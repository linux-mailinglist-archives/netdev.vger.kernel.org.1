Return-Path: <netdev+bounces-120844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8B895B043
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 10:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1F81F2656B
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 08:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9551917E009;
	Thu, 22 Aug 2024 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kW+LVAX1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05101791ED
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315162; cv=none; b=tUGJpKr8WZd+jOkGFkHuSKTWdtcH6+tVWdUq1Qg0zy/15IiHY4fAuD/lLjTpKsHbmrd5WrEqRpOh3gTXv5MsTnshM2nRTkea9E28vXHtIIf2NAefSDJsDCscZQWbmGBbszu1dWMPe1/V7qkWnedXi+gsptq2f1O3IOTepVx8FGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315162; c=relaxed/simple;
	bh=0wYT3SDbeCeTCC7hcV35fhdguGmGGumQITVT8VEKndE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOMvaYgAo5cNGQ5x/8HJvJ2QAvk1TELybn7u1JoILVrH//qMoaxIWQ5X1n9nUYfcojrKgE/fz15KA7g/dC4hVcTCfUfZuE+cMWewzER4uCl77jEEtoX6gAkaKM8K4nfHUOfpmGyYC2uKOb3ZTIWLsOVTzo1UgpYuwv+8kIyGXh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kW+LVAX1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724315160; x=1755851160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0wYT3SDbeCeTCC7hcV35fhdguGmGGumQITVT8VEKndE=;
  b=kW+LVAX1+frQKQJ5Kl5lTBWtLvAnHojTr00Dr8cSOD6e9iNbHXq/hGG1
   lEbt2JQ4i/H8DZnN+hKPilHnwCn1YQ7mcay3l0+OO7KmwJUlXM8ng9wR1
   l4pLYwqQcx7OxptKvpVaSJ9KR46Il0220zrihTMz4XpEQVbzA3EUfDZbt
   rMDnQZu0kOFDKAViPP5JkSMyKcB2DueZPA6qjaxlRJKtnEW5X391wQDYB
   GZAw3ek6+MOOypn+jAXasq1nkCF9TuzOGam5oMX7Yvgzcu5rbY2Rq9JfG
   ygaevVpLrgCdzV7S/KfBCgIwdKrHi3sRb/8lX7iMODgtr2k75DGiRpRNQ
   g==;
X-CSE-ConnectionGUID: E/UqR61nTjifc3rwseNUQw==
X-CSE-MsgGUID: KmhbXJPnRdqqNly71ICntw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22867342"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="22867342"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 01:26:00 -0700
X-CSE-ConnectionGUID: J+1LPfOEQjCOXKPCnj1Kyw==
X-CSE-MsgGUID: ujofzOfGRoqC9yfuq1S1bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="65717030"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 22 Aug 2024 01:25:57 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sh38l-000CZg-1K;
	Thu, 22 Aug 2024 08:25:55 +0000
Date: Thu, 22 Aug 2024 16:25:07 +0800
From: kernel test robot <lkp@intel.com>
To: Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, netdev@vger.kernel.org, felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com, pablo@netfilter.org,
	laforge@gnumonks.org, xeb@mail.ru
Cc: oe-kbuild-all@lists.linux.dev, Tom Herbert <tom@herbertland.com>
Subject: Re: [PATCH net-next v3 05/13] flow_dissector: UDP encap
 infrastructure
Message-ID: <202408221600.x6NZMg4C-lkp@intel.com>
References: <20240821212212.1795357-6-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821212212.1795357-6-tom@herbertland.com>

