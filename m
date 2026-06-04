Return-Path: <netdev+bounces-295225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W6HEE79wIWrgGQEAu9opvQ
	(envelope-from <netdev+bounces-295225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 14:34:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C08763FE8B
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 14:34:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=OIRVfvLp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295225-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295225-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 977C130C40E9
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 12:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66CE44BCB4;
	Thu,  4 Jun 2026 12:28:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013066.outbound.protection.outlook.com [40.93.196.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE5C44B681
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 12:28:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576089; cv=fail; b=c0n9R4qJ8aDsDthv1aY8hKaN41GSRgCzfpho5ACFA4hDGoIhbEMBFAXGg6yRjKDz/lmapynp6TxM9wIZK834IGBEAoB6WL54RU1CnKHruROhmFc1AXHcbJV1zVzBQQUEzjPrjUUCdgeNrX0vgXdgv8XA2lByBhV55z0QI+2jFHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576089; c=relaxed/simple;
	bh=oOuFUWsi38Va8ql+tpHN9Jg7JOcMcjmhntm9ARbOkDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BDuwMCgrbQLJxA+lKIuM+ILKLkHu/16bZBObnP9oi2bQwL5geIKUZZiJrdZiyfAgCOFW7okaYfqlFWnBG14u1Z4hbN+Wracjy5hPUqgINLh2ODdmRtYFx/hsWTzD2T99Dr2tfYnks096sA/6TLV198UiM59Oa2Orv7GSOdL+EsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OIRVfvLp; arc=fail smtp.client-ip=40.93.196.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4K4ZS8L+AwGsIx+Il1H6+MlHPDzMdMX4voH1I/8y70nxXtmZhQNSiJKmBJ4J1qffFqMH4db8s83GKtpMuYjUJ7PZHx0Lz6ANbwRJp+cZR5Okf/0Zsk2ezSd9xWvYLy5U73uRF1VEP38IAz//x8CLLlmBh9zjDhMwEMFYFaSPxrjOyN7tyQCNX5p8OVgNhtNICTxZorPGW4X3MQ8Ap9DHXxHnryrpnMAbN+A3c8RlFivBNEQGskzECvEJe+7uN4Q/bev0jKKLNjE5QXqg6dU2veAuFSuKmoVJMNUCueKX+5bTbRrWK6/fSZc+pZ6uxsryx6Kanq0DUtHqYWrlW/MzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOuFUWsi38Va8ql+tpHN9Jg7JOcMcjmhntm9ARbOkDU=;
 b=fC4poW0WpMeo4s+fTiQGTuQcIIlqzS06E91m05qbmWS7e53AaLDQUlCdImmGIyHHFkLTG0Bmcze2zxPpWfnov1uHMGy62aq42r3fUSLpVP/J6mqCiqr8XSHaDJQ33ZAP0QwFoM7iBcPk0rZjT0Uvqmd4N7ap+LyTpBEzJk/aT1/X6oVWROl8r4Vw+5lHlIGbwtRRd+1DGwdkawCnvPwsTR/AGdHrF35KAdF1KTTmXJNgBnhcNwqBKS8kzsUpNYBAgFzKz5FHOUoqwF8189Rnp4uwL3ycgK6PnS30fRXWs8PHXy2MmGhAYbLY6QQ5bZ7LZek4Pdk+Jts5OvG12BussQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOuFUWsi38Va8ql+tpHN9Jg7JOcMcjmhntm9ARbOkDU=;
 b=OIRVfvLp0mPmEgmH9iLthr8IzadUaD95oyrU30k+25ldazFo3UeC17i22EKP8puc7FOkekKq10huBndY2Q+qn/JpOYMAT3ItIme6sXP2cieY7ABH5CnVq254xvm9rvhuSzLC/3gira/6zVV0AUc+V58d75Gx3mGkxtlUbQdJhfQIRVsocPg4UmpukhN9mstI9IJ7kZyNCajPr9BEneHhB9ZywCU03a5HP2IxIwnfRWLUKtW0lN4kqx+j613VODyzquwKV6A1xqUr627i6ITShooAgp1QoULrdR/SzOxgAB46CPm7F39P1C5S7/oZdfF10BxIhv2g9mngYZEuSFzByg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 12:28:01 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 12:28:01 +0000
Date: Thu, 4 Jun 2026 15:27:51 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, andrew+netdev@lunn.ch,
	kuniyu@google.com, jlayton@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: protect egress device access in the output
 path with rcu_read_lock
Message-ID: <20260604122751.GA809874@shredder>
References: <ahveCu-zzFlpeVut@v4bel>
 <20260602154523.GA537996@shredder>
 <ad40bbe0-f79c-4fd9-9670-5dab01a8e57f@kernel.org>
 <aiAk2Q-yNs6It6g4@v4bel>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiAk2Q-yNs6It6g4@v4bel>
X-ClientProxiedBy: FR4P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::9) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: a939483f-a152-4aa6-72de-08dec234b7e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Qlu1IrhFhKhc4yCw4xuudFl09xoiYpj7rf2xVERLXYTS6oSDvyufFUH3kJ4jyB5tCu75nyikUv5Ax0sD8kjqbdzolz1GVj0dxDJ+su+w/Ia/CAPw/8YU61l0pjXEI2kOfIV92Tcafr75P4enDsSbmfAkzoBSgfURISmhTyB+DYMfyHqk+No964JyVAgEzQcUK1yuFoZB+1RYsiGgAwElBj0O8YqyY/JyNZyEAkfe87vJNMfLOqSkfb44ENeH1vlkOBFARppK0emRVdzvLC+Gu5ERUTR1HNcAfKJupxtWJrIPUIgHZGRRRSHJXMY4jtwuz6u3KECeWhaEanjfN7i4MTLUO6VAQJPBLiXz4apeebLbr0aN/zhi19ipdCOo98J15JqfzxGDiaf1fyKEHRsWvLXGPiUQnknhLqcpUMkkicvxx6IDmhBk1PPZDmiqJ/V4wUUl2YGlVzgozbAHAblzFmL93fZQ5wHDuyXLQFQNrP2sd3KVzZxmTxzkz4mHpeHJ8juzU6ik3k9wWQjSBIn2C85FQWfKuVSb428ZlkV6ant2LoS5McYyZOrUOlfBnqhqwRl0HiHSTKXRbuQ38JYMHFtuoou7afTfxL+9x9mQ7vU3+fVJJdNq1i+pAhFLwvkFgrVCVOUVTLXLEbZ0RAb0tDzWpg0muCnzub1Q7tzA3O2M3wZudU/D3vUDHJA9cYS3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b6TnH8gdhq+XCQo568gPnODH3I6Rx9vS4Lj0d+SZdGHGtL7IcPWxyk19VTtU?=
 =?us-ascii?Q?NNCcw0emn7CD33XIdESEyRlSVyHhGY6GdM8U8bqy8DytruHjYALdw30E/icL?=
 =?us-ascii?Q?hlrgI6a8WQ7FK4LEalN1rg/9rq6w2NUmgaagx1xKWixCSJ75k1UcIcY4Auib?=
 =?us-ascii?Q?9irPIbEgG+grkLQ74VgKsQ5R2HoF2hc+0ZGoHNwt2cUjAES//ECeAWVA7oVM?=
 =?us-ascii?Q?VyP4+St31s4PHHMN+AABUR8BRAhS7drpPtsgXuguCEWGDAN50VhDu4eOW/AW?=
 =?us-ascii?Q?pB7wobOOvXD4TwFzEMmY28NIfqEt4zXm1lsqY4+RTEVsJ5YdXSYpO9zXEaZg?=
 =?us-ascii?Q?R7vbNsiVDk6bSxQC/EnFizw6MRz+Mwb48olrE7lqC6UEKG42ow5cIR0TKg/y?=
 =?us-ascii?Q?IVQIA2tfA1sGX4GezOGui//XorsZ+x8fx4npP2HsEIfD9+kISD9TAcLF+RXp?=
 =?us-ascii?Q?TQwffpDnCBx4Vd3STYSCt3B1hbZRN29PnpolfsRG/6wtUB0jDSah7p/m/D7G?=
 =?us-ascii?Q?/g7Q41B11HKI4jHWDldd3ZpVqGcE92GbizJIxWkV1VLgj08bTfqk5sovvyIe?=
 =?us-ascii?Q?SU2PVJc1Vax3AJ0+A3Wcykf2UGEvKbJTThc1v2rkp/e8XhQIYJxfvMHMFdYx?=
 =?us-ascii?Q?TdRntRBZhdk+hW/rcaZdV6GtKy99vP+L9A9Yo37b1Exznp3z6OMYjzCCzuf3?=
 =?us-ascii?Q?SYnaV3Pqt8BaVosCOLhNMw3CZP4XyhcmuQdVTvbx81qS0fV1AViem3MExICz?=
 =?us-ascii?Q?Q/bpx2DC+kTAfbC0GwDemZx61bCfVGqJl8jKiFvHxnpNCDs8e+6+IzR5gs2t?=
 =?us-ascii?Q?LL4qkALZTbqgFo9swjh/SEgpHInLT1LKZJo2BJnDYDPnUs/v7Nck11ohmMGw?=
 =?us-ascii?Q?PZr487mI6ZkmAoLn9ijSqbltUK8oxjoACt6rk7yLR7qMQ9czXp7DuePBT0H9?=
 =?us-ascii?Q?QNqBU6DMNuTdbS/yWSwnQOs7bkV/+IpTBlsW426pCES+ILYWdn+fXHO1z9y/?=
 =?us-ascii?Q?fbsvLG2/z2KGHxa3sQvOrUZ4yIb1E6LFLplIoapKmTwtiKRqFKlc9NycJ3X7?=
 =?us-ascii?Q?gnHsgu0c+71jmONV4VTNIFIP6hIseAV3L+Z5qZ8ovxN+5RXz1Jbs4UCKhRXV?=
 =?us-ascii?Q?hWPBb6huie76PSEMm3hddOM7yz6UN3TpRI2dFMEsqZFexnkzpcvekY858qSH?=
 =?us-ascii?Q?yHBKcu2HM7bvVjOnO7naKGgoVlQM5bSEKM0aMsZesao8UARhPIGyYEX+tPHY?=
 =?us-ascii?Q?HaTT2U0Nk7KRkTiKHNxTRkQeQXvoG7FiLkkiHejJa6N7hlT8GE3yOGmFTywz?=
 =?us-ascii?Q?DgjlJdyz3AqbcVAN3xKBomZsHqfC4E/20h0BJyG6gQFUOT2iUennFNNfvROL?=
 =?us-ascii?Q?QA8CMC6E4+EsEq3JrnLe43XCUtMOzFJVaiGiAoF35jL6+2Xfb2ExIMc/sKr7?=
 =?us-ascii?Q?q5e8ouWrJCB/TtFuk963UoLP2L0KUCw9vGA6yRJ1y7RqIzsLJzcQc49pujAh?=
 =?us-ascii?Q?5pakqEg0ArJ/mDK1CHuW8y5MpwpIKje+DdSRPsG9jJIGfkTJW6TD8Bv1J130?=
 =?us-ascii?Q?pAa82Tye/jceXAIaDGw5HR2H659fujowp0cGCw+kHd2UFWdWYE0Fv/WWdlhd?=
 =?us-ascii?Q?F3/Fj+h4GCDcA+SXTQTv22J3sDgw83HLFPRxb1qflD6L8IhqfNkbEeru1Zgf?=
 =?us-ascii?Q?PhzdUF/LfgmJzPd4cA75+Cs7GhyFwMY9iC0JjPQwFk2x6n+6ce/UZ2gMq81i?=
 =?us-ascii?Q?XbrvqpsIow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a939483f-a152-4aa6-72de-08dec234b7e6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 12:28:01.3874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftgdedSlkZ1nMCTk6/tmOWTI4iO5WuG/d+UluxjbX+J55Wp2K/H+2ZRKY1APt3QsinAgoST7ivjDpX93tv3EUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295225-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:imv4bel@gmail.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:andrew+netdev@lunn.ch,m:kuniyu@google.com,m:jlayton@kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,nvidia.com:from_mime,Nvidia.com:dkim,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C08763FE8B

On Wed, Jun 03, 2026 at 09:58:01PM +0900, Hyunwoo Kim wrote:
> I couldn't find Sashiko's review. Could you share a url?

https://sashiko.dev/#/patchset/ahveCu-zzFlpeVut%40v4bel

