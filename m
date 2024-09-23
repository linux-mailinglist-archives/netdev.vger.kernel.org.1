Return-Path: <netdev+bounces-129222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3401A97E4E1
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 04:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626EA28159C
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 02:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6390128E7;
	Mon, 23 Sep 2024 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HgA2fdwu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308B81FA5;
	Mon, 23 Sep 2024 02:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727060238; cv=none; b=sUtZfM44si9/d8R3GAj2jgSpt+vU0Ljly41NqsZSsvM/bScBGu9L01JYabFGyfn6r7c3R4EfnWQ3xnHfBESuc261RE4oyWyhd336YUjbeHKoTR/+zZGVxnzVKDYOljTlJTazbzho/9FgWqmzHA6/YibZs9wEa8P/6FjybM+do4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727060238; c=relaxed/simple;
	bh=QQB2dXdDa8p4Cd4G/XHIeFjP+KmUSYs7VGkZ1kDNSNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrvBRjVvwuoiNzPv63gT4C53Q5CXd6R0DMHvnp++dajNZJrbUfpxMq2qmDVHjwGgX9oWkoYYNOSfjMWvb+nKTMhXx1dd3lmnrGkc18q9QKKBki7Sv3PdnM4jCb1dUHwBuzGeHM/pBiZnmoO6q2guzRiV7lRUc9aZRnIt5SzVGJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HgA2fdwu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727060235; x=1758596235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QQB2dXdDa8p4Cd4G/XHIeFjP+KmUSYs7VGkZ1kDNSNE=;
  b=HgA2fdwuHZDqZ9SwF+MHbbhHvnX8ah14acXhsWRXG2l9nGaFDogdxGGA
   FU4jwmUfKfRwyClFGRYu8leKNS7wwugfQmsKfCuSi7y/LhpsTcLucIOGP
   o+I2o7Nn0qPn+pXbEBSHkbVE8MxRHtoCYKzEqtxJK3xv7zVMFKqVArBTn
   Xe3FW9bgpdYPuAsaiz2vWy3TSO9V/mQi5khaE6mqmqV0kWrCljC6yHKws
   5g/1W0ZNJ/vmPvUnGKWyk9BmMGUVIaHE5qu6kAMB3no4CFOeItGrsRZ37
   A8+1eFP8hqqicMH+D0XifRuCVaf2vUdYIfXfr9HfkGJLxuegJTxRZp9It
   A==;
X-CSE-ConnectionGUID: jGVsZB5rSBqND7jM54iGlw==
X-CSE-MsgGUID: gx2zS7sER8e2Oj0cCyb38w==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="37363901"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="37363901"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 19:57:14 -0700
X-CSE-ConnectionGUID: t+R6Ll2tTmKmx/APhEjcxQ==
X-CSE-MsgGUID: NKoD5rX4T0u1mj88Dr74Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="71072211"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 22 Sep 2024 19:57:11 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssZG8-000GqQ-1u;
	Mon, 23 Sep 2024 02:57:08 +0000
Date: Mon, 23 Sep 2024 10:57:05 +0800
From: kernel test robot <lkp@intel.com>
To: Dipendra Khadka <kdipendra88@gmail.com>, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Dipendra Khadka <kdipendra88@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: net: nic: Add error pointer check in
 otx2_flows.c
Message-ID: <202409231056.4rLGE5NG-lkp@intel.com>
References: <20240922185235.50413-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922185235.50413-1-kdipendra88@gmail.com>

Hi Dipendra,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Dipendra-Khadka/Staging-net-nic-Add-error-pointer-check-in-otx2_flows-c/20240923-025325
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20240922185235.50413-1-kdipendra88%40gmail.com
patch subject: [PATCH] Staging: net: nic: Add error pointer check in otx2_flows.c
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240923/202409231056.4rLGE5NG-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240923/202409231056.4rLGE5NG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409231056.4rLGE5NG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/tcp.h:17:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
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
   In file included from drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:8:
   In file included from include/net/ipv6.h:12:
   In file included from include/linux/ipv6.h:101:
   In file included from include/linux/tcp.h:17:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:8:
   In file included from include/net/ipv6.h:12:
   In file included from include/linux/ipv6.h:101:
   In file included from include/linux/tcp.h:17:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:8:
   In file included from include/net/ipv6.h:12:
   In file included from include/linux/ipv6.h:101:
   In file included from include/linux/tcp.h:17:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:124:18: error: use of undeclared identifier 'bfvf'; did you mean 'pfvf'?
     124 |                         mutex_unlock(&bfvf->mbox.lock);
         |                                       ^~~~
         |                                       pfvf
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:72:46: note: 'pfvf' declared here
      72 | int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
         |                                              ^
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:207:17: error: use of undeclared identifier 'bfvf'; did you mean 'pfvf'?
     207 |                 mutex_unlock(&bfvf->mbox.lock);
         |                               ^~~~
         |                               pfvf
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:167:43: note: 'pfvf' declared here
     167 | int otx2_mcam_entry_init(struct otx2_nic *pfvf)
         |                                           ^
   17 warnings and 2 errors generated.


