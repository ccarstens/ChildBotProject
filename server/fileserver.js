var express = require("express");
var bodyparser = require("body-parser");

var fileserver = express();

fileserver.use(bodyparser.json());
fileserver.use(bodyparser.urlencoded());


fileserver.use(function (request, response, next) {
    console.log(`${request.method} request for ${request.url}`);
    next();
});

fileserver.use(express.static("../public_html"));

fileserver.get("/get-phrases", function (request, response) {

    var mysql = require("mysql");
    var con = mysql.createConnection({
        host: "localhost",
        port: 8889,
        user: "root",
        password: "root",
        database: "childbot"
    });

    var mysqlresult = "";
    con.connect(function (err) {
        if(err) throw err;
        console.log("Connected");
        var i = 2;
        con.query(`SELECT * FROM general_phrases WHERE type_id = ${i}`, function (err, result) {
            result.forEach(function (v, k) {
                response.write(v.content);
            });
            console.log(mysqlresult);
        });
    });



});

fileserver.listen(3000);
console.log("Express is running");
