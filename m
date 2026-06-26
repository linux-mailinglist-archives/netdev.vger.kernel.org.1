Return-Path: <netdev+bounces-302104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HFp2Cf8aPmqk/wgAu9opvQ
	(envelope-from <netdev+bounces-302104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 08:23:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C346CAA09
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 08:23:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=AxKBsHH8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302104-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302104-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E018300CC85
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 06:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7952A3D75AD;
	Fri, 26 Jun 2026 06:23:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E863D6689;
	Fri, 26 Jun 2026 06:23:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455036; cv=none; b=cbHNmldHpQpPvLH9qKhagysdj7AhCDQU6tbOOgG7tZaN31Q7Fo2DdelFTgDEsghrOCi8L23/tl2VQ6uUBomTHVia1XjtXlSA4elxHFwEVn+exKbhbNmi8G3IL/czWpDVwT9WSsCvdlH+AEQYbsGfpoq19LOKNRjIvuNYV7tHOiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455036; c=relaxed/simple;
	bh=58+U+C1b6uGYeIQR2XrACVezSF3AtvVYTLLtws+Ljic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyI6RFex8k1W5mo+vCdVZUq4sVQpvLrpoL1fglGqaKUfQZX7M/cLVS/rBn/oMpMOPUocc/M2OVjoUANBWv0eI/88eUTk2VTyy0VeI/LD9Oat5qYUQmmo35q3bcJ/Cgu9jiDADpkzdbpyvdQCCJmtKPCJjuX1K7UGgGKiebGByXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AxKBsHH8; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q2q7bB2487050;
	Thu, 25 Jun 2026 23:23:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=p
	YijR5LogrByvDrYitQhCTT62UQbO6nu0hD4NDAn5f8=; b=AxKBsHH8VcoCCy4Uw
	EgD2Y6bm6FgVu0M2mmD4dAiII/udIRG/0NZ9eOvChm25qM8tx6oFIu5HVddrp79e
	b90dfUkKtgX1IcUer9PA2dkuevixjz7MlIL0F15GDlYMvJKYlm799bIV36XQHxVc
	Be1c/fHOccTUM1EmkVyj4C2oqZ+fDHzUhAFPVWh6SBS9SE3DSHbHk5Ms2Wjf7T/A
	4dkOyBmD0ThMZjy4lkYGBMIU4141Ti+ivcEKGANu1txC6Ah6U26B5+dE0QXyVx6P
	6dJF+SL79HohW7o1gV/uHXYh4jnuAsAVur0LXQ+2yiE3w5NxmVlwdAwz5IR+6/q6
	y6xgw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f11jpbhe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 23:23:46 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 25 Jun 2026 23:23:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 25 Jun 2026 23:23:45 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 83D583F7072;
	Thu, 25 Jun 2026 23:23:40 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <bbhushan2@marvell.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <naveenm@marvell.com>, <tduszynski@marvell.com>,
        <sumang@marvell.com>, Nitin Shetty J <nshettyj@marvell.com>
Subject: [PATCH net v2] octeontx2-pf: check DMAC extraction support before filtering
Date: Fri, 26 Jun 2026 11:53:29 +0530
Message-ID: <20260626062329.871990-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260625172552.258631-1-nshettyj@marvell.com>
References: <20260625172552.258631-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA0OCBTYWx0ZWRfX1R7BMA9/huYP
 2o2eeHu0dzY3BOPVyQ6jHua4iOs2oqdduVrg1y9aHu+SeaMzG+Bjd7hAPHmF9cRi1i22xYrdtMX
 X1dHAGY9EhuvBct7mxlqrQerBDfBEho3IS1STsnnnu4cqFhMGcEw76abhHizSyeH3IcINiRlWOh
 0XeNPwIqF8rF48S1N27WR8AJ/wXT+W6VVKCx3qYnG3CGidMs5LfpzeJJKkSvYp1JYBTq9wtH7YM
 rgR2XfhYKqGT/dU5B2V87id1zoxuONFQDAlsP3FT09vuAHiiMyJrdRBc7MADdoTxM/q2M0BM4Nj
 sC/Y6Sddi/AxBAFY9aEGZiMYNvbz3VepYDgtazVFZwMrtS5EOYuxchHvmQgfKNl3Huln4DFMkLg
 YY7cluAIkAdE9QnoDzrCr7wLvrIqdU4kt/9Qo/rA3kwa8mnPxzrCD42OlBDTuxW16XCZ2d205ma
 FCQ+4gpURkP6kGnzRSg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA0OCBTYWx0ZWRfX6eAEP6cua1h3
 tF/s2a9YMJHnSpjCNYuIIBKiTmfyZsCrGR8am1jioH+5SYwJZ26PynGSI9Jp68sFT6D93wlTFC6
 U/39V7Tax8nMyeL3YlhOVd1zxH0tvX0=
X-Proofpoint-ORIG-GUID: 3FPE9yJOTV1BSL22SQ5ZJqRjsOneZn8W
X-Authority-Analysis: v=2.4 cv=KIxqylFo c=1 sm=1 tr=0 ts=6a3e1af2 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=glnSrrZhwWZS59TbXWMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: pWCm0G6w2fOEFaPXgVJJah0gV2WWW-E2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302104-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86C346CAA09

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
v2:
 - Move the DMAC extraction check from otx2_set_vf_mac() into
   otx2_do_set_vf_mac() which already holds pf->mbox.lock, so all
   mbox operations are under a single lock/unlock pair. All error
   paths now use the existing goto-out pattern, eliminating the
   scattered mutex_unlock() + return calls from v1.
 - Return -EOPNOTSUPP instead of 0 when DMAC extraction is not
   supported, so the caller gets an explicit error rather than a
   silent success.
---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index b63df5737ff2..dc7e4a225dd0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2517,10 +2517,43 @@ EXPORT_SYMBOL(otx2_config_hwtstamp_set);
 
 static int otx2_do_set_vf_mac(struct otx2_nic *pf, int vf, const u8 *mac)
 {
+	struct npc_get_field_status_req *freq;
+	struct npc_get_field_status_rsp *frsp;
 	struct npc_install_flow_req *req;
 	int err;
 
 	mutex_lock(&pf->mbox.lock);
+
+	/* Skip installing the DMAC filter if the hardware parser profile
+	 * does not support DMAC extraction.
+	 */
+	freq = otx2_mbox_alloc_msg_npc_get_field_status(&pf->mbox);
+	if (!freq) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	freq->field = NPC_DMAC;
+	if (otx2_sync_mbox_msg(&pf->mbox)) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	frsp = (struct npc_get_field_status_rsp *)otx2_mbox_get_rsp
+	       (&pf->mbox.mbox, 0, &freq->hdr);
+	if (IS_ERR(frsp)) {
+		err = PTR_ERR(frsp);
+		goto out;
+	}
+
+	if (!frsp->enable) {
+		netdev_warn(pf->netdev,
+			    "VF %d MAC filter not installed: DMAC extraction not supported by parser profile\n",
+			    vf);
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
 	req = otx2_mbox_alloc_msg_npc_install_flow(&pf->mbox);
 	if (!req) {
 		err = -ENOMEM;
-- 
2.48.1


