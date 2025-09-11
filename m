Return-Path: <netdev+bounces-222234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968CDB53A36
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 19:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE447162D1A
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 17:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECD01AF4D5;
	Thu, 11 Sep 2025 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cYH9U/em";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XRY9z1op"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E1D239E70
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757611110; cv=fail; b=U3gvqvUXtCVQ+6X1gV+u9VFYe9EYQAF1i/6YpdOzxKdAec5VQbAELAnacwoGaDyw8WdtqntU/aZmv9LdfnhFqPNauJ9QUPwcqYO2dbJs2xzL3DkTjmmprMyFmIUtAUpCjKAZFc42GpTuLO+m3JxyBKZI/eUovGYrRDSxmc4gcro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757611110; c=relaxed/simple;
	bh=2/VmyXl5FBwXh9uFABHSjJphrxiFi2cWKC8ht5e7+t8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o2rYDmDxw6CfjO93h7G2TdcEd7Y7TeTa6rk3e+nRaBDgKMDj/tHus+hz7Lvi2Br+79EQqUu6ftBlvw5AaqW9atbSnEtL73xfQovMnppVrcIun6RdnXZCq0IAyftqamZymMzf0ipNdTlu3sJ4gqzpvNFNIhqysUZ6AtWGw2xG66o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cYH9U/em; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XRY9z1op; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BHBxcH018367;
	Thu, 11 Sep 2025 17:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=V8QBhKg7sDmy64GhOd6C9AY0EgxG/tHSRIimTC9uE+s=; b=
	cYH9U/empXbpngfWYZt8tWZwFhT2z5KKJU+KP7HpXh7uhMwJGRPGgrNUx4ldeXuN
	FhI0aeedK4JBg54bmrPnw3JZ5FWpvrMXdQcVjoELkHkeFAa0/fI1QLZr4pMKtEAJ
	6m0wTHqCuNixLANs79pdSVuYA2rU9+uzaSrs4ms4tj+uyLDOVj9ud/s/Ju45dgB1
	kV3ATtsf6NpgvKcidJeCuwhF4ngE4N6djZnqsQSNHWn3ikBbQDVH37Gq0ZQGviHc
	tngTPJDtznSOec8mUQg5cR5CDhUPRNcC01rd+Feu8FGUiGkPzvvjlH/ldk3cpg0q
	HKEOVwGzNFwoH2yibCTCgQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1pv1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 17:18:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BH2e5t002971;
	Thu, 11 Sep 2025 17:18:14 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdk8w3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 17:18:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPYcHsmg5jCM9Aajfw9tGD3VsYM8Hox41OhSVzkmSNnyTA/G4jwOFBEr6p2XjxZg0b9lm9SGOQHnXjAGfLOaB9NsZ7/T51Tc0yX0v4FnacsgH/igEyirs5THRlmAoM4FIfTc20RJLabjRDyP5LY0wiELPVyGR7AGGoLQ0wHrI2ebZa3XeDY/XCzdbiun4GDH3CLVEGP1Phigu99lL8R5wfiC79S+L8Llzi6sJODEoJ8fAQHrilGUVWuCK4vQl8A4ATjCmlvIJKmJfI6uN1R2VsahywP41AmNFwWKBcXjxZT3wD7S1jHkGv5u4AA69/FAVMa6aqa3QMCMCbkkrQ4qjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8QBhKg7sDmy64GhOd6C9AY0EgxG/tHSRIimTC9uE+s=;
 b=JDkdzCnH8U4zH1jnI8R5UiSpFWhxrl0FX5oprTqs9lYK6xtrGtuSk9jQzElf4aoUq9k6O6CQ2ng2L6b1gogqmz3n/ajuNGQIAtoM0wQwQq8YKHutxaZIF6yT9o+sTQjmXYqGMlMgQAwnCWMCIZVfuBOlHA+c3u7ugrhaYTOe1bfcAHmDI75E9MllnGXVe6F2ITUIsB7IcdD9tfl1d+f4Iq57O78CFL06nA0Ix/51OKlXSu1q5q+5h1l+2Fcvrax2ZRhqI8sdCl/sMnsZ4H0kx4Aevtw+gOpoSnV5dkHQ4vmdOxWvs005427lTuh7y+w8dBi6PZ99UdDoQyyaepj0tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8QBhKg7sDmy64GhOd6C9AY0EgxG/tHSRIimTC9uE+s=;
 b=XRY9z1opp3xj5PE2wSaALyb59+27iwF98H3tqW9HuGr0G27jWTzzCO6nMgm8l6x1hbhexZWmi/a3lS0yMqn3PK1xMxwFB8XByJG1FURRjWiGbP5gFUAb0dYA0ROjUnqy8Bd/Z7+1N/KPxMy7RSSp/lD4X4xXTAfaiXZKzDz6WAE=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS4PPF7BD9BEA92.namprd10.prod.outlook.com (2603:10b6:f:fc00::d2d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 17:18:11 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 17:18:11 +0000
Message-ID: <2cad7a63-56e9-409b-90b1-69dfe73358c7@oracle.com>
Date: Thu, 11 Sep 2025 22:48:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH net] net: ena: fix duplicate Autoneg
 setting in get_link_ksettings
