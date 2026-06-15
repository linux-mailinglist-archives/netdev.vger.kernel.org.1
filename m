Return-Path: <netdev+bounces-299350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p1CdDy6rL2pPEQUAu9opvQ
	(envelope-from <netdev+bounces-299350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:35:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD226843C4
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:35:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=NdWPXjhr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299350-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299350-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A49530078F0
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 07:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFA93BBFDE;
	Mon, 15 Jun 2026 07:32:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011006.outbound.protection.outlook.com [40.93.194.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA663B2FCE
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 07:32:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781508736; cv=fail; b=I8gQ0rJ4lib5l1wK8Q3oTjuT6HRD48/EOKLYDFBII01NBWhZvTDmXHKOGUXDUDa/R8m3UFF5dDZThm8YBBqE9DtffBto0//z+AZJ9KnFXqWAuHwL0d8c4HXGVAuZDvkRdG8L/AwZJyv7HlWvjFjUf2DRmWTFRp94qeZNSnvS8Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781508736; c=relaxed/simple;
	bh=NS9cECxMUxKCLpeFKb9KSon4/ERmgP6Ao2GHFO/UOWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AYkmpy/aj59a5EnJxX6E3ITq2v2bnosbCgvalMwghyTio+7j8XkuOkVzOQK/wWKFiMnTxfzERxh2UHLM+qu07Eo1HXBVwP4O64JWJhSFpQlbhdP27xVAf+LaX+FGDYL/lH8s3o9PPuDdrQdiLXCiu9JAzk1K3I9Q1hOmlb6smJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NdWPXjhr; arc=fail smtp.client-ip=40.93.194.6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvBiIKlI1X4Qu5nQt1/6fT7rWur0VRv142Yl9q97A8dPey6nRNrrKk5gZ6lGdW0GUeXBBchfD0WIlmxVZNjnWGV1SzyD2W3HNYlpPuk6C0um2mvMIByDkezhWVWbASm8HosQZkW1WhcNOx64KS/9cMUoNDwxXuSwql3Zj4mBvVy4tXqGjYiRAwXZFL0Nj5A7UN9JlDlPiVN0QgcceaDtrmXM+P36jiNIgx++Y+l5GF2gqRc9FCkkyCNIdD36qUMSEBgUNkHB8am3A15BfG2usI8D8stbr+bnRyNrHwnSHiM45ue37Qi0JBG5QJYO5thsbbqTI9mXnQ/8gtrS0Pducg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmUGvP6lhBRTapQ+1WOhIOT+MfxoJ7o8pDm0CQkKHtk=;
 b=JLzjkEt3gG34EO0aYCe+5W2KTEe5fphmOzY3VFMi41v1q9dP6kG3n9lEknVQ8Rpdkyr5dTYdTmO7k3H9OTh4jK5yXbgMVmPpAFg3i/QbnCpTkTp7wFJQqwa3mEY0xlNl3NwmXvMRGfz09ZiA4uqBrKqK5uSHvVA4ROJKn1JkAcVzW13LDxhHPqkQ9x2cUMty3VcJFJAf6vN2B7KNcCtZ+muJlTSet4O9/PTVBsK/0ikVmMngK57b34KipDE7wYuvHv5MbYGM6bilsHVQuHGvb2WBMb/hB4ozsbjxGbUcML3S8B+O0/UP0R4Vefv7h/YNxeUSwrrhfvlAcrsvEZhlkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmUGvP6lhBRTapQ+1WOhIOT+MfxoJ7o8pDm0CQkKHtk=;
 b=NdWPXjhr8SgeWuwcPS+pDjzNATdTMfXUyFq5V739wVfGP6wk1pn7/8hK0drK2tLAq/7jUspFpm862DaaKIla6GOfMAD8nvAMSZNo3adMAJtt0QZ1syIiWtazsAfL0SZfW1IG68di6MoIxXZwxA/rgcqv243AE5k0msp896rPIP26XWFC286ejfG3rQBfzyvcBGi39y/I/EfX3iHX8/AxHrx9CBcLEmRRIzaGpICxZ9Cg4YHc+L77kuDPW4GuOug5lvsrb+Rnxg8m3dHKnKvt4VDeN2Ni2pT/J+Y4jubPZmdBB2v1YA5I37i1G1DO/rphddstOUiE//3mw4zXzKnOCg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 07:32:11 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0113.014; Mon, 15 Jun 2026
 07:32:11 +0000
Date: Mon, 15 Jun 2026 10:32:02 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Wongi Lee <qw3rtyp0@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, asml.silence@gmail.com,
	dhowells@redhat.com, willemb@google.com,
	Jungwoo Lee <jwlee2217@gmail.com>
Subject: Re: [PATCH net v3 1/2] ipv4: account for fraggap on the paged
 allocation path
Message-ID: <20260615073202.GB338677@shredder>
References: <aiq3f7UZGFp0F3MV@DESKTOP-19IMU7U.localdomain>
 <aiq491nYg2Qf/f1N@DESKTOP-19IMU7U.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiq491nYg2Qf/f1N@DESKTOP-19IMU7U.localdomain>
X-ClientProxiedBy: FR4P281CA0363.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6db602-dc47-4f1f-fcfe-08decab036a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lPq0nDUoaG3gLZhxpZBtMDeV8k98pbdcBx/A3U7xCjHc0JMj2Vnofu58hgxtZ1xjHW9+IAPuHpRH7aTTEiOY7Kas/SnEQNfW4RjXurW+9A4ueHQLmdcgScSGVfgsT20PI9lNFr8hIwttPlf28Osx7+jRJTOQBgemhgdOsherWdaQp6Yr2cAFrxEfcuCHZeOZRDDuVRb7qAlpTrGXeJezq0Ouam8MXjS05KigOrAA2YK+TbpYnCHAV5ZYV07R5M//VFStYDCCRQZyN3NcpZZb8kUPZFt3FbtjUQ8gCQQjZpJKrg2DYjsFAZANnyhWrS4QrN7T9cJ5SU8c1CXoNS8WIMGrYas0HTHvZbJDy1GAIRJcAmI5WligYV+PBw6871OJ8BU0+TxiQA0irMVG6iaJDpP47aiQ0bWYs2RzVa39wj8GnOJ9XmKI9kFBm6kHpfYVw9nxDqLpu7PwsVrAxLk/qc4c1XcEEEpZY1Wh1rGGkc7TUC6Y39ej06n0heLd7IzBUrJiLN2+9ysj//DnPaATSCsJcW7x5Cd3MqtHvSHwqiz06g2SniOKYPvPumTBQCgOMl6j9StWKtaediOXPPZPhbDgCpoQncSZQWbZdnJ/ZDBBMPCGJJ0BHogdQzzLZsMKPNQNqoIWCjPB/0mYGUiNGr8ekGf5mU6VVz22BQtqxbM/nrJNwToERdcnB+QcJckl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FChT4Ld52p4RgYZvHw4PVlUpsY1L3bIIr+dfXGTLIXk3ikhtXolfdcTRkPT2?=
 =?us-ascii?Q?75/KOFrCsUHQKMlKOoto+uZTjWvLriyTHHFYzKPiRqwpW9EV4Uk6d1OQw9j1?=
 =?us-ascii?Q?Qb1hnIHw3bFbaRlJh4GdpRfghQuci+6pthzgs78+Xn1/EA3pdFUjJLVglEnp?=
 =?us-ascii?Q?idyovrSOTC/3p1wFzb2U+aer+kCjoNg9qttQeAOY0E50lk+jFXgEpCKivet8?=
 =?us-ascii?Q?LDhA4nhVoWAHvZ77eYr4TvFonhLs342u8ww8hK9cGvHkoaYgv0tjz+Wqo0Ir?=
 =?us-ascii?Q?DO8V1n64LFLzT9YhGr318FqhOGwzZubAo2pVFdfbkuyNdgJrU/QAc1xHFrPz?=
 =?us-ascii?Q?f76CqUwncAvhHK+wyFhALeRaV3mrg/bmP5vbOyQXokkRZfg4UjMOKNYlTVwy?=
 =?us-ascii?Q?zbt6Z8ck/PfuTJJw/YlrAd0DTw6WR5892080sOflI7hhaq30e56FiK0f4bfG?=
 =?us-ascii?Q?LeLhsyouswB8m5H4Z+gB0SwF63ZiH/6kdSSw+hu9SmU3sdqzPYQv8gqzvLAO?=
 =?us-ascii?Q?vcfxes5G7a8cpVqYqY9CznbisKD3juXz2tJLDuXEahtdgGUC4o2f+08CdM0x?=
 =?us-ascii?Q?I5tBcLq6l0wMLo2tfalV6d8xSEpY31ldSzl78UqdzY5aXI0T/2ay4Pm/oVTm?=
 =?us-ascii?Q?Q12qFVkGxtvkm5T4eBm2afF0fec0MfvoDHZ7w0zi0n+QInGaFRlTTzyEWHLJ?=
 =?us-ascii?Q?O1zYV+WlNaF9Vg5rY4cNo5TfAo56Lit+mVD0rcEl59n890qILBGg1qbLOv9+?=
 =?us-ascii?Q?D6GpBuAj+YQ3Uf8hl8teIzBL8LyvtEjrLQEDK37lODmrLVM5gW2eUYZSqyRj?=
 =?us-ascii?Q?PDrwwwNSSJ106i9Xozbm7h2mLIS7MyS7J84E45pvFg03DmTwzceRpShKGDxs?=
 =?us-ascii?Q?/lWB17iSLcYTTiaWfgLh4RtwoV/ksC98t7yO5cYH8s1TiU20qcB6253TjftX?=
 =?us-ascii?Q?TSfg1SJ5bDyy/ijLoYiutszPM2ijgT0lblG+pCWftSXgoTJZcLkVj+JyMRDY?=
 =?us-ascii?Q?T1Rct4AkMSermvTpQFhz13BKn4+W5SzKDqBC0CeUf8SKXPPDg+CyY66pciej?=
 =?us-ascii?Q?TZM5pI+Cqgfcent1L4A2xWMnQuesBvZOv1FAiwbvnpk8jPunjSH445SyTZke?=
 =?us-ascii?Q?+XQt8IpTHm2UYIA4fYknJxVnucMUKybN6mTymEReihXMVjOi0EU1e1nlXSbl?=
 =?us-ascii?Q?kbOxxYSIKumj7Tg5gGxCSacIXty+e6s7VeU0JLHCnsLuL0Gf11ON4kKCvF+P?=
 =?us-ascii?Q?PnSzM/2vmcJd0JNgovwDG135EecuPoftPePgsT8zvU8n/FvMwFIdjEGyvwo/?=
 =?us-ascii?Q?hlkv7KcE6tdAczfwr5qZJikJVa9P90tkZuOtuyfI8Fh8Dw5kKfypdLCgxu8a?=
 =?us-ascii?Q?SvpRi0ETIl8fl0Y6b+fYKuy+h4wAbFTpLwO/quLl0Um34L25l8u7pWjwGO7i?=
 =?us-ascii?Q?1VDjn8Q5wPMul5KeXqsTsOY9BoXtCyxZ71NL5tR3QDES7BHhIxGQmN6w/gUO?=
 =?us-ascii?Q?yiruqxYBxYkbAzDIwiU4wDmeYapsl+aMW+ISt+ewVISlxIsXUKW2ByYfpleK?=
 =?us-ascii?Q?tBNuMIbcu/e85Dtrncc00kugi4AjzK1DoTqatY5V1lrjoxcfMMZvRRxQPANH?=
 =?us-ascii?Q?330oEeQYW/fRPhM5I1jQJUvoXp7RT5v2uWE5mZrqLXPKf3p0+TW7lLgpSC23?=
 =?us-ascii?Q?mgBl6G5XqvgQjOl1Vzdsu/+zha2FnZd5u7nAdZCmzTa2a35W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6db602-dc47-4f1f-fcfe-08decab036a6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 07:32:11.5808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pBvtmJjIBMxrICk5N3sLTaoMRw9VYtBWBNQF9P0vNjKlUnPM+YpWyBv3D6y/sA2tsWfx9ItgagzfQ+LDGN39Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299350-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:qw3rtyp0@gmail.com,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:asml.silence@gmail.com,m:dhowells@redhat.com,m:willemb@google.com,m:jwlee2217@gmail.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,google.com,redhat.com,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,shredder:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:from_mime,nvidia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8CD226843C4

On Thu, Jun 11, 2026 at 10:32:39PM +0900, Wongi Lee wrote:
> In __ip_append_data(), when the paged-allocation branch is taken,
> alloclen and pagedlen are computed as
> 
> 	alloclen = fragheaderlen + transhdrlen;
> 	pagedlen = datalen - transhdrlen;
> 
> datalen already includes fraggap, but the fraggap bytes carried over
> from the previous skb are copied into the new skb's linear area at
> offset transhdrlen by the subsequent skb_copy_and_csum_bits(). The
> linear area is therefore undersized by fraggap bytes while pagedlen is
> overstated by the same amount.
> 
> The non-paged branch sets alloclen to fraglen, which already accounts
> for fraggap because datalen does. Bring the paged branch in line by
> adding fraggap to alloclen and subtracting it from pagedlen.
> 
> After this adjustment, copy no longer collapses to -fraggap on the
> paged path, so remove the stale comment describing that old arithmetic.
> 
> Fixes: 8eb77cc73977 ("ipv4: avoid partial copy for zc")
> Signed-off-by: Jungwoo Lee <jwlee2217@gmail.com>
> Signed-off-by: Wongi Lee <qw3rtyp0@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

