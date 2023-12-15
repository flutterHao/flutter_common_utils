import os
import re
import shutil
import sys
import json
import datetime
from jinja2 import Environment, FileSystemLoader

config_path = 'config.json'
config_dict = {}
try:
    f = open(config_path, 'r', encoding="utf-8")
    config_dict = json.load(f)
    f.close()
except:
    print('    读取失败: ' + config_path)
    sys.exit()
    pass

constant_infos = config_dict['constant']['infos']
factory_infos = config_dict['widget_factory']['infos']
workspace_base_dir = os.path.dirname(os.getcwd())
constant_output_path = '_output/constant'
factory_output_path = '_output/widget_factory'
env = Environment(loader = FileSystemLoader('./template_dart'))

def find_class_name(text):
  text = text.replace('\r', '')
  text = text.replace('\n', '')
  text = text.replace(' ', '')
  res = re.findall(r"class(.+?)extendsAbsBase", text)
  # if len(res) > 0 and len(re.findall(r"//class(.+?)extendsAbsBase", text)) <= 0:
  if len(res) > 0: 
    return res[0]
  return '' 

def find_files(base_folder, end_str=''):
  all_dart_files = []
  list_dirs = os.walk(base_folder)
  for root, dirs, files in list_dirs:
    for d in dirs:
      pass
    for f in files:
      if f.find('._') < 0 and f.endswith('{}.dart'.format(end_str)):
        full_path = os.path.join(root, f)
        all_dart_files.append(full_path)
      pass
  return all_dart_files

def find_class_names(app_dir, end_str=''):
  all_app_files = find_files(app_dir, end_str)
  # print(all_app_files)
  all_class_names = []
  for app_file in all_app_files:
    f = open(app_file, 'r', encoding="utf-8")
    text = f.read()
    f.close()
    pass
    a_class_name = find_class_name(text)
    if len(a_class_name) > 0:
      all_class_names.append({
        'class_name': a_class_name,
        'file_path': app_file
      })
  all_class_names = sorted(all_class_names, key=lambda x:x['class_name'], reverse=False)
  return all_class_names
  pass

def find_all_class_names(widget_source_dir):
  #app
  # app_dir = os.path.join(widget_source_dir, 'app')
  # all_app_class_names = find_class_names(app_dir)
  # # print(all_app_class_names)
  # #tab
  # tab_dir = os.path.join(widget_source_dir, 'tab')
  # all_tab_class_names = find_class_names(tab_dir, '_tab')
  # # print(all_tab_class_names)
  # #page
  # page_dir = os.path.join(widget_source_dir, 'page')
  # all_page_class_names = find_class_names(page_dir, '_page')
  # print(all_page_class_names)
  #component
  component_dir = os.path.join(widget_source_dir, '')
  all_component_class_names = find_class_names(component_dir, '')
  # print(all_component_class_names)

  all_dict = {}
  all_dict['app'] = [] # all_app_class_names
  all_dict['tab'] = [] # all_tab_class_names
  all_dict['page'] = [] # all_page_class_names
  all_dict['component'] = all_component_class_names
  return all_dict
  pass

