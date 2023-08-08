Return-Path: <netdev+bounces-25454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0786377423F
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E891A1C20E5A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6723A14F75;
	Tue,  8 Aug 2023 17:38:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC8D14F6D
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 17:38:03 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA2217D490
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 10:26:18 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RKxD436dwz1GDTf;
	Tue,  8 Aug 2023 22:59:16 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 23:00:26 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jiri@resnulli.us>, <ivecera@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<petrm@nvidia.com>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next] net: switchdev: Remove unused declaration switchdev_port_fwd_mark_set()
Date: Tue, 8 Aug 2023 22:59:55 +0800
Message-ID: <20230808145955.2176-1-yuehaibing@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 6bc506b4fb06 ("bridge: switchdev: Add forward mark support for stacked devices")
removed the implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/switchdev.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 0294cfec9c37..a43062d4c734 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -326,10 +326,6 @@ int call_switchdev_blocking_notifiers(unsigned long val, struct net_device *dev,
 				      struct switchdev_notifier_info *info,
 				      struct netlink_ext_ack *extack);
 
-void switchdev_port_fwd_mark_set(struct net_device *dev,
-				 struct net_device *group_dev,
-				 bool joining);
-
 int switchdev_handle_fdb_event_to_device(struct net_device *dev, unsigned long event,
 		const struct switchdev_notifier_fdb_info *fdb_info,
 		bool (*check_cb)(const struct net_device *dev),
-- 
2.34.1


