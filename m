Return-Path: <netdev+bounces-289958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F3vBEXFDWql3AUAu9opvQ
	(envelope-from <netdev+bounces-289958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:29:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEC758FA1F
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B99E3007367
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8033E7BA9;
	Wed, 20 May 2026 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aGyfOW4/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F63C3E7BC6;
	Wed, 20 May 2026 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286319; cv=none; b=kqi8QCa1ZOqrwdm2Sm5uTiTuG3Of/q+GTCphe3O8NnfbmqxKSX23p+pcpRZFO3PFNTx0Yf9q5AojG3webgqfd/yMk7DVOv6CEWUlTECNW3xII/UYOM4ImJ1K3pX7dOoUlP4K7/8+yIxAVHNWp3hTzmG6u2f84xYYw4B5tq/RL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286319; c=relaxed/simple;
	bh=2Fr9Gu0QhvY6MDVRVAgKv/0duU0nkIHHf6ZVRHEl0uo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ifcm9nvWB3KPRDvEXlqep8zfGb774FqQEkrtsIDLsxzK9dOnc+H97yWK5H62YM7A7g8XV1YgUDUU4LL3jlnU1oNDJHSfyYTS3gKw3bNSW1CZ6wgP4mFAuiE2P0W0LTCb0Q3ZqQRBa0glyboMd+UeSUVJW9SgPcBJA5vMwBwADcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aGyfOW4/; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K7R74c2110606;
	Wed, 20 May 2026 07:11:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
	SiNo6cLEgdJcx41UZzvbJ/IRtyosImtXdb7vMBXhtk=; b=aGyfOW4/wUTdxt+LM
	9jmUoEL1gOcGoGCIoqak5jobwaKfH444NR8YOsxj7YGaMGmgPZWJh61YaHwu2dKp
	ppV6BM5D0JkshvzwMC6hwgXE7Z4fz3eHUq6S8GiNpd08nFrzLRdsW/4qv7qfyzDW
	L16+gsdVSH1XqjmtqPHkbfoRYEaEGgYkWau7g5Q6gaKi7EeEVj0OGoAVMHsA2rt2
	sGO/6CiF2Z51WsirBZJ+Mwy1rfCrV3YOgYfn+BLNmnkYB2rvQuN6HaWog8AyHirS
	OlOHjAxNhuHC949wOIMOwATi0efAufMQGTHZJ/jtqCaACQfCGzxlrfzvTYZs/GqZ
	xBFXA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e8cfmdvf4-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 07:11:31 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 May 2026 07:11:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 May 2026 07:11:30 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.74.182])
	by maili.marvell.com (Postfix) with ESMTP id 678945B693E;
	Wed, 20 May 2026 07:11:24 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v3 2/12] net: atlantic: move active_ipv4/ipv6 bitmap updates after HW write
Date: Wed, 20 May 2026 19:40:35 +0530
Message-ID: <20260520141046.2151-3-sukhdeeps@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=JYuMa0KV c=1 sm=1 tr=0 ts=6a0dc113 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=KHjEQNYavMDKLc9vdDMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: iMOwT8RkBtXsrIxdSAHlllUankk7PqXU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzOCBTYWx0ZWRfX7lqf8yhuNzHi
 0NmInZ1G8qyrhXL8WYdePAsb8Lo1k0e0aXu4Hwqw2NobCjZLnsTRHdjknx5zfOoq44BrWv3FpHy
 3vAamtJt/K4Z+A0pXu5FANWOtQHysmFHv2qrblvrjmorIercUr6CfVDy7Qc1H8wGnoVyk3IQYhX
 W8xbpS/HdHPtPGG+5Fc0pwNeVVsX3+FXQkgj+h1Nn8ZAJkEqV0jZ8A9+Ye4P61FSv3/H9UiiBPq
 Kft1BZRzMu07QGibzc8SmXl3D6imOJ2EptIIvquNDwHcV4QsBE4z9aqWznYIAc58t8kTQhzKell
 v6JScxlJ0sAducFGWKp2eWtuVcyTyCyPSb3AoN7yrjlhOwLRPfoe5R6dwCv6Kw/oNWozj3f8uUo
 6HdAaKNGmrU2IOTes+bSgud54HHS58MrJe3xZlRFT8McXrzBT/PJJAz+Q+1MAuL3KzAgo6DqRXU
 YynV44wIxOFMglYkghQ==
X-Proofpoint-GUID: iMOwT8RkBtXsrIxdSAHlllUankk7PqXU
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289958-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,marvell.com:email,marvell.com:mid,marvell.com:dkim];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 7AEC758FA1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sukhdeep Singh <sukhdeeps@marvell.com>

