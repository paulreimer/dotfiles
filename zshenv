STD_PATH=/usr/sbin:/sbin:/usr/bin:/bin:/usr/X11/bin
BIN_PATH=/usr/local/bin:/usr/local/sbin

ARM_PATH=$HOME/Development/arm/gcc-arm-none-eabi-4_9-2015q1/bin

MY_PATH=$HOME/bin

export PATH=$MY_PATH:$BIN_PATH:$STD_PATH

#export PATH=$PATH:$INTEL_PATH
#export PATH=$PATH:$AVR_PATH
export PATH=$PATH:$ARM_PATH
