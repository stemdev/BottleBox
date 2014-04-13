import pymysql
import hashlib

conn = pymysql.connect(host='127.0.0.1', port=3306, user='root', passwd='foo', db='compassApp') 
c=conn.cursor()

def get_hash(string):
    return hashlib.sha512(str.encode(string)).hexdigest()

def new(reg):
    c.execute(
        '''
        INSERT INTO `user` (email, username, pass_hash128)
        VALUES (%s,%s,%s)
        ''',
        (
            reg['email'],
            reg['username'],
            get_hash(reg['password'])
        )
    )
    conn.commit()


