.PHONY: all clean web

RADIUS=1

all:  build/web/index.html


build/YellowMotorEncoder.kicad_pcb: 
	kikit panelize grid --space 2 --gridsize 4 2 --tabwidth 10 --tabheight 5 \
		--htabs 2 --vtabs 2 --radius 1 --mousebites 0.25 1 0.25 \
		hw/kicad_export/YellowMotorEncoder.kicad_pcb build/YellowMotorEncoder-panel.kicad_pcb


%-gerber: %.kicad_pcb
	kikit export gerber $< $@

%-gerber.zip: %-gerber
	zip -j $@ `find $<`

web: build/web/index.html

build:
	mkdir -p build

build/web: build
	mkdir -p build/web

build/web/index.html: build/web build/YellowMotorEncoder.kicad_pcb
	kikit present boardpage \
		-d README.md \
		--name "RB0003 YellowMotorEncoder" \
		-b "YellowMotorEncoder" " " hw/kicad_export/YellowMotorEncoder.kicad_pcb \
		-b "YellowMotorEncoder Panelized" " " build/YellowMotorEncoder-panel.kicad_pcb  \
		--repository 'https://github.com/RoboticsBrno/RB0003-YellowMotorEncoder' \
		build/web


clean:
	rm -r build