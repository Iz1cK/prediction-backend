const db = require("../database/index");

const getTeamById = (id) =>
  db
    .query(`SELECT * FROM teams WHERE teamid=$1`, [id])
    .then(({ rows }) => rows[0]);

const getTeamByCode = (code) =>
  db
    .query(`SELECT * FROM teams WHERE code=$1`, [code])
    .then(({ rows }) => rows[0]);

const getWCTeamById = (id) =>
  db
    .query(`SELECT * FROM worldcupteams WHERE teamid=$1`, [id])
    .then(({ rows }) => rows[0]);

const getWCTeamByCode = (code) =>
  db
    .query(`SELECT * FROM worldcupteams WHERE code=$1`, [code])
    .then(({ rows }) => rows[0]);

const getAllWCTeams = () =>
  db.query(`SELECT * FROM worldcupteams`).then(({ rows }) => rows);
module.exports = { getTeamById, getTeamByCode, getWCTeamById, getWCTeamByCode };
