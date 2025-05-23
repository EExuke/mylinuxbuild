#ifndef  __BIN_DBG_H__
#define  __BIN_DBG_H__

#include <signal.h>
#include <unistd.h>
#include <execinfo.h>

/* Select the format of the print */
#define  PRINT_WITH_ENDIAN
/*
 *#define  PRINT_WITH_COMPILE_TIME
 */
#define  SUPPORT_COLOR_DEBUG

/* INHANDTAG: zhendong 2018-03-28
 * Supporting the display colors in the C program code.
 *   -----------------------------------------------------------
 *    UL -- [F]UnderLine   BA -- [F]Black        RE -- [F]Red
 *    GR -- [F]Green       YE -- [F]Yellow       BU -- [F]Blue
 *    PU -- [F]Purple      DG -- [F]DarkGreen    WH -- [F]White
 *    CL -- [F]Close      _BA -- [B]Black       _RE -- [B]Red
 *   _GR -- [B]Green      _YE -- [B]Yellow      _BU -- [B]Blue
 *   _PU -- [B]Purple     _DG -- [B]DarkGreen   _WH -- [B]White
 *   -----------------------------------------------------------
 */
#ifdef    SUPPORT_COLOR_DEBUG
#define   UL              "\033[4m"
#define   BA              "\033[30m"
#define   RE              "\033[31m"
#define   GR              "\033[32m"
#define   YE              "\033[33m"
#define   BU              "\033[34m"
#define   PU              "\033[35m"
#define   DG              "\033[36m"
#define   WH              "\033[37m"
#define   CL              "\033[0m"
#define  _BA              "\033[40m"
#define  _RE              "\033[41m"
#define  _GR              "\033[42m"
#define  _YE              "\033[43m"
#define  _BU              "\033[44m"
#define  _PU              "\033[45m"
#define  _DG              "\033[46m"
#define  _WH              "\033[47m"
#else
#define   UL              "\033[0m"
#define   BA              "\033[0m"
#define   RE              "\033[0m"
#define   GR              "\033[0m"
#define   YE              "\033[0m"
#define   BU              "\033[0m"
#define   PU              "\033[0m"
#define   DG              "\033[0m"
#define   WH              "\033[0m"
#define   CL              "\033[0m"
#define  _BA              "\033[0m"
#define  _RE              "\033[0m"
#define  _GR              "\033[0m"
#define  _YE              "\033[0m"
#define  _BU              "\033[0m"
#define  _PU              "\033[0m"
#define  _DG              "\033[0m"
#define  _WH              "\033[0m"
#endif

#include <string.h>
/*
 *#define filename(x)                (strrchr(x, '/') ? strrchr(x, '/')+1 : x)
 */
#define filename(x)                (strstr(x, "future") ? strstr(x, "future")+7 : x)

#ifdef PRINT_WITH_ENDIAN
#ifndef  OSIX_HOST
#define  OSIX_HOST            __BYTE_ORDER__
#define  OSIX_LITTLE_ENDIAN   __ORDER_LITTLE_ENDIAN__
#endif
#endif

/* INHANDTAG: zhendong 2018-03-28
 *  ----------------------------------------------------------------
 * 1. filename funcname(line)                   : message<color>
 * 2. filename compiletime funcname(line)       : message<color>
 * 3. filename endian funcname(line)            : message<color>
 * 4. filename endian:compiletime funcname(line): message<color>
 *  ---------------------------------------------------------------- */
