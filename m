Return-Path: <netdev+bounces-307141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ic3PE8HYVGoUfwAAu9opvQ
	(envelope-from <netdev+bounces-307141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:23:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D31BA74AE5F
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:23:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=I7aVqvmt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307141-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307141-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4499D303099F
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD7E4071C5;
	Mon, 13 Jul 2026 12:19:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C4A3F54A0;
	Mon, 13 Jul 2026 12:19:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945189; cv=none; b=FknsJi8JiTDQmeHUrEWVjI2HXLqtav13GP9A4KJQVpoI18k1aPi481wJ7BskF+4wDqSF+1QSMhGqpxY/9QWQACv7aHnfjLGsRQJGEwDZbnbm8e0T6BAlbxTqJOnuATYzEVAjo33/I0+zYMkqfo+Lk31PNViHdK+1DB2zb6bpEac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945189; c=relaxed/simple;
	bh=/n93W2PzyhcpKYJLUM7AROH7bZwOEdWgSIfpbjJGtT8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lxWj5KrBr/0M4fxjwZPoBjTexBDi9uwYuh7l3BjNgYppdWArNqLaJhsy+k/7ZkvQiWPaS6IdoZj1AKzZg+HcltKbF5xMiBZwD/Vi71Er80hDSJIAOJXZlpx5tmv0T5DdyC1D/+hfxFglyiBpLMI+/hNsTxeZmbGBsihCzwWV9/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=I7aVqvmt; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCEAHd1647590;
	Mon, 13 Jul 2026 05:19:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=SQMcdr5oGAdLAN6lhUQf9K/
	AsH+liZy0cj3ipt6Mtxo=; b=I7aVqvmt0ykWMSarOTroQJsL3RwzBfBIlXxwrD9
	lZ9QMNq11nSxLM38CvfjrnqM0pm7hRpHpb7KbvzNOGLm8f/nGBGIzlt78QaLj2EF
	Wjc/fsRlf74mBNIjRN7B2UD/ClPT2sQ2DrRlWpbmnlt4HNny0TKXxGlwZWPY/JEG
	KZFAPWyRo5ysdo3+AQKodAgRT4dAmEXuLWQUal9mINlhDa23BMszdMKTspxlYQDo
	r+yY4wrnr0WXE4i67KfpIIQB1HEEHEkaX95W8LHyTJjw3hwQVuJhJ1LMkxp4MsHI
	WpBfFJBlamLm8WWmOf+AO53l9qWjgosrHGlB//esgS0G1jw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fcwvc087q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 05:19:26 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Jul 2026 05:19:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Jul 2026 05:19:25 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 2A18C3F7068;
	Mon, 13 Jul 2026 05:19:21 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Hariprasad Kelam <hkelam@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v3 net] octeontx2-af: Block VFs from clobbering special CGX PKIND state
Date: Mon, 13 Jul 2026 17:49:02 +0530
Message-ID: <20260713121902.3938875-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iRwgqnJwEnhLSmPVsQsv686mU_5fhbR8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyNyBTYWx0ZWRfX9xH4nzhNDJIe
 u05j/iIwAdj8+Rt94Ehq5dZZzE/k5YBICO/GsO6/2ZbWa0OHAZPZnVhKaDAQABY/j9uCdn79oJG
 CDscEJoqYUsXV3iQYtUrFS6xz8zFip8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyNyBTYWx0ZWRfX0MlyuJId8ewy
 ik8/Usd4znKJeXKb64akZBkc+rWXeZSNsstPLnWuw8ga+C9h5ehuGDAfPInJe9vkM0HoW5YsVtN
 DNrpGsl57epwKw5i6fMVGgq9AHLdbuoPSKe6T8ruFueODzZgxVI0axaEKmX1g4U53Iwr0048Lrc
 6GaTRD3Xf9kUYRDN2Jr9+gxEkiw16pCqcvIxTA222JgJbr6Zmg3ATq7CXdsu/9d6i2d85sJf1Dw
 DI/bHmiQ/gsc2a4GSv+kgqJtRkeTGLaKJUtXAusV6pLw3dmmntbaKwm+WMtHXjP/8heg8L4MPkV
 8debVS2H0mzFDrAA0Auyd4mhGx6eMyJK1YZa4F092wBnYnmOGjFarwuBTYIU4jt78ltu9oO2AOd
 Q22BdQHZuI9lDKI6yEsvQRNMWifkT9sazQA2vSXzCUeQiHxKMXx2sG1xaIiT4kUNjcN/asdgWrU
 KVW/2xll0HBWxNK3B7A==
