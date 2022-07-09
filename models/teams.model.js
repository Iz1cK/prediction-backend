const db = require("../database/index");

const getTeamById = (id) =>
  db
    .query(`SELECT * FROM teams WHERE teamid=$1`, [id])
    .then(({ rows }) => rows[0]);

const getTeamByCode = (code) =>
  db
    .query(`SELECT * FROM teams WHERE code=$1`, [code])
    .then(({ rows }) => rows[0]);

module.exports = { getTeamById, getTeamByCode };
