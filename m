Return-Path: <netdev+bounces-252329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K00GvQacmnrbwAAu9opvQ
	(envelope-from <netdev+bounces-252329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:41:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF64266C2D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B3E6940A20
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AD948095E;
	Thu, 22 Jan 2026 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HYebaItw"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013021.outbound.protection.outlook.com [40.107.162.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BEA44A70E;
	Thu, 22 Jan 2026 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083990; cv=fail; b=Ro9k6RPdAgR4qU2sNaizM83BJatm/9kz9A7KIuO5XOkyVbOCAzMpcG8KTEbk8AGGLsgfcTLEpmt/H95TK4nvCzaZoZxM3ot5x+i8dpGKl45RxqLhoijHxYvcYvYpaVqYhLwmbzEDIcjxjUOjiL6mEP3bpwgsCWJ+nflnEvKhWXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083990; c=relaxed/simple;
	bh=g4j7ixRtIfS0HYUFlVzO0FJ+++olO22FTmKUPrhe2kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WIWPbRlOQ71WX1RtcowuMHCO9lHi3NIw7ql2SwiB/99OPxh+nTrg4vNNar314nkjC/m5MkpRL8+oxXC+6j4HLS3H609jp9/nU1QVK1jb6ilhZ8+eT7NQnqG1mlNx24xHp7tXUlzupozbSckFIUnAU2UtEVo7jpXXGVtVr3lbwos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HYebaItw; arc=fail smtp.client-ip=40.107.162.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7LeSEi6RVsVq2ycGI1WuYV36x1bDjfRFQMpyZ2/jTFJq0yZ99tpFJDeqqHh8oDGM+q3pfUBPXo0KuQesITPvqQIWVGpk4ZJA0D/iLovrTP1gnWKBXteAqkkkco8EKiiU6Wq83fsalKuK38X7gnQjXtOSrNOrG0rWdqPmcZ/mZ/LLC4rqauf6p3+5OdTCwTSmNppt79UXNuCWLv6CbipVscx5DX0qK+hlwvh6Bq0hExMAYcjVdTMzbG7FxhCrW7NzTYpyK85T5bu5r58WOpFvUTv2/GCx1mYan9gEK9pbe2z43okuq4tjuXOfEdY/DAYHnexDzctzAIahCJkajl1sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9tMWKVmPUgyj/CR7PcmyEn6d3luud85Ju4f3NcczoE=;
 b=lumKoH+rZvhLhjcrPhahQhFcdYsK3Pqe3142C7pXJFYrt4YTLI3Cr3I5a5lAqdssChKiOuQJr5uJ46Z9zFqpAhAKrljEknqAbPXMPd9MvGXFotE2Aj138i8GPpIlLPZIXIdg1Pd9iv3fHMjseDp57r7vJ5hH0YjXunM7yvwQ6GqqwoLthRdKvYo32HQDZiHdzd6N7JIY9C8uxe5wL8AfxK6GCjTPdXt9oVc9gUQprLahIQjFBREc08wD/KC5cdh9Gsq7LRrPsq9MoY/NzOIRCP9F0HOZ1FUT/kBEhH/kOmSLkWWJikdtRQylHYjCIs7P6IF9mbTt75LDM7Es9/qRXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9tMWKVmPUgyj/CR7PcmyEn6d3luud85Ju4f3NcczoE=;
 b=HYebaItwLc3E0Lap8bK9mNqn/i1KauroI+swI338E9MXxl0wjvqI0dQNBiJn7LL9J24SuKHA2sAZVRoRbhmmgjKZ0DGzhCA4Bb/ySJhogWS+Lzr3KetxsE45GsG/vTuAJ1TR2IhJ6CFNZPP1aKypvLSnnZkbqdXbGDzT39lAfgLtoDOCB2kOklcPOuFerazIKEuRuZAusEzu9O1sqGbCvHyDCWi69PMLNajrFkmaxfLSs5Xa6fzPJzen6KjSiZV7o1yaIBMub+TZR6ab9bnIdKuPguwMJJJeFJazSA4/dakWWgUlWO+NyXIMN15w0V3MJS640bz5keS7CJJ/H2ZaFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA4PR04MB7791.eurprd04.prod.outlook.com (2603:10a6:102:cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 12:13:04 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 12:13:04 +0000
Date: Thu, 22 Jan 2026 14:13:01 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
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
Message-ID: <20260122121301.cyxyevi7xvqw2axk@skbuf>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-2-vladimir.oltean@nxp.com>
 <aXISv3Acm1v6yS4V@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXISv3Acm1v6yS4V@smile.fi.intel.com>
X-ClientProxiedBy: VI1P194CA0030.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::19) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PA4PR04MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: fedd04f2-9d27-420e-a38e-08de59af985e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|10070799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c7k8taC1Su/g3I15ChU6kJrIeIezLO6gk3x2vWmo/3LxM9VaD0K4ZAC7rokk?=
 =?us-ascii?Q?ieiiZlJXJSZ/pOzhWenGEDKSdyHyXOrbBrrHBHiAH1eDVZwX+BT4jvlz1+uV?=
 =?us-ascii?Q?/hYK/n+eWMPn3FzO7tRclRolzNJcrvvWapFzvwB9kg4s//5JMGjlE+QGcG/H?=
 =?us-ascii?Q?xTDt8GHd8r7NWlr8GS8HlDwFIBh46oSY/F2FhwcsZVBmenN6+CYE+AcEOLlV?=
 =?us-ascii?Q?qDevMHJ7g5Ge4/hl1cf9aervr5EFpDWRF4JbVPpWWyZzgbkFOLqd0AuH9S9O?=
 =?us-ascii?Q?wxYlTHYznbWoFA3Jw54bH4YtSXjCMa35CYUSy5mPt+5touYASeraO8gd9Bm+?=
 =?us-ascii?Q?h9AyzQ//MlR2n5vKr4Ii/uPU3CSMhA0ZPhn/hvWrdwptJQVr6FIVuvu/Q86w?=
 =?us-ascii?Q?GB/CpvPiH5jSWy+Aq6gud5L/lPeW7LSa/uK6VjcBMvMSKiU9xIn4zn8wmdgS?=
 =?us-ascii?Q?KPDQFoYy3ivssvdkOgvKQA82jrpbl8J7CQn5PGDY3EUM2ZYYqKXE5jvf+Llk?=
 =?us-ascii?Q?Wk3ANJH07g1y1Ulzyg5rl90u4oA2PA7R8qn5A39i8vhdVehrl8H5R4UOfrXv?=
 =?us-ascii?Q?pXRkGu1/GiQX1IHjkKupzwhhgkkEzvjje4nTh2t6OVA+xgvvC12GxpCjzKoK?=
 =?us-ascii?Q?d+nrjLLApEYsMAUtbhqzo/VdHX/EG2W3tyhevL1V2psS//KQpb38jCkf82RN?=
 =?us-ascii?Q?fYgvxVkQbj2xdSUc8u5VRv81+3nk4rGeo+NMU1tnjeiWv8oY+QzGMhT0vB2n?=
 =?us-ascii?Q?9Ml/nlQq9YDkLMrF8fhlWP+aWx94PzAOjxgD6aj2Ai99aSo1QOSFqbgPDH3N?=
 =?us-ascii?Q?Lx1bkuBETl8aLTCSZN79oX9x/2GlnStcV4DwKVhjtbEOQMXPCWojG3TWaK0h?=
 =?us-ascii?Q?UY+2S7wQbmbw5Mht5HDaRV10PsoFAZ6HUp2wWTpqj4NkIrf4ED6SwbFYRR+N?=
 =?us-ascii?Q?tAK+asTf0AIDLed5StZDVvuU44W5jxpq3PybycFv+zcDwGxZ/2zKSuxjl300?=
 =?us-ascii?Q?KMpNelh5V7j4kcFpx9nO3d9nxCnPXlFK4+Vb+V0xhmKKKYYSfnNrvy7BPk97?=
 =?us-ascii?Q?RsW5lcNuLSgFs+cr3yxRERvlYZjAXfcUE2R1DH7ws6bokich0OtI61EBzgT6?=
 =?us-ascii?Q?NdJ8axD6PX48xxX/qukEIDu3P29D7zomJVhVpHg76umjqXBtLCm1O4hgPpw9?=
 =?us-ascii?Q?ZwewFKULcIDqHMgD8k6ArrKrAQ5SsX3GHBPPLEfZ1z+9qC5b/pcpVWzXfNYP?=
 =?us-ascii?Q?67691wCTCnxvkMZDEpoEamEv7UgkhIk35g7pn3UUAE5aad4VfO8X4NQ+Gnwo?=
 =?us-ascii?Q?mR3hPgKUEhaKXQKM+fiSwJj4zhS+n4NaPllrC7U22eym3odlrP2OO1OpQZ4+?=
 =?us-ascii?Q?zp4T2XOPopbk/TARbYpbnoxbUEf4x1Llujka8nSjNAFV+WHOYYs0UjaGn+9Y?=
 =?us-ascii?Q?gM+aJiaq/DQ+jdTQdPe3rTXw7T9hDR2nYfNgT8h4WHocxYrHRls4xeFYV78p?=
 =?us-ascii?Q?8CTjHDkWR/NSCCSvNOg9tmZiQnC6y1PJh8F/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(10070799003)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ebSNEWo3PsqAuxYf6MyTjyaoCe8HRcUgHq1Uk3CT5xKscsvKeN97rOWODiH?=
 =?us-ascii?Q?dBLc5/tlwoscmEaXqBdjEgIJr0Ij2r8y5cH8gqSOgVGud+fyEyBi8PmVAvI3?=
 =?us-ascii?Q?MV+ZY4DfQzaaMH+3DpZI6t2WUXaeTTlSO7VCMCz+NFZoidCQcwa8108eAjBt?=
 =?us-ascii?Q?PjqTLsFNxBnLITxvt+C/WF7qxW42CRTQlfcu9tMQgtlU817iMum2keT0obNn?=
 =?us-ascii?Q?JGSlOtrrly3LdYEPHLBQILCvLzzfzfgL+YbmM6AHSROA3fl9lE9TiVmQwKRY?=
 =?us-ascii?Q?zaR+vf95JrUmA6QlHiAB5PfjOWD22lF0atgHTmh0bD5GrmEJOWaKTlEuK2j4?=
 =?us-ascii?Q?zI9NeiLqv2TJ6IIg+7rsc7aO5sL9EeeWAHHdQwB8Y0z3pbTyiDoXqFQ6N29M?=
 =?us-ascii?Q?ZOLEQDPQk98vmWDa4Ls7sJJIlz6JefCP/pAAXvJT3Zd24v+Xzs976Z+U5fVb?=
 =?us-ascii?Q?Gz2xU/v8e0jUmyegawyI/NVJI5wfkfcATV3ldmqUcqvHAtex75U+cyarhYL7?=
 =?us-ascii?Q?xAwQiWMpCfswwDQr9yquO1GOLAVh4ZK0afyvixfz7TPuxC2PvqPJYrCmyDcz?=
 =?us-ascii?Q?2/fekOfWgjoy2t1SiOcMpNwSQtCGG3fI2E/xXwqBG1uxq+8Iv77ORbB5dFB3?=
 =?us-ascii?Q?HVfdaX53dybocP4SL+3l4Jjq9FilWmYqiTk+CvKIskbwnMs8CPHVuPyKPhQF?=
 =?us-ascii?Q?orM38Q8k/Y+rGbXba/cfC31y/kzCCdmN4uiTO+qI5ntZ9W1GLizzJesX2L6K?=
 =?us-ascii?Q?kECgriN47dG62itLgz2Sw9DnhX+NUeHiA8OVAmrwR8cpYJ6ug3AbdnDGRo+z?=
 =?us-ascii?Q?/nkQ2e5itaZ61+IM0t5K1H/0wGn36V7lSusI+5QFarUdnBW/D1Cz5VsTig6E?=
 =?us-ascii?Q?w8Irh2JMIl8DP6mnXu4wH7UYiqxYWYCrVE+Oyy+ketNDEKLDtoFt/i3HaBGW?=
 =?us-ascii?Q?U8xojBoRgYP0/qGKkDUFFRcvlSdlTKaNaYn7BMX3EH+blzEUR8ww9A343f/8?=
 =?us-ascii?Q?dbdZOFx8VayxFgcf3D/TvwPsJvtnuR5eYCUYHkLr/k1iaD459ggrx5rR4Sct?=
 =?us-ascii?Q?siwEtBlM7lLB6OOgPja2lFoDEgPR17nLfhBu+BJhcAycN7HQFIRbBNIBW5AJ?=
 =?us-ascii?Q?VtUsukb5vm/NOHN7PmI+pti6aWPuCG5/N0vptzSYPjk4XEBuKrgDMRVbBpZ9?=
 =?us-ascii?Q?GE8943NK8XPOWriqaQj4PjHzWmkaDWkXIbI1b1tgvqIRZx96N6/2YOzCbZIn?=
 =?us-ascii?Q?aY2PVzmH/qEVCxPrPO2cMJnfykGJ+iPJFoeZ5KvNUPoGiiwGzph4N3iutdJH?=
 =?us-ascii?Q?QE0pYWZotYAgri4+up8X3B/14jjuE3mpxjnypNfw0I8rgnfRaC0nlCHj9gnF?=
 =?us-ascii?Q?lxcJa2e3T9KHe79VJa+lNun6wu5qcHBXl8hmgob+A5B3nyuBGy1//iP+Cs0Z?=
 =?us-ascii?Q?3FLP6L/nMt0Rcn2/KUKoZu2+JpQUM72fCGWKiWGKJmizQW7ExvG6EkgUgBnw?=
 =?us-ascii?Q?gV5/6g5larNUwdawGHemxGPf2RKi1oi9WLiI5Ai98dWS9NaZ9ABUDyWdpWo+?=
 =?us-ascii?Q?X7+tyLt/943lduo/QobkpJmLCdTKIeyLd+UsQiXOkwPynwIkW9ZK9fnOVTcv?=
 =?us-ascii?Q?UIdtHOp36c0in/xzuPI9X2Dl3sKx6b6JraX8RFLYXF6IuYIGUIC+4Qp9IA1y?=
 =?us-ascii?Q?OFGLwk9yrq6dgCzI9+3ebD9VUid9VMvbVnu8l5ZVTrneJ3iOLNTCnNN/WIdA?=
 =?us-ascii?Q?UnEaYqJWS2ZjOsmUA1xUuOD+ZUb30cypW4GkfSpOC3dIZBad4Mqozn56vVUD?=
X-MS-Exchange-AntiSpam-MessageData-1: Dcd2uY/3pChfhMnaV/BgKLeNd+rQPeXzNk0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fedd04f2-9d27-420e-a38e-08de59af985e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:13:04.4913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7g24/tOx3YHdf69R6PFujO4KlHX1FpOFS//mUBOY2AfQFZbG4N5SbdfaxXDsjCnU/huyZCipEviVH3tAnks/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7791
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252329-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,linux.intel.com,trustnetic.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: BF64266C2D
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 02:06:23PM +0200, Andy Shevchenko wrote:
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> FWIW, Cc list may be located after --- line. It will have the same effect on
> emails (as regular tooling will parse and put them into email headers), but
> will reduce unneeded noise in the commit message. List will be still available
> on lore.kernel.org in the mail archives.

Thanks for the comment. I know it may be located after ---, but for me,
doing that implies an extra step which I find unnecessary (moving them
there after the git format-patch stage). I keep the Cc: in the commit
message in git so that it's preserved across revisions.

> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---
> 
>   Cc: ...
>   ...
> 
> ...
> 
> >  struct mdio_regmap_priv {
> >  	struct regmap *regmap;
> > +	unsigned int base;
> 
> Hmm... resource_size_t ?

Well, regmap_read() takes "unsigned int reg".
https://elixir.bootlin.com/linux/v6.18.6/source/include/linux/regmap.h#L1297
So in practice, a truncation will be done somewhere if the register base
exceeds unsigned int storage capacity. But I didn't feel that it's worth
handling that.

> >  	u8 valid_addr;
> >  };
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
>

