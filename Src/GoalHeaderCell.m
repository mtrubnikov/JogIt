//
//  GoalHeader.m
//  RunnersCompass
//
//  Created by Geoff MacDonald on 2013-02-24.
//  Copyright (c) 2013 Geoff MacDonald. All rights reserved.
//

#import "GoalHeaderCell.h"
#import <QuartzCore/QuartzCore.h>
#import "RunEvent.h"

@implementation GoalHeaderCell

@synthesize countLabel,countValue,beganLabel,beganValue;
@synthesize targetLabel,targetValue,metricDescriptionLabel,metricDescriptionSubtitle,metricValue;

@synthesize doneBut,goalButton;
@synthesize progress,goal,metric,noGoalImage,completeLabel;

-(void) setup
{
    orgFrame = self.frame;
    
    withGoalFrame = self.frame;
    CGRect progressRect = progress.frame;
    withGoalFrame.size.height = progressRect.origin.y + progressRect.size.height + 10;
    
    //set labels
    [self setGoalLabels];
    
    //set rounded corners on button
    [doneBut.layer setCornerRadius:8.0f];
    [goalButton.layer setCornerRadius:8.0f];
    [doneBut.layer setMasksToBounds:true];
    [goalButton.layer setMasksToBounds:true];
    
    //set progress bar
    UIImage *background = [[UIImage imageNamed:@"progress-bar-bg.png"]
                           resizableImageWithCapInsets:UIEdgeInsetsMake(0, 2, 0, 2)];
    UIImage *fill = [[UIImage imageNamed:@"progress-bar-fill.png"]
                     resizableImageWithCapInsets:UIEdgeInsetsMake(0, 2, 0, 2)];
    
    [progress setTrackImage:background];
    [progress setProgressImage:fill];
    [progress.layer setCornerRadius:6.0f];
    [progress.layer setMasksToBounds:true];
    
    
    [goalButton.titleLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:15.0f]];
    [doneBut.titleLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:15.0f]];
    
    
    [metricValue setFont:[UIFont fontWithName:@"Montserrat-Regular" size:12.0f]];
    [metricDescriptionLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:12.0f]];
    [metricDescriptionSubtitle setFont:[UIFont fontWithName:@"Montserrat-Regular" size:10.0f]];
    [beganLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:12.0f]];
    [beganValue setFont:[UIFont fontWithName:@"Montserrat-Regular" size:12.0f]];
    [targetLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:12.0f]];
    [targetValue setFont:[UIFont fontWithName:@"Montserrat-Regular" size:12.0f]];
    [countLabel setFont:[UIFont fontWithName:@"Montserrat-Regular" size:12.0f]];
    [countValue setFont:[UIFont fontWithName:@"Montserrat-Regular" size:12.0f]];
}

-(void)setGoalLabels
{
    [progress setHidden:false];
    
    if(goal && goal.type != GoalTypeNoGoal)
    {
        [goalButton setTitle:[goal getName:metric] forState:UIControlStateNormal];
        
        //dates
        NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterNoStyle];
        [formatter setCalendar:cal];
        [formatter setLocale:[NSLocale currentLocale]];
        if(goal.startDate)
        {
            NSString *beganString = [formatter stringFromDate:goal.startDate];
            [beganValue setText:beganString];
        }
        else{
            [beganValue setText:@""];
        }
        if(goal.endDate)
        {
            NSString *targetString = [formatter stringFromDate:goal.endDate];
            [targetValue setText:targetString];
        }
        else{
            [targetValue setText:@""];
        }
        
        [countValue setText:[NSString stringWithFormat:@"%d", [goal.activityCount integerValue]]];
        [metricValue setText:goal.metricValueChange];
        
        //both description labels to be updated
        [metricDescriptionLabel setText:[goal stringForProgress]];
        [metricDescriptionSubtitle setText:[goal stringForSubtitle]];
        
        //check if goal completed
        if(goal.progress >= 1)
        {
            [completeLabel setText:NSLocalizedString(@"GoalCompleteLabel", @"GoalCompleteLabel")];
            //hide progress, show label
            [completeLabel setHidden:false];
            //[progress setHidden:true];
        }
        
        //progress bar
        [progress setProgress:goal.progress];
        //hide image
        [noGoalImage setHidden:true];
        //decrease height to nearly that of progress bar
        [self setFrame:withGoalFrame];
        
    }else{
        [goalButton setTitle:NSLocalizedString(@"GoalButtonWithNone", @"No goal for button") forState:UIControlStateNormal];
        
        //dates
        [beganValue setText:@""];
        [targetValue setText:@""];
        
        [countValue setText:@""];
        [metricValue setText:@""];
        
        //both description labels to be updated
        [metricDescriptionLabel setText:@""];
        [metricDescriptionSubtitle setText:@""];
        
        //progress bar
        [progress setProgress:0];
        //view image
        [noGoalImage setHidden:false];
        //back to full screen
        [self setFrame:orgFrame];
    }
    
    //localizations    //localized buttons in IB
    [doneBut setTitle:NSLocalizedString(@"DoneButton", @"done button") forState:UIControlStateNormal];
    [beganLabel setText:NSLocalizedString(@"GoalBeganLabel", @"began date label for goal")];
    [targetLabel setText:NSLocalizedString(@"GoalTargetLabel", @"target date label for goal")];
    [countLabel setText:NSLocalizedString(@"GoalCountLabel", @"count label for goal activites")];
}

@end
