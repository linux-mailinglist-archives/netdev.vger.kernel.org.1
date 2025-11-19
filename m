Return-Path: <netdev+bounces-239940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA36C6E395
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3FCF23524FD
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B33035389E;
	Wed, 19 Nov 2025 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="laf8a0QP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A54352FA2;
	Wed, 19 Nov 2025 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551243; cv=none; b=on75ICgcBZnEIoZd8b2qzPS9ksnAGlT2IblP3+BN7iRNOi9NTep+crFOcAvN5g9+2mo/5k3dm8+PbFqEcxG+c4GEmyB/OE1KGD6tMDhDT5AXmHC0V5w7BziQF9GjNQl4zmhdrSEwjMWKLKpG+0zGJKvb064r7n/BsB+7XQrzBus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551243; c=relaxed/simple;
	bh=8GYEEcFXxf1XWxFmK+/08Fz7rh+Zh6iwPK82Hcyn60A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPkOAVSR0WPYbt7vkq4YJeDZfk5qaD8m5q9QaL1OyB2iwbbuvXq6tZtof3oZId9PTovpLGuKWwMgHVu2d3ppw4PiX4zW8+dtwJLGFF5dffqLexLfTQKzr/wlKBMiLMEWbzmwct1ev2TqRd+d/osnVHUU+Nk4ausftoEbonVFhcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=laf8a0QP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763551242; x=1795087242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8GYEEcFXxf1XWxFmK+/08Fz7rh+Zh6iwPK82Hcyn60A=;
  b=laf8a0QPIJPZw2cQkq0W+cYbo9YDF1OxxkTszUv6VG57M/dB/aPRRasg
   eb9fXpux2OeXCoIMivTvticT4a/WufD6A1X9vbxsLM78+udsOUv/VmZTf
   b8iLF8Q/ePCLihdbN5uY8ATw3e8yKgtDkezvqOMFtEfNFsWqON1eJSLft
   ag+3JaBURFysH7ntRSea680liq7TnllW6bzFdTGeV8hOUzZa9DzLVEQO5
   TuXYWXNza3tCDfkJ5GCceYm83JBh8jdeCgYS0WWGkYTlHx+VpUX4LHjYy
   kjKmbMQNSzAj+Ykr2t8/jgvfTcXXdLJxu4vUx07iI+mzI9gbV8rXNcpJ3
   Q==;
X-CSE-ConnectionGUID: derv1FmtTYmpnHHmAtkJaQ==
X-CSE-MsgGUID: OqZY9ruzRkmjbbJG6sgXYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="75913615"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="75913615"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 03:20:42 -0800
X-CSE-ConnectionGUID: K+iQptuBRX2UI2ytmN5h9A==
X-CSE-MsgGUID: 2P7RqcVvTK+TZCsDKz012Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="221658079"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 19 Nov 2025 03:20:38 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLgEl-0002oD-1S;
	Wed, 19 Nov 2025 11:20:35 +0000
Date: Wed, 19 Nov 2025 19:19:59 +0800
From: kernel test robot <lkp@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs
 with xpcs-plat driver
Message-ID: <202511191835.rwfD48SW-lkp@intel.com>
References: <20251118190530.580267-15-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118190530.580267-15-vladimir.oltean@nxp.com>

Hi Vladimir,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vladimir-Oltean/net-dsa-sja1105-let-phylink-help-with-the-replay-of-link-callbacks/20251119-031300
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251118190530.580267-15-vladimir.oltean%40nxp.com
patch subject: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs with xpcs-plat driver
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20251119/202511191835.rwfD48SW-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251119/202511191835.rwfD48SW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511191835.rwfD48SW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/dsa/sja1105/sja1105_mfd.c: In function 'sja1105_create_pcs_nodes':
>> drivers/net/dsa/sja1105/sja1105_mfd.c:145:73: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
     145 |                 snprintf(node_name, sizeof(node_name), "ethernet-pcs@%llx",
         |                                                                      ~~~^
         |                                                                         |
         |                                                                         long long unsigned int
         |                                                                      %x
     146 |                          pcs_res->res.start);
         |                          ~~~~~~~~~~~~~~~~~~                              
         |                                      |
         |                                      resource_size_t {aka unsigned int}


vim +145 drivers/net/dsa/sja1105/sja1105_mfd.c

   124	
   125	static int sja1105_create_pcs_nodes(struct sja1105_private *priv,
   126					    struct device_node *regs_node)
   127	{
   128		struct dsa_switch *ds = priv->ds;
   129		struct device *dev = ds->dev;
   130		struct device_node *pcs_node;
   131		const u32 reg_io_width = 4;
   132		char node_name[32];
   133		u32 reg_props[2];
   134		int rc;
   135	
   136		for (int i = 0; i < priv->info->num_pcs_resources; i++) {
   137			const struct sja1105_pcs_resource *pcs_res;
   138	
   139			pcs_res = &priv->info->pcs_resources[i];
   140	
   141			if (sja1105_child_node_exists(regs_node, "ethernet-pcs",
   142						      &pcs_res->res))
   143				continue;
   144	
 > 145			snprintf(node_name, sizeof(node_name), "ethernet-pcs@%llx",
   146				 pcs_res->res.start);
   147	
   148			pcs_node = of_changeset_create_node(&priv->of_cs, regs_node,
   149							    node_name);
   150			if (!pcs_node) {
   151				dev_err(dev, "Failed to create PCS node %s\n", node_name);
   152				return -ENOMEM;
   153			}
   154	
   155			rc = of_changeset_add_prop_string(&priv->of_cs, pcs_node,
   156							  "compatible",
   157							  pcs_res->compatible);
   158			if (rc) {
   159				dev_err(dev, "Failed to add compatible property to %s: %pe\n",
   160					node_name, ERR_PTR(rc));
   161				return rc;
   162			}
   163	
   164			reg_props[0] = pcs_res->res.start;
   165			reg_props[1] = resource_size(&pcs_res->res);
   166			rc = of_changeset_add_prop_u32_array(&priv->of_cs, pcs_node,
   167							     "reg", reg_props, 2);
   168			if (rc) {
   169				dev_err(dev, "Failed to add reg property to %s: %pe\n",
   170					node_name, ERR_PTR(rc));
   171				return rc;
   172			}
   173	
   174			rc = of_changeset_add_prop_string(&priv->of_cs, pcs_node,
   175							  "reg-names",
   176							  pcs_res->res.name);
   177			if (rc) {
   178				dev_err(dev, "Failed to add reg-names property to %s: %pe\n",
   179					node_name, ERR_PTR(rc));
   180				return rc;
   181			}
   182	
   183			rc = of_changeset_add_prop_u32_array(&priv->of_cs, pcs_node,
   184							     "reg-io-width",
   185							     &reg_io_width, 1);
   186			if (rc) {
   187				dev_err(dev, "Failed to add reg-io-width property to %s: %pe\n",
   188					node_name, ERR_PTR(rc));
   189				return rc;
   190			}
   191	
   192			dev_dbg(dev, "Created OF node %pOF\n", pcs_node);
   193			priv->pcs_fwnode[pcs_res->port] = of_fwnode_handle(pcs_node);
   194		}
   195	
   196		return 0;
   197	}
   198	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

