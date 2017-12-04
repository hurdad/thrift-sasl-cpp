CXX = g++ 
CXXFLAGS = -fPIC -Wall -Wextra -O3 -std=c++0x
LDFLAGS = -shared  
RM = rm -f
TARGET_SHARED = libthrift-sasl.so
TARGET_STATIC = libthrift-sasl.a

SRCS = TSasl.cpp TSaslTransport.cpp TSaslClientTransport.cpp TSaslServerTransport.cpp 
OBJS = $(SRCS:.cpp=.o)

PREFIX := /usr/local

.PHONY: all
all: $(TARGET_SHARED) $(TARGET_STATIC)

$(TARGET_SHARED): $(OBJS)
	$(CXX) ${LDFLAGS} -o $@ $^
	
$(TARGET_STATIC): $(OBJS)
	 ar rcs -o $@ $^

.PHONY: clean
clean:
	-$(RM) $(TARGET_LIB) $(OBJS)

.PHONY: install
install: $(TARGET_LIB) $(TARGET_STATIC)
	mkdir -p $(DESTDIR)$(PREFIX)/lib64
	mkdir -p $(DESTDIR)$(PREFIX)/include/thrift/transport
	cp $(TARGET_SHARED) $(DESTDIR)$(PREFIX)/lib64/
	cp $(TARGET_STATIC) $(DESTDIR)$(PREFIX)/lib64/
	cp *.h $(DESTDIR)$(PREFIX)/include/thrift/transport/
	