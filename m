Return-Path: <netdev+bounces-300246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BZYHLRsPM2rm8wUAu9opvQ
	(envelope-from <netdev+bounces-300246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 23:18:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A21F69C824
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 23:18:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=pG+++9Na;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300246-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300246-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 328E6311C312
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 21:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075E143DA49;
	Wed, 17 Jun 2026 21:18:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684DA3FAE0A;
	Wed, 17 Jun 2026 21:18:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781731095; cv=fail; b=BCkh1P4S28lIEchZNLvP6kurFrQtgNkb907MKaCeGYqq/Tyx/wAudJ30LiLrs7AWsqBVIp5A3VXYPmuH+HkZ6yl0sCiNYgSvdnq5fDyjLGmTasqV+JuKmQ0ASKDE7SHZ0ndEIzMPnWo+wqz3B7mxETqg62Ri+tbTt00+E3RRoFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781731095; c=relaxed/simple;
	bh=189A3OUo8OqLuhj2lqa04Psl9K9uDo90SQFeHxKF6Bg=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pWjw9hdIbyJIwdwEHYw7IdZUye1y4rSn/x7lklMPxJGf52mCQWnDUqpNxzHENvmQRV2qa9Sgr1QTfXdbX7yCv2U27uTfSNCyPS5kHh8H9/NzjsIggMa+hm59bRgVzGzpKOutSk3NgxKj711Xv+gGKGwTbSCHs/Rcs4+RWU5PIq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pG+++9Na; arc=fail smtp.client-ip=52.101.85.4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Phj+GOp/JJVTh+r3XQmtZBRbi/hwpJsSepWpTcDDMQc2ZyKAQ0Qh9sI3wBsCUqfVpsBxSePPAR3r6u7PVuzPUQgXkQ+E1E40NnHCuwpFOcDrlEzyzUAgYXj1CwTtvf529VabTRd03ln6U52VpmG3DXTPB/EoMvyDmJA7XeHHot6LA00A54rPTCSdxZ6Us05JTLMvHFtw3wAB0GJBL3H7g5qiMNYXDmlXzYYSZ+S7c5/78B3TINd/4KJqA7dOS6h/hHuPNy2KRBt7CHKECIp9h+DoOLJaXMi0FLqYKrdi6Z6Oc+dvShO+cgYbz9o5yXZ0Qz6ijTc4GzYJ10b956DZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSJhlu+DCU4I4MrdzdznlAjq8l1j5aOC8HQy8+wqNg4=;
 b=gS07LoqAje5jpKVhUic7TwQ02Im6pEfnytyZ+OM9z4jvsPu/R8Vu7vl1EgYOEoc/JKxBvTBx0/gIWRRPNIIhDf4l0T5g6M553isTsdKuf9RyxzS4ivettaeb3XtvkUQKWO+gN9OMbsfKuL6MIy0VljGH+uvBD6f/x+/tALAxTJDBbv414mPFfpruAnp2vJKJs3fiMOAS/pvoAIOl/lqndP0qSV38hR7nR0+u1h2OnGWFDwkX7FkAERxv5u8C2GbFDMf0yUW4MuhZEFayYJGvJQ7mnj4b6Dzo69UHQ+oYYQarwr8ywLfuliQ1SmD21Wm7JYt2n2ZHu9WLAwvn+oM03A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSJhlu+DCU4I4MrdzdznlAjq8l1j5aOC8HQy8+wqNg4=;
 b=pG+++9NaqAEH4idcifQQDqWVOsE37DJzS5QuRv1Er2FGGwfOFT6pth2M235KpGiELyPnkG8jW1tv73Q78kQ6Xn5WddbBHkiXi8+dSPvXLEuWFn01voRRTRbi+XOUZw7cjkvKjnXnrLMXFfezERW1SnXnYA7f/0yPaR7hiUjphTM=
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Wed, 17 Jun 2026 21:18:11 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 21:18:11 +0000
Message-ID: <030c15da-ee85-45fb-8e4d-9e5f46432419@amd.com>
Date: Wed, 17 Jun 2026 22:18:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v27 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20260609215755.8685-1-alejandro.lucero-palau@amd.com>
 <20260609215755.8685-5-alejandro.lucero-palau@amd.com>
 <6a28a206bf61a_4fa78100e4@djbw-dev.notmuch>
 <96ee638f-3b10-4baa-a6df-5a79efee8b8f@amd.com>
 <dcc502fa-1a06-465a-abab-9b039b9c2672@amd.com>
 <50d8e423-8248-4e26-901b-010d14d22e67@amd.com>
 <6a31a948d61f5_9b8551006b@djbw-dev.notmuch>
 <a423702c-05f6-4b4b-9ad4-fcaec2e07957@amd.com>
In-Reply-To: <a423702c-05f6-4b4b-9ad4-fcaec2e07957@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::7) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 171f6d57-552c-42dd-5498-08deccb5ef65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|11063799006|56012099006|6133799003|22082099003|18002099003|4143699003|921020;
X-Microsoft-Antispam-Message-Info:
	EOu9xeYUNj/YM8wj0MwOBSFV3JFTbLhi8KzLyCehErOCejrsesCgrz4La9vIBV9MVvfC0KidzSzC4ZJaalKvaSjuqr6CePB5gy7ShvJElXENzS19/4R6+9DTbhPW1+c3+BZsJEjfuOwhTgea2fvVzQJ2Brr+W6PbM1wwM1al1EHzNluW8F3YP8QTwwMUx43/xVYLh7o1SDN29JHt26cvXwgWiuYmQssptcmVgGziyOlSr1y/rtlvPcvIDHhifdOvL8TwGtdStmftPal7gsa9WSsb+NN956UwBRoIi32u7LIyTIiItJtSVnhwy7E4U8u2DOaKspAOGZd5bB+SS7j87Uzs4xOz0sp24XjbPU/XE8o7Zb5xNI4CF8PI0W+cWlqgrNSeC+A6cix4a5usaP7fxo6ZP9T2DfEE78LeleriJcM4ACDBzhrIpy3DjZ2Ga2FUZuAXiDgpZcoyLA6QtI7MLDilQhl8PN7nPbybtnVTYiT2ggzbxuNfVNK2LZhdYFktgNprP8gEKoOdMdxt3jBY92SMrDCXyioNooYZuKdGAeAaOqaGPo3kt6iKJID+Ucrtumi995qCH3IF8xWvBvGoZjqGpNw0uCJpLA2WLQ354PibVJggt1+usunMlDwnUgoMnjWfJkQNIY+RxLlALpDz31zcoGvhQi3apWtIlOvKh4o8LOOo7XBsCsFV8IKQpoSyuTDNdY1Eh94HT1CoTrwZaQmp/491jLBYPTsz0yQ2sAE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amJEczBYeEpqNVRxKzgxN2MrZlhRbmRJcTVCN2ROUDEraGtzWWJKNFhrdFU0?=
 =?utf-8?B?WkJ4aVFMWW9ua3psNy9aRnNySTZmcEhuMmpjR2RjT0hSWTNKTnNWMHozSEVD?=
 =?utf-8?B?R2RwRFZQMjdvYTRqb1p6Z1JQSUJ2cS93Y2hxVkhKTER3RjMxYUpjSW9ETXJn?=
 =?utf-8?B?dFRQcGcxYzg2UkNyYjBOd3cxd1YrSW9TT3E4Q1p0MVJmN2JoenFXVU9ieThU?=
 =?utf-8?B?T3pudFZoc2dSZVJoVzRNTmJmdWlVcVVDTE4rZkdPbTFnUlZMZ2tCOEVmb3JH?=
 =?utf-8?B?MkJ3S0Rrb0wySFM4eFZTRlFWdjJWcUhVbExzVVpQQXVYVjdmaHVLZENKaitO?=
 =?utf-8?B?YnlQTDBSS0hQYzM1MC9lSmhvVVVXUjBtSlMrbVZZMFZCTE1DbTlETEtyQlVm?=
 =?utf-8?B?Tnp5UEVnUkJaRmtqZWcvS2cwRUx3d0xmblpldUt5YVVLdWw2cVVmenpNU0VE?=
 =?utf-8?B?RFFkRXRQbWM1Wk1CdmxEUG12UkorM0MvYmFhaWtmejFMdVYyU2Q3VVpQT1Ex?=
 =?utf-8?B?Y2t3MTUwM0pSbkRYSUt4T0l1TUFJSzZ0aXJXSytzT1hZbXVlK1Jwbkh2VUx1?=
 =?utf-8?B?b2ZRV1N2R0tLVlJ2OE5qUUkwWGJlZmRaK3RNeGhkMVI1azJLNVZWa0ZTQ1Nz?=
 =?utf-8?B?dzQxcklnMkEyL3lYSXUrWFBqbEtaZldqWmU2YWRGM09wK3ZkMTNVcUdLUlFR?=
 =?utf-8?B?b1ZRcU8ycWxJbXB5TVNsOWtBL3g4RXRBNUhHOU9WaHBNeUNnQk9lWEY0UmdO?=
 =?utf-8?B?YnFmWnRyQmNNeTU3QUlXV2hOQnc1YjAxWW9Rb2RqWkZJS1lsNFpmZEdxbTJR?=
 =?utf-8?B?QTRSVktIMEUvOFV3UkhXR3ZZUThMRWZrd1JteGVhcDl5bVgzaDZQYUNTYUFw?=
 =?utf-8?B?MDlKckdqbDd4RDBzUE9kYW5MWDFINUFSbWExV0o1aDlGYzd1V0xoT0dESTZu?=
 =?utf-8?B?MzdCbGlLQUNNQ1pZcnNrVlhoMEhqY3Z3SzkzTXR6YUJsRDZ0TWlyeTFJQjBa?=
 =?utf-8?B?emRqZ2psUE9aNFVHR08wYmZyT3VZUm4yNXJTSjZWMlptbTRHSXlFZlYyRGVM?=
 =?utf-8?B?QWtudFNxd3Z2ZDg0cHR5c2ZXaVgrTWxpZzQ5dFp0UkNJSHpBQ2lmOXNkN2Jj?=
 =?utf-8?B?MTNtaUNFR21xaVZvaDRWWEJlakVqdHpTT3Q4UStLMmdab3orNmlGQTM4Njlq?=
 =?utf-8?B?VWdyTmFiQ3R0ZHplTW8xNmFPMlRPMWRndWdkU3pOdWJiMlhRVnFSUDlDN2FB?=
 =?utf-8?B?OUtRdGRxSnhva3laWlFRUnlJeWlaaXlLdGxZVE41R2FtMGg3cmZFMFVpQk81?=
 =?utf-8?B?OVJ3RmF1RDc4aGI4SkZjRWI0YUtnbU5hOHBzOFRmcHpyZ2Y3L09rTmM4NURn?=
 =?utf-8?B?R1U5Sjk2VXYrVUpzR25XdFBlVVFNSUYvZkp6U2dSZ1RHaG9qVU9DSlNqMjZW?=
 =?utf-8?B?LzZ3UXRKenF4NklROFlrWFlNRkQ2ZVVBdWJOM1l5STM4a24xcmhUSHdLNWdz?=
 =?utf-8?B?ZVRGVk12NXNraDFhR2Y0TnNhL3BvdWdxTU9KODh5eFd5ZWljN2xjUTNZSFd6?=
 =?utf-8?B?RHZ6TFBlaWZacUorR3F1NXZPYkFEMzhOSFR0VDV3azM4eGVJL1czVEV1alRM?=
 =?utf-8?B?b3k0Ym1wMzJVaDRFMEpNTGozbDN0aDZoSGJTZUU1NFpqcDhmSTR5WlFvcCtN?=
 =?utf-8?B?VzhjVXRlWlE3VXQvcXZOaHVxUThyRVhTYUVRZGVLK3lQTEpPRmMvZ216NHRE?=
 =?utf-8?B?V3FWVTJPMFB4eFdnTldHN1ZlNEJBQjU5S2dXVkE3NXRFNkdhcGc0U1NnN01K?=
 =?utf-8?B?ZW9aVjkyV1NMM0VodEpPempIUGRDYWU1SVRyVHdtVi84WjlHT0Vlai9qb3FO?=
 =?utf-8?B?ckZNNTdqU2dFTTNxeHkxb0F2UlZlWWZwNlNWaHAzeGhmWDEwdHg1enRzcmdJ?=
 =?utf-8?B?QUZxWndQSzF1dTZmd3FaUVBzZ1paWnVuZ25OQy9RUElDcHJJQTA3YWp3ODVL?=
 =?utf-8?B?a3ZFdlVRb3B6cjJCSTdYWHY5RFo2TkZwYXhPblpqVXN1NWZEeXhQQUh0WnFW?=
 =?utf-8?B?aWN1cFhEZ05zUjBpeEw5ZmpvbWN1MEJheHpSZmt5Q1UrUmtIOHR1ajgzME9Y?=
 =?utf-8?B?cFFIcnFPa1E1THJiZHUvYzdxNDBxVHJlSXQ0SGtRUDkxZHc3eUw4RU5VM2VO?=
 =?utf-8?B?cUJLUFhZTmhXaXAzbDVRdGhySXlhOEZJdHVLQVBDVC9zT1N3SDlkSVcxeEpK?=
 =?utf-8?B?ZGZidm9DT1VyYkx2bzlGU3BUdmNFZWgzYm9TQ0F0VHV6WmdJdTBpVDF6R21n?=
 =?utf-8?B?VHB6Rmg1WWIxQzAxREd4VE1PMWNVM2ZmVnFLYU5NOVl4RkRFcmJNdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171f6d57-552c-42dd-5498-08deccb5ef65
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 21:18:11.3282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HnHKdrfKnUK7DSlx2rR6ZczyVMdRir0vcUqDUG7KboomSQxx3fpSQRdT6QqJ1kjtt3YZ+Po0mgBA4Y7ahMOfDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300246-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A21F69C824


