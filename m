Return-Path: <netdev+bounces-290103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPZCGvQdDmro6AUAu9opvQ
	(envelope-from <netdev+bounces-290103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:47:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D4D59A1CD
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D92D63016014
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC51372EE2;
	Wed, 20 May 2026 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tE+gqgpe"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013067.outbound.protection.outlook.com [40.93.196.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F4228C5CB
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310065; cv=fail; b=UNagfB7L6UACOIltp8Ei+RkbVh8mOhB0iJwC32Zvege6FJUuKERbytJYvxoDoiinyVE3hnXRVMMNntTfc6mU0bhrJl9Jwa5Nxcy+R2SXHlKOEMXMo2dcO6H4fXG2QMjMYyFYeu4/QSUCOGi7AgdwFCIafoku12m/it5FFXq/eZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310065; c=relaxed/simple;
	bh=LHuqQNSRkIqzWOFjBmXMtJWIvbxxrH0LyGAUqRSt0wk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ac9D66CqQlV2W9KZSsGRyZhiBx7zz3y/3cy7LIyn+RlsZtm+114Cem9YFzazwfFFvKYE3u8P4hPiyHpYrrZdORMQiZLdIVV7VXhgpgV0Vmmc4UIPXRrNgDH4bG6OdKlSQBoLxsbYnRTTBenDI5BqN0DWrDD0qRTFD860kyD0DqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tE+gqgpe; arc=fail smtp.client-ip=40.93.196.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKGRyfiswXvWHJtbgNCmojTYiTr1eVlDun2OvxB5Tun4Zs2UgXYMEZhyX0c5wZXPaSusl0btguM41mgN36BuDlbcYeKcq3OnslHgVNv9kAn9J0IeM7nbOKg8nw1AVLQ1VSjjkFle7fDjZ0K8u2zuglvZ6rGMAXEgNeNbVFIVtcS3YfrnFKbyaWyHtrjHKJis3nGcG2j1LfHDBSbFiNgMze2WccyOniiwkbFrbucyBE8ObtlJeQCt0mf5lPUtS8jGFnjqHlhKuTk6bWEtIh7C/0r6JX33SIuf2eWxIM6k6Iwgpy4+Gi5ZxTwH6D7t3KETWW7tE8p2i/LfFgTvikc7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vrDXWF50gVh3aXK97DnrvnSBLsoMSUw+aWdjI0cBw4=;
 b=aQeMc1swxammhHye/eG4tvOmMnyF88elhu9ChPdrAyYdy8MAAaMphEvGmNf97dRsMlyS7QxZV/8ZYl6oeVpWGCE7NK0DNCXdpMlNVrTFVZbrKhOhH3SB2JpNV2wFhHxAc6tT4KY7YAhatJ3rOakL//zTO0o/TDxMuodRSsvFfoSMqsgTBSWRHopLmheS1Hq1O/b5NAtJ+MOfg4B4F4TufQLmbNr3USctOtlI6a1H0DB55l3Tngcb1Itj9JbIlaa2rXQtf80cqfKgXga2IL7iuZdVKvQI5eqD3JzXfZF+MrKCUe7axkBFOCou+kwQH0sXPBxdIbKuMvTF5Nr2yP8/dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vrDXWF50gVh3aXK97DnrvnSBLsoMSUw+aWdjI0cBw4=;
 b=tE+gqgpep/PmYwn4Da++Z9QMMFhog/DbUinFR2qrpz/0uva7GAQq2NlNRDkwpK+0AnZD3yH+SVtJugXtWKTO+C9biDGRShwHrdMxRrnKp0nID/XtKPi8BKMZTSo8Dx1SKtdYqTI+2Uwecfa3mFUfA/pafFvXrQ5UzmAl9dG1qgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by SJ5PPF4D350AC80.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::993) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Wed, 20 May
 2026 20:47:39 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%5]) with mapi id 15.21.0025.012; Wed, 20 May 2026
 20:47:39 +0000
Message-ID: <9c2e0768-b2e3-4bc0-b700-b097fafdb4e5@amd.com>
Date: Wed, 20 May 2026 13:47:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] pds_core: fix potential stack info leak in firmware
 version reporting
