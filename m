Return-Path: <netdev+bounces-285746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEf1J2m0/WlWhwAAu9opvQ
	(envelope-from <netdev+bounces-285746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:01:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D5E4F4A7F
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8830301F480
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 10:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8F53C9EF3;
	Fri,  8 May 2026 10:00:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2127.outbound.protection.partner.outlook.cn [139.219.146.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F176355F49;
	Fri,  8 May 2026 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234454; cv=fail; b=ApV5lWyjDqPEC5l/tlfXPvDi5loxCpEwrdSdzXQra1feNmeuNppA4qU51J6nr3xn2NtfTTpztEGyszfud0XJWK8/kFDCXGW0MOvlAi/UEI5r2AvU/It6kV5+Z+mznHs9qvFpZp2uhXxnPc7VA5rfJOmBybes1Nvl13GI33iEYTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234454; c=relaxed/simple;
	bh=SoHOYh6JvmQ8VgSCITGbvKsQgso0BAL9T++82glg1tQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MKlu8KkdK5Kov1Hb8YJIGGOWBWetm2H2TpIa4v3Wg5RQRTW71SRvTvo5s0V4V2eulgV2pSVoHfe1awJkpP/livPswqixyI9dHtqKyC56pe9+9U1WPnLOFYndGm2+Hc/hkAqnByZsycaCduXdam3SMjYUL75fE3wsQimbdN6hxnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7tIs5zG77cVwivV/Gvv7l9ZSWvLwfjEKRKXoRX2SJw37yMUTgVaApFwSrQo3GELUaAljdurkyaeVJ54vvukLa2tAbKm8X3OclJ+LjB6Rye6cciskIOTjv1BqxgvlcS+NQG69gkbJvvCxWSXlaaPeAJDomEof/Y2atGYf90kgsqD2xsPEhC6+sJFuc+ktu/3v5fC5ZJqBOqlWd/03eeVq+wmhotw3LJJqnrjcVXqgksmgh0H8oZbWXCyoZ1pU3RWE0UfkXJoFPDXBbWuMMUujNJGfXkZ5c3ZLnEzR15ZruCvWGGvPzYRoHK+Ny7r76N65v84rppMkf/J5rge2WjgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtCw9m5Lw7SahJV2VRPGAIx8FTrSNba9hNxj5ZuPJp0=;
 b=XOik3XHmHcqyLqYLiBqY4sjMMXZxf+J2TP1BeKY/aob/bwcO8iey8kRwJZi65Karih7OUTi+Luwi8OUuD/EAm6PNPB4HcSPMgTMU3uJGNerkRbbgw5Ibo7gg6zr5GiQzm6tjVSJi7Z1dgQAPXfxZikxhncon++gmBIpGfeyt8vmGOZ26pOyD97ZfL0ACUktlFxtZy1++JB+fKICdcTVquCYBBIqJjMr9yPD1eDppKw6nMbsff8Y76+1vCNr6SB9xv8ot2le6tKh5cTn8Np+nAf7aaDNu46G4+wvm3n6UJJnRP22+72sIOCsJ+xsZjAk22nZ6EdwreYm1ZwDxnTi73g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0776.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:19::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 09:45:33 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9846.025; Fri, 8 May 2026 09:45:33 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v3 3/3] net: phy: motorcomm: Add YT8522 100M RMII PHY support
Date: Fri,  8 May 2026 17:45:22 +0800
Message-Id: <20260508094522.3952-4-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260508094522.3952-1-minda.chen@starfivetech.com>
References: <20260508094522.3952-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0007.CHNPR01.prod.partner.outlook.cn
 (10.43.109.83) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn (10.43.36.12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0776:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2aeea8-a6a9-41f5-8904-08deace68cbe
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sAoz2/7hO49KiDLx5Ryx0GGdwIOnHGvsoozHRW8BdLhazIDOxkQdwcr+hgL4yxxE0NaxMgIi0jtuHE3KQXcRFUrN8poI5CcWtfThyxz6RWO8SLrzxk20ylZJv7OHGOwzUEFLyCKhk0oEOs+JJmc8ANsKP4MLAsvN5m27JDWR23XfW43N37UOinXxv3RK1CdK5sVc+xqEZiZyVdxgzXKfgILf3h444UNLgyDLeW41edF5W0OZ8mioVeZaz2o9rjCA7Z96jRSd0fWcL1XgDRkrjcdZkB/309k3PXVJevz4L8kJBTekP7M0s7GO4Ozor46iFG/jxE8UQx6yfblffwO8856yp2SvMD2rchS2jmvgRVTAZI0mSVXTqFK6ZBCSEGu5Cqn9tdUkKyjUQ8b71k2GE8w9XXqJ+yI+xg5lx/Em2lNTJtCr5dk6PxJLR84PjXNfWkNSZQLjIJIpZ6hRkcyz5n5oG61tt6vFtz1FPmyL8YY8g1fDNLpGq03jlOmpOuk2UlMYOyR1bFCh4C2/L3TT1Ldz7sH8XKBc8dleWsAEKpBDdVGkQuw0y9KQ/KfemXIG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K2Rm29FGL3RxBt1RTuS44Xo5gFJnnZdHs53r7gNem9jXG/zrefmc+/1SrU9j?=
 =?us-ascii?Q?AP4iuFlPMAUkMKco/QCqteBQBt3UvZ1OfW0Ygr3OAZd3a8WktyN6fG0YjJkB?=
 =?us-ascii?Q?KW7E/fubsySe3a1sc8DHK7CrNEaZcHNhSToBTXeNZ+fmREK0o83VHw10dWm0?=
 =?us-ascii?Q?Ox0s0pIR2tQh/TTOtXVHE8v/AMWbdwA3/kgjEYfNoogf9V2l6plZQoxJ4MrX?=
 =?us-ascii?Q?iwyqLM9AWWUqyyN0TeGIAyK6ucFjJTe0kIxsAGzQkjmfZIFxzRNAju4QQppZ?=
 =?us-ascii?Q?DPlrlOtEUV+uxVoCNCPAMcXFfhp2g5NMF9WZ0WvyKVosvG3bBRQ1WQpNa/gl?=
 =?us-ascii?Q?fusVRp4Nj16HBBrQ9WfV9ED4crzU+mxOt4aLS0V2MUchG/hpvqbq9l/yL/s0?=
 =?us-ascii?Q?AW8etnqJ5pv7OUVBuMEDu49y32RZH9f5VOEhHs0OYNMk6b+fVK7C4aqiD7en?=
 =?us-ascii?Q?oZmwQhNHvw8VowF5PjO+NyZ9oa8N+jydSeXTfvJYZhtDLt5pih+BJQX6C0zG?=
 =?us-ascii?Q?s82ISJmiGr58Psr4RgzwjjHcnmsGGa/JwKCEjP95DGW4saDfdJXTFJkxYs38?=
 =?us-ascii?Q?bBPOrPyAHbJpdcjZ+6HfaNCiaO2EJJS55kFy44mYHCYuuhXyUpTiRyWl1XdW?=
 =?us-ascii?Q?H530zCurBG6vdQCSsQNZ8ByCyQd4LI8dt4KTMG59o8vGxHkDJX/MYZhNtNuw?=
 =?us-ascii?Q?ccqUbgcnBDeYVFi6RW2ZqDSezJ0WWXTtZFb0IvzI5F4+C4ldNw3UG2eGZb0T?=
 =?us-ascii?Q?MjfEqkFCKTjquj9rUOpC81CCnrFKg4sSOvK2rXFxhR5KXaUWJFdZQi7j95xv?=
 =?us-ascii?Q?KAbtmRbz33Jq+umhlkCfQY7MQqSHAmD0GOyFRpVYCTRrBIxJhVhR8mI5aI+/?=
 =?us-ascii?Q?enwQxM9i8ld6xtKhHkYnwk75YA35Rgxdvu0dw1bOTS6y3AUlPm5Xu9D02cQE?=
 =?us-ascii?Q?dSSp2O/f5B6jwOc2ns9RTDUfJWC8j/VGMEWc0xYnqgUvxuRygcHr6feFHuQU?=
 =?us-ascii?Q?EDedW9I3Loz7R2nVUxSWmfjDGZgb/XQQu4NQNM81ZAUBlm1IlOLiJwCGZ7oA?=
 =?us-ascii?Q?iG5ht5dDCRitkUOiQNJqgGCd9zZnLYVPdGFmSgu7+CLFnSVwwUzISfJ6M10/?=
 =?us-ascii?Q?dPrsen8j4WkZRdZ7ajw5S6FeReTyoj4i1+FSfNRteaeArthrp9RTvWf7Bg9k?=
 =?us-ascii?Q?1+DSuFJKyYiJJuyg3KNvcZOReUR3uYI3HfxWtqkjOx1cHMwJaJ9zPuie/Nq4?=
 =?us-ascii?Q?CyQ4/tR0qOduWqEtg5gFMcK3Yf1zSUBUiNV2ibfybvuSAzUjGFMkRcDYXhPc?=
 =?us-ascii?Q?sAHNevLbzzfoI39ZuKfzXC05IJJNmFYMBVWO7R0SLaqRsoYtygP3sIYjIiSb?=
 =?us-ascii?Q?6rwHAsjekjU5UoxAgH2SHy+7uDiByWXkeRkoYsC8NqAgW86lA+IIpZ7BW/T4?=
 =?us-ascii?Q?kCtWIqc1ILCukgH0cWuf3SZf3V0HnKmqB/RPaX+WvEZMWfFNsoPwwRyJU91u?=
 =?us-ascii?Q?wi8kHC3bSRNAeHIJbLWocQtQIvft5tf8Pst799f+daEmfGrnslokrGbm5+zO?=
 =?us-ascii?Q?BrtDnJ39qVwJFN7Y9r27GeZL88sejWY/DMG52RhBOvuGVpo7KhjNqW23jlL+?=
 =?us-ascii?Q?BVeMGrsbE8FHn9mDW3CXEMZ/zIJWstE13S1SbOnAuxlpki8l7+gS3SB11GwP?=
 =?us-ascii?Q?4ver+I1G7hTA7MLkM+7TJSo9dlRCbTHYNMzRLuW9xVoPGCRVyn8RFYbwci3W?=
 =?us-ascii?Q?yQQL5OiaLl5KeiZ0+vVw2nry5SVhLm8=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2aeea8-a6a9-41f5-8904-08deace68cbe
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 09:45:33.8030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYhgonvh/SjbAxSgnC6HqOA3h8sqYwLX04s3Huc80yrESVZU6qYkkQrFtzMIKGKY6wg6BI+PqFlC6UGFWLvuGKbMOt3TeASvWQvKj7r3fLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0776
X-Rspamd-Queue-Id: 08D5E4F4A7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,meta];
	TAGGED_FROM(0.00)[bounces-285746-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.848];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,starfivetech.com:email,starfivetech.com:mid]
