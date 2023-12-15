#!/usr/bin/env python3
# coding: utf-8

import imp
import json
from posixpath import dirname
import re
import os
import shutil
import sys
import getopt
from jinja2 import Environment,FileSystemLoader
# from pypinyin import pinyin, lazy_pinyin, Style
import base
import gen_dart_cmds

# projects_dir = 'projects'
# os.makedirs(projects_dir, exist_ok=True)
# pre_str = 'RP'
# pre_str = 'OCA'
# swagger_file = 'api-docs-sdk_new_api.json'
# swagger_file = 'api-docs-skd_new_mgr.json'
# swagger_file = 'api-docs-web_custom.json'
# swagger_file = 'api-docs-custom_statis.json'
# swagger_file = 'api-docs-orye_api.json'
# swagger_file = 'api-docs-orye_mgr.json'
# swagger_file = 'api-docs-custom_chart.json'
# swagger_file = 'api-docs-custom_statis.json'
# swagger_file = 'api-docs-log_report.json'
# swagger_file = 'api-docs-oc_back.json'

# pro_name_dir = os.path.join(projects_dir, 'oc_back')
# pro_name_dir = os.path.join(projects_dir, 'oc_back')
# pro_name_dir = os.path.join(projects_dir, 'custom_statis')
# pro_name_dir = os.path.join(projects_dir, swagger_file.replace('api-docs-', '').replace('.json', ''))

# os.makedirs(pro_name_dir, exist_ok=True)
# cmds_json_path = os.path.join(pro_name_dir, './cmds.json')
# responses_json_path = os.path.join(pro_name_dir, './responses.json')
# responses_list_json_path = os.path.join(pro_name_dir, './responsesList.json')
# responses_combine_json_path = os.path.join(pro_name_dir, './responsesCombine.json')

# oc_model_dir = os.path.join(pro_name_dir, 'oc_model')
# os.makedirs(oc_model_dir, exist_ok=True)
# oc_cmd_dir = os.path.join(pro_name_dir, 'oc_cmd')
# os.makedirs(oc_cmd_dir, exist_ok=True)

# js_model_dir = os.path.join(pro_name_dir, 'js_model')
# os.makedirs(js_model_dir, exist_ok=True)
# js_cmd_dir = os.path.join(pro_name_dir, 'js_cmd')
# os.makedirs(js_cmd_dir, exist_ok=True)

# cpp_model_dir = os.path.join(pro_name_dir, 'cpp')
# os.makedirs(cpp_model_dir, exist_ok=True)
# cpp_cmd_dir = os.path.join(pro_name_dir, 'cpp')
# os.makedirs(cpp_cmd_dir, exist_ok=True)

# swagger_cmd_file_name = 'SwaggerCmds'
# swagger_request_file_name = 'SwaggerHttpRequest'

jsoncpp_h_path = "../third/JsonSerializer/Json/json/json.h"

swagger_config_path = 'swagger_config.json'
swagger_config = {}
try:
    f = open(swagger_config_path, 'r', encoding="utf-8")
    swagger_config = json.load(f)
    f.close()
except:
    print('    读取失败: ' + swagger_config_path)
    sys.exit()
    pass

swagger_infos = swagger_config['swagger']['infos']
base_workspace_dir = swagger_config['swagger']['base_workspace_dir']

def genkeyValue(definitions, params):
    # request
    if len(params) == 1: # and params[0]['schema']['$ref'] is not None:
        # print(' ==================================== 1')
        aSchema = params[0].get('schema', None)
        if aSchema is not None:
            # print(' ==================================== 2')
            aRef = aSchema.get('$ref', None)
            if aRef is not None:
                # print(' ==================================== 3')
                ref = aRef #params[0]['schema']['$ref']
                refStrs = ref.split('/')
                # print('refStrs')
                # print(len(refStrs))
                # print(refStrs)
                refStr = refStrs[len(refStrs) - 1]
                definition = definitions[refStr]
                properties = definition.get('properties', {})
                requireds = definition.get('required', [])
                parameters = []
                for propertieKey in properties:
                    propertieValue = properties[propertieKey]
                    type = propertieValue.get('type', '')
                    print(propertieValue)
                    # type = propertieValue['type']
                    # warn
                    if type == '':
                        refs = propertieValue['$ref']
                        refs = refs.split('/')
                        type = refs[len(refs) - 1]
                        pass
                    # if type == 'object':
                    #     print(' object ==========================  ' + propertieKey)
                    #     print(propertieValue)
                    #     print(ref)
                    #     print('refStr:' + refStr)
                    description = propertieValue.get('description', '没有描述')
                    items = propertieValue.get('items', None)
                    parameters.append({
                        'name': propertieKey,
                        'description': description,
                        'type': type,
                        'required': propertieKey in requireds,
                        'items': items,
                        'refStr': refStr
                    })
                return genkeyValue(definitions, parameters)
        pass
    return params

