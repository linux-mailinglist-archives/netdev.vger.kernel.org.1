Return-Path: <netdev+bounces-240011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 861C6C6F475
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8EDE4E4E37
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3A132721A;
	Wed, 19 Nov 2025 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pVGEngLT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DguDrzCj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69EC2FFDFC;
	Wed, 19 Nov 2025 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561305; cv=fail; b=ZWdP/6iD2GEaKUDdJP8pE1G9043+2QtwngE7elOmBwL8JYrmIORWYOYq6qtFggY073+Qnu40oP1S3i1tvfO2zfFEN8YScRop7celP6ssUL9H2jZh3IyrvqEawig2FOMLBxAPYV7xAbjd9oLwXtgqPR1xIVsepdS8CXLavHED2Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561305; c=relaxed/simple;
	bh=SsFShcsGTuInOPwnSdZEcvc4x0HJlFKSi3FJ9WJMR7w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MRQlwYvBSRBVdgSOBuMubnl2gjX7yNSJWVN7/pv7blVQhpHDE6Am7KFSut27tvUMJdE5GhvgbIL9NQiSSNzyayc6uS8SwVheI/VaKuZmLbQBpcQgyChxbL3RHYqyYepgNX/YmK6VoEc1nlC/WQs+be2goascyn4x901z/UlccyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pVGEngLT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DguDrzCj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJE78YW010781;
	Wed, 19 Nov 2025 14:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=m0TPQgJK3YsXoFmv2ABiZZdamrWexvur9zn6glIUlG0=; b=
	pVGEngLT/SBZCUlxVlYMhTJODGYlGXBswyLIOnTUrKkpMlG8kyJK0Lawevqze6dA
	7118JzlI2EDfghzTUJjaZnp4yxDmavmgJIdOoS+hmQ+JUOFzhC6V2o/x/m0mLCGk
	CsoCEvywtl5LX1d/TWURhOwyr1UuD5Owv1bf8Gun1/oEZGonZ+4wAtKtswhePXHy
	nQW7WH92ZvapxBd4K+q1Hh8rzd7MkOwXsehdlEjaVVoSP6gObdg67f0K9fLF02Sn
	GBgFuVqQ1hVjM26ND3LKLnjpyCMzx4AGC6+28T2hlqherpRhb+eDuzB5nhMyjuUt
	lYWGz5Wrs/5k5iZRMeFiXQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej8j73s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 14:07:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJChd8k007231;
	Wed, 19 Nov 2025 14:07:55 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011036.outbound.protection.outlook.com [40.93.194.36])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyamq9p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 14:07:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKXkLUqgPAxxqvqHcBtiuQ3hOX+Rma5EAtMZs4cr4I7PNFiq9ugjByDDKPAb4D1KaDZsaHRhrGlz68LvhemmazdIhQfVCOfSgYLyAcfWcPNklyPtz2X8/R7zOpwk2HAYVt6nKONXbuV4u+LXDwg8prZHzitJhX6V4htTJCpiRzAUYj23M7iQhudL/7tZnhtfyWATfsIl8TmrBQB4+GbgnWlI2Ys6Kat4qpFLBV02PiE+EX/x7UUYGJIesXO2dqZFLAc7PJ/DAKvIa8gk4LszqgYyHHpiYa8amdV4qcszUheIzRcdzAOGqVNJiyqCcreXFx8CltDhtjZc3Qhdzk6YIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0TPQgJK3YsXoFmv2ABiZZdamrWexvur9zn6glIUlG0=;
 b=BLGRMALw5OBJIe3Zm+LwNRlfiLHqc+lhp+m3WGvSMy4my3VGnQ0PlWZTKQUnHoQk/wxhnTuiqPm5jr5SRmoyzVeWd7zFKq9bRpe54qO8EdQR8uN7GBr+Bbs4WAUCb8wgWds/hXp/BmYhWhbgtsGgfCgN9DBtY8JncxlusjneKyyJ35RVSvQ6Wwj3Mw6Ud5j/2Da9j6fmbDD5zOLdd+fj+BF6VhR23toe4lbM+DwnpD47lDqbhj+YM1My/R6UwynL1U+MlVfD+CGhXJ7AEJTnt3o0XOAV9JbRfRszhW6p0VVjKAwKE1xmxxbQkmFd8SjEn9vhNDFbVbyLOdZHI2Zl7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0TPQgJK3YsXoFmv2ABiZZdamrWexvur9zn6glIUlG0=;
 b=DguDrzCjHhwY1ApAwzQjZWic+n7DDfjro6oyH84QbH6wJ16h3N1y0TYuqLqwGTGDzz2DFQ0gF2vzwHyQPMrQQ71eVZR8aozij5JH+5Mlnzvtna7cot1tLh9T3oD5cr1kyxuKiqYHTnSo3BmYr4NVUTGpt7TRMlk0q+iGhq6CYhU=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SJ5PPF2BE4E177D.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::798) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 14:07:52 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 14:07:51 +0000
