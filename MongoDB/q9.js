/* Script for the mongo Shell.
https://docs.mongodb.com/manual/tutorial/write-scripts-for-the-mongo-shell/
*/

conn = new Mongo();

db = conn.getDB("bda");

print()
print("Restaurantes en los cuales el nombre comienza por la palabra “Wil”. (Hint: usar expresión regular sobre el campo name).")
print()

// En cuisine se puede encontran la palabra con un espacio al final
filter = { name: {$regex: /^Wil.*/}}

projection = {restaurant_id: 1, name: 1}

cursor = db.restaurants.find(filter, projection);

print("Documentos encontrados: " + cursor.count())
print()

while ( cursor.hasNext() ) {
  printjson( cursor.next() );
}
