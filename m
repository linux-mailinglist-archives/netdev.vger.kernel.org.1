Return-Path: <netdev+bounces-307683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2gTFIaU3V2oZHgEAu9opvQ
	(envelope-from <netdev+bounces-307683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:32:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB4A75B76D
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:32:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b="Cu/NfRTn";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307683-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307683-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5339301F480
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D4A3112DA;
	Wed, 15 Jul 2026 07:31:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379BA3019C3;
	Wed, 15 Jul 2026 07:31:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100705; cv=none; b=MnSl1u/+ySs9qJ8uDOgdLvLw2eJ/kQDwBFAwYUAGcvW/3sfl3sjFpIQmGG6pyF0OGx6l5qt3xBIVOs8VxhC1vTseGs0lZbjexKb7iN3FV09m1C6olGEfv0Ssmv7pCLfG3tzdULcD9NlEbhIgFbbTryonaTxrAGqgsNJ58H/OVBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100705; c=relaxed/simple;
	bh=uEdkfiJrOo9VyHc0Ck0Ar4SOPXpkPzT4/Oj905lrKqs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y3hrK5rXDZF5HjrE1MOCqifz5o4Id12gMm2BE6JzU5H9C/6xdORvaNIyP9nxjp2/Tl6OLGY+as+c0fDyNJ15urRRmKBkQefzYVuOrHEp6QBm+JpwCNzm/08fGqRIThRQc3tYfWkrUJRpYtcErIoHs6N1VOZuknt5wBqS6UP100k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Cu/NfRTn; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3lO2d1893071;
	Wed, 15 Jul 2026 00:31:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=RcJRDN43yaxKPhIDRT7I3C7
	OcsVbvhyi4prds4LBzOo=; b=Cu/NfRTnHXJipMxnP3LNcv7lp6BgVsV7lqe2axz
	hlpx3ZzVomToG0WKknsTwuGlNd41Kn55j6DUwcKFKD77JRgerlDrMm+uoP8eMA/7
	mkfo/UWwffW+dBcKmCUWTqIv9oIQXXITXHHQLCKMErMxTQ4AyyAZf1WqLx3GshV4
	DKgs6H23Kl3ebE3pEOASSawWssrMGS2cC+2avHksrhZj9QhJQZUQh8/14oYD0KnJ
	1EXZyMnc9h+3w+DHuxy4e24DxRb1YrW/1GZJ5O7lIledhjOkU6VUaIAs2CgvxdFH
	ZXte4ERnimnttDpijm2VrXmJ1GhPJW68NpAY05ItaOI8D1Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fdkdc3nsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 00:31:35 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 15 Jul 2026 00:31:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 15 Jul 2026 00:31:34 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 6180B3F7044;
	Wed, 15 Jul 2026 00:31:30 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Shijith Thotton <sthotton@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] octeontx2-af: return VWQE timer delay in NIX HW info
Date: Wed, 15 Jul 2026 13:01:11 +0530
Message-ID: <20260715073112.622662-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA3MSBTYWx0ZWRfX8FBdLPMmM5Vj
 pw6fggXubWDa+tpLzio9etpI25BShyKVx2eN7Bq2B2QxbL6b30pGj9UwrXixBFzYRzxCvq8Nj7V
 u/s2Y/0ZsfBeD1BGEI2+Vw6XXPVfw34=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA3MSBTYWx0ZWRfX6xD7mYxSW0tU
 UDsa+wYs79dUfVLSUXt68mXpzvyD7hisJfuy26j5ifkWUNCRS1F99nd/Tc5FGyKb/DN58FlBNHE
 PbzDQTinMoPkjZlz4PtKvZcwyU4X7TsLZRo2llu7h3BujbArNAWqaxaUdSCFsUiDuBAk/LlDGS8
 7NIasszl2eLYO498FAaVcd0r75J60yN6BRurVK4kslWi0qFJXnWHfp0kvvqTCLdQP3uV/JIv7bi
 b/pg6qbKNvpZqmNhxQlLpXIMm7/OXDKJz/lxu+DIHemf/gndM1iDUH6FPCjeoWazSdCCPFT8p55
 rL7NJsqnfB0H9Ea1gnNTRvLX8RXn4F/GWPKItXUsLyja4cQvgOZtAMUWmJmN/NanmsL4USbEeNZ
 DkZ4cq/4Monz9rY7YLouoj55+thc9APcShioBDeTP2Zb/7vCQMKnFekGEHtO25EKU3I1u/ZY/AM
 VOylG0VQKnYBtjLTCTQ==
X-Proofpoint-GUID: PnxuLbFT6fYnDLwKmwiSIMYISMF97ZcY
X-Authority-Analysis: v=2.4 cv=WsYb99fv c=1 sm=1 tr=0 ts=6a573757 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=PdPszD-o5J0UizkRgOIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: lsHfrib_NPs1pby_IMi5S6yIQYurtN6s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307683-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sthotton@marvell.com,m:nshettyj@marvell.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:gakula@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,marvell.com:from_mime,marvell.com:mid,marvell.com:email,marvell.com:dkim];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEB4A75B76D

From: Shijith Thotton <sthotton@marvell.com>

Update the NIX_GET_HW_INFO mailbox message to return the VWQE timer
delay, which is used for vector packet wait time calculation.
Repurpose the existing rsvs16 reserved field in struct nix_hw_info
to vwqe_delay and populate it by reading the NIX_AF_VWQE_TIMER
register (applicable for non-OTX2 silicon).

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h    | 2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index f87cdf1b971d..253dfee9646e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1463,7 +1463,7 @@ struct nix_inline_ipsec_lf_cfg {
 
 struct nix_hw_info {
 	struct mbox_msghdr hdr;
-	u16 rsvs16;
+	u16 vwqe_delay;
 	u16 max_mtu;
 	u16 min_mtu;
 	u32 rpm_dwrr_mtu;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 78667a0977c0..c5bddd2ad920 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -3936,6 +3936,11 @@ int rvu_mbox_handler_nix_get_hw_info(struct rvu *rvu, struct msg_req *req,
 	if (blkaddr < 0)
 		return NIX_AF_ERR_AF_LF_INVALID;
 
+	rsp->vwqe_delay = 0;
+	if (!is_rvu_otx2(rvu))
+		rsp->vwqe_delay = rvu_read64(rvu, blkaddr, NIX_AF_VWQE_TIMER) &
+				  GENMASK_ULL(9, 0);
+
 	if (is_lbk_vf(rvu, pcifunc))
 		rvu_get_lbk_link_max_frs(rvu, &rsp->max_mtu);
 	else
-- 
2.48.1


