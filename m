Return-Path: <netdev+bounces-119799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9C0957011
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 18:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EBD11F242CB
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448C116C87B;
	Mon, 19 Aug 2024 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CcnRfXdz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4C015D5DE;
	Mon, 19 Aug 2024 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084399; cv=none; b=Y+uE05Liqj4T6EA6YtnKLU5hQNW1Tyvb461Xyy5TOp3uXYz+cnkVeHACnBRZ5b8VGcgpFG+NIImcN+Njk5aKyvOe6gttr/0jqpYxI96DwlyOa1F75L0vwUs0EfDICz3kd8IryXd3VEf3unOUUvQJLOfG4+3fcCgooBxjPdn+7j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084399; c=relaxed/simple;
	bh=WRBEAIL/mSk2vjw7LvazfEFu+s59E7ODhMDhYqdTKj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJlrzq8trsprqIMvkv75oQOdrAuBXY99z+AN5XoBRSq/fk/c2mtIvV1DNFpxi0sjHRUQ51SY49XrJb8niSw6eOFj94aeavQRKg1J2FjAtusBRzV7usVc2yexeqYW4eZUiOSd3pc5W/NuHRg/PtQClOI16DQf6LnaMvVDvJqeyTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CcnRfXdz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724084396; x=1755620396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WRBEAIL/mSk2vjw7LvazfEFu+s59E7ODhMDhYqdTKj8=;
  b=CcnRfXdzIqSXlBbBjIC/3xFNkT8N7yIa+KqkIfZdzeWOGLxz4Z+l3opr
   q/zHpVjZpkxkpHN+73xkmAo6PPYRLEXtX76l+LCkBoqmdSM5R9zD1+w6J
   C+UC9DlaJpTecb93SjMEB2Ok2DmDKUZ80xcEJEc3/a7eqZmAKW+pX+Fn4
   Qe63WznAO1KoeqoEmssvYaiRYCDeYnQ2CNwEo3wLAfp4cocEd2VoGyVxl
   Fb3TrnkzhnbJ8Dv/6TJYO8DAUnz3UVoXc8Mki9SpTua2dHWEbI2oxutjb
   sb/FNQw2+IOKOXJncwHFjCt/voq89PyVWjLox1dW/kjjP8DrHr7g4ZTnn
   A==;
X-CSE-ConnectionGUID: fVGPF2bDRqSEXkL85GnkgQ==
X-CSE-MsgGUID: GHltb1emR126KZWHr6T5lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33759115"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="33759115"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 09:19:56 -0700
X-CSE-ConnectionGUID: 1UZ5JfHgT5yUp/Cc0BLuFg==
X-CSE-MsgGUID: zSQt0BDLSaWM5b9rxfJjgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="64585048"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Aug 2024 09:19:50 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sg56i-0009BA-2E;
	Mon, 19 Aug 2024 16:19:48 +0000
Date: Tue, 20 Aug 2024 00:19:14 +0800
From: kernel test robot <lkp@intel.com>
To: Jijie Shao <shaojijie@huawei.com>, yisen.zhuang@huawei.com,
	salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	shaojijie@huawei.com, sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
	jdamato@fastly.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 09/11] net: hibmcge: Add a Makefile and update
 Kconfig for hibmcge
Message-ID: <202408200026.q20EuSHC-lkp@intel.com>
References: <20240819071229.2489506-10-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819071229.2489506-10-shaojijie@huawei.com>

