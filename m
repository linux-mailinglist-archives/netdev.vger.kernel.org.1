Return-Path: <netdev+bounces-57623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B78B813A57
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0709281F45
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5AD68B97;
	Thu, 14 Dec 2023 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lvv2wQM2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CCBA0
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 10:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702579928; x=1734115928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BDOejxndfLReb0cci5NYlZsRU6fGJSDduqwshAciC6Q=;
  b=lvv2wQM2b+85YMuUxBuY0mV3BdLScSeubA1Cvf77cQWFEBDi3qOzLf4i
   US/OcVomQu31K+4ul6BwOD/PbD+Rkb2XTgT7bm8ftTnDtmG2cpsWABTsg
   wQmatquuP3Tp71ltGz1/38IivpGWsXe7WEyV8ZzVGnufngDK8KJTJ51sd
   7d1FLo6E2Pq8ARekptlAEDi4Kya3f8jQTtn7xR5/76R7fdY4bsRasI/UF
   dTL2tW2nXJ/LjuzLrqBX9HZ88yLafU0B/N/O+lCWJFWctEAuqqeuNTJll
   y/jg7cv71x7OCS1uRFJ79s6RIUOA5Wbmxu9U5R6BI9RWizqrWoE07Uhbx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="399004490"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="399004490"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 10:52:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="15963533"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 14 Dec 2023 10:52:04 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDqoU-000MV2-1b;
	Thu, 14 Dec 2023 18:52:02 +0000
Date: Fri, 15 Dec 2023 02:51:11 +0800
From: kernel test robot <lkp@intel.com>
To: Eyal Birger <eyal.birger@gmail.com>, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, pablo@netfilter.org, paul@nohats.ca,
	nharold@google.com
Cc: oe-kbuild-all@lists.linux.dev, devel@linux-ipsec.org,
	netdev@vger.kernel.org, Eyal Birger <eyal.birger@gmail.com>
Subject: Re: [PATCH ipsec-next,v2] xfrm: support sending NAT keepalives in
 ESP in UDP states
Message-ID: <202312150227.iYQMDIJT-lkp@intel.com>
References: <20231210180116.1737411-1-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210180116.1737411-1-eyal.birger@gmail.com>

Hi Eyal,

kernel test robot noticed the following build errors:

[auto build test ERROR on netfilter-nf/main]
[also build test ERROR on linus/master v6.7-rc5 next-20231214]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eyal-Birger/xfrm-support-sending-NAT-keepalives-in-ESP-in-UDP-states/20231211-020238
base:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git main
patch link:    https://lore.kernel.org/r/20231210180116.1737411-1-eyal.birger%40gmail.com
patch subject: [PATCH ipsec-next,v2] xfrm: support sending NAT keepalives in ESP in UDP states
config: x86_64-rhel-8.3-ltp (https://download.01.org/0day-ci/archive/20231215/202312150227.iYQMDIJT-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150227.iYQMDIJT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150227.iYQMDIJT-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/xfrm/xfrm_nat_keepalive.c: In function 'nat_keepalive_send_ipv6':
>> net/xfrm/xfrm_nat_keepalive.c:78:21: error: implicit declaration of function 'csum_ipv6_magic'; did you mean 'csum_tcpudp_magic'? [-Werror=implicit-function-declaration]
      78 |         uh->check = csum_ipv6_magic(&ka->saddr.in6, &ka->daddr.in6,
         |                     ^~~~~~~~~~~~~~~
         |                     csum_tcpudp_magic
   cc1: some warnings being treated as errors


vim +78 net/xfrm/xfrm_nat_keepalive.c

    64	
    65	#if IS_ENABLED(CONFIG_IPV6)
    66	static int nat_keepalive_send_ipv6(struct sk_buff *skb,
    67					   struct nat_keepalive *ka,
    68					   struct udphdr *uh)
    69	{
    70		struct net *net = ka->net;
    71		struct dst_entry *dst;
    72		struct flowi6 fl6;
    73		struct sock *sk;
    74		__wsum csum;
    75		int err;
    76	
    77		csum = skb_checksum(skb, 0, skb->len, 0);
  > 78		uh->check = csum_ipv6_magic(&ka->saddr.in6, &ka->daddr.in6,
    79					    skb->len, IPPROTO_UDP, csum);
    80		if (uh->check == 0)
    81			uh->check = CSUM_MANGLED_0;
    82	
    83		memset(&fl6, 0, sizeof(fl6));
    84		fl6.flowi6_mark = skb->mark;
    85		fl6.saddr = ka->saddr.in6;
    86		fl6.daddr = ka->daddr.in6;
    87		fl6.flowi6_proto = IPPROTO_UDP;
    88		fl6.fl6_sport = ka->encap_sport;
    89		fl6.fl6_dport = ka->encap_dport;
    90	
    91		sk = *this_cpu_ptr(&nat_keepalive_sk_ipv6);
    92		sock_net_set(sk, net);
    93		dst = ipv6_stub->ipv6_dst_lookup_flow(net, sk, &fl6, NULL);
    94		if (IS_ERR(dst))
    95			return PTR_ERR(dst);
    96	
    97		skb_dst_set(skb, dst);
    98		err = ipv6_stub->ip6_xmit(sk, skb, &fl6, skb->mark, NULL, 0, 0);
    99		sock_net_set(sk, &init_net);
   100		return err;
   101	}
   102	#endif
   103	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

