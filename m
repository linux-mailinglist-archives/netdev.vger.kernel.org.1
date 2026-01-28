Return-Path: <netdev+bounces-254134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FULIZ23eWlHygEAu9opvQ
	(envelope-from <netdev+bounces-254134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:15:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 439D89DA13
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E07830041E1
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FC833D4F0;
	Wed, 28 Jan 2026 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KqqHaGRR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC60D3271E0;
	Wed, 28 Jan 2026 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769584425; cv=none; b=ZIzjdCfbQqa6i7KfPPJtDIG0J5dA5EOX7Fcq7qqv6ZkJWnxaCtYn0pw1vmL/WL8M6OQcx+zcMUPn/u0VHPjlpJKrONaVphisk0nQkHMgjfUo8un2bDNyK/fPfYpahRBpKfIa30Z3lXYhuR5Z4WNgGgSPO0sY9e+8umyooUzwGUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769584425; c=relaxed/simple;
	bh=y7u9Dbx/Ize/95KIKquELBmzWj9erblO6q9twl0c4gI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtApfnqIEcqDH+SmrWGDVlIPqL3qbllvgHGArZiPCqSITFKm9ym2EIjQxxm0HPGE3tJ9fdOzWrdPkrNUpa9V4xThpBdv6n156tA7LkhYr5q5TRGWJmUfCQBWNCZpTwp7ZjBHB3+UhILAtknA4HAvCEWfZXXuE8W8kmwTTfFUjL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KqqHaGRR; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S1MwOf3583354;
	Tue, 27 Jan 2026 23:13:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
	W/MdbyciwXS98NAmSK/PahT6hPSf0a5PugEWgvdW+w=; b=KqqHaGRRtPQllQLSG
	bNX1+Ez/VgL10uS3Y9+slkMjvN7p+WTX0m9QvppdtQaa1wTB69h2SW6saeYMH35N
	ist76qbu250SerWlMQCwDGlsfT6pI8o1CltKXCMDonKJI80IkawbD5E7rHJ1Chbk
	oP0mRJJYoZ/70+DmGbYhn79ekbF1pMMb08vvSwGFeWJku7gSSjvXOZswVD2n4J5Q
	L5Ch1C2wYsQRTnwl7EhNk4iGMz0phbwTYOZioSnsCBH+dQXWVJA0ySXQ+WhnXXEs
	LSmwWGJT9k1jyBbJ2e9E5mfKCld8Tm5XByMpDHW2/rEKOEc+6Acmwap1NzofF/CE
	wT8+g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4by8r68kcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 23:13:31 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 23:13:30 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 23:13:30 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 64D953F7106;
	Tue, 27 Jan 2026 23:13:27 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v6 10/13] octeontx2-af: npc: cn20k: Allocate MCAM entry for flow installation
Date: Wed, 28 Jan 2026 12:42:32 +0530
Message-ID: <20260128071235.3577206-11-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128071235.3577206-1-rkannoth@marvell.com>
References: <20260128071235.3577206-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Ka/fcAYD c=1 sm=1 tr=0 ts=6979b71b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=R86mbzlVWIuRp1_vrRQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA1NyBTYWx0ZWRfX5KLRIR7+c17r
 AoeRXJ5q3aJHi3spBPvhB1EzxyPFKvnE0CN8PhCx9lRJiUdbaWxan39Sm3+XTM2FKTHBwdNrdTp
 q3fd7InaaRYu6CZszQGlfo1xGUDRELW7GNvXvGFcuEWLdFsiVcN1wKEI70jFCQ9KkJHb6q3ICui
 J50SJI+anA0p940t0tZJlpEXwKbQXzcuXAWiyj98VdMGn5WEhMO4ygQkXBHC2DLxY8isBpdft1r
 MMbmUtyhZkU6CbxIBT1rcdMKrPQEz/DieZN3+1RP+P5ztAawdm7WGDAplM9T1HEhp5hW7rzyMRs
 kdK3QCVpjR1aKw1ibDgmOzAsJpiqtstgYlNcl4Q92NiJYbcDHZL5xVihFC2Vmyram4WdgzAj0Df
 efZu3zEPifPFNYjJ6clIbr93WL/pVDBFxD/4E9XWAa0FkA+aFEMnad5wy4qbvV7lHnW8bl+/TR0
 BNZqD4E7owIg15kB+3w==
X-Proofpoint-GUID: jM6uZvOyYzwdg8h0NqT8M4cKs1qtETSl
X-Proofpoint-ORIG-GUID: jM6uZvOyYzwdg8h0NqT8M4cKs1qtETSl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_01,2026-01-27_03,2025-10-01_01
X-Rspamd-Server: lfdr
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254134-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 439D89DA13
X-Rspamd-Action: no action

In CN20K, the PF/VF driver is unaware of the NPC MCAM entry type (x2/x4)
required for a particular TC rule when the user installs rules through the
TC command. This forces the PF/VF driver to first query the AF driver for
the rule size, then allocate an entry, and finally install the flow. This
sequence requires three mailbox request/response exchanges from the PF. To
speed up the installation, the `install_flow` mailbox request message is
extended with additional fields that allow the AF driver to determine the
required NPC MCAM entry type, allocate the MCAM entry, and complete the
flow installation in a single step.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 184 ++++++++++--
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |   5 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  48 ++++
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |   4 +
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 133 ++++++++-
 .../marvell/octeontx2/af/rvu_npc_fs.h         |  12 +
 .../marvell/octeontx2/nic/otx2_flows.c        | 265 +++++++++++++++++-
 7 files changed, 594 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 642336b0d476..8322427c8390 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -14,6 +14,7 @@
 #include "rvu_npc.h"
 #include "cn20k/npc.h"
 #include "cn20k/reg.h"
+#include "rvu_npc_fs.h"
 
 static struct npc_priv_t npc_priv = {
 	.num_banks = MAX_NUM_BANKS,
@@ -799,7 +800,7 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 		cfg = rvu_read64(rvu, blkaddr,
 				 NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx,
 								   bank));
