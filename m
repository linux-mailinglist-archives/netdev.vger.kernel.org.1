Return-Path: <netdev+bounces-50974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F00527F85B0
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 22:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F54628399F
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 21:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9363C070;
	Fri, 24 Nov 2023 21:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NxzZFG5K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A55719A2
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 13:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700862893; x=1732398893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3YjHettXvMeAxIoI/czxLXV1254w1xnxROIM5sTJpK0=;
  b=NxzZFG5K+e7YPZwSNp5E2Kb9WaR1aYXNPKJzhr5iQ+JjwrVb/sXp/qIj
   sudoL07RQ+mMiD0gP5EeezSzDU8v/cYEmbAcFc9GX/lWUROZ6YNj3NIcG
   iZUHKyggO/dEW/fsEyNnAyP0B1BNX2jkU9LgYnu7GdE4yeIVZsjgu1TKb
   HhZKAM44fd3ex3zx/y9w9DaQqNm/ZGW8gvnVtRMdohhoP09BF1G6xM/W3
   zF3ZtOprfEdbdPoKR+5KDlnVZ/DpXpTmFDKFJEfqvY8eCbUAh5FCuBnjl
   7+wuhkq5EE1+HSfdmBRLQGmq961Vl96oC9qY37i+qiX/et0bilQ/Tdsmz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="391344089"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="391344089"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 13:54:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="802229627"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="802229627"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Nov 2023 13:54:49 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r6e8N-0003JY-2X;
	Fri, 24 Nov 2023 21:54:47 +0000
Date: Sat, 25 Nov 2023 05:54:21 +0800
From: kernel test robot <lkp@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Jan Sokolowski <jan.sokolowski@intel.com>,
	Padraig J Connolly <padraig.j.connolly@intel.com>
Subject: Re: [PATCH iwl-next v2] i40e: add ability to reset vf for tx and rx
 mdd events
Message-ID: <202311250323.TmiFJ9nb-lkp@intel.com>
References: <20231124160804.2672341-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124160804.2672341-1-aleksandr.loktionov@intel.com>

Hi Aleksandr,

kernel test robot noticed the following build errors:

[auto build test ERROR on tnguy-next-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Aleksandr-Loktionov/i40e-add-ability-to-reset-vf-for-tx-and-rx-mdd-events/20231125-000929
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20231124160804.2672341-1-aleksandr.loktionov%40intel.com
patch subject: [PATCH iwl-next v2] i40e: add ability to reset vf for tx and rx mdd events
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231125/202311250323.TmiFJ9nb-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231125/202311250323.TmiFJ9nb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311250323.TmiFJ9nb-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/i40e/i40e_debugfs.c:746:9: error: no member named 'num_mdd_events' in 'struct i40e_vf'
                            vf->num_mdd_events);
                            ~~  ^
   include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
           dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                            ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                       ^~~~~~~~~~~
   1 error generated.


vim +746 drivers/net/ethernet/intel/i40e/i40e_debugfs.c

02e9c290814cc1 Jesse Brandeburg 2013-09-11  727  
3118025a070f33 Mitch Williams   2017-04-12  728  /**
3118025a070f33 Mitch Williams   2017-04-12  729   * i40e_dbg_dump_vf - dump VF info
3118025a070f33 Mitch Williams   2017-04-12  730   * @pf: the i40e_pf created in command write
3118025a070f33 Mitch Williams   2017-04-12  731   * @vf_id: the vf_id from the user
3118025a070f33 Mitch Williams   2017-04-12  732   **/
3118025a070f33 Mitch Williams   2017-04-12  733  static void i40e_dbg_dump_vf(struct i40e_pf *pf, int vf_id)
3118025a070f33 Mitch Williams   2017-04-12  734  {
3118025a070f33 Mitch Williams   2017-04-12  735  	struct i40e_vf *vf;
3118025a070f33 Mitch Williams   2017-04-12  736  	struct i40e_vsi *vsi;
3118025a070f33 Mitch Williams   2017-04-12  737  
3118025a070f33 Mitch Williams   2017-04-12  738  	if (!pf->num_alloc_vfs) {
3118025a070f33 Mitch Williams   2017-04-12  739  		dev_info(&pf->pdev->dev, "no VFs allocated\n");
3118025a070f33 Mitch Williams   2017-04-12  740  	} else if ((vf_id >= 0) && (vf_id < pf->num_alloc_vfs)) {
3118025a070f33 Mitch Williams   2017-04-12  741  		vf = &pf->vf[vf_id];
3118025a070f33 Mitch Williams   2017-04-12  742  		vsi = pf->vsi[vf->lan_vsi_idx];
3118025a070f33 Mitch Williams   2017-04-12  743  		dev_info(&pf->pdev->dev, "vf %2d: VSI id=%d, seid=%d, qps=%d\n",
3118025a070f33 Mitch Williams   2017-04-12  744  			 vf_id, vf->lan_vsi_id, vsi->seid, vf->num_queue_pairs);
5710ab79166504 Jacob Keller     2022-02-16  745  		dev_info(&pf->pdev->dev, "       num MDD=%lld\n",
5710ab79166504 Jacob Keller     2022-02-16 @746  			 vf->num_mdd_events);
3118025a070f33 Mitch Williams   2017-04-12  747  	} else {
3118025a070f33 Mitch Williams   2017-04-12  748  		dev_info(&pf->pdev->dev, "invalid VF id %d\n", vf_id);
3118025a070f33 Mitch Williams   2017-04-12  749  	}
3118025a070f33 Mitch Williams   2017-04-12  750  }
3118025a070f33 Mitch Williams   2017-04-12  751  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

