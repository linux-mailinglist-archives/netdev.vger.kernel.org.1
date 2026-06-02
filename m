Return-Path: <netdev+bounces-294247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lKceMU/jHmo3YgAAu9opvQ
	(envelope-from <netdev+bounces-294247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:06:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 276B662F23F
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:06:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=PI5AUJx2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294247-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294247-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19452303D11E
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081FF3E8C55;
	Tue,  2 Jun 2026 13:56:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CA03E8C67;
	Tue,  2 Jun 2026 13:56:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408578; cv=none; b=UYmqvbrsyLFIKjxBBDpmLxCxKEWHbo8VnOpUIphbsvx/sPCBKIbZA02eBeaBn2lDka38O+taz1ydJMYNtpogDXfdOhLvJIrBLLkz/yruYMaM6D/ez5lIKRZa1GHNEKRjAfH35KmxYRb69KirF8ePfTWYBvaiTTzxFWqnueZlNBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408578; c=relaxed/simple;
	bh=T6GZWKC3uW7mNQNk5jBWXHtsXd5yu5Fv/Tvn33AYmP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rteNhMGCpCE4EK5uT/vw76+X7aIJc+/Df+fL5GxvCmiShHRddiZS9x/NS2j41hWHL8pMYGKuMmhFKGNohDocf1MamQhRRUszulCyCunIXezaheMNpszqefyNXeeqAfxpJucgSZScTDkkoR22od4l4KBhrvxBqktQDEUGPWrXIjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PI5AUJx2; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65270hOp1231225;
	Tue, 2 Jun 2026 06:55:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=f
	uzL5qEzoyKxHbXiSjZ3tCBg/DxI3fe+ztrGaPgzJS8=; b=PI5AUJx2ZcRgCJq0P
	PZHetT3wLxspjdlrprN0aBaQodnL58YjmiVUkyysv4m1pVS7z7z6mfsW8sYxvWOu
	O9oE7FfQdm4QRUgut8UYMghtkgxuYXwJG1LJqzPblX3f0gQ98I7ngdt96Kwdp9Uu
	7MjFZH1riHQxnx8JpGM+2xJ+x2kooQ7k3r9uwa29lpEJzx0Qi65XVD9EtZaX4gFi
	lO/b72cvjuo5WiDyzttgmvanGw7xf/N5KJEr9r1cOjQdmspMcQXaZLvHHTedN2z7
	uddwEJACFdVc4H/OTXuvAgKF6ITZZj8udpikhAFx5H+8wb+8ItkSrGD0S7fll8/s
	OHicQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ega3b8qbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 06:55:58 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 2 Jun 2026 06:55:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 2 Jun 2026 06:55:57 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.71.86])
	by maili.marvell.com (Postfix) with ESMTP id 40F573F7062;
	Tue,  2 Jun 2026 06:55:52 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v4 11/12] net: atlantic: add AQC113 TX timestamp polling and PTP TX classification
Date: Tue, 2 Jun 2026 19:24:51 +0530
Message-ID: <20260602135452.516-12-sukhdeeps@marvell.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260602135452.516-1-sukhdeeps@marvell.com>
References: <20260602135452.516-1-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEzMyBTYWx0ZWRfXy9/wU5PN0p4u
 Zw42kbRZmn7VBnBCFaxIVRkB1Xbg3gj7Pgrz0pEgCNoeQ4cRYyW3+4hT0vtXW3IbSLotRrbbKeH
 j1mlXhQ0vPhGXC3neACz45S+ZJ6OSJr9a1cjygWFubzT2xjqDYAu9m/Pb6RiDavK/6cJOSk9bJf
 NJJs5vxi3ihT4hfM7bZ3IoxMikVwIxVSaIpn7yTM1Mi1tO6ZsS8roVF/NUNJB6VDvRc+eTgYRns
 iRvnY7LaHQZBkhXMBhtFUF5R9G0u9J2IiMO1r3I0eqeRneZaDGlWIxXeKiSlJrWCgz0BAtSWvvE
 LjDOlyjnaVpwEn7chU6xQUyGctSe1AmI3kLxQMUlOSqXr7eS7/U3c2lrjvQEeKv11EXeJCneLgf
 cYWItmfrnMt7m8xIXZeAHQz/FRi/BzDnPksjlLw4IElOD/fNaL9gamSkG0o3LSe00mj3LM8haQJ
 +e0miHLPZB3DhhnJMvA==
X-Authority-Analysis: v=2.4 cv=cLjQdFeN c=1 sm=1 tr=0 ts=6a1ee0ee cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=N-uMVKWTPtX7_nDEHIcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: F_2YyOnmfG5vn2ZbhbXZxYZJb6W6_dx1
X-Proofpoint-GUID: F_2YyOnmfG5vn2ZbhbXZxYZJb6W6_dx1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294247-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:sukhdeeps@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:mid,marvell.com:dkim,marvell.com:from_mime,marvell.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 276B662F23F

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

aq_nic.c:
- Move aq_reapply_rxnfc_all_rules() and aq_filters_vlans_update() into
  aq_nic_start() after hardware init, replacing the duplicate calls that
  were removed from aq_ndev_open().

Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
---
 .../net/ethernet/aquantia/atlantic/aq_main.c  | 30 ++++++++++---------
 .../net/ethernet/aquantia/atlantic/aq_nic.c   |  8 +++++
 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 23 +++++++++++++-
 .../net/ethernet/aquantia/atlantic/aq_ring.h  |  1 +
 4 files changed, 47 insertions(+), 15 deletions(-)

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
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index e270327e47fd..dd1af3deb2d1 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -311,6 +311,27 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
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
@@ -570,7 +591,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
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


