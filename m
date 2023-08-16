Return-Path: <netdev+bounces-27920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975A377DA2F
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5372817BF
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 06:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E36C2F0;
	Wed, 16 Aug 2023 06:07:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6564AC2EF
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 06:07:54 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FF81BCC
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 23:07:34 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bdef6f5449so18834925ad.3
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 23:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692166053; x=1692770853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1LNl3P8ApcQfxU0QvfIzYWOWAPiAp89w0rRa+fgQTI=;
        b=eVTsofHxeQSrJ8lPIfNECGlYm/RrtUYbu7nfobcAmIRV7LYsm4zNYRIAfEK4CNxgh+
         IZC+T9+SFiED+stk5imo3xt+wogfP+w+5DWXddbF4RQOXVLp03Oj5Vrj4dbINs/wMCsn
         krOPTehtarqkTIEErSQ7xhqDzrjp+7HvUu4bCdKJT0xmhx8Za7QNzmc99N1nkCKRg7YN
         x7vDwdFrcbynqn/cFI3xoj+mqeWRHu5lpzjYuL+uRGWAzQBCXdNP2lrNRi9J4ab2pc01
         MUTVl9fE2XoTaX2t2w4xJKhyDC2enxD2A6JhaZbwlqofMH3UpUVuSRG7oxsw5glGvee1
         qrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692166053; x=1692770853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1LNl3P8ApcQfxU0QvfIzYWOWAPiAp89w0rRa+fgQTI=;
        b=bFkJp2TsBfjkzfgppUQvSjbdG5Yw3qLs8cY0bwpNqojIWxmQgM4b/J4gF8+fgZ35Fv
         nCYO0UmtIlm3AzJgjy0Pqkxmtn5S2m9wdqelOjZ96zyHwRa1tIAHJ/c6zEa8O2aBnqbZ
         9QBi0BEs5Jn/s5Px9I8tPm2QFJo3wubWQZSEFAuGm6SMMbttIOSwKwx8x3YJoCy98beT
         y0Ne8wbtAnOPoLX8BMq3O5ZgyQCLLnQr6M62CsXWaBc5ScozExiwYpbnfTpk47H3aOhB
         9onxtxg+bXaq+Hel6z+i5ImOvg80lKQ/LfLV2phF70zQIKIi8GxrQQTozI3hHQkfcs7T
         L9ng==
X-Gm-Message-State: AOJu0Yzl05NCHhqCnWN46B++bYVv1w2bpXWhJsTrUZ+FWVlXCQOmawDn
	/DrkAR8JG2fMxcHkBdLrcMVvuf50OcVU9Rd9
X-Google-Smtp-Source: AGHT+IGDqTj+kWhL1sXbPX8mxG6MQ/ibb1hjEiDDlRembbBIZpubojH90Y+3BiBAg7fZWfkT+HPf6g==
X-Received: by 2002:a17:902:a40a:b0:1bc:48d7:f29b with SMTP id p10-20020a170902a40a00b001bc48d7f29bmr990471plq.27.1692166052896;
        Tue, 15 Aug 2023 23:07:32 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q22-20020a170902b11600b001bb24cb9a40sm12097090plr.39.2023.08.15.23.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 23:07:32 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Thomas Haller <thaller@redhat.com>
Subject: [PATCHv6 net-next 1/2] ipv6: do not match device when remove source route
Date: Wed, 16 Aug 2023 14:07:23 +0800
Message-Id: <20230816060724.1398842-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230816060724.1398842-1-liuhangbin@gmail.com>
References: <20230816060724.1398842-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
Fixes: c3968a857a6b ("ipv6: RTA_PREFSRC support for ipv6 route source address selection")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
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
index 10751df16dab..3e1c76c7bdd3 100644
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


