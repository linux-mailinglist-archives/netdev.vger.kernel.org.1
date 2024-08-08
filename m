Return-Path: <netdev+bounces-116637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 431B894B445
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 02:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7005C1C219C0
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 00:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9108D4A2D;
	Thu,  8 Aug 2024 00:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IhodNeVS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7BC2C95;
	Thu,  8 Aug 2024 00:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723077808; cv=none; b=o6dHGwLIJ59McX/ousi4PMR18EVBTRhzU1Hd4hZhUr5AzVxu/w5ONm9kQ9JydIu2cIHXGWDiN94Y83Yt1uofSNdfx8faTmVD8XR0yJvKW5GCGiVjL4gWA2TvW4Cpa50pwUqkpk4nGxv9S8Hwl222t5UdNCzk9QPiwX2amiTcVOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723077808; c=relaxed/simple;
	bh=feWacHYaPnIbpAOajEpd3LHUQ+7MZKIahPasyzDrR1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzoFXw1dIvoBSyqlb5P7q5WCKaVfZAzKG73wPdu28LI10hkelEcMpX+Qm4lZV69Vdxsg7HagJs+cwNmp5IodHaApHGVmRKFHBBs0wWEc6BpL6x1wytQ1gqWI98XgW30rFn4cZR4ObbTV1G9rnKZfPDTQK+l3rMO3PFoaCZ2RfN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IhodNeVS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723077806; x=1754613806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=feWacHYaPnIbpAOajEpd3LHUQ+7MZKIahPasyzDrR1o=;
  b=IhodNeVSfcwSP00eBL6MCvP8TfsZhqeMNv3yjpbvCabLFf3PuOh/xc1w
   VmlzKO7L0PKjdyDvmRGCOXsvZcAXwgqoVem1CLAf2LsI1MTE+BftXqAVw
   ZgrqGp/s2LnT6J+eb9Cq0e495/8CUtKkyqXHollMLHOD06Yhs0+mYWsD5
   UoCX56p5V/N84GW37eNEz9BxEghoa9p8w4gNdGKEjyCIfXgQAYh1jNwVr
   xgCBBa5qGq1rOXUO7l+km+30KbUJq+LOtOZsnhXtPKrvsFKZeOmlQl4S+
   nX/uEIPGDS+yiJUAVmSAhj8eJi33k9B61c1D6z2VcGgfVhg7+Gl0s0oeP
   Q==;
X-CSE-ConnectionGUID: jesNHD88QTi1Yep/5sEUWw==
X-CSE-MsgGUID: 42gH53z9SIGT4DS/XBtKEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="20844369"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="20844369"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 17:43:26 -0700
X-CSE-ConnectionGUID: YJCq9+jkTTaPj1f0roGVpQ==
X-CSE-MsgGUID: oWQmbrKORhWLZQIh8ShSbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="57003374"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 07 Aug 2024 17:43:23 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbrFQ-0005p4-2p;
	Thu, 08 Aug 2024 00:43:20 +0000
Date: Thu, 8 Aug 2024 08:42:28 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next] net: ibm/emac: Constify struct mii_phy_def
Message-ID: <202408080850.QKqTbf5o-lkp@intel.com>
References: <dfc7876d660d700a840e64c35de0a6519e117539.1723031352.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfc7876d660d700a840e64c35de0a6519e117539.1723031352.git.christophe.jaillet@wanadoo.fr>

