Return-Path: <netdev+bounces-299597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HwmdJXZZMGrkRwUAu9opvQ
	(envelope-from <netdev+bounces-299597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:58:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE613689A27
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:58:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=RMOcAB4s;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299597-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299597-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0655D301AB9B
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596E53B4EAA;
	Mon, 15 Jun 2026 19:58:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244230D3ED
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 19:58:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553524; cv=fail; b=MNhF2PaCQMNC16kE18VMQ/zUd9BLHs6W7kNZH8xbfi4O1j7nJTnPLE1RrFRDVTwS/ypafnQO6iVmnMHpgQraji+irHQvOkvZPHlMttroVlwKI7AtnFBYpOjQDh10t4s6kAfR7TjK6GWmOzoYWVW/A0GW7pgq3+HlKz521KyD3BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553524; c=relaxed/simple;
	bh=yquAH5jpWEEO9zqAsKiYq756jLqnlRjq2v3E+qfMX1U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QHDq6V2QVF1u8eOa0/1Bo0waFulrtBCwx7gykLYEaLS8JFj2nrjMaQbxtiFnVo1SKrFnanyXMeDGFNI6f4SiOwNfoodef92gF03Ycuotw/5+cgP99YfL0FcMBHLF3vfhPuHpTAgLuGEjyQx3yKoKr0MtdurU7/Ub5ZfGZhmoMHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RMOcAB4s; arc=fail smtp.client-ip=52.101.61.36
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYVkw1pAmjvad7vfC2FtUtH9IlYjioLe4ntF8bMbILrvlsQEYKzYokAiz4ryRli3tlXrlDKIoNoja7BPu/A961j+0iEfYQp70qZzCBppPGBb/9JdP8GnafUc4f3p6eZtDoiNhblgGEI1juC+wY43JmUbEXyzCCon6roqunwlfGQgPlteZpq5Ak+MxRcHL4PMjUk7W1qcZ5z5XnIK5qIVKQxacs7Iv9HDItKzUkYpiL4v4WVfP29gpb5oSqJaUcJFvck2EBmjgE/oiBFX557aYijwEsPyCkyLyPzew3TvDaWXJw9VOq897vKVxknCSGsE2vSeHXuGizsrCLngA3UR5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJpHJpfISUntRnVpcoHJGClHopL/7fjdH7B9AC9pCKw=;
 b=SmiFG6KALrteUQwjkrShn02RbrV8ezjxrBUXajHD9foA18GlY8RQpS9j6C/rgVkCRkghutte32alFObvD1hJ3ZuYd/6t+TU5PRvpLFWymUw85wE/cxyvB4SgoYSqYw/36LQvp5Ax5OI48lVxl524+zPO1lOVJ29X2efJXE160wunKGhCXgenGJ4rZf6fNt/kwXB2VytqYG2jYxhVRq1vv/KWWm21ekurDTX3fV+/twu75EqVXOMJNqpPvcrqyZhqbwZsVE6Zimo3URnxzGDu2XUPFg64njmHwfs/rn3ONYwk2dVC5CKYi+ATzb0Ijir6KcDn/flPPnwADEWbzYtlEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJpHJpfISUntRnVpcoHJGClHopL/7fjdH7B9AC9pCKw=;
 b=RMOcAB4sNx1lg5O8rnGgF7xtlDIJUG602fURWqTFJKrD/9PPy4acT+jN7vvpHKtu4WF+a/ulVog155SxYC42W05rZCaNcr4xj2C9JQCA+sbv0Up6OLtUBpYIlG66opY29UmXhZnG4PVVRhDeAToJpKF3bqK8mL3PK3rUdGpgkfA=
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by DSWPR12MB999178.namprd12.prod.outlook.com (2603:10b6:8:36f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Mon, 15 Jun
 2026 19:58:40 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 19:58:39 +0000
Message-ID: <44448066-0b2e-4b10-880a-96f6b8c5ecfa@amd.com>
Date: Mon, 15 Jun 2026 12:58:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] pds_core: add PLDM component info display
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, eric.joyner@amd.com, nikhil.rao@amd.com
References: <20260614050052.1048328-5-nikhil.rao@amd.com>
 <20260615160842.776643-4-horms@kernel.org>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <20260615160842.776643-4-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::34) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|DSWPR12MB999178:EE_
