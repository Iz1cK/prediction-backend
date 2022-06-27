const httpStatus = require("http-status");
const usersModel = require("./controllers/users.controller");
const router = require("express").Router();

router.get("/hello", (req, res) => {
  res.status(httpStatus.OK).send({ "Hello World": "Hello World" });
});

router.post("/login", usersModel.login);
router.get("/users", usersModel.getUsers);
router.post("/register", usersModel.register);

module.exports = router;
