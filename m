Return-Path: <netdev+bounces-25916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E290577629B
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139DD1C2131E
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDEA17755;
	Wed,  9 Aug 2023 14:36:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4E92CA4
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:36:50 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDF21FFA;
	Wed,  9 Aug 2023 07:36:48 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RLXdN75BkzVkwB;
	Wed,  9 Aug 2023 22:34:48 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 22:36:44 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <santosh.shilimkar@oracle.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>
Subject: [PATCH net-next] net/rds: Remove unused function declarations
Date: Wed, 9 Aug 2023 22:36:27 +0800
Message-ID: <20230809143627.34564-1-yuehaibing@huawei.com>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 39de8281791c ("RDS: Main header file") declared but never implemented
rds_trans_init() and rds_trans_exit(), remove it.
Commit d37c9359056f ("RDS: Move loop-only function to loop.c") removed the
implementation rds_message_inc_free() but not the declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/rds/rds.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/rds/rds.h b/net/rds/rds.h
index d35d1fc39807..dc360252c515 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -863,7 +863,6 @@ int rds_message_next_extension(struct rds_header *hdr,
 			       unsigned int *pos, void *buf, unsigned int *buflen);
 int rds_message_add_rdma_dest_extension(struct rds_header *hdr, u32 r_key, u32 offset);
 int rds_message_inc_copy_to_user(struct rds_incoming *inc, struct iov_iter *to);
-void rds_message_inc_free(struct rds_incoming *inc);
 void rds_message_addref(struct rds_message *rm);
 void rds_message_put(struct rds_message *rm);
 void rds_message_wait(struct rds_message *rm);
@@ -1013,7 +1012,5 @@ void rds_trans_put(struct rds_transport *trans);
 unsigned int rds_trans_stats_info_copy(struct rds_info_iterator *iter,
 				       unsigned int avail);
 struct rds_transport *rds_trans_get(int t_type);
-int rds_trans_init(void);
-void rds_trans_exit(void);
 
 #endif
-- 
2.34.1


