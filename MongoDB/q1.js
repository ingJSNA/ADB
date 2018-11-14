/* Script for the mongo Shell.
https://docs.mongodb.com/manual/tutorial/write-scripts-for-the-mongo-shell/
*/

conn = new Mongo();

db = conn.getDB("bda");

print()
print("Todos los restaurantes de la base de datos")
print()

filter = {}
projection = {}

cursor = db.restaurants.find(filter, projection);

while ( cursor.hasNext() ) {
  printjson( cursor.next() );
}
