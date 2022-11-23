const db = require("../database/index");

const makeWCPrediction = (userid, matchid, prediction) => {
  return db
    .query(
      `INSERT INTO worldcuppredictions (userid,matchid,prediction) VALUES ($1,$2,$3) RETURNING predictionid`,
      [userid, matchid, prediction]
    )
    .then(({ rows }) => rows[0]);
};

const getWCPredictions = (userid) => {
  return db
    .query(`SELECT * FROM worldcuppredictions WHERE userid=$1`, [userid])
    .then(({ rows }) => rows);
};

const checkIfExists = (userid, matchid) => {
  return db
    .query(
      `SELECT predictionid FROM worldcuppredictions WHERE userid=$1 AND matchid=$2`,
      [userid, matchid]
    )
    .then(({ rows }) => rows[0]);
};

const updateWCPrediction = ({ predictionid }, prediction) => {
  return db
    .query(
      `UPDATE worldcuppredictions SET prediction=$1 WHERE predictionid=$2 RETURNING predictionid`,
      [prediction, predictionid]
    )
    .then(({ rows }) => rows[0]);
};

const removeWCPrediction = (userid, matchid) => {
  return db
    .query(
      `DELETE FROM worldcuppredictions WHERE userid=$1 AND matchid = $2 RETURNING predictionid`,
      [userid, matchid]
    )
    .then(({ rows }) => rows[0]);
};

module.exports = {
  makeWCPrediction,
  getWCPredictions,
  checkIfExists,
  updateWCPrediction,
  removeWCPrediction,
};
