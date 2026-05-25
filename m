Return-Path: <netdev+bounces-291286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJM/MQohFGpjKAcAu9opvQ
	(envelope-from <netdev+bounces-291286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:14:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 202A35C922D
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CBFE300CBE7
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14B5346E7E;
	Mon, 25 May 2026 10:11:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1FE345CBE
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703906; cv=none; b=kzVBnU4feoZR6UoMOd/zLhG+oHOLe9VzUXBsY1r7JGAil4IFni1ojtnagtaJX1D4J8IuBhMLBy3Wb7AvJeZO2xvuQ0x6zmeZG8P2UsgrmtvMal8/Wi+soAlLuZ4tavDK0YTMVbPekx4SPh1N9C0fXKFKKYRTZMaARNVXYooSaH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703906; c=relaxed/simple;
	bh=x2QPrxCC4FxM0Gl2HnJkaor/tZczURz1J2o5PGjYECs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N78eiAWzhtD0aHwe5CwCPU/+OtybMgAMsYkbJgPsWxUS6aZUoqk43hikk2SqG4Oil0UkM89dyujKfCNTQi98ecpt1FLZ/yz/nLKDKAYfJNSe7h/Nw5yt5PSzVBS6MAFDPHbB3hSFRk4fZ9/jzmud3i6Yuo8m3w4tKl7v90HHZxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz1t1779703895t4b482f71
X-QQ-Originating-IP: XtSm2GntskmS2DjT4+bK0amMkvmMFPu7ilhVlj7WfkU=
Received: from localhost.localdomain ( [122.231.28.113])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 25 May 2026 18:11:35 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17867395689547384287
EX-QQ-RecipientCnt: 4
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v2 3/3] net: libwx: support vf hardware statistics
Date: Mon, 25 May 2026 18:11:15 +0800
Message-Id: <20260525101115.13151-4-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260525101115.13151-1-mengyuanlou@net-swift.com>
References: <20260525101115.13151-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Mf9Hc6kYdwfrM+M342BNXZurvR+dtG15SVJTXZ7cUd1tto5szbtpI7Pv
	R+YUJEAPn1PHrBOnpiEiDb6C1OQPGuOHkIB4HObVG0O3NguVPEvCIMVr8bo63KkpIQhoXym
	504l7SeCepORSnxiwN4KRByBPvTmpTrvNKNycYrEWFiLzCTdS7jpr1KIgnrd5d3hqKpNgH2
	ZAah36GgKSG0Yq85luQYvn+/OUQrXC8PKDbVpOQsVByrFQs1otTNzSzI5Mbh7cBJDz0vtb+
	MdfTcX3X1U6mXTRiZ76mzrpVzeausXBlAA5TIkJGTfwxCvjBveu3QfExHj+8jkLGN6PSArj
	ZWW8Y1vn/HE5/7xfc96cc1PmT5DMUXfc6pdJ7sQEPFCukdkGLXJzYXw8SXmTWns+WbTDXQ2
	k5vT/irqIBaaXdmxHKiMymBJG481JASt4/J9JKKgS8+FEcuxed2gNeWnjEYlyhMbK5uWYl0
	8bbrbzgks+iUHn8CkkGuYuYXOuuvIOpZmPJXdLn5AdfTp3DpwDWb5Z3EZD8dirsEkU+5n6s
	E7s3qbUf5RgmL7yz0qHnnw8+iSFu3wJPm9uB3ALxZGMWMcMY7ekhtoxVH4x4sldxK4m7/Q3
	HjUJMWqporlyf6gOzV8Nwo+1IKOl0K8B64YuxBMIfRIl/esaXeMnDKeD67jA/wfZ7+4cyue
	gScsWyS/Uf0mO44ETu4aWISGoNEEAtT4wfllrGfkULwlZg6Nndn1ads3vM5fbp8qaHtJ8OQ
	pzd+a+ceSTBiXPc1dQqdpbcO0DPmiaTV0MEfLoGlmzMzf972/fASKAj/7RwGDdIAWb19xMb
	MKjbGQQx80Foi78a2gBsWckEaeZ1hc5PoPx0YQaT7DcD5whByBTU4LW9P+mr0fPrzZWD9TH
	90lAxn0d5f/T41zS6jJT6JK8XOIPn7rXiCHh1Di6CCEosgzNnI2G3+sZClZ6OQoUg+qjcZc
	ZrEX56a3XKGLr3tqC6R/V1RF9YNkvCR9Zm9HZh6V1AJWukmjMuBs4PQkcti7G4mxh5LNtMn
	6Us0wMHZ/zOIZXLlZUfwVW05r0QfssTxorU59l+Ab9lRrE1rbPsqbZbXuuukjVtfVtjg5uM
	GHntD5+YZKy6Zhwxup2oG4pMNmCfWQaVonaMF8pS7HpmKgk+ZN3C5BcgqpgWwpfGK57VKfo
	AwmW
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[net-swift.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291286-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.957];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[net-swift.com:mid,net-swift.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 202A35C922D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support to show hardware statistics for ethtool -S ethx.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 31 ++++++--
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 75 ++++++++++---------
 .../net/ethernet/wangxun/libwx/wx_vf_common.c | 51 +++++++++++++
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |  1 +
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c |  1 +
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  2 +
 6 files changed, 118 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 30c6ef6103ac..a12e1205ce80 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -48,6 +48,10 @@ static const struct wx_stats wx_gstrings_stats[] = {
 	WX_STAT("rx_hwtstamp_cleared", rx_hwtstamp_cleared),
 };
 
+static const struct wx_stats wx_gstrings_stats_vf[] = {
+	WX_STAT("non_eop_descs", non_eop_descs),
+};
+
 static const struct wx_stats wx_gstrings_fdir_stats[] = {
 	WX_STAT("fdir_match", stats.fdirmatch),
 	WX_STAT("fdir_miss", stats.fdirmiss),
@@ -69,7 +73,9 @@ static const struct wx_stats wx_gstrings_rsc_stats[] = {
 #define WX_QUEUE_STATS_LEN ( \
 		(WX_NUM_TX_QUEUES + WX_NUM_RX_QUEUES) * \
 		(sizeof(struct wx_queue_stats) / sizeof(u64)))
-#define WX_GLOBAL_STATS_LEN  ARRAY_SIZE(wx_gstrings_stats)
+#define WX_GLOBAL_STATS_LEN (wx->pdev->is_virtfn ? \
+		ARRAY_SIZE(wx_gstrings_stats_vf) : \
+		ARRAY_SIZE(wx_gstrings_stats))
 #define WX_FDIR_STATS_LEN  ARRAY_SIZE(wx_gstrings_fdir_stats)
 #define WX_RSC_STATS_LEN  ARRAY_SIZE(wx_gstrings_rsc_stats)
 #define WX_STATS_LEN (WX_GLOBAL_STATS_LEN + WX_QUEUE_STATS_LEN)
@@ -101,7 +107,10 @@ void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < WX_GLOBAL_STATS_LEN; i++)
-			ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
+			if (wx->pdev->is_virtfn)
+				ethtool_puts(&p, wx_gstrings_stats_vf[i].stat_string);
+			else
+				ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
 		if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
 			for (i = 0; i < WX_FDIR_STATS_LEN; i++)
 				ethtool_puts(&p, wx_gstrings_fdir_stats[i].stat_string);
