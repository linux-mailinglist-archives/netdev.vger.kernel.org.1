Return-Path: <netdev+bounces-271301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKHDAYb8wmlXngQAu9opvQ
	(envelope-from <netdev+bounces-271301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:05:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BA831CA8A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2C5A318AAAB
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE7035F5FB;
	Tue, 24 Mar 2026 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWvj8IZh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE335E956;
	Tue, 24 Mar 2026 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774385965; cv=none; b=MVq4HazlPjjexFyexqfhGe4GpTP55SMGgyP5saq8OjL0yoibuVRDK/InNPQRzv6gVM9uI+FhRXh8sTZrjtKDD0oss4qXI9cVNgVjNMLDWlyd1roRXDNHMya6wIc2PQgnSg3qdqJLMmnA65Zf8or8f+AfjP/kBotI1yIJFBM42gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774385965; c=relaxed/simple;
	bh=4hyMla9M/Y6avVaVN56ryzCX6CTzBLSgs1vNFOe2kRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWUAelMkKyPyicDrNMqhncWHmdTkBT1QJsQD9W6tZ85Bme7oobrMBFFpvCjnZ33WYVNtU219ZnFaZuFgK/ScTfHLw+RPeiEtLWZN2x8sfsdfWJDWH6ndyAQzPaOjKAw8y+sbW08xe8g+H2wyi4ssYRh2NQQFlsycYlpi0yyNlSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWvj8IZh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774385963; x=1805921963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4hyMla9M/Y6avVaVN56ryzCX6CTzBLSgs1vNFOe2kRU=;
  b=JWvj8IZhTnTPA6f5aoSJ6Z8dEe+JgSJ0RFf82h+4DaF1jRLKMR8vf6hd
   dGF1UR3fwNchTXWjZ7+Mli5t1Po84sXad69ykrTEMRd+THmuigik0ETTa
   vudEFbOuPEG6uqUmYx+HoY0AOuXwr73rMx03UdJH76+e4ydg2mY7IONKx
   Ydajclt4ZoJqDjg3MGvBWSiFI8mmGvYEdaK7I3PbDdvkfKDhn9Vw7NRp2
   5StSQVVG9uO/LD3P0fDJhnPfXiKD6f1iS/q7Y0ZBKyRySaRbmWWuanH4L
   I3Knse3/+KX9LprR26GB5SmQwfamjESrexpICubN3uJvn8/VNvkbVl0e/
   g==;
X-CSE-ConnectionGUID: M+tBtjaxRq6dxlHnIntCzA==
X-CSE-MsgGUID: qgEStOZERiS6JvUIhLLpeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="85725388"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="85725388"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 13:59:23 -0700
X-CSE-ConnectionGUID: 2y/TFWZdSqW0+gqVPTpxFQ==
X-CSE-MsgGUID: +qdRDBy0TYCxZkBtxOwwrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="224483735"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 24 Mar 2026 13:59:18 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w58qI-000000005R3-1p3e;
	Tue, 24 Mar 2026 20:59:14 +0000
Date: Wed, 25 Mar 2026 04:58:28 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>,
	Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v6 2/4] net: dsa: add bridge member iteration
 macro and port mask helper
Message-ID: <202603250450.uUuzfUx3-lkp@intel.com>
References: <ff936ce4ad3044102c367c55e7a455ab0020e4b7.1774136876.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff936ce4ad3044102c367c55e7a455ab0020e4b7.1774136876.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271301-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 56BA831CA8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/net-dsa-add-driver-private-pointer-to-struct-dsa_bridge/20260323-041502
base:   net-next/main
patch link:    https://lore.kernel.org/r/ff936ce4ad3044102c367c55e7a455ab0020e4b7.1774136876.git.daniel%40makrotopia.org
patch subject: [PATCH net-next v6 2/4] net: dsa: add bridge member iteration macro and port mask helper
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20260325/202603250450.uUuzfUx3-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260325/202603250450.uUuzfUx3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603250450.uUuzfUx3-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/dsa/yt921x.c:2158:1: error: conflicting types for 'dsa_bridge_ports'
   dsa_bridge_ports(struct dsa_switch *ds, const struct net_device *bdev)
   ^
   include/net/dsa.h:845:19: note: previous definition is here
   static inline u32 dsa_bridge_ports(struct dsa_switch *ds,
                     ^
>> drivers/net/dsa/yt921x.c:2213:38: error: incompatible pointer types passing 'struct net_device *' to parameter of type 'const struct dsa_bridge *' [-Werror,-Wincompatible-pointer-types]
                           ports_mask = dsa_bridge_ports(ds, bdev);
                                                             ^~~~
   include/net/dsa.h:846:33: note: passing argument to parameter 'bridge' here
                                      const struct dsa_bridge *bridge)
                                                               ^
   drivers/net/dsa/yt921x.c:2285:36: error: incompatible pointer types passing 'struct net_device *' to parameter of type 'const struct dsa_bridge *' [-Werror,-Wincompatible-pointer-types]
           ports_mask = dsa_bridge_ports(ds, bridge.dev);
                                             ^~~~~~~~~~
   include/net/dsa.h:846:33: note: passing argument to parameter 'bridge' here
                                      const struct dsa_bridge *bridge)
                                                               ^
   3 errors generated.


