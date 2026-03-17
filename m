Return-Path: <netdev+bounces-268750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKBIJ8HKuWl/NgIAu9opvQ
	(envelope-from <netdev+bounces-268750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:42:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 438672B2D4E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99A03303C60B
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 21:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28A5395261;
	Tue, 17 Mar 2026 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="gdjVQuup"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020132.outbound.protection.outlook.com [52.101.56.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6970531065B
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773783741; cv=fail; b=cBlxMfOfaoOISe6BfmLHqTRG2PpUrVIVvskHD/Sbu6LmsdOIFBufCJF00QYHVUn2W88zmr5Ca9SxQTcYVFICwEvsZg79S296rrsZ7NqLWqj9UBIUf1UUsFWLfG9Qp+RapY1SV/XKgQB8FVCxvRlvofNvRq0x5qjelxoR3Jawm1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773783741; c=relaxed/simple;
	bh=dRsUAh1OSkJp6M4L0TMvqwm5FfctszL/rKM4XxUt9tU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MhIk83WRGEbE1pwTfmsi79E4e+HrCUgiQt0lvCefACoVgI09x7YalEbscp1NprmIrb59Cis4p9E3k/HxGpMgucWiei0ahM/S1eQvdma5rv1O8VI/iEWrVjsWXOH+eVK6ujLiOXZ9j7iFnlwWOJQjllOvjzstFu0PWNADNGnaTdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=gdjVQuup reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.56.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VINE/J02r/e53iGcy9mw5otvf1jJEgMS0NSQUU/XvwZyEpfrMwNMwXBoKjbaMdvqxCwM6hphvJL+RkLkFaoQxxzhQIWJ2sG0l97iT+MqdiK8XLATINoSYeB8slMLG6APo8VMh3i0Hnpfw2GhBe0GfcO6wVrdjex8eP/qAN2RyUaSqQdwr0NYS6y97kYlTv0jGxApkxQMYbQ0sTlla4ZoTPNsyYHz/texp2zRHVEGymHguHesKDjysOjiux3UtinPajQK8vrVEzfuPuuKzTddUbgUnxfIAmNYEfYdvFw9s245v2WcqB0AMCoXF91CbcfAu0Aj8hfn9L9VsUrAqdYXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtMpLglM3rJotz2DbGwWZZjqnYOx2cPnIa7Se8sL624=;
 b=FmjywyTd1vbhwWuZ7mhTuS4lwOKFboIbd1yQWU8x5t7jyL76+4kVg083s9j9HqA/FE1LkK7P8OY+CPrn9NbRxa+uCyG+oDfjUls+U/DGLqdEbQj9RtIqOtoQlZxaoJIaS+gpY4Qk999IomNRCAE5LkxyyDALKzK5rwx6FSn+IEn2ixKD7oLsih+YHtFn0HoHCUJT58VYhYGssemys1OI2/r1pvydaLzuP5lD4R12o7gebrvsR4bQO4mk2KhKhNcLTZ8WwfKrkdbiN6d8qJr2ZkLEYrXsZXjJjQJ7U3Ue+nYc6cZoqnEzH0uj2nTNTLakv5VtEDgAoPBtGKPniHn3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtMpLglM3rJotz2DbGwWZZjqnYOx2cPnIa7Se8sL624=;
 b=gdjVQuupm3l90Jz2dFxUIgC7yoYhBzv7i3meqC8E6zPMtV/2gRWeuoUxG39UlMnP2ugwiKG+jvSVLS8eG8euIzD9RGv6sn226Nvzm0sGWE4pG9ncOEq7YBhgPwZtYch3UknGEy15FPQajZrjzZbyRJeCMSuuzbP1WnKHjW19BKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CO1PR01MB8939.prod.exchangelabs.com (2603:10b6:303:275::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.22; Tue, 17 Mar 2026 21:42:17 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 21:42:16 +0000
Message-ID: <499587e4-0fff-4351-9b43-316d1660962d@amperemail.onmicrosoft.com>
Date: Tue, 17 Mar 2026 17:42:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: fbnic qemu is open source
To: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Zinc Lim <zinclim@meta.com>, willemb@google.com
References: <20260309113852.2c654de5@kernel.org>
 <CAHS8izMBx3j1nJwJ=b+ctGoJuEgTtMx8WsH2y-W=Sine+wo_3Q@mail.gmail.com>
 <20260317143446.4afabb97@kernel.org>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20260317143446.4afabb97@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::21) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CO1PR01MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: 772d8351-0598-4f08-12e9-08de846e0ec5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|55112099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	HEbgPkppmfZ8wdQQmT+LMwGQxUNVT33E6rpJwdvUao76SvGdpQfA11UIFS4mA2CvyE2V6BEz7wLRBfPW1AOArCGjUfIi54UIksM5AZHNvzqxC5LztfUC32u85f2gPR37SDJ+8RaAnP/n2i6Ym8kgp4JkD8zzwMXrVE5KfM9JT7C2zExCmDJLxAK6H/4Qsn8WDMDE6ojBVDbkUfQIYa1jXSzrIQyvqr/y74PvO/1BobvDmrh/PZQ+qv+wX2LHpA5VZPKfMss0ox1arG+XMs/cgIId9ah/do3gY9yfXvkljWBJ45PMHCH8vmr01UG6kE3tSg54xRcGAzdvts1Ovx2ShjVzJfbmncLfkWj9nzaRhOBTeB/iAkZkE5wiWXpmZI1MfF7FNHEG9NxcZOL4yt1mKhenrx//BWg9tzBf4a0GJBwr6w7bCe/ENSuSiupztkGp73TPM03aT6eci8QZACuUlL1VF6L/72AZ+6J+Nn23EjMnP1b43F9Bit7mCM3WxOXxslDZc9gFC3AbRD+V2ziyoYa9i9wo2BaXajXAILDpIjY0AG4B+xLLqHH1yjgn09Viyg6BHhdaGP8BKjodqPlOED1HR6H3DIFfuTRQiu8BOcy27SZt8bk+uPSUtSjS88mOL9EVp7I7Xu8WJkhkyjPRpkSdNZHDWkBtrw0EH/pO9FYK191TRGxtbFMNzjjiT+mxvJ8RohgqT9SdYu12cf5SGBzVYJtTVOsVTMyS8iqNNbg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(55112099003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3BaUXJkZ284OWM4SzlwRmRJdGxlOXh3R0xmRzBhYWZLUTVnRmRCTVVJbW5L?=
 =?utf-8?B?bTMvditNOG1Jd0xEZHIzcmJUaDlGOGs1MnNRWjQ1ejh4SkdsSnlzRGJSS1FH?=
 =?utf-8?B?MHd6NTVpRDVibmNITHRVSDdvdHVzRUdOSXdlVnRJaTg2Q3YvL0VDUDBaZllG?=
 =?utf-8?B?Q0c4YlhYWFBYVjNLVENhMGRyY05BUmJOVlFJaEV3SmZLU0JkUUxaVEI2WXpx?=
 =?utf-8?B?UWViM3Irb0I3U3oxSmllSWRVcnBaVTJ2TjJxc1JNaEpzQWJLSkFHN1IzRnVJ?=
 =?utf-8?B?NXd4TkJIWlN1M0tNc1ZqdGFSbDRzdWVwQlZxbnpLWjdxczZpTGhzeFAvRVN5?=
 =?utf-8?B?ZjhIVE1rdlFWU3FxQldjczVhQmpUUlpBbVFGdmNpNktGM3ZzRzJNV2NuR0RW?=
 =?utf-8?B?TVd0cjUvQVJVMW1nZHQ2dzlRUnVlZGY2S1ZGQytSZ2lYYW5iL0NicXorTE1H?=
 =?utf-8?B?elo2ajYvWDdTTFg0SlplWjdWRDBLQVkxajd3N0ZFajFJMlBTSU01WlR2K21L?=
 =?utf-8?B?VkZQVzlpbWU0R3g5elNQNHROc2hVZnVxbmVMQTZHNXpQbzdKWm5ka2xJbnow?=
 =?utf-8?B?YytNYUJBKzJIVlQ5NERmc2xub2MxNUZnZWZGdWl2S0RmNTRBYkpSbXpjcnZD?=
 =?utf-8?B?YWtZZ3FUZXYxNjR0dnJiRjRsR21qVVgxTGtKZ1pRbGxabjZhUnlDS3I1VE8v?=
 =?utf-8?B?U1ZReE12ZHdJMEJDNDRBVEg1eGpwUTFBYkZVKy9mbjFXY2huT1JFSk82TEwx?=
 =?utf-8?B?K2N0aGEzbnptditCYk13QzVmeU5uVEZIOXgwdC9NT1o4R0xOM0IzOG5EWVZI?=
 =?utf-8?B?dDB3REliL2VkQzllSmtpams5eWRHRTJqRFNOWGtTWktmZ2hXb0dmbWdKbFZU?=
 =?utf-8?B?QzNBWWpoVkRZa04xZ3pvcFNHaWFtSjk0SXoxS2pZQkIwRGZhZHdudmVNTXNi?=
 =?utf-8?B?VG5vYUJCRCt5SFdGVUhyUGtnaWc3VlJKamVVTXJtaFFlRnRENWRnWXdpMTNG?=
 =?utf-8?B?ZVQ0VEpXRjdicHBsdUFFVlIwMzRuRjRnVy9odWdRNXk3SlhQKzByWmlNaTlw?=
 =?utf-8?B?ckpzT3hrQnQ0UjUyMm5LL3Q0VHFHcnMxc1Vwc0JVUlV3RnJvY3BIRDJkRkh5?=
 =?utf-8?B?UFJQU2dleHlDbTFoZlk5TER5SGtPV0ZuSWxHZFlLanRkTUpNWVB5M3g3Nmlr?=
 =?utf-8?B?RzJWbW1TV0QrYjRkMkxQYTR1Nmd1eUFBalFPMnZYcWc4ZjdXRFgyRVVvUVBq?=
 =?utf-8?B?YUxNenNiODVZbldwYUIxVlhpbkQ2cUVxaFFFTkVpNlFqbC8xTHdoTWk5KzFp?=
 =?utf-8?B?c3p3UVdNbnNUL0NGVzFWTjZUcldqUzc5NEZLNTcyVHk1TFpqRkNjc2tkMjJs?=
 =?utf-8?B?MktQdU9zRnpzL2txQXlOOGNMemRvQUN4ZnVUbHM5SG15YTBiQ29EeVNuVVBa?=
 =?utf-8?B?cWljY09rUVc3ZHduejhZUHpUTWs3V3hURkZJZ1lGcTl4QnRlWk1uclg1aUJJ?=
 =?utf-8?B?enBycFRWbVdzNGZiOTlsMlVuZVZyREF4akdlamwwU0ZMd3VPbkRwd1RBK3ZY?=
 =?utf-8?B?WHhGblc4RG5mV1d6K2RjRWhWRDFPNnFBVWt4TEhkS1F6Sll2bG5sendiMzVl?=
 =?utf-8?B?ZGNHQVpoeUxTbStzL3pZZ1NsYWI3cG5laURaUkcrQjRVQ0NNWUk1WlNGSHgv?=
 =?utf-8?B?Z1FJWHhvdGM2UTF4U1ZpeEtXRnNDVzlJR2JkL3BpZ1NWOHRHa2MrU3FaTmlM?=
 =?utf-8?B?a09lRk82T3NoMy9NWit2NVU5S0xSb1VkWFIrZ3VqK1JpWFFZREZXb2o0bGpx?=
 =?utf-8?B?NTlUVlYxbDg0UU1Ic1dhOVZET1ZGRG5kVWxHU1dVOFVmRGtDcjYrT0syVHNZ?=
 =?utf-8?B?QWoyZEtBVWZrNXZEeVRrWklvMjNKSjlTUHlwSk50YXVMVVhUdkVDdWVJazk2?=
 =?utf-8?B?ditCUDdmeWdhTk9ERUdxbEpXTkFJb1VwM1UxMy9wQ1JnYy9ScEphM2R1aEFE?=
 =?utf-8?B?QXJBVFRkanNFcGc2Q3htSWkyUFd1SU1HYnNXRndVU3Bab1g4N3RpRG5JUktY?=
 =?utf-8?B?aEhWdnNZMjFJUnh4T0h3VHhERXVZNDhoNGZnYVI3a3hucGt3eHdIMFVvZGU3?=
 =?utf-8?B?WDJCSitBSFlNdWY2aDgwalZJWkVjNlRMOU92YXVyaDFqYWlPSDJxbndMaWlz?=
 =?utf-8?B?Y0g4Y3BFcE9oSkNZUnZtZUFsWGNMNTFHMHRWRzZFV1BsNDhTZVpBVlprejl2?=
 =?utf-8?B?VUxFMCtLV3JBeUExdzJFdC9oclo4RWZ1WmdsNGkxdjZWWCtOa25lMmJGRmpp?=
 =?utf-8?B?ZEFEUkxtbUtpYWVFSnB1MkRTZUpoYk9LWm5NaC84WmloaW5kTUJleDBScXRK?=
 =?utf-8?Q?u+Cv9P2AWm27oFYjQFkWfpj8I44ZNerL6f3axN3FfQzCX?=
X-MS-Exchange-AntiSpam-MessageData-1:
	kd97XqoQlbMrj9wD7JphhtDqy0JJega4WUsE04gtiyNW81hpHPQBL/nW
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772d8351-0598-4f08-12e9-08de846e0ec5
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:42:16.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5LrKXw+V7L3L0XIMyXyCmCgATdYX4tgy/G61j6nbhp0tgS/DjYYUj54BNYN63lk68SNyljgxNlRnFetg8RdHtBb3s6utDojLTN0M/HSDwH/KzGwR8B3Ztz2W8Ho0Kok
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB8939
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268750-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[onmicrosoft.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.961];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amperemail.onmicrosoft.com:mid]
X-Rspamd-Queue-Id: 438672B2D4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I think I see a pattern of this happening.  I wrote a Qemu driver  for 
the MCTP-over-PCC Kernel driver as well.  I wonder if there is a 
right-sized organizational scheme for these kind of drivers?

On 3/17/26 17:34, Jakub Kicinski wrote:
> On Tue, 17 Mar 2026 12:41:39 -0700 Mina Almasry wrote:
>>> No plans at this stage to upstream it to QEMU because TBH I don't
>>> expect that QEMU would care to carry random HW emulation drivers.
>>>
>>> Sorry if the announcement is a bit self-serving but folks expressed
>>> interest off list in being able to test the queue API and zero-copy
>>> Rx without real HW so I thought it's relevant.
>> Wow, very cool! (Sorry I missed this announcement initially) I'm a bit
>> of a noob but I'm a bit surprised a 'real' driver can work no qemu
>> with a bit of magic.
>>
>> Is fbnic-on-qemu about as feature-rich as fbnic-on-real-hardware? Do
>> most of what it can do on real hardware it can do on qemu, or is it
>> just really zerocopy that fully works?
> We implement the driver and QEMU side by side pre-silicon so the QEMU
> should cover what the driver can do. Keep in mind it's a pretty simple
> NIC, even "in the flesh".
>

