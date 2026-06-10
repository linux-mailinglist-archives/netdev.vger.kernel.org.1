Return-Path: <netdev+bounces-297643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Oj4OLZZRKWpUUwMAu9opvQ
	(envelope-from <netdev+bounces-297643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:59:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5216669048
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:59:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=WsNPeczg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297643-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297643-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20D79301E6E3
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F36F4028E8;
	Wed, 10 Jun 2026 11:55:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB02D404BEB;
	Wed, 10 Jun 2026 11:55:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092528; cv=none; b=L0Y1JWjDU5zF0P/xs4SX1uZOxtYeT0t58PBSr8Sv55ZGm3EUKYuQJ0wlU7xe1SiuVYt0x2mThWhv+/SDwwQgZoKEYM+iaf5Tv0I5z/+jmV7NjXwKyM0ZYKfZ93I2JM1KAjKqqplmLFqPjEYNJRoMsj6DQsP+BnXGGq1asDDMSqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092528; c=relaxed/simple;
	bh=uxNVsaRzOnFejNmiIUX3HPDYNqZFdOMxWonxL2AMPHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghi+jyXpblRqni3XaKYr1zuJPxjEKAvuqr7+/qFM4t+JXTWA5ywNLBIoUulpf52nAi1QivUKyTjypbwtm2mylJYcBeBRHmHKzMUg192GLRh1PRNwPtDG6SGmdixN5Wc4A1J98hvDjDRnte9ItR0u3fPEvDfpwJjjKQFhXEwZ82c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WsNPeczg; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7knLv2879058;
	Wed, 10 Jun 2026 04:55:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=U
	kbjYwFqoIN5M0l98GWm6jC17NSot+pUpVu2G13nNj0=; b=WsNPeczgJdG/PoC87
	z39tCft4JxqAsl07qMMu3aG+W3aat4k1QatN67bx0wL55QRQYQutRB4wHBNsgxyK
	B5ntAF6mPNFXBE+4WX0vfWabB6ehZg3v89BMJNQBMQA7Rxtpv7c4IoytzyZjS4LE
	GrJvqXpTMrsv4MxQV0ffC6uL4YzlYcMZVH55AgRo8t4STyv2effNh1EsenhPnitU
	BLx1m763tsYmaqPTOpPUBnur/r8BrvN43oua5F7AISzRU3uqghPXrqNpvUuao064
	mfvHifiiCfoFUjTo6BxrUQuTIMiFw5SGHHcIMoL9Ff0Atlx0Yr0Typ+k+UercADI
	ivLxg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eps392u3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 04:55:04 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 10 Jun 2026 04:55:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 10 Jun 2026 04:55:02 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.66.228])
	by maili.marvell.com (Postfix) with ESMTP id 8C9813F7090;
	Wed, 10 Jun 2026 04:54:58 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v5 1/12] net: atlantic: correct L3L4 filter flow_type masking and IPv6 handling
Date: Wed, 10 Jun 2026 17:24:37 +0530
Message-ID: <20260610115448.272-2-sukhdeeps@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=KKlqylFo c=1 sm=1 tr=0 ts=6a295098 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=7-RSyJf46AiWYYgqFwsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Ia-iIVKkB8z2IgDbFzLlQ_ru1rXNOQJP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDExMiBTYWx0ZWRfXwlLzCzAYmqHX
 JvnzEwHPklPLbAY8fiaI1ncijmR7I1Dp6DDdvm+4qCOpCLmT+eP6OLY/k/YbVEHWlNNiDsE6aO1
 rlqgf0w5+opb68AMAqBSyUGkn6UpkKtfWaEiWCaWTG0hLTik68RTgGaZxFxNdNzyAkjajZlzkBs
 H7hTdnEHnNtkf7+sq29GORdRpeeg8ztZdBpIidi3YgVTMWSH/QYK7zULTY0MaBYegxrzrXCmNyw
 ef4QLsO45a93H3OG2JH1Vm7Amw1VpsMI5fyPSsdkl01GLFWQqtaxbTCjx5UlKX+T00fYh7w4dHH
 KTfbdrqEqvqb/KK3w9FAIbR2skw7sAT2fR6U9syEPFMU9FBZvGFofThnRK1S+y3UZbyrgg0Cc1y
 EL0UtHvdUDNxoyf8/fPpegsVbZ9Oa8P0HCd240iupLXIyzil52mSazto7ezFu+IhvF8N/nq+kIg
 C8+i6murjm3lExhznkw==
X-Proofpoint-GUID: Ia-iIVKkB8z2IgDbFzLlQ_ru1rXNOQJP
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297643-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: B5216669048

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


