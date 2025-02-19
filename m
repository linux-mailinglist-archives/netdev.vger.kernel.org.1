Return-Path: <netdev+bounces-167605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88762A3B05F
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 05:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7961895C4F
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 04:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25CC1A8F9E;
	Wed, 19 Feb 2025 04:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJVVe53W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708771D554;
	Wed, 19 Feb 2025 04:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739939501; cv=none; b=ICw1BuIaieHlqSoAW5BQl6krDjKjnhrphSn9+RVbAbFxYt4ffSCbO0TIR5kEylpdys0N7YZ1wr73YdSkQwc/VJ+GCpDyDqct6JpPRS7PP/sV8VFJessI2BeMD3GyFIRYAGTiUPfp4iLJM+RqJ1sjeEyN3pOQohkbcUg5GiKI4h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739939501; c=relaxed/simple;
	bh=AAXRzVWm6+QKbg0q7VhMuL2NH/Rn8BgKA9ElBx5Gpkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulSETpBB2WCiDBXeaAN62Olm2I6+KxOZSxOGqSQMs9h5lAeECzeiJWTNkAU3QLnrdiCVm35A6/TQ43xgd07JFAGzqnxdzR80FKqIzV5cH48sqrJPk3VCOJ8k8aJtsJdNWK513cqoUwsbsmTExgJOoB+lO4kOkTaF3be4VBlbG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bJVVe53W; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739939499; x=1771475499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AAXRzVWm6+QKbg0q7VhMuL2NH/Rn8BgKA9ElBx5Gpkk=;
  b=bJVVe53WpXFSGwGjs9mqUhDGSG2kE6p/v0iuw/upFPWIed7RDabgRt1g
   4q6+oYPkjDa4S36YVFajqgqizDlElpLULvZWWLYtiLA8QU6sO0if/npBM
   Shy7GTqb91Ohs66ax0RD1OlngeXkNcTdvVvlW0i52D811kG2/ltp7ZUsp
   ZEMbUZ2PVi65TvUsIgwcuY5w1dBQ6yeFIqaJ76LzRhhFlvkNZRX1Cx2Sw
   Odnzmnwa4LbBsZuVltZGC8242xv5qeibNLg3qL7vPm7WktGPyyLolzu+u
   lr1RUqgWsTQmMlK+mU/fDZ/So/DkO9tGITx5i55EtkjUvfcWVWEKzwKf9
   g==;
X-CSE-ConnectionGUID: 23Uo4ECjTXuxIhT2VIAbQA==
X-CSE-MsgGUID: oV8RF4W4SVyogouH1h8m5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63138301"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="63138301"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 20:31:38 -0800
X-CSE-ConnectionGUID: anHUsH6hT9agwGAAhvmeDA==
X-CSE-MsgGUID: df/rmvh4QZyzvdSOMK+S+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="137837363"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 18 Feb 2025 20:31:34 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkbjw-0001Ep-2g;
	Wed, 19 Feb 2025 04:31:22 +0000
Date: Wed, 19 Feb 2025 12:29:47 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Kyle Hendry <kylehendrydev@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] net: phy: bcm63xx: add support for BCM63268 GPHY
Message-ID: <202502191246.zER47JXl-lkp@intel.com>
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
config: loongarch-randconfig-001-20250219 (https://download.01.org/0day-ci/archive/20250219/202502191246.zER47JXl-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250219/202502191246.zER47JXl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502191246.zER47JXl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/bcm63xx.c:84:5: warning: no previous prototype for 'bcm63268_gphy_set' [-Wmissing-prototypes]
      84 | int bcm63268_gphy_set(struct phy_device *phydev, bool enable)
         |     ^~~~~~~~~~~~~~~~~
>> drivers/net/phy/bcm63xx.c:100:5: warning: no previous prototype for 'bcm63268_gphy_resume' [-Wmissing-prototypes]
     100 | int bcm63268_gphy_resume(struct phy_device *phydev)
         |     ^~~~~~~~~~~~~~~~~~~~
>> drivers/net/phy/bcm63xx.c:115:5: warning: no previous prototype for 'bcm63268_gphy_suspend' [-Wmissing-prototypes]
     115 | int bcm63268_gphy_suspend(struct phy_device *phydev)
         |     ^~~~~~~~~~~~~~~~~~~~~


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

