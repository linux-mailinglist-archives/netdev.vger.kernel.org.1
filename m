Return-Path: <netdev+bounces-294237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w4R+KS7jHmofYgAAu9opvQ
	(envelope-from <netdev+bounces-294237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:05:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A6362F229
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:05:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=KVYRfO0X;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294237-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294237-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A325530D0F32
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB87C3E835B;
	Tue,  2 Jun 2026 13:55:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2873E8338;
	Tue,  2 Jun 2026 13:55:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408535; cv=none; b=dl/fdpDUVViaK8xMvirt02MWXB+hKYb95QlDFev9qYwMIdh4Z4A/dqmF+xjm7EMK6J5LuSewltKrg4Pd5U1uVbglSge0bbNrWCpDRO8ng4qoqUjxB8akCCeCZsXZm0n29pX1LlCanVdTL5F2zCjgcw1cpCrRtuu1VOfiezlpymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408535; c=relaxed/simple;
	bh=uxNVsaRzOnFejNmiIUX3HPDYNqZFdOMxWonxL2AMPHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvVcD5DPWUKbdzQ+nuE+n9xUsOkMwCRU/qd2eQmAlNXXZBacSO6QPGn2PDclFnRmDNYNFupiR6uOXMSXjK1B7/nK7eu2owMGAlLM6jaKB5sn1g/Y1nGFa0D0EvNgvdzF0thy8usx2vmKpFL+pyBAriIbU5p+fpoy0x93meidWhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KVYRfO0X; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6526S14G2043133;
	Tue, 2 Jun 2026 06:55:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=U
	kbjYwFqoIN5M0l98GWm6jC17NSot+pUpVu2G13nNj0=; b=KVYRfO0X1huy/7FdF
	Bs+jJjP356VevbWrL3e/LcLCugD7yBm07ILffOJP9KFND07we6FzmH97Ai9JKckX
	qetL6c2gSjjQIHk/72TMTMo6e4waxacS5rXzcIkFsuwl1qF0OCcrFc9WSUuKHXIg
	4FambiNwlZcjvY005T0qUohnhCc2SArM/EJi5Ko2yRO2r2JH0gWkFBeUlm5ppxh8
	LRKGuVe3zIFAqPXTq6+wfp0bNQi/cjcT8eMSyQk+MTpdwkCG85JQAEZlHtxXRHeq
	xPbWyqTgFrgOa5m92xJRfjK48D9/Cid2lsLcexu52PPyzbHi3TsfQPkJKPeA1jpc
	bpq3Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ehswn9a3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 06:55:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 2 Jun 2026 06:55:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 2 Jun 2026 06:55:07 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.71.86])
	by maili.marvell.com (Postfix) with ESMTP id D69473F7085;
	Tue,  2 Jun 2026 06:55:02 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v4 1/12] net: atlantic: correct L3L4 filter flow_type masking and IPv6 handling
Date: Tue, 2 Jun 2026 19:24:41 +0530
Message-ID: <20260602135452.516-2-sukhdeeps@marvell.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260602135452.516-1-sukhdeeps@marvell.com>
References: <20260602135452.516-1-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=GaInWwXL c=1 sm=1 tr=0 ts=6a1ee0bb cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=7-RSyJf46AiWYYgqFwsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ombZElfv7JOxUI0EOaCYUrgTgoSI-mtY
X-Proofpoint-GUID: ombZElfv7JOxUI0EOaCYUrgTgoSI-mtY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEzMyBTYWx0ZWRfX1hFeJQS1gzUm
 h0KPqjH4bd9B7CZuyeX1QeOAAcRCv0GcfoSC3F5I+8GSSCtrwER3B6dF12a76GcGvL911NErDPV
 WJJ2VtAxTf+s0tnjFgVJY14YxDndjOO4khRu5sTZo1qUxDVkx8GlmNx6dLrS943E+gUU5Rdzduj
 RrVzQE0UCTcwefOmzDcoQgaA/TIy27YCa6KgVl70xKOo+u+EgmC2MwDhuxFbEMFUEHbJhEtjz2n
 n7ODVNU5fJ/P1WV/1c9tPUDwZR4XSKq95v0PirnwZ72rdhEbdMgUcfEL7/3kxEBVMm+rKLrfvWQ
 pyxNngbdBZSf8pFERNIWgldIqTJtqqbjWTa+ffSu4lZunGTmMF+1RZWrAfJknBw155TZFbXWUd1
 f1lRkCbepj6x1N1VJptHXF/9aYyY2K5pfrLJxq423AwMZFU433x587eH8agPFbZjv9Ur6z0fN2I
 oQRLfX+7cUGIdvG2b3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294237-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:sukhdeeps@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,marvell.com:mid,marvell.com:dkim,marvell.com:from_mime,marvell.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20A6362F229

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


