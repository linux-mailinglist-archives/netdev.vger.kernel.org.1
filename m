Return-Path: <netdev+bounces-235357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CB6C2F1C6
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 04:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A5D84F7FAA
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 03:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0466726FDA9;
	Tue,  4 Nov 2025 03:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CrUlzhX/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356E726CE1E;
	Tue,  4 Nov 2025 03:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762225859; cv=none; b=oJ28KoVMx2asUEytzLD0tkbWA7BBZyx44v1nEozFVswXZz/hqaqiX8x5gvTbnyNmFEJLwkQ47RoPUKpuEqGOoxjZQYcDWxM4KGKuf6AF1A+bAYbbiYpwkVawfffOLqmdk+28CkTXltPQC9tMwRWx+d4pxhCFZ1AH2ErP+tqbD8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762225859; c=relaxed/simple;
	bh=nasp7obvVZx/zW5fYzUXJMKnK906v8ptyaXO0ca9Boo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/8Ds2IZkpeW355e4RnL3nU3z32zpsJe2vmEDsfbrdCG3yildwiJPoKEq+6SoaLmNxXow5g87Q/xq561x/hPC6xbkfYl4OpgBPVPlHyHtSJdsZ9k8DAvnOrpA7sT43utJEb9TsxIKHCZI/CN71WbLqHqWxBrjLHVT1/a06orJ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CrUlzhX/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762225858; x=1793761858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nasp7obvVZx/zW5fYzUXJMKnK906v8ptyaXO0ca9Boo=;
  b=CrUlzhX/GuJIaQrf2CTe2mhhhOd7ZY7YSf+6yv3FbWOjaUhNhpppJiKa
   g4T6a9PnFg1zB3y9iqWgYOSbWpO9gP4NSQ+/D6J/VPIdhNzEjeluCEmFp
   sN5RHVHk4VwAW0OdNX+NBjjCGqaF+c+mFWm0XaWoIc+QbbrRykLPFlLo8
   K+eEzN62xnpgkI9r61tbEPJYiKMLaOhdlIlqK4T5iluRjXKPYXe++q5lv
   bBdBRsohCqSqb/4X9MiwdBqA0DqkES21iOByFhaYaoyhRf93n4Tre+fyc
   0foTjlrM8xxhnpMYw+7PER6hwb23/bMKMJP1SfWCkygl4uA1WHQWH9s5d
   g==;
X-CSE-ConnectionGUID: qKnCv5ZYR32SvkvHZUoXUw==
X-CSE-MsgGUID: yDL9LG48Tdy7PPp0HjEZlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="67967486"
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="67967486"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 19:10:57 -0800
X-CSE-ConnectionGUID: Klu5rGQySFOcoXjRl282jw==
X-CSE-MsgGUID: oH3aw8ubRJiFJiwtRMte1w==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 03 Nov 2025 19:10:53 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vG7RZ-000QnM-34;
	Tue, 04 Nov 2025 03:10:50 +0000
Date: Tue, 4 Nov 2025 11:07:35 +0800
From: kernel test robot <lkp@intel.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com,
	Jacky Chou <jacky_chou@aspeedtech.com>
