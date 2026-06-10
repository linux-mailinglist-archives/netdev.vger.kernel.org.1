Return-Path: <netdev+bounces-297641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nw8OI0ZRKWo+UwMAu9opvQ
	(envelope-from <netdev+bounces-297641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:57:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEE4669028
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:57:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=ask1kJiw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297641-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297641-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE99D3002903
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355E03F8EDA;
	Wed, 10 Jun 2026 11:55:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93453DB337;
	Wed, 10 Jun 2026 11:55:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092520; cv=none; b=mwVsk/pnFCvnH6fprVVe4UjFUjRe5lI1AZf3L1iwpcwcEisVEnPSIAX/77qpemKrgHmgtRmQJ0vgApfdHoIiOTteqe4klM70L70FI9F5jMfHZc6aZETSdtHJYsc0Hx8BUOMd4tOxFrtBmdGwz2oBOTrYjng0BDHealS72PxAycQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092520; c=relaxed/simple;
	bh=2Fr9Gu0QhvY6MDVRVAgKv/0duU0nkIHHf6ZVRHEl0uo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZB/QueUIp7L4xLgXV0r9KcmxJHYe9uh3ZBdIi+ohkJI4yuOCz5QCRMH3cNMfQBuaKfqaBlceQxlds9OBbZgxlAFgAovRTHx9YcR9rQwduVG89GwfAmtxghxW0eLd+H1XGsJr7AO3CfBmK6OiECaF2JnGD7VB86oNFSbc0tKgOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ask1kJiw; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7kLwn3125563;
	Wed, 10 Jun 2026 04:55:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
	SiNo6cLEgdJcx41UZzvbJ/IRtyosImtXdb7vMBXhtk=; b=ask1kJiwkcQus/Rlk
	+InH18eKsFjmvvawlYgriRB3SyFo9P63uMBa2PQJ4iUshswhOFUXIO3DzJa1Wn9m
	bDn/0/A4QtT9YYmcjgyL/5WESNyuEb/jRkgpn1fpEge07iKYN2jey8xEsT0xVkP7
	sD7gWogaCFCU11KjvOU7c8E+xj5YIylKdTqKmAjSX+99gpMtxba96rVZ77B/RBxd
	4Jgs0XjB2J4u5KVwQ/bXA/SigotAprhJBG5XoGuhIkgsNjgWW6wFYeWQz43O5Vv4
	8W+PTAWEe0cMbSjDmUCOuQIOcRsYjuioG6xeOkF35rpQ09SF1Vhu9Mtr69YXBsah
	kYHtw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4epex1n7rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 04:55:09 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 10 Jun 2026 04:55:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 10 Jun 2026 04:55:07 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.66.228])
	by maili.marvell.com (Postfix) with ESMTP id 9C2093F708D;
	Wed, 10 Jun 2026 04:55:03 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v5 2/12] net: atlantic: move active_ipv4/ipv6 bitmap updates after HW write
Date: Wed, 10 Jun 2026 17:24:38 +0530
Message-ID: <20260610115448.272-3-sukhdeeps@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDExMiBTYWx0ZWRfX93AC3IE6XcS0
 2owSVBQc+6iGH3y1bLZ/cl/7jvvyJfiJBdkbsPXKCi/e4yKoVVcC8uN6Y6QloWagfvVRCHQwbl6
 l3RRvRJD9fMCzKGy0vynmtC1PH9cPpkzYGg5j+FezHF6aqNiFAxDqEsHNOixh8AxBh5t+xnl1Bj
 y6F5qdiFb5RkmOt8vUPf2et631MXTi/rOCp6xwMQbb3jBbJ9P52xizTLNlHmvmQ4JoPj+IGoNmm
 KYK47Cs+M03qF1mNV5wLqRcCuuFWa02L7PYqyYzFkbOjdm9wZS2KVmkX3NN3EIGapVe/gEEXB28
 0YE6N3rTGoMbMFzAqpPzyb9HWQN2DTRwv3Ns5s3jT9skdZBgdgUCcKpbkZ0MHwQoumZmHoDFV2K
 SjHY8Y62a4WamM3iKtkkiEwzGMYW5AKFgfqVMhSTwTarArAAAq7lsbjOePRJQo9urpdZRQSX804
 e9H3vk6JVY4h/DN3++A==
X-Proofpoint-ORIG-GUID: X2g8YiOlPGVtHmWBlHXGANiXKUpq1yW9
X-Authority-Analysis: v=2.4 cv=Aa2B2XXG c=1 sm=1 tr=0 ts=6a29509d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=KHjEQNYavMDKLc9vdDMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: X2g8YiOlPGVtHmWBlHXGANiXKUpq1yW9
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
	TAGGED_FROM(0.00)[bounces-297641-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:sukhdeeps@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
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
X-Rspamd-Queue-Id: 8DEE4669028

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