@@ -135,9 +144,15 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 	wx_update_stats(wx);
 
 	for (i = 0; i < WX_GLOBAL_STATS_LEN; i++) {
-		p = (char *)wx + wx_gstrings_stats[i].stat_offset;
-		data[i] = (wx_gstrings_stats[i].sizeof_stat ==
-			   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
+		if (wx->pdev->is_virtfn) {
+			p = (char *)wx + wx_gstrings_stats_vf[i].stat_offset;
+			data[i] = (wx_gstrings_stats_vf[i].sizeof_stat ==
+				   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
+		} else {
+			p = (char *)wx + wx_gstrings_stats[i].stat_offset;
+			data[i] = (wx_gstrings_stats[i].sizeof_stat ==
+				   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
+		}
 	}
 
 	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
@@ -219,9 +234,10 @@ EXPORT_SYMBOL(wx_get_pause_stats);
 
 void wx_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info)
 {
-	unsigned int stats_len = WX_STATS_LEN;
 	struct wx *wx = netdev_priv(netdev);
+	unsigned int stats_len;
 
+	stats_len = WX_STATS_LEN;
 	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags))
 		stats_len += WX_FDIR_STATS_LEN;
 
@@ -851,6 +867,9 @@ static const struct ethtool_ops wx_ethtool_ops_vf = {
 	.set_coalesce		= wx_set_coalesce,
 	.get_ts_info		= ethtool_op_get_ts_info,
 	.get_link_ksettings	= wx_get_link_ksettings_vf,
+	.get_sset_count		= wx_get_sset_count,
+	.get_strings		= wx_get_strings,
+	.get_ethtool_stats	= wx_get_ethtool_stats,
 };
 
 void wx_set_ethtool_ops_vf(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 2451f6b20b11..7244aee3fc74 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2916,45 +2916,46 @@ void wx_update_stats(struct wx *wx)
 	wx->restart_queue = restart_queue;
 	wx->tx_busy = tx_busy;
 
-	wx_update_xoff_rx_lfc(wx);
-
-	hwstats->gprc += rd32(wx, WX_RDM_PKT_CNT);
-	hwstats->gptc += rd32(wx, WX_TDM_PKT_CNT);
-	hwstats->gorc += rd64(wx, WX_RDM_BYTE_CNT_LSB);
-	hwstats->gotc += rd64(wx, WX_TDM_BYTE_CNT_LSB);
-	hwstats->tpr += rd64(wx, WX_RX_FRAME_CNT_GOOD_BAD_L);
-	hwstats->tpt += rd64(wx, WX_TX_FRAME_CNT_GOOD_BAD_L);
-	hwstats->crcerrs += rd64(wx, WX_RX_CRC_ERROR_FRAMES_L);
-	hwstats->rlec += rd64(wx, WX_RX_LEN_ERROR_FRAMES_L);
-	hwstats->bprc += rd64(wx, WX_RX_BC_FRAMES_GOOD_L);
-	hwstats->bptc += rd64(wx, WX_TX_BC_FRAMES_GOOD_L);
-	hwstats->mprc += rd64(wx, WX_RX_MC_FRAMES_GOOD_L);
-	hwstats->mptc += rd64(wx, WX_TX_MC_FRAMES_GOOD_L);
-	hwstats->roc += rd32(wx, WX_RX_OVERSIZE_FRAMES_GOOD);
-	hwstats->ruc += rd32(wx, WX_RX_UNDERSIZE_FRAMES_GOOD);
-	if (wx->mac.type >= wx_mac_aml)
-		hwstats->lxonrxc += rd32_wrap(wx, WX_MAC_LXONRXC_AML,
-					      &wx->last_stats.lxonrxc);
-	else
-		hwstats->lxonrxc += rd32(wx, WX_MAC_LXONRXC);
-	hwstats->lxontxc += rd32(wx, WX_RDB_LXONTXC);
-	hwstats->lxofftxc += rd32(wx, WX_RDB_LXOFFTXC);
-	hwstats->o2bgptc += rd32(wx, WX_TDM_OS2BMC_CNT);
-	hwstats->b2ospc += rd32(wx, WX_MNG_BMC2OS_CNT);
-	hwstats->o2bspc += rd32(wx, WX_MNG_OS2BMC_CNT);
-	hwstats->b2ogprc += rd32(wx, WX_RDM_BMC2OS_CNT);
-	hwstats->rdmdrop += rd32(wx, WX_RDM_DRP_PKT);
+	if (wx->pdev->is_physfn) {
+		wx_update_xoff_rx_lfc(wx);
+
+		hwstats->gprc += rd32(wx, WX_RDM_PKT_CNT);
+		hwstats->gptc += rd32(wx, WX_TDM_PKT_CNT);
+		hwstats->gorc += rd64(wx, WX_RDM_BYTE_CNT_LSB);
+		hwstats->gotc += rd64(wx, WX_TDM_BYTE_CNT_LSB);
+		hwstats->tpr += rd64(wx, WX_RX_FRAME_CNT_GOOD_BAD_L);
+		hwstats->tpt += rd64(wx, WX_TX_FRAME_CNT_GOOD_BAD_L);
+		hwstats->crcerrs += rd64(wx, WX_RX_CRC_ERROR_FRAMES_L);
+		hwstats->rlec += rd64(wx, WX_RX_LEN_ERROR_FRAMES_L);
+		hwstats->bprc += rd64(wx, WX_RX_BC_FRAMES_GOOD_L);
+		hwstats->bptc += rd64(wx, WX_TX_BC_FRAMES_GOOD_L);
+		hwstats->mprc += rd64(wx, WX_RX_MC_FRAMES_GOOD_L);
+		hwstats->mptc += rd64(wx, WX_TX_MC_FRAMES_GOOD_L);
+		hwstats->roc += rd32(wx, WX_RX_OVERSIZE_FRAMES_GOOD);
+		hwstats->ruc += rd32(wx, WX_RX_UNDERSIZE_FRAMES_GOOD);
+		if (wx->mac.type >= wx_mac_aml)
+			hwstats->lxonrxc += rd32_wrap(wx, WX_MAC_LXONRXC_AML,
+						&wx->last_stats.lxonrxc);
+		else
+			hwstats->lxonrxc += rd32(wx, WX_MAC_LXONRXC);
+		hwstats->lxontxc += rd32(wx, WX_RDB_LXONTXC);
+		hwstats->lxofftxc += rd32(wx, WX_RDB_LXOFFTXC);
+		hwstats->o2bgptc += rd32(wx, WX_TDM_OS2BMC_CNT);
+		hwstats->b2ospc += rd32(wx, WX_MNG_BMC2OS_CNT);
+		hwstats->o2bspc += rd32(wx, WX_MNG_OS2BMC_CNT);
+		hwstats->b2ogprc += rd32(wx, WX_RDM_BMC2OS_CNT);
+		hwstats->rdmdrop += rd32(wx, WX_RDM_DRP_PKT);
+
+		if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
+			hwstats->fdirmatch += rd32(wx, WX_RDB_FDIR_MATCH);
+			hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
+		}
 
-	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
-		hwstats->fdirmatch += rd32(wx, WX_RDB_FDIR_MATCH);
-		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
+		for (i = wx->num_vfs * wx->num_rx_queues_per_pool;
+		     i < wx->mac.max_rx_queues; i++)
+			hwstats->qmprc += rd32_wrap(wx, WX_PX_MPRC(i),
+						&wx->last_stats.qmprc[i]);
 	}
-
-	for (i = wx->num_vfs * wx->num_rx_queues_per_pool;
-	     i < wx->mac.max_rx_queues; i++)
-		hwstats->qmprc += rd32_wrap(wx, WX_PX_MPRC(i),
-					    &wx->last_stats.qmprc[i]);
-
 	spin_unlock(&wx->hw_stats_lock);
 }
 EXPORT_SYMBOL(wx_update_stats);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index a3361696b783..c2c748d6420a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -5,6 +5,7 @@
 #include <linux/pci.h>
 
 #include "wx_type.h"
