from sqlalchemy import func, desc

from base import Session, engine, Base

# классы таблиц
from countries import Countries
from events import Events
from olympics import Olympics
from players import Players
from results import Results

session = Session()

'''1'''
# олимпиада 2004
olympics2004 = session.query(Olympics).filter(Olympics.year == 2004).all()[0]
# список событий относящийся к этой олимпиаде
events2004 = session.query(Events.event_id).filter(Events.olympic_id == olympics2004.olympic_id)
# тэги людей, полуивших золото в 2004
results = session.query(Results.player_id).distinct(Results.player_id) \
    .filter((Results.event_id.in_(events2004)) & (Results.medal == "GOLD"))
# join им игроков и результаты и группировка по годам
years_players = session.query(func.extract('year', Players.birthdate).label('year'), func.count().label('count')) \
    .join(results.subquery()) \
    .group_by(func.extract('year', Players.birthdate))
# 'год рождения', 'кол-во людей, полчивших золото'

# тэги людей, полуивших золото в 2004 с повторениями
results = session.query(Results.player_id) \
    .filter((Results.event_id.in_(events2004)) & (Results.medal == "GOLD"))
# join им игроков и результаты и группировка по годам
years_medals = session.query(func.extract('year', Players.birthdate).label('year'), func.count().label('count')) \
    .join(results.subquery()) \
    .group_by(func.extract('year', Players.birthdate))

# 'год рождения', 'кол-во золота'

yma = years_medals.all()
ypa = years_players.all()
for i in range (len(yma)):
    print(yma[i].year, ypa[i].count, yma[i].count)

'''2'''
res = session.query(Results.event_id, func.count().label('count')).join(Events) \
    .filter(Events.is_team_event == 0) \
    .filter(Results.medal == "GOLD") \
    .group_by(Results.event_id).having(func.count() > 1)
for e in res:
    print(e.event_id, e.count)

'''3'''
res = session.query(Results.player_id).join(Players).distinct()
for e in res:
    print(e.player_id)

'''5'''
olympics2000 = session.query(Olympics).filter(Olympics.year == 2000).all()[0]
events2000 = session.query(Events.event_id).filter(Events.olympic_id == olympics2000.olympic_id)
res = session.query(Countries.name, Players.country_id, (Countries.population / func.count(Players.country_id)).label('ratio')) \
    .join(Results) \
    .join(Events) \
    .join(Countries) \
    .filter(Results.event_id.in_(events2000)) \
    .filter(Events.is_team_event == 1) \
    .group_by(Players.country_id, Countries.population, Countries.name) \
    .order_by(desc('ratio')).limit(5)
for e in res:
    print(e.name)
session.close()