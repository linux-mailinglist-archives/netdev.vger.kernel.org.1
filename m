Return-Path: <netdev+bounces-254220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFMBIdHzeWnT1AEAu9opvQ
	(envelope-from <netdev+bounces-254220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:32:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4BAA078C
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A96E3091140
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C962434FF7F;
	Wed, 28 Jan 2026 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="erZKud/R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OLk5jtJj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EBB34FF4E;
	Wed, 28 Jan 2026 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599683; cv=fail; b=cWIo+OccUUxaw2s5SgnZs7RrOZSNeJBXBJF0BTgcVDtlNF9NQf33nIO9FYfyAN/4LF0KKP2Ekslie+gDR3exjCAum5R5jI9vWNshI0sFMxCe6qieH2pm7OJq3/00LKGBvfgcdZ5GXBduVPGvMWAqcD8vzfJc8BOk7TRn51s1w60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599683; c=relaxed/simple;
	bh=Gbf94C9uVz06saskwAeSkI39kH01zZW1FEtDSuTGk0A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tZnAcaOjWTMOPtEbdx1zJA1hDh3zoy9HJ84xWOK/cOh7ZAki/kian6FlQEHOkl2v0eHyssE76ZWi0ooiytbvNkoN1YsMqXIuOOE9sV1cBwRz3Zt6tDMl+5eM32wV3a6JoVzP75yN2NEAUcgV1iCpWlNJTIimj1znKUUireiWyEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=erZKud/R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OLk5jtJj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S4C49K791701;
	Wed, 28 Jan 2026 11:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=z8C1nkJs2S/y0ZKFpAnl6ysAdBUQc+I6/eWmOEiYig4=; b=
	erZKud/Rewe8r/iFI+5yoyMrFWo1CN1/cAHkUWinBF8VGv9MMa4Yu+rp7Q+QKAQe
	9bLiHERh0pqf6akyO6F9fn3dBubdKJGRTJY+SZTVG4zjLge7GbWaej9KMOB4fZTC
	r4ytYSRTO2/TWdo7zILPp95kcTRnaVvk46Itb+MaPiCDcEaWc8lIOoldnBAVTtCM
	A7nB96Z8Vy9lTER9eoLkXeED4gYiPG36Im7g2gXOOapXHFXMBG4F7dGIVdT+wJgW
	r/reN69yp5HuVGccLsEx4S9qrQf5rw/fg23NmspPb1Bzt9LJ5eh39hUVARH5My+1
	r3tKmMJjmDWtz66ppKI4dQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by39r96cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 11:27:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60S9uDMT035370;
	Wed, 28 Jan 2026 11:27:45 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010071.outbound.protection.outlook.com [52.101.193.71])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhas3et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 11:27:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgL9u35p9q1RQo0ts7WFaJCJm9ZrIr9CazhZ/PkZb+y43144IdXO09SbNCRAwOpNqPOW1RzJn/7ujzPkDX4QjlhLEwTX5Za5wOfnUMrYxQ5RgdZKaiOTGhNelSCTT2RC+8VHG/BynWp7+ZvYfiNHh0zHAkDrkwNsIjnm9SLIgL1dqTATWjXxcWCS6ssX+EcqC/pQx99iXXNSx9/FYoYWTlgpO+VQpwAEtF4r7YTaGjOCI3M30y8mpIWRm4KariFuoCr36xL1xlR3m/VrYL8JJMVczTgDXRQThn8AfuGmVaSYyByzK3AK7ngvF8e66V8amKCVaivIs10E7+hITl1tBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8C1nkJs2S/y0ZKFpAnl6ysAdBUQc+I6/eWmOEiYig4=;
 b=bN+jjxUXQlXjmXYLkgHerbJLLrz7aWWNSai001Q25RZWx7TCinsIIXdl0Lf3el5JW9QDv1OR1HrXMzIrtoKEKixIj15jeP9RkPjpzKyYpdg4AwjwGA9H41skIHiwf2gTxQoXTatuWT0gMHtwzx/jxPa4s42lI0YNwRwgz4roDuqknLUW1MiZwIC1CkmieOs8+Mhrs8syfQ04Lez7OBf12Tz7EKKzxGd8Wgy1ozZxWniFhn4qRU6P/xnAs/7/paXoX2NxdY+Gap/qPa0Mjh0o2pnweKa5xVuVTtUs3x+DEyQ8A8At34ACNkvD5fP3wVbc/Sla6Vj7MQ+wyU5kXbeYUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8C1nkJs2S/y0ZKFpAnl6ysAdBUQc+I6/eWmOEiYig4=;
 b=OLk5jtJjLu6Sp1A1YnD6uuixSk3CLpXGJQzjohLphWrqRQdnBSd3ILZ53RxhCrFVkrfOyVQ41srhCvbqcxlxehUAPFOtO8C6JRrWRhQDTT2OhSBzdfiTlAVNjbMgnCJjjsgwcsWIr8MOKspxp7pOeoMjyHOQnsKK764sValYvws=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by LV8PR10MB7775.namprd10.prod.outlook.com (2603:10b6:408:1ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 11:27:40 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 11:27:39 +0000
Message-ID: <08870c7a-8410-46b1-9558-ea3fe6487619@oracle.com>
Date: Wed, 28 Jan 2026 16:57:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 01/13] octeontx2-af: npc: cn20k: Index
 management
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch
References: <20260128071235.3577206-1-rkannoth@marvell.com>
 <20260128071235.3577206-2-rkannoth@marvell.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20260128071235.3577206-2-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0067.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25a::6) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|LV8PR10MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: bcda6aa1-21d3-47fd-804b-08de5e603e9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cU9iY3NFUlFpMmwzNGxoSDdNaEZvWE41SHltdnFzMG52M21KczBuenZBVFRy?=
 =?utf-8?B?Q0pHaWgzLzdXWnBjUkJvUWl2N1dpUUhvcVpPWENqK2c3cUYzc05mTjZ5bFkr?=
 =?utf-8?B?MERUN1pGd2pxVkRKRWRSUmlyNXBjMjI1VktoaDh1WWlvOUJBaGUzcFR1bDR0?=
 =?utf-8?B?R2J2OUV0UXZDWkRldkxuRTg3MjgxMk9Ka1dhREpzekh3T2xkQlhyKzljcEx6?=
 =?utf-8?B?Zmc4ZUhSQnQvTGZmU0Q3L2ozQWVlQ2x1elJXdVRENGU4ZXREK29SRlVYN2Fo?=
 =?utf-8?B?VnJlUzQ4ci91bHY4Mnd3MmtudWk5WWYxS2t1bDNLUndSVm9jeHNYSUhxTzRr?=
 =?utf-8?B?YWx2ekRsWEpFdDFObjZCUjAxNEppTlNpMnFxYUtSblNwQkpMMXJaV0s1ZmVj?=
 =?utf-8?B?RmJyeVJzKzc2YWhIYjNVcmRtSU1ucGVhcG8wRzUzaDVpd2xJL1hOSndwUE83?=
 =?utf-8?B?OThMTE9NK01xR1pGREluK2V0RDZ0c2pqdDdxSUp4Wk03MURsTGZzMUZVS3gy?=
 =?utf-8?B?NlExMVAzTmtiZ3BpZjIwaW1yKzRjcjYvTXBTam1tbHVtYWZpekVWNy9PTFQy?=
 =?utf-8?B?dDFucWpzZ3dwQXRPTW53WWk3OG9aMTFoL0FXZk1EWGl4S2NaZlFIaWlGNXhs?=
 =?utf-8?B?cWt2YjZ5NEJxR3IzckJiM3d3dUVGc2ZNNTlaYklZYU1sZDEyMGw4SVJQcGEy?=
 =?utf-8?B?d1ZGYzNjVGlNelJEbnhTRUZXZDhWam80Y2lrWTZOOXp3czRzZkUzTW8rak1z?=
 =?utf-8?B?VmNKQ3ZBcjlybFVVMjFuS01WNnd1VFFpeGQyN1k2aFNUOWxtUXc3cVRHYXV6?=
 =?utf-8?B?Z0xJQkZlWHJ3RlFlalc0WU5zVmhDTThVU2pyWGpvbkpLeS9GOHRHMVlGVDFJ?=
 =?utf-8?B?ckhQNExwT1V1dVJlOHZQdFRaVjQyRmduUXVMOGJseWpTMWdqNy9qVW1BSkFt?=
 =?utf-8?B?SWgrU0V2Ly9nY3lGRm1qVW0vdnBFaUphSFpMaDZmSFVxbXFEZUQwTkxGdG9q?=
 =?utf-8?B?Vm02WjlmUEt0eVQzdEtXSkVtUElaMitwN1pzbjlBUTZybzRKWUR3VXltWXd5?=
 =?utf-8?B?NmRidm1ySVdJZThjKy9GTTJ4OSt3am94UjM1aDFNbWxmeEh2UkZnRzQxWFpY?=
 =?utf-8?B?bzFJdHlXM1hQcjgzbjIwY0k2cUxEVllFN3B6MXdBczBMc004dHdOMjVDR0x5?=
 =?utf-8?B?eEIxdTBpdnRTV0QwT3R1WGRqTU52ZW8xUlQwc0VMbkt1WWZzTUorRmd1SFlG?=
 =?utf-8?B?WVV0cFd1VDQrcW9ScFJJNkdoREZ6QTJ3RjdhN1J4aW5WYkFNak5oZmt3THha?=
 =?utf-8?B?OTVtcUh4dml2M2tnc2hMWXNLbnRjK28wakVmd2FueCtOZE1UeENBM204SURr?=
 =?utf-8?B?QnpvVlBaYk9sRUNKMFY3d2NkdzIyZExSc2FOKy9XbjJxTjJEb0ZWekRBMDB1?=
 =?utf-8?B?YzRiaWN3VHFNN2JEOEpoU1gyWERtcnlmV2tkNmJiZS9CTlNxeEIzbk5CUXZJ?=
 =?utf-8?B?di9RQndsNytBQ1FjaHBSYWRNb25GcE56YlkrUHlhd2JUTEY4WVU1am9WZ1U1?=
 =?utf-8?B?MGtITk83UGlLRG1rUzlWc2JabFNCZ1FOUmc1dmp1ak9KVjFyYnV6M05oOGsz?=
 =?utf-8?B?K1NDT2FPRUV0Mk1CWStrV2tmeWxDTEtPY1UxQ2JzeUNYRkpML0hsMjFLVFVl?=
 =?utf-8?B?OERCdWVaNVE3Z3pBUU9lOEtKMVZOK1pLRVdoOHYxZXFPU0JFa3p2TDFpRys0?=
 =?utf-8?B?Um5BVDdhQnJXOFV5N3VsQUk0SW1nUEZMaThZQVVrQlpyRXE5RDErNzFzWEc1?=
 =?utf-8?B?Z2ZLamM4RFZ4c0ozNVNvT3FOcU5Ndkdud1JjRkRwTXdua3p4czNYdzBuaVFK?=
 =?utf-8?B?RnYyUTdhK1M0MGNsbzRSbHBabTN6WWhxUmVkOGFrU0RGUWlLbS96ZnViKzIy?=
 =?utf-8?B?L0hEa1hranZySDNySG84b2EzbzFNTHRiT0FzRnprMDhNd2NKUVQyb3h1VTVC?=
 =?utf-8?B?QjVnME5kZjBTN3I2dEx4ellZMC9uRTlEYTdITEtub212eE12ZUpEZTBxQVRk?=
 =?utf-8?B?S3BjM2JZcVJUMDAyS0VsVmFZWExwYzBNblZWQmNqMTRHelBlMXdPNXFnQVN2?=
 =?utf-8?Q?R2G8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWVDU3cxN09VQTAxWUZWcm43cFB3Szk0L1p2RHR5cUZjT2tBVkNGVGE4MVQ2?=
 =?utf-8?B?RXZBK01LeDl1ZzdvZDdRL2FyWnQyeENBbWowTUJqS3RRdkNFQWtjeEdCZjJL?=
 =?utf-8?B?eTRabnJ5VFNnTklaWnRndlRDeE9SdEY1WW1QbkY1VWY0cmZUQVpGb3pDQ1Nq?=
 =?utf-8?B?QUg1cXlEUVp6ZzRiR0xlUXhsSmF2bGVXR2dJalliN3RrNW1xU3dpcnVrWjVq?=
 =?utf-8?B?bGFqK3hMa1pDTkdiSDd6Q3BEcyttS1ZaTTFvcDMyTlZBUUZuclpqeXgyQVpY?=
 =?utf-8?B?dW92a1E0MkFrejJPUkttalp4RmFaOWFoTUppd0JpVVJiOXhkbXMyU0lNVDdS?=
 =?utf-8?B?ZTRJemVhQkdUUS9tWnBaeGlqZnl5dlkrM2Y2WDkweTZQL2Z2UzVBSkxxRnlH?=
 =?utf-8?B?amhvMmFlWkJyT0lpRUlKSEo5RnBZWUovTW5sZE5rTHJoeS9oa1lRZkpjWUcy?=
 =?utf-8?B?WWZhMlJXRFJoWFlyb04rVlVqUHpjUTFrNnBJMkZMcFppQkpXUHdURE94NFJj?=
 =?utf-8?B?ZzhmdXYvQTY5cWk5dWlLRnBpM2Ywc2JDdnhCRzFUMkZUWjNwNUZtdDMwakRM?=
 =?utf-8?B?T3dIMnc2Ykh3eEk4L084ci9KU3lmS29OeWFudmwzb2s1QitrZG04UjJHblMx?=
 =?utf-8?B?VTJqaHFmR2wvdlRyRExxTFFJWkQyblZqazM2R0pJYys3SUgrb1VIR1ZCaVlq?=
 =?utf-8?B?a2xRelYwckhXYVJNWDhuSy9neHZpemFpVElUSzVQWXpjUGpsM3NCYXBCMWly?=
 =?utf-8?B?bzY1SGJOQnRjWDBzNGw2ZHdIUXpGY2R5dTZQa0Y4R1l4dFF4em12R2JJT0x3?=
 =?utf-8?B?WFJHSDNWZFhzS2VxUG5PZTBzdnRUblZGL2Fjd0s2bUg3cGpKNkNIdnJuRnk2?=
 =?utf-8?B?dWNkaWlqamlGdE5iVG1EaTNXSVBmTmthdzVUMGJVck1SUTRBUHl2WXd2ME05?=
 =?utf-8?B?UDRONDcza1pTYkhkU0lQSk5ZMnF3QjJVcmNaRE1tQW82Tno2YVdEdkRmMmZo?=
 =?utf-8?B?Rm00TjlvdjkxWllvZHBXUi85UGFGaEJEcnY2eVFSTG9xcEN5RjdSRTFmbThn?=
 =?utf-8?B?aEhTdmhEam9mNmd5RndsL3d5M1g1V3lMNXNBaC9mRkhMcXVCUDEzcEc0RThn?=
 =?utf-8?B?RlVGclQ4dXJMQzA3RVh5dWtpYzNBSURIZVVJU0M1OTY0K1JERlhzUWNZa3Zr?=
 =?utf-8?B?V0pLNExEajg4eFdKQ2Z3RkoxR21kNnhEVTZKaXJiNGZ3N1RLWHcwU1ptTXA5?=
 =?utf-8?B?MnpydVVOcmcyYlpzMXZ0ckNpM0dCMWRna2NyakZ1TThWZVgrMXdhUmZQWTJz?=
 =?utf-8?B?SVpTc1VKcnJGRG51YlJlNFBRZE10SVdMMzdtY0IwcjlJY05NalI4UjlUN2Vm?=
 =?utf-8?B?dTVNcElGSVJWeDRCVUxXbk52NFhQcDd4NllxQUF2TUxDK09VM0tWb0o5U1JI?=
 =?utf-8?B?TUsrREY5UGRHQnRPOTV1Nll6blNaZzcwbVJjWEMwYVZXekR2ZGlveCs4dkcy?=
 =?utf-8?B?NllTM0NrOVRFMnNlS0V0bGUyTEhhUlZ6RnUwZFhETG9rQWlXQkhSd1NneGZw?=
 =?utf-8?B?aG4xTXlTSVJxZWZiaWY0ZzJBRHF2TlovdjR4ajJNS3BQQ1lQRHprdzFJemxN?=
 =?utf-8?B?R0dYdXVXMUdWak80dGcxQmkrZlN4dEFWeGhmYlROeCtTaHZ5OVRNVXJmRXhX?=
 =?utf-8?B?ek9XWDhxNE1CMVJpWWQ1UFBVMnEvODNyZStzMzViM2VqQTE5N0dsTFo3VHR2?=
 =?utf-8?B?NGhWVFNHU3hpUkNZajJSWDV0Y0JWRHloQXg5ck1sTFVuMXBBaHV4eWIvZTdN?=
 =?utf-8?B?L1ZzYUM5SVVEVUU5ODBvNUZDWi85T1JWMStoWmUyNXlXWFg2LzNHS0p5eE5x?=
 =?utf-8?B?TDBRM2dQS0lQTVFxL1IxK0JaaVlOdTJvektVMTFZYmlMbENhM29STWpMMFlB?=
 =?utf-8?B?Y29nREZiQ0FCbzFSWFV6bGdSOGsvbEErcGxpUmY0YWM4WGpHQ2FaSG9PRnYr?=
 =?utf-8?B?UFdHZFExc1Vacmc3K1hZczNWdDNRTWRVc0I3b0xQZ2pQYVFvbSt0S2Z0bTRW?=
 =?utf-8?B?K3VYNXFNRU94R3o1UlY2ZzRmNUxtZEpXVENZRDRWRFYzY2R6WnFzVjNUWXFx?=
 =?utf-8?B?NGwzdldiL0tWbkRuZFhqUnBmbGlYN3BWamFGZ3U0dS8xRmxVZ2ZwNklkWkVp?=
 =?utf-8?B?WU9IQ1YwRDBSbmJYY01vcXJnRXFEZHNRQjBXeml4NDEzUHlieTZic0sxSnN4?=
 =?utf-8?B?cjl6ZXpReGw1THg5cmdrYXk0YnBWNzhiZHkydjJXanM0b3Rnd29lbUdNM3NQ?=
 =?utf-8?B?cUZZejZHTHdvekd4SXlWRWw1VjlRTGI1WlBWR0Q1aGMzUnV0YnZpUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wc6vL9/Ml2FdDOHRtIdg6QaLF8CDMNun0VOjm8FeQSzKhyjv2Fx2ZeHRsutW8XZDVCIQ7WXzgn8eWA8o0nTx/+7oE0U7tzp/33j8ehddJdvkJ7mBYMumKrJaczjw0B/Mowu5hiHRQpyVHot2ITFw6ZjGUaIEscl7/xIa/vkfNx2NK40+SIbBa0h5MlViHGwZ+VVHRxKWKNAGvu690F5bzyzNNqQoV+39b+YT2G5yTTb0k0iKy/r/4Ww0o8NCkNk6iDYbjGgbE/3GdtNjgfvBKxT6RHFHvbQIz/oUgI3XyQLfL9P9P43Dn0peTkgelx8BOnFocRfxcQ5cdi/PkQbGfTgDjnIDl4azW/ssJTQN8/8Kscvem6ErBy7yjjQj1b0U/2Q3EvagvSRMQXPf/4WZiin+Iv71lGS18AXZYiwNwMvqcIRR8Gd15F0LGzQxl35QNY6mMKIFPDW8Mh64qUPAXfcorlEk10+eTtBKEg3IKixt6Y8ltBwTJmiMYScJ5ovnSTHYFF+6F5zfqUsFzw5MP0oTAvLYpMESlDYYtapTdRKnPj71N3qFmCj0cDGmncu6yxuQDNzjoUAPvo45t5UCJlvsCHcA9icpEq041tUijTo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcda6aa1-21d3-47fd-804b-08de5e603e9f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:27:39.7184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Y2g+FOAsrZFX5JbFRE6IFwOHUMbwHBFM2MhgYe68Z+PrEkfNMnrddt9RBDzgTBJqyluQ5gyhJAftnEw4O/kNXyOpx/oGBJjd1Z6IiBndbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7775
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601280093
X-Authority-Analysis: v=2.4 cv=LaoxKzfi c=1 sm=1 tr=0 ts=6979f2b1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ARcCnNWQk2cZ0HZh8vAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YRXv9oiRGNE2oxpB8rjkaLLTC1fEMi9j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA5NCBTYWx0ZWRfXzwib2m9e9ocq
 pMOKH8GUwrTPCHAgchyNZ5c+6BdaD6VBXHCAk7DvDwDMFaF+1dymNQvxB2qnjVPyMlOs2i1h3Ma
 luLLxmS5LBpzqWeVjDrQCyTcccDFbDkU5DemckhtjLu6g9xJBApB6X8rRtqnN5XtWiXK1yQpbdI
 G42nW6HIH+BZvDUC1M4YYxfI2CWhddbO2Vpd76CN6NMxfRQX4BBMKhaVZ/eGDZsyDmjrzxwsiVE
 VZnpj2M9iKtM3JfGtdQxJn51ZHNkzkUIWNNuLHr4rlb+I6YybXD6rQjUh9AMl395AK7ESb5NmdG
 GzIvMF0CDaMz+VmVrahItNTHB8BliTUYA7lXOAYDGZFl+AIwMhq6cXZ4JQu70h/xhpmoNBSWGbW
 TGXGFYBdJsyMwk8AcJNjXuQTuX/5jYg/3psuaeP/E96tPfoIZik4nnm4jggHn159t7wi+Ch63y2
 56IYog6v9ZYbmV46QbQ==
