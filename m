Return-Path: <netdev+bounces-252831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ0jF1Jnc2mivQAAu9opvQ
	(envelope-from <netdev+bounces-252831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:19:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B661D75A95
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82F5230C5C65
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31701284896;
	Fri, 23 Jan 2026 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Su9j831x"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010054.outbound.protection.outlook.com [52.101.69.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A061514F8;
	Fri, 23 Jan 2026 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170538; cv=fail; b=V6K1eoyARhfqYT62Z5XxjtWXHy+zHLQrR6OoUMHTHuzg7RDBLzXWKRZkWLEoOSLb/5vi5qSGew5ldGlJuBbPLEPonO89HM9SiUHeonS9TdClRzGasBAzDt0ApAuTXAt/ZNDfTdjVdsxj4OrGpZzk2xDZjqP3KBAOgZoG1i85dI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170538; c=relaxed/simple;
	bh=TIIUbvCwUnZAk+sQAPnP2hRdnO4bp488equaNc1NvI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J241+nduXm5T0CVmpGoR1XtGklbZmYoXLkpQpGG0luyuUjFGbJo8jILTcYgNMaQeVOhhUmnWL0u90GRWGsS+w4/nzAUs+TyTagGKSsukQFJBZKwQVxgbeRsxksg40EsV0jJYXL7ePK3Zb/Hd/MzydxjdG0e1+JQQ4PRlZ3GTVIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Su9j831x; arc=fail smtp.client-ip=52.101.69.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onAxDDbGYW5n+/Vtsvjq6gbOUH7iT8jR3qbL7D3i4Rt6p+kpmOefv4cJiGPyksOifQrgu6ZmHQPTwsdebg2j1H96QNEE9nkHzOHppiGJFiYu9/wQM6Ou7SJpnvI/Y16aO6r04JEh7G13tuYawCvazPzU0p2EHH8VgmUzSbR2ELFdrB1Lc9xXKwJ9mEcPar3g/jHGLpIjMBngdSSie1x2UBXQn+WHpUBqwfvHkCgwP+GdoS79rSiiV1r8PUJkZruFlw/m2OOgfFjcA2Xosw9RD/R+2BUMr/Ku3EuLN5R8b17ISI0vd0UkDVxK6mWSJ3Tgcu8ZF2RhN7Qw817L49GC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqY8sd4hfhYS9MUkBZlP6k8zvpYJjgHsqzX28idQoho=;
 b=baLBFS1SfuICZZ6bZf/X+2fH/TYzZVFw5QdVtSn7pAAUbculu9sRBYygDLnwx7++QJS9Z5F0bO0r70KiGOHP5zuP5HqYUNFCoruOj1glVaS00VEN3GSxBrXU8K/j66fAFLIAvSdosyMvcZ/pqcQq/UG47UUodPN9RLJl+VYKhoWkobH9ob9hRwpkb7W4zqTW2HTeruUZmbhtB1GFc9Tzhv6zoAzJ2LoeGfI9YLdOaE4GpMWuf0AWbgQ7XvEpJjPsj6QcLXlcTmRssQ7hQfHmyERI9lmENYu16l0ZEoD1lucWBggtxb3LnTWad8WLOW39hjdxhmx05Q1V36o+81pQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqY8sd4hfhYS9MUkBZlP6k8zvpYJjgHsqzX28idQoho=;
 b=Su9j831xiFKp598aJiVDWigNd1HWiXTnimrWrlsT09mwXIgHAeGcduBaFQdFNQigVqKdkydd8MHXyiZsVB3lu2uha5A6Oud+e8hRwmapYssAO4p6b9yolGkQWgwJaKQxebG4XkmcdCpXJua9So9s6Vj0RKgqq8zGpHHq/IfNwkMRcniqVTxwDTBw9DeXAFh4ob1936ZxRVQhSvJXcEAQddppT6YbpaZQN4t59Uq7k1zrEN+rxeKOzv72oapEii+XPBsxpCtNIRMKctvGflAOFvg2r6yfuU5SqMsvxDKSG/7yM/hlojj52Q/n/QF0CYiDn6BOLSWv/WzPwvEbtSr26Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PR3PR04MB7434.eurprd04.prod.outlook.com (2603:10a6:102:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 12:15:33 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Fri, 23 Jan 2026
 12:15:33 +0000
Date: Fri, 23 Jan 2026 14:15:29 +0200
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
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v2 net-next 01/15] net: mdio-regmap: permit working with
 non-MMIO regmaps
Message-ID: <20260123121529.inik6xrfdianljq6@skbuf>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-2-vladimir.oltean@nxp.com>
 <aXISv3Acm1v6yS4V@smile.fi.intel.com>
 <20260122121301.cyxyevi7xvqw2axk@skbuf>
 <20260122134704.pxeikyk4q7nhay55@skbuf>
 <aXI2bWhDtNNfr8M8@smile.fi.intel.com>
 <20260122221848.py4p7mwxzybicnsq@skbuf>
 <aXMhWo0NpPK-BELG@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXMhWo0NpPK-BELG@smile.fi.intel.com>
X-ClientProxiedBy: VI1P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::19) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PR3PR04MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9d7195-570d-4f1e-5b26-08de5a791b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|10070799003|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o6550mAEqKUYHMIGrkyVnZuFf1ATv0rfLYj+P/LnJf84azXWpztzDULRD8TJ?=
 =?us-ascii?Q?mJnJGdNH7p6+CGIsCf+K4qtW4vI3f7qrNcfFS+YUwZa5hb60wTmXR2fwNYkR?=
 =?us-ascii?Q?3pzE5kiNa8G2u2kYbGu7RiRlxTn7HgLw0zw2F4F4vReVpjvIj8dZd1kgw1Zs?=
 =?us-ascii?Q?Ljb+rjZTSwLr7O3R5oRiS3n/YTiGVq1TkEpeIcjxWNnOpzMXHNLh35crdpRB?=
 =?us-ascii?Q?WYruScBkPkoFYhpGG3e/hOMBaeuol3pIGd3uegiMBuSDj1hQ5pFQa1gQfrRc?=
 =?us-ascii?Q?LdVF6zRt2Hf8aL+2C8cy+TKTECj8TLxarEaP9A/3UOoYFJH2Te7IWdyycuxb?=
 =?us-ascii?Q?BK0oEuw/1x/hvpk7upOsbUC9c6BYEA5JDNGPiQbN6Uqy+siQF6RP+bshg+iO?=
 =?us-ascii?Q?NVE5uulJw8gbKTw1axXO/Pfr1Fc1KbXt2+6Nr1nA/camjF7JwajwJQdULyRv?=
 =?us-ascii?Q?a1ivWsDzPNV5dt6M3Qf9/AlVGj+Xu2iTq7yBxNvVWeZVO0VJK1nEL5XyP/Mf?=
 =?us-ascii?Q?CoKaQ2859sTnox1SjQgKVRabImEPZfrL4k7gHBGgAzIkmDh+SIbp3kA/8b3l?=
 =?us-ascii?Q?tQCS14KqcKTDUNnDFmZR4FMWQo8dSasBddRL1jf9VKI/BXY263tQIBTd9D7r?=
 =?us-ascii?Q?w472KCStO9W12lqHRbKRGRT4uyNafL0wlKbofD4qs/pyYJFj4hSr3HWt/eFA?=
 =?us-ascii?Q?dqeNf+R2gi14pokUDquS02sV1TibDRnil0ONZrj6+PWQKhbR+yw5NG+Vl95e?=
 =?us-ascii?Q?DOzSG24qzI7juIrfChbyKpWZpSKT3jySlu62UpYuhdNhb8Ow33rLDa8dclG5?=
 =?us-ascii?Q?0Np4L8jZwZoLaaY/YzeusWOEeDwSHB9AE17Rtf7j/5tKNWYQKKxXuo+75gs3?=
 =?us-ascii?Q?nUe4h9NEnfI+UTKR+F8D7wL9+VXLkVCgLKRWAivbCANPyUxfIVzIxyRk1SUU?=
 =?us-ascii?Q?00qhGCg9mNK8O/jVWMY9LV5/lXc8zLOLdJYUSY02++ppKYLaVyA4PkRAKrJD?=
 =?us-ascii?Q?S/Bq1VOobLlAoTousuNM0dd9vMP60FJP8GhEvw9WNZ3nxfwmOm4St8nKjrw0?=
 =?us-ascii?Q?vbz+F17hTGgIQII3bj3eangssWypHvaqQHbDm4N6k/sA5TnPi/6dzX6S8gG+?=
 =?us-ascii?Q?i/yfmImag5ksbj5NUlc/5uV0GuFRSepqova4ac7ejmP0dOEk7DSnY2qrdfTD?=
 =?us-ascii?Q?CYnvnkAnduWVjfwhBuXvE+9+n4qwoMdnZDC13uy9EpSk/PcerWoyRYnhdI0j?=
 =?us-ascii?Q?YWj888GshBbe9VsrbhEbAuXRWnqPNe61EsLZcjVXmkK3o9d3DbRQPhSDiOPR?=
 =?us-ascii?Q?cpRb2QTqtDKeib7QLXN2wlyWnR/b2t6Id1iNt4YfuY+WeewCsEv41v29fWzP?=
 =?us-ascii?Q?YQ9VWNhf11pC/0yfkadCqeEib3Ty1VXZz1diSnkSVdxSK2rZ8qlZ44mAdz7h?=
 =?us-ascii?Q?ln24k6IhOFkwC5UuKWI/mAS1EgS491DGtKuzJhV3JrgOf9gQpAJP6dhQSkVY?=
 =?us-ascii?Q?1L9M+e0mm/0eOyrbrimyXxOhPT4cwzTOOwNV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(10070799003)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v489HrzY6XSukZ+9TbuG1NlgeZ5qTfu4xG3ZF4qj6FfDVr105IiJtDFwaWzV?=
 =?us-ascii?Q?nqK08Edha1TXCseHJp1ZrX2AvLSUPG/p9/Rra8V/8LJmoYZu9zZz5J5SYPoQ?=
 =?us-ascii?Q?F5IECRUb61nmDzIDvXdOxeWh8vdXqEJs4SlE29WYdgd4feLe3Bk6HtUF5Vcp?=
 =?us-ascii?Q?6zltjll7prup8BWFQ7NwzFK1cXHfrBOvCIFKWFbUHIH6RqJuOMbXPzX+NPoz?=
 =?us-ascii?Q?iT4tvRdgexHRr0LFi2r1f0JPV4qfpa2jjmkCJj9f5zjIIsbqr/qF4IDhtpVR?=
 =?us-ascii?Q?zP9hDV+0Fogi8IyehWIeQaYIrZ1e9J/WCH2ehZBgJw1v+985q9pQXQBG7TrX?=
 =?us-ascii?Q?jEXlJ0PXoHgTFgah2P4U84kElhlmTICSHGQZKGerujzkdvmFsayGv7KYK4gj?=
 =?us-ascii?Q?vSFJQbdLjMkNsyKGpxE+DFPFZY71Q85bDQdSCIXvOUjZX5cWbDOVjoOkDOrz?=
 =?us-ascii?Q?lPpSsSlGWwyNPprudfLIlGggxad+pR0ABbf02t+7Dn7KblpsVV3RkuDiMLx4?=
 =?us-ascii?Q?7sP++fxt7HOBZxgcG32cw9OOm1+fXPOXTojVmBNANG2c/UkHeJgJUuNxXlAr?=
 =?us-ascii?Q?hQ4senqy9S2+Pd7GHom5RcRwMvoLQQQI1BZoYagHrppSLs3PM+aH/8xivg1s?=
 =?us-ascii?Q?GfGEwUcJghmrWX8nGRXI6OHUKSb3iQEVmyRkI7pehHQpgeKthZ+UeQddpTjT?=
 =?us-ascii?Q?yhG8y53D7i+ARe50VOAciRoH4rHYiuMjwaMQgtXV0Lsk5LI2U7jOJVmz3X2n?=
 =?us-ascii?Q?p9IpdasVmJLY4oTz4N2szVCLRjXg3Ri8SqrpOFKuCLTlidglJRQKvsfY9X2F?=
 =?us-ascii?Q?ZQ17FYsnq3B584vlcdD/ANwselI7BOd0tGj69XM1ZKvl3em/s+XOlW1ZpfyP?=
 =?us-ascii?Q?OMhOyCOKiDR/oJ7YNPe6Qk+cglJH5HLOuOM060O4RtFrw/Sd4+LSfXwMxORg?=
 =?us-ascii?Q?QLXba1cb8dNY5pUmJOAhlILizxmU2WD2Yzmrp29OsRz5mcH3wBqlq3ME/Uwk?=
 =?us-ascii?Q?j+hloFz8ALfNi+F0cQES4O0dTE8tzh+eLCnFnR/lYpQ/FbSdNsCd59PtpdZL?=
 =?us-ascii?Q?z5vNpzoEkYgcQwA/kAKpMva/6jvP1DF4hidkeoxa6+SPoteUFA0MKAaGpXGq?=
 =?us-ascii?Q?J4VPRrig8ouqoa+qZQfjk1oov2WUBCYEmveiArNTschLBhZ6tivCV/k7UOsg?=
 =?us-ascii?Q?34/vD77axL9TU/AvwkARyPmvR7l2Ss96/2WxSC8wU/piEcWJAaSQ9ndSfyV7?=
 =?us-ascii?Q?5o1PrBuWHxsx7XfWM7eEYrgOhiLJ83tPyVOo8BPkWZOn5gwv2gj08VKFPlDY?=
 =?us-ascii?Q?xmuJolTgMiLorvvnDACV3XNSYI4JOOQkfE/yumkuyy6U1K4YctZb+r+YRI09?=
 =?us-ascii?Q?/4m9IqlYCJ3xASiBr4d96puyxxDt9Nt68/+Pqn6WeDUJXIWePKk9hHiNPCz5?=
 =?us-ascii?Q?KxumHsv3Pdn41OO8iSfH/03PbtVf6ovPkQeg1u3CX6LzvcoFM1gix0+qI8gw?=
 =?us-ascii?Q?Ng/xg2JZEi4Z+QB2IJBTmQweEw6V4czotPauNJkRHPNyFmmE6MFQglueiAPa?=
 =?us-ascii?Q?EAz/RnxnQJ1vXDFKJzXUGKn+eUWaA0udtScHAGzgQMGU+1BABJS/SsNl71cp?=
 =?us-ascii?Q?uC1+5RS/jbQ9A21XJ7U8k0l7oaN51SSNYywWt/bfrNrTmhX8i2IYeO3pfms0?=
 =?us-ascii?Q?ZoYfPNNpm9XXwa4niSrU1UUHYRfI/Ehy1AwLXa8M1fq3jjWuShCOu1WP/Dff?=
 =?us-ascii?Q?V/2Yloy7pY1U7MZHlv7rL1HZm6n5LlR28YAgQLvnWEBNYApt9jF0KYjrzNBp?=
