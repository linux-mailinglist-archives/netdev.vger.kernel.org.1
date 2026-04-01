Return-Path: <netdev+bounces-273946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK6uDq7LzGlFWwYAu9opvQ
	(envelope-from <netdev+bounces-273946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:39:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCBC376155
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1C5E30923FE
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DD2386C1F;
	Wed,  1 Apr 2026 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GHweqXp0"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5B2319852;
	Wed,  1 Apr 2026 07:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028450; cv=fail; b=JYlSWB6Tl96P7Uki1Uo8eolkoVmNX0SdvBddFXQwHheKPsuRKol3PZXmZKr8M2ttlu+pKG/OOI0oCqgfwZ2JRAa63t03PQBiqTZvwABSIiBOhPNnm0gJDbP/l2H7/dMqFKhIZudDCKzYBhW9e/7OQ7IjEiBIybzVUyjph8PsXEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028450; c=relaxed/simple;
	bh=Uf2PiaSOK5UgZtX1L+Z0HLCF4Ko7iE27L1OS3yQTILY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GHB/InyeP4xNQbjzV19arpdS9raUIHzjMrsqyKliXVAankJkjU7BOiOlrxDlFf5WRMuic6N0SijEgUognObMIB7RKF3mpydg2ew3C/E4O8cdOk6NpPVQPNwMaippgd41YX6bql8kT+JjJUZ6W0wo7cf8inNfX3wp3xqwtPan1S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GHweqXp0; arc=fail smtp.client-ip=52.101.57.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Px2tu9NfQzr3au+y9ToOx/jTZhJ/D+7ksGZWzdo6q/3jyLfhRKVNLahmdPOTSfYG1DcPPG//QgeUujEJ3Z8iOYDt/VyX5NBqJsx9REkOpxL12iOppLC8xmQyYP6l5MnmNdALCe1T9nUUWeMCnJZej3m5fojTdNaQLt2aNFxdxbRQz30tCzFJvgsA5xKqWnASrgA0hsmqpR08azXzzQC8Opl0j2gztCteV1JBlJ4pb9iboAV1ukPLGbFC0rCRYuvFVCPfUr6prt7tIQswNmVNv9A6iLQCh9GuJjJa0w5jwPaWh0H2pUwZ5XUbrAjUP3nkCvsdMsxJzkg59H1FMzilBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPi/Y3wou8BzWVv52qYYjX5oXIinXhrHBSE0l1zSAFA=;
 b=hlQ4+FX3Ajue0/RDAeFKZjcUAdzvBjM/BMsco6zTVTYWfLEPvWZRRW0vqRDR9ZxQS8f/FhXkKnQpyY+qni4sAB6Yx+uTuLvgpOM5TgJyWmkYF3ENoaGdxOrGopj795oxODVlIGbP1PnZ2EeyYv+EfCEP8622a1QKH10wh6t/l5uflPAhSENcY2i1OJd8dnCFDAeJ2gJVdhDskSvKfTxDLNABSget96zWLYeyPFKVqe3Ov+6EqRcggoTOkNLIhqhaUgvEc2nC/h5ejeoGNrcz1+jRHaJRxFyMjrCUZzmZ871NE1oMzkT40n8qj6swCDsgiFs9So9+opPq/wYv1x6e1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPi/Y3wou8BzWVv52qYYjX5oXIinXhrHBSE0l1zSAFA=;
 b=GHweqXp0fGHIZLlcsITPOdgs9Z5isICj+XKniDfLUNhhCeXRF3mzUMJvQ78oMgKOdCdahysEJZMKJ8jwf102LFNswgSDOXfdmnulFhzkD9vCrgSH4kjQk2DLg/wgCT7w/pv9EOGM2hkUSxfOJkIX3cPq67Rq9q+OVcB9UdNhJb3areiHwut8g2iAbAN1juGP/qhYgn93vNydtVPYQe/rtvTEp9ycGncV4xHBWvdCx4x8bwSyrIFCpypTSySvNVhM2Y5U3s82bLaBcMb79q+MAPRz/3CuFS3PNZK3su3MpI8tvXUSC05zKsv5eN7Ry4NoLHgOGfe+z/plDHEllsZRrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 07:27:21 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 07:27:20 +0000
Date: Wed, 1 Apr 2026 10:27:11 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ujjal Roy <royujjal@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/5] ipv4: igmp: encode multicast exponential
 fields
