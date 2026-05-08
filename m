Return-Path: <netdev+bounces-285778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGFRA0vR/Wl2jgAAu9opvQ
	(envelope-from <netdev+bounces-285778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:04:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B7D4F60FC
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C92330621F8
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A493DC4DA;
	Fri,  8 May 2026 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jN6sYOMo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A245C3DBD41;
	Fri,  8 May 2026 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241828; cv=none; b=V8+qV9lbLhLZk0oVUVmXjiO5KcW2hCNahzBsghetogcLN/btp14WbbPa2+Oiby+4J2dNy4g6cDv/Y/jeAm0ML2CABgFNgX1CJ7+6drW9nRZLKTrP/p6gnTodV+ocL8K00MXJrHAccItoziPOCUs3c3sJTKbhOBS2ZR8GYg52xOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241828; c=relaxed/simple;
	bh=k65eq5czZbXmJXCBYf5ab6pgNeunGvIiq8jrC7TQH04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SgIq08CpzHG2FI6ajQwSk3YG180oj4JTCWjEwq0NznLAmDWq/KpwBiFxiM5h9+2E9joDYnrfAT3AH7ucksRcKnxOYPz/h1W+INarq/0BiXtJLeUIsWfJ2IP6BIOD33eyhRryhBgtmkuGugEI6CoW30xtFiE+/FsYRqQNK7k97mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jN6sYOMo; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648AVEJR2833021;
	Fri, 8 May 2026 05:03:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
	v9cQbqib0MTIhBQ/Seru1uUw113kvLWggZ/818uEuA=; b=jN6sYOMoMUE2ECqMo
	NbqUeLFB5+WRnfrmbDJtHXBT+VPkzwKYhf5ajoIjVXDGPkopoWOv/CZP5LpcLuMB
	oGHoLKuxoOPcIuIUa633FWUFXdq5e0n+VQuAOjW/jAmRSjXJYSfOdxFnJe6gh1L/
	eaqUloj8WyOR42Srw5rw+PP/2Fodau1asoOZLagUT6VpSJhHP+LzFGoWJ+hG+EvE
	JEzfCkn8dO4m6yhlbDfhMOvGRZPvGgExcPHotZplDWNNrn16hs+6tN8kF+jXpN/I
	0gM1SwBJ+cbH5admXkPTrHWnb1OZY27BYvTJxicn9ejDres4VFEyKhqPS4yS13CP
	5z5RQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e0uytkcqy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 05:03:35 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 8 May 2026 05:03:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 8 May 2026 05:03:34 -0700
Received: from BG-LT92649.marvell.com (BG-LT92649.marvell.com [10.28.166.218])
	by maili.marvell.com (Postfix) with ESMTP id 20FC53F706D;
	Fri,  8 May 2026 05:03:27 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <irusskikh@marvell.com>, <epomozov@marvell.com>,
        <richardcochran@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <vadim.fedorenko@linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v2 4/9] net: atlantic: add AQC113 hardware register definitions and accessors definitions and accessors
Date: Fri, 8 May 2026 17:31:51 +0530
Message-ID: <20260508120156.3060-5-sukhdeeps@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=I6RVgtgg c=1 sm=1 tr=0 ts=69fdd117 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=LSCArPMb_0IkGpeXMRcA:9
 a=YV9oaHPYXN6LNWk9:21 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyNSBTYWx0ZWRfX+PndLYslJOJG
 xTj07O+QtkuER4HCCZ9XedQTLyS2wdPHyEgT2tynso5sSRth8O9IOVZekHtxPR95mcNPKw3+WuE
 wAR5zcJYZpRmHYUBuqhrfc+aWM7DArIEtffIL2dGFrUTd8CiWPAXxw1T02LKlL6vtTDC5i87ACG
 kN+Xmeamcbx6mCKDzK1FZwf2OFGxjiGQ8byxGAJHRIGzokO1z6P/9L7L/2AqQcwtgeS7ySDklAq
 2j9cGAvH9jMtt8L8YUKDaoH4yL5VApqB6t1a1f59D62pdfSOKYrq5u41g986VhY1V+e/dRdUAC2
 eWl//MvT512kiB+0N/7wMKgKHAnpXEuedO59gTsS0OF0utQYnhuuq/96JsK/bWvYcoBhFSZaWdK
 Nfb8nWlfooKBcWg/v5hmAuD6dKAE1KQdjKtRKPDlPCnbfIl9tkvKpSY+yyiT6cThWETDUgs7vsU
 V/Jd4SGPOD+Iwj51vBg==
X-Proofpoint-GUID: Kzjloc_IoBKnafGOCkDIyEa81MXRQ7lW
X-Proofpoint-ORIG-GUID: Kzjloc_IoBKnafGOCkDIyEa81MXRQ7lW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Rspamd-Queue-Id: 82B7D4F60FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-285778-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email,marvell.com:mid,marvell.com:dkim];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

From: Sukhdeep Singh <sukhdeeps@marvell.com>

Add low-level hardware register definitions and accessor functions
for AQC113 (Antigua) chip features:

- L3/L4 filter command, tag, and address registers for IPv4/IPv6
- Ethertype filter tag registers
- TSG (Time Stamp Generator) clock control, modification, and
  GPIO event generation/input timestamp registers
- TX descriptor timestamp writeback, timestamp enable, and AVB
  enable registers
- TX data/descriptor read request limit registers
- TPB highest priority TC registers
- PCIe extended tag enable register
- RX descriptor timestamp request register
- Action resolver section enable getter
- GPIO special mode and TSG external GPIO TS input select

Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
---
 .../aquantia/atlantic/hw_atl2/hw_atl2_llh.c   | 359 ++++++++++++++++++
 .../aquantia/atlantic/hw_atl2/hw_atl2_llh.h   | 107 +++++-
 .../atlantic/hw_atl2/hw_atl2_llh_internal.h   | 204 +++++++++-
 3 files changed, 663 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_llh.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_llh.c
index cd954b11d24a..21fda387f60e 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_llh.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_llh.c
@@ -7,6 +7,20 @@
 #include "hw_atl2_llh_internal.h"
 #include "aq_hw_utils.h"
 
+void hw_atl2_phi_ext_tag_set(struct aq_hw_s *aq_hw, u32 val)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_PHI_EXT_TAG_EN_ADR,
+			    HW_ATL2_PHI_EXT_TAG_EN_MSK,
+			    HW_ATL2_PHI_EXT_TAG_EN_SHIFT, val);
+}
+
+u32 hw_atl2_phi_ext_tag_get(struct aq_hw_s *aq_hw)
+{
+	return aq_hw_read_reg_bit(aq_hw, HW_ATL2_PHI_EXT_TAG_EN_ADR,
+				  HW_ATL2_PHI_EXT_TAG_EN_MSK,
+				  HW_ATL2_PHI_EXT_TAG_EN_SHIFT);
+}
+
 void hw_atl2_rpf_redirection_table2_select_set(struct aq_hw_s *aq_hw,
 					       u32 select)
 {
@@ -66,6 +80,278 @@ void hw_atl2_rpf_vlan_flr_tag_set(struct aq_hw_s *aq_hw, u32 tag, u32 filter)
 			    tag);
 }
 