X-MS-Exchange-AntiSpam-MessageData-1: tOFgf4zUSiHkODkdY8a3zQVSCfIADZ32ZBg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9d7195-570d-4f1e-5b26-08de5a791b92
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 12:15:33.5275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEOkdLYnPH5vhf1fSBbA/TqAPi+U58Y8bKzAeZW3eq2+YaAhHHVmZNmTfCOdc+fY5Ko7LBh6CM3kWpQulUN0jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7434
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,trustnetic.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252831-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B661D75A95
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 09:20:58AM +0200, Andy Shevchenko wrote:
> On Fri, Jan 23, 2026 at 12:18:48AM +0200, Vladimir Oltean wrote:
> > On Thu, Jan 22, 2026 at 04:38:37PM +0200, Andy Shevchenko wrote:
> > > On Thu, Jan 22, 2026 at 03:47:04PM +0200, Vladimir Oltean wrote:
> > > > On Thu, Jan 22, 2026 at 02:13:01PM +0200, Vladimir Oltean wrote:
> 
> ...
> 
> > > > > > > +	unsigned int base;
> > > > > > 
> > > > > > Hmm... resource_size_t ?
> > > 
> > > > > Well, regmap_read() takes "unsigned int reg".
> > > > > https://elixir.bootlin.com/linux/v6.18.6/source/include/linux/regmap.h#L1297
> > > > > So in practice, a truncation will be done somewhere if the register base
> > > > > exceeds unsigned int storage capacity. But I didn't feel that it's worth
> > > > > handling that.
> > > > 
> > > > Would this address your feedback?
> > > 
> > > Yes and no. See my remarks below.
> 
> ...
> 
> > > > -	if (config->resource)
> > > > +	if (config->resource) {
> > > 
> > > Btw, this might be not enough, one should check size and flags as well
> > > before use. There was a discussion about this recently. Maybe we should
> > > just move to a simple unsigned int in the config for now? Because handling
> > > resources maybe considered as over engineering in this case.
> > 
> > The resource flags are never taken into consideration, but I can for
> > sure replace the resource in struct mdio_regmap_config with just an
> > unsigned int start and an end, but that doesn't get rid of the resource
> > usage. The dev_get_resource(dev->parent, NULL) call is how we learn of
> > where our register window is located in the "one big regmap" provided by
> > the parent (SJA1105). So we still need this check somewhere else if we
> > wanted to not fail silently in case of address bits truncation.
> 
> Hmm... Bu why we can't embed the full struct resource in such a case?

We can also embed the full struct resource, I never said we can't...

> Because resource should have a flag check, otherwise it's a wrong check.
> 
> Discussion I mentioned is this:
> https://lore.kernel.org/lkml/20251207215359.28895-1-ansuelsmth@gmail.com/
> 
> Fixes due to that finding:
> https://lore.kernel.org/lkml/20251208200437.14199-1-ansuelsmth@gmail.com/
> https://lore.kernel.org/lkml/20251208145654.5294-1-ilpo.jarvinen@linux.intel.com/

The linked issues seem unrelated; they are caused by the assumption that
resource_size() can be zero. But I'm not using the resource_size()
helper, and even if I were, I'm not testing it against zero.

As opposed to the PCI BAR case, we don't keep around in an altered form
the resources exceeding 4G. Just need to reject them once and be done
with them.

Also, what else to even check about the resource flags? We get the
resource using "platform_get_resource(pdev, IORESOURCE_REG, 0)", so we
know they're of that type. I don't think IORESOURCE_REG resources have
any other valid bits in flags except for IORESOURCE_TYPE_BITS.

> > > > +		if (config->resource->start > U32_MAX ||
> > > > +		    config->resource->end > U32_MAX) {
> > > 
> > > Ideally it should be resource_overlaps() check. But see above.
> > 
> > resource_overlaps_with_what? The only problem is that the resource can
> > exceed the 32 bit representation that regmap works with.
> 
> Obviously with the 4G address space :-)
> 
> 	struct resource r4g = DEFINE_RESOURCE...(..., 0, SZ_4G...);
> 
> 	if (resource_overlaps(&r4g, config->resource))
> 		aiaiai! // using %pR to print the content

This is a buggy replacement of my intention. I need to sanity check that
my IORESOURCE_REG resource is entirely within the 0-4G region.

The correct way to express this using helpers:

	if (!resource_contains(&r4g, config->resource))
		nazad!

but... you see my point? In trying to make use of "standard" helpers, we
overcomplicate simple things and introduce bugs.

My initially proposed test can be written even simpler:

	if (config->resource->end > U32_MAX) {
		...

because end >= start, so also testing resource->start is redundant.

> > > > +			dev_err(config->parent,
> > > > +				"Resource exceeds regmap API addressing possibilities\n");
> > > > +			return ERR_PTR(-EINVAL);
> > > > +		}
> > > >  		mr->base = config->resource->start;
> > > > +	}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
>

