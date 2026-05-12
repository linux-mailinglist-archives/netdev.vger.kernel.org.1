Return-Path: <netdev+bounces-287152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAWjOegpA2qw1AEAu9opvQ
	(envelope-from <netdev+bounces-287152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:23:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D67521181
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DAFE930354FA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FC93905E0;
	Tue, 12 May 2026 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GYT/z3GF"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F95349CEA;
	Tue, 12 May 2026 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591774; cv=fail; b=E+biFOSAuXaFLJsc4ca9O77iuxckoshP/fb9zxdlXNJ7Ytmp7QpD/zbjC9ZGCTg4Q3ymBdxieOuaeM8B/Obmb32BPAZmXBFBRiqMDjh6SfTaivLLyUksxEO+10g97E2UwFOHbIJgAjzYMjTaX06/woeHNZL5fxTEdr0uTVF1uwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591774; c=relaxed/simple;
	bh=6YdE/Cq/3iZXtr485PTu500rVbVn2zhbxnjFAYIlfAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=McBX8MeV5AstX7yu3+ecrMDJ3AmcRrR1ZxyD/u8jt7CTFEAADnIefDuIT2IcwzYIGd2GAwcpMAPH6Ssy5fxYrlsDmyL0M7Z9KQmuNNdh+AqoVsogysSMtSi8x8XVq39olIGPfRzpB0oRvKBclgavhhLRcg9cuueK7WkUw09uPV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GYT/z3GF; arc=fail smtp.client-ip=40.107.130.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpl8+Yuiu//QP1rvtho/MO/+4ywOfO+jhJE/15QTwLBdOp5wZ6ENJFqhRTOC6pvA7xHin0WHQiBUB2K9EDslpfV2poY9BaGzRiazgOEbzntnFbhMpazbkIuFS98+AbFzPoi355r1Jmixt+u5opDsUeTM0Uj4j1fYylDyTintoiWRrGwRmz9Rk6g52XVYqbCryIoJ9kUKs3sjwGtBLBA4Wzy1O2RcDDl/VwT0kRfg0fdAZ0D6kDfMRxV5KtzvuaoKZXOrz3BY236YmgnmSVqITB5Sqyf10SfT0KxH5FQWVk+SGamPEYuDdQGieuc7erwR4bYPRufBUYdf9ql5UOwwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1FuldmkR5jQOm4yucI2Ks105du63W6rm0kxP2DzKds=;
 b=rx8XKBO8Ng1jQWHC7Ywvcsz6QtYBwvgDV0O9P8aFVCTbBnMMs1chm6aUgrUNxnKfeFOGPGA4MlYMzePmP36grEamEYLzbr46m0dCRBVgfza91Xzv7GbWmNvfNGRynRtQcv7yMD6b0YgyrJ4ImMkVJZhHCQIpKfBjDMg9+/S89Lfoxt39LMQW7iX8gEclpVnAFVMdb6Xd+xNkdG6lim53U1NT8fLALiMVjkn7XQx3j7X33IyaOOVafQeScLAzwVUJSUjDYKtjWdwBuWpTq4iNoRpMkohNHt2PMLgcPRVYYBSY2Cr77D3K1426ohRfHkA/JWBOAuOv7vwCWFsiWSZ0XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1FuldmkR5jQOm4yucI2Ks105du63W6rm0kxP2DzKds=;
 b=GYT/z3GFUJqdNqxoa2A1ZmUkVWlhKvvMemv4YCvmju5PcFFLPIAjI5+3Yhp79+xRartOkBos5axZvmVt1/9GhQRjTu4tcAwM/ckbplsQXjFM7lkWHarrrdXY1WGrMYZLmNe/q4N45HDH56fBazWpUYCWp6CDnnYqLuu1RtBZwghJZPOaQZjhc3E98UUYwRlYRKPaAaMNnTo5FmvegJnOagWNW4s1XDU9X9bVr6NA8GIS8uso0XjovZC8lXLSsaVF2pCFwHuz02WchMtJ4b+yYqfPew3vMhQoUduU+2XFBvzpkiLJHX/2so2dhpW/Qodu0nuuecFAQZbddN4Zeb0Mxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21) by DBBPR04MB7657.eurprd04.prod.outlook.com
 (2603:10a6:10:1f5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 13:16:09 +0000
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3]) by PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 13:16:09 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 01/13] dpaa2-switch: add LAG configuration API
Date: Tue, 12 May 2026 16:15:42 +0300
Message-Id: <20260512131554.952971-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512131554.952971-1-ioana.ciornei@nxp.com>
References: <20260512131554.952971-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0185.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::22) To PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB11508:EE_|DBBPR04MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: b22bf355-9d3e-42a5-e285-08deb028a1f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	whxp3zEXzuZVPvZcU4iqsyF6zw9/ZxSFjNOz0fFZRnRiAAAbW65rqWjGimjKCOkn8pBwCDZQOqJQ1zY5j+eaoeA7gojtGnGbUFqX3RU937FEomsUSISMHpDiPA4YrdO1s3GKzwg8jvaja3s1MfphVLsZR6Lj8HvT4azqLakdzA6BqP/Ztz7q1v/3KlZXvMDW6QdkPmCOTYuxalOcCB4CAj4ZHgoO2f8CbeXk9CTSLCixgz9zVvV7KrKtyw/mHHCIsLBNWMECANfO7qxOeDJF2Re1ZzoZYnxxhfGuhmfkvB7gtXqmZqW51jejnAGpw5ggj9DvyRlaQVWXPSkxVUJO704oApR9Ots4Y2nze72P0qQhK1xjmF0unBXKb/iCBNJM96cukNk6jDjclSdY1pUSJiOEDOOxAmcb8qUkTMe5rtUA0k5SxL7n00OLYFQfFu8P90cZ9Z4/3TZXs+kvelWezbV2nFlvY+s9ZASOgvx8EpmValceIKAMhDFYgxCOwho36FBJZ9F5DE7AtIcZsu4hQk1cXUw/F50aXldFaCGFDPI71/tUhGnrw1U0VsS5dvboniK4Ig6QKv9QiyczI7I14r6EUZtCCkXpHN3hsVZDNNojhVE20BE5iYAkQn+HbcMe4e/ynIjFx79A0kxKFzsfaBDz03u2+NenDc+VjsXFVVayexGu2F8mqwTfM/Vd2aW4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR04MB11508.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(56012099003)(11063799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+9VTfw4eIOhehqyxban9K0lygMVrgiJmb8Fb31b257iqF73VWwUZ0ol3zo0y?=
 =?us-ascii?Q?3qWoXsjlA+BMvR4/E3+65jA6I4elOR8nzWxZ7LK/lvbV5bmPltkz0+GTVFgX?=
 =?us-ascii?Q?Lf5LSxM2PrNurspvejmEx+v7RQT501cV94I+YZp3mlYl2gppxD+ujyYCMdUh?=
 =?us-ascii?Q?dp0sr4ww9lJx+oFHveCyq3SWtyaR+wBOSwjM8xkSDqlMzmWrc/Hlo+h2/0W5?=
 =?us-ascii?Q?LQmMIZHBJ4HckuXd3MZpAWCKlMhjSr7LbmVzFKIhkrmZ9kijvljpT6V9QlO/?=
 =?us-ascii?Q?ixEiR9iEHheakTKqk8JdCWZHYsA3l/D1T0HHX6SFMCGptS9Pims3mt7nEDYe?=
 =?us-ascii?Q?xicxrDHvamK1Bk4q2TOzGMdjRXrRhwDI13jfsM+SmaN837smgmSECA8IxjK2?=
 =?us-ascii?Q?/9Sc8Hu2OZ8iQC7Lfpmp+iF3AwkJriSJJOra+Tzdh4mHZcEYRjLEM4Bilx2i?=
 =?us-ascii?Q?/eW9rb6LfGze6Zr/SemRARWpX9ZaIYEFgzNkjFjWzY8TYTvJWGODl3H/UDXn?=
 =?us-ascii?Q?QY3jAMHSYJcF734985thBMBe71dGvmtT/RjdM8xPEj8KU/hSwYxG9Z+8TFhE?=
 =?us-ascii?Q?cjuui3bnD9g3GLTB+cYqYhfTVOVXquc29Qng9JDBVmK/8rkpWVOw3LhkdA+z?=
 =?us-ascii?Q?LFGVrdg2MhUqaTUcUOLiWRLxqJJjQjwNfVtPuDMzzF+C3QyQ/AYyLi54A6sJ?=
 =?us-ascii?Q?zRQK++p+OqzwYyhQTrZo2heMn2FywdcEI/JDBlU0Yv69i5UGblxv70PNDXhE?=
 =?us-ascii?Q?TgZqLsHRHi0u9PbZ6I1syiNM8YfHTiFg/6DPUsQbCtLzAkrnbyTUekGkFPJf?=
 =?us-ascii?Q?CenLIhOrY/3iu5SuwtaogwhOPvKWsf4zjyJDQG9mT7qrMe2+EGJTFAnOWivN?=
 =?us-ascii?Q?m6ZFqc/Bp4qvBqRuCIZPx9cjAXYPX+XdSNoYKXk9dX3Hrz0FFMYV7JVDMMbq?=
 =?us-ascii?Q?gfq58JGkeZB9ogKuXSMzCpy+hZZqBnmub9Sv2qQbwQ1w1oYhdZnNWhAopFfi?=
 =?us-ascii?Q?mlFEw1JFd/czi2qzmWROIVglrGJCWHjyvNET0zltKEXN/vJRmebHacQH6kSM?=
 =?us-ascii?Q?/G8dubNAoThLHefKXTa4uTAliHCyJMU3AtIQ5dkC43xX4gcr/4x8D5M03IlW?=
 =?us-ascii?Q?+aX3OHEUyuGVFNrUcdLYn6hS8vx35h0GbVgzPfUHtBoftC2Rv92PIvzf+Yi4?=
 =?us-ascii?Q?vKf074el1HXcpeErLA0UM1ncys+lG5XRNN4WonCPAOwNab6CIftPG/aQEmQJ?=
 =?us-ascii?Q?S0leYN7UhpnvzN+eubwRhFC7EZGzGSCidSLUZrKiZEAzR7lFAfEcBWMyH88n?=
 =?us-ascii?Q?lnay3Ra7IOnaOQbj9O+kCpWBox2vOgzTf+XhG9lGlDKis4t71ErKtX2wrUNf?=
 =?us-ascii?Q?FR12ZVHeTRSUggh8V8pUdLp680HNxn/AozzSpxycK367cHfEWMxB48nFchnR?=
 =?us-ascii?Q?BKkV9ts3O0WszyU0VW9KpPvhj1XZ1ouzgN7Hf8cy2zx8EuFu+XHgxONWAU8o?=
 =?us-ascii?Q?VOuLMejB5nQGGOggbmapg9ArrCTPRztZ01Y20Z3Nf1KphWqrxs3BsAMoTp3V?=
 =?us-ascii?Q?RZC76VwRbU8w+o5dqSpsjZxzQj803ckfMhPej6y0AHfbYRR+ESiOAARsj8Xa?=
 =?us-ascii?Q?P2eVGC1idxlcL2x6Lze7dlL1huU+NpmIqAzSabm3bNxq4NwYAccE4eANKFvu?=
 =?us-ascii?Q?JqhqR3iUsW2SbNxyA64TFmOhMT5c1FO2qBG0bb7iY1tu/3vaHNZath844V1q?=
 =?us-ascii?Q?3pR8FzNiig=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22bf355-9d3e-42a5-e285-08deb028a1f5
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB11508.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:16:09.6870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YcKsBRpeE7iMw7UgZpeWij/cBiVmwUh5G5xozHJr0LWZ2NpUlNY1N9NdxhzecTiufaJ8WXe2nhTva4iRgd2fQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7657
X-Rspamd-Queue-Id: A4D67521181
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-287152-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

Add the necessary APIs to configure and control the LAG support on the
DPAA2 switch object.
 - The dpsw_lag_set() function will be used to either verify that a LAG
 configuration can be support or to actually apply it in HW.
 - The dpsw_if_set_lag_state() will get used in the next patches to
 change the per port LAG state of a specific DPSW interface.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- none
---
 .../net/ethernet/freescale/dpaa2/dpsw-cmd.h   | 18 +++++-
 drivers/net/ethernet/freescale/dpaa2/dpsw.c   | 57 +++++++++++++++++++
 drivers/net/ethernet/freescale/dpaa2/dpsw.h   | 20 +++++++
 3 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpsw-cmd.h b/drivers/net/ethernet/freescale/dpaa2/dpsw-cmd.h
index 397d55f2bd99..9a2055c64983 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpsw-cmd.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpsw-cmd.h
@@ -12,7 +12,7 @@
 
 /* DPSW Version */
 #define DPSW_VER_MAJOR		8
-#define DPSW_VER_MINOR		9
+#define DPSW_VER_MINOR		13
 
 #define DPSW_CMD_BASE_VERSION	1
 #define DPSW_CMD_VERSION_2	2
@@ -92,11 +92,14 @@
 #define DPSW_CMDID_CTRL_IF_SET_POOLS        DPSW_CMD_ID(0x0A1)
 #define DPSW_CMDID_CTRL_IF_ENABLE           DPSW_CMD_ID(0x0A2)
 #define DPSW_CMDID_CTRL_IF_DISABLE          DPSW_CMD_ID(0x0A3)
+#define DPSW_CMDID_SET_LAG                  DPSW_CMD_V2(0x0A4)
 #define DPSW_CMDID_CTRL_IF_SET_QUEUE        DPSW_CMD_ID(0x0A6)
 
 #define DPSW_CMDID_SET_EGRESS_FLOOD         DPSW_CMD_ID(0x0AC)
 #define DPSW_CMDID_IF_SET_LEARNING_MODE     DPSW_CMD_ID(0x0AD)
 
+#define DPSW_CMDID_IF_SET_LAG_STATE         DPSW_CMD_ID(0x0B0)
+
 /* Macros for accessing command fields smaller than 1byte */
 #define DPSW_MASK(field)        \
 	GENMASK(DPSW_##field##_SHIFT + DPSW_##field##_SIZE - 1, \
@@ -552,5 +555,18 @@ struct dpsw_cmd_if_reflection {
 	/* only 2 bits from the LSB */
 	u8 filter;
 };
+
+struct dpsw_cmd_lag {
+	u8 group_id;
+	u8 num_ifs;
+	u8 pad[6];
+	u8 if_id[DPSW_MAX_LAG_IFS];
+	u8 phase;
+};
+
+struct dpsw_cmd_if_set_lag_state {
+	__le16 if_id;
+	u8 tx_enabled;
+};
 #pragma pack(pop)
 #endif /* __FSL_DPSW_CMD_H */
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpsw.c b/drivers/net/ethernet/freescale/dpaa2/dpsw.c
index ab921d75deb2..c3951a9d6e0e 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpsw.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpsw.c
@@ -1659,3 +1659,60 @@ int dpsw_if_remove_reflection(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 
 	return mc_send_command(mc_io, &cmd);
 }
+
+/**
+ * dpsw_lag_set() - Set LAG configuration
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @cfg:	pointer to LAG configuration
+ *
+ * Return:   '0' on Success; Error code otherwise.
+ */
+int dpsw_lag_set(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+		 const struct dpsw_lag_cfg *cfg)
+{
+	struct fsl_mc_command cmd = { 0 };
+	struct dpsw_cmd_lag *cmd_params;
+	int i = 0;
+
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_SET_LAG, cmd_flags, token);
+
+	cmd_params = (struct dpsw_cmd_lag *)cmd.params;
+	cmd_params->group_id = cfg->group_id;
+	cmd_params->num_ifs = cfg->num_ifs;
+	cmd_params->phase = cfg->phase;
+
+	for (i = 0; i < cfg->num_ifs; i++)
+		cmd_params->if_id[i] = cfg->if_id[i];
+
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_if_set_lag_state() - Change per port LAG state
+ * @mc_io:      Pointer to MC portal's I/O object
+ * @cmd_flags:  Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:      Token of DPSW object
+ * @if_id:      ID of the switch interface
+ * @tx_enabled: Value of the per port LAG state
+ *     - 0 if the interface will not be active as part of the LAG group
+ *     - 1 if the interface will be active in the LAG group
+ *
+ * Return:   '0' on Success; Error code otherwise.
+ */
+int dpsw_if_set_lag_state(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			  u16 if_id, u8 tx_enabled)
+{
+	struct dpsw_cmd_if_set_lag_state *cmd_params;
+	struct fsl_mc_command cmd = { 0 };
+
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_IF_SET_LAG_STATE,
+					  cmd_flags, token);
+
+	cmd_params = (struct dpsw_cmd_if_set_lag_state *)cmd.params;
+	cmd_params->if_id = cpu_to_le16(if_id);
+	cmd_params->tx_enabled = tx_enabled;
+
+	return mc_send_command(mc_io, &cmd);
+}
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpsw.h b/drivers/net/ethernet/freescale/dpaa2/dpsw.h
index b90bd363f47a..d79021ef3474 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpsw.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpsw.h
@@ -20,6 +20,8 @@ struct fsl_mc_io;
 
 #define DPSW_MAX_IF		64
 
+#define DPSW_MAX_LAG_IFS	8
+
 int dpsw_open(struct fsl_mc_io *mc_io, u32 cmd_flags, int dpsw_id, u16 *token);
 
 int dpsw_close(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
@@ -788,4 +790,22 @@ int dpsw_if_add_reflection(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 
 int dpsw_if_remove_reflection(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			      u16 if_id, const struct dpsw_reflection_cfg *cfg);
+
+/* Link Aggregation Group configuration */
+
+#define DPSW_LAG_SET_PHASE_APPLY 0
+#define DPSW_LAG_SET_PHASE_CHECK 1
+
+struct dpsw_lag_cfg {
+	u8 group_id;
+	u8 num_ifs;
+	u8 if_id[DPSW_MAX_LAG_IFS];
+	u8 phase;
+};
+
+int dpsw_lag_set(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+		 const struct dpsw_lag_cfg *cfg);
+
+int dpsw_if_set_lag_state(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			  u16 if_id, u8 tx_enabled);
 #endif /* __FSL_DPSW_H */
-- 
2.25.1