On 6/17/26 10:42, Alejandro Lucero Palau wrote:
>
> On 6/16/26 20:51, Dan Williams (nvidia) wrote:
>> Alejandro Lucero Palau wrote:
>>> On 6/10/26 14:56, Alejandro Lucero Palau wrote:
>>>> On 6/10/26 07:10, Alejandro Lucero Palau wrote:
>>>>> On 6/10/26 00:30, Dan Williams (nvidia) wrote:
>>>>>> alejandro.lucero-palau@ wrote:
>>>>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>>>>
>>>>>>> Use core API for safely obtain the CXL range linked to an HDM
>>>>>>> committed
>>>>>>> by the BIOS. Map such a range for being used as the ctpio buffer.
>>>>>>>
>>>>>>> A potential user space action through sysfs unbinding or core cxl
>>>>>>> modules remove will trigger sfc driver device detachment, with that
>>>>>>> case
>>>>>>> not racing with this mapping as this is done during driver probe 
>>>>>>> and
>>>>>>> therefore protected with device lock against those user space 
>>>>>>> actions.
>>>>>>>
>>>>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>>>>> ---
>>>>>>>    drivers/net/ethernet/sfc/efx.c     |  1 +
>>>>>>>    drivers/net/ethernet/sfc/efx_cxl.c | 24 ++++++++++++++++++++++++
>>>>>>>    drivers/net/ethernet/sfc/efx_cxl.h |  3 +++
>>>>>>>    3 files changed, 28 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/net/ethernet/sfc/efx.c
>>>>>>> b/drivers/net/ethernet/sfc/efx.c
>>>>>>> index 90ccbe310386..578054c21e79 100644
>>>>>>> --- a/drivers/net/ethernet/sfc/efx.c
>>>>>>> +++ b/drivers/net/ethernet/sfc/efx.c
>>>>>>> @@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev
>>>>>>> *pci_dev)
>>>>>>>        efx_fini_io(efx);
>>>>>>>          probe_data = container_of(efx, struct efx_probe_data, 
>>>>>>> efx);
>>>>>>> +    efx_cxl_exit(probe_data);
>>>>>>>          pci_dbg(efx->pci_dev, "shutdown successful\n");
>>>>>>>    diff --git a/drivers/net/ethernet/sfc/efx_cxl.c
>>>>>>> b/drivers/net/ethernet/sfc/efx_cxl.c
>>>>>>> index 4d55c08cf2a1..d5766a40e2cf 100644
>>>>>>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>>>>>>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>>>>>>> @@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data 
>>>>>>> *probe_data)
>>>>>>>    {
>>>>>>>        struct efx_nic *efx = &probe_data->efx;
>>>>>>>        struct pci_dev *pci_dev = efx->pci_dev;
>>>>>>> +    struct range cxl_pio_range;
>>>>>>>        struct efx_cxl *cxl;
>>>>>>>        u16 dvsec;
>>>>>>>        int rc;
>>>>>>> @@ -75,9 +76,32 @@ int efx_cxl_init(struct efx_probe_data 
>>>>>>> *probe_data)
>>>>>>>            return -ENODEV;
>>>>>>>        }
>>>>>>>    +    cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, 
>>>>>>> &cxl_pio_range);
>>>>>>> +    if (IS_ERR(cxl->cxlmd)) {
>>>>>>> +        pci_err(pci_dev, "CXL accel memdev creation failed\n");
>>>>>>> +        return PTR_ERR(cxl->cxlmd);
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
>>>>>>> +                    range_len(&cxl_pio_range));
>>>>>>> +    if (!cxl->ctpio_cxl) {
>>>>>>> +        pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
>>>>>>> +            &cxl_pio_range);
>>>>>>> +        return -ENOMEM;
>>>>>> Dave caught the iounmap leak, but another concern is since you 
>>>>>> want to
>>>>>> continue operation if efx_cxl_init() fails then you probably also 
>>>>>> want
>>>>>> to release the successful attachment to the CXL domain if this 
>>>>>> happens.
>>>>>
>>>>> I will do that.
>>>>>
>>>> Looking at this issue, I think an error when creating the memdev or
>>>> during the region attach triggers the memdev removal, but ...
>>>>
>>>>
>>>>>> Minor since something else is likely to fail if ioremap is not
>>>>>> reliable.
>>>>
>>>> .. if we want to specifically do that with an unlikely (but possible)
>>>> ioremap error something else needs to be exported like
>>>> cxl_memdev_unregister(). Are you happy with that approach?
>>>>
>>> I have just tested with this:
>>>
>>> +void cxl_memdev_remove(void *_cxlmd)
>>> +{
>>> +       struct cxl_memdev *cxlmd = _cxlmd;
>>> +       struct device *dev = &cxlmd->dev;
>>> +
>>> +       devm_remove_action_nowarn(cxlmd->cxlds->dev, 
>>> cxl_memdev_unregister,
>>> +                                 cxlmd);
>>> +
>>> +       cdev_device_del(&cxlmd->cdev, dev);
>>> +       cxl_memdev_shutdown(dev);
>>> +       put_device(dev);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_remove, "CXL");
>>>
>>>
>>> only called if the ioremap fails.
>>>
>>>
>>> Please, let me know if you like this approach before sending another
>>> version.
>> A devres group can automatically cleanup after devm_cxl_memdev_probe()
>> in the error path with no new exports needed from the CXL core.
>> Something like:
>>
>>          void *group = devres_open_group(cxl->cxlds.dev, NULL, 
>> GFP_KERNEL);
>>          int rc = 0;
>>
>>          if (!group)
>>                  return -ENOMEM;
>>                   cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, 
>> &cxl_pio_range);
>>          if (IS_ERR(cxl->cxlmd)) {
>>                  pci_err(pci_dev, "CXL accel memdev creation failed\n");
>>                  rc = PTR_ERR(cxl->cxlmd);
>>                  goto out;
>>          }
>>
>>          cxl->ctpio_cxl =
>>                  ioremap_wc(cxl_pio_range.start, 
>> range_len(&cxl_pio_range));
>>          if (!cxl->ctpio_cxl) {
>>                  pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
>>                          &cxl_pio_range);
>>                  rc = -ENOMEM;
>>          }
>>
>> out:
>>          if (rc)
>>                  devres_release_group(group);
>>          else
>>                  devres_remove_group(group);
>>          return rc;
>
>
> OK. I will use this in v28 instead of that export.
>

Adding this implies the full driver is detached from the device. The 
same can be obtained changing the check of efx_cxl_init() call and make 
the probe to fail if an error is returned.


I prefer to do this after discussing this internally. After all, if 
CXL.mem is there and the related initialization fails, this is not 
expected and it should be fixed.


Sending v28 shortly.



>
> Thanks
>

