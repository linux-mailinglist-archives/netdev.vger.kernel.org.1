Return-Path: <netdev+bounces-23909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8B576E213
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 09:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C271C214BE
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 07:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A140E13AC0;
	Thu,  3 Aug 2023 07:46:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C27125A7
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 07:46:12 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFA16199
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 00:45:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686efb9ee3cso558901b3a.3
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 00:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691048752; x=1691653552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3siCkD2XPVCoVuoe+tQEUiHiLkxh7ejrSO+8CyuOkVo=;
        b=UfQzB56rxeVt7r+86w9H5fNQ8uQdZDQQOZUF/PgGDhwR84ecZV9R0ux3YOeDN7MyBV
         WfMV/6IvXe2m4Kotmahi+y6R4R9wr++9ZA0FsUfsD8JVAPoOanza8H9NxldFjdqztHyC
         88VsZHOJX2Q+ctFoYuMD8xAP9cZXIiOkidzREYGRxe5JyWU0vgn0yoneiFz5w9VMcrMY
         TNl7JRWftqzkUImyahiyOGuJeVsGCLUmLG5yXtBccbpZ7uE0sg2BH3FPBBBFXcC/hMZ2
         AlHK+iq6Tim37cXgQLHYq4/UCovj2rg3Bj994jo4m0L7lMxURmJr8QVTf+jXEN39tnO8
         nD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691048752; x=1691653552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3siCkD2XPVCoVuoe+tQEUiHiLkxh7ejrSO+8CyuOkVo=;
        b=GZfqWxykj+a0oLYDYkbTN0L8BR375mlgmqRy4w/cofIYNi/UIe9WqEIGOAW68Y4Ebx
         7X4VuIB6Q84wQGhthdFnpNaAhrVVcKJa9q9ynBpGdwX0zKA1TA+8IGAqv10YQncJyQeb
         FtZkdMZiEGtEv40gpXZM7rE53FqRqSmTfrXjkem0Vlj99IameF5KySPR6h/9k49P/NCc
         YcV+rhKrd52WEM/hn8kxJL8eYz7BLqzMstEBEBFHgX+GM3l09ss4g5+1bWuerhyQOYzb
         yLufE2421+JRJw4t5/ytb0c6Tf64ddYdQ7FKXP/EjrELlR62AaeJFaqGrKcsEMmncbQ9
         4x3A==
X-Gm-Message-State: ABy/qLZjMrg5mUqBmBAUuMdTdWaf8iS+BmpuyxVBR8/XqwX8tG3WWvwJ
	g87W73rHuMRz3N9X5Ksp2vug6egaanWYxA==
X-Google-Smtp-Source: APBJJlFFssLpsZSApO27JQxvhXulu2mnTOTuDE8uO+/OW7jbi1gNEU3r8EFB0zlzC5X2t6D9yTvBmg==
X-Received: by 2002:a05:6a21:7889:b0:138:198f:6edf with SMTP id bf9-20020a056a21788900b00138198f6edfmr24084462pzc.46.1691048751858;
        Thu, 03 Aug 2023 00:45:51 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709026b4600b001bb9bc8d232sm13689521plt.61.2023.08.03.00.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 00:45:51 -0700 (PDT)
Date: Thu, 3 Aug 2023 15:45:47 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCHv4 net] ipv6: do not match device when remove source route
Message-ID: <ZMtbK16VpqGwbws1@Laptop-X1>
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
> So, I think we need to call ipv6_chk_addr() from rt6_remove_prefsrc() to
> be consistent with the addition path in ip6_route_info_create():
> 
> ipv6_chk_addr() is not cheap, but it's only called for routes that match
> the previous criteria.
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

After looking into it. I think this looks like a bug in
ip6_route_info_create(). When the dev is lo. It's vrf is the default vrf
table, which makes ipv6_chk_addr() only check dummy1 instead of dummy2.
Maybe we should add a special check for lo dev?

On the other hand, for route delete. How about add a special check for link
local src addr add loopback dev? e.g.

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b45b33394f43..6dbfae99f811 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4586,11 +4586,17 @@ static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
        struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
        struct net *net = ((struct arg_dev_net_ip *)arg)->net;
        struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
+       u32 tb6_id = l3mdev_fib_table(dev) ? : RT_TABLE_MAIN;

-       if (!rt->nh &&
-           ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
-           rt != net->ipv6.fib6_null_entry &&
-           ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
+       bool skip_dev_check = !(ipv6_addr_type(addr) & IPV6_ADDR_LINKLOCAL);
+
+       if (!(rt->fib6_nh->fib_nh_dev->flags & IFF_LOOPBACK))
+               dev = rt->fib6_nh->fib_nh_dev;
+
+       if (rt != net->ipv6.fib6_null_entry &&
+           rt->fib6_table->tb6_id == tb6_id &&
+           ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr) &&
+           !ipv6_chk_addr_and_flags(net, addr, dev, skip_dev_check, 0, IFA_F_TENTATIVE)) {
                spin_lock_bh(&rt6_exception_lock);
                /* remove prefsrc entry */
                rt->fib6_prefsrc.plen = 0;


With this, we can pass the fib_tests and your link local src route testing

Thanks
Hangbin

