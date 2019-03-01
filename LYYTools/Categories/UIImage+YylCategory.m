//
//  UIImage+YylCategory.m
//  LYYTools
//
//  Created by YangyangLi on 2019/2/20.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import "UIImage+YylCategory.h"

#if __has_feature(objc_arc)
CG_INLINE CGImageRef CGImageAutorelease(CFTypeRef obj) {
    id __autoreleasing result = CFBridgingRelease(obj);
    return (__bridge CGImageRef)result;
}
#endif

#ifndef CGImageAutorelease
#if __has_feature(objc_arc)
#define CGImageAutorelease CGImageAutorelease
#else
#define CGImageAutorelease(x) (CGImageRef)([(id)x autorelease])
#endif
#endif

UIImage* getGrayScaleImage(UIImage* originalImage) {
    
    //image bounds
    CGRect imageBounds = CGRectMake(0.0, 0.0, originalImage.size.width, originalImage.size.height);
    //create gray device colorspace.
    CGColorSpaceRef space = CGColorSpaceCreateDeviceGray();
    //create 8-bit bimap context without alpha channel.
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, originalImage.size.width, originalImage.size.height, 8, 0, space, kCGImageAlphaNone);
    CGColorSpaceRelease(space);
    
    //Draw a rectangle with white background.
    CGContextSetFillColorWithColor(bitmapContext, [UIColor whiteColor].CGColor);
    CGContextBeginPath(bitmapContext);
    CGContextAddRect(bitmapContext, imageBounds);
    CGContextDrawPath(bitmapContext, kCGPathFill);
    
    //Draw an ellipse in a with black background.
    CGContextSetFillColorWithColor(bitmapContext, [UIColor blackColor].CGColor);
    CGContextBeginPath(bitmapContext);
    //take a smaller rectangle then the whole image.
    CGContextAddEllipseInRect(bitmapContext, CGRectInset(imageBounds, 0, 0));
    CGContextDrawPath(bitmapContext, kCGPathFill);
    
    //Get image from bimap context.
    CGImageRef grayScaleImage = CGBitmapContextCreateImage(bitmapContext);
    CGContextRelease(bitmapContext);
    //image is inverted. UIImage inverts orientation while converting CGImage to UIImage.
    UIImage* image = [UIImage imageWithCGImage:grayScaleImage];
    CGImageRelease(grayScaleImage);
    return image;
}

UIImage* getGrayRoundImage(UIImage* originalImage) {
    
    //image bounds
    CGSize imageSize = originalImage.size;
    CGRect imageBounds = CGRectMake(0.0, 0.0, originalImage.size.width, originalImage.size.height);
    CGPoint imageCenter = CGPointMake(imageSize.width/ 2.0, imageSize.height/2.0);
    
    //create gray device colorspace.
    CGColorSpaceRef space = CGColorSpaceCreateDeviceGray();
    //create 8-bit bimap context without alpha channel.
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, originalImage.size.width, originalImage.size.height, 8, 0, space, kCGImageAlphaNone);
    CGColorSpaceRelease(space);
    
    //Draw a rectangle with white background.
    CGContextSetFillColorWithColor(bitmapContext, [UIColor whiteColor].CGColor);
    CGContextBeginPath(bitmapContext);
    CGContextAddRect(bitmapContext, imageBounds);
    CGContextDrawPath(bitmapContext, kCGPathFill);
    
    //Draw an ellipse in a with black background.
    CGContextSetFillColorWithColor(bitmapContext, [UIColor blackColor].CGColor);
    CGContextBeginPath(bitmapContext);
    //take a smaller rectangle then the whole image.
    CGContextAddEllipseInRect(bitmapContext, CGRectInset(imageBounds, 0, 0));
    CGContextAddArc(bitmapContext, imageCenter.x, imageCenter.y, MIN(imageCenter.x, imageCenter.y), 0, M_PI * 2, 1);
    CGContextDrawPath(bitmapContext, kCGPathFill);
    
    //Get image from bimap context.
    CGImageRef grayScaleImage = CGBitmapContextCreateImage(bitmapContext);
    CGContextRelease(bitmapContext);
    //image is inverted. UIImage inverts orientation while converting CGImage to UIImage.
    UIImage* image = [UIImage imageWithCGImage:grayScaleImage];
    CGImageRelease(grayScaleImage);
    return image;
}

