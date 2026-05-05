Return-Path: <netdev+bounces-284489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLXbJtcS+mkWJAMAu9opvQ
	(envelope-from <netdev+bounces-284489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:55:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6004D0B01
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A3B33004F13
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 15:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B952480950;
	Tue,  5 May 2026 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o0aESO0L"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E514848AE22
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996493; cv=fail; b=LXyWzQfLAklkT1pozAedCL7j8APDwAzpZgpkXJ8bw8ow2BB6D1crV2QsrOMlFVFV1N32EUGRQ0lkm0Gf6eoROAdi/h7txGg1Lsni7uDqcx5jsRZw9ZsUXwRy+REJPGi+ltqvhRlkzXWVd6BFsVIJgG1HBL73KjcHvWA3LNf9YMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996493; c=relaxed/simple;
	bh=HUmQZXkPcvXz/XHhgUP9yE1dKKlxp7feRKOmPNjGaY0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DFP6sn7kw2SyPKq+wsOp+DNaumWcJaSRjw3s+3izzLMU1R0lYOCoqb+BN8kFaNXumfb02B7Z4UC/cWJqs8RfL6NRBtuiXtSQXGe2UtrsfpKmT3ZipuMBVvo9QzvOZbrS7zXjxPufyY0Od7d1IJ3x/DVervsJ6A56v9zTltSLtis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o0aESO0L; arc=fail smtp.client-ip=40.107.208.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jjw8eiJlQIx3MycQFzDL3SJ4aFvVQwCezvEEW0ZMOetq0dwbuMbjeZGcQS3UIG19tPHhLQ3pxyTbEz/po05bvr8qNaMP/lWRBJl3IhkwdHOMxbghoEobX1AqmwoKqQ2EqviWiMDbU/2o7P5QWxqOTTCXXS2EdM2ZhYKWxSG6yYN/v4urAj/Ec8sJTZej5FfEzIoRIAL2jHhoF+plBVN28+pzFjOjGeaMNQMrnqww4+iCu77ACIqmD/PQcEFNb/Ow4wCrh+42eZv/C7bdRdpXMRtq/n+N2MP0dqZ5o41E6nyarmV7NTq5jW2pf//IxtnwIMxiDPIwlsD76JCRteBtmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8Jh6d5G17ktAMMZqoh8aZpoXKBm/Pt9u9akVEUJ/MU=;
 b=BLDxB9xNzgSTYEPkUhSGNTzA/vtEB5qJOb26xgEYkV6Pw+DlV1saMWYaZ9ce2o0YYpE4ze13KRueScQ+JzMIQ2+U6dqKTm7cWY6HWO+b4fTVldLFa+4bXhJquy9xVBbgS7CTciLVqudJBYXv1e4RC69jDYeISNwRQzcbcvlwM4Pf9UZLKZwRzK3tjbLYDSyMxWxFvyYnf51jVriPJF6fTVJN0g1IuGyw9z6vha2uZCL4TgtZ+O69WF0ctQWfDWsVQxvoMENdZMm8zXA9O6gg57L8O3h0BZd/bCjBAlVHoqgwR9edKTERFWgSAuemCqX9hVtvaLsGq/l5g0xFomsO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8Jh6d5G17ktAMMZqoh8aZpoXKBm/Pt9u9akVEUJ/MU=;
 b=o0aESO0LphnyYR5zrq2nUpW80r1OCL+SP7b8pd1AZLchpeLSjB9eLSlydJLMM+UfHc0M0IojL4sOPeEQfSN/aicEmHKB4uyzxC2KyEYs0RqQCzoSR7735OzXOZnObin+JD7ELZH8+ChxzT9IoSxipeUpz/HHKKwPk96sZFo05Yk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 SA1PR12MB6679.namprd12.prod.outlook.com (2603:10b6:806:252::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 15:54:48 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:54:48 +0000
Message-ID: <808743e2-dfce-4793-85b0-fdb771763ffa@amd.com>
Date: Tue, 5 May 2026 08:54:45 -0700
User-Agent: Mozilla Thunderbird
From: Eric Joyner <eric.joyner@amd.com>
Subject: Re: [PATCH net-next 1/5] ionic: Small improvements in devcmd retry
 logic
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260501031555.43259-1-eric.joyner@amd.com>
 <20260501031555.43259-2-eric.joyner@amd.com>
 <20260501163740.0f775e67@kernel.org>
Content-Language: en-US
In-Reply-To: <20260501163740.0f775e67@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::6) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|SA1PR12MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: ab4ecaae-849b-4861-1a4e-08deaabea283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vnFECm5B37YCIoO4WZzTKNIWLIbOuMNgE4vLDFkGvf7HLWxP2G0QbB8N8rDjnZebKSTv3DF+lvm24rfnfKm96ATkC++eCCF9W7StI0zTD5f6M//luH+CF86WkHqzFXqYK7rRh8VXb0k9M9hXacp5i7GAJt46E6usSZnoSnKMw0CoeZvG/SlMaAC7G5iS5Y0lQ9AORaozb7s9CnjSaZIkgMh0GYxFcHB5ey2wh/XS9JQ0IvDU1BGdrxUVRDQEyCRev74BMosW7lUrcqEDHm+ahRKgm8WXkzyD0ZAUW7ZJ+tPlDv+55ZNm2EujVP21foL8bs11c+rqfnKGv3A/Q1XfX548Odl3+Qwdyta1Y9qXi5hrknN6CqQmxmhSLCNxQ0DLcelHIKQVcdhU5iwFGGVe4P/Xn9zq1k4yy0IlAU9A7NrgR35wI78MKCNnV6qjui9/Pq96u0mNUXE3SPpBZsu/IILj6qeCF9uD7wXVIJ5CWvI0LNzzFmJltLMUNrPZ4nw8iMoloNUyI8uJzadeT7kpbKiXF171b1gdkEcYKJj9CFe1dZVhcTZjTRgpcKoHh+dgnlum5JNPXcO9VnmpXTgi33EZbXklTyaWVScDaA+GxvCIOMXGLZfhuublL/KA2ujjm8rBMNASbJhvHX/gLbJ0a85H0uj29NnlpK+EuLfYlDo4DUqfuBBe6E80fyyFUiZiOxCS1Qc+lvp91WcqtbcMNg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUVyQkd0OC9wM1Z1RnRaM1J3OVVLandxdHlBbWtka2RSYWQ4cmNhS2lFS1FC?=
 =?utf-8?B?VWZheEFkeWpjRGlRcXdpZUd0T3kyOGNId1lWeHUyUHpVSm13a1pXYXZMSUxr?=
 =?utf-8?B?RUhIM0Z5TEJobjRTNkdjbjFVT1oxWlBSRnhncy9WUU9iL2pqZUdKWjZRTWRF?=
 =?utf-8?B?dDJzU2F5dEdoVkRVSVA3SWw1Q21LcTFINnpaNytEbzk5NkVkR2JyWWc3SDRK?=
 =?utf-8?B?dlpIK1VXNmNycFQwa2daU0VpTjc2eFNGc2lWMG1UUDQrMW9WM0Z3OFg1R2NZ?=
 =?utf-8?B?YStVWTJJVE9UcjZoVHI3cXFOajdpWmZ0ZlhPdmtZY2hNK1dmaU5rZ0lxbjVH?=
 =?utf-8?B?UE1FeUE3RE1sbkFYaTAvbXRTcmhFYlF0aXZtdnFNQnJ1NFBKejU0eWdqMkdB?=
 =?utf-8?B?UDhVdTJJQlRKQ1QyclliTnhUemhzWVlMRUtkYVFtZkh6ZUdxZlo2R1BheHVu?=
 =?utf-8?B?enFjWmNBK2ZxY2NiYTF6NmFYM2NFN1VOdlh0VG1UMzVFSHloVkZlZUxJeGpO?=
 =?utf-8?B?MHhrank2TWNMUEFKa0pkSVYrYy9FK09pS29UQ1dKaS9IcldpMWtlQVYxREJq?=
 =?utf-8?B?am80cmNKd0lnQ25nZTlBMXRJbkR4citVTUJncUJwOG1rcWN2RFVOYnpTbVdL?=
 =?utf-8?B?UGIrbm9WQzJJMERuc01GbnF3TVhqd0tqRkRFRmNzOHYxd05EK3EwNi81NDdi?=
 =?utf-8?B?RzdmbGRjY2QzMHpSNUVjUFQ1VFkxTy9uNVM4czZLbU5SZE04RCthWmZZeU9t?=
 =?utf-8?B?YkVtR2VBbE0vZkJ4Uk14aG9zYjlPRnlMSUphTkJrTXlqdVVGVXVRVWtOQnhk?=
 =?utf-8?B?U1J1MDlJbXlJMnN6bHN5a0RPVkRCVGM1M01BY3JwWmptMHZ3Mno0OHZ0UnlM?=
 =?utf-8?B?dWcyWTJBV2ZoV1BNeXF4eSsycDN0UEpEMFZSVFdMaGlqUy8vbUFyVVJvRnNE?=
 =?utf-8?B?dXh2WjFDM29aNTVjM3oycE0vSGRGOFQraGhrVHFKTTlRRWxRUlRyQytPSGI0?=
 =?utf-8?B?TFlZREk3UE82c1BsV3pEcktzZ0hIWUd4S2RaNlFteENWVVNaQUZwdTgrTWZs?=
 =?utf-8?B?WDlwYjEvb2VPMkgrRHRuVFJpaDlDQVpVcm81SGxLNTVFZ2FaYTFWZy9UdWRH?=
 =?utf-8?B?MFpEMkNwQk92S0lTRUJzcmlWWHFIY2l4WHlZcyt4andIbDJUSXl2Sk5QcVly?=
 =?utf-8?B?dWl0amFld3o1Y3JtYzgzRGxHSDRWbmtodDVZdHNPdFQyb2xzMTVhOEl1ekQ3?=
 =?utf-8?B?OERCRWJhVmlvNjY2Kzl0dWNsRE9lZitrTVZwaHp0cHlaS2dyNFBDZHBRTEJz?=
 =?utf-8?B?ZVQ4K3YyUzdsakcycXIvdUx3YjN5bi8yaXM4aXZFU2JCWEgzanAzQnBNdGNB?=
 =?utf-8?B?N0w4RW5xZXdpUzFJV3R3QzBneUFJdU5DYXh1ancxUFlDZ0taSkdVbGE1VEZr?=
 =?utf-8?B?MzdJM3dFbkkwNGZZTVdtMVl6NG9SMFpOR3cyRGs0L1kxOG5Ma0NlNXd1eWps?=
 =?utf-8?B?QUhTenVDcW5IV2hXQWhXeFF5bU9Rc0tUQ1JkQXBFek9OU0tnbmhqY2lHL3p1?=
 =?utf-8?B?VE83L0JCQjZSRnlJSEd2NFliSStNbStzQ09ZbWFKV0tUTHVjSk5NeXpOL1I1?=
 =?utf-8?B?b045SHJBa1plOHVaSUpXaXFGV3U4SndVZlNaMFRZNDNsQ3F4Tk5KMlpTNWRj?=
 =?utf-8?B?SzdleDNDdkxib0l0VFc0cnZNemRrd2dyZ1dsSzJmOG5WOTRrdmtqNzl4QUZB?=
 =?utf-8?B?Sm1iOUM5RVZ3VWxYVjVqNzlrY2RLbDFwWDU5N3pDemRJUW01bGVocEJ0aFVV?=
 =?utf-8?B?WG9wY1lMKzVxV3Jma0Q4THBEa3FJRlBuZmI5dkhJWStrcU9OM1RNbWVyaHZv?=
 =?utf-8?B?eldRTlNzQ1VFR292VzRQWUt4ZGxuZG05NE4vVGhxRDlGb0hCcDI1NU1INXJU?=
 =?utf-8?B?a09OK3ZmaEhVOFBkL0NKZ3p2TTFrYTNneGNKTExJbmpOOUxQSERSVWRJWU1W?=
 =?utf-8?B?QWhqSGliNjB4R0xBZ3gyaXFieGpvMkdXeFhRSVprbHpDWERwQkF5QkVlbUNP?=
 =?utf-8?B?LzFOemlydVlSeW0zLzNwVnZCN0NUdVFPZ2FnWGpLYll3c21hSWRzT2sxVDZG?=
 =?utf-8?B?NUwvc3V3U243RXgvNkJYL0dISnp2OWw3VXBYdlp6VHd6K2JpV1hJbEc3YlBa?=
 =?utf-8?B?Q29aclBxRUxSWGtmd2dVWjZRZ3cyMFowNUZzK2RmbVNxaE5zSS9pdU9BaklJ?=
 =?utf-8?B?NDA1cVpKWVlVWDEyYjVWUS9acnBQMitraHlRSWxTMWp1WGxFTkFkWklNTG5L?=
 =?utf-8?Q?HUpPF5plpbCOb3j+dZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4ecaae-849b-4861-1a4e-08deaabea283
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:54:48.2005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wcr1MYe4MPxpEhqCnaw/4johVQx4kVw2vgPVaWAFhFQ8QCZ68Lq4uGfj+78USyfm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6679
X-Rspamd-Queue-Id: 5C6004D0B01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284489-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid]

