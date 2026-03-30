Return-Path: <netdev+bounces-273040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFBWMKbMyWm62gUAu9opvQ
	(envelope-from <netdev+bounces-273040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 03:06:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30571354841
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 03:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BCC5302DF43
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 01:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0D5260565;
	Mon, 30 Mar 2026 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wr91XK58"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB69B23ABBF;
	Mon, 30 Mar 2026 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774832625; cv=none; b=QB86SdBPfw/PiqoQWl66aDTxRdlAyGbRUxn/9SNIqd/XnQfdFFavBfO8wlihoXV9k7J+6rINISv+cmvOUM2kbdERWrb7l020ysc7t3pkLgvCcgvRUbnebQYbkmoQbWZLxgh2LGyOzIgOvCUywQQ6oNx2Cqs0ul2YXFHaaV8utRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774832625; c=relaxed/simple;
	bh=HLGNO9kkwF7YVxocDGUa0T0BFPgRKMuQWbKw+yw5TkI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eViS3psuJq6f0R24nNu28JxOOo+2LlXYH23OYhxvlmHJr8v81HbZ4Lax5b5OMLSi8FlR1rXKSV4ypU4nxnLGuOty/48u9bMmIxT/yPgLI0ZCFIMgXsuu5mxxajPuLoXLim0IHJXIYcZrSzi+ZAjewnT8U7etCpg8+kGFdoXSGFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wr91XK58; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XBvdtJ2kT9pQHCj630bn8QLBIwF6aCDp1CbZjuWTyY4=;
	b=wr91XK58EgGP5jkW1Bh8IVFsbyg6iIqVuKpuBgWoMOv/Hhmc1EqHSHbBz7almcUq3oxvqB18P
	DLU2JEb8Yk7qMETpBTI12E/NyGdeAHfIyzM1l7qtNzuWxJ1bPl+nDLiR1+rgQCtt6A7rMWqyZAK
	+TdaV6F1G0tTdFOoY5Im1Q0=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fkXsM14Qqz1cys9;
	Mon, 30 Mar 2026 08:57:27 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id B3F5440567;
	Mon, 30 Mar 2026 09:03:34 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 30 Mar 2026 09:03:33 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v02 3/6] hinic3: Add ethtool coalesce ops
Date: Mon, 30 Mar 2026 09:03:20 +0800
Message-ID: <40dfc7376e8f62e95500c983e04086a4c055a63a.1774684571.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1774684571.git.zhuyikai1@h-partners.com>
References: <cover.1774684571.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273040-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,h-partners.com:email,h-partners.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30571354841
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

  Implement following ethtool callback function:
.get_coalesce
.set_coalesce

  These callbacks allow users to utilize ethtool for detailed
RX coalesce configuration and monitoring.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 233 +++++++++++++++++-
 1 file changed, 231 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
index ea223381cddd..585b63c6be79 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
@@ -17,6 +17,11 @@
 #include "hinic3_nic_cfg.h"
 
 #define HINIC3_MGMT_VERSION_MAX_LEN     32
+/* Coalesce time properties in microseconds */
+#define COALESCE_PENDING_LIMIT_UNIT     8
+#define COALESCE_TIMER_CFG_UNIT         5
+#define COALESCE_MAX_PENDING_LIMIT      (255 * COALESCE_PENDING_LIMIT_UNIT)
+#define COALESCE_MAX_TIMER_CFG          (255 * COALESCE_TIMER_CFG_UNIT)
 
 static void hinic3_get_drvinfo(struct net_device *netdev,
 			       struct ethtool_drvinfo *info)
@@ -1035,9 +1040,231 @@ static void hinic3_get_pause_stats(struct net_device *netdev,
 	kfree(ps);
 }
 
