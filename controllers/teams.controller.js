const teamsModel = require("../models/teams.model");
const ApiError = require("../utils/ApiError");
const catchAsync = require("../utils/catchAsync");
const httpStatus = require("http-status");

const getAllWorldCupTeams = catchAsync(async (req, res) => {
  const teams = await teamsModel.getAllWCTeams();
  res.status(httpStatus.OK).send({ success: true, result: teams });
});

module.exports = {
  getAllWorldCupTeams,
};