-		hw_prio = cfg & GENMASK_ULL(14, 8);
+		hw_prio = cfg & GENMASK_ULL(30, 24);
 		cfg = enable ? 1 : 0;
 		cfg |= hw_prio;
 		rvu_write64(rvu, blkaddr,
@@ -815,7 +816,7 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 		cfg = rvu_read64(rvu, blkaddr,
 				 NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx,
 								   bank));
-		hw_prio = cfg & GENMASK_ULL(14, 8);
+		hw_prio = cfg & GENMASK_ULL(30, 24);
 		cfg = enable ? 1 : 0;
 		cfg |= hw_prio;
 		rvu_write64(rvu, blkaddr,
@@ -882,25 +883,33 @@ static void npc_cn20k_get_keyword(struct cn20k_mcam_entry *entry, int idx,
 	*cam0 = ~*cam1 & kw_mask;
 }
 
-/*-----------------------------------------------------------------------------|
- *Kex type  |  mcam entry   |  cam1	   |	cam 0	|| <----- output ----> |
- *profile   |  len	    | (key type)   | (key type)	|| len	  |   type     |
- *-----------------------------------------------------------------------------|
- *X2	    |  256 (X2)	    |  001b	   |	110b	|| X2	  |    X2      |
- *-----------------------------------------------------------------------------|
- *X4	    |  256 (X2)	    |  000b	   |	000b	|| X2	  |  DYNAMIC   |
- *-----------------------------------------------------------------------------|
- *X4	    |  512 (X4)	    |  010b	   |	101b	|| X4	  |    X4      |
- *-----------------------------------------------------------------------------|
- *DYN	    |  256 (X2)	    |  000b	   |	000b	|| X2	  |  DYNAMIC   |
- *-----------------------------------------------------------------------------|
- *DYN	    |  512 (X4)	    |  010b	   |	101b	|| X4	  |    X4      |
- *-----------------------------------------------------------------------------|
+/*-------------------------------------------------------------------------
+ *Kex type|  mcam	|  cam1	|cam0   | req_kwtype||<----- output >	  |
+ * in     |		|	|	|	    ||		|	  |
+ * profile|  len	|	|	|	    ||len	| type    |
+ *-------------------------------------------------------------------------
+ *X2	|  256 (X2)	|  001b	|110b	| 0	    ||X2	| X2      |
+ *------------------------------------------------------------------------|
+ *X4	|  256 (X2)	|  000b	|000b	| 0	    ||X2	| DYN     |
+ *------------------------------------------------------------------------|
+ *X4	|  512 (X4)	|  010b	|101b	| 0	    ||X4	| X4      |
+ *------------------------------------------------------------------------|
+ *DYN	|  256 (X2)	|  000b	|000b	| 0	    ||X2	| DYN     |
+ *------------------------------------------------------------------------|
+ *DYN	|  512 (X4)	|  010b	|101b	| 0	    ||X4	| X4      |
+ *------------------------------------------------------------------------|
+ *X4	|  256 (X2)	|  000b	|000b	| X2	    ||DYN	| DYN     |
+ *------------------------------------------------------------------------|
+ *DYNC	|  256 (X2)	|  000b	|000b	| X2	    ||DYN	| DYN     |
+ *------------------------------------------------------------------------|
+ * X2	|  512 (X4)	|  xxxb	|xxxb	| X4	    ||INVAL	| INVAL   |
+ *------------------------------------------------------------------------|
  */
 static void npc_cn20k_config_kw_x2(struct rvu *rvu, struct npc_mcam *mcam,
 				   int blkaddr, int index, u8 intf,
 				   struct cn20k_mcam_entry *entry,
-				   int bank, u8 kw_type, int kw)
+				   int bank, u8 kw_type, int kw,
+				   u8 req_kw_type)
 {
 	u64 intf_ext = 0, intf_ext_mask = 0;
 	u8 tx_intf_mask = ~intf & 0x3;
@@ -925,6 +934,15 @@ static void npc_cn20k_config_kw_x2(struct rvu *rvu, struct npc_mcam *mcam,
 		kw_type_mask = 0;
 	}
 
+	/* Say, we need to write x2 keyword in an x4 subbank.
+	 * req_kw_type will be x2, and kw_type will be x4.
+	 * So in the case ignore kw bits in mcam.
+	 */
+	if (kw_type == NPC_MCAM_KEY_X4 && req_kw_type == NPC_MCAM_KEY_X2) {
+		kw_type = 0;
+		kw_type_mask = 0;
+	}
+
 	intf_ext = ((u64)kw_type << 16) | tx_intf;
 	intf_ext_mask = (((u64)kw_type_mask  << 16) & GENMASK_ULL(18, 16)) |
 		tx_intf_mask;
@@ -972,14 +990,15 @@ static void npc_cn20k_config_kw_x2(struct rvu *rvu, struct npc_mcam *mcam,
 static void npc_cn20k_config_kw_x4(struct rvu *rvu, struct npc_mcam *mcam,
 				   int blkaddr, int index, u8 intf,
 				   struct cn20k_mcam_entry *entry,
-				   u8 kw_type)
+				   u8 kw_type, u8 req_kw_type)
 {
 	int kw = 0, bank;
 
 	for (bank = 0; bank < mcam->banks_per_entry; bank++, kw = kw + 4)
 		npc_cn20k_config_kw_x2(rvu, mcam, blkaddr,
 				       index, intf,
-				       entry, bank, kw_type, kw);
+				       entry, bank, kw_type,
+				       kw, req_kw_type);
 }
 
 static void
