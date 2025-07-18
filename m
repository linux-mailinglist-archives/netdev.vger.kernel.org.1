Return-Path: <netdev+bounces-208106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C63EB09E8A
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 11:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A9216AE47
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 09:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178691DE8BE;
	Fri, 18 Jul 2025 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6ETK/zV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266426FB9;
	Fri, 18 Jul 2025 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829249; cv=none; b=KP2pAE3khLjYmbHwH8nVMinymuYzA2Pu4/e6pgYDFY8TtL+asGAIOdrkN85Bi7iYSgotCZpGBBPElZNHWl4qQ3WKuEW8VN/IifQkyB+t8djqTtm25/h3HOzwdMHiYtZOY1FqQstSUSf/Z2gFDE/PZ9vH5sviaZt4zZ8yqWamVgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829249; c=relaxed/simple;
	bh=yYTHsWKD0UsyKxIDv/FNYZV63fdgd0+A487ofyJJd9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbxwCxSCHgW/nspZKPIjbCdAYbvYfj1VYsrAxzke0Ahp2Wt75v82SB4KpsoKQTSOD3GE7NGjAB1JmT2IkPYZGE4XKGBBjwIZdc7XZkBWrTvGx4qA2GAv7vGNgz0U96PAX6XqAdnI75aD5JzNBGwRLC12O4YAhOP7aBv7AFaCCs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b6ETK/zV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752829246; x=1784365246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yYTHsWKD0UsyKxIDv/FNYZV63fdgd0+A487ofyJJd9I=;
  b=b6ETK/zVgkRAV462Lnc4YwVfN1DAgBWRtOGeknojBIfXWznBvtkP3AiC
   gRPyGiUzc+0CgsFMGnEePWl/jqeBDoXocWZ4T5rtrWBFJqJkO7GgXbRK/
   BG7Lfz/byEzSSUb78TFhhXCoc565xL/VBtmk59JlZpKvCXAjUC2OH1Yh/
   wwR9/9HoZOlwKlR73dgfTSVa97QV4T9veCZFXPnjXCzaCt59UuUsH3xES
   f9vlDdVSQ//EP419dS7H1ahR4Na7L3zKvEDaQwQDVo0k3WSHWg3DvD/0H
   p/Dkq0YAseHwLyclQHeLUNmpHJawlv8aFsy1+cWy3Y/vwkiRZHY4dpxqG
   Q==;
X-CSE-ConnectionGUID: 3lvSoKrrTseECdpVOmPndA==
X-CSE-MsgGUID: DipPmWbyQRClfQMusCc3AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="80563388"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="80563388"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 02:00:45 -0700
X-CSE-ConnectionGUID: e55kaXycSjyQhqoUijWgqA==
X-CSE-MsgGUID: hV0bIggZR2WAPJZoDzagOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="158362935"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 18 Jul 2025 02:00:42 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucgxL-000ETL-2B;
	Fri, 18 Jul 2025 09:00:39 +0000
Date: Fri, 18 Jul 2025 17:00:17 +0800
From: kernel test robot <lkp@intel.com>
To: Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, dsahern@kernel.org, razor@blackwall.org,
	idosch@nvidia.com, petrm@nvidia.com, menglong8.dong@gmail.com,
	daniel@iogearbox.net, martin.lau@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net-next v4 4/4] net: geneve: enable binding geneve
 sockets to local addresses
Message-ID: <202507181610.vgBNLLYf-lkp@intel.com>
References: <20250717115412.11424-5-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115412.11424-5-richardbgobert@gmail.com>

