Return-Path: <netdev+bounces-26687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F11D778961
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0AF11C21316
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DE15661;
	Fri, 11 Aug 2023 09:01:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633281869
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:01:57 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82A11FE6
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:01:55 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-26b139f4e42so767440a91.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691744515; x=1692349315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FhqsYubntW7QJhqHgzbTQa0yosLQo42JA/MwfO6aMGo=;
        b=YSHtSQmkaSQF5CHWz6PfRQp+FxJbBebUiBd9ZMEDU2388jEQ2rAZg7DWRQg6KW1cev
         1SxpprZ0g9lSCf69Xg0UDYngSCkRKKIqAFvaxeuYjNClrC8gbqin24lTZM+joHFxfs7i
         8xmuZMxFYLvD+T7Ysx0nmxc1hH19UlHHQxFdVsLVrLvFee/bii6tUVnvcGrvljxaryRU
         0MZPWXnR4SykmO5YI6f7xKvUYuM5/9TD4oFlkZrToIx3TlYXgsugbPMqkqP40butEwZ3
         G30qmiF7fmkXzxc20pkVnniu8mC0KuZurL99zwGetC/mB6lFxoh2pAFWn1fOXH70n95l
         Djpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691744515; x=1692349315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhqsYubntW7QJhqHgzbTQa0yosLQo42JA/MwfO6aMGo=;
        b=Cylpe/JD3XVjc0kK9XPEgTzAyaGTDdNb77nII3wWTorkR7KLJpufsAAUhlSUyLhYiC
         I4dzxer/3xf7l1QJaitHlQv4tM3J0KuT4ZiKn8O6hj3iy1A7kGOSJfYrU98wZtuCO8qv
         F4Rcg+QRLwU8+gwBh9i2cN+H7d6aT+T1Zvf8kAoRXvoTYG/HhIKnBT8FvA3435RIKPxn
         nrsYMteI9fSGSBTKJhnPZzP2jPUyJmXftPw9eGKm4OhwhxJt+C+l+NMQnM5VfLngCSYC
         gBkMBoB1k7I6RjNAq47n6VrxGpkbmeob87MlYljQDuQyLOwod2keRaa9O2SAa4vvKuFb
         Bwlw==
X-Gm-Message-State: AOJu0Yw9RqM2wA7L/TQZOZrHzRDQi7lecE36OuiTClqoQGhkx5dSPIHx
	HAlyQM0kwUix/bD+iBLgu6UQpnu32YoGDw==
X-Google-Smtp-Source: AGHT+IHTeofPQcsHyUL3F1FisFbbZLxwcHl+jqyvxH+xHZPoJOo9nQfE8oDN+DkrAe2rGLnsoWTjcQ==
X-Received: by 2002:a17:90a:3e4b:b0:268:a61:ba86 with SMTP id t11-20020a17090a3e4b00b002680a61ba86mr668190pjm.16.1691744514989;
        Fri, 11 Aug 2023 02:01:54 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id gm23-20020a17090b101700b0026940eb686bsm4738303pjb.20.2023.08.11.02.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 02:01:52 -0700 (PDT)
Date: Fri, 11 Aug 2023 17:01:47 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCHv4 net] ipv6: do not match device when remove source route
Message-ID: <ZNX4+418qTh+cZvV@Laptop-X1>
References: <20230725102137.299305-1-liuhangbin@gmail.com>
 <ZMjx2D3AD81hvDGp@shredder>
 <ZMsp7A4yvyVUCu+o@Laptop-X1>
 <ZNSol/7x5oI6amEB@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNSol/7x5oI6amEB@shredder>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 12:06:31PM +0300, Ido Schimmel wrote:
>  static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
>  {
> -       struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;

We can't remove this parameter and there is an tb id check. My final patch
will looks like:

 static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
 {
+       struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
        struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
        struct net *net = ((struct arg_dev_net_ip *)arg)->net;
-       struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
+       u32 tb6_id = l3mdev_fib_table(dev) ? : RT_TABLE_MAIN;

-       if (!rt->nh &&
-           ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
-           rt != net->ipv6.fib6_null_entry &&
-           ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
+       if (rt != net->ipv6.fib6_null_entry &&
+           rt->fib6_table->tb6_id == tb6_id &&
+           ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr) &&
+           !ipv6_chk_addr(net, addr, rt->fib6_nh->fib_nh_dev, 0)) {
                spin_lock_bh(&rt6_exception_lock);
                /* remove prefsrc entry */
                rt->fib6_prefsrc.plen = 0;

And I will update the fib_test to do a special check for nexthop on loopback dev.

Thanks
Hangbin

>         struct net *net = ((struct arg_dev_net_ip *)arg)->net;
>         struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
>  
>         if (!rt->nh &&
> -           ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
>             rt != net->ipv6.fib6_null_entry &&
> -           ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
> +           ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr) &&
> +           !ipv6_chk_addr(net, addr, rt->fib6_nh->fib_nh_dev, 0)) {
>                 spin_lock_bh(&rt6_exception_lock);
>                 /* remove prefsrc entry */
>                 rt->fib6_prefsrc.plen = 0;
> @@ -4609,7 +4607,6 @@ void rt6_remove_prefsrc(struct inet6_ifaddr *ifp)
>  {
>         struct net *net = dev_net(ifp->idev->dev);
>         struct arg_dev_net_ip adni = {
> -               .dev = ifp->idev->dev,
>                 .net = net,
>                 .addr = &ifp->addr,
>         };

