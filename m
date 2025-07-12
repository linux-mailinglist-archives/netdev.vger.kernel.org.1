Return-Path: <netdev+bounces-206356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654C7B02BF4
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 18:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC973A47074
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 16:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68026289357;
	Sat, 12 Jul 2025 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJ8JCnwj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699C419D07A;
	Sat, 12 Jul 2025 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752338586; cv=none; b=QLkYpHBLRtA1R7cLS7uS88QVGXNtEwzcdPdOPDE2FVMznEBxsbaltgNJSy8D3g0B1yCNTLx2jImGD25D9V/dngeBl88cZi2mQh8avzaQwy4RQ3fDzJ5eefpJ8F3VUsLYV9oDtnJXYz6f/LyWR0ZsCOoTzCN5027gKt96fdaaC44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752338586; c=relaxed/simple;
	bh=Rri1++R5Mh+ArHcShmUW90XLxoQLjLZ/i3z5PUc7XjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEDtok0UA7OqhdXKVSokink377uoSwmktRzNfFlG2k1dcgO02EjTDZmCUHRe9XIJfHY/6vVty8g7AtQvlbQUOuSf0TuVU7t2l9RbaH5I/kSuijRJu5WVCJunQDEwDxgQJgum0OH4oc7zmJpe9ANvGIj44pIOdnPz7WcYFEDEU1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJ8JCnwj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752338585; x=1783874585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rri1++R5Mh+ArHcShmUW90XLxoQLjLZ/i3z5PUc7XjU=;
  b=lJ8JCnwjRulcHrcO4sSdcQoo9B2r/5PhD8P9QsDGkJ+Y6t6FPG+DBHSe
   5LwEbcuH3+F+P1z5pkmhx0c6qFMEJS5f4guESSWzlI8/tel1FnIStirM4
   +TxHrQ4YCsCqeRe2oPm2w2tjSeF5A5NSi0wyeDI7LgmhnOcd61/AwH8rf
   f7u3vlwkK31UAE5d7Xv1x0J1Ts4oNk+om7YhY/SOZc2LwbgnPgjsMwUMd
   yv/kccN+E0XWHlZYVt0k1C5a1WnzgDZ1UD8ouolTWByvOx+DPQt1B6smF
   UmGdIF3u8YcL7fuEtxuwCPWAYodkfCs+Oo7QmCnQhnDCHixOur9AiP2V7
   Q==;
X-CSE-ConnectionGUID: RN4tk6KhTxyLvXcT/O6YMw==
X-CSE-MsgGUID: cxUcSZ//S1qiQbnp17NrLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54471794"
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="54471794"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 09:43:04 -0700
X-CSE-ConnectionGUID: lr4zHb6GRf+mHtRFVyPxQA==
X-CSE-MsgGUID: 4YNDfRDTRfe3BMB5ZTxEbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="156931840"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 12 Jul 2025 09:42:59 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uadJR-0007Up-1L;
	Sat, 12 Jul 2025 16:42:57 +0000
Date: Sun, 13 Jul 2025 00:42:31 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Fang <wei.fang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, fushi.peng@nxp.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next 11/12] net: enetc: add PTP synchronization
 support for ENETC v4
Message-ID: <202507130049.KLM4A8GG-lkp@intel.com>
References: <20250711065748.250159-12-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711065748.250159-12-wei.fang@nxp.com>

Hi Wei,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Fang/dt-bindings-ptp-add-bindings-for-NETC-Timer/20250711-152311
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250711065748.250159-12-wei.fang%40nxp.com
patch subject: [PATCH net-next 11/12] net: enetc: add PTP synchronization support for ENETC v4
config: loongarch-randconfig-r062-20250712 (https://download.01.org/0day-ci/archive/20250713/202507130049.KLM4A8GG-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 01c97b4953e87ae455bd4c41e3de3f0f0f29c61c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250713/202507130049.KLM4A8GG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507130049.KLM4A8GG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/freescale/enetc/enetc.c:3340:7: error: call to undeclared function 'enetc_ptp_clock_is_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    3340 |         if (!enetc_ptp_clock_is_enabled(priv->si))
         |              ^
   drivers/net/ethernet/freescale/enetc/enetc.c:3390:7: error: call to undeclared function 'enetc_ptp_clock_is_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    3390 |         if (!enetc_ptp_clock_is_enabled(priv->si))
         |              ^
   drivers/net/ethernet/freescale/enetc/enetc.c:3602:46: warning: shift count >= width of type [-Wshift-count-overflow]
    3602 |         err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
         |                                                     ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
      73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   1 warning and 2 errors generated.
--
>> drivers/net/ethernet/freescale/enetc/enetc_ethtool.c:927:7: error: call to undeclared function 'enetc_ptp_clock_is_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     927 |         if (!enetc_ptp_clock_is_enabled(si))
         |              ^
   1 error generated.


vim +/enetc_ptp_clock_is_enabled +3340 drivers/net/ethernet/freescale/enetc/enetc.c

  3332	
  3333	int enetc_hwtstamp_set(struct net_device *ndev,
  3334			       struct kernel_hwtstamp_config *config,
  3335			       struct netlink_ext_ack *extack)
  3336	{
  3337		struct enetc_ndev_priv *priv = netdev_priv(ndev);
  3338		int err, new_offloads = priv->active_offloads;
  3339	
> 3340		if (!enetc_ptp_clock_is_enabled(priv->si))
  3341			return -EOPNOTSUPP;
  3342	
  3343		switch (config->tx_type) {
  3344		case HWTSTAMP_TX_OFF:
  3345			new_offloads &= ~ENETC_F_TX_TSTAMP_MASK;
  3346			break;
  3347		case HWTSTAMP_TX_ON:
  3348			new_offloads &= ~ENETC_F_TX_TSTAMP_MASK;
  3349			new_offloads |= ENETC_F_TX_TSTAMP;
  3350			break;
  3351		case HWTSTAMP_TX_ONESTEP_SYNC:
  3352			if (!enetc_si_is_pf(priv->si))
  3353				return -EOPNOTSUPP;
  3354	
  3355			new_offloads &= ~ENETC_F_TX_TSTAMP_MASK;
  3356			new_offloads |= ENETC_F_TX_ONESTEP_SYNC_TSTAMP;
  3357			break;
  3358		default:
  3359			return -ERANGE;
  3360		}
  3361	
  3362		switch (config->rx_filter) {
  3363		case HWTSTAMP_FILTER_NONE:
  3364			new_offloads &= ~ENETC_F_RX_TSTAMP;
  3365			break;
  3366		default:
  3367			new_offloads |= ENETC_F_RX_TSTAMP;
  3368			config->rx_filter = HWTSTAMP_FILTER_ALL;
  3369		}
  3370	
  3371		if ((new_offloads ^ priv->active_offloads) & ENETC_F_RX_TSTAMP) {
  3372			bool extended = !!(new_offloads & ENETC_F_RX_TSTAMP);
  3373	
  3374			err = enetc_reconfigure(priv, extended, NULL, NULL);
  3375			if (err)
  3376				return err;
  3377		}
  3378	
  3379		priv->active_offloads = new_offloads;
  3380	
  3381		return 0;
  3382	}
  3383	EXPORT_SYMBOL_GPL(enetc_hwtstamp_set);
  3384	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

