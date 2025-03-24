Return-Path: <netdev+bounces-177001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CE0A6D34E
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 04:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885F21664A6
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 03:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AABC17084F;
	Mon, 24 Mar 2025 03:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fs4RMN9x"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F46A17C98;
	Mon, 24 Mar 2025 03:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742786416; cv=none; b=D1QLK/HkaANeCgufnkgT91PHBfePVSWFEJJpmmA7UiQx8H4SJK8SJBGAKLOWSzlZ2t3wQt8cnFBjZpfSD95rx157JArHzXReKYht2i8IGbOYhDWhwAzKRnjS8EJrdeDflt+C9mJZSpR/+mncl5tWUHPzsq5HqOXk/UcpEYVUry8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742786416; c=relaxed/simple;
	bh=5U2hz6Ps5Y0/LkUJRaC8iNmpBLjaBL4x57nl2s22ReE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CC361PA49VEKWABdMobNa1Oaefj8HS8TS2X24f3yeIlbYtfW5JiqudTSC6zVaQqMZIdSt0sHt5Cd7dR3P8KXkE3D7iajG4ziRkXKwlawO58WrXqEROrblfrIpGxQ+g8I9UbiB684wOIaZ4y29SC3CO5BgkILDDl8JJI1vb5HVTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fs4RMN9x; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742786415; x=1774322415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5U2hz6Ps5Y0/LkUJRaC8iNmpBLjaBL4x57nl2s22ReE=;
  b=fs4RMN9xF0hzCcCt/oXiKsL+hjZ0Od5vaVqQLUM0RlSGr101uBy8Q6im
   3KjKCsi/8RcFEx9Gkvh0OpoG9ykDXDOYXpbY7T9skqw7cl974Xmax0d4i
   anqUXobzAAJGOUia3M9sEeN1r3PqexVLFMh4aJtrNVhmuCfYRps5SIm3h
   gH1B9vT/GcTor0/ykKCezHLguf8H2ajXqBVx4Ft+PBsgI9PKKn42YxGRN
   FoJoFxS/GwicIQAvFebAWoRY4oRdxNLujq3kNit1+iuNOXRcpc4TdmVGX
   TsETdNbcxIKHU7RBx3RX+gen1LzoOqyZ9NTJ8nHCHoNmtFyEjxp3jNFsL
   w==;
X-CSE-ConnectionGUID: i9T5vOsUQNiXFI9a/Yf1ew==
X-CSE-MsgGUID: vMf8u7v2SJuxkM10rJsnwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="43701678"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="43701678"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 20:20:14 -0700
X-CSE-ConnectionGUID: Ctcp6A7VTQi+FQAgva4eWQ==
X-CSE-MsgGUID: z3XqtjwiRLaLcbzzETLP3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="124700753"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 23 Mar 2025 20:20:10 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1twYMC-0003Cy-0j;
	Mon, 24 Mar 2025 03:20:08 +0000
Date: Mon, 24 Mar 2025 11:19:42 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] net: phy: Add support for new Aeonsemi PHYs
Message-ID: <202503241125.KKDZ7C9F-lkp@intel.com>
References: <20250323225439.32400-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323225439.32400-1-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-net-Document-support-for-Aeonsemi-PHYs/20250324-065920
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250323225439.32400-1-ansuelsmth%40gmail.com
patch subject: [net-next PATCH 1/2] net: phy: Add support for new Aeonsemi PHYs
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20250324/202503241125.KKDZ7C9F-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project c2692afc0a92cd5da140dfcdfff7818a5b8ce997)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250324/202503241125.KKDZ7C9F-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503241125.KKDZ7C9F-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/as21xxx.c:767:14: warning: variable 'val' is used uninitialized whenever 'for' loop exits because its condition is false [-Wsometimes-uninitialized]
     767 |         for (i = 0; i < ARRAY_SIZE(as21xxx_led_supported_pattern); i++)
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/as21xxx.c:775:33: note: uninitialized use occurs here
     775 |                               VEND1_LED_REG_A_EVENT, val);
         |                                                      ^~~
   drivers/net/phy/as21xxx.c:767:14: note: remove the condition if it is always true
     767 |         for (i = 0; i < ARRAY_SIZE(as21xxx_led_supported_pattern); i++)
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/as21xxx.c:761:9: note: initialize the variable 'val' to silence this warning
     761 |         u16 val;
         |                ^
         |                 = 0
   1 warning generated.


vim +767 drivers/net/phy/as21xxx.c

   757	
   758	static int as21xxx_led_hw_control_set(struct phy_device *phydev, u8 index,
   759					      unsigned long rules)
   760	{
   761		u16 val;
   762		int i;
   763	
   764		if (index > AEON_MAX_LDES)
   765			return -EINVAL;
   766	
 > 767		for (i = 0; i < ARRAY_SIZE(as21xxx_led_supported_pattern); i++)
   768			if (rules == as21xxx_led_supported_pattern[i].pattern) {
   769				val = as21xxx_led_supported_pattern[i].val;
   770				break;
   771			}
   772	
   773		return phy_modify_mmd(phydev, MDIO_MMD_VEND1,
   774				      VEND1_LED_REG(index),
   775				      VEND1_LED_REG_A_EVENT, val);
   776	}
   777	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

