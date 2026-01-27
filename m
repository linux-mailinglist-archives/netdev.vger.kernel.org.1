Return-Path: <netdev+bounces-253956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMqFEnj5eGlFuQEAu9opvQ
	(envelope-from <netdev+bounces-253956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:44:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DD292989BC
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CECF30078B5
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2229D312819;
	Tue, 27 Jan 2026 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jTe6ZrJV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BB82DC791
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769535861; cv=none; b=uBmKdwXDSqB1ajfmJHvBOYg5vM7NhlD+iZwhxT2ALtnmTJm2dF7KZPv9lgaAZrzqoFnCflVZ4jK2kzAZLAHFrSpHOIz4l09BBHQ6NwwCqUZk7SF4KBBezh0k6lsaeuz2XK1gFWHP910x8OXn54QJmMIWnrjTfN7hG5MkfC1db6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769535861; c=relaxed/simple;
	bh=wXn+0XhC179yJWz3pippm+1nRV6T8nGZOAqw4GxLUDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uPjB6lHYHfZXHAxJ+Y5M9HihrREAt0FIl21qlNZkQtINlowplbjS6m8JFQVKYKo68mVKAhILkUWmHJ0zUJGRNj39EBxjQLfe4VVeFVqpNK7naG11mAiYET/aoVI9W7LHVnNDv3DgE7716A0jpA0v7pqOu4RSzfPkMvO32UYzKxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jTe6ZrJV; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBEwIx3329570;
	Tue, 27 Jan 2026 17:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=X6KBhdrKX2Ul6jmgEjOPVwTgXD8e6
	q+SHpkeiDxUNxk=; b=jTe6ZrJVnih4x8gzRzkDytprjEe4/9y1Zma3BV2xryoUU
	YOoNUIbyzzd1XTOFJ7IonfYmuoeoauiyNDRNXue81LR3T0pw1N/GyBjiwH6yurip
	xQizmb3usatZjJ+4fn0TXl88J7w9sAbUNBeNKsyTa0YT36mPhuqEaSue4hDgnHrO
	Po4RcwMSGJsUHr3L74UmN3nn56X0BO5IaZJ8pHHmG+dNXnT+0xceT1A+aTkLWbi5
	xU8FV3h+45WxAnQUAndzz4Hlx4FmdBH8zWmoxLiI2Bf6MJHAuOnX+rMQgYAIw+n6
	C0tTQ2uOw0DNF596FZ4IZ8ySFgGwU4U46eIghPPpw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmny4gs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 17:44:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RH0DlT012491;
	Tue, 27 Jan 2026 17:44:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh9s3e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 17:44:03 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60RHi2tu005662;
	Tue, 27 Jan 2026 17:44:02 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bvmh9s3d8-1;
	Tue, 27 Jan 2026 17:44:02 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: sbhatta@marvell.com, hkelam@marvell.com, gakula@marvell.com,
        sgoutham@marvell.com, bbhushan2@marvell.com, pabeni@redhat.com,
        kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
        andrew+netdev@lunn.ch, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next] octeontx2-pf: Fix header guard comment in otx2_devlink.h
Date: Tue, 27 Jan 2026 09:42:52 -0800
Message-ID: <20260127174333.1247747-1-alok.a.tiwari@oracle.com>
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
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601270144
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE0NCBTYWx0ZWRfXxgtwNzcn+vqe
 kZ2ir9AYnqerjWyfv9TUNC78v+ehElo+vgam4Sx3DbPwVmH6sZApubl3LVh6xlp27zGhsM4+v4R
 tMMSolsUF26PAfqTK3S4TrltZrd86C4p4n1+mVDK/K2Q5dSsiODEisigx3i5OcDEjYTmjCuNmMn
 QqmXyfF+a73zYoiAiyhjrm4pGCVO8S0roP6LpC0gpuMie4c5SerQYtBME3Q8hCMiVwPcPZ7aCdy
 23RW6Od7JYfNObs+Iwh6wu9Iz7kFUIK/Bdo7EfJFkp/e1QKIvMmE0MvV4khk6QKyjsLp+nk1imF
 3aOBklsisLzcLrmiP3Bumt+mzrazs4ahuCuuTfUEBQSbzDirD/9P7CTQugtqrE9qhCO48ieg0+0
 /AH7144Gixu+oqMan/rF68DZmWhMl1KTIhWAVqSALbwKAkWH5pTmEkcUgW+bCK/m/mZuoKj511a
 D+IA/wkB3G4UbH4h3zw==
X-Proofpoint-GUID: MawMzU9a2WAIM91Thf22-AqrFuBDBfLn
X-Authority-Analysis: v=2.4 cv=cZrfb3DM c=1 sm=1 tr=0 ts=6978f964 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=gFPa0cGCKXeg3HiXVbAA:9
X-Proofpoint-ORIG-GUID: MawMzU9a2WAIM91Thf22-AqrFuBDBfLn
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
	TAGGED_FROM(0.00)[bounces-253956-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.994];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DD292989BC
X-Rspamd-Action: no action

The closing #endif comment in otx2_devlink.h refers to RVU_DEVLINK_H,
but the actual header guard is OTX2_DEVLINK_H.

Fix the comment to match the correct header guard name.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.h
index c7bd4f3c6c6b..069e39b48847 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.h
@@ -17,4 +17,4 @@ struct otx2_devlink {
 int otx2_register_dl(struct otx2_nic *pfvf);
 void otx2_unregister_dl(struct otx2_nic *pfvf);
 
-#endif /* RVU_DEVLINK_H */
+#endif /* OTX2_DEVLINK_H */
-- 
2.50.1


