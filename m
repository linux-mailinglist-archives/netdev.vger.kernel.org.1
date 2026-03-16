Return-Path: <netdev+bounces-268065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOD2CNPQt2n0VgEAu9opvQ
	(envelope-from <netdev+bounces-268065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:43:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFB3297418
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FEF7302259E
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 09:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6B338E120;
	Mon, 16 Mar 2026 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="md/zo4ks"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013050.outbound.protection.outlook.com [52.101.83.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FF838CFE8;
	Mon, 16 Mar 2026 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654063; cv=fail; b=GGy8ZGwu8vgem0aCz2ljOnFxMl35QCKiMgW7pWXeSqRW1zaZiM3U+xl4qyxIltcoHPBpTdcFY4oHImf0Spi2S8l3wPG+u3eBzbxqH8Y8LwdyvBiKnHauxvg/g88l8BzBKNk3azrxhjpeDrerwk4bTB4me7BS5SfkUtfQdN7FyTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654063; c=relaxed/simple;
	bh=TyKimgDykn7wkSZu1bs6HtcBYKXP7m2KkIHJmH0wWZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VaWGp1uMgj8aY2fp8iKG1g6v/vDelErbWPLeQndmg6uNCOQqeaZJIl42sDtMl/V7r4QnYUfpjan/JIlh2Pv0mrT5sExtNEZyj3xK+v2BWHZ92c1/ds7f+WhGld89lmiUuYWgejthmgGR81Rnjz0vlTcYuegu+j/mZ0gF/N6uiEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=md/zo4ks; arc=fail smtp.client-ip=52.101.83.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lP1ZuCJ68HSVwDRXR13WyI9hNIlr9sq+oEssBesV2KsyoCt3gBsQ4X2zc6vOivT1kH0ZlbXDslvz6WEDdotaW6gWDpCKjfIRtjQbLHigIXxuOdDScwqGqVpFVjWhqxdDQkawK87vjELmEnx0Q29aAOUtyFStzhuD0QPbiQrxeG7ItEtL/7GuLjcEwSn1l7f3pouaPWHRt43oRIcYKEP8vNQ0mhgKNpVDw5xySPvRi1PmccOSNZ2Wm4AG48sH47i/UAYfARUXcyVOts3FDHskAcsgLeZiK8b/XjG1aKC1JuarFdtSMLAgY55GcSlkhduMvOZHeHTyH5BNLCvOmtOTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVX/wrHm3G4dGqNAC5ffQGFcekO9fLvQl9oiAcEDw5Q=;
 b=SH7tuPb9Alh4BpEIHePczM3pZOlFmFQQhLYytvQuHVHSmzRbHpo/LpQ+4eGhKNV6wzb/m+CuKqSglIZ8oCLHDNNp0OgeGETkAvojnc7C6t68WKSiwL+T/3ERgcQYf1zGOMkvao6ZMoGffnbuAz4CUI2H53jFfTa8pPlWEXUert8bPwzznI6uK+gBt55mTmHYNxDqliO0ZbH0G1YfumKnThWGYnCQH55o9iNuxb/FNuQr3IzN6liZtUEMBcDmfbc46wuaaV3k7ujpQUig1+VF6OKYYDmd8R5A6VB9U+lmokN7FX/60m2F4gfWjDxx2vMU4IWFl7uY5ESTPECod+/ozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVX/wrHm3G4dGqNAC5ffQGFcekO9fLvQl9oiAcEDw5Q=;
 b=md/zo4ksudg4l19+mPGnoM3YTmj2DCfT3lVkSkq6/trL3NeIvxqyk9Hkm2CmTR8mNaN0f4sa5gmmlF/uQJwyiPzY1KX8XpMqWXP04CLY5L8xocNx2H5ecSMJYMfm1cTOVxM2n1bKozluwiKUXIlvdBGruszvGJ7DlKvyeA9qAqTAs6SN20ws+9C6LpaJ0OlL9o4leWq47y9MlxcpQ5wn36LxFtQWSwzxG/mZYqu6PnlekyrM9kGCRvfkqZADwWAOmlLn7TBBqjK3gk6GTIj7WBKF/rJZF3y3g4EjDn0TyjyYwGPe13rMuogTIQCFBdLjeHM83VwhFDmW98RavKMQGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AMBPR04MB12412.eurprd04.prod.outlook.com (2603:10a6:20b:75f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 09:40:49 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 09:41:00 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 05/14] net: enetc: add support for the "Add" operation to VLAN filter table
Date: Mon, 16 Mar 2026 17:41:43 +0800
Message-Id: <20260316094152.1558671-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316094152.1558671-1-wei.fang@nxp.com>
References: <20260316094152.1558671-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AMBPR04MB12412:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ce8436-497e-4c33-7fe5-08de83402222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|7416014|366016|38350700014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uVrnmD7/M4hrv9kLN43mB0VH/LVG3882fOY0falnUPRwvs02ffB2tMPa3vQRGFixncrkmNKhksvor4aJ99MCIxDRo19zkl+8us8RgCZ4rdlpdZl6D7kYHEGNh1QGlaY26ZVgublVz39q+bppaq72R6yOgz9VBE9TOly8fX45wh+L+F8W40rX71bgSIpWnkkrvSjxAkpQEkkm97XUVuaxeGQ/SM399yohwwrZ2AnpRlldBM/FASTb6QW8px3ZlwS5JPUf1KjbH+fEhVOCRNhbQ2LCSHgsTpfjyOGQ66GWmBst1AvTXt02sylbdDzSsrkU74AoNvL4lPEHu7VVYRjeGj3zeO9AMqmK+4eJIQZ+NnlJLHAnhmzORpQiEqAyXZ/mZKKRo/YqSujU5F+9WcMsXk5G8nyz+jFe6+Hg+JFIDDWUO3K92booNZb/nnI1wdH2LtPguewtcmTdipDebc3UcabQgbKfyhI5bC3X3V48zOTvg56qScQ4jSAN100L9ZJ537/Cflm05HSwpz54CuM/1ppRmWQzh1s9FhMlsKGYNUHilV05WQ+lY13Yr/H4dV74IiAPNXytVI1SLQPjH8JbMC4JBoUW0g5ylvA39gc+gzppt6CMEHFhVAxIRPqHU4DCZJqF8+mdAe1U0aAfs8TuyrG+49gePsmjj+sFoHhtNqOx2K1HIZxyeNcmPXRBusurEYnbGfL/wwnveJwxKAGeFzLdGO7G857yWAWOe3AdMrXDD7XhNE4Mp6xVpKC0LnlWXzF72DbU8DIyD7IQtLQnKfYnceaMOBP5L+h6qvJJGDzvv72NKmJssIx1ARjgq1/4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(7416014)(366016)(38350700014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WQNiDmSir7mZuQlUwxYKbpEKuXhnPog5A826rdxHa/hDzifsF4gKuEKm/lk+?=
 =?us-ascii?Q?GW3rJ9Rm4pLnJd2aMgXU1g498IgItS0MHbpZ1UwLt8tkmPAJCMl6oKzBuRPW?=
 =?us-ascii?Q?nPpcP0RIiBhRv1UHD49i0REinR3ED8j0g0V8E+1F12V2/eJt3TNvwE2nuWeJ?=
 =?us-ascii?Q?ngMtFSIN1+yIlLEMJafVgAW+KqwVbbbVvxO1xiEl8Lh6v4S3WGQGMn8igxJS?=
 =?us-ascii?Q?+DNxlMtN5j8AS57+1HtDAPh95S/ZERXNFt3LeeTV3RQ4d5XXSqdj8/6Pxnen?=
 =?us-ascii?Q?ONL6fuZ/lMgf2byeacWqZuRFkfRrRKsafIVTrwOHAuQ5VI7PgEOBiVo6OH7I?=
 =?us-ascii?Q?yW9/lBjQZ2ObJIUVozeKJrogMR5qF7fOZpn1Gs7uoItpWwTyzBeeIinl42/z?=
 =?us-ascii?Q?8mHU5Y45SsCuqPyRbHIeDcxoPquJYkR14tOFBLg5oeCSRYvEoznMF0DczPNb?=
 =?us-ascii?Q?wD98iOapMfArC8fiKKyCgwn7lDdpoeST2kC6SWn2kuOSX2S6WYk8C3aNTq6x?=
 =?us-ascii?Q?tW/Tj9PEBXgT9Dxd8Hg0FK8BmTeWgpym8kOBXIpm6g945OI8cnGWwAiztaOs?=
 =?us-ascii?Q?wJl73C1B50zsUEiPnyybfZAxwp/KAW6VVnL4UlJ/ulmTDfwjJqkFUlGsfAfy?=
 =?us-ascii?Q?GOnRdCwSe9LW+bmUdJSifZbFMfngUvlBBLJyD71cUTllQNlc6sebHH8UDcpj?=
 =?us-ascii?Q?6PoZnpfZMa+cD6IQNs08OXhvYdp2di+oi721EfY+nzRzkcir3NGK5SvzvDfQ?=
 =?us-ascii?Q?mfsYnFf9iHswLHug9BCDorkXX9te1mYpGnAU+0IYX4J4In5m2G28epMK0iGF?=
 =?us-ascii?Q?2ls0CfkthfBixfEesDUCw7OW2dXB146hdxTP/fPW6oENmIuN33VD8KWRDGHo?=
 =?us-ascii?Q?2AUy5gDL7EyMo7flNEiNO8JbmWbmGb2eLhh6ld4icsHQMDaVkDGApeH5r6eP?=
 =?us-ascii?Q?o0ov/lZtmBSkscJKtaLeQwfZyTd0zXp71b7gVYsvOns9oBZUrYgU73sXuKel?=
 =?us-ascii?Q?BOXf3gQ5B4wwhd5NG+giF/+azBKnEjvFmbzTr6VMWwqRHzjhK8YGMg4Zr1d9?=
 =?us-ascii?Q?KR2IkrfUf7ImuLeYvbDDD8v3mr2AWY41wNtlewjOUD3RjIdwn2E3DKAMKieJ?=
 =?us-ascii?Q?Z+squkuBNlbRyoN/P7slYY4JPgcYLAadyh3IJIbAp3kH7IoNTXcuZiAssDM2?=
 =?us-ascii?Q?7RynrynSJzkzNveT9gDkRgJmPj3TAvM9nuzyfx2mAHwDW7IBAjXedZo/zuuA?=
 =?us-ascii?Q?xkPpXZKRufreV257EPQTsakrR9WxeNXVR3O0eNRuXkbiClX3qizvXsWsqqSH?=
 =?us-ascii?Q?6le8gWaP5h37hd+b4zuQF4rB2T+LlS6gvvpZlpbIA8oKR5WPPt/9MSIMeqjj?=
 =?us-ascii?Q?02f9kVBDz36YWjVkX1WhcN3cj642hMDtOrtglyDC6s5cdSuDsCrsiIgyeOPt?=
 =?us-ascii?Q?ARyJb4zllMV4s86L5hVC9Io4kIozRlg0jC6YOXWW5zmj4q1GafmOnzCqxLaG?=
 =?us-ascii?Q?O+o4xdt4dmLPl2xj9TAGdXztKcMmgMSSukLHuuKTBuvgdB96OAqljZ9D9fiA?=
 =?us-ascii?Q?G9nsXeVZQ/0CbVEe7Wr3Uov74j8Z7If2XT5s2F/8gEmscZeZsiuwjGYHAcTb?=
 =?us-ascii?Q?nEbVoMK/mP6K6d0bhkLwIalFCMKMSNdbzKgMFXUH+PZbBdq6xIYbsIbEsImS?=
 =?us-ascii?Q?8hy+cRdrB5oqy04Ua16CFkQ4z1vMrhH8CVtNEoeApqsjwrs4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ce8436-497e-4c33-7fe5-08de83402222
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:41:00.8425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66fLRzjo7wL8FFJGs1l+eYs0oPvNtPYXjzS1mCf509MWAlJfsE8QYYdQjbaNyRkjhLiHEdWXiKJWEU0yV5U1Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12412
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268065-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BFB3297418
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The VLAN filter table contains configuration and control information for
each VLAN configured on the switch. Each VLAN entry includes the VLAN
port membership, which FID to use in the FDB lookup, which spanning tree
group to use, the egress frame modification actions to apply to a frame
exiting form this VLAN, and various configuration and control parameters
for this VLAN.

The VLAN filter table can only be managed by the command BD ring using
table management protocol version 2.0. The table supports Add, Delete,
Update and Query operations. And the table supports 3 access methods:
Entry ID, Exact Match Key Element and Search. But currently we only add
the ntmp_vft_add_entry() helper to support the upcoming switch driver to
add an entry to the VLAN filter table. Other interfaces will be added in
the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 50 +++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   | 19 +++++++
 include/linux/fsl/ntmp.h                      | 30 +++++++++++
 3 files changed, 99 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index f6f4316169b6..e8c94157ceb1 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -21,6 +21,7 @@
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
 #define NTMP_FDBT_ID			15
+#define NTMP_VFT_ID			18
 
 /* Generic Update Actions for most tables */
 #define NTMP_GEN_UA_CFGEU		BIT(0)
@@ -231,6 +232,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "RSS Table";
 	case NTMP_FDBT_ID:
 		return "FDB Table";
+	case NTMP_VFT_ID:
+		return "VLAN Filter Table";
 	default:
 		return "Unknown Table";
 	}
@@ -652,5 +655,52 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 }
 EXPORT_SYMBOL_GPL(ntmp_fdbt_search_port_entry);
 
+/**
+ * ntmp_vft_add_entry - add an entry into the VLAN filter table
+ * @user: target ntmp_user struct
+ * @vid: VLAN ID
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
+		       const struct vft_cfge_data *cfge)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct vft_req_ua),
+	};
+	struct vft_req_ua *req;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.vft_ver, 0,
+		      NTMP_GEN_UA_CFGEU);
+	req->ak.exact.vid = cpu_to_le16(vid);
+	req->cfge = *cfge;
+
+	/* Request header */
+	len = NTMP_LEN(data.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_VFT_ID,
+			      NTMP_CMD_ADD, NTMP_AM_EXACT_KEY);
+
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to add %s entry, vid: %u, err: %pe\n",
+			ntmp_table_name(NTMP_VFT_ID), vid, ERR_PTR(err));
+
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 9e2a18cf3507..8f94572eaf0d 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -160,4 +160,23 @@ struct fdbt_resp_query {
 	u8 resv[3];
 };
 
