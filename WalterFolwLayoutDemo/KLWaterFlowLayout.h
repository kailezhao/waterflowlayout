//
//  KLWaterFlowLayout.h
//  WalterFolwLayoutDemo
//
//  Created by 赵凯乐 on 2018/3/28.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLWaterFlowLayout : UICollectionViewLayout
@property(nonatomic,assign)NSInteger colNumber;//列数
@property(nonatomic,assign)CGFloat colSpace;//列间距
@property(nonatomic,assign)CGFloat rowSpcae;//行间距
@property(nonatomic)UIEdgeInsets edgeinsets;//边缘间距

@property(nonatomic,strong)NSMutableArray *columnHeights;//每一列的高度数组
@property(nonatomic,strong)NSMutableArray<UICollectionViewLayoutAttributes*> *attrsArr;//存放所有的额cell的布局属性
@end
