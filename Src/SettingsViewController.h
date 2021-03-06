//
//  Settings.h
//  RunnersCompass
//
//  Created by Geoff MacDonald on 2013-01-27.
//  Copyright (c) 2013 Geoff MacDonald. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserPrefs.h"
#import "IAPShare.h"
#import "StandardNotifyVC.h"
#import "MJPopupBackgroundView.h"
#import "UIViewController+MJPopupViewController.h"
#import "AnimationUtil.h"
#import "FormKit.h"

@class FKFormModel;

@interface SettingsViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *table;

@property  FKFormModel *formModel;
@property  UserPrefs *prefsToChange;
@property  BOOL oldMetric;
@property  BOOL oldGrouping;
@property  BOOL oldShowSpeed;
@property  BOOL restoreAvailable;

@end