Hi Christophe,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-JAILLET/net-ibm-emac-Constify-struct-mii_phy_def/20240807-195146
base:   net-next/main
patch link:    https://lore.kernel.org/r/dfc7876d660d700a840e64c35de0a6519e117539.1723031352.git.christophe.jaillet%40wanadoo.fr
patch subject: [PATCH net-next] net: ibm/emac: Constify struct mii_phy_def
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20240808/202408080850.QKqTbf5o-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408080850.QKqTbf5o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408080850.QKqTbf5o-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/ibm/emac/core.c:28:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/powerpc/include/asm/io.h:24:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/ibm/emac/core.c:2648:23: error: cannot assign to non-static data member 'def' with const-qualified type 'const struct mii_phy_def *'
    2648 |         dev->phy.def->phy_id = dev->phy_dev->drv->phy_id;
         |         ~~~~~~~~~~~~~~~~~~~~ ^
   drivers/net/ethernet/ibm/emac/phy.h:50:28: note: non-static data member 'def' declared const here
      50 |         const struct mii_phy_def *def;
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/net/ethernet/ibm/emac/core.c:2649:28: error: cannot assign to non-static data member 'def' with const-qualified type 'const struct mii_phy_def *'
    2649 |         dev->phy.def->phy_id_mask = dev->phy_dev->drv->phy_id_mask;
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~ ^
   drivers/net/ethernet/ibm/emac/phy.h:50:28: note: non-static data member 'def' declared const here
      50 |         const struct mii_phy_def *def;
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/net/ethernet/ibm/emac/core.c:2650:21: error: cannot assign to non-static data member 'def' with const-qualified type 'const struct mii_phy_def *'
    2650 |         dev->phy.def->name = dev->phy_dev->drv->name;
         |         ~~~~~~~~~~~~~~~~~~ ^
   drivers/net/ethernet/ibm/emac/phy.h:50:28: note: non-static data member 'def' declared const here
      50 |         const struct mii_phy_def *def;
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/net/ethernet/ibm/emac/core.c:2651:20: error: cannot assign to non-static data member 'def' with const-qualified type 'const struct mii_phy_def *'
    2651 |         dev->phy.def->ops = &emac_dt_mdio_phy_ops;
         |         ~~~~~~~~~~~~~~~~~ ^
   drivers/net/ethernet/ibm/emac/phy.h:50:28: note: non-static data member 'def' declared const here
      50 |         const struct mii_phy_def *def;
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/net/ethernet/ibm/emac/core.c:2818:25: error: cannot assign to non-static data member 'def' with const-qualified type 'const struct mii_phy_def *'
    2818 |         dev->phy.def->features &= ~dev->phy_feat_exc;
         |         ~~~~~~~~~~~~~~~~~~~~~~ ^
   drivers/net/ethernet/ibm/emac/phy.h:50:28: note: non-static data member 'def' declared const here
      50 |         const struct mii_phy_def *def;
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   5 warnings and 5 errors generated.


vim +2648 drivers/net/ethernet/ibm/emac/core.c

a577ca6badb526 Christian Lamparter 2017-02-20  2632  
a577ca6badb526 Christian Lamparter 2017-02-20  2633  static int emac_dt_phy_connect(struct emac_instance *dev,
a577ca6badb526 Christian Lamparter 2017-02-20  2634  			       struct device_node *phy_handle)
a577ca6badb526 Christian Lamparter 2017-02-20  2635  {
a577ca6badb526 Christian Lamparter 2017-02-20  2636  	dev->phy.def = devm_kzalloc(&dev->ofdev->dev, sizeof(*dev->phy.def),
a577ca6badb526 Christian Lamparter 2017-02-20  2637  				    GFP_KERNEL);
a577ca6badb526 Christian Lamparter 2017-02-20  2638  	if (!dev->phy.def)
a577ca6badb526 Christian Lamparter 2017-02-20  2639  		return -ENOMEM;
a577ca6badb526 Christian Lamparter 2017-02-20  2640  
a577ca6badb526 Christian Lamparter 2017-02-20  2641  	dev->phy_dev = of_phy_connect(dev->ndev, phy_handle, &emac_adjust_link,
a577ca6badb526 Christian Lamparter 2017-02-20  2642  				      0, dev->phy_mode);
a577ca6badb526 Christian Lamparter 2017-02-20  2643  	if (!dev->phy_dev) {
a577ca6badb526 Christian Lamparter 2017-02-20  2644  		dev_err(&dev->ofdev->dev, "failed to connect to PHY.\n");
a577ca6badb526 Christian Lamparter 2017-02-20  2645  		return -ENODEV;
a577ca6badb526 Christian Lamparter 2017-02-20  2646  	}
a577ca6badb526 Christian Lamparter 2017-02-20  2647  
a577ca6badb526 Christian Lamparter 2017-02-20 @2648  	dev->phy.def->phy_id = dev->phy_dev->drv->phy_id;
a577ca6badb526 Christian Lamparter 2017-02-20  2649  	dev->phy.def->phy_id_mask = dev->phy_dev->drv->phy_id_mask;
a577ca6badb526 Christian Lamparter 2017-02-20  2650  	dev->phy.def->name = dev->phy_dev->drv->name;
a577ca6badb526 Christian Lamparter 2017-02-20  2651  	dev->phy.def->ops = &emac_dt_mdio_phy_ops;
3c1bcc8614db10 Andrew Lunn         2018-11-10  2652  	ethtool_convert_link_mode_to_legacy_u32(&dev->phy.features,
3c1bcc8614db10 Andrew Lunn         2018-11-10  2653  						dev->phy_dev->supported);
a577ca6badb526 Christian Lamparter 2017-02-20  2654  	dev->phy.address = dev->phy_dev->mdio.addr;
a577ca6badb526 Christian Lamparter 2017-02-20  2655  	dev->phy.mode = dev->phy_dev->interface;
a577ca6badb526 Christian Lamparter 2017-02-20  2656  	return 0;
a577ca6badb526 Christian Lamparter 2017-02-20  2657  }
a577ca6badb526 Christian Lamparter 2017-02-20  2658  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

