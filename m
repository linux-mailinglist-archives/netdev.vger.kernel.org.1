Return-Path: <netdev+bounces-286977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEzvCyjWAmpXyAEAu9opvQ
	(envelope-from <netdev+bounces-286977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:26:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFEF51BCBA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDDA8303FF8A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60A842E010;
	Tue, 12 May 2026 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="WEoKHPkv"
X-Original-To: netdev@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020087.outbound.protection.outlook.com [52.101.169.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D694379C5A;
	Tue, 12 May 2026 07:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570401; cv=fail; b=DiEvxuJlQpAjFrMDQ64QiASZ3mduNfWO4DTzjdZ5fveXf2IZrh+6v9Jd5uYLv6RnnaVHZlkWtmyCYAFqI86M0PSmwDeZZXTM44RNwbbi8usQJyiyDYnnYIwovoRBXWxVu2ArR1N2Nq+YyXkbnjzHB8o7PUOk7I9h9JwuaIofWaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570401; c=relaxed/simple;
	bh=Zs4oaDULX71HvODIlH18YZ6V6DZ0PkVf3YwqSzJoQMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Aupms5AF/5ARzB8n0NMEBEjxTF559AFyEpMJcWNF44FTRNdIvRlYTDrteTO6TyHmqXsUk7a9G1xb+D7xWxkVuWTWFGrxxRNQowRZpVy+6TC1QjcpMk2tvvuosVKkdGgQQXX0kluk79N4aeNT9lKKUv03rHnReYD2O5UfCxZhYIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=WEoKHPkv; arc=fail smtp.client-ip=52.101.169.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zqt+0m3aaSQrtFeHNVkqgwgNiQPG33i5Vw7cKq7m5v02Dz49zHWbcoQwLjxP1rQi7tkasiqxH6ZBwH0g8egj1pH0ZXwYFNj6zWApQrwXK8C+/ykdXShmtkX+4aENNOMCGyem4KG42mTIorlC0184qK+tnJRD3C2OFWAL5yj3CXBxmfWKKEuagweNXxKSnUjQenm5BIW8iMyErBskjCwb4t8dd2p6YH0OzW4fyKh2OugSzWBC7jFBsT0RSaWJXM+y8yOfxtWu63B1c/W+nnL0rgwaSLQm/1UUGllNOCDMBZYhkKbBrevEP/FoJjs4IeuHJdcR6gLbU+Zdv0xzMGgyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkducTZr0IeH0DPt4Q2sOuN97JOzaG1MRFaz4jljH3U=;
 b=Btq3Z5NjaaeLNjTqkbKf8dt7mHXXJ9WDR1ddbHwLeTOVEkQ3jaQauAaOe0hlKvI5Ln/QCjzVVl4cczO1MFL5ka6jAxhkDClwDW9vO7kxP52n1BujES/BOWPWcqIWjHNCFMx8vhJRiGaDiVtzVaiVAUwR+5AOxsSu55Ab8W14zzJHajf0A8QQ8k0EstsDc9lkxGmENhDfTYnbUVh3p9EGd/sZjjP68DfFK6TLgjgVDkxxp+BcuQhkTCZQIj2f26FosYQbacO/wSP8/EPUhDsKKFl/JEwE2HhS+FiXrgxXWxS4t2Adb6C3OaA7Cxx424+s4PABP0YOt5Qtau86luBcEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 62.153.209.165) smtp.rcpttodomain=armlinux.org.uk
 smtp.mailfrom=schleissheimer.de; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=schleissheimer.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkducTZr0IeH0DPt4Q2sOuN97JOzaG1MRFaz4jljH3U=;
 b=WEoKHPkvqjeFEAV9tMeVuyOxFB46MZXMKAI3aMAyE8O28+VEkEtNgouOhnxFSfgaUoQlgxu1/0auul78HOGmdm5ZL49OJtqWZ4Rluqp6wo+Vijr79Yrfas8sTdPquUAWuGggaVN96pkgDd/aNtmpEOHMee5jq47zxq0H/7kfy0U=
Received: from AM0PR02CA0169.eurprd02.prod.outlook.com (2603:10a6:20b:28e::6)
 by BE1P281MB2546.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:62::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 07:19:52 +0000
Received: from AM3PEPF0000A796.eurprd04.prod.outlook.com
 (2603:10a6:20b:28e:cafe::5) by AM0PR02CA0169.outlook.office365.com
 (2603:10a6:20b:28e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 07:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 62.153.209.165)
 smtp.mailfrom=schleissheimer.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=schleissheimer.de;
Received-SPF: Fail (protection.outlook.com: domain of schleissheimer.de does
 not designate 62.153.209.165 as permitted sender)
 receiver=protection.outlook.com; client-ip=62.153.209.165;
 helo=mailer.schleissheimer.de;
Received: from mailer.schleissheimer.de (62.153.209.165) by
 AM3PEPF0000A796.mail.protection.outlook.com (10.167.16.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Tue, 12 May 2026 07:19:52 +0000
Received: from A1460-Ubuntu24.schleissheimer.de (A1460-Ubuntu24.schleissheimer.de [192.168.50.44])
	by mailer.schleissheimer.de (Postfix) with ESMTP id 529DAA005A;
	Tue, 12 May 2026 09:19:52 +0200 (CEST)
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Dan Murphy <dmurphy@ti.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: maxime.chevallier@bootlin.com,
	Sven Schuchmann <schuchmann@schleissheimer.de>
Subject: [PATCH net v3] net: phy: DP83TC811: add reading of abilities
Date: Tue, 12 May 2026 09:19:47 +0200
Message-ID: <20260512071949.6218-1-schuchmann@schleissheimer.de>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A796:EE_|BE1P281MB2546:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d5cf867a-cf20-405d-1e6f-08deaff6dc57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Cuk9+eWHk67ShjxodHB+9bGdsbSM9OuWJeXwYyTqrbOxrRus1ECXhJKdv/LPQPI60NtzTb1A+YGav8RibvaFsLIz10EQp6k4g8ekmVsGt3/fVOwoQD7HBznLT7Xfz5Fubgw15/qyRIViufBdCtxsMoXuQaZerf+tWQZY4Lb2wTau7qvKqYhzU5Hi+5ZOLZgq6Zf3nAXhSB3eIqbA3gUT8aXhSP9eRK6Si/WLQMO0F9ShGTck7MwEFpQysmkDaMs17ck3/gaYmwj+MtC+2OL1+Kd8P0B0NSZVrNz2PdR506K+CxdP8nLum7lNgWMRapsG1jjhzDBZVfMX8RsIz3HInev5b/QqA2utwg6w4R5WuMtYjbvM27xQfJ+7qeC/PgZxA4ONxKce9aRRdHXYdibnt2JIQdobDIDfUUtU98Hwe5eayJ5XcPq4PHXwcVmWLduOnDbx1J31mgGTd2hDLizYCzZSuXVcFIL9NS+0FIYdj0ITXr4ZcQ6gq/G6VodMaiG3oyTM29HXZdSc/aPU/nY1hngUzoSwOp4vT8iGroSuqA6QlySv8mhUjqVAt/Zaz0f7aSqWP4bGyxRIq805UlKZ2CEgc/fsAYUXBW8D57F70nBZG2Bj7CFpptv2dA2tbqKG4mwJdE6071fOROMGOTOs4QrAsnkIRDm6+yvasF5i8aATUrnLX51V4YJu4wK6IsSdd2VQVyKSE2UFizLlJujB+JRwltlSHX7OCfvNe0lLJGFE5UuQVeBaY3E1RziBBU/woHxEboOu4bxBPXWhEQ6f2w==
X-Forefront-Antispam-Report:
	CIP:62.153.209.165;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailer.schleissheimer.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cIHE5L+7xGpUHC+Mq4VFeordKZawZCSPswIUPOF/myUWJixyv0KY7Z2XiGDOQ6l1KXwvBMqJ1hPcPFdwt9TBGgosUUTbx8cS/9i57oWETSaDphG+7KYmEtkw6FQZ8Y8XCJ7OX93F6++4gIMLDas9MwgYzn6vUf2+55aeMBCSDglExo39hALY9U+87FjwfuIaFrBi4Wm/HeGGGmy3ldDWLYYNKJ7uUrqGUC1G9zroowKzFsT8ToyGlVj+f+LtZpxJTF4rCEyfmlVzBFjmyRGlP+439+NlkxmgdMx0KJj+OffM0MitaRALyzZke14QlBmXnzMgfKFcsZ/udqtKlMVP31tVFJ0N9vUPRTvP8ag+LKJWQPccCVfKjmYKWzBH/IYTrN+CHkrW3gulwZzYEimDsupeYeTLcFWHSmqV+esWGhAluFfZ259J8PbdK8J8EN0q
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 07:19:52.6074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cf867a-cf20-405d-1e6f-08deaff6dc57
X-MS-Exchange-CrossTenant-Id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ba05321a-a007-44df-8805-c7e62d5887b5;Ip=[62.153.209.165];Helo=[mailer.schleissheimer.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2546
X-Rspamd-Queue-Id: 7FFEF51BCBA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[schleissheimer.onmicrosoft.com:s=selector1-schleissheimer-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[schleissheimer.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-286977-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,ti.com,vger.kernel.org];
	DKIM_TRACE(0.00)[schleissheimer.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schuchmann@schleissheimer.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

At this time the driver is not listing any speeds
it supports. This should be ETHTOOL_LINK_MODE_100baseT1_Full_BIT
for DP83TC811. Add the missing call for phylib to read the abilities.

v3:
 - Fixed indentitation problems. no code changes.
v2:
 - Fixed subject and added fixes tag. no code changes.

Fixes: b753a9faaf9a ("net: phy: DP83TC811: Introduce support for the DP83TC811 phy")
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Sven Schuchmann <schuchmann@schleissheimer.de>
---
 drivers/net/phy/dp83tc811.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/dp83tc811.c b/drivers/net/phy/dp83tc811.c
index e480c2a07450..252fb12b3e68 100644
--- a/drivers/net/phy/dp83tc811.c
+++ b/drivers/net/phy/dp83tc811.c
@@ -393,6 +393,7 @@ static struct phy_driver dp83811_driver[] = {
 		.config_init = dp83811_config_init,
 		.config_aneg = dp83811_config_aneg,
 		.soft_reset = dp83811_phy_reset,
+		.get_features = genphy_c45_pma_read_ext_abilities,
 		.get_wol = dp83811_get_wol,
 		.set_wol = dp83811_set_wol,
 		.config_intr = dp83811_config_intr,
-- 
2.43.0


