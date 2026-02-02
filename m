Return-Path: <netdev+bounces-255701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDIHC30cgGmu2wIAu9opvQ
	(envelope-from <netdev+bounces-255701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 04:39:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8204EC810B
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 04:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F5193005D2A
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 03:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF56D259C92;
	Mon,  2 Feb 2026 03:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W6bwNNRM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03AC248F73
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 03:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770003577; cv=none; b=bGj2jjCvOc7mHRGJ6lvbRrrdatzmMloBxpZceHO9xnhRbsBZm0X7mtLnLBLL+eXRCJ8uBUD3ZUd5rPEzn9PSOWl1S7IU+GAz/1E8oYbaGPx228c8hN0v67cV/d6OaWJ3WmDHZTHDbQ4w6OubJHp62tDAHvwYO3eJLZqZK7HyGTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770003577; c=relaxed/simple;
	bh=DV7tfqiNTbEr5VOTEJGIOZFedhzs+wrYkdyZvApHCl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dHDcf2is5jTvoRMSG6qH5Hz41cv1B34i+8mQsjOG+sfTp+DEYl341uOGEgeUW4jutOV07euaingwBBf7qef6p1BHEvhYgGAQCWcOeRQyJX5FlD49EEhvY2LWSWDb/HGH3oQiIzOJpjqXVsZlkJDn+No3HI4E6AZRd2XgpOuKde4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W6bwNNRM; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6121tnLW1497411;
	Mon, 2 Feb 2026 03:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=8BRn6GS6RzHTd7VvEahqNMmXhoH2Y
	Sy1UTHGRJwlPVM=; b=W6bwNNRMeTUhd0elCoh+XiB77WrBN5d52uTh+q7rruRP6
	TTGQ9rQP4LoTzS2M1rIeKPt8c3EfKnToJvQkRIsa4EgVinrNHzmvII2GpWESiTYM
	X6XH1z2tTFm15YML/aVm4gnAJ6bQ5BDRMmUdG5mqw7jsBw1MCyE8Ka8lsm3bucS8
	xfO9kcwoWRrqPxfQZJnktdxviFHPj1Ty50VcUP/qRZvXBRQytz8Pci64Sk0TrP74
	jKLyPQAuuJe8OER9MccqJYZYi0Zi/g4FMKehteDtK9KJvlZdbaeWKpv73UhHapvb
	OV9oqMnTPgpcsZ+H8wjIZ4H3pFHDhvyYpTMve01wg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1atm9c45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Feb 2026 03:39:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6123RaRX018713;
	Mon, 2 Feb 2026 03:39:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186jcf2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Feb 2026 03:39:19 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 6123dJk7015479;
	Mon, 2 Feb 2026 03:39:19 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4c186jcf1s-1;
	Mon, 02 Feb 2026 03:39:19 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: vikas.gupta@broadcom.com, bhargava.marreddy@broadcom.com,
        rajashekar.hudumula@broadcom.com, netdev@vger.kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH v2 net-next] bng_en: fix misleading error message for generic firmware version
Date: Sun,  1 Feb 2026 19:38:43 -0800
Message-ID: <20260202033848.22993-1-alok.a.tiwari@oracle.com>
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
 definitions=2026-02-02_01,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602020028
X-Proofpoint-ORIG-GUID: K5EXjDtB_BKTcMD_McAQXOqx8QlKCAYD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDAyOCBTYWx0ZWRfXx3rJ5Wguj7ht
 6HHfnrA6fHD1MoHSK7i2csveSAzeV+1D5qOyFwXRcZzORJIwtKLJgfBgQKcw+tGz5HvpVelal0D
 mFU4egLDSG0UZa24dPx0o7PumXuJjERvMDXjDEp9DPLVbE9aRkeanMyfQ//1yqKkgtzdbI0yeHF
 w44EomJQSnQ2saXjqYA9thqR6joBVaTaRPbI9vrJUtvxWUxbKrxklEc639emesmATUStAvloYHD
 uBlCWQVVh7Oej6hLu0Wj2iefUdS6QUJV8RSh1g87K5nJtLXT9F8DZ/Z7bLtGWsgTx8kmxhmnBzw
 P9EIhVKUwAi7lTujdglnP4k3BXaJ8m22uYvPOcOAR8/s8nIoC+ufQAxlAbrjjjPRr023nUHQ5zY
 1T8ZroknMrWCT+Vad8rENtL+cO44D0Rlw0x0PUWOtRIEYlOdKYe7DCeM/easXAP8Jy0gQvKNYN4
 Aa5YjPCczcmL91L18+aGxmxb+7Phe6J7uhsxo8r4=
X-Proofpoint-GUID: K5EXjDtB_BKTcMD_McAQXOqx8QlKCAYD
X-Authority-Analysis: v=2.4 cv=E+nAZKdl c=1 sm=1 tr=0 ts=69801c68 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=X1PviDuHVR5GJcKRcNUA:9 cc=ntf awl=host:12103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	TAGGED_FROM(0.00)[bounces-255701-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8204EC810B
X-Rspamd-Action: no action

The devlink info_get handler incorrectly reports "roce firmware" when
populating the generic firmware version field.

Update the error message to correctly describe the failing operation.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
v1 -> v2
remove generic word in ERR_MSG
---
 drivers/net/ethernet/broadcom/bnge/bnge_devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
index a987afebd64d..f3a984d4d5f1 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
@@ -221,7 +221,7 @@ static int bnge_devlink_info_get(struct devlink *devlink,
 			      DEVLINK_INFO_VERSION_GENERIC_FW, buf);
 	if (rc) {
 		NL_SET_ERR_MSG_MOD(extack,
-				   "Failed to set roce firmware version");
+				   "Failed to set firmware version");
 		return rc;
 	}
 
-- 
2.50.1


