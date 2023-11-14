from sqlalchemy import Column, Date, String, Integer, ForeignKey

from base import Base

class Olympics(Base):
    __tablename__ = 'olympics'

    olympic_id = Column(String(7), primary_key=True)
    country_id = Column(String(3), ForeignKey('countries.country_id'))
    city = Column(String(50))
    year = Column(Integer)
    startdate = Column(Date)
    enddate = Column(Date)

    def __init__(self, olympic_id, country_id, city, year, startdate, enddate):
        self.olympic_id = olympic_id
        self.country_id = country_id
        self.city = city
        self.year = year
        self.startdate = startdate
        self.enddate = enddate