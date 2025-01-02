Return-Path: <netdev+bounces-154718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 648509FF942
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 13:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ECD13A03F5
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 12:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807041AF0DB;
	Thu,  2 Jan 2025 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pk1akrM8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE231A23A0;
	Thu,  2 Jan 2025 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735819956; cv=none; b=BKlsNyZaeosyF/7+F3LWNqbAXMaDAstNRisQFzDl+EOv0gCO3RsqkkmcMp3B+gewU8t4g4TCAlHiyuT07Eo7EkYMR0MXB12+6cSlNyKatOmQNnYjQnumGGabVUGmWJszJ3DEMB1cKc4bbEFkd4zWfY1MNCCTUXYB4pskTIf3uzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735819956; c=relaxed/simple;
	bh=XM7fKrVvkO92waHy3V3qQx/hqHJdwWyUKnuOdjW9YTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSANfQNtKAhliGS2fu5grOiW42KtDZ3ePYev07QwkjQkz+CA4bu7Z7/zOlkn4U6VgBKb92DzyxvN+2CT59Lu//LWt+sZlqdVPLAWhc+uTIkIhZhjvT1uWH/fWQRfM2wQ8yfS3O0VBROZkc2RsWc8zqZ28lI+YzXf0NJAawnH8fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pk1akrM8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735819954; x=1767355954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XM7fKrVvkO92waHy3V3qQx/hqHJdwWyUKnuOdjW9YTA=;
  b=Pk1akrM8hM9O4rq58WBAnNty1C+jZYzmVU8AMEsuZx7y8LkOpwSfGX9M
   pKzSwDlFAMIFL5JHCUrmvLYSjOaOdEWzMu/MBibbJnzy27LyYb+zKhTGT
   4jraUt51dB+1tBNPzLrR+vstRdQdTh5xnQNjhV98ifONS7i3hzNHVC9YL
   mcQ4SF+NRc/W98FIectodppooM9VMtcIhm2E1WPYQx00cofnJCE0cngVO
   4uB1WI/on0SKHNe0YMzJWWeUNLAIdyKDbKArHCRXU11V71izyQsqJgJry
   sZDP2zW+N4tPTSohEIkXPS5k6Qp25wfdj39BMkdFSbJOG49eTsYf5VL+e
   Q==;
X-CSE-ConnectionGUID: rpjKXk0GQAGzqwmOdf6f7g==
X-CSE-MsgGUID: oZPQTiQeTC6e/+osuc9lhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="47467302"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="47467302"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 04:12:33 -0800
X-CSE-ConnectionGUID: gdqhT1dXSfGBOKsyCDUT7Q==
X-CSE-MsgGUID: jVY8ZuGMS4mbgz5T/QdHag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="101328025"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 02 Jan 2025 04:12:30 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTK3v-0008UF-13;
	Thu, 02 Jan 2025 12:12:27 +0000
Date: Thu, 2 Jan 2025 20:12:09 +0800
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
Message-ID: <202501021940.ecvmrJJb-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.13-rc5 next-20241220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shiming-cheng/ipv6-socket-SO_BINDTODEVICE-lookup-routing-fail-without-IPv6-rule/20250102-174939
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250102095114.25860-1-shiming.cheng%40mediatek.com
patch subject: [PATCH]  ipv6: socket SO_BINDTODEVICE lookup routing fail without IPv6 rule.
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20250102/202501021940.ecvmrJJb-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250102/202501021940.ecvmrJJb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501021940.ecvmrJJb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:18,
                    from net/ipv6/ip6_output.c:26:
   net/ipv6/ip6_output.c:1307:19: error: non-static declaration of 'ip6_sk_dst_lookup_flow' follows static declaration
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
   net/ipv6/ip6_output.c:1309:36: error: invalid storage class for function 'ip6_opt_dup'
    1309 | static inline struct ipv6_opt_hdr *ip6_opt_dup(struct ipv6_opt_hdr *src,
         |                                    ^~~~~~~~~~~
   net/ipv6/ip6_output.c:1315:35: error: invalid storage class for function 'ip6_rthdr_dup'
    1315 | static inline struct ipv6_rt_hdr *ip6_rthdr_dup(struct ipv6_rt_hdr *src,
         |                                   ^~~~~~~~~~~~~
   net/ipv6/ip6_output.c:1321:13: error: invalid storage class for function 'ip6_append_data_mtu'
    1321 | static void ip6_append_data_mtu(unsigned int *mtu,
         |             ^~~~~~~~~~~~~~~~~~~
   net/ipv6/ip6_output.c:1345:12: error: invalid storage class for function 'ip6_setup_cork'
    1345 | static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
         |            ^~~~~~~~~~~~~~
   net/ipv6/ip6_output.c:1420:12: error: invalid storage class for function '__ip6_append_data'
    1420 | static int __ip6_append_data(struct sock *sk,
         |            ^~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:18,
                    from net/ipv6/ip6_output.c:26:
   net/ipv6/ip6_output.c:1864:19: error: non-static declaration of 'ip6_append_data' follows static declaration
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
   net/ipv6/ip6_output.c:1866:13: error: invalid storage class for function 'ip6_cork_steal_dst'
    1866 | static void ip6_cork_steal_dst(struct sk_buff *skb, struct inet_cork_full *cork)
         |             ^~~~~~~~~~~~~~~~~~
   net/ipv6/ip6_output.c:1874:13: error: invalid storage class for function 'ip6_cork_release'
    1874 | static void ip6_cork_release(struct inet_cork_full *cork,
         |             ^~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:18,
                    from net/ipv6/ip6_output.c:26:
   net/ipv6/ip6_output.c:2007:19: error: non-static declaration of 'ip6_push_pending_frames' follows static declaration
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
   net/ipv6/ip6_output.c:2009:13: error: invalid storage class for function '__ip6_flush_pending_frames'
    2009 | static void __ip6_flush_pending_frames(struct sock *sk,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:18,
                    from net/ipv6/ip6_output.c:26:
   net/ipv6/ip6_output.c:2031:19: error: non-static declaration of 'ip6_flush_pending_frames' follows static declaration
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
   net/ipv6/ip6_output.c:2074:1: error: expected declaration or statement at end of input
    2074 | }
         | ^
   At top level:
>> net/ipv6/ip6_output.c:2033:17: warning: 'ip6_make_skb' defined but not used [-Wunused-function]
    2033 | struct sk_buff *ip6_make_skb(struct sock *sk,
         |                 ^~~~~~~~~~~~


vim +/ip6_make_skb +2033 net/ipv6/ip6_output.c

0bbe84a67b0b54 Vlad Yasevich 2015-01-31  2025  
0bbe84a67b0b54 Vlad Yasevich 2015-01-31 @2026  void ip6_flush_pending_frames(struct sock *sk)
0bbe84a67b0b54 Vlad Yasevich 2015-01-31  2027  {
6422398c2ab092 Vlad Yasevich 2015-01-31  2028  	__ip6_flush_pending_frames(sk, &sk->sk_write_queue,
6422398c2ab092 Vlad Yasevich 2015-01-31  2029  				   &inet_sk(sk)->cork, &inet6_sk(sk)->cork);
0bbe84a67b0b54 Vlad Yasevich 2015-01-31  2030  }
a495f8364efe11 Chris Elston  2012-04-29  2031  EXPORT_SYMBOL_GPL(ip6_flush_pending_frames);
6422398c2ab092 Vlad Yasevich 2015-01-31  2032  
6422398c2ab092 Vlad Yasevich 2015-01-31 @2033  struct sk_buff *ip6_make_skb(struct sock *sk,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

