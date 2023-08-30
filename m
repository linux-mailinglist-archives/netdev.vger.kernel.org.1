Return-Path: <netdev+bounces-31330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D770E78D337
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 08:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A6C1C209BB
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 06:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A57015C5;
	Wed, 30 Aug 2023 06:16:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B37215A0
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 06:16:01 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A70CCD2
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 23:16:00 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf3a2f4528so40919635ad.2
        for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 23:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693376159; x=1693980959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmvTj6z/xHNFVH3ZETwtxTxR57Mwo1lTVCpREPyFqeQ=;
        b=e7GHhCSgK2jsDemyFJW2ozGpZWPrwXmP3RAtAxnU7V0Trun72PUA6fX+dBaXhO55ou
         /1N5ORjreKViJfvwEpwRqnsZoimrxkQk1ZJS6pCA2i7HUZyu4KlQWWKyRnfoWOgrH1a3
         kfOj80BRCtv6P/AeVc25uUnjIcPHmkobPdMGxFHNIoef4hNfR4cZ0/uhfREDwvpn0Zq9
         nUn2PkdYZp33Lj8IXq6sO8kYQ9eAapO9CKmbw0+h6br9YUWfP5fx7boESNBU0vuU1GGa
         y4yJVOnffUoTfcF300kEX7V/x6yJjyudmQLG3Ch96Nl50oNbk141+miG7PezDwq4ojP+
         CR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693376159; x=1693980959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZmvTj6z/xHNFVH3ZETwtxTxR57Mwo1lTVCpREPyFqeQ=;
        b=O+cgQl/EiQ7Trk30utqIwXNgCPvLwnxXUdjuC0L9hf8PI3Qx6MtGAw4jMJUjDYRF0b
         kXR+M1pqfmrjMKG2qTTUbXLH6sBrHkPnMfsx9/hBdzimjUrW/Cllhtanv6D8WrfHJqsG
         DQYd3Gbpx7EATAK6q8jaVA4pir4GQyatoj2jjbntgnWmCObNHcbjvR3GKzTfVhCkY33J
         9bVo1oioRd3U+gbOj9vsVYcNfT6iKUmrNSneSsrD77woQwdTz4Ri3QSK8eJEQXrv0PBb
         fbkjJ6PwG51JLoAwnffP46JDIE0yF2ZUVyQDpzbTNn9q9AaOvNf9hb4xlsxrpMc0jLvx
         qGSg==
X-Gm-Message-State: AOJu0YxJq2fOIfDwSkr15ces7ByLvnDMdneQZvNxUabg/qJdSceQLNti
	2lZEAebzXMXDlcY+vCCCzipP2XF8swg=
X-Google-Smtp-Source: AGHT+IFO/9kV77RUfJjEV5dni38G8BCDAveWFsMUdJwaKpsBmrMi6SY27W3NRN6epRUK3fREh82b8g==
X-Received: by 2002:a17:903:1208:b0:1bb:9b29:20d9 with SMTP id l8-20020a170903120800b001bb9b2920d9mr1462810plh.20.1693376158996;
        Tue, 29 Aug 2023 23:15:58 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([2409:8a02:7820:a6d0:fe00:94b0:34da:834c])
        by smtp.gmail.com with ESMTPSA id v4-20020a170902b7c400b001b8a3dd5a4asm10325803plz.283.2023.08.29.23.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 23:15:57 -0700 (PDT)
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
Date: Wed, 30 Aug 2023 14:15:50 +0800
Message-ID: <20230830061550.2319741-1-liuhangbin@gmail.com>
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


