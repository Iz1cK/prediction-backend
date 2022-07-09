const httpStatus = require("http-status");
const checkAuth = require("./middlewares/checkAuth");
const router = require("express").Router();
const catchAsync = require("./utils/catchAsync");
const axios = require("axios").default;

const usersController = require("./controllers/users.controller");
const matchesController = require("./controllers/matches.controller");
const predictionsController = require("./controllers/predictions.controller");

const predictionsModel = require("./models/matches.model");
const teamsModel = require("./models/teams.model");
const leaguesModel = require("./models/leagues.model");

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

router.get(
  "/current-matches",
  catchAsync(async (req, res) => {
    const { events } = (
      await axios.get(
        "https://esports-api.lolesports.com/persisted/gw/getSchedule?hl=en-GB&leagueId=98767991302996019%2C98767991299243165",
        {
          headers: {
            "x-api-key": "0TvQnueqKa5mxJntVWt0w4LpLfEkrV1Ta8rQBb9Z",
          },
        }
      )
    ).data.data.schedule;
    const formattedEvents = await Promise.all(
      events.map(async (event) => {
        try {
          const team1id = await teamsModel.getTeamByCode(
            event.match.teams[0].code
          );
          //   const team1id = (
          //     await teamsModel.getTeamByCode(event.match.teams[0].code)
          //   ).teamid;
          const team2id = await teamsModel.getTeamByCode(
            event.match.teams[1].code
          );
          //   const team2id = (
          //     await teamsModel.getTeamByCode(event.match.teams[1].code)
          //   ).teamid;
          const outcome = event.match.teams[0].result.outcome;
          const winnerid =
            outcome === "win" ? team1id : outcome === "loss" ? team2id : null;
          const date = event.startTime;
          const leagueid = await leaguesModel.getLeagueByName(
            event.league.name
          );
          console.log("leagueid", leagueid);
          const format = "Best Of " + event.match.strategy.count;
          return {
            // team1id,
            // team2id,
            teams: [team1id, team2id],
            winnerid,
            date,
            league: leagueid,
            format,
          };
        } catch (e) {
          console.log(e);
        }
      })
    );
    res.status(200).send({ result: formattedEvents });
  })
);

module.exports = router;
