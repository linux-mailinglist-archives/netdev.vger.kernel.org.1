Return-Path: <netdev+bounces-294238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Iz5cMUThHmrtXgAAu9opvQ
	(envelope-from <netdev+bounces-294238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:57:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 610E162F036
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:57:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=d9MuowxG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294238-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294238-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CAE9A3008D5F
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548723E9299;
	Tue,  2 Jun 2026 13:55:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C7A3E8340;
	Tue,  2 Jun 2026 13:55:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408536; cv=none; b=tUN419Qd9pbZUpS59fOlyG1HvOahKJawREWMbBSr48mfek83kHHTsL23t1nEgvT1gE50YKEIitKRPYbYn0f3VbNsVQOkSuIA/NF7ONAVHynG6vkiaABz3ht+SqIE2G26b+C1EmCF8BQEib/UJ7wUGmmd1YJo2W2yMu0Q/s3tHWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408536; c=relaxed/simple;
	bh=2Fr9Gu0QhvY6MDVRVAgKv/0duU0nkIHHf6ZVRHEl0uo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKDeExVkcVoiLtJHRxC8mTZqlfkj1QJ+Vu9sUvdC1HHXBTfyCXCLYJhiin7fpqtEnyHYbZRk5Z0u6XIn8VPNC7I3XluTQ7ckqaGFz+WegrCIbePLhaewNySSqJ07mIvvd7iNZhoIwcwCIPKQz8SIpEQO/bjkEWl9SvSw5W737wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=d9MuowxG; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6529eHA82859214;
	Tue, 2 Jun 2026 06:55:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
	SiNo6cLEgdJcx41UZzvbJ/IRtyosImtXdb7vMBXhtk=; b=d9MuowxGCqCYGGmiT
	R191DS8e91VPZkEBehJSdeXmoqRxh+p0iUtsCLkK7DpAtkP9ZX3GpdGTNyVkfMMW
	wynpIyjPj/Q3CJugcI/XrtHV8Nyhp9eHbEZ3dG4AOScF3u57Fh6oCQxRT4H7WRsv
	Fi2gdk2k2qk7v7AjRMGWdBrDZ5vQ9zR1Du8/Kteprj9/pbdPxnxU+yn4RarqEuOZ
	Knc86RVAr6v8Iz8sbC6oJvn+yhIyFkEZ7tszc/B9k2z0s2FWjRhQvfsTNa2SByiO
	58fQy9BdFeDiXs+ssvmHnyuayKdxT8bAkUeswW+9cjcWw0sEnNGg3mReC9SVQ5wU
	iKB9w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ehbxrbw9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 06:55:12 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 2 Jun 2026 06:55:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 2 Jun 2026 06:55:12 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.71.86])
	by maili.marvell.com (Postfix) with ESMTP id E22273F7062;
	Tue,  2 Jun 2026 06:55:07 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v4 2/12] net: atlantic: move active_ipv4/ipv6 bitmap updates after HW write
Date: Tue, 2 Jun 2026 19:24:42 +0530
Message-ID: <20260602135452.516-3-sukhdeeps@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=RMaD2Yi+ c=1 sm=1 tr=0 ts=6a1ee0c0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=KHjEQNYavMDKLc9vdDMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEzMyBTYWx0ZWRfXwWXMrAE+/ciS
 wBi5R8uy2rk8WaCAi5oo9UEuf7udWnf0BXCPUtGGj3mgsp9FPi+sbVT5+XUMF/1Yz8TTeGroez9
 HJmEIfJkwBoZgnqGGzjZ4l/SzS17I1EXj9JpL2mt3atdE593bPioZdYbNPb8v6eRM2NXys+03TX
 gGEvoPkpdEIuEriocD5myRX2xfhMTuXK3WXpJ84kYaKTaG2EUMSd6VXKseJd3u/Na1vQy5I/UnL
 9cbj/D2MN2DUUWcT9BwFW7ixoQ2xuw7Ucb5HOcRzGEDNRZdeugbAPaF85y7KSLr/7NTXSOFn7OW
 oW2/9pC6YtxuXgKWY+SZ5X/CTAjqSVD9LxTLUsN7OYSM7KK2+yDmoh57bBZQGddgfgzeGqaut9O
 KdlRei4m4xE2WSggwfPAId3beb+citljujnxu4cjETi569n/do+ysACRAjfkqnCnyFsp0U12ATX
 WPOUGL1sJNfdshLBqOA==
X-Proofpoint-ORIG-GUID: 3mkfOmL3RsakQSy7Aq2QvTu3HHMcAgdt
X-Proofpoint-GUID: 3mkfOmL3RsakQSy7Aq2QvTu3HHMcAgdt
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294238-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:sukhdeeps@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,marvell.com:mid,marvell.com:dkim,marvell.com:from_mime,marvell.com:email,vger.kernel.org:from_smtp];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 610E162F036

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


