Return-Path: <netdev+bounces-280351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNO7DJ2K6Gk6LgIAu9opvQ
	(envelope-from <netdev+bounces-280351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:45:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F0E4439CC
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0E09301ECD7
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E92D3C1966;
	Wed, 22 Apr 2026 08:33:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2108.outbound.protection.partner.outlook.cn [139.219.17.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4343C1401;
	Wed, 22 Apr 2026 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776846808; cv=fail; b=QPsRdW+qfOppQ4+I+Tt5HNX+PlyAmujtnQ4ovEk0a7J6yxu2Q2c8FaFrIJqKFsjZGevjR1i26aReoYgnAFCOY91NNTp4VpZhTz/YmbihAU0z9kUhdXycf3QSgZmX0eZYrfJv2mJ1K/UhOw/iHXEFW/3VbF9jyzAltUfge4of3uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776846808; c=relaxed/simple;
	bh=SoHOYh6JvmQ8VgSCITGbvKsQgso0BAL9T++82glg1tQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qVWr6aI/JZpXZB9qoZPsqqEcdF3gHcAZUT357TDkPVSwgsvB1y2ObDVV4foxl9XEmmky2Ti7LKq6k+/V6RBnKNzybm/FWg4iXP9mRufH4FfxTyPuZrECH3diuCeZyOx0R9Pt2AIHs8nZo2M9VeUjnzt3YXNQ/5U2Zji5uxHinc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wc5Bcr4b+nDvk5WEYBGMUqGsFWzJqv6G0zfR/Nvy0er9p+L3CGoZ4+oRmMZa/mqT6f3GveECA0qfWPSvRV/lFKtNFZBhdFZlj4t+q8/afnxQZouhkSv+tGpjf9SwWYCj/eZFu3VTyGQV6BykKnDfXm91mM+7QJwyZZZzUvi8hZnUvqTQmWPlVd0Rvp078Z7TwfEOq8fAWjUQ/Bri3dlWNqEEx79SFBfFl6JuMGa9JnII3bQZGmrs+Tyfv7YG716SMo0wooq6Va8GDXe5KwaOZTIfdBpKnskoCVuhKJIRzm5JDzczmx5MU4mcwP8FDE/uHX61SI5n2H1ayreQb5Sq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtCw9m5Lw7SahJV2VRPGAIx8FTrSNba9hNxj5ZuPJp0=;
 b=WeAW+vE2TZRwEyaKzUFM65dn/KF2whNcAsg34DSBlgqwi2N3nT7C1sgsszX25/OV8VZvawGZRBTtyCqG8sS38nAO9or1ITdnmQHyeU/KBoiwVXEe0TbXdBNhMzdZihlRmbrbhYrxxk13T4U8OXhG7tLZRBcc/Uk4T6GJCPIntidbHoo4O558TbTMHpWzMJl8njD++rNxu4eOl3UtWyb5ZOKezThQhnjaPaiZ0KKe7SWT4m/02Gt4HwGcuYmoB0koAPvd6OHl9KNguheZCTHoCk2Um8pfetg/awNIeE16bCM5liP5aPPgMR21oKZ92Ep7diQmdDsuZAjABt/Clh2WIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::18) by SH0PR01MB0554.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 22 Apr
 2026 08:33:08 +0000
Received: from SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn
 ([fe80::8f25:1579:34a0:8569]) by
 SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn ([fe80::8f25:1579:34a0:8569%5])
 with mapi id 15.20.9769.046; Wed, 22 Apr 2026 08:33:08 +0000
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
Subject: [net-next v2 3/3] net: phy: motorcomm: Add YT8522 100M RMII PHY support
Date: Wed, 22 Apr 2026 16:32:55 +0800
Message-Id: <20260422083255.29692-4-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260422083255.29692-1-minda.chen@starfivetech.com>
References: <20260422083255.29692-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0028.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::18) To SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0858:EE_|SH0PR01MB0554:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c10a8a0-19a9-453f-c91b-08dea049c7d9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	xcuRlmITrnsm1BzTbIAgcv/qUmaKuHJdHolRkO1zofXi5OzLmXICEqGbT0Fiox6hcoQ4L12nuzIAYsE9UQ2b7EqpMe+2hyfimrN0OSWd7htWphCjVOfn4cDOh+FyvuoFue8ftgWMfrxTdUmTb0ZsORuI5iv3E6jxQ12yoPNRIYXEnmaltMS1pXOc0qfNXovu8HnEK/Z3iHPVRyx8P8BniKjds+V4F7Y1hQOKbAezaUpTihcop4qASsu5zstu/vzv3xsmIz6LwgRCqHSlSXWUpGGCcWGjaj40M4NmN7LB4ZuoH7C+5BbMqlCvoHyuZpF32RyJXqe5nQ4n2o5EDRcTeLsFCgBFvFMWb04MMEbuoNjiiNfTpIJZ4M8iP6zYD5Urxi2MBJQaND8Yqq3jpgvgtN9hXQfTLNAsfb25hkr8zkrPiVIB60fJbpvM3hDpqphfCgS7GRZ1q2LtJV7G3paoM7KCp2flqbbfXrpRpSImZqHK2t72x9G8dC0NdS0HdXNDLyJZM7A+8g0K0Gw7yTK4LoKniOYobT2AEbMcRgOauVgrO8Y0X2r0j2hXGJpj6uRfl0vmlOyd5dJ448M4sEttqg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(18002099003)(22082099003)(56012099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sndNXccq+meoV/qWmCtbPlymEDzzQpdPvXNekmVFdqftOMx18Bp2G7u1nvDT?=
 =?us-ascii?Q?L9akgCqM2l140AQ2oaMDxX6uY11TIuID/aMGLNuUsJOG68TFHoc5pnhlu5fE?=
 =?us-ascii?Q?hq8SQUwq03IB9LYGCY5w3Cx3HoP4b79oaknayPbZRjm7cE8sOGjo2nNsALx0?=
 =?us-ascii?Q?aWo6QcBLm+ZoGCq/qoUd/04yZwhfq472cWDxXOPxlce1nMsi3vamWhzoPF9r?=
 =?us-ascii?Q?dL6DwcNqz3xjAcDxO40iLyMOlccmCayTJf2JCrTaL5r8eVBbd8L14nwfyw1S?=
 =?us-ascii?Q?M0cYW/eNTjIJw4SGA+Jl5YalFfPkw5CCk4X45d/58SvwQmZm3nD2SsOiqcyU?=
 =?us-ascii?Q?BS8YRYgQJHcwAAVBao75ANXVsSJvCuGlYLEF7mi8CLcRszl4e7qh3Rfg4BIV?=
 =?us-ascii?Q?GeqPO9o/UGkKx5bJWl44AV37vLcivQZ+ETmjwLbFaAeZwHc7aUzCViWXgHxv?=
 =?us-ascii?Q?afU8C0miOwnhX03EMRpxFPi4inHN6PmY6xbr04bc1KVdQoJPb2R+RR2GnHmm?=
 =?us-ascii?Q?Kw7CWTDIe6TK134nUyptsK9LmeoDRHE2okjvD7cD1AOdG13Ma7Yrob1T9suE?=
 =?us-ascii?Q?2VHHolrLXkmoZuuC7UWi5c7RbIXBg8KxWdpPIPlcY3n/HfrdsVa1f8KS1KJu?=
 =?us-ascii?Q?X+Hh+4+uLGI5KD9zdQz6kucu5jLd7GEQG/2ThAeilePjMH5ORoZ/yzFqFJj8?=
 =?us-ascii?Q?ZMj5ZvT8v5NZ2J+9nFTu+G/hyv2PO/cvAxJx7DRkwLNkvdgtDqoTbySx+ZR2?=
 =?us-ascii?Q?7GPVrxDTFkbzxwvDbpglhS9sIH+txcnvwUYH7dpxlEssy1LcexjznizTlNtw?=
 =?us-ascii?Q?LT7dFbs7NAoWZHPhJYJ4MMk6vHOG3nvvYPg+irpkKiJNd0B268Kw7w8bWeEZ?=
 =?us-ascii?Q?yrOLyhWB2UuyRi7+rKbkDculV4+Tc5psJY/eWBBZjrNJDYkC/GE8N10ZRFwl?=
 =?us-ascii?Q?3b4vtIlMHpezF4qFl/1ncq+ncM1/yO1Zqf46itWzAbg06I9ZoaPH3nLbdKa1?=
 =?us-ascii?Q?rZqKD1H/oJDqq8EJVZBO4ZWKiQM+Vj6lcRLPjRDvlRg72T/mPqwX0PQf+xMS?=
 =?us-ascii?Q?Rghuue+Ltc4C5kl6HrmcUE0BdDMgHHZlfwFvxnMjxg5fwuPrgsoj2Bw6IWU/?=
 =?us-ascii?Q?YsKMS4I4BpRPnla+U/Yxoh8pAouzFVZykUifXLGssjJJgXQN34fx/lzS82/E?=
 =?us-ascii?Q?Dc2Oz4Itmvt5OmgFYx5Gqh4NkFZHJHIgI4vsYpm/0RrDaXKTsEjTyYN1X9Gx?=
 =?us-ascii?Q?bQprU5xMpEYi+4SblHKjYf2l2URjOLQZMV6wGikCfYZES54xaOw7nyEVb5uQ?=
 =?us-ascii?Q?F09tEZOEbxFwpl18PC9cTbyCEnOriDqKgOYG21OR46ALU+ffb2PN6qIp52C6?=
 =?us-ascii?Q?x0Lexpv4SjuUoURdTmnNZjkm4oPNTrI7BhY6ISjsw6kwdPuD+t5IgCJfFpvj?=
 =?us-ascii?Q?XFhbhIQhTkTK5miRWgxYwdNwID462LPEfrOl/7L1I2Ft7wz4o7XKrbDbQcST?=
 =?us-ascii?Q?Vky7VAb8RZ7+S+08UidWOAPslo001sXT9b8ddF82AG/jvTodTV4TL/hNfBU0?=
 =?us-ascii?Q?CaX3NnFQSqo7A50aybknIFpduQAhyVbh00zI1oLpt3/RCQuQDuvqhH4/D0lb?=
 =?us-ascii?Q?cA+Ecboamv/jUNFavTb6V9ZqXIJy9FndOq4gmRjqo08475n7pQ/5btqz8zW2?=
 =?us-ascii?Q?pVIC694l12RYTJnO4ccT8EW5UnoVWlD0dXNxiv7rAfndue4eS4yh+0Z0gP8e?=
 =?us-ascii?Q?Bx9LDi6/zgJrS2kTk2aRFWdOI/I5Mb0=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c10a8a0-19a9-453f-c91b-08dea049c7d9
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 08:33:08.0515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJxmq9YowV+ge64ugqevvpw9xHbjPCeRhqPzT8TnRXzz6mrMJ8iOhLY1Ds12y/XTN6nlc9kP2b1XtFk3h84QMnWyNauhBJ+3PHuFffDboWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0554
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-280351-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,motor-comm.com:email,starfivetech.com:mid,starfivetech.com:email]
X-Rspamd-Queue-Id: 28F0E4439CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


