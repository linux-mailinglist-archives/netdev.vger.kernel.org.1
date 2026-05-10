Return-Path: <netdev+bounces-286272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kpxmF21ZAGoZGwEAu9opvQ
	(envelope-from <netdev+bounces-286272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 12:09:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC559503909
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 12:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0B18300C906
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 10:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB91535E93E;
	Sun, 10 May 2026 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+/QpCVe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A022D7D3A;
	Sun, 10 May 2026 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778407785; cv=none; b=OGqWcHKaZVwJgmbonpuV8Yxgm2fmeJ++5exfyerjpCbK7UZ4T8ApF9wPDB8fCiLe3c4VNIlwF9BovYgMAskvnRkWW6Z/1blgqPzj75+tD24r9vUf0g71Q/YG8Tq7dB1MJetCoqXWY8Lu6gqybsS753QVEaAtETLDYOCvHHGTxLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778407785; c=relaxed/simple;
	bh=uqlxDGtXqYV/zVFSgS1Lzvi3cG2PZDyfoNyh9tfMy5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qM7yCmekw3T7waRLVHp0wpX9TUACJj3v+pgEBzYmNdmCUsw80J6RsEVB56X35vcyVI9njgv8q+LgcT7ZznQaZfnBavu6d2N8hSx9LvKDak4tm7X0KKVMlateiP1aEUBkMxrMUXN/taaFjlO/Jmf+6i4hv0TEE5Mvmz42I2oOgRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+/QpCVe; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778407783; x=1809943783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uqlxDGtXqYV/zVFSgS1Lzvi3cG2PZDyfoNyh9tfMy5U=;
  b=Z+/QpCVeDCkVwLF+NxyH6fuNpIL6QtJhMj8jZ5qOn3LhPNWBI7abJcjh
   83s3vk2xXuhdsFZY0ho1GqyBBeG9OtmTjr1ee/5SGCzBqofNTSbUFLUdR
   7quuMFZks1RlAw2cRRCeSV5nOzm9UHn2sWH7YWoI+c3n7WjQw7EQ8BEu1
   I4cKbybAF5tecv5mxOpCsi64nO2Ldre25k1g0tZvzhTF5lcdsIBDOhnsz
   jiDcnvpDS+2Vhf0b4JugFd9vetj64m22c36UD1GlTwovhlFFKKRGxO8xm
   7dKgOvb6yzXuu2LBdxof/bpBa2B4dli0PF7bHtFweb0P48devIr/mJSga
   A==;
X-CSE-ConnectionGUID: BMS6xjLBSOeKYg77agzhMA==
X-CSE-MsgGUID: bUiWCvF9RreWfnawRAWfcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="83192992"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="83192992"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 03:09:43 -0700
X-CSE-ConnectionGUID: CB3zKpjIQi65C+iinvZdTA==
X-CSE-MsgGUID: S8kPmL23T8CZPFjhJ5BAzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="275327717"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by orviesa001.jf.intel.com with ESMTP; 10 May 2026 03:09:41 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wM16Q-000000007h3-1gJW;
	Sun, 10 May 2026 10:09:38 +0000
Date: Sun, 10 May 2026 12:08:58 +0200
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v1 5/5] net: mdiobus: Hide acpi_mdio.h
Message-ID: <202605101210.Y9D9eQWJ-lkp@intel.com>
References: <20260504074610.40799-6-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504074610.40799-6-andriy.shevchenko@linux.intel.com>
X-Rspamd-Queue-Id: AC559503909
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,lunn.ch,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286272-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim,01.org:url]
X-Rspamd-Action: no action

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/net-mdiobus-Provide-fwnode_mdiobus_register/20260510-124038
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260504074610.40799-6-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH net-next v1 5/5] net: mdiobus: Hide acpi_mdio.h
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260510/202605101210.Y9D9eQWJ-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260510/202605101210.Y9D9eQWJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605101210.Y9D9eQWJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/mdio/fwnode_mdio.c: In function '__fwnode_mdiobus_register':
>> drivers/net/mdio/fwnode_mdio.c:197:24: error: implicit declaration of function '__of_mdiobus_register'; did you mean 'of_mdiobus_register'? [-Wimplicit-function-declaration]
     197 |                 return __of_mdiobus_register(mdio, to_of_node(fwnode), owner);
         |                        ^~~~~~~~~~~~~~~~~~~~~
         |                        of_mdiobus_register


vim +197 drivers/net/mdio/fwnode_mdio.c

   192	
   193	int __fwnode_mdiobus_register(struct mii_bus *mdio, struct fwnode_handle *fwnode,
   194				      struct module *owner)
   195	{
   196		if (is_of_node(fwnode))
 > 197			return __of_mdiobus_register(mdio, to_of_node(fwnode), owner);

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

