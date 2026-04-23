Return-Path: <netdev+bounces-280713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDePNJj56WnkpwIAu9opvQ
	(envelope-from <netdev+bounces-280713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:51:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 825DA450EA6
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33E8630F50AA
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8C33E5581;
	Thu, 23 Apr 2026 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Scf3Mdyi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4C33E121D;
	Thu, 23 Apr 2026 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941050; cv=none; b=AbCmJummeAMEGfwhqD9Bt2lopHbok6uDyMqdQrPN7hYTnGObbryXIcJf80VMZd9ilGGJrz0DiiLDwuJ1QY6wxa1cFUHL0xXal/DdqZMc9VUwF5PfxxzfqzKyhTtY5WhyZooMFzoCWNmnUgz7siWHRl37Wv5GWF/y4OAZk8bo0g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941050; c=relaxed/simple;
	bh=vo48SDEawX3aFm0pwyBAMC+CmR8GsXJo+cVtSlpySzo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1+dahk2Y6WTMPVyM+ZIVaAK1dtk//eXZ/45hzijzgXnrv/zMLxc5cpYb9ZorA+TD3JQAhVVj6S9JrP9/cGD4Vzpaj79OlIBUPKAEW2BcI6Ky8HDmqL9zzrTSDz0umITGiZbH1kyPDXQAqPaQ6oRh9PZkfslLhsYIjMcHONS6IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Scf3Mdyi; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N6GaNV692965;
	Thu, 23 Apr 2026 03:44:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
	6xHSoYuupH8yoWj/X2yglf95qIfuZyusnlvU/lLtqk=; b=Scf3MdyiI3jhtelFW
	TxaUh8GrKU3NpIBaigJaVw0osqeO5GlQy60+PRddwohv97mJwuy4D5JFEKaiivPa
	l1OLMrwRz2YxcGlUVU5EVrHeLx475wmdeWb96m4EznZLGQtMi5kPrIZYCM7sjPag
	B1iKy2nnAZmpz6CI6mTwakYE1y4tCUxVcnDMYSDgzALdw25endFKdFb8EDmP3/KU
	DxIOeKSYcQUwWd6hwmTsIinbx8z1KpUgaSyUqeN5AcpD18naov3upWA3IfFdAk7X
	vpPPAzzMxb9irja9n78F/9JzbTh9aWnxxBLv3REiqNJcSFEeYu5zKqlRW19Ph3IW
	TlLpw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dq1n6jfh9-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 03:44:01 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Apr 2026 03:43:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Apr 2026 03:43:57 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 8AE033F7044;
	Thu, 23 Apr 2026 03:43:54 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v3 net 09/11] octeontx2-af: npc: cn20k: Initialize default-rule index outputs up front
Date: Thu, 23 Apr 2026 16:13:15 +0530
Message-ID: <20260423104317.2707923-10-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423104317.2707923-1-rkannoth@marvell.com>
References: <20260423104317.2707923-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 35iROhcl8q1kHfZxCw7OF_J1cz90IRUL
X-Proofpoint-GUID: 35iROhcl8q1kHfZxCw7OF_J1cz90IRUL
X-Authority-Analysis: v=2.4 cv=ecoNubEH c=1 sm=1 tr=0 ts=69e9f7f1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=jWBfGndVv8tF2AnpqLMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEwNSBTYWx0ZWRfX9WWfUY8G8gMe
 62xaiaS8u3qaSO5N+fEPT+8ddtvA3Vt6y7tCmXWx4KXwI5hQOMI4rTyaaYQluB0yZ2X5LGM2qu9
 ZhBKRC6zr4ZEqboAnBf+uv+QqHImRVTT5FmZC7/facUF6n3YdDoTv9IMqWfgND1n9wjbI2U5t0Y
 USRBmVSCc5RCamzYC9yopWuRxwGevkyElJ1bY7zcc/oDi1O6lAklTXeir/th73wQVR0wkoq6ZMO
 /xjq7txgQb6cruGX2nEtjc8npbaVzFus6Et8QOdIqDy2fydmV4mfV6VWxyjyjqHQXgkp01/aBQd
 imttivCXTICbwh1ul6cbDbteyHbfOQQw42ognIhHidbc/PhiRh+L2lTh1P8UFBiXoZ9x1Zr+cdX
 MolYkgO7u0OFcedEAUCRyFtsKZ8822GX28lKe7xn6egX162Y5d96nx/0USQ4+Y/wg0L2sr2uSBs
 Xlh9s8I7HtPIFz+NbKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_02,2026-04-21_02,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280713-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 825DA450EA6
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
index 0bcfd1243f12..6d3166960a3f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -4004,6 +4004,13 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
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
 
@@ -4019,7 +4026,6 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				 npc_dft_rule_name[NPC_DFT_RULE_PROMISC_ID],
 				 pcifunc);
 
-			*ptr[0] = USHRT_MAX;
 			return -ESRCH;
 		}
 
@@ -4039,7 +4045,6 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				 npc_dft_rule_name[NPC_DFT_RULE_UCAST_ID],
 				 pcifunc);
 
-			*ptr[3] = USHRT_MAX;
 			return -ESRCH;
 		}
 
@@ -4059,7 +4064,6 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				 __func__,
 				 npc_dft_rule_name[i], pcifunc);
 
-			*ptr[j] = USHRT_MAX;
 			continue;
 		}
 
-- 
2.43.0