Message-ID: <20260401072711.GC1725933@shredder>
References: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
 <20260330191611.16929-1-royujjal@gmail.com>
 <20260330191611.16929-4-royujjal@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330191611.16929-4-royujjal@gmail.com>
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: b29f624f-47e5-47f2-fbf4-08de8fc01c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ylq3Q98n6I6a/7ZilQfitiLrYYLwF+UwNzU+/jP5B2B3Co5ifqXpvrPzZ2toHhOTrTR6u6MWIktURYCm7Sz4AcKQcQmsqckaQ/BguobsxWDzl6qCJuffcZYQiJkrDBY2GjXBcjE3K/FZvaZqrzbqrGGUrsDBQzL/Ej0WRIr/IRM+rMD9SM4Q7KLrD5ajWcPMuydQ3nEspbcR5p9uCzQPqnlUmuJ04BDM/J88bNyud+yoY3RHUlIORmyvHntOYGt88t+YfXlvwbluuIj1Uqfj9VwD/2RrkG5rNcMCVeivew3AtiMbJ/jLaraBr/U6BROObQjL71BO9JT6aTO59PgdR2er+4dUKFKYr7bUOxtGdvx/GQqT+lY//Xgf9jV5eUOH9nNyVAX+DgWiKrBpHe0Oel5ZIU/SXaKme+MYwL6wvasiyacdi743twvm9okH89ZkMvtK+qzLZc6zrQJ1zfjFfGXeEKhsIc4n7/xQwyz01JaPGczg9NfzX0PVXEPEyGvyKrNsy6tX87PJQVGmDhldT9AK/i37vvCm0QcHGtabMV0qrOQTjVz1UxxKGTiJCkS97FXcTRCq8Bk4gRkPTMXNDD25xaDdqku7K8Ki0w+kbW8MFgqVT7laDlXacw3z6PTYlKZCfnhrAwhyLlaEGpK1Ze1cM0WZ6vYVbmOzi7U3iyFfKr7XQ6M+42uX/cmMKZzLf57aajvzJnF7kfOi6TcrZAVq+E2F7bME1B4LaY5Eks8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tvkiMt6lyZhvpvZSgpK/zXcvZk/d2kp/JESCLHJibY9z/MjGJA3rtvhA/KtJ?=
 =?us-ascii?Q?6ESNrPtdV+7mpffI/v983Zn9uqkiAfhCs+8/QozqhaQzLqEzeMrhx/k4p3hN?=
 =?us-ascii?Q?4Bf890L6l9f+Hu4Sm6XFCGvVLJNN/0KvDQSQK7Yy997euHd+/jsygxHU28me?=
 =?us-ascii?Q?KtMm/H0w5KZvvqewSWFgddfUFbvQ5Ku9C5VIrpqAdNcaEnncJSNKt/j5smTB?=
 =?us-ascii?Q?GUCKIED6CKzyM4PoeMEqSk6gdnbBzC5Cv+4AAsQCCk/TCHLZUwS94ixGsndV?=
 =?us-ascii?Q?gFGzbWvajVxnwRPxJZTS28LQMgzbiJ5uCzR9Uw+kqFKx9z7J0ZbEtpClM883?=
 =?us-ascii?Q?KQpEhB5ySSUId4z+75C3h8Rcs6aVx+ztTYsV1aGgPvYLkY2n+icirSTk8xci?=
 =?us-ascii?Q?83uQLQPSsDT6eki8Y4Uj+qgjqoqQTuf1VebZ7IqjrZaT+d5uEQMvw3zRPiX+?=
 =?us-ascii?Q?/izyq9mc+7n7i9OZyagfjI8owUYD+aUmTwjQ+v3r+L62VpOnllAwGApnSYyY?=
 =?us-ascii?Q?yhZMwT/89ciVxDa0wn7XorGgNvdlJ8CXVifkG1R1anZHZ3SIS4cRqchxfl0H?=
 =?us-ascii?Q?VeR+syvWV8JtjuN0Zmd4lTcEaEs0b5dyeyNGcV/LiRknagfVg9KzPc9dKBhA?=
 =?us-ascii?Q?WSQ6Xh9QmF2bbDq9WYSmFgwHPnlSNGE7kL8SB3Ldskz7aSew9BPeOpSMKRl/?=
 =?us-ascii?Q?slx+y50H79Mo1zZYHybaWqsvsb6YHTXZd+m4pQk4yDByPy/DyQJeczqxaYOL?=
 =?us-ascii?Q?+3dDpPmduOe/tx5rUJ9Yu10hABbNw7vmPYTMtw1Qhsm0vTJgvn4BNSwfsTfT?=
 =?us-ascii?Q?EySgKwdgHiEJF3QxVZhCw+mxuJ55bPlagSmx3OYkqqoc/GuOVA5mc10ZTKw/?=
 =?us-ascii?Q?KoRq8NLj3UJxitaaBkbo2QW009LzbRyisgotu1w/Pht7LapfIcM5FPFzr8Yr?=
 =?us-ascii?Q?N9K+8jUlpJD2vXjvV6iRK1oNCauGqf3JpbqRG1o2Oex55TxoiBSHJ9hXE0P1?=
 =?us-ascii?Q?aqAwdqZh56gxyLdfBiI5kY4dDKpisQoTQsiD29U7F7GCphTkA/Xgaa/LVgBo?=
 =?us-ascii?Q?Mje9WhPHoCNzNXCWZzpvkv79RXrPcx2d2n46s6b6xwyHxapD1Js2XLCiwhjU?=
 =?us-ascii?Q?qEQJL4xERbrKYmErJyUeraj46ks+yIidvjKjg6B6y/q76okYPPKDLlNAT3bP?=
 =?us-ascii?Q?nJZtRTH7oEkC7sF/XhVFPK8AfYZ1M/u/2bazU7BheXTlQbswsFQyCovRuqOO?=
 =?us-ascii?Q?cT2FVrUeHf8c9lh6OfClKulKinCw9V7n1fVwcS8gehgN+uMjHL0dlbX4bv9m?=
 =?us-ascii?Q?avYJIErcchwMPOb6EfBuWY2b+R9r1w1kD27qm9QWzpAOjr4L6v69Lq+hmYkt?=
 =?us-ascii?Q?sGcmLkHdFY0SEIuEUFfXGxpDmTPXXAI85/X7JoO0QidMOUwrbLGCS6X7wmYR?=
 =?us-ascii?Q?btKmHrmPVn1W9PHu7MXHl9poDhWncXFWBCT+ddHQJdihgP0zOXuRy39/uEJ4?=
 =?us-ascii?Q?lYP+9vGfPw/pfi1RP6kDUwYp4GZznSPH8PJk4DRv+S+8SnftT11jbnpSgfHz?=
 =?us-ascii?Q?jCkX0V0UwkJari/Qpq2igN0wGpw0ESgMyGMSKDhIc6EaDHYy3+gLPKKhq+tg?=
 =?us-ascii?Q?DyM2VGmRbwVU82Gpla9A+R/14dOCuGuU0IBFHFqATfTptDAITh/J3cLOnPiI?=
 =?us-ascii?Q?D77+VbfeZkhmsosh1gQ7oB/y3YNYOiVyiTi0ry/jgWSSnD/uhWwWXScSBhpN?=
 =?us-ascii?Q?HpzdmGjp/Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b29f624f-47e5-47f2-fbf4-08de8fc01c59
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 07:27:20.6909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtekSVArhmpsPZ7XnAfJUrWXDwTwgl5pxJ9WUDRj99zdQMjyi4r90rzKefix/meOo4ynjn0yZmPyXLYCduTKog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273946-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FCBC376155
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 07:16:09PM +0000, Ujjal Roy wrote:
> In IGMP, QQIC and MRC fields are not currently encoded

