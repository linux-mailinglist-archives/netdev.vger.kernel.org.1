Return-Path: <netdev+bounces-179371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B04A7C291
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 19:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90D83BA2B5
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 17:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D347E21D3C7;
	Fri,  4 Apr 2025 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zpdiks8W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FA921C171;
	Fri,  4 Apr 2025 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788158; cv=none; b=fZwAIfKF9pYOMUA98OBmMozBEK0rtW3tRLzpWJ8D/XO+oH4hNP5IXjgiix1wE3Cwg7E8zSnsH9ThtOA6oW8ETNWxRH57yeSOVkB3s6UTioltDsq5w+Wf5Ht70s4zSpLzoGh+xjSCbv/nhBvqkVZtnznRrAb/sQLk/gSrODB6RvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788158; c=relaxed/simple;
	bh=Tj/HfVjqdh8faGcHAlLbM5/fJtNdbkBrRoiq+2QW0Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmuUJprg5kzyiA+H9xXY048cxWVrT0Mv66dHkIbFXPcbYsXGhD6b3SKQ3GJTT4Us+iMHKVH8eRxfGUqFl/CLoaol43eCSXyvNebekMJvxeq6uBllv8cXxn4x2JBV1THqK4R4Qb3YeyjjegxWGzlTWglxWnVD6mK6jiqHfcDDDyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zpdiks8W; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743788150; x=1775324150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tj/HfVjqdh8faGcHAlLbM5/fJtNdbkBrRoiq+2QW0Ps=;
  b=Zpdiks8W7+R+O8leVL3uxHvNZg5Y4tEiSdXZlBBBJVRgElym0R0UlCQR
   YVnwp5YwkHrPsjVG5RZg1shmpwOW4F03WUbTTWfmUGNBa/H6HITNKPrcA
   p3da/MJIODHwhkeWqM1Ec6TU4cPWxTblZqWmhvB/zFE9bXFhnb5r9T/ty
   Dr0ekfKUPT6xR2dH6JDUXbOflnaQTbQf8/5UKDdr2JLm8QLpRxbrE2yWF
   eOJdBjfi1AEgDkA6CtmHFYSNmYYmMevmENkzOMhZMisTj12pM0mpNaPfn
   dSLTLIX452c1Do4/2OhynNSLfxtEMO6BQA/0L4rDDT+SN4j8fZj6QqRKE
   w==;
X-CSE-ConnectionGUID: c+1si+5uQ1OQbCgxdpUcpg==
X-CSE-MsgGUID: jx0lihhIS7GJ+BrAip9gYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="45140695"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="45140695"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 10:35:49 -0700
X-CSE-ConnectionGUID: 53fwTgKvTvmRLYdCdRTTTA==
X-CSE-MsgGUID: DAaf8C44RgyeCvVKTvQkdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="127855345"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 04 Apr 2025 10:35:46 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u0kxE-0001QV-0a;
	Fri, 04 Apr 2025 17:35:44 +0000
Date: Sat, 5 Apr 2025 01:35:00 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>
Subject: Re: [PATCH] octeontx2-pf:  Add error handling for
 cn10k_map_unmap_rq_policer().
Message-ID: <202504050157.qdVzTVMM-lkp@intel.com>
References: <20250403151303.2280-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403151303.2280-1-vulab@iscas.ac.cn>

Hi Wentao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.14 next-20250404]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/octeontx2-pf-Add-error-handling-for-cn10k_map_unmap_rq_policer/20250403-231435
base:   linus/master
patch link:    https://lore.kernel.org/r/20250403151303.2280-1-vulab%40iscas.ac.cn
patch subject: [PATCH] octeontx2-pf:  Add error handling for cn10k_map_unmap_rq_policer().
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20250405/202504050157.qdVzTVMM-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250405/202504050157.qdVzTVMM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504050157.qdVzTVMM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c: In function 'cn10k_free_matchall_ipolicer':
>> drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c:360:9: warning: this 'for' clause does not guard... [-Wmisleading-indentation]
     360 |         for (qidx = 0; qidx < hw->rx_queues; qidx++)
         |         ^~~
   drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c:362:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'for'
     362 |                 if (rc)
         |                 ^~


vim +/for +360 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c

2ca89a2c375272 Sunil Goutham 2021-06-15  351  
2ca89a2c375272 Sunil Goutham 2021-06-15  352  int cn10k_free_matchall_ipolicer(struct otx2_nic *pfvf)
2ca89a2c375272 Sunil Goutham 2021-06-15  353  {
2ca89a2c375272 Sunil Goutham 2021-06-15  354  	struct otx2_hw *hw = &pfvf->hw;
2ca89a2c375272 Sunil Goutham 2021-06-15  355  	int qidx, rc;
2ca89a2c375272 Sunil Goutham 2021-06-15  356  
2ca89a2c375272 Sunil Goutham 2021-06-15  357  	mutex_lock(&pfvf->mbox.lock);
2ca89a2c375272 Sunil Goutham 2021-06-15  358  
2ca89a2c375272 Sunil Goutham 2021-06-15  359  	/* Remove RQ's policer mapping */
2ca89a2c375272 Sunil Goutham 2021-06-15 @360  	for (qidx = 0; qidx < hw->rx_queues; qidx++)
d85bdae93e8dbe Wentao Liang  2025-04-03  361  		rc = cn10k_map_unmap_rq_policer(pfvf, qidx, hw->matchall_ipolicer, false);
d85bdae93e8dbe Wentao Liang  2025-04-03  362  		if (rc)
d85bdae93e8dbe Wentao Liang  2025-04-03  363  			goto out;
2ca89a2c375272 Sunil Goutham 2021-06-15  364  
2ca89a2c375272 Sunil Goutham 2021-06-15  365  	rc = cn10k_free_leaf_profile(pfvf, hw->matchall_ipolicer);
2ca89a2c375272 Sunil Goutham 2021-06-15  366  
d85bdae93e8dbe Wentao Liang  2025-04-03  367  out:
2ca89a2c375272 Sunil Goutham 2021-06-15  368  	mutex_unlock(&pfvf->mbox.lock);
2ca89a2c375272 Sunil Goutham 2021-06-15  369  	return rc;
2ca89a2c375272 Sunil Goutham 2021-06-15  370  }
2ca89a2c375272 Sunil Goutham 2021-06-15  371  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

