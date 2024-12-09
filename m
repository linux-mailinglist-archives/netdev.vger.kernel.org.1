Return-Path: <netdev+bounces-150027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF0E9E8A69
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 05:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747401885815
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 04:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423CE1865EF;
	Mon,  9 Dec 2024 04:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="an8LRK/i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89F016F288;
	Mon,  9 Dec 2024 04:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733719172; cv=none; b=bTJmPCJd+BDQoWhjD8USBqQe3iTk6gZ+p4YTAmw2/Ei7qojm1GHkJ8qlcdtfHk6KFZfpSM3kS/+2Ki06Gw8hi8u3xQs16HgeEKHcAJBuBJabUaYHnX0gbdDPb0+PukmtJ4jQ6pWz6lq6fd6UpCKTfJ2plkwzzHTTpPUt316L7iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733719172; c=relaxed/simple;
	bh=WxSdxf8pLdMWv4fY9QRvr5Gkcta72PxtTHjRQUY08Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8q89SRW2X59awZoD+ooZ5FymURMP4q+IZH3B6UqbynEtywjhxCC3phsTz9UGf7PhZH+GWFtAuKAcAdVZzRU26RFKlpwsF87PUO68tK42AQNlc3QzCTVEnvheCuyRKM7bYy2aTxrTgVJ9q66F3UWnYjhqayz3PoZBXa31YCy6+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=an8LRK/i; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733719170; x=1765255170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WxSdxf8pLdMWv4fY9QRvr5Gkcta72PxtTHjRQUY08Xo=;
  b=an8LRK/iqXLKY3LEE4fpykmNY7gyqaxwnSaHbLsoiQsUrX/Jl0MtINS/
   u/qPn43HaqriwOL7ytrjvZPJEiOJlEvv9zWyu4ERbVnyaDRmPQneZn5Um
   pQW0N2a34t/AwrL1k8SfRcVd/T8XhPNfVhSws9uNGEX6JWyNXLTkyvOJj
   1cDr+Hx4erp8ks7pQvdjCY0rnweq5i1PtFTlv5vlTrCRJGLL/ELMH22Lc
   TBOFD9uhn5yXSCDlbNDWtwR+/7MUKHFKFgwJujQ5kAFLodKz3KuChztQX
   FYA8O0kPEOXV8hE+/EmVRMGlQgKLOc773HWvg07ANuQtetRkqz8FMy8OR
   g==;
X-CSE-ConnectionGUID: KukZGVlLTfaXBPq8kGzO4g==
X-CSE-MsgGUID: iR2XJtAqRrm5s6daWtYL3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="37931447"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="37931447"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:39:29 -0800
X-CSE-ConnectionGUID: eBVdfRJ/Qwq0407wVB29Vg==
X-CSE-MsgGUID: wjhdMOM7T+Ctp8wtjgcWgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="95751895"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 08 Dec 2024 20:39:24 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVYH-0003tF-0M;
	Mon, 09 Dec 2024 04:39:21 +0000
Date: Mon, 9 Dec 2024 12:38:51 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@airoha.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v10 8/9] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <202412081038.lJvmpuB2-lkp@intel.com>
References: <20241208002105.18074-9-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208002105.18074-9-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-nvmem-Document-support-for-Airoha-AN8855-Switch-EFUSE/20241208-082533
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241208002105.18074-9-ansuelsmth%40gmail.com
patch subject: [net-next PATCH v10 8/9] net: dsa: Add Airoha AN8855 5-Port Gigabit DSA Switch driver
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20241208/202412081038.lJvmpuB2-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241208/202412081038.lJvmpuB2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412081038.lJvmpuB2-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/dsa/an8855.c: In function 'an8855_switch_probe':
>> drivers/net/dsa/an8855.c:2227:34: error: invalid use of undefined type 'struct platform_device'
    2227 |         priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
         |                                  ^~
   drivers/net/dsa/an8855.c:2231:26: error: invalid use of undefined type 'struct platform_device'
    2231 |         priv->dev = &pdev->dev;
         |                          ^~
   drivers/net/dsa/an8855.c: In function 'an8855_switch_remove':
   drivers/net/dsa/an8855.c:2282:57: error: invalid use of undefined type 'struct platform_device'
    2282 |         struct an8855_priv *priv = dev_get_drvdata(&pdev->dev);
         |                                                         ^~
   drivers/net/dsa/an8855.c: At top level:
