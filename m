Return-Path: <netdev+bounces-196712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF92AD6074
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 22:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B565C1BC1E1D
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9772BEC25;
	Wed, 11 Jun 2025 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtWpKYwz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A325223338;
	Wed, 11 Jun 2025 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675458; cv=none; b=eHJmCpYfoz6nI0dwFMGmPDB7xWAn97KxZPmmlLUt3w9d9cd8gMWsV7JdGjTfwQU9II07WxIGiVTxLmmgtyjBSnrNa7hQ568yxkVIilV/qu3HVF3QiynHSz/dQ0U1IJBlJVTy7UMRXOmQLrm/9mZATwbldl4iyHKBFq/dnfvIrP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675458; c=relaxed/simple;
	bh=j1MoG8vohMurbJ2zXOe7FjdHXD8BvCDW/R9FluYHUpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ezye8ipgKRlrHU2VWws/q5+N4XRkYSgEXaK9HW4EtbnaL6ILC0aWTTTbo9dCFm7uDIprPYTYUDhJKixSxJJcSYvl2POpuLz/c8oNXmt8vNXkhLKjmKgIazjFo/ayM0ZZK38xZnvUSv4RwK/l7LXU8glzathtfDRoSW7DjXc75Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtWpKYwz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749675457; x=1781211457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j1MoG8vohMurbJ2zXOe7FjdHXD8BvCDW/R9FluYHUpk=;
  b=gtWpKYwzPi2omaj4ALY+aVWqBrVojKJiCc1X0nHNi9iUSgrkh8SPHjj9
   rrCO26oBOzIQwhpk7GIhW8AqraVPCrY8nguViAD/QC/Ch8SdQbsOG+6gM
   vO7z367Yx4tuKf6uGvjmqG0fjiP0CatEsQU3TZzw42tCFdzeUUzCJi6Rx
   A+SpxEp9sxk9jQZYi6CtocWC8+WZcf0PmESUTYUNDW6iER6mL6gpmgr+p
   TQWGz7e/4X68TX+B8/EHfTjJ851qtDFwFDH69PuIE+2j/qZASJM4rzD+C
   BE1YzPI/6nstbXM7uVYDNSe9GAkC9rlFLM/x9oU4SNB2W4KiyVEgRyUL1
   g==;
X-CSE-ConnectionGUID: 864CMKrQRsWINuaqy9fU9Q==
X-CSE-MsgGUID: Cb4ytaATSce5Z/gXCkmRew==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62447049"
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="62447049"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 13:57:36 -0700
X-CSE-ConnectionGUID: gvyO/YbKQXirQ68wnknz1w==
X-CSE-MsgGUID: grM3MlK7RBmVp9XuSo07CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="152579700"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 11 Jun 2025 13:57:33 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uPSVm-000ArK-1y;
	Wed, 11 Jun 2025 20:57:30 +0000
Date: Thu, 12 Jun 2025 04:56:42 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Justin Chen <justin.chen@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: bcmasp: enable GRO software interrupt
 coalescing by default
Message-ID: <202506120428.xh54jIu7-lkp@intel.com>
References: <20250610173835.2244404-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610173835.2244404-3-florian.fainelli@broadcom.com>