Subject: Re: [PATCH net-next v3 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <202511041023.QGAHaAZ3-lkp@intel.com>
References: <20251103-rgmii_delay_2600-v3-4-e2af2656f7d7@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-rgmii_delay_2600-v3-4-e2af2656f7d7@aspeedtech.com>

Hi Jacky,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 01cc760632b875c4ad0d8fec0b0c01896b8a36d4]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacky-Chou/dt-bindings-net-ftgmac100-Add-delay-properties-for-AST2600/20251103-154258
base:   01cc760632b875c4ad0d8fec0b0c01896b8a36d4
patch link:    https://lore.kernel.org/r/20251103-rgmii_delay_2600-v3-4-e2af2656f7d7%40aspeedtech.com
patch subject: [PATCH net-next v3 4/4] net: ftgmac100: Add RGMII delay support for AST2600
config: arm-defconfig (https://download.01.org/0day-ci/archive/20251104/202511041023.QGAHaAZ3-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d2625a438020ad35330cda29c3def102c1687b1b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251104/202511041023.QGAHaAZ3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511041023.QGAHaAZ3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/faraday/ftgmac100.c:1865:13: warning: variable 'rgmii_delay_unit' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1865 |         } else if (of_device_is_compatible(np, "aspeed,ast2600-mac23")) {
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/faraday/ftgmac100.c:1870:53: note: uninitialized use occurs here
    1870 |         rgmii_tx_delay = DIV_ROUND_CLOSEST(rgmii_tx_delay, rgmii_delay_unit);
         |                                                            ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/faraday/ftgmac100.c:1865:9: note: remove the 'if' if its condition is always true
    1865 |         } else if (of_device_is_compatible(np, "aspeed,ast2600-mac23")) {
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/faraday/ftgmac100.c:1844:22: note: initialize the variable 'rgmii_delay_unit' to silence this warning
    1844 |         u32 rgmii_delay_unit;
         |                             ^
         |                              = 0
   1 warning generated.


vim +1865 drivers/net/ethernet/faraday/ftgmac100.c

  1838	
  1839	static int ftgmac100_set_ast2600_rgmii_delay(struct platform_device *pdev,
  1840						     u32 rgmii_tx_delay,
  1841						     u32 rgmii_rx_delay)
  1842	{
  1843		struct device_node *np = pdev->dev.of_node;
  1844		u32 rgmii_delay_unit;
  1845		struct regmap *scu;
  1846		int dly_mask;
  1847		int dly_reg;
  1848		int id;
  1849	
  1850		scu = syscon_regmap_lookup_by_phandle(np, "scu");
  1851		if (IS_ERR(scu)) {
  1852			dev_err(&pdev->dev, "failed to get scu");
  1853			return PTR_ERR(scu);
  1854		}
  1855	
  1856		id = of_alias_get_id(np, "ethernet");
  1857		if (id < 0 || id > 3) {
  1858			dev_err(&pdev->dev, "get wrong alise id %d\n", id);
  1859			return -EINVAL;
  1860		}
  1861	
  1862		if (of_device_is_compatible(np, "aspeed,ast2600-mac01")) {
  1863			dly_reg = AST2600_MAC01_CLK_DLY;
  1864			rgmii_delay_unit = AST2600_MAC01_CLK_DLY_UNIT;
> 1865		} else if (of_device_is_compatible(np, "aspeed,ast2600-mac23")) {
  1866			dly_reg = AST2600_MAC23_CLK_DLY;
  1867			rgmii_delay_unit = AST2600_MAC23_CLK_DLY_UNIT;
  1868		}
  1869	
  1870		rgmii_tx_delay = DIV_ROUND_CLOSEST(rgmii_tx_delay, rgmii_delay_unit);
  1871		if (rgmii_tx_delay >= 32) {
  1872			dev_err(&pdev->dev,
  1873				"The index %u of TX delay setting is out of range\n",
  1874				rgmii_tx_delay);
  1875			return -EINVAL;
  1876		}
  1877	
  1878		rgmii_rx_delay = DIV_ROUND_CLOSEST(rgmii_rx_delay, rgmii_delay_unit);
  1879		if (rgmii_rx_delay >= 32) {
  1880			dev_err(&pdev->dev,
  1881				"The index %u of RX delay setting is out of range\n",
  1882				rgmii_rx_delay);
  1883			return -EINVAL;
  1884		}
  1885	
  1886		/* Due to the hardware design reason, for MAC23 on AST2600, the zero
  1887		 * delay ns on RX is configured by setting value 0x1a.
  1888		 * List as below:
  1889		 * 0x1a -> 0   ns, 0x1b -> 0.25 ns, ... , 0x1f -> 1.25 ns,
  1890		 * 0x00 -> 1.5 ns, 0x01 -> 1.75 ns, ... , 0x19 -> 7.75 ns, 0x1a -> 0 ns
  1891		 */
  1892		if (of_device_is_compatible(np, "aspeed,ast2600-mac23"))
  1893			rgmii_rx_delay = (AST2600_MAC23_RX_DLY_0_NS + rgmii_rx_delay) &
  1894					 AST2600_MAC_TX_RX_DLY_MASK;
  1895	
  1896		if (id == 0 || id == 2) {
  1897			dly_mask = ASPEED_MAC0_2_TX_DLY | ASPEED_MAC0_2_RX_DLY;
  1898			rgmii_tx_delay = FIELD_PREP(ASPEED_MAC0_2_TX_DLY, rgmii_tx_delay);
  1899			rgmii_rx_delay = FIELD_PREP(ASPEED_MAC0_2_RX_DLY, rgmii_rx_delay);
  1900		} else {
  1901			dly_mask = ASPEED_MAC1_3_TX_DLY | ASPEED_MAC1_3_RX_DLY;
  1902			rgmii_tx_delay = FIELD_PREP(ASPEED_MAC1_3_TX_DLY, rgmii_tx_delay);
  1903			rgmii_rx_delay = FIELD_PREP(ASPEED_MAC1_3_RX_DLY, rgmii_rx_delay);
  1904		}
  1905	
  1906		regmap_update_bits(scu, dly_reg, dly_mask, rgmii_tx_delay | rgmii_rx_delay);
  1907	
  1908		return 0;
  1909	}
  1910	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

