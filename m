Return-Path: <netdev+bounces-255706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFVRH0M2gGk64gIAu9opvQ
	(envelope-from <netdev+bounces-255706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 06:29:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E03C8515
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 06:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B52D3007C99
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 05:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61DB3BB57;
	Mon,  2 Feb 2026 05:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IgtGD+G0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401183EBF37
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 05:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770010176; cv=none; b=a5cYMcc/3EqOoW/DmBY0s8i4ueqLVY0Z1lb4NtpxeKvSz2sw6W+ycFueApoMzvA8G3Xd+BINp8vNk3NjXV63Sdwencp7K/sD/+ptYURsWqP/mEmaOW5uyYDuqDEdQtcXQ4O0TRqsQLZmaYDZeqhGuoMEB3R9TvW25E3ekziHt30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770010176; c=relaxed/simple;
	bh=O+JAxNMAU5QnUiJHT4tzSd08Dci8HvG2osvHjufpcTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IIUv+wrKIiAjlHVW+d46n3UywQcPQLNTmsa0unsHlnpbrSsaLbIaq8iDrJbqf1N6mZKOyoKQFMKwGEqf85UZRvbThvTxoCGZpBxubgOZ32q3D+HNTNhPNzHMWymlibdZzUnIeJdF2uFWdWF3hzRSV+OCiC2D2NDwhKAXZTPfBmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IgtGD+G0; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 611Mw9Eo293218;
	Mon, 2 Feb 2026 05:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=8/zTt7K32lDSml0jOg2zsnz3fPuUn
	8GLvVhi21bT8vI=; b=IgtGD+G0LCQ68rcws62ewY3LbHrT2UM5wcxy3/iPPl1+n
	tq76lqHUu1GTW9EGmyHdOK3BzVxfI9+txLaPM8Sx0bLFjL9HdJa1JT8vuSXmKvuI
	zT77p74JcW8nyNl85c4hHBmtsKNysAmrZAzmTZ0ORO0Y5vS7QDd6FQy3B60F4zSt
	KHDecYM16VpXZ75xWDIFouYGbE+RuX61yTmOzTf/or1vrCz3WWKDXrfjOr/3XTlW
	e8OI00heyovyAgGQMjMksQ/RUyEVtNPQAsJneXfL4ANLcKCiEzP8gNQKYfy3Svkv
	5Y9DIZn5OWG/GRD9drKiTDPH2RzRB7Aq0cf9SfNFQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1as39fth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Feb 2026 05:29:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6121gXMC034752;
	Mon, 2 Feb 2026 05:29:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c1867x6va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Feb 2026 05:29:20 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 6125Skno006196;
	Mon, 2 Feb 2026 05:28:48 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4c1867x6uu-1;
	Mon, 02 Feb 2026 05:28:46 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: tchornyi@marvell.com, vmytnyk@marvell.com, yevhen.orlov@plvision.eu,
        vkochan@marvell.com, taras.chornyi@plvision.eu, pabeni@redhat.com,
        kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
        andrew+netdev@lunn.ch, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next] net: marvell: prestera: fix FEC error message for SFP ports
Date: Sun,  1 Feb 2026 21:28:08 -0800
Message-ID: <20260202052816.28191-1-alok.a.tiwari@oracle.com>
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
 definitions=2026-02-02_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602020044
X-Proofpoint-ORIG-GUID: AYdRRB2EzwhOvKU6C0Wduiw7849LRJnf
X-Authority-Analysis: v=2.4 cv=Sq6dKfO0 c=1 sm=1 tr=0 ts=69803631 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=-y2SokaO-GGFvZjGeZUA:9
X-Proofpoint-GUID: AYdRRB2EzwhOvKU6C0Wduiw7849LRJnf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA0NSBTYWx0ZWRfXzEwD9h6uA9oS
 q/iXjub15qQFqgfvwjieLsuxmODwqzLt8xRY2ksmZzX2BaJeypldIEuxgRmRYA5VV2wR3y37l4J
 DXVYmZpe7W6aBzrg9nKY5ZN4mNnZNgVXzyHfRrZuTQ2EP3nX0HPDGC75Okfqba2C8h9rSs/aB3q
 ii8+f3q5k+wPIJ40MK6tWHvE1JPnuh/WiHvgf99t5xBnPoBpNFiDieBhKYYk/KUNqIUuF3I66ak
 HX7UFge2NZ6jHdmsTjbSK9BZm2VfM24GvaN9/Fm5OVyqvCnQCy+5um+jm0HDcUHbVcpFeb5/t8t
 uzdYi5KlqFLOKtimuFyZh5vCifv6a6SH/cYPbg/TK0nh6NtnLgTgqo15R6dGR7WaNxzJGisn91y
 qnEw8yxYpKIimT4Or/JXixE+I3OSSlHcOSwREt+onDQHcE7PqmLJsLMfUJYUBkjp1BkgF7O5uWy
 I5rbMHa9Pb5ID6fOySA==
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255706-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D9E03C8515
X-Rspamd-Action: no action

In prestera_ethtool_set_fecparam(), the error message is opposite of
the condition checking PRESTERA_PORT_TCVR_SFP. FEC configuration is
not allowed on SFP ports, but the message says "non-SFP ports", which
does not match the condition.

Fix the message to match the condition.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/marvell/prestera/prestera_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c b/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c
index 2f52daba58e6..a259da9f30f4 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c
@@ -718,7 +718,7 @@ static int prestera_ethtool_set_fecparam(struct net_device *dev,
 	}
 
 	if (port->caps.transceiver == PRESTERA_PORT_TCVR_SFP) {
-		netdev_err(dev, "FEC set is not allowed on non-SFP ports\n");
+		netdev_err(dev, "FEC set is not allowed on SFP ports\n");
 		return -EINVAL;
 	}
 
-- 
2.50.1


