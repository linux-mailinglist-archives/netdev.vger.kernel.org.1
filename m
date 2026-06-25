Return-Path: <netdev+bounces-302056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9LZcCY5lPWr02QgAu9opvQ
	(envelope-from <netdev+bounces-302056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 19:29:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E1A6C7C9A
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 19:29:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=IDySTlfw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302056-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302056-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D204830E2915
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3123EC2EF;
	Thu, 25 Jun 2026 17:27:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49E3EB119;
	Thu, 25 Jun 2026 17:27:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408423; cv=none; b=q6rkDRZTlFmNnEfV6KHYSsHazSNfsRC3UONbociI0bdrc0ocVbI2wk925dEtdSjVhn7J2Mi/IoZk0SEJD9ZKfLmB4yJK6f7HkPr/BrlZx16HZMmebCe0scwosd7wEg7CBJXnRsMDngN7s60V9tw34dj3ToG7JQs11jp1CPBIRX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408423; c=relaxed/simple;
	bh=4HQCwNp+Gpty8vnj0N7JZ99X9uEvEISDCnIh3XMp9Hw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WmFiWmAw+FcfyZ5XjippLVkAPMmbc8pOI69ZrEAAf3qnvl39oVEXp55cpNjfl5/8QduZJDAsp5MRrz14E9kubjykxzDVr0gpoV3BG2bFq2/oEBifulF1r8sTCPyuDh16swiTKQyNU4sGVK1rHgYmFopC9H/NMT3Ounhw11ytPeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IDySTlfw; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65PFhY7P1177797;
	Thu, 25 Jun 2026 10:26:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=G2YTC9kOTHbxRgyIZfR7BfY
	erlYbuK8Ixe6sr8vQWfs=; b=IDySTlfwejD7GNgTE78ZZA+ZNZYL11gu0ezlyUS
	1UVzPUd063yQge+mL8ms7E/cdpFf4lCXtesnOCVBD85qcTprcEUBPrXKQwiK3tR0
	tslnBUoC8xAfHJdDYZA+2IP2AHMEPtmV+4Z5n4BweTJpMPtdMu4geXqpC0ZLGO0K
	A6WCZdR5yuGrAQWGzUvswGSX1Y7ZCT7zmIUgNrBKP1Xv9VnyqZZbMbOVmN6NGOIP
	cFV8EJSu0jNFfdG511p0OPrH/WOl9s51lLxdy41CZYepkTNLhxXdnR521QCmyHNt
	sneUzMAr4T1fPTGhguHbmio1d8Skb9YDI3SGKNDi6Bn2MBQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f03u9psyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 10:26:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 25 Jun 2026 10:26:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 25 Jun 2026 10:26:36 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 1C78E3F7050;
	Thu, 25 Jun 2026 10:26:31 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <bbhushan2@marvell.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <naveenm@marvell.com>, <tduszynski@marvell.com>,
        <sumang@marvell.com>, Nitin Shetty J <nshettyj@marvell.com>
Subject: [PATCH net] octeontx2-pf: check DMAC extraction support before filtering
Date: Thu, 25 Jun 2026 22:55:52 +0530
Message-ID: <20260625172552.258631-1-nshettyj@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE1MCBTYWx0ZWRfX3ZTiPU7VUBg6
 DXYlpIx/rkiF/zTOBadMl5duRjHmwj5Wvh+SO9xF4gqaIEybC7Eskh+AMSxJhrDSWO4rs1IIErp
 knkoaDrTk+ZIbNTAaJ4kUv+NivqUI9AbHuA72pp39ArLaH0EYXINq/VV+7bUzJ4PsxXsLr6znz6
 qKDr1tVgyIDeJd8foF6gB2lzRW3hAQYbgnAvCa075UIKHNSKZ6WW2NQxtkqKPGpoIgEbQoykwBE
 lodic00fj8wDUpowSNiYJ8bFz3EYVbr3yThiG+g+r0OP7ojzSLgHpC5SK3tx+96CrGoGEhpeYOj
 GbMrtK7B5jNx8pYb8WjkZjM3u+omC2+Q0EZLyIIhDlgz8Nb5XdiAhPcD9pb1dYhC0pwFcLHX93w
 3PvJfHRBofw2fUJY7MEI7JjpgioCEOl3mAoMekyJBku1CLnv1QBjhT/YdPyP+CgtYAa9jTuBr/+
 Fdpihh8dYxKsaDAc66A==
X-Authority-Analysis: v=2.4 cv=LMdWhpW9 c=1 sm=1 tr=0 ts=6a3d64d0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=glnSrrZhwWZS59TbXWMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: htDEv94ospFIyzQx9Dk8VY3Qs7D7XGdt
X-Proofpoint-ORIG-GUID: 1CMY3Hpv3FgJKiGflC3rWQtkF6az_z5O
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE1MCBTYWx0ZWRfX4x3IYoK6bW36
 LXstl1OhexhzsN+cocQFlkWbX599AV0CiYQU2ulgoiaDsCq6UMiMgjguv/9dBIYA3TY1OMxA/6j
 qNwqmnrG2OHJ2URz+Gz3/HNsl3ayBSY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-302056-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sgoutham@marvell.com,m:gakula@marvell.com,m:sbhatta@marvell.com,m:hkelam@marvell.com,m:bbhushan2@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:naveenm@marvell.com,m:tduszynski@marvell.com,m:sumang@marvell.com,m:nshettyj@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
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
X-Rspamd-Queue-Id: 80E1A6C7C9A

From: Suman Ghosh <sumang@marvell.com>

Currently, configuring a VF MAC address via the PF (e.g., 'ip link
set <pf> vf 0 mac <mac>') blindly attempts to install a DMAC-based
hardware filter. However, the hardware parser profile might not
support DMAC extraction.

Check if the hardware parsing profile supports DMAC extraction
before adding the filter. Additionally, emit a warning message
to inform the operator if the MAC filter installation fails due
to missing DMAC extraction support.

Fixes: f0c2982aaf98 ("octeontx2-pf: Add support for SR-IOV management functions")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index b63df5737ff2..8e4435d9e520 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2546,6 +2546,8 @@ static int otx2_do_set_vf_mac(struct otx2_nic *pf, int vf, const u8 *mac)
 static int otx2_set_vf_mac(struct net_device *netdev, int vf, u8 *mac)
 {
 	struct otx2_nic *pf = netdev_priv(netdev);
+	struct npc_get_field_status_req *req;
+	struct npc_get_field_status_rsp *rsp;
 	struct pci_dev *pdev = pf->pdev;
 	struct otx2_vf_config *config;
 	int ret;
@@ -2559,6 +2561,38 @@ static int otx2_set_vf_mac(struct net_device *netdev, int vf, u8 *mac)
 	if (!is_valid_ether_addr(mac))
 		return -EINVAL;
 
+	/* Skip installing the DMAC filter if the hardware parser profile
+	 * does not support DMAC extraction.
+	 */
+	mutex_lock(&pf->mbox.lock);
+	req = otx2_mbox_alloc_msg_npc_get_field_status(&pf->mbox);
+	if (!req) {
+		mutex_unlock(&pf->mbox.lock);
+		return -ENOMEM;
+	}
+
+	req->field = NPC_DMAC;
+	if (otx2_sync_mbox_msg(&pf->mbox)) {
+		mutex_unlock(&pf->mbox.lock);
+		return -EINVAL;
+	}
+
+	rsp = (struct npc_get_field_status_rsp *)otx2_mbox_get_rsp
+	       (&pf->mbox.mbox, 0, &req->hdr);
+	if (IS_ERR(rsp)) {
+		mutex_unlock(&pf->mbox.lock);
+		return PTR_ERR(rsp);
+	}
+
+	if (!rsp->enable) {
+		mutex_unlock(&pf->mbox.lock);
+		netdev_warn(netdev, "VF %d MAC filter not installed: DMAC extraction not supported by parser profile\n",
+			    vf);
+		return 0;
+	}
+
+	mutex_unlock(&pf->mbox.lock);
+
 	config = &pf->vf_configs[vf];
 	ether_addr_copy(config->mac, mac);
 
-- 
2.48.1