+#include "wx_hw.h"
 #include "wx_mbx.h"
 #include "wx_lib.h"
 #include "wx_vf.h"
@@ -332,6 +333,7 @@ void wxvf_down(struct wx *wx)
 	netif_tx_disable(netdev);
 	netif_carrier_off(netdev);
 	wx_napi_disable_all(wx);
+	wx_update_stats(wx);
 	wx_reset_vf(wx);
 
 	wx_clean_all_tx_rings(wx);
@@ -405,6 +407,7 @@ static void wxvf_service_task(struct work_struct *work)
 
 	wxvf_link_config_subtask(wx);
 	wxvf_reset_subtask(wx);
+	wx_update_stats(wx);
 	wx_service_event_complete(wx);
 }
 
@@ -415,3 +418,51 @@ void wxvf_init_service(struct wx *wx)
 	clear_bit(WX_STATE_SERVICE_SCHED, wx->state);
 }
 EXPORT_SYMBOL(wxvf_init_service);
+
+static void wxvf_get_queue_stats_rx(struct net_device *dev, int idx,
+				    struct netdev_queue_stats_rx *stats)
+{
+	struct wx *wx = netdev_priv(dev);
+	struct wx_ring *ring = wx->rx_ring[idx];
+
+	stats->packets = ring->stats.packets;
+	stats->bytes = ring->stats.bytes;
+	stats->alloc_fail = wx->alloc_rx_buff_failed;
+	stats->csum_complete = wx->hw_csum_rx_good;
+	stats->csum_bad = wx->hw_csum_rx_error;
+}
+
+static void wxvf_get_queue_stats_tx(struct net_device *dev, int idx,
+				    struct netdev_queue_stats_tx *stats)
+{
+	struct wx *wx = netdev_priv(dev);
+	struct wx_ring *ring = wx->tx_ring[idx];
+
+	stats->packets = ring->stats.packets;
+	stats->bytes = ring->stats.bytes;
+}
+
+static void wxvf_get_base_stats(struct net_device *dev,
+				struct netdev_queue_stats_rx *rx,
+				struct netdev_queue_stats_tx *tx)
+{
+	rx->bytes = 0;
+	rx->packets = 0;
+	rx->alloc_fail = 0;
+	rx->csum_complete = 0;
+	rx->csum_bad = 0;
+	tx->bytes = 0;
+	tx->packets = 0;
+}
+
+static const struct netdev_stat_ops wxvf_stat_ops = {
+	.get_queue_stats_rx  = wxvf_get_queue_stats_rx,
+	.get_queue_stats_tx  = wxvf_get_queue_stats_tx,
+	.get_base_stats      = wxvf_get_base_stats,
+};
+
+void wx_set_stat_ops_vf(struct net_device *netdev)
+{
+	netdev->stat_ops = &wxvf_stat_ops;
+}
+EXPORT_SYMBOL(wx_set_stat_ops_vf);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
index d45d5d8ac3ab..4367505a7b8f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
@@ -20,5 +20,6 @@ int wxvf_open(struct net_device *netdev);
 void wxvf_down(struct wx *wx);
 int wxvf_close(struct net_device *netdev);
 void wxvf_init_service(struct wx *wx);
+void wx_set_stat_ops_vf(struct net_device *netdev);
 
 #endif /* _WX_VF_COMMON_H_ */
diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
index d79cf8d8484f..69765b6bb8c3 100644
--- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
@@ -189,6 +189,7 @@ static int ngbevf_probe(struct pci_dev *pdev,
 
 	wx->driver_name = KBUILD_MODNAME;
 	wx_set_ethtool_ops_vf(netdev);
+	wx_set_stat_ops_vf(netdev);
 	netdev->netdev_ops = &ngbevf_netdev_ops;
 
 	/* setup the private structure */
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
index 8b16b900820a..c7f0f7e1f54c 100644
--- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
@@ -7,6 +7,7 @@
 #include <linux/netdevice.h>
 #include <linux/string.h>
 #include <linux/etherdevice.h>
+#include <net/netdev_queues.h>
 
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_hw.h"
@@ -254,6 +255,7 @@ static int txgbevf_probe(struct pci_dev *pdev,
 
 	wx->driver_name = KBUILD_MODNAME;
 	wx_set_ethtool_ops_vf(netdev);
+	wx_set_stat_ops_vf(netdev);
 	netdev->netdev_ops = &txgbevf_netdev_ops;
 
 	/* setup the private structure */
-- 
2.30.1


