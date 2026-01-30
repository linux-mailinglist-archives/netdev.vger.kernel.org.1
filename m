Return-Path: <netdev+bounces-255046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKB8HgFhfGl0MAIAu9opvQ
	(envelope-from <netdev+bounces-255046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 08:42:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0F0B7FDF
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 08:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6B273033898
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 07:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A36315D35;
	Fri, 30 Jan 2026 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfMgV1Pl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A2A3128A2;
	Fri, 30 Jan 2026 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769758909; cv=none; b=Vf6ZgfDZnteVZATDDo8QZgsufdOmjwBQ8T3UMZ/4sCKsxKtYY67t69oV1GrGhPGkTPhK70YCKEzKi1TOgtjuJCT5ZcbbVdc7VTaVHp9EY2cuihr0lGoYpQBjzPHIbhQJx6+738xHHM3w1+OySexgdE6n2txmP1Zo3kfQOPu0+Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769758909; c=relaxed/simple;
	bh=cXi0KRzZoV34WeDhHHBqcZR1/JcRSeqxXpA0StBk5vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0T5ARg2jMdnT+Tjc6NXNRWFWAvqF08JWRK8vPMQyx2ivOcZUVMer8k/LHfM+uQfkdiB/jDyd4UlRTkOk7WNa3w97Cfzj70aw0s/7P7JKu9bFqg/YVV7Paw1gYBvFhW0b7ZyHIdkNXFir96yb9h4d2m7oVFbJFQ9zkni5EEHoaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfMgV1Pl; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769758907; x=1801294907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cXi0KRzZoV34WeDhHHBqcZR1/JcRSeqxXpA0StBk5vM=;
  b=jfMgV1Pleth1hGdOzquRHRKyrsnGEgTUfTHisBmSASa/XJR8P0zY5kDo
   4RhMu0f6I9ERTndhlcXB7wzopsmIIv+Mea12fA9cplDCN8vxwSVIKRJL2
   QnUn196t4oOBSuA7ZC8lCYP5NnL5M2WvqUpbFioCdt0V3lwgQIl8ei7CW
   hlGFfGH6mBCDMMjUhgLAtY0HQrN5gBK3vlj5o3cQjXKaYma0LA6Aw5h3R
   k4TFr7h3r8ftnFVaNCr9k6IWwzdMdSi2adwD1b6NMhHvwI9DzZa+cPBZk
   Q6YCHmrpbbWWO522Pre4v3V1XVVKYo0I/IldNg3p+OGRfivOfjgBfOnbo
   A==;
X-CSE-ConnectionGUID: 3apuhws5R/iaOsyrdCuiZg==
X-CSE-MsgGUID: XS7I4GrZRRuZjn+NhcV6wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82378407"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="82378407"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 23:41:46 -0800
X-CSE-ConnectionGUID: KMnMedBOSHyr8E/b7Ob4jQ==
X-CSE-MsgGUID: wLknmg+BTlSWpoyN9Da0yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="246411346"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 29 Jan 2026 23:41:40 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlj8L-00000000cKo-1bmS;
	Fri, 30 Jan 2026 07:41:37 +0000
Date: Fri, 30 Jan 2026 15:40:42 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v10 4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <202601301504.2pd3tNrg-lkp@intel.com>
References: <281fd7e777b51849fac9ef5191679586cc2a1b54.1769731630.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <281fd7e777b51849fac9ef5191679586cc2a1b54.1769731630.git.daniel@makrotopia.org>
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
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	TAGGED_FROM(0.00)[bounces-255046-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: DC0F0B7FDF
X-Rspamd-Action: no action

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/dt-bindings-net-dsa-add-MaxLinear-MxL862xx/20260130-085313
base:   net-next/main
patch link:    https://lore.kernel.org/r/281fd7e777b51849fac9ef5191679586cc2a1b54.1769731630.git.daniel%40makrotopia.org
patch subject: [PATCH net-next v10 4/4] net: dsa: add basic initial driver for MxL862xx switches
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20260130/202601301504.2pd3tNrg-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260130/202601301504.2pd3tNrg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601301504.2pd3tNrg-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/dsa/mxl862xx/mxl862xx.c: In function 'mxl862xx_port_setup':
>> drivers/net/dsa/mxl862xx/mxl862xx.c:331:32: error: passing argument 1 of 'dsa_port_is_unused' from incompatible pointer type [-Wincompatible-pointer-types]
     331 |         if (dsa_port_is_unused(ds, port) ||
         |                                ^~
         |                                |
         |                                struct dsa_switch *
   In file included from drivers/net/dsa/mxl862xx/mxl862xx.c:16:
   include/net/dsa.h:546:56: note: expected 'struct dsa_port *' but argument is of type 'struct dsa_switch *'
     546 | static inline bool dsa_port_is_unused(struct dsa_port *dp)
         |                                       ~~~~~~~~~~~~~~~~~^~
>> drivers/net/dsa/mxl862xx/mxl862xx.c:331:13: error: too many arguments to function 'dsa_port_is_unused'; expected 1, have 2
     331 |         if (dsa_port_is_unused(ds, port) ||
         |             ^~~~~~~~~~~~~~~~~~     ~~~~
   include/net/dsa.h:546:20: note: declared here
     546 | static inline bool dsa_port_is_unused(struct dsa_port *dp)
         |                    ^~~~~~~~~~~~~~~~~~
>> drivers/net/dsa/mxl862xx/mxl862xx.c:332:29: error: passing argument 1 of 'dsa_port_is_dsa' from incompatible pointer type [-Wincompatible-pointer-types]
     332 |             dsa_port_is_dsa(ds, port))
         |                             ^~
         |                             |
         |                             struct dsa_switch *
   include/net/dsa.h:531:53: note: expected 'struct dsa_port *' but argument is of type 'struct dsa_switch *'
     531 | static inline bool dsa_port_is_dsa(struct dsa_port *port)
         |                                    ~~~~~~~~~~~~~~~~~^~~~
>> drivers/net/dsa/mxl862xx/mxl862xx.c:332:13: error: too many arguments to function 'dsa_port_is_dsa'; expected 1, have 2
     332 |             dsa_port_is_dsa(ds, port))
         |             ^~~~~~~~~~~~~~~     ~~~~
   include/net/dsa.h:531:20: note: declared here
     531 | static inline bool dsa_port_is_dsa(struct dsa_port *port)
         |                    ^~~~~~~~~~~~~~~


vim +/dsa_port_is_unused +331 drivers/net/dsa/mxl862xx/mxl862xx.c

   317	
   318	static int mxl862xx_port_setup(struct dsa_switch *ds, int port)
   319	{
   320		bool is_cpu_port = dsa_is_cpu_port(ds, port);
   321		int ret;
   322	
   323		/* disable port and flush MAC entries */
   324		ret = mxl862xx_port_state(ds, port, false);
   325		if (ret)
   326			return ret;
   327	
   328		mxl862xx_port_fast_age(ds, port);
   329	
   330		/* skip setup for unused and DSA ports */
 > 331		if (dsa_port_is_unused(ds, port) ||
 > 332		    dsa_port_is_dsa(ds, port))
   333			return 0;
   334	
   335		/* configure tag protocol */
   336		ret = mxl862xx_configure_sp_tag_proto(ds, port, is_cpu_port);
   337		if (ret)
   338			return ret;
   339	
   340		/* assign CTP port IDs */
   341		ret = mxl862xx_configure_ctp_port(ds, port, port,
   342						  is_cpu_port ? 32 - port : 1);
   343		if (ret)
   344			return ret;
   345	
   346		if (is_cpu_port)
   347			/* assign user ports to CPU port bridge */
   348			return mxl862xx_setup_cpu_bridge(ds, port);
   349	
   350		/* setup single-port bridge for user ports */
   351		return mxl862xx_add_single_port_bridge(ds, port);
   352	}
   353	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

