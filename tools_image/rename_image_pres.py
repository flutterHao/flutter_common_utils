import os
from copy_svn_images import get_capitalize_file_name
from copy_svn_images import gen_r_file

# flutter_lib_shared
project_dir = 'C:/Users/fgc20/Documents/GitHub/flutter_bt_workspace/flutter_game_bt_app'
project_lib_dir = project_dir + '/lib'
image_dir = project_dir + '/assets/images'

to_replace_pres = [
  {
    'from': 'jingang_',
    'to': 'gangjin_',
  }
]

def read_text(text_path):
  fos = open(text_path, 'r', encoding="utf-8")
  text = fos.read()
  fos.close()
  return text

def save_text(text_path, text):
  fos = open(text_path, "w", encoding="utf-8")
  fos.write(text)
  fos.close()

def all_dart_files(dart_dir):
  total = 0
  all_paths = []
  list_dirs = os.walk(dart_dir)
  for root, dirs, files in list_dirs:
    for d in dirs:
      pass
    for f in files:
      if f.endswith('.dart') and f.find('._') < 0:
        full_path = os.path.join(root, f)
        all_paths.append(full_path)
        total += 1
  print('total dart files count: {}'.format(total))
  return all_paths
  pass


def rename_image_pres(project_lib_dir, image_dir, to_replace_pres):
  total = 0
  all_dart_full_files = all_dart_files(project_lib_dir)
  list_dirs = os.walk(image_dir)
  for root, dirs, files in list_dirs:
    for d in dirs:
      pass
    for f in files:
      if f.endswith('.png') and f.find('._') < 0:
        for to_replace_pre in to_replace_pres:
          from_str = to_replace_pre['from']
          to_str = to_replace_pre['to']
          if f.startswith(from_str):
            f_updated = f
            f_updated = f_updated.replace(from_str, to_str)
            full_path = os.path.join(root, f)
            full_path_update = os.path.join(root, f_updated)
            if full_path != full_path_update:
              from_text = 'R.' + get_capitalize_file_name(f)
              to_text = 'R.' + get_capitalize_file_name(f_updated)
              print('from: {}'.format(full_path))
              print('   to: {}'.format(full_path_update))
              print('   from_text: {}'.format(from_text))
              print('   to_text: {}'.format(to_text))
              total += 1
              os.rename(full_path, full_path_update)
              for a_dart_full_file in all_dart_full_files:
                text = read_text(a_dart_full_file)
                text = text.replace(from_text, to_text)
                save_text(a_dart_full_file, text)

  gen_r_file(image_dir)
  print('total: {}'.format(total))
  pass

if __name__ == '__main__':
  rename_image_pres(project_lib_dir, image_dir, to_replace_pres)
