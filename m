Return-Path: <netdev+bounces-285776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNvwNIbR/Wl2jgAAu9opvQ
	(envelope-from <netdev+bounces-285776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:05:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C80B4F6157
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 354AC3055E8C
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CABA3DC4C6;
	Fri,  8 May 2026 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hF74Ul8U"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54FC366079;
	Fri,  8 May 2026 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241825; cv=none; b=dLmiJX3n+FOhVEeQs7w+Z51VJphItx58rco2bLcMvQ9qgjg4MkYoKz+AOuqNQfaTdT8ZCRdYaLn36L7vhJGakyFH4n6V20X6CRIizbazFA2pQWUqguaCJUZMXdT6nEK3gCug4aWtON6DM7c0X8M5J+N7MZyxtNOv0xY74IIDAhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241825; c=relaxed/simple;
	bh=PXZjf0Yrl8AcSiqV4M8X8mu7WkwSWrfLyYegGwSDDo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLCzVjcEU8mJC0+AGr033FdWUIzOnI1uRs3Bk0VEti3YVqPvEZTuHiJTORSdsIE0vpgFv+jr2MxX2irslgWXUkAqBJFAjtKjHCU15K4mrKQikA2dBPssZaLn47NCCtgD7pt9oyoUveXBM/R1QeGT+QeryaZgrtwIWeoNCFSrZMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hF74Ul8U; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6484ULid2851331;
	Fri, 8 May 2026 05:03:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
	yUT73V4Fzc+3j+GPiArsJ6IP4UTuHyiOYk+puPGBbQ=; b=hF74Ul8UOZQA+HHei
	QDG6AiX2sF0/czNbB7wp8VirwuWraicNKS4lE2hNkkjfD3nZfXaMOlKznJrnUPD+
	A0xSiESjgt4x+7rtK37znc89Xl6kdAoAaFJqRqs1hWXPNnGQRK9PUdNELU8V7GBD
	J9YvF9mGMd5sMzAEvZlT1Ds0FPwHucARlo6X8nnQtcAMcRE5wnlln5i1+RlMp9uW
	cruKEgocJ4NF7g7nVxF30PXNJcQnM+Q5MoWacR8XFnxFwa1j0n42RoHgYroSRcg+
	/K4X1d2l3308s12Zz7GQev5jFdk9kWxxgZfRgXdHhe4eQlhQvrmPyAbQq2xVpgzt
	EV1WA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e0wy2awj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 05:03:27 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 8 May 2026 05:03:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 8 May 2026 05:03:26 -0700
Received: from BG-LT92649.marvell.com (BG-LT92649.marvell.com [10.28.166.218])
	by maili.marvell.com (Postfix) with ESMTP id 99D343F706D;
	Fri,  8 May 2026 05:03:21 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <irusskikh@marvell.com>, <epomozov@marvell.com>,
        <richardcochran@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <vadim.fedorenko@linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v2 3/9] net: atlantic: decouple aq_set_data_fl3l4() from driver internals driver internals
Date: Fri, 8 May 2026 17:31:50 +0530
Message-ID: <20260508120156.3060-4-sukhdeeps@marvell.com>
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
X-Proofpoint-ORIG-GUID: rCTJ1Yo2xZUQBimXYCjyY4eVAtX3WH8C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyNSBTYWx0ZWRfX0EbsXIZWza6a
 UKeZ5croshy2A0bivMRLG1vBjQtuCK5mzXBcNDoYvocFLatx1AVf6rzNCvskBwhmxuizo7/+0q5
 G5cOIesiWfeITVfHKUE2Nxk8bTBI+LAvU+YB0DVn4LWN1HvF1JhOxrmdDs+wUBVV1IIIqRPt5Sf
 ltBiWtim8F9BUAbAuZqgmfGuRpdFmcKopqnXyuyxP546qSpH3ckKylGc3yd1FOkzvG5hRWovKiA
 URzG4HbW+K7lqX6F5dKd7Gose5N/QljICbQyBxMf+wCdse52v84H7HQm0MdnpFsRdK3/8uQoVL4
 cJy7kLBJi7AKV+UW+0+vpxDkeND6W9H+bnT1Qt34dkJ/RBUGoXy7QyjbKzlEWmnR8lLCdQXFFYI
 NGmElLcnIjraRZA+aZ3wpvt4Ldp6pPOzID7JbdTxYVs5fEjH8LF9CgEURVbKP14+wBSMz75LTXM
 4U/p8Jpqo7ai2YSYisA==
