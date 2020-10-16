# This script is for converting new Kicad project 5.99 to old Kicad project 5.x.
# Script remove unsupported attributes.
# License: MIT
# Jaroslav Paral (github@jarekparal)

import re

new_kicad_file = '.\\hw\\kicad_export\\YellowMotorEncoder.kicad_pcb'

replace_list = [
    (r'\(paper "A4"\)', '(page A4)'),
    (r'\(clearance_min 0\)', ""),
    (r'\(through_hole_min \d+\.\d+\)', ""),
    (r'\(hole_to_hole_min \d+\.\d+\)', ""),
    (r'\(max_error \d+\.\d+\)', ""),
    (r'\(via_min_annulus \d+\.\d+\)', ""),
    (r'.*\(defaults\n(.*\n){14}', ""),
    (r" \(tstamp [0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}\)", "")
]

with open(new_kicad_file, 'r+') as f:
    file_source = f.read()

    for pattern, repl in replace_list:
        file_source = re.sub(pattern, repl, file_source, flags=re.MULTILINE)

    f.seek(0)
    write_file = f.write(file_source)
    f.truncate()