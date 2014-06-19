
#include <iostream>
#include <string>
#include <map>
using namespace std;

string inputText = "epqllqwdlwbykocvsqtsnjeqqliahylvmcslbwosukwbslhcokgcbtakhblkbveldput\
qyfpxpaapfxkwplsbjudzbhcmjysftsasvxvnhbnmipcqicvmnxqubcietgpumnaxavb\
gdipeucjmdaukgbmamiekdkjwkdmlgojkcaxnjyklbsmgeabquaqmrpseqoouvpsmmbo\
spyhmmjeaaerwvgjpvsqtbaiebchsmwqvyijknxdtrfxrgmewkphuvkrtjgsosvwldcn\
qisbacyplqjytyblwyzlqdjpxbpnnayuodaigpdguungltsaqgwilmtfuyrnnuujyaae\
sgaltcgpykdorkpydzkatfndcblbjbuncnqjjudzpwtemdjpnzadxoqusjdjjouawmes\
ojirrkoomlgpyydgkyxonobrijfofopoxcadgbtpwandcjpaklmkvlqjhympujtbtfym\
lyrfjdhkalugohcixrzwspqmsirrlyvoftjjnicgloqfinmunytdqrycxolxllqqdpds\
nnluzhcywwiumdxhrxjpgylxmtjkeowonxgtekptnleekpfmkfoanurrotftloiaywhw\
lqxefamsalapzrjuotvaynspyenczlopvmbimagdcixriytkipcfvsppzcdwcadgpkhr\
zdgxfmcvorguolgjviibsnigyhmjboajqxzuqrgpzechqhgngcyfoobtlnmkfzoxhuei\
mgsptlexvvuhfdmegbuirrngiefhgyzdcucqxkfrvaxykdndpxersucoqpqtahxvswht\
mwqafucubejjpynuucuqfklnngoafuzggunqgrrtuixtyfuljrnwokaerhekwbnjpjqb\
gencsjtfszmtiybligkwifuavbsmqoqqkkbeosghvrftgbpaxbpzxpcvyjlagwwrfvta\
twmbuapxbhofpxxbzgyl_____ffi___afjpi___qykh___sio___dagx____tnd____c\
at_fy_qgddfyiypiiiqmabpbexhaofov_uefemr_xsa_lgp_veetxo_oajyru_ls_ewp\
_cycgbs_sedfac_r_lenseuhprocpgklrjlpvwoqvaea___zyfs_fen_fhr_v__zbh_c\
zpbly___qsaa___fhvd___qkpd__oqvkeneszrpkjcrucigowcmetfbn_fdmifc_saz_\
iyv_va_von_fsilun_tf_llk_rdjglz_lfdjwk_m_cbagzushwiiqixchnoorfvltnxm\
_nchmhxw___haftt___lyyl___alf_li_xrt____vqv____hjm_eh_mgdlfsuqnegwvy\
jefkmgffaonmupbqdhgfasrffdlndmelfwstdbcoisozhtbrnrldmbuyvtyocdrwlhtm\
egniftgifoljginhrvhesbgnlwttsdaqqshamqnuiiyqtkmczhcrllcwgsspysdqdpod\
rvrewgsmjovunolxyxpwcxiwxnotiemsdqbusffobjuufgmnvaywuqqokuutnosrmvmg\
cmbksdnkwpcrkxnhcvrhnhryrvvrqhqxeixsmitiqbploahtakfqggtwyhxmtrksmewu\
egxmfjbwgyroemxsrmhhbnldmrtfsolawmvvbgyasbjlxmacavnwrgsrfiocxaaesvim\
uiehcblbjxpggikimmobldipfqxtaejgagsiiminvivbecrvjjfyqdkjielocukivfzg\
zwgxfdjlhvpudivussnvktwlqfelvtlemgcfnchnnuzugxxckdcvksumhbzgcrxwrdne\
gqbrkbzxilwundnmzrfoxstxkwebesibbkpxrpeeahfcwhqhethioteqdvaxhptccfjo\
cnlyxihurkfgudwtypcktmatunrwclsdrgegsfbjlzxvqfilnodrxxjoqfgnmrkbkkkh\
jfvmhlsrgocispfunezqmhayljyluwbdeszntbaomobfhkncwwdtygfflyvfpmnubyld\
wcxwbcrkmbofiilpcwmnigajibdpwwxxvvvwkuufbreoitfiksxqmvqthtjrjbhljwwh\
ydrleyssfjtrqbqyjauwrpesgjuwopvfptniodmatfmfaspihclcdxhekgngaidsdali\
fajjjedkomkwcohimgvfiauqtmokmapbzjnrqgaacnvecnnuonrjosrvrivcifinkchd\
zlbkohihzrqjphjwifjwumzymdhnctsqtorwldbuicsahhkgeyvuzdtowdmdzrueknee\
uashzcxz";

int main(int argc, const char * argv[])
{
    
    string letters = "abcdefghijklmnopqrstuvwxyz_";
    
    int buckets[27] = {0};
    
    for (int i=0; i<inputText.length(); i++) {
        char c = inputText.at(i);
        int index = 26;
        if (c == '_') {
            index = 26;
        } else if ('a' <= c && c <= 'z') {
            index = c - 'a';
        }
        buckets[index]++;
    }
    
    // print out the buckets just to see if number of occurence is unique
    // if they are unique, then lets just use a hashmap to sort
//    for (int i=0; i<27; i++) {
//        cout << buckets[i] << endl;
//    }
    
    map<int, char> aMap;
    
    const char *str = letters.c_str();
    
    for (int i=0; i<27; i++) {
        aMap.emplace(buckets[i], str[i]);
    }
    
    for (map<int, char>::reverse_iterator iter = aMap.rbegin(); iter != aMap.rend(); ++iter)
    {
        if (iter->second == '_') {
            break;
        }
        cout << iter->second;
    }
    cout << endl;
    
    
    return 0;
}

