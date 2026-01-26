Return-Path: <netdev+bounces-253357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NGkIhsYd2k1cAEAu9opvQ
	(envelope-from <netdev+bounces-253357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 08:30:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B480B84DA3
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 08:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ED7C3002F86
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFE52C0278;
	Mon, 26 Jan 2026 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YEKQ2oHF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34F2212566;
	Mon, 26 Jan 2026 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769412632; cv=none; b=RDPvcWaG9U9mg3Q6Mc5IyJav/Z3nn08XFFGNOtjdCMvD6FVvqYrcUvKcM2e/lbyhG/ORphC67AjB4jVrAniWWaSCxrOOcYh4MaiYgCxfWn6u5bMXPraC/VCmlv0DdU2BAPIMQR1bli4W/dn4WErVKrItmeOeNa+P7hnEnrU3fKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769412632; c=relaxed/simple;
	bh=7M1Qp3E4IgSeuMjenTyLTiLhYneDC0ACbTvLHKeBhK0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F4kZdN7gzQ7mOoJk3UgKYzWtDTL/xR6A6Onp8JT6h0w8p45IGsHhX04VVNSxOR/3vOfRfenQeruTAlojkNpMPexn6k857TGLUD9ZGMQtRGvPaAv0i76ufou6MiW0ioDl93CWzVtGtJX9friacZbOP6bKda1fzKkmLeVxR6+mQ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YEKQ2oHF; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60PNGOiP3054212;
	Sun, 25 Jan 2026 23:30:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=AucSPbb3bnmFr22F++NhPthsl8GBA1u0JwQ/99BcSi8=; b=YEK
	Q2oHFzTf+/Mjwu+jBv27gkH6mk6w6C9lIcDvtpZFpUh/PMKoeQ5UKxe60+P1Q/u2
	HbJedmTsjjXg1IcmGHBfopx67Gcd50Afi/wRGIw+pnI9EirWyyOkwpAI0Ry6VMpT
	ATx65OGMX677z2ts7PUe9DT0/9sAd+C457XkUdmbe7izg++Pyg0cNF8uXdT/jfi1
	4+QhGRknh68/zIeVCjDxLzK3F+jk0pxatzFNHgWFQbUhHDHhArEB+MvxM3dvUw0q
	I08JXZySt495I4EAQ/cC7S4mGnjr3oJkuQcaVX/lGdjn9nMHgVQo/SzVojpuvznb
	K6VM8bFxquXyUePCS1g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bvxfjj9y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Jan 2026 23:30:20 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 25 Jan 2026 23:30:34 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 25 Jan 2026 23:30:34 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 2F7683F70FB;
	Sun, 25 Jan 2026 23:30:15 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <andrew+netdev@lunn.ch>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH] octeontx2-pf: cn10k/cn20k: Update count_eot in NPA_LF_AURA_BATCH_FREE0
Date: Mon, 26 Jan 2026 13:00:15 +0530
Message-ID: <20260126073015.29333-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 1KWETdC_QTilqt4z9kXJdYJ6Ijk-ttbS
X-Proofpoint-ORIG-GUID: 1KWETdC_QTilqt4z9kXJdYJ6Ijk-ttbS
X-Authority-Analysis: v=2.4 cv=S9LUAYsP c=1 sm=1 tr=0 ts=6977180c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=BegAR1CbhO-4hU-ZqGQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA2NCBTYWx0ZWRfX/R/sCFLwsvlO
 mtwjjNP7oV9SOb8his/N/SiwfahGBhB6j4UQfa+Lzl/sxiQiwy+Gvv60XVyAe/qDbhTmJsOBXo2
 TsG0QdwOr0T4arfoXyW+NHUxq41RDDzwSaFz8TAY95p96DcQv9oRgw3yp15jywVFoCU1aWb77HM
 7bQ9Co9u6eLAznW/ZJrrkRb3/aq6fXB6aQERE1do20mf2CB4qQ0lQgsExk5xXpWqrtvIXIfigq1
 VpBo+Afnj5OXLsXwVOJ1TxiSuAeJG0FQzarrS15OH+YVt2ONB7BfDPAiKfMtTd7Na4jT0BfCby2
 Tao/ZvarnxUd1sPUbYemRy+39uBB2K2okECsJ1IzKPIk2KRigZhyLYefGfhWUz1A+eLM7nsF6qX
 zEZb5a7Zs+hf0C/uDSzLSis344wpGTxtvT6cY3Pdx8Y9G1KRkhQ6Y5uvnZDPvQ7tH/MqL1L6sOh
 zyfjVGgJBEQMhzPXZ9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[gakula@marvell.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253357-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B480B84DA3
X-Rspamd-Action: no action

The count_eot field determines how many valid pointers are present in
the last 128-bit word during buffer free operations. The current driver
only handled CN10K devices where count_eot feild is 1 bit wide.
And possible values, count_eot = 0 for an even number of
pointers and 1 for an odd number.

For CN20K devices,the count_eot feild extended to 2 bits.
The hardware expects count_eot to represent the least
significant two bits of the number of valid pointers to free. This patch
updates the calculation accordingly to ensure correct behavior on both
CN10K and CN20K platforms.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/nic/otx2_common.h  | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 8cdfc36d79d2..c6023e1ce92b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -789,8 +789,15 @@ static inline void __cn10k_aura_freeptr(struct otx2_nic *pfvf, u64 aura,
 	tar_addr = (__force u64)otx2_get_regaddr(pfvf, NPA_LF_AURA_BATCH_FREE0);
 	/* LMTID is same as AURA Id */
 	val = (lmt_info->lmt_id & 0x7FF) | BIT_ULL(63);
-	/* Set if [127:64] of last 128bit word has a valid pointer */
-	count_eot = (num_ptrs % 2) ? 0ULL : 1ULL;
+	/* Meaning of count_eot
+	 * CN10K: count_eot = 0 if the number of pointers to free is even,
+	 *	  count_eot = 1 if the number of pointers to free is odd.
+	 *
+	 * CN20K: count_eot represents the least significant 2 bits of the
+	 *	  total number of valid pointers to free.
+	 *        Example: if 7 pointers are freed (0b111), count_eot = 0b11.
+	 */
+	count_eot = (num_ptrs - 1) & 0x3ULL;
 	/* Set AURA ID to free pointer */
 	ptrs[0] = (count_eot << 32) | (aura & 0xFFFFF);
 	/* Target address for LMTST flush tells HW how many 128bit
-- 
2.25.1


