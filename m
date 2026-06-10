Return-Path: <netdev+bounces-297490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kNoqNsEMKWqyPQMAu9opvQ
	(envelope-from <netdev+bounces-297490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:05:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC5166677F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:05:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=HxB98tg5;
	dkim=pass header.d=huawei.com header.s=dkim header.b=HxB98tg5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297490-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297490-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B78423060309
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C447E38330F;
	Wed, 10 Jun 2026 06:59:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B4A371CEE;
	Wed, 10 Jun 2026 06:59:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074778; cv=none; b=ql8z0Iku3fHPLMp6r6fiGLpb8bUNQOIDgXxXbxwW4fgwx7kxLhLUmrPpCj1RxuKyR3OveBmN/KcCIT/OZfcvvwXqVUkY66TXamVgvB4k5c1t3lBz1+GPsc1ulf7V691hxf5tWxvV/aKb3EVjKYwU3C1wwMULmz2Uvxl4m4PhVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074778; c=relaxed/simple;
	bh=v+oB0Ll6R43E6pS1GMYzTr0TyFnyRfIR6ksUHCW+dgE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYRVmeQx+OG41HVgMYkZ2r0+Md5EL+aMy5YdAncPzIR0nqdBwX1Ghuxxi11Ou5TYpjgnurJ9qHc7bS1gb1YBJWsgkNin804IHTwgn5ReU4SvtCcRTRUBCQLwV2dcH2RqacNU1Cy2uga2n9yknV0hNyvX9+5z5HgRAFmmr4CSrBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HxB98tg5; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HxB98tg5; arc=none smtp.client-ip=45.249.212.187
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=F7jQjHmCzs5qSNgYUk3Vcjqz5wQ+VEAbybCX9Ibi2fU=;
	b=HxB98tg5LkXlZnXzffn8ZuX7xGcLGZNanHHjNOu7uJTlds5D0oYR7sN6MCpcMMNNqaLVxhnl3
	LguZ2gn7AfwT4dCQq2OxG1Vdecup1Q84n1rqV/vaOEwtEuP5zpHnD+e1oXZppaqPSilV4aGVvK7
	GaLkIiDa4IuewP8zKPONCQs=
Received: from canpmsgout07.his.huawei.com (unknown [172.19.92.160])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4gZxTd4YMCz1BFxW;
	Wed, 10 Jun 2026 14:59:17 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=F7jQjHmCzs5qSNgYUk3Vcjqz5wQ+VEAbybCX9Ibi2fU=;
	b=HxB98tg5LkXlZnXzffn8ZuX7xGcLGZNanHHjNOu7uJTlds5D0oYR7sN6MCpcMMNNqaLVxhnl3
	LguZ2gn7AfwT4dCQq2OxG1Vdecup1Q84n1rqV/vaOEwtEuP5zpHnD+e1oXZppaqPSilV4aGVvK7
	GaLkIiDa4IuewP8zKPONCQs=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gZxJl5XfMzLlSZ;
	Wed, 10 Jun 2026 14:51:35 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 8336C40561;
	Wed, 10 Jun 2026 14:59:29 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 10 Jun 2026 14:59:28 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>, Teng Peisen
	<tengpeisen@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Mohsin Bashir <mohsin.bashr@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v09 3/5] hinic3: Add ethtool coalesce ops