Hi Florian,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Fainelli/net-bcmasp-Utilize-napi_complete_done-return-value/20250611-140255
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250610173835.2244404-3-florian.fainelli%40broadcom.com
patch subject: [PATCH net-next 2/2] net: bcmasp: enable GRO software interrupt coalescing by default
config: parisc-randconfig-002-20250612 (https://download.01.org/0day-ci/archive/20250612/202506120428.xh54jIu7-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250612/202506120428.xh54jIu7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506120428.xh54jIu7-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c: In function 'bcmasp_interface_create':
>> drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c:1282:36: error: passing argument 1 of 'netdev_sw_irq_coalesce_default_on' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1282 |  netdev_sw_irq_coalesce_default_on(dev);
         |                                    ^~~
         |                                    |
         |                                    struct device *
   In file included from include/linux/etherdevice.h:21,
                    from drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c:8:
   include/linux/netdevice.h:93:59: note: expected 'struct net_device *' but argument is of type 'struct device *'
      93 | void netdev_sw_irq_coalesce_default_on(struct net_device *dev);
         |                                        ~~~~~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors


vim +/netdev_sw_irq_coalesce_default_on +1282 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c

  1198	
  1199	struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
  1200						    struct device_node *ndev_dn, int i)
  1201	{
  1202		struct device *dev = &priv->pdev->dev;
  1203		struct bcmasp_intf *intf;
  1204		struct net_device *ndev;
  1205		int ch, port, ret;
  1206	
  1207		if (of_property_read_u32(ndev_dn, "reg", &port)) {
  1208			dev_warn(dev, "%s: invalid port number\n", ndev_dn->name);
  1209			goto err;
  1210		}
  1211	
  1212		if (of_property_read_u32(ndev_dn, "brcm,channel", &ch)) {
  1213			dev_warn(dev, "%s: invalid ch number\n", ndev_dn->name);
  1214			goto err;
  1215		}
  1216	
  1217		ndev = alloc_etherdev(sizeof(struct bcmasp_intf));
  1218		if (!ndev) {
  1219			dev_warn(dev, "%s: unable to alloc ndev\n", ndev_dn->name);
  1220			goto err;
  1221		}
  1222		intf = netdev_priv(ndev);
  1223	
  1224		intf->parent = priv;
  1225		intf->ndev = ndev;
  1226		intf->channel = ch;
  1227		intf->port = port;
  1228		intf->ndev_dn = ndev_dn;
  1229		intf->index = i;
  1230	
  1231		ret = of_get_phy_mode(ndev_dn, &intf->phy_interface);
  1232		if (ret < 0) {
  1233			dev_err(dev, "invalid PHY mode property\n");
  1234			goto err_free_netdev;
  1235		}
  1236	
  1237		if (intf->phy_interface == PHY_INTERFACE_MODE_INTERNAL)
  1238			intf->internal_phy = true;
  1239	
  1240		intf->phy_dn = of_parse_phandle(ndev_dn, "phy-handle", 0);
  1241		if (!intf->phy_dn && of_phy_is_fixed_link(ndev_dn)) {
  1242			ret = of_phy_register_fixed_link(ndev_dn);
  1243			if (ret) {
  1244				dev_warn(dev, "%s: failed to register fixed PHY\n",
  1245					 ndev_dn->name);
  1246				goto err_free_netdev;
  1247			}
  1248			intf->phy_dn = ndev_dn;
  1249		}
  1250	
  1251		/* Map resource */
  1252		bcmasp_map_res(priv, intf);
  1253	
  1254		if ((!phy_interface_mode_is_rgmii(intf->phy_interface) &&
  1255		     intf->phy_interface != PHY_INTERFACE_MODE_MII &&
  1256		     intf->phy_interface != PHY_INTERFACE_MODE_INTERNAL) ||
  1257		    (intf->port != 1 && intf->internal_phy)) {
  1258			netdev_err(intf->ndev, "invalid PHY mode: %s for port %d\n",
  1259				   phy_modes(intf->phy_interface), intf->port);
  1260			ret = -EINVAL;
  1261			goto err_free_netdev;
  1262		}
  1263	
  1264		ret = of_get_ethdev_address(ndev_dn, ndev);
  1265		if (ret) {
  1266			netdev_warn(ndev, "using random Ethernet MAC\n");
  1267			eth_hw_addr_random(ndev);
  1268		}
  1269	
  1270		SET_NETDEV_DEV(ndev, dev);
  1271		intf->ops = &bcmasp_intf_ops;
  1272		ndev->netdev_ops = &bcmasp_netdev_ops;
  1273		ndev->ethtool_ops = &bcmasp_ethtool_ops;
  1274		intf->msg_enable = netif_msg_init(-1, NETIF_MSG_DRV |
  1275						  NETIF_MSG_PROBE |
  1276						  NETIF_MSG_LINK);
  1277		ndev->features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_SG |
  1278				  NETIF_F_RXCSUM;
  1279		ndev->hw_features |= ndev->features;
  1280		ndev->needed_headroom += sizeof(struct bcmasp_pkt_offload);
  1281	
> 1282		netdev_sw_irq_coalesce_default_on(dev);
  1283	
  1284		return intf;
  1285	
  1286	err_free_netdev:
  1287		free_netdev(ndev);
  1288	err:
  1289		return NULL;
  1290	}
  1291	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

