BEGIN;

DROP TABLE IF EXISTS users,predictions CASCADE;

CREATE TABLE users (
    userid SERIAL PRIMARY KEY,
    username VARCHAR(255),
    password VARCHAR(255),
    email VARCHAR(255),
    active BOOLEAN DEFAULT 'true'
);

CREATE TABLE predictions(
    predictionid SERIAL PRIMARY KEY,
    userid INTEGER REFERENCES users(userid),
    prediction json
);

INSERT INTO users (userid,username,password,email,active) 
VALUES (1,'Kuala','$2y$10$GDBGnXjObP6inrMX2Mv7Ue6GFeC4KXv0YODMentLaT28TCoPoPRYK','durd2001@gmail.com','true'),
(2,'Nur','$2a$10$.FBK6i3nvw11tB2hLtqKHO7TDPpdMPCfH.H4DzflQW9tJ/c.V7UZq','nur.awad795@gmail.com','true');

COMMIT;