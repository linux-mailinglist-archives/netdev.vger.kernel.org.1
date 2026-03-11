Return-Path: <netdev+bounces-266520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFalEAgisWkOrQIAu9opvQ
	(envelope-from <netdev+bounces-266520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:04:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B5525E620
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72F543034C85
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 08:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6613B47DC;
	Wed, 11 Mar 2026 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iKc5oZlY"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D316E3B6358;
	Wed, 11 Mar 2026 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773216167; cv=fail; b=UerbMwNiMnFTXd+Mo50THCg4sjN2Q2lqc+MjHpliWmELRRzbppnpJ066JQrwPKYSRti7PLRia1CFdrUUK3ZH8CW4LGoP7wuNA6t5AZm/p9fonDDGlYTG7qzMmhYwFNtDjgZnuJnpgKno9Di6pfWFSWCKNI7XNUf9/huRjG5nq+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773216167; c=relaxed/simple;
	bh=6O2GmFfcf8tabzAzyuE9zkWLDI0SovytqQnIMOXYBaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o44bVEN0FB8zBbvRNIb2sGXSdkYmmsD3jLW53OORXPqwrGFE5VEq8FrfmWdl9EBacoeg64v+5m41TcmUpMfQpG5VSXcHEA+JVbZIytD/d8x9klEo5Wd8pRlDbLSEzWZGQiMo8qixxtoJrTeu16+1S2Sf8D71GtO9+YAK7s+AOgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iKc5oZlY; arc=fail smtp.client-ip=52.101.84.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWF8PAj1vwxgORl0Bj2qkxJqLZO6hpk+bS65Xq+UEm+2Kpk+M2PlkxV244pzY4/dKIM8B6Q0k6Lu4KC1mpTrpTgzByiIO11k1BdRrM6Apx+sBp/kt0vR+t8+eX1X0nM732lPCBjtV5YjdaerRLpZjuv8BQVDo1zxpElFAq7+qtmsjDgOfDRP4WZaIhCblVPKIfO16BzZV/kzrjLk1F01N5mT8PdMQX9OIMAbh8EQHYndhe9TThSWtRkVhNCWLJ5r/ylJaMoMxb42aRs4Pby7T1F1CNA3JLNpDsW4EEzKYkDfTjptBfY4ziH5zH4GmZVyuYEm4COn31i6IwWaw3RGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKpRU9T9zNqPO+squnXDcQZydo3mRpTDAGRKT7t5ga0=;
 b=k+1aIh8hLucnxvwjkrpc7unhR0q7HeJhmXhU8zg5DiIPKv0e5pVL5/xbgsM4tiCKBjSb+rPXR3qxsenB1wRz18LEhdfTX/29U0uTr16HpFtJdMr5sHaCwxVOiG0kp650diOeQr1L+CU7/onSdV2ItbHSbzEWh7lKswsx/RDfbQ8keA24ehKq9b8C6SXNzXgdG0h4BYho2vMxWbSZQWzZbMhlwKi3s8gqyCHFRsSLwYQDLrB+nvZRszu4V2lKdMrpOyYGwoFdn6Z+5gaYmKKbY1MlmKYjrsVRD2kDtQWXDu5rJ4+ukQ4NUvxAEDDMospWDwFsV4wEMT+QLY3WM8okiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKpRU9T9zNqPO+squnXDcQZydo3mRpTDAGRKT7t5ga0=;
 b=iKc5oZlYBZI8alUXY1jrFaQLU1NERyvx+rccKGufsZwdHBHN4yhXidqshP2w+ZXMTtnjlZ5kkksssaTof4u08+VLHraChYFCo+VOo900yQrvaQdeWT8d1qZ6UKZdsusOifQq+kfji+Z8kzGKmrrwRo8jZdseKFOm876Oownhg/8Yz6TOCtt86lkQHN89hEeT15yCMESBGDVvHdxKMRBWMafVHY57740LCvyXiBoUYHigCQFqgnUMo1GUca8T7ADw4B3Tnwgt7Qs7AuisMd/xcXguTeSZMo1jiKSnrlSZaZCAaAMl2bOeFcwx8J6XZtUparU90Z3Cw1w9T4J7U4LFqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PAWPR04MB9909.eurprd04.prod.outlook.com (2603:10a6:102:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Wed, 11 Mar
 2026 08:02:40 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9678.024; Wed, 11 Mar 2026
 08:02:39 +0000
Date: Wed, 11 Mar 2026 10:02:34 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next 0/2] dpaa2: fix config relation with
 FSL_DPAA2_SWITCH
Message-ID: <bvsswaffjo37rsg5e3mybbe22qe7hxvuz4blzmo3cdf5fk36d4@ioac5utjlpx6>
References: <20260309125018.420275-1-caixinchen1@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309125018.420275-1-caixinchen1@huawei.com>
X-ClientProxiedBy: AM0P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::32) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PAWPR04MB9909:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdb7857-5c1a-41a4-f2b6-08de7f449002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EYKZ9OvpcnjgoBG9DjD12c61uEHo2iZzksjY4h7z5y69LLNomagWZeO1/H9o1/bsuKwrafc8SifylZVWZD3oHHK4Ex+wBOa/jbwxXFdtmHr60Ar4VU+b4vUE10m2bvnAlsp14zpk95b/4ZMg9LX+Qf+uKrNV0FrKoCMuiGP3AcmGeshL/8yDiM9YMfJN+iDxaY636JAIRLRCcQ02NCByNt4zieIS1ulppjg5SQIJc5DFQtUuDEDOKJBb9x7kWtaX9H50caqIcizdz62Fx6QyqZGpQop622XRcz70/a1y3edrS3br9jQSqp1sAK9kAJ/pghVf9IIs6xinIeay0nWdDKWvuihu9tzfm0sy3ZPLg3sepdjTwyuZ2AdlYHTMYy7HWYLDB3Ftlh75Pj+1x/ZFzxWX9vVhxr+JnobideVcFX9jnZfbKMOvTdlHSMrCVGGxRgornWEUYYoEJoxeZz1ieeyN7MYHWOXY6Tlv+3icAHSzHdLp2vJlpzz2qaoQtREKJ5hiHqT4r/RgANQegPYjPD2whFLmLcCmxkd7gsp0zX4RI0U8N6hzrllDJXA4BXYZ1r240URQLLa0jfx6YO9xH6iKxy5S3WIbD1EjXLWnUx+D8hSiJPKtVjntkiOQbmOvL/P/7J/+mIbNfsy0OoD3A3hcSYwQZwJCTY99vBdBcnp1wz/wU5ZsCFREE3RiJZH6wN0shSdVNPRLiiDIJg4jdtL7cmuLjA+2D3DwikFRM8w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TxwGyXCbec9K1cOnGUDdXVEwI0s4SrW1mgEPFcmokSnxjh/cTkeL8CD46/i1?=
 =?us-ascii?Q?9luAwkVuNXTEzNpYYsDCU1HJMsv0C2dd13phdCPPh2sqJ1Dn9kO/h3wfhQA9?=
 =?us-ascii?Q?/adq5Wi7HhQFRA9eNNTXBs2Y7rQX41Yx2cA82F/re4x9PWoez1oxIdjZ0j8c?=
 =?us-ascii?Q?wedcG61JvpO8ckuwqOq1pXbo+y2C8xaeUXRcUfYSk8BSFw8fkL4eEuejS0/v?=
 =?us-ascii?Q?0TjC/AoWEr600SHI8rm4u+FLQ9gWodIs26k5HPm21llX5/p38jh7vJhlvLBK?=
 =?us-ascii?Q?YYHbQsXelRgkPaVK5pEpfbOyNe9NpPGDNRbv+vEV6E8SYV0kv08Sx20emUmE?=
 =?us-ascii?Q?SmJoprMaWBqWg/EmCym6VAi5azOiMj9Vv8pLuFDoWZU5/QfPnSOXnBGbQGSp?=
 =?us-ascii?Q?CAFiAyF4guuDyCYY59xXW/Fc4k8Mg+sOqQ6/4DdXfYWld7KkhXhsAUIcS+dM?=
 =?us-ascii?Q?APOUcqI4OWyN6BVLSpIlgqb3M/B96b1PfSHV8hBUWmdWqE3VhV5+ulmXx2qn?=
 =?us-ascii?Q?ejkjGGdFbAYzWCuthNL+qXq3MTjnDjmIUyo5pZBJqIldlBMhsa72gxxvylCQ?=
 =?us-ascii?Q?MQZXfsOPG6y93a49FyUBKUkg4PG2opZdz2YHcK+SmL/Rw6uV9fS9VzqKIBir?=
 =?us-ascii?Q?utZCUlpA3jjaVSkop6VtgHQOHZ/++mtCgFXyUqzP49+AlCXUt7i1g1UgJA+t?=
 =?us-ascii?Q?LunGOFETePt5rh2HOhnVOXjwZLVFQI/Kv24w9ektu7pQ5zJAPjibx36MEULD?=
 =?us-ascii?Q?OpqPSvpl94kXPmITjDDHScWvHuOdUK87KeNogK7x4Jgs1tBTTEI/MkNZ4CaU?=
 =?us-ascii?Q?OLy5Su7QMyzhTsca/45ayjQESt0X+i8c7OvSBPsXS4Kzso/isQRsuYuB2aoE?=
 =?us-ascii?Q?67SrwcgojMqNdWeL9NsHpYwt+UL5KBAqv8b/rlZwFD68uyI7YTKYjZimeG2c?=
 =?us-ascii?Q?fBgosrSD+CNyHaXEy4jgj9HrKQufyqoD2wj89biL7FKrlHCt6ZSR5gmQOEUj?=
 =?us-ascii?Q?rE/zbkCXkirsiYnBLv85Opmb0LlIa86AHoHIoYxQAv4Y9xsSagZnY0b6yxRt?=
 =?us-ascii?Q?nvHqiUEZmAd4a3yWxdIL6sE70sPLhwVcY26ULrw67ZfC0vSnS0I6LWGgKOJO?=
 =?us-ascii?Q?VBaPTT0/JbD81mffBUeNOWtzGFlZ310i3h7Xx5GzH82vqFWwB9IEQU9+OLum?=
 =?us-ascii?Q?ai0KTf5RGH3ZfufobReLPhHAlllcWaMOblc5LZ0vLSzOMjxBuifS0XYoOBWT?=
 =?us-ascii?Q?qL7UIWM26kgOpobwTeiBEOQbOwT9+jZlCCe0JjXGBamR+8it21MnCPy2ZEvx?=
 =?us-ascii?Q?kw5hsWqmG/Lma+wgtcqVRVAIz3qJMEjV7mYVIwS0xQOdlNn0tdNXOhcH4UQl?=
 =?us-ascii?Q?n6RAS0m4AOkdvPKZ7bzQmhbuVltGuMRNaqHWIXIEdo2foVglMZDtaMr1V3PD?=
 =?us-ascii?Q?o148i8Xr4+lJHWlezMS5bdiCrDRNSy1otpqbVxTl+B6WJjJb10T4O0SLTWso?=
 =?us-ascii?Q?63HtXgg3TdgPzK33NRjaCCs6tgysfWeY0jWzHUkmhtsQ856Hi8522+pW9jUv?=
 =?us-ascii?Q?vUAgYDkTfalTrhau7gK8G3WBLj4PozrLUyPhahqPYCta5aFcjbFD4w9atpIG?=
 =?us-ascii?Q?e+bFzIc83RDs3JHJrPO1BBB8DYrkagG5Efu+GyahozPVy1dENwK5ef1WPAVb?=
 =?us-ascii?Q?x/TEU9J6+YwzICbJw9zJCugkgZ816RCv/S1U/QjdXJJxoBQGEjCQ2BnuI/pB?=
 =?us-ascii?Q?Fya94gbfkg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdb7857-5c1a-41a4-f2b6-08de7f449002
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 08:02:39.2345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmxcxXXghJeHBJ55PHaRzGn2JyrxihLNC9vT59SCtXrgdxMG2xRmJL1Mk0z8C4xWxiOsjSGEVjy7Zo05LrDv+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9909
X-Rspamd-Queue-Id: B7B5525E620
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266520-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 12:50:16PM +0000, Cai Xinchen wrote:
> When compile FSL_DPAA2_SWITCH, it needs to set CONFIG_FSL_DPAA2_ETH=y,
> otherwise it cannot be compiled.
> And as Ioana Ciornei sugggested, FSL_DPAA2_SWITCH included dpaa2-mac.o in
> the driver, but it does not select PCS_LYNX, PHYLINK and FSL_XGMAC_MDIO
> 
> v1->v2
> There is no code dependency between the dpaa2-switch driver and the
> dpaa2-eth, so use Makefile to control dpaa2-eth instead of using depending
> on in Kconfig.
> And add select PCS_LYNX, PHYLINK and FSL_XGMAC_MDIO for FSL_DPAA2_SWITCH.

Thanks for submitting this!

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>


