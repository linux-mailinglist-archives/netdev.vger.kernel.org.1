Return-Path: <netdev+bounces-220264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A86B45179
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B86A5A2BD0
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 08:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EF83126DD;
	Fri,  5 Sep 2025 08:29:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A593112DF;
	Fri,  5 Sep 2025 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060962; cv=none; b=TMldezOgDu0KNvHAKZACBwn8bEQxQavazJjtgBdSTa4V1mWL1+97dI3/KkZfg4qeVuBilDg/rcUmuMaa6nwFwqUFEZFlbFlLYP59dQ0DXqwMzTsbiN6yDhumXzGtcLeEiaIVm5ojLcs8xH9XhM0dw97sa5t6jT6H1bLZQkb35O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060962; c=relaxed/simple;
	bh=1dpY5rrx/KQQ7MFnbktR5mrQt1+y3qjUhCGENSPzb6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Py3T7DBj0LJm7urC7yVCyVf+Jf+6XmR50jQ/xEDqhr0cYc/s3dHfaPFpOxaGPMC/ynUcStwyuqfVMwDzFeIhpfY1Ljyj6pYZr2Asf04IW00ZrhlZ+D99NxL8YR6nBrE5pL+8Gl5BCWomS8HywP6uLnJjittB4lhVPbnQj9ESe9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cJ8ZK5798z1R99p;
	Fri,  5 Sep 2025 16:26:17 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id F079F140279;
	Fri,  5 Sep 2025 16:29:17 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Sep 2025 16:29:16 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>, Meny Yossefi
	<meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>, Lee Trager
	<lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Suman Ghosh <sumang@marvell.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v04 10/14] hinic3: Tx & Rx configuration
Date: Fri, 5 Sep 2025 16:28:44 +0800
Message-ID: <72048beed5c95d1c1c7437e57a09ccf2355f2014.1757057860.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1757057860.git.zhuyikai1@h-partners.com>
References: <cover.1757057860.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Configure Tx & Rx queue common attributes.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../huawei/hinic3/hinic3_mgmt_interface.h     | 15 +++++
 .../huawei/hinic3/hinic3_netdev_ops.c         | 56 +++++++++++++++-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 25 ++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  2 +
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    | 64 +++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  2 +
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    | 32 ++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |  2 +
 8 files changed, 197 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
index b891290a3d6e..20d37670e133 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
@@ -75,6 +75,21 @@ struct l2nic_cmd_force_pkt_drop {
 	u8                   rsvd1[3];
 };
 
