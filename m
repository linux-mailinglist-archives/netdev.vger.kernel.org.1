Return-Path: <netdev+bounces-178648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA662A78085
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACEE1888087
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBE820E00B;
	Tue,  1 Apr 2025 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SiwtiXOg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BD320DD4B
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525197; cv=none; b=f4FBMj0I//Eb6ZWGH+v6ALWvKfqIOu8cejIpEYDl8QKn19G+hWsDlo3tTb4b7IkxXgKpwEP2qI7huOQ0g5sLOG5ZSYv3vt67oavgNT+qLP1HuJh5JlKccw3u+9FhN1vU0qqE0ROTVY/Rp6cH8kRHRnGtq7rw56zerxaiyHr8bPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525197; c=relaxed/simple;
	bh=5ZU3Vj/rhlgpMYV6z8eIH94VEZhymXTa05dMuO//8ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVwN1pGIJME0YelXxMzHolJQLXBEaQgUr5Or+9VAHdKMxmp4wvBGYkL3iSJFHpXzFAedlwd3GS5BASrV483FGlLIzhk9dcCc5vxg/KA/aSp4kokZfqtRPibCQ0aj6gJCH4DH8LVcjyh/ByL9mX4rnRX0HnF0bseezALfRaCfvKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SiwtiXOg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743525195; x=1775061195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ZU3Vj/rhlgpMYV6z8eIH94VEZhymXTa05dMuO//8ZM=;
  b=SiwtiXOghaQy6G4O/xfYB1CM4/XZ7w/bxsb3mqfpA5mua1YfLmGkdxBz
   wwej5Vt6nwtUz+/UYohemVimVBnJHZS5urN/BghtyjIRgPjJC5NnZ0maS
   kLlol7XvlQMDRlaOrIhvmOjNwfTE4UxhGc5gbSZUP27LJhnaOe7yN6bAE
   2dnC2y6xebKXrWEzCF7kZGqZjXC75+ogD4dKBIN9wbi+dX3WPnUHfJCf0
   kKB4QYPf22Ns2MIMHCxtmyZoT6YsT4m19jzClSqy3MPQQOJ4Flkv3q8xW
   AUYutgjmVLGZ7hB+7Bp/ZM6CsGYJE3n0i68MQERff0DFMHFB5if6bm3Lq
   A==;
X-CSE-ConnectionGUID: e4O8C4lhQG2vwNybJvUjaQ==
X-CSE-MsgGUID: v1XBfxVETlGuWcZ47rbbOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="55495976"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="55495976"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 09:33:13 -0700
X-CSE-ConnectionGUID: FWmfHHI2T9ygkxepQI2t9w==
X-CSE-MsgGUID: KqcPutiDSuGvqMPdTmAXdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="131159106"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 01 Apr 2025 09:33:11 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tzeXw-000A0Q-02;
	Tue, 01 Apr 2025 16:33:05 +0000
Date: Wed, 2 Apr 2025 00:32:56 +0800
From: kernel test robot <lkp@intel.com>
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: Re: [PATCH net-next v7 14/14] net: homa: create Makefile and Kconfig
Message-ID: <202504012234.xnBwaq8x-lkp@intel.com>
References: <20250331234548.62070-15-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331234548.62070-15-ouster@cs.stanford.edu>

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/net-homa-define-user-visible-API-for-Homa/20250401-080339
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250331234548.62070-15-ouster%40cs.stanford.edu
patch subject: [PATCH net-next v7 14/14] net: homa: create Makefile and Kconfig
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250401/202504012234.xnBwaq8x-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250401/202504012234.xnBwaq8x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504012234.xnBwaq8x-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/homa/homa_incoming.c:742:6: warning: variable 'iteration' set but not used [-Wunused-but-set-variable]
     742 |         int iteration;
         |             ^
   net/homa/homa_incoming.c:803:6: warning: variable 'iteration' set but not used [-Wunused-but-set-variable]
     803 |         int iteration;
         |             ^
   2 warnings generated.


vim +/iteration +742 net/homa/homa_incoming.c

