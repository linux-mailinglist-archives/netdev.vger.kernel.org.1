Return-Path: <netdev+bounces-20733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC44760CD5
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05BE52817B8
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 08:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0DD13AFB;
	Tue, 25 Jul 2023 08:21:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09758F71
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 08:21:05 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8585E64
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 01:21:04 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bb8a89b975so12497635ad.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690273264; x=1690878064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eo9i0Grfce124ZQq8nf2UkGETswEEpg+/WJcF86O1jw=;
        b=Tk1AedAZJdCw4MfdxtZ++Gzzx4Q+TnFfH1PzOMmnNmHIgaaB21cfmTZQhA5fbdj0bo
         +wjksqycnu1onRj6kOigzpv1KDNTbyAJ8HzAi2qYGCcKKbgFUSGA/pgOvY3eOFac6TV2
         HYXeaC4EKDvPgARZOXecSUHfAvL3CO7DZwZENe6r0rrXfdstFQ/i2pEpELb1MYQMYywS
         YDemGMhorFIlO2x4xuGsOx2OHOiaCyHHtnnl142wojTFT5QfzfB4vWVwP5NYqs4TV952
         2riKcdFDMXL6stZheNWuVIc0IPz8668s/iimjt5KXodoVDvfxUTUWaXBBp39YL82no5n
         bBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690273264; x=1690878064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eo9i0Grfce124ZQq8nf2UkGETswEEpg+/WJcF86O1jw=;
        b=eBn1HW748pqJkm/cyqUjAEgxD/OdpHyshZFGn33DbpC57dBe25ME5VyYs5ATiSZGMX
         Af2HAudQbE8ZeLULz4wgraN3vYaj6GT68Y8Jt0xhC0zSeejRdQ3m73Ns37owu1vxVw4Y
         LioJ1zEL6HedWCFb29LFswrW1fe2bl+5w2jGq+BSAP1AdwMmw63ZW3MINSCODjrOGG8X
         12Kspij69MzCXohOGs8ZlwI9n8iwCKK5cy4Ek7egZPKHtM3ljChDXO3eHdZmwX34dkBs
         MyBZqEILnUXUEr2N91nwPnvmxH1HxElXSJsEEtYgEECf2zDOez3hwW13ltT4zflWCY7n
         v5fw==
X-Gm-Message-State: ABy/qLb0RLlY2vZnX5Sryeu0+DFWPEvS0yAlGgkwidmDgT8FBstMmp50
	LBSkCVttfdohegEpb+0/WW8=
X-Google-Smtp-Source: APBJJlGhiBNvf28sJAXq9JQ0FPcuf0h1DEB3zXot8CV0Ni2bubb+WpexsfiL+BWx/wT6aVc+j5eRuQ==
X-Received: by 2002:a17:902:b18f:b0:1bb:9b29:20e3 with SMTP id s15-20020a170902b18f00b001bb9b2920e3mr4577897plr.67.1690273264226;
        Tue, 25 Jul 2023 01:21:04 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902d48700b001b80b342f61sm10306141plg.268.2023.07.25.01.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:21:03 -0700 (PDT)
Date: Tue, 25 Jul 2023 16:20:59 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Ido Schimmel <idosch@idosch.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Message-ID: <ZL+F6zUIXfyhevmm@Laptop-X1>
References: <ZLZnGkMxI+T8gFQK@shredder>
 <20230718085814.4301b9dd@hermes.local>
 <ZLjncWOL+FvtaHcP@Laptop-X1>
 <ZLlE5of1Sw1pMPlM@shredder>
 <ZLngmOaz24y5yLz8@Laptop-X1>
 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
 <ZLobpQ7jELvCeuoD@Laptop-X1>
 <ZLzY42I/GjWCJ5Do@shredder>
 <ZL48xbowL8QQRr9s@Laptop-X1>
 <20230724084820.4aa133cc@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724084820.4aa133cc@hermes.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 08:48:20AM -0700, Stephen Hemminger wrote:
> On Mon, 24 Jul 2023 16:56:37 +0800
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> > The NetworkManager keeps a cache of the routes. Missing/Wrong events mean that
> > the cache becomes inconsistent. The IPv4 will not send src route delete info
> > if it's bond to other device. While IPv6 only modify the src route instead of
> > delete it, and also no notify. So NetworkManager developers complained and
> > hope to have a consistent and clear notification about route modify/delete.
> 
> Read FRR they get it right. The routing daemons have to track kernel,
> and the semantics have been worked out for years.

Yes, normally the routing daemon need to track kernel. On the other hand,
the kernel also need to make a clear feedback. The userspace developers may
not know the kernel code very well. The unclear/inconsistent notification
would make them confused.

Thanks
Hangbin

