Return-Path: <netdev+bounces-23293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BC176B7CD
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FAB1C21075
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAAB1B149;
	Tue,  1 Aug 2023 14:35:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008D1B146
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:35:08 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC041FCB;
	Tue,  1 Aug 2023 07:35:03 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RFd073ts2z1GDG0;
	Tue,  1 Aug 2023 22:33:59 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 22:35:00 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <paul@paul-moore.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: [PATCH net-next] netlabel: Remove unused declaration netlbl_cipsov4_doi_free()
Date: Tue, 1 Aug 2023 22:34:53 +0800
Message-ID: <20230801143453.24452-1-yuehaibing@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since commit b1edeb102397 ("netlabel: Replace protocol/NetLabel linking with refrerence counts")
this declaration is unused and can be removed.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/netlabel/netlabel_cipso_v4.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/netlabel/netlabel_cipso_v4.h b/net/netlabel/netlabel_cipso_v4.h
index 85d7ecb05728..9518ab56ec98 100644
--- a/net/netlabel/netlabel_cipso_v4.h
+++ b/net/netlabel/netlabel_cipso_v4.h
@@ -149,7 +149,4 @@ enum {
 /* NetLabel protocol functions */
 int netlbl_cipsov4_genl_init(void);
 
-/* Free the memory associated with a CIPSOv4 DOI definition */
-void netlbl_cipsov4_doi_free(struct rcu_head *entry);
-
 #endif
-- 
2.34.1