X-MS-Office365-Filtering-Correlation-Id: aa491220-4f24-462f-d837-08decb187e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|22082099003|56012099006|18002099003|4143699003|6133799003|5023799004|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	ITKzTsNjnGLf0Te7IiFmh0M765hbb8BM+0C+/VvNBoiugImrKug9sbJqcZByPH/G3cWbE0G7sqL1P1KpzkXGtZWDZmKUWg1YyK19xaBYY59agbN4OtkK43EuyXeDhNgF+ORG53pIAfe7p0xiSGmKqSUC1yq1ZR0UVvE9O/BKmv9oHxd12r+bJk5wnKc/LPNwvMe++cOXv+55UO4/woZvFSXK5ZEHsPXxzu0+GsZRmcc9rqaIeQ6lIJZf3nTWm8x7nEevNAumbaJM8vMlDA1m/xZCBFEH+ZI5jG85v7sH0d407qpl83fGEaDkw4FRAZuCkXUUmGu06kFH+pEkRFMycuH5284LHc6rnkdcs3C0dAqatZb3TIf3CT0EcmbJDnTQwXJQvY9xW00NF0NuIAkfcXbjQDNsY1WIvCO7T7gQnMAmLgNmvKSrSi81JuhMLkqeXCTDe4Ofz9iXS46vh7iBGL3WGH0upVTXlE6CK0spOFFOZBZsYcEYTrB582e1smDoj+Xxuz/cdRpTqamlNq9C0ah+P3SN9Og6LRpn7avpIe+Qr1LSEqfMjXcyrMf758Dq4MFGDa4gQiwMKjUGD7mN3CDW2iWH9qN6f6yRjEgAG51RZAVUeCsd7TizXnufB6rjsaZ1yVi8KoDsXSvaXvvlcg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(56012099006)(18002099003)(4143699003)(6133799003)(5023799004)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mmx4UGpCeUtYbW1Xd0dMY0prWTBpM1hCWGxqNjVQSC83aldCc2d4K0pGeXdl?=
 =?utf-8?B?Mk94THJ6dTU0Y0Q1REV3SkowTENtaUQ1R3RmVkIveGZyS3dRNzUrSXNkZVJQ?=
 =?utf-8?B?cUcyL3hCamc0RkE0RUpNallwZmRwSG91S3JzSjVuM3JCSnNtbDBSbDByZmJL?=
 =?utf-8?B?VmkvUHd5NkM3ajQrSmNCMmdRQ2Q0dUdTNDl6VFhuZUs0ODVVWFI3SmFrUmo1?=
 =?utf-8?B?eDRVblFRalpPcjdmbjdQUjkvMmxId2hxVGVmMVp5Y1M1bWtSWFdnYktxM2wy?=
 =?utf-8?B?aHJ3NG1Rbk51NGM0Rk9vemljZ3NpYjM4bXIvbnJ1aVdHOUlrYzBtNlp3UHpw?=
 =?utf-8?B?WCtvam9iL3FpbExSTDhXanc5QVFDbElkekx2TXBiNnNiSUtXaWkydnpVV1gx?=
 =?utf-8?B?VFNwTFNHc2diTjVsVlFDYm9OQSttQkRJZjNteTlPUkNIQndDcW1jQ3I2cm1p?=
 =?utf-8?B?UTdxSlVsUHJUMHFSRWJjT2V4QnZ1Tkp0UGF5alBxeE1MdUdsZHZBOFZYc2Qw?=
 =?utf-8?B?bGhKUW5KU3ZQOVlqcGU0Tnp0MXEvaVo2bmdXemlVWGRTcXR6OHlSL2dXRHJy?=
 =?utf-8?B?N2ZFdGVUeGxWMW5PeEwvTFhXMjhUbzBleTkrUGUzRzVtSjd2d0lCaTZhK1NL?=
 =?utf-8?B?VkNMMFdPVzZ3MjdnT2lxd1RlK25tbGtUWGZzOFpDSE9qSlkvVXpBWVdsSm9K?=
 =?utf-8?B?dmxFdFZNZTlUVTB6RXR5U2thUVJ2MXVZc2FYOWNxM0tiQ2sxYVV3ZkVLT1NT?=
 =?utf-8?B?QW5mdTRqN1hlNzdMSXhHK2I2TUMzMUMvMjA5OUJmZkVUZ1FRTFVwcWVUS0ds?=
 =?utf-8?B?T0NJblBwUU5iVkcveThoV0thQysvbityeThFT2NXdjluYitpeG9nRHhZd1Vr?=
 =?utf-8?B?NldtTU1xaDhZRWRQRDg4dDVaR1lZaUxxd0FSMC9HQ0ZEa0YxN1ZCRHpjUy8y?=
 =?utf-8?B?ekxiUmdJSHJsK2JWWjBZSXBJZHJqRG90R1R6N2RVSWZRYWp0UktreHMzUERK?=
 =?utf-8?B?QXdDRmNnTmk0aUNpbFM5YncwRGJ0aHl4NDQ1b2lyNCtHU09ZU2JZZ0w4WktT?=
 =?utf-8?B?dDkrcXIxa2d5SElyaWpkUjU2REtCQ3ZWbWpoMDNlVytQVlNJdDFid2hrWWUy?=
 =?utf-8?B?WkY5U2FsZ2dZMlFHd0tQTEpwdyszRVZYd2hrdUNQb05nSHFrNzB4RHQwOUxZ?=
 =?utf-8?B?ZmVRU0RkMmRwWkNjUHdwdm9JZ0cveUJSa2tUZTIwc3JVWU9tbDF6bDBGVjFJ?=
 =?utf-8?B?bDhDYVBrQ1hydEplM2E5ZkJNa0tmd3ZuWnlrclA4bENXZnBvazhiUEJwQjNK?=
 =?utf-8?B?dmtheVNmKzNjMHh0Y29zTGFBVWJSOXUxcnF1Uzl2ejNuWUsyb0JOaHVYTTJP?=
 =?utf-8?B?L0g4QUU3L244dFBCYTBDb2RaVC8xa0JJOTVhUFEyWGFrM1o5ckV2ZWVhdE9s?=
 =?utf-8?B?b1F1Nm5MOTAyeWQrTkRTeWtPR3ArVlFJTi85SVlsRWdFOTg4a2F3WlNFUDZa?=
 =?utf-8?B?WWpYbjlya1hTUDcxYWFjTHhiQzMvQUVLajQ5dy9KTEJCeGYzK3gyZmJ5eklw?=
 =?utf-8?B?M3piWWJ5bzFNUjc1cG53WDF3cVR5K2o2YnlEdkhtNUQvWDFjalJNdWlyYkNi?=
 =?utf-8?B?dnVqa0dUakszMnh2c29YWnl5Ump2eVZJOFYvWHVLRDJLby8ybWxGOTU4Q1hs?=
 =?utf-8?B?K3RabklEdlBLU21RaUZOVUFaV0lEd1ZwditIM295U3BVNzdaVFhrZGdNTlI2?=
 =?utf-8?B?RFdMQzFFV1REb3lnK0ZyMmpUNzZKMzVYTW00RC9LMHVkUUg5Tm5YQ2hzanZM?=
 =?utf-8?B?NTZIMHZtRENFT1VXRFNEa1B4cmg5QXJ6M2N3QXlDbW80UkdPMkhhbnp0Tmk2?=
 =?utf-8?B?V1NpU093Zzl0QnAxWnVJSW45bnppV0lRYTRmSGVrWE15azQ5N0xxV1cyaUM2?=
 =?utf-8?B?MWkxTzh1NWhqbS81aXZaSUk5bjk3ZUo0d2pNRU1MM2FnYWJoa2lIcUNXSHBz?=
 =?utf-8?B?VEQ5M041aWY3UzJ3OWRvMTNZYU9TbU90WnY2NnE0anJhUmZNRkVDbHRZdTY1?=
 =?utf-8?B?VUw5SHJuWWgvSzBYMmlUUE1wdi9LZFpVNGwzV2krVmU3dmpJbXlKRnVqUi9R?=
 =?utf-8?B?ZmhwanR1cnNhdkdMVlhGRkpnOTcxNjRzdXp4VjltZzFkZS91OStRMDhCa3dy?=
 =?utf-8?B?Uk1keFduQm1UVVJzSXFnRUE5WUVQN2tnem1ZMkhMS3AyV0lBbVBrRG8remJT?=
 =?utf-8?B?MW5mTXVyWTQvbFdVM0tOS3AveHFEQzBzbXBoWDk2VWkva3VLQ3B2RWJIRWU1?=
 =?utf-8?B?SFZ6MGlIQUpTVmMxK0h4M2hhWjFPUWJSblRGK013MXoyZTF0MitGdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa491220-4f24-462f-d837-08decb187e80
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 19:58:39.7322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvszLdi2LclAwjOmlKZyZEt11ODqvFhQc/Vx8G216Os71D7YzMmg8KM03sQwIQ7r1fpLDsvHoaRcElVjkceDkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999178
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299597-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:dkim,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE613689A27