@@ -989,7 +1008,7 @@ npc_cn20k_set_mcam_bank_cfg(struct rvu *rvu, int blkaddr, int mcam_idx,
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	u64 bank_cfg;
 
-	bank_cfg = (u64)hw_prio << 8;
+	bank_cfg = (u64)hw_prio << 24;
 	if (enable)
 		bank_cfg |= 0x1;
 
@@ -1012,7 +1031,7 @@ npc_cn20k_set_mcam_bank_cfg(struct rvu *rvu, int blkaddr, int mcam_idx,
 
 void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 				 u8 intf, struct cn20k_mcam_entry *entry,
-				 bool enable, u8 hw_prio)
+				 bool enable, u8 hw_prio, u8 req_kw_type)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	int mcam_idx = index % mcam->banksize;
@@ -1035,27 +1054,34 @@ void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 		npc_cn20k_clear_mcam_entry(rvu, blkaddr, bank, mcam_idx);
 		npc_cn20k_config_kw_x2(rvu, mcam, blkaddr,
 				       mcam_idx, intf, entry,
-				       bank, kw_type, kw);
+				       bank, kw_type, kw, req_kw_type);
 		/* Set 'action' */
 		rvu_write64(rvu, blkaddr,
 			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
 								  bank, 0),
 			    entry->action);
 
+		/* Set 'action2' for inline receive */
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
+								  bank, 2),
+			    entry->action2);
+
 		/* Set TAG 'action' */
 		rvu_write64(rvu, blkaddr,
 			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
 								  bank, 1),
 			    entry->vtag_action);
-
 		goto set_cfg;
 	}
+
 	/* Clear mcam entry to avoid writes being suppressed by NPC */
 	npc_cn20k_clear_mcam_entry(rvu, blkaddr, 0, mcam_idx);
 	npc_cn20k_clear_mcam_entry(rvu, blkaddr, 1, mcam_idx);
 
 	npc_cn20k_config_kw_x4(rvu, mcam, blkaddr,
-			       mcam_idx, intf, entry, kw_type);
+			       mcam_idx, intf, entry,
+			       kw_type, req_kw_type);
 	for (bank = 0; bank < mcam->banks_per_entry; bank++) {
 		/* Set 'action' */
 		rvu_write64(rvu, blkaddr,
@@ -1068,6 +1094,12 @@ void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
 								  bank, 1),
 			    entry->vtag_action);
+
+		/* Set 'action2' for inline receive */
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
+								  bank, 2),
+			    entry->action2);
 	}
 
 set_cfg:
@@ -1156,7 +1188,7 @@ void npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
 	bank_cfg = rvu_read64(rvu, blkaddr,
 			      NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(index, bank));
 	*ena = bank_cfg & 0x1;
