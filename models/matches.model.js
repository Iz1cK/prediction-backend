const db = require("../database/index");

const getAllMatches = () =>
  db.query(`SELECT * FROM matches`).then(({ rows }) => rows);

const insertNewMatch = (team1id, team2id, winnderid, date, leagueid, format) =>
  db
    .query(
      `INSER INTO matches (team1id,team2id,winnerid,date,leagueid,format) 
     VALUES ($1,$2,$3,$4,$5,$6) RETURNING matchid`
    )
    .then(({ rows }) => rows[0]);

module.exports = { getAllMatches };
