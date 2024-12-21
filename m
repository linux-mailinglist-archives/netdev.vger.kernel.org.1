Return-Path: <netdev+bounces-153849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7289F9D56
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 01:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158B2160B15
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 00:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B55C17E;
	Sat, 21 Dec 2024 00:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aY49UTzv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76519370;
	Sat, 21 Dec 2024 00:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734739595; cv=none; b=J3Cn4qczjTxh6llpz1Ua+M/7TndMBSk8i1HSQCXdSeBk0FtSQuj/euRNZBdp4vL1UugH9icPDFXDlTA/lQGfNDOcsKpYpawJbTTNAYreHh6aymq3XB1Ngg830Lu9s7r0AkiemUKtkK1Qwe2B5q0LvOFwFlXJw6cLIWly8VnA2bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734739595; c=relaxed/simple;
	bh=7eKynyAGbkufr/ZNtz935UBCsTC5J1w/8/uhytNNyKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVJ7luUB8zihco+3M5VsCENPfcGpIjJKfrYYwALmA0BQ8pd2j3/4byLJrXNa+P2N0AFjgc1PsipOBsfcwNIrK41F/Qg0eWBbCinkFddnDo3l6Cy9qAQNU5DUNMZkcuZucS8nCHVlE3+VPmEA9bJcuPsHtIXjhVse5FKS2nNPLwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aY49UTzv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734739594; x=1766275594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7eKynyAGbkufr/ZNtz935UBCsTC5J1w/8/uhytNNyKs=;
  b=aY49UTzvbpgNLyuNLUcfBGLAX3+SvEa9ur9ONG/MD0Uyd1c9IX0p+lf3
   Zw5xl8tVdQL7dZDBvRbof2rEV64zSdJLpY8GzYnGlzpiDX3Et1XG+MKaB
   KrqBY90R3VfnDvjVcTRAs25jW90hX42EWN+qUWAM0xDD9CLAKb6939iGT
   OQp6x6XUhI8QYkSjSsq5sibP6t1TB2RxHpgIOzHahGUnYMgPX+OcuYKwa
   bZQ349fuhEnTmvXtqOqmny0usAu45/PDJMO1tjVc6SkMHKtq/4YASGCie
   3ktnV6+/F0NsVo156d6nOA75g8qA0cdEWt2xAtCgoGq1Z6CH/bTe3Gp8D
   w==;
X-CSE-ConnectionGUID: lUQpZTV4RKObW0yiSblWuQ==
X-CSE-MsgGUID: V/6lqnpJTPC71mvEqGU5CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="52701388"
X-IronPort-AV: E=Sophos;i="6.12,252,1728975600"; 
   d="scan'208";a="52701388"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 16:06:33 -0800
X-CSE-ConnectionGUID: TxkhmUMoQKuSFKkNU0rLJA==
X-CSE-MsgGUID: FyMziybBSlSrO2NSt9J37A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102756568"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 20 Dec 2024 16:06:30 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOn0m-0001nH-1R;
	Sat, 21 Dec 2024 00:06:28 +0000
Date: Sat, 21 Dec 2024 08:05:56 +0800
From: kernel test robot <lkp@intel.com>
To: Yajun Deng <yajun.deng@linux.dev>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: Re: [PATCH net-next] sock: make SKB_FRAG_PAGE_ORDER equal to
 PAGE_ALLOC_COSTLY_ORDER
Message-ID: <202412210700.fAOJ9ocm-lkp@intel.com>
References: <20241217105659.2215649-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217105659.2215649-1-yajun.deng@linux.dev>

