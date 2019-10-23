# Virtual-Tourist
This app set pin on the map and download images related with the pin location.
It used on flickr's API.


## Features
- User can put on pin on the map, and show on place picture from Flickr
- Edit pin (remove)

## Flickr API Key apply on Apps
Apply for an API key [here](https://www.flickr.com/services/apps/create/apply).

## Reference 
[플리커 API활용](http://www.isquery.com/wiki/doku.php?id=flickr)

- Login Test 

```
https://api.flickr.com/services/rest/?method=flickr.test.echo&api_key=a700dbe3e34048606e970f8af6fd4fb4&format=json
```
```json
jsonFlickrApi(
              {"method":{"_content":"flickr.test.echo"},
              "api_key":{"_content":"a700dbe3e34048606e970f8af6fd4fb4"},
               "format":{"_content":"json"},"stat":"ok"})
```
