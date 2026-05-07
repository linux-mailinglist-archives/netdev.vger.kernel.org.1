Return-Path: <netdev+bounces-285444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JXeKDTM/GlhTwAAu9opvQ
	(envelope-from <netdev+bounces-285444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:30:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BE34ECE64
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ED31301C169
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 17:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1128F3128C6;
	Thu,  7 May 2026 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qrjcbc+y"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013029.outbound.protection.outlook.com [40.93.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32C640DFD6;
	Thu,  7 May 2026 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175026; cv=fail; b=Rmg8J0oTZKITZIj6Klrmj48YipSxsLVRiOaArobQmrjVIlMM+UNkQzuZAQT5PdYff7I1wTdZphBFXYZ4lSHnZ0dTUmScW4bC8ayIXAw8/B/OQqYiQMlKLvbZSyC90pxPD9xeDnyQvx3kHvkOVszBnZ2TLAIMODZaiW9Tns4NbZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175026; c=relaxed/simple;
	bh=kE7y/XEc4Lq/pL56FX/49oSXU1+KcW+CTIkDpm8xQSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QOvlCn7l8gbG3Gg4++bgM3fs6nXe5/DMXBgJU+v6X6M/09L9pzLpcLAA10BFZKe91s4l+Rezv/88roq+o1xLvnahm9JuembF2RFEBJ/KRH2vnZsV+XntDz23jAjq+dUOrsAqGFYR4+/c5JKOmzkE72VH+Ey2r2mGtLfku+KoJ7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qrjcbc+y; arc=fail smtp.client-ip=40.93.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwFLAzSg16eYCvprCekHu+/ICcCpDfG00ER5n75tVBVe/NUobN5hs+m6FtFfj90SCP/YwxlxDiXcmGO9X7AtHOgnPu/z5la/Heb3Lwh+w7RwAWJRQYAirW2sssod/kANsqUiKRozsabXXjC0/KtnKNFM05B/Ho45go3xzSwuLONMG/P2UWFPGGOCnnHZqkZCLA9ucVJtofb+TJgVVOig7/XWWoYzdqhzagmbNLO1i+xI7u3HY0xCLdy+eyc5YLatyyd9vJrKBKyEkzylNGkuV8ThIpIjinNLDmD47kOo8PgX7g5YhtKPsDQhKznFW4+ZEMiST46wUvgTuueSDMfAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ySKPx6e3I7u6sxx1W5fyRFMTdkhMT8lIomffJJ//tQ=;
 b=cfbrX23NJWADZ3S2ocyxk91Lkb1df94F2MWVSUaFHg2m0EXmya9t58O42oIMjlbfa0XrqcZPGWyJuLA+/dIMjQOsb1X2idCAz4svzqauWyXGIQM9Gq/C8qxeNCNIvfgwQsbmSxbv2oUhaILSrAXzXRqk+Gv1TU9x+whSbbsXB99KGp19S+xWuhwc/JlATlazeRGmJu1ZKlKe0io0Tu7zOI5eD/XIj1KTiHz1CYaK8xw89iUEh7qq18aULZWs7nK6DKAIykGx8l8RZaAPi7WRdPqMzXgtEH49O/T65ZtaV1sEvKdHjsnZTYpcyk+o71WJ3LqA7cDJyJGnzFZX5hXSaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ySKPx6e3I7u6sxx1W5fyRFMTdkhMT8lIomffJJ//tQ=;
 b=qrjcbc+yErXrGry25qywYDdiY7E/lDARfi761HPe+hFexADLP73IfTj8CJJONd+ZkdUvaTPTHzBkXSPRZjQWDRHBme867I2evsBw1lAnMh6HWdBjqSJE7QXLws0Ow4y14MtNZ1TaAPjLjKvdqwoNRU+4yuk7JtWq3YETp3SnuJ/hLHtOrAn356+lmtUZq7ViKVri7Kwc4SCrd6B7hcNNMmVc+htR/UQV860ZEmEcUWXQv3Vw5QxtZYgf13/I84+zbKoPQzNlncR//qge/qPm3mwf95ESNWJGJODpUjR/DyV0Os6drns6J1rfs6wV+HwzqyP2WJlUw8mcp8vyjVRlPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Thu, 7 May
 2026 17:30:20 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 17:30:20 +0000
Date: Thu, 7 May 2026 20:30:10 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: syzbot <syzbot+ae231e0552fa77b26ea1@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	syzkaller-bugs@googlegroups.com, bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Subject: Re: [syzbot] [kernel?] WARNING: ODEBUG bug in smpboot_thread_fn
Message-ID: <20260507173010.GA977556@shredder>
References: <69f88fc0.050a0220.3460d5.0004.GAE@google.com>
 <87qznowlfs.ffs@tglx>
 <87bjerwqan.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjerwqan.ffs@tglx>
X-ClientProxiedBy: FR4P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::7) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a634c21-1b53-4c85-da9c-08deac5e4fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zeEXCMXT7IBiVuvCD8Ij0cHOhfrgqZBe8lCf93jqxVmCaK4w2E7njzje32nw++3rqwJ83wp2jQFq3RExVxLNvF0Rp2Q3OSZJDaZqd2tGH1sZOz2Kf3MN7OAlNtd4gmwpC0k+47E/9i17uBbB134kaIHxCzMLOH8BD7CxCPhh8yUTqm1jmOvScEhvbkS5gH7wBv1YnX0QpD+Zlewwz4x3ydWljmUb9/4fgxjMph2Jm9hR8v4PvHrMXDP2nY6j+01UvrBV0HMqeYEW5mdAlW7uQVh1dU0tqqcSfpekhWgENczBSZhi+Xyrf5xqGFDs4pgXkmLDFSTrcsdVs8F2O84O9dsm1XxNjptIeKCsrEH+tU7mfVR9CirRhb2GtSGRHtXEbz5P8e4rccrqVPF7DOekK0qQEIW13wUgdzTP6JfPr2VjUNsHBBtp/y5SsYYLq73fEyVLCgmjeUdf56goa2uAuWJDOWXyCar/MRfVTFu1ZKaZLBT6IX9KsCoX+qJ/rTxPy7OB1pwISwvbT3vPycZdQ7FqWED5Wx9SDOJwWWpNQYXA+rFLzC5DSEIb+MjdVv1JqYEUOQvI0tLwETcntNOSsT7A3vxY5wJUQhYB2c4W0lNni9qOJ8paSEekJhFbAymjSsa2P8MO3ZrpUC8efRQ5dAG4yWNAk5YJf4VGZsWYR0SXIC3omV5ltcOrD+4Akxna
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ntuOlsTGJGU+oShH4yzUO3YALroJ2B+Wfc3kzvUtkO4dQ6hmp3OpTb2OYO0?=
 =?us-ascii?Q?fDEn7ruWkyUNliUPtqIEoW54fUAmimEbIgvTOQYdZhdqi/cod8I3UkPVMoTm?=
 =?us-ascii?Q?aZfsaC1Sf3AHzd/opM0+QaZtWUzdEgNBioRduwUoRFTSXDzPf3JgyqcUj6qX?=
 =?us-ascii?Q?F7Yz3vqfdFPzFtjAjqrjN2Jmc4Hj2+EfWjlwi96UGaDuX6u7QVL+Pzqz81OH?=
 =?us-ascii?Q?dxFNk5Gz8ZFM+qejql39NdADJM2tHu17Gaj8o+r/iJ+C7wTPwqUeCFcRe40W?=
 =?us-ascii?Q?KVn4JhDGPAMBdrcmDwHqqrUtTzAbwA+StWd7QbLKw97Ks5JJQvsjNUxJksPy?=
 =?us-ascii?Q?npkmpFdaBRIXHO7xHLBEQHBOKlRYsGOVOCT68h5/T/LUR3lcRv3r0KbmtDja?=
 =?us-ascii?Q?jbKTL7Atb4KAIZjF5LaPbmkIkXV0w+YXZ9IHsaSHHoKHYLZwchGo1WpEmU8z?=
 =?us-ascii?Q?4bPmcMRrdxmXyr7UIWRw9cVBcolWYplepwxcHe1fz4zdlWtix6FPd1qpdFfQ?=
 =?us-ascii?Q?oDZXDkG41BVP8wHEULl3uxh3bJhqNYXVw8kvU5keMSxcH1K/0140zUmdBGlr?=
 =?us-ascii?Q?DT2wFkRnN5FZ+6JDKqg10LG7WzfKZaBgFJNpUJN00ZF0lLtvNp4Q9mqSP6KX?=
 =?us-ascii?Q?Iu5exWULTmC4WB0lGMeNkNUNgsZYtbT3I7vnLVK4ACEb44q3lu56ZVUMeed3?=
 =?us-ascii?Q?8qzCVzR68coJaB7LI9cwGKayZS1RrN70SEDd6DnJ9hwJwkfU6BEeS7i8738i?=
 =?us-ascii?Q?Q+xPNrWu+DFYwTXZ4eWgarMr5TVWAT5yxbvN3+m2LIh+A4Kh0hqYw+rKh+g4?=
 =?us-ascii?Q?sF5ikBZe1aml8TI72hJ1wsRkXLedZva/NOnZ7ipo1Ohe+mN5OypHTNNoLHqY?=
 =?us-ascii?Q?n4VI+RYR0PmoYYANLCE1x0GQmieSVkECVF4ituQvZsZaKs4I/sKUa0muXGUY?=
 =?us-ascii?Q?cYs5dmPBDKOaqgxmUkOhbosMKJ78mDWL3CGeKz/BCJeTblFOPlXRJkGQ8CMh?=
 =?us-ascii?Q?nBtI8RKN3NC73ntXRhsDCVSDmtv5ixelF27H3SLFbu10HkN2P5KXL0ALK24P?=
 =?us-ascii?Q?lm0g5BCvsjhLRWf4W2UYW9GMBwscZnqeCxvDlwEMQ/zNzvTWdimqB9gscK75?=
 =?us-ascii?Q?5yVljZGkCy1Jnt7i+QJHufrgoczoGJNYWyGpf9sjMrJNMhrso60oGf7qXOtd?=
 =?us-ascii?Q?jS4ezukjlMa5I8kkBhuLm/Ri9WiqCVQYZsLsPMOUdVeFQYzH9P7o/3ey99xK?=
 =?us-ascii?Q?WFj+zg2hX1RGjFjxK+F7eKNeANe/dtu50jmPvuG2F2jrH8XfE33kI4p5wbRp?=
 =?us-ascii?Q?IrIXO+gNYp2FOKv3A5pHnk/kxA+ymoG/OVA6VBEUiJtJ/1vhfo+4fhIHV69l?=
 =?us-ascii?Q?FIal5vucEj8AQavs2PM+khEXdc0rHgHm7/GRRu2UgrxOQK0GeKiuKd27cb9I?=
 =?us-ascii?Q?cB12TFyLy6yX83Cz3pr7pVYIOR+a3Z5qWbVwuHvM6xe0iBFtdP6bObG+STlX?=
 =?us-ascii?Q?hObsJP2bMbpec/+eNOjf1A8T7sCadLVPL4psFtDqYwUauBBeeO2/9L1wKUOd?=
 =?us-ascii?Q?TSRoEvdiMDJIBWJkwkZ1HmejCV8gHzmybBY0LN/3NNDijmT+GIXgvg+uRlim?=
 =?us-ascii?Q?ZFYyS5c1JzLh/LMCe/I+E/horqaH7FHg8mV5NXMllNFaOuBs0oFbDWqMLTGk?=
 =?us-ascii?Q?nHiK35PhF9s4JCYFbSrkXke3j0+1VARe5XO7SQbM+ogEpwbl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a634c21-1b53-4c85-da9c-08deac5e4fb8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 17:30:20.0407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwEdSii5G/LrluGa3s5uhyJc85tpsr6HTT4FlgmjPaWRSvYyvvIh1V/Tg8Upl+SH7Bp4ocxvo02iPfJUacNA5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961
