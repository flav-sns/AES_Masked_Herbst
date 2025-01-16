# Nom des compilateurs
CC = gcc

# Options de compilation avec les bonnes pratiques de secure coding
CFLAGS = -Wall -Wextra -Werror -pedantic -std=c11 -O2 -D_FORTIFY_SOURCE=2 \
         -fstack-protector-strong -fPIE -fPIC -Wformat=2 -Wshadow -Wconversion \
         -Wstrict-prototypes -Wmissing-prototypes -Wpointer-arith -Wcast-align \
         -Wwrite-strings -Wredundant-decls -Wswitch-default -Wswitch-enum \
         -Wundef -Wlogical-op -Wfloat-equal -Winline -Wnested-externs \
         -Wunreachable-code -Wcast-qual

# Liens supplémentaires pour la sécurité
LDFLAGS = -Wl,-z,relro -Wl,-z,now -pie

# Librairies externes nécessaires (par exemple pour OpenSSL)
LDLIBS = -lcrypto

# Fichiers source
SRC_AES = aes.c
SRC_AES_MASKED = aes_masked.c

# Fichiers objets
OBJ_AES = $(SRC_AES:.c=.o)
OBJ_AES_MASKED = $(SRC_AES_MASKED:.c=.o)

# Exécutables générés
TARGET_AES = aes
TARGET_AES_MASKED = aes_masked

# Règles par défaut
all: $(TARGET_AES) $(TARGET_AES_MASKED)

# Compilation de l'exécutable aes
$(TARGET_AES): $(OBJ_AES)
	@$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS)

# Compilation de l'exécutable aes_masked
$(TARGET_AES_MASKED): $(OBJ_AES_MASKED)
	@$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS)

# Compilation des fichiers .o (générique)
%.o: %.c
	@$(CC) $(CFLAGS) -c $< -o $@

# Nettoyage des fichiers générés
clean:
	@rm -f $(OBJ_AES) $(OBJ_AES_MASKED) $(TARGET_AES) $(TARGET_AES_MASKED)

# Nettoyage complet (y compris les sauvegardes)
distclean: clean
	@rm -f *~ *.bak

# Ajout d'une cible pour vérifier les erreurs statiques avec static analyzers
check: $(SRC_AES) $(SRC_AES_MASKED)
	@cppcheck --enable=all --std=c11 --quiet $^
	@scan-build make

.PHONY: all clean distclean check