+void hw_atl2_rpf_etht_flr_tag_set(struct aq_hw_s *aq_hw, u32 tag, u32 filter)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_RPF_ET_TAG_ADR(filter),
+			    HW_ATL2_RPF_ET_TAG_MSK,
+			    HW_ATL2_RPF_ET_TAG_SHIFT, tag);
+}
+
+u32 hw_atl2_rpf_etht_flr_tag_get(struct aq_hw_s *aq_hw, u32 filter)
+{
+	return aq_hw_read_reg_bit(aq_hw, HW_ATL2_RPF_ET_TAG_ADR(filter),
+				  HW_ATL2_RPF_ET_TAG_MSK,
+				  HW_ATL2_RPF_ET_TAG_SHIFT);
+}
+
+void hw_atl2_rpf_l3_v4_dest_addr_set(struct aq_hw_s *aq_hw, u32 filter, u32 val)
+{
+	u32 addr_set = 6 + ((filter < 4) ? 0 : 1);
+	u32 dword = filter % 4;
+
+	aq_hw_write_reg(aq_hw, HW_ATL2_RPF_L3_DA_DW_ADR(addr_set, dword), val);
+}
+
+void hw_atl2_rpf_l3_v4_src_addr_set(struct aq_hw_s *aq_hw, u32 filter, u32 val)
+{
+	u32 addr_set = 6 + ((filter < 4) ? 0 : 1);
+	u32 dword = filter % 4;
+
+	aq_hw_write_reg(aq_hw, HW_ATL2_RPF_L3_SA_DW_ADR(addr_set, dword), val);
+}
+
+void hw_atl2_rpf_l3_v6_dest_addr_set(struct aq_hw_s *aq_hw, u8 location,
+				     u32 *ipv6_dst)
+{
+	int i;
+
+	for (i = 0; i < 4; ++i)
+		aq_hw_write_reg(aq_hw,
+				HW_ATL2_RPF_L3_DA_DW_ADR(location, 3 - i),
+				ipv6_dst[i]);
+}
+
+void hw_atl2_rpf_l3_v6_src_addr_set(struct aq_hw_s *aq_hw, u8 location,
+				    u32 *ipv6_src)
+{
+	int i;
+
+	for (i = 0; i < 4; ++i)
+		aq_hw_write_reg(aq_hw,
+				HW_ATL2_RPF_L3_SA_DW_ADR(location, 3 - i),
+				ipv6_src[i]);
+}
+
+void hw_atl2_rpf_l3_v4_cmd_set(struct aq_hw_s *aq_hw, u32 val, u32 filter)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_RPF_L3_V4_CMD_ADR(filter),
+			    HW_ATL2_RPF_L3_V4_CMD_MSK,
+			    HW_ATL2_RPF_L3_V4_CMD_SHIFT, val);
+}
+
+void hw_atl2_rpf_l3_v6_cmd_set(struct aq_hw_s *aq_hw, u32 val, u32 filter)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_RPF_L3_V6_CMD_ADR(filter),
+			    HW_ATL2_RPF_L3_V6_CMD_MSK,
+			    HW_ATL2_RPF_L3_V6_CMD_SHIFT, val);
+}
+
+void hw_atl2_rpf_l3_v6_v4_select_set(struct aq_hw_s *aq_hw, u32 val)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_RPF_L3_V6_V4_SELECT_ADR,
+			    HW_ATL2_RPF_L3_V6_V4_SELECT_MSK,
+			    HW_ATL2_RPF_L3_V6_V4_SELECT_SHIFT, val);
+}
+
+void hw_atl2_rpf_l3_v4_tag_set(struct aq_hw_s *aq_hw, u32 val, u32 filter)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_RPF_L3_V4_TAG_ADR(filter),
+			    HW_ATL2_RPF_L3_V4_TAG_MSK,
+			    HW_ATL2_RPF_L3_V4_TAG_SHIFT, val);
+}
+
+void hw_atl2_rpf_l3_v6_tag_set(struct aq_hw_s *aq_hw, u32 val, u32 filter)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_RPF_L3_V6_TAG_ADR(filter),
+			    HW_ATL2_RPF_L3_V6_TAG_MSK,
+			    HW_ATL2_RPF_L3_V6_TAG_SHIFT, val);
+}
+
+void hw_atl2_rpf_l4_tag_set(struct aq_hw_s *aq_hw, u32 val, u32 filter)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_RPF_L4_TAG_ADR(filter),
+			    HW_ATL2_RPF_L4_TAG_MSK,
+			    HW_ATL2_RPF_L4_TAG_SHIFT, val);
+}
+
+void hw_atl2_rpf_l4_cmd_set(struct aq_hw_s *aq_hw, u32 val, u32 filter)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_RPF_L4_CMD_ADR(filter),
+			    HW_ATL2_RPF_L4_CMD_MSK,
+			    HW_ATL2_RPF_L4_CMD_SHIFT, val);
+}
+
+/* tsg */
+static void hw_atl2_clock_modif_value_set(struct aq_hw_s *aq_hw,
+					  u32 clock_sel, u64 ns)
+{
+	aq_hw_write_reg64(aq_hw,
+			  HW_ATL2_TSG_REG_ADR(clock_sel, CLOCK_MODIF_VAL_LSW),
+			  ns);
+}
+
+void hw_atl2_tsg_clock_en(struct aq_hw_s *aq_hw,
+			  u32 clock_sel, u32 clock_enable)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_TSG_REG_ADR(clock_sel, CLOCK_CFG),
+			    HW_ATL2_TSG_CLOCK_EN_MSK,
+			    HW_ATL2_TSG_CLOCK_EN_SHIFT,
+			    clock_enable);
+}
+
+void hw_atl2_tsg_clock_reset(struct aq_hw_s *aq_hw, u32 clock_sel)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_TSG_REG_ADR(clock_sel, CLOCK_CFG),
+			    HW_ATL2_TSG_SYNC_RESET_MSK,
+			    HW_ATL2_TSG_SYNC_RESET_SHIFT, 1);
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_TSG_REG_ADR(clock_sel, CLOCK_CFG),
+			    HW_ATL2_TSG_SYNC_RESET_MSK,
+			    HW_ATL2_TSG_SYNC_RESET_SHIFT, 0);
+}
+
+u64 hw_atl2_tsg_clock_read(struct aq_hw_s *aq_hw, u32 clock_sel)
+{
+	return aq_hw_read_reg64(aq_hw,
+				HW_ATL2_TSG_REG_ADR(clock_sel,
+						    READ_CUR_NS_LSW));
+}
+
+void hw_atl2_tsg_clock_add(struct aq_hw_s *aq_hw, u32 clock_sel, u64 ns)
+{
+	hw_atl2_clock_modif_value_set(aq_hw, clock_sel, ns);
+	aq_hw_write_reg(aq_hw,
+			HW_ATL2_TSG_REG_ADR(clock_sel, CLOCK_MODIF_CTRL),
+			HW_ATL2_TSG_ADD_COUNTER_MSK);
+}
+
+void hw_atl2_tsg_clock_sub(struct aq_hw_s *aq_hw, u32 clock_sel, u64 ns)
+{
+	hw_atl2_clock_modif_value_set(aq_hw, clock_sel, ns);
+	aq_hw_write_reg(aq_hw,
+			HW_ATL2_TSG_REG_ADR(clock_sel, CLOCK_MODIF_CTRL),
+			HW_ATL2_TSG_SUBTRACT_COUNTER_MSK);
+}
+
+void hw_atl2_tsg_clock_increment_set(struct aq_hw_s *aq_hw,
+				     u32 clock_sel, u32 ns, u32 fns)
+{
+	u32 nsfns = (ns & 0xff) | (fns & 0xffffff00);
+
+	aq_hw_write_reg(aq_hw,
+			HW_ATL2_TSG_REG_ADR(clock_sel, CLOCK_INC_CFG),
+			nsfns);
+	aq_hw_write_reg(aq_hw,
+			HW_ATL2_TSG_REG_ADR(clock_sel, CLOCK_MODIF_CTRL),
+			HW_ATL2_TSG_LOAD_INC_CFG_MSK);
+}
+
+void hw_atl2_tsg_ext_isr_to_host_set(struct aq_hw_s *aq_hw, int on)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_GLB_CONTROL_2_ADR,
+			    HW_ATL2_MIF_INTERRUPT_2_TO_ITR_MSK,
+			    HW_ATL2_MIF_INTERRUPT_TO_ITR_SHIFT + 2,
+			    !!on);
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_GLB_CONTROL_2_ADR,
+			    HW_ATL2_EN_INTERRUPT_MIF2_TO_ITR_MSK,
+			    HW_ATL2_EN_INTERRUPT_TO_ITR_SHIFT + 2,
+			    !!on);
+}
+
+void hw_atl2_tpb_tps_highest_priority_tc_enable_set(struct aq_hw_s *aq_hw,
+						    u32 tps_highest_prio_tc_en)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_TPB_HIGHEST_PRIO_TC_EN_ADR,
+			    HW_ATL2_TPB_HIGHEST_PRIO_TC_EN_MSK,
+			    HW_ATL2_TPB_HIGHEST_PRIO_TC_EN_SHIFT,
+			    tps_highest_prio_tc_en);
+}
+
+void hw_atl2_tpb_tps_highest_priority_tc_set(struct aq_hw_s *aq_hw,
+					     u32 tps_highest_prio_tc)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_TPB_HIGHEST_PRIO_TC_ADR,
+			    HW_ATL2_TPB_HIGHEST_PRIO_TC_MSK,
+			    HW_ATL2_TPB_HIGHEST_PRIO_TC_SHIFT,
+			    tps_highest_prio_tc);
+}
+
+void hw_atl2_tsg_gpio_isr_to_host_set(struct aq_hw_s *aq_hw,
+				      int on, u32 clock_sel)
+{
+	aq_hw_write_reg_bit(aq_hw,
+			    HW_ATL2_GLOBAL_HIGH_PRIO_INTERRUPT_1_MASK_ADR,
+		clock_sel == 1 ? HW_ATL2_TSG_TSG1_GPIO_INTERRUPT_MSK :
+			HW_ATL2_TSG_TSG0_GPIO_INTERRUPT_MSK,
+		clock_sel == 1 ? HW_ATL2_TSG_TSG1_GPIO_INTERRUPT_SHIFT :
+			HW_ATL2_TSG_TSG0_GPIO_INTERRUPT_SHIFT,
+		!!on);
+}
+
+void hw_atl2_tsg_gpio_clear_status(struct aq_hw_s *aq_hw)
+{
+	aq_hw_read_reg(aq_hw, HW_ATL2_GLOBAL_INTERNAL_ALARMS_1_ADR);
+}
+
+void hw_atl2_tsg_gpio_input_event_info_get(struct aq_hw_s *aq_hw,
+					   u32 clock_sel,
+					   u32 *event_count,
+					   u64 *event_ts)
+{
+	if (event_count)
+		*event_count = aq_hw_read_reg(aq_hw,
+					      HW_ATL2_TSG_REG_ADR(clock_sel,
+								  EXT_CLK_COUNT));
+
+	if (event_ts)
+		*event_ts = aq_hw_read_reg64(aq_hw,
+					     HW_ATL2_TSG_REG_ADR(clock_sel,
+								 GPIO_EVENT_TS_LSW));
+}
+
+void hw_atl2_tsg_ptp_gpio_gen_pulse(struct aq_hw_s *aq_hw, u32 clk_sel,
+				    u64 ts, u32 period, u32 hightime)
+{
+	u32 val = (HW_ATL2_TSG_GPIO_EVENT_MODE_SET_ON_TIME <<
+		   (HW_ATL2_TSG_GPIO_EVENT_MODE_SHIFT -
+		    HW_ATL2_TSG_GPIO_OUTPUT_EN_SHIFT)) |
+		  (HW_ATL2_TSG_GPIO_GEN_OUTPUT_EN_MSK) |
+		  (HW_ATL2_TSG_GPIO_OUTPUT_EN_MSK);
+
+	if (ts != 0) {
+		aq_hw_write_reg64(aq_hw,
+				  HW_ATL2_TSG_REG_ADR(clk_sel,
+						      GPIO_EVENT_GEN_TS_LSW),
+				  ts);
+
+		aq_hw_write_reg64(aq_hw,
+				  HW_ATL2_TSG_REG_ADR(clk_sel,
+						      GPIO_EVENT_HIGH_TIME_LSW),
+				  hightime);
+
+		aq_hw_write_reg64(aq_hw,
+				  HW_ATL2_TSG_REG_ADR(clk_sel,
+						      GPIO_EVENT_LOW_TIME_LSW),
+				  (period - hightime));
+	}
+
+	aq_hw_write_reg_bit(aq_hw,
+			    HW_ATL2_TSG_REG_ADR(clk_sel, GPIO_EVENT_GEN_CFG),
+			    HW_ATL2_TSG_GPIO_EVENT_MODE_MSK |
+				HW_ATL2_TSG_GPIO_OUTPUT_EN_MSK |
+				HW_ATL2_TSG_GPIO_GEN_OUTPUT_EN_MSK,
+			   HW_ATL2_TSG_GPIO_OUTPUT_EN_SHIFT,
+			   (!ts ? 0 : val));
+}
+
+void hw_atl2_rpf_rx_desc_timestamp_req_set(struct aq_hw_s *aq_hw, u32 request,
+					   u32 descriptor)
+{
+	aq_hw_write_reg_bit(aq_hw,
+			    HW_ATL2_RPF_TIMESTAMP_REQ_DESCD_ADR(descriptor),
+			    HW_ATL2_RPF_TIMESTAMP_REQ_DESCD_MSK,
+			    HW_ATL2_RPF_TIMESTAMP_REQ_DESCD_SHIFT, request);
+}
+
 /* TX */
 
 void hw_atl2_tpb_tx_tc_q_rand_map_en_set(struct aq_hw_s *aq_hw,
@@ -93,6 +379,30 @@ void hw_atl2_reg_tx_intr_moder_ctrl_set(struct aq_hw_s *aq_hw,
 			tx_intr_moderation_ctl);
 }
 
