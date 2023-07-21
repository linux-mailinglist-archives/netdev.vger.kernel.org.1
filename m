Return-Path: <netdev+bounces-19764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8D775C24D
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 10:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F85D1C215F8
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 08:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461EC14F71;
	Fri, 21 Jul 2023 08:59:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364CC14F65
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 08:59:30 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5CA9E
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 01:59:29 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6686ef86110so1136947b3a.2
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 01:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689929968; x=1690534768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zBSxGx6yL8p4ekQABEf2ksMC9Mdh4safTVjM09lsCoQ=;
        b=DHhXJ+39NRZ8bVeqkVhWooCIAuF9i3ubCSHQMRTKZocCPytMfTWtoqAQFuZ14nvfeQ
         aIm1WLSwUfsDDLg9cmcZ1tWBlOANb7+a7E97V/1Q63eDFpHhjPYtWMXEI0yocQWmxUbP
         CayPz6+3/uMIaa8wEUuOowa5YgOSNcxtHieWC70hqsjWTRNGdlgpa2nRtNXoSZ2noLq+
         T4mrP/eAUjBAXcAbaP3IP/v745XLvLuhwXSi6piZ4Qhb2MfBWnDmTe1lTiFaceWtaX2N
         RS/VEUG9bGm33lcjWvFYKJrbqZO9nresz06r9+5j9Cg3Nb5ozGYUIsn+yjq6H6BrR5WI
         k4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689929968; x=1690534768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBSxGx6yL8p4ekQABEf2ksMC9Mdh4safTVjM09lsCoQ=;
        b=KMUUAk2SAIgbtu6KVcCJobGf9LHG9bwPKV+MOa8Od4885915u5XBqXpr9QVNHvBhM9
         L9EubZWCHR/6UiYSJAWkG3WyYfnAIvYIRyuM/ny1kw6UmbNvN6HcVsVrD10a0t9NziOX
         pE8hLp27DjXbqlhXts9YmFle3VLjCcyvkHkHTMsHLjg04BI93XmC1eTBkef0fP1CGuzp
         ZptYeIoEoaS/6JWwZqIT1RyfFmz0E0sBkLv0s3cEl9M9oxe2+dtuHwXNkVfKog66lvG9
         mssmiE/H2H5OT0Ouu0bzJ/6DpLxH1iBHQ13eiSu6+olALkbS/JNB7njOUWiWKs86C/3J
         eBxQ==
X-Gm-Message-State: ABy/qLYASw7P6fYP57n81y6HRrxlORuFTTBR+l+D8HpZ6pMVyEZwryKl
	st/si5wIaGvvVqOae72VF0s=
X-Google-Smtp-Source: APBJJlEVVak55j45X/ALizR4PpF32dyjtL+7hCgd8JREpBGkc2RicOrOdVkr6r52+CNTiGgecOZ//Q==
X-Received: by 2002:a05:6a00:1a16:b0:67f:2ba2:f741 with SMTP id g22-20020a056a001a1600b0067f2ba2f741mr1030262pfv.24.1689929968490;
        Fri, 21 Jul 2023 01:59:28 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d16-20020aa78e50000000b006827d86ca0csm2527193pfr.55.2023.07.21.01.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 01:59:27 -0700 (PDT)
Date: Fri, 21 Jul 2023 16:59:21 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCHv3 net] ipv6: do not match device when remove source route
Message-ID: <ZLpI6YZPjmVD4r39@Laptop-X1>
References: <20230720065941.3294051-1-liuhangbin@gmail.com>
 <ZLk0/f82LfebI5OR@shredder>
 <ZLlJi7OUy3kwbBJ3@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLlJi7OUy3kwbBJ3@shredder>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ido,

On Thu, Jul 20, 2023 at 05:49:47PM +0300, Ido Schimmel wrote:
> Actually, there is another problem here. IPv4 checks that the address is
> indeed gone (it can be assigned to more than one interface):
> 
> + ip link add name dummy1 up type dummy
> + ip link add name dummy2 up type dummy
> + ip link add name dummy3 up type dummy
> + ip address add 192.0.2.1/24 dev dummy1
> + ip address add 192.0.2.1/24 dev dummy2
> + ip route add 198.51.100.0/24 dev dummy3 src 192.0.2.1
> + ip address del 192.0.2.1/24 dev dummy2
> + ip -4 r s
> 192.0.2.0/24 dev dummy1 proto kernel scope link src 192.0.2.1 
> 198.51.100.0/24 dev dummy3 scope link src 192.0.2.1 
> 
> But it doesn't happen for IPv6:
> 
> + ip link add name dummy1 up type dummy
> + ip link add name dummy2 up type dummy
> + ip link add name dummy3 up type dummy
> + ip address add 2001:db8:1::1/64 dev dummy1
> + ip address add 2001:db8:1::1/64 dev dummy2
> + ip route add 2001:db8:2::/64 dev dummy3 src 2001:db8:1::1
> + ip address del 2001:db8:1::1/64 dev dummy2
> + ip -6 r s
> 2001:db8:1::/64 dev dummy1 proto kernel metric 256 pref medium
> 2001:db8:2::/64 dev dummy3 metric 1024 pref medium
> fe80::/64 dev dummy1 proto kernel metric 256 pref medium
> fe80::/64 dev dummy2 proto kernel metric 256 pref medium
> fe80::/64 dev dummy3 proto kernel metric 256 pref medium

Hmm, what kind of usage that need to add same address on different interfaces?
BTW, to fix it, how about check if the IPv6 addr still exist. e.g.

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4590,10 +4590,11 @@ static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
        struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
        struct net *net = ((struct arg_dev_net_ip *)arg)->net;
        struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
+       u32 tb6_id = l3mdev_fib_table(dev) ? : RT_TABLE_MAIN;

-       if (!rt->nh &&
-           ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
-           rt != net->ipv6.fib6_null_entry &&
+       if (rt != net->ipv6.fib6_null_entry &&
+           rt->fib6_table->tb6_id == tb6_id &&
+           !ipv6_chk_addr_and_flags(net, addr, NULL, true, 0, IFA_F_TENTATIVE) &&
            ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
                spin_lock_bh(&rt6_exception_lock);
                /* remove prefsrc entry */

Thanks
Hangbin

