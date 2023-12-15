echo 'begin install'
echo 'begin packing ...'
pyinstaller -F gen_constant_and_factory_dart_file.py
echo 'copy exe file ...'
copy .\dist  .\
echo 'install end'
pause
