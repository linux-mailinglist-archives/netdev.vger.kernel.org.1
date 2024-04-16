Return-Path: <netdev+bounces-88141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 278B08A5F5C
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 02:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9488D1F21B6B
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 00:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F89E80C;
	Tue, 16 Apr 2024 00:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BEnz70GU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6636A3F
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 00:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713227981; cv=none; b=liz/fXtlyQTW7Yecv9Zv25bYsLDZZS6aebvd0z6KyxukiPzCcSF7rCuQ6lSdwj7Ia9Z8wvDSGoJQcDBqXLlUyRbl3zV4cAD6ULKcZW/TqjH1VwLjfAQtq2dTy+NRpJJgcKBvufmbWErh1avEeV0NjmlaxMcimB4afx1pkDSwcPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713227981; c=relaxed/simple;
	bh=tM3OCE1DZZHveXD2E/m/rUSM/zbMro4dGRHM4XQKcj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+PglsXOLAJ51ssfU/Kpqm9FML92i1L3RsnGB/kqvf1PyKLptSAmxFZGGEtmj7uE8lELWdfyAMXQT7yl8q6CMGF1PuVu1rFb4X50E8O0APOAFhH7hzvJrdUWnPA8DzDwUZyVBoBCaXoSYfABnrLtXBNJBh/FDbZkdsk5+ijoCic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BEnz70GU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713227980; x=1744763980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tM3OCE1DZZHveXD2E/m/rUSM/zbMro4dGRHM4XQKcj8=;
  b=BEnz70GUB8LxIhOCUYF8Rk63XiS3aN/Gf1vCI4tHeXOu6O/Sxqmx2iHp
   e01sieT14q33SWnwTVWki7w/hHVZBkXHs/T8RC9Kq+IVQ9itx2TM4Zjhn
   HTqAeumjnWHWUlAZi4ha5ayjPFZefBXln+F8tFxGcW7rtvFjmH1xPuGfC
   brCio+IfGkQ+CEsinIpeQTpsGBFwOL9Id5bm19bgloofMbcHsYlfKlQAO
   /E11qm8Ac3lq53J3eXL9FnyoAxSu5wacIoY0NpTPj7zkba3W6sqDx1Oh9
   X+6dDr/PMe32XP8XkMy9e0X4bAvFXw7mZFM6FWRFtr8r/5u0YI6lqnPMu
   w==;
X-CSE-ConnectionGUID: yLUhTDTuTBm4XfmTI3f+2Q==
X-CSE-MsgGUID: QiIMFlAWQPyaOQvs7o3EAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8808498"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="8808498"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 17:39:39 -0700
X-CSE-ConnectionGUID: v1N4o0H/QMyv+9BypL7SRQ==
X-CSE-MsgGUID: Vz7Ett5SQiWOXbt5B5zF+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="22671147"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 15 Apr 2024 17:39:38 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwWrH-0004ma-19;
	Tue, 16 Apr 2024 00:39:35 +0000
Date: Tue, 16 Apr 2024 08:38:53 +0800
From: kernel test robot <lkp@intel.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrew@lunn.ch
Subject: Re: [PATCH net-next v1 4/5] net: tn40xx: add basic Rx handling
Message-ID: <202404160840.Me9Gpj7a-lkp@intel.com>
References: <20240415104352.4685-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415104352.4685-5-fujita.tomonori@gmail.com>

Hi FUJITA,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 32affa5578f0e6b9abef3623d3976395afbd265c]

