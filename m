Return-Path: <netdev+bounces-23291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A5576B7B8
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBF6281B96
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900C437370;
	Tue,  1 Aug 2023 14:32:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832C13736D
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:32:34 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663BA2103
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 07:32:03 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RFcsW4yS9ztRg2;
	Tue,  1 Aug 2023 22:28:15 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 22:31:36 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next] ila: Remove unnecessary file net/ila.h
Date: Tue, 1 Aug 2023 22:31:29 +0800
Message-ID: <20230801143129.40652-1-yuehaibing@huawei.com>
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
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 642c2c95585d ("ila: xlat changes") removed ila_xlat_outgoing()
and ila_xlat_incoming() functions, then this file became unnecessary.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/ila.h       | 16 ----------------
 net/ipv6/ila/ila_main.c |  1 -
 net/ipv6/ila/ila_xlat.c |  1 -
 3 files changed, 18 deletions(-)
 delete mode 100644 include/net/ila.h

diff --git a/include/net/ila.h b/include/net/ila.h
deleted file mode 100644
index 73ebe5eab272..000000000000
--- a/include/net/ila.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * ILA kernel interface
- *
- * Copyright (c) 2015 Tom Herbert <tom@herbertland.com>
- */
-
-#ifndef _NET_ILA_H
-#define _NET_ILA_H
-
-struct sk_buff;
-
-int ila_xlat_outgoing(struct sk_buff *skb);
-int ila_xlat_incoming(struct sk_buff *skb);
-
-#endif /* _NET_ILA_H */
diff --git a/net/ipv6/ila/ila_main.c b/net/ipv6/ila/ila_main.c
index 3faf62530d6a..69caed07315f 100644
--- a/net/ipv6/ila/ila_main.c
+++ b/net/ipv6/ila/ila_main.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <net/genetlink.h>
-#include <net/ila.h>
 #include <net/netns/generic.h>
 #include <uapi/linux/genetlink.h>
 #include "ila.h"
diff --git a/net/ipv6/ila/ila_xlat.c b/net/ipv6/ila/ila_xlat.c
index bee45dfeb187..67e8c9440977 100644
--- a/net/ipv6/ila/ila_xlat.c
+++ b/net/ipv6/ila/ila_xlat.c
@@ -5,7 +5,6 @@
 #include <linux/rhashtable.h>
 #include <linux/vmalloc.h>
 #include <net/genetlink.h>
-#include <net/ila.h>
 #include <net/netns/generic.h>
 #include <uapi/linux/genetlink.h>
 #include "ila.h"
-- 
2.34.1


