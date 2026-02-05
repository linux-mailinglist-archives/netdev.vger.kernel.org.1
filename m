Return-Path: <netdev+bounces-256942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB4SEagLhGl5xQMAu9opvQ
	(envelope-from <netdev+bounces-256942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 04:16:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBE2EE414
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 04:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 366453004F0A
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 03:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CAA217F27;
	Thu,  5 Feb 2026 03:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UgEVVCk8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yH/y5VV+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6431224D6
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 03:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770261412; cv=fail; b=SBbJWmwdExFrsObiRhO42alc7Tij2MfzU93loqYDUaSXtphm0FWwmoV2I74b7ppu29lh3zlmNvJFzRjdFfFsl/SObz7iAkHlozYIRD2HnP0UgwQnmU4P4XJDe9mpOOBUmYv97OQiUOIaSp952/hZlZE+ccCQnDcvrEL9n0C2364=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770261412; c=relaxed/simple;
	bh=zdccYDWkUjY6yfyPlFE8jUz4+SsFmQc3cxJ2VS2hMVU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jLdzSADziCsleKvVnBRFfBpPjsOhjiwnvsZhRLi4HyxHvtzTKiT2+/M+SN8Nkj+JTFId5w0tV1sS0QfV0ZVNdULfCMko5dQNCQ1i/YvDVxVyCtAurc2W27ZA6InrrpizF0MGcPbR2Y7v699HkFlhc5DJWrSVUAox/AoVx94Xufw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UgEVVCk8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yH/y5VV+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614N46cX3258020;
	Thu, 5 Feb 2026 03:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=h0cnDYQUSxRUWimBw6+OrTm3/2/VKNu6L5TPa48DvYM=; b=
	UgEVVCk87euAB4uT8JFzJMjUAVvISn8IUBtUT+PQ2lRZ/mrpkiLBtuc/PNEvz0JF
	9LqamzTS/NoTb6B1L+UZx+++t/w2EWc4GggLZ5kjPIcdXQ/qvKrGNvK5SpNWFOvZ
	l6kwWxtHraD3RT4W4sJF/29alytGifIYJDUGIjBMWpQwt29Q5ED4cs1jBe3HUucX
	X/lHgMFBnyvBX7qNIpSY7ipelMf8/sQ4/SWZBUwfB45GeUTGeRIC8M/8xZqIUYhg
	xJKY3fjpPRRi8Gs82kiFKEUNz42m4gHBWygUF86ysg6x0uEUcbbp8qZTDf5UuoX9
	uLrTli1C32AxpYsZybVQQA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3jsqjyyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 03:16:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61518Z8R025765;
	Thu, 5 Feb 2026 03:16:36 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012005.outbound.protection.outlook.com [40.93.195.5])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c257b1302-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 03:16:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFf/6dbof31588uCDc8B4nrfwPvKt7lJBwQM5WxztC8BHdhZvb/3FoDqIPo+nHwgn+IvWLpqlbmfFeeuRsXJiWN2V5XFYHiElkqlv1X7jkthgXIfycyHJQgCbAPV3IVXQUjKh6sNewGhelC20/n6cpl8IqfK7TdpAL87X2nreLAV8lzhI3OCzFYCJAdfz9o6RaYRvR6Rv1ttBb029ojDonK2RHY9+wdrx8xR1TteeVDXfzym6eUerX3XgA0YKBaUm6FELFk4cRDDfcE3L6QF3c8ISezrEt/fgH7sb/63jsLYQ1FvrMWEAk05CTWLhwNAHDS6xIfIIVS6LgBV/9P1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0cnDYQUSxRUWimBw6+OrTm3/2/VKNu6L5TPa48DvYM=;
 b=eLVlNTG0v9jGSGSvi5xYlsiv1jImH0gsg1Hu3iAhwOXnG1qFv4JzUx3eTIPRNbtWjKoG2yBmyanpxI+Jb9vzyvYSz0CA9EGfP7zGNTYvDuqI8VSBNWUQTPEYDVVHLJGtrqxEnLdJV5RSyMuONJb3ntLno48c3ZEcUR0FnEoAEkWyK+3YKJZ+aofW/JWnpjIQekxqrcU/o7xhjrEfL68rF2P8Lj9CQdB2Ziby8h9pNQWtjap+8g6vCXmunJVk6DzXkgNY3BiLj8/sah2k3Ka/mXET8ESHKxX7RyTHEGnk9zFBR3vdiaai/qEK37YK6DHVSkHsuTumxg/sVNI5gzgG8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0cnDYQUSxRUWimBw6+OrTm3/2/VKNu6L5TPa48DvYM=;
 b=yH/y5VV+Fx7YXjY9yp6w44e6tfKuCz9WxpPzi0lsrJyA0g3buhbtpbykn523/DjV/M84feIG9BfD5Kzka1++WONltRC1ZqZIrs2WqmPRDlC8y+uDfVDtCHaYm4jemLYuFbES//5Lg2tUKY6Xn2s11kigFOxBPcGiIrdGiF/fglo=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by BL3PR10MB6188.namprd10.prod.outlook.com (2603:10b6:208:3bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 03:16:32 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 03:16:31 +0000
