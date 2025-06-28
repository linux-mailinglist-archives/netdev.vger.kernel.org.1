Return-Path: <netdev+bounces-202112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E3BAEC412
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 04:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA19E189BC76
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 02:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93404145FE0;
	Sat, 28 Jun 2025 02:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCwxwCW/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7A85661
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 02:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751076972; cv=none; b=LGQrRcg2ra1M8W5YSnTzR2f8NPlxBeMrl5diarBNNLCZpbXza51oZKar6xFu/ByDeGGh2YfWrd7qpx5UUossQqf2yjdMsBtgJmmo2d8fq1tfOTFQZSgZH7q/yl8tOkpkyte/qvA1Va5+H9UJGWZ67TBlXZtC7UjXFcj7Qcl09Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751076972; c=relaxed/simple;
	bh=ag7Kr6KM9qZ+uPV1cOWPb3YE+2clOt88Kxu8Wy0cy6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT7xrZS+vSu7NX/2UacvHmVjoCy4fhN1jlSA9INbMxp+KwIszhg2Xhl0ymv8ccILmOHjAZKjXDqjm79DrMTs3OaY6s6SShNwtAbv7xzXT8jsS5F4b3BxQTWcID14MBNhdrXNZIR3JvOKWgRHqg3zIXc7WwCbMjEh4kUarvwjRN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCwxwCW/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751076970; x=1782612970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ag7Kr6KM9qZ+uPV1cOWPb3YE+2clOt88Kxu8Wy0cy6g=;
  b=DCwxwCW/jHivOd6DzCkFG+0RBLbJe2iBhmuTlwPb7V7/ggd15UyemPUk
   08VDROhTXQgpq9WXsag/u2KK2ebgNR4oo37EijGXt//8KrG+asSc0J33f
   QgRbEhvJoWFNMIUiHQp/fNrLfGE9LXN5xdXboZNVhJhyqosRlsl0B2622
   jgmiZOf1IPRCP2hvRUAhx3e9wgMa6MxWUTTv4TaGo+hAluHd1cZuM9fTQ
   3jHgjbS2aH4pTqfuR9Q2i0K7zAfcar/cWSq1X7TSB4H5thSy1MduLS57k
   VQzKEyGmWxgHCZqGOFTJ1QNYUNzc3o5A9gIC5A4q1P+MybJTb4nXLHyjG
   g==;
X-CSE-ConnectionGUID: QZdCHlaLTIOzwkgaJMZSHQ==
X-CSE-MsgGUID: 0PR4x3sWSYW3SO/nYj0ADw==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="75938876"
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="75938876"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 19:16:10 -0700
X-CSE-ConnectionGUID: qP/hKwJASHG3oi12STQ0Gw==
X-CSE-MsgGUID: /6MyDilPSx6eBCfjfgwgag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="152340632"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 27 Jun 2025 19:16:06 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVL6r-000Wfa-0d;
	Sat, 28 Jun 2025 02:16:05 +0000
Date: Sat, 28 Jun 2025 10:15:42 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 09/10] ipv6: adopt skb_dst_dev() and
 skb_dst_dev_net[_rcu]() helpers
