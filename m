Return-Path: <netdev+bounces-158185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB43A10D58
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 18:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1021884B9D
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D1E1CF2B7;
	Tue, 14 Jan 2025 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ht63IOGl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E03014A609
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875049; cv=none; b=qlUobXteuIRsNrhTYWaercbE2+BsGqDzOwZGDvreqTRnLhHeS0rsGeT3RG6O1ErKv9SZG7Fn4qCLs06kPZrxY2Je0QgKElkx/NkBWq/No+WwrrsEkzJ3X1iVk6uYwyWlRc0iLnTnMbA4n/763RcyoHV6EMirap+Ie9bo5udZJxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875049; c=relaxed/simple;
	bh=U5JjmE7PtmCm8nJEk9tVTmqsXLSCNFXiXPuKAm5dVuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmvIdvppCJoU5DFah8R/BOll1nGC03BPJk7iM1HzcW1P9lHSzdEHSi5ryHYHrcKhjoVTQjmcMTzh331oMjtEcnkofEsdNW3iDIZN4ImGXdaE+lqlNF15cpbYS34yGvguREyvEbTZ4zDkcFFXsj5mVm2cDwS1MTjdIROI7OaB0Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ht63IOGl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736875048; x=1768411048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U5JjmE7PtmCm8nJEk9tVTmqsXLSCNFXiXPuKAm5dVuU=;
  b=Ht63IOGl77VkDp9+sAaIbYTDtv79mxBB3TaKqmvwLzVRfPRh0E2zSvDC
   7FuJfiYN6rsWkWztvGgyH/q4rxnB5/SMjltE3MpXCWP9BBiGrVsEI0Qd+
   D1y9+jb3vsDGe1LuL4sYzPb14mirKGGK424Lxjs4+st8PXWTv8q+jsLbY
   uvpeKota2BO3hAyffJc69TI/+wA3jyCaibU8vQhhG6xI8za0AtwklUhK8
   w75Ko1Rp/PnIgybfDLKFsM76TdlixkIH6hh2ZqLlSnktu/sb6dQRbb32B
   JoQ0vI7/fV5b1fRn9zcfmS9Ulxg0kdJWs34fdaGrJgul0UHPFCxUj/yNn
   w==;
X-CSE-ConnectionGUID: rQZ3LRbgTwajW6N1O5jniQ==
X-CSE-MsgGUID: ZEqapRmESMmE4k8yRKFXJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37338566"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="37338566"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:17:27 -0800
X-CSE-ConnectionGUID: GaB4D4N5TsyoBtOwLpxvcA==
X-CSE-MsgGUID: 0sjUhexdSkq9xK5YWneOeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="104699422"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 14 Jan 2025 09:17:23 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tXkXZ-000Onj-1K;
	Tue, 14 Jan 2025 17:17:21 +0000
Date: Wed, 15 Jan 2025 01:17:05 +0800
From: kernel test robot <lkp@intel.com>
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	ast@fiberby.net, Shuang Li <shuali@redhat.com>
Subject: Re: [PATCHv2 net] net: sched: refine software bypass handling in
 tc_run
Message-ID: <202501150119.PO2Xlm4u-lkp@intel.com>
References: <17d459487b61c5d0276a01a3bc1254c6432b5d12.1736793775.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17d459487b61c5d0276a01a3bc1254c6432b5d12.1736793775.git.lucien.xin@gmail.com>

Hi Xin,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Xin-Long/net-sched-refine-software-bypass-handling-in-tc_run/20250114-025301
base:   net/main
patch link:    https://lore.kernel.org/r/17d459487b61c5d0276a01a3bc1254c6432b5d12.1736793775.git.lucien.xin%40gmail.com
patch subject: [PATCHv2 net] net: sched: refine software bypass handling in tc_run
config: i386-buildonly-randconfig-005-20250114 (https://download.01.org/0day-ci/archive/20250115/202501150119.PO2Xlm4u-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250115/202501150119.PO2Xlm4u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501150119.PO2Xlm4u-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/sched/cls_api.c:422:23: error: use of undeclared identifier 'tcf_bypass_check_needed_key'
     422 |                         static_branch_dec(&tcf_bypass_check_needed_key);
         |                                            ^
   net/sched/cls_api.c:2385:24: error: use of undeclared identifier 'tcf_bypass_check_needed_key'
    2385 |                                 static_branch_inc(&tcf_bypass_check_needed_key);
         |                                                    ^
   2 errors generated.


vim +/tcf_bypass_check_needed_key +422 net/sched/cls_api.c

   415	
   416	static void tcf_proto_destroy(struct tcf_proto *tp, bool rtnl_held,
   417				      bool sig_destroy, struct netlink_ext_ack *extack)
   418	{
   419		tp->ops->destroy(tp, rtnl_held, extack);
   420		if (tp->usesw && tp->counted) {
   421			if (!atomic_dec_return(&tp->chain->block->useswcnt))
 > 422				static_branch_dec(&tcf_bypass_check_needed_key);
   423			tp->counted = false;
   424		}
   425		if (sig_destroy)
   426			tcf_proto_signal_destroyed(tp->chain, tp);
   427		tcf_chain_put(tp->chain);
   428		module_put(tp->ops->owner);
   429		kfree_rcu(tp, rcu);
   430	}
   431	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

