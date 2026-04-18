Return-Path: <netdev+bounces-279509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id smcYB7ia42lhJAEAu9opvQ
	(envelope-from <netdev+bounces-279509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 16:52:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D76421621
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 16:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAFE13026587
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 14:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB613939B1;
	Sat, 18 Apr 2026 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GMzJ10aS"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012017.outbound.protection.outlook.com [40.107.200.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596C5397694;
	Sat, 18 Apr 2026 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776523814; cv=fail; b=QBnGfnALCYIgfonAgKEnhH3JC2KNGSK6DDZQcHE9u0VFOIEIvN3dNKbIPRuxJZ82KKbbkrmBd4SElS22SyYKEQ6YFHbmkS0D/dKsDjc2Xj9F23kfHG4jyqb1uziTVmdR0yDUr7lwL8vwDi0dvnKpqqmHwSPTkL7SHngevf0Kg8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776523814; c=relaxed/simple;
	bh=4Oac5h/PAct5oCCBWs7NTE4sgjwwr4Vo071Ohc+0SEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TmtDP3OKY+JjzUy6x52ljKaRJMkhY/J4DpUqQ+078k0CT0DHMzvoa18u01elUG6XZ9Nk4LH+tFrw/edsLpMB7KRc6TC7JHMnlYESCIpfFHevUOevzipsNOyD93KnYCJ8kLS0VTG4AJsY1HVBjCMyx7FJ8ouZx+Xxn4KBV06WgGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GMzJ10aS; arc=fail smtp.client-ip=40.107.200.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wE4A7c38DL5kyDVOG2z26ayX9dEtKJjkyx01lmjBJQQleR3W/S3vbi84RLumoACl4ZZMYMUcfF2uyAd/CwHYBqlpGqABx9DWHUS+Nu3TjhXtxNZtpwmS88TzTp8lzYQ+k+3eLUtJK39+X1YBtx3rJTKmBGKI2roRziDB/ZMBrbwYv+4g/oRpEPWGjzl2iPu6hKpGRMo6w0eGBZ2HJUqiCesy7bKmf+Iifi2AvPnQIgi7+z4NQ7kocq5TY85VHEfZb6d1dgBLCkPiCt1pnYxzZ8uduDxF0UKszkJ7prlPo2qIfNbEAjRE1ojvp93Z4zXpXZ+9NJO0Q7n0Y0VFGEwzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEQ6fs7rjRjy+MzhfZL8CyKNQAnXSE3ijfvDxUQpoIQ=;
 b=scRe17n11b3OTkXNA2zFo2CzFjlhxEU1wLwmo9Rv0rzWg/D7jXHix53p3Sq1/aHMCUljGhoEJBX4t3hd+i2FZvrNRyYV80jDiuTzVdNtjfJNy5Y9bwweNF5pjBg0w3EojAn6wLWq+aOd1x0FZSbvD4lpDycVkd4Wz3C5DRldsymVYMN3HmhwBG1pAReXf/dape58YefgNVTNpskqAJKYflPBbjhmWB43SFtU34AXTcS5b5o7183WSbjVCXQ8LDZw3MCG1eoBMG7gqWC49jPUzWF6caAEsN1RqmTEeu5CC7Yv8jpzeffFFUHMPkL/B8pdgxHWApKCH/dl5M3Vgo9weA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEQ6fs7rjRjy+MzhfZL8CyKNQAnXSE3ijfvDxUQpoIQ=;
 b=GMzJ10aSaidZslxF8lp/fqktHWiPj108mzVn9kL1Fn0YvgzhwiineK4DDowLbeEUbNyeiGCp3HjX+xt8gH9sEa79lzCKgPB/SVnNWboMislpuW+eqR205luruFkl6JDbsbq8CLbt+Uhmq1IiL7SQYJ6Maykm4VRaykf8MPn6SlIrQcnrWD6F4Yr7vp12VkLORyGWDBlZd//RQT1K8tDcXdiLNI6Es4hixmNr9fdUV4yudROVdqaV/qv3D4xLeqwNaLAutvisfygrUVJkNd7+nEIuWj+sqydSgFo0fMLZq5Az1+B8uc1ppXWsMPDdyDNn3G7BAFy3kqHDOn9XLw2hog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Sat, 18 Apr
 2026 14:50:08 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9846.007; Sat, 18 Apr 2026
 14:50:08 +0000
Date: Sat, 18 Apr 2026 17:49:57 +0300
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
Subject: Re: [PATCH net-next v4 5/5] selftests: net: bridge: add MRC and QQIC
 field encoding tests
Message-ID: <20260418144957.GA798825@shredder>
References: <20260412111047.1326-1-royujjal@gmail.com>
 <20260412111047.1326-6-royujjal@gmail.com>
 <20260413084752.GD209364@shredder>
 <CAE2MWkmvdAVMBvJ9xKgEzjJZ010=oY_ZoG==FBjHEisHEMrS8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2MWkmvdAVMBvJ9xKgEzjJZ010=oY_ZoG==FBjHEisHEMrS8Q@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0373.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: eac95ba7-8321-4ebf-a39b-08de9d59c8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dMzCaVP/hLC4g51Q8LTzW6rzpYEaUOhRaNbqy15Dx+DFwt4znhNLP/gk2fQDW2toJrgbcDQEZesRLO6tRzd4kly6UDqDMAtPk64oV+k5qkxTPdXHGvmbV11r+DGirKlTf7zqGNadZw+CMwHsTl8I5STnuub5pdfE71uOLUj+IYmuaFNMphjqTMjwz8e6Bi+S18fbaT5NSis6gvEVAuduTPFmrFKKXfsbZgzJYsctMJnQqr5qQ4F6owA1ywpUDqat3LO1aaN/pJx54NpVoiK0nUsyOdYYLxu8v8MxPMiStVPdy8fg5AEnpjlwiQj/93dvHGtgfm7ELuHjIl2FBO2w/ZhV8QYpznlE/06nNE/b7bswVv1doKiqu+PuekhNPNDLA02i8Lhd4Bb/kkYeWa9QPYQvEX9+a89oMwfUXbfoTs2q2N6U2wRkDr7qRkxRWNofsRHoxL1CqAp7u/+7HiYxLN71C8oTSogUxLlnuOBJ9vDcSZHs4tbN4n+IEQCb1IMMJRnvKQWCasHeQvy2KO3E+Mj9Z7ah8fU2VCE+Wg5YyuC/yATZwML8xZz1XV1Y/DwGPwaEI8SEDa+1lxb7ymV9KGrcjH+R4chCF5UhxhqQ5fqGbxiI4c7LdwNn/G/T0h+m0BUSEzurBHtJJYhMCNb0V8q/hgwz/uqAckEMavZGr9Pr1ItCU8ERxdwL10iXcfmeuale0kTdBVWv2t0+tOn11COygvTQ+62h8nMwJyo+bzA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXM4OGpGbkI2Si94VEdwbnhKTkZiTWZzSlUrWTk2cGpta0gzVlRUcnNoSzBo?=
 =?utf-8?B?TlRqc3JUc1YrMjdPcm1XRUJkeXlxcFY5VkhHNGNUcmdtdVcyb3NFWWx4a3NI?=
 =?utf-8?B?MUR6RWRpVlMwUmRpanVOejR3MitVTGZ3RUVrTUo5L0I3Z0l0eXVycGYzWXJh?=
 =?utf-8?B?aDBSTTVhMjNoOUJ0czFJVURlNnVMajh0SEZLQXg2VDJqandYeDdrbWcvaTM5?=
 =?utf-8?B?UlFQNUJPSTRCemxYNW04VGR1cGZKOERNb0ZwRDYyWm53QjZlOVY3MFlERzVh?=
 =?utf-8?B?TkJWazVyeGZ0dVRuRDdqNnVOWWRnTmt0OEwySm9iSXFHdEw1cTkyWUE3L1pt?=
 =?utf-8?B?QkVYVzRDRlNYU0tvdkE0Tm96SmYxaTJZV2Znd085UUtrY1NheVhHZHVLRVIz?=
 =?utf-8?B?M05hK1lHTGtkWnQ1eS85Tm5UUG5zTFhmMXp2bUZiY1RPZHFneVZRTEx1b3k0?=
 =?utf-8?B?KzR6WXk1TkNheXB3Q3ZZK21uYkdKWk1rNmZCMU5ZNWRNbGJaUWhXOFB3aFc0?=
 =?utf-8?B?U2Q1bzBhNnMyOFNvRnp5Uit6WE1OWkxndkhvaTUwRFF5NkN2VnhCVEwvU2RZ?=
 =?utf-8?B?a3pUclUzcHAvSDU2TFJPN3JMZjVDbDlpM3YyOTB1ZzVyRTVCQXdnL1FjcjIv?=
 =?utf-8?B?VlRTTHg0WFpTV0ZGeXhvaU5sNnNrMUc2MHBsY0V3UHJXSlMvOTVFNUZYcVh2?=
 =?utf-8?B?KytVRFhlcGM5Qk9zUXhjVEtyU1VYdzVXN2RURjFvbTJzaWdBbDZYMHFRb3hO?=
 =?utf-8?B?Y2krTW5EbHFZRGZ2RXJ1QUxzc1RzNzhGaXVlL05idXpVbnFTelhCeWR6eTBF?=
 =?utf-8?B?NFF3RHQxVWc4TnhML0JHandqVDVHYXZTek1uUEtpMzFEYS90MFg4VlhCQTJ0?=
 =?utf-8?B?YXNQeFl0NVFud0NVQnZGVEFrN0lpa3kyQUxBVFkrUWRFeW1YRTFkUmhvMVEx?=
 =?utf-8?B?UDQvQWRjMkptV2FRL3ZnRmllVVJMUzc0Sy9mRjl4Nmd5ZGNsYjRkRjZjOUxw?=
 =?utf-8?B?bEJKT2NqKzZ3bTZQWkc1YS9Nem80aUVNZ01lRmJEdm5OUVVpRHQ5WDc4QURF?=
 =?utf-8?B?dDhlZjVic3kvOGtxd1pTdzhjRzlWYjR4aFN0SVZlQStqTzdzZjBEUDhoR2FK?=
 =?utf-8?B?aDBONDFwTFVpVkdBM2FlMk5mVnFTc2xCNGNVclFKV0VvTVEyUnpYU0o3L3VM?=
 =?utf-8?B?ejB2bXljbDVMSkdaQ08vQ3cvajlJNmhvazRxV3EycmRsSzY5WFBDdzBQc3k4?=
 =?utf-8?B?dmxsTTJqanFYa3FrbkdKQU9DY0o1RWZkcUtIaVJlUnFzTjVrcmd3VHRsNUc2?=
 =?utf-8?B?d3B0TXVweUN2elllNEZyaTUxb2V4SDR0MUZWYVVKamV4c1M1KzFJVjUwamtN?=
 =?utf-8?B?bkRPOHl4U2wwSDFNbno2OStLN0VPZEw1ZmM3b3NQMUtiY1RWWnhNUUswSUVZ?=
 =?utf-8?B?bmUxQXpDTjBrUFY3VUdNTG10ZFdOQ3dKeFBFMDFVSHNTQ0Nmc0tpWkxGTXVG?=
 =?utf-8?B?MS9NQ2RjcC9SUW8vb2FWeUZYdkZPbXV3QmlqSFZPdktUSnQ3YVViQnhyT0NO?=
 =?utf-8?B?NmwzMmtQcEFDRFR1cW1KeWxKMWhQOW96V0FjWVhmUkwxNXg2SXEwbUJFUXlG?=
 =?utf-8?B?MU5xUDk5U2RTU0xsWEFQdk55QkxTYTRpRnlkaS9OOVQxQVVXbndzNzB5eTlu?=
 =?utf-8?B?VEtML1c5MEpYYmJtUHBhcDkvMFNZRkpYME5uai9QbFNJQlVHWWxVWmtzUjJl?=
 =?utf-8?B?QngxcUlBTm5KSk8rem9wVE5SNFEwOXdYZ2srMFlnbzJVK2h6TVh6aU9OMzA1?=
 =?utf-8?B?Tzk5K3FwckJiU1hnSEM0ejVHKzNuZERxVlFmMldFRmY3M2hucEszR2tmMmNy?=
 =?utf-8?B?TldFVkdTS2dzaGlGVHhrSlRHd0JqQkF0ZU8zbjJJNFNkdEFucGQvYWFJZHFl?=
 =?utf-8?B?bWFPMW56VUNUZjMycE5GUzlLUGhiajU2OWNqSHVYaVY1L0h3NVFJSE9oK0dR?=
 =?utf-8?B?R2JkOTNxNXBjd2dzeWcxNkhzMEw0SHFGQ2NIaWFSRktQUUNBenVsZjdkMEY0?=
 =?utf-8?B?ZXJDNXB1TEN0ZTdTK0MxRng3MEoyQkRsN1NSWkFCY2dDbkhWZzFDSUVyUWQw?=
 =?utf-8?B?QzNGbHVMc2dHcmpFdW85U25nODhZTmdwVWpxSWJiVTl4d2hnbi92UWhnY09G?=
 =?utf-8?B?SUV3TUYvZm10d3BaNE40Skk5Y0RodzMwMlNwL3pUWnYyNTFVaU1HTGpCMmov?=
 =?utf-8?B?MlB1Y25lOXBPSEc5ak1xb2p2SFpOdWdpMlBuQjNWQ2l5TjZCQVVySnY1L1dV?=
 =?utf-8?B?VG1iRGlBcFJkZDNxdUlYNlB3dThrM3RjSmVFK2M5L1ZUNVU2c3FPQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac95ba7-8321-4ebf-a39b-08de9d59c8c4
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 14:50:08.1874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eR6DEhydTaHBzaWkzhvEILD/sjyOGIusNlkU/mRKTHIiA0TDf7gdZ5cmNUyCO6AwiW3V5RdIbBHmFNFvx2yDFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279509-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 55D76421621
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 11:27:06AM +0530, Ujjal Roy wrote:
> On Mon, Apr 13, 2026 at 2:18 PM Ido Schimmel <idosch@nvidia.com> wrote:
> >
> > See some comments below, but note that net-next is closed:
> >
> > https://lore.kernel.org/netdev/20260412142250.131bf997@kernel.org/
> >
> > So you can either wait with v5 until it is open again or post it as RFC
> > so that we can at least review (but not merge) it while net-next is
> > closed.
> 
> Let me clear the changes asked here inline, so that I will be prepared
> with v5 until net-next is open. You can ask me to send it as RFC v5,
> if you have doubts about inline answers.

I checked the proposed changes and they look fine to me.

Thanks

