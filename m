Return-Path: <netdev+bounces-150722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45B19EB419
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A7F280ED4
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E831AAA29;
	Tue, 10 Dec 2024 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zlc5DFbp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1CC1A9B4C
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842682; cv=none; b=PTfX+j/q8EqtQpJbctuEM9NGT0XaZMQygAQUiuk5CmrBFQrBHEkbukMQgrSpTay8QCxsTsXvb9wAiZh5yjRTNE6dduwZc/wqks2yiIG730t43KE2ndgbndUUTDpROd3zyKt2p5MPTMR6nGOOD79vTIG/7HWV0grJnv2SYBnTPtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842682; c=relaxed/simple;
	bh=PXdRxS8VDAc9k4peB8AhqHweam9Zn73N/eoOrtwukBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKR2oLb4oRo6+pvhP+GpQ5unAoXEk16hhb81L3lvKLbT5po3EU6qoARhMZahzByykGKtCpWWVxSqp+XOKg7JbKT5XN2A7y/mOrn9Yfc03H8E/MZSBVTOI+q87dcb3SLtaiVv6r9/cNEbUJhrtM+gsi+D96DmZG8bteQsWWJ4R6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zlc5DFbp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733842680; x=1765378680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PXdRxS8VDAc9k4peB8AhqHweam9Zn73N/eoOrtwukBE=;
  b=Zlc5DFbpoChPkIevQH+wRPvpJwDnq9RTyH4I4UbIrFafttpvd6F/i3id
   nN/tw15hAIQvobKKUIIS621kI9D89MfOJw4+Sm5ihKBpjZ/3jeHFtqY+e
   aG9rU47iQ33hh/6sQwOwNObF57whxXFW/57RdlP5wMMhuUJwmmGseUqUJ
   JYN/qwkO0Nmsn5muwMqOLDfaIMatywz1xgM1iCO2iL5zlTiC0zGcR/rce
   +xtk/zX8PRthU8VFw7FdjjtRw4uf1KcHsg01vq3b7mWywcTQ95NQA8tL8
   TJ8L6Ki+7A0psEUpV58nOcOX0NuYvms1fF9eDMxthFkN2RFJWgI/+oHQ7
   Q==;
X-CSE-ConnectionGUID: xmRHRk8CStKEPqpCRzyNrg==
X-CSE-MsgGUID: 70yXkCJNTs+FEwyfq8gIBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45201937"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="45201937"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 06:57:48 -0800
X-CSE-ConnectionGUID: 5LBUTF+xQhSAfCnDfNa3tQ==
X-CSE-MsgGUID: TuqROZKoQuubn19k1IK4wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="95267738"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 10 Dec 2024 06:57:45 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tL1gF-0005gT-08;
	Tue, 10 Dec 2024 14:57:43 +0000
Date: Tue, 10 Dec 2024 22:57:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 10/10] net: lan743x: convert to phylink managed
 EEE
Message-ID: <202412102203.FVir20i4-lkp@intel.com>
References: <E1tKeg8-006SNJ-4Q@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tKeg8-006SNJ-4Q@rmk-PC.armlinux.org.uk>

