Return-Path: <netdev+bounces-299884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fjugFgtpMWq8igUAu9opvQ
	(envelope-from <netdev+bounces-299884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 17:17:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FAB690E1F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 17:17:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=AKRsWACO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299884-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299884-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 772BC3013BA8
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D0643DA3C;
	Tue, 16 Jun 2026 15:16:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0707444103F;
	Tue, 16 Jun 2026 15:16:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623007; cv=fail; b=pg5D38ZK5a35ocxTzNSswCuPBA1BP3RZhwC8KN2Zxs6H1FWGbK5AsHvKoQ1/gKlYR/2pG3agjp+LCusZ3BzYNqiN85WFQQ8iQObzrRyZMQxnRlT1J2XMbdTZ9WsFwjqnXEQkGowkQ1hMzwrKgp/zPykIaGeVaMC2q2A52HoKe/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623007; c=relaxed/simple;
	bh=adQaE8H9mK3pYxRlagUAVX9BLwlNgbiFM7OFz/sHons=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=suTogQVTqyKq66J+GHPFKCxMFMlldAIYGcyZJsvSQBTDlXGRGLzXop12FCRgZ5hbRpWaFjAsizN6CMCnhvxNadPtQvjmWvxPeQI6d3TGFYiioPCh50IrOn0PyedF9NOzOFfu9hKxmnxpX4+/k+6r/dQhvp7C3Q1GdVviAWWWcgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AKRsWACO; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFkMe6QmVQfKTeKwGd6MlxzFzhWV8l4gGTAnMbjrDckz0I4BM1vxV5GQ01P9QabmTnBuUyHw9GQRgKnTSrqvSfML43d3C0hN6GsKZsM/Yp70P1mh42HR4uKKdHK7qhR99ETuqvjtK2uUptQpxfp4kx185LO/dekFGhKYQMYXzwoU4b6Y9pedcFAqA1+PyX2CRN1Zy3TFA5iHlTmgpaxRRmGMhZgmOyvBl1HzuCRc/S9XPsC/NvjFamk6Y4xogoBxolfzYC56mM1cG25rbDcZ0M8QhSi7odiz3KVHrh1NxJRcsFWKGG5ONSBxW5Cid1jIDk/YUV6S22s6OdukI7p/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hEN0DTeXbWZUpzvYHOO0nyXGy7OAeRiHgqlqV2w+kg=;
 b=dEEbJUfIezxvRhRhDOxvHGFWox4Af+9y+u31Rjl0j2gfsTomnHmk36UnGrhjjUOAmso/uw8PudYv0Ekw0zT+jwZf5NvKC+imJtR4cwAoQ2n1Ckrwwe9karETgvFUzqTZmkvM2IncK/CPqdO4ia/9PHJuzZqm6s/2HhvP2FNQuDGySb3/IFB6ulx4qePyfEJzucnFskQoyUaOi3sTpVuX1em1FJZkmHB00o8OtLFiFF/+sdzQsrZWGphVgxz/EVGNKzmQFDeEamXn5ddsuJu+l4iybZKo+xD8U9NPdzUncCFoTike+mg9NN24ew8A0laWvH2PUHwb8a+o+H7v7C8NOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hEN0DTeXbWZUpzvYHOO0nyXGy7OAeRiHgqlqV2w+kg=;
 b=AKRsWACOgdmudtw5Plp3cl13KDrwTH80ODqU/OQcedktoZhD3wkuwmVzXANtogXtrVPOachO5K0N4m1xqtE9W0pT8aJiQSXU/iPQ/loez8gPLBxlwnsxlBJW2L+F3YR+XXXFBY8VIsNLctLZZTdhEDd3rmoRLk/zOX0ErCYvV6B6vHB1Bxp9WZyhDD+xp0PJHvlIZNtFekqwNO6qVhf7S6mPG0XSBOk/r7aU5EHMw4Gxz/S8FmmMutAdqJQKPnLLtiQ+Ud9tQb6hsyX/TvV54CcW/dRcYh40acC3XWW2WgKMBJWlZuAcZT1dxO7TRhShj3yuKqaCgeVJFxiTTx1Elw==
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS8PR04MB8296.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 15:16:43 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 15:16:43 +0000
Date: Tue, 16 Jun 2026 18:16:40 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Simon Horman <horms@kernel.org>
Cc: muhammad.nazim.amirul.nazle.asmade@altera.com, netdev@vger.kernel.org,
	andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	faizal.abdul.rahim@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethtool: mm: Increase FPE verification retry count
Message-ID: <20260616151640.qi4bobvcbeyptvgg@skbuf>
References: <20260615072436.26128-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260616071925.GA800687@horms.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616071925.GA800687@horms.kernel.org>
X-ClientProxiedBy: VI1PR0502CA0014.eurprd05.prod.outlook.com
 (2603:10a6:803:1::27) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS8PR04MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3dd352-90dc-4988-cdaf-08decbba460a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|19092799006|366016|7416014|23010399003|376014|22082099003|18002099003|56012099006|5023799004|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	oi4ZgdcE65rwPgwXQgy30YGIBBGjtgHn4rx2VUZZBIUOlVEXbAob3UZnVE/+IrNGlllEjarcYlOnJo0qs7nVCqr2+TaL26UeJpKTWkxNNLNI2gK8LWAgnVW1zfXJ53V8odclAgzNJSPNmSx5002yOVsuxvgC+FFjsKBJqFAhYN7GWzH1vh1bB5q+j8AW1m4QF0b+9xavUI3VC7/Gfvgx2JJbUJe2w/abL8hmWrQdWcR7au4kfS9YISZMgHS7LPqDJ1JUk25YWSFn+xQfoW48R2WsHcNXsgntRJZId1xB49h0dC7rWWVTDgoUgia+28ckxJI6qrL00wVD2YUGqCi5s6UsoyFXeUc/zhLjmSFDtyIbpsWMCv1PVqRxvkFUHrcfFGfn6udvUXV8n51Z4l2MF+1G69orB7+kRYUPbLdoifNveRQ9xWAX1YmaWCf0R56J46BHqfyslYi9NDDzpLwd4pGjOXPyTmld8I1dyrW2Eyd2Tt8cv30CTlzOHq6dz8+ga2xoTpY53lUVhZ9KWBNSgUnWbmJNTL9fR3L2+yuUpeWMEG1g7FIWbefdcodVbA3kS28KpUqSYUr27Wd75w7b8g3zewIowyG9krUW3podlBjp7p8xI6s75AWD5Ha+BB69WQjaK5wEVlTWb0ZPLHmsxtS/vxVx9FWrsQpcaGlIXKqVgVFwNofFuVpX/7qLcUZb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(19092799006)(366016)(7416014)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(5023799004)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mphkQaz6xOD/5iFu7kYIjm07I6uKak+tzlzYxOrFqBAbNzO2aidOXHhhpvc7?=
 =?us-ascii?Q?yrBUhK0HHYeYJbq+MjcOJlLVTCa9pFCXwfr7wfjqoLfOEb0760XNwwTxd7N5?=
 =?us-ascii?Q?L51wWGrN4uuipyvruYPoDc/sdEKD7S6PhMOBLio/R+07uWYSfMnHyxKa/uY2?=
 =?us-ascii?Q?dCqEKOr6Y1+d1TSeGCt6HOqKemgyXwYVRhUN9mX52Qb3uGuRhJ+XeTb4NAHW?=
 =?us-ascii?Q?L+D/AacLh6fPwelrzbOInxLEXS3Bf1TKWd5QobGrhnqPbbcgjCB5jC71zj1i?=
 =?us-ascii?Q?RaQqMKjusVRosmzFIK3SW+p9D6S4qwF3FBDhzv39pKez+bHCpmCnxMMo8Mwd?=
 =?us-ascii?Q?lTpv67SVgE9P3A4JiHxYfKR2WuEKPqYlN42cH/yY+u79ojDTLccZGyRcouvw?=
 =?us-ascii?Q?znIHFAUSJVxWlVRdeS57kIKgESOtHDDbX7/r+lSzkLaJhwxypjIqpC5KED5o?=
 =?us-ascii?Q?OgwZgZXjYVCSnNr+D3pWCGHqxr67ec5Empfrwqa0dQVHjD8YA9j4KALbK1SP?=
 =?us-ascii?Q?EWOXP6kBXg336TWsmcetZKqI5wKO5vx/z4YnyIP4uTh2TGyz4icS5X8l866R?=
 =?us-ascii?Q?4ErpJ2QL2OySjYcoNH53JGnpPvY/OTH/csCof/bgayeV+nTcyrSOhxcrbShQ?=
 =?us-ascii?Q?cuPNTOLpJtqCnMKrLVZ7hbJ1eePKBQvcCo/vEyIdWwMbSAwO8jN1s6+roLet?=
 =?us-ascii?Q?4s2Xvrreq4fHD9m6Q/aH+Cdl4tVPtjNecbcAwIqrd8P2xuBobXqZqJTH8KLO?=
 =?us-ascii?Q?MLbg1O8SZwNIqa0DDW0ujeo0jcvdjeYPQEfVN0oop1eZJfG7vtlerCQ1luAf?=
 =?us-ascii?Q?yz0fjAVsj3S2P1PlbO9R+CylaKxQ4RQvTcODYH8UNYR3LROx/4ZvjgtrNyFh?=
 =?us-ascii?Q?YqTpGrMB5uIkvPjLU/9MRrxnKAFGEVJ5ymZ5vRLW+Kr17DZr802zThnRuxAk?=
 =?us-ascii?Q?SyK8m+DscY+z1s0O+QYkCcZgRswvn/RP5Sxutrj1DgrESki9FtUbWGl/ypGM?=
 =?us-ascii?Q?Y6EDncuhEUMWobE0b5ktbuPsF4JNDDJEDHAOCkvqFTfKLvcH8H8D/GXI/41W?=
 =?us-ascii?Q?SlD5fzFVVwfCp14R8l/mPCd+40xWtUFhS5y27Z6osMuwbEVCFK7egL1/vSET?=
 =?us-ascii?Q?/JrPvf5j4ZbgIigd2tQ2Ox/CX+5e0UiynruaWOJDgfzUZeAfbysy/q4bFUuY?=
 =?us-ascii?Q?R/mxGWtKM+GsnTsQ0IL6yZZXoPsB385h1X04H3HpM+EJXqMXmj3rMP5CfICf?=
 =?us-ascii?Q?xm4Vqszhvqdj1JDH3H+I2/Ml14AqvRuzBROSYeeQYw1j7KEb+BC89beTK/aR?=
 =?us-ascii?Q?bCMFkxKed5FT2GGZz4vgiNUCOXlt5nhY+U7qeVgmAP0EekXU3PZ+BpwOpxVv?=
 =?us-ascii?Q?bSi59GwlGKIRYoptL08x6WEVmAdf151sRjUaatHy7yBKzcxIKxIydaZJc+lP?=
 =?us-ascii?Q?VXN2+Y4vhx/ZwtfEE/ei0RMQ9Offm9IfMbeQHj5BWhw9GX8e6ZagcktsdHyX?=
 =?us-ascii?Q?fDVQYd2YI2tOrkadx7YwwcCB0e4su13TwlmDQSR3P+gTGuxZztbYkodS3aq4?=
 =?us-ascii?Q?ITUTIaa0qP5mMGlBvhjExGQhMKFr7r+5SB0KIFPaou5gmMVMFMdooFdlHDAt?=
 =?us-ascii?Q?IW49fj8lz/FH5dl8imutbim38hmk50m1jb/+ENfL/c1kAgLkUDPgsjT59Rky?=
 =?us-ascii?Q?r6pxD7sDf7cDZq7O0vBx8c86C4WqLMBUtk6G3B+DYYR2E7JXGitWNILsMOBJ?=
 =?us-ascii?Q?m+nyP1LZWVFreESvdmJYOVhbDLthblBDgHUJ/FkoZOAKVoTzIjdyvqwT+wJk?=
X-MS-Exchange-AntiSpam-MessageData-1: YIBBtIq/kLeOGEjnoOvDVFuIkCMVdKB5PBk=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3dd352-90dc-4988-cdaf-08decbba460a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 15:16:43.4331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39iSjUsHa5xokkWh/UCdtkmrAV8mOhTPnRzFGjKWWEBxOL51sXHHbdPDFh0j2PW7/iuiXWAuwzzrD87GVgMHxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8296
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299884-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:faizal.abdul.rahim@linux.intel.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,altera.com:email,nxp.com:dkim,nxp.com:from_mime,skbuf:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15FAB690E1F

On Tue, Jun 16, 2026 at 08:19:25AM +0100, Simon Horman wrote:
> + Vladimir
> 
> On Mon, Jun 15, 2026 at 12:24:36AM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> > From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> > 
> > The current FPE verification retry count is set to 3. However,
> > the IEEE 802.3br standard does not specify a fixed value for this.
> > A retry count of 3 may be insufficient when the remote device is
> > slow to respond during link-up. Increase the retry count to 20 to
> > improve robustness.
> > 
> > Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> > Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Vladimir, I'm wondering if you could take a look at this one.

IEEE 802.3br is an obsolete standard, I don't even have access to it.

IEEE 802.3-2022 is the current one for the MAC Merge layer. Clause
99.4.7.2 Constants states:

verifyLimit: the integer 3, the number of verification attempts

I don't have something in principle against making the verifyLimit
configurable past IEEE 802.3 for debugging purposes or non-standard
applications, but keep the default to 3.