def gen_constant_file(widget_source_dir, constant_target_path):
  all_dict = find_all_class_names(widget_source_dir)
  all_app_class_names = all_dict['app']
  all_tab_class_names = all_dict['tab']
  all_page_class_names = all_dict['page']
  all_component_class_names = all_dict['component']

  #component
  component_text = ''
  all_components_str = ''
  for (index_of_component, component_class_name) in enumerate(all_component_class_names):
    component_text += '''  static const c{} = '{}';\n'''.format(component_class_name['class_name'], component_class_name['class_name'])
    all_components_str += "'{}'".format(component_class_name['class_name'])
    if index_of_component < len(all_component_class_names) - 1:
      all_components_str += ', '
    else:
      all_components_str += ''

  #page
  page_text = ''
  all_pages_str = ''
  for (index_of_page, page_class_name) in enumerate(all_page_class_names):
    page_text += '''  static const c{} = '{}';\n'''.format(page_class_name['class_name'], page_class_name['class_name'])
    all_pages_str += "'{}'".format(page_class_name['class_name'])
    if index_of_page < len(all_page_class_names) - 1:
      all_pages_str += ', '
    else:
      all_pages_str += ''

  #tab
  tab_text = ''
  all_tabs_str = ''
  for (index_of_tab, tab_class_name) in enumerate(all_tab_class_names):
    tab_text += '''  static const c{} = '{}';\n'''.format(tab_class_name['class_name'], tab_class_name['class_name'])
    all_tabs_str += "'{}'".format(tab_class_name['class_name'])
    if index_of_tab < len(all_tab_class_names) - 1:
      all_tabs_str += ', '
    else:
      all_tabs_str += ''
  
  #app
  app_text = ''
  all_apps_str =''
  for (index_of_app, app_class_name) in enumerate(all_app_class_names):
    app_text += '''  static const c{} = '{}';\n'''.format(app_class_name['class_name'], app_class_name['class_name'])
    all_apps_str += "'{}'".format(app_class_name['class_name'])
    if index_of_app < len(all_app_class_names) - 1:
      all_apps_str += ', '
    else:
      all_apps_str += ''

  with open(constant_output_path, 'w', encoding="utf-8") as fout:
      render_content = env.get_template('dart_template_constant').render({ 
        'app_text': app_text,
        'tab_text': tab_text,
        'page_text': page_text,
        'component_text': component_text,
        'all_apps_str': all_apps_str,
        'all_tabs_str': all_tabs_str,
        'all_pages_str': all_pages_str,
        'all_components_str': all_components_str,
        "last_time": datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
      })
      fout.write(render_content)
  # print(all_sheet_names)
  pass

  print(constant_output_path, constant_target_path)
  shutil.copy(constant_output_path, constant_target_path)

def gen_widget_factory_file(widget_source_dir, factory_info, widget_factory_target_path):
  all_dict = find_all_class_names(widget_source_dir)
  all_app_class_names = all_dict['app']
  all_tab_class_names = all_dict['tab']
  all_page_class_names = all_dict['page']
  all_component_class_names = all_dict['component']
  component_special_params = factory_info['component_special_params']
  component_special_params_keys = list(component_special_params.keys())
  all_component_special_params = []
  for a_params in component_special_params.values():
    all_component_special_params += a_params
  all_component_special_params = list(set(all_component_special_params))
  all_component_special_params = sorted(all_component_special_params, key=lambda x:x, reverse=False)
  print(component_special_params_keys)
  print(all_component_special_params)
  component_special_params_str = ''
  if len(all_component_special_params) > 0:
    component_special_params_str = ', {' + ', '.join(all_component_special_params) + '}'
  
  #
  packages_str = ''
  replace_str = os.path.dirname(os.getcwd())
  print(replace_str)
  for (index_of_app, app_class_name) in enumerate(all_app_class_names):
    packages_str += '''
import 'package:{}';'''.format(app_class_name['file_path']).replace(replace_str, '').replace('\\', '/').replace('package:/lib/', 'package:flutter_lib_shared/')

  for (index_of_tab, tab_class_name) in enumerate(all_tab_class_names):
    packages_str += '''
import 'package:{}';'''.format(tab_class_name['file_path']).replace(replace_str, '').replace('\\', '/').replace('package:/lib/', 'package:flutter_lib_shared/')

  for (index_of_page, page_class_name) in enumerate(all_page_class_names):
    packages_str += '''
import 'package:{}';'''.format(page_class_name['file_path']).replace(replace_str, '').replace('\\', '/').replace('package:/lib/', 'package:flutter_lib_shared/')

  for (index_of_component, component_class_name) in enumerate(all_component_class_names):
    packages_str += '''
import 'package:{}';'''.format(component_class_name['file_path']).replace(replace_str, '').replace('\\', '/').replace('package:/lib/', 'package:flutter_lib_shared/')