Hi Richard,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Gobert/net-udp-add-freebind-option-to-udp_sock_create/20250717-200233
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250717115412.11424-5-richardbgobert%40gmail.com
patch subject: [PATCH net-next v4 4/4] net: geneve: enable binding geneve sockets to local addresses
config: arm-randconfig-001-20250718 (https://download.01.org/0day-ci/archive/20250718/202507181610.vgBNLLYf-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250718/202507181610.vgBNLLYf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507181610.vgBNLLYf-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/net/ipv6_stubs.h:11,
                    from drivers/net/geneve.c:15:
   drivers/net/geneve.c: In function 'geneve_find_sock':
>> include/net/sock.h:385:37: error: 'struct sock_common' has no member named 'skc_v6_rcv_saddr'; did you mean 'skc_rcv_saddr'?
    #define sk_v6_rcv_saddr __sk_common.skc_v6_rcv_saddr
                                        ^~~~~~~~~~~~~~~~
   drivers/net/geneve.c:685:31: note: in expansion of macro 'sk_v6_rcv_saddr'
      else if (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr,
                                  ^~~~~~~~~~~~~~~
--
   In file included from include/net/ipv6_stubs.h:11,
                    from geneve.c:15:
   geneve.c: In function 'geneve_find_sock':
>> include/net/sock.h:385:37: error: 'struct sock_common' has no member named 'skc_v6_rcv_saddr'; did you mean 'skc_rcv_saddr'?
    #define sk_v6_rcv_saddr __sk_common.skc_v6_rcv_saddr
                                        ^~~~~~~~~~~~~~~~
   geneve.c:685:31: note: in expansion of macro 'sk_v6_rcv_saddr'
      else if (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr,
                                  ^~~~~~~~~~~~~~~


vim +385 include/net/sock.h

4dc6dc7162c08b Eric Dumazet             2009-07-15  364  
68835aba4d9b74 Eric Dumazet             2010-11-30  365  #define sk_dontcopy_begin	__sk_common.skc_dontcopy_begin
68835aba4d9b74 Eric Dumazet             2010-11-30  366  #define sk_dontcopy_end		__sk_common.skc_dontcopy_end
4dc6dc7162c08b Eric Dumazet             2009-07-15  367  #define sk_hash			__sk_common.skc_hash
5080546682bae3 Eric Dumazet             2013-10-02  368  #define sk_portpair		__sk_common.skc_portpair
05dbc7b59481ca Eric Dumazet             2013-10-03  369  #define sk_num			__sk_common.skc_num
05dbc7b59481ca Eric Dumazet             2013-10-03  370  #define sk_dport		__sk_common.skc_dport
5080546682bae3 Eric Dumazet             2013-10-02  371  #define sk_addrpair		__sk_common.skc_addrpair
5080546682bae3 Eric Dumazet             2013-10-02  372  #define sk_daddr		__sk_common.skc_daddr
5080546682bae3 Eric Dumazet             2013-10-02  373  #define sk_rcv_saddr		__sk_common.skc_rcv_saddr
^1da177e4c3f41 Linus Torvalds           2005-04-16  374  #define sk_family		__sk_common.skc_family
^1da177e4c3f41 Linus Torvalds           2005-04-16  375  #define sk_state		__sk_common.skc_state
^1da177e4c3f41 Linus Torvalds           2005-04-16  376  #define sk_reuse		__sk_common.skc_reuse
055dc21a1d1d21 Tom Herbert              2013-01-22  377  #define sk_reuseport		__sk_common.skc_reuseport
9fe516ba3fb29b Eric Dumazet             2014-06-27  378  #define sk_ipv6only		__sk_common.skc_ipv6only
26abe14379f8e2 Eric W. Biederman        2015-05-08  379  #define sk_net_refcnt		__sk_common.skc_net_refcnt
^1da177e4c3f41 Linus Torvalds           2005-04-16  380  #define sk_bound_dev_if		__sk_common.skc_bound_dev_if
^1da177e4c3f41 Linus Torvalds           2005-04-16  381  #define sk_bind_node		__sk_common.skc_bind_node
8feaf0c0a5488b Arnaldo Carvalho de Melo 2005-08-09  382  #define sk_prot			__sk_common.skc_prot
07feaebfcc10cd Eric W. Biederman        2007-09-12  383  #define sk_net			__sk_common.skc_net
efe4208f47f907 Eric Dumazet             2013-10-03  384  #define sk_v6_daddr		__sk_common.skc_v6_daddr
efe4208f47f907 Eric Dumazet             2013-10-03 @385  #define sk_v6_rcv_saddr	__sk_common.skc_v6_rcv_saddr
33cf7c90fe2f97 Eric Dumazet             2015-03-11  386  #define sk_cookie		__sk_common.skc_cookie
70da268b569d32 Eric Dumazet             2015-10-08  387  #define sk_incoming_cpu		__sk_common.skc_incoming_cpu
8e5eb54d303b7c Eric Dumazet             2015-10-08  388  #define sk_flags		__sk_common.skc_flags
ed53d0ab761f5c Eric Dumazet             2015-10-08  389  #define sk_rxhash		__sk_common.skc_rxhash
efe4208f47f907 Eric Dumazet             2013-10-03  390  
5d4cc87414c5d1 Eric Dumazet             2024-02-16  391  	__cacheline_group_begin(sock_write_rx);
43f51df4172955 Eric Dumazet             2021-11-15  392  
9115e8cd2a0c6e Eric Dumazet             2016-12-03  393  	atomic_t		sk_drops;
5d4cc87414c5d1 Eric Dumazet             2024-02-16  394  	__s32			sk_peek_off;
9115e8cd2a0c6e Eric Dumazet             2016-12-03  395  	struct sk_buff_head	sk_error_queue;
b178bb3dfc30d9 Eric Dumazet             2010-11-16  396  	struct sk_buff_head	sk_receive_queue;
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  397  	/*
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  398  	 * The backlog queue is special, it is always used with
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  399  	 * the per-socket spinlock held and requires low latency
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  400  	 * access. Therefore we special case it's implementation.
b178bb3dfc30d9 Eric Dumazet             2010-11-16  401  	 * Note : rmem_alloc is in this structure to fill a hole
b178bb3dfc30d9 Eric Dumazet             2010-11-16  402  	 * on 64bit arches, not because its logically part of
b178bb3dfc30d9 Eric Dumazet             2010-11-16  403  	 * backlog.
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  404  	 */
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  405  	struct {
b178bb3dfc30d9 Eric Dumazet             2010-11-16  406  		atomic_t	rmem_alloc;
b178bb3dfc30d9 Eric Dumazet             2010-11-16  407  		int		len;
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  408  		struct sk_buff	*head;
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  409  		struct sk_buff	*tail;
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  410  	} sk_backlog;
b178bb3dfc30d9 Eric Dumazet             2010-11-16  411  #define sk_rmem_alloc sk_backlog.rmem_alloc
2c8c56e15df3d4 Eric Dumazet             2014-11-11  412  
5d4cc87414c5d1 Eric Dumazet             2024-02-16  413  	__cacheline_group_end(sock_write_rx);
5d4cc87414c5d1 Eric Dumazet             2024-02-16  414  
5d4cc87414c5d1 Eric Dumazet             2024-02-16  415  	__cacheline_group_begin(sock_read_rx);
5d4cc87414c5d1 Eric Dumazet             2024-02-16  416  	/* early demux fields */
5d4cc87414c5d1 Eric Dumazet             2024-02-16  417  	struct dst_entry __rcu	*sk_rx_dst;
5d4cc87414c5d1 Eric Dumazet             2024-02-16  418  	int			sk_rx_dst_ifindex;
5d4cc87414c5d1 Eric Dumazet             2024-02-16  419  	u32			sk_rx_dst_cookie;
5d4cc87414c5d1 Eric Dumazet             2024-02-16  420  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

