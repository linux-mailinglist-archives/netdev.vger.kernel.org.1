Return-Path: <netdev+bounces-229154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F4DBD8AAC
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597413A8D05
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EF42EC0B2;
	Tue, 14 Oct 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GHZRaEk8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n1lzx73s"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A682EBBAD;
	Tue, 14 Oct 2025 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436245; cv=fail; b=X74z1V5DVeuCmz/6RxSIaMblI8QFCvrM+dOfLXNQajv4I9shl0ZLs9rR/5QIV30kDYYOatCdljWZujuZnBppjU3QdChTSZiYH269BLANJ8F6n3jcUJT+9fqcOKIoThwmKOJKFTOKximXIa3+iPczHOJBaJHBqBM4nr6xoqS6Yks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436245; c=relaxed/simple;
	bh=t+dB0GVB0LKUp1LfUlUZ5fP42AzQIgfIlpFGHvfFX1E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cgz0WRBHWgx2aygNVR2hXYFQUiODMnh6TcvQ1TUQDfAsMMs0WUM2h2umb53AkikosvbdJnI2TKZOyti++1q8ihRX5EP3Ov00Spl7Vo7fukvdMH9xq98kJLsNnUkeUOUVedemxQzBc/Btt4ZIhYSHr6wDin4bFMwjkBw6bB+nlHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GHZRaEk8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n1lzx73s; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E9u3EC010630;
	Tue, 14 Oct 2025 10:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=H3Q5eNB15d993fpx1xrCN2YYnXmS2+1jxDvYCxo26Yo=; b=
	GHZRaEk8BgZIPQ4UMxySWGNGCkPsOMFvPkqNW0K9j4fkf6CLWQkK7SmNY3Qu5r3a
	bOih/xQNfaS3y4kQTmyWHSi0TfDDliPpVfu09P7z42pwA2HWjEg1Z2o2+T9khKkt
	y47jXkoADGdOMH/imYnPyZIHiYcb05vNEo39d8i7BzIQLsMAT38nAxd4wCkN6sTu
	WRBUoi+PRJmS6gfQsep4U4Ye9JGLaNjxRpdup6ivR45eUcq6Q14jjlEPQRptS1c9
	GdmErrLYkvNGWmq70WlJ1ShuN9ZW7yaozVnTbfl4L6sVWFNmg4BZifuLC0zlcL6h
	kEZNdlWs38JhPOueSfOtVw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdnc404x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 10:03:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59E8F2uC037189;
	Tue, 14 Oct 2025 10:03:47 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012006.outbound.protection.outlook.com [40.93.195.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp8r8rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 10:03:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGU8Z2+6Y0iu7YKJqsV5tky8VHs2q6bgjAdFUHt3D+GvLA66VmIbrjvvPC2T2Z9bDCclhp8TKyoHzIqAbxXLKIjtw4dfXbxIImaxIO8dpZSZeQMVU7/nJzddpd81Nq2md4C6S0SnxvpDUipDmfPb6QTWurVAmFcpC+WNqjH7EXcQEXNhAT995+6XY2PbmSGA5naStzI556p+3DHjzwcpqzsCQCR9ENA8YGiV8govTkYK/Gj/4zAZNYwRhXWWTJgzbWRzzLAlBOUzN36n2DND39BvohR+KoLmL8Qnj9I+mtFlenUR2eCtb2AfGLBjlCI5PXE8wGTRHhVXjlHZu4t7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3Q5eNB15d993fpx1xrCN2YYnXmS2+1jxDvYCxo26Yo=;
 b=cmWwQlNn0rZe+ris4xZ8nVaUaCcgFua2psmlw7zGsd4TBROyqkUjFI0Ia2f+ddyaQyI/nPLWY3uMBsrSwdOKkOXJ7hPOwSQhQhTbSnoFCJZ5E2D8q8qhRTwvBRlMZ6llCH3b+FLjINYQO10PftH9zyF1COM4q7SGo2MuQzN/KpemolkE6kqINKlFnpQWSpaLX8RuGVpqvPZYED2i8pRMrS6jpDbHsMOpP9OgMIT0jAHjhcBsVcWuN/Y1yRwXpRcxGCST7pEq0PLfjDFhrzYuuzIbj+vrZPlUnlXh3ls9hF0DVT2mm/ZljeVMPr2D3Za4peTP4kLO2jO2XwKCPF2yHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3Q5eNB15d993fpx1xrCN2YYnXmS2+1jxDvYCxo26Yo=;
 b=n1lzx73sqyAmLQayIQKc1E6rV84e/zlm4f4v+cqlPhd5MY9lEHljLkU1lpWPDWe2WXJewXgRpSeY9cGWdX5fWNuM+EZWz4M82XBsRj03xqPFk/Odks74m0VDuEunEnfY6fSlqEfY8TS+tYYeY3fEO1sQPZ5P28isj+Sw48We300=
Received: from DS4PPF5E3A27BDE.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d20) by IA0PR10MB6745.namprd10.prod.outlook.com
 (2603:10b6:208:43f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 10:03:18 +0000
Received: from DS4PPF5E3A27BDE.namprd10.prod.outlook.com
 ([fe80::aa3d:bc4c:4114:cd4e]) by DS4PPF5E3A27BDE.namprd10.prod.outlook.com
 ([fe80::aa3d:bc4c:4114:cd4e%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 10:03:17 +0000
Message-ID: <9d1ecea4-c63c-4627-8512-98af3153b357@oracle.com>
Date: Tue, 14 Oct 2025 15:33:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Octeontx2-af: Fix missing error code in cgx_probe()
To: Paolo Abeni <pabeni@redhat.com>, Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn
 <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20251010204239.94237-1-harshit.m.mogalapalli@oracle.com>
 <2b9e0f15-6e4f-4510-91b6-8e4586e5f665@redhat.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2b9e0f15-6e4f-4510-91b6-8e4586e5f665@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0329.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::29) To DS4PPF5E3A27BDE.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF5E3A27BDE:EE_|IA0PR10MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c5d5ef-f148-4842-2cb5-08de0b08e57e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXR3UDJ2bmpETmRBamJaTUUrQlgzVUpYeVpDanZDNjRMSldlVlhnS0c4V2lC?=
 =?utf-8?B?UXJidGp1WnhGRU9PcmkvSklmMjhrejlEWTFINnE0UXE4K0NvaHZFTVhKOSth?=
 =?utf-8?B?SU9DdFpUQkU1U1NGMXZxd21teHM5WlQ4MEtmMzVYZ3h6RHpRSmdXbnVFeHpZ?=
 =?utf-8?B?SW90dVhjUXBtd3ZYd1o1WTJreTA4Mjl1VVNzTnNVbDNnOHAwWllZbHNDeGc1?=
 =?utf-8?B?T0J2czJvcDlwRFdsUWlPWkNmck9JZVY2TGhzZWdTditsU055eGNZMVI1UTZQ?=
 =?utf-8?B?dEJnbHZ3U0tBRFhGY0tnZk54Y0ZINVU2NUZvK0lQWjhJcFdJbUYyUDc3UHZ3?=
 =?utf-8?B?WGVObnl1SkYweXoxSmhDVHNEYmZaa2ZjVTFnOXV3dlpLdjBJTWhNUmNWaFAz?=
 =?utf-8?B?QWlrb0NGUWZTTGJXb1EyWmVuaTZsY2w3Z2c5YzBoWnI4MGtZMHdYNmZ4WXJN?=
 =?utf-8?B?Ylh1bkw2eGs1VjlvY3E3aHNETkxhK1BZbW5reVN0eEdEd2dKeHhsWnUwaUhS?=
 =?utf-8?B?K3NDWXNFYnNMV2cwaFJ3dU53ZzJNalYrKzBuY0tlUUI0ZUEwT1kzcVNxYWg2?=
 =?utf-8?B?VXVEaEd0TGRSSVRlZG1CQlovaHFQK05UVGROZXNuTFhvemFhUDREUWJIRmR2?=
 =?utf-8?B?K052ejhXZk5GWXA4N1JSVHVVTytrSnUwV1FWamVBcGxYeE0zQWVkeVVpSHVL?=
 =?utf-8?B?SytORHFYU2lTRlF1bUt4ekZUajlGbkgxVitROHZsVm9NRU5NOUxFQTRNd0Nr?=
 =?utf-8?B?NFJ0OGliK21mZVFla2lXS2ZKb255SW4zZGcvRFBxUGovMDNNKzg4Sm5xVGtQ?=
 =?utf-8?B?QW9xSnVjMVBUTWFOSDg0dWk2YjJsVWkvelpWVGc0UUVnWURwSWpqYkZHeWRh?=
 =?utf-8?B?M2Roa2VCYWxLYUpxQ1poSHNCandBRmRwMzI2azU2TjlnSnlSWlpzVnljTlZJ?=
 =?utf-8?B?S1NQRmljWll5Y09UY0ppUHFYVHJOTEtXT0ZaakxHQ0lqT3UxY0tjeVZ6VGVh?=
 =?utf-8?B?SUllQUxnZFN0YUZRMVZLNVkrdFB5bkN4RzdneDAvVjBUUTdxalhicGdaSk1G?=
 =?utf-8?B?V0h4UVB5WHE3Qmo4bEhWbUxoSzVhM3EzcnJmMnBvamtwQmdVcEEvZFlpUzFx?=
 =?utf-8?B?aGNHS1Q2MndVUFZBWjhOZTB0a0VwQzl2a0NuOTNpTXBiNk9mTVFzZjhhZ2pn?=
 =?utf-8?B?aUJ0aHNrdG5uVEt2YWxMbzkvMUZvcEFrbGJXVTdua01BTE5jTjlxZzVmKzBT?=
 =?utf-8?B?Y2V5cWZ5a3A4aTdEelczVDdSNGVpRVcyT0MxcHQ3RXM4M0phd1dIaUlaMEpi?=
 =?utf-8?B?TytIdW9qeEIrcDA3T2FseEJJd3pudmVXa3lsa2tGajhxaVM0aXZxTXB5ck8x?=
 =?utf-8?B?ZXVtQUJkckF6K3dZWGU2ZVUyRjYxREdLSlk4bElrVDNkUEhnZmN5VWdGdWxY?=
 =?utf-8?B?NXB2TlB5d25XendWQWMrdGhlZmxlWmNrRG16NERNYWxpOTVQU2Fmb2t6OHhK?=
 =?utf-8?B?TFVleWFlYTQ4QnVuUFJrR1Z1ZmkrU0syVmJmMU5IWGtENlRZVUQranphOHVa?=
 =?utf-8?B?bGpEa2lGM3oxYzIvUGRwVkRkY3VWSUZtbFl4TFppWmF5TDYxbkRMSDZrclBC?=
 =?utf-8?B?VXR1U3ZZVU0vM2RONitOUDIwVURlOG11cmN0eG5uKzFGVXljcytpbmQyOFUr?=
 =?utf-8?B?NjJ2djJ2azFwUzEzMnpCUFlDYnNMaGRNOHF0QnFIVlFwdTZlVG9FVzZxeEZW?=
 =?utf-8?B?TzdkT25vVFJFU1FOZWZDY3U0VnZ5bUQzRDg5Vk9PYU13dFI4aStTbzZadGJm?=
 =?utf-8?B?K0ZmSmxaSVJ0Mm1UdTM1WWRQOU0zd3ZQQ2FiQmhSd1BlL2h2a3lxaFpqMHJq?=
 =?utf-8?B?RkM5Y284dUlaUXJNT2V1L2phSHRySFRBQWVwT0xmQ1RFTlRWN1kzbDFrc2ZY?=
 =?utf-8?B?bmF5VFRvRm9EeitwTzFINTRjb2hjOFRSdDhEZG9NU2wyek9UZHJJYXVhYWU0?=
 =?utf-8?B?T3lyQ3o5dW5CR0dKNGl4Z0F5WTAxNDNEZUdDL2E4RXY3dXhoMTRIaVVySEZ3?=
 =?utf-8?Q?Ak4U4u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF5E3A27BDE.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUFJazFhdk1DM0NCN2o4OU52NS8vbDhRZ2huQmpFSFcvUStxVVNLTzhmb293?=
 =?utf-8?B?SUl2L2NYOHN6N1U2L0ZLT3hhMmt0djhXUEhjRjhScXNhSDQyZ2NraW4xRGQw?=
 =?utf-8?B?MzhTcnFHMGt2emlHSnBNN2owRU9NWFJPYjl0dE9LOGFpSitHaGpOanNGQTJh?=
 =?utf-8?B?ZXAreTBObkQwWjA1c2VkSDZxN1FDVzZxVnVmeXpLQ0s5aTFJUmpNRlB5UFNk?=
 =?utf-8?B?VCtTN0xPcHJ6Sm5jV2J6VllJeVJEb2VYMk9XWWlqeWY1L01NUDNtS29sZjFF?=
 =?utf-8?B?SzgyUllLWmVlU3V3eU1PUDJOZUt4SlYrdEpKVGlJTXU5K3dScUl3Z2luRmNR?=
 =?utf-8?B?MjhOU2JxNXpzMHhyMlNyN1RWbHE1Z2toQWdRUU9NMlZ6TkUyalNyTnJhRkZr?=
 =?utf-8?B?SVRPbVp4am9zeHVLOFJ6VFRIbnJWSzVJSVBYM3k5c2ExelgvQ3lqY0tkTVpB?=
 =?utf-8?B?eFFrMmppaFZrNnhndStmSERWTmhyMEc4ZHY0YmV4ekw1aTZtd3ZSNVBwVGVX?=
 =?utf-8?B?WEs3N3UrL3cwTHRVL3JVS0t2OWk2bTFwektrOGNkcm51UXZUVktvb0FyN3JU?=
 =?utf-8?B?YmdQUjd2cDNNYnM5aFdhTTFkYjNiaG9iVFpSdXBqYUdxMWR2aitEaFpIb28x?=
 =?utf-8?B?d1JwWmNPTkNGWkxoN2pPMFRPZHJVY2RGR2ZjdWtheUV5K1BWZXp4bUtlWGVo?=
 =?utf-8?B?MVpzZ1RpOWlSY1YwM2lLVFZlZU9zaUI2anlHYVlhNFJ1YVovKzBNNHBIb3pk?=
 =?utf-8?B?cGE5MnQ2czRNcDcwakxFaE82WDlyK3JBRU9odWRlZXU4RWQyU3VoQVlIcGIv?=
 =?utf-8?B?bE9sdDljR3JDSTlrSkhWbnF4Znp2Z011UUFqZERlQUVKMjhVNW4wWFdpaTlj?=
 =?utf-8?B?azRJWWRpdHJQR0N1MVJFZXFRMGVvbmJGVGpCcGs3NENRR3BuWWhuNUMxdCtW?=
 =?utf-8?B?TzdRR0hoM0kvam16Q040ZTB2N2VNY0VmeVgyM3lrbXpOeU0wdVVQU2xOUWRV?=
 =?utf-8?B?VG04c00vS0o5SDl3SUM4OVRvdGdvMmYyY0dkS09MZkMxdUUvYlBhdnFnTTM3?=
 =?utf-8?B?ZU1MNldJZ1ExcWFXZVBVSjhLL3dtbFpoOXJQQXNjNi9VZGtWeDJzdkpvd3V2?=
 =?utf-8?B?VzdFaTFLYk5tNDRJQ1FxeFpEbFFTZ1hDdWxURnNUSmV0Mlo5UWVzNU5LOGox?=
 =?utf-8?B?VllJTFAxeVRyM0xCb0FFNHBYb0d6ai8vRU03c0FXUG00eG0xNnd0eFQ2VHNa?=
 =?utf-8?B?NTRXYVJVcEdpcUkxdVhxTk1BZDRLeXVrdFU3NDZBMDhiOHpHc3ZIK0NYVW5l?=
 =?utf-8?B?UjVwSjZsTXMrUVlDZTlUK0xSanNzdkg1R1QwempGUEx3d2xLMUk1dFFaMW9J?=
 =?utf-8?B?d1pHQS9rTlg4YVRUbG9Fc3NUTHlFbll1aG05NnJyV2RZbUI2aFJudktsRjQ1?=
 =?utf-8?B?WXdwNnI1bUEyeXYyUzFMdUI0WWloWER6S2ZPQ3ZwQWVacGtxelRCbVY0R0xC?=
 =?utf-8?B?NXREU2R6OEF0dE9VeXBsOGhDR1dkRGxxR2FmM1N6UllhMTRFalVIbDVrb2lE?=
 =?utf-8?B?OFBibDBqVTF1ZFo0RVo0NXBQSXVNWXVVeXcyTitQUWR0QUJvMmN2aFhxbzh3?=
 =?utf-8?B?T2tZQ0dXTmtIV0NpY1hxY1ErMzVVbGxkRE12elkyNnRDclZ5UU1FV3NDbzFU?=
 =?utf-8?B?bHRoNEJMU3pZeWp2dHNBZHcyUHBwa3ZLcU1wTVlQbVpzMmhUYk9PaVE5Z1BB?=
 =?utf-8?B?OTBMQVJSaXdiamlOVDFBek9pTkpJYWE0OG1GN21YSUxLNDQvUWtNVWxWaUxD?=
 =?utf-8?B?aE5OdElqbnVxcHVLRkxqSUdYQ0M1OXBLNWhRZ3BRK1M0M0ZwU21ReTNuSXZp?=
 =?utf-8?B?TXNxU0doSzE5aVlVZHYwSlNUOVVmTjVkaWNHWTl6MndDZXBRckFpQXI0Nnhl?=
 =?utf-8?B?UE9mSk1uTGxFMnAvKzhlWDJ2QjJtRTd0SEJaWnFiRGNJbkU0OWtCVWQxeFBD?=
 =?utf-8?B?SHBpbFZDT3pMcXpaRUlIbit0bmEyRUFybkJpaVBidmRHRHh2YmpUSnJSd0NB?=
 =?utf-8?B?dVJWbVVLVStMcm9TWFRjWGp2Ylh3dUxld0duWTUxdmZ1dzFLMzhEYzBQNjRQ?=
 =?utf-8?B?bUs3NTFnVmhIYlErMTBUdGJ2cVR4MFRGbUtLbXExS0JQTUthMFpGUmpOYVp2?=
 =?utf-8?Q?TKiir2mLRKg7cPb5Q9u9IR0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9K1wIkyJxFeEQCyCBlaEHpyiho+/CBPG0yjJsfQdzJu2vWGlp+y0dTNIZlqeNHEi6LhVofbK0PZ+a9rsMSZOqUrDmdcXYcT8+JYusz4ZhpngBfAbH0SgDjDVTLVigR29tY+sd1FVaQxP40NX6MquUU8xzYq48AaYVGNkvjLzrxT/8qkmMpCXc33LVTRIq+XRXHRnclwoWp9mW5yLvVeaEoi1fMEMiSvWm0ZUqyZk1NFO7J4mbxisd86Oqs08KdnG3ReaJtOMjqYDkSDb1OVQeWzPrYbHNKoDWVZKkV3Jxk+kwoQa4hT0J5OQMNNgRKzuwJD5kCUJDWErQk2gFBgWMvUBx9rq76OMzgCp2VbnvjTMLxSF801Nb3JdKHdQnB7iU42eoqAcNR+b/Ixs3gFhNJ8ts8oyOqjkUFNQU2UM40RgJOzMikHUElRIZtPVfKyLWj9lJRrzfwth0RwuGX1YREbXZKEdLTulwcIZcHFBjvEd0fs/wF/jnKftUqtGC/e/f7T3PwQ3gi4QuAxk+MGYTyHeExWU4UGB7H9y50HKscV+oEW3bV2FeF7sEiiQrWJ5Xch3w6ldbhe+4Ao2dZHTr5KZqF3pFLmVJQ6F53VVt8k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c5d5ef-f148-4842-2cb5-08de0b08e57e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF5E3A27BDE.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 10:03:17.3777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvi5n8uDWS6uG15NaE2LtSPF38OALYojseIx4rY+55Y9583vuETIu7aW3xP7o6YJHoTNU/O2X4iuPMcr0sj5b2m+SQcerSCstWhOPXflwbxvIb6SEyea/1knn/N9mY5H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510140079
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNiBTYWx0ZWRfX1MtIODws4IdY
 ROuugAvWFkYCQbqMxJnZcDAVPxWN9OamcjXuYzZHdGDIjGOyzTSgaSLQllrntmi1vbpNSAQOVYg
 WDjbA8uA+kV2xcsb+kNRS/jmyyPn4w5+X+csjWdUjzY+oBNlB5aQEWaXVOXwH0GkFMLsF3DvAgn
 irr+p9wvD83rriWbZrT+CSDgCxM4lRZuHiq6BBR7YMvU32rde3EZSjVghi9YyWIhrDb2K4KTD0H
 8yow7xZhHWWe1AgRXCFdBrMWhrW+2t+OVmguXJ3+daVTVFWeoH4bcyRpkPK3OpIYHdgEM2GMNUw
 o+7KVlSfmY2NGbn+SLdfYAuMg2/KzAi97c1PnNnwpL5NFnLlo30GyOskkVkn+5B4gsy6rEipezP
 FgCCKXkWDfsfGtvpWTkXmnGZqdogrg==
X-Proofpoint-GUID: T2HNE84lAWsZvptg9J8cUAKGAoMX2lC2
X-Authority-Analysis: v=2.4 cv=ReCdyltv c=1 sm=1 tr=0 ts=68ee2004 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8 a=7vkhVdsVktQTiFWwXEcA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: T2HNE84lAWsZvptg9J8cUAKGAoMX2lC2

Hi Paolo,

On 14/10/25 15:17, Paolo Abeni wrote:
> 
> 
> On 10/10/25 10:42 PM, Harshit Mogalapalli wrote:
>> When CGX fails mapping to NIX, set the error code to -ENODEV, currently
>> err is zero and that is treated as success path.
>>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/all/aLAdlCg2_Yv7Y-3h@stanley.mountain/
>> Fixes: d280233fc866 ("Octeontx2-af: Fix NIX X2P calibration failures")
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> ---
>> This is based on static analysis with smatch and only compile tested.
>> ---
>>   drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
>> index d374a4454836..ec0e11c77cbf 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
>> @@ -1981,6 +1981,7 @@ static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	    !is_cgx_mapped_to_nix(pdev->subsystem_device, cgx->cgx_id)) {
>>   		dev_notice(dev, "CGX %d not mapped to NIX, skipping probe\n",
>>   			   cgx->cgx_id);
>> +		err = -ENODEV;
>>   		goto err_release_regions;
>>   	}
>>   
> 
> Side note, a few lines below there is this check:
> 
> 	err = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSIX);
> 	if (err < 0 || err != nvec) {
> 		dev_err(dev, "Request for %d msix vectors failed, err %d\n",
> 			nvec, err);
> 		goto err_release_regions;
> 	}
> 
> AFAICS err can never be a positive value in that error path, but the
> 
> 	if (err < 0 || err != nvec)
> 
> check is confusing and should possibly be changed to:
> 
> 	if (err < 0)

I agree, will send a patch for this.

Thanks for the suggestion.


Regards,
Harshit>
> /P
> 


