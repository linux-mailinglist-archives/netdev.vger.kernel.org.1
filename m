Return-Path: <netdev+bounces-179374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF1EA7C2CC
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 19:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ABDA17C567
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 17:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A51021C160;
	Fri,  4 Apr 2025 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SNb5Ao3m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307D821C168;
	Fri,  4 Apr 2025 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788825; cv=none; b=kDqzMOMDx6X2+v7NCeiEc+okgTRCygINoYZx+qklSqof4cQRZjv+MBaAwod0s6i3Q0UP5b6+6fTeQRnWO2y/adupdjPbpvBrmBmWY8LLf4+Y09yO3o2HKFjRwzAaQLk3pL9WJmiWsFkm6c5kUZ/Vf3hXwM+TV5/p2JuOr5cO6n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788825; c=relaxed/simple;
	bh=DqN5pxAfN0evYrsHyPi6fbUjjlY9CZ+NWI+PLEjkqtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0FEG/1Tv/7JUorm31nl9CFpQP05dRlF1jYptlK1Ap0TBdVmIlK5Gzov+7b88CCOQzlXexOq5AVxx+kE/FbUGxUcxMQCvDL4nDLm1opJgkjpBiIhA6cNlhcHM5Q85swZkcQflqMD8PNOPCPN0H0m7fE+AwfnmEkw/pltDmKrkRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SNb5Ao3m; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743788822; x=1775324822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DqN5pxAfN0evYrsHyPi6fbUjjlY9CZ+NWI+PLEjkqtw=;
  b=SNb5Ao3m/5Cv1HrCZkTvycl6vigejnOFqzly0SsqP+4WcCTmJnoPI1k+
   ZUDgSJmcV/193ikllRQ/6z06Kb7u4YnEAGN7wE7vORW1Ie/Gmb3Cow1rX
   Wk3/YQ+K3mB/4POOYRO6hEY1JidIbK0AaQL2qw3d6nDhKNCZKVWNDzRw0
   XnexKJWmClLJz7eDSRZydtpXxxckNNab420zaPUQZm9+/34SoNpr42j32
   GqE58URaNsxX42Y4jd+X3sMLRxHhT6+0GSlzfO8Dhi78iLVghYnW9hRDb
   Vud+qQ7nIb7vNVzZua6su6qedf8xhg0CpJvUlwnyM24UtSdD9vRJWw8PB
   g==;
X-CSE-ConnectionGUID: cAuL8keoT8+BSJQpNkngNw==
X-CSE-MsgGUID: wvZIh/roT6W2Xr6zygHLOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="49094800"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="49094800"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 10:46:50 -0700
X-CSE-ConnectionGUID: mYSbDg/qT2irREuKI9oL2w==
X-CSE-MsgGUID: H+Qol/ZkRHOhB/+PniIPHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="132088790"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 04 Apr 2025 10:46:47 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u0l7s-0001Qp-2u;
	Fri, 04 Apr 2025 17:46:44 +0000
Date: Sat, 5 Apr 2025 01:46:11 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: Re: [PATCH] octeontx2-pf:  Add error handling for
 cn10k_map_unmap_rq_policer().
Message-ID: <202504050116.6a4iOEA7-lkp@intel.com>
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
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250405/202504050116.6a4iOEA7-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250405/202504050116.6a4iOEA7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504050116.6a4iOEA7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c:362:3: warning: misleading indentation; statement is not part of the previous 'for' [-Wmisleading-indentation]
     362 |                 if (rc)
         |                 ^
   drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c:360:2: note: previous statement is here
     360 |         for (qidx = 0; qidx < hw->rx_queues; qidx++)
         |         ^
   1 warning generated.


vim +/for +362 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c

   351	
   352	int cn10k_free_matchall_ipolicer(struct otx2_nic *pfvf)
   353	{
   354		struct otx2_hw *hw = &pfvf->hw;
   355		int qidx, rc;
   356	
   357		mutex_lock(&pfvf->mbox.lock);
   358	
   359		/* Remove RQ's policer mapping */
   360		for (qidx = 0; qidx < hw->rx_queues; qidx++)
   361			rc = cn10k_map_unmap_rq_policer(pfvf, qidx, hw->matchall_ipolicer, false);
 > 362			if (rc)
   363				goto out;
   364	
   365		rc = cn10k_free_leaf_profile(pfvf, hw->matchall_ipolicer);
   366	
   367	out:
   368		mutex_unlock(&pfvf->mbox.lock);
   369		return rc;
   370	}
   371	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

