Return-Path: <netdev+bounces-22539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBFD767F13
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 14:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECCE281342
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 12:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1E9156F5;
	Sat, 29 Jul 2023 12:19:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610C83C2A
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 12:19:43 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011513AB4;
	Sat, 29 Jul 2023 05:19:41 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RCk4b6X4jzNm8n;
	Sat, 29 Jul 2023 20:16:15 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 29 Jul
 2023 20:19:39 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <kgraul@linux.ibm.com>, <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>,
	<alibuda@linux.alibaba.com>, <tonylu@linux.alibaba.com>,
	<guwen@linux.alibaba.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net/smc: Remove unused function declarations
Date: Sat, 29 Jul 2023 20:19:29 +0800
Message-ID: <20230729121929.17180-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

commit f9aab6f2ce57 ("net/smc: immediate freeing in smc_lgr_cleanup_early()")
left behind smc_lgr_schedule_free_work_fast() declaration.
And since commit 349d43127dac ("net/smc: fix kernel panic caused by race of smc_sock")
smc_ib_modify_qp_reset() is not used anymore.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/smc/smc_core.h | 1 -
 net/smc/smc_ib.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 1645fba0d2d3..3c1b31bfa1cf 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -539,7 +539,6 @@ int smc_vlan_by_tcpsk(struct socket *clcsock, struct smc_init_info *ini);
 
 void smc_conn_free(struct smc_connection *conn);
 int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini);
-void smc_lgr_schedule_free_work_fast(struct smc_link_group *lgr);
 int smc_core_init(void);
 void smc_core_exit(void);
 
diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
index 034295676e88..4df5f8c8a0a1 100644
--- a/net/smc/smc_ib.h
+++ b/net/smc/smc_ib.h
@@ -96,7 +96,6 @@ void smc_ib_destroy_queue_pair(struct smc_link *lnk);
 int smc_ib_create_queue_pair(struct smc_link *lnk);
 int smc_ib_ready_link(struct smc_link *lnk);
 int smc_ib_modify_qp_rts(struct smc_link *lnk);
-int smc_ib_modify_qp_reset(struct smc_link *lnk);
 int smc_ib_modify_qp_error(struct smc_link *lnk);
 long smc_ib_setup_per_ibdev(struct smc_ib_device *smcibdev);
 int smc_ib_get_memory_region(struct ib_pd *pd, int access_flags,
-- 
2.34.1


