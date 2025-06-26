Return-Path: <netdev+bounces-201697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62295AEAA28
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 01:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 626757A31E3
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 23:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD421EDA3C;
	Thu, 26 Jun 2025 23:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+T+Eyaw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE1018871F
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750978937; cv=none; b=Cx24HUqSKbsVtDnDZXuv62mKZQyzmgsxe5T5bzJxptxUbmfhKvK0day+v1pjzMRWljmdsDp4cQtWsBfogCFp8iceYyuybQWEx+MiAtYB7ppv/X3RpyJ/WdRiu2qUmmgdIC6FVVhSJ21co9ZaXFhCez+pv8ZnWoN31p47o8ZLjQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750978937; c=relaxed/simple;
	bh=nub01D8M7RV9xlJ0/aVofev++91DZcJt80rM/TN9yh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ek7tQTB4pvDBGgjHE/vHMu8Av3QsWku7eqXvKZeWBqrgts6aTKujWsiaASQqr1vmI715olybRMPf5KRY0N7QyDdTSwdsOIm2tdHNv3laP5CIwfPFraAGX9TeufiAmEvw1GYir5oBKQGcYjrMdxuPfTf40hsGUtZb2JGiYD2SJ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+T+Eyaw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750978935; x=1782514935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nub01D8M7RV9xlJ0/aVofev++91DZcJt80rM/TN9yh8=;
  b=D+T+Eyaw9Tm8rJx7crhO33bHM3ovnp3sT/iFYvvJaHXIpQINoAqMZd/M
   8qO8ErZJA/fDAJ3IZKmJ02KQ1Jqjm4BZvrS5BSqOuBeiH04/ES3abjvxQ
   ffzoa8FHiYlR67tiTMceEM49NBKDMI2Ec29y1DxJPUeOkr+uxqTLeJ7lJ
   HGaU36KZVMshCi7pq53DzLp6YzAhaqK1nmcGXDlbvRLkpBXZoFrz25nuz
   LcZRaT7TjbVgi56Z0UltG62+ovNMqrQ6WcbSsGELs4LBY7pkpTaUtd5gn
   tB1dlZ7J3YrZ7othk0mQ2Kd3js2SAvfTyiM+eFxi2rvycSOgT+L4RQuuO
   w==;
X-CSE-ConnectionGUID: 8f2NxcEUTfSRPlpidrTHtA==
X-CSE-MsgGUID: HAtxW5inT928C8e1bev0UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53153003"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="53153003"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 16:01:59 -0700
X-CSE-ConnectionGUID: RQKJmr1HQQaruMKrHEN3xA==
X-CSE-MsgGUID: v7UBRS7vRxqtMaLD3sSJ9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="152747001"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 26 Jun 2025 16:01:56 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUvbO-000Vbm-09;
	Thu, 26 Jun 2025 23:01:54 +0000
Date: Fri, 27 Jun 2025 07:00:59 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Sitnicki <jakub@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, kernel-team@cloudflare.com,
	Lee Valentine <lvalentine@cloudflare.com>
Subject: Re: [PATCH net-next 1/2] tcp: Consider every port when connecting
 with IP_LOCAL_PORT_RANGE
Message-ID: <202506270619.Cjd8lmig-lkp@intel.com>
References: <20250626120247.1255223-1-jakub@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626120247.1255223-1-jakub@cloudflare.com>

Hi Jakub,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Sitnicki/selftests-net-Cover-port-sharing-scenarios-with-IP_LOCAL_PORT_RANGE/20250626-200955
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250626120247.1255223-1-jakub%40cloudflare.com
patch subject: [PATCH net-next 1/2] tcp: Consider every port when connecting with IP_LOCAL_PORT_RANGE
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20250627/202506270619.Cjd8lmig-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250627/202506270619.Cjd8lmig-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506270619.Cjd8lmig-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/ipv4/inet_hashtables.c:1015:21: warning: unused variable 'sk2' [-Wunused-variable]
    1015 |         const struct sock *sk2;
         |                            ^~~
   1 warning generated.


vim +/sk2 +1015 net/ipv4/inet_hashtables.c

  1007	
  1008	/* True on source address conflict with another socket. False otherwise.
  1009	 * Caller must hold hashbucket lock for this tb.
  1010	 */
  1011	static inline bool check_bound(const struct sock *sk,
  1012				       const struct inet_bind_bucket *tb)
  1013	{
  1014		const struct inet_bind2_bucket *tb2;
> 1015		const struct sock *sk2;
  1016	
  1017		hlist_for_each_entry(tb2, &tb->bhash2, bhash_node) {
  1018	#if IS_ENABLED(CONFIG_IPV6)
  1019			if (sk->sk_family == AF_INET6) {
  1020				if (tb2->addr_type == IPV6_ADDR_ANY ||
  1021				    ipv6_addr_equal(&tb2->v6_rcv_saddr,
  1022						    &sk->sk_v6_rcv_saddr))
  1023					return true;
  1024				continue;
  1025			}
  1026	
  1027			/* Check for ipv6 non-v6only wildcard sockets */
  1028			if (tb2->addr_type == IPV6_ADDR_ANY)
  1029				sk_for_each_bound(sk2, &tb2->owners)
  1030					if (!sk2->sk_ipv6only)
  1031						return true;
  1032	
  1033			if (tb2->addr_type != IPV6_ADDR_MAPPED)
  1034				continue;
  1035	#endif
  1036			if (tb2->rcv_saddr == INADDR_ANY ||
  1037			    tb2->rcv_saddr == sk->sk_rcv_saddr)
  1038				return true;
  1039		}
  1040	
  1041		return false;
  1042	}
  1043	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

