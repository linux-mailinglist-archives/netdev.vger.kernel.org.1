Return-Path: <netdev+bounces-24658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27146770F65
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 13:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5211B1C20A91
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 11:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB573A93B;
	Sat,  5 Aug 2023 11:00:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0C4A920
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 11:00:21 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9843468C
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 04:00:18 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RJ02P0dV7zrS4b;
	Sat,  5 Aug 2023 18:59:09 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 5 Aug
 2023 19:00:15 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <kuniyu@amazon.com>
CC: <netdev@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH net-next] udp/udplite: Remove unused function declarations udp{,lite}_get_port()
Date: Sat, 5 Aug 2023 19:00:09 +0800
Message-ID: <20230805110009.44560-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 6ba5a3c52da0 ("[UDP]: Make full use of proto.h.udp_hash innovation.")
removed these implementations but leave declarations.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/udp.h     | 3 ---
 include/net/udplite.h | 2 --
 2 files changed, 5 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index 5a8421cd9083..488a6d2babcc 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -273,9 +273,6 @@ static inline struct sk_buff *skb_recv_udp(struct sock *sk, unsigned int flags,
 
 int udp_v4_early_demux(struct sk_buff *skb);
 bool udp_sk_rx_dst_set(struct sock *sk, struct dst_entry *dst);
-int udp_get_port(struct sock *sk, unsigned short snum,
-		 int (*saddr_cmp)(const struct sock *,
-				  const struct sock *));
 int udp_err(struct sk_buff *, u32);
 int udp_abort(struct sock *sk, int err);
 int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len);
diff --git a/include/net/udplite.h b/include/net/udplite.h
index 299c14ce2bb9..bd33ff2b8f42 100644
--- a/include/net/udplite.h
+++ b/include/net/udplite.h
@@ -81,6 +81,4 @@ static inline __wsum udplite_csum(struct sk_buff *skb)
 }
 
 void udplite4_register(void);
-int udplite_get_port(struct sock *sk, unsigned short snum,
-		     int (*scmp)(const struct sock *, const struct sock *));
 #endif	/* _UDPLITE_H */
-- 
2.34.1


