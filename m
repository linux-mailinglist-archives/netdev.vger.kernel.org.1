Return-Path: <netdev+bounces-163488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7C2A2A5FD
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 11:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B601889BFC
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4C8227593;
	Thu,  6 Feb 2025 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0+shFSY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D703227580;
	Thu,  6 Feb 2025 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738838407; cv=none; b=QHxNkABCZ2rG5cQwWiz7EUHfncD6lrT9s7vg7qAVfYormItOUnLzZQuc3hdV/KwceN+DL/Wii13nUD9bVOiBu2I5ieLnMSpE8weicSWXhFclpkVY0MqIvZa6m05Qs34y2Bu0b5jKnlF31F74245HnYbgM9aTHp/ZhklBjHsRPEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738838407; c=relaxed/simple;
	bh=FdibQnL131/L0M2R5AMACpiiKHrQgNDDYYi3NknCtAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLouGzWj5qZ85DqW0TQ1JYhK0QMSIIttyN3KMCLKirUAFhkuCtzoa7UdyYQrNyvGoU5t+BIJ1Y1S2vqhbI67sU5Ltc5vG37HC4FobXs+sbbx9v7f9yHjT1v/qg8AgA6vg3ZNRXPUkbn0r+TXYMdCXWbaGzqM9INCSGZd+1Jh2qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D0+shFSY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738838406; x=1770374406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FdibQnL131/L0M2R5AMACpiiKHrQgNDDYYi3NknCtAE=;
  b=D0+shFSY4b9c89lynqr8NG8ajMYrhehj7fA8w8mFdBhDMdhGXrt3oVdm
   cEVCLzMMqZgADCP8NfgR6OLdLbtx2ADpnX02328MFQ2TqBWpWSmlKyZzd
   gMvMLXRPRVg+YKSrikdpXvXPDmqSiPHeF6CwnHPO3av0eCF5aWay8jWpS
   5swucZlgwVL9IJF5dGCxQwQLlgchPFO/gK2GojE/Ex0HFZLwwB5l2w8Y1
   tVWdLdkD1P+HnnNxF6QJyGX0XvuY1yOB5nOOwL6+zdYFYfpTfZ+OpbqJj
   jSFeZqGXnNygKr3yFPwtA87fbgJk6yJhvlRpg/dRDfspudrOo6vpf/fDf
   w==;
X-CSE-ConnectionGUID: emQLMxCzQ4aRWEwcywRbGQ==
X-CSE-MsgGUID: +IS1qzNJSUKR95gU5+xafw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49680106"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="49680106"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 02:40:06 -0800
X-CSE-ConnectionGUID: FsrH/Y1kTC+E0tbcEPoU9w==
X-CSE-MsgGUID: Buw5YOnuQZmiHLhcq5rqEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="142053882"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 06 Feb 2025 02:40:02 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tfzId-000wkl-1i;
	Thu, 06 Feb 2025 10:39:59 +0000
Date: Thu, 6 Feb 2025 18:39:16 +0800
From: kernel test robot <lkp@intel.com>
To: Jeroen de Borst <jeroendb@google.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jeroendb@google.com, pkaligineedi@google.com,
	shailend@google.com, andrew+netdev@lunn.ch, willemb@google.com,
	hramamurthy@google.com, ziweixiao@google.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, Jeroen de Borst <jeroend@google.com>
Subject: Re: [PATCH net-next v2] gve: Add RSS cache for non RSS device option
 scenario
Message-ID: <202502061802.Co0dVfXU-lkp@intel.com>
References: <20250204213121.14195-1-jeroendb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204213121.14195-1-jeroendb@google.com>

