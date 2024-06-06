Return-Path: <netdev+bounces-101364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 906EA8FE460
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 12:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87CE71C24E84
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AEE194C61;
	Thu,  6 Jun 2024 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NB7IlQ0b"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0081E52A;
	Thu,  6 Jun 2024 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669985; cv=none; b=Gq5ft7xz8BIvn6O2UC/PCi6y3sdu1qRhy/Sa/t3XBn/Jm6UcdRD5plmh79FDN4ykQd6MxBQEo6WHQw2Cc1GcA/oXBMo1hiuB1Kr1U4GF2IuZXCqmmZDyrcvdSILHxM4HvPFvgVcYUs+FgZoGQczHnf/VENUvD6WqhREzIdT7SaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669985; c=relaxed/simple;
	bh=7oulF61J/1Ld/MRF929qgvIcKwcBsekXr7qO9gCsAS8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ela0UnTULtoWGCX/9zFbcdnMAcWVdlwna1a9bY4NahuIZpX2dfBtbanLm2D+H6GSqLfxPtXGEwOogAS/HpR1Nc8KtTIJdrR0YdxrkpekIhwFkeBKCUm9jG3DxCF5xsvxqwhFlEocKxqf1xAkD9wk99ObRrj8Fh4Eqt+9FKAhjrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NB7IlQ0b; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717669982; x=1749205982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7oulF61J/1Ld/MRF929qgvIcKwcBsekXr7qO9gCsAS8=;
  b=NB7IlQ0buBEAnpN/0VQTYqszZSB64l5jrHUJsmMR8PvIw07G5eSQGig/
   mMiQcA2/4eQy6yka9KpHC9H9AZCy4XQWXT9usdXQjxJmALeIR9QVCMo9X
   hs/DrNGiyYEhYnr41xpWHNbQYodurse9dZ6R09rfbBvYBmrV6LsZbrL46
   OJQCFnTNB5BXexR9xBpTx68bR/OyJHIR/iUcGSHt7klv/554bDsrC0jBM
   Fif0+DOW3QcvDr8Pvt8HBPXt4BYjvbQP1uZfCEL88N/u+iPEM4pHBy+YX
   YzBX59MjL14jzzTB//AJTGpo4kfoUk32s3PCsYYh1KaK3Y6zlftGopzez
   A==;
X-CSE-ConnectionGUID: wRNOMPcPTNSQ93tseZzK/w==
X-CSE-MsgGUID: fEw/lNs7RdWnASCtNNjC9A==
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="194466390"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jun 2024 03:33:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 6 Jun 2024 03:33:00 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 6 Jun 2024 03:33:00 -0700
Date: Thu, 6 Jun 2024 16:00:20 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: kernel test robot <lkp@intel.com>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
	<davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<sbauer@blackbox.su>, <hmehrtens@maxlinear.com>, <lxu@maxlinear.com>,
	<hkallweit1@gmail.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net V3 2/3] net: lan743x: Support WOL at both the PHY and
 MAC appropriately
Message-ID: <ZmGPvNOOZ5EvZFne@HYD-DK-UNGSW21.microchip.com>
References: <20240605101611.18791-3-Raju.Lakkaraju@microchip.com>
 <202406060612.UBlHLtM8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <202406060612.UBlHLtM8-lkp@intel.com>

"phy_wolopts" and "phy_wol_supported" variable define in struct lan743x_adapter
under CONFIG_PM compiler build option.

These variable define in drivers/net/ethernet/microchip/lan743x_main.h file.
Can you please add the config (CONFIG_PM=y) to build?

Thanks,
Raju

