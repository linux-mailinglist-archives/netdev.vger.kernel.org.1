Return-Path: <netdev+bounces-303022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7DoZDaB1Q2ozYwoAu9opvQ
	(envelope-from <netdev+bounces-303022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:52:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EDE6E1664
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:51:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=lNpEwLjc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303022-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303022-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A60E302494F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DA83E6DE7;
	Tue, 30 Jun 2026 07:49:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013068.outbound.protection.outlook.com [52.101.83.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7823E2AC9;
	Tue, 30 Jun 2026 07:49:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805768; cv=fail; b=dsawYB+UgybhLiS1lDv8WpyE77KMU80TS8xKV6INXVf1kwYHrPd9STJOy99AmU0+TQ9y50uYdhs/5x815szT+ydAldL4i97Qhj/Ko/qKha/rxGEX1Gp3eOWnXUN0a8+JGIP6TCGzT3abiszvvxSXuMgyFpcW26WEz5HWtWYCXDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805768; c=relaxed/simple;
	bh=mWGsmfK1lEPjFjTswHIjyR7AHRi38OcfYF+yMs/Mjnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AWTvlVwANnsSc41K684GNL2tDPZ+Qgi6wqPYUMXMame43S/pPBh6SQgqbpi1L0XmBdrvDV/UAr++Tu7QEINDJcCU6aqwM9MEo8ViGOMkZ6lNr6UmGxLJzDDiuvr2qJK+suMBVXsYcsNyqMR5UpPvn04BX7EFxM4wk+IKB6WzGco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lNpEwLjc; arc=fail smtp.client-ip=52.101.83.68
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXMu5T5tXdme1i9rDQyjpT2iU/hmJEHa8XQO3ywaxCWNPZ0FMU23ziPDOKErdI94Qy/AXcNLJZ2StEYTiuGHj3qZAuq5WpYVrDgZhpy9q0RGDn5wCL0WZBFRGMnk8xBD5flhS8OPufaCaV4nwNwRc0JEp5C0X731mGz1C9Eh02NIb3NNPwIgN6ikTGoT2Icy+e7FQTujV1UEzcmZ5gerezTvc2goWbjgQ8O9mnnPFAbqp1PrOGxwPbHT4YAYSZ8yT+GGYZXQ/xjoLwWqBFJObO0L60mIrSofuPwzl5RnX2KeP3hWe9ER0kp7GwEMEtS/ckzi7YqRk286EwP5EqvE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=la4Jl+DQWoNfBe5MsS38IJXSCWVf24NUmxmEqIAo+Jc=;
 b=ODmSA3R8iFJi7rgfJCqEszMkjVE6jl6BBX5moxLW9npxgvufA4Cpp61b7n3P4tzXAbbdkBlEoVsFIGSleTiunPXrOHkYhh+tQUiK6XkGRp4zi5NYjR5g+3vWxmfTpwRNn/12HKUlRx7Ri3fGSAuekO90o8HliOU/brgVF2TqXVcodTez6wmkcg03lx44iM2g17ibXYmD4qKsu6wR/2w6rWXTsvN/HAV+GBYCehHG8PQLoVJlAf8dNTKsiVDXYS9WdYXm/b0vrUzvv3z6Nkhi7lig4ps7sbWHGAgDn1D9s6QevZIjHcOkBc31RCLZb3TL3ZaGTlNHec7uA3rP3edcnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=la4Jl+DQWoNfBe5MsS38IJXSCWVf24NUmxmEqIAo+Jc=;
 b=lNpEwLjcoHQSkvaOmHpyO2DsQWZq8qlqr7Fi/9qKtMP8IwwEkscMUiWfRE3I1Jni4Vchasm7KN/yhvVQpzd4SyiBBbn/yRpAfV5Pl78V9O4/ZgeNFlHKAs/fsXCaMU5ZlAezOSB+t0db/K0AaltCoL6ALl7RO2Ec9tVc/mhaSOAmbrNx/jMNylLKEd7/oI2blTdGwAJgsYGd13YtME6TpfpeNFvvPmmvoPiRPe2lGvNG4tJxdENt/P6zbl3VsGx/eTlt/AdaHYEUxntf0z4AOnGjHI6p93scoa4We/jNLWaaojIKg71YmFzW93YeZkU23LiuCPQKOCwzMOl4F6ardQ==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:49:23 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:49:23 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 08/14] net: enetc: remove invalid code from enetc4_pl_mac_link_up()
Date: Tue, 30 Jun 2026 15:20:30 +0800
Message-Id: <20260630072036.382761-9-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630072036.382761-1-wei.fang@oss.nxp.com>
References: <20260630072036.382761-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU0PR04MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bbdc720-a960-4824-da54-08ded67c19ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|19092799006|1800799024|22082099003|18002099003|11063799006|56012099006|921020|3023799007;
X-Microsoft-Antispam-Message-Info:
	z41jv8VcD9gmYGB7j5pVtTGQOmFlr4IXJBFhY7UE7W0wen8+IOTLHvls/R/t+Ay3MfZGekqQhrBzLoJdnUzQUOv+V73jJM9Jh266WnO4USqCPEAbdyUxjHZ0h9ExDygrsTMC8gs8V0Mm8DqvheyaN7A8yr488BcaU37INK13UG/5/JqdWQBNP9DbG9Q/5BCc9RkgFPUGmBHLw7k8b2dAJ2DIWmOd9uKP/WW24rRUcJbtQyYzwo2pWaXmOKs5zXL0jvu2sCR+lvBaTmMKBMI1A1DW2/Cf9SazGdGprP56UlQ5kOuD3VxDZ+E1mEuKp0JHdLfEe/0uPc5Kit38HCG28mb5+uuhXgo4NXiLx14WVYZAAx/80zsUDu26J4Fy7eRrEmovTSQV+YX4TuKquLmXByNAZETrb1qQ/8Lq+RoF7taPTXq5NNHlqa8EF4LPFQf0GEj14h5s1jaYft9c7j44ASb/iWOnn+CuR/pP0/1nWdlIZ0Wyc5oEEsJZR4TBNE9lKyt/xTCCIqu+ZnhUD1rs7GKiYmf41A1hszhdfvltqI+iN0SROaO2fzaKuwWGypAPkb0MFQtgETz/wirz5i2Ri3/xEPG+qrTG7lAaJw8BVjRVjkJVmCrvwH+Co0TWzVvM++1GtAl8mn5zurzpIN/Jf+RdVmOvDmC+QPFgs3kVhWEut+yKaB8Zb4wrrMZOFkP1bCRVNQZcD1+YVGtzb8/0YQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(19092799006)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(921020)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LRKn8YIKQOs9W17yRJWO4kPZpSzdEZnh1VSlyXqZwosRRwxOeJEkw1SCm9K6?=
 =?us-ascii?Q?Clx6iDfZdIitD+I5px3dxeqJeKN0TfkhvjddBS8dcPsaZhw1p2ED7XLXxVl6?=
 =?us-ascii?Q?kDIxSDZ26dY7nLsE6p3FlH6Nwm8Xhfihkp16bdcF+aV+EKW5ii4g/55P+scv?=
 =?us-ascii?Q?7Fi3YiObK4wmH4tj2vsvNSK33B07sjYN1PGeitNBu56KYQyNQ7URQTgghxXX?=
 =?us-ascii?Q?UZUBeFxSe4/s01Ry0Yu0LY2jl5P9bA5LiZl7Np8YXBdq6VIEzrwoqOdUrUcU?=
 =?us-ascii?Q?KkUZeIviIP4OpodASmY03Sm1/78VZwiGadvV9KKC4BEokV2lLyuAsokRlqJo?=
 =?us-ascii?Q?zZJfgP6hAw/U0bE/bd8BEY6xs7xvPOH8HkTJUye5u1lx3749mupolSfpUXcR?=
 =?us-ascii?Q?YCbyhBhIqwScFnXAJHCAsHIRi/0GPGq10tMoL0ZubNFjhra57zbyn/eQjsFG?=
 =?us-ascii?Q?7PpVHTHQ/g6dVjQ0hgoHB7svAWYQ5dtXG//1xltwWId/xneA8uJ2cO5Z3h0C?=
 =?us-ascii?Q?YWE/YuciROjm1tRCBCQ8jfZXNV7MY5s9etbSbbNr1bI+fx3X/tNQ8W3F0xMW?=
 =?us-ascii?Q?6+rRNnUscLYya3tKSWB7z9AXWKviZc8dnMWMuJNqciYLzV1zcHsdJMd7EKjg?=
 =?us-ascii?Q?AO4KdG026ku42OYt29LmiUly5eV4Y4otO871Qt93W4dQ9Cyh3g/FZl0HgOfp?=
 =?us-ascii?Q?YU6qvsHw8o3KD0IzK2KXeu+HLt1qZcP0+VS4r2yK3qWky2LnDKR5fJzdFad/?=
 =?us-ascii?Q?rfuEzz78VP8TmJJEZR6J9eAf6SuVAmkWLuFhGvm6KstfsgsTsTNVWWcrXO+0?=
 =?us-ascii?Q?JRDhQR0yLDc3QGmnlhu9eRuDr7xdvT5gEHpn9S9JKACbQBtGSPpspndyDhPN?=
 =?us-ascii?Q?Pieq0zNMgxv7J6XATGQZNEg6L9MuZfEZg3Lh4leHIYcR5I1D/ZwVgwQdgezJ?=
 =?us-ascii?Q?2aVBOpFT6+cT1hdoWbHJuVL15U96GqXxDJ/DIi5nk9iB94N/zyOF8lJfkMQ+?=
 =?us-ascii?Q?Y/E3UTIaj12wbg/dprRiQ8kbUIJ52WirKmld3egf1YCZrk0k5tHZshEs1KrQ?=
 =?us-ascii?Q?07HOU1j9GIcHs9aQHZDR7y8LSZWE9w1xQADVJKJ5NruqRXo+pwIF2Wi4jQTN?=
 =?us-ascii?Q?wt9qMU/CSAZs/9usesVHxeMdr6MHM/Hjhq1SnFM7qRSJqqfYNP2UAohSAkOH?=
 =?us-ascii?Q?WB08Fryryo8YkJXbdfn/CwDlV2i6IyPQ65WgMZA826ad86I2dZagu9+zEboI?=
 =?us-ascii?Q?sQrdQrT8Zqx6sof0SHHt1g/4QAdcXG9XsRgwrAAv20X8OLPDNiSXVE0k7/ey?=
 =?us-ascii?Q?TwFFnajwII2iIcPQH4L13BHaj5v8eKE4Dmgiu23BDxTjHm3h5XXuhRTwmFAl?=
 =?us-ascii?Q?9f5z8FudCwxbK4ZvFgtssk83YEOHkjxNLjwehm10+0x8fvDjzq+xru7e1rmM?=
 =?us-ascii?Q?4VOUvHQE/+0HRJruP6lmTPKbgULNu5Oec0GQ6NYE5rJ8CTYDpAa8tYDJMyNh?=
 =?us-ascii?Q?FJjpN+2qgOD1QhtAYEcJ/kcLtYVbkwLKCVeecM6zsPEb+9+rg4V685CjNLA3?=
 =?us-ascii?Q?4NCTfXemLp2YiX13+7CawuKc6TXsH3KH9X+caKr+jWBaS/4RaXTgRo6BVHZa?=
 =?us-ascii?Q?AOiLJYg3JOSKk4t10Myiy3CCxfEobc7uPnmHNDBymd+aYUTeUj8MrT5XyR0E?=
 =?us-ascii?Q?pmlW7+6+aCBgEanREo8iSGCCBb9znz8WE3akOxppfreAntzdRqOa2dt3lMQ/?=
 =?us-ascii?Q?wGl8/Aawdpv8NigTXlD51w+u2qjfdC/eOf9xz+SRDCp5z4BYT+Jt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbdc720-a960-4824-da54-08ded67c19ea
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:49:23.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14wkONB6Uk2ur9nlWNlpx7zA2YkHAJYHnJ+vY1ESms6Rnn3jdTo9Vx+wW8RAz8qVWdsWgJ8Hf1BESjOG+wzVukyEFyzjZY9hsBSnr7HEagITRO+Hm5PLOs2RQ3pdtynO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303022-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:chleroy@kernel.org,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,oss.nxp.com:from_mime,nxp.com:email,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83EDE6E1664

From: Wei Fang <wei.fang@nxp.com>

When adding phylink MAC operations support to the NETC switch driver,
Russell King pointed out several pieces of invalid logic in the
.mac_link_up() implementation (see [1] and [2]):

1) Half-duplex backpressure is not supported by the kernel, Ethernet
   relies on packet dropping for congestion management.

