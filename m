Return-Path: <netdev+bounces-224665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82502B87B28
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 04:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CD93BC463
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 02:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F146C246789;
	Fri, 19 Sep 2025 02:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zz4UIPdR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A6A1A7253;
	Fri, 19 Sep 2025 02:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248137; cv=none; b=m7PuW6s781GTHiTdq41449SllDiJB2gHgd3Ys43pAD7Br0Ti8aAPJ9N+23ZCsBNqPUuge7AkTR77V3c1PUuwHEpg5REb6NucCuFspiekDi4uuiXuH/NWflVYFl4WoNCxcbNGJTG1xf4lyyhmqGSaGh7IDKlhmYcj4nsEdg4s5CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248137; c=relaxed/simple;
	bh=CLHifCxry/Hxtv8iK8qBwA7qqVqD2rKatdwWd6C6jug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtXLvo8KwUqaY9Kkcw6X+93gWRCVL9fZB94Dsrvh4BFLSwezJBk4txTA9jZEcdu1ZcQUVKP2wd5wPBngxS1P3XRrkDrQlGhRKYpVBxfSULPmoNYFhIpMldjC0cxv/Eg++OvWSB+4LtK9JhUqOo6H9Ohoe8pGavx4HUSYFs0YxFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zz4UIPdR; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758248136; x=1789784136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CLHifCxry/Hxtv8iK8qBwA7qqVqD2rKatdwWd6C6jug=;
  b=Zz4UIPdRMbqyoZXf5CuL5HAM7lZzF6NZgdK4aRO+BEI9ralx/s9yQvVq
   1a4zZi7mhHyKKteRG+/L3zoEAcp3GGfDi3+qtJDKZBwISEdowDpxOmXDa
   ZTfs12t9isxl+LJyCxugLC8Tw8zc4ZqabzlQnJEQoMzxT4K+5n2NHuRnA
   tZKotjEcSLN1cwwUyxG9Nk1vyUvyZjlj9C0ss9eWGGSmbwCCBe7Upt60+
   ecJH6hGKHouaBS8kv4M5876bMpCS5u2I4C9gdTEJtxvTe01lVqrRdG6DG
   HZvkN8kM+GxQ5O09iT/yZX31ILKYnxgnHn/g1YI9T8k5bD57g9EKwysXM
   w==;
X-CSE-ConnectionGUID: xzJUHMHxSxCxsRZWIwbjuA==
X-CSE-MsgGUID: eROpm238SRahpRDcUtHlEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60539411"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60539411"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 19:15:35 -0700
X-CSE-ConnectionGUID: kwB7LZncQw20PCFm6g74Tw==
X-CSE-MsgGUID: zIFh5levRFeugenmp1h1CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="174833928"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 18 Sep 2025 19:15:31 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzQen-0003uN-0g;
	Fri, 19 Sep 2025 02:15:29 +0000
Date: Fri, 19 Sep 2025 10:14:44 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Fang <wei.fang@nxp.com>, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, yangbo.lu@nxp.com,
	richardcochran@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Frank.Li@nxp.com
Cc: oe-kbuild-all@lists.linux.dev, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: enetc: use generic interfaces to get
 phc_index for ENETC v1
Message-ID: <202509191049.t301ozfh-lkp@intel.com>
References: <20250918074454.1742328-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918074454.1742328-1-wei.fang@nxp.com>

Hi Wei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Fang/net-enetc-use-generic-interfaces-to-get-phc_index-for-ENETC-v1/20250918-160739
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250918074454.1742328-1-wei.fang%40nxp.com
patch subject: [PATCH net-next] net: enetc: use generic interfaces to get phc_index for ENETC v1
config: parisc-randconfig-001-20250919 (https://download.01.org/0day-ci/archive/20250919/202509191049.t301ozfh-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250919/202509191049.t301ozfh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509191049.t301ozfh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/freescale/enetc/enetc_ethtool.c: In function 'enetc_get_ts_info':
>> drivers/net/ethernet/freescale/enetc/enetc_ethtool.c:955:14: warning: unused variable 'phc_idx' [-Wunused-variable]
     955 |         int *phc_idx;
         |              ^~~~~~~


vim +/phc_idx +955 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c

f5b9a1cde0a26c Wei Fang     2025-08-29  949  
f5b9a1cde0a26c Wei Fang     2025-08-29  950  static int enetc_get_ts_info(struct net_device *ndev,
f5b9a1cde0a26c Wei Fang     2025-08-29  951  			     struct kernel_ethtool_ts_info *info)
f5b9a1cde0a26c Wei Fang     2025-08-29  952  {
f5b9a1cde0a26c Wei Fang     2025-08-29  953  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
f5b9a1cde0a26c Wei Fang     2025-08-29  954  	struct enetc_si *si = priv->si;
f5b9a1cde0a26c Wei Fang     2025-08-29 @955  	int *phc_idx;
f5b9a1cde0a26c Wei Fang     2025-08-29  956  
f5b9a1cde0a26c Wei Fang     2025-08-29  957  	if (!enetc_ptp_clock_is_enabled(si))
f5b9a1cde0a26c Wei Fang     2025-08-29  958  		goto timestamp_tx_sw;
f5b9a1cde0a26c Wei Fang     2025-08-29  959  
5f3b8f93ed1b53 Wei Fang     2025-09-18  960  	info->phc_index = enetc_get_phc_index(si);
f5b9a1cde0a26c Wei Fang     2025-08-29  961  	if (info->phc_index < 0)
f5b9a1cde0a26c Wei Fang     2025-08-29  962  		goto timestamp_tx_sw;
f5b9a1cde0a26c Wei Fang     2025-08-29  963  
f5b9a1cde0a26c Wei Fang     2025-08-29  964  	enetc_get_ts_generic_info(ndev, info);
f5b9a1cde0a26c Wei Fang     2025-08-29  965  
f5b9a1cde0a26c Wei Fang     2025-08-29  966  	return 0;
f5b9a1cde0a26c Wei Fang     2025-08-29  967  
f5b9a1cde0a26c Wei Fang     2025-08-29  968  timestamp_tx_sw:
f5b9a1cde0a26c Wei Fang     2025-08-29  969  	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
9c699a8f3b273c Martyn Welch 2024-09-12  970  
41514737ecaa60 Y.b. Lu      2019-05-23  971  	return 0;
41514737ecaa60 Y.b. Lu      2019-05-23  972  }
41514737ecaa60 Y.b. Lu      2019-05-23  973  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

