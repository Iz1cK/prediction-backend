const db = require("../database/index");

const getAllUsers = () => {
  return db.query(`SELECT * FROM users`, []).then(({ rows }) => rows);
};

const getUserByUsername = (username) => {
  return db
    .query(`SELECT * FROM users WHERE username=$1`, [username])
    .then(({ rows }) => rows[0]);
};

const createNewUser = (username, password, email) => {
  return db
    .query(
      `INSERT INTO users (username,password,email) VALUES ($1,$2,$3) RETURNING userid`,
      [username, password, email]
    )
    .then(({ rows }) => rows[0]);
};

module.exports = {
  getAllUsers,
  getUserByUsername,
  createNewUser,
};
