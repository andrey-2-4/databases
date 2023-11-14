from sqlalchemy import Column, String, Integer
from base import Base

class Countries(Base):
    __tablename__ = 'countries'

    country_id = Column(String(40), primary_key=True)
    name = Column(String(3))
    area_sqkm = Column(Integer)
    population = Column(Integer)

    def __init__(self, country_id, name, area_sqkm, population, actors):
        self.country_id = country_id
        self.name = name
        self.area_sqkm = area_sqkm
        self.population = population
        self.actors = actors