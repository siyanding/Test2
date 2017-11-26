import org.opencv.core.*;
import org.opencv.features2d.DescriptorExtractor;
import org.opencv.features2d.DescriptorMatcher;
import org.opencv.features2d.FeatureDetector;
import org.opencv.features2d.Features2d;
import org.opencv.highgui.Highgui;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;
import org.opencv.objdetect.CascadeClassifier;

import java.util.LinkedList;
import java.util.List;

import static org.opencv.imgcodecs.Imgcodecs.CV_LOAD_IMAGE_GRAYSCALE;

public class Test {

    //Boolean use_mask = false;
    //Mat img = new Mat(), templ = new Mat();
    //Mat mask = new Mat();

    public static void main(String[] args) {
        System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
        Mat src = org.opencv.imgcodecs.Imgcodecs.imread("D:\\ideaData\\Test2\\src\\imageTest\\man.png");
        Mat dst = org.opencv.imgcodecs.Imgcodecs.imread("D:\\ideaData\\Test2\\src\\imageTest\\manBand1.jpg");
        MatOfRect mr = getFace(dst);
        Mat sub = dst.submat(mr.toArray()[0]);

        org.opencv.imgcodecs.Imgcodecs.imwrite("D:\\ideaData\\Test2\\src\\imageTest\\manTest1.jpg", FeatureSurfBruteforce(src.t(), sub));
        //Highgui.imwrite("E:/work/qqq/Y5.jpg", FeatureSiftLannbased(src.t(), sub));
        //Highgui.imwrite("E:/work/qqq/Y6.jpg", FeatureOrbLannbased(src.t(), sub));
    }


    public static Mat FeatureSurfBruteforce(Mat src, Mat dst){
        //FeatureDetector fd = FeatureDetector.create(FeatureDetector.SIFT);
        //DescriptorExtractor de = DescriptorExtractor.create(DescriptorExtractor.SIFT);
        ////DescriptorMatcher Matcher = DescriptorMatcher.create(DescriptorMatcher.FLANNBASED);
        //DescriptorMatcher Matcher = DescriptorMatcher.create(DescriptorMatcher.BRUTEFORCE_L1);

        FeatureDetector fd = FeatureDetector.create(FeatureDetector.SURF);
        DescriptorExtractor de = DescriptorExtractor.create(DescriptorExtractor.SURF);
        //DescriptorMatcher Matcher = DescriptorMatcher.create(DescriptorMatcher.FLANNBASED);
        DescriptorMatcher Matcher = DescriptorMatcher.create(DescriptorMatcher.BRUTEFORCE_L1);

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

        Matches.fromList(goodMatch);
        // Show result
        Mat OutImage = new Mat();
        Features2d.drawMatches(src, mkp, dst, mkp2, Matches, OutImage);

        return OutImage;
    }

    public static MatOfRect getFace(Mat src) {
        Mat result = src.clone();
        if (src.cols() > 1000 || src.rows() > 1000) {
            Imgproc.resize(src, result, new Size(src.cols() / 3, src.rows() / 3));
        }
        //CascadeClassifier faceDetector = new CascadeClassifier(getClass().getResource("/haarcascade_frontalface_alt.xml").getPath());
        //CascadeClassifier faceDetector = new CascadeClassifier(facePath);
        CascadeClassifier faceDetector = new CascadeClassifier("D:\\software\\openCV-3.3.1\\opencv\\sources\\data\\haarcascades\\haarcascade_frontalface_alt2.xml");//
        MatOfRect objDetections = new MatOfRect();
        faceDetector.detectMultiScale(result, objDetections);

        return objDetections;
    }
}