-	*hw_prio = (bank_cfg & GENMASK_ULL(14, 8)) >> 8;
+	*hw_prio = (bank_cfg & GENMASK_ULL(30, 24)) >> 24;
 	if (kw_type == NPC_MCAM_KEY_X2) {
 		cam1 = rvu_read64(rvu, blkaddr,
 				  NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W0_EXT(index,
@@ -1292,7 +1324,7 @@ int rvu_mbox_handler_npc_cn20k_mcam_write_entry(struct rvu *rvu,
 
 	npc_cn20k_config_mcam_entry(rvu, blkaddr, req->entry, nix_intf,
 				    &req->entry_data, req->enable_entry,
-				    req->hw_prio);
+				    req->hw_prio, req->req_kw_type);
 
 	rc = 0;
 exit:
@@ -1370,7 +1402,7 @@ int rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry(struct rvu *rvu,
 
 	npc_cn20k_config_mcam_entry(rvu, blkaddr, entry, nix_intf,
 				    &req->entry_data, req->enable_entry,
-				    req->hw_prio);
+				    req->hw_prio, req->req_kw_type);
 
 	mutex_unlock(&mcam->lock);
 
@@ -1378,6 +1410,14 @@ int rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry(struct rvu *rvu,
 	return 0;
 }
 
+static int rvu_npc_get_base_steer_rule_type(struct rvu *rvu, u16 pcifunc)
+{
+	if (is_lbk_vf(rvu, pcifunc))
+		return NIXLF_PROMISC_ENTRY;
+
+	return NIXLF_UCAST_ENTRY;
+}
+
 int rvu_mbox_handler_npc_cn20k_read_base_steer_rule(struct rvu *rvu,
 						    struct msg_req *req,
 						    struct npc_cn20k_mcam_read_base_rule_rsp *rsp)
@@ -1387,6 +1427,7 @@ int rvu_mbox_handler_npc_cn20k_read_base_steer_rule(struct rvu *rvu,
 	u16 pcifunc = req->hdr.pcifunc;
 	u8 intf, enable, hw_prio;
 	struct rvu_pfvf *pfvf;
+	int rl_type;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
@@ -1412,9 +1453,11 @@ int rvu_mbox_handler_npc_cn20k_read_base_steer_rule(struct rvu *rvu,
 		mutex_unlock(&mcam->lock);
 		goto out;
 	}
+
+	rl_type = rvu_npc_get_base_steer_rule_type(rvu, pcifunc);
+
 	/* Read the default ucast entry if there is no pkt steering rule */
-	index = npc_get_nixlf_mcam_index(mcam, pcifunc, nixlf,
-					 NIXLF_UCAST_ENTRY);
+	index = npc_get_nixlf_mcam_index(mcam, pcifunc, nixlf, rl_type);
 read_entry:
 	/* Read the mcam entry */
 	npc_cn20k_read_mcam_entry(rvu, blkaddr, index,
@@ -3885,6 +3928,89 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 	return  set ? 0 : -ESRCH;
 }
 
+int rvu_mbox_handler_npc_get_pfl_info(struct rvu *rvu, struct msg_req *req,
+				      struct npc_get_pfl_info_rsp *rsp)
+{
+	if (!is_cn20k(rvu->pdev)) {
+		dev_err(rvu->dev, "Mbox support is only for cn20k\n");
+		return -EOPNOTSUPP;
+	}
+
+	rsp->kw_type = npc_priv.kw;
+	rsp->x4_slots = npc_priv.bank_depth;
+	return 0;
+}
+
+int rvu_mbox_handler_npc_get_num_kws(struct rvu *rvu,
+				     struct npc_get_num_kws_req *req,
+				     struct npc_get_num_kws_rsp *rsp)
+{
+	struct rvu_npc_mcam_rule dummy = { 0 };
+	struct cn20k_mcam_entry cn20k_entry = { 0 };
+	struct mcam_entry_mdata mdata = { };
+	struct mcam_entry entry = { 0 };
+	struct npc_install_flow_req *fl;
+	int i, cnt = 0, blkaddr;
+
+	if (!is_cn20k(rvu->pdev)) {
+		dev_err(rvu->dev, "Mbox support is only for cn20k\n");
+		return -EOPNOTSUPP;
+	}
+
+	fl = &req->fl;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (blkaddr < 0) {
+		dev_err(rvu->dev, "%s: NPC block not implemented\n", __func__);
+		return NPC_MCAM_INVALID_REQ;
+	}
+
+	npc_populate_mcam_mdata(rvu, &mdata, &cn20k_entry, &entry);
+
+	npc_update_flow(rvu, &mdata, fl->features, &fl->packet,
+			&fl->mask, &dummy, fl->intf, blkaddr);
+
+	/* Find the most significant word valid. Traverse from
+	 * MSB to LSB, check if cam0 or cam1 is set
+	 */
+	for (i = NPC_CN20K_MAX_KWS_IN_KEY - 1; i >= 0; i--) {
+		if (cn20k_entry.kw[i] || cn20k_entry.kw_mask[i]) {
+			cnt = i + 1;
+			break;
+		}
+	}
+
+	rsp->kws = cnt;
+
+	return 0;
+}
+
+int rvu_mbox_handler_npc_get_dft_rl_idxs(struct rvu *rvu, struct msg_req *req,
+					 struct npc_get_dft_rl_idxs_rsp *rsp)
+{
+	u16 bcast, mcast, promisc, ucast;
+	u16 pcifunc;
+	int rc;
+
+	if (!is_cn20k(rvu->pdev)) {
+		dev_err(rvu->dev, "Mbox support is only for cn20k\n");
+		return -EOPNOTSUPP;
+	}
+
+	pcifunc = req->hdr.pcifunc;
+
+	rc = npc_cn20k_dft_rules_idx_get(rvu, pcifunc, &bcast, &mcast,
+					 &promisc, &ucast);
+	if (rc)
+		return rc;
+
+	rsp->bcast = bcast;
+	rsp->mcast = mcast;
+	rsp->promisc = promisc;
+	rsp->ucast = ucast;
+	return 0;
+}
+
 static bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc)
 {
 	return is_pf_cgxmapped(rvu, rvu_get_pf(rvu->pdev, pcifunc)) ||
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index 178051b2535a..12a76aaa5317 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -321,9 +321,8 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				u16 *mcast, u16 *promisc, u16 *ucast);
 
 void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
-				 u8 intf,
-				 struct cn20k_mcam_entry *entry,
-				 bool enable, u8 hw_prio);
+				 u8 intf, struct cn20k_mcam_entry *entry,
+				 bool enable, u8 hw_prio, u8 req_kw_type);
 void npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 				 int index, bool enable);
 void npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 1638bf4e15fd..79cb1c752c2b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -301,6 +301,15 @@ M(NPC_CN20K_MCAM_READ_BASE_RULE, 0x601a, npc_cn20k_read_base_steer_rule,       \
 M(NPC_MCAM_DEFRAG,	     0x601b,	npc_defrag,			\
 					msg_req,			\
 					msg_rsp)			\
+M(NPC_MCAM_GET_NUM_KWS, 0x601c, npc_get_num_kws,		\
+				npc_get_num_kws_req,		\
+				npc_get_num_kws_rsp)		\
+M(NPC_MCAM_GET_DFT_RL_IDXS, 0x601d, npc_get_dft_rl_idxs,	\
+					msg_req,		\
+					npc_get_dft_rl_idxs_rsp)\
+M(NPC_MCAM_GET_NPC_PFL_INFO, 0x601e, npc_get_pfl_info,		\
+					msg_req,		\
+					npc_get_pfl_info_rsp)	\
 /* NIX mbox IDs (range 0x8000 - 0xFFFF) */				\
 M(NIX_LF_ALLOC,		0x8000, nix_lf_alloc,				\
 				 nix_lf_alloc_req, nix_lf_alloc_rsp)	\
@@ -1598,6 +1607,7 @@ struct cn20k_mcam_entry {
 	u64	kw_mask[NPC_CN20K_MAX_KWS_IN_KEY];
 	u64	action;
 	u64	vtag_action;
+	u64	action2;
 };
 
 struct npc_cn20k_mcam_write_entry_req {
@@ -1608,6 +1618,7 @@ struct npc_cn20k_mcam_write_entry_req {
 	u8  intf;	 /* Rx or Tx interface */
 	u8  enable_entry;/* Enable this MCAM entry ? */
 	u8  hw_prio;	 /* hardware priority, valid for cn20k */
+	u8  req_kw_type; /* Type of kw which should be written */
 	u64 reserved;	 /* reserved for future use */
 };
 
@@ -1694,6 +1705,7 @@ struct npc_cn20k_mcam_alloc_and_write_entry_req {
 	u8  enable_entry;/* Enable this MCAM entry ? */
 	u8  hw_prio;	 /* hardware priority, valid for cn20k */
 	u8  virt;	 /* Allocate virtual index */
+	u8  req_kw_type; /* Key type to be written */
 	u16 reserved[4]; /* reserved for future use */
 };
 
@@ -1861,11 +1873,47 @@ struct npc_install_flow_req {
 	/* old counter value */
 	u16 cntr_val;
 	u8 hw_prio;
+	u8  req_kw_type; /* Key type to be written */
+	u8 alloc_entry;	/* only for cn20k */
+	u16 ref_prio;
+	u16 ref_entry;
 };
 
 struct npc_install_flow_rsp {
 	struct mbox_msghdr hdr;
 	int counter; /* negative if no counter else counter number */
+	u16 entry;
+	u8 kw_type;
+};
+
+struct npc_get_num_kws_req {
+	struct mbox_msghdr hdr;
+	struct npc_install_flow_req fl;
+	u32 rsvd[4];
+};
+
+struct npc_get_num_kws_rsp {
+	struct mbox_msghdr hdr;
+	int kws;
+	u32 rsvd[4];
+};
+
+struct npc_get_dft_rl_idxs_rsp {
+	struct mbox_msghdr hdr;
+	u16 bcast;
+	u16 mcast;
+	u16 promisc;
+	u16 ucast;
+	u16 vf_ucast;
+	u16 rsvd[7];
+};
+
+struct npc_get_pfl_info_rsp {
+	struct mbox_msghdr hdr;
+	u16 x4_slots;
+	u8 kw_type;
+	u8 rsvd1[3];
+	u32 rsvd2[4];
 };
 
 struct npc_delete_flow_req {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 0ceba03ca5e7..6607d803ea53 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2674,6 +2674,10 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 	if (!is_cn20k(rvu->pdev))
 		goto not_cn20k;
 
+	/* Only x2 or x4 key types are accepted */
+	if (req->kw_type != NPC_MCAM_KEY_X2 && req->kw_type != NPC_MCAM_KEY_X4)
+		return NPC_MCAM_INVALID_REQ;
+
 	/* The below table is being followed during allocation,
 	 *
 	 * 1. ref_entry == 0 && prio == HIGH && count == 1 : user wants to
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 82afb4993346..7a48ba1db5e9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1071,11 +1071,11 @@ static void npc_update_vlan_features(struct rvu *rvu,
 				 ~0ULL, 0, intf);
 }
 
-static void npc_update_flow(struct rvu *rvu, struct mcam_entry_mdata *mdata,
-			    u64 features, struct flow_msg *pkt,
-			    struct flow_msg *mask,
-			    struct rvu_npc_mcam_rule *output, u8 intf,
-			    int blkaddr)
+void npc_update_flow(struct rvu *rvu, struct mcam_entry_mdata *mdata,
+		     u64 features, struct flow_msg *pkt,
+		     struct flow_msg *mask,
+		     struct rvu_npc_mcam_rule *output, u8 intf,
+		     int blkaddr)
 {
 	u64 dmac_mask = ether_addr_to_u64(mask->dmac);
 	u64 smac_mask = ether_addr_to_u64(mask->smac);
@@ -1304,7 +1304,7 @@ static int npc_mcast_update_action_index(struct rvu *rvu, struct npc_install_flo
 	return 0;
 }
 
-static void
+void
 npc_populate_mcam_mdata(struct rvu *rvu,
 			struct mcam_entry_mdata *mdata,
 			struct cn20k_mcam_entry *cn20k_entry,
@@ -1549,6 +1549,7 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 	cn20k_wreq.intf = req->intf;
 	cn20k_wreq.enable_entry = (u8)enable;
 	cn20k_wreq.hw_prio = req->hw_prio;
+	cn20k_wreq.req_kw_type = req->req_kw_type;
 
 update_rule:
 
@@ -1642,6 +1643,75 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 	return 0;
 }
 
+static int
+rvu_npc_free_entry_for_flow_install(struct rvu *rvu, u16 pcifunc,
+				    bool free_entry, int mcam_idx)
+{
+	struct npc_mcam_free_entry_req free_req;
+	struct msg_rsp rsp;
+	int rc;
+
+	if (!free_entry)
+		return 0;
+
+	free_req.hdr.pcifunc = pcifunc;
+	free_req.entry = mcam_idx;
+	rc = rvu_mbox_handler_npc_mcam_free_entry(rvu, &free_req, &rsp);
+	return rc;
+}
+
+static int
+rvu_npc_alloc_entry_for_flow_install(struct rvu *rvu,
+				     struct npc_install_flow_req *fl_req,
+				     u16 *mcam_idx, u8 *kw_type,
+				     bool *allocated)
+{
+	struct npc_mcam_alloc_entry_req entry_req;
+	struct npc_mcam_alloc_entry_rsp entry_rsp;
+	struct npc_get_num_kws_req kws_req;
+	struct npc_get_num_kws_rsp kws_rsp;
+	int off, kw_bits, rc;
+	u8 *src, *dst;
+
+	if (!is_cn20k(rvu->pdev))
+		return 0;
+
+	if (!fl_req->alloc_entry)
+		return 0;
+
+	off = offsetof(struct npc_install_flow_req, packet);
+	dst = (u8 *)&kws_req.fl + off;
+	src = (u8 *)fl_req + off;
+	memcpy(dst, src, sizeof(struct npc_install_flow_req) - off);
+	rc = rvu_mbox_handler_npc_get_num_kws(rvu, &kws_req, &kws_rsp);
+	if (rc)
+		return rc;
+
+	kw_bits = kws_rsp.kws * 64;
+
+	*kw_type = NPC_MCAM_KEY_X2;
+	if (kw_bits > 256)
+		*kw_type = NPC_MCAM_KEY_X4;
+
+	memset(&entry_req, 0, sizeof(entry_req));
+	memset(&entry_rsp, 0, sizeof(entry_rsp));
+
+	entry_req.hdr.pcifunc = fl_req->hdr.pcifunc;
+	entry_req.ref_prio = fl_req->ref_prio;
+	entry_req.ref_entry = fl_req->ref_entry;
+	entry_req.kw_type = *kw_type;
+	entry_req.count = 1;
+	rc = rvu_mbox_handler_npc_mcam_alloc_entry(rvu,
+						   &entry_req,
+						   &entry_rsp);
+	if (rc)
+		return rc;
+
+	*mcam_idx = entry_rsp.entry_list[0];
+	*allocated = true;
+	return 0;
+}
+
 int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 				      struct npc_install_flow_req *req,
 				      struct npc_install_flow_rsp *rsp)
@@ -1652,11 +1722,11 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 	int blkaddr, nixlf, err;
 	struct rvu_pfvf *pfvf;
 	bool pf_set_vfs_mac = false;
+	bool allocated = false;
 	bool enable = true;
+	u8 kw_type;
 	u16 target;
 
-	req->entry = npc_cn20k_vidx2idx(req->entry);
-
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0) {
 		dev_err(rvu->dev, "%s: NPC block not implemented\n", __func__);
@@ -1666,6 +1736,17 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 	if (!is_npc_interface_valid(rvu, req->intf))
 		return NPC_FLOW_INTF_INVALID;
 
+	err = rvu_npc_alloc_entry_for_flow_install(rvu, req, &req->entry,
+						   &kw_type, &allocated);
+	if (err) {
+		dev_err(rvu->dev,
+			"%s: Error to alloc mcam entry for pcifunc=%#x\n",
+			__func__, req->hdr.pcifunc);
+		return err;
+	}
+
+	req->entry = npc_cn20k_vidx2idx(req->entry);
+
 	/* If DMAC is not extracted in MKEX, rules installed by AF
 	 * can rely on L2MB bit set by hardware protocol checker for
 	 * broadcast and multicast addresses.
@@ -1679,6 +1760,10 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 			dev_warn(rvu->dev,
 				 "%s: mkex profile does not support ucast flow\n",
 				 __func__);
+			rvu_npc_free_entry_for_flow_install(rvu,
+							    req->hdr.pcifunc,
+							    allocated,
+							    req->entry);
 			return NPC_FLOW_NOT_SUPPORTED;
 		}
 
@@ -1686,6 +1771,10 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 			dev_warn(rvu->dev,
 				 "%s: mkex profile does not support bcast/mcast flow",
 				 __func__);
+			rvu_npc_free_entry_for_flow_install(rvu,
+							    req->hdr.pcifunc,
+							    allocated,
+							    req->entry);
 			return NPC_FLOW_NOT_SUPPORTED;
 		}
 
@@ -1695,8 +1784,11 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 	}
 
 process_flow:
-	if (from_vf && req->default_rule)
+	if (from_vf && req->default_rule) {
+		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
+						    allocated, req->entry);
 		return NPC_FLOW_VF_PERM_DENIED;
+	}
 
 	/* Each PF/VF info is maintained in struct rvu_pfvf.
 	 * rvu_pfvf for the target PF/VF needs to be retrieved
@@ -1724,8 +1816,11 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 		req->chan_mask = 0xFFF;
 
 	err = npc_check_unsupported_flows(rvu, req->features, req->intf);
-	if (err)
+	if (err) {
+		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
+						    allocated, req->entry);
 		return NPC_FLOW_NOT_SUPPORTED;
+	}
 
 	pfvf = rvu_get_pfvf(rvu, target);
 
@@ -1744,8 +1839,11 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 
 	/* Proceed if NIXLF is attached or not for TX rules */
 	err = nix_get_nixlf(rvu, target, &nixlf, NULL);
-	if (err && is_npc_intf_rx(req->intf) && !pf_set_vfs_mac)
+	if (err && is_npc_intf_rx(req->intf) && !pf_set_vfs_mac) {
+		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
+						    allocated, req->entry);
 		return NPC_FLOW_NO_NIXLF;
+	}
 
 	/* don't enable rule when nixlf not attached or initialized */
 	if (!(is_nixlf_attached(rvu, target) &&
@@ -1760,20 +1858,31 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 		enable = true;
 
 	/* Do not allow requests from uninitialized VFs */
-	if (from_vf && !enable)
+	if (from_vf && !enable) {
+		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
+						    allocated, req->entry);
 		return NPC_FLOW_VF_NOT_INIT;
+	}
 
 	/* PF sets VF mac & VF NIXLF is not attached, update the mac addr */
 	if (pf_set_vfs_mac && !enable) {
 		ether_addr_copy(pfvf->default_mac, req->packet.dmac);
 		ether_addr_copy(pfvf->mac_addr, req->packet.dmac);
 		set_bit(PF_SET_VF_MAC, &pfvf->flags);
+		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
+						    allocated, req->entry);
 		return 0;
 	}
 
 	mutex_lock(&rswitch->switch_lock);
 	err = npc_install_flow(rvu, blkaddr, target, nixlf, pfvf,
 			       req, rsp, enable, pf_set_vfs_mac);
+	if (err)
+		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
+						    allocated, req->entry);
+
+	rsp->kw_type = kw_type;
+	rsp->entry = req->entry;
 	mutex_unlock(&rswitch->switch_lock);
 
 	return err;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h
index 442287ee7baa..d3ba86c23959 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h
@@ -18,4 +18,16 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
 		      struct mcam_entry_mdata *mdata, u64 val_lo,
 		      u64 val_hi, u64 mask_lo, u64 mask_hi, u8 intf);
 
