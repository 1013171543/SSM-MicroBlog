package jkworld.util;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.CropImageFilter;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageFilter;
import java.io.File;
import java.util.UUID;

public class ImageCut{

	 public static String imgCut(String srcImageFile, int x, int y, int desWidth,
             int desHeight, String rootPath) {
		 	try {
		 		
		 		System.out.println("srcImageFile======="+srcImageFile);
				Image img;
				ImageFilter cropFilter;

				System.err.println("srcImageFile======="+srcImageFile);
				BufferedImage bi = ImageIO.read(new File(srcImageFile));

				int srcWidth = bi.getWidth();
				int srcHeight = bi.getHeight();

				//srcWidth >= desWidth && srcHeight >= desHeight
				if (true) {
					Image image = bi.getScaledInstance(srcWidth, srcHeight,Image.SCALE_DEFAULT);
					cropFilter = new CropImageFilter(x, y, desWidth, desHeight);
					img = Toolkit.getDefaultToolkit().createImage(
					       new FilteredImageSource(image.getSource(), cropFilter));
					BufferedImage tag = new BufferedImage(desWidth, desHeight,
					       BufferedImage.TYPE_INT_RGB);
					Graphics g = tag.getGraphics();
					g.drawImage(img, 0, 0, null);
					g.dispose();

					String newFileName = UUID.randomUUID().toString()+srcImageFile.substring(srcImageFile.lastIndexOf("."));

					System.out.println("newFileName........................"+newFileName);
					System.out.println("path........................"+rootPath);

					
					String format = srcImageFile.substring(srcImageFile.lastIndexOf(".")+1).toUpperCase();
					ImageIO.write(tag, format, new File(rootPath+newFileName));
					return newFileName;
					
				}
			} catch (Exception e) {
				e.printStackTrace();
				return "";
			}
			return "";
	 }


 
	
	
    
}
