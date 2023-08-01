Return-Path: <netdev+bounces-23183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A356876B3D3
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A071C20DFB
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37612214E6;
	Tue,  1 Aug 2023 11:52:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2650E20FA4
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:52:00 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697E010E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:51:59 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 458DD32008FF;
	Tue,  1 Aug 2023 07:51:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 01 Aug 2023 07:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690890717; x=1690977117; bh=E9dPXfJNwBN/G
	OFLkeKRXNkxQgjZ1Xh6cb33eVeM9Og=; b=urRyw1OdSpZAj/SheKj+BM4X8GeqD
	knpqbOQ6Hbxe3sw40zf9Jggj3NmWiFSZjx0QWlUG2sw8Mj3caPXwSFszRkQRH8iD
	zNIptO1eeh4p5pFNvl+IDuOvuuDD3z30gENTfb9aKv0NFpESDU3Aq26lFk4GQgu/
	ymsnWLVOgiNNUeBKseUCcmOTw0O/7Nlr3KXcye7vk40exZig/r4AYc44i3WL4s1Y
	qPITrCq0DnW7cxQK/k5441H0tnI3OZ8fWgQ5Jc8uvyyCbVyQ0OOGFDXBOUO7twdf
	IxcT+Ze64yhkD1skCsp+5UxzGebuWjHbORePMB+04tsVuS6gkt4xKfOBw==
X-ME-Sender: <xms:3fHIZGT34rJMqOmwkmsFUwsdNiHCGAcYApeeS4wm94oAnfZm1B7nsA>
    <xme:3fHIZLxJDSXIUyY9P4tqkFTnfLuJUwU6cIhxwb9urnkrz5G6NHGpjczZ8MP0vXQJk
    W6Kp1AUzLmJvVM>
X-ME-Received: <xmr:3fHIZD2ll685052i85CRlKt8HwEeIJg1ALgPr-EknoQKLm_Jln9iTQFERtOqROd9oid7XYXWz0pfO4UPdquPhDjre9U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeigdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeehtdejffeghffgkeffuedvueefheeklefgjefhudelueefveehfffgvdduudfg
    geenucffohhmrghinhepihhfphdrnhgvthenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:3fHIZCCVJYE-07bNT-I7n4FSDdMhxwpDeQuDRunSg0pazyDjSCoxCA>
    <xmx:3fHIZPgCvzan3HuH78_7Ozikv2aTLASKu1fPW-sCeAm35hbX2EQm9w>
    <xmx:3fHIZOqvhTlHunlXd9TZ0zicZgMFE_DGyP6c4IkmOvBJC0YMGwWPOA>
    <xmx:3fHIZFb88tnBlUoLm4zlvJrwWr7zaege8ulsiVfLzYSFcIxPZ58Lvw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Aug 2023 07:51:56 -0400 (EDT)
