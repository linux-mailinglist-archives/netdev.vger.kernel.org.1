Return-Path: <netdev+bounces-293497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMk8FF7vHGo+UQkAu9opvQ
	(envelope-from <netdev+bounces-293497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:33:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C33618D62
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 746A1300383E
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 02:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7839F214813;
	Mon,  1 Jun 2026 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iGJ4S/ee"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0E178F4A;
	Mon,  1 Jun 2026 02:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780281179; cv=none; b=ipK4+msVFlr085xWHPwRfTK8+fO4V6EmPVbcLTG6N6+mzVBsUpDjToLvN3b+ji5QCke00QBIZHDEamRU/xHQAmvvesnnKiM8Brl/wgefdFMPmqTSMvMT/ZopZoen6pj5PG51vFMzR6UFMgcm6/HvZV0SCgExUdEp9IDBzE9hegM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780281179; c=relaxed/simple;
	bh=qGRVdsMOBjqZD290Fp9mFQHk24i3vB6z1zRfcvuIcM4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nyfkLNN+FDn94sfZ4+8RmDO+uOu84RGJi8c9GyvnlWau2oKv4kHupoq9v6T6Rp3P8s7YP/yg0UMiYWP8IO5DUaRNvrRmmD2+tXlW/a+CxAWLWxbHgzKF0HHWxn4QLirHig43MqUz/3QHXYL4gRWID629Rnf9+z0E+7sfYYaghdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iGJ4S/ee; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VLTET63285359;
	Sun, 31 May 2026 19:32:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=kDJk+3/0cOtLNJZ1WWLamR3
	QzmHE/O1godFj+ubVObo=; b=iGJ4S/eegpoPKgbUA9d/NFNWWV1tGEqseqjrg6O
	fxBa9+7iWRDHIhRbaV5eVolnppHS6nwYz4tHoyWgpeXNQ/RUCsYCbPMxdAXHZaBm
	UZl67e95kMS7DA6QQAfD3CweAjdg0n1LRwZXsBcCtsVC2CXGZ5eB7kmVD5Lgizgb
	6gNXM0k63+lX8z5ybLpieh7tVE81O0h3/RCLSuh0GTlWAd/GQNMel1GpEO6FjQkv
	qzJCURs6uNNCMI9TMmKmaDk4Ru8QjGmCog7VG9ue+5WPOjuBHVpltWknNi5nqhwb
	yVhO53aZZNXBxEZBeVOIFzE7blTfCLdBI6ShS7Z4Q0AbbBg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eggn8a38n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 19:32:36 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 31 May 2026 19:32:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 31 May 2026 19:32:35 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 3005F3F7062;
	Sun, 31 May 2026 19:32:31 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <naveenm@marvell.com>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Nithin Dabilpuram
	<ndabilpuram@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-af: npc: Fix CPT channel mask in npc_install_flow
Date: Mon, 1 Jun 2026 08:02:21 +0530
Message-ID: <20260601023221.858168-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mhEuTRg75Wc5LV3Wjs9bYmfjZTTSWpn-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDAyMyBTYWx0ZWRfX2gt8R0ZQR4Vu
 QBTvHbUB35MXmKNFAJNEpLD740FtjNr+L1uQBch2HUUkr/iCd2o+rKrPgeWm6qc81Cg8JMIjS2e
 +X5g1lOApdOIo58vjxjQRIQ56lS+ZDPSlpp4/I7+mcUgCpmieHHBTur+QFrYzAt6devKbI67r+1
 pW+VsuqfmoCY+aLckTMFBKr5l/omyuFnUZ9ZMVuznf6icqrGEB4bQvtZ+oYNwZPbeV9b2EDFCfo
 6cuiBHNa4DRkcxv0+MvssdWrl5fBvkEg+6HQosX/Emmj9ER2p10RPmPdNsyOn5bc+HLbz4oXLqI
 J/hFp02kYyqM2TBVPC51Ib6j2eDN8Ga1KNVZDOmvjuLP3TmutgQgvLwHdKu1ITRk1S/zXqNTIsy
 n02oeS3OB2zBA8l/wv5iieVRLzTeXY4gzh2sY+LWH6eHID07BJQB8THJrTQH/xo6wC3+R6gfuys
 rDuXHcCItRq4BTzbfsg==
X-Proofpoint-GUID: mhEuTRg75Wc5LV3Wjs9bYmfjZTTSWpn-
X-Authority-Analysis: v=2.4 cv=ON0XGyaB c=1 sm=1 tr=0 ts=6a1cef44 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=4LLoDVS4aI4iRlKlNUYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293497-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,marvell.com:email,marvell.com:mid,marvell.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D7C33618D62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nithin Dabilpuram <ndabilpuram@marvell.com>

Use the CPT-aware NIX channel mask in the npc_install_flow path so that
when the host PF installs steering rules in kernel for a VF used from
userspace (e.g. DPDK), MCAM entries see the same channel mask semantics as
other RX paths.

Fixes: 56bcef528bd8 ("octeontx2-af: Use npc_install_flow API for promisc and broadcast entries")
Cc: Naveen Mamindlapalli <naveenm@marvell.com>
Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  1 +
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 24 +++++++++++--------
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  2 +-
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index de3fbd3d15d6..65397daae4c2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -1145,6 +1145,7 @@ int rvu_cpt_lf_teardown(struct rvu *rvu, u16 pcifunc, int blkaddr, int lf,
 			int slot);
 int rvu_cpt_ctx_flush(struct rvu *rvu, u16 pcifunc);
 int rvu_cpt_init(struct rvu *rvu);
+u32 rvu_get_cpt_chan_mask(struct rvu *rvu);
 
 #define NDC_AF_BANK_MASK       GENMASK_ULL(7, 0)
 #define NDC_AF_BANK_LINE_MASK  GENMASK_ULL(31, 16)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 607d0cf1a778..cb1ce4cc1948 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -701,6 +701,19 @@ void npc_set_mcam_action(struct rvu *rvu, struct npc_mcam *mcam,
 	return rvu_write64(rvu, blkaddr, reg, cfg);
 }
 