##
  app_case_str = ''
  for (index_of_app, app_class_name) in enumerate(all_app_class_names):
    app_case_str +=  '''
      case '{}': return {}(key: Key(key),);'''.format(app_class_name['class_name'], app_class_name['class_name'])

  tab_case_str = ''
  for (index_of_tab, tab_class_name) in enumerate(all_tab_class_names):
    tab_case_str +=  '''
      case '{}': return {}(key: Key(key),);'''.format(tab_class_name['class_name'], tab_class_name['class_name'])

  page_case_str = ''
  for (index_of_page, page_class_name) in enumerate(all_page_class_names):
    page_case_str +=  '''
      case '{}': return {}(key: Key(key),);'''.format(page_class_name['class_name'], page_class_name['class_name'])

  component_case_str = ''
  for (index_of_component, component_class_name) in enumerate(all_component_class_names):
    ext_params_str = ''
    if component_class_name['class_name'] in component_special_params_keys:
      params = component_special_params[component_class_name['class_name']]
      params = map(lambda x: x + ': ' + x, params)
      ext_params_str += "" + ', '.join(params) + ""
      pass
    component_case_str +=  '''
      case '{}': return {}(key: Key(key), extParams: extParams,{});'''.format(component_class_name['class_name'], component_class_name['class_name'], " " + ext_params_str)

##

  with open(factory_output_path, 'w', encoding="utf-8") as fout:
      render_content = env.get_template('dart_template_widget_factory').render({ 
        'packages_str': packages_str,
        'app_case_str': app_case_str,
        'tab_case_str': tab_case_str,
        'page_case_str': page_case_str,
        'component_case_str': component_case_str,
        'component_special_params_str': component_special_params_str,
        "last_time": datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
      })
      fout.write(render_content)
  pass

  shutil.copy(factory_output_path, widget_factory_target_path)

def parse_constant_infos():
  for constant_info in constant_infos:
    #
    widget_source_dir = constant_info['widget_source_dir']
    widget_source_dir = widget_source_dir.replace('\\', '/')
    widget_source_dirs = widget_source_dir.split('/')
    a_base_dir = workspace_base_dir
    for a_widget_source_dir in widget_source_dirs:
      if len(a_widget_source_dir) > 0:
        widget_source_dir = os.path.join(a_base_dir, a_widget_source_dir)
        a_base_dir = widget_source_dir
    print('widget_source_dir: {}'.format(widget_source_dir))
    #
    constant_target_path = constant_info['constant_target_path']
    constant_target_path = constant_target_path.replace('\\', '/')
    constant_target_paths = constant_target_path.split('/')
    a_base_dir = workspace_base_dir
    for a_constant_target_path in constant_target_paths:
      if len(a_constant_target_path) > 0:
        constant_target_path = os.path.join(a_base_dir, a_constant_target_path)
        a_base_dir = constant_target_path
    print('constant_target_path: {}'.format(constant_target_path))
    gen_constant_file(widget_source_dir, constant_target_path)

def parse_factory_infos():
  for factory_info in factory_infos:
    #
    widget_source_dir = factory_info['widget_source_dir']
    widget_source_dir = widget_source_dir.replace('\\', '/')
    widget_source_dirs = widget_source_dir.split('/')
    a_base_dir = workspace_base_dir
    for a_widget_source_dir in widget_source_dirs:
      if len(a_widget_source_dir) > 0:
        widget_source_dir = os.path.join(a_base_dir, a_widget_source_dir)
        a_base_dir = widget_source_dir
    print('widget_source_dir: {}'.format(widget_source_dir))
    #
    widget_factory_target_path = factory_info['widget_factory_target_path']
    widget_factory_target_path = widget_factory_target_path.replace('\\', '/')
    widget_factory_target_paths = widget_factory_target_path.split('/')
    a_base_dir = workspace_base_dir
    for a_widget_factory_target_path in widget_factory_target_paths:
      if len(a_widget_factory_target_path) > 0:
        widget_factory_target_path = os.path.join(a_base_dir, a_widget_factory_target_path)
        a_base_dir = widget_factory_target_path
    print('widget_factory_target_path: {}'.format(widget_factory_target_path))
    gen_widget_factory_file(widget_source_dir, factory_info, widget_factory_target_path)


if __name__ == '__main__':
  parse_constant_infos()
  parse_factory_infos()