+void npc_update_flow(struct rvu *rvu, struct mcam_entry_mdata *mdata,
+		     u64 features, struct flow_msg *pkt,
+		     struct flow_msg *mask,
+		     struct rvu_npc_mcam_rule *output, u8 intf,
+		     int blkaddr);
+
+void
+npc_populate_mcam_mdata(struct rvu *rvu,
+			struct mcam_entry_mdata *mdata,
+			struct cn20k_mcam_entry *cn20k_entry,
+			struct mcam_entry *entry);
+
 #endif /* RVU_NPC_FS_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 052d989f2d9a..23372f30dcc2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -37,6 +37,98 @@ static void otx2_clear_ntuple_flow_info(struct otx2_nic *pfvf, struct otx2_flow_
 	flow_cfg->max_flows = 0;
 }
 
+static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, bool *is_x2,
+				  u16 *x4_slots)
+{
+	struct npc_get_pfl_info_rsp *rsp;
+	struct msg_req *req;
+	static struct {
+		bool is_set;
+		bool is_x2;
+		u16 x4_slots;
+	} pfl_info;
+
+	/* Avoid sending mboxes for constant information
+	 * like x4_slots
+	 */
+	if (pfl_info.is_set) {
+		*is_x2 = pfl_info.is_x2;
+		*x4_slots = pfl_info.x4_slots;
+		return 0;
+	}
+
+	mutex_lock(&pfvf->mbox.lock);
+
+	req = otx2_mbox_alloc_msg_npc_get_pfl_info(&pfvf->mbox);
+	if (!req) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -ENOMEM;
+	}
+
+	/* Send message to AF */
+	if (otx2_sync_mbox_msg(&pfvf->mbox)) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -EFAULT;
+	}
+
+	rsp = (struct npc_get_pfl_info_rsp *)otx2_mbox_get_rsp
+		(&pfvf->mbox.mbox, 0, &req->hdr);
+
+	if (IS_ERR(rsp)) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -EFAULT;
+	}
+
+	*is_x2 = (rsp->kw_type == NPC_MCAM_KEY_X2);
+	if (*is_x2)
+		*x4_slots = 0;
+	else
+		*x4_slots = rsp->x4_slots;
+
+	pfl_info.is_x2 = *is_x2;
+	pfl_info.x4_slots = *x4_slots;
+	pfl_info.is_set = true;
+
+	mutex_unlock(&pfvf->mbox.lock);
+	return 0;
+}
+
+static int otx2_get_dft_rl_idx(struct otx2_nic *pfvf, u16 *mcam_idx)
+{
+	struct npc_get_dft_rl_idxs_rsp *rsp;
+	struct msg_req *req;
+
+	mutex_lock(&pfvf->mbox.lock);
+
+	req = otx2_mbox_alloc_msg_npc_get_dft_rl_idxs(&pfvf->mbox);
+	if (!req) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -ENOMEM;
+	}
+
+	/* Send message to AF */
+	if (otx2_sync_mbox_msg(&pfvf->mbox)) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -EINVAL;
+	}
+
+	rsp = (struct npc_get_dft_rl_idxs_rsp *)otx2_mbox_get_rsp
+		(&pfvf->mbox.mbox, 0, &req->hdr);
+
+	if (IS_ERR(rsp)) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -EFAULT;
+	}
+
+	if (is_otx2_lbkvf(pfvf->pdev))
+		*mcam_idx = rsp->promisc;
+	else
+		*mcam_idx = rsp->ucast;
+
+	mutex_unlock(&pfvf->mbox.lock);
+	return 0;
+}
+
 static int otx2_free_ntuple_mcam_entries(struct otx2_nic *pfvf)
 {
 	struct otx2_flow_config *flow_cfg = pfvf->flow_cfg;
@@ -69,7 +161,10 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 	struct otx2_flow_config *flow_cfg = pfvf->flow_cfg;
 	struct npc_mcam_alloc_entry_req *req;
 	struct npc_mcam_alloc_entry_rsp *rsp;
-	int ent, allocated = 0;
+	u16 dft_idx = 0, x4_slots = 0;
+	int ent, allocated = 0, ref;
+	bool is_x2 = false;
+	int rc;
 
 	/* Free current ones and allocate new ones with requested count */
 	otx2_free_ntuple_mcam_entries(pfvf);
@@ -86,6 +181,22 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 		return -ENOMEM;
 	}
 