To: Andrew Lunn <andrew@lunn.ch>
Cc: shayagr@amazon.com, akiyano@amazon.com, saeedb@amazon.com,
        darinzon@amazon.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
References: <20250911113727.3857978-1-alok.a.tiwari@oracle.com>
 <6500d036-f6ef-47df-9158-529b2f376fae@lunn.ch>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <6500d036-f6ef-47df-9158-529b2f376fae@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::11) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS4PPF7BD9BEA92:EE_
X-MS-Office365-Filtering-Correlation-Id: 4def2940-87dc-476f-8420-08ddf1572f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUFadjFBUUc0RDVueGtZdmR2aXJLM1VQMjM1YVBnZ0VCdHErOXZBb3V2YWxk?=
 =?utf-8?B?enlWTGN5WkpRcVBJMTdYUldoSUVwellKUnBqMkx5N0NkTWJTRFNJR3VPOXVN?=
 =?utf-8?B?dVlmRFQ5YUdwMUxQWk4wNXFQTHZNc3RBQlhEWlN0VTNabWdBQTJNOU1aZmFT?=
 =?utf-8?B?eTNrSEQ2RXhjSlZFNGgrVWxwSFNRaGQ4NXpBMjRkN0dOVzczWFJTQzNRb3gy?=
 =?utf-8?B?djQ3N2VQaFZsUWxISFcwM3QrMnFucE1taXpzY01zSDBlYU5VSDdDeWlndXhl?=
 =?utf-8?B?d2gxbnNrRTM1aUI4bzJteXRJTnp3V1Jxd2MxQ3JxSG1pTWVxZmRLcnRKOFpD?=
 =?utf-8?B?TXk0QkJ2S1Y3Y1YveVMzNU8vYTRYY1NIUFhIL1pDNzJJVmRqK2kxQUVzU1Vj?=
 =?utf-8?B?c1diK1lxL3Fvb0J0RGJrQ29UNUxTeVJVNXdENVNwNEo1a3NBV25uaVlXUk9H?=
 =?utf-8?B?eit6R2prVFU1VThZcllLT2duQzZ2Y3VzUzlibUcwalVPdTdwK3NHUmZzN256?=
 =?utf-8?B?TjFWUUhObFA1M09qUjVoTG0ySEFkWEh2eGhsTEFWUWl2TVNZcC81WnlyL0ly?=
 =?utf-8?B?Z0t1dCtwWVlrZENNU3A0NmsyTldSWmE0SWVyMlhuOFl3UlRBS2pDYzVGUTYx?=
 =?utf-8?B?anByLyt4WkU0UVNyZG9OSUhscThNUTFFa20wejloZEhuOTVDQnFOSkpwYnhn?=
 =?utf-8?B?MERDMXhqeFFPSzErWTQ0STdIZ2pGdjZQejE2dEw2K3RpNzgrMHdvclpFV3Vy?=
 =?utf-8?B?TS9jbFhEK3VVL1AvdW1oTmwweXJxZ1Y4NkRBMHFKQXBRY1cwMkFiUG0xbVZj?=
 =?utf-8?B?NUx3Rk5JYkRzbjBCT1JUNUFJV3N0N1F6WXRrdU9uN3NTdC9zclpKN1hMcVVP?=
 =?utf-8?B?WjMrTVBhcWNJY2hxTGpkeG1LYS9PM0l4VkRCSFI1UWNJZXNDZEJKcThkQ2lh?=
 =?utf-8?B?bkZFZkJBeUt2aUlYVlZaUHVSUzV5alNud1dJaVNUQkJvSm11eXZUdHMzRjBI?=
 =?utf-8?B?Q0pMbWxQN3JIKy9QVlZRc3daOWhNZGN5dXBNRmNIK0dETEhRNkdkMEJkWXpx?=
 =?utf-8?B?L1ZiWVB3SG1ib1BlQ2FlakhoU25wN2hiRm85cVh5UXJlUGNUTjdyNGdVU1l2?=
 =?utf-8?B?RGl1ZjZ3YTczRjlEMElSSWpXbG5WbXp3R2loSFBZS1RzTEMxSEZvaVp4TFVH?=
 =?utf-8?B?SWNSdlhHdE16WXJZWEVCUms2ajJUQStnNlAwRXpJTDY1dTJwN0w4UE04eTRh?=
 =?utf-8?B?ajlKOFdFZFZHMFk2ZXF3VTBidXhlVnhZOGtwWk5wd09Qc3poNG1EdldNUHJv?=
 =?utf-8?B?SFhUQUI5UFl5aVgrMFovMSsxeUVoekp5WDFxNjlKeXNvSXZIMkluOHFJVWha?=
 =?utf-8?B?c2xoa2k5SC90YThxTWVkaDhQZ3R5YzVXb3ppam5mczhtL2xMYkVxZjMyU0ox?=
 =?utf-8?B?RGVUdjdUQjBTZVZraWRJZHVBNk5PRVdIQlMyOWNjWDd2S3dtUXN1eXYyY3dB?=
 =?utf-8?B?MnFoQVNPUUtmVWVRWGcyUWNVTzJFREFHSU02cTVvcUo4b0FCUHF6MENRUSs2?=
 =?utf-8?B?TWxyYkY0VE83TXVadkVuczk0ZnZtUWZENFR6NVNYanZXV3EvcVhhWDZiL2s4?=
 =?utf-8?B?cXFUS1lxdXNVYldVZnIxekhpMVFQNU5sbVpTaGMwbEdrTWlpYTJHYml0aFF3?=
 =?utf-8?B?dEdXeEVUNVgrNXBQQzc4ODY4dFY5VENQQlJhNkEzTG40VFh0SFZGMExwWlE5?=
 =?utf-8?B?MkdFVUpzSGluUmNHelFyZGlaYzFCUE5kUlJFUVpjRjlCZ0VjcGNzWGxYeGpE?=
 =?utf-8?B?eW81cFM2VEFZaXJlWTZDbjJJMkQydEpBbUQrZlBtdkdFZHFFT0FPQWlGRlp5?=
 =?utf-8?B?dzFObGtTampYdVdqZ2ZUOEtWblhaS2hxM1JUQWR2d3ZqUHl4dXFUbC9TcHlw?=
 =?utf-8?Q?mBWXEAtAJYg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzhrWXpXUzhXT3pyWi9qMTExamo2UXRHYW4xRENNNTV6TDJ2NkUwSldQWGRo?=
 =?utf-8?B?SVpNTUtCaWFpckxNek9YblRFYi9BeXVPZ001endQNmVXM0xUNjJkTzBsd3J3?=
 =?utf-8?B?UVZlSFNzOEMrdHE0MmxtTnd1WU1KTTVyNHl0N0UxaHBMVWNOTnpzTXFndVhk?=
 =?utf-8?B?RVFYSjdCYmk4TEEyaGppY29TTjBtMHBJaFl5ZGRrc0xRdmk1dkE5Z0w0aUpk?=
 =?utf-8?B?YlRPY05KajExeHFGQTZ5K2k5UVZqWEtCV0ljZ3ZqWGpqSDZCbjRSYzZlTFkx?=
 =?utf-8?B?R0RsRzU1WC9nL2xaK05WMHdqTFV2RUx1OTNOTndWaEt0SlFrM1pBMXJSK1h4?=
 =?utf-8?B?TWJCa1lFNkdic0M4VUt4UUJiTVN1WlFjdDF6bGEveGNBMkNWRUFBVnM3bVZt?=
 =?utf-8?B?UnMzL05NMW5lRzN4SXYrdEZmQ2lWUVNITU13MWh3eTZuQW5HbDFNRG9mTFU5?=
 =?utf-8?B?cENiTmZzZW96NWpNemZXSFgxTzRsYzYzd0IzVVdDT0tJVXk1Y3ZKUTM0SUcw?=
 =?utf-8?B?endGbFJFQ0VrcHFoaFROYkR6WGY3ai9aZi9UeFhocml1WXRIa1lKa3NTWXVY?=
 =?utf-8?B?VnJyRFNxTDhLR1pyUUsxbmVmc3NVcjhPVFJwZG1MK1JzVE40STFQSGNFRnFk?=
 =?utf-8?B?amZiNDFmZlJQWlZjc1oyckY0NVc5Tk9HbzNRMGRMd0htcjNuSFMraklzTU0w?=
 =?utf-8?B?VCthcXM3M21Ybk50cHpTZzJFV3VJWTk0QnVoU0FTaWM5Qjdvd3YrdE9qcVJj?=
 =?utf-8?B?MXVGVHlsaVBFSUpHT2xJeTQyQ2NKVnBKL3BHOWhOQzd2QVh5WXREQ0hXQ3No?=
 =?utf-8?B?QmhHZUZ6cU1lMUxEY3dwNVd1cUtNTTdBTldTZlA3YUdqWk9zM3BIaitQRmZO?=
 =?utf-8?B?TjgyMmFLclFDVE5JRnYrK1BsZWRxY3laMGpkK1JTTFZZQjQxZEswN0xEdGxa?=
 =?utf-8?B?b3BCb0gyd1VKY2JRelllaXo1Q3VPamJmTzJVRENxMnlXb3lkVUR1YXNPS3FM?=
 =?utf-8?B?MHpMSVAvZi9XbjRHOUlUSzFVUEowcFE1UjJEMTdsQ2RwTUFRNzVjVkU2WENH?=
 =?utf-8?B?ekpXNmNwY2UrWGdpeVJPSXNMV1ZCdlFjdi9IZDcwQlg0aHQzeDJpRXVHR3lZ?=
 =?utf-8?B?dUx2TGhSRWRHUGQvdzhXNHpKYllnTjBTQzBIWG14ZnlsQ1NWNi8xeVg3M09q?=
 =?utf-8?B?SGJJMjJZMGwwL3J4eFVCVXNGUjZ0RFRSZTBYRG9wazZaR0Z1cEdxbkJ0VTR4?=
 =?utf-8?B?bGdwN2xZa3h0ajdSdUhjWHlZaWh3TUZlakg3R3krcnA3dXM0b25qMXhQYnZT?=
 =?utf-8?B?M215Z0FXZ0pocDIvNEFuVXNWYzBWbVBkRG1hcFZMWGx4OCs2S0M4b1pmeTQ3?=
 =?utf-8?B?OUNFQUZlNHpkelRMekNZQThVYTF0Q3prVEd4Q2VyK3pqd1VubWo0Nnh3QU1l?=
 =?utf-8?B?ZFNYOHRzdENxQ2g0WkpwRGRmNmk5enNPZ3FFbWFsVWdLR3JLNzVjYS95Mkxk?=
 =?utf-8?B?aGdRdlVld0dNZXpoVUxYMkV1U3VzWjQ3TWtheWhrU25pZ1lRWDdJRVRDMlM2?=
 =?utf-8?B?MHlXZU9oUm1BMDNzcE9mZlBkc3BXeGFycUNkbWpVc2hFVW9YWG90dEw4YlIv?=
 =?utf-8?B?akJHN3NmbHV5a3l6RzNsUFZRV2xGQTVpakM3TndCci9mN05kWjE3dTEyeU9k?=
 =?utf-8?B?UHlBdk01Nlo3WDBvRXlST0FWcE5EaWhGZG5NWTJUTFkrSkpiL3E4cmZua0J4?=
 =?utf-8?B?ZWZJZmlRSnpiMmZ2eFJ0YWRLSG9ndUMrbWNyWG5DVUpkdmlUNUFBTkxRZ0tk?=
 =?utf-8?B?c1dlN2IzdWgxTDlVaFpPc1hFemRUSkRNaXkwaUIwY2xDVUd6QkJDTUdKQ2dr?=
 =?utf-8?B?WVhnMUU3bm5zQmxoVGVlMytaLzJNL3hvN0g0eklhcWc4amFHaWFhdTJubURw?=
 =?utf-8?B?NnR2NHNUMm5XWnA0L2FYRGRxSkh5RGgyTS9leEo1QmdjYkZWYVFGQ1JhYmpQ?=
 =?utf-8?B?U3laREdUWC96SmdIK3lRSXR3MVJJMlZ2am1aN2JjMGgwbGJ1RVY4NW5uVzFv?=
 =?utf-8?B?OHJRaUw0eWFwb2IzN01YM2RGbkJQUVdwb1NiTXdFSENyaTh4N0RNYjNjZDFz?=
 =?utf-8?B?M01RQkNkbWdGcVJLK0tOYXJ4UlVhM3JJdXJwYXYzQktVYkNJZm9EYm1aamQx?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DMEGoecmxnhpE2G0ljAVDpKf260FuWoGcBrD7xVpnY550PIhPL9rPqKRO7Y3fjybbtRT1uSz9hfBVTUMlKMnWjzbSXOgudHRddZA8wwqtmLjtWN6j9K+BFrBE4bUwdn47o81SxosuHrxLAhSgNgeX6ReP+ILtx5PmJ+T3N1JgjlN/RRcHQut89MI/fi6JS06l0dnUYwlln33Cyk37VhbZHhn4hfyER8dzi69Y9XSr89nCXyV58/eRp2VJ0A7KRNiahKYpte7/NZ1mwpThZGbZMNNY2Juf0Ke+efS99PxZ8rQ9HKZKYorjAOStA3naKTBRTE8vhzKeY4tvKgISJapTOg+l3rR4Hv1lbpAywvkca801SevfbBEPyDCnl8/JPYtIhKOdErAgYPCSPpgLC305jd6nk9JbJ2Y7TJ/aRgcAw+j/I+pYCDgvwTJydeGPvGVz7Nrv59dlMGx+dR+Aicpd6LQhlDbyJXq1sq4zgvFUsAcGnm6JlqdBxB/J36tOQY9V0ZhrjRLknrY3m0k4aKSaEEDmivKEcw0JsFFzYn0U5+Hn44PvqS2k/0jxB0jJSm3blNXuLWg8VzJ9WM1KwpBhEjZL1410TpmSYMZ8G/LZSY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4def2940-87dc-476f-8420-08ddf1572f36
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 17:18:11.4275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rPXDztQgKNbtBuRntPZpx+A40sfJz3m9UMtoZs0WpneQWvyl5DimgxZ/IDtdXXZ5+KAlLpRLbi8n1rJneSKIP0Kzgyxzo0b/tdE8Lgx5Ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF7BD9BEA92
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110154
X-Proofpoint-ORIG-GUID: 5Tc_cCcLX8pETD78eEw8AfLBzvzMlnNd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfX08kAJB5wl3lz
 zQvbbTfXxPMZiCxdDLF/K7CWmsxhKCIaH7vi1/o0vrism1IjwFCgEcYoIjQSpi5aZOMkEVqamHo
 fterotlO3k1j09MrZGvfy1Cpekpkb+As2c/gilzsHQbIppPU2gmnn4VaIG803iLhvYWrC6EIDB5
 CUCAgbxDUHgZ3dIwR4pDl1EDOJXLRQVsWHQdymydjYE6QMTKfgYqQh8wbn2jL2FXdj3fMCEy8E/
 m+bKelVt0VmkjF7H8qNynJWEcXOwTIaoNTHsJJU10C6EUAKiQ233ILcU7K6RpCMHHq7Ju1CjhMq
 n87spbA5hu8lShKW5EhZGHD21iOSKx2L68+Vkdc2isEHtokp+Q7QzEMSkhBv/oPmlsk4tUDEbEa
 F8lg2CccF4IdDfNkeomlc76v04cnBg==
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c30458 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Ee25Y81XHhGl8Bvb:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=js5zSrmNTFIPkzqVtYEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12084
X-Proofpoint-GUID: 5Tc_cCcLX8pETD78eEw8AfLBzvzMlnNd


