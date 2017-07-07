var express = require("express");
var bodyparser = require("body-parser");

var fileserver = express();

fileserver.use(bodyparser.json());
fileserver.use(bodyparser.urlencoded());


fileserver.use(function (request, response, next) {
    console.log(`${request.method} request for ${request.url}`);
    next();
});

fileserver.use(express.static("./public_html"));

fileserver.get("/get-phrases", function (request, response) {
    response.json("hello");
});

fileserver.listen(3000);
console.log("Express is running");