@implementation UIImage (YylCategory)
+ (UIImage *)yyl_circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    //1. 开启上下文
    UIImage *sourceImage = [UIImage imageNamed:name];
    return [self yyl_circleImageWithImage:sourceImage borderWidth:borderWidth borderColor:borderColor];
}

+ (UIImage *)yyl_circleImageWithImage:(UIImage *)sourceImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    //1. 开启上下文
    CGFloat imageWidth = sourceImage.size.width + 2 * borderWidth;
    CGFloat imageHeigh = sourceImage.size.height + 2 * borderWidth;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeigh), NO, 0);
    //2. 获取上下文
    UIGraphicsGetCurrentContext();
    //3. 画圆
    CGFloat radius = sourceImage.size.width < sourceImage.size.height ? sourceImage.size.width * 0.5 : sourceImage.size.height * 0.5;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageWidth * 0.5, imageHeigh * 0.5) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    bezierPath.lineWidth = borderWidth;
    [borderColor setStroke];
    [bezierPath stroke];
    //4. 使用BezierPath进行剪切
    [bezierPath addClip];
    //5. 画图
    [sourceImage drawInRect:CGRectMake(borderWidth, borderWidth, sourceImage.size.width, sourceImage.size.height)];
    //6. 从内存中创建新图片对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //7. 结束上下文
    UIGraphicsEndImageContext();
    return newImage;
}



