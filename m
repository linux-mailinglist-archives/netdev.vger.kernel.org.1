Return-Path: <netdev+bounces-31046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F2F78B10F
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 14:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A461C208D9
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 12:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3D7125BB;
	Mon, 28 Aug 2023 12:52:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498AE125B9
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 12:52:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FE2107
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 05:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693227155; x=1724763155;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0tLU3Y09BQUkxu4IV89orRIQpc+aKxw3Ks/9MpQmPaU=;
  b=ep/FHOHi9+rHnhEaPvN/fNv8szlozo3YdQFT2IwUcmYIQOTN2z6UUBvX
   1mQhnj/kmeHDSQSPWnZ7lPduCTG6UwGsnCibySOgFzgyRf5isr8plpOR7
   /P4NyN8ROVO7+9Izq2A5IerbG9C/45f9obQfx/29N0VZOlilllHIFBFOQ
   TYt14MWkjDsFunn3hhzTe0OEA0RYHM1xPGMqs+OD7+msUaxub+I2mhJrM
   zqqvc/zf7lTQOaSasvr4dcu5HT/pItm6Rampal7bltSMRA8RXN9zidtlk
   sAbnXh+NYcb36MTdud5ANSTY50HN+YKNlb2i+83sgVGKwUo0cqgEHnJwg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="441438595"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="441438595"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 05:52:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="688092568"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="688092568"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 28 Aug 2023 05:52:27 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qabjB-0007sr-1r;
	Mon, 28 Aug 2023 12:52:23 +0000
Date: Mon, 28 Aug 2023 20:51:53 +0800
From: kernel test robot <lkp@intel.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	netdev@vger.kernel.org
Subject: [linux-next:master 13014/13109] include/linux/netlink.h:116:13:
 warning: 'sfc: Unsupported: only suppo...' directive output truncated
 writing 104 bytes into a region of size 80
Message-ID: <202308282000.2XNh0K6D-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   2ee82481c392eec06a7ef28df61b7f0d8e45be2e
commit: 01183204bc24d9612add84a809377cb10737e77f [13014/13109] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230828/202308282000.2XNh0K6D-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230828/202308282000.2XNh0K6D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308282000.2XNh0K6D-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:45,
                    from include/net/sch_generic.h:5,
                    from include/net/pkt_cls.h:7,
                    from drivers/net/ethernet/sfc/tc.c:12:
   drivers/net/ethernet/sfc/tc.c: In function 'efx_tc_mangle':
>> include/linux/netlink.h:116:13: warning: 'sfc: Unsupported: only suppo...' directive output truncated writing 104 bytes into a region of size 80 [-Wformat-truncation=]
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:1223:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
    1223 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: note: directive argument in the range [0, 254]
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:1223:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
    1223 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: note: 'snprintf' output between 107 and 110 bytes into a destination of size 80
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:1223:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
    1223 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: warning: 'sfc: Unsupported: only suppo...' directive output truncated writing 110 bytes into a region of size 80 [-Wformat-truncation=]
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:1282:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
    1282 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: note: directive argument in the range [0, 254]
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:1282:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
    1282 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: note: 'snprintf' output between 113 and 116 bytes into a destination of size 80
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:1282:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
    1282 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/netlink.h:116:13: warning: ') out of range, only support...' directive output truncated writing 60 bytes into a region of size between 46 and 55 [-Wformat-truncation=]
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:1271:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
    1271 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: note: 'snprintf' output between 86 and 95 bytes into a destination of size 80
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:1271:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
    1271 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c: In function 'efx_tc_flower_record_encap_match':
   include/linux/netlink.h:116:13: warning: ' conflicts with existing pse...' directive output truncated writing 53 bytes into a region of size between 28 and 33 [-Wformat-truncation=]
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:634:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
     634 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: note: directive argument in the range [0, 65535]
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:634:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
     634 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: note: 'snprintf' output between 102 and 112 bytes into a destination of size 80
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:634:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
     634 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: warning: ' conflicts with existing pse...' directive output truncated writing 57 bytes into a region of size 39 [-Wformat-truncation=]
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:627:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
     627 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: note: directive argument in the range [0, 255]
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:627:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
     627 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:116:13: note: 'snprintf' output 103 bytes into a destination of size 80
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |                      "%s" fmt "%s", "", ##args, "") >=                         \
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netlink.h:131:9: note: in expansion of macro 'NL_SET_ERR_MSG_FMT'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/tc.c:627:33: note: in expansion of macro 'NL_SET_ERR_MSG_FMT_MOD'
     627 |                                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~


vim +116 include/linux/netlink.h

2d4bc93368f5a0d Johannes Berg 2017-04-12  107  
51c352bdbcd23d7 Edward Cree   2022-10-18  108  /* We splice fmt with %s at each end even in the snprintf so that both calls
51c352bdbcd23d7 Edward Cree   2022-10-18  109   * can use the same string constant, avoiding its duplication in .ro
51c352bdbcd23d7 Edward Cree   2022-10-18  110   */
51c352bdbcd23d7 Edward Cree   2022-10-18  111  #define NL_SET_ERR_MSG_FMT(extack, fmt, args...) do {			       \
51c352bdbcd23d7 Edward Cree   2022-10-18  112  	struct netlink_ext_ack *__extack = (extack);			       \
51c352bdbcd23d7 Edward Cree   2022-10-18  113  									       \
51c352bdbcd23d7 Edward Cree   2022-10-18  114  	if (!__extack)							       \
51c352bdbcd23d7 Edward Cree   2022-10-18  115  		break;							       \
51c352bdbcd23d7 Edward Cree   2022-10-18 @116  	if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,	       \
51c352bdbcd23d7 Edward Cree   2022-10-18  117  		     "%s" fmt "%s", "", ##args, "") >=			       \
51c352bdbcd23d7 Edward Cree   2022-10-18  118  	    NETLINK_MAX_FMTMSG_LEN)					       \
51c352bdbcd23d7 Edward Cree   2022-10-18  119  		net_warn_ratelimited("%s" fmt "%s", "truncated extack: ",      \
51c352bdbcd23d7 Edward Cree   2022-10-18  120  				     ##args, "\n");			       \
51c352bdbcd23d7 Edward Cree   2022-10-18  121  									       \
51c352bdbcd23d7 Edward Cree   2022-10-18  122  	do_trace_netlink_extack(__extack->_msg_buf);			       \
51c352bdbcd23d7 Edward Cree   2022-10-18  123  									       \
51c352bdbcd23d7 Edward Cree   2022-10-18  124  	__extack->_msg = __extack->_msg_buf;				       \
51c352bdbcd23d7 Edward Cree   2022-10-18  125  } while (0)
51c352bdbcd23d7 Edward Cree   2022-10-18  126  

:::::: The code at line 116 was first introduced by commit
:::::: 51c352bdbcd23d7ce46b06c1e64c82754dc44044 netlink: add support for formatted extack messages

:::::: TO: Edward Cree <ecree.xilinx@gmail.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

