Return-Path: <netdev+bounces-307108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0xQPEqWzVGrzpgMAu9opvQ
	(envelope-from <netdev+bounces-307108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 11:45:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC39A74970D
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 11:45:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b="RpKo/wFT";
	dmarc=pass (policy=reject) header.from=windriver.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307108-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307108-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5654F303AB5C
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3E73E2740;
	Mon, 13 Jul 2026 09:43:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD99B3E2767;
	Mon, 13 Jul 2026 09:43:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935824; cv=fail; b=JnopfWWfn5MIwSMKeCuzlJBOgYnkGi27buO0OUy4ntH3b6dzaqxfpQnn/kCVtBWFCcWQ8AxCNNWitRg7xNEt1K1uAcMWTD/or8hNFi+YkmNxMyyTzlPvEGjY+QLsG82bsAzph39zAcXQSFtdai2J/pW6LmOtb6cv8+MbJjqZzoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935824; c=relaxed/simple;
	bh=sAy8yW8KdpoGThC1ZSyoa8iKY6DihilRGruo/0Wh+IM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nTD9zC+p29jRQwAIK47ltPejM0FT1Tcifrd6B4anAAzmWd/IZr6mbtHWMk6FIQgaHbp3R65L4PDlh6EmdSGDC2IqkZw8m21F/VHM0XNFVPyh32/i3Ws3Bmp6nt5q4TX6B9OyZVvBGVAEjmQyiyjnYyDmMO3g/e1JayJHudp0GBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=RpKo/wFT; arc=fail smtp.client-ip=205.220.178.238
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6OvA33205691;
	Mon, 13 Jul 2026 09:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=w4Akpz5kTXjLZ2StCsZx9ewNMjufvkgoZlEOm8JQqKU=; b=
	RpKo/wFTZJNbQBGmzMHtMeF8Na3SVerr++LNI7mcQq3XrCP4+hMemodkD4aQN9G9
	KpdnS50xUJecH8nKzxnSHNaZi2Yfx37qcK1xM/mRCMjjSxDxecdduRGLIACsJ7bm
	kc0m4pOaP0cXc17S9dwT8wGxkMLUeQ/ZsNQVnwsqcaMfrmmRYPQ8rYnh1aU43JWZ
	0fBC4QaDqpikn/RFv2tAeWAF/c03SeWDjv7UQGZ7g074OVmDYWwfrBqKk0czOBrl
	nQGJv/NjQzSC5JWT5VuCSMbQFL4zeFWP5E7koR0BU1wai2RFatfulkCcnzlsIt4H
	9PuP9hT7apBFOGInPDn6/g==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fbcpn227b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 09:43:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0tg9iAuASSuXyRVc+8f+8T31tSBWmj9Ucq8l7R/oNygAVP96Iagv8V1Guv96dhKFO7WxGZEF3eAgFqi4uRC9aCF2VYHQr/HWyygJLbDMQ1oU71sx7zs0Ac9ckTei2yAnLC/uUC0qBFv85cX+aI3ZTZhEIRGThLEo5Yi1vvNjUz/9ZPgc8RrGC+HTGIY3CJXfz54n2mnZqFLlwf0OV1DZET4nYvPzzneEZH+UhicWZHg+38Q50XG/HO7Yt2IZ3IwcnAwYBVB9uvH1nQ2ZBL85LqYhaLz3qqH/k9lKrF27VsnLEPwpV4MbvDKJ6JT8VySRwfN3SuwfxdSKGUbjfsNWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4Akpz5kTXjLZ2StCsZx9ewNMjufvkgoZlEOm8JQqKU=;
 b=sy5u6oc1RZW2kCLrhIHdsZuNoCSDsnTWkkXRv8ytJHPW9Ht90DeHdKeQTXfBBUe2M0RxWbr7Y1jkD47S0bGtsvbdIxhz2RTV7duuhhFZFiK3URBARfdqdkHYGHobnDfWb6FJ8WbhS6hHr4bWCviFTfkkm53sFgkwJnXRYBdDtN4d3MIhGMrYqJsdEuOCwR8ECjGhqYDF6Twt371+ypukwSmt6WFQT0lN1py/K9v0RBAIZFw6hXU6XrdhIYyE/LCY+ypKu8gyWv3ufQ7KzAOSD8hX8mf5Mr3N0GTjczi0n6PHZG3u704kzW++wTI8KVj1Ksq//jRyUiDctjWARRPzLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by SJ0PR11MB6768.namprd11.prod.outlook.com (2603:10b6:a03:47f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 09:43:07 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 09:43:07 +0000
Message-ID: <8f58111e-f66e-476c-8a22-2017a02475a6@windriver.com>
Date: Mon, 13 Jul 2026 17:42:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: gre: fix lltx regression for GRE tunnels with
 SEQ/CSUM
To: Ido Schimmel <idosch@nvidia.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260709105243.864835-1-yun.zhou@windriver.com>
 <20260713085325.GA472073@shredder>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <20260713085325.GA472073@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0132.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c0::18) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|SJ0PR11MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff0ef49-c28a-4522-9f95-08dee0c3245f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Y4iMgPN5cNb+PVE1UNpbMCaO2JxBU/1LVxjM8wQvwuZ0ArfLdm64TAG9fkfbAM8FJOINSbN5XpKYZtxHU/HTfKEORPxkGOQa35H5hLbg3LkbDiDtxWVTarMdLchSi8H/cniq3tf7lb/YPLHuTRKI7SfwrzpIWHqHnOpCgCVeboDmsiT2NP8SFn4QSfjJycgVw/xPSCMQV6LHfLn42z2dkD/ep1LIGJfXJE5clho1m4OoKd4LLfkiC3MFGb52p69vUMwAciOOiprUNIgPcfie+8OPc8oJ8oTjmi0EvyU8gC07P/OFwK1wSqtRne/aE/CsY8IkMVatK9lmt1bjEVCP3A3GyvR+YKIaHqw1EL6uQsihmvTC/k2vOU1UjxTzyUXZTHBkpnGoi/nZCMOYzhpFEM/JPUmMWlSJAzRlSaGTOpt7P7u/cd4A/UJf09mv0vsRekJfmiG8Uj9QozWYjWgRZeOdpBMbB8Ju03k4SvnH6xZOl00ixHnPg45d3SZzoyOvr76Qe51fEZ2KkqXaNDqB1cAKSEi4/IUpbG0Md3Dk+UCeQfCCxxfeZ9j75Oz8M6ruetpMoQeugvsaPG6Am8LvleoWgEdT/AarKoeHX5RMA5WcznJ3oPDIZFAw0n7dO2vjD8pDfUhbvhN1KCgOH2rhjzJbM+HyEsnjuApNMHg2/xM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bytjUERWd3JyV252czl4Vm52VG1jWHRCUzdZdFpTeEpQUWhjT0RHV0t1cFlu?=
 =?utf-8?B?T0kzUHh3djNvdVVrSjduQ0RxWmVFVUlNcnFrOVlOMFRUNnVRelVlTkNzbWlj?=
 =?utf-8?B?RUtPbGlhS3I5RzhycW9kNm9iSnZ3N1hVSXVnTXBoeUx4UjlzWlFYeGZBZmxD?=
 =?utf-8?B?SWFpY3lZOXBvVkMxdnhySjdmWTR0RkFScFlEbXZIT3Y5TXBQekdWd0orZ0pl?=
 =?utf-8?B?TkNwZXIwUXNYbEhncHdCcms4Rk9BQmsyemhtZkRsTWhwZGZmd1h1Z2x0QW1I?=
 =?utf-8?B?RFY3QVUvNkZacGV2N0pxYUhjRERHUWlCTS9QVjNzNVRlZUlySWJ2b0ZQSUdo?=
 =?utf-8?B?Z0RMMmRtQ3JRcTcvNURPQXFTZ3FLZzhDeXcxOXdiV2s1QXIxM1BvS3U3R2J3?=
 =?utf-8?B?cVZxVGdEQU91cVlwMCtva2FvRnRuczIrdTNSMmFDKzVVeFhuK2hCTWZVMENi?=
 =?utf-8?B?ZjMycnQ3eURwZ1M5eGtiVFhYN0lKUFllWmdQYUNUQTdEc2E2L016YytjVzVT?=
 =?utf-8?B?YmhkcGxZdUNPU0NJcnVibkhBSWdHc0I1U3RIUVRvM0dQSUswMVZOMnF5UUVR?=
 =?utf-8?B?TElzL2FFcjVzMkVnRlNBS0pMa0ExWUcrRkRwRmFobTMwVklvLzVlVml1YzZN?=
 =?utf-8?B?bXVZOFhkTTljWFg2WjZVWnB3bENHVlFXczJKYmI5UU52S3Fxc1plY2NsUUhP?=
 =?utf-8?B?anZ3Q1dVVTh6U2pTSFd2c04rZXNvYmVaQ0VscUlYZEc0WWlqRE9aRUlzTk51?=
 =?utf-8?B?Tjg2WlFlOFJaYkZDZmNjL2ZnMjR3dHR1ZXR0Rk5BUHRlcStkTWQ3VEEyRFV5?=
 =?utf-8?B?enplcEkzakhIRVdtYThHcmxUWmJTWEdOVFU1Rlp6aWVpcGZzTS9pb0RndzA3?=
 =?utf-8?B?QjAzUDNSS0luMWVpc1R0UGw1QUp4U25BRWt6UXdKaUVqKzA3d3k3dmpkdkhI?=
 =?utf-8?B?dTBiOE1tYUFDQm1hQ1hxdmpqTCtUSHZjWWE5a0swcEw4N1lIV1RDRjU5SXNL?=
 =?utf-8?B?cGxUTHZiK2NyaktnRTFQd2haSzVRTCtmckJ2OWpZdE95OUllU3VVS2lMTzU2?=
 =?utf-8?B?bjROdVc1c3ZoTU82UkhIUTJlQ3gvVXZ4OGFWU1ZGNDBBT3U2dENpTmVZWitV?=
 =?utf-8?B?MWNSN201aEh2MGRmc3pwdkdXYitXLzVGN1R1NWVYbXQ2YUZrMGdIWHJxcGIx?=
 =?utf-8?B?dm16UHRSbGw5ZmluNnI2aE0wblRhbEsrMSs3UzBVL3B6aGVNUGdoUWRqZnFN?=
 =?utf-8?B?VC9qZ2Qxd05ZZ2ZZcGViY1RjSG85L01JeWtHQWZQdncxMFlCOEdERFEwK0V4?=
 =?utf-8?B?WWRuU3cxU0ZpVVh3SSt6eXIya2pCMDVHVE9iT3FmdThFbTB6SFJmYmtnaVAw?=
 =?utf-8?B?eFVvVWVNT2VtYU1uN2hIZzVDNzdmUTFLemVyZmxINTlHSTQzRUVST3VPME1z?=
 =?utf-8?B?TFRFNHhFa0lvKzgrdnBpRXBRa0RjdDhMY0V5c1VSTC9CTWhQelR0RTlCV2pR?=
 =?utf-8?B?WHVjZm9PRGlUeVFWM0VOZEdBWmVWWjVIMTlyMStqVFlYb0VIOCtWZE5mcWdj?=
 =?utf-8?B?c3hFM2VEdHRLc3o2ZThLWDRIelZ0bjVLMHNXMkdEMVN3b1M4NDRNRVZJTXJN?=
 =?utf-8?B?cERDMWJjdk9wVzhzSUV4TnMyalhRN24rVXA5THpTS0pITU1pYjAwNnZmSHBI?=
 =?utf-8?B?MWVUSzJCZVMwZUxvRnAyL01tS2lucjRHbHlSMGZMbHQ4Rm9SQzZoMmhrOEpj?=
 =?utf-8?B?QjZLSnYvUktGMUs1VUN6UFB2M0RGa0QyYjh6dGRKUnBNcnVzVHN2NVh4K091?=
 =?utf-8?B?R1M0c0p6ZlRMUmpSS21MOWZFUWhJc0M1cjdpMkdZTEszaDR1ZGZpQmUxSjBq?=
 =?utf-8?B?Y3BhVkVsUkowdUoxSmp1Qm02dVcvVE56angvQmtLSzBKa2V2MG9kaDdnbmty?=
 =?utf-8?B?WXhIb0o3Q2Nxd1o4TElIK0Q5ZmRqVGw1Vm82amNaWXJJWjBneTZrZVcreFFm?=
 =?utf-8?B?TU54RGIyT0gzazdWU3VEUjhxSkhMQkdPVDBza2R4Yk5sLzJ1QW1KbGVRYnp6?=
 =?utf-8?B?N0l2ZUpzL2xuUWdvSEhLUktSbjNBaWpTTnNjSnpCRFk1SDJGTGZRQ0R2NW9H?=
 =?utf-8?B?YmltZEg4bmJDcmhydlUzdWVxUXE1Y0I1TmNyZHNESjliY1VCak4rLzhFMmx3?=
 =?utf-8?B?NEFLckVCZmFHRmxGL2NSRXhUWU15L3Rsd2cyaUIxdk9rMXp2TkZPZ0ZWYVV1?=
 =?utf-8?B?RERyQWdrTHRDcnNrL28xeWNRaE0yMEtQR0EyaklkOFUwSjZaQXVBeWx0Wk1h?=
 =?utf-8?B?aU1ZeXdNUldUWS8yd0NNMXErSGlmRkFhOW9MenJraTlyOTlXZXRZZz09?=
