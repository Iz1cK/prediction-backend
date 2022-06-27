BEGIN;

DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
    userid SERIAL PRIMARY KEY,
    username VARCHAR(255),
    password VARCHAR(255),
    email VARCHAR(255),
    active BOOLEAN
);

CREATE TABLE predictions(
    predictionid SERIAL PRIMARY KEY,
    userid INTEGER REFERENCES users(userid),
    prediction json
)

COMMIT;