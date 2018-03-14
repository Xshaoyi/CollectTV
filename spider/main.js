// var Crawler = require("crawler");
// var c = new Crawler({
//     callback : function (error, res, done){
//         if(error){
//             console.log(error);
//         }else{
//             var $ = res.$;
//             // $ 默认为 Cheerio 解析器
//             // 它是核心jQuery的精简实现，可以按照jQuery选择器语法快速提取DOM元素
//             console.log($("title").text());
//         }
//         done();
//     }
// });
// c.queue('http://www.baidu.com');

var request = require("request");
var util = require("./util.js");
request('https://nokia--sdcdev.cs19.my.salesforce.com/?un=yi.shao@nokia.sdcdev&pw=sy1221123', function (error, response, body) {
    console.log(error)
  if (!error && response.statusCode == 200) {
    console.log(util.parseLandingUrl(body)); 
    var landingUrl = util.parseLandingUrl(body);
    request("")
  }
  
});