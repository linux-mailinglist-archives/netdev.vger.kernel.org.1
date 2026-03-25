Return-Path: <netdev+bounces-271730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IltHT9CxGlHxwQAu9opvQ
	(envelope-from <netdev+bounces-271730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:14:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB70232BB54
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DAA4307C258
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F15368961;
	Wed, 25 Mar 2026 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KBNxdokK"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200DD33B95E
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 20:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469533; cv=fail; b=QuaY1qkPMVQ+hS1JRL4b3lyuOSfvdRhHMhlE4WiJR4vhz3oCQqUeB3T7znT52UlV8g14iAcq30JW2dqdQT3F1BS+ADCQ3v3g6Os9zI7ttfdw6Evl0axt2BYwO22XonEf/vIsjhdhky60/BUn1PVcJ/dERjVV5xhE0uklU/ykGtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469533; c=relaxed/simple;
	bh=34W1PeA/dlcGSrwA1dRnfzFL5+QoQMXY3eT/QyK5NcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zq7IKXW/B7yOCsPFMlud4eSv/iDiYF4VKFVP3oVr0vQQBqdcSj+B0XaaMCE+bLOe5Y0hjcQFTvXliN/OyBUdhKYBfoFBG0BinLt/5QP1CuLpQzqSJebcd3AHgn5IcvbjVF+D41QD1Qn+1j/40MwviMkmnYHm3YpZbn7mNd21r7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KBNxdokK; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyKfHlM/PPueC6nuBWpm7KbEttgN7voLf1SWMN+G9exVsbaoTCDRKfN9Pv6UY5GcVHRb3rvUjh9EcpMm4z6eOfNrpZwz3XrGVyNYgh4KikdDNHucdQjw6L70UVV/38s0jQic9BWHLZoZTw2Iifk6f1q7gHS4VdZGltF36Egsfgx+TrtmpQx28IfRSUiKkVl2FBaoKdcqf2gNKAyepIJsJiyH/q61no61s29Gzf9n21v/oWXh5jGmNw+y97jtpWXUcjDBST8e7xowtiLQYKO44uoIzOlCZVrEEHog36f8Dwft/XcBYYfzFfH4cYwqO7eWGVTpcCFJXJpIRnlduVigKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Cvw93fB6XRbeffzPbUsNcUeSqUfyE0p/TpZvACLm8o=;
 b=UKbU32/cLR5ZtqzgjL7rHAcOr0/FnFxG4ZKMse1qt74beq1BOHohOQo234g1gf9vdXCrwmQeY1Oe3sJ+16MmovC7+MOB9A67hSvX5h5fXEziAcKyT7MynWSg8leg/x2EYYxVt1ew5rBQw3FLTtKAQk5DKEh37artHcjjoT4rqYCi8mb1DWUIsvTyzXAE9RH7stxOJ3AGv63UY7D9WWAqT8LZa45vhx/w9yZOCfxjzI+R8NJqa08hvEWqj65bEq7UAwDswnHJQEqpjZvV2BsMeTg8JYY2nDgvToitXwxYJ0JVIgC+V3WgNU27QeztagmGIqmOFYIEr2Tvxj8a3o9tEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Cvw93fB6XRbeffzPbUsNcUeSqUfyE0p/TpZvACLm8o=;
 b=KBNxdokKNO/4t9cACYjhVxiVhLVp8ciDjbSmv+E/GRoj1om7OTBRLbaaD2hf3DptuBTrBApqhjvUd7qa0RY1jKoEKyS3ulfHKCRWCkdw9yb2Kmq1UlD0vie1WuDDAqYZC2sUUljqHMrxOzvVHoDHA3ceWnTr8XBBqATIVTZDI62Ntmklj3Hd/8/DoJdGHucI0vmGs04tEihIm/puZZOeepnspRa2TwvQT8f/gmF4OfpAckyYIepsvtMCebbY4UZCDrTQZjoJNxDCLDjiGmCOePYk/0ST3+Sa/hRXWfv5F3U+3i7oLsvy8/RCD4FMFofnYRxbqtjHgiUp8cNpOHFgVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 20:12:05 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9745.007; Wed, 25 Mar 2026
 20:12:05 +0000
Date: Wed, 25 Mar 2026 22:11:55 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, dsahern@kernel.org
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, petrm@nvidia.com, lirongqing@baidu.com
Subject: Re: [PATCH net-next 3/3] vrf: Remove unnecessary synchronize_rcu()
 invocations
Message-ID: <20260325201155.GA909880@shredder>
References: <20260324155521.525292-1-idosch@nvidia.com>
 <20260324155521.525292-4-idosch@nvidia.com>
 <CANn89iJ9hD3vBiViEz886sVwuqQVbaocnE0UJHZMhchFHKiM-w@mail.gmail.com>
 <1ea4c187-9c1f-4e15-b472-07a82abd3260@kernel.org>
 <20260325144228.GA686135@shredder>
 <CANn89iJ9MQ_3af3XiNAGQWwr-t1kF=E-mKmu6h-XVDVyi7c4mA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJ9MQ_3af3XiNAGQWwr-t1kF=E-mKmu6h-XVDVyi7c4mA@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: f42ca08f-69a8-42ee-9655-08de8aaac8ce
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RaHoex7phukQrbZ6Os9wBJ5/AZUamPYb0jhzB/e5qHkBq/Nez3Hy8AtpNYdgPyBIzPZxsdocgn9qVDtTdkJMwIlhJxqLrTMiMxdlw53QpgmHgYSQrHyAdEl82y6jFnEGNO0Pn0/mA4B5XZYw39xEUi4JJlZQ3x55QheWgBlevUnuMbxajHt8gI8J+UsGVRuSxF5TUqsQpvA5XUXKQpYPONMbwz18RKYpyp624a0JUSTrZqMO8rRnbyZgY7VJbC3jEMyp6Bjd0pvyU0XP/b0SttMcc9369ieyGN2nXjokGSMt6dgyKrr29wDLGNJtQNxTPmumGFMWp/tyY8MJ8yiaombdf1atqY9Eei7FzSrOWvfSExgwYMHn1b7+ZJs8WPdkZJOrbK2KbxKduOlVNT50k5s428RnTS6IVUP1bq835xyDQrTcu8gIK3bQZI9G6+2e/BhzZ91IkV0GvkDnDBoSQJ41qBrMxwszMo1gAs4F4xjpk+6hLA3Pn7mCd3caFQSxwTNl6Zc+ei+wrcuF4poilo/gLhQFLh5BG7EHRUgnUBb+mxRphRfmBZyu3RJzL56H8SIphwoYluhlarz4Fxtpfvi+uDCfvLKrbc7E+YZHE/PHFPOO6pA4s3wh9fUiqFhheEVX5OEKWVuImEDbQWC+uZHww2bclDqM66jc1IMxKV7zm14kbbH3KZWde1lQkWhQjbJG833mdW95gWXdlgGBCwsjm3FdihPM9pN0ueAFcU1yMQhRk/siJVOhD+GIZREk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlJEaExTTHBnM1lGOVhENVgzMTJMeG1TWktXdWpBSWhqUWpkOFd5UnBWdUpj?=
 =?utf-8?B?Q3lzZjRVRy96NDdwby9YTGIxN2dkOXFSSWlEdXk0UWdkdDRjNmNWWjFqSFVE?=
 =?utf-8?B?ZGZoQWd4NmVqWktGTUxqZjlZV2s5ZmpvV0kvS1BwQWRHTXpUSGlQOEJLSitt?=
 =?utf-8?B?aW92NFA5NTNoMU9uNlZpODVsY0dSbVE5MW5CWFoybUtXVTA3YktYamcxM2I4?=
 =?utf-8?B?T0VPazNuSG5yekZJcTlBOHhBT1RsV01YbWxjWkJZb3pRUlpHalFtdyt4aDVp?=
 =?utf-8?B?YVBmTFRnLzZVTWQ1RDhJZ3dLd2M0Q0FOYjE0dWNmWTRaZ2ozSDJqZ3hLSEY5?=
 =?utf-8?B?cmE5N3UzNHIybEdLekhTMTZlQ2RlenB6dllBaUpId215bERkR2gzTm9ORzVu?=
 =?utf-8?B?alNwcmcrN2gyTjdPeXpiM3BpQytsUWNvMlBsL1FyRklFbWZuZC9TVFVzalk1?=
 =?utf-8?B?SjJtR0trdVBTM2Ftd3JOeUNPdThCMmZIczQrK2V0dGNHdU5ncVk0ODBZSWdG?=
 =?utf-8?B?SWxzR05vRXFlOTZCcFVwazBId2MyYnVyZjMwK01zTFVDODZuNm1XbHhUektT?=
 =?utf-8?B?UWRIZ25Yd0c1Q2lTZW91WGYvczdsV3diaWVIbys2YUx5SzZJSVRLOWRyeHMr?=
 =?utf-8?B?RndDalkzM2ZaR0hEUW5vSEwzREFSc25PMFJ6ZGVDZlFCVy8xRVNNMzM2VGlZ?=
 =?utf-8?B?NjVwbVlRQkJuME9IazM1NHFhd3pBTEdXdUxsMDFwMGFpK3M4QjVJRGg3RDhE?=
 =?utf-8?B?U2ZiS2dVL3dmQ2tyU2JGK0lYNjJncWlFS2RSVmxmNHZWOXBVcUF3QjIwTmE4?=
 =?utf-8?B?aG9Ya2VZN2hmMFRhYjBjMDFLTkthdkQzeFZQSGhWV0l5Wi9KdFpES251OW9X?=
 =?utf-8?B?cW84OFJ1Z3p3cnZSVHYrTUx3bURVeVZMRWh3MVVZaXVtZjkxK3c2Z2pLdkF6?=
 =?utf-8?B?dlNuK2lFcVU1Mis1dGlqZkI3OW1ObHhSdnBJWXdwa0laazhwY3Nacy9Tc1M5?=
 =?utf-8?B?bVZ1Mm4zanlUWjlyelkyVUNFL0g2b09BM3ZzckZpejc3NlMya3VDcWtFZU1w?=
 =?utf-8?B?TWEwQnNrM2FZWGprN1Q2Z3luL0p4b3BPUXN3aTh2UURqSjB0UEoyVTRyM0w5?=
 =?utf-8?B?Vi9waGttdlJQL3JXcDVBYS9zSFE0WlZVaFdWRGU0a2NJRVFCNzRyVXI2b3U1?=
 =?utf-8?B?Nm9yQ1lCNWZUWG9MU3k1VEJLdCtNU1RvZVdUWmQvaCs5SHZLSXRUMlA3NGhP?=
 =?utf-8?B?RHcrcHBjNFJqSm5nUmhaZHovY3VuQnVYYXk2a1ZYMllJa2gxdEU2N0tKdC9C?=
 =?utf-8?B?a2JMWXRXU2dJZU1kK0ZyN0tTVE1PL0dOY0dhZzFKMHFZZXhaUzhyL1puUTlD?=
 =?utf-8?B?Z3VwK0JlRzNQS0JrSjBKN2xROU5FOTllYXBRZStOV2JMWGRJQjg3SThnZUFF?=
 =?utf-8?B?TGhyNXdyc3FDQmZTR3NycTZ4YU9TZ21odis4WEJiK0k2VTRuZTRIejhLRUFm?=
 =?utf-8?B?dGlEbDB2NUtaTWwrU2pSNVdwVEdDOU0zWlZXOUVPVTJPNTg3djJNYllvbUJq?=
 =?utf-8?B?M3RqN0pudDVRUzBhbzRWQkdHMHNMTlBud240Ri9HZzB3NENhLzhuWGpGVFMr?=
 =?utf-8?B?eVJGS09xbkZIb2tESFA5alNPUzQwbXBCVGFDMElNNDk5ZnM5anZJaGZPTlUr?=
 =?utf-8?B?UUdIT1FVb0crK0ozWGRCdzE1K3ZSRFUzb1ZrTE9walZ3RnpxWWFQY2xrUGRX?=
 =?utf-8?B?OHpCb2JKVnhwdVpIVXJlM2xPRW9RK1hRRFlCOExnZU1NS1RSdSs1LzMvNzZT?=
 =?utf-8?B?NnhUb3Z3ZlZxZlZiZTVtalMyaTZJUEwrWDdVQ2tmTEFKakxCdTRqMjNiTVhy?=
 =?utf-8?B?MlNyaThkK3Y1NjcwdGE3OHVLcjNTYk5vUDNJUGNXREpaQUJhZzQvLzE3azIr?=
 =?utf-8?B?UTY2dEdveWlYVkZkbS95YmFHVUxtYTBZQm9sc3VTSmNWbTB5dUpmV2RoRzd6?=
 =?utf-8?B?aGkzSnlKcnpaclJpSjVpalhOUkV0QkZuVnoyUEtjNmkwTDNEK3RWdGk1dnpN?=
 =?utf-8?B?V2RTZHpZcFNEZmJKYzVXb2xiMUJjdG9sZ09GcTc4NGpuM29yZ1R5ek9NcEZ0?=
 =?utf-8?B?Q2RpT1Q0ZlBlRXlBZENyNmppMHI3R214bGNhQ211M210MTJvRU43QkNOM2lY?=
 =?utf-8?B?VGFMRVJETnhpZTl0OUZzb1lIekZsN0xWa0JaazczdVZkQTNqSlZ0d0QvUURW?=
 =?utf-8?B?RW8xUWEzRkxWN1NtSTU2UExnNE5nNWg3UzhLTXk5WSs1YTI1RWM5UXMvWExQ?=
 =?utf-8?B?QmpwYmMzcm9CV1JsSGZrL1ZOdXJnaFFBZ1ErSy8rcDUrbzFRZHQ1Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42ca08f-69a8-42ee-9655-08de8aaac8ce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 20:12:05.3269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2WEyY9m5UFQCyIPzaRS+y00htsVWn08/+zkiWHOQv39BWv5GvWRXUG1EkwhJ939KYkRdm23ykBtXLb4I1up+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866
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
	TAGGED_FROM(0.00)[bounces-271730-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: EB70232BB54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 07:57:37AM -0700, Eric Dumazet wrote:
> On Wed, Mar 25, 2026 at 7:42 AM Ido Schimmel <idosch@nvidia.com> wrote:
> >
> > On Wed, Mar 25, 2026 at 08:17:30AM -0600, David Ahern wrote:
> > > On 3/24/26 2:39 PM, Eric Dumazet wrote:
> > > > On Tue, Mar 24, 2026 at 8:56 AM Ido Schimmel <idosch@nvidia.com> wrote:
> > > >>
> > > >> vrf_rtable_release() and vrf_rt6_release() are called as part of the VRF
> > > >> device's ndo_uninit() callback. As such, an RCU grace period passes
> > > >> between the removal of the VRF slaves and the closing of the VRF device
> > > >> until these functions are invoked.
> > > >>
> > > >> Therefore, it should not be possible for any concurrent RCU readers to
> > > >> try and acquire a reference on the dst entry while we are potentially
> > > >> releasing the last reference via dst_release().
> > > >>
> > > >> Given the above, the synchronize_rcu() invocations in these functions
> > > >> seem unnecessary and only add unnecessary delay when deleting VRF
> > > >> devices. Remove them.
> > > >>
> > > >> Reviewed-by: Petr Machata <petrm@nvidia.com>
> > > >> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > > >> ---
> > > >>  drivers/net/vrf.c | 2 --
> > > >>  1 file changed, 2 deletions(-)
> > > >>
> > > >> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> > > >> index bfc9ea91ac20..75edb8eba87f 100644
> > > >> --- a/drivers/net/vrf.c
> > > >> +++ b/drivers/net/vrf.c
> > > >> @@ -753,7 +753,6 @@ static void vrf_rt6_release(struct net_device *dev, struct net_vrf *vrf)
> > > >>         struct rt6_info *rt6 = rtnl_dereference(vrf->rt6);
> > > >>
> > > >>         RCU_INIT_POINTER(vrf->rt6, NULL);
> > > >
> > > > We could argue that the vrf->rt6 clearing is not needed,
> > > > or should be done before the RCU grace period mentioned in the
> > > > changelog started ?
> > > >
> > >
> > > AIUI Ido's point is that the synchronize_net() in
> > > unregister_netdevice_many_notify() occurs before the ndo_uninit call
> > > making the synchronize_rcu here unnecessary. There is also a second
> > > synchronize_net after it.
> > >
> > > I get your point about skipping the clearing the poiniters.
> >
> > We can probably remove more code than just the synchronize_rcu() calls.
> > Looking into that right now.
> 
> This was a minor point, the synchronize_rcu() is far more interesting of course.

Did some more digging. I don't see a reason for keeping the dst pointers
RCU protected. I can replace patch #3 with the following one in v2:

https://github.com/idosch/linux/commit/3fbc1cad610df95cfcde117394c2c3d9e9a04e65.patch

