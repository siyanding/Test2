import org.opencv.core.*;
import org.opencv.features2d.*;
import org.opencv.highgui.Highgui;
import java.io.File;

import org.opencv.imgproc.Imgproc;
import pixeljelly.gui.ImageComponent;

import java.awt.image.BufferedImage;
import java.util.LinkedList;
import java.util.List;

public class Test {

    public Mat getThansform(Mat drawable, Mat region, int[] points) {
        Mat drawableCorner = new Mat(4, 1, CvType.CV_32FC2);
        Mat drawableTransformCorner = new Mat(4, 1, CvType.CV_32FC2);

        drawableCorner.put(0, 0, new double[]{0.0, 0.0});
        drawableCorner.put(1, 0, new double[]{drawable.cols(), 0.0});
        drawableCorner.put(2, 0, new double[]{drawable.cols(), drawable.rows()});
        drawableCorner.put(3, 0, new double[]{0.0, drawable.rows()});

        drawableTransformCorner.put(0, 0, new double[]{points[0], points[1]});
        drawableTransformCorner.put(1, 0, new double[]{points[2], points[3]});
        drawableTransformCorner.put(2, 0, new double[]{points[4], points[5]});
        drawableTransformCorner.put(3, 0, new double[]{points[6], points[7]});

        Mat perspectiveTransform = Imgproc.getPerspectiveTransform(drawableCorner, drawableTransformCorner);
        Imgproc.warpPerspective(drawable, region, perspectiveTransform, region.size(), Imgproc.INTER_LINEAR,
                Imgproc.BORDER_TRANSPARENT, new Scalar(0, 0, 0, 0));

        return region;
    }

    public static boolean FeatureSurfBruteforce(String srcString, String dstString){//return Mat
        //srcString = srcString.trim();
        //File f2 = new File( dstString );
        //File f = new File( srcString) ;
        //System.out.println( "FILE EXISTS: " + f.exists( ) + "=>" + f2.exists());
        System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
        Mat src = Highgui.imread(srcString);
        Mat dst = Highgui.imread(dstString);
        //System.out.println("SRC STRING IN FEATURE_SURF_BRUTE_FORCE IS (" + srcString.charAt(0) + ")");
        //System.out.println("DST STRING IN FEATURE_SURF_BRUTE_FORCE IS " + dstString);


        FeatureDetector fd = FeatureDetector.create(FeatureDetector.SURF);
        DescriptorExtractor de = DescriptorExtractor.create(DescriptorExtractor.SURF);
        //FLANN的含义是Fast Library forApproximate Nearest Neighbors
        DescriptorMatcher Matcher = DescriptorMatcher.create(DescriptorMatcher.FLANNBASED);
        //尝试所有可能的匹配，从而使得它总能够找到最佳匹配，这也是Brute Force（暴力法）
        //DescriptorMatcher Matcher = DescriptorMatcher.create(DescriptorMatcher.BRUTEFORCE_L1);
        //DescriptorMatcher Matcher = DescriptorMatcher.create(DescriptorMatcher.BRUTEFORCE);

        MatOfKeyPoint mkp = new MatOfKeyPoint();
        fd.detect(src, mkp);
        Mat desc = new Mat();
        de.compute(src, mkp, desc);
        Features2d.drawKeypoints(src, mkp, src);


        MatOfKeyPoint mkp2 = new MatOfKeyPoint();
        fd.detect(dst, mkp2);
        Mat desc2 = new Mat();
        de.compute(dst, mkp2, desc2);
        Features2d.drawKeypoints(dst, mkp2, dst);


        // Matching features
        MatOfDMatch Matches = new MatOfDMatch();
        Matcher.match(desc, desc2, Matches);

        double maxDist = Double.MIN_VALUE;
        double minDist = Double.MAX_VALUE;

        DMatch[] mats = Matches.toArray();
        for (int i = 0; i < mats.length; i++) {
            double dist = mats[i].distance;
            if (dist < minDist) {
                minDist = dist;
            }
            if (dist > maxDist) {
                maxDist = dist;
            }
        }
        System.out.println("Min Distance:" + minDist);
        System.out.println("Max Distance:" + maxDist);
        List<DMatch> goodMatch = new LinkedList<>();

        for (int i = 0; i < mats.length; i++) {
            double dist = mats[i].distance;
            if (dist < 3 * minDist && dist < 0.2f) {
                goodMatch.add(mats[i]);
            }
        }
        System.out.println("size:" + goodMatch.size());
        System.out.println("percent:" + goodMatch.size()/(double)mats.length);
        Matches.fromList(goodMatch);
        // Show result
        Mat OutImage = new Mat();
        Features2d.drawMatches(src, mkp, dst, mkp2, Matches, OutImage);

        if((goodMatch.size()/(double)mats.length)>0.1){
            return true;
        }else{
            return false;
        }

        //return OutImage;
    }

    //public static MatOfRect getFace(Mat src) {
    //    Mat result = src.clone();
    //    System.out.println("cols:"+src.cols()+",rows:"+src.rows());
    //    if (src.cols() > 1000 || src.rows() > 1000) {
    //        Imgproc.resize(src, result, new Size(src.cols() / 3, src.rows() / 3));
    //    }
    //    //CascadeClassifier faceDetector = new CascadeClassifier(getClass().getResource("/haarcascade_frontalface_alt.xml").getPath());
    //    //CascadeClassifier faceDetector = new CascadeClassifier(facePath);
    //    CascadeClassifier faceDetector = new CascadeClassifier("D:\\software\\openCV-3.3.1\\opencv\\sources\\data\\haarcascades\\haarcascade_frontalface_alt2.xml");//
    //    MatOfRect objDetections = new MatOfRect();
    //    faceDetector.detectMultiScale(result, objDetections);
	//
    //    return objDetections;
    //}

    public static BufferedImage mat2Img(Mat in)
    {
        BufferedImage out;
        byte[] data = new byte[in.cols() * in.rows() * (int)in.elemSize()];
        int type;
        in.get(0, 0, data);

        if(in.channels() == 1)
            type = BufferedImage.TYPE_BYTE_GRAY;
        else
            type = BufferedImage.TYPE_3BYTE_BGR;

        out = new BufferedImage(in.cols(), in.rows(), type);

        out.getRaster().setDataElements(0, 0, in.cols(), in.rows(), data);
        return out;
    }
}