+static int hinic3_set_queue_coalesce(struct net_device *netdev, u16 q_id,
+				     struct hinic3_intr_coal_info *coal)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_intr_coal_info *intr_coal;
+	struct hinic3_interrupt_info info = {};
+	int err;
+
+	intr_coal = &nic_dev->intr_coalesce[q_id];
+
+	intr_coal->coalesce_timer_cfg = coal->coalesce_timer_cfg;
+	intr_coal->pending_limit = coal->pending_limit;
+	intr_coal->rx_pending_limit_low = coal->rx_pending_limit_low;
+	intr_coal->rx_pending_limit_high = coal->rx_pending_limit_high;
+
+	if (!test_bit(HINIC3_INTF_UP, &nic_dev->flags) ||
+	    q_id >= nic_dev->q_params.num_qps || nic_dev->adaptive_rx_coal)
+		return 0;
+
+	info.msix_index = nic_dev->q_params.irq_cfg[q_id].msix_entry_idx;
+	info.interrupt_coalesc_set = 1;
+	info.coalesc_timer_cfg = intr_coal->coalesce_timer_cfg;
+	info.pending_limit = intr_coal->pending_limit;
+	info.resend_timer_cfg = intr_coal->resend_timer_cfg;
+	err = hinic3_set_interrupt_cfg(nic_dev->hwdev, info);
+	if (err) {
+		netdev_warn(netdev, "Failed to set queue%u coalesce\n", q_id);
+		return err;
+	}
+
+	return 0;
+}
+
+static int is_coalesce_exceed_limit(struct net_device *netdev,
+				    const struct ethtool_coalesce *coal)
+{
+	const struct {
+		const char *name;
+		u32 value;
+		u32 limit;
+	} coalesce_limits[] = {
+		{"rx_coalesce_usecs",
+		 coal->rx_coalesce_usecs,
+		 COALESCE_MAX_TIMER_CFG},
+		{"rx_max_coalesced_frames",
+		 coal->rx_max_coalesced_frames,
+		 COALESCE_MAX_PENDING_LIMIT},
+		{"rx_max_coalesced_frames_low",
+		 coal->rx_max_coalesced_frames_low,
+		 COALESCE_MAX_PENDING_LIMIT},
+		{"rx_max_coalesced_frames_high",
+		 coal->rx_max_coalesced_frames_high,
+		 COALESCE_MAX_PENDING_LIMIT},
+	};
+
+	for (int i = 0; i < ARRAY_SIZE(coalesce_limits); i++) {
+		if (coalesce_limits[i].value > coalesce_limits[i].limit) {
+			netdev_err(netdev, "%s out of range %d-%d\n",
+				   coalesce_limits[i].name, 0,
+				   coalesce_limits[i].limit);
+			return -EOPNOTSUPP;
+		}
+	}
+	return 0;
+}
+
+static int is_coalesce_legal(struct net_device *netdev,
+			     const struct ethtool_coalesce *coal)
+{
+	int err;
+
+	err = is_coalesce_exceed_limit(netdev, coal);
+	if (err)
+		return err;
+
+	if (coal->rx_max_coalesced_frames_low >=
+	    coal->rx_max_coalesced_frames_high &&
+	    coal->rx_max_coalesced_frames_high > 0) {
+		netdev_err(netdev, "invalid coalesce frame high %u, low %u, unit %d\n",
+			   coal->rx_max_coalesced_frames_high,
+			   coal->rx_max_coalesced_frames_low,
+			   COALESCE_PENDING_LIMIT_UNIT);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static void check_coalesce_align(struct net_device *netdev,
+				 u32 item, u32 unit, const char *str)
+{
+	if (item % unit)
+		netdev_warn(netdev, "%s in %d units, change to %u\n",
+			    str, unit, item - item % unit);
+}
+
+#define CHECK_COALESCE_ALIGN(member, unit) \
+	check_coalesce_align(netdev, member, unit, #member)
+
+static void check_coalesce_changed(struct net_device *netdev,
+				   u32 item, u32 unit, u32 ori_val,
+				   const char *obj_str, const char *str)
+{
+	if ((item / unit) != ori_val)
+		netdev_dbg(netdev, "Change %s from %d to %u %s\n",
+			   str, ori_val * unit, item - item % unit, obj_str);
+}
+
+#define CHECK_COALESCE_CHANGED(member, unit, ori_val, obj_str) \
+	check_coalesce_changed(netdev, member, unit, ori_val, obj_str, #member)
+
+static int hinic3_set_hw_coal_param(struct net_device *netdev,
+				    struct hinic3_intr_coal_info *intr_coal)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+	u16 i;
+
+	for (i = 0; i < nic_dev->max_qps; i++) {
+		err = hinic3_set_queue_coalesce(netdev, i, intr_coal);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int hinic3_get_coalesce(struct net_device *netdev,
+			       struct ethtool_coalesce *coal,
+			       struct kernel_ethtool_coalesce *kernel_coal,
+			       struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_intr_coal_info *interrupt_info;
+
+	interrupt_info = &nic_dev->intr_coalesce[0];
+
+	/* TX/RX uses the same interrupt.
+	 * So we only declare RX ethtool_coalesce parameters.
+	 */
+	coal->rx_coalesce_usecs = interrupt_info->coalesce_timer_cfg *
+				  COALESCE_TIMER_CFG_UNIT;
+	coal->rx_max_coalesced_frames = interrupt_info->pending_limit *
+					COALESCE_PENDING_LIMIT_UNIT;
+
+	coal->use_adaptive_rx_coalesce = nic_dev->adaptive_rx_coal;
+
+	coal->rx_max_coalesced_frames_high =
+		interrupt_info->rx_pending_limit_high *
+		COALESCE_PENDING_LIMIT_UNIT;
+
+	coal->rx_max_coalesced_frames_low =
+		interrupt_info->rx_pending_limit_low *
+		COALESCE_PENDING_LIMIT_UNIT;
+
+	return 0;
+}
+
+static int hinic3_set_coalesce(struct net_device *netdev,
+			       struct ethtool_coalesce *coal,
+			       struct kernel_ethtool_coalesce *kernel_coal,
+			       struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_intr_coal_info *ori_intr_coal;
+	struct hinic3_intr_coal_info intr_coal = {};
+	char obj_str[32];
+	int err;
+
+	err = is_coalesce_legal(netdev, coal);
+	if (err)
+		return err;
+
+	CHECK_COALESCE_ALIGN(coal->rx_coalesce_usecs, COALESCE_TIMER_CFG_UNIT);
+	CHECK_COALESCE_ALIGN(coal->rx_max_coalesced_frames,
+			     COALESCE_PENDING_LIMIT_UNIT);
+	CHECK_COALESCE_ALIGN(coal->rx_max_coalesced_frames_high,
+			     COALESCE_PENDING_LIMIT_UNIT);
+	CHECK_COALESCE_ALIGN(coal->rx_max_coalesced_frames_low,
+			     COALESCE_PENDING_LIMIT_UNIT);
+
+	ori_intr_coal = &nic_dev->intr_coalesce[0];
+	snprintf(obj_str, sizeof(obj_str), "for netdev");
+
+	CHECK_COALESCE_CHANGED(coal->rx_coalesce_usecs, COALESCE_TIMER_CFG_UNIT,
+			       ori_intr_coal->coalesce_timer_cfg, obj_str);
+	CHECK_COALESCE_CHANGED(coal->rx_max_coalesced_frames,
+			       COALESCE_PENDING_LIMIT_UNIT,
+			       ori_intr_coal->pending_limit, obj_str);
+	CHECK_COALESCE_CHANGED(coal->rx_max_coalesced_frames_high,
+			       COALESCE_PENDING_LIMIT_UNIT,
+			       ori_intr_coal->rx_pending_limit_high, obj_str);
+	CHECK_COALESCE_CHANGED(coal->rx_max_coalesced_frames_low,
+			       COALESCE_PENDING_LIMIT_UNIT,
+			       ori_intr_coal->rx_pending_limit_low, obj_str);
+
+	intr_coal.coalesce_timer_cfg =
+		(u8)(coal->rx_coalesce_usecs / COALESCE_TIMER_CFG_UNIT);
+	intr_coal.pending_limit = (u8)(coal->rx_max_coalesced_frames /
+				      COALESCE_PENDING_LIMIT_UNIT);
+
+	nic_dev->adaptive_rx_coal = coal->use_adaptive_rx_coalesce;
+
+	intr_coal.rx_pending_limit_high =
+		(u8)(coal->rx_max_coalesced_frames_high /
+		     COALESCE_PENDING_LIMIT_UNIT);
+
+	intr_coal.rx_pending_limit_low =
+		(u8)(coal->rx_max_coalesced_frames_low /
+		     COALESCE_PENDING_LIMIT_UNIT);
+
+	/* coalesce timer or pending set to zero will disable coalesce */
+	if (!nic_dev->adaptive_rx_coal &&
+	    (!intr_coal.coalesce_timer_cfg || !intr_coal.pending_limit))
+		netdev_warn(netdev, "Coalesce will be disabled\n");
+
+	return hinic3_set_hw_coal_param(netdev, &intr_coal);
+}
+
 static const struct ethtool_ops hinic3_ethtool_ops = {
-	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
-					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
+	.supported_coalesce_params      = ETHTOOL_COALESCE_RX_USECS |
+					  ETHTOOL_COALESCE_RX_MAX_FRAMES |
+					  ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
+					  ETHTOOL_COALESCE_RX_MAX_FRAMES_LOW |
+					  ETHTOOL_COALESCE_RX_MAX_FRAMES_HIGH,
 	.get_link_ksettings             = hinic3_get_link_ksettings,
 	.get_drvinfo                    = hinic3_get_drvinfo,
 	.get_msglevel                   = hinic3_get_msglevel,
@@ -1053,6 +1280,8 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
 	.get_eth_ctrl_stats             = hinic3_get_eth_ctrl_stats,
 	.get_rmon_stats                 = hinic3_get_rmon_stats,
 	.get_pause_stats                = hinic3_get_pause_stats,
+	.get_coalesce                   = hinic3_get_coalesce,
+	.set_coalesce                   = hinic3_set_coalesce,
 };
 
 void hinic3_set_ethtool_ops(struct net_device *netdev)
-- 
2.43.0


