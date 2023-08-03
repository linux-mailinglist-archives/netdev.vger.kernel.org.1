Return-Path: <netdev+bounces-23882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B6876DF52
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 06:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3116F1C21413
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DCA8F4B;
	Thu,  3 Aug 2023 04:15:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50AA6FBE
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:15:48 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ED22D69
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 21:15:47 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc3bec2c95so4463845ad.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 21:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691036146; x=1691640946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B/QIWAddCb5gR+NP8XwRdlxY75JXbjYGDX+PWsEvAvs=;
        b=HaAZT6C1NMqLI0Rm79cx6vWsIcns6TkwWKoTXZWgbJRJQFxvQHFJcLe2pikOqLwXjd
         oITtN74qUgXQH4HH2kqsedYF2AQcPodXBIQBr6n9bWyXzMuRfM+E4ngF5YQIwCjd8KJN
         q17MMilbnjQGyQvJO41WX/XO+ljwV4GrMhEKRKLRnXJ0m7rHvRmKSdVuY/aeYySOlNKA
         ij8V6d8RWuaFiSoJ3KLHxyp+uwwNH435QV8Ob+NpOETL9MIC6qSLOpaYJGDr/s2GzKOu
         ObE19NG0FYJQo/3WPdykxm2TPUEncx0rGYcVVJ0o0L5LC2w1Nq2SuByCVvwdIlVcWB+Q
         YhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691036146; x=1691640946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/QIWAddCb5gR+NP8XwRdlxY75JXbjYGDX+PWsEvAvs=;
        b=KA1QypdgpB5+FrQ66RqnQgQiK1z5cl7He2SrjrQEqofTf8ZMr+O1kej38icN5XIbUL
         6Qg/5dSkqf4EaW0jvlaEfoSy8r80WwTRNEfz6oU72wTf/eRE4M0LZSaTXrFyEUwV5Nhj
         3XVnBpikDbZCGkfb5b2vdufAkeP82AeUhkcyZKyUAYQDm7fAgjSbHfzAY430j8U7BRW8
         /jREPUlfxVWvd/4pmBPJa5S9J33mp6hWg3jZfPQv0sjE6tVIR0txkeRVt7BTw+G1qeS3
         4OWQlL11vlP1UurmpUYFuAu8+7nT/B+73qlKbyZeR5dqzIXAIRmLBarIDQPHy1IlAiWa
         CRQg==
X-Gm-Message-State: ABy/qLZkSC3O/ZqCedadLwAAG6OTAriCCAUCwek+knSNUZx1iVy5ol2p
	OO4KOttvJNflm2uU8ZUk4sM=
X-Google-Smtp-Source: APBJJlGV13PS9JZtygrPzlvio9OgT001yanjIzPrs9+fEJgLLniDTqdaWa7MnGSv5/kUCSdN4dZwCA==
X-Received: by 2002:a17:903:32cf:b0:1b9:d38d:efb1 with SMTP id i15-20020a17090332cf00b001b9d38defb1mr22515215plr.8.1691036146245;
        Wed, 02 Aug 2023 21:15:46 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id m8-20020a170902bb8800b001b8a3dd5a4asm13202518pls.283.2023.08.02.21.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 21:15:44 -0700 (PDT)
Date: Thu, 3 Aug 2023 12:15:40 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCHv4 net] ipv6: do not match device when remove source route
Message-ID: <ZMsp7A4yvyVUCu+o@Laptop-X1>
References: <20230725102137.299305-1-liuhangbin@gmail.com>
 <ZMjx2D3AD81hvDGp@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMjx2D3AD81hvDGp@shredder>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 02:51:52PM +0300, Ido Schimmel wrote:
