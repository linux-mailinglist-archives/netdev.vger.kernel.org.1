Return-Path: <netdev+bounces-279896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC4eMyBy5mlgwgEAu9opvQ
	(envelope-from <netdev+bounces-279896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:36:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D2890432EF3
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 939163002B68
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB783AE1AF;
	Mon, 20 Apr 2026 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cm24McTT"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010020.outbound.protection.outlook.com [40.93.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8573A7F41
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776709616; cv=fail; b=Ds8IodRWt1Fm3TtsNRPQbBwipXeae0JhikB20/k4+nQNQiioLu56K73oK0/0FCe+zdOiMrsMVwwLeLCJBQwZ1UOYDOFqDIIwHG/JMyxpa5R8rtfsRi+DSDICtoBZN/zJOtjjol5EF7k+8mt8Ai3PP6Ya4veOW3u9Ce9L9LezTvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776709616; c=relaxed/simple;
	bh=+fcOM0aLTEDWjJ5hsLtzlk/ciuzgAPG3VQjlx1jsW80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cahFtYNN+h88NzScnO2Ulbyg1T5I+CcYtnf2G3iR64jaLQOBDJJ4QySRZd40buareIBtjYfA0BPQJbziieykUoP1L67XPbJe9M1J3ez/CbnqnlF+jZlOvyoV81PL81dxTjiI36AIVvmcA4JwStcc4uQ0iUe+EmhRAFkUsCKqrN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cm24McTT; arc=fail smtp.client-ip=40.93.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBARyo4ZwY2cyH2K74ArDfJqkXrjM33uexRfK7aGdRz3yQaRr9Gfqyu0zg+UPgFRiTL8tJD1kbqEMVCw42e011uiRnDh/ShdpFo1c/+v8qf7Tuig3R1c3yVykh7pB6QtnALUIE+87YhlTtkizBD7j5us+zYXQmWbGstenLuN/Z06KwOAnqZXWh4nqm6Vd9xPfBUv0cLIRbiAJ5c+sBud+fZTD97r77lHp7IE/wO3aRVhrjwCLlYRGM7DyKQWCA+KECWBs9nSM8HSo/36ZKlHr+N+tKU1CaoQKomEy0AxVyDwfCIILmf/OmdDdrb1RK2DH+xgFAJ/3uETWoxLy+wnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkM1Wkjvv+Pp8SI1tns72BQUZiHxusSDJaqSL+G7l8Q=;
 b=jeUn8ymuFVJ7ThabVFTvMQ1eTe8DBOfn4a/nyjJY1H9IceXI/+TdujWIWpEokVWY8EDkMJXBs/6pd2KD86FyAU5fOgxDe+z/VrHOl6FMyNLYDS038LILS7DovXLm6Sspx3GfAVFSvIWBU2f+5icq9KqQZN1DPusc4Q4utcwF0Y1Zxe0gQ2jBef2IDjgrzfg90CI3hBfYNZ3TD92TtnHfjtWC9yiVoYM4uDQJRrMF1TeE49KErMzgxlsIHCzPpQBg/TCOKLZ9uuouzphXkeHcnv6+3Yak8ReKwJiCeDTu8UTwFfBwvI2+7NQLvNA+qDJxwudM5NKhdQo6+oCX/Qc0Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkM1Wkjvv+Pp8SI1tns72BQUZiHxusSDJaqSL+G7l8Q=;
 b=cm24McTT81qMCMWzOkpI0XZ+qvYl2XRFtFQAwDgsq+1keURDH2MwtsiF3bLNrZSHoZB5yJdwZxBADaoqh9ZEwdGyocWVFBuAzCvVa9ZXgxeL9aXj+nkkFaYOtuSHYlI5Ua3ztqLhc9JsJ4oZ6xdb74n++ECb5TeY709V4b5HcMVfj90oll7hmm6K4sbBSC7iR4RDuDQCk05PIR7eUj2J62nBZ30zlCVDEjwggQjz5FSFEVnpMTsCNZRxQlVvp76vy9HdYt4f4aAFU0do6inAkOnz+eJpAKBz1mNZgjUpsK77zjqQ6agvZu1+TbH6hKmGk1tnztHDxmFdIxN4XlKypQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 18:26:50 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 18:26:50 +0000
Date: Mon, 20 Apr 2026 21:26:40 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, idosch@mellanox.com, dsahern@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, yuantan098@gmail.com,
	bird@lzu.edu.cn, royenheart@gmail.com
Subject: Re: [PATCH net v3 1/1] net: l3mdev: Reject non-L3 uppers in slave
 helpers
Message-ID: <20260420182640.GA1027405@shredder>
References: <20260419145332.3988923-1-n05ec@lzu.edu.cn>
 <20260420113208.GA972415@shredder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420113208.GA972415@shredder>
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: e638fbec-26b9-4b90-137a-08de9f0a633f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	X7pxr1C34XBap03dXU2gDXgHN7EH5u9x7O8zoG0fhtR7s32TOR+Dg58LifWqyTwVr7KgEwx7MxTqkX27RCNufdmClreQP0dAi1qWjW04u5M7m8ieU2yv/D7ljhtQicrEmnwWJB+0JImGWVNjuhR4L6kevz4S4OzuRXXoKHW5YpZ1FtwU/QmdhxYLLwUO6+sxPOCDuvjzcdVClytw0o7DUWkruBTSbXbM+voR0BIlaDKciIyIfm79m2/h1mxjNeO+mmFGgLkYpxJI5381uDkEcxQ7WyMWXtPEt3ko0+Ah52B3JkrYTGvizd5weFQp7gypI6z5UKuG7tzj1l8zsbrt7cIb6voGSbFzOokBZ78v1c/mOpnPWsufVTCaWE00NZRJgAYZ8I79QiCGeGytqcV6dhgTi6p2RsByWsdIypciAKi0xGUk4E4c7aFhZVaYKI7fCM3LqjC4jOVP2YY21elY6ePdjsVXLw72AYJZ6EfQ649Wt+e0Xf3pbB55IGSBxJYDaUDMP4iUuRHTJZUT/7nJC/u2V63EFxlzhvxEKRsgdiRtCs1NH4NvPYK+PTT9ByrJK7GHzsaR3QbA9GihAS/Ds4cVHZ0GgrJPclDzKMaodcrWgj0MChgd61NgNeD1GBXxS0hnZ9mYBBJiprjGbQ8vbk9W4zASolOm8/RvnWKbSYx9xxSfVGgmKvlSN6G22oN9gtoqJiYOCtC/Fg01xhhIGBxKn6Jt75mpvj+d8nH7Xrg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VqYn/E0KFbb0EnpOWT+fqqUp6cT8BB0DlEO9csOv7AcUlb2ydeTwHVSq16eW?=
 =?us-ascii?Q?ByrHJ4vmC/T5SUh9T9U4EPtik4s7XHToZ2rEN2x1Tr4lAj1a3FHOhYsULepR?=
 =?us-ascii?Q?mSW3zNM8PaxDuTwZgQXeHE6NMu+vPm5L2Scx/596jLvJB6/KRSeAFQpBsY2X?=
 =?us-ascii?Q?8lZOWZbkgHOFJgb3vW6yeSH1CzDb4JSrllAJYKoaa4Rdjqlv7eJ++CP434Uw?=
 =?us-ascii?Q?LToxey7hqodnt999IwPk2W1PRsh4Te2Ov+XMaux1xSwG8YOwU7OCZUZ2uEfV?=
 =?us-ascii?Q?ld0KfRqSzHn+KauxlZPwgDzuQfUZLKHNnDWOahRwHHsIgoE/qc58++Q+zQj/?=
 =?us-ascii?Q?vIyWj9Wa7iH70Dl/7eXh69ZB9IxOqABpRR9JI0b6i+rQOYIycyZAnP6HSX+S?=
 =?us-ascii?Q?e/5kRXsIHO3AhqY6yw96dtTESgvpFrN78Sl/KfOIbNaO24vmYALl17uSyP4Q?=
 =?us-ascii?Q?KT41n2nx60ukgI8haQONG2YEyqahOZs33sICZeOEzoGhQNq8UxgdaODTUgdj?=
 =?us-ascii?Q?RADC3/GaD8KVa5s8VrfdYLIvOAPtIdcVrnA7ZnBK+TidkbvShF6h/7kGUbz7?=
 =?us-ascii?Q?vG6NPaiLmQiTHiuKunI0moqEIK5w/FnSdUOKYOIB8uPVdJba0RRMWvQrAG/9?=
 =?us-ascii?Q?OokMgWQ9obcGTJa6S3g/xroxT1SM4UKwysBSMN0FIgYFcWTLTXDNZe/Jk4r0?=
 =?us-ascii?Q?hNofgtGNfbMfZef+vJ7Jl9uI3FGMaRW8IE3tk4c6WS25pvHiRVYH/Ce6FsBu?=
 =?us-ascii?Q?pubNn9AX0jaXdunJfEWN9nk6+j780OirdyDyMok5uUUUUmlQ3xripY++gl1g?=
 =?us-ascii?Q?1n8qHK53biWT5bOExw06Nz1rL7LPpXS1FkYgZjGeNPSCVS+oDV8+8TmTZIQW?=
 =?us-ascii?Q?NI2mgXqAXqp6Gf9kg9CH6t1ZY/mf5GNQ2dIhbzqbpOKQAJ48uvYVGkqKcr8R?=
 =?us-ascii?Q?OiTqhBeFGyQyddlP44yus7cZ/to0DxC7GX93q9YGcTIQVKekm4fLuo5GEM2Y?=
 =?us-ascii?Q?9gvZGWqGinLuFIC4TF50sz0fYsd3pNOx8ZDCdkVAbpfFLsbVcaud9vOJ2iRS?=
 =?us-ascii?Q?hDHDb1qyju+azNPBpyRDLPIFI/Ilq99JXca3iJJY6ChDDe3dXhulXCh2g7RI?=
 =?us-ascii?Q?6WMFpcHrHlUkfF43oE9OQSNDEVU6b6rovs7a1qzWykH/XNT0UbLf0bTQtXf9?=
 =?us-ascii?Q?Tv2vIyUaF8rWG8m5E0drqG93tM6n8UNhQgd72i8C4a6wuiwZgRydqhqKDh5b?=
 =?us-ascii?Q?utQhbVJq0cNJUYyno0lmAgkhACbBbISFJ8CBzyBLaeNz+1lxGoR+T7zdoTr0?=
 =?us-ascii?Q?WLSeq+2VVJAb8ZzvDf44sMeYGEe+hamwbuGZjzg7AtB8gYXUPbzvgvi1vIMT?=
 =?us-ascii?Q?kxwITcDb9tbgsj5nP3KaWKuEnJ0ae+8NNLi2wmS13OUTD2T7t2xeC3Vnl7Ux?=
 =?us-ascii?Q?uCCBiWVxiitUIOh7DkeM0wRcVCWBx1BuCOQ5bwYkE972g4/mONscrvwuN5XZ?=
 =?us-ascii?Q?hbGHmOas4VR/GwSqnY9kMzcdJSa12jCmfn/UevDSyTXefbhWFNxWt8w+C53Z?=
 =?us-ascii?Q?bw8Xw5IRkaieHTjC5IH9GHserrDsa2bo9xG49RPJdbWN37t3C0PyDp+WQeH7?=
 =?us-ascii?Q?/9Ic16y96pm5RKcdoTarzQdra4q/mffSIY6XIc70IFepuUIlrTRiXZHIcB5N?=
 =?us-ascii?Q?aU9am/R6DBF6v1jKJqYYgvx703yGuG8p43OgfzlvshMPFO+bBH1W3ZDmsUgs?=
 =?us-ascii?Q?eWsjXfvCHA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e638fbec-26b9-4b90-137a-08de9f0a633f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 18:26:49.9130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdonnNtkVlvfFYgsi+qziTt//lF7Be3/apNC9pX/FvH3FyvusgUHhzvPONEj3+f1ENappcaHaeWhnRowoLdweQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279896-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,mellanox.com,kernel.org,davemloft.net,google.com,redhat.com,resnulli.us,gmail.com,lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,lzu.edu.cn:email]
X-Rspamd-Queue-Id: D2890432EF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 02:32:08PM +0300, Ido Schimmel wrote:
> On Sun, Apr 19, 2026 at 10:53:32PM +0800, Ren Wei wrote:
> > From: Haoze Xie <royenheart@gmail.com>
> > 
> > Several l3mdev slave-side helpers resolve an upper device and then use
> > l3mdev_ops without first proving that the resolved device is still a
> > valid L3 master.
> > 
> > During slave transition, an RCU reader can transiently observe an upper
> > that is not an L3 master. Guard the affected slave-resolved paths by
> > requiring the resolved upper to still be an L3 master before using
> > l3mdev_ops, while keeping existing L3 RX handler providers intact.
> > 
> > Fixes: fdeea7be88b1 ("net: vrf: Set slave's private flag before linking")
> > Cc: stable@kernel.org
> > Reported-by: Yifan Wu <yifanwucs@gmail.com>
> > Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> > Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> > Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> > Suggested-by: Xin Liu <bird@lzu.edu.cn>
> > Tested-by: Haoze Xie <royenheart@gmail.com>
> > Signed-off-by: Haoze Xie <royenheart@gmail.com>
> > Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
> 
> I think it's fine for net:
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thought about this again. I would like to check another approach
(synchronize_net() after clearing IFF_L3MDEV_SLAVE). Will update
tomorrow.

