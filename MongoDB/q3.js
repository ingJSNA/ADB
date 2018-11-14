/* Script for the mongo Shell.
https://docs.mongodb.com/manual/tutorial/write-scripts-for-the-mongo-shell/
*/

conn = new Mongo();

db = conn.getDB("bda");

print()
print("Todos los restaurantes: únicamente los campos restaurant_id, name, zipcode y SIN _id.")
print()

filter = {}
projection = {_id: 0, restaurant_id: 1, name: 1, "address.zipcode":1}

cursor = db.restaurants.find(filter, projection);

while ( cursor.hasNext() ) {
  printjson( cursor.next() );
}
