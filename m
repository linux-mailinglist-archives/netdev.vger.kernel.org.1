Return-Path: <netdev+bounces-255041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI35BmxefGkYMAIAu9opvQ
	(envelope-from <netdev+bounces-255041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 08:31:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86159B7F10
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 08:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E9C83011C63
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 07:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C042E6CC2;
	Fri, 30 Jan 2026 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ErpeC7iU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9782DECCB
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769758307; cv=none; b=bj/WJfTCAOs+SPJ37te6btTgE4ndk7ZIBQbWOJGeD32zL4BJe3bzNzFOrfeQfqAsXnU8B68U4an6AtDUZvMJR8y3R6GfxPr5KbrP0Pof06msfpfAgi49BGdVQLz3B4rK58d7pxmv1aELHGSyrfLp13ivMQ1sZBswPjNAmFp3AzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769758307; c=relaxed/simple;
	bh=p3dF4VO+6Qiz7FGczFk+FKeEobQkSsypg4n57qKJTRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PMXRIIr6FR7HyN5OmVssvb4euz+yp9271eCx13gUQSq1rRu4RbAuGcPyGF2iM6pGdvVReqB9vaFZ4RU3VV8jMo05F+CKiF153R2fbF5KpWz0wOKeipiKLEkdGFB83fczLutjeN68wp7btmfSEe8tMTIqYEVxV2k/ZOCnn4UlfZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ErpeC7iU; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TLnhGP542649;
	Fri, 30 Jan 2026 07:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=ix/+yLuaAB2x6B2AEOJyq61Uq1xnP
	DQx9JMh2/3mi8A=; b=ErpeC7iUQTFXLHS5EbDWqL9DWWgX73JMvi6tSHL+q6Qev
	FCX/6ise+HReD0BVg/KQ0jp/7H10IoNPyAl3AwGfWSVc7zUnzclIenmkiAWEYpIu
	Wbhig+AX/spP3UdPthinYa4wWvfdCSIJEEIg9ghI3x1Il4UuhkzkSQaxYwOoW5ky
	B0XteGSxxQ8MF3HW8mvFUJQFMlRDgOcb8lO3sXQ/X9eR31zLmGSkL6cz0GPNNax1
	hGdQWbPu72QgYqw3V7MPIcWlbqq3/Wve5slSqcI8isl5L/Vj1Hd8CX3thC+t0ssO
	QxFKOp4WHZno9a0hP09dAhJTGbkt+tZaefo2CnLOA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by5dj4fqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 07:31:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60U6CCbu001851;
	Fri, 30 Jan 2026 07:31:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhhwphe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 07:31:28 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60U7VRJf004952;
	Fri, 30 Jan 2026 07:31:27 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bvmhhwpgs-1;
	Fri, 30 Jan 2026 07:31:27 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: vikas.gupta@broadcom.com, bhargava.marreddy@broadcom.com,
        rajashekar.hudumula@broadcom.com, netdev@vger.kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net-next] bng_en: fix misleading error message for generic firmware version
Date: Thu, 29 Jan 2026 23:30:23 -0800
Message-ID: <20260130073055.1609162-1-alok.a.tiwari@oracle.com>
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
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601300057
X-Proofpoint-ORIG-GUID: dz6aGudXvPTCpuMz36ef80I3qzEJg5NG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA1OCBTYWx0ZWRfX7OLbKPwp9xg8
 BLig2dIqbgiCBPq9QbYEIWRngsdf97ujwMxDTwEhzhEbXkTpB0QYuahhdqe8XAP88R8tiLki36y
 837fbHVFu0hezOyKfg/4H171aXb2CQK20x4Krh/LX+PNZ2+NjNoSnnvoW3YCfXMbshP0VQYYTPK
 wJ+noYG5dfne0jrGJ7ZiYbv0nvCDEEfR6aA/D4tw2U7m2jFyHpLMmHabEOMxi47yA7hzO10jn0J
 WIMeK+v4eQ7CGlG5uXJeGRxBPzUVw8wgXA3Wxk+Wn93sQ9Jry3sC2uGTDve9Eh5RQ0NVu+p/cwU
 MYAAPIfhBlP1Y14W4Z4PjA0xP8RQe4w/fARE0prROCcOCr48W2OfVU6Peo7Odp0EgrRcoVvj+Hm
 o6jVaPwtQ2Rr83o8GR7UYc6cnaz9jfrYPsuwhDOP4UIV8lJ+ItEcmqvi1TnPoKp9j8JkQSk70D5
 NSxrhvhbnQHas50R78tdFGutcBTYwj6b3zLUfHlw=
X-Authority-Analysis: v=2.4 cv=IrsTsb/g c=1 sm=1 tr=0 ts=697c5e51 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=Wjh5z62sGZEWw8ZWgqsA:9 cc=ntf awl=host:13644
X-Proofpoint-GUID: dz6aGudXvPTCpuMz36ef80I3qzEJg5NG
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-255041-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.com:mid]
X-Rspamd-Queue-Id: 86159B7F10
X-Rspamd-Action: no action

The devlink info_get handler incorrectly reports "roce firmware" when
populating the generic firmware version field.

Update the error message to correctly describe the failing operation.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
index a987afebd64d..57db3caabcfb 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
@@ -221,7 +221,7 @@ static int bnge_devlink_info_get(struct devlink *devlink,
 			      DEVLINK_INFO_VERSION_GENERIC_FW, buf);
 	if (rc) {
 		NL_SET_ERR_MSG_MOD(extack,
-				   "Failed to set roce firmware version");
+				   "Failed to set generic firmware version");
 		return rc;
 	}
 
-- 
2.50.1


