Return-Path: <netdev+bounces-287129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANm6FuslA2p21AEAu9opvQ
	(envelope-from <netdev+bounces-287129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:06:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE95520B65
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85F25305E024
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1E43998BF;
	Tue, 12 May 2026 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QQXkHtA7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A2306768;
	Tue, 12 May 2026 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590675; cv=none; b=NQg4Koo+6LaX5tKd1hTekLZjXBgRj3sFnYTV3FyA6Jf051jIneNzr+DfVtM3CZi+uJaF1rJBzTZ68wwyTuK80u03X7DjRZTZc63QH9vU241Ap+LqLg0LfWYEsCJPKh5lDDTfkefWMLK8qCPI6H0Z7I7HEsvu6xTFSXtAnkB4Uug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590675; c=relaxed/simple;
	bh=Xz/AM4OC/PQFWU170RodBRJ49VM35K8Na6MIZhW5beA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B5eN0GZ8SDCw/b1i+0XNTCHT6yGnG1K6iUxTsqVw29YYcCY/7z88PsyIw4gcXqxcAid6FU3Y0OGSizhtjdREJYOEP/9zZdhYxcAplyqLpFANv22KRmqx1Y7JBd19c0A/86rOo4ZwfHJF+7XAnTJGkqvobs0V9V1JomQ+WFaNpGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QQXkHtA7; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C7fBmj034742;
	Tue, 12 May 2026 05:57:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=2SCE7k+HV3B1V1Q5wogLPyM
	ufvv4f5lPi43EQNO83rc=; b=QQXkHtA7tgrA+WyUNpYSoVlBgavlv5lNjRO6kYT
	0fM/rFMb1VRjYn5F4K6ckqDY9biD1nR9UIvctifExOPUKI/Sbu/k7XCu/K+5Io6G
	uPfBO/fLTDNtuaX+3egvbfGwCPZOMrl3SUjMP6AGKf0XN5QkFKZK3J/hiFDmGze2
	WvESELUWf9r7PcPfRLPNNZfQlXEgrRImrMshfKSnXCdL6E+hM217x+hKGmUIwsCs
	aGlkfhZMelK7b0LSEKhduzjzxAZ9foBRc3Qppok/SmhqJy3jJ5KECJ6UAc5Sx/yT
	+naJjLamkSTydXHNUtG+A5x07tz67Wbdbd4nz9U91X3SzOg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e3nusadx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 05:57:38 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 12 May 2026 05:57:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 12 May 2026 05:57:36 -0700
Received: from BG-LT92649.marvell.com (BG-LT92649.marvell.com [10.28.166.218])
	by maili.marvell.com (Postfix) with ESMTP id 8E0EB3F703F;
	Tue, 12 May 2026 05:57:33 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kuba@kernel.org>, <davem@davemloft.net>,
        <epomozov@marvell.com>, <irusskikh@marvell.com>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net] MAINTAINERS: update atlantic driver maintainer
Date: Tue, 12 May 2026 18:27:11 +0530
Message-ID: <20260512125711.3142-1-sukhdeeps@marvell.com>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: RY4H1wNgweHAQiYCZBIbp-hv0v9e2VBY
X-Authority-Analysis: v=2.4 cv=fbCdDUQF c=1 sm=1 tr=0 ts=6a0323c2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=kZbXAlMlAAAA:8 a=VwQbUJbxAAAA:8
 a=69LWc1rl86c1DZQ69rIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=1K0MQvXYBBII1NMywDO_:22
X-Proofpoint-ORIG-GUID: RY4H1wNgweHAQiYCZBIbp-hv0v9e2VBY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEzNCBTYWx0ZWRfX6znkcT8qmwew
 5RcrWe4yp8QQI+vTXczBClCEL7ZsY2hePUWea3IA27fqRiOlOXVjp6DX59pOouTTYCUROtn++rB
 xvshPYKjwJA/Od15YAdR6AhmDUB+uFfvMY6hQ4yczTGJAk1h7gFy91bRb1cDft7A46mCbTBR2Qx
 ETWkLH58jlPe9xfmZm/BR/WPGC9JHZ87r0TmC2hZ8Lcuw7N6up6OYAer0w89diEkpv1aOSIvjNs
 zwBuqNGbEk2EH5YLg+DALQEP1/vm7iMJOt0Kngz1TO5KKWm1q6pkOOq5lPY/BhTq3L798FbFOU+
 zDGcO0lVSPSVXbZKyUyKCedJdLZR0jwf3I66533CR5rZv6rgdWH2jo2GjzEScW4DJTFE/+HUiQM
 1ipmJzPvyZPmkBJhv7HhRtJIjMUgadK4RrADowartDqJOZF6MzDsv5c6BfwYRXfiXJydLsYPFTK
 ArzYkLox4ctCxEQ0aEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Rspamd-Queue-Id: 5CE95520B65
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	TAGGED_FROM(0.00)[bounces-287129-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

From: Sukhdeep Singh <sukhdeeps@marvell.com>

Igor Russkikh and Egor Pomozov have left Marvell.
Take over maintenance of the atlantic driver and its PTP subsystem.

Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..ce9e1ef8d51d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2015,7 +2015,7 @@ F:	Documentation/hwmon/aquacomputer_d5next.rst
 F:	drivers/hwmon/aquacomputer_d5next.c
 
 AQUANTIA ETHERNET DRIVER (atlantic)
-M:	Igor Russkikh <irusskikh@marvell.com>
+M:	Sukhdeep Singh <sukhdeeps@marvell.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 W:	https://www.marvell.com/
@@ -2024,7 +2024,7 @@ F:	Documentation/networking/device_drivers/ethernet/aquantia/atlantic.rst
 F:	drivers/net/ethernet/aquantia/atlantic/
 
 AQUANTIA ETHERNET DRIVER PTP SUBSYSTEM
-M:	Egor Pomozov <epomozov@marvell.com>
+M:	Sukhdeep Singh <sukhdeeps@marvell.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 W:	http://www.aquantia.com
-- 
2.43.0


