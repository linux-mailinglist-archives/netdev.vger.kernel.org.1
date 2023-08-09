Return-Path: <netdev+bounces-25897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4226B7761A4
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 15:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B44D1C2121C
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 13:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC29118C3D;
	Wed,  9 Aug 2023 13:50:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F6D612D
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 13:50:32 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC121BF2
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 06:50:31 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RLWbz23SjzVl0s;
	Wed,  9 Aug 2023 21:48:31 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 21:50:26 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next] net: caif: Remove unused declaration cfsrvl_ctrlcmd()
Date: Wed, 9 Aug 2023 21:49:43 +0800
Message-ID: <20230809134943.37844-1-yuehaibing@huawei.com>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 43e369210108 ("caif: Move refcount from service layer to sock and dev.")
declared but never implemented this.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/caif/cfsrvl.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/net/caif/cfsrvl.h b/include/net/caif/cfsrvl.h
index bd5440977f7f..5ee7b322e18b 100644
--- a/include/net/caif/cfsrvl.h
+++ b/include/net/caif/cfsrvl.h
@@ -33,9 +33,6 @@ struct cflayer *cfrfml_create(u8 linkid, struct dev_info *dev_info,
 				int mtu_size);
 struct cflayer *cfdbgl_create(u8 linkid, struct dev_info *dev_info);
 
-void cfsrvl_ctrlcmd(struct cflayer *layr, enum caif_ctrlcmd ctrl,
-		     int phyid);
-
 bool cfsrvl_phyid_match(struct cflayer *layer, int phyid);
 
 void cfsrvl_init(struct cfsrvl *service,
-- 
2.34.1