Hi Russell,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Russell-King-Oracle/net-mdio-add-definition-for-clock-stop-capable-bit/20241210-022608
base:   net-next/main
patch link:    https://lore.kernel.org/r/E1tKeg8-006SNJ-4Q%40rmk-PC.armlinux.org.uk
patch subject: [PATCH net-next 10/10] net: lan743x: convert to phylink managed EEE
config: powerpc-randconfig-002-20241210 (https://download.01.org/0day-ci/archive/20241210/202412102203.FVir20i4-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241210/202412102203.FVir20i4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412102203.FVir20i4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/microchip/lan743x_main.c:5:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/powerpc/include/asm/io.h:24:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/net/ethernet/microchip/lan743x_main.c:3078:25: error: use of undeclared identifier 'adapter'
    3078 |         lan743x_mac_eee_enable(adapter, false);
         |                                ^
   drivers/net/ethernet/microchip/lan743x_main.c:3089:20: error: use of undeclared identifier 'adapter'
    3089 |         lan743x_csr_write(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT, timer);
         |                           ^
   drivers/net/ethernet/microchip/lan743x_main.c:3090:25: error: use of undeclared identifier 'adapter'
    3090 |         lan743x_mac_eee_enable(adapter, true);
         |                                ^
>> drivers/net/ethernet/microchip/lan743x_main.c:3097:24: error: use of undeclared identifier 'lan743x_mac_disable_tx_lpi'; did you mean 'mac_disable_tx_lpi'?
    3097 |         .mac_disable_tx_lpi = lan743x_mac_disable_tx_lpi,
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                               mac_disable_tx_lpi
   drivers/net/ethernet/microchip/lan743x_main.c:3076:13: note: 'mac_disable_tx_lpi' declared here
    3076 | static void mac_disable_tx_lpi(struct phylink_config *config)
         |             ^
>> drivers/net/ethernet/microchip/lan743x_main.c:3098:23: error: use of undeclared identifier 'lan743x_mac_enable_tx_lpi'; did you mean 'mac_enable_tx_lpi'?
    3098 |         .mac_enable_tx_lpi = lan743x_mac_enable_tx_lpi,
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                              mac_enable_tx_lpi
   drivers/net/ethernet/microchip/lan743x_main.c:3081:13: note: 'mac_enable_tx_lpi' declared here
    3081 | static void mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
         |             ^
>> drivers/net/ethernet/microchip/lan743x_main.c:3113:26: error: no member named 'lpi_timer_max' in 'struct phylink_config'
    3113 |         adapter->phylink_config.lpi_timer_max = U32_MAX;
         |         ~~~~~~~~~~~~~~~~~~~~~~~ ^
   1 warning and 6 errors generated.


vim +/adapter +3078 drivers/net/ethernet/microchip/lan743x_main.c

  3075	
  3076	static void mac_disable_tx_lpi(struct phylink_config *config)
  3077	{
> 3078		lan743x_mac_eee_enable(adapter, false);
  3079	}
  3080	
  3081	static void mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
  3082				      bool tx_clk_stop)
  3083	{
  3084		/* Software should only change this field when Energy Efficient
  3085		 * Ethernet Enable (EEEEN) is cleared. We ensure that by clearing
  3086		 * EEEEN during probe, and phylink itself guarantees that
  3087		 * mac_disable_tx_lpi() will have been previously called.
  3088		 */
  3089		lan743x_csr_write(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT, timer);
  3090		lan743x_mac_eee_enable(adapter, true);
  3091	}
  3092	
  3093	static const struct phylink_mac_ops lan743x_phylink_mac_ops = {
  3094		.mac_config = lan743x_phylink_mac_config,
  3095		.mac_link_down = lan743x_phylink_mac_link_down,
  3096		.mac_link_up = lan743x_phylink_mac_link_up,
> 3097		.mac_disable_tx_lpi = lan743x_mac_disable_tx_lpi,
> 3098		.mac_enable_tx_lpi = lan743x_mac_enable_tx_lpi,
  3099	};
  3100	
  3101	static int lan743x_phylink_create(struct lan743x_adapter *adapter)
  3102	{
  3103		struct net_device *netdev = adapter->netdev;
  3104		struct phylink *pl;
  3105	
  3106		adapter->phylink_config.dev = &netdev->dev;
  3107		adapter->phylink_config.type = PHYLINK_NETDEV;
  3108		adapter->phylink_config.mac_managed_pm = false;
  3109	
  3110		adapter->phylink_config.mac_capabilities = MAC_ASYM_PAUSE |
  3111			MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000FD;
  3112		adapter->phylink_config.lpi_capabilities = MAC_100FD | MAC_1000FD;
> 3113		adapter->phylink_config.lpi_timer_max = U32_MAX;
  3114		adapter->phylink_config.lpi_timer_default =
  3115			lan743x_csr_read(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT);
  3116	
  3117		lan743x_phy_interface_select(adapter);
  3118	
  3119		switch (adapter->phy_interface) {
  3120		case PHY_INTERFACE_MODE_SGMII:
  3121			__set_bit(PHY_INTERFACE_MODE_SGMII,
  3122				  adapter->phylink_config.supported_interfaces);
  3123			__set_bit(PHY_INTERFACE_MODE_1000BASEX,
  3124				  adapter->phylink_config.supported_interfaces);
  3125			__set_bit(PHY_INTERFACE_MODE_2500BASEX,
  3126				  adapter->phylink_config.supported_interfaces);
  3127			adapter->phylink_config.mac_capabilities |= MAC_2500FD;
  3128			break;
  3129		case PHY_INTERFACE_MODE_GMII:
  3130			__set_bit(PHY_INTERFACE_MODE_GMII,
  3131				  adapter->phylink_config.supported_interfaces);
  3132			break;
  3133		case PHY_INTERFACE_MODE_MII:
  3134			__set_bit(PHY_INTERFACE_MODE_MII,
  3135				  adapter->phylink_config.supported_interfaces);
  3136			break;
  3137		default:
  3138			phy_interface_set_rgmii(adapter->phylink_config.supported_interfaces);
  3139		}
  3140	
  3141		memcpy(adapter->phylink_config.lpi_interfaces,
  3142		       adapter->phylink_config.supported_interfaces,
  3143		       sizeof(adapter->phylink_config.lpi_interfaces));
  3144	
  3145		pl = phylink_create(&adapter->phylink_config, NULL,
  3146				    adapter->phy_interface, &lan743x_phylink_mac_ops);
  3147	
  3148		if (IS_ERR(pl)) {
  3149			netdev_err(netdev, "Could not create phylink (%pe)\n", pl);
  3150			return PTR_ERR(pl);
  3151		}
  3152	
  3153		adapter->phylink = pl;
  3154		netdev_dbg(netdev, "lan743x phylink created");
  3155	
  3156		return 0;
  3157	}
  3158	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

