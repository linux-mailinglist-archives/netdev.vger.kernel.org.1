Return-Path: <netdev+bounces-224966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC89B8C395
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 09:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3913189D655
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 07:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2586426B760;
	Sat, 20 Sep 2025 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7w9DKMY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDD922A7E6;
	Sat, 20 Sep 2025 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354937; cv=none; b=lZKaiURu3dbAvN/a4ySGR7kIE30NmX2gSfNNhn2cD8Sqect+r/C7/Y2tbpOCWeOhxbNgO6klLquwjz3mjLYjv6/64A+BaeI2kQM3lPAsuO9/3QF40qTPEWMWKGHD5X/eUtLROuVs/Pg8CH66wF38TBRVoghb7gov0cqJxC0hLiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354937; c=relaxed/simple;
	bh=DXZa405/D/WyTQ1AZVXEBfnFpyEuDlPKkMIzHok8tYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxwRNG+NTgyrCUfIrtdHOagak0firGZrWZ9XF7LvGWtpxQRuyX8SQgtd23DuQg4iL1yIwf4B29cyNSbTrsGPjt7YKJux5KruFHpC2We3giYlCFOgGoxdbHc/zpDLF0SKNFkapjiRIjtrWoioGiPjHK0jmj2bBLsX1hlw+iTuJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7w9DKMY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758354934; x=1789890934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DXZa405/D/WyTQ1AZVXEBfnFpyEuDlPKkMIzHok8tYk=;
  b=C7w9DKMYOv9X/mtOWbTfqO+QwMH0TV66WebLrxulgKze2rNhASu2g5hi
   gu62R85m4SyjWez9bIu48HTacPJ4PGiJrNGlzPm9PQgALTSG4AUkrE59I
   kY9upDkvzVCPKDGrlhK5fdTRIpc80MRbm6A/gbFImKS7crVbLj5q0OvVa
   akDnpwQJnZvUBpfbxK68iZj/1iONJQwGNbFIyk3F8mw8Dsy9GVbZv+hxP
   rqGbuLkRq0EOI8Wh0tcGZhby18CZoVq+5gMhKHFahOMWHy0CmxtCt7mnZ
   /1gJQwI2iEvr3y/UzDoFBc4lVVtba8A1PlCAkMBIW1pFo2vypJbSsrCNq
   g==;
X-CSE-ConnectionGUID: DYaNoEd2QJiBSqsU38SqJg==
X-CSE-MsgGUID: cCJ+OrziRbOfg4lRgmB80w==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60580799"
X-IronPort-AV: E=Sophos;i="6.18,280,1751266800"; 
   d="scan'208";a="60580799"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2025 00:55:33 -0700
X-CSE-ConnectionGUID: PVn1jTHFS/i175+SwCPBgg==
X-CSE-MsgGUID: zjEGM9A3Rbe03T3lBS/7zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,280,1751266800"; 
   d="scan'208";a="176073275"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 20 Sep 2025 00:55:29 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzsRK-000595-32;
	Sat, 20 Sep 2025 07:55:26 +0000
Date: Sat, 20 Sep 2025 15:55:09 +0800
From: kernel test robot <lkp@intel.com>
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 2/5] net: phy: introduce
 PHY_INTERFACE_MODE_REVSGMII
