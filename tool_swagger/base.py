#!/usr/bin/env python3
# coding: utf-8

import json

def read_json(json_path):
    f = open(json_path, 'r', encoding="utf-8")
    all_dicts = json.load(f)
    f.close()
    return all_dicts

def save_json(json_path, all_dicts):
    f = open(json_path, 'w', encoding="utf-8")
    json_str = json.dumps(all_dicts, indent=2, ensure_ascii=False, default=str)
    f.write(json_str)
    f.close()
    pass

def save_text(text_path, text):
    fos = open(text_path, "w", encoding="utf-8")
    fos.write(text)
    fos.close()
    pass

def read_text(text_path):
    fos = open(text_path, "r", encoding="utf-8")
    text = fos.read()
    fos.close()
    return text
