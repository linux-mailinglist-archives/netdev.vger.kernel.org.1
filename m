Return-Path: <netdev+bounces-269319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nBbLBJKTu2m/lgIAu9opvQ
	(envelope-from <netdev+bounces-269319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 07:11:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 667A42C6906
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 07:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 421E530C19E1
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632DF2E8B64;
	Thu, 19 Mar 2026 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UofD7PeB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB3D2DCF52
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 06:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773900539; cv=none; b=pfAifgYwm51OYLFwcY6j3dJo6vn6tf46rmwcM252z+3ZPJd6oIBphZMm5wCssbsmRgXNTamcNnUhMlZQ0HUoaKWnc6B7oEUHLQujZR01ls5r60Syio+w/YUDsiKaS3Sgy/jAK1+DdtGaxuUXcYtC1jLqgE8zQuS9tVG8aeNZRj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773900539; c=relaxed/simple;
	bh=81+59PUbbKjDo0KhwiiutAwkjctGwfDcX2loaTMAdbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9Yb2GmhvPxoleGnQrhx3jYz3pAAo4GnWnf2k+UD/B1wbyXA+8MT5nkX7AIQP1c280CtgoSdVdI9zEF3cmWgmfnyOXyhUOEJmTjIXj5JsDEIxTe413ozh8Hx6JeyEk4D1L2BpDYXCmlk7QyPjEwz9a8Y8WwpZGBLJiAuizI0sW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UofD7PeB; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J4ijmf2706638;
	Thu, 19 Mar 2026 06:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=ZY/0zYxZNJzDbLWzyay8c+Zw0QzVp
	V8hEXPPCVOC0eE=; b=UofD7PeBNQsKYFQZljBwHQeh4z28u8+ueK3vs2CYclz6b
	a4mdQCSTJ+vJtByR4FTVQHq1G/YchUrK8HxA05X0iByYuZoCaGpNy8lXqCdO85Xb
	3Ll9D/XUpOy/tBNaBNk4rvSM9pNCL3ZwFreWA2GyOxJDtyydpkjLuF+1wOaWUs0P
	9HHrgbZyC5BfI0tXUFocJey+I5PmOXOyC3b7xoqXw4vNNLo69fP4hLOqd1d32oyH
	UwA6Zc7ERa6X0xbD9Ce9oNgLDTvxf7T3Oufhw5D2lahGwL5QHeCxnZD7MqBgi6+6
	JnT+FoBtfLOFrd84d1riYMBxIDsOZhLYXzPFgIppg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxf479n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 06:08:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62J4ZYtc021360;
	Thu, 19 Mar 2026 06:08:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4qx6jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 06:08:44 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62J68iKX036348;
	Thu, 19 Mar 2026 06:08:44 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4cvx4qx6c3-1;
	Thu, 19 Mar 2026 06:08:43 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next] net: netdevsim: correct typo in new_device_store error message
Date: Wed, 18 Mar 2026 23:08:10 -0700
Message-ID: <20260319060812.495488-1-alok.a.tiwari@oracle.com>
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
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603190046
X-Authority-Analysis: v=2.4 cv=ftrRpV4f c=1 sm=1 tr=0 ts=69bb92ed b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=gQ_49kHmquteJQZ1tsEA:9 cc=ntf
 awl=host:13824
X-Proofpoint-GUID: NzcX2vO-Qeo-tj66wVfr_1_qDG-sSg4B
X-Proofpoint-ORIG-GUID: NzcX2vO-Qeo-tj66wVfr_1_qDG-sSg4B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA0NiBTYWx0ZWRfX85F/6GNeB8wR
 4KwVqyWlq71scC5sixL3XLzPw5JD5RYMwwe0hCRRAIR0/E6ekR/SgV1bXiFE8HWvOgtnZ8txEzM
 1MAY8YKC2jX2L0b04HihK/EypcSCP03e78w7TM/BRDLW6O8BZAu7vsYMnSN/q2o40VS+yWlYLuP
 dNSNoQmWsdA5tf66cNCvSaqxWjV3poHmuixVQ+2QyXuOoC1xjxlZqCb9fp0cBLQP18Le6C4H/Dq
 S4xoNXrc5B2oHij+nQ97RuUg7Ek2ZkJJpcmHQLVCBrwQeL+l/v7kuX/C2G4FclqvVd4iC+lapAM
 x7iEd/2DacL8EvRPbuvJIihmDhgXJvUazmAWuGQDM7ovpZoBix4+SNaYQcdFhSP46I5QhxWPP/J
 IOknotYbRnplMZTxGUbnZTyXTrZKecknaicW9Td67vrpYCFQle1RnyJb97tgTVDXfTXtwbP7p6S
 ZjtSUoJNJetqz1aWnCt3fYdlwujFH+rkViwrIjWE=
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269319-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.966];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:email,oracle.com:mid];
	DKIM_TRACE(0.00)[oracle.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 667A42C6906
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix the format hint by replacing "unit" with "uint" in the pr_err() string.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/netdevsim/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index f85b1c261dfb..41483e371f05 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -177,7 +177,7 @@ new_device_store(const struct bus_type *bus, const char *buf, size_t count)
 		}
 		break;
 	default:
-		pr_err("Format for adding new device is \"id port_count num_queues\" (uint uint unit).\n");
+		pr_err("Format for adding new device is \"id port_count num_queues\" (uint uint uint).\n");
 		return -EINVAL;
 	}
 
-- 
2.50.1


