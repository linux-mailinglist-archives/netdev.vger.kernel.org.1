Return-Path: <netdev+bounces-150028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 541349E8A70
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 05:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43F70163E3F
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 04:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0526189BA8;
	Mon,  9 Dec 2024 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLr6rIEq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215D176AC7;
	Mon,  9 Dec 2024 04:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733719231; cv=none; b=lO7Bh6iUHLUZotIxLvmZZsHS0nVMp58TTVHXTXTkfsC2WhYKzZqG46Am2tCUyN6cz2bqXoKRn4ETXJbiWs61ctWmXhsyFCHKN19HxilTtQO6HgW7RQw1kQwFmuAYR4jwtqFRGaFBUoWKn3NF1w5BL42RRm9fWnPfylSr4vhHcmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733719231; c=relaxed/simple;
	bh=d5TxygKeLQVwmWX4ir2xJcbJDNYcHfp00n5X8scHlYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4Rsn2GYfccE+FLUokhvUYNgjtvlRthXuPJcKpFAY4TiaxBI21AJymuOQUaB75qdOy1CqxxRCv11DxY3gNfUV9BpaPhbheBzE7mywGZ3QIdFeY65FSqtf4k9EGyzkv6YIN6OXqmq/Ezus0OQOJ9djItXu57qTAHtPE84t9MT4qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLr6rIEq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733719230; x=1765255230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d5TxygKeLQVwmWX4ir2xJcbJDNYcHfp00n5X8scHlYc=;
  b=GLr6rIEqSpwdBdymfginj1hc0r5TWO/WmJiN4aX17wm7K1dYEeDnoKGT
   uPGRSQKL+f6PdEysHrxk6ggW2fc4+/J6vfsgZSOtCgTQ5pfv+zV8iMM/k
   rPMFS8S9pyTKpW03CBZ073YT5+1bnuTStvaHp5hxrGBi0z6qRUwh87ZrT
   c/H8y2gxMkfP3YSCjPmTbRT+8rjc48MJtGV7AeoUBbHjKGOVm1dvBIvuh
   Rmc5XctbyYd645yypw2EfI5Tt/J3H+jFEG+0QHNY8AP/4FRtbN6VS9/uT
   PZ0HVsnAaqqsFmtiilbd5IBi3VBPzSa9U6LE4xDiFTE4zRzayJr1+is7f
   Q==;
X-CSE-ConnectionGUID: LCaBT4XjQiWPZuhykaMqdA==
X-CSE-MsgGUID: DDKICtyYQ2SX+/wfidqLLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="37931530"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="37931530"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:40:29 -0800
X-CSE-ConnectionGUID: kHGDx7C3SYmhQCzLMVuOcA==
X-CSE-MsgGUID: lYg68KfIQSi40c+WU75O+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="94827028"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Dec 2024 20:40:24 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVZF-0003tR-1S;
	Mon, 09 Dec 2024 04:40:21 +0000
Date: Mon, 9 Dec 2024 12:39:54 +0800
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
Subject: Re: [net-next PATCH v10 9/9] net: phy: Add Airoha AN8855 Internal
 Switch Gigabit PHY
Message-ID: <202412081155.xp97LlzV-lkp@intel.com>
References: <20241208002105.18074-10-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208002105.18074-10-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-nvmem-Document-support-for-Airoha-AN8855-Switch-EFUSE/20241208-082533
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241208002105.18074-10-ansuelsmth%40gmail.com
patch subject: [net-next PATCH v10 9/9] net: phy: Add Airoha AN8855 Internal Switch Gigabit PHY
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20241208/202412081155.xp97LlzV-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241208/202412081155.xp97LlzV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412081155.xp97LlzV-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/phy/air_an8855.c: In function 'an8855_probe':
>> drivers/net/phy/air_an8855.c:100:13: warning: unused variable 'ret' [-Wunused-variable]
     100 |         int ret;
         |             ^~~
   drivers/net/phy/air_an8855.c: In function 'an8855_config_init':
>> drivers/net/phy/air_an8855.c:154:45: error: 'dev' undeclared (first use in this function); did you mean 'cdev'?
     154 |                 ret = en8855_get_r50ohm_val(dev, "tx_a", &calibration_data[0]);
         |                                             ^~~
         |                                             cdev
   drivers/net/phy/air_an8855.c:154:45: note: each undeclared identifier is reported only once for each function it appears in


