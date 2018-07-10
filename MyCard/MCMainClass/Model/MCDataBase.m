//
//  MCDataBase.m
//  MyCard
//
//  Created by caohouhong on 2018/7/9.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCDataBase.h"
#import "FMDB.h"

#import "MCModel.h"

static MCDataBase *dataBase = nil;

@interface MCDataBase()<NSCopying,NSMutableCopying>{
    FMDatabase  *_db;
}

@end

@implementation MCDataBase

+(instancetype)sharedDataBase{
    
    if (dataBase == nil) {
        
        dataBase = [[MCDataBase alloc] init];
        
        [dataBase mc_initDataBase];
        
    }
    
    return dataBase;
    
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (dataBase == nil) {
        
        dataBase = [super allocWithZone:zone];
        
    }
    
    return dataBase;
    
}

-(id)copy{
    
    return self;
    
}

-(id)mutableCopy{
    
    return self;
    
}

-(id)copyWithZone:(NSZone *)zone{
    
    return self;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    
    return self;
}

-(void)mc_initDataBase{
    // 获得Documents目录路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 文件路径
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"mcmodel.sqlite"];
    
    // 实例化FMDataBase对象
    _db = [FMDatabase databaseWithPath:filePath];
    
    [_db open];
    
    NSString *recordSql = @"CREATE TABLE 'mcmodel' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'r_id' VARCHAR(255), 'type' VARCHAR(255), 'name' VARCHAR(255), 'numbers' VARCHAR(255), 'remarks' VARCHAR(255), 'addTime' VARCHAR(255))";
    
    [_db executeUpdate:recordSql];
    [_db close];
}
#pragma mark - MCModel
- (void)addMCModel:(MCModel *)model{
    [_db open];
    
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM mcmodel "];
    //获取数据库中最大的ID
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"r_id"] integerValue]) {
            maxID = @([[res stringForColumn:@"r_id"] integerValue] ) ;
        }
    }
    maxID = @([maxID integerValue] + 1);
    
    [_db executeUpdate:@"INSERT INTO mcmodel (r_id,type,name,numbers,remarks,addTime) VALUES (?,?,?,?,?,?)",
     maxID,model.type,model.name,model.numbers,model.remarks,model.addTime];
    
    [_db close];
}

- (NSMutableArray *)getAllModel{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM mcmodel ORDER BY type DESC"];
    
    while ([res next]) {
        MCModel *record = [[MCModel alloc] init];
        record.r_id = @([[res stringForColumn:@"r_id"] integerValue]);
        record.type = [res stringForColumn:@"type"];
        record.name = [res stringForColumn:@"name"];
        record.numbers = [res stringForColumn:@"numbers"];
        record.remarks = [res stringForColumn:@"remarks"];
        record.addTime = [res stringForColumn:@"addTime"];
        [dataArray addObject:record];
    }
    [_db close];
    
    return dataArray;
}

- (void)deleteModel:(MCModel *)model{
    [_db open];
    [_db executeUpdate:@"DELETE FROM mcmodel WHERE addTime = ?",model.addTime];
    [_db close];
}

- (void)deleteAllModel{
    [_db open];
    [_db executeUpdate:@"DELETE FROM mcmodel"];
    [_db close];
}
@end
