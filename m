Return-Path: <netdev+bounces-307393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tpuMGk/4VWqQxAAAu9opvQ
	(envelope-from <netdev+bounces-307393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:50:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D3E752945
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:50:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=YhOv9N7D;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307393-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307393-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 963D03025D17
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483F743B3DE;
	Tue, 14 Jul 2026 08:49:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE83DA5C3;
	Tue, 14 Jul 2026 08:49:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018978; cv=none; b=RhX4fi2PUof+Fa5KyTyGENzLmcNwafOwh9+pQDSasBYwBjI1N+z5RTWjiVACbNlB9f16O3jKv68Krr3kB42dVbyuWubB7va6c7/2MINPhC6tgKJy0bkFj50EK78ilPTBCCBhmS0tnIxcaLDed+jtUmIOJi8Z9tDIGZn9VrABLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018978; c=relaxed/simple;
	bh=IhRizaFZNT6iIhdFTIb+ldPAbmdO0ogff8Wepo1+pNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Urpzfzu4sC0/8V0dNvvIag0vkB2QmJskb98l3ua2OSuqZD0+2Y7oWTci4H47srJT9wvlqjka/eSHD7+tf5i2gv5CEzCz5mwglUwc4tpxFOu70G5rfsVCr7BM83OgFD/cYlRuK4FlcqdvR1/ULhGplCT1Gt0WLUchO/TMXbBff5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YhOv9N7D; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6ffRt558522;
	Tue, 14 Jul 2026 08:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UlBSejEVaIBIEa4r0
	4ayXvj57d2wuWmf9/5AmQVSZxE=; b=YhOv9N7D/P1PBtqf2DwlipTRTS8CNfJv6
	qjYJBnukMtnreigoPtjvxI5vMwx0V13mIKxdwM6iNvY9dgriqFi1rM6RR+0kQWw2
	UkAw9FZaP7RDzqjQ6I6uOSAWTf8QEVfsDMEg6CqShbflAMVLClh959cEwzpdPg3t
	icYLvZ8c/JzqqtXjSPl7GCzogs8NgP33tQB8WQ5OwMo1IrJ3Knq9Yx1RjsdwQKp/
	W0nHM5UIGH2U2t/RT0LbZ2M3m2unS76tcnAeTUPWp5guVywt/zHOUAj1lT0iru94
	iL4gj+tJTBId7DMzyUd05QrSztJgRrz9wj8pIpHs5qUk2quOpA4zw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxd457-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 08:49:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66E8YdWn007168;
	Tue, 14 Jul 2026 08:49:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nh9rhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 08:49:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66E8nQlo43647254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 08:49:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 202F22004B;
	Tue, 14 Jul 2026 08:49:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E416720040;
	Tue, 14 Jul 2026 08:49:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 14 Jul 2026 08:49:25 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id C93F1162592; Tue, 14 Jul 2026 10:49:25 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 2/2] ptp: ptp_s390: Add missing facility check
Date: Tue, 14 Jul 2026 10:49:21 +0200
Message-ID: <20260714084921.3926697-3-svens@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714084921.3926697-1-svens@linux.ibm.com>
References: <20260714084921.3926697-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: hMAd7vudzFfYgF5Bh_2kmfhcsYG2GRc6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5MCBTYWx0ZWRfXxSTVWRkQrccF
 OOi8oJJJ03EO6o4wCJHFgJ3NPae2ZYNdzLnOqm4g10/xKe6kecmUinqUAPJvvdLl491AaDHMCAB
 pR1V4wAXRPxAtAdLRDxYz0J/A5sAV3Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5MCBTYWx0ZWRfXzFYD02nb/0s/
 2zE7g0c7QwBl+8w5MKDJyt3Zh/R+WBAE1SlDDsrJ6YISaTdLfZ/Qk+y319rnuP0eJOUIAznmT/R
 lXSR1unacRyev7sRtX7tU4hqwXAZ6pvZjGJu4dhi3zFDrfpGenAIVHNgUqvIsNQ8cUBfr+93XXo
 40XjFSLmUkPHRsU8U+7nFmt30/Dm6ZxxoNi5It0BWE+Pltc/AfVfzghN/335DfVqsYxYXSe9f10
 R4T8mm4L2gGY6qBOossfRMO5bW9KDTJlqd0LB8512yZpYvVSh7+QXmiIB8srKVL3gNAfXjF9Ufc
 Anq5hKjliXGO3XTQJ201XtyqSUS2uOa26pvuRJ/WHumGyQDw9gH3T63Fv/Wl211kYBO5RtL5Vzs
 X3MFYYz0gGCgSLGBRtC/7UtKAdM4QK+yJfvAfyQSaQE67IKjjtRFBXszHRUbydhCGd8jemZBsgD
 ekdIavh77gEefCZP1iQ==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a55f81b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=15N3dO80ItH7txqtrAgA:9
X-Proofpoint-ORIG-GUID: 40Dz3stgneQ2z818DDZ44weEwNm0e5bc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140090
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307393-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:richardcochran@gmail.com,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[svens@linux.ibm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[svens@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:from_mime,linux.ibm.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6D3E752945

Only register the physical clock when facility 28 is installed.

Fixes: 2d7de7a3010d ("s390/time: Add PtP driver")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Cc: stable@kernel.org
---
 drivers/ptp/ptp_s390.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_s390.c b/drivers/ptp/ptp_s390.c
index 7299c3aae65f..3ea94648cdde 100644
--- a/drivers/ptp/ptp_s390.c
+++ b/drivers/ptp/ptp_s390.c
@@ -108,6 +108,9 @@ static __init int ptp_s390_init(void)
 	if (IS_ERR(ptp_stcke_clock))
 		return PTR_ERR(ptp_stcke_clock);
=20
+	if (!test_facility(28))
+		return 0;
+
 	ptp_qpt_clock =3D ptp_clock_register(&ptp_s390_qpt_info, NULL);
 	if (IS_ERR(ptp_qpt_clock)) {
 		ptp_clock_unregister(ptp_stcke_clock);
@@ -118,7 +121,8 @@ static __init int ptp_s390_init(void)
=20
 static __exit void ptp_s390_exit(void)
 {
-	ptp_clock_unregister(ptp_qpt_clock);
+	if (ptp_qpt_clock)
+		ptp_clock_unregister(ptp_qpt_clock);
 	ptp_clock_unregister(ptp_stcke_clock);
 }
=20
--=20
2.53.0


