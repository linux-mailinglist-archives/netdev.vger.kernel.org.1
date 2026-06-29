Return-Path: <netdev+bounces-302828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NFDsJyXgQmoIGQoAu9opvQ
	(envelope-from <netdev+bounces-302828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 23:14:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E3C6DED1C
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 23:14:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=VbotzhSf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302828-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302828-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 228FF3001825
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022FC382290;
	Mon, 29 Jun 2026 21:14:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61CB33ADB9;
	Mon, 29 Jun 2026 21:14:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767649; cv=none; b=U1o5dF7qF3F5hdfDcTAh4hk/PiGxXaKnYA+kWfxGP7TLhuIi7NRoX4Zf/pkfowaeFHreZ1O8DMDNl2SP9oeZFlagNVu3Rmb1B/AeztscqBi1upfCDBRb9cCBm7mBfA9q0+4REcdazuqzai+4GDbrFnMBbl1n/y5iuERqKlFkYcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767649; c=relaxed/simple;
	bh=QKQZKGspDO9Ian5T6DoxwASi58FrTMyf0vXiQi+nsvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EuCZd4QEEZh3VVHyQceC7+mUukSZWgdDAloj95mcJuExtJWy4X/y4Gxx/Ac0X5hDaum715TGKycb1/k7Re+UUSctiI588qoWYJolXwZMkQA1HfSxoEhF8Rdou/O4WcT+HCyzy8x76G5RPSem4eN2ZCGHARvwAdLI9nkbbCM/S+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VbotzhSf; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TKmbiP118754;
	Mon, 29 Jun 2026 21:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=k6s6rMxHkE8UCeYRlh/50Ra+0YJH30fiBwZ2ps3SP
	hg=; b=VbotzhSfPCjZJF6oI40oz4WDulpO2Skaa/CGIorsLDupHR5OHu4H1kt6C
	/XHTl/CoKpnCSedQ6zYsfGpwXypxL2yyPYx/qPTdbT6StlXFSJtm8AL/gmO3wVxU
	Ap+vmEwZVRyQtro6lzF2zeO94E23AfHFIx5ziUKxGll97Dpu+9fTiI/ArWGfQCoh
	CsKd1L4ynuzi9Zl6l3tJFyJ04YxqG/EK9w0nn3gUClQ2Kn4WHsq3tyHGZDOfGDLP
	4FNnJRiedOTjpxtHwgRoFEBpx49EDUBjweSDmdhRC/IU/xd2WD3nf4//xG2PlqRp
	TRoOOl5LAVRDTOA2pZQZZT03SDpow==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pduhd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 21:13:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TL4cfL018401;
	Mon, 29 Jun 2026 21:13:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhy71k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 21:13:43 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65TLDgM811797174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 21:13:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C16D358055;
	Mon, 29 Jun 2026 21:13:42 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DCE958043;
	Mon, 29 Jun 2026 21:13:42 +0000 (GMT)
Received: from ltcblue121-lp3.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2026 21:13:42 +0000 (GMT)
From: David Christensen <drc@linux.ibm.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, David Christensen <drc@linux.ibm.com>
Subject: [PATCH net-next 0/2] net: remove the orphaned IBM eHEA driver
Date: Mon, 29 Jun 2026 16:13:41 -0500
Message-ID: <20260629211343.3712775-1-drc@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: rmScWcMhoat7NIpx5BnhtFhVaJlwDeJN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE3NSBTYWx0ZWRfX4cC5R1F0F8E/
 EPJlqJ0ElWut9xueHHuMtXrtuoP6TlCiMOwlB1y6JpFc28USiv2OvlwDm2mVv1gPA4iYHTqzqyM
 ItMonVCmkP2IYcSuc99IVlt/BzUTg8k=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a42e008 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=IvWWDg-NrMPg4tOFgfIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE3NSBTYWx0ZWRfX5dIE45Ygui8K
 e1tFmk8DuxCGCRjCfz0l14S1j4X3YLC2SXML4WMGYnXDXOZ4Ptbosd1YfKcp3MjhAgv28tGK352
 Y4z1kqgRYxfIhomt+mnihU5uJYn+eI0MfzP26imNsHbEJUXRJiodVQ8ViOYvgZryRNOJJ8aFNu9
 RlfoMNvELIfgvVQqb1ZHdss4jFYxdKj+jSnercoSMcOV05afnHp3odGhrU5lpQJmKKHYT5x/ijy
 vi6Q0r8iMov7azV8PdOF6tp6/cYPQ35JRVZO0Me0GiVxbDbN2S4merYWPskrF3nA+oHIITk7hEo
 jbgpMCGJ/IVYszUlxqLPpqEd9AjSnUK0cUMq8O/QGKa/Rv46bOkVSz3NfnWgaNPnxNd8vAOibYp
 XBvuzbETJ/Eev9I3mnQrIgfJ5Hf23pjv2tb6xl1/FdUlwhVZt5bVZVU4v4sysulkEnBKgzp201p
 ItGTON0Flnyll0Ykgpw==
X-Proofpoint-ORIG-GUID: 2gEzx2rWUS-nmF2MLg-WeaaF443sUeMb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290175
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302828-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:christophe.leroy@csgroup.eu,m:netdev@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:drc@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[drc@linux.ibm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,ellerman.id.au,gmail.com,csgroup.eu];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[drc@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14E3C6DED1C

The IBM eHEA (Ethernet Host Ethernet Adapter) driver has been orphaned
since April 2024 with no active maintainer stepping forward. This series
removes the driver and associated references from the kernel tree.

The driver was marked as an Orphan on April 18, 2024:

commit 97ec32b583bb ("MAINTAINERS: eth: mark IBM eHEA as an Orphan")

In the 13 months since, no maintainer has stepped forward to take
ownership.

The hardware was last supported on IBM POWER7 systems, which reached
end-of-support in December 2020. The driver has received no functional
updates since October 2022:

commit 0e7ce23a917a ("net: ehea: fix possible memory leak in ehea_register_port()")

And has only received mechanical API migrations affecting the entire kernel
tree since that time.

David Christensen (2):
  ehea: remove the ehea driver
  powerpc: remove ehea driver references

 MAINTAINERS                                  |    5 -
 arch/powerpc/configs/ppc64_defconfig         |    1 -
 arch/powerpc/mm/mem.c                        |    6 -
 drivers/net/ethernet/ibm/Kconfig             |    9 -
 drivers/net/ethernet/ibm/Makefile            |    1 -
 drivers/net/ethernet/ibm/ehea/Makefile       |    7 -
 drivers/net/ethernet/ibm/ehea/ehea.h         |  477 ---
 drivers/net/ethernet/ibm/ehea/ehea_ethtool.c |  277 --
 drivers/net/ethernet/ibm/ehea/ehea_hw.h      |  253 --
 drivers/net/ethernet/ibm/ehea/ehea_main.c    | 3581 ------------------
 drivers/net/ethernet/ibm/ehea/ehea_phyp.c    |  612 ---
 drivers/net/ethernet/ibm/ehea/ehea_phyp.h    |  433 ---
 drivers/net/ethernet/ibm/ehea/ehea_qmr.c     |  999 -----
 drivers/net/ethernet/ibm/ehea/ehea_qmr.h     |  390 --
 14 files changed, 7051 deletions(-)
 delete mode 100644 drivers/net/ethernet/ibm/ehea/Makefile
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea.h
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_ethtool.c
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_hw.h
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_main.c
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_phyp.c
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_phyp.h
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_qmr.c
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_qmr.h

-- 
2.47.3


