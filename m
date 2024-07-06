Return-Path: <netdev+bounces-109663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CD992974F
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 11:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7961C20BAB
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 09:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F0211725;
	Sun,  7 Jul 2024 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BtqICMpk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wd3+Q2Sm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D9818028
	for <netdev@vger.kernel.org>; Sun,  7 Jul 2024 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720345211; cv=fail; b=YWYOiGMzzaMWV3sZw3iutD1Txm2O+a4YcUhOwrU85tWehZ0Cz91MXo7zC5BqpM6F3RlBc5kPALywhf0Ve8TtUZLoAuindCxhGN4frvwUd68fK75G133Mx1XJHLT3qgmSWk7KKkChL+jhi9e7KXINMWjvgttPV8J2dlYDGnv4aEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720345211; c=relaxed/simple;
	bh=vL2UZErJK6t1DMQPZf5+S7Mt7gLKYmTVQmz6AfN+y9Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L/f6QZVZ0omyhk5QH+RSVoAwJmdhTr7wzi/q6ESS5xOz3gyoC4MCmy3X0iaGLa9gx2VhG8MWzvM9Hgzi3/kJikZjq9OOKHnFxJKmjdyyytKKN3h3P44u1uo79h+zo2aIhaEO4FBvcKTdtXxuL/Y5A6FBZXd9RJ+gRd0QctlYNOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BtqICMpk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wd3+Q2Sm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4676rLEW017972;
	Sun, 7 Jul 2024 09:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=rYwpYO9NIS/UT+gMd3FnXPflQmzovNmT5Ryhk0lurqk=; b=
	BtqICMpk2V74N4AxwFGmqAvFcOH/9fsknZooUiVclWU1uBMDAQz3m6uzCQ/7Q6m2
	RMcfhZ4OedJ47s47zpv1QQyKAdoKYzFzS/J7+reobUYYEp7zL3dQSKpGZvpSs20e
	BWFV7U+3wCk/qvkwE1Qqjpy4o53BGvu+fIhsMBFvmVy1Il5FtrXxUroXCwOI4533
	4jF5vzYAKOOPHApD07oScrp8ktBbVv4e6H4F73GdSrZoqp1svm6jT64QIrg6FBQ0
	feA6SXZWaU71Yk+F0hhQMKnAOYygXqZNAZ3zBm/FX3+BxbusGj14vCHBIgAym3tm
	v+KKNsARt8YRmSfODV+jUQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky14j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Jul 2024 09:39:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4675fd5n017842;
	Sun, 7 Jul 2024 09:39:50 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 406vc596tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Jul 2024 09:39:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8MCr7s185TyPTPu49BJT6IKojC6xzUNFkehxD1Th+YweCcNq1ZbeIVzVZ0DG5jfv4r/4+Dzn0hyVrh6uk9b5nhzWVMMT/pj5Zyaow+mksK+HYscC2dbOjlpV/I+Dj2fkzWKPVv+gAhvBceRTKwxuGIn3BR/rXRwn8cpiv8gQvdlZ60PouWTviDs59Fe7s4fOMDFyHybXVtH342Xjtld5n7HtMI0FbJjLxUOLr+ta/uwr79vR6YrbuBV1irUxNAC/F1vv2dpMTNyVrbjB3Ee9N9PnqaSa+WeV3oEsq9rRcbMFVMZYAMSVcgupasGbzEJNRRba6NQQ+dhlBH8+ptoag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYwpYO9NIS/UT+gMd3FnXPflQmzovNmT5Ryhk0lurqk=;
 b=VZHPcCJYxIIo6e+oEWl87BbXErSULHjKkvPa1+j5eiaPuANOubHum1sKodAgc4b3ehese59d1LZ2cFwsV+aHmv7cAODtR/sPEDji5mVM1fGxB2verwlAbxVoyPXz+rFRgpbx/VGVIKcJU72rSjhw3ti/zpxvtXruoztbz2w8HaX7jVCaO+4HOXSbXect88kxUNPWN2BRtWRHkkCgSdRLqCQ1guSXVTXGGIsdDRl/VvQk7JGCfcu38BNOrionJdUw0jVEx/mz7bGmGnzUEHGIYuiuYqrRPgBoppIU7YCtrWYn7UPK4qapUUohJA6RsLAipM+CXiUlyF9CCipFl7z9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYwpYO9NIS/UT+gMd3FnXPflQmzovNmT5Ryhk0lurqk=;
 b=Wd3+Q2SmOnj0hxtOqCkSBu09PMRi4GSP+V5RC8UtDLgqSvkvwBN35r/yj8q2nCVszT1TEpaNCrdjlndjinZu4m/Mokgqo7ILZprrW+iOedkCKJkS2tE8RrsB1RF1SOWw0Ynxpr9Gf4IybyPB+N0TqAj+n0WRdfdwhbGKrVvnN8c=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by LV8PR10MB7752.namprd10.prod.outlook.com (2603:10b6:408:1e7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Sun, 7 Jul
 2024 09:39:47 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%7]) with mapi id 15.20.7741.033; Sun, 7 Jul 2024
 09:39:47 +0000
