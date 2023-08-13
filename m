Return-Path: <netdev+bounces-27172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DBA77A9C3
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 18:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA7F1C20957
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 16:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EDB8F67;
	Sun, 13 Aug 2023 16:19:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9381E8C0B
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 16:19:06 +0000 (UTC)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91039199E
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 09:18:45 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id F322E320005D;
	Sun, 13 Aug 2023 12:09:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 13 Aug 2023 12:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1691942990; x=1692029390; bh=xkyKermy4Q9dC
	m+CXhtQi/s8ql9+kXVMcUn/hl1Dt24=; b=j7KwfF79E1/1YZVuExSC2mRhCbALl
	0/qEUhLPd5FyRJFXZ8PnT8cvklKldyg9aFbXyF+DK7NRcV1W8uGu9T2ByIoOaCJQ
	erMd9jJ8Eh84Kh4YBgq2B5op7fpmjoL0Fd0s6sq5oKv/RlKMqB1nFKW59sv91fjW
	4wLmi+fRLTDWMDj7YWI+mbFlIKXmQSBcpnK8GAC1WL+qvL50egfg91xgxRG8hfm3
	ce+JVWcHNhPJT4DdyDtrzYMT5xICEepdd+mvJWWeua6JPWYPowFRTZqeAhiIWwgM
	sE+xPjG8WYo9t6mylPjhMWyts7aVs5OKUE+FRbLWZepC+B90hjxSnXFoA==
X-ME-Sender: <xms:TgDZZMQddbygxNiQ0KqehY8ztD4kopXcKhisCbknxI6UuWectJor3Q>
    <xme:TgDZZJzgQSegD3Gpprw5CCnRyfYD6mRx8Ro3-FHo-INtbG2qoJJI4bEnoAgAvg9u-
    Gv9NzItoVgonNk>
X-ME-Received: <xmr:TgDZZJ0iCTYT7yLiZg0YO3cwG1dyX2fqmeUYbsBXhytzt9tNx-QMg_HineA1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtvddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhephefhtdejvdeiffefudduvdffgeetieeigeeugfduffdvffdtfeehieejtdfh
    jeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:TgDZZAA3nIqi_XCceIdcpx_T_N0ZjZy5Bw60sCILdbJgoAeR2vvNpQ>
    <xmx:TgDZZFgvMU6C86ogH67UpmIKLk4btoEjlMIGmuklVmMS9Wp5CTELWg>
    <xmx:TgDZZMrUgPEvdzl3gcEHhX2BZRtbMAaP_ZvB7ZhnJjy0fXRaJUuQ5Q>
    <xmx:TgDZZDb4LXabP2Wm9VZZz3pBss6rLpeao7XPj2-5TKQV7c34hKaoRg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Aug 2023 12:09:49 -0400 (EDT)
Date: Sun, 13 Aug 2023 19:09:46 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCHv5 net-next] ipv6: do not match device when remove source
 route
Message-ID: <ZNkASnjqmAVg2vBg@shredder>
References: <20230811095308.242489-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811095308.242489-1-liuhangbin@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 05:53:08PM +0800, Hangbin Liu wrote:
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 64e873f5895f..0f981cc5bed1 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -4590,11 +4590,12 @@ static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
>  	struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
>  	struct net *net = ((struct arg_dev_net_ip *)arg)->net;
>  	struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
> +	u32 tb6_id = l3mdev_fib_table(dev) ? : RT_TABLE_MAIN;
>  
> -	if (!rt->nh &&
> -	    ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
> -	    rt != net->ipv6.fib6_null_entry &&
> -	    ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
> +	if (rt != net->ipv6.fib6_null_entry &&
> +	    rt->fib6_table->tb6_id == tb6_id &&
> +	    ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr) &&
> +	    !ipv6_chk_addr(net, addr, rt->fib6_nh->fib_nh_dev, 0)) {
>  		spin_lock_bh(&rt6_exception_lock);
>  		/* remove prefsrc entry */
>  		rt->fib6_prefsrc.plen = 0;

The table check is incorrect which is what I was trying to explain here
[1]. The route insertion code does not check that the preferred source
is accessible from the VRF where the route is installed, but instead
that it is accessible from the VRF of the first nexthop device. I'm not
going to debate whether it is correct or not. I'm going to say that the
logic should be consistent between the route insertion and deletion
paths. That is, if I'm only able to insert a route with a preferred
source address because some address exists, then when this address is
removed the preferred source address should be removed from the route.

Here is an example with your patch applied:

+ ip link add name dummy1 up type dummy
+ ip link add name vrf1 up type vrf table 1111
+ ip link set dev dummy1 master vrf1
+ ip -6 route add 2001:db8:2::/64 src 2001:db8:1::1 dev dummy1
Error: Invalid source address.
+ ip address add 2001:db8:1::1/64 dev dummy1
+ ip -6 route add 2001:db8:2::/64 src 2001:db8:1::1 dev dummy1
+ ip -6 route show 2001:db8:2::/64
2001:db8:2::/64 dev dummy1 src 2001:db8:1::1 metric 1024 pref medium
+ ip address del 2001:db8:1::1/64 dev dummy1
+ ip -6 route show 2001:db8:2::/64
2001:db8:2::/64 dev dummy1 src 2001:db8:1::1 metric 1024 pref medium

Note how it is not possible to add the route to the main table because
the address does not exist, but then after the address is deleted the
route still exists with the preferred source address.

And this is the same example, but with the patch from [1]:

+ ip link add name dummy1 up type dummy
+ ip link add name vrf1 up type vrf table 1111
+ ip link set dev dummy1 master vrf1
+ ip -6 route add 2001:db8:2::/64 src 2001:db8:1::1 dev dummy1
Error: Invalid source address.
+ ip address add 2001:db8:1::1/64 dev dummy1
+ ip -6 route add 2001:db8:2::/64 src 2001:db8:1::1 dev dummy1
+ ip -6 route show 2001:db8:2::/64
2001:db8:2::/64 dev dummy1 src 2001:db8:1::1 metric 1024 pref medium
+ ip address del 2001:db8:1::1/64 dev dummy1
+ ip -6 route show 2001:db8:2::/64
2001:db8:2::/64 dev dummy1 metric 1024 pref medium

[1] https://lore.kernel.org/netdev/ZNSol%2F7x5oI6amEB@shredder/

