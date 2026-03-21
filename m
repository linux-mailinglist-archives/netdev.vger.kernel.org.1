Return-Path: <netdev+bounces-270227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLoWEMG7vmlIZAMAu9opvQ
	(envelope-from <netdev+bounces-270227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 16:39:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D54DA2E6274
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 16:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C01523022F47
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 15:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEADC3932DB;
	Sat, 21 Mar 2026 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U9IiN9me"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D2438F941
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774107578; cv=none; b=XwgqDKVQDZYBWELD7y9yzulMk9Dl3ETrRQ8bVfUKBwBzubW0iTcLj4q6ULuN4zF6SV8a0328iPNdqqo+X1u8nU++DsR6O7YzF5J+htvtJYo9s4HVhyRIr9q32IfYUE7/4tsVzzUx9funVQDO1akYzDed7Y9KQ/y1ax2+FiDXAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774107578; c=relaxed/simple;
	bh=ChT9oRDKs+YyDuTUTLF25/5MCNlcWVivoWKUurqi3kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUnRIuFrl1iIhTBH7FrLGNhA0aZsOcOahVNPGP/1OifFad1qqHWcBMooVEgLeP3wFCbPSL4bd0EulOYlX5Jgp0Zx6kp3F7ZhmAkLojWQ5hwL7eJ9HWIZBw6+mVoVGxWoJQaQTME3nsaOgcHrJ7XhpmrepEDdHqskp5E2wHKmGuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U9IiN9me; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LF14qi1287602;
	Sat, 21 Mar 2026 15:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=5si90YiB2xKvKR5rXkT0WOT00VT5M
	MTSjC1RK06hkRI=; b=U9IiN9me7hVFyDA1jY5K8nWZOthRPQfKBjJrhYmNYRzJs
	8T5EqKH2/DRufCMWcKYnfwijbwVsH4PZACU4osE6fh+edF0BZI8yFI0iAsn5nnea
	DIuNECNuJ98ZAKLwKedtSx+79Pgl9oKRit0+nr6QluO8NUEBNU5rsaz+WTnc1JJ5
	6fv6hcrdAicmeZ6ssZcblZjclBGSydyX96dprBhbmjG7vQ3lHsfLYEg501sXeq1g
	Tap+R2awcle4Z7EU4B+BH944j271gQbYOscQLv/5FgZCYAQFv8wSQsolBTWfz9os
	LHJjXKEG4H4bVcjprGketMzx7HZXPVZw7ngP/7LZQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kvng881-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 15:39:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62L9KZCZ028887;
	Sat, 21 Mar 2026 15:39:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hs6wruu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 15:39:13 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62LFdCqA009538;
	Sat, 21 Mar 2026 15:39:12 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d1hs6wrtk-1;
	Sat, 21 Mar 2026 15:39:12 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: danieller@nvidia.com, kuba@kernel.org, netdev@vger.kernel.org,
        mkubecek@suse.cz
Cc: alok.a.tiwari@oracle.com, alok.a.tiwarilinux@gmail.com
Subject: [PATCH v2 ethtool] cmis: Fix incorrect LSB field used for wavelength tolerance
Date: Sat, 21 Mar 2026 08:39:02 -0700
Message-ID: <20260321153905.644959-1-alok.a.tiwari@oracle.com>
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
 definitions=2026-03-21_05,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603210132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDEzMSBTYWx0ZWRfX+BIPvz3KiDHt
 7f41ftqQQSn2FdhBPJ8AFkHC1v3Jmy91qf6G/4/0bEfLLimXJi+39SqDcId1+u5iU28SO+S90/s
 eq4z16NStIEsqRHZs5hAsSCnK6A/9lJ6hLSWBO0rJQOJTfvOxsfXEQN7Z7t0RPGCOpC2vDjVg8X
 hXfkfxdeRQNCM4iC26SMRE2kdDhJH1p6EHSMfltvpwb9+NlreyHmraCd33aiLGUbdW39BBUjdoo
 5WwdO1599zAIGAxX2aeR3tKXTVxDoj0bck0XFP4A6Nuw3wn4c4DWzPZbicgOiowYpB7KoP0Stmo
 fidF2hvvmtDtQKR9Kt+eyaULLwN5jvJXrNnFVUYjlYoxlH2bCmTycUe/SpXkvXe5WyG42WpORbK
 U2MfImUxzcRqgMjkh/ZZMtwy7H3CSAf5qgXMkuK5MkIsBXLgilrLZ/YUOn6vtQhWk9uKp3m9HIS
 94INPIfQinUCV8fkvFg==
X-Proofpoint-GUID: yILqFSuDm7m137rGgE2Q5-CEuAe7XphB
X-Authority-Analysis: v=2.4 cv=GrtPO01C c=1 sm=1 tr=0 ts=69bebba1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=ZJccf7p4IP6gnwPS0usA:9
X-Proofpoint-ORIG-GUID: yILqFSuDm7m137rGgE2Q5-CEuAe7XphB
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
	TAGGED_FROM(0.00)[bounces-270227-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: D54DA2E6274
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The wavelength tolerance calculation mistakenly uses the nominal
wavelength LSB field (CMIS_NOM_WAVELENGTH_LSB) instead of the correct
tolerance LSB field (CMIS_WAVELENGTH_TOL_LSB). This causes incorrect
values to be reported for the "Laser wavelength tolerance".

Use CMIS_NOM_WAVELENGTH_LSB -> CMIS_WAVELENGTH_TOL_LSB.
correct 0.005 nm LSB scaling for the tolerance field (per CMIS)

Fixes: 3448a2f73e77 ("cmis: Add JSON output handling to --module-info in CMIS modules")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
v1 -> v2
change 0.05 -> 0.005
---
 cmis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmis.c b/cmis.c
index 305814c..996e9eb 100644
--- a/cmis.c
+++ b/cmis.c
@@ -276,7 +276,7 @@ static void cmis_show_mit_compliance(const struct cmis_memory_map *map)
 				       "nm");
 		module_print_any_float("Laser wavelength tolerance",
 				       (((map->page_01h[CMIS_WAVELENGTH_TOL_MSB] << 8) |
-				        map->page_01h[CMIS_NOM_WAVELENGTH_LSB]) * 0.05),
+				        map->page_01h[CMIS_WAVELENGTH_TOL_LSB]) * 0.005),
 				       "nm");
 	}
 }
-- 
2.50.1


