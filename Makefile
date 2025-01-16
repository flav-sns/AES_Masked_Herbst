CC = gcc

CFLAGS = -Wall -Wextra -Werror -pedantic -std=c11 -O2 -D_FORTIFY_SOURCE=2 \
         -fstack-protector-strong -fPIE -fPIC -Wformat=2 -Wshadow -Wconversion \
         -Wstrict-prototypes -Wmissing-prototypes -Wpointer-arith -Wcast-align \
         -Wwrite-strings -Wredundant-decls -Wswitch-default -Wswitch-enum \
         -Wundef -Wlogical-op -Wfloat-equal -Winline -Wnested-externs \
         -Wunreachable-code -Wcast-qual

LDFLAGS = -Wl,-z,relro -Wl,-z,now -pie

LDLIBS = -lcrypto

SRC_AES = aes.c
SRC_AES_MASKED = aes_masked.c

OBJ_AES = $(SRC_AES:.c=.o)
OBJ_AES_MASKED = $(SRC_AES_MASKED:.c=.o)

TARGET_AES = aes
TARGET_AES_MASKED = aes_masked

all: $(TARGET_AES) $(TARGET_AES_MASKED)

$(TARGET_AES): $(OBJ_AES)
	@$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS)

$(TARGET_AES_MASKED): $(OBJ_AES_MASKED)
	@$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS)

%.o: %.c
	@$(CC) $(CFLAGS) -c $< -o $@

clean:
	@rm -f $(OBJ_AES) $(OBJ_AES_MASKED) $(TARGET_AES) $(TARGET_AES_MASKED)

distclean: clean
	@rm -f *~ *.bak

check: $(SRC_AES) $(SRC_AES_MASKED)
	@cppcheck --enable=all --std=c11 --quiet $^
	@scan-build make

.PHONY: all clean distclean check
