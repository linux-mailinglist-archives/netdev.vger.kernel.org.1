Return-Path: <netdev+bounces-268134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAWYCizxt2mfXQEAu9opvQ
	(envelope-from <netdev+bounces-268134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:01:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E56299129
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15777300A8FF
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E278A38236E;
	Mon, 16 Mar 2026 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JLpzptbP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC15392831;
	Mon, 16 Mar 2026 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773662320; cv=fail; b=lom/J8mmbFtoUgYLa9/QyiyITzc9HGyrOLFvfaQbbyyFK7Etr+NmxhHAXvGkAE6LwJYE3g38o8YghLX5XAIq8NYuNNZrSrhhdoF6h6tZAvYzC33wxAxZ6xeTkxnk1nCZsWQCb7t6l1KX/6541Ec1UvrvRkZmlP+ek8Dbx3eABbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773662320; c=relaxed/simple;
	bh=0r0ksb86NBcUbGtAzd7cBG/wfY8fh1YcsLOi2P/Wd0c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ek8rA7v6bhlRb6DtiIAnhzQSizENPXNj5Y3eRVM5457KWPY5y92uRiR6HZ+oBz69W5OQKNZ8KGVDbmvOtAwNi5SAws5l/G+12nbdVOrrMxSDQIyJro62hWL5pyHNwjMN12xoY14TeE9rADwohfVLQp6buSfGYDlq8eHxvpn76xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JLpzptbP; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G8ivIF007790;
	Mon, 16 Mar 2026 04:58:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=3PnD/bjD/vv6mbIIzhvYnIhTCjfcSULxonmfaIAu0HU=; b=JLpzptbPqZkj
	ntI6DHMqJmPXpDMG8Oc6Px+41UtfGyML+7lZAHZZ3Jgk54YVj+F97xZY3I59YiAC
	3o/8Xm1iMWGQaW0hLsKbod1szQ5IHaYXYOHnLRV25gAa/AW1EJ32PbugEaJ98tHD
	l9EmD86t9Pa9w89MDRkdYQOhTYsMwJ24HxsZ30Til/MGZIPFeGEU5MlXLkiGRs1s
	6UzNYlWhWGkvigF4wYkPVqpf1DZ7W8A1EY0tVrl+jzjmMkb/zw2CRnpds57+1IR3
	0aIkwLj+ghZdlRhbXRL4k6GOw6S2P630jUTqGkp6hKqRVL+gGxC5uVwI4PuOpmKv
	JU5Q0il3wA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cxeme1tga-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 04:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSFsNZHfMep7xEp1FuiGJ3OSnA5XIUaIfu0SvNki6wA9/f1UilQVsMa+7sJ4Wg4E2ibSgsBD4teE/IyeHY3+y2Peew5uYFpei5zPVBBTBXQqRW/1IIcr2Si+TDYJasO90MrE0Fc2MToms/ca0wf/qXu9n1ONhBjMTuPaC35kjxT2G/bKLhsT+XPVJcyGepormIGHTamJOoN0qEjbc+4V/ijEpuKABvSt+5/27MSVjWhK/jcqQ908mOyqpck10SPGpDt9dXa4SRcvPM9pr2mSgrtKKv4CWLyodjKECj+xKInA3xbEYG4NBQ8frCCkMGcLTHjvCU1CROx7cBYX/mZWUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PnD/bjD/vv6mbIIzhvYnIhTCjfcSULxonmfaIAu0HU=;
 b=LvKAf4JsN7SVM1JV+ILA2OHeGKA60I+lFETYMWiyXCEAv871hznmCG1bkxPisYDNA+nB4bOgd54yEzrLYHNPa8SgevFB9aCO1eWnfE4LGzI5Mow8aTxtfc/FIBAQFkDP5n/e6rYf+jDrkhakPtkKa3evLdkKDp/QYhvFcBigdAXT7h8kw6qn+7amdc0gPGct49fcDcJh5gN2sCiaU8MXJHdasilVFFmzby8uXyz3FFQXP7+8P/LOs97DAXSG0VZEGgwdpwEG+UqpR/fWyKAJEBC2fQ/yTYjHjFKu0f6+QEdpVEJm+Jj1/erRtEslZDzIlIppoQeapwWsGptUgblg6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB3893.namprd15.prod.outlook.com (2603:10b6:5:2b6::17)
 by SJ4PPFF0FFC677F.namprd15.prod.outlook.com (2603:10b6:a0f:fc02::8d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Mon, 16 Mar
 2026 11:58:05 +0000
Received: from DM6PR15MB3893.namprd15.prod.outlook.com
 ([fe80::12c7:cfea:e8a3:9667]) by DM6PR15MB3893.namprd15.prod.outlook.com
 ([fe80::12c7:cfea:e8a3:9667%4]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 11:58:05 +0000
Message-ID: <6d43dbbb-7d04-4442-8743-3963b61195cd@meta.com>
Date: Mon, 16 Mar 2026 17:27:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for buffer
 allocation
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
References: <20260310183107.2822016-1-vishs@meta.com>
 <20260316054232-mutt-send-email-mst@kernel.org>
 <20260316064256-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vishwanath Seshagiri <vishs@meta.com>
In-Reply-To: <20260316064256-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR1501CA0014.namprd15.prod.outlook.com
 (2603:10b6:207:17::27) To DM6PR15MB3893.namprd15.prod.outlook.com
 (2603:10b6:5:2b6::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB3893:EE_|SJ4PPFF0FFC677F:EE_
X-MS-Office365-Filtering-Correlation-Id: 6507f5e0-dee9-426d-601e-08de83534830
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 AqgE1pl+xxyz25VZpTok/hj5Rg2wIxCzRiy6b11vNlhoZmah0zMs90fP4tNHQPRGpTJU/5q1Uk3Owh5WajCKCiNfVt9d2MqMZYbzG/VFm2H3gkglfPxJ029REoYvl9zggTqKBrSR36C9oy1J4CP0v8jxNyhBk5b8wcMiGj/n5E9WTzeSZzd8lmLNKvMPpfYzGDwHvcHsz6qgVBAEbrp/dr+s7hBs/UdwZ3peM8bZaWVfjdwgo+k1zzWSRbeR+SgADXDekn8gRgX0Qcwyq8EIKlu6NapDxLdEeV7yDRNX42hX0HcBfNyxCV8wNfsl++oddA8N/bJKxalqxOkk9actNdENxSOssv2EghZXFSovwlFkW8967SW7Q2RXvLopwc4dsDnvEqgr7O2mKfB+HqV4h6BXTVVGWMKeMp4OkJGs/zyHvpjwy7FsYnRw3dzGRlYkCre7aAwHhXH6SKy3b1tDzh9XC/PFWdKj3cYpPT9CdYtazO2D1IQYOni9hmI7VyUFV3WNKG0Y+qJ8lD3/1mRS4oyktstGGRByFc/OHVlrPTABfKUCSn2x+1Y/yfRgVg69JvhaWk+XSfVqY7GugUQut3LKNTywd+MmI+PnONTcT2qnL3qR/bswGp6/SPRJsRsfJjmRf+KqQgbPvB+ltE+pLOxPlZkZdWlfEcLttzwehVKwnbB8ZlVAmUuoq4cpyRC/XN9yaucx15ItcRL2f2OBkqKEkpszHyT3zY1udGivXNQ=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB3893.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VXptOTJab08waHpsWC80NmZJcjNqUTR6R0J1S1Vnei80a1FLMzJ5Q3ZNVGdS?=
 =?utf-8?B?eHJSWmNBYnhEajZhQ3IxMWdLd3R0Y2dqRE1MUmJxT0d6eW91Nis1RGtuOUty?=
 =?utf-8?B?VU80NlUxOFZ4U2ZmbmlDMDlxaVYvN3J0TzZYMjJpQU9INFpsRXB4eHI2aE9E?=
 =?utf-8?B?TTR1VUZJWW5ycDFZKy9yU0J2d0pTMDdPTzUvOEphZ3d1SStJeVdXOWM2YUx6?=
 =?utf-8?B?Vlk4WndHN2ZIbGN1ZHQrVXJUaEordnpORSs1VlIxVEFMZTlOeDZRcjZFOVZR?=
 =?utf-8?B?M2J5UDhQQ2RsVTNHaWozNHc4d3gvNUpOcnQwNXJQVyt0U3NRa0Z6VlAzOGZR?=
 =?utf-8?B?WmlIZGdTN0I4Z0RRL0grMFpTV0tPTVBoczUzMytSdlEzTEFxNlNpdFFRVmtw?=
 =?utf-8?B?ZDlEY1NMVjNGamIxOEdId09sYUl3QTFjNUZjU3Zmak1icDMyaEFZQll0MS9z?=
 =?utf-8?B?a0tWSisvcUhUeGJZUU82T0JLMDh6Vjk5WExmTkxMWldxdklOWi9WSTJhL2JE?=
 =?utf-8?B?M0JOUnplbmh4T2RSNkhRaG5kUHVVb1F4dW1QckJ6SXZnTWtQUjNYUjZUTTlw?=
 =?utf-8?B?T1J2WDVxeFFtaGdvRTdIZ2tCWVIzSDNOV2lDWG1UMkZHT21NSGVRRkZhdTRE?=
 =?utf-8?B?L3hTdmowNmNpYmVRa25qYkk4ZWp4UysyN21LYW1UdUpWMFlKMHU3T3V4dDhM?=
 =?utf-8?B?LzE5UzVNcDgxUGpaT0J3MnNVRDY3MzR6RlROVFg0ZW9zeWwyUmtnV09vY2Uw?=
 =?utf-8?B?NjMrZGdSV2VZckR6YUpUZjJGYVlHbGhKN1ZUbTlTNTcxY2xLL1didVYwZTNn?=
 =?utf-8?B?L0Jyc2RLaDY0SkdyZ0pZZUdnbWg1bEQ2bTc2bW1EVkJpa2YzUGsweUdYYmxh?=
 =?utf-8?B?UlFxb0RqRUNWTXdGUlQ4eVlxa01jMG8yY3FGbmcwNE1ycnFNZHliZHBrajJi?=
 =?utf-8?B?N29PK0lLNW9qYUl5cnIxa1JQbHo1SWc4R3NjaWQ0ZmhQUWNiOHE4cGcvdnZS?=
 =?utf-8?B?c0cydUtKZVVpTHd0dHk3V2tDQkFIcTBUQXZraXVHMjk2d2x1OGRlMjJYZ1hp?=
 =?utf-8?B?dWZncDFHVDk4cUlCKzFwZHM0UktScjFZV2VUVHZ3YytKOW84bUtxY2JsZ2Yw?=
 =?utf-8?B?b2prcGphWWQ4YjRtaVg3NVQ4dzBlTzdwVENodEN1L1dsUXRzUXdrZmt5QTQw?=
 =?utf-8?B?YTlTM0Z6cXRxeXh2R2phYnJCcmpneEl0UGxvWnlOVmFoMUV2MjJ4ZWJWZDMy?=
 =?utf-8?B?YXpad1MwWmxNTE5iUkVKcUM2RXhuT2x2L2NkQU9OcEhaZVV1TWNKUlVKem9O?=
 =?utf-8?B?NkhzNitzWEU1eDZ5bEUrZWQ2aTlYYU1COFlQK3dSWTNscmZ3SjFKUWU5WEJ0?=
 =?utf-8?B?aFpxZ3lYdWYxR2J2MytWZjFJb3NhcGUvUUVBREJxVmIxUlJuQWY4c2hMV29R?=
 =?utf-8?B?ZnZFazFpOU16anBTOGZGQ0Z0dGtBYXBvcUdqZm1MN21IRlBwWmVMUU1EUVpo?=
 =?utf-8?B?WTNRMkNKMlFNNHNKbmZlS1hVdWw0K3FMN0VTNnlySjdLd1dvRXdwMC9iZU9q?=
 =?utf-8?B?SXYxV3dFZTZ5NDFyNmNhMFJ1aG4xODkyY1VLMzFMcGllalZ6UW05dE9iWkQ1?=
 =?utf-8?B?UkFuT1BmZENwZ3gyVFVUei9CN3dBRmlaWG5vWTVxWFZaOVNnZ0w5NklBUmxM?=
 =?utf-8?B?RFZzWWlqU3FhWm9MUFBxZ2E0aENwcU5tbCtHV1lEMWowbWxYc2VYbGMzYko1?=
 =?utf-8?B?WCtPU3JiYnJESERKdEQwVi8zRFZJaDlOUlJIcGEwSFd3SzdWNXNtdHdWV3pV?=
 =?utf-8?B?VzhiMUZLWGdmNmJhY2cvNE1nd0JKbzRPcndsVTBjekoxTm9CSWdqWGY1VHFv?=
 =?utf-8?B?d205RjF2cUZFVWErZE5meEx1Uktwb2FuZEo5RzhERlJIUjRkRk1vcEZHYzFD?=
 =?utf-8?B?QnRWYUdLNGVqeS9NWlNob2IwNHBMSVFpcUdmU1c3c2wrK1pnMW5QMVNKcmdn?=
 =?utf-8?B?Rndrb1FMZ1lIQ0pMQUJab2k4ckVGY0lNVXZGQ2dwcnVUakdmbkd4YlJDVXp4?=
 =?utf-8?B?NjdBODgwb1F1NzEybGY5eW9TTXhOTXVJMlVJZjNiOEFXS2g0YlBxc0EvOHBQ?=
 =?utf-8?B?NTdDL3FEZ1hhYzBKNUZaZU5lUFp1dTQvVXRUbWtMaEJDOGJTYy9JOVdva1cy?=
 =?utf-8?B?K20xT3BiaDNoV1JPUmZBeUNLRVpZelZRNS93bklzZUVZVWJvbnNEdmFGZlk1?=
 =?utf-8?B?OUZkSC9xZFJ0ODZiKy9MZ3d5ZWhVL0svUURob2lyNm5naERzeUpTWnJPS045?=
 =?utf-8?B?ZFZlcXcxMEg0TFZyRk56dkY2b05EKzczc3VTK2lTK2JPL29mSGlGaVIwYk96?=
 =?utf-8?Q?FzYCJESZqCRudTCg=3D?=
X-Exchange-RoutingPolicyChecked:
	gugr/nLLaauw6eg8BqCqFrLPR7Jqb8UAoWPYNe0RWtHJ9/O3Z0c+hFBA1WMkYz0uEFyjN3KFWF4zeT6hrI+0ygsHFWsAWIcil4Ae4boordzMY7WbjZz4ZZf33beadJsH227MC4tzl4TpmGvqFuLpVUtd+PYdTwd9Q7lgUb6gspCTjVBe+oGW7HV+FnRRNjvYHcfl8rWI3yladgFgMOHQL0hcveaG/t04LJ6eetw3RTcPL8pLe7NqKgiIFnWaTFQTcxSEfieWkvK98WMP2nzgMip0DP/je+OjdHvjsBMLBHTKVtn2+HeI1l73gbQBu3iRb6H56qjjeOst2DJ7yx6NpQ==
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6507f5e0-dee9-426d-601e-08de83534830
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB3893.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 11:58:05.1313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b48oHYtdspw5Wt/jhr7LteHOpi8sOFstyBZUl60mDb0P4TULhO8SAPkc/WcgiQZw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFF0FFC677F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5MSBTYWx0ZWRfX+/BOZo3akDjr
 s3vqLYxVHAh4fNVXevM57SrIG30MP1Xdheq3FhtzBT6BO4ZgXZym0wSV9o+xOpIybxc0x+sg3Uw
 MnatfoipbnJr8brMmFkj7s5HaVRGUiTg2NxoxNcrl3aRS6WXAHD1S9irVTH3SycacPc8vALAVKN
 aE8AWLUonpg02uwddRBjov56jarZIGze/dS1Z8iQ9Lo7xZP7/4mUoFe1tbefkAEFpsfGFBXIMK7
 92mkDqreLLcwUpBWhHrLTihcpLlYrU8puCW2DtVgIJTRUKH7ni6mII8pHHj8JQ4laT4WoPzw/LW
 dTFYh8sZjCnhe11sxJyFIgEvXdlJgzjurVnE2AHux5/hIy7oW5wO9FZxdOT9aUhYW3bb5hu1hSm
 gC3rV44p977FmPeq4U6gDiNKulh4wePWiw0Xc7H5gmZ5nCgWtLT/ioVY9hvrcFMk9MVsbdZ5t67
 YKidc8kKsIM1aCQkA2A==
X-Authority-Analysis: v=2.4 cv=N9Uk1m9B c=1 sm=1 tr=0 ts=69b7f052 cx=c_pps
 a=CjRpyDoPu1ZhyeacGh9KdQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=xV6hwiu3NnXKRggssh0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 06uYE5e25dfaDH_sJLR0utnewFZrZbS1
X-Proofpoint-GUID: 06uYE5e25dfaDH_sJLR0utnewFZrZbS1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268134-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:dkim,meta.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 86E56299129
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 4:13 PM, Michael S. Tsirkin wrote:
> On Mon, Mar 16, 2026 at 05:56:20AM -0400, Michael S. Tsirkin wrote:
>> On Tue, Mar 10, 2026 at 11:31:04AM -0700, Vishwanath Seshagiri wrote:
>>> @@ -5857,7 +5863,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
>>>   	/* In big_packets mode, xdp cannot work, so there is no need to
>>>   	 * initialize xsk of rq.
>>>   	 */
>>> -	if (vi->big_packets && !vi->mergeable_rx_bufs)
>>> +	if (!vi->rq[qid].page_pool)
>>>   		return -ENOENT;
>>>   
>>>   	if (qid >= vi->curr_queue_pairs)
>>
>>
>>
>> It seems that a qid that exceeds curr_queue_pairs would previously get
>> -EINVAL and now gets -ENOENT.
> 
> Or maybe this if (qid >= vi->curr_queue_pairs) is dead code?
> I looked at it some more and I can't find a path where this
> triggers.
> 
>> Maybe reorder the checks:
>>
>>          if (qid >= vi->curr_queue_pairs)
>>                  return -EINVAL;
>>
>>          /* In big_packets mode, xdp cannot work, so there is no need to
>>           * initialize xsk of rq.
>>           */
>>         if (!vi->rq[qid].page_pool)
>>                 return -ENOENT;
>>
>>
>> Alternatively I think we can completely drop this chunk: we already seem
>> to init page_pull at all times except for big packets mode, so the
>> current code is fine I think.

Yes, I agree qid >= curr_queue_pairs appears to be dead code.
xsk_reg_pool_at_qid() in the XSK core already validates
queue_id < max(real_num_rx_queues, real_num_tx_queues) before
ndo_bpf is called, and real_num_rx_queues == curr_queue_pairs is an
invariant in virtio_net. Both paths hold rtnl_lock so no race is
possible. That said, I'll adopt your suggested reorder for v12 to ensure
vi->rq[qid] isn't accessed before a bounds check, even if the check
is currently redundant.

>>
>>
>> -- 
>> MST
> 


