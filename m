Return-Path: <netdev+bounces-279642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN8HDi6R5WlNlgEAu9opvQ
	(envelope-from <netdev+bounces-279642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:36:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B876542653A
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE881301C963
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2101378D78;
	Mon, 20 Apr 2026 02:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ugv1e4xb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAC337881D;
	Mon, 20 Apr 2026 02:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776652543; cv=none; b=nOLXtA3iQhVU3I4l43AWrbZ0JDWh+XRSuEn1/PH4rDts4nU+yn04E/jrRXIQqOZo+6gzJoXIWWliFklGuzpUXBQKscghpMrfysLz+BYD6rjHqMP9Gpy4ZgBP6DWzD/92aIrCiQcRkvtvoTejAUJYgeWfYsPBN5ylNUl42jLCKJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776652543; c=relaxed/simple;
	bh=nYEcYNZJoUw3wy4NlQppXqao/5vo/lVMyHqT7uOXo+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmI4hzl5i3I5jwR1N8rM6jzReF4euxg4or5FmKWkPTgx4gSVMDLQoCVPmQyhuxaFpOMASek/OqvI842qz0rUvqvycnIr+f2Xgk9QHhr/OYkEXm6IrIZr4LlaE34r074mAjPzSCHG+yUS7GRXVAM4TECSl9G017HHp9KZWMJUfLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ugv1e4xb; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K2IU2e2059171;
	Sun, 19 Apr 2026 19:35:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
	iVIdVllkSLKyLa67P0D6uPYv24IsN7s9waK3UooU0M=; b=Ugv1e4xbXfeAwY3iU
	y93furGC36AcQosY+4PawBO7/fZM/V9X2W2FonmYJDqBXoWpHvAQ8LxItR/iE3SG
	/L2goV+a6qrC17+/l7cHx/M1/VVgj6DcE3XcOWTEyP/q3LYOn/iAMFi7b/MJAu47
	9IY45+eVUglFAzcerTPjXkD/mbLo/0ZW9HRki2e28RaMzh3+bKzzQcOky7HhWGHW
	ax509HvoYYMWJe31F/mUvNwggeFtyUSvy5R1nUpKaY8O+axS+Ru3xklOU6yiBUUl
	nPCD5g4Vdvg9kjmK7u13KUiP/fLPCfkOfA8ivqAvYhe2c07omVI97iwQ5gZFxJIx
	Fm7TQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dnb8180qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Apr 2026 19:35:26 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 19 Apr 2026 19:35:25 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 19 Apr 2026 19:35:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 19 Apr 2026 19:35:24 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 66E773F7041;
	Sun, 19 Apr 2026 19:35:21 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <dan.carpenter@linaro.org>, Ratheesh Kannoth <rkannoth@marvell.com>,
        "Suman
 Ghosh" <sumang@marvell.com>
Subject: [PATCH v2 net 06/11] octeontx2-af: npc: cn20k: Clear MCAM entries by index and key width
Date: Mon, 20 Apr 2026 08:04:37 +0530
Message-ID: <20260420023442.3295891-7-rkannoth@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDAyMyBTYWx0ZWRfX42SmV2NFeKzC
 uNwqSnB4U21snqCrO1WEtb2HCFGj+nyFeG89Tn7TWjTEgEI4zvdmtm8q4eHU722GTHHtcAF9bHF
 xVFW3v7AyRt7B9Ag0eAcXvrqDFkM6vU7ROz4NHLgiy8WAddWe2JhbiRwiYQr1MD/JYpvVs6KhfA
 NphNSKMfvVxAf3nW6XZCcsWeRPIXh4eru80iET+jji+R+7KU4SdA6c0sl+xoIgTMban6kP7rzHV
 NJzcqBy49p9lnN0Ms/jYKDyMCAkwiam17fLmn+LmMzV+iuY9YF4qMGIfIn4nhSDbxzmvtFdVgwU
 icwHie6EmpsjYantov8vK46dNeDVu11v/rP/eM0zCeAJYIBOrCy8HP/GdNpmUKaGhHLBkJByFEn
 V19gRD7Kr+ZMvbnrMapBG0CyGzvvAoc5gCJbIzlbaFjuhnWedMQwsxF9tKBETCQ5NAnpbRDfBXL
 otLWnBnBbVB2kIuLsDg==
X-Proofpoint-GUID: 9vHG2z_KGvXy-FfsxkAAmSKV0n86UuAz
X-Authority-Analysis: v=2.4 cv=W6wIkxWk c=1 sm=1 tr=0 ts=69e590ee cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=MjTODloqs2dhJEbYUhsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 9vHG2z_KGvXy-FfsxkAAmSKV0n86UuAz
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279642-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B876542653A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the old four-argument CN20K MCAM clear with a per-bank static
helper and npc_cn20k_clear_mcam_entry() that takes a logical MCAM index,
resolves the key width via npc_mcam_idx_2_key_type(), and clears either
one bank (X2) or every bank (X4).
Call it from npc_clear_mcam_entry() on cn20k and log when key-type lookup
fails. Use the per-bank helper from npc_cn20k_config_mcam_entry() for
pre-program clears.
For loopback VFs, use the promisc MCAM index as ucast_idx when copying
RSS action for promisc, matching cn20k default-rule layout.

Cc: Suman Ghosh <sumang@marvell.com>
Fixes: 6d1e70282f76 ("octeontx2-af: npc: cn20k: Use common APIs")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 36 ++++++++++++++++---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  3 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 17 +++++++--
 3 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 705fe7a877e6..7bfd39fe0f5e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -842,8 +842,8 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 	return 0;
 }
 
