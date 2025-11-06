Return-Path: <netdev+bounces-236399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 311BFC3BCF1
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 15:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 62AF6351474
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 14:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44E93431FA;
	Thu,  6 Nov 2025 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c8Ivqa0g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ImHvSiTw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2456534320B;
	Thu,  6 Nov 2025 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439965; cv=fail; b=jtjjvX2Ao0xciU0rczjWrkRFNgIL4A4UPzbsi69o92QBSRLXPBwbYqX8CvytXHpYCfSijDFzkb+KaezfPpw+eQTvGtWCXw8TuE4l3NmlkdIPeE2izpysOAimSfLQl7LCu+D8Z5jEGX8Eugjnm75IYE3Ddj40PP2zyQ0p70/qe+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439965; c=relaxed/simple;
	bh=cEm+pNubkxTDW6cRXURO4mV570Lx0zmo0X+EEiRJCxs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Whkpiqe03+qzRopNHLoY4vCKdC+bZ/+mPq5QtlmQ4CmMy0Xo2t3/d8sLQ5B3vM+4RIt2FiyIPtyACPbvX7obSmbOs17yjqgacIlxZZgLeLAFhvcwT9ooSUgWGk1K9IT3HbaAHF6nv7S6vnRYhQHzBYcCNc5PhWAl/BscrkQHGJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c8Ivqa0g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ImHvSiTw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6BG5c7017857;
	Thu, 6 Nov 2025 14:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LL1ykUMbC3gVvRVEZ+NeYPy/h65yh8hdJ2m/O7+Abv8=; b=
	c8Ivqa0gpqAL6vmVNiOxnnNOSYMvtF++Huf+vuwqrZW/kJvh6p7TZEK3xWIksYwB
	Mab5GlRxXh9ChhkPiIvN9t2ic/btzL8z0iMVnu8ifXipzONWFZwu5Is+dCAmBOrf
	g0MWA3oY7ygo474QCO+LOJjKAOHz8HmpZbdnZKqz/HRKbBU0VuTVlUdlUDVdmIxo
	7lxh6ZXzaadGdxFKGy55u0p2QVuyUi0bC2l2e7svNouWohvXviY+uPh/khKgNZn9
	TJFCB0V/kcbSrt1lickI50y9dc25e10hnayQd31fkPu3Xzl5BIyIfndHsoMQqqxG
	jdI+MXirr3Gmx6RSKvx7Sw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8aejt70j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 14:33:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6EQuNd010946;
	Thu, 6 Nov 2025 14:33:34 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ncftxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 14:33:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ET2/KZd4UvJCZ97bPc/DBfUfZwXdIYiywH+IsC+O7kbzrC8wKte7+hFBqYU4vqN2/eIwGoAJgRko8aoptbrgeCKKC05m3XVm4yY+GjE17Wdie1fW65pIwjZ7MtWykoE/nhVDEigha5y3OgVU5yKnPyOR108YAp45Jv+/W9ycQgTPCQis518cnK9Kq93W4aSD2uXq6aMXm9MiTywfLajrWY0AwvUvI3nsSWG85ni1kjE3aMo/kdGZ64YMqaCLoAq78rU7mdmmup1y1Kl10JWLflAQZcc5pUsIZ+gmdxPq7t/5QvjweB9fQxbf/YCzjloT5xVdQbzoIhufnMB/5e3sQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LL1ykUMbC3gVvRVEZ+NeYPy/h65yh8hdJ2m/O7+Abv8=;
 b=NupVNRUpF8b7KrUQ6ZKfVJilZpLPNJpDGArbTwazvP79Pn1zcXdcMC/c/mdh6OQvOPALMchQmMGMk7K9IpebF7CiJyh8ar7FO6GrmhG/e4GcfeSDbgfHxPYdSc0A9YODuW8bvJGGmaU6ALryr3LagDa7Y29HqnEvE/6BOqWX9Pt2xzGlsqruXaiOqbq45GY84iS5Ga4kY2PeZSmP5AwTCJSrVBi7OjV73X5+iSiIGdBybX3PFT1hA8lbe4Fj8236JjG6DPyWgwmB8DTs5GAy/6y4pFxJYlXqXtgMZ78j9r8gt99aVpIpxxUpZdTV6Civ8ChcKUs8hDvIyAO84IdZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LL1ykUMbC3gVvRVEZ+NeYPy/h65yh8hdJ2m/O7+Abv8=;
 b=ImHvSiTw6M0cRqLD+clKHiOTaW1t3YJJ5FdDVGyCIFr5F5lo+N9hIVzzobRBITizIiJ0xkWEBMl9kRroHdDTAJ/xDHexkGH2iCJuTfzJZa9RvqDWt8lYT5J/fheNqb8Ic80BmCTuWuLLYJQ++e6ZE9y+OuSniSBGo4nBMMWvxT4=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS4PPF415C917DC.namprd10.prod.outlook.com (2603:10b6:f:fc00::d19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 14:33:32 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9253.017; Thu, 6 Nov 2025
 14:33:31 +0000
Message-ID: <0cabe15f-9056-409b-bcfb-3c2e9a6dab72@oracle.com>
Date: Thu, 6 Nov 2025 20:03:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH net-next v05 2/5] hinic3: Add PF management
 interfaces
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Markus.Elfring@web.de,
        pavan.chebbi@broadcom.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
        Shen Chenyang <shenchenyang1@hisilicon.com>,
        Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
        Shi Jing <shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>,
        Meny Yossefi <meny.yossefi@huawei.com>,
        Gur Stavi <gur.stavi@huawei.com>
