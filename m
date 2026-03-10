Return-Path: <netdev+bounces-266295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPNhGpNnsGloigIAu9opvQ
	(envelope-from <netdev+bounces-266295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:48:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D13AB256A97
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 423253008C18
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEE435FF50;
	Tue, 10 Mar 2026 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NVUYBWSo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC77E33260C
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168527; cv=none; b=i/dK5tLVKTaEWezBp4EeWsPWSlut5lK8Ml1Zxsyq8DrSvFswAHbkg42fhFSSjkd0IobvEGq0L0q22d5SnC5ZMXW2MSRHVMgW0b//vVUh0b8WDcwe7RPj7NsXRSIxL15oXq9j4K13ryhqqNT4gWKPQjYPSLlTxPCnEqddyGKQ1go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168527; c=relaxed/simple;
	bh=xBeHobUjwYNoZJh4i/+iaew/LTWGRxU9VLkybjg2rm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6JshuwrB8EBy/58thzYdPn0LCghOlSx4rT7PdufL9no4sM8y6GKIzCf+QHzO+xA0tGsLNfesH+atbRQjeq5PEE3xf1KnAGKqov/SwNGq20KCXgCyBcjdMLYtRbYTtx9GrpaQmregy7yqgs7slQnSuxLZzaNfgOWpWyOfP3aK1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NVUYBWSo; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A9Uh5S2582671;
	Tue, 10 Mar 2026 18:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Qv+4+
	7NCUaeyvvMtlO5/RY1JZrO+motoSZrXr0HRkAA=; b=NVUYBWSopYYlV6mBVewwa
	UBh+ol6LR9rpljAYnqCcn6SLUD97R9uKaQ4rY+0syLxwOOdfMx4+lhIepci28eif
	kbZWJBPSMjyZoFC4ukm70zjP4AqHLr7fh9mCIf0CW/aSkTQTCavwGadYhAkBkRvE
	jFlvyd779ehYMXzatqidXUoMpADbHwMh8ARZvHuPyXnl2i8tsQfB1oSBOtC8up1q
	Rsq5BNTXBbY5qEPnQzWWtm0jZkAOvs86T/jg0EX7v+Cdmo9quqlueG3WDLkl7gu3
	fyqvx3vkD59d4mNprg47IEJyT7I+OkKDhXURClKC7YtPYpxW5sfF3IoKQ/7QPk+R
	Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csm9cug4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 18:48:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62AHfAxk014777;
	Tue, 10 Mar 2026 18:48:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4crafes4c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 18:48:30 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62AIhj7I022917;
	Tue, 10 Mar 2026 18:48:29 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4crafes499-2;
	Tue, 10 Mar 2026 18:48:29 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: sbhatta@marvell.com, hkelam@marvell.com, gakula@marvell.com,
        lcherian@marvell.com, sgoutham@marvell.com, andrew+netdev@lunn.ch,
        kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH 2/2] octeontx2-af: devlink: fix NIX RAS reporter to use RAS interrupt status
Date: Tue, 10 Mar 2026 11:48:17 -0700
Message-ID: <20260310184824.1183651-2-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260310184824.1183651-1-alok.a.tiwari@oracle.com>
References: <20260310184824.1183651-1-alok.a.tiwari@oracle.com>
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
X-Proofpoint-ORIG-GUID: 8Pj3_5JkLvMGQU5JM37pgZSU7xFBMFu7
X-Proofpoint-GUID: 8Pj3_5JkLvMGQU5JM37pgZSU7xFBMFu7
X-Authority-Analysis: v=2.4 cv=LeYxKzfi c=1 sm=1 tr=0 ts=69b0677f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=0KbjFF4dJjV3BNrtTV4A:9 cc=ntf
 awl=host:12273
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE2NCBTYWx0ZWRfX15sFQC/R1QK2
 2x5av/fITVf24r5kmuJMMtXxKebNwcJkqsK/xC2GRh4z1GGz75iHIn32H/jKjzVnE8NzNuq4oXn
 sv9wM6nFGdLD9cxwdM5Juf4yHijo4/FLLfyre/TLzSiC5E1Bk6R4iNFTrWtnyFjlbxN4oqZoVkP
 t/gn5BtW+o9ZktJb+td05pPoxhai2Eg81/f3lONIpz7Ru3SqyhuXFWPHSGtWZbSZ4QuGP2NjZMB
 20kG3MHQ/AwGSQm09rIR5EC4yFAfavGf3SmDyPMHhy5MSOTZ3uKJLKFryXAX40xUQ137R1MqfAP
 Q7QjxtU0slkjtm9+RYeSudAQ97Rx5DmnHoaTwFT+1zmbNUjikB2u7RBmpLzcRkzyYlUr8um4H3A
 bGj8sq/YkpBsjydKbXjy7wIP6/IFFvefznjagRE/BvwAtj238GiXHV+rKnJToEwO4vAqFbKYfbv
 rvv1EQxL8uGT5dOc7VSCfrpEw2nJx7Muk3DM/dG4=
X-Rspamd-Queue-Id: D13AB256A97
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266295-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oracle.com:dkim,oracle.com:email,oracle.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

The NIX RAS health report path uses nix_af_rvu_err when handling the
NIX_AF_RVU_RAS case, so the report prints the ERR interrupt status rather
than the RAS interrupt status.

Use nix_af_rvu_ras for the NIX_AF_RVU_RAS report.

Fixes: 5ed66306eab6 ("octeontx2-af: Add devlink health reporters for NIX")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 7ef3da0f6a88..a29f1ea04c7d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -327,10 +327,10 @@ static int rvu_nix_report_show(struct devlink_fmsg *fmsg, void *ctx,
 		rvu_report_pair_end(fmsg);
 		break;
 	case NIX_AF_RVU_RAS:
-		intr_val = nix_event_context->nix_af_rvu_err;
+		intr_val = nix_event_context->nix_af_rvu_ras;
 		rvu_report_pair_start(fmsg, "NIX_AF_RAS");
 		devlink_fmsg_u64_pair_put(fmsg, "\tNIX RAS Interrupt Reg ",
-					  nix_event_context->nix_af_rvu_err);
+					  nix_event_context->nix_af_rvu_ras);
 		devlink_fmsg_string_put(fmsg, "\n\tPoison Data on:");
 		if (intr_val & BIT_ULL(34))
 			devlink_fmsg_string_put(fmsg, "\n\tNIX_AQ_INST_S");
-- 
2.50.1