Message-ID: <e60ec48e-6b4f-4a32-bfc9-c29ee4f30be4@oracle.com>
Date: Thu, 5 Feb 2026 08:46:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net-next] net: marvell: prestera: fix FEC
 error message for SFP ports
To: Jakub Kicinski <kuba@kernel.org>, Elad Nachman <enachman@marvell.com>
Cc: Jonas Gorski <jonas.gorski@gmail.com>,
        "Taras Chornyi [C]" <tchornyi@marvell.com>,
        "Volodymyr Mytnyk [C]" <vmytnyk@marvell.com>,
        Yevhen Orlov <yevhen.orlov@plvision.eu>,
        "Vadym Kochan [C]" <vkochan@marvell.com>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "alok.a.tiwarilinux@gmail.com" <alok.a.tiwarilinux@gmail.com>
References: <20260202052816.28191-1-alok.a.tiwari@oracle.com>
 <795c3351-d65b-4a9a-83dc-b530177b9d28@gmail.com>
 <20260203191517.024dab80@kernel.org>
 <BL1PR18MB4248EFE8E7D182A5601927E1DB98A@BL1PR18MB4248.namprd18.prod.outlook.com>
 <20260204182758.7ba3fd43@kernel.org>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20260204182758.7ba3fd43@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0384.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::18) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|BL3PR10MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: d87b1faf-31a8-474b-7b33-08de6464f5ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDFoS1FPUXdBU3A3ZzdUamhIbE94U2RJOWIwdzltTWMwYUVCc2h0ZjFKRm1i?=
 =?utf-8?B?Q042ajM5cjcvNTZvQ1dLTnMxQTNDMFgvRUpZNm5BemovdGFPSHpKalNXMU85?=
 =?utf-8?B?bkUxUzVtcEV0QkF1VzBwcnY3WjU2QXUvU2NoZUY3eEsyMUR1ZUx6SXN5K2Iy?=
 =?utf-8?B?c1gxNVEvRkNMQyt1blJSSk1PVGV2VFRMLy9SR2RDMjNpWHNaMEVwcjhKSWxF?=
 =?utf-8?B?OENMcEQ2TSsyL2EvaGlXVmFlMFhsQ05oelR5TTlFN1BqYUU0R3d3MFppL1hH?=
 =?utf-8?B?bGxXUWRPZEt5SlhUWU0zWTNBZEhlUm0wWFR3YWtoem0yVExEODZ1N0VsM3BE?=
 =?utf-8?B?b2tUb3o2Q0p1c3V5M05CUjd2a3hmb25yUURETVRnYjJSdGNtWlRwY3M4cTBF?=
 =?utf-8?B?WnlGY2pFditHcjZOYmdERyt0VmF3d1kySHdYcDhjTDNIYVBRU3NEQk1IOXdi?=
 =?utf-8?B?Wll1RGdNbWJ2aTBMUjc1WFV3eXNPcUtsZFhSdE9OVllWN1lEaXQzQWdkODlX?=
 =?utf-8?B?cVNBT2JSVDkvdjJDdElncU0zU01pTVJkSzBCS1VieXowZ2o0SFFXMFRtNmhx?=
 =?utf-8?B?M3Rzc3Z1SHpPdnVybk55OXhIVDlwbVVPNlBtZDlPSzFuQ1NxZEdwR2Z5VlNp?=
 =?utf-8?B?VmZGQjlUOS9kaUpHaHhlQ0FvNEJ3MW0yRmtHMzRNSzVMYS9mVkxDcnZsTVBL?=
 =?utf-8?B?T1JlL2JCYk1Sd2E2TXlNK2VEU1I0R28yeFRGK1ZtV2Z5c3hGaTdWTTBKbUNJ?=
 =?utf-8?B?ZFlLZ05tVHJjWlFZTVZydmxhNm9rUlJZYkdDcGtXQ3RxeE5kWGhVdVRjclJo?=
 =?utf-8?B?RkFNU3U0MzN0WHNBeG82eDk5YmlqRTJJU2RPZjRjZzU2SkJZbHFCelBVeGlB?=
 =?utf-8?B?bTdjUkVxK3lPOEVaTnpyMHhTOEtYQzl2VTI2NjNNOGpwWkpEcGNvalRZWlRa?=
 =?utf-8?B?SEhDRjljTWJXWC9xeDZ4YXFxOW1ZNjdWeTJqTVJFNkt4cloreld5QW1qYkVt?=
 =?utf-8?B?bDhpVmN1NDBPb2JnMFdvOVZCcFo2VjA5ZWVVNmMrWE4yQkR6U3ExZk5qM3kz?=
 =?utf-8?B?M1ArVTk5OC9RZGpENDB0MUtlcnIwRlJoaGJoNWNxQWcwdlJ4ZXVDcDliSVha?=
 =?utf-8?B?c3dyY3pUek1OSGNmNXBMaFUzRVMzOEtzS25CejR1RU10cWF6eGRKNXArRkhJ?=
 =?utf-8?B?bXA3SmJuTXA0b0hQUVdZRWVCMXpNK2JhQ3l2VlNFOXBQQ2ordDRJTTNTaExp?=
 =?utf-8?B?UXJjT3FtRDNqV0tlQkZ5eG5NSHB1YjhDek1xWWhRSFkxaG5XdklVQlVMeG5J?=
 =?utf-8?B?QWVoMlc5aHpXMFhRSVlFNGR4OWZWSEhWNGFJL1Zoblc4MjluK0hCTURqZnNK?=
 =?utf-8?B?dE5rSFRTdGlGaVFJSDIyM045RTd5SkF1cnEvYzBBV1ZDem8wUkVobEtEMXNM?=
 =?utf-8?B?VFZDdXFtVlRmYzVDSThzaDB2enVlZXRURG82bWE0T29GcVhWbUdnUHJZNXdH?=
 =?utf-8?B?cjI0TE4rdS9wcEhmaks2SmJQU0ZqdEFLNjB6cGNiR1ZJcXBIU0tZNndmNThU?=
 =?utf-8?B?YWgyQWdraXJhQW1GSXZlWEZoRTFmS25rSENCallFN0JBYjF6Zy9CRTFxdk92?=
 =?utf-8?B?dUdRdHZNVktkaXN2NDllcHZrd1V1SFJHbHB0RThoY2pPZHRmVm8wVDY3ZW9L?=
 =?utf-8?B?YVJ4VTM3S3dYc2xBMUQralp6RVFqS0oveERxTzRvdWJZZVJmbUNEVFRkR3Bn?=
 =?utf-8?B?aXVHVC9iUDdSaStJdHNrczEvWk5JdGJlOFNhaEN1UmsyakZja2l1SGZBR1RG?=
 =?utf-8?B?VllVMFQxNDBxYmNJQ3RybHBoMDd5eFFkeFprZWZMRWdid2RXM3RnQkV5WDhr?=
 =?utf-8?B?NzVTbHRWY0hKTlNKMmV6dEtRMXIwNk1aSFdhM3d3MXlNZTlRNEdaTE1xUUpD?=
 =?utf-8?B?YkVPZlg2bFlQdm80aUZwZWxoYWppeEcrMDBXbHBPeXNFY1Y4Ui91cEJiYmt1?=
 =?utf-8?B?VVhMd0xmVktaVUtWMnJnVFZlUjd1UmJGSGQ5SFJtRFV5dDZiWjMwczhVVFll?=
 =?utf-8?B?N2FFeGcyejNycjVMSE5TSmpabXRGclk0OVo3K0w3OEN5TXFJNkI3aUgrL1Ny?=
 =?utf-8?Q?C9xA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHN5dDN0a3R3QnYzUm9ZTDdZbUU2SHhDVnVXUVphbnVKbDZ2WXU2SW9QOHVa?=
 =?utf-8?B?Y0FIbThqTzNLUjB1V0hueGZhQStGUlFGM1JYZXQ2MzZZbzVFQkNlNWltRDVY?=
 =?utf-8?B?RWpvM1dyM3FwREJHditRMTlMV3VlUlQveTA0OXhYTjVZSUs1STlvbHdYWUYw?=
 =?utf-8?B?a0J5UjlUa3d4eUNpT3FLRnFtNFIwSUsyU0NpUS9SU29LeGJlWno0ZCt6OE1n?=
 =?utf-8?B?ZVE1UWpodVQ1M0RCNFY3WnlpNmtCN3A1eFhkUVdsMWxickdrSzlXMWRJTmN1?=
 =?utf-8?B?eFZ2cEV1cFhKS2I0WUFXcUZBSEs0UzFmcC9MSXhWU1lmZ3g4SC9KRVk2Wm5P?=
 =?utf-8?B?U0JuK3RaWWpBeVhMSWF4TGdqcWxVcUIvT1U0WXRzd04wVE41MXhXNjNGZVBL?=
 =?utf-8?B?U1gyejkvWXRyMVpYd2ZLL0VzUVRwZHVkV0Y0MDE4OC9JaExXMGNvTVk1NGlK?=
 =?utf-8?B?Vzl6dTJnNTRFdGltdWY5dGE4S3pxc044U0MrYUpVcWZlVVJZSE5BaE1pNERL?=
 =?utf-8?B?NDF6Tm91cFNNQzEzZnN4bnBCY2ZiTDVRZ2grQWtRYWdWVmQwakdZZXlWMUtL?=
 =?utf-8?B?a1pja1NTQnZpNkZkcStWQ1Q2YUJCWHpjRE14YncydDdvZURkb25lTU5xNnFJ?=
 =?utf-8?B?dWNXWGh0dUVWVjRWajkvTGxoVHlzQmVKZ1djb3NyNFJhWmtmRjZ4SEFveDlm?=
 =?utf-8?B?MkRzVGJpNFY2K0hDYW11RHlUc0l5MHhQWU9BK0RFZVBIWDMrY0xsV3lSU2xp?=
 =?utf-8?B?SHQrdnBvRWFRV1VhRGNuY2NtQ1VjbU5MbWpQSUxQNHVWNXQ1K3gwVTYveHBo?=
 =?utf-8?B?SStEZzA4MkVjNzNFcm94WXFpWkptVUtDRVJGM0U3TkYxVzBKM1pSZ2I1SVR0?=
 =?utf-8?B?V3VuaTYyVE1QTFY3UFdRdjVxSzczWG9LWHZLcElZZktBOTVqc2dhbEU5dmhq?=
 =?utf-8?B?ZDBtbndJYkhkU3A3eTM1VVRDbUVsdzZPd0tNSzRBNVJVSnpGVkJzY041dHF2?=
 =?utf-8?B?bWdoZjJ4L1B6Yjc1SzFuOVlaOEhyd0plRDlSS24yWVBMMUc1c2prVGc2K3Ns?=
 =?utf-8?B?ckdxTlVLVEczTkR3cUNkdkZQUnQ2dFp0ajNiTzJwQVFCTHFzcFVZVjJOa0pR?=
 =?utf-8?B?V3FIREJMTG5WL05FTzNMK2pxNk8rZGZEa0JheEovWWgrMUg3T3BPWmNNUFBz?=
 =?utf-8?B?Y2tkMFhzSFNHQk96RW1HOTROQ2VieXhGU1ZZRVJBa1d3MWhTWlIvTWZZdmRO?=
 =?utf-8?B?T2E4RUVoRkRzQkZrMXhvNzNFakRhQW5HaEdycTAzOUFvOTNQbStmVUloRmtG?=
 =?utf-8?B?UWZReHJqbVpSR0ZxSVIxSVFlYjRBTUp0SGpTN3c0VVp0KzVwQnpXV2tLcEVW?=
 =?utf-8?B?ZmQ3OE5WTlljTTNZcGdsclZ3azBhL0JxR3RQajd3T3krWDY0VERPNnc3cW9B?=
 =?utf-8?B?VDdKajVOZHYxUG5QMitmamVmeld3S2ZzRlFCOUkwc240d0t3am5IZlBWbE1p?=
 =?utf-8?B?VXJ3cThtODdQek92VllDRFA0d0YvZHZqRkFVeXh0bnlqeE00SXBiN2JVbng2?=
 =?utf-8?B?TWRqZGxhUFVLU2Fwa2w5T3JBMlQwWGJhTzN2VkorM0NZc2orY3U1NlVOcUJK?=
 =?utf-8?B?T0Z1NXptUWVNdG1MUnppd2tsTlFtaWlSc3hkallraFh0MWVTNXRFaEI4OFhN?=
 =?utf-8?B?eC9KTC81NVpMcHJQa3N5SUllVnVIb0dPVEk5VjF1NnpJejhvREFQV1dUWEQ4?=
 =?utf-8?B?UVdnTXd6cERKOEtTdmVsaGdOWXFkemZPa2x5endPRVNRY1hnclNmK2hMOWJu?=
 =?utf-8?B?Q0ZkK3ZpVkh0Z2ZqN05iZnJIVnM5VDZmTXBDZTIvZ1JEYlhXMUViN3BYc1VG?=
 =?utf-8?B?MHpMNE5hUnJIVkcrMVlzTHJ2bGM2ZThrTzI2cEN5Z3hqTVp4RnpOREZqUzZZ?=
 =?utf-8?B?SWhlSVZmWXFuNGVDUnovN2dScHVHRElFTng0b2NKbkdLUmV5d3I0U0NQRFFS?=
 =?utf-8?B?djFkWHRsZk1WS2dMZmpzc0NiOXhNMEJLWUJCd3ZJd0h0dmZQS1RPMSt0cUtx?=
 =?utf-8?B?eGtNdEQyd3VGbC9jeUdmK3prRGZuaTBqSXNVMEpyYXdYdkRGNVBVRU9lRWJp?=
 =?utf-8?B?M0UzT0RNVllSd0VkdVMwYTdFTnQyUnc3cHhOZW5kUWg3NTJxQW85U1hzSjhI?=
 =?utf-8?B?L3owY1M2Vk1HczN0VFpFWkRHd1JaL280cDU3WjE0ODJFSDBwTks0K3poekFq?=
 =?utf-8?B?U1l2dlY1Q3QxQm1GT0ZqV2ROL1AvTGh3dVRJOEFCMWlJMm92RkE1cXZZN2Ez?=
 =?utf-8?B?NTZiQkFzUUVsSXc5NDhIa0RoZ1ZiT1RKOGl6NHAyY3l0Zy94VDg3WWhDVFZP?=
 =?utf-8?Q?nTbmLeurtvmqukHk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aUn95FJomYSa2I2055Vgfl4SnAmkohUO8Iz8yGG3oY6xG1NPXbSYzmTG7VuX240ynmdnIlyJxfvd8HmU0NJR6VDEMfphZTJZQFbjsIMf23ZDktb50OMbVC++cOaZYQG/C4dXQbyYKQhzHhcUakEMEA4mG7XcV/Xb0aW1X3t17evsoIVroXP1u1EX/vZtn3NEevKWh6t56hDiZGi1Vg8X/lD9B9cIl/QMQUpMWM41E1i16S/aZgEQgUfbZ19odPAlx0zS0eO4qEa4Hfb6OIbhLnxCB9UxnGhZ9gio+RnXvlCVQetxtR8RBNQIgkDXDReC8eMYSPNmYPIC1vjs8gyx8RS8Yrp08J5zAKBLiSevJhvPmgpbAZ9OZwvrIJT3a+jNUk1oHoP6mA6kkSwOyRBydZIrJgW75X3+fhb6xK1I1Iz7jX3pFOhEEExHnbpQ8F635QuTCS9yplPSDYM/twJ4NUNqDjoj97k/yok6kXsWPU1Dd/u5qao9S19gv5ocuvoTH1Mab+/A6Lc/Y607kuXImCx1/DCJWSynQjfiCHLvBFxwkwQOPpTifGT4nuML4ktu7fpfaCCVX9NACVjRY3sRzQRNVoWSrd9pO1LvyS2Gqog=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87b1faf-31a8-474b-7b33-08de6464f5ac
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 03:16:31.7854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1t5w/ht7QVwKcDUBLoA2To0UhK7a7X+njLxnYyzvCPFOZB3nT1/JbtX1haIMV49dF1f4aZomqQEjKSCNhYGGAIGi/iIdk0Ps5vXEPUyWf2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_08,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602050019
X-Authority-Analysis: v=2.4 cv=Db0aa/tW c=1 sm=1 tr=0 ts=69840b95 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0pLChrmhRn1KBhwUQrgA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13644
X-Proofpoint-ORIG-GUID: bcpcunrsZpQfGyd9bi-Q72k924rorLEt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDAxOSBTYWx0ZWRfX9m0OF6DEQzuI
 GN7M+d0IzFMfA3vlXuMmIUxCaDpgJgRTt4XhDr5ZEillPoUdzktHsYm/P8EMGpWEGy15rzOBGVO
 rns1TsjJJZD6czn3OxQ4tufBpwryyUTH9oDm6W15kwde54Vrve7tJVB29DwDkqRzMwntNQxzMrQ
 vTk4x/C0MC04aqtSQQzyvAQQhEl3kCrKGFb0ocsn4FI6kPXGL89Swcc4XfaT0NYfbvmJjD27ocg
 gHC3JE419lA8viGQmWgfgy5Ivnu3E5nWRYM6IzDCKt1aZaLfo4Feo+9FqR6IRC2OO8L8A5kR1l6
 ZD58tGgLQ6SIFa+T5hXw2ZlqlUiR2b8Ng3AL1C/W045ctsM1dUChZuABqK9PaSpWxHlfHfnCVAb
 Ij74Xp7cZuZnShzNCfMKZOnQMyhtoapxU13avXoVla3E9eJAc1Inb9yKCSePpeUVrpndSIQmJhl
 kQSQJ1QqPeGto/kplfnS4BLPQjDiwNb2YrTO5LaU=
