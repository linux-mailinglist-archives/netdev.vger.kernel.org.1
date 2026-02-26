Return-Path: <netdev+bounces-261561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HyBN3qkoGk9lQQAu9opvQ
	(envelope-from <netdev+bounces-261561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:52:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 564E31AEB79
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BCFA30068F5
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E72450907;
	Thu, 26 Feb 2026 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bcvKO/2m"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D76644E031;
	Thu, 26 Feb 2026 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772135528; cv=fail; b=pbcPwqHSWUJuxI2jGXpM/EN5KTgOIPUNTCBcB9hhPeHE8+8TeBBEvzoGa9ZbnjpoZq7QmY92ivajJO3I0sitYvn6vSEHng33ELjXRwwO161aZUrM9XDnxAFkqV/ShrE+4Lz1VbA8Ks2691SsrXdJR2dIvSEzxSx8gurwpnMXaOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772135528; c=relaxed/simple;
	bh=Q4YT5zeL7EBzHGGcoMBKlpFpSJJ2RmYtABqP6eoxoJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ooaDgVaNCvzUzMt+z2c2ZkqEbyKC10+gGCjAzzYpHddqm8fsiE6Ww6PUFTRsBpj1W2wTxLlUpPx+ejOQqco8OQwVnVzAV5P4g5IZcgWb+OSqUA+LlSIXOtXpX6ryfbkQRW+/AzvZiTCtC8bOfXn16xxBCmliN8TuluC+7EPwq9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bcvKO/2m; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+oo3ZVFzOG9t3vzGD4a6eS5lfmXe4hwDjQ2ShEspPbEWv4kW3oNbjpHw8ZWVEpCGJqMrHr7E13N9GMln9Tw5fvHb8WSBHd0O/MFwUy15Fjq473uG2FPB8QcRnnUY9gdL0NJIY7Jd0m0YHpHaVc/tRk+IBF9UwqrcfH0fIdDiGXxmtXRdj7Hy4hpTFf1MkjbKqdZHj1xFD16gMgBW8cmdn8WrBo17y+mT0tEZBcx/WxWRxbtFoNvZ0zdNB51x73fb5mMapMcrSQ0JWJympsBGal0MCf4alxFEm40pP2h5fUxZN5kR0XzrIwiuRocIgGW8lr+r84qaVtMEE0RVtOKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKtTCw8nxDeCqQOQILoB8r6N6fo623AEr4kUt7BQVI4=;
 b=oepVTSw8t4zw7dZaWdl2QwhlUOFumTNPO3FbkaFf99g/tDPIpVtiMtHaBJeN5BKQ3yI9/gu6nfTO5GjCxP9LuRKrezyMpyn7g7jYxzExAssZw1XpNk4UtMS5CvwB25+QrVE2uAa9NlTYmsFzefDO/M3xIbLnfykMOxnxSiVHTSi0lpDCiS6ZLnmLNGjOOZVdC/yv/XZCXvia/fVx4upF8Ii+MUiNDP1Q91JQfawdHSCkrOcfYRVZ1v/Jhyzxraog39Ac/6QNOmuJW2Wo/2ncpX6n7MnDEcosFmggcrjlwFVmpSsVoACoOTp00UPb9CU1V5xV8WnqZyUyQmuLaTmqZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKtTCw8nxDeCqQOQILoB8r6N6fo623AEr4kUt7BQVI4=;
 b=bcvKO/2m8nQMqOJN8cLZH5tDqRSChPhsVl0NCd/lFpPfPhpHVXIfMABdRDOt2u2M3rrJBMVfI85O6yNP3kQaePW1KZ/cLOZhZiUJxDFxKBR5ac75oOvaE09ASqbzdHG5bkCdi962QcUwVx3M/xg1YlOhJ1xvMPIsrVu6C75Y8JNEnM0paq0ndIyqUeHSMrMgSfOrdmOJn8byqEN8hs2DuFDKX2KaPq3mn92/8O0NCPfoYcTxmld0Am82YeJLPGcV0s+I10rYhT6fBK4s4/ED34EV0A2GNFgs/ydSXIerXkYgNGEmJdhT/t9BTt2ZzyS6XXtLKlGW7EhdoB3rQ7rqDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 19:52:02 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 19:52:02 +0000
Date: Thu, 26 Feb 2026 21:51:58 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Zefir Kurtisi <zefir.kurtisi@gmail.com>
Cc: claudiu.manoil@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zefir Kurtisi <zefir.kurtisi@westermo.com>
Subject: Re: [PATCH] net: enetc: fix sirq-storm by clearing IDR registers
Message-ID: <20260226195158.sagjq3hgs6l64w2u@skbuf>
References: <20260220132930.2521155-1-zefir.kurtisi@gmail.com>
 <20260223163227.y3yzzpncyf5a7klq@skbuf>
 <b3d9136c-2803-4203-b1ea-1f9e62de80a1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3d9136c-2803-4203-b1ea-1f9e62de80a1@gmail.com>
X-ClientProxiedBy: VI1PR0202CA0023.eurprd02.prod.outlook.com
 (2603:10a6:803:14::36) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0666f7-8601-4776-dc1a-08de7570828e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	eF2AG6bTQFlvmpK3ssgIfaTEvihErlswWBFRCxrr4yJss7lcmAdvbGt9AHIoiPG4pOM+7VnVyGwVwk+UuSM6uoxjmlAkXBCQdIwot3Dw5l4kYR03No/Wkbj2OHYfPEsuOAI7KF7F/2RjmPDXLw8towhgD6TnWnllF4icIawRhepVHqRTHZykT4a4F0TFezpSiJc3Ue4bQY7gR/2yC33YiwPKi/GFNn8eQlgIpu/ouQZtZ+ye2GtLX+clSYVcBgtvqpp5ljNOVsVI3iKXd020wGbzd0vyboJUIzcMmVHjuFNP8KKmX4v4Bv2rwd/UgNvbDQJkIafQqDaGa0ETxBdqU4bJkqcdNNFbi8dMvghWcepA4s8n2k6oNFWyr/LxssO6LYBBtON7ynwLiXG6eNFF7cpE6JBnnK+S8iNPlvll8Cy1M3XWXrugbU/NVT/H1jgeM8ge+0yt3L8QbOslJqxlp2YdfWZ2wT0Ec/YNkvLWpZ3Y25eUsDpFyId1koF8TB9LwEOf/7XoJd8vlZgBV1epIWG7gcT157t/4B4qXlk0B/pnwJdmVLeuP1C5j84hhdX9LIQlFJYJ51c/EwuoPm5Ok90k5nzUzQXZMnk4FQyPrYjI586wspkLsdx8itBUixGq3Z9wFtDGwQhUlPomzi+WjDKC6mm7woaftaGRuirZ4KCyUkHxW+ptSDXc8AtAAzp/X6O4fTGwLBtWFYfgf56ZtLe8NH6xWE3cekDYLM2e97E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uFMvOWCIEeyV8JJEtqMUBrmL9uzZ6jeLp0vRmaoLBRN7jJyq3dc+bmO41p1x?=
 =?us-ascii?Q?PzMRLtjXk5F5lh/0BWeHNoCAoiYJBNEpDHdAWLkcJApDkCwr4xfAoMHHnCGT?=
 =?us-ascii?Q?BRVrauWG3inG7i2h0xYlyieKEzxOwhYYjDcDRb67qgDFhRblOo/sxp+nVK8W?=
 =?us-ascii?Q?AViydFobyJpvNnXVVYchVdzRwk4tm+cLLTVqAdjHPum6oyTGzM7gnjT98SLI?=
 =?us-ascii?Q?JDRUXZBijlMzqqeCk2MUg8nMzVpsWSDvo4sYoOO1PaRiDJ/xWuUvoY+LlT5V?=
 =?us-ascii?Q?YxMINc8v0u1ZWYWiHC55hAEHg8lL3fdrW8aVYXWGwd+bof+dxIL5YaS2eEor?=
 =?us-ascii?Q?M0x5D5R0VfSPUWO8Pmz/qIXd4LNDoOxSdyGy3keaLukKHBUCnCd+3dN8U3CV?=
 =?us-ascii?Q?qZlZkA1LVKaXOp9Djt+PAxdfq4Pib5GIbtq1UVwiW3XiOhysTun7KOqXQ/89?=
 =?us-ascii?Q?Rl+p2OfGzxR8Gs3qDwFR5AcMFd5v3rHTClzOEL0KJ7PokZ/rRC2CNfFoyMvI?=
 =?us-ascii?Q?S4urVX1sTto2Pfw3w5mZOyo7NefyknZlzCmVkfIb4CP4QpK5R2HUKbewl8uB?=
 =?us-ascii?Q?Bj5eHlPuqIdLgMDReJvSvdfYE7uZgjvl4FeYHI6f8j4roE0dPMNNA2N1Nd7k?=
 =?us-ascii?Q?xdXMmfhmLzALRi9I3BUO9/LRz9mxji0uxHbh4wuA08nHkYXigZxXHLqYAOwO?=
 =?us-ascii?Q?oUXlcTVT7VWyQggBvLnN8Cc6TTW/atlqlUd+hTlrtEKHmJJ9I3hJZeeL+H38?=
 =?us-ascii?Q?7vS0gIbnBJ3ha1Vy/fIbM32rnCo/KIserfShkE36IsBrFv8kHu//4hfPtf5G?=
 =?us-ascii?Q?jnVGM9qdXBGW7Z6pOy/3mUFBjHJgooMIiwC/n+B1Kvs8Gq6+/d7I1FxaJbRG?=
 =?us-ascii?Q?YDkTRygIl3yTwwB1jiZ1ingG2l7YEgsX3TredYsz9FM9VIFW/R8IO9EHyjVC?=
 =?us-ascii?Q?0YdzPWJ52LnAh/6pZPdvfawI83q+UZqnnxO7jz+kVYoGgC1rgyMB5E87JDIO?=
 =?us-ascii?Q?yPDc666MYeYQmAl+sQuyLcjADGhLFj11pnI89rM0YSf7tEYk3t/u8q7/faqm?=
 =?us-ascii?Q?xiWawPjVA39UDvcMQKUxC9BCg7oT8nCtV3NbwzcR8TwvDY+OMvnF7MRD4JmZ?=
 =?us-ascii?Q?cZO7nnieSU0xlgWhupDEQXXmCr93PgwrWqO3XRAia5n8vgrK7ugxre/QZVya?=
 =?us-ascii?Q?zt64Eu8GVjWqIFfR7tUnAHnpuOY+3+f2xP0J5f4msOv0JLDyKKhJC05651Wz?=
 =?us-ascii?Q?ZFbVnGbGS8ln8qu3Ci9oGLkMo84RBn4qQp0OOzdOyHvuZG9HkfagtpT6dmzA?=
 =?us-ascii?Q?9Y3nrEbkY3XazIrl/BHgDqSQgcXHe9iN6BCasvW5eWsk9JNyvInvJiJH4c7I?=
 =?us-ascii?Q?eDxDJUo1UY+DlxlOVmdtUds7lymwHHN9aRDRf1BAoviDvBAR4ey+o5p+x8Yv?=
 =?us-ascii?Q?haeoPAubVwe1H5Ulevfpz2Yqhj3HJ2FmDGpgAy28NZvxi6sBYrOE4YlwSoKJ?=
 =?us-ascii?Q?s3wWDFEw/hMg4AnEMv+sWjFT2W031Shsem4q2l0QWTj0CG3MPPLQ/IJp6Viw?=
 =?us-ascii?Q?Fx8K87OqP04dLrXESAR9OGqMHyHIUz1QgtIy9WHd5fZpR8Z8Wn1jWUisWiNr?=
 =?us-ascii?Q?3iT0Cl/SCmRk8fbNiTrd0Tx1GYmJ1WODrsCsXxDj5Pncvw2m33Q1j793d+FG?=
 =?us-ascii?Q?kalR/V0rjJNUIzp7y1AG+4Dl3X4zUixdWABBE9znwY3q3lQHfeSn1ZJXRYci?=
 =?us-ascii?Q?iTFDFuoZ3FqTZSG7uXE8n4XVIu/9AcmpZ4fux7g2WGTWGIJFB+ewIj43wGJg?=
X-MS-Exchange-AntiSpam-MessageData-1: uOEBpnzwCsk9XYQPmKjH0OtRMLo1cFJonwM=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0666f7-8601-4776-dc1a-08de7570828e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 19:52:02.2904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rV/TBZuOM8FG1RQV7hAhNe1wh1G4BK4+uHjs2KnI1Y10c59efmz7q9KxwM48aETzRZ+c0TpywLIMJn3HmOXa5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261561-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 564E31AEB79
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 08:28:53PM +0100, Zefir Kurtisi wrote:
> Thank you for the feedback and clarifications.
> 
> The statement that SITXIDR/SIRXIDR bits are directly linked to TBaIDR/RBaIDR
> is missing in the reference manual, i.e. it states that the former represent
> a summary of the latter, but not that W1C-ing the bits in SITXIDR would also
> move the other direction and clear TBaIDR. That clarifies quite a bit,
> thanks.
> 
> As for your request to take the mainline branch, I am depending on a OpenWRT
> build-system and shifting linux kernel-versions is unfortunately not
> something I can do in no time. As for the potentially missing patch you
> pointed me to, I backported that one, but it makes no difference.
> 
> Luckily meanwhile I was able to narrow down the issue and can provide you a
> means to hopefully reproduce it. This is the tl;dr version:
> 
> * enetc operates eth0
> * ath9k operates wlan0
> * both are bridged over OVS
> * device is AP with an active STA connected to it
> * STA regularly sends an L2 WNM keep-alive frame
>  * that frame is 'buggy' as being tagged IPv4 but without payload
> * through the OVS bridge that frame makes it into eth0 TX path
> * enetc_start_xmit() enqueues it into TX-BD
> * HW processes that descriptor, sets IDR and issues interrupt
> * enetc_clean_tx_ring()
>  * gets a bds_to_clean=0 (tx_ring->tcir = tx_ring->next_to_clean)
>   * i.e. HW signals it completed the BD but did not advance TCIR
>  * skips the while() loop
>  * and hence never clears the according SITXIDR bit
> * enetc_poll() after completion of ring processing
>  * re-enables interrupts
>  * but the one bit in SITXIDR is now sticky
> * interrupt is re-asserted immediately
> * the affected core remains 100% SIRQing
> * it only recovers when the affected TX ring advances
> 
> So in short, enetc breaks when sending 0-byte frames.
> 
> The patch that I provided resolves the problem by force-cleaning all IDRs
> before interrupts are re-enabled. That is the sledge-hammer approach, since
> it also unmasks BDs that were just completed during
> execution of enetc_poll() or no_eof BDs. Hence it is not the final
> solution, but currently anything is better than a freezing box.
> 
> Below is the tool I wrote to fire such a frame-of-death. If you can
> reproduce the observation, I'd prepare a v2 patch to unblock the issue once
> it happens - preventing enetc_start_xmit() from sending such frames I'd
> leave to you, since that part looks complex to me to handle it properly.
> 
> 
> Cheers,
> Zefir
> 
> ---
> 
> #include <stdio.h>
> #include <string.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <sys/socket.h>
> #include <net/ethernet.h>
> #include <netpacket/packet.h>
> #include <net/if.h>
> #include <arpa/inet.h>
> #include <sys/ioctl.h>
> 
> /*
>  * Enetc-Killer
>  *
>  * This is a PoC for fsl_enetc Ethernet driver to detect an
>  * issue the driver has when zero-payload IP packets are sent.
>  *
>  * It was detected when using an enetc Ethernet interface bridged
>  * with a wireless interface operating as AP. A connected client
>  * regularly sends L2 WNM keep-alive frames without IP payload.
>  * Through the bridge this 'buggy' packet makes it into the
>  * enetc TX path, which the driver enqueues for sending and
>  * the HW signals transmission done but without providing a
>  * completed TX-BD. This leads to a sticky interrupt detected
>  * flag causing a SIRQ-storm.
>  *
>  * This has been tested on a LS1028A based system under an
>  * OpenWRT derivative / linux 6.6.93
>  *
>  * To test:
>  * * build and copy binary to device
>  * * connect over serial, leave eth0 idle
>  * * ensure device runs with multiple cores enabled (otherwise it freezes)
>  * * run the program
>  * * with top, observe that one core is fully loaded with SIRQ
>  * * to recover, storm-ping eth0 from outside to
>  *   enforce TX-BD advance
>  */
> 
> int main()
> {
> 	int sock = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
> 	if (sock < 0) {
> 		perror("socket");
> 		return 1;
> 	}
> 
> 	struct ifreq ifr;
> 	memset(&ifr, 0, sizeof(ifr));
> 	strncpy(ifr.ifr_name, "eth0", IFNAMSIZ);
> 	if (ioctl(sock, SIOCGIFINDEX, &ifr) < 0) {
> 		perror("ioctl");
> 		return 1;
> 	}
> 
> 	struct sockaddr_ll addr = { 0 };
> 	addr.sll_family = AF_PACKET;
> 	addr.sll_ifindex = ifr.ifr_ifindex;
> 	addr.sll_halen = ETH_ALEN;
> 	addr.sll_protocol = htons(ETH_P_IP);
> 	// Destination MAC (Broadcast)
> 	addr.sll_addr[0] = 0xff;
> 	addr.sll_addr[1] = 0xff;
> 	addr.sll_addr[2] = 0xff;
> 	addr.sll_addr[3] = 0xff;
> 	addr.sll_addr[4] = 0xff;
> 	addr.sll_addr[5] = 0xff;
> 
> 	// "broken" packet: only Ethernet-header, no IP-payload
> 	// as sent by wpa_supplicant as L2 WNM keep-alive frame
> 	unsigned char buf[14] = {
> 		0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	// DST MAC
> 		0x00, 0x11, 0x22, 0x33, 0x44, 0x55,	// SRC MAC
> 		0x08, 0x00				// EtherType = IPv4
> 	};
> 
> 	if (sendto(sock, buf, sizeof(buf), 0, (struct sockaddr*) &addr,
> sizeof(addr)) < 0) {
> 		perror("sendto");
> 		return 1;
> 	}
> 	close(sock);
> 	return 0;
> }
> 

If I understand correctly, this patch should resolve your issue?

From 887cf74648fb10b7dee3c60199349d184c5a851e Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 26 Feb 2026 21:50:13 +0200
Subject: [PATCH] net: enetc: avoid sending too short Ethernet frames

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index b0b47b0f7723..4f5e593b348a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -982,6 +982,9 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 	struct enetc_bdr *tx_ring;
 	int count;
 
+	if (eth_skb_pad(skb))
+		return NETDEV_TX_OK;
+
 	/* Queue one-step Sync packet if already locked */
 	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
 		if (test_and_set_bit_lock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS,
-- 
2.43.0


