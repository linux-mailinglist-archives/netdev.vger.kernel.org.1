Return-Path: <netdev+bounces-285709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHkpJcaV/WmXgAAAu9opvQ
	(envelope-from <netdev+bounces-285709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:50:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C344F346E
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2999C30041C3
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 07:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB903385B9;
	Fri,  8 May 2026 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="eoKJNKa+"
X-Original-To: netdev@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022078.outbound.protection.outlook.com [40.107.149.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8586347521;
	Fri,  8 May 2026 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778226627; cv=fail; b=dY6eZpqNrVa+bRKj+lVv3gjk8TW0u9hHJ1/DUERRtUMXGxEvgKuJFNhebJpxh8nqlKUuPEcYmSRSaLaCN23929W58FQQEcuajXnQS9uSXK0ZEsu+4jyAfr22/UT5MwT02Mm7KAuD73Fixs1wmpNyg1mJDBcTD+fGhG5I+edXxzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778226627; c=relaxed/simple;
	bh=3iaG425+X5pfPR6YGhn7dWMG8OKNInJA9qGV8LJ2LFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qyOZ740y3q6tvatpbvYxY5/r8ZmJVbthj0lbxhrvztcNp9m0T8OgRJSNm4HDerkibB338kQmjxP4JWfL1Gj9zJ1NTiu9vMQcl6Z5tRD8tWHrVUA3+QOy8ZNwWcmH8HAblgAgfvvpicsefZv8mxhBelvtgNzlxdrlPD8pR9hty6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=eoKJNKa+; arc=fail smtp.client-ip=40.107.149.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lw2mG8AvYVY6mA2kc1az+6uhS0KZl2weTWtuFakblidOPHjd0U8r3GcxJwNSOllNywblbVJb59uTLlBKiLizszNAV3fTIKngmQZFMoMPQo/H4Heq2w/Mm0yzgpFZ7SdCltr4NUTAOzykQNPpK4gXa8HUWnOSJcHYMW31IqmslDBYcMUAs4XQ3iWPd4roR8qT7DDeBWbALv3xat7yecUG9qdx45llxofp9Gi7Eeqb33uTn4Q5iMRL+5IfMYopjKFJDbtaO7H/4Sog+KcrzFiIg7jdJLfYJjc1yIxYpm7R/0i5sx4n5fsahCqmtRdd7sWsADMjsMrOJzoE+W6xwbWyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXsdQDM3d9rJ3TXOtbD8HrMGAlYcbAfmSDPx46A2IHk=;
 b=Mooz14FkOokYHr20HOo/wAqx1OyccSppKb959GLCZu2iqX/s996nbW/ZtOQGX8kepRdm5p233ZOoi/WlLpKpnisdHEDPgjyKy/cxDpIhD5JmFoPUsUxf1gMgRtNUd6qliI+JUnutVjIHUxqWykvhk28mgr28ZXol10g9LPhKV1jN1OC3a+9IIF78W6b+A/iBv5sZXsWCDJjpT1iKx8cXCWQdNYFASCfoGiAmLQNf7BOicppgZ0FbsmPgWkVzU4qLj1smqBQRYUMabju4syeK6+0O/i8OOi/hD/zSKr7AJDWnE1DD19OpBCqmlcLL6CCsm54XenbEvVZYD07xRy+Q1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 62.153.209.165) smtp.rcpttodomain=armlinux.org.uk
 smtp.mailfrom=schleissheimer.de; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=schleissheimer.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXsdQDM3d9rJ3TXOtbD8HrMGAlYcbAfmSDPx46A2IHk=;
 b=eoKJNKa+36ZhuXJfIlwjnqb5UbUaqjTDceEwaE+66PM+Tb2fcJnWX3v2vvc3XfQnNYWb+pQ3cuOYzLqwezUtdgK3EYxKA2FkC1oVKAXSEXYcuf8TWLpTwPY+Q77WEGU8kRxyxH/DUU+6YBaD6OTol/xQ52JK4cdLr8WC0lwRmqU=
Received: from DB8PR06CA0048.eurprd06.prod.outlook.com (2603:10a6:10:120::22)
 by FR6P281MB5324.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:197::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:50:21 +0000
Received: from DB5PEPF00014B94.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::e) by DB8PR06CA0048.outlook.office365.com
 (2603:10a6:10:120::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 07:50:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 62.153.209.165)
 smtp.mailfrom=schleissheimer.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=schleissheimer.de;
Received-SPF: Fail (protection.outlook.com: domain of schleissheimer.de does
 not designate 62.153.209.165 as permitted sender)
 receiver=protection.outlook.com; client-ip=62.153.209.165;
 helo=mailer.schleissheimer.de;
Received: from mailer.schleissheimer.de (62.153.209.165) by
 DB5PEPF00014B94.mail.protection.outlook.com (10.167.8.232) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9
 via Frontend Transport; Fri, 8 May 2026 07:50:21 +0000
