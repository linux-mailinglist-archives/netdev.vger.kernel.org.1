Return-Path: <netdev+bounces-253473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OZJJJ9gd2nGegEAu9opvQ
	(envelope-from <netdev+bounces-253473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:39:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E54D488638
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD4FE30BE121
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D9D33556D;
	Mon, 26 Jan 2026 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ASAkFUti"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66B52F5A09;
	Mon, 26 Jan 2026 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430825; cv=none; b=p9tUa5kuzd8Cu/D4egsjbttpByWUJpW19q5Ov6Gg1fmVBZIjgdIdn8Y/7IxSed3Dyvd+GvrLhh1v1FlpNymlpKgoHp9z/LoabQjBUh3TZbAiJap7T7VpoHXQ9vm4L8qTQXqzTSi+Q48PdZxBCWsFnRb3gJGPVvIExYsPNcB02BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430825; c=relaxed/simple;
	bh=mJTjmhcoNnaZfRyM7rbBYNm3m3xOop+FYIIS8f+LuTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VB7IdtEOAxbBDyWZqetIIVCxTqw02na+tlTnAuwFm9x3EuLg74KE+BpdnxeGZSDFY3jBj5oM19DFSdheXS21bI9DgEImxscp5SiiBCyzR7Cq/7T8WmrLad6FBHOsgwsWRKb0/u8iFRQK1HPle8K8I7LV59MF2LgV+ihzrIMOP9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ASAkFUti; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q9dhti4175220;
	Mon, 26 Jan 2026 04:33:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
	ncpttqcfnlPbqinLFTWfRFG1SXZe/kkJv+ILe/Yl2Q=; b=ASAkFUtiXh7t5G7Hj
	/ALHHDdvg20uZK3z5uVuh5BGc21umCrgsHG7YqfZZvcivAJgxDCRbqL+8q3mMr1+
	UZZDEntg6qbVlvZP5zoBFWcfhI+7ko2/V9nojYeUwMetMcfeW4k5xcY4zKO1Q3s6
	5Jd2jITnFy4ztrMe/aJGyEDtOLRcmNmGs2VxzvsPQfwS4lxB1YRz23m2BI7zg283
	CCUNFsrCEZ23o47LeD2rAFZ7DsMDQOMFfyzq0F3recSdjBOws2RHOdsY6jErWu+w
	tBpCVTR7COLHjy16GsEI2ZujxY/lZWdBc8Q3uqBrV1vl3bBc+Xf4ixFm5uyqsj8V
	Wtxgw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bvxfjjqkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 04:33:30 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 Jan 2026 04:33:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 26 Jan 2026 04:33:29 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 053783F70B4;
	Mon, 26 Jan 2026 04:33:26 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v5 05/13] octeontx2-af: npc: cn20k: Allocate default MCAM indexes
