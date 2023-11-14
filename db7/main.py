from sqlalchemy_utils import database_exists, create_database

from faker import Faker
from faker_sqlalchemy import SqlAlchemyProvider

from base import Session, engine, Base

# классы таблиц
from countries import Countries
from events import Events
from olympics import Olympics
from players import Players
from results import Results

# создаю бд
if not database_exists(engine.url):
    create_database(engine.url)
# создаю таблицы
Base.metadata.create_all(engine)
# создаю сессию
session = Session()

# не получилось сделать нормальный фейкер, поэто просто использую Ваши insert'ы
with open("sql.txt") as file:
    lines = file.read().split('\n')
    for line in lines:
        if line != '':
            session.execute(line)

# commit and close session
session.commit()
session.close()

