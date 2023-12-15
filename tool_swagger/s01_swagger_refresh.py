import imp
import json
import base
import requests
import os
import base

def refresh():
  json_dict = base.read_json('swagger_config_sources.json')
  swagger_resources = json_dict['swagger_resources']
  for swagger_resource in swagger_resources:
    store_dir = swagger_resource['store_dir']
    url = swagger_resource['url']
    print(store_dir)
    print(url)
    ret = requests.get(url, headers={})
    print(ret.text)
    sw_urls = json.loads(ret.text)
    # print(sw_urls)
    # print(len(sw_urls))
    os.makedirs(store_dir, exist_ok=True)
    base.save_json(store_dir + '/_all_swagger_urls.json', sw_urls)
    base_url = url.replace('/swagger-resources', '')
    for sw_url_dict in sw_urls:
      # print(sw_url_dict)
      servicePath = sw_url_dict['servicePath']
      header = sw_url_dict['header']
      location = sw_url_dict['location']
      a_api_url = base_url + location
      file_name = servicePath.replace('/', '') + '.json'
      print('================================')
      print(a_api_url)
      ret2 = requests.get(a_api_url, headers={
        "knfie4j-gateway-request": header
      })
      # print(ret2.text)
      sw_api_json = json.loads(ret2.text)
      base.save_json(store_dir + '/' + file_name, sw_api_json)

  pass

if __name__ == '__main__':
  refresh()
  pass