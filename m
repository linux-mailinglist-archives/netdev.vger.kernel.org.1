Return-Path: <netdev+bounces-239958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 142A7C6E79C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 15B892EE46
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC80C3587A9;
	Wed, 19 Nov 2025 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JO0Ci3oo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oIoPqyhZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0AF351FB4;
	Wed, 19 Nov 2025 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555353; cv=fail; b=rfKashgzG9mHl5PxGe0rOsrPq6D681zFWrlFUoCuEu7XPll0zxPygaVp9om2iWMLJ8ChPtfzreTXqmZJu0SF/IXnqZTvOzCqzrwM94aP/Vs94N43nD9KbyelHPOuNhaT4EZ1xt/YVvXR+yTnjzIMqcp2rYpF9l6blM3HEFJ3ik8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555353; c=relaxed/simple;
	bh=fCieoUwnM16IOQVn9SvIT78CXqe8+8u874+JzLF+YoM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jpeeThuwppJaIsUoaFHNCP7K4nsl6lJOr1roHdPV+48dyqJk9FukV+uvBQM+EWFCHRnLAHTmOebYmU0V1itXzXx2TKyuZ1wiULoZO2wFoqJ9t0tUdFQxZJvuXpyV4b23dswY9vQOmDFNRLUaR8EALAz1N1QnV6yNZ66WHxug/x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JO0Ci3oo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oIoPqyhZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJAnpCV009391;
	Wed, 19 Nov 2025 12:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ifjS7PV6OhmV69LPNKCUQxFtPQLB528mwPCbXM6THQs=; b=
	JO0Ci3ookgqbtxiEUc33itxLH2PEuO0ToULgBcTG8i1yFBkTAkw+ovLXiYe2rZdO
	PTrHLIyHWceoMDirHU69s/n73fnr8r5F9xJefOOq2WP0AZsAYy2qywHnpngLAyOO
	Dy7oBy6ZC34SIuZj7ev/ptYRpLbPXCFMOD0NL4YwYC4dHtIUzTWtZtFcMr8idTdM
	t1cBTSVIwf6FJc5ZMzijN0KE8Faq70AldTBHomsYY9BRyx7pEc0bQ/76jFexsgJC
	+2iEHGFnCu2Swl4SgMmKvabeeCJZXG3tT16mWhujIPd16TywtM4CfJuTPkj+tdOO
	4vG3OmPMYTX5CD6TXls6zA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej906ygh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 12:28:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJBQ0mw035899;
	Wed, 19 Nov 2025 12:28:21 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010056.outbound.protection.outlook.com [52.101.193.56])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefymsev7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 12:28:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OutAY46xPyx/5bdVqwdY1Cny2tTVO7I7eRoKq92HGCKViEvkD0pGm16ACj3k/F7rAEv17T7gkak6W15Fccp9P15t2Rb0DTSzSiQSYV8IqM+1gAR/QN9VoqQ+GLrsEX0cTacfUapAX2m+caLo8GqXZY7NdcHobuOkWe3ZJJU44uYZCVQ0cOipE5LE8Hs4ex2pklfnQqlzPIFjBTpQ6SG6FOrq0JGQ61TDwwEM7KqA8nyHcaq/Z1mUzA/1iOkfGWi6CBdE2W0IOtSYzYcoCrpOWOnc/bDo49ngRtMqqSrxx+ThYRP35p9QFqJMhLiFvb/Hey6PzKS9k8tQDWeECc8Sgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifjS7PV6OhmV69LPNKCUQxFtPQLB528mwPCbXM6THQs=;
 b=WQdf2SYlZOZZ2QSWmvKSxw6ExBj+RP0P6vH5hGsnCzhR1PjpQSDQcp45/5viTZXsKaG9FHNruMEy9dZY0hUzX0WMJd+sR0ONn3VoGVELOHded12zlwtBtD95U1F+QlzE/y0G1E96xDSm8E2GGEGBqrDALCKrpoKwWJrUukViDl3s+hrEq3aN8FXgenNdTJ1JPWZZ2fNbNnb8cVxjN3yfp31dA7kq+phQflypuQzlOucUWlqbp+0y5ISnEEC37n8A93ymEQo6djdv6xBiXIaiLAUJeXa2MbYZTDUgM189jaq4bSP2YCmXqPROfSgklSkRNVqAShQrl+eY2v8vPDbGzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifjS7PV6OhmV69LPNKCUQxFtPQLB528mwPCbXM6THQs=;
 b=oIoPqyhZ5P74uazCWYi/RBpetsaLOa0sNH9PmM9Ipbm4U8W8Jyz/XW+AoSJCTPd8jX9fxhLZMGodvI/9eOiTnypHXOx/kDuMC9ElQLsNHNIunSD4jiwCCTu6cHxXP1jfWMvuWqGrbj/znrhYdezHv2knNdaYCF4lHjixSqqapKs=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 12:28:15 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 12:28:15 +0000
