Atlas map
=========

MapServer configuratie voor Atlas.


Development
-----------

* Build de mapserver docker.
* Download eventueel de database met de geoviews.
* controleer eerste de geo data met qgis door direct met postgres te werken
* configureer de mapfile om het de juiste database en data te werken
* Ontwikkel met http://localhost/map/YOURMAPFILENAME


Development met Docker
----------------------

Installeer:

* [docker](https://docs.docker.com/index.html)
* [docker-compose](https://docs.docker.com/compose/install/)

Draai


    cd mapserver
    $ docker-compose build && docker-compose up -d

De server is nu te bereiken op <http://${DOCKER_HOST}:8989/maps/YOURMAPFILE>

De Postgres database is te bereiken op tcp://${DOCKER_HOST}:5403

De laatste versie van de database kan opgehaald worden met:

	$ docker exec $(docker-compose ps -q database) update-db.sh nap
	$ docker exec $(docker-compose ps -q database) update-db.sh milieuthemas
	$ docker exec $(docker-compose ps -q database) update-db bag
	$ docker exec $(docker-compose ps -q database) update-db handelsregister
	
	
Each mapfile can be reached `/maps/mapfilename` for convenience.

	
WMS services
------------

| Set    | URL                                                                                                            |
| ------ | ---------------------------------------------------------------------------------------------------------------|
| BAG    | /maps/bag&service=wms&request=getcapabilities      |
| WKPB   | /maps/wkpb&service=wms&request=getcapabilities     |
| LKI    | /maps/lki&service=wms&request=getcapabilities      |
| GBKA   | /maps/gbka&service=wms&request=getcapabilities     |
| KBKA10 | /maps/kbka10&service=wms&request=getcapabilities   |
| KBKA50 | /maps/kbka50&service=wms&request=getcapabilities   |
| NAP    | /maps/nap&service=wms&request=getcapabilities      |
| VLGH   | /maps/**externeveiligheid**&service=wms&request=getcapabilities                                |
| GBIEDN | /maps/**gebieden**.map&service=wms&request=getcapabilities                                         |


WFS services
------------

| Set    | URL                                                                                                          |
| ------ | ------------------------------------------------------------------------------------------------------------ |
| BAG    | maps/bag&service=wfs&request=getcapabilities    |
| WKPB   | maps/wkpb&service=wfs&request=getcapabilities   |
| LKI    | maps/lki&service=wfs&request=getcapabilities    |
| NAP    | maps/nap&service=wfs&request=getcapabilities    |


TMS services
------------
Topo
Lufo
LKI kot



Test
----

Bijvoorbeeld de kaartserver in bag.map:

* wms capabilities:   <http://192.168.99.100:8989/cgi-bin/mapserv?map=/srv/mapserver/bag.map&service=wms&request=getcapabilities>
* kaart opvragen :    <http://192.168.99.100:8989/cgi-bin/mapserv?map=/srv/mapserver/bag.map&service=wms&request=getmap&version=1.3.0&layers=ligplaats&width=500&height=500&crs=epsg:28992&bbox=122000,487000,122250,487250&format=image/png>
* wfs capabilities:   <http://192.168.99.100:8989/cgi-bin/mapserv?map=/srv/mapserver/bag.map&service=wfs&request=getcapabilities>
* 1 feature opvragen: <http://192.168.99.100:8989/cgi-bin/mapserv?map=/srv/mapserver/bag.map&service=wfs&version=1.1.0&request=getfeature&typename=ligplaats&maxfeatures=1>

Monumenten
* wms kaart:
http://localhost:8989/maps/monumenten&SERVICE=WMS&VERSION=1.3.0&REQUEST=GetMap&BBOX=119160,485473,124004,489948&CRS=EPSG:28992&WIDTH=1217&HEIGHT=1217&LAYERS=monument_coordinaten&STYLES=&FORMAT=image/png&DPI=72&MAP_RESOLUTION=72&FORMAT_OPTIONS=dpi:72&TRANSPARENT=false
http://localhost:8989/maps/monumenten&SERVICE=WMS&VERSION=1.3.0&REQUEST=GetMap&BBOX=119160,485473,124004,489948&CRS=EPSG:28992&WIDTH=1217&HEIGHT=1217&LAYERS=monument_geometrie&STYLES=&FORMAT=image/png&DPI=72&MAP_RESOLUTION=72&FORMAT_OPTIONS=dpi:72&TRANSPARENT=false