X-Proofpoint-GUID: rCTJ1Yo2xZUQBimXYCjyY4eVAtX3WH8C
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=69fdd10f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=OqYplCa96tyeLioHD84A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Rspamd-Queue-Id: 3C80B4F6157
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
	TAGGED_FROM(0.00)[bounces-285776-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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

Refactor aq_set_data_fl3l4() to take an ethtool_rx_flow_spec pointer and
an explicit HW register location instead of driver-internal structures
(aq_nic_s, aq_rx_filter). This makes the function reusable for PTP
filter setup which constructs flow specs independently.

Key changes:
- Add aq_is_ipv6_flow_type() helper to derive IPv6 status from the
  flow_type field, replacing the dependency on rx_fltrs->fl3l4.is_ipv6
  shared state.
- Change aq_set_data_fl3l4() signature to accept (fsp, data, location,
  add) and export it via aq_filters.h.
- Update aq_add_del_fl3l4() to compute the HW register location and
  pass it explicitly.

Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
---
 .../ethernet/aquantia/atlantic/aq_filters.c   | 31 ++++++++++++++-----
 .../ethernet/aquantia/atlantic/aq_filters.h   |  3 ++
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_filters.c b/drivers/net/ethernet/aquantia/atlantic/aq_filters.c
index 150a0b1af26a..4be7b629bfac 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_filters.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_filters.c
@@ -181,6 +181,20 @@ aq_check_approve_fvlan(struct aq_nic_s *aq_nic,
 	return 0;
 }
 
+static bool aq_is_ipv6_flow_type(const struct ethtool_rx_flow_spec *fsp)
+{
+	switch (fsp->flow_type & ~FLOW_EXT) {
+	case TCP_V6_FLOW:
+	case UDP_V6_FLOW:
+	case SCTP_V6_FLOW:
+	case IPV6_FLOW:
+	case IPV6_USER_FLOW:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int __must_check
 aq_check_filter(struct aq_nic_s *aq_nic,
 		struct ethtool_rx_flow_spec *fsp)
@@ -466,18 +480,16 @@ static int aq_add_del_fvlan(struct aq_nic_s *aq_nic,
 	return aq_filters_vlans_update(aq_nic);
 }
 
-static int aq_set_data_fl3l4(struct aq_nic_s *aq_nic,
-			     struct aq_rx_filter *aq_rx_fltr,
-			     struct aq_rx_filter_l3l4 *data, bool add)
+int aq_set_data_fl3l4(const struct ethtool_rx_flow_spec *fsp,
+		      struct aq_rx_filter_l3l4 *data,
+		      int location, bool add)
 {
-	struct aq_hw_rx_fltrs_s *rx_fltrs = aq_get_hw_rx_fltrs(aq_nic);
-	const struct ethtool_rx_flow_spec *fsp = &aq_rx_fltr->aq_fsp;
 	u32 flow = fsp->flow_type & ~FLOW_EXT;
 
 	memset(data, 0, sizeof(*data));
 
-	data->is_ipv6 = rx_fltrs->fl3l4.is_ipv6;
-	data->location = HW_ATL_GET_REG_LOCATION_FL3L4(fsp->location);
+	data->is_ipv6 = aq_is_ipv6_flow_type(fsp);
+	data->location = location;
 
 	if (!add)
 		return 0;
@@ -569,13 +581,16 @@ static int aq_add_del_fl3l4(struct aq_nic_s *aq_nic,
 	const struct aq_hw_ops *aq_hw_ops = aq_nic->aq_hw_ops;
 	struct aq_hw_s *aq_hw = aq_nic->aq_hw;
 	struct aq_rx_filter_l3l4 data;
+	int location;
 	int err;
 
 	if (unlikely(aq_rx_fltr->aq_fsp.location < AQ_RX_FIRST_LOC_FL3L4 ||
 		     aq_rx_fltr->aq_fsp.location > AQ_RX_LAST_LOC_FL3L4))
 		return -EINVAL;
 
-	aq_set_data_fl3l4(aq_nic, aq_rx_fltr, &data, add);
+	location = HW_ATL_GET_REG_LOCATION_FL3L4(aq_rx_fltr->aq_fsp.location);
+
+	aq_set_data_fl3l4(&aq_rx_fltr->aq_fsp, &data, location, add);
 
 	err = aq_set_fl3l4(aq_hw, aq_hw_ops, &data);
 	if (err)
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_filters.h b/drivers/net/ethernet/aquantia/atlantic/aq_filters.h
index 122e06c88a33..96e89c8e52d0 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_filters.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_filters.h
@@ -32,5 +32,8 @@ int aq_clear_rxnfc_all_rules(struct aq_nic_s *aq_nic);
 int aq_reapply_rxnfc_all_rules(struct aq_nic_s *aq_nic);
 int aq_filters_vlans_update(struct aq_nic_s *aq_nic);
 int aq_filters_vlan_offload_off(struct aq_nic_s *aq_nic);
+int aq_set_data_fl3l4(const struct ethtool_rx_flow_spec *fsp,
+		      struct aq_rx_filter_l3l4 *data,
+		      int location, bool add);
 
 #endif /* AQ_FILTERS_H */
-- 
2.43.0