+	if (is_cn20k(pfvf->pdev)) {
+		rc = otx2_mcam_pfl_info_get(pfvf, &is_x2, &x4_slots);
+		if (rc) {
+			netdev_err(pfvf->netdev, "Error to retrieve profile info\n");
+			return rc;
+		}
+
+		rc = otx2_get_dft_rl_idx(pfvf, &dft_idx);
+		if (rc) {
+			netdev_err(pfvf->netdev,
+				   "Error to retrieve ucast mcam idx for pcifunc %#x\n",
+				   pfvf->pcifunc);
+			return -EFAULT;
+		}
+	}
+
 	mutex_lock(&pfvf->mbox.lock);
 
 	/* In a single request a max of NPC_MAX_NONCONTIG_ENTRIES MCAM entries
@@ -96,18 +207,31 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 		if (!req)
 			goto exit;
 
+		req->kw_type = is_x2 ? NPC_MCAM_KEY_X2 : NPC_MCAM_KEY_X4;
 		req->contig = false;
 		req->count = (count - allocated) > NPC_MAX_NONCONTIG_ENTRIES ?
 				NPC_MAX_NONCONTIG_ENTRIES : count - allocated;
 
+		ref = 0;
+
+		if (is_cn20k(pfvf->pdev)) {
+			req->ref_prio = NPC_MCAM_HIGHER_PRIO;
+			ref = dft_idx;
+		}
+
 		/* Allocate higher priority entries for PFs, so that VF's entries
 		 * will be on top of PF.
 		 */
 		if (!is_otx2_vf(pfvf->pcifunc)) {
 			req->ref_prio = NPC_MCAM_HIGHER_PRIO;
-			req->ref_entry = flow_cfg->def_ent[0];
+			ref = flow_cfg->def_ent[0];
 		}
 
