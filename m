Return-Path: <netdev+bounces-289638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGuEJLbnDGoopwUAu9opvQ
	(envelope-from <netdev+bounces-289638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:44:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4041B585C53
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09AD73051133
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A393236F427;
	Tue, 19 May 2026 22:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oLs9PJrH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31605371042;
	Tue, 19 May 2026 22:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779230644; cv=none; b=VIEE1vlj0iC+Y1QU3MwR3HixeeBmnqFHz/K/XYyHI3PEkEaE82qQsYmDEnAwYm1Nj42dhcxNmMYc52T6ABRDEwfwy1a6fAlpoz4RNet+sUHPBwcPkAgM0nA+0aHMGoiuAWNrjCaGNImgpJRIHolFmgbHVYU3ucNCBKj4gLhgacU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779230644; c=relaxed/simple;
	bh=7kPo9VBfGIt2hP18MdLqhUHGd50Uysz8EPxa2Bp+q6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZ/npy1eXAiepq0CLPV70xdvqNrNXiadjvTE07hL5VS1ghyZFIhaKSO3MSKpXHRxd6DO/upnYugQWG18ZbLZVq2WTtdsfag7l8NjkXvqDhVlbNQ8buX1wqiQU8l6qmQ1Xp9bF+blVfIybHg6LeNY3Hnv4Vz6I5S1Mh7gDU/Lnqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oLs9PJrH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JCLbhl610903;
	Tue, 19 May 2026 22:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4Ckjf65EFcPIldW44
	SVtWhwPYV6gPOriHiesCHbBBho=; b=oLs9PJrHaIvrHFzc5sb3BjKQK+FqaNxEO
	axO8fCLhFDhMHy/bMVIi28gIS+Tx+1mGaoRrl+YBpab5oDVU1ZDVEXL2u6CD1kNp
	zYn2jvZ7ZAW/R1tSmXJGsgAMLxjfR1RXnc27+MzSK/62p2wnzJ1ZNgNcH4/f+bBr
	SzMzDKD5RvoH+1XolXVmtBIVIh/yll9X33B0F5KVD309ZYqwvqvd7IJklvY0sx/6
	A3bKK1gMmleRGwlO41Vtj1LiQhNLdjY/i/HYpjqbI9kk09uTfazUkJv+pOV9sr/8
	T/LRGIefosJZaxzG/Beqboh5R8ySacqLKLA+xySr9V5nGOeuhAXqA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8eja6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 22:43:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JMdHYa021162;
	Tue, 19 May 2026 22:43:45 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk4tur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 22:43:45 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JMhiWq30343868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 22:43:45 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9E1458055;
	Tue, 19 May 2026 22:43:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C164258059;
	Tue, 19 May 2026 22:43:43 +0000 (GMT)
Received: from ltcblue121-lp3.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 22:43:43 +0000 (GMT)
From: David Christensen <drc@linux.ibm.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, David Christensen <drc@linux.ibm.com>
Subject: [RFC PATCH net-next 2/2] powerpc: remove ehea driver references
Date: Tue, 19 May 2026 17:43:52 -0500
Message-ID: <20260519224353.1282038-3-drc@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519224353.1282038-1-drc@linux.ibm.com>
References: <20260519224353.1282038-1-drc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDIyNyBTYWx0ZWRfX1Pyl8qjCtNrh
 HME/VsLOTH0Mz1Xxe/yruhvdRc8vZDkYtHqNKhel5KnssyBO48QoD5bVXlOZZuSxlEszBnlHHyC
 OM94vWbW4d9SXZj7vygvWW1uoR+xoAAgoR0SkfNUuynchcDd9DEsoXy7LHFk0Gp1xru3DDQHYso
 XroFmbpNuY+69o965UQMt5h2siMepuF3DfP8AomK4aXNyv5AXdxw4BC0g8u65IVSusT6gTVOrBe
 7+kmkoa8stOg6fhSekAqdiJyMpvawSxtOyKDSGEfR7hTtAGDWPEewxk1rHbTCzUrtKrSxexSEGp
 eM0S1+q0S4V4DTcj3m01xn8f9fC8c+l85CDCokk04iwFrQ8zvOW6Z0j62svfFkFw/s5up41+bGb
 OjIUv+GUPinBbhlpnOOEJTKqXcmDqRBckQ+DZ8BdI1NkHQ6WUEMbVPeRcAlMVQBv3ur1dB2rOMq
 DgINdQ+L7OIUdo0wFOg==
X-Proofpoint-GUID: K8pxDYP2wMKB5seWxbgLGraxmXlvKrYL
X-Proofpoint-ORIG-GUID: tZekUGBsXhsgomI0g2COYYzNwB2P0R70
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0ce7a2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=ShowhVjdL_h4nbc8-K8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190227
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289638-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,ellerman.id.au,gmail.com,csgroup.eu];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[drc@linux.ibm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 4041B585C53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Follow-on cleanup after the removal of the IBM eHEA driver in commit
XXXXXXXXXXXX ("net: ethernet: ibm: remove the ehea driver").

Remove the CONFIG_IBM_EHEA entry from ppc64_defconfig and the obsolete
comment in arch/powerpc/mm/mem.c that referenced the driver.

Signed-off-by: David Christensen <drc@linux.ibm.com>
---
 arch/powerpc/configs/ppc64_defconfig | 1 -
 arch/powerpc/mm/mem.c                | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 6316ca4df25d..b022d00708f4 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -210,7 +210,6 @@ CONFIG_BNX2X=m
 CONFIG_CHELSIO_T1=m
 CONFIG_BE2NET=m
 CONFIG_IBMVETH=m
-CONFIG_EHEA=m
 CONFIG_IBMVNIC=m
 CONFIG_E100=y
 CONFIG_E1000=y
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 648d0c5602ec..1f5ad1a59d68 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -370,10 +370,6 @@ int devmem_is_allowed(unsigned long pfn)
 }
 #endif /* CONFIG_STRICT_DEVMEM */
 
-/*
- * This is defined in kernel/resource.c but only powerpc needs to export it, for
- * the EHEA driver. Drop this when drivers/net/ethernet/ibm/ehea is removed.
- */
 EXPORT_SYMBOL_GPL(walk_system_ram_range);
 
 #ifdef CONFIG_EXECMEM
-- 
2.47.3


