Return-Path: <netdev+bounces-268918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8O8VFFBkumklWAIAu9opvQ
	(envelope-from <netdev+bounces-268918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:37:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EC72B82AD
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA7A13024468
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E7B38236E;
	Wed, 18 Mar 2026 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hWGh6rC3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE063822B1
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773822933; cv=none; b=FNOPQTXpxit3eeZdWfNxkM1l/JKFXCeFt/MnI+zsW1497SDTuEXhnPmVVn+7a7jZzPXIZiFt8eX0r3kE5+fexpQMvnZ7B5NeWXaDFYl66F3T2lj/yGQGizcRKWWhzr4cOVCiojfdTAz/99bBPLHioQlJuws/Ha2Ug8CkDFJeUWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773822933; c=relaxed/simple;
	bh=r+mDY48GKVucNSX3OTPRLrQOM3AtJ8qe5o18ZnQ2Mes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PlUKkWfmsZXJKuMAV6RNHGE0+W/3UB/6DOGba0LuWJSkvYUqaoIIIaGNn36Ed5xs5d36JKMBmTP6SO5sC/Yl6DY0dA9yBpnp631xr7359Q2iqunFoH+s1fTt6SpFXTnutgCwLEpz6kkjpMhcbgymUZKaYPMhTateDR5oia5NhVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hWGh6rC3; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I2Msk02307274;
	Wed, 18 Mar 2026 08:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=eW1rAwPgrc0kvPWnvDZe+teTA9nMp
	NpIM+ZZbzDlNpY=; b=hWGh6rC3Je4zKf3mpDwAVNqMXgHjXSYPEHBtXPMB6jDo/
	vDrnzzAZxGuC/9cZ1a3Q6aotWRvKJA+43St5QCw/ODnKyeUdESR6J8VTwEq5y7rs
	XF9CNuanZU4MSHo89nuEkkvDose4aNXsgHOVDioXggo+cvXA2SUWlCdXt1JSdR9i
	6FsxyiR1EKkW6/9RVdKoZj9Sw14bk8Ec1TorsGXF5RBhRYR4cRMd3mN/wRkx2qiE
	dUWWTjKUX+re3rCsqmVsmiMhExOPUErV7Afhjgg6ON+KwI1AuTGcTeJOyyy5p+jd
	4p0F4lOlZKwS+Bm8UXJutUuCdmARQOvpNbE2uJ4Ew==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvy9rwj5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 08:35:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62I6C4qc017938;
	Wed, 18 Mar 2026 08:35:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4nvucx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 08:35:18 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62I8ZIJO017101;
	Wed, 18 Mar 2026 08:35:18 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4cvx4nvuch-1;
	Wed, 18 Mar 2026 08:35:18 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: kuba@kernel.org, netdev@vger.kernel.org, mkubecek@suse.cz
Cc: alok.a.tiwari@oracle.com, alok.a.tiwarilinux@gmail.com
Subject: [PATCH ethtool] Fix index calculation in RTTPT2C register dump loop
Date: Wed, 18 Mar 2026 01:35:06 -0700
Message-ID: <20260318083515.375498-1-alok.a.tiwari@oracle.com>
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
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603180072
X-Authority-Analysis: v=2.4 cv=X5Vf6WTe c=1 sm=1 tr=0 ts=69ba63c8 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=duqEgjHrYRZmBGoEmooA:9 cc=ntf
 awl=host:12273
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA3MiBTYWx0ZWRfXyYc4Ffq87yuD
 63QV5fF1iu1OEGlFJrc9frWgJ+dRV1MH1yDAOs9D/YL4j7Y/PIKZAxhfPkDxDAy1AWHYIwjqVyQ
 jhwrENYxLXmq8A8w3yLdOdJdLRVvd8ivpXNJ6XuUFUw9dBClIs3+Tg4rW/yu5bgI2uTXooAjnkT
 s8D3517xKSoeYAl/as5zD1rZrG7PKZ0EfqYZZtug66FxWz8VD5HzbOHrds9TLlv5WE9i9TvO3TV
 Lc2gIjBaiJjnS0O61wp9Ldk3a98zF7npv64RSzsDqUzKRXEw8f3j/nGjYZeFK1BVyEMgGyD+2MP
 N9aFuo8dpAgezHjz2fhaDRJ5Kif8KZOVyJreSTmI74LGKdkgGTEutX19mScGB1RFnt8BlyTcx9B
 NLvjwnirxUqTw01PHcjKAtC5R2xTffjbY3G5ABpjRXOQwom4NLLY202OX1YfdCIll2bn7uD5eHo
 DhT+4CYw1gjZM/RVCH+zhk5yIgxALhoFiXcFdMeY=
X-Proofpoint-GUID: qsGvPyAtsGwymo6s-hm2MoT5W_jm9mKx
X-Proofpoint-ORIG-GUID: qsGvPyAtsGwymo6s-hm2MoT5W_jm9mKx
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
	TAGGED_FROM(0.00)[bounces-268918-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,oracle.com:email,oracle.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C0EC72B82AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Correct regs_buff indexing in ixgbe_dump_regs for RTTPT2C loop to use
regs_buff[865 + i] instead of regs_buff[865]

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 ixgbe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ixgbe.c b/ixgbe.c
index 6d509c8..fd374a1 100644
--- a/ixgbe.c
+++ b/ixgbe.c
@@ -732,7 +732,7 @@ ixgbe_dump_regs(struct ethtool_drvinfo *info __maybe_unused,
 		for (i = 0; i < 8; i++)
 			fprintf(stdout,
 			"0x%05X: RTTPT2C%d    (Tx Packet Plane T2 Config %d)    0x%08X\n",
-			0x0CD20 + (4 * i), i, i, regs_buff[865]);
+			0x0CD20 + (4 * i), i, i, regs_buff[865 + i]);
 
 		if (mac_type < ixgbe_mac_x550)
 			for (i = 0; i < 8; i++)
-- 
2.50.1


