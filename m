Return-Path: <netdev+bounces-281230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHu7CrsE72ma3wAAu9opvQ
	(envelope-from <netdev+bounces-281230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:39:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B6B46DB0F
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6AA53067CAE
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 06:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76BD38F94F;
	Mon, 27 Apr 2026 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MYduru4k"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6CA38C2A5;
	Mon, 27 Apr 2026 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777271581; cv=none; b=RMweoEUev7wxqfwVWgNXTn4rqOUpN8VSXwlitZauYzLJZPmxQlqv7MNnwnSk6wvYgJXxaraEYn0dfnhaP/7jGXbwQWQx6tZ08Ut8kDyHJ12+SgzHJzqwldKWfwDjhTxTEXhWzTTk+qcQn00U5mx0G9TWtqyDrJf0DDaDPSm9PbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777271581; c=relaxed/simple;
	bh=LubCldszlnDrXephrtjtd+ux6lOlk70tOqpSCSGg/KU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0qJhdaOFuDGNT6cZ7INJ2Sp4CxF3ZdCbo3bmG1043WEcv7wdeFhVT8SMjTG8NMErYL/sAm5JQnDGu4fo/FzVVYtWuJTCS8x2aZz2Cr3Gu2Ch74RVdo3+16wtGT/8c+oqKLXb/fCfxNW5lfeivkcosFQaDbeqKNZuF4cOhbbqfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MYduru4k; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QMGvYp3237478;
	Sun, 26 Apr 2026 23:32:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
	CMXYrNMi6T26M9XzrPLGmppNcxD7KtL6QnVnH07sk8=; b=MYduru4kayzrR/Yi2
	0LZQYIffupm8ARS1P1YbReeegpHUBkpj9SDBfoK4JEhRYXrao+R+d0awshDph6AA
	lQkEr6gDt0oYOFpA3Pcr0hAP+SnmmrM1NobR2KG0E9c5z9FY/2QRDSvFK68d5f20
	q8nDsP9MwRFltFm7FShAArmOEHHiqJwwWCtd3bN+BU2E23dPOwXY1QtZ76t0oFEr
	H+c9VVNkwD9yDmssL9VO7VWoeiFyAy2EmPu8gb0RSdN0owsL/Ti2HKthOFuQKIu8
	+8btp4r+iL2MVYyhA4rfTismoM6GeXlwSmpIUJyzr70QDbjdWfpIRsrQL7c5iywo
	HF5tg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4drtypb48h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 23:32:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 26 Apr 2026 23:32:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 26 Apr 2026 23:32:50 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 899E73F70BB;
	Sun, 26 Apr 2026 23:32:47 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v4 net 08/10] octeontx2-af: npc: cn20k: Initialize default-rule index outputs up front
Date: Mon, 27 Apr 2026 12:02:11 +0530
Message-ID: <20260427063213.3937451-9-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427063213.3937451-1-rkannoth@marvell.com>
References: <20260427063213.3937451-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ZNiLUP2XFDkbX0-2QO9Xx9HgjGXexqFG
X-Authority-Analysis: v=2.4 cv=UfJhjqSN c=1 sm=1 tr=0 ts=69ef0313 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=jWBfGndVv8tF2AnpqLMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ZNiLUP2XFDkbX0-2QO9Xx9HgjGXexqFG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2NyBTYWx0ZWRfX285AKXCI28W9
 GMlm/HHDUN8q7ci5UhSe/Uy4PZEMiIr5i3uFBEgx69D6bc4OgEyN0yvNPXrW/dx86YDx72G/F/C
 XN2yyCac1/jJtlLBQZemRa9JgnhaEPvQIM6T1wvLJHmb/uBeoiFTfgeFOX/JW1Z5OEOYYuNH+5B
 p2Br+v6ctsx/R7ujigpR7W0fkAfb1YJ9NYUGrYULCOmbB1Jn/RLcYNkOHY7AE6RjHMgqjntXnL/
 YX8xBUljd2TlFRQG9QlkbAx9/NrbNtyfAFdihRlvdit+XsfWFhTT79WKpXtWUxIAlS7C41z6sqF
 Kn7w5ozDeFS3+9KdEI0HyRm5I/q3Ij/YFUKdfzNeLdARhPpy29/ER6ED07J7kMt1Cv6g5IIZ1hu
 6GAg6hy73K4YpDb8dNjKRMG9Ib/70QbxJCaJb+/Oib8U/wsyBDUCU9g1mOWS5Y9fjoIzboJqNla
 Cg8JDrcp7wDuqBAdX/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 98B6B46DB0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281230-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

npc_cn20k_dft_rules_idx_get() wrote USHRT_MAX into individual outputs
only on some error paths (lbk promisc lookup, VF ucast lookup, and the
PF rule walk), which could leave other caller slots stale across
retries.

Set every non-NULL bcast/mcast/promisc/ucast pointer to USHRT_MAX once
at entry, then drop the duplicate assignments on failure. Successful
lookups still overwrite the relevant slot before returning.

Fixes: 09d3b7a1403f ("octeontx2-af: npc: cn20k: Allocate default MCAM indexes")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 369771c90256..3cc7a2339c78 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -4002,6 +4002,13 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 	void *val;
 	int i, j;
 
+	for (i = 0; i < ARRAY_SIZE(ptr); i++) {
+		if (!ptr[i])
+			continue;
+
+		*ptr[i] = USHRT_MAX;
+	}
+
 	if (!npc_priv.init_done)
 		return 0;
 
@@ -4017,7 +4024,6 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				 npc_dft_rule_name[NPC_DFT_RULE_PROMISC_ID],
 				 pcifunc);
 
-			*ptr[0] = USHRT_MAX;
 			return -ESRCH;
 		}
 
@@ -4037,7 +4043,6 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				 npc_dft_rule_name[NPC_DFT_RULE_UCAST_ID],
 				 pcifunc);
 
-			*ptr[3] = USHRT_MAX;
 			return -ESRCH;
 		}
 
@@ -4057,7 +4062,6 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				 __func__,
 				 npc_dft_rule_name[i], pcifunc);
 
-			*ptr[j] = USHRT_MAX;
 			continue;
 		}
 
-- 
2.43.0