vim +154 drivers/net/phy/air_an8855.c

    94	
    95	static int an8855_probe(struct phy_device *phydev)
    96	{
    97		struct device *dev = &phydev->mdio.dev;
    98		struct device_node *node = dev->of_node;
    99		struct air_an8855_priv *priv;
 > 100		int ret;
   101	
   102		/* If we don't have a node, skip calib */
   103		if (!node)
   104			return 0;
   105	
   106		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
   107		if (!priv)
   108			return -ENOMEM;
   109	
   110		phydev->priv = priv;
   111	
   112		return 0;
   113	}
   114	
   115	static int an8855_get_downshift(struct phy_device *phydev, u8 *data)
   116	{
   117		int val;
   118	
   119		val = phy_read_paged(phydev, AN8855_PHY_PAGE_EXTENDED_1, AN8855_PHY_EXT_REG_14);
   120		if (val < 0)
   121			return val;
   122	
   123		*data = val & AN8855_PHY_EN_DOWN_SHIFT ? DOWNSHIFT_DEV_DEFAULT_COUNT :
   124							 DOWNSHIFT_DEV_DISABLE;
   125	
   126		return 0;
   127	}
   128	
   129	static int an8855_set_downshift(struct phy_device *phydev, u8 cnt)
   130	{
   131		u16 ds = cnt != DOWNSHIFT_DEV_DISABLE ? AN8855_PHY_EN_DOWN_SHIFT : 0;
   132	
   133		return phy_modify_paged(phydev, AN8855_PHY_PAGE_EXTENDED_1,
   134					AN8855_PHY_EXT_REG_14, AN8855_PHY_EN_DOWN_SHIFT,
   135					ds);
   136	}
   137	
   138	static int an8855_config_init(struct phy_device *phydev)
   139	{
   140		struct air_an8855_priv *priv = phydev->priv;
   141		int ret;
   142	
   143		/* Enable HW auto downshift */
   144		ret = an8855_set_downshift(phydev, DOWNSHIFT_DEV_DEFAULT_COUNT);
   145		if (ret)
   146			return ret;
   147	
   148		/* Apply calibration values, if needed.
   149		 * AN8855_PHY_FLAGS_EN_CALIBRATION signal this.
   150		 */
   151		if (priv && phydev->dev_flags & AN8855_PHY_FLAGS_EN_CALIBRATION) {
   152			u8 *calibration_data = priv->calibration_data;
   153	
 > 154			ret = en8855_get_r50ohm_val(dev, "tx_a", &calibration_data[0]);
   155			if (ret)
   156				return ret;
   157	
   158			ret = en8855_get_r50ohm_val(dev, "tx_b", &calibration_data[1]);
   159			if (ret)
   160				return ret;
   161	
   162			ret = en8855_get_r50ohm_val(dev, "tx_c", &calibration_data[2]);
   163			if (ret)
   164				return ret;
   165	
   166			ret = en8855_get_r50ohm_val(dev, "tx_d", &calibration_data[3]);
   167			if (ret)
   168				return ret;
   169	
   170			ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_R500HM_RSEL_TX_AB,
   171					     AN8855_PHY_R50OHM_RSEL_TX_A | AN8855_PHY_R50OHM_RSEL_TX_B,
   172					     FIELD_PREP(AN8855_PHY_R50OHM_RSEL_TX_A, calibration_data[0]) |
   173					     FIELD_PREP(AN8855_PHY_R50OHM_RSEL_TX_B, calibration_data[1]));
   174			if (ret)
   175				return ret;
   176			ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_R500HM_RSEL_TX_CD,
   177					     AN8855_PHY_R50OHM_RSEL_TX_C | AN8855_PHY_R50OHM_RSEL_TX_D,
   178					     FIELD_PREP(AN8855_PHY_R50OHM_RSEL_TX_C, calibration_data[2]) |
   179					     FIELD_PREP(AN8855_PHY_R50OHM_RSEL_TX_D, calibration_data[3]));
   180			if (ret)
   181				return ret;
   182		}
   183	
   184		/* Apply values to reduce signal noise */
   185		ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_TX_PAIR_DLY_SEL_GBE,
   186				    FIELD_PREP(AN8855_PHY_CR_DA_TX_PAIR_DELKAY_SEL_A_GBE, 0x4) |
   187				    FIELD_PREP(AN8855_PHY_CR_DA_TX_PAIR_DELKAY_SEL_C_GBE, 0x4));
   188		if (ret)
   189			return ret;
   190		ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_RXADC_CTRL,
   191				    AN8855_PHY_RG_AD_SAMNPLE_PHSEL_A |
   192				    AN8855_PHY_RG_AD_SAMNPLE_PHSEL_C);
   193		if (ret)
   194			return ret;
   195		ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_RXADC_REV_0,
   196				    FIELD_PREP(AN8855_PHY_RG_AD_RESERVE0_A, 0x1));
   197		if (ret)
   198			return ret;
   199		ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_RXADC_REV_1,
   200				    FIELD_PREP(AN8855_PHY_RG_AD_RESERVE0_C, 0x1));
   201		if (ret)
   202			return ret;
   203	
   204		return 0;
   205	}
   206	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

