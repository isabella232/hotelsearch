var express = require('express'),
  bodyParser = require('body-parser')
  logger = require('morgan')

var loki = require('lokijs'),
  db = new loki('hotels.json',{verbose:true});

var sequence = 6;

var hotels = db.addCollection('hotels');

hotels.insert({"id":1,"name": "Grand Budapest Hotel",
  "address":"Market Street, 212","star_rating": 5,"accomodation_type": 5});

hotels.insert({"id": 2,"name": "Hotel California",
  "address":"The Eagles Avenue, 123","star_rating": 3,"accomodation_type": 2});

hotels.insert({"id":3,"name": "Heartbreak Hotel",
  "address":"Elvis PResly Boulevard, 1111","star_rating": 4,"accomodation_type": 2});

hotels.insert({"id":4,"name": "Small Hotel",
  "address":"Ella Lane, 1111","star_rating": 5,"accomodation_type": 5});

hotels.insert({"id":5,"name": "Holiday Inn",
  "address":"Gang Ave, no nbr","star_rating": 1,"accomodation_type": 4});

var app = express()
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: true}))
app.use(logger('dev'))
app.use(function(req, res, next) {
  res.set({ 'content-type': 'application/json; charset=utf-8' })
  //res.setHeader("Content-Type", "application/json");
  return next();
});

// app.param('collectionName', function(req, res, next, collectionName){
//   req.collection = db.collection(collectionName)
//   return next()
// })

app.get('/hotels', function(req, res, next) {
  var query = {};
  if(req.query.field){
    par = {};
    par[req.query.op || '$regex'] = `${req.query.value}`;
    query[req.query.field] = par;
  }
  console.log(query);
  var h = hotels.find(query);
  res.send(h);
})

app.get('/hotel/:id', function(req, res, next) {
  var h = hotels.get(req.params.id);
  res.send(h);
})

app.post('/hotels', function(req, res, next) {
  var body = req.body;
  body.id = sequence++;
  console.info(body);
  var h = hotels.insert(body);
  res.send(h);
})

app.delete('/hotel/:id', function(req, res, next) {
  var h = hotels.get(req.params.id);
  hotels.remove(h);
  res.send('ok');
})

app.post('/hotel/:id', function(req, res, next) {
  var params = req.body;
  var h = hotels.get(params.id);
  if(!params["$loki"]){
    h.name = params.name;
    h.address = params.address;
    h.star_rating = params.star_rating;
    h.accomodation_type = params.accomodation_type;
  }
  if(h){
    h = hotels.update(h);
  }else{
    h = hotels.insert(req.body);
  }
  res.send(h);
})

app.delete('/hotel/:id', function(req, res, next) {
  var h = hotels.get(req.params.id);
  h = hotels.remove(h);
  res.send("removed");
})

app.listen(3030, function(){
  console.log('Express server listening on port 3030')
})
