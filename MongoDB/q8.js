/* Script for the mongo Shell.
https://docs.mongodb.com/manual/tutorial/write-scripts-for-the-mongo-shell/
*/

conn = new Mongo();

db = conn.getDB("bda");

print()
print("Restaurantes para los cuales cuisine es diferente de “American”, tiene un grade de “A” y no pertenece al borough “Brooklyn”.")
print()

// En cuisine se puede encontran la palabra con un espacio al final
filter = { cuisine: {$not: /American.*/} , "grades.grade": "A", borough: {$ne: "Brooklyn"}}

projection = {restaurant_id: 1, cuisine: 1, "grades.grade": 1, borough: 1}

cursor = db.restaurants.find(filter, projection);

print("Documentos encontrados: " + cursor.count())
print()

while ( cursor.hasNext() ) {
  printjson( cursor.next() );
}
