Return-Path: <netdev+bounces-175009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A5AA62591
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 04:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678D319C35E6
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 03:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3BA18C031;
	Sat, 15 Mar 2025 03:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAw4sguj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F5863D;
	Sat, 15 Mar 2025 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742010547; cv=none; b=bo75qqIfaSMp2gs73GH7dKu/MfjY6SvPewOBDatK7x9uWfUSgZIQOjtnCjfMQ0F3qPlHazSkMagzIwuT6/jGMqeu496OegZb4BuLYEGIb3RM5IYnEm7L6Z7XFnHyxFAs22HwbAvUchnAa7DSupLblqgCeVXS7SoADuUe+0gg48U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742010547; c=relaxed/simple;
	bh=mSkbxS1REs4KpYz+KOYutSriJ2uGhjKLTrlxISCSz0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnmScZbT1quNwJwVUgdqvkd2unVRSGcQAdaBVWuv2+KLNSMlLwXst5hzJs+zLL5agPw8TTps5p1VByfAPg/NQ6ToQ1k9+EwUgrSRmfDAKc/fj/lxPcA8IvczMANMimoYsLQcasErnlU5g4HXow13SBek1NzVeyT4ER+clAfGuLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAw4sguj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742010545; x=1773546545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mSkbxS1REs4KpYz+KOYutSriJ2uGhjKLTrlxISCSz0Q=;
  b=NAw4sgujbSrQUqYtKUINAHCOCYQhJ12OvX07Gz+kMe6UNAJgOBtLgtiV
   HpC3h/HipeYqk5RkQHgVEpvwoR1bKgaSMa6eziVq4a7DLYdpJVqQ94qGC
   G6Cp9WnYzpAKShTgQm0BawAgTQaZSBPUhDLB2jKc8HKpLUtrNAOukIDp8
   ixGqy/PMMwwqfML27H+yEtb1qpr/i3qxMUxOCwEkIIzOsRLY1EMNnl4FH
   XhNFqLSv0QF2MkyDUbc3m+yktS+BB76NPLHgokOgA5gTHv4epIIwp/xEk
   2O07WGp1PSG9D/vNXa+/t23H9mDfV7NzEEGMiUCoK9YXggZIDOMUs2brs
   A==;
X-CSE-ConnectionGUID: LatfVJtYQ1yT3gwLs5DPTQ==
X-CSE-MsgGUID: +GnuEyt1Q8mJXxkH28bSWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="53830395"
X-IronPort-AV: E=Sophos;i="6.14,249,1736841600"; 
   d="scan'208";a="53830395"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 20:49:04 -0700
X-CSE-ConnectionGUID: EXcMqaLgSlCjLJGGirvNDQ==
X-CSE-MsgGUID: +5L5MzR0Sj+L2cyePPAj2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,249,1736841600"; 
   d="scan'208";a="122402691"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 14 Mar 2025 20:49:00 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ttIWA-000B2l-13;
	Sat, 15 Mar 2025 03:48:58 +0000
Date: Sat, 15 Mar 2025 11:48:15 +0800
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
Subject: Re: [PATCH net-next v3 1/7] net: usb: lan78xx: Convert to PHYlink
 for improved PHY and MAC management
