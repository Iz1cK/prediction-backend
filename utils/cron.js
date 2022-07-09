const cron = require("node-cron");
const axios = require("axios");

// */45 5-12 * * Fri,Sat,Sun => Every 45 minutes, between 05:00 AM and 12:59 PM, only on Friday, Saturday, and Sunday
// cron.schedule("* * * * * *", () => {});
const formatApiData = async () => {
  const { events } = (
    await axios.get(
      "https://esports-api.lolesports.com/persisted/gw/getSchedule?hl=en-GB&leagueId=98767991302996019%2C98767991299243165",
      { headers: { "x-api-key": " 0TvQnueqKa5mxJntVWt0w4LpLfEkrV1Ta8rQBb9Z" } }
    )
  ).data.schedule;

  console.log(events);
};
