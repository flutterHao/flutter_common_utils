import os
import hashlib

workspace_base_dir = os.getcwd()
workspace_base_dir = os.path.dirname(workspace_base_dir)
workspace_base_dir = os.path.dirname(workspace_base_dir)

def find_not_exist_x_images(base_assets_image_dir):
  if os.path.exists(base_assets_image_dir):
    pass
  else:
    print('   base_assets_image_dir not exist: {}'.format(base_assets_image_dir))
    return
  pass
  png_files = os.listdir(base_assets_image_dir)
  png_files = sorted(png_files, key=lambda x:x, reverse=False)
  png_files = list(filter(lambda x: x.find('.png') > 0 and x.find('._') < 0 and os.path.isfile(os.path.join(base_assets_image_dir, x)), png_files))
  # print(png_files)
  print('total: {}'.format(len(png_files)))
  base_assets_image_dir_2x = os.path.join(base_assets_image_dir, '2.0x')
  base_assets_image_dir_3x = os.path.join(base_assets_image_dir, '3.0x')
  base_assets_image_dir_4x = os.path.join(base_assets_image_dir, '4.0x')
  for png_file in png_files:
    check_str = '==== checking --> {}   '.format(png_file)
    # print(check_str)
    not_exist_str = ''
    png_file_2x = os.path.join(base_assets_image_dir_2x, png_file)
    png_file_3x = os.path.join(base_assets_image_dir_3x, png_file)
    png_file_4x = os.path.join(base_assets_image_dir_4x, png_file)
    if not os.path.exists(png_file_2x):
      not_exist_str += ' 2x'
    if not os.path.exists(png_file_3x):
      not_exist_str += ' 3x'
    # if not os.path.exists(png_file_4x):
    #   not_exist_str += ' 4x'
    if len(not_exist_str) == 0:
      print(check_str + ' true')
    else:
      print(check_str + ' not exist: {}'.format(not_exist_str))
  pass

def check_images_md5(base_assets_image_dir, base_svn_images_dir):
  if os.path.exists(base_assets_image_dir):
    pass
  else:
    print('   base_assets_image_dir not exist: {}'.format(base_assets_image_dir))
    return
  pass

  md5_dict = all_svn_images(base_svn_images_dir)
  # print(md5_dict)
  png_files = os.listdir(base_assets_image_dir)
  png_files = sorted(png_files, key=lambda x:x, reverse=False)
  png_files = list(filter(lambda x: x.find('.png') > 0 and x.find('._') < 0 and os.path.isfile(os.path.join(base_assets_image_dir, x)), png_files))
  # print(png_files)
  print('total: {}'.format(len(png_files)))
  for png_file in png_files:
    png_full_file_path = os.path.join(base_assets_image_dir, png_file)
    # print(png_full_file_path)
    file = open(png_full_file_path, "rb")
    md = hashlib.md5()
    md.update(file.read())
    res1 = md.hexdigest()
    file.close()
    # print('{}: {}'.format(png_file, res1))
    if md5_dict.get(res1, {}).get('md5', '') == res1:
      print('{} dir: {}'.format(png_file, md5_dict[res1].get('dir', 'not_found')))
      pass
    else:
      print('{} not found in svn'.format(png_file))
      pass
  pass
  pass


def all_svn_images(base_svn_images_dir):
  list_dirs = os.walk(base_svn_images_dir)
  md5_dict = {}
  for root, dirs, files in list_dirs:
    for d in dirs:
      pass
    for f in files:
      if (f.find('.png') > 0) and f.find('._') < 0:
        png_full_path = os.path.join(root, f)
        # print(png_full_path)
        file = open(png_full_path, "rb")
        md = hashlib.md5()
        md.update(file.read())
        res1 = md.hexdigest()
        file.close()
        if res1 in md5_dict.keys():
          print('exist png, {}, {}'.format(md5_dict[res1]['full_path'].replace(base_svn_images_dir, ''), png_full_path).replace(base_svn_images_dir, ''))
          pass
        folder_basename = os.path.basename(root).lower()
        # print(folder_basename)
        xx = ''
        if folder_basename.find('1') >= 0 and folder_basename.find('x') >= 0:
          xx = '1x'
        if folder_basename.find('2') >= 0 and folder_basename.find('x') >= 0:
          xx = '2x'
        if folder_basename.find('3') >= 0 and folder_basename.find('x') >= 0:
          xx = '3x'
        if folder_basename.find('4') >= 0 and folder_basename.find('x') >= 0:
          xx = '4x'
        md5_dict[res1] = {
          'md5': res1,
          'name': f,
          'full_path': png_full_path,
          'dir': png_full_path.replace(base_svn_images_dir, ''),
          'xx': xx
        }
        # print(md5_dict[res1]['xx'])
  return md5_dict


if __name__ == '__main__':
  # flutter_game_bt_app flutter_lib_shared
  base_assets_image_dir = os.path.join(workspace_base_dir, 'flutter_lib_shared', 'assets', 'images')
  base_svn_images_dir = 'C:/Users/fgc20/Documents/svn_flutter_bt_all'
  # print(base_assets_image_dir)
  # find_not_exist_x_images(base_assets_image_dir)
  # check_images_md5(base_assets_image_dir, base_svn_images_dir)
  all_svn_images(base_svn_images_dir)