+void hw_atl2_tdm_tx_desc_timestamp_writeback_en_set(struct aq_hw_s *aq_hw,
+						    u32 enable, u32 descriptor)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_TDM_DESCD_TS_WRB_EN_ADR(descriptor),
+			    HW_ATL2_TDM_DESCD_TS_WRB_EN_MSK,
+			    HW_ATL2_TDM_DESCD_TS_WRB_EN_SHIFT, enable);
+}
+
+void hw_atl2_tdm_tx_desc_timestamp_en_set(struct aq_hw_s *aq_hw, u32 enable,
+					  u32 descriptor)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_TDM_DESCD_TS_EN_ADR(descriptor),
+			    HW_ATL2_TDM_DESCD_TS_EN_MSK,
+			    HW_ATL2_TDM_DESCD_TS_EN_SHIFT, enable);
+}
+
+void hw_atl2_tdm_tx_desc_avb_en_set(struct aq_hw_s *aq_hw, u32 enable,
+				    u32 descriptor)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_TDM_DESCD_AVB_EN_ADR(descriptor),
+			    HW_ATL2_TDM_DESCD_AVB_EN_MSK,
+			    HW_ATL2_TDM_DESCD_AVB_EN_SHIFT, enable);
+}
+
 void hw_atl2_tps_tx_pkt_shed_data_arb_mode_set(struct aq_hw_s *aq_hw,
 					       const u32 data_arb_mode)
 {
@@ -122,6 +432,20 @@ void hw_atl2_tps_tx_pkt_shed_tc_data_weight_set(struct aq_hw_s *aq_hw,
 			    weight);
 }
 
