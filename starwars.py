import sys,requests,json

BASE_URL = "https://swapi.co/api"
FILMS = []
########################### FUNCTIONS ###########################
def getPilot(url):
    try:
        response = requests.get(url = url).json()
        return str(response['name'])
    except Exception as e:
        print("Error getting pilot data: {0}".format(str(e)))

def getStarShipData(url):
    try:
        response = requests.get(url = url).json()
        data = { 'ship' : str(response['name']), 'pilots' : [] }
        for _pilotUrl in response['pilots']:
            data['pilots'].append(getPilot(_pilotUrl))
        return data
    except Exception as e:
        print("Error getting starship data: {0}".format(str(e)))

def getFilmData(title = None):
    try:
        response = requests.get(url = BASE_URL + "/films").json()
        data = {}
        for _item in response['results']:
            FILMS.append(_item['title'].lower())
            if _item['title'].lower() == title:
                data['title'] = film
                data['starships'] = []
                for _starshipUrl in _item['starships']:
                    data['starships'].append(getStarShipData(_starshipUrl))
        return data
    except Exception as e:
        print("Error getting film data: : {0}".format(str(e)))
########################### LOGIC ###########################
if len(sys.argv) == 1:
    films = getFilmData()
    print(json.dumps({ "error": "no movie entered", "films": FILMS }))
    sys.exit()
else:
    film = " ".join(sys.argv[1:]).lower()
data = getFilmData(film)

if len(data.keys()) > 0:
    print(json.dumps(data))
    sys.exit(0)
else:
    print(json.dumps({ "error": "failed to get film data", "films": FILMS }))
