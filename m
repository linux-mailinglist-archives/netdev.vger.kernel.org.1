Return-Path: <netdev+bounces-299306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P1olEkZyL2pnAgUAu9opvQ
	(envelope-from <netdev+bounces-299306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:32:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D52AD6830C8
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:32:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=CJCWkGY2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299306-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299306-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F7F33001FE4
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 03:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB56F1F4CB3;
	Mon, 15 Jun 2026 03:32:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CA517A31C;
	Mon, 15 Jun 2026 03:32:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781494338; cv=none; b=SiWvwIRDiZjJfYicF83b8+gzAHOoTYuaVNy8ml6O9Y901OkSuohI+wVxGKncMq2ZidF4I/tvf/RaZVL2RO39ty/xAeLDYfZHUZjv5CPsp6iPvtXVySedg9rNB/+uw0c0uPClt/k5xpJCAmqgi/ImXqQSouar4N70qSPId1UDC0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781494338; c=relaxed/simple;
	bh=wnKLEeD+LshxL54ljbJ2CdU+z+ectdMdhh2yuEJMCsQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U4qp3j5iB7cdLBzSdiPtSn2XaV0QwazEC/0/WnOEaltPxEHFDQaP4DH6vwZ3ni0nssBfVmBxDzutO5t9iPa7WKcLW5SkqdNQ1WzX02GfVsumx6mTc3XEPez+eoWr7mraFpq/eOo1EsbOfvxbFXfqJ6UiKS7idYY4uD8w5bepnXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CJCWkGY2; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F1lgwg3665326;
	Sun, 14 Jun 2026 20:32:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Loyblxv+SgwG2wV+cenYfpv
	89YSbIJNVgWvrk+zYgOk=; b=CJCWkGY2PMVzF9mNcVlDAI10x8YWO8Co4MtvWhs
	CrrwVv68Vd8UP2slF9k8o8AXUB3ZzuYQ393quZdP1qHJgqqoolfULPx2v8+C38Wi
	Vh7yc3R63W9zn/PmnwTw5yY9q3jxN5E7LJiFz52q+hYbK40Su8LiOJWOii/exfaP
	uZ6w5EAaR+AeSVxt4yszXaJ0AzpXZm/z/v9mjiyeXDSIVG+jjCRMa5s+ONweh1if
	dHvJ/En+2i7K4QJZoTjH4u6OCXz34fqwbNw1aWCkdDtcPH2iDjsEzuMq9f5bdMZD
	iQbiq0WKPx731Lh7B8sZZM2cDs8Xqm1fdAZnaCbgf0IA0cw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4es6qed88a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 20:32:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 14 Jun 2026 20:32:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 14 Jun 2026 20:32:07 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 3EC943F7063;
	Sun, 14 Jun 2026 20:32:05 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <rkannoth@marvell.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: [PATCH net] octeontx2-af: npc: Log successful MCAM drop-on-non-hit install at debug level
Date: Mon, 15 Jun 2026 09:01:57 +0530
Message-ID: <20260615033157.535237-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 8W3rF4fBxrxa2FmLEtIYiNz0XTGhWFKJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDAzMyBTYWx0ZWRfX8irJV7tlM6x9
 3h4Py/x/bTDDK+bq1q4jpYgzhIw9SoabjlHBG34nRt9r57E9hCj6z93VVrrjGKSlJZAlMrvToH3
 mvDwbd1NX4I/UcYMbseS7pMVLtUXLps=
X-Authority-Analysis: v=2.4 cv=TuXWQjXh c=1 sm=1 tr=0 ts=6a2f7239 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=DrKsVqLRQLHJ2BDX9nwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 8W3rF4fBxrxa2FmLEtIYiNz0XTGhWFKJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDAzMyBTYWx0ZWRfXzZqWQpq4C66Q
 RZYkjxGgpKZEHvF4LCEOIqYfgtGGph7LocNW5pV1Napb89NYItRN7/urI7h6RvyKIHT6RC1z9gV
 3Qo6FdOheRuOQeVk0GslJv7uoB6sEcs94Dyq9fbJ/4dgeujCrXMZLWXSnUZFbT0bXUyKsOe1d+O
 2VchyVhJuaRUPtmzaNnHYkLrkq5mqaNRTol9uhW/SOV5W2dJcSMpl78eECrMowJkxT9CWzMulNF
 5fFEX4IFD3lKSaDza40cKTN9AUPDMJWvxVYms3xQeOlAB9Fb/3FI+7VLOnfgPeQPsrygiKnEJ5g
 Coizt9jtjSaAVgD7gpczNke415envAhm1EO6uWRqz38he2yTJFTkByJV3UzKAHe0F/0RSxB+OnG
 Aqy32jJ0BdwRm8nu3bZVU69Y2XyRD3rxU3KqlXdZiBcBLkz5c6qBY0a+in0/VIx5smYQa5R65Nk
 EcvA2yy7jiKWEfI1G6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_01,2026-06-12_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299306-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:rkannoth@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D52AD6830C8

npc_install_mcam_drop_rule() used dev_err() after a successful
rvu_mbox_handler_npc_mcam_write_entry() call, so normal installs appeared
as errors in dmesg.  Use dev_dbg() for the success path and keep dev_err()
for real failures.

Fixes: 3571fe07a090 ("octeontx2-af: Drop rules for NPC MCAM")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 34f1e066707b..3d4d3ab5183b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -2215,7 +2215,7 @@ int npc_install_mcam_drop_rule(struct rvu *rvu, int mcam_idx, u16 *counter_idx,
 		return err;
 	}
 
-	dev_err(rvu->dev,
+	dev_dbg(rvu->dev,
 		"%s: Installed single drop on non hit rule at %d, cntr=%d\n",
 		__func__, mcam_idx, req.cntr);
 
-- 
2.43.0


