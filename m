Return-Path: <netdev+bounces-297651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +wM8BIBRKWpJUwMAu9opvQ
	(envelope-from <netdev+bounces-297651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:58:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A535266903E
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:58:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=eWTIzyyf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297651-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297651-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7850308FDA4
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A20240628B;
	Wed, 10 Jun 2026 11:56:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE3040587D;
	Wed, 10 Jun 2026 11:56:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092564; cv=none; b=KW4cWPIx12htC96hME60RVZE4hj8yxU0u3n8VMSlWa6ESSxPvjQPaAwS9tmrOu1x5aDOzd6qc5lhM321lSjBSGdcR/U6rZPUCuWiNL3GExfHDIspFNIrxsewDqsUR6TnpmuHkKGbf0L6MQ8oj1lLlDm79/1/5XdUBEWxw1YdDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092564; c=relaxed/simple;
	bh=7/lHGfRtMcJC9TlHeFY0fvxGxdkPlXMxm12Dce+y1bE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ael/esbX9Ro0EmASl/O6wN81lBb4QIPefUm2b3C//+VZ7sMz2lN2nl1ASHIJn8a2R4QHJ6lcgInjrsoi3wOKluj0WYe9z3RlTFwi/utk631KfFoVtnQ+veueLoRTMqWWD1sTHmrTB308hobGPr7IL+9QlaNOrbZTj+ZSOejVf2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eWTIzyyf; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7kDf83125409;
	Wed, 10 Jun 2026 04:55:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=g
	HpJXcXhNJQAr0ugZl01tcO1x3nCb1g/h+iESzTV0u8=; b=eWTIzyyfvSEaDmRMm
	cAQBOtr7GIt1MS5JoeI5q6qclL1zuIGgEGvXBUE9hQ6fSOeG8ra/tARHA1kpg0jZ
	+ACYU4eYCFeBKALfnsBI6MWEsdLCUGe45LK5q2Tiqe4yxq33PaAbub6/jGu6QFxD
	gQ2zG6HmWFGN78YFV80OwcuoFvkdlQdKauFANmUkTxF7fg7sDCdTV4NU8glxr0uQ
	Pw1Ed4jp6XEyHVdAUUBGGI0WlBn21GVju5/jfXc67ncfPcwnwVHbOy+7VBDHJnY6
	9MYbKWi3Z3w9jCXjPKDMXeIUUToGMQkadbbih/dqRjAw/qTfxme5Qq6m9Yy2112v
	Rskjw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4epex1n7tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 04:55:52 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 10 Jun 2026 04:55:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 10 Jun 2026 04:55:51 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.66.228])
	by maili.marvell.com (Postfix) with ESMTP id 992423F708D;
	Wed, 10 Jun 2026 04:55:47 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v5 11/12] net: atlantic: add AQC113 TX timestamp polling and PTP TX classification
Date: Wed, 10 Jun 2026 17:24:47 +0530
Message-ID: <20260610115448.272-12-sukhdeeps@marvell.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260610115448.272-1-sukhdeeps@marvell.com>
References: <20260610115448.272-1-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDExMiBTYWx0ZWRfXwmz00QAq1J1x
 owkQg5pXYBgHaTdhH4gm3soGpQqYH1Cs8NQOHTytUwzW/PKKtO1uv6RBPCEQP5/VnwJ9lr9jfhk
 ZSTehBqbnKGFPCTcBfnzgnf6Je8fIuBDt4ERRacVod1gbaBXhmbe7Ua3zMvbPw/pHUWu9l37Eg8
 8aYHq/Soae/VqI2OW81aSSrMGcFzuCtkLkf+YoV+fwTJPITUhsqydGiMzK5ChE7lf7dRw8UaRFz
 OUP9y7cUV3Wu7lz68ogiTmAkG1GUjZf5rVkdQ57p18Ht4t9ohQizStoPBWH4jHncSw2ZXlOgPmt
 BXJUn9jSldLvOAjL+M/1gBJLPDpE4qGE/lV2xzaaMscAApI3ONnKMqTfkFYSFJ6R0T8iQEn0sX6
 pbcE3ocMZZYxcOywrqb/9JzDvrWuSOGAcmn6SIIl+aDhDE6r6y+HNHV7+oancPblIL9ItSgRflM
 FKpHeVCKuS8SUdsuAiA==
X-Proofpoint-ORIG-GUID: yODLXQ234zIzxG1gT-a0KdfbdmtfW_bM
X-Authority-Analysis: v=2.4 cv=Aa2B2XXG c=1 sm=1 tr=0 ts=6a2950c9 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=PEfJco_GQ0AasJOrgtIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: yODLXQ234zIzxG1gT-a0KdfbdmtfW_bM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297651-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:sukhdeeps@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A535266903E

From: Sukhdeep Singh <sukhdeeps@marvell.com>

