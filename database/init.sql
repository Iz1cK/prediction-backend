BEGIN;

DROP TABLE IF EXISTS users,predictions,teams,leagues,matches,worldcupteams,worldcuppredictions,worldcupmatches CASCADE;

CREATE TABLE users (
    userid SERIAL PRIMARY KEY,
    username VARCHAR(255),
    password VARCHAR(255),
    email VARCHAR(255),
    active BOOLEAN DEFAULT 'true'
);

CREATE TABLE leagues(
    leagueid SERIAL PRIMARY KEY,
    slug VARCHAR(3),
    name VARCHAR(3)
);

CREATE TABLE teams(
    teamid SERIAL PRIMARY KEY,
    leagueid INTEGER REFERENCES leagues(leagueid),
    name VARCHAR(255),
    code VARCHAR(4),
    image VARCHAR(255),
    wins INTEGER,
    loses INTEGER
);

CREATE TABLE worldcupteams(
    teamid SERIAL PRIMARY KEY,
    name VARCHAR(255),
    code VARCHAR(4),
    image VARCHAR(255)
);

CREATE TABLE worldcupmatches(
    matchid SERIAL UNIQUE,
    team1id INTEGER REFERENCES worldcupteams(teamid),
    team2id INTEGER REFERENCES worldcupteams(teamid),
    winnerid INTEGER REFERENCES worldcupteams(teamid),
    date DATE DEFAULT CURRENT_DATE,
    format VARCHAR(30),
    PRIMARY KEY (team1id, team2id, date)
);

CREATE TABLE worldcuppredictions(
    predictionid SERIAL,
    userid INTEGER REFERENCES users(userid),
    matchid INTEGER REFERENCES worldcupmatches(matchid),
    prediction INTEGER REFERENCES worldcupteams(teamid),
    result BOOLEAN,
    PRIMARY KEY(userid, matchid)
);

CREATE TABLE matches(
    matchid VARCHAR(50) UNIQUE,
    team1id INTEGER REFERENCES teams(teamid),
    team2id INTEGER REFERENCES teams(teamid),
    winnerid INTEGER REFERENCES teams(teamid),
    date DATE DEFAULT CURRENT_DATE,
    leagueid INTEGER REFERENCES leagues(leagueid),
    format VARCHAR(30),
    PRIMARY KEY (team1id, team2id, date)
);

CREATE TABLE predictions(
    predictionid SERIAL,
    userid INTEGER REFERENCES users(userid),
    matchid VARCHAR(50) REFERENCES matches(matchid),
    prediction INTEGER REFERENCES teams(teamid),
    result BOOLEAN,
    PRIMARY KEY(userid, matchid)
);

INSERT INTO users (username,password,email,active) 
VALUES 
-- ('Kuala','$2y$10$GDBGnXjObP6inrMX2Mv7Ue6GFeC4KXv0YODMentLaT28TCoPoPRYK','durd2001@gmail.com','true'),
('Kuala','$2b$10$ErNLJE7wRRIExTPAhlQ.0.ZNJBy1VeHAIg93ae2ZD27qH6cRw51uy','durd2001@gmail.com','true'),
('Nur','$2a$10$.FBK6i3nvw11tB2hLtqKHO7TDPpdMPCfH.H4DzflQW9tJ/c.V7UZq','nur.awad795@gmail.com','true');

INSERT INTO leagues (name,slug) 
VALUES ('LEC','lec'),
('LCS','lcs');

