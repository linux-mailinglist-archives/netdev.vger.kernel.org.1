Return-Path: <netdev+bounces-90731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF20E8AFDB4
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 03:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21B51B23C72
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 01:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A67538A;
	Wed, 24 Apr 2024 01:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O02zcs1i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F/ClyYhi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D89DD2FA
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 01:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921522; cv=fail; b=G6bx6g78QINF0qwyEYVlEf+Hj4Tgmo+3eWWi+ziD5KhUv9rW776mRZ6qjteWBpOFH0ahfv0ZEozCoP5k5T6qYlmAO11T/anQw9HeCFl11gvE4CgEoP47qLKwJrSbixBEQLFyhDIqNhvzg8plXBLsAVCwQ5cVhIezaTVTcMDHIus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921522; c=relaxed/simple;
	bh=cCmGgqs6+3GJybl4q7E5Not7q2eG/onG6w3XH8Uoo+Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dTqgHiQmMiybuWbw0zWhvWY8fuSeDImkwfrRCU3Yl4RxCfNo1oKPAQb/dRcHehT29YKJTNCRAiA+l/0WYZJx/nYLqJfgv7/1km82woeRCC+ZBu9sOjToFIRu5DM1JTLyIGGFzVE4JqqzGcMD0BYP6sxMd5Gu9HgdQzEyo76zyqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O02zcs1i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F/ClyYhi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NJdDcI026718;
	Wed, 24 Apr 2024 01:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=eHlyveNtKtyCcPlNcxNvqtOKh+bItDhzvM+y1bLhTgk=;
 b=O02zcs1iBGjb9JoHUDEKq7VOYsqK2oksrX7T3xgAfspn0kIL3ylItuBChIGYLCeMRMb2
 LrLhmjUwj+hZAw3yFSODI6b1nZZUZTINjaRytm+r6D7dffW+SkYNgjPY9294YiNbL+qz
 9t1C8KxfG5ekv/pisfQnt0ccGBAqonW6YEW4wOe26iES3kzyFHoxKWyDN6DDdx4Ve1so
 S0CUCstjADrhrfuS71XQEomlzFgHVlEm1IGL44FYiLwyr4xYtp0w+/Q6q5jihjbwy70z
 z5qs6hutZLUIPWyii4RgMBo1NFIF5pzj0usf/IigzI/hyCvGvZtdNLiQQ0O39tfFCviB cA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm44exmss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 01:18:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43O0Ef5R030968;
	Wed, 24 Apr 2024 01:18:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45837em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 01:18:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ndfn0nPWSU0XbhDG4djIH/Axyvr6F3DifCbLGwccE1jdpQXiQkZRw1y8iyHc+iqRC5W3pU2Q6639b7CsL9K9vFV8pNoOG/VeEDZFhSONGLWtJe7UIUVwslNOsSyInqw935R0Z3cboIIwnUl6FwU+0UZvEeXl8TZMdUwNVWiW/o4gQ/6+ExI6waVZoCaDH4IvFt+hvhVvHMBhPYMITOjj8cdpxruvrPtpukJy2qvDMyG2h2gW7IV6v+8Und7ze9LXnLLjlbaUyjQlhJ51aVDd33u3Hs2H6/CvyfYRIEeJAgWKaUC/YbHJQdPJhklWRQr2YbPCCr/K15uzVEY3OftsCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHlyveNtKtyCcPlNcxNvqtOKh+bItDhzvM+y1bLhTgk=;
 b=IQC7bOln+UPPUZOP0k6MGR994szR4nphAlnk6jVckxv2S+ppEeQBNV+iwlg2RdpXJpA9LMi8cx4Qto2Sywm9ObnAVSqkj6XtQE3koU7Rf0AmuV2wmxCRT9q4CZBYp57d1xAaKQ7J8C8maWwuQmDM/I/k+fZqbjgUe1LYNKmIsV6ycWLvVe55udV8vzJr63yokb7G/CrdZFd1yVpg9r07C01m70/pErbMLJjW6sUJ6fyS0maTkxoJXo9V9iB8t0dJUNEJn2bdqV6FAS5SmIWTIqEBCOhci1hgg1+nqDVPWvSiZnjhVlDoibT4hrLqyayL+EV6lubvCv2hIjH1B5axDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHlyveNtKtyCcPlNcxNvqtOKh+bItDhzvM+y1bLhTgk=;
 b=F/ClyYhi8ECHta9LFfHG/2/lks96qgfmy6mIAL8M7ERJXIcVNjDbzeucmFyWuBRk9NknejE02P2UyCv1NSuACuZSASjRb9n49+F1BO59UGH03r/iByTO8qdB4obMxN580uJy207CLK/PujsMdCO2cyawlc9Bpx608MIzSWsxgl0=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by BLAPR10MB5108.namprd10.prod.outlook.com (2603:10b6:208:330::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 01:18:27 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%5]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 01:18:27 +0000