+/* Access Key Format of VLAN Filter Table */
+struct vft_ak_exact {
+	__le16 vid; /* bit0~11: VLAN ID, other bits are reserved */
+	__le16 resv;
+};
+
+union vft_access_key {
+	__le32 entry_id; /* entry_id match */
+	struct vft_ak_exact exact;
+	__le32 resume_entry_id; /* search */
+};
+
+/* VLAN Filter Table Request Data Buffer Format of Update and Add actions */
+struct vft_req_ua {
+	struct ntmp_cmn_req_data crd;
+	union vft_access_key ak;
+	struct vft_cfge_data cfge;
+};
+
 #endif
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index ba56d4ae0ff4..6fb2c8c525de 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -32,6 +32,7 @@ struct netc_tbl_vers {
 	u8 maft_ver;
 	u8 rsst_ver;
 	u8 fdbt_ver;
+	u8 vft_ver;
 };
 
 struct netc_cbdr {
@@ -94,6 +95,27 @@ struct fdbt_entry_data {
 #define FDBT_ACT_FLAG		BIT(7)
 };
 
+struct vft_cfge_data {
+	__le32 bitmap_stg;
+#define VFT_PORT_MEMBERSHIP	GENMASK(23, 0)
+#define VFT_STG_ID_MASK		GENMASK(27, 24)
+#define VFT_STG_ID(g)		FIELD_PREP(VFT_STG_ID_MASK, (g))
+	__le16 fid;
+#define VFT_FID			GENMASK(11, 0)
+	__le16 cfg;
+#define VFT_MLO			GENMASK(2, 0)
+#define VFT_MFO			GENMASK(4, 3)
+#define VFT_IPMFE		BIT(6)
+#define VFT_IPMFLE		BIT(7)
+#define VFT_PGA			BIT(8)
+#define VFT_SFDA		BIT(10)
+#define VFT_OSFDA		BIT(11)
+#define VFT_FDBAFSS		BIT(12)
+	__le32 eta_port_bitmap;
+#define VFT_ETA_PORT_BITMAP	GENMASK(23, 0)
+	__le32 et_eid;
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
@@ -118,6 +140,8 @@ int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 				u32 *resume_entry_id,
 				struct fdbt_entry_data *entry);
+int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
+		       const struct vft_cfge_data *cfge);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
@@ -183,6 +207,12 @@ static inline int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 	return 0;
 }
 
+static inline int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
+				     const struct vft_cfge_data *cfge)
+{
+	return 0;
+}
+
 #endif
 
 #endif
-- 
2.34.1


