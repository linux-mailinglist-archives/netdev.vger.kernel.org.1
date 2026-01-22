Return-Path: <netdev+bounces-252474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI0IBztrcmnckQAAu9opvQ
	(envelope-from <netdev+bounces-252474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:23:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C5F6C550
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6706F31E81A1
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2D6353EE9;
	Thu, 22 Jan 2026 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2X4zy3q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E3532573B;
	Thu, 22 Jan 2026 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769103633; cv=none; b=L2BmDVw4xZ9j9CRuyjRg71xGZZcsYqc1IQkOpiHZs0H8C/KLTYBfwJKB823iaOIv4gcT5UJtTmNBiBGtAV2UHkMepQiA5tXkHM/G4LL3+IuKGcS3Uk0KkLgzPwFzOHs7SseIf8UtFjpSB/tO0pSMFxeNN3LGCDYKd4/qbON7Mi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769103633; c=relaxed/simple;
	bh=Z+R84j5D0y+EGcYGZf77szrmdtLgDIsT1NFnIIZmzIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZqZC3dcAi1TZHu1NSqz00C1vlTCKeS4xIpTLiQJ8mzs4Nij9ziZ0q7/+oa8VucVJf/cQD3jkQhQrtnpuYAI+33Niotcurqs7ZFev1mipvYOwECfUWJ5X1v6jia7YVrs4UCf4hyOrZWxlzuHMYdRxhemQjQRK34yjqQjILg0ZWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2X4zy3q; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769103626; x=1800639626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z+R84j5D0y+EGcYGZf77szrmdtLgDIsT1NFnIIZmzIk=;
  b=R2X4zy3qaVOHaSeMxJ5x+QpPj3fJcWxjWsCEUwgcTS9W6trFuZTdXsi1
   x+JWlaV9uLVA3GjrhpJYaRe8qOnaL0ugDdLZP2bvU9AHBNSYodRovXK+9
   7Cu6mZHB7E75GVBcQEjpKxAqzvk7Rcx+98cuEUWR1JnNn+hxYy2tLTLlL
   ZWSQI/3NqBK3VZsn6z2EKWkkE3iTYpxct9Y3rTbc8yeG2yQfLYKQp+aqV
   YotvHsGMDAqQr9mT3E8VToOZAApR3OZntLI52mPTPwfk5uNQwjgrBOPMe
   Mv6aAAZ5jQqXPzog3EWC+Oy+IOYGSTF5Ho9dXZBVSbi8VGXEOronsNr5t
   A==;
X-CSE-ConnectionGUID: IG+kUIY2SMKM8ZVt6hiyLQ==
X-CSE-MsgGUID: miW8qqJ3SJa/3gKByTu4ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="81795423"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="81795423"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 09:40:17 -0800
X-CSE-ConnectionGUID: OcKZGVQ8R6KLb5B7eBNb+w==
X-CSE-MsgGUID: n/S0XiraTpyy+caYGaHM1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="211245816"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 22 Jan 2026 09:40:14 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viyfE-00000000T7O-1EOb;
	Thu, 22 Jan 2026 17:40:12 +0000
Date: Fri, 23 Jan 2026 01:39:19 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Dejean <dam.dejean@gmail.com>, andrew@lunn.ch,
	krzk+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: Re: [PATCH v2 2/4] net: phy: realtek: add RTL8224 pair order support
Message-ID: <202601230140.M3peApO0-lkp@intel.com>
References: <20260121151506.813783-2-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121151506.813783-2-dam.dejean@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-252474-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.975];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: B0C5F6C550
X-Rspamd-Action: no action

Hi Damien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 983d014aafb14ee5e4915465bf8948e8f3a723b5]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Dejean/net-phy-realtek-add-RTL8224-pair-order-support/20260122-000009
base:   983d014aafb14ee5e4915465bf8948e8f3a723b5
patch link:    https://lore.kernel.org/r/20260121151506.813783-2-dam.dejean%40gmail.com
patch subject: [PATCH v2 2/4] net: phy: realtek: add RTL8224 pair order support
config: i386-randconfig-141-20260122 (https://download.01.org/0day-ci/archive/20260123/202601230140.M3peApO0-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch version: v0.5.0-8994-gd50c5a4c

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601230140.M3peApO0-lkp@intel.com/

New smatch warnings:
drivers/net/phy/realtek/realtek_main.c:1710 rtl8224_mdi_config_order() warn: unsigned 'val' is never less than zero.

Old smatch warnings:
drivers/net/phy/realtek/realtek_main.c:805 rtl821x_resume() warn: 'priv->clk' from clk_prepare_enable() not released on lines: 801.

vim +/val +1710 drivers/net/phy/realtek/realtek_main.c

  1688	
  1689	static int rtl8224_mdi_config_order(struct phy_device *phydev)
  1690	{
  1691		struct device_node *np = phydev->mdio.dev.of_node;
  1692		u8 port_offset = phydev->mdio.addr & 3;
  1693		u32 mdi_conf, val;
  1694		int ret;
  1695	
  1696		ret = of_property_read_u32(np, "realtek,mdi-cfg-order", &mdi_conf);
  1697	
  1698		/* Do nothing in case the property is not present */
  1699		if (ret == -EINVAL)
  1700			return 0;
  1701	
  1702		if (ret)
  1703			return ret;
  1704	
  1705		if (mdi_conf & ~1)
  1706			return -EINVAL;
  1707	
  1708		val = __phy_package_read_mmd(phydev, 0, MDIO_MMD_VEND1,
  1709					     RTL8224_VND1_MDI_PAIR_SWAP);
> 1710		if (val < 0)
  1711			return val;
  1712	
  1713		if (mdi_conf)
  1714			val |= (1 << port_offset);
  1715		else
  1716			val &= ~(1 << port_offset);
  1717	
  1718		return __phy_package_write_mmd(phydev, 0, MDIO_MMD_VEND1,
  1719					       RTL8224_VND1_MDI_PAIR_SWAP, val);
  1720	}
  1721	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