#ifdef PRINT_WITH_COMPILE_TIME
#ifdef PRINT_WITH_ENDIAN
    #define MYPRINT(x, msg, args...)  \
        printf(PU "%s " DG "%s:%s" YE " %s" CL "(" GR "%d" CL "): " x msg CL "\n\r", \
                filename(__FILE__), OSIX_HOST == OSIX_LITTLE_ENDIAN ? "LE" : "BE", __TIME__,  __FUNCTION__, __LINE__, ##args)
    #define MYPRINT_NO_FEED(x, msg, args...)  \
        printf(PU "%s " DG "%s:%s" YE " %s" CL "(" GR "%d" CL "): " x msg CL, \
                filename(__FILE__), OSIX_HOST == OSIX_LITTLE_ENDIAN ? "LE " : "BE ", __TIME__,  __FUNCTION__, __LINE__, ##args)
#else
    #define MYPRINT(x, msg, args...)  \
        printf(PU "%s " DG "%s" YE " %s" CL "(" GR "%d" CL "): " x msg CL "\n\r", \
                filename(__FILE__), __TIME__, __FUNCTION__, __LINE__, ##args)
    #define MYPRINT_NO_FEED(x, msg, args...)  \
        printf(PU "%s " DG "%s" YE " %s" CL "(" GR "%d" CL "): " x msg CL, \
                filename(__FILE__), __TIME__, __FUNCTION__, __LINE__, ##args)
#endif
#else  /*else PRINT_WITH_COMPILE_TIME*/
#ifdef PRINT_WITH_ENDIAN
    #define MYPRINT(x, msg, args...)  \
        printf(PU "%s " DG "%s" YE " %s" CL "(" GR "%d" CL "): " x msg CL "\n\r", \
                filename(__FILE__), OSIX_HOST == OSIX_LITTLE_ENDIAN ? "LE " : "BE ",  __FUNCTION__, __LINE__, ##args)
    #define MYPRINT_NO_FEED(x, msg, args...)  \
        printf(PU "%s " DG "%s" YE " %s" CL "(" GR "%d" CL "): " x msg CL, \
                filename(__FILE__), OSIX_HOST == OSIX_LITTLE_ENDIAN ? "LE " : "BE ",  __FUNCTION__, __LINE__, ##args)
#else
    #define MYPRINT(x, msg, args...)  \
        printf(PU "%s" YE " %s" CL "(" GR "%d" CL "): " x msg CL "\n\r", \
                filename(__FILE__),  __FUNCTION__, __LINE__, ##args)
    #define MYPRINT_NO_FEED(x, msg, args...)  \
        printf(PU "%s" YE " %s" CL "(" GR "%d" CL "): " x msg CL, \
                filename(__FILE__),  __FUNCTION__, __LINE__, ##args)
#endif
#endif /*ifdef PRINT_WITH_COMPILE_TIME*/

/* APIs for calling by source code, pls make sure the dbg.h has been added into iss.h */
#define my_debug_msg(msg, args...)            do { MYPRINT(CL, msg, ##args); fflush(stdout); }while (0)
#define my_debug_red_msg(msg, args...)        do { MYPRINT(RE, msg, ##args); fflush(stdout); }while (0)
#define my_debug_green_msg(msg, args...)      do { MYPRINT(GR, msg, ##args); fflush(stdout); }while (0)
#define my_debug_yellow_msg(msg, args...)     do { MYPRINT(YE, msg, ##args); fflush(stdout); }while (0)
#define my_debug_blue_msg(msg, args...)       do { MYPRINT(BU, msg, ##args); fflush(stdout); }while (0)
#define my_debug_purple_msg(msg, args...)     do { MYPRINT(PU, msg, ##args); fflush(stdout); }while (0)
#define my_debug_darkgreen_msg(msg, args...)  do { MYPRINT(DG, msg, ##args); fflush(stdout); }while (0)
#define my_debug_black_msg(msg, args...)      do { MYPRINT(BA, msg, ##args); fflush(stdout); }while (0)

//基于pause+signal实现的,断点单步调试功能
static inline void SIG_NONP(int sig) {}
#define my_break_point(msg, args...)          do { MYPRINT(RE, msg, ##args); fflush(stdout); \
	static char __my_break_point_first = 1; \
	if (__my_break_point_first) { \
		__my_break_point_first = 0; \
		signal(SIGTSTP, SIG_NONP); \
	} \
	pause(); \
} while (0)

// My backtrace
// *链接时需添加 -rdynamic 参数;
// *static函数识别不到函数名
#define my_debug_backtrace()      do { \
	void *__bt_buf[128]; \
	int __bt_size = backtrace(__bt_buf, sizeof(__bt_buf)); \
	char **__bt_strings = backtrace_symbols(__bt_buf, __bt_size); \
	printf("backtrace:\n"); \
	for (int __i=0; __i<__bt_size; __i++) { \
		printf("%*s %s\n", __i+4, "↑_", __bt_strings[__i]); \
	} \
	free(__bt_strings); \
} while (0)

//格式数据输出命令, 用于绘制数据图表
#define MY_DATA_OUTPUT(fname, args...)    do { \
	static FILE *__my_data_fd = fopen(fname, "w+"); \
	fprintf(__my_data_fd, ##args); \
} while (0);
#define MY_DATA_OUTPUT_FP(fp, fname, args...)    do { \
	if (!fp) { \
		fp = fopen(fname, "w+"); \
	} \
	fprintf(fp, ##args); \
} while (0);
#define MY_DATA_CLOSE_FP(fp)    do { \
	if (fp) { \
		fclose(fp); \
		fp = NULL; \
	} \
} while (0);

#define myprintf(msg, args...)                do { MYPRINT_NO_FEED(CL, msg, ##args); fflush(stdout); }while (0)
#define myprintf_red(msg, args...)            do { MYPRINT_NO_FEED(RE, msg, ##args); fflush(stdout); }while (0)
#define myprintf_green(msg, args...)          do { MYPRINT_NO_FEED(GR, msg, ##args); fflush(stdout); }while (0)

#define DEBUG_CABLE do { \
    printf("\n %s i4PortControlIndex=%d\n",i4LinkStatus == CFA_IF_UP ? "CFA_IF_UP":"CFA_IF_DOWN", i4PortControlIndex); \
    printf("pu2CableStatus[0]=%d,pu2CableLen[0]=%d\n",pu2CableStatus[0],pu2CableLen[0]); \
    printf("pu2CableStatus[1]=%d,pu2CableLen[1]=%d\n",pu2CableStatus[1],pu2CableLen[1]); \
    printf("pu2CableStatus[2]=%d,pu2CableLen[2]=%d\n",pu2CableStatus[2],pu2CableLen[2]); \
    printf("pu2CableStatus[3]=%d,pu2CableLen[3]=%d\n",pu2CableStatus[3],pu2CableLen[3]); \
    fflush(stdout); \
} while (0)

#define PRINT_PKT do { \
    printf ("\n-----------------------  ----------------------- \n");             \
    printf ("\nPrinting the Packet Received (%s-%d):\n", __FUNCTION__, __LINE__); \
    for (i4_Index = 0; i4_Index < u2_PktLen; i4_Index++)                          \
        if (i4_Index % 8 == 0 && i4_Index != 0)                                   \
            if (i4_Index % 16 == 0 && i4_Index != 0)                              \
                printf ("%02X\n", *(p_u1RadiusReceivedPacket + i4_Index));        \
            else                                                                  \
                printf ("%02X  ", *(p_u1RadiusReceivedPacket + i4_Index));        \
        else                                                                      \
            printf ("%02X ", *(p_u1RadiusReceivedPacket + i4_Index));             \
    printf ("\n-----------------------  ----------------------- \n");             \
    fflush(stdout); \
} while (0)


/* printf cursor ctrl */
// 清屏
#define PRT_CLEAR()          printf("\033[2J")
// 上移光标
#define PRT_MOVEUP(x)        printf("\033[%dA", (x))
// 下移光标
#define PRT_MOVEDOWN(x)      printf("\033[%dB", (x))
// 左移光标
#define PRT_MOVELEFT(y)      printf("\033[%dD", (y))
// 右移光标
#define PRT_MOVERIGHT(y)     printf("\033[%dC",(y))
// 定位光标
#define PRT_MOVETO(x,y)      printf("\033[%d;%dH", (x), (y))
// 光标复位
#define PRT_RESET_CURSOR()   printf("\033[H")
// 隐藏光标
#define PRT_HIDE_CURSOR()    printf("\033[?25l")
// 显示光标
#define PRT_SHOW_CURSOR()    printf("\033[?25h")
//清除从光标到行尾的内容
#define PRT_CLEAR_LINE()     printf("\033[K")
//反显
#define PRT_HIGHT_LIGHT()    printf("\033[7m")
#define PRT_UN_HIGHT_LIGHT() printf("\033[27m")

#endif /* __BIN_DBG_H__ */
