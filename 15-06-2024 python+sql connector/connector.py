#First install the connector: Go to command prompt --> type: pip install mysql.connector.python

#import the connector
import mysql.connector as mc

#connect to database
OYO_DB= mc.Connect(host="localhost", user="SCHOLAR", password ="Mysqlaccount1!", database="OYO" )


my_cursor=OYO_DB.cursor()
OYO_DB.commit()

#For every sql statement to be executed--> use my_cursor.execute("....query goes here...")
my_cursor.execute("show databases")

#print output using python
for i in my_cursor:
    print(i)
