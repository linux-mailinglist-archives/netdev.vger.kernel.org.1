Return-Path: <netdev+bounces-25920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EFC7762AF
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617671C20EB5
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5341918B03;
	Wed,  9 Aug 2023 14:40:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467E717752
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:40:15 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1AB210B;
	Wed,  9 Aug 2023 07:40:13 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RLXk85LfDzcbWf;
	Wed,  9 Aug 2023 22:38:56 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 22:40:08 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <santosh.shilimkar@oracle.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>
Subject: [PATCH net-next] rds: rdma: Remove unused declaration rds_rdma_conn_connect()
Date: Wed, 9 Aug 2023 22:40:07 +0800
Message-ID: <20230809144007.28212-1-yuehaibing@huawei.com>
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
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since commit 55b7ed0b582f ("RDS: Common RDMA transport code")
rds_rdma_conn_connect() is never implemented and used.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/rds/rdma_transport.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/rds/rdma_transport.h b/net/rds/rdma_transport.h
index ca4c3a667091..d2fdb1529585 100644
--- a/net/rds/rdma_transport.h
+++ b/net/rds/rdma_transport.h
@@ -17,7 +17,6 @@
  */
 #define RDS_RDMA_REJ_INCOMPAT		1
 
-int rds_rdma_conn_connect(struct rds_connection *conn);
 int rds_rdma_cm_event_handler(struct rdma_cm_id *cm_id,
 			      struct rdma_cm_event *event);
 int rds6_rdma_cm_event_handler(struct rdma_cm_id *cm_id,
-- 
2.34.1


