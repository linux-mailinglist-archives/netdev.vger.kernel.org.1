Return-Path: <netdev+bounces-264030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEoHGPiOqGmzvgAAu9opvQ
	(envelope-from <netdev+bounces-264030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:58:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3AE207521
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41BC43053B00
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 19:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77C9373C0B;
	Wed,  4 Mar 2026 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kudnqVDN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A277384233
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772654298; cv=none; b=RuYufMlEAHqoOGWM+KKrmbAZzxwOod7uY2AuBcjQzohdFtf/8Utlw+OhCmfSVxJW1C9C26GRwQG9XPgBrBeZR2y2tuW9LFzg1shk/7iTFguHfeTBRxGPrUGzb6AE5kXvd4hENnyOLHQI3ZgVU8phlI1j/UXObILdOSt3swesRK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772654298; c=relaxed/simple;
	bh=kFO/B4e/IaVbaY9CcGM2YUXt0C8zsScv36IYi5un9Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzS0oGcVVFWjKZI4FgjdlTaLlU0VbXMsvFVr94aXsEKQfoD1yV7m8CM+VkrDspF2WRKnD0Rl1YvJ6nz44oT8g2FxcnlZel+ll0gHGsEI/dXh9M6w/l9oixTcavqXmeAUW1gs6DOFdzP9ei1U501N1wKdBzWmtorRXDJlQzIY/WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kudnqVDN; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624JIZQG562163;
	Wed, 4 Mar 2026 19:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=NK0wdBVWOMqSOx9D4namXKrlO7gOV
	+RASLmvXZgC8v0=; b=kudnqVDNp1J/shFqQ07YY3dZY1609st3X4Cz3MI8oZejq
	Y/jb6lQZUvOlf38AxG4cAYJ95fmpbmdVW7KqJx9Stv1r/JynFfdhlflBmYSB8NWo
	lU384ldwK5JXX4S6aFh0hAhFOk2SJw71jtIG6y9hBn/B6cz0e+0ei/zCiMMG0VQM
	s0ef6kr421xnS2faCg57/JnRni3w6xpj9l9Q78g+xt+AdU6cPv5cTBKa12CBpWoq
	TdOsO/MqyyJs0oyLnTu+x8P19z8qFGeGdvQiQnHi63BocNpsrf6hWrEl6ePjsHxx
	mxOFpg5TEMU8rc0Nb24za+gt5XK6O2XOUBPmb+W5A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cpts9r2nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 19:57:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 624JarnE036974;
	Wed, 4 Mar 2026 19:57:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptc0b4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 19:57:58 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 624JkHBw009565;
	Wed, 4 Mar 2026 19:57:58 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ckptc0b3y-1;
	Wed, 04 Mar 2026 19:57:58 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: hkallweit1@gmail.com, linux@armlinux.org.uk, quan@os.amperecomputing.com,
        keyur@os.amperecomputing.com, iyappan@os.amperecomputing.com,
        andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next] net: mdio: xgene: Fix misleading err message in xgene mdio read
Date: Wed,  4 Mar 2026 11:57:36 -0800
Message-ID: <20260304195755.2468204-1-alok.a.tiwari@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603040163
X-Authority-Analysis: v=2.4 cv=AsvjHe9P c=1 sm=1 tr=0 ts=69a88ec8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=8tFowhmXnpZRbm--SGgA:9
X-Proofpoint-GUID: BCpuMIulLLtWD6BeajtbYWWitWmPIeD2
X-Proofpoint-ORIG-GUID: BCpuMIulLLtWD6BeajtbYWWitWmPIeD2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE2MyBTYWx0ZWRfX2wL+fGrlRxs1
 C0KYIg/IY0wLWmruomRGRWCYkoEEai52mBRSKJ6CUoTUM9l7Snn+r5xUeDkAgjL85HCSkdKKmaF
 iqJmJufWdtFLMKBt5jUSD7vAywXcpsDa1blVDelk023KVXKftc10lc4FBq9vVRdOMlxPZ1sOXk/
 XpBWW+4YLzYCtY2fBmlKO5lJPTCgh3R7aW4O6k7sOx7HMt8spRF7c1U7FYqlkTvRCkcltYS+PUO
 OdTWV07VwSXSR2icgb/NbNxyrWfw3jbDgLYoLitI35oLybf6Gs2AHThGXi3wMzxrF3YArTtLp3r
 yPg2ocldplATCLIHpxHDwY4vk2lv4s2uzd51P8GbSyWH0AWJN78dsyDVOd7RTLL3xB+G1ZnTQnJ
 tZm6OhjFusVEcl7sYpch7EkthSJoAiJvn4PEBJ29fpSqNp+/yx5lGzjwtKtPM6WRArW51s8/Xnu
 E50saGOgJo3lox5K5zA==
X-Rspamd-Queue-Id: DC3AE207521
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,armlinux.org.uk,os.amperecomputing.com,lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com];
	TAGGED_FROM(0.00)[bounces-264030-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,oracle.com:email,oracle.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

xgene_xfi_mdio_read() prints "write failed" when the MDIO management
interface remains busy and the read times out. Update the message to
"read failed" to match the operation.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/mdio/mdio-xgene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-xgene.c b/drivers/net/mdio/mdio-xgene.c
index a8f91a4b7fed..ede6b9ddc426 100644
--- a/drivers/net/mdio/mdio-xgene.c
+++ b/drivers/net/mdio/mdio-xgene.c
@@ -250,7 +250,7 @@ static int xgene_xfi_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 	} while ((status & BUSY_MASK) && timeout--);
 
 	if (status & BUSY_MASK) {
-		pr_err("XGENET_MII_MGMT write failed\n");
+		pr_err("XGENET_MII_MGMT read failed\n");
 		return -EBUSY;
 	}
 
-- 
2.50.1