The 06/06/2024 06:25, kernel test robot wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Hi Raju,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Lakkaraju/net-lan743x-disable-WOL-upon-resume-to-restore-full-data-path-operation/20240605-182110
> base:   net/main
> patch link:    https://lore.kernel.org/r/20240605101611.18791-3-Raju.Lakkaraju%40microchip.com
> patch subject: [PATCH net V3 2/3] net: lan743x: Support WOL at both the PHY and MAC appropriately
> config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240606/202406060612.UBlHLtM8-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240606/202406060612.UBlHLtM8-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406060612.UBlHLtM8-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/net/ethernet/microchip/lan743x_main.c:4:
>    In file included from include/linux/module.h:19:
>    In file included from include/linux/elf.h:6:
>    In file included from arch/s390/include/asm/elf.h:173:
>    In file included from arch/s390/include/asm/mmu_context.h:11:
>    In file included from arch/s390/include/asm/pgalloc.h:18:
>    In file included from include/linux/mm.h:2253:
>    include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>      500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      501 |                            item];
>          |                            ~~~~
>    include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>      507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      508 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>      514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~
>    include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>      519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      520 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>      528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      529 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>    In file included from drivers/net/ethernet/microchip/lan743x_main.c:5:
>    In file included from include/linux/pci.h:39:
>    In file included from include/linux/io.h:14:
>    In file included from arch/s390/include/asm/io.h:93:
>    include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      548 |         val = __raw_readb(PCI_IOBASE + addr);
>          |                           ~~~~~~~~~~ ^
>    include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
>          |                                                         ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
>       37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
>          |                                                           ^
>    include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
>      102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
>          |                                                      ^
>    In file included from drivers/net/ethernet/microchip/lan743x_main.c:5:
>    In file included from include/linux/pci.h:39:
>    In file included from include/linux/io.h:14:
>    In file included from arch/s390/include/asm/io.h:93:
>    include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
>          |                                                         ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
>       35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
>          |                                                           ^
>    include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
>      115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
>          |                                                      ^
>    In file included from drivers/net/ethernet/microchip/lan743x_main.c:5:
>    In file included from include/linux/pci.h:39:
>    In file included from include/linux/io.h:14:
>    In file included from arch/s390/include/asm/io.h:93:
>    include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      585 |         __raw_writeb(value, PCI_IOBASE + addr);
>          |                             ~~~~~~~~~~ ^
>    include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
>          |                                                       ~~~~~~~~~~ ^
>    include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
>          |                                                       ~~~~~~~~~~ ^
>    include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      693 |         readsb(PCI_IOBASE + addr, buffer, count);
>          |                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      701 |         readsw(PCI_IOBASE + addr, buffer, count);
>          |                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      709 |         readsl(PCI_IOBASE + addr, buffer, count);
>          |                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      718 |         writesb(PCI_IOBASE + addr, buffer, count);
>          |                 ~~~~~~~~~~ ^
>    include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      727 |         writesw(PCI_IOBASE + addr, buffer, count);
>          |                 ~~~~~~~~~~ ^
>    include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      736 |         writesl(PCI_IOBASE + addr, buffer, count);
>          |                 ~~~~~~~~~~ ^
> >> drivers/net/ethernet/microchip/lan743x_main.c:3126:12: error: no member named 'phy_wol_supported' in 'struct lan743x_adapter'
>     3126 |                 adapter->phy_wol_supported = wol.supported;
>          |                 ~~~~~~~  ^
> >> drivers/net/ethernet/microchip/lan743x_main.c:3127:12: error: no member named 'phy_wolopts' in 'struct lan743x_adapter'
>     3127 |                 adapter->phy_wolopts = wol.wolopts;
>          |                 ~~~~~~~  ^
>    17 warnings and 2 errors generated.
> 
> 
> vim +3126 drivers/net/ethernet/microchip/lan743x_main.c
> 
>   3085
>   3086  static int lan743x_netdev_open(struct net_device *netdev)
>   3087  {
>   3088          struct lan743x_adapter *adapter = netdev_priv(netdev);
>   3089          int index;
>   3090          int ret;
>   3091
>   3092          ret = lan743x_intr_open(adapter);
>   3093          if (ret)
>   3094                  goto return_error;
>   3095
>   3096          ret = lan743x_mac_open(adapter);
>   3097          if (ret)
>   3098                  goto close_intr;
>   3099
>   3100          ret = lan743x_phy_open(adapter);
>   3101          if (ret)
>   3102                  goto close_mac;
>   3103
>   3104          ret = lan743x_ptp_open(adapter);
>   3105          if (ret)
>   3106                  goto close_phy;
>   3107
>   3108          lan743x_rfe_open(adapter);
>   3109
>   3110          for (index = 0; index < LAN743X_USED_RX_CHANNELS; index++) {
>   3111                  ret = lan743x_rx_open(&adapter->rx[index]);
>   3112                  if (ret)
>   3113                          goto close_rx;
>   3114          }
>   3115
>   3116          for (index = 0; index < adapter->used_tx_channels; index++) {
>   3117                  ret = lan743x_tx_open(&adapter->tx[index]);
>   3118                  if (ret)
>   3119                          goto close_tx;
>   3120          }
>   3121
>   3122          if (adapter->netdev->phydev) {
>   3123                  struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
>   3124
>   3125                  phy_ethtool_get_wol(netdev->phydev, &wol);
> > 3126                  adapter->phy_wol_supported = wol.supported;
> > 3127                  adapter->phy_wolopts = wol.wolopts;
>   3128          }
>   3129
>   3130          return 0;
>   3131
>   3132  close_tx:
>   3133          for (index = 0; index < adapter->used_tx_channels; index++) {
>   3134                  if (adapter->tx[index].ring_cpu_ptr)
>   3135                          lan743x_tx_close(&adapter->tx[index]);
>   3136          }
>   3137
>   3138  close_rx:
>   3139          for (index = 0; index < LAN743X_USED_RX_CHANNELS; index++) {
>   3140                  if (adapter->rx[index].ring_cpu_ptr)
>   3141                          lan743x_rx_close(&adapter->rx[index]);
>   3142          }
>   3143          lan743x_ptp_close(adapter);
>   3144
>   3145  close_phy:
>   3146          lan743x_phy_close(adapter);
>   3147
>   3148  close_mac:
>   3149          lan743x_mac_close(adapter);
>   3150
>   3151  close_intr:
>   3152          lan743x_intr_close(adapter);
>   3153
>   3154  return_error:
>   3155          netif_warn(adapter, ifup, adapter->netdev,
>   3156                     "Error opening LAN743x\n");
>   3157          return ret;
>   3158  }
>   3159
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

-- 
--------                                                                        
Thanks,                                                                         
Raju