+void hw_atl2_tdm_tx_data_read_req_limit_set(struct aq_hw_s *aq_hw, u32 limit)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_TDM_TX_DATA_RD_REQ_LIMIT_ADR,
+			    HW_ATL2_TDM_TX_DATA_RD_REQ_LIMIT_MSK,
+			    HW_ATL2_TDM_TX_DATA_RD_REQ_LIMIT_SHIFT, limit);
+}
+
+void hw_atl2_tdm_tx_desc_read_req_limit_set(struct aq_hw_s *aq_hw, u32 limit)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_TDM_TX_DESC_RD_REQ_LIMIT_ADR,
+			    HW_ATL2_TDM_TX_DESC_RD_REQ_LIMIT_MSK,
+			    HW_ATL2_TDM_TX_DESC_RD_REQ_LIMIT_SHIFT, limit);
+}
+
 u32 hw_atl2_get_hw_version(struct aq_hw_s *aq_hw)
 {
 	return aq_hw_read_reg(aq_hw, HW_ATL2_FPGA_VER_ADR);
@@ -164,6 +488,13 @@ void hw_atl2_rpf_act_rslvr_section_en_set(struct aq_hw_s *aq_hw, u32 sections)
 			    sections);
 }
 
+u32 hw_atl2_rpf_act_rslvr_section_en_get(struct aq_hw_s *aq_hw)
+{
+	return aq_hw_read_reg_bit(aq_hw, HW_ATL2_RPF_REC_TAB_EN_ADR,
+				  HW_ATL2_RPF_REC_TAB_EN_MSK,
+				  HW_ATL2_RPF_REC_TAB_EN_SHIFT);
+}
+
 void hw_atl2_mif_shared_buf_get(struct aq_hw_s *aq_hw, int offset, u32 *data,
 				int len)
 {
@@ -232,3 +563,31 @@ void hw_atl2_mif_host_req_int_clr(struct aq_hw_s *aq_hw, u32 val)
 	return aq_hw_write_reg(aq_hw, HW_ATL2_MCP_HOST_REQ_INT_CLR_ADR,
 			       val);
 }
+
+void hw_atl2_tsg1_ext_gpio_ts_input_select_set(struct aq_hw_s *aq_hw,
+					       u32 tsg_gpio_ts_select)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_TSG1_EXT_GPIO_TS_INPUT_SEL_ADR,
+			    HW_ATL2_TSG1_EXT_GPIO_TS_INPUT_SEL_MSK,
+			    HW_ATL2_TSG1_EXT_GPIO_TS_INPUT_SEL_SHIFT,
+			    tsg_gpio_ts_select);
+}
+
+void hw_atl2_tsg0_ext_gpio_ts_input_select_set(struct aq_hw_s *aq_hw,
+					       u32 gpio_ts_in_select)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_TSG0_EXT_GPIO_TS_INPUT_SEL_ADR,
+			    HW_ATL2_TSG0_EXT_GPIO_TS_INPUT_SEL_MSK,
+			    HW_ATL2_TSG0_EXT_GPIO_TS_INPUT_SEL_SHIFT,
+			    gpio_ts_in_select);
+}
+
+void hw_atl2_gpio_special_mode_set(struct aq_hw_s *aq_hw,
+				   u32 gpio_special_mode,
+				   u32 pin)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL2_GPIO_PIN_SPEC_MODE_ADR(pin),
+			    HW_ATL2_GPIO_PIN_SPEC_MODE_MSK,
+			    HW_ATL2_GPIO_PIN_SPEC_MODE_SHIFT,
+			    gpio_special_mode);
+}
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_llh.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_llh.h
index 98c7a4621297..01aaf701b201 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_llh.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_llh.h
@@ -10,6 +10,11 @@
 
 struct aq_hw_s;
 