X-Exchange-RoutingPolicyChecked:
	i+WRjYdF27arIgKXcNrGOsPt6+ssjZUAHqW2mVMexI1JQpNFj12fDEVSpPZsl8EkXT8IK2k9Xs2u5H9SWFkDnGRDRanTL3PbIHnHbQszmAfoJ/VmEHdDDiZv33lccmwpO/uHEaAw6hRK5iPhGRSufKYuHGwLXd6yj9dCbnedEtSbrdbQn0PGmiusvsKHRpefu00a/geQrQNwHkPoWASKUiYqNS4B7K+mH0F26oIR5Z+0a73ee13uEi7iMzqMStsSyHwVlpZG/uSd9PsyhzZCCiL9sPFA1HaFq4mAGCRhW3b4juJF8zRclvXZE7+v1U6kFcMKm0Uu/6dz+GUr67tKiQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff0ef49-c28a-4522-9f95-08dee0c3245f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 09:43:06.9760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJbIR3bOGiOZZXQcFDH6kRAyG1TMLxPQkQQeuD23m1aHKlVy8rWuQBBRKd036j1XFzZBYavIC7d/adJcu31/YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6768
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEwMSBTYWx0ZWRfX8LQChS8oi05t
 uyp4un84y+2tCqBZN45fHBy3Rqilh+EMEv5oEsin8beEEsCOfD53ojX7/im6lYNhNWMxX//DDKJ
 HksL/C5nvN1gGizBWQFq9ReAGSuHabNUeonF7T2+3qNQ2UCq1NZrwWRnbmuh6zBguhmwMryW07U
 vciK93B92lldT7kctjkfunew8uuDSZh8X1a7s2Tdkf70vLBV7PVI3HxKUZYzR/ndxRMrY68ZTb7
 ld+5jAzbaxvoAPtUJHfAdsmx6dxzDHyc/xu3t504iQPo0WMOXYq+Vz6IQNcY8kQ+cDuIk/IRf48
 POHbRb2YmrZkLC79V7VshGKpBQ+Oj2e/aQyIfl7av3nZu8ZqmpVMwzpefqJbOaBKWPG+jn8EcJ/
 sNr3mWJk6x367ZZjFZOjSAe9dfs+VZUeJ2ylg3UB432Y2rK8oG6eZKKuteSW+AEnjfFoDVGI6vM
 P0xEOggc/6Iya59FygA==