X-Proofpoint-ORIG-GUID: YRXv9oiRGNE2oxpB8rjkaLLTC1fEMi9j
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254220-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,npc_priv.sb:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BA4BAA078C
X-Rspamd-Action: no action

> +
> +static int __npc_subbank_contig_alloc(struct rvu *rvu,
> +				      struct npc_subbank *sb,
> +				      int key_type, int sidx,
> +				      int eidx, int prio,
> +				      int count, int t, int b,
> +				      unsigned long *bmap,
> +				      u16 *save)
> +{
> +	int k, offset, delta = 0;
> +	int cnt = 0, sbd;
> +
> +	sbd = npc_priv.subbank_depth;
> +
> +	if (sidx >= npc_priv.bank_depth)
> +		delta = sbd;
> +
> +	switch (prio) {
> +	case NPC_MCAM_LOWER_PRIO:
> +	case NPC_MCAM_ANY_PRIO:
> +		/* Find an area of size 'count' from sidx to eidx */
> +		offset = bitmap_find_next_zero_area(bmap, sbd, sidx - b,
> +						    count, 0);
> +
> +		if (offset >= sbd) {
> +			dev_err(rvu->dev,
> +				"%s: Could not find contiguous(%d) entries\n",
> +				__func__, count);
> +			return -EFAULT;
> +		}
> +
> +		dev_dbg(rvu->dev,
> +			"%s: sidx=%d eidx=%d t=%d b=%d offset=%d count=%d delta=%d\n",
> +			__func__, sidx, eidx, t, b, offset,
> +			count, delta);
> +
> +		for (cnt = 0; cnt < count; cnt++)
> +			save[cnt] = offset + cnt + delta;
> +
> +		break;
> +
> +	case NPC_MCAM_HIGHER_PRIO:
> +		/* Find an area of 'count' from eidx to sidx */
> +		for (k = eidx - b; cnt < count && k >= (sidx - b); k--) {
> +			/* If an intermediate slot is not free,
> +			 * reset the counter (cnt) to zero as
> +			 * request is for contiguous.
> +			 */
> +			if (test_bit(k, bmap)) {
> +				cnt = 0;
> +				continue;
> +			}
> +
> +			save[cnt++] = k + delta;
> +		}
> +		break;
> +	}
> +
> +	/* Found 'count' number of free slots */
> +	if (cnt == count)
> +		return 0;
> +
> +	dev_dbg(rvu->dev,
> +		"%s: Could not find contiguous(%d) entries in subbbank=%u\n",

typo subbbank -> subbank

> +		__func__, count, sb->idx);
> +	return -EFAULT;
> +}
> +
> +static int __npc_subbank_non_contig_alloc(struct rvu *rvu,
> +					  struct npc_subbank *sb,
> +					  int key_type, int sidx,
> +					  int eidx, int prio,
> +					  int t, int b,
> +					  unsigned long *bmap,
> +					  int count, u16 *save,
> +					  bool max_alloc, int *alloc_cnt)
> +{
> +	unsigned long index;
> +	int cnt = 0, delta;
> +	int k, sbd;
> +
> +	sbd = npc_priv.subbank_depth;
> +	delta = sidx >= npc_priv.bank_depth ? sbd : 0;
> +
> +	switch (prio) {
> +		/* Find an area of size 'count' from sidx to eidx */
> +	case NPC_MCAM_LOWER_PRIO:
> +	case NPC_MCAM_ANY_PRIO:
> +		index = find_next_zero_bit(bmap, sbd, sidx - b);
> +		if (index >= sbd) {
> +			dev_err(rvu->dev,
> +				"%s: Error happened to alloc %u, bitmap_weight=%u, sb->idx=%u\n",
> +				__func__, count,
> +				bitmap_weight(bmap, sbd),
> +				sb->idx);
> +			break;
> +		}
> +
> +		for (k = index; cnt < count && k <= (eidx - b); k++) {
> +			/* Skip used slots */
> +			if (test_bit(k, bmap))
> +				continue;
> +
> +			save[cnt++] = k + delta;
> +		}
> +		break;
> +
> +		/* Find an area of 'count' from eidx to sidx */
> +	case NPC_MCAM_HIGHER_PRIO:
> +		for (k = eidx - b; cnt < count && k >= (sidx - b); k--) {
> +			/* Skip used slots */
> +			if (test_bit(k, bmap))
> +				continue;
> +
> +			save[cnt++] = k + delta;
> +		}
> +		break;
> +	}
> +
> +	/* Update allocated 'cnt' to alloc_cnt */
> +	*alloc_cnt = cnt;
> +
> +	/* Successfully allocated requested count slots */
> +	if (cnt == count)
> +		return 0;
> +
> +	/* Allocation successful for cnt < count */
> +	if (max_alloc && cnt > 0)
> +		return 0;
> +
> +	dev_dbg(rvu->dev,
> +		"%s: Could not find non contiguous entries(%u) in subbank(%u) cnt=%d max_alloc=%d\n",
> +		__func__, count, sb->idx, cnt, max_alloc);
> +
> +	return -EFAULT;
> +}
> +
> +static void __npc_subbank_sboff_2_off(struct rvu *rvu, struct npc_subbank *sb,
> +				      int sb_off, unsigned long **bmap,
> +				      int *off)
> +{
> +	int sbd;
> +
> +	sbd = npc_priv.subbank_depth;
> +
> +	*off = sb_off & (sbd - 1);
> +	*bmap = (sb_off >= sbd) ? sb->b1map : sb->b0map;
> +}
> +
> +/* set/clear bitmap */
> +static bool __npc_subbank_mark_slot(struct rvu *rvu,
> +				    struct npc_subbank *sb,
> +				    int sb_off, bool set)
> +{
> +	unsigned long *bmap;
> +	int off;
> +
> +	/* if sb_off >= subbank.depth, then slots are in
> +	 * bank1
> +	 */
> +	__npc_subbank_sboff_2_off(rvu, sb, sb_off, &bmap, &off);
> +
> +	dev_dbg(rvu->dev,
> +		"%s: Marking set=%d sb_off=%d sb->idx=%d off=%d\n",
> +		__func__, set, sb_off, sb->idx, off);
> +
> +	if (set) {
> +		/* Slot is already used */
> +		if (test_bit(off, bmap))
> +			return false;
> +
> +		sb->free_cnt--;
> +		set_bit(off, bmap);
> +		return true;
> +	}
> +
> +	/* Slot is already free */
> +	if (!test_bit(off, bmap))
> +		return false;
> +
> +	sb->free_cnt++;
> +	clear_bit(off, bmap);
> +	return true;
> +}
> +
> +static int __npc_subbank_mark_free(struct rvu *rvu, struct npc_subbank *sb)
> +{
> +	int rc, blkaddr;
> +	void *val;
> +
> +	sb->flags = NPC_SUBBANK_FLAG_FREE;
> +	sb->key_type = 0;
> +
> +	bitmap_clear(sb->b0map, 0, npc_priv.subbank_depth);
> +	bitmap_clear(sb->b1map, 0, npc_priv.subbank_depth);
> +
> +	if (!xa_erase(&npc_priv.xa_sb_used, sb->arr_idx)) {
> +		dev_err(rvu->dev,
> +			"%s: Error to delete from xa_sb_used array\n",
> +			__func__);
> +		return -EFAULT;
> +	}
> +
> +	rc = xa_insert(&npc_priv.xa_sb_free, sb->arr_idx,
> +		       xa_mk_value(sb->idx), GFP_KERNEL);
> +	if (rc) {
> +		val = xa_load(&npc_priv.xa_sb_free, sb->arr_idx);
> +		dev_err(rvu->dev,
> +			"%s: Error to add sb(%u) to xa_sb_free array at arr_idx=%d, val=%lu\n",
> +			__func__, sb->idx, sb->arr_idx, xa_to_value(val));
> +	}
> +
> +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> +	rvu_write64(rvu, blkaddr,
> +		    NPC_AF_MCAM_SECTIONX_CFG_EXT(sb->idx),
> +		    NPC_MCAM_KEY_X2);
> +
> +	return rc;
> +}
> +
> +static int __npc_subbank_mark_used(struct rvu *rvu, struct npc_subbank *sb,
> +				   int key_type)
> +

