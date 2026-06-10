Return-Path: <netdev+bounces-297460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nbKaAzIBKWrkOgMAu9opvQ
	(envelope-from <netdev+bounces-297460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:16:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BDA666237
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:16:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=AH2rhU6+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297460-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297460-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D83143161101
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCE92F5A13;
	Wed, 10 Jun 2026 06:10:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396AB3438BD;
	Wed, 10 Jun 2026 06:10:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071855; cv=fail; b=bZyf6HQNqRmgg+j16pIcfLgrltF/R/sAexDHfO1lhV1kOsn/4om7nqF1fsdCU/FSR77cmOEZIqcGjUQ/sG9fdp5ePIm6yBSIMoTvq5Mo1fpcvZgxIKdJ3UPLRdJavzO/IymbkESSG1qZvRTMkGEfN6nOrZXRlklQZBGMFFBxjPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071855; c=relaxed/simple;
	bh=u431/h1BN5GjFEN6jHRwswsDaGotgnNIBZVFPApKAW0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c2OiSRiTerWzPWol2fnA8h5XWsI3khX9W+3l8deJ1pOmJhdT+otHeRC/RZY5Wrbs6ju/9uTPLXdFkVoCLUlsfwwLtgeYUjiKy6Af3XBWyQBM60vt+4SStVeVwn1XU1S7ssWqJbEkOwdQ8SkjpMoFfrYMfrOjDQVHX5uNYKODkQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AH2rhU6+; arc=fail smtp.client-ip=40.107.208.25
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7b2US+Ff6OKlRjFKepyiuaFqB7qi68XGgHgtjUrhE8G3fT6fcmZ6RpOSl3wEWZvdATqXfnrsrh8IMWWsVriEbjU+oWQINGY2X4saDO1mrG8OJTsi7xdnlHw3HyFWpPQRpgpT7GCkNWPXyfcZwZy6vY65v2BMcs4hCNX56wqsbOkRudlHDRXEaaB5EwYwGIhznov0cBsZO1RqlLCeCow/4SrL9LLvmTX6jGY52vneunqt5v3r012mj0cfHOiRgpUHzq1q319vqZGjdBXNxJA6G8mUgkOuEyhmN90BoRZHJ1jXXiaZfR8inno/E0pxbtvfxwDlgzGJorLTYDHVrnTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ks1K7Dnerk5Tsx6tIwDWDmLu+/sHP3v7+X23sJhTcws=;
 b=n+9wqwxHB23xPT87/Jdm7JV/232qS5FDkG8hZFMJY5ZHd7/kfOoERntv4rfBmHDUtaKtzAoAnJTi9CKi63gJt/suAi02aqA8qdqWBDgWghx/rLbYRNpQYiocSwzNS7quNc9Auk3NvkmIHJvoYfY/AHN6ByGcn3N74VAO9daImz2xCLGiI1pHUtQH8Md9BE3SpooWahCqfuQ2C0VaOeIlNM+IPTB12zKCwaLH1fkXW2xwvTwLhnrUaHlEqkL7cMF2GQtLx6hYXKCxdt0M1sXPaXoQLuA5ByFqSryhiCwzm4J7zg31mr4oVCZ4XoHcfabzIBuNzFK9WksS2j4WzJNVaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ks1K7Dnerk5Tsx6tIwDWDmLu+/sHP3v7+X23sJhTcws=;
 b=AH2rhU6+8X7uB7Zw+E/N43RUZUi5WRUugbObAj52naxX879iMeNLDx8w7AsDgKpj7fyXxnJCVAx7VOGAIjfRwzdN+sGQXeCPFmwrSvEyay0HOkqPW5WmnejAtYvoBf15JKd9l8hukWua/jGRLqYMcm2sYwyKlAh42Fwl7W0V8MM=
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Wed, 10 Jun 2026
 06:10:51 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 06:10:51 +0000
Message-ID: <96ee638f-3b10-4baa-a6df-5a79efee8b8f@amd.com>
Date: Wed, 10 Jun 2026 07:10:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v27 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
Content-Language: en-US
To: "Dan Williams (nvidia)" <djbw@kernel.org>,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20260609215755.8685-1-alejandro.lucero-palau@amd.com>
 <20260609215755.8685-5-alejandro.lucero-palau@amd.com>
 <6a28a206bf61a_4fa78100e4@djbw-dev.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6a28a206bf61a_4fa78100e4@djbw-dev.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0632.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::22) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|PH7PR12MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d78b31-9747-4a5a-a177-08dec6b7058d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|921020|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	bYTm6XFdkDGcKSG5p1QaNiqnqYWT5pF2k84tpxyW1buwM4NhNVGkKSxSRi615za6r+XtPh44vtdf7hQxdLsO3bAMHmxUhXn+zIK/gDyOnevJvMeduWbxt/EwzQTUYYODAg7Ix7S1bHPqpUcDQczKNfQHirmMKDPqfHRdT/uKm7dWM/VNAOXOPs8hMjWl3OyBIek/pjiJ52FFiTtz4qT7BIz3BAt3KWc+OKKeu34IzwyyoqOK3CtpHGfoIdIDFML4uHXvqFntjt7rcbx6s/GSUHzrcIvny7wm50u5AqK52DxijaB62NMqCNdUSmgChEMUOhsdjw5yEBOlkD7e28hJWvXK1LqXxuflVnn0CghkjseRcKeLgkDQT8C/zwlyrLMnxUKv1tN5XLsMm2clnLF3EIo8boAygf/XblKjOe05JN3YQ15yxUhKc6K4dfLWUK9PX4NPsfu5U/czPrAq8fejMKaOVG5Gr//P11RawSUZ2/9s+ln2Us5vZOd9mC5I4IVj7dSU06AmtoE3BcNBhwX3nD/XQWU9eqaFQVf8wQ5SyGTkQdDslH3oJKn84wRyx/V9OfjdhDIsxPXIn+EwYL3Pjw/NdsGb4/DG3NbCgiDlZmzSIB1gTAWAREjX3eXTj/DcVLRH5geUVBe8tZiOD6CdD8jmPTvgJnS7AAuU8UcIzOXz7q/wCOvjS0X2GeZ8excqQRAqjIFCxjmNsb5vpLocngSZZcM6TCPvv6d+d8zewU1FAsS+2mMjX2Dt8s0EogAp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(921020)(6133799003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFNOMm9lRWMxUm4yRlVXZElCWHJ1SzgrMnBJeUMxcDB0NmV0NmptS3RJRVcr?=
 =?utf-8?B?K0VDbnBONTR5U2I1NHBRa2VxTlY5Z0RFbVAyUmlGcDJDa1pMQ3pDOXV5bjJ1?=
 =?utf-8?B?UWE0VkY2UXlReDVMOUdqeHFCZ01uRGlycFFtc2p3VXBhRmRqd243V0JYcmM0?=
 =?utf-8?B?VlVvTGtOcXZ4TVZ3M1ROSTB6ZkNUT2MwYlBkTnFJcEkrYU9NNHJGUnBPNFlj?=
 =?utf-8?B?ZWJQblJQL1BGSE9PMWdJZHQzSUM4dTNyNVFXRStKcW5DcnZJUklQZ05zTTlB?=
 =?utf-8?B?TGZocVUrNW9renR1eTQyeXl1cUtDTjBkUUFzdGNMRURWSXJOcHFNSXlrR1Zv?=
 =?utf-8?B?QWtEMzZVb3NmS2hlcVBKK3NRZ1lBU0dvT3RhZ3RMSzlSbGV3ZnRWcEc1YlE5?=
 =?utf-8?B?Q3IwZUs0dXFGWlBEdVZkK1VieCttYStMUjhXN2pYSEVkRXRxdVJnZW5rR0xw?=
 =?utf-8?B?aEVzUTI3R0I0Y3BBVXZWcXdJTUxkOUNuSGNsWUloMUJtTkFvV0F4MGlHQ1da?=
 =?utf-8?B?WUh2bXlDampFV0U1SEh6Ym9RdVgrdk9VSHhHSWtEYm1nNmpVYlpOZ015U0RS?=
 =?utf-8?B?VWV3ZkorU2I3Q0hSaGpDb3ZWZjk2S1Z6ZGM2M3crZUtlV1pMa3R2RGk1amsr?=
 =?utf-8?B?Q1NjQUdHVEJuM3V5c2xudEhpU3BOeHgxb3VadWs4UDhoSnh1S3U5andaUE96?=
 =?utf-8?B?MjZOM01BbkZzOStMcjZMRDhKQ3lRamVWNlhPSVUwSlhuK1k2RjFMbW1DK0JP?=
 =?utf-8?B?eVV5aUQycm12TjVuNVYwV2hib1JzN01XYlliWjJpVmV2RXdJY2wvT1dNY296?=
 =?utf-8?B?V3pjb0dGSHF0bWhmOWJ3Zm5xaHFvVlRnRmM4US9mVWdiUUZ2bTJhWitYcjFu?=
 =?utf-8?B?V2pHdVBhR0FWTzhVNkp5dGgrTVFmWWhsZkI5QzFBcEdvR0tSOVYvZStvLzRU?=
 =?utf-8?B?cjdKdXBuM3lIeWVVRnh4bldEMTRVN2NhVm5rZGlwK3hrZ05pVWZDZDE4NFRh?=
 =?utf-8?B?K2ZXYURBbTNKRnZnSy9MS0ZsUUZ0K2JEKzMzNmRpZkduWk9uWXpUMHF3Q0M1?=
 =?utf-8?B?dC9pS1JJRXNHNDhMMTBGak1tK3dKWkhHT0E1YVNWd1kwY0xSZzNzRG8wMTlo?=
 =?utf-8?B?TXNrTTJSUmx2QVd0UjdTUTlCd2JzUXNiRDI2K2Jna3dQaEdDT0xwWHh1NURw?=
 =?utf-8?B?ZEorTkM4aEY3K2hvWG0zZVc3Slg1RllVejRqaE5oWWh5YnlPOFEvUEtwTGRX?=
 =?utf-8?B?cUx1WFVNN3Y5ZS9lSGdsVGZoZEJkV3FNZDFUQStLb2ZLeDlES01hMkVTeStZ?=
 =?utf-8?B?MloxUVFvZnE3bFJVTWpvM285OUxuWXczOFNWaHBFajNBaTY4b3hSSzVMWlJL?=
 =?utf-8?B?ZnlHSzZkbGVUa1FWUjNxV0duMmtsSXRoYjFLR08vb0E1ZnhrdVVtTkpXVktH?=
 =?utf-8?B?Vm5WVjZKQlFyZC9Eenk2aTBCdExodzNTc041WnFMbWJlTHc2eit5aFFjUTJC?=
 =?utf-8?B?TXd2bHNyZTZJQUVwV0tYc3JpRlRpZlc1NU1YT3NTdElyNzU4MzkvTWx4VzZn?=
 =?utf-8?B?Wi9UVWhRU2dpWmFrR2xnU2dOUW5vRCswUVVHTGNKUmVxSzNPeHAwRCsyTWpD?=
 =?utf-8?B?SkJNL3FrV2pYSmVhcUkrMFZCcXF4MU5zZDJwUDEyNWFrbGxPdUNKQ1EzeTZY?=
 =?utf-8?B?VWtnUnRIV2RoajZIQmZIWWVvVGRnL3pvN0Vsdm5NTzhRcW1kSHRkVXdrTzdn?=
 =?utf-8?B?RXRtejdJVDJ0MWdtaTBISEpySFBaU1pxYi9kdWlhMkFacHFtZU5xWDZ3S21y?=
 =?utf-8?B?ckJEQXNUL29rR3dXUUJRNnhjVHJ1WEE5VmE2ZzJxczdPT0hCZXd3R2I2eWgz?=
 =?utf-8?B?bit3OXYvZlNTNFYzcmFoVTRBdGNlU3prRW1LemNZcndKeGhUcXh6Vzk4OFJi?=
 =?utf-8?B?QS9aRGc3djdQeWUwSjlXb21maWJZVDJiMHBpb2k5c0k4dC9qQ0hzTDFyTE9p?=
 =?utf-8?B?UmxFZ2s3cXJVaW5LanlMbnEzWTZjcDdaUUFZRVl0RDZ1TVN6dzdIbzBnVmhi?=
 =?utf-8?B?djVDLzRwMkZ0WnVZS00yaG0wQXJWMFV0aC9LcnRiNXZybnk4TDVEbjd1Q0Jh?=
 =?utf-8?B?UmNNNEJxK24veEhHQ3I3QTAzb1NWc2N3RCt5amFMLzN2dmFKd3JTckZFcGJY?=
 =?utf-8?B?YUF1bEdXMkZ2bVU4S1VPNlc1V0V6bVN6Q1FSVldNN0JLcEhxMkVLMG1FRCto?=
 =?utf-8?B?UkI5RmlLa0IySkxpZThRTENJcFo5THhqOW5sbHF2bS84K3hHN2pteDNPTjRy?=
 =?utf-8?B?eXRXYjFJRXgrOTNSWVFMbDdtSmQxRStrMEZTSkJYZXRFRS9FeTlEQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d78b31-9747-4a5a-a177-08dec6b7058d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:10:50.9583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLfjtTdUXV3JDSsTffs7I8sEy/RuEo/3vmFb2rZTYPoU5Nt3DULgJzi1CRLYOg5r5JophZryyRClB0caSqSvmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5757
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297460-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:djbw@kernel.org,m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78BDA666237


