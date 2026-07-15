Return-Path: <netdev+bounces-307655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0vLBANgIV2rtEQEAu9opvQ
	(envelope-from <netdev+bounces-307655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 06:13:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B38D75A6AC
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 06:13:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=V+93rKLX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307655-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307655-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 152D33019825
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 04:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325BE3B2FC0;
	Wed, 15 Jul 2026 04:13:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC493ACF0A;
	Wed, 15 Jul 2026 04:13:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784088789; cv=none; b=ZpmAZli6lCaSLCBsJqbc6pFq9eCoA9pZWaFWFBfuvNYpma9aCDtg96ZUQXyzga9MLxHSdI7IJ37CDNtWDuOPgCI9BzcVaubfd6kJuDSg8cRMzb7P2VlfnLKzRcfHY5rBAjB7tOLx3+SlpiLcr6BrS6KyIHPhi0uX7aQCnSlv0VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784088789; c=relaxed/simple;
	bh=KPTA9P0WwV6pnz9pDknwbHnMX6+U7zW1xNUJHrznqbQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n0a6ymR73EaWYGv2BGxMWmoX2lOE87jHHR5KNz2SB1LbS5nunt8xaDaUPhnrIdQnGHYn3v7PXEQWQ1ilhLUA3zsU9B8Nr+lvACQIXdgchkVHXJv9Y7a/jgreKA2E60ZOHvlANdD2L/0hlDK5ikpcelDVlu4/u89xvr9a83d5sD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=V+93rKLX; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3lKcr517474;
	Tue, 14 Jul 2026 21:12:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=gHjJj06fkts2+NPI7KN5ahH
	6Ce7MGrcRGMkD+crdkR4=; b=V+93rKLX13t6M2w25RL6PYD+QRDpPrUvSQv7oxR
	uSKCsOWYroXBz15fUK05pPpxo3NGwHWyK9uurup1e6iTrzsf2fSXPZEOFIlGudjc
	eGET/iq9ALbd/gKO6vrrVWSq5NT0HUo8FDAUXYY010aJSlYk0k1W90SGzqhS06/E
	bNYNhPEbJ3r+LLwJ8Qlq/ajwuZfYfma6QI7LDY0PPpflI3BK0X1ZAVs61S6a/GCw
	xg1ypFMbXptN5kWCTHK0LPX7knFZKPGJSc8fyjGNrZshHbMvLrCQh6884V2d/Yn/
	5rEFNXXgH8p0ut/fTYKKw97YtBLXlH2PlSTYE3fLE6NDfSA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fdxve0mhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 21:12:46 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 14 Jul 2026 21:12:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 14 Jul 2026 21:12:45 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id E7A0B626761;
	Tue, 14 Jul 2026 21:12:41 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Satha Rao
	<skoteshwar@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v2 net-next] octeontx2-af: add new mbox to support sync cycle on rx path
Date: Wed, 15 Jul 2026 09:42:39 +0530
Message-ID: <20260715041239.2052888-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDAzNSBTYWx0ZWRfX5pczTCl/xx3i
 K1n0vj+eUeAAXx0zT60C5hEbl/vV8dlFmp84xrASBXS6HnkLGJTeI3vL7Tc94PmBryIlDF4m22c
 m0vNH326Gcw39rnPxlgNfXYMLRoCQVYQ6kGfBZyqUN13O171Gc4WMcj138E3fT3ogssia0ko80+
 /wQLxF5qFBKmS1m58AG0z02R0/Mkj55+LJP8oyySKwFZ+mmT2++ieLrihN5oGq6Wb0Rh5hQH0gx
 9TRtpQnaEJD0KdtbWUqoqnj2D1fa05YZtyylapzNtKqUcUnSV6lQiGOvpaEqia1z4+CU0EujZuK
 z8slzcjnLJT6WVIO8/CyUOhGA/uig2twfnnqgLkfB/X4Ry5ONLCaE2XlP/4KNCfIgVWF7Z3PSIJ
 SstEOtkuHG8KiuuVRcFxeM0t0MbHEnQnJpLGSm3aJszr5yRvpnU5Jz4FyCpoA7XnLt/fMji9G3Y
 LZ6+7BL+AnpE9gueoJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDAzNSBTYWx0ZWRfX1ZkaCviUa2/d
 DJvfs8ePTcGHG/puHQ+mhXbctWK9j05agJriVy9jPFY7bPguhs4s/S8B2I4squ0orxuWF3P8wRX
 17hv5nYBGceD1DkD76WNXPRm2O+LN0o=
