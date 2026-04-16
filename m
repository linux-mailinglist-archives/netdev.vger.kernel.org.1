Return-Path: <netdev+bounces-278915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFJjBGJe4GkcfgAAu9opvQ
	(envelope-from <netdev+bounces-278915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:58:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E4540A1C9
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CD15316C3E3
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 03:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0303033C6;
	Thu, 16 Apr 2026 03:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bblGHbj9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A47F2DF13A;
	Thu, 16 Apr 2026 03:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776311734; cv=none; b=j70ZDv7UvAvDgP8fcSLOlvsscjRodYq+MdMFyBi9di6wAA7voPn6njMxJ/KyIiShhNIcXZRZia+cTt16iLThYGtefgWCOhVIcuOnmhMc6k0cXYV6MfhJx5lVvOZniMquavl/ybCjenKPSuNA3JXGvGKQj8d2b2N5zbhIZmmTkhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776311734; c=relaxed/simple;
	bh=rQrs8lLPk7fTA2mg+4gyQpXuS/QFkHUdLLfDb2MIflg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIxHfCYT5i9nBisaz3HDStmivQeOLTM9iUZ3+LSTI3jfUY/CCI6+2mj74Xxx2c8magiw7EzOLIs+wTO8wMy+un5hFGQkD6vgYRGm0A58iClGdPGDTb9Er6IeKHN7ckv3V8prebtD12HrMFB6mr7fNMo2yEnlIT2qJmiGW8RZyUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bblGHbj9; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FNT44u066774;
	Wed, 15 Apr 2026 20:55:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=0
	J26ByA48pTyYzUFPE0k9D22JfJYQgTDr3R5J/ygeGA=; b=bblGHbj9h0iJ/rNkR
	f1iJvPn8xZMKdYPuFrwWQlzPF/7dNWTWXJknh3n4mvNeW+Vegd5leFLAFhxvQgm4
	y61DWULT2W6on9zcTwHyoPrw9lB07jkCSLv6Y5jFxkNl1a17szbrxuIMs6vLomcD
	ItYXpkkDZBRJ8/4VYtcXRj/qleD1HYEp++bcGqWD12Y98QEwhPdo9WZIHFEbGyAQ
	HQ+xcyDXz6px6vSGzwH5h+ceUlO2StAbX7gKXbchkYS7NzWeHGIsicaHaSGlDm0r
	fPpa3YB16bNmU1i2wjNT7NW06sD3nkQel2WLDaokhWSQr5gzhBgMBxEFHMT2A2l+
	3KSSQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4djmcugdvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 20:55:11 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 15 Apr 2026 20:55:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 15 Apr 2026 20:55:10 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id BBF403F7079;
	Wed, 15 Apr 2026 20:55:06 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <dan.carpenter@linaro.org>, Ratheesh Kannoth <rkannoth@marvell.com>,
        "Dan
 Carpenter" <error27@gmail.com>
Subject: [PATCH net 1/3] octeontx2-af: npc: cn20k: Handle npc_mcam_idx_2_key_type() failures
Date: Thu, 16 Apr 2026 09:23:50 +0530
Message-ID: <20260416035352.333808-2-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416035352.333808-1-rkannoth@marvell.com>
References: <20260416035352.333808-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDAzMyBTYWx0ZWRfXyi+SB8lyRlNx
 wWJ0sOOcVY17ntGI30eMUrVdOGTiGZPowRWxF6pbh/nmk7bluaZEK8AwnZdJBsQCJSjs2IL1uez
 fq6a9LfWKasRL6p/cKh3t1kyxz/qpdx8izgqyC795Ls/JP5AVI/HPtRHKdR1/Skk56KxIH7I4Cv
 dNmP+paEte9N4FLrTe6QZvNYfYru3RMXII6x1nb+G3Prhe2lecO5vJ3XrEWdM4tdS5nzGUxCh6M
 HhKj01Hb7thIYvhTWH+KQsxkfkBKzozDc5CR4oUBxD4JLCSyZ+OEA+RtNPEpU0XhYi1aCqfQRCw
 9fdWeOxxT5p6fEFNOsZeUOxQQ44+NbVT0SsplolDIYAkL7JJ1plVAG1s5424DkSIZLVwTo3iwW+
 9uejvWxsBhu4P0LHFvh1cbusR66Jx64BhQD8RSmh8KgH4XT7VVHYGLALzd/LZxYjtOXI0sug+T+
 Yn8ZiVJpC4zNkwDbIeQ==
X-Proofpoint-GUID: dkIffXavJSnnh24SJBn5p7iPLvREwjZD
X-Proofpoint-ORIG-GUID: dkIffXavJSnnh24SJBn5p7iPLvREwjZD
X-Authority-Analysis: v=2.4 cv=F4hnsKhN c=1 sm=1 tr=0 ts=69e05d9f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8
 a=uyHcWPyfkJeEmAZy9ZsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,linaro.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-278915-lists,netdev=lfdr.de];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: C6E4540A1C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

npc_mcam_idx_2_key_type() can fail; ignoring its return value left
kw_type unchecked in MCAM enable, configure, copy, and read paths.
Return early on error so we do not program or interpret MCAM state
with an invalid key type.

CC: Dan Carpenter <error27@gmail.com>
Fixes: 6d1e70282f76 ("octeontx2-af: npc: cn20k: Use common APIs")
Link: https://lore.kernel.org/netdev/adiQJvuKlEhq2ILx@stanley.mountain/
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 7291fdb89b03..2fcd0ee2b1e1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -808,7 +808,9 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 	u64 cfg, hw_prio;
 	u8 kw_type;
 
-	npc_mcam_idx_2_key_type(rvu, index, &kw_type);
+	if (npc_mcam_idx_2_key_type(rvu, index, &kw_type))
+		return;
+
 	if (kw_type == NPC_MCAM_KEY_X2) {
 		cfg = rvu_read64(rvu, blkaddr,
 				 NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx,
@@ -1052,10 +1054,12 @@ void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 	int kw = 0;
 	u8 kw_type;
 
+	if (npc_mcam_idx_2_key_type(rvu, index, &kw_type))
+		return;
+
 	/* Disable before mcam entry update */
 	npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, false);
 
-	npc_mcam_idx_2_key_type(rvu, index, &kw_type);
 	/* CAM1 takes the comparison value and
 	 * CAM0 specifies match for a bit in key being '0' or '1' or 'dontcare'.
 	 * CAM1<n> = 0 & CAM0<n> = 1 => match if key<n> = 0
@@ -1132,8 +1136,13 @@ void npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr, u16 src, u16 dest)
 
 	dbank = npc_get_bank(mcam, dest);
 	sbank = npc_get_bank(mcam, src);
-	npc_mcam_idx_2_key_type(rvu, src, &src_kwtype);
-	npc_mcam_idx_2_key_type(rvu, dest, &dest_kwtype);
+
+	if (npc_mcam_idx_2_key_type(rvu, src, &src_kwtype))
+		return;
+
+	if (npc_mcam_idx_2_key_type(rvu, dest, &dest_kwtype))
+		return;
+
 	if (src_kwtype != dest_kwtype)
 		return;
 
@@ -1188,7 +1197,8 @@ void npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
 	int kw = 0, bank;
 	u8 kw_type;
 
-	npc_mcam_idx_2_key_type(rvu, index, &kw_type);
+	if (npc_mcam_idx_2_key_type(rvu, index, &kw_type))
+		return;
 
 	bank = npc_get_bank(mcam, index);
 	index &= (mcam->banksize - 1);
-- 
2.43.0


