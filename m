Return-Path: <netdev+bounces-289965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAJODALFDWql3AUAu9opvQ
	(envelope-from <netdev+bounces-289965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:28:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 571EB58F9E1
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11BDC3092F23
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F83B3E866C;
	Wed, 20 May 2026 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MTeaxeHa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB13E7BDE;
	Wed, 20 May 2026 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286367; cv=none; b=Gh1LGDiFZ5jYArVK+9P2q+y9Vv2J29wOrZhTbIIg5u8GQrA3bGOyUyPsH4qV7cRTb4ce8qaRY/gv42ZvWOYQhyq2HKsIr7B2WSF461z7oVmKdmPHnu9mb6DS1EH2eteKdug+8NUUYHrPYwybebR4X1r7NuMvAUI/x4RJ+GLQ6EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286367; c=relaxed/simple;
	bh=ejWDSdsseNeZK0IrRjI/qPlDbxe2//gD7sAplCZE59Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJxi8thlkTxL6m7JHkX//g1nOYKY75a/POojiBronUuTrzf4leN72RpXzOefDadPvwpf+1F3uglk+FbyXbop8Z9UxY2xIKH2m0/V0et54O4790PZnHv8mbfbxQd2Zekdo1kJ4ob4kk5H6i8po3sN0X9NCSS9r7Ytpsz4HGwEtRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MTeaxeHa; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K7WCPW2111256;
	Wed, 20 May 2026 07:12:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
	ubNicQd9VQMtqItCAc6RPq4yyCdPnryEfS126c4fCA=; b=MTeaxeHaeQY5bV1q8
	lHy+vT3ngIq/0sCLEgMYcoC3JHHS1iaFr7Q54i1BKSaJeVwqAZnOv0GEIDTJwYHp
	N0cEL7tuLMDE+N12moBCiTdXfPAr2FUdSFA6rJHrCxe6MYmG9WwflEulAgf+4Rm+
	8UXDi2uqi5SRnEB7oQg1jUR6VtvZ/KlXgb+yotHUKgSw3JpUG1+Oo7Ob1U/i3d2X
	BU2NhjcvsVg8pmCqim2at7tG9ql/zGgla/IHbb7CL0QFpKeN9Gtp1laYetakyd72
	zDbTLS8DrylFCIYzOzlColnZbVtwGGlfq2QjmomeXiyQRquYrQ6/wXt4GwksLMXx
	20MnA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e8cfmdvgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 07:12:16 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 May 2026 07:12:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 May 2026 07:12:16 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.74.182])
	by maili.marvell.com (Postfix) with ESMTP id DECC85B693E;
	Wed, 20 May 2026 07:12:09 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v3 8/12] net: atlantic: add AQC113 PTP traffic class and  TX path setup
Date: Wed, 20 May 2026 19:40:41 +0530
Message-ID: <20260520141046.2151-9-sukhdeeps@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=JYuMa0KV c=1 sm=1 tr=0 ts=6a0dc140 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=Dpi8SI6RF_br7PiJ-gsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: QcUixBbv3PBxGHGB-xbakJC3Emrf6PUP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzOCBTYWx0ZWRfXwbepMFCPxIMQ
 2KEEDmt/xn1eUgJ+bmoun25QwhKeDMAHQDYMzzJMNtX8Hh7/2zzilXHvAYUvOzduD5un6uisjSg
 gs2vo7+vBmVTCg+E82akjpEL27ExOQik0IgMhH3S2cYAprrKqk/2+8f/dGaBAnspxwQu+JzJGtG
 2e0WeiaSvycZDd/y1rg6qnR8qXUCEb7MGlFOYAnKnlD8qGKUCKfQn6b2SwBUPHJDi8p33PkNGdh
 sROy/2ahq1mUdyW+AfKvExyZV044idi5a6bPe4UuYq2jc+uXIJNVeVo8pyq4vJmcIKkfyqEVJuV
 SSxMA4CsRcP0DwyI8Ttl4/spfo1oovU2sXfaiFhBK4D67dx49EMjrqcsVdIuZq6cRDnWjkBYw9r
 LPHulJtuOiDS2BjJ+W4N3Rdfz1rdVqy02r7UOhULxguZ5Q6BWsmT9jkfVQyS2AlgtzGRcujqExR
 jX3fQModDhqNztsFprw==
X-Proofpoint-GUID: QcUixBbv3PBxGHGB-xbakJC3Emrf6PUP
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289965-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,marvell.com:email,marvell.com:mid,marvell.com:dkim];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 571EB58F9E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sukhdeep Singh <sukhdeeps@marvell.com>

Add PTP traffic class (TC) buffer reservation and TX path
improvements for AQC113:

- Reserve dedicated TX and RX buffer space for PTP TC when PTP is
  enabled, reducing user TC buffers accordingly (TX: 8KB, RX: 16KB).
- Configure PTP TC with no flow control and highest priority
  scheduling to ensure timely PTP packet transmission.

TX path improvements:
- Increase TX data and descriptor read-request limits when firmware
  has already enabled extended PCIe tag mode.

