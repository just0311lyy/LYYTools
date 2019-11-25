//
//  LYYLazyLoadTableViewController.m
//  LYYTools
//
//  Created by 李阳洋 on 2018/10/18.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "LYYLazyLoadTableViewController.h"

@interface LYYLazyLoadTableViewController ()
@property(nonatomic,strong) NSArray *groups; //在类中声明了一个属性
@end

@implementation LYYLazyLoadTableViewController

-(NSArray *)groups{  //重写groups的getter方法
    if (!_groups) {  //不能用self.groups,是因为!_groups是个getter方法，若用getter访问会造成死循环
        _groups = @[@"cell01",@"cell02",@"cell03",@"cell04",@"cell05",@"cell06",@"cell07"];  //可以用self.groups访问，这是个setter方法
    }
    return _groups;  //不能用self.groups,是因为!_groups是个getter方法，若用getter访问会造成死循环
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- **** 列表点击事件 UITableViewDataSource ****
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld",_groups.count);
    //使用懒加载，此处必须使用self,不然无法调用setter方法
    return self.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString static *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [_groups objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark -- **** 列表点击事件 UITableViewDelegate ****
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.section) {
        case 0://精彩活动
            break;
        case 1://今日计划
        {
            
        }
            break;
        case 2://发现·话题
            break;
        default:
            break;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    switch (indexPath.section) {
//        case 0://精彩活动
//            return [HomeActivitiesCell getActivitiesHeight];
//            break;
//        case 1://今日计划
//        {
//            return [HomeTodayPlanCell getTodayPlanHeight];
//        }
//            break;
//        case 2://发现·话题
//            return [HomeFindTopicCell getTopicHeight];
//            break;
//        default:
//            return 0;
//    }
//}

//制定个性标题，这里通过UIview来设计标题，功能上丰富，变化多。
//- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    CGFloat sectionHeader_h = [HealthHomeSectionHeaderView getHeaderHeight];
//    CGRect sectionHeaderRect = CGRectMake(0, 0, SCREEN_WIDTH, sectionHeader_h);
//    HealthHomeSectionModel *sectionModel = [[HealthHomeSectionModel alloc] init];
//    if (section == 0)//精彩活动
//    {
//        HealthHomeSectionHeaderView *activitiesHeaderView = [[HealthHomeSectionHeaderView alloc] initWithFrame:sectionHeaderRect];
//        sectionModel.imageName = @"";
//        sectionModel.titleName = @"精彩活动";
//        sectionModel.detailTitle = @"";
//        sectionModel.hasArrow = NO;
//        [activitiesHeaderView setSectionModel:sectionModel];
//        return activitiesHeaderView;
//    }
//    if (section == 1)//今日计划
//    {
//        HealthHomeSectionHeaderView *todayPlanHeaderView = [[HealthHomeSectionHeaderView alloc] initWithFrame:sectionHeaderRect];
//        sectionModel.imageName = @"";
//        sectionModel.titleName = @"今日计划";
//        sectionModel.detailTitle = @"";
//        sectionModel.hasArrow = NO;
//        [todayPlanHeaderView setSectionModel:sectionModel];
//        return todayPlanHeaderView;
//    }
//    if (section == 2) //发现话题
//    {
//        HealthHomeSectionHeaderView *topicHeaderView = [[HealthHomeSectionHeaderView alloc] initWithFrame:sectionHeaderRect];
//        sectionModel.imageName = @"";
//        sectionModel.titleName = @"发现·话题";
//        sectionModel.detailTitle = @"";
//        sectionModel.hasArrow = YES;
//        [topicHeaderView setSectionModel:sectionModel];
//        topicHeaderView.delegate = self;
//        topicHeaderView.rightArrowBtn.tag = 3;
//        return topicHeaderView;
//    }
//    return self.goBackView;
//}

//- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return [HealthHomeSectionHeaderView getHeaderHeight];
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
