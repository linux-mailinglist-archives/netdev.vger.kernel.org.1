Return-Path: <netdev+bounces-23296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D304A76B7E0
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A411C20EEB
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D619A4DC69;
	Tue,  1 Aug 2023 14:42:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC77815
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:42:49 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1114B1BD3
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 07:42:48 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RFd9465sxz1GDKg;
	Tue,  1 Aug 2023 22:41:44 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 22:42:45 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jiri@resnulli.us>, <ivecera@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<petrm@nvidia.com>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next] net: switchdev: Remove unused typedef switchdev_obj_dump_cb_t()
Date: Tue, 1 Aug 2023 22:42:09 +0800
Message-ID: <20230801144209.27512-1-yuehaibing@huawei.com>
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

Commit 29ab586c3d83 ("net: switchdev: Remove bridge bypass support from switchdev")
leave this unused.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/switchdev.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 4d324e2a2eef..0294cfec9c37 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -201,8 +201,6 @@ struct switchdev_obj_in_state_mrp {
 #define SWITCHDEV_OBJ_IN_STATE_MRP(OBJ) \
 	container_of((OBJ), struct switchdev_obj_in_state_mrp, obj)
 
-typedef int switchdev_obj_dump_cb_t(struct switchdev_obj *obj);
-
 struct switchdev_brport {
 	struct net_device *dev;
 	const void *ctx;
-- 
2.34.1