url:    https://github.com/intel-lab-lkp/linux/commits/FUJITA-Tomonori/net-tn40xx-add-pci-driver-for-Tehuti-Networks-TN40xx-chips/20240415-185416
base:   32affa5578f0e6b9abef3623d3976395afbd265c
patch link:    https://lore.kernel.org/r/20240415104352.4685-5-fujita.tomonori%40gmail.com
patch subject: [PATCH net-next v1 4/5] net: tn40xx: add basic Rx handling
config: microblaze-allmodconfig (https://download.01.org/0day-ci/archive/20240416/202404160840.Me9Gpj7a-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240416/202404160840.Me9Gpj7a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404160840.Me9Gpj7a-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:566,
                    from include/asm-generic/bug.h:22,
                    from ./arch/microblaze/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/linux/sched.h:14,
                    from include/linux/delay.h:23,
                    from drivers/net/ethernet/tehuti/tn40.h:8,
                    from drivers/net/ethernet/tehuti/tn40.c:4:
   drivers/net/ethernet/tehuti/tn40.c: In function 'bdx_rx_reuse_page':
>> drivers/net/ethernet/tehuti/tn40.c:154:20: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     154 |                    (void *)dm->dma);
         |                    ^
   include/linux/dynamic_debug.h:224:29: note: in definition of macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:277:9: note: in expansion of macro '_dynamic_func_call'
     277 |         _dynamic_func_call(fmt, __dynamic_netdev_dbg,           \
         |         ^~~~~~~~~~~~~~~~~~
   include/net/net_debug.h:57:9: note: in expansion of macro 'dynamic_netdev_dbg'
      57 |         dynamic_netdev_dbg(__dev, format, ##args);              \
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/tehuti/tn40.c:153:9: note: in expansion of macro 'netdev_dbg'
     153 |         netdev_dbg(priv->ndev, "dm size %d off %d dma %p\n", dm->size, dm->off,
         |         ^~~~~~~~~~
   drivers/net/ethernet/tehuti/tn40.c:156:67: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     156 |                 netdev_dbg(priv->ndev, "unmap page %p size %d\n", (void *)dm->dma, dm->size);
         |                                                                   ^
   include/linux/dynamic_debug.h:224:29: note: in definition of macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:277:9: note: in expansion of macro '_dynamic_func_call'
     277 |         _dynamic_func_call(fmt, __dynamic_netdev_dbg,           \
         |         ^~~~~~~~~~~~~~~~~~
   include/net/net_debug.h:57:9: note: in expansion of macro 'dynamic_netdev_dbg'
      57 |         dynamic_netdev_dbg(__dev, format, ##args);              \
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/tehuti/tn40.c:156:17: note: in expansion of macro 'netdev_dbg'
     156 |                 netdev_dbg(priv->ndev, "unmap page %p size %d\n", (void *)dm->dma, dm->size);
         |                 ^~~~~~~~~~
   drivers/net/ethernet/tehuti/tn40.c: In function 'bdx_rx_alloc_buffers':
   drivers/net/ethernet/tehuti/tn40.c:324:28: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     324 |                            (void *)dm->dma);
         |                            ^
   include/linux/dynamic_debug.h:224:29: note: in definition of macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:277:9: note: in expansion of macro '_dynamic_func_call'
     277 |         _dynamic_func_call(fmt, __dynamic_netdev_dbg,           \
         |         ^~~~~~~~~~~~~~~~~~
   include/net/net_debug.h:57:9: note: in expansion of macro 'dynamic_netdev_dbg'
      57 |         dynamic_netdev_dbg(__dev, format, ##args);              \
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/tehuti/tn40.c:323:17: note: in expansion of macro 'netdev_dbg'
     323 |                 netdev_dbg(priv->ndev, "dm size %d off %d dma %p\n", dm->size, dm->off,
         |                 ^~~~~~~~~~
   drivers/net/ethernet/tehuti/tn40.c: In function 'bdx_rx_receive':
>> drivers/net/ethernet/tehuti/tn40.c:465:26: warning: variable 'rxf_fifo' set but not used [-Wunused-but-set-variable]
     465 |         struct rxf_fifo *rxf_fifo;
         |                          ^~~~~~~~
   drivers/net/ethernet/tehuti/tn40.c: In function 'bdx_start_xmit':
   drivers/net/ethernet/tehuti/tn40.c:923:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     923 |         txdd->va_lo = (u32)((u64)skb);
         |                             ^
   drivers/net/ethernet/tehuti/tn40.c: In function 'bdx_tx_cleanup':
>> drivers/net/ethernet/tehuti/tn40.c:1007:48: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
    1007 |                         netdev_dbg(priv->ndev, "pci_unmap_page 0x%llx len %d\n",
         |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1008 |                                    db->rptr->addr.dma, db->rptr->len);
         |                                    ~~~~~~~~~~~~~~~~~~
         |                                                  |
         |                                                  dma_addr_t {aka unsigned int}
   include/linux/dynamic_debug.h:224:29: note: in definition of macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:277:9: note: in expansion of macro '_dynamic_func_call'
     277 |         _dynamic_func_call(fmt, __dynamic_netdev_dbg,           \
         |         ^~~~~~~~~~~~~~~~~~
   include/net/net_debug.h:57:9: note: in expansion of macro 'dynamic_netdev_dbg'
      57 |         dynamic_netdev_dbg(__dev, format, ##args);              \
         |         ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/tehuti/tn40.c:1007:25: note: in expansion of macro 'netdev_dbg'
    1007 |                         netdev_dbg(priv->ndev, "pci_unmap_page 0x%llx len %d\n",
         |                         ^~~~~~~~~~
   drivers/net/ethernet/tehuti/tn40.c:1007:69: note: format string is defined here
    1007 |                         netdev_dbg(priv->ndev, "pci_unmap_page 0x%llx len %d\n",
         |                                                                  ~~~^
         |                                                                     |
         |                                                                     long long unsigned int
         |                                                                  %x


vim +154 drivers/net/ethernet/tehuti/tn40.c

   150	
   151	static void bdx_rx_reuse_page(struct bdx_priv *priv, struct rx_map *dm)
   152	{
   153		netdev_dbg(priv->ndev, "dm size %d off %d dma %p\n", dm->size, dm->off,
 > 154			   (void *)dm->dma);
   155		if (dm->off == 0) {
   156			netdev_dbg(priv->ndev, "unmap page %p size %d\n", (void *)dm->dma, dm->size);
   157			dma_unmap_page(&priv->pdev->dev, dm->dma, dm->size,
   158				       DMA_FROM_DEVICE);
   159		}
   160	}
   161	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

