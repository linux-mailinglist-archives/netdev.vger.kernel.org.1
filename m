Return-Path: <netdev+bounces-26229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602FB7773AD
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 11:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824961C214D0
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 09:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF2E1E51E;
	Thu, 10 Aug 2023 09:06:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7F419BB3
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:06:41 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAA6211E
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 02:06:40 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 4F21C320079B;
	Thu, 10 Aug 2023 05:06:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 10 Aug 2023 05:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1691658396; x=1691744796; bh=AvXDnk+DVGqX5
	/avA+172eyrbWlmkuIbVKaeZNAFLAs=; b=BmDwkaoxFklK+zdthR0kBWea4AGkY
	073E5TywacssyvTy8SZ5O6YBIyDID5NwQbxNtPavLpAsU1pnvpEPcAQKtGTbxudw
	F1RGscQ/Tkb78CVDLiy6ZikbCnP4V9HrMGDMxNCDJ5vgs/1/f8mWkkvTS5lP+cMq
	z0Avf1EKFHIyshdC7aGHLoPjj3pqxnzFaciFyYr1ONuKfsigBTTN7MOg7nOxhJ61
	Y5YvpxW0jrt2FlQaMbQ4mNubGJsuuzjAIh8Bczh5k2MIrm3DqbswcIVzEuxR1dO1
	J7Qo2emllKvBdx7GG+q0RyvchqtuF1orqD4vSQIFKsHXkQUf0JVnSozJA==
X-ME-Sender: <xms:nKjUZAARtMfyApUCIZsxKIFdIjPg_OtJF0psD1dgmKatKgQDjytlvA>
    <xme:nKjUZChZ58KyYfDwgCLa9hRN-es8bPowXVmxWulYOxoSV3NY2wHBK4_gwWfAj3CpJ
    l77QZJVCKsQPGg>
X-ME-Received: <xmr:nKjUZDk-264G-mJQfKbi8agq_juCrMiL3WZ_sL-A9XTVJxqxL1frXTgEZiZLWSIe5skKlDwsPv50xetvoMwCSLaNuZaHow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleeigdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeehtdejffeghffgkeffuedvueefheeklefgjefhudelueefveehfffgvdduudfg
    geenucffohhmrghinhepihhfphdrnhgvthenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:nKjUZGwgsHwRKf8IW7UxzptdgQ30KTxfW9IaBuqHxHqBLI70BKPdAg>
    <xmx:nKjUZFSa8htLgQc68l2C9Fqyq93B6cMLzxbTar7L2HysJKyq3yv4qQ>
    <xmx:nKjUZBbKSXsHGnpefPBg-EcPHVi6qthl2SJ4HbnRFXdIksQRGKCcKw>
    <xmx:nKjUZOJlRakVi4ZyNWwTUUtYN5DA42xU1Ljx6JwLZ0VLZKOQuS-TZQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Aug 2023 05:06:35 -0400 (EDT)
Date: Thu, 10 Aug 2023 12:06:31 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCHv4 net] ipv6: do not match device when remove source route
Message-ID: <ZNSol/7x5oI6amEB@shredder>
References: <20230725102137.299305-1-liuhangbin@gmail.com>
 <ZMjx2D3AD81hvDGp@shredder>
 <ZMsp7A4yvyVUCu+o@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMsp7A4yvyVUCu+o@Laptop-X1>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 03, 2023 at 12:15:40PM +0800, Hangbin Liu wrote:
