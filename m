Return-Path: <netdev+bounces-127050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D087E973D88
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB0F284ECA
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0473618FC81;
	Tue, 10 Sep 2024 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6z6aOk2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BD618132A;
	Tue, 10 Sep 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725986580; cv=none; b=Dov7A4sglJAArACfUs6549T17D6lD5qVFf64nLWmJhwiUATJM38tf5ci5wY20kSIz1qlANdi//Et9HyxzPM8dRT+TvDac4ro80UbeemJ2/9Iu5kS0yKg+rxz1iBFx9SsZhm+HXiAzijH1DghjSaLSn1tauv5nL9i157BETaI2ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725986580; c=relaxed/simple;
	bh=LjsXT6LIhygj/TwleDUnGDeoGP4p0mHvwmvUHaoM33Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCLPMVaVATyxus+3m21w12GgCQj1M4sEJm6dwaw7oqFVW/UDtTL/+Kfr4Mywv7hiAcgVNp0Lx+iFRtHs/5qI+oXaESR3TOc0LiqvOJSODJV/OC2G88ikpW6AoPXVLYMn0mQBjnX3FSE45zdP8oIoAunEQCR10MSV7bsRZ0GnB6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B6z6aOk2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725986579; x=1757522579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LjsXT6LIhygj/TwleDUnGDeoGP4p0mHvwmvUHaoM33Q=;
  b=B6z6aOk2rB9ItsO1gFdt3m75VbdF0dnAZfMcsoFE32wYt6t6HEleC9dB
   7iONKEk1v2XS0ah2SjQk4XZ/AqJ1WHD8S1ZI/K++scCaysVehpLhrIIJ3
   +FC6hhRsRTZnE1TN4mF1OTzr77TK7+Ii/afdpvx1tyPNtMoG/gJSIHEty
   d7Ed+DakRPqmcNbM4/ObL1IfOMlcDRpDt+8m0s6Un3OaI1KW8FB/OxWWl
   GsVLP0fqLsNKJpUg0IOIElXhGaJOGdSwk5Z4eVubtprr6TKtylEOv+9yH
   2NKLkhPylQN/MTbk+7cb9sF9AltucIxOBo9r8zFPztus4RIVYMvMFM77t
   A==;
X-CSE-ConnectionGUID: jJ+N+4I5QCuywIOFQyapfw==
X-CSE-MsgGUID: cZQmv9l3SSSAdUxAHhW0DQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24290331"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="24290331"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 09:42:57 -0700
X-CSE-ConnectionGUID: P/oB79SeSb+aHUxrJofGzA==
X-CSE-MsgGUID: IQPaY4lXSauZow6hlEhZ1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="66921826"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 10 Sep 2024 09:42:54 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1so3x5-0002OK-32;
	Tue, 10 Sep 2024 16:42:51 +0000
Date: Wed, 11 Sep 2024 00:42:48 +0800
From: kernel test robot <lkp@intel.com>
To: Jeongjun Park <aha310510@gmail.com>, davem@davemloft.net,
	dsahern@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	kafai@fb.com, weiwan@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeongjun Park <aha310510@gmail.com>
Subject: Re: [PATCH net] net: prevent NULL pointer dereference in
 rt_fibinfo_free() and rt_fibinfo_free_cpus()
Message-ID: <202409110000.E9IVjdB7-lkp@intel.com>
References: <20240909184827.123071-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909184827.123071-1-aha310510@gmail.com>

