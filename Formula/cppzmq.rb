class Cppzmq < Formula
  desc "Header-only C++ binding for libzmq"
  homepage "http://www.zeromq.org"
  url "https://github.com/zeromq/cppzmq/archive/v4.3.0.tar.gz"
  sha256 "27d1f56406ba94ee779e639203218820975cf68174f92fbeae0f645df0fcada4"

  depends_on "cmake" => :build
  depends_on "zeromq"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "-j4", "install"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <zmq.hpp>
      #include <iostream>
      int main()
      {
        int major=0, minor=0, patch=0;
        zmq::version(&major, &minor, &patch);
        std::cout << major << "." << minor << "." << patch << std::endl;
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-I#{include}", "-L#{lib}", "-lzmq", "-o", "test"
  end
end
