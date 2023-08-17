Return-Path: <netdev+bounces-28334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B825177F132
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99351C21154
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 07:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7FB2115;
	Thu, 17 Aug 2023 07:30:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA236AAA
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 07:30:49 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A44D1FC8
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 00:30:47 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRGmJ4T4mzNnBK;
	Thu, 17 Aug 2023 15:27:12 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 15:30:44 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <netdev@vger.kernel.org>, Mirko Lindner <mlindner@marvell.com>, Stephen
 Hemminger <stephen@networkplumber.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next] sky2: Remove redundant NULL check for debugfs_create_dir
Date: Thu, 17 Aug 2023 15:30:17 +0800
Message-ID: <20230817073017.350002-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since debugfs_create_dir() returns ERR_PTR, IS_ERR() is enough to
check whether the directory is successfully created. So remove the
redundant NULL check.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/marvell/sky2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index c4cca27fb0d5..07720841a8d7 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -4528,7 +4528,7 @@ static __init void sky2_debug_init(void)
 	struct dentry *ent;
 
 	ent = debugfs_create_dir("sky2", NULL);
-	if (!ent || IS_ERR(ent))
+	if (IS_ERR(ent))
 		return;
 
 	sky2_debug = ent;
-- 
2.34.1


