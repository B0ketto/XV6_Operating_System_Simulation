#include "types.h"
#include "user.h"

int main(){
	while(1){
		char buff[1024];
		printf(1, ">>>");
		read(0, buff, 1024);
		write(1, buff, 1024);
		}
	exit();
}
