Return-Path: <netdev+bounces-24996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C768D7727D2
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB902813EB
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4D611192;
	Mon,  7 Aug 2023 14:32:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0704111A4
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 14:32:24 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D194AF0
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 07:32:22 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKJc71GwQz1Z1Wb;
	Mon,  7 Aug 2023 22:29:27 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:32:15 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jiri@resnulli.us>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH net-next] devlink: Remove unused devlink_dpipe_table_resource_set() declaration
Date: Mon, 7 Aug 2023 22:32:14 +0800
Message-ID: <20230807143214.46648-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit f6b19b354d50 ("net: devlink: select NET_DEVLINK from drivers")
removed this but leave the declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/devlink.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index a1a8e1b6e7df..f7fec0791acc 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1743,9 +1743,6 @@ int devl_resource_size_get(struct devlink *devlink,
 int devl_dpipe_table_resource_set(struct devlink *devlink,
 				  const char *table_name, u64 resource_id,
 				  u64 resource_units);
-int devlink_dpipe_table_resource_set(struct devlink *devlink,
-				     const char *table_name, u64 resource_id,
-				     u64 resource_units);
 void devl_resource_occ_get_register(struct devlink *devlink,
 				    u64 resource_id,
 				    devlink_resource_occ_get_t *occ_get,
-- 
2.34.1