Message-ID: <d5234126-ed10-43b5-ac81-d9edf21f9d7c@oracle.com>
Date: Sat, 6 Jul 2024 02:38:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net 03/11] af_unix: Stop recv(MSG_PEEK) at consumed OOB
 skb.
To: Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
References: <20240625013645.45034-1-kuniyu@amazon.com>
 <20240625013645.45034-4-kuniyu@amazon.com>
 <014f053032241c56a0f76ea897caa6a08d3b3f7b.camel@redhat.com>
 <703aee1612d356af99969a4acd577e93a2942410.camel@redhat.com>
Content-Language: en-US
From: Rao Shoaib <rao.shoaib@oracle.com>
In-Reply-To: <703aee1612d356af99969a4acd577e93a2942410.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0406.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::15) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|LV8PR10MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf9e154-4b53-4aff-ab24-08dc9e68bd6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q3BHZ0RrYzh6NXQxSy9tbTEwNk9sWGx2SFRRdG81eEZuZHBIWW0rZVJsQ05J?=
 =?utf-8?B?THJpSzBOakQ3TklFdEd1U1BVcm94TGx1aHp0M3BCQ3p1Q0JTOHZ6UGo3eXQ1?=
 =?utf-8?B?NzAxeVozQXQ1dVN5c2hVYXpkYXk2a29zYXRqbmRYNHNJUzJJVnFhS2U3a01x?=
 =?utf-8?B?NkhFL3gyLzNacEdQNzcrQVREYVJidW9HQWQ0RTZpWjJxcjNscHdib0JpUXho?=
 =?utf-8?B?OGttWEVOU0djVzRWL2ZYRXFvMDRaY1lBYW90YkUrbmx2M09YTXFsVmlNZmVJ?=
 =?utf-8?B?b3NCYitrY3JEZStpTWFrbkF1NHQ1Z0dPTzRmSFE3MXJ0c0RVN1Ywb2c3WlJZ?=
 =?utf-8?B?TlR1Y2p0anE5UUp5TnZVbTlVeXd5bUdNekpiUXJYSWJJSVk5cWFMenp0Rytx?=
 =?utf-8?B?WE1wbThXT0dGTHVXOHZRL1Npck5MVDU1TjJhV1pjZkZtVks5VFpxTzRpS3Z6?=
 =?utf-8?B?ZEx0Z0w0UzZMbkxRZTdPdEpSU09ISS81dzN1TUZCcC91bTRzaGVORHBncURm?=
 =?utf-8?B?N1FZcno4VUVDQXc1TndZZHNCUnBvZnR2WjVWVjFsZ3huRW1lMEtnenc4T04y?=
 =?utf-8?B?OEhxRXhEenhKYkNYK0ZIWlVsaFUrQytDaWhtRXpJSTR4NjlkaWF3b1hxRkNK?=
 =?utf-8?B?YkpyQ2FlbHhLQU1SZzlmOHVqRFlBZG5pNzYvemgvTVliSzdveWdCTW1INkdW?=
 =?utf-8?B?K2hFOUhabWVhRXZmWjlNRDZ1ZnYvSzhEN0M0bEpIcTVjeHBxRzZvckx3NEln?=
 =?utf-8?B?OEFYazJGSk5STHB0elpqVElFTkI0OWlPOVN5M0c4enh3NFJubEZGQTVGQWFr?=
 =?utf-8?B?MTRNOU5HOTVaUlljUzNVS1hqT2FMbzhvYUl4NzhDMDF0L3ZXY1kwK0tmMDZY?=
 =?utf-8?B?blVLUlRCM3R5V3ppbkR1MW9DY0Z6T3VFNlVXbE5ZNEVRZTU5YlJ3MEE2K285?=
 =?utf-8?B?enpxS0VnRkpnelBYTTkyMlJGcnMvOVc5K3QwT25vT3FnOXNkUjhZYjhjeFp2?=
 =?utf-8?B?aUwrbVF2ZHMwTEhyOHVMWjUyUnJWbjAxNXl3ZlJ4UWRuMndGdnRDZllPeFhh?=
 =?utf-8?B?WG1VaGxlWE9ZL24vRFVhS1RkR2NxWUlHU1AvZnZ6Yms2Vjg2MTFVK0lIS3Y1?=
 =?utf-8?B?aWl0S2RMeWN5WExIQTVIRHFDVFk0VGQ5VnBxOGhvWi9hRHhEUm1EUEh1alUy?=
 =?utf-8?B?UDFFVnJVTnF3RHVMSW9LVUFicWpYbzdTZ3F0Wk1TMFdMcCtKd09UdXBUZ0Jk?=
 =?utf-8?B?Q2tpYng3U2t0WFdBaGsxVmI5bFBqZkdsSndJQWR1OEU1am9zbldHTUhOT3g4?=
 =?utf-8?B?UlFLYkV1cHVqUVpxcnRvNE1zWmhEeHNnYmdQY0JKd3ZwWEE2bVRkZjk3cTNj?=
 =?utf-8?B?cDZGQVFWSWw2dk13eEhEeEd2cHhUU0dzMGRTN1VxclR6SEZ6QStwckpwTnZz?=
 =?utf-8?B?YW5obENwL2Y0UCtIaTFMQVlVdm9tbjIwVmR3YWFpd3lSL0k4M2kzN0VsZGtC?=
 =?utf-8?B?VlJaNXBzbmxWSkxpSmVoMEJoaUxZRlowelpWdnJ4YkRDWXhMd2R2aWxGQUJr?=
 =?utf-8?B?N01yaTkrVU1PK1RkWXN6SmRxS1VwelYzRDg2WUFuaHpiaVRBcG5laW9yanpa?=
 =?utf-8?B?RHBmSklqcGZaWE92Y1l2WTl5VzBYTmlMWmVoT2ErZHo5Zk0veXVZNkZhL3ZU?=
 =?utf-8?B?dzR2WFhHb3QyK1l1UDk4Rlc0ekE4UElNRThqSnBBS1ZxakxzbTlMSXZTa0N5?=
 =?utf-8?Q?8/hmsVILVQw+XRuBpA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L3VNaHNtT2NEakdGRkw5WFVCQ2daelVuVHZLR05ocEhmN3kzUmdlS0Nyb1Zk?=
 =?utf-8?B?cXM3REd0eWxnb3FCMVVOc2Rmam1jU3NqUWsxUUNiVVFseXZjU0t3RERzS3I4?=
 =?utf-8?B?ekF5TEpWVlE2RU9ENHQ1d1B0MGN5Z053SFJIN0Y5bGRCVHNuVmkvTThGVDdM?=
 =?utf-8?B?OHVoRDBpUmZsU2RJTzk0U2NBRWd3a0Q0RGpia1dMTEpLelp1eUZOOEVoRWF3?=
 =?utf-8?B?UzVHSmhQSFFBTko3ZnNFb0huZ01Ya2xHYVgrS3R6S0h1OGRzVWtSeXQzanFm?=
 =?utf-8?B?NEVvSGhBZDU0VTJySXRVZGp2U0psS1dpRExJYTkyRXl2bmhkak5rbXZIQ1lr?=
 =?utf-8?B?RS96dDdqamZuODZXemxueWcrREFmQ0gwN0NVZW5XWld4aEthRWRPdzh6MGtB?=
 =?utf-8?B?dThHZ3JIdWhHdU5XWVcyL2hXcjFNa0Z6THJ4YjZyVHBXRjg5TjNqbVl1NTEz?=
 =?utf-8?B?MFdqR0hWdy9rdUoyZ2hJTFZMYk4rbFhyUzRwbHFwVlJnaGwzTExuK0dHbFVT?=
 =?utf-8?B?a2w0SG0yL2lCU2hpblh4RmQ2Um5QNVkxQVVvdjVodVZxZGw4K2lvNHZLMkdX?=
 =?utf-8?B?NkxaNnJpWUhUN2FSYUtoZC82WkdRNUl5b3d2UVFzZzA2bDVzWjVUZEZoczdG?=
 =?utf-8?B?K0xjb0thMEJ2clJIQlpCbU1TYTUvNTYwbzhuS3ZpdkRCNWZFSjNZWUhpY2tp?=
 =?utf-8?B?TUgxQWNCVXNVQm95QzBWWEpNZFNMUVRRMG13ckx0TnlBc1VNd2Y4K3BKcmRw?=
 =?utf-8?B?c3NJZlAyMGl4YXAzUU9uK2RYNFpJcFlCWDhRczZoUW00WDNMOWVDaUJYakNh?=
 =?utf-8?B?S0dvRlhuWlRHOXNUNjAwWXk5TFhqTFRHWE94MEx1d2lKam9tanlwMzRkQ3J4?=
 =?utf-8?B?UGhsZ290WlExa1ZqekJWa3Y0eDZ5V0xiZCsxMEowS0RjQUZ2SUhvSnhybDF4?=
 =?utf-8?B?U3JIVGlHb0I3bEJEbVc1ellyMzdIVXJXcHdIa0s3NFI3d3hQVzNsYVczZVEx?=
 =?utf-8?B?VVVZaytBTVJoZlhuMkZJejdZblRMSjlIM1JESWIrY3FkNVZYNFd5NTM4Y240?=
 =?utf-8?B?NUp1YjZKOE1BSHJQc2lIMWc2MlIxbkJjQk5oajVhS3RMeFZSVXpwUWZGSFIz?=
 =?utf-8?B?MXhtdHJKekY1L29vbVVkOU9GRzBUTFEvN3ZvSnJ1Tlh3KzllbEFYOUpkY3FU?=
 =?utf-8?B?RnJRU1dxaGxxS3F0SVIzUUlUQXhCWlIvelkxLzdtRmEzYTQ1MU5wMnVVSTBm?=
 =?utf-8?B?VFhja1V1L3VnVk91QTBtUFU4dWdQL0ViUXhKYUk0dTBmTlRqS1NBb29HNncv?=
 =?utf-8?B?a2J4Q294R0ZRV0phanF5RXYrT1hlVEI3L3NyTzZjTVd5VVVUaU41d0wrVC9F?=
 =?utf-8?B?c3VuMnlrNVprQWRiRzhMUGdnbW43MTlWMXlKaE1XbUVLSHltbmJhN1drUkow?=
 =?utf-8?B?cmNieDh1eXB3NWpHMzZuQUplWkF4UHNmVVhYOWNxTktNTHRSN1JuTXNOSFJh?=
 =?utf-8?B?Ukh2UDRSZURBbkFHQVZManpFS1JHbXZHVTljN0VNRlMvZGZwcDBoZTVtZVJL?=
 =?utf-8?B?c1MyN3NpRjZhcEg3Z0toZlR4KzM0bC91NFp2Wk5XL014TzZ6VkFXckNtUWNv?=
 =?utf-8?B?UDdoRWJuaFJaa3NhUmY0Q2Ryc01uV3lmaVJTQVFZeittMTZCSXZzeU1wQXZ1?=
 =?utf-8?B?dkFtMGk3UThiZFBhYXI3Sjc5aWRRYXk3NWg3UnEyWmtabmVHbnFmakI0ekNt?=
 =?utf-8?B?ZXJvSE1laUQ5UmZ1bEVTNTVCQjM0cG5lbitIOW1LRHp2b2QrV01sZjZWVDBC?=
 =?utf-8?B?eEo2dkI4UlBSK0hlSkpLdXlkYlpGalRuSFE1aWdadnhqMjFjNDhuU1orbWI1?=
 =?utf-8?B?dEx2TUczUENTVCtnUWp3amRHVmE3bzdJZElvWmcvYVZuSi9Mcy9CdXRmMzNE?=
 =?utf-8?B?Tmh5ZTRZT1h4dmtQTUVhdHQzMHFQbkxnZHArUEV4d2VSYWs5SUJEV1NnaGNt?=
 =?utf-8?B?UVlycWJ0bHN0UHk5NmtWSHlKeHkvNGptQWFZa2pxNFY5YzlQbzEzSFRuYlZG?=
 =?utf-8?B?OW0xOXJoa3dTdUlzQ01GNFpMd09lbU84Y2p3NmdTZmdSRTNKRXlWQWFROVQx?=
 =?utf-8?Q?NcAJDaVGSFQBRuaHbVte+Bn+1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	89pA0I0gLB8Kqw3gRhhvTWd+U1dSNt6vmJ/XwK2oMtOyo1FJLY7jVAsGCxzcsZy1mxy6bXBh6S44Z36lgPtw/PyI7CJ4OThAvKvAXOrI7LGizR5IEY09BrWwCxDlLeMGzDXTN+NzfTalUqfiVzp5U67sqLIHxuoeVNewTKNTCsTRpj94RJhb3CKGcaSk3bOfSu83kkid6/24iHb/YPtpvR5+53rL9jzZxzy9Bje4A8lnOFd3XjLGSYWAEkMCFSPtrmSO03Xymp4Mpa3MSJkYtRJPXHWhoV5mDT76LBg+MJMrRZPoF+m7LCdJl7xFSqOjrFKiYUSq9MlIw5jOG98vq8S/5b23C25dzwc0ji2vvly8EIqeJJsD3WoUU8tm06/LSig5Yn55XWz6HOzw/tgJymhZZttCesJfstTruhv6kRKCWWo2Ww14Ma5vYjn92MKlBlYfYMHCEnKN+5WzTmVFkSrY+t9JgfD++/7Pb/sWC2hFKvQLzHES6/qfngm4hl8V0DWWjCOc2dDDF+AwMF2kE2OUwt5Ue1ntr58WP/6OXqdMic/fYR1fki+U3HdF1AynJNT6/QSiCund0/biwwEuocOvNqdJ9Uj7TOzKFu9ZZas=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf9e154-4b53-4aff-ab24-08dc9e68bd6d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2024 09:39:47.3337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuSqu2BVPvwNekxTbARR8vYZboUJXVqySjmH/XIiM7ONT1SgEeZo/MYwMQdjiM/XrIPZr2NFO3W5HkHXWyhncg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=869
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407070077
X-Proofpoint-ORIG-GUID: UBD3LG3xR-1_ll1LLN4QCs5BcbNue7_W
X-Proofpoint-GUID: UBD3LG3xR-1_ll1LLN4QCs5BcbNue7_W



