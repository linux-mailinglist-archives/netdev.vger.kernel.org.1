Return-Path: <netdev+bounces-252499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIXjNLZwcmlpkwAAu9opvQ
	(envelope-from <netdev+bounces-252499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:47:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 153696CA70
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 314F63011842
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213F9385ED9;
	Thu, 22 Jan 2026 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQZowu+7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACD737D11D;
	Thu, 22 Jan 2026 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107358; cv=none; b=ZoY07XCAx1J1mqqbbN8MwYm2n3H/tGpQAIfiUm4Rxr9h8W1zKRSvv8t+Hp2b2dSruIL3NP6Nms6A1k2XqBz18TcnsmACLmeF4trmwdh2v1uQOcbTEJZTve/UArywsLkgGABIPDsGc7Kn6mfjZfKjaadW8ZIhF+mbDU8CDUmw+34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107358; c=relaxed/simple;
	bh=BN/pC1Tv6LR754wFtKBSqKF3/ANhaf9GJBQL5ftXzv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3wRWvhZJDtFodfuIfKZShgVu8SEWTlbk8Vg62hFt/U74AGa5UclgN4nZg/0WuDujHzJIUouizab2PrAlbKtqrAhnsBfNAShUbFvKDnwLcW39OlDbawEidFfbVbptENdlIciGA/WJavihKx/+6RdJ/cWGrR+o8fqEItTMm0CY6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQZowu+7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769107345; x=1800643345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BN/pC1Tv6LR754wFtKBSqKF3/ANhaf9GJBQL5ftXzv4=;
  b=NQZowu+7rQp/TFWvyJdGDrV71ngc9W7vWtkNv412VktHTizmT3wOlsuy
   RjyOkq8g+WVCIlMg0JCfOhQdCbOsoAtaYSKdfn7S4ssA1m5yTjppQxVhr
   LgmSuF+fB/Dz0FZZyxyuhR/7xRLORxUzYa8r+0OI0doIBRqn5q1m2cCLX
   86k6FXwPAvzUGLMubcxrnwUmeHuGTn7Q+CCXbT10PPltb3UReLaOQWxQv
   blWODbGKXm7YJffeoNpBVNREhYgTbdE62/+dFOP3uDc9VTka1rYEMTP1s
   sn8vNfHGmUKq3Wqr3OpVgkojYyfmzw8O6lrlp/6366kXkfOChWuTBgq8v
   Q==;
X-CSE-ConnectionGUID: ifVMM3QlRCGYnw+irV+Z2g==
X-CSE-MsgGUID: rAHPtguQS/CEooe+5a6aKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70450016"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70450016"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 10:42:20 -0800
X-CSE-ConnectionGUID: dmHKRQjMTOWz86PkOuIFJw==
X-CSE-MsgGUID: kmYbyz/ASxeo+V+bVuCozA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="229775130"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 22 Jan 2026 10:42:17 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vizdH-00000000TBG-0Nha;
	Thu, 22 Jan 2026 18:42:15 +0000
Date: Fri, 23 Jan 2026 02:41:50 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Dejean <dam.dejean@gmail.com>, andrew@lunn.ch,
	krzk+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: Re: [PATCH v2 4/4] net: phy: realtek: add RTL8224 polarity support
Message-ID: <202601230236.Ey3jrFu2-lkp@intel.com>
References: <20260121151506.813783-4-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121151506.813783-4-dam.dejean@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-252499-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.977];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 153696CA70
X-Rspamd-Action: no action

Hi Damien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 983d014aafb14ee5e4915465bf8948e8f3a723b5]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Dejean/net-phy-realtek-add-RTL8224-pair-order-support/20260122-000009
base:   983d014aafb14ee5e4915465bf8948e8f3a723b5
patch link:    https://lore.kernel.org/r/20260121151506.813783-4-dam.dejean%40gmail.com
patch subject: [PATCH v2 4/4] net: phy: realtek: add RTL8224 polarity support
config: i386-randconfig-141-20260122 (https://download.01.org/0day-ci/archive/20260123/202601230236.Ey3jrFu2-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch version: v0.5.0-8994-gd50c5a4c

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601230236.Ey3jrFu2-lkp@intel.com/

New smatch warnings:
drivers/net/phy/realtek/realtek_main.c:1744 rtl8224_mdi_config_polarity() warn: unsigned 'val' is never less than zero.

Old smatch warnings:
drivers/net/phy/realtek/realtek_main.c:806 rtl821x_resume() warn: 'priv->clk' from clk_prepare_enable() not released on lines: 802.
drivers/net/phy/realtek/realtek_main.c:1711 rtl8224_mdi_config_order() warn: unsigned 'val' is never less than zero.

vim +/val +1744 drivers/net/phy/realtek/realtek_main.c

  1722	
  1723	static int rtl8224_mdi_config_polarity(struct phy_device *phydev)
  1724	{
  1725		struct device_node *np = phydev->mdio.dev.of_node;
  1726		u8 port_offset = phydev->mdio.addr & 3;
  1727		u32 polarity, val;
  1728		int ret;
  1729	
  1730		ret = of_property_read_u32(np, "realtek,mdi-cfg-polarity", &polarity);
  1731	
  1732		/* Do nothing if the property is not present */
  1733		if (ret == -EINVAL)
  1734			return 0;
  1735	
  1736		if (!ret)
  1737			return ret;
  1738	
  1739		if (polarity & ~0xf)
  1740			return -EINVAL;
  1741	
  1742		val = __phy_package_read_mmd(phydev, 0, MDIO_MMD_VEND1,
  1743					     RTL8224_VND1_MDI_POLARITY_SWAP);
> 1744		if (val < 0)
  1745			return val;
  1746	
  1747		val &= ~(0xf << port_offset);
  1748		val |= polarity << port_offset;
  1749		return __phy_package_write_mmd(phydev, 0, MDIO_MMD_VEND1,
  1750					       RTL8224_VND1_MDI_POLARITY_SWAP, val);
  1751	}
  1752	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

