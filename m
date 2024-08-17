Return-Path: <netdev+bounces-119416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F601955845
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 16:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE62B1C20C99
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 14:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F4B148832;
	Sat, 17 Aug 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHon+3Yk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F7433A9
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723903306; cv=none; b=HduBNecC2LSUs/DAdE9CkBelaOpX3V6uHK4SyvuchJbMRSmDKvPNrC+as6Z2jRKpCjTf5m47VO35aN19iDEUhhXIJzqJX5GJzwSQqSWI/AYu7HUzUtujSZGS3TYQWKtLb86KO0R91Gict9XwFo5Qm44bPI5xiR16xT7MoNDaCSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723903306; c=relaxed/simple;
	bh=e2jyO1dfFXPZobWT1qKv98x5G7gttacbMq+Wez3b4gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kF0oYR+BU+EYr9nJMiau+8HUSj5jvLEAp0RPSFaW3RyNfQqfypaREo/nXin9lFUc4yS2skbglrY7b1P7g0Uq399Wzxn38cwgLU1nqwA67IAs82LiDG1gbOHc1dL3QfFXlKVRwe7KCmhUFb/cNJeBqwJYbIIslT/d6grtIoz1KXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CHon+3Yk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723903303; x=1755439303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e2jyO1dfFXPZobWT1qKv98x5G7gttacbMq+Wez3b4gk=;
  b=CHon+3Yk2y/E8u9T5JWxdAuNx00SZyRppEhKxBa9+qkF6NSZaz8/MiMW
   qdk/j2vL6oKKtG3OKDeP+zsG5i4ro5itrZdype9Hu8gWchsifPas/XCb1
   TgUZtNlFiaMQ4gdmAW1g19zqJj06MRdYXCgnZ9FRWVoR5ecG09jaa87oh
   4VfzY/j+nTwLy6JFAnQVmMhJ0OLOpt6Cfxl8HPA7hENjezTdGZTrN+s0D
   FQyG/jnzNXZ+/MMgXboKqcte/GUKDgx4U7v5jqMkGUeWvDHqsbIgaqsj8
   0ce3eNLp21sqcDKzE8bX9mkCeKvt/Mz1BHM8FZ1MGagcx/AkOpD9UcsXm
   w==;
X-CSE-ConnectionGUID: +xCB50dZT5O4niwCBAIYDw==
X-CSE-MsgGUID: gC9PxBAtQsaU9RJQCcOSlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11167"; a="21999657"
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="21999657"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 07:01:43 -0700
X-CSE-ConnectionGUID: IUuuM50cSgGYOIlVy/M2+A==
X-CSE-MsgGUID: WQO8NA1YRDSDWIkfb7JDDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="59944268"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 17 Aug 2024 07:01:40 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfJzu-0007X2-0z;
	Sat, 17 Aug 2024 14:01:38 +0000
Date: Sat, 17 Aug 2024 22:01:04 +0800
From: kernel test robot <lkp@intel.com>
To: Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, netdev@vger.kernel.org, felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, Tom Herbert <tom@herbertland.com>
Subject: Re: [PATCH net-next v2 04/12] flow_dissector: UDP encap
 infrastructure
Message-ID: <202408172101.UDWfVPns-lkp@intel.com>
References: <20240815214527.2100137-5-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815214527.2100137-5-tom@herbertland.com>