Message-ID: <5a2dc473-5b99-4798-8f23-c5316610af8e@oracle.com>
Date: Tue, 23 Apr 2024 18:18:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] af_unix: Read with MSG_PEEK loops if the first
 unread byte is OOB
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com
References: <20240422092503.1014699-1-Rao.Shoaib@oracle.com>
 <20240424001543.7843-1-kuniyu@amazon.com>
Content-Language: en-US
From: Rao Shoaib <rao.shoaib@oracle.com>
In-Reply-To: <20240424001543.7843-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0056.namprd11.prod.outlook.com
 (2603:10b6:a03:80::33) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|BLAPR10MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: c9509b91-6b65-4085-94d8-08dc63fc71a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R253R05RYTBYbmVHaGdCNU5WWTY0SXk5WC9RRDBaUEd2V2tQcGdOTDZiY0Jm?=
 =?utf-8?B?WnMvbk1tNzhLcDVHUk1xd0ZGRG0vbC8rT2src0tVWlpxT3pNcTFURlBrVDVs?=
 =?utf-8?B?UUY5WFNTUEFiWWJCSTRLY1d4ZkhPMW9qOXFmRm1JSEtEY2VxOHZQTzRnbXZY?=
 =?utf-8?B?QmRxUGROclJydS90ZWxzVWI2VTdjd2UxNzBvYnlxMng2MS9YQnF6K1NVT2Q3?=
 =?utf-8?B?TE1zU0JRZEJXS1J5cC9uYStwV1RQbm4xa2pLK2xqRkZOMi9Jck9kVHRkZDBN?=
 =?utf-8?B?Sm54akNNYVpQM1IwU1M3dUliL2pmMlIvem1QaE02cVZyS2h1N3B5alVqaHJN?=
 =?utf-8?B?a1dleVhtLy8wNm1SZFdjYi9SNUs0QUhpYmY5TjJ4bGduN1hnaDkzMGZSbDha?=
 =?utf-8?B?WG9YdXRoaFZXWHIxQmpJYzdwUmZkd3YzTFRhTDhJN3pKZGVla0d3aUpXRDNG?=
 =?utf-8?B?b3hkMjl3RVI5ajNJZlBoTElBOS9jelJUTXVZNm82MzN6QTN6NHg4SURLSEZY?=
 =?utf-8?B?dDRxeGZnQVFBSFVmNHRTaGQ4Y1k5Q0Y1dm5tK2VFaW1ZR0dMd0U5bjFrejUw?=
 =?utf-8?B?SUpDcXRGbS9CUlM2WDhYZjcrVEEwQmJCdHlCNzlVS2s1QXJBVGVHM0RWSUtX?=
 =?utf-8?B?TmVNYU9xcUpHV0duZFVDRk92WWZJamtwMDVmTE5DaEs4Z2ErZHpVZmFnZUlu?=
 =?utf-8?B?dmsxTnhaOTlmeTNnQS9WTGZMN2JhRG5FRzhIUG9EVEJOOENyYk5zK1JhQTM5?=
 =?utf-8?B?eTdHUWw4SHlEamMzdzNVdlBSdnN6UVVEeDhJcTdjYmNOK243RWNaOENUWFlq?=
 =?utf-8?B?SUNJZzlNbGY4Mjc1UkhUSmtmc2poY2YzQkpzazVlTkE1MFgwMS90djc3RitC?=
 =?utf-8?B?a0R4L0RWSUZHSGs5UnA0ODVkVlBzbklEVjlkd3I3UXhubHRQRmVLMGxESWxk?=
 =?utf-8?B?THI1VVBXZGdqWFlDTzFoS1p2OUpDSDhEWXJJbWRxazR2ZDI1eEZsRFI3TFh4?=
 =?utf-8?B?cHk3UEhaSjRaZG9RNThOdTZxVnBTclM5ZXNwRkt1bndGb3E4U0RJZjZwSU5n?=
 =?utf-8?B?SGxlOTMzcy9xTmd0OVhZSnFIVE1XSklEbm11aENaVGhJUkkwdnk3ajZvUVIw?=
 =?utf-8?B?OG9lKzVlN2NoUXZTNXR3TFFoL05BN1F5UlBraFRQTHZQMHEvcWNOSFVQQ01v?=
 =?utf-8?B?L0tBWkFZbmtScVZiMS9NMkovRDZBbzRhYyt1NmR2ZG9TbGNjRW9ia2ViR21X?=
 =?utf-8?B?SVpmMzYwSCtqekhKUVNZbk1CbU9nR3FScU5WT1NrMkxkdWZYdThSaVZqNW9r?=
 =?utf-8?B?VHlObTlNY0o5WXJ2OHBtR1FmMmV6NEdtOGU0azcxOUUzL0YxTXlGWHpLbW91?=
 =?utf-8?B?VnUzbFFrUEVpcHBRTVY5TzVaa1VQK3RQQmFhVlVLRWQrRUUzNmZyMlQ3YTlK?=
 =?utf-8?B?K2VwY2U1NzJBcktkZFRENk5BbzZpd1RibnR2MUg0MHpjbGdhTXRtK1pPSGti?=
 =?utf-8?B?VUF2VkdCUmNLMUJHY29WZHphM0lpZis0VTVoMGlkQkhnSnZjTHVCditHUmVs?=
 =?utf-8?B?WXAvaXY2d0lGSDdIYmVPTWtRVTdKeDNlY0Nlby9zTjVUeERQYnJoOHV6ZWV6?=
 =?utf-8?B?YW4xa2pFWlZ5N3hOUUd4WUlaWUlqb1Y5L0x5OGhCR1MvaVg3WkFaWHJOU1Jr?=
 =?utf-8?B?SnlaRVR4bktQLzRGdW1XeEl6bWdkbHFWRmpjbkp5U3VBNUZtbFF0SFZBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MFQzb3BveHlSOUpwcFhoT1RnYzBIS0lGWmpwMWpqcFhDUVRGdWNIVHNlRFhW?=
 =?utf-8?B?bHozV0U4QzdDazdaOVZCWnB4cWNzVVkyL2VqNFpVaHRKc1NRMkw0Ty9sRTBB?=
 =?utf-8?B?Tzd5dWZ2S3UyYi9lc2RuVDhtak55RU1WQmhFU1ZMaU9kQWRvNURpVEtJV2Mz?=
 =?utf-8?B?TEJSazFhdURHc1N2REJCdEIweXFRMTZVZkFiY01pNGpLME5RZFZVekpSQjd1?=
 =?utf-8?B?dWgvdkNidjM4Y25Jci9JNWROcUNEOXNOaEhEc05VZUpHaFl1a0lDajFMaEow?=
 =?utf-8?B?ci81aXFvUlJFeU9rSEY3RGNsYWJrZ2tRdW90ZkUzWmxuWWdJUzRxdjJhcm50?=
 =?utf-8?B?UWp5dXNaT1hsRkQwRE1jbWhTeERYZWFDNWc3R1VvbVUrY0IySWdvQXFFL0F6?=
 =?utf-8?B?YjM2SEVsT0lhNVFtTnlpZGtFUGpxYWh2WndESXJ1UkE2NlVKMFdhWXlmLzBC?=
 =?utf-8?B?UEdYRW5MY3RkaFFEVHZoMUVVdFNramFEa2xNcGxnbysvTDJiK1ZzaUNJcHI1?=
 =?utf-8?B?bXdpQmlic1VxOVBsSzJKT2QrYkdWWUVDNEVCTmRGR2FiMVp4KzJSMlBCbm8z?=
 =?utf-8?B?dW1OV1VlZ1ZwWHRTK1NCRUV2QzJVUTNrcVp1SHMxNVNvblBpVkxrc0J1dzN2?=
 =?utf-8?B?cEY1TU04S2tHN210eVFIMnp2OGo1bHZOdms3MnRQOCt0SXRBT1pXZ2s5UmlQ?=
 =?utf-8?B?TVRtcTRLT0lsRXQrOWdKVVhyRTJKUVFYU2NTMGU0QUVoaFhvUHBuWXBjSnc2?=
 =?utf-8?B?T2FJMDBuNFNrSWx1ZFpvbFVEd0JYczg3a3ZkSVFVVlhCUno1SUJ5c2IrRnFE?=
 =?utf-8?B?bXUrZzZKYVVub1NFK3l0NWlzSGNHK1h0c3IzK0RwOXoxZm44cHNrNFhUM2lE?=
 =?utf-8?B?M2gwbG9lM3FnZC9nRGJ4WkpwNEV5djY4d1NlOUVqTXUzSDV4TXcwajlzNzBo?=
 =?utf-8?B?STVTSWZ5OGgwSFRuM1FtVXZHbVlUMktILyt0dXYvSUtvaUlPMUFLRjJ6YlNW?=
 =?utf-8?B?ZkZIK0gxOE1VSTQxeHZqUFNnV1BOZmoxSmFqUGFkaHdCd2VmeUdQYkZUN1NB?=
 =?utf-8?B?SXpvR0FTdGlEVE43SHd3S1ZxZUNGYnlpUVI5Nk83V0JkYlRKR2dHZEtrMFdK?=
 =?utf-8?B?ckIrZVRvdmwreXplT2ZuV0pObmZQVjlOd09MeUw2dytob2hUV3Z2aDN2dVpR?=
 =?utf-8?B?R0F4YS90dnNyb0dJS2RQajlhYVpmU2VObjVqZ2NkTzlmbURHY0RuaTIzY1Nl?=
 =?utf-8?B?eFNTN2NyOS9kRllQVENLcDU3bEFvemFSdktJMHR6cW5SMThUNWk1bDVKZTZu?=
 =?utf-8?B?bko0UXRZcDRGQ1Zza0thbTlvZG1vM3pYZXF0NzUvYVNvUWIva0V3NG1NYnV1?=
 =?utf-8?B?UzVOcTJ2clQvbmxKblc5WXZDUFUrc0d5N0xyNWtOLytzNVhpdy8xR1crbk0r?=
 =?utf-8?B?eWRvQWRYMXJPNVdMZG1TQ2xNeWIwSkUzaWpudFVsN282ZittcFlaSEl6dm1m?=
 =?utf-8?B?eUVMN084OGQ0QWJENFJxTHcyV3lFYVNHbkVvRjVuYUVSK1NRSEY0WnpzcWVx?=
 =?utf-8?B?elBMVDBGVzhxa3FRMDlyV0pOZGZwNnJTUjloSXVkMzZqTmdBQ25WSFAzdzNn?=
 =?utf-8?B?aDhoUG9scFBkamZFMUJWZ1ZSM0x4VExUajJSUTFMS1VVQ1FQYVJWTndscngr?=
 =?utf-8?B?TUh0VkVSZEl3YXVQZXYrdGpmVEc3ZDRLOGRTY0hqd055dndSODNxK2haWVlz?=
 =?utf-8?B?dGFJZ2hENk51bHRyb3VHVTNrOG1qbG1ITkpjRzZrYU5mK1lSbFpFMU00enB2?=
 =?utf-8?B?WDZNMUZRTitDUDJYNzA5NWlWVFYzb1JCUDczSC90K1RSZDFGRkZNYkJxVHQ0?=
 =?utf-8?B?QkRLZFJYdVpVbmVjVlJTcVVVakRDcXpRWWNlM21lSlpOZkF1OExrZUYwdm04?=
 =?utf-8?B?YWZCa1BpZnlLOXUxd21BSUlkZUhiMklNM0dta3hqdWROWTJXeklrYy9wb2M3?=
 =?utf-8?B?OFc2ZysrQ3V2SnFtWHB2bUlIcmJQK1NXdEUzYzNieXN2UTdDM2VMb0xQMkdh?=
 =?utf-8?B?OW1RWi9tUWxnNEFUc0tTSm1CUTFQV3pMZXhnNXBQYkhPSlJQbGF0VlhFTy9F?=
 =?utf-8?Q?u34LXJH9l6DPcxJcw7TYX2W6E?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TjoxJh5FvKpL5FOsY21QYhWlTS1S9w6k9zZK8h6HhEFzIqm/LhqK23Bs03y5gguQv2kQvKGLGfXU/ZBtzs0/GvST0ji1pMu3z+LdUutGreupx2D7j82lU7mLQ0lWVyvv34ETylYbfzw0p0bAnSAiwqo6xAqbqiKpTJeXXoTB/xhEJaQEjeXPslU44qJ/hpCCly79H9UDM4XktKkGH64ye661I24HGPIJXj+J/sjmCwGKq4bnQi9ZM85g6UTQrsTigDO0W9iA8uch0gOmIwj4fJdTc0CcOb7R7QmPvCZr6sbgJ7NurSmC82UoNXn3oksQkG16b0xvMpW2gju9uXKGLnCBsLboJGMq8bfHcv7kGnwKfp20S1r7t+CiE2eYQcHho2x8ZFL0ao1+gDuPeGM00tpqKjANiT9CfQQ1wQWmDkycyCIXV53ekfKof08m2sERKDWYxqpEFPhPgxBsXdV/UAK9M2yF2eUQB1jwnj4UzN09QmK5EaRO39gUC/swRCuz1FGaxgzQ+6i3fs7QjaHrslA7Sm5G6SwHx/R1V6VMVg2dZcc43uFCfqpXz8u944oGNkj1hxpF5vgt9bvQb+FnTQEopzKwC+5X2nb1S4PWehc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9509b91-6b65-4085-94d8-08dc63fc71a2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 01:18:27.1534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KC+QWLRTF1OhGz/rRns6SjnMA09R0GKJSIW/vf/yIn2OExnVLD+rwM3ojWtnLsgguCh2mZH5UzhWHD+iIs+OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_20,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404240005
