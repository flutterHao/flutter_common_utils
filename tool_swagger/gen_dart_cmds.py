#!/usr/bin/env python3
# coding: utf-8

import os
import base
from jinja2 import Environment, FileSystemLoader
from pypinyin import pinyin, lazy_pinyin, Style
import datetime
import base
import re

def filter_key(key):
    key = key.replace('-', '')
    key = key.replace(' ', '')
    key = key.replace('«', '')
    key = key.replace('»', '')
    key = key.replace(',', '')
    keys = lazy_pinyin(key)
    keys = list(map(lambda x:x[0].upper() + x[1:] , keys))
    key = ''.join(keys)
    return key

def basename_to_class_name(name):
    name = name.split('.')[0]
    name = name.replace('-', '_')
    while name.find('__') >= 0:
        name = name.replace('__', '_')
        pass
    name_strs = name.split('_')
    name_strs = list(map(lambda x:x[0].upper() + x[1:] , name_strs))
    name = ''.join(name_strs)
    return name
    pass

def gen_dart_cmds(is_debug, cmds, project_package, request_class_name, base_workspace_dir, target_model_path, model_prefix, selectd_routes):
    target_cmd_full_path = base_workspace_dir + target_model_path
    pre_str = basename_to_class_name(model_prefix)
    # cmd_file_name = cmd_file_name
    # request_file_name = pre_str + request_file_name    
    # cmds = base.read_json(cmds_json_path) 
    cmd_class_name = basename_to_class_name(os.path.basename(target_cmd_full_path))
    selectd_responses = []
    cmds_fliter = []
    env = Environment(loader = FileSystemLoader('./template_dart'))
    for cmd_dict in cmds:
        cmd_dict['response_class_name'] = pre_str + filter_key(cmd_dict['response'])
        cmd_dict['response_data'] = pre_str + filter_key(cmd_dict['response'])
        cmd_dict['method_comment'] = env.get_template('dart_template_cmd_comment').render({ 'cmd_dict': cmd_dict, 'is_debug': is_debug })
        cmd_dict['method_name'] = env.get_template('dart_template_cmd_method_name').render({ 'cmd_dict': cmd_dict, 'is_debug': is_debug })
        if cmd_dict['pathKey'] in selectd_routes or (cmd_dict['route_prefix'] + cmd_dict['pathKey']) in selectd_routes or True:
            cmds_fliter.append(cmd_dict)
            if cmd_dict.get('response', '') != '': 
                selectd_responses.append(cmd_dict['response'])

    file_dir = os.path.dirname(target_cmd_full_path)
    os.makedirs(file_dir, exist_ok=True)
    with open(target_cmd_full_path, 'w', encoding='utf-8') as fout:
        render_content = env.get_template('dart_template_cmds').render({
            'is_debug': is_debug,
            "last_time": datetime.datetime.now().strftime('%Y-%m-%d'),
            'class_name': cmd_class_name,
            'class_name_request': request_class_name,
            'cmds': cmds_fliter, # cmds,
            'project_package': project_package,
        })
        fout.write(render_content)

    return selectd_responses
    pass

    # with open(os.path.join(dart_cmd_dir, request_file_name + '.h'), 'w', encoding='utf-8') as fout:
    #     fout.write(env.get_template('dart_template_request').render({ 'class_name': request_file_name, 'jsondart_h_path': jsondart_h_path }))
    # pass