Message-ID: <dff2924b-745e-45eb-bff6-f0c6798a61cf@oracle.com>
Date: Wed, 19 Nov 2025 19:37:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [v2, net-next 10/12] bng_en: Add initial support for
 ethtool stats display
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
        vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
        Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
References: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
 <20251114195312.22863-11-bhargava.marreddy@broadcom.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20251114195312.22863-11-bhargava.marreddy@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::14) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SJ5PPF2BE4E177D:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa32c47-61ac-4bf7-8eb8-08de277506c9
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dmpZZEJWVHN4UVJFdjdTVGZiakpOMW5mektoVS8wWEpkR1Q1cG8rZDYxNUE5?=
 =?utf-8?B?UCtBWjBGYWJrR1EzMEVOaU1ZRlNBbjdqcE5TbWZYWEtzcEdkSG13RXBSL2lm?=
 =?utf-8?B?cjRKYkVHZXBaRUlXZzVuTE5XMUkrL280NGxFU2dzd2QrWUJCejVIa2YwN2FI?=
 =?utf-8?B?QkxabWQweWgzZWpGRDBlS0Rlc0VEcE1MeU5TbUxEeUl6QnJiWkFlRUJZdnVj?=
 =?utf-8?B?MGNDVkVFU1dQUE5DNXUzV2N5S1JzM0M4L0VvQnFXbGdaNE9ZTDVuVzl5aGc0?=
 =?utf-8?B?YnVvRXBSRmMxV2hub1cvcHFCVlVlek5kbndqQkZIRkJoV3BnRmcraURMTGpB?=
 =?utf-8?B?Rzl6d2Jmc3pNMXlWeW94bWpTZVJEeVRXZEFMa0c4ZzVQdUlwSEpsVjhJbldW?=
 =?utf-8?B?aFBNUkxVeDNjRjZDcHZGUmJLazltcXZWM3dTanVqakRXKzRyaEF0c3RwN2pa?=
 =?utf-8?B?eDYxZnlEMUdTNy9QUXhPbHB4YngrMUdjV0xjV3ZHZjZlL0JKcnFGZk81alhJ?=
 =?utf-8?B?RXRqNG5zMm9yUWFGaVlSVldGNUdGay9iTnBUc3loZEVna1BPOUFoSnJwL0l6?=
 =?utf-8?B?MlI5OEVNTE1sT25uQ1BGamRKODFmNlFQeVMvMG84d21URjVGN28zeFBLcXZk?=
 =?utf-8?B?ZnlWVFNYcEZpVk5BV2Jhb2FOdHN0Q0srUnFHbDlDYnhUUVhXVUw3eWovajRs?=
 =?utf-8?B?QVE0NURGdmZncnp3RXdwa3dQRmliT2JGcFlPKzdGeURpMndWQkhRZWx5aDVZ?=
 =?utf-8?B?NDZkdlU2SW81Z0pzeDZtdmYrZU9Yc2d4WWo2d3JDNy9UczBMK1ByR3ZYVjQw?=
 =?utf-8?B?RncwQU8wcWtKL1Z6QUlWSEQ1QTV3WS95d0plY0ZRRm1xNkRHTjF1SXNvWjl5?=
 =?utf-8?B?UUNCdWwwb0VxYXFBVEIrbTUvQjdJeGxxczZ2dE95Uk1sNzY2ZU1wK3BzT2xo?=
 =?utf-8?B?STNMS1oxemZPaUNjdEl4dEV3VXV1ZGwxSVloUGVIdy9KaGoyWVZqL2lGd0Y5?=
 =?utf-8?B?b3ZNaTgrYW9jUjVlbFBwS20xNFhpRjJxMk1kUmFsaXpQamtrY3J3S09wU2Nx?=
 =?utf-8?B?NG4vZUZTSFJIUUtzZzBkQlExSFlmaERIeVlaQlRTZC9oalJ5Y3BYellxVGY1?=
 =?utf-8?B?M2haSWR2V05tUDNGano0K0M1UVE3cE13NGsxaFhkMUx1MXRFVis3LzBFUldE?=
 =?utf-8?B?R1VZWkdmOGliWVVHVlVCNDdLdHAxM1N3cFhlYk5EbzYrbUtQT0dyRS9yRFBU?=
 =?utf-8?B?d3M2aGt2cElXYWJia3NrKzBsbkdkb1dKV2dPK3hKOFovYWV1dmN5VnhHNkFa?=
 =?utf-8?B?TGk0blp5bmExYmxWRVg1NG1BdzhMc2VwU2xHdG5KT3pIVXpOU0NEbHJ1WGxQ?=
 =?utf-8?B?RGZmZ0pvYjloZVdYUkozUUNmaE5JMTN1VGQvZEpVSjF1M2VvZkU3aEJ6em5I?=
 =?utf-8?B?T0JVN3h4YVJLd2N2ay9CV0tveW5YaWU0SVprMWNhM09jS0hsbWFuOUNoZVVW?=
 =?utf-8?B?UnlwOE05b08zMDRpQkI3QkVqcjd2aHdPRUZQaE90RGVOaG9Xc0VwZit3SWpG?=
 =?utf-8?B?VElIOUQ5M25FeU41dFhHdjU0QlE0cXZjL2p6OTdRZVhaMC9OSmZNL1M1RTdB?=
 =?utf-8?B?NWFyWGFoYWp1SUhRY0lIc0xrSVJJRmZyT0M0Zm8rd1ppbDlsQzFLQ3o2ZlAw?=
 =?utf-8?B?bndxN2Z5czV1dnZ2bHlKSXdtcy9ZYW0wMWhlZStKOGd3eUhWRDJSY0dBNW90?=
 =?utf-8?B?Tm4rWHpKTnQ4eGNZUGVCdWJSQkl2bE1rYlcwUmZvLzEvazdHRFRielBtZjZW?=
 =?utf-8?B?S0ZYUEg1ekVoaVlhNFhPMkNzc0tTcWpOSlMrbUZvT0EzVndoN08rRzBSbnZH?=
 =?utf-8?B?STZBQTl2OEEzcUFqM2hsTzRPdHJnQ2Y1SHRCQkl5b2pMZURlRUpXMjdEQTRS?=
 =?utf-8?Q?KLugJzCNhdgZS+6z5fZ/hqulsQBjTywN?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?R1BrODJnZkUzbDRLSURBRU5Cdkk4ZmdEc1RWVUMrZTltZTFYejlRaWluUEhh?=
 =?utf-8?B?RCtINWtBTElYbzd6dHZiSWpXYTV0cVNwVktaS3dqc3BjSE9KK2RTQkNKdXpu?=
 =?utf-8?B?LzFMbktqa1hjMFJFaDZqdUdyOHUzUHB4Z0JPdkkyMFFWYVN4YzVpeHVBTXVH?=
 =?utf-8?B?NUlEbkNTUnZBNGU0RDZIWVg1YmZweGtjTnJMUERXTGRjY3N3TlVKeXhRNW81?=
 =?utf-8?B?TDlkaTBLbGtpaXhOQ0hNdjZGTU8wQXQvU2tQNmw2SFBjL0twZi9XNGJzNUtr?=
 =?utf-8?B?a2F3ODdxWG1iMERhV1pNcTY0dWNBbU9ENUZMcW1NNzk4SmQ1N0FnQm45S2NL?=
 =?utf-8?B?UWVxS0Q4UncwUGhvbTNNQnorL0lEKzB1Q2dQTDJaa0NwNUFKS1JNQjduTlFE?=
 =?utf-8?B?SENiSHJMWm1ad1R2bXJlQXpUNTBwcW1SaTBDWlV3MEV1WnlpNmxWWCtCSWtx?=
 =?utf-8?B?bGRvcWd2dzN2TTlnZzEwQXkySmNTVnU5bVZFdWFjK1BMYmNMSXNYTTFYRGtW?=
 =?utf-8?B?S1R1cGxhdGhmTFhIQVNhQ1dQSVNOK1ErTUY5NWFaMWZieGJqT1h5T3VVQm1E?=
 =?utf-8?B?bHRiZEQ5UXZ4U09MeTV2QmNOVWVOOHoxNFg3bHVFd25lOUE4YnFCT0xXbTMw?=
 =?utf-8?B?MkV4OEdGa1EzbUdONlAyWFBjeUdRR0lxc05NdmNhU1ZIWUJuZndzVDVEMWVv?=
 =?utf-8?B?RE9OSWR5eU0zcDlPOTltSThrclVBbkFVMHFOTmI5V3JjdGREMTAyTHEzTWdv?=
 =?utf-8?B?WWpycG4wVFZnMUIxUnk3bUptZVJZcXZRbFpxSlp4WmFIWG43V3AxRTVzTTZV?=
 =?utf-8?B?RmRldDNxbllCMmJ0dkVPRnpWTG4yOE01Rzdwb2hjNDFLSXI2Q3NCU3dJZFRq?=
 =?utf-8?B?L3RzaTF3REwxelU3amVWWnE2KytkVFMrOU0xaXovR24rZ1MvQXJSdUFLMGtN?=
 =?utf-8?B?Y1ZrN2k0aHdWRVJRVVBhck9TazZWOXZ4SWw0RnozbXFNNHVieEFsdjU2MDlk?=
 =?utf-8?B?WDFsbHpnd21VL2RPemhKVVNZanJ2QXBkclp2T3Y0SzE1b2FkWFp2UGkwSlI4?=
 =?utf-8?B?T1B6S25Hbmx1WVJFWUpvZFd2Y0M4VzRpK2hJNU9TZ3B3dVQ3Z0p4Njd6Rzd1?=
 =?utf-8?B?bzVtdk15ajlobWdqZTBaSHA2QkppZUZGRzF6by9tY1NVV0RkM1QxSEwyd0RF?=
 =?utf-8?B?UDFub21Id3BwVGRKQUJkNzd5Q0lrTFpna1JSd3B0QURjRzVCVzhGc0JlSDN6?=
 =?utf-8?B?SmhKcnpNOVRMcDNaMlFIR09Mb29WYTZZTDJUY0R1NXp0RmgrbmtoQkh0bDBL?=
 =?utf-8?B?S3BvQ1FVUWpYbjI1aEFHY1BQb3UyTy8xSFVzaW1BU0p3d0dUODhtb3hZTEE3?=
 =?utf-8?B?RVptODAxa000VFNvL3lzbEVhYjkyc1p3eUFkZ3dKbFFKQUU1TXY0K1h5VDJk?=
 =?utf-8?B?OUVqSFFaNlVyc1RuVXMxcEsxeDRQVzVMeU9HNE4xazdybVdZZ1F1M2hmakpq?=
 =?utf-8?B?RnJkMUFqMVBQMXorQlkxRVk0bm03RG14d3cxZXBwVWhxQ0tjZXNnV2dPR25s?=
 =?utf-8?B?QkE3NytRQTIrT3YvWFlWcHVGK0tPK2VBQzBUUm5xL2M5SVArTGlNRUJENkxS?=
 =?utf-8?B?RWg0ODlHRWx0MCtuVHp4endqVzRwSjJ2U2xsZHdiVndPNWVzSWlwT0hsNE1L?=
 =?utf-8?B?b2ZVcXh4cllLQllIQjhxdG5yS1ZpVlVqSmI3VmNKOHRId00wcXlreHorKzM5?=
 =?utf-8?B?Q3ptSnI2U1RSOHludzhzdFQxQ2V5dDJ6Njk3RXFKWXZ2REhqVDNIaU1IK05K?=
 =?utf-8?B?RTcydmIzMVN2R2lEWVlONSttVzRzd0ttQjVoYTZUVzBHMDMwdGVIdS9pdUJa?=
 =?utf-8?B?MDRMcFJ1OWQwUmJFYUphWXlLaW55cTZNMUpRekMyTFF1aHphVS9CaUx0MGlq?=
 =?utf-8?B?WVBhRzlnQ2pTM0J5eXRRb21ML3JDK240NGNaUzZDY0hJb3orT2N3azVuQ1R2?=
 =?utf-8?B?YUoxb3pvQ3B4TDlNelJWYUxYTTVjbU9nYyswUVAwMHVmVHg2ZjY2bG9wUnds?=
 =?utf-8?B?L3F3Rm5qMytMSExVeHZaU3RIa1dMYWZTc1FyTkcvWFJSTHZvNURmQlMwSXpj?=
 =?utf-8?B?cXVKaE5MRXF1L3FWSEhudWtMekt5cmFLclZ5d2t2TWt4SmphR2o4YVpDNlVJ?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E2vDRNuNRZf57+17mOw3K77F0GtKQydyjKjWbm0jUlKsIaG6Ht1J3YTYLujDGc9mN0x87bRkwS5jrtRUywEM0jASiE1dMaLqX3WBcW0eO762oJPka4IqkkUzUEAT3ldzwHycj7JnFLywdEwP/JX3LRBzzdSFIex3vaEC8awKbYLrFzlx3zciI1kX1cAALJHsSpcIkvM7EeabYW7QLJKdgFQLiCJ2DB3VJYVcoTZf7ZsUmMn6+OWovViA9Rd1UipTGCJk8ILs6pwHCwJaqwbchacFREq0bt2JSnhf7RUh1+5BrFm0S5K5Q+Z4hHkBrjVcd992e50MkbDXFzqkbeUSq4F8Uezc/R3rWWGhPAl9dQDsqvEWkpnPFhAzjFZ+6mAf/MYqrc6TCqCIgfhXqlDjTa3CDMPwtangoACeobwqPd9zJCcQJ8bxiMssnPLu4TEzM8zZNN1WekddUsKk4Ch1i5z85IYcnCzBL9COwlJU9ykHA8KEvfYuK1UtJEDPEREqdMfHGE3sF934RaaVk3mMVZBnnUVtzEO6+tYwjOWXjgorUPSlanGodqwSPdBhoIO7seHmGaUWfyg9bZ8GBgLnuM4jw+mLAAz3wNzo11rblWU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa32c47-61ac-4bf7-8eb8-08de277506c9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 14:07:51.4082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aou9zzpr7vtFzQd2lFdQTlpTSAVW5syH41BqdAro3koeOYFEUGpwL5mGWLdq2bRtaPLi3g5pjCw2ogz8eAmI8zH76bNhkbUBL6NORSEgkhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2BE4E177D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190112
