#include "types.h"
#include "stat.h"
#include "user.h"


char buf[512];
char word[16];

void 
wc(int fd, char *name){
    int i, n;
    int l=0;

    
    n = read(fd, buf, sizeof(buf));
    for(i=0; i<n; i++){
            
        if((buf[i]>='a' && buf[i]<='z') || (buf[i]>='A' && buf[i]<='Z')){
            word[l] = buf[i];
            l++;
        }else{
            word[l] = '\0';
            if(strcmp(word, "ping")==0){
                printf(1,"pong\n");
            }
            l=0;
        }
    }
       
}


int main(int argc, char *argv[]){
    
    int fd;

    fd = open(argv[1], 0);
    if(fd<0){
        printf(1, "COuldn't open file\n");
    }
    wc(fd, argv[1]);

    close(fd);
    exit();
}