2040cdd15cc153 John Ousterhout 2025-03-31  727  
2040cdd15cc153 John Ousterhout 2025-03-31  728  /**
2040cdd15cc153 John Ousterhout 2025-03-31  729   * homa_wait_private() - Waits until the response has been received for
2040cdd15cc153 John Ousterhout 2025-03-31  730   * a specific RPC or the RPC has failed with an error.
2040cdd15cc153 John Ousterhout 2025-03-31  731   * @rpc:          RPC to wait for; an error will be returned if the RPC is
2040cdd15cc153 John Ousterhout 2025-03-31  732   *                not a client RPC or not private. Must be locked by caller.
2040cdd15cc153 John Ousterhout 2025-03-31  733   * @nonblocking:  Nonzero means return immediately if @rpc not ready.
2040cdd15cc153 John Ousterhout 2025-03-31  734   * Return:  0 if the response has been successfully received, otherwise
2040cdd15cc153 John Ousterhout 2025-03-31  735   *          a negative errno.
2040cdd15cc153 John Ousterhout 2025-03-31  736   */
2040cdd15cc153 John Ousterhout 2025-03-31  737  int homa_wait_private(struct homa_rpc *rpc, int nonblocking)
2040cdd15cc153 John Ousterhout 2025-03-31  738  	__must_hold(&rpc->bucket->lock)
2040cdd15cc153 John Ousterhout 2025-03-31  739  {
2040cdd15cc153 John Ousterhout 2025-03-31  740  	struct homa_interest interest;
2040cdd15cc153 John Ousterhout 2025-03-31  741  	int result = 0;
2040cdd15cc153 John Ousterhout 2025-03-31 @742  	int iteration;
2040cdd15cc153 John Ousterhout 2025-03-31  743  
2040cdd15cc153 John Ousterhout 2025-03-31  744  	if (!(atomic_read(&rpc->flags) & RPC_PRIVATE))
2040cdd15cc153 John Ousterhout 2025-03-31  745  		return -EINVAL;
2040cdd15cc153 John Ousterhout 2025-03-31  746  
2040cdd15cc153 John Ousterhout 2025-03-31  747  	homa_rpc_hold(rpc);
2040cdd15cc153 John Ousterhout 2025-03-31  748  
2040cdd15cc153 John Ousterhout 2025-03-31  749  	/* Each iteration through this loop waits until rpc needs attention
2040cdd15cc153 John Ousterhout 2025-03-31  750  	 * in some way (e.g. packets have arrived), then deals with that need
2040cdd15cc153 John Ousterhout 2025-03-31  751  	 * (e.g. copy to user space). It may take many iterations until the
2040cdd15cc153 John Ousterhout 2025-03-31  752  	 * RPC is ready for the application.
2040cdd15cc153 John Ousterhout 2025-03-31  753  	 */
2040cdd15cc153 John Ousterhout 2025-03-31  754  	for (iteration = 0; ; iteration++) {
2040cdd15cc153 John Ousterhout 2025-03-31  755  		if (!rpc->error)
2040cdd15cc153 John Ousterhout 2025-03-31  756  			rpc->error = homa_copy_to_user(rpc);
2040cdd15cc153 John Ousterhout 2025-03-31  757  		if (rpc->error) {
2040cdd15cc153 John Ousterhout 2025-03-31  758  			result = rpc->error;
2040cdd15cc153 John Ousterhout 2025-03-31  759  			break;
2040cdd15cc153 John Ousterhout 2025-03-31  760  		}
2040cdd15cc153 John Ousterhout 2025-03-31  761  		if (rpc->msgin.length >= 0 &&
2040cdd15cc153 John Ousterhout 2025-03-31  762  		    rpc->msgin.bytes_remaining == 0 &&
2040cdd15cc153 John Ousterhout 2025-03-31  763  		    skb_queue_len(&rpc->msgin.packets) == 0)
2040cdd15cc153 John Ousterhout 2025-03-31  764  			break;
2040cdd15cc153 John Ousterhout 2025-03-31  765  
2040cdd15cc153 John Ousterhout 2025-03-31  766  		result = homa_interest_init_private(&interest, rpc);
2040cdd15cc153 John Ousterhout 2025-03-31  767  		if (result != 0)
2040cdd15cc153 John Ousterhout 2025-03-31  768  			break;
2040cdd15cc153 John Ousterhout 2025-03-31  769  
2040cdd15cc153 John Ousterhout 2025-03-31  770  		homa_rpc_unlock(rpc);
2040cdd15cc153 John Ousterhout 2025-03-31  771  		result = homa_interest_wait(&interest, nonblocking);
2040cdd15cc153 John Ousterhout 2025-03-31  772  
2040cdd15cc153 John Ousterhout 2025-03-31  773  		atomic_or(APP_NEEDS_LOCK, &rpc->flags);
2040cdd15cc153 John Ousterhout 2025-03-31  774  		homa_rpc_lock(rpc);
2040cdd15cc153 John Ousterhout 2025-03-31  775  		atomic_andnot(APP_NEEDS_LOCK, &rpc->flags);
2040cdd15cc153 John Ousterhout 2025-03-31  776  		homa_interest_unlink_private(&interest);
2040cdd15cc153 John Ousterhout 2025-03-31  777  
2040cdd15cc153 John Ousterhout 2025-03-31  778  		/* If homa_interest_wait returned an error but the interest
2040cdd15cc153 John Ousterhout 2025-03-31  779  		 * actually got ready, then ignore the error.
2040cdd15cc153 John Ousterhout 2025-03-31  780  		 */
2040cdd15cc153 John Ousterhout 2025-03-31  781  		if (result != 0 && atomic_read(&interest.ready) == 0)
2040cdd15cc153 John Ousterhout 2025-03-31  782  			break;
2040cdd15cc153 John Ousterhout 2025-03-31  783  	}
2040cdd15cc153 John Ousterhout 2025-03-31  784  
2040cdd15cc153 John Ousterhout 2025-03-31  785  	homa_rpc_put(rpc);
2040cdd15cc153 John Ousterhout 2025-03-31  786  	return result;
2040cdd15cc153 John Ousterhout 2025-03-31  787  }
2040cdd15cc153 John Ousterhout 2025-03-31  788  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

