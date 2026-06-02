Return-Path: <netdev+bounces-294245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QNszCVjiHmqoYQAAu9opvQ
	(envelope-from <netdev+bounces-294245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:02:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD33462F1D4
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:01:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=g2p3jTHI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294245-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294245-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A121305680C
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4CD3F1AA0;
	Tue,  2 Jun 2026 13:56:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AE2372064;
	Tue,  2 Jun 2026 13:56:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408564; cv=none; b=pr7BIY9+sn/9/uybKjM+GUeMPxgjYEjKDD6oUyDcPUsEgGKLcTle0jCV3yJYCFOl9q0kc4Koj9xGgDn2bt+v3K4hNYdUNnf1PUMBCbfW0qDQROPdcNFHKRem1blXcUBivdRlRAKOe0pFnUd8l2R5xwkX8M2qLhuzU3KL7f6eMQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408564; c=relaxed/simple;
	bh=ZhG8L4PZfVsGvqOB6ROyhVayDnV0wCsShOSusFhPh1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5dm+WnKRkUI1X1tSgx0VxLj5ntICJUzRnDLHGbgY8qV6/GleNdHtpKyHEhg3KBQWVuVlRU7I59LGOEiBLb0n0wclJCzCTaHhVOrvH2rOos+1Lq3/LZpHkzQ/cNTX83TYwmkV6Kaj79VMdyD7JArAmQ16l65Y8pIgs48yjimyQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=g2p3jTHI; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6526RSlY2042694;
	Tue, 2 Jun 2026 06:55:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=P
	Up/NWj9PvjDO63YZ8nczx1VMDJnMyJ0S4CQXTTZ0Gk=; b=g2p3jTHIYsbLcNzE+
	ZNSkzbb+hxje1DUfI8fPyGBL2rKXuaGZ+lPDN7W/D7bjyh1W1jTjs/9iB7aDeuIv
	MPhr063F/seyA6EETN+YC/BhT1aIoXa5mkhxQvW/x8Z7QS8FAsf/aqxPsieU5iIf
	YrO0aId+MulaRGeNbzUrluvtiy9ZAnuspkQH88AZLokA1fHK6O3+dvEIAe1+cD9v
	FrWFwczkD7QDBzRSd7nHzM1zX+Ndp0yPjKSgHBNYsGRUesYj6X+GEgt/HddZrjEm
	xM4arHt9nnRTAVQpeCTSr0Qpqdi9nPJvcmeh3nYSQjT93Libz+hu25qMLgL/JZBp
	We7og==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ehswn9a5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 06:55:52 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 2 Jun 2026 06:55:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 2 Jun 2026 06:55:52 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.71.86])
	by maili.marvell.com (Postfix) with ESMTP id 3ABC03F7085;
	Tue,  2 Jun 2026 06:55:47 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v4 10/12] net: atlantic: add AQC113 PTP hardware ops in hw_atl2
Date: Tue, 2 Jun 2026 19:24:50 +0530
Message-ID: <20260602135452.516-11-sukhdeeps@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=GaInWwXL c=1 sm=1 tr=0 ts=6a1ee0e8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=_Uech-6FvGySvUjt_wcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: q2VkyAN1MAI2GW9sfWATcDQjrQcjsRdP
X-Proofpoint-GUID: q2VkyAN1MAI2GW9sfWATcDQjrQcjsRdP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEzMyBTYWx0ZWRfX2yLaC2dL3L44
 cszPPHa83rbU6GbOQZhzY2BlkRrlU5dmQYOBxgzhYCByozY1il3C8tvIpAFmlGamcMvaozdgQDq
 lP9Jvq4OMbRRyfZX544y3Urr5k6Pujvwd1pSfNr5rrKbUX//jaafB0LcWc82h9kEyQKvI0UtpaF
 ckPxEyJ1PjqZOCjXcImcIcW12iYPBgCYdxOllrlSUM2++slMBfDR60Dk6FE7+x5RTGeVMwdJQMa
 XUZhYiYNsUhYrCfQZG6hyPwdLUgfpefdToIJ4fpxpQgg/P7hQdsu+xG1yN0L6WcGFR8cXC+vcMY
 dGC4lhh1J1GLfeOnJwBxm0xMbUVokQg6yk8fLabvIGEu4XH81TfnGjH+T5ifGNg+oO25F5dF4EN
 wM1VjzMyThzpu+1PO/2HxS4pXVWvRWiTbANApLJvXfLHLVp1TiFv5voMRP113RJBWDCKrGlXM2l
 FAU3wn7XLV6Yc5v11pg==
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294245-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:sukhdeeps@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:mid,marvell.com:dkim,marvell.com:from_mime,marvell.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
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
X-Rspamd-Queue-Id: BD33462F1D4

