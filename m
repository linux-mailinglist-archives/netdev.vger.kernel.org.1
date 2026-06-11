Return-Path: <netdev+bounces-297965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k94MDHJWKmqQngMAu9opvQ
	(envelope-from <netdev+bounces-297965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:32:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C599866F0AF
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:32:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=SpjlGGbf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297965-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297965-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 987103004DB0
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44A1356754;
	Thu, 11 Jun 2026 06:32:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A588434EF0D;
	Thu, 11 Jun 2026 06:32:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159527; cv=fail; b=FLu+NRvfUyeUTgdPREX2RBIfJzOWWwwMAPx0OgRxkfGGp5hIiRyiqeNq1s0yRsTbPuvfUOoyqD1R+i7PdquMwgvRXKKYzEHKl0OBgIG58YBeN0qKKTI6shpoGfYh+dRzBvecg1rE78DJ3u/qcgb85/ZehC13WP4mFCaOF3oyCE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159527; c=relaxed/simple;
	bh=vAT0ucp8TKGFtHx56/HwXMbzKCL38L5pn4v0IEQfmzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V20RtJFutLwCqsJ2pUmNJvA5MaVh/vz5C2d8UClGBWF1ZPPxF8zFM/JzdMwAWktrSjhLoBgN+VI1ZdKyEE5INVlf7YmGIIGqzQXa5MmY6B3WM3eOHVH1vBdKv0dwTecbrlyHKGXcIk2sY3IS2/UCstXg6tAO2k28uZ5BeX4hbA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SpjlGGbf; arc=fail smtp.client-ip=40.107.209.25
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+ntDOKK42pK2FIXJ/dCktJ408OLQm6lgxyFT9K33Uwr3vZgEyb+/oNMoYqgS169eF+O5kKSUnCF+VwajdrhzFSoH9XrrKVrdV8AW5BmT4++FMRAwTE9YFfipAQbOHTHdhn3L4wLfIBb2rC7VxCS/TOOIMvjkyvJnpCB9uTwWEAB1zk0ZoE/8AqwOKQX4GCfpxWQWwptsI1LVrYrD7nU+Dc4dwJa0jpk1pIwPXLLgCshVRKyQgpwRG0IFnlGuF74/J8XoaDyWHa5grePWpmz1d2PJYryxSlj/jGLhbLVtrk9vOPScPiiMehU9nF3yqfzzhFPupOIH65LZFTqWvtGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhLbmMBVZBKud58dfRB3Hiw5JxUuzJDNokUwRWGJXxE=;
 b=CePZDGV/dipjt09hMJzFMyBo5/pReBRoKDtdm/K5T/YVIPS0q7B0akj57TXhhN4OEn72UAqjPv7xFBd1JhcWiwtA8Z+lpVUxIoVsI4muc+R9PDdO+zWTwlosjlsGSfwcVxB2cjqUSIFn7dkDap6w8fUkxHhiUrnnfi9HY+O14qeh2VmV2esx76dSxirag0696Cp340vWFN7hxRsHWAQ1whnU9sWCyhRZyeDxPPlFuVPzq8a/lK+tot9IKFSwKRbczuVK/mrVcCLpPMK6qbOrOBRVKnoOxy9unK1sO8Xw/ZHzly3FtD8MIKuX/D1pJExfzfDTrnNn3vjZ9OX3Vo2kqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhLbmMBVZBKud58dfRB3Hiw5JxUuzJDNokUwRWGJXxE=;
 b=SpjlGGbfyVWz5PvWdiPXJRTHoMdOlMH5N4O8cC0h12B89AK5mQmTQHGPPQPGVaasbPWJlI9dXFP9xJOiAGOipXCAS+tyRwcUCEpylBO/CevCwS+QTyheDzvrdDxkxzA9/5P8yVC8FQmoC43VtQhGjqhCgdIxJ36H5vbUtbFk7lTTFH/tuel+ERk+5fLU1HZLemzRCw8+VJ1eYMKwByiZtFn74IJcJoqrerSfa7f5q74vyZlczMxD+BMK4mOpzRLIcpXZIQ1b3d9evXqPXLxBZ9rGnUuzE6QwiIRzuPtbZngB9IV4+R08BFozIzJFGtJD94XRGzlvaLIGoVBgtY0Hqg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 06:32:00 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.010; Thu, 11 Jun 2026
 06:32:00 +0000
Date: Thu, 11 Jun 2026 09:31:51 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] ipv6: mcast: annotate data-races around
 mca_flags