On 5/1/2026 4:37 PM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Thu, 30 Apr 2026 20:15:51 -0700 Eric Joyner wrote:
>> If the timeout time is hit when the last attempt returned EAGAIN, the
>> driver returns -ETIMEDOUT. This causes the -EAGAIN result to be lost.
>> Fix this by returning -EAGAIN if the timeout time is hit and the
>> previous result matches.
>>
>> Also, reduce the sleep between the write to done and doorbell
>> registers. The msleep(1000) was initially added in an arbitrary
>> manner. However, this long of a sleep is problematic because
>> it reduces the number of retries when -EAGAIN is returned, which
>> may result in the devmcd giving up early due to the timeout. Fix
>> this by reducing the sleep to msleep(50).
> 
> It would be useful to explain the significance of the return value
> to the callers. Are you trying to return EAGAIN to user space?
> Or some kernel-internal function catches this?

It looks like the -EAGAIN return value used here would have been used by
"[PATCH net 1/7] ionic: Allow the first devcmd to trigger deferred probe" [1];
this change got put in this series because we decided it was more of a net-next
change rather than a net change, but didn't realize these two were more
connected than what we saw at first glance.

1: https://lore.kernel.org/netdev/20260429210007.40015-2-eric.joyner@amd.com/

 - Eric

