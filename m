Return-Path: <netdev+bounces-266296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKTZEX9osGmNjAIAu9opvQ
	(envelope-from <netdev+bounces-266296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:52:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B81F0256B3E
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B60630ED05E
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAF23A6F0C;
	Tue, 10 Mar 2026 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iOkjw2p1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8D22857F0
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168529; cv=none; b=AN42ePvvvjcPNmiEZmtpGGuIE/f6ddlbbtbNOqFN7jEPXVEAJvGwgD5e/3RTCP6L74n1bQu2Qxf8GmMGqhEXuYIc8y6tkEtb5sGsLaFB8csJcwhJPIMwqN1BSWC5N7lHG7nL5Nl/HHJtrXiQlYuZDDEzdyRj32UPkTXMHpFOdHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168529; c=relaxed/simple;
	bh=NLk6gQ3iGnwEMcW1yHkGiQvoQQTMiYYSa0s0HI0YFFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=stiLFPCOvCar4TfV+JuqLa1k5AXZZuCbqoF9cGIcBKFuH86e0gu9HU4bH4lQs9+Dz0n3XNJCEkFBwSkl2+4jycfh+ebR3mvHyxAJlcQWW6MxfgkIlARz6SfAyTX5klqAJe+ZyR9NEt0sFomR810CDD/v+u5+eO16ODTNJKrwHMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iOkjw2p1; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AAH5Mt094064;
	Tue, 10 Mar 2026 18:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=BdFfzH7zMV8HLEa/cQuTYdoL002sE
	4eSVkIQz2bxs54=; b=iOkjw2p1PxzfPrbgf0wKYGViPwCfKpThzeoDk2lcCrWMr
	mDi7c+x4POcmNo44/iUyCl6X3PFG5y+mjie8ImFqiYgmE5MCDGIPK2Nd3isS39a6
	zvktuWMmTq4yvgm7wL7nKLUp/gdKNmUsPSm2M2h9/KKrefSTcFXdT4eJk3hfYTkJ
	jNzHzAauud7pHZue8T4IVup3oxt3b7CdEyQkHIyoi/kWngantgAB3XXooCJn3i+H
	AcV88XohhD37Y/yzgcK04iytmovmOrZIW6i8CxjA1vIKnGoe7AdhnDPw5QuN6clZ
	LPV9XuN4iWPRpr8Je+T419sr1+QjEOtSaz76fx0Kg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csmdkkfhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 18:48:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62AHfAxj014777;
	Tue, 10 Mar 2026 18:48:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4crafes4aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 18:48:28 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62AIhj7G022917;
	Tue, 10 Mar 2026 18:48:27 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4crafes499-1;
	Tue, 10 Mar 2026 18:48:27 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: sbhatta@marvell.com, hkelam@marvell.com, gakula@marvell.com,
        lcherian@marvell.com, sgoutham@marvell.com, andrew+netdev@lunn.ch,
        kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH 1/2] octeontx2-af: devlink: fix NIX RAS reporter recovery condition
Date: Tue, 10 Mar 2026 11:48:16 -0700
Message-ID: <20260310184824.1183651-1-alok.a.tiwari@oracle.com>
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
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603100164
X-Authority-Analysis: v=2.4 cv=MuBfKmae c=1 sm=1 tr=0 ts=69b0677d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=GGRDrTkq9ZDcpYJ1ayoA:9 cc=ntf
 awl=host:12273
X-Proofpoint-ORIG-GUID: 0jtp8gZyb9QQtNnh9tltp_KswjkLTK8v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE2NCBTYWx0ZWRfXyDG26+O5eQDs
 lve56hb7tGAARdNgMhu7qblF5I8QVhj3mVJtQO6rWuM3HjPlCmWRavvBydFet8qrZmRdj2mSrUf
 8Jia/cs9OKT1oznoW41p+K8Aygs0PNzl0A7CQnEf0CkoGjx14hd75yaflwyphyGiVBzUk/yXVge
 K/peBaFmfrEKYgBa5w+bvFeGJbtABrw9iEUFvyXxRrYN7rKpfNRATVP+qgxycg4DfFHllQDLloF
 ZNzBz42FDqjl4xHHKB+RnO257578NvkH6IoTzPHhewDb179MNM2AIhFlWnucxgm9iok3Bd79hXQ
 Sd9cg35eMPmNNa28tKB2ToZa0b8fnCq393JQtSkBSOP9JEIekEPatqAGtbxk84t1JxaZj/HLUBD
 rgwiL4sYgbxBLNfDAf240q5Ou8SPIOALe7mCi0nYNo8JhICOAlWsYZ52mpb9C3Cz8KY0Hbd+DIi
 Muf2SdgbHsscoLXVfUqG6Niog2bdvETZ4485/2yw=
X-Proofpoint-GUID: 0jtp8gZyb9QQtNnh9tltp_KswjkLTK8v
X-Rspamd-Queue-Id: B81F0256B3E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266296-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:dkim,oracle.com:email,oracle.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

The NIX RAS health reporter recovery routine checks nix_af_rvu_int to
decide whether to re-enable NIX_AF_RAS interrupts. This is the RVU
interrupt status field and is unrelated to RAS events, so the recovery
flow may incorrectly skip re-enabling NIX_AF_RAS interrupts.

Check nix_af_rvu_ras instead before writing NIX_AF_RAS_ENA_W1S.

Fixes: 5ed66306eab6 ("octeontx2-af: Add devlink health reporters for NIX")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index fb15c794efc9..7ef3da0f6a88 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -475,7 +475,7 @@ static int rvu_hw_nix_ras_recover(struct devlink_health_reporter *reporter,
 	if (blkaddr < 0)
 		return blkaddr;
 
-	if (nix_event_ctx->nix_af_rvu_int)
+	if (nix_event_ctx->nix_af_rvu_ras)
 		rvu_write64(rvu, blkaddr, NIX_AF_RAS_ENA_W1S, ~0ULL);
 
 	return 0;
-- 
2.50.1


