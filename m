Return-Path: <netdev+bounces-293571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DKKM28mHWq6VwkAu9opvQ
	(envelope-from <netdev+bounces-293571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:27:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3344561A291
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54B6F3013A56
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 06:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19974345CAE;
	Mon,  1 Jun 2026 06:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="TwxeBCDe"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC7B346777;
	Mon,  1 Jun 2026 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295044; cv=none; b=DFZWJ7Z8rCmHA7XOZhNHRy1urzbTtxpsltIiZB15X6b4OSakRPWnzVosNGu6WHF6PsdsbsGXOaixqx65LhiR/KBRNa/K4+bRknHGDg2KGyLPXgHcZ0iTl15QVkv4zTZ4BnUCvJgkry2IhT1nya047/10InI/S1sruBkCM1boF0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295044; c=relaxed/simple;
	bh=Nw5ha/jTxyRROx0tiO/vQaPKOUIwZW8AYhOrNLxXrN4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YXuw8UzYtOIH4FJCAtFB0AXy0D1skstdxhFhcXzqSPd57UmX03437voLv/mq6UZMODMsPrp1TOLmcYZItHmwYarA+FYFHjIOnS86Cfe3SVZvuDllwRIlij2GtD6fv1iyU/2JaaGMhSz2txwueAfg9SM8GF+IzDru1KZivty+/4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=TwxeBCDe; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6516NhljE1861064, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780295023; bh=zGaiXVmbFcIR0uMWOBGPUlQVnflhuLNnVy3pOGlJPLM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=TwxeBCDercioP+E+C2GwUL7QiH7g/bn3YOP/qfrOWJum1QPTr1o1xgDDM70Ptk7lN
	 CsOfSz6LMYCSp1YNlPCO5DvECTtAoB4VjAlUiZ/mSFA6csSfDcNjz2PGO5XRQkAN0q
	 1VpVu3ykKmyIaIUhtEMSfBfgrLwZNY+dc8cjrN/R9vfd5ztwR0AM8goIo1nvQUN09V
	 LMuO9DmOAAjyNtI6ijsYG5+KqrkJs4GxRr6lfe57rQ/096uWFZwYxj9CBgjmd6+3VQ
	 vYIyRK49z1cYs141Bd+ltKCah1PqmGul+Ra+JhJzdiMWMW7Ozx2rRuRq3qXmxTC4U0
	 WBh9kdLNf1MaQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6516NhljE1861064
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 14:23:43 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Jun 2026 14:23:43 +0800
Received: from RTDOMAIN (172.21.42.225) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 1 Jun 2026 14:23:43 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
	<larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH] rtase: Workaround for IP fragmented UDP packet hardware bug
Date: Mon, 1 Jun 2026 14:23:41 +0800
Message-ID: <20260601062341.63981-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[justinlai0215@realtek.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293571-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3344561A291
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The hardware parser incorrectly interprets 319/320 in a short
IP fragmented UDP packet payload as standard PTP destination
ports and treats the fragment as a PTP packet for further
parsing.

If the transport data is smaller than RTASE_MIN_PAD_LEN, the
remaining data is insufficient for further parsing and causes
hardware TX hang.

Pad these packets so the transport data reaches
RTASE_MIN_PAD_LEN before transmitting to avoid triggering the
hardware issue.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase.h    |  3 ++
 .../net/ethernet/realtek/rtase/rtase_main.c   | 50 +++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index 9bd6872474c1..213fe2173b40 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -363,4 +363,7 @@ struct rtase_private {
 
 #define RTASE_MSS_MASK GENMASK(28, 18)
 
+#define RTASE_MIN_PAD_LEN      47
+#define RTASE_SHORT_PKT_THRESH 128
+
 #endif /* RTASE_H */
diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index bde9bccfb5a9..43a4aa275b62 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -61,6 +61,7 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/prefetch.h>
+#include <linux/ptp_classify.h>
 #include <linux/rtnetlink.h>
 #include <linux/tcp.h>
 #include <asm/irq.h>
@@ -1250,6 +1251,52 @@ static u32 rtase_tx_csum(struct sk_buff *skb, const struct net_device *dev)
 	return csum_cmd;
 }
 
+static bool rtase_skb_is_udp(struct sk_buff *skb)
+{
+	int no = skb_network_offset(skb);
+	struct ipv6hdr *i6h, _i6h;
+	struct iphdr *ih, _ih;
+
+	switch (vlan_get_protocol(skb)) {
+	case htons(ETH_P_IP):
+		ih = skb_header_pointer(skb, no, sizeof(_ih), &_ih);
+		return ih && ih->protocol == IPPROTO_UDP;
+	case htons(ETH_P_IPV6):
+		i6h = skb_header_pointer(skb, no, sizeof(_i6h), &_i6h);
+		return i6h && i6h->nexthdr == IPPROTO_UDP;
+	default:
+		return false;
+	}
+}
+
+static bool rtase_skb_pad(struct sk_buff *skb)
+{
+	bool has_trans = skb_transport_header_was_set(skb);
+	u32 pkt_len = skb->len;
+	u32 trans_data_len;
+	u16 dest_port;
+	u32 pad_len;
+
+	if (!(has_trans &&
+	      pkt_len < RTASE_SHORT_PKT_THRESH + RTASE_MIN_PAD_LEN &&
+	      rtase_skb_is_udp(skb)))
+		return true;
+
+	trans_data_len = skb_tail_pointer(skb) - skb_transport_header(skb);
+	if (trans_data_len >= offsetof(struct udphdr, len) &&
+	    trans_data_len < RTASE_MIN_PAD_LEN) {
+		dest_port = ntohs(udp_hdr(skb)->dest);
+
+		if (dest_port == PTP_EV_PORT || dest_port == PTP_GEN_PORT) {
+			pad_len = RTASE_MIN_PAD_LEN - trans_data_len;
+			if (__skb_put_padto(skb, skb->len + pad_len, false))
+				return false;
+		}
+	}
+
+	return true;
+}
+
 static int rtase_xmit_frags(struct rtase_ring *ring, struct sk_buff *skb,
 			    u32 opts1, u32 opts2)
 {
@@ -1363,6 +1410,9 @@ static netdev_tx_t rtase_start_xmit(struct sk_buff *skb,
 		opts2 |= rtase_tx_csum(skb, dev);
 	}
 
+	if (!rtase_skb_pad(skb))
+		goto err_dma_0;
+
 	frags = rtase_xmit_frags(ring, skb, opts1, opts2);
 	if (unlikely(frags < 0))
 		goto err_dma_0;
-- 
2.40.1