def list_paths(swagger_file, route_prefix):
    # cmd_text = ''
    cmds = []
    all_headerp_params = {}
    responses = {}
    responsesList = {}
    responsesCombine = {}
    f = open(swagger_file, 'r', encoding='utf-8')
    apiDocs = json.load(f)
    f.close()

    # print('apidocs')
    # print(apiDocs)

    host = apiDocs['host']

    if host.find('http') < 0:
        host = 'http://{}'.format(host)

    print(host)

    definitions = apiDocs['definitions']
    definitionKeys = definitions.keys()

    for definitionKey in definitionKeys:
        responses[definitionKey] = definitions[definitionKey]
        # if definitionKey.find('List') >= 0:
        #     responsesList[definitionKey] = definitions[definitionKey]
        # elif definitionKey.find('«') < 0:
        #     responses[definitionKey] = definitions[definitionKey]
        # else:
        #     responsesCombine[definitionKey] = definitions[definitionKey]
        # pass    

    paths = apiDocs['paths']
    pathKeys = paths.keys()

    for pathKey in pathKeys:
        if pathKey == '/error':
            continue
        pathInfo = paths[pathKey]
        methodKeys = pathInfo.keys()
        for methodKey in methodKeys:
            requestInfo = pathInfo[methodKey]
            tags = requestInfo['tags'] or []
            summary = requestInfo['summary'] or '暂无说明'
            operationId = requestInfo['operationId'] or ''
            consumes = requestInfo.get('consumes', []) # ['consumes'] or []         
            parameters = requestInfo.get('parameters', []) # requestInfo['parameters'] or []
            headers = []
            queries = []
            bodies = []
            formDatas = []
            for parameter in parameters:
                inStr = parameter['in']
                if 'header' == inStr:
                    headers.append(parameter)
                elif 'query' == inStr:
                    queries.append(parameter)
                elif 'body' == inStr:
                    bodies.append(parameter)
                elif 'formData' == inStr:
                    formDatas.append(parameter)

            urlparams = []
            regExp1 = r'(\{[^\}]*\})'
            results1 = re.findall(regExp1, pathKey)
            # if results1 is not None and len(results1) > 0:
            #     print(results1)
            for result in results1:
                urlparams.append({
                    'name': result,
                    'description': result,
                    'required': True,
                    'type': 'string'
                })

            pathParams = genkeyValue(definitions, urlparams)
            bodyParams = genkeyValue(definitions, bodies)
            queryParams = genkeyValue(definitions, queries)
            headerParams = genkeyValue(definitions, headers)

            responseStr = requestInfo['responses']['200'].get('schema', {}).get('$ref', '')
            responseStrs = responseStr.split('/')
            responseStr = responseStrs[len(responseStrs) - 1]
            # print('responseStr: {}'.format(responseStr))

            params = headerParams + pathParams + queryParams + bodyParams
            paramsExceptHeaders = pathParams + queryParams + bodyParams
            for param in params:
                name = param.get('name', '暂无说明')
                name = name.replace('{', '')
                name = name.replace('}', '')
                if name == 'id':
                    name = 'id'
                param['realname'] = name
                description = param.get('description', '暂无说明')
                description = description.replace('{', '')
                description = description.replace('}', '')
                if description == 'id':
                    description = 'id'
                param['realdes'] = description
                if description == 'id':
                    description = 'id'                
                type = param.get('type', 'None')
                format = param.get('format', '')
                param['realtype'] = type
                param['is_num'] = type == 'integer' or type == 'number' or type == 'boolean'
                param['realcpptype'] = 'std::string'
                param['realdarttype'] = 'String'
                if type == 'integer' and format == 'int64':
                    param['realcpptype'] = 'int64_t'
                    param['realdarttype'] = 'int'
                elif type == 'integer':
                    param['realcpptype'] = 'int32_t'
                    param['realdarttype'] = 'int'
                elif type == 'number':
                    param['realcpptype'] = 'int32_t'
                    param['realdarttype'] = 'int'
                elif type == 'boolean':
                    param['realcpptype'] = 'bool'
                    param['realdarttype'] = 'bool'

            a_method_name_arr = list(filter(lambda x: x.find('{') < 0, pathKey.split('/')))
            a_method_name_arr = list(map(lambda x:x.title(), a_method_name_arr))
            method_name_str = ''.join(a_method_name_arr)
            method_name_str = method_name_str.replace('-', '')

            # for headerParam in headerParams:
            #     all_headerp_params[]

            cmd_dict = {
                'pathKey': pathKey,
                'route_prefix': route_prefix,
                'operationId': operationId,
                'consumes': consumes,
                'summary': summary,
                'tags': ','.join(tags),
                'method': methodKey,
                'pathParams': pathParams,
                'bodyParams': bodyParams,
                'queryParams': queryParams,
                'headerParams': headerParams,
                'response': responseStr,
                'allParams': params,
                'paramsExceptHeaders': paramsExceptHeaders,
                'method_name_str': method_name_str
            }
            cmds.append(cmd_dict)

    print('=============================== all_headerp_params2: ')
    print(all_headerp_params)
    return cmds, responses, responsesList, responsesCombine, definitions


