Return-Path: <netdev+bounces-28739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4237780725
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 10:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF2A282310
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 08:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2931775F;
	Fri, 18 Aug 2023 08:29:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8FB1774A
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 08:29:18 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2B63A94
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:29:17 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bbff6b2679so4975395ad.1
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692347357; x=1692952157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yksqX3OepBL9YdH6Uy61gV7vRT7IHvqai8+TUAvydYs=;
        b=kPeQWG5kTwMZwzCRuRf4NSpLARRC5x2Kt4EZlCAysNU9Y2zkO9mEa5clQh6Ffwf8Os
         /MIQ9THRc1gL3Kg8t9ptI1UkqYUcpEvpFan1owot2Q2rAj43zy4akalyhhyhu6RHoc+5
         Bi7qTmlgcJhn3+wqFAepr08oFEWvbUZwisH0wojeInJuaJ7HWqX3ZKYKn3y+n9qSKHhM
         Ga4MDBhy7mwUeL8Ukro7FDdfI+vfisY3yaVpy/EX+V3Sp2wz28wBQ3kEb+AwLXha2gxV
         W14yq+hyLcbvv6IgJU8RjWJ0Qe6d9xDwiyG1QA7JgY+rQh86tk8EWPbsXSjAkpdr552R
         xKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692347357; x=1692952157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yksqX3OepBL9YdH6Uy61gV7vRT7IHvqai8+TUAvydYs=;
        b=iqLzKcbWqOZHs+R82l5cblHt7s4/H6F9lJDMWAucGlOXbv/MQEH2Nj8cnKCFDfUIiA
         yzH6BovOqxYEf3RWaTWqOLVN6efyEWjnwZjq93ETTDhDfC/zR88K4weMLp/CtzlK4OOH
         a1M2eUjHSbn1+j5eZeOkd+UwwLvOA8z16kY3poh69Dlx8U2BPIILWVmHc3xVuaAMd/4J
         Rb6Lc2Tazk5tZmxnusGM29TdnpupD1vqXKHdfN1VA3hpl587MZB87hdfNukvAB5DiKFA
         LKhIrIP5pCoOP+MCMEFTsHlWp3e7h0RBDVUXCKxuksI1pXz4sNuHQGRH4nW4P66shr5s
         oifA==
X-Gm-Message-State: AOJu0YzQ5fS9KqVeYAZhNmrJeJMMZtffnkUOckqUscMmHygvRep8VFdD
	h/xPdN90rxNF2eG94nMf4UIfAP8gME2FXwav
X-Google-Smtp-Source: AGHT+IHe265jcADbCyFizMfABhe647DmbvLjPW2Lcevz+h+/OXll6d+uCbkkA6Hfm+1A04VnQZxXRw==
X-Received: by 2002:a17:902:728a:b0:1bf:728:745b with SMTP id d10-20020a170902728a00b001bf0728745bmr1622227pll.49.1692347356767;
        Fri, 18 Aug 2023 01:29:16 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902ee4d00b001b8a3e2c241sm1148781plo.14.2023.08.18.01.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 01:29:15 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Thomas Haller <thaller@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCHv7 net-next 1/2] ipv6: do not match device when remove source route
Date: Fri, 18 Aug 2023 16:29:01 +0800
Message-Id: <20230818082902.1972738-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230818082902.1972738-1-liuhangbin@gmail.com>
References: <20230818082902.1972738-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After deleting an IPv6 address on an interface and cleaning up the
related preferred source entries, it is important to ensure that all
routes associated with the deleted address are properly cleared. The
current implementation of rt6_remove_prefsrc() only checks the preferred
source addresses bound to the current device. However, there may be
routes that are bound to other devices but still utilize the same
preferred source address.

To address this issue, it is necessary to also delete entries that are
bound to other interfaces but share the same source address with the
current device. Failure to delete these entries would leave routes that
are bound to the deleted address unclear. Here is an example reproducer
(I have omitted unrelated routes):

+ ip link add dummy1 type dummy
+ ip link add dummy2 type dummy
+ ip link set dummy1 up
+ ip link set dummy2 up
+ ip addr add 1:2:3:4::5/64 dev dummy1
+ ip route add 7:7:7:0::1 dev dummy1 src 1:2:3:4::5
+ ip route add 7:7:7:0::2 dev dummy2 src 1:2:3:4::5
+ ip -6 route show
1:2:3:4::/64 dev dummy1 proto kernel metric 256 pref medium
7:7:7::1 dev dummy1 src 1:2:3:4::5 metric 1024 pref medium
7:7:7::2 dev dummy2 src 1:2:3:4::5 metric 1024 pref medium
+ ip addr del 1:2:3:4::5/64 dev dummy1
+ ip -6 route show
7:7:7::1 dev dummy1 metric 1024 pref medium
7:7:7::2 dev dummy2 src 1:2:3:4::5 metric 1024 pref medium

As Ido reminds, in IPv6, the preferred source address is looked up in
the same VRF as the first nexthop device, which is different with IPv4.
So, while removing the device checking, we also need to add an
ipv6_chk_addr() check to make sure the address does not exist on the other
devices of the rt nexthop device's VRF.

After fix:
+ ip addr del 1:2:3:4::5/64 dev dummy1
+ ip -6 route show
7:7:7::1 dev dummy1 metric 1024 pref medium
7:7:7::2 dev dummy2 metric 1024 pref medium

Reported-by: Thomas Haller <thaller@redhat.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2170513
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v7: remove fixes tag
v6:
 - Add back the "!rt->nh" checking as Ido said this should be fixed in
   another patch.
 - Remove the table id checking as the preferred source address is
   looked up in the same VRF as the first nexthop device in IPv6. not VRF
   table like IPv4.
 - Move the fib tests to a separate patch.
v5: Move the addr check back to fib6_remove_prefsrc.
v4: check if the prefsrc address still exists on other device
v3: remove rt nh checking. update the ipv6_del_addr test descriptions
v2: checking table id and update fib_test.sh
---
 net/ipv6/route.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index db10c36f34bb..a5b74b91c8f3 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4582,21 +4582,19 @@ struct fib6_info *addrconf_f6i_alloc(struct net *net,
 
 /* remove deleted ip from prefsrc entries */
 struct arg_dev_net_ip {
-	struct net_device *dev;
 	struct net *net;
 	struct in6_addr *addr;
 };
 
 static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
 {
-	struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
 	struct net *net = ((struct arg_dev_net_ip *)arg)->net;
 	struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
 
 	if (!rt->nh &&
-	    ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
 	    rt != net->ipv6.fib6_null_entry &&
-	    ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
+	    ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr) &&
+	    !ipv6_chk_addr(net, addr, rt->fib6_nh->fib_nh_dev, 0)) {
 		spin_lock_bh(&rt6_exception_lock);
 		/* remove prefsrc entry */
 		rt->fib6_prefsrc.plen = 0;
@@ -4609,7 +4607,6 @@ void rt6_remove_prefsrc(struct inet6_ifaddr *ifp)
 {
 	struct net *net = dev_net(ifp->idev->dev);
 	struct arg_dev_net_ip adni = {
-		.dev = ifp->idev->dev,
 		.net = net,
 		.addr = &ifp->addr,
 	};
-- 
2.38.1


