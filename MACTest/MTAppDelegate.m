//
//  MTAppDelegate.m
//  MACTest
//
//  Created by luozhen on 13-10-21.
//  Copyright (c) 2013年 luozhen. All rights reserved.
//

#import "MTAppDelegate.h"
#import "NSImage+RoundCorner.h"

@implementation MTAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    [self.slider setAction:@selector(myCustomDragMethod:)];
}

- (IBAction)valueChange:(id)sender
{
    NSSlider *sl = (NSSlider*)sender;
    
    [self.lbValue setStringValue:[NSString stringWithFormat:@"%d",[sl intValue]]];
    
}

- (void)myCustomDragMethod:(NSSlider*)sender {
    NSSlider *sl = (NSSlider*)sender;
    
    [self.lbValue setStringValue:[NSString stringWithFormat:@"%d",[sl intValue]]];
}

- (IBAction)btnOutputClicked:(id)sender
{
    NSLog(@"%@",[self.textField stringValue]);

    NSString *path = [self.textField stringValue];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSImage *image = [[NSImage alloc] initWithContentsOfFile:path];
        if (image)
        {
            [self resizeAndSaveImageWithPath:path];
        }
        else
        {
            //运行起来就知道这4个字符串对应的含义的，不解释
            NSAlert *alert=[NSAlert alertWithMessageText:@"Info" defaultButton:@"确定" alternateButton:nil otherButton:nil informativeTextWithFormat:@"文件类型错误，不是图片类型"];
            //下面这个方法就是为了能够传递参数给alertEnded:code:context:方法从而进行判断当前所点击的按钮
            [alert beginSheetModalForWindow:[self window] modalDelegate:self didEndSelector:@selector(alertEnded:code:context:) contextInfo:nil];
        }
    }
    else
    {
        //运行起来就知道这4个字符串对应的含义的，不解释
        NSAlert *alert=[NSAlert alertWithMessageText:@"Info" defaultButton:@"确定" alternateButton:nil otherButton:nil informativeTextWithFormat:@"文件路径错误"];
        //下面这个方法就是为了能够传递参数给alertEnded:code:context:方法从而进行判断当前所点击的按钮
        [alert beginSheetModalForWindow:[self window] modalDelegate:self didEndSelector:@selector(alertEnded:code:context:) contextInfo:nil];
    }
}


//当点击defaultButton按钮的时候，返回0。当点击alternateButton按钮的时候，返回1；看词义就该了解了啊
-(void)alertEnded:(NSAlert *)alert code:(int)choice context:(void *)v{

    if (choice==NSAlertDefaultReturn) {

        NSLog(@"----------------0");
        
    } else if(choice==NSAlertAlternateReturn){
        
        NSLog(@"----------------1");
    }
}