def get_select_response_with_refs(selectd_responses, definitions):
    def list_dict(a_dict, definitions, response_strs=[]):
        for key in a_dict.keys():
            value = a_dict[key]
            if isinstance(value, str):
                if value.find('#/definitions/') >= 0:
                    a_value = value.replace('#/definitions/', '')
                    response_strs.append(a_value)
                    list_dict(definitions[a_value], definitions, response_strs)
                pass
            elif isinstance(value, dict):
                list_dict(value, definitions, response_strs)
        return response_strs

    select_response_with_refs = []
    for selectd_response in selectd_responses:
        if len(selectd_response) <= 0:
            continue
        properties = definitions[selectd_response]['properties']
        property_keys = properties.keys()
        if ('code' in property_keys and 'data' in property_keys and 'msg' in property_keys) == False:
            select_response_with_refs += [selectd_response]
        print('selectd_response222')
        print(selectd_response)
        select_response_with_refs += list_dict(definitions[selectd_response], definitions)
        # properties = definitions[selectd_response]
        # select_response_with_refs += list_dict(properties, definitions)
        # list_objs = properties
        # while len(list_objs.keys()) > 0:
        #     for key in list_objs.keys():
        #         value = list_objs[key]
    return select_response_with_refs
    pass

if __name__ == '__main__':
    # base.save_json(cmds_json_path, cmds)
    # base.save_json(responses_json_path, responses)
    # base.save_json(responses_list_json_path, responsesList)
    # base.save_json(responses_combine_json_path, responsesCombine)
    # gen_oc_cmds.gen_oc_cmds(oc_cmd_dir, cmds_json_path, swagger_cmd_file_name, swagger_request_file_name, pre_str)
    # gen_oc_cmds.gen_oc_models(responses_json_path, oc_model_dir, pre_str)
    # gen_js_cmds.gen_js_cmds(js_cmd_dir, cmds_json_path, swagger_cmd_file_name, swagger_request_file_name, pre_str)
    # gen_js_cmds.gen_js_models(responses_json_path, js_model_dir, pre_str)

    os.makedirs('_test', exist_ok=True)

    is_debug = False
    argv = sys.argv[1:]
    try:
        opts, args = getopt.getopt(argv, "d",[])
    except getopt.GetoptError:
        # sys.exit(2)
        pass
    
    for opt, arg in opts:
        # print(opt)
        # print(arg)
        if opt == '-d':
            is_debug = True
            print('is_debug')

    for swagger_info in swagger_infos:
        entity_dir = swagger_info['entity_dir']
        g_entity_dir = swagger_info['g_entity_dir']
        project_package = swagger_info['project_package']
        json_conver_target_dir = swagger_info['json_conver_target_dir']        
        swagger_file = swagger_info['swagger_file']
        model_prefix = swagger_info['model_prefix']
        route_prefix = swagger_info['route_prefix']
        selectd_routes = swagger_info['selectd_routes']
        target_model_path = swagger_info['target_model_path']
        target_cmd_path = swagger_info['target_cmd_path']
        # cmd_class_name = swagger_info['cmd_class_name']
        request_class_name = swagger_info['request_class_name']
        cmds, responses, responsesList, responsesCombine, definitions = list_paths(swagger_file, route_prefix)
        #
        base.save_json(os.path.join('_test', model_prefix + '_cmds.json'), cmds)
        base.save_json(os.path.join('_test', model_prefix + '_responses.json'), responses)
        base.save_json(os.path.join('_test', model_prefix + '_responsesList.json'), responsesList)
        base.save_json(os.path.join('_test', model_prefix + '_responsesCombine.json'), responsesCombine)
        #
        # target_model_full_path = base_workspace_dir + target_model_path
        # target_cmd_full_path = base_workspace_dir + target_cmd_path
        # cpp_model_dir = os.path,dirname(target_model_full_path)
        # cpp_model_file = os.path.basename(target_model_full_path)
        # cpp_cmd_dir = os.path.dirname(target_cmd_full_path)
        # cpp_cmd_file = os.path.basename(target_cmd_full_path)
        #
        # gen_cpp_cmds.gen_cpp_cmds(cmds, cmd_class_name, request_class_name, target_cmd_full_path, pre_str, jsoncpp_h_path)
        # gen_cpp_cmds.gen_cpp_models(responses, target_model_full_path, pre_str, jsoncpp_h_path)
        print('swagger file 22=======================')
        print(swagger_file)
        selectd_responses = gen_dart_cmds.gen_dart_cmds(is_debug, cmds, project_package, request_class_name, base_workspace_dir, target_cmd_path, model_prefix, selectd_routes)
        print(selectd_responses)
        with_refs = get_select_response_with_refs(selectd_responses, definitions)
        print(with_refs)
        gen_dart_cmds.gen_dart_models(is_debug, responses, project_package, base_workspace_dir, entity_dir, g_entity_dir, target_model_path, model_prefix, with_refs)
        gen_dart_cmds.gen_dart_json_conver(is_debug, project_package, base_workspace_dir, entity_dir, json_conver_target_dir, model_prefix)

