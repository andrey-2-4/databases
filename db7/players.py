from sqlalchemy import Column, Date, String, Integer, ForeignKey

from base import Base

class Players(Base):
    __tablename__ = 'players'

    name = Column(String(40))
    player_id = Column(String(10), primary_key=True)
    country_id  = Column(String(3), ForeignKey('countries.country_id'))
    birthdate = Column(Date)

    def __init__(self, name, player_id, country_id, birthdate):
        self.player_id = player_id
        self.name = name
        self.country_id = country_id
        self.birthdate = birthdate