+ (UIImage *)yyl_rotate:(UIImage *)src andOrientation:(UIImageOrientation)orientation {
    UIGraphicsBeginImageContext(src.size);
    
    CGContextRef context=(UIGraphicsGetCurrentContext());
    
    if (orientation == UIImageOrientationRight) {
        CGContextRotateCTM (context, 90/180*M_PI) ;
    } else if (orientation == UIImageOrientationLeft) {
        CGContextRotateCTM (context, -90/180*M_PI);
    } else if (orientation == UIImageOrientationDown) {
        // NOTHING
    } else if (orientation == UIImageOrientationUp) {
        CGContextRotateCTM (context, 90/180*M_PI);
    }
    
    [src drawAtPoint:CGPointMake(0, 0)];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//+ (UIImage *)yyl_amatorkaFilterImage:(UIImage *)image {
//    GPUImagePicture *resource = [[GPUImagePicture alloc] initWithImage:image];
//    GPUImageAmatorkaFilter *amatorkaFilter = [[GPUImageAmatorkaFilter alloc] init];
//    [resource addTarget:amatorkaFilter];
//    [amatorkaFilter useNextFrameForImageCapture];
//    [resource processImage];
//    UIImage *filteredImage = [amatorkaFilter imageFromCurrentFramebuffer];
//    return filteredImage;
//}

//+ (UIImage *)yyl_brightnessFilterImage:(UIImage *)image brightness:(CGFloat)brightness {
//    GPUImagePicture *resource = [[GPUImagePicture alloc] initWithImage:image];
//    GPUImageBrightnessFilter *filter = [[GPUImageBrightnessFilter alloc] init];
//    [filter setBrightness:brightness];
//    [resource addTarget:filter];
//    [filter useNextFrameForImageCapture];
//    [resource processImage];
//
//    UIImage *filteredImage = [filter imageFromCurrentFramebuffer];
//    return filteredImage;
//}

//+ (UIImage *)yyl_saturationFilterImage:(UIImage *)image vaule:(CGFloat)vaule {
//    GPUImagePicture *resource = [[GPUImagePicture alloc] initWithImage:image];
//    GPUImageSaturationFilter *filter = [[GPUImageSaturationFilter alloc] init];
//    [filter setSaturation:vaule*2.f];
//    [resource addTarget:filter];
//    [filter useNextFrameForImageCapture];
//    [resource processImage];
//
//    UIImage *filteredImage = [filter imageFromCurrentFramebuffer];
//    return filteredImage;
//}

//+ (UIImage *)yyl_kuwaharaFilterImage:(UIImage *)image {
//    GPUImagePicture *resource = [[GPUImagePicture alloc] initWithImage:image];
//    GPUImageKuwaharaFilter *filter = [[GPUImageKuwaharaFilter alloc] init];
//    [resource addTarget:filter];
//    [filter useNextFrameForImageCapture];
//    [resource processImage];
//
//    UIImage *filteredImage = [filter imageFromCurrentFramebuffer];
//    return filteredImage;
//}

+ (UIImage*)yyl_maskImage:(UIImage *)mainImage withMask:(UIImage *)maskImage {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGImageRef maskImageRef = [maskImage CGImage];
    
    // create a bitmap graphics context the size of the image
    CGContextRef mainViewContentContext = CGBitmapContextCreate (NULL, maskImage.size.width, maskImage.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    
    
    if (mainViewContentContext == NULL){
        CGColorSpaceRelease(colorSpace);
        return nil;
    }
    
    CGFloat ratio = 0;
    
    ratio = maskImage.size.width/ mainImage.size.width;
    
    if(ratio * mainImage.size.height < maskImage.size.height) {
        ratio = maskImage.size.height/ mainImage.size.height;
    }
    
    CGRect rect1  = {{0, 0}, {maskImage.size.width, maskImage.size.height}};
    CGRect rect2  = {
        {-((mainImage.size.width*ratio)-maskImage.size.width)/2 , -((mainImage.size.height*ratio)-maskImage.size.height)/2},
        {mainImage.size.width*ratio, mainImage.size.height*ratio}
    };
    
    CGContextClipToMask(mainViewContentContext, rect1, maskImageRef);
    CGContextDrawImage(mainViewContentContext, rect2, mainImage.CGImage);
    
    // Create CGImageRef of the main view bitmap content, and then
    // release that bitmap context
    CGImageRef newImage = CGBitmapContextCreateImage(mainViewContentContext);
    UIImage *theImage = [UIImage imageWithCGImage:newImage];
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(mainViewContentContext);
    CGImageRelease(newImage);
    
    // return the image
    return theImage;
    
}

+ (UIImage *)yyl_scaleImageWithImage:(UIImage *)image maxLengt:(CGFloat)length
{
    UIImage *resultImage = image;
    if (image.size.width > length && image.size.height > length) {
        CGFloat scaleFactor = length / image.size.width;
        resultImage = [UIImage yyl_imageWithImage:image scaledToSize:CGSizeMake(image.size.width * scaleFactor, image.size.height * scaleFactor)];
    }
    
    
    return resultImage;
}

+ (UIImage *)yyl_imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)yyl_cropImageToRound:(UIImage *)image {
    CGFloat width = image.size.width;
    CGFloat height = image.size.width;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = MIN(width/2, height/2);
    imageView.backgroundColor = [UIColor clearColor];
    UIImage *output = [UIImage yyl_imageFromLayer:imageView.layer];
    return output;
}


+ (UIImage *)yyl_circleImage:(UIImage *)oldImage withSize:(CGSize)size {
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGFloat radius = width < height ? width * 0.5 :height * 0.5;
    CGSize imageSize = CGSizeMake(width, height);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddArc(ctx, width * 0.5, height * 0.5, radius, 0,M_PI * 2, 0);
    CGContextClip(ctx);
    [oldImage drawInRect:CGRectMake(0, 0, width, height)];
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/// 去掉四周透明部分
+ (UIImage *)yyl_imageByTrimmingTransparentPixels:(UIImage *)image {
    int rows = image.size.height;
    int cols = image.size.width;
    int bytesPerRow = cols*sizeof(uint8_t);
    
    if ( rows < 2 || cols < 2 ) {
        return image;
    }
    
    //allocate array to hold alpha channel
    uint8_t *bitmapData = calloc(rows*cols, sizeof(uint8_t));
    
    //create alpha-only bitmap context
    CGContextRef contextRef = CGBitmapContextCreate(bitmapData, cols, rows, 8, bytesPerRow, NULL, kCGImageAlphaOnly);
    
    //draw our image on that context
    CGImageRef cgImage = image.CGImage;
    CGRect rect = CGRectMake(0, 0, cols, rows);
    CGContextDrawImage(contextRef, rect, cgImage);
    
    //summ all non-transparent pixels in every row and every column
    uint16_t *rowSum = calloc(rows, sizeof(uint16_t));
    uint16_t *colSum = calloc(cols, sizeof(uint16_t));
    
    //enumerate through all pixels
    for ( int row = 0; row < rows; row++) {
        for ( int col = 0; col < cols; col++)
        {
            if ( bitmapData[row*bytesPerRow + col] ) { //found non-transparent pixel
                rowSum[row]++;
                colSum[col]++;
            }
        }
    }
    
    //initialize crop insets and enumerate cols/rows arrays until we find non-empty columns or row
    UIEdgeInsets crop = UIEdgeInsetsMake(0, 0, 0, 0);
    
    for ( int i = 0; i<rows; i++ ) {        //top
        if ( rowSum[i] > 0 ) {
            crop.top = i; break;
        }
    }
    
    for ( int i = rows -1; i >= 0; i-- ) {     //bottom
        if ( rowSum[i] > 0 ) {
            crop.bottom = MAX(0, rows-i-1); break;
        }
    }
    
    for ( int i = 0; i<cols; i++ ) {        //left
        if ( colSum[i] > 0 ) {
            crop.left = i; break;
        }
    }
    
    for ( int i = cols -1; i >= 0; i-- ) {     //right
        if ( colSum[i] > 0 ) {
            crop.right = MAX(0, cols-i-1); break;
        }
    }
    
    free(bitmapData);
    free(colSum);
    free(rowSum);
    
    if ( crop.top == 0 && crop.bottom == 0 && crop.left == 0 && crop.right == 0 ) {
        //no cropping needed
        return image;
    }
    else {
        //calculate new crop bounds
        rect.origin.x += crop.left;
        rect.origin.y += crop.top;
        rect.size.width -= crop.left + crop.right;
        rect.size.height -= crop.top + crop.bottom;
        
        //crop it
        CGImageRef newImage = CGImageCreateWithImageInRect(cgImage, rect);
        
        //convert back to UIImage
        return [UIImage imageWithCGImage:newImage];
    }
}

+ (UIImage*)yyl_maskImage3:(UIImage *)image withMask:(UIImage *)maskImage {
    
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
    CGImageRelease(mask);
    
    UIImage *outputImage = [UIImage imageWithCGImage:masked];
    CGImageRelease(masked);
    
    return outputImage;
    
}

/// the image to be masked MUST be created with an alpha channel. The Alpha channel may not be created from the code.
+ (UIImage *)yyl_image:(UIImage *)image withMask:(UIImage *)maskImage {
    CGImageRef imageNoAlpha = image.CGImage;
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), nil, YES);
    CGImageRef imageWithAlpha = imageNoAlpha;
    //add alpha channel for images that don't have one (ie GIF, JPEG, etc...)
    //this however has a computational cost
    if ((CGImageGetAlphaInfo(imageNoAlpha) == kCGImageAlphaNone)
        || (CGImageGetAlphaInfo(imageNoAlpha) == kCGImageAlphaNoneSkipFirst)
        || (CGImageGetAlphaInfo(imageNoAlpha) == kCGImageAlphaNoneSkipLast)) {
        
        imageWithAlpha = CopyImageAndAddAlphaChannel(imageNoAlpha);
    }
    
    CGImageRef masked = CGImageCreateWithMask(imageWithAlpha, mask);
    
    UIImage *deviceImage = [UIImage imageWithCGImage:masked];
    
    CGImageRelease(mask);
    CGImageRelease(masked);
    
    return deviceImage;
}

