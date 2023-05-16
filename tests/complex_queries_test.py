#! /usr/bin/env python3
import psycopg2
import pandas as pd
import unittest

import warnings
warnings.filterwarnings(action='once')

sql = dict()

with open('../scripts/ddl.sql') as query:
    sql['ddl'] = query.read().strip()

with open('../scripts/inserts.sql') as query:
    sql['inserts'] = query.read().strip()

for query_num in range(1, 7):
    with open(f'../scripts/complex/cq{query_num}.sql') as query:
        sql[f'cq{query_num}'] = query.read().strip()

conn = psycopg2.connect(dbname="postgres", host="localhost",
                        user="postgres", password="postgres", port="5432")

with conn.cursor() as cursor:
    cursor.execute(sql['ddl'])
    cursor.execute(sql['inserts'])


class TestComplexQueries(unittest.TestCase):
    def test_cq1(self):
        df = pd.read_sql(sql[f'cq{1}'], con=conn)
        self.assertEqual(list(df.columns), ['contract_id', 'pay_num', 'payer_ref_sum'])
        self.assertTrue(df.shape[0] == 2)
        self.assertEqual(list(df['contract_id']), [5, 0])

    def test_cq2(self):
        df = pd.read_sql(sql[f'cq{2}'], con=conn)
        self.assertEqual(list(df.columns),
                         ['contract_id', 'sum', 'avg_sum', 'relative_sum'])
        # test for ORDER BY
        self.assertEqual(list(sorted(list(df['contract_id']))),
                         list(df['contract_id']))
        df['check_avg'] = df.groupby(['contract_id'])['sum'].transform('mean')
        self.assertEqual(list(df['check_avg']), list(df['avg_sum']))

    def test_cq3(self):
        df = pd.read_sql(sql[f'cq{3}'], con=conn)
        self.assertEqual(list(df.columns),
                         ['program_id', 'course_id', 'duration', 'prog_duration', 'rel_duration'])
        self.assertEqual(df.shape[0], 15)
        df['check_prog_duration'] = df.groupby(['program_id'])['duration'].transform('sum')
        self.assertEqual(list(df['prog_duration']), list(df['check_prog_duration']))
        df['check_rel_duration'] = df['duration'] / df['prog_duration']
        self.assertEqual(list(df['rel_duration']), list(df['check_rel_duration']))
        self.assertEqual(list(sorted(list(df['program_id']))),
                         list(df['program_id']))

    def test_cq4(self):
        df = pd.read_sql(sql[f'cq{4}'], con=conn)
        self.assertEqual(list(df.columns),
                         ['firstname', 'secondname', 'surname', \
                          'name', 'specialization', 'num_job'])
        # for each name check if number of jobs is correct
        for name in list(df['firstname']):
            tmp_df = df[df['firstname'] == name]
            if name == 'Ксения':
                self.assertEqual(tmp_df.shape[0], 4)
            if name == 'Алла':
                self.assertEqual(tmp_df.shape[0], 2)
            if name in ['Иван', 'Дмитрий', 'Инна', 'Ирина']:
                self.assertEqual(tmp_df.shape[0], 1)
            self.assertEqual(list(tmp_df['num_job']),
                             list(range(1, 1 + tmp_df.shape[0])))

    def test_cq5(self):
        df = pd.read_sql(sql[f'cq{5}'], con=conn)
        self.assertEqual(list(df.columns),
                         ['person_id', 'company_id', 'starttime', \
                         'next_workplace', 'next_worktime'])
        for person_id in set(df['person_id']):
            tmp_df = df[df['person_id'] == person_id].copy()
            tmp_df.sort_values(inplace=True, by=['starttime'])
            # check LEAD performance
            for i in range(tmp_df.shape[0] - 1):
                self.assertEqual(tmp_df.iloc[i]['next_worktime'],
                                 tmp_df.iloc[i+1]['starttime'])
                self.assertEqual(tmp_df.iloc[i]['next_workplace'],
                                 tmp_df.iloc[i + 1]['company_id'])

    def test_cq6(self):
        df = pd.read_sql(sql[f'cq{6}'], con=conn)
        self.assertEqual(list(df.columns), ['person_id', 'contracts_cnt'])
        self.assertEqual(list(df['person_id']), [0, 1, 7, 8])
        self.assertEqual(list(df['contracts_cnt']), [1, 2, 2, 2])


unittest.main()
conn.close()