Date: Wed, 10 Jun 2026 14:59:13 +0800
Message-ID: <dda2f285e7314fa4a682a031328766e58f3137dc.1781062575.git.wudi234@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1781062575.git.wudi234@huawei.com>
References: <cover.1781062575.git.wudi234@huawei.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-297490-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[huawei.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gongfan1@huawei.com,m:wudi234@huawei.com,m:tengpeisen@huawei.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:ioana.ciornei@nxp.com,m:mohsin.bashr@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:luosifu@huawei.com,m:guoxin09@huawei.com,m:zhoushuai28@huawei.com,m:wulike1@huawei.com,m:shijing34@huawei.com,m:zhengjiezhen@h-partners.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:mohsinbashr@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BC5166677F

  Implement following ethtool callback function:
.get_coalesce
.set_coalesce

  These callbacks allow users to utilize ethtool for detailed
RX coalesce configuration and monitoring.

Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 249 +++++++++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |   3 +
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |   1 +
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |   2 +
 4 files changed, 253 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
index 66ca4303bb3c..11c8eb0f5d2a 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
@@ -18,6 +18,11 @@
 #include "hinic3_nic_cfg.h"
 
 #define HINIC3_MGMT_VERSION_MAX_LEN     32
+/* Coalesce time properties in microseconds */
+#define COALESCE_PENDING_LIMIT_UNIT     8
+#define COALESCE_TIMER_CFG_UNIT         5
+#define COALESCE_MAX_PENDING_LIMIT      (255 * COALESCE_PENDING_LIMIT_UNIT)
+#define COALESCE_MAX_TIMER_CFG          (255 * COALESCE_TIMER_CFG_UNIT)
 
 static void hinic3_get_drvinfo(struct net_device *netdev,
 			       struct ethtool_drvinfo *info)
@@ -975,9 +980,247 @@ static void hinic3_get_pause_stats(struct net_device *netdev,
 	kfree(ps);
 }
 
+static int hinic3_set_queue_coalesce(struct net_device *netdev, u16 q_id,
+				     struct hinic3_intr_coal_info *coal,
+				     struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_intr_coal_info *intr_coal;
+	struct hinic3_interrupt_info info = {};
+	int err;
+
+	if (nic_dev->adaptive_rx_coal) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Static coalesce not allowed in adaptive RX mode");
+		return -EINVAL;
+	}
+
+	if (!test_bit(HINIC3_INTF_UP, &nic_dev->flags) ||
+	    q_id >= nic_dev->q_params.num_qps)
+		return 0;
+
+	spin_lock(&nic_dev->coal_lock);
+
+	intr_coal = &nic_dev->intr_coalesce[q_id];
+
+	intr_coal->coalesce_timer_cfg = coal->coalesce_timer_cfg;
+	intr_coal->pending_limit = coal->pending_limit;
+	intr_coal->rx_pending_limit_low = coal->rx_pending_limit_low;
+	intr_coal->rx_pending_limit_high = coal->rx_pending_limit_high;
+	spin_unlock(&nic_dev->coal_lock);
+
+	info.msix_index = nic_dev->q_params.irq_cfg[q_id].msix_entry_idx;
+	info.interrupt_coalesc_set = 1;
+	info.coalesc_timer_cfg = intr_coal->coalesce_timer_cfg;
+	info.pending_limit = intr_coal->pending_limit;
+	info.resend_timer_cfg = intr_coal->resend_timer_cfg;
+	err = hinic3_set_interrupt_cfg(nic_dev->hwdev, info);
+	if (err) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Failed to set queue%u coalesce",
+				       q_id);
+		return err;
+	}
+
+	return 0;
+}
+
+static int is_coalesce_exceed_limit(const struct ethtool_coalesce *coal,
+				    struct netlink_ext_ack *extack)
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
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "%s out of range %d-%d",
+					       coalesce_limits[i].name,
+					       0,
+					       coalesce_limits[i].limit);
+			return -ERANGE;
+		}
+	}
+	return 0;
+}
+
+static int is_coalesce_legal(const struct ethtool_coalesce *coal,
+			     struct netlink_ext_ack *extack)
+{
+	int err;
+
+	err = is_coalesce_exceed_limit(coal, extack);
+	if (err)
+		return err;
+
+	if (coal->rx_max_coalesced_frames_low >
+	    coal->rx_max_coalesced_frames_high) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "invalid coalesce frame high %u, low %u",
+				       coal->rx_max_coalesced_frames_high,
+				       coal->rx_max_coalesced_frames_low);
+		return -ERANGE;
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
+				    struct hinic3_intr_coal_info *intr_coal,
+				    struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+	u16 i;
+
+	for (i = 0; i < nic_dev->max_qps; i++) {
+		err = hinic3_set_queue_coalesce(netdev, i, intr_coal, extack);
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
+	memset(coal, 0, sizeof(*coal));
+
+	interrupt_info = &nic_dev->intr_coalesce[0];
+
+	coal->use_adaptive_rx_coalesce = nic_dev->adaptive_rx_coal;
+
+	if (nic_dev->adaptive_rx_coal) {
+		coal->rx_max_coalesced_frames_low =
+			interrupt_info->rx_pending_limit_low *
+			COALESCE_PENDING_LIMIT_UNIT;
+		coal->rx_max_coalesced_frames_high =
+			interrupt_info->rx_pending_limit_high *
+			COALESCE_PENDING_LIMIT_UNIT;
+	} else {
+		/* TX/RX uses the same interrupt.
+		 * So we only declare RX ethtool_coalesce parameters.
+		 */
+		coal->rx_coalesce_usecs = interrupt_info->coalesce_timer_cfg *
+					  COALESCE_TIMER_CFG_UNIT;
+		coal->rx_max_coalesced_frames = interrupt_info->pending_limit *
+						COALESCE_PENDING_LIMIT_UNIT;
+	}
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
+	const char *obj_str = "for netdev";
+	int err;
+
+	err = is_coalesce_legal(coal, extack);
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
+		NL_SET_ERR_MSG_MOD(extack, "Coalesce will be disabled");
+
+	return hinic3_set_hw_coal_param(netdev, &intr_coal, extack);
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
@@ -993,6 +1236,8 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
 	.get_eth_ctrl_stats             = hinic3_get_eth_ctrl_stats,
 	.get_rmon_stats                 = hinic3_get_rmon_stats,
 	.get_pause_stats                = hinic3_get_pause_stats,
+	.get_coalesce                   = hinic3_get_coalesce,
+	.set_coalesce                   = hinic3_set_coalesce,
 };
 
 void hinic3_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
