Return-Path: <netdev+bounces-300658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AGB3GXYHNWrImAYAu9opvQ
	(envelope-from <netdev+bounces-300658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:10:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC6A6A4DE1
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:10:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=OS6GkCZY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300658-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300658-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A0443003631
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EF4360EF0;
	Fri, 19 Jun 2026 09:08:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E013603D7;
	Fri, 19 Jun 2026 09:08:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860103; cv=none; b=aeXMQfqj8d/O1F3/VfWuV2rxRmSiVjSEoVNo3mn0EfpaBgmfpEZMZdAZjGOA7SPO65WFQcEJKCvJiAX/Z+jURVmih89SYeLoZz9KH7R5xBHrdhP5LjAfTswlYXXHqskKOEANPVrBDcwKBHUS4rZfqaAR1tSo51iPHRyWqwl9J4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860103; c=relaxed/simple;
	bh=bctLAr7e+rqnWX7szupANse/GMf9YprpkuKsuKWYcbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/2eh45eJBV2FP52FFAzJ9ZGYzvZNe4cjRIViaLQ+k58Aojo5LIU+WMnGZSTNZR4xGjzdzLIcAM/tDdL4rkYJcpuXHTsGAuyAgn8YpyTocyvydXcCNlCFCVzcTu4FGZ7+3v3NvqgXbAJ1OYNJCY0f/ZynUBVL+KoQDiIZIXxQoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=OS6GkCZY; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7Rqwo1671610;
	Fri, 19 Jun 2026 02:08:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=M
	4uQRQQY9x8ebzHPMlmrS7YdNNfEKKZoJVcSJHTZB4Q=; b=OS6GkCZY055vrrMYw
	G+W5eoekfwSda0z42L7UO+Iq/y9KQMh6/GEctTboaCp2ZT1T4dLL3IIP0uvcfcun
	7XZQsorghtYMqGqHIHRnNOxI4GeCS04tLB6dr2UJmQaBFoFb3CZMdv5jnI92r8CO
	nUc4HThy1XUmRGpKtKD/+dvfSiLIQb0ciwLbHlJeor+995Sa+9fk1yCljDvNeYIB
	0aPnjhsNnaqxF96hcoHp5cWsWJlgbLTjAglDA9ex4Cu9UOVTZ2qy8KqzEBBmq3KQ
	DYjEgMvYoYnA0vv2Hrrlt5yXoYoGYlN3t04MU3jAvDiAtxKMCJsddJkZ2F1WTHF8
	2Fj1Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4evtcb18ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 02:08:13 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 19 Jun 2026 02:08:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 19 Jun 2026 02:08:12 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id C075D5B6930;
	Fri, 19 Jun 2026 02:08:07 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <Sunil.Goutham@marvell.com>,
        <naveenm@marvell.com>, <hkalra@marvell.com>,
        Nitin Shetty J <nshettyj@marvell.com>
Subject: [PATCH net 2/2] octeontx2-af: suppress kpu profile loading warning
Date: Fri, 19 Jun 2026 14:37:46 +0530
Message-ID: <20260619090746.1829416-3-nshettyj@marvell.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA4NCBTYWx0ZWRfXyhe0e2do7rcp
 2B9pY7qYng7wHVQ735z1DgVEf8N2X+iuViiwXYigiwxGfgvnA3ByYsUXyrveCiFpW/7tkz00CpI
 s1ZkwLo/jnYg/+pcv36AOS67ILJqeg4=
X-Proofpoint-GUID: W2ULtocGPFMhC15BcRBpqpOQwn2ZxdM1
X-Proofpoint-ORIG-GUID: P-Phhgby7zkpBvcdJ2FtC3xNkItu3I62
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA4NCBTYWx0ZWRfX4wQRl1GNTyJy
 y6KtWKGFVROG23iXtdHAJT7D3DzMUl6CAG5coUAjfu1iqBRvkxoraAciKGj+nFZogZpyasDIcW6
 KdpvirBhQs3Xa0pl0nFqJWRTkmCDVsMPOBFGPlAqihQMmHf/L3QokvE4S4IzHMA142B/KPPxG+b
 noqeQNYXHpDvuhEFiZoQ346H6Zw6arNINK87P2vZguqhQOgztA1N7ofDh77g3hIbEM1vPRYw5ZL
 2Pn63JANR/1viiPXR6PuqPAGl2ZMz2k0iKuy9oU9WRCs1vWV0sPWm32XQz60IuzjYVaZ+AHE10m
 8P5Wztvefo6eQJ3jKWdu32KghWmHfv7+ZPULQ7vOd7hUX6L85qlCLUvnddhCcddj75EsE1XSth1
 EpCZ/YIcLG71xSYztDw8m88aIVNSNFsNZn70uWSAb7maCx9J3iJJKU+uNQSIrghHVLR2E+bj1Zn
 7FehNqWdyInURF9GBoA==
X-Authority-Analysis: v=2.4 cv=YM2vDxGx c=1 sm=1 tr=0 ts=6a3506fe cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=K-tenT1Ek76uFhoKguQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300658-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFC6A6A4DE1

From: Harman Kalra <hkalra@marvell.com>

There are three ways in which a KPU profile can be loaded
(in high to low priority order):
1. profile image integrated in kernel image
2. firmware database method
3. default profile

In most cases the profile is loaded using the 2nd method, which
causes a spurious warning from the Linux firmware subsystem (method 1)
due to the absence of firmware in the kernel image.

Replace request_firmware_direct() with firmware_request_nowarn() to
suppress such warnings when no image is integrated into the kernel image.

Fixes: cf2437626502 ("octeontx2-af: suppress external profile loading warning")
Signed-off-by: Harman Kalra <hkalra@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 4994385a822b..a2de7f1c6c22 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1966,7 +1966,7 @@ void npc_load_kpu_profile(struct rvu *rvu)
 	 * Firmware database method.
 	 * Default KPU profile.
 	 */
-	if (!request_firmware_direct(&fw, kpu_profile, rvu->dev)) {
+	if (!firmware_request_nowarn(&fw, kpu_profile, rvu->dev)) {
 		dev_info(rvu->dev, "Loading KPU profile from firmware: %s\n",
 			 kpu_profile);
 		rvu->kpu_fwdata = kzalloc(fw->size, GFP_KERNEL);
-- 
2.48.1


