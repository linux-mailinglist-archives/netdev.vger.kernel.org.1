Return-Path: <netdev+bounces-54169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DA88062A6
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 00:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1235E2820FF
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 23:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6AC405E6;
	Tue,  5 Dec 2023 23:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYV/ofEn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD189196;
	Tue,  5 Dec 2023 15:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701817443; x=1733353443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I+bwbwFyENG7yFV0azLeO6IAGA9bVpvHuBPiiW8IsjQ=;
  b=SYV/ofEnJC/JLuGm5MIV8hUrcrt1l+AkEeCUXahtiDClYHDOaABIan6A
   +Gz/cxUVKX59x8Lyb7RF8TwpWskKI4pNQCWPneb2jtJ9OOI6daD6T8i5l
   vRIHehXIawoV+6I4Knc0EBofkzfnjqpT3JxkC+7dkVEoe8PvSg1S7nqRa
   /a58N0mjcQhYaqDLaCPEO/odwQN++tMRlRLQuYs7ru/GVsj4Ft8HwZU3v
   1eCOk1oYBG9o6HsA+pjrZckTWFJtwJPDXA71ROd6FRxk9REUEGSrbMiqF
   30j3OAYgv6TU2FZxzB4t5/ywH5RQOlnGTw5lwMChKMRQBuxmkkOkPW0y7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="393705738"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="393705738"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 15:04:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="19127791"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 05 Dec 2023 15:03:57 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAeSI-0009q0-2B;
	Tue, 05 Dec 2023 23:03:54 +0000
Date: Wed, 6 Dec 2023 07:03:46 +0800
From: kernel test robot <lkp@intel.com>
To: Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Serge Semin <fancer.lancer@gmail.com>, openbmc@lists.ozlabs.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 11/16] net: pcs: xpcs: Change
 xpcs_create_mdiodev() suffix to "byaddr"
Message-ID: <202312060634.Cblfigt2-lkp@intel.com>
References: <20231205103559.9605-12-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205103559.9605-12-fancer.lancer@gmail.com>

Hi Serge,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/net-pcs-xpcs-Drop-sentinel-entry-from-2500basex-ifaces-list/20231205-183808
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231205103559.9605-12-fancer.lancer%40gmail.com
patch subject: [PATCH net-next 11/16] net: pcs: xpcs: Change xpcs_create_mdiodev() suffix to "byaddr"
config: arc-randconfig-001-20231206 (https://download.01.org/0day-ci/archive/20231206/202312060634.Cblfigt2-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312060634.Cblfigt2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060634.Cblfigt2-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c: In function 'txgbe_mdio_pcs_init':
>> drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c:150:16: error: implicit declaration of function 'xpcs_create_mdiodev'; did you mean 'xpcs_create_byaddr'? [-Werror=implicit-function-declaration]
     150 |         xpcs = xpcs_create_mdiodev(mii_bus, 0, PHY_INTERFACE_MODE_10GBASER);
         |                ^~~~~~~~~~~~~~~~~~~
         |                xpcs_create_byaddr
>> drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c:150:14: warning: assignment to 'struct dw_xpcs *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     150 |         xpcs = xpcs_create_mdiodev(mii_bus, 0, PHY_INTERFACE_MODE_10GBASER);
         |              ^
   cc1: some warnings being treated as errors


vim +150 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c

854cace61387b6 Jiawen Wu      2023-06-06  121  
854cace61387b6 Jiawen Wu      2023-06-06  122  static int txgbe_mdio_pcs_init(struct txgbe *txgbe)
854cace61387b6 Jiawen Wu      2023-06-06  123  {
854cace61387b6 Jiawen Wu      2023-06-06  124  	struct mii_bus *mii_bus;
854cace61387b6 Jiawen Wu      2023-06-06  125  	struct dw_xpcs *xpcs;
854cace61387b6 Jiawen Wu      2023-06-06  126  	struct pci_dev *pdev;
854cace61387b6 Jiawen Wu      2023-06-06  127  	struct wx *wx;
854cace61387b6 Jiawen Wu      2023-06-06  128  	int ret = 0;
854cace61387b6 Jiawen Wu      2023-06-06  129  
854cace61387b6 Jiawen Wu      2023-06-06  130  	wx = txgbe->wx;
854cace61387b6 Jiawen Wu      2023-06-06  131  	pdev = wx->pdev;
854cace61387b6 Jiawen Wu      2023-06-06  132  
854cace61387b6 Jiawen Wu      2023-06-06  133  	mii_bus = devm_mdiobus_alloc(&pdev->dev);
854cace61387b6 Jiawen Wu      2023-06-06  134  	if (!mii_bus)
854cace61387b6 Jiawen Wu      2023-06-06  135  		return -ENOMEM;
854cace61387b6 Jiawen Wu      2023-06-06  136  
854cace61387b6 Jiawen Wu      2023-06-06  137  	mii_bus->name = "txgbe_pcs_mdio_bus";
854cace61387b6 Jiawen Wu      2023-06-06  138  	mii_bus->read_c45 = &txgbe_pcs_read;
854cace61387b6 Jiawen Wu      2023-06-06  139  	mii_bus->write_c45 = &txgbe_pcs_write;
854cace61387b6 Jiawen Wu      2023-06-06  140  	mii_bus->parent = &pdev->dev;
854cace61387b6 Jiawen Wu      2023-06-06  141  	mii_bus->phy_mask = ~0;
854cace61387b6 Jiawen Wu      2023-06-06  142  	mii_bus->priv = wx;
854cace61387b6 Jiawen Wu      2023-06-06  143  	snprintf(mii_bus->id, MII_BUS_ID_SIZE, "txgbe_pcs-%x",
d8c21ef7b2b147 Xiongfeng Wang 2023-08-08  144  		 pci_dev_id(pdev));
854cace61387b6 Jiawen Wu      2023-06-06  145  
854cace61387b6 Jiawen Wu      2023-06-06  146  	ret = devm_mdiobus_register(&pdev->dev, mii_bus);
854cace61387b6 Jiawen Wu      2023-06-06  147  	if (ret)
854cace61387b6 Jiawen Wu      2023-06-06  148  		return ret;
854cace61387b6 Jiawen Wu      2023-06-06  149  
854cace61387b6 Jiawen Wu      2023-06-06 @150  	xpcs = xpcs_create_mdiodev(mii_bus, 0, PHY_INTERFACE_MODE_10GBASER);
854cace61387b6 Jiawen Wu      2023-06-06  151  	if (IS_ERR(xpcs))
854cace61387b6 Jiawen Wu      2023-06-06  152  		return PTR_ERR(xpcs);
854cace61387b6 Jiawen Wu      2023-06-06  153  
854cace61387b6 Jiawen Wu      2023-06-06  154  	txgbe->xpcs = xpcs;
854cace61387b6 Jiawen Wu      2023-06-06  155  
854cace61387b6 Jiawen Wu      2023-06-06  156  	return 0;
854cace61387b6 Jiawen Wu      2023-06-06  157  }
854cace61387b6 Jiawen Wu      2023-06-06  158  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

