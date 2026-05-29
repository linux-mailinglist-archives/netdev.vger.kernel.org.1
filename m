Return-Path: <netdev+bounces-292970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG54BxAcGWrwqQgAu9opvQ
	(envelope-from <netdev+bounces-292970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:54:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9955FD2E7
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D2513193261
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB36374187;
	Fri, 29 May 2026 04:40:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2119.outbound.protection.partner.outlook.cn [139.219.146.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7181F36F427;
	Fri, 29 May 2026 04:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780029647; cv=fail; b=cU+1Hu7pBf2V9koaU9PrKDAwhIVVhYq6qG/vzVg5YMQp65h+7PtMsuGJXE4UHCUohGtCq5ThY5/P6/LutwgUsQ+QFuIaglRJNvHf1SdO1JYU9NPFK8kK4yvWFgJlGPHIT8SWzqLkF5LSSoGAzQKl8h4bXgR/8qAa79DJwWqV6gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780029647; c=relaxed/simple;
	bh=8JLa2rSqp2qAoZImuhsgUtKhSXaErMJ6Hx8VZq2EIzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oSup6/qZ9Cow8TNBqhtW5YUU6KlFuvL3S8z0HghrKN5PRKEYF26ifoMK8a9ama6YS4Bty6cLiXSJKgYxqxe2M1OJ+pXjvJEBZOaCcSWsiIM0UulbrXg+ZvkBbEk9MdAcQCyJFGIdrMFKIjKZC9EPQLHB429tPI3nTpaPZZ6dDTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0xEm4Jkn2HMjz9gLQolUtujqDnUMnQe0qYZmt7vxWu02emCYxNK8OyMAzHDiyF7jXIN7EwzlvGgvT2nIv5Mh8PnddiHKCi7LWPGQ5zQS4xbrFqtLm1mxyTmgjg6bkrcNA6FS80R5L1D96qEzts7Hr6hSHY/2pWE0BWPt0hlNyyvb7HMNxkO5u9jGhtJAxpGxy2tTShU3yuwbmlGeHz9r+2b9jJJ/cJH6UtJXahVNegrdc1BXq4xc2TdNRPJJKFx+Nm8tuOoMbFTKpqKmD+qFc1tydglN+88kycno7BNgHbi22S/bZO0elVmjdaxUtbBShw+ZHMm4V86cJ/CF2Jveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+Os+0rHJSS3kOpJh4yRaZzWHvLj7/57H84K8ZxEaQc=;
 b=Ucf+ctMSCwFTpWCIkIXXzp0t8UWOuE4CXbmZn9lPomfKLbO2U4BoZOS9ClHzzaEkEj0XCB9qQh97o9vXfQX/FFD2GYybV6DVi9C3CUbUZP5G+3MyVxcVCPL95ky5HFnXNKa/zGbkeE6twbQGG92tYzHd+MVpeEm1Joi4iY1LjWTX8sR+JsPQthlEf27E8etA0F0/oUlltQgqkzHb+Ms3rpzeApysi7ufMA4761ZGRsqdlnDFMMWod6Gd6ON73HO3737heAILF6yjuc63BzAuvDTPcHhX1A5bDFLZdxm6hqgW6f4bGKMKJg78ZWK4P29aZ2ZsiPtAv1RqMlIv6k/Ggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0862.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 02:05:40 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Fri, 29 May 2026 02:05:40 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v5 3/3] net: phy: motorcomm: Add YT8522 100M RMII PHY support
Date: Fri, 29 May 2026 10:05:30 +0800
Message-Id: <20260529020530.16856-4-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260529020530.16856-1-minda.chen@starfivetech.com>
References: <20260529020530.16856-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::6) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0862:EE_
X-MS-Office365-Filtering-Correlation-Id: 32679644-eb79-4528-2fd1-08debd26c895
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|52116014|376014|38350700014|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	okxCq6jxNV7DLGwDjpV+rJh39Wp+BmDLaY04QD7O5vfgJoiIWb4W/cUyEME0q+GFHQH2wkKRUx/qQNqvg1cGIWV4X4HE0d7Myp5HMdMZ8ifgV3+Tk6j0gFMQR1+JHOcO1EtHBSYqhGm/6MdN4BiAMNLbWumT82TFnrueWCsMl+eRXXw6k8vDi4K4omQxSWBgn2Q6Y4P/qlIFbenlx/lNvkSk62P9sSk/g4WxvVjYGwIsZifTqY5XhcKwpVvO9YYhsuWjfxV3XTv2EHUG9Orn9whTz9oEvqOSgdzXzi4EVeEAjPn3D39y0bZ+7rz5AvYbSaEoxGCh1OxItZRHlIxqiZQAf6Ey/BZxQ91ufmSfAhoiDNxsILF99nDMiyO/A7ETHqhSO0zZIfe4+dqvbvLw3CC6gLSW/fOpsvS8McAWtaAxmQZx1tD1On6hn4/mqeswmbveBXun2JgQerdH1n0XaBFRijt66K+XrtO0xuSCgyvZ3EBQu2sj2ILFF0Pj1QorOib+9/XUwRJTe6IU7P2eo+zaLCWNH5bVI2k12rtpO0pvxSYsiwXQy4SDX5BNLW9Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(376014)(38350700014)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eKwvwwe36BKA6aBRLDj1SCfXiqkM71LQtaaRLhzC7GpvQzcUS8ehiK6mEXZK?=
 =?us-ascii?Q?XIkweE+roHbSmbsjqW33OeygBvuJErT0pRU6U3g92qajoQGcDRMl/1mNSqne?=
 =?us-ascii?Q?BVSiRMQPQTvGr1O+ETwlKz1AothS1EA96TGMdWDo8CFlT9f3fSLhoIgRmbkr?=
 =?us-ascii?Q?z7bRA5giP7Y37Dxc1aOPM7jkt05oR9bgLGUz6yRnxcvWMDphs27gcPEQ0tWz?=
 =?us-ascii?Q?8I+kSlXqPymmknA0DGDTLDK7w4Un0KIHR9nH708FW2zJRM05zwz9+H64eOkX?=
 =?us-ascii?Q?Ezmu7P/kGxSuUE27IQHu5ABb30EaBhuApL+HbfKLXDmyS6DBsF7kAdwR0qOI?=
 =?us-ascii?Q?pelbmGJbsGkccinDI1uvBeWkcAEVpiKGF1az2pyUrKblW4G/8lyyZMK4peON?=
 =?us-ascii?Q?OLLIZvG0K4wAmpxh43y6Yvka4utY0aNCxZ3/PnZml7imx/42BPltvc0PCsyp?=
 =?us-ascii?Q?BtrgugfXaDbh+eH2Oo1LxYYHq9gDlhypUgc8TlqBj90S+Q5h3NCxxA8+kXk3?=
 =?us-ascii?Q?DZS/dCkpfVBjQ5HEP9lnNSw92pbA3n4Bje1yssEr1/BUwVNLqKQVB+UeRGoG?=
 =?us-ascii?Q?wK1j9aLviKchtoLbWbhMX7+UWinQwsmBb5EMFzd0ib+pRV5EjFyGuNt4UM6o?=
 =?us-ascii?Q?Mjn1zP+rruxoKmYBV5te0Wrb1EylFKHyqhzx1n2S+X/HZ8FxwMsOE1lF1KGU?=
 =?us-ascii?Q?AWyQyulI0VFSj0fl1/W1sNwxt5p8ySdHV71XKh9RCikzmnBDOXHNUiN64g7K?=
 =?us-ascii?Q?jZzOr7wRugfUk+Vreb0RLMP/Ykaac4eU7oib1LNr/vsTSDF1iCXb5dPcGYqJ?=
 =?us-ascii?Q?ObyrZyB8kFR5IeKEq+ixYi5tRJJYHI+OgLeLXeTmTIyx09L+e+9yiZ5kOCjx?=
 =?us-ascii?Q?n1Y11X3TZ/ffD4lslyb7c/k0PLYnUgZqxlLzUxZ95if0/arJx6fq/3zajb2O?=
 =?us-ascii?Q?W1028HUGqweIV/NutLEUIT4RXbU92Ppw7UV5RF1I5YX2OIXLu+J8KPywIdtc?=
 =?us-ascii?Q?0Hbo2EmFlHZhWOfVagrFJHX9MLcUNuy53oUV905+Xgp195onIg8Q0bGcTtaF?=
 =?us-ascii?Q?1f1+8UGuWbXIcxg2bY3Hu9KP0Fafr2Y+8A0rOn+i18wCm3ETRpGs4A3O41KG?=
 =?us-ascii?Q?WyOBAdTAtEZTJFgM+5dT21KSauLSi58Z7PLrjY0+ZFyGvxvVmp54FWICpMPV?=
 =?us-ascii?Q?sSYDN1iOjErgrjqdny8+yZQXC1Iae9VbFVNkVnSvD4wKUECWh7qPwtWWQ8jP?=
 =?us-ascii?Q?0l6Y6/8p7Fxca7Jj7O+7hNGlfh0gVJr54a8OiCJLWEBlu7gMA9w5H9f7Z3ZD?=
 =?us-ascii?Q?Yt+RkmR4I87+H1CbhBoYDX2v5Arc9CGVJ14+bumRYtnC2WIkV9O63RSfPns4?=
 =?us-ascii?Q?5P73oUDUXsT7EB7bct8T90jIZwIMwrtgoo89uAHvmM/PnSvDSUoNbtSZiEQZ?=
 =?us-ascii?Q?/Ym5TlMmejhi8HEeYxArNXvlsjZISqOhKB5KtthhldG4X+iVE5DHJmZmn5aB?=
 =?us-ascii?Q?OAdQm8sBm3snIdlIWZ+7pXaboRls7ugWX8abvpZbhQkLwWYBG8FyXEBiIM4h?=
 =?us-ascii?Q?4y7HIKjQWIu9jpuLc3jflzWMp9vBKKJy3j/MhM/ozCrm+skcJeL7x269iBAq?=
 =?us-ascii?Q?fmHkHIc72kfsJUXNq+Izr56F4+tZUMta6pSOVZsnNwQoTy+qRGHISShUbuGC?=
 =?us-ascii?Q?rQ0faDuZQczuVXDweVrH0zrKZIVAmVdO4Z/tPLhPprHoGciu9O6kTdsTzrOJ?=
 =?us-ascii?Q?IlE6HEsVVTzYjT54TeDiYUXjHKpi/f0=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32679644-eb79-4528-2fd1-08debd26c895
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 02:05:40.5909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8LHyHUfhUXt8V1DqPVE5ZpCtnJe4FpAgCoGOOrgm2eD+uOu98PYYFaN49gOJn0n+lYJephRRHCt3xfJl4JwdxipReP9a7ex2VzH6nk7qBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0862
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-292970-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.934];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:mid,starfivetech.com:email,lunn.ch:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6F9955FD2E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add YT8522 100M RMII ethernet PHY base driver support, including
PHY ID and base config init function.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/motorcomm.c | 49 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index dcba50007451..a202015d3869 100644
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
@@ -1842,6 +1850,36 @@ static int yt8531_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int yt8522_config_init(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
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
+	if (device_property_read_bool(dev, "motorcomm,auto-sleep-disabled")) {
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
@@ -3051,6 +3089,14 @@ static struct phy_driver motorcomm_phy_drvs[] = {
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
@@ -3111,6 +3157,7 @@ MODULE_LICENSE("GPL");
 static const struct mdio_device_id __maybe_unused motorcomm_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8511) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8521) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8522) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531S) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8821) },
-- 
2.17.1