References: <cover.1762414088.git.zhuyikai1@h-partners.com>
 <9adc3fa959ea51ddf1eff7eec641801b541f24df.1762414088.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <9adc3fa959ea51ddf1eff7eec641801b541f24df.1762414088.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0091.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::6) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS4PPF415C917DC:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad7048c-69da-4719-d3fa-08de1d41758c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REQrRUZ6STZjSmlZS01KOWlYWVFpM3FDc3VMVDJpQUI1MjJHSEk0dXBkTkZO?=
 =?utf-8?B?RWIxclV2STArK2o2TFE3YlI1eElIZ3FveXZzRjBKWUFTdUwzYVZwMHg0YS92?=
 =?utf-8?B?T0RYbHNGWFI5MkFHdGtISEcxYjVUVDIxUmkrbU1tV2ZrMFU2VnMxSzMxRHow?=
 =?utf-8?B?UFdMTEtRUi9FTHVEZVBTakR3am1CVVU2QW1JZlYxaVVhNGQ4WnROMjg0VUhX?=
 =?utf-8?B?UzA2SmkrVFdIaWtaaE5xa0RPQmNKTkNzYWZHcER4c0NjZVR6SDNzdzloc011?=
 =?utf-8?B?T2xVYkhLc1RDWUpMcjV0V2QzRHVtTWZ0Sk5IaUF1cURjNGRKb2M5Z3FQZDZn?=
 =?utf-8?B?cHQwWkViZEREeEt0NGt2emozNDJzNEZWSGwrQTVzUVZTMDh1OUpjTUUyK09Q?=
 =?utf-8?B?cnl6VTRINmxhMjFOK0ZyV3Z1S2hMUXg4MmVPZjc1Z0F1a0k1cWJQd05PdTh2?=
 =?utf-8?B?eFF3bTZKTjRvQzJ3NWkyaFdLWnJIRWV6QXNtQ0dhclZsbE1nTXJiSkxsQnZp?=
 =?utf-8?B?R2pLZTNLWVNUdTFvYk1RUDdlZHN1WmpGTDIrd2Q0bE5uajBKRWlxeTFwMnFr?=
 =?utf-8?B?QWVZKzVCdjY2WHlJL1pVcVI2OXAzN0UyMXBLa0R5aHJmRy9PelVnRjlCa3J5?=
 =?utf-8?B?MHRFM2ZkMGVXUG1XSGVwcUJ3S0hCZjVpY0ltUHZuQ1l0SGo4RlZXUXd4a0hs?=
 =?utf-8?B?T2NtTktLTzc3SklEMmpZU0RXd1VsSkNwMFlVdVdqS3JGdGxrS1p4QVkxTC9z?=
 =?utf-8?B?ekFnQk44UWIxU2FlMjVEMzVYNlh1dmxoZ2luSEJyNDF5Rno2bkRuZUNCMVFl?=
 =?utf-8?B?cWZDU2VjSU95anZlY3M2ODdsZWMvcXllRlNOeXJFa0VvUHVpZ2w0Ynh3NHpQ?=
 =?utf-8?B?N2g1SVAvRi9TQ3RsVnhNamMyT0RQNEZTM3J2bzZ5SnpjY1N6QngrY3cvSVFH?=
 =?utf-8?B?NFNjRjFBWDJNcjI0anh4M1QxL1FGd251eDNIb3krUFdiNVVQR2taQ2NPNlli?=
 =?utf-8?B?eEFjcUcxcFZadHFnTHNlR3RneGl1ZHRqRGhKZ2o2ZEp0aGZkcFR0RGUvZ0Y3?=
 =?utf-8?B?c3djOXFLSHF3QnZUWnlyTUYycTJSc3JoOEZHL2tuY2RMMTF1dHdDNWhpSURW?=
 =?utf-8?B?VDB3U01ZNmpjK2JybHJLb0svWFUzQkd6UWV3SEx1K0E0dUhlOWZwbFpDN1FX?=
 =?utf-8?B?UW44YUk5dkc0Y2c0bWM4WUlBdVFidXNpS096Q1FkdjJyTkxITkZKN0JSNGJR?=
 =?utf-8?B?N1NMaWdiVWFMTm5Ob3RVNzNGcEVEaGduRHdWc1ZSdFhncVdZY0lVOFpSVjFr?=
 =?utf-8?B?VlFFMWZQSzU1MXN1bi93cWFZL2ZEK0FERERyaTNCV2NyVDFpdjcxNGtXVDJD?=
 =?utf-8?B?R2V3QVQ2QVRVa1JXdDhPb3QyTjhyNlljSm0zenV0K0cxS1I0U3NmMlhOa3Z0?=
 =?utf-8?B?SlAwWWZselFKbFh4Q1JZNzJNUFFwdFNBTWg0UTE4VkxBTlNyRS92Q2l4R2x2?=
 =?utf-8?B?OEsyN0QvTmc0VDV6ZkNaZ2M3M21pWUpxMlkwTk5kTEJna29iU24ycGMzNEZB?=
 =?utf-8?B?eWdsRGRyQ1ZKUitDYm5uWEZuUjQ4SE4rbnJmTmpXaVBYcUQ3VGZBbGlpZGRx?=
 =?utf-8?B?cDh6Z1c5ekdFS0FUZGxqMEYwNklEeU1UQmowdFUvVkZmVnV3OVI0WnRGRHJj?=
 =?utf-8?B?RDcvcU5XbDh5ZkpGSDM4VmV5K3JaV2FBaTJ5SkN1ajdlR2dyQ0NTaGRDOVRJ?=
 =?utf-8?B?QlZscFJJZ3Z6bk9HdkhSaGEwbm05dEdlYm5IUndjMDVSR2hLeXpKYURVNld5?=
 =?utf-8?B?QTdmSzF0Z21SN1pYbk9QQ0JpZElqOXhoczVBcnZoMllTUEhLMlpvK3hLcnVM?=
 =?utf-8?B?Qk1zb0k5VnVQU0RJdkxRZnlacjRIY3BaQmFML3B0eERLckZLaXJNNFArSzh6?=
 =?utf-8?B?RExFZEdiZHlQSllEb3hsdnF4ZWx6akYrR21LTS95WFd1bW9CemNxRytDNnV2?=
 =?utf-8?Q?nHvJnivOLsVobSjhVTkSy6Miu0CpNU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVFOTjJsTGpNb1JYNExKczEvUFB4M0lXWnBvQVFHQkRiOWNpN1V2VmZZN2to?=
 =?utf-8?B?VEM4V2QxYnNUTEFOSXlSZjRZemJuNzgrSHAwRURxcDlFZWV1eFZLcDhNWjZM?=
 =?utf-8?B?WURHYjM3aHdpOXBNK1NoY3U2elpKOWNBRFdVUzIwcDZuOEk1aWlKZDM2Q1Bo?=
 =?utf-8?B?MjBKdWd1S0k2Z20xc3V3RzlkaUVtb0JOMUV1Q3FQVEt2Zy9NS3BVV1FkRzhO?=
 =?utf-8?B?d2l3QlU5b0RsOTF3R3RGNnBiRHVQYWhiM3lCcFpCRGVCdjR1NU9uNEhTdGt2?=
 =?utf-8?B?UXkwR0ZjcXdwb1V3cmUxVExiTnRwWU5wTmd2OFBGYm5MV2RSNmZoOGxLL09x?=
 =?utf-8?B?UXFkL0ZiU2VyK0prMmpsNWUyQUJ1L241UkpwVTI4dEliYVVtMGR1VDRzTVhK?=
 =?utf-8?B?cXNmVU9vcTVTZVJhanlwek5CNytJMkxPcEF1UlZ6VUl4bE5mRzBzeU80eHdU?=
 =?utf-8?B?cHdabmpycmtjbzZzRWg3RmJTd0dkRjgrTDdVMUFUOG1hN3pxS2lQTHNYNG41?=
 =?utf-8?B?cTUwcW83NXdYRVZ0SHRhMnhaSDh0SjR1a3RPYVZoN3A1aDRTNkNHRklCUUZX?=
 =?utf-8?B?akpxUisyUTVMMDM2Q2wvemdzaGxyMlYvaUlwTC9wOVNxMWFPUDUzZ1p3RFVt?=
 =?utf-8?B?Z2Z5RnFMSHFlTjl0V2w4MlM4UWowemZxYVU2QXpJeG01MzZkcDNVRGticGhq?=
 =?utf-8?B?QmxtTUpPczYwQitWL1BDaGp2ZlduQTVGTUdFOFhwSW9uOTZ4b204WGlhOGRI?=
 =?utf-8?B?N0huaFphWjFFcWxtOXZPTVdMWXQwRmN6cUdSNytaYk9QTVB4UnBsODZCV29t?=
 =?utf-8?B?SXBRYjBUc1JrNnZhM2xvZmd0OFVTSURseE53c2UzMDZmUlZVYkwzcUVsWnQz?=
 =?utf-8?B?dFRDL1JpQnJRcFdUYVRacDVoWkczbXgyWG5PWER6aDl4SElpUFhNeUVnQVcy?=
 =?utf-8?B?emprU09hV0xKdEhJemdxaEpXU1RmQldzYnhIMHYxOHlyRmh0ZEI0c3grdE8w?=
 =?utf-8?B?ZFhnVDFCS1U3MDlZNEJKWHNjWHNwNkQwbzFUQ05JRnNrR2V5SmpWakczVFlT?=
 =?utf-8?B?K1Q5cllyVDJtLzBVN2VaeW8yZG1FSExGTithZ0dRcmwwbFpzeDNzQU9qdVMv?=
 =?utf-8?B?eXFtM1NiWTdkTkpza0dXMEFHZlF0T0plRERRUUR1d2V5ZXk3REFGMUJJL2xP?=
 =?utf-8?B?aDdIeVZ3by9oa0o4bVJEY0t1MGlLTGtUc05Rc2R2aFJWbUc0MkFtR2x5SUVa?=
 =?utf-8?B?d2oxOXAvQXBBRU5ueU5mYkNXcFU1dVhvQlg1R1MveWthUHBPVCs2Vm55Ry8v?=
 =?utf-8?B?M0drSWZRSU8rZ0JoanhLRG10OTdVclN6bVBZZmFHUzl1STcyejlGWXJZSG1G?=
 =?utf-8?B?QXJaQ3RmRnlieitYTEpZWWpRaG1BSS92N1Z6bmF3YUVHRVhFbUlQVHhKQ1lQ?=
 =?utf-8?B?aFB6bmdCTnNBQzJKa3EyNGFRaDRsRmJxemt6cDl5UkdxZkR5RVcyVFI1ZHFv?=
 =?utf-8?B?MForTVIwSDdWcFpndTQzck96QlNac2h1RVE5V0pmTzlXc040SERlcHJMM1E4?=
 =?utf-8?B?SVZDekk0c3BMa2lKMDNpVlJ2cER4T0ZuKzVuYkVvU3VtRE5wejlJb2l0bXE5?=
 =?utf-8?B?R2JzaW50enhHek1RUmtjZlNWQ3RWN0dtZ3E3UkhrVzJFQnl4N212YWdCSENY?=
 =?utf-8?B?aWkyQmU4MWlrMnhzeHI4Y2ZKTnZmelpYU0JlWlh2OXhLL2k1dysrSzFtOWUz?=
 =?utf-8?B?SUZKOXF6bGMvd3p1Z0pFZEVMWXBUWm1IREVQUWppblpUVGRoQmh0RGFkVUVU?=
 =?utf-8?B?RjV2dkJpaHBiS2tCamJPM0p4VE5qaWdoQVJ3cjVwbCtvQW9zbHlLN3preHVS?=
 =?utf-8?B?WkQ0MG85cEViRkI0S3V1aWt0WXEvamZkZk1QQ3V5YWJiUHkzT3cya24yeTRL?=
 =?utf-8?B?Z0JRMnZIbS82ek1Eeml5NU9vdVI2a01ldXlPYXc0cnltTitqNHM4MFcvWm91?=
 =?utf-8?B?eVFXWmxib3E5UmRjWVJyR2JqSDVzcVpwM2Q4NTVzOTBGV3I4RXM3TEF0L1VX?=
 =?utf-8?B?RXQ3a0RETU1ES0JtTzExQVc4UU9WM0RUVG8ybDNPR0JIVUdGMXVISUE1NHl2?=
 =?utf-8?B?bENNWVNoMmtEQVptbUQ3cnNmcEtyRjhXaTYrRlVNMC94cDFheXFrL0trNDg2?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wsaYFu9jvCO0v28I0L9i/tW2v1K1iDwd7BbL9mBnqqY510XUhAllXHphcB2KpQWxtwmVhCQF7UwienaqOjiGoUGLC4gSG+cmf6WRcr5qksCcgEzbVcGRww5r5oCcilkuO0Hzdt2CwIR83KG0hLs7r98HR6/d5DgTFEHzclwe4BuCoyKgLOloJbWOI0LIIX6EHxmmd4uN0fLWWtCtyEWk/oAtmbxky1JpleKHCPnVOBh11Ogd9sOAUW3bwWUClaVRxEm+/NAwaL3ZPhlZNmB6LuDDzXQvozX4kwnbPyo6RjwDLa4xSwcAfCLfJrTPFd0T5f0B1qDsEmSMNFZA6eCrdVhMcbkyQfedkvxiWbsAKz4LxCmdRwCasLfZVJ1OmY7NkuFwS8RJ1sj4Ix81/EyzAaeG9c+hvbwR5Pzy+IK8hQkIEQhJ3sB7vm051dmNJJgAqDtnI5wEpw2rL3uxFCeC/AIO5tAPKZ8TiXI0hTbtcuvS39lE97KW5nJfZltBFNEbe3OyOguzZ94QJ81TtuVfez0P+HY+/GfbMOVlGVosqySsTJV6dPrdFFpTlB29GMMcO1IMk4A1dXDF0YubMN1JrgEhqGTaqrmVtm/AarxiM2I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad7048c-69da-4719-d3fa-08de1d41758c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 14:33:31.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6DhvWXN3haKOMFnsGExtGuuDq8nudeSQowgBlelsLQnJf4n/OlGnYGBuHgzAmBI+ZU+AJDm+aexaW8SQ6IjVTXGNLpfdY7tR9Gr4qm9lw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF415C917DC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060115
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMCBTYWx0ZWRfXzFcv8Eh78B3S
 DSbNSsDuDcauCIp8U1aZfxLo3OMHHg7XrskqCceembH4MTimkxbwDMHKVsdtVJNCh5LXGXQQ9xi
 okoTwUhkPnMzw/HFiwgtj5NJ5N7cjbjGtKcBspB5AV8nxfZzy9xNhFpsSfUOB78ysdWtRh5qcW4
 aatDARRfaxT7wXfD9zpOitq3QR9DdQeqmpoVkNbHvg7SKhK1IbBjEErRZFNnXnlTVkPei/C84eY
 yRoO+jPJq0nsPDuuJ/+ugMdg9FF9KWaD4HCAHZFMecWT06wVxWaLtll4ns4sIulbz1dyIVrhp05
 UJDu7TP3c/W9RBrDHKBKcjPh4flQ6UwTx63H22EU9BmbIxRqQkRjvmm7/LdZ3CrCTMABBa6fkSt
 F4rFIslS5Tduc+n7u8XSXLPLg3pyjg==
X-Authority-Analysis: v=2.4 cv=R8IO2NRX c=1 sm=1 tr=0 ts=690cb1bf cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kH4N2UgdrgYKrGk0WpIA:9 a=QEXdDO2ut3YA:10 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: JBgJLx06ywe3QRbW2kSFxyZcUR5CVWRJ
X-Proofpoint-GUID: JBgJLx06ywe3QRbW2kSFxyZcUR5CVWRJ



On 11/6/2025 4:45 PM, Fan Gong wrote:
>   void hinic3_mgmt_msg_aeqe_handler(struct hinic3_hwdev *hwdev, u8 *header,
>   				  u8 size)
>   {
> +	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt;
> +	struct hinic3_recv_msg *recv_msg;
> +	__le64 msg_header;
> +	bool is_send_dir;
> +
>   	if (MBOX_MSG_HEADER_GET(*(__force __le64 *)header, SOURCE) ==
> -				MBOX_MSG_FROM_MBOX)
> +	    MBOX_MSG_FROM_MBOX){

space before {

>   		hinic3_mbox_func_aeqe_handler(hwdev, header, size);
> +
> +		return;
> +	}
> +

Thanks,
Alok

