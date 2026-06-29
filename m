Return-Path: <netdev+bounces-302829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YEkXIj7gQmocGQoAu9opvQ
	(envelope-from <netdev+bounces-302829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 23:14:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 775786DED2D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 23:14:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=pJdKKGE4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302829-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302829-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 141AC300B2A4
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015FF3C108E;
	Mon, 29 Jun 2026 21:14:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DCD3B4EA9;
	Mon, 29 Jun 2026 21:14:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767652; cv=none; b=eSdWJgZfgYrp6VYMmqzQfPK9jP/TwiZy6COzPfiMsqpbc6bgklqOMuQF0bYK/BIyAZmuvKTe3ppFpw4k/s+lipqRj8gtGpXBVYRgy1pANz4n6nUW2+7RIH08f+98rWhuyRiyF4b6eYNnX4RyY3tM0sDouq18aYUZUeogQKjfrAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767652; c=relaxed/simple;
	bh=3syxCbfoofhx0Ttb+9g/7ww5KN/biT0MHDMuJceeWXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+UOL+nE6RxXJGyLIUAKc7iQLACxbW48SdoedJwZZv9uJ85yMVkwax5tw8/qOC9qZTLn5iXRj8Mv8rv+Ugr3v4F1Lr9nNBcXKvnt9o6Q9resUotFx0gf9FUOjoc2AkS1GEPm2RIYztm7ldCQJM9N0ZDitU5HO9EwpWJg/t/QkIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pJdKKGE4; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TKmWge4155723;
	Mon, 29 Jun 2026 21:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=m7/+6o0Lw4YS48ICx
	YL3/EbwwcDouagQTM3RctQLk6c=; b=pJdKKGE4v1xHAsfMcI8b2IaQPTMtL00ue
	I0MB1GlNXTYmpsXRHm42cdxDDwMrqVKfJjK0kcvJ3uk6kuMcp0ddTjjvddvzZaXG
	fbWbV8K/DgB6wh3fEPp3AqVZ81rxBc9DsbG7tMmga18WdnTAl30Lv7ONx3dW3Xcd
	C/hy9YeaQnfB/korVhAi2GJ390A9JoWaAdtRoQ8ttcd7luV082N2FBxS3bEbZLA8
	xzzLI29u8PxpLHUbYgWS6Bne0l4Sl0w8QbE1xOFjfj2HAJSICkN773Uz1W7kfA/2
	flvJNzbK5uE4M1c8xb2FNrPriOSL/2Xvja0jISwhK0vqhMKpaOgmg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjk8yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 21:13:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TL4g9f014311;
	Mon, 29 Jun 2026 21:13:48 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sujy9gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 21:13:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65TLDlsc32899624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 21:13:48 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C749358043;
	Mon, 29 Jun 2026 21:13:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47F0258059;
	Mon, 29 Jun 2026 21:13:47 +0000 (GMT)
Received: from ltcblue121-lp3.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2026 21:13:47 +0000 (GMT)
From: David Christensen <drc@linux.ibm.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, David Christensen <drc@linux.ibm.com>
Subject: [PATCH net-next 2/2] powerpc: remove ehea driver references
Date: Mon, 29 Jun 2026 16:13:43 -0500
Message-ID: <20260629211343.3712775-3-drc@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629211343.3712775-1-drc@linux.ibm.com>
References: <20260629211343.3712775-1-drc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE3NSBTYWx0ZWRfXxRSEc5fzo5B4
 LolXpB8bAemjDCSywJsAzV8hsVeQjK2TDjEMPHniOoxhzhQSR8T3pki7f5A3XxaxglFiPOoYd6i
 asP3OHzEvohLfYcGl8yCCc9cnUJ7iaqX4VWSPlHhR5pnkmBRXcgJSTPYnDD6ARmdReVyaTTv/mn
 r14JLr1SDsjGBIS4/0zRRR4X2ETyKZzMvTgaW/YeVlKBXiFZr0K7bFa3Ib1SLVhNY1C05/ld2xk
 Yy68tVEQsSlIH7LA03yDJtEXUJ+nlWabWjhu6v7QYasS/G0N6b2cQH2nOFR3OTdOjZ1N1SkDOjI
 +RpgW0elsiTcOGwet6laJgE8Hd1BNUNShPgTHsBfH2cxeuoSUUgrCVJuRffEPSjpm0BA/YlntN1
 1GGFD5SGjJNVmHb+c0PUeWBKJ7i3sY1VvRuAnL8ENmYjoYnivIOGx1UpQR0XMVaLnoykVM0PV/a
 DTgZze8CMC80Oe3KVXQ==
X-Proofpoint-GUID: GK2H9_yx1scvRiPIlIQ2GDLQ6ZrtGVVu
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a42e00d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ShowhVjdL_h4nbc8-K8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE3NSBTYWx0ZWRfX7GHBPVc3nP6J
 jBQtFk7smZJWy2yhZvKZdrlXPgIk6Gb42ot2T9SSeXLMQdN8svGeNU9ErUwAXXU4+HZML3GCk5o
 GhyTReOrCmY9cMkO58l7C+VcYRB+Dck=
X-Proofpoint-ORIG-GUID: oqNrgQa8KXyKxir_wWIYufkFzewIuSNX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290175
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302829-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:christophe.leroy@csgroup.eu,m:netdev@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:drc@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[drc@linux.ibm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,ellerman.id.au,gmail.com,csgroup.eu];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[drc@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 775786DED2D

Follow-on cleanup after the removal of the IBM eHEA driver in commit
f721e8ffa92a ("ehea: remove the ehea driver").

Remove the CONFIG_IBM_EHEA entry from ppc64_defconfig and the
EXPORT_SYMBOL_GPL(walk_system_ram_range) export from arch/powerpc/mm/mem.c
that was only needed by the ehea driver.

Signed-off-by: David Christensen <drc@linux.ibm.com>
---
 arch/powerpc/configs/ppc64_defconfig | 1 -
 arch/powerpc/mm/mem.c                | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index f795b74602ec..1eb8e3457e8b 100644
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
index 4c1afab91996..b617b69452cd 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -371,12 +371,6 @@ int devmem_is_allowed(unsigned long pfn)
 }
 #endif /* CONFIG_STRICT_DEVMEM */
 
-/*
- * This is defined in kernel/resource.c but only powerpc needs to export it, for
- * the EHEA driver. Drop this when drivers/net/ethernet/ibm/ehea is removed.
- */
-EXPORT_SYMBOL_GPL(walk_system_ram_range);
-
 #ifdef CONFIG_EXECMEM
 static struct execmem_info execmem_info __ro_after_init;
 
-- 
2.47.3


