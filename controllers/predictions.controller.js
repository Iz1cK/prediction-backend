const matchesModel = require("../models/matches.model");
const teamsModel = require("../models/teams.model");
const leaguesModel = require("../models/leagues.model");
const predictionsModel = require("../models/predictions.model");
const ApiError = require("../utils/ApiError");
const catchAsync = require("../utils/catchAsync");
const httpStatus = require("http-status");

const makePredictions = catchAsync(async (req, res) => {
  const userid = req.userid;
  const predictions = req.body;
  if (!predictions) throw new ApiError(httpStatus.BAD_REQUEST, "Missing info!");
  let results = [];
  for (let i = 0; i < predictions.length; i++) {
    const { matchid, prediction } = predictions[i];
    if (isNaN(prediction)) {
      const remove = await predictionsModel.removePrediction(userid, matchid);
      results.push(remove);
    }
    const check = await predictionsModel.checkIfExists(userid, matchid);
    if (check) {
      const result = await predictionsModel.updatePrediction(check, prediction);
      results.push(result);
    } else {
      const result = await predictionsModel.makePrediction(
        userid,
        matchid,
        prediction
      );
      results.push(result);
    }
  }
  res.status(httpStatus.OK).send({ status: "success", result: results });
});

const getPredictions = catchAsync(async (req, res) => {
  const userid = req.userid;
  const result = await predictionsModel.getPredictions(userid);
  res.status(httpStatus.OK).send({ status: "success", result });
});

module.exports = { makePredictions, getPredictions };