2) phylink_autoneg_inband() is unnecessary, as RGMII in-band status is
   not supported.

3) TX and RX pause are disabled in half-duplex mode, so there is no
   need to override them in .mac_link_up().

The same invalid logic is also present in enetc4_pl_mac_link_up(), so
remove the invalid code from it.

Link: https://lore.kernel.org/imx/acEIQqI-_oyCym8O@shell.armlinux.org.uk/ # 1
Link: https://lore.kernel.org/imx/acEFwqmAvWls_9Ef@shell.armlinux.org.uk/ # 2
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  1 -
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 35 +------------------
 2 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index dea1fd0b8175..7a3ccc94b036 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -198,7 +198,6 @@
 #define  PM_CMD_CFG_CNT_FRM_EN		BIT(13)
 #define  PM_CMD_CFG_TXP			BIT(15)
 #define  PM_CMD_CFG_SEND_IDLE		BIT(16)
-#define  PM_CMD_CFG_HD_FCEN		BIT(18)
 #define  PM_CMD_CFG_SFD			BIT(21)
 #define  PM_CMD_CFG_TX_FLUSH		BIT(22)
 #define  PM_CMD_CFG_TX_LOWP_EN		BIT(23)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index b21ff362c31e..67aaf188d325 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -588,11 +588,6 @@ static void enetc4_mac_config(struct enetc_pf *pf, unsigned int mode,
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		val |= IFMODE_RGMII;
-		/* We need to enable auto-negotiation for the MAC
-		 * if its RGMII interface support In-Band status.
-		 */
-		if (phylink_autoneg_inband(mode))
-			val |= PM_IF_MODE_ENA;
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		val |= IFMODE_RMII;
@@ -690,22 +685,6 @@ static void enetc4_set_rmii_mac(struct enetc_pf *pf, int speed, int duplex)
 	enetc_port_mac_wr(si, ENETC4_PM_IF_MODE(0), val);
 }
 