// works for iOS8 simulator
+ (UIImage*)yyl_maskImage2:(UIImage *)image withMask:(UIImage *)maskImage {
    
    CGImageRef imgRef  = [image CGImage];
    CGImageRef maskRef = [maskImage CGImage];
    
    
    size_t maskWidth      = CGImageGetWidth(maskRef);
    size_t maskHeight     = CGImageGetHeight(maskRef);
    //  round bytesPerRow to the nearest 16 bytes, for performance's sake
    size_t bytesPerRow    = (maskWidth + 15) & 0xfffffff0;
    size_t bufferSize     = bytesPerRow * maskHeight;
    
    //  allocate memory for the bits
    CFMutableDataRef dataBuffer = CFDataCreateMutable(kCFAllocatorDefault, 0);
    CFDataSetLength(dataBuffer, bufferSize);
    
    //  the data will be 8 bits per pixel, no alpha
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef ctx            = CGBitmapContextCreate(CFDataGetMutableBytePtr(dataBuffer),
                                                        maskWidth, maskHeight,
                                                        8, bytesPerRow, colourSpace, (CGBitmapInfo)kCGImageAlphaNone);
    //  drawing into this context will draw into the dataBuffer.
    CGContextDrawImage(ctx, CGRectMake(0, 0, maskWidth, maskHeight), maskRef);
    CGContextRelease(ctx);
    
    //  now make a mask from the data.
    CGDataProviderRef dataProvider  = CGDataProviderCreateWithCFData(dataBuffer);
    CGImageRef mask                 = CGImageMaskCreate(maskWidth, maskHeight, 8, 8, bytesPerRow,
                                                        dataProvider, NULL, FALSE);
    
    CGDataProviderRelease(dataProvider);
    CGColorSpaceRelease(colourSpace);
    CFRelease(dataBuffer);
    
    CGImageRef masked = CGImageCreateWithMask(imgRef, mask);
    
    UIImage *outputImage = [UIImage imageWithCGImage:masked];
    
    CGImageRelease(mask);
    CGImageRelease(masked);
    return outputImage;
}

