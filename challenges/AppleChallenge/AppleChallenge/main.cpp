

#include <iostream>
#include <vector>
#include <sstream>
#include <algorithm>
#include <climits>


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

bool isOdd(int number) {
    if (number == 0) {
        return false;
    } else if (number < 0) {
        return false;
        number *= -1;
        return (number % 2 == 1);
    }
    return (number % 2 == 1);
}

int main(int argc, const char * argv[])
{

    string input;
    getline(cin, input);
    vector<string> inputNumbers = split(input, ',');
    
    int maxOddInts[3] = {INT_MIN, INT_MIN, INT_MIN};
    unsigned int numOddFound = 0;
    
    vector<int> intArray;
    for (int i=0; i<inputNumbers.size(); i++) {
//        cout << inputNumbers[i] << endl;
        int anInt = atoi(inputNumbers[i].c_str());
        if (isOdd(anInt) == true) {
            intArray.push_back(anInt);
        }
    }
    
    sort(intArray.begin(), intArray.end());
    
    for (int i=0; i<intArray.size(); i++) {
        int anInt = intArray[i];
        if (isOdd(anInt) == true) {
            numOddFound++;
            if (anInt >= maxOddInts[0]) {
                maxOddInts[2] = maxOddInts[1];
                maxOddInts[1] = maxOddInts[0];
                maxOddInts[0] = anInt;
            }
        }
    }
    
    int sum = 0;
    if (numOddFound >= 3) {
        sum = maxOddInts[0] + maxOddInts[1] + maxOddInts[2];
    } else if (numOddFound == 2) {
        sum = maxOddInts[0] + maxOddInts[1];
    } else if (numOddFound == 1) {
        sum = maxOddInts[0];
    } else if (numOddFound == 0) {
        sum = 0;
    }
    
    cout << sum << endl;
    
    return 0;
}

