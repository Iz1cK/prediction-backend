const matchesModel = require("../models/matches.model");
const teamsModel = require("../models/teams.model");
const leaguesModel = require("../models/leagues.model");
const ApiError = require("../utils/ApiError");
const catchAsync = require("../utils/catchAsync");
const httpStatus = require("http-status");

const axios = require("axios").default;

const fetchMatches = catchAsync(async (req, res) => {
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
        const matchid = event.match.id;
        const team1id = await teamsModel.getTeamByCode(
          event.match.teams[0].code
        );
        const team2id = await teamsModel.getTeamByCode(
          event.match.teams[1].code
        );
        const outcome = event.match.teams[0].result.outcome;
        const winnerid =
          outcome === "win" ? team1id : outcome === "loss" ? team2id : null;
        const date = event.startTime;
        const leagueid = await leaguesModel.getLeagueByName(event.league.name);

        const format = "Best Of " + event.match.strategy.count;
        matchesModel.insertNewMatch(
          matchid,
          team1id.teamid,
          team2id.teamid,
          winnerid.teamid,
          date,
          leagueid.leagueid,
          format
        );
        return {
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
});

const getMatches = catchAsync(async (req, res) => {
  const matches = await matchesModel.getAllMatches();
  let result = [];
  for (let i = 0; i < matches.length; i++) {
    const match = matches[i];
    const { team1id, team2id, winnerid, leagueid, format, date, matchid } =
      match;
    const team1 = await teamsModel.getTeamById(team1id);
    const team2 = await teamsModel.getTeamById(team2id);
    const winner = winnerid == team1id ? team1.code : team2.code;
    const league = await leaguesModel.getLeagueById(leagueid);
    result.push({
      matchid,
      teams: [team1, team2],
      winner,
      league,
      format,
      date,
    });
  }
  res.status(httpStatus.OK).send({ result, status: "success" });
});

module.exports = { getMatches, fetchMatches };
