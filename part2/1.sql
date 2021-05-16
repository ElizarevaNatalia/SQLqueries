import sqlite3
with sqlite3.connect('Musicdb') as conn: 
    cur = conn.cursor()
    cur.row_factory = lambda cursor, row: {col[0]: row[idx] for idx, col in enumerate(cursor.description)} 
    print(cur.fetchall())

#create table Band
from sqlite3 import Error
def sql_connection():
    try:
        con = sqlite3.connect('Music.db')
        return con
    except Error:
        print(Error)
con = sql_connection()
cursorObj = con.cursor()
cursorObj.execute("CREATE TABLE IF NOT EXISTS Band(band_id text PRIMARY KEY, name text, genre text)")
con.commit()

#create table Album
cursorObj.execute("CREATE TABLE IF NOT EXISTS Album(\
                  album_id text PRIMARY KEY,\
                   band_id text, name text, date_released date,\
                   FOREIGN KEY (band_id)\
                   REFERENCES Band(band_id)\
                   ON DELETE CASCADE\
                   ON UPDATE NO ACTION)")
con.commit()

#create table Song
cursorObj.execute("CREATE TABLE Song(\
                  album_id text, song_id text PRIMARY KEY, name text, duration integer, lyrics_author text, music_author text,\
                  FOREIGN KEY (album_id)\
                     REFERENCES Album(album_id)\
                     ON DELETE CASCADE\
                     ON UPDATE NO ACTION,\
                  FOREIGN KEY (lyrics_author)\
                     REFERENCES Musician(musician_id)\
                     ON DELETE RESTRICT\
                     ON UPDATE NO ACTION,\
                  FOREIGN KEY (music_author)\
                     REFERENCES Musician(musician_id)\
                     ON DELETE RESTRICT\
                     ON UPDATE NO ACTION)")
con.commit()

#create table Musician
cursorObj.execute("CREATE TABLE Musician(\
                   musician_id text PRIMARY KEY, name text)")
con.commit()

#create table Musician_band table
cursorObj.execute("CREATE TABLE Musician_band(\
                   musician_id text, band_id text, started_at date, finished_at date, instrument text,\
                   FOREIGN KEY (musician_id)\
                      REFERENCES Musician(musician_id)\
                      ON DELETE RESTRICT\
                      ON UPDATE NO ACTION,\
                   FOREIGN KEY (band_id)\
                      REFERENCES Band(band_id)\
                      ON DELETE CASCADE\
                      ON UPDATE NO ACTION)")
con.commit()

#fill tables with data
cursorObj.execute("INSERT INTO Band VALUES('1', 'Rammstein', 'industrial metal')")
cursorObj.execute("INSERT INTO Band VALUES('2', 'Linkin park', 'alternative')")
cursorObj.execute("INSERT INTO Album VALUES('1', '1', 'Rammstein', '2019-05-17')")
cursorObj.execute("INSERT INTO Album VALUES('2', '1', 'Liebe ist für alle da', '2009-10-16')")
cursorObj.execute("INSERT INTO Song VALUES('1', '1', 'Deutschland', '5:23', '1', '2')")
cursorObj.execute("INSERT INTO Song VALUES('1', '2', 'Radio', '4:37', '1', '2')")
cursorObj.execute("INSERT INTO Musician VALUES('1', 'Richard Kruspe')")
cursorObj.execute("INSERT INTO Musician VALUES('2', 'Till Lindemann')")
cursorObj.execute("INSERT INTO Musician_band VALUES('1', '1', '1994-01-31', '', 'Solo guitar')")
cursorObj.execute("INSERT INTO Musician_band VALUES('2', '1', '1994-01-31', '', 'Vocal')")
con.commit()

