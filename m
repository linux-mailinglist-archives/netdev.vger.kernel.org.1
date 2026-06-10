Return-Path: <netdev+bounces-297642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UHY/F31RKWpIUwMAu9opvQ
	(envelope-from <netdev+bounces-297642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:58:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5027F66903B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:58:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=CHCLINod;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297642-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297642-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02CB03014B3A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9577403B0E;
	Wed, 10 Jun 2026 11:55:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49388403AF7;
	Wed, 10 Jun 2026 11:55:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092523; cv=none; b=uzxeuidbDiTybwykjty7jlbzNz80v/Gyam4w9/aNsPCGd2QQEMLQugaOk05Bu3qJDoR5j3/RWRc59jKBZNSjGNthDRaSJb97MRfPVrmFqsnFMXc/71twnmWLfFh7HhEWmgNTWM7LlTcIuLHcQxcwPwZu7xy8/L/pEi/M/FTczHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092523; c=relaxed/simple;
	bh=PXZjf0Yrl8AcSiqV4M8X8mu7WkwSWrfLyYegGwSDDo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qa8za8GKZNleQrGiLeZCg4/ymzrSMlS+lOBafvJEefHyK/hbHSFFxLOmd4mzTIRjWznPM6R6QX2xz9XU7UJG8vG07adsUByPsuZqKxsNbRbZbCbC/uz93eSsBVzSnWE0MOYWV2geDT2WTsHT0RAUuqYhAepFlNrF2GHWCOrgkmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CHCLINod; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7kQV22876386;
	Wed, 10 Jun 2026 04:55:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
	yUT73V4Fzc+3j+GPiArsJ6IP4UTuHyiOYk+puPGBbQ=; b=CHCLINodVL0Ds8A89
	FihfzIwLyryIuWCLAzrlYFBdFO/ZebEQfOJy2xvwVRE/KqLvYK6O26HX2NNaY49c
	QDwgYsB4tLZh9JLgSG47FAKvKsRD+FE8xDWyvDWpGSRPiE5OnOz3V8nGP3BPiIYk
	IVGVXgkU4MBw1lbVGv3CSYPzLler+CtF4aUScl3yv5LaKnYKAP9ScL+viobuvzQj
	vXVX4P/d2U2dWvsbRwUwh9ZomHeActO8xIfDqIXhjQ31QAwg55ip9WiPosA2ks3s
	W6eV32E7IFJPehHs0q7ErPTmsL6BJLCQymixC1MM9+Vvq66Jvc5HEEs8qcn/S0mp
	I4Mzg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eps392u4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 04:55:13 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 10 Jun 2026 04:55:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 10 Jun 2026 04:55:12 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.66.228])
	by maili.marvell.com (Postfix) with ESMTP id 8B6EC3F708D;
	Wed, 10 Jun 2026 04:55:08 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v5 3/12] net: atlantic: decouple aq_set_data_fl3l4() from driver internals
Date: Wed, 10 Jun 2026 17:24:39 +0530
Message-ID: <20260610115448.272-4-sukhdeeps@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=KKlqylFo c=1 sm=1 tr=0 ts=6a2950a1 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=OqYplCa96tyeLioHD84A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: RyQO38b-8wwJduLC-XV5wdgAr2OMwHd8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDExMiBTYWx0ZWRfX+SRBatFgj6xq
 WygmKFC7Z7vKVkCeHMHlZhz8XfJn83Qv9vCH0aZjctQg4rwYA4gQA1eEA4/Jdb9YPDpS70w9nvE
 hc/DZz8AkvtcLcJR5dRYuntpLKxnnD8LzjjCPxfDH+sVHhkRxObh+izcW1pQ/ctUkiIRt2Fg7vX
 fIrqcWSDP+reBvcReJzAHCbomqP6Je6uUeXDjXadSZ29iH/fyXbll7HXBYO2y2LJacMIwSasxR/
 NsrXSwuNW+NFqZJQedc8URd8S6+GzD97rbhhYzYM+kwSHStdRJr4MzvHPoEbxIDOSDv34DdrqwP
 wRRPwGXUNRW0GuNAWLgF5dWcMNUOzjNJ+/JmdGtmrODEH4gn/4BqFYcHi7oTMwhFPbssWDxb9yr
 93G1c+Gd153V3ReVoHPlkpPzzoSp0GSq+2T2Jez4Bbeg9v1QaEOG/OAFVdNnkQfP9bXzRUKP7hm
 Hpa9/PpE26zzVoccHbw==
X-Proofpoint-GUID: RyQO38b-8wwJduLC-XV5wdgAr2OMwHd8
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297642-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:sukhdeeps@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5027F66903B

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


