Return-Path: <netdev+bounces-24655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC38770F5F
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 12:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253601C20AC3
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 10:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D713A8F6F;
	Sat,  5 Aug 2023 10:52:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB7B847F
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 10:52:12 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A1810CF
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 03:52:11 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHzrD1jMGzVjvD;
	Sat,  5 Aug 2023 18:50:20 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 5 Aug
 2023 18:52:09 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: pkt_cls: Remove unused inline helpers
Date: Sat, 5 Aug 2023 18:52:08 +0800
Message-ID: <20230805105208.45812-1-yuehaibing@huawei.com>
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

Commit acb674428c3d ("net: sched: introduce per-block callbacks")
implemented these but never used it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/pkt_cls.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 139cd09828af..f308e8268651 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -138,19 +138,6 @@ static inline struct Qdisc *tcf_block_q(struct tcf_block *block)
 	return NULL;
 }
 
-static inline
-int tc_setup_cb_block_register(struct tcf_block *block, flow_setup_cb_t *cb,
-			       void *cb_priv)
-{
-	return 0;
-}
-
-static inline
-void tc_setup_cb_block_unregister(struct tcf_block *block, flow_setup_cb_t *cb,
-				  void *cb_priv)
-{
-}
-
 static inline int tcf_classify(struct sk_buff *skb,
 			       const struct tcf_block *block,
 			       const struct tcf_proto *tp,
-- 
2.34.1


