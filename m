Return-Path: <netdev+bounces-300657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HJ82DwIHNWq5mAYAu9opvQ
	(envelope-from <netdev+bounces-300657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:08:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FA06A4DB9
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:08:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=Vg6lsPtI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300657-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300657-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6BD93020EC3
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718FB360EDC;
	Fri, 19 Jun 2026 09:08:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B31B360EC3;
	Fri, 19 Jun 2026 09:08:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860096; cv=none; b=OiLOL0ydunOc3tf6xR7c8g3qV+vD2AtewQgSkoBjIs741ENAT+WBFZGn9clxwwfJUm68fR/pRrCb7C8yCvmaJK6Y4NFSeHZZ6RuayblHFMqVauT823CquJatUCBlC0rQXU9rJrpregRWkAyTY5mGG+bVcI/wl3z27nctjUJjfts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860096; c=relaxed/simple;
	bh=njV8yyfltUGMBGo120+qx89wCNdVCyXDZngn4+oyZS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxNCVHCJWQ0TgvnKECQ1vCyCfWAnIG2thBX98mBnnEQLydinWN6MihKa/lX6MXSjIOJ3faJtIM67mOSCrvWXokV+0Ai6roBeRVqJD4ylzwGWfQLqNDxfuMbkPD8PIMWCJRDectxDXxxiHFh6bDTg46Wc/DdULn89MiDwV4kO89Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Vg6lsPtI; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7Qv8a1746532;
	Fri, 19 Jun 2026 02:08:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=U
	HgOPGM0ZrZwdHpUPotVKyLphfzvwAMjjr39iviQDf0=; b=Vg6lsPtIA2ARSmPZF
	clG7zA4d0q28CmUP95KjrsWJ6CD8Hsj+Guo6XKeeRkoSl0h5v6i2j3jkQleae0Ic
	4jNn9oQ5lYAg7ZIzUKk3kAK/l+b4vniRD5CRak8ia4sWFmt0Ny9i9lk9LFIjlwio
	tAPPPIzzzfQqBML+/9v8iKaGLklpor+yiZetRD8qF0PRhmB3zsaVAc9a851Z2c46
	g+wbzBKhBV+FbQSOufuLPSNhJP4VuPYPLff8rMncMstzygIPaUiDfXvI2T6LaQQT
	a0utyXBP9bmzhqxo2hj5jFKH6kdJh98faB0dAy9GSzaPKKpFwUMD/a9z3/rTeEIG
	Q/39A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ev59ddehr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 02:08:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 19 Jun 2026 02:08:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 19 Jun 2026 02:08:05 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 2FE515B692E;
	Fri, 19 Jun 2026 02:08:00 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <Sunil.Goutham@marvell.com>,
        <naveenm@marvell.com>, <hkalra@marvell.com>,
        Nitin Shetty J <nshettyj@marvell.com>
Subject: [PATCH net 1/2] octeontx2-af: fix VF bringup affecting PF promiscuous state
Date: Fri, 19 Jun 2026 14:37:45 +0530
Message-ID: <20260619090746.1829416-2-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260619090746.1829416-1-nshettyj@marvell.com>
References: <20260619090746.1829416-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: zsVpE_jAMv4oyE4z-jgNkTSGvkGAT-IB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA4NCBTYWx0ZWRfX15qMwpvu7buP
 M07hvNhr0FkF2V3dFge2FLgsxiutWXmi/OT6+/+nduNHJo1NPExT3wimP+DxJac/FsyQJ5ZoOp4
 oYYkwXvNQi4NxOmg9IGEy0B2amkPSWBC4+0/riD5rh7SFeiKO1xg1p4owiACmuMzn8/ZmcEuG9m
 vSpvr/qiJx9gQiqyDWpj2CDGWCYEDI8B8+/1J9VP94sxodK/hOUcV/FNfnxV7DrQYV5Y/MwmfIf
 cTjW7+9HT5ro71DQkslmHRAoVaNXsUwpS2GSr1nlX8+FXWI+s6FiApJnCnjCFMAfldBYO8wLfwh
 rIkKs4dggMudL3DZssVdQuqUW1mQF++a4j6s6dbooei/DYUT548LClIsh849bWvJVQDbNwqIkx+
 T4eEydWRIUUVXxu0xOZPeZ5xpKg7kVppptc2L0lrFwRI6R31jxX8ocnHcGgOloqNjk+7nWRmokj
 4XpjocDFEOc4C3iWW0w==
X-Authority-Analysis: v=2.4 cv=c4Cbhx9l c=1 sm=1 tr=0 ts=6a3506f6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=ZiVtc4tnZ_wSfkjzQ8sA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: NvVJgEV6oDNipgHK66-TMqdNhDsyk_qN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA4NCBTYWx0ZWRfX4CKIVQnhJOOE
 BEMhfiHLwYCST4MV/4sOKZUNphAL542onllZmKJj2Gq5Qc8D6DUp2UXwDZJuqDe0mpc4ej/q0UQ
 sJZrHXaV0ulT0Aj8F5Oto0bp0r/N8s0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300657-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Sunil.Goutham@marvell.com,m:naveenm@marvell.com,m:hkalra@marvell.com,m:nshettyj@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
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
X-Rspamd-Queue-Id: A8FA06A4DB9

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
index f977734ae712..f4c066aff371 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4548,7 +4548,7 @@ int rvu_mbox_handler_nix_set_rx_mode(struct rvu *rvu, struct nix_rx_mode *req,
 		rvu_npc_install_allmulti_entry(rvu, pcifunc, nixlf,
 					       pfvf->rx_chan_base);
 	} else {
-		if (!nix_rx_multicast)
+		if (!nix_rx_multicast && !is_vf(pcifunc))
 			rvu_npc_enable_allmulti_entry(rvu, pcifunc, nixlf, false);
 	}
 
@@ -4558,7 +4558,7 @@ int rvu_mbox_handler_nix_set_rx_mode(struct rvu *rvu, struct nix_rx_mode *req,
 					      pfvf->rx_chan_base,
 					      pfvf->rx_chan_cnt);
 	else
-		if (!nix_rx_multicast)
+		if (!nix_rx_multicast && !is_vf(pcifunc))
 			rvu_npc_enable_promisc_entry(rvu, pcifunc, nixlf, false);
 
 	return 0;
-- 
2.48.1


