Return-Path: <netdev+bounces-259325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G5QLYnklWneVwIAu9opvQ
	(envelope-from <netdev+bounces-259325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 17:10:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF131579DE
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 17:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A79AE300EF8D
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 16:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E40333451;
	Wed, 18 Feb 2026 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xi7UlQWb"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013062.outbound.protection.outlook.com [52.101.83.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078B22DC352;
	Wed, 18 Feb 2026 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771431046; cv=fail; b=FCc6ouI+ErQoh8NU6aUWKkYTXNTMf4unvk4lGznWUJTNVJFtMTy8DoeITMBPkRQ+N5xvLSgPPwYo3dq9ifd7oaQYAgO/TKGJ4aVkEVOQPntfAbGKftvCJS6QvmO+rJsGyhHw0ueZRb3aS1Z7zPPMB/UmSiC3tqAnryHUjCNEF2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771431046; c=relaxed/simple;
	bh=KRkgrN1I5QIpSqJQrHYgYh/ohfPlNhHwYzYMVnj2Qok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aUqzpgWTN1NpfE3pV7oBY0EKUHp8MYyeSV52fvOHT43voVEY3DLALRnEfjXFRKSMXJe182UNwMaeB588EnDtdxwUCYEaVnDzMghDcfdowVkAcx1Fai+/b+dJ/hXpknJBjvnueHvqrHzIjitsd0A6jbNs7/NfBa5aTZIc4yxnFa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xi7UlQWb; arc=fail smtp.client-ip=52.101.83.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIxmBoVW1K0osRaJ1plWMywvyWuE5/Rhud+XvZOMDTlLZzmPu3lyj7gKcrVdT1PS1lUau0O4JopJ1H/qsLDrBsvSnDKadFAIPLeL0NoO7rijFB/MjblZgeGiIE0rXFiWDocJZBhB0C/I8y13cXWYeZivc8bey8bJqy9WLiU/f1AJj63gy/MHQsojt+3gChZpsYDLxuQAMdC0KIG6LdZCiSPhleYlQzvLu+virZU7I1vwLZ6UIzku7H1ae88eOzVKmQ/UZjiOV6V/v4qUg/Mlmil4doHS+dxoL2NqfsEO0wbLzGv/Ao+kOW6A3kfmWs5AFgpia1FBwFiOqekxOwmF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPFI2VgM/jE6qaMsdhZ+q2Y0JpX2IjUolN1QVBDfIMo=;
 b=UynDTgD52ZJq+h7Ti0gxwN1KDaGcAcf5YvXevrA5/b+o1p0S2hgGEfutn2Lz7RRoMeZsmsSx0LZMT3YGse41eufj8R83b5VC3flfsbOHWuARc7czitlZE126cleGDQE1ct5IDP7k0J87txhA97HBvmHW8U4ab+iHIBg3ZE5b38lv3FWOs2exHtElmPAjCldRPssA3ixr6iRL7wsKMwHk159cMonJ1yQ/fT5jHZhwf2Ie3mD7SYTsFbNWElJOsO3HomLCGtQJFsB1yoQITtcOSokjFaboTDBmnwwmZ2Xf2GdLGIUqIiigcLoOegthmGczLz5Crza7StHJqrx9REeXhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPFI2VgM/jE6qaMsdhZ+q2Y0JpX2IjUolN1QVBDfIMo=;
 b=Xi7UlQWb3MzFrM//DfhlPhKBgzc1zQndjyE+Mhy/EE/e52rIyX4ILKIBkr5lxqXR23VK7bm13X+sqSIxLu1/GcecptGPyvMjWgLzzWMao6ESBAZpVlNVTzod3Qqt9NzSnRBADhSsvx+xuyPfQSYZudRvdTBrLmPKYBCLsT2J2i9pm5rix/ksTw12THJ6SVW5oWpsJO6B5rHPkcaAG/M3Q7EdPV3TRouBvwCJgxr6yMePnPSsew5WhvcsKIKBX50FIJGGFwzzjHxqgJpzOQnc+pG4xjIhKF7oq7KPHwryQlQtRvZm5/c8ZSFnzR9YABKpSxxxDuS+7pv6GibBKv4akA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA4PR04MB7997.eurprd04.prod.outlook.com (2603:10a6:102:c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 16:10:40 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9611.013; Wed, 18 Feb 2026
 16:10:40 +0000
Date: Wed, 18 Feb 2026 18:10:37 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: dsa: sja1105: protect link replay helpers
 against NULL phylink instance
Message-ID: <20260218161037.a4uyxtku2hbsnfzx@skbuf>
References: <20260218160551.194782-1-vladimir.oltean@nxp.com>
 <20260218160551.194782-1-vladimir.oltean@nxp.com>
 <aZXj8QbM5-0tpl4s@shell.armlinux.org.uk>
 <aZXj8QbM5-0tpl4s@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZXj8QbM5-0tpl4s@shell.armlinux.org.uk>
 <aZXj8QbM5-0tpl4s@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1PR04CA0047.eurprd04.prod.outlook.com
 (2603:10a6:802:2::18) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PA4PR04MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ac9b7c-1fe2-404c-7456-08de6f08427f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NKAxgqIY86OunWi0GmQcmQLYAlkr3bHwroq/otBdsm6OC53ElDrd/PdY3NBS?=
 =?us-ascii?Q?z8kRXJSmcVyWYjM76Sfe5PUyS2BWOJs6D+VqfruuDXdTuCK5h1jkqyQowiBe?=
 =?us-ascii?Q?UVLkiGzDK9vvtkySMGPP1m4va6+uU5aGNHxZ2UG5IfoyIrz31XKPe0HQbzQH?=
 =?us-ascii?Q?8u46T5ygcsUglKA8dvrYGksCeLqB3BkNr+86oSHS5lgzrVy6K6T7AKbw5CJI?=
 =?us-ascii?Q?fdN29o4v3CflFRU0WAJgWLhmO06PvjUytggwTLef09NPlzSX/7bR8GzkMFsw?=
 =?us-ascii?Q?1K+DdnRi1Z8RTxGQdDwJPsaDQRxaFLEk4Qkhe0HSPzLSe+ku7N7L3snmPRfw?=
 =?us-ascii?Q?dnWFsjG1efr182VER+3W9zuapv1TrnXWB+DeJURRAafK8DKXLkulXV77D+ue?=
 =?us-ascii?Q?pNkWc4SiHsRTebsfngdn8hcIvv9SZMd/L+se4h5LGlJeYrJBlDGBfF1OcJQb?=
 =?us-ascii?Q?ed0ZR8I3Fppyk3thF3CpVS3edd+3ImYFbCh/jUOTrsLreq2LjNHxujoKr0J3?=
 =?us-ascii?Q?jR9A/gZ4VkJFDsHhy7osrg5uLQ+d9XUTBk6w4dTOl9Ehqo6X4skHI5a5qBk1?=
 =?us-ascii?Q?yguKuGZPi82My12kkbtBvfzaFQap09eJ3hPfIkVlrMZfXgo+bQLgyMiI3Pvc?=
 =?us-ascii?Q?4wjTafYxniq1piwGUJ8mUkbGIiSkGc3nhqD83AfP5Uz5gC4DIUskzicI9+kT?=
 =?us-ascii?Q?xHwIUOFaML9uX9xh6JfCg0ESv5B+6YOhvlC9Kh6Jvxt9FcZAyU7puZcCpi2j?=
 =?us-ascii?Q?uMVU4MmuFT9gvDvArd3TjSQK0DrXbDIGwAuhsfowLnwpBGECitFTze6jCXAd?=
 =?us-ascii?Q?IfjQvVvRgsNkDyCeC7yLd8xkHTuwJ0k0LMg6FZfRgxpUFzP4VtRlYSYchWdg?=
 =?us-ascii?Q?txmN0EYF4WhD8FdidMylBkK0g+u+gbmCC8/hkJ+dIxKOCkGKQAzPr4Ni+lDk?=
 =?us-ascii?Q?warIW+v5NXrFQwf2wD2kxZ4GpY6Zfs4ffylu8H2pdocKRDjubsSaN25YOl2t?=
 =?us-ascii?Q?h92zGTgOpJ9J6eGDq+Bg1aRt3vUTjD84ZwQAiXKnoTlDzrHIJPLZRGOFPmsk?=
 =?us-ascii?Q?fH5Bmwet44aVlk1subsT2goRxzTTQcNz2Zx5sHlNVXJoGMNuK6QtxCy6Duib?=
 =?us-ascii?Q?+mOOEqw3PVA/8uYoBDBpY7ASi5M1PL7XIneg+GtPKew/U5Wv9je+1uOu9zFX?=
 =?us-ascii?Q?80CHDfGyjBMmVERxqkkXSMzLPaQ3cmMscUdoiVgwP3ZRfu01ODbuOvOeHyY+?=
 =?us-ascii?Q?C3Nw4ExZjX8Im+XXfYks3qUlrfGpvkd9AxBFJQVdjim3WQmwANzrgIo2PL4D?=
 =?us-ascii?Q?MR938IVACeSR1otqxUyqKnGoWuOEt9IU7kfsl14NY8/3E50EgdhcTUpm/LM6?=
 =?us-ascii?Q?OjsJqz2WioizbSddPLvTZS37cI2QlakxXMUeZM1xC8jhLY+aVUrX7wYP3bL+?=
 =?us-ascii?Q?E/1YSBLO5+4l3hsZ/e5fApVrlfH3tm7CPcIqor7NTOAIe8jAhlk2snJaBrjd?=
 =?us-ascii?Q?gQMw0Vb1swLBKgIlNvZBzAbQUXZpDbFUaSNJiXKzD0h0daM1Mzx+QrR+Csg1?=
 =?us-ascii?Q?+FmH8Ejc8/G4XJ+UGAg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wMG6qp7ZXjRJzcpXQdJxYv8rHkR8kkbyWtXF2zyNvigrhwUDjbojXfBcev5z?=
 =?us-ascii?Q?9YosKCv+xBaGdmU86kiqv7SCnoXVRnhNJrd4Ij8VmJLKsClnSq6TYwnRTMqm?=
 =?us-ascii?Q?xypUpDZQKqTyANqxsLQSYmxW7fACKX9rFtV+qwoEQEgvKe+6pLDDkZ6wA7i3?=
 =?us-ascii?Q?XIJQqYZr/L/DWy656+nIigHO8BMzHqGz1oC0KpM7D7R3tq820O/U2hHgEl57?=
 =?us-ascii?Q?iUzSW581MGReEtK6bzDhTEb6sjwitYv6wcVVkbmyFQcfXxCiQ5yx4gayEh+s?=
 =?us-ascii?Q?5OY4DbtRelv2A38HSRZxqi1RLrbRNtdOAMwjD5ieIMF01lkhJzFW3fT71wKA?=
 =?us-ascii?Q?DcSuXwquLts3AKPcq2L+gfpHz60feN10CodDgps7DIcyIwUfYoB1lhwRDzrc?=
 =?us-ascii?Q?RFsznUmpVZ8L6n8WDnAq2/UV4vuVxluna0DN7OJS+Jf6Li/nyd6bH1XWZ+fM?=
 =?us-ascii?Q?7OsAOUSNOqzln727OGrwFAqJ5FQTqT55M11RX0ENW0rGv4pAbaqNtj5f5etT?=
 =?us-ascii?Q?9LFgPoctHjxMJGNqG+ZB6EjorHBm2rQUGYaRHmqsF44PkMMrp9ZNNoONPDgS?=
 =?us-ascii?Q?LfXIwIgQTYc9cx34yPrYPL+xN+pzNQTa1hOaT0iJULSsttBkA0M84umKsi/S?=
 =?us-ascii?Q?iLQOC7paaHvq9mE2qPy2ZiWGGtAHaysRZRe8xEsoJ9Bjmfb9bnMYsabJfUU3?=
 =?us-ascii?Q?iby6EKjYdKj+QD9rPFS59v9HJS7FvY0RTR+5CJ7w7PKSNPAa+EvNywDqx6ix?=
 =?us-ascii?Q?5BPuNbXKYfyiRuMK6dtwLnhfCZ/Z2Ms7yl6NBQArMOA+ZWfxJeGw3U4IXTrH?=
 =?us-ascii?Q?odEKSnUaSfz+X0+nWWsw3dY094YTWeZLvkxWLtHcB/bxm2SjMd0b1N2X4Qci?=
 =?us-ascii?Q?fNrNcoxWUp7y8WbPZqr23BLx7LrAupM57BXLsHRdsg/fcClgwUFsDDXVqoaT?=
 =?us-ascii?Q?PJ1UuT02jPJ82v1J3a9NEhYsMsHs3uAuitgAyycSnolaDN+Ek+t/nVmIyDwS?=
 =?us-ascii?Q?fjg6Gb/RQBn0PYpNWB5fJiwN3hvQA78Y5YW1bC2dPeneDIhddRPEkvWcT/gU?=
 =?us-ascii?Q?AvkJfrp08SYdtSuEQ7waJYa80PlfChuKG/xyM/T0MiRlnnaGFYzuS9jjvJCd?=
 =?us-ascii?Q?ECVnfgRCHGUWNFIqDKwbrT9mPyyeCfcv+raDHIBszJ3FW1efTyg6b4HVxFgr?=
 =?us-ascii?Q?Zmi9ZW8EspzB8NsyIVH8X0vGKL6XaQYbFuRfv1ZBQJt65F0547mQLvbO/Unk?=
 =?us-ascii?Q?aGrn7DCZGdaUwKMoxO4q84giVZm6glNW0LNwCNpRb4BXyo3UfzwI+YEbvOqD?=
 =?us-ascii?Q?j8HbOFayKyzky+lekcBLLOnfrpkAy/2d/aG3R/7gCErSLnh0KWceUbX+4h2R?=
 =?us-ascii?Q?XeODcK3V/j5vDlEpiUZ0N/NBq1Rw0ShLrnY3sxu/YnuQMBGBVZKRfeOXlrhB?=
 =?us-ascii?Q?QZfSs1sU/Ksot9Twat55PQoe0P3lMv6lnxX881a1/IeIL5/4wXf0pR4hzdrs?=
 =?us-ascii?Q?IIKPR+pIV6mQzW++DuoQBc0SMnOtAKiUwGbf7iruCueQNav17JtggYiRaXy7?=
 =?us-ascii?Q?ZHaAkELdY76CoujEA6v0a3mF4Wo9rdxFp8JvRVrrFYrjiZeGpLJsdoIXW5kM?=
 =?us-ascii?Q?A4EJBsUAGEZMCopMs0/bXCAvAZrJQEetGpfvD6GNPKr8Uz+fTfJUMEw5jdT8?=
 =?us-ascii?Q?9pQbPSQfWL5DnO0VulM+c1x+ISdnahmyRI5O2KyA/pW6K+kyZiovFoSe9OnN?=
 =?us-ascii?Q?EuzJa9eHjxtI6N9ha+qp9bAMoD5G2BRPaS2veWFLUJGrR4kQOOwsgQpilPd3?=
X-MS-Exchange-AntiSpam-MessageData-1: 9c6iR4tsgnWrwbBtDiEe+wGipMpByWVH0Vg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ac9b7c-1fe2-404c-7456-08de6f08427f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:10:40.0929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95Y7AKxIU0xer64ZJkilR3EPT3dU6AeakadNEhGlbpV/RqfgDUn6naEudBvsR7jXLdWlLWDUxMMZinEwbSQFLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7997
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259325-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BF131579DE
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 04:08:17PM +0000, Russell King (Oracle) wrote:
> On Wed, Feb 18, 2026 at 06:05:51PM +0200, Vladimir Oltean wrote:
> > There are multiple levels at which this could be avoided:
> > - add an "if (dp->pl)" in sja1105_static_config_reload()
> > - make the phylink replay helpers NULL-tolerant
> > - mark ports as DSA_PORT_TYPE_UNUSED after dsa_port_phylink_destroy()
> >   has run, such that subsequent dsa_switch_for_each_available_port()
> >   iterations skip them
> > - disconnect the entire switch at once from switchdev and
> >   NETDEV_CHANGEUPPER events while unbinding, not just port by port,
> >   likely using a "ds->unbinding = true" mechanism or similar
> > 
> > however options 3 and 4 are quite heavy and might have side effects.
> > Although 2 allows to keep the driver simpler, the phylink API it not
> > NULL-tolerant in general and is not responsible for the NULL pointer
> > (this is something done by dsa_port_phylink_destroy()). So I went
> > with 1.
> 
> ^^^^^^^^
> 
> > v1->v2: select option 1 instead of 2
> 
> Given this, I think the paragraph above needs updating.

Sorry, I don't understand what needs updating.

