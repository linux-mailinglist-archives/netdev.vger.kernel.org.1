Return-Path: <netdev+bounces-154734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990809FF9F0
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 14:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0EB3A2055
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 13:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4328919D898;
	Thu,  2 Jan 2025 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QTNAdG3/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D65D517;
	Thu,  2 Jan 2025 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735825726; cv=none; b=Qe0D4MCFNpfW3WgyopEkEa8CxPdy5Ze2GwOtU8Bxa0L/9fntbFmviHSh/1SFKnQHmZWtr/G3kvcauK/BmffZeP8iie4lO84sarqxNKtAW6+ERJZyGslz/FoxV0pec8y+WAamU+LRjUy3qw86SYTRN/rx+vCbpzBDohjeUyTRL0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735825726; c=relaxed/simple;
	bh=Y3+WpI94jB0bqBKTVWD/pTzMcHhaR3wsC0lMWCTicOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjtgQCjM+tTBWNSbW+ptV3gm35dh4HhYHccK+BzWHxKJEI54ZsfEYh8pGJ6M6oNMwRUtC45BxKPIeY0xh7qVLhLLGDzGsIPe1iNTlLWLDWq+oQE7MLKZa8YG8HvG8Zebw+XlQO2V2XUa9vNeumiDr1Sapn1wANRqPsB6G0sVBqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QTNAdG3/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735825723; x=1767361723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y3+WpI94jB0bqBKTVWD/pTzMcHhaR3wsC0lMWCTicOI=;
  b=QTNAdG3/geCPIjnmqTVdJtGrAu7ehGkgNBvPGaxWlDi7XXIlZpiM6rIO
   1hvq2E9OgrHV3OUC5T9s/dmZbC+OoCbRuZw90VjkCGjHd0DcMb+Rbqvhq
   kUb1IRDfQMzgd8bdhuKLbQGSLcLEZrAuCWYlg4YYYdPFhd5WBJRRnaeX8
   NtA7w5KkNNitHOnZ+GiIigDz/jPsxehNMTZlk6dTHOywOfQdwP0PgWeOg
   6B/zmFa1mpf8UIH9Czy+xk77nG2vXUZlpKZrYWU4/DpFYNe+i0IgNSyrB
   w/aeArYqfeYb8GmZX8Sr/gpjlGnQmn+bpqqBf40rUGDn5YdS0cXfKclEl
   w==;
X-CSE-ConnectionGUID: 8FTiPHOxQ5ud8wIyAqDabw==
X-CSE-MsgGUID: 3ZUanwwRQtGweYpMCURsFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36078429"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="36078429"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 05:48:42 -0800
X-CSE-ConnectionGUID: a7G1PdnqSdypEPN40UO4dQ==
X-CSE-MsgGUID: y2MeSAy2QMmHsH/LVO8g0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101996533"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 02 Jan 2025 05:48:37 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTLYx-0008X5-0E;
	Thu, 02 Jan 2025 13:48:35 +0000
Date: Thu, 2 Jan 2025 21:48:14 +0800
From: kernel test robot <lkp@intel.com>
To: shiming cheng <shiming.cheng@mediatek.com>,
	willemdebruijn.kernel@gmail.com, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	lena.wang@mediatek.com, shiming cheng <shiming.cheng@mediatek.com>
Subject: Re: [PATCH]  ipv6: socket SO_BINDTODEVICE lookup routing fail
 without IPv6 rule.
Message-ID: <202501022159.X5KKqJoW-lkp@intel.com>
References: <20250102095114.25860-1-shiming.cheng@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102095114.25860-1-shiming.cheng@mediatek.com>

Hi shiming,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v6.13-rc5 next-20241220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shiming-cheng/ipv6-socket-SO_BINDTODEVICE-lookup-routing-fail-without-IPv6-rule/20250102-174939
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250102095114.25860-1-shiming.cheng%40mediatek.com
patch subject: [PATCH]  ipv6: socket SO_BINDTODEVICE lookup routing fail without IPv6 rule.
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20250102/202501022159.X5KKqJoW-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250102/202501022159.X5KKqJoW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501022159.X5KKqJoW-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:18,
                    from net/ipv6/ip6_output.c:26:
   net/ipv6/ip6_output.c: In function 'ip6_dst_lookup_tail':
