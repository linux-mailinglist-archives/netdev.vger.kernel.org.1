Return-Path: <netdev+bounces-189348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE15AB1C6F
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 20:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE271703C2
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 18:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7D823E347;
	Fri,  9 May 2025 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kc5OEvSz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6777C23F417;
	Fri,  9 May 2025 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746815933; cv=none; b=P1C7H2dkFIUKqtTD1/UfaxSy68GRbQU/Tpi3lhLcNEtqW6GW2dFt7uvGzql9qOSczQC8WoiQq+eMSHdlmQom+3ULTFplftjTS71QRQoKJzFb+9Z0WQ9jDkCOcYxRDkGyY9GmW0mUjiKMRdSa5W+VhP7B04M/2S590n8H9Z3hnwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746815933; c=relaxed/simple;
	bh=QtwKxH7Ox65yxsmQJyOF0DBPCqTdkDUFcjdM6t1xUak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNlFWzI1dOam9OME18AJascVeYm4yl/4ZwYsiS52otWERsMEC6/FG6jgdBJoR+whE0rooqdYovKpjKNG68uN8Q2RyxvpuUGKcKZhvdhDmuq1Io2cPBbBN3X6TsRfvRpySsBMnpMqoRwZ7xzhjVmDX+TKDZi2vuL62m17QkHHJcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kc5OEvSz; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746815932; x=1778351932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QtwKxH7Ox65yxsmQJyOF0DBPCqTdkDUFcjdM6t1xUak=;
  b=Kc5OEvSzRYblZuB/jhgV+aovjps5cdGEdCxzS1Lxmsn5FSD1Wf+5JpU2
   Gv4MIjyUIr0yljVU6A8PCdUlFWc1pEA+X4o5IpHjprA87VDxioUlxhkXm
   Olu7eTFMSQ3m1yFL38ddObjBizMiaO2EPMydx8hrDZYmCFr6vFB3aWoPa
   5qC5v95ZyABFXcCWo9o38JIsZZDxMNUBtfkvoOp15vyV3ongmVlTtKTlM
   0XZ+D4OBX5vxD2HJifAnkYB0yMi9GiOhpH2SiLnZaTGTVdyVIAxHhRc2N
   SPg+KmB1smkhT/ouIJEHBNgfKxhAczKfz7dsslqMfoNRW6Vmv4y31RGBk
   A==;
X-CSE-ConnectionGUID: pzPp4zbVQcShIDvqjD4oyA==
X-CSE-MsgGUID: 8mlFOmUpQIubK9Tej/Mncw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59649555"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59649555"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 11:38:51 -0700
X-CSE-ConnectionGUID: ylxpl6m5TPqiYokkCvZ9Jw==
X-CSE-MsgGUID: IqHZR2MaQNqBYpXTw4x6Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="167781489"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 May 2025 11:38:43 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDScL-000CMl-0u;
	Fri, 09 May 2025 18:38:41 +0000
Date: Sat, 10 May 2025 02:37:41 +0800
From: kernel test robot <lkp@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: enetc: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <202505100217.0jMyMEHN-lkp@intel.com>
References: <20250508114310.1258162-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508114310.1258162-1-vladimir.oltean@nxp.com>