def gen_dart_models(is_debug, responses, project_package, base_workspace_dir, entity_dir, g_entity_dir, target_model_path, model_prefix, selectd_responses_with_refs):
    target_model_full_path = base_workspace_dir + target_model_path
    entity_file_basename = '' + model_prefix + '_entity.dart'
    g_file_basename = '' + model_prefix + '_entity.g.dart'
    target_entity_full_path = base_workspace_dir + entity_dir + '/' + entity_file_basename
    target_g_full_path = base_workspace_dir + g_entity_dir + '/' + g_file_basename
    pre_str = basename_to_class_name(model_prefix)
    # responses = base.read_json(responses_json_path)
    # "TopicRecommendAddDto": {
    #     "properties": {
    #         "sourceId": {
    #             "type": "integer",
    #             "format": "int32",
    #             "description": "课程,商品,知识id"
    #         },
    #         "sourceType": {
    #             "type": "integer",
    #             "format": "int32",
    #             "description": "类型：1-> 课程；2-> 商品；3 -> 知识"
    #         },
    #         "topicId": {
    #             "type": "integer",
    #             "format": "int32",
    #             "description": "话题id"
    #         }
    #     }
    # },

    env = Environment(loader = FileSystemLoader('./template_dart'))
    all_classes = []
    render_contents_head = ''
    render_contents_head += '/// 此文件由 python 自动生成，请勿编辑'
    render_contents_head += '\n'
    render_contents_head += '/// Swagger的所有请求的或者接收的model, 用于http请求返回的json字符串转换'
    render_contents_head += '\n'
    render_contents_head += "/// 最后生成时间: {}".format(datetime.datetime.now().strftime('%Y-%m-%d'))
    render_contents_head += '\n'
    render_contents_head += '\n'

    render_entity_contents_head = ''
    render_entity_contents_head += '/// 此文件由 python 自动生成，请勿编辑'
    render_entity_contents_head += '\n'
    render_entity_contents_head += '/// Swagger的所有请求的或者接收的model, 用于http请求返回的json字符串转换'
    render_entity_contents_head += '\n'
    render_entity_contents_head += "/// 最后生成时间: {}".format(datetime.datetime.now().strftime('%Y-%m-%d'))
    render_entity_contents_head += '\n'
    render_entity_contents_head += '\n'
    render_entity_contents_head += "import 'package:{}/generated/json/base/json_field.dart';".format(project_package)
    render_entity_contents_head += '\n'
    render_entity_contents_head += "import 'package:{}/generated/json/{}';".format(project_package, g_file_basename)
    render_entity_contents_head += '\n'
    render_entity_contents_head += "import 'dart:convert';"
    render_entity_contents_head += '\n'

    render_g_contents_head = ''
    render_g_contents_head += '/// 此文件由 python 自动生成，请勿编辑'
    render_g_contents_head += '\n'
    render_g_contents_head += '/// Swagger的所有请求的或者接收的model, 用于http请求返回的json字符串转换'
    render_g_contents_head += '\n'
    render_g_contents_head += "/// 最后生成时间: {}".format(datetime.datetime.now().strftime('%Y-%m-%d'))
    render_g_contents_head += '\n'
    render_g_contents_head += '\n'
    render_g_contents_head += "import 'package:{}/generated/json/base/json_convert_content.dart';".format(project_package)
    render_g_contents_head += '\n'
    render_g_contents_head += "import 'package:{}/models/{}';".format(project_package, entity_file_basename)

    render_g_contents_head += '\n'

    # selectd_responses_map = []
    # for selectd_response in selectd_responses:
    #     selectd_responses_map.append(filter_key(selectd_response))
    #     pass

    render_contents_body = ''
    render_entity_contents_body = ''
    render_g_contents_body = ''

    print('44===============================')
    print(selectd_responses_with_refs)
    
    for responseKey in responses.keys():
        properties = responses[responseKey].get('properties', {})
        # if responseKey.find('«') >= 0 and responseKey.find('»') >= 0:
        #     continue 
        originResponseKey = responseKey + ''
        responseKey = filter_key(responseKey)

        is_in_selected = False

        # for a_selectd_response in selectd_responses_with_refs:
        #     if a_selectd_response.find(responseKey) >= 0:
        #         is_in_selected = True

        print('446=========================')
        print(originResponseKey)

        if originResponseKey in selectd_responses_with_refs:
            is_in_selected = True
            print(is_in_selected)

        if is_in_selected == False:
            continue

        # print(responseKey)
        # keys = lazy_pinyin(responseKey)
        # keys = list(map(lambda x:x[0].upper() + x[1:] , keys))
        class_name = responseKey # ''.join(keys)
        class_name = pre_str + class_name
        all_classes.append(class_name)
        # render_contents_head += 'class {};\n'.format(class_name)
        for propertiesKey in properties.keys():
            properties[propertiesKey]['refClass'] = ''
            if properties[propertiesKey].get('type', '') in ['array']:
                print(' ====================================== ' + class_name)
                print(propertiesKey)
                print(properties[propertiesKey])
                refStr = properties[propertiesKey].get('items', {}).get('$ref', '')
                typeStr = properties[propertiesKey].get('items', {}).get('type', '')
                if typeStr == 'string':
                    properties[propertiesKey]['refClassSingle'] = '{}'.format('String')
                    properties[propertiesKey]['refClass'] = 'List<{}>'.format('String')
                if typeStr == 'object':
                    properties[propertiesKey]['refClassSingle'] = '{}'.format('dynamic')
                    properties[propertiesKey]['refClass'] = 'List<{}>'.format('dynamic')
                elif typeStr == 'integer':
                    properties[propertiesKey]['refClassSingle'] = '{}'.format('int')
                    properties[propertiesKey]['refClass'] = 'List<{}>'.format('int')
                    formatStr = properties[propertiesKey].get('items', {}).get('format', '')
                    if formatStr == 'int64':
                        properties[propertiesKey]['refClassSingle'] = '{}'.format('int')
                        properties[propertiesKey]['refClass'] = 'List<{}>'.format('int')
                elif len(refStr) > 0:
                    refStrs = refStr.split('/')
                    refStr2 = refStrs[len(refStrs) - 1]
                    refStr2 = filter_key(refStr2)
                    properties[propertiesKey]['refClassSingle'] = '{}'.format(pre_str + refStr2)
                    properties[propertiesKey]['refClass'] = 'List<{}>'.format(pre_str + refStr2)
            if properties[propertiesKey].get('type', '') in ['object']:
                print('object2 ====================================== ' + class_name)
                print(propertiesKey)
                print(properties[propertiesKey])
                refStr = properties[propertiesKey].get('additionalProperties', {}).get('$ref', '')
                if len(refStr) > 0:
                    refStrs = refStr.split('/')
                    refStr2 = refStrs[len(refStrs) - 1]
                    refStr2 = filter_key(refStr2)
                    if refStr2 in ['Set']:
                        properties[propertiesKey]['refClassSingle'] = '{}'.format('')
                        properties[propertiesKey]['refClass'] = 'Set<String>'
                    else:
                        properties[propertiesKey]['refClassSingle'] = '{}'.format(pre_str + refStr2)
                        properties[propertiesKey]['refClass'] = pre_str + refStr2
                else:
                    properties[propertiesKey]['refClass'] = 'Map<String, String>'
            if properties[propertiesKey].get('type', '') in ['']:
                print(' ====================================== ' + class_name)
                print(propertiesKey)
                print(properties[propertiesKey])
                properties[propertiesKey]['type'] = ''
                refStr = properties[propertiesKey].get('$ref', '')
                if len(refStr) > 0:
                    refStrs = refStr.split('/')
                    refStr2 = refStrs[len(refStrs) - 1]
                    refStr2 = filter_key(refStr2)
                    properties[propertiesKey]['refClass'] = pre_str + refStr2
            # if 'CSFishingresultfunneldetailbo' == class_name:
            properties[propertiesKey]['realkey'] = propertiesKey
            if propertiesKey == 'id':
                properties[propertiesKey]['realkey'] = 'id'
            
        render_contents_body += env.get_template('dart_template_model_h').render({ 
            'class_name': class_name, 
            'origin': originResponseKey, 
            'properties': properties, 
            'is_debug': is_debug 
        })
        render_contents_body += '\n'

        render_entity_contents_body += env.get_template('dart_template_model_e').render({ 
            'class_name': class_name, 
            'origin': originResponseKey, 
            'properties': properties, 
            'is_debug': is_debug
         })
        render_entity_contents_body += '\n'

        render_g_contents_body += env.get_template('dart_template_model_g').render({ 
            'class_name': class_name, 
            'origin': originResponseKey, 
            'properties': properties, 
            'is_debug': is_debug
         })
        render_g_contents_body += '\n'


    all_model_class_name = basename_to_class_name(os.path.basename(target_model_path))

    render_contents_head += env.get_template('dart_template_model_all').render({ 'all_model_class_name': all_model_class_name, 'all_classes': all_classes, 'is_debug': is_debug })
    render_contents_head += '\n'

    render_contents_head += '\n'
    render_contents_body += '\n'

    render_entity_contents_head += '\n'
    render_entity_contents_body += '\n'

    render_g_contents_head += '\n'
    render_g_contents_body += '\n'

    # with open(target_model_full_path, 'w', encoding='utf-8') as fout:
    #     fout.write(render_contents_head + render_contents_body)
    # pass

    with open(target_entity_full_path, 'w', encoding='utf-8') as fout:
        fout.write(render_entity_contents_head + render_entity_contents_body)
    pass

    with open(target_g_full_path, 'w', encoding='utf-8') as fout:
        fout.write(render_g_contents_head + render_g_contents_body)
    pass