>> net/ipv6/ip6_output.c:1243:19: error: non-static declaration of 'ip6_dst_lookup' follows static declaration
    1243 | EXPORT_SYMBOL_GPL(ip6_dst_lookup);
         |                   ^~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   net/ipv6/ip6_output.c:1243:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1243 | EXPORT_SYMBOL_GPL(ip6_dst_lookup);
         | ^~~~~~~~~~~~~~~~~
   net/ipv6/ip6_output.c:1237:5: note: previous definition of 'ip6_dst_lookup' with type 'int(struct net *, struct sock *, struct dst_entry **, struct flowi6 *)'
    1237 | int ip6_dst_lookup(struct net *net, struct sock *sk, struct dst_entry **dst,
         |     ^~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:18,
                    from net/ipv6/ip6_output.c:26:
>> net/ipv6/ip6_output.c:1271:19: error: non-static declaration of 'ip6_dst_lookup_flow' follows static declaration
    1271 | EXPORT_SYMBOL_GPL(ip6_dst_lookup_flow);
         |                   ^~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   net/ipv6/ip6_output.c:1271:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1271 | EXPORT_SYMBOL_GPL(ip6_dst_lookup_flow);
         | ^~~~~~~~~~~~~~~~~
   net/ipv6/ip6_output.c:1257:19: note: previous definition of 'ip6_dst_lookup_flow' with type 'struct dst_entry *(struct net *, const struct sock *, struct flowi6 *, const struct in6_addr *)'
    1257 | struct dst_entry *ip6_dst_lookup_flow(struct net *net, const struct sock *sk, struct flowi6 *fl6,
         |                   ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:18,
                    from net/ipv6/ip6_output.c:26:
>> net/ipv6/ip6_output.c:1307:19: error: non-static declaration of 'ip6_sk_dst_lookup_flow' follows static declaration
    1307 | EXPORT_SYMBOL_GPL(ip6_sk_dst_lookup_flow);
         |                   ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   net/ipv6/ip6_output.c:1307:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1307 | EXPORT_SYMBOL_GPL(ip6_sk_dst_lookup_flow);
         | ^~~~~~~~~~~~~~~~~
   net/ipv6/ip6_output.c:1291:19: note: previous definition of 'ip6_sk_dst_lookup_flow' with type 'struct dst_entry *(struct sock *, struct flowi6 *, const struct in6_addr *, bool)' {aka 'struct dst_entry *(struct sock *, struct flowi6 *, const struct in6_addr *, _Bool)'}
    1291 | struct dst_entry *ip6_sk_dst_lookup_flow(struct sock *sk, struct flowi6 *fl6,
         |                   ^~~~~~~~~~~~~~~~~~~~~~
>> net/ipv6/ip6_output.c:1309:36: error: invalid storage class for function 'ip6_opt_dup'
    1309 | static inline struct ipv6_opt_hdr *ip6_opt_dup(struct ipv6_opt_hdr *src,
         |                                    ^~~~~~~~~~~
>> net/ipv6/ip6_output.c:1315:35: error: invalid storage class for function 'ip6_rthdr_dup'
    1315 | static inline struct ipv6_rt_hdr *ip6_rthdr_dup(struct ipv6_rt_hdr *src,
         |                                   ^~~~~~~~~~~~~
>> net/ipv6/ip6_output.c:1321:13: error: invalid storage class for function 'ip6_append_data_mtu'
    1321 | static void ip6_append_data_mtu(unsigned int *mtu,
         |             ^~~~~~~~~~~~~~~~~~~
>> net/ipv6/ip6_output.c:1345:12: error: invalid storage class for function 'ip6_setup_cork'
    1345 | static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
         |            ^~~~~~~~~~~~~~
>> net/ipv6/ip6_output.c:1420:12: error: invalid storage class for function '__ip6_append_data'
    1420 | static int __ip6_append_data(struct sock *sk,
         |            ^~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:18,
                    from net/ipv6/ip6_output.c:26:
>> net/ipv6/ip6_output.c:1864:19: error: non-static declaration of 'ip6_append_data' follows static declaration
    1864 | EXPORT_SYMBOL_GPL(ip6_append_data);
         |                   ^~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   net/ipv6/ip6_output.c:1864:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1864 | EXPORT_SYMBOL_GPL(ip6_append_data);
         | ^~~~~~~~~~~~~~~~~
   net/ipv6/ip6_output.c:1828:5: note: previous definition of 'ip6_append_data' with type 'int(struct sock *, int (*)(void *, char *, int,  int,  int,  struct sk_buff *), void *, size_t,  int,  struct ipcm6_cookie *, struct flowi6 *, struct rt6_info *, unsigned int)' {aka 'int(struct sock *, int (*)(void *, char *, int,  int,  int,  struct sk_buff *), void *, long unsigned int,  int,  struct ipcm6_cookie *, struct flowi6 *, struct rt6_info *, unsigned int)'}
    1828 | int ip6_append_data(struct sock *sk,
         |     ^~~~~~~~~~~~~~~
>> net/ipv6/ip6_output.c:1866:13: error: invalid storage class for function 'ip6_cork_steal_dst'
    1866 | static void ip6_cork_steal_dst(struct sk_buff *skb, struct inet_cork_full *cork)
         |             ^~~~~~~~~~~~~~~~~~
>> net/ipv6/ip6_output.c:1874:13: error: invalid storage class for function 'ip6_cork_release'
    1874 | static void ip6_cork_release(struct inet_cork_full *cork,
         |             ^~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:18,
                    from net/ipv6/ip6_output.c:26:
>> net/ipv6/ip6_output.c:2007:19: error: non-static declaration of 'ip6_push_pending_frames' follows static declaration
    2007 | EXPORT_SYMBOL_GPL(ip6_push_pending_frames);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   net/ipv6/ip6_output.c:2007:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    2007 | EXPORT_SYMBOL_GPL(ip6_push_pending_frames);
         | ^~~~~~~~~~~~~~~~~
   net/ipv6/ip6_output.c:1997:5: note: previous definition of 'ip6_push_pending_frames' with type 'int(struct sock *)'
    1997 | int ip6_push_pending_frames(struct sock *sk)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> net/ipv6/ip6_output.c:2009:13: error: invalid storage class for function '__ip6_flush_pending_frames'
    2009 | static void __ip6_flush_pending_frames(struct sock *sk,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:18,
                    from net/ipv6/ip6_output.c:26:
>> net/ipv6/ip6_output.c:2031:19: error: non-static declaration of 'ip6_flush_pending_frames' follows static declaration
    2031 | EXPORT_SYMBOL_GPL(ip6_flush_pending_frames);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   net/ipv6/ip6_output.c:2031:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    2031 | EXPORT_SYMBOL_GPL(ip6_flush_pending_frames);
         | ^~~~~~~~~~~~~~~~~
   net/ipv6/ip6_output.c:2026:6: note: previous definition of 'ip6_flush_pending_frames' with type 'void(struct sock *)'
    2026 | void ip6_flush_pending_frames(struct sock *sk)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
>> net/ipv6/ip6_output.c:2074:1: error: expected declaration or statement at end of input
    2074 | }
         | ^
   At top level:
   net/ipv6/ip6_output.c:2033:17: warning: 'ip6_make_skb' defined but not used [-Wunused-function]
    2033 | struct sk_buff *ip6_make_skb(struct sock *sk,
         |                 ^~~~~~~~~~~~


vim +/ip6_dst_lookup +1243 net/ipv6/ip6_output.c

34a0b3cdc07874 Adrian Bunk              2005-11-29  1225  
497c615abad7ee Herbert Xu               2006-07-30  1226  /**
497c615abad7ee Herbert Xu               2006-07-30  1227   *	ip6_dst_lookup - perform route lookup on flow
b51cd7c834dba0 Andrew Lunn              2020-07-13  1228   *	@net: Network namespace to perform lookup in
497c615abad7ee Herbert Xu               2006-07-30  1229   *	@sk: socket which provides route info
497c615abad7ee Herbert Xu               2006-07-30  1230   *	@dst: pointer to dst_entry * for result
4c9483b2fb5d25 David S. Miller          2011-03-12  1231   *	@fl6: flow to lookup
497c615abad7ee Herbert Xu               2006-07-30  1232   *
497c615abad7ee Herbert Xu               2006-07-30  1233   *	This function performs a route lookup on the given flow.
497c615abad7ee Herbert Xu               2006-07-30  1234   *
497c615abad7ee Herbert Xu               2006-07-30  1235   *	It returns zero on success, or a standard errno code on error.
497c615abad7ee Herbert Xu               2006-07-30  1236   */
343d60aada5a35 Roopa Prabhu             2015-07-30  1237  int ip6_dst_lookup(struct net *net, struct sock *sk, struct dst_entry **dst,
343d60aada5a35 Roopa Prabhu             2015-07-30  1238  		   struct flowi6 *fl6)
497c615abad7ee Herbert Xu               2006-07-30  1239  {
497c615abad7ee Herbert Xu               2006-07-30  1240  	*dst = NULL;
343d60aada5a35 Roopa Prabhu             2015-07-30  1241  	return ip6_dst_lookup_tail(net, sk, dst, fl6);
497c615abad7ee Herbert Xu               2006-07-30  1242  }
3cf3dc6c2e05e6 Arnaldo Carvalho de Melo 2005-12-13 @1243  EXPORT_SYMBOL_GPL(ip6_dst_lookup);
3cf3dc6c2e05e6 Arnaldo Carvalho de Melo 2005-12-13  1244  
497c615abad7ee Herbert Xu               2006-07-30  1245  /**
68d0c6d34d586a David S. Miller          2011-03-01  1246   *	ip6_dst_lookup_flow - perform route lookup on flow with ipsec
b51cd7c834dba0 Andrew Lunn              2020-07-13  1247   *	@net: Network namespace to perform lookup in
68d0c6d34d586a David S. Miller          2011-03-01  1248   *	@sk: socket which provides route info
4c9483b2fb5d25 David S. Miller          2011-03-12  1249   *	@fl6: flow to lookup
68d0c6d34d586a David S. Miller          2011-03-01  1250   *	@final_dst: final destination address for ipsec lookup
68d0c6d34d586a David S. Miller          2011-03-01  1251   *
68d0c6d34d586a David S. Miller          2011-03-01  1252   *	This function performs a route lookup on the given flow.
68d0c6d34d586a David S. Miller          2011-03-01  1253   *
68d0c6d34d586a David S. Miller          2011-03-01  1254   *	It returns a valid dst pointer on success, or a pointer encoded
68d0c6d34d586a David S. Miller          2011-03-01  1255   *	error code.
68d0c6d34d586a David S. Miller          2011-03-01  1256   */
c4e85f73afb638 Sabrina Dubroca          2019-12-04  1257  struct dst_entry *ip6_dst_lookup_flow(struct net *net, const struct sock *sk, struct flowi6 *fl6,
0e0d44ab427554 Steffen Klassert         2013-08-28  1258  				      const struct in6_addr *final_dst)
68d0c6d34d586a David S. Miller          2011-03-01  1259  {
68d0c6d34d586a David S. Miller          2011-03-01  1260  	struct dst_entry *dst = NULL;
68d0c6d34d586a David S. Miller          2011-03-01  1261  	int err;
68d0c6d34d586a David S. Miller          2011-03-01  1262  
c4e85f73afb638 Sabrina Dubroca          2019-12-04  1263  	err = ip6_dst_lookup_tail(net, sk, &dst, fl6);
68d0c6d34d586a David S. Miller          2011-03-01  1264  	if (err)
68d0c6d34d586a David S. Miller          2011-03-01  1265  		return ERR_PTR(err);
68d0c6d34d586a David S. Miller          2011-03-01  1266  	if (final_dst)
4e3fd7a06dc20b Alexey Dobriyan          2011-11-21  1267  		fl6->daddr = *final_dst;
2774c131b1d199 David S. Miller          2011-03-01  1268  
c4e85f73afb638 Sabrina Dubroca          2019-12-04  1269  	return xfrm_lookup_route(net, dst, flowi6_to_flowi(fl6), sk, 0);
68d0c6d34d586a David S. Miller          2011-03-01  1270  }
68d0c6d34d586a David S. Miller          2011-03-01 @1271  EXPORT_SYMBOL_GPL(ip6_dst_lookup_flow);
68d0c6d34d586a David S. Miller          2011-03-01  1272  
68d0c6d34d586a David S. Miller          2011-03-01  1273  /**
68d0c6d34d586a David S. Miller          2011-03-01  1274   *	ip6_sk_dst_lookup_flow - perform socket cached route lookup on flow
497c615abad7ee Herbert Xu               2006-07-30  1275   *	@sk: socket which provides the dst cache and route info
4c9483b2fb5d25 David S. Miller          2011-03-12  1276   *	@fl6: flow to lookup
68d0c6d34d586a David S. Miller          2011-03-01  1277   *	@final_dst: final destination address for ipsec lookup
96818159c3c089 Alexey Kodanev           2018-04-03  1278   *	@connected: whether @sk is connected or not
497c615abad7ee Herbert Xu               2006-07-30  1279   *
497c615abad7ee Herbert Xu               2006-07-30  1280   *	This function performs a route lookup on the given flow with the
497c615abad7ee Herbert Xu               2006-07-30  1281   *	possibility of using the cached route in the socket if it is valid.
497c615abad7ee Herbert Xu               2006-07-30  1282   *	It will take the socket dst lock when operating on the dst cache.
497c615abad7ee Herbert Xu               2006-07-30  1283   *	As a result, this function can only be used in process context.
497c615abad7ee Herbert Xu               2006-07-30  1284   *
96818159c3c089 Alexey Kodanev           2018-04-03  1285   *	In addition, for a connected socket, cache the dst in the socket
96818159c3c089 Alexey Kodanev           2018-04-03  1286   *	if the current cache is not valid.
96818159c3c089 Alexey Kodanev           2018-04-03  1287   *
68d0c6d34d586a David S. Miller          2011-03-01  1288   *	It returns a valid dst pointer on success, or a pointer encoded
68d0c6d34d586a David S. Miller          2011-03-01  1289   *	error code.
497c615abad7ee Herbert Xu               2006-07-30  1290   */
4c9483b2fb5d25 David S. Miller          2011-03-12  1291  struct dst_entry *ip6_sk_dst_lookup_flow(struct sock *sk, struct flowi6 *fl6,
96818159c3c089 Alexey Kodanev           2018-04-03  1292  					 const struct in6_addr *final_dst,
96818159c3c089 Alexey Kodanev           2018-04-03  1293  					 bool connected)
497c615abad7ee Herbert Xu               2006-07-30  1294  {
68d0c6d34d586a David S. Miller          2011-03-01  1295  	struct dst_entry *dst = sk_dst_check(sk, inet6_sk(sk)->dst_cookie);
497c615abad7ee Herbert Xu               2006-07-30  1296  
4c9483b2fb5d25 David S. Miller          2011-03-12  1297  	dst = ip6_sk_dst_check(sk, dst, fl6);
96818159c3c089 Alexey Kodanev           2018-04-03  1298  	if (dst)
96818159c3c089 Alexey Kodanev           2018-04-03  1299  		return dst;
96818159c3c089 Alexey Kodanev           2018-04-03  1300  
c4e85f73afb638 Sabrina Dubroca          2019-12-04  1301  	dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_dst);
96818159c3c089 Alexey Kodanev           2018-04-03  1302  	if (connected && !IS_ERR(dst))
96818159c3c089 Alexey Kodanev           2018-04-03  1303  		ip6_sk_dst_store_flow(sk, dst_clone(dst), fl6);
68d0c6d34d586a David S. Miller          2011-03-01  1304  
00bc0ef5880dc7 Jakub Sitnicki           2016-06-08  1305  	return dst;
497c615abad7ee Herbert Xu               2006-07-30  1306  }
68d0c6d34d586a David S. Miller          2011-03-01 @1307  EXPORT_SYMBOL_GPL(ip6_sk_dst_lookup_flow);
497c615abad7ee Herbert Xu               2006-07-30  1308  
0178b695fd6b40 Herbert Xu               2009-02-05 @1309  static inline struct ipv6_opt_hdr *ip6_opt_dup(struct ipv6_opt_hdr *src,
0178b695fd6b40 Herbert Xu               2009-02-05  1310  					       gfp_t gfp)
0178b695fd6b40 Herbert Xu               2009-02-05  1311  {
0178b695fd6b40 Herbert Xu               2009-02-05  1312  	return src ? kmemdup(src, (src->hdrlen + 1) * 8, gfp) : NULL;
0178b695fd6b40 Herbert Xu               2009-02-05  1313  }
0178b695fd6b40 Herbert Xu               2009-02-05  1314  
0178b695fd6b40 Herbert Xu               2009-02-05 @1315  static inline struct ipv6_rt_hdr *ip6_rthdr_dup(struct ipv6_rt_hdr *src,
0178b695fd6b40 Herbert Xu               2009-02-05  1316  						gfp_t gfp)
0178b695fd6b40 Herbert Xu               2009-02-05  1317  {
0178b695fd6b40 Herbert Xu               2009-02-05  1318  	return src ? kmemdup(src, (src->hdrlen + 1) * 8, gfp) : NULL;
0178b695fd6b40 Herbert Xu               2009-02-05  1319  }
0178b695fd6b40 Herbert Xu               2009-02-05  1320  
75a493e60ac4bb Hannes Frederic Sowa     2013-07-02 @1321  static void ip6_append_data_mtu(unsigned int *mtu,
0c1833797a5a6e Gao feng                 2012-05-26  1322  				int *maxfraglen,
0c1833797a5a6e Gao feng                 2012-05-26  1323  				unsigned int fragheaderlen,
0c1833797a5a6e Gao feng                 2012-05-26  1324  				struct sk_buff *skb,
75a493e60ac4bb Hannes Frederic Sowa     2013-07-02  1325  				struct rt6_info *rt,
e367c2d03dba4c lucien                   2014-03-17  1326  				unsigned int orig_mtu)
0c1833797a5a6e Gao feng                 2012-05-26  1327  {
0c1833797a5a6e Gao feng                 2012-05-26  1328  	if (!(rt->dst.flags & DST_XFRM_TUNNEL)) {
63159f29be1df7 Ian Morris               2015-03-29  1329  		if (!skb) {
0c1833797a5a6e Gao feng                 2012-05-26  1330  			/* first fragment, reserve header_len */
e367c2d03dba4c lucien                   2014-03-17  1331  			*mtu = orig_mtu - rt->dst.header_len;
0c1833797a5a6e Gao feng                 2012-05-26  1332  
0c1833797a5a6e Gao feng                 2012-05-26  1333  		} else {
0c1833797a5a6e Gao feng                 2012-05-26  1334  			/*
0c1833797a5a6e Gao feng                 2012-05-26  1335  			 * this fragment is not first, the headers
0c1833797a5a6e Gao feng                 2012-05-26  1336  			 * space is regarded as data space.
0c1833797a5a6e Gao feng                 2012-05-26  1337  			 */
e367c2d03dba4c lucien                   2014-03-17  1338  			*mtu = orig_mtu;
0c1833797a5a6e Gao feng                 2012-05-26  1339  		}
0c1833797a5a6e Gao feng                 2012-05-26  1340  		*maxfraglen = ((*mtu - fragheaderlen) & ~7)
0c1833797a5a6e Gao feng                 2012-05-26  1341  			      + fragheaderlen - sizeof(struct frag_hdr);
0c1833797a5a6e Gao feng                 2012-05-26  1342  	}
0c1833797a5a6e Gao feng                 2012-05-26  1343  }
0c1833797a5a6e Gao feng                 2012-05-26  1344  
366e41d9774d70 Vlad Yasevich            2015-01-31 @1345  static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
26879da58711aa Wei Wang                 2016-05-02  1346  			  struct inet6_cork *v6_cork, struct ipcm6_cookie *ipc6,
f37a4cc6bb0ba0 Pavel Begunkov           2022-01-27  1347  			  struct rt6_info *rt)
^1da177e4c3f41 Linus Torvalds           2005-04-16  1348  {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1349  	struct ipv6_pinfo *np = inet6_sk(sk);
15f926c4457aa6 Eric Dumazet             2023-09-12  1350  	unsigned int mtu, frag_size;
d656b2ea5fa797 Pavel Begunkov           2022-01-27  1351  	struct ipv6_txoptions *nopt, *opt = ipc6->opt;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1352  
40ac240c2e06e4 Pavel Begunkov           2022-01-27  1353  	/* callers pass dst together with a reference, set it first so
40ac240c2e06e4 Pavel Begunkov           2022-01-27  1354  	 * ip6_cork_release() can put it down even in case of an error.
40ac240c2e06e4 Pavel Begunkov           2022-01-27  1355  	 */
40ac240c2e06e4 Pavel Begunkov           2022-01-27  1356  	cork->base.dst = &rt->dst;
40ac240c2e06e4 Pavel Begunkov           2022-01-27  1357  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1358  	/*
^1da177e4c3f41 Linus Torvalds           2005-04-16  1359  	 * setup for corking
^1da177e4c3f41 Linus Torvalds           2005-04-16  1360  	 */
^1da177e4c3f41 Linus Torvalds           2005-04-16  1361  	if (opt) {
366e41d9774d70 Vlad Yasevich            2015-01-31  1362  		if (WARN_ON(v6_cork->opt))
0178b695fd6b40 Herbert Xu               2009-02-05  1363  			return -EINVAL;
0178b695fd6b40 Herbert Xu               2009-02-05  1364  
d656b2ea5fa797 Pavel Begunkov           2022-01-27  1365  		nopt = v6_cork->opt = kzalloc(sizeof(*opt), sk->sk_allocation);
d656b2ea5fa797 Pavel Begunkov           2022-01-27  1366  		if (unlikely(!nopt))
^1da177e4c3f41 Linus Torvalds           2005-04-16  1367  			return -ENOBUFS;
0178b695fd6b40 Herbert Xu               2009-02-05  1368  
d656b2ea5fa797 Pavel Begunkov           2022-01-27  1369  		nopt->tot_len = sizeof(*opt);
d656b2ea5fa797 Pavel Begunkov           2022-01-27  1370  		nopt->opt_flen = opt->opt_flen;
d656b2ea5fa797 Pavel Begunkov           2022-01-27  1371  		nopt->opt_nflen = opt->opt_nflen;
0178b695fd6b40 Herbert Xu               2009-02-05  1372  
d656b2ea5fa797 Pavel Begunkov           2022-01-27  1373  		nopt->dst0opt = ip6_opt_dup(opt->dst0opt, sk->sk_allocation);
d656b2ea5fa797 Pavel Begunkov           2022-01-27  1374  		if (opt->dst0opt && !nopt->dst0opt)
0178b695fd6b40 Herbert Xu               2009-02-05  1375  			return -ENOBUFS;
0178b695fd6b40 Herbert Xu               2009-02-05  1376  
d656b2ea5fa797 Pavel Begunkov           2022-01-27  1377  		nopt->dst1opt = ip6_opt_dup(opt->dst1opt, sk->sk_allocation);
d656b2ea5fa797 Pavel Begunkov           2022-01-27  1378  		if (opt->dst1opt && !nopt->dst1opt)
0178b695fd6b40 Herbert Xu               2009-02-05  1379  			return -ENOBUFS;
0178b695fd6b40 Herbert Xu               2009-02-05  1380  
d656b2ea5fa797 Pavel Begunkov           2022-01-27  1381  		nopt->hopopt = ip6_opt_dup(opt->hopopt, sk->sk_allocation);
d656b2ea5fa797 Pavel Begunkov           2022-01-27  1382  		if (opt->hopopt && !nopt->hopopt)
0178b695fd6b40 Herbert Xu               2009-02-05  1383  			return -ENOBUFS;
0178b695fd6b40 Herbert Xu               2009-02-05  1384  
d656b2ea5fa797 Pavel Begunkov           2022-01-27  1385  		nopt->srcrt = ip6_rthdr_dup(opt->srcrt, sk->sk_allocation);
d656b2ea5fa797 Pavel Begunkov           2022-01-27  1386  		if (opt->srcrt && !nopt->srcrt)
0178b695fd6b40 Herbert Xu               2009-02-05  1387  			return -ENOBUFS;
0178b695fd6b40 Herbert Xu               2009-02-05  1388  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1389  		/* need source address above miyazawa*/
^1da177e4c3f41 Linus Torvalds           2005-04-16  1390  	}
26879da58711aa Wei Wang                 2016-05-02  1391  	v6_cork->hop_limit = ipc6->hlimit;
26879da58711aa Wei Wang                 2016-05-02  1392  	v6_cork->tclass = ipc6->tclass;
0c1833797a5a6e Gao feng                 2012-05-26  1393  	if (rt->dst.flags & DST_XFRM_TUNNEL)
6b724bc4300b43 Eric Dumazet             2023-09-12  1394  		mtu = READ_ONCE(np->pmtudisc) >= IPV6_PMTUDISC_PROBE ?
749439bfac6e1a Mike Maloney             2018-01-10  1395  		      READ_ONCE(rt->dst.dev->mtu) : dst_mtu(&rt->dst);
0c1833797a5a6e Gao feng                 2012-05-26  1396  	else
6b724bc4300b43 Eric Dumazet             2023-09-12  1397  		mtu = READ_ONCE(np->pmtudisc) >= IPV6_PMTUDISC_PROBE ?
c02b3741eb99a1 David S. Miller          2018-01-17  1398  			READ_ONCE(rt->dst.dev->mtu) : dst_mtu(xfrm_dst_path(&rt->dst));
15f926c4457aa6 Eric Dumazet             2023-09-12  1399  
15f926c4457aa6 Eric Dumazet             2023-09-12  1400  	frag_size = READ_ONCE(np->frag_size);
15f926c4457aa6 Eric Dumazet             2023-09-12  1401  	if (frag_size && frag_size < mtu)
15f926c4457aa6 Eric Dumazet             2023-09-12  1402  		mtu = frag_size;
15f926c4457aa6 Eric Dumazet             2023-09-12  1403  
366e41d9774d70 Vlad Yasevich            2015-01-31  1404  	cork->base.fragsize = mtu;
fbf47813607ba8 Willem de Bruijn         2018-07-06  1405  	cork->base.gso_size = ipc6->gso_size;
678ca42d688534 Willem de Bruijn         2018-07-06  1406  	cork->base.tx_flags = 0;
c6af0c227a22bb Willem de Bruijn         2019-09-11  1407  	cork->base.mark = ipc6->sockc.mark;
a32f3e9d1ed146 Anna Emese Nyiri         2024-12-13  1408  	cork->base.priority = ipc6->sockc.priority;
822b5bc6db55f1 Vadim Fedorenko          2024-10-01  1409  	sock_tx_timestamp(sk, &ipc6->sockc, &cork->base.tx_flags);
4aecca4c76808f Vadim Fedorenko          2024-10-01  1410  	if (ipc6->sockc.tsflags & SOCKCM_FLAG_TS_OPT_ID) {
4aecca4c76808f Vadim Fedorenko          2024-10-01  1411  		cork->base.flags |= IPCORK_TS_OPT_ID;
4aecca4c76808f Vadim Fedorenko          2024-10-01  1412  		cork->base.ts_opt_id = ipc6->sockc.ts_opt_id;
4aecca4c76808f Vadim Fedorenko          2024-10-01  1413  	}
366e41d9774d70 Vlad Yasevich            2015-01-31  1414  	cork->base.length = 0;
5fdaa88dfefa87 Willem de Bruijn         2018-07-06  1415  	cork->base.transmit_time = ipc6->sockc.transmit_time;
a818f75e311c23 Jesus Sanchez-Palencia   2018-07-03  1416  
366e41d9774d70 Vlad Yasevich            2015-01-31  1417  	return 0;
366e41d9774d70 Vlad Yasevich            2015-01-31  1418  }
366e41d9774d70 Vlad Yasevich            2015-01-31  1419  
0bbe84a67b0b54 Vlad Yasevich            2015-01-31 @1420  static int __ip6_append_data(struct sock *sk,
0bbe84a67b0b54 Vlad Yasevich            2015-01-31  1421  			     struct sk_buff_head *queue,
f3b46a3e8c4030 Pavel Begunkov           2022-01-27  1422  			     struct inet_cork_full *cork_full,
0bbe84a67b0b54 Vlad Yasevich            2015-01-31  1423  			     struct inet6_cork *v6_cork,
0bbe84a67b0b54 Vlad Yasevich            2015-01-31  1424  			     struct page_frag *pfrag,
0bbe84a67b0b54 Vlad Yasevich            2015-01-31  1425  			     int getfrag(void *from, char *to, int offset,
0bbe84a67b0b54 Vlad Yasevich            2015-01-31  1426  					 int len, int odd, struct sk_buff *skb),
f93431c86b631b Wang Yufen               2022-06-07  1427  			     void *from, size_t length, int transhdrlen,
5fdaa88dfefa87 Willem de Bruijn         2018-07-06  1428  			     unsigned int flags, struct ipcm6_cookie *ipc6)
366e41d9774d70 Vlad Yasevich            2015-01-31  1429  {
366e41d9774d70 Vlad Yasevich            2015-01-31  1430  	struct sk_buff *skb, *skb_prev = NULL;
f3b46a3e8c4030 Pavel Begunkov           2022-01-27  1431  	struct inet_cork *cork = &cork_full->base;
f37a4cc6bb0ba0 Pavel Begunkov           2022-01-27  1432  	struct flowi6 *fl6 = &cork_full->fl.u.ip6;
10b8a3de603df7 Paolo Abeni              2018-03-23  1433  	unsigned int maxfraglen, fragheaderlen, mtu, orig_mtu, pmtu;
b5947e5d1e710c Willem de Bruijn         2018-11-30  1434  	struct ubuf_info *uarg = NULL;
0bbe84a67b0b54 Vlad Yasevich            2015-01-31  1435  	int exthdrlen = 0;
0bbe84a67b0b54 Vlad Yasevich            2015-01-31  1436  	int dst_exthdrlen = 0;
366e41d9774d70 Vlad Yasevich            2015-01-31  1437  	int hh_len;
366e41d9774d70 Vlad Yasevich            2015-01-31  1438  	int copy;
366e41d9774d70 Vlad Yasevich            2015-01-31  1439  	int err;
366e41d9774d70 Vlad Yasevich            2015-01-31  1440  	int offset = 0;
773ba4fe9104a6 Pavel Begunkov           2022-07-12  1441  	bool zc = false;
366e41d9774d70 Vlad Yasevich            2015-01-31  1442  	u32 tskey = 0;
e8dfd42c17faf1 Eric Dumazet             2024-04-26  1443  	struct rt6_info *rt = dst_rt6_info(cork->dst);
4aecca4c76808f Vadim Fedorenko          2024-10-01  1444  	bool paged, hold_tskey = false, extra_uref = false;
0bbe84a67b0b54 Vlad Yasevich            2015-01-31  1445  	struct ipv6_txoptions *opt = v6_cork->opt;
32dce968dd987a Vlad Yasevich            2015-01-31  1446  	int csummode = CHECKSUM_NONE;
682b1a9d3f9686 Hannes Frederic Sowa     2015-10-27  1447  	unsigned int maxnonfragsize, headersize;
1f4c6eb2402968 Eric Dumazet             2018-03-31  1448  	unsigned int wmem_alloc_delta = 0;
366e41d9774d70 Vlad Yasevich            2015-01-31  1449  
0bbe84a67b0b54 Vlad Yasevich            2015-01-31  1450  	skb = skb_peek_tail(queue);
0bbe84a67b0b54 Vlad Yasevich            2015-01-31  1451  	if (!skb) {
0bbe84a67b0b54 Vlad Yasevich            2015-01-31  1452  		exthdrlen = opt ? opt->opt_flen : 0;
7efdba5bd9a2f3 Romain KUNTZ             2013-01-16  1453  		dst_exthdrlen = rt->dst.header_len - rt->rt6i_nfheader_len;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1454  	}
0bbe84a67b0b54 Vlad Yasevich            2015-01-31  1455  
15e36f5b8e982d Willem de Bruijn         2018-04-26  1456  	paged = !!cork->gso_size;
bec1f6f697362c Willem de Bruijn         2018-04-26  1457  	mtu = cork->gso_size ? IP6_MAX_MTU : cork->fragsize;
e367c2d03dba4c lucien                   2014-03-17  1458  	orig_mtu = mtu;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1459  
d8d1f30b95a635 Changli Gao              2010-06-10  1460  	hh_len = LL_RESERVED_SPACE(rt->dst.dev);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1461  
a1b051405bc162 Masahide NAKAMURA        2007-12-20  1462  	fragheaderlen = sizeof(struct ipv6hdr) + rt->rt6i_nfheader_len +
b4ce92775c2e7f Herbert Xu               2007-11-13  1463  			(opt ? opt->opt_nflen : 0);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1464  
4df98e76cde7c6 Hannes Frederic Sowa     2013-12-16  1465  	headersize = sizeof(struct ipv6hdr) +
3a1cebe7e05027 Hannes Frederic Sowa     2014-05-11  1466  		     (opt ? opt->opt_flen + opt->opt_nflen : 0) +
4df98e76cde7c6 Hannes Frederic Sowa     2013-12-16  1467  		     rt->rt6i_nfheader_len;
4df98e76cde7c6 Hannes Frederic Sowa     2013-12-16  1468  
5e34af4142ffe6 Tadeusz Struk            2022-03-10  1469  	if (mtu <= fragheaderlen ||
5e34af4142ffe6 Tadeusz Struk            2022-03-10  1470  	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <= sizeof(struct frag_hdr))
6596a022954127 Jiri Bohac               2022-01-19  1471  		goto emsgsize;
6596a022954127 Jiri Bohac               2022-01-19  1472  
6596a022954127 Jiri Bohac               2022-01-19  1473  	maxfraglen = ((mtu - fragheaderlen) & ~7) + fragheaderlen -
6596a022954127 Jiri Bohac               2022-01-19  1474  		     sizeof(struct frag_hdr);
6596a022954127 Jiri Bohac               2022-01-19  1475  
10b8a3de603df7 Paolo Abeni              2018-03-23  1476  	/* as per RFC 7112 section 5, the entire IPv6 Header Chain must fit
10b8a3de603df7 Paolo Abeni              2018-03-23  1477  	 * the first fragment
10b8a3de603df7 Paolo Abeni              2018-03-23  1478  	 */
10b8a3de603df7 Paolo Abeni              2018-03-23  1479  	if (headersize + transhdrlen > mtu)
10b8a3de603df7 Paolo Abeni              2018-03-23  1480  		goto emsgsize;
10b8a3de603df7 Paolo Abeni              2018-03-23  1481  
26879da58711aa Wei Wang                 2016-05-02  1482  	if (cork->length + length > mtu - headersize && ipc6->dontfrag &&
4df98e76cde7c6 Hannes Frederic Sowa     2013-12-16  1483  	    (sk->sk_protocol == IPPROTO_UDP ||
13651224c00b74 Jakub Kicinski           2022-02-16  1484  	     sk->sk_protocol == IPPROTO_ICMPV6 ||
4df98e76cde7c6 Hannes Frederic Sowa     2013-12-16  1485  	     sk->sk_protocol == IPPROTO_RAW)) {
4df98e76cde7c6 Hannes Frederic Sowa     2013-12-16  1486  		ipv6_local_rxpmtu(sk, fl6, mtu - headersize +
4df98e76cde7c6 Hannes Frederic Sowa     2013-12-16  1487  				sizeof(struct ipv6hdr));
4df98e76cde7c6 Hannes Frederic Sowa     2013-12-16  1488  		goto emsgsize;
4df98e76cde7c6 Hannes Frederic Sowa     2013-12-16  1489  	}
4df98e76cde7c6 Hannes Frederic Sowa     2013-12-16  1490  
682b1a9d3f9686 Hannes Frederic Sowa     2015-10-27  1491  	if (ip6_sk_ignore_df(sk))
682b1a9d3f9686 Hannes Frederic Sowa     2015-10-27  1492  		maxnonfragsize = sizeof(struct ipv6hdr) + IPV6_MAXPLEN;
682b1a9d3f9686 Hannes Frederic Sowa     2015-10-27  1493  	else
682b1a9d3f9686 Hannes Frederic Sowa     2015-10-27  1494  		maxnonfragsize = mtu;
682b1a9d3f9686 Hannes Frederic Sowa     2015-10-27  1495  
4df98e76cde7c6 Hannes Frederic Sowa     2013-12-16  1496  	if (cork->length + length > maxnonfragsize - headersize) {
4df98e76cde7c6 Hannes Frederic Sowa     2013-12-16  1497  emsgsize:
10b8a3de603df7 Paolo Abeni              2018-03-23  1498  		pmtu = max_t(int, mtu - headersize + sizeof(struct ipv6hdr), 0);
10b8a3de603df7 Paolo Abeni              2018-03-23  1499  		ipv6_local_error(sk, EMSGSIZE, fl6, pmtu);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1500  		return -EMSGSIZE;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1501  	}
682b1a9d3f9686 Hannes Frederic Sowa     2015-10-27  1502  
682b1a9d3f9686 Hannes Frederic Sowa     2015-10-27  1503  	/* CHECKSUM_PARTIAL only with no extension headers and when
682b1a9d3f9686 Hannes Frederic Sowa     2015-10-27  1504  	 * we are not going to fragment
682b1a9d3f9686 Hannes Frederic Sowa     2015-10-27  1505  	 */
682b1a9d3f9686 Hannes Frederic Sowa     2015-10-27  1506  	if (transhdrlen && sk->sk_protocol == IPPROTO_UDP &&
682b1a9d3f9686 Hannes Frederic Sowa     2015-10-27  1507  	    headersize == sizeof(struct ipv6hdr) &&
2b89ed65a6f201 Vlad Yasevich            2017-01-29  1508  	    length <= mtu - headersize &&
bec1f6f697362c Willem de Bruijn         2018-04-26  1509  	    (!(flags & MSG_MORE) || cork->gso_size) &&
c8cd0989bd151f Tom Herbert              2015-12-14  1510  	    rt->dst.dev->features & (NETIF_F_IPV6_CSUM | NETIF_F_HW_CSUM))
682b1a9d3f9686 Hannes Frederic Sowa     2015-10-27  1511  		csummode = CHECKSUM_PARTIAL;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1512  
1fd3ae8c906c0f Pavel Begunkov           2022-07-12  1513  	if ((flags & MSG_ZEROCOPY) && length) {
1fd3ae8c906c0f Pavel Begunkov           2022-07-12  1514  		struct msghdr *msg = from;
1fd3ae8c906c0f Pavel Begunkov           2022-07-12  1515  
1fd3ae8c906c0f Pavel Begunkov           2022-07-12  1516  		if (getfrag == ip_generic_getfrag && msg->msg_ubuf) {
1fd3ae8c906c0f Pavel Begunkov           2022-07-12  1517  			if (skb_zcopy(skb) && msg->msg_ubuf != skb_zcopy(skb))
1fd3ae8c906c0f Pavel Begunkov           2022-07-12  1518  				return -EINVAL;
1fd3ae8c906c0f Pavel Begunkov           2022-07-12  1519  
1fd3ae8c906c0f Pavel Begunkov           2022-07-12  1520  			/* Leave uarg NULL if can't zerocopy, callers should
1fd3ae8c906c0f Pavel Begunkov           2022-07-12  1521  			 * be able to handle it.
1fd3ae8c906c0f Pavel Begunkov           2022-07-12  1522  			 */
1fd3ae8c906c0f Pavel Begunkov           2022-07-12  1523  			if ((rt->dst.dev->features & NETIF_F_SG) &&
1fd3ae8c906c0f Pavel Begunkov           2022-07-12  1524  			    csummode == CHECKSUM_PARTIAL) {
1fd3ae8c906c0f Pavel Begunkov           2022-07-12  1525  				paged = true;
1fd3ae8c906c0f Pavel Begunkov           2022-07-12  1526  				zc = true;
1fd3ae8c906c0f Pavel Begunkov           2022-07-12  1527  				uarg = msg->msg_ubuf;
1fd3ae8c906c0f Pavel Begunkov           2022-07-12  1528  			}
1fd3ae8c906c0f Pavel Begunkov           2022-07-12  1529  		} else if (sock_flag(sk, SOCK_ZEROCOPY)) {
8c793822c5803e Jonathan Lemon           2021-01-06  1530  			uarg = msg_zerocopy_realloc(sk, length, skb_zcopy(skb));
b5947e5d1e710c Willem de Bruijn         2018-11-30  1531  			if (!uarg)
b5947e5d1e710c Willem de Bruijn         2018-11-30  1532  				return -ENOBUFS;
522924b583082f Willem de Bruijn         2019-06-07  1533  			extra_uref = !skb_zcopy(skb);	/* only ref on new uarg */
b5947e5d1e710c Willem de Bruijn         2018-11-30  1534  			if (rt->dst.dev->features & NETIF_F_SG &&
b5947e5d1e710c Willem de Bruijn         2018-11-30  1535  			    csummode == CHECKSUM_PARTIAL) {
b5947e5d1e710c Willem de Bruijn         2018-11-30  1536  				paged = true;
773ba4fe9104a6 Pavel Begunkov           2022-07-12  1537  				zc = true;
b5947e5d1e710c Willem de Bruijn         2018-11-30  1538  			} else {
e7d2b510165fff Pavel Begunkov           2022-09-23  1539  				uarg_to_msgzc(uarg)->zerocopy = 0;
52900d22288e7d Willem de Bruijn         2018-11-30  1540  				skb_zcopy_set(skb, uarg, &extra_uref);
b5947e5d1e710c Willem de Bruijn         2018-11-30  1541  			}
b5947e5d1e710c Willem de Bruijn         2018-11-30  1542  		}
6d8192bd69bb43 David Howells            2023-05-22  1543  	} else if ((flags & MSG_SPLICE_PAGES) && length) {
cafbe182a467bf Eric Dumazet             2023-08-16  1544  		if (inet_test_bit(HDRINCL, sk))
6d8192bd69bb43 David Howells            2023-05-22  1545  			return -EPERM;
5a6f6873606e03 David Howells            2023-06-14  1546  		if (rt->dst.dev->features & NETIF_F_SG &&
5a6f6873606e03 David Howells            2023-06-14  1547  		    getfrag == ip_generic_getfrag)
6d8192bd69bb43 David Howells            2023-05-22  1548  			/* We need an empty buffer to attach stuff to */
6d8192bd69bb43 David Howells            2023-05-22  1549  			paged = true;
6d8192bd69bb43 David Howells            2023-05-22  1550  		else
6d8192bd69bb43 David Howells            2023-05-22  1551  			flags &= ~MSG_SPLICE_PAGES;
1fd3ae8c906c0f Pavel Begunkov           2022-07-12  1552  	}
b5947e5d1e710c Willem de Bruijn         2018-11-30  1553  
4aecca4c76808f Vadim Fedorenko          2024-10-01  1554  	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
4aecca4c76808f Vadim Fedorenko          2024-10-01  1555  	    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
4aecca4c76808f Vadim Fedorenko          2024-10-01  1556  		if (cork->flags & IPCORK_TS_OPT_ID) {
4aecca4c76808f Vadim Fedorenko          2024-10-01  1557  			tskey = cork->ts_opt_id;
4aecca4c76808f Vadim Fedorenko          2024-10-01  1558  		} else {
488b6d91b07112 Vadim Fedorenko          2024-02-13  1559  			tskey = atomic_inc_return(&sk->sk_tskey) - 1;
4aecca4c76808f Vadim Fedorenko          2024-10-01  1560  			hold_tskey = true;
4aecca4c76808f Vadim Fedorenko          2024-10-01  1561  		}
4aecca4c76808f Vadim Fedorenko          2024-10-01  1562  	}
488b6d91b07112 Vadim Fedorenko          2024-02-13  1563  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1564  	/*
^1da177e4c3f41 Linus Torvalds           2005-04-16  1565  	 * Let's try using as much space as possible.
^1da177e4c3f41 Linus Torvalds           2005-04-16  1566  	 * Use MTU if total length of the message fits into the MTU.
^1da177e4c3f41 Linus Torvalds           2005-04-16  1567  	 * Otherwise, we need to reserve fragment header and
^1da177e4c3f41 Linus Torvalds           2005-04-16  1568  	 * fragment alignment (= 8-15 octects, in total).
^1da177e4c3f41 Linus Torvalds           2005-04-16  1569  	 *
634a63e73f0594 Randy Dunlap             2020-09-17  1570  	 * Note that we may need to "move" the data from the tail
^1da177e4c3f41 Linus Torvalds           2005-04-16  1571  	 * of the buffer to the new fragment when we split
^1da177e4c3f41 Linus Torvalds           2005-04-16  1572  	 * the message.
^1da177e4c3f41 Linus Torvalds           2005-04-16  1573  	 *
^1da177e4c3f41 Linus Torvalds           2005-04-16  1574  	 * FIXME: It may be fragmented into multiple chunks
^1da177e4c3f41 Linus Torvalds           2005-04-16  1575  	 *        at once if non-fragmentable extension headers
^1da177e4c3f41 Linus Torvalds           2005-04-16  1576  	 *        are too large.
^1da177e4c3f41 Linus Torvalds           2005-04-16  1577  	 * --yoshfuji
^1da177e4c3f41 Linus Torvalds           2005-04-16  1578  	 */
^1da177e4c3f41 Linus Torvalds           2005-04-16  1579  
2811ebac2521ce Hannes Frederic Sowa     2013-09-21  1580  	cork->length += length;
2811ebac2521ce Hannes Frederic Sowa     2013-09-21  1581  	if (!skb)
^1da177e4c3f41 Linus Torvalds           2005-04-16  1582  		goto alloc_new_skb;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1583  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1584  	while (length > 0) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1585  		/* Check if the remaining data fits into current packet. */
e57a34478586fe Yan Zhai                 2023-10-24  1586  		copy = (cork->length <= mtu ? mtu : maxfraglen) - skb->len;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1587  		if (copy < length)
^1da177e4c3f41 Linus Torvalds           2005-04-16  1588  			copy = maxfraglen - skb->len;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1589  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1590  		if (copy <= 0) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1591  			char *data;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1592  			unsigned int datalen;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1593  			unsigned int fraglen;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1594  			unsigned int fraggap;
6d123b81ac6150 Jakub Kicinski           2021-06-23  1595  			unsigned int alloclen, alloc_extra;
aba36930a35e7f Willem de Bruijn         2018-11-24  1596  			unsigned int pagedlen;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1597  alloc_new_skb:
^1da177e4c3f41 Linus Torvalds           2005-04-16  1598  			/* There's no room in the current skb */
0c1833797a5a6e Gao feng                 2012-05-26  1599  			if (skb)
0c1833797a5a6e Gao feng                 2012-05-26  1600  				fraggap = skb->len - maxfraglen;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1601  			else
^1da177e4c3f41 Linus Torvalds           2005-04-16  1602  				fraggap = 0;
0c1833797a5a6e Gao feng                 2012-05-26  1603  			/* update mtu and maxfraglen if necessary */
63159f29be1df7 Ian Morris               2015-03-29  1604  			if (!skb || !skb_prev)
0c1833797a5a6e Gao feng                 2012-05-26  1605  				ip6_append_data_mtu(&mtu, &maxfraglen,
75a493e60ac4bb Hannes Frederic Sowa     2013-07-02  1606  						    fragheaderlen, skb, rt,
e367c2d03dba4c lucien                   2014-03-17  1607  						    orig_mtu);
0c1833797a5a6e Gao feng                 2012-05-26  1608  
0c1833797a5a6e Gao feng                 2012-05-26  1609  			skb_prev = skb;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1610  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1611  			/*
^1da177e4c3f41 Linus Torvalds           2005-04-16  1612  			 * If remaining data exceeds the mtu,
^1da177e4c3f41 Linus Torvalds           2005-04-16  1613  			 * we know we need more fragment(s).
^1da177e4c3f41 Linus Torvalds           2005-04-16  1614  			 */
^1da177e4c3f41 Linus Torvalds           2005-04-16  1615  			datalen = length + fraggap;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1616  
e57a34478586fe Yan Zhai                 2023-10-24  1617  			if (datalen > (cork->length <= mtu ? mtu : maxfraglen) - fragheaderlen)
0c1833797a5a6e Gao feng                 2012-05-26  1618  				datalen = maxfraglen - fragheaderlen - rt->dst.trailer_len;
15e36f5b8e982d Willem de Bruijn         2018-04-26  1619  			fraglen = datalen + fragheaderlen;
aba36930a35e7f Willem de Bruijn         2018-11-24  1620  			pagedlen = 0;
15e36f5b8e982d Willem de Bruijn         2018-04-26  1621  
6d123b81ac6150 Jakub Kicinski           2021-06-23  1622  			alloc_extra = hh_len;
6d123b81ac6150 Jakub Kicinski           2021-06-23  1623  			alloc_extra += dst_exthdrlen;
6d123b81ac6150 Jakub Kicinski           2021-06-23  1624  			alloc_extra += rt->dst.trailer_len;
6d123b81ac6150 Jakub Kicinski           2021-06-23  1625  
6d123b81ac6150 Jakub Kicinski           2021-06-23  1626  			/* We just reserve space for fragment header.
6d123b81ac6150 Jakub Kicinski           2021-06-23  1627  			 * Note: this may be overallocation if the message
6d123b81ac6150 Jakub Kicinski           2021-06-23  1628  			 * (without MSG_MORE) fits into the MTU.
6d123b81ac6150 Jakub Kicinski           2021-06-23  1629  			 */
6d123b81ac6150 Jakub Kicinski           2021-06-23  1630  			alloc_extra += sizeof(struct frag_hdr);
6d123b81ac6150 Jakub Kicinski           2021-06-23  1631  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1632  			if ((flags & MSG_MORE) &&
d8d1f30b95a635 Changli Gao              2010-06-10  1633  			    !(rt->dst.dev->features&NETIF_F_SG))
^1da177e4c3f41 Linus Torvalds           2005-04-16  1634  				alloclen = mtu;
6d123b81ac6150 Jakub Kicinski           2021-06-23  1635  			else if (!paged &&
6d123b81ac6150 Jakub Kicinski           2021-06-23  1636  				 (fraglen + alloc_extra < SKB_MAX_ALLOC ||
6d123b81ac6150 Jakub Kicinski           2021-06-23  1637  				  !(rt->dst.dev->features & NETIF_F_SG)))
15e36f5b8e982d Willem de Bruijn         2018-04-26  1638  				alloclen = fraglen;
47cf88993c9108 Pavel Begunkov           2022-08-25  1639  			else {
773ba4fe9104a6 Pavel Begunkov           2022-07-12  1640  				alloclen = fragheaderlen + transhdrlen;
773ba4fe9104a6 Pavel Begunkov           2022-07-12  1641  				pagedlen = datalen - transhdrlen;
15e36f5b8e982d Willem de Bruijn         2018-04-26  1642  			}
6d123b81ac6150 Jakub Kicinski           2021-06-23  1643  			alloclen += alloc_extra;
299b0767642a65 Steffen Klassert         2011-10-11  1644  
0c1833797a5a6e Gao feng                 2012-05-26  1645  			if (datalen != length + fraggap) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1646  				/*
0c1833797a5a6e Gao feng                 2012-05-26  1647  				 * this is not the last fragment, the trailer
0c1833797a5a6e Gao feng                 2012-05-26  1648  				 * space is regarded as data space.
^1da177e4c3f41 Linus Torvalds           2005-04-16  1649  				 */
0c1833797a5a6e Gao feng                 2012-05-26  1650  				datalen += rt->dst.trailer_len;
0c1833797a5a6e Gao feng                 2012-05-26  1651  			}
0c1833797a5a6e Gao feng                 2012-05-26  1652  
0c1833797a5a6e Gao feng                 2012-05-26  1653  			fraglen = datalen + fragheaderlen;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1654  
15e36f5b8e982d Willem de Bruijn         2018-04-26  1655  			copy = datalen - transhdrlen - fraggap - pagedlen;
ce650a1663354a David Howells            2023-08-02  1656  			/* [!] NOTE: copy may be negative if pagedlen>0
ce650a1663354a David Howells            2023-08-02  1657  			 * because then the equation may reduces to -fraggap.
ce650a1663354a David Howells            2023-08-02  1658  			 */
ce650a1663354a David Howells            2023-08-02  1659  			if (copy < 0 && !(flags & MSG_SPLICE_PAGES)) {
232cd35d0804cc Eric Dumazet             2017-05-19  1660  				err = -EINVAL;
232cd35d0804cc Eric Dumazet             2017-05-19  1661  				goto error;
232cd35d0804cc Eric Dumazet             2017-05-19  1662  			}
^1da177e4c3f41 Linus Torvalds           2005-04-16  1663  			if (transhdrlen) {
6d123b81ac6150 Jakub Kicinski           2021-06-23  1664  				skb = sock_alloc_send_skb(sk, alloclen,
^1da177e4c3f41 Linus Torvalds           2005-04-16  1665  						(flags & MSG_DONTWAIT), &err);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1666  			} else {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1667  				skb = NULL;
1f4c6eb2402968 Eric Dumazet             2018-03-31  1668  				if (refcount_read(&sk->sk_wmem_alloc) + wmem_alloc_delta <=
^1da177e4c3f41 Linus Torvalds           2005-04-16  1669  				    2 * sk->sk_sndbuf)
6d123b81ac6150 Jakub Kicinski           2021-06-23  1670  					skb = alloc_skb(alloclen,
^1da177e4c3f41 Linus Torvalds           2005-04-16  1671  							sk->sk_allocation);
63159f29be1df7 Ian Morris               2015-03-29  1672  				if (unlikely(!skb))
^1da177e4c3f41 Linus Torvalds           2005-04-16  1673  					err = -ENOBUFS;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1674  			}
63159f29be1df7 Ian Morris               2015-03-29  1675  			if (!skb)
^1da177e4c3f41 Linus Torvalds           2005-04-16  1676  				goto error;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1677  			/*
^1da177e4c3f41 Linus Torvalds           2005-04-16  1678  			 *	Fill in the control structures
^1da177e4c3f41 Linus Torvalds           2005-04-16  1679  			 */
9c9c9ad5fae7e9 Hannes Frederic Sowa     2013-08-26  1680  			skb->protocol = htons(ETH_P_IPV6);
32dce968dd987a Vlad Yasevich            2015-01-31  1681  			skb->ip_summed = csummode;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1682  			skb->csum = 0;
1f85851e17b64c Gao feng                 2012-03-19  1683  			/* reserve for fragmentation and ipsec header */
1f85851e17b64c Gao feng                 2012-03-19  1684  			skb_reserve(skb, hh_len + sizeof(struct frag_hdr) +
1f85851e17b64c Gao feng                 2012-03-19  1685  				    dst_exthdrlen);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1686  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1687  			/*
^1da177e4c3f41 Linus Torvalds           2005-04-16  1688  			 *	Find where to start putting bytes
^1da177e4c3f41 Linus Torvalds           2005-04-16  1689  			 */
15e36f5b8e982d Willem de Bruijn         2018-04-26  1690  			data = skb_put(skb, fraglen - pagedlen);
1f85851e17b64c Gao feng                 2012-03-19  1691  			skb_set_network_header(skb, exthdrlen);
1f85851e17b64c Gao feng                 2012-03-19  1692  			data += fragheaderlen;
b0e380b1d8a8e0 Arnaldo Carvalho de Melo 2007-04-10  1693  			skb->transport_header = (skb->network_header +
b0e380b1d8a8e0 Arnaldo Carvalho de Melo 2007-04-10  1694  						 fragheaderlen);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1695  			if (fraggap) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1696  				skb->csum = skb_copy_and_csum_bits(
^1da177e4c3f41 Linus Torvalds           2005-04-16  1697  					skb_prev, maxfraglen,
8d5930dfb7edbf Al Viro                  2020-07-10  1698  					data + transhdrlen, fraggap);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1699  				skb_prev->csum = csum_sub(skb_prev->csum,
^1da177e4c3f41 Linus Torvalds           2005-04-16  1700  							  skb->csum);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1701  				data += fraggap;
e9fa4f7bd291c2 Herbert Xu               2006-08-13  1702  				pskb_trim_unique(skb_prev, maxfraglen);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1703  			}
232cd35d0804cc Eric Dumazet             2017-05-19  1704  			if (copy > 0 &&
5204ccbfa22358 Eric Dumazet             2024-12-03  1705  			    INDIRECT_CALL_1(getfrag, ip_generic_getfrag,
5204ccbfa22358 Eric Dumazet             2024-12-03  1706  					   from, data + transhdrlen, offset,
232cd35d0804cc Eric Dumazet             2017-05-19  1707  					   copy, fraggap, skb) < 0) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1708  				err = -EFAULT;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1709  				kfree_skb(skb);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1710  				goto error;
ce650a1663354a David Howells            2023-08-02  1711  			} else if (flags & MSG_SPLICE_PAGES) {
ce650a1663354a David Howells            2023-08-02  1712  				copy = 0;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1713  			}
^1da177e4c3f41 Linus Torvalds           2005-04-16  1714  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1715  			offset += copy;
15e36f5b8e982d Willem de Bruijn         2018-04-26  1716  			length -= copy + transhdrlen;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1717  			transhdrlen = 0;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1718  			exthdrlen = 0;
299b0767642a65 Steffen Klassert         2011-10-11  1719  			dst_exthdrlen = 0;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1720  
52900d22288e7d Willem de Bruijn         2018-11-30  1721  			/* Only the initial fragment is time stamped */
52900d22288e7d Willem de Bruijn         2018-11-30  1722  			skb_shinfo(skb)->tx_flags = cork->tx_flags;
52900d22288e7d Willem de Bruijn         2018-11-30  1723  			cork->tx_flags = 0;
52900d22288e7d Willem de Bruijn         2018-11-30  1724  			skb_shinfo(skb)->tskey = tskey;
52900d22288e7d Willem de Bruijn         2018-11-30  1725  			tskey = 0;
52900d22288e7d Willem de Bruijn         2018-11-30  1726  			skb_zcopy_set(skb, uarg, &extra_uref);
52900d22288e7d Willem de Bruijn         2018-11-30  1727  
0dec879f636f11 Julian Anastasov         2017-02-06  1728  			if ((flags & MSG_CONFIRM) && !skb_prev)
0dec879f636f11 Julian Anastasov         2017-02-06  1729  				skb_set_dst_pending_confirm(skb, 1);
0dec879f636f11 Julian Anastasov         2017-02-06  1730  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1731  			/*
^1da177e4c3f41 Linus Torvalds           2005-04-16  1732  			 * Put the packet on the pending queue
^1da177e4c3f41 Linus Torvalds           2005-04-16  1733  			 */
1f4c6eb2402968 Eric Dumazet             2018-03-31  1734  			if (!skb->destructor) {
1f4c6eb2402968 Eric Dumazet             2018-03-31  1735  				skb->destructor = sock_wfree;
1f4c6eb2402968 Eric Dumazet             2018-03-31  1736  				skb->sk = sk;
1f4c6eb2402968 Eric Dumazet             2018-03-31  1737  				wmem_alloc_delta += skb->truesize;
1f4c6eb2402968 Eric Dumazet             2018-03-31  1738  			}
0bbe84a67b0b54 Vlad Yasevich            2015-01-31  1739  			__skb_queue_tail(queue, skb);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1740  			continue;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1741  		}
^1da177e4c3f41 Linus Torvalds           2005-04-16  1742  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1743  		if (copy > length)
^1da177e4c3f41 Linus Torvalds           2005-04-16  1744  			copy = length;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1745  
113f99c3358564 Willem de Bruijn         2018-05-17  1746  		if (!(rt->dst.dev->features&NETIF_F_SG) &&
113f99c3358564 Willem de Bruijn         2018-05-17  1747  		    skb_tailroom(skb) >= copy) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1748  			unsigned int off;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1749  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1750  			off = skb->len;
5204ccbfa22358 Eric Dumazet             2024-12-03  1751  			if (INDIRECT_CALL_1(getfrag, ip_generic_getfrag,
5204ccbfa22358 Eric Dumazet             2024-12-03  1752  					    from, skb_put(skb, copy),
^1da177e4c3f41 Linus Torvalds           2005-04-16  1753  					    offset, copy, off, skb) < 0) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1754  				__skb_trim(skb, off);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1755  				err = -EFAULT;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1756  				goto error;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1757  			}
6d8192bd69bb43 David Howells            2023-05-22  1758  		} else if (flags & MSG_SPLICE_PAGES) {
6d8192bd69bb43 David Howells            2023-05-22  1759  			struct msghdr *msg = from;
6d8192bd69bb43 David Howells            2023-05-22  1760  
ce650a1663354a David Howells            2023-08-02  1761  			err = -EIO;
ce650a1663354a David Howells            2023-08-02  1762  			if (WARN_ON_ONCE(copy > msg->msg_iter.count))
ce650a1663354a David Howells            2023-08-02  1763  				goto error;
ce650a1663354a David Howells            2023-08-02  1764  
6d8192bd69bb43 David Howells            2023-05-22  1765  			err = skb_splice_from_iter(skb, &msg->msg_iter, copy,
6d8192bd69bb43 David Howells            2023-05-22  1766  						   sk->sk_allocation);
6d8192bd69bb43 David Howells            2023-05-22  1767  			if (err < 0)
6d8192bd69bb43 David Howells            2023-05-22  1768  				goto error;
6d8192bd69bb43 David Howells            2023-05-22  1769  			copy = err;
6d8192bd69bb43 David Howells            2023-05-22  1770  			wmem_alloc_delta += copy;
1fd3ae8c906c0f Pavel Begunkov           2022-07-12  1771  		} else if (!zc) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1772  			int i = skb_shinfo(skb)->nr_frags;
5640f7685831e0 Eric Dumazet             2012-09-23  1773  
^1da177e4c3f41 Linus Torvalds           2005-04-16  1774  			err = -ENOMEM;
5640f7685831e0 Eric Dumazet             2012-09-23  1775  			if (!sk_page_frag_refill(sk, pfrag))
^1da177e4c3f41 Linus Torvalds           2005-04-16  1776  				goto error;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1777  
1fd3ae8c906c0f Pavel Begunkov           2022-07-12  1778  			skb_zcopy_downgrade_managed(skb);
5640f7685831e0 Eric Dumazet             2012-09-23  1779  			if (!skb_can_coalesce(skb, i, pfrag->page,
5640f7685831e0 Eric Dumazet             2012-09-23  1780  					      pfrag->offset)) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  1781  				err = -EMSGSIZE;
5640f7685831e0 Eric Dumazet             2012-09-23  1782  				if (i == MAX_SKB_FRAGS)
^1da177e4c3f41 Linus Torvalds           2005-04-16  1783  					goto error;
5640f7685831e0 Eric Dumazet             2012-09-23  1784  
5640f7685831e0 Eric Dumazet             2012-09-23  1785  				__skb_fill_page_desc(skb, i, pfrag->page,
5640f7685831e0 Eric Dumazet             2012-09-23  1786  						     pfrag->offset, 0);
5640f7685831e0 Eric Dumazet             2012-09-23  1787  				skb_shinfo(skb)->nr_frags = ++i;
5640f7685831e0 Eric Dumazet             2012-09-23  1788  				get_page(pfrag->page);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1789  			}
5640f7685831e0 Eric Dumazet             2012-09-23  1790  			copy = min_t(int, copy, pfrag->size - pfrag->offset);
5204ccbfa22358 Eric Dumazet             2024-12-03  1791  			if (INDIRECT_CALL_1(getfrag, ip_generic_getfrag,
5204ccbfa22358 Eric Dumazet             2024-12-03  1792  				    from,
5640f7685831e0 Eric Dumazet             2012-09-23  1793  				    page_address(pfrag->page) + pfrag->offset,
5640f7685831e0 Eric Dumazet             2012-09-23  1794  				    offset, copy, skb->len, skb) < 0)
5640f7685831e0 Eric Dumazet             2012-09-23  1795  				goto error_efault;
5640f7685831e0 Eric Dumazet             2012-09-23  1796  
5640f7685831e0 Eric Dumazet             2012-09-23  1797  			pfrag->offset += copy;
5640f7685831e0 Eric Dumazet             2012-09-23  1798  			skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1799  			skb->len += copy;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1800  			skb->data_len += copy;
f945fa7ad9c12a Herbert Xu               2008-01-22  1801  			skb->truesize += copy;
1f4c6eb2402968 Eric Dumazet             2018-03-31  1802  			wmem_alloc_delta += copy;
b5947e5d1e710c Willem de Bruijn         2018-11-30  1803  		} else {
b5947e5d1e710c Willem de Bruijn         2018-11-30  1804  			err = skb_zerocopy_iter_dgram(skb, from, copy);
b5947e5d1e710c Willem de Bruijn         2018-11-30  1805  			if (err < 0)
b5947e5d1e710c Willem de Bruijn         2018-11-30  1806  				goto error;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1807  		}
^1da177e4c3f41 Linus Torvalds           2005-04-16  1808  		offset += copy;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1809  		length -= copy;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1810  	}
5640f7685831e0 Eric Dumazet             2012-09-23  1811  
9e8445a56c253f Paolo Abeni              2018-04-04  1812  	if (wmem_alloc_delta)
1f4c6eb2402968 Eric Dumazet             2018-03-31  1813  		refcount_add(wmem_alloc_delta, &sk->sk_wmem_alloc);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1814  	return 0;
5640f7685831e0 Eric Dumazet             2012-09-23  1815  
5640f7685831e0 Eric Dumazet             2012-09-23  1816  error_efault:
5640f7685831e0 Eric Dumazet             2012-09-23  1817  	err = -EFAULT;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1818  error:
8e0449172497a9 Jonathan Lemon           2021-01-06  1819  	net_zcopy_put_abort(uarg, extra_uref);
bdc712b4c2baf9 David S. Miller          2011-05-06  1820  	cork->length -= length;
3bd653c8455bc7 Denis V. Lunev           2008-10-08  1821  	IP6_INC_STATS(sock_net(sk), rt->rt6i_idev, IPSTATS_MIB_OUTDISCARDS);
1f4c6eb2402968 Eric Dumazet             2018-03-31  1822  	refcount_add(wmem_alloc_delta, &sk->sk_wmem_alloc);
488b6d91b07112 Vadim Fedorenko          2024-02-13  1823  	if (hold_tskey)
488b6d91b07112 Vadim Fedorenko          2024-02-13  1824  		atomic_dec(&sk->sk_tskey);
^1da177e4c3f41 Linus Torvalds           2005-04-16  1825  	return err;
^1da177e4c3f41 Linus Torvalds           2005-04-16  1826  }
0bbe84a67b0b54 Vlad Yasevich            2015-01-31  1827  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

