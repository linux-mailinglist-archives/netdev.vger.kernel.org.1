Return-Path: <netdev+bounces-257289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCEuKYfmhGlf6QMAu9opvQ
	(envelope-from <netdev+bounces-257289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 19:50:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E89F6945
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 19:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 165C1301BCE6
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 18:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF665303A18;
	Thu,  5 Feb 2026 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RbE/xXnv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F42ED844;
	Thu,  5 Feb 2026 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770317335; cv=fail; b=QNj2fIO7dMadYAyI+XyXkyRvntAvLwO9T06PzHU8vRJ0ID+ZEsUYjR9huJ1lgVuFdn3h5NYS1ERfNS8xI4laMQAoDqtyuDLUCP4YXRmcHFyMam1EVqpBxngFo9krUl5Sg0/szRnE22JbWNRjuFDJzwaGgWxt01yZwZjXZTAvwpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770317335; c=relaxed/simple;
	bh=e+zgGmGr76klzj3J96ZtQ4ucW/ZIyn2I8BglnQXdS9U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p+OAS0DeXaTzh5Mb5RP8WEWSBv5bTMJ8ekSstzTGCkbgM+qEaLrahqyzQVKgyHeyXEDXznx1FTKCMypJ0R0lcVxn3WvNkS2J97imUfA/QUJaktHMW8dEpq9LCjARxp1QaYQjV7Yy97/6fZJAOHW3wXNL8pfc+FkGg+IJKk848Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RbE/xXnv; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615FfTEA2704363;
	Thu, 5 Feb 2026 10:48:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=6IkBo399Aaj67acvNzzJjK0Kzpa5uFsU8couwEhpWxc=; b=RbE/xXnv7Zqr
	LeD9hmf01xxfbEWaq+OWrjPb4orOK063TCb56/jzd8pkTtNML3U/WsNfR+ny99KZ
	JZJvVqFdot9T7HrOcPYYtLTHFI7/9jk0F4dJnE9kOYJLbE26cmJ2C+n96WceDmBs
	gbsg5gPnSUZ7L0frKYDXqSiJT3C3Qt+KEzuCnZXDidaC7KjZxpdSKdzHjp4bP+ht
	1CUu0R5+2h84IshInYfQw8y3whwcW4WPuG56qlCzBG/ATASv29xonmilBL+A8Xsr
	f+YY1pTjc5u+yq2wZqPL/waVu29sOXAUjFP8gMUFQDFG5PXr5aimpo68UlvoGz4/
	vVZvdlcAog==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c4x2sjhah-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 10:48:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DaeZz3PSuUVbmhPXkA03QVpn2ple73jResyumBfa+2sX9tU3TgQtb/FGosaoTVEhy59Q7v51sZeRHsSeB6Beqm58Y+aTFmFdu+daLn6IpJJMQh6AyPP8G4ZBuYUnC8zfUH5VU3pPmRJ5OIiA/EoNFfxBs1zj8qycVAKBJ9F9qGsvoO8J3kB6cxjl0KjE9TMDFdR4r7F3yqUsOs6M+U2+k8kYftPSVks9ybIATSbYGxTtzgPJQwaDnM2n9VB2jmn5DAI+WH6JFoHpDPsLddiWEKIp2vHw6Mp1CHOyxN79KtzfaTMHCoZiRwjuzRg9Zcnz3PMWfRoFHaVyH4dm5kkxmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IkBo399Aaj67acvNzzJjK0Kzpa5uFsU8couwEhpWxc=;
 b=K7ZQrurwoIc/bxp7M5W5fKLOnzZBCv+VB3004hcuJFpnAVKHoObLDKQ+bST1KPrnys6qMalARH4O0oSGWngiOxjFXGy5aeNkUs4Ro8xQkFJXCzeAKZlOUK1l3OvEYNsQE/n4GpzHdIFr+9epXVOLwAPLA+6COsno2NNru7fkpIXUMDF/kdUGMYiaR1rOP6g0JldvPRNhPHDKZDisBJ7hHm6D1r7b+Cm9MvurTm7M8h9Phm0vV3rsF1dgvc7yAbyCTpjzxjFjqU5OY6Xsw3obwgDCV/luyNH+ql8E1wZkhhtjEzMCyY65FxMox53SV2L0+o+0lEqnn4Eys4tAuh7dNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11)
 by DS4PPFDD0B461C1.namprd15.prod.outlook.com (2603:10b6:f:fc00::9c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 18:48:39 +0000
Received: from BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044]) by BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044%5]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 18:48:39 +0000
Message-ID: <15c57879-f759-4bd6-8ac6-3f466567a33a@meta.com>
Date: Thu, 5 Feb 2026 10:48:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] virtio_net: add page_pool support for
 buffer allocation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>,
        Matteo Croce <technoboy85@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
References: <20260204193617.1200752-1-vishs@meta.com>
 <20260204193617.1200752-2-vishs@meta.com>
 <20260205000916-mutt-send-email-mst@kernel.org>
 <efa1f22b-eabc-4602-8886-b7cf5e3c057e@meta.com>
 <20260205013640-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vishwanath Seshagiri <vishs@meta.com>
