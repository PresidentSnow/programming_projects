#include <iostream>
#include <string>
using namespace std;

// Code from tutorialspoint

class Vig 
{
    public:
        string k;
    Vig(string k)
    {
        for (int i = 0; i < k.size(); ++i)
        {
            if (k[i] >= 'A' && k[i] <= 'Z')
                this->k += k[i];
            else if (k[i] >= 'a' && k[i] <= 'z')
                this->k += k[i] + 'A' - 'a';
        }
    }

    string encryption(string t)
    {
        string output;
            for (int i = 0, j = 0; i < t.length(); ++i)
            {
            char c = t[i];
                if (c >= 'a' && c <= 'z')
                    c += 'A' - 'a';
                else if (c < 'A' || c > 'Z')
                    continue;
                //added 'A' to bring it in range of ASCII alphabet [ 65-90 | A-Z ]
                output += (c + k[j] - 2 * 'A') % 26 + 'A';
                j = (j + 1) % k.length();
            }
            return output;
    }

    string decryption(string t)
    {
        string output;
        for (int i = 0, j = 0; i < t.length(); ++i)
        {
            char c = t[i];
            if (c >= 'a' && c <= 'z')
                c += 'A' - 'a';
            else if (c < 'A' || c > 'Z')
                continue;
            //added 'A' to bring it in range of ASCII alphabet [ 65-90 | A-Z ]
            output += (c - k[j] + 26) % 26 + 'A';
            j = (j + 1) % k.length();
        }
        return output;
    }
};

int main()
{
    Vig v("OCHO");
    std::string ori ="Thisistutorialspoint";
    std::string encrypt = v.encryption(ori);
    std::string decrypt = v.decryption(encrypt);
    std::cout << "Original Message: "<< ori << std::endl;
    std::cout << "Encrypted Message: " << encrypt << std::endl;
    std::cout << "Decrypted Message: " << decrypt << std::endl;
}