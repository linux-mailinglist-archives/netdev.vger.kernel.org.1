Return-Path: <netdev+bounces-300671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vYb2ACsRNWpJmgYAu9opvQ
	(envelope-from <netdev+bounces-300671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:51:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E059B6A50B8
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:51:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=dlSai3Bn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300671-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300671-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B39113004D8C
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9681D36895D;
	Fri, 19 Jun 2026 09:51:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A560C366823;
	Fri, 19 Jun 2026 09:51:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781862692; cv=none; b=Wdo4StYWHquFEiXAwOnseRuzbvsuX4aP9xNnlANaTbO293daSL8Wg2j0J0SrUnfWdy/UnoLp1khPLywAf3HMquQhDO4SFR2OvSgM+uGVTXN9iiPJaH5OAEj/ORsp9/tfv3fp1HBlJeMNdFDKeTKPbitYmbni94xJCpuhR6ntgAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781862692; c=relaxed/simple;
	bh=hEa4mCjhKBsNu+5TxQywgF+7+yMq3PlN0Bh/NN8lcfo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nr7IdivaxU9RuFtAXlhqr12KIregwEIfAF88buAsLTEPqKInjITGwP2W3r1MGGHsD7EekCdJ111CQ3BXFxB1f+hZnbYcbCCjs44Ai9fDVEu/v/yRSYAb7zW+uDWIw8xS/VXNvR3HGjXSH1JhnaLllE8/IXHo3v2FcZYhCrb3+1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dlSai3Bn; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7RGHe1671154;
	Fri, 19 Jun 2026 02:51:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=tZy16LJwW4OpJ0glUmYi9OZ
	ebo8aPvqtLpEf56MAu7g=; b=dlSai3BnpR81eVmP/xGDKIQbVZs7yN2aYpgMeh2
	+TbErJO3ilyA9dEEOhwsHuGqy2xwaIoXP1KHUCS+Lnu1/vmH6YBrGsL0ElBr70yB
	w9zeniGSVpfJ0Rvfy2o76TZz1ROUY7AmZ/5+6LY49OmYkvVjh3kdmN75c3P4xphY
	l5hVhkBCLVMLu9ahou/dtrNdDw6nnPYE+4QNQhCscEBU23q12GDlK1TOHi0VvFw3
	u6xFVhvWIXkSukjA+wVOdcCP+UlFAjb2li/faSSuaNJo0QL5MHQg8Jb8dOilfTdK
	+5b+lWMrBx6Ww935+mkSy8yIDN/lqXHQLYbYLee4WJFKAwQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4evtcb1bm7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 02:51:14 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 19 Jun 2026 02:51:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 19 Jun 2026 02:51:14 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id A3E5E3F7045;
	Fri, 19 Jun 2026 02:51:11 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <rkannoth@marvell.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: [PATCH net v2] octeontx2-af: npc: cn20k: Fix subbank free list indexing for search order
Date: Fri, 19 Jun 2026 15:21:00 +0530
Message-ID: <20260619095100.1864440-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA5MiBTYWx0ZWRfX3zLHvmxxz4G2
 QS+3+9Ydm4oDeP6q5xzkIdyw7KGMkkJD7Y4pcFJqgxn8Z/LQ9Ui1serCpnHF63x5dtZ7Fi0l6yv
 I6lrE5IZ88FNb9kyRME1pLE8VlwhxKM=
X-Proofpoint-GUID: ddFAt839kDkq3RmUfP9zEx8rkHU3e5d0
X-Proofpoint-ORIG-GUID: ddFAt839kDkq3RmUfP9zEx8rkHU3e5d0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA5MiBTYWx0ZWRfX24UiEMYqqTbW
 q1YzpcqKyqt9KimFnXPpd+GPKTMr5MiqUwA95Y9cSCE5x5Wnxa8Mfv8tAkzyGD2Z7CKdmKI2EVK
 APuBr5FWKhm3RbhaZaDowNTUQKIiKhleGyfCbmqIheK2xw8FxoVE1idjxHMfIl/plQpcldwu/Ok
 EgfKVjjmew9EM5JvKs2OtM/iGFnGxje+2Op/X0Sjc9dWgJarNrx643veyJKBH7CQsijQ6IRfYFS
 jzh27rouVVsnmsfREUc4sjcuFfvON6Q38sVuSd5Ny+7dCtQyNUjZ/v91OHapfzVbXhOiSFZNkzI
 BjyLc9ArrRuxCGPVhspbf2f+ssARM1okU8FJPSfxHsVWTj5qG8WyYnpUEBql9an7fuLucHZx60D
 tCSwPVhI3Vd4aOjNfperKylAQQ2qL0n3TBz4HKdEeW1zKVbk83iQSiu0DCcJNfOR4ZdDxTE2/DA
 p/jQmhwaISjT0kneweg==
X-Authority-Analysis: v=2.4 cv=YM2vDxGx c=1 sm=1 tr=0 ts=6a351112 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=W3-A8rqs_R2IxcmWfgIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300671-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:rkannoth@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E059B6A50B8

subbank_srch_order[i] is the physical subbank at search-order slot i,
so each subbank's arr_idx must be i (its slot), not
subbank_srch_order[sb->idx].  The old logic mis-keyed xa_sb_free
and broke allocation traversal order.

Populate arr_idx and xa_sb_free in a single pass over the search
order after subbank structs are initialized.

Fixes: 7ac9d4c4075c ("octeontx2-af: npc: cn20k: add subbank search order control")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
v1 -> v2: Addressed simon comments
	https://lore.kernel.org/netdev/20260619091341.918165-1-horms@kernel.org/
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 51 ++++++++++++++-----
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 354c4e881c6a..51fe82f1343f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -3423,6 +3423,36 @@ static int npc_create_srch_order(int cnt)
 	return 0;
 }
 