From: Sukhdeep Singh <sukhdeeps@marvell.com>

Add the hardware-layer PTP implementation for AQC113 (Antigua):

- hw_atl2.h/hw_atl2_utils.h/hw_atl2_internal.h: export PTP function
  prototypes, per-instance aq_ptp_offset arrays, RX timestamp size
  (HW_ATL2_RX_TS_SIZE=8), and reduced HW_ATL2_RXBUF_MAX=172 (AQC113
  on-chip RX packet buffer hardware limit for data TCs).

- hw_atl2.c: implement hw_atl2_enable_ptp() to program TSG clocks,
  PTP TC receive path and filter ART entries, and re-enable PTP state
  after hardware reset.

- hw_atl2.c: implement hw_atl2_adj_sys_clock(), hw_atl2_adj_clock_freq(),
  and aq_get_ptp_ts() for TSG clock read/adjust/increment operations.

- hw_atl2.c: implement hw_atl2_gpio_pulse() for PPS output generation
  via TSG pulse generator.

- hw_atl2.c: implement hw_atl2_hw_tx_ptp_ring_init() and
  hw_atl2_hw_rx_ptp_ring_init() for PTP ring setup.

- hw_atl2.c: implement hw_atl2_hw_ring_tx_ptp_get_ts() to read TX
  timestamp from descriptor writeback, and hw_atl2_hw_rx_extract_ts()
  to extract RX timestamp from the 8-byte packet trailer.

- hw_atl2.c: add hw_atl2_hw_get_clk_sel() helper.

- Wire all new ops into hw_atl2_ops.

Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
---
 .../aquantia/atlantic/hw_atl2/hw_atl2.c       | 202 +++++++++++++++++-
 .../aquantia/atlantic/hw_atl2/hw_atl2.h       |  12 ++
 .../atlantic/hw_atl2/hw_atl2_internal.h       |   3 +-
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils.h |  10 +
 4 files changed, 224 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index 6d9ec4072d43..e94627c36163 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
@@ -7,6 +7,7 @@
 #include "aq_hw_utils.h"
 #include "aq_ring.h"
 #include "aq_nic.h"
+#include "aq_ptp.h"
 #include "hw_atl/hw_atl_b0.h"
 #include "hw_atl/hw_atl_utils.h"
 #include "hw_atl/hw_atl_llh.h"
@@ -20,6 +21,15 @@
 static int hw_atl2_act_rslvr_table_set(struct aq_hw_s *self, u8 location,
 				       u32 tag, u32 mask, u32 action);
 
+static void hw_atl2_enable_ptp(struct aq_hw_s *self,
+			       unsigned int param, int enable);
+static int hw_atl2_hw_tx_ptp_ring_init(struct aq_hw_s *self,
+				       struct aq_ring_s *aq_ring);
+static int hw_atl2_hw_rx_ptp_ring_init(struct aq_hw_s *self,
+				       struct aq_ring_s *aq_ring);
+static void aq_get_ptp_ts(struct aq_hw_s *self, u64 *stamp);
+static int hw_atl2_adj_clock_freq(struct aq_hw_s *self, s32 ppb);
+
 #define DEFAULT_BOARD_BASIC_CAPABILITIES \
 	.is_64_dma = true,		  \
 	.op64bit = true,		  \
@@ -127,6 +137,7 @@ static u32 hw_atl2_sem_act_rslvr_get(struct aq_hw_s *self)
 static int hw_atl2_hw_reset(struct aq_hw_s *self)
 {
 	struct hw_atl2_priv *priv = self->priv;
+	s8 clk_sel;
 	int err;
 	int i;
 
@@ -144,6 +155,13 @@ static int hw_atl2_hw_reset(struct aq_hw_s *self)
 		priv->l3l4_filters[i].l4_index = -1;
 	}
 
