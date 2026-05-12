Return-Path: <netdev+bounces-287159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF28D/EtA2qN1QEAu9opvQ
	(envelope-from <netdev+bounces-287159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:41:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCA45216E7
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F20E0305F325
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5031C3B100A;
	Tue, 12 May 2026 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MKXep+xm"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1023AFB1A;
	Tue, 12 May 2026 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591792; cv=fail; b=pEnbscidlY0O2iZkYSuLyVNKAQZBjr9kw2Xsc8hOKZ1993flEV5Y8TrEM5sJH6CrJUOwsAmzlzlvGPLrlc26jmiip0GMKWQNsCKkG4gKlUBaOjIehTauBTweIr+rJvl6HIASrrM0NZ/0kUMDdWS1D6cWMpLvS4ONbuuPEHXxkRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591792; c=relaxed/simple;
	bh=sFkxIAi7+xN3L3BkLDR0TnvDA8Qkb0aL4wYNxYDlC/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q9MjmBuMvbYXpL3h8ptqHL3+POey5woBMT/+czX8eoOa/dadjqzX02rBZHPdM3kopFVwYBzdzbD4uAt6Tve1T+mjmnkpIoq0+b7X+CtUwkkmgiHKlkuTyd9fwmV02ZQZ27ifQyXqX2uy1tBnDQaWoYdx9eoznNkTeadAkE0ronc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MKXep+xm; arc=fail smtp.client-ip=52.101.65.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPzqejjvbo/kxjca9SqYopL7d49S8D2YJPktNInyeETfyk1jiGKs06LnWOsWwd6LrkW9f2YQ3JlYa36djWU7eOHfcBLHkfjDiKXvz9l8ffPpN4f+TCt3n7v1AGEzJcv6afYX2+l16pply+qEJVD1IxykY/Ol4K88wG1dwPaFbAwkDmNV2sgCPIY3PtvYvvq20hhLcoPUH5u4lhjsaaAoi7d42zqoWjUdikH9Ody8Xan+eQuQdotQOe/TNZfhyTqKEahoCB8tQl4A4eJCoLHiDwVKe9hhkOzAlJaIagXXBVAYBwgKGKwxP9j8zoelH1r2cTUM17RxU2mHHAAKp4LS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RV8Sxw6PLoEyCA7qIZ6ENztZJwwDa+6Bt2Jv20K+0T0=;
 b=XC+hc5sznQ8OXLElQ9aldJvTEHpZJUM4jt8zRgG10fnYSLCJG4YggYKQsrL4xF1Fms11kfKVTjwuWHuCe6V2z++oCUTDLIh2BGgekHsW4URgGbMjU79XCdBBHSQBRTHTqNDR8icdBGlYOOa/PRaDez2ce9yIJxCPT/9MZ/C18P2ZP5m3nQsu/MwTWNfPK1NwLeYedTYxCzUsCQZDyDrY6TkcY+oIO2E1miQs9ls6gmwZSw0LIpApMpFopt9AjOPGOlOff2xju8FDWAIinOK9oSCuZK0LVbdluH4IwYvE4znCmXfG2GKopPMQJhoUJlLPxS7FU+uooYk9xf8lJmDGKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RV8Sxw6PLoEyCA7qIZ6ENztZJwwDa+6Bt2Jv20K+0T0=;
 b=MKXep+xmvjqfC81VIbJUuYFgIVf3JMlKTRyx3yQjNdghcZnWJwp9t5hCVh5ogLUFFkAP3RQuUWCbrVISwefU/hagvIzVJLPtqf1M1174Kvkz32HZWXHR3Io5pcfsJlLp/rSjMG2XMjLY9rvi6la1DeHmNIeD6M5jXbw83tvQt/cSDLVu7/cJ0/qXnUXAPd9BoSYrhLwpHUY3mUG3UdEPK9wnpj7BOFinR/S+1PvefuFcjhJQ8hREncbGv6C5ADdhQ4zo2SzjMfLiNFJoSLSSv+WArNoGAD9X5nLBda8A25KhGUSIlgpJwkuGWO1zF67tT8E0/wH8/XBKRAu2oSuQnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21) by DBBPR04MB7530.eurprd04.prod.outlook.com
 (2603:10a6:10:1f5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 13:16:27 +0000
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3]) by PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 13:16:27 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 08/13] dpaa2-switch: consolidate unicast and multicast management
Date: Tue, 12 May 2026 16:15:49 +0300
Message-Id: <20260512131554.952971-9-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512131554.952971-1-ioana.ciornei@nxp.com>
References: <20260512131554.952971-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0034.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::27) To PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB11508:EE_|DBBPR04MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 7332ba9e-deff-490c-5fa6-08deb028aca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	QxU8BXrTkPBEDtxTC/+u9ju84wot0nmBsPEBiNwobPyTjvyNU7/sfYcrGkgkW4H5k3G5x6tqlguQEY2xTqCsgROP0vRK/9pwEh/379SQ/Xwq2s7v2tqHcNqkOliJyV3u58dAqyVBwNUauUj/cx8uhMvnHmlZ/vr1kK4PVKf0ORprrRJrwbV2Hxvc7YNWO9agK2amTekTTcd7zhYL7LyEcK0vXhVgW1X7VH+kw3h7wYVcMdOJ0VCTRgIu0x+oiowQEYrXtEGHFGLX3dfY1he4BhVqmf5IQXj1rAovkQec//Yh2ZiXJLNDT5QtwBDlcXagMiWPWCIpWd/szq6+YLuA5uNRJ00hmp2dgkhhBbWTcGIaZNJ3CWtX0W6QantA2NNuS5wUyi9oh3rWUvD3TpdXoPmsqHBXTjPLY061LZ5nyr393ZAEGXbFYxee2L/HIpZbTWzo0erLMjFljr4MelW/CwzqjEn2iVysZ69wxV6ZHtlJdwMSPPVTyOp3Vlg7yd7qQikSoJhQKuZDWUF7vmjFf+jYaAuAbZuVrpoEaPAiKIxASpPGKU8jXQZC4t+zjLhj7Dp2Whi/a+K7672kUA91OxO0CoVxcJ0PWu4DjAx6UB3ZEHl70dHaaWZF/6w78YhD+EWKi61Ec1Ynv4tl4OD6sDLJM8FnwXs1LMzYRz3SU3kwmzvSRk7XZ5UIdofSKJDJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR04MB11508.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IMVi1l7U1lJmiidXkCRP2dyCqnlQc/4KLZW34yzFuwWllRWVSYcagpBmGK3M?=
 =?us-ascii?Q?2HRDxK4mKFb1eke9eOjjCzU+7lockD89ClXCTt8e9z3jVDaf9PXqHKNnVo9A?=
 =?us-ascii?Q?iHgFOq4dNmMqpH2Qh8mHVe4cqbIj6Wl2vbn7gwrxpv/o2eOLlifKBEduukOs?=
 =?us-ascii?Q?XSaHdO71J7xxMDc8Ctk0zLr2NtJyXSIJLA1zh2TJpTn7t7pHW2zOicS+qeOd?=
 =?us-ascii?Q?k8c5q1/rX68l1xuAJmHSeF28rltLtJhlPf3RS/EozbQJnASpBOEuzEk4FchU?=
 =?us-ascii?Q?GkAL4LA9iXqWkoDEYmiEliZ6FNYXdB7o1HfkAnAFWg9SdlrBC9zH72Y5GwF6?=
 =?us-ascii?Q?vxG4JFde0XGqRRFoaL1TL5ZXwrE0V4BdKeUTcZl5NDZyaoBu7hAfTzMhvbb8?=
 =?us-ascii?Q?UklFFXpA6pQ8jNTlZxk2SqbmYSoNjb4+11So4Z6Ws0iwhHh9WkO2FnZz7ymF?=
 =?us-ascii?Q?hOOR06iySsi749lLx/VB88Comwr1h0uLqKa1hzmic9Txj+zNgDRT8qSvm1om?=
 =?us-ascii?Q?h59/S9f73PF53p7DuejodjhFVOmS5sM1+PqpfWbwTKn850GzVljS4LBSHMGe?=
 =?us-ascii?Q?IR0AiUQ0TBUm7wR9JasAK44Og9L62lmpTJ/YfoVPrnl5nJkykz1N3yLxC/PF?=
 =?us-ascii?Q?hBC2fUAd6tCzijei9rP3ym3bt8czHt+cAat0aHzuCjo5mibnCOaBw7+K/g55?=
 =?us-ascii?Q?tssrBdz0zkbiACciwsmoqnuY4/CB+m8+/wQLbqiUGdk3xEmWsn0w/ihP0kPQ?=
 =?us-ascii?Q?gBznnw99j86LTC3TBS/hItT9y9Lo9ptpC8AGsVJM9d4vDrjPaLrnmQRbH9I5?=
 =?us-ascii?Q?V1Bfv69tLQIIdQN3Kh0TN9Mf7/FfdjKmCttSgUYUlWeRq17M6Ad3d1e9d4Nm?=
 =?us-ascii?Q?ZkWUiN7GFuWrG0/mQ8pYFDvTZ+4V8lYMJctkzWfwpIhjDhH1riOYQlsCl0X5?=
 =?us-ascii?Q?Qb+kDIfVgbuqKvJoo/zsHCG8A4DT+L9Ccm4pwuPObf6RtiuyxDbCqFolS93N?=
 =?us-ascii?Q?bh6i4zu7s6auyBXRqIq8++CXf28KJQy/wCVX/uFPUav4Op08iBU2qkKJwyJJ?=
 =?us-ascii?Q?MmewAPBbH2XqMSwM4qM6iVA/cS8llxdCwRIW77M/r06s5XAFsbYP8YFGJoV4?=
 =?us-ascii?Q?fKcPAPDbUy8kmFSjhIOd4Vclpo+FJj2gKJecLPpZubVbQ+o+Dz3OfjdkLVhZ?=
 =?us-ascii?Q?w3QE/oycCC88jtHIpnwLa2lYtFLU81bsyw2Y0f/J4oYkQfrWm9P8t2nvr83n?=
 =?us-ascii?Q?sqZBbWXwQ7fQG6CyMU7yJgdVcAoBZQKeKpUFl4zLvZUkbN2txplpKoHBfhLH?=
 =?us-ascii?Q?p6pfr2NP7fOobAJtCgQ2QyLUlrAcgcv70co+TPdSU5YWjy7AUkyxApvOhx5N?=
 =?us-ascii?Q?AtQklwoIJtjeCgKUmwocJWRDq8YDDukeE3ZX9a+xxX4ErTWcESWSS79kQC+Y?=
 =?us-ascii?Q?h1NU2guICXRJwYBU5NRwO6FWdW+6G00lc11Er6LoponWBIBHqEWtnv4TzVkL?=
 =?us-ascii?Q?2SlbPrOTN+kBbDPPGP5OpJCuOKb/+/DNyfRtZiK/fuFmeuumOPxsmkwy7Zzf?=
 =?us-ascii?Q?UX8njpA+cgWFBoC43Zpcnw/JuU7kWCnVqINc7R2sHHw9dKn+fwZ5Db9qyO75?=
 =?us-ascii?Q?an6c25JijKmajcIKvURHk630hWMn4Jj6vap2qWuOKQV/o7CS40at5Q9P9Tdk?=
 =?us-ascii?Q?NB/d17daJHdsa2YIX81y5hFMva93+iyUI0ZB5W+iUyGxDDVFRHuVo2+7cizd?=
 =?us-ascii?Q?aPGwVEaw+A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7332ba9e-deff-490c-5fa6-08deb028aca5
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB11508.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:16:27.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuC7feTjgecOuGSA1Bxwt4SqoBxTy7J3/pfhiatm+BubE5M69ESIpYQeNAXRHDSoLVJbGPAyI2f20u/267hkQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7530
X-Rspamd-Queue-Id: 3DCA45216E7
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
	TAGGED_FROM(0.00)[bounces-287159-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

This patch consolidates the unicast and multicast management by creating
two new functions - dpaa2_switch_port_fdb_[add|del]() - which can be
used for either uc or mc addresses. Having this common entrypoint for
both types of addresses will help us in the next patches to streamline
the same addresses but on LAG ports.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- The rollback in dpaa2_switch_port_mdb_add() uses the newly introduced
dpaa2_switch_port_fdb_del() helper instead of the _mc counterpart.
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 41 +++++++++++++------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index f910a07095be..f8aa65463386 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -551,6 +551,28 @@ static int dpaa2_switch_port_fdb_del_mc(struct ethsw_port_priv *port_priv,
 	return err;
 }
 
+static int dpaa2_switch_port_fdb_add(struct ethsw_port_priv *port_priv,
+				     const unsigned char *addr)
+{
+	int err;
+
+	if (is_unicast_ether_addr(addr))
+		err = dpaa2_switch_port_fdb_add_uc(port_priv, addr);
+	else
+		err = dpaa2_switch_port_fdb_add_mc(port_priv, addr);
+
+	return err;
+}
+
+static int dpaa2_switch_port_fdb_del(struct ethsw_port_priv *port_priv,
+				     const unsigned char *addr)
+{
+	if (is_unicast_ether_addr(addr))
+		return dpaa2_switch_port_fdb_del_uc(port_priv, addr);
+	else
+		return dpaa2_switch_port_fdb_del_mc(port_priv, addr);
+}
+
 static void dpaa2_switch_port_get_stats(struct net_device *netdev,
 					struct rtnl_link_stats64 *stats)
 {
@@ -1915,14 +1937,14 @@ static int dpaa2_switch_port_mdb_add(struct net_device *netdev,
 	if (dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
 		return -EEXIST;
 
-	err = dpaa2_switch_port_fdb_add_mc(port_priv, mdb->addr);
+	err = dpaa2_switch_port_fdb_add(port_priv, mdb->addr);
 	if (err)
 		return err;
 
 	err = dev_mc_add(netdev, mdb->addr);
 	if (err) {
 		netdev_err(netdev, "dev_mc_add err %d\n", err);
-		dpaa2_switch_port_fdb_del_mc(port_priv, mdb->addr);
+		dpaa2_switch_port_fdb_del(port_priv, mdb->addr);
 	}
 
 	return err;
@@ -2033,7 +2055,7 @@ static int dpaa2_switch_port_mdb_del(struct net_device *netdev,
 	if (!dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
 		return -ENOENT;
 
-	err = dpaa2_switch_port_fdb_del_mc(port_priv, mdb->addr);
+	err = dpaa2_switch_port_fdb_del(port_priv, mdb->addr);
 	if (err)
 		return err;
 
@@ -2779,12 +2801,8 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 
 	switch (switchdev_work->event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
-		if (is_unicast_ether_addr(fdb_info->addr))
-			err = dpaa2_switch_port_fdb_add_uc(netdev_priv(dev),
-							   fdb_info->addr);
-		else
-			err = dpaa2_switch_port_fdb_add_mc(netdev_priv(dev),
-							   fdb_info->addr);
+		err = dpaa2_switch_port_fdb_add(netdev_priv(dev),
+						fdb_info->addr);
 		if (err)
 			break;
 		fdb_info->offloaded = true;
@@ -2792,10 +2810,7 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 					 &fdb_info->info, NULL);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		if (is_unicast_ether_addr(fdb_info->addr))
-			dpaa2_switch_port_fdb_del_uc(netdev_priv(dev), fdb_info->addr);
-		else
-			dpaa2_switch_port_fdb_del_mc(netdev_priv(dev), fdb_info->addr);
+		dpaa2_switch_port_fdb_del(netdev_priv(dev), fdb_info->addr);
 		break;
 	}
 
-- 
2.25.1


