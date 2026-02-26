Return-Path: <netdev+bounces-261327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK2UBgI/oGmrhAQAu9opvQ
	(envelope-from <netdev+bounces-261327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:39:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BE51A5CC8
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D0A4300E70A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED82B385524;
	Thu, 26 Feb 2026 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M4V4xnKF"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013064.outbound.protection.outlook.com [52.101.83.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B106A337B95
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772109415; cv=fail; b=rj2q6I8WQ39WCTmQpQrqcAyaTTMHpixyJUcNRlpPsTmTDXwtYJJIjz2gUzkR256KV35wShBke/dDYt34uK5DyEpYT3fdY1jAac1ZnjluIk1tpWGz+x5KJHk/Ugz8zYBcER3dehepp70e31CZNUpqxbfRYiOFR9sUkU7r4NktpBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772109415; c=relaxed/simple;
	bh=YjnQenPwOIKIG3CGXP+1DyZHSyB6LA4ow/pNQ/pG3DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jPj5wK17dvE3ZUCjuhZCM3N8jpoxvfZZPh4dmP9Z6B65WmGQKV/Otw+FCpNYD0xF0dfwF/mD83egPY7sJ7mtyok+LvYLQR4lvv0HS5yE1HWNVmuoEGUOrheQLe+qWzIkVvBaDcEPYIXzNRrbeQF1qAwUBvn7/b7vpyjMydzFBfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M4V4xnKF; arc=fail smtp.client-ip=52.101.83.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlVMO2k/TL5IODPtFaAAqY+xaOLkXkBxtscqxv5iGmXbno3WxX1ud/8w7Z7298SUgd6vpUTNBZmJZAYD71PsIelFDpe4GGn63Kn3xAUYt6rg3NY6nXqDdS1cnXOvsOLmO/QA7mU5/NMnJknZr4Mr3mq0tm2WZo9aQsDtfVQo/SHZR25hthzLFcgUSG1wthHwmU7jDWeo/yVx97uhZOqn2uJgoD394BL9PxIBO/bKsFOPGlU6uJhyz5gVMt/l3dF2JTp4UXG8nMBMheZaDzu504rhSLAILknaBCgNdcjkOniQTszLwvq1x4HPeSYuwngOfYHfKpPO9/NivvTpThdS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oB2suBo89CFXNj0xc+uvhID2bJDwtcqP8weBYUy6aU=;
 b=tknKTvLfj1f+s4M4J2V5rSQX2/EVvjmDKifJzywliNfLjCoHXsYLD7+c/d8N4PTaFC6Rsx1Fr2AYEnl7MB1NH5bg41dbe/k68bwE060GKs0kVlo6jUbwIxPoQr8WV4s8SsPPQMrdI9TCyKK0rGczuBXZSdOcmKTKpG5WvYGhkJDCj3MY9kGD8lvoZJ0RJcK/UL2Vy+haD4yKgd6/xroUv5R71Do8qtR26OCpWN6N1vrSIR4e/WISKEOrSa5zHdmQUJ2GaHdXTHZMzpMfanpWatAyaiMGuox6KOqiKYQv3XCMo7aXjJTznkdQV/7V3EIP8qFRkAKthavZGIO1e7Lv8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oB2suBo89CFXNj0xc+uvhID2bJDwtcqP8weBYUy6aU=;
 b=M4V4xnKF+LeiPYImA2xP08sl+D7WP38915dbRvKvJMzChDHIThkzSjZQhb/cRJUFnnGjDKxqHiKC/DOGzqjlp2GDyLsePT1rSSgFRlRxAURCLqjR1JcLM1GbJU82PgmC3cnSvyWnkwegHxE/xnhtLqmztdI1T/aevRoEdjQTmBVWTN7u7xxfGJ7fCrP2h8djfJuDdpxEiyKl3kiRWtK8X7hEeRVqmJuBSQHxk2UaJhRwH8XsMwzBVedgyp28zQXhP1yiauZSKZmNumitPUxRqh3HT5P/r7keCDm/oUcLj4/iZCm1WUlvGqOmwb62gz0Dq852Y2NWKh9nordtLyYkVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB7554.eurprd04.prod.outlook.com (2603:10a6:20b:2da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Thu, 26 Feb
 2026 12:36:51 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 12:36:50 +0000
Date: Thu, 26 Feb 2026 14:36:47 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Patryk <pbiel7@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: 10G-QXGMII phy no autonegotiation on LS1028A
Message-ID: <20260226123647.kvv7zbu5ijkbn6jb@skbuf>
References: <CA+DkFDaW_wJ5p9_P7pMpz-8iE6xeKkdF-MQcd2m2GcyVUE3S4Q@mail.gmail.com>
 <5bbafc78-9dbb-448f-a86e-c5e94618f2f8@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bbafc78-9dbb-448f-a86e-c5e94618f2f8@lunn.ch>
X-ClientProxiedBy: VI1PR02CA0063.eurprd02.prod.outlook.com
 (2603:10a6:802:14::34) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: f24f72bf-f918-4da8-fefc-08de7533b6fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	ynCEjWKtX0vxi62PLMoEiyUunKjQyngqFoJXCF7HhImyVB8a3XLaEn9nfjpCLy4q3Z2qHMq3k8MLsGnp7xWunp9XIxCZjWX1MGPzSMRcuN5nxFmV6+iD6AgoozAROM4pgwqy8YyoAUxc5ikIEZjwT7B6f/P8YkpLvoyFaar0lG3fiiIKCH8VIpTJX8N8BP6moHhi1u5GOvevhkuEoATbvKos7OBmlRMQeRJF4DYgoEJMn0FP4Y9BwFDaBtzRTigMu4bnQGMQWyZEpgS7wl80yeMmXvZpBxytHSrphxVfp18s1dXHunowldsQml5Q+doVnWTNz2pASaA7j0/b1vT4vQKNHpU9IwDTQpYSniAMO9YPFEFF1F0tsLBwstnJ2rKqGKmYw4xPLRrFAw0bokk4vefL1a6toYcG+kQNxCno+2/4OA8AGbzKnqWBWJqzxa1Y6M6Q1TbHfB4lK3gqDCqQD89FzzfbnZhY1aWMHibav7rs1umzbdyGEhQUF7eSVrKVqtMFnk4erPgJX+HfFbNTHK2l5P59xkdHsipv4JNmKvP7HpjGsHgqTEcfAk+7SPqakIw3V4JSUqJi1CKnSRznt1oaz72rMdiylr0JDUBj4ihUBSjZ0icJDQJi/yGREMjW4C5ElC2AOKLJYlT0OQT2stOvVZxVF3sTApEosf8ejeOI5yo76PGw+TLQOWwgwNYk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L+eMPFLt7ZEi0svyam1iB2++9BLI7cd3ZCCZxfHMN2UaYS5fhAnepHHJVetF?=
 =?us-ascii?Q?tqSAXsEM4FIfLf5RWfuXXCz0rIwyhV2SejRUpv6c1i+DkdwghuGo5hwXxCKc?=
 =?us-ascii?Q?KNRUrJGkEahTlo6YoZOsdLS6qc8FdXdgvg5AcfO7P6QwYdDczy9e6qJNsQss?=
 =?us-ascii?Q?7zV2u6+9D9TlhsNTnfQOBk7DVTmsOq0bbmupPRZA9lUoTBd5eWgIkI/DByOK?=
 =?us-ascii?Q?8ssbYY/1rOHOH2to0yHcqaKe8cUBt112E/b/PtMHxVNEsfjDa5eFX83aqpHo?=
 =?us-ascii?Q?JdTDUKqbFpTIK08RK4hCRbwyjahDN8dAp8HRyCiX2UF2wmbZte8PgQ485Pkn?=
 =?us-ascii?Q?BfnvQIn1yTjQQK/dK/OTgFcZEoexBt1178oR1/8K5Ws2ajhMgQLEckGBaiqc?=
 =?us-ascii?Q?a8xpenWfFNxaZSZlkHDNVyhf7R5gKnhsVNB6dKygM24bGkjqg013KXNeYcbF?=
 =?us-ascii?Q?sAH4ZsTdpaSrAxnzNb9Dy0jVd+cvfPQRYXb+Avwc1dZhCcJwvHsswLacC/A3?=
 =?us-ascii?Q?727zpRoUmgIohbm52E2zZB5vj0o4J3gT13Kqpss7n7z/4ltMuPJs5Dr+9nqx?=
 =?us-ascii?Q?B/sPuBs+FI4xBpgHcJ4eaM8PHsYBVnoC5ysLUyZe2N/xSWB9GHPrkVpH9+FN?=
 =?us-ascii?Q?nPuu671VwOIs95roApTnHZPTBT7V5Pt3Ml5bnFZcLVpbWM0ag+CD97VAhNAA?=
 =?us-ascii?Q?Zq0tSGUZ74K1OqY7tILhGhGTfF4VkPTSBeHm2DAtclaajTflslJmVXnxPKUi?=
 =?us-ascii?Q?9qZIz80ER34YsH/Kl9emGPuaQoMUTs9lHN1YKEl09AVCPR2dHJOJryWCO4zv?=
 =?us-ascii?Q?8OWM/T2UNIbmtNzeKK79e4SqEs/ZWN+S+3uRsr5+WdPcQ/81XP//rmfc0Xj1?=
 =?us-ascii?Q?m13nwAA9NKbfBJOMswiyH3wBmcRuDpKg/52lWXjW2Ird7qBo0E5dnWijjwdu?=
 =?us-ascii?Q?jTSlOh/eWkilfYcBwBTptqaf4NUHpE2Gfhng6V/vE/eOOoWZC0R8KDdHc0ER?=
 =?us-ascii?Q?tskFEt2fTkUp0ou5h2WY1ucqAbzncGlK3/YNzBU/AcIBCE9IvAZX3Nrmcs7x?=
 =?us-ascii?Q?Zs9QJ/97QEaBLQ/FDKOJjC+8kYhkbv+QlGZw2ZprbYTQs++JuUU47BZzUsXL?=
 =?us-ascii?Q?1RS2t+s5u/2BnK5wm0kz5qxmssvm8HWqGXl6gWgfFJxvenNQpillwVvYcHIU?=
 =?us-ascii?Q?oJ/JQc5GV1/FavBKm+dmthYmSfYUuJp+rdFxGlGPTfDPCCTu7+LaKwF9PtMO?=
 =?us-ascii?Q?2zdEaQeaUVPGfj/WAkLEPqkmGyM+k6gUiqYMxTaShz1ZNlVufhnEoic/1ccp?=
 =?us-ascii?Q?umf1BJmMrjdMqOckbIVa3CCwQeLRAtHkhJs0e4cchfeKthKqDgN7TUTJG/U2?=
 =?us-ascii?Q?vvBaCsqpq6j1lSNTmCV5huur5mLmMVrY4wJU1MG0qSWCJI5XLnjalHB5xqZW?=
 =?us-ascii?Q?wF2sPk/eCZbiGVwZxCSbMAgEvhNDjW42pt8BCdOR18GPyRI7lrxsW9Z4ePzy?=
 =?us-ascii?Q?/xCb3kZXvK/tGCl6KQR6LmnOwEJtsj4xHQrWw6fv5DZPX0WDo2Sz4/Hzi5wO?=
 =?us-ascii?Q?jDYRS9E3pMq8xceMmaFle75DLRsrexYZ25Y+2LrMRAKiDBQl6SA783NaNQp1?=
 =?us-ascii?Q?5f8oGiEra2y2Sa9ZDXMzja9WekXNmpVruLwmeeb683ZBc1xX6+BzK77lXWIP?=
 =?us-ascii?Q?KskfI3CSYyTBrENJN5eTR4dYHNSRBMPMK4fZyX4JhQDMW8WGxtHWmTifoYaG?=
 =?us-ascii?Q?xuKuqPbRqLA+6SaLJfYABSV3UPegfiSjLvVDFaMDXHCoS8PbSBt6ClzBO2iY?=
X-MS-Exchange-AntiSpam-MessageData-1: TSBTQSk1b5w9fXe5JGWMDdx9LBR0ln2irHo=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f24f72bf-f918-4da8-fefc-08de7533b6fb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 12:36:50.8632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcpSsTrHImOYqXjigjOT785PugLxvOmh8NAOI5FhoT4502zvNHubg3rLpMnIBK32KbLWUe7JEuwmmdFrjsvQoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7554
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261327-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70BE51A5CC8
X-Rspamd-Action: no action

Hi,

On Thu, Feb 26, 2026 at 12:26:30AM +0100, Andrew Lunn wrote:
> The call which is supposed to start autoneg is lynx_pcs_an_restart().
> 
> static void lynx_pcs_an_restart(struct phylink_pcs *pcs)
> {
>         struct lynx_pcs *lynx = phylink_pcs_to_lynx(pcs);
> 
>         phylink_mii_c22_pcs_an_restart(lynx->mdio);
> }
> 
> This is hitting the normal MII_BMCR, where as it seems like USXGMII
> has all it registers in MDIO_MMD_VEND2. Does this go together with
> what you found?
> 
> The problem here is, lynx_pcs_an_restart() is not passed the interface
> mode, so there is no obvious indication you should be using
> MDIO_MMD_VEND2. Probably lynx_pcs_config() needs to store away ifmode
> in struct lynx_pcs.

This is the wrong path. phylink_pcs_an_restart() only calls
pl->pcs->ops->pcs_an_restart() if
phy_interface_mode_is_8023z(pl->link_config.interface), which
PHY_INTERFACE_MODE_10G_QXGMII is not. It is by API design that this
won't be called.

> On Wed, Feb 25, 2026 at 09:32:28AM +0100, Patryk wrote:
> > The problem is as follows - the pcs-lynx correctly detect the USXGII
> > link however does not detect the link partner ability thus, the link
> > never becomes functional. It looks like the autonegotiation on the SoC
> > side does not work at all. I browsed through the pcs-lynx sources,
> > looking at the LS1028A reference manual, and I've found that Serdes
> > module on this SoC features some MDIO devices, whereas one of them is
> > "QXGMII USXGMII Replicator" (LS1028ARM 29.6 MDIO register spaces for
> > anyone interested). I checked this device and it features the Control
> > Register, which contains the Auto_Negotiation_Enable bit that is never
> > set by the pcs-lynx driver.
> 
> I'm not the expert here. Adding Vladimir and Ioana to Cc:

The problem that Patryk has identified is correct. Both PCS and PHY
in-band auto-negotiation used to rely on U-Boot pre-configuration to be
in sync.

To bring some context, the U-Boot driver for the Felix switch does
enable in-band auto-negotiation here:
https://github.com/u-boot/u-boot/blob/master/drivers/net/mscc_eswitch/felix_switch.c#L200-L201
so the reason why Patryk is seeing this issue is probably because he is
not using that driver.

Not depending on U-Boot pre-configuration is obviously a great goal, but
the infrastructure just hasn't existed until very recently. Again, it's
a combination of PHY and PCS settings, not exclusively a PHY or a PCS issue.
This is not the only place where an implicit dependency upon U-Boot has
existed.

I've tried to fix this before:
https://lore.kernel.org/netdev/20221118000124.2754581-1-vladimir.oltean@nxp.com/
but due to various reasons, it was a too complex issue for me then, and
Russell King finally introduced the framework based on LINK_INBAND_DISABLE |
LINK_INBAND_ENABLE relatively recently (Dec 2024).

Without Russell's framework, we would have no tool to set the PHY
in-band settings in sync with the PCS. And PHYs may be paired with any
other PCS, which may have different expectations. So hardcoding any
setting in the PHY driver is an obvious regression risk.

What we are looking at here are the loose ends for 10G-QXGMII, where the
Linux driver was just assuming that U-Boot would pre-initialize in-band
autoneg, and just validate that the device tree has
managed = "in-band-status". This is obviously insufficient for the new
world where we have API in place to ensure PHY and PCS settings are in
sync.

The good news, so to speak, is that I am not expecting regressions if we
were to configure 10G-QXGMII in-band autoneg in phylink_pcs_config()
according to the passed neg_mode, and remove the "%s only supports in-band AN for now\n"
limitation.

Patryk, which PHY are you working with? Are you able to also patch its
phylib driver so as to report both LINK_INBAND_DISABLE | LINK_INBAND_ENABLE
in its inband_caps() method? It would be great if the mode without
managed = "in-band-status" would also work. My notes on this topic while
I was working with the AQR412C didn't show a clear procedure on how to
disabled 10G-QXGMII in-band auto-negotiation.

How do you wish we proceed? Is the above context enough for you to
submit patches, or do you need assistance?