+	clk_sel = READ_ONCE(self->clk_select);
+	if (clk_sel != -1)
+		hw_atl2_enable_ptp(self,
+				   clk_sel,
+				   aq_utils_obj_test(&self->flags, AQ_HW_PTP_AVAILABLE) ?
+				   1 : 0);
+
 	self->aq_fw_ops->set_state(self, MPI_RESET);
 
 	err = aq_hw_err_from_flags(self);
@@ -725,14 +743,32 @@ static int hw_atl2_hw_ring_rx_init(struct aq_hw_s *self,
 				   struct aq_ring_s *aq_ring,
 				   struct aq_ring_param_s *aq_ring_param)
 {
-	return hw_atl_b0_hw_ring_rx_init(self, aq_ring, aq_ring_param);
+	int res = hw_atl_b0_hw_ring_rx_init(self, aq_ring, aq_ring_param);
+
+	if (!res && aq_ptp_ring(aq_ring->aq_nic, aq_ring)) {
+		int rx_err = hw_atl2_hw_rx_ptp_ring_init(self, aq_ring);
+
+		if (!res)
+			res = rx_err;
+	}
+
+	return res;
 }
 
 static int hw_atl2_hw_ring_tx_init(struct aq_hw_s *self,
 				   struct aq_ring_s *aq_ring,
 				   struct aq_ring_param_s *aq_ring_param)
 {
-	return hw_atl_b0_hw_ring_tx_init(self, aq_ring, aq_ring_param);
+	int res = hw_atl_b0_hw_ring_tx_init(self, aq_ring, aq_ring_param);
+
+	if (!res && aq_ptp_ring(aq_ring->aq_nic, aq_ring)) {
+		int tx_err = hw_atl2_hw_tx_ptp_ring_init(self, aq_ring);
+
+		if (!res)
+			res = tx_err;
+	}
+
+	return res;
 }
 
 #define IS_FILTER_ENABLED(_F_) ((packet_filter & (_F_)) ? 1U : 0U)
@@ -892,6 +928,151 @@ static struct aq_stats_s *hw_atl2_utils_get_hw_stats(struct aq_hw_s *self)
 	return &self->curr_stats;
 }
 
