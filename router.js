const httpStatus = require("http-status");
const usersController = require("./controllers/users.controller");
const matchesController = require("./controllers/matches.controller");
const checkAuth = require("./middlewares/checkAuth");
const router = require("express").Router();

router.get("/hello", (req, res) => {
  res.status(httpStatus.OK).send({ "Hello World": "Hello World" });
});

router.post("/login", usersController.login);
router.get("/users", usersController.getUsers);
router.post("/register", usersController.register);
router.get("/me", checkAuth, (req, res) => {
  res.status(httpStatus.OK).send({ userid: req.userid });
});

router.get("/all-matches", matchesController.getMatches);

module.exports = router;
