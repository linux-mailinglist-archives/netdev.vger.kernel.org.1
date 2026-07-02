Return-Path: <netdev+bounces-303981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dRmoOfnvRWq3GwsAu9opvQ
	(envelope-from <netdev+bounces-303981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:58:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ADD6F37F8
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:58:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=kYr4rqEV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303981-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303981-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B43A306077E
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 04:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE58366049;
	Thu,  2 Jul 2026 04:56:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04F036493C;
	Thu,  2 Jul 2026 04:56:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782968203; cv=none; b=B0zRWxk/c7FKPIOcNP/zTZDg/JbTTTq2uSoW8W3DOJrHXUGg3uocoOX/LyIJ3TpcfbrTJYVpPZv/g/SPtBSdrwyOo/Nz0XKQXhdCfs9d5RXIgSp5nc/9GkoV7JtSM85+TqaM2bkejmSBUfvk7s5A+cuRZo1dN/sJtJMM7ocjY/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782968203; c=relaxed/simple;
	bh=7gTJMuPnSVRmdy3m/A0Ydr8qC7rV6vskwAoEpmuDDYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=npwZSLzoxXAws/4FCFFIuGXbW7Pu1ldtiynmyJibKPse0sjdX5aaVLn+tOKVfoQ1WajBPF5msvRUmxvaYXsf7lc8t7xcVi5GAmszY/V2zWfEcJ2hIe5XugXClE6IdlzNe+vWD4LynievGndKu6lEizEhC9yVfqVK/DuHHds0Uu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kYr4rqEV; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621Mrb9570199;
	Wed, 1 Jul 2026 21:56:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=2
	qNgs/yDjGKz4/dWCfvR6GRltfOYCfcaDqs7slA89/M=; b=kYr4rqEVOnMOj7QZs
	bFThOIJ/I27j3iWusLh2OhNbDM67G379iathmqTWrnlVobPyNBJlGsHmvWMh64mI
	9Qwp/6Jt2piyOYDMQ7336J6Lh68yOnnYX1APUDJ7xKA9ZgtsnigXylsSbm0b7al7
	tk8nmElLY+zrG591Ipiq3SFQUu5bS6zQ83mAngQzMiYcy4ILLLwnxk9bbP84/J8k
	0PZEjqPeKiW0YZR1NcTIe+cYKHdgcAgZwjSgdEV1B1twh/gX7mz2bGTVmHySMxUj
	TggSrA52JwfmdaLauWRKyGWTY2ZYDBSvpyk0GrQSNU0O3y/H9UitLOwpRaMB1j9k
	HREaQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f5b99111f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 21:56:32 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Jul 2026 21:56:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Jul 2026 21:56:31 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id D40D43F708F;
	Wed,  1 Jul 2026 21:56:26 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <naveenm@marvell.com>, <rkannoth@marvell.com>,
        Harman Kalra
	<hkalra@marvell.com>,
        Nitin Shetty J <nshettyj@marvell.com>
Subject: [PATCH net v3 1/1] octeontx2-af: fix VF bringup affecting PF promiscuous state
Date: Thu, 2 Jul 2026 10:26:16 +0530
Message-ID: <20260702045616.3002773-2-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260702045616.3002773-1-nshettyj@marvell.com>
References: <20260702045616.3002773-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: PzI7hiawpeG_eqsiKZula1dbzftNyg21
X-Authority-Analysis: v=2.4 cv=GPk41ONK c=1 sm=1 tr=0 ts=6a45ef81 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=ZiVtc4tnZ_wSfkjzQ8sA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: VnqoIhZ_C1h2nujezPbvhUR-CeEiPHrh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA0NyBTYWx0ZWRfX/REQ8B71dYL7
 PvqB3g1HKlVuXCh24M0CJc31MuOpTXvpFVt5XB0ns/yZfvmWYnGZr2C36YO0RZ3nSI5VclNhaVq
 ADBLFZHY1lrVMT/lUxYJ+5o5GJi9qwrCBHegVNoEVowc8/ekhe8d9eVSSHLcvHQQNFlSv/qrw1c
 wU2ZmjkEjhtwGXO4mwOwBTQpJcQHCmkayAxouIOmkot3tfqnn8fkkYgl3e4CmYKgWlWwcw1imUd
 diVkECNAcfZbwCoP5i3GmFmxmCqcBIiAFxdRJcCHXLWuVMUc0+kBqfXRnsHKObbrgIiO9HcOi6m
 SQC0vnGdDc7IBEYdcOqTBhKFqVcVQ/SkNI+pwroF+1xR3afU9Yktg1UQLvHtG+VUoxf7DNTEjFr
 QxtdK7kGeY6iKKU6xNPbY297x93+NTStGao10iDP4vmN9W7ThaaNpLpBERVIRcgeHo/+b8LBb9o
 aNmzNAZar5kIsB57OkA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA0NyBTYWx0ZWRfXxUAgcNff37Vx
 EQK8bDPJ/PwD+BkfkOAKs/Hf9PCKjLJ4ikjWFR5joYRD/g9McuLJqFabzeXUA+sQxqO2hIwSUFJ
 RnytqYJT2jTJiTYu8f7QeTflyZ/YPYk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-303981-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:naveenm@marvell.com,m:rkannoth@marvell.com,m:hkalra@marvell.com,m:nshettyj@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
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
X-Rspamd-Queue-Id: 66ADD6F37F8

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