+static void hw_atl2_enable_ptp(struct aq_hw_s *self,
+			       unsigned int param, int enable)
+{
+	WRITE_ONCE(self->clk_select, (s8)param);
+
+	/* enable tsg counter */
+	hw_atl2_tsg_clock_reset(self, self->clk_select);
+	hw_atl2_tsg_clock_en(self, !self->clk_select, enable);
+	hw_atl2_tsg_clock_en(self, self->clk_select, enable);
+
+	if (enable)
+		hw_atl2_adj_clock_freq(self, 0);
+
+	hw_atl2_tpb_tps_highest_priority_tc_enable_set(self, enable);
+}
+
+static void aq_get_ptp_ts(struct aq_hw_s *self, u64 *stamp)
+{
+	s8 clk_sel = READ_ONCE(self->clk_select);
+
+	if (clk_sel < 0)
+		return;
+	if (stamp)
+		*stamp = hw_atl2_tsg_clock_read(self, clk_sel);
+}
+
+static u64 hw_atl2_hw_ring_tx_ptp_get_ts(struct aq_ring_s *ring)
+{
+	struct hw_atl2_txts_s *txts;
+	u32 ctrl;
+
+	txts = (struct hw_atl2_txts_s *)&ring->dx_ring[ring->sw_head *
+						HW_ATL2_TXD_SIZE];
+	/* DD + TS_VALID */
+	ctrl = le32_to_cpu(READ_ONCE(txts->ctrl));
+	if ((ctrl & HW_ATL2_TXTS_DD) && (ctrl & HW_ATL2_TXTS_TS_VALID)) {
+		dma_rmb();
+		return le64_to_cpu(txts->ts);
+	}
+
+	return 0;
+}
+
+static u16 hw_atl2_hw_rx_extract_ts(struct aq_hw_s *self, u8 *p,
+				    unsigned int len, u64 *timestamp)
+{
+	unsigned int offset = HW_ATL2_RX_TS_SIZE;
+	__le64 ts;
+	u8 *ptr;
+
+	if (len <= offset || !timestamp)
+		return 0;
+
+	ptr = p + (len - offset);
+	memcpy(&ts, ptr, sizeof(ts));
+	*timestamp = le64_to_cpu(ts);
+
+	return HW_ATL2_RX_TS_SIZE;
+}
+
+static int hw_atl2_adj_sys_clock(struct aq_hw_s *self, s64 delta)
+{
+	s8 clk_sel = READ_ONCE(self->clk_select);
+
+	if (clk_sel < 0)
+		return -ENODEV;
+	if (delta >= 0)
+		hw_atl2_tsg_clock_add(self, clk_sel, (u64)delta);
+	else
+		hw_atl2_tsg_clock_sub(self, clk_sel, (u64)(-delta));
+
+	return 0;
+}
+
+static int hw_atl2_adj_clock_freq(struct aq_hw_s *self, s32 ppb)
+{
+	u32 freq = AQ2_HW_PTP_COUNTER_HZ;
+	u64 divisor = 0, base_ns;
+	u32 nsi_frac = 0, nsi;
+	u32 nsi_rem;
+	s8 clk_sel;
+
+	base_ns = div_u64((u64)((s64)ppb + NSEC_PER_SEC) * NSEC_PER_SEC, freq);
+	nsi = (u32)div_u64_rem(base_ns, NSEC_PER_SEC, &nsi_rem);
+	if (nsi_rem != 0) {
+		divisor = div_u64(mul_u32_u32(NSEC_PER_SEC, NSEC_PER_SEC),
+				  nsi_rem);
+		nsi_frac = (u32)div64_u64(AQ_FRAC_PER_NS * NSEC_PER_SEC,
+					  divisor);
+	}
+
+	clk_sel = READ_ONCE(self->clk_select);
+	if (clk_sel < 0)
+		return -ENODEV;
+	hw_atl2_tsg_clock_increment_set(self, clk_sel, nsi, nsi_frac);
+
+	return 0;
+}
+
+static int hw_atl2_hw_tx_ptp_ring_init(struct aq_hw_s *self,
+				       struct aq_ring_s *aq_ring)
+{
+	hw_atl2_tdm_tx_desc_timestamp_writeback_en_set(self, true,
+						       aq_ring->idx);
+	hw_atl2_tdm_tx_desc_timestamp_en_set(self, true, aq_ring->idx);
+	hw_atl2_tdm_tx_desc_avb_en_set(self, true, aq_ring->idx);
+
+	return aq_hw_err_from_flags(self);
+}
+
+static int hw_atl2_hw_rx_ptp_ring_init(struct aq_hw_s *self,
+				       struct aq_ring_s *aq_ring)
+{
+	hw_atl2_rpf_rx_desc_timestamp_req_set(self,
+					      self->clk_select == ATL_TSG_CLOCK_SEL_1 ? 2 : 1,
+					      aq_ring->idx);
+	return aq_hw_err_from_flags(self);
+}
+
+static u32 hw_atl2_hw_get_clk_sel(struct aq_hw_s *self)
+{
+	return READ_ONCE(self->clk_select);
+}
+
+static int hw_atl2_gpio_pulse(struct aq_hw_s *self, u32 index, u32 clk_sel,
+			      u64 start, u32 period, u32 hightime)
+{
+	u32 mode;
+
+	if (index != 1 && index != 3)
+		return -EINVAL;
+
+	if (start == 0)
+		mode = HW_ATL2_GPIO_PIN_SPEC_MODE_GPIO;
+	else if (clk_sel == ATL_TSG_CLOCK_SEL_0)
+		mode = HW_ATL2_GPIO_PIN_SPEC_MODE_TSG0_EVENT_OUTPUT;
+	else
+		mode = HW_ATL2_GPIO_PIN_SPEC_MODE_TSG1_EVENT_OUTPUT;
+
+	hw_atl2_gpio_special_mode_set(self, mode, index);
+	hw_atl2_tsg_ptp_gpio_gen_pulse(self, clk_sel, start, period, hightime);
+
+	return 0;
+}
+
 static bool hw_atl2_rxf_l3_is_equal(struct hw_atl2_l3_filter *f1,
 				    struct hw_atl2_l3_filter *f2)
 {
@@ -1472,4 +1653,21 @@ const struct aq_hw_ops hw_atl2_ops = {
 	.hw_set_offload              = hw_atl_b0_hw_offload_set,
 	.hw_set_loopback             = hw_atl_b0_set_loopback,
 	.hw_set_fc                   = hw_atl_b0_set_fc,
+
+	.hw_ring_hwts_rx_fill        = NULL,
+	.hw_ring_hwts_rx_receive     = NULL,
+
+	.hw_get_ptp_ts           = aq_get_ptp_ts,
+	.hw_adj_clock_freq       = hw_atl2_adj_clock_freq,
+	.hw_adj_sys_clock        = hw_atl2_adj_sys_clock,
+	.hw_gpio_pulse           = hw_atl2_gpio_pulse,
+
+	.enable_ptp              = hw_atl2_enable_ptp,
+	.hw_ring_tx_ptp_get_ts   = hw_atl2_hw_ring_tx_ptp_get_ts,
+	.rx_extract_ts           = hw_atl2_hw_rx_extract_ts,
+	.hw_tx_ptp_ring_init     = hw_atl2_hw_tx_ptp_ring_init,
+	.hw_rx_ptp_ring_init     = hw_atl2_hw_rx_ptp_ring_init,
+	.hw_get_clk_sel          = hw_atl2_hw_get_clk_sel,
+	.extract_hwts            = NULL,
+	.hw_extts_gpio_enable    = NULL,
 };
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.h
index 346f0dc9912e..4b905231ae73 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.h
@@ -7,6 +7,18 @@
 #define HW_ATL2_H
 
 #include "aq_common.h"
+#define HW_ATL2_RX_TS_SIZE 8
+
+#define HW_ATL2_PTP_OFFSET_INGRESS_100          768
+#define HW_ATL2_PTP_OFFSET_EGRESS_100           336
+#define HW_ATL2_PTP_OFFSET_INGRESS_1000         510
+#define HW_ATL2_PTP_OFFSET_EGRESS_1000          105
+#define HW_ATL2_PTP_OFFSET_INGRESS_2500         2447
+#define HW_ATL2_PTP_OFFSET_EGRESS_2500          634
+#define HW_ATL2_PTP_OFFSET_INGRESS_5000         1426
+#define HW_ATL2_PTP_OFFSET_EGRESS_5000          361
+#define HW_ATL2_PTP_OFFSET_INGRESS_10000        997
+#define HW_ATL2_PTP_OFFSET_EGRESS_10000         203
 
 extern const struct aq_hw_caps_s hw_atl2_caps_aqc113;
 extern const struct aq_hw_caps_s hw_atl2_caps_aqc115c;
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
index 31d7cae6641a..8da3262c167d 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
@@ -29,7 +29,8 @@
 #define HW_ATL2_TXBUF_MAX              128U
 #define HW_ATL2_PTP_TXBUF_SIZE           8U
 
-#define HW_ATL2_RXBUF_MAX              192U
+/* AQC113 on-chip RX packet buffer available for data TCs */
+#define HW_ATL2_RXBUF_MAX              172U
 #define HW_ATL2_PTP_RXBUF_SIZE          16U
 #define HW_ATL2_RSS_REDIRECTION_MAX 64U
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h
index c84955bc14ae..ee998aabf91e 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h
@@ -8,6 +8,16 @@
 
 #include "aq_hw.h"
 
+/* Hardware tx launch time descriptor */
+struct hw_atl2_txts_s {
+	__le64 ts;
+	__le32 ctrl;
+	u32 reserved;
+};
+
+#define HW_ATL2_TXTS_DD	BIT(3)
+#define HW_ATL2_TXTS_TS_VALID   BIT(20)
+
 /* F W    A P I */
 
 struct link_options_s {
-- 
2.43.0


