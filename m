Return-Path: <netdev+bounces-172906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E57A56700
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D78223B2885
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD6D2153EC;
	Fri,  7 Mar 2025 11:45:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F6F20FA99;
	Fri,  7 Mar 2025 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347940; cv=none; b=sbcGEXg4pO9E/tAtUGtvJk9kH9EV/zzoS0OulNgEcUOQr5g4dz14r5/J/lKqK/7nBkmktqzBDKhoFgSB1eOOT1H6DQmcSojexXMqgfMFezgqrM7VW4oU/jasjQb7pf7pt2/sy+DaJzBWRl55Y1DnBuAWAIgajP5aIoWXvChQOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347940; c=relaxed/simple;
	bh=W0ObQu17V1jFy1AeEjYyEQLfOct3nZd2Yuh1cnkkFNA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d5X2bJeWy8y7IntZsOxo0LmEEQUdtrdBui8YUO/wI5wAOJAeLAKzy4dYepeQ9oEiavNcweeRk8/vl0s0Yx5KBQao/uQqWOdBpUyTBfHBxw5hyi3tZJtnHUIpd81gLNOnPB0eKKiJtxvL1/X7p0DBO+L/21xqaBG44qka2ch3Ilc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Z8PWL2Klhz1f053;
	Fri,  7 Mar 2025 19:41:18 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 274941402C4;
	Fri,  7 Mar 2025 19:45:34 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Mar 2025 19:45:33 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next] net: hns3: use string choices helper
Date: Fri, 7 Mar 2025 19:37:33 +0800
Message-ID: <20250307113733.819448-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Jian Shen <shenjian15@huawei.com>

Use string choices helper for better readability.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 24 ++++---
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  3 +-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 63 +++++++++----------
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 10 +--
 .../hisilicon/hns3/hns3pf/hclge_ptp.c         |  3 +-
 5 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 9bbece25552b..09749e9f7398 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -3,6 +3,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/device.h>
+#include <linux/string_choices.h>
 
 #include "hnae3.h"
 #include "hns3_debugfs.h"
@@ -661,12 +662,14 @@ static void hns3_dump_rx_queue_info(struct hns3_enet_ring *ring,
 		HNS3_RING_RX_RING_PKTNUM_RECORD_REG));
 	sprintf(result[j++], "%u", ring->rx_copybreak);
 
-	sprintf(result[j++], "%s", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_EN_REG) ? "on" : "off");
+	sprintf(result[j++], "%s",
+		str_on_off(readl_relaxed(ring->tqp->io_base +
+					 HNS3_RING_EN_REG)));
 
 	if (hnae3_ae_dev_tqp_txrx_indep_supported(ae_dev))
-		sprintf(result[j++], "%s", readl_relaxed(ring->tqp->io_base +
-			HNS3_RING_RX_EN_REG) ? "on" : "off");
+		sprintf(result[j++], "%s",
+			str_on_off(readl_relaxed(ring->tqp->io_base +
+						 HNS3_RING_RX_EN_REG)));
 	else
 		sprintf(result[j++], "%s", "NA");
 
@@ -764,12 +767,14 @@ static void hns3_dump_tx_queue_info(struct hns3_enet_ring *ring,
 	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
 		HNS3_RING_TX_RING_PKTNUM_RECORD_REG));
 
-	sprintf(result[j++], "%s", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_EN_REG) ? "on" : "off");
+	sprintf(result[j++], "%s",
+		str_on_off(readl_relaxed(ring->tqp->io_base +
+					 HNS3_RING_EN_REG)));
 
 	if (hnae3_ae_dev_tqp_txrx_indep_supported(ae_dev))
-		sprintf(result[j++], "%s", readl_relaxed(ring->tqp->io_base +
-			HNS3_RING_TX_EN_REG) ? "on" : "off");
+		sprintf(result[j++], "%s",
+			str_on_off(readl_relaxed(ring->tqp->io_base +
+						 HNS3_RING_TX_EN_REG)));
 	else
 		sprintf(result[j++], "%s", "NA");
 
