Return-Path: <netdev+bounces-175052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4610EA62B58
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 11:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E3F17310F
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 10:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED32B1F582A;
	Sat, 15 Mar 2025 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6+BJOKx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6671922E0;
	Sat, 15 Mar 2025 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742036307; cv=none; b=UViel1lTBZw9wCVrKDMYUrYM29B4cIDiaeoXrVHHlygCf9rJb6rEHFziDCqnXZbcS0umeD2vCD7Ta6o0ot0O5DnTS406AaSQBPJmf63c0flMgN/6x/cVfOeTFOkep80p7RN9ZDp3ifdZWC0lP4ndxn/0Mcx86ZPHrSIPWL7SQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742036307; c=relaxed/simple;
	bh=zPk2Re0M9KaNbfwrY4fyGI1YDs36bkwYcu+v0qYpRcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQlUEVFnbA9fbAg178HBvhUOm3eDrpzpqXgKVfnstlIghnq8kNdZf4qygKQhPfLPP/wfeZ5exGupB7NAc9VAGc8tRagkFkvkNW2YvAtfwkvK9fiypHQNh38Osim9xE55QKn/jjpscQbV9h0sBGQ90rCCuJtK19szdV4gH7lIWR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6+BJOKx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742036305; x=1773572305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zPk2Re0M9KaNbfwrY4fyGI1YDs36bkwYcu+v0qYpRcA=;
  b=g6+BJOKxFUc2tHuvdv7KqxWUJYOeoeR7xQ2a+mkIw18jQTZQyTwYPyM2
   rMOnMsqfWcO++zJWpnHFxXoMgQ0pe0LyG3COhQZY7oGx62hRItwv1EBHA
   AUwcrVE5Ak1z0I8hI4VowiCsSqSJGFg73tB5VgDFxMpJT1BisSbCcvqlT
   JY8Kgif9CyHNHEoOcXNEJYzl+V/cYRHFRjJT8h69Od0ING0TTYTyCqfPJ
   IGQMy71fSxuH0qLehdI9zQ4x9elgz0Q4Ua2ZN3AMjAvafZFLZGr7jSQqj
   8CSLKK3EwSrAufrSDDoVT08mEuVad76S8i1tN7VxGHIw5JGqzqgYsNAJp
   w==;
X-CSE-ConnectionGUID: 2qwbv+ZgSDmnGQaa6A3SBA==
X-CSE-MsgGUID: QELdHv/ESKKT++HV/MU5Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="60585527"
X-IronPort-AV: E=Sophos;i="6.14,250,1736841600"; 
   d="scan'208";a="60585527"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 03:58:25 -0700
X-CSE-ConnectionGUID: Elox2mw/SgOIIoSim2DqAQ==
X-CSE-MsgGUID: bD9fuRWLQiGuBnYOKRxH0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,250,1736841600"; 
   d="scan'208";a="121550360"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 15 Mar 2025 03:58:21 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ttPDf-000BI3-0n;
	Sat, 15 Mar 2025 10:58:19 +0000
Date: Sat, 15 Mar 2025 18:58:13 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v3 6/7] net: usb: lan78xx: Transition
 get/set_pause to phylink
Message-ID: <202503151846.f7B5hHIU-lkp@intel.com>
References: <20250310115737.784047-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310115737.784047-7-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/net-usb-lan78xx-Convert-to-PHYlink-for-improved-PHY-and-MAC-management/20250310-200116
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250310115737.784047-7-o.rempel%40pengutronix.de
patch subject: [PATCH net-next v3 6/7] net: usb: lan78xx: Transition get/set_pause to phylink
config: i386-randconfig-006-20250315 (https://download.01.org/0day-ci/archive/20250315/202503151846.f7B5hHIU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250315/202503151846.f7B5hHIU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503151846.f7B5hHIU-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_set_link_ksettings':
   drivers/net/usb/lan78xx.c:1874: undefined reference to `phylink_ethtool_ksettings_set'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_get_link_ksettings':
   drivers/net/usb/lan78xx.c:1866: undefined reference to `phylink_ethtool_ksettings_get'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_set_pause':
>> drivers/net/usb/lan78xx.c:1890: undefined reference to `phylink_ethtool_set_pauseparam'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_get_pause':
>> drivers/net/usb/lan78xx.c:1882: undefined reference to `phylink_ethtool_get_pauseparam'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_open':
   drivers/net/usb/lan78xx.c:3205: undefined reference to `phylink_start'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_stop':
   drivers/net/usb/lan78xx.c:3275: undefined reference to `phylink_stop'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_disconnect':
   drivers/net/usb/lan78xx.c:4300: undefined reference to `phylink_stop'
   ld: drivers/net/usb/lan78xx.c:4301: undefined reference to `phylink_disconnect_phy'
   ld: drivers/net/usb/lan78xx.c:4312: undefined reference to `phylink_destroy'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_reset_resume':
   drivers/net/usb/lan78xx.c:5098: undefined reference to `phylink_start'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_phy_init':
   drivers/net/usb/lan78xx.c:2603: undefined reference to `phylink_connect_phy'
   ld: drivers/net/usb/lan78xx.c:2571: undefined reference to `phylink_set_fixed_link'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_phylink_setup':
   drivers/net/usb/lan78xx.c:2541: undefined reference to `phylink_create'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_probe':
   drivers/net/usb/lan78xx.c:4534: undefined reference to `phylink_disconnect_phy'
   ld: drivers/net/usb/lan78xx.c:4536: undefined reference to `phylink_destroy'


vim +1890 drivers/net/usb/lan78xx.c

  1876	
  1877	static void lan78xx_get_pause(struct net_device *net,
  1878				      struct ethtool_pauseparam *pause)
  1879	{
  1880		struct lan78xx_net *dev = netdev_priv(net);
  1881	
> 1882		phylink_ethtool_get_pauseparam(dev->phylink, pause);
  1883	}
  1884	
  1885	static int lan78xx_set_pause(struct net_device *net,
  1886				     struct ethtool_pauseparam *pause)
  1887	{
  1888		struct lan78xx_net *dev = netdev_priv(net);
  1889	
> 1890		return phylink_ethtool_set_pauseparam(dev->phylink, pause);
  1891	}
  1892	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

