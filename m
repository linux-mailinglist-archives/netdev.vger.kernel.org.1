Return-Path: <netdev+bounces-281225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WImmBAQE72lz3QAAu9opvQ
	(envelope-from <netdev+bounces-281225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:36:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7078C46DA0B
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACACA3026C3D
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 06:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EBE371063;
	Mon, 27 Apr 2026 06:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Y+3LS/iq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5427937BE9E;
	Mon, 27 Apr 2026 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777271564; cv=none; b=fOHu8kUIPjya4ZtoQ5Bi+KGZqdQNZMIc00FYsMEo/8ETnEFvwNnuLp+Nem1xaREtnI6wUyhvopfXk1eyakqGpoGRA9tJ//NRpb+vXDm3hqUj/xSIzeldlgiV3fScpfikYaIxL4NbOsOYxmyyAz5iPMQZ58bYRae8U9PKxKXFZN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777271564; c=relaxed/simple;
	bh=SCx0FQZ3mMoedjX0FgcoCFCvZa7DvmJkLrBFqXzFigM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgzYqI+RvFHTZTBqJDOrJC7rcvvTeKUJGFPs6izvWtQ4O7TQ0guTm1fVbQJWvEEEvT3xMM0tnzxIrGOO+t/jYLj4lYG0zKHHNjNWz1B5bvOYPcAWZum5zCLMpjaaG78zUnNEkE9nw121w8UmdZ6cwRAq0ospDH2Mnh2zqf2vSPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Y+3LS/iq; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QKjK6k2392172;
	Sun, 26 Apr 2026 23:32:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=9
	RuSma2fb0I3xDUOR1CJEMrEoOfLv3jRMe7/xC0gu6U=; b=Y+3LS/iqzBOstjNuC
	3EQ+gFaBV4rSKZBIPyu42L+ejk222LvE45RvCuAwgmVyUtcqpq5WHqp3a8WHXwK6
	yMFFJnJfEZHjzGyrlPFxBr6qoIoMp06FBYGsim6CNK+TVB2ShZW7YhZg9zg+JA7i
	eFZZTKWctVFkvY8dYDqEg1uicxIhIp951H3vJ9bMusgzemLCo41N9zs6kvsmrzbz
	Ay+8xXFdv9Oq0xPhO04Izyw9CJBqm9WeZJ0/psNS+jZWm5qR6pnDxSqdb1vFptmK
	RgQQ1sr3qfB5DJ1HxdBDwpd6PEMC0nmzoKJdHMLgObNOzBKvqqob3jkEZwZ8YoDe
	gpw+g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4drw4fjxrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 23:32:35 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 26 Apr 2026 23:32:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 26 Apr 2026 23:32:35 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 10FA63F70BB;
	Sun, 26 Apr 2026 23:32:31 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v4 net 04/10] octeontx2-af: npc: cn20k: Fix target map and rule
Date: Mon, 27 Apr 2026 12:02:07 +0530
Message-ID: <20260427063213.3937451-5-rkannoth@marvell.com>
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
X-Proofpoint-ORIG-GUID: GoxGlgSobAmZnJ2wigRiGN1rNczB7CL-
X-Proofpoint-GUID: GoxGlgSobAmZnJ2wigRiGN1rNczB7CL-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2NyBTYWx0ZWRfX7/rpODsJmT0Y
 2u6PsPnFoRKgYM/SCgK+mQRathmTq6n71GTu30sw2R8pf6hap7cxFjt+qzwd+mkUW8nOZ6OsQWt
 nSr/HWdYCI66tpK4wqNlDLkYpOKBAP5c+ccCbhJ1HTBJLsY/hj0FJOxcoyCHRCUEqaSddVhEWUd
 Zs6/WiYbSFMcTJ1o5TYhPGumd0LTFTLInkvRxts3bF/4swlZaQVveYofoUosa0i2sx6mzptSD2F
 cjOwVisaTlylsk0yAmEb/IunHm9d4Ah/E735SNbCmIdTceBnCXsc4WH3oarOHoBuYAG4dwzghWn
 GBuljwYMqsu76NInicXMFIcZQDYw90MH1IZyA+pEdfQcpuLsQmRRzj0lOtQY/z9k16SZyh+hQX4
 Wa65QQyWy1qcB1o1IzRubHi6mF+I4OkOVrG2o42Yif3ebEVLGmhXE0fNQlwczHoh6NEnLiTlcRg
 dDLk4yrty40yPN7HU0Q==
X-Authority-Analysis: v=2.4 cv=X/Ni7mTe c=1 sm=1 tr=0 ts=69ef0303 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=3gJHjdpLIrtAeZZwNzUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 7078C46DA0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-281225-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

npc_defrag_move_vdx_to_free() disables, copies, and enables the MCAM
entry at a new index but previously left entry2target_pffunc[] and the
mcam_rules list still keyed to the old index.  Copy the target PF
association to the new slot, clear the old one, and retarget the rule
entry so software state matches the relocated hardware context.

Fixes: 645c6e3c1999 ("octeontx2-af: npc: cn20k: virtual index support")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c    | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index c831585424df..020496c82806 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -3588,9 +3588,10 @@ int npc_defrag_move_vdx_to_free(struct rvu *rvu,
 				struct npc_defrag_node *v,
 				int cnt, u16 *save)
 {
+	u16 new_midx, old_midx, vidx, target_pf;
 	struct npc_mcam *mcam = &rvu->hw->mcam;
+	struct rvu_npc_mcam_rule *rule, *tmp;
 	int i, vidx_cnt, rc, sb_off;
-	u16 new_midx, old_midx, vidx;
 	struct npc_subbank *sb;
 	bool deleted;
 	u16 pcifunc;
@@ -3709,8 +3710,21 @@ int npc_defrag_move_vdx_to_free(struct rvu *rvu,
 		mcam->entry2pfvf_map[new_midx] = pcifunc;
 		/* Counter is not preserved */
 		mcam->entry2cntr_map[new_midx] = new_midx;
+		target_pf = mcam->entry2target_pffunc[old_midx];
+		mcam->entry2target_pffunc[new_midx] = target_pf;
+		mcam->entry2target_pffunc[old_midx] = 0;
+
 		npc_mcam_set_bit(mcam, new_midx);
 
+		/* Note: list order is not functionally required for mcam_rules */
+		list_for_each_entry_safe(rule, tmp, &mcam->mcam_rules, list) {
+			if (rule->entry != old_midx)
+				continue;
+
+			rule->entry = new_midx;
+			break;
+		}
+
 		/* Mark as invalid */
 		v->vidx[vidx_cnt - i - 1] = -1;
 		save[cnt - i - 1] = -1;
-- 
2.43.0


