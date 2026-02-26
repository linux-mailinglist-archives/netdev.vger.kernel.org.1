Return-Path: <netdev+bounces-261141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCZJKkCzn2kpdQQAu9opvQ
	(envelope-from <netdev+bounces-261141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:43:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F551A02EE
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3751D303B4D3
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA5637AA80;
	Thu, 26 Feb 2026 02:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cPxqvZCj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C594315D52;
	Thu, 26 Feb 2026 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073588; cv=fail; b=YktetjtwnXiANu2kCuJhD/wkh3S441RaBMHt+O8U5liLD5nbB5OV422O5bCXVMZq6TJgx0Dh3WtKxEJa4JBLMjjbuYlhP9oFl08Y/wlytI0wxzERBKdza7Xd4VqGmd0jsqCe6VHZwFH+kgILr7AkPulTD4yCWNrDKI/hbWUmvKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073588; c=relaxed/simple;
	bh=rEEuTp3SX5+tOyJB8kjXqGMf/yfl870GoKwwR8YiFIQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PndL+X2qRk5be7GVocgEn/yaROW8Ko7GEtH5qSXeq7MOPFNcOZ+VsLXeGyDC/VI/ZB4EOTkBKng0fvQaINEq0zOfvu2vDYPAiXR07knftgyuir5fhQrYeW1MGXWB+92l64DHxy644+4N8vU0bgO4E8mKj5+ZYsonxgLx+BQo//E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cPxqvZCj; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PN37CH3219219;
	Wed, 25 Feb 2026 18:39:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=RsKxwhwSHiMrh1c8VNvnOrnyQn7Wa9qdcfo4fqBvBNI=; b=cPxqvZCjNZUM
	TchGDczQIKEAtFNqozn+JSySDBr3avKyD573rG42zHzwtziWVWphIxUylO6iiXY/
	9zjk0pHeyRrqPQR3n0WJop/sHqhNYr3t7legEkGej1v3mzrsJ0XRr0m2PQBnu0jq
	soW4CQydFAr98oFOuvZt1Ku/ce1/QieADKqvSOw8QAt7TOb29z3+XSUbTRLJ7AP7
	RSzEk+knh3kwduMYDr7R177udhBXam9LquPR1nFMaNAx1tUKxKW9OsXcK4aZaAEX
	ijQEPhJKRAxL7gZBDqRQj3d3ArEzyuzQywWPHgVpNvXVgIBoeAbqKqWf6qwM4uLr
	6KShtEXKQg==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010014.outbound.protection.outlook.com [40.93.198.14])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cj5ps58tg-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 18:39:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFqrYnoWIVmnzdPHibWUyuIdMfAJy7/xYjwwdbGyKl5xaxeYHyAypCdro/qox8Ukb5UaRjHpKfJRKHjM3pYKZJ2bQVBr0y7lvDrJtuBy+8Q7OxjOE+3vmizlAbWUWl1n9rZ8GQAE41eiRmP+mLheKst7997m2gP/lvh9srqzPOUg7rSTaSRiLL5Ul7Fomou/1XL9sQaIJeBZN1SOPOXtjZdBpj8pJL3vaXMkakuKgVjua0lbKt0KVGnOJ0Kjuwp2MQ1nKF/DvrX4nc+3BaYj3ktJm5WyO25BNd8YaW0qi1why8I+eF3s+zYFUE+c3HDd+GGzR/am8+NoWzVYcYq/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsKxwhwSHiMrh1c8VNvnOrnyQn7Wa9qdcfo4fqBvBNI=;
 b=omUQ0jv4K1XN2JQqJkT3CHTZucDb8xJQDflnfAdx+GOSqQpwtV4++RAf35g7HCSnEDxC9asG77gPx9OunVa+NU36lje5SMqPa0ae+VDg9wuLxuVsdRcvyl/Hwk/Ms9n6PtBVifrJ8hgi1Ehi6UVMtK3b0xNxyv//CAHUKb8j4qYXdvYEGGu7Pq9rheu4R218RZXQrMw0Wl8bF7b+fUlNuW/t9vZZXazZJ4E6k1sQtWB/H48XrEqcQ1nsc8leZ/G3Xby4DzN0JQR8NJQQ5+EtX1aLHM1z0pbxuTH9VfSd8dVJobVOwvVNYbiYl+aASJz8xd+4c8kCxI2dg5gtgAdq9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB3893.namprd15.prod.outlook.com (2603:10b6:5:2b6::17)
 by IA1PR15MB5606.namprd15.prod.outlook.com (2603:10b6:208:429::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 02:39:28 +0000
Received: from DM6PR15MB3893.namprd15.prod.outlook.com
 ([fe80::12c7:cfea:e8a3:9667]) by DM6PR15MB3893.namprd15.prod.outlook.com
 ([fe80::12c7:cfea:e8a3:9667%4]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 02:39:28 +0000
Message-ID: <5d7e2f02-104d-43a1-895f-dc5fe5cc1865@meta.com>
Date: Thu, 26 Feb 2026 08:09:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 RESEND net-next] virtio_net: add page_pool support for
 buffer allocation
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
References: <20260225044910.1328791-1-vishs@meta.com>
 <20260225174239.7a8933e6@kernel.org>
Content-Language: en-US
From: Vishwanath Seshagiri <vishs@meta.com>
In-Reply-To: <20260225174239.7a8933e6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0082.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::27) To DM6PR15MB3893.namprd15.prod.outlook.com
 (2603:10b6:5:2b6::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB3893:EE_|IA1PR15MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff51395-530c-4615-0332-08de74e0434f
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 Jar+OHBK7HlgJ6PZy1VLUpfWwrfX8MqX5vaf/Ai7Tf6fVP7IHVUT4qWeYdjLxE8QRoadJiPeXgB/9A5EW6C4K1rEaVBgoDesaRVIXnVMPBPI1wVviCn6GyM8OLs0M9kZf/9nHSafP6Ogg8UGiAJeI8Y6cExehV/prGt2NgmWOIjBvNfKn4HLAeuzhg39+FkWJyeImgxnNOzKfoDO4DfrDWwuneDctpbktGFUoDKxdfpeGky05yS1soRC8BoLo7jCkzehDdovvGb3vcjll3ZkW0Xwno8YzxG2kddQuiVnqMjRUEdJvQ6E+VTdIb5lEXTGEAVP246kS8QK/x178VU96K/5TA/vLFtIQGzBDmhcwNbOZ2GWzUz+iyV+8zzFqAksQBTlGa28OgAz1OydlCIKWTFHPLh3c6xjr1sk9xP0DhGG0zH1mKJi8+E+6MQBbtsCm+5oRVIyJNgJf0CZ4AjBJCmlD7ZOqRfYvGHP2P1ihONmghbyEvYEVTQvi2ATnwc0LNyg1tt+yCMKHx6086e5pS5+Mx9GyMbOiKIhFh/KzW4zbizy4Wv5/PRInaUAtr6LFsLnjf9s8MZhKia60HAVeThVZkONSCskQmp7vczhGGVjoYoGjaYLrT83d83q/6rTV2Fq61EDNVMeoW0cbLD5gcCX97cF6pO5oQKtmfY70OJhr8vOgGySM1urU/jeUr9orzG+0P9nwOSUgmd1yvKdv95trRvAf/IeCks7BEGSFEQ=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB3893.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Q2pJdjRXenM2QTJsZVBSTTRiVW9FTm9mVDZiMFpldXFMMnlBTHJGd3lLKzBF?=
 =?utf-8?B?anpYYkk5Qi80SHdpVnlnMEVKZHYzaFJ0c3dLZkVVTHQvUWtGaEdpdTZmOXBW?=
 =?utf-8?B?TlpBdmhhYW80WDJ5ZVNQaHdLTFRRUWpNbWpNdXJ2Rm9IbVYvZzZuL2lJMDBv?=
 =?utf-8?B?N3JqTGpIY3VvaGQrYmgxYXpWTHFyRzNEYitadkthNTFSbkhodFlLT2hKY3dY?=
 =?utf-8?B?Q2dIVGhSZWNuaHRKK0RFcERtYzZhODRURjBxNnVXMVlwK3BjRFVYOHIrZWRY?=
 =?utf-8?B?RStNeU8yVVhjaE9JV1l5Z2FEZFVFdmJQWEZDbXlpa3NGS09iZ1VMYndmemJZ?=
 =?utf-8?B?K2hHQTVXODAvNUFIcGZhWXRTRjcxaGFyUVBEaFhITFVsMGdibHZqcHJTVHRn?=
 =?utf-8?B?T0NqZUFuTjdHcTNpUU40ZG5zMENmeW9scnJkajNzL01oRFhNVVlEVVpyQXlH?=
 =?utf-8?B?K1h5VXB5TGN2YW1xNlJGSU9IWDNPMzAxa0pZb21KQzRsbTVjV0NNdTBHUTc2?=
 =?utf-8?B?dGIwQmZTUXk2aEtaNkxJSjE0V1pMZTFQVW9CWTRTK2VuUmFtYUFKTU00Qy9I?=
 =?utf-8?B?S1liWEM5dHNzTEhWRFNLR1BDd3ZKT2NXd0J6aTFSWHBiUGFnYXpuWDYrV2lT?=
 =?utf-8?B?aHZ4VGVhcDJTbzV1dTdUam56dSs3UThBcG9SMitnT2J4cHRMN2RGVE1tb1Z3?=
 =?utf-8?B?VXZ4cjZUS00wRWppMTRqMHdGOWd6M0RibmFVVVJvajlDb21KNDdTOFFoamNH?=
 =?utf-8?B?S2UvWlVTMmIwNlIzQS9scUlkekMrSVY5MXQrNmttWThXRE1FNlNIRjhzeGVa?=
 =?utf-8?B?a2RMcGoybkY5V1pnZnVPMjQvWURoc1Y0cW5pSVBud1hEaThHaVA1MmhndnRB?=
 =?utf-8?B?S1NGNTNpV2FHSUJqWnl6MCtHN1VuRndlNDZNM1UrdmdjNG5WS2RPQktBOHRS?=
 =?utf-8?B?aDZSazk2RDZDbDZpeUNKVG9OaG5obDQwazVTVURUT2U0SEVpMTEvMUpnZDZW?=
 =?utf-8?B?Z3ZDTEVBb3ROaUg3RVMyWVhFL1hhWDN0UHFQcmZjNTNmaERqUnFhRE5kQnVH?=
 =?utf-8?B?emVpUkwwLzlyajl1ek1NMWc1MDlTdkRNWERrZEdGbWh5K0MxY1g2U3lNd2dC?=
 =?utf-8?B?d2tsaGNDYk0yenNQaEVRSG5JTzh5M3BCbGpvYWRvdlM1L2VDY053TEplNU1L?=
 =?utf-8?B?bEE0UG96b05XbGY0WDh2T2k2QTU0WXZzWTc1TmsxT25ENDh4YWxuSFJ4azJj?=
 =?utf-8?B?OHU0dmN2Rk80YjREdWhaSzVXVmZiSDZWYXdnNSt3S3BRNEtxdm9aSFFYNEhX?=
 =?utf-8?B?QWpqd29uR1kra3dKLzNtNEplT3ZISlRFWGN1VkVoU1AzR0NncURscWxWcnhX?=
 =?utf-8?B?Wjh4WElMTndqWXZKV0NwZ0ZqcG1hSTJOZlJOZmdaQ2wvUWtmUTZEVnEzOEhF?=
 =?utf-8?B?YXBwMTBSU2R0NllFamdWd0NzU1pCa2w0TGtDRVlMcVcyK21GbVpZMWd6RDQ4?=
 =?utf-8?B?S1REdmZxUjh6TFJYUnRzTlNVVkdZbXJodUFPeWV4ZnNtS2c0KzF4aFZqQnB3?=
 =?utf-8?B?NmJVMU9GS3J5ZUZPcS9kdUxaU2lMTjdINzhRRGtndk92ZjdpSUNuaG5wSnVn?=
 =?utf-8?B?dkg4ZFd6SnRqMDRWbDZ0bDQwTzZDVmNaNEJ2RG5ZSmM2MkhWdjM2Zi9NY2kx?=
 =?utf-8?B?MUg4UGFiTmkzUjB2a1M2Ujl4bjltek5kVWRHckpaQzErcjJKUXFsZngrZ0VG?=
 =?utf-8?B?TzBKUmlqNTdockYzdUV5OHA3bUJRN2p5QUQ3SDhnSTZ4L2pEdnpNVDFtT2VF?=
 =?utf-8?B?MnJDUUdYWFpkTWppSW9ZZnVYYVNpVFluVHJEYmxLdDJLeUFSemZVZmZoUjlo?=
 =?utf-8?B?eDQ5ZGVQcHJ1aEtMTjk3K0lxelhVRVNTRDBhWnBXOVlmdTZXZ3VtNjBEeWhi?=
 =?utf-8?B?ay9BRnZWVE8rQVBKK1NxMmEvdU9ERkdaVkd4RWtsYUxCZ2tTSk1LUU9YaUk0?=
 =?utf-8?B?eG0zVFp6clh3WDFwMGxTcHlKeXpiUS9PazY5STBJWTZ0Q2lxaHhpQUpRS0tB?=
 =?utf-8?B?QjFaKzVTL21tQzdsVVRGVENmaDBWcGpjUjZYN3F3THdLVHBkc3IzL3lPVnAz?=
 =?utf-8?B?LzhIN2xsdGRpZ1FpV21mU3lqdG85NmpZRmhkcE5wWUFwQmpkaENGbEg4bm90?=
 =?utf-8?B?cVM3TnliblBKd21ESFFBVVR6d3p5emlrSFp3MTd0bThKaytiL1dCQklCRjkx?=
 =?utf-8?B?bFNKUzBVVmozYVk3N3hEQjIveS9aZ3N4VE4rdU1nSDJpRmZIbDROaGU1b0pa?=
 =?utf-8?B?ZUt0aTBzd1ZPeGZPMVhxSGg0OExMZUl1MEEvaGhIeVplOVNETnB3Zy9PYkJq?=
 =?utf-8?Q?H721KdR8VtYRfwOE=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff51395-530c-4615-0332-08de74e0434f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB3893.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 02:39:28.5439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pc8tk1FiEDU7ooZtIprm2h3uV3yrnX6+TITSO22TxbaPC3GpgS5jTZLcGzOqUOW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5606
X-Proofpoint-GUID: jthAha4soWe0qv-t2TagUp2F3SqRKNmf
X-Proofpoint-ORIG-GUID: jthAha4soWe0qv-t2TagUp2F3SqRKNmf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDAyMiBTYWx0ZWRfX6yWVcwI/41Lv
 6znTlvyYug+x6WzYAkJMab6bdp0tHo34sVy+83dhTFYMK5anxax9mnXfIv4l6ruNo0Whb1tgc2f
 D02guCVNkIUtIGYl21KUaWAWVw6cjXZTd+UIfJET+LT1SjTmAIdHYw4VlRpONI1HZO9SHMCKqoK
 WcNi/TqSr6mpt19pnX8/tpKX1JCBGdvEEn1soU6BMShRVVRRwmDI6mvJjv0H4iezsR8UT1T8Oho
 YCdbeWBK/ZVxfMwrbjPfeu7Dse3funzgNTNC/g+tXMMDNm32y6lQpWtEbfnxVTXQZcxxtQ7kbvf
 bnze+nB0pazUwqzVRY03FVvNGz9XBFvfCPGsBWj0DC59Rc/aiJ1Gq2jILY2atmF7YxT8igzewRz
 u3bLt5SRoaWKmJuUdvIPE7Uce59m4uX/6eLjyeIg/x7VXw4x24lDNEzdX261TEhz+nWiWkOYF+K
 I4pA59pfWXalDXPrEvQ==
X-Authority-Analysis: v=2.4 cv=LuqfC3dc c=1 sm=1 tr=0 ts=699fb264 cx=c_pps
 a=CzkwbHv2eVnX1aWe+0O+5A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=94b4RzGPZZlmCrVK9O0A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261141-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 08F551A02EE
X-Rspamd-Action: no action

On 2/26/26 7:12 AM, Jakub Kicinski wrote:
> On Tue, 24 Feb 2026 20:49:10 -0800 Vishwanath Seshagiri wrote:
>> Use page_pool for RX buffer allocation in mergeable and small buffer
>> modes to enable page recycling and avoid repeated page allocator calls.
>> skb_mark_for_recycle() enables page reuse in the network stack.
> 
> Would you mind holding off v8 until tomorrow mid-day (and rebase then)?
> There is a conflict coming in from Linus'es tree, if you post v8 today
> it will most likely not apply tomorrow :(

ack. will wait until then to send it.

