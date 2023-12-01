-- task 1
select bit_length(name) + length(race) as calculation from demographics;

-- task 2
select id,
       bit_length(name) as name,
       birthday,
       bit_length(race)
from demographics;

-- task 3
select id,
       ascii(name) as name,
       birthday,
       ascii(race)
from demographics;

-- task 4
select concat_ws(' ', prefix, first, last, suffix) as title from names;

-- task 5
select rpad(md5, length(sha256), '1') as md5,
       lpad(sha1, length(sha256), '0') as sha1,
       sha256
from encryption;

-- task 6
select left(project, commits),
       right(address, contributors)
from repositories;

-- task 7
select project,
       commits,
       contributors,
       regexp_replace(address, '\d', '!', 'g') as address
from repositories;

-- task 8

select name, round(price / (weight::numeric / 1000), 2) as price_per_kg
from products
order by name desc, price_per_kg asc;