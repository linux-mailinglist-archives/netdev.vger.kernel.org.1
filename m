Return-Path: <netdev+bounces-286698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJsjOpTvAWpHmQEAu9opvQ
	(envelope-from <netdev+bounces-286698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:02:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DAE510C48
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52BD53056149
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114454014AC;
	Mon, 11 May 2026 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="Wxijt0zL"
X-Original-To: netdev@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020098.outbound.protection.outlook.com [52.101.169.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4687E3FBEC6;
	Mon, 11 May 2026 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511431; cv=fail; b=l3JBFW/Ep53ZZwmHOfCP6jGdBdtCnZZiZaPDfCeO3N/VHep3ymD+xW9U/ThO2fJTwC4xDBK4DyjO9JIFFs0uv6dmgxStWLww8xMJ9p5uDoWhv2lPJl9kyjMy2Ghjp2wJosGx3/7tFulWsfqqH3nKM0Ezjui6M269/E8AF2dARzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511431; c=relaxed/simple;
	bh=Zs4oaDULX71HvODIlH18YZ6V6DZ0PkVf3YwqSzJoQMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JH2xpTGqYmK0wnFkv7iSsvRBYOnhglEgRYU1bk/W+EVTgoViMUsTwpLvsJQBOkCLeJvN+vkVana3nSFgE0MLWkIc3OlnrMTart7JW1b1UEvDukDYW2kTCh0hhobdmFfbhmDID/JBcmt6TYSGtANHJwZjrZ/WZaoWkLk9X/4ji8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=Wxijt0zL; arc=fail smtp.client-ip=52.101.169.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htO7ATblF85kBmWRt5MR4bxqaxRDva3F0LrYuOuZW1STbq2ehaMu9vokS9kSdtnjwP9Sqhqub8U3r7dgcZTvhLv4VoRlffTwfjXwqTBLDSawTGbopyD5T7dnxSSu9jSyfcufVi2Ox4oRTH13i0ZCdzeW+McEEr5N95Um6A6BDhEW9H5IyNh+m1A2BzZUtSZZCBsm8drRrAGDT/Tx1iWl+8VHU1RFX8Drq0YIkysNdDJA+HfEHVWDW73dQW7GwBJBUwZBaAYuW5SICiWlyJF95grSW0uAGHHUC8SrW6vwkCF11dMGUPesBzXhhLuX9rv6YZ8sJtU4V17QfIOcdwB9Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkducTZr0IeH0DPt4Q2sOuN97JOzaG1MRFaz4jljH3U=;
 b=Vrb5P0XiXcOBdFfuBmAUwEn0jKea1zmKRg/In48qniLe8RKNZIslwPoMC6sPRRrlbzlzW8xqeLkcapviQGyEuYPnc1yaE75G8CK2ZirG+W3TIhS16HctIndy7k9uMqikjTZhNKCm7nBX8d9EMDOSztJ/Oc/tXWdQDMI3ltqwVJAZZBua4pgeT9mlLdehekb3tncCD1ZsUuA1e/e5TK2fSwNe42f/ore/nW8XVpMCziEkyHUaU+8Ympd6bm4Va4leXLBwwf+meRV28+msGSTUC7ZuO+B8jihMhfIcFUBxUDmBdt8lcgAe5GB9MoCbBaTzBxWdkD54vN1sFWvQijjnuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 62.153.209.165) smtp.rcpttodomain=armlinux.org.uk
 smtp.mailfrom=schleissheimer.de; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=schleissheimer.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkducTZr0IeH0DPt4Q2sOuN97JOzaG1MRFaz4jljH3U=;
 b=Wxijt0zLxepCAyB0HOPftDl3a5JGM1s11BV83gaYzYESWFrF+8av3fUeZ4zG3AUcOEHaM70+GnnJfwOv7KNM7gpCmoMNHLQIgtt0xj5xc4aR15WFttAm8U/S9vErcGiVTdgo10AqGPRnhj/hkhF/FiGHdSErPyztt4NCsmXcp7I=
Received: from CWLP265CA0270.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::18)
 by FR5P281MB4764.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:151::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 14:57:04 +0000
Received: from AM1PEPF000252DD.eurprd07.prod.outlook.com
 (2603:10a6:401:5c:cafe::a2) by CWLP265CA0270.outlook.office365.com
 (2603:10a6:401:5c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 14:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 62.153.209.165)
 smtp.mailfrom=schleissheimer.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=schleissheimer.de;
Received-SPF: Fail (protection.outlook.com: domain of schleissheimer.de does
 not designate 62.153.209.165 as permitted sender)
 receiver=protection.outlook.com; client-ip=62.153.209.165;
 helo=mailer.schleissheimer.de;