X-Proofpoint-ORIG-GUID: LtznUAuKvcTycH-hFxCEs-emWhYL-dcU
X-Proofpoint-GUID: LtznUAuKvcTycH-hFxCEs-emWhYL-dcU
X-Authority-Analysis: v=2.4 cv=I7xohdgg c=1 sm=1 tr=0 ts=691dcf3c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=LOVCZO0e0k3lTha6_gcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX/bYHtMu7GEND
 Gutft4n6epnbeN9IV6MM2C4ZucsaGLjSr4x/dSeYmWVSkXdVe8si1vl8VxZMOpLp/ZuSnLAuWYG
 tMwEfYc/MT0kVoHuS1pBuZEOUW7Yib8Pl0Xr7ILKdwdubnC5x0jHvdTwWdGeepHtwZGIcDqdWyl
 yx8rYdLR/7CHT8sWvi6U2Eqdkox8eQ+1ddN7/hNLQ78djEwXXz/DgVBwudiwkE+n4AbsbK2VmY8
 S10fL3Evy8H6M5zkcOwWEoE7HvzpCZef67thM50CMwGjlo2YPwdwjx2mXlRayPLd7vILWSZ2mGE
 6ZbLMZF/fmIu3ABNqfxgIcUpZM514jj6S/YU2jCgbck56rvMoFoitEkrpSXGVme6hHk91ZGRtgT
 bvIiyyhI+dDHQ3O/tKwBRD9eA7Lv9g==

