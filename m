Return-Path: <netdev+bounces-254035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCwQKndHeWlWwQEAu9opvQ
	(envelope-from <netdev+bounces-254035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 00:17:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F2A9B5A8
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 00:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A857300B05B
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CB929B22F;
	Tue, 27 Jan 2026 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8RpoYDm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F093F26ED3A;
	Tue, 27 Jan 2026 23:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769555828; cv=none; b=ji+qvBffMDB7Qwt52teAT069Bm3dKpK8qrIFwXnwpihEvihM1p49SxnSOxnWVAUG13eZ/YBOnskzAcpm32vmo9bYl5alDeLePX0FUOfMnUntwxDds5653iPJgNj4xNxVqefYJM4F6Z5+qQHtByNGlfoc09Ms2xoPUhJe1NvuWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769555828; c=relaxed/simple;
	bh=gWope56I4QlZ5z0v2nya+iChrbGZ5OFefD3iU3L0jIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcvXvUzG4ke/GgOkWustDqxh6VkjDnClI57SERs74g+mrGA+yDShrAb1jKhCkY3BdFmHAYrjJLDjPsTpYTLMao8Mf6hKqL5el0Y+WCt7a5B2yaG7Gp0XvnDdPI0JgxoeffYme4CLnvSOUnI8cGXJtoSa/ghSzXARqqmqs6x85Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8RpoYDm; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769555826; x=1801091826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gWope56I4QlZ5z0v2nya+iChrbGZ5OFefD3iU3L0jIE=;
  b=Q8RpoYDmVA4P1Ezj7NZ0cMqmnuLPDAFjz4ruWw5KmAZFNufYrs2pGePM
   /fiIfmSHqBTugt4AkmsyTJBzMgWHnA5sbvE7u3MzKId1C/n9iYuSZfw/Q
   7nQ4oGwhG3gBiyZZkuaRlKLKlvogb+QOvO8HfruVFrbPgHsZFVNWUaIUL
   m0TMbTl/ZpGZxz5b/g2ZoQccx6b1Ki8xXhcMhPP6ibAgXadMEw4IsIrsY
   K6ExeI+2q6ZC3J8pkcDRup00Kbmt7w7XjLkoX4EFp358nEhkmaUuQdtLS
   WzWYSTgCkhQesVt1G15zTYgiddBT1JGj99QlC6Ql7msol+Xx1ZRavU0JC
   A==;
X-CSE-ConnectionGUID: rgvIkxMdTU2zXdAVLxCt7A==
X-CSE-MsgGUID: V/mZ3w9oSJaCVTEwqf6vqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81487176"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="81487176"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 15:17:05 -0800
X-CSE-ConnectionGUID: /JJWdyt3RViz2ZMVXJtj5A==
X-CSE-MsgGUID: r54WFEILSWu4mw5pZwG6CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="208461286"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 27 Jan 2026 15:17:00 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vksIr-00000000Z1M-22wR;
	Tue, 27 Jan 2026 23:16:57 +0000
Date: Wed, 28 Jan 2026 07:16:51 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
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
Subject: Re: [PATCH net-next 13/13] net: ethtool: Introduce ethtool command
 to list ports
Message-ID: <202601280753.G8XBwank-lkp@intel.com>
References: <20260127134202.8208-14-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127134202.8208-14-maxime.chevallier@bootlin.com>
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
	FREEMAIL_CC(0.00)[lists.linux.dev,bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-254035-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 62F2A9B5A8
X-Rspamd-Action: no action

Hi Maxime,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Chevallier/net-phy-phy_port-Correctly-recompute-the-port-s-linkmodes/20260127-215318
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260127134202.8208-14-maxime.chevallier%40bootlin.com
patch subject: [PATCH net-next 13/13] net: ethtool: Introduce ethtool command to list ports
config: um-defconfig (https://download.01.org/0day-ci/archive/20260128/202601280753.G8XBwank-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260128/202601280753.G8XBwank-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601280753.G8XBwank-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/core/dev.c:165:
>> include/linux/phy_link_topology.h:110:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     110 | phy_link_topo_get_port(struct net_device *dev, u32 port_id)
         | ^
         | int
>> include/linux/phy_link_topology.h:112:9: error: incompatible pointer to integer conversion returning 'void *' from a function with result type 'int' [-Wint-conversion]
     112 |         return NULL;
         |                ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
       8 | #define NULL ((void *)0)
         |              ^~~~~~~~~~~
   In file included from net/core/dev.c:165:
   include/linux/phy_link_topology.h:110:1: warning: no previous prototype for function 'phy_link_topo_get_port' [-Wmissing-prototypes]
     110 | phy_link_topo_get_port(struct net_device *dev, u32 port_id)
         | ^
   include/linux/phy_link_topology.h:110:23: note: declare 'static' if the function is not intended to be used outside of this translation unit
     110 | phy_link_topo_get_port(struct net_device *dev, u32 port_id)
         |                       ^
         |                       static 
   1 warning and 2 errors generated.
--
   In file included from net/ethtool/port.c:11:
>> include/linux/phy_link_topology.h:110:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     110 | phy_link_topo_get_port(struct net_device *dev, u32 port_id)
         | ^
         | int
>> include/linux/phy_link_topology.h:112:9: error: incompatible pointer to integer conversion returning 'void *' from a function with result type 'int' [-Wint-conversion]
     112 |         return NULL;
         |                ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
       8 | #define NULL ((void *)0)
         |              ^~~~~~~~~~~
   In file included from net/ethtool/port.c:11:
   include/linux/phy_link_topology.h:110:1: warning: no previous prototype for function 'phy_link_topo_get_port' [-Wmissing-prototypes]
     110 | phy_link_topo_get_port(struct net_device *dev, u32 port_id)
         | ^
   include/linux/phy_link_topology.h:110:23: note: declare 'static' if the function is not intended to be used outside of this translation unit
     110 | phy_link_topo_get_port(struct net_device *dev, u32 port_id)
         |                       ^
         |                       static 
>> net/ethtool/port.c:70:7: error: incompatible integer to pointer conversion assigning to 'struct phy_port *' from 'int' [-Wint-conversion]
      70 |         port = phy_link_topo_get_port(req_info->dev, request->port_id);
         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 3 errors generated.


vim +/int +110 include/linux/phy_link_topology.h

624ef6af11779e Maxime Chevallier 2026-01-27  109  
624ef6af11779e Maxime Chevallier 2026-01-27 @110  phy_link_topo_get_port(struct net_device *dev, u32 port_id)
624ef6af11779e Maxime Chevallier 2026-01-27  111  {
624ef6af11779e Maxime Chevallier 2026-01-27 @112  	return NULL;
624ef6af11779e Maxime Chevallier 2026-01-27  113  }
38496878690920 Maxime Chevallier 2024-08-21  114  #endif
38496878690920 Maxime Chevallier 2024-08-21  115  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

