import http.client

conn = http.client.HTTPSConnection("profserv-msp.itsm-us1.comodo.com")

headers = {
    'content-type': "application/json",
    'x-auth-type': "4",
    'x-auth-token': "e087f80be7add78cea126174f474ad33",
    'cache-control': "no-cache",
    }

conn.request("GET", "/api/rest/v1/device-group/assigned-profiles-list?id=1&page=1&page-size=200", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))