Received: from mailer.schleissheimer.de (62.153.209.165) by
 AM1PEPF000252DD.mail.protection.outlook.com (10.167.16.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Mon, 11 May 2026 14:57:04 +0000
Received: from A1460-Ubuntu24.schleissheimer.de (A1460-Ubuntu24.schleissheimer.de [192.168.50.44])
	by mailer.schleissheimer.de (Postfix) with ESMTP id D0606A005A;
	Mon, 11 May 2026 16:57:03 +0200 (CEST)
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
Date: Mon, 11 May 2026 16:56:30 +0200
Message-ID: <20260511145630.31618-1-schuchmann@schleissheimer.de>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DD:EE_|FR5P281MB4764:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 86a5a3f6-ecb2-4df3-db2f-08deaf6d907c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|1800799024|18002099003|921020|56012099003;
X-Microsoft-Antispam-Message-Info:
	0uhxj2uo9B/s7XcQXwuncvLlk/Bal+UYG7zaN4Iop/Q3YJLQFCSIx8gHheZl7X4102WpBBnPlupl7YaL17yEaSfQtPe1O+MsZArZ8KVnhrw3NXzCzDmIaUJwzHo5OmNGO0TBnvOgHqSRP8bKDbzIr/nTNA7IUAgJJq0vVpz+Gg9mh70CqnxATUnUx0ge/UmdovWSziWeYqBnFB6/D6OOsAKlpeIuzEJz3R7DZH0JrT0fCJWUbZCBE92aVMc/xhm+ha6cdO713S9zbG85RQywIwfNozG6NVcF5OB2SntPJuL1pJp3E6ecMURey/Eio2Yw0Ryd7yMjl/vX2vLbIFqz0hh567g6BHdM5LvqUZlLWZrc8KqkD9EO8MjuqJyHjNrloB0DA/7S4YYwOZ7FpIw+NvArQe6CY4o8xTgJQqdB7Ulyvp+CBZONPY4B9uX4EJouO7/lGnv69jCavUIKkBxP4zHvlfsaRqkUooSID0O0EUM5qwo65946lNiDrlttEQ86GIM/APqnDizfb8FIcBvPWmZkHTwMGLKc/ZIBhM7jZcwD3G4C/8Od2JZod1QmpzX2SiUAoK41KU0lTsYlpSPFDjDWd5WVhphy6btxz9r6sC1ALJ/xgH3RCisDqSvO5ilWHKtjFShpxE4n3IzLL6PpaXq3+KJ5LrH9ZwPd18RwYqj6crUoO9X1d2A2WCBAsYBTOvpxz35wTGDiNre24xgYN4TAdxxwn13sCAl1MHV42rJ8kfyvgWkEEvzv9w6SEcYzam9QMddabI8HstuD6x3CXQ==
X-Forefront-Antispam-Report:
	CIP:62.153.209.165;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailer.schleissheimer.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(921020)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	43ll6x9Gi2rRGGGFs0oKa01E9BSzQv0k22/tWDPlwtUGAxCEC8PsgCRt4Y0L4dIe4qPJTYNzQ5skCKOAZh7A92LkCg4Y7AkcRC/yTfMoqtsS6CbnzQP+DBJ8hDmXz1dLWNwa+PJDnFkEJK+xtiIEqBe0tBMe06Mih8J5LYy6nm9bMlSFKfCyT5d+X8vu52v6p7MGddgxtZbx+UG+dHoS565D22VBv2YAQj89ACpjxGo1h7pnPzwRa6q8XN48hnamEwsWD0HAsAAKPkBoGuz168vGYCS++UUzYYcQPZk2YHCiaMXwFhV29dx+RP1tkLNy0v6vRIC1Og1bn6qMkzkxOUqEseU8j+qVLfWx9RjOeHljhU5TAcIImP83y4CdbXugpLzoQFIAq3X27IW+KkobonU+0b3wZZLRXDuLyJN9arwGHJLG4r/UTFhpwfLcr0Bj
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 14:57:04.2914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a5a3f6-ecb2-4df3-db2f-08deaf6d907c
X-MS-Exchange-CrossTenant-Id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ba05321a-a007-44df-8805-c7e62d5887b5;Ip=[62.153.209.165];Helo=[mailer.schleissheimer.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB4764
X-Rspamd-Queue-Id: F0DAE510C48
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[schleissheimer.onmicrosoft.com:s=selector1-schleissheimer-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[schleissheimer.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-286698-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,ti.com,vger.kernel.org];
	DKIM_TRACE(0.00)[schleissheimer.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schuchmann@schleissheimer.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email,schleissheimer.onmicrosoft.com:dkim,schleissheimer.de:email,schleissheimer.de:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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