@@ -1030,7 +1035,6 @@ static void
 hns3_dbg_dev_caps(struct hnae3_handle *h, char *buf, int len, int *pos)
 {
 	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(h->pdev);
-	const char * const str[] = {"no", "yes"};
 	unsigned long *caps = ae_dev->caps;
 	u32 i, state;
 
@@ -1039,7 +1043,7 @@ hns3_dbg_dev_caps(struct hnae3_handle *h, char *buf, int len, int *pos)
 	for (i = 0; i < ARRAY_SIZE(hns3_dbg_cap); i++) {
 		state = test_bit(hns3_dbg_cap[i].cap_bit, caps);
 		*pos += scnprintf(buf + *pos, len - *pos, "%s: %s\n",
-				  hns3_dbg_cap[i].name, str[state]);
+				  hns3_dbg_cap[i].name, str_yes_no(state));
 	}
 
 	*pos += scnprintf(buf + *pos, len - *pos, "\n");
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index b771a2daba43..6715222aeb66 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -3,6 +3,7 @@
 
 #include <linux/etherdevice.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/phy.h>
 #include <linux/sfp.h>
 
@@ -1198,7 +1199,7 @@ static int hns3_set_tx_push(struct net_device *netdev, u32 tx_push)
 		return 0;
 
 	netdev_dbg(netdev, "Changing tx push from %s to %s\n",
-		   old_state ? "on" : "off", tx_push ? "on" : "off");
+		   str_on_off(old_state), str_on_off(tx_push));
 
 	if (tx_push)
 		set_bit(HNS3_NIC_STATE_TX_PUSH_ENABLE, &priv->state);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index debf143e9940..c46490693594 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -3,6 +3,7 @@
 
 #include <linux/device.h>
 #include <linux/sched/clock.h>
+#include <linux/string_choices.h>
 
 #include "hclge_debugfs.h"
 #include "hclge_err.h"
@@ -11,7 +12,6 @@
 #include "hclge_tm.h"
 #include "hnae3.h"
 
-static const char * const state_str[] = { "off", "on" };
 static const char * const hclge_mac_state_str[] = {
 	"TO_ADD", "TO_DEL", "ACTIVE"
 };
@@ -2573,7 +2573,7 @@ static int hclge_dbg_dump_loopback(struct hclge_dev *hdev, char *buf, int len)
 	loopback_en = hnae3_get_bit(le32_to_cpu(req_app->txrx_pad_fcs_loop_en),
 				    HCLGE_MAC_APP_LP_B);
 	pos += scnprintf(buf + pos, len - pos, "app loopback: %s\n",
-			 state_str[loopback_en]);
+			 str_on_off(loopback_en));
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_COMMON_LOOPBACK, true);
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
@@ -2586,22 +2586,22 @@ static int hclge_dbg_dump_loopback(struct hclge_dev *hdev, char *buf, int len)
 
 	loopback_en = req_common->enable & HCLGE_CMD_SERDES_SERIAL_INNER_LOOP_B;
 	pos += scnprintf(buf + pos, len - pos, "serdes serial loopback: %s\n",
-			 state_str[loopback_en]);
+			 str_on_off(loopback_en));
 
 	loopback_en = req_common->enable &
 			HCLGE_CMD_SERDES_PARALLEL_INNER_LOOP_B ? 1 : 0;
 	pos += scnprintf(buf + pos, len - pos, "serdes parallel loopback: %s\n",
-			 state_str[loopback_en]);
+			 str_on_off(loopback_en));
 
 	if (phydev) {
 		loopback_en = phydev->loopback_enabled;
 		pos += scnprintf(buf + pos, len - pos, "phy loopback: %s\n",
-				 state_str[loopback_en]);
+				 str_on_off(loopback_en));
 	} else if (hnae3_dev_phy_imp_supported(hdev)) {
 		loopback_en = req_common->enable &
 			      HCLGE_CMD_GE_PHY_INNER_LOOP_B;
 		pos += scnprintf(buf + pos, len - pos, "phy loopback: %s\n",
-				 state_str[loopback_en]);
+				 str_on_off(loopback_en));
 	}
 
 	return 0;
