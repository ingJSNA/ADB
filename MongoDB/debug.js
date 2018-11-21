/* Script for the mongo Shell.
https://docs.mongodb.com/manual/tutorial/write-scripts-for-the-mongo-shell/
*/

conn = new Mongo();

db = conn.getDB("bda");

var emit = function(key, value) {
    print("emit");
    print("key: " + key + "  value: " + tojson(value));
}


var mapper = function() {
  var score = {sum: this.grades[0].score, quantity: 1};
  emit(this.address.zipcode, score);
};

var reducer = function (key, values) {
  return Array.sum(values);
};

filter = {}
projection = {restaurant_id: 1, 'address.zipcode': 1, 'grades': 1}

cursor = db.restaurants.find(filter, projection);

print("Documentos encontrados: " + cursor.count())
print()

while ( cursor.hasNext() ) {
  var doc = cursor.next();
  printjson( doc );
  mapper.apply(doc);
}

var myKey = 'myKey';
var myTestValues = [ 5, 5, 10 ];
var valuesIdempotent = [
                         1,
                         reducer(myKey, [ 1, 1 ] )
                       ];
printjson(reducer('myKey', valuesIdempotent));

var reducer2 = function (key, values) {
  reducedVal = { sum: 0, quantity: 0 };

  for(var i=0; i < values.length; i++){
    var value = values[i]
    reducedVal.sum += value.sum;
    reducedVal.quantity += value.quantity;
  }
  return reducedVal;
};
