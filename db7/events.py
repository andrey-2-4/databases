from sqlalchemy import Column, String, Integer, ForeignKey, CheckConstraint

from base import Base

class Events(Base):
    __tablename__ = 'events'
    __table_args__ = (CheckConstraint('is_team_event IN (0, 1)'), )

    event_id = Column(String(7), primary_key=True)
    name = Column(String(40))
    eventtype = Column(String(20))
    olympic_id = Column(String(7), ForeignKey('olympics.olympic_id'))
    is_team_event = Column(Integer)
    num_players_in_team = Column(Integer)
    result_noted_in = Column(String(100))

    def __init__(self, event_id, name, eventtype, olympic_id, is_team_event, num_players_in_team, result_noted_in):
        self.event_id = event_id
        self.name = name
        self.eventtype = eventtype
        self.olympic_id = olympic_id
        self.is_team_event = is_team_event
        self.num_players_in_team = num_players_in_team
        self.result_noted_in = result_noted_in