@@ -2894,9 +2894,9 @@ static int hclge_dbg_dump_vlan_filter_config(struct hclge_dev *hdev, char *buf,
 	egress = vlan_fe & HCLGE_FILTER_FE_NIC_EGRESS_B ? 1 : 0;
 
 	*pos += scnprintf(buf, len, "I_PORT_VLAN_FILTER: %s\n",
-			  state_str[ingress]);
+			  str_on_off(ingress));
 	*pos += scnprintf(buf + *pos, len - *pos, "E_PORT_VLAN_FILTER: %s\n",
-			  state_str[egress]);
+			  str_on_off(egress));
 
 	hclge_dbg_fill_content(content, sizeof(content), vlan_filter_items,
 			       NULL, ARRAY_SIZE(vlan_filter_items));
@@ -2915,11 +2915,11 @@ static int hclge_dbg_dump_vlan_filter_config(struct hclge_dev *hdev, char *buf,
 			return ret;
 		j = 0;
 		result[j++] = hclge_dbg_get_func_id_str(str_id, i);
-		result[j++] = state_str[ingress];
-		result[j++] = state_str[egress];
-		result[j++] =
-			test_bit(HNAE3_DEV_SUPPORT_PORT_VLAN_BYPASS_B,
-				 hdev->ae_dev->caps) ? state_str[bypass] : "NA";
+		result[j++] = str_on_off(ingress);
+		result[j++] = str_on_off(egress);
+		result[j++] = test_bit(HNAE3_DEV_SUPPORT_PORT_VLAN_BYPASS_B,
+				       hdev->ae_dev->caps) ?
+			      str_on_off(bypass) : "NA";
 		hclge_dbg_fill_content(content, sizeof(content),
 				       vlan_filter_items, result,
 				       ARRAY_SIZE(vlan_filter_items));
@@ -2958,19 +2958,19 @@ static int hclge_dbg_dump_vlan_offload_config(struct hclge_dev *hdev, char *buf,
 		j = 0;
 		result[j++] = hclge_dbg_get_func_id_str(str_id, i);
 		result[j++] = str_pvid;
-		result[j++] = state_str[vlan_cfg.accept_tag1];
-		result[j++] = state_str[vlan_cfg.accept_tag2];
-		result[j++] = state_str[vlan_cfg.accept_untag1];
-		result[j++] = state_str[vlan_cfg.accept_untag2];
-		result[j++] = state_str[vlan_cfg.insert_tag1];
-		result[j++] = state_str[vlan_cfg.insert_tag2];
-		result[j++] = state_str[vlan_cfg.shift_tag];
-		result[j++] = state_str[vlan_cfg.strip_tag1];
-		result[j++] = state_str[vlan_cfg.strip_tag2];
-		result[j++] = state_str[vlan_cfg.drop_tag1];
-		result[j++] = state_str[vlan_cfg.drop_tag2];
-		result[j++] = state_str[vlan_cfg.pri_only1];
-		result[j++] = state_str[vlan_cfg.pri_only2];
+		result[j++] = str_on_off(vlan_cfg.accept_tag1);
+		result[j++] = str_on_off(vlan_cfg.accept_tag2);
+		result[j++] = str_on_off(vlan_cfg.accept_untag1);
+		result[j++] = str_on_off(vlan_cfg.accept_untag2);
+		result[j++] = str_on_off(vlan_cfg.insert_tag1);
+		result[j++] = str_on_off(vlan_cfg.insert_tag2);
+		result[j++] = str_on_off(vlan_cfg.shift_tag);
+		result[j++] = str_on_off(vlan_cfg.strip_tag1);
+		result[j++] = str_on_off(vlan_cfg.strip_tag2);
+		result[j++] = str_on_off(vlan_cfg.drop_tag1);
+		result[j++] = str_on_off(vlan_cfg.drop_tag2);
+		result[j++] = str_on_off(vlan_cfg.pri_only1);
+		result[j++] = str_on_off(vlan_cfg.pri_only2);
 
 		hclge_dbg_fill_content(content, sizeof(content),
 				       vlan_offload_items, result,
@@ -3007,14 +3007,13 @@ static int hclge_dbg_dump_ptp_info(struct hclge_dev *hdev, char *buf, int len)
 	pos += scnprintf(buf + pos, len - pos, "phc %s's debug info:\n",
 			 ptp->info.name);
 	pos += scnprintf(buf + pos, len - pos, "ptp enable: %s\n",
-			 test_bit(HCLGE_PTP_FLAG_EN, &ptp->flags) ?
-			 "yes" : "no");
+			 str_yes_no(test_bit(HCLGE_PTP_FLAG_EN, &ptp->flags)));
 	pos += scnprintf(buf + pos, len - pos, "ptp tx enable: %s\n",
-			 test_bit(HCLGE_PTP_FLAG_TX_EN, &ptp->flags) ?
-			 "yes" : "no");
+			 str_yes_no(test_bit(HCLGE_PTP_FLAG_TX_EN,
+					     &ptp->flags)));
 	pos += scnprintf(buf + pos, len - pos, "ptp rx enable: %s\n",
-			 test_bit(HCLGE_PTP_FLAG_RX_EN, &ptp->flags) ?
-			 "yes" : "no");
+			 str_yes_no(test_bit(HCLGE_PTP_FLAG_RX_EN,
+					     &ptp->flags)));
 
 	last_rx = jiffies_to_msecs(ptp->last_rx);
 	pos += scnprintf(buf + pos, len - pos, "last rx time: %lu.%lu\n",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 3f17b3073e50..8c736a069eeb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -8000,7 +8000,7 @@ static int hclge_set_loopback(struct hnae3_handle *handle,
 	ret = hclge_tqp_enable(handle, en);
 	if (ret)
 		dev_err(&hdev->pdev->dev, "failed to %s tqp in loopback, ret = %d\n",
-			en ? "enable" : "disable", ret);
+			str_enable_disable(en), ret);
 
 	return ret;
 }
