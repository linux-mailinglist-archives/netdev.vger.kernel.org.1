Return-Path: <netdev+bounces-246858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E5DCF1B82
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 04:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD78230517C4
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 03:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6DE321F39;
	Mon,  5 Jan 2026 03:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DI2QB3B9"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9229320A2C;
	Mon,  5 Jan 2026 03:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767582822; cv=none; b=ubYIduuPBg8J6XaneAWWGB5uX1JB3o48Nc5wC078MSKdKb+IFzMuHYHA0Yq/wwWgX6b5ngqCWiKuUhNlG7sV+4qExwpeckjaVPA/QEtNbjFc8ZE/c0DMRGE95oQcVUW2prbg8j1UUf6Ho3qZrO3Fh1h831wkLLWUe+DrqMV6IVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767582822; c=relaxed/simple;
	bh=0IMjmLMCnOU2fPiCxC2EJwL+HLJAu1/CLuV/JBTAdww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=In7HNHvKYXNYHEJWRLNG9ji4TyStHk2eBNjqsC547khm6+fc/SrsD53EM1q2pdSvT/KoRmq32wppPj3PSbH92oF+iXI2POH/wIg8irYnBD/7xplI3O7oP0f88KwoP8xbuLv9H5ZduifgrTdn71V5/qUPoG/0FpMctbjfhjfa9B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DI2QB3B9; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QqcxYPu+etYkHC38X3eMef7Z5wzu6DRmSex9D5brSSg=;
	b=DI2QB3B9ErQ6ezQfm53+MCa3YElnM3FwGhqU3N2jQeZ0Bz3jcdjwquN40qNakifWW6zTxeYF4
	OpFhcCYWnWeudra04DxN/W6HJE84nFi9yNe26uRZNzXtIg9J7ARRMIzhbPzDdFiJzxge2V4fR8I
	HJEVcxlgK7pcNIEAT3ek4+w=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dkznN0lqpz1prKy;
	Mon,  5 Jan 2026 11:10:16 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 1EEDB40569;
	Mon,  5 Jan 2026 11:13:32 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 5 Jan 2026 11:13:30 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Markus Elfring <Markus.Elfring@web.de>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
	<shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
	<wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Luo Yang
	<luoyang82@h-partners.com>
Subject: [PATCH net-next v08 5/9] hinic3: Add .ndo_features_check
Date: Mon, 5 Jan 2026 11:13:08 +0800
Message-ID: <de1740ae870e9f4f787e8b3716e72e011169483e.1767495881.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1767495881.git.zhuyikai1@h-partners.com>
References: <cover.1767495881.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100013.china.huawei.com (7.202.181.12)

As we cannot solve packets with multiple stacked vlan, so we use
.ndo_features_check to check for these packets and return a smaller
feature without offload features.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_netdev_ops.c   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index 526487bf57f4..c1e4edfb69a9 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -2,6 +2,7 @@
 // Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 
 #include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
 #include <linux/netdevice.h>
 
 #include "hinic3_hwif.h"
@@ -15,6 +16,10 @@
 #define HINIC3_LRO_DEFAULT_COAL_PKT_SIZE  32
 #define HINIC3_LRO_DEFAULT_TIME_LIMIT     16
 
+#define HINIC3_VLAN_CLEAR_OFFLOAD \
+	(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \
+	 NETIF_F_SCTP_CRC | NETIF_F_RXCSUM | NETIF_F_ALL_TSO)
+
 /* try to modify the number of irq to the target number,
  * and return the actual number of irq.
  */
@@ -624,6 +629,16 @@ static netdev_features_t hinic3_fix_features(struct net_device *netdev,
 	return features_tmp;
 }
 
+static netdev_features_t hinic3_features_check(struct sk_buff *skb,
+					       struct net_device *dev,
+					       netdev_features_t features)
+{
+	if (unlikely(skb_vlan_tagged_multi(skb)))
+		features &= ~HINIC3_VLAN_CLEAR_OFFLOAD;
+
+	return features;
+}
+
 int hinic3_set_hw_features(struct net_device *netdev)
 {
 	netdev_features_t wanted, curr;
@@ -756,6 +771,7 @@ static const struct net_device_ops hinic3_netdev_ops = {
 	.ndo_stop             = hinic3_close,
 	.ndo_set_features     = hinic3_ndo_set_features,
 	.ndo_fix_features     = hinic3_fix_features,
+	.ndo_features_check   = hinic3_features_check,
 	.ndo_change_mtu       = hinic3_change_mtu,
 	.ndo_set_mac_address  = hinic3_set_mac_addr,
 	.ndo_tx_timeout       = hinic3_tx_timeout,
-- 
2.43.0


