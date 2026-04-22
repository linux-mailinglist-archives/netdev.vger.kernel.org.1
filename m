Return-Path: <netdev+bounces-280518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEmKHbsC6Wl5SgIAu9opvQ
	(envelope-from <netdev+bounces-280518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 19:17:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A71449392
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 19:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75468300D146
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77854347FCD;
	Wed, 22 Apr 2026 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="0rOhi9I0"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021081.outbound.protection.outlook.com [52.101.62.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD02B347532;
	Wed, 22 Apr 2026 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776878261; cv=fail; b=F+EH/K11PVsyKliMzIw4q76Zc9nvGiNMfC7sPM210YXpBBJlE3fl3YmSa6mIlVANwQtmfbecTSSBDbZ+MkBpR9FbQX6b80XxAtyZTL89w77uRhgnLP8lxgQYi6gfVktLagtDT9LDjlD+BbXRjdObRdQD/1wbYeeGeHWEnR7XaIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776878261; c=relaxed/simple;
	bh=jyvT3MhmURyXnlC1pxTOedxoPFWqx3GmJ4JejwZUw7I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WVbWvddrzKj1aouLnpzWRb2rIsmUmwg0fMw98eciJw14Wx7/vApFXYfiwaAgoK2HY4dwzs8BMiGCCUxwN/5+LiY52c5aQXJEW7aq0fZ5RDgQ0bHdBz+4vO4iz3Jzp2FnfMZ3Mb65bVu0/nueoz319YmsnmOABIhkeZQzkDNJoaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=0rOhi9I0 reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.62.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLgOLIQ7fBbRFycEdxIg+MbLx97jYHdGmDvLBvoqLsgOdFuEilukUxc8yTc7uTXoMq4z0IMyel55xcU5ZBk3N+8RZc/m0CtzSxdaPfDQpxkZs2zrIst85MyBrFUbPUbj3gZKqEYD/d69KBmNxhhL+lbKR037HlInIjniobXvhVO9uYdPgmkrxz8bst8Gggsn6TxNOs/C8gWZFVFJZUMJ9J4ol9SAjzGhC9pdZX96vjgwX/y7u2aO95WCFBkiz2xRYMCRc7Pz/FOL3ROnZ9x3l724LbiBMSpM79aQ9BBcct7vhdV7ZBFf+m0khozQqu/77QtXQPHfrXDeKCHnUaUk/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRYv2+gFoFL/2TSbo4xg/0Hsorf56knjE8/rCxwV9I4=;
 b=wA78vqvymqLGAROw0HkfII41daAZlDovk2d3BZMWYjjuEdkRERpC3AcJKgsYgThrvbiiJQ6xZg9wqj4NwdsA5cnskyBwT+4lowQcQeLXAmbmPsWgFXTMFFb0l9hOC0EW0vBF/RTT0Zlr9sZZSZfZ3EyRK1qasjPE2k7Ra9t+vECw12Ny7q7BjoxlovKhTTqsTCchodP3jO5lyC+CIwerGB+OPFg8RetHVGc4C6vJG7/O6OdLRZqlTthANHoNJVgSx1C8x0eWzP+EegffHrlduKtzVYJLfYJIPlMY6BkzVAiKUFBjr8slUU1/LpMN2dWnVey3KCgtiwHZcxguzrelXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRYv2+gFoFL/2TSbo4xg/0Hsorf56knjE8/rCxwV9I4=;
 b=0rOhi9I0UB6ysP/VSfWXv5eQWDVz3cTNp99S1B57HnZStoFafUauDSIxH0KjuwNUT+382dL1zeREwQfKVZCM9D0Xd3gadhD2fTw0GLQ606ir2l6nw6clFLQKjFo04RwC+OYGLLcbiKm/z8jL6ZLDC3uZK8DhmTbOSeSi6Op+hZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SJ0PR01MB7330.prod.exchangelabs.com (2603:10b6:a03:3f6::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.16; Wed, 22 Apr 2026 17:17:34 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9818.017; Wed, 22 Apr 2026
 17:17:33 +0000
Message-ID: <2989efb3-11e3-441a-b213-b0979ef74e95@amperemail.onmicrosoft.com>
Date: Wed, 22 Apr 2026 13:17:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v38] mctp pcc: Implement MCTP over PCC Transport
To: Jakub Kicinski <kuba@kernel.org>, admiyo@os.amperecomputing.com
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sudeep.holla@arm.com, Jonathan.Cameron@huawei.com, lihuisong@huawei.com
References: <20260405180741.1496198-1-admiyo@os.amperecomputing.com>
 <20260410032441.1844450-1-kuba@kernel.org>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20260410032441.1844450-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR14CA0034.namprd14.prod.outlook.com
 (2603:10b6:930:a0::19) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SJ0PR01MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb2cda2-3595-47a8-6bae-08dea0930ad6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|7416014|11006099003|55112099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4VFCn3aebQ4JUJpkPqsLBGBn/iWrOaZaNcxyQotE5dKNzv1oLVmZV+FMnJDsqikEe8nT8uR+4qkuplSJ1mHkfa8UZs+0jMTmx+mWtPJmoHTUcNPNGmDzidBcX4pkPHR1q8/LP6Y9TkNZ0mul8IBs83SDz617Z763f0pwpfZRaa1ovgbM273hu45AUWsytKBbc0vqbbd0Lqu4QdualRkk7pCKFL/UfDTDECAQj8DRYSuiQsODRa7dPNlXLIygXAb7YCSx+eZPH8c2nM815s3BnHhH0I33+yv9fvfPmKJzsY4WCiGp2C6kxRTsfpGZUxWA767X3l1hvX1+wZSOMgu5jekn/rxeF7A4rpVEMW+DB9r2IvRWICaJ9SwsmDS96dA5kijrGCAhUq/tTJ5sncNlXzUbyW5n9Q33AOqyLYqVspTb4DvjCQHCjvDQ+A99HebVvK8NtXhXWgc7lJFUfkoFTlXy1Cdk366SA4hMy+88+Q8uaF14ymvXviBzGdoEz1+Ofez8mzZgvBizx1ZUh11YdukXhq4kVI4TmqM+pKmV74J+fh7dfCQ0V5HofulkxUmeK/+cpWluA8WTlU+eLsMRSNPxqahdRkUNvTiqlWyjFrN+infgXcC8AgA2JM2t1sv5Zo9wEIMdCB+pSh1vXAqB1rlzNtAM+TJ/dq2XtV7faU54EmVviMVBxYr3WPzytQwX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7416014)(11006099003)(55112099003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TC83NkdFbDhxM0RXL1Mwb3M5enNJRjlQY1ZOK0R3aWsyOG1aVWJ0OUtHQk0z?=
 =?utf-8?B?NVhpb2FmaCs5V2pKZVY3ejlkRm1jdDRhdXp4bDBNVDQxQzN6WFd2MkdoMlUv?=
 =?utf-8?B?VW0vQVpUREpPNTdrdEoyMXZJVTlaanNkU0ZZZHJJS1NEM2FadlJxOFJ1WHhO?=
 =?utf-8?B?Vjh0ZWJCcGNpRHB5dFhXYk9yUFgzN2NUbGFLUWVQNVdJL1F0ZWZPVnRmN3Nv?=
 =?utf-8?B?c0RKVThFdWNtNk9Fd2lveTF3YUF0VFR2a0xjWmlzbUoxc3NPdFNmWFNyVmd4?=
 =?utf-8?B?ekJMN3prazJOQjBKYzF3aVBrU2xDTjZFZFVGZHY4MVc4bjUzSURZak1ZUHFm?=
 =?utf-8?B?YytMYVVvSUJ0UjVOTk1zMVNLVFJjalh5RjRuQzB3d0VCclNSWjdLUW1TTFlH?=
 =?utf-8?B?NFQwZXoyNGRmNEhsMEhuS0d2N0FJcXVRMktXNmVZdDdqVzhLMkgxRGVSSVFZ?=
 =?utf-8?B?d0QrMGdGSmE3SjdFREFGN0ZRQXZXQlE4TjFDZ0RZYmlHSTBVeFdlRWlybVJ0?=
 =?utf-8?B?bjZ2ZGlldVFhMjloc2p0OU9CNTA5S3pPNVN4N0hoUVBKaWlWbjRuN0NwSmJz?=
 =?utf-8?B?MWRsRkoxZHhYU0psOFNiUzY3N2hiMHJ0K3VrK0o0YlZOWXJEQzNPTWtkMHpZ?=
 =?utf-8?B?Vlc5R2NtTFRvSitQaVlCOTcvbkpQU0ZGOVlkbFhoaGgwZ05yOUZQZGVvTUlK?=
 =?utf-8?B?eWlDNUJXODh3a1FMUStSNG5IdEZGblRrZjl0V1djSHpZRVMvZWQyNWVxdito?=
 =?utf-8?B?eUxLcDRCbTBLMi9BQ2lLWEhvbzh4TnJuanFmRTNTVFhEUDRzdXlCbm1vZ0Rv?=
 =?utf-8?B?TjdsY2RVeDhSejc5UThVUFJyK054LzlyaE1hK0xYcWdEblR3K3Q4UFdqSys3?=
 =?utf-8?B?TUEzZDBaVHdqVGdUdkQ2a1NuMmJNZjVZblViVmFoS2tsYUwyY1QxTkorbVlC?=
 =?utf-8?B?YmkvaXZ3ZDA2WEp1VWx0eGpHTHlQa3VkOHM3L2xMNGpLTHBNVUl5VEJVbHZk?=
 =?utf-8?B?aVlCZVpmU3BGOEFpQ2UzYkUzdXZxY1crb29obzE4WmRxTWg3L3J2dG1PT21o?=
 =?utf-8?B?RitZWmczWjAwY1hjaFoxNnVxclBCOWNWRjBpY0h4VVk3alRVMUxxdlRNeGpY?=
 =?utf-8?B?eDljdkpiV3FzMWxva2dIZjRhcGtlK3kya1RqYnRldHJoL0FjVzZoUTBuUTFv?=
 =?utf-8?B?ZDRtMHJlbHRaSGdrRENieGJ0dFE5OWVTRFlpSmxkM2daRi80RDg5VWdwcEs0?=
 =?utf-8?B?RzY3SDdYcTJnRVpzYWpMVW1TdC9sQUY5OFpOVnVQVnRmdERMc3l4QmpnT2JT?=
 =?utf-8?B?ckhZN0xXQUhJMmw1eWJDRzg4RHZTdUpKQnBQclJVWEZRd2tiTTRNRzNlVDF5?=
 =?utf-8?B?UnJ5Y2g3ZlArVkpCZWVwZmVjTkFUM1pJNTlNaVo4VDFiR1FJTEFNdDR0bXQ3?=
 =?utf-8?B?T0pOQTlnRWlwR1hVZGIvY1U3S2xkcHB6dEJtQUpiMXQ1VmcxYVdkeHk3UTZ5?=
 =?utf-8?B?WEZERjRSYjVVTkVXaUxLVmt3dE5xaUpma054dXI3VGFPUFhJVWdnWjFiRG1y?=
 =?utf-8?B?QVZxV3RMRGhhREVaM3FSZENqU2tDcXhTVWdMYjBkNnJMYkNoa3pBTW4rcXNX?=
 =?utf-8?B?WG9oVnNQU0l6VnRyVjZrVlRudnFjTlFGKysxUU5aNFplTlo5K3RwdnBRUlk4?=
 =?utf-8?B?NUdxSnNwSFdRNkl0WDJLNDFDMlBPeWJVT2VIVUhsNkpiQ3AyWTBPMS9HaEJz?=
 =?utf-8?B?VG40bHJySGJ5Q2pzaVZzclJvL25Ec3M4TW1zemdKUllZZ01lM1F6cUMydTZD?=
 =?utf-8?B?WlBtVGtNMkY5SE1hUUpLYzQ5OVhHZ1BxUlpuSHoxN0VVSWFBOXVoSWYzYlVK?=
 =?utf-8?B?NkM1RVllL1drRE8vN2xlQUlIYjZlbUpNUUoyaE1EVGhBTUl4cG1LcFc4ZGw3?=
 =?utf-8?B?aDlHV2hVSUN4MVBZUHh1T3hMR2VGTlQ1WEMweWcwVEtvenR0K0NGaGxqNFdz?=
 =?utf-8?B?MDVJZTFya1MzbkxMcWd1RkZFeEpCTlQxMXhqV3lzcFJCdTUxMnRQVUFoNHpB?=
 =?utf-8?B?ZmFreGUzTEQ4SVpwR1FoeFMvQkQ1T0VHajlNZ3R3R1lrMmM1VE1qN3dxSGdP?=
 =?utf-8?B?bDBJZ1FxQzlRQllLMHdORjcxNWo2STVJcTRoa1R6STdQVCtrVlZ5c1U0L3ZC?=
 =?utf-8?B?SEx5NC9PRkduYmgzZ2tCRzdyYUdqOUxtNE9SYjdoemtCYXQyUWdra0VQL1d1?=
 =?utf-8?B?QjRjMWJUdDBRVVltalBzS04zTWQ3dHFpSjNmcnhqZDRrUUkyRkJRQVBkdk85?=
 =?utf-8?B?UmpIWWRDUC9ZMnNxQnRGa2ZoRjJzQ0gyVjRZVzd5SWVKbXlwZ0srMnZoT2Rz?=
 =?utf-8?Q?ibz0LHFH+hzK4Ov45gPW/lxGuBhSuXU3kG8jJQgKkdCNO?=
X-MS-Exchange-AntiSpam-MessageData-1:
	lXBjDGHY5KWR4ISv+bDwJZbV1GyeIAhdGwwPWJMTJeXC4XyWa4mUT5sA
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb2cda2-3595-47a8-6bae-08dea0930ad6
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 17:17:33.7438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8wfpHnFGrMjiMrrPGrHpP/OVX8WG2PTwRJTcO/BCskQdQQ5FzhWrqah1I2AVgpurlosHnDLdhOqdR854koYoduPqxhyWWdUQcu9a6ti9OucjzEjqsYSfmJ9S7xivUXy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7330
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280518-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	DMARC_NA(0.00)[onmicrosoft.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	NEURAL_SPAM(0.00)[0.877];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,uefi.org:url]
X-Rspamd-Queue-Id: 02A71449392
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/9/26 23:24, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> mctp pcc: Implement MCTP over PCC Transport
>
> This commit implements a network driver for the Management Component
> Transport Protocol (MCTP) over the Platform Communication Channel (PCC).
>
> Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html
>
>> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
>> new file mode 100644
>> --- /dev/null
>> +++ b/drivers/net/mctp/mctp-pcc.c
> [ ... ]
>
>> +static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *mssg)
>> +{
> [ ... ]
>
>> +	// The message must at least have the PCC command indicating it is an MCTP
>> +	// message followed by the MCTP header, or we have a malformed message.
>> +	if (pcc_header.length < sizeof(pcc_header.command) + sizeof(struct mctp_hdr)) {
>> +		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
>> +		return;
>> +	}
>> +
>> +	size = pcc_header.length - sizeof(pcc_header.command) + sizeof(pcc_header);
> Can this size calculation wrap around? Because pcc_header.length is read from
> shared memory, a maliciously large value (e.g. 0xFFFFFFF8) could wrap around
> the unsigned 32-bit addition, resulting in a small positive size.
>
> This small positive size would then bypass the check below, and eventually
> fail in skb_pull(), leaving the malformed skb to be passed to the network
> stack.

This seems legit.  The logic to check the size should ensure that the 
value pulled out of the shared buffer is the size of the buffer, minus 
the header.


>
>> +	// If the reported size is larger than the shared memory, something is wrong
>> +	// and the best we can do is treat it as corrupted data.
>> +	if (size > inbox->chan->shmem_size) {
>> +		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
>> +		return;
>> +	}
> [ ... ]
>
>> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
>> +{
> [ ... ]
>
>> +	pcc_header = skb_push(skb, sizeof(*pcc_header));
>> +	pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
>> +	pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
>> +	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
>> +	pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
> Are these assignments writing native endian values into shared memory?
>
> The ACPI Platform Communications Channel specification defines the shared
> memory region as strictly little-endian. Writing without cpu_to_le32() will
> cause big endian architectures to write byte-swapped metadata, resulting in
> dropped packets.

This looks legit, and it reflects some of the early version of my patch 
where I was doing similar transforms.

The target for this code is only ARM little endian systems, but I think 
it is more correct to handle the wider cases in case that decision changes.


>
>> +
>> +	rc = mbox_send_message(mpnd->outbox.chan->mchan, skb);
>> +	if (rc < 0) {
> [ ... ]
>
>> +static void mctp_pcc_tx_prepare(struct mbox_client *cl, void *mssg)
>> +{
> [ ... ]
>
>> +	if (skb->len > outbox->chan->shmem_size) {
>> +		dev_dstats_tx_dropped(mctp_pcc_ndev->ndev);
>> +		return;
>> +	}
> If the skb is oversized, this skips the copy and returns, but does it abort
> the transmission?
>
> Since mctp_pcc_tx() already submitted the message and tx_prepare() returns
> void, the hardware doorbell will still be rung. The remote endpoint would
> process the unmodified shared memory, replaying the previous packet's data.
This looks legit.  Once we are in tx_prepare the message is going to be 
sent. All checks like this need to be done in tx
>
>> +	memcpy_toio(outbox->chan->shmem,  skb->data, skb->len);
> Is it possible to read out of bounds here if the skb is fragmented?
>
> The skb->data pointer only points to the linear portion of the packet, while
> skb->len represents the total packet length including page fragments.
> skb_cow_head() does not linearize the packet, so a call to skb_linearize()
> might be needed before copying.

Legit.

While we don't have fragmentation enabled right now, it could very well 
be enabled in the future, and this should be addressed.


>
>> +}
>> +
>> +static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
>> +{
>> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +	struct sk_buff *skb = mssg;
>> +
>> +	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
>> +	dev_dstats_tx_add(mctp_pcc_ndev->ndev, skb->len);
> Could this lead to sequence counter corruption and deadlock?
>
> mctp_pcc_tx() runs in process or softirq context and calls
> dev_dstats_tx_dropped(). mctp_pcc_tx_done() runs in the controller's hardirq
> context and calls dev_dstats_tx_add().
>
> The generic dev_dstats_* macros use u64_stats_update_begin(), which does not
> disable interrupts. If a hardware interrupt fires while the softirq path is
> inside u64_stats_update_begin(), the hardirq path will re-enter the lock.

I think this is legit. mctp_pcc_tx_done is triggered by the interupt 
handler (it is the registered call back). While I do prefer to register 
the packet as being sent at this point, I think that latest it can be 
done is after the packet is written to the shared region in 
mctp_pcc_tx_prepare.


>
>> +	dev_consume_skb_any(skb);
>> +	netif_wake_queue(mctp_pcc_ndev->ndev);
>> +}
> [ ... ]
>
>> +static int mctp_pcc_ndo_stop(struct net_device *ndev)
>> +{
>> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +	unsigned int count, idx;
>> +	struct mbox_chan *chan;
>> +	struct sk_buff *skb;
>> +
>> +	mctp_pcc_ndev = netdev_priv(ndev);
>> +	chan = mctp_pcc_ndev->outbox.chan->mchan;
>> +
>> +	scoped_guard(spinlock_irqsave, &chan->lock) {
>> +		chan->active_req = NULL;
> Does this bypass the mailbox API and cause a memory leak?
>
> By explicitly setting active_req to NULL without freeing the in-flight skb,
> the skb is leaked.
>
> Additionally, when the hardware completion interrupt fires, mbox_chan_txdone()
> will pass NULL as the mssg parameter to mctp_pcc_tx_done(). Since
> mctp_pcc_tx_done() dereferences skb->len, this will result in a NULL pointer
> dereference.

Legit.  I was thinking that the packet pointed to by chan->active_req 
was still in the ring buffer, but it has already been removed.


>
>> +		while (chan->msg_count > 0) {
>> +			count = chan->msg_count;
>> +			idx = chan->msg_free;
>> +			if (idx >= count)
>> +				idx -= count;
>> +			else
>> +				idx += MBOX_TX_QUEUE_LEN - count;
> Is this index calculation accurate?
>
> Since msg_free is incremented and msg_count is decremented in each iteration
> below, the calculated idx jumps by 2. This skips alternate skbs, leaking
> them, and reads uninitialized memory, which is then passed to
> dev_consume_skb_any(), causing a use-after-free or double free.

I don't think this is legit.  I've written code to test this algorithm, 
and it works as written.  This logic comes from the 
drivers/mailbox/mailbox.c function msg_submit.

  idx does not jump by two each iteration.

>
>> +			skb = chan->msg_data[idx];
>> +			dev_dstats_tx_dropped(ndev);
>> +			dev_consume_skb_any(skb);
>> +			chan->msg_count--;
>> +			chan->msg_free++;
>> +		}
>> +	}
> [ ... ]
>
>> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
>> +{
>> +	struct mctp_pcc_lookup_context context = {0};
>> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> [ ... ]
>
>> +	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
>> +				     &context);
>> +	if (!ACPI_SUCCESS(status)) {
>> +		dev_err(dev, "FAILED to lookup PCC indexes from CRS\n");
>> +		return -EINVAL;
>> +	}
> What happens if the _CRS table contains fewer than two PCC_DWORD_TYPE
> resources?
>
> If context.index is not verified to be at least 2 here, context.inbox_index
> and context.outbox_index might remain uninitialized or at their default zero
> values. This could cause the driver to blindly request PCC channel 0, which
> may belong to another hardware subsystem.

If that is the case then things are truely corrupted on the system.  So, 
yeah, this is legit, but a sign of things much worse happening.

It is easy enough to check that we get 2 values in the context from walk 
resources.


>
>> +
>> +	snprintf(name, sizeof(name), "mctppcc%d", context.inbox_index);
>> +	ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
>> +			    mctp_pcc_setup);

