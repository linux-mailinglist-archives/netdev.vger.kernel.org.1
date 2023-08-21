Return-Path: <netdev+bounces-29335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78087782AFB
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 15:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A844D1C20908
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAAC7481;
	Mon, 21 Aug 2023 13:53:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1A7747F
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 13:53:26 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B0DD7
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 06:53:02 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RTv2x0yDPzNn2v;
	Mon, 21 Aug 2023 21:48:57 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 21 Aug
 2023 21:52:30 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <drivers@pensando.io>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next] ionic: Remove unused declarations
Date: Mon, 21 Aug 2023 21:47:17 +0800
Message-ID: <20230821134717.51936-1-yuehaibing@huawei.com>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit fbfb8031533c ("ionic: Add hardware init and device commands")
declared but never implemented ionic_q_rewind()/ionic_set_dma_mask().
Commit 969f84394604 ("ionic: sync the filters in the work task")
declared but never implemented ionic_rx_filters_need_sync().

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/pensando/ionic/ionic.h           | 1 -
 drivers/net/ethernet/pensando/ionic/ionic_dev.h       | 1 -
 drivers/net/ethernet/pensando/ionic/ionic_rx_filter.h | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
index 602f4d45d529..2453a40f6ee8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic.h
@@ -81,7 +81,6 @@ int ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_wait);
 int ionic_dev_cmd_wait_nomsg(struct ionic *ionic, unsigned long max_wait);
 void ionic_dev_cmd_dev_err_print(struct ionic *ionic, u8 opcode, u8 status,
 				 int err);
-int ionic_set_dma_mask(struct ionic *ionic);
 int ionic_setup(struct ionic *ionic);
 
 int ionic_identify(struct ionic *ionic);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 0bea208bfba2..6aac98bcb9f4 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -376,7 +376,6 @@ void ionic_q_cmb_map(struct ionic_queue *q, void __iomem *base, dma_addr_t base_
 void ionic_q_sg_map(struct ionic_queue *q, void *base, dma_addr_t base_pa);
 void ionic_q_post(struct ionic_queue *q, bool ring_doorbell, ionic_desc_cb cb,
 		  void *cb_arg);
-void ionic_q_rewind(struct ionic_queue *q, struct ionic_desc_info *start);
 void ionic_q_service(struct ionic_queue *q, struct ionic_cq_info *cq_info,
 		     unsigned int stop_index);
 int ionic_heartbeat_check(struct ionic *ionic);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.h b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.h
index 87b2666f248b..ee9e99cd1b5e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.h
@@ -43,7 +43,6 @@ struct ionic_rx_filter *ionic_rx_filter_by_addr(struct ionic_lif *lif, const u8
 struct ionic_rx_filter *ionic_rx_filter_rxsteer(struct ionic_lif *lif);
 void ionic_rx_filter_sync(struct ionic_lif *lif);
 int ionic_lif_list_addr(struct ionic_lif *lif, const u8 *addr, bool mode);
-int ionic_rx_filters_need_sync(struct ionic_lif *lif);
 int ionic_lif_vlan_add(struct ionic_lif *lif, const u16 vid);
 int ionic_lif_vlan_del(struct ionic_lif *lif, const u16 vid);
 
-- 
2.34.1


