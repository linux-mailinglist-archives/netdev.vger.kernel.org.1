Return-Path: <netdev+bounces-252336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNthLhgqcmmadwAAu9opvQ
	(envelope-from <netdev+bounces-252336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:46:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2B4677AB
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87DEC729F50
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B439844A725;
	Thu, 22 Jan 2026 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IVlElCxw"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011048.outbound.protection.outlook.com [52.101.70.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898C42DC337;
	Thu, 22 Jan 2026 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769084524; cv=fail; b=GI27hzfaf/O2G8Qic0eZLDgS9bO9dvxEWgmC3aJ4gnx6ht0dZqks+sYZKfbayFc2jU5lc45Kpiz06tCH1DEh0Xi0b4DeASSixuR//h4vuX5BikMm/SaXrNOI8nqN8HLw9GNO6S2yPV2a8dYWt3F4TDl1Vyvu0aGLE563c+pOnPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769084524; c=relaxed/simple;
	bh=uqy9ICpalbKZreAaAMr8cryn8jV1hibOtVxxZVKumr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YrTumiHlRkhvd2PRfXydRlL24n9BKShGeasm1JTykp/ewe6QWfppHZzmXLen1hKvEg09cFjotTP7VKcHLlGIVf8KX0aTUGBXi42TV42a3K/SSFTdYccOEHQ6eo88SAmsPwlPmPPa8ivqU7RcA2YPO2Ca4Q9bw4QU3b2XywAEY40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IVlElCxw; arc=fail smtp.client-ip=52.101.70.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfsESMBGmt3oPLW4ERk+XccYeG12xjd2lNn40xWYr9h6k6JnA0nWKiypdFrjyZpY+WeEkingeqT7U7O6AA4vx+v/DNBjxBNFFEaq+i0+XhuoVADqOdFcBTlCTaaPoyfnc4ZeQSEBlRdBcDY9GuKh+/Gl0y2nzz3hpQNXHJOmSfUSmYMZD4vSAlpKPxh4cor2rCh6kEe5pQUNbzUUKdXpgH0AZX0Q94Ar+P5D515sA/ZiJKGK6j5Gbp7cqVH2XceMTP2XIllTZCcggi5B/VzLdJDc8jQtMlXbViuRhiS6g6npDfmfszTFb9vKm8ryWqIa0mFKWwfQLnJcsGPIsFEclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vXFdz+kEa1SIEJRpG1n1RCFpgyRvWH3ZCjy4ZuJs0Q=;
 b=zJ3kBQsv6KYl26mbfk8sBUDOY3JovnhnSUS+G1ZF0+Nbv+2XkKLQL1OlnBn5SHT5ugxeVbmo6rCMe6qv5r9oTwL+WcdZ3ywdHopWOxQWfH7/rKlIkN5Ze6a5NfAdtytMmHz8eNZrXYu+6hmrPfu14pjsCEqi+nc+ZZUHNyvfRkJyie+mA4S3iCREbxPQZJDhcyjtLbXP87cI+jaEbImZg9zmnqrSHMePeVDsSBoxKSCH1uNGqGtjkkQ9QHJPabpK4feb9rdKxQo4s423x1zZFtRq+2fOph2Hui56kGPKzpZvfWIAbcNqSdrQ8bNL/6ZmrjETufWpKxTF3OjhzCBopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vXFdz+kEa1SIEJRpG1n1RCFpgyRvWH3ZCjy4ZuJs0Q=;
 b=IVlElCxwzlHppmzk/GVSJvDc3c45/r0kOssSY/Ji+x8OU8n78kGZBKQW21o/BCqcVMgkEJFeH90fzs6FVOkOha5y1BDLR0jvCk4mZ+nYaYlqkt4+8h9jOiOfhjMkLsMjIBp4HAHr0sjvsRRnwjRzkn4eSpvJuLhsGlRZLwqJAbwsoIwrFjCrtQN40hEyPjaH74GM5km7f+2yJQ8Wn2CBZODs613LRGgPrC9MnXJa9trBf5XPdKqmjh+IinkLImwRaGhhjijVzBL6vr9ijTGhd4zEB1KCxGCQ5BPKfZnIBuq5HkjInFxPVNVju/bZLsvAOH3HPrbX3wtXq/WZD1u9jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA6PR04MB11733.eurprd04.prod.outlook.com (2603:10a6:102:51f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 12:21:58 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 12:21:58 +0000
Date: Thu, 22 Jan 2026 14:21:54 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v2 net-next 01/15] net: mdio-regmap: permit working with
 non-MMIO regmaps
Message-ID: <20260122122154.5j62eyhny3cek2br@skbuf>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-2-vladimir.oltean@nxp.com>
 <aXISv3Acm1v6yS4V@smile.fi.intel.com>
 <20260122121301.cyxyevi7xvqw2axk@skbuf>
 <aXIVIw2SKsMfNVUm@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXIVIw2SKsMfNVUm@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1PR04CA0051.eurprd04.prod.outlook.com
 (2603:10a6:802:2::22) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PA6PR04MB11733:EE_
X-MS-Office365-Filtering-Correlation-Id: 042f5506-4764-4889-cf8b-08de59b0d6af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|10070799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8fN5OVoTKOpy1Op8mqS8bKIORieRV9+oa1IqWOlVeE/gCLG6TjkLQL6L4f1T?=
 =?us-ascii?Q?Ikb8FKoK8q95V2sLvx6okocyzL6V3M6MWPccuVbTKMpXpU08YQZA3Qxc0DDJ?=
 =?us-ascii?Q?OGkIhrTIKCGZMh3jTi0+0/vXz+GqrqjyfPqzIQ/iCqDU515/hy0U3iStq5fZ?=
 =?us-ascii?Q?JroDViy/YdIyvsitMO1WbhJw6K0qZi471hgVQoQixeW+YqlUG864BP52zp8P?=
 =?us-ascii?Q?lT8AupfuL2KTSS3dVHNPydRqdKAFFqrCqC5BQVaePECMUevUpyAT4qXrA+Ch?=
 =?us-ascii?Q?cTHjSMKkMr/w7VXXGZFmt3KJAZ1ccdq6nle586YHRB2yXxM9iWCMVrqoz9SZ?=
 =?us-ascii?Q?FQwyVNCg/8fLfn4c5nxekIrn7r9U6KfUKoGlEYUfFvcLkIHqIE5J1NRFaq9E?=
 =?us-ascii?Q?8cY66h5XuhpdGEQAQ5eDKvu3vHtegimAFHgQFj1oaV0E5OInPb95yeiZQIhu?=
 =?us-ascii?Q?oJTNlb366f5PtTS3LeMy7mDWdU/S6+eaI+G0zcYNk5qd2KSNwG4Fe1/FauST?=
 =?us-ascii?Q?lAIHL6rC9eI1pYlJ0gws50kBqim2qoTIi5RI9TbABenSPD1XSr/Ga8f5Z08B?=
 =?us-ascii?Q?2FMLSFuKC5O74dxLFBg2FS7cGJJJKtO1dQFh9cEQYhueCFeFZK5/bvWsvJ94?=
 =?us-ascii?Q?FLrhOXFKxvIWmlK4G57ZhWlu4ABoWCbBjMR+LpfNnXrZdXvCwki8vcHafgie?=
 =?us-ascii?Q?lozYRdXL03O02ArUIFgNws04f/9N7TN7v+w6d2hEFtmQoDtidPNXjUAJuLUR?=
 =?us-ascii?Q?1jg9BTJVske5+TUAO3gt+ox6gnMC6VYa5m2jPtnYPB3yKOEP0/TIgIq011I8?=
 =?us-ascii?Q?8XHgzVl4A0sw5+dS3rA/Lmi8hNITkpbW/k0fe/1uvtwkZrbhUbm10evDF1WR?=
 =?us-ascii?Q?StWr004VKMBCFFwii/XnhAovlYyO43Oq5I+acpnW03MXXkbn0rZDX02L6b3z?=
 =?us-ascii?Q?Np7uDB3iYKT6QTo5P7ZD2s/LkBeqbOdKOSY3NQ+TnXoe2JNhLybAoc0e8RJO?=
 =?us-ascii?Q?c7tsplsyNqjTYXKuePN7zUYS8iknmsV/fZtdKUawY3gTfV2mwXokMpxGLgZx?=
 =?us-ascii?Q?a+NUapQ3eqFqOc5Te5OEeuHCOaRW4LxL6W65ZWYwx9iV56O35aJe8S0Hu3dM?=
 =?us-ascii?Q?hw95r2EsqeLtjY1NIyMvf/bNbE4yF0v4IugMKfaQWbZfxnjNKwlLW3H6I2Av?=
 =?us-ascii?Q?Zfk5LuapBODwBMugm1YRh+iVHt9owMQ56zOgcQHBWfFYNGVJ7fwbaXb5jHK8?=
 =?us-ascii?Q?GyZqmCgCVqv6Ospj6+kLd0WJdCn1oxqrQjGYCPpCjaztdIj1GhSBF91p8bvi?=
 =?us-ascii?Q?ovpb9wOr8V0YsvmJJq9Pka5v4Uu53AsNKex1Zg/EcDz8J8KL4AtWPK41KKbg?=
 =?us-ascii?Q?2/7hkn54NrBT9Pj2r/mSZsNlZFM/iUAyqOv4i04pa8kRcj/7hN0jtq69beeH?=
 =?us-ascii?Q?nilr7nJd+I4NPKFYFHLbVx351jNI/lwgAYLPrBqmTSfQ6p7pR0iV0UcUEVAq?=
 =?us-ascii?Q?Cz0FUPzEcmVNkDun2YBLs2xW3jhuXxvoHdiWu1D701KjjbWrdgq1zmj70aJV?=
 =?us-ascii?Q?KJk65wyce5pZQ/kEge4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(10070799003)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y1fejDrNbcKRjKMvNpfB5RfGMfJDwaBb8dS61oYP0UoLztVZIKz8WEZ4POrN?=
 =?us-ascii?Q?ft6vKCG3v2L2S4qyKJjyAKq7JmkArHvxCPlH7ogjGvmfYBMdsTMXQxvIBrk5?=
 =?us-ascii?Q?B0MCEDgJYroMQiAyEihOWo7tOo9Bw2GsXEAjKbZt3EwB/um++DALodlgJhX9?=
 =?us-ascii?Q?vXLEEvSuCVbA2R3Ush5xvh2DZwxul4/2wBNQWrkO8sCBDjygnuKiLI+APy/a?=
 =?us-ascii?Q?jWONmxG7/CLhkpSDh5kJbGfmaKrvG8bcacTgPtZdyCeOtU4Km6EztJbajOng?=
 =?us-ascii?Q?JVEINGup97wd8n+8jtdZ+cI5s4sfe3z1UMCSNPOfcadTnu9zngxHIiwerdFH?=
 =?us-ascii?Q?QMk/Fl8cpHZSxbYBhlOL26d7PgIRRwtPoLdk7ROOhCNQ2Ju3j+gangE1zp6K?=
 =?us-ascii?Q?bXPy7YxTbWjkZTuUdqZKcdcdShbfxyu+Ip7QYH8PzqkO5tOLiNmHjGIbjkMX?=
 =?us-ascii?Q?qoaTLO6xuqHU6yi5L52dNQg/PomRGZfBH5XTRmNldCdvuZoEqciL4d5VPdsU?=
 =?us-ascii?Q?p7jfquVjfrzfK3rpkT6sKniwefqQJR/RDNZ+jisLjinV+dU0OA4/9ix2tKfG?=
 =?us-ascii?Q?oKaG+DQWjI3orp9aPggqn4qpfEr4nlCerSlZkuC0LB9ZNBfdC4Qi1gNf7ezL?=
 =?us-ascii?Q?Yoz3FXpeuYHhHLneeQ4Tq4uxvDDdCLEqNdOoaFxuY1J8gcD+8hgaIivstoaf?=
 =?us-ascii?Q?F/YPJl1B14D5Y9fuD+Tfs0UenaSv50YEfXyi/QJDmibrhguRldBQvJf018Fw?=
 =?us-ascii?Q?kA/QblMEqa52hhVhP8pJFWS8dZe2rVlKiS1flI9Zg7RJx/IAYZ5v2pATOvEe?=
 =?us-ascii?Q?KJ/GPiTh8BXJEYcDlVQnO7nW5cmC2m2la4eFGVuxnOne6USSS9nIPMSYpf1j?=
 =?us-ascii?Q?enS76iSjzzM2Tnv6W5gftTfXO5UwadWNU7nUwmTfHGL6oa9K0BwR7r0uquZA?=
 =?us-ascii?Q?EtuG/y8bt4g0c9GBQWfD+Zt00tMQe0ehcWQcxzCT4bWkcYWUd7tCELc/wLEo?=
 =?us-ascii?Q?akk+uFOgC55ShjCl+K3EWnEWBqQMQTmX5PbqjkgKTTzYxeeVWwaIfv0uRrA1?=
 =?us-ascii?Q?q6HgfaOOXLWYhlgldNML/0CoP5NGWeaM33xVkjl6DA0lqqkDCiKxYel3iDvw?=
 =?us-ascii?Q?op2uNXDfC20ycDmECuC5A9lYbTMh6XSe7ES91u/IBt6SZh166tbw5fqtWGEP?=
 =?us-ascii?Q?mH07Ac65NUO5K51ro+NaMHaPdelDxmODrrEkPyBVBIkOM9HbYrTVXNTS4Pwz?=
 =?us-ascii?Q?kXB0wW4Lt8JxddnKrUlTdkb0i81We52+v0gQhSS+HbQQ4A9CZm96Dv3G4hxu?=
 =?us-ascii?Q?CVRT5nOl/Jqg2Qtu0VwFwrQSg3zquEJrxroXAYrhiBYE3sDFOkDZVsoXhQet?=
 =?us-ascii?Q?DAPuQ46BcREf4PPKE7ZRuOUBMFUsOD4ehYDr0+YLQtAHbVhDrX3K2DE4GTKX?=
 =?us-ascii?Q?P2v6RjHkJ9E6eofz2EngZliFmbkNXi/TrYeSahYHlpJln0cRorXyQrFN2/q5?=
 =?us-ascii?Q?f34mY4f69H3CIPXE8LfSCUVgx5lc2GkPEUisOSLN7ueFAUGdKffVZPrMG4zO?=
 =?us-ascii?Q?3uC9pPKHUzAKWjNDtp/2xlz9bGVf2g6ulnSUZXrCpMdBJ20FjzmhJoub7Ewg?=
 =?us-ascii?Q?aPgoFjdEIX6/z5yGNkuHJTXVi5nuxpgh82XBykdEeVs8oAZOQBlz2+f9J7og?=
 =?us-ascii?Q?bg1RsaHgtY8WFXjH5F3AKt1Gukc7tAhQ1woN4TM7wGc92bfYsGjVVHr6G/3p?=
 =?us-ascii?Q?kiPANsWd9/MC2hGx7ov1RBYRE/PSLrS4e/lKbSGakwdOYW5PsT+N7bkR3PEa?=
X-MS-Exchange-AntiSpam-MessageData-1: nvO2+jYI23PgVBWofnowbrzVIQeOM4qFq0Y=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042f5506-4764-4889-cf8b-08de59b0d6af
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:21:58.6358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4axdU3PjS4IfQioDgvJLV/RmW74UMMLVkxk7MnOX86H9MaWBjJh6KJiPfoDlq9wqjNNWK+3oz8DxFMTryr32g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11733
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252336-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,trustnetic.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8E2B4677AB
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 12:16:35PM +0000, Russell King (Oracle) wrote:
> On Thu, Jan 22, 2026 at 02:13:01PM +0200, Vladimir Oltean wrote:
> > On Thu, Jan 22, 2026 at 02:06:23PM +0200, Andy Shevchenko wrote:
> > > > Cc: Mark Brown <broonie@kernel.org>
> > > > Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > > 
> > > FWIW, Cc list may be located after --- line. It will have the same effect on
> > > emails (as regular tooling will parse and put them into email headers), but
> > > will reduce unneeded noise in the commit message. List will be still available
> > > on lore.kernel.org in the mail archives.
> > 
> > Thanks for the comment. I know it may be located after ---, but for me,
> > doing that implies an extra step which I find unnecessary (moving them
> > there after the git format-patch stage). I keep the Cc: in the commit
> > message in git so that it's preserved across revisions.
> 
> What I do with my individual patch versioning is in the editor, after
> my sign-off, add the "---" and put the version changes below. This means
> git format-patch will do what it normally does, and as the commit
> message is reproduced verbatum, you get all that included too.
> 
> You do get an extra "---" line between the versioning changes and the
> diffstat, but that's fine.
> 
> So in the commit message:
> 
> Signed-off-by: ...
> ---
> Cc: ...
> 
> Changes v2:
>  ...
> 
> will work fine.

Oh, that's quite a clever use. I can now keep my changelog in git too...
Thanks for the hint!