Hi Vladimir,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vladimir-Oltean/net-enetc-convert-to-ndo_hwtstamp_get-and-ndo_hwtstamp_set/20250508-194458
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250508114310.1258162-1-vladimir.oltean%40nxp.com
patch subject: [PATCH net-next] net: enetc: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
config: arm64-randconfig-002-20250509 (https://download.01.org/0day-ci/archive/20250510/202505100217.0jMyMEHN-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250510/202505100217.0jMyMEHN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505100217.0jMyMEHN-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from arch/arm64/include/asm/rwonce.h:71,
                    from include/linux/compiler.h:390,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/timer.h:5,
                    from drivers/net/ethernet/freescale/enetc/enetc.h:4,
                    from drivers/net/ethernet/freescale/enetc/enetc.c:4:
>> include/linux/stddef.h:8:16: error: expected identifier or '(' before 'void'
    #define NULL ((void *)0)
                   ^~~~
   drivers/net/ethernet/freescale/enetc/enetc.h:495:50: note: in expansion of macro 'NULL'
    #define enetc_hwtstamp_set(ndev, config, extack) NULL
                                                     ^~~~
   drivers/net/ethernet/freescale/enetc/enetc.c:3265:5: note: in expansion of macro 'enetc_hwtstamp_set'
    int enetc_hwtstamp_set(struct net_device *ndev,
        ^~~~~~~~~~~~~~~~~~
>> include/linux/stddef.h:8:23: error: expected ')' before numeric constant
    #define NULL ((void *)0)
                          ^
   drivers/net/ethernet/freescale/enetc/enetc.h:495:50: note: in expansion of macro 'NULL'
    #define enetc_hwtstamp_set(ndev, config, extack) NULL
                                                     ^~~~
   drivers/net/ethernet/freescale/enetc/enetc.c:3265:5: note: in expansion of macro 'enetc_hwtstamp_set'
    int enetc_hwtstamp_set(struct net_device *ndev,
        ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/printk.h:8,
                    from include/asm-generic/bug.h:22,
                    from arch/arm64/include/asm/bug.h:26,
                    from include/linux/ktime.h:24,
                    from include/linux/timer.h:6,
                    from drivers/net/ethernet/freescale/enetc/enetc.h:4,
                    from drivers/net/ethernet/freescale/enetc/enetc.c:4:
>> drivers/net/ethernet/freescale/enetc/enetc.c:3312:19: error: 'enetc_hwtstamp_set' undeclared here (not in a function); did you mean 'enetc_tstamp_tx'?
    EXPORT_SYMBOL_GPL(enetc_hwtstamp_set);
                      ^~~~~~~~~~~~~~~~~~
   include/linux/export.h:70:16: note: in definition of macro '__EXPORT_SYMBOL'
     extern typeof(sym) sym;     \
                   ^~~
   include/linux/export.h:84:33: note: in expansion of macro '_EXPORT_SYMBOL'
    #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "GPL")
                                    ^~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/enetc/enetc.c:3312:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(enetc_hwtstamp_set);
    ^~~~~~~~~~~~~~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from arch/arm64/include/asm/rwonce.h:71,
                    from include/linux/compiler.h:390,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/timer.h:5,
                    from drivers/net/ethernet/freescale/enetc/enetc.h:4,
                    from drivers/net/ethernet/freescale/enetc/enetc.c:4:
>> include/linux/stddef.h:8:16: error: expected identifier or '(' before 'void'
    #define NULL ((void *)0)
                   ^~~~
   drivers/net/ethernet/freescale/enetc/enetc.h:494:43: note: in expansion of macro 'NULL'
    #define enetc_hwtstamp_get(ndev, config)  NULL
                                              ^~~~
   drivers/net/ethernet/freescale/enetc/enetc.c:3314:5: note: in expansion of macro 'enetc_hwtstamp_get'
    int enetc_hwtstamp_get(struct net_device *ndev,
        ^~~~~~~~~~~~~~~~~~
>> include/linux/stddef.h:8:23: error: expected ')' before numeric constant
    #define NULL ((void *)0)
                          ^
   drivers/net/ethernet/freescale/enetc/enetc.h:494:43: note: in expansion of macro 'NULL'
    #define enetc_hwtstamp_get(ndev, config)  NULL
                                              ^~~~
   drivers/net/ethernet/freescale/enetc/enetc.c:3314:5: note: in expansion of macro 'enetc_hwtstamp_get'
    int enetc_hwtstamp_get(struct net_device *ndev,
        ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/printk.h:8,
                    from include/asm-generic/bug.h:22,
                    from arch/arm64/include/asm/bug.h:26,
                    from include/linux/ktime.h:24,
                    from include/linux/timer.h:6,
                    from drivers/net/ethernet/freescale/enetc/enetc.h:4,
                    from drivers/net/ethernet/freescale/enetc/enetc.c:4:
>> drivers/net/ethernet/freescale/enetc/enetc.c:3333:19: error: 'enetc_hwtstamp_get' undeclared here (not in a function); did you mean 'enetc_hwtstamp_set'?
    EXPORT_SYMBOL_GPL(enetc_hwtstamp_get);
                      ^~~~~~~~~~~~~~~~~~
   include/linux/export.h:70:16: note: in definition of macro '__EXPORT_SYMBOL'
     extern typeof(sym) sym;     \
                   ^~~
   include/linux/export.h:84:33: note: in expansion of macro '_EXPORT_SYMBOL'
    #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "GPL")
                                    ^~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/enetc/enetc.c:3333:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(enetc_hwtstamp_get);
    ^~~~~~~~~~~~~~~~~
--
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from arch/arm64/include/asm/rwonce.h:71,
                    from include/linux/compiler.h:390,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/timer.h:5,
                    from enetc.h:4,
                    from enetc.c:4:
>> include/linux/stddef.h:8:16: error: expected identifier or '(' before 'void'
    #define NULL ((void *)0)
                   ^~~~
   enetc.h:495:50: note: in expansion of macro 'NULL'
    #define enetc_hwtstamp_set(ndev, config, extack) NULL
                                                     ^~~~
   enetc.c:3265:5: note: in expansion of macro 'enetc_hwtstamp_set'
    int enetc_hwtstamp_set(struct net_device *ndev,
        ^~~~~~~~~~~~~~~~~~
>> include/linux/stddef.h:8:23: error: expected ')' before numeric constant
    #define NULL ((void *)0)
                          ^
   enetc.h:495:50: note: in expansion of macro 'NULL'
    #define enetc_hwtstamp_set(ndev, config, extack) NULL
                                                     ^~~~
   enetc.c:3265:5: note: in expansion of macro 'enetc_hwtstamp_set'
    int enetc_hwtstamp_set(struct net_device *ndev,
        ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/printk.h:8,
                    from include/asm-generic/bug.h:22,
                    from arch/arm64/include/asm/bug.h:26,
                    from include/linux/ktime.h:24,
                    from include/linux/timer.h:6,
                    from enetc.h:4,
                    from enetc.c:4:
   enetc.c:3312:19: error: 'enetc_hwtstamp_set' undeclared here (not in a function); did you mean 'enetc_tstamp_tx'?
    EXPORT_SYMBOL_GPL(enetc_hwtstamp_set);
                      ^~~~~~~~~~~~~~~~~~
   include/linux/export.h:70:16: note: in definition of macro '__EXPORT_SYMBOL'
     extern typeof(sym) sym;     \
                   ^~~
   include/linux/export.h:84:33: note: in expansion of macro '_EXPORT_SYMBOL'
    #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "GPL")
                                    ^~~~~~~~~~~~~~
   enetc.c:3312:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(enetc_hwtstamp_set);
    ^~~~~~~~~~~~~~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from arch/arm64/include/asm/rwonce.h:71,
                    from include/linux/compiler.h:390,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/timer.h:5,
                    from enetc.h:4,
                    from enetc.c:4:
>> include/linux/stddef.h:8:16: error: expected identifier or '(' before 'void'
    #define NULL ((void *)0)
                   ^~~~
   enetc.h:494:43: note: in expansion of macro 'NULL'
    #define enetc_hwtstamp_get(ndev, config)  NULL
                                              ^~~~
   enetc.c:3314:5: note: in expansion of macro 'enetc_hwtstamp_get'
    int enetc_hwtstamp_get(struct net_device *ndev,
        ^~~~~~~~~~~~~~~~~~
>> include/linux/stddef.h:8:23: error: expected ')' before numeric constant
    #define NULL ((void *)0)
                          ^
   enetc.h:494:43: note: in expansion of macro 'NULL'
    #define enetc_hwtstamp_get(ndev, config)  NULL
                                              ^~~~
   enetc.c:3314:5: note: in expansion of macro 'enetc_hwtstamp_get'
    int enetc_hwtstamp_get(struct net_device *ndev,
        ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/printk.h:8,
                    from include/asm-generic/bug.h:22,
                    from arch/arm64/include/asm/bug.h:26,
                    from include/linux/ktime.h:24,
                    from include/linux/timer.h:6,
                    from enetc.h:4,
                    from enetc.c:4:
   enetc.c:3333:19: error: 'enetc_hwtstamp_get' undeclared here (not in a function); did you mean 'enetc_hwtstamp_set'?
    EXPORT_SYMBOL_GPL(enetc_hwtstamp_get);
                      ^~~~~~~~~~~~~~~~~~
   include/linux/export.h:70:16: note: in definition of macro '__EXPORT_SYMBOL'
     extern typeof(sym) sym;     \
                   ^~~
   include/linux/export.h:84:33: note: in expansion of macro '_EXPORT_SYMBOL'
    #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "GPL")
                                    ^~~~~~~~~~~~~~
   enetc.c:3333:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(enetc_hwtstamp_get);
    ^~~~~~~~~~~~~~~~~


vim +3312 drivers/net/ethernet/freescale/enetc/enetc.c

  3264	
  3265	int enetc_hwtstamp_set(struct net_device *ndev,
  3266			       struct kernel_hwtstamp_config *config,
  3267			       struct netlink_ext_ack *extack)
  3268	{
  3269		struct enetc_ndev_priv *priv = netdev_priv(ndev);
  3270		int err, new_offloads = priv->active_offloads;
  3271	
  3272		switch (config->tx_type) {
  3273		case HWTSTAMP_TX_OFF:
  3274			new_offloads &= ~ENETC_F_TX_TSTAMP_MASK;
  3275			break;
  3276		case HWTSTAMP_TX_ON:
  3277			new_offloads &= ~ENETC_F_TX_TSTAMP_MASK;
  3278			new_offloads |= ENETC_F_TX_TSTAMP;
  3279			break;
  3280		case HWTSTAMP_TX_ONESTEP_SYNC:
  3281			if (!enetc_si_is_pf(priv->si))
  3282				return -EOPNOTSUPP;
  3283	
  3284			new_offloads &= ~ENETC_F_TX_TSTAMP_MASK;
  3285			new_offloads |= ENETC_F_TX_ONESTEP_SYNC_TSTAMP;
  3286			break;
  3287		default:
  3288			return -ERANGE;
  3289		}
  3290	
  3291		switch (config->rx_filter) {
  3292		case HWTSTAMP_FILTER_NONE:
  3293			new_offloads &= ~ENETC_F_RX_TSTAMP;
  3294			break;
  3295		default:
  3296			new_offloads |= ENETC_F_RX_TSTAMP;
  3297			config->rx_filter = HWTSTAMP_FILTER_ALL;
  3298		}
  3299	
  3300		if ((new_offloads ^ priv->active_offloads) & ENETC_F_RX_TSTAMP) {
  3301			bool extended = !!(new_offloads & ENETC_F_RX_TSTAMP);
  3302	
  3303			err = enetc_reconfigure(priv, extended, NULL, NULL);
  3304			if (err)
  3305				return err;
  3306		}
  3307	
  3308		priv->active_offloads = new_offloads;
  3309	
  3310		return 0;
  3311	}
> 3312	EXPORT_SYMBOL_GPL(enetc_hwtstamp_set);
  3313	
  3314	int enetc_hwtstamp_get(struct net_device *ndev,
  3315			       struct kernel_hwtstamp_config *config)
  3316	{
  3317		struct enetc_ndev_priv *priv = netdev_priv(ndev);
  3318	
  3319		config->flags = 0;
  3320	
  3321		if (priv->active_offloads & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
  3322			config->tx_type = HWTSTAMP_TX_ONESTEP_SYNC;
  3323		else if (priv->active_offloads & ENETC_F_TX_TSTAMP)
  3324			config->tx_type = HWTSTAMP_TX_ON;
  3325		else
  3326			config->tx_type = HWTSTAMP_TX_OFF;
  3327	
  3328		config->rx_filter = (priv->active_offloads & ENETC_F_RX_TSTAMP) ?
  3329				     HWTSTAMP_FILTER_ALL : HWTSTAMP_FILTER_NONE;
  3330	
  3331		return 0;
  3332	}
> 3333	EXPORT_SYMBOL_GPL(enetc_hwtstamp_get);
  3334	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

