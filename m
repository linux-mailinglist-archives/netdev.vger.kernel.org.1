Return-Path: <netdev+bounces-287645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJL+J46fBGqbMAIAu9opvQ
	(envelope-from <netdev+bounces-287645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:58:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FB75369F5
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 512E4304636E
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823CA47277E;
	Wed, 13 May 2026 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N7M+PRsP"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B08C274FE3;
	Wed, 13 May 2026 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685026; cv=fail; b=ngRBuoTHzOzK1H8k8izD6mdmotgkQXA/25Bruy1c+3kE+6U0apIn8J2M3NP4x2PKhlz0+qhY8HDaEaItdzxkSxmJtxJTYb6BN3X3Jnw+GTN0O04VXhOBkG9BWemtOyoEn08uKUq0xMliJp7v2sPlw9OQIN8TfX/kSbU0bcvKfUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685026; c=relaxed/simple;
	bh=TmTt6zASTqrA9x7i3z2B74wEcy4uySw3KUTXxQJKMmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kw4ZTc0kltncQJHDT0Use57ijwWD502wgoOjaRNBTSIlF4yGjxl5Lx8OSsvYprYsdU+C1Dtw12BermrdK29C16MzOADl5xxjYDNpEZRp9OEJCdLAgFE3yuNMhMXKMUG8elljbCFd90eF+EJB5pPHC4RpvSzssq4ERQCcqAoZhbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N7M+PRsP; arc=fail smtp.client-ip=52.101.65.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnns0y4kvYMaxv7Kkw4AvM77hgfxwnwb84UkHkDWaH7R69/ypWE2JzTW9TJFxHw/eIJ5ZnALWSfXGRy7Go+KgmatEWWVzhqgSBmYeJyUK7zCn/4d+zVR4n8JjLYra4WC3YvculbrGaJwlBav65u+C4xk98vZTNaYOf7048iFnX/e4sxIAvIBrLD7wv9k1chPikF1kp6sIHUpeZBQnQt/OuH5KTRrdCeL9KusJ//lEtDeAst7gdnP7u4lKHMO9uSrkKTiquYkYv6fbPzdqdfsC6hW+qxoafojoW5+PO9Z8wN46afbP/9zhUlfTF6nZitp9u+e6EnIeklHc7MGHbgy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KVccCh3yC6moFfe9/Ojko95Pin5bOEMU4L2MSNMdIM=;
 b=B7WBeMvGU3JuUdcwSR9a+p0JxvcYMG9VCocQ3zpMi8paeAEG4xMTwKS1QGEz82iR4nkkcJtJYLG/ln77XAQGLUo++D8+IDhOM1QsIr5R0aE/ozAJHofcRhhReF18Bp/y7JzKvVA3Jfb7XwKOKf5JiB0KBHyL18NjaoyP/MWLlcl0m/weSKkyyDqpUsymMFtKMIlOS9uy37ZSFH+rIAhxUx1KEU7UDv0hRnYk/UYrin1HaGQllFIgQYQYC3qxWYGJujiLTXeGrg6JgRGS12sI9dA7Vu1oDt3T61e/h35qW6RApA8y8wQ4LfDJ7MfC3o7N4tabGvmUwQ5diYIVcQSkWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KVccCh3yC6moFfe9/Ojko95Pin5bOEMU4L2MSNMdIM=;
 b=N7M+PRsPfWuXO1jB2Tk/+37dIxwpAJXcOzBVGPWc86FICtkFMN2+n9sXSHnKzOUO0oRXjH8knvfFaUEe33zPFPrC4UurlQEJNKMYX/0ZYR4D5AgJxSb7CFefuW1kCZZz1aPvwhF1bVOZnmREC3mCL+nrcKqK0C8fFkIk4e+mC3hBKQOjey8ATQ1H1dXRX57ExsFZn65nvefrzLtPMyxAF/sZuFKGHHOtGJ2q4B+5JhCuEF1750awnZdH2fojUNE5QOHvdfWf45kbMNQ2G5su/yvL3yylYYTIO+v5G9qUUWZm6dtcojmU0agxJ8kKJyOGe95I662K/7OjZEUwQGSQXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by MRWPR04MB12306.eurprd04.prod.outlook.com (2603:10a6:501:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 15:10:21 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 15:10:21 +0000
Date: Wed, 13 May 2026 18:10:18 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Josua Mayer <josua@solid-run.com>
Cc: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rabeeh Khoury <rabeeh@solid-run.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>
Subject: Re: [PATCH phy-next 5/5] phy: lynx-28g: add support for 25GBASER
Message-ID: <20260513151018.sfyowih53zistli3@skbuf>
References: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
 <20260511150023.1903577-6-vladimir.oltean@nxp.com>
 <1ba1f688-9f68-4749-a18f-20ae91738ae0@solid-run.com>
 <20260513133721.huu4j3wksxykizz4@skbuf>
 <5cc008f1-d2c4-4a56-a1b4-6fd9bd470049@solid-run.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cc008f1-d2c4-4a56-a1b4-6fd9bd470049@solid-run.com>
X-ClientProxiedBy: WA0P291CA0015.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::20) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|MRWPR04MB12306:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a79de1-2c0c-45d3-83ba-08deb101c026
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|10070799003|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
 KR2Iul3oltx3rfGdto8wb00et+QaPuuYNTUNU3A0zHzB3cPj4RzM/VnCX0OS+rHxwQaLRcJEonugEHgcpDvgIilp2JfPorOs+24Sn1G2kSZQ++WGeix/C4YxpI7txM1CnuwPNdDX2sOQGqpKHAvKz/9YKasM9C7E9JEzHT9DFzERXv5mQykmODh/4QuSAV16EnWoop3PJhz4hPuK3JFBoWb7HTUkxP55vZNU6gMfb3sUU2R4M3EX7lG4+/4yvl0U7qch7JC1mutoaOdcjUuX6PC9nq3jIreagaxxGWlv1ob2uGlFPDW7QZyIXV2gQwOgyN47aYm0tEk3zstVJPCYZJMOtYAoUnn0AAsjpZru3fk0sLWWb4wXq2RgEXSWZzFHC57OnAcuFbVnz2/G6GA45uYF1klWGZr+Lg7xMe28iKKJuzr+3mjnl6TjiKjEDgCTHVdBD+DioAUbQ+nsTjRafEpv7np4no5N7GYmK74+yNEdYxZx6nb8bNMSRMYgKTqTs8Bto+OxFeM1UsJXJCdi/U4GuNOg3LtR92Vt1G6RjZ4fSdbXbPxA0bLvbMHOU0aE50T1PkMZICtrBAxqfPHu4mCcjH/v+zDysCXIPwMlG+utK+NCBqjtSJjlp0lAegQQKv0cD7jV1cvySjSWdltgw4Y11zchrpvsekGYIV/Ba/IaWx/K+L2JDIbqdJe/zYnO
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(10070799003)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?9zT44bHkCiE17+4WfkmJm0tDSoPFGq6ns+N0ImjR+9RfonAO/ud0Np01MH8C?=
 =?us-ascii?Q?7np+Cs1g/VxH2Ynn4XYlHXtUAAnsLT09e/r3jnNeNweWBLOfii6OYq2oE59I?=
 =?us-ascii?Q?7dZoL9V0cb7faXBeGr5iz96xiypwMjal3t24kJyWa1qzicH1DM6/nbEu0ZS7?=
 =?us-ascii?Q?hFbFPC+T25q0uQyn2/Vt6cZljiZvJObcsX7Szmg7W86a7Gq7aj3zohGiiRbU?=
 =?us-ascii?Q?bu//apxDimhxza6ycpI4w8u6vKlraN8vvp12fFdKEY1ctU6hlqHsFNh9oX+N?=
 =?us-ascii?Q?fSTHgpltOabQTMTJIj1YYf1kQv2ZZ39HbDfbm7AQccLt5zs1hcWANNVny9VN?=
 =?us-ascii?Q?QQKV+sBUd6kjdDaP011/H1ozwiRXFvus5TKG7y7upfPIe+RQuBIDtuJ5A2CK?=
 =?us-ascii?Q?k3GavPKYvFJfUAg++2SrcC8tK+KcCT8xms8rV1AY5BioPBuhHaRjfCyb9839?=
 =?us-ascii?Q?kg5+5TN8H7mGg13Tb75P8thiUK9av+NGGBR7b1ZcOUBgyYcNn3JmBa6/8Sdg?=
 =?us-ascii?Q?b7sA9mQv5P7te9YaHsDMzIOfSC+SMdz4vxsTXImPrPCWhwY1PhF8j6lNOwZi?=
 =?us-ascii?Q?wPXPlos2ZCRROzLqZsb6OgmxiJ8M1W4YTbKpYSUEFoZM1A4FQe3PBGN0S3em?=
 =?us-ascii?Q?tcbpSvIl8TNk4nLyGS76oHODLuY6t53Nbg0TYtx+v1HtvGyqpaq+oFuK/tv9?=
 =?us-ascii?Q?C0BEFVF2QsnJlhReOTlXW3LeqoeGSLpyZtFNU5BtTDJlGI2Fc34P+HEyA+BG?=
 =?us-ascii?Q?/7cnsQtV8h2cxoXFehd1uiRoG2XJ6bNhbX+20N66Yss8ggpwHG9zAmI27F3j?=
 =?us-ascii?Q?DYx/srLVpDUukYJM10IGCfpSNqwSontdLGEGAWV8A1JWv2Rr5thQNcrFa45W?=
 =?us-ascii?Q?roQ4FAKQdnZyM975sAHRO5YwzAsaYLOHStDYfGsNDssDYqeDci/t/2taPL7A?=
 =?us-ascii?Q?LcU1hIY8DxORiwy2alelSv0mpyPpX3ONaK6zqKFGeUu6aiE07SJ9FBg7MKGP?=
 =?us-ascii?Q?GYHi9htPY50OQEzc8jisB7+WMGmyLDTDAAYupDZc2twYhnR9kVGSGijr2DNt?=
 =?us-ascii?Q?ldtG1qaD0FK+kLWHRCw16DzNifZV8pN3wfNhhfPVYSQur+DnfyxWd4iVGPeS?=
 =?us-ascii?Q?W3QptLmiI2rNccfX5DHbILpBv3aLjScZ/qoWyXAD0opbrozOaTtNNRO0heCV?=
 =?us-ascii?Q?nmykB2LNox8VbuPm/Y6KALHxzZthHJ2xN4aROHbSnTWGjU/LC4kaImxV3OQv?=
 =?us-ascii?Q?xOM2j5z2PScdlHhBrKeAFSuTzE2YoVHe4GsTwadzXfgEuPzJXH9ZBhDqbzcM?=
 =?us-ascii?Q?gaUB0lsFl3TbblJy+IJhYcPeL/VZidb9TSNo20C4ooyl8i1AWleuchZO4j9W?=
 =?us-ascii?Q?vFYSvpcjKrFUJbYMbd0UOKhfMWLouPDPHQVFBqhuwOPhrpAE9NwE4Dj8tbgz?=
 =?us-ascii?Q?v/KbVWuKe2ctN6ilIB7ex5Uc96srS5yRS3h54pQJI43gpN+Wb/kI95elM1nx?=
 =?us-ascii?Q?h4RrAdg6k9c/vkzWDN++bnrJwfmfXLn4FZcpj1uy3DUHLS/uAHWo0rTk147P?=
 =?us-ascii?Q?XMjFenlvosT4MwHV+R/XfBIoggcwCwkbAhxfWPOgrbgsVsm1ZW9tJg8oW5hR?=
 =?us-ascii?Q?N/BrqXYKFw32Yqq/CHoOYTp0H9Hrpy2VDuKfgHSF8Fmtv9soQqxMGNBe51nk?=
 =?us-ascii?Q?Tw31LCiayFy7SJjlIhJZh71UCks621qFGUqRKj1EJag1F1uyvUZaFwYg1oSK?=
 =?us-ascii?Q?QaHDU4f25d15J6MK/3AebtvTdQcG3d3VvSj0nss4gHACuJx5DkqDax4RAGiS?=
X-MS-Exchange-AntiSpam-MessageData-1: vwhDWa3leT7EjQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a79de1-2c0c-45d3-83ba-08deb101c026
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 15:10:21.1376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zv0AUXurFqhuEFPA7Dna7JiPHSclKOTY9yDEzVKmvYPNmUd/neMoJOYjsR4waAmbopb9MZU4r0oxadXwFZwXxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12306
X-Rspamd-Queue-Id: E8FB75369F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287645-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 02:50:38PM +0000, Josua Mayer wrote:
> With updated compatible string it is working perfectly!
> 
> I'll send my tested-by on the series, thanks!

Thanks.

> >
> > You can look at my branch
> > https://github.com/vladimiroltean/linux/commits/net-phy-upstreaming
> > specifically commit "arm64: dts: lx2160a: transition to device-specific
> > SerDes compatible strings".
> 
> Thanks!
> 
> I will probably have retimer comments i.e. one phy object ehach for rx, and tx,
> instead of combined - as we can not rely on hardware designers making clean choices.
> E.g. imagine two retimer chips, one handling rx direction of 2 ports and one tx of 2 ports.
> 
> phys = <&serdes_1 0, &retimer_rx 0>, <&retimer_tx 0>;
> 
> Not relevant to this patch.

Correct. For the retimers we will upstream (Ioana is working on the TI
DS125DF111), their channels will be split to separate Generic PHY
objects, to cater specifically to that use case. Hoping that all other
multi-channel retimer submissions where there is no meaningful
distinction between RX and TX will do the same.