Message-ID: <202509201554.gyfdX3FT-lkp@intel.com>
References: <20250919094234.1491638-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919094234.1491638-3-mmyangfl@gmail.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Yang/dt-bindings-ethernet-phy-add-reverse-SGMII-phy-interface-type/20250919-174746
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250919094234.1491638-3-mmyangfl%40gmail.com
patch subject: [PATCH net-next v10 2/5] net: phy: introduce PHY_INTERFACE_MODE_REVSGMII
config: arc-randconfig-002-20250920 (https://download.01.org/0day-ci/archive/20250920/202509201554.gyfdX3FT-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509201554.gyfdX3FT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509201554.gyfdX3FT-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/phy/phy-core.c: In function 'phy_interface_num_ports':
>> drivers/net/phy/phy-core.c:113:2: warning: enumeration value 'PHY_INTERFACE_MODE_REVSGMII' not handled in switch [-Wswitch]
     113 |  switch (interface) {
         |  ^~~~~~
--
   drivers/net/phy/phylink.c: In function 'phylink_interface_max_speed':
>> drivers/net/phy/phylink.c:235:2: warning: enumeration value 'PHY_INTERFACE_MODE_REVSGMII' not handled in switch [-Wswitch]
     235 |  switch (interface) {
         |  ^~~~~~
   during RTL pass: mach
   drivers/net/phy/phylink.c: In function 'phylink_pcs_neg_mode':
   drivers/net/phy/phylink.c:1228:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9352
    1228 | }
         | ^
   Please submit a full bug report,
   with preprocessed source if appropriate.
   See <https://gcc.gnu.org/bugs/> for instructions.
--
   drivers/net/phy/phy_caps.c: In function 'phy_caps_from_interface':
>> drivers/net/phy/phy_caps.c:286:2: warning: enumeration value 'PHY_INTERFACE_MODE_REVSGMII' not handled in switch [-Wswitch]
     286 |  switch (interface) {
         |  ^~~~~~


vim +/PHY_INTERFACE_MODE_REVSGMII +113 drivers/net/phy/phy-core.c

0c3e10cb442328 Sean Anderson     2022-09-20  103  
c04ade27cb7b95 Maxime Chevallier 2022-08-17  104  /**
c04ade27cb7b95 Maxime Chevallier 2022-08-17  105   * phy_interface_num_ports - Return the number of links that can be carried by
c04ade27cb7b95 Maxime Chevallier 2022-08-17  106   *			     a given MAC-PHY physical link. Returns 0 if this is
c04ade27cb7b95 Maxime Chevallier 2022-08-17  107   *			     unknown, the number of links else.
c04ade27cb7b95 Maxime Chevallier 2022-08-17  108   *
c04ade27cb7b95 Maxime Chevallier 2022-08-17  109   * @interface: The interface mode we want to get the number of ports
c04ade27cb7b95 Maxime Chevallier 2022-08-17  110   */
c04ade27cb7b95 Maxime Chevallier 2022-08-17  111  int phy_interface_num_ports(phy_interface_t interface)
c04ade27cb7b95 Maxime Chevallier 2022-08-17  112  {
c04ade27cb7b95 Maxime Chevallier 2022-08-17 @113  	switch (interface) {
c04ade27cb7b95 Maxime Chevallier 2022-08-17  114  	case PHY_INTERFACE_MODE_NA:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  115  		return 0;
c04ade27cb7b95 Maxime Chevallier 2022-08-17  116  	case PHY_INTERFACE_MODE_INTERNAL:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  117  	case PHY_INTERFACE_MODE_MII:
67c0170566b55b Kamil Horák - 2N  2025-07-08  118  	case PHY_INTERFACE_MODE_MIILITE:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  119  	case PHY_INTERFACE_MODE_GMII:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  120  	case PHY_INTERFACE_MODE_TBI:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  121  	case PHY_INTERFACE_MODE_REVMII:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  122  	case PHY_INTERFACE_MODE_RMII:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  123  	case PHY_INTERFACE_MODE_REVRMII:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  124  	case PHY_INTERFACE_MODE_RGMII:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  125  	case PHY_INTERFACE_MODE_RGMII_ID:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  126  	case PHY_INTERFACE_MODE_RGMII_RXID:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  127  	case PHY_INTERFACE_MODE_RGMII_TXID:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  128  	case PHY_INTERFACE_MODE_RTBI:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  129  	case PHY_INTERFACE_MODE_XGMII:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  130  	case PHY_INTERFACE_MODE_XLGMII:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  131  	case PHY_INTERFACE_MODE_MOCA:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  132  	case PHY_INTERFACE_MODE_TRGMII:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  133  	case PHY_INTERFACE_MODE_USXGMII:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  134  	case PHY_INTERFACE_MODE_SGMII:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  135  	case PHY_INTERFACE_MODE_SMII:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  136  	case PHY_INTERFACE_MODE_1000BASEX:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  137  	case PHY_INTERFACE_MODE_2500BASEX:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  138  	case PHY_INTERFACE_MODE_5GBASER:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  139  	case PHY_INTERFACE_MODE_10GBASER:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  140  	case PHY_INTERFACE_MODE_25GBASER:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  141  	case PHY_INTERFACE_MODE_10GKR:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  142  	case PHY_INTERFACE_MODE_100BASEX:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  143  	case PHY_INTERFACE_MODE_RXAUI:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  144  	case PHY_INTERFACE_MODE_XAUI:
05ad5d4581c3c1 Sean Anderson     2022-09-02  145  	case PHY_INTERFACE_MODE_1000BASEKX:
bbb7d478d91ac4 Alexander Duyck   2025-06-18  146  	case PHY_INTERFACE_MODE_50GBASER:
bbb7d478d91ac4 Alexander Duyck   2025-06-18  147  	case PHY_INTERFACE_MODE_LAUI:
bbb7d478d91ac4 Alexander Duyck   2025-06-18  148  	case PHY_INTERFACE_MODE_100GBASEP:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  149  		return 1;
c04ade27cb7b95 Maxime Chevallier 2022-08-17  150  	case PHY_INTERFACE_MODE_QSGMII:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  151  	case PHY_INTERFACE_MODE_QUSGMII:
777b8afb817915 Vladimir Oltean   2024-06-15  152  	case PHY_INTERFACE_MODE_10G_QXGMII:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  153  		return 4;
83b5f0253b1ef3 Gabor Juhos       2023-08-11  154  	case PHY_INTERFACE_MODE_PSGMII:
83b5f0253b1ef3 Gabor Juhos       2023-08-11  155  		return 5;
c04ade27cb7b95 Maxime Chevallier 2022-08-17  156  	case PHY_INTERFACE_MODE_MAX:
c04ade27cb7b95 Maxime Chevallier 2022-08-17  157  		WARN_ONCE(1, "PHY_INTERFACE_MODE_MAX isn't a valid interface mode");
c04ade27cb7b95 Maxime Chevallier 2022-08-17  158  		return 0;
c04ade27cb7b95 Maxime Chevallier 2022-08-17  159  	}
c04ade27cb7b95 Maxime Chevallier 2022-08-17  160  	return 0;
c04ade27cb7b95 Maxime Chevallier 2022-08-17  161  }
c04ade27cb7b95 Maxime Chevallier 2022-08-17  162  EXPORT_SYMBOL_GPL(phy_interface_num_ports);
c04ade27cb7b95 Maxime Chevallier 2022-08-17  163  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