INSERT INTO teams (leagueid,name,code,image,wins,loses)
VALUES 
(1,'G2 Esports','G2','http://static.lolesports.com/teams/G2-FullonDark.png',4,1),
(1,'Astralis','AST','http://static.lolesports.com/teams/AST-FullonDark.png',3,2),
(1,'Team BDS','BDS','http://static.lolesports.com/teams/1641292031788_Team_BDSlogo_square.png',1,4),
(1,'Misfits Gaming','MSF','http://static.lolesports.com/teams/1592591419157_MisfitsMSF-01-FullonDark.png',1,4),
(1,'Team Vitality','VIT','http://static.lolesports.com/teams/Vitality-logo-color-outline-rgb.png',3,2),
(1,'SK Gaming','SK','http://static.lolesports.com/teams/1643979272144_SK_Monochrome.png',3,2),
(1,'Rogue','RGE','http://static.lolesports.com/teams/1631819715136_rge-2021-worlds.png',3,2),
(1,'EXCEL','XL','http://static.lolesports.com/teams/Excel_FullColor2.png',3,2),
(1,'Fnatic','FNC','http://static.lolesports.com/teams/1631819669150_fnc-2021-worlds.png',3,2),
(1,'MAD Lions','MAD','http://static.lolesports.com/teams/1631819614211_mad-2021-worlds.png',3,2),
(2,'TSM','TSM','http://static.lolesports.com/teams/1592590917094_TSMTSM-01-FullonDark.png',2,3),
(2,'Evil Geniuses','EG','http://static.lolesports.com/teams/1592590374862_EvilGeniusesEG-01-FullonDark.png',4,1),
(2,'Fly Quest','FLY','http://static.lolesports.com/teams/flyquest-new-on-dark.png',2,3),
(2,'Dignitas','DIG','http://static.lolesports.com/teams/DIG-FullonDark.png',1,4),
(2,'100 Thieves','100','http://static.lolesports.com/teams/AST-FullonDark.png',3,2),
(2,'Team Liquid Honda','TL','http://static.lolesports.com/teams/1631820014208_tl-2021-worlds.png',4,1),
(2,'Golden Guardians','GG','http://static.lolesports.com/teams/1592590586919_GoldenGuardiansGGS-01-FullonDark.png',2,3),
(2,'Immortals','IMT','http://static.lolesports.com/teams/imt-new-color.png',1,4),
(2,'Cloud9','C9','http://static.lolesports.com/teams/1631820065346_cloud9-2021-worlds.png',2,3),
(2,'CLG','CLG','http://static.lolesports.com/teams/1592590248482_CounterLogicGamingCLG-01-FullonDark.png',4,1);

INSERT INTO matches (matchid,team1id,team2id,winnerid,leagueid,format)
VALUES ('1',1,2,1,1,'Best of 1');

INSERT INTO predictions (userid,matchid,prediction)
VALUES (1,'1',1);

INSERT INTO worldcupteams (name,code,image)
VALUES 
('Argentina','ARG','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/ARG?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Australia','AUS','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/AUS?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Belgium', 'BEL','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/BEL?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Brazil','BRA','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/BRA?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Cameroon','CMR','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/CMR?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Canada','CAN','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/CAN?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Costa Rica','CRC','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/CRC?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Croatia','CRO','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/CRO?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Denmark','DEN','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/DEN?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Ecuador','ECU','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/ECU?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('England','ENG','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/END?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('France','FRA','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/FRA?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Germany','GER','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/GER?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Ghana','GHA','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/GHA?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Iran','IRN','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/IRN?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Japan','JPN','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/JPN?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Korea Republic','KOR','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/KOR?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Mexico','MEX','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/MEX?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Morocco','MAR','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/MAR?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Netherlands','NED','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/NED?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Poland','POL','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/POL?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Portugal','POR','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/POR?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Qatar','QAT','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/QAT?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Saudi Arabia','KSA','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/KSA?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Senegal','SEN','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/SEN?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Serbia','SRB','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/SRB?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Spain','ESP','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/ESP?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Switzerland','SUI','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/SUI?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Tunis','TUN','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/TUN?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('United States','USA','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/USA?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Uruguay','URU','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/URU?tx=c_fill,g_auto,q_auto,w_94,h_62'),
('Wales','WAL','https://cloudinary.fifa.com/api/v3/picture/flags-sq-4/WAL?tx=c_fill,g_auto,q_auto,w_94,h_62');

COMMIT;