-static void enetc4_set_hd_flow_control(struct enetc_pf *pf, bool enable)
-{
-	struct enetc_si *si = pf->si;
-	u32 old_val, val;
-
-	if (!pf->caps.half_duplex)
-		return;
-
-	old_val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
-	val = u32_replace_bits(old_val, enable ? 1 : 0, PM_CMD_CFG_HD_FCEN);
-	if (val == old_val)
-		return;
-
-	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
-}
-
 static void enetc4_set_rx_pause(struct enetc_pf *pf, bool rx_pause)
 {
 	struct enetc_si *si = pf->si;
@@ -881,13 +860,11 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 	struct enetc_pf *pf = phylink_to_enetc_pf(config);
 	struct enetc_si *si = pf->si;
 	struct enetc_ndev_priv *priv;
-	bool hd_fc = false;
 
 	priv = netdev_priv(si->ndev);
 	enetc4_set_port_speed(priv, speed);
 
-	if (!phylink_autoneg_inband(mode) &&
-	    phy_interface_mode_is_rgmii(interface))
+	if (phy_interface_mode_is_rgmii(interface))
 		enetc4_set_rgmii_mac(pf, speed, duplex);
 
 	if (interface == PHY_INTERFACE_MODE_RMII)
@@ -899,18 +876,8 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 		 */
 		if (priv->active_offloads & ENETC_F_QBU)
 			tx_pause = false;
-	} else { /* DUPLEX_HALF */
-		if (tx_pause || rx_pause)
-			hd_fc = true;
-
-		/* As per 802.3 annex 31B, PAUSE frames are only supported
-		 * when the link is configured for full duplex operation.
-		 */
-		tx_pause = false;
-		rx_pause = false;
 	}
 
-	enetc4_set_hd_flow_control(pf, hd_fc);
 	enetc4_set_tx_pause(pf, priv->num_rx_rings, tx_pause);
 	enetc4_set_rx_pause(pf, rx_pause);
 	enetc4_mac_tx_enable(pf);
-- 
2.34.1


