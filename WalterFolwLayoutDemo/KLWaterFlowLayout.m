//
//  KLWaterFlowLayout.m
//  WalterFolwLayoutDemo
//
//  Created by 赵凯乐 on 2018/3/28.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLWaterFlowLayout.h"

@implementation KLWaterFlowLayout

-(void)prepareLayout{
    [super prepareLayout];
    NSLog(@"prepareLayout");
    _rowSpcae = _rowSpcae?_rowSpcae : 10;//行间距
    _colSpace = _colSpace?_colSpace : 10;//列间距
    _colNumber = _colNumber?_colNumber : 2;//列数
    
    [self.attrsArr removeAllObjects];
    [self.columnHeights removeAllObjects];
    
    //当列高度数组为空时，即为第一行计算，每一列的基础高度加上collection的边框的top值
    if (!self.columnHeights.count) {
        for (int i = 0; i< _colNumber; i++) {
            [self.columnHeights addObject:@(self.edgeinsets.top)];
        }
    }
    
    //遍历所有的cell
    for (int i = 0; i < self.collectionView.numberOfSections; i++) {//遍历组
        NSLog(@"------%ld",[self.collectionView numberOfItemsInSection:i]);
        NSLog(@"------%ld",self.attrsArr.count);
        for (NSInteger j = 0; j < [self.collectionView numberOfItemsInSection:i]; j++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
           [self.attrsArr addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
        
    }
    
    
}
//返回可视范围内cell的UICollectionViewLayoutAttributes数组
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArr;
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
   UICollectionViewLayoutAttributes *cellAtts = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    /*1.****************获取cell的高度和宽度*****************/
    //获取collectionview的宽度
    CGFloat collectionViewW = self.collectionView.bounds.size.width;
    //cell的宽度
    CGFloat cell_W = (collectionViewW - self.edgeinsets.left - self.edgeinsets.right - _colSpace*(self.colNumber-1))/_colNumber;
    //cell的高度(随机高度)
    CGFloat cell_H = cell_W * (arc4random()%100 >= 50?250:320)/200;
    
    /*2.****************获取 最小列的高度 和 最小列*****************/
    //cell应该拼接的列数
    NSInteger destColum = 0;
    //获取最小的列数高度
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (int i = 1; i< _colNumber; i++) {
       CGFloat columnheight = [self.columnHeights[i] doubleValue];
        if (minColumnHeight > columnheight) {
            minColumnHeight = columnheight;
            destColum = i;
        }
    }
    
    /*3.****************获取cell的x、y坐标值*****************/
    CGFloat cell_X = self.edgeinsets.left + destColum * (cell_W + _colSpace);
    CGFloat cell_Y = _rowSpcae + minColumnHeight;//最小列的高度 + cell的高度
    
    /*4.****************获取cell的 Frame *****************/
    cellAtts.frame = CGRectMake(cell_X, cell_Y, cell_W, cell_H);
    
    
    self.columnHeights[destColum] = @(CGRectGetMaxY(cellAtts.frame));
    return cellAtts;
}

-(CGSize)collectionViewContentSize{
    NSLog(@"collectionViewContentSize");
    CGFloat maxHeight = [self.columnHeights[0] doubleValue];
    
    for (int i = 1; i < _colNumber; i++) {
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (maxHeight < columnHeight) {
            maxHeight = columnHeight;
        }
    }
    
    return CGSizeMake(0, maxHeight+self.edgeinsets.bottom);
}
#pragma mark - getter
-(NSMutableArray *)columnHeights{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}
-(NSMutableArray<UICollectionViewLayoutAttributes *> *)attrsArr{
    if (!_attrsArr) {
        _attrsArr = [NSMutableArray array];
    }
    return _attrsArr;
}
@end
