Return-Path: <netdev+bounces-248447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BDAD08921
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2008301FD9B
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06BA33987D;
	Fri,  9 Jan 2026 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NF0l6Tdi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4379033985D;
	Fri,  9 Jan 2026 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954697; cv=none; b=lTHc2Sqao5Dtp28oF2ut9fucFskQ+tIXS7XEEw1G4cf/P6nQQbifCZ1dKhnnviMfcWdkC27Q/eFIW3Mmth8/dnOnPOT3CZuLTMAbdkj14PJh1WSQCS4XXwqrLckDCdX1FOMesf+KlfPMyvgU3OcHRpx4DpWLzxJ+aQ5mqrO9nOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954697; c=relaxed/simple;
	bh=hvRoOatdLz4eD+UTjcenXojj6NTBQLoGT9GSnTJdiSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hibj8iWM2FWOaRaTQ3HeSNekuMpqM3N8ip3qImXrhiJsLdHwtZ6SlfMkzAba9Hc8CHASiHGugOxa/k+PlGibLowsUm/JdtUslPIwFE0l8Yv8lwzgqcD8ifsPhOYu6YYdXT32U0xzjEPHoRgR9JtEHehUZLoZUoOpqdhZ4Hoda1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NF0l6Tdi; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6093EZqe2938365;
	Fri, 9 Jan 2026 02:31:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=/
	ustlcCd2/vc0nz0e4vkaB2BMkO4iRIal+dWTDbD4M0=; b=NF0l6Tdi7SacOro0i
	EyUqmXzJrRtbzxN5mARPa4rFScWs825OF1hzoKdZVExj6XjHqpsnUTd5fQQ9w8T3
	DTftq1tXtNG6JU8AjNBZcxCaEyrD4Yvgz6ieN5wWGUZqGkxZqI57dPRni9lbYEYu
	IynRspiCVWON2+x7N26oKtaOlIvddv7COw8j8If1BKUBqGQnjYVmiZBr5uKGxIBX
	lHDm4026dyqprMVdyiSeLlh93RBQMa8pZ5iXm68IcxA8Nqxi9wi4HUFLlHroeZRS
	jxaPhTfjOMsVtOjn3ZgtL43L0ZvZsLAFQzd5QwEovsNFJ6M+C2lha8+j4XOLVkDx
	0Sz0g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bhwh2vmv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 02:31:26 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 9 Jan 2026 02:31:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 9 Jan 2026 02:31:40 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 14FB33F70F5;
	Fri,  9 Jan 2026 02:31:22 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v3 02/10] octeontx2-af: switch: Add switch dev to AF mboxes
Date: Fri, 9 Jan 2026 16:00:27 +0530
Message-ID: <20260109103035.2972893-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109103035.2972893-1-rkannoth@marvell.com>
References: <20260109103035.2972893-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: x_P2SM8K9TeSfhnrlxdfBKmD3lOZeC0F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA3NiBTYWx0ZWRfX9h7Ve6mzAmtg
 RLQpBs7elY78thEWsz7g+EoZdFffqTGaP5CQDNyeRkJK6ObjbtV/9mUxEEvwMpU0sjClaQO/IKQ
 TmYrraTrrOrEQ0tJHVAfsxG+FtIZBN71ZpUesPgxJjrnZhd1fdPapOBiDhGDYhMoqi88bptY3kE
 4tPbD8i2CbUZ++l04GKxCkfgM6IZEtraaFDSk4r1dF/TFldxMNV/Apq0fdix959gQ5RK9k1yS8o
 nyshaXuD7gXGSDMjPMmgcOQVxsbdP7a+BQ64jqOlK8S++yilSMVGj0wz3L0zUP7oLQaZrdjPqfd
 Bsr/4T2sBXqzBYJBOc7d+61pautYE8RVZ0WN7z21xT+SXUZ83Ou1WmhGIVERyVWkWcSzsWj6xFQ
 Cnxc5buQXPXQk+RJsr4kXAGSf+6HJBphNX+OICGrp61rE0SlTebGHjRkRS92vKysEN2BfAPw4Az
 3SXCjDQrlRVm0iaBLOQ==
