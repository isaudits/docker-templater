# templater-server

Docker implementation of Templater Server. 

https://templater.info/

https://github.com/ngs-doo/TemplaterExamples/tree/master/Advanced/TemplaterServer

## Usage

Launch docker container:

    docker run -p 7777:7777 -it --rm isaudits/templater-server

Once the docker container has started, REST API can be consumed by calling:

    PUT http://localhost:7777/pdf?file=name.ext

There are several options which can be passed to server during startup. One of them is to use a special path for temporary files:

    docker run -p 7777:7777 --tmpfs /mnt/ramdisk -it --rm isaudits/templater-server -tmp=/mnt/ramdisk -log=INFO

The demo license file is built into the image. To pass your own valid license file, use a volume mount:

    docker run -p 7777:7777 -v /path/to/templater.lic:/opt/templater/templater.lic -it --rm isaudits/templater-server

Full instructions for usage can be found at https://github.com/ngs-doo/TemplaterExamples/tree/master/Advanced/TemplaterServer