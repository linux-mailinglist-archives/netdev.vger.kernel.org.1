Return-Path: <netdev+bounces-252547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IZuLBuhcmnwngAAu9opvQ
	(envelope-from <netdev+bounces-252547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:13:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5176E16A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A2B5300CC14
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB0A3B8D5B;
	Thu, 22 Jan 2026 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6/dldaE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327B33B8BBE;
	Thu, 22 Jan 2026 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119955; cv=none; b=qPNN5nj8qycK+FPq4wjR+OLuHQwPeYdOMSc2eVVVXqPMFUpjZ3fJuMEc9r2OAho2TInEDieiveCZCX+Sny2Q4umxKb4MXLLvWBYFek5asjg/9GCkkjcouHiORb9PW8Y1ySOoxVcPoDzPUOVq7P/fSvmHy/XiT0ZAhbbTqVPp6gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119955; c=relaxed/simple;
	bh=fbAxZ8+4E0E6YP5OYQFpZpSY13OcTcToB8nH0fiQdIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDiR6RgvXUVl1E/zfJF2QiFZZLuQlpmLE7aXZTmdyThTdW6SqPnVL486Xl72uQ8n/G5tRpMbxPhZs/xDubWtNdtmxRiMgJTkyzBYwA/QZnklAWeLIRVxAdUODND3xktJsN+iLZU9IlgSvPPQ2ZLpk3+TVzlhgC8xmOru4MUKT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6/dldaE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769119950; x=1800655950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fbAxZ8+4E0E6YP5OYQFpZpSY13OcTcToB8nH0fiQdIE=;
  b=R6/dldaEQ3tJVvoqi3eL6FRECWDVB6svR6NaHVLIOCD7Fq25mwZ5iowE
   gmGRSoTlXj4lALE5f0ZT4Pg1FTvC4tObQXoBQ/5/PU5D/V5EYGms/Ayim
   2b9YEtFWzwW6gcni6iAJo9mfpd/dJpFyN0a6keHrlQbzGZHwNV//kuX6k
   LGnr9V8k1AgQ5fleuJoC3ynfrxRd4r10K8pQ5HR5sP4assk6gEhDxcEKU
   HUZpsreHCYgJX0vJ3OjT0hXOon/DpFR3oBnthZzlAbXg8yEGNFCH+wXaa
   fvLzOHBN35Q3FMZIq+H15KYH7POoXGw0Jn0cE9dJZVK9BPRjrdqB3Pcj2
   A==;
X-CSE-ConnectionGUID: 4OPLtGuVQuqoA2nxl5BHQQ==
X-CSE-MsgGUID: uh/TbqVEQhuYgqoN0LmFXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="93037575"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="93037575"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 14:12:25 -0800
X-CSE-ConnectionGUID: Rz737VhmTIG3jaDZk0URgA==
X-CSE-MsgGUID: lQbcgB2oSc+fw2btgDSC4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206900739"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 22 Jan 2026 14:12:21 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vj2uZ-00000000THW-2Cx9;
	Thu, 22 Jan 2026 22:12:19 +0000
Date: Fri, 23 Jan 2026 06:12:01 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Dejean <dam.dejean@gmail.com>, andrew@lunn.ch,
	krzk+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: Re: [PATCH v2 4/4] net: phy: realtek: add RTL8224 polarity support
Message-ID: <202601230608.52Hf4Qza-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-252547-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.981];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B5176E16A
X-Rspamd-Action: no action

Hi Damien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 983d014aafb14ee5e4915465bf8948e8f3a723b5]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Dejean/net-phy-realtek-add-RTL8224-pair-order-support/20260122-000009
base:   983d014aafb14ee5e4915465bf8948e8f3a723b5
patch link:    https://lore.kernel.org/r/20260121151506.813783-4-dam.dejean%40gmail.com
patch subject: [PATCH v2 4/4] net: phy: realtek: add RTL8224 polarity support
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20260123/202601230608.52Hf4Qza-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260123/202601230608.52Hf4Qza-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601230608.52Hf4Qza-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In function 'rtl8224_mdi_config_polarity',
       inlined from 'rtl8224_config_init' at drivers/net/phy/realtek/realtek_main.c:1761:9:
>> drivers/net/phy/realtek/realtek_main.c:1739:12: warning: 'polarity' is used uninitialized [-Wuninitialized]
    1739 |         if (polarity & ~0xf)
         |            ^
   drivers/net/phy/realtek/realtek_main.c:1727:13: note: 'polarity' was declared here
    1727 |         u32 polarity, val;
         |             ^~~~~~~~


vim +/polarity +1739 drivers/net/phy/realtek/realtek_main.c

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
> 1739		if (polarity & ~0xf)
  1740			return -EINVAL;
  1741	
  1742		val = __phy_package_read_mmd(phydev, 0, MDIO_MMD_VEND1,
  1743					     RTL8224_VND1_MDI_POLARITY_SWAP);
  1744		if (val < 0)
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