@@ -11200,9 +11200,9 @@ static void hclge_info_show(struct hclge_dev *hdev)
 	dev_info(dev, "This is %s PF\n",
 		 hdev->flag & HCLGE_FLAG_MAIN ? "main" : "not main");
 	dev_info(dev, "DCB %s\n",
-		 handle->kinfo.tc_info.dcb_ets_active ? "enable" : "disable");
+		 str_enable_disable(handle->kinfo.tc_info.dcb_ets_active));
 	dev_info(dev, "MQPRIO %s\n",
-		 handle->kinfo.tc_info.mqprio_active ? "enable" : "disable");
+		 str_enable_disable(handle->kinfo.tc_info.mqprio_active));
 	dev_info(dev, "Default tx spare buffer size: %u\n",
 		 hdev->tx_spare_buf_size);
 
@@ -11976,7 +11976,7 @@ static int hclge_set_vf_spoofchk_hw(struct hclge_dev *hdev, int vf, bool enable)
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"Set vf %d mac spoof check %s failed, ret=%d\n",
-			vf, enable ? "on" : "off", ret);
+			vf, str_on_off(enable), ret);
 		return ret;
 	}
 
@@ -11984,7 +11984,7 @@ static int hclge_set_vf_spoofchk_hw(struct hclge_dev *hdev, int vf, bool enable)
 	if (ret)
 		dev_err(&hdev->pdev->dev,
 			"Set vf %d vlan spoof check %s failed, ret=%d\n",
-			vf, enable ? "on" : "off", ret);
+			vf, str_on_off(enable), ret);
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index bab16c2191b2..5c03694af8ad 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2021 Hisilicon Limited.
 
 #include <linux/skbuff.h>
+#include <linux/string_choices.h>
 #include "hclge_main.h"
 #include "hnae3.h"
 
@@ -226,7 +227,7 @@ static int hclge_ptp_int_en(struct hclge_dev *hdev, bool en)
 	if (ret)
 		dev_err(&hdev->pdev->dev,
 			"failed to %s ptp interrupt, ret = %d\n",
-			en ? "enable" : "disable", ret);
+			str_enable_disable(en), ret);
 
 	return ret;
 }
-- 
2.33.0


