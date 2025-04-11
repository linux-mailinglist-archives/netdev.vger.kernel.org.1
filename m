Return-Path: <netdev+bounces-181735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1562AA8652B
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C74E1B600BD
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B63B258CC6;
	Fri, 11 Apr 2025 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T4MMGGXW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CTlH6w2A"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FA823E359
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394539; cv=fail; b=S9ZnQkAKbCJgWW1fx3OzWEYRYVzYHhyPg0eFJrIaczojUDSnjOkELb93BrRaQu+NmI2gjgUb0tiWfkvWorSF2SpToJPw2115Gi5FvAXlBbDvDihnUgtHaMipyw3KHjc/d0tCGP0hgfj4bWhBk81YvAi2EhW+1a2ylJC79I0R+UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394539; c=relaxed/simple;
	bh=DXoPq88OxyQqFW5jNqynsX4tT/nSQYw5Bzbs+a0DKmc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CrOI2UwKuF4qPFCkEPbghPkQ6naFeFmbCfZZfKsPp/jWbzNkq1i1AbA17hcKJVf+cmzh4iNU8dckLYOSPfkS0XAzD0MxLlAajjvYyzGQSmTSFEKF5UNocSvwFgDSTeDTcZ3973xdiw0co/Qp1o4MVSi5T3j72BDWzkB1hB+9eDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T4MMGGXW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CTlH6w2A; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BHihKT006537
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=2crASyd4T8KBq8ka
	RgiNOKLikNiYM/hhPEVhNR2E4P8=; b=T4MMGGXWpvkEeE7qmPgTEkr3Wq5U79Ld
	V2R97upcakzgSav33KC5OIvPD0ag7L+1zu69MxQDUsos9uRJYa0bGVgV6KKQlHuj
	xNyZlQp+DNQSftxcg/CQaoFIn+l7IU+imvLBsq1tZofldQi9bZovmYZ/+abGB+5A
	nmf/IH1sGX4qh22D7w3nrat3hwLe46/SMi4+I8pm4fPJ9o/G9Ih/kNOCQB6s61HJ
	cJ9VqbHo9CpjuRLLEDXjLIsrimM2blndL86p7dVGw0n9vvr8ETPe4iotOCo20fZi
	xPDtGJqLu+s6ORLg8fTJqJEzj/KQKOOQdu1cWuPaQKh98hyl4utDpQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y7dpr2fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53BH0CL9016775
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:14 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010006.outbound.protection.outlook.com [40.93.10.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttydyn9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2bN/U00PWFYR2odvEHKpyG2PnYF7NWBOViIv2y/fBWy/gksXx/JyD9IJB7aHhqLfzB3kTWlO0yHkpg5QWBAG8VcQ1iG3NxJODsFkp8L3/wAIP8y+6fjpcEzhd84s1Lv6RyB2eOU0wTxzRS0OciSNPC9p3E0p8aWj7b089f1L8pCnWp8vh4/zln2f53mKKhBIrqKcPt0vdb7XelQkuzhuEjm39E/0hrEWR0zLpLQmw620eA92ap4byF2RDsITru3OA0Uo6Z4XkbFGyt69mp/ddKX4wOB8qdkvaHGLhDoClav5+dYAN5oGVYJ1SjmloQX5Q1lNOpe8JAhWh1nqrf1CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2crASyd4T8KBq8kaRgiNOKLikNiYM/hhPEVhNR2E4P8=;
 b=h0fG4weGEw9vMcyHDHJRVElCm7vDS55UdhUTgX5z0qF4+NiW8FYxkBSbwdw8t3+WP2Dm761YVhdow9FOnK3l+kNOCw12oYmDMl22tudacsCnYNiv3zS0fEeaQTvzh++IF5Y56Up8QKsOhI/TEr0r1SkycM5hKOyEsJxYQmumDWuH3cAgKK3a/TiDSW2zylzLNWJKMuvRp91L9bNmLVrSBdSdOuvdviseATrIJeBBfLp7gPZsv6BlVh08n4umNqifKx3wHiwbQLUJzC/6XFQXMXYTOAbTd4HzNhCyQzFNKXB81Cwq6wsCleMQoD0lzuAPKhEinpeNilJr4s1WIhfLMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2crASyd4T8KBq8kaRgiNOKLikNiYM/hhPEVhNR2E4P8=;
 b=CTlH6w2AOGgXSOWvcTHyWUX2/rt19pE3vxEdfl3LFxU0mNujOa0Q9Q5nwBFz13z3Kv8Qm4eeOjOFQ6H++ujwtrOB/4zj9RYH6k3VoyM0USmmQQRenAgVmlJPiSgvIA9Qr3pFB2igTVUEguxrGGD++DDpmXPWgEMtZLklakfmTD4=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SA2PR10MB4636.namprd10.prod.outlook.com (2603:10b6:806:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Fri, 11 Apr
 2025 18:02:11 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 18:02:10 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Subject: [PATCH v2 0/8] RDS bug fix collection
Date: Fri, 11 Apr 2025 11:01:59 -0700
Message-ID: <20250411180207.450312-1-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0024.prod.exchangelabs.com (2603:10b6:a02:80::37)
 To BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|SA2PR10MB4636:EE_
X-MS-Office365-Filtering-Correlation-Id: d1574bdf-d098-42c8-a34f-08dd7922fa9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cW91ZkI5U0JoNUZzRkVwQ21vZ0tHZmxFeXBtWXNnSVlDNTBadklxOUpaRHJ1?=
 =?utf-8?B?N2VjRnhlVVA3b2duUm9CbHJWekpHOTNBODIyUG1YdTdZV0FXNTduM3ZkWFNB?=
 =?utf-8?B?VXp3d0VJU3JWaW02VkltTjlCalp1YWtwWWF4THRjQU41YVpjMzhvS3B4dUpr?=
 =?utf-8?B?cTU3WUxycVlrZ1pGVnNXeExqNWcvU2FJWWZsRGpWZUh6ZDI5TUhzZ29FMml2?=
 =?utf-8?B?QmhFRmdGa2NhUzcyMEhQQjVtSEtLbmRNRExyNTBQTkJlaDFTQjdUZCswbDVv?=
 =?utf-8?B?WDJscSs0bUYxdXV3VStYNi9tRDBlQ1kzcGRNbkV4TWs3MzQ4VktSSzVmVy9G?=
 =?utf-8?B?NExpaCtrWmc1TUlDSUs5MjBXeDR4RlNDYTdjUXloSTZ0MzJxUmxDRnBkZEZ6?=
 =?utf-8?B?K2x0MFBEdHN6QTk2Z2VKOUlNOU16K2hIaElxMVRhTEFLZTAxQXp0a3Z3a25X?=
 =?utf-8?B?ZXVBczgrL0dJSVZtUExMMGl3bnFaRllUSTgzMjRjbFpTS2pzd1l0NzJwcmNR?=
 =?utf-8?B?YUdncE5rZGxSOEFmSVlHL0laMmwxL0pmNmJNUGNKanRPWStaS3l1WGhnaDVG?=
 =?utf-8?B?MzdnN0t6aVZjcEdZeW0zdFM0bUIyaTFjNi9tZjRmMCtPa1dwZmJjYloraysv?=
 =?utf-8?B?SU5mU2lqMHZGVnEyTU5JeGIwUUZGMkFsejhSeHhBL1MxcVNXSEtmY0JOcmRL?=
 =?utf-8?B?dkVNREluSFZlTEtpbUVZQkdTVjZkVUJIWkthUnFvK0dzUHBBUnR5Q0tmLzJz?=
 =?utf-8?B?Z3Iwdngva0hVV2g5WTRkMWloNUVlSUNiTytCN1dSK1YwWW1JWThiTzB4by9a?=
 =?utf-8?B?dDkzTjNnZ01rUXo0aFh5alpGamwvK1kxZXhRSUZwODRuTW1VZisrOUF1ZDZ4?=
 =?utf-8?B?c1hGRlVUNWV2WTFoSHkrRGx5ZXpEYzcwYUNnSW1ZMDZMM3JGbGlHVlh5dTZU?=
 =?utf-8?B?TERURHlILzJ0MzBCcEJJOHMzN0taOWRZcWczbTVxM1JmTzc2VjFNMUVJb2VY?=
 =?utf-8?B?ZjZGYnFscUVScW5XeDR1c1ZLT3FMR1ZpekV3RGg0dXZJNFgrZHNMdy9ieDBH?=
 =?utf-8?B?ZTNhdlZXcWkxTnA1V0d4bTNjOTFEMFQ0eWw4YXBWQ2xZTk4xczZXWERaWk5i?=
 =?utf-8?B?aDhmUDBxUTZteDFpempnMUsxeHVYT1pYQlY0MVhYc1pRdm9DZm1XK2Q2KzVV?=
 =?utf-8?B?eGp5N2xITWZkdWlpUzdrUkYxcUZIMFdTOWF3SmZtaHdiRjA0NExrYnpWS3oy?=
 =?utf-8?B?bFRwSjhnUGQwUWptVU1OaU9pQUwxTzNyOVBUeXJYMlNWNGtIQzlXNW9GNGNt?=
 =?utf-8?B?b2VjdzhaZ1AvdUcyYWZSOWlSWXl2amZTTnduOXRnRDdLMWYzSmQyMGxTVGJm?=
 =?utf-8?B?a3UxVEJRcDNka082aFhOSy8vak1SNXJ5NUJMVWM1MzQ1SkFBcHJYdHphbmln?=
 =?utf-8?B?WEJvTFhsbWRSb3hoVWx1U3Y0a2wrNDZIVzVDZGN1K2R2V3VSRXBpMDg2UC9M?=
 =?utf-8?B?K0RiK0dJeEwxeGQ0UDZsbmhDMEc0Uzd6WjE5c21OMWIwazNVcllwdlVXUGd4?=
 =?utf-8?B?SDV0amhaVEJnSDR0c25MVkZNSW9JSmtRS3NISmY2RFpmcUl3aFFzMWl5N0RC?=
 =?utf-8?B?WFYxd1pLbVJ2NXl3WVdIWWhTellpTXVyTTBra2JzUlIwOHVQakhWOGJ2aWo5?=
 =?utf-8?B?azBjVy9xeWloT21ZalZXaG1SYy9Rc1NPZXAwZTNQUlZIWFFwcitnUitTVkxG?=
 =?utf-8?B?RHlwSHJXSlFLaGcwRVFGc0VQSmtnSkV0T3gxamVMV2RqZUVkNkRrMTdqdnVD?=
 =?utf-8?B?MytZYmpjckJYWStTVmtLd1VvOVZTRHQrbUlJUmNpN1FkbVhzUVVUdk9CUXpT?=
 =?utf-8?B?cXdOcy9VRUhYRE9mS2Y0UjY2Sm12aEYvNG1lNjJBVDJkdDg1ZzFVcHc0ZzQx?=
 =?utf-8?Q?sEiMyoywYQI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2FEYTZFckpwaGVVRGg0akY1NWdBVVBDZkZJQUN1Q0N5Y01IVjdzS3h0clBJ?=
 =?utf-8?B?cHhwbWlKREJjaVg5VHRUUDZLNWVTdzZoWG50UXR2YytFakUwNHAwaGJLdGpI?=
 =?utf-8?B?SFYyMHZRUjNuaEQ3MjlwczBmcGh4RWlKS25UWXQzbXVwWVZNTWd4WWJaWGRv?=
 =?utf-8?B?QTY5N3RCZ3hhS05ReG5hVFZ4aUlWdExlYXl6b2xkeVB1dzZoMklMeU0wWFk1?=
 =?utf-8?B?dG9ORmk2MW9nbW1yclZvSWJQcyt3TjYwQWxUaXZxTDBnSXBTQ2xmYWVKUDAx?=
 =?utf-8?B?K2x6d1ZNaVF3ZE1EQUdadmJ5ODVmeHRqdmNZWWF5Q3l1VzBCdDFIZGg1NU5X?=
 =?utf-8?B?eVlVam9ia21yZnhROU5LTEdiWTY4MUR6ckhRYkVMaGE5RFFSRWplZkZ5aUQx?=
 =?utf-8?B?RHhWMHl6alpUZ2twamNzU000b2dVazBPV1FaVGw1QTdVMStpQnYvS3NHL1pB?=
 =?utf-8?B?bzUxWVlyd3VEcjB2elJ2WHNPM1pDelcxSDZOVFE5YnZtVDZnWFMrYzBobHlq?=
 =?utf-8?B?Zk5BcEdudDJFTlNtdWxMZEtKbG5jU2JhdkNNUmc3WndqWFVHUnZGYVMySWVz?=
 =?utf-8?B?MDFQclFQVHR2TGVQZGl2MlVWNHhCVXNLL3pjRzZOY2U5Z2c4TUY4MnZWNUpv?=
 =?utf-8?B?Z09HTmQwVzM1Z2hPakR3YkhtU3haOUlVQ2pJc01rckdGbFhkbkYxZzhEbWEy?=
 =?utf-8?B?TGdjMXFrOHZiUFJGZ1RvcXA3RUdYbmVVYVNLYUNHdHVFd3owMEtnYit5OFpH?=
 =?utf-8?B?c21VeHkwdEloVXFtTG1vcmFNcVI4SkRxMFFpZ2l2OHFXUzRoc0NLK2pSMlFZ?=
 =?utf-8?B?eWk5Wm1ZSWkydzBGZHRlbTdYekNoQkl3eTR1bmdINnZDdWd0bVlUNXRqcTNt?=
 =?utf-8?B?ODR2akp1YzZQYWsxcHpsd3AyZGozUllRbXFwKy85Uk9SY3ZPc1ZHR0U2MUs4?=
 =?utf-8?B?Y2U0TVovSmRiY0QvK24xeG9FZU4xYUdaZmNrK2hJMjBnZ29LTUowSGYrWk1M?=
 =?utf-8?B?MVFHY0lYaVZKV1JqSWNKZmdjZ2RjWFAxZTlwdGZteERyRWt5cUEySzdLV3Qy?=
 =?utf-8?B?R1NsT3JuYkFaNm1ZbFc2WGtxYUpzUGFKaUhLRjNwQjFqazlSaFBIWGFnQ1U4?=
 =?utf-8?B?WldqZWxrOGNRV1JibHdLQmJpQ0hTNWh2NUpwMkIza3Z4eDdBV21FNXhwWWNs?=
 =?utf-8?B?NGRUTm1MY1A0bGE5VTE1a3JYaE5JUStKWUd5cklGSnJsWFVsdHJkcndDSnJL?=
 =?utf-8?B?Y1pKa2tVQ01GNmpMRjFDcFYwbVUxNHN1TnQ0Q2hxc2c1VTZUZVVlTG9rd3NH?=
 =?utf-8?B?T1ppR2NjRy9IcWU1MTN0aDhqM0FoSm9Xd2xFQng0aWxmQWt5MWhOQTNDQzhV?=
 =?utf-8?B?TmJ2bXJUV084YXYrYU95VHdqREc2ZHAycXBXWGN2TTdWU09ENU1mZEx4VHpK?=
 =?utf-8?B?eU9OYlVQdjR3bTkySE9CcG51M2libE5GZmNVWnRUKzl1ZHhNVlVrMy9YWEkr?=
 =?utf-8?B?bnhXRXdSZSs0YTdZZkwxVWMzLytadUZRc3ZFZFN5TW9qSU5KTzdnZE1yU1pt?=
 =?utf-8?B?MHdjMHAzZXZhUFJYVFRUckRyQTM0KysveFcvQUdpWHdPTDR0cU1GanJDODFr?=
 =?utf-8?B?Z3IwNy9WOHM0TlRxSGJMc1RWV3hZZHFpTXJEcWp1NEdwejlGb0pzQnNxSzlk?=
 =?utf-8?B?VDhOdVZlSGlBdUtUdHN4YmxQSGZjQlNkd1JXWnpnaVZ3WGZoMjVCcnEwYUR2?=
 =?utf-8?B?enhBZDZ4Tnl1Q1JzYXlITVlUNkFmcVBtYzlpWUNweGFPazVQT1NFQk5tLzFj?=
 =?utf-8?B?L2Uxc2lBK1A2cmQwakM5MjZ0eTNVRlFmeWduRjNkRTZYTndrTVpleklYSTZK?=
 =?utf-8?B?YW0yUXJVeFFYajhFZ05WbHBjWEN1UjJkUS82YTBBQTBXakR5bFRGVmFWSEtW?=
 =?utf-8?B?R1ptU2pTcmxMRHZBNlhhbVQzVVJ1MXJsdFRkVk1UMS9VUGd2RFpUSVZJcXlL?=
 =?utf-8?B?ODV5eGNPa1R0UDBqaXN1Z1BySTBZQllsTUVmMi9rV2VaRlk1eUV5dmp2LzBY?=
 =?utf-8?B?YmtNL2VXQjBXSyttQm4xc0h4TmpzZ0xDenRYQ0tNZW5yZ01iUnJrMUU1OWJv?=
 =?utf-8?B?aU1WKzh0RnlFaDFIeTZFbTZjQkdWczB2K0dqSXdReG9NYllGdVd1SGRHTUtj?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AxawjRJvDu5m5lIJ2VV5j3NQqM1Yy0UcQGvQR8L+s80h/OKPMxoGYtF+c0T0yrukTupDrA+Aqd6JJzT+c5qYArconTPogbiz9xfDjMQ2kW9EqZ15JDtitqJbSrw/AsqkneaGdLqOUD97Fk2/i25j7UtT2zNY3hQHZDvEpSYgvn+cYUePVuKbD46eORk3Hqefdq3JI2icmPxAak8eB8QEIUGNgJspfspDAIWuS+oWBaXnaG5/kY5TqEEub8kV3BitTymU5M/IDvqPftZXDNx5uGWm+X3i90Llj/fcI37Bgi6Ue7zSveL375HsLoXS3apgz+tHfuEWWUEeRDU3O6NNczI1L3pkhat4/2XsMrRx0/cYvrlwbtxjbORH2fHbsAp+uHbOf0nQ0NJJe3YnYwpjXEXgC28diBa5R8jfATTWFwgR0Qy1hmnmiAOEeGo9MyrFH8OPiG799pD9hqK5m1XxR1HAj7Lp4BtSKT4d8KGMg7f5xaGWfgD2WbhkH19AT0ZDawWLWokbmFCo0M/aPdqwY+IZ9GJad3t4wX36453xfNLwRsPoK0BtPd/yWfw/t9sJxqRfHb5lPWpeMuPEzuYG01iaGNWSRex73E8JEY2lvOw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1574bdf-d098-42c8-a34f-08dd7922fa9e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:02:09.9742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IzObLixfV8FrZaFhyyMFnFcpwpew+LDHxlm23u6/AV5Tbhaf6xSZkxqVV4JylBAsRduRPXrrUG/fEoKh8cpna/HBQZWfn2eXXHq3JbsJfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504110114
X-Proofpoint-ORIG-GUID: 1jmzUI3yp2PZxUjUeNAkjmyNK8lclNvL
X-Proofpoint-GUID: 1jmzUI3yp2PZxUjUeNAkjmyNK8lclNvL

From: Allison Henderson <allison.henderson@oracle.com>

Hi all,

This is v2 of the RDS bug fix collection set.

This set is a collection of bug fixes I've been working on porting from
uek rds to upstream rds.  We have some projects that are exploring the
idea of using upstream rds, but under enough stress, we've run into
dropped or out of sequence message bugs that we would like to fix.  We
have patches to address these, so I've ported them along with a handful
of other fixes they depend on.

Since v1, I've integrated the feed back from the last review, and have
since stabilized a few more patches that should be included as well.
Below is a summary of the changes:

net/rds: Avoid queuing superfluous send and recv work
   Removed

net/rds: Re-factor and avoid superfluous queuing of reconnect work
   Removed

net/rds: RDS/TCP does not initiate a connection
   Removed as a fix for "Re-factor and avoid superfluous queuing of reconnect work"
   
net/rds: rds_tcp_accept_one ought to not discard messages
   Fixed uninitialized inet found by kernel test robot
   Fixed smatch warning found by kernel test robot
   Moved kdoc for rds_transport into member specific comments.
   Added comment for the new conn_slots_available member

I've also included a few other bug fixes that I wanted to include in v1,
but still needed work at the time:
   net/rds: rds_tcp_conn_path_shutdown must not discard messages
   net/rds: Kick-start TCP receiver after accept

These last two needed some additional queue management patches to get
them through the selftests.  So those are included at the begining of
the set:
   net/rds: Add per cp work queue
   net/rds: Introduce a pool of worker threads for connection management
   net/rds: Re-factor queuing of shutdown work

So that's pretty much the break down of changes in this version.
Questions, comments, flames appreciated!
Thanks everybody!

Allison

Allison Henderson (1):
  net/rds: Add per cp work queue

Gerd Rausch (5):
  net/rds: No shortcut out of RDS_CONN_ERROR
  net/rds: rds_tcp_accept_one ought to not discard messages
  net/rds: Encode cp_index in TCP source port
  net/rds: rds_tcp_conn_path_shutdown must not discard messages
  net/rds: Kick-start TCP receiver after accept

Håkon Bugge (2):
  net/rds: Introduce a pool of worker threads for connection management
  net/rds: Re-factor queuing of shutdown work

 net/rds/connection.c  |  20 +++-
 net/rds/ib.c          |   5 +
 net/rds/ib_recv.c     |   2 +-
 net/rds/ib_send.c     |   2 +-
 net/rds/message.c     |   1 +
 net/rds/rds.h         |  74 +++++++++------
 net/rds/recv.c        |  11 +++
 net/rds/send.c        |  13 ++-
 net/rds/tcp.c         |  28 +++---
 net/rds/tcp.h         |  27 +++++-
 net/rds/tcp_connect.c |  68 ++++++++++++-
 net/rds/tcp_listen.c  | 216 +++++++++++++++++++++++++++++++-----------
 net/rds/tcp_recv.c    |   6 +-
 net/rds/tcp_send.c    |   4 +-
 net/rds/threads.c     |  40 ++++++--
 15 files changed, 395 insertions(+), 122 deletions(-)

-- 
2.43.0


