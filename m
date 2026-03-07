Return-Path: <netdev+bounces-265147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEP+McI9rGmWngEAu9opvQ
	(envelope-from <netdev+bounces-265147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 16:01:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F292222C412
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 16:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45126303A8CD
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 15:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1310C319843;
	Sat,  7 Mar 2026 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EIndN1Nc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0A72D77F7;
	Sat,  7 Mar 2026 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772895672; cv=fail; b=JfgDwh06+fDN3iwVBw060H2veTzMTAClwyXj3vvMqzVS8D/xYcv/fM9NPi3kRnq3uyn/7ZeQqMtUTpgs2esR8hz/asriGShX7fKXE890/uxS52mfyDxPcC7rLjbV+mCLKD8JoFkBV990wrE1K1x2F4n2XahiQt/7PVbxvbtEBkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772895672; c=relaxed/simple;
	bh=bOxa8rfjNwkBj9n84ddMb5wvzyjPdJUfeRGsrbItc04=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WW3iSP//yRnvvV2++Ft/ZL29L4gloUcCcmZ6T7485RGOOvxrBVtALWjprVYcshrUzA26Ke99S6cwjOfV7r6y4OTC+/2a83JztuLJAtQf9Lk14cehqfT/9V9Zj99lw0LvsHTKR8ejd/0p9MfVf6wj3WZ9oMh09v1jjmvF9OJpzls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EIndN1Nc; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 627A7eIA358800;
	Sat, 7 Mar 2026 07:00:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ieFD1eWJiPsFYZcJ2dThV0CUsutCA0L+uAMf3IbEelc=; b=EIndN1NchgPy
	zrDqvrNMWfaqZtKoXq3UGuPrzD+nJ1S4pulFXtzvQPOMLh4lszr/LmEUtMTeB2rp
	D+NYSiK9g/JFgKFjJ61zOi22p6vPsaW0FfLli09uWdKJaUcGfkv6p1N3eReYHXzr
	nN73+BnDBxILtLDRlt81Ompc5EPvjBOL04tdMf9UB1l24CrHOrrUzn5Py1ilU90A
	MnzEYo+hTLjCSy7XOvaXS8MVNbgAy7iZ+xbhhnjSQb4UktoHyzMI0covmWgm6RYS
	UP263CgwfxWcCq1F+pfTxWk28ChelgzrZA7yGao8TRjm4SzRSXXz0uBk+vkDwDbf
	uc7gQZZeoQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011013.outbound.protection.outlook.com [52.101.57.13])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4crj099btn-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 07 Mar 2026 07:00:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BezTUCNzd1SVLJxeetVZ4zRaRmdZPRgWQ59H4kNPUq/z0oHFk5eB/HT+4e/Lhf/RnWUuDbLFu6j8dHm4BRnY1ShCEAMKHLDGdLjYUkiqVnc8RG1HLTe4be+xjYtMdEWkviRPkUeYnNRqnA2OLQlCsq/5wgFpOodTO/NgGQzyzoLBx+fP+E2NloybN+0SXcQ6RGHz4pPYfk0vLkezcqAGOBHpc3JoyNToepwYm3qILd4D3+PTdLjapFCNRmTJkW81AVwg9CBlbaeSY6XysDg1MG2EIWTrbkyQUb9LISWJFpSM9AZvYt+eWbjxjeleCnbrU8je/vCu8AP+eVlzJoqfDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieFD1eWJiPsFYZcJ2dThV0CUsutCA0L+uAMf3IbEelc=;
 b=uSpr974m7qaasgPdo18Gw5jxRLOkbwdODT948TzZYq0mGR3NHokBnHjPu1FCwPskixCbEMR0F8tU0uVBc5PeEmGjRezj4iGdrxeK2Qea2K1WjQzNWCFCFBlIPzrDxwrGvldvhXbwMPb6kQVrxaS9fP/jRMwm3DLwJFOFzwWVpuwLtoeN+BIcDw7cuIeSs62EVz3SlHfDqn47c42WS1nha/u8Qyy70jQaU9M6SH22AFHpniRlVEViPCukSWOVkal8qRlAfbx+zSyueSp3h7uw6aiQO4a/A7OwjOkwn7lOW1lB3LYsd6PbnwiQaxhhm+vavwCLUNQP6UNY6/AdbCNrJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB3893.namprd15.prod.outlook.com (2603:10b6:5:2b6::17)
 by PH0PR15MB5238.namprd15.prod.outlook.com (2603:10b6:510:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.7; Sat, 7 Mar
 2026 15:00:34 +0000
Received: from DM6PR15MB3893.namprd15.prod.outlook.com
 ([fe80::12c7:cfea:e8a3:9667]) by DM6PR15MB3893.namprd15.prod.outlook.com
 ([fe80::12c7:cfea:e8a3:9667%4]) with mapi id 15.20.9700.003; Sat, 7 Mar 2026
 15:00:34 +0000
Message-ID: <011f89d3-8d66-4547-92d2-e685a3a7f441@meta.com>
Date: Sat, 7 Mar 2026 20:30:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10] virtio_net: add page_pool support for buffer
 allocation
From: Vishwanath Seshagiri <vishs@meta.com>
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
References: <20260303074253.3449987-1-vishs@meta.com>
 <20260305073638-mutt-send-email-mst@kernel.org>
 <fc4e8dcf-ba26-4170-9405-eb4a2728d92f@meta.com>
