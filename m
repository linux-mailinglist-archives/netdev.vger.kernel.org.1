Return-Path: <netdev+bounces-284852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBu+DzBJ+2lZYwMAu9opvQ
	(envelope-from <netdev+bounces-284852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:59:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EADFF4DB83C
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42AD8301E4B9
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 13:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4941D47F2FA;
	Wed,  6 May 2026 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EKRKWFve"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AFD48032D;
	Wed,  6 May 2026 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075916; cv=none; b=TYsqCD4pJ7Sf0M52fKBoykP7s4Zac/MCYw7WE1/436o1H4CVNBghIhVfeJuScA2pRrKVmckGCDa2EhGXhS6IzPCDJRldkO5D06IA2MfB7RRC09bqAEmj9Uob/mIRS8LaCK6KsPHTJoU0owQz81UD0cVQOYErxUg9+ZY5WxeeQRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075916; c=relaxed/simple;
	bh=PXZjf0Yrl8AcSiqV4M8X8mu7WkwSWrfLyYegGwSDDo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDh/MDNu7zUXINXixJ+1awFW3ik2gCXYWKYoJizIjp9b2VzCDWBowIdXypixf73j0phI5uktRd+5+pEzNcbRlc80YFxY1YPbuj59rt8Y7/0uKgwDQjsx4nUIlj6SYlOzTwS5AlcNn/ec5aWdaLbB9bP417cT10qSDDz5ubrXxcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EKRKWFve; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646APXAu2226342;
	Wed, 6 May 2026 06:58:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
	yUT73V4Fzc+3j+GPiArsJ6IP4UTuHyiOYk+puPGBbQ=; b=EKRKWFveg/Ee+vcc1
	6/mbX5LyyAAKQhd7hg1O/6lyZBWe2RfDh35TE+KA9B/Hea8a0WJEjQ8rx/D4e08b
	y2Kxgaz6cGBNLCVBiHqxjjVhtwBKGXCTBEO55CjBpplalUu1F16szCAtLGbmaQnJ
	Xgqt8Q4TipkrSAu2OK4nTCozGZUjpjNs2Ny782oW5T8JAGu23duT0CxBRopUpVSx
	c7VBxqfaFvqNib+1K65stmOv3sp3e6kRoRQkRDQBHIyB9Qjfk/gHO4zx2GO/gUt/
	V6vpzanXbFMxVUPj/ccwkqw9qXkfTADG4z2QW2nlTFuZn3bi9RxbQy4RsiSNxXhB
	RN2NQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dyupyt086-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 06:58:25 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 6 May 2026 06:58:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 6 May 2026 06:58:24 -0700
Received: from BG-LT92649.marvell.com (BG-LT92649.marvell.com [10.28.166.218])
	by maili.marvell.com (Postfix) with ESMTP id 69C183F7092;
	Wed,  6 May 2026 06:58:20 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <irusskikh@marvell.com>, <epomozov@marvell.com>,
        <richardcochran@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        Sukhdeep Singh <sukhdeeps@marvell.com>
Subject: [PATCH net-next 3/9] net: atlantic: decouple aq_set_data_fl3l4() from driver internals driver internals
Date: Wed, 6 May 2026 19:27:00 +0530
Message-ID: <20260506135706.2834-4-sukhdeeps@marvell.com>
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
X-Proofpoint-GUID: vZGQrxpHQBGwCeNkCtGo7AphHfKaFMBp
X-Proofpoint-ORIG-GUID: vZGQrxpHQBGwCeNkCtGo7AphHfKaFMBp
X-Authority-Analysis: v=2.4 cv=BoOtB4X5 c=1 sm=1 tr=0 ts=69fb4901 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=OqYplCa96tyeLioHD84A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzNyBTYWx0ZWRfX37e6XmuRzgrg
 DgZ/ypswdPwVwIJRRT2QRRVYkOBATdNSDhCRh5pFZ4FGrCkiFwj3CtOLklBjC1RaTmDmrHpOlcU
 XL66EB8DCrA0UtPp6OHXwr6buu9Ih5ozOKrjaaZUFHyjJNcDH5O9Qac7UKXDIHlSjKbP54Zd3z5
 isrskyOAxIIU7ZwqxdA2x63y3WLo3HlbVmN81BaSadSLnhczKN5Jv0Av/e4E3IZRJ+0ep7eMTgt
 3RBETvCgieccTtdR76dTYmSEO/yYVA8qachFxEclpZNv9i+YTwwd77HmTEh9MezHm6vT43AsqJe
 SOQbf2JmQoxq1JGYnZMxZF7RPjpkAzim2MjGp+Q1cYimdOSJIEpC7VWo21GLs1HBd8ahTLh7bBV
 fisohFvv5mNlrqwl7hN+hBVXjkFTjCL2bjIWAj94sESxZVyPsVYz7P+pLZflPN/okD5CGapYowq
 3jyLw22dtCYtAbd2Oxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Rspamd-Queue-Id: EADFF4DB83C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284852-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

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


