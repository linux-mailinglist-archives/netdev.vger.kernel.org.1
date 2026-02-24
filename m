Return-Path: <netdev+bounces-260382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC/lHBlbnWmxOgQAu9opvQ
	(envelope-from <netdev+bounces-260382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:02:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEC8183602
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DBF330CAD6C
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C76E36606B;
	Tue, 24 Feb 2026 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LswusFl0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F02364040;
	Tue, 24 Feb 2026 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920067; cv=none; b=lism0nOpwUzY5UIKtb60xVnJoI8QDReqILVXM5HuyamGO/HsUK7EnHhP5tMBIVFe2rCCYSOsgYCVldxqd4a2xjXQKggiSP0hiDPouwBq9AVMOAi7DnTlKSUJADSeTM8o0mwX48Bb04aNib7WhcnEEkNNYVXZfxIV1S8PuQRT6AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920067; c=relaxed/simple;
	bh=jxLVWxOqQXzWTadl48UrPy2MBQyUCt6t2LSNF/IXR38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/scCzofpNVRaoiyw50TFjP6KfX72tXR94j3VjvovMCrF1Eg+2DzqcMJhYiJktz7HLd+/8wQHOSzyDRgSV4QygcLtWI79r2rSSBonrfedDUag8kwKpKWhZ+KkGmURhiuLNPu6XPKGoOCyGviO5gwmG2qgbP/mtBt/HD78HQNwY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LswusFl0; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NIE8Yd3329915;
	Tue, 24 Feb 2026 00:00:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
	F8byz1wTpygU7Bw97iEaJerFl1VUsR+uBCyZGHQ7Sc=; b=LswusFl09sH40fmmI
	fzSXZtA9/tyhBP94o6BLQ5zaFspe6Sg8afo/QG9gv6JtmNu5HZ3sJiLpmHt6af/6
	TBwklPDEAFvAumH7Gax2Wt2pZA+z3pE41WaAn2cjbbSxMjaxJMYz2qoKkm8bek2m
	hFCnlG/nu+aWUSouafs0efZ1J72Um7J8f+JocC+WAEd+w9iDXfbuIuA2Dr3+04aR
	mrc4KUqGFE/Lpc+6qvctrlG7u14vnzaHfwaugtip44hGwYSBOLSwgLt4ozj+i5Ci
	ZI6Qdb01GKnatf1v6fNFloupKFaRX9QktXE4xj2dF8sKNSQbrWLVYkTNwNH0oKz3
	HmHCQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cgd2mkea0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 00:00:57 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Feb 2026 00:00:55 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 24 Feb 2026 00:00:55 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 381F83F70D4;
	Tue, 24 Feb 2026 00:00:44 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        Suman Ghosh
	<sumang@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next v9 03/13] octeontx2-af: npc: cn20k: Add default profile
Date: Tue, 24 Feb 2026 13:29:59 +0530
Message-ID: <20260224080009.4147301-4-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224080009.4147301-1-rkannoth@marvell.com>
References: <20260224080009.4147301-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=AfW83nXG c=1 sm=1 tr=0 ts=699d5ab9 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=NGP3fZmBk5oLfH1lOsUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: pd6x6IxdNu-Jw_KJRDS4ZjzAhsOg2cV9
X-Proofpoint-GUID: pd6x6IxdNu-Jw_KJRDS4ZjzAhsOg2cV9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA2OCBTYWx0ZWRfXxFex/3muiICf
 s+mulGxVVTFGyjaoyroBccuhHq60VpT7o6bn1HZ5k3uRfyu0pfp3rMCgl858h16czCM1D/q5GRA
 m4X8RxXvN/bpr42d+2yrEiPcPKM0Ce9ontbbEFVeRs+jqzzD/etXw2+npKbiZI/RnZn1baf8jNx
 sybyv91zqp2viwDQq0IsZkhbesrT57BFQom7gP+xJEVQqIMXmAAQeR75TCBSvjrHGvnEA79XLXp
 jxkl7fe+cA8jLrk9TqaEDK73WknMlf7j8TjkYQqnJzUnoLk7VMDEV45qtcfxZNS8J57xMy488uE
 nw3blCbCmK/rxpTNT+YCDNx9tVGYisWPfyEA97KkCju0MFjEmbAiQ2MxmFojo/DoFRzp+g54Gck
 wkPQoXLv7S8eTtxjub6kg7gvUnA0NqwsVAzPQaHpVbcAbHOpqIY1HMhENQ547HEfAim7jfbgHoP
 rEsApxtwDmnsLNg/D5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-260382-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:mid,marvell.com:dkim,marvell.com:email];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 0CEC8183602