Also simplify RSS queue calculation in hw_atl2_hw_rss_set() by
extracting to a local variable and use unsigned types for loop
variables to match their usage.

Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
---
 .../aquantia/atlantic/hw_atl2/hw_atl2.c       | 49 ++++++++++++++++---
 .../atlantic/hw_atl2/hw_atl2_internal.h       |  4 +-
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index a8ab27367dc1..39d84576ca51 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
@@ -151,6 +151,24 @@ static int hw_atl2_hw_reset(struct aq_hw_s *self)
 	return err;
 }
 
+static int hw_atl2_tc_ptp_set(struct aq_hw_s *self)
+{
+	/* Init TC2 for PTP_TX */
+	hw_atl_tpb_tx_pkt_buff_size_per_tc_set(self, HW_ATL2_PTP_TXBUF_SIZE,
+					       AQ_HW_PTP_TC);
+
+	/* Init TC2 for PTP_RX */
+	hw_atl_rpb_rx_pkt_buff_size_per_tc_set(self, HW_ATL2_PTP_RXBUF_SIZE,
+					       AQ_HW_PTP_TC);
+
+	/* No flow control for PTP */
+	hw_atl_rpb_rx_xoff_en_per_tc_set(self, 0U, AQ_HW_PTP_TC);
+
+	hw_atl2_tpb_tps_highest_priority_tc_set(self, AQ_HW_PTP_TC);
+
+	return aq_hw_err_from_flags(self);
+}
+
 static int hw_atl2_hw_queue_to_tc_map_set(struct aq_hw_s *self)
 {
 	struct aq_nic_cfg_s *cfg = self->aq_nic_cfg;
@@ -209,6 +227,11 @@ static int hw_atl2_hw_qos_set(struct aq_hw_s *self)
 	unsigned int prio = 0U;
 	u32 tc = 0U;
 
+	if (cfg->is_ptp) {
+		tx_buff_size -= HW_ATL2_PTP_TXBUF_SIZE;
+		rx_buff_size -= HW_ATL2_PTP_RXBUF_SIZE;
+	}
+
 	/* TPS Descriptor rate init */
 	hw_atl_tps_tx_pkt_shed_desc_rate_curr_time_res_set(self, 0x0U);
 	hw_atl_tps_tx_pkt_shed_desc_rate_lim_set(self, 0xA);
@@ -242,6 +265,9 @@ static int hw_atl2_hw_qos_set(struct aq_hw_s *self)
 		hw_atl_b0_set_fc(self, self->aq_nic_cfg->fc.req, tc);
 	}
 
+	if (cfg->is_ptp)
+		hw_atl2_tc_ptp_set(self);
+
 	/* QoS 802.1p priority -> TC mapping */
 	for (prio = 0; prio < 8; ++prio)
 		hw_atl_rpf_rpb_user_priority_tc_map_set(self, prio,
@@ -259,8 +285,9 @@ static int hw_atl2_hw_rss_set(struct aq_hw_s *self,
 	u8 *indirection_table = rss_params->indirection_table;
 	const u32 num_tcs = aq_hw_num_tcs(self);
 	u32 rpf_redir2_enable;
-	int tc;
-	int i;
+	u32 queue;
+	u32 tc;
+	u32 i;
 
 	rpf_redir2_enable = num_tcs > 4 ? 1 : 0;
 
@@ -268,10 +295,9 @@ static int hw_atl2_hw_rss_set(struct aq_hw_s *self,
 
 	for (i = HW_ATL2_RSS_REDIRECTION_MAX; i--;) {
 		for (tc = 0; tc != num_tcs; tc++) {
-			hw_atl2_new_rpf_rss_redir_set(self, tc, i,
-						      tc *
-						      aq_hw_q_per_tc(self) +
-						      indirection_table[i]);
+			queue = tc * aq_hw_q_per_tc(self) +
+				indirection_table[i];
+			hw_atl2_new_rpf_rss_redir_set(self, tc, i, queue);
 		}
 	}
 
@@ -415,9 +441,20 @@ static int hw_atl2_hw_init_tx_path(struct aq_hw_s *self)
 
 	hw_atl2_tpb_tx_buf_clk_gate_en_set(self, 0U);
 
+	if (hw_atl2_phi_ext_tag_get(self)) {
+		hw_atl2_tdm_tx_data_read_req_limit_set(self, 0x7F);
+		hw_atl2_tdm_tx_desc_read_req_limit_set(self, 0x0F);
+	}
+
 	return aq_hw_err_from_flags(self);
 }
 
+/* Initialise new rx filters
+ * L2 promisc OFF
+ * VLAN promisc OFF
+ *
+ * User priority to TC
+ */
 static void hw_atl2_hw_init_new_rx_filters(struct aq_hw_s *self)
 {
 	u8 *prio_tc_map = self->aq_nic_cfg->prio_tc_map;
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
index fc086d84fb91..31d7cae6641a 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
@@ -27,8 +27,10 @@
 #define HW_ATL2_INT_MASK  (0xFFFFFFFFU)
 
 #define HW_ATL2_TXBUF_MAX              128U
-#define HW_ATL2_RXBUF_MAX              192U
+#define HW_ATL2_PTP_TXBUF_SIZE           8U
 
+#define HW_ATL2_RXBUF_MAX              192U
+#define HW_ATL2_PTP_RXBUF_SIZE          16U
 #define HW_ATL2_RSS_REDIRECTION_MAX 64U
 
 #define HW_ATL2_TC_MAX 8U
-- 
2.43.0