X-Authority-Analysis: v=2.4 cv=cIXQdFeN c=1 sm=1 tr=0 ts=6a54d7ce cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=ZSlNZ2RTXUNskQ7JDYEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: iRwgqnJwEnhLSmPVsQsv686mU_5fhbR8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307141-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:gakula@marvell.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:sgoutham@marvell.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:hkelam@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D31BA74AE5F

From: Hariprasad Kelam <hkelam@marvell.com>

PF and VF NIX LFs that share a CGX LMAC reuse the same hardware PKIND
programming. When HiGig2 or EDSA parsing is enabled, a VF NIX LF alloc must
not reset the LMAC RX PKIND or default TX parse config over the PF setup.

Add cgx_get_pkind() and rvu_cgx_is_pkind_config_permitted() so VFs skip
cgx_set_pkind(), rvu_npc_set_pkind(), and NIX_AF_LFX_TX_PARSE_CFG updates
when the LMAC is using NPC_RX_HIGIG_PKIND or NPC_RX_EDSA_PKIND.

Fixes: 94d942c5fb97 ("octeontx2-af: Config pkind for CGX mapped PFs")
Cc: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
v2 -> v3: Addressed simon comments
	https://lore.kernel.org/netdev/20260709122648.1552103-2-horms@kernel.org/
v1 -> v2: Addressed simon comments
	https://lore.kernel.org/netdev/20260619041002.1773822-1-rkannoth@marvell.com/
---
 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 12 +++++++
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  1 +
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 32 +++++++++++++++++++
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 18 ++++++++---
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 11 +++++--
 6 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 2e94d5105016..f5fd6138c352 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -518,6 +518,18 @@ int cgx_set_pkind(void *cgxd, u8 lmac_id, int pkind)
 	return 0;
 }
 
+int cgx_get_pkind(void *cgxd, u8 lmac_id, int *pkind)
+{
+	struct cgx *cgx = cgxd;
+
+	if (!is_lmac_valid(cgx, lmac_id))
+		return -ENODEV;
+
+	*pkind = cgx_read(cgx, lmac_id, cgx->mac_ops->rxid_map_offset);
+	*pkind = *pkind & 0x3F;
+	return 0;
+}
+
 static u8 cgx_get_lmac_type(void *cgxd, int lmac_id)
 {
 	struct cgx *cgx = cgxd;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
index 92ccf343dfe0..8411a75dd723 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
@@ -141,6 +141,7 @@ int cgx_get_cgxid(void *cgxd);
 int cgx_get_lmac_cnt(void *cgxd);
 void *cgx_get_pdata(int cgx_id);
 int cgx_set_pkind(void *cgxd, u8 lmac_id, int pkind);
+int cgx_get_pkind(void *cgxd, u8 lmac_id, int *pkind);
 int cgx_lmac_evh_register(struct cgx_event_cb *cb, void *cgxd, int lmac_id);
 int cgx_lmac_evh_unregister(void *cgxd, int lmac_id);
 int cgx_get_tx_stats(void *cgxd, int lmac_id, int idx, u64 *tx_stat);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 7f3505ae6860..bb671e2150aa 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -1115,6 +1115,7 @@ void npc_read_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 			 u8 *intf, u8 *ena);
 int npc_config_cntr_default_entries(struct rvu *rvu, bool enable);
 bool is_cgx_config_permitted(struct rvu *rvu, u16 pcifunc);
+bool rvu_cgx_is_pkind_config_permitted(struct rvu *rvu, u16 pcifunc);
 bool is_mac_feature_supported(struct rvu *rvu, int pf, int feature);
 u32  rvu_cgx_get_fifolen(struct rvu *rvu);
 void *rvu_first_cgx_pdata(struct rvu *rvu);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 4ff3935ed3fe..2be1da3476ac 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -1355,3 +1355,35 @@ void rvu_mac_reset(struct rvu *rvu, u16 pcifunc)
 	if (mac_ops->mac_reset(cgxd, lmac, !is_vf(pcifunc)))
 		dev_err(rvu->dev, "Failed to reset MAC\n");
 }
