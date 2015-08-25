SRC_WINDOWS=https://github.com/arduino/Arduino/blob/ide-1.0.x/build/windows/avr_tools.zip?raw=true
SRC_LINUX32=https://github.com/arduino/Arduino/blob/ide-1.0.x/build/linux/avr_tools_linux32.tar.bz2?raw=true
SRC_LINUX64=https://github.com/arduino/Arduino/blob/ide-1.0.x/build/linux/avr_tools_linux64.tar.bz2?raw=true
SRC_OSX=https://github.com/arduino/Arduino/blob/ide-1.0.x/build/macosx/dist/tools-universal.zip?raw=true
SRC_ARM=http://mirrordirector.raspbian.org/raspbian/pool/main/g/gcc-avr/gcc-avr_4.7.2-2_armhf.deb


build:

install: install-${DEB_HOST_ARCH}

install-linux-amd64:
	echo "Downloading compiler archive..."
	wget -q -c -O avr-tools-linux64.tar.bz2 https://github.com/arduino/Arduino/blob/ide-1.0.x/build/linux/avr_tools_linux64.tar.bz2?raw=true
	mkdir -p tmp
	echo "Extracting compiler archive..."
	tar -C tmp -jxf avr-tools-linux64.tar.bz2
	mkdir -p ${DESTDIR}/compilers/avr-gcc
	mv tmp/tools/avr/* ${DESTDIR}/compilers/avr-gcc/
	cp config/compiler.txt ${DESTDIR}/compilers/avr-gcc/compiler.txt
	rm -rf tmp

install-linux-i386:
	echo "Downloading compiler archive..."
	wget -q -c -O avr-tools-linux32.tar.bz2 https://github.com/arduino/Arduino/blob/ide-1.0.x/build/linux/avr_tools_linux32.tar.bz2?raw=true
	mkdir -p tmp
	echo "Extracting compiler archive..."
	tar -C tmp -jxf avr-tools-linux32.tar.bz2
	mkdir -p ${DESTDIR}/compilers/avr-gcc
	mv tmp/tools/avr/* ${DESTDIR}/compilers/avr-gcc/
	cp config/compiler.txt ${DESTDIR}/compilers/avr-gcc/compiler.txt
	rm -rf tmp

install-windows-amd64:
	echo "Downloading compiler archive..."
	wget -q -c -O avr-tools-windows.zip https://github.com/arduino/Arduino/blob/ide-1.0.x/build/windows/avr_tools.zip?raw=true
	mkdir -p tmp
	echo "Extracting compiler archive..."
	unzip -qq -d tmp avr-tools-windows.zip
	mkdir -p ${DESTDIR}/compilers/avr-gcc
	find tmp -name '*.exe' -exec chmod 755 '{}' \+
	mv tmp/tools/avr/* ${DESTDIR}/compilers/avr-gcc/
	cp config/compiler.txt ${DESTDIR}/compilers/avr-gcc/compiler.txt
	rm -rf tmp

install-windows-i386:
	echo "Downloading compiler archive..."
	wget -q -c -O avr-tools-windows.zip https://github.com/arduino/Arduino/blob/ide-1.0.x/build/windows/avr_tools.zip?raw=true
	mkdir -p tmp
	echo "Extracting compiler archive..."
	unzip -qq -d tmp avr-tools-windows.zip
	mkdir -p ${DESTDIR}/compilers/avr-gcc
	find tmp -name '*.exe' -exec chmod 755 '{}' \+
	mv tmp/tools/avr/* ${DESTDIR}/compilers/avr-gcc/
	cp config/compiler.txt ${DESTDIR}/compilers/avr-gcc/compiler.txt
	rm -rf tmp

install-darwin-amd64:
	echo "Downloading compiler archive..."
	wget -q -c -O avr-tools-darwin.zip https://github.com/arduino/Arduino/blob/ide-1.0.x/build/macosx/dist/tools-universal.zip?raw=true
	mkdir -p tmp
	echo "Extracting compiler archive..."
	unzip -qq -d tmp avr-tools-darwin.zip
	mkdir -p ${DESTDIR}/compilers/avr-gcc
	mv tmp/tools/avr/* ${DESTDIR}/compilers/avr-gcc/
	cp config/compiler.txt ${DESTDIR}/compilers/avr-gcc/compiler.txt
	rm -rf tmp

install-linux-armhf:
	mkdir -p tmp
	echo "Downloading compiler archive..."
	wget -q -c http://mirrordirector.raspbian.org/raspbian/pool/main/g/gcc-avr/gcc-avr_4.7.2-2_armhf.deb
	wget -q -c http://mirrordirector.raspbian.org/raspbian/pool/main/b/binutils-avr/binutils-avr_2.20.1-3_armhf.deb
	wget -q -c http://mirrordirector.raspbian.org/raspbian/pool/main/a/avr-libc/avr-libc_1.8.0-2_all.deb
	dpkg-deb --extract gcc-avr_4.7.2-2_armhf.deb tmp
	dpkg-deb --extract binutils-avr_2.20.1-3_armhf.deb tmp
	dpkg-deb --extract avr-libc_1.8.0-2_all.deb tmp
	mkdir -p ${DESTDIR}/compilers/avr-gcc
	mv tmp/usr/* ${DESTDIR}/compilers/avr-gcc/
	cp config/compiler.txt ${DESTDIR}/compilers/avr-gcc/compiler.txt
	rm -rf tmp

install-linux-armel: install-linux-armhf
