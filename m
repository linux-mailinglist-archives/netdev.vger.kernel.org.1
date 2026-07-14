Return-Path: <netdev+bounces-307330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l6JKIPyZVWrKqgAAu9opvQ
	(envelope-from <netdev+bounces-307330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:07:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E90AC750473
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:07:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=L0pm1sBL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307330-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307330-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E57B93035163
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB07337B019;
	Tue, 14 Jul 2026 02:07:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4720837D137;
	Tue, 14 Jul 2026 02:07:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994861; cv=none; b=T/7Ur+tjTwqvF+AKsTEaHVAB42C0u4ZM0lOZ/KuUti9yiPtOS1DxxvtZsSzG5YW4Rm3T6fYoJcKNmC1SVFMiEcjA8c60+lrLOg04oz+Rc+sqDwwvdc7IRBB7wOVsYYwKWZ9BpnRG+XqjXPrwgYnk6pFMTTRrA28oy+e/h77b9MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994861; c=relaxed/simple;
	bh=5xXzHySaNJWSbamT11PFvfOuZEpm43jVYB5y6KN6Hzs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aP1EtPv3VCJwLnDID5uzSaCb2svoBfIgdrRKRTvbmAv8Xse9FuzS0mdioTn3SzFokBz01oeT0C75W9jS5p/v7OcDjstzd67WHtHDC7zLQgDXwz065abE/p5epD3JUgYLK/FWK/2P/GuCwJG/2Z9P4WpfHXAXifZBmELB2cTstT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=L0pm1sBL; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DNnDrf2948220;
	Mon, 13 Jul 2026 19:07:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=oz/t9+TW8tiXSvTnrorof7B
	jnd8uIEMev60XemHz2fA=; b=L0pm1sBLqQmHjH2HxB6NoRj3ouww3RgSbxUE5/M
	1GAIH1TBAnd/QklloS6ybVi4gmQQDt6LW7t7U5EoPJYcdLzxMjRvmIUAkhHhuzRD
	yix4DuP/EKv0pSDR8HV6HP55kqbI8BiUtdLqtsi483LenGo+3kthnF1D9KxP6btT
	fc3fS8ZfLMxEHeDdR73RZSHsWnK0Qa49CrdDFFEyeJCAvExcjSIA0LfoQ4GPEXXA
	4RwycHoHZtugiXHV6ZyCk7ve7WEwXT78Noh/xp9de1IsjVPlH+UkrcyOTteJnKRd
	empqDTpLYyZ5p1eqwuXeymzL8wcM9/km78WdYjQj0Q1smVg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fbnbex630-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 19:07:33 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Jul 2026 19:07:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Jul 2026 19:07:32 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 7B6B45E6866;
	Mon, 13 Jul 2026 19:07:29 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Satha Rao
	<skoteshwar@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next] octeontx2-af: add new mbox to support sync cycle on rx path
Date: Tue, 14 Jul 2026 07:37:23 +0530
Message-ID: <20260714020723.1811237-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: sgVy49OKCbPajte6HDxxWo-D36yVMmwL
X-Authority-Analysis: v=2.4 cv=WOdPmHsR c=1 sm=1 tr=0 ts=6a5599e5 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=0F-xt6_jZRxGZ832hTMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: sgVy49OKCbPajte6HDxxWo-D36yVMmwL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAxOSBTYWx0ZWRfXyOdUWGsMZ+ej
 uSEgQwn0bcXcwd80JaAQbTH7nIl93K9r9z1dcx4xn/HixoEsqifm1Ou1M2lVD0pscuoK3DorgzD
 1FJy+kfZ7IHsy94l2mSYicz3zpsY46Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAxOSBTYWx0ZWRfX/Kq/o15nzV/7
 IFkUYREkVvo6dwU6e4cPKYvNtzB/gQ8ZvAOL3AUsM9R8+LnDJ1lty4L5XOQhKFShRn4SZae8faF
 Hjjx488/535DM16FowesRHnhe67gun1W+WQWEOmDWx5lKGCDWgypBOFTXk1uOhNvt734R/sTP4e
 lBtqOrkliQjeVIw+6WxCgRUH413a0xpVCFkeyOBp8rxYMldhqZ6YezfQTxdPiWeCBiGv6fGJ5Xn
 F4vz5ikDnWui0HGKNRrv3Ssi/ukMGn0HoWSeit9yRCOUwEi0CGFAnwUj9X5TCYxsew2CekBws4W
 bi2ESc5P18AoeTpKa/UYs2HFzcET9mWkhsnvLdgD7PQTVZb7ER4kkv6yVJi4ScVPIrq8DtHONJz
 57z5YTQVYSYeG0qZik84bnQsJ4eM55/ERgTUeXBSqd22hc9SqGxBxFuW1rAH6HequHl5JFujR3z
 gp2JZ2RKivTva6NenNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-307330-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:skoteshwar@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:from_mime,marvell.com:mid,marvell.com:email,marvell.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E90AC750473

From: Satha Rao <skoteshwar@marvell.com>

sync ensures that all packets that were in flight are flushed out to
memory. This can be used to assist in the tearing down of an active RQ.

To complete disabling RQs or disabling SMQ and its SQs, LF software
send mbox to AF to complete RX_SW_SYNC.

Change-Id: Iaadf5e6b26a7920693fca9921b2050af0e8e2322
Signed-off-by: Satha Rao <skoteshwar@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h    |  1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

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
index 78667a0977c0..0e2e6cde3de2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -6324,6 +6324,19 @@ int rvu_mbox_handler_nix_bandprof_get_hwinfo(struct rvu *rvu, struct msg_req *re
 	return 0;
 }
 
+int rvu_mbox_handler_nix_rx_sw_sync(struct rvu *rvu, struct msg_req *req,
+				    struct msg_rsp *rsp)
+{
+	int blkaddr;
+
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


