Return-Path: <netdev+bounces-289970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC74CgDHDWr93AUAu9opvQ
	(envelope-from <netdev+bounces-289970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:36:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 806E458FB9B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC20331BE0E6
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B363E834B;
	Wed, 20 May 2026 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aIvb0qMw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED463E6385;
	Wed, 20 May 2026 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286417; cv=none; b=TNCpbUdWyMLW8MS7JCQ8Ydrg0hppTDbFYdDQdJEkO/xBQ9nuXu29QYnaCGbWuPGqG/HlbReJAOh22blb4DmS1dO7YRH+X1Uj0koRzrWe5KtvWdhCZgySwK5HrfQd2WCemyPbZZA2EwWY9IeLGzoWgutTbvCwlNPZjusaK7/fHQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286417; c=relaxed/simple;
	bh=uMJ1rBeb+cFJNpKd70G1Ilpr4hB0EpddhwjqXUI17jU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5haGwF5bN9LyrapgOqAGaecZc6QB6BEcPSXCK82g0XLuRdUNrOrxYe1RIDtnlwR7y657oRIURF8odNAiHXSXJ612kxlEFFLQZUG2xp4dMGGbMOJKed7V0gZ7iO2e7BNwuZywNL6YNaVod/2oeiBYTghv/S1+YMBbXHIlVHngps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aIvb0qMw; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K3icET3008986;
	Wed, 20 May 2026 07:12:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=f
	tIzJbhcdhXplQ6XzXevUKNqMKt3T7JQCf8+zwxSrNE=; b=aIvb0qMw4rDO4Snz/
	kph/c+Mw3ie54TguNxCODzE1Tp+ZT27ejUFPUrUOrtd7VyFIA3zt2FmMarhUBfeG
	6zmn2kQ7Vm5g5crSgQYdeajsbDeYL9+9OZobhb+gvVbWNQCTOOCyU0oqDs1xy2ZA
	xDzUMWcO6H6RHYsLBBfcVzGJ5x3gK8Vu71EITGez7p/XFF2FMf13wysRYY669elk
	iR/BzxGDsn+nR5VQsdc6Wiu2fJuajc+f7VwbJes+9JCj0h0dQEUiINzEmh7bKJ/l
	SfJvuyT6lQ9RXg3nsRQqDdWq5zUOBmY/5HvPskD1Qs6gywgOPdLqIR8LK+02VU7X
	9BiPQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e8jywd2h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 07:12:41 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 May 2026 07:12:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 May 2026 07:12:40 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.74.182])
	by maili.marvell.com (Postfix) with ESMTP id 0FA655B6942;
	Wed, 20 May 2026 07:12:34 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v3 11/12] net: atlantic: add AQC113 TX timestamp polling and PTP TX classification
Date: Wed, 20 May 2026 19:40:44 +0530
Message-ID: <20260520141046.2151-12-sukhdeeps@marvell.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260520141046.2151-1-sukhdeeps@marvell.com>
References: <20260520141046.2151-1-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: cnLmMJqMzQ9ylbF8qCzmpnlkx3uCDANa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzOCBTYWx0ZWRfX4BDkhWNDjlDK
 fNY/SPJk1ybYcWcdusNQFOflrf/5ld5/RYdnFbb85S63SUCfZmw4iKwnnmx0d91n4IX/w+0GB5E
 FAjn3v0sa33OT73TxG+vo/mxamIb6qOtfx1xZHQU+/wcUJay4NSQci24JtbHkRUfx1Nu9Lk8T0y
 HN4YKFehK5o2N3I/yM9iGVh5Rj7mWFgLvjCTp+C3ehQwTVNKmA3MbWlATSBhkn3uy3yJrHlxc2d
 revVLnqRCVW83YYPn0zbVb8uAm0sWWEIqRbU0OYKRzrYACg9uFoD9rv8yriX2js4DMWfabTDsDM
 E97gBuF5dc+EN1OGhYC0OP8duHH/lDuTLSqgWK1Qen8JeOLmA6K00K/pYfLIgd8WndGI/gpCmbp
 4Bk5R1jlIv0tSteW+mf6Z9GOTnzvzsnzCJQ3sv2XSPd/+YBybJCYCR/x30Hhs+GW3f3L7UA9Qmd
 dlMYOuG45PSQL3Zttmg==
X-Proofpoint-ORIG-GUID: cnLmMJqMzQ9ylbF8qCzmpnlkx3uCDANa
X-Authority-Analysis: v=2.4 cv=QbNWeMbv c=1 sm=1 tr=0 ts=6a0dc159 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=75Hvxm_qA_5bnyVo-WkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289970-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,marvell.com:email,marvell.com:mid,marvell.com:dkim];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 806E458FB9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sukhdeep Singh <sukhdeeps@marvell.com>

aq_ring.h / aq_ring.c:
- Add ptp_ts_deadline field to aq_ring_s to track TX timestamp timeout.
- In aq_ring_tx_clean(): when hw_ring_tx_ptp_get_ts() returns 0 (HW not
  yet written back the timestamp), clear buff->is_mapped and buff->pa
  before breaking to prevent double dma_unmap on retry.  When
  ptp_ts_deadline expires, clear request_ts and free the skb via
  dev_kfree_skb_any() to unblock the ring if HW never delivers the
  timestamp.

