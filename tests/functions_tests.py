import psycopg2
import pandas as pd
import unittest

# Pandas warns that psycopg2 connection object is not tested
import warnings
warnings.filterwarnings("ignore")

sql = dict()
cnt = 0

with open('../scripts/ddl.sql') as query:
    sql['ddl'] = query.read().strip()

with open('../scripts/inserts.sql') as query:
    sql['inserts'] = query.read().strip()

with open('../scripts/functions.sql') as query:
    sql['functions'] = query.read().strip()

with open('../scripts/functions_exec.sql') as query:
    scripts = query.read().split('\n')

    for script in scripts:
        print(script)
        sql[f'query{cnt}'] = script
        cnt += 1

conn = psycopg2.connect(dbname="postgres", host="localhost",
                        user="postgres", password="postgres", port="5432")
with conn.cursor() as cursor:
    cursor.execute(sql['ddl'])
    cursor.execute(sql['inserts'])
    cursor.execute(sql['functions'])


class TestFunctions(unittest.TestCase):
    def pre_check_program_info(self, df):
        self.assertEqual(list(df.columns),
                         ['course_id_', 'course_nm_',
                          'direction_', 'duration_',
                          'direct_duration_', 'rel_duration_'])
        total = df.sum(numeric_only=True, axis=0)['duration_']
        self.assertEqual(list(df['rel_duration_']),
                        list(df['duration_'] / total))

    def testProgramInfo(self):
        shape = [4, 4, 4]
        for i in range(0, 3):
            df = pd.read_sql(sql[f'query{i}'], con=conn)
            self.pre_check_program_info(df)
            self.assertEqual(df.shape[0], shape[i])

    def testActualContracts(self):
        for i in range(4, 6):
            df = pd.read_sql(sql[f'query{i}'], con=conn)
            self.assertEqual(list(df.columns), ['get_actual_contracts'])
            self.assertEqual(df.shape[0], 1)
            if i == 4:
                self.assertEqual(df.iloc[0]['get_actual_contracts'], 3)
            if i == 5:
                self.assertEqual(df.iloc[0]['get_actual_contracts'], 7)
            if i == 6:
                self.assertEqual(df.iloc[0]['get_actual_contracts'], 9)

    def testNotExisting(self):
        df = pd.read_sql(sql[f'query{3}'], con=conn)
        self.assertEqual(list(df.columns),
                         ['course_id_', 'course_nm_',
                          'direction_', 'duration_',
                          'direct_duration_', 'rel_duration_'])
        self.assertEqual(df.shape[0], 0)
        df = pd.read_sql(sql[f'query{7}'], con=conn)
        self.assertEqual(list(df.columns), ['get_actual_contracts'])
        self.assertEqual(df.shape[0], 0)


unittest.main()
conn.close()
