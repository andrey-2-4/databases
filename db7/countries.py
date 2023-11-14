from sqlalchemy import Column, String, Integer
from base import Base

class Countries(Base):
    __tablename__ = 'countries'

    name = Column(String(40))
    country_id = Column(String(3), primary_key=True)
    area_sqkm = Column(Integer)
    population = Column(Integer)

    def __init__(self, name, country_id, area_sqkm, population):
        self.country_id = country_id
        self.name = name
        self.area_sqkm = area_sqkm
        self.population = population