aq_main.c:
- Add IPv6 PTP packet detection in aq_ndev_start_xmit() using
  ipv6_hdr()->nexthdr for ETH_P_IPV6 frames, steering them through
  aq_ptp_xmit() alongside the existing IPv4 path.
- Use PTP_EV_PORT/PTP_GEN_PORT constants instead of magic numbers 319/320.
- Remove stale aq_ndev_open() PTP call that was moved to aq_nic_start().

Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
---
 .../net/ethernet/aquantia/atlantic/aq_main.c  | 30 ++++++++++---------
 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 22 +++++++++++++-
 .../net/ethernet/aquantia/atlantic/aq_ring.h  |  1 +
 3 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
index 4ef4fe64b8ac..1da14786fe5c 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
@@ -19,8 +19,10 @@
 #include <linux/netdevice.h>
 #include <linux/module.h>
 #include <linux/ip.h>
+#include <linux/ipv6.h>
 #include <linux/udp.h>
 #include <net/pkt_cls.h>
+#include <linux/ptp_classify.h>
 #include <net/pkt_sched.h>
 #include <linux/filter.h>
 
@@ -68,14 +70,6 @@ int aq_ndev_open(struct net_device *ndev)
 	if (err < 0)
 		goto err_exit;
 
-	err = aq_reapply_rxnfc_all_rules(aq_nic);
-	if (err < 0)
-		goto err_exit;
-
-	err = aq_filters_vlans_update(aq_nic);
-	if (err < 0)
-		goto err_exit;
-
 	err = aq_nic_start(aq_nic);
 	if (err < 0) {
 		aq_nic_stop(aq_nic);
@@ -113,12 +107,20 @@ static netdev_tx_t aq_ndev_start_xmit(struct sk_buff *skb, struct net_device *nd
 		 * and hardware PTP design of the chip. Otherwise ptp stream
 		 * will fail to sync
 		 */
-		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) ||
-		    unlikely((ip_hdr(skb)->version == 4) &&
-			     (ip_hdr(skb)->protocol == IPPROTO_UDP) &&
-			     ((udp_hdr(skb)->dest == htons(319)) ||
-			      (udp_hdr(skb)->dest == htons(320)))) ||
-		    unlikely(eth_hdr(skb)->h_proto == htons(ETH_P_1588)))
+		if (unlikely(skb->protocol == htons(ETH_P_IP) &&
+			     ip_hdr(skb)->protocol == IPPROTO_UDP &&
+			     (udp_hdr(skb)->dest == htons(PTP_EV_PORT) ||
+			      udp_hdr(skb)->dest == htons(PTP_GEN_PORT))))
+			return aq_ptp_xmit(aq_nic, skb);
+
+		/* PTP over IPv6 does not use extension headers */
+		if (unlikely(skb->protocol == htons(ETH_P_IPV6) &&
+			     ipv6_hdr(skb)->nexthdr == IPPROTO_UDP &&
+			     (udp_hdr(skb)->dest == htons(PTP_EV_PORT) ||
+			      udp_hdr(skb)->dest == htons(PTP_GEN_PORT))))
+			return aq_ptp_xmit(aq_nic, skb);
+
+		if (unlikely(eth_hdr(skb)->h_proto == htons(ETH_P_1588)))
 			return aq_ptp_xmit(aq_nic, skb);
 	}
 #endif
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index e270327e47fd..87d680590ef2 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -311,6 +311,26 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
 		if (likely(!buff->is_eop))
 			goto out;
 
+		if (unlikely(buff->request_ts) &&
+		    self->aq_nic->aq_hw_ops->hw_ring_tx_ptp_get_ts) {
+			u64 ts = self->aq_nic->aq_hw_ops->hw_ring_tx_ptp_get_ts(self);
+
+			if (!ts) {
+				if (time_after(jiffies,
+					       self->ptp_ts_deadline)) {
+					/* Timeout: free skb, unblock ring */
+					buff->request_ts = 0;
+					dev_kfree_skb_any(buff->skb);
+					buff->skb = NULL;
+				} else {
+					buff->is_mapped = 0;
+					buff->pa = 0U;
+					break;
+				}
+			}
+
+			aq_ptp_tx_hwtstamp(self->aq_nic, ts);
+		}
 		if (buff->skb) {
 			u64_stats_update_begin(&self->stats.tx.syncp);
 			++self->stats.tx.packets;
@@ -570,7 +590,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 							    self->hw_head);
 
 				if (unlikely(!is_rsc_completed) ||
-						frag_cnt > MAX_SKB_FRAGS) {
+				    frag_cnt > MAX_SKB_FRAGS) {
 					err = 0;
 					goto err_exit;
 				}
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
index e578fe04d22c..a70b880ada67 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
@@ -154,6 +154,7 @@ struct aq_ring_s {
 	struct bpf_prog *xdp_prog;
 	enum atl_ring_type ring_type;
 	struct xdp_rxq_info xdp_rxq;
+	unsigned long ptp_ts_deadline;
 };
 
 struct aq_ring_param_s {
-- 
2.43.0


