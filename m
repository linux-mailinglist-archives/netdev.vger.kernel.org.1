Return-Path: <netdev+bounces-295165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2GmSFddVIWoUEAEAu9opvQ
	(envelope-from <netdev+bounces-295165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:39:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5712263F1D3
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:39:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=uaIZChsN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295165-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295165-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09640300808B
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 10:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B453563EB;
	Thu,  4 Jun 2026 10:21:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013022.outbound.protection.outlook.com [40.107.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BFF70808;
	Thu,  4 Jun 2026 10:21:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568461; cv=fail; b=mjD2+c/+m/4Z2tLoUHDsMyzAIbBqGW4TOoEvbbl5F1tvK3OT3Bs8pKKCO5xIedIoFzibTW+4BaH2J8LfPCJqdrhfK+KL3fKajHJI/7QuXTrcONmM+i145mwnGXpM5j89GhO061oZ5WiP6T0CqJmGFT5w4r4wMyVOuRtbGKVAAmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568461; c=relaxed/simple;
	bh=jc3VBc30R/H5JCjAhri0/lcgSDdOemOB8+icUueRiwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LaE0V+nSEddhhKQmHKfz6+e+gg1XQSny4UWctPMHJMsdyqpzSsJc6Aqa/qIhK3+hKzIU0aOYpsSFm51oYtvKluyV7pjugg/4OCQMU6lp8QhIdo+uydbZo7NYhQjW3lnmMAAidnAFPHB13t6qvapaKKX4HGgW6oN1irx7GFKhF0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uaIZChsN; arc=fail smtp.client-ip=40.107.201.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wONWdrKokzZWxyOgltO6ulZFy1cJJl0kUzIT7+Z8urUgfUMKAszYVXoggefxgXktX25p+E6Of3bO+/gtZ01NbymzeDqqvmg1aJA4NYq/AeDaI2D6u31aWsH80Rhv7MrTM1XMuL83EtKv+fuZzDYLeQLNaLr8nKbsX7T/2hVFXLLhnroFeWCGJXzBlUgUFN2bH6j5DuIaD+ToTVOXShPpzc9CJniM7Sf65rfZmYxDbIJKBCMiD1dJ9kT0wz+LTIUAniVIURiLSFSr1Zqv6Lqa8ELhI6VN+7xgvhK6pCgVIaORhUVg64UpCmvd8OkW1B2uKNJ4d1gaClNHy4H4TSJMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSR3v6veNg2V0/JnY9YlQi+dCJzFS8wXoE4X0BQRz0s=;
 b=G3eNChOEE6Z6NdISCpjxho7/N+v2z3bIEd6+kvRgndkbbghznwyQmNoIuidaeIZQWIqpMabyZxPQtoM/RGGwiuJgvqBsQBdDEPExIlvl84rxYMa9WBjmvBM8T36WozTTj2wOSJ+ZoKP2n/F8cM47T7vSyi8f+S2xEmO/WmlVSVnngUJV7+9/Jf8x+pMB+j1x/r/+YTKBetgBEDwIqsxYP65V6deMjUTNN0trTAIhpGV7xaNN8o59x6/wJgM8imaR5k2YveBJox0inB7tnBQtPeUi5GtFx/Aq9I7OJY5ZT5MZcXYmP07igbP6TWstAM9DwC1BbUIEH7Nrp9kbNFLPmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSR3v6veNg2V0/JnY9YlQi+dCJzFS8wXoE4X0BQRz0s=;
 b=uaIZChsNrEJqHj/JR20KChfTdLuxkv0ngG4qcCyEgv7HdHzQybNryX3p07oe8EkKMJAvK/WmZ3yyCwJ9pDD0cHrweN7Qa9+Oo4ukEbllPATrVmom1c83oqxpNY+FOBLMVzgJZ1qfTxcXP9SmvGeIuAtDIpkzmqOVNrZJqjugZwF25PZoaaArH7nepHiOTSLk0MjusIuRyru6JAjB6UX0NRzatx+ovam1+FHUcxg63hTg4CWnSdNTcyFDKDTpsCQr8lOGG7Qa3L8AwdMcGbuLgIXc9fRK/lJEV7WPe0R3NqayjZSeXeIXMwoUkIRbxbMicPzvOdUL8Dv0e3vnoQZNzQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 4 Jun 2026
 10:20:56 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 10:20:55 +0000
Date: Thu, 4 Jun 2026 13:20:44 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	dsahern@kernel.org, edumazet@google.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net v2] ipv6: use READ_ONCE() for bindv6only default in
 inet6_create()
Message-ID: <20260604102044.GE771160@shredder>
References: <20260602002414.1504106-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602002414.1504106-1-runyu.xiao@seu.edu.cn>
X-ClientProxiedBy: FR4P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7650ec-1abd-4c5f-2630-08dec222f6c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	/76yVPpra10T2XkjWWookkdfhYZE4wBxTue6vbvI15Pv6EdvDbVauwW0jLh1mCTseVr+VQCNM2mHBofPL2Z2jlSSmb51d2dhcytDRal2Joh4K7z7vmHnmRkB5yNQFex2hsOvWJ1qWu5zRJXdpFPsu3YcvgTK8cbg12F2fidci2B8eTOMEAnupsSn5Sn3AX836fUrTtKGe5bs5TKD5Pfi7i2ecQIWvp7uA9yuMj293luHImEo7FBl6Sc1P4QE8gedwocNLkHCg177SJj/wSja8hBcAwLY0IVs5w37Jxf41eVhUecs4k9H2CHyW3mdlkPXNfHfRqt9SP4rMsp+5I3d18RnHXUCK4HBbuR7ncPSzkiKxDEZt+P5ZGcqIJVHRYTm7hQ9De/wVtz/LAQ9mbQMe1PWSr9hJlxpjH4ZcAIGqYWEHCS+nOmOgBtD1kp0fGcPBT763lceeMQY99WLzx+QokmRUs71DXgnGeMmVQN+StZah8nb7FJBVE1EtMDohQi999ds7o3J3nrrb+5WO92pCsjUZfHqAP5jQUPIu4kXwbsndvUWYtXv0YA6seFAKkYIacS5WNyCqHrso91AkDiBEN9VCci2XjQUZCI81HhrCQpdxWQ8BPnmVY1RDameo5fjDf6vIIqlFrlD9wuyyGWPfn9Pcn9r9XysuLE25a4TXg4lTMq0IZoTgSQ/QwkIlvLk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dWEo5l6XywL0riw4QExrjkv+JBocsfWb+nfX73UQ0724jDWMwdPfB8lFSMEN?=
 =?us-ascii?Q?gF+g94/wjfABCLZOFAOW1JPfG2tbxosLhdQnk/i5M6k1fUSqi/RIRSNwb3/f?=
 =?us-ascii?Q?0VnLhWXqgVRo878saAiJXfEJvCtoFZ7ZNRK4r/uj/9idVYDzEuCHu7ysfDBR?=
 =?us-ascii?Q?U6tQtKMCFqi1Lw1eCjHGuMJlYdn8Ute9IlO8rAyZ1BPl5FOc8Oe2c3iaphv6?=
 =?us-ascii?Q?ks/zGmBQR+ZX0zqYrW4ZeffN+A4AQ5zyvHy+HqGRWVo8JuEEIOoH8qF2GLsk?=
 =?us-ascii?Q?tya8+3L1KYLwj23ktmy+SPe2nPdK33Trj4GDY4Lquw2d0ze7KXzWsQlx8fAY?=
 =?us-ascii?Q?SC0sGp35QOHpTS+ynlcGny/ljDj+eK/WU9gf4lRnPBLR0ZEPjiszGqTvpMYa?=
 =?us-ascii?Q?xrJhQ2yQzY9y7425STirsKSLJZtmfLDqipiiVaZNeU4eADvpu7oYamI1ujqB?=
 =?us-ascii?Q?Y5WCqz1K4qT6CJdRN3dK13T17GG9GpOAKCYagjj6Zm2FkRILmuy9Mfy5y0Da?=
 =?us-ascii?Q?E0prexEpL0d5bG620cKUXhg/BY4E2jW0qy8a7S4FxASEEaIMYI/rp7NjIbMP?=
 =?us-ascii?Q?Oka+H+ip7jCL2+CbnsEa2hDRFQ9lxMG8UwhFeNd8/qA3kZ2jPB+4LObko1j2?=
 =?us-ascii?Q?MN/fZGhYHLhY/lK+b+1aH4YVlaBZd4iNDWMap49DuRICwX8RhOQVvnAQefy5?=
 =?us-ascii?Q?eF6Y8KlKvM972V/9QIyvjnDM/pve5+ve45vXZ0s02ipPXPBzkT+WLJ+T0TF1?=
 =?us-ascii?Q?TxTBZG+WQDowOG+yZTxiIcOfgX38AjsKR4ZkTBPIn4gkIW6jEGn4zTsi6NLY?=
 =?us-ascii?Q?Zk778zdOuKS6izTbnIpOImVwSL4Ol42NM6sEjAtZDZbLURtS6jNzmed1VSwy?=
 =?us-ascii?Q?+U9B2TTnDKD20YgzRIqO3T1RbhgbnaICENhbMFLbZsz9Y/MHfCIapDuEpbTa?=
 =?us-ascii?Q?uD3Sl19A1GFwRd1rU2x6GbXic+phfdC1D47KV+7syehisdIpFhUeWyPpG0H5?=
 =?us-ascii?Q?JZw7Pf9ROQ2KKW2vcKQDPpyjAdhv+bAlABin4PLADNEUHo6y3R5mWWHgHaac?=
 =?us-ascii?Q?UrZ3Ck6xUxDh1rocHrQQ0pe1navhz3UX7Rfdg+Y2cbLbEirFdB9YBTQN9LQP?=
 =?us-ascii?Q?1aQbTXSSuuVQPVOjx4t5znOrez+RB6YFCCv2GU+mMSIkdcENBtO2cKuITvqq?=
 =?us-ascii?Q?vVsD27329cTHjSMGdBAUlFmIKFveV/iYhX8PTB2MDiFyr5pgi2F/zHX7sc25?=
 =?us-ascii?Q?OQ6ruuevV+vUxI2HFSXopy7fRwlYg7ngBED4mUpiRC2TJFwrtKG/cPbgIK7R?=
 =?us-ascii?Q?mWV84vdS+BU9plB1tEgt+mqJsTiMdMv+6Q7h7Yi6PT1gGBa0IKmVOm2Q/Uz6?=
 =?us-ascii?Q?c6fVhsTWP9BUzKNDHs0bDwoveP0QRe+X0KQerraE7r1DhZAYyYuGrF/0QuL4?=
 =?us-ascii?Q?OkCXXxjWzNtgfu+gm8KU1146vS2rBFB4FI3sCYNuqkepfPgrAXXAFTtfTuI2?=
 =?us-ascii?Q?i+VYUOL79URGafqIpzRl5MACi+Xlo2oUCJvpyGDZptMBrMYreMmEHxR2hv8t?=
 =?us-ascii?Q?9mGf2M4u5AIon73Y0RYjsj333Pcoi3/YCfh6ffSg35R3yZLWhBvSPl4yl+bC?=
 =?us-ascii?Q?ZqBvxTMFlMoM+6S4CD5R5L5olPN56sxemDjdUXiBzXpPOxLvmrlIxdRpAf8u?=
 =?us-ascii?Q?WvxEW+uAGIniKZ1EDIyLrbEuYNVoVb+arlZ8x3VPVBdTaOsz8KC92MINo7t8?=
 =?us-ascii?Q?Wyt8/tukKg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7650ec-1abd-4c5f-2630-08dec222f6c1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 10:20:55.8971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njmL1qQPYRx37L58D/hgICWX41hGs1eMLbktgW27jzl8ZA70r3K1os3sNoOyW7s2udYFIANBHYTGV6BmynABXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295165-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5712263F1D3

On Tue, Jun 02, 2026 at 08:24:14AM +0800, Runyu Xiao wrote:
> inet6_create() reads net->ipv6.sysctl.bindv6only locklessly.
> 
> Use READ_ONCE() for this sysctl access.

There should be a blank line here.

> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

For net-next:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

