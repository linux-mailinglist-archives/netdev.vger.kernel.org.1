Return-Path: <netdev+bounces-176165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3098A693DA
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1268D1883E68
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 15:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDDC1DA11B;
	Wed, 19 Mar 2025 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HgHQETQq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE6A1D54FA;
	Wed, 19 Mar 2025 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398676; cv=none; b=Ney1UTcakm8xFgubzhLdk/LWnPtNyYC/VOpAKkh5/7hhfojFtE3qwOoAL0LmvdoMMBAgx6mMvJ8yaSQPUeRKI6vTynPHZBl6EJN9Q2IPu/l40stWfrQKYZwB0HUmdCvo6PyV9+oEgJ4t8NKm4UtN/R9wJ5D0KfbWb/HGZwmDWmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398676; c=relaxed/simple;
	bh=sD5fGnYZK30pymvpAu4ycCY+DHO4I697q6Iprb71Lcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7RI6T12zosWlil4dJMP0QCLhjJQD8k2+KFKG89ZlKH7MjbhIAqKJ7kjVpJ5Wm7U+kjkJu1swKTIVBZCfydVKFwZJzrKb2tBt58FI95vpUQcGnRM8l1L07jJs+4dOslRxEXvc4fDFYkbg/UVDuWvEcNIgqkae469/8InUXVBciQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HgHQETQq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742398674; x=1773934674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sD5fGnYZK30pymvpAu4ycCY+DHO4I697q6Iprb71Lcg=;
  b=HgHQETQq9rrzLI5k1uDoJI8rxG5S4Rljdh3LAexOzO0xxJY4KhZqlF6J
   fDZF8hNgLUoP3JVCEQKcMuuiOnyRNpdOvoMTJfz+dz3z7YJfGwAmKWlNo
   Ze28GQIC0y7cXnOV4bIZNuc7Jmz+6KaFxdHKz5XjCNzVqtk1qBi2Ducam
   8zeIngSHAji9vdD/ycIF0S5HlouNWLbNwb3LySVnzPChbTxm+y7ytPDH2
   GIG+AUYtuHrfahsat/5ktu+5ndGC+F0sHvGIPoGNxKtPfYoszzQ4UyoAe
   T8wuE9ydASlfFjpo/5A0n9u9TUNblQbrxt72NDtx2Luprqe8J830sb0u2
   g==;
X-CSE-ConnectionGUID: r/bnI+RLRjeavuRCjmN79A==
X-CSE-MsgGUID: qKgnSEvnTqaTKofkbGTuWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="31177208"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="31177208"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 08:37:48 -0700
X-CSE-ConnectionGUID: JAepnRHKTCSkdxZE0geb/A==
X-CSE-MsgGUID: QpKDRUg6T6Kq5OojE9elEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="153532879"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 19 Mar 2025 08:37:44 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuvUD-000FSQ-0a;
	Wed, 19 Mar 2025 15:37:41 +0000
Date: Wed, 19 Mar 2025 23:37:19 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net v2 1/2] net: phy: Fix formatting specifier to avoid
 potential string cuts