remove extra \n

> +{
> +	int rc;
> +
> +	sb->flags = NPC_SUBBANK_FLAG_USED;
> +	sb->key_type = key_type;
> +	if (key_type == NPC_MCAM_KEY_X4)
> +		sb->free_cnt = npc_priv.subbank_depth;
> +	else
> +		sb->free_cnt = 2 * npc_priv.subbank_depth;
> +
> +	bitmap_clear(sb->b0map, 0, npc_priv.subbank_depth);
> +	bitmap_clear(sb->b1map, 0, npc_priv.subbank_depth);
> +
> +	if (!xa_erase(&npc_priv.xa_sb_free, sb->arr_idx)) {
> +		dev_err(rvu->dev,
> +			"%s: Error to delete from xa_sb_free array\n",
> +			__func__);
> +		return -EFAULT;
> +	}
> +
> +	rc = xa_insert(&npc_priv.xa_sb_used, sb->arr_idx,
> +		       xa_mk_value(sb->idx), GFP_KERNEL);
> +	if (rc)
> +		dev_err(rvu->dev,
> +			"%s: Error to add to xa_sb_used array\n", __func__);
> +
> +	return rc;
> +}
> +
> +static bool __npc_subbank_free(struct rvu *rvu, struct npc_subbank *sb,
> +			       u16 sb_off)
> +{
> +	bool deleted = false;
> +	unsigned long *bmap;
> +	int rc, off;
> +
> +	deleted = __npc_subbank_mark_slot(rvu, sb, sb_off, false);
> +	if (!deleted)
> +		goto done;
> +
> +	__npc_subbank_sboff_2_off(rvu, sb, sb_off, &bmap, &off);
> +
> +	/* Check whether we can mark whole subbank as free */
> +	if (sb->key_type == NPC_MCAM_KEY_X4) {
> +		if (sb->free_cnt < npc_priv.subbank_depth)
> +			goto done;
> +	} else {
> +		if (sb->free_cnt < 2 * npc_priv.subbank_depth)
> +			goto done;
> +	}
> +
> +	/* All slots in subbank are unused. Mark the subbank as free
> +	 * and add to free pool
> +	 */
> +	rc = __npc_subbank_mark_free(rvu, sb);
> +	if (rc)
> +		dev_err(rvu->dev, "%s: Error to free subbank\n", __func__);
> +
> +done:
> +	return deleted;
> +}
> +
> +static int
> +npc_subbank_free(struct rvu *rvu, struct npc_subbank *sb, u16 sb_off)
> +{
> +	bool deleted;
> +
> +	mutex_lock(&sb->lock);
> +	deleted = __npc_subbank_free(rvu, sb, sb_off);
> +	mutex_unlock(&sb->lock);
> +
> +	return deleted ? 0 : -EFAULT;
> +}
> +
> +static int __npc_subbank_alloc(struct rvu *rvu, struct npc_subbank *sb,
> +			       int key_type, int ref, int limit, int prio,
> +			       bool contig, int count, u16 *mcam_idx,
> +			       int idx_sz, bool max_alloc, int *alloc_cnt)
> +{
> +	int cnt, t, b, i, blkaddr;
> +	bool new_sub_bank = false;
> +	unsigned long *bmap;
> +	u16 *save = NULL;
> +	int sidx, eidx;
> +	bool diffbank;
> +	int bw, bfree;
> +	int rc = 0;
> +	bool ret;
> +
> +	/* Check if enough space is there to return requested number of
> +	 * mcam indexes in case of contiguous allocation
> +	 */
> +	if (!max_alloc && count > idx_sz) {
> +		dev_err(rvu->dev,
> +			"%s: Less space, count=%d idx_sz=%d sb_id=%d\n",
> +			__func__, count, idx_sz, sb->idx);
> +		return -ENOSPC;
> +	}
> +
> +	/* Allocation on multiple subbank is not supported by this function.
> +	 * it means that ref and limit should be on same subbank.
> +	 *
> +	 * ref and limit values should be validated w.r.t prio as below.
> +	 * say ref = 100, limit = 200,
> +	 * if NPC_MCAM_LOWER_PRIO, allocate index 100
> +	 * if NPC_MCAM_HIGHER_PRIO, below sanity test returns error.
> +	 * if NPC_MCAM_ANY_PRIO, allocate index 100
> +	 *
> +	 * say ref = 200, limit = 100
> +	 * if NPC_MCAM_LOWER_PRIO, below sanity test returns error.
> +	 * if NPC_MCAM_HIGHER_PRIO, allocate index 200
> +	 * if NPC_MCAM_ANY_PRIO, allocate index 100
> +	 *
> +	 * Please note that NPC_MCAM_ANY_PRIO does not have any restriction
> +	 * on "ref" and "limit" values. ie, ref > limit and limit > ref
> +	 * are valid cases.
> +	 */
> +	if ((prio == NPC_MCAM_LOWER_PRIO && ref > limit) ||
> +	    (prio == NPC_MCAM_HIGHER_PRIO && ref < limit)) {
> +		dev_err(rvu->dev, "%s: Wrong ref_enty(%d) or limit(%d)\n",
> +			__func__, ref, limit);
> +		return -EINVAL;
> +	}
> +
> +	/* x4 indexes are from 0 to bank size as it combines two x2 banks */
> +	if (key_type == NPC_MCAM_KEY_X4 &&
> +	    (ref >= npc_priv.bank_depth || limit >= npc_priv.bank_depth)) {
> +		dev_err(rvu->dev,
> +			"%s: Wrong ref_enty(%d) or limit(%d) for x4\n",
> +			__func__, ref, limit);
> +		return -EINVAL;
> +	}
> +
> +	/* This function is called either bank0 or bank1 portion of a subbank.
> +	 * so ref and limit should be on same bank.
> +	 */
> +	diffbank = !!((ref & npc_priv.bank_depth) ^
> +		      (limit & npc_priv.bank_depth));
> +	if (diffbank) {
> +		dev_err(rvu->dev,
> +			"%s: request ref and limit should be from same bank\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	sidx = min_t(int, limit, ref);
> +	eidx = max_t(int, limit, ref);
> +
> +	/* Find total number of slots available; both used and free */
> +	cnt = eidx - sidx + 1;
> +	if (contig && cnt < count) {
> +		dev_err(rvu->dev,
> +			"%s: Wrong ref_enty(%d) or limit(%d) for count(%d)\n",
> +			__func__, ref, limit, count);
> +		return -EINVAL;
> +	}
> +
> +	/* If subbank is free, check if requested number of indexes is less than
> +	 * or equal to mcam entries available in the subbank if contig.
> +	 */
> +	if (sb->flags & NPC_SUBBANK_FLAG_FREE) {
> +		if (contig && count > npc_priv.subbank_depth) {
> +			dev_err(rvu->dev, "%s: Less number of entries\n",
> +				__func__);
> +			goto err;
> +		}
> +
> +		new_sub_bank = true;
> +		goto process;
> +	}
> +
> +	/* Flag should be set for all used subbanks */
> +	WARN_ONCE(!(sb->flags & NPC_SUBBANK_FLAG_USED),
> +		  "Used flag is not set(%#x)\n", sb->flags);
> +
> +	/* If subbank key type does not match with requested key_type,
> +	 * return error
> +	 */
> +	if (sb->key_type != key_type) {
> +		dev_dbg(rvu->dev, "%s: subbank key_type mismatch\n", __func__);
> +		rc = -EINVAL;
> +		goto err;
> +	}
> +
> +process:
> +	/* if ref or limit >= npc_priv.bank_depth, index are in bank1.
> +	 * else bank0.
> +	 */
> +	if (ref >= npc_priv.bank_depth) {
> +		bmap = sb->b1map;
> +		t = sb->b1t;
> +		b = sb->b1b;
> +	} else {
> +		bmap = sb->b0map;
> +		t = sb->b0t;
> +		b = sb->b0b;
> +	}
> +
> +	/* Calculate free slots */
> +	bw = bitmap_weight(bmap, npc_priv.subbank_depth);
> +	bfree = npc_priv.subbank_depth - bw;
> +
> +	if (!bfree) {
> +		rc = -ENOSPC;
> +		goto err;
> +	}
> +
> +	/* If request is for contiguous , then max we can allocate is
> +	 * equal to subbank_depth
> +	 */
> +	if (contig && bfree < count) {
> +		rc = -ENOSPC;
> +		dev_err(rvu->dev, "%s: no space for entry\n", __func__);
> +		goto err;
> +	}
> +
> +	/* 'save' array stores available indexes temporarily before
> +	 * marking it as allocated
> +	 */
> +	save = kcalloc(count, sizeof(u16), GFP_KERNEL);
> +	if (!save) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
> +
> +	if (contig) {
> +		rc =  __npc_subbank_contig_alloc(rvu, sb, key_type,
> +						 sidx, eidx, prio,
> +						 count, t, b,
> +						 bmap, save);
> +		/* contiguous allocation success means that
> +		 * requested number of free slots got
> +		 * allocated
> +		 */
> +		if (!rc)
> +			*alloc_cnt = count;
> +
> +	} else {
> +		rc =  __npc_subbank_non_contig_alloc(rvu, sb, key_type,
> +						     sidx, eidx, prio,
> +						     t, b, bmap,
> +						     count, save,
> +						     max_alloc, alloc_cnt);
> +	}
> +
> +	if (rc)
> +		goto err;
> +
> +	/* Mark new subbank bank as used */
> +	if (new_sub_bank) {
> +		blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> +		if (blkaddr < 0) {
> +			dev_err(rvu->dev,
> +				"%s: NPC block not implemented\n", __func__);
> +			goto err;
> +		}
> +
> +		rc =  __npc_subbank_mark_used(rvu, sb, key_type);
> +		if (rc) {
> +			dev_err(rvu->dev,
> +				"%s: Error to mark subbank as used\n",
> +				__func__);
> +			goto err;
> +		}
> +
> +		/* Configure section type to key_type */
> +		rvu_write64(rvu, blkaddr,
> +			    NPC_AF_MCAM_SECTIONX_CFG_EXT(sb->idx),
> +			    key_type);
> +	}
> +
> +	for (i = 0; i < *alloc_cnt; i++) {
> +		rc = npc_subbank_idx_2_mcam_idx(rvu, sb, save[i],
> +						&mcam_idx[i]);
> +		if (rc) {
> +			dev_err(rvu->dev,
> +				"%s: Error to find mcam idx for %u\n",
> +				__func__, save[i]);
> +			/* TODO: handle err case gracefully */
> +			goto err;
> +		}
> +
> +		/* Mark all slots as used */
> +		ret = __npc_subbank_mark_slot(rvu, sb, save[i], true);
> +		if (!ret) {
> +			dev_err(rvu->dev, "%s: Error to mark mcam_idx %u\n",
> +				__func__, mcam_idx[i]);
> +			rc = -EFAULT;
> +			goto err;
> +		}
> +	}
> +
> +err:
> +	kfree(save);
> +	return rc;
> +}
> +
> +static int
> +npc_subbank_alloc(struct rvu *rvu, struct npc_subbank *sb,
> +		  int key_type, int ref, int limit, int prio,
> +		  bool contig, int count, u16 *mcam_idx,
> +		  int idx_sz, bool max_alloc, int *alloc_cnt)
> +{
> +	int rc;
> +
> +	mutex_lock(&sb->lock);
> +	rc = __npc_subbank_alloc(rvu, sb, key_type, ref, limit, prio,
> +				 contig, count, mcam_idx, idx_sz,
> +				 max_alloc, alloc_cnt);
> +	mutex_unlock(&sb->lock);
> +
> +	return rc;
> +}
> +
> +static int
> +npc_del_from_pf_maps(struct rvu *rvu, u16 mcam_idx)
> +{
> +	int pcifunc, idx;
> +	void *map;
> +
> +	map = xa_erase(&npc_priv.xa_idx2pf_map, mcam_idx);
> +	if (!map) {
> +		dev_err(rvu->dev,
> +			"%s: failed to erase mcam_idx(%u) from xa_idx2pf map\n",
> +			__func__, mcam_idx);
> +		return -EFAULT;
> +	}
> +
> +	pcifunc = xa_to_value(map);
> +	map = xa_load(&npc_priv.xa_pf_map, pcifunc);
> +	idx = xa_to_value(map);
> +
> +	map = xa_erase(&npc_priv.xa_pf2idx_map[idx], mcam_idx);
> +	if (!map) {
> +		dev_err(rvu->dev,
> +			"%s: failed to erase mcam_idx(%u) from xa_pf2idx_map map\n",
> +			__func__, mcam_idx);
> +		return -EFAULT;
> +	}
> +	return 0;
> +}
> +
> +static int
> +npc_add_to_pf_maps(struct rvu *rvu, u16 mcam_idx, int pcifunc)
> +{
> +	int rc, idx;
> +	void *map;
> +
> +	dev_dbg(rvu->dev,
> +		"%s: add2maps mcam_idx(%u) to xa_idx2pf map pcifunc=%#x\n",
> +		__func__, mcam_idx, pcifunc);
> +
> +	rc = xa_insert(&npc_priv.xa_idx2pf_map, mcam_idx,
> +		       xa_mk_value(pcifunc), GFP_KERNEL);
> +
> +	if (rc) {
> +		map = xa_load(&npc_priv.xa_idx2pf_map, mcam_idx);
> +		dev_err(rvu->dev,
> +			"%s: failed to insert mcam_idx(%u) to xa_idx2pf map, existing value=%lu\n",
> +			__func__, mcam_idx, xa_to_value(map));
> +		return -EFAULT;
> +	}
> +
> +	map = xa_load(&npc_priv.xa_pf_map, pcifunc);
> +	idx = xa_to_value(map);
> +
> +	rc = xa_insert(&npc_priv.xa_pf2idx_map[idx], mcam_idx,
> +		       xa_mk_value(pcifunc), GFP_KERNEL);
> +
> +	if (rc) {
> +		map = xa_load(&npc_priv.xa_pf2idx_map[idx], mcam_idx);
> +		xa_erase(&npc_priv.xa_idx2pf_map, mcam_idx);
> +		dev_err(rvu->dev,
> +			"%s: failed to insert mcam_idx(%u) to xa_pf2idx_map map, earlier value=%lu idx=%u\n",
> +			__func__, mcam_idx, xa_to_value(map), idx);
> +
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool
> +npc_subbank_suits(struct npc_subbank *sb, int key_type)
> +{
> +	mutex_lock(&sb->lock);
> +
> +	if (!sb->key_type) {
> +		mutex_unlock(&sb->lock);
> +		return true;
> +	}
> +
> +	if (sb->key_type == key_type) {
> +		mutex_unlock(&sb->lock);
> +		return true;
> +	}
> +
> +	mutex_unlock(&sb->lock);
> +	return false;
> +}
> +
> +#define SB_ALIGN_UP(val)   (((val) + npc_priv.subbank_depth) & \
> +			    ~((npc_priv.subbank_depth) - 1))
> +#define SB_ALIGN_DOWN(val) ALIGN_DOWN((val), npc_priv.subbank_depth)
> +
> +static void npc_subbank_iter_down(struct rvu *rvu,
> +				  int ref, int limit,
> +				  int *cur_ref, int *cur_limit,
> +				  bool *start, bool *stop)
> +{
> +	int align;
> +
> +	*stop = false;
> +
> +	/* ALIGN_DOWN the limit to current subbank boundary bottom index */
> +	if (*start) {
> +		*start = false;
> +		*cur_ref = ref;
> +		align = SB_ALIGN_DOWN(ref);
> +		if (align < limit) {
> +			*stop = true;
> +			*cur_limit = limit;
> +			return;
> +		}
> +		*cur_limit = align;
> +		return;
> +	}
> +
> +	*cur_ref = *cur_limit - 1;
> +	align = *cur_ref - npc_priv.subbank_depth + 1;
> +	if (align <= limit) {
> +		*stop = true;
> +		*cur_limit = limit;
> +		return;
> +	}
> +
> +	*cur_limit = align;
> +}
> +
> +static void npc_subbank_iter_up(struct rvu *rvu,
> +				int ref, int limit,
> +				int *cur_ref, int *cur_limit,
> +				bool *start, bool *stop)
> +{
> +	int align;
> +
> +	*stop = false;
> +
> +	/* ALIGN_UP the limit to current subbank boundary top index */
> +	if (*start) {
> +		*start = false;
> +		*cur_ref = ref;
> +
> +		/* Find next lower prio subbank's bottom index */
> +		align = SB_ALIGN_UP(ref);
> +
> +		/* Crosses limit ? */
> +		if (align - 1 > limit) {
> +			*stop = true;
> +			*cur_limit = limit;
> +			return;
> +		}
> +
> +		/* Current subbank's top index */
> +		*cur_limit = align - 1;
> +		return;
> +	}
> +
> +	*cur_ref = *cur_limit + 1;
> +	align = *cur_ref + npc_priv.subbank_depth - 1;
> +
> +	if (align >= limit) {
> +		*stop = true;
> +		*cur_limit = limit;
> +		return;
> +	}
> +
> +	*cur_limit = align;
> +}
> +
> +static int
> +npc_subbank_iter(struct rvu *rvu, int key_type,
> +		 int ref, int limit, int prio,
> +		 int *cur_ref, int *cur_limit,
> +		 bool *start, bool *stop)
> +{
> +	if (prio != NPC_MCAM_HIGHER_PRIO)
> +		npc_subbank_iter_up(rvu, ref, limit,
> +				    cur_ref, cur_limit,
> +				    start, stop);
> +	else
> +		npc_subbank_iter_down(rvu, ref, limit,
> +				      cur_ref, cur_limit,
> +				      start, stop);
> +
> +	/* limit and ref should < bank_depth for x4 */
> +	if (key_type == NPC_MCAM_KEY_X4) {
> +		if (*cur_ref >= npc_priv.bank_depth)
> +			return -EINVAL;
> +
> +		if (*cur_limit >= npc_priv.bank_depth)
> +			return -EINVAL;
> +	}
> +	/* limit and ref should < 2 * bank_depth, for x2 */
> +	if (*cur_ref >= 2 * npc_priv.bank_depth)
> +		return -EINVAL;
> +
> +	if (*cur_limit >= 2 * npc_priv.bank_depth)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int npc_idx_free(struct rvu *rvu, u16 *mcam_idx, int count,
> +			bool maps_del)
> +{
> +	struct npc_subbank *sb;
> +	int idx, i;
> +	bool ret;
> +	int rc;
> +
> +	/* Check if we can dealloc indexes properly ? */
> +	for (i = 0; i < count; i++) {
> +		rc =  npc_mcam_idx_2_subbank_idx(rvu, mcam_idx[i],
> +						 &sb, &idx);
> +		if (rc) {
> +			dev_err(rvu->dev,
> +				"Failed to free mcam idx=%u\n", mcam_idx[i]);
> +			return rc;
> +		}
> +	}
> +
> +	for (i = 0; i < count; i++) {
> +		rc =  npc_mcam_idx_2_subbank_idx(rvu, mcam_idx[i],
> +						 &sb, &idx);
> +		if (rc)
> +			return rc;
> +
> +		ret = npc_subbank_free(rvu, sb, idx);
> +		if (ret)
> +			return -EINVAL;
> +
> +		if (!maps_del)
> +			continue;
> +
> +		rc = npc_del_from_pf_maps(rvu, mcam_idx[i]);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int npc_multi_subbank_ref_alloc(struct rvu *rvu, int key_type,
> +				       int ref, int limit, int prio,
> +				       bool contig, int count,
> +				       u16 *mcam_idx)
> +{
> +	struct npc_subbank *sb;
> +	unsigned long *bmap;
> +	int sb_off, off, rc;
> +	int cnt = 0;
> +	bool bitset;
> +
> +	if (prio != NPC_MCAM_HIGHER_PRIO) {
> +		while (ref <= limit) {
> +			/* Calculate subbank and subbank index */
> +			rc =  npc_mcam_idx_2_subbank_idx(rvu, ref,
> +							 &sb, &sb_off);
> +			if (rc)
> +				goto err;
> +
> +			/* If subbank is not suitable for requested key type
> +			 * restart search from next subbank
> +			 */
> +			if (!npc_subbank_suits(sb, key_type)) {
> +				ref = SB_ALIGN_UP(ref);
> +				if (contig) {
> +					rc = npc_idx_free(rvu, mcam_idx,
> +							  cnt, false);
> +					if (rc)
> +						return rc;
> +					cnt = 0;
> +				}
> +				continue;
> +			}
> +
> +			mutex_lock(&sb->lock);
> +
> +			/* If subbank is free; mark it as used */
> +			if (sb->flags & NPC_SUBBANK_FLAG_FREE) {
> +				rc =  __npc_subbank_mark_used(rvu, sb,
> +							      key_type);
> +				if (rc) {
> +					mutex_unlock(&sb->lock);
> +					dev_err(rvu->dev,
> +						"%s:Error to add to use array\n",

use ' ' before Error %s:Error
> +						__func__);
> +					goto err;
> +				}
> +			}
> +
> +			/* Find correct bmap */
> +			__npc_subbank_sboff_2_off(rvu, sb, sb_off, &bmap, &off);
> +
> +			/* if bit is already set, reset 'cnt' */
> +			bitset = test_bit(off, bmap);
> +			if (bitset) {
> +				mutex_unlock(&sb->lock);
> +				if (contig) {
> +					rc = npc_idx_free(rvu, mcam_idx,
> +							  cnt, false);
> +					if (rc)
> +						return rc;
> +					cnt = 0;
> +				}
> +
> +				ref++;
> +				continue;
> +			}
> +
> +			set_bit(off, bmap);
> +			sb->free_cnt--;
> +			mcam_idx[cnt++] = ref;
> +			mutex_unlock(&sb->lock);
> +
> +			if (cnt == count)
> +				return 0;
> +			ref++;
> +		}
> +
> +		/* Could not allocate request count slots */
> +		goto err;
> +	}
> +	while (ref >= limit) {
> +		rc =  npc_mcam_idx_2_subbank_idx(rvu, ref,
> +						 &sb, &sb_off);
> +		if (rc)
> +			goto err;
> +
> +		if (!npc_subbank_suits(sb, key_type)) {
> +			ref = SB_ALIGN_DOWN(ref) - 1;
> +			if (contig) {
> +				rc = npc_idx_free(rvu, mcam_idx, cnt, false);
> +				if (rc)
> +					return rc;
> +
> +				cnt = 0;
> +			}
> +			continue;
> +		}
> +
> +		mutex_lock(&sb->lock);
> +
> +		if (sb->flags & NPC_SUBBANK_FLAG_FREE) {
> +			rc =  __npc_subbank_mark_used(rvu, sb, key_type);
> +			if (rc) {
> +				mutex_unlock(&sb->lock);
> +				dev_err(rvu->dev,
> +					"%s:Error to add to use array\n",
> +					__func__);
> +				goto err;
> +			}
> +		}
> +
> +		__npc_subbank_sboff_2_off(rvu, sb, sb_off, &bmap, &off);
> +		bitset = test_bit(off, bmap);
> +		if (bitset) {
> +			mutex_unlock(&sb->lock);
> +			if (contig) {
> +				rc = npc_idx_free(rvu, mcam_idx, cnt, false);
> +				if (rc)
> +					return rc;
> +
> +				cnt = 0;
> +			}
> +			ref--;
> +			continue;
> +		}
> +
> +		mcam_idx[cnt++] = ref;
> +		sb->free_cnt--;
> +		set_bit(off, bmap);
> +		mutex_unlock(&sb->lock);
> +
> +		if (cnt == count)
> +			return 0;
> +		ref--;
> +	}
> +
> +err:
> +	rc = npc_idx_free(rvu, mcam_idx, cnt, false);
> +	if (rc)
> +		dev_err(rvu->dev,
> +			"%s: Error happened while freeing cnt=%u indexes\n",
> +			__func__, cnt);
> +
> +	return -ENOSPC;
> +}
> +
> +static int npc_subbank_free_cnt(struct rvu *rvu, struct npc_subbank *sb,
> +				int key_type)
> +{
> +	int cnt, spd;
> +
> +	spd = npc_priv.subbank_depth;
> +	mutex_lock(&sb->lock);
> +
> +	if (sb->flags & NPC_SUBBANK_FLAG_FREE)
> +		cnt = key_type == NPC_MCAM_KEY_X4 ? spd : 2 * spd;
> +	else
> +		cnt = sb->free_cnt;
> +
> +	mutex_unlock(&sb->lock);
> +	return cnt;
> +}
> +
> +static int npc_subbank_ref_alloc(struct rvu *rvu, int key_type,
> +				 int ref, int limit, int prio,
> +				 bool contig, int count,
> +				 u16 *mcam_idx)
> +{
> +	struct npc_subbank *sb1, *sb2;
> +	bool max_alloc, start, stop;
> +	int r, l, sb_idx1, sb_idx2;
> +	int tot = 0, rc;
> +	int alloc_cnt;
> +
> +	max_alloc = !contig;
> +
> +	start = true;
> +	stop = false;
> +
> +	/* Loop until we cross the ref/limit boundary */
> +	while (!stop) {
> +		rc = npc_subbank_iter(rvu, key_type, ref, limit, prio,
> +				      &r, &l, &start, &stop);
> +
> +		dev_dbg(rvu->dev,
> +			"%s: ref=%d limit=%d r=%d l=%d start=%d stop=%d tot=%d count=%d rc=%d\n",
> +			__func__, ref, limit, r, l,
> +			start, stop, tot, count, rc);
> +
> +		if (rc)
> +			goto err;
> +
> +		/* Find subbank and subbank index for ref */
> +		rc = npc_mcam_idx_2_subbank_idx(rvu, r, &sb1,
> +						&sb_idx1);
> +		if (rc)
> +			goto err;
> +
> +		dev_dbg(rvu->dev,
> +			"%s: ref subbank=%d off=%d\n",
> +			__func__, sb1->idx, sb_idx1);
> +
> +		/* Skip subbank if it is not available for the keytype */
> +		if (!npc_subbank_suits(sb1, key_type)) {
> +			dev_dbg(rvu->dev,
> +				"%s: not suitable sb=%d key_type=%d\n",
> +				__func__, sb1->idx, key_type);
> +			continue;
> +		}
> +
> +		/* Find subbank and subbank index for limit */
> +		rc = npc_mcam_idx_2_subbank_idx(rvu, l, &sb2,
> +						&sb_idx2);
> +		if (rc)
> +			goto err;
> +
> +		dev_dbg(rvu->dev,
> +			"%s: limit subbank=%d off=%d\n",
> +			__func__, sb_idx1, sb_idx2);

sb_idx1 -> sb2->idx

> +
> +		/* subbank of ref and limit should be same */
> +		if (sb1 != sb2) {
> +			dev_err(rvu->dev,
> +				"%s: l(%d) and r(%d) are not in same subbank\n",
> +				__func__, r, l);
> +			goto err;
> +		}
> +
> +		if (contig &&
> +		    npc_subbank_free_cnt(rvu, sb1, key_type) < count) {
> +			dev_dbg(rvu->dev, "%s: less count =%d\n",
> +				__func__,
> +				npc_subbank_free_cnt(rvu, sb1, key_type));
> +			continue;
> +		}
> +
> +		/* Try in one bank of a subbank */
> +		alloc_cnt = 0;
> +		rc =  npc_subbank_alloc(rvu, sb1, key_type,
> +					r, l, prio, contig,
> +					count - tot, mcam_idx + tot,
> +					count - tot, max_alloc,
> +					&alloc_cnt);
> +
> +		tot += alloc_cnt;
> +
> +		dev_dbg(rvu->dev, "%s: Allocated tot=%d alloc_cnt=%d\n",
> +			__func__, tot, alloc_cnt);
> +
> +		if (!rc && count == tot)
> +			return 0;
> +	}
> +err:
> +	dev_dbg(rvu->dev, "%s: Error to allocate\n",
> +		__func__);
> +
> +	/* non contiguous allocation fails. We need to do clean up */
> +	if (max_alloc) {
> +		rc = npc_idx_free(rvu, mcam_idx, tot, false);
> +		if (rc)
> +			dev_err(rvu->dev,
> +				"%s: failed to free %u indexes\n",
> +				__func__, tot);
> +	}
> +
> +	return -EFAULT;
> +}
> +
> +/* Minimize allocation from bottom and top subbanks for noref allocations.
> + * Default allocations are ref based, and will be allocated from top
> + * subbanks (least priority subbanks). Since default allocation is at very
> + * early stage of kernel netdev probes, this subbanks will be moved to
> + * used subbanks list. This will pave a way for noref allocation from these
> + * used subbanks. Skip allocation for these top and bottom, and try free
> + * bank next. If none slot is available, come back and search in these
> + * subbanks.
> + */
> +
> +static int npc_subbank_restricted_idxs[2];
> +static bool restrict_valid = true;
> +
> +static bool npc_subbank_restrict_usage(struct rvu *rvu, int index)
> +{
> +	int i;
> +
> +	if (!restrict_valid)
> +		return false;
> +
> +	for (i = 0; i < ARRAY_SIZE(npc_subbank_restricted_idxs); i++) {
> +		if (index == npc_subbank_restricted_idxs[i])
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int npc_subbank_noref_alloc(struct rvu *rvu, int key_type, bool contig,
> +				   int count, u16 *mcam_idx)
> +{
> +	struct npc_subbank *sb;
> +	unsigned long index;
> +	int tot = 0, rc;
> +	bool max_alloc;
> +	int alloc_cnt;
> +	int idx, i;
> +	void *val;
> +
> +	max_alloc = !contig;
> +
> +	/* Check used subbanks for free slots */
> +	xa_for_each(&npc_priv.xa_sb_used, index, val) {
> +		idx = xa_to_value(val);
> +
> +		/* Minimize allocation from restricted subbanks
> +		 * in noref allocations.
> +		 */
> +		if (npc_subbank_restrict_usage(rvu, idx))
> +			continue;
> +
> +		sb = &npc_priv.sb[idx];
> +
> +		/* Skip if not suitable subbank */
> +		if (!npc_subbank_suits(sb, key_type))
> +			continue;
> +
> +		if (contig && npc_subbank_free_cnt(rvu, sb, key_type) < count)
> +			continue;
> +
> +		/* try in bank 0. Try passing ref and limit equal to
> +		 * subbank boundaries
> +		 */
> +		alloc_cnt = 0;
> +		rc =  npc_subbank_alloc(rvu, sb, key_type,
> +					sb->b0b, sb->b0t, 0,
> +					contig, count - tot,
> +					mcam_idx + tot,
> +					count - tot,
> +					max_alloc, &alloc_cnt);
> +
> +		/* Non contiguous allocation may allocate less than
> +		 * requested 'count'.
> +		 */
> +		tot += alloc_cnt;
> +
> +		dev_dbg(rvu->dev,
> +			"%s: Allocated %d from subbank %d, tot=%d count=%d\n",
> +			__func__, alloc_cnt, sb->idx, tot, count);
> +
> +		/* Successfully allocated */
> +		if (!rc && count == tot)
> +			return 0;
> +
> +		/* x4 entries can be allocated from bank 0 only */
> +		if (key_type == NPC_MCAM_KEY_X4)
> +			continue;
> +
> +		/* try in bank 1 for x2 */
> +		alloc_cnt = 0;
> +		rc =  npc_subbank_alloc(rvu, sb, key_type,
> +					sb->b1b, sb->b1t, 0,
> +					contig, count - tot,
> +					mcam_idx + tot,
> +					count - tot, max_alloc,
> +					&alloc_cnt);
> +
> +		tot += alloc_cnt;
> +
> +		dev_dbg(rvu->dev,
> +			"%s: Allocated %d from subbank %d, tot=%d count=%d\n",
> +			__func__, alloc_cnt, sb->idx, tot, count);
> +
> +		if (!rc && count == tot)
> +			return 0;
> +	}
> +
> +	/* Allocate in free subbanks */
> +	xa_for_each(&npc_priv.xa_sb_free, index, val) {
> +		idx = xa_to_value(val);
> +		sb = &npc_priv.sb[idx];
> +
> +		/* Minimize allocation from restricted subbanks
> +		 * in noref allocations.
> +		 */
> +		if (npc_subbank_restrict_usage(rvu, idx))
> +			continue;
> +
> +		if (!npc_subbank_suits(sb, key_type))
> +			continue;
> +
> +		/* try in bank 0 */
> +		alloc_cnt = 0;
> +		rc =  npc_subbank_alloc(rvu, sb, key_type,
> +					sb->b0b, sb->b0t, 0,
> +					contig, count - tot,
> +					mcam_idx + tot,
> +					count - tot,
> +					max_alloc, &alloc_cnt);
> +
> +		tot += alloc_cnt;
> +
> +		dev_dbg(rvu->dev,
> +			"%s: Allocated %d from subbank %d, tot=%d count=%d\n",
> +			__func__, alloc_cnt, sb->idx, tot, count);
> +
> +		/* Successfully allocated */
> +		if (!rc && count == tot)
> +			return 0;
> +
> +		/* x4 entries can be allocated from bank 0 only */
> +		if (key_type == NPC_MCAM_KEY_X4)
> +			continue;
> +
> +		/* try in bank 1 for x2 */
> +		alloc_cnt = 0;
> +		rc =  npc_subbank_alloc(rvu, sb,
> +					key_type, sb->b1b, sb->b1t, 0,
> +					contig, count - tot,
> +					mcam_idx + tot, count - tot,
> +					max_alloc, &alloc_cnt);
> +
> +		tot += alloc_cnt;
> +
> +		dev_dbg(rvu->dev,
> +			"%s: Allocated %d from subbank %d, tot=%d count=%d\n",
> +			__func__, alloc_cnt, sb->idx, tot, count);
> +
> +		if (!rc && count == tot)
> +			return 0;
> +	}
> +
> +	/* Allocate from restricted subbanks */
> +	for (i = 0; restrict_valid &&
> +	     (i < ARRAY_SIZE(npc_subbank_restricted_idxs)); i++) {
> +		idx = npc_subbank_restricted_idxs[i];
> +		sb = &npc_priv.sb[idx];
> +
> +		/* Skip if not suitable subbank */
> +		if (!npc_subbank_suits(sb, key_type))
> +			continue;
> +
> +		if (contig && npc_subbank_free_cnt(rvu, sb, key_type) < count)
> +			continue;
> +
> +		/* try in bank 0. Try passing ref and limit equal to
> +		 * subbank boundaries
> +		 */
> +		alloc_cnt = 0;
> +		rc =  npc_subbank_alloc(rvu, sb, key_type,
> +					sb->b0b, sb->b0t, 0,
> +					contig, count - tot,
> +					mcam_idx + tot,
> +					count - tot,
> +					max_alloc, &alloc_cnt);
> +
> +		/* Non contiguous allocation may allocate less than
> +		 * requested 'count'.
> +		 */
> +		tot += alloc_cnt;
> +
> +		dev_dbg(rvu->dev,
> +			"%s: Allocated %d from subbank %d, tot=%d count=%d\n",
> +			__func__, alloc_cnt, sb->idx, tot, count);
> +
> +		/* Successfully allocated */
> +		if (!rc && count == tot)
> +			return 0;
> +
> +		/* x4 entries can be allocated from bank 0 only */
> +		if (key_type == NPC_MCAM_KEY_X4)
> +			continue;
> +
> +		/* try in bank 1 for x2 */
> +		alloc_cnt = 0;
> +		rc =  npc_subbank_alloc(rvu, sb, key_type,
> +					sb->b1b, sb->b1t, 0,
> +					contig, count - tot,
> +					mcam_idx + tot,
> +					count - tot, max_alloc,
> +					&alloc_cnt);
> +
> +		tot += alloc_cnt;
> +
> +		dev_dbg(rvu->dev,
> +			"%s: Allocated %d from subbank %d, tot=%d count=%d\n",
> +			__func__, alloc_cnt, sb->idx, tot, count);
> +
> +		if (!rc && count == tot)
> +			return 0;
> +	}
> +
> +	/* non contiguous allocation fails. We need to do clean up */
> +	if (max_alloc)
> +		npc_idx_free(rvu, mcam_idx, tot, false);
> +
> +	dev_dbg(rvu->dev, "%s: non-contig allocation fails\n",
> +		__func__);
> +
> +	return -EFAULT;
> +}
> +
> +
> +void npc_cn20k_deinit(struct rvu *rvu)
> +{
> +	int i;
> +
> +	xa_destroy(&npc_priv.xa_sb_used);
> +	xa_destroy(&npc_priv.xa_sb_free);
> +	xa_destroy(&npc_priv.xa_idx2pf_map);
> +	xa_destroy(&npc_priv.xa_pf_map);
> +
> +	for (i = 0; i < npc_priv.pf_cnt; i++)
> +		xa_destroy(&npc_priv.xa_pf2idx_map[i]);
> +
> +	kfree(npc_priv.xa_pf2idx_map);
> +	kfree(npc_priv.sb);
> +	kfree(subbank_srch_order);
> +}
> +
> +int npc_cn20k_init(struct rvu *rvu)
> +{
> +	int err;
> +
> +	err = npc_priv_init(rvu);
> +	if (err) {
> +		dev_err(rvu->dev, "%s: Error to init\n",
> +			__func__);
> +		return err;
> +	}
> +
> +	npc_priv.init_done = true;
> +
> +	return 0;
> +}
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
> new file mode 100644
> index 000000000000..26da0a2c717a
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
> @@ -0,0 +1,110 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Marvell RVU Admin Function driver
> + *
> + * Copyright (C) 2026 Marvell.
> + *
> + */
> +
> +#ifndef NPC_CN20K_H
> +#define NPC_CN20K_H
> +
> +#define MAX_NUM_BANKS 2
> +#define MAX_NUM_SUB_BANKS 32
> +#define MAX_SUBBANK_DEPTH 256
> +
> +/**
> + * enum npc_subbank_flag - NPC subbank status
> + *
> + * subbank flag indicates whether the subbank is free
> + * or used.
> + *
> + * @NPC_SUBBANK_FLAG_UNINIT: Subbank is not initialized.
> + * @NPC_SUBBANK_FLAG_FREE: Subbank is free.
> + * @NPC_SUBBANK_FLAG_USED: Subbank is used.
> + */
> +enum npc_subbank_flag {
> +	NPC_SUBBANK_FLAG_UNINIT,
> +	NPC_SUBBANK_FLAG_FREE = BIT(0),
> +	NPC_SUBBANK_FLAG_USED = BIT(1),
> +};
> +
> +/**
> + * struct npc_subbank - Subbank fields.
> + * @b0b:	Subbanks bottom index for bank0
> + * @b1b:	Subbanks bottom index for bank1
> + * @b0t:	Subbanks top index for bank0
> + * @b1t:	Subbanks top index for bank1
> + * @flags:	Subbank flags
> + * @lock:	Mutex lock for flags and rsrc mofiication

mofiication -> modification

> + * @b0map:	Bitmap map for bank0 indexes
> + * @b1map:	Bitmap map for bank1 indexes
> + * @idx:	Subbank index
> + * @arr_idx:	Index to the free array or used array
> + * @free_cnt:	Number of free slots in the subbank.
> + * @key_type:	X4 or X2 subbank.
> + *
> + * MCAM resource is divided horizontally into mutltiple subbanks and

mutltiple -> multiple

> + * Resource allocation from each subbank is managed by this data
> + * structure.
> + */
> +struct npc_subbank {
> +	u16 b0t, b0b, b1t, b1b;
> +	enum npc_subbank_flag flags;
> +	struct mutex lock;	/* Protect subbank resources */
> +	DECLARE_BITMAP(b0map, MAX_SUBBANK_DEPTH);
> +	DECLARE_BITMAP(b1map, MAX_SUBBANK_DEPTH);
> +	u16 idx;
> +	u16 arr_idx;
> +	u16 free_cnt;
> +	u8 key_type;
> +};
> +
> +/**
> + * struct npc_priv_t - NPC private structure.
> + * @bank_depth:		Total entries in each bank.
> + * @num_banks:		Number of banks.
> + * @num_subbanks:	Number of subbanks.
> + * @subbank_depth:	Depth of subbank.
> + * @kw:			Kex configured key type.
> + * @sb:			Subbank array.
> + * @xa_sb_used:		Array of used subbanks.
> + * @xa_sb_free:		Array of free subbanks.
> + * @xa_pf2idx_map:	PF to mcam index map.
> + * @xa_idx2pf_map:	Mcam index to PF map.
> + * @xa_pf_map:		Pcifunc to index map.
> + * @pf_cnt:		Number of PFs.A

remove extra A

> + * @init_done:		Indicates MCAM initialization is done.
> + *
> + * This structure is populated during probing time by reading
> + * HW csr registers.
> + */
> +struct npc_priv_t {
> +	int bank_depth;
> +	const int num_banks;
> +	int num_subbanks;
> +	int subbank_depth;
> +	u8 kw;
> +	struct npc_subbank *sb;
> +	struct xarray xa_sb_used;
> +	struct xarray xa_sb_free;
> +	struct xarray *xa_pf2idx_map;
> +	struct xarray xa_idx2pf_map;
> +	struct xarray xa_pf_map;
> +	int pf_cnt;
> +	bool init_done;
> +};
> +
> +struct rvu;
> +
> +struct npc_priv_t *npc_priv_get(void);
> +int npc_cn20k_init(struct rvu *rvu);
> +void npc_cn20k_deinit(struct rvu *rvu);
> +
> +void npc_cn20k_subbank_calc_free(struct rvu *rvu, int *x2_free,
> +				 int *x4_free, int *sb_free);
> +
> +int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
> +			    int prio, u16 *mcam_idx, int ref, int limit,
> +			    bool contig, int count);
> +int npc_cn20k_idx_free(struct rvu *rvu, u16 *mcam_idx, int count);
> +#endif /* NPC_CN20K_H */

Thanks,
Alok

