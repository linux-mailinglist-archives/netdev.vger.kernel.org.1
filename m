Return-Path: <netdev+bounces-254068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDNdIIhzeWkHxQEAu9opvQ
	(envelope-from <netdev+bounces-254068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:25:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A289C36F
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1CF1300FB78
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92992298987;
	Wed, 28 Jan 2026 02:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="L85p+LhG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF030262FC0;
	Wed, 28 Jan 2026 02:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567108; cv=none; b=DX6Zvsim5iYQ3T0kgwNWu9P84mpB8pVfcDolICARgYQZCkLuwG1O4FbBibzRwEN4P8WSha6BqM20uThog5nUtXDPG/PBuzgedyvCo2wnCtikMpMd/StBlOjUzWMeTCnAjIaOwKpEZv6H76v/aFb+LfIMk5r4mKDHrp8zF0/N200=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567108; c=relaxed/simple;
	bh=eM9ZN/OKZai+oZtqZCWSJ4uxxH+rHCAu/kuqcq/vPVo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oQtOi0jdDxEYQTA9HLwbYt8jFsFXgJCr2wOOyTjROo7HqrOCtwfnHAzQ9hqnTakmh6JTbWQuZZLmv5MsEE16lPtERD8Z3Lp6PdpgSoZe/E7E3ZczhxPZnYFvhYkkUqCu3qlFhueiuVqYXSoCYuiw/HOOzxP/oWCJTbqH1dFZwhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=L85p+LhG; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RGPxYD1390280;
	Tue, 27 Jan 2026 18:24:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=n8RuJ7EhcsLCxD3pC16aojCyLiwzb1MnjUwxPSvVLT0=; b=L85
	p+LhGLB/68gsVNbyrPE9MPBhxJmq3KIhuiA+E5nSuvH4FBRrUJGNLjJW9uwoGjtG
	Ba5Y/zn7okv14E/zKevoTffnN7WpFD5Cwa6/mdFjEcuTypZwOvjBMnLor1kEOOyT
	SA60xZELasZ722aj2scLoGADZ3Td9QulTfgZu/aPxX85Xa0N/WTIDoOyrvD2rRt8
	2VJh34f19tN/uzfryJHYMmLzUWTMgjOrPdrBNDLw1qhCFxRM+T9KKdFv/3BAJpFV
	GwjW+E7pcdMBZYIp3fOp5JhXyX46MMBBHW+KC8iu65sAvdk3UCBNTzgUDlA75OuD
	T4MdNmwKXvM58M8F5ww==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bx0qswdsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 18:24:54 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 18:24:53 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 18:24:53 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 172D43F70D1;
	Tue, 27 Jan 2026 18:24:49 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <andrew+netdev@lunn.ch>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v2] octeontx2-pf: cn10k/cn20k: Update count_eot in NPA_LF_AURA_BATCH_FREE0
Date: Wed, 28 Jan 2026 07:54:48 +0530
Message-ID: <20260128022448.4402-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAxNiBTYWx0ZWRfX67vlnxd4Awb0
 TfnyYAe8vQjzJ31WE9dXe87jv7zcnrlfKdA4ZIRx6VHK4IcSlXao4jW75eLNz1odI9hBOTXRjC8
 0/UCGo41bVqlDJoeAL/ECuGcnIuTB5lKmNW7dmtXcFwiFh0N3F7QBU0fRaHETFVwXj5orzRP4zY
 Xb3gVg1b+vlTSGaPXGBfAHKAhVdCqiEqqxjkG7fY2gSbhEo+zSjX61Rk8rAYIVUnvVlaMVOElk2
 j8mCDrlFwOaVpP97/mPQqCYRgp7Y+M+Pxd/BAmUB5QouzeklRbOIlnJltbbxmb/V68q4dkIokZv
 fwWbIy/JuFYlW2nGZxHdyBEw+ei5fDAsdoKuqs69rODV7bVH//jpaABMytS7+Tni4p+pJz6DakG
 NlU/NtQVY2h6lc/LMowcpTGiDhMYNGW9b4TMTYspHs34ZYd041DIncn1pAT5ZudMAxXz2fZRV+4
 j6aEKuOPuhgsSRly7XQ==
X-Authority-Analysis: v=2.4 cv=P9E3RyAu c=1 sm=1 tr=0 ts=69797376 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=gZj3l8r3B47-ThncwAQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: dslz7DZFJYUqVIasm8TvRP8Z8KDe1KIO
X-Proofpoint-GUID: dslz7DZFJYUqVIasm8TvRP8Z8KDe1KIO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	TAGGED_FROM(0.00)[bounces-254068-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NEQ_ENVFROM(0.00)[gakula@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E0A289C36F
X-Rspamd-Action: no action

This patch updates the count_eot calculation for CN20K devices. 
Where the count_eot feild extended to 2 bits, while maintaining
CN10K compatibility where only bit 0 is used.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
v1-v2: Fix size value based on count_eot

 .../ethernet/marvell/octeontx2/nic/otx2_common.h    | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 8cdfc36d79d2..255c7e2633bb 100644
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
@@ -800,7 +807,7 @@ static inline void __cn10k_aura_freeptr(struct otx2_nic *pfvf, u64 aura,
 	 */
 	if (num_ptrs > 2) {
 		size = (sizeof(u64) * num_ptrs) / 16;
-		if (!count_eot)
+		if (!(count_eot & 1))
 			size++;
 		tar_addr |=  ((size - 1) & 0x7) << 4;
 	}
-- 
2.25.1


