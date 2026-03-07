Return-Path: <netdev+bounces-265142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CaaHmklrGnnlwEAu9opvQ
	(envelope-from <netdev+bounces-265142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 14:17:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D56E322BE43
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 14:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 513FD301FF9B
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 13:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABE323F417;
	Sat,  7 Mar 2026 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2az5eRw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0270234964
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772889440; cv=none; b=XxfXwJ3xMtLr6GdAZebq9hjefJg+OeHIkzxJK7VcGb8K/On1hecGVWSRCPZIyhSAGHdhNoRmrCAnKDt32jz67Cza5dMuIXxkVPPWOjCE7GIoybjQE8Aaop85G17r6cOS2f6JE4ndGzn/lmTy944HdldpxK8sK4S6SGBL7Jp3kUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772889440; c=relaxed/simple;
	bh=GRvgJUxIPjSIiZV5EA4Z/cXGn1I3X9I/fS97RBSGqrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBt3NAkJUB/Jh5QRUXwJRQTPbifJkdtxgSn928EOndtJa9uj7UgHeEFFK27Az26mBLp+tsx0pWlaU7K8Xj2AK9hZbRjQSAwoVZ3V5DkAfvcfiZQXx65oW0dP4HBnr8jgsFlNeIYSUCXHMJVaZAW93owBhL+N18I/KlS7WlgvJgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2az5eRw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772889438; x=1804425438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GRvgJUxIPjSIiZV5EA4Z/cXGn1I3X9I/fS97RBSGqrY=;
  b=d2az5eRwSFyf+ZW/MTSb6LMmQxov+nvpvG0hCF2JwnZkaSbyPAObEJ9q
   34Dvz4TDXgAc3/uFluVaiHqL+A5aNnajsh24PPJisrzjQkKSlinDAOe3/
   QbyUYH6UcJtVvfdGtlbTCRub/rxpKncuFDmo+9oVDqg50g4kpl3pi+TfQ
   fIADmKNxQCeaibuG2khlUsSxPIT2jzKtQRGkq2GM50r8Zh47dYOE7lSiT
   DQcaYYUq+7b4xI9Opxh6DfOrAbAq+wRs2dEZly7w8SoLYDLfhxj8VM4Ki
   2pFjKzi34VV3XMrp7QTYX6SBGIqU2j6u6OSjhbaZKcHuA4NA7QGA/TC6B
   g==;
X-CSE-ConnectionGUID: r59fA7yvQLm6UVrcegmUBQ==
X-CSE-MsgGUID: YBZMrqDjTp+MDDWBExXRAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="74055178"
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; 
   d="scan'208";a="74055178"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 05:17:17 -0800
X-CSE-ConnectionGUID: rFLfZ19vQ1OBMPhIIJXcvg==
X-CSE-MsgGUID: iuYf0HQHQG20uidNlBxcxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; 
   d="scan'208";a="223971427"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Mar 2026 05:17:14 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyrWq-00000000217-0TYr;
	Sat, 07 Mar 2026 13:17:12 +0000
Date: Sat, 7 Mar 2026 21:16:23 +0800
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
Message-ID: <202603072110.3PSz4SUZ-lkp@intel.com>
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
X-Rspamd-Queue-Id: D56E322BE43
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,kernel.org,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-265142-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url]
X-Rspamd-Action: no action

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/ipv6-Remove-permanent-routes-from-tb6_gc_hlist-when-all-exceptions-expire/20260307-104803
base:   net/main
patch link:    https://lore.kernel.org/r/20260307024709.718395-3-kuniyu%40google.com
patch subject: [PATCH v1 net 2/2] ipv6: Don't remove permanent routes with exceptions from tb6_gc_hlist.
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20260307/202603072110.3PSz4SUZ-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603072110.3PSz4SUZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603072110.3PSz4SUZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   include/net/ip6_fib.h: In function 'fib6_may_remove_gc_list':
>> include/net/ip6_fib.h:557:42: error: 'struct net' has no member named 'ipv6'; did you mean 'ipv4'?
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
>> include/net/ip6_fib.h:557:42: error: 'struct net' has no member named 'ipv6'; did you mean 'ipv4'?
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
>> include/net/ip6_fib.h:557:42: error: 'struct net' has no member named 'ipv6'; did you mean 'ipv4'?
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
>> include/net/ip6_fib.h:557:42: error: 'struct net' has no member named 'ipv6'; did you mean 'ipv4'?
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
>> include/net/ip6_fib.h:557:42: error: 'struct net' has no member named 'ipv6'; did you mean 'ipv4'?
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
>> include/net/ip6_fib.h:557:42: error: 'struct net' has no member named 'ipv6'; did you mean 'ipv4'?
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
>> include/net/ip6_fib.h:557:42: error: 'struct net' has no member named 'ipv6'; did you mean 'ipv4'?
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
   include/net/ip6_fib.h:557:73: warning: left-hand operand of comma expression has no effect [-Wunused-value]
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