Hi Jeongjun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeongjun-Park/net-prevent-NULL-pointer-dereference-in-rt_fibinfo_free-and-rt_fibinfo_free_cpus/20240910-025008
base:   net/main
patch link:    https://lore.kernel.org/r/20240909184827.123071-1-aha310510%40gmail.com
patch subject: [PATCH net] net: prevent NULL pointer dereference in rt_fibinfo_free() and rt_fibinfo_free_cpus()
config: arm-randconfig-001-20240910 (https://download.01.org/0day-ci/archive/20240911/202409110000.E9IVjdB7-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 05f5a91d00b02f4369f46d076411c700755ae041)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240911/202409110000.E9IVjdB7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409110000.E9IVjdB7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/ipv4/fib_semantics.c:17:
   In file included from include/linux/mm.h:2232:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> net/ipv4/fib_semantics.c:156:12: warning: address of 'rt->dst' will always evaluate to 'true' [-Wpointer-bool-conversion]
     156 |         if (!&rt->dst)
         |             ~ ~~~~^~~
   net/ipv4/fib_semantics.c:209:13: warning: address of 'rt->dst' will always evaluate to 'true' [-Wpointer-bool-conversion]
     209 |                 if (!&rt->dst)
         |                     ~ ~~~~^~~
   3 warnings generated.


vim +156 net/ipv4/fib_semantics.c

  > 17	#include <linux/mm.h>
    18	#include <linux/string.h>
    19	#include <linux/socket.h>
    20	#include <linux/sockios.h>
    21	#include <linux/errno.h>
    22	#include <linux/in.h>
    23	#include <linux/inet.h>
    24	#include <linux/inetdevice.h>
    25	#include <linux/netdevice.h>
    26	#include <linux/if_arp.h>
    27	#include <linux/proc_fs.h>
    28	#include <linux/skbuff.h>
    29	#include <linux/init.h>
    30	#include <linux/slab.h>
    31	#include <linux/netlink.h>
    32	#include <linux/hash.h>
    33	#include <linux/nospec.h>
    34	
    35	#include <net/arp.h>
    36	#include <net/inet_dscp.h>
    37	#include <net/ip.h>
    38	#include <net/protocol.h>
    39	#include <net/route.h>
    40	#include <net/tcp.h>
    41	#include <net/sock.h>
    42	#include <net/ip_fib.h>
    43	#include <net/ip6_fib.h>
    44	#include <net/nexthop.h>
    45	#include <net/netlink.h>
    46	#include <net/rtnh.h>
    47	#include <net/lwtunnel.h>
    48	#include <net/fib_notifier.h>
    49	#include <net/addrconf.h>
    50	
    51	#include "fib_lookup.h"
    52	
    53	static DEFINE_SPINLOCK(fib_info_lock);
    54	static struct hlist_head *fib_info_hash;
    55	static struct hlist_head *fib_info_laddrhash;
    56	static unsigned int fib_info_hash_size;
    57	static unsigned int fib_info_hash_bits;
    58	static unsigned int fib_info_cnt;
    59	
    60	#define DEVINDEX_HASHBITS 8
    61	#define DEVINDEX_HASHSIZE (1U << DEVINDEX_HASHBITS)
    62	static struct hlist_head fib_info_devhash[DEVINDEX_HASHSIZE];
    63	
    64	/* for_nexthops and change_nexthops only used when nexthop object
    65	 * is not set in a fib_info. The logic within can reference fib_nh.
    66	 */
    67	#ifdef CONFIG_IP_ROUTE_MULTIPATH
    68	
    69	#define for_nexthops(fi) {						\
    70		int nhsel; const struct fib_nh *nh;				\
    71		for (nhsel = 0, nh = (fi)->fib_nh;				\
    72		     nhsel < fib_info_num_path((fi));				\
    73		     nh++, nhsel++)
    74	
    75	#define change_nexthops(fi) {						\
    76		int nhsel; struct fib_nh *nexthop_nh;				\
    77		for (nhsel = 0,	nexthop_nh = (struct fib_nh *)((fi)->fib_nh);	\
    78		     nhsel < fib_info_num_path((fi));				\
    79		     nexthop_nh++, nhsel++)
    80	
    81	#else /* CONFIG_IP_ROUTE_MULTIPATH */
    82	
    83	/* Hope, that gcc will optimize it to get rid of dummy loop */
    84	
    85	#define for_nexthops(fi) {						\
    86		int nhsel; const struct fib_nh *nh = (fi)->fib_nh;		\
    87		for (nhsel = 0; nhsel < 1; nhsel++)
    88	
    89	#define change_nexthops(fi) {						\
    90		int nhsel;							\
    91		struct fib_nh *nexthop_nh = (struct fib_nh *)((fi)->fib_nh);	\
    92		for (nhsel = 0; nhsel < 1; nhsel++)
    93	
    94	#endif /* CONFIG_IP_ROUTE_MULTIPATH */
    95	
    96	#define endfor_nexthops(fi) }
    97	
    98	
    99	const struct fib_prop fib_props[RTN_MAX + 1] = {
   100		[RTN_UNSPEC] = {
   101			.error	= 0,
   102			.scope	= RT_SCOPE_NOWHERE,
   103		},
   104		[RTN_UNICAST] = {
   105			.error	= 0,
   106			.scope	= RT_SCOPE_UNIVERSE,
   107		},
   108		[RTN_LOCAL] = {
   109			.error	= 0,
   110			.scope	= RT_SCOPE_HOST,
   111		},
   112		[RTN_BROADCAST] = {
   113			.error	= 0,
   114			.scope	= RT_SCOPE_LINK,
   115		},
   116		[RTN_ANYCAST] = {
   117			.error	= 0,
   118			.scope	= RT_SCOPE_LINK,
   119		},
   120		[RTN_MULTICAST] = {
   121			.error	= 0,
   122			.scope	= RT_SCOPE_UNIVERSE,
   123		},
   124		[RTN_BLACKHOLE] = {
   125			.error	= -EINVAL,
   126			.scope	= RT_SCOPE_UNIVERSE,
   127		},
   128		[RTN_UNREACHABLE] = {
   129			.error	= -EHOSTUNREACH,
   130			.scope	= RT_SCOPE_UNIVERSE,
   131		},
   132		[RTN_PROHIBIT] = {
   133			.error	= -EACCES,
   134			.scope	= RT_SCOPE_UNIVERSE,
   135		},
   136		[RTN_THROW] = {
   137			.error	= -EAGAIN,
   138			.scope	= RT_SCOPE_UNIVERSE,
   139		},
   140		[RTN_NAT] = {
   141			.error	= -EINVAL,
   142			.scope	= RT_SCOPE_NOWHERE,
   143		},
   144		[RTN_XRESOLVE] = {
   145			.error	= -EINVAL,
   146			.scope	= RT_SCOPE_NOWHERE,
   147		},
   148	};
   149	
   150	static void rt_fibinfo_free(struct rtable __rcu **rtp)
   151	{
   152		struct rtable *rt = rcu_dereference_protected(*rtp, 1);
   153	
   154		if (!rt)
   155			return;
 > 156		if (!&rt->dst)
   157			return;
   158	
   159		/* Not even needed : RCU_INIT_POINTER(*rtp, NULL);
   160		 * because we waited an RCU grace period before calling
   161		 * free_fib_info_rcu()
   162		 */
   163	
   164		dst_dev_put(&rt->dst);
   165		dst_release_immediate(&rt->dst);
   166	}
   167	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

