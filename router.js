const httpStatus = require("http-status");
const checkAuth = require("./middlewares/checkAuth");
const router = require("express").Router();
const usersController = require("./controllers/users.controller");
const matchesController = require("./controllers/matches.controller");
const predictionsController = require("./controllers/predictions.controller");
const teamsController = require("./controllers/teams.controller");

router.post("/login", usersController.login);
router.get("/users", usersController.getUsers);
router.post("/register", usersController.register);
router.get("/me", checkAuth, (req, res) => {
  res.status(httpStatus.OK).send({ userid: req.userid });
});

router.get("/all-matches", matchesController.getMatches);

router.post(
  "/make-predictions",
  checkAuth,
  predictionsController.makePredictions
);

router.get("/get-predictions", checkAuth, predictionsController.getPredictions);
router.get("/current-matches", matchesController.fetchMatches);

router.get(
  "/worldcup-predictions",
  checkAuth,
  predictionsController.getWCPredictions
);
router.get("/worldcup-matches", matchesController.getWCMatches);
router.get("/worldcup-teams", teamsController.getAllWorldCupTeams);

module.exports = router;
