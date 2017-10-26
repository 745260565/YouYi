//
//  EDCryptoUtil.m
//  eDrive
//
//  Created by harbin6666 on 15/5/12.
//  Copyright (c) 2015年 carbit. All rights reserved.
//
#include <stdio.h>
#import "EDCryptoUtil.h"
#define MAXLEN 1024
//static  char chars[]= {
//    '4', 'W', 'T', '6', 'J', '0', '=',
//    'u', 'G', 'O', 'H', '7', 'r', '2', 'e', 't', 'w', '9', 'F',
//    'l', 'Z', '5', '/', 'U', 'Q', 'X', 'q', 'j', 'f', 'P', 'S', 'h', 'R',
//    'o', 'N', 'i',
//    'B', 'n', 'Y', 'y', 'a', 'c', 'b', 'D', 'K', 'C', '8', '1',
//    'E', '3', 'k', 'd', 'm', 'v', 'M', 'z', 'p', '+', 's', 'I', 'V', 'x',
//    'A', 'g', 'L'
//};
//

static const int SPECIAL_CHAR=102;
@implementation EDCryptoUtil

+(NSString*)encodeData:(NSData*)data{
    if (data==nil) {
        return nil;
    }
    
    static NSArray*charsArray;
    if (charsArray==nil) {
        charsArray=@[@"4",@"W",@"T",@"6",@"J",@"0",@"=",@"u",@"G",@"O",@"H",@"7",@"r",@"2",@"e",@"t",@"w",@"9",@"F",@"l",@"Z",@"5",@"/",@"U",@"Q",@"X",@"q",@"j",@"f",@"P",@"S",@"h",@"R",@"o",@"N",@"i",@"B",@"n",@"Y",@"y",@"a",@"c",@"b",@"D",@"K",@"C",@"8",@"1",@"E",@"3",@"k",@"d",@"m",@"v",@"M",@"z",@"p",@"+",@"s",@"I",@"V",@"x",@"A",@"g",@"L"];
    }

    NSMutableString *result=@"".mutableCopy;
    Byte *testByte = (Byte *)[data bytes];
    int c1,c2,c3;
    int i;
    int loop=ceil(data.length/3);
    for(i=0;i<loop;i++){

        c1 = (int)testByte[3*i];
        c2 = (int)testByte[3*i+1];
        c3 = (int)testByte[3*i+2];
        
        int t=((c1^SPECIAL_CHAR) & 252)>>2;
        
        [result appendString:charsArray[t]];
        
        t=((((c1 ^ SPECIAL_CHAR) & 3) << 4)|((c2 &240)>>4));
        
        [result appendString:charsArray[t]];

        t=(((c2 & 15) << 2) | ((c3 & 192) >> 6));
        
        [result appendString:charsArray[t]];

        t=(char)(c3 & 63);
        
        [result appendString:charsArray[t]];

    }

    switch (data.length%3) {
        case 1:
        {
            c1 = testByte[3*i];
            int t=((c1^SPECIAL_CHAR) & 252)>>2;
            [result appendString:charsArray[t]];
            

            t=(((c1 ^ SPECIAL_CHAR) & 3) << 4);
            [result appendString:charsArray[t]];
            

            [result appendString:charsArray[64]];
            [result appendString:charsArray[64]];

        }
            break;
            
        case 2:
            c1 = testByte[3*i];
            c2 = testByte[3*i+1];
            int t=((c1^SPECIAL_CHAR) & 252)>>2;
            [result appendString:charsArray[t]];
            

            t=((((c1 ^ SPECIAL_CHAR) & 3) << 4)|((c2 &240)>>4));
            [result appendString:charsArray[t]];
            

            t=((c2 & 15) << 2);
            [result appendString:charsArray[t]];
            

            [result appendString:charsArray[64]];
            break;
        default:
            break;
    }
//    NSLog(@"%@",result);
    return result ;
}

+(NSString*)encodeString:(NSString*)string{
    NSData *temp=[string dataUsingEncoding:NSUTF8StringEncoding];
    return [self encodeData:temp];
}

+(NSString*)encodeDictionary:(NSDictionary*)jsonDic {
    NSError *error=nil;
    NSData* tempData=[NSJSONSerialization dataWithJSONObject:jsonDic options:0 error:&error];
//    NSLog(@"$$$$$$$加密的内容%@",[[NSString alloc] initWithData:tempData encoding:NSUTF8StringEncoding]);
    if (error) {
        return nil;
    }
    return [self encodeData:tempData];
}

+(NSData*)encodeDic:(NSDictionary*)jsonDic{
    if (jsonDic==nil) {
        jsonDic=[NSMutableDictionary dictionary];
    }
    NSString *string=[self encodeDictionary:jsonDic ];
   return  [string dataUsingEncoding:NSUTF8StringEncoding];
}
/*
 public static String encode(String plainText){
 byte[] data = plainText.getBytes();
 StringBuilder sb = new StringBuilder();
 int i;
 byte c1, c2, c3;
 for (i=0; i<=(data.length - 3); i+=3){
 c1 = data[i];
 c2 = data[i+1];
 c3 = data[i+2];
 sb.append(chars[((c1 ^ SPECIAL_CHAR) & 252) >> 2]);
 sb.append(chars[(((c1 ^ SPECIAL_CHAR) & 3) << 4) | ((c2 &240) >> 4)]);
 sb.append(chars[((c2 & 15) << 2) | ((c3 & 192) >> 6)]);
 sb.append(chars[c3 & 63]);
 }
 
 switch (data.length%3) {
 case 1:
 c1 = data[i];
 sb.append(chars[((c1 ^ SPECIAL_CHAR) & 252) >> 2]);
 sb.append(chars[((c1 ^ SPECIAL_CHAR) & 3) << 4]);
 sb.append(chars[64]);
 sb.append(chars[64]);
 break;
 
 case 2:
 c1 = data[i];
 c2 = data[i+1];
 sb.append(chars[((c1 ^ SPECIAL_CHAR) & 252) >> 2]);
 sb.append(chars[(((c1 ^ SPECIAL_CHAR) & 3) << 4) | ((c2
 & 240) >> 4)]);
 sb.append(chars[(c2 & 15) << 2]);
 sb.append(chars[64]);
 break;
 default:
 break;
 }
 
 return sb.toString();
 }

 */
@end