X-Proofpoint-ORIG-GUID: QitUr59UmwKq-Ztqf75yUqd-_IShbrRv
X-Proofpoint-GUID: QitUr59UmwKq-Ztqf75yUqd-_IShbrRv



On 4/23/24 17:15, Kuniyuki Iwashima wrote:
> From: Rao Shoaib <Rao.Shoaib@oracle.com>
> Date: Mon, 22 Apr 2024 02:25:03 -0700
>> Read with MSG_PEEK flag loops if the first byte to read is an OOB byte.
>> commit 22dd70eb2c3d ("af_unix: Don't peek OOB data without MSG_OOB.")
>> addresses the loop issue but does not address the issue that no data
>> beyond OOB byte can be read.
>>
>>>>> from socket import *
>>>>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
>>>>> c1.send(b'a', MSG_OOB)
>> 1
>>>>> c1.send(b'b')
>> 1
>>>>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
>> b'b'
>>
>> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
>> Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
>> ---
>>  net/unix/af_unix.c | 26 ++++++++++++++------------
>>  1 file changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>> index 9a6ad5974dff..ed5f70735435 100644
>> --- a/net/unix/af_unix.c
>> +++ b/net/unix/af_unix.c
>> @@ -2658,19 +2658,19 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
>>  		if (skb == u->oob_skb) {
>>  			if (copied) {
>>  				skb = NULL;
>> -			} else if (sock_flag(sk, SOCK_URGINLINE)) {
>> -				if (!(flags & MSG_PEEK)) {
>> +			} else if (!(flags & MSG_PEEK)) {
>> +				if (sock_flag(sk, SOCK_URGINLINE)) {
>>  					WRITE_ONCE(u->oob_skb, NULL);
>>  					consume_skb(skb);
>> +				} else {
>> +					skb_unlink(skb, &sk->sk_receive_queue);
>> +					WRITE_ONCE(u->oob_skb, NULL);
>> +					if (!WARN_ON_ONCE(skb_unref(skb)))
>> +						kfree_skb(skb);
>> +					skb = skb_peek(&sk->sk_receive_queue);
> 
> I added a comment about this case.

OK. I will sync up.
> 
> 
>>  				}
>> -			} else if (flags & MSG_PEEK) {
>> -				skb = NULL;
>> -			} else {
>> -				skb_unlink(skb, &sk->sk_receive_queue);
>> -				WRITE_ONCE(u->oob_skb, NULL);
>> -				if (!WARN_ON_ONCE(skb_unref(skb)))
>> -					kfree_skb(skb);
>> -				skb = skb_peek(&sk->sk_receive_queue);
>> +			} else if (!sock_flag(sk, SOCK_URGINLINE)) {
>> +				skb = skb_peek_next(skb, &sk->sk_receive_queue);
>>  			}
>>  		}
>>  	}
>> @@ -2747,9 +2747,11 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
>>  		if (skb) {
>>  			skb = manage_oob(skb, sk, flags, copied);
>> -			if (!skb && copied) {
>> +			if (!skb) {
>>  				unix_state_unlock(sk);
>> -				break;
>> +				if (copied || (flags & MSG_PEEK))
>> +					break;
>> +				goto redo;
> 
> Here, copied == 0 && !(flags & MSG_PEEK) && skb == NULL, so it means
> skb_peek(&sk->sk_receive_queue) above returned NULL.  Then, we need
> not jump to the redo label, where we call the same skb_peek().
> 
> Instead, we can just fall through the if (!skb) clause below.
> 
> Thanks!

Yes that makes sense. I will submit a new version with the jump to redo
removed.

Thanks,

Shoaib

> 
>>  			}
>>  		}
>>  #endif
>> -- 
>> 2.39.3

