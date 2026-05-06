Return-Path: <netdev+bounces-284898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIWyJ8Zc+2nbaAMAu9opvQ
	(envelope-from <netdev+bounces-284898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:22:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD134DD1BB
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36FA5304E5A5
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB4C48C417;
	Wed,  6 May 2026 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WGU3bVKq"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013060.outbound.protection.outlook.com [40.107.159.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4302E48C401;
	Wed,  6 May 2026 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080567; cv=fail; b=MBy80odnUeF9MfeUByjNVEWej3d7MT89r7gSm0ZdoIVAOhxGDURsWhKeKZmviWDloAyfAWHfMzk3EXP10KWTfuDu10JwfL1YcKELyKZ/i9T3r2bKJf6zsx1PP3NJXdorFNJeXQ+kSwzjfrssUD0KU2NIx364TgFhdUCgdCB8p7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080567; c=relaxed/simple;
	bh=LQFbDNk6mMmNYeqZzIwIxbQKRNrIjxUFLu1GoEB/OtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J2/WWzYNiXQEoufbR9XpzGQMTbyWOZEwp6aUbiUnnjZ9LgJ2RKaVR4fD/x/n7EqIgm5lrlzSVDzDnjlKKaepaD2LDjpZ2sdooMEgzxyBFoyj/nKEu5L02mmzzcprAY+KXC3oOh4qAHhqzyZa8KlzN3HPPCvw6XqSFU4VwrbT/h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WGU3bVKq; arc=fail smtp.client-ip=40.107.159.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMdNYqj1BG+LzZO2ONFP6GeZ/zTouG1J4dPwmUNycoQqnRmG872v7nVqaxwGZueBEoTMhZcZYl/J/2VgHY0IADJhSCH/+eTuxPqX5fAkBKeIu0VOerYL7J/W8DHVFU5RjVhakyaQ7Sd8zfHBCKUJtGytexIUsLNdDczAOduVRsHq0yNnYWOo861GJOc9RmFYY0izGnjvBV0sM3hJJbwRUKfA0dIZc+bZVmjUHhuZrHDH+MZIq2mAqmBYSQ5ol8B0+ngN4kE/kd+pKEp2u0teFi8yx6zFktXUyVy1iJDjHr3pn3+6gpZlF0favUfMFAcIYMDXhfj50czzPi0mm6IbSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a172WUJDuWFwoEgf+AOM296+IiieUCeMrYi2HnQt6vE=;
 b=Zedepj+bWphUNalI2mjB1QxW2ckNXumyyztk+MCIFs1ULnL+8isIu1J+YWuWaykM+CsMgxyboSacI/acVUk4D6sTRUV3RaSBQRcTE8QUh/J8eT8MEZ47H605HA/BG+Vwt3x56ZFaIx7/wHkA6x94jSpmMBxzjPYUt9olDqK4xygBZ63rKOqKQpxW106UoO3PEkVyC6IG8EIbikFokN8XOEL/eR6//NVQ/LfjjbT85KMXlcw1qOto+dfLbWcO2GbwVhUNAWVPVvsh+lAuE7t/1MrQ6jG+SDv0SiPqd8ni/WXvB6oz9vPM/J8PvMLc8NeoixpaRBt5CaPjIVaUdcB4jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a172WUJDuWFwoEgf+AOM296+IiieUCeMrYi2HnQt6vE=;
 b=WGU3bVKqM7BS/lr1/dUx2d0R3/h4wwEFAUdNs+zkeaKXEnIEW2JZOsymwuxWUS0/R6i2P4ym+LC8BPM4/GrTSzAkW82vEx1Bx38ZF9Lnhe5UTZD49g6nB8O+0C5UczAm3P75fZVjB12lIfd8uww1s/YHx9bnTXkv1J6wUSvGHAkcfXsSf+HCKpkEdyYIHAgi7HeOykKR1UG9SZj60kexhis6vPL38GgZ01ZxEdhR7uIt+6nWm6gF9LGYLNdBQSDWsibL2JB1qkiVuzDpYo6gAuqlEHAKmIP5mdn3adIklmHPlv9NSKpVJGmMlccVhU7HJAy28cfMO1HvzBwqZddRAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by PA1PR04MB10626.eurprd04.prod.outlook.com
 (2603:10a6:102:48e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 15:15:58 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 15:15:58 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 01/13] dpaa2-switch: add LAG configuration API
Date: Wed,  6 May 2026 18:15:28 +0300
Message-Id: <20260506151540.1242997-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::12) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|PA1PR04MB10626:EE_
X-MS-Office365-Filtering-Correlation-Id: db0435a2-72df-4cb2-0d22-08deab826028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CF2UhSldU1dLegOWP7EhfUk5GCxZknr1wbhFKJ9V8mzqpIbwNOMXuyXq8fQCWzPv+eLKFVNYiFGyskacl2KEd0FHL7vuNX0sxYPSbAw+UJG+2Uzb7xTGXdneqzLu3KpIqv117ga725o4b4vPwN75VrC1QZl7v+b2L62q6SUyvsgw4eIa9uAQBD9Fyjya5C2K/eQ9/Yycayps/mJMYNb/4orTzkvYVYZ0erf1eeELFcoksxPQ/ShMLrVSb+foczoiG9FK7PXMoh+gN4pvYHM6faqbeUEXnhHTPRR+6pEXy3Nv8vb4JsXAXmDLfXaoSnw7tL1ZyqmUXbAXDzNhXpAkN492vax4Z3njNTL2loSRncSyqMwWZgJa2/TdHFZHe79Zg0f01MZITZjVkYdkBNV3hSDND6Bwe4v4kcrVKVbjeymXRVDr8Rk2zIuwB271c/80YsMfjnp7nxWmPuVzWgzRXREYF57ZEwOw2W3yFsoUrKZRODjSXOJ3aArs9T1zPn2TnSHo+dEGyk8GMhmWxdOaHbo9nXYRL85LmSjh17FsGXUrrMLRqOrtTebXKRVmDKJmAgjW5xGJaYEnQYpM/Nn9G1x+9bOvrkjQPiz+4TaedqPOzqdxbfsan7XWbvCod8AVCaVwkR7ONxkXOt8DBb+ZbxT3+/E771uT7WEYIS+nQ2G8nZj5REJYhrghjQQsvjnA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JYCSm0lvDGzZU+JjZvDPBa9CTTJPqKQtf9WtBtL48SMbKXbvodd3WUZGLrk0?=
 =?us-ascii?Q?TicaL72h6Li3sjQhoX718OHBFHhMDexRF52VPttg06Er+WW3V+ziwm3Gf9HK?=
 =?us-ascii?Q?7XYHhevE3wprBeKv1JJBngWhELSHaZjYPfBb/CCX9ktfwt0QEFixeGXKwm2t?=
 =?us-ascii?Q?bGMv8aUkV1Rg0dDvNYKq/l6OWZp6H1Ge2E5GDV4thFXw7weLv9dAWhSSURz4?=
 =?us-ascii?Q?E00WvcGngVylTgKOxprp5qjYjpkzxTkV9JDOX7tKPMInNxTAQBgaX2qqQaDO?=
 =?us-ascii?Q?py04Y+nH2H7LHeJ3hVeokxg0cHZEhR2TkRl2Gky3UOrUXvbd4v7e8XG47af/?=
 =?us-ascii?Q?8BXdMQS40BNUuPp+2GSByVthSatbDVlIZnSqMej+Wez+0b4XDR4oy2tMtYR4?=
 =?us-ascii?Q?k0SNnxe3gfMZMHJEjKfWCX4UdShieEQ0y/xgnf2VhVJFz5uQrX0LoaU4wJD0?=
 =?us-ascii?Q?BGV1Z/Q2skLiYz+8ms8d7pNrupdu/9fvfChdA2PsGcl+keKCQXqFShd10kxn?=
 =?us-ascii?Q?H1qjLf/nCORbBdVgtYFklrMf9oo40q6UUnLaw2zG/2N1Nds4j3459pJf0DO6?=
 =?us-ascii?Q?v7HBcP/Yth8z+FegpZqnWseFRcM6lE2BcP9CJX/kHGFV3jXTR38nrdIhgK3W?=
 =?us-ascii?Q?to8XyDDidRylvaPNgLK2XZYVAAL4rx8QSEc9bouSaeHXAXNepwh50os3i4kn?=
 =?us-ascii?Q?BU4Kw9WuoUglcHmta+yfUHvdadl1wuITI8JUIypV2PFGxD8xsijcPxM0xKPX?=
 =?us-ascii?Q?qhXbDPYGlEHo3V8XGvnGQZpnn7VA86Kt5SwsD3kUtPvcLDIIp3QgrmbcAROW?=
 =?us-ascii?Q?Kq4jdZzKOz6LFHylmpvNeuTFQHkE2yykVMZyWMM1nGmysfdGXInla8vi8KuW?=
 =?us-ascii?Q?CTfd6aoBdAwCzI7FC5Sy30puJcbjkPxbtSoEwT6pDXOdN/JOnH3Wt1y+D215?=
 =?us-ascii?Q?vf18hv/GA0zNN9V6N8zTJfCNftyEP5M5/5o0uGczrkhXBf44b1WeeDpwJIws?=
 =?us-ascii?Q?mtj9LQ5fVIRvicUz0/yzgQAvmKRISP2Yo6ZFHLYQ0SAnyIMyaZi9r3AUtoNN?=
 =?us-ascii?Q?PJQW4uO8jTJ8hLGSO0q1WAZGX0Fh+siHPGQzipFrtqt6inlqoL5ugjbnFAYb?=
 =?us-ascii?Q?VLGJ/f1GSF8JYRunH2jTN6+BHRAQbTUegSzpmAWFSDAZYzryfVGFIEXQlay5?=
 =?us-ascii?Q?FIq3o/OO5g4iOV0V64Eq66hOW1bdNIaixmruzWMWv5m5zzeYazxE+8aAr0vQ?=
 =?us-ascii?Q?2PBQI9uBwVrdwAkwSOl+hH/gARgzYrW70nXW/x2YtkEwbrCgWqqgqU6Srzec?=
 =?us-ascii?Q?q0ueizJ08tyysVo/yvz7l6qDebK+Wf7Wuht/BwagjLJW+jx6G47rgSOcqUCb?=
 =?us-ascii?Q?CLth/Z74R0P4yPLSRluqz/u/8M0tB9l7LeZKkNJd/QIotJetvjLXgMC5WQAS?=
 =?us-ascii?Q?V9RK1IXqvB5bViaFGxOTHut+mr69WRRuhVrc/7qbfehAsalJ87g6DerKgwZN?=
 =?us-ascii?Q?qYa0hfFhRvS60Rq/hvbtGNMOxXM00WX5RBj2dE2/437Ntgsg5du1JBxGGKdN?=
 =?us-ascii?Q?HoiYMLlr2b7Jf/wso6PqsVoAWtdmQKlrswT9rsJNvtqVlWm/u8xy8WUwfcfV?=
 =?us-ascii?Q?XX85DiAknPfi5SdSztryQZTjXjfjNC317gc6hzptLKTi7HxUIFjU9QB1ftR4?=
 =?us-ascii?Q?8iYlWcPaeTBC58wAYM94FfUEP+MzJqxD2kOigEh3acLGwkbtle3ePpdeKkx+?=
 =?us-ascii?Q?toBy84b4Iw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0435a2-72df-4cb2-0d22-08deab826028
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:15:58.1686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmZAoveSoKj2OaaQ1v7RmPAe6SQ9sH66opgYFSob+7VDOLCc6YzEcFlgnq3D89bfA6774SZ6zS3eohcXKpgyxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10626
X-Rspamd-Queue-Id: 8CD134DD1BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-284898-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Add the necessary APIs to configure and control the LAG support on the
DPAA2 switch object.
 - The dpsw_lag_set() function will be used to either verify that a LAG
 configuration can be support or to actually apply it in HW.
 - The dpsw_if_set_lag_state() will get used in the next patches to
 change the per port LAG state of a specific DPSW interface.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
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


