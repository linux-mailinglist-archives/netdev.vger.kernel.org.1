Return-Path: <netdev+bounces-125850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DAF96EF05
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4551C220B7
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877EC1C7B9F;
	Fri,  6 Sep 2024 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9D6y35q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FD31C7B7E;
	Fri,  6 Sep 2024 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614584; cv=none; b=Jm/NfGn1BRJGrERoQw+iQm6rVSkJLgAnL/ST+2ej7OwDx7e6Mv4zSGFnP4WCLV0p7tL1B8ljc4xlIo8Q4pgvKNtIF6v6HWNwLCLtlwS61OAKqCzj2DbfJZWClA4ipjjc1LAdWfPbLqPieU5Ka8ui90ESKXakmQaIJXVy4WGs6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614584; c=relaxed/simple;
	bh=x6shILPiw+s+HzuV5rd+G3Nn5q8gSaTLiklStUFDP+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjQJcvAY+cG1fpjKtph6cHDmo9jf7RM96J2pXPd2v2tz9/EtICNNQVQm7z4QsCN4lM+ZHcX0i1TH3/ZjUNznPTITEytTcM77u/R6ITxiJOa62XGBd6VqDrfCHmWRnqjPzxPKjB4i7xis5DkCxk8ATLHITuiYrc3lTDrBqumNwMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9D6y35q; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725614583; x=1757150583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x6shILPiw+s+HzuV5rd+G3Nn5q8gSaTLiklStUFDP+o=;
  b=h9D6y35qK7gXcLK6+HjwbwPY3e3Cy36KrOAy7aLYn98ynjRlG36VgkmT
   HjqaMTDdpc4L7PCFhabCZtcC+1sa9jdslqQumPbiXHV+DA+Tke1ZEcUMq
   Jb04u3HYjLDE68IzWVkSUiGKY4z+OV5rT/giWr1jVFUqKe3sk5V+XVeOO
   vB5DxQXXd8GVTXZo+jeoiNjjTv9iWy/bpnhVhx5eR1kfG34qgebSmghn4
   tqKJHfGJ1GLErKhBSOddpG81Z6TIaPOJUM1RKlVqzURkAwa6IH+0eayCz
   3nKriX4SK7zQc8bTtc+xlFoGBqM4Xd7J8uIZt5DIPWjdZgZ0Ceb6UBw2K
   Q==;
X-CSE-ConnectionGUID: F9v4yg2UTWeQQcrjZfF+sg==
X-CSE-MsgGUID: kMIVThQ2Rk6Dg6NtDSUPZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="35718900"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="35718900"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 02:23:02 -0700
X-CSE-ConnectionGUID: 7AlpJc3iSsWv2kHlbJKHBg==
X-CSE-MsgGUID: 0ycuWGMvT0yZfdj1UOXuLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="70483542"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 06 Sep 2024 02:22:58 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smVB9-000Aud-0i;
	Fri, 06 Sep 2024 09:22:55 +0000
Date: Fri, 6 Sep 2024 17:22:29 +0800
From: kernel test robot <lkp@intel.com>
To: MD Danish Anwar <danishanwar@ti.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
	Dan Carpenter <error27@gmail.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net-next v4 3/5] net: ti: icssg-prueth: Add support for
 HSR frame forward offload
Message-ID: <202409061658.vSwcFJiK-lkp@intel.com>
References: <20240904100506.3665892-4-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904100506.3665892-4-danishanwar@ti.com>

Hi MD,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 075e3d30e4a3da8eadd12f2f063dc8e2ea9e1f08]

url:    https://github.com/intel-lab-lkp/linux/commits/MD-Danish-Anwar/net-ti-icss-iep-Move-icss_iep-structure/20240904-180917
base:   075e3d30e4a3da8eadd12f2f063dc8e2ea9e1f08
patch link:    https://lore.kernel.org/r/20240904100506.3665892-4-danishanwar%40ti.com
patch subject: [PATCH net-next v4 3/5] net: ti: icssg-prueth: Add support for HSR frame forward offload
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240906/202409061658.vSwcFJiK-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240906/202409061658.vSwcFJiK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409061658.vSwcFJiK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/ti/icssg/icssg_prueth.c: In function 'emac_ndo_set_features':
>> drivers/net/ethernet/ti/icssg/icssg_prueth.c:765:24: warning: unused variable 'prueth' [-Wunused-variable]
     765 |         struct prueth *prueth = emac->prueth;
         |                        ^~~~~~


vim +/prueth +765 drivers/net/ethernet/ti/icssg/icssg_prueth.c

   760	
   761	static int emac_ndo_set_features(struct net_device *ndev,
   762					 netdev_features_t features)
   763	{
   764		struct prueth_emac *emac = netdev_priv(ndev);
 > 765		struct prueth *prueth = emac->prueth;
   766	
   767		emac_change_hsr_feature(ndev, features, NETIF_F_HW_HSR_FWD);
   768		emac_change_hsr_feature(ndev, features, NETIF_F_HW_HSR_DUP);
   769		emac_change_hsr_feature(ndev, features, NETIF_F_HW_HSR_TAG_INS);
   770		emac_change_hsr_feature(ndev, features, NETIF_F_HW_HSR_TAG_RM);
   771	
   772		return 0;
   773	}
   774	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

