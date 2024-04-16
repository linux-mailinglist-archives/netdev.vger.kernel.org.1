Return-Path: <netdev+bounces-88151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E41CA8A6088
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 03:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131E01C208FB
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 01:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13236AB9;
	Tue, 16 Apr 2024 01:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WaoiDdUE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E16523D
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 01:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713231742; cv=none; b=K9UOe5MQDph/oB4eUL9c8CGwfCwjoOY8zCs1xGbHC7t4i+aC1qAvZF0+PXmBMaGEwuHfvYrhqkcJzllFzzs/nQ2v9V6yMlF1Yg9uGnzGAlrlGpMGlP/xQ6k9pDmRtjBW5gUfZ1mhqHP3ueCVnf0s0NypVbgGSixF3yoqY+y84qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713231742; c=relaxed/simple;
	bh=8Ph1M2gLwclZUwobrKRtWjpUrWJqo6CN0Wc+gtnA0Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hyG7z+MBKMarIjdsmr75n58T3t7VbfDkTWnpVwLkS4giRO0aRx1BmO+Csv+a/38BKFDObH0gHPK7eb0Y3FrSLV23pPK0KBz3N7dGeJpXVdHWObo7RWlhoYH2noxbJLJkCq0BX4JMhEYQb5NO8D/QiEDJcrg8Z2PXwpmBmhmZnDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WaoiDdUE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713231741; x=1744767741;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8Ph1M2gLwclZUwobrKRtWjpUrWJqo6CN0Wc+gtnA0Uo=;
  b=WaoiDdUEzJxo2HPRVlIUdDDPpvFZqTxPN3AsR1nmVsUImP0KWpGxpwRv
   vmX/wcoJIBUTCjQcTQUL2VE0OLLdniCABxCzjJq/81ezncPzdAtixUiHJ
   n/AeUWv/yzbCp3DcYQ6t1wngKp+3AusU+XcCpIP3J8b5pc1ymEzF+tBUW
   6u4IEZi06dd0MyyKXTZM4a+in5w1YQUm6Q+qNN9MLCVocYBhjdrfycviF
   CNFrpMk0NNc5GoR17LnKkqpXhksYHR0w3gsSBG2jtOFaOWPlCb3ajjmJv
   gEXbEmywxq/XmIKrkUSr75utZDy39Nj49eExkOnUJXI3YRxwHNOqePqw5
   A==;
X-CSE-ConnectionGUID: zKZxwKG1Q5SYvEu4QEO4vQ==
X-CSE-MsgGUID: 4Ze9ywzbRjyUOvBvCxGV2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8479712"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="8479712"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 18:42:20 -0700
X-CSE-ConnectionGUID: 4RqMBrBuQ5ewjs+FQopNNw==
X-CSE-MsgGUID: Sy328VxlTYyHU9qqCH5Ltw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="22178837"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 15 Apr 2024 18:42:19 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwXpw-0004pC-37;
	Tue, 16 Apr 2024 01:42:16 +0000
Date: Tue, 16 Apr 2024 09:41:43 +0800
From: kernel test robot <lkp@intel.com>
To: Julien Panis <jpanis@baylibre.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
Subject: [net-next:main 17/18]
 drivers/net/ethernet/ti/am65-cpsw-nuss.c:478:9: warning: cast to smaller
 integer type 'enum am65_cpsw_tx_buf_type' from 'void *'
Message-ID: <202404160955.THhpKGGa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git main
head:   bb72159c0ad193bbaa842e41316f0f6b6972e821
commit: 8acacc40f7337527ff84cd901ed2ef0a2b95b2b6 [17/18] net: ethernet: ti: am65-cpsw: Add minimal XDP support
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20240416/202404160955.THhpKGGa-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7089c359a3845323f6f30c44a47dd901f2edfe63)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240416/202404160955.THhpKGGa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404160955.THhpKGGa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/ti/am65-cpsw-nuss.c:8:
   In file included from include/linux/bpf_trace.h:5:
   In file included from include/trace/events/xdp.h:8:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/arm64/include/asm/cacheflush.h:11:
   In file included from include/linux/kgdb.h:19:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/ti/am65-cpsw-nuss.c:478:9: warning: cast to smaller integer type 'enum am65_cpsw_tx_buf_type' from 'void *' [-Wvoid-pointer-to-enum-cast]
     478 |         return (enum am65_cpsw_tx_buf_type)k3_cppi_desc_pool_desc_info(tx_chn->desc_pool,
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     479 |                                                                        desc_idx);
         |                                                                        ~~~~~~~~~
   6 warnings generated.


vim +478 drivers/net/ethernet/ti/am65-cpsw-nuss.c

   467	
   468	static enum am65_cpsw_tx_buf_type am65_cpsw_nuss_buf_type(struct am65_cpsw_tx_chn *tx_chn,
   469								  dma_addr_t desc_dma)
   470	{
   471		struct cppi5_host_desc_t *desc_tx;
   472		int desc_idx;
   473	
   474		desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool, desc_dma);
   475		desc_idx = am65_cpsw_nuss_desc_idx(tx_chn->desc_pool, desc_tx,
   476						   tx_chn->dsize_log2);
   477	
 > 478		return (enum am65_cpsw_tx_buf_type)k3_cppi_desc_pool_desc_info(tx_chn->desc_pool,
   479									       desc_idx);
   480	}
   481	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