Hi Jijie,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jijie-Shao/net-hibmcge-Add-pci-table-supported-in-this-module/20240819-152333
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240819071229.2489506-10-shaojijie%40huawei.com
patch subject: [PATCH net-next 09/11] net: hibmcge: Add a Makefile and update Kconfig for hibmcge
config: sparc64-defconfig (https://download.01.org/0day-ci/archive/20240820/202408200026.q20EuSHC-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240820/202408200026.q20EuSHC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408200026.q20EuSHC-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:15:21: error: variable 'hbg_regmap_config' has initializer but incomplete type
      15 | static const struct regmap_config hbg_regmap_config = {
         |                     ^~~~~~~~~~~~~
>> drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:16:10: error: 'const struct regmap_config' has no member named 'reg_bits'
      16 |         .reg_bits       = 32,
         |          ^~~~~~~~
>> drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:16:27: warning: excess elements in struct initializer
      16 |         .reg_bits       = 32,
         |                           ^~
   drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:16:27: note: (near initialization for 'hbg_regmap_config')
>> drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:17:10: error: 'const struct regmap_config' has no member named 'reg_stride'
      17 |         .reg_stride     = 4,
         |          ^~~~~~~~~~
   drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:17:27: warning: excess elements in struct initializer
      17 |         .reg_stride     = 4,
         |                           ^
   drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:17:27: note: (near initialization for 'hbg_regmap_config')
>> drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:18:10: error: 'const struct regmap_config' has no member named 'val_bits'
      18 |         .val_bits       = 32,
         |          ^~~~~~~~
   drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:18:27: warning: excess elements in struct initializer
      18 |         .val_bits       = 32,
         |                           ^~
   drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:18:27: note: (near initialization for 'hbg_regmap_config')
>> drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:19:10: error: 'const struct regmap_config' has no member named 'max_register'
      19 |         .max_register   = 0x20000,
         |          ^~~~~~~~~~~~
   drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:19:27: warning: excess elements in struct initializer
      19 |         .max_register   = 0x20000,
         |                           ^~~~~~~
   drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:19:27: note: (near initialization for 'hbg_regmap_config')
>> drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:20:10: error: 'const struct regmap_config' has no member named 'fast_io'
      20 |         .fast_io        = true,
         |          ^~~~~~~
   drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:20:27: warning: excess elements in struct initializer
      20 |         .fast_io        = true,
         |                           ^~~~
   drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:20:27: note: (near initialization for 'hbg_regmap_config')
   drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c: In function 'hbg_init':
>> drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:136:18: error: implicit declaration of function 'devm_regmap_init_mmio' [-Wimplicit-function-declaration]
     136 |         regmap = devm_regmap_init_mmio(dev, priv->io_base, &hbg_regmap_config);
         |                  ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:136:16: error: assignment to 'struct regmap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     136 |         regmap = devm_regmap_init_mmio(dev, priv->io_base, &hbg_regmap_config);
         |                ^
   drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c: At top level:
>> drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:15:35: error: storage size of 'hbg_regmap_config' isn't known
      15 | static const struct regmap_config hbg_regmap_config = {
         |                                   ^~~~~~~~~~~~~~~~~


vim +/hbg_regmap_config +15 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c

97e170277067a0 Jijie Shao 2024-08-19   14  
97e170277067a0 Jijie Shao 2024-08-19  @15  static const struct regmap_config hbg_regmap_config = {
97e170277067a0 Jijie Shao 2024-08-19  @16  	.reg_bits	= 32,
97e170277067a0 Jijie Shao 2024-08-19  @17  	.reg_stride	= 4,
97e170277067a0 Jijie Shao 2024-08-19  @18  	.val_bits	= 32,
97e170277067a0 Jijie Shao 2024-08-19  @19  	.max_register	= 0x20000,
97e170277067a0 Jijie Shao 2024-08-19  @20  	.fast_io	= true,
97e170277067a0 Jijie Shao 2024-08-19   21  };
97e170277067a0 Jijie Shao 2024-08-19   22  
687339112834f6 Jijie Shao 2024-08-19   23  static void hbg_all_irq_enable(struct hbg_priv *priv, bool enabled)
687339112834f6 Jijie Shao 2024-08-19   24  {
687339112834f6 Jijie Shao 2024-08-19   25  	u32 i;
687339112834f6 Jijie Shao 2024-08-19   26  
687339112834f6 Jijie Shao 2024-08-19   27  	for (i = 0; i < priv->vectors.info_array_len; i++)
687339112834f6 Jijie Shao 2024-08-19   28  		hbg_irq_enable(priv, priv->vectors.info_array[i].mask,
687339112834f6 Jijie Shao 2024-08-19   29  			       enabled);
687339112834f6 Jijie Shao 2024-08-19   30  }
687339112834f6 Jijie Shao 2024-08-19   31  
687339112834f6 Jijie Shao 2024-08-19   32  static int hbg_net_open(struct net_device *dev)
687339112834f6 Jijie Shao 2024-08-19   33  {
687339112834f6 Jijie Shao 2024-08-19   34  	struct hbg_priv *priv = netdev_priv(dev);
687339112834f6 Jijie Shao 2024-08-19   35  
687339112834f6 Jijie Shao 2024-08-19   36  	if (test_and_set_bit(HBG_NIC_STATE_OPEN, &priv->state))
687339112834f6 Jijie Shao 2024-08-19   37  		return 0;
687339112834f6 Jijie Shao 2024-08-19   38  
687339112834f6 Jijie Shao 2024-08-19   39  	netif_carrier_off(dev);
ae4a07330253ca Jijie Shao 2024-08-19   40  	napi_enable(&priv->rx_ring.napi);
ddb659b09e0fd3 Jijie Shao 2024-08-19   41  	napi_enable(&priv->tx_ring.napi);
687339112834f6 Jijie Shao 2024-08-19   42  	hbg_all_irq_enable(priv, true);
687339112834f6 Jijie Shao 2024-08-19   43  	hbg_hw_mac_enable(priv, HBG_STATUS_ENABLE);
687339112834f6 Jijie Shao 2024-08-19   44  	netif_start_queue(dev);
687339112834f6 Jijie Shao 2024-08-19   45  	hbg_phy_start(priv);
687339112834f6 Jijie Shao 2024-08-19   46  
687339112834f6 Jijie Shao 2024-08-19   47  	return 0;
687339112834f6 Jijie Shao 2024-08-19   48  }
687339112834f6 Jijie Shao 2024-08-19   49  
687339112834f6 Jijie Shao 2024-08-19   50  static int hbg_net_stop(struct net_device *dev)
687339112834f6 Jijie Shao 2024-08-19   51  {
687339112834f6 Jijie Shao 2024-08-19   52  	struct hbg_priv *priv = netdev_priv(dev);
687339112834f6 Jijie Shao 2024-08-19   53  
687339112834f6 Jijie Shao 2024-08-19   54  	if (!hbg_nic_is_open(priv))
687339112834f6 Jijie Shao 2024-08-19   55  		return 0;
687339112834f6 Jijie Shao 2024-08-19   56  
687339112834f6 Jijie Shao 2024-08-19   57  	clear_bit(HBG_NIC_STATE_OPEN, &priv->state);
687339112834f6 Jijie Shao 2024-08-19   58  	netif_carrier_off(dev);
687339112834f6 Jijie Shao 2024-08-19   59  	hbg_phy_stop(priv);
687339112834f6 Jijie Shao 2024-08-19   60  	netif_stop_queue(dev);
687339112834f6 Jijie Shao 2024-08-19   61  	hbg_hw_mac_enable(priv, HBG_STATUS_DISABLE);
687339112834f6 Jijie Shao 2024-08-19   62  	hbg_all_irq_enable(priv, false);
ddb659b09e0fd3 Jijie Shao 2024-08-19   63  	napi_disable(&priv->tx_ring.napi);
ae4a07330253ca Jijie Shao 2024-08-19   64  	napi_disable(&priv->rx_ring.napi);
687339112834f6 Jijie Shao 2024-08-19   65  
687339112834f6 Jijie Shao 2024-08-19   66  	return 0;
687339112834f6 Jijie Shao 2024-08-19   67  }
687339112834f6 Jijie Shao 2024-08-19   68  
687339112834f6 Jijie Shao 2024-08-19   69  static int hbg_net_set_mac_address(struct net_device *dev, void *addr)
687339112834f6 Jijie Shao 2024-08-19   70  {
687339112834f6 Jijie Shao 2024-08-19   71  	struct hbg_priv *priv = netdev_priv(dev);
687339112834f6 Jijie Shao 2024-08-19   72  	u8 *mac_addr;
687339112834f6 Jijie Shao 2024-08-19   73  
687339112834f6 Jijie Shao 2024-08-19   74  	mac_addr = ((struct sockaddr *)addr)->sa_data;
687339112834f6 Jijie Shao 2024-08-19   75  	hbg_hw_set_uc_addr(priv, ether_addr_to_u64(mac_addr));
687339112834f6 Jijie Shao 2024-08-19   76  	dev_addr_set(dev, mac_addr);
687339112834f6 Jijie Shao 2024-08-19   77  
687339112834f6 Jijie Shao 2024-08-19   78  	return 0;
687339112834f6 Jijie Shao 2024-08-19   79  }
687339112834f6 Jijie Shao 2024-08-19   80  
687339112834f6 Jijie Shao 2024-08-19   81  static int hbg_net_change_mtu(struct net_device *dev, int new_mtu)
687339112834f6 Jijie Shao 2024-08-19   82  {
687339112834f6 Jijie Shao 2024-08-19   83  	struct hbg_priv *priv = netdev_priv(dev);
687339112834f6 Jijie Shao 2024-08-19   84  	bool is_opened = hbg_nic_is_open(priv);
687339112834f6 Jijie Shao 2024-08-19   85  	u32 frame_len;
687339112834f6 Jijie Shao 2024-08-19   86  
687339112834f6 Jijie Shao 2024-08-19   87  	hbg_net_stop(dev);
687339112834f6 Jijie Shao 2024-08-19   88  
687339112834f6 Jijie Shao 2024-08-19   89  	frame_len = new_mtu + VLAN_HLEN * priv->dev_specs.vlan_layers +
687339112834f6 Jijie Shao 2024-08-19   90  		    ETH_HLEN + ETH_FCS_LEN;
687339112834f6 Jijie Shao 2024-08-19   91  	hbg_hw_set_mtu(priv, frame_len);
687339112834f6 Jijie Shao 2024-08-19   92  	WRITE_ONCE(dev->mtu, new_mtu);
687339112834f6 Jijie Shao 2024-08-19   93  
687339112834f6 Jijie Shao 2024-08-19   94  	dev_dbg(&priv->pdev->dev,
687339112834f6 Jijie Shao 2024-08-19   95  		"change mtu from %u to %u\n", dev->mtu, new_mtu);
687339112834f6 Jijie Shao 2024-08-19   96  	if (is_opened)
687339112834f6 Jijie Shao 2024-08-19   97  		hbg_net_open(dev);
687339112834f6 Jijie Shao 2024-08-19   98  	return 0;
687339112834f6 Jijie Shao 2024-08-19   99  }
687339112834f6 Jijie Shao 2024-08-19  100  
ddb659b09e0fd3 Jijie Shao 2024-08-19  101  static void hbg_net_tx_timeout(struct net_device *dev, unsigned int txqueue)
ddb659b09e0fd3 Jijie Shao 2024-08-19  102  {
ddb659b09e0fd3 Jijie Shao 2024-08-19  103  	struct hbg_priv *priv = netdev_priv(dev);
ddb659b09e0fd3 Jijie Shao 2024-08-19  104  	struct hbg_ring *ring = &priv->tx_ring;
ddb659b09e0fd3 Jijie Shao 2024-08-19  105  	char *buf = ring->tout_log_buf;
ddb659b09e0fd3 Jijie Shao 2024-08-19  106  	u32 pos = 0;
ddb659b09e0fd3 Jijie Shao 2024-08-19  107  
ddb659b09e0fd3 Jijie Shao 2024-08-19  108  	pos += scnprintf(buf + pos, HBG_TX_TIMEOUT_BUF_LEN - pos,
ddb659b09e0fd3 Jijie Shao 2024-08-19  109  			 "ring used num: %u, fifo used num: %u\n",
ddb659b09e0fd3 Jijie Shao 2024-08-19  110  			 hbg_get_queue_used_num(ring),
ddb659b09e0fd3 Jijie Shao 2024-08-19  111  			 hbg_hw_get_fifo_used_num(priv, HBG_DIR_TX));
ddb659b09e0fd3 Jijie Shao 2024-08-19  112  	pos += scnprintf(buf + pos, HBG_TX_TIMEOUT_BUF_LEN - pos,
ddb659b09e0fd3 Jijie Shao 2024-08-19  113  			 "ntc: %u, ntu: %u, irq enabled: %u\n",
ddb659b09e0fd3 Jijie Shao 2024-08-19  114  			 ring->ntc, ring->ntu,
ddb659b09e0fd3 Jijie Shao 2024-08-19  115  			 hbg_irq_is_enabled(priv, HBG_INT_MSK_TX_B));
ddb659b09e0fd3 Jijie Shao 2024-08-19  116  
ddb659b09e0fd3 Jijie Shao 2024-08-19  117  	netdev_info(dev, "%s", buf);
ddb659b09e0fd3 Jijie Shao 2024-08-19  118  }
ddb659b09e0fd3 Jijie Shao 2024-08-19  119  
687339112834f6 Jijie Shao 2024-08-19  120  static const struct net_device_ops hbg_netdev_ops = {
687339112834f6 Jijie Shao 2024-08-19  121  	.ndo_open		= hbg_net_open,
687339112834f6 Jijie Shao 2024-08-19  122  	.ndo_stop		= hbg_net_stop,
ddb659b09e0fd3 Jijie Shao 2024-08-19  123  	.ndo_start_xmit		= hbg_net_start_xmit,
687339112834f6 Jijie Shao 2024-08-19  124  	.ndo_validate_addr	= eth_validate_addr,
687339112834f6 Jijie Shao 2024-08-19  125  	.ndo_set_mac_address	= hbg_net_set_mac_address,
687339112834f6 Jijie Shao 2024-08-19  126  	.ndo_change_mtu		= hbg_net_change_mtu,
ddb659b09e0fd3 Jijie Shao 2024-08-19  127  	.ndo_tx_timeout		= hbg_net_tx_timeout,
687339112834f6 Jijie Shao 2024-08-19  128  };
687339112834f6 Jijie Shao 2024-08-19  129  
97e170277067a0 Jijie Shao 2024-08-19  130  static int hbg_init(struct hbg_priv *priv)
97e170277067a0 Jijie Shao 2024-08-19  131  {
97e170277067a0 Jijie Shao 2024-08-19  132  	struct device *dev = &priv->pdev->dev;
97e170277067a0 Jijie Shao 2024-08-19  133  	struct regmap *regmap;
44d1e0ec4b312d Jijie Shao 2024-08-19  134  	int ret;
97e170277067a0 Jijie Shao 2024-08-19  135  
97e170277067a0 Jijie Shao 2024-08-19 @136  	regmap = devm_regmap_init_mmio(dev, priv->io_base, &hbg_regmap_config);
97e170277067a0 Jijie Shao 2024-08-19  137  	if (IS_ERR(regmap))
97e170277067a0 Jijie Shao 2024-08-19  138  		return dev_err_probe(dev, PTR_ERR(regmap), "failed to init regmap\n");
97e170277067a0 Jijie Shao 2024-08-19  139  
97e170277067a0 Jijie Shao 2024-08-19  140  	priv->regmap = regmap;
44d1e0ec4b312d Jijie Shao 2024-08-19  141  	ret = hbg_hw_init(priv);
44d1e0ec4b312d Jijie Shao 2024-08-19  142  	if (ret)
44d1e0ec4b312d Jijie Shao 2024-08-19  143  		return ret;
44d1e0ec4b312d Jijie Shao 2024-08-19  144  
ddb659b09e0fd3 Jijie Shao 2024-08-19  145  	ret = hbg_txrx_init(priv);
ddb659b09e0fd3 Jijie Shao 2024-08-19  146  	if (ret)
ddb659b09e0fd3 Jijie Shao 2024-08-19  147  		return ret;
ddb659b09e0fd3 Jijie Shao 2024-08-19  148  
ddb659b09e0fd3 Jijie Shao 2024-08-19  149  	ret = devm_add_action_or_reset(&priv->pdev->dev, hbg_txrx_uninit, priv);
ddb659b09e0fd3 Jijie Shao 2024-08-19  150  	if (ret)
ddb659b09e0fd3 Jijie Shao 2024-08-19  151  		return ret;
ddb659b09e0fd3 Jijie Shao 2024-08-19  152  
20db2e78ac2dab Jijie Shao 2024-08-19  153  	ret = hbg_irq_init(priv);
20db2e78ac2dab Jijie Shao 2024-08-19  154  	if (ret)
20db2e78ac2dab Jijie Shao 2024-08-19  155  		return ret;
20db2e78ac2dab Jijie Shao 2024-08-19  156  
44d1e0ec4b312d Jijie Shao 2024-08-19  157  	return hbg_mdio_init(priv);
97e170277067a0 Jijie Shao 2024-08-19  158  }
7212bbc0ea2ed3 Jijie Shao 2024-08-19  159  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