Hi Tom,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Tom-Herbert/flow_dissector-Parse-ETH_P_TEB-and-move-out-of-GRE/20240816-102659
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240815214527.2100137-5-tom%40herbertland.com
patch subject: [PATCH net-next v2 04/12] flow_dissector: UDP encap infrastructure
config: loongarch-randconfig-002-20240817 (https://download.01.org/0day-ci/archive/20240817/202408172101.UDWfVPns-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240817/202408172101.UDWfVPns-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408172101.UDWfVPns-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: net/core/flow_dissector.o: in function `__skb_flow_dissect_udp':
>> net/core/flow_dissector.c:844:(.text+0x13e8): undefined reference to `__udp4_lib_lookup'


vim +844 net/core/flow_dissector.c

   809	
   810	static enum flow_dissect_ret
   811	__skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
   812			       struct flow_dissector *flow_dissector,
   813			       void *target_container, const void *data,
   814			       int *p_nhoff, int hlen, __be16 *p_proto,
   815			       u8 *p_ip_proto, int base_nhoff, unsigned int flags)
   816	{
   817		enum flow_dissect_ret ret;
   818		const struct udphdr *udph;
   819		struct udphdr _udph;
   820		struct sock *sk;
   821		__u8 encap_type;
   822		int nhoff;
   823	
   824		if (!(flags & FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS))
   825			return FLOW_DISSECT_RET_OUT_GOOD;
   826	
   827		switch (*p_proto) {
   828		case htons(ETH_P_IP): {
   829			const struct iphdr *iph;
   830			struct iphdr _iph;
   831	
   832			iph = __skb_header_pointer(skb, base_nhoff, sizeof(_iph), data,
   833						   hlen, &_iph);
   834			if (!iph)
   835				return FLOW_DISSECT_RET_OUT_BAD;
   836	
   837			udph = __skb_header_pointer(skb, *p_nhoff, sizeof(_udph), data,
   838						    hlen, &_udph);
   839			if (!udph)
   840				return FLOW_DISSECT_RET_OUT_BAD;
   841	
   842			rcu_read_lock();
   843			/* Look up the UDPv4 socket and get the encap_type */
 > 844			sk = __udp4_lib_lookup(net, iph->saddr, udph->source,
   845					       iph->daddr, udph->dest,
   846					       inet_iif(skb), inet_sdif(skb),
   847					       net->ipv4.udp_table, NULL);
   848			if (!sk || !udp_sk(sk)->encap_type) {
   849				rcu_read_unlock();
   850				return FLOW_DISSECT_RET_OUT_GOOD;
   851			}
   852	
   853			encap_type = udp_sk(sk)->encap_type;
   854			rcu_read_unlock();
   855	
   856			break;
   857		}
   858	#if IS_ENABLED(CONFIG_IPV6)
   859		case htons(ETH_P_IPV6): {
   860			const struct ipv6hdr *iph;
   861			struct ipv6hdr _iph;
   862	
   863			if (!likely(ipv6_bpf_stub))
   864				return FLOW_DISSECT_RET_OUT_GOOD;
   865	
   866			iph = __skb_header_pointer(skb, base_nhoff, sizeof(_iph), data,
   867						   hlen, &_iph);
   868			if (!iph)
   869				return FLOW_DISSECT_RET_OUT_BAD;
   870	
   871			udph = __skb_header_pointer(skb, *p_nhoff, sizeof(_udph), data,
   872						    hlen, &_udph);
   873			if (!udph)
   874				return FLOW_DISSECT_RET_OUT_BAD;
   875	
   876			rcu_read_lock();
   877			/* Look up the UDPv6 socket and get the encap_type */
   878			sk = ipv6_bpf_stub->udp6_lib_lookup(net,
   879					&iph->saddr, udph->source,
   880					&iph->daddr, udph->dest,
   881					inet_iif(skb), inet_sdif(skb),
   882					net->ipv4.udp_table, NULL);
   883	
   884			if (!sk || !udp_sk(sk)->encap_type) {
   885				rcu_read_unlock();
   886				return FLOW_DISSECT_RET_OUT_GOOD;
   887			}
   888	
   889			encap_type = udp_sk(sk)->encap_type;
   890			rcu_read_unlock();
   891	
   892			break;
   893		}
   894	#endif /* CONFIG_IPV6 */
   895		default:
   896			return FLOW_DISSECT_RET_OUT_GOOD;
   897		}
   898	
   899		nhoff = *p_nhoff + sizeof(struct udphdr);
   900		ret = FLOW_DISSECT_RET_OUT_GOOD;
   901	
   902		switch (encap_type) {
   903		default:
   904			break;
   905		}
   906	
   907		switch (ret) {
   908		case FLOW_DISSECT_RET_PROTO_AGAIN:
   909			*p_ip_proto = 0;
   910			fallthrough;
   911		case FLOW_DISSECT_RET_IPPROTO_AGAIN:
   912			*p_nhoff = nhoff;
   913			break;
   914		default:
   915			break;
   916		}
   917	
   918		return ret;
   919	}
   920	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

