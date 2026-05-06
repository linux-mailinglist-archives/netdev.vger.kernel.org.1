Return-Path: <netdev+bounces-284856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGN1Cf5L+2nWYwMAu9opvQ
	(envelope-from <netdev+bounces-284856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:11:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 972D94DBC8E
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A2C630ED8D2
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 13:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8A947F2F3;
	Wed,  6 May 2026 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gpjhTUpW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B119A480DE1;
	Wed,  6 May 2026 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075946; cv=none; b=QtGI197SSxhCe0yIaZxGnamfjF2t5hEaH5S2QFGpn77biq1BDlgW7PSmbeG120i6DcaaQpVApumj79a7/842HIvZqNtvwglV7xPqiiy2iTep8Ytps1VgpJ626pz+Q54B4N5Isd0lSD7wHKCDvrQW7Ry6xI016cbwOH9S27VNYqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075946; c=relaxed/simple;
	bh=ztja0mEiadKt1ZyOXBgkzR+1THc5X8M+0eJvreWX3P4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1KnpCpOvuXY/31I76IoMTYgdEbVuEoPtxuRdCZPFWToDeYWBnou/GZTNMvn/HY6iTDBJ5cXxKCVj6zTAG0pXxvYuasaKyfPtkXzUbQ4e+GmYIbnCmcTIXx5hlI48Z3DGfK4mTDP7lFPQ2W+ZzPhEBfznQ5b5Uz/VCSWvp2Llm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gpjhTUpW; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646BrSjb3902995;
	Wed, 6 May 2026 06:58:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
	tC0aX4znzx5pOhy2xcatdgVjUjoH1fQHnAw4FDLmdc=; b=gpjhTUpWl89Y0vKbZ
	ST1G1nyzocWvC/Kwu9yqIBmvrlgjasBChay2sKbfj9e7K9dZePQJdCh9fOztr38Z
	Fr22xxjwFzHkNjysLlR3qrPtW6W2hRXwyJTsrBypdKYMAqNgKeCtTiaDVV1C3euz
	G8AZ9iuhF8dsUzzR5TC8uKF4plhF4vLtkLqAgVpcz8sf37sG5GwV6GqvUu78m7Q3
	Cte1w2Eq7e2kb7z8Nxi2zaubSX9TS8REfpGHcqnqudOmCYa6ykdMTIT6b6gdasOr
	KVQmAWUoSbeqgjGxAq80A5cadLp60xNXDGY6OLxgnlCfmsyF4wJ6mC3Tkaz1e0IG
	+L6Yw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e026pgm8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 06:58:55 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 6 May 2026 06:58:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 6 May 2026 06:58:54 -0700
Received: from BG-LT92649.marvell.com (BG-LT92649.marvell.com [10.28.166.218])
	by maili.marvell.com (Postfix) with ESMTP id A84863F708A;
	Wed,  6 May 2026 06:58:49 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <irusskikh@marvell.com>, <epomozov@marvell.com>,
        <richardcochran@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        Sukhdeep Singh <sukhdeeps@marvell.com>
Subject: [PATCH net-next 7/9] net: atlantic: add AQC113 PTP traffic class and TX path setup TX path setup
Date: Wed, 6 May 2026 19:27:04 +0530
Message-ID: <20260506135706.2834-8-sukhdeeps@marvell.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260506135706.2834-1-sukhdeeps@marvell.com>
References: <20260506135706.2834-1-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Y/LIdBeN c=1 sm=1 tr=0 ts=69fb491f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=wn5G0mF7TSBqfe3wV-wA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: WCyvz2MbHQ5LBb9xk96-aumjG0-2p0O4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzNyBTYWx0ZWRfX8JNjm1GCdbck
 YBgNcVFuzhKXRyiMlLD2toznOZBQBNie+nIGzQeBvUnTTdEo7iK1KvCZFbZzBRkCwfMov19Uben
 TJlnU+IVNeVwBRSohPtIn5mrjBQRmPJMQKgR++JWrVCopFNPslTlhDHn9uZrS+5iWTUSuhEzbcr
 PGtI6buDf0fz2ARh/rJxLS3DHyDErR6+GxVcbN9I/HWdF1/Bwql/rzGsrCO7c8HzUf+vXNwgkF/
 m8jiPOL59543uT9H1EyY5vbWh0XXIzNaNEADuwbu7Ic3tIkZ8Z8dfoY80EqoYWDmKENdgse6GmZ
 KWu/vMnjXP+tCX+Qp8eCm4k6DndmekYdqewigz2w8dMKGC4tXCqmOtb8YNq64FH9Nmu3BapxjGh
 g4YruaT/miJ91fHrqvlKZToWOyT7PPglgWa2CA+xPtFA+BRO8KPCPsWLxmJeSzvJwQOTldGAKi8
 mnkN5QkfTbwGHMsMANA==
X-Proofpoint-ORIG-GUID: WCyvz2MbHQ5LBb9xk96-aumjG0-2p0O4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Rspamd-Queue-Id: 972D94DBC8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284856-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

From: Sukhdeep Singh <sukhdeeps@marvell.com>

Add PTP traffic class (TC) buffer reservation and TX path
improvements for AQC113:

- Reserve dedicated TX and RX buffer space for PTP TC when PTP is
  enabled, reducing user TC buffers accordingly (TX: 8KB, RX: 16KB).
- Configure PTP TC with no flow control and highest priority
  scheduling to ensure timely PTP packet transmission.
- Enable multicast frame tagging (accept_all_mc_packets) so the
  Action Resolver Table (ART) can match and steer PTP multicast
  traffic to the correct TC/queue based on RPF input tags.

TX path improvements:
- Enable extended PCIe tag mode (32-255) when hardware supports it,
  with increased TX data and descriptor read request limits for
  improved throughput.

Also simplify RSS queue calculation in hw_atl2_hw_rss_set() by
extracting to a local variable and use unsigned types for loop
variables to match their usage.

Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
---
 .../aquantia/atlantic/hw_atl2/hw_atl2.c       | 52 ++++++++++++++++---
 .../atlantic/hw_atl2/hw_atl2_internal.h       |  4 +-
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index e58bfff38670..c71e8d1adfc9 100644
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
@@ -429,6 +466,9 @@ static void hw_atl2_hw_init_new_rx_filters(struct aq_hw_s *self)
 	u8 index;
 	int i;
 
+	/* tag MC frames always */
+	hw_atl_rpfl2_accept_all_mc_packets_set(self, 1);
+
 	/* Action Resolver Table (ART) is used by RPF to decide which action
 	 * to take with a packet based upon input tag and tag mask, where:
 	 *  - input tag is a combination of 3-bit VLan Prio (PTP) and
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