Message-ID: <202503192340.iVN44lM2-lkp@intel.com>
References: <20250319105813.3102076-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319105813.3102076-2-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/net-phy-Fix-formatting-specifier-to-avoid-potential-string-cuts/20250319-190433
base:   net/main
patch link:    https://lore.kernel.org/r/20250319105813.3102076-2-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH net v2 1/2] net: phy: Fix formatting specifier to avoid potential string cuts
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20250319/202503192340.iVN44lM2-lkp@intel.com/config)
compiler: clang version 20.1.0 (https://github.com/llvm/llvm-project 24a30daaa559829ad079f2ff7f73eb4e18095f88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503192340.iVN44lM2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503192340.iVN44lM2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/usb/ax88172a.c:312:20: warning: format specifies type 'unsigned char' but the argument has type 'u16' (aka 'unsigned short') [-Wformat]
     311 |         snprintf(priv->phy_name, 20, PHY_ID_FMT,
         |                                      ~~~~~~~~~~
     312 |                  priv->mdio->id, priv->phy_addr);
         |                                  ^~~~~~~~~~~~~~
   1 warning generated.


vim +312 drivers/net/usb/ax88172a.c

16626b0cc3d5af Christian Riesch 2012-07-13  260  
16626b0cc3d5af Christian Riesch 2012-07-13  261  static int ax88172a_reset(struct usbnet *dev)
16626b0cc3d5af Christian Riesch 2012-07-13  262  {
16626b0cc3d5af Christian Riesch 2012-07-13  263  	struct asix_data *data = (struct asix_data *)&dev->data;
16626b0cc3d5af Christian Riesch 2012-07-13  264  	struct ax88172a_private *priv = dev->driver_priv;
16626b0cc3d5af Christian Riesch 2012-07-13  265  	int ret;
16626b0cc3d5af Christian Riesch 2012-07-13  266  	u16 rx_ctl;
16626b0cc3d5af Christian Riesch 2012-07-13  267  
16626b0cc3d5af Christian Riesch 2012-07-13  268  	ax88172a_reset_phy(dev, priv->use_embdphy);
16626b0cc3d5af Christian Riesch 2012-07-13  269  
16626b0cc3d5af Christian Riesch 2012-07-13  270  	msleep(150);
d9fe64e511144c Robert Foss      2016-08-29  271  	rx_ctl = asix_read_rx_ctl(dev, 0);
16626b0cc3d5af Christian Riesch 2012-07-13  272  	netdev_dbg(dev->net, "RX_CTL is 0x%04x after software reset\n", rx_ctl);
d9fe64e511144c Robert Foss      2016-08-29  273  	ret = asix_write_rx_ctl(dev, 0x0000, 0);
16626b0cc3d5af Christian Riesch 2012-07-13  274  	if (ret < 0)
16626b0cc3d5af Christian Riesch 2012-07-13  275  		goto out;
16626b0cc3d5af Christian Riesch 2012-07-13  276  
d9fe64e511144c Robert Foss      2016-08-29  277  	rx_ctl = asix_read_rx_ctl(dev, 0);
16626b0cc3d5af Christian Riesch 2012-07-13  278  	netdev_dbg(dev->net, "RX_CTL is 0x%04x setting to 0x0000\n", rx_ctl);
16626b0cc3d5af Christian Riesch 2012-07-13  279  
16626b0cc3d5af Christian Riesch 2012-07-13  280  	msleep(150);
16626b0cc3d5af Christian Riesch 2012-07-13  281  
16626b0cc3d5af Christian Riesch 2012-07-13  282  	ret = asix_write_cmd(dev, AX_CMD_WRITE_IPG0,
16626b0cc3d5af Christian Riesch 2012-07-13  283  			     AX88772_IPG0_DEFAULT | AX88772_IPG1_DEFAULT,
d9fe64e511144c Robert Foss      2016-08-29  284  			     AX88772_IPG2_DEFAULT, 0, NULL, 0);
16626b0cc3d5af Christian Riesch 2012-07-13  285  	if (ret < 0) {
16626b0cc3d5af Christian Riesch 2012-07-13  286  		netdev_err(dev->net, "Write IPG,IPG1,IPG2 failed: %d\n", ret);
16626b0cc3d5af Christian Riesch 2012-07-13  287  		goto out;
16626b0cc3d5af Christian Riesch 2012-07-13  288  	}
16626b0cc3d5af Christian Riesch 2012-07-13  289  
16626b0cc3d5af Christian Riesch 2012-07-13  290  	/* Rewrite MAC address */
16626b0cc3d5af Christian Riesch 2012-07-13  291  	memcpy(data->mac_addr, dev->net->dev_addr, ETH_ALEN);
16626b0cc3d5af Christian Riesch 2012-07-13  292  	ret = asix_write_cmd(dev, AX_CMD_WRITE_NODE_ID, 0, 0, ETH_ALEN,
d9fe64e511144c Robert Foss      2016-08-29  293  			     data->mac_addr, 0);
16626b0cc3d5af Christian Riesch 2012-07-13  294  	if (ret < 0)
16626b0cc3d5af Christian Riesch 2012-07-13  295  		goto out;
16626b0cc3d5af Christian Riesch 2012-07-13  296  
16626b0cc3d5af Christian Riesch 2012-07-13  297  	/* Set RX_CTL to default values with 2k buffer, and enable cactus */
d9fe64e511144c Robert Foss      2016-08-29  298  	ret = asix_write_rx_ctl(dev, AX_DEFAULT_RX_CTL, 0);
16626b0cc3d5af Christian Riesch 2012-07-13  299  	if (ret < 0)
16626b0cc3d5af Christian Riesch 2012-07-13  300  		goto out;
16626b0cc3d5af Christian Riesch 2012-07-13  301  
d9fe64e511144c Robert Foss      2016-08-29  302  	rx_ctl = asix_read_rx_ctl(dev, 0);
16626b0cc3d5af Christian Riesch 2012-07-13  303  	netdev_dbg(dev->net, "RX_CTL is 0x%04x after all initializations\n",
16626b0cc3d5af Christian Riesch 2012-07-13  304  		   rx_ctl);
16626b0cc3d5af Christian Riesch 2012-07-13  305  
d9fe64e511144c Robert Foss      2016-08-29  306  	rx_ctl = asix_read_medium_status(dev, 0);
16626b0cc3d5af Christian Riesch 2012-07-13  307  	netdev_dbg(dev->net, "Medium Status is 0x%04x after all initializations\n",
16626b0cc3d5af Christian Riesch 2012-07-13  308  		   rx_ctl);
16626b0cc3d5af Christian Riesch 2012-07-13  309  
16626b0cc3d5af Christian Riesch 2012-07-13  310  	/* Connect to PHY */
16626b0cc3d5af Christian Riesch 2012-07-13  311  	snprintf(priv->phy_name, 20, PHY_ID_FMT,
16626b0cc3d5af Christian Riesch 2012-07-13 @312  		 priv->mdio->id, priv->phy_addr);
16626b0cc3d5af Christian Riesch 2012-07-13  313  
16626b0cc3d5af Christian Riesch 2012-07-13  314  	priv->phydev = phy_connect(dev->net, priv->phy_name,
16626b0cc3d5af Christian Riesch 2012-07-13  315  				   &ax88172a_adjust_link,
f9a8f83b04e0c3 Florian Fainelli 2013-01-14  316  				   PHY_INTERFACE_MODE_MII);
16626b0cc3d5af Christian Riesch 2012-07-13  317  	if (IS_ERR(priv->phydev)) {
16626b0cc3d5af Christian Riesch 2012-07-13  318  		netdev_err(dev->net, "Could not connect to PHY device %s\n",
16626b0cc3d5af Christian Riesch 2012-07-13  319  			   priv->phy_name);
16626b0cc3d5af Christian Riesch 2012-07-13  320  		ret = PTR_ERR(priv->phydev);
16626b0cc3d5af Christian Riesch 2012-07-13  321  		goto out;
16626b0cc3d5af Christian Riesch 2012-07-13  322  	}
16626b0cc3d5af Christian Riesch 2012-07-13  323  
16626b0cc3d5af Christian Riesch 2012-07-13  324  	netdev_info(dev->net, "Connected to phy %s\n", priv->phy_name);
16626b0cc3d5af Christian Riesch 2012-07-13  325  
16626b0cc3d5af Christian Riesch 2012-07-13  326  	/* During power-up, the AX88172A set the power down (BMCR_PDOWN)
16626b0cc3d5af Christian Riesch 2012-07-13  327  	 * bit of the PHY. Bring the PHY up again.
16626b0cc3d5af Christian Riesch 2012-07-13  328  	 */
16626b0cc3d5af Christian Riesch 2012-07-13  329  	genphy_resume(priv->phydev);
16626b0cc3d5af Christian Riesch 2012-07-13  330  	phy_start(priv->phydev);
16626b0cc3d5af Christian Riesch 2012-07-13  331  
16626b0cc3d5af Christian Riesch 2012-07-13  332  	return 0;
16626b0cc3d5af Christian Riesch 2012-07-13  333  
16626b0cc3d5af Christian Riesch 2012-07-13  334  out:
16626b0cc3d5af Christian Riesch 2012-07-13  335  	return ret;
16626b0cc3d5af Christian Riesch 2012-07-13  336  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

