const db = require("../database/index");

const makePrediction = (userid, matchid, prediction) => {
  return db
    .query(
      `INSERT INTO predictions (userid,matchid,prediction) VALUES ($1,$2,$3) RETURNING predictionid`,
      [userid, matchid, prediction]
    )
    .then(({ rows }) => rows[0]);
};

const getPredictions = (userid) => {
  return db
    .query(`SELECT * FROM predictions WHERE userid=$1`, [userid])
    .then(({ rows }) => rows);
};

const checkIfExists = (userid, matchid) => {
  return db
    .query(
      `SELECT predictionid FROM predictions WHERE userid=$1 AND matchid=$2`,
      [userid, matchid]
    )
    .then(({ rows }) => rows[0]);
};

const updatePrediction = ({ predictionid }, prediction) => {
  return db
    .query(
      `UPDATE predictions SET prediction=$1 WHERE predictionid=$2 RETURNING predictionid`,
      [prediction, predictionid]
    )
    .then(({ rows }) => rows[0]);
};

const removePrediction = (userid, matchid) => {
  return db
    .query(
      `DELETE FROM predictions WHERE userid=$1 AND matchid = $2 RETURNING predictionid`,
      [userid, matchid]
    )
    .then(({ rows }) => rows[0]);
};

module.exports = {
  makePrediction,
  getPredictions,
  checkIfExists,
  updatePrediction,
  removePrediction,
};
