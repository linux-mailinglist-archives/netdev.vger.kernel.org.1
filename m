Return-Path: <netdev+bounces-167604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A0FA3B052
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 05:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058CC1891EA4
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 04:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BFC1A5BA9;
	Wed, 19 Feb 2025 04:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUNQy1LQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4433FD4;
	Wed, 19 Feb 2025 04:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739938868; cv=none; b=s3V40YNTkvbUXKZlEObTjpHwrCKS6Amr7C3x/w4VTkNNBcBQHBzCUPDv/WRQuS+gWcC1XgIvTh8VBN7HK6y3fU1xI281ruGl9nRufMChCYxo8zN+64j8hs34LtAoHG2dyzj07OaTGnV2/sThOPqAkfcEWvLLaSaGeJKCh6jg/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739938868; c=relaxed/simple;
	bh=ckkrBzfsdso+T2awCaIUQiZvGU2IkHGhc+H4I3t65fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4dyvZhK23ZmjEgpQyF8XKIwn8g+ct4F79njVN5RQzoVUe9kvSqP7K0amKoOIshp9jSK1jSEHqZIC5f8qcGsA4Op/nMYN5YlqjDmmCWWyV8VUVkMacMY/SGc83vuQpGjxtL3nCuGi6vpwdZ5+6QtiDKc400zPK5pcc1oTBSsPcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUNQy1LQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739938866; x=1771474866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ckkrBzfsdso+T2awCaIUQiZvGU2IkHGhc+H4I3t65fk=;
  b=aUNQy1LQbgusN+UJddcOhVHRX4DLb2DzY/qDOIRZggrE/pL0mG5DkdnF
   TZdHNZ0ylAJ7h+AAAW7/U8y/WK8HLzNYYU7ZsqMllt9HKszmieLjGaipD
   ruvaNJotIUZiaNWeN2Y1dvIEb7UjJJgaUXOXmjLGKtgD1Qgvc4/EsmFjs
   SN0DfLo7/zOrS7s12RHA3CskNU1imrfwk7o+8aEOUUOh6+t5xEuzpKW/r
   Hduu56YUy5yv03S7RA8QreGy9FteoUp8gISZNCRrYeAtj4UvqApsFPASi
   p4i9YLxGtkRGpo6oj9AGdwImxwKftdtt0GXl+XpEC4SmrbCflgLHLypdp
   Q==;
X-CSE-ConnectionGUID: dkuShneJRg2y4fZiEKjyIQ==
X-CSE-MsgGUID: XrkXwP7zQ+KEHxFspGr0ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="58062440"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="58062440"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 20:21:05 -0800
X-CSE-ConnectionGUID: V8xrp3+cQyG9v96azC7CMA==
X-CSE-MsgGUID: xx5oaXeYT06QKPJpPoD3MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114450358"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 18 Feb 2025 20:20:59 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkbZB-0001EN-1J;
	Wed, 19 Feb 2025 04:20:49 +0000
Date: Wed, 19 Feb 2025 12:18:57 +0800
From: kernel test robot <lkp@intel.com>
To: Kyle Hendry <kylehendrydev@gmail.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?iso-8859-1?Q?Fern=E1ndez?= Rojas <noltari@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Kyle Hendry <kylehendrydev@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] net: phy: bcm63xx: add support for BCM63268 GPHY
Message-ID: <202502191212.s0NqhQ3T-lkp@intel.com>
References: <20250218013653.229234-2-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218013653.229234-2-kylehendrydev@gmail.com>

Hi Kyle,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on robh/for-next lee-leds/for-leds-next linus/master lee-mfd/for-mfd-fixes v6.14-rc3 next-20250218]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kyle-Hendry/net-phy-bcm63xx-add-support-for-BCM63268-GPHY/20250218-094117
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/20250218013653.229234-2-kylehendrydev%40gmail.com
patch subject: [PATCH v2 1/5] net: phy: bcm63xx: add support for BCM63268 GPHY
config: x86_64-buildonly-randconfig-004-20250219 (https://download.01.org/0day-ci/archive/20250219/202502191212.s0NqhQ3T-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250219/202502191212.s0NqhQ3T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502191212.s0NqhQ3T-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/bcm63xx.c:84:5: warning: no previous prototype for function 'bcm63268_gphy_set' [-Wmissing-prototypes]
      84 | int bcm63268_gphy_set(struct phy_device *phydev, bool enable)
         |     ^
   drivers/net/phy/bcm63xx.c:84:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      84 | int bcm63268_gphy_set(struct phy_device *phydev, bool enable)
         | ^
         | static 
>> drivers/net/phy/bcm63xx.c:100:5: warning: no previous prototype for function 'bcm63268_gphy_resume' [-Wmissing-prototypes]
     100 | int bcm63268_gphy_resume(struct phy_device *phydev)
         |     ^
   drivers/net/phy/bcm63xx.c:100:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     100 | int bcm63268_gphy_resume(struct phy_device *phydev)
         | ^
         | static 
>> drivers/net/phy/bcm63xx.c:115:5: warning: no previous prototype for function 'bcm63268_gphy_suspend' [-Wmissing-prototypes]
     115 | int bcm63268_gphy_suspend(struct phy_device *phydev)
         |     ^
   drivers/net/phy/bcm63xx.c:115:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     115 | int bcm63268_gphy_suspend(struct phy_device *phydev)
         | ^
         | static 
   3 warnings generated.


vim +/bcm63268_gphy_set +84 drivers/net/phy/bcm63xx.c

    83	
  > 84	int bcm63268_gphy_set(struct phy_device *phydev, bool enable)
    85	{
    86		struct bcm_gphy_priv *priv = phydev->priv;
    87		u32 pwr_bits;
    88		int ret;
    89	
    90		pwr_bits = GPHY_CTRL_IDDQ_BIAS | GPHY_CTRL_LOW_PWR;
    91	
    92		if (enable)
    93			ret = regmap_update_bits(priv->gphy_ctrl, 0, pwr_bits, 0);
    94		else
    95			ret = regmap_update_bits(priv->gphy_ctrl, 0, pwr_bits, pwr_bits);
    96	
    97		return ret;
    98	}
    99	
 > 100	int bcm63268_gphy_resume(struct phy_device *phydev)
   101	{
   102		int ret;
   103	
   104		ret = bcm63268_gphy_set(phydev, true);
   105		if (ret)
   106			return ret;
   107	
   108		ret = genphy_resume(phydev);
   109		if (ret)
   110			return ret;
   111	
   112		return 0;
   113	}
   114	
 > 115	int bcm63268_gphy_suspend(struct phy_device *phydev)
   116	{
   117		int ret;
   118	
   119		ret = genphy_suspend(phydev);
   120		if (ret)
   121			return ret;
   122	
   123		ret = bcm63268_gphy_set(phydev, false);
   124		if (ret)
   125			return ret;
   126	
   127		return 0;
   128	}
   129	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

