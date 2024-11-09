show databases;
use mysql;
show tables;

drop table if exists songs;

create table songs (
song_id int not null auto_increment,
song_name varchar(30) not null, 
released_year year not null,
hit_or_flop varchar(30),
artist_name varchar(30),
artist_id int not null,
primary key (song_id)
);

drop table if exists artists;
create table artists (
artist_id  int not null, 
song_id int , 
artist_name varchar(30),
primary key (artist_id),
foreign key (song_id) references songs (song_id),
country_name varchar (30)
);


insert into songs (song_name, released_year, hit_or_flop, artist_name, artist_id) values
('Shape of You', 2017, 'Hit', 'Ed Sheeran', 1),
('Blinding Lights', 2020, 'Flop', 'The Weeknd', 2),
('Bad Guy', 2019, 'Hit', 'Billie Eilish', 3),
('Someone Like You', 2011, 'Hit', 'Adele', 4),
('Rolling in the Deep', 2010, 'Flop', 'Adele', 4),
('Circles', 2019, 'Hit', 'Post Malone', 5),
('Despacito', 2017, 'Hit', 'Luis Fonsi', 6),
('One Dance', 2016, 'Flop', 'Drake', 7),
('Senorita', 2019, 'Hit', 'Shawn Mendes', 8),
('Rockstar', 2017, 'Flop', 'Post Malone', 5),
('Uptown Funk', 2015, 'Hit', 'Mark Ronson', 9),
('Thinking Out Loud', 2014, 'Hit', 'Ed Sheeran', 1),
('Old Town Road', 2019, 'Flop', 'Lil Nas X', 10),
('Havana', 2018, 'Hit', 'Camila Cabello', 11),
('Happy', 2013, 'Flop', 'Pharrell Williams', 12),
('Shallow', 2018, 'Hit', 'Lady Gaga', 13),
('Roar', 2013, 'Flop', 'Katy Perry', 14),
('Closer', 2016, 'Hit', 'The Chainsmokers', 15),
('Cheap Thrills', 2016, 'Flop', 'Sia', 16),
('Believer', 2017, 'Hit', 'Imagine Dragons', 17);


INSERT INTO artists (artist_id, song_id, artist_name, country_name) VALUES
(1, 1, 'Ed Sheeran', 'United Kingdom'),
(2, 3, 'The Weeknd', 'Canada'),
(3, 4, 'Billie Eilish', 'United States'),
(4, 5, 'Adele', 'United Kingdom'),
(5, 7, 'Post Malone', 'United States'),
(6, 8, 'Luis Fonsi', 'Puerto Rico'),
(7, 9, 'Drake', 'Canada'),
(8, 11, 'Shawn Mendes', 'Canada'),
(9, 12, 'Mark Ronson', 'United Kingdom'),
(10, 13, 'Lil Nas X', 'United States'),
(11, 14, 'Camila Cabello', 'Cuba'),
(12, 15, 'Pharrell Williams', 'United States'),
(13, 16, 'Lady Gaga', 'United States'),
(14, 17, 'Katy Perry', 'United States'),
(15, 18, 'The Chainsmokers', 'United States'),
(16, 19, 'Sia', 'Australia'),
(17, 20, 'Imagine Dragons', 'United States'),
(18, 2, 'Arijit Singh', 'India'),
(19, NULL, 'Shreya Ghoshal', 'India'),
(20, NULL, 'Neha Kakkar', 'India');

select * from songs;

select * from artists;

-- How many artist are from United Kingdom? 

select count(artist_name) 
from artists 
group by country_name 
having country_name ='United Kingdom';

-- verify
select country_name, count(artist_name) 
from artists 
group by country_name;

 -- Renaming columns 
alter table artists rename column artist_name to artist;
alter table artists rename column country_name to country;

-- all songs that were released before 2017
select song_name from songs 
where released_year < 2017;

-- year wise distribution of songs
select * from songs where released_year = 2017;

SET SESSION sql_mode = REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', '');

select `released_year`, count(song_name)  
from songs 
group by `released_year`;

-- can verify like this 
select * from songs where released_year = 2017;

-- also we can see, in which year the max songs were released from the above query
select `released_year`, count(song_name) as no_songs_released 
from songs 
group by `released_year` 
order by no_songs_released desc;

-- artist id  and artist name whose released year was 2010

select s.released_year , a.artist_id , a.artist
from songs s 
join artists a 
on s.artist_id = a.artist_id
where s.released_year = 2010;

-- max songs were released from which country's artist

select a.artist, a.country, count(s.song_name)
from artists a 
join songs s
on s.song_id = a.song_id
group by 2
order by count(s.song_name) desc
limit 1;

