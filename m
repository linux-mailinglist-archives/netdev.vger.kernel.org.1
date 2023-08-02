Return-Path: <netdev+bounces-23506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF3D76C3AD
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 05:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671A31C21187
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 03:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C6AED7;
	Wed,  2 Aug 2023 03:47:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4075EC6
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 03:47:58 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5A01BCC
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 20:47:54 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RFyZx4PDPzrS1M;
	Wed,  2 Aug 2023 11:46:49 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 11:47:51 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jmaloy@redhat.com>, <ying.xue@windriver.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<yuehaibing@huawei.com>, <lucien.xin@gmail.com>
CC: <netdev@vger.kernel.org>, <tipc-discussion@lists.sourceforge.net>
Subject: [PATCH net-next] tipc: Remove unused function declarations
Date: Wed, 2 Aug 2023 11:46:59 +0800
Message-ID: <20230802034659.39840-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit d50ccc2d3909 ("tipc: add 128-bit node identifier") declared but never
implemented tipc_node_id2hash().
Also commit 5c216e1d28c8 ("tipc: Allow run-time alteration of default link settings")
never implemented tipc_media_set_priority() and tipc_media_set_window(),
commit cad2929dc432 ("tipc: update a binding service via broadcast") only declared
tipc_named_bcast().

Since commit be07f056396d ("tipc: simplify the finalize work queue")
tipc_sched_net_finalize() is removed and declaration is unused.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/tipc/addr.h       | 1 -
 net/tipc/bearer.h     | 2 --
 net/tipc/name_distr.h | 1 -
 net/tipc/net.h        | 1 -
 4 files changed, 5 deletions(-)

diff --git a/net/tipc/addr.h b/net/tipc/addr.h
index 0772cfadaa0d..93f82398283d 100644
--- a/net/tipc/addr.h
+++ b/net/tipc/addr.h
@@ -131,6 +131,5 @@ bool tipc_in_scope(bool legacy_format, u32 domain, u32 addr);
 void tipc_set_node_id(struct net *net, u8 *id);
 void tipc_set_node_addr(struct net *net, u32 addr);
 char *tipc_nodeid2string(char *str, u8 *id);
-u32 tipc_node_id2hash(u8 *id128);
 
 #endif
diff --git a/net/tipc/bearer.h b/net/tipc/bearer.h
index 1ee60649bd17..41eac1ee0c09 100644
--- a/net/tipc/bearer.h
+++ b/net/tipc/bearer.h
@@ -214,8 +214,6 @@ int tipc_nl_media_get(struct sk_buff *skb, struct genl_info *info);
 int tipc_nl_media_set(struct sk_buff *skb, struct genl_info *info);
 int __tipc_nl_media_set(struct sk_buff *skb, struct genl_info *info);
 
-int tipc_media_set_priority(const char *name, u32 new_value);
-int tipc_media_set_window(const char *name, u32 new_value);
 int tipc_media_addr_printf(char *buf, int len, struct tipc_media_addr *a);
 int tipc_enable_l2_media(struct net *net, struct tipc_bearer *b,
 			 struct nlattr *attrs[]);
diff --git a/net/tipc/name_distr.h b/net/tipc/name_distr.h
index e231e6964d61..c677f6f082df 100644
--- a/net/tipc/name_distr.h
+++ b/net/tipc/name_distr.h
@@ -67,7 +67,6 @@ struct distr_item {
 	__be32 key;
 };
 
-void tipc_named_bcast(struct net *net, struct sk_buff *skb);
 struct sk_buff *tipc_named_publish(struct net *net, struct publication *publ);
 struct sk_buff *tipc_named_withdraw(struct net *net, struct publication *publ);
 void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities);
diff --git a/net/tipc/net.h b/net/tipc/net.h
index d0c91d2df20a..1cb1e43cf34a 100644
--- a/net/tipc/net.h
+++ b/net/tipc/net.h
@@ -43,7 +43,6 @@ extern const struct nla_policy tipc_nl_net_policy[];
 
 int tipc_net_init(struct net *net, u8 *node_id, u32 addr);
 void tipc_net_finalize_work(struct work_struct *work);
-void tipc_sched_net_finalize(struct net *net, u32 addr);
 void tipc_net_stop(struct net *net);
 int tipc_nl_net_dump(struct sk_buff *skb, struct netlink_callback *cb);
 int tipc_nl_net_set(struct sk_buff *skb, struct genl_info *info);
-- 
2.34.1