Message-ID: <20260611063151.GA848847@shredder>
References: <20260609081113.7613-1-sigefriedhyy@gmail.com>
 <20260609081113.7613-2-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609081113.7613-2-sigefriedhyy@gmail.com>
X-ClientProxiedBy: FR4P281CA0332.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8297d3-fa8b-4c56-a3e4-08dec78324e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	NjKffukWwgtyt1JAnCZS2B9n09i93pdNFigjEaKgWjlAT2DjDrlX7GpsHXyrnkoftWxbAI7INolb5tERkFPG41UzNmn/mAmp+0e4kk/DNLW29K4T1u508qSuzc0Ey/aogRBSIisEHrpU93ySAcmk/A/J8V8k2ElkUBpWbb/iHttSjg7JdmhiXdpTBn4OQu/Qync/fCci40FgLCEy+6LYqtlqDJNFba6C7eJRRSxFru/enHrB5vrZicbFQrv2FKpW0fFkt+EH7fr+88gzfAKzRartM1e8fWBT5VKZAUirf/T/xhUnNmMkDiof/ksGBYLP0rPteyOc7bpn1nN6Gxxpz+anuSVPAEyN0wfEzBktrpfmFaO19gS2uvrWl022yCdzdciACo7ZWFDsi23OVi7AsORRFAzkFVylYSYPO5GEDOH4CRmpcS0CPY8v92tz/sfJMIuhAxIwZ4A+b/jaSgmcCcyeesA44uq7k0XOutlBwJLBPTaQ2v87JsOAs913r1XbivPx32lMAWnVfKXXzyinacQ5OPdpAEoe8o6JQ6JzvgZ0mC6JV9+c8q1Yiba4FbFFqgl3bWbqHxeTiv0MjOJhRdVEiaPQxpYF2C3TtKV3HyklOza7vgPlXdMRuHZRfjr/XI/Wp4nP5NpkHl91FB/Wikg9BBZDoeelpEj/7zhyL+WVvsOzbTCZoHlfSO5mbHP7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TS9DturCqh9mF/YFFAJ+6WVMyogVHJi8hiy8N4QAJNDW2FMqaIVtJesNRrQm?=
 =?us-ascii?Q?rcD0mPqMcImvQHy0UkrOlaFgz9svGZH+P4xjzUCUD3XgmUZ/R1gxCeFWZ9aJ?=
 =?us-ascii?Q?/Pfenyh0JVzMJ+zq3rrln/QFor5NZnEYhljP2U8mk9e9Zp3FyaDcdk1ElYos?=
 =?us-ascii?Q?tPh3ghnnzhdeVVSHQapeR+3aaQ57eTPVTvmwsSyAs3YBwBQEPILNJRiPddQ0?=
 =?us-ascii?Q?O6k0TAMAqxPvoMETRSX1nkFSJ+ZaSFhgTx4DTsJsOdkpdpGkXuut+62j0L+y?=
 =?us-ascii?Q?tQRx3shWpK68YyJKKueZIhUe0/9Bmv5JDFiUkZkHL1688Acp2/R0oK7h8+H8?=
 =?us-ascii?Q?jqVb1HbI5115UOs/sJBmWu+WU1NQF4FsiTi8ia0sZho/nBRemJpioYZspPDG?=
 =?us-ascii?Q?T/sOtfNh8zwWZnMdr/KN85dRCJTRSOIX2m68GcuDoVLWc+QpK8lab8B3vhhB?=
 =?us-ascii?Q?PyyIlQJT0RZW5mpR68XDzI8i9t45Xwrxt+YFGUOr0F6xWeqZQ224Swpy89Hh?=
 =?us-ascii?Q?GlViT8jm6+tkj8Kb/9s/5Y78lchtdAP/PQI0njoPijWZTYKYClC17fOMkSZ8?=
 =?us-ascii?Q?bn4QPHSYFA6nlAsYFi8WgIhP7Gm9dcNOuSktVNdmOpnNW6+bySLVt+8zFPpg?=
 =?us-ascii?Q?XJu1v+g5JEIvrYSJaj0KV6OZjTJhHEvQz9La2NJDkjzSVdHO87cyVvTLC+FG?=
 =?us-ascii?Q?HNrFUDdo6OQMPgmejFTDag0pjC7dXDNCXUVzKdAqdhZyIMX5gPA32UnfdjK2?=
 =?us-ascii?Q?kveRfAVtRiGM4Rdx6QwqV63q2KzW9hmRi7Zs+fY0AZoMHEEEcYfLIp84QYQM?=
 =?us-ascii?Q?NEG6pF620Eq94oEPmz2LWyDrnvcedFBPP/QuVV7tjz0jtG/VBYbDU8KJsas7?=
 =?us-ascii?Q?z7kOyyHFiSw/m5FGTcSiQecryVWB8RDIglHSI+KEDkG+TpHzTwcLvheA2EU0?=
 =?us-ascii?Q?i6oh7oky0LV+d2rKkztPnzsxUsb/26aLEPBi4FcIcD3xudlfdBdl00eEBId1?=
 =?us-ascii?Q?7HVm22jGInAcX6iRtWLg0JfOCJ+mJc4UL0GZwzLXTfBq2bbKfki+aCm+FlIV?=
 =?us-ascii?Q?K0TxQqzGjMTFoyerhF0gfkR6zC6dqjetkTYskbqPlJv+pmGIEo8dFNQvpoT5?=
 =?us-ascii?Q?bOibdPI4abWetCXtWoDgTy+bmc3129CzM5uKFpWziWQVfCdYHZUxRYCwkr8R?=
 =?us-ascii?Q?Sa//CGdAGLOQrM4BnEO//zHqUkCBYWak27c7cAm4PbsL6w42foB2UHoBdBZC?=
 =?us-ascii?Q?MtlHcQN5t27c/elevUsXij75cxUS00HGlC8NyLyfEKo1GHGpoh0Mz8zQLMFx?=
 =?us-ascii?Q?aRSKSGWlmNq3cwT96fu6AM0IX8e4poKfpgyIavw9LI08AFshJqfYEy+CGQiz?=
 =?us-ascii?Q?nsw6Klf52gc6wsFMgY0rLateGyHWxLLnoe51rOmSw9yZgpYeoENIp5pe6EE5?=
 =?us-ascii?Q?yBQm0KSA0BY/H9O41jNbgB2nzsrkqjcTMqsxlPPG5ibGfuu3uNoGphEfT42I?=
 =?us-ascii?Q?qufEnkKVYDTqsKBUDg8mklzE7LpH7tr+i1F3ujjCC6lsNnIFSY65NpvYEd1Y?=
 =?us-ascii?Q?sfmCrOMHaw6+tWaXWsA77akD3giPWHN5ATqYOV+pD2ciPOZNxPfMs3Rz8ZA0?=
 =?us-ascii?Q?vf2Nt8Oj4V2cBIambKWzUtwRVy6XDkU/9twLgfS1rbDojv3VMYxYzhutYiDv?=
 =?us-ascii?Q?SXLsp2AF7awbTDkP4zPtLPerfZF8utVTXl8OEme7AEUP9KpO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8297d3-fa8b-4c56-a3e4-08dec78324e3
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 06:32:00.7772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iF4e1/oOWyKG2qdiK+TzGt6fSA/C+1t0raNEb++EVjgrQSA/767vjDJIEIemhTYzvWhrGhVgVQCSbdcP/GYyzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297965-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sigefriedhyy@gmail.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C599866F0AF

On Tue, Jun 09, 2026 at 05:11:12PM +0900, Yuyang Huang wrote:
> /proc/net/igmp6 walks IPv6 multicast memberships under RCU and
> prints mca_flags without holding idev->mc_lock. The multicast paths
> update the field while holding idev->mc_lock.
> 
> Annotate this intentional lockless snapshot with READ_ONCE() and the
> matching writers with WRITE_ONCE().
> 
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

