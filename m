Return-Path: <netdev+bounces-283649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCDgDMyR92lhjAIAu9opvQ
	(envelope-from <netdev+bounces-283649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 20:19:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E504B6F81
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 20:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F7E93001398
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 18:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B153CBE84;
	Sun,  3 May 2026 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JOU2kj68"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9903537D2
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777832390; cv=fail; b=QcDCZH0l3T5qlZc5NWbbSF8nmLJKF0ElM7KieEgDx00h1pZDzk/hOih7z+J02c9+zUeliXXikld/r0sTxRj4CX2ygGMS5o+A/wh9PVyF9Ccan5GqqLQ75xv270dUZEbKX+1eH7tDaFvJ0AvhLdY/vozF8/LluD2rFsPS1LJABbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777832390; c=relaxed/simple;
	bh=QqXKm0FzoOjXOOiCV2AGnNkVcGr2cskkgvZyCjCzzqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iTXtymGMo1jUvh8tv7r469rkicYpHp10UTgMwGSMkJ+4pRTdoOcDuXQPOTUiHe6MITxh9Eg6KPM/Yb6U5Ge3mNfi7sd69IHPh4e3QFg9juvdbJmlYAeDYjOJkPWyd/meqNVeqVRonAEpAF7dD+9iiuO3AobG+jjl0X/DFOApTpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JOU2kj68; arc=fail smtp.client-ip=52.101.43.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HT73/N365LplGjJaddMEglB3ZQd/Tcci1FLBLa+HAJ26J0d31v2sRo36ZNGSPbfN2y1PXuF1S6kRmzV9RJc8R/Tni9U+Y4tFNYWN+2dpNl0Xgz1Te4tFHEcHtc4QtuA6GweEpBTQUOUbUdr/Z8YAZAnitD6myZaJ5Pre34PDt5vAfgOTzMB/DjpbcKHaLr1Ela2luBEnyHCxhohpgDt1qvXExw5HzZPkZYBAGVcVJYbbOuuEi4T/GluPPtZ6JSqFmGk3dYkNaKKIK+meE6k7Zd9iT4UbW4m8E7zR57qOXPTsJK8higqVGwMx2lm43aA+VWpPMeLKkcVAHo3rwV7jRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwNGogs77wpzHNH0ku7kTspIs4jGIHPzoNIHZi4c4/c=;
 b=BewZzXQBD3vsY66FujmIyrFVXF50rp3tLGeQpHeqeMJlHujQJ/g88F8vr1B0GpPnsanWXTEss8pJyjNKJd4A2soWcMAEDPM537XvidMzyBc83cY1l5dWkwy++xwxoFzvZpkl1UxVsdWLq/ZErRRBO0s1jBRfz7FDgTxq4aJDVVVU1MoQPyuTZJW50Y9a29PlkPtSR5dhuHftwcNYY/zNPfkEzZn6gxzNMGhc3D2v5ZTVngmVOiw2Hg1DUXUSLz6OB5QLR+urOtOQDe/vT8s1cxIZUWnHJgL6NvyWqDNSsJjX200cMalCTW9DCxnVp164EtBOOqbwGMycZoARzh8f5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwNGogs77wpzHNH0ku7kTspIs4jGIHPzoNIHZi4c4/c=;
 b=JOU2kj68VZkKTZUusMuPmlF0aLojM4rM7AHZuTLiBGdvuJz1p3NFkMAFQrSmQMwOEfqjngnUfbqWolCkwW2CxigI0Pf8O/9zMmIpFLss8k3ACo6glOqDHtqSE3DNqi1QfIuz5ch4hq3Ha47vm6V+z/ACSchKtURD9hwVSKuQ2fwxp41516Pjlnh/Lnm/SI4cZTFREu7FS0d24+FvuUJ/FTP6yCLHW4d2HSmvTAh1fpIQO3dmEio2ZWQt7UXrKReaGRMUvSmkvsTQBYU8SFO99jqaxOQl8qIWkvloZPTEFLJnF/748XrVJrkAkgGWg3Qf1Ub9bR8LPGr1o9/FFOo2MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sun, 3 May
 2026 18:19:44 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.023; Sun, 3 May 2026
 18:19:44 +0000
Date: Sun, 3 May 2026 21:19:34 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
	petrm@nvidia.com
Subject: Re: [PATCH net-next 2/3] macvlan: Do not transfer operational state
 when protodown is enabled
Message-ID: <20260503181934.GB269092@shredder>
References: <20260429124624.835335-1-idosch@nvidia.com>
 <20260429124624.835335-3-idosch@nvidia.com>
 <20260501180948.1f68c43f@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501180948.1f68c43f@kernel.org>
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: 45819636-57df-45c9-847f-08dea9408d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jRjS5IBDuo9zagrnpRfXeg3aq/6zZgrcZv/W/WwLaeivLWmbncCcAWLD05kWhxxXM8UxOmwGDsfJGJndum1/My9Rnt/ojn0/6ZIEUcHjGHeXdqvlO9ZqSX9FUTRf2dFi/nyX/KF9FkRq/O7xxgpG166CoqvwvWXZw8r2y/toFdJdwn5Tshv9N/2zm8Q7hOzGcJiLtv9SpuMBmQah968lbqGcUzE9TA8ARmTDkQZXbZz8szol1QYak/T+7a5kN83Q/gEDoLl+yO9EAT0mCwZdKi8OVJKnrjJi2f2ggfQAGLbpZx9Rm5l1j88MTTmwcoTFe4+VtPkapfrBjM0bHaAKl+0Ejz7AxUMG91vNlTqFPUwGTn0mpx3dQ1KI6a+6On8fyjMRlCQPV89sOsvSrLh+EzhTcU6YpIy81wSpYlYA83rK/m3+kCOdVWmuBzdCof48A96SESFB8ewFRfaxKl0b+YlfWg3Skw907ZZdx90ZEvUPhNIVacB1eCZ88kNa3i27pCLQ6cAa8pyizEA849WPYC+oA7PusJEi9UfNi1GC0kO5Il9zsmSpAiBEFt+1cg1taAKQ6nduaX+WGIQFTJDns0x6FHFndmSllA8a5c4GWmglaH9AH1uRl3S9spQklgLdINe+wBOwGkr06SgIKQLc2EqpYwHueRCjMoFlK9ZVLfwKeL4kE6JDHci27MiPhXu982FhFfB8mRDpNZmq8qMpAg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PJLS94O5SDbrmTNO58k0A6BO3SbN9ft2ksJhKmavO4yEBPIae6xDAtk0jztV?=
 =?us-ascii?Q?XJAK+1Ed2Wa0pBdN697ZCvCqY+c6RpLDPcl32GGkUH/d9UOLKy8l6VHnZUDf?=
 =?us-ascii?Q?/AaamsD0YLvn2Khrs28Q4ZYQlSFcitCK6EJSdKT1c0Est8ys4fuCo5DR4dgl?=
 =?us-ascii?Q?1Z9bKa7+vR3MNOpblHhKLk78i0SItWeA5Tba844UKJO3yK23fzA3pk9Oi67I?=
 =?us-ascii?Q?eE4U5Xe/t6kGb6z65qK2XUU9aeZKAskCj9ISXZ/yatUyIkPZNJIMGNVZlRDm?=
 =?us-ascii?Q?/VbgC3p1UTdy0STKMiUnK+3GrTgmO0JaUfVXAOEN6KXUqmBZAMptGgMHen8R?=
 =?us-ascii?Q?bH9/Nc3JWEpz4dvqqFQa56SpUGxK3Hj2IuGLEZ8jXbsN9230O6cVLUDwAN9x?=
 =?us-ascii?Q?0EbSaxON+aM1U+UFKVLW0Qp9UzK0vDM++KnLsWt5nFlyjaVHxc3wvsVmg6gU?=
 =?us-ascii?Q?s1lGQEfUGX9tefMbY2LTp5nUeYeL1hdKleQhChhE+vI0XHK263rbG3Fil/S8?=
 =?us-ascii?Q?Qqhe0J8QBj4adPliIMM6Zy3f1z5ppAc2SqdlJbSPSjnwoBmWp7tFc+N/VIbQ?=
 =?us-ascii?Q?pVn5uMn4czGQ2Y71FR1qQCUd18yntiCwgHra29UzAzCTANhLmS6jWiRvfJpF?=
 =?us-ascii?Q?wJhroRlFJ2oJTMDTNe0IGtsKcTPH3anttAyu0DJ8mjp0hDqBFIICOGN75m0l?=
 =?us-ascii?Q?8ZrglT5KH7e55ubiKkSc7zV8ydSaGMeW6h0EmuuuuCjR3VWDBPwTd40foqrQ?=
 =?us-ascii?Q?cEWvL3FgTaahUR7IG+MI8xKKoQlIn1+AwzDxb2hx5nvETs4DhyUWX37Iw9t3?=
 =?us-ascii?Q?6yfXN6GEL41nsHcFeVjntfGzR7g0zhNwY3vFAmWtXkgUS/LHR2CN5GjNuBNn?=
 =?us-ascii?Q?Zp0Bj7R1vwMabmTSnQkG9KqAr0Wlg5d8CkSyIQVRneQDtrts/UgPI2OtXLYJ?=
 =?us-ascii?Q?hHCz4eFDfoI/xwJVqIARh7Cru4xajCOXxlJP3rsyw5bQS6h6H+ZWMlLbKNu4?=
 =?us-ascii?Q?LIo9qdNwNZCkQUJ0QdZaSPEXef8StNGixHuMYZckBmU3fPYyxra11LUqsRIQ?=
 =?us-ascii?Q?ajdOfQNZz9syHJlQQYncDvzjDB3nGSZHAdid5qY8ViMKkwsm+vXO3llr810Y?=
 =?us-ascii?Q?2sOilnvxnL7zvrhxH9XFmTzwmM0IQfS9zsT6TjZk1GHPBoQOYupfJ7rSug84?=
 =?us-ascii?Q?7sYOihQOM3vpLL28XSvk4bjvR8et/9WT+phv1XuRxaPhDPzOPMwie7epg8DN?=
 =?us-ascii?Q?BEvYBDFAk/ciGOKuy+1U1cZ+qtQCtI+HEoYXBdtBnWWo6EjO9E/wFJJagAb4?=
 =?us-ascii?Q?CysKLaTTx4ZWkYpWBvbtENawvUdcEyQGXtf9tzmYVX6L/FziG9ck3lLq3ZRI?=
 =?us-ascii?Q?9P/B0RYR1cWIC6ISeK8HuqzcMMq8F50Il6VfKie/nJmj6eaNW2Pwvc1c5jMX?=
 =?us-ascii?Q?Siw61K52tRf47j1EstMNtdoItEdoUKBZGsrnyEU+RTRvQNhEYphu51WdlEvu?=
 =?us-ascii?Q?mg3ZmdG3eVqJWQporDxJczrVvgb7YoP5cGjtksiwRr27VFwpDbvQG31NDRwA?=
 =?us-ascii?Q?Rr+A3YKaxTZZ6ofwTjEcLJkrbv/+JLAKK4hhT1bI7IMcfIACB4u4sHIVv6aw?=
 =?us-ascii?Q?k5q0NNEEugT9n5oSEu2FUOFFDK4u0tor3fkN1ArKlhJDbC1z2FuBF4ztUunj?=
 =?us-ascii?Q?kU8S9k0ZYUOcK62qJuWCK+Xn+7QFEb/ywI3AXI5o8h+JvjTI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45819636-57df-45c9-847f-08dea9408d4c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 18:19:44.8033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p99Wid3K92uOufN1ipzjonbydTr0T4Z7oG+EItjdDM+eNpetY1kRWSIU+q9i9OMjo28Mf9QFer8tRI9OPUrhuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078
X-Rspamd-Queue-Id: 35E504B6F81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283649-lists,netdev=lfdr.de];
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
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Fri, May 01, 2026 at 06:09:48PM -0700, Jakub Kicinski wrote:
> On Wed, 29 Apr 2026 15:46:23 +0300 Ido Schimmel wrote:
> > -		list_for_each_entry(vlan, &port->vlans, list)
> > +		list_for_each_entry(vlan, &port->vlans, list) {
> > +			if (vlan->dev->proto_down)
> > +				continue;
> >  			netif_stacked_transfer_operstate(vlan->lowerdev,
> >  							 vlan->dev);
> 
> Doesn't feel particularly macvlan-specific?
> Other simple upper devs don't support protodown
> but when they do presumably they'll have to add
> this exact condition, too, so why not add it in
> netif_stacked_transfer_operstate()?

It seemed more consistent with patch #1 that invokes
netif_stacked_transfer_operstate() from the driver. I can move it to the
core in v2 [1] assuming we go for a solution that doesn't involve the
driver at all.

[1] https://github.com/idosch/linux/commit/1d86acbf0affc9004fad79820bbb2172aeb305a4.patch

