Return-Path: <netdev+bounces-270107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKceF0PavWlyCwMAu9opvQ
	(envelope-from <netdev+bounces-270107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:37:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D91292E24A5
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D200305EBA6
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA623D6493;
	Fri, 20 Mar 2026 23:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="RI8/r/L9"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023072.outbound.protection.outlook.com [40.93.201.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA5C3806DE
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774049834; cv=fail; b=Vw7B5I4YJNb8Onr7lTA13t8/iZpvEwnz47LzeruTJz20kWpw+kcnTcpE9CmG6Ho67fWEPt8GfN3cIlSw2qD1V7dWGoTSXOJpKU1qTShIO2eZojMTJ5gHbI9kso3mjYJ265Zrun4kmr0op4LeBiCkj3j/lF30VTn20vSzYmzdBrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774049834; c=relaxed/simple;
	bh=Xm3oPFQajXF8q3Ry+gnRXC5gxmhkvZ9yqWuhndrf/MQ=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gvd/7addhgStkex6ebM+Vw3zYbT/sS6ACbBoVFYwBBhsSewccwYhh36wwGxQQiE8UYM4y8mxB/5jXJq8PUUXIWeVARbXH+tEUY/vNGyZBFeIhED+Y2Fy0S6nmoBQiXwajwplDY5I27BLPnY4zbYJkNXWDrpcmmj8P+EuWd7+Nl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=RI8/r/L9 reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.201.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fto70wTOmSljxkliYhvxRqvgYhBAP0r0HAmW8XkHmH2AbVRppvODsexsGYAeWomXfmmAtbGmEo4WOe3e2qzO6GBQL3yhVjhICF8YW9qI4xDGz/w6X3NugtEwa9QMDUj7yHWrrJkdshMWGw5eyVQYwE3iH5fAOsRLe4XFzBgIPCOwVpJz61ycxYEaJyc6pO4x58ILtEJFHkUx97pemTMHac/L52DjyNz/fnER5Owu5SAkKDRJV7MX+9V7IfvQa76NI/g+mJW+W5QOh4eSgByZqbMF/g9Xmn+2lgnjA6lQLKg4XA4G/tFgVygC0wFFlO1FJX7evahZPk9+bjuuiBl94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RG3XJSaqHoG4FJAtu/32IujQc2iEt7MTyaMCF7DilaM=;
 b=KsEDlcwHiuM4faCeHX/UcwWhKZabSf+/33tBcYvGWjFFCXD8ZiY8HJaQUdsOl9MeVDFtrKoOTuElvbwYLS859btLJJXXy1l5IerF8lpt5VYDHjLvAkA8OEs1tRHr4YlC6p9MdoqrnBBC7V3tZCFIyVQosTrO+rpgwszaAn5YXMRR/jnZ4wRNwLxUSEJyIeewNKnYkQ9nWnqs+5Nt4MatMoNcNK9TuBVOr2W5Yf5WLN+jnOe0+BGCCKrlCzVmw7de5X44UWgd8L6Cha/uZde6TxSo6FZ1pfH1vkM1/lFRHx/TKXANwCu3nJfIaGazl7iO6v0k+URj95hZHlgxzkd3og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RG3XJSaqHoG4FJAtu/32IujQc2iEt7MTyaMCF7DilaM=;
 b=RI8/r/L9O9g9oHPf15uLXpm/BA7WutmRxSRQtZP4YRPX9mIH+/mk8NTAaheQIg6rlZ4USPlm/D9zQyPPXgPvRpAQPxdWUPk+vEgj+V+nlbJwyguyQEcYe6tZoPphqnuXlcuv9PV+VQm691ZpYTQvlMEcIxRzvtyw5IBvrqB081g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CH5PR01MB8791.prod.exchangelabs.com (2603:10b6:610:212::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.23; Fri, 20 Mar 2026 23:37:04 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 23:37:09 +0000
Message-ID: <c37ee2a7-8e19-4aaa-aaf3-4cd5a9c171d1@amperemail.onmicrosoft.com>
Date: Fri, 20 Mar 2026 19:37:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 13/13] net/mlx5: Add a shared devlink instance
 for PFs on same chip
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
References: <20260312100407.551173-1-jiri@resnulli.us>
 <20260312100407.551173-14-jiri@resnulli.us>
 <bab5b6bc-aa42-4af1-80d1-e56bcef06bc2@amperemail.onmicrosoft.com>
Content-Language: en-US
In-Reply-To: <bab5b6bc-aa42-4af1-80d1-e56bcef06bc2@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::18) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CH5PR01MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: bc04f3fa-76f2-49de-3ed9-08de86d99a6b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	9+zr6BfEP3j1QM5++L1zbZ2/0dy8CUPJzzg7QQmvHAXVkTPCUdSRVdM/XAR8n+7GJkELBwuud60nhy5TeQ1IJiy1QiUZ/aPu1HxkBM4GpoSOryZg8/U7ZEraWdIowFgK1rY0WSqhGZ/MlW0sP7fc+jKDlQrA95nNmiQTokjDaDpknnKCq0jGPOto2lUryqQnIMmN8JXE//NfOC5KN4BSBq/ZqK+fmXe0dN6vazX1vwdyxrPk6RW+dz7spL/NQHaGBesuJvLPwBbAhtS4BDYIEry2ADq4kQd4zIB1j/4jYWAk5Lrm/WBU5ledR0Wr2CFj3eaOcOzH27tkHw0gW6i6rtqBrdJdG4cDIs93yaHuT5Z7fR0HexHvdWvgHSP1W2OkIdJmwgOqaiecVxgfeiybz7MVl7nIkQBKDQ9nt4LJ2/g6tbCnM5AMkrcde8cM32QoTkS6z1FLg75eTlyCVZ02foblQvrfJFNQaMUVJxSvA6Atb+dAasAjGtKzHLJju7Z+vkwagKyaRdVk3wkvmqyZmadI7bRWkayS9QWDodyKlQ2zilHEVjf91p5ByGWYfGppW78g9t4RDFBbdpMimMg9TBQkXAsQiEt9d+ocnKnS6sxo23e/hEjHS1IiWnDb6MvD+OS7KMDrwQ02qqmchNSwJuKmVLtDsA84z83XduEV4OfxHA/KLqKy4ktYa5QjuExPrBCTAzA2cHc5r/BdManuWgBgvJd/2gQFQZLWSC14M8w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0Y4aGRORVlmNUxtakJReHlxdzQxM0JTTThKQTc4Q3FzWmx0UUxYUTIwanVq?=
 =?utf-8?B?RUIyd0o3THBTZGtzNHAyMzJEMVFkMmFoeURmTHNScU0xRmFXZElvdm5ndjdn?=
 =?utf-8?B?ajZCN2hBeTFZcGNTWnM0NnFOSGtDQU9NQ3ZhcUErb2V1T1VBQVVzYnJXNnZq?=
 =?utf-8?B?eENZbnRZUXlhaUJUY1d3RUUyaW8yZGE0T2M3TTNpcTN3Ry94MFdPQlFxVE5q?=
 =?utf-8?B?djZ2SjE0UHFBRWJqbmpucEZQbHVqMDBNamZxUHBPVGp6MkM1eVZHaXJZbE9N?=
 =?utf-8?B?QzZLa3NjKzhYUDU1eVEzdU83MHJwMHk5c3huRFo2ZE1zVUhXNDBoQy9EZVVx?=
 =?utf-8?B?ekw1bkViOVNDWC9VaitkZHNLdFdDeHd1RGk0VkZockt3dGxORVd5MGM0WCtK?=
 =?utf-8?B?cW9lYzFjYzZuZzFxd1VGOXBJSU5wOHN5M1RLQ0N4YzN5VzFORW9qalFDSDZI?=
 =?utf-8?B?dzZlRFRQWE96cVVTK0xQM3BuVHE3Z0V3TzJkeDFoM054eWd3SWpheDNDeHVw?=
 =?utf-8?B?dXcrWG9nQk90UGlLVFJ1SmcrVWNkUGozUmw2K1VPd21sM3hHZTM2TUxCZ0tx?=
 =?utf-8?B?NERrVzRncnFLRUovb1Y0bGcvNE5naDNoOWN3RGNHazdnbUdqVEJaMVUyVUg4?=
 =?utf-8?B?Y0x3ZkFRMmVCMlZnRTZOWGVkNE54QlluOVY5ME5raG83ZFg5bUNXMmxrUzU3?=
 =?utf-8?B?b0ZjSnV4Uk9DUkxsaG5xUDI5MEs1b1dHNlRTajFwVFpEcmo0S05ZUDhJa05T?=
 =?utf-8?B?a2FzSSsrQzhUNHhRUmVDNFdxS0tFNUdRSXhvOXRaRWJhT2ppQVhnR3lUM0lv?=
 =?utf-8?B?NjI1UlgvbFZ2bkp0SEJkSDhqTjkzemh2aDJmSU9UNFJueTUvbldRL0FWSzMz?=
 =?utf-8?B?MDRxVzRvcThjTG10ZW5MdXZnY0lmdWRVMld6TmVuQkcramNlQlB5VXhIMTVI?=
 =?utf-8?B?WHlGdmthVTlldTU3blNXMmQraVBBdXIyMXVPS25JQ1B5czlBY1BqSmcwNnAz?=
 =?utf-8?B?KytpamhkdlJRcnQ0V2RheVJYUnFjaUtYak9PcCtPSndPRmpiNEtrZk9OQ29m?=
 =?utf-8?B?NTZ5ZmRraUx6RXRLVEl1ZFc5b0hmNzBPODI1cEc5SUJVRTh2cUVEV0tSc2Zi?=
 =?utf-8?B?cy9wNzNnNVNDcldNZjhRcWo1WUhuWjBKa05tcVJ4Qmh0NXNKL09VUkMva3ZQ?=
 =?utf-8?B?VHpWT01zWTV3S2IzYWEwZUQyWEorazRjNE1XTjNJUTY3eEpKdFJXSDRUS0xQ?=
 =?utf-8?B?aytoeCtCdFJOcldDbDMzbkZKTUNUQ2krMUtMMzFvU2dHeHRFMGZVSysxT3Ja?=
 =?utf-8?B?ZXV0eG5KSjFpMGZxMGZ0NVlta0NoeTJ1MWNpcit3MVRnMDZCeEh3K050YTRi?=
 =?utf-8?B?ZitNVytDWnZybVo0UERBY0JvUjlURVNoa3hHZzdvbXZXZzFCR3pMU24rbzFH?=
 =?utf-8?B?NmpIR0tnWVBHVjJCQ0VTY2FqMm56RGhvdjZ3MmpkdGJYaTNKOUZRM3praFBz?=
 =?utf-8?B?aXdBOG1RSFhZTVBRWm5ScWY3N25KK3daRGhQeFVDMjhSMkE2cjJuTzVpTG45?=
 =?utf-8?B?NTNOSytuQ0VZOUN4ekt1L21GMDJjWWJWYzVWOGhKQ2JGZks2eGp5eHo5OUUx?=
 =?utf-8?B?Vm1SK1lHcmRZeXA4Wm44MEwzRFYyZ241UElOR1pQSm5tRUF1dEFvbWttRHkw?=
 =?utf-8?B?UnVZdWo2UmVrVjZZRXNBcW5YTVg0c2hpWmNaZ1p3a2UwM0Era1B4UG5WZk54?=
 =?utf-8?B?M2ptVndEMFpyeUpoKzlEZk5mVS9XcnhWMHE1LzBUV3Bsb2g5OFhFTy8wQjNS?=
 =?utf-8?B?NW5GYzNJNnNHNnpsVmk3VlBYVTBJYzdkSUJ6NXk1NlJmS3RLSXhHODFTNVY0?=
 =?utf-8?B?aWhOZXFNek1TU0RONHJoN0NNYmY1b28xY2JNc2J4MnQzcEwrZGJWUjY5ZVdI?=
 =?utf-8?B?NlJ2SzJhMFpPQ2I3S0c5Uzg1cHMyZktsMjR3Vk56b2hWa080aVhzb3owZkhY?=
 =?utf-8?B?aGhDeGFqellKc0EvWk84ZlpJV1d1ZW5kOTRVRTR0MjhyR0gyTVpHZVpzN2c0?=
 =?utf-8?B?TjU3ckxlUEdwU0F3TmsxNUpibjBTakRlenZiN3FvbytkYU5vUlcydHZZMCs1?=
 =?utf-8?B?RmxiazN2N3o4OWlvSWJ5bFl0VHVteHJGRUJmME44akgzYTZGMlBZcU8zdGNK?=
 =?utf-8?B?OHBIVFhoUWt2Sy9xa3pLcG4rS1A1OTFLb3UrUjRVeUUzSnByVFBIWXNsTGMx?=
 =?utf-8?B?ZUVJejVQU2Vod016WHd4dnYzZS9ZT2xQWk5KRWdyOW1kOUUzbG1ZcmxER0ln?=
 =?utf-8?B?bFFObkZVUVpMRzZDS2Y2UWhNWitBSUhTa2FKdFVlUis5VUhxZjN5NEVEbG1i?=
 =?utf-8?Q?yArtVHl+C63Fjigivbh5TdOZeKJgEubl9Opx3BADFZt+T?=
X-MS-Exchange-AntiSpam-MessageData-1:
	Egml50QgefhGDAwsgrCRMrUUHoahnDdnsilDh7qkC/bez7LqneCDx9Zy
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc04f3fa-76f2-49de-3ed9-08de86d99a6b
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 23:37:09.1126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSRGPbuv6g/kDCUt+Vb5LZ+nJovSjH4ZMySjoB+YEObH6gLqZsK2SVu+NKnlmY0JLvowDtBZAGmB80w08eQ+7avCgO3tdElaDrIbvWeu7yJ4u85c3hAoNNqfaQ7pf974
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB8791
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270107-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[onmicrosoft.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	NEURAL_SPAM(0.00)[1.000];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amperemail.onmicrosoft.com:mid,mellanox.com:email]
X-Rspamd-Queue-Id: D91292E24A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



0005:01:00.0 Ethernet controller: Mellanox Technologies MT27710 Family 
[ConnectX-4 Lx]
0005:01:00.1 Ethernet controller: Mellanox Technologies MT27710 Family 
[ConnectX-4 Lx]

On 3/20/26 19:16, Adam Young wrote:
> This breaks on my system:
>
> On 7.0.0 It boots fine.  With net-next/main currently at this commit
>
>
> commit 8737d7194d6d5947c3d7d8813895b44a25b84477 (net-next/main, 
> net-next/HEAD)
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
> Date:   Fri Mar 13 17:28:36 2026 +0100
>
> I get:
>
> [   21.859081] mlx5_core 0005:01:00.0: probe_one:2017:(pid 10): 
> mlx5_shd_init failed with error code -2
> [   21.863266] mlx5_core 0005:01:00.0: probe with driver mlx5_core 
> failed with error -2
> [   21.866360] mlx5_core 0005:01:00.1: probe_one:2017:(pid 10): 
> mlx5_shd_init failed with error code -2
> [   21.869937] mlx5_core 0005:01:00.1: probe with driver mlx5_core 
> failed with error -2
>
>
> I am happy to help debug:   what do you need from me?
>
>
> On 3/12/26 06:04, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Use the previously introduced shared devlink infrastructure to create
>> a shared devlink instance for mlx5 PFs that reside on the same physical
>> chip. The shared instance is identified by the chip's serial number
>> extracted from PCI VPD (V3 keyword, with fallback to serial number
>> for older devices).
>>
>> Each PF that probes calls mlx5_shd_init() which extracts the chip serial
>> number and uses devlink_shd_get() to get or create the shared instance.
>> When a PF is removed, mlx5_shd_uninit() calls devlink_shd_put()
>> to release the reference. The shared instance is automatically destroyed
>> when the last PF is removed.
>>
>> Make the PF devlink instances nested in this shared devlink instance,
>> allowing userspace to identify which PFs belong to the same physical
>> chip.
>>
>> Example:
>>
>> pci/0000:08:00.0: index 0
>>    nested_devlink:
>>      auxiliary/mlx5_core.eth.0
>> devlink_index/1: index 1
>>    nested_devlink:
>>      pci/0000:08:00.0
>>      pci/0000:08:00.1
>> auxiliary/mlx5_core.eth.0: index 2
>> pci/0000:08:00.1: index 3
>>    nested_devlink:
>>      auxiliary/mlx5_core.eth.1
>> auxiliary/mlx5_core.eth.1: index 4
>>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v2->v3:
>> - removed "const" from "sn"
>> - passing driver pointer to devlink_shd_get()
>> ---
>>   .../net/ethernet/mellanox/mlx5/core/Makefile  |  5 +-
>>   .../net/ethernet/mellanox/mlx5/core/main.c    | 17 ++++++
>>   .../ethernet/mellanox/mlx5/core/sh_devlink.c  | 61 +++++++++++++++++++
>>   .../ethernet/mellanox/mlx5/core/sh_devlink.h  | 12 ++++
>>   include/linux/mlx5/driver.h                   |  1 +
>>   5 files changed, 94 insertions(+), 2 deletions(-)
>>   create mode 100644 
>> drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>>   create mode 100644 
>> drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile 
>> b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>> index 8ffa286a18f5..d39fe9c4a87c 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>> @@ -16,8 +16,9 @@ mlx5_core-y :=    main.o cmd.o debugfs.o fw.o eq.o 
>> uar.o pagealloc.o \
>>           transobj.o vport.o sriov.o fs_cmd.o fs_core.o pci_irq.o \
>>           fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o 
>> dev.o events.o wq.o lib/gid.o \
>>           lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o 
>> diag/fs_tracepoint.o \
>> -        diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o 
>> diag/reporter_vnic.o \
>> -        fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o 
>> lib/nv_param.o
>> +        diag/fw_tracer.o diag/crdump.o devlink.o sh_devlink.o 
>> diag/rsc_dump.o \
>> +        diag/reporter_vnic.o fw_reset.o qos.o lib/tout.o lib/aso.o 
>> wc.o fs_pool.o \
>> +        lib/nv_param.o
>>     #
>>   # Netdev basic
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c 
>> b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> index fdc3ba20912e..1c35c3fc3bb3 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> @@ -74,6 +74,7 @@
>>   #include "mlx5_irq.h"
>>   #include "hwmon.h"
>>   #include "lag/lag.h"
>> +#include "sh_devlink.h"
>>     MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
>>   MODULE_DESCRIPTION("Mellanox 5th generation network adapters 
>> (ConnectX series) core driver");
>> @@ -1520,10 +1521,16 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
>>       int err;
>>         devl_lock(devlink);
>> +    if (dev->shd) {
>> +        err = devl_nested_devlink_set(dev->shd, devlink);
>> +        if (err)
>> +            goto unlock;
>> +    }
>>       devl_register(devlink);
>>       err = mlx5_init_one_devl_locked(dev);
>>       if (err)
>>           devl_unregister(devlink);
>> +unlock:
>>       devl_unlock(devlink);
>>       return err;
>>   }
>> @@ -2005,6 +2012,13 @@ static int probe_one(struct pci_dev *pdev, 
>> const struct pci_device_id *id)
>>           goto pci_init_err;
>>       }
>>   +    err = mlx5_shd_init(dev);
>> +    if (err) {
>> +        mlx5_core_err(dev, "mlx5_shd_init failed with error code %d\n",
>> +                  err);
>> +        goto shd_init_err;
>> +    }
>> +
>>       err = mlx5_init_one(dev);
>>       if (err) {
>>           mlx5_core_err(dev, "mlx5_init_one failed with error code 
>> %d\n",
>> @@ -2018,6 +2032,8 @@ static int probe_one(struct pci_dev *pdev, 
>> const struct pci_device_id *id)
>>       return 0;
>>     err_init_one:
>> +    mlx5_shd_uninit(dev);
>> +shd_init_err:
>>       mlx5_pci_close(dev);
>>   pci_init_err:
>>       mlx5_mdev_uninit(dev);
>> @@ -2039,6 +2055,7 @@ static void remove_one(struct pci_dev *pdev)
>>       mlx5_drain_health_wq(dev);
>>       mlx5_sriov_disable(pdev, false);
>>       mlx5_uninit_one(dev);
>> +    mlx5_shd_uninit(dev);
>>       mlx5_pci_close(dev);
>>       mlx5_mdev_uninit(dev);
>>       mlx5_adev_idx_free(dev->priv.adev_idx);
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c 
>> b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>> new file mode 100644
>> index 000000000000..bc33f95302df
>> --- /dev/null
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>> @@ -0,0 +1,61 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>> +/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights 
>> reserved. */
>> +
>> +#include <linux/mlx5/driver.h>
>> +#include <net/devlink.h>
>> +
>> +#include "sh_devlink.h"
>> +
>> +static const struct devlink_ops mlx5_shd_ops = {
>> +};
>> +
>> +int mlx5_shd_init(struct mlx5_core_dev *dev)
>> +{
>> +    u8 *vpd_data __free(kfree) = NULL;
>> +    struct pci_dev *pdev = dev->pdev;
>> +    unsigned int vpd_size, kw_len;
>> +    struct devlink *devlink;
>> +    char *sn, *end;
>> +    int start;
>> +    int err;
>> +
>> +    if (!mlx5_core_is_pf(dev))
>> +        return 0;
>> +
>> +    vpd_data = pci_vpd_alloc(pdev, &vpd_size);
>> +    if (IS_ERR(vpd_data)) {
>> +        err = PTR_ERR(vpd_data);
>> +        return err == -ENODEV ? 0 : err;
>> +    }
>> +    start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3", 
>> &kw_len);
>> +    if (start < 0) {
>> +        /* Fall-back to SN for older devices. */
>> +        start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
>> +                             PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
>> +        if (start < 0)
>> +            return -ENOENT;
>> +    }
>> +    sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
>> +    if (!sn)
>> +        return -ENOMEM;
>> +    /* Firmware may return spaces at the end of the string, strip 
>> it. */
>> +    end = strchrnul(sn, ' ');
>> +    *end = '\0';
>> +
>> +    /* Get or create shared devlink instance */
>> +    devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0, pdev->dev.driver);
>> +    kfree(sn);
>> +    if (!devlink)
>> +        return -ENOMEM;
>> +
>> +    dev->shd = devlink;
>> +    return 0;
>> +}
>> +
>> +void mlx5_shd_uninit(struct mlx5_core_dev *dev)
>> +{
>> +    if (!dev->shd)
>> +        return;
>> +
>> +    devlink_shd_put(dev->shd);
>> +}
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h 
>> b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>> new file mode 100644
>> index 000000000000..8ab8d6940227
>> --- /dev/null
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>> @@ -0,0 +1,12 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>> +/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights 
>> reserved. */
>> +
>> +#ifndef __MLX5_SH_DEVLINK_H__
>> +#define __MLX5_SH_DEVLINK_H__
>> +
>> +#include <linux/mlx5/driver.h>
>> +
>> +int mlx5_shd_init(struct mlx5_core_dev *dev);
>> +void mlx5_shd_uninit(struct mlx5_core_dev *dev);
>> +
>> +#endif /* __MLX5_SH_DEVLINK_H__ */
>> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
>> index 04dcd09f7517..1268fcf35ec7 100644
>> --- a/include/linux/mlx5/driver.h
>> +++ b/include/linux/mlx5/driver.h
>> @@ -798,6 +798,7 @@ struct mlx5_core_dev {
>>       enum mlx5_wc_state wc_state;
>>       /* sync write combining state */
>>       struct mutex wc_state_lock;
>> +    struct devlink *shd;
>>   };
>>     struct mlx5_db {
>

