Return-Path: <netdev+bounces-282846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBuXFzhQ82lnzQEAu9opvQ
	(envelope-from <netdev+bounces-282846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:51:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A710F4A2E88
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EA85301D6AB
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646FD3FA5F7;
	Thu, 30 Apr 2026 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="vKGKuB4J"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A17347520;
	Thu, 30 Apr 2026 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553418; cv=fail; b=hWKU3bl2OX961eHMZWyDJfAx+667G0byoDMULR/2UHNwxI+iE0I+mn1dK0hKP99yhNGDRiG+2k0EuRsj6vQuR12Zt38XONAQ7wFmIl1gd5XP7R2Mr4ZM6rj7NfY+G+o2NfgA+kiWTLIQL6b1rh3r8Afi12Jh94z+EsBfFiTbiUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553418; c=relaxed/simple;
	bh=PPas/MDgIReXSfKxOETln0vteT9qVTKIlgj7+796qOI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mHsjC0D/BhGG/6Il9Jw5qrHH4UEP5mC6qY3pRZ3ZHZyHjdn+WIX+7MX3XuXFQ6pKON+q93wZEHXNX2JxphXZnmUOkF31WngX5Iq8i3nqACyeR+Pkoq4qDJf7viHMoP1spskGFjJEbXiFtQQS6C0C9cTFVUrtZvzc0AvuCFwrAU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=vKGKuB4J; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ki68C4p3gg+Q6KCQxSdVwUc96f825mPb1xWMzMQmIZ7ShoG0rY0xUwwty4F5vU8UzlLX1upKSVdWVbds2O1oVuVFPKZ/E6asWeI+wmEn3wR3FoQgf7uXHd5dSWp1j6GVy1ZZPuntKcm7EeRwaOGGW3NMMQr3xR84F6WKIFhocnpUyfLrXL3LWnNqAtSTtQiMamSW3QFIDLBBMzhKxh9XeEdFd6jggsUHm8NP4aEjWPgyrDuIPIDnecQ57Ccumdy+zpws0vjOL4rx0uvdvu9Jqa/7e0ZELw3UWifwHJVIkFsdx4UUIonKXS6johlrqbKc42H4S1eLqXPrKTGQ6snPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPSlMh7QFnxSR8Pn3UXNY7QK+1FYlvtmL65dBQrN3HA=;
 b=UschPT6cvBk+omOgmsZk1rzyQM1c4AJXIK+AHnwEfa13IVrD328/PHINfiDCRBGeV5xR4on5TXvx0pjPicQ4ibDES3UytHPl3LGrozxvZjZIK6sxmzShFY8US0pNvfwRsQQw0xEjq0mp8tht9bVQeZ/7lHTOPTnZL1BjARSZDQTwcNsy6MjKh9LwvmjhBECgJ669swrL3Q4e/2Mq3WPQ4XR3vXcnPuV/A0ZBDQoFp0ZXqnn4yVnk6Ua0K2Bd3kbztfgym56Zo+ajXm+AHLa7nF1bb1pLX6gbH0akhySRMuj9GpCD5YqF8mAPJ4LoHgkdkvW/A/f3z+TAIpC3SGhmpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPSlMh7QFnxSR8Pn3UXNY7QK+1FYlvtmL65dBQrN3HA=;
 b=vKGKuB4J5xQJeGaIlnM1c0Yfa/gxI8jqKTIpnOV8QtEny2vnj+EdPjvHrARR1WkVzdg+P2vVFuHtin7+hPrJx1i1oGYC0lS1qROpSLzR/VOKHbV1RJZbB9bwcxVfNXDFaxCmDVCTUZ+OUWVathUsUhF34a0o+JN/hrVBCZjIC70wuIf9xZHT+RmHGhAkNTWVDSdkcJhEdYalk5RW2+QlOYcXwH97sTgf+1/rIFlnXpSMJHJoKS38i392TM9gT7t52zAEvu2GSg3JQm140Ha9DRs+t10q2HK7pUqEOWmD9UuGYye5GLlFck4vox8V1whoK132znt8lezXCPWf442gEw==
Received: from DUZPR01CA0186.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::15) by GV2PR07MB12148.eurprd07.prod.outlook.com
 (2603:10a6:150:30b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 30 Apr
 2026 12:50:11 +0000
Received: from DU6PEPF0000B61C.eurprd02.prod.outlook.com
 (2603:10a6:10:4b3:cafe::c4) by DUZPR01CA0186.outlook.office365.com
 (2603:10a6:10:4b3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 12:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU6PEPF0000B61C.mail.protection.outlook.com (10.167.8.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 12:50:10 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 30 Apr 2026 14:50:10 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 3A8554020AAE;
	Thu, 30 Apr 2026 14:50:09 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id 236711005C88; Thu, 30 Apr 2026 14:50:09 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <thomas.eckerman.ext@ericsson.com>, "Fidan
 Aliyeva" <fidan.aliyeva.ext@ericsson.com>
Subject: [PATCH net-next v2 0/2] mv88e6xxx: SERDES on mv88e6321 letter
Date: Thu, 30 Apr 2026 14:49:05 +0200
Message-ID: <20260430124907.3533344-1-fidan.aliyeva.ext@ericsson.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61C:EE_|GV2PR07MB12148:EE_
X-MS-Office365-Filtering-Correlation-Id: e19f2706-25dd-4ef2-906e-08dea6b703cd
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	caPu8Yf/8AvbSVImy7mYxs9kL5XMcvYYnea6eLLgRieNRcLB1of7Xo4R7e5k/9TOsM3qfgut2BEDQgVnJn5S7OKPWQSu3eQJP3ZtiaEQECwrP36pw1WtQs4QnKNu54RkTNJtLpDzJXuafluQ1eVVAZO3D3TeWo4jaqSNxFC/PWAeTYLqKZAmbZxM2GRGiVAhkE/fEPfajQAw40ni9wSbhVvu8nrhNMlMEf4S5uuXimA4hovxMmUhEUousw6mI4GccymijHQkOVU3v6DhE+My8XPe8bBTz3qz7GJRhN7Xe076qX9eXdwdpEH9w2l9/D3tLvLOJIZh+DpnHB4G/bHQ5h4BCEJcD/Ok0rvRMyyOAgG9Kd3wPGBVBIFlFA7EJIDak4BErwLoLJnlyPjWHFpXuky639SApOdf1Sm86feZphzc7ck8QyQxquHVWmi0638voZoUeTi9juiQgQf0s0K9LvKrljOk5KN+DdU8UhVAjirMRSXJGKUzlB2E3sIab1RPL8Knu/SiWMe6tTf33Af8sFRZ3OCnottWiq5U0uyHEY0ZblnJrhAHCG5uIzSRAczhelYXq9F2BtLyrTi+G+c2yIxGg7JrFFSajPbdgeKk1aPLuIK3D26WnQ7U/BLLBcDZgrjB9y48yuMmqJxniM+YqqRGg79zRARMuFbUBTPSDqpb8UXCk+KXiQHd07OK07CNkGyTrGVqMQisrc65SObWOjjMjCypVuvIiY+2TDt0bqko/oRTV0lKdHxvrcd29OD/Brgg3N36bqHTMfq7g0XTXQ==
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qaYnOJTHYIwFaZaNw/0bPj+izkzAGLYHdEBa3UxKy625OeZgMPAdqe+PYT4XGos0rTvdgbW6mBerAqEBcGDG7INKtG4+JP7k7BUsldLM8Xde9lXU2xlFpEK8iTzN+GuxkxypRGUmi/uAosH7+pYSclLz2OF8kjPAFlXX3uEgGvCw+00ZefcTI5IeM6PYCrYtJMf4YEc2/Pv6uO4ipJrky7vrhUKWsomGAOBhGwF1KN4glCYxZss7Jyo9eEVoMRFkK68n2n+4VpMf/26oNi55+gsUmJNt6KXnyIprDnMkfLuhNBWeiTSajVv+svbO7w8aflzeXh2vuOuj0kpZIluvf4oHrLc1HXY45oeC86emoTpYhmyWaMI4cEeYrF0kW4BOUiE7eabuhVyYoEgJ7zxWt8oargHVG8UyWBG98OUWKDlNdFFh6TO3BC+hdFil9qKf
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:50:10.5407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e19f2706-25dd-4ef2-906e-08dea6b703cd
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB12148
X-Rspamd-Queue-Id: A710F4A2E88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282846-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ericsson.com:dkim,ericsson.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fidan.aliyeva.ext@ericsson.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ericsson.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]

This patch series add code support to be able to use SERDES feature of
mv88e6321 version of Marvel mv88e6xxx series. mv88e6321 has 2 ports to
support high speed SERDES but the support is lacking in the driver.

mv88e6321 version has a similar architecture to mv88e6352 version making it
possible to reuse its pcs functions. That's why the patch series consist of
2 parts:
1. Refactor the serdes functions and pcs_init of mv88e6352 to be more
generic
2. Add the SERDES support for mv88e6321 reusing 6352's pcs functions

The final code has been built on top of net-next tree and tested on
mv88e6321 ethernet device directly by ip ping tests, performance tests and
also verifying the switch's expected register values.

Referred document: 88E6321/88E6320 Functional Specification

Code has been built with allmodconfig and allyesconfig. checkpatch.pl was
also run

---
Changes in v2:
  - Removed 6321-specific pcs_init and made 6352's pcs_init more generic
  as suggested by Andrew Lunn
  - Added the correct mailing list

---
Fidan Aliyeva (2):
  mv88e6xxx: Refactor 6352's serdes functions
  mv88e6xxx: Add SERDES Support for mv88e6321

 drivers/net/dsa/mv88e6xxx/chip.c     |  8 +++
 drivers/net/dsa/mv88e6xxx/pcs-6352.c | 12 ++--
 drivers/net/dsa/mv88e6xxx/serdes.c   | 87 ++++++++++++++++++++++------
 drivers/net/dsa/mv88e6xxx/serdes.h   |  5 ++
 4 files changed, 86 insertions(+), 26 deletions(-)

--
2.36.0