Message-ID: <b8e79877-0fd1-457c-84cd-84442bf70b47@oracle.com>
Date: Wed, 19 Nov 2025 17:58:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [v2, net-next 07/12] bng_en: Add TPA related
 functions
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
        vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
        Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
References: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
 <20251114195312.22863-8-bhargava.marreddy@broadcom.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20251114195312.22863-8-bhargava.marreddy@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CH0PR10MB4876:EE_
X-MS-Office365-Filtering-Correlation-Id: fd18812f-ff4f-442a-7756-08de27671ce1
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MUpHYXZHOElTOUVTNElkMkFPT1dVaSt6TVVIMnRURjZlcjdOUkp5STVhUmdV?=
 =?utf-8?B?SHo3M0F5NnRzaTNjS3VPSlZ1ZGtGdXZrZCsvbmVOem11R3BWUEtGNFpxWk9Y?=
 =?utf-8?B?dkZlUERwMEZ0UzJhellXM1h0bnNqRmVjaHZSaVVIRU44VC8ySU5yUExUQlB2?=
 =?utf-8?B?dUg0Y3p1MHZML0ljY09udE8vQkhjakM2RmM5d3dGZGZaNjBCT2s5VXd6UDQ0?=
 =?utf-8?B?ajJ2RkxmMFJJN1czc2gwRC9FVXhXeFJQMzQyZXUrSmRFOFVhajF0YjQ3U2M1?=
 =?utf-8?B?Zng4V1haQzNlVVcyM3RTNExLS0pUakVWQWN4T2RmWkgrQ0pONlpud250SlBq?=
 =?utf-8?B?Q2dPbkJnVHZRYkdHZkFaYjVLTERoQm55eE1MMVl4bFY3dmFZT3VTVVBLM1Zt?=
 =?utf-8?B?ZFBPL3JEcXk1azhJMERMdWJHMlF6cmd0RWNtSkh5QTl4YTM2clNwaGJOaHJC?=
 =?utf-8?B?Q3h5Sk1MNG11Q3BsT2EwRlJIcjhKclhMY1B2UXp5R3hBOUt4VVBlNCtGZHhC?=
 =?utf-8?B?cktKYjN1SjZtL2VVc0IwcUxXOEY4NGp0anRUQlBTamVyWnJDSHg1QlRWSGtw?=
 =?utf-8?B?Y2hHZ1R5OVZrSTZtWEwzd1M1T1JOZnkwR3pNM3M2Nk9oT3ZNSFlndEhLV3E0?=
 =?utf-8?B?NXlMSXVTNVluYW5CMDB3TlluaEV4T2FkYU5FTXdqa0FGdXI1RzVUYmFxOEFE?=
 =?utf-8?B?Zlg3ZVlib1RVemtUcWlmTzNFbnFTQS9yUy9sYy9vMTRpYlJsREtzRm0yQ3dC?=
 =?utf-8?B?RUpoMEVER1AwZGRYKzlMMVZZODZOakNuY2JZMWpYejROOU54QWRSY3l3QTIz?=
 =?utf-8?B?K1M0WXNXMmVWU0RqaXpOSlV6azdSZkhhK3RMQndqWjZWRFIySW03azd2c0Zm?=
 =?utf-8?B?OWZuNmJTVE1mMjVESHZQSnFDclZkeUJUL2tCcm80N2p6akNDVkV6djA2U29q?=
 =?utf-8?B?dEp4U0RHRWltYTd0bCtPMXBabHgwQ05BME8rOTNsM3BrSWZLV29RNjJ4NnVI?=
 =?utf-8?B?c0RrVUxBWThFT1hsaVduSU50TjNycVVSTFdveDRMNzVDY2I3RkNuYlFTNnZE?=
 =?utf-8?B?MHV5TGFRNmI5NmlRQ0x3Z1EzOTNNaFFnV1VtL1d4QktSRFRVckxVK2dkUUpk?=
 =?utf-8?B?QUtBRzJOa2dkK3FZZlU2QkNiczBGeEtaM08wbmEyWkhrQi9TRlhXRkswaXJR?=
 =?utf-8?B?d0ErY3ZFa3ZHODFOOGNBcTluK2x5ZkVURUxYSC8vaVg3Wk55ZGVTNGpNWXZa?=
 =?utf-8?B?clJPRVg5V1MrVE05R0Q3MkxJSW1KTDVCU3BmYWpLWC9HTlZEb09KUGl4bHI2?=
 =?utf-8?B?UlZNejhJS0gvbk5BZnhaWTdwcHhXU0NZYVBoSWhXM2dmWkVpZmFvUkpsOGRI?=
 =?utf-8?B?aGxXdFlTTDhhYXc1MC9RLy9mYnBhVHUzUnlKZldoRmNtSWZHU0ZNeWxHM1pY?=
 =?utf-8?B?MlRYT29PaGV4OVQ4cGNDTnFzOUxTbHBXZjZxY3U3angyU2piQVd0enYzVC9p?=
 =?utf-8?B?R3lwU0JJV1JjNVZTdUdhRDJCa0FkUDNaRlJXNmEwdW91b0RWeERMKy93emR6?=
 =?utf-8?B?S1d0eGxXMHpQNnYxc29FV2p2VkJLd3VWeXlJVG9EZnZQbFN4OXZ1blR3ZXYz?=
 =?utf-8?B?L3JlWENvYkJacGtTQmZybEw5b29qUVZlUlJFV2dIQ1pyYXZ3STBDMmVMakF2?=
 =?utf-8?B?MjRRMFkyVmxOVkdCVFdkdFYwcFlGMkQ1aTFQTElYRFdJRzlGOW9XU05UMUtE?=
 =?utf-8?B?b3lyNnA4U0Fvb3ZTRUNNWUJoZmRmbmdHMUVzbGdmOUJCUnZDM0xkejlXZVEv?=
 =?utf-8?B?OHlQUjBENndIMm4ySzdpMFhpNTBMaFh6OTU0ZHVkNjM4Q3VBWjM4bkN6aXBH?=
 =?utf-8?B?R3E4RysrTldtUXdzeG5EYnpQWnVVWDNPM1Vqd1Mydy9DY0xDNHY2WFkyanJ1?=
 =?utf-8?Q?NYbZpSHBMw8KgtRnOkCpqmw1EjJJMhY5?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aXl1V05sVGVPcG82dUlrQ3lBaGpjM0daNUZzYmduakptWlZTbEFXcG13YjNj?=
 =?utf-8?B?cTQ0LzV3alA3Zk9XUEo1TjRKQ2JJTHYxMklPWmJEWnU3NXo4RUx3Umw5dDAw?=
 =?utf-8?B?VHdYdFR6ei9aNjJiL3RSNGRUSmtMWU1rcUlmaUhPTWxMa21DK24ySFhXYmRU?=
 =?utf-8?B?a0VjUTZSWk1SNmlQRkErU0pKbFhMMW1uMzlzRXpDeXc3ZVVBL0QwSGlWY0Rj?=
 =?utf-8?B?TG05cUM3ZWl2cnJFWjFGTW5TUCt3cjc4cjB4S09raG91M2d2dTNHS2dTOVo0?=
 =?utf-8?B?UE5BUmdhQWZGcUwwZktuRHY3VmpMYTRQQ28vSXNieVkyNUFscVRkbjNEcmtx?=
 =?utf-8?B?VHZjV0JHUEdLc0hQMU4yYnNXNit4SkZJaTBWYnlJMTFDeUlLVmxSbEJZMVVS?=
 =?utf-8?B?WGlqYVA3OEpidXRBWS9uZkprbG9PRG5CV2x0ZExML2oyTFZMeVFkUjU5Rkxp?=
 =?utf-8?B?TE1oN2tEQ0xORTB0c0FpSGF0V1dCbTBkOFVBQXdjQnljUkxGWVZ4cUowMjlI?=
 =?utf-8?B?S0p5ekNJem81aFo3UGR2QWpETnA1WEU3bjB6c2N2bGZJSjcvZEVUcUpQSzgv?=
 =?utf-8?B?anpHbytIcWJ5Z0NoMnkrOFhtZG9ENXhFaS9rUnBCRVFrUVJFbXQwMUduME00?=
 =?utf-8?B?cytmOVBrTE1Hdm84MDQybm5jekVQYXJsNjVBcE13WkhrVUIxQ3Z3SFd3TTIz?=
 =?utf-8?B?alF2b0xpOXlQTFp6K0pPa3pab3FoSXVtY0dPd1owRTgvbG8zZzEwRnNhY3Ur?=
 =?utf-8?B?MXU0VTZwMDc1VmlVMjM1UHFxSW1qYU4veTZSM1o2YlVJbWlEMTZkcXJmejdL?=
 =?utf-8?B?N3dNMDFqa0s5bi9iUnF0elpCUXB0RWo4WDhmdHdUMG9FdndmbC9FdHZxM2wz?=
 =?utf-8?B?bS80RHdiaW9uY1NaZXdZczZQY1NnaDV0bWR5TmFZMFo5Ry9yWTJGSEo4Q3Az?=
 =?utf-8?B?OXgvVE1vWWRqZ0xBb0tzdEdockM1OExwcHdMMFRvd2FvVU84TFllbVhPUC83?=
 =?utf-8?B?NHVhZ1NpZFoyMVp5YkRwNmIrbnpmRkR3d21JRGd2T2x5U1VLb0xXamM4K01R?=
 =?utf-8?B?bjcwS3p2YVpZVUdBL2kyNWdVNEFWYVMvaVBqUUMrWWRBN2dGb09XUnlIVVRS?=
 =?utf-8?B?dmFlT0dtSzNyU0lvT21vTTh6RzVWSzdkbHU4dmZaK1A4Mk5USCt0d2hmV043?=
 =?utf-8?B?bmx2WWI2bzQyRzBEc1E1Zk00dW52cVJ6RVJjdGN0eStrTk9FWFp4di9nODZt?=
 =?utf-8?B?NDNJaDlIaFB6SWJWOWlGR0xlTCtiSy9HNG9VRmovQkVEQWtLYVNCRnRSZHdl?=
 =?utf-8?B?VUNZcmxDODBzZGtUTG5GN3FobkRQU1JZVEdmSXVYTEQ2dmFienlsM3llRmEy?=
 =?utf-8?B?aGYzZVhYSzlHcVBmV2ltZHZoYU1GbFlkTVE4b3hBUXB2UDhaUm9RN3lqdnBi?=
 =?utf-8?B?TVg0Uk0vdy9IU0dqOHREL3JCUFBSR1NsaWsvcU1abHFUUW9CU2xicyt2U1hi?=
 =?utf-8?B?b01CWExFUWdzUEJlTFNHQnlnaTM5NGs1ZGhtWGVacXN0VEwvWlNLeHcvMEQ2?=
 =?utf-8?B?VXFEL2pvaGlBY3NqR0VVc1hBMUxDV3BVWlRYYmRvZXAzNWpGbEhIRllFdXY3?=
 =?utf-8?B?SEJmMHkrWCt5MTFZNXlrNlluL2ozNW8yOXhWOHVNSnJ0MncvUzhBVnR6N09J?=
 =?utf-8?B?VzFYdko0d2c5SGlEcTI4ZUoyUFpCUlRhYXkyZU41b093amlKV0Vqbmo5R2lQ?=
 =?utf-8?B?dkttT0RRa21GQmc4Tnh5UDQ1SGQ4bFpac1hJNk45SCtDbzZqMER5UEpXN2ho?=
 =?utf-8?B?TUdaRXpURlV5Uy90TUUvZGhTYVJsY0FTWEpVTEtpUVZuSkNydnFmYU1XNCtV?=
 =?utf-8?B?K0ZaVXFRZWliNEw5L285c0JNcFMxNXZjMS9sY1g5NFdZa2QvWEliSVFCREox?=
 =?utf-8?B?YjE5eThtMVpVUVhsb1ZXK1B0Syswd2VPT2FGTmdKbTBnM0lVU2g2cWRPOUJ1?=
 =?utf-8?B?czBFWS82dmhDZnowTDhRZ1ZNcXdrT3NOVnJkdDNXZFZUMjlOQnFOcFE2d051?=
 =?utf-8?B?T0NCZzBWZW9Ra0ZmVnJGSHllLzIzbkt4cWJuT3Z1L2lvVkplSC9xWFNpczk4?=
 =?utf-8?B?djM5RFNUOEVxVGZIT3VLSmxxTFh6bHpPcU1xZGJTYW1UTFVtNkpGR1ViUjRW?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bKAYsm9IygR9aj+hm50lzwb8MoAw83YKCxb/ixQHqBtGz5Cqgx6UxYFB08Iz9fN4pTNN/9zBbkXj9KMXB9l16Gt0aJuczV72i16Mya9/V2xXcmuubdXHbehmJIsKqKdFWpAhelSyWB1ANq5oWROqs3vvIQG6tjVPYznvcJ41gxNXd53FEoNd9seTJw9iXpZnACm/9VGmEMklUcnLg2L0AK/RfMG/ri+/ca5zNfB8X2KVp5qcGF6LL/rgYpn6sMpDXlY7cdOh5wa5VkoszfB5W++PgL96juIXPjJ7byqtPgJN9gvvsEowDd/oj9iQifwaBnN5oyg9Wt5o3zfF4lkZrZ6K/wcVNkJ+ikCMlNOn7dxk9iAH90+2XESbqwcDk7RDV5DRn+0S/vdX2EOLNof+U4Nw57oBZ2SlBVOCrWPUPB0Hod032zvfYvbd5wgrHG27mxzmbRj5O8MK8hRkKUTQh6AsK/uCOYdXYtXpERkirhI4lhUft+zI6+1zHXUzg0e1KdPCowAnUCJkCSdLnHQNr3HN6Rjt7LqkTxD1GDeKM30n3syRlDgPqoAIxpftbAlfOqU2YTgsqXtX42jPbc03tzGilj3fh4lGNvGoXpCm81g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd18812f-ff4f-442a-7756-08de27671ce1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 12:28:15.5164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOVnopM6v00P82jVZKuED+mt2jJAkS7hCOwFC6hFRoMZQUvvukQ+OghzzXljS0dBKuAEz3auO156lve7Bpjp/uHZL6cjdp+4I375mS/VYZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190099
