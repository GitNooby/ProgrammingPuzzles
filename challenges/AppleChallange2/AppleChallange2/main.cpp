
#include <iostream>
#include <vector>
#include <sstream>
#include <algorithm>

using namespace std;

inline std::vector<std::string> &split(const std::string &str, char delimiter, std::vector<std::string> &elements) {
    std::string item;
    std::stringstream strStream(str);
    while (std::getline(strStream, item, delimiter)) {
        elements.push_back(item);
    }
    return elements;
}

inline std::vector<std::string> split(const std::string &str, char delimiter) {
    std::vector<std::string> elements;
    split(str, delimiter, elements);
    return elements;
}


int main(int argc, const char * argv[])
{
    string inputString1;
    getline(cin, inputString1);
    vector<string> inputStringArray1 = split(inputString1, ',');
    
    string inputString2;
    getline(cin, inputString2);
    vector<string> inputStringArray2 = split(inputString2, ',');
    
    vector<int> inputArray1;
    for (int i=0; i<inputStringArray1.size(); i++) {
        int anInt = atoi(inputStringArray1[i].c_str());
        inputArray1.push_back(anInt);
    }
    
    vector<int> inputArray2;
    for (int i=0; i<inputStringArray2.size(); i++) {
        int anInt = atoi(inputStringArray2[i].c_str());
        inputArray2.push_back(anInt);
    }
    
    // sort and unique first array
//    sort(inputArray1.begin(), inputArray1.end());
//    inputArray1.erase(unique(inputArray1.begin(), inputArray1.end()), inputArray1.end());
//    for (int i=0; i<inputArray1.size(); i++) {
//        cout << inputArray1[i] << endl;
//    }
    
    // 1. determine the duplicate in array 2, if not a duplicate, then add to output from array1
    vector<int> outputArray;
    for (int i=0; i<inputArray1.size(); i++) {
        int firstInt = inputArray1[i];
        bool duplicateInArray2 = false;
        
        for (int j=0; j<inputArray2.size(); j++) {
            int secondInt = inputArray2[j];
            if (firstInt == secondInt) {
                duplicateInArray2 = true;
                break;
            }
        }
        
        if (duplicateInArray2 == false) {
            outputArray.push_back(firstInt);
        }
    }
    
    
    string outputString = "";
    for (int i=0; i<outputArray.size(); i++) {
        string aNumberStr = to_string(outputArray[i]);
        outputString += aNumberStr;
        if (i < outputArray.size()-1) {
            outputString += ",";
        }
    }
    cout << outputString << endl;
    
    return 0;
}

