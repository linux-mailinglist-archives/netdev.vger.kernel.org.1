Return-Path: <netdev+bounces-295898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S6dbDIr7ImpQgAEAu9opvQ
	(envelope-from <netdev+bounces-295898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 18:38:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D9534649D85
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 18:38:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=MflzJ4AS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295898-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295898-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3F0A3003D17
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 16:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEB5416CFD;
	Fri,  5 Jun 2026 16:28:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6C630C610
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 16:28:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676912; cv=fail; b=gPLUMLhkkGLtypA9eWDrbiZHq4hK+M2TcCzMNFrObXnsUZQ4yZgVANy3zK+tHVqsILioLJ8VERmGt8ZxFhreuokRQBBh1361lbFBn8OpgDKG5GGpDwnhV7yUx84p1hn3oGL9fIMolMMcOTTNbXnJjwuclU4KNaRDcJhQCkqHsGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676912; c=relaxed/simple;
	bh=InEVdszLPneik4mR/7VYGoCtNXL6lShqN5edhnDv6OM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pU73mQVJfynXhfGvD5nA+qBw/FExXJbELMQzH6xuh3uabzoJQ/q4T0+HYeJWqdv9A7txYU2BPqqAp4Y+wQBHWQrXGCj37FRJ2aY0XMB8wy4mz1G5xbY6B+tn5X/l7XxJFFrAEX6h/QTQlUchE6fuXkgweM4FlO9DhLvD880eos8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MflzJ4AS; arc=fail smtp.client-ip=40.93.195.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXCbqd7bHyLpPuE+iCfT0VLbUKsaHcRsprRntb8JNzBB0LiP5fHVXeSxC+tP+grKZbFt4ZJpko6JzcCp3vz5VkNtHDu25RLHKdHKmfbgVEd4vRGrWfXLADRQ9IXAwT4ytyrQb1P5PnHipd09EphPasvEnQnpEzoLR7mfo8KnZaUvj1ZE8q5ZqRvPWZzUjsaG/9wna4SpBJZtSLvY4ojf3/To391QV7agsMrzn3KN4+RMVyomptRtytyAt53lt2pdcPy30iuKJXCPwl3V+YnHBKb4qicyosH0RphdUreeTf0/jxkWs6DSIksSR+MXM6qmPXnzfWwRY+J3lcrUH6entg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkvMZy2Xrodr9FZF4W8CfbggsW9WdlQZTbkf4jeQX44=;
 b=Y33D5FnaaA06rHirsHfwSoE+zUKu7QSDrig8vQWfQ97lsi7M9XRnxyylSCK/RCQjv6S1NfqE+CTR6cHusZUuVc1kN07es65PD6JDfwxRjADbxx68cWyonJCCxmobyJE1eiRyRtWKXYeHNT589eI4pBqUSSbP1ixP9L+FRfcA8sse50YL7cLrgY6oANx1awHE0LqwUpu5jHlg+PpvJ8qGqJSsSt1UpFOSwbC9KCmH8dp4p7sYy+3HCbVCxhYUqf7dhttEaxuGehOzl/w1uAPNo9TGs/ZiNvs18Pn0TfK5mRgVu8YDFTLepnp13a661qNUAIAQXfujFIMgCM94Asix3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkvMZy2Xrodr9FZF4W8CfbggsW9WdlQZTbkf4jeQX44=;
 b=MflzJ4ASoQaYyuDIdoxHuAMSGtPXhQCLLmU+9Lg4jbTVnpDVjKa63t/Z6YXHL2HPOhY/gOIvpc4XxvYyqp7QMnCcDTKRX4M2ELIHC9gN6UuaYz18DxOhrGDKa2K3tSarRb1qRCUMn2NEEdtAbcEMmoZBBIIr09qhhIYkc0qU5PM=
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 LV9PR12MB9784.namprd12.prod.outlook.com (2603:10b6:408:2ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 16:28:24 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:28:24 +0000
Message-ID: <9706ac4c-1fce-4603-b857-c77e9009c60a@amd.com>
Date: Fri, 5 Jun 2026 09:28:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ethtool: Set histogram ranges to NULL before querying
 FEC data
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>
References: <20260604225440.11083-1-eric.joyner@amd.com>
 <20260604194629.45a3ef03@kernel.org>
Content-Language: en-US
From: Eric Joyner <eric.joyner@amd.com>
In-Reply-To: <20260604194629.45a3ef03@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0144.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::29) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|LV9PR12MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ef459e-28d0-4d16-8b5c-08dec31f76f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|6133799003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	OLsPtBHw7r/s0Jao1Ehhe3LdHGEuX2pc+qBFqunPWY8is1pEG/Grr8frLzDyw1KWjdee9mzKn6qg9BzgwqV+chqSj95XaF2lvu4K+bxMHZgJ1WU6wSGovBnmkFLFte183yQxVHjryrhMVMCNpLKyMmIbSH6y+h4NfkFpky9WgCiL7rnLG/BP3txf+Kl7vP/s+qeMSk8grjK/Usv1e1sF2okFoYbMDzVb4mF1ySnhtvakG5uH2vrcKwlrPPVWeYqzz2ol1KAa7VYpq3LtpbEFcx8ogZC8A7L4pqRKnBGQVEdQv0hmFcmN+0Lss+xMmwAYZHClglMUYc9Zage6gOPhNWgKYwmSnhIETWY+/8PQeANkgUI26/kNe+23SrkJ4aqGCGbTmrbI5Ux43j6FbgZYGwiv0meYtnheRACLBuc6yuLH3xyABLFpkdJSU+hRNOlD1DrBqOBPVGmPtgyNiTozbPyl2a+hnl41NcepkBVgyIPFm5S8f7Fiogd+SBamOA899nuVkC6Y/XcoT2LJvs+12yeJv7TEf48ecuN5IL3Xf0ApSsTycyU5qJoHax6IJZh+O9N+bVBWHloOWrNM/+n3kvMUdoN+drc2rN/VO53fceFyuz6JRv2psVRTMZilEKssnr6PO5N8wTQb26hQyizCd5hFk2mbtZa8h2CcRVjIHNygfEhoLZwRGzGV0RnSj5UI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWY5bisxOTRzaGgwNEtBN0JXZXpxbHllaVZFOG1jakF4UjRueDNzVkRRbVF0?=
 =?utf-8?B?bkpQeHJOTi8rMU5mSGpodWlHbjRpZUgrd0E1OUxlM2hjWDAvU0JicmUzWjBT?=
 =?utf-8?B?TExvWG9ZVmlqdk5wcDB1dVpEQlBkSmg5TGtqb21MZU1JazAyUHExQ2VzNTg0?=
 =?utf-8?B?NllsMGRWUGhETDNXOVVDYkM4anVtQWpnMFRmRFA0bmlCUnBpaDRFTnhMNC9H?=
 =?utf-8?B?YjdsSTJtaXc4N3RGekRHMTlSVUM4cDVCK3ZRMkVRa1MzN0Z6RjFjdVlHSmhy?=
 =?utf-8?B?bDhCSFp4bE9lYlErVmhLcnlFYllJaHJ2QjBUenljNUpjUUVtK2owQktDQ2ll?=
 =?utf-8?B?a0Y1R0MwNHlxbUhmTUoxUU1CdTBnNExGOTRQcUttbEQ0KzdWUzYxY3U1OVIr?=
 =?utf-8?B?cXlNV2ZnblRLR0s3RWVYMXBZVzlQU09jTkliRU10L3UzNzh1MnBPSGt4Y2Nr?=
 =?utf-8?B?a2hSZGhLZmdTTVc2cXdEeEZKcGcwdER0SkdDcjFuTWdvMVFlcEYrSnNPeGhP?=
 =?utf-8?B?MFo4ckU2MFgzK01qeHdab1FGSkFlOHZhNDVSK2lTaGNyTDhheXN6VURyclJ1?=
 =?utf-8?B?UEpQRlRWUW1kd2FBZnpBTXIrb3ViTGJnb0VPTWg2Sm5Bd0swaUZ5V2Jua1Zy?=
 =?utf-8?B?MmViaHZyNnQ3UTcwcWUwc2ZxK2NJN2dkeWhIN1N0ZzFjZ2xvUGMrYlE0S0Iz?=
 =?utf-8?B?ZDRqeUNvVnM0ZXJRVjJ1aDRpNHVBZXdyUXNhYjJoSHRuNHF6eExobldUZzFL?=
 =?utf-8?B?NmV2WVVuUTJMMmNJNnhPT0JNbWhjVkpOdlVPbXFxRmwvSU15ZjhhUUlnSG9T?=
 =?utf-8?B?Rk40YzhneVQ0N3JSYTJ3RXhkL2lQOGp1Y25EdG4yYTJZcVp5TEpEUjhacGdv?=
 =?utf-8?B?V0hqY1diV0s4cVoyUFlHUEVxSTBNTTE3MWlNa2NoWTAxY2FhZWNvS0JkMkE4?=
 =?utf-8?B?UEwzbUl4Umc5RjJjM3h1bDQyQkZ2a0xhaWJyQWRWcllyeVpxSXhVbXFDakhw?=
 =?utf-8?B?bXNid0NqTGZvRmN6WVNsMkEvUWYycDNzekQxUStZY1BnSlFheC9FUlErOEJ0?=
 =?utf-8?B?RDBxdTZIVjk2ZDdLVmFkcmx1OTlpaFl6MWw2NEtYTmE4ay84NGdUVTgwSmVB?=
 =?utf-8?B?NzV1NXRhWngwVTNEZkc5TUVXanRwMldUOGR1REpuUzlzUzFrRmtVNWtlVjU1?=
 =?utf-8?B?MXNkZWM2MnRpWllXalQyVWJmejlETWgxam1ZTUlsTUtseXFuU3lNVmVsNWg4?=
 =?utf-8?B?NG5XU1lVMzVDZVV3ZE9jL0h6QVc5U3VVUlVWYlRwQ1ZacC9xU3RCMnJOZW83?=
 =?utf-8?B?cEJOZk4wOWxCV1R1V1hoVmVWeE1hU29hNkR2alNuVFZRbDJuUE1Mb0lhU2pY?=
 =?utf-8?B?Z09ZaWNra3NVYThESWxCN1E0UzI5Z2VUT2grSW84Z3JoS09FeGw0VGpabEF6?=
 =?utf-8?B?R0V3OFNmQWNHbjVMSTVVNisyUmw4QW9NNHhFRHRuVlRzTG5sUFJyWkw0b1Fr?=
 =?utf-8?B?bFpYcWwrM3UyRnh0dGN6eXFXUkYyZ0phWVFZUUo5ZVVsWTRpb0d1YXN5UnV3?=
 =?utf-8?B?Y3VFMjdtVTRTZGF5cUF6L3FvN2IwU1VNaEgreE1yY1NoR1NBZnZGZmNGT1dU?=
 =?utf-8?B?YTBQSU9tSGJhTmlnWkk2YVM0V2dmRFM3c1JwcVdUdkExQzJUQU9oblRBQVB5?=
 =?utf-8?B?U2tjS2hsVmN3ODBQT0daaHFLQ05lN2RsT2NsVFRiYWl4d0F1TTl6OUNHU1Y3?=
 =?utf-8?B?eWN1aUxGN0tNUVdNcGVKV29hYlJtdnIvMnZOTFZGeWdUQ2RkK1lSQS9lRnV2?=
 =?utf-8?B?bndiZ2lnNTFxKzRYTm44ZWZRWkMvU0NMSGZlUHRXRVJkdFR3R0UrR0tlYkZh?=
 =?utf-8?B?K0F4cFQrOTd0bkxUVERHeGJiME5idU1MaWIzMjRQdFNyUGpVamZVOUduMmhn?=
 =?utf-8?B?T09TNnJpNmNBYkN0UFQ1Mnh0N2t1azI5NzRFYVF5SjFVVWw5OElvOEFYMm41?=
 =?utf-8?B?RzYyTnpMeXdqcmhhNlZjbVhGZTJUSFJ0ekxaNWsrNUNKWG5janl0S3IyWWRr?=
 =?utf-8?B?dVBBamt4bXY1RWRIdlR2UUR1RUh4Zk5mbXV3T2pHQ1QzRkhjRTJlWFA1eE1a?=
 =?utf-8?B?UUUvRzI5ZUlhQ2t0RTRJRkVaaXBwMmdvZHowN0hZeWRYejNCMzY1QWZEbmpP?=
 =?utf-8?B?b2lQQzMyYmZ3SlhEdFFNWFB5RGFxNFpoVVB2OEE4ZUY2c2I1cXZzMnpaU2hE?=
 =?utf-8?B?Y3pCOVE5WWRnZEVTVG56Y2p1dlJlSWhBblJWcE1yVHd3NFEwYUtuN01xejFi?=
 =?utf-8?Q?cikZNPpeQsM+R0mL8U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ef459e-28d0-4d16-8b5c-08dec31f76f8
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:28:24.2423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBGpbmziscLCzUGeGVn5vig5i5xpD1ZjK3xpkIfUD7nFs80kQhJFG+LbRKb30mbM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9784
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295898-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:mid,amd.com:from_mime,amd.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9534649D85

On 6/4/2026 7:46 PM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Thu, 4 Jun 2026 15:54:40 -0700 Eric Joyner wrote:
>> If this field isn't set to NULL, then drivers that set the non-histogram
>> FEC statistics and don't support/modify the histogram fields will
>> trigger a WARN_ON() in fec_put_hist(). Drivers shouldn't be forced to
>> set this field to NULL if they don't have a need to touch FEC histogram
>> reporting, so set this field before the driver gets the data structure.
> 
> &data should be zero-initialized, how is this patch not a nop?
> 
> Are you sure this can trigger unless the driver is buggy and sets
> ranges without reporting any values?
> 

I'm double-checked this, and you're right; the memory gets zeroed, and so the
situation I described shouldn't happen.

It must have been some buggy in-between version driver I was using, but I can't
reproduce this and have no idea what I did to trigger it; I'm guessing I did
what you suggested and only partially set the histogram values somehow.

Drop this patch; and I'm sorry about the noise.

- Eric