X-Rspamd-Action: no action

From: Suman Ghosh <sumang@marvell.com>

Default mkex profile for cn20k silicon. This commit
changes attribute of objects to may_be_unused to
avoid compiler warning

Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 176 +++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  18 ++
 .../marvell/octeontx2/af/npc_profile.h        |  72 +++----
 3 files changed, 229 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index f65db0698c33..0dec50b1e84f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -7,9 +7,13 @@
 #include <linux/xarray.h>
 #include <linux/bitfield.h>
 
+#include "rvu.h"
+#include "npc.h"
+#include "npc_profile.h"
+#include "rvu_npc_hash.h"
+#include "rvu_npc.h"
 #include "cn20k/npc.h"
 #include "cn20k/reg.h"
-#include "rvu_npc.h"
 
 static struct npc_priv_t npc_priv = {
 	.num_banks = MAX_NUM_BANKS,
@@ -21,6 +25,176 @@ static const char *npc_kw_name[NPC_MCAM_KEY_MAX] = {
 	[NPC_MCAM_KEY_X4] = "X4",
 };
 
+#define KEX_EXTR_CFG(bytesm1, hdr_ofs, ena, key_ofs)		\
+		     (((bytesm1) << 16) | ((hdr_ofs) << 8) | ((ena) << 7) | \
+		     ((key_ofs) & 0x3F))
+
+static struct npc_mcam_kex_extr npc_mkex_extr_default = {
+	.mkex_sign = MKEX_SIGN,
+	.name = "default",
+	.kpu_version = NPC_KPU_PROFILE_VER,
+	.keyx_cfg = {
+		/* nibble: LA..LE (ltype only) + Error code + Channel */
+		[NIX_INTF_RX] = ((u64)NPC_MCAM_KEY_DYN << 32) |
+			NPC_PARSE_NIBBLE_INTF_RX |
+				 NPC_PARSE_NIBBLE_ERRCODE,
+
+		/* nibble: LA..LE (ltype only) */
+		[NIX_INTF_TX] = ((u64)NPC_MCAM_KEY_X2 << 32) |
+			NPC_PARSE_NIBBLE_INTF_TX,
+	},
+	.intf_extr_lid = {
+	/* Default RX MCAM KEX profile */
+	[NIX_INTF_RX] = { NPC_LID_LA, NPC_LID_LA, NPC_LID_LB, NPC_LID_LB,
+			  NPC_LID_LC, NPC_LID_LC, NPC_LID_LD },
+	[NIX_INTF_TX] = { NPC_LID_LA, NPC_LID_LA, NPC_LID_LB, NPC_LID_LB,
+			  NPC_LID_LC, NPC_LID_LD },
+	},
+	.intf_extr_lt = {
+	/* Default RX MCAM KEX profile */
+	[NIX_INTF_RX] = {
+		[0] = {
+			/* Layer A: Ethernet: */
+			[NPC_LT_LA_ETHER] =
+				/* DMAC: 6 bytes, KW1[63:15] */
+				KEX_EXTR_CFG(0x05, 0x0, 0x1,
+					     NPC_KEXOF_DMAC + 1),
+			[NPC_LT_LA_CPT_HDR] =
+				/* DMAC: 6 bytes, KW1[63:15] */
+				KEX_EXTR_CFG(0x05, 0x0, 0x1,
+					     NPC_KEXOF_DMAC + 1),
+		},
+		[1] = {
+			/* Layer A: Ethernet: */
+			[NPC_LT_LA_ETHER] =
+				/* Ethertype: 2 bytes, KW0[63:48] */
+				KEX_EXTR_CFG(0x01, 0xc, 0x1, 0x6),
+			[NPC_LT_LA_CPT_HDR] =
+				/* Ethertype: 2 bytes, KW0[63:48] */
+				KEX_EXTR_CFG(0x01, 0xc, 0x1, 0x6),
+		},
+		[2] = {
+			/* Layer B: Single VLAN (CTAG) */
+			[NPC_LT_LB_CTAG] =
+				/* CTAG VLAN: 2 bytes, KW1[15:0] */
+				KEX_EXTR_CFG(0x01, 0x2, 0x1, 0x8),
+			/* Layer B: Stacked VLAN (STAG|QinQ) */
+			[NPC_LT_LB_STAG_QINQ] =
+				/* Outer VLAN: 2 bytes, KW1[15:0] */
+				KEX_EXTR_CFG(0x01, 0x2, 0x1, 0x8),
+			[NPC_LT_LB_FDSA] =
+				/* SWITCH PORT: 1 byte, KW1[7:0] */
+				KEX_EXTR_CFG(0x0, 0x1, 0x1, 0x8),
+		},
+		[3] = {
+			[NPC_LT_LB_CTAG] =
+				/* Ethertype: 2 bytes, KW0[63:48] */
+				KEX_EXTR_CFG(0x01, 0x4, 0x1, 0x6),
+			[NPC_LT_LB_STAG_QINQ] =
+				/* Ethertype: 2 bytes, KW0[63:48] */
+				KEX_EXTR_CFG(0x01, 0x8, 0x1, 0x6),
+			[NPC_LT_LB_FDSA] =
+				/* Ethertype: 2 bytes, KW0[63:48] */
+				KEX_EXTR_CFG(0x01, 0x4, 0x1, 0x6),
+		},
+		[4] = {
+			/* Layer C: IPv4 */
+			[NPC_LT_LC_IP] =
+				/* SIP+DIP: 8 bytes, KW3[7:0], KW2[63:8] */
+				KEX_EXTR_CFG(0x07, 0xc, 0x1, 0x11),
+			/* Layer C: IPv6 */
+			[NPC_LT_LC_IP6] =
+				/* Everything up to SADDR: 8 bytes, KW3[7:0],
+				 * KW2[63:8]
+				 */
+				KEX_EXTR_CFG(0x07, 0x0, 0x1, 0x11),
+		},
+		[5] = {
+			[NPC_LT_LC_IP] =
+				/* TOS: 1 byte, KW2[7:0] */
+				KEX_EXTR_CFG(0x0, 0x1, 0x1, 0x10),
+		},
+		[6] = {
+			/* Layer D:UDP */
+			[NPC_LT_LD_UDP] =
+				/* SPORT+DPORT: 4 bytes, KW3[39:8] */
+				KEX_EXTR_CFG(0x3, 0x0, 0x1, 0x19),
+			/* Layer D:TCP */
+			[NPC_LT_LD_TCP] =
+				/* SPORT+DPORT: 4 bytes, KW3[39:8] */
+				KEX_EXTR_CFG(0x3, 0x0, 0x1, 0x19),
+		},
+	},
+	/* Default TX MCAM KEX profile */
+	[NIX_INTF_TX] = {
+		[0] = {
+			/* Layer A: NIX_INST_HDR_S + Ethernet */
+			/* NIX appends 8 bytes of NIX_INST_HDR_S at the
+			 * start of each TX packet supplied to NPC.
+			 */
+			[NPC_LT_LA_IH_NIX_ETHER] =
+				/* PF_FUNC: 2B , KW0 [47:32] */
+				KEX_EXTR_CFG(0x01, 0x0, 0x1, 0x4),
+			/* Layer A: HiGig2: */
+			[NPC_LT_LA_IH_NIX_HIGIG2_ETHER] =
+				/* PF_FUNC: 2B , KW0 [47:32] */
+				KEX_EXTR_CFG(0x01, 0x0, 0x1, 0x4),
+		},
+		[1] = {
+			[NPC_LT_LA_IH_NIX_ETHER] =
+				/* SQ_ID 3 bytes, KW1[63:16] */
+				KEX_EXTR_CFG(0x02, 0x02, 0x1, 0xa),
+			[NPC_LT_LA_IH_NIX_HIGIG2_ETHER] =
+				/* VID: 2 bytes, KW1[31:16] */
+				KEX_EXTR_CFG(0x01, 0x10, 0x1, 0xa),
+		},
+		[2] = {
+			/* Layer B: Single VLAN (CTAG) */
+			[NPC_LT_LB_CTAG] =
+				/* CTAG VLAN[2..3] KW0[63:48] */
+				KEX_EXTR_CFG(0x01, 0x2, 0x1, 0x6),
+			/* Layer B: Stacked VLAN (STAG|QinQ) */
+			[NPC_LT_LB_STAG_QINQ] =
+				/* Outer VLAN: 2 bytes, KW0[63:48] */
+				KEX_EXTR_CFG(0x01, 0x2, 0x1, 0x6),
+		},
+		[3] = {
+			[NPC_LT_LB_CTAG] =
+				/* CTAG VLAN[2..3] KW1[15:0] */
+				KEX_EXTR_CFG(0x01, 0x4, 0x1, 0x8),
+			[NPC_LT_LB_STAG_QINQ] =
+				/* Outer VLAN: 2 Bytes, KW1[15:0] */
+				KEX_EXTR_CFG(0x01, 0x8, 0x1, 0x8),
+		},
+		[4] = {
+			/* Layer C: IPv4 */
+			[NPC_LT_LC_IP] =
+				/* SIP+DIP: 8 bytes, KW2[63:0] */
+				KEX_EXTR_CFG(0x07, 0xc, 0x1, 0x10),
+			/* Layer C: IPv6 */
+			[NPC_LT_LC_IP6] =
+				/* Everything up to SADDR: 8 bytes, KW2[63:0] */
+				KEX_EXTR_CFG(0x07, 0x0, 0x1, 0x10),
+		},
+		[5] = {
+			/* Layer D:UDP */
+			[NPC_LT_LD_UDP] =
+				/* SPORT+DPORT: 4 bytes, KW3[31:0] */
+				KEX_EXTR_CFG(0x3, 0x0, 0x1, 0x18),
+			/* Layer D:TCP */
+			[NPC_LT_LD_TCP] =
+				/* SPORT+DPORT: 4 bytes, KW3[31:0] */
+				KEX_EXTR_CFG(0x3, 0x0, 0x1, 0x18),
+		},
+	},
+	},
+};
+
+struct npc_mcam_kex_extr *npc_mkex_extr_default_get(void)
+{
+	return &npc_mkex_extr_default;
+}
+
 static void npc_config_kpmcam(struct rvu *rvu, int blkaddr,
 			      const struct npc_kpu_profile_cam *kpucam,
 			      int kpm, int entry)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index fb4d5f463461..7cfca5cfe5fa 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -130,6 +130,23 @@ struct npc_kpm_action0 {
 #endif
 };
 
+struct npc_mcam_kex_extr {
+	/* MKEX Profle Header */
+	u64 mkex_sign; /* "mcam-kex-profile" (8 bytes/ASCII characters) */
+	u8 name[MKEX_NAME_LEN];   /* MKEX Profile name */
+	u64 cpu_model;   /* Format as profiled by CPU hardware */
+	u64 kpu_version; /* KPU firmware/profile version */
+	u64 reserved; /* Reserved for extension */
+
+	/* MKEX Profle Data */
+	u64 keyx_cfg[NPC_MAX_INTF]; /* NPC_AF_INTF(0..1)_KEX_CFG */
+#define NPC_MAX_EXTRACTOR	24
+	/* MKEX Extractor data */
+	u64 intf_extr_lid[NPC_MAX_INTF][NPC_MAX_EXTRACTOR];
+	/* KEX configuration per extractor */
+	u64 intf_extr_lt[NPC_MAX_INTF][NPC_MAX_EXTRACTOR][NPC_MAX_LT];
+} __packed;
+
 struct rvu;
 
 struct npc_priv_t *npc_priv_get(void);
@@ -144,4 +161,5 @@ int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
 			    bool contig, int count);
 int npc_cn20k_idx_free(struct rvu *rvu, u16 *mcam_idx, int count);
 void npc_cn20k_parser_profile_init(struct rvu *rvu, int blkaddr);
