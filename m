Return-Path: <netdev+bounces-23157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75A776B330
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88FD21C20EA7
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694B720FA7;
	Tue,  1 Aug 2023 11:27:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6A61DDFF
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:27:18 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF71A9B
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:27:16 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RFXmp0bsDztRh9;
	Tue,  1 Aug 2023 19:23:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 19:27:14 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
	<jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <netdev@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v2] octeontx2: Remove unnecessary ternary operators
Date: Tue, 1 Aug 2023 19:26:38 +0800
Message-ID: <20230801112638.317149-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There are a little ternary operators, the true or false judgement
of which is unnecessary in C language semantics. So remove it
to clean Code.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2:
- Fix the subject prefix and commit message issue.
---
 drivers/net/ethernet/marvell/octeontx2/af/ptp.c      | 4 ++--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
index 0ee420a489fc..c55c2c441a1a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
@@ -61,12 +61,12 @@ static const struct pci_device_id ptp_id_table[];
 
 static bool is_ptp_dev_cnf10kb(struct ptp *ptp)
 {
-	return (ptp->pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_B_PTP) ? true : false;
+	return ptp->pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_B_PTP;
 }
 
 static bool is_ptp_dev_cn10k(struct ptp *ptp)
 {
-	return (ptp->pdev->device == PCI_DEVID_CN10K_PTP) ? true : false;
+	return ptp->pdev->device == PCI_DEVID_CN10K_PTP;
 }
 
 static bool cn10k_ptp_errata(struct ptp *ptp)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 9551b422622a..61f62a6ec662 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2027,7 +2027,7 @@ u16 otx2_select_queue(struct net_device *netdev, struct sk_buff *skb,
 #endif
 	int txq;
 
-	qos_enabled = (netdev->real_num_tx_queues > pf->hw.tx_queues) ? true : false;
+	qos_enabled = netdev->real_num_tx_queues > pf->hw.tx_queues;
 	if (unlikely(qos_enabled)) {
 		/* This smp_load_acquire() pairs with smp_store_release() in
 		 * otx2_qos_root_add() called from htb offload root creation
-- 
2.34.1