X-Proofpoint-GUID: MbGy4LYCT1L5tB8TEp1-EIscgGGd-zxy
X-Proofpoint-ORIG-GUID: MbGy4LYCT1L5tB8TEp1-EIscgGGd-zxy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEwMSBTYWx0ZWRfX634pcqYenUt4
 jojQXDujW7PYiqCkCyn9yFIyTNIUdNgSLh7kQbDF7ZnmFB2hOnxSuQOP+YS8JJhxY7ca1iN1jSA
 cNNsZRvt1rsezDLYMRLSSsrRA0rM9M8vo9gVQP8K+j5sQ8Slx/cW
X-Authority-Analysis: v=2.4 cv=JNsLdcKb c=1 sm=1 tr=0 ts=6a54b330 cx=c_pps
 a=Ja4avHF4q49+S+GKa94BQQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22
 a=VwQbUJbxAAAA:8 a=Z769gSPs5zW2QKvth9MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130101
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307108-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC39A74970D



On 7/13/26 16:53, Ido Schimmel wrote:
> 
> Patch prefix should be [PATCH net]:
> 
> https://docs.kernel.org/process/maintainer-netdev.html
> 
> On Thu, Jul 09, 2026 at 06:52:43PM +0800, Yun Zhou wrote:
>> Before commit 00d066a4d4ed ("netdev_features: convert NETIF_F_LLTX to
>> dev->lltx"), NETIF_F_LLTX was set unconditionally in __gre_tunnel_init()
>> alongside GRE_FEATURES:
>>
>>      dev->features |= GRE_FEATURES | NETIF_F_LLTX;
>>
>> When that commit converted NETIF_F_LLTX to the dev->lltx flag, it
>> placed 'dev->lltx = true' after the SEQ/CSUM early returns instead
>> of before them. This causes GRE/GRETAP tunnels with SEQ or CSUM+encap
>> to lose lockless TX, reintroducing _xmit_lock acquisition around their
>> ndo_start_xmit. Since GRE xmit re-enters the stack via
>> ip_tunnel_xmit(), holding _xmit_lock risks ABBA deadlock with the
>> underlay device.
>>
>>    CPU0                        CPU1
>>    ----                        ----
>>    lock(&qdisc_xmit_lock_key#6);
>>                                lock(&qdisc_xmit_lock_key#3);
>>                                lock(&qdisc_xmit_lock_key#6);
>>    lock(&qdisc_xmit_lock_key#3);
>>
>> Fix by moving dev->lltx = true before the early returns, restoring
>> the original unconditional behavior.
>>
>> Fixes: 00d066a4d4ed ("netdev_features: convert NETIF_F_LLTX to dev->lltx")
> 
> Both sashiko instances indicate that this commit introduced the same bug
> in ip6gre_tnl_init_features(). Please perform the same fix there and
> fold it into v2.
> 

Thanks a lot for your review. IPv6 indeed has the same issue. I will fix 
it in v2 as you suggested.

BR,
Yun

