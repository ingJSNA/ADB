/* Script for the mongo Shell.
https://docs.mongodb.com/manual/tutorial/write-scripts-for-the-mongo-shell/
*/

conn = new Mongo();

db = conn.getDB("bda");

print()
print("Restaurantes ordenados en ascendentemente por el name.")
print()

filter = {}

projection = {restaurant_id: 1, name: 1}

cursor = db.restaurants.find(filter, projection).sort({name: 1});

print("Documentos encontrados: " + cursor.count())
print()

while ( cursor.hasNext() ) {
  printjson( cursor.next() );
}