Date: Mon, 26 Jan 2026 18:02:45 +0530
Message-ID: <20260126123254.1000480-6-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126123254.1000480-1-rkannoth@marvell.com>
References: <20260126123254.1000480-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Ksuy28EnUu1gi-9Z9ZOs3I-5tSO8o4cy
X-Proofpoint-ORIG-GUID: Ksuy28EnUu1gi-9Z9ZOs3I-5tSO8o4cy
X-Authority-Analysis: v=2.4 cv=S9LUAYsP c=1 sm=1 tr=0 ts=69775f1a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=s374GtA9f-YmEK9EDmoA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEwNiBTYWx0ZWRfX7i8Ume6VX40Y
 2iLybbIg6CnHaBJcpKkVrOImtUMGRUW2daFsmD9p7WffqbexnEJplwA2jfHUd5RrZ1yR7w0REqf
 4negbhLOPPRxxd6BJ49AXkC/SLLCZ5as5e4C+oATUpedamrmwJmxN6mvb68ORh4bPHsIs9aMBZ7
 u8/BbwsLXFbrBWkyaXcnl2GcOZLKUqkESs+TNlLWVgqEo+5IgVbLuH08/coHY+6WVzm17pQAc7P
 /OZ9ScpcnOpjV8lNRIiwfHnCycJqY7gg+zq01aBcrDT8BuHDHizzlh14DgGgV8FD681zM0caUhM
 hAFnujDULzVopVeUcqN9H0aX1tJkrqhJ2tgQ7GMy+NKUtl/5KkO3dSI+md3lSHDyvnS9A3yBlCi
 s6XZLOP4Bop27adhdsZGfJ4sO97M9rI18GPaJtPPkEaEJOT9uE6q4DOS/GiPOo/bsx1UrHj5vgy
 h4b3j8zRcae2BfhnPnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-253473-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[npc_priv.sb:url,marvell.com:email,marvell.com:dkim,marvell.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E54D488638
X-Rspamd-Action: no action

Reserving MCAM entries in the AF driver for installing default MCAM
entries is not an efficient allocation method, as it results in
significant wastage of entries. This patch allocates MCAM indexes for
promiscuous, multicast, broadcast, and unicast traffic in descending
order of indexes (from lower to higher priority) when the NIX LF is
attached to the PF/VF.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 366 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  29 ++
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   8 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  32 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   1 +
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  36 +-
 .../marvell/octeontx2/nic/otx2_flows.c        |   2 +-
 7 files changed, 452 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index dd5352bd6dbf..6ae462d6ebaa 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -25,10 +25,28 @@ static const char *npc_kw_name[NPC_MCAM_KEY_MAX] = {
 	[NPC_MCAM_KEY_X4] = "X4",
 };
 
+static const char *npc_dft_rule_name[NPC_DFT_RULE_MAX_ID] = {
+	[NPC_DFT_RULE_PROMISC_ID] = "Promisc",
+	[NPC_DFT_RULE_MCAST_ID] = "Mcast",
+	[NPC_DFT_RULE_BCAST_ID] = "Bcast",
+	[NPC_DFT_RULE_UCAST_ID] = "Ucast",
+};
+
 #define KEX_EXTR_CFG(bytesm1, hdr_ofs, ena, key_ofs)		\
 		     (((bytesm1) << 16) | ((hdr_ofs) << 8) | ((ena) << 7) | \
 		     ((key_ofs) & 0x3F))
 
+#define NPC_DFT_RULE_ID_MK(pcifunc, id) \
+	((pcifunc) | FIELD_PREP(GENMASK_ULL(31, 16), id))
+
+#define NPC_DFT_RULE_ID_2_PCIFUNC(rid) \
+	FIELD_GET(GENMASK_ULL(15, 0), rid)
+
+#define NPC_DFT_RULE_ID_2_ID(rid) \
+	FIELD_GET(GENMASK_ULL(31, 16), rid)
+
+#define NPC_DFT_RULE_PRIO 127
+
 static const char cn20k_def_pfl_name[] = "default";
 
 static struct npc_mcam_kex_extr npc_mkex_extr_default = {
@@ -2329,6 +2347,351 @@ static int npc_pcifunc_map_create(struct rvu *rvu)
 	return cnt;
 }
 
+int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
+				u16 *mcast, u16 *promisc, u16 *ucast)
+{
+	u16 *ptr[4] = {promisc, mcast, bcast, ucast};
+	unsigned long idx;
+	bool set = false;
+	void *val;
+	int i, j;
+
+	if (!npc_priv.init_done)
+		return 0;
+
+	if (is_lbk_vf(rvu, pcifunc)) {
+		if (!ptr[0])
+			return -ENOMEM;
+
+		idx = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_PROMISC_ID);
+		val = xa_load(&npc_priv.xa_pf2dfl_rmap, idx);
+		if (!val) {
+			pr_debug("%s: Failed to find %s index for pcifunc=%#x\n",
+				 __func__,
+				 npc_dft_rule_name[NPC_DFT_RULE_PROMISC_ID],
+				 pcifunc);
+
+			*ptr[0] = USHRT_MAX;
+			return -ESRCH;
+		}
+
+		*ptr[0] = xa_to_value(val);
+		return 0;
+	}
+
+	if (is_vf(pcifunc)) {
+		if (!ptr[3])
+			return -ENOMEM;
+
+		idx = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_UCAST_ID);
+		val = xa_load(&npc_priv.xa_pf2dfl_rmap, idx);
+		if (!val) {
+			pr_debug("%s: Failed to find %s index for pcifunc=%#x\n",
+				 __func__,
+				 npc_dft_rule_name[NPC_DFT_RULE_UCAST_ID],
+				 pcifunc);
+
+			*ptr[3] = USHRT_MAX;
+			return -ESRCH;
+		}
+
+		*ptr[3] = xa_to_value(val);
+		return 0;
+	}
+
+	for (i = NPC_DFT_RULE_START_ID, j = 0; i < NPC_DFT_RULE_MAX_ID; i++,
+	     j++) {
+		if (!ptr[j])
+			continue;
+
+		idx = NPC_DFT_RULE_ID_MK(pcifunc, i);
+		val = xa_load(&npc_priv.xa_pf2dfl_rmap, idx);
+		if (!val) {
+			pr_debug("%s: Failed to find %s index for pcifunc=%#x\n",
+				 __func__,
+				 npc_dft_rule_name[i], pcifunc);
+
+			*ptr[j] = USHRT_MAX;
+			continue;
+		}
+
+		*ptr[j] = xa_to_value(val);
+		set = true;
+	}
+
+	return  set ? 0 : -ESRCH;
+}
+
+static bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc)
+{
+	return is_pf_cgxmapped(rvu, rvu_get_pf(rvu->pdev, pcifunc)) ||
+		is_lbk_vf(rvu, pcifunc);
+}
+
+void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc)
+{
+	struct npc_mcam_free_entry_req free_req = { 0 };
+	unsigned long index;
+	struct msg_rsp rsp;
+	u16 ptr[4];
+	int rc, i;
+	void *map;
+
+	if (!npc_priv.init_done)
+		return;
+
+	if (!npc_is_cgx_or_lbk(rvu, pcifunc)) {
+		dev_dbg(rvu->dev,
+			"%s: dft rule allocation is only for cgx mapped device, pcifunc=%#x\n",
+			__func__, pcifunc);
+		return;
+	}
+
+	rc = npc_cn20k_dft_rules_idx_get(rvu, pcifunc, &ptr[0], &ptr[1],
+					 &ptr[2], &ptr[3]);
+	if (rc)
+		return;
+
+	/* LBK */
+	if (is_lbk_vf(rvu, pcifunc)) {
+		index = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_PROMISC_ID);
+		map = xa_erase(&npc_priv.xa_pf2dfl_rmap, index);
+		if (!map)
+			dev_dbg(rvu->dev,
+				"%s: Err from delete %s mcam idx from xarray (pcifunc=%#x\n",
+				__func__,
+				npc_dft_rule_name[NPC_DFT_RULE_PROMISC_ID],
+				pcifunc);
+
+		goto free_rules;
+	}
+
+	/* VF */
+	if (is_vf(pcifunc)) {
+		index = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_UCAST_ID);
+		map = xa_erase(&npc_priv.xa_pf2dfl_rmap, index);
+		if (!map)
+			dev_dbg(rvu->dev,
+				"%s: Err from delete %s mcam idx from xarray (pcifunc=%#x\n",
+				__func__,
+				npc_dft_rule_name[NPC_DFT_RULE_UCAST_ID],
+				pcifunc);
+
+		goto free_rules;
+	}
+
+	/* PF */
+	for (i = NPC_DFT_RULE_START_ID; i < NPC_DFT_RULE_MAX_ID; i++)  {
+		index = NPC_DFT_RULE_ID_MK(pcifunc, i);
+		map = xa_erase(&npc_priv.xa_pf2dfl_rmap, index);
+		if (!map)
+			dev_dbg(rvu->dev,
+				"%s: Err from delete %s mcam idx from xarray (pcifunc=%#x\n",
+				__func__, npc_dft_rule_name[i],
+				pcifunc);
+	}
+
+free_rules:
+
+	free_req.hdr.pcifunc = pcifunc;
+	free_req.all = 1;
+	rc = rvu_mbox_handler_npc_mcam_free_entry(rvu, &free_req, &rsp);
+	if (rc)
+		dev_err(rvu->dev,
+			"%s: Error deleting default entries (pcifunc=%#x\n",
+			__func__, pcifunc);
+}
+
+int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
+{
+	struct npc_mcam_free_entry_req free_req = { 0 };
+	u16 mcam_idx[4] = { 0 }, pf_ucast, pf_pcifunc;
+	struct npc_mcam_alloc_entry_req req = { 0 };
+	struct npc_mcam_alloc_entry_rsp rsp = { 0 };
+	int ret, eidx, i, k, pf, cnt;
+	struct rvu_pfvf *pfvf;
+	unsigned long index;
+	struct msg_rsp free_rsp;
+	u16 b, m, p, u;
+
+	if (!npc_priv.init_done)
+		return 0;
+
+	if (!npc_is_cgx_or_lbk(rvu, pcifunc)) {
+		dev_dbg(rvu->dev,
+			"%s: dft rule allocation is only for cgx mapped device, pcifunc=%#x\n",
+			__func__, pcifunc);
+		return 0;
+	}
+
+	/* Check if default rules are already alloced for this pcifunc */
+	ret =  npc_cn20k_dft_rules_idx_get(rvu, pcifunc, &b, &m, &p, &u);
+	if (!ret) {
+		dev_err(rvu->dev,
+			"%s: default rules are already installed (pcifunc=%#x)\n",
+			__func__, pcifunc);
+		dev_err(rvu->dev,
+			"%s: bcast(%u) mcast(%u) promisc(%u) ucast(%u)\n",
+			__func__, b, m, p, u);
+		return 0;
+	}
+
+	/* Set ref index as lowest priority index */
+	eidx = 2 * npc_priv.bank_depth - 1;
+
+	/* Install only UCAST for VF */
+	cnt = is_vf(pcifunc) ? 1 : ARRAY_SIZE(mcam_idx);
+
+	/* For VF pcifunc, allocate default mcam indexes by taking
+	 * ref as PF's ucast index.
+	 */
+	if (is_vf(pcifunc)) {
+		pf = rvu_get_pf(rvu->pdev, pcifunc);
+		pf_pcifunc = pf << RVU_CN20K_PFVF_PF_SHIFT;
+
+		/* Get PF's ucast entry index */
+		ret = npc_cn20k_dft_rules_idx_get(rvu, pf_pcifunc, NULL,
+						  NULL, NULL, &pf_ucast);
+
+		/* There is no PF rules installed; and VF installation comes
+		 * first. PF may come later.
+		 * TODO: Install PF rules before installing VF rules.
+		 */
+
+		/* Set PF's ucast as ref entry */
+		if (!ret)
+			eidx = pf_ucast;
+	}
+
+	pfvf = rvu_get_pfvf(rvu, pcifunc);
+	pfvf->hw_prio = NPC_DFT_RULE_PRIO;
+
+	req.contig = false;
+	req.ref_prio = NPC_MCAM_HIGHER_PRIO;
+	req.ref_entry = eidx;
+	req.kw_type = NPC_MCAM_KEY_X2;
+	req.count = cnt;
+	req.hdr.pcifunc = pcifunc;
+
+	ret = rvu_mbox_handler_npc_mcam_alloc_entry(rvu, &req, &rsp);
+
+	/* successfully allocated index */
+	if (!ret) {
+		/* Copy indexes to local array */
+		for (i = 0; i < cnt; i++)
+			mcam_idx[i] = rsp.entry_list[i];
+
+		goto chk_sanity;
+	}
+
+	/* If there is no slots available and request is for PF,
+	 * return error.
+	 */
+	if (!is_vf(pcifunc)) {
+		dev_err(rvu->dev,
+			"%s: Default index allocation failed for pcifunc=%#x\n",
+			__func__, pcifunc);
+		return ret;
+	}
+
+	/* We could not find an index with higher priority index for VF.
+	 * Find rule with lower priority index and set hardware priority
+	 * as NPC_DFT_RULE_PRIO - 1 (higher hw priority)
+	 */
+	req.contig = false;
+	req.kw_type = NPC_MCAM_KEY_X2;
+	req.count = cnt;
+	req.hdr.pcifunc = pcifunc;
+	req.ref_prio = NPC_MCAM_LOWER_PRIO;
+	req.ref_entry = eidx + 1;
+	ret = rvu_mbox_handler_npc_mcam_alloc_entry(rvu, &req, &rsp);
+	if (ret) {
+		dev_err(rvu->dev,
+			"%s: Default index allocation failed for pcifunc=%#x\n",
+			__func__, pcifunc);
+		return ret;
+	}
+
+	/* Copy indexes to local array */
+	for (i = 0; i < cnt; i++)
+		mcam_idx[i] = rsp.entry_list[i];
+
+	pfvf->hw_prio = NPC_DFT_RULE_PRIO - 1;
+
+chk_sanity:
+	dev_dbg(rvu->dev,
+		"%s: Default index for pcifunc=%#x, bcast=%u mcast=%u promise=%u ucast=%u cnt=%u\n",
+		__func__, pcifunc, mcam_idx[0], mcam_idx[1],
+		mcam_idx[2], mcam_idx[3], cnt);
+
+	/* LBK */
+	if (is_lbk_vf(rvu, pcifunc)) {
+		index = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_PROMISC_ID);
+		ret = xa_insert(&npc_priv.xa_pf2dfl_rmap, index,
+				xa_mk_value(mcam_idx[0]), GFP_KERNEL);
+		if (ret) {
+			dev_err(rvu->dev,
+				"%s: Err to insert %s mcam idx to xarray pcifunc=%#x\n",
+				__func__,
+				npc_dft_rule_name[NPC_DFT_RULE_PROMISC_ID],
+				pcifunc);
+			goto err;
+		}
+
+		goto done;
+	}
+
+	/* VF */
+	if (is_vf(pcifunc)) {
+		index = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_UCAST_ID);
+		ret = xa_insert(&npc_priv.xa_pf2dfl_rmap, index,
+				xa_mk_value(mcam_idx[0]), GFP_KERNEL);
+		if (ret) {
+			dev_err(rvu->dev,
+				"%s: Err to insert %s mcam idx to xarray pcifunc=%#x\n",
+				__func__,
+				npc_dft_rule_name[NPC_DFT_RULE_UCAST_ID],
+				pcifunc);
+			goto err;
+		}
+
+		goto done;
+	}
+
+	/* PF */
+	for (i = NPC_DFT_RULE_START_ID, k = 0; i < NPC_DFT_RULE_MAX_ID &&
+	     k < cnt; i++, k++) {
+		index = NPC_DFT_RULE_ID_MK(pcifunc, i);
+		ret = xa_insert(&npc_priv.xa_pf2dfl_rmap, index,
+				xa_mk_value(mcam_idx[k]), GFP_KERNEL);
+		if (ret) {
+			dev_err(rvu->dev,
+				"%s: Err to insert %s mcam idx to xarray pcifunc=%#x\n",
+				__func__, npc_dft_rule_name[i],
+				pcifunc);
+			for (int p = NPC_DFT_RULE_START_ID; p < i; p++) {
+				index = NPC_DFT_RULE_ID_MK(pcifunc, p);
+				xa_erase(&npc_priv.xa_pf2dfl_rmap, index);
+			}
+			goto err;
+		}
+	}
+
+done:
+	return 0;
+
+err:
+	free_req.hdr.pcifunc = pcifunc;
+	free_req.all = 1;
+	ret = rvu_mbox_handler_npc_mcam_free_entry(rvu, &free_req, &free_rsp);
+	if (ret)
+		dev_err(rvu->dev,
+			"%s: Error deleting default entries (pcifunc=%#x\n",
+			__func__, pcifunc);
+
+	return -EFAULT;
+}
+
 static int npc_priv_init(struct rvu *rvu)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
