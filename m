Return-Path: <netdev+bounces-292147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +M84O9qgFmqBnwcAu9opvQ
	(envelope-from <netdev+bounces-292147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:44:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C925E0963
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5F913005D2C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9EF3C9EDF;
	Wed, 27 May 2026 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MJEsgKFw"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB713BADB4
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 07:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867860; cv=fail; b=sCcr2BFNsnFa+NTAEb8Z23so6HGDTAV3dW4FRSD0q51iTPwINOB1EI4jO1IehrFed1qj81jOQ3Cn9wvAK48Kill5BtQngAGouTNFQWxsimd6rlzNPqNf0ZLW2L/fG6L1b15CZhjeer3ELph4ytZrHefekFKSjG4k3pOV0J9JPPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867860; c=relaxed/simple;
	bh=3lRfdaDVzWDpMxcyq90aaaZFHmJICXV2rMkxxkUyz5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fDqcOHHPdbQJzJQmQeNRXwtrrhrWYZu07eRmY5sgmFLyMO9mMlDBlAqDCnCbuTyT5AgFNQ6kjStAQMZ2kOcy1PzFAOpAd2hRNjpglYpf0WTHSEk/TRvxfXzGUSqIwtSMdJWfMltJWUzD4/0Q9trPfTnUuGwLyuYT1tiiyeDSjlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MJEsgKFw; arc=fail smtp.client-ip=52.101.62.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdCrEkAn2a/bmIyydIzxQfczORrVYykQ6WcqV/RJXyi8IFAFROtdS1hNcjc4nGgzN9baY5rrVLYalrtZQySaXA0vCuykG0RU5mq8P+A4r9RMsswi7lGycZ3wbFWLC7bc4T3Cjn1xDs8vVPK9c5VGV9wJg5EPvVPz6fmjoym1PRqjLR905+90KJCHqYkATXUX5FpJUy1Dm2MPDuOYGR2tMibQ/3UpgnMLo2LEKjP4bEamslaa77DP3vJ0Tpqq0rm3dIFCWR1zz4fMrlxaM+ltqmj26EaYuuHMIjm0pveXuVW6aO2KLetE3guUjoin8zsu/hfI3wFR2c2nSyoCgqUvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYS11GaTfCkKRuH66Z4JDTqgTJVTEUMEvmhnVDeboyk=;
 b=mxQYaruY2s99gf3QTQbheIfrIBz5llLMJF0q0SfdgM5wFKinIgO2lY7Ch6owrcPOs7NGclvanQs2TH8TR3mJi7EM+xPV9722FPn2qTGfFKvp38OJy7aDNcPTxVgY1Wqogr0rH+16XpO/sudcuSLGdpMCcDMrcpGM/OPaTHlFHNTHY6IOYCIabAd2JnDiXWnb9dHJWvH78+C68Zz67yzPKbTygbXHx3p8ib0pAOZ9Dj2CCsVPI9rfVEntnPti2UgKFQKDIf25b94b1nUKPZqDJ/96zXy6+bYJGy7XUU2gzpKdy+8/MlF6ylA9oFWtPKFk+1v8DG3JKkLiDRyaHJvleg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYS11GaTfCkKRuH66Z4JDTqgTJVTEUMEvmhnVDeboyk=;
 b=MJEsgKFwuAyF3CggHyV2bTK0cic1u8JHaKyViaCk26nLz262czX7SSDSZYYfI9yB4/UKN2OFlvhe88w1LZ2tZ11U+C5TcpUEtofK0uhSmlApCGFi7QAkG/9iZU3gLA1PHFyu/CdlYZFiwuWDJdt38bCAROGSHxVqZUooZGzM8YrA7uQk0xEr5U5Oquy6vn/MEirCUn09079sWbXUK1miJw3iJgIFLj37mdy0HOQEg7sSJCDmQih3jmYXIsNDYZfHILVn+9z2VCnzLdzFtDN0eTdI1h424VAgcqWN4kJfdVvr7vH4ZsQTMwFitYkhdbl6Vt/9XXCEAWWkukPLAtSmxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 07:44:15 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 07:44:14 +0000
Date: Wed, 27 May 2026 10:44:04 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Stephen Suryaputra <ssuryaextr@gmail.com>
Subject: Re: [PATCH v2 net-next 1/2] ipv6: guard against possible NULL deref
 in __in6_dev_stats_get()
Message-ID: <20260527074404.GA434943@shredder>
References: <20260526145529.3587126-1-edumazet@google.com>
 <20260526145529.3587126-2-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526145529.3587126-2-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0361.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW4PR12MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: 9487e98e-49f6-452c-8876-08debbc3bffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1+uUVcRWBjoGucERG25nmruAU6zsqACq2SwXBtKhXYwKsKLd2mkGVBMLOBqcbWs4pLySrOoXzuhfH+jTKbirHfsxbCAPv3HVgxOnH8vUqTWpSfA0FgiWQEV6HnxyEMfapHc7/Df6S3fUYshi4o32hn+mDLozd2brZQcikhkMjiGD7WLNhh+zFwaj/AEktao8zGcC+Hp4b6elZE53DlXJj33pJwkrJv/Ww2Bg2hEFO/6wVi66Scd0Th2Wuzt47T2Z51uTFzs3ecoh98MlUW1nvDiqZys36sNYzX1u0RtCnT16hLEx+Gk+RhMGSIFkkfUh6APLvyPl4rolwA+oi2NKiQ7vziFFL7K+cumd1sOBPzOySEX7471BnoRvvm/ZnOcc5y1cEEv2rVpAwRPZ2TYUwgt9RuMgzT8bvTa+oalfh8PmeV4u7qpO+d6ThsQGTwdZLzrr9mxSmemD3brK9KBaiD3BIidrz8/v1RjbxiiuGMOYkx8uA9k5j/37TCFEAOGFXkKPN5V1ZJM/slpucH4iylFDayfT7oC+SIKd5FHDEb5WBVhatwfD94dh3viGQgND5eFZwf1sIvqqc4nNe+MiCydmt5DfJh1lFFe0Lcd/dStPMPN5pnJplPV9Cltqesmb45ypl8l/AnyxTC3B3kWIWxl9nmv0VLnMX3JptGhLp/3jtHM1UdwoLTMkk43xPOfw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bIbortMTAPdbS5dfWfyGDhnpgXBLwHlKi4HnxqNtVVrrO0IBywpkVUCCfmeA?=
 =?us-ascii?Q?+FgfOvnYLRIUNUxZrxGW4LZt4oVwipp209FVHunkeuPzaoiZFGAsTtX3vC9p?=
 =?us-ascii?Q?mMfq8T2mgDIXhQay5//czf/3nf5pXPz4IIqrsn/T6jqUXORcWA5pLaSLOY58?=
 =?us-ascii?Q?GULBr0TgiHRZASdcgujsjaKWIRvANb9FpCBLRj535QmmBtSOiSHpr+CiSq7c?=
 =?us-ascii?Q?gIKuu9kci7mVfLZjUqGaDZVl5KA3F8283cE9/KGsUwCVJ2Z+i5e7a7QL3pWK?=
 =?us-ascii?Q?ode7X/XQ7+6xAjrvixvYTx8/NVlVtuLrfBbCPDGiXb513F737r8o+59G9Aj8?=
 =?us-ascii?Q?+cXDNQAYYOM1u8AZKiNMtrRB/jUpNqxqO1iS6KnPODmeR9nsKRPUDe4s+GUo?=
 =?us-ascii?Q?1zHQVBPBlZtDmd19Xi3eCw95mG+DMaGPyC7+VjAm3BOe1qTjKX2lBZTGf4tB?=
 =?us-ascii?Q?+QSma3Bi/tw6NpyN9bMl0Gy8Xvz1S85s3XBk6BKEcNfm0SASi2M0qUwggwYL?=
 =?us-ascii?Q?lvDoixz9CP2158Z/Hs8XmL0BgdzNzQTH6xcsqVH28aEPwsyQyXqLMGGUe+4k?=
 =?us-ascii?Q?61qZxk21Bym/su9FkfOAwDfn0Iuti32Coky4KUxVUku47pVduRnGfkllY0DT?=
 =?us-ascii?Q?eSXSpVLFnjiO0XnqLPLuaF+ANH34KJnkAPM2mabrQUqPTdpQ8c9QSKsPOW/3?=
 =?us-ascii?Q?LmnGwG4HHaR4rDYQlAt+V83khcnfmF7/wtVoK97Bb8zqMwRxU//auNBNplnE?=
 =?us-ascii?Q?fNKEwcWqZF1UYKjLw/nxW0NhaG6OBTVj9SnaYQEW3KLBEGBHJm8uGFcfCe0Q?=
 =?us-ascii?Q?RB/78l/mc98+GxmnTxgd5z7id+66tp2hrmpTRybaoJOhtikb2nnjE3Ul5Czl?=
 =?us-ascii?Q?1I6fuginb/zH++x5FWiVhTMZgf+Ir8S9mw9B6UxamLfhuQd9aYz2cRnmMj4I?=
 =?us-ascii?Q?UY0e03NlbISv+SUqJhoA+NJ0VCRYvpncS9aPzCMKzsN4fdv1igZE27LWZeAa?=
 =?us-ascii?Q?yq4EggBUJ5m+HnRwD25bE05idqQgrDHFZKolkBx6LQx2C8cFsUpmnHBVOmTD?=
 =?us-ascii?Q?4zpIlK3/2wO4RfroDJRv69Nk4D0D1XGQ6JWgxfp6CbHmabW5xFYdFLwI2xfB?=
 =?us-ascii?Q?A7Z34H5DjVXwgaE7nC7tV2yXXD8sEszld3cx6vrhM2ORPaQUq4lWKVfR9YAk?=
 =?us-ascii?Q?sz1oAxnsIaNO1/uNZnl+viIkJhzt2p9S9Tnxq+W9iICCjAqM/hHYOupqWW+J?=
 =?us-ascii?Q?JSTZJnGkcuKbP/VVE/QvRTnBPsz+91UR26r9bP59UkoBUO/7/8mDU16cNcMB?=
 =?us-ascii?Q?kNzpmsGQqm+LHwfiTI5K1HjTiNFP7WjQXVgoFzfMD6lAWasEk3B7M3zfLpQg?=
 =?us-ascii?Q?9uFQjlg8iewFGPr3/2QVUyx/DWXI1M3F77kI75PbXNIeYgSv/vH07PE1NW1W?=
 =?us-ascii?Q?+Qgz1aQ3j3lHRM+XdwyZZm3K/KOuNedu6mPEQGXHb8HTopNXuRTHGFRf172r?=
 =?us-ascii?Q?JHz9xHIT6GNXG1m/x7YaQ1ebHQ3sap07s1cg8LgtmZqc3X7g7Hex86jjc2wt?=
 =?us-ascii?Q?Q8EJPg0iOO728Bz4mLmbhGQ+rW4Jyc1V8/WjK+mRZON08Xpqm4mtywZRgjeZ?=
 =?us-ascii?Q?4hIKOIJpUd4dFO1UOSph++/AqOfaVSupYeSDr9HEU16TP//A7g8KGMhIqQY1?=
 =?us-ascii?Q?Igk4iGtv398j2L5IXzaIId+o2UhRTiQktBmONNiLJhqpVpaZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9487e98e-49f6-452c-8876-08debbc3bffd
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 07:44:14.8226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GU+rWOnUMn9dEM/O92HqAB1873ybYEsmivJ6SPtnCItM4KxX/Ljg83vUS6K1lCRlY3wHZVuE5o2p1XSA2oGe0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292147-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 52C925E0963
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 02:55:28PM +0000, Eric Dumazet wrote:
> dev_get_by_index_rcu() could return NULL if the original physical
> device is unregistered.
> 
> Found by Sashiko.
> 
> Fixes: e1ae5c2ea478 ("vrf: Increment Icmp6InMsgs on the original netdev")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Stephen Suryaputra <ssuryaextr@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

