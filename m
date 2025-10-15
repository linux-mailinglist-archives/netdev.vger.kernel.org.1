Return-Path: <netdev+bounces-229820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A8DBE10DC
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 01:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CEE18913A7
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 23:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F384316905;
	Wed, 15 Oct 2025 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3tgJbwu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C856E1E285A;
	Wed, 15 Oct 2025 23:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571834; cv=none; b=lOE/r/JyOHzOJV2nxbX4F983cMGoGJAWd8Qkk61oamXajs1Ynd/3D28jDr5y0SBtLKe1h1baGVIQi06wtn2gUSpKUM0pL+GZTaJDNJ879UhyhXrSz/qf6OHyLuLyR5C3gM/D2RO3/InbdefSPlcdnOaIWXB4/tNXsgfP+vf1o1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571834; c=relaxed/simple;
	bh=0xdTqDw9WUR1MHTE6JTRUHIGJ2mKZvvcYBTUUih42x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yw/rLc1yemoSFFcnVjuO7L7SyV8Ed4wzFzgdqrx1dygaKr31X/Q10c89wF2fZBLuiqtDbvYZJl585VKD6i5ohioEIbGPwQjOckWeBOD29Zs11IerYQqBF4ieIka0UzfuS/y0pyMkAPJbXR7VWGYf5qwIhIKf87v7h/tqmdljQOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3tgJbwu; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760571832; x=1792107832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0xdTqDw9WUR1MHTE6JTRUHIGJ2mKZvvcYBTUUih42x4=;
  b=K3tgJbwuU+EHnJwLDXudQqYISdk1LcmvH781B8it6NJMcaX7+FiHq0LI
   CyGYNUE+Fms9h1uqj2smU2OMB3OgNnEBXdgedZjiNYFHjWULTDL3vNCAk
   kTnVMxrctN+BrhUHtnitYP+OF9aotBJRCimVN5Npqt0sRhAZdFRLUbv03
   qd5N2jBlCrUwtjENCOhKgBSPGNTygwMWeZ5STqYEkGTibpQjgY4Dd88AW
   gimF8kd7yfqWkNTeQ85H+IBAlkU52xL1ZDC6PM4VpeD3dhcJLXc2UvSIl
   tc42gUxBuZ8dsjZ85j2Cc8eXgdKR7QJKVb3fnBDkYmpwP5JjUse53Rq9e
   g==;
X-CSE-ConnectionGUID: Hpyh25SQS1yRcA3/ye6QQQ==
X-CSE-MsgGUID: jieR0m0fTjOSMbb1ijqDEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="74204108"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="74204108"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 16:43:52 -0700
X-CSE-ConnectionGUID: Hso+wECATpWtOfTbPJ+EBQ==
X-CSE-MsgGUID: NhZgz1k0SL+mUJXovZND2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="181853552"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 15 Oct 2025 16:43:48 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9B9g-0004Id-38;
	Wed, 15 Oct 2025 23:43:42 +0000
Date: Thu, 16 Oct 2025 07:43:07 +0800
From: kernel test robot <lkp@intel.com>
To: Lizhe <sensor1010@163.com>, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, jonas@kwiboo.se,
	chaoyi.chen@rock-chips.com, david.wu@rock-chips.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: Re: [PATCH net-next] net: dwmac-rk: No need to check the return
 value of the phy_power_on()
Message-ID: <202510160726.OejMgsW0-lkp@intel.com>
References: <20251015040847.6421-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015040847.6421-1-sensor1010@163.com>

Hi Lizhe,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Lizhe/net-dwmac-rk-No-need-to-check-the-return-value-of-the-phy_power_on/20251015-121214
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251015040847.6421-1-sensor1010%40163.com
patch subject: [PATCH net-next] net: dwmac-rk: No need to check the return value of the phy_power_on()
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20251016/202510160726.OejMgsW0-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251016/202510160726.OejMgsW0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510160726.OejMgsW0-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c: In function 'rk_gmac_powerdown':
>> drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:1670:9: error: implicit declaration of function 'phy_power_on'; did you mean 'rk_phy_power_on'? [-Wimplicit-function-declaration]
    1670 |         phy_power_on(gmac, false);
         |         ^~~~~~~~~~~~
         |         rk_phy_power_on


vim +1670 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

7ad269ea1a2b7d Roger Chen            2014-12-29  1662  
229666c14c75ae Vincent Palatin       2016-06-15  1663  static void rk_gmac_powerdown(struct rk_priv_data *gmac)
7ad269ea1a2b7d Roger Chen            2014-12-29  1664  {
32c7bc0747bbd8 Jonas Karlman         2025-03-19  1665  	if (gmac->integrated_phy && gmac->ops->integrated_phy_powerdown)
32c7bc0747bbd8 Jonas Karlman         2025-03-19  1666  		gmac->ops->integrated_phy_powerdown(gmac);
fecd4d7eef8b21 David Wu              2017-08-10  1667  
8f6503993911f0 Russell King (Oracle  2025-06-16  1668) 	pm_runtime_put_sync(gmac->dev);
aec3f415f7244b Punit Agrawal         2021-09-29  1669  
7ad269ea1a2b7d Roger Chen            2014-12-29 @1670  	phy_power_on(gmac, false);
7ad269ea1a2b7d Roger Chen            2014-12-29  1671  	gmac_clk_enable(gmac, false);
7ad269ea1a2b7d Roger Chen            2014-12-29  1672  }
7ad269ea1a2b7d Roger Chen            2014-12-29  1673  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

