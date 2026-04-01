Return-Path: <netdev+bounces-274106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOfNMmQgzWnOaAYAu9opvQ
	(envelope-from <netdev+bounces-274106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:40:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3152137B630
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E244530B29A2
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 13:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713FD3E929B;
	Wed,  1 Apr 2026 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XbPBjmN3"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAC53F23B6
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775048604; cv=fail; b=N3AITJJfGOZgjBDFXinuY4cZ/6Nhm9XS7P1S2A8l929cxtA9FKpwcy5Fxyqjoy3eJlwV4200flZq5TOEbOxH3STC9BnJf2NWfrwtXRbtUTQWdsE6vZnwaith2SNnhTMls/xR4yIe84spGbhUBhZhbsOzOmQmX7a85bttMFCGjEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775048604; c=relaxed/simple;
	bh=NwRk0JJ8U19ox80CwVUQuXfdlcXmSBdibS4rSIw4pjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IgJLZkIcOXfXwyB2rqe/n2Z6ZtYze8nDQW2IrqJHgPrBuj1Bq2TrtTsaZGP0QQQ4ucrHMwIXOuMg6qrIgEiBy41klEX8q2mFUKuNs7aD9Ar06CLOwAaiyNevO5c/lWXgIsK8tMFinniOUaUibCWID2/FFaVTpdcsI4SZM+aNZe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XbPBjmN3; arc=fail smtp.client-ip=52.101.56.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxIMkla2CTgYRbkEfemDar3SqhRvNNNx9QORNNoHi9Go7Xw6+cFw0SiF3/zvb9+bHbYusruCvChRqGtpw/L9zaH0ROaazxp7otLfayGvYYAEtfRBNosjFvbLlKVxQhL4V5EJsVuvmJqmowgEjJj2z5ig2HxGVc/OKKXMc+um4jHfjGVRaJO5awfDPonx6F1Dmb49TeWpZbZZGgrmYbKRQBTUYYmozVbyOhsmwciWypOlP2ak/l8Vc5OMbkVC36md498HME6Ua9tLsx2hiPHk2vowNYlkqrmPiSYXZrhDwdsC7p3E8sw5tAqe0GPlX4+x10tlx+XdvlIqrH67gYOnHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gN2yVxOtsVXvpfZdSwg2W5/rmf5tQPmlM2QRaivtvY4=;
 b=GqabqvwQARJW+qcEwp7FsZVuSIOBOMKRjQALaaH3U36kaWGAuQvWOWSUYnN1vk+CbbJEfEAUBypkNXmdfbXq1MtZ9GyPspLNfZhM0E8YKsj/Je/hDvi6UkAQB44Kb4lOfqMlfWhxLG1I3BffP/gwlDENtLSIoROhgmSGCDtIRDmUT7hhzG0bvKVnTmBmD+M2f4pWaZDSFKZZkq249pjG3LQs53aU84Qc9R4hna+OsY7eguwSFcnRT50kDx2KwTv/zqHNRrZwTrjnN+rqnWBxUGgCnHyHq2/MyvBL/I5kT0koDiAha3G07owKHIbLqzWPjE1HuXg06s74+HdbEfDOuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gN2yVxOtsVXvpfZdSwg2W5/rmf5tQPmlM2QRaivtvY4=;
 b=XbPBjmN3bV1snKZDBsOUNnTT8REI834OqEw6FlLvyyiCt8FHnkrx18wBejgQNyemagsqvpqeOX9kOigy2ngzzyko26P1Tg6BRtIyxW13bqLuxlyFRiP5oEcHPMhEbq0fnW1lqdlWk1o+9BY4OS/a8tL8AwS5upRTtv0xKxrwtb5h85zf0T+8WQo0vtevaapa752GRGRrClA7Xyp8ys5wfs77rvqK3dUCM5OkeL8hMrIhPutf54mN4BmacOS/GPIHdJl+/r+xNT1FfNC5n4GRnNywyk0jGUJuBeljJtku+2NxN80GHPTcpmP2wc0//mwdF8nQc6YLgniWRhq6CSLLiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 13:03:13 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 13:03:13 +0000
Date: Wed, 1 Apr 2026 16:02:57 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, petrm@nvidia.com, horms@kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, dsahern@kernel.org, kees@kernel.org,
	Yiming Qian <yimingqian591@gmail.com>
Subject: Re: [PATCH 2/2 net v2] ipv4: nexthop: allocate skb dynamically in
 rtm_get_nexthop()
Message-ID: <20260401130257.GB1808730@shredder>
References: <20260401081741.4273-1-fmancera@suse.de>
 <20260401081741.4273-2-fmancera@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401081741.4273-2-fmancera@suse.de>
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c323bde-1d9e-42da-80e1-08de8fef0822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wMeL7By2Y3iMV3Ks3h5Pr6gxdYi4ygNj6YE00KdkR9e3WiWGAE+pS48nZVm5rdvBHyS/zxeaP0uxJMRoDgPu/B4mUTanMKxWGf/uRAF7q3ZTNoEpFQkIlOY+30V5OItUZLulNoJdhb4Xy3y9+IMoeZ/GH6e/C3xSaItSREFx4Nb3BcHJQ0miSdQsBys2N5NWAx4E7Dh8WfxOH9uKjQhGXhdBLN3Ua1qRkqGTTTSEZarFLa4002K4AQjbyfaKp6DgOVIfXu29ICOLQVkf86nMEy4igpDNkzOyBprRhRpS7JQ2ilvj8SVOZSZr5fXBcxqW4TagYvt7OOSw72sxLRbrAc9tjOuellWDUmj/5SPcXCzYn66UV2HKFbd+uk4+7z0/T/VbwyfbEaI7h3DH4NF4AqNb10ddyubCmIQv7w8M4E+lrLRbew9Ckm0KfdCjnYXQ3bKwGI5BALONoTuTvvz62UAEhUCq8SPQc6jSEpslIKW0xhtpZxjNzBnU8eAhgu8xaTWTjJgngADkb+y94fNiGlNKCK7C92WOpOQ7MFauAUJ+kkqYXTBDM3XLbcFXsiOUX79mYS4aDgShHjCmCDihxAALyLJ5pXJJDl2A2GDdwhkhzpGLtXR/Aj8UGuB/Yy+ZnO052X38FDObUrvFBP+sss+Uk33bLWgvPQZoOyXCkcgsMtDmDltRdHrLayvLZAGDHj0DQyPJOBrSL/+yStBJwvyXfEDtx+YKSmqJcFMkIdU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dYCJqU29wopM/w4UZRNhpMKX9PTApYD3HXEavMuYSc6A1g7Sf5EUL3VBnOlC?=
 =?us-ascii?Q?tGUnlVhpZy53IAh4EfrqkXf9CIq7EfbcCNKJs7GQqVHcZyypePqCuT+g9VnS?=
 =?us-ascii?Q?InQIeifD0aDVdnDmSk1pCTg29Ul3bJKMaEv8yjINcBW0DEKf033Js/bNoirR?=
 =?us-ascii?Q?JJ0RzpGEK1y7RNjvbQT1g7fdpYkBJAi+Xi/1t+F7AHIBXOR0J+FthDE7f/ng?=
 =?us-ascii?Q?EV7JFbishVPdV72krntqBeLKZACpVD3jnoHiKt96bceglJJg7Cci6OtAFuRz?=
 =?us-ascii?Q?dFD86RgcWQQDg2od1TtSHz3fovWrUvLHAUJeq2qri2RPWRrMQf+eicSA8qUC?=
 =?us-ascii?Q?EJs7k/fs9FTA0h+3VgHenZNaa2+Aky8iRG8pfcMgyOrgV9HPY+GLLRFZBSy3?=
 =?us-ascii?Q?nDH7iE/T3mKauHz9gMu+3VSTOrhlg2MNdjME3H7qyp5CHosRm1z5rgtpwTdw?=
 =?us-ascii?Q?+fU6gQjTAYAnxeDfmRJWnCYt7UDaZ6G3m0nsqqm0CgdAI8vdo7OqqwMoLYRx?=
 =?us-ascii?Q?CHQc6OEGZSS0O6tu1Q7u4utaSXwBqk5YW5ROf1dKlnrJ0QiONt6NqhrbrmG3?=
 =?us-ascii?Q?fYwbQ4dGrHA5KxlIe3ACiHOAV4oq4F2CDMGFV0TrDtYUXX+B2zSF5SEyCB5X?=
 =?us-ascii?Q?9QTOHzh604mr59qK6KCuB5N1GddpFFXoGgl5f2oJiJOMcp80iqXoecv4hbYj?=
 =?us-ascii?Q?oECyPrlxoyT19TvCS+y8MxXgvv8+Qyn2Rfobtd4kF/UKdy8GMjYid+NVzrWp?=
 =?us-ascii?Q?12q41ijFcJxWMF0o/MEOLkhesBMS1CeFofASeOPRDSnci6RGlQFMYHM1tTyo?=
 =?us-ascii?Q?9i99bat/KG3wJVDIyW0Qc1h8q7uPS0zO2E3tsEB9Kj0nxk1oKtdq25Xw7/Pu?=
 =?us-ascii?Q?UvQoeYvv+kPFc2jyJrY99i8HopHWBWcQlOGGvqlOoHhlvDq6swmiHevrSEgV?=
 =?us-ascii?Q?TL5BmU3NuhdQ/Ju1CvhR2VYqioru4iLeyUxs1BLmMn8jW8wrzLD9yQ5+AGXY?=
 =?us-ascii?Q?4gBV7KWk4pUUYefjDig3pa5wCmN7CRMLipdXj9cc89C3wm7Wa2YeEET7BPmG?=
 =?us-ascii?Q?ItZW/F+lBO84CHyzi3QrAxJRrvdEZhw3nqXMPzMkOad6XP8ySLUtLYgCL5h8?=
 =?us-ascii?Q?Zaz9yEwDsLFFXIzIKB4TK7Hp9e4dsa7YW8Df0fP7NaVj5Es722OluY2DYjTf?=
 =?us-ascii?Q?VP76qpZ8RbZaDcf7W4vvVVm4lhKS/riQwBqpH8l7vl7PeiCZrXDyWWl4nLiT?=
 =?us-ascii?Q?GM8SXaDF8NnSeZNUJ5sVOPqHrNViC3QN9KsxKBHHEalvcy8gB7BTHoHMlvL2?=
 =?us-ascii?Q?4ewaqWYZq1lXM/LtvddGrkhIaxENGtDcNv9V9wLgwIFvx9tAszx/TTwlNbTH?=
 =?us-ascii?Q?8FnGWbFmYMXHD2VGh7RbuZ+f9UXXrwV8N3AXSBlh2/RsqPFHVAipd4zRvWP0?=
 =?us-ascii?Q?MeC+YSE8AZn0ZdkfOlq5L4Lw8vClQnY5xihXs7LyBf3YVwzo9RiZMDyW1h5r?=
 =?us-ascii?Q?nFrd9Jqog+dEYLaXDM4hPYx+R9XbRJdgMQ/lvh2hfCRcIqGNY41IZL8BHp9D?=
 =?us-ascii?Q?QxfXa8rP/TYShHnY6yNC29Fz8lyWHkXvvUuIO3OQedsIOmYDlvq80EfBcTIa?=
 =?us-ascii?Q?LADPfW7DrbNZ8zLrhs3uWZHKehV3i6I1eyKAqmzPmEe9ipAoW4mRk36fTzgx?=
 =?us-ascii?Q?H3n/Uh487p35ubUmc/vQQXdyg+E78N85fQ2trdc0m8GBd2t/NRwVw1bE2NFN?=
 =?us-ascii?Q?IyhAGb+HKQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c323bde-1d9e-42da-80e1-08de8fef0822
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 13:03:13.2390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9+1AccmFVyPYhuF/rVK0amen+SScst6W6F5bEu6zAvAXfjhCR7z/cFWNnrTeTwyyhKWrIsDB27k+Bafbey8TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274106-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3152137B630
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 10:17:41AM +0200, Fernando Fernandez Mancera wrote:
> -static size_t nh_nlmsg_size_grp(struct nexthop *nh)
> +static size_t nh_nlmsg_size_grp(struct nexthop *nh, u32 op_flags)
>  {
>  	struct nh_group *nhg = rtnl_dereference(nh->nh_grp);
>  	size_t sz = sizeof(struct nexthop_grp) * nhg->num_nh;
> @@ -1013,6 +1013,21 @@ static size_t nh_nlmsg_size_grp(struct nexthop *nh)
>  	if (nhg->resilient)
>  		tot += nh_nlmsg_size_grp_res(nhg);
>  
> +	if (op_flags & NHA_OP_FLAG_DUMP_STATS) {
> +		tot += nla_total_size(0) +	  /* NHA_GROUP_STATS */
> +		       nla_total_size(4);	  /* NHA_HW_STATS_ENABLE */
> +		tot += nhg->num_nh *
> +		       (nla_total_size(0) +	  /* NHA_GROUP_STATS_ENTRY */
> +			nla_total_size(4) +	  /* NHA_GROUP_STATS_ENTRY_ID */
> +			nla_total_size_64bit(8)); /* NHA_GROUP_STATS_ENTRY_PACKETS */
> +
> +		if (op_flags & NHA_OP_FLAG_DUMP_HW_STATS) {
> +			tot += nhg->num_nh *
> +			       nla_total_size_64bit(8); /* NHA_GROUP_STATS_ENTRY_PACKETS_HW */
> +			tot += nla_total_size(4);	/* NHA_HW_STATS_USED */
> +		}
> +	}
> +

This looks correct

>  	return tot;
>  }
>  
> @@ -1047,14 +1062,14 @@ static size_t nh_nlmsg_size_single(struct nexthop *nh)
>  	return sz;
>  }
>  
> -static size_t nh_nlmsg_size(struct nexthop *nh)
> +static size_t nh_nlmsg_size(struct nexthop *nh, u32 op_flags)
>  {
>  	size_t sz = NLMSG_ALIGN(sizeof(struct nhmsg));
>  
>  	sz += nla_total_size(4); /* NHA_ID */
>  
>  	if (nh->is_group)
> -		sz += nh_nlmsg_size_grp(nh) +
> +		sz += nh_nlmsg_size_grp(nh, op_flags) +
>  		      nla_total_size(4) +	/* NHA_OP_FLAGS */
>  		      0;

But the AI review [1] also mentions missing accounting for NHA_FDB which
seems like a legit issue (even if we can't currently trigger it).

In the single nexthop case we have:

sz = nla_total_size(4);  /* NHA_OIF */

Which covers NHA_FDB since it's mutually exclusive with NHA_OIF.

[1] https://sashiko.dev/#/patchset/20260401081741.4273-1-fmancera%40suse.de