+
+/* Do not allow CGX-mapped VFs to overwrite PKIND when special parse kinds
+ * (HiGig, EDSA, etc.) are in use on the shared LMAC.
+ */
+bool rvu_cgx_is_pkind_config_permitted(struct rvu *rvu, u16 pcifunc)
+{
+	int pf, err, rxpkind;
+	u8 cgx_id, lmac_id;
+	void *cgxd;
+
+	pf = rvu_get_pf(rvu->pdev, pcifunc);
+
+	if (!(pcifunc & RVU_PFVF_FUNC_MASK))
+		return true;
+
+	if (!is_pf_cgxmapped(rvu, pf))
+		return true;
+
+	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
+	cgxd = rvu_cgx_pdata(cgx_id, rvu);
+	err = cgx_get_pkind(cgxd, lmac_id, &rxpkind);
+	if (err)
+		return false;
+
+	switch (rxpkind) {
+	case NPC_RX_HIGIG_PKIND:
+	case NPC_RX_EDSA_PKIND:
+		return false;
+	default:
+		return true;
+	}
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 6a0ce2665031..040eb4c9b8d1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -338,6 +338,7 @@ static int nix_interface_init(struct rvu *rvu, u16 pcifunc, int type, int nixlf,
 	struct sdp_node_info *sdp_info;
 	int pkind, pf, vf, lbkid, vfid;
 	u8 cgx_id, lmac_id;
+	struct cgx *cgxd;
 	bool from_vf;
 	int err;
 
@@ -363,8 +364,15 @@ static int nix_interface_init(struct rvu *rvu, u16 pcifunc, int type, int nixlf,
 		pfvf->tx_chan_cnt = 1;
 		rsp->tx_link = cgx_id * hw->lmac_per_cgx + lmac_id;
 
-		cgx_set_pkind(rvu_cgx_pdata(cgx_id, rvu), lmac_id, pkind);
-		rvu_npc_set_pkind(rvu, pkind, pfvf);
+		cgxd = rvu_cgx_pdata(cgx_id, rvu);
+
+		mutex_lock(&cgxd->lock);
+		if (rvu_cgx_is_pkind_config_permitted(rvu, pcifunc)) {
+			cgx_set_pkind(rvu_cgx_pdata(cgx_id, rvu), lmac_id,
+				      pkind);
+			rvu_npc_set_pkind(rvu, pkind, pfvf);
+		}
+		mutex_unlock(&cgxd->lock);
 		break;
 	case NIX_INTF_TYPE_LBK:
 		vf = (pcifunc & RVU_PFVF_FUNC_MASK) - 1;
@@ -1685,8 +1693,10 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_RX_CFG(nixlf), req->rx_cfg);
 
 	/* Configure pkind for TX parse config */
-	cfg = NPC_TX_DEF_PKIND;
-	rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf), cfg);
+	if (rvu_cgx_is_pkind_config_permitted(rvu, pcifunc)) {
+		cfg = NPC_TX_DEF_PKIND;
+		rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf), cfg);
+	}
 
 	if (is_rep_dev(rvu, pcifunc)) {
 		pfvf->tx_chan_base = RVU_SWITCH_LBK_CHAN;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index c7bc0b3a29b9..1297c6681a01 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -17,6 +17,7 @@
 #include "npc_profile.h"
 #include "rvu_npc_hash.h"
 #include "cn20k/npc.h"
+#include "lmac_common.h"
 #include "rvu_npc.h"
 #include "cn20k/reg.h"
 
@@ -4204,6 +4205,7 @@ int rvu_npc_set_parse_mode(struct rvu *rvu, u16 pcifunc, u64 mode, u8 dir,
 	int pf = rvu_get_pf(rvu->pdev, pcifunc);
 	u64 rxpkind, txpkind;
 	u8 cgx_id, lmac_id;
+	struct cgx *cgxd;
 
 	/* use default pkind to disable edsa/higig */
 	rxpkind = rvu_npc_get_pkind(rvu, pf);
@@ -4228,9 +4230,11 @@ int rvu_npc_set_parse_mode(struct rvu *rvu, u16 pcifunc, u64 mode, u8 dir,
 		if (!is_cgx_config_permitted(rvu, pcifunc))
 			return 0;
 		rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
+		cgxd = rvu_cgx_pdata(cgx_id, rvu);
 
-		rc = cgx_set_pkind(rvu_cgx_pdata(cgx_id, rvu), lmac_id,
-				   rxpkind);
+		mutex_lock(&cgxd->lock);
+		rc = cgx_set_pkind(cgxd, lmac_id, rxpkind);
+		mutex_unlock(&cgxd->lock);
 		if (rc)
 			return rc;
 	}
@@ -4241,6 +4245,9 @@ int rvu_npc_set_parse_mode(struct rvu *rvu, u16 pcifunc, u64 mode, u8 dir,
 		if (rc)
 			return rc;
 
+		if (!rvu_cgx_is_pkind_config_permitted(rvu, pcifunc))
+			return -EINVAL;
+
 		rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf),
 			    txpkind);
 	}
-- 
2.43.0


