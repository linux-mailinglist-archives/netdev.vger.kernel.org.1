Return-Path: <netdev+bounces-31331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA3F78D338
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 08:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB112812D9
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 06:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079A715C5;
	Wed, 30 Aug 2023 06:16:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F019915A0
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 06:16:31 +0000 (UTC)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C38CCB
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 23:16:31 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7a25184a648so1822816241.2
        for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 23:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693376189; x=1693980989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmvTj6z/xHNFVH3ZETwtxTxR57Mwo1lTVCpREPyFqeQ=;
        b=awoPPrpAiNIQy0zSP1jJG2Rq3dHsYBJARnYyHJkkQZPiAV6mEMv/T5c6HI1Zs/mzci
         EMcdsnqv295M8vkqNsCzllNyJtkimHokqEeZhb+Y7BDrB/KjCNvuYTSznjnfsWaOTrcp
         hzZZ3pCBi0g5skDI15qHlF8bI8T4XWa2ueXJ5ttwVOPwhMW5UPkLYW2H+XoLhvXICVVg
         hOD28FGmvnqwQ94whtMnL3EXvIfCB/Z2jbua23tNHOYwk0cqfExLLuW17a3i9KGr1Y5U
         qECFvem0Wuvc2FzPpWEhp7Cwo08IUf/7bXOHcVmhuiGfi/b8DRlzb+o7+a1tPetLhWKN
         BF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693376189; x=1693980989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZmvTj6z/xHNFVH3ZETwtxTxR57Mwo1lTVCpREPyFqeQ=;
        b=ktObxeE+3CzXhBHM7SKMiawzSOvpMoxE+OQmOtZ8SzOVEOq93DJNrg0pANtrT0yBCR
         ghkJlBptnJz7e9CP+nH/F2bam+dGwaiuPqW7Q1v96Sg2GSrqsG0s9Ff8RmmteY05A2AT
         +xu6dGrP/I8EOMnkykIThIxaxbt7uFKy5xy2oKsKUh0oFM7vPlo0wQoL3kwJZzpEt3jM
         bB5AApNSERvpIPTKCN2McJB6913EvoHWtPaPrm36osjvHsx/DnMQb3ldrYqY3QzT924a
         LkQuHXvL3JbAkBMjOtg7jHHUOUATiXyHk0ZAH2uAG3t6N2BUUm8Z3i311+5Jk+v//JB/
         E0Uw==
X-Gm-Message-State: AOJu0Yz/axCSpH5aLPnINRG2PJW6KsSZ5ocbhY1Kc5x4jvKJDwdL5bUl
	g3lw8DNexkhGtmgkDpnEGmFg0pXfujI=
X-Google-Smtp-Source: AGHT+IEjCVDUu8wLOBtfKhAOHp/QQXd6VaunRGCnpm+XM3ViO6KQtB2D/RdxwlxiWrNp9zJN64VyoA==
X-Received: by 2002:a67:f993:0:b0:44d:476b:3bc0 with SMTP id b19-20020a67f993000000b0044d476b3bc0mr1280048vsq.28.1693376189384;
        Tue, 29 Aug 2023 23:16:29 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([2409:8a02:7820:a6d0:fe00:94b0:34da:834c])
        by smtp.gmail.com with ESMTPSA id cm8-20020a17090afa0800b00267b7c5d232sm550085pjb.48.2023.08.29.23.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 23:16:28 -0700 (PDT)
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
Subject: [PATCH net-next] ipv6: do not merge differe type and protocol routes
Date: Wed, 30 Aug 2023 14:16:22 +0800
Message-ID: <20230830061622.2320096-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Different with IPv4, IPv6 will auto merge the same metric routes into
multipath routes. But the different type and protocol routes are also
merged, which will lost user's configure info. e.g.

+ ip route add local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 table 100
+ ip route append unicast 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 table 100
+ ip -6 route show table 100
local 2001:db8:103::/64 metric 1024 pref medium
        nexthop via 2001:db8:101::10 dev dummy1 weight 1
        nexthop via 2001:db8:101::10 dev dummy2 weight 1

+ ip route add 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel table 200
+ ip route append 2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp table 200
+ ip -6 route show table 200
2001:db8:104::/64 proto kernel metric 1024 pref medium
        nexthop via 2001:db8:101::10 dev dummy1 weight 1
        nexthop via 2001:db8:101::10 dev dummy2 weight 1

So let's skip counting the different type and protocol routes as siblings.
After update, the different type/protocol routes will not be merged.

+ ip -6 route show table 100
local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 metric 1024 pref medium
2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 metric 1024 pref medium

+ ip -6 route show table 200
2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel metric 1024 pref medium
2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp metric 1024 pref medium

Reported-by: Thomas Haller <thaller@redhat.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2161994
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
All fib test passed:
Tests passed: 203
Tests failed:   0
---
 net/ipv6/ip6_fib.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 28b01a068412..f60f5d14f034 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1133,6 +1133,11 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 							rt->fib6_pmtu);
 				return -EEXIST;
 			}
+
+			if (iter->fib6_type != rt->fib6_type ||
+			    iter->fib6_protocol != rt->fib6_protocol)
+				goto next_iter;
+
 			/* If we have the same destination and the same metric,
 			 * but not the same gateway, then the route we try to
 			 * add is sibling to this route, increment our counter
-- 
2.41.0