@@ -2384,6 +2747,7 @@ static int npc_priv_init(struct rvu *rvu)
 	xa_init_flags(&npc_priv.xa_sb_free, XA_FLAGS_ALLOC);
 	xa_init_flags(&npc_priv.xa_idx2pf_map, XA_FLAGS_ALLOC);
 	xa_init_flags(&npc_priv.xa_pf_map, XA_FLAGS_ALLOC);
+	xa_init_flags(&npc_priv.xa_pf2dfl_rmap, XA_FLAGS_ALLOC);
 
 	if (npc_create_srch_order(num_subbanks))
 		goto fail1;
@@ -2415,6 +2779,7 @@ static int npc_priv_init(struct rvu *rvu)
 	xa_destroy(&npc_priv.xa_sb_free);
 	xa_destroy(&npc_priv.xa_idx2pf_map);
 	xa_destroy(&npc_priv.xa_pf_map);
+	xa_destroy(&npc_priv.xa_pf2dfl_rmap);
 	kfree(npc_priv.sb);
 	return -ENOMEM;
 }
@@ -2427,6 +2792,7 @@ void npc_cn20k_deinit(struct rvu *rvu)
 	xa_destroy(&npc_priv.xa_sb_free);
 	xa_destroy(&npc_priv.xa_idx2pf_map);
 	xa_destroy(&npc_priv.xa_pf_map);