+u32 rvu_get_cpt_chan_mask(struct rvu *rvu)
+{
+	/* For cn10k the upper two bits of the channel number are
+	 * cpt channel number. with masking out these bits in the
+	 * mcam entry, same entry used for NIX will allow packets
+	 * received from cpt for parsing.
+	 */
+	if (!is_rvu_otx2(rvu))
+		return NIX_CHAN_CPT_X2P_MASK;
+	else
+		return 0xFFFu;
+}
+
 void rvu_npc_install_ucast_entry(struct rvu *rvu, u16 pcifunc,
 				 int nixlf, u64 chan, u8 *mac_addr)
 {
@@ -1053,16 +1066,7 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 	ether_addr_copy(req.mask.dmac, mac_addr);
 	req.features = BIT_ULL(NPC_DMAC);
 
-	/* For cn10k the upper two bits of the channel number are
-	 * cpt channel number. with masking out these bits in the
-	 * mcam entry, same entry used for NIX will allow packets
-	 * received from cpt for parsing.
-	 */
-	if (!is_rvu_otx2(rvu))
-		req.chan_mask = NIX_CHAN_CPT_X2P_MASK;
-	else
-		req.chan_mask = 0xFFFU;
-
+	req.chan_mask = rvu_get_cpt_chan_mask(rvu);
 	req.channel = chan;
 	req.intf = pfvf->nix_rx_intf;
 	req.entry = index;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 6ae9cdcb608b..34f1e066707b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1820,7 +1820,7 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 
 	/* ignore chan_mask in case pf func is not AF, revisit later */
 	if (!is_pffunc_af(req->hdr.pcifunc))
-		req->chan_mask = 0xFFF;
+		req->chan_mask = rvu_get_cpt_chan_mask(rvu);
 
 	err = npc_check_unsupported_flows(rvu, req->features, req->intf);
 	if (err) {
-- 
2.43.0


