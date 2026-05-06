Return-Path: <netdev+bounces-284850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGx/L35K+2nWYwMAu9opvQ
	(envelope-from <netdev+bounces-284850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:04:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DB74DBA28
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A64A53020D6D
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 13:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B057747ECDE;
	Wed,  6 May 2026 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VZZR8oFG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B9F47B41D;
	Wed,  6 May 2026 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075901; cv=none; b=oES4Jp5yzfB6GMMsHtPXcN+pYwnTC6SdvtEcvsh2PrxaeUfshVej0QlAvkJEm4S7dCuBQ2xslTwVbtt0XnIVQJNpxMUBu3ZPf92pj4rZ7ITxE2rBFUKOGkiGtUNH6oKx1zYNA6JRpVimN45CIq7E7MEhwNmzYCFvo8asjr6sU94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075901; c=relaxed/simple;
	bh=uxNVsaRzOnFejNmiIUX3HPDYNqZFdOMxWonxL2AMPHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfyvEWXGtpB6ttOqaabAR+yGz6wcloRRs+/NJsHSq1hzWEWbjReylEwjfWSZgLsYejYonZkbsRBqMC02ChwPuqVNKstplc/aZhxshTEJqAXrmTbMUXZ9EhAvAWrZiIbcmL6SIU+Hkt5+bK2qpmviuvFrBkj5vZc3eAFlbW+TGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VZZR8oFG; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646AIIZp2226351;
	Wed, 6 May 2026 06:58:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=U
	kbjYwFqoIN5M0l98GWm6jC17NSot+pUpVu2G13nNj0=; b=VZZR8oFGHzF5w/DJm
	P5Gz/KV15NW/xaaujLJRWiSVv6E30BbFWc+D2BVYg6YlZqSlRQyVAw6NKv9jNYeT
	akpCNLxszT3IqU1xRiSZkZ7nRdkOShecssfdQEHBauDz50TJ9bC67WYgapLC3M1e
	UMheHNLvftnKHJ2nuF7Eagsc2ekDotiuQ014kUGwlbtOvjlD+PoLzQsZeHF8TQk3
	Qmq89+BT1f1HjYXp5fzzlQqZplAMFe/71Xi6pf9GYROmp1siH39GoRS3pnTxb+uY
	QMBKWHCKOXsmuZcGUH5RDkTogJKAcE2rnRQThmWmKnhxpnTPMBCkJFz/VcsmP4Mm
	lJGPA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dyupyt07r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 06:58:10 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 6 May 2026 06:58:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 6 May 2026 06:58:09 -0700
Received: from BG-LT92649.marvell.com (BG-LT92649.marvell.com [10.28.166.218])
	by maili.marvell.com (Postfix) with ESMTP id 2D1273F708A;
	Wed,  6 May 2026 06:58:04 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <irusskikh@marvell.com>, <epomozov@marvell.com>,
        <richardcochran@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        Sukhdeep Singh <sukhdeeps@marvell.com>
Subject: [PATCH net-next 1/9] net: atlantic: correct L3L4 filter flow_type masking and IPv6 handling masking and IPv6 handling
Date: Wed, 6 May 2026 19:26:58 +0530
Message-ID: <20260506135706.2834-2-sukhdeeps@marvell.com>
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
X-Proofpoint-GUID: NIR2WLP5YRrhGdGHg6zYDtKPipoi3wZJ
X-Proofpoint-ORIG-GUID: NIR2WLP5YRrhGdGHg6zYDtKPipoi3wZJ
X-Authority-Analysis: v=2.4 cv=BoOtB4X5 c=1 sm=1 tr=0 ts=69fb48f2 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=7-RSyJf46AiWYYgqFwsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzNyBTYWx0ZWRfX+n8L3J2EX5zQ
 QcjBp1D4y4NUXV3Ct25Hh53KcIjNIQ8D5roJr1y08FzxjE148AwVKj8/tcfK+z7IBfz0piuW3mE
 u2XptHXY3gIlrmakjr5JqV3QYWZYHfhdkDdQ82bky29hvLs3QukaFCRqis6bqwm9ccQDBKQIFu0
 2VI9EVqBw/FQYy85C5LbCnv51l2TXsu1WV107Hq+clW1r2vmwyIabRpM/W5/WLepmWdzlafdArQ
 CAXW/85mXQJbPLOPeqaZ/JI7EwzA9GJyVKusT6Wzp2gbQs4jN3lhQCwLDld3Wc8uE2Q254UIWQl
 YmHVelzLtQQwyDiRE4uVE5h5TgfLSGQP8FOdZ4X2vc71GbY1kY28WCZYDbFD2xilOiXpY2voEpR
 a7rLKl6Giinf+vpkObhIo7xgdnKzMxbjTnjwAFbNSwpXhNgEx6Xq9bi/nLEXiMY5l1WF/Bj7Mqm
 cxFohtO/IHqzsVjtdaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Rspamd-Queue-Id: 20DB74DBA28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284850-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

From: Sukhdeep Singh <sukhdeeps@marvell.com>

Correct three issues in aq_set_data_fl3l4() required for the AQC113
PTP filter path introduced later in this series:

1. Mask FLOW_EXT from flow_type before the protocol switch statement.
   Flow types with FLOW_EXT set (e.g. TCP_V4_FLOW | FLOW_EXT) fall
   through to the default case and skip protocol comparison flags.

2. Extend the L3 address comparison check to cover all four IPv6
   words. The original code only checked ip_src[0]/ip_dst[0] and
   required !is_ipv6, so CMP_SRC_ADDR_L3/CMP_DEST_ADDR_L3 were never
   set for IPv6 filters.

3. Use explicit flow type checks for port extraction instead of
   negating IP_USER_FLOW/IPV6_USER_FLOW. The old check did not mask
   FLOW_EXT, so IP_USER_FLOW | FLOW_EXT would incorrectly attempt
   port extraction. Use the actual flow type to pick the correct
   union member directly.

Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
---
 .../ethernet/aquantia/atlantic/aq_filters.c   | 33 ++++++++++---------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_filters.c b/drivers/net/ethernet/aquantia/atlantic/aq_filters.c
index e419c73b32ce..eef52f23166d 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_filters.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_filters.c
@@ -472,6 +472,7 @@ static int aq_set_data_fl3l4(struct aq_nic_s *aq_nic,
 {
 	struct aq_hw_rx_fltrs_s *rx_fltrs = aq_get_hw_rx_fltrs(aq_nic);
 	const struct ethtool_rx_flow_spec *fsp = &aq_rx_fltr->aq_fsp;
+	u32 flow = fsp->flow_type & ~FLOW_EXT;
 
 	memset(data, 0, sizeof(*data));
 
@@ -490,7 +491,7 @@ static int aq_set_data_fl3l4(struct aq_nic_s *aq_nic,
 
 	data->cmd |= HW_ATL_RX_ENABLE_FLTR_L3L4;
 
-	switch (fsp->flow_type) {
+	switch (flow) {
 	case TCP_V4_FLOW:
 	case TCP_V6_FLOW:
 		data->cmd |= HW_ATL_RX_ENABLE_CMP_PROT_L4;
@@ -527,23 +528,23 @@ static int aq_set_data_fl3l4(struct aq_nic_s *aq_nic,
 		}
 		data->cmd |= HW_ATL_RX_ENABLE_L3_IPV6;
 	}
-	if (fsp->flow_type != IP_USER_FLOW &&
-	    fsp->flow_type != IPV6_USER_FLOW) {
-		if (!data->is_ipv6) {
-			data->p_dst =
-				ntohs(fsp->h_u.tcp_ip4_spec.pdst);
-			data->p_src =
-				ntohs(fsp->h_u.tcp_ip4_spec.psrc);
-		} else {
-			data->p_dst =
-				ntohs(fsp->h_u.tcp_ip6_spec.pdst);
-			data->p_src =
-				ntohs(fsp->h_u.tcp_ip6_spec.psrc);
-		}
+	if (flow == TCP_V4_FLOW || flow == UDP_V4_FLOW ||
+	    flow == SCTP_V4_FLOW) {
+		data->p_dst = ntohs(fsp->h_u.tcp_ip4_spec.pdst);
+		data->p_src = ntohs(fsp->h_u.tcp_ip4_spec.psrc);
+	}
+	if (flow == TCP_V6_FLOW || flow == UDP_V6_FLOW ||
+	    flow == SCTP_V6_FLOW) {
+		data->p_dst = ntohs(fsp->h_u.tcp_ip6_spec.pdst);
+		data->p_src = ntohs(fsp->h_u.tcp_ip6_spec.psrc);
 	}
-	if (data->ip_src[0] && !data->is_ipv6)
+	if (data->ip_src[0] ||
+	    (data->is_ipv6 && (data->ip_src[1] || data->ip_src[2] ||
+			       data->ip_src[3])))
 		data->cmd |= HW_ATL_RX_ENABLE_CMP_SRC_ADDR_L3;
-	if (data->ip_dst[0] && !data->is_ipv6)
+	if (data->ip_dst[0] ||
+	    (data->is_ipv6 && (data->ip_dst[1] || data->ip_dst[2] ||
+			       data->ip_dst[3])))
 		data->cmd |= HW_ATL_RX_ENABLE_CMP_DEST_ADDR_L3;
 	if (data->p_dst)
 		data->cmd |= HW_ATL_RX_ENABLE_CMP_DEST_PORT_L4;
-- 
2.43.0


