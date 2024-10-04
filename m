Return-Path: <netdev+bounces-131895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927D098FE52
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371DF282EDA
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 08:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0912912C7F9;
	Fri,  4 Oct 2024 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hp4mI5ai"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32BA83CD9;
	Fri,  4 Oct 2024 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728028813; cv=none; b=n3+Juwt5DiInwaRbsA/Uqhc69xRr2Bh02vSBcWyOR8NcIVVXf2VhtCcNo+vFix42VC/dQAnCVVy44w1+bb+Nxd2QYNJwtV7EXMNwFUfl2lBsSV5Mwudrx4VX29gEOZnV4GIZOMQQ5I7AIB5ITuiJVOX1qckMG4ZJgv2Jmt4JQI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728028813; c=relaxed/simple;
	bh=mX21nG4Zy98SLUkjeUOB9NLhAqw+tZLY8RDtgnkW9vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEf6m8yu47rA9HxDXV6f52ViIXMVmDSu9lLjcaaak604R5n56gjOsDcDQP0VMTXd1w9Lx7ylnkSZJN3FiXBrlA5Ejc4IrMHKinjDMFoi4r24v+OfWpykfYmXu6gwUubnFWhIO34FzuRBSCX6AMnR2rZMX9u57xbJOUYEbKTGgMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hp4mI5ai; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728028812; x=1759564812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mX21nG4Zy98SLUkjeUOB9NLhAqw+tZLY8RDtgnkW9vY=;
  b=hp4mI5ail8PBOEfaRh1agMWz5Dh/bgIcykgyIpwka1OYDVeqEDDQ/QO8
   4tpCirSflcCKFtNRZec1APbx2kgGy9MtRD/u8PaqybxJODumVZ4JJGQHF
   tA5JFtoPNhOJ5lAhT1Zifx2xwcBdihCqNEWftlLiKQULyu8YgXJnZWd+X
   V5RbAo4EGnjfTSY+f6RvYyDqvtFJCQVWE2gF1wqBRxaPC8pMg4vKC5DqM
   NpINC9OxpJ96Vn1bwWEYssom3MLlQUm6NE9oNTNCMs6RU/5Jt4IA/ehTS
   GEF9jAIiJDhCTiR1/cMAxIJGPpDgrxvTg/GkrBkLrC2DH+afCjymnplnJ
   w==;
X-CSE-ConnectionGUID: cbOVLx1NSpuQgWdgNKzI7w==
X-CSE-MsgGUID: 3yZbn7O2QN6raJruAImGLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="31039115"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="31039115"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 01:00:11 -0700
X-CSE-ConnectionGUID: VTtkfrh9Rkax5AfPRKo9Fw==
X-CSE-MsgGUID: DG16FN6lQ56pJnEjGADlzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="78629889"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 04 Oct 2024 01:00:09 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swdEM-0001MS-2j;
	Fri, 04 Oct 2024 08:00:06 +0000
Date: Fri, 4 Oct 2024 15:59:58 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Yang <danielyangkang@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fix KMSAN infoleak, initialize unused data in
 pskb_expand_head