Hi Jeroen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeroen-de-Borst/gve-Add-RSS-cache-for-non-RSS-device-option-scenario/20250205-053317
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250204213121.14195-1-jeroendb%40google.com
patch subject: [PATCH net-next v2] gve: Add RSS cache for non RSS device option scenario
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250206/202502061802.Co0dVfXU-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250206/202502061802.Co0dVfXU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502061802.Co0dVfXU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/google/gve/gve_ethtool.c:7:
   In file included from include/linux/rtnetlink.h:7:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/google/gve/gve_ethtool.c:502:6: warning: variable 'reset_rss' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     502 |         if (new_rx != priv->rx_cfg.num_queues &&
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     503 |             priv->cache_rss_config && !netif_is_rxfh_configured(netdev))
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/google/gve/gve_ethtool.c:509:57: note: uninitialized use occurs here
     509 |         return gve_adjust_queues(priv, new_rx_cfg, new_tx_cfg, reset_rss);
         |                                                                ^~~~~~~~~
   drivers/net/ethernet/google/gve/gve_ethtool.c:502:2: note: remove the 'if' if its condition is always true
     502 |         if (new_rx != priv->rx_cfg.num_queues &&
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     503 |             priv->cache_rss_config && !netif_is_rxfh_configured(netdev))
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     504 |                 reset_rss = true;
>> drivers/net/ethernet/google/gve/gve_ethtool.c:502:6: warning: variable 'reset_rss' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
     502 |         if (new_rx != priv->rx_cfg.num_queues &&
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     503 |             priv->cache_rss_config && !netif_is_rxfh_configured(netdev))
         |             ~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/google/gve/gve_ethtool.c:509:57: note: uninitialized use occurs here
     509 |         return gve_adjust_queues(priv, new_rx_cfg, new_tx_cfg, reset_rss);
         |                                                                ^~~~~~~~~
   drivers/net/ethernet/google/gve/gve_ethtool.c:502:6: note: remove the '&&' if its condition is always true
     502 |         if (new_rx != priv->rx_cfg.num_queues &&
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     503 |             priv->cache_rss_config && !netif_is_rxfh_configured(netdev))
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/google/gve/gve_ethtool.c:502:6: warning: variable 'reset_rss' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
     502 |         if (new_rx != priv->rx_cfg.num_queues &&
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/google/gve/gve_ethtool.c:509:57: note: uninitialized use occurs here
     509 |         return gve_adjust_queues(priv, new_rx_cfg, new_tx_cfg, reset_rss);
         |                                                                ^~~~~~~~~
   drivers/net/ethernet/google/gve/gve_ethtool.c:502:6: note: remove the '&&' if its condition is always true
     502 |         if (new_rx != priv->rx_cfg.num_queues &&
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/google/gve/gve_ethtool.c:485:16: note: initialize the variable 'reset_rss' to silence this warning
     485 |         bool reset_rss;
         |                       ^
         |                        = 0
   6 warnings generated.


vim +502 drivers/net/ethernet/google/gve/gve_ethtool.c

   475	
   476	static int gve_set_channels(struct net_device *netdev,
   477				    struct ethtool_channels *cmd)
   478	{
   479		struct gve_priv *priv = netdev_priv(netdev);
   480		struct gve_queue_config new_tx_cfg = priv->tx_cfg;
   481		struct gve_queue_config new_rx_cfg = priv->rx_cfg;
   482		struct ethtool_channels old_settings;
   483		int new_tx = cmd->tx_count;
   484		int new_rx = cmd->rx_count;
   485		bool reset_rss;
   486	
   487		gve_get_channels(netdev, &old_settings);
   488	
   489		/* Changing combined is not allowed */
   490		if (cmd->combined_count != old_settings.combined_count)
   491			return -EINVAL;
   492	
   493		if (!new_rx || !new_tx)
   494			return -EINVAL;
   495	
   496		if (priv->num_xdp_queues &&
   497		    (new_tx != new_rx || (2 * new_tx > priv->tx_cfg.max_queues))) {
   498			dev_err(&priv->pdev->dev, "XDP load failed: The number of configured RX queues should be equal to the number of configured TX queues and the number of configured RX/TX queues should be less than or equal to half the maximum number of RX/TX queues");
   499			return -EINVAL;
   500		}
   501	
 > 502		if (new_rx != priv->rx_cfg.num_queues &&
   503		    priv->cache_rss_config && !netif_is_rxfh_configured(netdev))
   504			reset_rss = true;
   505	
   506		new_tx_cfg.num_queues = new_tx;
   507		new_rx_cfg.num_queues = new_rx;
   508	
 > 509		return gve_adjust_queues(priv, new_rx_cfg, new_tx_cfg, reset_rss);
   510	}
   511	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