#pragma mark- 
- (void)resizeAndSaveImageWithPath:(NSString*)path
{
    int count = 16;
    
    BOOL isRoundCorner = NO;
    NSInteger value = 0;
    if (self.btnSwich.state == NSOnState)
    {
        isRoundCorner = YES;
        
        value = [self.slider intValue];
    }
    
    
    
    NSImage *orginImage = [[NSImage alloc] initWithContentsOfFile:path];
    NSString *path2 = [path stringByDeletingLastPathComponent];
    
    NSSize   newSize;
    NSString *newName = nil;
    for (int i = 0; i<count; i++)
    {
        switch (i) {
            case 0:
            {
                newSize = NSMakeSize(40, 40);
                newName = [[NSString alloc] initWithFormat:@"Icon-40.png"];
            }
                break;
            case 1:
            {
                newSize = NSMakeSize(80, 80);
                newName = [[NSString alloc] initWithFormat:@"Icon-40@2x.png"];
            }
                break;
            case 2:
            {
                newSize = NSMakeSize(60, 60);
                newName = [[NSString alloc] initWithFormat:@"Icon-60.png"];
            }
                break;
            case 3:
            {
                newSize = NSMakeSize(120, 120);
                newName = [[NSString alloc] initWithFormat:@"Icon-60@2x.png"];
            }
                break;
            case 4:
            {
                newSize = NSMakeSize(72, 72);
                newName = [[NSString alloc] initWithFormat:@"Icon-72.png"];
            }
                break;
            case 5:
            {
                newSize = NSMakeSize(144, 144);
                newName = [[NSString alloc] initWithFormat:@"Icon-72@2x.png"];
            }
                break;
            case 6:
            {
                newSize = NSMakeSize(76, 76);
                newName = [[NSString alloc] initWithFormat:@"Icon-76.png"];
            }
                break;
            case 7:
            {
                newSize = NSMakeSize(152, 152);
                newName = [[NSString alloc] initWithFormat:@"Icon-76@2x.png"];
            }
                break;
            case 8:
            {
                newSize = NSMakeSize(29, 29);
                newName = [[NSString alloc] initWithFormat:@"Icon-Small.png"];
            }
                break;
            case 9:
            {
                newSize = NSMakeSize(58, 58);
                newName = [[NSString alloc] initWithFormat:@"Icon-Small@2x.png"];
            }
                break;
            case 10:
            {
                newSize = NSMakeSize(50, 50);
                newName = [[NSString alloc] initWithFormat:@"Icon-Small-50.png"];
            }
                break;
            case 11:
            {
                newSize = NSMakeSize(100, 100);
                newName = [[NSString alloc] initWithFormat:@"Icon-Small-50@2x.png"];
            }
                break;
            case 12:
            {
                newSize = NSMakeSize(57, 57);
                newName = [[NSString alloc] initWithFormat:@"Icon.png"];
            }
                break;
            case 13:
            {
                newSize = NSMakeSize(114, 114);
                newName = [[NSString alloc] initWithFormat:@"Icon@2x.png"];
            }
                break;
            case 14:
            {
                newSize = NSMakeSize(512, 512);
                newName = [[NSString alloc] initWithFormat:@"iTunesArtwork.png"];
            }
                break;
            case 15:
            {
                newSize = NSMakeSize(1024, 1024);
                newName = [[NSString alloc] initWithFormat:@"iTunesArtwork@2x.png"];
            }
                break;
            default:
                break;
        }
        
        NSString *newPath = [path2 stringByAppendingPathComponent:newName];
        NSImage *newImage = [self imageResize:orginImage newSize:newSize];
        
        BOOL isSuccess = NO;
        
        if (isRoundCorner)
        {
            NSImage *tempImage = [newImage roundCornersImageCornerRadius:value];
            isSuccess = [self saveImage:tempImage withPath:newPath];
        }
        else
        {
            isSuccess = [self saveImage:newImage withPath:newPath];
        }
        
        
        if (isSuccess)
        {
            NSLog(@"成功 i:%d",i);
        }
        else
        {
            NSLog(@"失败 i:%d",i);
        }

    }
    
}

- (NSImage *)imageResize:(NSImage*)anImage newSize:(NSSize)newSize {
    NSImage *sourceImage = anImage;
    [sourceImage setScalesWhenResized:YES];
    
    // Report an error if the source isn't a valid image
    if (![sourceImage isValid])
    {
        NSLog(@"Invalid Image");
    } else
    {
        NSImage *smallImage = [[NSImage alloc] initWithSize: newSize];
        [smallImage lockFocus];
        [sourceImage setSize: newSize];
        [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
        [sourceImage drawAtPoint:NSZeroPoint fromRect:CGRectMake(0, 0, newSize.width, newSize.height) operation:NSCompositeCopy fraction:1.0];
        [smallImage unlockFocus];
        return smallImage;
    }
    return nil;
}

- (BOOL)saveImage:(NSImage*)resultImg withPath:(NSString*)path
{
    NSData *imageData = [resultImg  TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];
    imageData = [imageRep representationUsingType:NSPNGFileType properties:imageProps];
    BOOL isSuccess = [imageData writeToFile:path atomically:NO];
    
    return isSuccess;
}

@end