def gen_dart_json_conver(is_debug, project_package, base_workspace_dir, entity_dir, target_dir,  model_prefix):
    env = Environment(loader = FileSystemLoader('./template_dart'))
    files = os.listdir(base_workspace_dir + entity_dir)
    all_entity_dart_basenames = []
    all_class_entity_names = []
    for f in files:
        if f.endswith('_entity.dart') and f.find('._') < 0:
            print(f)
            all_entity_dart_basenames.append(f)
            full_f = base_workspace_dir + entity_dir + '/' + f
            text = base.read_text(full_f)
            text = get_filter_text(text)
            class_names = find_class_name(text)
            print(class_names)
            all_class_entity_names += class_names
            
    with open(base_workspace_dir + target_dir + '/json_convert_content.dart', 'w', encoding='utf-8') as fout:
        render_content = env.get_template('dart_template_json_convert').render({
          "all_entity_dart_basenames": all_entity_dart_basenames,
          "project_package": project_package,
          "all_class_entity_names": all_class_entity_names,
        })
        fout.write(render_content)
    pass


def get_filter_text(text):
    lines = text.split('\n')
    new_lines = []
    for line in lines:
        line = line.split('//')[0]
        new_lines.append(line)
    # res = re.findall(r"\/\*(\s|.)*?\*\/", text)
    # if len(res) > 0:
    #     print('res3')
    #     print(res)
    return ('\n').join(new_lines)

def find_class_name(text):
  text = text.replace('\r', '')
  text = text.replace('\n', '')
  text = text.replace('(', '')
  text = text.replace(')', '')
#   text = text.replace('\t', '')
  text = text.replace(' ', '')
  res = re.findall(r"@JsonSerializableclass(.+?){", text)
  # if len(res) > 0 and len(re.findall(r"//class(.+?)extendsAbsBase", text)) <= 0: 
  return res