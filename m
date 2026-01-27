Return-Path: <netdev+bounces-254026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBKzBvQ/eWmAwAEAu9opvQ
	(envelope-from <netdev+bounces-254026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:45:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EAD9B32D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9FDAA300C0E2
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26762980A8;
	Tue, 27 Jan 2026 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLSWQbC5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028A82E9EB9;
	Tue, 27 Jan 2026 22:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769553904; cv=none; b=kvOaNLKfFRiMbBA2HffZp+mruntqYyC9uTcRzz57GogHMeQ5D8y7Ndi5j+aR/E7DVkk+jHmjkTGxlVnioMEACG2ba1Pl0dqmNQuud1Eig1LmnF3Ck/IKfdJA5LBs7cC9vKsLe6HI5N63rCDhC/oXC3wE5WWHWl9mWQsumpoJToc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769553904; c=relaxed/simple;
	bh=Fyfig1hlmqksh+KcRGovg5cENmEy6664DDkuXWFmK48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tshk0SD2/iEFrgRx6DMJZOti3LCbQIZg5ZEKzMJjA4HLYUmNK8zrcqnU7TcemhOcBu2lo9R4hacNRabubf/bpuZmoujA+a4H727tE8XXRqYaNLzGMF69DBb/0uMMkK7Ju3zPn3+MvrpOqBrZd6jyOjSZ5XLuhIOOd3j5dKxub9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLSWQbC5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769553903; x=1801089903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fyfig1hlmqksh+KcRGovg5cENmEy6664DDkuXWFmK48=;
  b=MLSWQbC5U/xa0B+UwqzVvHrUiGzDTpURlRrXNxjxT+Savp4N1pXCH/4C
   KWoc7aNXUit89d9zZJT9ErjD011C6JYOo2lIpjG+tjs9DKH3SwzwdQYua
   0WvO+1kOKXXxnXU5tvgf+qq4EicaFghMy5O7429QDzKCZDuPKvPpiXjto
   lLPbeILDkIvjAbxJTxJ4bOxdjW/vInmcWg2ucuGRS52OzEc5Jy8aGiV1i
   oW6xaT3azezC5JabkYvtftHSGhSabRI89oVbZ6Zjf2jeV3wsJP2Ti2OgK
   7hTdGIekwcGX/DqzsczqBB27fAknDQBSLBxixacAuFFOIQIhexZJtMh7H
   w==;
X-CSE-ConnectionGUID: xCQVy6RHQU+a/fPaJ5MdOA==
X-CSE-MsgGUID: AuUPboCiRM6cZoIgQ92eFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="88339594"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="88339594"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 14:45:02 -0800
X-CSE-ConnectionGUID: Y/YszoS9TKm0VeoYoRYcVQ==
X-CSE-MsgGUID: Qirxfc7BS7mjeRGGm3t8Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="208333165"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 27 Jan 2026 14:44:56 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkrnp-00000000YzA-3ywp;
	Tue, 27 Jan 2026 22:44:53 +0000
Date: Wed, 28 Jan 2026 06:44:39 +0800
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
Message-ID: <202601280624.F1IZ2yHm-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-254026-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: A8EAD9B32D
X-Rspamd-Action: no action

Hi Maxime,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Chevallier/net-phy-phy_port-Correctly-recompute-the-port-s-linkmodes/20260127-215318
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260127134202.8208-11-maxime.chevallier%40bootlin.com
patch subject: [PATCH net-next 10/13] net: phy: phy_link_topology: Add a helper to retrieve ports
config: s390-randconfig-002-20260128 (https://download.01.org/0day-ci/archive/20260128/202601280624.F1IZ2yHm-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260128/202601280624.F1IZ2yHm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601280624.F1IZ2yHm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/ethtool/tsinfo.c:5:
   include/linux/phy_link_topology.h:110:1: error: return type defaults to 'int' [-Werror=implicit-int]
    phy_link_topo_get_port(struct net_device *dev, u32 port_id)
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/phy_link_topology.h:110:1: warning: no previous prototype for 'phy_link_topo_get_port' [-Wmissing-prototypes]
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/uapi/linux/net_tstamp.h:13,
                    from include/linux/net_tstamp.h:6,
                    from net/ethtool/tsinfo.c:3:
   include/linux/phy_link_topology.h: In function 'phy_link_topo_get_port':
>> include/linux/stddef.h:8:14: warning: returning 'void *' from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
    #define NULL ((void *)0)
                 ^
   include/linux/phy_link_topology.h:112:9: note: in expansion of macro 'NULL'
     return NULL;
            ^~~~
   cc1: some warnings being treated as errors


vim +8 include/linux/stddef.h

^1da177e4c3f41 Linus Torvalds   2005-04-16  6  
^1da177e4c3f41 Linus Torvalds   2005-04-16  7  #undef NULL
^1da177e4c3f41 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
6e218287432472 Richard Knutsson 2006-09-30  9  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