+struct npc_mcam_kex_extr *npc_mkex_extr_default_get(void);
 #endif /* NPC_CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h b/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h
index 41de72c8607f..561b01fcdbde 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h
@@ -489,7 +489,7 @@ enum NPC_ERRLEV_E {
 		0, 0, 0, 0,			\
 	}
 
-static struct npc_kpu_profile_action ikpu_action_entries[] = {
+static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		12, 16, 20, 0, 0,
@@ -1068,7 +1068,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu1_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu1_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -1878,7 +1878,7 @@ static struct npc_kpu_profile_cam kpu1_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu2_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu2_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -2823,7 +2823,7 @@ static struct npc_kpu_profile_cam kpu2_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu3_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu3_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -3804,7 +3804,7 @@ static struct npc_kpu_profile_cam kpu3_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu4_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu4_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -4119,7 +4119,7 @@ static struct npc_kpu_profile_cam kpu4_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu5_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu5_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -5172,7 +5172,7 @@ static struct npc_kpu_profile_cam kpu5_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu6_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu6_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -5901,7 +5901,7 @@ static struct npc_kpu_profile_cam kpu6_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu7_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu7_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -6252,7 +6252,7 @@ static struct npc_kpu_profile_cam kpu7_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu8_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu8_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -7089,7 +7089,7 @@ static struct npc_kpu_profile_cam kpu8_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu9_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu9_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -7575,7 +7575,7 @@ static struct npc_kpu_profile_cam kpu9_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu10_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu10_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -7746,7 +7746,7 @@ static struct npc_kpu_profile_cam kpu10_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu11_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu11_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -8061,7 +8061,7 @@ static struct npc_kpu_profile_cam kpu11_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu12_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu12_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -8322,7 +8322,7 @@ static struct npc_kpu_profile_cam kpu12_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu13_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu13_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -8340,7 +8340,7 @@ static struct npc_kpu_profile_cam kpu13_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu14_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu14_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -8358,7 +8358,7 @@ static struct npc_kpu_profile_cam kpu14_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu15_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu15_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -8565,7 +8565,7 @@ static struct npc_kpu_profile_cam kpu15_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu16_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu16_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -8628,7 +8628,7 @@ static struct npc_kpu_profile_cam kpu16_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu1_action_entries[] = {
+static struct npc_kpu_profile_action kpu1_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -9368,7 +9368,7 @@ static struct npc_kpu_profile_action kpu1_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu2_action_entries[] = {
+static struct npc_kpu_profile_action kpu2_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -10209,7 +10209,7 @@ static struct npc_kpu_profile_action kpu2_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu3_action_entries[] = {
+static struct npc_kpu_profile_action kpu3_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -11082,7 +11082,7 @@ static struct npc_kpu_profile_action kpu3_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu4_action_entries[] = {
+static struct npc_kpu_profile_action kpu4_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -11363,7 +11363,7 @@ static struct npc_kpu_profile_action kpu4_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu5_action_entries[] = {
+static struct npc_kpu_profile_action kpu5_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -12300,7 +12300,7 @@ static struct npc_kpu_profile_action kpu5_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu6_action_entries[] = {
+static struct npc_kpu_profile_action kpu6_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -12949,7 +12949,7 @@ static struct npc_kpu_profile_action kpu6_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu7_action_entries[] = {
+static struct npc_kpu_profile_action kpu7_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -13262,7 +13262,7 @@ static struct npc_kpu_profile_action kpu7_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu8_action_entries[] = {
+static struct npc_kpu_profile_action kpu8_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -14007,7 +14007,7 @@ static struct npc_kpu_profile_action kpu8_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu9_action_entries[] = {
+static struct npc_kpu_profile_action kpu9_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -14440,7 +14440,7 @@ static struct npc_kpu_profile_action kpu9_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu10_action_entries[] = {
+static struct npc_kpu_profile_action kpu10_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -14593,7 +14593,7 @@ static struct npc_kpu_profile_action kpu10_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu11_action_entries[] = {
+static struct npc_kpu_profile_action kpu11_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -14874,7 +14874,7 @@ static struct npc_kpu_profile_action kpu11_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu12_action_entries[] = {
+static struct npc_kpu_profile_action kpu12_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -15107,7 +15107,7 @@ static struct npc_kpu_profile_action kpu12_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu13_action_entries[] = {
+static struct npc_kpu_profile_action kpu13_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -15124,7 +15124,7 @@ static struct npc_kpu_profile_action kpu13_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu14_action_entries[] = {
+static struct npc_kpu_profile_action kpu14_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -15141,7 +15141,7 @@ static struct npc_kpu_profile_action kpu14_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu15_action_entries[] = {
+static struct npc_kpu_profile_action kpu15_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -15326,7 +15326,7 @@ static struct npc_kpu_profile_action kpu15_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu16_action_entries[] = {
+static struct npc_kpu_profile_action kpu16_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -15383,7 +15383,7 @@ static struct npc_kpu_profile_action kpu16_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile npc_kpu_profiles[] = {
+static struct npc_kpu_profile npc_kpu_profiles[] __maybe_unused = {
 	{
 		ARRAY_SIZE(kpu1_cam_entries),
 		ARRAY_SIZE(kpu1_action_entries),
@@ -15482,7 +15482,7 @@ static struct npc_kpu_profile npc_kpu_profiles[] = {
 	},
 };
 
-static struct npc_lt_def_cfg npc_lt_defaults = {
+static struct npc_lt_def_cfg npc_lt_defaults __maybe_unused = {
 	.rx_ol2 = {
 		.lid = NPC_LID_LA,
 		.ltype_match = NPC_LT_LA_ETHER,
@@ -15604,7 +15604,7 @@ static struct npc_lt_def_cfg npc_lt_defaults = {
 	},
 };
 
-static struct npc_mcam_kex npc_mkex_default = {
+static struct npc_mcam_kex npc_mkex_default __maybe_unused = {
 	.mkex_sign = MKEX_SIGN,
 	.name = "default",
 	.kpu_version = NPC_KPU_PROFILE_VER,
-- 
2.43.0


