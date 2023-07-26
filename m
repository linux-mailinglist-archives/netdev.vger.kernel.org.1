Return-Path: <netdev+bounces-21421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE4476390E
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD3A1C212DC
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07043253AB;
	Wed, 26 Jul 2023 14:26:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07B9C2CF
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:26:37 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2554E196;
	Wed, 26 Jul 2023 07:26:36 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R9x4T22F7zTkyW;
	Wed, 26 Jul 2023 22:24:57 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 22:26:31 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <mareklindner@neomailbox.ch>, <sw@simonwunderlich.de>, <a@unstable.cc>,
	<sven@narfation.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <b.a.t.m.a.n@lists.open-mesh.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] batman-adv: Remove unused declarations
Date: Wed, 26 Jul 2023 22:25:25 +0800
Message-ID: <20230726142525.29572-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since commit 335fbe0f5d25 ("batman-adv: tvlv - convert tt query packet to use tvlv unicast packets")
batadv_recv_tt_query() is not used.
And commit 122edaa05940 ("batman-adv: tvlv - convert roaming adv packet to use tvlv unicast packets")
left behind batadv_recv_roam_adv().

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/batman-adv/routing.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/batman-adv/routing.h b/net/batman-adv/routing.h
index 5f387786e9a7..afd15b3879f1 100644
--- a/net/batman-adv/routing.h
+++ b/net/batman-adv/routing.h
@@ -27,10 +27,6 @@ int batadv_recv_frag_packet(struct sk_buff *skb,
 			    struct batadv_hard_iface *iface);
 int batadv_recv_bcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if);
-int batadv_recv_tt_query(struct sk_buff *skb,
-			 struct batadv_hard_iface *recv_if);
-int batadv_recv_roam_adv(struct sk_buff *skb,
-			 struct batadv_hard_iface *recv_if);
 int batadv_recv_unicast_tvlv(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if);
 int batadv_recv_unhandled_unicast_packet(struct sk_buff *skb,
-- 
2.34.1


