Return-Path: <netdev+bounces-257079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBfWIqthhGng2gMAu9opvQ
	(envelope-from <netdev+bounces-257079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:23:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F25F0996
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72DA330215AB
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 09:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9649C38F236;
	Thu,  5 Feb 2026 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dLHv0KNU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2958F338F52
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283243; cv=none; b=tIarEEKtQ7lhnVsSKPknBEiXv/+oHIc3aOrNSUduWtrfTuSp4cHpkqq0pnSipZcZLovwH8018waLZd5UbDTNJ56GvmrxkVHsTrc4icE96bQgfhYFfhYP2wAKHfg0O9k9CyhxQWQ2QfVYa0eTR7W6AviYAvVbIZbU4J8f0EZK3NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283243; c=relaxed/simple;
	bh=nAjaJGYQ9yv1NAr1PTcoIkTKJy7Umu+RSvznDuZP8yI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UEfbQAG/hfVYUSwU5BD5M1jv3f74OeeWNwUuMGsnfWGN2Fre1z1AkBEf+JJpL1KfgzQb4YciheC29tpe4W/ZfwZgUXAxcoYHaiIKC3nK7xafW0wDGLfPGeCjfd0yeIWq3/SoWQN4I7fZ0DNiD0q4F+1IV6EOtO2I73/2m/yT+OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dLHv0KNU; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614Mu0Qm1716219;
	Thu, 5 Feb 2026 09:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=cM0LiDRxA5336s77lfnjlxV+Y/RNR
	miRjdkC3HiMb1U=; b=dLHv0KNUbiACIzjrfyVr9x1OHg+oDb/YbuHn4Lk2+e8NV
	75Bk+aUuWUlQwBAgT2/yRx6zCbZi+6OplRPv3SzvwxJiwsvyFZ5jysm2BJhZH/mx
	yU46ivvtxMsVCAWbGMHIz3D5WAGRtQKbTambN92pM1f4T6+mWASa3ephkcG64KgF
	MfrU2YBH8pbib9A58+JJ0trKpX9LEzADkvMwzAW3kWQFbHY7v68Wmkt+8Z2RF/z1
	QzbbvAVRWDXnURLACh4LZzUt8ndldpbxkVO4PpfwYMRXSJBjHFSuGsFIPe0tdeDB
	XZDugVoZyORM+seCYzgGXZENGgGnMss5PKkE/xQRg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3jhb3d2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 09:20:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61591sfC034760;
	Thu, 5 Feb 2026 09:20:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186cuah7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 09:20:28 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 6159KSks017505;
	Thu, 5 Feb 2026 09:20:28 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4c186cuag7-1;
	Thu, 05 Feb 2026 09:20:28 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: enachman@marvell.com, tchornyi@marvell.com, vmytnyk@marvell.com,
        vkochan@marvell.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
        netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH v2 net-next] net: marvell: prestera: fix FEC error message for SFP ports
Date: Thu,  5 Feb 2026 01:19:55 -0800
Message-ID: <20260205091958.231413-1-alok.a.tiwari@oracle.com>
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
 definitions=2026-02-05_01,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602050067
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA2NyBTYWx0ZWRfX2NCNYLoRvgXG
 txMQ2Cvmcd6DKR4w2a4rfu7R4smJAOUgRRgTtehDt/NQu0bnExZxb/gRjV4bqoLv63qkUxNkSbk
 ftUlSlPxjKKVuh1KVZqmcs9jwEBfrIyxyovvVG4CiZjTO/jgtjze7hyukYSYdta9Xh91XpH/qV9
 gLhaeTkH1CqcVvgv66lZUoenhh4bSaZOXynzIp9XEUKjtnMP+bWLpDo1JLBk2J/8SCnxmPWNMa1
 AhDamrJE1x09gXc05Rb79ANSdhURQzDhckyU634/nH4bqm2N3kzOqBke6vmtMo0wfWpJt3vvzY5
 TbA1z/GSWGzyheOPZYI5qexwZc42emnGanyKWn+7Iq+YZTMIbJgttfbw+hYvy0xuSW/nVyxkGSD
 XKqYVZT8QKTh1ZYp36a7X2spfN0rnDuB5nGrGCKkFDeuKPman1fQAZIcJQ58XrmSJYNz2iXEdSm
 Q3BQ55P9xDQkQQVaR7A==
X-Proofpoint-ORIG-GUID: -QY9DocLXbfOQ4BGlxGPstuxvtLjxjSy
X-Proofpoint-GUID: -QY9DocLXbfOQ4BGlxGPstuxvtLjxjSy
X-Authority-Analysis: v=2.4 cv=CaYFJbrl c=1 sm=1 tr=0 ts=698460dd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=-y2SokaO-GGFvZjGeZUA:9
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-257079-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 05F25F0996
X-Rspamd-Action: no action

In prestera_ethtool_set_fecparam(), the error message is opposite of
the condition checking PRESTERA_PORT_TCVR_SFP. FEC configuration is
not allowed on SFP ports, but the message says "non-SFP ports", which
does not match the condition. However, FEC may be required depending on
the transceiver, cable, or mode, and firmware already validates invalid
combinations.

Remove the SFP transceiver check and let firmware handle validation.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
v1 -> v2
remove condition of if (port->caps.transceiver ==
PRESTERA_PORT_TCVR_SFP)  check instead of error message correction
---
 drivers/net/ethernet/marvell/prestera/prestera_ethtool.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c b/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c
index 2f52daba58e6..750c72f628e5 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c
@@ -717,11 +717,6 @@ static int prestera_ethtool_set_fecparam(struct net_device *dev,
 		return -EINVAL;
 	}
 
-	if (port->caps.transceiver == PRESTERA_PORT_TCVR_SFP) {
-		netdev_err(dev, "FEC set is not allowed on non-SFP ports\n");
-		return -EINVAL;
-	}
-
 	fec = PRESTERA_PORT_FEC_MAX;
 	for (mode = 0; mode < PRESTERA_PORT_FEC_MAX; mode++) {
 		if ((port_fec_caps[mode].eth_fec & fecparam->fec) &&
-- 
2.50.1


