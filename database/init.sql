BEGIN;

DROP TABLE IF EXISTS users,predictions,teams,leagues,matches CASCADE;

CREATE TABLE users (
    userid SERIAL PRIMARY KEY,
    username VARCHAR(255),
    password VARCHAR(255),
    email VARCHAR(255),
    active BOOLEAN DEFAULT 'true'
);

CREATE TABLE leagues(
    leagueid SERIAL PRIMARY KEY,
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

CREATE TABLE matches(
    matchid SERIAL PRIMARY KEY,
    team1id INTEGER REFERENCES teams(teamid),
    team2id INTEGER REFERENCES teams(teamid),
    winnerid INTEGER REFERENCES teams(teamid),
    date DATE DEFAULT CURRENT_DATE,
    leagueid INTEGER REFERENCES leagues(leagueid),
    format VARCHAR(30)
);

CREATE TABLE predictions(
    predictionid SERIAL PRIMARY KEY,
    userid INTEGER REFERENCES users(userid),
    matchid INTEGER REFERENCES matches(matchid),
    prediction INTEGER REFERENCES teams(teamid),
    result BOOLEAN
);

INSERT INTO users (username,password,email,active) 
VALUES 
-- ('Kuala','$2y$10$GDBGnXjObP6inrMX2Mv7Ue6GFeC4KXv0YODMentLaT28TCoPoPRYK','durd2001@gmail.com','true'),
('Kuala','$2b$10$ErNLJE7wRRIExTPAhlQ.0.ZNJBy1VeHAIg93ae2ZD27qH6cRw51uy','durd2001@gmail.com','true'),
('Nur','$2a$10$.FBK6i3nvw11tB2hLtqKHO7TDPpdMPCfH.H4DzflQW9tJ/c.V7UZq','nur.awad795@gmail.com','true');

INSERT INTO leagues (name) 
VALUES ('LEC'),
('LCS');

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

INSERT INTO matches (team1id,team2id,winnerid,leagueid,format)
VALUES (1,2,1,1,'Best of 1');

INSERT INTO predictions (userid,matchid,prediction)
VALUES (1,1,1);

COMMIT;