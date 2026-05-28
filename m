Return-Path: <netdev+bounces-292798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLBVJoGKGGrCkwgAu9opvQ
	(envelope-from <netdev+bounces-292798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:33:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A035F6590
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AC8A30976EB
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4189403E8A;
	Thu, 28 May 2026 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="nTaykxU5"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022095.outbound.protection.outlook.com [52.101.48.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940672DF6E6;
	Thu, 28 May 2026 18:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992785; cv=fail; b=ci7+oP1aXmO+k9CIx8d5YkJ+ZFTgknc24CPmIsrx8aVkl9YozB7Euk7V1r1UN26xJ0ETFaHQ/Qd4sSoYpq1B7f65SHXDdNwxUbOtzZH2xWsZ983hJlbVp6iy5snSOJTOCqt0m4ILm48ytnbl+I9BRxxgn+AL3b3XStbH5YeURsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992785; c=relaxed/simple;
	bh=JNhkOQW/x3zBrGaygyaemXuA70IzQl+9sj+9oHYW/JQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EY6D+80QOa76Kn6k6/V5+Gr+VSdHTrEAd5udUxLPQJKJi16/hrD4Oxon7mD0i/KDEEqwyJzv628r1V0mbG6RG7lyV/OzRkBKPEYXAUGpQSfax5NFdsiezIDyUS3rilF4P45LJd+pGNBu0AeY1zqDIrnPGxwfNm1KVlVXnIPS7Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=nTaykxU5 reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.48.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xegMI3ZjCxGz7zVErUJh9kEVlYXZjS9Wi8/xOvUf0Nqkv/CnjbwNA5szuUfuSNGZMvu8O22JtQtEOjnx3cEep1iknsp5v6X9xi7AHL01uvPqRg0BaJbDsIN6lvkPqO1LIDK/Jr0A9pdO6raloYyYnyIlECqfsH1nEJMAJZk+poFe/+MXAuhktVhg4UOUCGA2WTeG1TdGeYXUlZ4YLtFKkK2zUwzFZHecwUy72CGBMYP4fTnBK+QmqtD9sxB/tErPkUssdTzD5yeVqtQNydwOFNLCJ6QlBspxvJwk7EK93fh38D2J/9aM3+HW9w9zwoSxMHBbyFVOnLgxUokJz0X24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsAxC+EsX18jFccmLtiIlFELLXf8QxwnFn/7K2pAal4=;
 b=Z9jFOQZnN/kFDvX9SBsaC/4+DPHgdOvBvykA+Jfa49DfJcmJFRlahtHz5dhCclOG5aB6FtFv4cO1f/ZNu54EqB76TVSTstk8Hl2JTrdWx3HMWZ7t4Ctrn1wfYfcV4ZgThR+u9AJO9LuMRuRz8lOVVaC9FPTe/oxVZk9G5kLSU5nrJonLzhBEo8AZaMNKj7cnhJDeqIgxxl30YsVVwBeG8hgMSKNmvFgy8EnOdxn4OeSoK9cDyeQMX5sziTmvNI6CSLaSdAPb1dACbHeX0H9dLhvbo4teqWUlHO7tTAssWVaR6QvvxFIcqwxQzNIm73LfyyR1cqBSn46ZIOZNvvgX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsAxC+EsX18jFccmLtiIlFELLXf8QxwnFn/7K2pAal4=;
 b=nTaykxU5fGPmpqMYFKA0b3TEOnXeBBkQxEg4dGsGY7a5in9r8nL9sO9RVUuS/GIxBooNNvXBnn088SNwSy0WQHWjWsS6O+b9mXW6tDMjhO88dDJ78qCKQUtQOjbyvqFAluirefC2JyXfiIPY0SV5pZps5iVb9DsnBw7+4nuDw+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 LV0PR01MB994220.prod.exchangelabs.com (2603:10b6:408:32d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.13; Thu, 28 May 2026 18:26:19 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:26:19 +0000
Message-ID: <63aebaed-2456-457d-be70-5211d2f746df@amperemail.onmicrosoft.com>
Date: Thu, 28 May 2026 14:26:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v44] mctp pcc: Implement MCTP over PCC Transport
To: Paolo Abeni <pabeni@redhat.com>, admiyo@os.amperecomputing.com
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sudeep.holla@arm.com, Jonathan.Cameron@huawei.com, lihuisong@huawei.com
References: <20260522193610.234166-1-admiyo@os.amperecomputing.com>
 <20260528084611.133703-1-pabeni@redhat.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20260528084611.133703-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:208:329::17) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|LV0PR01MB994220:EE_
X-MS-Office365-Filtering-Correlation-Id: 3069f11d-7b2e-4310-017a-08debce69c89
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|22082099003|18002099003|55112099003|13003099007|4143699003|3023799007|5023799004|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	2+l93HxfEeVRNZs+/6XgzsWMqXTp0cK/IT+vhYLfZl2HFTyVjxKXnRWCArSVqA6g3VIGjAmZ+SJx4egqXSEIBNqZYAMdnv4R0MLYgA9AdqLaQEQ8mBen5m0eXPJnu8HVA7pguYh+1ihbpRUZ1mG5wHO7QhaJjisVreXnH19/1YNMAFNq++rUB+4dmdixwLXxLLtGdmGpZJThO5suM0VavhJyUWqp3JunTzo0w5vgDkrHnkCiHpylDJxGXVymUyRYbYgNgXcpvmZ039ZPYhvDEnz5/ZRxQc8G3Z6M7W+RSVAgxLn6p9aPRNfYyESdM6VOxWRAnkWClz4wE8JUVnUAM7G4x3iA1pBQjHJjqhvMfuZDVZzIkcincYfGPWBQ4W7QM9zVNDia/0AW0VKbiIQKviLsAXK529U1yYBu1lXGJdgl0HIQCjGGh7BH7MJOlSg3PzFOTD9fWpKtNPIhBM5L6bjm6Yq0WzjeDtRxgWOxI+EmkjzCZLUdYrr5rMFgI8kOM80B5pr29O3ytkiFa3Vzh8M/NmG75iqvtF3SfPDtisqOHtPjm25+f37EsX9QY67NlB1SCv2qBzpooGW3wKKVpfjbjD+V5ISCSzCdSkXNe9gw5WIMjYtqdv3ieLB4Y78NgHF/5Jf7m3WsXPmP/5lBJg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(22082099003)(18002099003)(55112099003)(13003099007)(4143699003)(3023799007)(5023799004)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGpmaEJEMndiaXdSNDk5dFpzbWJNMU9TSkJqZmhIYWZnRmYrbnBLYnAzUERG?=
 =?utf-8?B?QjdzK2EzMWhDRWxoWTduN2hIeDlYSE9OcnVUdG1VdDJTRWZnN2daK3dPNDgr?=
 =?utf-8?B?dHBIS1grVEtTNTdvMDdnWGdsd2xzWHcyZURqOHNOeVlWd2luYUNYaktoekpQ?=
 =?utf-8?B?QnBUbW9TeHJxb0s3NGVVN2hpcktmYjl5alA1aW54eHFYdkRTOEt2NnJ1VFhh?=
 =?utf-8?B?endrWGw0c2pVYVFsb2x3SVR1MUxaOWtMMVl0bkM4RTdKTjlka3E4RWowa3VK?=
 =?utf-8?B?MDNhNGFNQzl4L25DSWNDSU51a3NpYmxRMjNFOFd1RklCZzY4dmsrelBCY1lG?=
 =?utf-8?B?UnVVcVBCcGVPU3p0RnRDMWxIWkFULzZKTVAvM01pTzBXWGwwQlVwK3ZxSW4y?=
 =?utf-8?B?MUdkbVRIRDhadytIdmJmcVN3N3VocUtVUmdNTlRYK3NRdTNuRFJmditIWVVw?=
 =?utf-8?B?TjJCelJXSEkzbnVSSmFTSXZSNk82NFJwakVPVXhiNVIrTzNLSDQ0dWZvQW1S?=
 =?utf-8?B?aythZlV0VWk3MTNoN0V4MWRyU0Mycmp2YVpLOGpwR0VBajVHeHorWGtBaFhJ?=
 =?utf-8?B?NUFQT2p6UzYvTlZrQVhIQVZjcW9Nd0syTDNOZnRVcHBuZFAzRlVUdDh3WGhV?=
 =?utf-8?B?V2M3ZDNpTHpMTEdNWkY5LzJDSUhOVnhYN1QrT0NrRjA2bEwwLzR1eWxyUWJP?=
 =?utf-8?B?WGovZlA5S0NGd1czVUcwcnJhdEhyMHY1ZWlEZkdpQU85ckQ4N0xmRmpFeGR4?=
 =?utf-8?B?bjZTVkpmR282NVRJYUFvWUwrTld2S29YZGw5K3dZYTFBSGZ4dHU3dkdSNmlp?=
 =?utf-8?B?bDY4cXNCL0laSXhSQWRqc0tBVExBSUxKSHN0MDl4aUZVczBYdXhmaHNsbFIr?=
 =?utf-8?B?cWlRTlpaNllqbEFmUSs0QlFqeGU1eDc5cnFqZ3NWOXN5TnVMOXNPNkxwK3RG?=
 =?utf-8?B?T1ovQ3JJTU1DZ0NxdHVpVUw1UVZIbFhad2I3QWNJUHBYNGYrNzNNS083aWZq?=
 =?utf-8?B?dXJzWFZrVVFaYmh3bVVVVnNidlJtLzNuZlhQVUZkSVBpNEx3dVJqK1BTUnBE?=
 =?utf-8?B?aFcwUEVDVnhYcFJVUnFQMnljeWorY2tGRGRCRmgxdGtObVFSYWNPZnVzdEpv?=
 =?utf-8?B?QVpvbU0xK0srN3JNY29Xc1dtVFppSlJjNU9hb3V1dGVtVmdSSDUrL3A2ODY4?=
 =?utf-8?B?SXg4eCtKQlNCcG42K2Q1VDBLbkg4ZFlQWksxZWpCN3FRUUxha0NEa2NlUi9Z?=
 =?utf-8?B?aWRIY3VTc05EQ04yNytRNWxwemxRV1hxN0htcWZFQ05rVGFubHIxaXZCdTFB?=
 =?utf-8?B?dGhvK1V2TUN6RkVSeGpQdXozV2RsczJWeGxuV3dCdUZJVnFRcXpWaGRhMFVI?=
 =?utf-8?B?QnpZR3l1dEc3RnJkM2lxRlU1VDM1c0ljUExMSi9PL2JEeStTSFQvVzRnQ2hG?=
 =?utf-8?B?UWpqUzVIZjVNcnJQbWNIT0JMRWRpSG9POUNGOENBb1Z2emdVNnZNNmVtZnVj?=
 =?utf-8?B?Y3UrL25ueVA4RkZ0K1FRSXFnckYwNmEvbFhaUjhWNjdudDlHQWVEYjR0NHJr?=
 =?utf-8?B?RFF1YWx6QVVKaGtIN2lGN056NVFxdmxQLzFvQ3B3MW9IYTFTS0sxZk1uWXVI?=
 =?utf-8?B?L1RYN3d3aWNhMzYrZjBHbkhNVHpJSHNvaDF5R1drRzhqdFdvdTM5U1hJMFJs?=
 =?utf-8?B?U3dOckc4NmRield0T2kxMGlJbkY1NnN0VU9uNVVJZm9raTVTWDlFYWIyQnll?=
 =?utf-8?B?bmo1d09SVmc5Yk9pZUFXb0xnSVZacGI5U3dQSDJteU1CNEQ3bjB0dm5lU1RE?=
 =?utf-8?B?bkV0ZEhXdTdKK0VOVnUySE1pZENGamJSeG1ON2pIQ0VDQ2RMbmE2WG9lSTNS?=
 =?utf-8?B?RTd0clZSU3UvUUVsUWtXK0xSMnR6ZVlNamRXMHVZK1hscUlCR3RkcXg3MW5O?=
 =?utf-8?B?RVhQUXBwS2dqZmZyRGtVVWhyZDZsbU10WU94RGlOQVE1bEUvYXA0ODVYV0N2?=
 =?utf-8?B?UzBQVWh2S29UeGlpTk9YTGFUd04vQTFkS09JaWNhYURpZVI5N2I3T0g1WHhj?=
 =?utf-8?B?WjJra2FabUlWL1pzNUJnS2ZIZzYvNDdtQXVDbHlBYVhZSGNzQitGWXZLWjFu?=
 =?utf-8?B?RjJHdmFRakxnYlFEdXpmVzRpc0trRkNPTEZzc1JRMGUzbWdyWE5LR2FPQTNh?=
 =?utf-8?B?TDQ5N0ZQYjZTTWhxbUswMnpaWGJYOGl6d3dmaG00bHdMcVlsYTZHd20xUldj?=
 =?utf-8?B?eHJXWTFFcnVJc1kvZ2tselFBc0J2TGdRQUJURVNlQm9leXhMQ09EekhYRjNC?=
 =?utf-8?B?V2tZL3hFSHVWYVpwaXBTRzFWZUl4eWliT0h0MnRjY3pDa0tvT3RndFVSQWg0?=
 =?utf-8?Q?hs9lMlcIZYNTwMo5rulCLGjoWoh0ju/WMGEF8/lGE3Yfb?=
X-MS-Exchange-AntiSpam-MessageData-1:
	hEjvP1bkow+mjsdq/Kcz3QImhQELK/YJBVbgmVlsUQf7Mh5VoAnZiBR8
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3069f11d-7b2e-4310-017a-08debce69c89
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:26:18.9280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRcNIee/9a0Z9C0kV81kWSQeiULYToiG1kLHgfVsLd4L/Ts3dBNf6c3iHcQUOeA7RDa+txtcFnqNCiPtuJxlDfdVVoyKSOgMXjyfq559lP1kJp1S8RpV/i+qL7XC4xFD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR01MB994220
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292798-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	DMARC_NA(0.00)[onmicrosoft.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amperemail.onmicrosoft.com:mid,linux.dev:url]
X-Rspamd-Queue-Id: E0A035F6590
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/28/26 04:45, Paolo Abeni wrote:
> From: AI Reviewer <ai@example.com>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> mctp pcc: Implement MCTP over PCC Transport
>
> This patch adds a new mctp-pcc network driver that implements the DMTF
> DSP0292 binding for MCTP over the ACPI Platform Communication Channel.
> Type 3 channels are used for transmit and Type 4 channels for receive,
> with each interface created from a DMT0001 ACPI device referencing two
> PCC subspaces.
>
> Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html
>
> A few questions inline below.
>
> [Low]
> The Link tag and the body of the commit message both reference
> DSP0292_1.0.0WIP50. Is it intentional to merge an in-tree binding
> based on a Work-In-Progress draft of the spec rather than the
> published 1.0.0?
>
> Anything userspace-visible that ships in this driver (the netdev name
> mctppccN, the ARPHRD type, the literal "MCTP" marker overloaded into
> the PCC command field) becomes a de-facto ABI once it lands in a
> stable kernel; if the published DSP0292 finalises any of those points
> differently, the kernel would have to keep bug-compatibility with the
> WIP variant. Could the rationale for picking the WIP baseline be
> captured in the commit message, or alternatively could the merge wait
> on the published revision?
>
>> diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
>> index cf325ab0b1ef..e68d23794a80 100644
>> --- a/drivers/net/mctp/Kconfig
>> +++ b/drivers/net/mctp/Kconfig
>> @@ -47,6 +47,22 @@ config MCTP_TRANSPORT_I3C
>>   	  A MCTP protocol network device is created for each I3C bus
>>   	  having a "mctp-controller" devicetree property.
>>   
>> +config MCTP_TRANSPORT_PCC
>> +	tristate "MCTP PCC transport"
>> +	depends on ACPI
>> +	depends on PCC
>> +	depends on 64BIT
>> +	depends on CPU_LITTLE_ENDIAN
> [Medium]
> Could the rationale for depends on 64BIT and depends on
> CPU_LITTLE_ENDIAN be added to the commit message?
>
> DSP0292 and ACPI PCC are not 64-bit-only, and the PCC shared memory
> header is fixed little-endian which can be handled with __le32 fields
> and le32_to_cpu()/readl() accessors so the driver runs on any host
> endianness. Other PCC consumers such as drivers/acpi/cppc_acpi.c and
> drivers/mailbox/pcc.c are not LE-only.
>
> If these depends on lines are present to paper over byte-handling
> choices in the driver, would it be preferable to use endian-correct
> accessors and drop the dependencies?

The ACPICA code used to access the PCC region and registers is imported 
an external project, and it hard codes the values to machine, not 
explicitly little endian.  So making this little-endian only ensures 
that the ordering is correct.  The only machines that are going to 
support MCTP over PCC are little endian and 64 bit, so this is strictly 
speaking correct.


>
>> +	help
>> +	  Provides a driver to access MCTP devices over PCC transport,
> [ ... ]
>
>> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
>> new file mode 100644
>> index 000000000000..f2dd5286efa7
>> --- /dev/null
>> +++ b/drivers/net/mctp/mctp-pcc.c
>> @@ -0,0 +1,429 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * mctp-pcc.c - Driver for MCTP over PCC.
>> + * Copyright (c) 2024-2026, Ampere Computing LLC
>> + *
>> + */
>> +
>> +/* Implementation of MCTP over PCC DMTF Specification DSP0256
>> + * https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
>> + */
> [Low]
> The header comment says DSP0256 but the URL and the commit message
> both say DSP0292. DSP0256 is a different DMTF document (PLDM for
> Monitoring and Control). Should the comment read DSP0292?
>
> [ ... ]

The DMTF DSP0256 is the MCTP Host Interface Specification. It 
standardizes how Management Component Transport Protocol (MCTP) packets 
and messages are communicated between a system's host software and its 
internal management controllers (like a BMC or satellite controller). 
DSP0292 IS specific to the binding. Neither are PLDM. THis comment is 
correct


>
>> +#define MCTP_SIGNATURE          "MCTP"
>> +#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
>> +#define MCTP_MIN_MTU            68
>> +#define PCC_HEADER_SIZE         sizeof(struct acpi_pcct_ext_pcc_shared_memory)
>> +#define MCTP_PCC_MIN_SIZE       (PCC_HEADER_SIZE + MCTP_MIN_MTU)
>> +#define PCC_EXTRA_LEN           (PCC_HEADER_SIZE - sizeof(pcc_header.command))
> [Low]
> PCC_EXTRA_LEN refers to pcc_header, which is not a global symbol or
> type but a local variable inside mctp_pcc_client_rx_callback(). It
> expands successfully today only because every caller happens to have
> a pcc_header in scope. Would something like the following be more
> robust?
>
>    #define PCC_EXTRA_LEN (PCC_HEADER_SIZE - \
>        sizeof_field(struct acpi_pcct_ext_pcc_shared_memory, command))
>
> [ ... ]
>
>> +static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *mssg)
>> +{
>> +	struct acpi_pcct_ext_pcc_shared_memory pcc_header;
>> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +	struct mctp_pcc_mailbox *inbox;
>> +	struct mctp_skb_cb *cb;
>> +	struct sk_buff *skb;
>> +	int size;
>> +
>> +	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
>> +	inbox = &mctp_pcc_ndev->inbox;
>> +	memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
> [High]
> Can this dereference a NULL shmem during teardown?
>
> Looking at pcc_mbox_free_channel() in drivers/mailbox/pcc.c, the
> channel's shmem is iounmapped (and the pointer cleared) before the
> shutdown path runs free_irq(). Until free_irq() returns, an inbound
> doorbell on another CPU can still fire pcc_mbox_irq, which calls
> mbox_chan_received_data(), which calls chan->cl->rx_callback (cl is
> still set at that moment) — landing here.
>
> Existing PCC clients such as drivers/acpi/acpi_pcc.c::pcc_rx_callback
> do not touch shmem from their callback, so this driver appears to be
> the first one to expose this ordering.
>
> Should the rx_callback bail out when inbox->chan->shmem is NULL, or
> should the ordering in pcc_mbox_free_channel() (free_irq before
> iounmap) be addressed in the mailbox layer first?

That needs to be fixed in the PCC layer, and is submitted in a different 
patch.  When that patch is accepted, this issue will be fixed.  I do not 
want to hold up this driver for that issue.

See

https://lore.kernel.org/linux-hwmon/20260522205220.237355-1-admiyo@os.amperecomputing.com/


>
>> +
>> +	// The message must at least have the PCC command indicating it is an MCTP
>> +	// message followed by the MCTP header, or we have a malformed message.
>> +	// This may be run on big endian system, but the data in the buffer is
>> +	// explicitly little endian.
> [Medium]
> This comment claims the callback may run on a big-endian system, but
> the Kconfig has depends on CPU_LITTLE_ENDIAN, and the u32 fields
> length, command and signature are read from MMIO via memcpy_fromio
> without any le32_to_cpu() or readl() byteswap. On big-endian, those
> header fields would be misinterpreted.
>
> Is the comment stale, or is the intent eventually to drop the
> CPU_LITTLE_ENDIAN dependency? If a future change relaxes the Kconfig
> dependency based on this comment, the driver will silently corrupt
> multi-byte header fields. Could the comment and the Kconfig be made
> consistent (and the code made endian-correct if the goal is to
> support BE)?

Yeah, the Big Endian reference is spurious.  If there is another 
iteration I will pull it.


>
>> +	if (pcc_header.length < sizeof(pcc_header.command) + sizeof(struct mctp_hdr))
>> +		goto error;
>> +
>> +	// If the reported size is larger than the shared memory minus headers,
>> +	// something is wrong and treat the buffer as corrupted data.
>> +	if (pcc_header.length > inbox->chan->shmem_size - PCC_EXTRA_LEN)
>> +		goto error;
>> +
>> +	if (memcmp(&pcc_header.command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH) != 0)
>> +		goto error;
> [Low]
> The TX path stamps pcc_header.signature with PCC_SIGNATURE |
> subspace_id but the RX path validates pcc_header.length and the
> "MCTP" command field only — signature is never checked. Would it be
> worth adding a signature check here for symmetry with TX and to
> reject obviously malformed peer input?

It couldn't hurt, but it is not essential.


>
>> +
>> +	size = pcc_header.length + PCC_EXTRA_LEN;
> [Medium]
> Is the type of size correct here?
>
> pcc_header.length is u32 and is sourced from peer-writable shared
> memory. PCC_EXTRA_LEN is a sizeof() expression of type size_t. The
> sum is a size_t that is then narrowed to a signed int.
>
> The only upper bound on pcc_header.length is the earlier check
> against inbox->chan->shmem_size - PCC_EXTRA_LEN. shmem_size is u64
> from the PCCT and is only checked to be >= MCTP_PCC_MIN_SIZE in
> mctp_pcc_open(). If firmware ever exposes a PCC channel whose
> shmem_size exceeds INT_MAX, pcc_header.length can be near 4 GiB and
> still pass that bound, after which size wraps to a small or negative
> int.
>
> The subsequent skb_pull(skb, sizeof(pcc_header)) on a too-small skb
> ends up in __skb_pull() which calls BUG(). Would using unsigned int
> or size_t for size, validating pcc_header.length against an
> INT_MAX-safe bound, and sanity-checking shmem_size in mctp_pcc_open()
> close this off?

The calculation is correct, and the different data types do not effect 
that.  Shared buffers are physical memory and they cannot be that large.


>
>> +	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
>> +	if (!skb)
>> +		goto error;
>> +
>> +	skb_put(skb, size);
>> +	skb->protocol = htons(ETH_P_MCTP);
>> +	memcpy_fromio(skb->data, inbox->chan->shmem, size);
> [Medium, Low]
> Two concerns about reading from shmem here:
>
> First, the header bytes are read twice — once into the local
> pcc_header for validation, and again as the leading bytes of this
> memcpy_fromio() into skb->data. Between the two reads the remote
> endpoint can rewrite the shared region,

They are forbidden to do so by the protocol, which uses flags set in the 
registers.  If they do that, all bets are off, your platform is hosed, 
and there is no recovery.



>   so the bytes the driver
> validated and the bytes the MCTP layer parses are not guaranteed to
> match. A common hardening pattern is to snapshot once into a kernel
> buffer, validate from the snapshot, and then either copy the
> validated header into skb->data and memcpy_fromio() only the
> remaining payload, or do a single MMIO copy into the skb and validate
> from that copy.
Too expensive.  This is done this way explicitly for the sake of 
optimizing and not allocaing more memory than we need.
>
> Second, on weakly-ordered architectures (arm64 is included via 64BIT)
> memcpy_fromio is a byte/word loop without a final dma_rmb() and the
> PCC mailbox layer does not insert a barrier on the consumer side
> before invoking the rx callback. Would a dma_rmb() between the IRQ
> and consuming buffer contents (and between successive memcpy_fromio()
> calls of the same region) be appropriate here?

If so, it needs to be done for the entire PCC Mailbox infrastructure, 
and would not be appropriate in this patch.


>
>> +	dev_dstats_rx_add(mctp_pcc_ndev->ndev, size);
>> +	skb_pull(skb, sizeof(pcc_header));
>> +	skb_reset_mac_header(skb);
>> +	skb_reset_network_header(skb);
>> +	cb = __mctp_cb(skb);
>> +	cb->halen = 0;
>> +	netif_rx(skb);
>> +	return;
>> +
>> +error:
>> +	dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
>> +}
>> +
>> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
>> +{
>> +	struct acpi_pcct_ext_pcc_shared_memory *pcc_header;
>> +	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
>> +	int len = skb->len;
>> +
>> +	if (skb_cow_head(skb, sizeof(*pcc_header)))
>> +		goto error;
>> +
>> +	pcc_header = skb_push(skb, sizeof(*pcc_header));
>> +	pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
>> +	pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
>> +	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
>> +	pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
>> +
>> +	if (skb->len > mpnd->outbox.chan->shmem_size)
>> +		goto error;
> [Low]
> This length check is performed after skb_cow_head() and skb_push()
> have already mutated the skb. It also looks unreachable in normal
> operation: net core enforces skb->len <= dev->mtu, and
> initialize_mtu() sets max_mtu = shmem_size - sizeof(pcc_header), so
> after the skb_push the resulting length is at most shmem_size.
>
> Could the check either be moved before the mutation (comparing
> len + sizeof(*pcc_header) against shmem_size) or removed?
This is just paranoid programming. It is fine here.  Moving it makes no 
difference.
>
>> +
> [ ... ]
>> +	netif_stop_queue(ndev);
>> +	if (mbox_send_message(mpnd->outbox.chan->mchan, skb) >= 0) {
>> +		netif_wake_queue(ndev);
>> +	} else {
>> +		// Remove the header in case it gets sent again
>> +		skb_pull(skb, sizeof(*pcc_header));
>> +		return NETDEV_TX_BUSY;
>> +	}
>> +	return NETDEV_TX_OK;
> [ ... ]
>> +}
>> +
>> +static void mctp_pcc_tx_prepare(struct mbox_client *cl, void *mssg)
>> +{
>> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +	struct mctp_pcc_mailbox *outbox;
>> +	struct sk_buff *skb = mssg;
>> +
>> +	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, outbox.client);
>> +	outbox = &mctp_pcc_ndev->outbox;
>> +
>> +	/* The PCC Mailbox typically does not make use of the mssg pointer
>> +	 * The mctp-over pcc driver is the only client that uses it.
>> +	 * This value should always be non-null; it is possible
>> +	 * that a change in the Mailbox level will break that assumption.
>> +	 */
> [Medium]
> The comment effectively concedes that this driver depends on
> behaviour that other PCC clients (cppc, acpi_pcc, hisi_uncore) do not
> rely on, and that a change in the mailbox layer could break it.
> Building a new in-tree driver on an undocumented contract is fragile
> — if PCC core ever ignores or sanitises mssg, this driver's TX path
> would silently leak SKBs or crash.
>
> Could the mssg semantics be formalised in the mailbox/PCC API, or
> could the driver instead track outstanding SKBs in its own state
> (for example, a single-slot or queue indexed by send order) so it
> does not depend on mssg being passed through?
THat would rewquire a rewrite of the Mailbox code, and I do not want to 
hold up this patch for that. I initially tried somethign along those 
lines but it was rejected by the mailbox maintainer.
>
>> +	if (!skb) {
>> +		netdev_warn_once(mctp_pcc_ndev->ndev,
>> +				 "%s called with null message.\n", __func__);
>> +		return;
>> +	}
>> +	memcpy_toio(outbox->chan->shmem, skb->data, skb->len);
>> +}
>> +
>> +static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int rc)
>> +{
>> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +	struct pcpu_dstats *dstats;
>> +	struct sk_buff *skb = mssg;
>> +	unsigned long flags;
>> +
>> +	/*
>> +	 * If there is a packet in flight during driver cleanup
>> +	 * It may have been freed already.
>> +	 */
>> +	if (!mssg)
>> +		return;
> [Medium]
> The comment describes a use-after-free hazard, but a NULL check does
> not detect a freed pointer — freed memory is not NULL.
But the code that frees the buffer sets the value to MBOX_NO_MS.
>
> Looking at the actual cleanup path, mctp_pcc_stop() takes
> chan->lock, swaps active_req to MBOX_NO_MSG and frees the skb, while
> tx_tick() in drivers/mailbox/mailbox.c also reads-and-clears
> active_req under the same lock before invoking tx_done. So tx_done
> should never run with a freed pointer here, and this NULL check is
> effectively dead.
>
> Either the documented race is real and this guard does not actually
> catch it (the subsequent dev_consume_skb_any(skb) and skb->len reads
> would still touch freed memory), or the race cannot occur and the
> comment is misleading. Could this be reworked so the comment matches
> the actual invariants?

It was written before the change to setting active_req=MBOX_NO_MSG but 
the result is the same.


>
> [ ... ]
>> +}
>> +
>> +static int mctp_pcc_open(struct net_device *ndev)
>> +{
>> +	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
>> +	struct mctp_pcc_mailbox *outbox, *inbox;
>> +
>> +	outbox = &mctp_pcc_ndev->outbox;
>> +	inbox = &mctp_pcc_ndev->inbox;
>> +
>> +	outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
>> +	if (IS_ERR(outbox->chan))
>> +		return PTR_ERR(outbox->chan);
>> +	if (outbox->chan->shmem_size < MCTP_PCC_MIN_SIZE) {
>> +		pcc_mbox_free_channel(outbox->chan);
>> +		return -EINVAL;
>> +	}
>> +
>> +	inbox->client.rx_callback = mctp_pcc_client_rx_callback;
>> +	inbox->chan = pcc_mbox_request_channel(&inbox->client, inbox->index);
>> +	if (IS_ERR(inbox->chan)) {
>> +		pcc_mbox_free_channel(outbox->chan);
>> +		return PTR_ERR(inbox->chan);
>> +	}
>> +	if (inbox->chan->shmem_size < MCTP_PCC_MIN_SIZE) {
>> +		pcc_mbox_free_channel(outbox->chan);
>> +		pcc_mbox_free_channel(inbox->chan);
>> +		return -EINVAL;
>> +	}
> [Medium]
> On the shmem_size validation failure paths, outbox->chan and
> inbox->chan are not reset to NULL after pcc_mbox_free_channel(),
> which is the invariant mctp_pcc_stop() establishes elsewhere (it
> sets the pointers to NULL after freeing). After ndo_open returns an
> error those fields hold pointers to channels whose shmem has been
> unmapped and whose chan->cl has been cleared. Should these be
> NULLed for consistency?
Yes, for consistency,  but it does not break things if they are not set 
to NULL there.
>
>> +	return 0;
>> +}
>> +
>> +static int mctp_pcc_stop(struct net_device *ndev)
>> +{
>> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +	unsigned int count, idx;
>> +	struct mbox_chan *chan;
>> +	struct sk_buff *skb;
>> +
>> +	mctp_pcc_ndev = netdev_priv(ndev);
>> +	chan = mctp_pcc_ndev->outbox.chan->mchan;
>> +	pcc_mbox_free_channel(mctp_pcc_ndev->inbox.chan);
>> +	mctp_pcc_ndev->inbox.chan = NULL;
>> +	scoped_guard(spinlock_irqsave, &chan->lock) {
>> +		if (chan->active_req !=  MBOX_NO_MSG) {
>> +			skb = chan->active_req;
>> +			chan->active_req = MBOX_NO_MSG;
>> +			dev_dstats_tx_dropped(ndev);
>> +			dev_consume_skb_any(skb);
>> +		}
>> +		while (chan->msg_count > 0) {
>> +			count = chan->msg_count;
>> +			idx = chan->msg_free;
>> +			if (idx >= count)
>> +				idx -= count;
>> +			else
>> +				idx += MBOX_TX_QUEUE_LEN - count;
>> +			skb = chan->msg_data[idx];
>> +			dev_dstats_tx_dropped(ndev);
>> +			dev_consume_skb_any(skb);
>> +			chan->msg_count--;
>> +		}
>> +	}
> [High]
> Should this driver be reaching into the private internals of struct
> mbox_chan?
It has no choice.
>
> This block takes chan->lock (commented in mailbox_controller.h as
> "Serialise access to the channel"), reads and clears chan->active_req,
> walks chan->msg_data[] using a verbatim copy of msg_submit()'s tail
> math:
>
>      count = chan->msg_count;
>      idx = chan->msg_free;
>      if (idx >= count)
>          idx -= count;
>      else
>          idx += MBOX_TX_QUEUE_LEN - count;
>
> and decrements chan->msg_count. These fields are owned by
> drivers/mailbox/mailbox.c and there is no public API for clients to
> drain queued TX messages.
And changes there could break this driver, but there is no documented 
way to free memory in the ring buffer.
>
> Note also that chan->msg_free is never advanced by this loop, leaving
> the channel with msg_count=0 but msg_free unchanged — this only
> happens to be safe because pcc_mbox_free_channel() runs immediately
> afterwards.
>
> Any future change to the mailbox queue layout, locking primitive, or
> indexing semantics would silently produce leaks, double-frees, or
> corruption in this driver only. Would it be feasible to add a generic
> mbox_drain_channel() helper, or have the mailbox call tx_done with a
> failure code on free, instead of duplicating this internal logic in a
> client?
>
>> +	pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
>> +	mctp_pcc_ndev->outbox.chan = NULL;
> [ ... ]
>> +	return 0;
>> +}
> [ ... ]
>> +static int initialize_mtu(struct net_device *ndev)
>> +{
>> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +	struct mctp_pcc_mailbox *outbox;
>> +	struct pcc_mbox_chan *pchan;
>> +	int mctp_pcc_max_mtu;
>> +
>> +	mctp_pcc_ndev = netdev_priv(ndev);
>> +	outbox = &mctp_pcc_ndev->outbox;
>> +	pchan = pcc_mbox_request_channel(&outbox->client, outbox->index);
>> +	if (IS_ERR(pchan))
>> +		return PTR_ERR(pchan);
>> +	if (pchan->shmem_size < MCTP_MIN_MTU + sizeof(struct acpi_pcct_ext_pcc_shared_memory)) {
>> +		pcc_mbox_free_channel(pchan);
>> +		return -EINVAL;
>> +	}
>> +	mctp_pcc_max_mtu = pchan->shmem_size - sizeof(struct acpi_pcct_ext_pcc_shared_memory);
>> +	pcc_mbox_free_channel(pchan);
> [Medium]
> Probe time acquires the outbox channel just to read shmem_size and
> then immediately releases it; mctp_pcc_open() requests the same
> channel again on first ifup. A few questions:

Again, fixing this requires a fix in the PCC layer, and I am not willing 
to hold up the driver for that.

The fix is to provide a query function that does not open the driver.  I 
have implemented that and will submit it after this driver gets merged.


>
> This maps and unmaps shmem twice. Could shmem_size be obtained
> without binding the channel (for example by inspecting the PCCT
> entry) or by acquiring the channel once and holding it across probe
> and open?
>
> There is also a small TOCTOU window between probe and ifup where
> nothing prevents another mailbox client from grabbing the channel —
> pcc_mbox_request_channel() returns -EBUSY if chan->cl is set, so a
> later ndo_open would silently fail.
This is an issue in the mailbox API, and can be fixed by ensuring proper 
seriliazation there.  It cannot be addresssed in this driver.
>
> Finally, only the outbox shmem_size is validated at probe time; the
> inbox is only validated on first open. Should both be checked at the
> same point?
No need.  This is better if done using a query function which removes 
the chance of triggering a remote message send on the inbox channel.
>
>> +	ndev->mtu = MCTP_MIN_MTU;
>> +	ndev->max_mtu = mctp_pcc_max_mtu;
>> +	ndev->min_mtu = MCTP_MIN_MTU;
>> +
>> +	return 0;
>> +}
>> +
>> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
>> +{
> [ ... ]
>> +	mctp_pcc_ndev->acpi_device = acpi_dev;
>> +	mctp_pcc_ndev->ndev = ndev;
>> +	acpi_dev->driver_data = mctp_pcc_ndev;
>> +
>> +	rc = initialize_mtu(ndev);
>> +	if (rc)
>> +		goto free_netdev;
>> +
>> +	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_PCC);
>> +	if (rc)
>> +		goto free_netdev;
>> +
>> +	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
>> +free_netdev:
>> +	free_netdev(ndev);
>> +	return rc;
>> +}
> [Medium]
> acpi_dev->driver_data is set to mctp_pcc_ndev before initialize_mtu()
> and mctp_register_netdev() are called. On the goto free_netdev path,
> free_netdev(ndev) frees the netdev along with the embedded
> mctp_pcc_ndev, but acpi_dev->driver_data still points at that freed
> memory. ACPI does not call .remove() when .add() returns non-zero,
> so nothing zeroes the pointer afterwards.
>
> Would it be safer to set acpi_dev->driver_data only after all the
> fallible operations succeed, or to NULL it on the error path?
Possibly, but not essential.  It would make the start up code more 
complex and harder to read and to clean up.
>
>> +
>> +static const struct acpi_device_id mctp_pcc_device_ids[] = {
>> +	{ "DMT0001" },
>> +	{}
>> +};
>> +
>> +static struct acpi_driver mctp_pcc_driver = {
>> +	.name = "mctp_pcc",
>> +	.class = "Unknown",
> [Low]
> Is .class = "Unknown" intentional? The ACPI subsystem exposes this
> string via sysfs and uses it for grouping. A more meaningful value
> (for example "mctp_pcc") or omitting the field would seem
> preferable for a new in-tree driver.
There is no accepted value for this yet.  Unknown is appropriate for now.
>
>> +	.ids = mctp_pcc_device_ids,
>> +	.ops = {
>> +		.add = mctp_pcc_driver_add,
>> +	},
>> +};


I do not see any required changes based on this review.