-void
-npc_cn20k_clear_mcam_entry(struct rvu *rvu, int blkaddr, int bank, int index)
+static void
+npc_clear_x2_entry(struct rvu *rvu, int blkaddr, int bank, int index)
 {
 	rvu_write64(rvu, blkaddr,
 		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_INTF_EXT(index, bank, 1),
@@ -877,6 +877,32 @@ npc_cn20k_clear_mcam_entry(struct rvu *rvu, int blkaddr, int bank, int index)
 		    NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(index, bank), 0);
 }
 
+int
+npc_cn20k_clear_mcam_entry(struct rvu *rvu, int blkaddr, int mcam_idx)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	int bank = npc_get_bank(mcam, mcam_idx);
+	u8 kw_type, index;
+
+	if (npc_mcam_idx_2_key_type(rvu, mcam_idx, &kw_type))
+		return -EINVAL;
+
+	index = mcam_idx & (mcam->banksize - 1);
+
+	if (kw_type == NPC_MCAM_KEY_X2) {
+		npc_clear_x2_entry(rvu, blkaddr, bank, index);
+		return 0;
+	}
+
+	/* For NPC_MCAM_KEY_X4 keys, both the banks
+	 * need to be programmed with the same value.
+	 */
+	for (bank = 0; bank < mcam->banks_per_entry; bank++)
+		npc_clear_x2_entry(rvu, blkaddr, bank, index);
+
+	return 0;
+}
+
 static void npc_cn20k_get_keyword(struct cn20k_mcam_entry *entry, int idx,
 				  u64 *cam0, u64 *cam1)
 {
@@ -1071,7 +1097,7 @@ int npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 	 */
 	if (kw_type == NPC_MCAM_KEY_X2) {
 		/* Clear mcam entry to avoid writes being suppressed by NPC */
-		npc_cn20k_clear_mcam_entry(rvu, blkaddr, bank, mcam_idx);
+		npc_clear_x2_entry(rvu, blkaddr, bank, mcam_idx);
 		npc_cn20k_config_kw_x2(rvu, mcam, blkaddr,
 				       mcam_idx, intf, entry,
 				       bank, kw_type, kw, req_kw_type);
@@ -1096,8 +1122,8 @@ int npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 	}
 
 	/* Clear mcam entry to avoid writes being suppressed by NPC */
-	npc_cn20k_clear_mcam_entry(rvu, blkaddr, 0, mcam_idx);
-	npc_cn20k_clear_mcam_entry(rvu, blkaddr, 1, mcam_idx);
+	npc_clear_x2_entry(rvu, blkaddr, 0, mcam_idx);
+	npc_clear_x2_entry(rvu, blkaddr, 1, mcam_idx);
 
 	npc_cn20k_config_kw_x4(rvu, mcam, blkaddr,
 			       mcam_idx, intf, entry,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index 8f3eea9cfb1d..2f761b97f91b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -330,8 +330,7 @@ int npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr,
 int npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
 			      struct cn20k_mcam_entry *entry, u8 *intf,
 			      u8 *ena, u8 *hw_prio);
-void npc_cn20k_clear_mcam_entry(struct rvu *rvu, int blkaddr,
-				int bank, int index);
+int npc_cn20k_clear_mcam_entry(struct rvu *rvu, int blkaddr, int index);
 int npc_mcam_idx_2_key_type(struct rvu *rvu, u16 mcam_idx, u8 *key_type);
 u16 npc_cn20k_vidx2idx(u16 index);
 u16 npc_cn20k_idx2vidx(u16 idx);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 762fafd4ccb7..0a2191fda614 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -259,6 +259,13 @@ static void npc_clear_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 	int bank = npc_get_bank(mcam, index);
 	int actbank = bank;
 
+	if (is_cn20k(rvu->pdev)) {
+		if (npc_cn20k_clear_mcam_entry(rvu, blkaddr, index))
+			dev_err(rvu->dev, "%s Failed to enable mcam %u\n",
+				__func__, index);
+		return;
+	}
+
 	index &= (mcam->banksize - 1);
 	for (; bank < (actbank + mcam->banks_per_entry); bank++) {
 		rvu_write64(rvu, blkaddr,
@@ -753,9 +760,15 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
 
 	/* If the corresponding PF's ucast action is RSS,
 	 * use the same action for promisc also
+	 * Please note that for lbk(s) "index" and "ucast_idx"
+	 * will be same.
 	 */
-	ucast_idx = npc_get_nixlf_mcam_index(mcam, pcifunc,
-					     nixlf, NIXLF_UCAST_ENTRY);
+	if (is_lbk_vf(rvu, pcifunc))
+		ucast_idx = index;
+	else
+		ucast_idx = npc_get_nixlf_mcam_index(mcam, pcifunc,
+						     nixlf, NIXLF_UCAST_ENTRY);
+
 	if (is_mcam_entry_enabled(rvu, mcam, blkaddr, ucast_idx))
 		*(u64 *)&action = npc_get_mcam_action(rvu, mcam,
 						      blkaddr, ucast_idx);
-- 
2.43.0


