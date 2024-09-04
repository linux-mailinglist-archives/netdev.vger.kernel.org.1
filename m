Return-Path: <netdev+bounces-124774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098FC96ADC6
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 03:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B601C285527
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 01:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AF9522F;
	Wed,  4 Sep 2024 01:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dbPlwnZp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1367228F1
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 01:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413031; cv=none; b=OTW0BE8FjuSOux4KTqQNkp5KgZ+80KGb6oa4T+5//h8230ijoUXGBVMzYWcnM9cQx2Cjzh13iy7FXNKEIfhw6ySfWkAafFo6CsGJEV0XQLtHIQHIqP1Bo8VwsG/euZI91+hUeVRGrbCsbQ1YFROen93mpVUv7Pkuf7T3Yp+3FfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413031; c=relaxed/simple;
	bh=ytbajlfPRQIsxRp3bqycC3PNNPUn4VnChiTQykosmko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYT78vBNz5pcRbicaX0By/P3jxDvsEuzQ7LaJptiZ10wPyjbQ8DcE0XjiLHBh1ghkSwDA3mRntFq4clMgM8EpPfXd2QFS6u005HfGQWiTWnnX56/s0KEGNXAbnYxjUYciQ6tu/BUZDUmUUihCh7dc00/ybUXxXgsI7M8kut6lUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dbPlwnZp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725413028; x=1756949028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ytbajlfPRQIsxRp3bqycC3PNNPUn4VnChiTQykosmko=;
  b=dbPlwnZpsoAtjtDwZvEFjIK4zcdDapsI7Z5SUHTLi3097onA+8Zd4eNs
   yomb6vBdBbbH2Jhf+Jlsf9X+ASlG5ezNi3QeiHb20i88Miv4LjJtujiVW
   UKbyHRPvrqjrP9LGsr9nyr2zvtZHHPqDEIMb2R+bMVLqzhuoe/2EDpQDP
   a0HUfZVIORRYPIEAXBuYY7jyXd0DAiNktxXHaMRhkTlO5r8Kn3yniZaVJ
   H0Eh6pxx6pmQBwYPxWRT8tYw1iAqU9TppEXPW2Qp+c6Gxf+q8sICBGgW6
   tgzAGx/pjuMDCWONQYVRXL6Zx7WRaX6+pBAcJitLMKeoYOUa74nZcxyQw
   w==;
X-CSE-ConnectionGUID: 53RvMl2oStGpDu/u6gtSKA==
X-CSE-MsgGUID: cai7guZITducneOgrN08KQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="26960891"
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="26960891"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 18:23:47 -0700
X-CSE-ConnectionGUID: hX+LpildTzO+r08PYUUHuw==
X-CSE-MsgGUID: 62T6M5JbSM2WIObAlECFVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="102509598"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 03 Sep 2024 18:23:43 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slekH-0007PY-0h;
	Wed, 04 Sep 2024 01:23:41 +0000
Date: Wed, 4 Sep 2024 09:22:48 +0800
From: kernel test robot <lkp@intel.com>
To: Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Erez Shitrit <erezsh@nvidia.com>
Subject: Re: [net-next 15/15] net/mlx5: HWS, added API and enabled HWS support
Message-ID: <202409040845.XQQRrH9v-lkp@intel.com>
References: <20240903031948.78006-16-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903031948.78006-16-saeed@kernel.org>

