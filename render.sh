#!/bin/bash

# Usage instructions
usage() {
    echo "Usage: $0 <blend_file> <output_directory> [-s start_frame] [-e end_frame]"
    exit 1
}

# Require at least two arguments (blend file and output directory)
if [ "$#" -lt 2 ]; then
    usage
fi

# Assign required arguments
BLEND_FILE="$1"
OUTPUT_DIR="$2"
shift 2

# Initialize frame options as empty
START_FRAME=""
END_FRAME=""

# Parse additional options for start and end frames
while [ "$#" -gt 0 ]; do
    case "$1" in
        -s)
            START_FRAME="-s $2"
            shift 2
            ;;
        -e)
            END_FRAME="-e $2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

# Execute the Blender command
./blender --background "$BLEND_FILE" --python-expr \
"import bpy; prefs = bpy.context.preferences.addons['cycles'].preferences; \
[setattr(d, 'use', False) for d in prefs.devices if 'CPU' in d.name]; \
bpy.ops.wm.save_userpref();" \
-E CYCLES -o "$OUTPUT_DIR/img" -F PNG $START_FRAME $END_FRAME -a