X-Proofpoint-GUID: UG9yTN_Yu-_hjZgTGK3DtK5Gd6gzN0RF
X-Proofpoint-ORIG-GUID: UG9yTN_Yu-_hjZgTGK3DtK5Gd6gzN0RF
X-Authority-Analysis: v=2.4 cv=dfCwG3Xe c=1 sm=1 tr=0 ts=6a5708be cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=0F-xt6_jZRxGZ832hTMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307655-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:skoteshwar@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B38D75A6AC

From: Satha Rao <skoteshwar@marvell.com>

sync ensures that all packets that were in flight are flushed out to
memory. This can be used to assist in the tearing down of an active RQ.

To complete disabling RQs or disabling SMQ and its SQs, LF software
send mbox to AF to complete RX_SW_SYNC.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  1 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 20 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index f87cdf1b971d..92175de036d5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -362,6 +362,7 @@ M(NIX_CPT_BP_ENABLE,    0x8020, nix_cpt_bp_enable, nix_bp_cfg_req,	    \
 				nix_bp_cfg_rsp)				    \
 M(NIX_CPT_BP_DISABLE,   0x8021, nix_cpt_bp_disable, nix_bp_cfg_req,	    \
 				msg_rsp)				\
+M(NIX_RX_SW_SYNC,	0x8022, nix_rx_sw_sync, msg_req, msg_rsp)		\
 M(NIX_READ_INLINE_IPSEC_CFG, 0x8023, nix_read_inline_ipsec_cfg,		\
 				msg_req, nix_inline_ipsec_cfg)		\
 M(NIX_MCAST_GRP_CREATE,	0x802b, nix_mcast_grp_create, nix_mcast_grp_create_req,	\
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 78667a0977c0..47e1a4e3392b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -273,6 +273,8 @@ static void nix_rx_sync(struct rvu *rvu, int blkaddr)
 {
 	int err;
 
+	mutex_lock(&rvu->rsrc_lock);
+
 	/* Sync all in flight RX packets to LLC/DRAM */
 	rvu_write64(rvu, blkaddr, NIX_AF_RX_SW_SYNC, BIT_ULL(0));
 	err = rvu_poll_reg(rvu, blkaddr, NIX_AF_RX_SW_SYNC, BIT_ULL(0), true);
@@ -289,6 +291,8 @@ static void nix_rx_sync(struct rvu *rvu, int blkaddr)
 	err = rvu_poll_reg(rvu, blkaddr, NIX_AF_RX_SW_SYNC, BIT_ULL(0), true);
 	if (err)
 		dev_err(rvu->dev, "SYNC2: NIX RX software sync failed\n");
+
+	mutex_unlock(&rvu->rsrc_lock);
 }
 
 static bool is_valid_txschq(struct rvu *rvu, int blkaddr,
@@ -6324,6 +6328,22 @@ int rvu_mbox_handler_nix_bandprof_get_hwinfo(struct rvu *rvu, struct msg_req *re
 	return 0;
 }
 
+int rvu_mbox_handler_nix_rx_sw_sync(struct rvu *rvu, struct msg_req *req,
+				    struct msg_rsp *rsp)
+{
+	int blkaddr;
+
+	/* NIX_AF_RX_SW_SYNC is global per NIX block; nix_rx_sync() serializes
+	 * access under rvu->rsrc_lock across mbox and teardown paths.
+	 */
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, req->hdr.pcifunc);
+	if (blkaddr < 0)
+		return NIX_AF_ERR_AF_LF_INVALID;
+
+	nix_rx_sync(rvu, blkaddr);
+	return 0;
+}
+
 static struct nix_mcast_grp_elem *rvu_nix_mcast_find_grp_elem(struct nix_mcast_grp *mcast_grp,
 							      u32 mcast_grp_idx)
 {
-- 
2.43.0


