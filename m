Return-Path: <netdev+bounces-18863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997AB758ECD
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02565280933
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 07:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE10BE6A;
	Wed, 19 Jul 2023 07:22:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C0C2EF
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:22:11 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C2A2119
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:21:52 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666e97fcc60so4335900b3a.3
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689751309; x=1692343309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=14ngGs8TOlk69v8k5g626/qSpdvUVY2EAr1Pk9d1WI4=;
        b=MPGr4AwhvL5GKgaUqSz7RMABUMhEWbqGeP4+lgEVSFgTpboI/BeRtvMLeDUxJxJPma
         H9oyo1eF/V0r9UYzJ3kUoOKiQqjT2IC2jV2E4bfBhHxXUOfYaoJA06rPm9zbvoz87t7G
         0C3EWWLSIgtKYNr15s+qc1cnah6bWkUIk2+pJ+q2hT2uZxHVCkzJYppELdVFIshS/q/+
         +EvgWdrjmuRYhiqmyc3YjIGcT4dDwqcrMSs7o0FQatGCgniZmAdeH6q0meLS9xp7sq9+
         5NUFp9XV6sSxrLFE7Vn+3+4dMOUPdXWPGacIWl1IrcDQ0/n8vSspuDLDayF0c/5xWJnd
         35Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689751309; x=1692343309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14ngGs8TOlk69v8k5g626/qSpdvUVY2EAr1Pk9d1WI4=;
        b=eJIdGFKLVzwdv5BDe97ajSphf4IN9kkhjeDwuaOhATf+cbJ0a41nyhf3dcZR4ycsiu
         +myN46UUotktGMcBp8PpmD+4QS5uCSwQREzPRefGyfYrb87zQvzNOof9A9VrfcQjht0N
         BQNF9WS9KLa7b3++xoKf8szbCnPss4P4eBFkEyj6kYqsBtJWb2HG5NU7G9p3rYPSCYpC
         FZpOTVuzilUR6Ib6Is5JeNhULDAY++pk/ypGcPq5Vaw62Dz5gQtYqYHxsqSsF8zZst5p
         sswOfUbBzwRATXQAJ4Hc7MrOy0ZbVr22Ho618P/ktFicaBRsd6F7hBQBb/aRl2faRm6a
         fwHw==
X-Gm-Message-State: ABy/qLarhs2zkTHGcT7Z8v2FIzMjnmvvixGDnFtz3GXKDk6ulaAYzSWC
	O9/GpY4qiWYEqMQj1nq62wxcJILAhJZImgs/
X-Google-Smtp-Source: APBJJlHEXomuy+N71JRrM1UIDJUfxyB9zrQjWuU6kTTXruj04bg9c8DweSyer1fx+v5qyeaOxTmdKw==
X-Received: by 2002:a05:6a20:12c2:b0:134:a8a1:3bf with SMTP id v2-20020a056a2012c200b00134a8a103bfmr1658779pzg.30.1689751308600;
        Wed, 19 Jul 2023 00:21:48 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id fm10-20020a056a002f8a00b0067526282193sm2575439pfb.157.2023.07.19.00.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 00:21:47 -0700 (PDT)
Date: Wed, 19 Jul 2023 15:21:43 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net] ipv6: do not match device when remove source route
Message-ID: <ZLePByChs5ZNtplQ@Laptop-X1>
References: <20230718065253.2730396-1-liuhangbin@gmail.com>
 <ZLZ6ipKWo1dSW8Xc@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLZ6ipKWo1dSW8Xc@shredder>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 02:42:02PM +0300, Ido Schimmel wrote:
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index 64e873f5895f..ab8c364e323c 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -4607,7 +4607,6 @@ void rt6_remove_prefsrc(struct inet6_ifaddr *ifp)
> >  {
> >  	struct net *net = dev_net(ifp->idev->dev);
> >  	struct arg_dev_net_ip adni = {
> > -		.dev = ifp->idev->dev,
> 
> Wouldn't this affect routes in different VRFs?
> 
> See commit 5a56a0b3a45d ("net: Don't delete routes in different VRFs")
> and related fixes:

Thanks for this notify. I saw this is for IPv4 only and there is no IPv6 version.
I can try add an IPv6 version patch for this issue. The fib_tb_id is based
on table id. So in same table we still need to not check the device and remove
all source routes.
 
> 8a2618e14f81 ipv4: Fix incorrect table ID in IOCTL path
> c0d999348e01 ipv4: Fix incorrect route flushing when table ID 0 is used
> f96a3d74554d ipv4: Fix incorrect route flushing when source address is deleted
> e0a312629fef ipv4: Fix table id reference in fib_sync_down_addr
> 
> Anyway, please add tests to tools/testing/selftests/net/fib_tests.sh

The fib_tests.sh result looks good as my patch affects IPv6 only.

# ./fib_tests.sh

Single path route test
    Start point
    TEST: IPv4 fibmatch                                                 [ OK ]
    TEST: IPv6 fibmatch                                                 [ OK ]
    Nexthop device deleted
    TEST: IPv4 fibmatch - no route                                      [ OK ]
    TEST: IPv6 fibmatch - no route                                      [ OK ]

[...]

IPv4 broadcast neighbour tests
    TEST: Resolved neighbour for broadcast address                      [ OK ]
    TEST: Resolved neighbour for network broadcast address              [ OK ]
    TEST: Unresolved neighbour for broadcast address                    [ OK ]
    TEST: Unresolved neighbour for network broadcast address            [ OK ]

Tests passed: 203
Tests failed:   0

BTW, It's a bit different for IPv4 and IPv6. IPv4 will remove the total
source routes, while IPv6 only remove the source address and keep the route.
e.g.

IPv4:
+ ip -netns x addr add 192.168.5.5/24 dev net1
+ ip -netns x route add 7.7.7.0/24 dev net2 src 192.168.5.5
+ ip -netns x -4 route
7.7.7.0/24 dev net2 scope link src 192.168.5.5 
192.168.5.0/24 dev net1 proto kernel scope link src 192.168.5.5 
+ ip -netns x addr del 192.168.5.5/24 dev net1
+ ip -netns x -4 route

IPv6:

+ ip addr add 1:2:3:4::5/64 dev dummy1
+ ip route add 7:7:7:0::1 dev dummy1 src 1:2:3:4::5
+ ip -6 route show
1:2:3:4::/64 dev dummy1 proto kernel metric 256 pref medium
7:7:7::1 dev dummy1 src 1:2:3:4::5 metric 1024 pref medium
+ ip addr del 1:2:3:4::5/64 dev dummy1
+ ip -6 route show
7:7:7::1 dev dummy1 metric 1024 pref medium

Thanks
Hangbin

