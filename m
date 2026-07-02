Return-Path: <netdev+bounces-303971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bTZAEVzuRWpCGwsAu9opvQ
	(envelope-from <netdev+bounces-303971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:51:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D976F3758
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:51:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=Y2X3eOlV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303971-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303971-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D49F304914E
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 04:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB6F367B84;
	Thu,  2 Jul 2026 04:50:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE336729D;
	Thu,  2 Jul 2026 04:50:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782967847; cv=none; b=Rs+tJTcC11z13GvoYOLusHWmT+Bka8rXQXJqINwE+GiEvQvz0KWOtKjXPXzFxQrlKVsB3jlT5fD1e5rzAJvaVa1dQTo5SBGxIJslYeJJ8QuPCMYeszQgXwp2F6B8p/L1DLDh20pDESCaFczoLzbK4iMfMVI2RzwE8y+x1LIC/no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782967847; c=relaxed/simple;
	bh=OehqEkYUfxhhm9MlbO8+5EkP9rXXfX4Y/tsV2GtfC/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+hseC34yvbyTXgBqNu+gkuBY8Xorl9hz9xkug4t3omOjOdw+lNFCR+zMaUh52pLtCgG/EiT+5SOsLoDqFjii1Z6Agi1rzOnL/d+Bu7p7o1Y8LRl/3xOxKfzcbjmJ1itsTOF6NbMbN3Xq0psVu+6pHR8O1NumybxZeh6rgsFKTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Y2X3eOlV; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621MFjN213822;
	Wed, 1 Jul 2026 21:50:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=1
	gOzp29FiXCu5XGNT3YG3jhQ+ZXmhwXkzKmXZ8tYd14=; b=Y2X3eOlVSd8rlkQ7X
	eDStQDt4qYG2tG6cWksrLOvgA54Zp06NtZsn0uqYy2cGrUbAKBkobYiMx3K4ubGc
	yRXo5glz5TtDvrni9zCPbGJn0mjFQTICJFk2ymmRrwPaGZ1WDQPxO7a0gTzpo45j
	Aoelol1DBLDWSXMTfkl49w7AI2uDMCL/Df8HXZeu9MJnQWdEo7GQy6DeidcdslNZ
	H/sJXYy9CuPO2UYkCvfJ9X1PQSEw9D+3CJR7uWrS7zNXejs4fZHcW9gXU0fkZqi8
	3zB0ZGzJlwwkJvV3E/lHC7sGFomxEb4qsF6Q40upSAcY8Lf7qgLqHJ4PDAI5cxE1
	XsUOQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f52krbdsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 21:50:37 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Jul 2026 21:50:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Jul 2026 21:50:37 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 90EAC3F708F;
	Wed,  1 Jul 2026 21:50:34 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v2 net-next 2/9] octeontx2-af: switch: Add switch dev to AF mboxes
Date: Thu, 2 Jul 2026 10:20:19 +0530
Message-ID: <20260702045026.2914748-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702045026.2914748-1-rkannoth@marvell.com>
References: <20260702045026.2914748-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA0NSBTYWx0ZWRfX/dUPYmIQR54u
 twK/0vij6ythTMAVcSwejMpF/88/Fby8DV5Q/zvD1de1Aahy+jbZpXQ7cSaofxnckGSsJIAeto8
 JDAsRi0jp6rP9Nu1OuKwkJ/qc+hmoQU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA0NSBTYWx0ZWRfXxiptR5LqTawa
 emGj9oa1D2pUnkuDer7gM8eJBINT4+++ABStEHBd5tf4H9sjs/xHoLPrOefy9lCrdUNmWTnTHu4
 kaqn9ALsQ9fqaVuP2dq6IwYz5D5hutkf4X55TO28LNpxVU6DLZom5NAcP5kXjSHyruC1g+pQRlr
 NWAGkfeZddS4G72FXEFGPJI+Ap6x5maNFELSnOb7o6P60OLEhmpEPHdu8p++iO3utqj7JiTZ0TE
 Al9DPKWIoh8JprjjNg96jUzf8mVLAI8dHA6WJN1pvmi3LO5yoSmEfyxIWe2rVaLIvx/0cnvN6Y/
 TjyvJAn0xACbtl7SVE44vgLa6ZMSa+cCPD7OufdKvIEaHyvUtTaRKlzLzJeldsXk72OsxNNiDGl
 6tLojKr45cXMUPPR5RzyeLf4VAkq1hgx2gZGdtql35AVbaklWbRw0RSb0zdW3q2CdgRfAiU6H2d
 F25K4KiB9uLXBiwkGDw==
