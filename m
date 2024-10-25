Return-Path: <netdev+bounces-139054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFB99AFE22
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 11:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C341F2197E
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 09:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0449C1D2B17;
	Fri, 25 Oct 2024 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTDBUfUt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF7C175A6;
	Fri, 25 Oct 2024 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848360; cv=none; b=sMVhrRGg/CNtzaR4NwY++mzsD4JOw0sO1SWJWwIb+2zIIxbxKCr+hX/5VTU0UzMtxTBeg5/utDN/z80yMGnKZ+bSM0tvbRbgSH+eBzmWn+wGc6BAtOc6B3fqtI8qwEVK5Ksj/+AW6Ye20Zn3i6824bElN7CY38ZBtNh3C14BmPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848360; c=relaxed/simple;
	bh=BhMfZ/Qr3xfxsyNGBewyG61lKCjGfrP4CAs7Bh9O61A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIh7zJ38WS6xZZqNiFIWhlory+3tCtCeuQF70oUdY9wMNM962Vdkw2RtNyPSJ4MbNZVikbw3P/KLVna2m6Q/nnqloYxclBQBc4gIyRpUpwE/dB+C82BTkRNCBeWgMQhy7phTcB71ruRnpuguAKuSfuKOiNMb5zc4Bpk+FrvzoYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTDBUfUt; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729848359; x=1761384359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BhMfZ/Qr3xfxsyNGBewyG61lKCjGfrP4CAs7Bh9O61A=;
  b=UTDBUfUtWaAPHa12Pk4NndilIzX4V2ZFWzSjbVJ0Y4Xu1KR8AWR8Lnxx
   PDcUX7qgBjXdQIM1BXOA1PJoXOENXRqrmeZb8t3WuiMnCgW2JhAujHRnm
   4If2ZeW6/ruZYzkmk3ZTE+nEWD9yZMJWkBgt5Hh0y47Zgfj3g3RhNiPWh
   7Kn7FAQ2456Pq0UwJ4SIeJxv36io04oGKyxcJ3/ZbOz2oVtgdR3Jfvqkj
   qm6bwbkXj3i2rj3bxKABKs+HSLKSgZbfqoKEhAMgzdLvM259RgxcnG+J2
   Sh0gpuHXgI7E+iYZDVTI26aOoB+2JjyJO1Vx1TvKv7kdiFg41MBb4FCQT
   Q==;
X-CSE-ConnectionGUID: CFKyILdCTEO/F/ac2P1fLw==
X-CSE-MsgGUID: GXBl/5A5TDGrQvLxUMjYcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46976026"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46976026"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 02:25:59 -0700
X-CSE-ConnectionGUID: pangIxHsQ+ShqJtRmCy2FA==
X-CSE-MsgGUID: CfxRfQ4PRX+iuMy4db0xHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="81288958"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 25 Oct 2024 02:25:54 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4GZr-000Xyv-1t;
	Fri, 25 Oct 2024 09:25:51 +0000
Date: Fri, 25 Oct 2024 17:25:04 +0800
From: kernel test robot <lkp@intel.com>
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, shaojijie@huawei.com
Subject: Re: [PATCH net-next 4/7] net: hibmcge: Add register dump supported
 in this module
Message-ID: <202410251738.mRleD5uf-lkp@intel.com>
References: <20241023134213.3359092-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023134213.3359092-5-shaojijie@huawei.com>

Hi Jijie,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jijie-Shao/net-hibmcge-Add-dump-statistics-supported-in-this-module/20241023-215222
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241023134213.3359092-5-shaojijie%40huawei.com
patch subject: [PATCH net-next 4/7] net: hibmcge: Add register dump supported in this module
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20241025/202410251738.mRleD5uf-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410251738.mRleD5uf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410251738.mRleD5uf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c: In function 'hbg_ethtool_get_regs':
>> drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c:322:20: warning: '%s' directive output may be truncated writing up to 127 bytes into a region of size 31 [-Wformat-truncation=]
     322 |                  "[%s] %s", type_info->name, reg_map->name);
         |                    ^~
   In function 'hbg_get_reg_info',
       inlined from 'hbg_ethtool_get_regs' at drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c:338:14:
   drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c:321:9: note: 'snprintf' output between 4 and 154 bytes into a destination of size 32
     321 |         snprintf(info->name, sizeof(info->name),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     322 |                  "[%s] %s", type_info->name, reg_map->name);
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +322 drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c

   313	
   314	static u32 hbg_get_reg_info(struct hbg_priv *priv,
   315				    const struct hbg_reg_type_info *type_info,
   316				    const struct hbg_reg_offset_name_map *reg_map,
   317				    struct hbg_reg_info *info)
   318	{
   319		info->val = hbg_reg_read(priv, reg_map->reg_offset);
   320		info->offset = reg_map->reg_offset - type_info->offset_base;
   321		snprintf(info->name, sizeof(info->name),
 > 322			 "[%s] %s", type_info->name, reg_map->name);
   323	
   324		return sizeof(*info);
   325	}
   326	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

