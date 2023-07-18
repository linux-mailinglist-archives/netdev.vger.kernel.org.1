Return-Path: <netdev+bounces-18468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B7D7574A8
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 08:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690A5281107
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 06:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB3D3D63;
	Tue, 18 Jul 2023 06:53:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5054710EA
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 06:53:21 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE8C1B3
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 23:53:18 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666ecf9a081so5379414b3a.2
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 23:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689663198; x=1692255198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zTzHjdfQx+CACbfDLys04ENOlJetrH4U0LLN63rgZMw=;
        b=dlSPlspzsZgysuBZGCNUDDjH85JCBzEptDIRp3PbFtWrQ8SuncfQw5PIrOL4PCEcS4
         UDkZAgMmCpITYEf9t1CGbIFcd3EVeDuh6EWt1mLO0zp2eWTArmTv4QMk042D7MtSl/+c
         XEVZfbTKBlsztWpe07Jc+agcijBGXhuAXmQS5uP98rEijMkPGloWoJU363rzsQ5pOn6m
         MMhM1JR9VwgQdx3MFxXTKHWMEqnWOws68EZ7zs7rMWLaDsoYU9UDal6Df92Kxl+wYi9a
         4N8Bf3XMHBmtRjjiTz0do9DqagVyDXRkNhFIGJM7KpQQlGd2L3h9qog+ZDwKKfdbbRee
         n94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689663198; x=1692255198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTzHjdfQx+CACbfDLys04ENOlJetrH4U0LLN63rgZMw=;
        b=QuM4eg4caFZ3lLdcqm13rNCLIkxpKKDCWt6hEzp70oene9Zcag4sTn6jZsNAKrK0Oy
         5y1KHcAp3cJxkcqRkDNnrXbG0TE+XZlEBXWhbou0lujqji3OfyWB6nRUpk6RmNp/MUoj
         r5h9ucoiECGiblRvnyGQQkYKVyvL1EkCW3BF45fPWi49xphLRfX3vBNlyGj2UQOoGqpA
         iAx4QTpLEtZDEayafadfBPbhyghrcmrabTR+ph0o8OlXiDJWXwqVkKEqfDnuHIYuxWDm
         3PnaiYzy7aDHXiiYV4+qhCjoTpSUGTp8BM/5Y6iQrfNApzcYTifvjwyDLUoacEcY+Sna
         zRLw==
X-Gm-Message-State: ABy/qLYaOr3OpIVmcJrEGnnzERy/+rDQL3IAddLh+mUu8ZfifKBJ6tdO
	jQeaQxTFRFU6D67eZpxcpX8A/ZoOSKEFUCKp
X-Google-Smtp-Source: APBJJlGupGqbuN1b7mg/w5crhH/sOR++bzw4Tfi2ZOuUpabUB+AK3oZsvfZSHAW5eCK/rTSwrFD1Ng==
X-Received: by 2002:a05:6a21:6d9a:b0:12c:2dc7:74bc with SMTP id wl26-20020a056a216d9a00b0012c2dc774bcmr20246885pzb.46.1689663197630;
        Mon, 17 Jul 2023 23:53:17 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902ea8300b001b895336435sm1032308plb.21.2023.07.17.23.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 23:53:16 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Thomas Haller <thaller@redhat.com>
Subject: [PATCH net] ipv6: do not match device when remove source route
Date: Tue, 18 Jul 2023 14:52:53 +0800
Message-Id: <20230718065253.2730396-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
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

After fix:

+ ip addr del 1:2:3:4::5/64 dev dummy1
+ ip -6 route show
7:7:7::1 dev dummy1 metric 1024 pref medium
7:7:7::2 dev dummy2 metric 1024 pref medium

Reported-by: Thomas Haller <thaller@redhat.com>
Fixes: c3968a857a6b ("ipv6: RTA_PREFSRC support for ipv6 route source address selection")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/ipv6/route.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 64e873f5895f..ab8c364e323c 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4607,7 +4607,6 @@ void rt6_remove_prefsrc(struct inet6_ifaddr *ifp)
 {
 	struct net *net = dev_net(ifp->idev->dev);
 	struct arg_dev_net_ip adni = {
-		.dev = ifp->idev->dev,
 		.net = net,
 		.addr = &ifp->addr,
 	};
-- 
2.38.1


