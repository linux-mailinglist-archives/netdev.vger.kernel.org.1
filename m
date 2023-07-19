Return-Path: <netdev+bounces-19091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEE8759A0E
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 17:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9E2281932
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1801F16416;
	Wed, 19 Jul 2023 15:41:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B14211C93
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 15:41:38 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3F72113
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 08:41:21 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 39D6A5C008F;
	Wed, 19 Jul 2023 11:41:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 19 Jul 2023 11:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1689781276; x=1689867676; bh=gCsM4hAyMCNkt
	LaiUDPjOwpaoCchPjCBcTQRqo1CNvg=; b=0b4s8Idbm3pytQc3xQOoRHsx9kE51
	7fJL3/+grovVGjo+kTPAZ4Dxt4olwqdks5f95vF4Cx6k/GDhK95DikPsub+xYAYH
	dKglvjdvkIlmCweJNTJ0GbcKPKHBz+6lDxGkKVtx0vpNxvkFhiYPSbvclh+3Yzo+
	gLZf48Oif5nC9cMIftpcl3m6jY726Dsi+kiwFrea84rRcYAQHkBrzcNlqLba+lXQ
	VbrZsqlbsuHZfPxz7K3R2S8+osWGpGCKB+HzY1/aklA7NAmOSoleXYESDyBXuCap
	+bMR/2GCQf0ops/f0qBNPiXAdy3geWR+0QhEoo/eXKHeErezMueWZ6LjA==
X-ME-Sender: <xms:HAS4ZBZXT-97ZJHPn4aVK5DsPyeXnPBEtsivzP2MdAkG1l4_LfcrzA>
    <xme:HAS4ZIb0Q9E_PYnOu3Xod5S9GhNErLGiMsUcTdcORZyyHWnqpqb0Nvrgt98Y7y6ak
    tAFWYp4i1iUlD8>
X-ME-Received: <xmr:HAS4ZD_Zh77i_Od2mCfirJ0WbkLxzuoCK-0-lY0aTQjgLNPboaaFkCU0oMCDa15XNEVSGU43cmMWbJYa5tZuxo7GWD8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeekgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:HAS4ZPqF_Vnpe1AO-8thZUP9ERiMp1yi0VfX75XYSbdGdfUC-CteBQ>
    <xmx:HAS4ZMprDKIR_NDdN5WD3GFVb1zJr6MGmZhEB8MU42VwDcoTVWzogg>
    <xmx:HAS4ZFT9PzOhpkMsFMcjTy3gYd__Zs6WXbU1bJiJQnKvSdDZvCUMWw>
    <xmx:HAS4ZBA2qS5uAfSu_xsnFRcDTI0J7NTisBJtsyDo6b49laNpi_ck2A>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jul 2023 11:41:15 -0400 (EDT)
Date: Wed, 19 Jul 2023 18:41:11 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCHv2 net] ipv6: do not match device when remove source route
Message-ID: <ZLgEF9w903kI5pHs@shredder>
References: <20230719095449.2998778-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719095449.2998778-1-liuhangbin@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 05:54:49PM +0800, Hangbin Liu wrote:
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 64e873f5895f..4f49677e24a2 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -4590,10 +4590,11 @@ static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
>  	struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
>  	struct net *net = ((struct arg_dev_net_ip *)arg)->net;
>  	struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
> +	u32 tb6_id = l3mdev_fib_table(dev) ? : RT_TABLE_MAIN;

l3mdev_fib_table() handles the case of 'dev' being NULL, so this looks
OK.

>  
>  	if (!rt->nh &&
> -	    ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&

Now that we are not checking the nexthop device, I believe we should
remove the '!rt->nh' check. With this check, the source address is not
removed from IPv6 routes that are using a nexthop object. This is in
contrast to IPv4 [1]. After removing the check, IPv4 and IPv6 are
consistent (disregarding the fundamental difference of removing the
route vs. only the source address) [2].

>  	    rt != net->ipv6.fib6_null_entry &&
> +	    rt->fib6_table->tb6_id == tb6_id &&
>  	    ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
>  		spin_lock_bh(&rt6_exception_lock);
>  		/* remove prefsrc entry */

[1]
+ ip link add name dummy1 up type dummy
+ ip link add name dummy2 up type dummy
+ ip -4 nexthop add id 1 dev dummy1
+ ip -6 nexthop add id 2 dev dummy1
+ ip address add 192.0.2.1/24 dev dummy2
+ ip address add 2001:db8:1::1/64 dev dummy2
+ ip route add 198.51.100.0/24 nhid 1 src 192.0.2.1
+ ip route add 2001:db8:10::/64 nhid 2 src 2001:db8:1::1
+ ip -4 route show 198.51.100.0/24
198.51.100.0/24 nhid 1 dev dummy1 src 192.0.2.1 
+ ip -6 route show 2001:db8:10::/64
2001:db8:10::/64 nhid 2 dev dummy1 src 2001:db8:1::1 metric 1024 pref medium
+ ip address del 192.0.2.1/24 dev dummy2
+ ip address del 2001:db8:1::1/64 dev dummy2
+ ip -4 route show 198.51.100.0/24
+ ip -6 route show 2001:db8:10::/64
2001:db8:10::/64 nhid 2 dev dummy1 src 2001:db8:1::1 metric 1024 pref medium

[2]
+ ip link add name dummy1 up type dummy
+ ip link add name dummy2 up type dummy
+ ip -4 nexthop add id 1 dev dummy1
+ ip -6 nexthop add id 2 dev dummy1
+ ip address add 192.0.2.1/24 dev dummy2
+ ip address add 2001:db8:1::1/64 dev dummy2
+ ip route add 198.51.100.0/24 nhid 1 src 192.0.2.1
+ ip route add 2001:db8:10::/64 nhid 2 src 2001:db8:1::1
+ ip -4 route show 198.51.100.0/24
198.51.100.0/24 nhid 1 dev dummy1 src 192.0.2.1 
+ ip -6 route show 2001:db8:10::/64
2001:db8:10::/64 nhid 2 dev dummy1 src 2001:db8:1::1 metric 1024 pref medium
+ ip address del 192.0.2.1/24 dev dummy2
+ ip address del 2001:db8:1::1/64 dev dummy2
+ ip -4 route show 198.51.100.0/24
+ ip -6 route show 2001:db8:10::/64
2001:db8:10::/64 nhid 2 dev dummy1 metric 1024 pref medium