index bc4d879f9be4..b7cd5f2f53a7 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -173,9 +173,12 @@ static void hinic3_update_queue_coal(struct net_device *netdev, u16 q_id,
 
 	q_coal = &nic_dev->intr_coalesce[q_id];
 	coalesc_timer_cfg = (u8)coal_timer;
+
+	spin_lock(&nic_dev->coal_lock);
 	pending_limit = clamp_t(u8, coal_pkts >> HINIC3_COAL_PKT_SHIFT,
 				q_coal->rx_pending_limit_low,
 				q_coal->rx_pending_limit_high);
+	spin_unlock(&nic_dev->coal_lock);
 
 	hinic3_set_interrupt_moder(nic_dev->netdev, q_id,
 				   coalesc_timer_cfg, pending_limit);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index c87624a5e5dc..b4821c8042b1 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -180,6 +180,7 @@ static int hinic3_sw_init(struct net_device *netdev)
 
 	mutex_init(&nic_dev->port_state_mutex);
 	mutex_init(&nic_dev->change_res_mutex);
+	spin_lock_init(&nic_dev->coal_lock);
 
 	nic_dev->q_params.sq_depth = HINIC3_SQ_DEPTH;
 	nic_dev->q_params.rq_depth = HINIC3_RQ_DEPTH;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index 005b2c01a988..b6e3b188fa78 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -134,6 +134,8 @@ struct hinic3_nic_dev {
 	struct mutex                    port_state_mutex;
 	/* mutex to serialize channel/resource changes */
 	struct mutex                    change_res_mutex;
+	/* lock for set queue coalesce */
+	spinlock_t                      coal_lock;
 
 	struct list_head                uc_filter_list;
 	struct list_head                mc_filter_list;
-- 
2.43.0