X-Authority-Analysis: v=2.4 cv=OMAqHCaB c=1 sm=1 tr=0 ts=691db7e5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=b-4t3SZdC6h5UNtumhIA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12098
X-Proofpoint-ORIG-GUID: eksEVMwcDnkmfRuGzlmgNLhCltqFgM5r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX6cJjfze5In3I
 2muENuZ9BSyaPXmojxmjU1GT672tLf9OJrjY9LRHwS+FBpAT1uUpTol6pTAZuyBG/0aEsBKE7fl
 t9avH9qqM72dIPIFsL9Dw/ReXOCv7XdPunkAX+2Q+2W9B3wGs+xSd7I1piUfnqr2QzRa70Z8vMV
 q7uidYfA7XGOUNETyLxDx86/IRsj/SFrRg+gYnWxr69BvcybzTtoQGaWOoP49uw1GS1g7cPWOU/
 ybmjgiFAC3+/W4juj3WomU93C5gctgKdGIsBl+TDr/m5iwcNyradn7l6P9WRlRB9F/Azjkah4Bk
 l4emZ9Z9s5/pXqPKcilR40GzNnQ7RPFC2/Ty7dyvm98aRY2Z4Oz7iCVdVIPV6OZRil91ogdT9xD
 btpfrMX1GzJ2bvQxGy4SCKuE1tuEI3zrKud4zviZYjPRXO02mEs=