+		if (is_cn20k(pfvf->pdev))
+			ref = is_x2 ? ref : ref & (x4_slots - 1);
+
+		req->ref_entry = ref;
+
 		/* Send message to AF */
 		if (otx2_sync_mbox_msg(&pfvf->mbox))
 			goto exit;
@@ -163,8 +287,24 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	struct npc_get_field_status_rsp *frsp;
 	struct npc_mcam_alloc_entry_req *req;
 	struct npc_mcam_alloc_entry_rsp *rsp;
-	int vf_vlan_max_flows;
-	int ent, count;
+	int vf_vlan_max_flows, count;
+	int rc, ref, prio, ent;
+	u16 dft_idx;
+
+	ref = 0;
+	prio = 0;
+	if (is_cn20k(pfvf->pdev)) {
+		rc = otx2_get_dft_rl_idx(pfvf, &dft_idx);
+		if (rc) {
+			netdev_err(pfvf->netdev,
+				   "Error to retrieve ucast mcam idx for pcifunc %#x\n",
+				   pfvf->pcifunc);
+			return -EFAULT;
+		}
+
+		ref = dft_idx;
+		prio = NPC_MCAM_HIGHER_PRIO;
+	}
 
 	vf_vlan_max_flows = pfvf->total_vfs * OTX2_PER_VF_VLAN_FLOWS;
 	count = flow_cfg->ucast_flt_cnt +