X-Proofpoint-GUID: 4mQIWatqN6LwKwbtgh8Sy15yHOKfi6eT
X-Authority-Analysis: v=2.4 cv=Ae6B2XXG c=1 sm=1 tr=0 ts=6a45ee1d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=tre5bDftVekK85ftDVEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 4mQIWatqN6LwKwbtgh8Sy15yHOKfi6eT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303971-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9D976F3758

The Marvell switch hardware runs on a Linux OS. Switch
needs various information from AF driver. These mboxes are defined
to query those from AF driver.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/Makefile    |   2 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 121 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 116 +++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   1 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   3 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  88 +++++++++++++
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  11 ++
 .../marvell/octeontx2/af/switch/rvu_sw.c      |  15 +++
 .../marvell/octeontx2/af/switch/rvu_sw.h      |  11 ++
 9 files changed, 365 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/Makefile b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
index 82dd387308c9..73f20a44f1a0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
@@ -12,6 +12,6 @@ rvu_af-y := cgx.o rvu.o rvu_cgx.o rvu_npa.o rvu_nix.o \
 		  rvu_reg.o rvu_npc.o rvu_debugfs.o ptp.o rvu_npc_fs.o \
 		  rvu_cpt.o rvu_devlink.o rpm.o rvu_cn10k.o rvu_switch.o \
 		  rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o mcs_cnf10kb.o \