X-Proofpoint-GUID: eksEVMwcDnkmfRuGzlmgNLhCltqFgM5r



On 11/15/2025 1:22 AM, Bhargava Marreddy wrote:
> +#define TPA_END_AGG_ID(rx_tpa_end)					\
> +	((le32_to_cpu((rx_tpa_end)->rx_tpa_end_cmp_misc_v1) &		\
> +	 RX_TPA_END_CMP_AGG_ID) >> RX_TPA_END_CMP_AGG_ID_SHIFT)
> +
> +#define TPA_END_TPA_SEGS(rx_tpa_end)					\
> +	((le32_to_cpu((rx_tpa_end)->rx_tpa_end_cmp_misc_v1) &		\
> +	 RX_TPA_END_CMP_TPA_SEGS) >> RX_TPA_END_CMP_TPA_SEGS_SHIFT)
> +
> +#define RX_TPA_END_CMP_FLAGS_PLACEMENT_ANY_GRO				\
> +	cpu_to_le32(RX_TPA_END_CMP_FLAGS_PLACEMENT_GRO_JUMBO &		\
> +		    RX_TPA_END_CMP_FLAGS_PLACEMENT_GRO_HDS)

why ANY_GRO mark with &, how does this match GRO type
similar code present in bnxt.

> +
> +#define TPA_END_GRO(rx_tpa_end)						\
> +	((rx_tpa_end)->rx_tpa_end_cmp_len_flags_type &			\
> +	 RX_TPA_END_CMP_FLAGS_PLACEMENT_ANY_GRO)
> +
> +#define TPA_END_GRO_TS(rx_tpa_end)					\
> +	(!!((rx_tpa_end)->rx_tpa_end_cmp_tsdelta &			\
> +	    cpu_to_le32(RX_TPA_END_GRO_TS)))
> +
> +struct rx_tpa_end_cmp_ext {
> +	__le32 rx_tpa_end_cmp_dup_acks;
> +	#define RX_TPA_END_CMP_TPA_DUP_ACKS			(0xf << 0)
> +	#define RX_TPA_END_CMP_PAYLOAD_OFFSET_P5		(0xff << 16)
> +	 #define RX_TPA_END_CMP_PAYLOAD_OFFSET_SHIFT_P5		 16
> +	#define RX_TPA_END_CMP_AGG_BUFS_P5			(0xff << 24)
> +	 #define RX_TPA_END_CMP_AGG_BUFS_SHIFT_P5		 24
> +


Thanks,
Alok

