/* Script for the mongo Shell.
https://docs.mongodb.com/manual/tutorial/write-scripts-for-the-mongo-shell/
*/

conn = new Mongo();

db = conn.getDB("bda");

print()
print("Restaurante en el borough “Manhattan”.")
print()

filter = {borough: "Manhattan"}
projection = {}

cursor = db.restaurants.find(filter, projection).limit(1);

while ( cursor.hasNext() ) {
  printjson( cursor.next() );
}
