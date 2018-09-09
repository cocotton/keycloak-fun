require('dotenv').config();

var request = require('request');
var express = require('express');
var router = express.Router();

const OIDC_BASE_URI = `${process.env.OIDC_ISSUER_URI}/protocol/openid-connect`

/*
  ALL OF THE ROUTES IN THIS PAGE REQUIRE AN AUTHENTICATED USER
*/

/* GET users listing. */
router.get('/', function(req, res, next) {

  console.log(req.user)

  res.render('users', {
    title: 'Users',
    user: req.user
  });
});

/* GET the profile of the current authenticated user */
router.get('/profile', function(req, res, next) {

  request.get(`${OIDC_BASE_URI}/userinfo`, {
    'auth': {
      'bearer': req.session.accessToken
    }
  },function(err, respose, body){

    console.log('User Info')
    console.log(body);

    res.render('profile', {
      title: 'Profile',
      user: JSON.parse(body)
    });

  });
});

module.exports = router;
