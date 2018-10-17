#!/bin/bash

create 'Agenda', 'Personal', 'Oficina'
list
put 'Agenda', '1', 'Personal:Nombre', 'Juan'
scan 'Agenda'
put 'Agenda', '1', 'Personal:Telefono', '312 123 45 67'
scan 'Agenda'
put 'Agenda', '1', 'Oficina:Telefono', '312 555 66 887'
put 'Agenda', '1', 'Oficina:Direccion', 'Calle Falsa 123'
put 'Agenda', '1', 'Personal:Telefono', '312 123 45 97', 1
get 'Agenda', '1', {COLUMN => 'Personal:Telefono'}
get 'Agenda', '1', {COLUMN => 'Personal:Telefono', TIMESTAMP => 1}
get 'Agenda', '1'
get 'Agenda', '1', ['Personal:Telefono', 'Oficina:Telefono']
put 'Agenda', '2', 'Personal:Nombre', 'Maria'
put 'Agenda', '2', 'Personal:Telefono', '320 987 65 43', 1
put 'Agenda', '2', 'Personal:Telefono', '313 356 12 87', 3
put 'Agenda', '2', 'Personal:Telefono', '321 987 65 21', 2
get 'Agenda', '2', {COLUMN => 'Personal:Telefono', TIMERANGE => [1,3]}
get 'Agenda', '2', {COLUMN => 'Personal:Telefono', TIMERANGE => [2,4]}
get 'Agenda', '2', {COLUMN => 'Personal:Telefono', VERSIONS => 4}
put 'Agenda', '2', 'Oficina:Telefono', '555 123 87 45'
put 'Agenda', '2', 'Oficina:Direccion', 'Area 51'
scan 'Agenda'
delete 'Agenda', '2', 'Personal:Telefono', 1
get 'Agenda', '2', {COLUMN => 'Personal:Telefono', VERSIONS => 3}
