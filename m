Return-Path: <netdev+bounces-194567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FA7ACAAE0
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 10:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3376B3A4C96
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 08:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D90F1D54EE;
	Mon,  2 Jun 2025 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LiPFsM5+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W4Peb9kI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEE2290F;
	Mon,  2 Jun 2025 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748854240; cv=fail; b=Nb1tXZ5AUN4G2tTXJNhUWA9FWUYdGO5qpTbwAUM/1fipd1H0N6L/bjwof3iu51Gi+BnJTXdPx+5HVjua8fUa8OMa10vACHhR9J4qWY13nPBmpGYeDuKJxuJBg0Nl2iMwDk3ssmwmZa8zhblbQzkw2mIpqJaqy3qtnqTWRYuEkWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748854240; c=relaxed/simple;
	bh=su/9kI7IwPvdnhak6k+w4qJs5oT2XbEMt77KR2MGzQ8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vj0GRYq6GFs/VzDbTPTtj9CnDoG6pRqL5fylO4qFD0G/LGOQxqiv433fmRLfsCbD6cDJcOzjrYj2ca3VHaGZb382H6HwtMtlLkt7L/BHvplRjZOzd5bxecdwI5zBMRtaxulgYf4/tKPJZd98HahygYm4717W7UXOM7ps+EWfb4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LiPFsM5+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W4Peb9kI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5525ts3L011352;
	Mon, 2 Jun 2025 08:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rx7be8It3IM4ta9nnbM/J9gXiIhXj9SlczC/7RTsrNM=; b=
	LiPFsM5+/1nXcnNTITSM/XES17ffJmW1I9gxXQpgsWFm0olNFWKbxiaRunP/h+17
	NLYtGaxVv+FInSpGq3qDEqL1U2cX8ozVTW2G3c1rfnMPeUoYq2MWFY1IqnmmZhDD
	XwV7Q8xaCJns3JKBwJyaiM5sCA2JPCpYOwzLYhLyBz9mGe3Sq3Gu2XBEjKT4c/3I
	v+j9lTXAtqYtprtVRT0UZFgxMqZMyAU+yBEWiRTAamh1BS8+il8uE56jdZerPgDu
	wnTj0FMc5wZ9V5sXqSmXaNOr6ctrHHSnWFhsbM8JDeFIY0q5jPv19CaLjG6wBy8L
	j88ee41J01fXRMZgb9/7JA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46yrj526bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 08:50:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5527VDTW033839;
	Mon, 2 Jun 2025 08:50:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr77q10a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 08:50:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iC5RqEi5a3riB8/M0VLk62nmUIX5fzDkHEAHrD/JCJRjq4DYsM2sRMq6zf6Rx0/voy1dC4dnbmpoCt5k6obgnML6ujLPgJ5X9taekZRrg0wlGJE0cb83O/oIcgDZCop4NTCqDevl9gZXi0Yh57cP5o7driIVkgGHEy748rBGEDghRgTqFoqj7hsTyRNYux/LtWniILRwenOPNjfbbi0xQ9u7MKujLyh9AgtYcX3CRvA9YP4fVs36o1+fu04G8xWkypAKqN0ziQjuwkJ3QorNgoFZlQAJQE/vCv7TwKZleOEYej4wRTDbNEdkv5IAzDiNqlsx3HG1zzE054wK+T581w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rx7be8It3IM4ta9nnbM/J9gXiIhXj9SlczC/7RTsrNM=;
 b=cK2EHEOfOASltMD8Idkksfj0xMEKkm9/S9zVYl9A8NH/tMU8kW1fAfg6/5JgKEGE0xtzqq6BmKzvH+JKysEwW3KDCLrpswUMa4B80ScJM0Hq7lCiFqMLcdkGZUJf4Jdw2s7FbT4EUs+WffZrYHYdrpTRqyUdysN2UQvYtSm7dEB7mDfy74bHJV/to7kH/xKYC82tuzUPDTeCVCx1N6w1HJUJVQzEg0G1BiLQi1qWqsq3soaJ/sZEYafQIq0Ol8rtuO6kT7NPS//pyrq6VRlVGJtOcbsMNM3QFO/23/xSr4CuJMhMdIbAXkF0WxbmpMdXkTEpuy9A/usIPEJBxKFxuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx7be8It3IM4ta9nnbM/J9gXiIhXj9SlczC/7RTsrNM=;
 b=W4Peb9kIF3/2zqZ98/fdtytBMWt/fkXiiZY2rTmUNa26AxGdQI1IPohtN5VvC2vrWiPmQrcOUHro98+th3UBr4ynMlXdIF70FQbDneOZm5DsCFlbP4aUDHjIHrE3D6qBo+c9cxuCxnt1ziiL/3lfss97jbNQn32ktXKdaPt2Bgw=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS4PPFC7C4B0ED5.namprd10.prod.outlook.com (2603:10b6:f:fc00::d48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Mon, 2 Jun
 2025 08:50:24 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8792.034; Mon, 2 Jun 2025
 08:50:24 +0000
Message-ID: <bf4f1e06-f692-43bf-9261-30585a1427d7@oracle.com>
Date: Mon, 2 Jun 2025 14:20:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gve: add missing NULL check for
 gve_alloc_pending_packet() in TX DQO
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
To: Mina Almasry <almasrymina@google.com>
Cc: bcf@google.com, joshwash@google.com, willemb@google.com,
        pkaligineedi@google.com, pabeni@redhat.com, kuba@kernel.org,
        jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, darren.kenny@oracle.com
References: <20250601193428.3388418-1-alok.a.tiwari@oracle.com>
 <CAHS8izOqWWdsEheAFSwOtzPM98ZudP7gKZMECWUhcU1NCLnwHA@mail.gmail.com>
 <cc05cbf5-0b59-4442-9585-9658d67f9059@oracle.com>
Content-Language: en-US
In-Reply-To: <cc05cbf5-0b59-4442-9585-9658d67f9059@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0067.namprd07.prod.outlook.com
 (2603:10b6:a03:60::44) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS4PPFC7C4B0ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: 3296e89a-6677-4d9c-1b29-08dda1b28394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDNwTHJHMndnaDNuUk1KbnNCYk9ESGVBZGI1MnNQZnJQZHpRQVRmS1lRbVcr?=
 =?utf-8?B?M0xXcEZzUWVhRU1oK0RHbWU1b2w4MHlWTTJRWmxod1Z0dFl6eHl2akdRRUJG?=
 =?utf-8?B?RHlQQjdoQS9DU3MxZDBUMm1xdkNvNC9uUExnYmRTWTNiSWRlUkYybVoxRU8x?=
 =?utf-8?B?bVNsWlRqQ1lkSFhVNlhnM2JCTWVjdDNnVGVpeUtjTVQyY1AzNzI1MGtPV1Jk?=
 =?utf-8?B?RklDN3RZOE1QTnd0ZTd3TDRhZUpvSGhhQm1VUXYzbzRFc09hRVhoT08rbUVl?=
 =?utf-8?B?dUtybjVzQVB1OFQvZnMwRTNGSXZGbzVubEdhRkxmd2ZhRXd0S1FucTN6SGpC?=
 =?utf-8?B?VkU5L3l2LzRTYVhyVk13MHRxVlhDSTJReHp2MEFSY080eithdDZoditDbko3?=
 =?utf-8?B?NFdhMWRvZVdyNk00dFRUcXZnNmlPZWpESUpodmdveGY2Z0luQjBXSUhRZkVI?=
 =?utf-8?B?TVk0ZWV3QWNhSUZQYkNIQ2FuejZ3dDZOeGNoelpxRTRFeFRrdDdhMm04RlEw?=
 =?utf-8?B?d3MyNFRpUWhtUWh6L3IxN25BT2YrT29LRmdqc3M2UzRYUXRoRUM0QUhOYWxY?=
 =?utf-8?B?R0tLMXB4eGM0QW44SERrekU2S3lNclhOOVhhOW1CQ2UrNlRQMHpGZzZpQkF5?=
 =?utf-8?B?cWFXY1FVQUNFWkdYaUJuTS9aSVlRR1laUTdHSmZUeWhORnI1OXRabk5qb3U5?=
 =?utf-8?B?Nm1CZ0dRWGs5bWdaMGhldGMwTWw0SVJac2V6NzZmT1FqRHpXalpOOWxJd0Vr?=
 =?utf-8?B?VWFLUVhVWmErQWJZWGp2TnNOYWJPRjlmdVhVMEU5ZHlJMTVJZXFDMmZnbDNp?=
 =?utf-8?B?V3d5MHJmUXdQazl4TUFHQXJmZzd2RHhITTlETHRwaEk1eFR0YmIxN3QwVkw2?=
 =?utf-8?B?SzlXQ0dNNXUxZmJsdi9IOVJFWFIrVVVVS3FPcW1HV3FVYlRwc0xZL3FoQTRh?=
 =?utf-8?B?TjF0WlhXY1JSQW4xajFHbExIby81RU9oOUtNUUtnb0lSUlNMTVhaeGkzLzZ6?=
 =?utf-8?B?RmQyQXYxOHVOSVJYcktzbE1Qb2pXZEM1Qmw4VGxUdW44bkQzUTVlM3k5NlNn?=
 =?utf-8?B?SWF5Qk5Ibi9YRE5MNEE4c0VVT01VdDdCRjNBUDlPYTNmNk9FSVdqdCt1VEVE?=
 =?utf-8?B?MGx3WWtrSVJtaCt0S3FSMWo3Q2N6VnVLcDJ0eDIxbWFadUZEYkdPbXZXb3JD?=
 =?utf-8?B?d2JqOTliWVZOQzNoM25jMkVEaGVGUlNpMHdGY3Rvai96c1lGMDE3dThRb3NO?=
 =?utf-8?B?NDNCaTdoMUEvdnB3NEdFQmtTVE5rQy9leEpyUU40dXNpSWJnZmNWeUtVREl1?=
 =?utf-8?B?MTJDb283K0hNWk44R3NDNGFUdUtZNjZqQTNJWWxVRHkvc3BnVDc4Z1gyQ1pN?=
 =?utf-8?B?a3NjbWNBOEVqMGs2MloxaFh3bWtKb25HYmhLOXE5dlFXcHdQWXBhTHZLczhz?=
 =?utf-8?B?MnFiMG9lR01rRWJkRFY3cENiRS9xSkFXbnQ0ZGE5U2J3K05DNWtkOHNTM3Zu?=
 =?utf-8?B?U2lueU9nNDdXQ3dhcHZhTi91MUppQ2lSQkl6VWNYeWZndk5YeEpHN3dReXhK?=
 =?utf-8?B?VkpmejZ5ZE9FVXFSdTBkNjN5K3k1dFFkekZ1Y0xmY3BHcTlic3ZLRklyYjB6?=
 =?utf-8?B?THpVOUJvOG9lUVZQbGtlMjNYWmJhRDVpeWdiaUlYZWlHNk1yZzBRcERGUUQ3?=
 =?utf-8?B?VXNQRFVkT0YxVGhzUnpleFR1eURubHNIUnFXc2Zic2UwN2tKeDlHdW1CZ0JN?=
 =?utf-8?B?TFREY002UG9PbngzQTMwQmNJcmRxM240QmZYNzZBQ2tFbTkyRFU1VFpjM0F0?=
 =?utf-8?Q?XfKpqmiRRekzw/pJeMdrqyZHAw0/JWnTHZklM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGxSTk1VakZLT3h0dXdGakdURGZvaFc5dllZM2JVNFJDNHN5SVluYW1KcGRJ?=
 =?utf-8?B?MU5qTGw5ZkNQQ3EyRmNkYkprTml2N2s2Z1NuVUkySkoyNDdDL3MrMzFtVERa?=
 =?utf-8?B?SE4xcFNxMTNyQ084b3ZRUlF3dk9wWWFlOGJ3VFlPMzVycXQ3aHN0UlVwcDd5?=
 =?utf-8?B?N2MrZDg5T1BhSmFtcmNBbnRvTzREdGZaNUFyaWFqMEp6eHRZS1Y0MXhKKzBI?=
 =?utf-8?B?WktxaWNibC9hYm1Fd09JeUdCMEJRNi9aSHJvZE5aTnNVenU1VUpOdHllc01W?=
 =?utf-8?B?c2hkeDVNTFZjU2FUbWNJVjBIV0RSWGNRYlhRK3luRE00ZkN6eVRIUkMzWnpB?=
 =?utf-8?B?U0FYTFNJT01rNWtaa2pEcmN6SU13d1pxcWU0UFN4SHFoTTZKN1paUkE3STdI?=
 =?utf-8?B?ck5uTFFkSndpMCtKeG1lN0c4akV0aWpUeE5qMHliNlF0cHczMzFnek82aTZj?=
 =?utf-8?B?TTJMcjZ2aC8zS09uRTRSbmlMaE5GRXFYSW9ZR0IyT29pSE5zWXM3YlpsWDQ2?=
 =?utf-8?B?em5PWDl1Y0pnUWNVTlJLMzdTQkNzcTZqWk8yREtXSTNHQ2I5NUdJTjVtaEMx?=
 =?utf-8?B?U3hEY3hzQjlVRThUdGdJUk1OajFYMm8zM09zSHJCN3VoT0xEYnJzMnlJTGlJ?=
 =?utf-8?B?emJuQUptL2FzUllPU0g5dDdJcTZVc21OYm1pbnRvcCtub2pJa05veEJZZUU3?=
 =?utf-8?B?Z1dkYWZqaCtYVlVKUWpiZ3g0dFhKaldIYVQ1SjJsdS9QUGJiMnJ3aU1uTHE3?=
 =?utf-8?B?Y3p6YTlMMWQ0c1gyRkd3TGNMTytMYVNRYUFQOS9lK1FVOFhwOHhtT3RWcG9o?=
 =?utf-8?B?YnBoSGM0ZnFNOXpncWp0V1pSZzNubUFMTTBnOXdxQnlMbCtVS3NRTkdWY0FZ?=
 =?utf-8?B?MXllYktucG1YYzc0MFlMU3RoaXE3QXRUbmFuMTh6SmQzNkpXTkRGNEJnY2p2?=
 =?utf-8?B?b1dWcUhXZjh5RmJlTSs2N2hvVllGa2hhdTNRNlNyQVV6cmZraFZGYXl2STZP?=
 =?utf-8?B?MUM3RTc4Z0tGd2Z0cHpmL1ptVEpwSFQ2cXBXUEtsUFNFT2lwWGVQMGx2SGMx?=
 =?utf-8?B?alBnTmJOaUxYTVZTcGtZQ2Q2eTNJOXl5cXM4a0FVeE1LQ1ZzYVdLU3o0WnpM?=
 =?utf-8?B?Y005dE1qbUZ3Z21YVzFmVmx3T2lJWFF1RHpleGVFSSswSjlvQk5GUDZSUE5p?=
 =?utf-8?B?djBVTHI3a0xxSG0vOWx3YzhyYWdqNEVtM1JQeENrdXliVGxpaDNuaklKak15?=
 =?utf-8?B?b0tnOXZFWVBxbkNqeHFLb2NLS3ZrcW1QdlpHSzZ6Z3E4bzMxWmlTVC9TeDZl?=
 =?utf-8?B?NHBlUEtZdHJVUUNtRkdWemdoK2ZmaGVRYmpiVVl2QlhrN3VvQkVia2R5Mk9L?=
 =?utf-8?B?VlRaVDc2NjBITFNVWklzYWIzZC80QnFXNWFjRlBvVmY1NWVBeTgrbmNWbTFi?=
 =?utf-8?B?SzJuQ2hsUTR5VEhYbkZpUXNHZU9uUHZ2UnY4S3NoU2RYQ1FJdENXRjdudlhq?=
 =?utf-8?B?endIVjlFU0s4RVVTeVAvVElsOE1VUjBKclVrREM3dkVHMTdKaU5HUGFBVE8w?=
 =?utf-8?B?N3gyczAydHQ5SG5DWi9zWFdpM2g0V2VkQjVWUE15T2xmK3hSM1Y5aHUxd2JH?=
 =?utf-8?B?UWh5bm1jTDFKT2lUelMyWW1MSFNrWkdrcEF5dUhoWkk1T2tiWjFrT1VyaGxD?=
 =?utf-8?B?ZWZSMS9FZ2RGWVVnZk4rbUZpZGdXM01INW9HcTdORnJjWFFvTndtU3dzQVpi?=
 =?utf-8?B?bFFPOVROejc5YlNuRHJFeDBaZ1htc2ZZd1dHVnU0KzgwdEJ3emcyT2RxL093?=
 =?utf-8?B?dTdqc3kzeW5Xbkk4M1luekVPZ09XUDNNd2VJU0EwR3NHNXlWSmp1MHJLYk01?=
 =?utf-8?B?WDJxcFhFRE1jVUlXdHVsT3F3UlBRK2RpdEZWRi9mUjNIR0I5SXpsNm51Y3NM?=
 =?utf-8?B?eTZQeE5idTUxVE82eXhHUUNlZzlZMGMwaGl4QjdWRzBiNWhvOE51c1VQZThB?=
 =?utf-8?B?WmtZMEZHSjYxWWE3V1RpeXJBNDZBaHkzUXNvZWhzdGlIUXpPVlNMeTN5ZGJN?=
 =?utf-8?B?Z2dwVS9jUUp4RGZ4SXNNYzlZOEFjS1VHSWpqT21vOHIreXhaZXh2cE1McXRx?=
 =?utf-8?B?WGptaS85UDhCZFpNSzFLRWhsOURnV1JpaTlTY1VnVjJic0JybExpRGxnRnVt?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CQZEb1XaUYN4IxV4lutMs9xTcAlR99uOGk+WhhAqmmv8f7GCw531orvZn7LBg/X5quYYNH0x9s0gP2qEhdagiWL2QCeghYWiZasMay/fHoYgIDwSbGGjMNoblk3shPGBgRn0m++Xd8SBovUi3UPcP4XmvHt07Ws3l37sRoekUZ9MexbmN98x8/tdnRmIZAHD8BvafkpEkl+a9armBKhAidFdCAOCtWfEb0vYNxYn+WXOuHbn9Vh6rnC9WkHeeMTyg0Bxu5NwaKffh7IfR+A9/G4MM88DAb6EDU8zloCwd1qbqbet/kcvd6uaQs7aTWCGXUr/IFE9IyRdczC+fxBcGVwI8s14SLDJw5LfXboM4hi0mKNv1pMhcjAgF0Pu28VXDq6tYvbHUD5fDxJIpj1mvsh5BYh0V0t/+mbTJ050fFDX3XIbC2tEJWGIc7zft50yse+r5H7hu02kVj8L2wC1V8BthqhF113qxHNfK8ZWIkhoTVKcoJ62mc480wNe/1Xl0gEko8Ny6ZJcg2sC/BZiiyu7GpJjbflOqqbMIYE/0+MnLM63ewoX71bbqkr2bmR5nrIySVKfQOyJPFFQua7V/hlxkYeMCAADNqvC+vu1XGE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3296e89a-6677-4d9c-1b29-08dda1b28394
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 08:50:24.3221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0h5Idd8xadxONzsJSN5hFlHnhZTvg7liKVLLoZBNcJBa7jBqQJLWLIEQ9Qak+qTCDpIanTbySM7P1Pvs746EGBaI9DO6Y0wbZP/V40X5Gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC7C4B0ED5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_03,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506020075
X-Authority-Analysis: v=2.4 cv=fs7cZE4f c=1 sm=1 tr=0 ts=683d65d3 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=ipsAig6x-wuCjoWyye8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-Proofpoint-GUID: cKcDX3bdRJmWP1M_hdxcd_2Zw1_xm_Yh
X-Proofpoint-ORIG-GUID: cKcDX3bdRJmWP1M_hdxcd_2Zw1_xm_Yh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDA3NSBTYWx0ZWRfX3aTFa6ykgmhh NYwZDVnpczhVE1Xy0R5A4ui4nY3/X3G1ka4A/UKkWODqXqXTV3YN6cqKxVTmREB01hdxuGedB7m KLF6lZvnT32r5Cw1IJVlTdfGqJ0lqIcZdYVxFsjBKv8s9fkVpn3LMjlTRwDRAd91kXmHYn+iO/R
 T0F1+EuDnLf0RD9eJ5wu4E3RsxbyxUrsFuSEfBMtgBXCNpf+xHdIf2tGy7GRYjPBtMwJKYZq0lm /fOQv0KDtvNoyf/sr0FZ4GnYlmwuXtorIeilaw/ta9LFepIxwCf22mUAEypZbfmpQUUk+XkzzVP K/EQu69ywPmhWilAZbIgPbYbyQ1ses7DB8vp60Gr7RghT9zLw5EFf/Tq2W0fXHT7iZ2f4DKtmJr
 PsNh4k3+5XECNrJwQk8bfUxqld1HJTC3m+MQ0apH599Xb99h7aHkMuWug8KwnLNBiDNoVXS+

Hi Mina,

On 02-06-2025 01:21, ALOK TIWARI wrote:
> Patch itself looks good to me, but if you can, please designate it to
> the net tree by prefixing the patch with `[PATCH net v2]` as mentioned
> in our docs:
> 
> https://urldefense.com/v3/__https://docs.kernel.org/process/maintainer- 
> netdev.html__;!!ACWV5N9M2RV99hQ!JPpnRT9itx84rhzAaeGelVD- 
> bnJR8vFksx2OjGzAKZWf_A6o8hEY0CUMMUO_NuSStcCyBGnvhoJAJlADszR4D_aj$
> 
> Also, if possible, add `Fixes: commit a57e5de476be ("gve: DQO: Add TX
> path")` to give it a chance to get picked up by stable trees.

I believe commit a6fb8d5a8b69 is a more natural and appropriate 
candidate for the Fixes tag compared to a57e5de476be
What’s your take on this, Mina?

> 
> With that:
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>


Thanks,
Alok

