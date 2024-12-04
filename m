Return-Path: <netdev+bounces-148887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8351B9E3533
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A055B360A8
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD291AF0A4;
	Wed,  4 Dec 2024 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUcR8Tdh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847B41AE876;
	Wed,  4 Dec 2024 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299161; cv=none; b=OjKyzjYc5CU3i28nTlgcQrgPAV5kGSvdzqAhWVScsxq38fyEogEWzMxJe/elMd2S3J6s/1oZcwQlYuO9sh+yQcgVjwfzs1YlhCrO0uwIzf7Nla5c0Kq174wiyzeh800wKBHn5seGCEtFHjz3v8CeVxenmnXx7G6UlM/IkTAGOhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299161; c=relaxed/simple;
	bh=rjw6F3m54cN6FFFuRReZrj6CVL8zRG63qtVX2uMNiOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dD3EeGsUK7jKQ73nwOLGJTzZZ3CoEVgLHGncSdLUJPzG8btucCshKC2E5poDOAHVYCFQ6XrbCRs9Uss1U1e+JovaUOMrnlhyZDNn+PnlXx+lx19DvdXkqShEaKD5p45p7AdxDUZ4yBB5sRatYD6PhsVEeZceT5LGS/ZRRLnwDJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUcR8Tdh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733299160; x=1764835160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rjw6F3m54cN6FFFuRReZrj6CVL8zRG63qtVX2uMNiOY=;
  b=QUcR8Tdh1Z37T1g3PBK8G/reDHJobBuDibfqKylVJWZqa3Bae+4nR9BH
   AERKn620jkDeXmfPr1uwmeoYikPteNjVlKrKrguUHkSeYlhtw4OSNXjp3
   k6VBkjRZGk7nKXLuZikVRg0oOvywtCMamUsWQcx8PvcXOmz8RiJM7Bi00
   Wo7FD5HHQzzVkfvezRf8FRWc0ANgQttFzlTH8VK2urrrfLGQ69x+7qbeR
   8y8UQxo0RzzBB7yNZH9vPfXWODPKzCW93Z2SjgxHk2XCxyN+AEaojUahN
   2rmJYTT2LCuYIndWqkLfBHWsDhezPGYjA5jaKafLfad3Ijvr3HqFbL1l5
   w==;
X-CSE-ConnectionGUID: j9FI3y2AS5mXvd6xPXXq0w==
X-CSE-MsgGUID: lgYrisdeQFaxasD0cIF9xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37489223"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="37489223"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 23:59:19 -0800
X-CSE-ConnectionGUID: O+inB0qeSrCGWFOhV5KGJw==
X-CSE-MsgGUID: e0xiNP/WSAel1C9qSXwlDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98707703"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 03 Dec 2024 23:59:16 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIkHq-0002jD-1M;
	Wed, 04 Dec 2024 07:59:11 +0000
Date: Wed, 4 Dec 2024 15:58:07 +0800
From: kernel test robot <lkp@intel.com>
To: Zhiyuan Wan <kmlinuxm@gmail.com>, andrew@lunn.ch
Cc: oe-kbuild-all@lists.linux.dev, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, willy.liu@realtek.com,
	Zhiyuan Wan <kmlinuxm@gmail.com>
Subject: Re: [PATCH net-next] net: phy: realtek: disable broadcast address
 feature of rtl8211f
Message-ID: <202412041557.EtqjkJE5-lkp@intel.com>
References: <20241203125430.2078090-1-kmlinuxm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203125430.2078090-1-kmlinuxm@gmail.com>

Hi Zhiyuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhiyuan-Wan/net-phy-realtek-disable-broadcast-address-feature-of-rtl8211f/20241203-205751
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241203125430.2078090-1-kmlinuxm%40gmail.com
patch subject: [PATCH net-next] net: phy: realtek: disable broadcast address feature of rtl8211f
config: i386-buildonly-randconfig-006 (https://download.01.org/0day-ci/archive/20241204/202412041557.EtqjkJE5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412041557.EtqjkJE5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412041557.EtqjkJE5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/phy/realtek.c: In function 'rtl821x_probe':
>> drivers/net/phy/realtek.c:147:51: warning: passing argument 1 of 'PTR_ERR' makes pointer from integer without a cast [-Wint-conversion]
     147 |                 return dev_err_probe(dev, PTR_ERR(ret),
         |                                                   ^~~
         |                                                   |
         |                                                   int
   In file included from include/linux/kernfs.h:9,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:18,
                    from drivers/net/phy/realtek.c:11:
   include/linux/err.h:52:61: note: expected 'const void *' but argument is of type 'int'
      52 | static inline long __must_check PTR_ERR(__force const void *ptr)
         |                                                 ~~~~~~~~~~~~^~~


vim +/PTR_ERR +147 drivers/net/phy/realtek.c

   126	
   127	static int rtl821x_probe(struct phy_device *phydev)
   128	{
   129		struct device *dev = &phydev->mdio.dev;
   130		struct rtl821x_priv *priv;
   131		u32 phy_id = phydev->drv->phy_id;
   132		int ret;
   133	
   134		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
   135		if (!priv)
   136			return -ENOMEM;
   137	
   138		priv->clk = devm_clk_get_optional_enabled(dev, NULL);
   139		if (IS_ERR(priv->clk))
   140			return dev_err_probe(dev, PTR_ERR(priv->clk),
   141					     "failed to get phy clock\n");
   142	
   143		dev_dbg(dev, "disabling MDIO address 0 for this phy");
   144		ret = phy_modify_paged(phydev, 0xa43, RTL8211F_PHYCR1,
   145					       RTL8211F_PHYAD0_EN, 0);
   146		if (ret < 0) {
 > 147			return dev_err_probe(dev, PTR_ERR(ret),
   148					     "disabling MDIO address 0 failed\n");
   149		}
   150		/* Deny broadcast address as PHY address */
   151		if (phydev->mdio.addr == 0)
   152			return -ENODEV;
   153	
   154		ret = phy_read_paged(phydev, 0xa43, RTL8211F_PHYCR1);
   155		if (ret < 0)
   156			return ret;
   157	
   158		priv->phycr1 = ret & (RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF);
   159		if (of_property_read_bool(dev->of_node, "realtek,aldps-enable"))
   160			priv->phycr1 |= RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF;
   161	
   162		priv->has_phycr2 = !(phy_id == RTL_8211FVD_PHYID);
   163		if (priv->has_phycr2) {
   164			ret = phy_read_paged(phydev, 0xa43, RTL8211F_PHYCR2);
   165			if (ret < 0)
   166				return ret;
   167	
   168			priv->phycr2 = ret & RTL8211F_CLKOUT_EN;
   169			if (of_property_read_bool(dev->of_node, "realtek,clkout-disable"))
   170				priv->phycr2 &= ~RTL8211F_CLKOUT_EN;
   171		}
   172	
   173		phydev->priv = priv;
   174	
   175		return 0;
   176	}
   177	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

