const express = require("express");
const dotenv = require("dotenv");
const bodyParser = require("body-parser");
const { pool } = require("./models/db");

dotenv.config();
const app = express();
app.use(bodyParser.json());

// Routes
app.use("/api/auth", require("./routes/auth"));
app.use("/api/scripts", require("./routes/scripts"));

app.listen(process.env.PORT || 5000, () => console.log("Server running"));
