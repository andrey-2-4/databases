from sqlalchemy_utils import database_exists, create_database

from base import Session, engine, Base

from countries import Countries
from events import Events
from olympics import Olympics
from players import Players
from results import Results

if not database_exists(engine.url):
    create_database(engine.url)

Base.metadata.create_all(engine)