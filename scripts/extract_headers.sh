#!/bin/bash

rsync -a -m -R --include '*/' --include '*.h' --include '*.inc' --exclude '*' ../../godot-master ./bin/extracted_headers