Move active_ipv4/active_ipv6 bitmap updates from aq_set_data_fl3l4()
into aq_add_del_fl3l4() after the hardware write succeeds. The bitmaps
track which filter slots are actively programmed in hardware and must
only be updated once the HW write is confirmed.

The bitmap updates in aq_nic_reserve_filter() and aq_nic_release_filter()
are intentionally retained: they guard the aq_check_approve_fl3l4()
IPv4/IPv6 mixing validation for callers such as the AQC113 PTP path that
program filters directly via hw_atl2_new_fl3l4_configure() without going
through aq_add_del_fl3l4().

Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
---
 .../ethernet/aquantia/atlantic/aq_filters.c   | 36 ++++++++++++-------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_filters.c b/drivers/net/ethernet/aquantia/atlantic/aq_filters.c
index eef52f23166d..150a0b1af26a 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_filters.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_filters.c
@@ -479,15 +479,8 @@ static int aq_set_data_fl3l4(struct aq_nic_s *aq_nic,
 	data->is_ipv6 = rx_fltrs->fl3l4.is_ipv6;
 	data->location = HW_ATL_GET_REG_LOCATION_FL3L4(fsp->location);
 
-	if (!add) {
-		if (!data->is_ipv6)
-			rx_fltrs->fl3l4.active_ipv4 &= ~BIT(data->location);
-		else
-			rx_fltrs->fl3l4.active_ipv6 &=
-				~BIT((data->location) / 4);
-
+	if (!add)
 		return 0;
-	}
 
 	data->cmd |= HW_ATL_RX_ENABLE_FLTR_L3L4;
 
@@ -515,11 +508,9 @@ static int aq_set_data_fl3l4(struct aq_nic_s *aq_nic,
 			ntohl(fsp->h_u.tcp_ip4_spec.ip4src);
 		data->ip_dst[0] =
 			ntohl(fsp->h_u.tcp_ip4_spec.ip4dst);
-		rx_fltrs->fl3l4.active_ipv4 |= BIT(data->location);
 	} else {
 		int i;
 
-		rx_fltrs->fl3l4.active_ipv6 |= BIT((data->location) / 4);
 		for (i = 0; i < HW_ATL_RX_CNT_REG_ADDR_IPV6; ++i) {
 			data->ip_dst[i] =
 				ntohl(fsp->h_u.tcp_ip6_spec.ip6dst[i]);
@@ -574,16 +565,35 @@ static int aq_set_fl3l4(struct aq_hw_s *aq_hw,
 static int aq_add_del_fl3l4(struct aq_nic_s *aq_nic,
 			    struct aq_rx_filter *aq_rx_fltr, bool add)
 {
+	struct aq_hw_rx_fltrs_s *rx_fltrs = aq_get_hw_rx_fltrs(aq_nic);
 	const struct aq_hw_ops *aq_hw_ops = aq_nic->aq_hw_ops;
 	struct aq_hw_s *aq_hw = aq_nic->aq_hw;
 	struct aq_rx_filter_l3l4 data;
+	int err;
 
 	if (unlikely(aq_rx_fltr->aq_fsp.location < AQ_RX_FIRST_LOC_FL3L4 ||
-		     aq_rx_fltr->aq_fsp.location > AQ_RX_LAST_LOC_FL3L4  ||
-		     aq_set_data_fl3l4(aq_nic, aq_rx_fltr, &data, add)))
+		     aq_rx_fltr->aq_fsp.location > AQ_RX_LAST_LOC_FL3L4))
 		return -EINVAL;
 
-	return aq_set_fl3l4(aq_hw, aq_hw_ops, &data);
+	aq_set_data_fl3l4(aq_nic, aq_rx_fltr, &data, add);
+
+	err = aq_set_fl3l4(aq_hw, aq_hw_ops, &data);
+	if (err)
+		return err;
+
+	if (add) {
+		if (!data.is_ipv6)
+			rx_fltrs->fl3l4.active_ipv4 |= BIT(data.location);
+		else
+			rx_fltrs->fl3l4.active_ipv6 |= BIT(data.location / 4);
+	} else {
+		if (!data.is_ipv6)
+			rx_fltrs->fl3l4.active_ipv4 &= ~BIT(data.location);
+		else
+			rx_fltrs->fl3l4.active_ipv6 &= ~BIT(data.location / 4);
+	}
+
+	return 0;
 }
 
 static int aq_add_del_rule(struct aq_nic_s *aq_nic,
-- 
2.43.0


