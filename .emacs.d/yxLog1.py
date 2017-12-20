


# yxLog1.py as a module
import logging

# config logging's logger alias yx_logger:
yx_logger = logging.getLogger('yx_log')
hdlr = logging.FileHandler('/var/log/yx/yx.log')    # chmod -R 777  /var/log/yx 
formatter = logging.Formatter('%(asctime)s %(levelname)s --> %(message)s')
hdlr.setFormatter(formatter)
yx_logger.addHandler(hdlr)
yx_logger.setLevel(logging.DEBUG)

yxdebug = yx_logger.debug
import json
json.dumps

'''
usage:    
            # mkdir  /var/log/yx     
            # chmod -R 777  /var/log/yx
            from yxLog1 import yxdebug
            yxdebug("==============debug info")
            # tailf  /var/log/yx/yx.log
'''