Message-ID: <202410041506.hEO3Ubsh-lkp@intel.com>
References: <20241002053844.130553-1-danielyangkang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002053844.130553-1-danielyangkang@gmail.com>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on horms-ipvs/master v6.12-rc1 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Yang/Fix-KMSAN-infoleak-initialize-unused-data-in-pskb_expand_head/20241002-134054
base:   linus/master
patch link:    https://lore.kernel.org/r/20241002053844.130553-1-danielyangkang%40gmail.com
patch subject: [PATCH] Fix KMSAN infoleak, initialize unused data in pskb_expand_head
config: powerpc-randconfig-r071-20241004 (https://download.01.org/0day-ci/archive/20241004/202410041506.hEO3Ubsh-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241004/202410041506.hEO3Ubsh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410041506.hEO3Ubsh-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/core/skbuff.c: In function 'pskb_expand_head':
>> net/core/skbuff.c:2292:29: error: invalid operands to binary + (have 'u8 *' {aka 'unsigned char *'} and 'sk_buff_data_t' {aka 'unsigned char *'})
    2292 |         memset(data + nhead + skb->tail, 0, skb_tailroom(skb) + ntail);
         |                ~~~~~~~~~~~~ ^ ~~~~~~~~~
         |                     |            |
         |                     |            sk_buff_data_t {aka unsigned char *}
         |                     u8 * {aka unsigned char *}

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +2292 net/core/skbuff.c

  2240	
  2241	/**
  2242	 *	pskb_expand_head - reallocate header of &sk_buff
  2243	 *	@skb: buffer to reallocate
  2244	 *	@nhead: room to add at head
  2245	 *	@ntail: room to add at tail
  2246	 *	@gfp_mask: allocation priority
  2247	 *
  2248	 *	Expands (or creates identical copy, if @nhead and @ntail are zero)
  2249	 *	header of @skb. &sk_buff itself is not changed. &sk_buff MUST have
  2250	 *	reference count of 1. Returns zero in the case of success or error,
  2251	 *	if expansion failed. In the last case, &sk_buff is not changed.
  2252	 *
  2253	 *	All the pointers pointing into skb header may change and must be
  2254	 *	reloaded after call to this function.
  2255	 */
  2256	
  2257	int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
  2258			     gfp_t gfp_mask)
  2259	{
  2260		unsigned int osize = skb_end_offset(skb);
  2261		unsigned int size = osize + nhead + ntail;
  2262		long off;
  2263		u8 *data;
  2264		int i;
  2265	
  2266		BUG_ON(nhead < 0);
  2267	
  2268		BUG_ON(skb_shared(skb));
  2269	
  2270		skb_zcopy_downgrade_managed(skb);
  2271	
  2272		if (skb_pfmemalloc(skb))
  2273			gfp_mask |= __GFP_MEMALLOC;
  2274	
  2275		data = kmalloc_reserve(&size, gfp_mask, NUMA_NO_NODE, NULL);
  2276		if (!data)
  2277			goto nodata;
  2278		size = SKB_WITH_OVERHEAD(size);
  2279	
  2280		/* Copy only real data... and, alas, header. This should be
  2281		 * optimized for the cases when header is void.
  2282		 */
  2283		memcpy(data + nhead, skb->head, skb_tail_pointer(skb) - skb->head);
  2284	
  2285		memcpy((struct skb_shared_info *)(data + size),
  2286		       skb_shinfo(skb),
  2287		       offsetof(struct skb_shared_info, frags[skb_shinfo(skb)->nr_frags]));
  2288	
  2289		/* Initialize newly allocated headroom and tailroom
  2290		 */
  2291		memset(data, 0, nhead);
> 2292		memset(data + nhead + skb->tail, 0, skb_tailroom(skb) + ntail);
  2293	
  2294		/*
  2295		 * if shinfo is shared we must drop the old head gracefully, but if it
  2296		 * is not we can just drop the old head and let the existing refcount
  2297		 * be since all we did is relocate the values
  2298		 */
  2299		if (skb_cloned(skb)) {
  2300			if (skb_orphan_frags(skb, gfp_mask))
  2301				goto nofrags;
  2302			if (skb_zcopy(skb))
  2303				refcount_inc(&skb_uarg(skb)->refcnt);
  2304			for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
  2305				skb_frag_ref(skb, i);
  2306	
  2307			if (skb_has_frag_list(skb))
  2308				skb_clone_fraglist(skb);
  2309	
  2310			skb_release_data(skb, SKB_CONSUMED);
  2311		} else {
  2312			skb_free_head(skb);
  2313		}
  2314		off = (data + nhead) - skb->head;
  2315	
  2316		skb->head     = data;
  2317		skb->head_frag = 0;
  2318		skb->data    += off;
  2319	
  2320		skb_set_end_offset(skb, size);
  2321	#ifdef NET_SKBUFF_DATA_USES_OFFSET
  2322		off           = nhead;
  2323	#endif
  2324		skb->tail	      += off;
  2325		skb_headers_offset_update(skb, nhead);
  2326		skb->cloned   = 0;
  2327		skb->hdr_len  = 0;
  2328		skb->nohdr    = 0;
  2329		atomic_set(&skb_shinfo(skb)->dataref, 1);
  2330	
  2331		skb_metadata_clear(skb);
  2332	
  2333		/* It is not generally safe to change skb->truesize.
  2334		 * For the moment, we really care of rx path, or
  2335		 * when skb is orphaned (not attached to a socket).
  2336		 */
  2337		if (!skb->sk || skb->destructor == sock_edemux)
  2338			skb->truesize += size - osize;
  2339	
  2340		return 0;
  2341	
  2342	nofrags:
  2343		skb_kfree_head(data, size);
  2344	nodata:
  2345		return -ENOMEM;
  2346	}
  2347	EXPORT_SYMBOL(pskb_expand_head);
  2348	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

