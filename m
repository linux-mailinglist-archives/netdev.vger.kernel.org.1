Return-Path: <netdev+bounces-252256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLUrI/rycWmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:50:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE8864CD7
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2065E46B281
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFEF3502B5;
	Thu, 22 Jan 2026 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PcdW0KSk"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B23B3382F6;
	Thu, 22 Jan 2026 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769074935; cv=none; b=MsQWOOyAHo/dwanu3/4rbDfndDDp1MLG4XLtazXXG4UgJgcgsMW4GLnoKHdDtgLzeDAJAof5ZSc8goffEhYyMbQsViDiyW/sw4U5zp0ZMOqcj65FfWVsyulXekNSaWC0dfiESc18KSxpX2uYBrabGK2BhyExr+1ZIQR5Ulld60Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769074935; c=relaxed/simple;
	bh=5SPePvLFCVU7uGpYZnAas7vBwKA+eg/HhSX+ND/pmf8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CK4GWIARWViuZbpypHQWdvnBsEi0OUCPpkuKxtyZ+LwP6ci0P7GnYSDWWEQqPUq2izYXY+qEOGHZqSYdojOicQpt1mvWCJqL3fN/ts0WIYUxce2m43EgBOaeJIu0m8/SOh2CaCLA2pd12aB6VaP1gnUis9rW7GZEvaOB0Xuuoxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PcdW0KSk; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=29WEvSrf/iaKqoW802ob5Q5yFZ8wknyJlgfI+Bmi4cQ=;
	b=PcdW0KSk9uI4zf3umApWaFveqX96oe7u4VeqqvfDyhmbCgNe9uRTiYcQQBuFQ7wVtMUn3+Kee
	vF1/JVpiYQbyvyDQcMOHHxjWFaZibcLKgUwQuEIRxYHAWaoLMTM+t/R1tngom2pgnccxmZosdZc
	lVdd1tr0I7Ih1JJm0Z+Rk24=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dxbb05s2xznTbp;
	Thu, 22 Jan 2026 17:38:04 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 39CAD40565;
	Thu, 22 Jan 2026 17:42:02 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 22 Jan 2026 17:42:01 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>
Subject: [PATCH net] hinic3: Fix netif_queue_set_napi queue_index input parameter error
Date: Thu, 22 Jan 2026 17:41:55 +0800
Message-ID: <7b8e4eb5c53cbd873ee9aaefeb3d9dbbaff52deb.1769070766.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252256-lists,netdev=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_POLICY_ALLOW(0.00)[huawei.com,quarantine];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,h-partners.com:mid,h-partners.com:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FE8864CD7
X-Rspamd-Action: no action

  Incorrectly transmitted interrupt number instead of queue number
when using netif_queue_set_napi. Besides, move this to appropriate
code location to set napi.

Remove redundant netif_stop_subqueue beacuase it is not part of the
hinic3_send_one_skb process.

Fixes: 17fcb3dc12bb ("hinic3: module initialization and tx/rx logic")
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   | 22 +++++++++++--------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
index a69b361225e9..84bee5d6e638 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -43,21 +43,12 @@ static void qp_add_napi(struct hinic3_irq_cfg *irq_cfg)
 	struct hinic3_nic_dev *nic_dev = netdev_priv(irq_cfg->netdev);
 
 	netif_napi_add(nic_dev->netdev, &irq_cfg->napi, hinic3_poll);
-	netif_queue_set_napi(irq_cfg->netdev, irq_cfg->irq_id,
-			     NETDEV_QUEUE_TYPE_RX, &irq_cfg->napi);
-	netif_queue_set_napi(irq_cfg->netdev, irq_cfg->irq_id,
-			     NETDEV_QUEUE_TYPE_TX, &irq_cfg->napi);
 	napi_enable(&irq_cfg->napi);
 }
 
 static void qp_del_napi(struct hinic3_irq_cfg *irq_cfg)
 {
 	napi_disable(&irq_cfg->napi);
-	netif_queue_set_napi(irq_cfg->netdev, irq_cfg->irq_id,
-			     NETDEV_QUEUE_TYPE_RX, NULL);
-	netif_queue_set_napi(irq_cfg->netdev, irq_cfg->irq_id,
-			     NETDEV_QUEUE_TYPE_TX, NULL);
-	netif_stop_subqueue(irq_cfg->netdev, irq_cfg->irq_id);
 	netif_napi_del(&irq_cfg->napi);
 }
 
@@ -150,6 +141,11 @@ int hinic3_qps_irq_init(struct net_device *netdev)
 			goto err_release_irqs;
 		}
 
+		netif_queue_set_napi(irq_cfg->netdev, q_id,
+				     NETDEV_QUEUE_TYPE_RX, &irq_cfg->napi);
+		netif_queue_set_napi(irq_cfg->netdev, q_id,
+				     NETDEV_QUEUE_TYPE_TX, &irq_cfg->napi);
+
 		hinic3_set_msix_auto_mask_state(nic_dev->hwdev,
 						irq_cfg->msix_entry_idx,
 						HINIC3_SET_MSIX_AUTO_MASK);
@@ -164,6 +160,10 @@ int hinic3_qps_irq_init(struct net_device *netdev)
 		q_id--;
 		irq_cfg = &nic_dev->q_params.irq_cfg[q_id];
 		qp_del_napi(irq_cfg);
+		netif_queue_set_napi(irq_cfg->netdev, q_id,
+				     NETDEV_QUEUE_TYPE_RX, NULL);
+		netif_queue_set_napi(irq_cfg->netdev, q_id,
+				     NETDEV_QUEUE_TYPE_TX, NULL);
 		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
 				      HINIC3_MSIX_DISABLE);
 		hinic3_set_msix_auto_mask_state(nic_dev->hwdev,
@@ -184,6 +184,10 @@ void hinic3_qps_irq_uninit(struct net_device *netdev)
 	for (q_id = 0; q_id < nic_dev->q_params.num_qps; q_id++) {
 		irq_cfg = &nic_dev->q_params.irq_cfg[q_id];
 		qp_del_napi(irq_cfg);
+		netif_queue_set_napi(irq_cfg->netdev, q_id,
+				     NETDEV_QUEUE_TYPE_RX, NULL);
+		netif_queue_set_napi(irq_cfg->netdev, q_id,
+				     NETDEV_QUEUE_TYPE_TX, NULL);
 		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
 				      HINIC3_MSIX_DISABLE);
 		hinic3_set_msix_auto_mask_state(nic_dev->hwdev,

base-commit: 19e4175e997a5b85eab97d522f00cc99abd1873c
-- 
2.43.0