Hi Tom,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Tom-Herbert/ipv6-Add-udp6_lib_lookup-to-IPv6-stubs/20240822-052515
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240821212212.1795357-6-tom%40herbertland.com
patch subject: [PATCH net-next v3 05/13] flow_dissector: UDP encap infrastructure
config: x86_64-buildonly-randconfig-001-20240822 (https://download.01.org/0day-ci/archive/20240822/202408221600.x6NZMg4C-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240822/202408221600.x6NZMg4C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408221600.x6NZMg4C-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/flow_dissector.c: In function '__skb_flow_dissect_udp':
>> net/core/flow_dissector.c:821:22: warning: unused variable 'sk' [-Wunused-variable]
     821 |         struct sock *sk;
         |                      ^~
>> net/core/flow_dissector.c:819:30: warning: unused variable 'udph' [-Wunused-variable]
     819 |         const struct udphdr *udph;
         |                              ^~~~


vim +/sk +821 net/core/flow_dissector.c

   809	
   810	static enum flow_dissect_ret
   811	__skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
   812			       struct flow_dissector *flow_dissector,
   813			       void *target_container, const void *data,
   814			       int *p_nhoff, int hlen, __be16 *p_proto,
   815			       u8 *p_ip_proto, int base_nhoff, unsigned int flags,
   816			       unsigned int num_hdrs)
   817	{
   818		enum flow_dissect_ret ret;
 > 819		const struct udphdr *udph;
   820		struct udphdr _udph;
 > 821		struct sock *sk;
   822		__u8 encap_type;
   823		int nhoff;
   824	
   825		if (!(flags & FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS))
   826			return FLOW_DISSECT_RET_OUT_GOOD;
   827	
   828		/* Check that the netns for the skb device is the same as the caller's,
   829		 * and only dissect UDP if we haven't yet encountered any encapsulation.
   830		 * The goal is to ensure that the socket lookup is being done in the
   831		 * right netns. Encapsulations may push packets into different name
   832		 * spaces, so this scheme is restricting UDP dissection to cases where
   833		 * they are in the same name spaces or at least the original name space.
   834		 * This should capture the majority of use cases for UDP encaps, and
   835		 * if we do encounter a UDP encapsulation within a different namespace
   836		 * then the only effect is we don't attempt UDP dissection
   837		 */
   838		if (dev_net(skb->dev) != net || num_hdrs > 0)
   839			return FLOW_DISSECT_RET_OUT_GOOD;
   840	
   841		switch (*p_proto) {
   842	#ifdef CONFIG_INET
   843		case htons(ETH_P_IP): {
   844			const struct iphdr *iph;
   845			struct iphdr _iph;
   846	
   847			iph = __skb_header_pointer(skb, base_nhoff, sizeof(_iph), data,
   848						   hlen, &_iph);
   849			if (!iph)
   850				return FLOW_DISSECT_RET_OUT_BAD;
   851	
   852			udph = __skb_header_pointer(skb, *p_nhoff, sizeof(_udph), data,
   853						    hlen, &_udph);
   854			if (!udph)
   855				return FLOW_DISSECT_RET_OUT_BAD;
   856	
   857			rcu_read_lock();
   858			/* Look up the UDPv4 socket and get the encap_type */
   859			sk = __udp4_lib_lookup(net, iph->saddr, udph->source,
   860					       iph->daddr, udph->dest,
   861					       inet_iif(skb), inet_sdif(skb),
   862					       net->ipv4.udp_table, NULL);
   863			if (!sk || !udp_sk(sk)->encap_type) {
   864				rcu_read_unlock();
   865				return FLOW_DISSECT_RET_OUT_GOOD;
   866			}
   867	
   868			encap_type = udp_sk(sk)->encap_type;
   869			rcu_read_unlock();
   870	
   871			break;
   872		}
   873	#if IS_ENABLED(CONFIG_IPV6)
   874		case htons(ETH_P_IPV6): {
   875			const struct ipv6hdr *iph;
   876			struct ipv6hdr _iph;
   877	
   878			if (!likely(ipv6_stub))
   879				return FLOW_DISSECT_RET_OUT_GOOD;
   880	
   881			iph = __skb_header_pointer(skb, base_nhoff, sizeof(_iph), data,
   882						   hlen, &_iph);
   883			if (!iph)
   884				return FLOW_DISSECT_RET_OUT_BAD;
   885	
   886			udph = __skb_header_pointer(skb, *p_nhoff, sizeof(_udph), data,
   887						    hlen, &_udph);
   888			if (!udph)
   889				return FLOW_DISSECT_RET_OUT_BAD;
   890	
   891			rcu_read_lock();
   892			/* Look up the UDPv6 socket and get the encap_type */
   893			sk = ipv6_stub->udp6_lib_lookup(net,
   894					&iph->saddr, udph->source,
   895					&iph->daddr, udph->dest,
   896					inet_iif(skb), inet_sdif(skb),
   897					net->ipv4.udp_table, NULL);
   898	
   899			if (!sk || !udp_sk(sk)->encap_type) {
   900				rcu_read_unlock();
   901				return FLOW_DISSECT_RET_OUT_GOOD;
   902			}
   903	
   904			encap_type = udp_sk(sk)->encap_type;
   905			rcu_read_unlock();
   906	
   907			break;
   908		}
   909	#endif /* CONFIG_IPV6 */
   910	#endif /* CONFIG_INET */
   911		default:
   912			return FLOW_DISSECT_RET_OUT_GOOD;
   913		}
   914	
   915		nhoff = *p_nhoff + sizeof(_udph);
   916		ret = FLOW_DISSECT_RET_OUT_GOOD;
   917	
   918		switch (encap_type) {
   919		default:
   920			break;
   921		}
   922	
   923		switch (ret) {
   924		case FLOW_DISSECT_RET_PROTO_AGAIN:
   925			*p_ip_proto = 0;
   926			fallthrough;
   927		case FLOW_DISSECT_RET_IPPROTO_AGAIN:
   928			*p_nhoff = nhoff;
   929			break;
   930		default:
   931			break;
   932		}
   933	
   934		return ret;
   935	}
   936	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