Message-ID: <202506281042.86fCDDNl-lkp@intel.com>
References: <20250627112526.3615031-10-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627112526.3615031-10-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-dst-annotate-data-races-around-dst-obsolete/20250627-192850
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250627112526.3615031-10-edumazet%40google.com
patch subject: [PATCH net-next 09/10] ipv6: adopt skb_dst_dev() and skb_dst_dev_net[_rcu]() helpers
config: x86_64-buildonly-randconfig-006-20250628 (https://download.01.org/0day-ci/archive/20250628/202506281042.86fCDDNl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250628/202506281042.86fCDDNl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506281042.86fCDDNl-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ipv6/exthdrs.c: In function 'ipv6_rthdr_rcv':
>> net/ipv6/exthdrs.c:786:41: error: too many arguments to function 'dev_net'
     786 |                 if (!ipv6_chk_home_addr(dev_net(skb_dst_dev(skb), addr)) {
         |                                         ^~~~~~~
   In file included from net/ipv6/exthdrs.c:25:
   include/linux/netdevice.h:2711:13: note: declared here
    2711 | struct net *dev_net(const struct net_device *dev)
         |             ^~~~~~~
>> net/ipv6/exthdrs.c:786:22: error: too few arguments to function 'ipv6_chk_home_addr'
     786 |                 if (!ipv6_chk_home_addr(dev_net(skb_dst_dev(skb), addr)) {
         |                      ^~~~~~~~~~~~~~~~~~
   In file included from include/net/ip6_route.h:5,
                    from net/ipv6/exthdrs.c:40:
   include/net/addrconf.h:122:5: note: declared here
     122 | int ipv6_chk_home_addr(struct net *net, const struct in6_addr *addr);
         |     ^~~~~~~~~~~~~~~~~~
>> net/ipv6/exthdrs.c:786:73: error: expected ')' before '{' token
     786 |                 if (!ipv6_chk_home_addr(dev_net(skb_dst_dev(skb), addr)) {
         |                    ~                                                    ^~
         |                                                                         )
>> net/ipv6/exthdrs.c:795:9: error: expected expression before '}' token
     795 |         }
         |         ^


vim +/dev_net +786 net/ipv6/exthdrs.c

   642	
   643	/********************************
   644	  Routing header.
   645	 ********************************/
   646	
   647	/* called with rcu_read_lock() */
   648	static int ipv6_rthdr_rcv(struct sk_buff *skb)
   649	{
   650		struct inet6_dev *idev = __in6_dev_get(skb->dev);
   651		struct inet6_skb_parm *opt = IP6CB(skb);
   652		struct in6_addr *addr = NULL;
   653		int n, i;
   654		struct ipv6_rt_hdr *hdr;
   655		struct rt0_hdr *rthdr;
   656		struct net *net = dev_net(skb->dev);
   657		int accept_source_route;
   658	
   659		accept_source_route = READ_ONCE(net->ipv6.devconf_all->accept_source_route);
   660	
   661		if (idev)
   662			accept_source_route = min(accept_source_route,
   663						  READ_ONCE(idev->cnf.accept_source_route));
   664	
   665		if (!pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
   666		    !pskb_may_pull(skb, (skb_transport_offset(skb) +
   667					 ((skb_transport_header(skb)[1] + 1) << 3)))) {
   668			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
   669			kfree_skb(skb);
   670			return -1;
   671		}
   672	
   673		hdr = (struct ipv6_rt_hdr *)skb_transport_header(skb);
   674	
   675		if (ipv6_addr_is_multicast(&ipv6_hdr(skb)->daddr) ||
   676		    skb->pkt_type != PACKET_HOST) {
   677			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INADDRERRORS);
   678			kfree_skb(skb);
   679			return -1;
   680		}
   681	
   682		switch (hdr->type) {
   683		case IPV6_SRCRT_TYPE_4:
   684			/* segment routing */
   685			return ipv6_srh_rcv(skb);
   686		case IPV6_SRCRT_TYPE_3:
   687			/* rpl segment routing */
   688			return ipv6_rpl_srh_rcv(skb);
   689		default:
   690			break;
   691		}
   692	
   693	looped_back:
   694		if (hdr->segments_left == 0) {
   695			switch (hdr->type) {
   696	#if IS_ENABLED(CONFIG_IPV6_MIP6)
   697			case IPV6_SRCRT_TYPE_2:
   698				/* Silently discard type 2 header unless it was
   699				 * processed by own
   700				 */
   701				if (!addr) {
   702					__IP6_INC_STATS(net, idev,
   703							IPSTATS_MIB_INADDRERRORS);
   704					kfree_skb(skb);
   705					return -1;
   706				}
   707				break;
   708	#endif
   709			default:
   710				break;
   711			}
   712	
   713			opt->lastopt = opt->srcrt = skb_network_header_len(skb);
   714			skb->transport_header += (hdr->hdrlen + 1) << 3;
   715			opt->dst0 = opt->dst1;
   716			opt->dst1 = 0;
   717			opt->nhoff = (&hdr->nexthdr) - skb_network_header(skb);
   718			return 1;
   719		}
   720	
   721		switch (hdr->type) {
   722	#if IS_ENABLED(CONFIG_IPV6_MIP6)
   723		case IPV6_SRCRT_TYPE_2:
   724			if (accept_source_route < 0)
   725				goto unknown_rh;
   726			/* Silently discard invalid RTH type 2 */
   727			if (hdr->hdrlen != 2 || hdr->segments_left != 1) {
   728				__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
   729				kfree_skb(skb);
   730				return -1;
   731			}
   732			break;
   733	#endif
   734		default:
   735			goto unknown_rh;
   736		}
   737	
   738		/*
   739		 *	This is the routing header forwarding algorithm from
   740		 *	RFC 2460, page 16.
   741		 */
   742	
   743		n = hdr->hdrlen >> 1;
   744	
   745		if (hdr->segments_left > n) {
   746			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
   747			icmpv6_param_prob(skb, ICMPV6_HDR_FIELD,
   748					  ((&hdr->segments_left) -
   749					   skb_network_header(skb)));
   750			return -1;
   751		}
   752	
   753		/* We are about to mangle packet header. Be careful!
   754		   Do not damage packets queued somewhere.
   755		 */
   756		if (skb_cloned(skb)) {
   757			/* the copy is a forwarded packet */
   758			if (pskb_expand_head(skb, 0, 0, GFP_ATOMIC)) {
   759				__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
   760						IPSTATS_MIB_OUTDISCARDS);
   761				kfree_skb(skb);
   762				return -1;
   763			}
   764			hdr = (struct ipv6_rt_hdr *)skb_transport_header(skb);
   765		}
   766	
   767		if (skb->ip_summed == CHECKSUM_COMPLETE)
   768			skb->ip_summed = CHECKSUM_NONE;
   769	
   770		i = n - --hdr->segments_left;
   771	
   772		rthdr = (struct rt0_hdr *) hdr;
   773		addr = rthdr->addr;
   774		addr += i - 1;
   775	
   776		switch (hdr->type) {
   777	#if IS_ENABLED(CONFIG_IPV6_MIP6)
   778		case IPV6_SRCRT_TYPE_2:
   779			if (xfrm6_input_addr(skb, (xfrm_address_t *)addr,
   780					     (xfrm_address_t *)&ipv6_hdr(skb)->saddr,
   781					     IPPROTO_ROUTING) < 0) {
   782				__IP6_INC_STATS(net, idev, IPSTATS_MIB_INADDRERRORS);
   783				kfree_skb(skb);
   784				return -1;
   785			}
 > 786			if (!ipv6_chk_home_addr(dev_net(skb_dst_dev(skb), addr)) {
   787				__IP6_INC_STATS(net, idev, IPSTATS_MIB_INADDRERRORS);
   788				kfree_skb(skb);
   789				return -1;
   790			}
   791			break;
   792	#endif
   793		default:
   794			break;
 > 795		}
   796	
   797		if (ipv6_addr_is_multicast(addr)) {
   798			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INADDRERRORS);
   799			kfree_skb(skb);
   800			return -1;
   801		}
   802	
   803		swap(*addr, ipv6_hdr(skb)->daddr);
   804	
   805		ip6_route_input(skb);
   806		if (skb_dst(skb)->error) {
   807			skb_push(skb, -skb_network_offset(skb));
   808			dst_input(skb);
   809			return -1;
   810		}
   811	
   812		if (skb_dst_dev(skb)->flags & IFF_LOOPBACK) {
   813			if (ipv6_hdr(skb)->hop_limit <= 1) {
   814				__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
   815				icmpv6_send(skb, ICMPV6_TIME_EXCEED, ICMPV6_EXC_HOPLIMIT,
   816					    0);
   817				kfree_skb(skb);
   818				return -1;
   819			}
   820			ipv6_hdr(skb)->hop_limit--;
   821			goto looped_back;
   822		}
   823	
   824		skb_push(skb, -skb_network_offset(skb));
   825		dst_input(skb);
   826		return -1;
   827	
   828	unknown_rh:
   829		__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
   830		icmpv6_param_prob(skb, ICMPV6_HDR_FIELD,
   831				  (&hdr->type) - skb_network_header(skb));
   832		return -1;
   833	}
   834	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

