/* Script for the mongo Shell.
https://docs.mongodb.com/manual/tutorial/write-scripts-for-the-mongo-shell/
*/

conn = new Mongo();

db = conn.getDB("bda");

print()
print("Restaurante con score mayor que 80 y menor que 90.")
print()

// Uno de los score debe cumplir con todos los criterios
filter = {"grades.score": { $elemMatch: { $gt: 80, $lt: 90 } }}
projection = {}

cursor = db.restaurants.find(filter, projection);

while ( cursor.hasNext() ) {
  printjson( cursor.next() );
}