On 6/15/2026 9:08 AM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> 
> Simon says: This review seems to be a bit of a mixed bag.
>              I've annotated the issues it raises that I'd appreciate
>              you looking over, and the rest, which I don't feel fall
>              in that category.
> ---
> pds_core: add PLDM component info display
> 
> This patch reports per-component firmware versions through devlink info on
> v2+ devices, replacing the single fw running version with names derived
> from the firmware-supplied component list and slot/flag fields.
> 
> Simon says: I'm not particularly concerned about the issue raised below -
>              I'm forwarding this review because of others raised further down.

Thanks for the review. Responding to the issues you flagged as 
warranting investigation below. I'm also addressing patch reordering and 
v2-error-handling in v5.

> Simon says: However, the issue flagged below seems to warrant
>              investigation in the context of this patch-set.
> 
> Second, pdsc->fw_components is only invalidated at the end of
> pdsc_firmware_update() ("pdsc->fw_components.num_components = 0;").
> If firmware versions change through any other path (FW recovery via
> health_work, PCI reset via pci_reset_work, side-channel upgrade) the
> cached list stays around and devlink dev info reports stale versions.
> Should those reset paths also clear pdsc->fw_components?

Valid concern. Will add a pdsc_fw_components_invalidate() helper in v5 
and call it from recovery and reset paths.