+	xa_destroy(&npc_priv.xa_pf2dfl_rmap);
 
 	for (i = 0; i < npc_priv.pf_cnt; i++)
 		xa_destroy(&npc_priv.xa_pf2idx_map[i]);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index aadee502bac1..f1734435db4d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -95,6 +95,27 @@ enum npc_subbank_flag {
 	NPC_SUBBANK_FLAG_USED = BIT(1),
 };
 
+/**
+ * enum npc_dft_rule_id - Default rule type
+ *
+ * Mcam default rule type.
+ *
+ * @NPC_DFT_RULE_START_ID:	Not used
+ * @NPC_DFT_RULE_PROMISC_ID:	promiscuous rule
+ * @NPC_DFT_RULE_MCAST_ID:	promiscuous rule
+ * @NPC_DFT_RULE_BCAST_ID:	broadcast rule
+ * @NPC_DFT_RULE_UCAST_ID:	unicast rule
+ * @NPC_DFT_RULE_MAX_ID:	Maximum index.
+ */
+enum npc_dft_rule_id {
+	NPC_DFT_RULE_START_ID = 1,
+	NPC_DFT_RULE_PROMISC_ID = NPC_DFT_RULE_START_ID,
+	NPC_DFT_RULE_MCAST_ID,
+	NPC_DFT_RULE_BCAST_ID,
+	NPC_DFT_RULE_UCAST_ID,
+	NPC_DFT_RULE_MAX_ID,
+};
+
 /**
  * struct npc_subbank - Subbank fields.
  * @b0b:	Subbanks bottom index for bank0
@@ -141,6 +162,7 @@ struct npc_subbank {
  * @xa_pf_map:		Pcifunc to index map.
  * @pf_cnt:		Number of PFs.A
  * @init_done:		Indicates MCAM initialization is done.
+ * @xa_pf2dfl_rmap:	PF to default rule index map.
  *
  * This structure is populated during probing time by reading
  * HW csr registers.
@@ -157,6 +179,7 @@ struct npc_priv_t {
 	struct xarray *xa_pf2idx_map;
 	struct xarray xa_idx2pf_map;
 	struct xarray xa_pf_map;
+	struct xarray xa_pf2dfl_rmap;
 	int pf_cnt;
 	bool init_done;
 };
@@ -265,4 +288,10 @@ int npc_cn20k_apply_custom_kpu(struct rvu *rvu,
 void
 npc_cn20k_update_action_entries_n_flags(struct rvu *rvu,
 					struct npc_kpu_profile_adapter *pfl);
+
+int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc);
+void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc);
+
+int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
+				u16 *mcast, u16 *promisc, u16 *ucast);
 #endif /* NPC_CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index a393bf884fd6..1b7f1103f78f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1539,9 +1539,10 @@ struct npc_mcam_alloc_entry_req {
 #define NPC_MCAM_ANY_PRIO		0
 #define NPC_MCAM_LOWER_PRIO		1
 #define NPC_MCAM_HIGHER_PRIO		2
-	u8  priority; /* Lower or higher w.r.t ref_entry */
+	u8  ref_prio; /* Lower or higher w.r.t ref_entry */
 	u16 ref_entry;
 	u16 count;    /* Number of entries requested */