On 6/26/24 02:10, Paolo Abeni wrote:
> On Wed, 2024-06-26 at 18:56 +0200, Paolo Abeni wrote:
>> On Mon, 2024-06-24 at 18:36 -0700, Kuniyuki Iwashima wrote:
>>> After consuming OOB data, recv() reading the preceding data must break at
>>> the OOB skb regardless of MSG_PEEK.
>>>
>>> Currently, MSG_PEEK does not stop recv() for AF_UNIX, and the behaviour is
>>> not compliant with TCP.
>>
>> I'm unsure we can change the MSG_PEEK behavior at this point: existing
>> application(s?) could relay on that, regardless of how inconsistent
>> such behavior is.
>>
>> I think we need at least an explicit ack from Rao, as the main known
>> user.
> 
> I see Rao stated that the unix OoB implementation was designed to mimic
> the tcp one:
> 
> https://urldefense.com/v3/__https://lore.kernel.org/netdev/c5f6abbe-de43-48b8-856a-36ded227e94f@oracle.com/__;!!ACWV5N9M2RV99hQ!MxZ1Tdors9BCjgG4K-LeD_fvtJ0mQ6jgbR5CfGYIouxV7LbYRiKf7zCml6SKYN7OLG7LZnZHnBnVfyo$ 
> 
> so the series should be ok.

Yes.

Thanks,

Shoaib
> 
> Still given the size of the changes and the behavior change I'm
> wondering if the series should target net-next instead.
> That would offer some time cushion to deal with eventual regression.
> WDYT?
> 
> Thanks,
> 
> Paolo
> 