Hi Saeed,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Saeed-Mahameed/net-mlx5-Added-missing-definitions-in-preparation-for-HW-Steering/20240903-121951
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240903031948.78006-16-saeed%40kernel.org
patch subject: [net-next 15/15] net/mlx5: HWS, added API and enabled HWS support
config: i386-randconfig-063-20240903 (https://download.01.org/0day-ci/archive/20240904/202409040845.XQQRrH9v-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240904/202409040845.XQQRrH9v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409040845.XQQRrH9v-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.c:119:30: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.c:119:30: sparse: sparse: cast from restricted __be64
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.c:120:30: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.c:120:30: sparse: sparse: cast from restricted __be64
--
>> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:516:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:516:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:516:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:517:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:517:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:517:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:518:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:518:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:518:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:672:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:672:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:672:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:673:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:673:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:673:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:674:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:674:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:674:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:834:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:834:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:834:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:835:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:835:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:835:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:836:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:836:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:836:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:837:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:837:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:837:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:838:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:838:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:838:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:839:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:839:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:839:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:840:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:840:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:840:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:846:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:846:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:846:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1031:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1031:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1031:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1032:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1032:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1032:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1033:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1033:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1033:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1105:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1105:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1105:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1106:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1106:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1106:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1107:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1107:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1107:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1108:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1108:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1108:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1336:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1336:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1336:13: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1386:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] res @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1386:13: sparse:     expected unsigned int [usertype] res
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1386:13: sparse:     got restricted __be32 [usertype]
>> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1783:58: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1795:52: sparse: sparse: cast to restricted __be32
--
>> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c:1117:14: sparse: sparse: cast from restricted __be32
>> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c:1117:14: sparse: sparse: restricted __be32 degrades to integer
--
>> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:41:12: sparse: sparse: symbol 'mlx5hws_action_type_str' was not declared. Should it be static?
>> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:1562:54: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:1562:54: sparse:     expected unsigned int [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:1562:54: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:1765:54: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:1765:54: sparse:     expected unsigned int [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:1765:54: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:1766:54: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:1766:54: sparse:     expected unsigned int [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:1766:54: sparse:     got restricted __be32 [usertype]
>> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2165:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] vlan_hdr @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2165:52: sparse:     expected unsigned int [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2165:52: sparse:     got restricted __be32 [usertype] vlan_hdr
>> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2183:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] stc_idx @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2183:17: sparse:     expected unsigned int [usertype] stc_idx
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2183:17: sparse:     got restricted __be32 [usertype]
>> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2184:61: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 @@     got unsigned int [usertype] stc_idx @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2184:61: sparse:     expected restricted __be32
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2184:61: sparse:     got unsigned int [usertype] stc_idx
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2203:60: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2203:60: sparse:     expected unsigned int [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2203:60: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2210:60: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2210:60: sparse:     expected unsigned int [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2210:60: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2239:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2239:52: sparse:     expected unsigned int [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2239:52: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2241:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] stc_idx @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2241:17: sparse:     expected unsigned int [usertype] stc_idx
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2241:17: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2242:61: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 @@     got unsigned int [usertype] stc_idx @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2242:61: sparse:     expected restricted __be32
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2242:61: sparse:     got unsigned int [usertype] stc_idx
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2270:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2270:52: sparse:     expected unsigned int [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2270:52: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2272:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] stc_idx @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2272:17: sparse:     expected unsigned int [usertype] stc_idx
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2272:17: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2273:61: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 @@     got unsigned int [usertype] stc_idx @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2273:61: sparse:     expected restricted __be32
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2273:61: sparse:     got unsigned int [usertype] stc_idx
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2312:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2312:52: sparse:     expected unsigned int [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2312:52: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2313:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2313:52: sparse:     expected unsigned int [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2313:52: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2326:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2326:52: sparse:     expected unsigned int [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2326:52: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2337:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2337:52: sparse:     expected unsigned int [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2337:52: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2380:56: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2380:56: sparse:     expected unsigned int [usertype]
   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c:2380:56: sparse:     got restricted __be32 [usertype]
--
>> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_cmd.c:9:16: sparse: sparse: cast to restricted __be32

vim +119 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.c

fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02   98  
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02   99  static bool mlx5hws_pat_compare_pattern(int cur_num_of_actions,
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  100  					__be64 cur_actions[],
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  101  					int num_of_actions,
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  102  					__be64 actions[])
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  103  {
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  104  	int i;
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  105  
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  106  	if (cur_num_of_actions != num_of_actions)
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  107  		return false;
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  108  
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  109  	for (i = 0; i < num_of_actions; i++) {
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  110  		u8 action_id =
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  111  			MLX5_GET(set_action_in, &actions[i], action_type);
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  112  
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  113  		if (action_id == MLX5_MODIFICATION_TYPE_COPY ||
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  114  		    action_id == MLX5_MODIFICATION_TYPE_ADD_FIELD) {
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  115  			if (actions[i] != cur_actions[i])
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  116  				return false;
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  117  		} else {
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  118  			/* Compare just the control, not the values */
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02 @119  			if ((__be32)actions[i] !=
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  120  			    (__be32)cur_actions[i])
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  121  				return false;
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  122  		}
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  123  	}
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  124  
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  125  	return true;
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  126  }
fb3c1a8b875d02 Yevgeny Kliteynik 2024-09-02  127  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

