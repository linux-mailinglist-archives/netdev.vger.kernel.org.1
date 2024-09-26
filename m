Return-Path: <netdev+bounces-129939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CB09871F0
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 12:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00AFDB2AA05
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 10:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71411AB51F;
	Thu, 26 Sep 2024 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9DcKNdA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D6A1A726A;
	Thu, 26 Sep 2024 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347642; cv=none; b=PzS4IqD4tXUdkhnnWLMaLbnPakJJoScdpM5NyeNCA447EsKcK+Vx+4GJ6D8Hzebztbf3Ji61ROP9tmg1dP1sjEoqDeMVDE7NemSon5AfyfsqrcYTk8966TlS4xC3y2MCLSm8PndQg/DR3ylmiXR+g9VdnvHkmDJydrCD8BysvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347642; c=relaxed/simple;
	bh=kgTVEDiu1C/X/bxty3fOtvH3nFttn5jCBkrGOQolGMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFCU82b0DWwP2uGqTlGYzgibXUD9PnNOJGgo8BL1cEdQTaxtBsmGew5qyuTy7lX70ycyPWk4n7mkmBEcTNyQMhkXJntJteSUGgQrs/92QQWoAeQj9GXMcHFN6htYsjdAIoN8Jfo9mQODEgXr/VIuagpbHBO37ZqLV6qvoiDOFb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9DcKNdA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727347640; x=1758883640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kgTVEDiu1C/X/bxty3fOtvH3nFttn5jCBkrGOQolGMY=;
  b=O9DcKNdA00uVRzt3SVy0fP7ktS0AhFeoCCqPRiLMz/M2ZD0yFrucTL/y
   nWPvdjLN1QOBAfHuKyCmgYKOisjnY/Iw/7riJ98OAqm0Xbzte/qZlIKyW
   6qCbZEHXr/FzwLY1FZ5SW5/W4L5dWVbOf55iDTOATM1SSet0orkIFkp+x
   LklF8bql2r3dJk5YVTkzhfm7XU97QdNPb7miuh6zIV5zPV3tsvIicIUfz
   iUeaA+XwL3fJWf0lvwjjX1+11/n3vD+604slKkwZbe8Cz9GEtz5fnivN9
   zO3+sVO+ZdHuC74cfVMe135izcJuER2fnu7tMuMFUddDZ+8Cqo/CXfzgD
   Q==;
X-CSE-ConnectionGUID: WZzqkdRWQoewGqnZk02cww==
X-CSE-MsgGUID: S7JOb7iSTfu9IOmNSPJoeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="43947437"
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="43947437"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 03:47:11 -0700
X-CSE-ConnectionGUID: VBop/fJUTtWTJG9YeZpqjw==
X-CSE-MsgGUID: f6+mt1YJQeKm6knOr+RLSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="76870270"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 26 Sep 2024 03:47:08 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stm1Z-000KaF-1o;
	Thu, 26 Sep 2024 10:47:05 +0000
Date: Thu, 26 Sep 2024 18:46:28 +0800
From: kernel test robot <lkp@intel.com>
To: Dipendra Khadka <kdipendra88@gmail.com>, florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, horms@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Dipendra Khadka <kdipendra88@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: systemport: Add error pointer checks in
 bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
Message-ID: <202409261836.eGX8TVKA-lkp@intel.com>
References: <20240925152927.4579-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925152927.4579-1-kdipendra88@gmail.com>

Hi Dipendra,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Dipendra-Khadka/net-systemport-Add-error-pointer-checks-in-bcm_sysport_map_queues-and-bcm_sysport_unmap_queues/20240925-233508
base:   net/main
patch link:    https://lore.kernel.org/r/20240925152927.4579-1-kdipendra88%40gmail.com
patch subject: [PATCH net v4] net: systemport: Add error pointer checks in bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240926/202409261836.eGX8TVKA-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240926/202409261836.eGX8TVKA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409261836.eGX8TVKA-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/broadcom/bcmsysport.c:11:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/ethernet/broadcom/bcmsysport.c:11:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/ethernet/broadcom/bcmsysport.c:11:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/broadcom/bcmsysport.c:14:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2232:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/net/ethernet/broadcom/bcmsysport.c:2401:21: error: expected ';' after return statement
    2401 |                 return PTR_ERR(dp));
         |                                   ^
         |                                   ;
   7 warnings and 1 error generated.


vim +2401 drivers/net/ethernet/broadcom/bcmsysport.c

  2389	
  2390	static int bcm_sysport_unmap_queues(struct net_device *dev,
  2391					    struct net_device *slave_dev)
  2392	{
  2393		struct bcm_sysport_priv *priv = netdev_priv(dev);
  2394		struct bcm_sysport_tx_ring *ring;
  2395		unsigned int num_tx_queues;
  2396		unsigned int q, qp, port;
  2397		struct dsa_port *dp;
  2398	
  2399		dp = dsa_port_from_netdev(slave_dev);
  2400		if (IS_ERR(dp))
> 2401			return PTR_ERR(dp));
  2402	
  2403		port = dp->index;
  2404	
  2405		num_tx_queues = slave_dev->real_num_tx_queues;
  2406	
  2407		for (q = 0; q < dev->num_tx_queues; q++) {
  2408			ring = &priv->tx_rings[q];
  2409	
  2410			if (ring->switch_port != port)
  2411				continue;
  2412	
  2413			if (!ring->inspect)
  2414				continue;
  2415	
  2416			ring->inspect = false;
  2417			qp = ring->switch_queue;
  2418			priv->ring_map[qp + port * num_tx_queues] = NULL;
  2419		}
  2420	
  2421		return 0;
  2422	}
  2423	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

