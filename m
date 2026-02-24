Return-Path: <netdev+bounces-260522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJDZERainWlrQwQAu9opvQ
	(envelope-from <netdev+bounces-260522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:05:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5E81875FD
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACDAD30412A6
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF99039B49E;
	Tue, 24 Feb 2026 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SBNiKP/U"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7315139B48E
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938319; cv=none; b=WwT8QTtAUlqkVs1OOQc78Vufdz+/K9rznjcQN+UTm5dLT6dqwEs/qgciguZmuGSt3j6dcHXfZaaL7khbJcEdCle98SSOBmku6pt+/9JJOLGEa6wEZncCzZ0slvXGqrOduzywSEZ1HcVw3xG9xsAvFmRcisR3Z93sqSbegHE8Y2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938319; c=relaxed/simple;
	bh=WA9F2BUhPPQWJ3KUnSwG0GvgcRanSBYwKOaGdDznZ5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOVQFwD8SbYF7riWDqe9NnhMp4/LbBdZcrB+aH1eONQhh3s/zJAZ9wmXX9wOBevVezD9lZTUDm8bDZ9BATgT4YBKQLdsjbN5sbi7X5yuh1zZTkfswEAkIaayrsN4WivYft8j7wLIald6RrNRXcNkl64ftnXRg2nhSk/AiBm+wWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SBNiKP/U; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NMv5D23045533;
	Tue, 24 Feb 2026 13:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=8Hy3EX2xXj68thJlLm0pRPZafLuv3
	evQ7IZ7/HLWn1w=; b=SBNiKP/Uf9TlgqEfYHoZfyIsqdRGLkZQSVNj9fPOeb4uR
	DqMglwXN0OD2/hM1MDZ1IjZYrwbfGnEzasiA99AQ6uYIIVNPgITxm3Mv+gpcKduy
	irAjxaLBPmpNcD6dAViYwY5aJVtW3LvAbMmFay89IR6bQQ4qjmhn+O3Bb4kcD7ic
	ZT/nrt+10yuyHs6a3ISUxqN1++2jRI5Wc+SsdO7fk6h6vMLHEaA81DLj4FZ8sgmu
	TdGBnLpDX2HsFxmoVoSCPsmxb43OOKZqDst2GaXDr8fiNCEjf+9Wb1ChjQGA2hr/
	S9InL0n2nJn3Vmda8SHCtSkgN6pN4tCqeFEXeUKIw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4arc608-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 13:05:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61OCckPg038415;
	Tue, 24 Feb 2026 13:05:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35kxae4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 13:05:03 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61OD0sAR020702;
	Tue, 24 Feb 2026 13:05:02 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4cf35kxab4-1;
	Tue, 24 Feb 2026 13:05:02 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, andrew+netdev@lunn.ch, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com, ntb@lists.linux.dev,
        netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next] net: ntb_netdev: Fix NULL check ordering in TX handler
Date: Tue, 24 Feb 2026 05:04:47 -0800
Message-ID: <20260224130458.1355686-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602240107
X-Authority-Analysis: v=2.4 cv=La0xKzfi c=1 sm=1 tr=0 ts=699da1ff b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=KUN_3tzMj68wRxwuEm4A:9 cc=ntf
 awl=host:12261
X-Proofpoint-ORIG-GUID: mqknJSqL-UUZUsE2bbGJDkuCp6mQrN66
X-Proofpoint-GUID: mqknJSqL-UUZUsE2bbGJDkuCp6mQrN66
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDEwNyBTYWx0ZWRfX1x2wa94So9RV
 fG9w3jqEw2nyOhroeG2cQkLYrcOEFVUHvHrA0jYi1TzZ6ZeHEVkAqsCHzaq2uyu5qKeG8B6hlWb
 aMXzXPNDUxikoFe8uo/KjLw9ryHVgdc4OmqVM98Cifj4piM/115+5CnXb3Pnall0FmYREqLHGIt
 Jq2FtXZsAiVjg/0uxEdI/d0pEkc1i5Ngep5UrnsIuVEGEmxaeRoHWAr3DJCwTqfaRbprdxT4sRb
 4lXYHXE/k4WnKq5V+rB0nScx4Fq2GB0hqI6qIiDMjEmhSsejBaFox+FG4y6akFuMOB+k0a3T5hL
 8jErBIZDT8vXbBkSd6GEUg3hoYyv1Kbi/6YMKjKgbdY30t83lLilNPigbr/258n/+DmDZrwiatI
 1vNHYNoo995kCAOdU/MwWmSRcOTBdUVx4VZVSTa0Vi3riMaobd6KMRTMrjur9HRIxcpXooCQiab
 VGEV5UJ17AEqsr0PMTOAIrWxdXFUdJuUlE5lMRbU=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,google.com,davemloft.net,lunn.ch,kudzu.us,intel.com,gmail.com,lists.linux.dev,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com];
	TAGGED_FROM(0.00)[bounces-260522-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.com:email];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5D5E81875FD
X-Rspamd-Action: no action

ntb_netdev_tx_handler() calls netdev_priv(ndev) before checking
whether ndev is NULL. Although qp_data is expected to always be
valid in normal operation, dereferencing the pointer before the
NULL check is logically incorrect.

Move netdev_priv() after validating ndev.

No functional change intended.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ntb_netdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index fbeae05817e9..6792b3b1f253 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -177,13 +177,15 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
 	struct net_device *ndev = qp_data;
+	struct ntb_netdev *dev;
 	struct sk_buff *skb;
-	struct ntb_netdev *dev = netdev_priv(ndev);
 
 	skb = data;
 	if (!skb || !ndev)
 		return;
 
+	dev = netdev_priv(ndev);
+
 	if (len > 0) {
 		ndev->stats.tx_packets++;
 		ndev->stats.tx_bytes += skb->len;
-- 
2.50.1


