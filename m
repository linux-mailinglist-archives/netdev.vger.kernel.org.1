Return-Path: <netdev+bounces-276904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNhrNPly12maOAgAu9opvQ
	(envelope-from <netdev+bounces-276904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 11:35:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 513083C8922
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 11:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C143B309547D
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 09:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B1F3B0AE8;
	Thu,  9 Apr 2026 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ksqR07vc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D933A70E
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775726940; cv=none; b=K22xyoiqSNms+N7T4eNtAZSg6WixCnz2yuP5oOtkwkwmzzzRleEfdja2jpH9zlt0mo2uqo91KWlzfjTpUEGv/+dZNBZ5gsu30mVDW20kAdbfB9sEbqpJHiyM8kq32tMlnsK/j/s3dv2Vb1z6TuvA0aAzfXY5O+HRsJCBn0uToys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775726940; c=relaxed/simple;
	bh=n0kFnOpXabmFwfzHapt3Rvw2MfUtolfG7dvjIFB1jkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GrKgu8lCp7Wr0KA9uQbTuPOUxXLV9pUwzPIlQME//4dx+ziMc2tw23qeAH4rOZrAlW1Qp7+4cNOXi7+zt/XedYrdgB3bDaVyvmeL93cFW6Lagy9ALpL+adEAWrxhf9XQLH2B4Ar6SsSvYKomsfQE/duEhljRAq07Orv/HiY5uaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ksqR07vc; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6399Mg4O1134630;
	Thu, 9 Apr 2026 09:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=wBpTYFj4NhPuSE2QvKreZcYSV8ssW
	Oeb8M96HnJllV0=; b=ksqR07vcSrq+mcplE1Fyp8rRVkkk2vA9ovDlZ9U5iSf1q
	vKsgVWgdRAlND1SBKxngL5v9U/TCrIZTWCciqWdeaccSkQC2Ac0LXYtMKTEowgma
	Oyab+QM2V64rnfcx9dRk2NbSdGFBzax4uFTfqHWCOwyfixUEWdH0ZsscBHYMeQgK
	iOpxsi0TgxMufO9U1H1G+In+MamTeAiX0fDk3w6TPgylrD7UYP+S4Yb/QpJX0WWW
	amS979DsQODCkayBzDgZzG6dSG+SYf/iUPLaer4n2iRt1d4OtMQQy9s0AmTOItZS
	d3NzUK9UIgneOrnVXgLk0PxVHV7jVX2FaKwjoApJw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqa5myk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Apr 2026 09:28:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6397qJQL005201;
	Thu, 9 Apr 2026 09:28:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ddgxrmfqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Apr 2026 09:28:45 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 6399Sii3013839;
	Thu, 9 Apr 2026 09:28:44 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ddgxrmf8a-1;
	Thu, 09 Apr 2026 09:28:43 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: tariqt@nvidia.com, andrew+netdev@lunn.ch, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next] mlx4: correct error reporting in mlx4_master_process_vhcr()
Date: Thu,  9 Apr 2026 02:27:47 -0700
Message-ID: <20260409092754.508880-1-alok.a.tiwari@oracle.com>
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
 definitions=2026-04-09_02,2026-04-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2604010000 definitions=main-2604090084
X-Proofpoint-GUID: zh9UIkSIC9FCA6MptRk6QKG6862JkhZ-
X-Proofpoint-ORIG-GUID: zh9UIkSIC9FCA6MptRk6QKG6862JkhZ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA4MyBTYWx0ZWRfX0W96a23TdqDa
 ElNp6OBuhuBGS2xcgKVJ62AMycKjMlJq1Uqeo4grAFc9i87K/nTYpyLMOkr1Q8jzpNhhj90+Hf0
 EZA4zZjWA1fPksYiEztVxv7N4w68GA8xdjU+ujLh2PrtoqOjE1MVxP37L8K46AMbsatTfZJiT14
 ytwUXNaZJdH8Y2mibA/rZ36TKpceTZJeVFOhpdoZr7YpQBS5zHkudl8RQipCdKOoFixFXDxgPd3
 KPp0DKe+FZWdGi9yPxgaBx9/BfWEz9WolgSTuTfrO32sU7+EmDHe2btrqtGxANPsS7+UHEqu5XH
 50/+fajfBUoukdUTs9lO0/OLX52jJ2pfqiqPkughyNcjozUNmjUf80o4PjXb9Ehkfoj4v6AEDFt
 EFY9YFvkf4lBTx3buHAFcCe9ie7iknQgcdwdHzbWUJD5eBvF/RwzIiwd6jpDVD5CYfXE8L0ZHx3
 9gLqmtTZpg/zcUUiadQ==
X-Authority-Analysis: v=2.4 cv=DLS/JSNb c=1 sm=1 tr=0 ts=69d7714e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=ExyQ2M1wpTjk_N7HTBcA:9
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
	TAGGED_FROM(0.00)[bounces-276904-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:email,oracle.com:mid];
	DKIM_TRACE(0.00)[oracle.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 513083C8922
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mlx4_master_process_vhcr() logs vhcr->errno on failures, but this field
is never populated by the PF path. As a result, all failures are reported
with errno 0 and err print in status case which is misleading.

Use the actual return value (err) instead, translate it to FW status
before logging, and report both values.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/mellanox/mlx4/cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/cmd.c b/drivers/net/ethernet/mellanox/mlx4/cmd.c
index de0193d82ec1..bdaf152e6712 100644
--- a/drivers/net/ethernet/mellanox/mlx4/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx4/cmd.c
@@ -1782,6 +1782,7 @@ static int mlx4_master_process_vhcr(struct mlx4_dev *dev, int slave,
 	}
 
 	if (err) {
+		vhcr_cmd->status = mlx4_errno_to_status(err);
 		if (!(dev->persist->state & MLX4_DEVICE_STATE_INTERNAL_ERROR)) {
 			if (vhcr->op == MLX4_CMD_ALLOC_RES &&
 			    (vhcr->in_modifier & 0xff) == RES_COUNTER &&
@@ -1791,9 +1792,8 @@ static int mlx4_master_process_vhcr(struct mlx4_dev *dev, int slave,
 					 slave, err);
 			else
 				mlx4_warn(dev, "vhcr command:0x%x slave:%d failed with error:%d, status %d\n",
-					  vhcr->op, slave, vhcr->errno, err);
+					  vhcr->op, slave, err, vhcr_cmd->status);
 		}
-		vhcr_cmd->status = mlx4_errno_to_status(err);
 		goto out_status;
 	}
 
-- 
2.50.1


