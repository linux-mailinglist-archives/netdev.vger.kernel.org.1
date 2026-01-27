Return-Path: <netdev+bounces-254015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CK3JTI7eWkmwAEAu9opvQ
	(envelope-from <netdev+bounces-254015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:24:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCECF9AFED
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66AE8304751C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C9B36680A;
	Tue, 27 Jan 2026 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/oUy+jg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEC836075E;
	Tue, 27 Jan 2026 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769552643; cv=none; b=VmnjfcDPhhU4X888UIfaKtuyyte/tLQ/jYumI2Yi0NTE0ea7cAdF77R7IDCNQzGcauwzY7nHMq4YZitsH6y+3ZPfbKH9uq4TSvGjih2tsnZDRpnhaTuKRhyF5Zf2UXmqXQR8axDSc+fHTrw+8BKgsKOy0Z36JNLDoALA1eyKQxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769552643; c=relaxed/simple;
	bh=btv2N3BYSmYw7FfTJ4mrRfI153ka+xbTQC0KedUlZ74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BA1v5BMm2nMhAqIOhuPHgQSjmjqUz3BsfDpxXBLZGNpGkKtu7n5btTBPgu+Eam16k9gVOvQ8dbcnMvbdoc5gcQottmZUx9AZ9ytq22bNArMAgrtMDITckQ7VUMiVZJDkNxYuMhusEnNIJjfxMY6TdvjvMH0enZWqo1ae7ie9p0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/oUy+jg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769552641; x=1801088641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=btv2N3BYSmYw7FfTJ4mrRfI153ka+xbTQC0KedUlZ74=;
  b=W/oUy+jgel0RXHMeCaRh3Wo9Jq4+bgtxrVJuW3R1k/KH1FH59Htlp5zW
   x23/kaQlhuHB37Lh7QiVzhVdh2K64McPN678O24TFTysYqJw0pSTSMk+x
   FKX3xrBdnYZyvIEAQiSxl/k9CS6ky3wLzyKVUKBxgwEKfQNKbowGvw8el
   j+ItnpOq2Uw7vbp1aO92CiSn+9l09DPC/1PFq1dOkavyc2eUg/G1n1JXB
   gnNRgAKn1sXQAViDOUP4ijH/k5fblzBePCmC0BeoOsZQsuy68EM2qlbwL
   YAy601lTsprrYAo0gdWR04AKhtl6L0XxTf7TQ7PfH8L1Xo9WM+HeXvApP
   Q==;
X-CSE-ConnectionGUID: i+Y3FEISR+qyykCfZDlbiA==
X-CSE-MsgGUID: Jzw2ghe+SheIiB6use3Ykg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81393765"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="81393765"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 14:24:01 -0800
X-CSE-ConnectionGUID: RZEBSTJQQ76KaM4MOMQlPA==
X-CSE-MsgGUID: Q9kQzI6VQ1CYLn6/VfKKTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="239350957"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 27 Jan 2026 14:23:55 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkrTV-00000000YyI-0uDP;
	Tue, 27 Jan 2026 22:23:53 +0000
Date: Wed, 28 Jan 2026 06:23:19 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH net-next 10/13] net: phy: phy_link_topology: Add a helper
 to retrieve ports
Message-ID: <202601280617.qlkBpNaP-lkp@intel.com>
References: <20260127134202.8208-11-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127134202.8208-11-maxime.chevallier@bootlin.com>
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
	FREEMAIL_CC(0.00)[lists.linux.dev,bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-254015-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[bootlin.com,davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCECF9AFED
X-Rspamd-Action: no action

Hi Maxime,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Chevallier/net-phy-phy_port-Correctly-recompute-the-port-s-linkmodes/20260127-215318
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260127134202.8208-11-maxime.chevallier%40bootlin.com
patch subject: [PATCH net-next 10/13] net: phy: phy_link_topology: Add a helper to retrieve ports
config: i386-randconfig-141-20260128 (https://download.01.org/0day-ci/archive/20260128/202601280617.qlkBpNaP-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260128/202601280617.qlkBpNaP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601280617.qlkBpNaP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/core/dev.c:165:
>> include/linux/phy_link_topology.h:110:1: error: return type defaults to 'int' [-Wimplicit-int]
     110 | phy_link_topo_get_port(struct net_device *dev, u32 port_id)
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/phy_link_topology.h:110:1: warning: no previous prototype for 'phy_link_topo_get_port' [-Wmissing-prototypes]
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/x86/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:380,
                    from include/linux/cleanup.h:5,
                    from include/linux/uaccess.h:5,
                    from net/core/dev.c:71:
   include/linux/phy_link_topology.h: In function 'phy_link_topo_get_port':
>> include/linux/stddef.h:8:14: error: returning 'void *' from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
       8 | #define NULL ((void *)0)
         |              ^
   include/linux/phy_link_topology.h:112:16: note: in expansion of macro 'NULL'
     112 |         return NULL;
         |                ^~~~


vim +/int +110 include/linux/phy_link_topology.h

   109	
 > 110	phy_link_topo_get_port(struct net_device *dev, u32 port_id)
   111	{
   112		return NULL;
   113	}
   114	#endif
   115	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

