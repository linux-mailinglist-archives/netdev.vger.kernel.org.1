Return-Path: <netdev+bounces-101361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9518FE436
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 12:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29761C25022
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C683194C83;
	Thu,  6 Jun 2024 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ccsJOH6n"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A44194A74;
	Thu,  6 Jun 2024 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669560; cv=none; b=WiQ/IZaBbxhpOAg5DcYI2JMAHaYcGvdq1Cyri3zrLy+aX2sGuU1RfONvPG5IbbyVRVSMByW9ICZ6opdusXYVTsBWl7vIhcJd0tC4OWpaF59toXwVOoj3W1kWxks0QrZvm6LFxeivdGUIfervRo69KniHAO54SJgbP5tLM8N/g0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669560; c=relaxed/simple;
	bh=Y9cpqD3t+DiHnN1F1DLKXpb8pKYRnlIlunH0czog3Vg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEBDl+vU8keeOFwEKTFeTesT5JTpVKV+NE1iWFoKy86f5fCeIyx0Vh57fGpit9Wcg7WWs6lWR7Cpegu1ZPfbe5Gu2A0RA58DlDfPQ78blOB+8KDrRREm6s1cm3F6SYdQZ042ETm70+yf2CWIDQf06TzNsg8fT4rtHXSE/RcOw/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ccsJOH6n; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717669558; x=1749205558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y9cpqD3t+DiHnN1F1DLKXpb8pKYRnlIlunH0czog3Vg=;
  b=ccsJOH6ngqekAwkFN5MT+uFvfGCEbr+zQ8gtXMw8k0L4+6lTujpQX4vP
   NDDm2u8/79w3ZTJJwuzrGdDWy2BepOLGsmniek4+bIeV2KMUnyrtKpAAE
   MKmUfm6ifw9rdA4IgBtWa6BFidonY+8WP91cZ7+lpbHZbIAQsxW7JoCf2
   N3aBeLfMxtL454TXQ3uHpU47tDVLxVrp2b55LB5Yj0XGgu7PmcN0fcrXr
   SYKYHbnu8U+uPi4iNj3RCM/KDxdp41IBUTA/kZTr4k+Q3ujj/tLsZyFZS
   wxr8bHm5qVSaEaGiTIxZ9ZaL5MgC0eiX7REphSWhfdw5pYikeQeJqyWhw
   w==;
X-CSE-ConnectionGUID: LF52B74sSd6hfTmuCf+/iA==
X-CSE-MsgGUID: BcnDLqiFTH6Rao3o5ZdqQg==
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="29467372"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jun 2024 03:25:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 6 Jun 2024 03:25:31 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 6 Jun 2024 03:25:31 -0700
Date: Thu, 6 Jun 2024 15:52:51 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: kernel test robot <lkp@intel.com>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <davem@davemloft.net>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <bryan.whitehead@microchip.com>,
	<andrew@lunn.ch>, <linux@armlinux.org.uk>, <sbauer@blackbox.su>,
	<hmehrtens@maxlinear.com>, <lxu@maxlinear.com>, <hkallweit1@gmail.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net V3 2/3] net: lan743x: Support WOL at both the PHY and
 MAC appropriately
Message-ID: <ZmGN+2qysJGU/9+V@HYD-DK-UNGSW21.microchip.com>
References: <20240605101611.18791-3-Raju.Lakkaraju@microchip.com>
 <202406052200.w3zuc32H-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <202406052200.w3zuc32H-lkp@intel.com>

The target architecture of alpha's config file miss the "CONFIG_PM=y"
cofiguration.

"phy_wolopts" and "phy_wol_supported" variable define in struct
lan743x_adapter under CONFIG_PM compiler option.

these variable define in drivers/net/ethernet/microchip/lan743x_main.h file.

Thanks,
Raju

The 06/05/2024 22:56, kernel test robot wrote:
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
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240605/202406052200.w3zuc32H-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406052200.w3zuc32H-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406052200.w3zuc32H-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/net/ethernet/microchip/lan743x_main.c: In function 'lan743x_netdev_open':
> >> drivers/net/ethernet/microchip/lan743x_main.c:3126:24: error: 'struct lan743x_adapter' has no member named 'phy_wol_supported'
>     3126 |                 adapter->phy_wol_supported = wol.supported;
>          |                        ^~
> >> drivers/net/ethernet/microchip/lan743x_main.c:3127:24: error: 'struct lan743x_adapter' has no member named 'phy_wolopts'
>     3127 |                 adapter->phy_wolopts = wol.wolopts;
>          |                        ^~
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