> On Tue, Aug 01, 2023 at 02:51:52PM +0300, Ido Schimmel wrote:
> > On Tue, Jul 25, 2023 at 06:21:37PM +0800, Hangbin Liu wrote:
> > > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > > index 64e873f5895f..44e980109e30 100644
> > > --- a/net/ipv6/route.c
> > > +++ b/net/ipv6/route.c
> > > @@ -4590,10 +4590,10 @@ static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
> > >  	struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
> > >  	struct net *net = ((struct arg_dev_net_ip *)arg)->net;
> > >  	struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
> > > +	u32 tb6_id = l3mdev_fib_table(dev) ? : RT_TABLE_MAIN;
> > >  
> > > -	if (!rt->nh &&
> > > -	    ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
> > > -	    rt != net->ipv6.fib6_null_entry &&
> > > +	if (rt != net->ipv6.fib6_null_entry &&
> > > +	    rt->fib6_table->tb6_id == tb6_id &&
> > >  	    ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
> > >  		spin_lock_bh(&rt6_exception_lock);
> > >  		/* remove prefsrc entry */
> > > @@ -4611,7 +4611,9 @@ void rt6_remove_prefsrc(struct inet6_ifaddr *ifp)
> > >  		.net = net,
> > >  		.addr = &ifp->addr,
> > >  	};
> > > -	fib6_clean_all(net, fib6_remove_prefsrc, &adni);
> > > +
> > > +	if (!ipv6_chk_addr_and_flags(net, adni.addr, adni.dev, true, 0, IFA_F_TENTATIVE))
> > 
> > Setting 'skip_dev_check' to true is problematic since when a link-local
> > address is deleted from a device, it should be removed as the preferred
> > source address from routes using the device as their nexthop device,
> > even if this address is configured on other devices.
> > 
> > You can't configure a route with a link-local preferred source address
> > if the address is not configured on the nexthop device:
> 
> Thanks for letting me know another case I'm not aware...
> 
> > Setting 'skip_dev_check' to false will solve this problem:
> >
> > But will create another problem where when such an address is deleted it
> > also affects routes that shouldn't be affected:
> > 
> > So, I think we need to call ipv6_chk_addr() from rt6_remove_prefsrc() to
> > be consistent with the addition path in ip6_route_info_create():
> > 
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index 56a55585eb79..e7e2187bff0c 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -4591,11 +4591,13 @@ static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
> >         struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
> >         struct net *net = ((struct arg_dev_net_ip *)arg)->net;
> >         struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
> > +       u32 tb6_id = l3mdev_fib_table(dev) ? : RT_TABLE_MAIN;
> >  
> >         if (!rt->nh &&
> > -           ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
> >             rt != net->ipv6.fib6_null_entry &&
> > -           ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
> > +           rt->fib6_table->tb6_id == tb6_id &&
> > +           ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr) &&
> > +           !ipv6_chk_addr(net, addr, rt->fib6_nh->fib_nh_dev, 0)) {
> >                 spin_lock_bh(&rt6_exception_lock);
> >                 /* remove prefsrc entry */
> >                 rt->fib6_prefsrc.plen = 0;
> > 
> > ipv6_chk_addr() is not cheap, but it's only called for routes that match
> > the previous criteria.
> > 
> > With the above patch, the previous test cases now work as expected:
> > 
> > There is however one failure in the selftest:
> >
> > Which is basically:
> > 
> > # ip link add name dummy1 up type dummy
> > # ip link add name dummy2 up type dummy
> > # ip link add red type vrf table 1111
> > # ip link set dev red up
> > # ip link set dummy2 vrf red
> > # ip -6 address add dev dummy1 2001:db8:104::12/64
> > # ip -6 address add dev dummy2 2001:db8:104::12/64
> > # ip -6 route add 2001:db8:106::/64 dev lo src 2001:db8:104::12
> > # ip -6 route add vrf red 2001:db8:106::/64 dev lo src 2001:db8:104::12
> > # ip -6 address del dev dummy2 2001:db8:104::12/64
> > # ip -6 route show vrf red | grep "src 2001:db8:104::12"
> > 2001:db8:106::/64 dev lo src 2001:db8:104::12 metric 1024 pref medium
> > 
> > I'm not sure it's realistic to expect the source address to be removed
> > when the address is deleted from dummy2, given that user space was only
> > able to configure the route because the address was available on dummy1
> > in the default vrf:
> > 
> > # ip link add name dummy1 up type dummy
> > # ip link add name dummy2 up type dummy
> > # ip link add red type vrf table 1111
> > # ip link set dev red up
> > # ip link set dummy2 vrf red
> > # ip -6 address add dev dummy2 2001:db8:104::12/64
> > # ip -6 route add vrf red 2001:db8:106::/64 dev lo src 2001:db8:104::12
> > Error: Invalid source address.
> 
> OK.. Another difference with IPv4, which could add this route directly. e.g.
> 
> ip addr add dev dummy2 172.16.104.13/24
> ip route add vrf red 172.16.107.0/24 dev lo src 172.16.104.13

There is a fundamental difference between how the preferred source
address is implemented for IPv4 compared to IPv6. In IPv4, the local
route for the preferred source address is looked up in the table where
the route is installed and there is a fallback to the local table in
case the route was not installed in the main table. See
fib_valid_prefsrc() and commit e1b8d903c6c3 ("net: Fix prefsrc
lookups").

In IPv6, the preferred source address is looked up in the same VRF as
the first nexthop device. This will give you similar results to IPv4 if
the route is installed in the same VRF as the nexthop device, but not
when the nexthop device is enslaved to a different VRF. Personally, I
find this behavior weird because at least as far as user space is
concerned, the preferred source address is an attribute of the route,
not the nexthop. This is probably rooted in historical reasons such as
the fact that this feature was implemented in IPv6 before multipath
routes and VRFs.

Anyway, the objective of the patch is not to align IPv4 and IPv6 (I'm
not sure it's possible / worth the effort), but to align the logic for
the preferred source address between addition and deletion. That is, if
a global address is deleted from a device, then it should be removed
from all the relevant routes, not only those using the device as their
nexthop device.

I tested [1] the following patch [2] and it seems to work.

[1]
+ ip link add name dummy1 up type dummy
+ ip link add name dummy2 up type dummy
+ ip link add name dummy3 up type dummy
+ ip link add name red up type vrf table 1111
+ ip link set dev dummy3 master red
+ ip address add 2001:db8:1::1/64 dev dummy1
+ ip address add 2001:db8:1::1/64 dev dummy3
+ ip route add 2001:db8:2::/64 dev dummy2 src 2001:db8:1::1
+ ip -6 route show 2001:db8:2::/64 dev dummy2
2001:db8:2::/64 src 2001:db8:1::1 metric 1024 pref medium
+ ip address del 2001:db8:1::1/64 dev dummy3
+ ip -6 route show 2001:db8:2::/64 dev dummy2
2001:db8:2::/64 src 2001:db8:1::1 metric 1024 pref medium
+ ip address del 2001:db8:1::1/64 dev dummy1
+ ip -6 route show 2001:db8:2::/64 dev dummy2
2001:db8:2::/64 metric 1024 pref medium
+ ip address add fe80::1/128 dev dummy1
+ ip address add fe80::1/128 dev dummy2
+ ip route add 2001:db8:3::/64 dev dummy2 src fe80::1
+ ip -6 route show 2001:db8:3::/64
2001:db8:3::/64 dev dummy2 src fe80::1 metric 1024 pref medium
+ ip address del fe80::1/128 dev dummy1
+ ip -6 route show 2001:db8:3::/64
2001:db8:3::/64 dev dummy2 src fe80::1 metric 1024 pref medium
+ ip address del fe80::1/128 dev dummy2
+ ip -6 route show 2001:db8:3::/64
2001:db8:3::/64 dev dummy2 metric 1024 pref medium

[2]
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 10751df16dab..3e1c76c7bdd3 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4582,21 +4582,19 @@ struct fib6_info *addrconf_f6i_alloc(struct net *net,
 
 /* remove deleted ip from prefsrc entries */
 struct arg_dev_net_ip {
-       struct net_device *dev;
        struct net *net;
        struct in6_addr *addr;
 };
 
 static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
 {
-       struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
        struct net *net = ((struct arg_dev_net_ip *)arg)->net;
        struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
 
        if (!rt->nh &&
-           ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
            rt != net->ipv6.fib6_null_entry &&
-           ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
+           ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr) &&
+           !ipv6_chk_addr(net, addr, rt->fib6_nh->fib_nh_dev, 0)) {
                spin_lock_bh(&rt6_exception_lock);
                /* remove prefsrc entry */
                rt->fib6_prefsrc.plen = 0;
@@ -4609,7 +4607,6 @@ void rt6_remove_prefsrc(struct inet6_ifaddr *ifp)
 {
        struct net *net = dev_net(ifp->idev->dev);
        struct arg_dev_net_ip adni = {
-               .dev = ifp->idev->dev,
                .net = net,
                .addr = &ifp->addr,
        };

