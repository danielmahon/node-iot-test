var express = require('express');
var router = express.Router();

var five = require("johnny-five");
var Raspi = require('raspi-io');
var board = new five.Board({
  io: new Raspi()
});

var AWS = require('aws-sdk');
var sns = new AWS.SNS();

var intruder = false;

function sendMessage(msg) {
  var params = {
    Message: msg, /* required */
    TopicArn: process.env.AWS_SNS_TOPIC_ARN
  };
  sns.publish(params, function(err, data) {
    if (err) console.log(err, err.stack); // an error occurred
    else     console.log(data);           // successful response
  });
}

board.on("ready", function() {

  sendMessage('Security System Online');

  // Create a new `motion` hardware instance.
  var motion = new five.IR.Motion('GPIO18');

  // "calibrated" occurs once, at the beginning of a session,
  motion.on("calibrated", function() {
    console.log("calibrated");
  });

  // "motionstart" events are fired when the "calibrated"
  // proximal area is disrupted, generally by some form of movement
  motion.on("motionstart", function() {
    console.log("motionstart");
    intruder = true;

    sendMessage('Motion Detected!');

  });

  // "motionend" events are fired following a "motionstart" event
  // when no movement has occurred in X ms
  motion.on("motionend", function() {
    console.log("motionend");
    intruder = false;
  });
});

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express', motion: intruder });
});

module.exports = router;