+/* Set Enable usage of extended tags from 32-255. */
+void hw_atl2_phi_ext_tag_set(struct aq_hw_s *aq_hw, u32 val);
+/* Get Enable usage of extended tags from 32-255. */
+u32 hw_atl2_phi_ext_tag_get(struct aq_hw_s *aq_hw);
+
 /* Set TX Interrupt Moderation Control Register */
 void hw_atl2_reg_tx_intr_moder_ctrl_set(struct aq_hw_s *aq_hw,
 					u32 tx_intr_moderation_ctl,
@@ -19,7 +24,7 @@ void hw_atl2_reg_tx_intr_moder_ctrl_set(struct aq_hw_s *aq_hw,
 void hw_atl2_rpf_redirection_table2_select_set(struct aq_hw_s *aq_hw,
 					       u32 select);
 
-/** Set RSS HASH type */
+/* Set RSS HASH type */
 void hw_atl2_rpf_rss_hash_type_set(struct aq_hw_s *aq_hw, u32 rss_hash_type);
 
 /* set new RPF enable */
@@ -37,14 +42,92 @@ void hw_atl2_new_rpf_rss_redir_set(struct aq_hw_s *aq_hw, u32 tc, u32 index,
 
 /* Set VLAN filter tag */
 void hw_atl2_rpf_vlan_flr_tag_set(struct aq_hw_s *aq_hw, u32 tag, u32 filter);
+/* set ethertype filter tag */
+void hw_atl2_rpf_etht_flr_tag_set(struct aq_hw_s *aq_hw, u32 tag, u32 filter);
+
+/* get ethertype filter tag */
+u32 hw_atl2_rpf_etht_flr_tag_get(struct aq_hw_s *aq_hw, u32 filter);
+
+/* set L3 v4 dest address */
+void hw_atl2_rpf_l3_v4_dest_addr_set(struct aq_hw_s *aq_hw,
+				     u32 filter, u32 val);
+
+/* set L3 v4 src address */
+void hw_atl2_rpf_l3_v4_src_addr_set(struct aq_hw_s *aq_hw, u32 filter, u32 val);
+
+/* set L3 v4 cmd */
+void hw_atl2_rpf_l3_v4_cmd_set(struct aq_hw_s *aq_hw, u32 val, u32 filter);
+
+/* set L3 v6 cmd */
+void hw_atl2_rpf_l3_v6_cmd_set(struct aq_hw_s *aq_hw, u32 val, u32 filter);
+
+/* set L3 v6 dest address */
+void hw_atl2_rpf_l3_v6_dest_addr_set(struct aq_hw_s *aq_hw, u8 location,
+				     u32 *ipv6_dst);
+
+/* set L3 v6 src address */
+void hw_atl2_rpf_l3_v6_src_addr_set(struct aq_hw_s *aq_hw, u8 location,
+				    u32 *ipv6_src);
+
+/* set L3 v6 v4 select */
+void hw_atl2_rpf_l3_v6_v4_select_set(struct aq_hw_s *aq_hw, u32 val);
+
+/* set L3 v4 tag */
+void hw_atl2_rpf_l3_v4_tag_set(struct aq_hw_s *aq_hw, u32 val, u32 filter);
+
+/* set L3 v6 tag */
+void hw_atl2_rpf_l3_v6_tag_set(struct aq_hw_s *aq_hw, u32 val, u32 filter);
+
+/* set L4 cmd */
+void hw_atl2_rpf_l4_cmd_set(struct aq_hw_s *aq_hw, u32 val, u32 filter);
+
+/* set L4 tag */
+void hw_atl2_rpf_l4_tag_set(struct aq_hw_s *aq_hw, u32 val, u32 filter);
 
 /* set tx random TC-queue mapping enable bit */
 void hw_atl2_tpb_tx_tc_q_rand_map_en_set(struct aq_hw_s *aq_hw,
 					 const u32 tc_q_rand_map_en);
 
+void hw_atl2_tpb_tps_highest_priority_tc_enable_set(struct aq_hw_s *aq_hw,
+						    u32 tps_highest_prio_tc_en);
+
+void hw_atl2_tpb_tps_highest_priority_tc_set(struct aq_hw_s *aq_hw,
+					     u32 tps_highest_prio_tc);
+
 /* set tx buffer clock gate enable */
 void hw_atl2_tpb_tx_buf_clk_gate_en_set(struct aq_hw_s *aq_hw, u32 clk_gate_en);
 
+/* tsg */
+
+void hw_atl2_tsg_clock_en(struct aq_hw_s *aq_hw, u32 clock_sel,
+			  u32 clock_enable);
+
+void hw_atl2_tsg_clock_reset(struct aq_hw_s *aq_hw, u32 clock_sel);
+u64 hw_atl2_tsg_clock_read(struct aq_hw_s *aq_hw, u32 clock_sel);
+void hw_atl2_tsg_clock_add(struct aq_hw_s *aq_hw, u32 clock_sel,
+			   u64 ns);
+void hw_atl2_tsg_clock_sub(struct aq_hw_s *aq_hw, u32 clock_sel,
+			   u64 ns);
+void hw_atl2_tsg_clock_increment_set(struct aq_hw_s *aq_hw, u32 clock_sel,
+				     u32 ns, u32 fns);
+void hw_atl2_tsg_gpio_isr_to_host_set(struct aq_hw_s *aq_hw, int on,
+				      u32 clock_sel);
+void hw_atl2_tsg_ext_isr_to_host_set(struct aq_hw_s *aq_hw, int on);
+void hw_atl2_tsg_gpio_clear_status(struct aq_hw_s *aq_hw);
+void hw_atl2_tsg_gpio_input_event_info_get(struct aq_hw_s *aq_hw,
+					   u32 clock_sel,
+					   u32 *event_count,
+					   u64 *event_ts);
+/* Set Rx Descriptor0 Timestamp request */
+void hw_atl2_rpf_rx_desc_timestamp_req_set(struct aq_hw_s *aq_hw, u32 request,
+					   u32 descriptor);
+/* Set Tx Descriptor Timestamp writeback Enable */
+void hw_atl2_tdm_tx_desc_timestamp_writeback_en_set(struct aq_hw_s *aq_hw,
+						    u32 enable,
+						    u32 descriptor);
+/* Set Tx Descriptor Timestamp enable */
+void hw_atl2_tdm_tx_desc_timestamp_en_set(struct aq_hw_s *aq_hw, u32 enable,
+					  u32 descriptor);
 void hw_atl2_tps_tx_pkt_shed_data_arb_mode_set(struct aq_hw_s *aq_hw,
 					       const u32 data_arb_mode);
 
@@ -57,6 +140,15 @@ void hw_atl2_tps_tx_pkt_shed_tc_data_max_credit_set(struct aq_hw_s *aq_hw,
 void hw_atl2_tps_tx_pkt_shed_tc_data_weight_set(struct aq_hw_s *aq_hw,
 						const u32 tc,
 						const u32 weight);
+/* Set Tx Descriptor AVB enable */
+void hw_atl2_tdm_tx_desc_avb_en_set(struct aq_hw_s *aq_hw, u32 enable,
+				    u32 descriptor);
+void hw_atl2_tsg_ptp_gpio_gen_pulse(struct aq_hw_s *aq_hw, u32 clk_sel,
+				    u64 ts, u32 period, u32 hightime);
+
+void hw_atl2_tdm_tx_data_read_req_limit_set(struct aq_hw_s *aq_hw, u32 limit);
+
+void hw_atl2_tdm_tx_desc_read_req_limit_set(struct aq_hw_s *aq_hw, u32 limit);
 
 u32 hw_atl2_get_hw_version(struct aq_hw_s *aq_hw);
 
@@ -69,6 +161,9 @@ void hw_atl2_rpf_act_rslvr_record_set(struct aq_hw_s *aq_hw, u8 location,
 /* set enable action resolver section */
 void hw_atl2_rpf_act_rslvr_section_en_set(struct aq_hw_s *aq_hw, u32 sections);
 
+/* get enable action resolver section */
+u32 hw_atl2_rpf_act_rslvr_section_en_get(struct aq_hw_s *aq_hw);
+
 /* get data from firmware shared input buffer */
 void hw_atl2_mif_shared_buf_get(struct aq_hw_s *aq_hw, int offset, u32 *data,
 				int len);
@@ -98,5 +193,13 @@ u32 hw_atl2_mif_host_req_int_get(struct aq_hw_s *aq_hw);
 
 /* clear host interrupt request */
 void hw_atl2_mif_host_req_int_clr(struct aq_hw_s *aq_hw, u32 val);
-
+/* Set TSG EXT GPIO TS Input select */
+void hw_atl2_tsg1_ext_gpio_ts_input_select_set(struct aq_hw_s *aq_hw,
+					       u32 tsg_gpio_ts_select);
+/* Set PTP EXT GPIO TS Input select */
+void hw_atl2_tsg0_ext_gpio_ts_input_select_set(struct aq_hw_s *aq_hw,
+					       u32 gpio_ts_in_select);
+/* Set GPIO Special Mode */
+void hw_atl2_gpio_special_mode_set(struct aq_hw_s *aq_hw,
+				   u32 gpio_special_mode, u32 pin);
 #endif /* HW_ATL2_LLH_H */
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_llh_internal.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_llh_internal.h
index e34c5cda061e..9b9be3ef1332 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_llh_internal.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_llh_internal.h
@@ -5,6 +5,11 @@
 
 #ifndef HW_ATL2_LLH_INTERNAL_H
 #define HW_ATL2_LLH_INTERNAL_H
+/* RX timestamp_req_desc{D} [1:0] Bitfield Definitions
+ */
+#define HW_ATL2_RPF_TIMESTAMP_REQ_DESCD_ADR(descr) (0x00005B08 + (descr) * 0x20)
+#define HW_ATL2_RPF_TIMESTAMP_REQ_DESCD_MSK 0x00030000
+#define HW_ATL2_RPF_TIMESTAMP_REQ_DESCD_SHIFT 16
 
 /* RX pif_rpf_redir_2_en_i Bitfield Definitions
  * PORT="pif_rpf_redir_2_en_i"
@@ -114,7 +119,68 @@
 #define HW_ATL2_RPF_VL_TAG_WIDTH 4
 /* default value of bitfield vlan_req_tag0{f}[3:0] */
 #define HW_ATL2_RPF_VL_TAG_DEFAULT 0x0
-
+/* register address for bitfield etype_req_tag0{f}[2:0] */
+#define HW_ATL2_RPF_ET_TAG_ADR(filter) (0x00005340 + (filter) * 0x4)
+/* bitmask for bitfield etype_req_tag0{f}[2:0] */
+#define HW_ATL2_RPF_ET_TAG_MSK 0x00000007
+/* lower bit position of bitfield etype_req_tag0{f}[2:0] */
+#define HW_ATL2_RPF_ET_TAG_SHIFT 0
+/* Lower bit position of bitfield l3_l4_act{F}[2:0] */
+#define HW_ATL2_RPF_L3_L4_ACTF_SHIFT 16
+/* Bitmask for bitfield l3_l4_rxq{F}[4:0] */
+#define HW_ATL2_RPF_L3_L4_RXQF_MSK 0x00001F00u
+/* Lower bit position of bitfield l3_l4_rxq{F}[4:0] */
+#define HW_ATL2_RPF_L3_L4_RXQF_SHIFT 8
+/* Register address for bitfield rpf_l3_v6_sa{F}_dw{D}[1F:0] */
+#define HW_ATL2_RPF_L3_SA_DW_ADR(filter, dword) \
+	(0x00006400u + (filter) * 0x10 + (dword) * 0x4)
+
+/* Register address for bitfield rpf_l3_v6_da{F}_dw{D}[1F:0] */
+#define HW_ATL2_RPF_L3_DA_DW_ADR(filter, dword) \
+	(0x00006480u + (filter) * 0x10 + (dword) * 0x4)
+
+/* Register address for bitfield rpf_l3_cmd{F}[1F:0] */
+#define HW_ATL2_RPF_L3_V4_CMD_ADR(filter) (0x00006500u + (filter) * 0x4)
+/* Bitmask for bitfield rpf_l3_cmd{F}[F:0] */
+#define HW_ATL2_RPF_L3_V4_CMD_MSK 0x0000FFFFu
+/* Lower bit position of bitfield rpf_l3_cmd{F}[1F:0] */
+#define HW_ATL2_RPF_L3_V4_CMD_SHIFT 0
+/* Register address for bitfield rpf_l3_v6_cmd{F}[1F:0] */
+#define HW_ATL2_RPF_L3_V6_CMD_ADR(filter) (0x00006500u + (filter) * 0x4)
+/* Bitmask for bitfield rpf_l3_v6_cmd{F}[F:0] */
+#define HW_ATL2_RPF_L3_V6_CMD_MSK 0xFF7F0000u
+/* Lower bit position of bitfield rpf_l3_v6_cmd{F}[1F:0] */
+#define HW_ATL2_RPF_L3_V6_CMD_SHIFT 0
+/* Register address for bitfield rpf_l3_v6_cmd{F}[F:0] */
+#define HW_ATL2_RPF_L3_V6_V4_SELECT_ADR 0x00006500u
+/* Bitmask for bitfield pif_rpf_l3_v6_v4_select*/
+#define HW_ATL2_RPF_L3_V6_V4_SELECT_MSK 0x00800000u
+/* Lower bit position of bitfield pif_rpf_l3_v6_v4_select */
+#define HW_ATL2_RPF_L3_V6_V4_SELECT_SHIFT 23
+/* Register address for bitfield rpf_l3_v4_req_tag{F}[2:0] */
+#define HW_ATL2_RPF_L3_V4_TAG_ADR(filter) (0x00006500u + (filter) * 0x4)
+/* Bitmask for bitfield rpf_l3_v4_req_tag{F}[2:0] */
+#define HW_ATL2_RPF_L3_V4_TAG_MSK 0x00000070u
+/* Lower bit position of bitfield rpf_l3_v4_req_tag{F}[2:0] */
+#define HW_ATL2_RPF_L3_V4_TAG_SHIFT 4
+/* Register address for bitfield rpf_l3_v6_req_tag{F}[2:0] */
+#define HW_ATL2_RPF_L3_V6_TAG_ADR(filter) (0x00006500u + (filter) * 0x4)
+/* Bitmask for bitfield rpf_l3_v6_req_tag{F}[2:0] */
+#define HW_ATL2_RPF_L3_V6_TAG_MSK 0x00700000
+/* Lower bit position of bitfield rpf_l3_v6_req_tag{F}[2:0] */
+#define HW_ATL2_RPF_L3_V6_TAG_SHIFT 20
+/* Register address for bitfield rpf_l4_cmd{F}[2:0] */
+#define HW_ATL2_RPF_L4_CMD_ADR(filter) (0x00006520u + (filter) * 0x4)
+/* Bitmask for bitfield rpf_l4_cmd{F}[2:0] */
+#define HW_ATL2_RPF_L4_CMD_MSK 0x00000007u
+/* Lower bit position of bitfield rpf_l4_cmd{F}[2:0] */
+#define HW_ATL2_RPF_L4_CMD_SHIFT 0
+/* Register address for bitfield rpf_l4_tag{F}[2:0] */
+#define HW_ATL2_RPF_L4_TAG_ADR(filter) (0x00006520u + (filter) * 0x4)
+/* Bitmask for bitfield rpf_l4_tag{F}[2:0] */
+#define HW_ATL2_RPF_L4_TAG_MSK 0x00000070u
+/* Lower bit position of bitfield rpf_l4_tag{F}[2:0] */
+#define HW_ATL2_RPF_L4_TAG_SHIFT 4
 /* RX rx_q{Q}_tc_map[2:0] Bitfield Definitions
  * Preprocessor definitions for the bitfield "rx_q{Q}_tc_map[2:0]".
  * Parameter: Queue {Q} | bit-level stride | range [0, 31]
@@ -131,7 +197,24 @@
 #define HW_ATL2_RX_Q_TC_MAP_WIDTH 3
 /* Default value of bitfield rx_q{Q}_tc_map[2:0] */
 #define HW_ATL2_RX_Q_TC_MAP_DEFAULT 0x0
-
+/* TX desc{D}_ts_wrb_en Bitfield Definitions
+ */
+#define HW_ATL2_TDM_DESCD_TS_WRB_EN_ADR(descriptor) \
+	(0x00007C08 + (descriptor) * 0x40)
+#define HW_ATL2_TDM_DESCD_TS_WRB_EN_MSK 0x00040000
+#define HW_ATL2_TDM_DESCD_TS_WRB_EN_SHIFT 18
+/* TX desc{D}_ts_en Bitfield Definitions
+ */
+#define HW_ATL2_TDM_DESCD_TS_EN_ADR(descriptor) \
+	(0x00007C08 + (descriptor) * 0x40)
+#define HW_ATL2_TDM_DESCD_TS_EN_MSK 0x00020000
+#define HW_ATL2_TDM_DESCD_TS_EN_SHIFT 17
+/* TX desc{D}_avb_en Bitfield Definitions
+ */
+#define HW_ATL2_TDM_DESCD_AVB_EN_ADR(descriptor) \
+	(0x00007C08 + (descriptor) * 0x40)
+#define HW_ATL2_TDM_DESCD_AVB_EN_MSK 0x00010000
+#define HW_ATL2_TDM_DESCD_AVB_EN_SHIFT 16
 /* tx tx_tc_q_rand_map_en bitfield definitions
  * preprocessor definitions for the bitfield "tx_tc_q_rand_map_en".
  * port="pif_tpb_tx_tc_q_rand_map_en_i"
@@ -221,7 +304,18 @@
 #define HW_ATL2_TPS_DATA_TCTCREDIT_MAX_WIDTH 16
 /* default value of bitfield data_tc{t}_credit_max[f:0] */
 #define HW_ATL2_TPS_DATA_TCTCREDIT_MAX_DEFAULT 0x0
-
+/* register address for bitfield pif_tpb_highest_prio_tc_en */
+#define HW_ATL2_TPB_HIGHEST_PRIO_TC_EN_ADR 0x00007180
+/* bitmask for bitfield pif_tpb_highest_prio_tc_en */
+#define HW_ATL2_TPB_HIGHEST_PRIO_TC_EN_MSK 0x00000100
+/* lower bit position of bitfield pif_tpb_highest_prio_tc_en */
+#define HW_ATL2_TPB_HIGHEST_PRIO_TC_EN_SHIFT 8
+/* register address for bitfield pif_tpb_highest_prio_tc */
+#define HW_ATL2_TPB_HIGHEST_PRIO_TC_ADR 0x00007180
+/* bitmask for bitfield pif_tpb_highest_prio_tc */
+#define HW_ATL2_TPB_HIGHEST_PRIO_TC_MSK 0x00000007
+/* lower bit position of bitfield pif_tpb_highest_prio_tc */
+#define HW_ATL2_TPB_HIGHEST_PRIO_TC_SHIFT 0
 /* tx data_tc{t}_weight[e:0] bitfield definitions
  * preprocessor definitions for the bitfield "data_tc{t}_weight[e:0]".
  * parameter: tc {t} | stride size 0x4 | range [0, 7]
@@ -248,7 +342,87 @@
  */
 
 #define HW_ATL2_TX_INTR_MODERATION_CTL_ADR(queue) (0x00007c28u + (queue) * 0x40)
-
+/* TX tx_data_rd_req_limit[7:0] Bitfield Definitions
+ */
+#define HW_ATL2_TDM_TX_DATA_RD_REQ_LIMIT_ADR 0x00007B04
+#define HW_ATL2_TDM_TX_DATA_RD_REQ_LIMIT_MSK 0x0000FF00
+#define HW_ATL2_TDM_TX_DATA_RD_REQ_LIMIT_SHIFT 8
+/* TX tx_desc_rd_req_limit[4:0] Bitfield Definitions
+ */
+#define HW_ATL2_TDM_TX_DESC_RD_REQ_LIMIT_ADR 0x00007B04
+#define HW_ATL2_TDM_TX_DESC_RD_REQ_LIMIT_MSK 0x0000001F
+#define HW_ATL2_TDM_TX_DESC_RD_REQ_LIMIT_SHIFT 0
+/* register address for bitfield uP Force Interrupt */
+#define HW_ATL2_GLB_CONTROL_2_ADR 0x00000404
+#define HW_ATL2_MIF_INTERRUPT_2_TO_ITR_MSK 0x00000100
+/* lower bit position of bitfield MIF Interrupt to ITR */
+#define HW_ATL2_MIF_INTERRUPT_TO_ITR_SHIFT 6
+#define HW_ATL2_EN_INTERRUPT_MIF2_TO_ITR_MSK 0x00001000
+/* lower bit position of bitfield Enable MIF Interrupt to ITR */
+#define HW_ATL2_EN_INTERRUPT_TO_ITR_SHIFT 0xA
+#define HW_ATL2_GLOBAL_INTERNAL_ALARMS_1_ADR 0x00000924
+#define HW_ATL2_GLOBAL_HIGH_PRIO_INTERRUPT_1_MASK_ADR 0x00000964
+/* bitmask for bitfield TSG PTM GPIO interrupt */
+#define HW_ATL2_TSG_TSG1_GPIO_INTERRUPT_MSK 0x00000200
+/* lower bit position of bitfield TSG PTM GPIO interrupt */
+#define HW_ATL2_TSG_TSG1_GPIO_INTERRUPT_SHIFT 9
+/* bitmask for bitfield TSG0 GPIO interrupt */
+#define HW_ATL2_TSG_TSG0_GPIO_INTERRUPT_MSK 0x00000020
+/* lower bit position of bitfield TSG0 GPIO interrupt */
+#define HW_ATL2_TSG_TSG0_GPIO_INTERRUPT_SHIFT 5
+/* TSG registers */
+#define HW_ATL2_TSG_REG_ADR(clk, reg_name) \
+	((clk) == 0 ? HW_ATL2_CLK0_##reg_name##_ADR :\
+		 HW_ATL2_CLK1_##reg_name##_ADR)
+
+#define HW_ATL2_CLK0_CLOCK_CFG_ADR 0x00000CA0u
+#define HW_ATL2_CLK1_CLOCK_CFG_ADR 0x00000D50u
+#define HW_ATL2_TSG_SYNC_RESET_MSK 0x00000001
+#define HW_ATL2_TSG_SYNC_RESET_SHIFT 0x00000000
+#define HW_ATL2_TSG_CLOCK_EN_MSK 0x00000002
+#define HW_ATL2_TSG_CLOCK_EN_SHIFT 0x00000001
+#define HW_ATL2_CLK0_CLOCK_MODIF_CTRL_ADR 0x00000CA4u
+#define HW_ATL2_CLK1_CLOCK_MODIF_CTRL_ADR 0x00000D54u
+#define HW_ATL2_TSG_SUBTRACT_COUNTER_MSK 0x00000002
+#define HW_ATL2_TSG_ADD_COUNTER_MSK 0x00000004
+#define HW_ATL2_TSG_LOAD_INC_CFG_MSK 0x00000008
+#define HW_ATL2_CLK0_CLOCK_MODIF_VAL_LSW_ADR 0x00000CA8u
+#define HW_ATL2_CLK1_CLOCK_MODIF_VAL_LSW_ADR 0x00000D58u
+#define HW_ATL2_CLK0_CLOCK_INC_CFG_ADR 0x00000CB0u
+#define HW_ATL2_CLK1_CLOCK_INC_CFG_ADR 0x00000D60u
+#define HW_ATL2_CLK0_READ_CUR_NS_LSW_ADR 0x00000CB8u
+#define HW_ATL2_CLK1_READ_CUR_NS_LSW_ADR 0x00000D68u
+
+#define HW_ATL2_CLK0_GPIO_CFG_ADR 0x00000CC4u
+#define HW_ATL2_CLK1_GPIO_CFG_ADR 0x00000D74u
+#define HW_ATL2_TSG_GPIO_IN_MONITOR_EN_SHIFT 0x00000000
+#define HW_ATL2_TSG_GPIO_IN_MONITOR_EN_MSK 0x00000001
+#define HW_ATL2_TSG_GPIO_IN_MODE_SHIFT 0x00000001
+#define HW_ATL2_TSG_GPIO_IN_MODE_MSK 0x00000006
+#define HW_ATL2_TSG_GPIO_IN_MODE_POSEDGE 0x00000000
+#define HW_ATL2_CLK0_EXT_CLK_COUNT_ADR 0x00000CCCu
+#define HW_ATL2_CLK1_EXT_CLK_COUNT_ADR 0x00000D7Cu
+#define HW_ATL2_CLK0_GPIO_EVENT_TS_LSW_ADR 0x00000CD0u
+#define HW_ATL2_CLK1_GPIO_EVENT_TS_LSW_ADR 0x00000D80u
+#define HW_ATL2_CLK0_GPIO_EVENT_GEN_TS_LSW_ADR 0x00000CE0u
+#define HW_ATL2_CLK1_GPIO_EVENT_GEN_TS_LSW_ADR 0x00000D90u
+#define HW_ATL2_CLK0_GPIO_EVENT_GEN_CFG_ADR 0x00000CE8u
+#define HW_ATL2_CLK1_GPIO_EVENT_GEN_CFG_ADR 0x00000D98u
+#define HW_ATL2_TSG_GPIO_OUTPUT_EN_SHIFT 0x00000000
+#define HW_ATL2_TSG_GPIO_OUTPUT_EN_MSK 0x00000001
+#define HW_ATL2_TSG_GPIO_EVENT_MODE_SHIFT 0x00000001
+#define HW_ATL2_TSG_GPIO_EVENT_MODE_MSK 0x00000006
+#define HW_ATL2_TSG_GPIO_EVENT_MODE_SET_ON_TIME 0x00000003
+#define HW_ATL2_TSG_GPIO_GEN_OUTPUT_EN_MSK 0x00000008
+#define HW_ATL2_CLK0_GPIO_EVENT_HIGH_TIME_LSW_ADR 0x00000CF0u
+#define HW_ATL2_CLK1_GPIO_EVENT_HIGH_TIME_LSW_ADR 0x00000DA0u
+#define HW_ATL2_CLK0_GPIO_EVENT_LOW_TIME_LSW_ADR 0x00000CF8u
+#define HW_ATL2_CLK1_GPIO_EVENT_LOW_TIME_LSW_ADR 0x00000DA8u
+/* PCIE Extended tag enable Bitfield Definitions
+ */
+#define HW_ATL2_PHI_EXT_TAG_EN_ADR 0x00001000
+#define HW_ATL2_PHI_EXT_TAG_EN_MSK 0x00000020
+#define HW_ATL2_PHI_EXT_TAG_EN_SHIFT 5
 /* Launch time control register */
 #define HW_ATL2_LT_CTRL_ADR 0x00007a1c
 
@@ -387,5 +561,25 @@
 #define HW_ATL2_MCP_HOST_REQ_INT_ADR 0x00000F00u
 #define HW_ATL2_MCP_HOST_REQ_INT_SET_ADR 0x00000F04u
 #define HW_ATL2_MCP_HOST_REQ_INT_CLR_ADR 0x00000F08u
-
+/* Register address for bitfield PTP EXT GPIO TS SEL */
+#define HW_ATL2_TSG0_EXT_GPIO_TS_INPUT_SEL_ADR 0x00003664
+/* Bitmask for bitfield PTP EXT GPIO TS SEL */
+#define HW_ATL2_TSG0_EXT_GPIO_TS_INPUT_SEL_MSK 0x00001F00
+/* Lower bit position of bitfield PTP EXT GPIO TS SEL */
+#define HW_ATL2_TSG0_EXT_GPIO_TS_INPUT_SEL_SHIFT 8
+/* Register address for bitfield TSG EXT GPIO TS SEL */
+#define HW_ATL2_TSG1_EXT_GPIO_TS_INPUT_SEL_ADR 0x00003660
+/* Bitmask for bitfield TSG EXT GPIO TS SEL */
+#define HW_ATL2_TSG1_EXT_GPIO_TS_INPUT_SEL_MSK 0x00001F00
+/* Lower bit position of bitfield TSG EXT GPIO TS SEL */
+#define HW_ATL2_TSG1_EXT_GPIO_TS_INPUT_SEL_SHIFT 8
+/* Register address for bitfield GPIO{P} Special Mode */
+#define HW_ATL2_GPIO_PIN_SPEC_MODE_ADR(pin) (0x00003698 + (pin) * 0x4)
+/* Bitmask for bitfield GPIO{P} Special Mode */
+#define HW_ATL2_GPIO_PIN_SPEC_MODE_MSK 0x0000000C
+/* Lower bit position of bitfield GPIO{P} Special Mode */
+#define HW_ATL2_GPIO_PIN_SPEC_MODE_SHIFT 2
+#define HW_ATL2_GPIO_PIN_SPEC_MODE_TSG1_EVENT_OUTPUT 0
+#define HW_ATL2_GPIO_PIN_SPEC_MODE_TSG0_EVENT_OUTPUT 2
+#define HW_ATL2_GPIO_PIN_SPEC_MODE_GPIO 3
 #endif /* HW_ATL2_LLH_INTERNAL_H */
-- 
2.43.0


