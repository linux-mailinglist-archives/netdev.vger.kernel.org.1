Return-Path: <netdev+bounces-28533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C20C77FC40
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 18:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108B5282099
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2AB14F71;
	Thu, 17 Aug 2023 16:41:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61C433D1
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 16:41:26 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E51E2
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:41:22 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 8C21132004E7;
	Thu, 17 Aug 2023 12:41:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 17 Aug 2023 12:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1692290479; x=1692376879; bh=rTbgjRVFOGbl2
	FASp3/hPz5SzF2cutU3jrqO3MTogF0=; b=PVx65slqhTPNJ5Hi13+sC/xa3WrzL
	RsQ0S7aXkvi20uKat15GP6qvW8WxXIrLE1Z1gWfy/N7HLXrf1CJmDnljfPt/AqoN
	D1qf9pcl5RpthWisHXrhFW8l2xGXLXmQeMAw9O/WkMEPxdlX8A9zLlWhIaDwAOje
	9sW10MzhzfwWEgcdims50qNVa/dPqDuYPa7WvPUZd1MdVB8LpHkuJkD3L68xmI/f
	gExu7HZY1zYkPEUU1ODDrEqBIbBOpCsu/q0HRsTibItcP9ZXWJDWxbDZEmjD54N4
	paaTNMbnAdD4CV/BFIVfeHLGVD06B5ErkA6iEx5lMX1XnnZR0gAHT9mEA==
X-ME-Sender: <xms:rk3eZKdMP9RVJGWgrqV5BqmDQSusd0ppAwYhAGIp-OELVkRDRJ8RyA>
    <xme:rk3eZEPJuwEULS2yJq8_9Mo7xck_cFm7O4jy2Gk1tX5mzKp389f6LLxErdl_EIdHw
    WtIng6hiUSwtxY>
X-ME-Received: <xmr:rk3eZLg76w5aLyg5c65G6Q2c4ZAGQn9mr96QAb_uy00pSmyi_yLHGXnI-Ys7iumdCnOVu7ATjRJVD3yPifFVvd7bwGjocw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduuddguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeej
    geeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:rk3eZH8pU5SOtX-A6-WD7oBZH076RghuglEO2q0xTFoH925rZ9VWtw>
    <xmx:rk3eZGuJCH4Dz6_2wZSQvAsc_VmdrNa8m1YzP47NbsO_HnuOY4D4HA>
    <xmx:rk3eZOFAo052ex5VdO0f-UZMD7sjVtnCwITWxpITXcJYTB6rB1TGDw>
    <xmx:r03eZLVFMMGKunezWZWktgFGEYOqp2f603EHfb_9EqV8BdQeblP7Tg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Aug 2023 12:41:17 -0400 (EDT)
Date: Thu, 17 Aug 2023 19:41:13 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>, dsahern@gmail.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: Re: [Question]: TCP resets when using ECMP for load-balancing
 between multiple servers.
Message-ID: <ZN5NqZI2PGQ6W+a8@shredder>
References: <20230815201048.1796-1-sriram.yagnaraman@est.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815201048.1796-1-sriram.yagnaraman@est.tech>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

+ David, Paolo

On Tue, Aug 15, 2023 at 10:10:48PM +0200, Sriram Yagnaraman wrote:
> All packets in the same flow (L3/L4 depending on multipath hash policy)
> should be directed to the same target, but after [0] we see stray
> packets directed towards other targets. This, for instance, causes RST
> to be sent on TCP connections. This happens on a static setup, with no
> changes to the nexthops, so there is no hash space reassignment.

Which multipath hash policy are you using? I guess the issue is more
visible with L4 as ip_can_use_hint() at least makes sure the destination
IP is the same before using the hint.

> 
> IIUC, route hints when the next hop is part of a multipath group causes
> packets in the same receive batch to be sent to the same next hop
> irrespective of which nexthop the multipath hash points to. I am no
> expert in this area, so please let me know if there is a simple
> explanation on how to fix this problem?
> 
> Below is a patch which has a selftest that describes the problem setup
> and a hack to solve the problem in ipv4. For ipv6, I have just commented
> out the part the returns the route hint, just for testing.

Did you consider marking the skb instead of the route? Something like
[1]. Compile tested only.