+static int npc_subbanks_srch_order_init(struct rvu *rvu)
+{
+	struct npc_subbank *sb;
+	int sb_idx;
+	int i, j;
+	int rc;
+
+	for (i = 0; i < npc_priv->num_subbanks; i++) {
+		sb_idx = subbank_srch_order[i];
+		sb = &npc_priv->sb[sb_idx];
+		sb->arr_idx = i;
+
+		dev_dbg(rvu->dev, "%s: sb->idx=%u sb->arr_idx=%u\n",
+			__func__, sb->idx, sb->arr_idx);
+
+		rc = xa_err(xa_store(&npc_priv->xa_sb_free, sb->arr_idx,
+				     xa_mk_value(sb->idx), GFP_KERNEL));
+		if (rc) {
+			dev_err(rvu->dev,
+				"%s: xa_store(xa_sb_free) failed at slot %d (sb=%d): %d\n",
+				__func__, i, sb_idx, rc);
+			for (j = 0; j < i; j++)
+				xa_erase(&npc_priv->xa_sb_free, j);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
 static void npc_subbank_init(struct rvu *rvu, struct npc_subbank *sb, int idx)
 {
 	mutex_init(&sb->lock);
@@ -3435,16 +3465,6 @@ static void npc_subbank_init(struct rvu *rvu, struct npc_subbank *sb, int idx)
 
 	sb->flags = NPC_SUBBANK_FLAG_FREE;
 	sb->idx = idx;
-	sb->arr_idx = subbank_srch_order[idx];
-
-	dev_dbg(rvu->dev, "%s: sb->idx=%u sb->arr_idx=%u\n",
-		__func__, sb->idx, sb->arr_idx);
-
-	/* Keep first and last subbank at end of free array; so that
-	 * it will be used at last
-	 */
-	xa_store(&npc_priv->xa_sb_free, sb->arr_idx,
-		 xa_mk_value(sb->idx), GFP_KERNEL);
 }
 
 static int npc_pcifunc_map_create(struct rvu *rvu)
@@ -4635,6 +4655,7 @@ static int npc_priv_init(struct rvu *rvu)
 	int num_subbanks, subbank_depth;
 	u64 npc_const1, npc_const2 = 0;
 	struct npc_subbank *sb;
+	int ret = -ENOMEM;
 	u64 cfg;
 	int i;
 
@@ -4727,13 +4748,19 @@ static int npc_priv_init(struct rvu *rvu)
 	for (i = 0, sb = npc_priv->sb; i < num_subbanks; i++, sb++)
 		npc_subbank_init(rvu, sb, i);
 
+	ret = npc_subbanks_srch_order_init(rvu);
+	if (ret)
+		goto fail3;
+
 	/* Get number of pcifuncs in the system */
 	npc_priv->pf_cnt = npc_pcifunc_map_create(rvu);
 	npc_priv->xa_pf2idx_map = kcalloc(npc_priv->pf_cnt,
 					  sizeof(struct xarray),
 					  GFP_KERNEL);
-	if (!npc_priv->xa_pf2idx_map)
+	if (!npc_priv->xa_pf2idx_map) {
+		ret = -ENOMEM;
 		goto fail3;
+	}
 
 	for (i = 0; i < npc_priv->pf_cnt; i++)
 		xa_init_flags(&npc_priv->xa_pf2idx_map[i], XA_FLAGS_ALLOC);
@@ -4760,7 +4787,7 @@ static int npc_priv_init(struct rvu *rvu)
 fail1:
 	kfree(npc_priv);
 	npc_priv = NULL;
-	return -ENOMEM;
+	return ret;
 }
 
 void npc_cn20k_deinit(struct rvu *rvu)
-- 
2.43.0