@@ -183,8 +323,11 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 		return -ENOMEM;
 	}
 
+	req->kw_type = NPC_MCAM_KEY_X2;
 	req->contig = false;
 	req->count = count;
+	req->ref_prio = prio;
+	req->ref_entry = ref;
 
 	/* Send message to AF */
 	if (otx2_sync_mbox_msg(&pfvf->mbox)) {
@@ -819,7 +962,7 @@ static int otx2_prepare_ipv6_flow(struct ethtool_rx_flow_spec *fsp,
 }
 
 static int otx2_prepare_flow_request(struct ethtool_rx_flow_spec *fsp,
-			      struct npc_install_flow_req *req)
+				     struct npc_install_flow_req *req)
 {
 	struct ethhdr *eth_mask = &fsp->m_u.ether_spec;
 	struct ethhdr *eth_hdr = &fsp->h_u.ether_spec;
@@ -945,6 +1088,58 @@ static int otx2_prepare_flow_request(struct ethtool_rx_flow_spec *fsp,
 	return 0;
 }
 
+static int otx2_get_kw_type(struct otx2_nic *pfvf,
+			    struct npc_install_flow_req *fl_req,
+			    u8 *kw_type)
+{
+	struct npc_get_num_kws_req *req;
+	struct npc_get_num_kws_rsp *rsp;
+	u8 *src, *dst;
+	int off, err;
+	int kw_bits;
+
+	off = offsetof(struct npc_install_flow_req, packet);
+
+	mutex_lock(&pfvf->mbox.lock);
+
+	req = otx2_mbox_alloc_msg_npc_get_num_kws(&pfvf->mbox);
+	if (!req) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -EINVAL;
+	}
+
+	dst = (u8 *)&req->fl + off;
+	src = (u8 *)fl_req + off;
+
+	memcpy(dst, src, sizeof(struct npc_install_flow_req) - off);
+
+	err = otx2_sync_mbox_msg(&pfvf->mbox);
+	if (err)  {
+		mutex_unlock(&pfvf->mbox.lock);
+		netdev_err(pfvf->netdev,
+			   "Error to get default number of keywords\n");
+		return err;
+	}
+
+	rsp = (struct npc_get_num_kws_rsp *)otx2_mbox_get_rsp
+		(&pfvf->mbox.mbox, 0, &req->hdr);
+	if (IS_ERR(rsp)) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -EFAULT;
+	}
+
+	kw_bits = rsp->kws * 64;
+
+	if (kw_bits <= 256)
+		*kw_type = NPC_MCAM_KEY_X2;
+	else
+		*kw_type = NPC_MCAM_KEY_X4;
+
+	mutex_unlock(&pfvf->mbox.lock);
+
+	return 0;
+}
+
 static int otx2_is_flow_rule_dmacfilter(struct otx2_nic *pfvf,
 					struct ethtool_rx_flow_spec *fsp)
 {
@@ -973,12 +1168,41 @@ static int otx2_is_flow_rule_dmacfilter(struct otx2_nic *pfvf,
 
 static int otx2_add_flow_msg(struct otx2_nic *pfvf, struct otx2_flow *flow)
 {
+	struct otx2_flow_config *flow_cfg = pfvf->flow_cfg;
+	struct npc_install_flow_req *req, treq = { 0 };
 	u64 ring_cookie = flow->flow_spec.ring_cookie;
 #ifdef CONFIG_DCB
 	int vlan_prio, qidx, pfc_rule = 0;
 #endif
-	struct npc_install_flow_req *req;
-	int err, vf = 0;
+	int err, vf = 0, off, sz;
+	bool modify = false;
+	u8 kw_type = 0;
+	u8 *src, *dst;
+	u16 x4_slots;
+	bool is_x2;
+
+	if (is_cn20k(pfvf->pdev)) {
+		err = otx2_mcam_pfl_info_get(pfvf, &is_x2, &x4_slots);
+		if (err) {
+			netdev_err(pfvf->netdev,
+				   "Error to retrieve ucast mcam idx for pcifunc %#x\n",
+				   pfvf->pcifunc);
+			return -EFAULT;
+		}
+
+		if (!is_x2) {
+			err = otx2_prepare_flow_request(&flow->flow_spec,
+							&treq);
+			if (err)
+				return err;
+
+			err = otx2_get_kw_type(pfvf, &treq, &kw_type);
+			if (err)
+				return err;
+
+			modify = true;
+		}
+	}
 
 	mutex_lock(&pfvf->mbox.lock);
 	req = otx2_mbox_alloc_msg_npc_install_flow(&pfvf->mbox);
@@ -987,14 +1211,29 @@ static int otx2_add_flow_msg(struct otx2_nic *pfvf, struct otx2_flow *flow)
 		return -ENOMEM;
 	}
 
-	err = otx2_prepare_flow_request(&flow->flow_spec, req);
-	if (err) {
-		/* free the allocated msg above */
-		otx2_mbox_reset(&pfvf->mbox.mbox, 0);
-		mutex_unlock(&pfvf->mbox.lock);
-		return err;
+	if (modify) {
+		off = offsetof(struct npc_install_flow_req, packet);
+		sz = sizeof(struct npc_install_flow_req) - off;
+		dst = (u8 *)req + off;
+		src = (u8 *)&treq + off;
+
+		memcpy(dst, src, sz);
+		req->req_kw_type = kw_type;
+	} else {
+		err = otx2_prepare_flow_request(&flow->flow_spec, req);
+		if (err) {
+			/* free the allocated msg above */
+			otx2_mbox_reset(&pfvf->mbox.mbox, 0);
+			mutex_unlock(&pfvf->mbox.lock);
+			return err;
+		}
 	}
 
+	netdev_dbg(pfvf->netdev,
+		   "flow entry (%u) installed at loc:%u kw_type=%u\n",
+		   flow_cfg->flow_ent[flow->location],
+		   flow->location, kw_type);
+
 	req->entry = flow->entry;
 	req->intf = NIX_INTF_RX;
 	req->set_cntr = 1;
-- 
2.43.0


