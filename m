Return-Path: <netdev+bounces-24995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD177727BB
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DAE280FFC
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 14:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D4D1118B;
	Mon,  7 Aug 2023 14:29:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4BF443A
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 14:29:49 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36677F0
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 07:29:48 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKJZF43GszVk6p;
	Mon,  7 Aug 2023 22:27:49 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:29:41 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jmaloy@redhat.com>, <ying.xue@windriver.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <tipc-discussion@lists.sourceforge.net>
Subject: [PATCH net-next] tipc: Remove unused declaration tipc_link_build_bc_sync_msg()
Date: Mon, 7 Aug 2023 22:29:26 +0800
Message-ID: <20230807142926.45752-1-yuehaibing@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 526669866140 ("tipc: let broadcast packet reception use new link receive function")
declared but never implemented this.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/tipc/link.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/tipc/link.h b/net/tipc/link.h
index a16f401fdabd..d80f5649b395 100644
--- a/net/tipc/link.h
+++ b/net/tipc/link.h
@@ -148,8 +148,6 @@ int tipc_link_bc_ack_rcv(struct tipc_link *l, u16 acked, u16 gap,
 			 struct tipc_gap_ack_blks *ga,
 			 struct sk_buff_head *xmitq,
 			 struct sk_buff_head *retrq);
-void tipc_link_build_bc_sync_msg(struct tipc_link *l,
-				 struct sk_buff_head *xmitq);
 void tipc_link_bc_init_rcv(struct tipc_link *l, struct tipc_msg *hdr);
 int tipc_link_bc_sync_rcv(struct tipc_link *l,   struct tipc_msg *hdr,
 			  struct sk_buff_head *xmitq);
-- 
2.34.1