> +static const struct {
> +	long base_off;
> +	char string[ETH_GSTRING_LEN];
> +} bnge_tx_pkts_pri_arr[] = {
> +	BNGE_TX_STATS_PRI_ENTRIES(tx_packets),
> +};
> +
> +static const struct {
> +	long offset;
> +	char string[ETH_GSTRING_LEN];
> +} bnge_port_stats_arr[] = {
> +	BNGE_RX_STATS_ENTRY(rx_64b_frames),
> +	BNGE_RX_STATS_ENTRY(rx_65b_127b_frames),
> +	BNGE_RX_STATS_ENTRY(rx_128b_255b_frames),
> +	BNGE_RX_STATS_ENTRY(rx_256b_511b_frames),
> +	BNGE_RX_STATS_ENTRY(rx_512b_1023b_frames),
> +	BNGE_RX_STATS_ENTRY(rx_1024b_1518b_frames),
> +	BNGE_RX_STATS_ENTRY(rx_good_vlan_frames),
> +	BNGE_RX_STATS_ENTRY(rx_1519b_2047b_frames),
> +	BNGE_RX_STATS_ENTRY(rx_2048b_4095b_frames),
> +	BNGE_RX_STATS_ENTRY(rx_4096b_9216b_frames),
> +	BNGE_RX_STATS_ENTRY(rx_9217b_16383b_frames),
> +	BNGE_RX_STATS_ENTRY(rx_total_frames),
> +	BNGE_RX_STATS_ENTRY(rx_ucast_frames),
> +	BNGE_RX_STATS_ENTRY(rx_mcast_frames),
> +	BNGE_RX_STATS_ENTRY(rx_bcast_frames),
> +	BNGE_RX_STATS_ENTRY(rx_fcs_err_frames),
> +	BNGE_RX_STATS_ENTRY(rx_ctrl_frames),
> +	BNGE_RX_STATS_ENTRY(rx_pause_frames),
> +	BNGE_RX_STATS_ENTRY(rx_pfc_frames),
> +	BNGE_RX_STATS_ENTRY(rx_align_err_frames),
> +	BNGE_RX_STATS_ENTRY(rx_ovrsz_frames),
> +	BNGE_RX_STATS_ENTRY(rx_jbr_frames),
> +	BNGE_RX_STATS_ENTRY(rx_mtu_err_frames),
> +	BNGE_RX_STATS_ENTRY(rx_tagged_frames),
> +	BNGE_RX_STATS_ENTRY(rx_double_tagged_frames),
> +	BNGE_RX_STATS_ENTRY(rx_good_frames),
> +	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri0),
> +	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri1),
> +	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri2),
> +	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri3),
> +	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri4),
> +	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri5),
> +	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri6),
> +	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri7),
> +	BNGE_RX_STATS_ENTRY(rx_undrsz_frames),
> +	BNGE_RX_STATS_ENTRY(rx_eee_lpi_events),
> +	BNGE_RX_STATS_ENTRY(rx_eee_lpi_duration),
> +	BNGE_RX_STATS_ENTRY(rx_bytes),
> +	BNGE_RX_STATS_ENTRY(rx_runt_bytes),
> +	BNGE_RX_STATS_ENTRY(rx_runt_frames),
> +	BNGE_RX_STATS_ENTRY(rx_stat_discard),
> +	BNGE_RX_STATS_ENTRY(rx_stat_err),
> +
> +	BNGE_TX_STATS_ENTRY(tx_64b_frames),
> +	BNGE_TX_STATS_ENTRY(tx_65b_127b_frames),
> +	BNGE_TX_STATS_ENTRY(tx_128b_255b_frames),
> +	BNGE_TX_STATS_ENTRY(tx_256b_511b_frames),
> +	BNGE_TX_STATS_ENTRY(tx_512b_1023b_frames),
> +	BNGE_TX_STATS_ENTRY(tx_1024b_1518b_frames),
> +	BNGE_TX_STATS_ENTRY(tx_good_vlan_frames),
> +	BNGE_TX_STATS_ENTRY(tx_1519b_2047b_frames),
> +	BNGE_TX_STATS_ENTRY(tx_2048b_4095b_frames),
> +	BNGE_TX_STATS_ENTRY(tx_4096b_9216b_frames),
> +	BNGE_TX_STATS_ENTRY(tx_9217b_16383b_frames),
> +	BNGE_TX_STATS_ENTRY(tx_good_frames),
> +	BNGE_TX_STATS_ENTRY(tx_total_frames),
> +	BNGE_TX_STATS_ENTRY(tx_ucast_frames),
> +	BNGE_TX_STATS_ENTRY(tx_mcast_frames),
> +	BNGE_TX_STATS_ENTRY(tx_bcast_frames),
> +	BNGE_TX_STATS_ENTRY(tx_pause_frames),
> +	BNGE_TX_STATS_ENTRY(tx_pfc_frames),
> +	BNGE_TX_STATS_ENTRY(tx_jabber_frames),
> +	BNGE_TX_STATS_ENTRY(tx_fcs_err_frames),
> +	BNGE_TX_STATS_ENTRY(tx_err),
> +	BNGE_TX_STATS_ENTRY(tx_fifo_underruns),
> +	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri0),
> +	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri1),
> +	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri2),
> +	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri3),
> +	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri4),
> +	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri5),
> +	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri6),
> +	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri7),
> +	BNGE_TX_STATS_ENTRY(tx_eee_lpi_events),
> +	BNGE_TX_STATS_ENTRY(tx_eee_lpi_duration),
> +	BNGE_TX_STATS_ENTRY(tx_total_collisions),
> +	BNGE_TX_STATS_ENTRY(tx_bytes),
> +	BNGE_TX_STATS_ENTRY(tx_xthol_frames),
> +	BNGE_TX_STATS_ENTRY(tx_stat_discard),
> +	BNGE_TX_STATS_ENTRY(tx_stat_error),

