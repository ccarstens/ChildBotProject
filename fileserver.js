var express = require("express");

var fileserver = express();

fileserver.use(express.static("./public_html"));

fileserver.listen(3000);
console.log("Express is running");
