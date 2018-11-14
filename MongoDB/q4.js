/* Script for the mongo Shell.
https://docs.mongodb.com/manual/tutorial/write-scripts-for-the-mongo-shell/
*/

conn = new Mongo();

db = conn.getDB("bda");

print()
print("Restaurante en el borough “Manhattan”.")
print()

filter = {borough: "Manhattan"}
projection = {restaurant_id: 1, borough: 1}

cursor = db.restaurants.find(filter, projection).limit(1);

print("Documentos encontrados: " + cursor.count())
print()

while ( cursor.hasNext() ) {
  printjson( cursor.next() );
}