On 6/10/26 00:30, Dan Williams (nvidia) wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use core API for safely obtain the CXL range linked to an HDM committed
>> by the BIOS. Map such a range for being used as the ctpio buffer.
>>
>> A potential user space action through sysfs unbinding or core cxl
>> modules remove will trigger sfc driver device detachment, with that case
>> not racing with this mapping as this is done during driver probe and
>> therefore protected with device lock against those user space actions.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/efx.c     |  1 +
>>   drivers/net/ethernet/sfc/efx_cxl.c | 24 ++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.h |  3 +++
>>   3 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
>> index 90ccbe310386..578054c21e79 100644
>> --- a/drivers/net/ethernet/sfc/efx.c
>> +++ b/drivers/net/ethernet/sfc/efx.c
>> @@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>>   	efx_fini_io(efx);
>>   
>>   	probe_data = container_of(efx, struct efx_probe_data, efx);
>> +	efx_cxl_exit(probe_data);
>>   
>>   	pci_dbg(efx->pci_dev, "shutdown successful\n");
>>   
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 4d55c08cf2a1..d5766a40e2cf 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   {
>>   	struct efx_nic *efx = &probe_data->efx;
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>> +	struct range cxl_pio_range;
>>   	struct efx_cxl *cxl;
>>   	u16 dvsec;
>>   	int rc;
>> @@ -75,9 +76,32 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		return -ENODEV;
>>   	}
>>   
>> +	cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
>> +	if (IS_ERR(cxl->cxlmd)) {
>> +		pci_err(pci_dev, "CXL accel memdev creation failed\n");
>> +		return PTR_ERR(cxl->cxlmd);
>> +	}
>> +
>> +	cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
>> +				    range_len(&cxl_pio_range));
>> +	if (!cxl->ctpio_cxl) {
>> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
>> +			&cxl_pio_range);
>> +		return -ENOMEM;
> Dave caught the iounmap leak, but another concern is since you want to
> continue operation if efx_cxl_init() fails then you probably also want
> to release the successful attachment to the CXL domain if this happens.


I will do that.


> Minor since something else is likely to fail if ioremap is not reliable.
>
> Otherwise this looks good and with those fixed up the Reviewed-by still
> stands.


No Reviewed-by yet ... this is a new patch after your series removing 
previous functionality.


Thanks


