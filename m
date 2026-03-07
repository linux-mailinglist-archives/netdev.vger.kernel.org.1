Return-Path: <netdev+bounces-265135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCazAR0TrGkujwEAu9opvQ
	(envelope-from <netdev+bounces-265135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 12:59:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F7022BA1B
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 12:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E60243010619
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 11:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FED135836E;
	Sat,  7 Mar 2026 11:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXuMtDBK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0807433C18B
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772884762; cv=none; b=NHXuXaeUHrwe+O57HzLGSOiopKXQQH3l2b+pP0f8b3Slf/KQBi/L5hV/wXq3B41yPBidnztr3OXDsPumAB6cPgHYCLI1lkENsIqJO6/8pAvJFyezLtwnfqRhboPyYE6k0uRF+K4Q6uPZi3Q+ictW3PLcXVBPoCldrXSCwdKVoqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772884762; c=relaxed/simple;
	bh=+Jtk73AtwgRWJ77Gc08frUB+SRwy2ZqoFSuRtxuDPTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xsfp1YGrlUa/e3QpmEfegU+53dPmzPBgWaupykGLt8ocWQ8y1SHnfDZICh+mBnBSTnExADXhvcz38W/SIhhK4aPwtmw6VECN921nHrWfxSXZytdngfRLX4ZcZ2PLzOM0ze58MK05Ul02jDbNmtBcKmfI1S9T6ZzczJ7z/JTcXtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXuMtDBK; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772884758; x=1804420758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Jtk73AtwgRWJ77Gc08frUB+SRwy2ZqoFSuRtxuDPTs=;
  b=OXuMtDBKFZTQkWTMm57MTDSUJD44PsC/TCuM7I3ONcGSEe30XVNyI3rb
   wrm3DP1yCMm6jJ4eaSxjl4+cmocIb/g7zvbCQdf7TzLNkn0Nb2bYhw2fT
   qDj2VN5sNB1qxLaax68iACA/kI5aVaX+ZyfuB8s4/k4dimOVhWbZOPZ+V
   JCy2JBlJfpNGP6jAiKITBMTOEJcqeYHrXXNBJV8/5Wblz/rtsCchfdn5o
   X6kpd9yhpbuSrXPE8riCzjmsWBA2OfTTmGlHA20NNE6G5tWuuKDRIiiQD
   gralCqIjmDGWD08COwsIm/hOPTY1tZ2G1zLosITb2AlDW+tYz+z19n2pH
   g==;
X-CSE-ConnectionGUID: e/vXirIqQG2tumh1y9taIA==
X-CSE-MsgGUID: u2nd012CRtOel8+Ltjpc0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="73894571"
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; 
   d="scan'208";a="73894571"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 03:59:15 -0800
X-CSE-ConnectionGUID: jkXcanMZTJOwpdxikpcG9Q==
X-CSE-MsgGUID: +6WBOzAITNGNzzg4L5JlLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; 
   d="scan'208";a="249736287"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 07 Mar 2026 03:59:12 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyqJI-000000001xR-3BCP;
	Sat, 07 Mar 2026 11:59:08 +0000
Date: Sat, 7 Mar 2026 19:58:49 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Kui-Feng Lee <thinker.li@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net 2/2] ipv6: Don't remove permanent routes with
 exceptions from tb6_gc_hlist.
Message-ID: <202603071918.kDLKvFsA-lkp@intel.com>
References: <20260307024709.718395-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307024709.718395-3-kuniyu@google.com>
X-Rspamd-Queue-Id: 90F7022BA1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,kernel.org,google.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:?];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-265135-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.077];
	DMARC_DNSFAIL(0.00)[intel.com : server fail];
	R_DKIM_TEMPFAIL(0.00)[intel.com:s=Intel];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,01.org:url]
X-Rspamd-Action: no action

Hi Kuniyuki,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/ipv6-Remove-permanent-routes-from-tb6_gc_hlist-when-all-exceptions-expire/20260307-104803
base:   net/main
patch link:    https://lore.kernel.org/r/20260307024709.718395-3-kuniyu%40google.com
patch subject: [PATCH v1 net 2/2] ipv6: Don't remove permanent routes with exceptions from tb6_gc_hlist.
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20260307/202603071918.kDLKvFsA-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603071918.kDLKvFsA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603071918.kDLKvFsA-lkp@intel.com/

All warnings (new ones prefixed by >>):

      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/ip6_fib.h:557:27: note: in expansion of macro 'READ_ONCE'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                           ^~~~~~~~~
   include/net/ip6_fib.h:557:42: error: 'struct net' has no member named 'ipv6'; did you mean 'ipv4'?
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                          ^~~~
   include/linux/compiler_types.h:686:23: note: in definition of macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/ip6_fib.h:557:27: note: in expansion of macro 'READ_ONCE'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                           ^~~~~~~~~
   include/net/ip6_fib.h:557:42: error: 'struct net' has no member named 'ipv6'; did you mean 'ipv4'?
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                          ^~~~
   include/linux/compiler_types.h:686:23: note: in definition of macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/ip6_fib.h:557:27: note: in expansion of macro 'READ_ONCE'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                           ^~~~~~~~~
   include/net/ip6_fib.h:557:42: error: 'struct net' has no member named 'ipv6'; did you mean 'ipv4'?
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                          ^~~~
   include/linux/compiler_types.h:686:23: note: in definition of macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/ip6_fib.h:557:27: note: in expansion of macro 'READ_ONCE'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                           ^~~~~~~~~
   include/net/ip6_fib.h:557:42: error: 'struct net' has no member named 'ipv6'; did you mean 'ipv4'?
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                          ^~~~
   include/linux/compiler_types.h:642:53: note: in definition of macro '__unqual_scalar_typeof'
     642 | #define __unqual_scalar_typeof(x) __typeof_unqual__(x)
         |                                                     ^
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   include/net/ip6_fib.h:557:27: note: in expansion of macro 'READ_ONCE'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                           ^~~~~~~~~
   In file included from ./arch/openrisc/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:372,
                    from include/linux/build_bug.h:5,
                    from include/linux/bits.h:30,
                    from include/linux/capability.h:18,
                    from net/core/sock.c:89:
   include/net/ip6_fib.h:557:42: error: 'struct net' has no member named 'ipv6'; did you mean 'ipv4'?
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                          ^~~~
   include/asm-generic/rwonce.h:44:73: note: in definition of macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
   include/net/ip6_fib.h:557:27: note: in expansion of macro 'READ_ONCE'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                           ^~~~~~~~~
   In file included from include/net/xfrm.h:26,
                    from net/core/sock.c:133:
>> include/net/ip6_fib.h:557:73: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                                                         ^


vim +557 include/net/ip6_fib.h

   548	
   549	static inline void fib6_may_remove_gc_list(struct net *net,
   550						   struct fib6_info *f6i)
   551	{
   552		struct fib6_gc_args gc_args;
   553	
   554		if (hlist_unhashed(&f6i->gc_link))
   555			return;
   556	
 > 557		gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
   558		gc_args.more = 0,
   559	
   560		fib6_age_exceptions(f6i, &gc_args, jiffies);
   561	}
   562	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