Thanks Andrew,

On 9/11/2025 7:57 PM, Andrew Lunn wrote:
>> The ENA ethtool implementation mistakenly sets the Autoneg link mode
>> twice in the 'supported' mask, leaving the 'advertising mask unset.
> These are not masks. They are bitfields.

You are right, these are not masks, they are bitfields.

> 
>> Fix this by setting Autoneg in 'advertising' instead of duplicating
>> it in 'supported'.
>>
>> Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
>> Signed-off-by: Alok Tiwari<alok.a.tiwari@oracle.com>
>> ---
>>   drivers/net/ethernet/amazon/ena/ena_ethtool.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
>> index a81d3a7a3bb9..a6ef12c157ca 100644
>> --- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
>> +++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
>> @@ -471,7 +471,7 @@ static int ena_get_link_ksettings(struct net_device *netdev,
>>   		ethtool_link_ksettings_add_link_mode(link_ksettings,
>>   						     supported, Autoneg);
>>   		ethtool_link_ksettings_add_link_mode(link_ksettings,
>> -						     supported, Autoneg);
>> +						     advertising, Autoneg);
> While i agree the current code looks wrong, i'm not convinced your
> change is correct.
> 
> What does ENA_ADMIN_GET_FEATURE_LINK_DESC_AUTONEG_MASK mean?
> 
> That the firmware support autoneg? If so, setting the bit in supported
> makes sense. But does it mean it is actually enabled? If its not
> enabled, you should not set it in advertising.
> 
> However, if we assume the firmware always supports autoneg, but
> ENA_ADMIN_GET_FEATURE_LINK_DESC_AUTONEG_MASK indicates it is enabled,
> supported should always have the bit set, and advertising should be
> set based on this flag.
> 
> 	Andrew

Thanks Andrew, for pointing this out.
You are right the distinction between supported and advertising (as 
runtime state) was not properly reflected in my earlier patch.

 From my understanding of ENA_ADMIN_GET_FEATURE_LINK_DESC_AUTONEG_MASK:
- It indicates whether autonegotiation is enabled.
- ENA devices always support autoneg, so supported should always have 
the bit set unconditionally.
- advertising should be set only if the flag is present,  since that 
reflects  runtime enablement.

So we have two possible approaches:
1. Explicitly set supported unconditionally and gate advertising on the 
flag:

/* Autoneg is always supported */
ethtool_link_ksettings_add_link_mode(link_ksettings, supported, Autoneg);

if (link->flags & ENA_ADMIN_GET_FEATURE_LINK_DESC_AUTONEG_MASK)
         ethtool_link_ksettings_add_link_mode(link_ksettings, 
advertising, Autoneg);

2. Leave the logic unchanged but remove the redundant assignment to
supported to avoid confusion. (send to [net-next] + no Fixes tag)

If this approach looks correct to you, I’ll prepare a v2 with the 
preferred fix.

Thanks,
Alok


