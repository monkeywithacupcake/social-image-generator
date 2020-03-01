# social-image-generator
A bash script automating ImageMagick creation of social media images

This is an image automation process that I created to solve a specific problem, that is, the time and effort that it takes to arrange and maintain a constant and harmonious social media presence for individuals and small business.

## How To Use
`git clone https://github.com/monkeywithacupcake/social-image-generator.git`
`cd social-image-generator`
`bash ig_gen.sh "${PWD}/example-dir"`

## What you get
The file will look in the directory presented as an argument for three things:
- logo.png
- backgrounds folder 
- images folder

For each background, it will apply resizing and add the logo to create a background for square (instagram) and rectangle (twitter/facebook) shaped images. On the square, the logo will be in the bottom center. On the rectangle, the logo will be bottom right.

For each item in the STRINGS variable (inside `ig_gen.sh`), it will create an image using a background (sequentially in a loop, so if you have two backgrounds, like the example-dir, you will alternate, so every other item in the STRINGS will be on the first background image). These will be put into the `ig` and `output` folders that are created by the file and numbered, like `1.jpg`, `2.jpg`, etc.

For each image in the images folder, it will apply a filter (using ImageMagick) add the logo, and resize. It will name these sequentially, like `1a.jpg`, `2a.jpg`, etc. 

Then, all of the resulting images in square form will be arranged into a file called `/example-dir/big.png` that shows how the images will look in a feed, like you might see on instagram.

## To Customize

- **Background:** I recommend using GIMP or ImageMagick to create your backgrounds and logo in a way that keeps with your brand. Images for backgrounds should be sized at 1080X1080. 
- **Logo:** The logo should be small, the example uses 100x100.
- **Images:** These can be whatever. You can create them in GIMP, use your product images, or collect royalty free images from Unsplash or other sources. They should be at least 1080x1080
- **Strings:** The STRINGS variable must be of the form `("string 1" "string 2")` You can not have commas between strings. You can have single quotes in strings. ImageMagick will automatically break the strings and resize to make it fit. Very long strings may not be readable. You can force breaks with `\n` 
- **Overlays:** The overlay is part of the `convert` argument at the end of the `ig_gen.sh` file. `-size 1080x1080  xc:"#2196F3"  -gravity Center -alpha on  -compose blend  -define compose:args=20  -composite ` This essentially creates an image that is the color `#2196F3` that is the same size as the current image (which has been resized, centered, and cropped to fit in that space), they are then blended together with the image taking up 75% and the solid color at 25%. Then they are composited into a single image. You can get more fancy with overlays, adding multiple colors or images, or you can just change the color.
- **Font:** In this example, we use `RalewayBk` for the font of the STRINGS. If your machine does not have RalewayBk installed (it is a google font), it will default to a sans-serif font. This can be changed to any font on your machine. The color of the text can be changed as well. It is set at `#212121` here:  `-fill '#212121' -background None -strokewidth 1 -stroke '#212121' \` and here ` -fill '#212121'`



If this helps you, please let me know.


