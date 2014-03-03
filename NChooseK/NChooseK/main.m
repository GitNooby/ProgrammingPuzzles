

//IMPORTANT: algorithm found on geeksforgeeks.org

#import <Foundation/Foundation.h>

void combinationUtil(int arr[], int data[], int start, int end, int index, int r);

// The main function that prints all combinations of size r
// in arr[] of size n. This function mainly uses combinationUtil()
void printCombination(int arr[], int n, int r)
{
    // A temporary array to store all combination one by one
    int data[r];
    
    // Print all combination using temprary array 'data[]'
    combinationUtil(arr, data, 0, n-1, 0, r);
}

/* arr[]  ---> Input Array
 data[] ---> Temporary array to store current combination
 start & end ---> Staring and Ending indexes in arr[]
 index  ---> Current index in data[]
 r ---> Size of a combination to be printed */
void combinationUtil(int arr[], int data[], int start, int end, int index, int r)
{
    // Current combination is ready to be printed, print it
    if (index == r)
    {
        for (int j=0; j<r; j++)
            printf("%d ", data[j]);
        printf("\n");
        return;
    }
    
    // replace index with all possible elements. The condition
    // "end-i+1 >= r-index" makes sure that including one element
    // at index will make a combination with remaining elements
    // at remaining positions
    for (int i=start; i<=end && end-i+1 >= r-index; i++)
    {
        data[index] = arr[i];
        combinationUtil(arr, data, i+1, end, index+1, r);
    }
}

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        int N = 5;
        int K = 4;
        
        assert(K<=N);
        
//        NSMutableArray *inputSet = [[NSMutableArray alloc] init];
//        for (int i=0; i<N; i++) {
//            NSNumber *anElement = [NSNumber numberWithInt:i];
//            [inputSet addObject:anElement];
//        }
        
//        findCombinations(inputSet, N, K);
        
        int input[] = {1,2,3,4,5};
        
        printCombination(input, N, K);
        
        
//        for (int i=0; i<chosenSets.count; i++) {
//            NSMutableArray *aChosenSet = [chosenSets objectAtIndex:i];
//            printf("set:%d ", i);
//            for (int j=0; j<aChosenSet.count; j++) {
//                printf("%d ", [[aChosenSet objectAtIndex:j] intValue]);
//            }
//            printf("\n");
//        }
        
    }
    return 0;
}

