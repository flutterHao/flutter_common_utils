import os
import hashlib
from check_images import all_svn_images

imported_images = []

if __name__ == '__main__':
  base_svn_images_dir = 'C:/Users/fgc20/Documents/svn_flutter_bt_all'
  md5_dict = all_svn_images(base_svn_images_dir)
  print('================== check imported')
  notfount_counter = 0
  for imported_image in imported_images:
    file = open(imported_image, "rb")
    md = hashlib.md5()
    md.update(file.read())
    res1 = md.hexdigest()
    file.close()
    base_name = os.path.basename(imported_image)
    # print('------------ checking')
    if md5_dict.get(res1, {}).get('md5', '') == res1:
      print(' {} dir: {}'.format(base_name, md5_dict[res1].get('dir', 'not_found')))
      pass
    else:
      # print(' {} not found in svn'.format(base_name))
      notfount_counter += 1
      pass
    pass

  print(' not found: {}'.format(notfount_counter))