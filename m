Return-Path: <netdev+bounces-50765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2407F7076
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 10:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466911F2061B
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 09:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0AC17983;
	Fri, 24 Nov 2023 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCHbIQyp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C484F171D;
	Fri, 24 Nov 2023 01:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700819417; x=1732355417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WzTWD8+CcHAV0Ch8HWHYlJ+az5wbVKJRj68BrurTJKw=;
  b=JCHbIQypZ/2KENcCKxczb/SLynZmnmc2zqrCBAPOlttQcN4Y6hGsK62d
   W2gMTuZV2quAFPIE6pbQsTXl2kJKKyIQnwjNSN2N3ku1xBz+kFzbTDSXH
   KtilnUo+Sc2a0mqcG1and9cD+iP8RpmhWr9fRn/eh+WNpG1kGsOwa3ekY
   FJj2a387ns0la3ZGpusM5bOu3RFy7xWLt2/LYRg3l7M/pT9NuUdalp7+w
   BvzB9xSYFfU9qh6R7ihZNRU9QlQKqa94UDeiPpcFDwnVYBYD/cIwE3DN/
   yVGT3zzOEHjOyuPH7G74xQr3DKYbIyELoOhSNaRljREe2c4Bbc4QoExTa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="392165234"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="392165234"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 01:50:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="8921133"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 24 Nov 2023 01:50:15 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r6Sp9-0002Lc-2z;
	Fri, 24 Nov 2023 09:50:11 +0000
Date: Fri, 24 Nov 2023 17:49:06 +0800
From: kernel test robot <lkp@intel.com>
To: Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, pkshih@realtek.com,
	larry.chiu@realtek.com, Justin Lai <justinlai0215@realtek.com>
Subject: Re: [PATCH net-next v12 12/13] realtek: Update the Makefile and
 Kconfig in the realtek folder
Message-ID: <202311241318.bdYlmH2b-lkp@intel.com>
References: <20231123124313.1398570-13-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123124313.1398570-13-justinlai0215@realtek.com>

Hi Justin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Justin-Lai/rtase-Add-pci-table-supported-in-this-module/20231123-204759
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231123124313.1398570-13-justinlai0215%40realtek.com
patch subject: [PATCH net-next v12 12/13] realtek: Update the Makefile and Kconfig in the realtek folder
config: csky-randconfig-r081-20231124 (https://download.01.org/0day-ci/archive/20231124/202311241318.bdYlmH2b-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231124/202311241318.bdYlmH2b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241318.bdYlmH2b-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/realtek/rtase/rtase_main.c:2318:12: warning: 'rtase_resume' defined but not used [-Wunused-function]
    2318 | static int rtase_resume(struct device *device)
         |            ^~~~~~~~~~~~
>> drivers/net/ethernet/realtek/rtase/rtase_main.c:2305:12: warning: 'rtase_suspend' defined but not used [-Wunused-function]
    2305 | static int rtase_suspend(struct device *device)
         |            ^~~~~~~~~~~~~


vim +/rtase_resume +2318 drivers/net/ethernet/realtek/rtase/rtase_main.c

8f9d7c2677f7dc Justin Lai 2023-11-23  2304  
da2f11aefe82ee Justin Lai 2023-11-23 @2305  static int rtase_suspend(struct device *device)
da2f11aefe82ee Justin Lai 2023-11-23  2306  {
da2f11aefe82ee Justin Lai 2023-11-23  2307  	struct net_device *dev = dev_get_drvdata(device);
da2f11aefe82ee Justin Lai 2023-11-23  2308  
da2f11aefe82ee Justin Lai 2023-11-23  2309  	if (netif_running(dev)) {
da2f11aefe82ee Justin Lai 2023-11-23  2310  		netif_stop_queue(dev);
da2f11aefe82ee Justin Lai 2023-11-23  2311  		netif_device_detach(dev);
da2f11aefe82ee Justin Lai 2023-11-23  2312  		rtase_hw_reset(dev);
da2f11aefe82ee Justin Lai 2023-11-23  2313  	}
da2f11aefe82ee Justin Lai 2023-11-23  2314  
da2f11aefe82ee Justin Lai 2023-11-23  2315  	return 0;
da2f11aefe82ee Justin Lai 2023-11-23  2316  }
da2f11aefe82ee Justin Lai 2023-11-23  2317  
da2f11aefe82ee Justin Lai 2023-11-23 @2318  static int rtase_resume(struct device *device)
da2f11aefe82ee Justin Lai 2023-11-23  2319  {
da2f11aefe82ee Justin Lai 2023-11-23  2320  	struct net_device *dev = dev_get_drvdata(device);
da2f11aefe82ee Justin Lai 2023-11-23  2321  	struct rtase_private *tp = netdev_priv(dev);
da2f11aefe82ee Justin Lai 2023-11-23  2322  	int ret;
da2f11aefe82ee Justin Lai 2023-11-23  2323  
da2f11aefe82ee Justin Lai 2023-11-23  2324  	/* restore last modified mac address */
da2f11aefe82ee Justin Lai 2023-11-23  2325  	rtase_rar_set(tp, dev->dev_addr);
da2f11aefe82ee Justin Lai 2023-11-23  2326  
da2f11aefe82ee Justin Lai 2023-11-23  2327  	if (!netif_running(dev))
da2f11aefe82ee Justin Lai 2023-11-23  2328  		goto out;
da2f11aefe82ee Justin Lai 2023-11-23  2329  
da2f11aefe82ee Justin Lai 2023-11-23  2330  	rtase_wait_for_quiescence(dev);
da2f11aefe82ee Justin Lai 2023-11-23  2331  
da2f11aefe82ee Justin Lai 2023-11-23  2332  	rtase_tx_clear(tp);
da2f11aefe82ee Justin Lai 2023-11-23  2333  	rtase_rx_clear(tp);
da2f11aefe82ee Justin Lai 2023-11-23  2334  
da2f11aefe82ee Justin Lai 2023-11-23  2335  	ret = rtase_init_ring(dev);
da2f11aefe82ee Justin Lai 2023-11-23  2336  	if (ret) {
da2f11aefe82ee Justin Lai 2023-11-23  2337  		netdev_err(dev, "unable to init ring\n");
da2f11aefe82ee Justin Lai 2023-11-23  2338  		rtase_free_desc(tp);
da2f11aefe82ee Justin Lai 2023-11-23  2339  		return -ENOMEM;
da2f11aefe82ee Justin Lai 2023-11-23  2340  	}
da2f11aefe82ee Justin Lai 2023-11-23  2341  
da2f11aefe82ee Justin Lai 2023-11-23  2342  	rtase_hw_config(dev);
da2f11aefe82ee Justin Lai 2023-11-23  2343  	/* always link, so start to transmit & receive */
da2f11aefe82ee Justin Lai 2023-11-23  2344  	rtase_hw_start(dev);
da2f11aefe82ee Justin Lai 2023-11-23  2345  
da2f11aefe82ee Justin Lai 2023-11-23  2346  	netif_wake_queue(dev);
da2f11aefe82ee Justin Lai 2023-11-23  2347  	netif_device_attach(dev);
da2f11aefe82ee Justin Lai 2023-11-23  2348  out:
da2f11aefe82ee Justin Lai 2023-11-23  2349  
da2f11aefe82ee Justin Lai 2023-11-23  2350  	return 0;
da2f11aefe82ee Justin Lai 2023-11-23  2351  }
da2f11aefe82ee Justin Lai 2023-11-23  2352  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