>> drivers/net/dsa/an8855.c:2295:15: error: variable 'an8855_switch_driver' has initializer but incomplete type
    2295 | static struct platform_driver an8855_switch_driver = {
         |               ^~~~~~~~~~~~~~~
>> drivers/net/dsa/an8855.c:2296:10: error: 'struct platform_driver' has no member named 'probe'
    2296 |         .probe = an8855_switch_probe,
         |          ^~~~~
>> drivers/net/dsa/an8855.c:2296:18: warning: excess elements in struct initializer
    2296 |         .probe = an8855_switch_probe,
         |                  ^~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/an8855.c:2296:18: note: (near initialization for 'an8855_switch_driver')
>> drivers/net/dsa/an8855.c:2297:10: error: 'struct platform_driver' has no member named 'remove'
    2297 |         .remove = an8855_switch_remove,
         |          ^~~~~~
   drivers/net/dsa/an8855.c:2297:19: warning: excess elements in struct initializer
    2297 |         .remove = an8855_switch_remove,
         |                   ^~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/an8855.c:2297:19: note: (near initialization for 'an8855_switch_driver')
>> drivers/net/dsa/an8855.c:2298:10: error: 'struct platform_driver' has no member named 'driver'
    2298 |         .driver = {
         |          ^~~~~~
>> drivers/net/dsa/an8855.c:2298:19: error: extra brace group at end of initializer
    2298 |         .driver = {
         |                   ^
   drivers/net/dsa/an8855.c:2298:19: note: (near initialization for 'an8855_switch_driver')
   drivers/net/dsa/an8855.c:2298:19: warning: excess elements in struct initializer
   drivers/net/dsa/an8855.c:2298:19: note: (near initialization for 'an8855_switch_driver')
>> drivers/net/dsa/an8855.c:2303:1: warning: data definition has no type or storage class
    2303 | module_platform_driver(an8855_switch_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/dsa/an8855.c:2303:1: error: type defaults to 'int' in declaration of 'module_platform_driver' [-Wimplicit-int]
>> drivers/net/dsa/an8855.c:2303:1: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
>> drivers/net/dsa/an8855.c:2295:31: error: storage size of 'an8855_switch_driver' isn't known
    2295 | static struct platform_driver an8855_switch_driver = {
         |                               ^~~~~~~~~~~~~~~~~~~~
>> drivers/net/dsa/an8855.c:2295:31: warning: 'an8855_switch_driver' defined but not used [-Wunused-variable]


vim +2227 drivers/net/dsa/an8855.c

  2220	
  2221	static int an8855_switch_probe(struct platform_device *pdev)
  2222	{
  2223		struct an8855_priv *priv;
  2224		u32 val;
  2225		int ret;
  2226	
> 2227		priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
  2228		if (!priv)
  2229			return -ENOMEM;
  2230	
> 2231		priv->dev = &pdev->dev;
  2232		priv->phy_require_calib = of_property_read_bool(priv->dev->of_node,
  2233								"airoha,ext-surge");
  2234	
  2235		priv->reset_gpio = devm_gpiod_get_optional(priv->dev, "reset",
  2236							   GPIOD_OUT_LOW);
  2237		if (IS_ERR(priv->reset_gpio))
  2238			return PTR_ERR(priv->reset_gpio);
  2239	
  2240		/* Get regmap from MFD */
  2241		priv->regmap = dev_get_regmap(priv->dev->parent, NULL);
  2242	
  2243		if (priv->reset_gpio) {
  2244			usleep_range(100000, 150000);
  2245			gpiod_set_value_cansleep(priv->reset_gpio, 0);
  2246			usleep_range(100000, 150000);
  2247			gpiod_set_value_cansleep(priv->reset_gpio, 1);
  2248	
  2249			/* Poll HWTRAP reg to wait for Switch to fully Init */
  2250			ret = regmap_read_poll_timeout(priv->regmap, AN8855_HWTRAP, val,
  2251						       val, 20, 200000);
  2252			if (ret)
  2253				return ret;
  2254		}
  2255	
  2256		ret = an8855_read_switch_id(priv);
  2257		if (ret)
  2258			return ret;
  2259	
  2260		priv->ds = devm_kzalloc(priv->dev, sizeof(*priv->ds), GFP_KERNEL);
  2261		if (!priv->ds)
  2262			return -ENOMEM;
  2263	
  2264		priv->ds->dev = priv->dev;
  2265		priv->ds->num_ports = AN8855_NUM_PORTS;
  2266		priv->ds->priv = priv;
  2267		priv->ds->ops = &an8855_switch_ops;
  2268		devm_mutex_init(priv->dev, &priv->reg_mutex);
  2269		priv->ds->phylink_mac_ops = &an8855_phylink_mac_ops;
  2270	
  2271		priv->pcs.ops = &an8855_pcs_ops;
  2272		priv->pcs.neg_mode = true;
  2273		priv->pcs.poll = true;
  2274	
  2275		dev_set_drvdata(priv->dev, priv);
  2276	
  2277		return dsa_register_switch(priv->ds);
  2278	}
  2279	
  2280	static void an8855_switch_remove(struct platform_device *pdev)
  2281	{
> 2282		struct an8855_priv *priv = dev_get_drvdata(&pdev->dev);
  2283	
  2284		if (!priv)
  2285			return;
  2286	
  2287		dsa_unregister_switch(priv->ds);
  2288	}
  2289	
  2290	static const struct of_device_id an8855_switch_of_match[] = {
  2291		{ .compatible = "airoha,an8855-switch" },
  2292		{ /* sentinel */ }
  2293	};
  2294	
> 2295	static struct platform_driver an8855_switch_driver = {
> 2296		.probe = an8855_switch_probe,
> 2297		.remove = an8855_switch_remove,
> 2298		.driver = {
  2299			.name = "an8855-switch",
  2300			.of_match_table = an8855_switch_of_match,
  2301		},
  2302	};
> 2303	module_platform_driver(an8855_switch_driver);
  2304	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