Message-ID: <202503151113.AFty2HdH-lkp@intel.com>
References: <20250310115737.784047-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310115737.784047-2-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/net-usb-lan78xx-Convert-to-PHYlink-for-improved-PHY-and-MAC-management/20250310-200116
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250310115737.784047-2-o.rempel%40pengutronix.de
patch subject: [PATCH net-next v3 1/7] net: usb: lan78xx: Convert to PHYlink for improved PHY and MAC management
config: i386-randconfig-006-20250315 (https://download.01.org/0day-ci/archive/20250315/202503151113.AFty2HdH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250315/202503151113.AFty2HdH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503151113.AFty2HdH-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_phy_init':
>> drivers/net/usb/lan78xx.c:2683: undefined reference to `phylink_connect_phy'
>> ld: drivers/net/usb/lan78xx.c:2651: undefined reference to `phylink_set_fixed_link'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_open':
>> drivers/net/usb/lan78xx.c:3280: undefined reference to `phylink_start'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_stop':
>> drivers/net/usb/lan78xx.c:3350: undefined reference to `phylink_stop'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_disconnect':
   drivers/net/usb/lan78xx.c:4375: undefined reference to `phylink_stop'
>> ld: drivers/net/usb/lan78xx.c:4376: undefined reference to `phylink_disconnect_phy'
>> ld: drivers/net/usb/lan78xx.c:4387: undefined reference to `phylink_destroy'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_phylink_setup':
>> drivers/net/usb/lan78xx.c:2621: undefined reference to `phylink_create'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_probe':
>> drivers/net/usb/lan78xx.c:4609: undefined reference to `phylink_disconnect_phy'
   ld: drivers/net/usb/lan78xx.c:4611: undefined reference to `phylink_destroy'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_reset_resume':
   drivers/net/usb/lan78xx.c:5173: undefined reference to `phylink_start'


vim +2683 drivers/net/usb/lan78xx.c

  2599	
  2600	static int lan78xx_phylink_setup(struct lan78xx_net *dev)
  2601	{
  2602		struct phylink_config *pc = &dev->phylink_config;
  2603		phy_interface_t link_interface;
  2604		struct phylink *phylink;
  2605	
  2606		pc->dev = &dev->net->dev;
  2607		pc->type = PHYLINK_NETDEV;
  2608		pc->mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE | MAC_10 |
  2609				       MAC_100 | MAC_1000FD;
  2610		pc->mac_managed_pm = true;
  2611	
  2612		if (dev->chipid == ID_REV_CHIP_ID_7801_) {
  2613			phy_interface_set_rgmii(pc->supported_interfaces);
  2614			link_interface = PHY_INTERFACE_MODE_RGMII_ID;
  2615		} else {
  2616			__set_bit(PHY_INTERFACE_MODE_INTERNAL,
  2617				  pc->supported_interfaces);
  2618			link_interface = PHY_INTERFACE_MODE_INTERNAL;
  2619		}
  2620	
> 2621		phylink = phylink_create(pc, dev->net->dev.fwnode,
  2622					 link_interface, &lan78xx_phylink_mac_ops);
  2623		if (IS_ERR(phylink))
  2624			return PTR_ERR(phylink);
  2625	
  2626		dev->phylink = phylink;
  2627	
  2628		return 0;
  2629	}
  2630	
  2631	static int lan78xx_phy_init(struct lan78xx_net *dev)
  2632	{
  2633		struct phy_device *phydev;
  2634		int ret;
  2635	
  2636		switch (dev->chipid) {
  2637		case ID_REV_CHIP_ID_7801_:
  2638			phydev = lan7801_phy_init(dev);
  2639			/* If no PHY found, set fixed link, probably there is no
  2640			 * device or some kind of different device like switch.
  2641			 * For example: EVB-KSZ9897-1 (KSZ9897 switch evaluation board
  2642			 * with LAN7801 & KSZ9031)
  2643			 */
  2644			if (!phydev) {
  2645				struct phylink_link_state state = {
  2646					.speed = SPEED_1000,
  2647					.duplex = DUPLEX_FULL,
  2648					.interface = PHY_INTERFACE_MODE_RGMII,
  2649				};
  2650	
> 2651				ret = phylink_set_fixed_link(dev->phylink, &state);
  2652				if (ret)
  2653					netdev_err(dev->net, "Could not set fixed link\n");
  2654	
  2655				return ret;
  2656			}
  2657	
  2658			break;
  2659	
  2660		case ID_REV_CHIP_ID_7800_:
  2661		case ID_REV_CHIP_ID_7850_:
  2662			phydev = phy_find_first(dev->mdiobus);
  2663			if (!phydev) {
  2664				netdev_err(dev->net, "no PHY found\n");
  2665				return -EIO;
  2666			}
  2667			phydev->is_internal = true;
  2668			phydev->interface = PHY_INTERFACE_MODE_GMII;
  2669			break;
  2670	
  2671		default:
  2672			netdev_err(dev->net, "Unknown CHIP ID found\n");
  2673			return -EIO;
  2674		}
  2675	
  2676		/* if phyirq is not set, use polling mode in phylib */
  2677		if (dev->domain_data.phyirq > 0)
  2678			phydev->irq = dev->domain_data.phyirq;
  2679		else
  2680			phydev->irq = PHY_POLL;
  2681		netdev_dbg(dev->net, "phydev->irq = %d\n", phydev->irq);
  2682	
> 2683		ret = phylink_connect_phy(dev->phylink, phydev);
  2684		if (ret) {
  2685			netdev_err(dev->net, "can't attach PHY to %s\n",
  2686				   dev->mdiobus->id);
  2687			return -EIO;
  2688		}
  2689	
  2690		phy_support_eee(phydev);
  2691	
  2692		if (phydev->mdio.dev.of_node) {
  2693			u32 reg;
  2694			int len;
  2695	
  2696			len = of_property_count_elems_of_size(phydev->mdio.dev.of_node,
  2697							      "microchip,led-modes",
  2698							      sizeof(u32));
  2699			if (len >= 0) {
  2700				/* Ensure the appropriate LEDs are enabled */
  2701				lan78xx_read_reg(dev, HW_CFG, &reg);
  2702				reg &= ~(HW_CFG_LED0_EN_ |
  2703					 HW_CFG_LED1_EN_ |
  2704					 HW_CFG_LED2_EN_ |
  2705					 HW_CFG_LED3_EN_);
  2706				reg |= (len > 0) * HW_CFG_LED0_EN_ |
  2707					(len > 1) * HW_CFG_LED1_EN_ |
  2708					(len > 2) * HW_CFG_LED2_EN_ |
  2709					(len > 3) * HW_CFG_LED3_EN_;
  2710				lan78xx_write_reg(dev, HW_CFG, reg);
  2711			}
  2712		}
  2713	
  2714		return 0;
  2715	}
  2716	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

