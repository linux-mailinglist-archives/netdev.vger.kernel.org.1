Return-Path: <netdev+bounces-36159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FB57ADC8A
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 17:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DD3F9281A59
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 15:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E6B219FA;
	Mon, 25 Sep 2023 15:59:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC8D219F4
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 15:59:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F908CC1
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 08:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695657573; x=1727193573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Agip7NiufgUtwn8yYnWGFOa6/EV2/BQIOm1L6bkP7EU=;
  b=h/grsFm/+inGEFAZQyfVuQ9XoWaoTgxPaU8mMqlYxQv59mx6Vjpmn/xQ
   Hd6xgdwgIKxuc1o7K8slxXnx5N/UEuyhxhPl+S/gWxg52AtbrdUbhkGtU
   YoywjrOlrBwcM1c7C6uZrM/FpGfPEN5v8QZxA74WwEGFAs/8/dJzXSled
   hWl33E49z2/ObuYiM7NhWNFPBB1gNqwRmC2IfT2fg4Uwyv8qKIHKZtRy6
   50PbN4r6BPap2CLylNuBLlEb+v1O8MixE+gvaohMTKPLnV22tItFus9ZA
   PBHtPOWaw7WguK1k9azuhbcYK3bNakC757CTv/oUO8XYSqqVD2ytBChS9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445398258"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="445398258"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:59:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="814021520"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="814021520"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 25 Sep 2023 08:59:30 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qknzc-0001jT-1A;
	Mon, 25 Sep 2023 15:59:28 +0000
Date: Mon, 25 Sep 2023 23:58:53 +0800
From: kernel test robot <lkp@intel.com>
To: liuhaoran <liuhaoran14@163.com>, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	liuhaoran <liuhaoran14@163.com>
Subject: Re: [PATCH] net: phonet: Add error handling in phonet_device_init
Message-ID: <202309252347.ef6inFEC-lkp@intel.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi liuhaoran,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master horms-ipvs/master v6.6-rc3 next-20230925]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/liuhaoran/net-phonet-Add-error-handling-in-phonet_device_init/20230923-200141
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230923115847.32740-1-liuhaoran14%40163.com
patch subject: [PATCH] net: phonet: Add error handling in phonet_device_init
config: x86_64-randconfig-123-20230925 (https://download.01.org/0day-ci/archive/20230925/202309252347.ef6inFEC-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230925/202309252347.ef6inFEC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309252347.ef6inFEC-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/phonet/pn_dev.c:339:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected int err @@     got struct proc_dir_entry * @@
   net/phonet/pn_dev.c:339:13: sparse:     expected int err
   net/phonet/pn_dev.c:339:13: sparse:     got struct proc_dir_entry *

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

