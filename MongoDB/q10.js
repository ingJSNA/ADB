/* Script for the mongo Shell.
https://docs.mongodb.com/manual/tutorial/write-scripts-for-the-mongo-shell/
*/

conn = new Mongo();

db = conn.getDB("bda");

print()
print("Restaurantes en los cuales la cuisine NO es “American” NI “Chinese” O el name comienza por la palabra “Wil”. (Hint: utilizar los operadores $or y $and).")
print()

// En cuisine se puede encontran la palabra con un espacio al final
filter = { $or:[
  { $and: [
    { cuisine: {$not: /American.*/} },
    { cuisine: {$not: /Chinese.*/} } ] },
  { name: {$regex: /^Wil.*/} }
  ]
}

projection = {restaurant_id: 1, cuisine: 1, name: 1}

cursor = db.restaurants.find(filter, projection);

print("Documentos encontrados: " + cursor.count())
print()

while ( cursor.hasNext() ) {
  printjson( cursor.next() );
}
