Return-Path: <netdev+bounces-22541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D3D767F1A
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 14:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5052E1C20A9B
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 12:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9AA16415;
	Sat, 29 Jul 2023 12:24:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3073C2A
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 12:24:07 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1F0CE;
	Sat, 29 Jul 2023 05:24:06 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RCk9h1SPfzNmTB;
	Sat, 29 Jul 2023 20:20:40 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 29 Jul
 2023 20:24:04 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <dhowells@redhat.com>, <marc.dionne@auristor.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <linux-afs@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] rxrpc: Remove unused function declarations
Date: Sat, 29 Jul 2023 20:23:27 +0800
Message-ID: <20230729122327.12668-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

commit 3cec055c5695 ("rxrpc: Don't hold a ref for connection workqueue")
left behind these declarations.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/rxrpc/ar-internal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index e8e14c6f904d..a22f4ae849ca 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -834,7 +834,6 @@ bool rxrpc_new_incoming_call(struct rxrpc_local *local,
 			     struct rxrpc_connection *conn,
 			     struct sockaddr_rxrpc *peer_srx,
 			     struct sk_buff *skb);
-void rxrpc_accept_incoming_calls(struct rxrpc_local *);
 int rxrpc_user_charge_accept(struct rxrpc_sock *, unsigned long);
 
 /*
@@ -954,7 +953,6 @@ void rxrpc_connect_client_calls(struct rxrpc_local *local);
 void rxrpc_expose_client_call(struct rxrpc_call *);
 void rxrpc_disconnect_client_call(struct rxrpc_bundle *, struct rxrpc_call *);
 void rxrpc_deactivate_bundle(struct rxrpc_bundle *bundle);
-void rxrpc_put_client_conn(struct rxrpc_connection *, enum rxrpc_conn_trace);
 void rxrpc_discard_expired_client_conns(struct rxrpc_local *local);
 void rxrpc_clean_up_local_conns(struct rxrpc_local *);
 
-- 
2.34.1


