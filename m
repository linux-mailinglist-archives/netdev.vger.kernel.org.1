Return-Path: <netdev+bounces-130778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFEF98B7ED
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5055AB26269
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E762419D08C;
	Tue,  1 Oct 2024 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4xOF5sK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3624F19CC0A;
	Tue,  1 Oct 2024 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773628; cv=none; b=Q2QO01XQxG8N3p9z8y+bvhT9LcyFlmcDlT0LPlYmdNlGnZII9ANj4fkn5Mbvhh92WXyaH6qVkjO30ZbjQ+XE6szZtA5Ur6fJdTH39ob8hvlMUIodwD4H5ZwdJzhTm1aqHrQJ/SeNnbNYCxJEHw2zh/9lWkXOnYZa+KLRnlOnC+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773628; c=relaxed/simple;
	bh=m97NaR/uwM/LoByNr7jk1ak8+1faMfudA3HDDJa1jBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akcaOcV28nO9iEQTb/RUIv16kcgq+TSe/Wc1sUoaUP2ue+c1kY8SUggqsJOwX2XTgKEgfr5wuEi8kzWmrJORnwGlAMnpJwiWexmoBxmeh5NHQIdIRQLn5wqaNQo4yCPIACCAwAPOIuZdnRuRwxDrTI3oLfFIAdEr/rLfw2K7Qpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4xOF5sK; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727773627; x=1759309627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m97NaR/uwM/LoByNr7jk1ak8+1faMfudA3HDDJa1jBQ=;
  b=i4xOF5sKEcVbFekmdnCSMR+cnRPA4hmKBdS9JZCe6V1tp+wKRs9VI2eO
   PxeBU/c2Pz9TWdoCc5VO0qocXtkR1Pm9sHTH3q6fF9cRJKLm+nTRdSgcP
   SuXEkzRg6mU62sLxqk0SCTuoUfZJxyxL8J53iHPWMR3tMCsUojjba4sEt
   Q6Gxy4d2nbgIPi69O5GAk2npEVgwmYITSuv8zig7ztYuuAD3qjwtuWo06
   cRw5lmSz7GPA/HOKKp1XSz5ziwmOFvNAOB+E3jlUPYWF8GpbFuLM5gH94
   rYUYdhe2SG3y5sN+xqWidsfQ+MsPz08Uaj2zvuSjx0vYBIvT9Yb0trWJj
   A==;
X-CSE-ConnectionGUID: Jtgvw55ARa6cvlUvdSfq1w==
X-CSE-MsgGUID: N7RX5xitS9u3byBQpSk4lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="52306003"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="52306003"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 02:07:07 -0700
X-CSE-ConnectionGUID: ojDeIRRCQy6cXbvKsd4T0g==
X-CSE-MsgGUID: N/BxBTXLSmyOMZi+tRyimQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73564062"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 01 Oct 2024 02:07:03 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svYqT-000QU9-0V;
	Tue, 01 Oct 2024 09:07:01 +0000
Date: Tue, 1 Oct 2024 17:06:18 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
	chunkeey@gmail.com
Subject: Re: [PATCH net-next 09/13] net: ibm: emac: rgmii:
 devm_platform_get_resource
Message-ID: <202410011626.D4gEmLU8-lkp@intel.com>
References: <20240930180036.87598-10-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930180036.87598-10-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-ibm-emac-remove-custom-init-exit-functions/20241001-020553
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240930180036.87598-10-rosenp%40gmail.com
patch subject: [PATCH net-next 09/13] net: ibm: emac: rgmii: devm_platform_get_resource
config: powerpc-canyonlands_defconfig (https://download.01.org/0day-ci/archive/20241001/202410011626.D4gEmLU8-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241001/202410011626.D4gEmLU8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410011626.D4gEmLU8-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/ibm/emac/rgmii.c:21:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/powerpc/include/asm/cacheflush.h:7:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/net/ethernet/ibm/emac/rgmii.c:229:14: error: call to undeclared function 'devm_platform_get_resource'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     229 |         dev->base = devm_platform_get_resource(ofdev, 0);
         |                     ^
   drivers/net/ethernet/ibm/emac/rgmii.c:229:14: note: did you mean 'platform_get_resource'?
   include/linux/platform_device.h:58:25: note: 'platform_get_resource' declared here
      58 | extern struct resource *platform_get_resource(struct platform_device *,
         |                         ^
>> drivers/net/ethernet/ibm/emac/rgmii.c:229:12: error: incompatible integer to pointer conversion assigning to 'struct rgmii_regs *' from 'int' [-Wint-conversion]
     229 |         dev->base = devm_platform_get_resource(ofdev, 0);
         |                   ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 2 errors generated.


vim +/devm_platform_get_resource +229 drivers/net/ethernet/ibm/emac/rgmii.c

   215	
   216	
   217	static int rgmii_probe(struct platform_device *ofdev)
   218	{
   219		struct rgmii_instance *dev;
   220	
   221		dev = devm_kzalloc(&ofdev->dev, sizeof(struct rgmii_instance),
   222				   GFP_KERNEL);
   223		if (!dev)
   224			return -ENOMEM;
   225	
   226		mutex_init(&dev->lock);
   227		dev->ofdev = ofdev;
   228	
 > 229		dev->base = devm_platform_get_resource(ofdev, 0);
   230		if (IS_ERR(dev->base)) {
   231			dev_err(&ofdev->dev, "can't map device registers");
   232			return PTR_ERR(dev->base);
   233		}
   234	
   235		/* Check for RGMII flags */
   236		if (of_property_read_bool(ofdev->dev.of_node, "has-mdio"))
   237			dev->flags |= EMAC_RGMII_FLAG_HAS_MDIO;
   238	
   239		/* CAB lacks the right properties, fix this up */
   240		if (of_device_is_compatible(ofdev->dev.of_node, "ibm,rgmii-axon"))
   241			dev->flags |= EMAC_RGMII_FLAG_HAS_MDIO;
   242	
   243		DBG2(dev, " Boot FER = 0x%08x, SSR = 0x%08x\n",
   244		     in_be32(&dev->base->fer), in_be32(&dev->base->ssr));
   245	
   246		/* Disable all inputs by default */
   247		out_be32(&dev->base->fer, 0);
   248	
   249		printk(KERN_INFO
   250		       "RGMII %pOF initialized with%s MDIO support\n",
   251		       ofdev->dev.of_node,
   252		       (dev->flags & EMAC_RGMII_FLAG_HAS_MDIO) ? "" : "out");
   253	
   254		wmb();
   255		platform_set_drvdata(ofdev, dev);
   256	
   257		return 0;
   258	}
   259	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

