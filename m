Return-Path: <netdev+bounces-285775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GEmDFrR/Wl2jgAAu9opvQ
	(envelope-from <netdev+bounces-285775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:04:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0EE4F6134
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0076730086D6
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDCA3D4100;
	Fri,  8 May 2026 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QgJKW0dU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705DA395254;
	Fri,  8 May 2026 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241823; cv=none; b=UwZH5lwIeUf2c9oQe88q0uhDxNRuvX0c21N4X2IWOy3aW9pGiEJKhhFUYdgSxgvIpp8WQVNXsbp259ai3N2md0F6Ebo9c7jD0WXfgZELIt1l+bzjnDBHt6H7ySq5umFSeysuc+2nIla1V4WKaIEZK8PLjLsJ16LCmFwDkOqHh14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241823; c=relaxed/simple;
	bh=uxNVsaRzOnFejNmiIUX3HPDYNqZFdOMxWonxL2AMPHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2TaXkDP4wm9IgAeOe2qU2HHltDv+Lj0AqLjkUu9ANib5PbAOqWw3RIcGrj3ShlNEiFBFbQbu28cA062ZSBeo6Jt2lS9cUb3K36vsCeSLib1NvPhISIZMTeBp2mErAznPaeOVPessh9JZU4D2wZftFTESEEQqSYRlwtlTGGIvcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QgJKW0dU; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6484mfZd3918198;
	Fri, 8 May 2026 05:03:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=U
	kbjYwFqoIN5M0l98GWm6jC17NSot+pUpVu2G13nNj0=; b=QgJKW0dUh7UZQMJ8h
	wgrTHjbWvm0QefQKZ+dfqD1MWas6rmvVcdP8/tsbkhRJpngQ5bLsXLaHCHJNJIKz
	a/DdrrpPLxTE8UJLt0Jh5i2BNrBXZ+W7VGQEJSBG6byc5x5bqRtqGSY9h9ba3tTk
	cVpA0DsB1UxSDErFO7+vOyZB65q45B/RVifZ8DU2OlTX4m1U+W0SFDjU5cjJ44T7
	YadQZTvqa5dutt+iVJZxCoyH3MMpfoFrv+L032QOO/hV18sdasn7HfRVbnlja7In
	yxBIVB4OiB2poH9yaLXYwgpcj1pNfORTUdTSAPGSu1baFZJo/GuOJbPNcPkLSqjC
	JC75w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e093sxbpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 05:03:12 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 8 May 2026 05:03:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 8 May 2026 05:03:11 -0700
Received: from BG-LT92649.marvell.com (BG-LT92649.marvell.com [10.28.166.218])
	by maili.marvell.com (Postfix) with ESMTP id C56F63F706D;
	Fri,  8 May 2026 05:03:06 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <irusskikh@marvell.com>, <epomozov@marvell.com>,
        <richardcochran@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <vadim.fedorenko@linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v2 1/9] net: atlantic: correct L3L4 filter flow_type masking and IPv6 handling masking and IPv6 handling
Date: Fri, 8 May 2026 17:31:48 +0530
Message-ID: <20260508120156.3060-2-sukhdeeps@marvell.com>
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
X-Proofpoint-ORIG-GUID: vKBi4YCZKzowzZqW1f8iMWFXj9p1qVaW
X-Proofpoint-GUID: vKBi4YCZKzowzZqW1f8iMWFXj9p1qVaW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyNSBTYWx0ZWRfX4iikq9MMgtSW
 JoQUtw+k9IsKp0QcCv1qCAq4+7OApR7TvufqdV0ZQiLHpkfzD33MWe0zpiqSejm0yV58WjQTOHz
 NUPDgtiRmFHOJjqh8/ooLbGVKe8bsLzix/8+0WsnNIWv0DBoxImeTIWtoijQebkAELqaDuh+qol
 1Abw3BXTLsvoLks6WIb6sthdOIp3lCMy0UHG/uX2Oo9UDiXmjel0qj+I3e5JB0eE9VkQt994b07
 ZkIeGjKoBe1S+VlrJv2dt35BjJ+52hulyZNKxelarEwU9UcdL18k4gtzyqOpSgb1PXH+PCYNPso
 tzPsEKBln+pExEG8W1EPSxLMyKmUGiUbpI5y0TrNlJm+XHEf+i+CRgIHycpNn8PacncoJTFuKKp
 9dnftFE/u73Z2T/xa/35YL5FXzv6eUUmC9CrzTCqQRChbAWAsyEUAvbJHA7e6FSMsNHo2qJqN6u
 RsihSx/mByPF3U5j3gQ==
X-Authority-Analysis: v=2.4 cv=WZ48rUhX c=1 sm=1 tr=0 ts=69fdd100 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=7-RSyJf46AiWYYgqFwsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Rspamd-Queue-Id: AF0EE4F6134
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-285775-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

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


