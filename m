Return-Path: <netdev+bounces-301257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b2uxAd4GOmoS0QcAu9opvQ
	(envelope-from <netdev+bounces-301257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 06:09:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFCF6B3F51
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 06:09:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b="X/wSk1GI";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301257-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301257-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B28830480DC
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 04:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322B139FCAE;
	Tue, 23 Jun 2026 04:06:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10D039E9C3;
	Tue, 23 Jun 2026 04:06:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187604; cv=none; b=UV0QGB7Yt2t/QDx4BCHFXCiVyZ8GvIUauAhlIGwoHzQGOXcg0prIvNf3GNaEH/7weTjhsvOLiIEBXXgevfFJvtlwnap6pKrx8d23GIii6o/yX7uy8UXMMjXTf207b6pGwF73fx86dUB/SDcaxahwwKbC2dO/Qs7nXQIu0Wdv6oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187604; c=relaxed/simple;
	bh=7gTJMuPnSVRmdy3m/A0Ydr8qC7rV6vskwAoEpmuDDYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eeMkQnoBxdDREk8Yd5XbsrAvYFSLX3H0NoP/wh/3FBDCFXqko9ml/dhvZ/N3sQg1v6v8Iagoy6bEziSRDmUgxUtMHySumB7f+8hPAWaZL+aq1Qsmy2Vz/Dw0AhiTy2qSx/1rXHvLD0bw2RX3M3Fvc/Ob8sTByscrdwXTaDtPQn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=X/wSk1GI; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0fofk2739278;
	Mon, 22 Jun 2026 21:06:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=2
	qNgs/yDjGKz4/dWCfvR6GRltfOYCfcaDqs7slA89/M=; b=X/wSk1GIdJXVH3oDh
	0smUv0WUZqsPxedqHbRo1pH8klr21mJ3kthFcr4S6P4FR4BiNdk/m/expVQpCNNt
	uzugGFW761jgN/ZUYFrLQI//TSixUGT5JxmSXXh11VApjRxRvH5Ob/g7/kzNIk4c
	5Wv4nvOY6YqzKZyuhfRtQVwkHqtMY5GrHR2p0zHA/SHY8J3//Y8M6EwBmmwsqXOg
	HaoozxTNO0oAW2/yrI/4OqdR1hbSK3+e7qgTDVW/5tKA/FTGVEnjP+BtiSrXQ892
	oUEiIb90EupS767pPfe0fRSWpxKTG/2/ABFlRQTmUOYC/i71USB8xKuocRlIYhvE
	9ikaQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eyerdgjt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 21:06:26 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 22 Jun 2026 21:06:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 22 Jun 2026 21:06:25 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id B7AD83F7058;
	Mon, 22 Jun 2026 21:06:20 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <rkannoth@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <Sunil.Goutham@marvell.com>,
        <naveenm@marvell.com>, <hkalra@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>
Subject: [PATCH net v2 1/2] octeontx2-af: fix VF bringup affecting PF promiscuous state
Date: Tue, 23 Jun 2026 09:36:08 +0530
Message-ID: <20260623040609.3090846-2-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260623040609.3090846-1-nshettyj@marvell.com>
References: <20260623040609.3090846-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=IvYutr/g c=1 sm=1 tr=0 ts=6a3a0642 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=ZiVtc4tnZ_wSfkjzQ8sA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAyOSBTYWx0ZWRfX+Ob0pGzvdDv6
 V3TS1Ra29wFBZeOe4DIy5N0n+UZrZ+ZzHz23DW0aE0WncyfkzK3CN2Lp83NC3CS/5IP1nIkMA+o
 cV80JvPsHmBz8KUI7TxzCtuWIbqwXuQRiNsnFSzLKa5MbxNpvXvvQuC2bj+yL9RCW4H44qhMkSj
 VPEscfKEPB3tUPir4OQbaEhfTtDLZXE+AzF8mn9NXubenYk79zVAcSlA6djkAOWJ+1pBg1I2Qk8
 siOTNmqSraqmBCa8nPKdPpboVh6rl9MsopsP7p61FlZ+PrZPMU4TZM+/h0VoRtYJoywcC/4dW5J
 Jiu8OsRalqVqmrfVQL4JuMQp689cHGpu4IxSFlsIZyLqhjVt3adFwFtxKiR1CL9jqNYmIuJ183h
 K5XIvLKJq2Dve+MBm2BumK8eHuvi+d0XvHf9LeyVGq3KvgKrsRZId3o0c9pJTkc0khD5FpyycWG
 py3j5nxMklb25ECm4ow==
X-Proofpoint-GUID: IVGfaWjhJ60fvdwMDgho-z4cuaqzzqB7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAyOSBTYWx0ZWRfX3g/71p0AW8Ny
 4ZbfbThrTERk4GhUk+vjnFux58rDr6K6T9Gegi+x4RHAEBfv5yeL9olnWxzp3Anx3Tc2RKiW0IG
 TDFaKls9ZmN7yc3MaahnlkH+swRGgBA=
X-Proofpoint-ORIG-GUID: _rHp2tsh36ogieUj9tG7eOTSRUi__E9j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301257-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Sunil.Goutham@marvell.com,m:naveenm@marvell.com,m:hkalra@marvell.com,m:nshettyj@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CFCF6B3F51

From: Harman Kalra <hkalra@marvell.com>

Mbox handling of nix_set_rx_mode for a VF with promiscuous and
all_multi flags set to false causes deletion of the PF's promiscuous
and allmulti MCAM rules. This occurs because the APIs that
enable/disable these rules operate only on the PF, even when the
mbox request is made via a VF interface.

Guard both rvu_npc_enable_allmulti_entry() and
rvu_npc_enable_promisc_entry() disable paths with an is_vf() check so
that a VF bringing up or tearing down its interface cannot inadvertently
clear the PF's MCAM rules.

Fixes: 967db3529eca ("octeontx2-af: add support for multicast/promisc packet replication feature")
Signed-off-by: Harman Kalra <hkalra@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index d8989395e875..a7e0e0e05ad2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4575,7 +4575,7 @@ int rvu_mbox_handler_nix_set_rx_mode(struct rvu *rvu, struct nix_rx_mode *req,
 		rvu_npc_install_allmulti_entry(rvu, pcifunc, nixlf,
 					       pfvf->rx_chan_base);
 	} else {
-		if (!nix_rx_multicast)
+		if (!nix_rx_multicast && !is_vf(pcifunc))
 			rvu_npc_enable_allmulti_entry(rvu, pcifunc, nixlf, false);
 	}
 
@@ -4585,7 +4585,7 @@ int rvu_mbox_handler_nix_set_rx_mode(struct rvu *rvu, struct nix_rx_mode *req,
 					      pfvf->rx_chan_base,
 					      pfvf->rx_chan_cnt);
 	else
-		if (!nix_rx_multicast)
+		if (!nix_rx_multicast && !is_vf(pcifunc))
 			rvu_npc_enable_promisc_entry(rvu, pcifunc, nixlf, false);
 
 	return 0;
-- 
2.48.1


