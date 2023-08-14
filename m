Return-Path: <netdev+bounces-27263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803FF77B434
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 10:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BACC2810BA
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 08:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A148BEB;
	Mon, 14 Aug 2023 08:33:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1B55662
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 08:33:44 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3E010B
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 01:33:43 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a7f74134e7so936299b6e.1
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 01:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692002022; x=1692606822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7xPm11escuGzhgNkOmStOSpd/NhT0RzY//H/Y2eSJY0=;
        b=Q0IvBEzeTTPsBL0uVtadL3ZO18SNgifoX27qxv6p3wcFwFN7Y/rxOivpDeuJVhuK/P
         CnxZbS/uj83R7HIn1iQny/Dm+n6Adt2QmEgs2W7iYJcnE6btMNxukOZO05Bd7qNlin1t
         qmLNriI5WhjGU7lSHr1UeCIIw54oyan9JTX8l/MABsz2geFYM0lZjkmSOUA0JNHdMuci
         HG0qMoO1VlDE19GrW7u3KT7D2cciMc+PM0X1TBF+dcZDs3pq9JP/LkDX8hqnJJcM3OnL
         s+J6ihlne3vfbgiCwJWbbiHWhWE4PWjeg+nEoMmIopOau16O2SRKJZCxTByh8UOlwiMI
         xMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692002022; x=1692606822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xPm11escuGzhgNkOmStOSpd/NhT0RzY//H/Y2eSJY0=;
        b=i61RXNIPpx2pgYZg41PC5fUzfbKWkuBRukElQmBwiAVysHTD4WVNZccpv9SMnK1337
         +c8zY/aqFqeuRZqa8/0SKpkD8uTUb+L2x7ivU9kUwHOPOvIMX+/Y+LqF5wla7NpCIkR4
         5Yqt1jHnp9l7KsBRTdEAGxTJibmwITZFRseyC1lEUWdALAFWK6QYrte1ITnpwT6KKk1f
         avzxiUq8I4UXb1HKBYtWkMmmKt0wPskYmACoIuWfSzQxFmapyZn8/JnJVFiTpXh9Y6SH
         Gbk/BtsHWpz/kAgAOa5d67h7g19JyhG+wmRkP1DLXuHU6RPulfzUWN5AVDw34QgvIB6E
         7PZQ==
X-Gm-Message-State: AOJu0YwDEkqTCWHRTmyCiQ1NvRX9sCKQ0aq+hT2FjZPXlkb+EvSNCUPa
	ws04oe7FwvnMW9v37S5hSl7BLw6nJejB4BpS
X-Google-Smtp-Source: AGHT+IHfuBrps+Yf7a35PZ/k8KQvUWb3W9hrYMIV+Sx3aGg68AFGNM33Ijf3RjRscbh/susdyFEl0w==
X-Received: by 2002:aca:2311:0:b0:3a1:bfda:c6d2 with SMTP id e17-20020aca2311000000b003a1bfdac6d2mr10539753oie.11.1692002022460;
        Mon, 14 Aug 2023 01:33:42 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n26-20020a638f1a000000b00565009a97f0sm7941964pgd.17.2023.08.14.01.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 01:33:41 -0700 (PDT)
Date: Mon, 14 Aug 2023 16:33:37 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCHv5 net-next] ipv6: do not match device when remove source
 route
Message-ID: <ZNnm4UOszRN6TOHJ@Laptop-X1>
References: <20230811095308.242489-1-liuhangbin@gmail.com>
 <ZNkASnjqmAVg2vBg@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNkASnjqmAVg2vBg@shredder>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ido,
On Sun, Aug 13, 2023 at 07:09:46PM +0300, Ido Schimmel wrote:
> On Fri, Aug 11, 2023 at 05:53:08PM +0800, Hangbin Liu wrote:
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index 64e873f5895f..0f981cc5bed1 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -4590,11 +4590,12 @@ static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
> >  	struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
> >  	struct net *net = ((struct arg_dev_net_ip *)arg)->net;
> >  	struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
> > +	u32 tb6_id = l3mdev_fib_table(dev) ? : RT_TABLE_MAIN;
> >  
> > -	if (!rt->nh &&
> > -	    ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
> > -	    rt != net->ipv6.fib6_null_entry &&
> > -	    ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
> > +	if (rt != net->ipv6.fib6_null_entry &&
> > +	    rt->fib6_table->tb6_id == tb6_id &&
> > +	    ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr) &&
> > +	    !ipv6_chk_addr(net, addr, rt->fib6_nh->fib_nh_dev, 0)) {
> >  		spin_lock_bh(&rt6_exception_lock);
> >  		/* remove prefsrc entry */
> >  		rt->fib6_prefsrc.plen = 0;
> 
> The table check is incorrect which is what I was trying to explain here
> [1]. The route insertion code does not check that the preferred source
> is accessible from the VRF where the route is installed, but instead
> that it is accessible from the VRF of the first nexthop device. I'm not

Sorry for my bad understanding and thanks a lot for your patient response!

Now I finally get what you mean of "In IPv6, the preferred source address is
looked up in the same VRF as the first nexthop device." Which is not same with
the IPv4 commit f96a3d74554d ipv4: Fix incorrect route flushing when source
address is deleted

I will remove the tb id checking in next version. Another thing to confirm.
We need remove the "!rt->nh" checking, right. Because I saw you kept it in you
reply.

Thanks and Best regards
Hangbin

