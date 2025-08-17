#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[]){
    // char *com = argv[1];
    // argv[argc] = "\0
    int pid = fork();
    if(pid<0){
        printf(1, "child process\n");
        exit();
    }else if(pid == 0){
        exec(argv[1], argv+1);
        printf(1,"Exec failed");
        exit();
    }else{
        wait();
    }
    exit();
}