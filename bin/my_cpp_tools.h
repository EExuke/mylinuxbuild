 /* Copyright (C)
  * 2024 EExuke Optoelectronic Technology Co.LTD
  * All rights reserved.
  */
 /**
  * @file my_cpp_tools.h
  * @brief my tools header func of cpp
  * @author xuke
  * @version 1.0
  * @date 2025-12-30
  */

#ifndef _MY_CPP_TOOLS_H_
#define _MY_CPP_TOOLS_H_


/*------------------Include Files----------------------------*/
#include <string>
#include <atomic>
/*------------------End of Include Files---------------------*/

/*------------------Macro Definition-------------------------*/
#define GST_PIPELINE_RTSP_NX(url)    ({ \
	"rtspsrc location=" + url + \
	" protocols=udp latency=0 ! rtpjitterbuffer latency=100 ! rtph264depay ! h264parse config-interval=-1 ! nvv4l2decoder ! nvvidconv ! video/x-raw,format=BGRx ! videoconvert ! video/x-raw,format=BGR ! appsink drop=1 max-buffers=3"; \
})

#define GST_PIPELINE_RTSP_RK(url)    ({ \
})
/*------------------End of Macro Definition------------------*/

/*------------------Typedefs Definition----------------------*/
class INTERRUPTIBLE_TIMER_T {
	private:
		std::atomic_bool _timer_break;

	public:
		INTERRUPTIBLE_TIMER_T() {};
		~INTERRUPTIBLE_TIMER_T() {};

		int wait_sec(uint32_t t_sec) {
			_timer_break = false;
			for (int i=0; i<t_sec; i++) {
				if (_timer_break) {
					return 1;
				}
				sleep(1);
			}
			return 0;
		};

		void time_break() {
			_timer_break = true;
		};
};
/*------------------End of Typedefs Definition---------------*/

/*------------------API Definition---------------------------*/
/*------------------End of API Definition--------------------*/


#endif /* End of _MY_CPP_TOOLS_H_ */