CGImageRef CopyImageAndAddAlphaChannel(CGImageRef sourceImage) {
    CGImageRef retVal = NULL;
    
    size_t width = CGImageGetWidth(sourceImage);
    size_t height = CGImageGetHeight(sourceImage);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    
    CGContextRef offscreenContext = CGBitmapContextCreate(NULL, scale*width, scale*height,
                                                          8, width * scale * 4, colorSpace,
                                                          (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGContextScaleCTM(offscreenContext, scale, scale);
    
    if (offscreenContext != NULL) {
        CGContextDrawImage(offscreenContext, CGRectMake(0, 0, width, height), sourceImage);
        
        retVal = CGBitmapContextCreateImage(offscreenContext);
        CGContextRelease(offscreenContext);
    }
    
    CGColorSpaceRelease(colorSpace);
    
    return CGImageAutorelease(retVal);
}

+ (UIImage*)yyl_maskImage2:(CGImageRef)image withMask:(UIImage*)maskImage withFrame:(CGRect)currentFrame {
    @autoreleasepool {
        CGFloat scale = [UIScreen mainScreen].scale;
        //Returns mainscreen or nativescale
        
        CGRect scaledRect = CGRectMake(currentFrame.origin.x, currentFrame.origin.y, maskImage.size.width*scale, maskImage.size.height*scale);
        //Rect scaled up to account for retina sizes
        
        CGImageRef tempImage = CGImageCreateWithImageInRect(image, scaledRect);// Cut out pieces of the image at the size of the pieces
        
        CGImageRef maskRef = maskImage.CGImage;  //Creates the mask to cut out edges
        CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                            CGImageGetHeight(maskRef),
                                            CGImageGetBitsPerComponent(maskRef),
                                            CGImageGetBitsPerPixel(maskRef),
                                            CGImageGetBytesPerRow(maskRef),
                                            CGImageGetDataProvider(maskRef), NULL, false);
        CGImageRef colorsHighlights = CGImageCreateWithMask(tempImage, mask);//Colors with tran transparent surround
        
        CFRelease(tempImage);
        
        CGSize tempsize = CGSizeMake(maskImage.size.width, maskImage.size.height);
        
        CFRelease(mask);
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(tempsize.width+5.0f, tempsize.height+5.0f), NO, scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            CGContextSetShadow(context, CGSizeMake(1, 2), 2);
        }else{
            CGContextSetShadow(context, CGSizeMake(.5, .5), 1);
        }
        
        [[UIImage imageWithCGImage:colorsHighlights scale:scale orientation:UIImageOrientationUp] drawInRect:CGRectMake(0, 0, tempsize.width, tempsize.height)];
        CFRelease(colorsHighlights);
        
        UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return finalImage;
    }
    
}

+ (UIImage *)yyl_squareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    double ratio;
    double delta;
    CGPoint offset;
    
    //make a new square size, that is the resized imaged width
    CGSize sz = CGSizeMake(newSize.width, newSize.height);
    
    //figure out if the picture is landscape or portrait, then
    //calculate scale factor and offset
    if (image.size.width > image.size.height) {
        ratio = newSize.width / image.size.width;
        delta = (ratio*image.size.width - ratio*image.size.height);
        offset = CGPointMake(delta/2, 0);
    } else {
        ratio = newSize.height / image.size.height;
        delta = (ratio*image.size.height - ratio*image.size.width);
        offset = CGPointMake(0, delta/2);
    }
    
    
    offset.x = (image.size.width - newSize.width)/2.0;
    offset.y = (image.size.height - newSize.height)/2.0;
    
    //make the final clipping rect based on the calculated values
    CGRect clipRect = CGRectMake(-offset.x, -offset.y,
                                 newSize.width,
                                 newSize.height);
    
    
    //start a new context, with scale factor 0.0 so retina displays get
    //high quality image
    UIGraphicsBeginImageContext(sz);
    UIRectClip(clipRect);
    [image drawInRect:clipRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)yyl_imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}


@end
