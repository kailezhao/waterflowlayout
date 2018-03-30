//
//  ViewController.m
//  WalterFolwLayoutDemo
//
//  Created by 赵凯乐 on 2018/3/28.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "ViewController.h"
#import "KLWaterFlowLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)KLWaterFlowLayout *flowlayout;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.collectionView];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 50;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
    cell.backgroundColor = [UIColor orangeColor];
    }else if(indexPath.section == 1){
        cell.backgroundColor = [UIColor purpleColor];
    }else{
        cell.backgroundColor = [UIColor blueColor];
    }
    
    UILabel *lab = [self.collectionView viewWithTag:100];
    if (lab==nil) {
        lab  = [[UILabel alloc]init];
        lab.frame = CGRectMake(0, cell.bounds.size.height-20, cell.bounds.size.width, 20);
        lab.tag = 100;
        lab.font = [UIFont systemFontOfSize:13];
        [cell addSubview:lab];
    }
    lab.text = [NSString stringWithFormat:@"%ld--%ld",indexPath.section,indexPath.row];
    
    return cell;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:self.flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor greenColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return _collectionView;
}
-(KLWaterFlowLayout *)flowlayout{
    if (!_flowlayout) {
        _flowlayout = [[KLWaterFlowLayout alloc]init];
        _flowlayout.colNumber = 5;
        _flowlayout.edgeinsets = UIEdgeInsetsMake(20, 20, 20, 20);
    }
    return _flowlayout;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
