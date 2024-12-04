Return-Path: <netdev+bounces-148803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47109E32C2
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 05:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11D71678F1
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 04:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B43D17A597;
	Wed,  4 Dec 2024 04:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcvFX56B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8353B192;
	Wed,  4 Dec 2024 04:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733287720; cv=none; b=lFzuMIgEiOkEw26PNJA2ZHw3KaTk3r7s0QqAvYnsb97LZuwZidkFlW1oWniuyhEQcBLzvnU79ijaPlViFukFbNiNN0u2assTZ7v/jNF4KfQNHmVFOfqIrQHqJbcKG4Avt/rKFAhTRLL2lOmwaWOaiwne3p4o4kzMvCuSIPEtdBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733287720; c=relaxed/simple;
	bh=hxH3Ca85gKY3h+glCmXY6pry3O7lllgZ7KRXnLA6w8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ykr+CJOrv/s2jP0pShdQ72ZjimkZJEC8dP9oIv42vgJ7ujWJAbJ5MccBRNHwuQEWjhKjEBUA2wJNqPf+q25/YKTG40EJgWO7vXWR2eKU645Fb+QNXr1FozcpLai2lmdbXbBa9eWT8EmLN1vIaewC701sN4c2dYfeJfHMaGVeBd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcvFX56B; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733287717; x=1764823717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hxH3Ca85gKY3h+glCmXY6pry3O7lllgZ7KRXnLA6w8U=;
  b=AcvFX56B5Zzw3hvJ+RA9YiJ49RrpTbZuDhQd9YBCiaOeL2WF9GONEJjX
   RiA0jxOwfGpl5lJstFrbgxEjT8PF0UnNN9LcmlJ1CjPlFXhiohnWzxXsZ
   u4oh848DFLoiUr1Aa9OXHxmm7VTCJeuR6OrcxznXtt8JUHyAWxIfrezHR
   ohp9vuocIJcacErxSpPl0pEFYQj22PNzfn49U1rBEm4LSvUrp1GdTp7/R
   IAP+OIpxkKeTnlg3I0Buq/W7/qNwZ2PCz5GNJzXZcrBkKdABr9h9SdXr2
   9XABrimV7mblG5rdLIOIMiPbTRNcXCutKS00AztJmAcDiCXRuf/bx8XDK
   Q==;
X-CSE-ConnectionGUID: TST0IwpHQqG14jZiAjqswA==
X-CSE-MsgGUID: emNrpWAkTnyRGvkL0JveqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33670020"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="33670020"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 20:48:36 -0800
X-CSE-ConnectionGUID: qfPjScBATOugZ76VSQroDA==
X-CSE-MsgGUID: mpEKrRGgTNCsCC+pHq9aQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="98454788"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 03 Dec 2024 20:48:33 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIhJO-0002az-39;
	Wed, 04 Dec 2024 04:48:30 +0000
Date: Wed, 4 Dec 2024 12:47:59 +0800
From: kernel test robot <lkp@intel.com>
To: Zhiyuan Wan <kmlinuxm@gmail.com>, andrew@lunn.ch
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy.liu@realtek.com, Zhiyuan Wan <kmlinuxm@gmail.com>
Subject: Re: [PATCH net-next] net: phy: realtek: disable broadcast address
 feature of rtl8211f
Message-ID: <202412041255.6r9ogs5i-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhiyuan-Wan/net-phy-realtek-disable-broadcast-address-feature-of-rtl8211f/20241203-205751
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241203125430.2078090-1-kmlinuxm%40gmail.com
patch subject: [PATCH net-next] net: phy: realtek: disable broadcast address feature of rtl8211f
config: arm-randconfig-002-20241204 (https://download.01.org/0day-ci/archive/20241204/202412041255.6r9ogs5i-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412041255.6r9ogs5i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412041255.6r9ogs5i-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/phy/realtek.c:12:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/arm/include/asm/cacheflush.h:10:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/net/phy/realtek.c:147:37: error: incompatible integer to pointer conversion passing 'int' to parameter of type 'const void *' [-Wint-conversion]
     147 |                 return dev_err_probe(dev, PTR_ERR(ret),
         |                                                   ^~~
   include/linux/err.h:52:61: note: passing argument to parameter 'ptr' here
      52 | static inline long __must_check PTR_ERR(__force const void *ptr)
         |                                                             ^
   1 warning and 1 error generated.


vim +147 drivers/net/phy/realtek.c

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

