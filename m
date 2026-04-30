Return-Path: <netdev+bounces-282847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJyOCUZQ82lnzQEAu9opvQ
	(envelope-from <netdev+bounces-282847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:51:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 251E44A2E8F
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4D2030055F7
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F195840759C;
	Thu, 30 Apr 2026 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="ATOZKQqq"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013025.outbound.protection.outlook.com [40.107.162.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C143396579;
	Thu, 30 Apr 2026 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553433; cv=fail; b=q6uUxXiCZsLx3QYB8GsuOjkcCckkM5BwxVypD18aTb6FJGV1CQDZH4pOcjM1H6ENFD5J/ItKUaTg3yjGOueAC2xqmaOczj+1Mq7LJYbYtwIpjS2h1Ni2qFdtUZWnpG6idmMB3Gn0ZVw4OFjvdY1NuKnbFOlBjAZhjFsHILjkIUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553433; c=relaxed/simple;
	bh=8spFHAyQ6ZGQpVuTJpijqF8H/EAo/ZZpgzUWzVQAZE0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zu3HvDd0YvUjGVw0EjA9o002n868GasUdiduNIRvKC2QP1uuiJfB1n/fcJzUu/nbKQAkkd2KfVNAB7vjqJlMjZKD9mjjBqTGEqc+bb1mKbYpEDbb1YPz42e/6bql45nA+NAqDgS1A1Vx9/jPGE/TxFedjYlPCFD8f/JZ27Q/EwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=ATOZKQqq; arc=fail smtp.client-ip=40.107.162.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AatFrEtQo6Sh6tnyQHp/7NVhvTu1PCj6xb/NwUHWYcpfVai2HXOGvKLm2khNf6mrhGbaKvM6KSspHrandWdCzsJ7tmOMBrtSxIrmuQmoXtQOpCdXMYdaV+GE8J+KwKVQp2rtUdJA3Y1LSjQf0m2fcDac5oRZeh0KItVQA5JZxIR1/UJ7XSCENXg2eMq4zY8srMl5AF0syVOJApnOuw76KpgTxiT4xJCDD7dLS2xrNl3HCa7lPy/wvz3wIHVB++RBuByJtgAmUna03VMR1VlWj4jtIv1Qs4CFJIzHiB9yj1alkN/hU09l6r3coO4liibV60yh+nZjLg66KZP+wA6Zfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DY91eDW9K6Eu/ZUqc8d7DwBhEYSjjpUafAlSslHd+zY=;
 b=ObJVwxXaLkwhbBazTVEePO+UagOMIXwxfKjpWjs1vv3c05ouat1UnjsiMjMk+1+0rFM3aG2E8ujy2e2V+57EWGwyWwkMmtxuptbNhwzfDh7cg5YagfPN3QJzS9gL0iZQ0lE8+tQbDaOBHwTsOlgExxNHBgEuA3BKkerSW18O/yZO2QlEZ54+YBfTrJu7v/T6X6ca3C32S1pLrHZWZ1WSmEvnDp8z4wv2R+fi9X/7ZB0PCkHwJjV9UH0Yfu3JSpOybPjESFc3MD8WPxg6vLmw49K2cUxB9Yp1MJexoW+6ssMLTAsAsO8UmVjExyQpMYX7mPDpEIS1WGx8la9RB4cS5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DY91eDW9K6Eu/ZUqc8d7DwBhEYSjjpUafAlSslHd+zY=;
 b=ATOZKQqqbDlhIEvWjPPTmAsT+C1Hi2cx6e2eTe2KdoXr/FXk9uWfd/kwtxU2YgCuGIXx8YQDtmwrvRe72p/AR6fl/cm2zK27XE/m6C19VzC8AGLh3LdN6eZ+SbjzMirW05SDW8szzJLhjGqNNVGec2kOiA82JSe3Vwa50ATVRaMv+zlHKe8qIY5tCEnUcEMZvjJ2t4WFC8rTrJvkjpfne9kDr0VCo9TVFOhSqQhurhuYbaouARvXrRoJM/NbrRGPmB2Y73twfCt53R05cSaOVYOq0d5o/tZQlkoo5nhkyt56fXQnWcM5SuqQNi7hQHc1PlwRb1tnF4+hnV883UJTNg==
Received: from DUZPR01CA0180.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::14) by FRWPR07MB10659.eurprd07.prod.outlook.com
 (2603:10a6:d10:16f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Thu, 30 Apr
 2026 12:50:24 +0000
Received: from DU6PEPF0000B61C.eurprd02.prod.outlook.com
 (2603:10a6:10:4b3:cafe::93) by DUZPR01CA0180.outlook.office365.com
 (2603:10a6:10:4b3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 12:50:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU6PEPF0000B61C.mail.protection.outlook.com (10.167.8.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 12:50:22 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 30 Apr 2026 14:50:20 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 9E9094020AA4;
	Thu, 30 Apr 2026 14:50:19 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id 8A2CC1005C88; Thu, 30 Apr 2026 14:50:19 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <thomas.eckerman.ext@ericsson.com>, "Fidan
 Aliyeva" <fidan.aliyeva.ext@ericsson.com>
Subject: [PATCH net-next v2 1/2] mv88e6xxx: Refactor 6352's serdes functions
Date: Thu, 30 Apr 2026 14:49:06 +0200
Message-ID: <20260430124907.3533344-2-fidan.aliyeva.ext@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20260430124907.3533344-1-fidan.aliyeva.ext@ericsson.com>
References: <20260430124907.3533344-1-fidan.aliyeva.ext@ericsson.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61C:EE_|FRWPR07MB10659:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c859bcd-74b5-44ca-8898-08dea6b70b2c
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	wOD89QhMp0oqBVscabADZNIp4olFfJ8xUdaDbdM5haHqCAeUAlMRLCSrZ9FolgjHGOW49qKgfghV6fxDVh6+3MEy+JpEZcoVNywDKHd27IrecqiKQx3MnOqBG0yCnU8l8K+EWTGabNFhllJHBn/Jp10UUupvGW89tlEAGqwy7zzasxMC73d4J7/gLigbMzlpiGAsoGd4diAcUhPHfBGhut0Hq6yBLAJekNLrx3A1Dwy+WibG9dEEWdyNBYQYcBwf5V+mYxDV/Yi5etf76J+tMsWW3rFEWbXUspX+Qru7KqFT692CyIhAvhhL5vSVAbfvOucVRJNaNxUHvAC5kywLed/Zl6F/eTBZBUTc9YHUGDJBACjZU5JLL9iqJMZjsaOS32oNsYki8JN5QCm8pCEEInEfFQ4we3k5s1DrZgDruCKh2jfdI6z1njND+oLdiTvn35byyJ+WFan0huSaBAmzn4s5VKPaXZquWTGj8SjQXGHF7gbGTBvs7e/mC9aHJDUjZ9IgEZlt9GBnLVPBNw+IaTZW0ozy5RXw0WDVN4i/7ujOijeDMz9oj11M1bdAq823JJR2RI/XV3SUp+GAErBI/MZGg29zvTT+mzaAIenA57NVKEwGYYjltMaLF841vvdltvqxfRDBgJ56EJ4bXgOATWZKVsW7FSmc7shwrOE/zq33rKXsGWxD6KH6OP0r2icNDiMCZ4O1I1eHT4D06wC/hiWWaeF5Re3EYM2vOV89kNsxTj5nfsCWvyJCQaHzFkGzoG7x+LJALUqVG4cyzwKuCw==
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XUl+Awcry4gsUojrsEzYY/ktR6OglBwMr36M78kNWDspPhieq5EmEvkvh5zyL3/XOVObKbnolD4npkpVuktfml5+OEgchlhPYETcIlFnjo0M2jn9RtO/P0urWQxG74IkNmj+xpRCGolltznj5BsKJa3Yy0ra3kz6bOHB9rnKU+Jwe+6qrrtex+oVOSi3VuInMEBbbEfxhYVBc+Vu3dZKqKioAPqLtmv4DAurHrC8xvasntv4fyPJweJsmhyCT/gfn/HIjEfXbyBFoiRMQXOapPBzQWMShEe8qvquj3ctbnGw9BGWRkNTw8VSz2/iXiwUhCY64kTqj4zeK56sVVLihO3OiqL7jv3FitfyERtaeZgqXfZKXiBho8OjwHA4B9918hUwYIKlbNdP9LkBLLMSftPvw+bLwn1AbStygjRYNZDeu2qiRZir4gJbWZIvBoQy
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:50:22.9085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c859bcd-74b5-44ca-8898-08dea6b70b2c
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR07MB10659
X-Rspamd-Queue-Id: 251E44A2E8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282847-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ericsson.com:email,ericsson.com:dkim,ericsson.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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

This is a preparation patch for adding SERDES support for mv88e6321
version of the ethernet switch. The patch aims to make
mv88e6352_pcs_init, as well as some of serdes functions, more generic
so they can be reused for mv88e6321.

Changes:
1. Add mv88e6352_serdes_get_lane function which checks if the port
supports SERDES by reading G2 global scratch register. Then returns
the address of the SERDES lane.
2. Add this function as .serdes_get_lane member to all the chip
versions which use mv88e6352_pcs_init.
3. Replace serdes check by global register in mv88e6352_pcs_init
function by mv88e6xxx_serdes_get_lane function making it more generic.
4. Replace serdes check in mv88e6352_serdes_get_regs_len by
mv88e6xxx_serdes_get_lane. This function is the only other function which
checks the scratch register with lock; thus, can call
mv88e6xxx_serdes_get_lane instead.
5. Add mv88e6352_serdes_get_regs_from_lane helper function and refactor
mv88e6352_serdes_get_regs to call this function with MV88E6352_ADDR_SERDES.
The helper function will later be reused for 6321.
mv88e6352_serdes_get_regs itself is not reused because
mv886exxx_serdes_get_lane cannot be called inside 6352's serdes_get_regs.
The reason is 6352's serdes_get_lane requires register lock which has
already been locked by the serdes_get_regs's caller function.
6. Add lane argument to mv88e6352_serdes_read so it can be reused later for
6321.

Co-developed-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c     |  4 ++
 drivers/net/dsa/mv88e6xxx/pcs-6352.c | 12 +++---
 drivers/net/dsa/mv88e6xxx/serdes.c   | 58 +++++++++++++++++++---------
 drivers/net/dsa/mv88e6xxx/serdes.h   |  1 +
 4 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 8ca5fd40df92..15a8028a02a8 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4662,6 +4662,7 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
+	.serdes_get_lane = mv88e6352_serdes_get_lane,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
 	.gpio_ops = &mv88e6352_gpio_ops,
@@ -4765,6 +4766,7 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
+	.serdes_get_lane = mv88e6352_serdes_get_lane,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
@@ -5040,6 +5042,7 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
+	.serdes_get_lane = mv88e6352_serdes_get_lane,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
@@ -5475,6 +5478,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
+	.serdes_get_lane = mv88e6352_serdes_get_lane,
 	.serdes_get_sset_count = mv88e6352_serdes_get_sset_count,
 	.serdes_get_strings = mv88e6352_serdes_get_strings,
 	.serdes_get_stats = mv88e6352_serdes_get_stats,
diff --git a/drivers/net/dsa/mv88e6xxx/pcs-6352.c b/drivers/net/dsa/mv88e6xxx/pcs-6352.c
index 9ebf0f89f817..4228ae5bb9db 100644
--- a/drivers/net/dsa/mv88e6xxx/pcs-6352.c
+++ b/drivers/net/dsa/mv88e6xxx/pcs-6352.c
@@ -324,19 +324,17 @@ static int mv88e6352_pcs_init(struct mv88e6xxx_chip *chip, int port)
 	struct mii_bus *bus;
 	struct device *dev;
 	unsigned int irq;
-	int err;
+	int lane, err;

-	mv88e6xxx_reg_lock(chip);
-	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
-	mv88e6xxx_reg_unlock(chip);
-	if (err <= 0)
-		return err;
+	lane = mv88e6xxx_serdes_get_lane(chip, port);
+	if (lane < 0)
+		return 0;

 	irq = mv88e6xxx_serdes_irq_mapping(chip, port);
 	bus = mv88e6xxx_default_mdio_bus(chip);
 	dev = chip->dev;

-	mpcs = marvell_c22_pcs_alloc(dev, bus, MV88E6352_ADDR_SERDES);
+	mpcs = marvell_c22_pcs_alloc(dev, bus, lane);
 	if (!mpcs)
 		return -ENOMEM;

diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index a936ee80ce00..273c3b169f65 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -17,10 +17,10 @@
 #include "port.h"
 #include "serdes.h"

-static int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int reg,
-				 u16 *val)
+static int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int lane,
+				 int reg, u16 *val)
 {
-	return mv88e6xxx_phy_page_read(chip, MV88E6352_ADDR_SERDES,
+	return mv88e6xxx_phy_page_read(chip, lane,
 				       MV88E6352_SERDES_PAGE_FIBER,
 				       reg, val);
 }
@@ -102,6 +102,21 @@ int mv88e6xxx_pcs_decode_state(struct device *dev, u16 bmsr, u16 lpa,
 	return 0;
 }

+int mv88e6352_serdes_get_lane(struct mv88e6xxx_chip *chip, int port)
+{
+	int err;
+
+	mv88e6xxx_reg_lock(chip);
+	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
+	mv88e6xxx_reg_unlock(chip);
+	if (err < 0)
+		return err;
+	else if (err == 0)
+		return -ENODEV;
+
+	return MV88E6352_ADDR_SERDES;
+}
+
 struct mv88e6352_serdes_hw_stat {
 	char string[ETH_GSTRING_LEN];
 	int sizeof_stat;
@@ -141,14 +156,14 @@ int mv88e6352_serdes_get_strings(struct mv88e6xxx_chip *chip, int port,
 	return ARRAY_SIZE(mv88e6352_serdes_hw_stats);
 }

-static uint64_t mv88e6352_serdes_get_stat(struct mv88e6xxx_chip *chip,
+static uint64_t mv88e6352_serdes_get_stat(struct mv88e6xxx_chip *chip, int lane,
 					  struct mv88e6352_serdes_hw_stat *stat)
 {
 	u64 val = 0;
 	u16 reg;
 	int err;

-	err = mv88e6352_serdes_read(chip, stat->reg, &reg);
+	err = mv88e6352_serdes_read(chip, lane, stat->reg, &reg);
 	if (err) {
 		dev_err(chip->dev, "failed to read statistic\n");
 		return 0;
@@ -157,7 +172,7 @@ static uint64_t mv88e6352_serdes_get_stat(struct mv88e6xxx_chip *chip,
 	val = reg;

 	if (stat->sizeof_stat == 32) {
-		err = mv88e6352_serdes_read(chip, stat->reg + 1, &reg);
+		err = mv88e6352_serdes_read(chip, lane, stat->reg + 1, &reg);
 		if (err) {
 			dev_err(chip->dev, "failed to read statistic\n");
 			return 0;
@@ -185,7 +200,7 @@ size_t mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,

 	for (i = 0; i < ARRAY_SIZE(mv88e6352_serdes_hw_stats); i++) {
 		stat = &mv88e6352_serdes_hw_stats[i];
-		value = mv88e6352_serdes_get_stat(chip, stat);
+		value = mv88e6352_serdes_get_stat(chip, MV88E6352_ADDR_SERDES, stat);
 		mv88e6xxx_port->serdes_stats[i] += value;
 		data[i] = mv88e6xxx_port->serdes_stats[i];
 	}
@@ -200,35 +215,40 @@ unsigned int mv88e6352_serdes_irq_mapping(struct mv88e6xxx_chip *chip, int port)

 int mv88e6352_serdes_get_regs_len(struct mv88e6xxx_chip *chip, int port)
 {
-	int err;
+	int lane = -ENODEV;

-	mv88e6xxx_reg_lock(chip);
-	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
-	mv88e6xxx_reg_unlock(chip);
-	if (err <= 0)
-		return err;
+	lane = mv88e6xxx_serdes_get_lane(chip, port);
+	if (lane < 0)
+		return 0;

 	return 32 * sizeof(u16);
 }

-void mv88e6352_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, void *_p)
+static void mv88e6352_serdes_get_regs_from_lane(struct mv88e6xxx_chip *chip, int lane, void *_p)
 {
 	u16 *p = _p;
 	u16 reg;
 	int err;
 	int i;

-	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
-	if (err <= 0)
-		return;
-
 	for (i = 0 ; i < 32; i++) {
-		err = mv88e6352_serdes_read(chip, i, &reg);
+		err = mv88e6352_serdes_read(chip, lane, i, &reg);
 		if (!err)
 			p[i] = reg;
 	}
 }

+void mv88e6352_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, void *_p)
+{
+	int err;
+
+	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
+	if (err <= 0)
+		return;
+
+	mv88e6352_serdes_get_regs_from_lane(chip, MV88E6352_ADDR_SERDES, _p);
+}
+
 int mv88e6341_serdes_get_lane(struct mv88e6xxx_chip *chip, int port)
 {
 	u8 cmode = chip->ports[port].cmode;
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.h b/drivers/net/dsa/mv88e6xxx/serdes.h
index 17a3e85fabaa..21e050b328cc 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -115,6 +115,7 @@ int mv88e6xxx_pcs_decode_state(struct device *dev, u16 bmsr, u16 lpa,
 			       u16 status, struct phylink_link_state *state);

 int mv88e6341_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
+int mv88e6352_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390x_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6393x_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
--
2.36.0


