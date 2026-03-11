import configparser
from sqlalchemy import create_engine

config = configparser.ConfigParser()
config.read(".\config\config.ini")

db = config["database"]

user = db["user"]
password = db["password"]
host = db["host"]
port = db["port"]
database = db["database"]

connection_string = f"postgresql://{user}:{password}@{host}:{port}/{database}"

engine = create_engine(connection_string)