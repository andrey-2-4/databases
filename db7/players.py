from sqlalchemy import Column, Date, String, Integer, ForeignKey

from base import Base

class Players(Base):
    __tablename__ = 'players'

    player_id = Column(String(10), primary_key=True)
    name = Column(String(40))
    country_id  = Column(String(3), ForeignKey('countries.country_id'))
    birthdate = Column(Date)

    def __init__(self, player_id, name, country_id, birthdate):
        self.player_id = player_id
        self.name = name
        self.country_id = country_id
        self.birthdate = birthdate