> Simon says: Likewise, the one below seems to warrant investigation too.
> 
> [Medium]
> num_components has already been bounded against
> PDS_CORE_FW_COMPONENT_LIST_LEN inside pdsc_get_component_info().
> max_fw_slots looks like a slot count (gold/main-a/main-b), but the
> component list also contains cpld/bootloader/uboot/etc.  If firmware
> reports six components on a three-slot device, this min_t() silently
> truncates legitimate component entries from the devlink output.
> 
> Is this cap intentional, and if so should truncation be logged?  If
> not, can the cap simply be dropped?

The field name max_fw_slots is misleading - firmware populates it with 
the component count, not a slot count. Will clean up the comment in v5. 
The min_t() is correct - it bounds against the number of components 
firmware reports.

> 
> Simon says: Again, the one below seems to warrant investigation.
> 
> [Medium]
> Pre-patch, devlink_info_version_stored_put() failures inside the fw
> list loop returned to the devlink layer immediately.  After this
> refactor, pdsc_dl_fw_list_info_get() returns the error but
> pdsc_dl_info_get_v1() converts it to dev_warn_once() and continues to
> append the running fw version and the ASIC fields.
> 
> Does this mean a mid-loop failure (for example -EMSGSIZE from netlink
> attribute append) is now masked, leaving a partially populated devlink
> info reply that gets reported as success?

Valid bug. The refactor unintentionally changed v1 error handling. 
Pre-patch, devlink_*() errors returned immediately. Will restore 
original v1 behavior in v5 - propagate errors from 
pdsc_dl_fw_list_info_get().

> Simon says: but this one seems to be more a question of style that substance.
> 
> [Medium]
> On v2+ devices, errors from pdsc_dl_component_info_get() are swallowed
> into dev_warn_once() and the function falls through to the ASIC
> fields.  Pre-patch behavior always reported pdsc->dev_info.fw_version
> via DEVLINK_INFO_VERSION_GENERIC_FW.
> 
> After this change, transient failures inside pdsc_get_component_info()
> (DMA mapping failure, -ENOMEM, the -ETIMEDOUT/-EAGAIN deferred-DMA
> path, the v0-firmware return-0-without-populating branch, the
> num_components > LIST_LEN -ENOMEM branch), or even firmware enumerating
> components without setting PDS_CORE_FW_COMPONENT_INFO_F_RUNNING on the
> MAIN component, cause devlink dev info to show only asic.id, asic.rev
> and the serial number with no firmware version reported at all.
> 
> Could the v2 path either retain the unconditional running fw fallback
> from dev_info.fw_version, or fall through to pdsc_dl_info_get_v1() on
> failure, so devlink info never silently loses the fw running version?
> 
> Also, since dev_warn_once() suppresses the warning across the lifetime
> of the device, callers cannot tell that the netlink reply is partial:
> a partially populated message gets the ASIC fields appended and is
> reported as success.
> 

For the v2 error handling: will propagate devlink errors (so partial 
replies are discarded) and add a fallback to dev_info.fw_version if 
component info fails.

Thanks,
Nikhil

