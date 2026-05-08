Return-Path: <netdev+bounces-285783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOGeHwbT/Wl2jgAAu9opvQ
	(envelope-from <netdev+bounces-285783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:11:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A65804F6285
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A73073034573
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4FE3D0918;
	Fri,  8 May 2026 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jacg2AEL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4013B52E1;
	Fri,  8 May 2026 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241901; cv=none; b=Pcq++BLavw44BYo9dZWOYXn5WW0JSL1gtKpr5jt0KCbQQaODEHz8OhtWeUTGOWgcRD2jc2bW0RZcb1eLU9G1mFhc8TIvk2NrOjOXupBFyZ31R5RPXi+1sjbkiA2EjQXtJyLs33DVEdqutEricMWZ5QqHVNw2h7IxBFwdh0DZcCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241901; c=relaxed/simple;
	bh=ztja0mEiadKt1ZyOXBgkzR+1THc5X8M+0eJvreWX3P4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMIR7w8EEAN//gocinqwTVOolP/L/c8GZgQMqAiidf2t2nf3Wws7nrE42nZdUD/MxOGLBrKoGTlWSTo76GD0A/tjZEqVr1aNP3gTDQPSqfYUpGC9hFZV4BGWG9/ina43H33jYMBxcdDWnbeTpyXn+RmLsROscUJst1lRWf0g/+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jacg2AEL; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6484mfZh3918198;
	Fri, 8 May 2026 05:03:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
	tC0aX4znzx5pOhy2xcatdgVjUjoH1fQHnAw4FDLmdc=; b=jacg2AELcAMycs3Wy
	J8B5Hk1FZorr4WdAXKjGOP+8MnWkerbrm90zAeH6P7+yN+3Yx++7zXfJedNlj1Jo
	0ZBsr1ikZCdm5cE+6/AtfWASs0aDfFNNsRdOBL/yL/4oSXMXh+kDpAIuo6hYXET3
	YkmuLQ56qus+PgGPqCo63lzBJLoqBHqEl8VW84xyaKxKxCWK5WV5NXQjPC6bCr+i
	jQD+HpfcyYDU7d1cAZVH1LOc63j9kaNvta5PUV0SmMvvDC8KKJKdfpBODxeLIoRA
	mu7mE31oLy7SRNuxwHrQpJuAekHTmR8iIcHAcsT6i1g8zqGEXgyEcLu1UpQAnq9V
	ZL36A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e093sxbrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 05:03:55 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 8 May 2026 05:03:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 8 May 2026 05:03:55 -0700
Received: from BG-LT92649.marvell.com (BG-LT92649.marvell.com [10.28.166.218])
	by maili.marvell.com (Postfix) with ESMTP id 5FE0C5B693D;
	Fri,  8 May 2026 05:03:50 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <irusskikh@marvell.com>, <epomozov@marvell.com>,
        <richardcochran@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <vadim.fedorenko@linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v2 7/9] net: atlantic: add AQC113 PTP traffic class and TX path setup TX path setup
Date: Fri, 8 May 2026 17:31:54 +0530
Message-ID: <20260508120156.3060-8-sukhdeeps@marvell.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260508120156.3060-1-sukhdeeps@marvell.com>
References: <20260506135706.2834-1-sukhdeeps@marvell.com>
 <20260508120156.3060-1-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8P88sPW1pBh9glUa7VZS__YEoFcCKuI7
X-Proofpoint-GUID: 8P88sPW1pBh9glUa7VZS__YEoFcCKuI7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyNSBTYWx0ZWRfX5k3+PLXbSwqF
 A/NsEXBpgHjw2vkxlH4+rmgh2CIQgF5dUBx6Zm+gFjeoaFek7QBPdRrfy8iLN2++Jb0aVPlQbfe
 PyCZypxteoMv355APshW2ta++mk7Ruu2nklK2giwEYyN7Y3Y0N4H3QUNZ/IX2jyUKk/z52VeBsl
 hDxi8xLK60RSjQBunWBNfBM6Q4UXi4ntC+JOJb9Rch5RSj1u4XDK9bu47tZA33qeXo0QslU8Z+i
 7RUr0GuiNWFdQXV8cOQBTRNF3SkSYFjO5offDYRa939r2WOu8+euhJcKISH+oX2z2leZexmXORt
 d9alchPec4wbVGz6D/4uaOWn/RFp3H9DaZ67iU7tUfQX83jMPnhdzcVUsIgxszHxFQwkMUFAlfR
 TNwn9FS35YxeM/g6W68RZ0YWEfb4eafSoYPiCLSb+5oLARLvtotbg5dpOE0znKN0H8imFkOS7c/
 1X2qFyDrT8VRa7EzBRw==
X-Authority-Analysis: v=2.4 cv=WZ48rUhX c=1 sm=1 tr=0 ts=69fdd12c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=wn5G0mF7TSBqfe3wV-wA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Rspamd-Queue-Id: A65804F6285
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-285783-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:mid,marvell.com:dkim];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

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


