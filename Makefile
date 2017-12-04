CXX = g++ 
CXXFLAGS = -fPIC -Wall -Wextra -O3 -std=c++0x
LDFLAGS = -shared  
RM = rm -f
TARGET_LIB = libthrift-sasl.so 

SRCS = TSasl.cpp TSaslTransport.cpp TSaslClientTransport.cpp TSaslServerTransport.cpp 
OBJS = $(SRCS:.cpp=.o)

PREFIX	:= /usr/local

.PHONY: all
all: ${TARGET_LIB}

$(TARGET_LIB): $(OBJS)
	$(CXX) ${LDFLAGS} -o $@ $^

.PHONY: clean
clean:
	-${RM} ${TARGET_LIB} ${OBJS} $(SRCS:.cpp=.d)

.PHONY: install
install: $(TARGET_LIB)
	mkdir -p $(DESTDIR)$(PREFIX)/lib64
	mkdir -p $(DESTDIR)$(PREFIX)/include/thrift/transport
	cp $(TARGET_LIB) $(DESTDIR)$(PREFIX)/lib64/
	cp *.h $(DESTDIR)$(PREFIX)/include/thrift/transport/