-		  switch/rvu_sw_l2.o switch/rvu_sw_l3.o switch/rvu_sw_fl.o\
+		  switch/rvu_sw.o switch/rvu_sw_l2.o switch/rvu_sw_l3.o switch/rvu_sw_fl.o \
 		  rvu_rep.o cn20k/mbox_init.o cn20k/nix.o cn20k/debugfs.o \
 		  cn20k/npa.o cn20k/npc.o
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 821895a7014e..43ff97441273 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -172,6 +172,10 @@ M(FL_NOTIFY,		0x012,  fl_notify,				\
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
@@ -317,6 +321,14 @@ M(NPC_MCAM_GET_DFT_RL_IDXS, 0x601e, npc_get_dft_rl_idxs,	\
 M(NPC_MCAM_GET_NPC_PFL_INFO, 0x601f, npc_get_pfl_info,		\
 					msg_req,		\
 					npc_get_pfl_info_rsp)	\
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
@@ -446,6 +458,12 @@ M(MCS_INTR_NOTIFY,	0xE00, mcs_intr_notify, mcs_intr_info, msg_rsp)
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
@@ -453,6 +471,8 @@ MBOX_UP_CGX_MESSAGES
 MBOX_UP_CPT_MESSAGES
 MBOX_UP_MCS_MESSAGES
 MBOX_UP_REP_MESSAGES
+MBOX_UP_AF2SWDEV_MESSAGES
+MBOX_UP_AF2PF_FDB_REFRESH_MESSAGES
 #undef M
 };
 
@@ -1587,6 +1607,30 @@ struct npc_mcam_alloc_entry_rsp {
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
@@ -1909,6 +1953,83 @@ struct fl_get_stats_rsp {
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
+#define IFACE_MAX (256 + 32) /* 32 PFs + 256 Vs */
+
+struct iface_get_info_rsp {
+	struct  mbox_msghdr hdr;
+	int cnt;
+	struct iface_info info[IFACE_MAX];
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
index ffba56ee8a60..6e10a58a0421 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1990,6 +1990,122 @@ int rvu_mbox_handler_msix_offset(struct rvu *rvu, struct msg_req *req,
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
+		if (tot >= IFACE_MAX)
+			goto done;
+
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
+			if (tot >= IFACE_MAX)
+				goto done;
+
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
+done:
+	rsp->cnt = tot;
+
+	return 0;
+}
+
 int rvu_mbox_handler_free_rsrc_cnt(struct rvu *rvu, struct msg_req *req,
 				   struct free_rsrcs_rsp *rsp)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 7f3505ae6860..21803e257cae 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -1158,6 +1158,7 @@ void rvu_program_channels(struct rvu *rvu);
 
 /* CN10K NIX */
 void rvu_nix_block_cn10k_init(struct rvu *rvu, struct nix_hw *nix_hw);
+int nix_get_tx_link(struct rvu *rvu, u16 pcifunc);
 
 /* CN10K RVU - LMT*/
 void rvu_reset_lmt_map_tbl(struct rvu *rvu, u16 pcifunc);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 0297c7ab0614..d2734f6d6d92 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -32,7 +32,6 @@ static int nix_free_all_bandprof(struct rvu *rvu, u16 pcifunc);
 static void nix_clear_ratelimit_aggr(struct rvu *rvu, struct nix_hw *nix_hw,
 				     u32 leaf_prof);
 static const char *nix_get_ctx_name(int ctype);
-static int nix_get_tx_link(struct rvu *rvu, u16 pcifunc);
 
 enum mc_tbl_sz {
 	MC_TBL_SZ_256,
@@ -2087,7 +2086,7 @@ static void nix_clear_tx_xoff(struct rvu *rvu, int blkaddr,
 	rvu_write64(rvu, blkaddr, reg, 0x0);
 }
 
-static int nix_get_tx_link(struct rvu *rvu, u16 pcifunc)
+int nix_get_tx_link(struct rvu *rvu, u16 pcifunc)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
 	int pf = rvu_get_pf(rvu->pdev, pcifunc);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index c7bc0b3a29b9..d797cd05776e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -3544,6 +3544,45 @@ int rvu_mbox_handler_npc_mcam_free_entry(struct rvu *rvu,
 	return rc;
 }
 
+int rvu_mbox_handler_npc_flow_del_n_free(struct rvu *rvu,
+					 struct npc_flow_del_n_free_req *mreq,
+					 struct msg_rsp *rsp)
+{
+	struct npc_mcam_free_entry_req sreq = { 0 };
+	struct npc_delete_flow_req dreq = { 0 };
+	struct npc_delete_flow_rsp drsp = { 0 };
+	bool err = false;
+	int ret = 0, i;
+
+	sreq.hdr.pcifunc = mreq->hdr.pcifunc;
+	dreq.hdr.pcifunc = mreq->hdr.pcifunc;
+
+	if (!mreq->cnt || mreq->cnt > 256) {
+		dev_err(rvu->dev, "Invalid cnt=%d\n", mreq->cnt);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < mreq->cnt; i++) {
+		dreq.entry = mreq->entry[i];
+		ret = rvu_mbox_handler_npc_delete_flow(rvu, &dreq, &drsp);
+		if (ret) {
+			dev_err(rvu->dev, "delete flow error for i=%d entry=%d\n",
+				i, mreq->entry[i]);
+			err = true;
+		}
+
+		sreq.entry = mreq->entry[i];
+		ret = rvu_mbox_handler_npc_mcam_free_entry(rvu, &sreq, rsp);
+		if (ret) {
+			dev_err(rvu->dev, "free entry error for i=%d entry=%d\n",
+				i, mreq->entry[i]);
+			err = true;
+		}
+	}
+
+	return err ? -EINVAL : 0;
+}
+
 int rvu_mbox_handler_npc_mcam_read_entry(struct rvu *rvu,
 					 struct npc_mcam_read_entry_req *req,
 					 struct npc_mcam_read_entry_rsp *rsp)
@@ -4361,6 +4400,55 @@ int rvu_mbox_handler_npc_mcam_entry_stats(struct rvu *rvu,
 	return 0;
 }
 
+int rvu_mbox_handler_npc_mcam_mul_stats(struct rvu *rvu,
+					struct npc_mcam_get_mul_stats_req *req,
+					struct npc_mcam_get_mul_stats_rsp *rsp)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	u16 pcifunc = req->hdr.pcifunc;
+	u16 index, cntr, entry;
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
+		entry = npc_cn20k_vidx2idx(req->entry[i]);
+
+		if (npc_mcam_verify_entry(mcam, pcifunc, entry)) {
+			dev_err(rvu->dev, "%s invalid mcam index=%d\n",
+				__func__, req->entry[i]);
+			return -EINVAL;
+		}
+
+		index = entry & (mcam->banksize - 1);
+		bank = npc_get_bank(mcam, entry);
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
index 91b5947dae06..09c7ee8571df 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1926,6 +1926,17 @@ static int npc_delete_flow(struct rvu *rvu, struct rvu_npc_mcam_rule *rule,
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


