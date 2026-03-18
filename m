Return-Path: <netdev+bounces-268917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDdBAI1jummoVwIAu9opvQ
	(envelope-from <netdev+bounces-268917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:34:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FEB2B8197
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0A0B3012536
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB7837C922;
	Wed, 18 Mar 2026 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e9Nqsrs4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB4C37187A
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773822858; cv=none; b=N953i3sWbCJYYCWADCANMgdOIiBUg49/ukGdkaQUipLfesExiDYaZMxBkUNNl7FJ30mGLPVMpQWnihbHKdjBKXQ1E7z+ygviBQ8syiNnkQFn4loEgAHwiedNLBpL6RoAHUFD0G2pRqoEK8G1O/VmPb8jlwr6mDU1cI6hI5AiJLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773822858; c=relaxed/simple;
	bh=HXAxWEjOUK+8t0Fn/YkksllAm2RlVXi1t6S2o0kyioY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uU9L5lyiDtFeXIleWDEbdQ88n3fAiJRlKkLzD9OcGMkJSG0UEEaxwgbIUIyFmAQT70CHFUIujpOfzsuMaE+niaOTC7PB0G4v4ijNswOPCpBtd+VXTD2Z/tP+FeqkxnK/qlwwY+mbqqoTAbtfGpqUkqI6IQrDSwjwbQL/mebO3nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e9Nqsrs4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I2O6un1712268;
	Wed, 18 Mar 2026 08:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=1HT3KoNApG9Oup11/pa2wq4MlCdL6
	1VV8jPX/LrSQVI=; b=e9Nqsrs47AwOyExNEv7KbQOHdMSf3P7GZTqFpJKoer6mA
	fm0BwhdgcB7g6uP692pPbgynuamUm7Zfufyi7er3/Jlhw1c6gsUhI3e3DaJeoV9g
	Sg/vZIMYoe0CMYqe2VfR6RWSUd5vxwgDlP19B/AxTV0yISh5wu8BaKgqlxKWfEeZ
	buDB9qBd2PAm5CxbWNatyhlOXiqQlxDlPGX1KG2dkGJCTxQuyU9fctMNSGavuf43
	fKWDG+W9OaZuWq96/97KjbOrB0ESmkqKPHcpkFF12cEArp0i9Uu8ZTyqTr9pC20Q
	TVkVb2hiKCsMQNGcav3pjSPAi6M8M9wpcbO/pfwnw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvyj65mmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 08:34:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62I7RbAl021287;
	Wed, 18 Mar 2026 08:34:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4pmeag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 08:34:04 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62I8Y4fJ033227;
	Wed, 18 Mar 2026 08:34:04 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4cvx4pme9k-1;
	Wed, 18 Mar 2026 08:34:04 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: danieller@nvidia.com, kuba@kernel.org, netdev@vger.kernel.org,
        mkubecek@suse.cz
Cc: alok.a.tiwari@oracle.com, alok.a.tiwarilinux@gmail.com
Subject: [PATCH ethtool] cmis: Fix incorrect LSB field used for wavelength tolerance
Date: Wed, 18 Mar 2026 01:33:55 -0700
Message-ID: <20260318083401.375458-1-alok.a.tiwari@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603180072
X-Authority-Analysis: v=2.4 cv=LKFrgZW9 c=1 sm=1 tr=0 ts=69ba637d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=_bwHfJjy6k3R0AaavDoA:9 cc=ntf
 awl=host:13824
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA3MiBTYWx0ZWRfX65wfLuWTyBNH
 Mr/BaBktXYwn2fFk+y6nL36N1P9ab25K8Ocs7ozwWHAgTl1zhcoMChgOWMG6l/0/jyMHvPanM+J
 hAtEBDm5Hm2UOJ/o/LAd/tjJ07g9c4LG3QWmWE4HUhbHSzsfbubdAT5e5qNTX4xuWmi9bRWtiho
 xy/tsfPfwiZvSVdxXm4cVgpLwtadgkXTDAdh/XkRQ4/kksxEFoKWrFQ4siBaUpzwZK++oj1Mpn/
 O5/NiRehJxQW7TtoByxOhyhGo1UeSgGCh+bSqBNHbG8KgqGgxtHDUkRdcGBFefZY0l6CGfAaprN
 2ny1v7MTxtc6ERvUnwT3PEjweKrUFpoPVMbkbTK13FrdagfIoHLqwIQ2ygqra5u1FEV7bSTjqwj
 TwrsOYh3mLaEh3oWGmPkLFiCz+nO9AGdRm/bBD1/E/P8h/Uhng5wM7nqcQvl6AJIRBw42R0f1hk
 1JBUfujH0XNg+ztOrGw2/bqlaSwqPX2PTiXBl3kE=
X-Proofpoint-GUID: 6n4Mwqa68XtARW8vqvPV9HlcqdMJDYYm
X-Proofpoint-ORIG-GUID: 6n4Mwqa68XtARW8vqvPV9HlcqdMJDYYm
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268917-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,oracle.com:email,oracle.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 86FEB2B8197
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The wavelength tolerance calculation mistakenly uses the nominal
wavelength LSB field (CMIS_NOM_WAVELENGTH_LSB) instead of the correct
tolerance LSB field (CMIS_WAVELENGTH_TOL_LSB). This causes incorrect
values to be reported for the "Laser wavelength tolerance".

Use CMIS_NOM_WAVELENGTH_LSB -> CMIS_WAVELENGTH_TOL_LSB.

Fixes: 3448a2f73e77 ("cmis: Add JSON output handling to --module-info in CMIS modules")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 cmis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmis.c b/cmis.c
index 305814c..345ce1c 100644
--- a/cmis.c
+++ b/cmis.c
@@ -276,7 +276,7 @@ static void cmis_show_mit_compliance(const struct cmis_memory_map *map)
 				       "nm");
 		module_print_any_float("Laser wavelength tolerance",
 				       (((map->page_01h[CMIS_WAVELENGTH_TOL_MSB] << 8) |
-				        map->page_01h[CMIS_NOM_WAVELENGTH_LSB]) * 0.05),
+				        map->page_01h[CMIS_WAVELENGTH_TOL_LSB]) * 0.05),
 				       "nm");
 	}
 }
-- 
2.50.1


