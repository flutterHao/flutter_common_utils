#!/usr/bin/env python3
# coding: utf-8

from genericpath import isdir
import os
from posixpath import dirname
import shutil
import sys
import json
import getopt
import yaml

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

svn_images_infos = config_dict['svn_images']['infos']
base_workspace_dir = config_dict['svn_images']['base_workspace_dir']
project_base_dir = os.getcwd()

all_file_names = []

# def rename():
  # base_folder = os.path.join(os.getcwd(), '_input')
  # print ("base_folders[]: ", base_folder)
  # for base_folder in base_folder:
  # rename_file(base_folder)

# def rename_file(base_folder):
#   list_dirs = os.walk(base_folder)
#   for root, dirs, files in list_dirs:
#     for d in dirs:
#       pass
#     for f in files:
#       # print(os.path.join(root, f))
#       source_fullname = os.path.join(root, f)
#       ext_names = ['.png']
#       for ext_name in ext_names:
#         if f.find(ext_name) > 0 and f.find('._') < 0:
#             updated_name = f
#             updated_name = updated_name.lower()
#             updated_name = updated_name.replace('-', '_')
#             updated_name = updated_name.replace(' ', '_')
#             updated_name = updated_name.split('@')[0] + ext_name
#             fullname = os.path.join(root, f)
#             updated_fullname = os.path.join(root, updated_name)
#             updated_fullname = updated_fullname.replace('_input', '_output')
#             # print(updated_fullname)
#             output_dir = os.path.dirname(updated_fullname)
#             print(output_dir)
#             os.makedirs(output_dir, exist_ok=True)
#             shutil.copy(source_fullname, updated_fullname)

def get_target_nameame(source_name, prefix):
  ext_name = source_name.split('.')[1]
  target_name = source_name
  target_name = target_name.lower()
  target_name = target_name.replace('%', 'percent')
  target_name = target_name.replace('￥', 'yuan')
  target_name = target_name.replace('$', 'dollar')
  if target_name.endswith('_1.png'):
    target_name = target_name.replace('_1.png', '.png')
  elif target_name.endswith('_2.png'):
    target_name = target_name.replace('_2.png', '.png')
  elif target_name.endswith('_3.png'):
    target_name = target_name.replace('_3.png', '.png')
  elif target_name.endswith('_4.png'):
    target_name = target_name.replace('_4.png', '.png')
  target_name = target_name.replace('-', '_')
  target_name = target_name.replace(' ', '_')
  while target_name.find('__') >= 0:
    target_name = target_name.replace('__', '_')
  target_name = target_name.split('@')[0]
  target_name = target_name.split('.')[0]
  target_name = target_name + '.' + ext_name
  while target_name.find('_.{}'.format(ext_name)) >= 0:
    target_name = target_name.replace('_.{}'.format(ext_name), '.{}'.format(ext_name))
  target_name = prefix + target_name
  # print(target_name)
  return target_name

def copy_dir_files(svn_images_dir, project_image_dir, base_workspace_dir, prefix):
  list_dirs = os.walk(svn_images_dir)
  for root, dirs, files in list_dirs:
    for d in dirs:
      pass
    for f in files:
      if f.endswith('.png') and f.find('._') < 0:
        source_fullname = os.path.join(root, f)
        updated_f = get_target_nameame(f, prefix)
        dirname_foler = os.path.basename(os.path.dirname(source_fullname))
        all_file_names.append(
          {
            'file_name': f,
            'dir_folder': os.path.basename(os.path.dirname(root))
          }
        )
        # print(dirname_foler)
        # full_inner_image_dir = os.path.dirname(os.getcwd()) + inner_image_dir
        # full_inner_image_dir = full_inner_image_dir.replace('/', '\\')
        full_project_image_dir = base_workspace_dir + project_image_dir
        # print(full_inner_image_dir)
        # print(os.path.exists(full_inner_image_dir))
        dirname_foler = dirname_foler.lower()
        if dirname_foler.find('1') >= 0 and dirname_foler.find('x') >= 0:
          full_project_image_dir = os.path.join(full_project_image_dir, '')
        if dirname_foler.find('2') >= 0 and dirname_foler.find('x') >= 0:
          full_project_image_dir = os.path.join(full_project_image_dir, '2.0x')
        if dirname_foler.find('3') >= 0 and dirname_foler.find('x') >= 0:
          full_project_image_dir = os.path.join(full_project_image_dir, '3.0x')
        if dirname_foler.find('4') >= 0 and dirname_foler.find('x') >= 0:
          full_project_image_dir = os.path.join(full_project_image_dir, '4.0x')
        os.makedirs(full_project_image_dir, exist_ok=True)
        updated_fullname = os.path.join(full_project_image_dir, updated_f)
        shutil.copy(source_fullname, updated_fullname)
        print('                from: {} to: {}'.format(source_fullname, updated_fullname))
  pass