> On Tue, Jul 25, 2023 at 06:21:37PM +0800, Hangbin Liu wrote:
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index 64e873f5895f..44e980109e30 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -4590,10 +4590,10 @@ static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
> >  	struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
> >  	struct net *net = ((struct arg_dev_net_ip *)arg)->net;
> >  	struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
> > +	u32 tb6_id = l3mdev_fib_table(dev) ? : RT_TABLE_MAIN;
> >  
> > -	if (!rt->nh &&
> > -	    ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
> > -	    rt != net->ipv6.fib6_null_entry &&
> > +	if (rt != net->ipv6.fib6_null_entry &&
> > +	    rt->fib6_table->tb6_id == tb6_id &&
> >  	    ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
> >  		spin_lock_bh(&rt6_exception_lock);
> >  		/* remove prefsrc entry */
> > @@ -4611,7 +4611,9 @@ void rt6_remove_prefsrc(struct inet6_ifaddr *ifp)
> >  		.net = net,
> >  		.addr = &ifp->addr,
> >  	};
> > -	fib6_clean_all(net, fib6_remove_prefsrc, &adni);
> > +
> > +	if (!ipv6_chk_addr_and_flags(net, adni.addr, adni.dev, true, 0, IFA_F_TENTATIVE))
> 
> Setting 'skip_dev_check' to true is problematic since when a link-local
> address is deleted from a device, it should be removed as the preferred
> source address from routes using the device as their nexthop device,
> even if this address is configured on other devices.
> 
> You can't configure a route with a link-local preferred source address
> if the address is not configured on the nexthop device:

Thanks for letting me know another case I'm not aware...

> Setting 'skip_dev_check' to false will solve this problem:
>
> But will create another problem where when such an address is deleted it
> also affects routes that shouldn't be affected:
> 
> So, I think we need to call ipv6_chk_addr() from rt6_remove_prefsrc() to
> be consistent with the addition path in ip6_route_info_create():
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 56a55585eb79..e7e2187bff0c 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -4591,11 +4591,13 @@ static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
>         struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
>         struct net *net = ((struct arg_dev_net_ip *)arg)->net;
>         struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
> +       u32 tb6_id = l3mdev_fib_table(dev) ? : RT_TABLE_MAIN;
>  
>         if (!rt->nh &&
> -           ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
>             rt != net->ipv6.fib6_null_entry &&
> -           ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
> +           rt->fib6_table->tb6_id == tb6_id &&
> +           ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr) &&
> +           !ipv6_chk_addr(net, addr, rt->fib6_nh->fib_nh_dev, 0)) {
>                 spin_lock_bh(&rt6_exception_lock);
>                 /* remove prefsrc entry */
>                 rt->fib6_prefsrc.plen = 0;
> 
> ipv6_chk_addr() is not cheap, but it's only called for routes that match
> the previous criteria.
> 
> With the above patch, the previous test cases now work as expected:
> 
> There is however one failure in the selftest:
>
> Which is basically:
> 
> # ip link add name dummy1 up type dummy
> # ip link add name dummy2 up type dummy
> # ip link add red type vrf table 1111
> # ip link set dev red up
> # ip link set dummy2 vrf red
> # ip -6 address add dev dummy1 2001:db8:104::12/64
> # ip -6 address add dev dummy2 2001:db8:104::12/64
> # ip -6 route add 2001:db8:106::/64 dev lo src 2001:db8:104::12
> # ip -6 route add vrf red 2001:db8:106::/64 dev lo src 2001:db8:104::12
> # ip -6 address del dev dummy2 2001:db8:104::12/64
> # ip -6 route show vrf red | grep "src 2001:db8:104::12"
> 2001:db8:106::/64 dev lo src 2001:db8:104::12 metric 1024 pref medium
> 
> I'm not sure it's realistic to expect the source address to be removed
> when the address is deleted from dummy2, given that user space was only
> able to configure the route because the address was available on dummy1
> in the default vrf:
> 
> # ip link add name dummy1 up type dummy
> # ip link add name dummy2 up type dummy
> # ip link add red type vrf table 1111
> # ip link set dev red up
> # ip link set dummy2 vrf red
> # ip -6 address add dev dummy2 2001:db8:104::12/64
> # ip -6 route add vrf red 2001:db8:106::/64 dev lo src 2001:db8:104::12
> Error: Invalid source address.

OK.. Another difference with IPv4, which could add this route directly. e.g.

ip addr add dev dummy2 172.16.104.13/24
ip route add vrf red 172.16.107.0/24 dev lo src 172.16.104.13

For the IPv6 part, if we remove dummy1 addr, should we remove the src route
in vrf since user only able to config the route when the addr available on
dummy1? My current patch, and with yours, will keep the src route in vrf..

+ ip link add name dummy1 up type dummy
+ ip link add name dummy2 up type dummy
+ ip link add red type vrf table 1111
+ ip link set dev red up
+ ip link set dummy2 vrf red
+ ip -6 address add dev dummy1 2001:db8:104::12/64
+ ip -6 address add dev dummy2 2001:db8:104::12/64
+ ip -6 route add 2001:db8:106::/64 dev lo src 2001:db8:104::12
+ ip -6 route add vrf red 2001:db8:106::/64 dev lo src 2001:db8:104::12
+ ip -6 address del dev dummy1 2001:db8:104::12/64
+ ip -6 route show vrf red
2001:db8:104::/64 dev dummy2 proto kernel metric 256 pref medium
2001:db8:106::/64 dev lo src 2001:db8:104::12 metric 1024 pref medium
fe80::/64 dev dummy2 proto kernel metric 256 pref medium
multicast ff00::/8 dev dummy2 proto kernel metric 256 pref medium
+ ip -6 route show
::1 dev lo proto kernel metric 256 pref medium
2001:db8:106::/64 dev lo metric 1024 pref medium

> 
> Anyway, given that this patch does not fix a regression and the on-going
> discussion around the semantics, I suggest to target future versions at
> net-next.

OK, I will.

Thanks
Hangbin