RX uses rx_stat_err. Consider using consistent err/error
same for rx_jbr_frames and tx_jabber_frames

> +};
> +
> +static const struct {
> +	long offset;
> +	char string[ETH_GSTRING_LEN];
> +} bnge_port_stats_ext_arr[] = {
> +	BNGE_RX_STATS_EXT_ENTRY(link_down_events),
> +	BNGE_RX_STATS_EXT_ENTRY(continuous_pause_events),
> +	BNGE_RX_STATS_EXT_ENTRY(resume_pause_events),
> +	BNGE_RX_STATS_EXT_ENTRY(continuous_roce_pause_events),
> +	BNGE_RX_STATS_EXT_ENTRY(resume_roce_pause_events),
> +	BNGE_RX_STATS_EXT_COS_ENTRIES,
> +	BNGE_RX_STATS_EXT_PFC_ENTRIES,
> +	BNGE_RX_STATS_EXT_ENTRY(rx_bits),
> +	BNGE_RX_STATS_EXT_ENTRY(rx_buffer_passed_threshold),
> +	BNGE_RX_STATS_EXT_ENTRY(rx_pcs_symbol_err),
> +	BNGE_RX_STATS_EXT_ENTRY(rx_corrected_bits),
> +	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRIES,
> +	BNGE_RX_STATS_EXT_ENTRY(rx_fec_corrected_blocks),
> +	BNGE_RX_STATS_EXT_ENTRY(rx_fec_uncorrectable_blocks),
> +	BNGE_RX_STATS_EXT_ENTRY(rx_filter_miss),
> +};
> +
Thanks,
Alok

