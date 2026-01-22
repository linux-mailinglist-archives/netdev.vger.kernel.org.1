Return-Path: <netdev+bounces-252405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC2+FThCcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:28:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD1368CFA
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D25C1304E6F7
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532BE37F11B;
	Thu, 22 Jan 2026 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPm1gwD6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC8E37B402;
	Thu, 22 Jan 2026 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094972; cv=none; b=WFvYGPfOgRZzYx0/a51GZQZquQ47LJi3nYXnnokW+RC3Zc7yvJsPMBJTk4J6PAEZ7szaWa5vWbCEpndHVjSPFJS845P9uHF+H9CEikGo4ZJY4fp7yw9OBjiI2yuR7/NKX23mxQGVmnTg41Ji3GOsiu1vKVCLdwrfGMKjyth11zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094972; c=relaxed/simple;
	bh=hEjFWHPJTwU36jyq6mh96LiBEsL2uKI2r/oLQDcmGb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4kNoeUeQ1wqcPDGcdIhUXBopzpgxY2vSz/J4o2J6ZeM6KSoAVp8/W8be5QGNGcTZAjWiWgmYrD+o41mFdU5TQc8v6sRRsR/DtT9g0l5me9XYazWWyjrJRFtEmQxiRtFbZYKOzkCCj6rGM3FU1HrRm+jQBo8ODH/P5LwLtlOCxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPm1gwD6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769094970; x=1800630970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hEjFWHPJTwU36jyq6mh96LiBEsL2uKI2r/oLQDcmGb4=;
  b=cPm1gwD6FSlbypAJNUX+1jkoEMsWLMumv+KTZx3bkN1JdgHCOSjqkFWW
   c7vwuQfnooHuV5o+mDlCUDKWB0hQGgS0iQrlClJ2GJgjLINWSmvugMzPZ
   sweeic/uT8Z+m/YcX6DAxtHg2APt4TFg1O7NpJWRoQ5NyyJx5bg+IT+Qs
   RKTzXlDE8/nftXgn5bzjryoAyS1Jq6H8uIyMJ8nAXxqbbmT787zCRRLbT
   kSeWCZtiv/0lxv3iR/ItoeBggtoWwjThZZjhOumYo4ytgnp1ovnelJqXS
   MCWBE+O2dvwa0fUtIfSzRrgGQjJHfMaEdXR0YhaMC5MhprNOVK9n2Yw5c
   w==;
X-CSE-ConnectionGUID: 1ZrL4UURRwS8VkheoDDUAw==
X-CSE-MsgGUID: cRo684vYQlWxPglfGjvLsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70504760"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70504760"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 07:16:09 -0800
X-CSE-ConnectionGUID: gn49yJbDSki1bkexPSz8TQ==
X-CSE-MsgGUID: YrNfleXRQ2yzpifeznZg5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="211615656"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 22 Jan 2026 07:16:06 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viwPj-00000000Sx2-42vT;
	Thu, 22 Jan 2026 15:16:03 +0000
Date: Thu, 22 Jan 2026 23:15:34 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Dejean <dam.dejean@gmail.com>, andrew@lunn.ch,
	krzk+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: Re: [PATCH v2 2/4] net: phy: realtek: add RTL8224 pair order support
Message-ID: <202601222247.z2ExZCHx-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252405-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: AFD1368CFA
X-Rspamd-Action: no action

Hi Damien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 983d014aafb14ee5e4915465bf8948e8f3a723b5]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Dejean/net-phy-realtek-add-RTL8224-pair-order-support/20260122-000009
base:   983d014aafb14ee5e4915465bf8948e8f3a723b5
patch link:    https://lore.kernel.org/r/20260121151506.813783-2-dam.dejean%40gmail.com
patch subject: [PATCH v2 2/4] net: phy: realtek: add RTL8224 pair order support
config: i386-randconfig-141-20260122 (https://download.01.org/0day-ci/archive/20260122/202601222247.z2ExZCHx-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch version: v0.5.0-8985-g2614ff1a

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601222247.z2ExZCHx-lkp@intel.com/

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