X-Rspamd-Action: no action

Add YT8522 100M RMII ethernet PHY base driver support, including
PHY ID and base config init function.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/net/phy/motorcomm.c | 49 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index ebc24f51e626..13d57aba5487 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Motorcomm 8511/8521/8531/8531S/8821 PHY driver.
+ * Motorcomm 8511/8521/8522/8531/8531S/8821 PHY driver.
  *
  * Author: Peter Geis <pgwipeout@gmail.com>
  * Author: Frank <Frank.Sae@motor-comm.com>
@@ -14,6 +14,7 @@
 
 #define PHY_ID_YT8511		0x0000010a
 #define PHY_ID_YT8521		0x0000011a
+#define PHY_ID_YT8522		0x4f51e928
 #define PHY_ID_YT8531		0x4f51e91b
 #define PHY_ID_YT8531S		0x4f51e91a
 #define PHY_ID_YT8821		0x4f51ea19
@@ -227,6 +228,13 @@
 #define YT8521_LED_100_ON_EN			BIT(5)
 #define YT8521_LED_10_ON_EN			BIT(4)
 
+#define YT8522_EXTREG_SLEEP_CONTROL		0x2027
+#define YT8522_EN_SLEEP_SW			15
+
+#define YT8522_EXTENDED_COMBO_CTRL		0x4000
+#define YT8522_RXDV_SEL				BIT(4)
+#define YT8522_RMII_EN				BIT(1)
+
 #define YTPHY_MISC_CONFIG_REG			0xA006
 #define YTPHY_MCR_FIBER_SPEED_MASK		BIT(0)
 #define YTPHY_MCR_FIBER_1000BX			(0x1 << 0)