Received: from A1460-Ubuntu24.schleissheimer.de (A1460-Ubuntu24.schleissheimer.de [192.168.50.44])
	by mailer.schleissheimer.de (Postfix) with ESMTP id C28F4A005A;
	Fri,  8 May 2026 09:50:20 +0200 (CEST)
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: maxime.chevallier@bootlin.com,
	Sven Schuchmann <schuchmann@schleissheimer.de>
Subject: [PATCH] net: phy: DP83TC811: add reading of abilities
Date: Fri,  8 May 2026 09:49:30 +0200
Message-ID: <20260508074931.8226-1-schuchmann@schleissheimer.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B94:EE_|FR6P281MB5324:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 883425e8-11ad-4bbe-8281-08deacd6749d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4eIl3w0moN2GaBFnMSABrpnIcevgVk81nHZXrQJkxfbpV6+bIxXyfjoWkeVdmAe/yOHWml7ISMk+o3vS2YxAvnbX8BBNMQvGR9CSMbFTkOgVkDKwvrqobYT4FUYlvUTfDoP01Zp2p211fbm0q/BDaK5ite9v8bSCffXpbHo4gvKnevPtswbDvsG3JvGliEjx2uElVnhs99JhQ2t1lHlsN/UnCGKPgDCZUB9/XAfoAgvotrM42w4V4bttS6FtxuP88aUF1EAVNITRrj5qROvPpydx6wUexcixqVY3fRmbLzFIUgPAZkfNhDQB5fyta1WzOk4xQ0gsg2gUwFVPP8ArcrmTQJUsDSU8CJlkuW1haPpARzESbA9J09yjDSoTNsspMSxLuk9fbxmq72NzOs7CgBDttXFU/To6PZpsJoF2Ls7cMRYDZ5ZbpAXg1vGb58K4JuoaAing3iSnwYNy8DAIotxL/hTBMaonnxDXB+kg57hYBXnCp4LWxGdW+ZC3Jdakny1QwgUD+tngVSECSG3RiZLbESE/WXyV5GuMnPiOQhzo7a4uttFR4Sw/5qKv2AmQFCefpONXn/k9PIhIN57Jy6GqDynPkPfsJlrs9NvyMLUkCZNiGB70PSuVnGLDq1cwH2n/FZ7mj3yfdcl3/IXwSJHhGGtn4RNnXhjp809ePCWiH1VyWxkfsBV6L6Awu0O1uyAb3MmZdV3HvqW3kbAM8+mA8oOiEIBwTqt8fZSq/fo=
X-Forefront-Antispam-Report:
	CIP:62.153.209.165;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailer.schleissheimer.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B9BmRJrmIRNXRnts+p1mtg3GBxkRooXpfDBxz33WHUBH2WpfczKipjtcRMEd+eObf65PXZzWGa2NLwpyPBJtEc27exq5ACBW2qQj0YmR0/s5oDQdWzWByChWTd/VGBjidJS1ZalYvkRcYzIYX2mGLv0a/ox8/eqNVHw2yEYwTF4xwnOQ31k8LZCdA2qB5F1hAwqW37wLt0fB/6rRt4+O9pwbX9fzFZom8q8vbKOQ+9tRoaxSW64wNrwUjA7vov1JJGe0KOjarf5VULds2Ucb0QUlPzRIy9sNTGZhBeIrqX+8E6Xlm1zXkSdgBWTurI12yjh4tOJ5k7r0FU8iZ5tsu3jHBhzfEPGb5QqChK4Ll6MUcSK2k5UIbBer+R6PbbVrvsQxccJ9GC/fyS/v+jhG12PZHdpVrV+Fkzwst7rjaEAKATj1RVLF1GBZAIKQCTRR
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:50:21.1754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 883425e8-11ad-4bbe-8281-08deacd6749d
X-MS-Exchange-CrossTenant-Id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ba05321a-a007-44df-8805-c7e62d5887b5;Ip=[62.153.209.165];Helo=[mailer.schleissheimer.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB5324
X-Rspamd-Queue-Id: 37C344F346E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[schleissheimer.onmicrosoft.com:s=selector1-schleissheimer-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[schleissheimer.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285709-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[schleissheimer.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schuchmann@schleissheimer.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:email];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

At this time the driver is not listing any speeds
it supports. This should be ETHTOOL_LINK_MODE_100baseT1_Full_BIT
for DP83TC811. Add the missing call for phylib to read the abilities.

Signed-off-by: Sven Schuchmann <schuchmann@schleissheimer.de>
Suggested-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/dp83tc811.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/dp83tc811.c b/drivers/net/phy/dp83tc811.c
index e480c2a07450..6492b60d1f7d 100644
--- a/drivers/net/phy/dp83tc811.c
+++ b/drivers/net/phy/dp83tc811.c
@@ -392,6 +392,7 @@ static struct phy_driver dp83811_driver[] = {
 		/* PHY_BASIC_FEATURES */
 		.config_init = dp83811_config_init,
 		.config_aneg = dp83811_config_aneg,
+		.get_features = genphy_c45_pma_read_ext_abilities,
 		.soft_reset = dp83811_phy_reset,
 		.get_wol = dp83811_get_wol,
 		.set_wol = dp83811_set_wol,
-- 
2.43.0