vim +2213 drivers/net/dsa/yt921x.c

186623f4aa724c David Yang 2025-10-17  2169  
186623f4aa724c David Yang 2025-10-17  2170  static int
186623f4aa724c David Yang 2025-10-17  2171  yt921x_bridge_flags(struct yt921x_priv *priv, int port,
186623f4aa724c David Yang 2025-10-17  2172  		    struct switchdev_brport_flags flags)
186623f4aa724c David Yang 2025-10-17  2173  {
186623f4aa724c David Yang 2025-10-17  2174  	struct yt921x_port *pp = &priv->ports[port];
186623f4aa724c David Yang 2025-10-17  2175  	bool do_flush;
186623f4aa724c David Yang 2025-10-17  2176  	u32 mask;
186623f4aa724c David Yang 2025-10-17  2177  	int res;
186623f4aa724c David Yang 2025-10-17  2178  
186623f4aa724c David Yang 2025-10-17  2179  	if (flags.mask & BR_LEARNING) {
186623f4aa724c David Yang 2025-10-17  2180  		bool learning = flags.val & BR_LEARNING;
186623f4aa724c David Yang 2025-10-17  2181  
186623f4aa724c David Yang 2025-10-17  2182  		mask = YT921X_PORT_LEARN_DIS;
186623f4aa724c David Yang 2025-10-17  2183  		res = yt921x_reg_toggle_bits(priv, YT921X_PORTn_LEARN(port),
186623f4aa724c David Yang 2025-10-17  2184  					     mask, !learning);
186623f4aa724c David Yang 2025-10-17  2185  		if (res)
186623f4aa724c David Yang 2025-10-17  2186  			return res;
186623f4aa724c David Yang 2025-10-17  2187  	}
186623f4aa724c David Yang 2025-10-17  2188  
186623f4aa724c David Yang 2025-10-17  2189  	/* BR_FLOOD, BR_MCAST_FLOOD: see the comment where ACT_UNK_ACTn_TRAP
186623f4aa724c David Yang 2025-10-17  2190  	 * is set
186623f4aa724c David Yang 2025-10-17  2191  	 */
186623f4aa724c David Yang 2025-10-17  2192  
186623f4aa724c David Yang 2025-10-17  2193  	/* BR_BCAST_FLOOD: we can filter bcast, but cannot trap them */
186623f4aa724c David Yang 2025-10-17  2194  
186623f4aa724c David Yang 2025-10-17  2195  	do_flush = false;
186623f4aa724c David Yang 2025-10-17  2196  	if (flags.mask & BR_HAIRPIN_MODE) {
186623f4aa724c David Yang 2025-10-17  2197  		pp->hairpin = flags.val & BR_HAIRPIN_MODE;
186623f4aa724c David Yang 2025-10-17  2198  		do_flush = true;
186623f4aa724c David Yang 2025-10-17  2199  	}
186623f4aa724c David Yang 2025-10-17  2200  	if (flags.mask & BR_ISOLATED) {
186623f4aa724c David Yang 2025-10-17  2201  		pp->isolated = flags.val & BR_ISOLATED;
186623f4aa724c David Yang 2025-10-17  2202  		do_flush = true;
186623f4aa724c David Yang 2025-10-17  2203  	}
186623f4aa724c David Yang 2025-10-17  2204  	if (do_flush) {
186623f4aa724c David Yang 2025-10-17  2205  		struct dsa_switch *ds = &priv->ds;
186623f4aa724c David Yang 2025-10-17  2206  		struct dsa_port *dp = dsa_to_port(ds, port);
186623f4aa724c David Yang 2025-10-17  2207  		struct net_device *bdev;
186623f4aa724c David Yang 2025-10-17  2208  
186623f4aa724c David Yang 2025-10-17  2209  		bdev = dsa_port_bridge_dev_get(dp);
186623f4aa724c David Yang 2025-10-17  2210  		if (bdev) {
186623f4aa724c David Yang 2025-10-17  2211  			u32 ports_mask;
186623f4aa724c David Yang 2025-10-17  2212  
186623f4aa724c David Yang 2025-10-17 @2213  			ports_mask = dsa_bridge_ports(ds, bdev);
186623f4aa724c David Yang 2025-10-17  2214  			ports_mask |= priv->cpu_ports_mask;
186623f4aa724c David Yang 2025-10-17  2215  			res = yt921x_bridge(priv, ports_mask);
186623f4aa724c David Yang 2025-10-17  2216  			if (res)
186623f4aa724c David Yang 2025-10-17  2217  				return res;
186623f4aa724c David Yang 2025-10-17  2218  		}
186623f4aa724c David Yang 2025-10-17  2219  	}
186623f4aa724c David Yang 2025-10-17  2220  
186623f4aa724c David Yang 2025-10-17  2221  	return 0;
186623f4aa724c David Yang 2025-10-17  2222  }
186623f4aa724c David Yang 2025-10-17  2223  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

