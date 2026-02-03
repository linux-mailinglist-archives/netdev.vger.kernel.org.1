Return-Path: <netdev+bounces-256460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIOQHZV1gmm+UwMAu9opvQ
	(envelope-from <netdev+bounces-256460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:24:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9F7DF32E
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88E613045672
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 21:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3F536A00E;
	Tue,  3 Feb 2026 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e7fou1wd"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CFF33985A
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 21:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770154831; cv=fail; b=LOPx8GXPazb48NZ1gRaeMzSbd7yXfE0wS4OqplqkWUes4bXOD6tsR/33SS9AtnpjNAOfRv60JCOLru8TMy/wJbLty/2DIjZpo5DaKt6I7HNcD5qxWrwpKwQrvz3TwjAmQnDgWLYlL1YS1i+wZulco9yKgbxaflyWL3JJlcZiUGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770154831; c=relaxed/simple;
	bh=iCC24RZNgqTZZ0wB5LSDIoqE1F2xqxf+FM81Q4KvHBI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m5hFyw8vBJOg/MPtJa/kLix4PD88o2BTAlSpIrC67Q9QgFjpNswGm1cuRaBFKmw6CXQKqqFZ9gggSgErJtm1ay/1Us5IadgIb0l/Lq6aYYNtcCg6Y1zm5rciRJZyM1zI/ZqMz4tUzmxSWaWg3Hfm6OTEKU2V3u4hf7th1fxdtHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e7fou1wd; arc=fail smtp.client-ip=52.101.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pn9C86IlSU7e+lI/pxWrvTUzaFu3RtUVfomlKwcF2YBJbtx/j3nDTVRN8yPOtWt4FdtQGGgyj8WGMSYNV+y6qpUZq0a/3N3IR/FaKxlQFgmAMJqB6WTn4Kn2PDY4gyNtvVZN3lh2fKyZk/+DLjQXJ3mYqiXBwit/ZU0TepQ6426PGNkNtTaqFjyL6LgmozM+9DodB3KBbzXaZYHJlBClB5gtkYunXHSKN4ocpR52UEgmpgy9EklncmLo2OeqzEhMIFJyH8jZ+1Wm1O7n+onnQL1zcT4cgbD9pLj+H7HQVQUtg9th/TS1L21xKHE/LOkYu4rGkFaB2rUoWp1JxQzxjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ex/9tjKG7tvTwi3nWnZ2dqetYv9G9DxwCk+K38EsTRI=;
 b=Ccxml7NHUKw3iti+gmRDp80gTVV6jxK55GnP2brhwJByveLFTnATpUXXWxbseE1iiPlfCq0oPfmYE3RZaahnKuhjmButojsNbU37dRq9epuiA+DON+7s1Lz3UuiqQVx4AIvuyeaCs0nzo8rpkMFMgjlnWAV0BFa4czjZhgl06I7gp7wEmjg5mxHElxStfYX/2QgYFaPtwGNml98Jr0eXGhD9pQupEnGdx77zxrgV9r0IzsKNwRYfhCIZH+TamRZjZF568kpYIOVYeot5bVhfIcxAJcAwiGbNUl2vtRaxvF5dwmOKGku3+qyr2sW7+yToSlQBv8hpHepfcQ2zWZKmQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ex/9tjKG7tvTwi3nWnZ2dqetYv9G9DxwCk+K38EsTRI=;
 b=e7fou1wdwVuPBWK6M8ZLxv5zsOqYzrEtmI2VPhtAC5Mr8R0D27AdTw0a2C/eU452XIRWVv+Pr7Gb2nbkaru8X5sCKxCvxbeV4EA8/DxqAFeOEUlOvTukAXNAgl3X6diEAwyKxbwlY9FrN9b4rMoQ5un7ULpeFwTSfLfwZ+nmNYKw3gxd22AUUU8DBqDtbVAbThJjwgwuUEDkkDDzdax77G1oKNcUpAMmMAWoDurylSzQZVRp6IbYshstTwC6+L1af+GbskIVsRTVae7TqScrgP777L3gAK02RzZj7io0mmck+CyCWDv0Ob3lOqKUm4PC0H71Z2KwmwYzLMuQaG976Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6748.namprd12.prod.outlook.com (2603:10b6:510:1c4::5)
 by MW4PR12MB6876.namprd12.prod.outlook.com (2603:10b6:303:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 21:40:26 +0000
Received: from PH8PR12MB6748.namprd12.prod.outlook.com
 ([fe80::a91b:e47b:4f8f:57fe]) by PH8PR12MB6748.namprd12.prod.outlook.com
 ([fe80::a91b:e47b:4f8f:57fe%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 21:40:26 +0000
Message-ID: <a3aec539-9468-4273-b7fa-6705331c9b92@nvidia.com>
Date: Tue, 3 Feb 2026 15:40:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20260202170518.9076-1-danielj@nvidia.com>
 <20260202170518.9076-8-danielj@nvidia.com>
 <90017867-2649-4632-8497-96e2592c73c3@redhat.com>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <90017867-2649-4632-8497-96e2592c73c3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0107.namprd13.prod.outlook.com
 (2603:10b6:806:24::22) To PH8PR12MB6748.namprd12.prod.outlook.com
 (2603:10b6:510:1c4::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6748:EE_|MW4PR12MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aff7f50-dda7-4e0a-c41c-08de636cd7d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWZndzcwcEZFMzFLY0NpaUlmWm53VHVtbzNqM0dRZFZpUWNIekZneHd4SHo0?=
 =?utf-8?B?dzRaUUtFaGVwOHU2UUo5MXFjSGxpelhlcHNZQzhBRmFNb0UxT3dlODh2a0pS?=
 =?utf-8?B?OWtITWpPaUI1VDlUNTZJR1VXbXZpYnBaTFVLWXdSeFpoQUN0THlxYTJEdkpp?=
 =?utf-8?B?KzdqNXpxUjVMR2F1NlYvUGRLcVlWRnk1bHd3QmF3VW01QXhURXMxUWNJVmZD?=
 =?utf-8?B?dnBwelhwRTlVT09UWXRqU2xRM01XVC9xWTJ1SFRIaEVnaTgrVjVzcSs2dGVS?=
 =?utf-8?B?Q3lOTWJ6bTU3ejVEYUdsS0thL285SEt2Vm9ZUHZwVkI5U0QybXJ6N2VkMnZX?=
 =?utf-8?B?SExMcUZVcmZJdmp2dEpLWUhIb3ZWeEQ1ci82bXE2ZVlwWW5lSVFaRFY4REFw?=
 =?utf-8?B?TGhJZ1ZxQW8rWVRDNjd0RlZjdmJjcmtNeHJaLzhLeW9HQi9oUStvR0pjeWhQ?=
 =?utf-8?B?YnpEWGRoYWRWZklQVFljaHlsZU9FMmw3ODZGcU43MXVmcVVhRzJvWUxTbG9V?=
 =?utf-8?B?RjJ2ZkVnbXhoMVA1Mk9EZ0FBWjBIVEUwTUhyVFYvcU03MmEwei9TWWx6cWN6?=
 =?utf-8?B?b3c4bmZwenJ2UnpaVTNDSG5UajZOaEtEWDZJcHRDTEh2cDVIK2x1VUpZSVJw?=
 =?utf-8?B?Q0pOdFlXZ1l0ODV0MHdVZ1VzeUltYkpQa09XV3JPNmI5cUtlVUVySko1dmQx?=
 =?utf-8?B?RTMwYVprQ1BuM3dZSGlyVCttbU5NOGNSVzFldGRqamZ1YURtd2Y2M3VYR3Zu?=
 =?utf-8?B?WndlK0o4RUpZblg2UDg5UDEwQ2RKakN1VkI2TXgrVEUrU3dPZUN4OWN0QWdF?=
 =?utf-8?B?cUh4SkdiaGFFS0p6ZHJMUlVzbjczV3JtZ2pwS1RvMUdCdXZyL2xNQmQ4SGdX?=
 =?utf-8?B?Y1BOUUZ4UlAzL0tRd0xDaTFYWlBKcGpzeGhWS1pLVzRlUGs5c0V1T09iY0l1?=
 =?utf-8?B?TDRHNWhzMzJXRFozbEJsbFBtTG5uYmhOSTQxZlhoWFlwZFNxY25taHNBV3Rv?=
 =?utf-8?B?SHV0TWt1R3l1bExjRFdqekYwMGRSMVVUbXJTQjRyUWx5eDN0azR6ZkxUWlJm?=
 =?utf-8?B?dUU1elBGMWIzMTVBSER5aWZYM013SWcvMlJPd0RlOC9KbjI0VldCUkN5a29K?=
 =?utf-8?B?cFhTK2xMeUdHQ1JxR2xSSkxwajFmTk1nYkorYXFSVE1UQWVUZWIvekRKS2ZL?=
 =?utf-8?B?TDJTYWJ4NUxKVTVzekpsaFUzUExNRU0wNFRDTmo0ZzE4a3ZsYkVCRUxVZk1D?=
 =?utf-8?B?cGs0Vis2a2d4anpHNFkwUHVJUXJ5WU1SYnh0SlBGMTQra3FTK3I0V2N5S2oz?=
 =?utf-8?B?Nmd2TjQ5VVJucFZIaTBvVGsxS2RxK2lxOWhYbHdsei9TVzl4MEdBdE8xbUpo?=
 =?utf-8?B?ZVJ3U2pUS0lLaGZFRVRKSWNVMVBqdE9YdjJFcHNXUDl6Skl5SkJ6b2ZCVjZB?=
 =?utf-8?B?NjdkVUVYNnBkazF4dFlzMDhOWHdmbTVTTzY5R1g0c284K1EvcW5kRXJKS2tu?=
 =?utf-8?B?M3hROEhlMVFqYWFHZEp2aktsbnZ6eWFYZUoxRUFzYlBqbWtsU2hDSGhES0Yv?=
 =?utf-8?B?T2VZOTdHbUJTVmt2T0xjd3g0Z2NsdVRvOTAxbTRRaWFxOGVrUytjOHM3a1BL?=
 =?utf-8?B?bDFpRTZCYnBkQ1M3UjdtaVRsMXNkUXY5ZHZPTzBabyttaTNWdkdlb1Y2REF1?=
 =?utf-8?B?MzM1VVExbTV2UEtCRUdLNUtMUVFQbXpsZU9SaWF4QkgvclJsUnd1ZVlja2ZW?=
 =?utf-8?B?aEJRMTh2bGZOYUJVMmJrL1haOWswakhHVGY2eDEyQ0FqcENWaGhhbTkvSUh3?=
 =?utf-8?B?RmZXd0pRbVJ0TmgyQ256MTUzZG5sTHRVbkwxdzNsWmp5RTlQM05TVnI2TlRl?=
 =?utf-8?B?Rml3REg3U3VROUZnR1pocFE5NXJiVVJuNEMycWMxOEk0dTEyM1dDcXo2ZVNv?=
 =?utf-8?B?YUw5Q3ZySGxicnhtTmt2V1JWVi9PRWU1RVdyYllRdmovSjBBbWpENndrbHFs?=
 =?utf-8?B?d0ZVbWo4ODdmbzZHdW43bnRTR3VvUk1DK0E3TWJCSEljOUZzS3RxcXIwK1Ex?=
 =?utf-8?B?QkpBSHVQV1FseDIwa00zUnBmNzZvd2VYUjB5amYzWXYrYmtiY21KVm9UU05O?=
 =?utf-8?Q?6IZA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6748.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFh6d1V0OS9xM3VXaDEzUG1ocmdVU3ZEeWtLQm1xNUxlNlR4UFFjWFRvZldL?=
 =?utf-8?B?a3JCeEViSlc1dTd5WnA0S09EenNYbjh3ODg3cTViS0FvTU40MmdrclVJRXdB?=
 =?utf-8?B?cTNJbjhLQzN2Uzh5VGpVZTA4VkdLdGtVRTljNkY1NkgyS2ZqejZRb042TjRF?=
 =?utf-8?B?dVhXZGNWVDZEMGtkOWhoUGFyOWF4T0ovWElBcVJmSEl0UUFNRW9PQ2c2Vy9T?=
 =?utf-8?B?ck5jbUNOSlY4ZDZob1VucE9pRS9LT1FzdUZZNkVIdGRuc2pDdHpPS1I1amhC?=
 =?utf-8?B?c0VmckJQajVXbVFrZXZld1ZUb0UzUXJ0OExCL1Arb0hYcUthc0lsc0NNTXJX?=
 =?utf-8?B?NFMzVjI5UGhtYmRoWnRLWUhBYlQzNFI4TWI4WW54dzBNbUR5RnhxNEg3OGhQ?=
 =?utf-8?B?OS9kS09TSjBOWXVNZndLdkZGMVhNaWRUUjcwQ05XaWVhd2FrMlIySlFzWVIv?=
 =?utf-8?B?aXJwV0U1VzBTbjg5cWdOYXkrQ0ZsQmQ5a1F1UVh3MTdQeHRzSzZkbThxSnJY?=
 =?utf-8?B?YU9YYzhCQzFPdVFyRWRnQjZWaVpqcGdtSVJtTVpBaUpvZ1kwcEdyNnA0dkVm?=
 =?utf-8?B?MFNlanRsNmR5d3F4Y3lDdzJ2cmt4bXZNU1dEWUY0YzJGaEdkTGJIWEpmcjFy?=
 =?utf-8?B?TTMxeDk4dUkzMGoya3V2cWlOYkhUeDlKem1pdDJDTEZ6cVZ3RlhCeDh6SGE3?=
 =?utf-8?B?R3ZCTjdOZEVNOUtQQm1SamJWVTN3MTBxOXd1Z0svclZIUUx4SVAzQkRlRmV1?=
 =?utf-8?B?VkgrSGE0blc5MlpNZFZWWFFxU2Z1UkhQNjFrbVMxcEFNSjUwT0R0RURWcEhs?=
 =?utf-8?B?V2VOSzF2a3FUdlVpeHp3YWZiVE1JOTRlVzZqd2VoQVBRamRNNmpEdXdNQzc1?=
 =?utf-8?B?aUlUTGRaZVVVeDNWT1p2Wkt2b25NOElxQlpDdjd1Ym9JbTBGZi9ET2cvOWVS?=
 =?utf-8?B?K1RGVnE2cWFUc1RCRFhkQlF4VER5aFBvdCtZeHQ1aUhIQ0E3WW9KVnZNeklS?=
 =?utf-8?B?d0VkdXBubnk4UmdsblU5THU2dVBtOHVzT3UrREd6Q2pPTHNkQU81eUt0Kzlv?=
 =?utf-8?B?Y3BmUVRGbUlnUG9WdDF6ME9wRXRFbGNrUFRLRG1pV05qYUlKajFyTXRGRTAy?=
 =?utf-8?B?cGVYdUdVQ2VjaXRPcUd5N2ZrV21ySWF0Q2RuR0dRWHRyYnpCZU1IbkJUMlFY?=
 =?utf-8?B?T281TFFxd1E4Y1Q0WEpXWnRYcmIyRXg5d0FpbU5RUWhMQnBXOExnWncyVGRR?=
 =?utf-8?B?NlFvT1E0ZkE5UDV6YjJLY3JiTFZWcnBrTDB5ZzFrbjBGN3NQOWIwZWdLbENJ?=
 =?utf-8?B?V3EzZnR3Z3dlanA4andTQVJ6QlpnVHp3Q2dleUhRSWJsTjZ2KzlQMllGdDc0?=
 =?utf-8?B?T0NZekcxUm5mWXNycys1NXZyNzNqUDAzblArWm15S2ViajNOZTBqMk1nVlFU?=
 =?utf-8?B?VkpTd2oyWFlReEFyYWNsck04YklOTDFzbElvVTV0ZW9nL0lvbE1VRDdJUm5H?=
 =?utf-8?B?OHRsUmdSSEhsMTFSNmo5Y0dXaHhHZzNPY01MQlMyT01NRmoxcVRSelVyL0hJ?=
 =?utf-8?B?bm5USTdQU0dqcC9wMTFCdzhFRGYybUczU1E1YlJEZStrK3BEVHJFbVNaMmY0?=
 =?utf-8?B?VHVvaExPSThNT0hFSGVxSjB3ZnlEOFpIdnJDU051QWFlNXpBYWxvYkZKWlJJ?=
 =?utf-8?B?eXlnbjNKa0xjZTc4WG9wdFpCM2cvbHUzUFk5ekd3YU9FeXFFT1E2bzRSZDlj?=
 =?utf-8?B?eC9tRytWN3pZOFZ1V1VWZDZ5LzBqQTBqSHpFZUx4ZWtDa0gvZnp4RnJKekRR?=
 =?utf-8?B?VkZzaTAwRjNFRXFPaWZPWDVFdU9DaEJyMEU5dmFiWnlHeUkxNHlieGxIL2Z5?=
 =?utf-8?B?SGI3Y2s3UTZ1bFdWTmZHTXF1Z05udjBObmc1ektnWW04V0d0cXVubitOZzdz?=
 =?utf-8?B?UVFDWUlLRmRVSVpBdWNWTDdxTVVZNU1vUVltU2Y3V09jQjdXNnVENUZmWEtu?=
 =?utf-8?B?UHc2eGNoaVNMZVZmR2pKRDVtL2xmMnpKdldkS2MzRzFLdDRWeEVTNFY3aVFD?=
 =?utf-8?B?MllBQ2hHQTgrQWpqWDAwU3VzVWl2eWIwNjhJWXg0SnVEV2IwZE1Sb0RUQWcz?=
 =?utf-8?B?YWtGamdFVTZDeHBOdDgxQmF5bFEwQ0JHSEI5N2hXelN0Y1QyRmRiYlVyeWNr?=
 =?utf-8?B?ZWhZZldwSzhqaUtjRFZKdTJIWFlUWGIrdEpGcDlxTDJDMHZ1Ym9uVk0xd3F3?=
 =?utf-8?B?RThkZlRxTitSSUlqZWJpZ0VqdGN3UHJ6Y3g1blN6M08vTTdXWnVhYkVDdlh4?=
 =?utf-8?B?TUFyQzlYenRzV0NhaDUzZEtMWlcvcFlBdVFCNWsxMkRCV255V0VFZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aff7f50-dda7-4e0a-c41c-08de636cd7d5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6748.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 21:40:26.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O853VHpwUCYYrrbp6JEsUsFqTyQ/Oi1xhSYNaaLHwVQ9RjkjVhwBLQb8q0xULmVs2tkDmPmWYb2b1LwLrJbELA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6876
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-256460-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: DF9F7DF32E
X-Rspamd-Action: no action

On 2/3/26 3:19 AM, Paolo Abeni wrote:
> Hi,
> 
> The AI review reported a possible issue that looks valid to me.
> Reporting the feedback manually because I think only one to the AI
> remarks is valid, see below.
> 
> On 2/2/26 6:05 PM, Daniel Jurgens wrote:
>> +static bool validate_eth_mask(const struct virtnet_ff *ff,
>> +			      const struct virtio_net_ff_selector *sel,
>> +			      const struct virtio_net_ff_selector *sel_cap)
>> +{
>> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
>> +	struct ethhdr *cap, *mask;
>> +	struct ethhdr zeros = {};
>> +
>> +	cap = (struct ethhdr *)&sel_cap->mask;
>> +	mask = (struct ethhdr *)&sel->mask;
> 
> This function casts sel_cap->mask to struct ethhdr * and accesses fields
> at offsets 0, 6, and 12. Shouldn't there be validation that
> sel_cap->length is at least sizeof(struct ethhdr) = 14 bytes?
> 
> Looking at virtnet_ff_init() at line 6291, it only checks that
> sel->length <= MAX_SEL_LEN (40 bytes) but doesn't enforce a minimum
> length for the ETH selector type. If a device provides an ETH selector
> capability with length < 14 bytes, won't validate_eth_mask() read beyond
> the allocated mask array?

It won't read beyond the end of the array. When we retrieve the selector
caps we make sure the that the size of all the selectors and their data
is less than what we allocated. So I don't think this is really a bug.

I'll change the check here to be sel->length !=
get_mask_size(sel->type). It'll fail in a clearer way if this is the case.

                if (sel->length > MAX_SEL_LEN ||
                    test_and_set_bit(sel->type, &sel_types)) {
                        WARN_ON_ONCE(true);
                        err = -EINVAL;
                        goto err_ff_action;
                }



> ---
> 
> Note that the AI review additionally reported a possible leak on xarray,
> but I think it got confused possibly because it run out of token and
> mixed-up the patch context.
> 

Yes, I saw this and it didn't make sense.

> /P
> 