+struct l2nic_cmd_set_dcb_state {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	/* 0 - get dcb state, 1 - set dcb state */
+	u8                   op_code;
+	/* 0 - disable, 1 - enable dcb */
+	u8                   state;
+	/* 0 - disable, 1 - enable dcb */
+	u8                   port_state;
+	u8                   rsvd[7];
+};
+
+/* IEEE 802.1Qaz std */
+#define L2NIC_DCB_COS_MAX     0x8
+
 /* Commands between NIC to fw */
 enum l2nic_cmd {
 	/* FUNC CFG */
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index 2c5c7051e72e..cc0a1c2eb681 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -183,6 +183,47 @@ static void hinic3_free_txrxq_resources(struct net_device *netdev,
 	q_params->txqs_res = NULL;
 }
 
+static int hinic3_configure_txrxqs(struct net_device *netdev,
+				   struct hinic3_dyna_txrxq_params *q_params)
+{
+	int err;
+
+	err = hinic3_configure_txqs(netdev, q_params->num_qps,
+				    q_params->sq_depth, q_params->txqs_res);
+	if (err) {
+		netdev_err(netdev, "Failed to configure txqs\n");
+		return err;
+	}
+
+	err = hinic3_configure_rxqs(netdev, q_params->num_qps,
+				    q_params->rq_depth, q_params->rxqs_res);
+	if (err) {
+		netdev_err(netdev, "Failed to configure rxqs\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int hinic3_configure(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	netdev->min_mtu = HINIC3_MIN_MTU_SIZE;
+	netdev->max_mtu = HINIC3_MAX_JUMBO_FRAME_SIZE;
+	err = hinic3_set_port_mtu(netdev, netdev->mtu);
+	if (err) {
+		netdev_err(netdev, "Failed to set mtu\n");
+		return err;
+	}
+
+	/* Ensure DCB is disabled */
+	hinic3_sync_dcb_state(nic_dev->hwdev, 1, 0);
+
+	return 0;
+}
+
 static int hinic3_alloc_channel_resources(struct net_device *netdev,
 					  struct hinic3_dyna_qp_params *qp_params,
 					  struct hinic3_dyna_txrxq_params *trxq_params)
@@ -231,14 +272,28 @@ static int hinic3_open_channel(struct net_device *netdev)
 		return err;
 	}
 
+	err = hinic3_configure_txrxqs(netdev, &nic_dev->q_params);
+	if (err) {
+		netdev_err(netdev, "Failed to configure txrxqs\n");
+		goto err_free_qp_ctxts;
+	}
+
 	err = hinic3_qps_irq_init(netdev);
 	if (err) {
 		netdev_err(netdev, "Failed to init txrxq irq\n");
 		goto err_free_qp_ctxts;
 	}
 
+	err = hinic3_configure(netdev);
+	if (err) {
+		netdev_err(netdev, "Failed to init txrxq irq\n");
+		goto err_uninit_qps_irq;
+	}
+
 	return 0;
 
+err_uninit_qps_irq:
+	hinic3_qps_irq_uninit(netdev);
 err_free_qp_ctxts:
 	hinic3_free_qp_ctxts(nic_dev);
 
@@ -287,7 +342,6 @@ static int hinic3_open(struct net_device *netdev)
 err_uninit_qps:
 	hinic3_uninit_qps(nic_dev, &qp_params);
 	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
-
 err_destroy_num_qps:
 	hinic3_destroy_num_qps(netdev);
 err_free_nicio_res:
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index 5b18764781d4..ed70750f5ae8 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -289,3 +289,28 @@ int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev)
 
 	return pkt_drop.msg_head.status;
 }
+
+int hinic3_sync_dcb_state(struct hinic3_hwdev *hwdev, u8 op_code, u8 state)
+{
+	struct l2nic_cmd_set_dcb_state dcb_state = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	dcb_state.op_code = op_code;
+	dcb_state.state = state;
+	dcb_state.func_id = hinic3_global_func_id(hwdev);
+
+	mgmt_msg_params_init_default(&msg_params, &dcb_state,
+				     sizeof(dcb_state));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_QOS_DCB_STATE, &msg_params);
+	if (err || dcb_state.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set dcb state, err: %d, status: 0x%x\n",
+			err, dcb_state.head.status);
+		return -EFAULT;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
index dd1615745f02..719b81e2bc2a 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
@@ -52,4 +52,6 @@ int hinic3_set_ci_table(struct hinic3_hwdev *hwdev,
 			struct hinic3_sq_attr *attr);
 int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev);
 
+int hinic3_sync_dcb_state(struct hinic3_hwdev *hwdev, u8 op_code, u8 state);
+
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
index e81f7c19bf63..6cfe3bdd8ee5 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
@@ -85,6 +85,27 @@ static int rx_alloc_mapped_page(struct page_pool *page_pool,
 	return 0;
 }
 
+/* Associate fixed completion element to every wqe in the rq. Every rq wqe will
+ * always post completion to the same place.
+ */
+static void rq_associate_cqes(struct hinic3_rxq *rxq)
+{
+	struct hinic3_queue_pages *qpages;
+	struct hinic3_rq_wqe *rq_wqe;
+	dma_addr_t cqe_dma;
+	u32 i;
+
+	qpages = &rxq->rq->wq.qpages;
+
+	for (i = 0; i < rxq->q_depth; i++) {
+		rq_wqe = get_q_element(qpages, i, NULL);
+		cqe_dma = rxq->cqe_start_paddr +
+			  i * sizeof(struct hinic3_rq_cqe);
+		rq_wqe->cqe_hi_addr = cpu_to_le32(upper_32_bits(cqe_dma));
+		rq_wqe->cqe_lo_addr = cpu_to_le32(lower_32_bits(cqe_dma));
+	}
+}
+
 static void rq_wqe_buf_set(struct hinic3_io_queue *rq, uint32_t wqe_idx,
 			   dma_addr_t dma_addr, u16 len)
 {
@@ -445,6 +466,49 @@ void hinic3_free_rxqs_res(struct net_device *netdev, u16 num_rq,
 	}
 }
 
