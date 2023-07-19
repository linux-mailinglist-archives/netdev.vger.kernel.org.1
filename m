Return-Path: <netdev+bounces-18774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B604758A2C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 02:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561B31C20EC7
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 00:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F54E15C1;
	Wed, 19 Jul 2023 00:50:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135A615A9
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:50:04 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E358139
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 17:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689727803; x=1721263803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7XNm/eiu/+464O+4ELZCRoc88UcSsKb444y7j36j4e4=;
  b=CreNYKl4uNB+LK8CLdbdI45zOG9KoiuQZrH2XODmnxKyEqFOvjjxsiWO
   wFPV80TYiRvKaEX8UPTvvbyiac3miROP3L4e1WMfq1o/2ihdeQDkidj84
   bd5qSx7JfrN/1otv77jeB5qF8sbiYdGQdRQ5lpNHyir2vx43iVC77Q9wv
   DKoCK/N0qG9ykhS+It0GepFSHYeWRdzQ3kiJyfyCHqSVY0sXL5ujeQ3RD
   L3vnpMhkLuZUUkJARuXeMX04Pvo6x/UFiUSu9OLTLtUIfbv+F6OK5janx
   OSMBMZq1u/eXmFITcVf6I9yyHcK+ZO7g3eIp/7XwDzOSEFpUv1ypiR26T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="365226387"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="365226387"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 17:50:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="723822440"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="723822440"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 18 Jul 2023 17:50:00 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qLvO1-0003zn-0L;
	Wed, 19 Jul 2023 00:49:52 +0000
Date: Wed, 19 Jul 2023 08:48:57 +0800
From: kernel test robot <lkp@intel.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/1] net:openvswitch: check return value of pskb_trim()
Message-ID: <202307190802.c2sJufoJ-lkp@intel.com>
References: <20230717145024.27274-1-ruc_gongyuanjun@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717145024.27274-1-ruc_gongyuanjun@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Yuanjun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5-rc2 next-20230718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuanjun-Gong/net-openvswitch-check-return-value-of-pskb_trim/20230718-190417
base:   linus/master
patch link:    https://lore.kernel.org/r/20230717145024.27274-1-ruc_gongyuanjun%40163.com
patch subject: [PATCH 1/1] net:openvswitch: check return value of pskb_trim()
config: loongarch-randconfig-r031-20230718 (https://download.01.org/0day-ci/archive/20230719/202307190802.c2sJufoJ-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230719/202307190802.c2sJufoJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307190802.c2sJufoJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/irqflags.h:18,
                    from include/linux/spinlock.h:59,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from net/openvswitch/actions.c:8:
   arch/loongarch/include/asm/percpu.h:20:4: error: #error compiler support for the model attribute is necessary when a recent assembler is used
      20 | #  error compiler support for the model attribute is necessary when a recent assembler is used
         |    ^~~~~
   In file included from include/linux/export.h:5,
                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:17,
                    from include/linux/skbuff.h:13:
   net/openvswitch/actions.c: In function 'do_output':
>> include/linux/compiler.h:55:26: warning: suggest explicit braces to avoid ambiguous 'else' [-Wdangling-else]
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                          ^
   net/openvswitch/actions.c:922:25: note: in expansion of macro 'if'
     922 |                         if (skb->len - cutlen > ovs_mac_header_len(key))
         |                         ^~


vim +/else +55 include/linux/compiler.h

2bcd521a684cc9 Steven Rostedt 2008-11-21  49  
2bcd521a684cc9 Steven Rostedt 2008-11-21  50  #ifdef CONFIG_PROFILE_ALL_BRANCHES
2bcd521a684cc9 Steven Rostedt 2008-11-21  51  /*
2bcd521a684cc9 Steven Rostedt 2008-11-21  52   * "Define 'is'", Bill Clinton
2bcd521a684cc9 Steven Rostedt 2008-11-21  53   * "Define 'if'", Steven Rostedt
2bcd521a684cc9 Steven Rostedt 2008-11-21  54   */
a15fd609ad53a6 Linus Torvalds 2019-03-20 @55  #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
a15fd609ad53a6 Linus Torvalds 2019-03-20  56  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