Content-Language: en-US
In-Reply-To: <fc4e8dcf-ba26-4170-9405-eb4a2728d92f@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0176.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::17) To DM6PR15MB3893.namprd15.prod.outlook.com
 (2603:10b6:5:2b6::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB3893:EE_|PH0PR15MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: 6122043e-1f12-47ce-82ca-08de7c5a4888
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
 G2lTKm0kZBaGVS9o4DARpdStpixwcS92oYu5Wm1xIruraNwAqWlEITiUW2eiUYIfxBvBL6hh+lxoJKb67M/cTr0upxjlhk6vBZlDHGfq/66z21+ZOkWpCrQ7NiIGY924yh2RC/TSpqm+gfhjU06gAHHAeXJwnszaZzlyjk+OkqehUu3/e/AtjScbIrjb5KnaMlztexQypj5ofpk3rLOBvpV9DCS8Zn8WTafTWxKj2cdM7XUgqqrO7zMS9VXwkun4I0ZTocFghI7ebuQF1B+vHESOUi4H8O+txM+Wwn0GkgmigQi64oVxJZPYQA3FQbprYcCLtHZTP1+gO8a2uada9a21JvMHNdR1UcX0QxoLg/XnoQswItFh2Hyd03oJ9727sgrJ6vqtrfXlVyL01GU5obvq91K7dI+qUyKHcMFaPACQYfBaS5lvxnEh2e18EzvaGB68NkOynsx25cdQyza5nOptEpWrPv+iEZem4jqJYMf+rJF3m1QfugaScMY8xEzknmyixCYxxFmn/3OHkAwaFQJ6c0lgN01yIdfMqdB9ASUPV9S4WDjTfDYeYdfQZ2qoP0VMr/ZCHy2b5Sv3v71ok+W5TZlVU5mWFocgqRLnlTB8VeLVI/jroB5IqdnaF8cQhFaZeRKxzvSuJYCtv2xS47XsO6ZcfcTjn4feBg9yKPZGJanaoF5ttQG0TIJTAJot
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB3893.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aDBJK0V0VnMvaXFQVGR0TjJXUWpKd2Erc20vZmwzWWt3dmhlSWJ3OWNob2lq?=
 =?utf-8?B?Q2VaRUM2Yi9idDBzN3NSZE4xQ3B5YWVud0JWOU5iMjV6RXZDUVRtWGFBRGZi?=
 =?utf-8?B?RkR0UExXOE5sK3RENms4QVFNeHh2S0pJL0tCOFY1ckF4emRWSmgrd1JHTDNp?=
 =?utf-8?B?cnloSTBMOXdHSWNUeE5zbmo4bmgzaWlkeG5ET0xXMlFIYXdRWUs2WW1IeXR4?=
 =?utf-8?B?TnFxR0lBQzZBS3FETXphQ01Ec3NKSmZ2Z3lDWjljUUtzV2J5M0NNVk11SUF3?=
 =?utf-8?B?NUwranJCTzJlYXo3bWxQbFhHUGpXaFFid1N6Rk5XOTZNU1BTczRnMGdsQWlR?=
 =?utf-8?B?NWxyRzNkVjNjUDFHK1o5OHIrT2M1Y1A2TDdhNXc3N3dNZG9PMGJnRXNvd3Nu?=
 =?utf-8?B?eVdaeEZMQWN4SUJDZ2lSVDRFRW56alc1T0dNcCtVbGpVZW5WRGh2S1dWQUpt?=
 =?utf-8?B?QktwTDVyZWFpa0VkNFZlQjF6NFFPOUlXcXhVSGdhd3A1bDBqUUpkL2dlUWV2?=
 =?utf-8?B?dXZiSkZSU1l0YjFLUUxQOSs5cWFIOU92UXRsUVhZSjVEUFpvOU4xUHVYSDA2?=
 =?utf-8?B?SE5tbmNkY1hVdmgreW9KZmtuU2F3dUlUZmlxampZOEswaWZ0UjJZdC9rVVRU?=
 =?utf-8?B?cWxiVUxsRlJ2dy9ybGhJcGxjTEpsZUNmL2RNalVKbUE4VHpQUC9jQitDNUFJ?=
 =?utf-8?B?d2lMSTVCYlQ4c3N3MG8vckRhdk14NUsxVkpLdVUzaHBlNDJvSG40T1FkTE44?=
 =?utf-8?B?MGdQRi9WMzU0U29kNE9ENjZTcWJlWGtGNmZkQlBhZ1pwRUFmdUEweFRIUEpZ?=
 =?utf-8?B?Y0NOQzJDTmQ0OUNzUllOLzlhVGxxMmExTk4vdzdMa1RleU9GZW5KMVBvV2wz?=
 =?utf-8?B?cDM4NTJYZVR2NG9LSEZBYWk0VnI1VTdDOGJ2WHZ5TlhVN2FpUlBTanVmWFRs?=
 =?utf-8?B?c3Nkc2FLcTFOSUhockdmK05BVzlaK0Jjc215c0RUcFRCYXlZNEJLUElvdHJN?=
 =?utf-8?B?aG9QSjlDYUFOR1hVMmVHS0JseERVWlRBYXZxNVdlMHhDVU95ZnRqM0szUk1q?=
 =?utf-8?B?RDZpb3F4Zi9yRWw3bDdQRDdiN3hCRENaVnBWZlZzNFF6bVFKMzlrb0pHUjZv?=
 =?utf-8?B?eUdlOWdHSEpseHFXOExkTy9BcDRCbzhIa1lPUTNiZzFVTkdQMTUzMmJWTmNi?=
 =?utf-8?B?MitjUlJyKzRRazRaWGlmMmFCSGtrWkdJemVzVGJhZ3paRkZJMVBmemQ3NEhC?=
 =?utf-8?B?SVU2aWduUG1laGhvczh0L0RJR2NYRnVCa0xQNWZhdHc0ZTJXWnNnU0thOSta?=
 =?utf-8?B?bVVOTUR3NXROYmhGTG9PU2lCQkl1N0dGSkZnek9ydktBUmNOZ0w3eGx3SkRK?=
 =?utf-8?B?VWdNUU04YTVmUE9RekUxc1UyeXFJVlkzV1luNmxMYjZ3anI0QkROVFpoTkxP?=
 =?utf-8?B?WFhpQUFBYytyeWFYRFhWd1dLbWN0bTlYZWFWa2RzM01ZcXlWTWpxam0wb29M?=
 =?utf-8?B?c00wUE5hOTlBOUVMVHdTLzhPSzRHc2cwbHRWcVhCZTZ5S3dCOTRZSkJiRDg3?=
 =?utf-8?B?TEhFelhBWlRhbGRqbldxV3AwS1gzNG9EbUpDUjVSaVZWcG1ZYWNDUWh5em9x?=
 =?utf-8?B?ZjY2WmVCeUNXVE14VzRyZWhucS8wc0R4aWJyRjhWaHBMVVF5bXJ4WWh2YkY0?=
 =?utf-8?B?Rlh1TkZUTFRPZnZrVTMyRWdNM0NDcnl2VE10VHlGcVlvOGpBdGV6TWlQakU2?=
 =?utf-8?B?dURHeS94eXYvUmpUZ1AwUjNUdGtlZ1RYaGVpKzhYN05UaDFvOUhMcGd6NFVC?=
 =?utf-8?B?OHBDS2MxOWR1cmphVXU2b3RUSGUwQzF1TmVyWmhWaVdadlg4b1ZkSVM3YklP?=
 =?utf-8?B?QWNSa3ZlOTl5UTV1eVQzRjJ3MkhMOUFwS3FrWUwydkFrcFhtcDJLQUF4TU40?=
 =?utf-8?B?UXVCTjJwTEF0V0lXK0FLVURLOERaNWczYVdwbS9nZjNJc0JPZFFRQXVxcUV1?=
 =?utf-8?B?QksrcStGNjE1K3pZL2h4NjRwME9vSW56NWhNTndrTXp3NFdHVlVaMDdxR0VR?=
 =?utf-8?B?Z0JFaUtVeVVORkpWWHpQdFlqbzI1Nm9iOHNYSzB5SzIyZENFZ0hsYzdVSC9r?=
 =?utf-8?B?RHVxNG4xdldUVGcwUDMyMjVhMElUUUJZSDNxKzh5ZkZ4VUpYVWNBcXJNQzJp?=
 =?utf-8?B?YStZQ1lrbnJ2azdxWmNHblZEU2ZLKzhjUHltQlNtYjBmeUcxcVFJanRWUlZw?=
 =?utf-8?B?UllNd2Zxd01YU0psS3kwajdnaVJ4VXRrdEt3S2U3d0tuOFVCcWJ6eFFnc1F2?=
 =?utf-8?Q?B4OqMBtyBo6vBWjjAf?=
X-Exchange-RoutingPolicyChecked:
	kth/I2owmt5lgRVtzWBAgAVlLwhuBOA3yrV9y6FoSGb2xlSVm4mRR2SeHXs0lKyYvvlgO+FJi4Mh94NqsDLBH74HAFh8MZ2uRWqZn2UhiabJljZZe3nUCJNxEN0EkBrUcPseMIGMq5Gni4lxe8V0qsQ9uhxTfROToCpUkQi/UA1rBKdnvc5D8E2ZjgGfafYhXkxb6kfRNLzOiq5OPtElJYqtu/BzrXXYNxlSCcJGxYK8l8Ocw2OIH5LgwgbYYb8vdAmXVjIOepAyF3OJczp5/6sZ4APZvzEJQryiZsp0MWoBe+yz27mLw4B/cEerVwG9WOfp8n0jgOqt6wBWBXyutQ==
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6122043e-1f12-47ce-82ca-08de7c5a4888
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB3893.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 15:00:34.2952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJDEhjHs47G6DQ+9cUjhNOscR2IFa/Il9OqxHPqkVv8jCmRSK/3C8vEc6yUW6mns
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5238
X-Proofpoint-ORIG-GUID: vm1w-t45Pj2-Fww9QHol-qkjJABICpn7
X-Authority-Analysis: v=2.4 cv=T4GBjvKQ c=1 sm=1 tr=0 ts=69ac3d96 cx=c_pps
 a=g4bHFsidlxN+L/prI/sWbA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=grV1kQxFQDfxUPLecMkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0MiBTYWx0ZWRfXz8EAPPP+VEOr
 4Od/EpTUz/S+o7jyRAyweYuzshMVrJvY4wZUbCGkcSEf4nv9g8iP730Y60kL0pm9DGyGxI02vZN
 Mh7WU323IRss+bDHMVp8o0Dz7cpQtehdJTpoVX2rv6vtDHy75O1Bv41duImGiqK9hEkTXAkzKJv
 /RoBzJMnNwkRB+IObpkv5AB1+KsgblZsCbDbu74wBLeuTefO5dM/ClCYmBSC7+crmwjSbvZcjkb
 FJi3XFTKbwMXWmSjUM/iQSlVNkFWq9NOZrB/3YAMDt9YljksuuHoGlB+RaHoKsoVrR0EM1yqxMW
 iA07l0I9837f6emD457sv7tmZSRg0y85ZobWfiL6o7X/BPxqHxFLuM9obYMqH/RNXymCMAUD8t/
 6absIbTfpZgZan8kdlTgEbXWW+EUdw+d97NergZrNdsrxrfSPzwD8WgCjcdYxc0iVwGSthk0wyz
 oRvePcyO5coAd73uKGQ==
X-Proofpoint-GUID: vm1w-t45Pj2-Fww9QHol-qkjJABICpn7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Rspamd-Queue-Id: F292222C412
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
	TAGGED_FROM(0.00)[bounces-265147-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:dkim,meta.com:email,meta.com:mid];
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
X-Rspamd-Action: no action



On 3/7/26 7:36 PM, Vishwanath Seshagiri wrote:
> 
> 
> On 3/5/26 6:08 PM, Michael S. Tsirkin wrote:
>> On Mon, Mar 02, 2026 at 11:42:53PM -0800, Vishwanath Seshagiri wrote:
>>> Use page_pool for RX buffer allocation in mergeable and small buffer
>>> modes to enable page recycling and avoid repeated page allocator calls.
>>> skb_mark_for_recycle() enables page reuse in the network stack.
>>>
>>> Big packets mode is unchanged because it uses page->private for linked
>>> list chaining of multiple pages per buffer, which conflicts with
>>> page_pool's internal use of page->private.
>>>
>>> Implement conditional DMA premapping using virtqueue_dma_dev():
>>> - When non-NULL (vhost, virtio-pci): use PP_FLAG_DMA_MAP with page_pool
>>>    handling DMA mapping, submit via virtqueue_add_inbuf_premapped()
>>> - When NULL (VDUSE, direct physical): page_pool handles allocation only,
>>>    submit via virtqueue_add_inbuf_ctx()
>>>
>>> This preserves the DMA premapping optimization from commit 31f3cd4e5756b
>>> ("virtio-net: rq submits premapped per-buffer") while adding page_pool
>>> support as a prerequisite for future zero-copy features (devmem TCP,
>>> io_uring ZCRX).
>>>
>>> Page pools are created in probe and destroyed in remove (not open/ 
>>> close),
>>> following existing driver behavior where RX buffers remain in virtqueues
>>> across interface state changes.
>>>
>>> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
>>> ---
>>> Changes in v10:
>>> - add_recvbuf_small: use alloc_len to avoid clobbering len (Michael 
>>> S. Tsirkin)
>>
>> this was not my comment though?
> 
> Apologies! I misunderstood the comment as a variable naming issue
> than truesize under accounting.
> 
>>
>>> - v9:
>>>    https://lore.kernel.org/virtualization/20260302041005.1627210-1- 
>>> vishs@meta.com/
>>>
>>> Changes in v9:
>>> - Fix virtnet_skb_append_frag() for XSK callers (Michael S. Tsirkin)
>>> - v8:
>>>    https://lore.kernel.org/virtualization/e824c5a3-cfe0-4d11-958f- 
>>> c3ec82d11d37@meta.com/
>>>
>>> Changes in v8:
>>> - Remove virtnet_no_page_pool() helper, replace with direct !rq- 
>>> >page_pool
>>>    checks or inlined conditions (Xuan Zhuo)
>>> - Extract virtnet_rq_submit() helper to consolidate DMA/non-DMA buffer
>>>    submission in add_recvbuf_small() and add_recvbuf_mergeable()
>>> - Add skb_mark_for_recycle(nskb) for overflow frag_list skbs in
>>>    virtnet_skb_append_frag() to ensure page_pool pages are returned to
>>>    the pool instead of freed via put_page()
>>> - Rebase on net-next (kzalloc_objs API)
>>> - v7:
>>>    https://lore.kernel.org/virtualization/20260210014305.3236342-1- 
>>> vishs@meta.com/
>>>
>>> Changes in v7:
>>> - Replace virtnet_put_page() helper with direct page_pool_put_page()
>>>    calls (Xuan Zhuo)
>>> - Add virtnet_no_page_pool() helper to consolidate big_packets mode 
>>> check
>>>    (Michael S. Tsirkin)
>>> - Add DMA sync_for_cpu for subsequent buffers in xdp_linearize_page() 
>>> when
>>>    use_page_pool_dma is set (Michael S. Tsirkin)
>>> - Remove unused pp_params.dev assignment in non-DMA path
>>> - Add page pool recreation in virtnet_restore_up() for freeze/restore 
>>> support (Chris Mason's
>>> Review Prompt)
>>> - v6:
>>>    https://lore.kernel.org/virtualization/20260208175410.1910001-1- 
>>> vishs@meta.com/
>>>
>>> Changes in v6:
>>> - Drop page_pool_frag_offset_add() helper and switch to 
>>> page_pool_alloc_va();
>>>    page_pool_alloc_netmem() already handles internal fragmentation 
>>> internally
>>>    (Jakub Kicinski)
>>> - v5:
>>>    https://lore.kernel.org/virtualization/20260206002715.1885869-1- 
>>> vishs@meta.com/
>>>
>>> Benchmark results:
>>>
>>> Configuration: pktgen TX -> tap -> vhost-net | virtio-net RX -> XDP_DROP
>>>
>>> Small packets (64 bytes, mrg_rxbuf=off):
>>>    1Q:  853,493 -> 868,923 pps  (+1.8%)
>>>    2Q: 1,655,793 -> 1,696,707 pps (+2.5%)
>>>    4Q: 3,143,375 -> 3,302,511 pps (+5.1%)
>>>    8Q: 6,082,590 -> 6,156,894 pps (+1.2%)
>>>
>>> Mergeable RX (64 bytes):
>>>    1Q:   766,168 ->   814,493 pps  (+6.3%)
>>>    2Q: 1,384,871 -> 1,670,639 pps (+20.6%)
>>>    4Q: 2,773,081 -> 3,080,574 pps (+11.1%)
>>>    8Q: 5,600,615 -> 6,043,891 pps  (+7.9%)
>>>
>>> Mergeable RX (1500 bytes):
>>>    1Q:   741,579 ->   785,442 pps  (+5.9%)
>>>    2Q: 1,310,043 -> 1,534,554 pps (+17.1%)
>>>    4Q: 2,748,700 -> 2,890,582 pps  (+5.2%)
>>>    8Q: 5,348,589 -> 5,618,664 pps  (+5.0%)
>>>
>>>   drivers/net/Kconfig      |   1 +
>>>   drivers/net/virtio_net.c | 466 ++++++++++++++++++++-------------------
>>>   2 files changed, 237 insertions(+), 230 deletions(-)
>>>
>>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>>> index 17108c359216..b2fd90466bab 100644
>>> --- a/drivers/net/Kconfig
>>> +++ b/drivers/net/Kconfig
>>> @@ -452,6 +452,7 @@ config VIRTIO_NET
>>>       depends on VIRTIO
>>>       select NET_FAILOVER
>>>       select DIMLIB
>>> +    select PAGE_POOL
>>>       help
>>>         This is the virtual network driver for virtio.  It can be 
>>> used with
>>>         QEMU based VMMs (like KVM or Xen).  Say Y or M.
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index 72d6a9c6a5a2..d722031604bf 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -26,6 +26,7 @@
>>>   #include <net/netdev_rx_queue.h>
>>>   #include <net/netdev_queues.h>
>>>   #include <net/xdp_sock_drv.h>
>>> +#include <net/page_pool/helpers.h>
>>>   static int napi_weight = NAPI_POLL_WEIGHT;
>>>   module_param(napi_weight, int, 0444);
>>> @@ -290,14 +291,6 @@ struct virtnet_interrupt_coalesce {
>>>       u32 max_usecs;
>>>   };
>>> -/* The dma information of pages allocated at a time. */
>>> -struct virtnet_rq_dma {
>>> -    dma_addr_t addr;
>>> -    u32 ref;
>>> -    u16 len;
>>> -    u16 need_sync;
>>> -};
>>> -
>>>   /* Internal representation of a send virtqueue */
>>>   struct send_queue {
>>>       /* Virtqueue associated with this send _queue */
>>> @@ -356,8 +349,10 @@ struct receive_queue {
>>>       /* Average packet length for mergeable receive buffers. */
>>>       struct ewma_pkt_len mrg_avg_pkt_len;
>>> -    /* Page frag for packet buffer allocation. */
>>> -    struct page_frag alloc_frag;
>>> +    struct page_pool *page_pool;
>>> +
>>> +    /* True if page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
>>> +    bool use_page_pool_dma;
>>>       /* RX: fragments + linear part + virtio header */
>>>       struct scatterlist sg[MAX_SKB_FRAGS + 2];
>>> @@ -370,9 +365,6 @@ struct receive_queue {
>>>       struct xdp_rxq_info xdp_rxq;
>>> -    /* Record the last dma info to free after new pages is 
>>> allocated. */
>>> -    struct virtnet_rq_dma *last_dma;
>>> -
>>>       struct xsk_buff_pool *xsk_pool;
>>>       /* xdp rxq used by xsk */
>>> @@ -521,11 +513,14 @@ static int virtnet_xdp_handler(struct bpf_prog 
>>> *xdp_prog, struct xdp_buff *xdp,
>>>                      struct virtnet_rq_stats *stats);
>>>   static void virtnet_receive_done(struct virtnet_info *vi, struct 
>>> receive_queue *rq,
>>>                    struct sk_buff *skb, u8 flags);
>>> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff 
>>> *head_skb,
>>> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue 
>>> *rq,
>>> +                           struct sk_buff *head_skb,
>>>                              struct sk_buff *curr_skb,
>>>                              struct page *page, void *buf,
>>>                              int len, int truesize);
>>>   static void virtnet_xsk_completed(struct send_queue *sq, int num);
>>> +static void free_unused_bufs(struct virtnet_info *vi);
>>> +static void virtnet_del_vqs(struct virtnet_info *vi);
>>>   enum virtnet_xmit_type {
>>>       VIRTNET_XMIT_TYPE_SKB,
>>> @@ -709,12 +704,10 @@ static struct page *get_a_page(struct 
>>> receive_queue *rq, gfp_t gfp_mask)
>>>   static void virtnet_rq_free_buf(struct virtnet_info *vi,
>>>                   struct receive_queue *rq, void *buf)
>>>   {
>>> -    if (vi->mergeable_rx_bufs)
>>> -        put_page(virt_to_head_page(buf));
>>> -    else if (vi->big_packets)
>>> +    if (!rq->page_pool)
>>>           give_pages(rq, buf);
>>>       else
>>> -        put_page(virt_to_head_page(buf));
>>> +        page_pool_put_page(rq->page_pool, virt_to_head_page(buf), 
>>> -1, false);
>>>   }
>>>   static void enable_rx_mode_work(struct virtnet_info *vi)
>>> @@ -876,10 +869,16 @@ static struct sk_buff *page_to_skb(struct 
>>> virtnet_info *vi,
>>>           skb = virtnet_build_skb(buf, truesize, p - buf, len);
>>>           if (unlikely(!skb))
>>>               return NULL;
>>> +        /* Big packets mode chains pages via page->private, which is
>>> +         * incompatible with the way page_pool uses page->private.
>>> +         * Currently, big packets mode doesn't use page pools.
>>> +         */
>>> +        if (!rq->page_pool) {
>>> +            page = (struct page *)page->private;
>>> +            if (page)
>>> +                give_pages(rq, page);
>>> +        }
>>> -        page = (struct page *)page->private;
>>> -        if (page)
>>> -            give_pages(rq, page);
>>>           goto ok;
>>>       }
>>> @@ -925,133 +924,16 @@ static struct sk_buff *page_to_skb(struct 
>>> virtnet_info *vi,
>>>       hdr = skb_vnet_common_hdr(skb);
>>>       memcpy(hdr, hdr_p, hdr_len);
>>>       if (page_to_free)
>>> -        put_page(page_to_free);
>>> +        page_pool_put_page(rq->page_pool, page_to_free, -1, true);
>>>       return skb;
>>>   }
>>> -static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, 
>>> u32 len)
>>> -{
>>> -    struct virtnet_info *vi = rq->vq->vdev->priv;
>>> -    struct page *page = virt_to_head_page(buf);
>>> -    struct virtnet_rq_dma *dma;
>>> -    void *head;
>>> -    int offset;
>>> -
>>> -    BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>>> -
>>> -    head = page_address(page);
>>> -
>>> -    dma = head;
>>> -
>>> -    --dma->ref;
>>> -
>>> -    if (dma->need_sync && len) {
>>> -        offset = buf - (head + sizeof(*dma));
>>> -
>>> -        virtqueue_map_sync_single_range_for_cpu(rq->vq, dma->addr,
>>> -                            offset, len,
>>> -                            DMA_FROM_DEVICE);
>>> -    }
>>> -
>>> -    if (dma->ref)
>>> -        return;
>>> -
>>> -    virtqueue_unmap_single_attrs(rq->vq, dma->addr, dma->len,
>>> -                     DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
>>> -    put_page(page);
>>> -}
>>> -
>>>   static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, 
>>> void **ctx)
>>>   {
>>> -    struct virtnet_info *vi = rq->vq->vdev->priv;
>>> -    void *buf;
>>> -
>>> -    BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>>> -
>>> -    buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
>>> -    if (buf)
>>> -        virtnet_rq_unmap(rq, buf, *len);
>>> -
>>> -    return buf;
>>> -}
>>> -
>>> -static void virtnet_rq_init_one_sg(struct receive_queue *rq, void 
>>> *buf, u32 len)
>>> -{
>>> -    struct virtnet_info *vi = rq->vq->vdev->priv;
>>> -    struct virtnet_rq_dma *dma;
>>> -    dma_addr_t addr;
>>> -    u32 offset;
>>> -    void *head;
>>> -
>>> -    BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>>> -
>>> -    head = page_address(rq->alloc_frag.page);
>>> -
>>> -    offset = buf - head;
>>> -
>>> -    dma = head;
>>> -
>>> -    addr = dma->addr - sizeof(*dma) + offset;
>>> -
>>> -    sg_init_table(rq->sg, 1);
>>> -    sg_fill_dma(rq->sg, addr, len);
>>> -}
>>> -
>>> -static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, 
>>> gfp_t gfp)
>>> -{
>>> -    struct page_frag *alloc_frag = &rq->alloc_frag;
>>> -    struct virtnet_info *vi = rq->vq->vdev->priv;
>>> -    struct virtnet_rq_dma *dma;
>>> -    void *buf, *head;
>>> -    dma_addr_t addr;
>>> -
>>> -    BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>>> -
>>> -    head = page_address(alloc_frag->page);
>>> -
>>> -    dma = head;
>>> -
>>> -    /* new pages */
>>> -    if (!alloc_frag->offset) {
>>> -        if (rq->last_dma) {
>>> -            /* Now, the new page is allocated, the last dma
>>> -             * will not be used. So the dma can be unmapped
>>> -             * if the ref is 0.
>>> -             */
>>> -            virtnet_rq_unmap(rq, rq->last_dma, 0);
>>> -            rq->last_dma = NULL;
>>> -        }
>>> -
>>> -        dma->len = alloc_frag->size - sizeof(*dma);
>>> -
>>> -        addr = virtqueue_map_single_attrs(rq->vq, dma + 1,
>>> -                          dma->len, DMA_FROM_DEVICE, 0);
>>> -        if (virtqueue_map_mapping_error(rq->vq, addr))
>>> -            return NULL;
>>> -
>>> -        dma->addr = addr;
>>> -        dma->need_sync = virtqueue_map_need_sync(rq->vq, addr);
>>> -
>>> -        /* Add a reference to dma to prevent the entire dma from
>>> -         * being released during error handling. This reference
>>> -         * will be freed after the pages are no longer used.
>>> -         */
>>> -        get_page(alloc_frag->page);
>>> -        dma->ref = 1;
>>> -        alloc_frag->offset = sizeof(*dma);
>>> -
>>> -        rq->last_dma = dma;
>>> -    }
>>> -
>>> -    ++dma->ref;
>>> -
>>> -    buf = head + alloc_frag->offset;
>>> -
>>> -    get_page(alloc_frag->page);
>>> -    alloc_frag->offset += size;
>>> +    BUG_ON(!rq->page_pool);
>>> -    return buf;
>>> +    return virtqueue_get_buf_ctx(rq->vq, len, ctx);
>>>   }
>>>   static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>>> @@ -1067,9 +949,6 @@ static void virtnet_rq_unmap_free_buf(struct 
>>> virtqueue *vq, void *buf)
>>>           return;
>>>       }
>>> -    if (!vi->big_packets || vi->mergeable_rx_bufs)
>>> -        virtnet_rq_unmap(rq, buf, 0);
>>> -
>>>       virtnet_rq_free_buf(vi, rq, buf);
>>>   }
>>> @@ -1335,7 +1214,7 @@ static int xsk_append_merge_buffer(struct 
>>> virtnet_info *vi,
>>>           truesize = len;
>>> -        curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>>> +        curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, 
>>> page,
>>>                               buf, len, truesize);
>>>           if (!curr_skb) {
>>>               put_page(page);
>>> @@ -1771,7 +1650,7 @@ static int virtnet_xdp_xmit(struct net_device 
>>> *dev,
>>>       return ret;
>>>   }
>>> -static void put_xdp_frags(struct xdp_buff *xdp)
>>> +static void put_xdp_frags(struct receive_queue *rq, struct xdp_buff 
>>> *xdp)
>>>   {
>>>       struct skb_shared_info *shinfo;
>>>       struct page *xdp_page;
>>> @@ -1781,7 +1660,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>>>           shinfo = xdp_get_shared_info_from_buff(xdp);
>>>           for (i = 0; i < shinfo->nr_frags; i++) {
>>>               xdp_page = skb_frag_page(&shinfo->frags[i]);
>>> -            put_page(xdp_page);
>>> +            page_pool_put_page(rq->page_pool, xdp_page, -1, true);
>>>           }
>>>       }
>>>   }
>>> @@ -1873,7 +1752,7 @@ static struct page *xdp_linearize_page(struct 
>>> net_device *dev,
>>>       if (page_off + *len + tailroom > PAGE_SIZE)
>>>           return NULL;
>>> -    page = alloc_page(GFP_ATOMIC);
>>> +    page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
>>>       if (!page)
>>>           return NULL;
>>> @@ -1896,8 +1775,12 @@ static struct page *xdp_linearize_page(struct 
>>> net_device *dev,
>>>           p = virt_to_head_page(buf);
>>>           off = buf - page_address(p);
>>> +        if (rq->use_page_pool_dma)
>>> +            page_pool_dma_sync_for_cpu(rq->page_pool, p,
>>> +                           off, buflen);
>>> +
>>>           if (check_mergeable_len(dev, ctx, buflen)) {
>>> -            put_page(p);
>>> +            page_pool_put_page(rq->page_pool, p, -1, true);
>>>               goto err_buf;
>>>           }
>>> @@ -1905,21 +1788,21 @@ static struct page *xdp_linearize_page(struct 
>>> net_device *dev,
>>>            * is sending packet larger than the MTU.
>>>            */
>>>           if ((page_off + buflen + tailroom) > PAGE_SIZE) {
>>> -            put_page(p);
>>> +            page_pool_put_page(rq->page_pool, p, -1, true);
>>>               goto err_buf;
>>>           }
>>>           memcpy(page_address(page) + page_off,
>>>                  page_address(p) + off, buflen);
>>>           page_off += buflen;
>>> -        put_page(p);
>>> +        page_pool_put_page(rq->page_pool, p, -1, true);
>>>       }
>>>       /* Headroom does not contribute to packet length */
>>>       *len = page_off - XDP_PACKET_HEADROOM;
>>>       return page;
>>>   err_buf:
>>> -    __free_pages(page, 0);
>>> +    page_pool_put_page(rq->page_pool, page, -1, true);
>>>       return NULL;
>>>   }
>>> @@ -1996,7 +1879,7 @@ static struct sk_buff *receive_small_xdp(struct 
>>> net_device *dev,
>>>               goto err_xdp;
>>>           buf = page_address(xdp_page);
>>> -        put_page(page);
>>> +        page_pool_put_page(rq->page_pool, page, -1, true);
>>>           page = xdp_page;
>>>       }
>>> @@ -2028,13 +1911,15 @@ static struct sk_buff 
>>> *receive_small_xdp(struct net_device *dev,
>>>       if (metasize)
>>>           skb_metadata_set(skb, metasize);
>>> +    skb_mark_for_recycle(skb);
>>> +
>>>       return skb;
>>>   err_xdp:
>>>       u64_stats_inc(&stats->xdp_drops);
>>>   err:
>>>       u64_stats_inc(&stats->drops);
>>> -    put_page(page);
>>> +    page_pool_put_page(rq->page_pool, page, -1, true);
>>>   xdp_xmit:
>>>       return NULL;
>>>   }
>>> @@ -2056,6 +1941,13 @@ static struct sk_buff *receive_small(struct 
>>> net_device *dev,
>>>        */
>>>       buf -= VIRTNET_RX_PAD + xdp_headroom;
>>> +    if (rq->use_page_pool_dma) {
>>> +        int offset = buf - page_address(page) +
>>> +                 VIRTNET_RX_PAD + xdp_headroom;
>>> +
>>> +        page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
>>> +    }
>>> +
>>>       len -= vi->hdr_len;
>>>       u64_stats_add(&stats->bytes, len);
>>> @@ -2082,12 +1974,14 @@ static struct sk_buff *receive_small(struct 
>>> net_device *dev,
>>>       }
>>>       skb = receive_small_build_skb(vi, xdp_headroom, buf, len);
>>> -    if (likely(skb))
>>> +    if (likely(skb)) {
>>> +        skb_mark_for_recycle(skb);
>>>           return skb;
>>> +    }
>>>   err:
>>>       u64_stats_inc(&stats->drops);
>>> -    put_page(page);
>>> +    page_pool_put_page(rq->page_pool, page, -1, true);
>>>       return NULL;
>>>   }
>>> @@ -2142,7 +2036,7 @@ static void mergeable_buf_free(struct 
>>> receive_queue *rq, int num_buf,
>>>           }
>>>           u64_stats_add(&stats->bytes, len);
>>>           page = virt_to_head_page(buf);
>>> -        put_page(page);
>>> +        page_pool_put_page(rq->page_pool, page, -1, true);
>>>       }
>>>   }
>>> @@ -2252,8 +2146,12 @@ static int virtnet_build_xdp_buff_mrg(struct 
>>> net_device *dev,
>>>           page = virt_to_head_page(buf);
>>>           offset = buf - page_address(page);
>>> +        if (rq->use_page_pool_dma)
>>> +            page_pool_dma_sync_for_cpu(rq->page_pool, page,
>>> +                           offset, len);
>>> +
>>>           if (check_mergeable_len(dev, ctx, len)) {
>>> -            put_page(page);
>>> +            page_pool_put_page(rq->page_pool, page, -1, true);
>>>               goto err;
>>>           }
>>> @@ -2272,7 +2170,7 @@ static int virtnet_build_xdp_buff_mrg(struct 
>>> net_device *dev,
>>>       return 0;
>>>   err:
>>> -    put_xdp_frags(xdp);
>>> +    put_xdp_frags(rq, xdp);
>>>       return -EINVAL;
>>>   }
>>> @@ -2337,7 +2235,7 @@ static void *mergeable_xdp_get_buf(struct 
>>> virtnet_info *vi,
>>>           if (*len + xdp_room > PAGE_SIZE)
>>>               return NULL;
>>> -        xdp_page = alloc_page(GFP_ATOMIC);
>>> +        xdp_page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
>>>           if (!xdp_page)
>>>               return NULL;
>>> @@ -2347,7 +2245,7 @@ static void *mergeable_xdp_get_buf(struct 
>>> virtnet_info *vi,
>>>       *frame_sz = PAGE_SIZE;
>>> -    put_page(*page);
>>> +    page_pool_put_page(rq->page_pool, *page, -1, true);
>>>       *page = xdp_page;
>>> @@ -2393,6 +2291,8 @@ static struct sk_buff 
>>> *receive_mergeable_xdp(struct net_device *dev,
>>>           head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, 
>>> xdp_frags_truesz);
>>>           if (unlikely(!head_skb))
>>>               break;
>>> +
>>> +        skb_mark_for_recycle(head_skb);
>>>           return head_skb;
>>>       case XDP_TX:
>>> @@ -2403,10 +2303,10 @@ static struct sk_buff 
>>> *receive_mergeable_xdp(struct net_device *dev,
>>>           break;
>>>       }
>>> -    put_xdp_frags(&xdp);
>>> +    put_xdp_frags(rq, &xdp);
>>>   err_xdp:
>>> -    put_page(page);
>>> +    page_pool_put_page(rq->page_pool, page, -1, true);
>>>       mergeable_buf_free(rq, num_buf, dev, stats);
>>>       u64_stats_inc(&stats->xdp_drops);
>>> @@ -2414,7 +2314,8 @@ static struct sk_buff 
>>> *receive_mergeable_xdp(struct net_device *dev,
>>>       return NULL;
>>>   }
>>> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff 
>>> *head_skb,
>>> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue 
>>> *rq,
>>> +                           struct sk_buff *head_skb,
>>>                              struct sk_buff *curr_skb,
>>>                              struct page *page, void *buf,
>>>                              int len, int truesize)
>>> @@ -2429,6 +2330,9 @@ static struct sk_buff 
>>> *virtnet_skb_append_frag(struct sk_buff *head_skb,
>>>           if (unlikely(!nskb))
>>>               return NULL;
>>> +        if (head_skb->pp_recycle)
>>> +            skb_mark_for_recycle(nskb);
>>> +
>>>           if (curr_skb == head_skb)
>>>               skb_shinfo(curr_skb)->frag_list = nskb;
>>>           else
>>> @@ -2446,7 +2350,10 @@ static struct sk_buff 
>>> *virtnet_skb_append_frag(struct sk_buff *head_skb,
>>>       offset = buf - page_address(page);
>>>       if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
>>> -        put_page(page);
>>> +        if (head_skb->pp_recycle)
>>> +            page_pool_put_page(rq->page_pool, page, -1, true);
>>> +        else
>>> +            put_page(page);
>>>           skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
>>>                        len, truesize);
>>>       } else {
>>> @@ -2475,6 +2382,10 @@ static struct sk_buff 
>>> *receive_mergeable(struct net_device *dev,
>>>       unsigned int headroom = mergeable_ctx_to_headroom(ctx);
>>>       head_skb = NULL;
>>> +
>>> +    if (rq->use_page_pool_dma)
>>> +        page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
>>> +
>>>       u64_stats_add(&stats->bytes, len - vi->hdr_len);
>>>       if (check_mergeable_len(dev, ctx, len))
>>> @@ -2499,6 +2410,8 @@ static struct sk_buff *receive_mergeable(struct 
>>> net_device *dev,
>>>       if (unlikely(!curr_skb))
>>>           goto err_skb;
>>> +
>>> +    skb_mark_for_recycle(head_skb);
>>>       while (--num_buf) {
>>>           buf = virtnet_rq_get_buf(rq, &len, &ctx);
>>>           if (unlikely(!buf)) {
>>> @@ -2513,11 +2426,17 @@ static struct sk_buff 
>>> *receive_mergeable(struct net_device *dev,
>>>           u64_stats_add(&stats->bytes, len);
>>>           page = virt_to_head_page(buf);
>>> +        if (rq->use_page_pool_dma) {
>>> +            offset = buf - page_address(page);
>>> +            page_pool_dma_sync_for_cpu(rq->page_pool, page,
>>> +                           offset, len);
>>> +        }
>>> +
>>>           if (check_mergeable_len(dev, ctx, len))
>>>               goto err_skb;
>>>           truesize = mergeable_ctx_to_truesize(ctx);
>>> -        curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>>> +        curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, 
>>> page,
>>>                               buf, len, truesize);
>>>           if (!curr_skb)
>>>               goto err_skb;
>>> @@ -2527,7 +2446,7 @@ static struct sk_buff *receive_mergeable(struct 
>>> net_device *dev,
>>>       return head_skb;
>>>   err_skb:
>>> -    put_page(page);
>>> +    page_pool_put_page(rq->page_pool, page, -1, true);
>>>       mergeable_buf_free(rq, num_buf, dev, stats);
>>>   err_buf:
>>> @@ -2658,6 +2577,24 @@ static void receive_buf(struct virtnet_info 
>>> *vi, struct receive_queue *rq,
>>>       virtnet_receive_done(vi, rq, skb, flags);
>>>   }
>>> +static int virtnet_rq_submit(struct receive_queue *rq, char *buf,
>>> +                 int len, void *ctx, gfp_t gfp)
>>> +{
>>> +    if (rq->use_page_pool_dma) {
>>> +        struct page *page = virt_to_head_page(buf);
>>> +        dma_addr_t addr = page_pool_get_dma_addr(page) +
>>> +                  (buf - (char *)page_address(page));
>>> +
>>> +        sg_init_table(rq->sg, 1);
>>> +        sg_fill_dma(rq->sg, addr, len);
>>> +        return virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1,
>>> +                             buf, ctx, gfp);
>>> +    }
>>> +
>>> +    sg_init_one(rq->sg, buf, len);
>>> +    return virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>>> +}
>>> +
>>>   /* Unlike mergeable buffers, all buffers are allocated to the
>>>    * same size, except for the headroom. For this reason we do
>>>    * not need to use  mergeable_len_to_ctx here - it is enough
>>> @@ -2666,32 +2603,27 @@ static void receive_buf(struct virtnet_info 
>>> *vi, struct receive_queue *rq,
>>>   static int add_recvbuf_small(struct virtnet_info *vi, struct 
>>> receive_queue *rq,
>>>                    gfp_t gfp)
>>>   {
>>> -    char *buf;
>>>       unsigned int xdp_headroom = virtnet_get_headroom(vi);
>>>       void *ctx = (void *)(unsigned long)xdp_headroom;
>>> -    int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + 
>>> xdp_headroom;
>>> +    unsigned int len = vi->hdr_len + VIRTNET_RX_PAD + 
>>> GOOD_PACKET_LEN + xdp_headroom;
>>> +    unsigned int alloc_len;
>>> +    char *buf;
>>>       int err;
>>>       len = SKB_DATA_ALIGN(len) +
>>>             SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>> -    if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
>>> -        return -ENOMEM;
>>> -
>>
>>
>> reepating my comment from v9:
>>
>>> -    buf = virtnet_rq_alloc(rq, len, gfp);
>>> +    alloc_len = len;
>>> +    buf = page_pool_alloc_va(rq->page_pool, &alloc_len, gfp);
>>
>> So alloc_len can increase here when at end of page ...
>>
>>
>>>       if (unlikely(!buf))
>>>           return -ENOMEM;
>>>       buf += VIRTNET_RX_PAD + xdp_headroom;
>>> -    virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
>>> -
>>> -    err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, 
>>> gfp);
>>> -    if (err < 0) {
>>> -        virtnet_rq_unmap(rq, buf, 0);
>>> -        put_page(virt_to_head_page(buf));
>>> -    }
>>> +    err = virtnet_rq_submit(rq, buf, vi->hdr_len + GOOD_PACKET_LEN, 
>>> ctx, gfp);
>>> +    if (err < 0)
>>> +        page_pool_put_page(rq->page_pool, virt_to_head_page(buf), 
>>> -1, false);
>>>       return err;
>>>   }
>>
>>
>> but then is not used until end of function and does not update the 
>> truesize.
> 
> I'll fix this in v11 by encoding the actual allocation size from
> page_pool_alloc_va() in the ctx pointer, so receive_small_build_skb()
> can pass the real buffer size to build_skb() for correct truesize
> accounting.
> 
>>
>>
>>
>>> @@ -2764,13 +2696,12 @@ static unsigned int 
>>> get_mergeable_buf_len(struct receive_queue *rq,
>>>   static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>>                    struct receive_queue *rq, gfp_t gfp)
>>>   {
>>> -    struct page_frag *alloc_frag = &rq->alloc_frag;
>>>       unsigned int headroom = virtnet_get_headroom(vi);
>>>       unsigned int tailroom = headroom ? sizeof(struct 
>>> skb_shared_info) : 0;
>>>       unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
>>> -    unsigned int len, hole;
>>> -    void *ctx;
>>> +    unsigned int len, alloc_len;
>>>       char *buf;
>>> +    void *ctx;
>>>       int err;
>>>       /* Extra tailroom is needed to satisfy XDP's assumption. This
>>> @@ -2779,39 +2710,22 @@ static int add_recvbuf_mergeable(struct 
>>> virtnet_info *vi,
>>>        */
>>>       len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>>> -    if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
>>> -        return -ENOMEM;
>>> -
>>> -    if (!alloc_frag->offset && len + room + sizeof(struct 
>>> virtnet_rq_dma) > alloc_frag->size)
>>> -        len -= sizeof(struct virtnet_rq_dma);
>>> -
>>> -    buf = virtnet_rq_alloc(rq, len + room, gfp);
>>> +    alloc_len = len + room;
>>> +    buf = page_pool_alloc_va(rq->page_pool, &alloc_len, gfp);
>>>       if (unlikely(!buf))
>>>           return -ENOMEM;
>>>       buf += headroom; /* advance address leaving hole at front of 
>>> pkt */
>>> -    hole = alloc_frag->size - alloc_frag->offset;
>>> -    if (hole < len + room) {
>>> -        /* To avoid internal fragmentation, if there is very likely not
>>> -         * enough space for another buffer, add the remaining space to
>>> -         * the current buffer.
>>> -         * XDP core assumes that frame_size of xdp_buff and the length
>>> -         * of the frag are PAGE_SIZE, so we disable the hole mechanism.
>>> -         */
>>> -        if (!headroom)
>>> -            len += hole;
>>> -        alloc_frag->offset += hole;
>>> -    }
>>> -    virtnet_rq_init_one_sg(rq, buf, len);
>>> +    if (!headroom)
>>> +        len = alloc_len - room;
>>>       ctx = mergeable_len_to_ctx(len + room, headroom);
>>> -    err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, 
>>> gfp);
>>> -    if (err < 0) {
>>> -        virtnet_rq_unmap(rq, buf, 0);
>>> -        put_page(virt_to_head_page(buf));
>>> -    }
>>> +    err = virtnet_rq_submit(rq, buf, len, ctx, gfp);
>>> +
>>> +    if (err < 0)
>>> +        page_pool_put_page(rq->page_pool, virt_to_head_page(buf), 
>>> -1, false);
>>>       return err;
>>>   }
>>> @@ -2963,7 +2877,7 @@ static int virtnet_receive_packets(struct 
>>> virtnet_info *vi,
>>>       int packets = 0;
>>>       void *buf;
>>> -    if (!vi->big_packets || vi->mergeable_rx_bufs) {
>>> +    if (rq->page_pool) {
>>>           void *ctx;
>>>           while (packets < budget &&
>>>                  (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
>>> @@ -3128,7 +3042,10 @@ static int virtnet_enable_queue_pair(struct 
>>> virtnet_info *vi, int qp_index)
>>>           return err;
>>>       err = xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
>>> -                     MEM_TYPE_PAGE_SHARED, NULL);
>>> +                     vi->rq[qp_index].page_pool ?
>>> +                        MEM_TYPE_PAGE_POOL :
>>> +                        MEM_TYPE_PAGE_SHARED,
>>> +                     vi->rq[qp_index].page_pool);
>>>       if (err < 0)
>>>           goto err_xdp_reg_mem_model;
>>> @@ -3168,6 +3085,82 @@ static void virtnet_update_settings(struct 
>>> virtnet_info *vi)
>>>           vi->duplex = duplex;
>>>   }
>>> +static int virtnet_create_page_pools(struct virtnet_info *vi)
>>> +{
>>> +    int i, err;
>>> +
>>> +    if (vi->big_packets && !vi->mergeable_rx_bufs)
>>> +        return 0;
>>> +
>>> +    for (i = 0; i < vi->max_queue_pairs; i++) {
>>> +        struct receive_queue *rq = &vi->rq[i];
>>> +        struct page_pool_params pp_params = { 0 };
>>> +        struct device *dma_dev;
>>> +
>>> +        if (rq->page_pool)
>>> +            continue;
>>> +
>>> +        if (rq->xsk_pool)
>>> +            continue;
>>> +
>>> +        pp_params.order = 0;
>>> +        pp_params.pool_size = virtqueue_get_vring_size(rq->vq);
>>> +        pp_params.nid = dev_to_node(vi->vdev->dev.parent);
>>> +        pp_params.netdev = vi->dev;
>>> +        pp_params.napi = &rq->napi;
>>> +
>>> +        /* Use page_pool DMA mapping if backend supports DMA API.
>>> +         * DMA_SYNC_DEV is needed for non-coherent archs on recycle.
>>> +         */
>>> +        dma_dev = virtqueue_dma_dev(rq->vq);
>>> +        if (dma_dev) {
>>> +            pp_params.dev = dma_dev;
>>> +            pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
>>> +            pp_params.dma_dir = DMA_FROM_DEVICE;
>>> +            pp_params.max_len = PAGE_SIZE;
>>> +            pp_params.offset = 0;
>>> +            rq->use_page_pool_dma = true;
>>> +        } else {
>>> +            /* No DMA API (e.g., VDUSE): page_pool for allocation 
>>> only. */
>>> +            pp_params.flags = 0;
>>> +            rq->use_page_pool_dma = false;
>>> +        }
>>> +
>>> +        rq->page_pool = page_pool_create(&pp_params);
>>> +        if (IS_ERR(rq->page_pool)) {
>>> +            err = PTR_ERR(rq->page_pool);
>>> +            rq->page_pool = NULL;
>>> +            goto err_cleanup;
>>> +        }
>>> +    }
>>> +    return 0;
>>> +
>>> +err_cleanup:
>>> +    while (--i >= 0) {
>>> +        struct receive_queue *rq = &vi->rq[i];
>>> +
>>> +        if (rq->page_pool) {
>>> +            page_pool_destroy(rq->page_pool);
>>> +            rq->page_pool = NULL;
>>> +        }
>>> +    }
>>> +    return err;
>>> +}
>>> +
>>> +static void virtnet_destroy_page_pools(struct virtnet_info *vi)
>>> +{
>>> +    int i;
>>> +
>>> +    for (i = 0; i < vi->max_queue_pairs; i++) {
>>> +        struct receive_queue *rq = &vi->rq[i];
>>> +
>>> +        if (rq->page_pool) {
>>> +            page_pool_destroy(rq->page_pool);
>>> +            rq->page_pool = NULL;
>>> +        }
>>> +    }
>>> +}
>>> +
>>>   static int virtnet_open(struct net_device *dev)
>>>   {
>>>       struct virtnet_info *vi = netdev_priv(dev);
>>> @@ -5715,6 +5708,10 @@ static int virtnet_restore_up(struct 
>>> virtio_device *vdev)
>>>       if (err)
>>>           return err;
>>> +    err = virtnet_create_page_pools(vi);
>>> +    if (err)
>>> +        goto err_del_vqs;
>>> +
>>>       virtio_device_ready(vdev);
>>>       enable_rx_mode_work(vi);
>>> @@ -5724,12 +5721,24 @@ static int virtnet_restore_up(struct 
>>> virtio_device *vdev)
>>>           err = virtnet_open(vi->dev);
>>>           rtnl_unlock();
>>>           if (err)
>>> -            return err;
>>> +            goto err_destroy_pools;
>>>       }
>>>       netif_tx_lock_bh(vi->dev);
>>>       netif_device_attach(vi->dev);
>>>       netif_tx_unlock_bh(vi->dev);
>>> +    return 0;
>>> +
>>> +err_destroy_pools:
>>> +    virtio_reset_device(vdev);
>>> +    free_unused_bufs(vi);
>>> +    virtnet_destroy_page_pools(vi);
>>> +    virtnet_del_vqs(vi);
>>> +    return err;
>>> +
>>> +err_del_vqs:
>>> +    virtio_reset_device(vdev);
>>> +    virtnet_del_vqs(vi);
>>>       return err;
>>>   }
>>> @@ -5857,7 +5866,7 @@ static int virtnet_xsk_pool_enable(struct 
>>> net_device *dev,
>>>       /* In big_packets mode, xdp cannot work, so there is no need to
>>>        * initialize xsk of rq.
>>>        */
>>> -    if (vi->big_packets && !vi->mergeable_rx_bufs)
>>> +    if (!vi->rq[qid].page_pool)
>>>           return -ENOENT;
>>>       if (qid >= vi->curr_queue_pairs)
>>> @@ -6287,17 +6296,6 @@ static void free_receive_bufs(struct 
>>> virtnet_info *vi)
>>>       rtnl_unlock();
>>>   }
>>> -static void free_receive_page_frags(struct virtnet_info *vi)
>>> -{
>>> -    int i;
>>> -    for (i = 0; i < vi->max_queue_pairs; i++)
>>> -        if (vi->rq[i].alloc_frag.page) {
>>> -            if (vi->rq[i].last_dma)
>>> -                virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
>>> -            put_page(vi->rq[i].alloc_frag.page);
>>> -        }
>>> -}
>>> -
>>>   static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void 
>>> *buf)
>>>   {
>>>       struct virtnet_info *vi = vq->vdev->priv;
>>> @@ -6401,7 +6399,7 @@ static int virtnet_find_vqs(struct virtnet_info 
>>> *vi)
>>>       vqs_info = kzalloc_objs(*vqs_info, total_vqs);
>>>       if (!vqs_info)
>>>           goto err_vqs_info;
>>> -    if (!vi->big_packets || vi->mergeable_rx_bufs) {
>>> +    if (vi->mergeable_rx_bufs || !vi->big_packets) {
>>>           ctx = kzalloc_objs(*ctx, total_vqs);
>>>           if (!ctx)
>>>               goto err_ctx;
>>> @@ -6441,10 +6439,8 @@ static int virtnet_find_vqs(struct 
>>> virtnet_info *vi)
>>>           vi->rq[i].min_buf_len = mergeable_min_buf_len(vi, vi- 
>>> >rq[i].vq);
>>>           vi->sq[i].vq = vqs[txq2vq(i)];
>>>       }
>>> -
>>>       /* run here: ret == 0. */
>>> -
>>>   err_find:
>>>       kfree(ctx);
>>>   err_ctx:
>>> @@ -6945,6 +6941,14 @@ static int virtnet_probe(struct virtio_device 
>>> *vdev)
>>>               goto free;
>>>       }
>>> +    /* Create page pools for receive queues.
>>> +     * Page pools are created at probe time so they can be used
>>> +     * with premapped DMA addresses throughout the device lifetime.
>>> +     */
>>> +    err = virtnet_create_page_pools(vi);
>>> +    if (err)
>>> +        goto free_irq_moder;
>>> +
>>>   #ifdef CONFIG_SYSFS
>>>       if (vi->mergeable_rx_bufs)
>>>           dev->sysfs_rx_queue_group = &virtio_net_mrg_rx_group;
>>> @@ -6958,7 +6962,7 @@ static int virtnet_probe(struct virtio_device 
>>> *vdev)
>>>           vi->failover = net_failover_create(vi->dev);
>>>           if (IS_ERR(vi->failover)) {
>>>               err = PTR_ERR(vi->failover);
>>> -            goto free_vqs;
>>> +            goto free_page_pools;
>>>           }
>>>       }
>>> @@ -7075,9 +7079,11 @@ static int virtnet_probe(struct virtio_device 
>>> *vdev)
>>>       unregister_netdev(dev);
>>>   free_failover:
>>>       net_failover_destroy(vi->failover);
>>> -free_vqs:
>>> +free_page_pools:
>>> +    virtnet_destroy_page_pools(vi);
>>> +free_irq_moder:
>>> +    virtnet_free_irq_moder(vi);
>>>       virtio_reset_device(vdev);
>>> -    free_receive_page_frags(vi);
>>>       virtnet_del_vqs(vi);
>>>   free:
>>>       free_netdev(dev);
>>> @@ -7102,7 +7108,7 @@ static void remove_vq_common(struct 
>>> virtnet_info *vi)
>>>       free_receive_bufs(vi);
>>> -    free_receive_page_frags(vi);
>>> +    virtnet_destroy_page_pools(vi);
>>>       virtnet_del_vqs(vi);
>>>   }
>>> -- 
>>> 2.47.3
>>
> 


