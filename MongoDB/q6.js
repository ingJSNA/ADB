/* Script for the mongo Shell.
https://docs.mongodb.com/manual/tutorial/write-scripts-for-the-mongo-shell/
*/

conn = new Mongo();

db = conn.getDB("bda");

print()
print("Restaurante con score mayor que 80 y menor que 90.")
print()

// Si se busca que un score cumpla con todos los criterios se usa $elemMatch
filter = {"grades.score": { $elemMatch: { $gt: 80, $lt: 90 } }}
filter = {"grades.score": { $gt: 80, $lt: 90 } }
projection = {restaurant_id: 1, "grades.score": 1}

cursor = db.restaurants.find(filter, projection);

print("Documentos encontrados: " + cursor.count())
print()

while ( cursor.hasNext() ) {
  printjson( cursor.next() );
}
