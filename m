Return-Path: <netdev+bounces-25906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B9C776238
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0870E281BEF
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0248E19BAF;
	Wed,  9 Aug 2023 14:18:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4BA612D
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:18:15 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE08A1FF7;
	Wed,  9 Aug 2023 07:18:14 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RLXD06YcmzVkqv;
	Wed,  9 Aug 2023 22:16:16 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 22:18:11 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <santosh.shilimkar@oracle.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>
Subject: [PATCH net-next] RDS: IB: Remove unused declarations
Date: Wed, 9 Aug 2023 22:18:06 +0800
Message-ID: <20230809141806.46476-1-yuehaibing@huawei.com>
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

Commit f4f943c958a2 ("RDS: IB: ack more receive completions to improve performance")
removed rds_ib_recv_tasklet_fn() implementation but not the declaration.
And commit ec16227e1414 ("RDS/IB: Infiniband transport") declared but never implemented
the other functions.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/rds/ib.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/rds/ib.h b/net/rds/ib.h
index 2ba71102b1f1..8ef3178ed4d6 100644
--- a/net/rds/ib.h
+++ b/net/rds/ib.h
@@ -369,9 +369,6 @@ int rds_ib_conn_alloc(struct rds_connection *conn, gfp_t gfp);
 void rds_ib_conn_free(void *arg);
 int rds_ib_conn_path_connect(struct rds_conn_path *cp);
 void rds_ib_conn_path_shutdown(struct rds_conn_path *cp);
-void rds_ib_state_change(struct sock *sk);
-int rds_ib_listen_init(void);
-void rds_ib_listen_stop(void);
 __printf(2, 3)
 void __rds_ib_conn_error(struct rds_connection *conn, const char *, ...);
 int rds_ib_cm_handle_connect(struct rdma_cm_id *cm_id,
@@ -402,7 +399,6 @@ void rds_ib_inc_free(struct rds_incoming *inc);
 int rds_ib_inc_copy_to_user(struct rds_incoming *inc, struct iov_iter *to);
 void rds_ib_recv_cqe_handler(struct rds_ib_connection *ic, struct ib_wc *wc,
 			     struct rds_ib_ack_state *state);
-void rds_ib_recv_tasklet_fn(unsigned long data);
 void rds_ib_recv_init_ring(struct rds_ib_connection *ic);
 void rds_ib_recv_clear_ring(struct rds_ib_connection *ic);
 void rds_ib_recv_init_ack(struct rds_ib_connection *ic);
-- 
2.34.1


