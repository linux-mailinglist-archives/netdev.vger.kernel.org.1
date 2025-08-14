Return-Path: <netdev+bounces-213562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD06B25A70
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 06:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A13437A157C
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 04:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B8719C556;
	Thu, 14 Aug 2025 04:23:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B203D69;
	Thu, 14 Aug 2025 04:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755145405; cv=none; b=B948CYqXR+sw4eV2zpw6Fd+g228jECAXWZfYWlZe3bVj2QuPt+XFfLBss8CQR6xgAbHK5967GiFpooCjSUrDE2u37jgvtt0UFbZO35abSte/OfOf55NnA41LeMW1RhYYh7PPNGZ72B97O06G+uE5aJus183xIqMuNOxg+3UVigo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755145405; c=relaxed/simple;
	bh=OU/17fUqQ2Vxs2ejvWaFCB390X2jIlbgKXMJALgspmk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rRl2ShCV1ncJ6sldTUipIcWcyLqf1hrYVSvOhrMNTC1xRRTk7ziXvxYR8iF3hDO3CK4l2XxKnIu4dp49lNzSCOI5BRfn43NFfXEwVlbXmXAQCTaY9235eNkr+4uAJMotD3v1m5p0rlM0fdpn724i3e6OvBFWSZprrn9/BNt7POM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c2XBy1qjnztTC8;
	Thu, 14 Aug 2025 12:22:18 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BF051800B2;
	Thu, 14 Aug 2025 12:23:18 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 12:23:17 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <razor@blackwall.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
CC: <bridge@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <wangliang74@huawei.com>
Subject: [PATCH net-next] net: bridge: remove unused argument of br_multicast_query_expired()
Date: Thu, 14 Aug 2025 12:23:55 +0800
Message-ID: <20250814042355.1720755-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500016.china.huawei.com (7.185.36.197)

Since commit 67b746f94ff3 ("net: bridge: mcast: make sure querier
port/address updates are consistent"), the argument 'querier' is unused,
just get rid of it.

Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/bridge/br_multicast.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 1377f31b719c..4dc62d01e2d3 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4049,8 +4049,7 @@ int br_multicast_rcv(struct net_bridge_mcast **brmctx,
 }
 
 static void br_multicast_query_expired(struct net_bridge_mcast *brmctx,
-				       struct bridge_mcast_own_query *query,
-				       struct bridge_mcast_querier *querier)
+				       struct bridge_mcast_own_query *query)
 {
 	spin_lock(&brmctx->br->multicast_lock);
 	if (br_multicast_ctx_vlan_disabled(brmctx))
@@ -4069,8 +4068,7 @@ static void br_ip4_multicast_query_expired(struct timer_list *t)
 	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
 							     ip4_own_query.timer);
 
-	br_multicast_query_expired(brmctx, &brmctx->ip4_own_query,
-				   &brmctx->ip4_querier);
+	br_multicast_query_expired(brmctx, &brmctx->ip4_own_query);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -4079,8 +4077,7 @@ static void br_ip6_multicast_query_expired(struct timer_list *t)
 	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
 							     ip6_own_query.timer);
 
-	br_multicast_query_expired(brmctx, &brmctx->ip6_own_query,
-				   &brmctx->ip6_querier);
+	br_multicast_query_expired(brmctx, &brmctx->ip6_own_query);
 }
 #endif
 
-- 
2.33.0


