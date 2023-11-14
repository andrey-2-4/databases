from sqlalchemy import Column, String, Integer, ForeignKey, Float

from base import Base

class Results(Base):
    __tablename__ = 'results'

    event_id = Column(String(7), ForeignKey('events.event_id'), primary_key=True)
    player_id = Column(String(10), ForeignKey('players.player_id'), primary_key=True)
    medal = Column(String(7))
    result = Column(Float)

    def __init__(self, event_id, name, eventtype, olympic_id, is_team_event, num_players_in_team, result_noted_in):
        self.event_id = event_id
        self.name = name
        self.eventtype = eventtype
        self.olympic_id = olympic_id
        self.is_team_event = is_team_event
        self.num_players_in_team = num_players_in_team
        self.result_noted_in = result_noted_in