+	u8 kw_type; /* entry key type, valid for cn20k */
 };
 
 struct npc_mcam_alloc_entry_rsp {
@@ -1634,10 +1635,12 @@ struct npc_mcam_alloc_and_write_entry_req {
 	struct mbox_msghdr hdr;
 	struct mcam_entry entry_data;
 	u16 ref_entry;
-	u8  priority;    /* Lower or higher w.r.t ref_entry */
+	u8  ref_prio;    /* Lower or higher w.r.t ref_entry */
 	u8  intf;	 /* Rx or Tx interface */
 	u8  enable_entry;/* Enable this MCAM entry ? */
 	u8  alloc_cntr;  /* Allocate counter and map ? */
+	/* hardware priority, supported for cn20k */
+	u8 hw_prio;
 };
 
 struct npc_mcam_alloc_and_write_entry_rsp {
@@ -1790,6 +1793,7 @@ struct npc_install_flow_req {
 	u8  vtag1_op;
 	/* old counter value */
 	u16 cntr_val;
+	u8 hw_prio;
 };
 
 struct npc_install_flow_rsp {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 747fbdf2a908..c8482b1598b9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -22,6 +22,7 @@
 #include "rvu_npc_hash.h"
 #include "cn20k/reg.h"
 #include "cn20k/api.h"
+#include "cn20k/npc.h"
 
 #define DRV_NAME	"rvu_af"
 #define DRV_STRING      "Marvell OcteonTX2 RVU Admin Function Driver"
@@ -1467,6 +1468,13 @@ static int rvu_detach_rsrcs(struct rvu *rvu, struct rsrc_detach *detach,
 			else if ((blkid == BLKADDR_CPT1) && !detach->cptlfs)
 				continue;
 		}
+
+		if (detach_all ||
+		    (detach && (blkid == BLKADDR_NIX0 ||
+				blkid == BLKADDR_NIX1) &&
+		     detach->nixlf))
+			npc_cn20k_dft_rules_free(rvu, pcifunc);
+
 		rvu_detach_block(rvu, pcifunc, block->type);
 	}
 
@@ -1750,6 +1758,12 @@ int rvu_mbox_handler_attach_resources(struct rvu *rvu,
 		err = rvu_attach_block(rvu, pcifunc, BLKTYPE_NIX, 1, attach);
 		if (err)
 			goto fail2;
+
+		if (is_cn20k(rvu->pdev)) {
+			err = npc_cn20k_dft_rules_alloc(rvu, pcifunc);
+			if (err)
+				goto fail3;
+		}
 	}
 
 	if (attach->sso) {
@@ -1763,7 +1777,7 @@ int rvu_mbox_handler_attach_resources(struct rvu *rvu,
 		err = rvu_attach_block(rvu, pcifunc, BLKTYPE_SSO,
 				       attach->sso, attach);
 		if (err)
-			goto fail3;
+			goto fail4;
 	}
 
 	if (attach->ssow) {
@@ -1772,7 +1786,7 @@ int rvu_mbox_handler_attach_resources(struct rvu *rvu,
 		err = rvu_attach_block(rvu, pcifunc, BLKTYPE_SSOW,
 				       attach->ssow, attach);
 		if (err)
-			goto fail4;
+			goto fail5;
 	}
 
 	if (attach->timlfs) {
@@ -1781,7 +1795,7 @@ int rvu_mbox_handler_attach_resources(struct rvu *rvu,
 		err = rvu_attach_block(rvu, pcifunc, BLKTYPE_TIM,
 				       attach->timlfs, attach);
 		if (err)
-			goto fail5;
+			goto fail6;
 	}
 
 	if (attach->cptlfs) {
@@ -1791,24 +1805,28 @@ int rvu_mbox_handler_attach_resources(struct rvu *rvu,
 		err = rvu_attach_block(rvu, pcifunc, BLKTYPE_CPT,
 				       attach->cptlfs, attach);
 		if (err)
-			goto fail6;
+			goto fail7;
 	}
 
 	mutex_unlock(&rvu->rsrc_lock);
 	return 0;
 
-fail6:
+fail7:
 	if (attach->timlfs)
 		rvu_detach_block(rvu, pcifunc, BLKTYPE_TIM);
 
-fail5:
+fail6:
 	if (attach->ssow)
 		rvu_detach_block(rvu, pcifunc, BLKTYPE_SSOW);
 
-fail4:
+fail5:
 	if (attach->sso)
 		rvu_detach_block(rvu, pcifunc, BLKTYPE_SSO);
 
+fail4:
+	if (is_cn20k(rvu->pdev))
+		npc_cn20k_dft_rules_free(rvu, pcifunc);
+
 fail3:
 	if (attach->nixlf)
 		rvu_detach_block(rvu, pcifunc, BLKTYPE_NIX);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index dd930aa05582..d2a0f6821cf9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -308,6 +308,7 @@ struct rvu_pfvf {
 	u64     lmt_map_ent_w1; /* Preseving the word1 of lmtst map table entry*/
 	unsigned long flags;
 	struct  sdp_node_info *sdp_info;
+	u8	hw_prio;   /* Hw priority of default rules */
 };
 
 enum rvu_pfvf_flags {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 8361d0aa4b6f..246f3568a795 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -653,6 +653,9 @@ void rvu_npc_install_ucast_entry(struct rvu *rvu, u16 pcifunc,
 	req.match_id = action.match_id;
 	req.flow_key_alg = action.flow_key_alg;
 
+	if (is_cn20k(rvu->pdev))
+		req.hw_prio = pfvf->hw_prio;
+
 	rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
 }
 
@@ -741,6 +744,9 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
 	req.match_id = action.match_id;
 	req.flow_key_alg = flow_key_alg;
 
+	if (is_cn20k(rvu->pdev))
+		req.hw_prio = pfvf->hw_prio;
+
 	rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
 }
 
@@ -821,6 +827,9 @@ void rvu_npc_install_bcast_match_entry(struct rvu *rvu, u16 pcifunc,
 	req.hdr.pcifunc = 0; /* AF is requester */
 	req.vf = pcifunc;
 
+	if (is_cn20k(rvu->pdev))
+		req.hw_prio = pfvf->hw_prio;
+
 	rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
 }
 
@@ -909,6 +918,9 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 	req.match_id = action.match_id;
 	req.flow_key_alg = flow_key_alg;
 
+	if (is_cn20k(rvu->pdev))
+		req.hw_prio = pfvf->hw_prio;
+
 	rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
 }
 
@@ -2484,7 +2496,7 @@ npc_get_mcam_search_range_priority(struct npc_mcam *mcam,
 {
 	u16 fcnt;
 
-	if (req->priority == NPC_MCAM_HIGHER_PRIO)
+	if (req->ref_prio == NPC_MCAM_HIGHER_PRIO)
 		goto hprio;
 
 	/* For a low priority entry allocation
@@ -2584,7 +2596,7 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 		goto lprio_alloc;
 
 	/* Get the search range for priority allocation request */
-	if (req->priority) {
+	if (req->ref_prio) {
 		npc_get_mcam_search_range_priority(mcam, req,
 						   &start, &end, &reverse);
 		goto alloc;
@@ -2625,11 +2637,11 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 		 * and not in mid zone.
 		 */
 		if (!(pcifunc & RVU_PFVF_FUNC_MASK) &&
-		    req->priority == NPC_MCAM_HIGHER_PRIO)
+		    req->ref_prio == NPC_MCAM_HIGHER_PRIO)
 			end = req->ref_entry;
 
 		if (!(pcifunc & RVU_PFVF_FUNC_MASK) &&
-		    req->priority == NPC_MCAM_LOWER_PRIO)
+		    req->ref_prio == NPC_MCAM_LOWER_PRIO)
 			start = req->ref_entry;
 	}
 
@@ -2678,7 +2690,7 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 	/* If allocating requested no of entries is unsucessful,
 	 * expand the search range to full bitmap length and retry.
 	 */
-	if (!req->priority && (rsp->count < req->count) &&
+	if (!req->ref_prio && rsp->count < req->count &&
 	    ((end - start) != mcam->bmap_entries)) {
 		reverse = true;
 		start = 0;
@@ -2689,14 +2701,14 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 	/* For priority entry allocation requests, if allocation is
 	 * failed then expand search to max possible range and retry.
 	 */
-	if (req->priority && rsp->count < req->count) {
-		if (req->priority == NPC_MCAM_LOWER_PRIO &&
+	if (req->ref_prio && rsp->count < req->count) {
+		if (req->ref_prio == NPC_MCAM_LOWER_PRIO &&
 		    (start != (req->ref_entry + 1))) {
 			start = req->ref_entry + 1;
 			end = mcam->bmap_entries;
 			reverse = false;
 			goto alloc;
-		} else if ((req->priority == NPC_MCAM_HIGHER_PRIO) &&
+		} else if ((req->ref_prio == NPC_MCAM_HIGHER_PRIO) &&
 			   ((end - start) != req->ref_entry)) {
 			start = 0;
 			end = req->ref_entry;
@@ -2810,9 +2822,9 @@ int rvu_mbox_handler_npc_mcam_alloc_entry(struct rvu *rvu,
 	/* ref_entry can't be '0' if requested priority is high.
 	 * Can't be last entry if requested priority is low.
 	 */
-	if ((!req->ref_entry && req->priority == NPC_MCAM_HIGHER_PRIO) ||
-	    ((req->ref_entry == mcam->bmap_entries) &&
-	     req->priority == NPC_MCAM_LOWER_PRIO))
+	if ((!req->ref_entry && req->ref_prio == NPC_MCAM_HIGHER_PRIO) ||
+	    (req->ref_entry == mcam->bmap_entries &&
+	     req->ref_prio == NPC_MCAM_LOWER_PRIO))
 		return NPC_MCAM_INVALID_REQ;
 
 	/* Since list of allocated indices needs to be sent to requester,
@@ -3358,7 +3370,7 @@ int rvu_mbox_handler_npc_mcam_alloc_and_write_entry(struct rvu *rvu,
 	/* Try to allocate a MCAM entry */
 	entry_req.hdr.pcifunc = req->hdr.pcifunc;
 	entry_req.contig = true;
-	entry_req.priority = req->priority;
+	entry_req.ref_prio = req->ref_prio;
 	entry_req.ref_entry = req->ref_entry;
 	entry_req.count = 1;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 64c6d9162ef6..052d989f2d9a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -104,7 +104,7 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 		 * will be on top of PF.
 		 */
 		if (!is_otx2_vf(pfvf->pcifunc)) {
-			req->priority = NPC_MCAM_HIGHER_PRIO;
+			req->ref_prio = NPC_MCAM_HIGHER_PRIO;
 			req->ref_entry = flow_cfg->def_ent[0];
 		}
 
-- 
2.43.0


