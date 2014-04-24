#include <stdio.h>
#include <string.h>

void permute(char*, int, int);

void swap (char *x, char *y)
{
    char temp;
    temp = *x;
    *x = *y;
    *y = temp;
}

int main (void) {

    char A[]= "1234567890";
    printf("%s, %d\n",A, (int)strlen(A));
    permute(A, 0, ((int)strlen(A))-1);
    printf("DONE\n");
}

void permute(char* A, int left, int right) {
	int i;
	if (right==left){
		printf("%s\n",A);
	} else {
		for (i=left; i<=right; i++){
			swap((A+i), (A+left));
			permute(A, left+1,right);
			swap((A+i), (A+left));
		}
    
	}

}