X-Rspamd-Queue-Id: 13BE34ECE64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285444-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,ae231e0552fa77b26ea1];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 10:57:04AM +0200, Thomas Gleixner wrote:
> On Wed, May 06 2026 at 18:29, Thomas Gleixner wrote:
> > On Mon, May 04 2026 at 05:23, syzbot wrote:
> >>
> >> ------------[ cut here ]------------
> >> ODEBUG: free active (active state 0) object: ffff888033a47278 object type: timer_list hint: br_ip6_multicast_port_query_expired+0x0/0x380 net/bridge/br_multicast.c:-1
> >
> >                                                                                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > An object which contains an active timer is RCU freed....
> 
> Unlike the other timer in the same object, the own_query timer is not
> shut down in br_multicast_port_ctx_deinit()
> 
> Something kike the below.
> 
> Thanks,
> 
>         tglx
> ---
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -2030,8 +2030,10 @@ void br_multicast_port_ctx_deinit(struct
>  
>  #if IS_ENABLED(CONFIG_IPV6)
>  	timer_delete_sync(&pmctx->ip6_mc_router_timer);
> +	timer_delete_sync(&pmctx->ip6_own_query_timer);
>  #endif
>  	timer_delete_sync(&pmctx->ip4_mc_router_timer);
> +	timer_delete_sync(&pmctx->ip4_own_query_timer);
>  
>  	spin_lock_bh(&br->multicast_lock);
>  	del |= br_ip6_multicast_rport_del(pmctx);

Thanks for the report and the fix. It looks correct, but it's unclear to
me which commit to blame.

AFAICT, the trace tells us that the timer is pending (not executing)
when the object that contains it is RCU freed. However, it shouldn't be
possible for the timer to be pending at this stage since it is
deactivated when the port multicast context is disabled and it is only
reactivated if the context is not disabled.

So, I see two options:

1. We did not disable port multicast context.

2. We did disable the port multicast context, but the timer somehow got
reactivated.

I will look into it...

