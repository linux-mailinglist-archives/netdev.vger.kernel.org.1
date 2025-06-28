Return-Path: <netdev+bounces-202195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF61DAEC985
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 19:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D5617D87D
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 17:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAA62417C2;
	Sat, 28 Jun 2025 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EljnOWkB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36201C8626;
	Sat, 28 Jun 2025 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751132634; cv=none; b=i/li/ewEs5lD01ZyB9lgQFHZ7wouRN8363z+u7TlG3I07Og544EgrGBXG/DWmL5mAXdj373tgCdf0Y2jdSpS+S7ijO00hmZ70JDU3PojfXRl1mg6L6KoXvR5Cfun3eKWCWd+4M5gjogITzEKuS57cQg5wSm0KzJjIZr7PdFTp48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751132634; c=relaxed/simple;
	bh=rJAICa0SpONfxMWg8HAFuYCuf5lAPXPGhxYxcfrSeAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohn2e2LQOV3r6SSYf4/fUDYjDvkK5FZ8a8aYc7zS/Qhdq+nQYEjnqRtZLvk0q8WZ0J6LTdN5cJL5jZZvhCAw8u3jUDE78ZWB4MNYSZb8q6zF84dKRMC6jZEFwsiez/XdXs3pKg5EknS2zFStM1Xjp4J7yCUxilvXNL1+W4PRUYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EljnOWkB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751132633; x=1782668633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rJAICa0SpONfxMWg8HAFuYCuf5lAPXPGhxYxcfrSeAE=;
  b=EljnOWkBLfcGlvfESdrNVxyXrZ430ZLfI+FDSXP1dBlP/YmHUpG+aRwf
   fmMG2a13K3yDwWEilpBVB5Y3zC6kYFhmZf8qmW8KfrggrXRT1vTPIgDM6
   8pQ7UTV6AUZuhNZIeeM7vrCTHsYAVOT5LAvYKSXIU+T4czeORoaK05n4X
   wusr2df2y8En/CS7lzfi/B3x3BLh4gVRN3kCRYZzzyTvg8hiLNkrfMy/i
   13Mrth7rCXVrM2v93tjrtR/O7Uv5WIRSOY4CIGuINvv5ppOqWJENMnRhL
   hE7vcCrrvNi3vZPdd+ny9MtYGvTQTCk9UgYBC+fcqzd4Cef9rfXFwqrnj
   w==;
X-CSE-ConnectionGUID: r5kKxVl0SNGOr0o5qioHVw==
X-CSE-MsgGUID: LG7VLBuxSnWKTEBkScxdYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11478"; a="52533115"
X-IronPort-AV: E=Sophos;i="6.16,273,1744095600"; 
   d="scan'208";a="52533115"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 10:43:52 -0700
X-CSE-ConnectionGUID: Y7B53AP4RP2en1ZOhu5XUw==
X-CSE-MsgGUID: jCKBeIUeQUOo9m98bK3rHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,273,1744095600"; 
   d="scan'208";a="152458874"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 28 Jun 2025 10:43:49 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVZac-000XFm-2e;
	Sat, 28 Jun 2025 17:43:46 +0000
Date: Sun, 29 Jun 2025 01:43:30 +0800
From: kernel test robot <lkp@intel.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, sgoutham@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, alok.a.tiwari@oracle.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: thunderx: avoid direct MTU assignment after
 WRITE_ONCE()
Message-ID: <202506290114.0EPFmc8U-lkp@intel.com>
References: <20250628095221.461991-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628095221.461991-1-alok.a.tiwari@oracle.com>

Hi Alok,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.16-rc3 next-20250627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alok-Tiwari/net-thunderx-avoid-direct-MTU-assignment-after-WRITE_ONCE/20250628-175420
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250628095221.461991-1-alok.a.tiwari%40oracle.com
patch subject: [PATCH] net: thunderx: avoid direct MTU assignment after WRITE_ONCE()
config: x86_64-buildonly-randconfig-006-20250628 (https://download.01.org/0day-ci/archive/20250629/202506290114.0EPFmc8U-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250629/202506290114.0EPFmc8U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506290114.0EPFmc8U-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/cavium/thunder/nicvf_main.c: In function 'nicvf_change_mtu':
>> drivers/net/ethernet/cavium/thunder/nicvf_main.c:1581:13: warning: unused variable 'orig_mtu' [-Wunused-variable]
    1581 |         int orig_mtu = netdev->mtu;
         |             ^~~~~~~~


vim +/orig_mtu +1581 drivers/net/ethernet/cavium/thunder/nicvf_main.c

4863dea3fab0173 Sunil Goutham   2015-05-26  1577  
4863dea3fab0173 Sunil Goutham   2015-05-26  1578  static int nicvf_change_mtu(struct net_device *netdev, int new_mtu)
4863dea3fab0173 Sunil Goutham   2015-05-26  1579  {
4863dea3fab0173 Sunil Goutham   2015-05-26  1580  	struct nicvf *nic = netdev_priv(netdev);
f9aa9dc7d2d00e6 David S. Miller 2016-11-22 @1581  	int orig_mtu = netdev->mtu;
4863dea3fab0173 Sunil Goutham   2015-05-26  1582  
1f227d16083b2e2 Matteo Croce    2019-04-11  1583  	/* For now just support only the usual MTU sized frames,
1f227d16083b2e2 Matteo Croce    2019-04-11  1584  	 * plus some headroom for VLAN, QinQ.
1f227d16083b2e2 Matteo Croce    2019-04-11  1585  	 */
1f227d16083b2e2 Matteo Croce    2019-04-11  1586  	if (nic->xdp_prog && new_mtu > MAX_XDP_MTU) {
1f227d16083b2e2 Matteo Croce    2019-04-11  1587  		netdev_warn(netdev, "Jumbo frames not yet supported with XDP, current MTU %d.\n",
1f227d16083b2e2 Matteo Croce    2019-04-11  1588  			    netdev->mtu);
1f227d16083b2e2 Matteo Croce    2019-04-11  1589  		return -EINVAL;
1f227d16083b2e2 Matteo Croce    2019-04-11  1590  	}
1f227d16083b2e2 Matteo Croce    2019-04-11  1591  
712c3185344050c Sunil Goutham   2016-11-15  1592  
8be8a2ba18f34d5 Alok Tiwari     2025-06-28  1593  	if (!netif_running(netdev)) {
8be8a2ba18f34d5 Alok Tiwari     2025-06-28  1594  		WRITE_ONCE(netdev->mtu, new_mtu);
712c3185344050c Sunil Goutham   2016-11-15  1595  		return 0;
8be8a2ba18f34d5 Alok Tiwari     2025-06-28  1596  	}
712c3185344050c Sunil Goutham   2016-11-15  1597  
f9aa9dc7d2d00e6 David S. Miller 2016-11-22  1598  	if (nicvf_update_hw_max_frs(nic, new_mtu)) {
4863dea3fab0173 Sunil Goutham   2015-05-26  1599  		return -EINVAL;
f9aa9dc7d2d00e6 David S. Miller 2016-11-22  1600  	}
4863dea3fab0173 Sunil Goutham   2015-05-26  1601  
8be8a2ba18f34d5 Alok Tiwari     2025-06-28  1602  	WRITE_ONCE(netdev->mtu, new_mtu);
8be8a2ba18f34d5 Alok Tiwari     2025-06-28  1603  
4863dea3fab0173 Sunil Goutham   2015-05-26  1604  	return 0;
4863dea3fab0173 Sunil Goutham   2015-05-26  1605  }
4863dea3fab0173 Sunil Goutham   2015-05-26  1606  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

