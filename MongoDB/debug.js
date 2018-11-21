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
  emit(this.address.zipcode, 1);
};

var reducer = function (key, values) {
  return Array.sum(values);
};

filter = {}
projection = {restaurant_id: 1, 'address.zipcode': 1}

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
