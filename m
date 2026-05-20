Return-Path: <netdev+bounces-289959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJGFAmHFDWql3AUAu9opvQ
	(envelope-from <netdev+bounces-289959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:29:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B3358FA2E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAD8D302C0D6
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1403E867A;
	Wed, 20 May 2026 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MFGgKxOp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B653E7BDB;
	Wed, 20 May 2026 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286320; cv=none; b=tkOJuqFKHTjLVN3pRnvKu+S07LFU4VsoGa2fI1sfCoqWh64f3eb4ETsUCAxKqRt3t/fCwSuKNobP6VZG9sAjV2ahrw708O+didpyPH9SRyqkAvv6tXyOo8kfmqZnBTDm4XJFlhQiGrY1Decm9WVnFTj12fMzzi2t+RtZq7FqOOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286320; c=relaxed/simple;
	bh=uxNVsaRzOnFejNmiIUX3HPDYNqZFdOMxWonxL2AMPHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWazo+CMWeaSUhwo27w9ZIX38iMZ09YqMaBWbizSmtAymHhzLDAu8MU6MFl82hB1I8umb/3Myf0E6C5owlu5m7igvLEStp4QvE8rvV13GZcRUK+DYEO7+Ka24sVcXF6mR322UDJ9nRPdSYHdhDwby9QQVTZakpJzabB5h5WuUPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MFGgKxOp; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K3ZUv1243525;
	Wed, 20 May 2026 07:11:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=U
	kbjYwFqoIN5M0l98GWm6jC17NSot+pUpVu2G13nNj0=; b=MFGgKxOplubnIQRHW
	QJsTKdjeOV2TV8HqzxQryxwq0p1GSsUf6JJX3tH9cpLwYui7TEx0b4SeY1eOKGfY
	ra93gwxlVAkPfUHzvPre00mpXPvSnGMPeSZcK2A6hXf/om5RYa4FnFfjQc4APhRj
	McEHWCmBf+tXom8wew5vK0fQRnOYS/b1H14dptMKEsvEYnopB1U0Pp4T27MRqw5l
	Jau9u9enRLahEyPdX/TfFsk1MoMEpWYXwfA53MF6OVUb2KgprKrA6DzyDMDKg6Vv
	XzGcDRoFlZBT3uRvyvH0o6nPw+QoTmMrnXQkSg2oE7O+gkJikLAuNmcsFwNplRLh
	BhOfQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e8k5rmx3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 07:11:22 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 May 2026 07:11:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 May 2026 07:11:22 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.74.182])
	by maili.marvell.com (Postfix) with ESMTP id A08315B693E;
	Wed, 20 May 2026 07:11:16 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v3 1/12] net: atlantic: correct L3L4 filter flow_type masking and IPv6 handling
Date: Wed, 20 May 2026 19:40:34 +0530
Message-ID: <20260520141046.2151-2-sukhdeeps@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=Ka7idwYD c=1 sm=1 tr=0 ts=6a0dc10a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=7-RSyJf46AiWYYgqFwsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzOCBTYWx0ZWRfX0Ejko4RdR8SN
 HQwxuBoO6P1n5Z0PvvYsi6Kp52Gph3ulvBaPaw3oLAaFB+og0hjuCM8lfa7ubKxitPjP8ko25FE
 6I4koiYUkoPB6Q13pe9lN8bvbeOjK3g+b9S84d5CwfUWQHywghXxEDA+IF/vuibg9I7D5Z2ttZp
 P/m5K2gk8IcuOysha6uc8tP0L/0oA4OASCU48O15CMp7IPqMKkTNF0bZe/N3GrijTM1wsQgv8bZ
 ZdV0vPfyA5hYT+6w4m+iRcnIqd4X6uL9I/NPkFRjKyEZV4doHtrVRMWmcpViiYrDgzc4r7Ycp0b
 QfwG1HCWAFy+rw4EjJtfTXnGOQjxAAXx0SGc48wyKfuYXsJpBCXfry+ad4R7HQ1EN3pZfeASLcI
 Tsj++dThxX7Th66QD7lApfHXOe9ouCbzAhDK5vL610kPVQd4bgIDTPQg7USrLNATkv7Ac3gFwmi
 O5DY0oS8zUdTZxjCQHA==
X-Proofpoint-GUID: 55R98tIDJlUr84_Fh8DS5RSms79Ly64R
X-Proofpoint-ORIG-GUID: 55R98tIDJlUr84_Fh8DS5RSms79Ly64R
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289959-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 57B3358FA2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