Date: Tue, 1 Aug 2023 14:51:52 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCHv4 net] ipv6: do not match device when remove source route
Message-ID: <ZMjx2D3AD81hvDGp@shredder>
References: <20230725102137.299305-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725102137.299305-1-liuhangbin@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 06:21:37PM +0800, Hangbin Liu wrote:
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 64e873f5895f..44e980109e30 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -4590,10 +4590,10 @@ static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
>  	struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
>  	struct net *net = ((struct arg_dev_net_ip *)arg)->net;
>  	struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
> +	u32 tb6_id = l3mdev_fib_table(dev) ? : RT_TABLE_MAIN;
>  
> -	if (!rt->nh &&
> -	    ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
> -	    rt != net->ipv6.fib6_null_entry &&
> +	if (rt != net->ipv6.fib6_null_entry &&
> +	    rt->fib6_table->tb6_id == tb6_id &&
>  	    ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
>  		spin_lock_bh(&rt6_exception_lock);
>  		/* remove prefsrc entry */
> @@ -4611,7 +4611,9 @@ void rt6_remove_prefsrc(struct inet6_ifaddr *ifp)
>  		.net = net,
>  		.addr = &ifp->addr,
>  	};
> -	fib6_clean_all(net, fib6_remove_prefsrc, &adni);
> +
> +	if (!ipv6_chk_addr_and_flags(net, adni.addr, adni.dev, true, 0, IFA_F_TENTATIVE))

Setting 'skip_dev_check' to true is problematic since when a link-local
address is deleted from a device, it should be removed as the preferred
source address from routes using the device as their nexthop device,
even if this address is configured on other devices.

You can't configure a route with a link-local preferred source address
if the address is not configured on the nexthop device:

# ip link add name dummy1 up type dummy
# ip link add name dummy2 up type dummy
# ip -6 address add fe80::1/128 dev dummy1
# ip -6 route add 2001:db8:1::/64 dev dummy2 src fe80::1
Error: Invalid source address.
# ip -6 address add fe80::1/128 dev dummy2
# ip -6 route add 2001:db8:1::/64 dev dummy2 src fe80::1
# ip -6 route show 2001:db8:1::/64
2001:db8:1::/64 dev dummy2 src fe80::1 metric 1024 pref medium

But if I now delete the address from dummy2, the preferred source
address still exists:

# ip -6 address del fe80::1/128 dev dummy2
# ip -6 route show 2001:db8:1::/64
2001:db8:1::/64 dev dummy2 src fe80::1 metric 1024 pref medium

Setting 'skip_dev_check' to false will solve this problem:

# ip link add name dummy1 up type dummy
# ip link add name dummy2 up type dummy
# ip -6 address add fe80::1/128 dev dummy1
# ip -6 address add fe80::1/128 dev dummy2
# ip -6 route add 2001:db8:1::/64 dev dummy2 src fe80::1
# ip -6 route show 2001:db8:1::/64
2001:db8:1::/64 dev dummy2 src fe80::1 metric 1024 pref medium
# ip -6 address del fe80::1/128 dev dummy2
# ip -6 route show 2001:db8:1::/64
2001:db8:1::/64 dev dummy2 metric 1024 pref medium

But will create another problem where when such an address is deleted it
also affects routes that shouldn't be affected:

# ip link add name dummy1 up type dummy
# ip link add name dummy2 up type dummy
# ip -6 address add fe80::1/128 dev dummy1
# ip -6 address add fe80::1/128 dev dummy2
# ip -6 route add 2001:db8:1::/64 dev dummy1 src fe80::1
# ip -6 route add 2001:db8:2::/64 dev dummy2 src fe80::1
# ip -6 route show 2001:db8:1::/64
2001:db8:1::/64 dev dummy1 src fe80::1 metric 1024 pref medium
# ip -6 route show 2001:db8:2::/64
2001:db8:2::/64 dev dummy2 src fe80::1 metric 1024 pref medium
# ip -6 address del fe80::1/128 dev dummy2
# ip -6 route show 2001:db8:1::/64
2001:db8:1::/64 dev dummy1 metric 1024 pref medium
# ip -6 route show 2001:db8:2::/64
2001:db8:2::/64 dev dummy2 metric 1024 pref medium

So, I think we need to call ipv6_chk_addr() from rt6_remove_prefsrc() to
be consistent with the addition path in ip6_route_info_create():

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 56a55585eb79..e7e2187bff0c 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4591,11 +4591,13 @@ static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
        struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
        struct net *net = ((struct arg_dev_net_ip *)arg)->net;
        struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
+       u32 tb6_id = l3mdev_fib_table(dev) ? : RT_TABLE_MAIN;
 
        if (!rt->nh &&
-           ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
            rt != net->ipv6.fib6_null_entry &&
-           ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
+           rt->fib6_table->tb6_id == tb6_id &&
+           ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr) &&
+           !ipv6_chk_addr(net, addr, rt->fib6_nh->fib_nh_dev, 0)) {
                spin_lock_bh(&rt6_exception_lock);
                /* remove prefsrc entry */
                rt->fib6_prefsrc.plen = 0;

ipv6_chk_addr() is not cheap, but it's only called for routes that match
the previous criteria.

With the above patch, the previous test cases now work as expected:

# ip link add name dummy1 up type dummy
# ip link add name dummy2 up type dummy
# ip -6 address add fe80::1/128 dev dummy1
# ip -6 address add fe80::1/128 dev dummy2
# ip -6 route add 2001:db8:1::/64 dev dummy2 src fe80::1
# ip -6 route show 2001:db8:1::/64
2001:db8:1::/64 dev dummy2 src fe80::1 metric 1024 pref medium
# ip -6 address del fe80::1/128 dev dummy2
# ip -6 route show 2001:db8:1::/64
2001:db8:1::/64 dev dummy2 metric 1024 pref medium

# ip link add name dummy1 up type dummy
# ip link add name dummy2 up type dummy
# ip -6 address add fe80::1/128 dev dummy1
# ip -6 address add fe80::1/128 dev dummy2
# ip -6 route add 2001:db8:1::/64 dev dummy1 src fe80::1
# ip -6 route add 2001:db8:2::/64 dev dummy2 src fe80::1
# ip -6 route show 2001:db8:1::/64
2001:db8:1::/64 dev dummy1 src fe80::1 metric 1024 pref medium
# ip -6 route show 2001:db8:2::/64
2001:db8:2::/64 dev dummy2 src fe80::1 metric 1024 pref medium
# ip -6 address del fe80::1/128 dev dummy2
# ip -6 route show 2001:db8:1::/64
2001:db8:1::/64 dev dummy1 src fe80::1 metric 1024 pref medium
# ip -6 route show 2001:db8:2::/64
2001:db8:2::/64 dev dummy2 metric 1024 pref medium

There is however one failure in the selftest:

# ./fib_tests.sh -t ipv6_del_addr

IPv6 delete address route tests
    Regular FIB info
    TEST: Prefsrc removed from VRF when source address deleted          [ OK ]
    TEST: Prefsrc in default VRF not removed                            [ OK ]
    TEST: Prefsrc removed in default VRF when source address deleted    [ OK ]
    TEST: Prefsrc in VRF is not removed by address delete               [ OK ]
    Identical FIB info with different table ID
    TEST: Prefsrc removed from VRF when source address deleted          [FAIL]
    TEST: Prefsrc in default VRF not removed                            [ OK ]
    TEST: Prefsrc removed in default VRF when source address deleted    [ OK ]
    TEST: Prefsrc in VRF is not removed by address delete               [ OK ]
    Table ID 0
    TEST: Prefsrc removed in default VRF when source address deleted    [ OK ]
    Identical address on different devices
    TEST: Prefsrc not removed when src address exists on other device   [ OK ]

Tests passed:   9
Tests failed:   1

Which is basically:

# ip link add name dummy1 up type dummy
# ip link add name dummy2 up type dummy
# ip link add red type vrf table 1111
# ip link set dev red up
# ip link set dummy2 vrf red
# ip -6 address add dev dummy1 2001:db8:104::12/64
# ip -6 address add dev dummy2 2001:db8:104::12/64
# ip -6 route add 2001:db8:106::/64 dev lo src 2001:db8:104::12
# ip -6 route add vrf red 2001:db8:106::/64 dev lo src 2001:db8:104::12
# ip -6 address del dev dummy2 2001:db8:104::12/64
# ip -6 route show vrf red | grep "src 2001:db8:104::12"
2001:db8:106::/64 dev lo src 2001:db8:104::12 metric 1024 pref medium

I'm not sure it's realistic to expect the source address to be removed
when the address is deleted from dummy2, given that user space was only
able to configure the route because the address was available on dummy1
in the default vrf:

# ip link add name dummy1 up type dummy
# ip link add name dummy2 up type dummy
# ip link add red type vrf table 1111
# ip link set dev red up
# ip link set dummy2 vrf red
# ip -6 address add dev dummy2 2001:db8:104::12/64
# ip -6 route add vrf red 2001:db8:106::/64 dev lo src 2001:db8:104::12
Error: Invalid source address.

Anyway, given that this patch does not fix a regression and the on-going
discussion around the semantics, I suggest to target future versions at
net-next.

