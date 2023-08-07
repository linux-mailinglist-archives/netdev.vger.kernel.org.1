Return-Path: <netdev+bounces-24991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87B9772789
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB701C20B87
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 14:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D241096C;
	Mon,  7 Aug 2023 14:21:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1FD10957
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 14:21:20 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F79DA4
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 07:21:19 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKJLh6gJqzNmm1;
	Mon,  7 Aug 2023 22:17:48 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:21:16 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next] net: fq: Remove unused typedef fq_flow_get_default_t
Date: Mon, 7 Aug 2023 22:21:11 +0800
Message-ID: <20230807142111.33524-1-yuehaibing@huawei.com>
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

Commitbf9009bf21b5 ("net/fq_impl: drop get_default_func, move default flow to fq_tin")
remove its last user, so can remove it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/fq.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/net/fq.h b/include/net/fq.h
index 07b5aff6ec58..99fbe4127b95 100644
--- a/include/net/fq.h
+++ b/include/net/fq.h
@@ -98,9 +98,4 @@ typedef bool fq_skb_filter_t(struct fq *,
 			     struct sk_buff *,
 			     void *);
 
-typedef struct fq_flow *fq_flow_get_default_t(struct fq *,
-					      struct fq_tin *,
-					      int idx,
-					      struct sk_buff *);
-
 #endif
-- 
2.34.1


