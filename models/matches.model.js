const db = require("../database/index");

const getAllMatches = () =>
  db.query(`SELECT * FROM matches`).then(({ rows }) => rows);

const insertNewMatch = (
  matchid,
  team1id,
  team2id,
  winnderid,
  date,
  leagueid,
  format
) =>
  db
    .query(
      `
        INSERT INTO matches (matchid,team1id,team2id,winnerid,date,leagueid,format) 
        VALUES ($1,$2,$3,$4,$5,$6,$7)
        ON CONFLICT (team1id,team2id,date) DO UPDATE
        SET matchid = $1, winnerid = $4, leagueid = $6, format = $7
        RETURNING matchid`,
      [matchid, team1id, team2id, winnderid, date, leagueid, format]
    )
    .then(({ rows }) => rows[0]);
module.exports = { getAllMatches, insertNewMatch };