In-Reply-To: <20260205013640-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:332::32) To BLAPR15MB3889.namprd15.prod.outlook.com
 (2603:10b6:208:27a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR15MB3889:EE_|DS4PPFDD0B461C1:EE_
X-MS-Office365-Filtering-Correlation-Id: 4875c6be-68e2-44f3-fb9a-08de64e72d05
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SzI3bnhWekY5b3JQRWMyOStSVG43TnAxNmx4QmxIOEt1TU1oUDdmYStRK0Nj?=
 =?utf-8?B?dUxCVVBxZmJDdVF5MWhVNlBwMGhqSnVBcVVnSG1wQVEwem50RUNabjRUWlc3?=
 =?utf-8?B?SnBqdnRHY1dieGhZdTE4MFJiVllsaE96cm5JU3gyK2xaNmdEREoyYVdDOXZJ?=
 =?utf-8?B?UVFiM1B4SCt4VEpHRVZzank4RnNFdkowV0pQbUozUk5NcnNBRHJhNkNUd2JN?=
 =?utf-8?B?Z3ExdlZydmMvemtPekEvZXdscGFtS1BWNkNNOUJWcTZQRzV2cXJmUUtISzVv?=
 =?utf-8?B?YXgyWVlUd3AxZlo2V0M5ZURTdkM3Q2lTSEdjdWRuRmZRcG5IT04rNFhjYjBM?=
 =?utf-8?B?WE0zWm1qL2NPVTFGMVdhYkNyME9sNDdHYVh0MEVQZUJRRWVFazJhTW1VR0FO?=
 =?utf-8?B?RmUxeEt5VStiRjVtTlVCN0hVY0dEOTdDYS9QL0NvWC9TaklkZGNpUnJwc3dU?=
 =?utf-8?B?T0VUVFVxakhwSyt3b1c4RG5pNml1YkFTL25nK1VJRThFRUlJSEpVSU1tekZT?=
 =?utf-8?B?RVRoeER0T2Y1a1lhQ1lSdmY4VmNkVFg4WFFOMzQzYytPN3BVRjBrUURxTTRS?=
 =?utf-8?B?aGRyTEVEczQxNTZ3c2FtQjl5VG9LR3dSYkQ2MVNWRlhzSSs4ZnVxMDZVSjdO?=
 =?utf-8?B?YlZQQzU3Y0VMRjMrVUNDZU50ZXBlaWN5NS85N2tKQTJ2S09QSzF3dWFJV2xk?=
 =?utf-8?B?cjVGNXJHWE5Xa3kwc0Z6TDBsMm8wc2RPb0VLbk10VTM4aWphUXlKT1N4NmxF?=
 =?utf-8?B?Uno1MERmVHpic3RrbGxaTnRNbXREVVJjcFlBMDlUeU9NUHJ1TzhQMEdJTUJE?=
 =?utf-8?B?KzZINWFNejlQYlBlaXlsWlRqTDlha0xxSTFmWWtncXpkT1laUW5pQkhQUjdI?=
 =?utf-8?B?RER4ZGRRc1pDaHZGelNwUHZ0UWxtODI0YU8xOXlRNkpaTjM2dmtVRU5lRTZC?=
 =?utf-8?B?WStlZmhiMWQ2OTlQUHhUTEY5bEx6WlU0NjhONjJuY2E4VFIxcjY3OUppWS9a?=
 =?utf-8?B?SHRoV0RKU2ROVUFxOHpkZ0lFaGc2Vm5BNU9hTU9yNFQrbmtjejc5djdVbmt6?=
 =?utf-8?B?UmhrMWcrQ2laUDFqNTVRdGhKTXk1aHl0bDlkS2ZVczFqYUF2V2YzSXdEUUUr?=
 =?utf-8?B?dk44NW5ZSjNKVlJjeHhWOGlSQWEySzQwbCtGMHlPdTRBRVlIQW82TjdXcDNI?=
 =?utf-8?B?cDdMRFp4aEh4dXRqOFNyemFrSUpqRURhNWpKQ0hCMGRyOXM4K0ZrV01XMUtE?=
 =?utf-8?B?aE5DaFVNa1ZoVm81cGtoU0RhZzBnajJZVHlmOGFuUTZzTDQyUHliNnY2UnZR?=
 =?utf-8?B?NE1XbHNhU2lkU3dkVmlrUkZCVWlrYjN4WUZpaEQ4blJXQ3B4bHlvOUtDbTV0?=
 =?utf-8?B?NWNwQ1Rtd0xPbE1CYVA1WVF3U3VNMk42U2txckFyQWFTTFlsOTVkZDlwSHpP?=
 =?utf-8?B?MVlDSHExbzZrZ0VVY0FxWmRVS1dIWU94N0orSm16MjFnbzNNSHpWTVJxVy9V?=
 =?utf-8?B?azE1Vy9UQ2tFMmtUMDVVR0dHVTZ6UXdrUVJZaTcwVWZCelhKVGpSMitMM0l6?=
 =?utf-8?B?cmRlamxveUFXWlBlaUQ5TzVtY0JsY2NOY0VDeW9WNzNjeExnSk9FRHFwRzh6?=
 =?utf-8?B?ZXJsOGVvaDNWTk05cnhYREdVbjV3dUhsajM3MC9QUk1NWHlzYUZGeVp3SXhQ?=
 =?utf-8?B?QnVpcEF4NnNzQ0xSU0ZTYlprUUFoVFdMbFFKTDVRSk82eVNuWGRMNWhKSzFr?=
 =?utf-8?B?Z3huWGVmb0pBSlI5SUU0S0Y0M002aVplc0FTSFNxWk5tZW90bVhsQmdHbktG?=
 =?utf-8?B?aTR0ek1ySFZhRks1SmxienBIT1NEN2cyVzR0amdUU1h5ZVJjL29VN2lDaGsr?=
 =?utf-8?B?QUNBdFh4WEg5blFZMDk0Y2dCR3RnYldNTzdyRjNXRm1VdjlNbXN6S0Y3S3Y3?=
 =?utf-8?B?eXVWVEpXNk12a0tMN3dvVHJPQ250TW5JaGRPdWZ2Ni9JbXpDcWwzbzBEWVVa?=
 =?utf-8?B?ZlpKVVZnU2o1V01FT2ZsTTlqcW1qdFBCbHovU3RBZlhsblNhTTN2cUVtUVRJ?=
 =?utf-8?B?WnB3RW1vVVk2c3lKMm8zeFNvbXpYbFVqZEhIZUV0SmxYK3dLaFdybnpicnlp?=
 =?utf-8?Q?tqQ4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB3889.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bkpEZjdESkdLSjNFVzVqWE53bm9valhib0oyKzdXcVhCMUtzdGgycUUrUmxF?=
 =?utf-8?B?YWtqYkVoWmdWVU5QL3NIaVEvNm5kbjU1eEhjbHlnUGFEWDExVytRY0pyc0J3?=
 =?utf-8?B?eVBZS2RCT1p6TG9xOUpZdTJIOUJvaDNISHRaMTBQalU2ZE8xMlJpSEpMZE9T?=
 =?utf-8?B?ZGRyMzg3UnBMckdCVXBTdElKcW8xbGdyclV4RnhGQzBZT2V1dHNIT1Ewd09w?=
 =?utf-8?B?b0NpR3dZMWVSNngyQ2x0ajVPclhQVHZEQ01NWUVnWnZDM2NKQkUvWE5Ccmlt?=
 =?utf-8?B?TEozUU5nUTJGZjVqTnpzeFg5NVVjMEV0WldjSXh4V0U0OWR2TGMvdm1WQjVu?=
 =?utf-8?B?ZThieHdDTEdobmczQmVoZC93eXdTUlF2VEQ0c3RZbFo0bnF3S1pCc2lVSElZ?=
 =?utf-8?B?SHMzYjg3TDU4RWYrVkd1SGJqdmNRR3ZRczVmR3hobCtGdG1YY1JwSURnd0NN?=
 =?utf-8?B?K0lCcWE5ZlhuNDdQWmdEbTNvMUxoRGhhWlRFK0JQaEJMRUxtZFJJRndyWDcz?=
 =?utf-8?B?UFpRN0orcHpNTnRkbitBZDRmZmpBMlJRVWhqTFFMTzRLamd4Z1c1RStVbE1T?=
 =?utf-8?B?TUlUUDcxZnB3VUlZaUxXbFdHd1JidFNGb2g3MWtueXpNS0xRbGNNczdXUVlD?=
 =?utf-8?B?QVVjWllBK3V0RHoyRy8xMzJXcUtZR3IvNjN3TjhHRm1aaFZxY0xtTkZVdzdY?=
 =?utf-8?B?V1hSTDFYVmhFWklSWHlOSUMzOWFUeE4zaEFKejFYSTJKSFFvTnIydVcxV083?=
 =?utf-8?B?OW1MSWVFc0NjTzgreDF5VkYwVHBvN2ROZWV5UWlLN3luSXlCaVVzUGkzRE9B?=
 =?utf-8?B?Wk5TcStOWEt4WHZ6allNZ1pCcUFMc1haZFZkQjBVWENHVFNWWVEyT0tNOTZR?=
 =?utf-8?B?ZFg2eVZsMTdpdXYrM3ptMEFqZmc0TGt4QVMxZFRjRTJGS0RpT0ZTTC9WeEtx?=
 =?utf-8?B?K0dHYzRscXBJRWxRVUZPRWJkT3poMHJCUlB1am91WU9ITkRaOXlhLzRvbFRm?=
 =?utf-8?B?Y1hBc2VjdW0yZndUK2hOemZyNHh6bEN6a0lLbktwYy8yU0xjTGU5OVpnWmFF?=
 =?utf-8?B?cEoyRXFVNXUwRE9sOGthb1huQUVmMHNyZ3VWVGlORVdvWWkzd2V2NWlGeUdI?=
 =?utf-8?B?b0htRy9HVGd2bndSUXgyMjhvaHJ2UGsveFZUVnVSd0ZQYmdZV3dySnB0OFU0?=
 =?utf-8?B?WUh3d2tuUnY5RkVhVTVKcUkzdTgvYW1hRURFb0hKUFVWR0V5STJkY25QYnZY?=
 =?utf-8?B?ZmVGMTc5TXJKNEQ0ajAvZFBTWTV4YzNpWG9rdDFkbkR3QTVZVFFCeDRkZE5L?=
 =?utf-8?B?V2xTWVJnbVM2YW9CYnphRi9ZN3NIMzBFckZKeUZ6dUFjbGtmbXd2R21tWnpx?=
 =?utf-8?B?OU5pUmpVU2JhZlBuTG9SUW9BcGN3aDhGa3NVN1diZjB5K3lEMUVlWVlCei9D?=
 =?utf-8?B?V1BtQjdjWHpYU3dRZGhFYlVvR1ZIdmRBS3FiVW5BWEN0TnZPcGJZb053ZkRO?=
 =?utf-8?B?Uy84RTVMcDFuVzJ1dDRBajZCa0tnQW0vdXRDNUg3OXRzV2Y5a2VVVkEyKzlX?=
 =?utf-8?B?M2c1aGhLTXRsREhNSkdMdEhLenBCSFkzTEFhY0NOaEhUWTlrbU5tQld4VEUx?=
 =?utf-8?B?RWRrLzhjZEVUcFlHdUcwK2pWNFBJSFpISlhHY1llaTgvdzd3OG1uZ01ldFFS?=
 =?utf-8?B?L201ajdYSVllUTkyVmtzZ3VoNnVFVEJhT3RodlhtNlhOenlkeHVaL0JrU2VC?=
 =?utf-8?B?VnhvRGwwSkZ0NmFUYWNOaXpSOGoyUWRjR1lFTmo2U3kxMk5ndGhxZUppR0w1?=
 =?utf-8?B?WXREYlFHekE5MzFCdGozMUVuL1VERUx2aElYUS9tT21hSUdTMFBLbCtJNHQ2?=
 =?utf-8?B?VGFkZ1lBTVF2WHZDV2NrazJ6R1FCamhrVGN4ODQ1ZU9OZmUzMGJaekJpL0J6?=
 =?utf-8?B?OVYxWW9sTzQwVnRjcG9tVzJhZS81dFNWNnpwdGFSZVE4dlUzR3l1T08vZmhx?=
 =?utf-8?B?NzRoUElCTGdXaGRXaU5XV0trTWhUcytwazJveFg2bFB6VW9Wc2JtZTdOQUEv?=
 =?utf-8?B?R3pQL1pJc1pPaEVyUWw3bFlFN2pLYnZNcXFiVmFSUkdvZ0lFRm1ma3lRckM2?=
 =?utf-8?B?RlA3VnB6RzJQQlRLcmpqV3dRUUZTUUw0ZEZrbXR0aFJOUG82SEJyNnR4aFRF?=
 =?utf-8?B?WU5nSzE3N0dIQ0hzbExHMHFxbEd5VWFUZ3lySDRCNVZ0ODRhSHlLMkFWZ1Vz?=
 =?utf-8?B?SnVSQU8xN1A4TFEvN1AzdVFvQ3pSSVIwY0psTFFValhpelNDWEY0UW5iNVNG?=
 =?utf-8?B?aWRrSStucS90bFNpY3NSNWROOGh3VzRZaVM2ekI3VnRPMlNDbU5yNExJcjQ2?=
 =?utf-8?Q?RZbcDHt7fXE2q5II=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4875c6be-68e2-44f3-fb9a-08de64e72d05
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB3889.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 18:48:39.1986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPVAdjf4XMVle0YTeCZJTwd9qK2FaxfOFRsCRKUYnvcnJtgS0AHfwTZr+i1fUA0t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFDD0B461C1
X-Proofpoint-GUID: kccYb0LPK9igERfFVJp8XfkCOtUnQYay
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE0MyBTYWx0ZWRfX1FSCSEDYgpvH
 kePvFGmBM3MUTDypYVFFdQjI6eXyLrGNcNYLZlTeXHPlW2FCHOrSTgj58gC9cIVqmQ2nO/i+004
 A49q6JTrvde53bmsbea6wDiImuWTwgOq1fEmLDQcxcuTdcto5AHVTTgCUCnl1C9rRjDXAWvu3Lq
 s0zzTx3e34z6S8PvSGI/Rw3pdJIYF/LuYk7S4SMKUeVBH3B2GxEeRSceOoL3BDeDAnxh9bXSWUP
 RbNYuHo694kPIP0CQd4nsFxkFY1WeP26Eq+xe5wSZBZqwgYnK1mPGi6YmC0gPdh0CoCrJGWRdnu
 yT17rmx8VINMZ0+r2SU99M0dYa3m8qlEwI+eedm4GVm5YkWK47yjzWxhd9Wx+I19RLRyEoGB4Dd
 NCA5eJcMlFwUqvwngI7TcP0TpSn/iKKgtNLZP9kfJeN+VD3sWBtnj1xORtajH6M1ACTD1f2rNC4
 mT/LFI45h15y+0qEvhg==
X-Authority-Analysis: v=2.4 cv=aPz9aL9m c=1 sm=1 tr=0 ts=6984e609 cx=c_pps
 a=JXicDZ6CVi74U63V4YFJkg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8 a=p_itvfGdbNRI2ye1EpMA:9
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: kccYb0LPK9igERfFVJp8XfkCOtUnQYay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_03,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-257289-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pp_params.dev:url,meta.com:email,meta.com:dkim,meta.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E7E89F6945
X-Rspamd-Action: no action



On 2/4/26 10:40 PM, Michael S. Tsirkin wrote:
> On Wed, Feb 04, 2026 at 10:34:38PM -0800, Vishwanath Seshagiri wrote:
>>
>>
>> On 2/4/26 9:30 PM, Michael S. Tsirkin wrote:
>>> On Wed, Feb 04, 2026 at 11:36:16AM -0800, Vishwanath Seshagiri wrote:
>>>> Use page_pool for RX buffer allocation in mergeable and small buffer
>>>> modes to enable page recycling and avoid repeated page allocator calls.
>>>> skb_mark_for_recycle() enables page reuse in the network stack.
>>>>
>>>> Big packets mode is unchanged because it uses page->private for linked
>>>> list chaining of multiple pages per buffer, which conflicts with
>>>> page_pool's internal use of page->private.
>>>>
>>>> Implement conditional DMA premapping using virtqueue_dma_dev():
>>>> - When non-NULL (vhost, virtio-pci): use PP_FLAG_DMA_MAP with page_pool
>>>>     handling DMA mapping, submit via virtqueue_add_inbuf_premapped()
>>>> - When NULL (VDUSE, direct physical): page_pool handles allocation only,
>>>>     submit via virtqueue_add_inbuf_ctx()
>>>>
>>>> This preserves the DMA premapping optimization from commit 31f3cd4e5756b
>>>> ("virtio-net: rq submits premapped per-buffer") while adding page_pool
>>>> support as a prerequisite for future zero-copy features (devmem TCP,
>>>> io_uring ZCRX).
>>>>
>>>> Page pools are created in probe and destroyed in remove (not open/close),
>>>> following existing driver behavior where RX buffers remain in virtqueues
>>>> across interface state changes.
>>>>
>>>> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
>>>> ---
>>>>    drivers/net/Kconfig      |   1 +
>>>>    drivers/net/virtio_net.c | 351 ++++++++++++++++++++++-----------------
>>>>    2 files changed, 201 insertions(+), 151 deletions(-)
>>>>
>>>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>>>> index ac12eaf11755..f1e6b6b0a86f 100644
>>>> --- a/drivers/net/Kconfig
>>>> +++ b/drivers/net/Kconfig
>>>> @@ -450,6 +450,7 @@ config VIRTIO_NET
>>>>    	depends on VIRTIO
>>>>    	select NET_FAILOVER
>>>>    	select DIMLIB
>>>> +	select PAGE_POOL
>>>>    	help
>>>>    	  This is the virtual network driver for virtio.  It can be used with
>>>>    	  QEMU based VMMs (like KVM or Xen).  Say Y or M.
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index db88dcaefb20..74c51e597c3f 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -26,6 +26,7 @@
>>>>    #include <net/netdev_rx_queue.h>
>>>>    #include <net/netdev_queues.h>
>>>>    #include <net/xdp_sock_drv.h>
>>>> +#include <net/page_pool/helpers.h>
>>>>    static int napi_weight = NAPI_POLL_WEIGHT;
>>>>    module_param(napi_weight, int, 0444);
>>>> @@ -359,6 +360,11 @@ struct receive_queue {
>>>>    	/* Page frag for packet buffer allocation. */
>>>>    	struct page_frag alloc_frag;
>>>> +	struct page_pool *page_pool;
>>>> +
>>>> +	/* True if page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
>>>> +	bool use_page_pool_dma;
>>>> +
>>>>    	/* RX: fragments + linear part + virtio header */
>>>>    	struct scatterlist sg[MAX_SKB_FRAGS + 2];
>>>> @@ -521,11 +527,13 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>>>>    			       struct virtnet_rq_stats *stats);
>>>>    static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
>>>>    				 struct sk_buff *skb, u8 flags);
>>>> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>>>> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
>>>> +					       struct sk_buff *head_skb,
>>>>    					       struct sk_buff *curr_skb,
>>>>    					       struct page *page, void *buf,
>>>>    					       int len, int truesize);
>>>>    static void virtnet_xsk_completed(struct send_queue *sq, int num);
>>>> +static void free_unused_bufs(struct virtnet_info *vi);
>>>>    enum virtnet_xmit_type {
>>>>    	VIRTNET_XMIT_TYPE_SKB,
>>>> @@ -706,15 +714,24 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>>>>    	return p;
>>>>    }
>>>> +static void virtnet_put_page(struct receive_queue *rq, struct page *page,
>>>> +			     bool allow_direct)
>>>> +{
>>>> +	if (page_pool_page_is_pp(page))
>>>> +		page_pool_put_page(rq->page_pool, page, -1, allow_direct);
>>>> +	else
>>>> +		put_page(page);
>>>> +}
>>>> +
>>>>    static void virtnet_rq_free_buf(struct virtnet_info *vi,
>>>>    				struct receive_queue *rq, void *buf)
>>>>    {
>>>>    	if (vi->mergeable_rx_bufs)
>>>> -		put_page(virt_to_head_page(buf));
>>>> +		virtnet_put_page(rq, virt_to_head_page(buf), false);
>>>>    	else if (vi->big_packets)
>>>>    		give_pages(rq, buf);
>>>>    	else
>>>> -		put_page(virt_to_head_page(buf));
>>>> +		virtnet_put_page(rq, virt_to_head_page(buf), false);
>>>>    }
>>>>    static void enable_rx_mode_work(struct virtnet_info *vi)
>>>> @@ -877,9 +894,12 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>>>    		if (unlikely(!skb))
>>>>    			return NULL;
>>>> -		page = (struct page *)page->private;
>>>> -		if (page)
>>>> -			give_pages(rq, page);
>>>> +		if (!rq->page_pool) {
>>>
>>> I think this is ok because big_packets is exactly when this happens.
>>> but it is confusing that the conditions on free and alloc are
>>> written differently. A comment with an explanation, at least?
>>
>> I will add a comment here in v5.
> 
> Would be better to also unify the way we test on alloc and free paths,
> if possible.

Yeah, I can unify the checks wherever possible, and will add a comment
when I cannot make the changes.

> 
> 
>>>
>>>
>>>> +			page = (struct page *)page->private;
>>>> +			if (page)
>>>> +				give_pages(rq, page);
>>>> +		}
>>>> +
>>>>    		goto ok;
>>>>    	}
>>>> @@ -925,7 +945,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>>>    	hdr = skb_vnet_common_hdr(skb);
>>>>    	memcpy(hdr, hdr_p, hdr_len);
>>>>    	if (page_to_free)
>>>> -		put_page(page_to_free);
>>>> +		virtnet_put_page(rq, page_to_free, true);
>>>>    	return skb;
>>>>    }
>>>> @@ -965,93 +985,10 @@ static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
>>>>    static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>>>>    {
>>>>    	struct virtnet_info *vi = rq->vq->vdev->priv;
>>>> -	void *buf;
>>>> -
>>>> -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>>>> -
>>>> -	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
>>>> -	if (buf)
>>>> -		virtnet_rq_unmap(rq, buf, *len);
>>>> -
>>>> -	return buf;
>>>> -}
>>>> -
>>>> -static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
>>>> -{
>>>> -	struct virtnet_info *vi = rq->vq->vdev->priv;
>>>> -	struct virtnet_rq_dma *dma;
>>>> -	dma_addr_t addr;
>>>> -	u32 offset;
>>>> -	void *head;
>>>> -
>>>> -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>>>> -
>>>> -	head = page_address(rq->alloc_frag.page);
>>>> -
>>>> -	offset = buf - head;
>>>> -
>>>> -	dma = head;
>>>> -
>>>> -	addr = dma->addr - sizeof(*dma) + offset;
>>>> -
>>>> -	sg_init_table(rq->sg, 1);
>>>> -	sg_fill_dma(rq->sg, addr, len);
>>>> -}
>>>> -
>>>> -static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
>>>> -{
>>>> -	struct page_frag *alloc_frag = &rq->alloc_frag;
>>>> -	struct virtnet_info *vi = rq->vq->vdev->priv;
>>>> -	struct virtnet_rq_dma *dma;
>>>> -	void *buf, *head;
>>>> -	dma_addr_t addr;
>>>>    	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>>>> -	head = page_address(alloc_frag->page);
>>>> -
>>>> -	dma = head;
>>>> -
>>>> -	/* new pages */
>>>> -	if (!alloc_frag->offset) {
>>>> -		if (rq->last_dma) {
>>>> -			/* Now, the new page is allocated, the last dma
>>>> -			 * will not be used. So the dma can be unmapped
>>>> -			 * if the ref is 0.
>>>> -			 */
>>>> -			virtnet_rq_unmap(rq, rq->last_dma, 0);
>>>> -			rq->last_dma = NULL;
>>>> -		}
>>>> -
>>>> -		dma->len = alloc_frag->size - sizeof(*dma);
>>>> -
>>>> -		addr = virtqueue_map_single_attrs(rq->vq, dma + 1,
>>>> -						  dma->len, DMA_FROM_DEVICE, 0);
>>>> -		if (virtqueue_map_mapping_error(rq->vq, addr))
>>>> -			return NULL;
>>>> -
>>>> -		dma->addr = addr;
>>>> -		dma->need_sync = virtqueue_map_need_sync(rq->vq, addr);
>>>
>>> it gives me pause that this patch never does sync.
>>> don't you need page_pool_dma_sync_for_cpu somewhere?
>>
>> I missed the page_pool_dma_sync_for_cpu in the receive path before
>> reading the buffer data. I will add it in v5.
>>
>>>
>>>
>>>
>>>> -
>>>> -		/* Add a reference to dma to prevent the entire dma from
>>>> -		 * being released during error handling. This reference
>>>> -		 * will be freed after the pages are no longer used.
>>>> -		 */
>>>> -		get_page(alloc_frag->page);
>>>> -		dma->ref = 1;
>>>> -		alloc_frag->offset = sizeof(*dma);
>>>> -
>>>> -		rq->last_dma = dma;
>>>> -	}
>>>> -
>>>> -	++dma->ref;
>>>> -
>>>> -	buf = head + alloc_frag->offset;
>>>> -
>>>> -	get_page(alloc_frag->page);
>>>> -	alloc_frag->offset += size;
>>>> -
>>>> -	return buf;
>>>> +	return virtqueue_get_buf_ctx(rq->vq, len, ctx);
>>>>    }
>>>>    static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>>>> @@ -1067,9 +1004,6 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>>>>    		return;
>>>>    	}
>>>> -	if (!vi->big_packets || vi->mergeable_rx_bufs)
>>>> -		virtnet_rq_unmap(rq, buf, 0);
>>>> -
>>>>    	virtnet_rq_free_buf(vi, rq, buf);
>>>>    }
>>>> @@ -1335,7 +1269,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
>>>>    		truesize = len;
>>>> -		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>>>> +		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>>>>    						    buf, len, truesize);
>>>>    		if (!curr_skb) {
>>>>    			put_page(page);
>>>> @@ -1771,7 +1705,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>>>>    	return ret;
>>>>    }
>>>> -static void put_xdp_frags(struct xdp_buff *xdp)
>>>> +static void put_xdp_frags(struct receive_queue *rq, struct xdp_buff *xdp)
>>>>    {
>>>>    	struct skb_shared_info *shinfo;
>>>>    	struct page *xdp_page;
>>>> @@ -1781,7 +1715,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>>>>    		shinfo = xdp_get_shared_info_from_buff(xdp);
>>>>    		for (i = 0; i < shinfo->nr_frags; i++) {
>>>>    			xdp_page = skb_frag_page(&shinfo->frags[i]);
>>>> -			put_page(xdp_page);
>>>> +			virtnet_put_page(rq, xdp_page, true);
>>>>    		}
>>>>    	}
>>>>    }
>>>> @@ -1873,7 +1807,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>>>    	if (page_off + *len + tailroom > PAGE_SIZE)
>>>>    		return NULL;
>>>> -	page = alloc_page(GFP_ATOMIC);
>>>> +	page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
>>>>    	if (!page)
>>>>    		return NULL;
>>>> @@ -1897,7 +1831,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>>>    		off = buf - page_address(p);
>>>>    		if (check_mergeable_len(dev, ctx, buflen)) {
>>>> -			put_page(p);
>>>> +			virtnet_put_page(rq, p, true);
>>>>    			goto err_buf;
>>>>    		}
>>>> @@ -1905,21 +1839,21 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>>>    		 * is sending packet larger than the MTU.
>>>>    		 */
>>>>    		if ((page_off + buflen + tailroom) > PAGE_SIZE) {
>>>> -			put_page(p);
>>>> +			virtnet_put_page(rq, p, true);
>>>>    			goto err_buf;
>>>>    		}
>>>>    		memcpy(page_address(page) + page_off,
>>>>    		       page_address(p) + off, buflen);
>>>>    		page_off += buflen;
>>>> -		put_page(p);
>>>> +		virtnet_put_page(rq, p, true);
>>>>    	}
>>>>    	/* Headroom does not contribute to packet length */
>>>>    	*len = page_off - XDP_PACKET_HEADROOM;
>>>>    	return page;
>>>>    err_buf:
>>>> -	__free_pages(page, 0);
>>>> +	page_pool_put_page(rq->page_pool, page, -1, true);
>>>>    	return NULL;
>>>>    }
>>>> @@ -1996,7 +1930,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>>>    			goto err_xdp;
>>>>    		buf = page_address(xdp_page);
>>>> -		put_page(page);
>>>> +		virtnet_put_page(rq, page, true);
>>>>    		page = xdp_page;
>>>>    	}
>>>> @@ -2028,13 +1962,15 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>>>    	if (metasize)
>>>>    		skb_metadata_set(skb, metasize);
>>>> +	skb_mark_for_recycle(skb);
>>>> +
>>>>    	return skb;
>>>>    err_xdp:
>>>>    	u64_stats_inc(&stats->xdp_drops);
>>>>    err:
>>>>    	u64_stats_inc(&stats->drops);
>>>> -	put_page(page);
>>>> +	virtnet_put_page(rq, page, true);
>>>>    xdp_xmit:
>>>>    	return NULL;
>>>>    }
>>>> @@ -2082,12 +2018,14 @@ static struct sk_buff *receive_small(struct net_device *dev,
>>>>    	}
>>>>    	skb = receive_small_build_skb(vi, xdp_headroom, buf, len);
>>>> -	if (likely(skb))
>>>> +	if (likely(skb)) {
>>>> +		skb_mark_for_recycle(skb);
>>>>    		return skb;
>>>> +	}
>>>>    err:
>>>>    	u64_stats_inc(&stats->drops);
>>>> -	put_page(page);
>>>> +	virtnet_put_page(rq, page, true);
>>>>    	return NULL;
>>>>    }
>>>> @@ -2142,7 +2080,7 @@ static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
>>>>    		}
>>>>    		u64_stats_add(&stats->bytes, len);
>>>>    		page = virt_to_head_page(buf);
>>>> -		put_page(page);
>>>> +		virtnet_put_page(rq, page, true);
>>>>    	}
>>>>    }
>>>> @@ -2253,7 +2191,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>>>>    		offset = buf - page_address(page);
>>>>    		if (check_mergeable_len(dev, ctx, len)) {
>>>> -			put_page(page);
>>>> +			virtnet_put_page(rq, page, true);
>>>>    			goto err;
>>>>    		}
>>>> @@ -2272,7 +2210,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>>>>    	return 0;
>>>>    err:
>>>> -	put_xdp_frags(xdp);
>>>> +	put_xdp_frags(rq, xdp);
>>>>    	return -EINVAL;
>>>>    }
>>>> @@ -2337,7 +2275,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>>>>    		if (*len + xdp_room > PAGE_SIZE)
>>>>    			return NULL;
>>>> -		xdp_page = alloc_page(GFP_ATOMIC);
>>>> +		xdp_page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
>>>>    		if (!xdp_page)
>>>>    			return NULL;
>>>> @@ -2347,7 +2285,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>>>>    	*frame_sz = PAGE_SIZE;
>>>> -	put_page(*page);
>>>> +	virtnet_put_page(rq, *page, true);
>>>>    	*page = xdp_page;
>>>> @@ -2393,6 +2331,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>>>    		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
>>>>    		if (unlikely(!head_skb))
>>>>    			break;
>>>> +
>>>> +		skb_mark_for_recycle(head_skb);
>>>>    		return head_skb;
>>>>    	case XDP_TX:
>>>> @@ -2403,10 +2343,10 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>>>    		break;
>>>>    	}
>>>> -	put_xdp_frags(&xdp);
>>>> +	put_xdp_frags(rq, &xdp);
>>>>    err_xdp:
>>>> -	put_page(page);
>>>> +	virtnet_put_page(rq, page, true);
>>>>    	mergeable_buf_free(rq, num_buf, dev, stats);
>>>>    	u64_stats_inc(&stats->xdp_drops);
>>>> @@ -2414,7 +2354,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>>>    	return NULL;
>>>>    }
>>>> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>>>> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
>>>> +					       struct sk_buff *head_skb,
>>>>    					       struct sk_buff *curr_skb,
>>>>    					       struct page *page, void *buf,
>>>>    					       int len, int truesize)
>>>> @@ -2446,7 +2387,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>>>>    	offset = buf - page_address(page);
>>>>    	if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
>>>> -		put_page(page);
>>>> +		virtnet_put_page(rq, page, true);
>>>>    		skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
>>>>    				     len, truesize);
>>>>    	} else {
>>>> @@ -2499,6 +2440,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>>>    	if (unlikely(!curr_skb))
>>>>    		goto err_skb;
>>>> +
>>>> +	skb_mark_for_recycle(head_skb);
>>>>    	while (--num_buf) {
>>>>    		buf = virtnet_rq_get_buf(rq, &len, &ctx);
>>>>    		if (unlikely(!buf)) {
>>>> @@ -2517,7 +2460,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>>>    			goto err_skb;
>>>>    		truesize = mergeable_ctx_to_truesize(ctx);
>>>> -		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>>>> +		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>>>>    						    buf, len, truesize);
>>>>    		if (!curr_skb)
>>>>    			goto err_skb;
>>>> @@ -2527,7 +2470,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>>>    	return head_skb;
>>>>    err_skb:
>>>> -	put_page(page);
>>>> +	virtnet_put_page(rq, page, true);
>>>>    	mergeable_buf_free(rq, num_buf, dev, stats);
>>>>    err_buf:
>>>> @@ -2666,32 +2609,42 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>>>    static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>>>>    			     gfp_t gfp)
>>>>    {
>>>> -	char *buf;
>>>>    	unsigned int xdp_headroom = virtnet_get_headroom(vi);
>>>>    	void *ctx = (void *)(unsigned long)xdp_headroom;
>>>>    	int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_headroom;
>>>> +	unsigned int offset;
>>>> +	struct page *page;
>>>> +	dma_addr_t addr;
>>>> +	char *buf;
>>>>    	int err;
>>>>    	len = SKB_DATA_ALIGN(len) +
>>>>    	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>>> -	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
>>>> -		return -ENOMEM;
>>>> -
>>>> -	buf = virtnet_rq_alloc(rq, len, gfp);
>>>> -	if (unlikely(!buf))
>>>> +	page = page_pool_alloc_frag(rq->page_pool, &offset, len, gfp);
>>>> +	if (unlikely(!page))
>>>>    		return -ENOMEM;
>>>> +	buf = page_address(page) + offset;
>>>>    	buf += VIRTNET_RX_PAD + xdp_headroom;
>>>> -	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
>>>> +	if (rq->use_page_pool_dma) {
>>>> +		addr = page_pool_get_dma_addr(page) + offset;
>>>> +		addr += VIRTNET_RX_PAD + xdp_headroom;
>>>> -	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
>>>> -	if (err < 0) {
>>>> -		virtnet_rq_unmap(rq, buf, 0);
>>>> -		put_page(virt_to_head_page(buf));
>>>> +		sg_init_table(rq->sg, 1);
>>>> +		sg_fill_dma(rq->sg, addr, vi->hdr_len + GOOD_PACKET_LEN);
>>>> +		err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1,
>>>> +						    buf, ctx, gfp);
>>>> +	} else {
>>>> +		sg_init_one(rq->sg, buf, vi->hdr_len + GOOD_PACKET_LEN);
>>>> +		err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1,
>>>> +					      buf, ctx, gfp);
>>>>    	}
>>>> +	if (err < 0)
>>>> +		page_pool_put_page(rq->page_pool, virt_to_head_page(buf),
>>>> +				   -1, false);
>>>>    	return err;
>>>>    }
>>>> @@ -2764,13 +2717,15 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
>>>>    static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>>>    				 struct receive_queue *rq, gfp_t gfp)
>>>>    {
>>>> -	struct page_frag *alloc_frag = &rq->alloc_frag;
>>>>    	unsigned int headroom = virtnet_get_headroom(vi);
>>>>    	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
>>>>    	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
>>>>    	unsigned int len, hole;
>>>> -	void *ctx;
>>>> +	unsigned int offset;
>>>> +	struct page *page;
>>>> +	dma_addr_t addr;
>>>>    	char *buf;
>>>> +	void *ctx;
>>>>    	int err;
>>>>    	/* Extra tailroom is needed to satisfy XDP's assumption. This
>>>> @@ -2779,18 +2734,14 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>>>    	 */
>>>>    	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>>>> -	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
>>>> -		return -ENOMEM;
>>>> -
>>>> -	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
>>>> -		len -= sizeof(struct virtnet_rq_dma);
>>>> -
>>>> -	buf = virtnet_rq_alloc(rq, len + room, gfp);
>>>> -	if (unlikely(!buf))
>>>> +	page = page_pool_alloc_frag(rq->page_pool, &offset, len + room, gfp);
>>>> +	if (unlikely(!page))
>>>>    		return -ENOMEM;
>>>> +	buf = page_address(page) + offset;
>>>>    	buf += headroom; /* advance address leaving hole at front of pkt */
>>>> -	hole = alloc_frag->size - alloc_frag->offset;
>>>> +
>>>> +	hole = PAGE_SIZE - (offset + len + room);
>>>>    	if (hole < len + room) {
>>>>    		/* To avoid internal fragmentation, if there is very likely not
>>>>    		 * enough space for another buffer, add the remaining space to
>>>> @@ -2800,18 +2751,27 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>>>    		 */
>>>>    		if (!headroom)
>>>>    			len += hole;
>>>> -		alloc_frag->offset += hole;
>>>
>>> Hmm. All these allocations are tricky.
>>> So we used to advance offset by hole but with page pool api
>>> what advances pool->frag_offset? If nothing will not the next
>>> small allocation reuse the space and overlap the buffer?
>>
>> I tested with debug tracing and confirmed the issue triggers with
>> typical 1536-byte allocations. When len += hole extends the buffer into
>> 3072-4096, page_pool's internal frag_offset stays at 3072, so a
>> subsequent smaller allocation could overlap.
>> Since page_pool manages frag_offset internally and there's no API to
>> advance it past the hole, the fix is to remove the if (hole < len +
>> room) block entirely.
> 
> Well... but this means that fragmentation can waste memory
> which is not accounted for anywhere. Just add an API for this?

I will add a page_pool_frag_offset_add() api in v5 and send the patch.

> 
> 
>>>
>>>
>>>>    	}
>>>> -	virtnet_rq_init_one_sg(rq, buf, len);
>>>> -
>>>>    	ctx = mergeable_len_to_ctx(len + room, headroom);
>>>> -	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
>>>> -	if (err < 0) {
>>>> -		virtnet_rq_unmap(rq, buf, 0);
>>>> -		put_page(virt_to_head_page(buf));
>>>> +
>>>> +	if (rq->use_page_pool_dma) {
>>>> +		addr = page_pool_get_dma_addr(page) + offset;
>>>> +		addr += headroom;
>>>> +
>>>> +		sg_init_table(rq->sg, 1);
>>>> +		sg_fill_dma(rq->sg, addr, len);
>>>> +		err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1,
>>>> +						    buf, ctx, gfp);
>>>> +	} else {
>>>> +		sg_init_one(rq->sg, buf, len);
>>>> +		err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1,
>>>> +					      buf, ctx, gfp);
>>>>    	}
>>>> +	if (err < 0)
>>>> +		page_pool_put_page(rq->page_pool, virt_to_head_page(buf),
>>>> +				   -1, false);
>>>>    	return err;
>>>>    }
>>>> @@ -3128,7 +3088,10 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>>>>    		return err;
>>>>    	err = xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
>>>> -					 MEM_TYPE_PAGE_SHARED, NULL);
>>>> +					 vi->rq[qp_index].page_pool ?
>>>> +						MEM_TYPE_PAGE_POOL :
>>>> +						MEM_TYPE_PAGE_SHARED,
>>>> +					 vi->rq[qp_index].page_pool);
>>>>    	if (err < 0)
>>>>    		goto err_xdp_reg_mem_model;
>>>> @@ -3168,6 +3131,81 @@ static void virtnet_update_settings(struct virtnet_info *vi)
>>>>    		vi->duplex = duplex;
>>>>    }
>>>> +static int virtnet_create_page_pools(struct virtnet_info *vi)
>>>> +{
>>>> +	int i, err;
>>>> +
>>>> +	if (!vi->mergeable_rx_bufs && vi->big_packets)
>>>> +		return 0;
>>>> +
>>>> +	for (i = 0; i < vi->max_queue_pairs; i++) {
>>>> +		struct receive_queue *rq = &vi->rq[i];
>>>> +		struct page_pool_params pp_params = { 0 };
>>>> +		struct device *dma_dev;
>>>> +
>>>> +		if (rq->page_pool)
>>>> +			continue;
>>>> +
>>>> +		if (rq->xsk_pool)
>>>> +			continue;
>>>> +
>>>> +		pp_params.order = 0;
>>>> +		pp_params.pool_size = virtqueue_get_vring_size(rq->vq);
>>>> +		pp_params.nid = dev_to_node(vi->vdev->dev.parent);
>>>> +		pp_params.netdev = vi->dev;
>>>> +		pp_params.napi = &rq->napi;
>>>> +
>>>> +		/* Check if backend supports DMA API (e.g., vhost, virtio-pci).
>>>> +		 * If so, use page_pool's DMA mapping for premapped buffers.
>>>> +		 * Otherwise (e.g., VDUSE), page_pool only handles allocation.
>>>> +		 */
>>>> +		dma_dev = virtqueue_dma_dev(rq->vq);
>>>> +		if (dma_dev) {
>>>> +			pp_params.dev = dma_dev;
>>>> +			pp_params.flags = PP_FLAG_DMA_MAP;
>>>> +			pp_params.dma_dir = DMA_FROM_DEVICE;
>>>> +			rq->use_page_pool_dma = true;
>>>> +		} else {
>>>> +			pp_params.dev = vi->vdev->dev.parent;
>>>> +			pp_params.flags = 0;
>>>> +			rq->use_page_pool_dma = false;
>>>> +		}
>>>> +
>>>> +		rq->page_pool = page_pool_create(&pp_params);
>>>> +		if (IS_ERR(rq->page_pool)) {
>>>> +			err = PTR_ERR(rq->page_pool);
>>>> +			rq->page_pool = NULL;
>>>> +			goto err_cleanup;
>>>> +		}
>>>> +	}
>>>> +	return 0;
>>>> +
>>>> +err_cleanup:
>>>> +	while (--i >= 0) {
>>>> +		struct receive_queue *rq = &vi->rq[i];
>>>> +
>>>> +		if (rq->page_pool) {
>>>> +			page_pool_destroy(rq->page_pool);
>>>> +			rq->page_pool = NULL;
>>>> +		}
>>>> +	}
>>>> +	return err;
>>>> +}
>>>> +
>>>> +static void virtnet_destroy_page_pools(struct virtnet_info *vi)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < vi->max_queue_pairs; i++) {
>>>> +		struct receive_queue *rq = &vi->rq[i];
>>>> +
>>>> +		if (rq->page_pool) {
>>>> +			page_pool_destroy(rq->page_pool);
>>>> +			rq->page_pool = NULL;
>>>> +		}
>>>> +	}
>>>> +}
>>>> +
>>>>    static int virtnet_open(struct net_device *dev)
>>>>    {
>>>>    	struct virtnet_info *vi = netdev_priv(dev);
>>>> @@ -6441,10 +6479,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>>>>    		vi->rq[i].min_buf_len = mergeable_min_buf_len(vi, vi->rq[i].vq);
>>>>    		vi->sq[i].vq = vqs[txq2vq(i)];
>>>>    	}
>>>> -
>>>>    	/* run here: ret == 0. */
>>>> -
>>>>    err_find:
>>>>    	kfree(ctx);
>>>>    err_ctx:
>>>> @@ -6945,6 +6981,14 @@ static int virtnet_probe(struct virtio_device *vdev)
>>>>    			goto free;
>>>>    	}
>>>> +	/* Create page pools for receive queues.
>>>> +	 * Page pools are created at probe time so they can be used
>>>> +	 * with premapped DMA addresses throughout the device lifetime.
>>>> +	 */
>>>> +	err = virtnet_create_page_pools(vi);
>>>> +	if (err)
>>>> +		goto free_irq_moder;
>>>> +
>>>>    #ifdef CONFIG_SYSFS
>>>>    	if (vi->mergeable_rx_bufs)
>>>>    		dev->sysfs_rx_queue_group = &virtio_net_mrg_rx_group;
>>>> @@ -6958,7 +7002,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>>>>    		vi->failover = net_failover_create(vi->dev);
>>>>    		if (IS_ERR(vi->failover)) {
>>>>    			err = PTR_ERR(vi->failover);
>>>> -			goto free_vqs;
>>>> +			goto free_page_pools;
>>>>    		}
>>>>    	}
>>>> @@ -7075,7 +7119,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>>>>    	unregister_netdev(dev);
>>>>    free_failover:
>>>>    	net_failover_destroy(vi->failover);
>>>> -free_vqs:
>>>> +free_page_pools:
>>>> +	virtnet_destroy_page_pools(vi);
>>>> +free_irq_moder:
>>>> +	virtnet_free_irq_moder(vi);
>>>>    	virtio_reset_device(vdev);
>>>>    	free_receive_page_frags(vi);
>>>>    	virtnet_del_vqs(vi);
>>>> @@ -7104,6 +7151,8 @@ static void remove_vq_common(struct virtnet_info *vi)
>>>>    	free_receive_page_frags(vi);
>>>> +	virtnet_destroy_page_pools(vi);
>>>> +
>>>>    	virtnet_del_vqs(vi);
>>>>    }
>>>> -- 
>>>> 2.47.3
>>>
> 