def get_capitalize_file_name(png_file):
  ext_name = png_file.split('.')[1]
  png_file_name_only = png_file.replace('.' + ext_name, '')
  print(' png_file_name_only: ' + png_file_name_only)
  png_file_names = png_file_name_only.split('_')
  full_name = ''
  for index, png_file_name in enumerate(png_file_names):
    if index == 0:
      full_name += png_file_name[0].lower() + png_file_name[1:]
    else:
      full_name += png_file_name[0].capitalize() + png_file_name[1:]
  return full_name
  pass

def gen_r_file(project_image_full_dir):
  print('============== gen r file')
  # f = open('../pubspec.yaml', 'r', encoding='utf-8')
  # cfg = f.read()
  # d = yaml.safe_load(cfg)
  # print(d['flutter_assets_generator'])
  # flutter_assets_generator = d['flutter_assets_generator']
  class_name = 'R' # fluter_assets_generator['class_name']
  output_filename = 'r' # flutter_assets_generator['output_filename']
  output_dir = 'generated' # flutter_assets_generator['output_dir']

  print(project_image_full_dir)
  png_files = sorted(list(os.listdir(project_image_full_dir)), key=lambda x:x, reverse=False)
  png_files = list(filter(lambda x: os.path.isfile(project_image_full_dir + '/' + x), png_files))
  print(png_files)
  project_full_dir = project_image_full_dir
  project_full_dir = os.path.dirname(project_full_dir)
  project_full_dir = os.path.dirname(project_full_dir)
  print(project_full_dir)
  with open(project_full_dir + '/lib/{}/{}.dart'.format(output_dir, output_filename), 'w', encoding="utf-8") as fout:
    render_content = ''
    render_content += '///This file is automatically generated. DO NOT EDIT, all your changes would be lost.\n'
    render_content += "class R {\n"
    render_content += '  R._();\n'
    render_content += '\n'
    for png_file in png_files:
      full_name = get_capitalize_file_name(png_file)
      render_content += "  static const String {} = 'assets/images/{}';\n".format(full_name, png_file)
    render_content += '\n'
    render_content += '}'
    fout.write(render_content)
  pass

if __name__ == '__main__':
  argv = sys.argv[1:]
  print('argv2')
  print(argv)
  try:
      opts, args = getopt.getopt(argv, ":r",[])
      print('opts, args2')
      print(opts)
      print(args)
  except getopt.GetoptError:
      # sys.exit(2)
      pass

  is_gen_r = False
  for opt, arg in opts: 
    if opt == '-r':
      is_gen_r = True
  
  # if is_gen_r == False:
  for svn_images_info in svn_images_infos:
    svn_images_dir = svn_images_info['svn_images_dir']
    project_image_dir = svn_images_info['project_image_dir']
    prefix = svn_images_info['prefix']
    #
    if is_gen_r == True:
      print('gen r')
      project_image_full_dir = base_workspace_dir + project_image_dir
      gen_r_file(project_image_full_dir)
    else:
      #
      #
      is_svn_images_dir_correct = False
      if os.path.exists(svn_images_dir):
        next_dirs = list(filter(lambda x: os.path.isdir(os.path.join(svn_images_dir, x)), os.listdir(svn_images_dir)))
        next_dirs_str = ','.join(next_dirs).lower()
        # print(next_dirs_str)
        if next_dirs_str.find('1') >= 0 and next_dirs_str.find('2') >= 0 and next_dirs_str.find('3') >= 0 and next_dirs_str.find('x') >= 0:
          is_svn_images_dir_correct = True
        if is_svn_images_dir_correct == True:
          copy_dir_files(svn_images_dir, project_image_dir, base_workspace_dir, prefix)
        else:
          print('*********************************** 该文件夹不含@1 @2 @3子目录: {}'.format(svn_images_dir))
      else:
        print('*********************************** 该文件夹不存在: {}'.format(svn_images_dir))




  # print(all_file_names)
  # print(len(all_file_names))
  # all_exist_names = []
  # all_exist_dict = {}
  # for all_file_name in all_file_names:
  #   all_exist_dict[all_file_name['file_name']] = all_file_name['dir_folder']
  #   if all_file_name['file_name'] not in all_exist_names:
  #     all_exist_names.append(all_file_name['file_name'])
  #   else:
  #     print('{} exist, folder: '.format(all_file_name['file_name']), all_file_name['dir_folder'])
  # # print(len(all_exist_names))
  # print(len(list(all_exist_dict.keys())))
