Return-Path: <netdev+bounces-279643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBWwARCR5WlNlgEAu9opvQ
	(envelope-from <netdev+bounces-279643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:36:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D86D042651D
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3C8A30089BB
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1A5379EC6;
	Mon, 20 Apr 2026 02:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iXB7EH+d"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA319F11B;
	Mon, 20 Apr 2026 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776652547; cv=none; b=gsHO0aFrvt1q4oT34CuChSsKKPGdGYccpwXbaAb+Ek68e4/s6SDvOM0z9fpkzRyh61HfMyeM04MVc8/799ROwtwFQJ0g4KqPziH0W610US68Iqj/T//QyrHrj99E7cazlOLSLUVgKp/qVaI1CknDYIHL6ZlVqTzp+Xgb5dHuXkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776652547; c=relaxed/simple;
	bh=bXbJ50rFUcbIasO1xX0zJRnkAC6bDqr9WbvInAZYxgM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpkDqwlJhQJ6fBcqFzFLqzCTKZ/g9kGIlVxdH7b7UxwvpCcmR+hnKCQDInavpEDeV2AGwvg8ZcPn0d0vmdoE3iUYHC/+YNIyu94HfnFDY6dfpPNav8Ec0yXJVKLOKH+pwzqQxe5kP8CriO2JLRbKi66C+PqQLNLmKotWeLi7z8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iXB7EH+d; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JMfQXB2187676;
	Sun, 19 Apr 2026 19:35:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
	64yxCKZ1tCxIC7h1IriReMi8/fzCDRdYMWcUSBl58o=; b=iXB7EH+dpGDWht4AQ
	VnVRUpREUTI2jEk0KOUFaSeqpnkz1Lzvmc61SmXD6aj0UcLm6wOluK9XxLCIZt5K
	0N2UHV7+lVUKwMBjFkStueNRdKoAZH6c7/vm6RtSTmQ59h+GKnmod5gnvSuUie4m
	GFRY7xuJ2N5QEODJwKXiXseAizjsnM8pap3GtMTSkbZO57KWmZA9q4F/vk5/6jK9
	ncQA+mYY4PBhrsEICA5ugPs9JHK6XBBKt9cuLrYyqOx+PIRgHMrI1yYFJRFYb+Zq
	ftHHuogXsbiPzeFvfciZ4ue8Zm7kmvENb/YcoFwilY1ZQeiTC28XoDPHpQxUrwMH
	JQHjw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dmx77h2np-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Apr 2026 19:35:36 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 19 Apr 2026 19:35:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 19 Apr 2026 19:35:36 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 153D13F7041;
	Sun, 19 Apr 2026 19:35:32 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <dan.carpenter@linaro.org>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v2 net 09/11] octeontx2-af: npc: cn20k: Initialize default-rule index outputs up front
Date: Mon, 20 Apr 2026 08:04:40 +0530
Message-ID: <20260420023442.3295891-10-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420023442.3295891-1-rkannoth@marvell.com>
References: <20260420023442.3295891-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDAyMyBTYWx0ZWRfXzuy70Pzix5vH
 yyOzLR/BI2UlMy4OH2Sx+BYC0QeXeuf2JVkaImN1DhXdJKzpD7JjT9DwYXHLpQlRVD7IzLQ9HNQ
 95tjIWM/3tt4lIFVCi0NlmnhhqVHCqta4DbW4Ca4wmNA32vsG+Saiu2XAJz9DLHcV3wE9aIeT+M
 Jf0FyYbFFNJksqovwH0Gf/UwxQfMBsIo7UoMVn/ClkN799EnbNSs8uK2z4gbqr+a45cyaQ6PLUZ
 tKjAkf5akubH+GCH2fEheMPQoTkWcuhaX/1YfyxBgqgR9M4RImzTFjltPkaTpQNM+us5+9GCHLR
 +wfpeLSiP8Mazr8iztMbuG+H5n2pg9t7TdduIXjGTIn+SwV3tComOdzi8KxKIb6q0RLp3prKFlY
 Spa0oe1QS8DondeZwhWdyz+G3+B6vQE91fRWC3ZbHBlT+nzSx40THo9ZAoZIDj4Y3JmXQvq99Px
 xyXPCxbcmVoa2VJZdxQ==
X-Proofpoint-GUID: PfbYL4s8zxuWiLnMVyTfPQVvzQrojlj0
X-Authority-Analysis: v=2.4 cv=P4IKQCAu c=1 sm=1 tr=0 ts=69e590f8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=jWBfGndVv8tF2AnpqLMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: PfbYL4s8zxuWiLnMVyTfPQVvzQrojlj0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_07,2026-04-17_04,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279643-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D86D042651D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 752dbcede90f..0714734c6af7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -4001,6 +4001,13 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
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
 
@@ -4016,7 +4023,6 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				 npc_dft_rule_name[NPC_DFT_RULE_PROMISC_ID],
 				 pcifunc);
 
-			*ptr[0] = USHRT_MAX;
 			return -ESRCH;
 		}
 
@@ -4036,7 +4042,6 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				 npc_dft_rule_name[NPC_DFT_RULE_UCAST_ID],
 				 pcifunc);
 
-			*ptr[3] = USHRT_MAX;
 			return -ESRCH;
 		}
 
@@ -4056,7 +4061,6 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				 __func__,
 				 npc_dft_rule_name[i], pcifunc);
 
-			*ptr[j] = USHRT_MAX;
 			continue;
 		}
 
-- 
2.43.0


