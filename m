Return-Path: <netdev+bounces-247574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA991CFBDD7
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 04:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E90DD30574F4
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 03:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91E82571BE;
	Wed,  7 Jan 2026 03:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kUa5tILw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D09B24A078;
	Wed,  7 Jan 2026 03:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767757164; cv=none; b=SSqjQHtGg6/abqw8ivGGo910U55dVolLmT7b6j4WWqdX30QE4VN1OWV7915dO/GB12syvAWga4uOyb2KZQJETZeEnDHSVfKN8JlWnJgVc6muXYhzRqm0Q96hmE4GK+WHhdk/Ww4h3y+YS4fndMPWyF6nIO+K4/DCODJJuY5ry6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767757164; c=relaxed/simple;
	bh=qq1lpHhzzylAUgflKg1gOCmTuOna74un4rh2nVnfGKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DkqwIwY92cPwAurUbK4BavizePl/Ll3EfsIJsH7sMhgHBMYqi6C7B3hSEIl7Cdcsn38K9p6h0VhcSImO15JBTonM5R5s5y6oj7BqvPeY8pdQVwof1cKG/LiBd9u5RGSlGBRgjjPKITXgBItzvJZTsrDxMVdVkaKiZYPDgaVvyKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kUa5tILw; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606NT1wh774720;
	Tue, 6 Jan 2026 19:39:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
	xlrCiikQC3GSi3/uR0RCG2UYE4MEb8SbYeqjQygbaQ=; b=kUa5tILwUDeWh8J3x
	4FbeKBlM4la+yw8SaUT0GXQDcf8GEmjrL5yyavTLUXBBr5PerV9tfPWHyAGpJfXx
	Zlyyr5Rqz71IlxrZF0ZuaOdb2WuDgqL/1lCLl0UxhHMeTVBNhRbod62DlKmsF3xL
	Eb3iHLJEDnaIrpOzx/pox2/oaxClXjU75B8ZH3778du0r1M4Y7Tf1cpBmptbY7TO
	yA9bx6Mr8dzQ9O5+C68c84NZqRQUMKd8h5gt7Fx5KytIn7ZLSqrwsQLDRWyzODpp
	MyL3oVu4nJeYzNpJFac3DayJYjzkCLj/fRNRGVihtl/gbOCo8Kp9dojI5jqLNmJ5
	NlYmw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bhc3n0cqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 19:39:08 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 6 Jan 2026 19:39:07 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 6 Jan 2026 19:39:07 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id D88973F704F;
	Tue,  6 Jan 2026 19:39:03 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        Suman Ghosh <sumang@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next v2 03/13] octeontx2-af: npc: cn20k: Add default profile
Date: Wed, 7 Jan 2026 09:08:34 +0530
Message-ID: <20260107033844.437026-4-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107033844.437026-1-rkannoth@marvell.com>
References: <20260107033844.437026-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5XbOZcnwghy1o0Hh12XIFAtTziPCEBXw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDAyNyBTYWx0ZWRfX1RhhFIZaiROr
 JndVbQ/TfT8VrDOsQiYgMCebhJrtz+h1OsxoJ757qm27W6fCL2k60Xm2ex013uag17tDwZxv49O
 sRnn/rvlVilFseUKlTnuge6Lqpj8TFgoVLA8nyPySgDapaPOaKaavXBB4XLJh8qcMYrFzdNtuvy
 gIPpTYopIFsY8GAtPM97VWf1TLjLqAKccHokexSXM2y3mXcgol9RYXbvmomlpdnIx+v+7FT1CFO
 hVRL3D3S060BRPMVnLMz/WACUJQPV91afJolt4FIGWeZdFX7ZH8dePykqDp+aldy21yY1n3eLYO
 u/b5m0wl4F50+YdQDFioNLVJ/NQY6JH2aE/5zV6Q4GSHERj1sIm7CvNaTvHO6VXkxQd095vK0X0
 O5pdICcwLbtgAE/f5ZVs5ItmSz/ROLuGZM5p3zicTGTdqBTFboMqQ+TgPq3e8HN4/ZkRfsuMwWy
 kGIwF1nnZs5OZSjaGqA==
X-Authority-Analysis: v=2.4 cv=EOILElZC c=1 sm=1 tr=0 ts=695dd55c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=NGP3fZmBk5oLfH1lOsUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 5XbOZcnwghy1o0Hh12XIFAtTziPCEBXw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01

From: Suman Ghosh <sumang@marvell.com>

Default mkex profile for cn20k silicon. This commit
changes attribute of objects to may_be_unused to
avoid compiler warning

Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 170 +++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  18 ++
 .../marvell/octeontx2/af/npc_profile.h        |  72 ++++----
 3 files changed, 223 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index bc52aafeb6a4..8f3f9cb37333 100644
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
@@ -21,6 +25,170 @@ static const char *npc_kw_name[NPC_MCAM_KEY_MAX] = {
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
+		[NIX_INTF_RX] = ((u64)NPC_MCAM_KEY_DYN << 32) | NPC_CN20K_PARSE_NIBBLE_INTF_RX |
+				 NPC_CN20K_PARSE_NIBBLE_ERRCODE,
+
+		/* nibble: LA..LE (ltype only) */
+		[NIX_INTF_TX] = ((u64)NPC_MCAM_KEY_X2 << 32) | NPC_PARSE_NIBBLE_INTF_TX,
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
+				KEX_EXTR_CFG(0x05, 0x0, 0x1, NPC_KEXOF_DMAC + 1),
+			[NPC_LT_LA_CPT_HDR] =
+				/* DMAC: 6 bytes, KW1[63:15] */
+				KEX_EXTR_CFG(0x05, 0x0, 0x1, NPC_KEXOF_DMAC + 1),
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
+				/* Everything up to SADDR: 8 bytes, KW3[7:0], KW2[63:8] */
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
index 0dfc2d171859..ceeda49dc291 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -82,6 +82,23 @@ struct npc_kpm_action0 {
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
@@ -98,5 +115,6 @@ int npc_cn20k_idx_free(struct rvu *rvu, u16 *mcam_idx, int count);
 int npc_cn20k_search_order_set(struct rvu *rvu, int (*arr)[2], int cnt);
 const int *npc_cn20k_search_order_get(bool *restricted_order);
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


