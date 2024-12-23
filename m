Return-Path: <netdev+bounces-154003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A512B9FAB82
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 09:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 147197A238B
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 08:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89331187342;
	Mon, 23 Dec 2024 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bVbQ7XWQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0637462
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734942018; cv=none; b=SnU2CihILm2Ocn2vtlg7xGvvlu2e5mXfmj7Bnh933fcmYc5TL2VTsuYFcqB0XnXOmee77MA7fvY5pp6PIb/X2ssIZRNowlPaIGuhz1wyOaHTo7sED2TNwYSmyVY40MOVl1m7kssZexIXHxzT1/kPRhUn81Xv39k3X2soi0ZDXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734942018; c=relaxed/simple;
	bh=axaF9dpKY8yR2fWQuuIExIfJe66HYYhMN9St+/v+8r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnFx+9KL2sxXOZqSFpRku5AtmsOwC3auGcZDK1bBwMqr1MjjjIur+Auch87uxi9tVP2BqUuxwlmnVxEDNSB6idfvPvPTwszyC7hICIhefniruxMW6yKNks9qIdfWRYgU8rI/HLyHUxRw//0jjFF1JXo7lP6wKYAVK31LzoIYWWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bVbQ7XWQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734942016; x=1766478016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=axaF9dpKY8yR2fWQuuIExIfJe66HYYhMN9St+/v+8r0=;
  b=bVbQ7XWQSgXDf8syLp4jYjCy8kuFKU/cTVmVlJjNe8k+FmhyvvsVS/3b
   mVZM9oiaXIuH4/jtOJT2oOcxjMdewr2jvDTr+5Zn8GkhUxYdxB3zQvzTO
   GR1Fxs/pElCkQNQWghpOGJS+Tt6PQEDkkLlcFRGCeAtbIuK1eJhrj2rZ+
   02LwNBFv/kyAtQbFkNnNL5v6ciTm/zMMpU7yIVODnBGcwZqr9WykFpYVY
   PYzZ0FgnWhUOfKjjFZEKW9x0S07pZ4rc0X8+OeQXnovYakLF4g/yQZOMX
   kUcne6zwMObFZIuzjg4YFiaprINKKWqPPXB70Bpgw0sALrel7qlQpCpk4
   A==;
X-CSE-ConnectionGUID: He39GlLUQqm2pp2dX6bV2Q==
X-CSE-MsgGUID: a1qgybx8QJWkf52JBimQWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11294"; a="39180688"
X-IronPort-AV: E=Sophos;i="6.12,256,1728975600"; 
   d="scan'208";a="39180688"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 00:20:15 -0800
X-CSE-ConnectionGUID: huNc4HPiTEiiIUBmHe9ruQ==
X-CSE-MsgGUID: q47s8Ob+QISfK8d59ETGhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,256,1728975600"; 
   d="scan'208";a="98915654"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 23 Dec 2024 00:20:12 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tPdfe-0003UJ-1D;
	Mon, 23 Dec 2024 08:20:10 +0000
Date: Mon, 23 Dec 2024 16:19:31 +0800
From: kernel test robot <lkp@intel.com>
To: John Daley <johndale@cisco.com>, benve@cisco.com, satishkh@cisco.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	John Daley <johndale@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>
Subject: Re: [PATCH net-next 4/5] enic: Use the Page Pool API for RX when MTU
 is less than page size
Message-ID: <202412231605.tOclyr7m-lkp@intel.com>
References: <20241220215058.11118-5-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220215058.11118-5-johndale@cisco.com>

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Daley/enic-Refactor-RX-path-common-code-into-helper-functions/20241221-055423
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241220215058.11118-5-johndale%40cisco.com
patch subject: [PATCH net-next 4/5] enic: Use the Page Pool API for RX when MTU is less than page size
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241223/202412231605.tOclyr7m-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241223/202412231605.tOclyr7m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412231605.tOclyr7m-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/cisco/enic/enic_rq.c:4:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/cisco/enic/enic_rq.c:214:30: warning: variable 'q_number' is uninitialized when used here [-Wuninitialized]
     214 |                                      enic->netdev->name, q_number);
         |                                                          ^~~~~~~~
   include/linux/net.h:286:43: note: expanded from macro 'net_warn_ratelimited'
     286 |         net_ratelimited_function(pr_warn, fmt, ##__VA_ARGS__)
         |                                                  ^~~~~~~~~~~
   include/linux/net.h:272:12: note: expanded from macro 'net_ratelimited_function'
     272 |                 function(__VA_ARGS__);                          \
         |                          ^~~~~~~~~~~
   include/linux/printk.h:554:37: note: expanded from macro 'pr_warn'
     554 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                                            ^~~~~~~~~~~
   include/linux/printk.h:501:60: note: expanded from macro 'printk'
     501 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                            ^~~~~~~~~~~
   include/linux/printk.h:473:19: note: expanded from macro 'printk_index_wrap'
     473 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   drivers/net/ethernet/cisco/enic/enic_rq.c:204:14: note: initialize the variable 'q_number' to silence this warning
     204 |         u16 q_number, completed_index, bytes_written, vlan_tci, checksum;
         |                     ^
         |                      = 0
   5 warnings generated.


vim +/q_number +214 drivers/net/ethernet/cisco/enic/enic_rq.c

   189	
   190	void enic_rq_indicate_page(struct vnic_rq *vrq, struct cq_desc *cq_desc,
   191				   struct vnic_rq_buf *buf, int skipped, void *opaque)
   192	{
   193		struct enic *enic = vnic_dev_priv(vrq->vdev);
   194		struct sk_buff *skb;
   195		struct enic_rq *rq = &enic->rq[vrq->index];
   196		struct enic_rq_stats *rqstats = &rq->stats;
   197		struct vnic_cq *cq = &enic->cq[enic_cq_rq(enic, vrq->index)];
   198		struct napi_struct *napi;
   199		u8 type, color, eop, sop, ingress_port, vlan_stripped;
   200		u8 fcoe, fcoe_sof, fcoe_fc_crc_ok, fcoe_enc_error, fcoe_eof;
   201		u8 tcp_udp_csum_ok, udp, tcp, ipv4_csum_ok;
   202		u8 ipv6, ipv4, ipv4_fragment, fcs_ok, rss_type, csum_not_calc;
   203		u8 packet_error;
   204		u16 q_number, completed_index, bytes_written, vlan_tci, checksum;
   205		u32 rss_hash;
   206	
   207		if (skipped) {
   208			rqstats->desc_skip++;
   209			return;
   210		}
   211	
   212		if (!buf || !buf->dma_addr) {
   213			net_warn_ratelimited("%s[%u]: !buf || !buf->dma_addr!!\n",
 > 214					     enic->netdev->name, q_number);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

