Return-Path: <netdev+bounces-289762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OsbMhc5DWqBugUAu9opvQ
	(envelope-from <netdev+bounces-289762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:31:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3907D5877F0
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74CAD304F38C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6641F09AD;
	Wed, 20 May 2026 04:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WCGBf5Ex"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0773B13DDAE;
	Wed, 20 May 2026 04:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779251474; cv=none; b=K+gneYUkPO5MhTKA6tEApNpDnG2RkNAGnTfQE1+cP3YXo1DyH7OA/MtOAUBOSjtRxdo2uvyHNQzQvO0OiXxmuH6Dv/Ik06pFTqhzRBCAFb9RaJn7u/hxasoeeGwtZrmgWO+kO/ENhYC540sBxrFBpOgI6FV/6va2DaC8dL1RSeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779251474; c=relaxed/simple;
	bh=f6mjM7KKs/UGkOydUaEw9o2nGol1Wj2FfP16fH5HU04=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kBWgCSfbcY+jOxIrM7SptSGVP0/Ullaq3RQDeQJH8enifKHIex/fqn1FXMrAg5hp/3wbNqW1Rbf+eksJKBiTnCQjEc11krMosuL1V7KXPW/6DkFs0I67te1+Apu8A/bw5Pt5DDQGfvdiiKfnESH2V1DEJo6PoWmw0HG8IxTtqJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WCGBf5Ex; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K2pm3k3009289;
	Tue, 19 May 2026 21:30:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=bI/+cOvklyLRSX00+NsdRtz
	PrQCcL9vTpdE4iKWbsPc=; b=WCGBf5ExVk4XucYPqtqVj7kTl83or794HistG0T
	lZrdkmU240E0HZ6i19CYiTBvLkNCMEYUj1SYDPsrwQIlcrw6Kh1Whq7E+5FaoTQx
	qkYQD9I2Y3coB3MA1whwx8MrJjBksRba3lYClHJpUe3rcdllDR/JQCdjuTH1AZiL
	k9FNgZbeVPk1D8JWcxDUkF/FHfeMxrmE7AzAoLy+eCi2qjPhx9gVP/EJpiVSyCS0
	HY05iZpdTbjObih9TllH1goCXge0InhgTef2vrNtzqYaRZlfhkKwQD/ixJsxndEk
	vxDD3gaA6vRs0AHpoDyny2oA/aP1JV/N1JhiuSF+U2FYbzQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e8jywbj3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 21:30:58 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 19 May 2026 21:30:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 19 May 2026 21:30:57 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id D49045B693E;
	Tue, 19 May 2026 21:30:53 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>, <horms@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-af: npc: Fix allmulticast skip logic for LBK and SDP VFs
Date: Wed, 20 May 2026 10:00:36 +0530
Message-ID: <20260520043036.1523798-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Ykl5mFnTk5KqvcTKGXAcFxcStvNCwYCu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA0MCBTYWx0ZWRfXzSk1KgKYRmUi
 4ye+RIYsBEhRTDdJ45XzuxBoM5LLZuCTW5+0g3oJ2KFe4IpdtDzZJiwhZwrHqFJAfeQXcjbzGP7
 9pzI761CUP5Ejhjx2p5CJjGoeiu9Gfj+9HLlvotS72VnvVgwW9anIGLavpb8A3dqyykqRMaIaAm
 96vN1cPSSG355gbVMyjnkjf1NY63zekI9IPTASnaeh7EeW+meiGtKk67BUdpN6wwTB9KrT4GtZK
 jC2Op6lXKUnX/IZRkP9+1fPWoCWMAIovdNu1yGPL+595ZXvRvbF+rghqufAvQwipAf5rrHAYzNj
 1sOJ/461/oofxbY+zv5j6D+oTVoAwr3dFWgaATMlG8ZRE6Fjjd1hNDJPPYwghzB123N1GbaeMd9
 jZVbb+56hwG7hfvdRsGFv6n52UEF7RLM4QJkRp5xJPWyraW7o/YKIw13m1zF1QXx+A2qLEvPdR1
 Lf6xJtMTL9HckmLHJ7g==
X-Proofpoint-ORIG-GUID: Ykl5mFnTk5KqvcTKGXAcFxcStvNCwYCu
X-Authority-Analysis: v=2.4 cv=QbNWeMbv c=1 sm=1 tr=0 ts=6a0d3902 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=UmA0Cgb4WzkLnBq1GnIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289762-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 3907D5877F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When installing the allmulticast NPC rule, rvu_npc_install_allmulti_entry()
should skip LBK and SDP VFs (only CGX PF/VF may add the entry).  The
code combined is_lbk_vf() and is_sdp_vf() with logical AND, which is
never true for a single pcifunc, so the intended early return never ran.

Use logical OR instead.

Cc: Geetha sowjanya <gakula@marvell.com>
Fixes: ae703539f49d2 ("octeontx2-af: Cleanup loopback device checks")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 3c814d157ab9..607d0cf1a778 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -990,7 +990,7 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 	u16 vf_func;
 
 	/* Only CGX PF/VF can add allmulticast entry */
-	if (is_lbk_vf(rvu, pcifunc) && is_sdp_vf(rvu, pcifunc))
+	if (is_lbk_vf(rvu, pcifunc) || is_sdp_vf(rvu, pcifunc))
 		return;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
-- 
2.43.0


