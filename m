Return-Path: <netdev+bounces-260531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNtYCP2mnWmgQwQAu9opvQ
	(envelope-from <netdev+bounces-260531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:26:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAA3187A26
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EEB43187076
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D423A0B37;
	Tue, 24 Feb 2026 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CVL7Ifl1"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A29639E6CA;
	Tue, 24 Feb 2026 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938981; cv=none; b=mg+KptoAWIwHY7VFHHHXpQ5IEnarcDlU8FmADfC1cgUGD6OBDT5CuGawVilCWnad2h/0MZb5VucrHpfqaeZUZK8E2CngPermxesaKdUOFUTXfjrOupe1lZRY75NZOlK673xNU9xuRi+YzW7yxBpBa3XQDAI/Skv8Xkp92Sm6N4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938981; c=relaxed/simple;
	bh=PuwG/keMEByyBRzSJCCvTUkYwbLRC/waxnE4miTtkXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBSi0ez1j8/TUxhWFYLFRqkCFPRmScthSu9DxpTxX0koU6vf00rZA/NMzwODvx6PahYGLvBhHXvoj4xgBpN8aVf5djZLW7CFuoNqAOMXe/hZvy1FmjilbBGVb4+NRJi8zzVEG49nxMi1Pf0bQnRab/iCByMpNIrFX51/BQy3oBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CVL7Ifl1; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VrjNgYENEFdEskuM+UhiVN06tUFuQ1OIIBPuFajVydA=;
	b=CVL7Ifl1X4zetnnFo1OGUTu/DQjQcpvV3/2nspC+gUffs4VfZmDGg3dVUTuti7QlTHZ+l6D2H
	EGeA8t4K/jjpC0cEi+ygvEAz9yrz55Ejkj4Q+T920xjZQA4P6jFd933dZzOhdOP+CvBtlMSazvD
	FXTrtlALn858IBrIDyiXtU0=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fKylv30syzKm50;
	Tue, 24 Feb 2026 21:11:23 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C45A40565;
	Tue, 24 Feb 2026 21:16:10 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 24 Feb 2026 21:16:09 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>
Subject: [PATCH net-next v01 04/15] hinic3: Add RX GRO and VLAN offload support
Date: Tue, 24 Feb 2026 21:15:41 +0800
Message-ID: <f978b58bad622e2e2299841a90c1278b8baab853.1771916043.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1771916043.git.zhuyikai1@h-partners.com>
References: <cover.1771916043.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260531-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,h-partners.com:mid,h-partners.com:email,huawei.com:email,huawei.com:dkim]
X-Rspamd-Queue-Id: 6BAA3187A26
X-Rspamd-Action: no action

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    | 26 +++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
index 159c291fa293..fe7fdd06c1b6 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
@@ -357,6 +357,23 @@ static void hinic3_rx_csum(struct hinic3_rxq *rxq, u32 offload_type,
 	}
 }
 
+static void hinic3_rx_gro(struct hinic3_rxq *rxq, u32 offload_type,
+			  struct sk_buff *skb)
+{
+	struct net_device *netdev = rxq->netdev;
+	bool l2_tunnel;
+
+	if (!(netdev->features & NETIF_F_GRO))
+		return;
+
+	l2_tunnel = HINIC3_GET_RX_TUNNEL_PKT_FORMAT(offload_type) ==
+		    HINIC3_RX_PKT_FORMAT_VXLAN ? 1 : 0;
+	if (l2_tunnel && skb->ip_summed == CHECKSUM_UNNECESSARY) {
+		/* If we checked the outer header let the stack know */
+		skb->csum_level = 1;
+	}
+}
+
 static void hinic3_lro_set_gso_params(struct sk_buff *skb, u16 num_lro)
 {
 	struct ethhdr *eth = (struct ethhdr *)(skb->data);
@@ -389,6 +406,15 @@ static int recv_one_pkt(struct hinic3_rxq *rxq, struct hinic3_rq_cqe *rx_cqe,
 
 	offload_type = le32_to_cpu(rx_cqe->offload_type);
 	hinic3_rx_csum(rxq, offload_type, status, skb);
+	hinic3_rx_gro(rxq, offload_type, skb);
+
+	if ((netdev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
+	    RQ_CQE_OFFOLAD_TYPE_GET(offload_type, VLAN_EN)) {
+		u16 vid = RQ_CQE_SGE_GET(vlan_len, VLAN);
+
+		/* if the packet is a vlan pkt, the vid may be 0 */
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
+	}
 
 	num_lro = RQ_CQE_STATUS_GET(status, NUM_LRO);
 	if (num_lro)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
index 31622e0a63d0..06d1b3299e7c 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
@@ -15,6 +15,9 @@
 #define RQ_CQE_OFFOLAD_TYPE_GET(val, member) \
 	FIELD_GET(RQ_CQE_OFFOLAD_TYPE_##member##_MASK, val)
 
+#define HINIC3_GET_RX_TUNNEL_PKT_FORMAT(offload_type) \
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, TUNNEL_PKT_FORMAT)
+
 #define RQ_CQE_SGE_VLAN_MASK  GENMASK(15, 0)
 #define RQ_CQE_SGE_LEN_MASK   GENMASK(31, 16)
 #define RQ_CQE_SGE_GET(val, member) \
-- 
2.43.0


