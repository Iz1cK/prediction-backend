const db = require("../database/index");

const getLeagueById = (id) =>
  db
    .query(`SELECT * FROM leagues WHERE leagueid = $1`, [id])
    .then(({ rows }) => rows[0]);

const getLeagueByName = (name) =>
  db
    .query(`SELECT * FROM leagues WHERE name = $1`, [name])
    .then(({ rows }) => rows[0]);

module.exports = { getLeagueById, getLeagueByName };
