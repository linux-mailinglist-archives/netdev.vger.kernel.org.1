Return-Path: <netdev+bounces-270235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sSqhKQjNvmn2cwMAu9opvQ
	(envelope-from <netdev+bounces-270235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 17:53:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C542E6678
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 17:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 858E73010D97
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 16:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6FA258EC2;
	Sat, 21 Mar 2026 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KQqdbsef"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C5821D3D2
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774112005; cv=none; b=pYCltfbz70vPBwtXTDwT/F29iUQPO9009PZeAYho0RYX6QC2U5V/ZexiMWvnCE04rCBEor52WW43d9UrxlSUa+730uDfGmeq1MbUbDVrpIUbt4ktFcvdmM5yjUoyPQriITvqIxS3NzpWvtp1GcGgXJ/kntzs5Jroxqi0vp6gkRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774112005; c=relaxed/simple;
	bh=gN91QTqZEG3vd17tKyIRfP1V1SdK19/Zw0fs3h2pF6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ox5URuY6TNTT36ivUFZyRTM9WDa1vXRw4k8xmxvHqtcNgwfMJs/HcrW4oUMCfBal1VOErPdcLJRrhpqNMklbcZ5KJv7qOySW3YzEruOLF+mpCrUhzEKs+P+L/ibuQObDit/Kxiw4hVqtjPR4EkLgvBKAtqa4rie0XHY0Jmk18Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KQqdbsef; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LGe5s32284091;
	Sat, 21 Mar 2026 16:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=YBM51
	b8oPUGBlus0+l0L28bAh3yNDW2w40+brotoPaU=; b=KQqdbsefF/kq9g6c8rDt1
	sAx/UjiqqH/uDwKq+rrMagLHuzos13XjhHDwIP2dC9VI3N6abHkJRdwAbKHU9AD/
	otdYpljtWn1loxLkPExbnb3UBWoj/M+rSJbvFPCDffYP4wNETHbiu8cO7CUosaS6
	Zet3bfpou2N5HHRhBz5Ylg3554uaJX2JDP64JEytiQjzpHpfm2iliV5413pN8zjV
	7srbfGfIfQswbWYexFeAnoCygJCLWdnVrE90GirtSFRh2cD/Bv1J27Wsc6DmLgC4
	m8vDfrOMZOw4Vcej4w9az0XqSvrYBXex8u1AVOlxwpp2+mbgU6M9UZR7PwV6KTrV
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1khf09fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 16:52:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62LFQTuK038893;
	Sat, 21 Mar 2026 16:52:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hs702s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 16:52:44 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62LGqgCo026985;
	Sat, 21 Mar 2026 16:52:43 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4d1hs702ru-2;
	Sat, 21 Mar 2026 16:52:43 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: gongfan1@huawei.com, cai.huoqing@linux.dev, andrew+netdev@lunn.ch,
        kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next 2/2] net: huawei: hinic3: correct IPv6 version check in TX checksum path
Date: Sat, 21 Mar 2026 09:52:34 -0700
Message-ID: <20260321165238.647948-2-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260321165238.647948-1-alok.a.tiwari@oracle.com>
References: <20260321165238.647948-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_05,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603210142
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDE0MiBTYWx0ZWRfXzr+/MAH8weRm
 WIhp+S8erPBYkF2kEeYazYLYQ0TOBVfWjTa6G4DH/sqPaXZ58ZyHrm40WDYJ5gWjwN6x+n+F0Un
 mDbAqseKp2HuYBzLz0vDUIaO1mCVMgFnMC8tSJpgBj8cVwFbEJPGsizmEyjYXyQkDWPfV5x6+Ao
 9fgBky2VqMlxXBkqWgyeuUEf7D11NHRoQLfi4XuH89t7pj7IKUFeQ4EVMG5cITlI/cHT3ELGAFE
 pOs6GRdgDjL53BFECvTS96Z7AlgFAoFf7QzbRV6VDOCiGJmEE7s4lpnTO7zMlw1y+wQyMJ2J2FY
 NJez2JSv+4h49ZtgCBop//nj6t2oifuglW0hGFOvRW/PfO27C+amgm3ueTD1uJA0Dp9wTJn26S3
 BKi1riiJwDH4j4NCAIzCnfHfIh05UPd+SEh/qVki+UcfXj2oynPylVqiH3s3jPun8eeHA3qSR07
 KdgQYfKQiFc0FmDlvDr1i+geGvOiZO8JLi/sgNV4=
X-Authority-Analysis: v=2.4 cv=AIvfpCdw c=1 sm=1 tr=0 ts=69beccdd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=IjSAn9rVpWYb9SUKWfEA:9 cc=ntf
 awl=host:13824
X-Proofpoint-ORIG-GUID: ZxHdhbj8k4PPXzN7etO-MI-L3JZoRK1Z
X-Proofpoint-GUID: ZxHdhbj8k4PPXzN7etO-MI-L3JZoRK1Z
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270235-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:email,oracle.com:mid];
	DKIM_TRACE(0.00)[oracle.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: F0C542E6678
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The TX checksum/offload path determines IPv4 vs IPv6 by checking the IP
version. In the IPv6 case the code reads ip->v4->version even though the
header is treated as IPv6 (ip->v6). Since v4/v6 are union members, this
does not typically change behavior, but it is confusing and inconsistent
with the header type being parsed.

Use ip->v6->version in the IPv6 case to match intent and improve
readability.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index 9306bf0020ca..a57ceb4d68ef 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -242,7 +242,7 @@ static int hinic3_tx_csum(struct hinic3_txq *txq, struct hinic3_sq_task *task,
 		ip.hdr = skb_network_header(skb);
 		if (ip.v4->version == 4) {
 			l4_proto = ip.v4->protocol;
-		} else if (ip.v4->version == 6) {
+		} else if (ip.v6->version == 6) {
 			union hinic3_l4 l4;
 			unsigned char *exthdr;
 			__be16 frag_off;
-- 
2.50.1


