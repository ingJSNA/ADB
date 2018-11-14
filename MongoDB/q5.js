/* Script for the mongo Shell.
https://docs.mongodb.com/manual/tutorial/write-scripts-for-the-mongo-shell/
*/

conn = new Mongo();

db = conn.getDB("bda");

print()
print("Restaurantes con score mayor que 90.")
print()

filter = {"grades.score": {$gt: 90}}
projection = {restaurant_id: 1, "grades.score": 1}

cursor = db.restaurants.find(filter, projection);

print("Documentos encontrados: " + cursor.count())
print()

while ( cursor.hasNext() ) {
  printjson( cursor.next() );
}
