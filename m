Return-Path: <netdev+bounces-278918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDXdMtZe4GkcfgAAu9opvQ
	(envelope-from <netdev+bounces-278918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 06:00:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8305E40A1F2
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 06:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47AE131C0DD5
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 03:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C62314B72;
	Thu, 16 Apr 2026 03:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eof64qwL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6E230EF7D;
	Thu, 16 Apr 2026 03:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776311737; cv=none; b=g1Tc+ZmN0cXB6CZkJx/7t0vcA1t6I9tb3Sa0HdyGDuHF0aKopENxBEHXEbWmDJcG1lrHqMCCoCRNj2tqn/DiNpNofIHCn+f+oa7TplLuOH3L9mKJp1U7piYRUNLJbRvBU8F5NBziTmGvLHi4ankC0XEKXkx9KhgMjbGIgOPNdE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776311737; c=relaxed/simple;
	bh=pqimf3NDcu8MKTJUALvHFCZn88kDi6+MlZ16MDoICG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTqDwqkVnP8in7kNkm46RsAAjqCf32MexwVJ9cuD7uxUjQC2N0AAo2WmIVqVQ2lC4B/Nqj/wyzPB4SUWrmf2x9GHXO16Pkz82RQgPZJCEZKnnXumowe3o5UMWMZw69I8+MIsrhoDPl4bJoewyoZPFvDXgHi4g0icr137gxzzeNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eof64qwL; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FLclaF3278469;
	Wed, 15 Apr 2026 20:55:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=6
	Pf98AgeLQwARDEu+E4vD3tnol9QnT2Zmed0+plww80=; b=eof64qwL1hgIggPJ7
	QNNcCHCoNo6wtCoBjUrxhodgmGrRrJQQDGdmmb5owr7MwqrDQe2HqRXza9iuzybX
	3AAx6jIh9PqECww38cXyAzfaXiC4FeRRs7/u8/EbNgGEvH402NOx72i9828yhsUz
	8WsCW0ewCPGoSmFguVnlwD8ik1vor4OjhBtVnMKa/M2TLcyFyCTYRBeYfxfsxM8L
	4QKYkF59n0VvRIzFDtO5XLbPK6hut8nAoIPAirNR2AmW6nKRb0ThfZ5i1gl5PMB0
	njx1aY93rUPk9weniE/0nWY0vfm0QA2nlKYi/YNvaP/XgM+IcbBCf4nY58H6sRDh
	To73g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4djjr6gmre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 20:55:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 15 Apr 2026 20:55:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 15 Apr 2026 20:55:19 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 423A03F707E;
	Wed, 15 Apr 2026 20:55:14 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <dan.carpenter@linaro.org>, Ratheesh Kannoth <rkannoth@marvell.com>,
        "Dan
 Carpenter" <error27@gmail.com>
Subject: [PATCH net 3/3] octeontx2-af: npc: cn20k: Return error when defrag rollback free fails
Date: Thu, 16 Apr 2026 09:23:52 +0530
Message-ID: <20260416035352.333808-4-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416035352.333808-1-rkannoth@marvell.com>
References: <20260416035352.333808-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDAzMyBTYWx0ZWRfX+XAkFHAxNr2C
 wKwia8xiaq5HPhy9/Om5JnWbIfeDBUOX5LUkalaWDr3g1T86d2YTnQzjSQygBsL7CgIpN4yHoG/
 hn7edZrbTDadqWgoyGb2B46Ej+LWJ22vRTCtUQfW4I4C0B1GwSMUnhnRj5jEjJhNIl7AK1hCcWr
 zuqELs6oXR4HX9nuGMtYSPJQgBYL0JExMYjuWnl+JU+vWvsx2PCcCOTJgfvH+u8rau7aiiG6qv5
 JaMn+ev/xJAEjHNegpxVWmLMGzN9Ufqp+r49H1ZVLfsERIfmHM0p+duL/X3NE+nFoQwM+GmK9eZ
 pOuZ1mB6dI8ju6yaYa++UIj2z6ayP1atBJYhRI/tHLIRpYbaAuAa48sSgejFZQovoIvV6UezB4V
 Y7zXcyXyWpJA8Wea17ZuAYsoD72AIInb/2AXDu3FnRPQPoG77rEHVcdzpYy8RhfcIAlez9lhEB2
 8OnbjJAECVTPUwsnySw==
X-Proofpoint-ORIG-GUID: oGrzF7P7vvpBl2cfJbMvDUEzgGudtwq5
X-Authority-Analysis: v=2.4 cv=ALcTSjp/ c=1 sm=1 tr=0 ts=69e05da8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8
 a=LAwRvmMFHPUKmpe1hlIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: oGrzF7P7vvpBl2cfJbMvDUEzgGudtwq5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,linaro.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-278918-lists,netdev=lfdr.de];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 8305E40A1F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In npc_defrag_alloc_free_slots(), the fail_free_alloc rollback loop frees
previously allocated MCAM entries after a partial allocation failure.  If
__npc_subbank_free() fails, we break out of the loop but rc was still zero
from the successful npc_mcam_idx_2_subbank_idx() lookup, so the function
incorrectly returned success.  Set rc to -EFAULT so the failure is visible
to callers.

CC: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/netdev/adjNJEpILRZATB2N@stanley.mountain/
Fixes: 645c6e3c1999 ("octeontx2-af: npc: cn20k: virtual index support")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 2fcd0ee2b1e1..df192729ac1d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -3541,6 +3541,7 @@ static int npc_defrag_alloc_free_slots(struct rvu *rvu,
 			dev_err(rvu->dev,
 				"%s: Error to free mcam idx=%u\n",
 				__func__, save[i]);
+			rc = -EFAULT;
 			break;
 		}
 	}
-- 
2.43.0


