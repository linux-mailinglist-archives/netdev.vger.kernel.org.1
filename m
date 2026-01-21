Return-Path: <netdev+bounces-251833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPowGAujcGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:57:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0345054C68
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BDE2889851
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAC8480DCF;
	Wed, 21 Jan 2026 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="I4lVj1Xq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED94748094C;
	Wed, 21 Jan 2026 09:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988935; cv=none; b=GHBB3WcYMQ3xstmJKsoEQcXTtiSvYD7nNFqNWQ1IP4T1c7Ob9pi9RpNqt24jiiwHvqAi6H2alqsMOCVgExxDFCdLQT4t1cZEXcgwSRJ2haS5lS3JRK4Sq1Ved6+z0aMHzLmhl8PjhSpM9iHv+gFASs3GAzXFT6HxzGV6cZrhrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988935; c=relaxed/simple;
	bh=ytK4RTjBy5+QpQT8OZGjUaIjplK1obj4wbqpMutMj8o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pJxbGcctnerEEDX3U45BZ8hKj7QNvKagTzZwfz0dc57vLv5EFnxVwnT6qeHxWBV/iSzZRCz8AnzZFOMkGFJMaNrNN2N5wMaJWrpY5xkChrsV0kpxwnUxF4c0fkndLl0XmMtl61lD3VIXrLNVbUxVVvXyHducAi0+yUS/ODvcR24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=I4lVj1Xq; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L0FZ0T2830980;
	Wed, 21 Jan 2026 01:48:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=n0s6WHBHJ0PbDWOag9uzFE8
	sN8ihqWrYucgczoD2JVs=; b=I4lVj1Xqd5N/Ff0WvlLO6WS07cJFwcQEZFjRlEL
	XB8fAhKmz6Y7oflvMpet6+lQ+8TGzaKICvkee6WscEvzUXJsIwKTPsZLvsP5oou8
	5/yVkT5WFlbTgGmsZe7iLJWvm2YahwwFYZuiQO6CQEc0cGlDurA1J2toq0SW/wH9
	67ezwjst2dJaLqISGVt/AnqBAEHF42S1eJnf7ugyjIxIXispFQLu+k1w0wW64LZH
	Xg8E0qztE597MCcehBnpggYVFI+C1Zvp4FCQHvJqjZNewSGCg7ZmvLRX8nmWfkTq
	T4ElvtGlA6MGI6osg8BVzhMMpKIzl4vGhTNXV9G1OU6DhiQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4btm3nh05w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 01:48:43 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 Jan 2026 01:48:41 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 21 Jan 2026 01:48:41 -0800
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id C83E93F70A9;
	Wed, 21 Jan 2026 01:48:37 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [net Patch] Octeontx2-af: Add proper checks for fwdata
Date: Wed, 21 Jan 2026 15:18:19 +0530
Message-ID: <20260121094819.2566786-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: rR1wl8Ss27RzmWwPm3_ECZJUEYvDH8Tm
X-Proofpoint-ORIG-GUID: rR1wl8Ss27RzmWwPm3_ECZJUEYvDH8Tm
X-Authority-Analysis: v=2.4 cv=ZcUQ98VA c=1 sm=1 tr=0 ts=6970a0fb cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=hMOJt8txAAAA:8
 a=eoKpnZtxu7hRG1NsJEsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=VB-UQLohyrnngkzD1eWn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA4MSBTYWx0ZWRfX2VL69th2oV/S
 5knMiBl2rCRadVD0p/r7Qg9npPd9//AC5VqKn5r/F60kGr61KSy1ao3Jz4XjBD0vQONkBEb3haU
 vVV5SYHbAvfaYYrtejomrXc+Nee0o5xfnzYeXzAltF/73CYjTN6QoHoMAQ+w7P4vxkN+bqJNadU
 FFqAcsSr1derRqADAK4NTSedEbHZrw+TQ4DVyBu2QSnsdkzuBLfHKjlookVfhuHWlZ+yUYrhJMU
 eQ+BnYwr350sSXYJ16CYI2HV6+o4uMYPWTyLOlpEuh42j6kfvfQtFjsI2GEM9IE+gWk6OlGTr58
 1sgEwI0Q8mW79fm29Vth3+81CKzmuLiGFP48XCqONvCn5BZXyu79MVIYYr0wX7K9SvuZatB2mUq
 2FT/ax7FD6+ywQ8rIqcBU39xU0aQq/QYdUyHcqJcpGHBrWPcn+yU01NKjzBvR49DMa9G4Bbh8I6
 EdqZ6h1EKdBP6tLg6cQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251833-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[hkelam@marvell.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[marvell.com,none];
	DKIM_TRACE(0.00)[marvell.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 0345054C68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

firmware populates MAC address, link modes (supported, advertised)
and EEPROM data in shared firmware structure which kernel access
via MAC block(CGX/RPM).

Accessing fwdata, on boards booted with out MAC block leading to
kernel panics.

Internal error: Oops: 0000000096000005 [#1]  SMP
[   10.460721] Modules linked in:
[   10.463779] CPU: 0 UID: 0 PID: 174 Comm: kworker/0:3 Not tainted 6.19.0-rc5-00154-g76ec646abdf7-dirty #3 PREEMPT
[   10.474045] Hardware name: Marvell OcteonTX CN98XX board (DT)
[   10.479793] Workqueue: events work_for_cpu_fn
[   10.484159] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   10.491124] pc : rvu_sdp_init+0x18/0x114
[   10.495051] lr : rvu_probe+0xe58/0x1d18

Fixes: 997814491cee ("Octeontx2-af: Fetch MAC channel info from firmware")
Fixes: 5f21226b79fd ("Octeontx2-pf: ethtool: support multi advertise mode")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 3 +++
 drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 3abd750a4bd7..3d91a34f8b57 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -1222,6 +1222,9 @@ int rvu_mbox_handler_cgx_set_link_mode(struct rvu *rvu,
 	u8 cgx_idx, lmac;
 	void *cgxd;
 
+	if (!rvu->fwdata)
+		return LMAC_AF_ERR_FIRMWARE_DATA_NOT_MAPPED;
+
 	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
 		return -EPERM;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c
index e4a5f9fa6fd4..bbfd8231aed5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c
@@ -56,7 +56,7 @@ int rvu_sdp_init(struct rvu *rvu)
 	struct rvu_pfvf *pfvf;
 	u32 i = 0;
 
-	if (rvu->fwdata->channel_data.valid) {
+	if (rvu->fwdata && rvu->fwdata->channel_data.valid) {
 		sdp_pf_num[0] = 0;
 		pfvf = &rvu->pf[sdp_pf_num[0]];
 		pfvf->sdp_info = &rvu->fwdata->channel_data.info;
-- 
2.34.1


