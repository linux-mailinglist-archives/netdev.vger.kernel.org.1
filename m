Return-Path: <netdev+bounces-264028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK0EFZyKqGlXvgAAu9opvQ
	(envelope-from <netdev+bounces-264028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:40:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9495207279
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CF1330305C8
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 19:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42333D567A;
	Wed,  4 Mar 2026 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sU5KUMXN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635DD36F40A
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653208; cv=none; b=nAfWB3rdDk3P/Ta+NL911Ym5eijpKdlBWf2lSVCpx0JAWa7KGjLZCNsSdHcJJcZPTu41pKDrYtCK0wq4v6QRemkHuLJ0P2ACtxqT7PXu86vvU//hiCbeia+kUuxC3H/683QvMgv4CIXtND9JSrK6lyNVtNrDSuRtC5CXfHsEEjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653208; c=relaxed/simple;
	bh=zGq7dibw42fmZTQ9Sd8rBhgwetAItY8L9y9yHSoU0WY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5XdjmYuyd/aTJZBVxkZF1jHkAMbRVILfebzCc3HHEYFCSYRQWpxllQekRvFqQ1k3bCrm2oRRSZpMMHJKsa48IoOaOHrODydnslvkhrHorZvM1BqfYMhurdvevFUo18jYCTbfI3dSeb6NZZZ59JgeHtUOKqmBy+X18gMcFF4lxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sU5KUMXN; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624J2Eet3358702;
	Wed, 4 Mar 2026 19:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=7K0hmDPdyf0ZWvRVQghK8CIA71o+U
	yowkQqNuLZhYrc=; b=sU5KUMXNjKfmTbCRt0NjkJb0VnxczXrLlfy+12EdIQ7Hx
	lLb2qEWejyiz9MDBropr6zTIsms373eIZbX2UuSfzFRSvQxrPQW2qLo0M7yAIg90
	wEdQHucrv541aKh+4X1MJIaw60GhmBpsXlYYqV1QVzHo5NSPmKJc7S0xzp8rDWRk
	Yp2y59d32fpYKwmfMHrKPjwXoDjPDYqp0ETnIuFyy8pfNQjT3YJ/P+Ho1s6dS4Aq
	SP4jtye2bhqzv8SIzc8MowoB1F83v6WUN7Arq51aNxr7RHP6quF3J5cVal5nTBFg
	32GibIadeGvWkso5kEJwAZ4H6Raz8mGkicdRXMelw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cpthtg2nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 19:39:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 624IdKTT023220;
	Wed, 4 Mar 2026 19:39:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptgh7un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 19:39:54 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 624JdrNf032430;
	Wed, 4 Mar 2026 19:39:53 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ckptgh7rw-1;
	Wed, 04 Mar 2026 19:39:53 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: sbhatta@marvell.com, hkelam@marvell.com, jerinj@marvell.com,
        gakula@marvell.com, lcherian@marvell.com, sgoutham@marvell.com,
        andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next] octeontx2-af:  make PF_FUNC comparison consistent in NIX XOFF handling
Date: Wed,  4 Mar 2026 11:39:48 -0800
Message-ID: <20260304193950.2467391-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603040160
X-Proofpoint-ORIG-GUID: FeJoZyXCcQYpqcNaXI7-AduOPwkoB3mA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE2MSBTYWx0ZWRfX2cTYXIQYSqXF
 TURP/jbtg7Fbh6rTVoW0bznZkd4c5bsayokYEm4A27OagGmtpdyOLZKzN4PGmsPRhE9Icz9WQvS
 6gc+xauJ3UO1wMuE1o/EGgb1su/M51wgCDSQjvBgP9EewO4hAkW8mj6BbAHKoMxi3ufKIf6TqHg
 tCm9SCxde8QfbxVsRFpdqKBKas7v3/U8HWrVik1owzJx0u3sg9eEq+dMQstfPtsF8Tgc+8a1IYv
 sOuugXTMgP8AvStmhJURc1gElIaxsMtUxIyDuzUGMwLsoo9OL/HGhCgH11bZLRF/2s2CRbQEgD3
 /gjDm9lxOmzgIDV7HPslF+WkmGONPE90bcQ9i8wTYu5E6l2L0w7bawEzwCTTXOzPOcE0XUiACok
 2jv6lRit75B3Gt6ajGckLSZaaDiQWHqv9vuGD2KoDUHNeFvQR90M7Q5599Vwpu0tYYvbDuX9IFi
 wSkht4K3KHRfyCaV3/7sGfUJgDyWMVPVCNlG9jC8=
X-Authority-Analysis: v=2.4 cv=KK1XzVFo c=1 sm=1 tr=0 ts=69a88a8b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=ZiVtc4tnZ_wSfkjzQ8sA:9 cc=ntf
 awl=host:12267
X-Proofpoint-GUID: FeJoZyXCcQYpqcNaXI7-AduOPwkoB3mA
X-Rspamd-Queue-Id: A9495207279
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264028-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:dkim,oracle.com:email,oracle.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

nix_smq_flush_enadis_xoff() compares PF_FUNC values with the FUNC bits
masked off, but one operand applied the mask before extracting PF_FUNC
via TXSCH_MAP_FUNC().

Apply RVU_PFVF_FUNC_MASK after TXSCH_MAP_FUNC() for the TL2 scheduler
queue operand, matching the existing handling of the other operand and
making the comparison consistent and clearer.

No functional change intended.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 98dd68137a09..32f1b1676a1e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -2391,8 +2391,8 @@ static void nix_smq_flush_enadis_xoff(struct rvu *rvu, int blkaddr,
 			continue;
 		/* skip if PF_FUNC doesn't match */
 		if ((TXSCH_MAP_FUNC(txsch->pfvf_map[tl2]) & ~RVU_PFVF_FUNC_MASK) !=
-		    (TXSCH_MAP_FUNC(txsch->pfvf_map[tl2_schq] &
-				    ~RVU_PFVF_FUNC_MASK)))
+		    (TXSCH_MAP_FUNC(txsch->pfvf_map[tl2_schq]) &
+				    ~RVU_PFVF_FUNC_MASK))
 			continue;
 		/* enable/disable XOFF */
 		regoff = NIX_AF_TL2X_SW_XOFF(tl2);
-- 
2.50.1


