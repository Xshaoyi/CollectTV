var parseLandingUrl = function(body){
    var reg = /location\.replace\("(.+)\"\)/;
    return (reg.exec(body))[1];
}
module.exports = {
    parseLandingUrl:parseLandingUrl
};