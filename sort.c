#include<stdio.h>
#include <unistd.h> 
#include<sys/types.h>
void childProcess(int arr[]);
void ParentProcess(int arr[],int n);
void displayArray(int arr[5]);
int main()
{
	int arr[5]={10,12,5,6,20};
	
	pid_t pid;
	pid=fork();
	if(pid==0)
	{
		displayArray(arr);
		childProcess(arr);
	}		
	else
	{
		wait(NULL);
		ParentProcess(arr,5);
	}	
	return 0;
}

void childProcess(int arr[5])
{
	printf("\nBubble sort in child process :\n");
	for(int i=0;i<5;i++)
	{
		for(int j=0;j<5-i-1;j++)
		{
			if(arr[j]>arr[j+1])
			{
				int temp=arr[j];
				arr[j]=arr[j+1];
				arr[j+1]=temp;
			}
		}		
	}	
	
	for(int i=0;i<5;i++)
	{
		
		printf("%d  ",arr[i]);
	}
}

void displayArray(int arr[5])
{
	for(int i=0;i<5;i++)
	{
		printf("%d  ",arr[i]);
	}
	
	printf("\n");
}
void ParentProcess(int arr[], int n)
{
	printf("\ninsertion sort in parent process :\n");
 	for(int i = 1; i < n; i++) 
 	{
      	  int key = arr[i];
          int j = i - 1;
          while(j >= 0 && arr[j] > key) 
          {
          	  arr[j + 1] = arr[j];
          	  j--;
       	  }
          arr[j + 1] = key;
        }
        
        for(int i=0;i<5;i++)
	{
		printf("%d  ",arr[i]);
	}
}