@@ -1843,6 +1851,36 @@ static int yt8531_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int yt8522_config_init(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	int ret, val;
+
+	val = ytphy_read_ext_with_lock(phydev, YT8522_EXTENDED_COMBO_CTRL);
+	if (val < 0)
+		return val;
+
+	if (val & YT8522_RMII_EN) {
+		val |= YT8522_RXDV_SEL;
+		ret = ytphy_write_ext_with_lock(phydev,
+						YT8522_EXTENDED_COMBO_CTRL,
+						val);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (of_property_read_bool(node, "motorcomm,auto-sleep-disabled")) {
+		/* disable auto sleep */
+		ret = ytphy_modify_ext_with_lock(phydev,
+						 YT8522_EXTREG_SLEEP_CONTROL,
+						 YT8522_EN_SLEEP_SW, 0);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * yt8531_link_change_notify() - Adjust the tx clock direction according to
  * the current speed and dts config.
@@ -3052,6 +3090,14 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 		.led_hw_control_set = yt8521_led_hw_control_set,
 		.led_hw_control_get = yt8521_led_hw_control_get,
 	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_YT8522),
+		.name		= "YT8522 100 Megabit Ethernet",
+		.config_aneg	= genphy_config_aneg,
+		.config_init	= yt8522_config_init,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_YT8531),
 		.name		= "YT8531 Gigabit Ethernet",
@@ -3112,6 +3158,7 @@ MODULE_LICENSE("GPL");
 static const struct mdio_device_id __maybe_unused motorcomm_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8511) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8521) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8522) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531S) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8821) },
-- 
2.17.1


