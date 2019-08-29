//
//  WLTTimeView.m
//  WLT优化game
//
//  Created by MS on 01-1-1.
//  Copyright (c) 2001年 MS. All rights reserved.
//

#import "WLTTimeView.h"
#import "WLTTime.h"
#import "Header.h"
#import "buttonView.h"
#import "WLTImage.h"
@interface WLTTimeView ()<UITableViewDataSource,UITableViewDelegate>{
    
    //
    UITableView * _tableView;
    
    //数据源
    NSMutableArray * _dataArray;
    
    //存储分组状态 是否展开
    
    NSMutableArray * _sectionStateArray;
    
   
    
  
}

@end

@implementation WLTTimeView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatData];
    
    
    [self creatTableView];

    

   

}
-(void)creatData{
    
    _dataArray = [[NSMutableArray alloc]init];
    
    _sectionStateArray = [[NSMutableArray alloc]init];
    
    WLTTime * time = [[WLTTime alloc]init];
    [time loadTime];
    for (int i = 0; i<time.timeArray.count; i++) {
        [_dataArray addObject:time.timeArray[i]];
        
        //将bool值转换成对象 其他的基本数据类型也可以通过这个方法来存储
        
        [_sectionStateArray addObject:@YES];

    }
    
        
   
    NSLog(@"%@",_dataArray);
    
    
    
    
    
}
-(void)creatTableView{
    
    
    _tableView  = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    
    
    _tableView.sectionFooterHeight= 0;
    
    _tableView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_tableView];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return _dataArray.count;
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if([_sectionStateArray[section] boolValue]){
        return 0;
        
    }
    return [_dataArray[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        //一般用UITableViewCellStyleSubtitle 带子标题的
        
    }
    //刷新数据
    NSDictionary * dict = _dataArray[indexPath.section][indexPath.row];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"通关用时：%@秒",[dict objectForKey:@"用时"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"日期：%@",[dict objectForKey:@"日期"]];
    
       
    
    return  cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
    
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //大小自动填充。。。。
    UIView * headView = [[UIView alloc]init];
    
    headView.layer.masksToBounds = YES;
    headView.layer.cornerRadius = 10;
    headView.layer.borderColor= [UIColor whiteColor].CGColor;
    headView.layer.borderWidth = 1;
    
    headView.backgroundColor = [UIColor colorWithRed:156/255.0f green:156/255.0f blue:156/255.0f alpha:1];
    
    UIButton * button  =  [[ UIButton alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
    
    
    
    UIImageView * upfold = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 40, 40)];

    WLTImage * unfoldArray = [WLTImage sharedWLTImage];
    [upfold setAnimationImages:unfoldArray.unfoladArray];
    [upfold setAnimationDuration:1];
    [upfold setAnimationRepeatCount:1];
    upfold.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"leida1" ofType:@"jpg"]];
   
    button.tag = 200+section;
    upfold.tag = 300+section;
    [upfold startAnimating];
    [button addTarget:self action:@selector(onclicked:) forControlEvents:UIControlEventTouchUpInside];
 
    [headView addSubview:upfold];
    [headView addSubview:button];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, 200,30)];
    
    NSMutableArray * array  = [[NSMutableArray alloc]init];
    for (int i = 0; i<=LEVEL; i++) {
        [array addObject:[NSString stringWithFormat:@"第%d关排行榜",i+1]];
        
    }
    
    label.text = array[section];
    
    [headView addSubview:label];
    
    return headView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
    
    
    
    
}
-(void)onclicked:(UIButton *)button{
   UIImageView * upfold = (id)[self.view viewWithTag:button.tag+100];
    
    [upfold startAnimating];
    if ([_sectionStateArray[button.tag-200] boolValue] ==YES) {
        
        //修改字典里的某一个值
        [_sectionStateArray replaceObjectAtIndex:button.tag-200 withObject:@NO];
        
    }else{
        
        [_sectionStateArray replaceObjectAtIndex:button.tag-200 withObject:@YES];
        
    }
    //重新调用所有source的方法
    // [_tableView reloadData];
    
    
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag-200] withRowAnimation:UITableViewRowAnimationTop];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com