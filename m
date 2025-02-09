Return-Path: <netdev+bounces-164401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FAAA2DBFF
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 11:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A923A1405
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 10:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901B9154456;
	Sun,  9 Feb 2025 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ds5LFIYF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA414B086;
	Sun,  9 Feb 2025 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096256; cv=none; b=cbl59kUu8vdl5Gu2VkMvwzqQ1jRwS65E6DKqDDYvMWCUSw4q3vGhq0RyVYd6Bgdl8t6nSLXpUqjLfrLJ3tQTk/UZEdrFBELOV0IWFoTDk+w0lq/1rVqDpNnjEZPBn/JQ6RXpK6BuaVStInV4sZHvfPirZv2ZZkgWE+Wour1z1fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096256; c=relaxed/simple;
	bh=Ec5owhxuVyqV6l/NuwWt6tySFHCPrsPZ2HH6kFOtAcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uX06ghuvPb6IQe9qlJ08WHz6aqPuaL4+j3Qk5bt36BP0IGGbBticPQFotCr+mRtzG4v/TPeK2IwR4u7/9JuuPpE3ONQ7m/OfTLGoa5rFliOvL7+N3UHyIW74DLkvZwGq+TdRI4fePOvrHxLretkkKmnFvyE2s95Y/oX2YGINQ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ds5LFIYF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739096253; x=1770632253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ec5owhxuVyqV6l/NuwWt6tySFHCPrsPZ2HH6kFOtAcQ=;
  b=Ds5LFIYFNa2x8j81YAyh4jCFficUq2EFpFSArcYJ5o3Sur4N/CsqlOOk
   /pG/PEti8+lTdKPzMGoTfhKA9O1nTGR5ArkWATQsMAtOrG7ZqWHx4qlDw
   W6zRL/iBF3xmZphgzeTuAVps/P9FX65/wS52I/sTw/TU4w5pfKGPe6m15
   9+iS7/WOMfdp/51LEPLMCYvCFYPtoUXm8NvJOqodhdVNfxvT5Ey1NmZsY
   QofOA37DKh/bcLdzvCSinjFLkDgiFMqoGWIzgNtNsTsHvxRu7WBghqMGB
   QuR8/hz8lWculCpaKJoJzkrq8WUlpmkzqYJ2/FZASSUu1e2OwN4I1AJMq
   A==;
X-CSE-ConnectionGUID: 5Jgm3M3kR02K1TPOgaZrQw==
X-CSE-MsgGUID: MIbmD4+2RNiKO7mpWD7Qkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11339"; a="42531859"
X-IronPort-AV: E=Sophos;i="6.13,272,1732608000"; 
   d="scan'208";a="42531859"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 02:17:33 -0800
X-CSE-ConnectionGUID: tAlE1hgASmaH/sPwSXJjeA==
X-CSE-MsgGUID: kZk4YyznQK2YAC5F+sIwUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,272,1732608000"; 
   d="scan'208";a="112557968"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 09 Feb 2025 02:17:29 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1th4NS-0011KR-2i;
	Sun, 09 Feb 2025 10:17:26 +0000
Date: Sun, 9 Feb 2025 18:17:12 +0800
From: kernel test robot <lkp@intel.com>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, horms@kernel.org,
	kuba@kernel.org, Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	David Wei <dw@davidwei.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/3] netdev-genl: Add an XSK attribute to
 queues
Message-ID: <202502091844.PyraqTPE-lkp@intel.com>
References: <20250208041248.111118-3-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208041248.111118-3-jdamato@fastly.com>

Hi Joe,

kernel test robot noticed the following build errors:

[auto build test ERROR on 233a2b1480a0bdf6b40d4debf58a07084e9921ff]

url:    https://github.com/intel-lab-lkp/linux/commits/Joe-Damato/netlink-Add-nla_put_empty_nest-helper/20250208-121856
base:   233a2b1480a0bdf6b40d4debf58a07084e9921ff
patch link:    https://lore.kernel.org/r/20250208041248.111118-3-jdamato%40fastly.com
patch subject: [PATCH net-next v5 2/3] netdev-genl: Add an XSK attribute to queues
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20250209/202502091844.PyraqTPE-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250209/202502091844.PyraqTPE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502091844.PyraqTPE-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/core/netdev-genl.c:3:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2224:
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
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> net/core/netdev-genl.c:404:12: error: no member named 'pool' in 'struct netdev_rx_queue'
     404 |                 if (rxq->pool)
         |                     ~~~  ^
>> net/core/netdev-genl.c:414:12: error: no member named 'pool' in 'struct netdev_queue'
     414 |                 if (txq->pool)
         |                     ~~~  ^
   3 warnings and 2 errors generated.


vim +404 net/core/netdev-genl.c

   374	
   375	static int
   376	netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
   377				 u32 q_idx, u32 q_type, const struct genl_info *info)
   378	{
   379		struct pp_memory_provider_params *params;
   380		struct netdev_rx_queue *rxq;
   381		struct netdev_queue *txq;
   382		void *hdr;
   383	
   384		hdr = genlmsg_iput(rsp, info);
   385		if (!hdr)
   386			return -EMSGSIZE;
   387	
   388		if (nla_put_u32(rsp, NETDEV_A_QUEUE_ID, q_idx) ||
   389		    nla_put_u32(rsp, NETDEV_A_QUEUE_TYPE, q_type) ||
   390		    nla_put_u32(rsp, NETDEV_A_QUEUE_IFINDEX, netdev->ifindex))
   391			goto nla_put_failure;
   392	
   393		switch (q_type) {
   394		case NETDEV_QUEUE_TYPE_RX:
   395			rxq = __netif_get_rx_queue(netdev, q_idx);
   396			if (nla_put_napi_id(rsp, rxq->napi))
   397				goto nla_put_failure;
   398	
   399			params = &rxq->mp_params;
   400			if (params->mp_ops &&
   401			    params->mp_ops->nl_fill(params->mp_priv, rsp, rxq))
   402				goto nla_put_failure;
   403	
 > 404			if (rxq->pool)
   405				if (nla_put_empty_nest(rsp, NETDEV_A_QUEUE_XSK))
   406					goto nla_put_failure;
   407	
   408			break;
   409		case NETDEV_QUEUE_TYPE_TX:
   410			txq = netdev_get_tx_queue(netdev, q_idx);
   411			if (nla_put_napi_id(rsp, txq->napi))
   412				goto nla_put_failure;
   413	
 > 414			if (txq->pool)
   415				if (nla_put_empty_nest(rsp, NETDEV_A_QUEUE_XSK))
   416					goto nla_put_failure;
   417	
   418			break;
   419		}
   420	
   421		genlmsg_end(rsp, hdr);
   422	
   423		return 0;
   424	
   425	nla_put_failure:
   426		genlmsg_cancel(rsp, hdr);
   427		return -EMSGSIZE;
   428	}
   429	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

