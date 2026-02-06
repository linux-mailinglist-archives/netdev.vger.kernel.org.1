Return-Path: <netdev+bounces-257648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOy2EsE0hmlrLAQAu9opvQ
	(envelope-from <netdev+bounces-257648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 19:36:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF91310203D
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 19:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5CEA311EA35
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 18:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B0942883D;
	Fri,  6 Feb 2026 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MqJLJBfr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F015426EA0;
	Fri,  6 Feb 2026 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770402452; cv=none; b=pxGTlI7sJEGwDywpBux8k5LDzg3xdfC8FAppIUIEyA0XLHpldE6IaS7Gilq4tEKgLEKlifCC4q0VeBPSN/Re5XjxOJvYSA+p3epEHZcWAm076FD3ZJETmC6N6PhRpPRQ6Z42JgOIICnspNgS+di6C5VLQBPoi8Zuec5EJIkmpJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770402452; c=relaxed/simple;
	bh=zxydVFnNqe6GrR6W7yE4Tx3yXmOU+e5eyiRf4JotjXg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gGK6YJe71ofgapK/tU8wD3kVyKl7KjzwP2xek1Whnz73zMzUzVMgo16vQJv1+uy3ChP0w0hn+rtr4D4j96QIHbNDQdDkJ9b4faKkGzkYzJKTE03IwTIP9wYepGGL8XWVh+OuDAwKKe1eUqwekKFJr0WmmqDjwkBoI7p0GY9vPf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MqJLJBfr; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616FdUDS1090855;
	Fri, 6 Feb 2026 10:27:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Yowg+XBoSDiNiXoAMdDX0Sp
	dDQGRSza2Gx0HTn5fzyw=; b=MqJLJBfrYiLgnEA3w9Ct9Kd3ZLiD2sLUZNyiYuN
	88lhyk6OT0wUurdbJcgJPcLD+U5Bo83T5xt8Ha9SJqnyR9qLhwNwqveStTfBanr1
	S9vTceGe2mFEJk2sKG7rXeRBivoexfEBXm4feAOdFFKOHML4bkVpWU8O5Xwr8BE0
	F7NrxiegjEK892eXuEqpemXcjdBpX7CeYF6DpLDJiB2kkqQidYwDFDlZj9Z42bMP
	BVwwSpDs3a9nLHUKYaf/mKpYWFA92Hy8bHgIJtp8Vt3gLHc8JjDlvRkqr7qytB7c
	AAxFzTMkrLfBnR7Qe8IwW8nAM8QpKPbCrH0jP2cjARtVHLA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c54u1t7x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 10:27:18 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Feb 2026 10:27:33 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 6 Feb 2026 10:27:33 -0800
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id E60113F708D;
	Fri,  6 Feb 2026 10:27:12 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "Andrew Lunn" <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [net Patch] octeontx2-pf: Unregister devlink on probe failure
Date: Fri, 6 Feb 2026 23:56:45 +0530
Message-ID: <20260206182645.4032737-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: JyN7iaI6esbu1dMkHlkBKfWrSLpkss5J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEzNiBTYWx0ZWRfX3qUEQYbu/oqq
 vSNJg2v/DZlrbrpeq8KKtbOGFB+81ySLiTrx/t4efDNB23DZdBzm86uyo46PkS+0sjuXaSpRZkB
 D8UAVJUqonyBUGVxaE1Ni/JFqeoAbQwENoj6VTP4Meh/jsnmT8+YZ1fNn1uuLB+KHoGaTRDsxNj
 KsnFxX5y7X0OPAyPsZfX2kxOAoGlvH9kkmBuqew24Geh4HVlkSWxRI9Gd+pppd/K+RB2IaLUS+y
 DBGXOD1S7cQI9RAiunIdEmV6qUg+OHfHlx7CIO73Hw6gVSASl72kAtMl7K+c1JKLYCIO1hRQ+Rz
 9q0RIizcJVrd3kk5A70IVGzfzw9ePybRTiNvsA+wkORndiYzepMItrJq5kYGkjZr1EsAPzQqo8S
 7zSLWUsq8fPttNJJjRjp9qrLVlaKaJrTUEkBXyIGeg/Kl3kMoJt/vomlwx4FAoigr1A5DuJFjmv
 NBL6LPHkAvqMBr+VOjA==
X-Authority-Analysis: v=2.4 cv=YcywJgRf c=1 sm=1 tr=0 ts=69863286 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=_GjXgmNaulZqIGvaOA8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: JyN7iaI6esbu1dMkHlkBKfWrSLpkss5J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257648-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkelam@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.983];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: BF91310203D
X-Rspamd-Action: no action

When probe fails after devlink registration, the missing devlink unregister
call causing a memory leak.

Fixes: 2da489432747 ("octeontx2-pf: devlink params support to set mcam entry count")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 6b2d8559f0eb..444bb67494ab 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3315,6 +3315,7 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 err_sriov_cleannup:
 	otx2_sriov_vfcfg_cleanup(pf);
 err_pf_sriov_init:
+	otx2_unregister_dl(pf);
 	otx2_shutdown_tc(pf);
 err_mcam_flow_del:
 	otx2_mcam_flow_del(pf);
-- 
2.34.1


