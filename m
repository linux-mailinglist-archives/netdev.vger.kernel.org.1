Return-Path: <netdev+bounces-221657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D35B51721
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 14:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DBF175CB5
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 12:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3814B3101B6;
	Wed, 10 Sep 2025 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaKAb8t9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7209A319875
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507972; cv=none; b=lonPCMX9F/LTfSX2GYYufXcZuqMJjq5xiZ+Rbnb2yjdJ67+5X2usW2U4w5fJtC7G78rpceAbD5pSc1mAcXPbKbtb1QL59cirrF6AJ332Tcq6KOGrAn62YeO5ekUtqV1E5SP/LNb8VER32B7QsSoBByNzMa32gRppsAFa9PvLUEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507972; c=relaxed/simple;
	bh=pgMI66MNaYeqniPAkqZSK4XrtTH6hcO+V9XqXpP+tMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buFGCN1KOWsULn9Cb30SkVBFrHIGOxpVQJatiJYEC+ygB3YkPjOQpjW7R4BRC2Sqpk5aDZwSAIUwCg01UF0+WkxDbgH1NybbzzIpKudr/JmZdrmDNJIH3SndDplSus7mSsGk0+K4eRW4DBnmTqhzX7gemGHmgeP0HazjMJDCxdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaKAb8t9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757507972; x=1789043972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pgMI66MNaYeqniPAkqZSK4XrtTH6hcO+V9XqXpP+tMA=;
  b=YaKAb8t94o6YskYHYaJeCk3LvGywmzC1l4jgB0BANu8F2AmuKEzfMOW3
   4kISZRlh51ZGiDLIsJoVFBsNuxN79J5fimzpkOkT/3Ny33fZiU/9SvlZP
   AAumagUftqek0aQaTMmwCY92kL0W+0jCYNhDmGVW3zi8SV2k4C0Nsc882
   31YHMMK+gNZnno/SarYbNZ4bmZxpIClRoXD1ffTsKvLIkEIciK992t+A2
   WNQ733G8M/t5hM9AxIb0AqlZEN3B/Wg6E4p6t/NwTNrRiQ/e/Ae8NiF+R
   jC5070Vqx9HDwHZHKCK54Lc12+wp9msOluoDInxkPGyGirW3lHjqya+rQ
   g==;
X-CSE-ConnectionGUID: 6el0De1mRZik6aZROupGYw==
X-CSE-MsgGUID: RxsPc/RiRQeICRqL6J9Mjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="77271547"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="77271547"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 05:39:18 -0700
X-CSE-ConnectionGUID: xdKiQp0QRPGDqB5z5waSiA==
X-CSE-MsgGUID: vepjTz59ShWvHR9L2Jlc1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="197052738"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Sep 2025 05:39:14 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwK6R-0005vj-20;
	Wed, 10 Sep 2025 12:39:11 +0000
Date: Wed, 10 Sep 2025 20:38:31 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	intel-wired-lan@lists.osuosl.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Yael Chemla <ychemla@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 3/4] net/mlx5e: Add logic to read RS-FEC
 histogram bin ranges from PPHCR
Message-ID: <202509102020.zpP7Pu8o-lkp@intel.com>
References: <20250909184216.1524669-4-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909184216.1524669-4-vadim.fedorenko@linux.dev>

Hi Vadim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/ethtool-add-FEC-bins-histogramm-report/20250910-025057
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250909184216.1524669-4-vadim.fedorenko%40linux.dev
patch subject: [PATCH net-next 3/4] net/mlx5e: Add logic to read RS-FEC histogram bin ranges from PPHCR
config: i386-buildonly-randconfig-002-20250910 (https://download.01.org/0day-ci/archive/20250910/202509102020.zpP7Pu8o-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250910/202509102020.zpP7Pu8o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509102020.zpP7Pu8o-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/string.h:3,
                    from arch/x86/include/asm/cpuid/api.h:10,
                    from arch/x86/include/asm/processor.h:19,
                    from include/linux/sched.h:13,
                    from drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h:38,
                    from drivers/net/ethernet/mellanox/mlx5/core/lib/events.h:7,
                    from drivers/net/ethernet/mellanox/mlx5/core/en_stats.c:33:
   drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: In function 'fec_rs_histogram_fill_ranges':
>> drivers/net/ethernet/mellanox/mlx5/core/en_stats.c:1505:43: warning: argument to 'sizeof' in '__builtin_memset' call is the same expression as the destination; did you mean to dereference it? [-Wsizeof-pointer-memaccess]
    1505 |         memset(priv->fec_ranges, 0, sizeof(priv->fec_ranges));
         |                                           ^
   arch/x86/include/asm/string_32.h:194:52: note: in definition of macro 'memset'
     194 | #define memset(s, c, count) __builtin_memset(s, c, count)
         |                                                    ^~~~~


vim +1505 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c

  1494	
  1495	static u8
  1496	fec_rs_histogram_fill_ranges(struct mlx5e_priv *priv,
  1497				     const struct ethtool_fec_hist_range **ranges)
  1498	{
  1499		struct mlx5_core_dev *mdev = priv->mdev;
  1500		u32 out[MLX5_ST_SZ_DW(pphcr_reg)] = {0};
  1501		u32 in[MLX5_ST_SZ_DW(pphcr_reg)] = {0};
  1502		int sz = MLX5_ST_SZ_BYTES(pphcr_reg);
  1503		u8 active_hist_type, num_of_bins;
  1504	
> 1505		memset(priv->fec_ranges, 0, sizeof(priv->fec_ranges));
  1506		MLX5_SET(pphcr_reg, in, local_port, 1);
  1507		if (mlx5_core_access_reg(mdev, in, sz, out, sz, MLX5_REG_PPHCR, 0, 0))
  1508			return 0;
  1509	
  1510		active_hist_type = MLX5_GET(pphcr_reg, out, active_hist_type);
  1511		if (!active_hist_type)
  1512			return 0;
  1513	
  1514		num_of_bins = MLX5_GET(pphcr_reg, out, num_of_bins);
  1515		if (WARN_ON_ONCE(num_of_bins > MLX5E_FEC_RS_HIST_MAX))
  1516			return 0;
  1517	
  1518		for (u8 i = 0; i < num_of_bins; i++) {
  1519			void *bin_range = MLX5_ADDR_OF(pphcr_reg, out, bin_range[i]);
  1520	
  1521			priv->fec_ranges[i].high = MLX5_GET(bin_range_layout, bin_range,
  1522							    high_val);
  1523			priv->fec_ranges[i].low = MLX5_GET(bin_range_layout, bin_range,
  1524							   low_val);
  1525		}
  1526		*ranges = priv->fec_ranges;
  1527	
  1528		return num_of_bins;
  1529	}
  1530	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

