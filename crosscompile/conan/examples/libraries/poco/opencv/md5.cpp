#include "opencv2/opencv.hpp"
#include "opencv2/highgui/highgui.hpp"


int main(int argc, char** argv) {
    //using namespace cv;

    cv::Mat img = cv::imread("/userdata/input.jpg", 0);
    if (img.empty())
    {
        std::cout << "!!! Failed imread(): image not found" << std::endl;
        return 1;
    }

    std::cout << "Width : " << img.cols << std::endl;
    std::cout << "Height: " << img.rows << std::endl;

    return 0;
}
