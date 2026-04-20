Return-Path: <netdev+bounces-279638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wADhJhmR5WlNlgEAu9opvQ
	(envelope-from <netdev+bounces-279638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:36:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 150D5426524
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A981F3019818
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA239378831;
	Mon, 20 Apr 2026 02:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HKF+aP0n"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0C33783DE;
	Mon, 20 Apr 2026 02:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776652536; cv=none; b=Grjv1G+zG2TGwtPdoQ7jS/6vQSOt7DfLc/5P1q0HB+WkNa4QQIGxXx549YGdgZ6gYcEqGzes53C1BTVmdHykAyk2PdM23lQFyqJGwjx29tzQcWT9OsZGufWhaKVOcitgs24U6FH3xU4dR23VQ7JJRuUS2iTjINSDy49t9srsrMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776652536; c=relaxed/simple;
	bh=OtXu/bK0ftEHAn0OEWl0qk4cZsT3peqlIN6xob/pg2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5ri4DUj2DQh5fqnaL9UJxBdNxRYEvJxZNMSkVThSD2DsDUdK+n63M/nLqjEjL48XOncU16icgTacXEE4GJ1kFC+qhZHOhj9GyS1Zj2mLImkyGMLfQeifyU+Tfu+qlhamYx/R7noXp3t+F5VHgesg1sGZORhaMxnYFTpgscLfLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HKF+aP0n; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JLIoXU614622;
	Sun, 19 Apr 2026 19:35:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=2
	SvlWovSVWRpK+1xDn5vLWcz+oFHujdvo/WaEaavjwg=; b=HKF+aP0n5TQLfrSUY
	fSKLe4NhnjQDNOgYwOSc/nKm9CWYJfConxxgxSlE8x2gxjRcFN65HthU6QWk+glQ
	fO0YecuJlxkAhPgibc8V8vlPXheFsemekrorxXEnNneDoecP3QMhadNn9jBG3OMP
	8FRfWHurwvTwSGeDQa+LVYfD1ODiOHP0TW1l1qwlZuGZ1a6UTWQ1M6buse3hEIdU
	Gs55RV/iR7CGqTe7Ui5l11khKrvDedT2BujA1284ESeXONQUUO3zYJvwdH7awP1A
	/+2aoeANKmuVDJfdhfJy7wAEdTCYKC/mdsEdCIpPcEu53wXg0M7fn/YVWXljcPGx
	TJm4Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dm9fgjj69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Apr 2026 19:35:22 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 19 Apr 2026 19:35:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 19 Apr 2026 19:35:20 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id C0FF53F7041;
	Sun, 19 Apr 2026 19:35:17 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <dan.carpenter@linaro.org>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v2 net 05/11] octeontx2-af: npc: cn20k: Reject request for x4 entries in x2 profile.
Date: Mon, 20 Apr 2026 08:04:36 +0530
Message-ID: <20260420023442.3295891-6-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420023442.3295891-1-rkannoth@marvell.com>
References: <20260420023442.3295891-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: o5EjJFMqQ1u6MAR3g9Vupg4OVYhRY-BD
X-Authority-Analysis: v=2.4 cv=TYSmcxQh c=1 sm=1 tr=0 ts=69e590ea cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=ng8EnHo8p987gso5S4sA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDAyMyBTYWx0ZWRfX6IERT9RW9qYx
 jZ5GDamtmdXp/L5nm1Pop4qeR2ApLs37dYNCm7fJvGTOsvY3fijyfd1xIPTYxN9+I4SxeDkVjdb
 gi5DQV8BepqwyJhVJF/yG+gx+lBqoQEdESfopwPmp7m9feD+t18RAOEqyE8WxmavXAnHSRgninY
 zPswyR+9OHbSgHTJ0g++fZd6eOCUBAjg6w7Sl48hNo5aIN3fb0npCG58t6BLjx7LBaTk6XG+5sO
 eMc9RspPpezps79eSAC1rGmajpOUW+hkoHO51jjn6r/vY1FLDq5Ff+YozU/YEYXJpkWlM27PdtF
 Z7hOJ7FwfuDfPW12Py/qA8+nL8Nf+baVBzuQUjnNNylIkGnTK0aMqyzJxl3Udcdu1CclIPwQRTm
 +joIqU72j3YPrs2vwBOEz/sV3yntYJHfv+CH/65AimJUmm31GCBdN/pNfHOsMWGpmedBOfGp/CY
 ZQI4HK0LasFQHC2WyGw==
X-Proofpoint-ORIG-GUID: o5EjJFMqQ1u6MAR3g9Vupg4OVYhRY-BD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_07,2026-04-17_04,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-279638-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.993];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 150D5426524
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Flow install mbox can alloc x2/x4 npc mcam entry based on
the flow entry size. If global kex profile is x2, x4 entries
won't work. Return error upon request for x4 entry in
x2 profile.

Fixes: 9000cada7aa9 ("octeontx2-af: npc: cn20k: Allocate MCAM entry for flow installation")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/cn20k/npc.c    | 10 ++++++++--
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c   | 12 +++++++++++-
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 108998b6d832..705fe7a877e6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -4330,11 +4330,17 @@ int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
 	 * as NPC_DFT_RULE_PRIO - 1 (higher hw priority)
 	 */
 	req.contig = false;
-	req.kw_type = NPC_MCAM_KEY_X2;
 	req.count = cnt;
 	req.hdr.pcifunc = pcifunc;
 	req.ref_prio = NPC_MCAM_LOWER_PRIO;
-	req.ref_entry = eidx + 1;
+	if (npc_priv.kw == NPC_MCAM_KEY_X4) {
+		req.kw_type = NPC_MCAM_KEY_X4;
+		req.ref_entry = (eidx + 1) & (npc_priv.bank_depth - 1);
+	} else {
+		req.kw_type = NPC_MCAM_KEY_X2;
+		req.ref_entry = eidx + 1;
+	}
+
 	ret = rvu_mbox_handler_npc_mcam_alloc_entry(rvu, &req, &rsp);
 	if (ret) {
 		dev_err(rvu->dev,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index bd1488fe1611..d8945823e202 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1663,9 +1663,11 @@ rvu_npc_alloc_entry_for_flow_install(struct rvu *rvu,
 {
 	struct npc_mcam_alloc_entry_req entry_req;
 	struct npc_mcam_alloc_entry_rsp entry_rsp;
+	struct npc_get_pfl_info_rsp rsp = { 0 };
 	struct npc_get_num_kws_req kws_req;
 	struct npc_get_num_kws_rsp kws_rsp;
 	int off, kw_bits, rc;
+	struct msg_req req;
 	u8 *src, *dst;
 
 	if (!is_cn20k(rvu->pdev)) {
@@ -1689,8 +1691,16 @@ rvu_npc_alloc_entry_for_flow_install(struct rvu *rvu,
 	kw_bits = kws_rsp.kws * 64;
 
 	*kw_type = NPC_MCAM_KEY_X2;
-	if (kw_bits > 256)
+	if (kw_bits > 256) {
+		rvu_mbox_handler_npc_get_pfl_info(rvu, &req, &rsp);
+		if (rsp.kw_type == NPC_MCAM_KEY_X2) {
+			dev_err(rvu->dev,
+				"Only X2 entries are supported in X2 profile\n");
+			return -EOPNOTSUPP;
+		}
+
 		*kw_type = NPC_MCAM_KEY_X4;
+	}
 
 	memset(&entry_req, 0, sizeof(entry_req));
 	memset(&entry_rsp, 0, sizeof(entry_rsp));
-- 
2.43.0


