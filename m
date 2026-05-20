Return-Path: <netdev+bounces-289961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qChIAArEDWql3AUAu9opvQ
	(envelope-from <netdev+bounces-289961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:24:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDB858F859
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CDD7B305D507
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA2B3EA942;
	Wed, 20 May 2026 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Vr6T362E"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC153E8C4C;
	Wed, 20 May 2026 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286331; cv=none; b=DfOoinpSXK5ckKkgdufJ72kb+ni4jR4F05n3hdqKMcZOEO1utdXe1J8VYt13Jrt4klmc3tVEpoAPewZ7PW2U+ILhnYQ5tMCARwcaZc2YV7+fiTEs5d2GRy6w+prB5Uc+WDvfrMYl+HfZAeHyYV5IYNdQQncQzpu+ZCxaHVNBeK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286331; c=relaxed/simple;
	bh=PXZjf0Yrl8AcSiqV4M8X8mu7WkwSWrfLyYegGwSDDo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCmSi25wORems3gdZV5OnMVTxu8K+5YNNZAMkWcd9HRdYemDJQ9LvLogUnxNClktBN2dNfv+0ISGJroXCL9KaBvsyNixNVgUcFO6PuHsOKvRIZHp4VC+3UReejV31/HUu3fiT0D1uaqaGEoRqL8sp6kiqthxqoaAgKrI+oEnzfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Vr6T362E; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KDUext3009289;
	Wed, 20 May 2026 07:11:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
	yUT73V4Fzc+3j+GPiArsJ6IP4UTuHyiOYk+puPGBbQ=; b=Vr6T362ES8hhl8hwL
	otENzW9oK86+s14KqeJ5OSvzwgZzyyP8QWgxDkvZ3hr6wu+aj7OWdwcM4kdr3gHJ
	79F3nyGadxVj7m81U/4fV66S6e3UosRZe8vrFXDbBk7qok7YpnsV9xZL9vl+SulQ
	bkhSg7pBFg4xco8UcvwYsS/vya1tyWCvQVyvoIHN9K7SYShkHBIlr4IsDVWcClRU
	tu2O+8RmqNp6b82BNmekoNpyddiuw0v3Onk2EeID+xhGhWp3U2KuadsinIuqPpe1
	VOF2udcGtJ4zAXKKqDWvluoblgtrfqBdnYrj3O9akz3x0YTLefHODEr7YnHB/dpE
	Vn1jQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e8jywd2ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 07:11:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 May 2026 07:11:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 May 2026 07:11:38 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.74.182])
	by maili.marvell.com (Postfix) with ESMTP id 001FD5B693E;
	Wed, 20 May 2026 07:11:31 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v3 3/12] net: atlantic: decouple aq_set_data_fl3l4() from driver internals
Date: Wed, 20 May 2026 19:40:36 +0530
Message-ID: <20260520141046.2151-4-sukhdeeps@marvell.com>
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
X-Proofpoint-GUID: Tn4rfJCGUhKF1niuGpNoG7EKFrA8GeP5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzOCBTYWx0ZWRfXw1DoMFzCn327
 xojgBgcG2BR8Q7amxoxglrOizCFrCWXQKgy3RTrrTOCMvSKrpAn1bqC6ZlZHb/GHrZg93NkV446
 8Xqf4e6wSz4KFLa7HDdIVKuFFIAakg5frthoTPgTbutkk1Y9h37AAntKpqEltq5dUd5nra1dyZ7
 MAcRAFTuN1Urs1e8ZimHP/iP3CYk+t88GQntD8VSARjCV+bda35tB+gdRyaYBJgUksfhhpxxv4r
 mn8r0U+9DVvqWH2QcWxVugETvbWY67GDMUsVH0QhaMKdz/bTZK/+1toNA1yWmoTQpLC7DEV7Fn+
 xU22pRKC/CFcZtj1euhCabVJhaZSn4O4aWduynCAV37z7qPie1HBHflfGIg6u1aQ1RxRSzOwoyr
 ISwAFDpBwCrJlxgNhRhsWIeApezqA5SA81caYrP+adNIVNCA9irbvGw4aX4t7ODr3xoY8GeGpw+
 +KR6fs5niUOx1NJEFEA==
X-Proofpoint-ORIG-GUID: Tn4rfJCGUhKF1niuGpNoG7EKFrA8GeP5
X-Authority-Analysis: v=2.4 cv=QbNWeMbv c=1 sm=1 tr=0 ts=6a0dc11b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=OqYplCa96tyeLioHD84A:9
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289961-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 1EDB858F859
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


