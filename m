Return-Path: <netdev+bounces-119769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 234BC956E44
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 17:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977AB1F2121A
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD248176AB9;
	Mon, 19 Aug 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c48Pserz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C02C17624C;
	Mon, 19 Aug 2024 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080074; cv=none; b=kDBur3wRSf5Dzduq3O0bzsqku8G69gbOMLtXmOjnb/iMJU4PCRa0xd0KinePmET9FibouxyIvnfc5/3xbFvbzD0PIPElGkb4OXiHp1+oHYARhQmKbroA6ya2yhoyp58WLJpReG04QxQdGuUc7pRSJLt5+Qcfld/ytpeHgNDR+Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080074; c=relaxed/simple;
	bh=OPGogBzdLYo2LmBSCRmFUCqRPxUNDvsm1vgEBwTzMZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFbmbPQDEV/0GCOUGPhZU4uN/TU17ROQk04xBJFNag7P/QNpBQcV8hhO6HEJZazxnLmFyjVeesaLAHiTlW367vZ/k+VgEprI1Q4p6ddjQXnANatk4IVgOx4NBVDa328Md5S3NJB9qtHD8umaQCUkMonAVMcFvds50xBjub43OmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c48Pserz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724080074; x=1755616074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OPGogBzdLYo2LmBSCRmFUCqRPxUNDvsm1vgEBwTzMZA=;
  b=c48PserzhyZvuJ4emmmbxeNAsROroh46AdGIJGFpNLjz/eX5ZwmM8qnd
   QlZKmHj8BHQjKu3GcuA6QN8aawMHUbKkW0vFhe3XQmmy4+2Rgr3IrzKzk
   wHyFdi7cK04f0twuSKNEslNKd2VuiJNrxf7l6A10myTI7P2R4Gc1NSWjD
   ltwuRHdBTbxcmJuLx62zM4xdNpO419zDXbHkTXgVZ/djeb43JsUArVZJL
   b7+k7GGTwPWxUDzj7VUMOMHXkr/I0SOA9XMH5K1wM4+teX26dZmDystoJ
   vQaIG0/0bbJCRIWjp1TWESTqNi+IfU38otAMPpuDC5NGd9F1raPSmkSxW
   A==;
X-CSE-ConnectionGUID: ZXdNAXWfTnSFFDH/S7Lv6w==
X-CSE-MsgGUID: ZR7oTUElSgCaCeKHZHwmKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22146677"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22146677"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 08:07:53 -0700
X-CSE-ConnectionGUID: 6yWknJfcS8mOnr7Nz+28kQ==
X-CSE-MsgGUID: MiWKthZaTK6BqyV8w+NvLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60099160"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 19 Aug 2024 08:07:47 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sg3yz-00096S-20;
	Mon, 19 Aug 2024 15:07:45 +0000
Date: Mon, 19 Aug 2024 23:07:19 +0800
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
Message-ID: <202408192219.zrGff7n1-lkp@intel.com>
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
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240819/202408192219.zrGff7n1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240819/202408192219.zrGff7n1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408192219.zrGff7n1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c:9:
   drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c: In function 'hbg_hw_set_txrx_intr_enable':
>> drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h:27:59: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
      27 |         regmap_write_bits((priv)->regmap, reg_addr, mask, FIELD_PREP(mask, val))
         |                                                           ^~~~~~~~~~
   drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c:101:9: note: in expansion of macro 'hbg_reg_write_field'
     101 |         hbg_reg_write_field(priv, addr, HBG_REG_CF_IND_INT_STAT_CLR_MSK_B, enabld);
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c: In function 'hbg_hw_txrx_intr_is_enabled':
>> drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h:24:9: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
      24 |         FIELD_GET(mask, hbg_reg_read(priv, reg_addr))
         |         ^~~~~~~~~
   drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c:109:16: note: in expansion of macro 'hbg_reg_read_field'
     109 |         return hbg_reg_read_field(priv, addr, HBG_REG_CF_IND_INT_STAT_CLR_MSK_B);
         |                ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c: In function 'hbg_init_tx_desc':
>> drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c:52:18: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
      52 |         word0 |= FIELD_PREP(HBG_TX_DESC_W0_WB_B, HBG_STATUS_ENABLE);
         |                  ^~~~~~~~~~
   drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c: In function 'hbg_sync_data_from_hw':
>> drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c:233:16: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
     233 |         return FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M, rx_desc->word2) != 0;
         |                ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +27 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h

97e170277067a0 Jijie Shao 2024-08-19  19  
97e170277067a0 Jijie Shao 2024-08-19  20  #define hbg_reg_write64(priv, reg_addr, value) \
97e170277067a0 Jijie Shao 2024-08-19  21  	lo_hi_writeq(value, (priv)->io_base + (reg_addr))
97e170277067a0 Jijie Shao 2024-08-19  22  
44d1e0ec4b312d Jijie Shao 2024-08-19  23  #define hbg_reg_read_field(priv, reg_addr, mask) \
44d1e0ec4b312d Jijie Shao 2024-08-19 @24  	FIELD_GET(mask, hbg_reg_read(priv, reg_addr))
44d1e0ec4b312d Jijie Shao 2024-08-19  25  
44d1e0ec4b312d Jijie Shao 2024-08-19  26  #define hbg_reg_write_field(priv, reg_addr, mask, val) \
44d1e0ec4b312d Jijie Shao 2024-08-19 @27  	regmap_write_bits((priv)->regmap, reg_addr, mask, FIELD_PREP(mask, val))
44d1e0ec4b312d Jijie Shao 2024-08-19  28  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

