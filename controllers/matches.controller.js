const matchesModel = require("../models/matches.model");
const teamsModel = require("../models/teams.model");
const leaguesModel = require("../models/leagues.model");
const ApiError = require("../utils/ApiError");
const catchAsync = require("../utils/catchAsync");
const httpStatus = require("http-status");

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
  //   setTimeout(() => {
  res.status(httpStatus.OK).send({ result, status: "success" });
  //   }, 2000);
});

module.exports = { getMatches };