vim +124 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c

    71	
    72	int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
    73	{
    74		struct otx2_flow_config *flow_cfg = pfvf->flow_cfg;
    75		struct npc_mcam_alloc_entry_req *req;
    76		struct npc_mcam_alloc_entry_rsp *rsp;
    77		int ent, allocated = 0;
    78	
    79		/* Free current ones and allocate new ones with requested count */
    80		otx2_free_ntuple_mcam_entries(pfvf);
    81	
    82		if (!count)
    83			return 0;
    84	
    85		flow_cfg->flow_ent = devm_kmalloc_array(pfvf->dev, count,
    86							sizeof(u16), GFP_KERNEL);
    87		if (!flow_cfg->flow_ent) {
    88			netdev_err(pfvf->netdev,
    89				   "%s: Unable to allocate memory for flow entries\n",
    90				    __func__);
    91			return -ENOMEM;
    92		}
    93	
    94		mutex_lock(&pfvf->mbox.lock);
    95	
    96		/* In a single request a max of NPC_MAX_NONCONTIG_ENTRIES MCAM entries
    97		 * can only be allocated.
    98		 */
    99		while (allocated < count) {
   100			req = otx2_mbox_alloc_msg_npc_mcam_alloc_entry(&pfvf->mbox);
   101			if (!req)
   102				goto exit;
   103	
   104			req->contig = false;
   105			req->count = (count - allocated) > NPC_MAX_NONCONTIG_ENTRIES ?
   106					NPC_MAX_NONCONTIG_ENTRIES : count - allocated;
   107	
   108			/* Allocate higher priority entries for PFs, so that VF's entries
   109			 * will be on top of PF.
   110			 */
   111			if (!is_otx2_vf(pfvf->pcifunc)) {
   112				req->priority = NPC_MCAM_HIGHER_PRIO;
   113				req->ref_entry = flow_cfg->def_ent[0];
   114			}
   115	
   116			/* Send message to AF */
   117			if (otx2_sync_mbox_msg(&pfvf->mbox))
   118				goto exit;
   119	
   120			rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp
   121				(&pfvf->mbox.mbox, 0, &req->hdr);
   122	
   123			if (IS_ERR(rsp)) {
 > 124				mutex_unlock(&bfvf->mbox.lock);
   125				return PTR_ERR(rsp);
   126			}
   127	
   128			for (ent = 0; ent < rsp->count; ent++)
   129				flow_cfg->flow_ent[ent + allocated] = rsp->entry_list[ent];
   130	
   131			allocated += rsp->count;
   132	
   133			/* If this request is not fulfilled, no need to send
   134			 * further requests.
   135			 */
   136			if (rsp->count != req->count)
   137				break;
   138		}
   139	
   140		/* Multiple MCAM entry alloc requests could result in non-sequential
   141		 * MCAM entries in the flow_ent[] array. Sort them in an ascending order,
   142		 * otherwise user installed ntuple filter index and MCAM entry index will
   143		 * not be in sync.
   144		 */
   145		if (allocated)
   146			sort(&flow_cfg->flow_ent[0], allocated,
   147			     sizeof(flow_cfg->flow_ent[0]), mcam_entry_cmp, NULL);
   148	
   149	exit:
   150		mutex_unlock(&pfvf->mbox.lock);
   151	
   152		flow_cfg->max_flows = allocated;
   153	
   154		if (allocated) {
   155			pfvf->flags |= OTX2_FLAG_MCAM_ENTRIES_ALLOC;
   156			pfvf->flags |= OTX2_FLAG_NTUPLE_SUPPORT;
   157		}
   158	
   159		if (allocated != count)
   160			netdev_info(pfvf->netdev,
   161				    "Unable to allocate %d MCAM entries, got only %d\n",
   162				    count, allocated);
   163		return allocated;
   164	}
   165	EXPORT_SYMBOL(otx2_alloc_mcam_entries);
   166	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