X-Authority-Analysis: v=2.4 cv=ROO+3oi+ c=1 sm=1 tr=0 ts=6960d8fe cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=WBe6_t-ORFUBTklN5yIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: x_P2SM8K9TeSfhnrlxdfBKmD3lOZeC0F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_03,2026-01-08_02,2025-10-01_01

The Marvell switch hardware runs on a Linux OS. Switch
needs various information from AF driver. These mboxes are defined
to query those from AF driver.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/Makefile    |   2 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 119 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 110 +++++++++++++++-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   1 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   4 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  77 +++++++++++-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  11 ++
 .../marvell/octeontx2/af/switch/rvu_sw.c      |  15 +++
 .../marvell/octeontx2/af/switch/rvu_sw.h      |  11 ++
 9 files changed, 344 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/Makefile b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
index 7d9c4050dc32..3254b97545d0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
@@ -12,6 +12,6 @@ rvu_af-y := cgx.o rvu.o rvu_cgx.o rvu_npa.o rvu_nix.o \
 		  rvu_reg.o rvu_npc.o rvu_debugfs.o ptp.o rvu_npc_fs.o \
 		  rvu_cpt.o rvu_devlink.o rpm.o rvu_cn10k.o rvu_switch.o \
 		  rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o mcs_cnf10kb.o \
-		  switch/rvu_sw_l2.o switch/rvu_sw_l3.o switch/rvu_sw_fl.o\
+		  switch/rvu_sw.o switch/rvu_sw_l2.o switch/rvu_sw_l3.o switch/rvu_sw_fl.o \
 		  rvu_rep.o cn20k/mbox_init.o cn20k/nix.o cn20k/debugfs.o \
 		  cn20k/npa.o
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index a439fe17580c..d82d7c1b0926 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -164,6 +164,10 @@ M(FL_NOTIFY,		0x012,  fl_notify,				\
 				fl_notify_req, msg_rsp)		\
 M(FL_GET_STATS,		0x013,  fl_get_stats,				\
 				fl_get_stats_req, fl_get_stats_rsp)	\
+M(GET_IFACE_GET_INFO,	0x014, iface_get_info, msg_req,	\
+				iface_get_info_rsp)			\
+M(SWDEV2AF_NOTIFY,	0x015,  swdev2af_notify,		\
+				swdev2af_notify_req, msg_rsp)		\
 /* CGX mbox IDs (range 0x200 - 0x3FF) */				\
 M(CGX_START_RXTX,	0x200, cgx_start_rxtx, msg_req, msg_rsp)	\
 M(CGX_STOP_RXTX,	0x201, cgx_stop_rxtx, msg_req, msg_rsp)		\