Hi Yajun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Yajun-Deng/sock-make-SKB_FRAG_PAGE_ORDER-equal-to-PAGE_ALLOC_COSTLY_ORDER/20241217-185748
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241217105659.2215649-1-yajun.deng%40linux.dev
patch subject: [PATCH net-next] sock: make SKB_FRAG_PAGE_ORDER equal to PAGE_ALLOC_COSTLY_ORDER
config: openrisc-randconfig-r122-20241220 (https://download.01.org/0day-ci/archive/20241221/202412210700.fAOJ9ocm-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241221/202412210700.fAOJ9ocm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412210700.fAOJ9ocm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/core/sock.c:2496:9: sparse: sparse: context imbalance in 'sk_clone_lock' - wrong count at exit
   net/core/sock.c:2500:6: sparse: sparse: context imbalance in 'sk_free_unlock_clone' - unexpected unlock
>> net/core/sock.c:3044:49: sparse: sparse: cast truncates bits from constant value (10000 becomes 0)

vim +3044 net/core/sock.c

5640f7685831e08 Eric Dumazet 2012-09-23  3013  
400dfd3ae899849 Eric Dumazet 2013-10-17  3014  /**
400dfd3ae899849 Eric Dumazet 2013-10-17  3015   * skb_page_frag_refill - check that a page_frag contains enough room
400dfd3ae899849 Eric Dumazet 2013-10-17  3016   * @sz: minimum size of the fragment we want to get
400dfd3ae899849 Eric Dumazet 2013-10-17  3017   * @pfrag: pointer to page_frag
82d5e2b8b466d5b Eric Dumazet 2014-09-08  3018   * @gfp: priority for memory allocation
400dfd3ae899849 Eric Dumazet 2013-10-17  3019   *
400dfd3ae899849 Eric Dumazet 2013-10-17  3020   * Note: While this allocator tries to use high order pages, there is
400dfd3ae899849 Eric Dumazet 2013-10-17  3021   * no guarantee that allocations succeed. Therefore, @sz MUST be
400dfd3ae899849 Eric Dumazet 2013-10-17  3022   * less or equal than PAGE_SIZE.
400dfd3ae899849 Eric Dumazet 2013-10-17  3023   */
d9b2938aabf757d Eric Dumazet 2014-08-27  3024  bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp)
5640f7685831e08 Eric Dumazet 2012-09-23  3025  {
5640f7685831e08 Eric Dumazet 2012-09-23  3026  	if (pfrag->page) {
fe896d1878949ea Joonsoo Kim  2016-03-17  3027  		if (page_ref_count(pfrag->page) == 1) {
5640f7685831e08 Eric Dumazet 2012-09-23  3028  			pfrag->offset = 0;
5640f7685831e08 Eric Dumazet 2012-09-23  3029  			return true;
5640f7685831e08 Eric Dumazet 2012-09-23  3030  		}
400dfd3ae899849 Eric Dumazet 2013-10-17  3031  		if (pfrag->offset + sz <= pfrag->size)
5640f7685831e08 Eric Dumazet 2012-09-23  3032  			return true;
5640f7685831e08 Eric Dumazet 2012-09-23  3033  		put_page(pfrag->page);
5640f7685831e08 Eric Dumazet 2012-09-23  3034  	}
5640f7685831e08 Eric Dumazet 2012-09-23  3035  
5640f7685831e08 Eric Dumazet 2012-09-23  3036  	pfrag->offset = 0;
af87ed7a96a9372 Yajun Deng   2024-12-17  3037  	if (!static_branch_unlikely(&net_high_order_alloc_disable_key)) {
d0164adc89f6bb3 Mel Gorman   2015-11-06  3038  		/* Avoid direct reclaim but allow kswapd to wake */
d0164adc89f6bb3 Mel Gorman   2015-11-06  3039  		pfrag->page = alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
d0164adc89f6bb3 Mel Gorman   2015-11-06  3040  					  __GFP_COMP | __GFP_NOWARN |
d0164adc89f6bb3 Mel Gorman   2015-11-06  3041  					  __GFP_NORETRY,
d9b2938aabf757d Eric Dumazet 2014-08-27  3042  					  SKB_FRAG_PAGE_ORDER);
d9b2938aabf757d Eric Dumazet 2014-08-27  3043  		if (likely(pfrag->page)) {
d9b2938aabf757d Eric Dumazet 2014-08-27 @3044  			pfrag->size = PAGE_SIZE << SKB_FRAG_PAGE_ORDER;
d9b2938aabf757d Eric Dumazet 2014-08-27  3045  			return true;
d9b2938aabf757d Eric Dumazet 2014-08-27  3046  		}
d9b2938aabf757d Eric Dumazet 2014-08-27  3047  	}
d9b2938aabf757d Eric Dumazet 2014-08-27  3048  	pfrag->page = alloc_page(gfp);
d9b2938aabf757d Eric Dumazet 2014-08-27  3049  	if (likely(pfrag->page)) {
d9b2938aabf757d Eric Dumazet 2014-08-27  3050  		pfrag->size = PAGE_SIZE;
5640f7685831e08 Eric Dumazet 2012-09-23  3051  		return true;
5640f7685831e08 Eric Dumazet 2012-09-23  3052  	}
400dfd3ae899849 Eric Dumazet 2013-10-17  3053  	return false;
400dfd3ae899849 Eric Dumazet 2013-10-17  3054  }
400dfd3ae899849 Eric Dumazet 2013-10-17  3055  EXPORT_SYMBOL(skb_page_frag_refill);
400dfd3ae899849 Eric Dumazet 2013-10-17  3056  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

