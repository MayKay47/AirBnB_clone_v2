# AirBnB_clones - version_2 :hotel:
This repository is part of a bigger project - AirBnB clone. This version will be implementing the database- MySQL.

## Objectives :bulb:
**Unit testing** is a software testing method that involves testing individual units or components of a software system in isolation to ensure they are working as expected. In a large project, unit testing can help to identify bugs and issues early in the development process and provide confidence in the system's reliability. **To implement unit testing in Python**, a testing framework like Pytest or Unittest can be used. Here's an example of a simple unit test using Pytest:
```
# test_calculation.py
def test_addition():
    assert 2+2 == 4
    
def test_subtraction():
    assert 4-2 == 2
```

In Python, **`*args`** is a special syntax that allows a function to accept an arbitrary number of positional arguments. Here's an example of a function that uses `*args`:
```
def my_function(*args):
    for arg in args:
        print(arg)

my_function(1, 2, 3)
```

Similarly, **`**kwargs`** is a special syntax that allows a function to accept an arbitrary number of keyword arguments. Here's an example:
```
def my_function(**kwargs):
    for key, value in kwargs.items():
        print(f"{key}: {value}")

my_function(name="John", age=30)
```

**Named arguments in Python functions can be handled** using the `**kwargs` syntax described above. Alternatively, named arguments can be explicitly defined in the function definition:
```
def my_function(name, age):
    print(f"{name} is {age} years old")

my_function(name="John", age=30)
```

**A MySQL database can be created** using the `mysql.connector` module in Python:
```
import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="yourusername",
  password="yourpassword"
)

mycursor = mydb.cursor()

mycursor.execute("CREATE DATABASE mydatabase")
```

Similarly, **a MySQL user can be created and granted its privileges** using the mysql.connector module:
```
import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="yourusername",
  password="yourpassword",
  database="mydatabase"
)

mycursor = mydb.cursor()

mycursor.execute("CREATE USER 'myuser'@'localhost' IDENTIFIED BY 'mypassword'")
mycursor.execute("GRANT ALL PRIVILEGES ON * . * TO 'myuser'@'localhost'")
```
**ORM** stands for Object-Relational Mapping. It is a programming technique that allows a developer to map objects in an object-oriented programming language to tables in a relational database management system.

ORM like SQLAlchemy, can be used **to map a Python class to a MySQL table**, a class is defined that inherits from a base class provided by the ORM:
```
from sqlalchemy import Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class User(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True)
    name = Column(String)
    age = Column(Integer)
```
**To handle two different storage engines with the same codebase in Python**. An abstraction layer that provides a consistent interface to both storage engines can be used. This can be achieved using an ORM (Object-Relational Mapping) library such as SQLAlchemy, which provides a high-level abstraction layer that works with multiple databases.
Here is an example using SQLAlchemy to handle two different databases:
```
import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

# get database URLs from environment variables
db_url1 = os.environ.get('DATABASE_URL_1')
db_url2 = os.environ.get('DATABASE_URL_2')

# create database engine for each storage engine
engine1 = create_engine(db_url1)
engine2 = create_engine(db_url2)

# create session factories for each engine
Session1 = sessionmaker(bind=engine1)
Session2 = sessionmaker(bind=engine2)

# example code that works with both storage engines using ORM
session1 = Session1()
session2 = Session2()

# query all users from the first database
users1 = session1.query(User).all()

# query all users from the second database
users2 = session2.query(User).all()

# insert a new user into the first database
new_user1 = User(name='John', email='john@example.com')
session1.add(new_user1)
session1.commit()

# insert a new user into the second database
new_user2 = User(name='Jane', email='jane@example.com')
session2.add(new_user2)
session2.commit()
```
Another example using Python:
```
class StorageInterface:
    def read(self, key):
        raise NotImplementedError

    def write(self, key, value):
        raise NotImplementedError


class SqlStorage(StorageInterface):
    def read(self, key):
        # SQL implementation
        pass

    def write(self, key, value):
        # SQL implementation
        pass


class NoSqlStorage(StorageInterface):
    def read(self, key):
        # NoSQL implementation
        pass

    def write(self, key, value):
        # NoSQL implementation
        pass


def main():
    storage = None
    storage_engine = os.environ.get('STORAGE_ENGINE')

    if storage_engine == 'sql':
        storage = SqlStorage()
    elif storage_engine == 'nosql':
        storage = NoSqlStorage()
    else:
        raise ValueError('Unknown storage engine')

    # Use the storage object
    storage.write('my_key', 'my_value')
    value = storage.read('my_key')
    print(value)
```
This example, an abstract `StorageInterface` class is defined that defines the read and write methods that must be implemented by the concrete storage classes (`SqlStorage` and `NoSqlStorage`). Then, in the `main` function, the `STORAGE_ENGINE` environment variable is checked to determine which storage engine to use. Depending on the value of the environment variable, an instance of the appropriate storage class is created and used to read and write data. By using an abstraction layer, there can be switching between storage engines without changing the application logic.

Environment variables are dynamic values that can be set and retrieved by the operating system or a running application. They can be used to store and retrieve configuration settings such as database URLs, API keys, or other sensitive information by the Python application. They can be set on your local machine or on a server, and are accessed through the `os` module in Python. Here's an example of **how to use environment variables** in Python:
```
import os

# Set environment variable
os.environ['MY_VAR'] = 'my_value'

# Get environment variable
my_var = os.environ.get('MY_VAR')
print(my_var)
```
This example, sets the environment variable `MY_VAR` to the value `my_value`, and then retrieves it using `os.environ.get()`. The output of this script will be `my_value`.

```
import os

# get database URL from environment variable
db_url = os.environ.get('DATABASE_URL')

# connect to database using URL
db = connect(db_url)

# use database for queries and updates
...
```
