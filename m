Return-Path: <netdev+bounces-253850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKptBKK1eGlzsQEAu9opvQ
	(envelope-from <netdev+bounces-253850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:54:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C77994892
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E9113038F69
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E031534DB59;
	Tue, 27 Jan 2026 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fms8en7a"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0302FD69E;
	Tue, 27 Jan 2026 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769518323; cv=none; b=o1dpxzrI+mqU8FiefbIgjEt50Y+UniX0awe5xSBudphnWaY/xkODdNHwq+34eQw+XxVR+o7BjjTjK/h6CEywCpJkMhQEuj633FchkTaYDJbcyN1VrS8AP7t7m3Ht429Pdl1m/q9MYuAKhXe9hyOdm+B/RWpzRKCq7bOtME7DGz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769518323; c=relaxed/simple;
	bh=AF7B5mdjuILhUr9Qo/loxzXqXOkPfO93BI7mR0gBkJk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rjx2wTdrl5L9mWjQU5qlGvWwsx789vKa+c5TIGNg2YzI1nqOjKa6MCJRQydL0kx0pGWQzPmOp7476Jscy5kuWw1JZs+QJNIp/TZbQCj7OxBpjpmRUkKGIce7fNxmNwXTtQ75Xds5QERh3eJJZbwD9ZUWU0bpduNZIxZTtstlU9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fms8en7a; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R7Dw0v379663;
	Tue, 27 Jan 2026 04:51:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=5HdhpSaJsDf6WBnwoSxqJJq
	/SN7CYe+G2BduJiysASI=; b=fms8en7acWNL8DXEdFgzUnfp9blMAvn3wvdRv2j
	4eBeTH+NwVvTps3eblw2PyN/uIl30Yr3YmWD74yxlkrLWaisKOgRLcCzG3hAOvQf
	bHqsc10UttZTojw4/TZS3NUR9f/Py+ZaWbMbOXiSmKDYzXVIEbBO5ADFUQcCd74m
	WvIwT4o1A9V357L6alCtI54/GZHiSsldDLJMAy2ZYv5SOAk+dYKC+6FlX9e3Grc1
	BXUIoQgFykCt7y6T+LKCbYIa4muq8x5geiyDmELHG4tgHG1HAjxIRfopcYomVIbn
	fGAn0dvqAbHdbLTkPlv8n+O9Sf3vnU/yaUwtFiwk6EAPDiQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bxa2yak61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 04:51:52 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 04:52:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 04:52:07 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 8A3343F70B2;
	Tue, 27 Jan 2026 04:51:48 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <andrew+netdev@lunn.ch>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH] octeontx2-af: Workaround SQM/PSE stalls by disabling sticky
Date: Tue, 27 Jan 2026 18:21:47 +0530
Message-ID: <20260127125147.1642-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iZALfc9a5nPERtJBpQLb7wx-Wt7Ons3O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEwNSBTYWx0ZWRfX1OfJjFrM1JNf
 0ooHSPP4YKbUPOcJe1NkjYScK2CztlVYnz/jQWjGxSH2JZeHaONQz1X1KzgsMHKHGQDOj8Nmq4V
 ieXDkJ3qesCAvREN5SSCoy9neHobrv+Zxu5AEvu0q0WuJuo8fs+HSRJJMuwBuClm/kwy+PK//vo
 miGGQ+SzeOUee9yOLD/POYatuDNRIWJWO7+zSTcqx2iE+0Mq9qHFp5vxvQ5hsOcIxTd6Y5xEUZz
 MfZHtgb/XSm7koTsBeGIboaurMT14omlXK6jxAXcf/wpE4qOjYHzaweRhIrbBcbv5CQCw5hqXyP
 UuJpEiOKYk8wmps9Cr64UcmRhwcsvtPx17G3pVLfTg4kIAwvpdV8TMhtk59jH0berBlcy0rhXXu
 JT9g0WQKaaqXJjhEgjZWLh+Ionh7XfHYFcSEaPodQypC5uel4nPvQoL1y07Tk5nbT6Lfuc0j702
 i9D/mCGAr6htIKOtAkA==
X-Authority-Analysis: v=2.4 cv=CY8FJbrl c=1 sm=1 tr=0 ts=6978b4e8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=qf4gfuq51q0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=bwYdPTnTkM3dl6DVjWIA:9 a=3ZKOabzyN94A:10 a=k40Crp0UdiQA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: iZALfc9a5nPERtJBpQLb7wx-Wt7Ons3O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-27_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253850-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gakula@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 7C77994892
X-Rspamd-Action: no action

NIX SQ manager sticky mode is known to cause stalls when multiple SQs
share an SMQ and transmit concurrently. Additionally, PSE may deadlock
on transitions between sticky and non-sticky transmissions. There is
also a credit drop issue observed when certain condition clocks are
gated.

work around these hardware errata by:
- Disabling SQM sticky operation:
  - Clear TM6 (bit 15)
  - Clear TM11 (bit 14)
- Disabling sticky → non-sticky transition path that can deadlock PSE:
  - Clear TM5 (bit 23)
- Preventing credit drops by keeping the control-flow clock enabled:
  - Set TM9 (bit 21)

These changes are applied via NIX_AF_SQM_DBG_CTL_STATUS. With this
configuration the SQM/PSE maintain forward progress under load without
credit loss, at the cost of disabling sticky optimizations.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 2f485a930edd..9520a55cb710 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4938,12 +4938,18 @@ static int rvu_nix_block_init(struct rvu *rvu, struct nix_hw *nix_hw)
 	/* Set chan/link to backpressure TL3 instead of TL2 */
 	rvu_write64(rvu, blkaddr, NIX_AF_PSE_CHANNEL_LEVEL, 0x01);
 
-	/* Disable SQ manager's sticky mode operation (set TM6 = 0)
+	/* Disable SQ manager's sticky mode operation (set TM6 = 0, TM11 = 0)
 	 * This sticky mode is known to cause SQ stalls when multiple
-	 * SQs are mapped to same SMQ and transmitting pkts at a time.
+	 * SQs are mapped to same SMQ and transmitting pkts simultaneously.
+	 * NIX PSE may deadlock when there are any sticky to non-sticky
+	 * transmission. Hence disable it (TM5 = 0).
 	 */
 	cfg = rvu_read64(rvu, blkaddr, NIX_AF_SQM_DBG_CTL_STATUS);
-	cfg &= ~BIT_ULL(15);
+	cfg &= ~(BIT_ULL(15) | BIT_ULL(14) | BIT_ULL(23));
+	/* NIX may drop credits when condition clocks are turned off.
+	 * Hence enable control flow clk (set TM9 = 1).
+	 */
+	cfg |= BIT_ULL(21);
 	rvu_write64(rvu, blkaddr, NIX_AF_SQM_DBG_CTL_STATUS, cfg);
 
 	ltdefs = rvu->kpu.lt_def;
-- 
2.25.1