Also, are you positive that your selftest fails before the patch and
passes after? It is using VRFs, which use FIB rules, which should in
turn disable the use of hints. If this is indeed the case, then try
using namespaces instead. There are various examples outside of the
forwarding directory.

[1]
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 5883551b1ee8..9ecebb8c6ffa 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -147,6 +147,7 @@ struct inet6_skb_parm {
 #define IP6SKB_JUMBOGRAM      128
 #define IP6SKB_SEG6          256
 #define IP6SKB_FAKEJUMBO      512
+#define IP6SKB_MULTIPATH     1024
 };
 
 #if defined(CONFIG_NET_L3_MASTER_DEV)
diff --git a/include/net/ip.h b/include/net/ip.h
index 332521170d9b..bdce572fa422 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -57,6 +57,7 @@ struct inet_skb_parm {
 #define IPSKB_FRAG_PMTU                BIT(6)
 #define IPSKB_L3SLAVE          BIT(7)
 #define IPSKB_NOPOLICY         BIT(8)
+#define IPSKB_MULTIPATH                BIT(9)
 
        u16                     frag_max_size;
 };
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index fe9ead9ee863..5e9c8156656a 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -584,7 +584,8 @@ static void ip_sublist_rcv_finish(struct list_head *head)
 static struct sk_buff *ip_extract_route_hint(const struct net *net,
                                             struct sk_buff *skb, int rt_type)
 {
-       if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST)
+       if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST ||
+           IPCB(skb)->flags & IPSKB_MULTIPATH)
                return NULL;
 
        return skb;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index a4e153dd615b..6a3f57a3fa41 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2144,6 +2144,7 @@ static int ip_mkroute_input(struct sk_buff *skb,
                int h = fib_multipath_hash(res->fi->fib_net, NULL, skb, hkeys);
 
                fib_select_multipath(res, h);
+               IPCB(skb)->flags |= IPSKB_MULTIPATH;
        }
 #endif
 
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index d94041bb4287..b8378814532c 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -99,7 +99,8 @@ static bool ip6_can_use_hint(const struct sk_buff *skb,
 static struct sk_buff *ip6_extract_route_hint(const struct net *net,
                                              struct sk_buff *skb)
 {
-       if (fib6_routes_require_src(net) || fib6_has_custom_rules(net))
+       if (fib6_routes_require_src(net) || fib6_has_custom_rules(net) ||
+           IP6CB(skb)->flags & IP6SKB_MULTIPATH)
                return NULL;
 
        return skb;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index db10c36f34bb..4cdc82931c91 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -424,6 +424,8 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
        if (match->nh && have_oif_match && res->nh)
                return;
 
+       IP6CB(skb)->flags |= IP6SKB_MULTIPATH;
+
        /* We might have already computed the hash for ICMPv6 errors. In such
         * case it will always be non-zero. Otherwise now is the time to do it.
         */

> 
> [0]: 02b24941619f ("ipv4: use dst hint for ipv4 list receive")
> 
> ---
>  include/uapi/linux/in_route.h                 |   1 +
>  net/ipv4/ip_input.c                           |   9 +-
>  net/ipv4/route.c                              |   7 +-
>  net/ipv6/ip6_input.c                          |   4 +
>  .../testing/selftests/net/forwarding/Makefile |   1 +
>  .../net/forwarding/router_multipath_vip.sh    | 324 ++++++++++++++++++
>  6 files changed, 341 insertions(+), 5 deletions(-)
>  create mode 100755 tools/testing/selftests/net/forwarding/router_multipath_vip.sh
> 
> diff --git a/include/uapi/linux/in_route.h b/include/uapi/linux/in_route.h
> index 0cc2c23b47f8..01ae06c7743b 100644
> --- a/include/uapi/linux/in_route.h
> +++ b/include/uapi/linux/in_route.h
> @@ -15,6 +15,7 @@
>  #define RTCF_REDIRECTED	0x00040000
>  #define RTCF_TPROXY	0x00080000 /* unused */
>  
> +#define RTCF_MULTIPATH	0x00200000
>  #define RTCF_FAST	0x00200000 /* unused */
>  #define RTCF_MASQ	0x00400000 /* unused */
>  #define RTCF_SNAT	0x00800000 /* unused */
> diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
> index fe9ead9ee863..e06a1a6a4357 100644
> --- a/net/ipv4/ip_input.c
> +++ b/net/ipv4/ip_input.c
> @@ -582,9 +582,11 @@ static void ip_sublist_rcv_finish(struct list_head *head)
>  }
>  
>  static struct sk_buff *ip_extract_route_hint(const struct net *net,
> -					     struct sk_buff *skb, int rt_type)
> +					     struct sk_buff *skb, int rt_type,
> +					     unsigned int rt_flags)
>  {
> -	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST)
> +	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST ||
> +	    !!(rt_flags & RTCF_MULTIPATH))
>  		return NULL;
>  
>  	return skb;
> @@ -615,7 +617,8 @@ static void ip_list_rcv_finish(struct net *net, struct sock *sk,
>  		dst = skb_dst(skb);
>  		if (curr_dst != dst) {
>  			hint = ip_extract_route_hint(net, skb,
> -					       ((struct rtable *)dst)->rt_type);
> +					       ((struct rtable *)dst)->rt_type,
> +					       ((struct rtable *)dst)->rt_flags);
>  
>  			/* dispatch old sublist */
>  			if (!list_empty(&sublist))
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 92fede388d52..232b507faf04 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -1786,6 +1786,7 @@ static void ip_handle_martian_source(struct net_device *dev,
>  
>  /* called in rcu_read_lock() section */
>  static int __mkroute_input(struct sk_buff *skb,
> +			   unsigned int flags,
>  			   const struct fib_result *res,
>  			   struct in_device *in_dev,
>  			   __be32 daddr, __be32 saddr, u32 tos)
> @@ -1856,7 +1857,7 @@ static int __mkroute_input(struct sk_buff *skb,
>  		}
>  	}
>  
> -	rth = rt_dst_alloc(out_dev->dev, 0, res->type,
> +	rth = rt_dst_alloc(out_dev->dev, flags, res->type,
>  			   IN_DEV_ORCONF(out_dev, NOXFRM));
>  	if (!rth) {
>  		err = -ENOBUFS;
> @@ -2139,16 +2140,18 @@ static int ip_mkroute_input(struct sk_buff *skb,
>  			    __be32 daddr, __be32 saddr, u32 tos,
>  			    struct flow_keys *hkeys)
>  {
> +	unsigned int flags = 0;
>  #ifdef CONFIG_IP_ROUTE_MULTIPATH
>  	if (res->fi && fib_info_num_path(res->fi) > 1) {
>  		int h = fib_multipath_hash(res->fi->fib_net, NULL, skb, hkeys);
>  
>  		fib_select_multipath(res, h);
> +		flags |= RTCF_MULTIPATH;
>  	}
>  #endif
>  
>  	/* create a routing cache entry */
> -	return __mkroute_input(skb, res, in_dev, daddr, saddr, tos);
> +	return __mkroute_input(skb, flags, res, in_dev, daddr, saddr, tos);
>  }
>  
>  /* Implements all the saddr-related checks as ip_route_input_slow(),
> diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
> index d94041bb4287..1b7527a4a4bd 100644
> --- a/net/ipv6/ip6_input.c
> +++ b/net/ipv6/ip6_input.c
> @@ -99,10 +99,14 @@ static bool ip6_can_use_hint(const struct sk_buff *skb,
>  static struct sk_buff *ip6_extract_route_hint(const struct net *net,
>  					      struct sk_buff *skb)
>  {
> +#if 0
>  	if (fib6_routes_require_src(net) || fib6_has_custom_rules(net))
>  		return NULL;
>  
>  	return skb;
> +#else
> +	return NULL;
> +#endif
>  }
>  
>  static void ip6_list_rcv_finish(struct net *net, struct sock *sk,
> diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
> index 770efbe24f0d..bf4e5745fd5c 100644
> --- a/tools/testing/selftests/net/forwarding/Makefile
> +++ b/tools/testing/selftests/net/forwarding/Makefile
> @@ -70,6 +70,7 @@ TEST_PROGS = bridge_igmp.sh \
>  	router_mpath_nh.sh \
>  	router_multicast.sh \
>  	router_multipath.sh \
> +	router_multipath_vip.sh \
>  	router_nh.sh \
>  	router.sh \
>  	router_vid_1.sh \
> diff --git a/tools/testing/selftests/net/forwarding/router_multipath_vip.sh b/tools/testing/selftests/net/forwarding/router_multipath_vip.sh
> new file mode 100755
> index 000000000000..0415cf974388
> --- /dev/null
> +++ b/tools/testing/selftests/net/forwarding/router_multipath_vip.sh
> @@ -0,0 +1,324 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# +--------------------+                     +----------------------+
> +# | H1                 |                     |                   H2 |
> +# |                    |                     |                      |
> +# |              $h1 + |                     | + $h2                |
> +# |     192.0.2.2/24 | |                     | | 198.51.100.2/24    |
> +# | 2001:db8:1::2/64 | |                     | | 2001:db8:2::2/64   |
> +# |                  | |                     | |                    |
> +# +------------------|-+                     +-|--------------------+
> +#                    |                         |
> +# +------------------|-------------------------|--------------------+
> +# | SW               |                         |                    |
> +# |                  |                         |                    |
> +# |             $rp1 +                         + $rp2               |
> +# |     192.0.2.1/24                             198.51.100.1/24    |
> +# | 2001:db8:1::1/64     + vip                   2001:db8:2::1/64   |
> +# |                        198.18.0.0/24                            |
> +# |                        2001:db8:18::/64    + $rp3               |
> +# |                                            | 203.0.113.1/24     |
> +# |                                            | 2001:db8:3::1/64   |
> +# |                                            |                    |
> +# |                                            |                    |
> +# +--------------------------------------------|--------------------+
> +#                                              |
> +#                                            +-|--------------------+
> +#                                            | |                 H3 |
> +#                                            | |                    |
> +#                                            | | 203.0.113.2/24     |
> +#                                            | | 2001:db8:3::2/64   |
> +#                                            | + $h3                |
> +#                                            |                      |
> +#                                            +----------------------+
> +
> +ALL_TESTS="ping_ipv4 ping_ipv6 multipath_test"
> +NUM_NETIFS=6
> +source lib.sh
> +
> +h1_create()
> +{
> +	vrf_create "vrf-h1"
> +	ip link set dev $h1 master vrf-h1
> +
> +	ip link set dev vrf-h1 up
> +	ip link set dev $h1 up
> +
> +	ip address add 192.0.2.2/24 dev $h1
> +	ip address add 2001:db8:1::2/64 dev $h1
> +
> +	ip route add default vrf vrf-h1 via 192.0.2.1
> +	ip route add default vrf vrf-h1 via 2001:db8:1::1
> +}
> +
> +h1_destroy()
> +{
> +	ip route del default vrf vrf-h1 via 2001:db8:1::1
> +	ip route del default vrf vrf-h1 via 192.0.2.1
> +
> +	ip address del 2001:db8:1::2/64 dev $h1
> +	ip address del 192.0.2.2/24 dev $h1
> +
> +	ip link set dev $h1 down
> +	vrf_destroy "vrf-h1"
> +}
> +
> +h2_create()
> +{
> +	vrf_create "vrf-h2"
> +	ip link set dev $h2 master vrf-h2
> +
> +	ip link set dev vrf-h2 up
> +	ip link set dev $h2 up
> +
> +	ip address add 198.51.100.2/24 dev $h2
> +	ip address add 2001:db8:2::2/64 dev $h2
> +
> +	ip address add 198.18.0.0/24 dev vrf-h2
> +	ip address add 2001:db8:18::/64 dev vrf-h2
> +
> +	ip route add 192.0.2.0/24 vrf vrf-h2 via 198.51.100.1
> +	ip route add 2001:db8:1::/64 vrf vrf-h2 nexthop via 2001:db8:2::1
> +}
> +
> +h2_destroy()
> +{
> +	ip route del 2001:db8:1::/64 vrf vrf-h2 nexthop via 2001:db8:2::1
> +	ip route del 192.0.2.0/24 vrf vrf-h2 via 198.51.100.1
> +
> +	ip address del 2001:db8:18::/64 dev vrf-h2
> +	ip address del 198.18.0.0/24 dev vrf-h2
> +
> +	ip address del 2001:db8:2::2/64 dev $h2
> +	ip address del 198.51.100.2/24 dev $h2
> +
> +	ip link set dev $h2 down
> +	vrf_destroy "vrf-h2"
> +}
> +
> +h3_create()
> +{
> +	vrf_create "vrf-h3"
> +	ip link set dev $h3 master vrf-h3
> +
> +	ip link set dev vrf-h3 up
> +	ip link set dev $h3 up
> +
> +	ip address add 203.0.113.2/24 dev $h3
> +	ip address add 2001:db8:3::2/64 dev $h3
> +
> +	ip address add 198.18.0.0/24 dev vrf-h3
> +	ip address add 2001:db8:18::/64 dev vrf-h3
> +
> +	ip route add 192.0.2.0/24 vrf vrf-h3 via 203.0.113.1
> +	ip route add 2001:db8:1::/64 vrf vrf-h3 nexthop via 2001:db8:3::1
> +}
> +
> +h3_destroy()
> +{
> +	ip route del 2001:db8:1::/64 vrf vrf-h3 nexthop via 2001:db8:3::1
> +	ip route del 192.0.2.0/24 vrf vrf-h3 via 203.0.113.1
> +
> +	ip address del 198.18.0.0/24 dev vrf-h3
> +	ip address del 2001:db8:18::/64 dev vrf-h3
> +
> +	ip address del 2001:db8:3::2/64 dev $h3
> +	ip address del 203.0.113.2/24 dev $h3
> +
> +	ip link set dev $h3 down
> +	vrf_destroy "vrf-h3"
> +}
> +
> +router1_create()
> +{
> +	vrf_create "vrf-r1"
> +	ip link set dev $rp1 master vrf-r1
> +	ip link set dev $rp2 master vrf-r1
> +	ip link set dev $rp3 master vrf-r1
> +
> +	ip link set dev vrf-r1 up
> +	ip link set dev $rp1 up
> +	ip link set dev $rp2 up
> +	ip link set dev $rp3 up
> +
> +	ip address add 192.0.2.1/24 dev $rp1
> +	ip address add 2001:db8:1::1/64 dev $rp1
> +
> +	ip address add 198.51.100.1/24 dev $rp2
> +	ip address add 2001:db8:2::1/64 dev $rp2
> +
> +	ip address add 203.0.113.1/24 dev $rp3
> +	ip address add 2001:db8:3::1/64 dev $rp3
> +
> +	ip route add 198.18.0.0/24 vrf vrf-r1 \
> +		nexthop via 198.51.100.2 \
> +		nexthop via 203.0.113.2
> +	ip route add 2001:db8:18::/64 vrf vrf-r1 \
> +		nexthop via 2001:db8:2::2 \
> +		nexthop via 2001:db8:3::2
> +}
> +
> +router1_destroy()
> +{
> +	ip route del 2001:db8:18::/64 vrf vrf-r1
> +	ip route del 198.18.0.0/24 vrf vrf-r1
> +
> +	ip address del 2001:db8:3::1/64 dev $rp3
> +	ip address del 203.0.113.1/24 dev $rp3
> +
> +	ip address del 2001:db8:2::1/64 dev $rp2
> +	ip address del 198.51.100.1/24 dev $rp2
> +
> +	ip address del 2001:db8:1::1/64 dev $rp1
> +	ip address del 192.0.2.1/24 dev $rp1
> +
> +	ip link set dev $rp3 down
> +	ip link set dev $rp2 down
> +	ip link set dev $rp1 down
> +
> +	vrf_destroy "vrf-r1"
> +}
> +
> +multipath4_test()
> +{
> +	local desc="$1"
> +	local weight_rp2=$2
> +	local weight_rp3=$3
> +	local t0_rp2 t0_rp3 t1_rp2 t1_rp3
> +	local packets_rp2 packets_rp3
> +
> +	# Transmit multiple flows from h1 to h2 and make sure they are
> +	# distributed between both multipath links (rp2 and rp3)
> +	# according to the configured weights.
> +	sysctl_set net.ipv4.fib_multipath_hash_policy 1
> +	ip route replace 198.18.0.0/24 vrf vrf-r1 \
> +		nexthop via 198.51.100.2 weight $weight_rp2 \
> +		nexthop via 203.0.113.2 weight $weight_rp3
> +
> +	t0_rp2=$(link_stats_tx_packets_get $rp2)
> +	t0_rp3=$(link_stats_tx_packets_get $rp3)
> +
> +	ip vrf exec vrf-h1 $MZ $h1 -q -p 64 -A 192.0.2.2 -B 198.18.0.0 \
> +		-d 1msec -t tcp "sp=1024,dp=0-32768"
> +
> +	t1_rp2=$(link_stats_tx_packets_get $rp2)
> +	t1_rp3=$(link_stats_tx_packets_get $rp3)
> +
> +	let "packets_rp2 = $t1_rp2 - $t0_rp2"
> +	let "packets_rp3 = $t1_rp3 - $t0_rp3"
> +	multipath_eval "$desc" $weight_rp2 $weight_rp3 $packets_rp2 $packets_rp3
> +
> +	ip route replace 198.18.0.0/24 vrf vrf-r1 \
> +		nexthop via 198.51.100.2 \
> +		nexthop via 203.0.113.2
> +
> +	sysctl_restore net.ipv4.fib_multipath_hash_policy
> +}
> +
> +multipath6_l4_test()
> +{
> +	local desc="$1"
> +	local weight_rp2=$2
> +	local weight_rp3=$3
> +	local t0_rp2 t0_rp3 t1_rp2 t1_rp3
> +	local packets_rp2 packets_rp3
> +
> +	# Transmit multiple flows from h1 to h2 and make sure they are
> +	# distributed between both multipath links (rp2 and rp3)
> +	# according to the configured weights.
> +	sysctl_set net.ipv6.fib_multipath_hash_policy 1
> +	ip route replace 2001:db8:18::/64 vrf vrf-r1 \
> +		nexthop via 2001:db8:2::2 weight $weight_rp2 \
> +		nexthop via 2001:db8:3::2 weight $weight_rp3
> +
> +	t0_rp2=$(link_stats_tx_packets_get $rp2)
> +	t0_rp3=$(link_stats_tx_packets_get $rp3)
> +
> +	ip vrf exec vrf-h1 $MZ $h1 -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:18::0 \
> +		-d 1msec -t tcp "sp=1024,dp=0-32768"
> +
> +	t1_rp2=$(link_stats_tx_packets_get $rp2)
> +	t1_rp3=$(link_stats_tx_packets_get $rp3)
> +
> +	let "packets_rp2 = $t1_rp2 - $t0_rp2"
> +	let "packets_rp3 = $t1_rp3 - $t0_rp3"
> +	multipath_eval "$desc" $weight_rp2 $weight_rp3 $packets_rp2 $packets_rp3
> +
> +	ip route replace 2001:db8:18::/64 vrf vrf-r1 \
> +		nexthop via 2001:db8:2::2 \
> +		nexthop via 2001:db8:3::2
> +
> +	sysctl_restore net.ipv6.fib_multipath_hash_policy
> +}
> +
> +multipath_test()
> +{
> +	log_info "Running IPv4 multipath tests"
> +	multipath4_test "ECMP" 1 1
> +	multipath4_test "Weighted MP 2:1" 2 1
> +	multipath4_test "Weighted MP 11:45" 11 45
> +
> +	log_info "Running IPv6 L4 hash multipath tests"
> +	multipath6_l4_test "ECMP" 1 1
> +	multipath6_l4_test "Weighted MP 2:1" 2 1
> +	multipath6_l4_test "Weighted MP 11:45" 11 45
> +}
> +
> +setup_prepare()
> +{
> +	h1=${NETIFS[p1]}
> +	rp1=${NETIFS[p2]}
> +
> +	rp2=${NETIFS[p3]}
> +	h2=${NETIFS[p4]}
> +
> +	rp3=${NETIFS[p5]}
> +	h3=${NETIFS[p6]}
> +
> +	vrf_prepare
> +
> +	h1_create
> +	h2_create
> +	h3_create
> +
> +	router1_create
> +
> +	forwarding_enable
> +}
> +
> +cleanup()
> +{
> +	pre_cleanup
> +
> +	forwarding_restore
> +
> +	router1_destroy
> +
> +	h3_destroy
> +	h2_destroy
> +	h1_destroy
> +
> +	vrf_cleanup
> +}
> +
> +ping_ipv4()
> +{
> +	ping_test $h1 198.51.100.2
> +	ping_test $h1 203.0.113.2
> +}
> +
> +ping_ipv6()
> +{
> +	ping6_test $h1 2001:db8:2::2
> +	ping6_test $h1 2001:db8:3::2
> +}
> +
> +trap cleanup EXIT
> +
> +setup_prepare
> +setup_wait
> +
> +tests_run
> +
> +exit $EXIT_STATUS
> -- 
> 2.34.1
> 
> 