X-Proofpoint-GUID: bcpcunrsZpQfGyd9bi-Q72k924rorLEt
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256942-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,marvell.com,plvision.eu,redhat.com,google.com,davemloft.net,lunn.ch,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CDBE2EE414
X-Rspamd-Action: no action



On 2/5/2026 7:57 AM, Jakub Kicinski wrote:
> On Wed, 4 Feb 2026 13:13:31 +0000 Elad Nachman wrote:
>>>> I'm pretty sure that the condition here is wrong, not the error message.
>>>>
>>>> AFAIK it doesn't make sense to configure FEC on ethernet/copper ports,
>>>> but for SFP ports, it may be required depending on the transceiver or
>>>> cable used, especially for fiber modules.
>>>>
>>>> I may be wrong though.
>>>>
>>>> This check was introduced with bb5dbf2cc64d ("net: marvell: prestera:
>>>> add firmware v4.0 support"), but that commit does not offer any
>>>> explanation for it in the commit message.
>>>
>>> Elad, could you clarify this? A bit hard to tell whether CR is included
>>> in "SFP" from glancing at the code.
>>
>> Basically, the supported devices have FEC on 10G-BASE-KR and upwards
>> (CR: from 40G-BASE-CR), and for USXGMII SERDES, which drives multiple
>> copper PHYs.
>>
>> Judging based on all of the above,
>> I think it is best to remove this check (plus said error message)
>> altogether and let the firmware return an error if the mode/speed/FEC
>> combination is invalid.
> 
> SG, thanks for explaining
> 
> Alok, pls respin as suggested.

Thanks for the clarification.
I will send a v2 that removes the "port->caps.transceiver == 
PRESTERA_PORT_TCVR_SFP"
check and lets the firmware handle validation.

Thanks,
Alok

