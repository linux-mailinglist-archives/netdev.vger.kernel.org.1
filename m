Return-Path: <netdev+bounces-206329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DC4B02AB3
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 13:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21F637B2E47
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 11:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850B9275868;
	Sat, 12 Jul 2025 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6vhnY2t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6426B752;
	Sat, 12 Jul 2025 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752321220; cv=none; b=C49mWQiLYnL6FAXxLgCHdD5Zj4ebQexa+hbzw+lB0/z/4p9/38VLf6G2a8dcR3+7hdHdjB3o3odOsQS/mN7rtE3VGaEbEIqfvq53hKrGoVtqSOPQbOAYZ9/aLyaZIT/nkULZT0KDDUOon7UlAQ7QLPWj5GMJ3Qh3l19GoCbHvKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752321220; c=relaxed/simple;
	bh=KzsTalIYYytvLpWidfkVgiBrJoufgmKXbomHVfz6euM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tykt16bEKBlcutxyL3+FjThd9LGGWisWguXDJJMpWXXPl8CUVcsELBDCsuM8I09EshMgM0nCVvde5kjkzqN424ZblKw7UQDVI31n+cEOUFtzLVHEABYa0LlprBWkiOCLVT/EPm6NReLGWxVqq2EW/i+852tvrvFDDoAxm82xWkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6vhnY2t; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752321219; x=1783857219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KzsTalIYYytvLpWidfkVgiBrJoufgmKXbomHVfz6euM=;
  b=R6vhnY2tzUF4tj8ASQLww7QOsxTlDHXdEC0asRme24MEB6GNxfwXoHmV
   QGfEH1lzIw9eziq2exULttTu6c64qZruShmy4YtyUEZ/qdqxaBhZogaw5
   X4EEuApGfgRU8C4rwrCWfplpwnLzP3ZbwMpKM2VPBlotsT+pCQatFrLDa
   G2ekCl3gU7EcKkSopWg20IuMdBQ63pORY+IjTXaT0OOgH0XP65pC0gNZv
   Dzi6IAu3qd6r5KwCl2EkKwxaFzlQbj2fWZ45vSxJLryCE/TJgSNKtg4nG
   kVZ8MY+KnfuDBt53uc63WZsSwZUTy2Qszh3nyc/9mKbyj5pyrJSIbLiY8
   w==;
X-CSE-ConnectionGUID: vnQtR/ShRJ+QhFBHi0VSjw==
X-CSE-MsgGUID: tx7XBnfXRZaA1cPvnnFupg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65944981"
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="65944981"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 04:53:38 -0700
X-CSE-ConnectionGUID: 3L8Qi3ocQ3Gr6VUkq7GnZw==
X-CSE-MsgGUID: snpBXbQgQbaujSSCHzNVkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="180240413"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 Jul 2025 04:53:34 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uaYnM-0007It-1W;
	Sat, 12 Jul 2025 11:53:32 +0000
Date: Sat, 12 Jul 2025 19:53:27 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Fang <wei.fang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, fushi.peng@nxp.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next 02/12] ptp: netc: add NETC Timer PTP driver
 support
Message-ID: <202507121901.cz1bRBUf-lkp@intel.com>
References: <20250711065748.250159-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711065748.250159-3-wei.fang@nxp.com>

Hi Wei,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Fang/dt-bindings-ptp-add-bindings-for-NETC-Timer/20250711-152311
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250711065748.250159-3-wei.fang%40nxp.com
patch subject: [PATCH net-next 02/12] ptp: netc: add NETC Timer PTP driver support
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20250712/202507121901.cz1bRBUf-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250712/202507121901.cz1bRBUf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507121901.cz1bRBUf-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/ptp/ptp_netc.c: In function 'netc_timer_adjust_period':
>> drivers/ptp/ptp_netc.c:161:20: error: implicit declaration of function 'u32_replace_bits' [-Wimplicit-function-declaration]
     161 |         tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
         |                    ^~~~~~~~~~~~~~~~


vim +/u32_replace_bits +161 drivers/ptp/ptp_netc.c

   150	
   151	static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
   152	{
   153		u32 fractional_period = lower_32_bits(period);
   154		u32 integral_period = upper_32_bits(period);
   155		u32 tmr_ctrl, old_tmr_ctrl;
   156		unsigned long flags;
   157	
   158		spin_lock_irqsave(&priv->lock, flags);
   159	
   160		old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
 > 161		tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
   162					    TMR_CTRL_TCLK_PERIOD);
   163		if (tmr_ctrl != old_tmr_ctrl)
   164			netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
   165	
   166		netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
   167	
   168		spin_unlock_irqrestore(&priv->lock, flags);
   169	}
   170	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