@@ -283,6 +287,14 @@ M(NPC_GET_FIELD_HASH_INFO, 0x6013, npc_get_field_hash_info,
 M(NPC_GET_FIELD_STATUS, 0x6014, npc_get_field_status,                     \
 				   npc_get_field_status_req,              \
 				   npc_get_field_status_rsp)              \
+M(NPC_MCAM_FLOW_DEL_N_FREE,	0x6020, npc_flow_del_n_free,		\
+				 npc_flow_del_n_free_req, msg_rsp)	\
+M(NPC_MCAM_GET_MUL_STATS, 0x6021, npc_mcam_mul_stats,			\
+				   npc_mcam_get_mul_stats_req,		\
+				   npc_mcam_get_mul_stats_rsp)		\
+M(NPC_MCAM_GET_FEATURES, 0x6022, npc_mcam_get_features,			\
+				   msg_req,				\
+				   npc_mcam_get_features_rsp)		\
 /* NIX mbox IDs (range 0x8000 - 0xFFFF) */				\
 M(NIX_LF_ALLOC,		0x8000, nix_lf_alloc,				\
 				 nix_lf_alloc_req, nix_lf_alloc_rsp)	\
@@ -412,6 +424,12 @@ M(MCS_INTR_NOTIFY,	0xE00, mcs_intr_notify, mcs_intr_info, msg_rsp)
 #define MBOX_UP_REP_MESSAGES						\
 M(REP_EVENT_UP_NOTIFY,	0xEF0, rep_event_up_notify, rep_event, msg_rsp) \
 
+#define MBOX_UP_AF2SWDEV_MESSAGES					\
+M(AF2SWDEV,	0xEF1, af2swdev_notify, af2swdev_notify_req, msg_rsp)
+
+#define MBOX_UP_AF2PF_FDB_REFRESH_MESSAGES					\
+M(AF2PF_FDB_REFRESH,  0xEF2, af2pf_fdb_refresh, af2pf_fdb_refresh_req, msg_rsp)
+
 enum {
 #define M(_name, _id, _1, _2, _3) MBOX_MSG_ ## _name = _id,
 MBOX_MESSAGES
@@ -419,6 +437,8 @@ MBOX_UP_CGX_MESSAGES
 MBOX_UP_CPT_MESSAGES
 MBOX_UP_MCS_MESSAGES
 MBOX_UP_REP_MESSAGES
+MBOX_UP_AF2SWDEV_MESSAGES
+MBOX_UP_AF2PF_FDB_REFRESH_MESSAGES
 #undef M
 };
 
@@ -1550,6 +1570,30 @@ struct npc_mcam_alloc_entry_rsp {
 	u16 entry_list[NPC_MAX_NONCONTIG_ENTRIES];
 };
 
+struct npc_flow_del_n_free_req {
+	struct mbox_msghdr hdr;
+	u16 cnt;
+	u16 entry[256]; /* Entry index to be freed */
+};
+
+struct npc_mcam_get_features_rsp {
+	struct mbox_msghdr hdr;
+	u64 rx_features;
+	u64 tx_features;
+};
+
+struct npc_mcam_get_mul_stats_req {
+	struct mbox_msghdr hdr;
+	int cnt;
+	u16 entry[256]; /* mcam entry */
+};
+
+struct npc_mcam_get_mul_stats_rsp {
+	struct mbox_msghdr hdr;
+	int cnt;
+	u64 stat[256];  /* counter stats */
+};
+
 struct npc_mcam_free_entry_req {
 	struct mbox_msghdr hdr;
 	u16 entry; /* Entry index to be freed */
@@ -1789,6 +1833,81 @@ struct fl_get_stats_rsp {
 	u64 pkts_diff;
 };
 
+struct af2swdev_notify_req {
+	struct mbox_msghdr hdr;
+	u64 flags;
+	u32 port_id;
+	u32 switch_id;
+	union {
+		struct {
+			u8 mac[6];
+		};
+		struct {
+			u8 cnt;
+			struct fib_entry entry[16];
+		};
+
+		struct {
+			unsigned long cookie;
+			u64 features;
+			struct fl_tuple tuple;
+		};
+	};
+};
+
+struct af2pf_fdb_refresh_req {
+	struct mbox_msghdr hdr;
+	u16 pcifunc;
+	u8 mac[6];
+};
+
+struct iface_info {
+	u64 is_vf :1;
+	u64 is_sdp :1;
+	u16 pcifunc;
+	u16 rx_chan_base;
+	u16 tx_chan_base;
+	u16 sq_cnt;
+	u16 cq_cnt;
+	u16 rq_cnt;
+	u8 rx_chan_cnt;
+	u8 tx_chan_cnt;
+	u8 tx_link;
+	u8 nix;
+};
+
+struct iface_get_info_rsp {
+	struct  mbox_msghdr hdr;
+	int cnt;
+	struct iface_info info[256 + 32]; /* 32 PFs + 256 Vs */
+};
+
+struct fl_info {
+	unsigned long cookie;
+	u16 mcam_idx[2];
+	u8 dis : 1;
+	u8 uni_di : 1;
+};
+
+struct swdev2af_notify_req {
+	struct  mbox_msghdr hdr;
+	u64 msg_type;
+#define SWDEV2AF_MSG_TYPE_FW_STATUS BIT_ULL(0)
+#define	SWDEV2AF_MSG_TYPE_REFRESH_FDB BIT_ULL(1)
+#define	SWDEV2AF_MSG_TYPE_REFRESH_FL BIT_ULL(2)
+	u16 pcifunc;
+	union {
+		bool fw_up;		// FW_STATUS message
+
+		u8 mac[ETH_ALEN];	// fdb refresh message
+
+		struct {		// fl refresh message
+			int cnt;
+			struct fl_info fl[64];
+		};
+	};
+};
+
 struct flow_msg {
 	unsigned char dmac[6];
 	unsigned char smac[6];
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 2d78e08f985f..6b61742a61b1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1396,7 +1396,6 @@ static void rvu_detach_block(struct rvu *rvu, int pcifunc, int blktype)
 	if (blkaddr < 0)
 		return;
 
-
 	block = &hw->block[blkaddr];
 
 	num_lfs = rvu_get_rsrc_mapcount(pfvf, block->addr);
@@ -1907,6 +1906,115 @@ int rvu_mbox_handler_msix_offset(struct rvu *rvu, struct msg_req *req,
 	return 0;
 }
 
+int rvu_mbox_handler_iface_get_info(struct rvu *rvu, struct msg_req *req,
+				    struct iface_get_info_rsp *rsp)
+{
+	struct iface_info *info;
+	struct rvu_pfvf *pfvf;
+	int pf, vf, numvfs;
+	u16 pcifunc;
+	int tot = 0;
+	u64 cfg;
+
+	info = rsp->info;
+	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
+		cfg = rvu_read64(rvu, BLKADDR_RVUM, RVU_PRIV_PFX_CFG(pf));
+		numvfs = (cfg >> 12) & 0xFF;
+
+		/* Skip not enabled PFs */
+		if (!(cfg & BIT_ULL(20)))
+			goto chk_vfs;
+
+		/* If Admin function, check on VFs */
+		if (cfg & BIT_ULL(21))
+			goto chk_vfs;
+
+		pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
+		pfvf = rvu_get_pfvf(rvu, pcifunc);
+
+		/* Populate iff at least one Tx channel */
+		if (!pfvf->tx_chan_cnt)
+			goto chk_vfs;
+
+		info->is_vf = 0;
+		info->pcifunc = pcifunc;
+		info->rx_chan_base = pfvf->rx_chan_base;
+		info->rx_chan_cnt = pfvf->rx_chan_cnt;
+		info->tx_chan_base = pfvf->tx_chan_base;
+		info->tx_chan_cnt = pfvf->tx_chan_cnt;
+		info->tx_link = nix_get_tx_link(rvu, pcifunc);
+		if (is_sdp_pfvf(rvu, pcifunc))
+			info->is_sdp = 1;
+
+		/* If interfaces are not UP, there are no queues */
+		info->sq_cnt = 0;
+		info->cq_cnt = 0;
+		info->rq_cnt = 0;
+
+		if (pfvf->sq_bmap)
+			info->sq_cnt = bitmap_weight(pfvf->sq_bmap, BITS_PER_LONG * 16);
+
+		if (pfvf->cq_bmap)
+			info->cq_cnt = bitmap_weight(pfvf->cq_bmap, BITS_PER_LONG);
+
+		if (pfvf->rq_bmap)
+			info->rq_cnt = bitmap_weight(pfvf->rq_bmap, BITS_PER_LONG);
+
+		if (pfvf->nix_blkaddr == BLKADDR_NIX0)
+			info->nix = 0;
+		else
+			info->nix = 1;
+
+		info++;
+		tot++;
+
+chk_vfs:
+		for (vf = 0; vf < numvfs; vf++) {
+			pcifunc = rvu_make_pcifunc(rvu->pdev, pf, vf + 1);
+			pfvf = rvu_get_pfvf(rvu, pcifunc);
+
+			if (!pfvf->tx_chan_cnt)
+				continue;
+
+			info->is_vf = 1;
+			info->pcifunc = pcifunc;
+			info->rx_chan_base = pfvf->rx_chan_base;
+			info->rx_chan_cnt = pfvf->rx_chan_cnt;
+			info->tx_chan_base = pfvf->tx_chan_base;
+			info->tx_chan_cnt = pfvf->tx_chan_cnt;
+			info->tx_link = nix_get_tx_link(rvu, pcifunc);
+			if (is_sdp_pfvf(rvu, pcifunc))
+				info->is_sdp = 1;
+
+			/* If interfaces are not UP, there are no queues */
+			info->sq_cnt = 0;
+			info->cq_cnt = 0;
+			info->rq_cnt = 0;
+
+			if (pfvf->sq_bmap)
+				info->sq_cnt = bitmap_weight(pfvf->sq_bmap, BITS_PER_LONG * 16);
+
+			if (pfvf->cq_bmap)
+				info->cq_cnt = bitmap_weight(pfvf->cq_bmap, BITS_PER_LONG);
+
+			if (pfvf->rq_bmap)
+				info->rq_cnt = bitmap_weight(pfvf->rq_bmap, BITS_PER_LONG);
+
+			if (pfvf->nix_blkaddr == BLKADDR_NIX0)
+				info->nix = 0;
+			else
+				info->nix = 1;
+
+			info++;
+
+			tot++;
+		}
+	}
+	rsp->cnt = tot;
+
+	return 0;
+}
+
 int rvu_mbox_handler_free_rsrc_cnt(struct rvu *rvu, struct msg_req *req,
 				   struct free_rsrcs_rsp *rsp)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index e85dac2c806d..4e11cdf5df63 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -1147,6 +1147,7 @@ void rvu_program_channels(struct rvu *rvu);
 
 /* CN10K NIX */
 void rvu_nix_block_cn10k_init(struct rvu *rvu, struct nix_hw *nix_hw);
+int nix_get_tx_link(struct rvu *rvu, u16 pcifunc);
 
 /* CN10K RVU - LMT*/
 void rvu_reset_lmt_map_tbl(struct rvu *rvu, u16 pcifunc);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 2f485a930edd..e2cc33ad2b2c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -31,7 +31,6 @@ static int nix_free_all_bandprof(struct rvu *rvu, u16 pcifunc);
 static void nix_clear_ratelimit_aggr(struct rvu *rvu, struct nix_hw *nix_hw,
 				     u32 leaf_prof);
 static const char *nix_get_ctx_name(int ctype);
-static int nix_get_tx_link(struct rvu *rvu, u16 pcifunc);
 
 enum mc_tbl_sz {
 	MC_TBL_SZ_256,
@@ -2055,7 +2054,7 @@ static void nix_clear_tx_xoff(struct rvu *rvu, int blkaddr,
 	rvu_write64(rvu, blkaddr, reg, 0x0);
 }
 
-static int nix_get_tx_link(struct rvu *rvu, u16 pcifunc)
+int nix_get_tx_link(struct rvu *rvu, u16 pcifunc)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
 	int pf = rvu_get_pf(rvu->pdev, pcifunc);
@@ -5283,7 +5282,6 @@ int rvu_mbox_handler_nix_lf_stop_rx(struct rvu *rvu, struct msg_req *req,
 	/* Disable the interface if it is in any multicast list */
 	nix_mcast_update_mce_entry(rvu, pcifunc, 0);
 
-
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	clear_bit(NIXLF_INITIALIZED, &pfvf->flags);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index c7c70429eb6c..4e2d24069d88 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2815,6 +2815,42 @@ int rvu_mbox_handler_npc_mcam_free_entry(struct rvu *rvu,
 	return rc;
 }
 
+int rvu_mbox_handler_npc_flow_del_n_free(struct rvu *rvu,
+					 struct npc_flow_del_n_free_req *mreq,
+					 struct msg_rsp *rsp)
+{
+	struct npc_mcam_free_entry_req sreq = { 0 };
+	struct npc_delete_flow_req dreq = { 0 };
+	struct npc_delete_flow_rsp drsp = { 0 };
+	int err, ret = 0;
+
+	sreq.hdr.pcifunc = mreq->hdr.pcifunc;
+	dreq.hdr.pcifunc = mreq->hdr.pcifunc;
+
+	if (!mreq->cnt || mreq->cnt > 256) {
+		dev_err(rvu->dev, "Invalid cnt=%d\n", mreq->cnt);
+		return -EINVAL;
+	}
+
+	for (int i = 0; i < mreq->cnt; i++) {
+		dreq.entry = mreq->entry[i];
+		err = rvu_mbox_handler_npc_delete_flow(rvu, &dreq, &drsp);
+		if (err)
+			dev_err(rvu->dev, "delete flow error for i=%d entry=%d\n",
+				i, mreq->entry[i]);
+		ret |= err;
+
+		sreq.entry = mreq->entry[i];
+		err = rvu_mbox_handler_npc_mcam_free_entry(rvu, &sreq, rsp);
+		if (err)
+			dev_err(rvu->dev, "free entry error for i=%d entry=%d\n",
+				i, mreq->entry[i]);
+		ret |= err;
+	}
+
+	return ret;
+}
+
 int rvu_mbox_handler_npc_mcam_read_entry(struct rvu *rvu,
 					 struct npc_mcam_read_entry_req *req,
 					 struct npc_mcam_read_entry_rsp *rsp)
@@ -3029,7 +3065,6 @@ static int __npc_mcam_alloc_counter(struct rvu *rvu,
 	if (!req->contig && req->count > NPC_MAX_NONCONTIG_COUNTERS)
 		return NPC_MCAM_INVALID_REQ;
 
-
 	/* Check if unused counters are available or not */
 	if (!rvu_rsrc_free_count(&mcam->counters)) {
 		return NPC_MCAM_ALLOC_FAILED;
@@ -3577,6 +3612,46 @@ int rvu_mbox_handler_npc_mcam_entry_stats(struct rvu *rvu,
 	return 0;
 }
 
+int rvu_mbox_handler_npc_mcam_mul_stats(struct rvu *rvu,
+					struct npc_mcam_get_mul_stats_req *req,
+					struct npc_mcam_get_mul_stats_rsp *rsp)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	u16 index, cntr;
+	int blkaddr;
+	u64 regval;
+	u32 bank;
+
+	if (!req->cnt || req->cnt > 256) {
+		dev_err(rvu->dev, "%s invalid request cnt=%d\n",
+			__func__, req->cnt);
+		return -EINVAL;
+	}
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (blkaddr < 0)
+		return NPC_MCAM_INVALID_REQ;
+
+	mutex_lock(&mcam->lock);
+
+	for (int i = 0; i < req->cnt; i++) {
+		index = req->entry[i] & (mcam->banksize - 1);
+		bank = npc_get_bank(mcam, req->entry[i]);
+
+		/* read MCAM entry STAT_ACT register */
+		regval = rvu_read64(rvu, blkaddr, NPC_AF_MCAMEX_BANKX_STAT_ACT(index, bank));
+		cntr = regval & 0x1FF;
+
+		rsp->stat[i] = rvu_read64(rvu, blkaddr, NPC_AF_MATCH_STATX(cntr));
+		rsp->stat[i] &= BIT_ULL(48) - 1;
+	}
+
+	rsp->cnt = req->cnt;
+
+	mutex_unlock(&mcam->lock);
+	return 0;
+}
+
 void rvu_npc_clear_ucast_entry(struct rvu *rvu, int pcifunc, int nixlf)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index b56395ac5a74..3d6f780635a5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1549,6 +1549,17 @@ static int npc_delete_flow(struct rvu *rvu, struct rvu_npc_mcam_rule *rule,
 	return rvu_mbox_handler_npc_mcam_dis_entry(rvu, &dis_req, &dis_rsp);
 }
 
+int rvu_mbox_handler_npc_mcam_get_features(struct rvu *rvu,
+					   struct msg_req *req,
+					   struct npc_mcam_get_features_rsp *rsp)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+
+	rsp->rx_features = mcam->rx_features;
+	rsp->tx_features = mcam->tx_features;
+	return 0;
+}
+
 int rvu_mbox_handler_npc_delete_flow(struct rvu *rvu,
 				     struct npc_delete_flow_req *req,
 				     struct npc_delete_flow_rsp *rsp)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
new file mode 100644
index 000000000000..fe143ad3f944
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#include "rvu.h"
+
+int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
+				     struct swdev2af_notify_req *req,
+				     struct msg_rsp *rsp)
+{
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
new file mode 100644
index 000000000000..f28dba556d80
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#ifndef RVU_SWITCH_H
+#define RVU_SWITCH_H
+
+#endif
-- 
2.43.0


