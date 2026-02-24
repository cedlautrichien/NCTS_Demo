import requests

def ctw_in(body):
    headers = {'content-type': 'text/xml'}
    url="https://txm.portal.at/at.gv.bmf-ef.ctw.in-wb/soap/ezoll?wsdl"
    response = requests.post(url,data=body,headers=headers)
    return response

def ctw_out(body):
    headers = {'content-type': 'text/xml'}
    url="https://txm.portal.at/at.gv.bmf-ef.ctw.out-wb/soap/ezoll/out?wsdl"
    response = requests.post(url,data=body,headers=headers)
    return response