aq_ring.h / aq_ring.c:
- Add ptp_ts_deadline field to aq_ring_s to track TX timestamp timeout.
- In aq_ring_tx_clean(): when hw_ring_tx_ptp_get_ts() returns 0 (HW not
  yet written back the timestamp), clear buff->is_mapped and buff->pa
  before breaking to prevent double dma_unmap on retry.  When
  ptp_ts_deadline expires, dequeue and drop the head of skb_ring to keep
  it in lockstep with buff_ring, then clear request_ts and free the skb
  via dev_kfree_skb_any() to unblock the ring.

aq_main.c:
- Add IPv6 PTP packet detection in aq_ndev_start_xmit() using
  ipv6_hdr()->nexthdr for ETH_P_IPV6 frames, steering them through
  aq_ptp_xmit() alongside the existing IPv4 path.
- Use PTP_EV_PORT/PTP_GEN_PORT constants instead of magic numbers 319/320.
- Remove duplicate aq_reapply_rxnfc_all_rules() and
  aq_filters_vlans_update()
  calls from aq_ndev_open() - now covered by aq_nic_start(), which also
  ensures filters are restored correctly after PM resume.

aq_nic.c:
- Move aq_reapply_rxnfc_all_rules() and aq_filters_vlans_update() into
  aq_nic_start() after hardware init, replacing the duplicate calls that
  were removed from aq_ndev_open().

Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
---
 .../net/ethernet/aquantia/atlantic/aq_main.c  | 30 ++++++++++---------
 .../net/ethernet/aquantia/atlantic/aq_nic.c   |  8 +++++
 .../net/ethernet/aquantia/atlantic/aq_ptp.c   | 12 ++++++++
 .../net/ethernet/aquantia/atlantic/aq_ptp.h   |  2 ++
 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 26 +++++++++++++++-
 .../net/ethernet/aquantia/atlantic/aq_ring.h  |  1 +
 6 files changed, 64 insertions(+), 15 deletions(-)

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
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index ef9447810071..09c90c969fb1 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -496,6 +496,14 @@ int aq_nic_start(struct aq_nic_s *self)
 			goto err_exit;
 	}
 
+	err = aq_reapply_rxnfc_all_rules(self);
+	if (err < 0)
+		goto err_exit;
+
+	err = aq_filters_vlans_update(self);
+	if (err < 0)
+		goto err_exit;
+
 	err = aq_ptp_ring_start(self);
 	if (err < 0)
 		goto err_exit;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
index 7486a28d7ff8..16592e11b82c 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
@@ -268,6 +268,18 @@ static void aq_ptp_tx_timeout_check(struct aq_ptp_s *aq_ptp)
 	}
 }
 
+void aq_ptp_tx_skb_drop_head(struct aq_nic_s *aq_nic)
+{
+	struct aq_ptp_s *aq_ptp = aq_nic->aq_ptp;
+	struct sk_buff *skb;
+
+	if (!aq_ptp)
+		return;
+	skb = aq_ptp_skb_get(&aq_ptp->skb_ring);
+	if (skb)
+		dev_kfree_skb_any(skb);
+}
+
 /* aq_ptp_adjfine
  * @ptp: the ptp clock structure
  * @ppb: parts per billion adjustment from base
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h
index 5e643ec7cc06..1658ef788de8 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h
@@ -53,6 +53,7 @@ void aq_ptp_service_task(struct aq_nic_s *aq_nic);
 void aq_ptp_tm_offset_set(struct aq_nic_s *aq_nic, unsigned int mbps);
 
 void aq_ptp_clock_init(struct aq_nic_s *aq_nic);
+void aq_ptp_tx_skb_drop_head(struct aq_nic_s *aq_nic);
 
 /* Traffic processing functions */
 int aq_ptp_xmit(struct aq_nic_s *aq_nic, struct sk_buff *skb);
@@ -123,6 +124,7 @@ static inline void aq_ptp_service_task(struct aq_nic_s *aq_nic) {}
 static inline void aq_ptp_tm_offset_set(struct aq_nic_s *aq_nic,
 					unsigned int mbps) {}
 static inline void aq_ptp_clock_init(struct aq_nic_s *aq_nic) {}
+static inline void aq_ptp_tx_skb_drop_head(struct aq_nic_s *aq_nic) {}
 static inline int aq_ptp_xmit(struct aq_nic_s *aq_nic, struct sk_buff *skb)
 {
 	return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index e270327e47fd..8ff07de2bd52 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -311,6 +311,30 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
 		if (likely(!buff->is_eop))
 			goto out;
 
+		if (unlikely(buff->request_ts) &&
+		    self->aq_nic->aq_hw_ops->hw_ring_tx_ptp_get_ts) {
+			u64 ts = self->aq_nic->aq_hw_ops->hw_ring_tx_ptp_get_ts(self);
+
+			if (!ts) {
+				if (time_after(jiffies,
+					       self->ptp_ts_deadline)) {
+					/* Timeout: drain skb_ring head to
+					 * keep in sync with buff_ring
+					 */
+					aq_ptp_tx_skb_drop_head(self->aq_nic);
+					buff->request_ts = 0;
+					dev_kfree_skb_any(buff->skb);
+					buff->skb = NULL;
+					goto out;
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
@@ -570,7 +594,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
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