s/currently/correctly/ ?

> when generating query packets. Since the receiver of the
> query interprets these fields using the IGMPv3 floating-
> point decoding logic, any raw interval value that exceeds
> the linear threshold is currently parsed incorrectly as
> an exponential value, leading to an incorrect interval
> calculation.
> 
> Encode and assign the corresponding protocol fields during
> query generation. Introduce the logic to dynamically
> calculate the exponent and mantissa using bit-scan (fls).
> This ensures QQIC and MRC fields (8-bit) are properly
> encoded when transmitting query packets with intervals
> that exceed their respective linear threshold value of
> 128 (for QQI/MRT).
> 
> RFC 3376: if QQIC/MRC >= 128, the QQIC/MRC field represents
> a floating-point value as follows:
>      0 1 2 3 4 5 6 7
>     +-+-+-+-+-+-+-+-+
>     |1| exp | mant  |
>     +-+-+-+-+-+-+-+-+
> 
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>

[...]

> +static inline u8 igmpv3_exp_field_encode(unsigned long value)
> +{
> +	u8 mc_exp, mc_man;
> +
> +	/* RFC3376: QQIC/MRC < 128 is literal */
> +	if (value < IGMPV3_EXP_MIN_THRESHOLD)
> +		return (u8)value;

return value;

> +
> +	/* Saturate at max representable (mant = 0xF, exp = 7) -> 31744 */
> +	if (value >= IGMPV3_EXP_MAX_THRESHOLD)
> +		return 0xFF;
> +
> +	mc_exp  = (u8)(fls(value) - 8);
> +	mc_man = (u8)((value >> (mc_exp + 3)) & 0x0F);

Drop the casts?

Same in other places throughout the patchset.

> +
> +	return 0x80 | (mc_exp << 4) | mc_man;
> +}

