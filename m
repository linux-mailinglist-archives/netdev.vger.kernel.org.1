Return-Path: <netdev+bounces-176673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73845A6B449
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 07:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 715E67A7FB8
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 06:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5631E9B2B;
	Fri, 21 Mar 2025 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jolmAg9z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41CF1E990E;
	Fri, 21 Mar 2025 06:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742537661; cv=none; b=gIsOhmiwFNnRgY4hUt6F6CtJJUnzAstu35A621q+MPle7cswf7fJT7lrUYnyMrrcs5W9PqGvxhsqWKpI9JQmxxguUEUUSrrmIwdz8GKk8LYxffK/lyRe/YIhgOKtaZBnig51nzCbMsLV9W3kvQ1Oz/CzshpCvJ6yKvtsPNBTUPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742537661; c=relaxed/simple;
	bh=HLEaxKvE4atjVNnvk1DK3mXeuEpJjws2WJUHQpfgQ/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfSI5G0FjA3BB+Z6G4lHYkcnXheF2yto9r8g6WBiWH6M2gspsCoA6dYmqhc2zTCeQuSDLn0nS00JQiXF+Qw4MydWpRPp4Wyi4qjNnXaW8NdGlpSYSK68BRNbGf+Z6kX4JgUtgTo9I08K2b4pUxHie9VZR19PC/dXqrZwslHCkHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jolmAg9z; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742537660; x=1774073660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HLEaxKvE4atjVNnvk1DK3mXeuEpJjws2WJUHQpfgQ/4=;
  b=jolmAg9zLK35TDZPfgcEQQk9q61W/wpZLSC/9oeXTJ1zKN/yQh85Ypo1
   dxB2zlfXYp1O+cIp8qZzJlpxBKW9VAuNp1Uzy6JwwDXkbb5fGXdzTpyMp
   si5DSN93XyyRtYjsdisyQklmqbGhegkKWxLTOraJetMQa3I5sV6MrgpU7
   9SYhCHJalETsnIdWPlbPsjE1GM9ogRB2VY5ftWxN8srvS9faR7BAOkJcC
   OSl0Z67EFz2RsA/vDiz8io3lt7cVCQi8OqvDFnwgIlZi7TmCWrhvKL1zL
   ddMqdsnqLpcVrW9lvdxk/y8toFlYFnvfYX4jj0BKzksEi5hs8rzql8iBO
   g==;
X-CSE-ConnectionGUID: W5LTp+AoR4Os9QUc9cBMnA==
X-CSE-MsgGUID: bQHpuk94QJWUjAxf9DllkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="54013377"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="54013377"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 23:14:17 -0700
X-CSE-ConnectionGUID: dm1rutLFR82EWWTmbhyLZA==
X-CSE-MsgGUID: Hhys1a/5RT+disyeTze/Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123331923"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 20 Mar 2025 23:14:11 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvVdt-00015Q-16;
	Fri, 21 Mar 2025 06:14:06 +0000
Date: Fri, 21 Mar 2025 14:12:55 +0800
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
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@airoha.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v13 10/14] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
Message-ID: <202503211428.H4VdWHco-lkp@intel.com>
References: <20250315154407.26304-11-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315154407.26304-11-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-nvmem-Document-support-for-Airoha-AN8855-Switch-EFUSE/20250315-235040
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250315154407.26304-11-ansuelsmth%40gmail.com
patch subject: [net-next PATCH v13 10/14] mfd: an8855: Add support for Airoha AN8855 Switch MFD
config: i386-randconfig-006-20250321 (https://download.01.org/0day-ci/archive/20250321/202503211428.H4VdWHco-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250321/202503211428.H4VdWHco-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503211428.H4VdWHco-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/mfd/airoha-an8855.o: in function `an8855_core_probe':
>> drivers/mfd/airoha-an8855.c:376: undefined reference to `devm_mdio_regmap_init'


vim +376 drivers/mfd/airoha-an8855.c

   352	
   353	static int an8855_core_probe(struct mdio_device *mdiodev)
   354	{
   355		struct regmap *regmap, *regmap_phy;
   356		struct device *dev = &mdiodev->dev;
   357		struct an8855_core_priv *priv;
   358		struct gpio_desc *reset_gpio;
   359		u32 val;
   360		int ret;
   361	
   362		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
   363		if (!priv)
   364			return -ENOMEM;
   365	
   366		priv->bus = mdiodev->bus;
   367		priv->switch_addr = mdiodev->addr;
   368		/* No DMA for mdiobus, mute warning for DMA mask not set */
   369		dev->dma_mask = &dev->coherent_dma_mask;
   370	
   371		regmap = devm_regmap_init(dev, NULL, priv, &an8855_regmap_config);
   372		if (IS_ERR(regmap))
   373			return dev_err_probe(dev, PTR_ERR(regmap),
   374					     "regmap initialization failed\n");
   375	
 > 376		regmap_phy = devm_mdio_regmap_init(dev, priv, &an8855_regmap_phy_config);
   377		if (IS_ERR(regmap_phy))
   378			return dev_err_probe(dev, PTR_ERR(regmap_phy),
   379					     "regmap phy initialization failed\n");
   380	
   381		reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
   382		if (IS_ERR(reset_gpio))
   383			return PTR_ERR(reset_gpio);
   384	
   385		if (reset_gpio) {
   386			usleep_range(100000, 150000);
   387			gpiod_set_value_cansleep(reset_gpio, 0);
   388			usleep_range(100000, 150000);
   389			gpiod_set_value_cansleep(reset_gpio, 1);
   390	
   391			/* Poll HWTRAP reg to wait for Switch to fully Init */
   392			ret = regmap_read_poll_timeout(regmap, AN8855_HWTRAP, val,
   393						       val, 20, 200000);
   394			if (ret)
   395				return ret;
   396		}
   397	
   398		ret = an8855_read_switch_id(dev, regmap);
   399		if (ret)
   400			return ret;
   401	
   402		/* Release global PHY power down */
   403		ret = regmap_write(regmap, AN8855_RG_GPHY_AFE_PWD, 0x0);
   404		if (ret)
   405			return ret;
   406	
   407		return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, an8855_core_childs,
   408					    ARRAY_SIZE(an8855_core_childs), NULL, 0,
   409					    NULL);
   410	}
   411	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