+int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
+			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_rxq_res *rqres;
+	struct msix_entry *msix_entry;
+	struct hinic3_rxq *rxq;
+	u16 q_id;
+	u32 pkts;
+
+	for (q_id = 0; q_id < num_rq; q_id++) {
+		rxq = &nic_dev->rxqs[q_id];
+		rqres = &rxqs_res[q_id];
+		msix_entry = &nic_dev->qps_msix_entries[q_id];
+
+		rxq->irq_id = msix_entry->vector;
+		rxq->msix_entry_idx = msix_entry->entry;
+		rxq->next_to_update = 0;
+		rxq->next_to_alloc = rqres->next_to_alloc;
+		rxq->q_depth = rq_depth;
+		rxq->delta = rxq->q_depth;
+		rxq->q_mask = rxq->q_depth - 1;
+		rxq->cons_idx = 0;
+
+		rxq->cqe_arr = rqres->cqe_start_vaddr;
+		rxq->cqe_start_paddr = rqres->cqe_start_paddr;
+		rxq->rx_info = rqres->rx_info;
+		rxq->page_pool = rqres->page_pool;
+
+		rxq->rq = &nic_dev->nic_io->rq[rxq->q_id];
+
+		rq_associate_cqes(rxq);
+
+		pkts = hinic3_rx_fill_buffers(rxq);
+		if (!pkts) {
+			netdev_err(netdev, "Failed to fill Rx buffer\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
 int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(rxq->netdev);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
index ec3f45c3688a..44ae841a3648 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
@@ -97,6 +97,8 @@ int hinic3_alloc_rxqs_res(struct net_device *netdev, u16 num_rq,
 			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res);
 void hinic3_free_rxqs_res(struct net_device *netdev, u16 num_rq,
 			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res);
+int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
+			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res);
 int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index 3c63fe071999..dea882260b11 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -702,6 +702,38 @@ void hinic3_free_txqs_res(struct net_device *netdev, u16 num_sq,
 	}
 }
 
+int hinic3_configure_txqs(struct net_device *netdev, u16 num_sq,
+			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_txq_res *tqres;
+	struct hinic3_txq *txq;
+	u16 q_id;
+	u32 idx;
+
+	for (q_id = 0; q_id < num_sq; q_id++) {
+		txq = &nic_dev->txqs[q_id];
+		tqres = &txqs_res[q_id];
+
+		txq->q_depth = sq_depth;
+		txq->q_mask = sq_depth - 1;
+
+		txq->tx_stop_thrs = min(HINIC3_DEFAULT_STOP_THRS,
+					sq_depth / 20);
+		txq->tx_start_thrs = min(HINIC3_DEFAULT_START_THRS,
+					 sq_depth / 10);
+
+		txq->tx_info = tqres->tx_info;
+		for (idx = 0; idx < sq_depth; idx++)
+			txq->tx_info[idx].dma_info =
+				&tqres->bds[idx * HINIC3_BDS_PER_SQ_WQEBB];
+
+		txq->sq = &nic_dev->nic_io->sq[q_id];
+	}
+
+	return 0;
+}
+
 bool hinic3_tx_poll(struct hinic3_txq *txq, int budget)
 {
 	struct net_device *netdev = txq->netdev;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
index 9ec6968b6688..7e1b872ba752 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
@@ -137,6 +137,8 @@ int hinic3_alloc_txqs_res(struct net_device *netdev, u16 num_sq,
 			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res);
 void hinic3_free_txqs_res(struct net_device *netdev, u16 num_sq,
 			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res);
+int hinic3_configure_txqs(struct net_device *netdev, u16 num_sq,
+			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res);
 
 netdev_tx_t hinic3_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
 bool hinic3_tx_poll(struct hinic3_txq *txq, int budget);
-- 
2.43.0


