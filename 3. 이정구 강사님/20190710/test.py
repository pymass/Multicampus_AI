import urllib.request
import json

data = {
        "Inputs": {
                "input1":
                [
                    {
                            'sepal_length': "5.1",   
                            'sepal_width': "3.5",   
                            'petal_length': "1.4",   
                            'petal_width': "0.2",   
                            'species': "setosa",   
                    }
                ],
        },
    "GlobalParameters":  {
    }
}

body = str.encode(json.dumps(data))

url = 'https://ussouthcentral.services.azureml.net/workspaces/fc032cd4e3374997abbc3de9d91fa100/services/2e1280c780164ec79f75e14a212ad705/execute?api-version=2.0&format=swagger'
api_key = 'G1OF2wEArvNM9ol8f54PLl9CQo6qKP+zWLY7ue86PPVBXOMSPRoOhf9ImGPHf+TCV1Hc4i/CvqGR2nc4fMug5g==' # Replace this with the API key for the web service
headers = {'Content-Type':'application/json', 'Authorization':('Bearer '+ api_key)}

req = urllib.request.Request(url, body, headers)

try:
    response = urllib.request.urlopen(req)

    result = response.read()
    print(result)
except urllib.error.HTTPError as error:
    print("The request failed with status code: " + str(error.code))

    # Print the headers - they include the requert ID and the timestamp, which are useful for debugging the failure
    print(error.info())
    print(json.loads(error.read().decode("utf8", 'ignore')))