To: Jakub Kicinski <kuba@kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, eric.joyner@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
References: <20260515212907.998028-2-nikhil.rao@amd.com>
 <20260519191644.1574c9c8@kernel.org>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <20260519191644.1574c9c8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:74::47) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|SJ5PPF4D350AC80:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b7a420-66e6-4783-069f-08deb6b107b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|11063799006|4143699003|22082099003|18002099003|56012099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	DlhJMNdQ1reqE+sUhor6uMAeOmu4ROTirVjuIJhzXC6VAnfN9muCrRxz+UyDMTyAMIahTzhzxtB6eSIMw/fUBQtVeqlZU458JQX4SvjTnjFdir/P3GFsvth8/ydbqxrySyrZsWjt8WYXc5xaMy2CCctPIOQIJU5kXOzY9+Rl1gvlzHSUsAq6Bvg2aemMnmfFDXlj9IQSRL6eh8gF9r56QkOFiX1zInmrtpw5LV4Rp51K1Frxd4Q5rmPNGMhdwFVpVAP2tJOZFWpcwPltHjwMvd/2eMJJxVsfdQEYc94xFKPYrfr1WfqK6hmFxtl3tnUKrIrhomaAGMe1Q6+bJjXJSIqbVUnWkT10XNN77YfhaVudhzrnNHcU4tsswNhovNnCFQhAvn8JJ0usE3rinEq0n4o6C9/L/AqDb1dl0x0WU0Ei7ewHRxFkExHIsrrZ3bMfKNz0D1zmFHMo2B9hR74TsLTcv6Ao8arWmLGDi3pRqwdm32EcHW73C2+aVb6wyqVJGtzkVOMwCb8ZvI076AExaR/bngAuYNXhnP1nDhISwSLGoNjMXxjivU4rpB6xFRYVaUGDKCkfTdXXNrRUyzFGjhpP3rnHfPr7oE9BcGCj5Jfo5kzBRg/Culm6NA5aPLXqmISXy3fv7Vv2LTk900ur4hcP8U/APJT5Tzqf40wB1O1tvST6j8QdO9mdcZXMfA72
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(4143699003)(22082099003)(18002099003)(56012099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVpqKzJFNWhFeWg4WFljbnpqUHhENWQwbFRad1N2aWdHck1aMGJxdDJKc0J2?=
 =?utf-8?B?RVdiWGplSDc1c0RBa2dWcXRqQlRtYzFBeCt0Q3RYc1JjY1o1c3FvTDZWZGpr?=
 =?utf-8?B?aUVQQ1kvSmZBR1RLYWR6R3dOMllhTDN3UGFuOWV4aFFyTFlsQ2lGbUM0M0pI?=
 =?utf-8?B?aEVqQzFFS0FtWWVZdU02OU9QU3kxYlFsb29nT3JJMWVjeitPTFRBWmdCZ1Jp?=
 =?utf-8?B?MXd2cEk2bGE4L2tyYlNzTk1lTndEYTZXV2M3cyt4TGp1cU1WZHozNHFQSGFH?=
 =?utf-8?B?bmlDRmllZVMvK0pWODBKcEFkWFdzWnc0R2hLY1VUQUdiVWl0ZksyN3l4MjhY?=
 =?utf-8?B?bTNNYXR1MjFmZlp3dWxLS2ZqUEtJYm5tcjRkc280Ym5panF3NTA1WWFjUVdC?=
 =?utf-8?B?c1MxbjVUandrcWY0YzhpZktGeVloL2tZZnJYTzNhY3NFcHh2YUc1QWpZOEJz?=
 =?utf-8?B?R09PQWpoeWIxaW9ycGlFRTR6Tm1lZXNMOTZ5L1ByN1FxK05DL042ZEthTWIw?=
 =?utf-8?B?c0FCQkExSnBvcEZrK01yK25hanF3MXJrUDNUOWhGdVEvYlRGbHh6dlkzOXAv?=
 =?utf-8?B?SFgrbTVhN1ExM0FYdHk3eHcwam9TMTNVTDViaERkc0wwbVljdWk2dFcySjl5?=
 =?utf-8?B?VllEb2NmY1AwNGZta2xaRDBDNEljUzI5Q2VPNkhKOEdOUjhYTlFtMWZ3Wnhq?=
 =?utf-8?B?dE1IV1FpQkdlZUpURjJHVUx6NlFtdzlmMjkwbm1US09hRzVpTkhjY2lsS3pr?=
 =?utf-8?B?QWQyMTBjRjFaeTQ5SHk0eDMzUlVwbEJOWXo4NGIyaTdld1hsbkFtWTM0MTZy?=
 =?utf-8?B?RVNjU3hTcUFCL01BU3RGVE82dlU2YjV6MjUzaHdERjFIOFVEVSs1Q01XajFM?=
 =?utf-8?B?b1Nxd1FsMVFRVW5iQUhMN0hCUkF2ZlFNVjVQTW5LbHFZMFgwaWY3by9ORDVN?=
 =?utf-8?B?M3g2a200dmlqOFNmOWZUdWRBbjdwZWRaeTM4bTN3UDQvY0IzblRVMVIyT28w?=
 =?utf-8?B?Y2JUNkNBV2pydU45RmdzRkxldzErb2NhNExXVmJWaHhtaTFBbWE1VnlkKzA3?=
 =?utf-8?B?UlpuUlROajJ1S2dsNGxjTDlPSmtjRVA1dCtxTTVtbTFpWmlITHk0SFdqc3VG?=
 =?utf-8?B?ZlFtS3l4OHFQR01KZGJNSGNIdWJOVWZNZjVoWGsrbGgxMXBqUnVNL1pMS1RF?=
 =?utf-8?B?MEF0TGkxOVRTY21xd3ZuZXFlT3ZSbzhnWHNuL05LeU1FS0Yxa1VkL0p2SUU0?=
 =?utf-8?B?Zy8xM2tVeS9SdHVzV1BzemgyWVZkZzl1bkFkK0NST2JGTUxiL25sYnpUN1px?=
 =?utf-8?B?ekRwMEdYTjg3ajZOV1VPa0g4OTI5aEMxUG5LVHBwWGpSZnF6b3E5eU5OZ2Fj?=
 =?utf-8?B?dFJnOUpVYVFNZkMxTHdoa2VBeVd0NHJ4Qi8zY3hLNDRLYThTZU5jKzg3Y3Rx?=
 =?utf-8?B?cE5ub20rZUcxT2xIN2lXOVIrbkw1VmVEdXpMU0diTDlETzZNdlBBdVE5bUtk?=
 =?utf-8?B?OG9NdFh5RzNFbEM3Mmp4ek45UlQybkJ1L3NlUjd2dVhsWWNkOFJLYzNoTXFS?=
 =?utf-8?B?YjZGNlppaDEyMlZiZ2YrWFdJMkdBd3lWR0dzNjkwRCtiUldmR2NqZ0N2N1Ew?=
 =?utf-8?B?S2ZjUnR5UXE2RGJYcE0yL2NsbS9GRG5iLzZzNzMrSGFrQWtYRk5jajZONWwv?=
 =?utf-8?B?V2ZDVXZYWjM2d0duQmpITkVvS0lCaTNuVXFlclk1L3dWZVYrUDZGWnpESERa?=
 =?utf-8?B?cElaQkpKYUVuYi9tRjNkTVJ4UzNmMk5KZ1Q5RzdybjZLRzd1RWxpT29VS292?=
 =?utf-8?B?djRUZ0xxNGxUY2hYd0l6Z2l0UWFkNTBDZUo2a0ZVUnNDRXZZdFBhTFIyb0Qx?=
 =?utf-8?B?M3ZMT2Iwb3VTb1JwZUpsZDZod2xrR1ZjQ3F4Uy82RUFiZHA5a09FaEt3c2Zw?=
 =?utf-8?B?N0FuWVRtYm9uQmlteDQ2NEtvR1JjSlM4Tjd0M3RrSElLS3VGQi9wYkk1ZGts?=
 =?utf-8?B?THgvS3VkeTVqY2lubGhBZ3pVUk95VmsyT3Rqckt4cWsxVC9Eb1A5TXB2SVY1?=
 =?utf-8?B?aVQ1dlJxSVJVdWtEOWFNdGxHY1hYc3MrY09zK0Voak1ya0tZNHpvYlhmSzFB?=
 =?utf-8?B?bkhCSUZtNW1mb1VMOXM1ZVZkdCtIUTR2MCtLQ3ZmZUhtaTNxUDlXY21RMGxG?=
 =?utf-8?B?cG9RalZuT2lFYVFZNDY1Z281dFY2cS85eUkrNllFM0YxelhVVzc5K3BwRzN6?=
 =?utf-8?B?aUZ2TkJEQVZQZ3E2dmp5NGdtUmFBNnNsb0ZWQjJadk1POWNyOE1jajNzNmph?=
 =?utf-8?B?SDlLei9YSDlIbVc2bVF1TEFXdndzb3JjWTBrOURoTUxLRHA1cElqdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b7a420-66e6-4783-069f-08deb6b107b2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 20:47:39.0574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3RYBptNERiK1p6yidAp5k0eIT7yUv5eeuTinB0O1cTJS4zowsZkkgyzWAam9ATpoYfPL467UlRrreEUBCpBJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4D350AC80
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290103-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:mid,amd.com:dkim]
X-Rspamd-Queue-Id: 11D4D59A1CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/19/2026 7:16 PM, Jakub Kicinski wrote:
>  
> On Fri, 15 May 2026 21:29:06 +0000 Nikhil P. Rao wrote:
>> The fw_version field in pds_core_fw_name_info is a fixed 32-byte array
>> that may not be null-terminated if firmware writes exactly 32
>> characters. When passed to devlink_info_version_stored_put(), this
>> could cause a read beyond the array boundary, potentially leaking
>> stack contents to userspace or causing a crash if the read crosses
>> into an unmapped page.
>>
>> Null-terminate the firmware version string in place before passing it
>> to the devlink API.
> 
> This loses the last, presumably meaningful character of the FW version.
> Are you saying that device should never send names this long and this
> is defensive? Otherwise we could trivially memcpy() the name into a
> buffer on the stack that has one extra byte.
> 
> Please fix or clarify the commit msg.

Thanks for the review.
 
 
 

The firmware already null-terminates these strings, so the fix won't 
truncate any valid data. This is a defensive fix - the driver shouldn't 
rely on firmware behavior.
 
 
 

I'll send v2 with an updated commit message that clarifies this.

Nikhil

