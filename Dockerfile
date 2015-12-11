FROM echocat/nano

MAINTAINER "echocat" contact@echocat.org

ADD images/rootfs.tar.gz /

EXPOSE 27017 27018 27019 28017

CMD [ "mongod", \
	"--dbpath", "/var/mongodb/db" \
]
