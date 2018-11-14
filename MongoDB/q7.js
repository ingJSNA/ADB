/* Script for the mongo Shell.
https://docs.mongodb.com/manual/tutorial/write-scripts-for-the-mongo-shell/
*/

conn = new Mongo();

db = conn.getDB("bda");

print()
print("Restaurantes ubicados en latitude menor a -95.754168.")
print()

filter = {"address.coord.1": {$lt: -95.754168}}
projection = {}

cursor = db.restaurants.find(filter, projection);

while ( cursor.hasNext() ) {
  printjson( cursor.next() );
}
