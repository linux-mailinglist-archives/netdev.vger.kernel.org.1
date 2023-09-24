Return-Path: <netdev+bounces-36010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A907B7AC6C0
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 08:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 5FA351C20843
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 06:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECCE7FE;
	Sun, 24 Sep 2023 06:21:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF79815
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 06:21:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818D5101
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 23:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695536514; x=1727072514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QiLHTjnm8sq1JlEZjCuf/g24Q0XVwe/gVgoaBvrdCKc=;
  b=VMvGMKZ+84bMhXua2Rdl/XRan+pfWUH0wfERZdXJcwC9jklYy8vx6KxB
   J4fQQMZZToR2jOMJYA2VUwUhlXPmKT8HlE+U51HfPm2b9RUtK2PmFrP3v
   TSEQw+vV356QjLzfB94PJQD5YeLYQki7fRh/ue880j5nk+GGA/hn09eh8
   xvaNOHReOCk6U3qSm5AryXwudKqv0d/yCU19kh9hX7KZHqphzDF0husPh
   apZQuuilQcC4ro99pvBFV6i7T0dpShkrw2uoRRF1Q/9rAuiKokp9s1Z73
   X7rGk+X8bBgqrmp6oclHlr4Upqprd+gCKf1kOoGd6tx/z7RupH6V5wCDg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="380987704"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="380987704"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 23:21:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="741560021"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="741560021"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 23 Sep 2023 23:21:52 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qkIV2-0003JZ-14;
	Sun, 24 Sep 2023 06:21:48 +0000
Date: Sun, 24 Sep 2023 14:21:40 +0800
From: kernel test robot <lkp@intel.com>
To: liuhaoran <liuhaoran14@163.com>, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	liuhaoran <liuhaoran14@163.com>
Subject: Re: [PATCH] net: phonet: Add error handling in phonet_device_init
Message-ID: <202309241414.qIf54B9l-lkp@intel.com>
References: <20230923115847.32740-1-liuhaoran14@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923115847.32740-1-liuhaoran14@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi liuhaoran,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master horms-ipvs/master v6.6-rc2 next-20230921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/liuhaoran/net-phonet-Add-error-handling-in-phonet_device_init/20230923-200141
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230923115847.32740-1-liuhaoran14%40163.com
patch subject: [PATCH] net: phonet: Add error handling in phonet_device_init
config: powerpc64-randconfig-003-20230924 (https://download.01.org/0day-ci/archive/20230924/202309241414.qIf54B9l-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230924/202309241414.qIf54B9l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309241414.qIf54B9l-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/phonet/pn_dev.c: In function 'phonet_device_init':
>> net/phonet/pn_dev.c:339:13: warning: assignment to 'int' from 'void *' makes integer from pointer without a cast [-Wint-conversion]
     339 |         err = proc_create_net("pnresource", 0, init_net.proc_net, &pn_res_seq_ops,
         |             ^


vim +339 net/phonet/pn_dev.c

   331	
   332	/* Initialize Phonet devices list */
   333	int __init phonet_device_init(void)
   334	{
   335		int err = register_pernet_subsys(&phonet_net_ops);
   336		if (err)
   337			return err;
   338	
 > 339		err = proc_create_net("pnresource", 0, init_net.proc_net, &pn_res_seq_ops,
   340				      sizeof(struct seq_net_private));
   341	
   342		if (!err)
   343			return err;
   344	
   345		err = register_netdevice_notifier(&phonet_device_notifier);
   346	
   347		if (!err)
   348			return err;
   349	
   350		err = phonet_netlink_register();
   351	
   352		if (err)
   353			phonet_device_exit();
   354		return err;
   355	}
   356	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

