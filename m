Return-Path: <netdev+bounces-201553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B47AE9DFB
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59EE21C25739
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 12:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6E42E1C58;
	Thu, 26 Jun 2025 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CpkUW2lQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a66sz3Hc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D22E1C50
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942742; cv=fail; b=NS7LSVvQOsbDBZ5std/kYavX5yG7OQhfyRe4XSnMS25+NCl4VP/IfBXz5ZANjYG/HivYtFwD2Dx0qQ4kx84ELiQkEssHu0jgpdSjRVfttVxpiaESa7uKYEJHziZg29I3ydnodOZJdYpdQxPyqyXRUkV6ZyQoEG+mz0Yva7foCh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942742; c=relaxed/simple;
	bh=pL8RxqruVoOSzUVThJQuiFE/VYREa6bKEOcK6KBA/us=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T+MqUq/Ha1vcOteFOlGK2rttsWUJPbLLukDvP6ZeznKXeqv6M/OYJNYqQV33CiSHBVlZc8F2FBPnx0ie85pSCc2hLDjlT3WaNKH3ZIrm+z8L46dQvmXroD3JkmwwCmUw/krntdnoC1qfbFFpNh0kNcokM4raFD/6bJRWcoz9g9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CpkUW2lQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a66sz3Hc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QCauEf005467;
	Thu, 26 Jun 2025 12:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dM6YrvfrNO2WPej6Sqcbt0LJzkKM780CYMg66d2Ab7E=; b=
	CpkUW2lQ7wwWAKjgWcVA9DbJNbUTvyOrv8qSw1nvtKOolF/wl3WU5oN6nNRImUOh
	DaCIL+T4DHCNSHwZTeoCIOCOKUjSQNtrouKX4A6L87RzjT/kaxeQdKl4m4cw3oWs
	8C/ZYNZMGdnNDgbHzxQtvtBKGxvO2W6ozNqEwMNQGHQvQRRk/x7F6ZzHiU0UlM9Q
	nUGMDaadGLNh/7uYds15zWeeTVuko9k6HaN5Yybl94HrllFYeSUUGswr2JZH9ftL
	oDXzfrNwhDCV+8zNix3LrP7JAqYIRsYM/N4X8Aaw6qWawBFfdSn7luFuqS3nYV4m
	eGnMdMYeNebzRacXejAQuQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt1gh7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 12:58:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55QBe9pp016875;
	Thu, 26 Jun 2025 12:58:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47h0guw6kh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 12:58:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4nqTcJXUl+O4bNJIFt0Ff/bDgKzKbIsoQs1EDj+eeZxRX3GZWUFbNUHWB4XPFV9IoNoIuaQ1BD8I8aYy35s8XTaSMGmqlSs0Gz5tCGsaSY/MfYWFAsy+WuJpgSWGfY+t6x0rUROYSc4DuShhtcjcEsrYNEuNv4A040dFdGgfwTQ7Ig0etF7e1MtZZQkQVb2n4ayn33e9te8+z0WIF6CFbAO23VZjobP9yMY1c63p4bKKs6j6BRVBoeeKeIzleBGUqCc2NRf35OcfUi7fd/aqTXLLK2K84r09lqlxIMJ9JLudV2oLr5T8fhqQaVk0d24nrAOs/sVwzqsm9R/AV/Jdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dM6YrvfrNO2WPej6Sqcbt0LJzkKM780CYMg66d2Ab7E=;
 b=WyqdLHQyND2ol6UIfmqNd/OI26vGSCqHohpiYyFPH3pDlc7dpnA/GnsfwWqMHAaiBMMoT1GtWk1mlL1TuxENjRFi+Xa9RqcnEpISMnc4Xc6HIpq9R3sQlf/VTl2lzwMZBx3fKZzePN30AUCnU8/W1nTWYEF/RcLMILmq4VmXqu5trSWHw8mn1SrLSzSXnkhKiit13Hkvbmps8DwwLFytdx8bFTiIHILw4RiTKwjyijxxAzi6Ur25ZJGAtOdN4GkgAd4yXEya0PsYOCYAm3D7gxPL30VqZoq7cqQM/AuO4z/q+CSp8eCct0mhlAsr0pXR1Pg+R7Ie5qD3eSzUAJlyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dM6YrvfrNO2WPej6Sqcbt0LJzkKM780CYMg66d2Ab7E=;
 b=a66sz3HcFE+hePWyIIVu8BwugZKwM0cp5bglvyvcF0EusYu/ADTLMicbBxwwjgX6XAM29yY0UtJyC79g3552PcK7kltOpEXaEcmdEA90F3G0BjY0+qJpuI44bULyZz2ziPteNyceIXrplfHSHayJNsWX1OZCZTK7WHfVfMdLBXE=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CH3PR10MB7394.namprd10.prod.outlook.com (2603:10b6:610:149::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 26 Jun
 2025 12:58:45 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%7]) with mapi id 15.20.8880.021; Thu, 26 Jun 2025
 12:58:43 +0000
Message-ID: <ce04ba52-9201-4594-9079-64000e8dc797@oracle.com>
Date: Thu, 26 Jun 2025 08:58:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 01/10] netlink: specs: nfsd: replace underscores with
 dashes in names
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
        donald.hunter@gmail.com
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, horms@kernel.org, jlayton@kernel.org,
        lorenzo@kernel.org
References: <20250624211002.3475021-1-kuba@kernel.org>
 <20250624211002.3475021-2-kuba@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250624211002.3475021-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:610:b0::9) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CH3PR10MB7394:EE_
X-MS-Office365-Filtering-Correlation-Id: e0db81bb-0204-427e-306d-08ddb4b12de0
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TVlsaG1RWU01aFZsR0VjZTd0ckVYSFI4WTlNdmM3Q1JVME1GTFZOblBoeXBI?=
 =?utf-8?B?Z1oyakRsSWx1eDk1R3FKZ0phQUhOZkowOFB0dTVTa2doSnBtRTNjei90YUhj?=
 =?utf-8?B?dTBMMTF4emptYng1OTRBWjlpRUtHaHExcTVuL1Fkd21taWUvdjdnVkMrWFhW?=
 =?utf-8?B?cHd6M2dEZnBvMkZSWEFFOUFLSXJ2QUJqMnh0SHBoZnJZSEQ5T0VuRGlxcjJy?=
 =?utf-8?B?c3NLYXBMU3dqYkhmeTkzVkpxaEtnTjNwcW9hQWRmSXNDYk80aEtOc1lPWkIv?=
 =?utf-8?B?Nzl0cHhFTFlHa1RjejFLaWswUDVDUDJnOExVSnhYckpnVXhKdk5Xc3pJQUI3?=
 =?utf-8?B?VFhWTHZLVDk1WmVtbjNrOHNtTnJnbFpHTloxMktZUDRGWFkzRldmWEdpd1J1?=
 =?utf-8?B?MlJmZnljdCtKU1V2OStyMWJFZ1BSZXhmVC9BVEdYcVVURjBkcU91UlJvK0Uy?=
 =?utf-8?B?K0UzQUtYbGhIclUvZytaUFZkZWoreEppRm1rNVlVSWJuZ1R3YTllNmV3RkVX?=
 =?utf-8?B?Vy8xSWQ1SnFvc2NKSkdENlNYVkVFcjJkKythdXRzcXFDZ1Y3YUg1bzcwUjVG?=
 =?utf-8?B?VUJhOFE5TS9VRnZWZTAxc3FHRC9vWWdTOGhqTVB0ZzhCUk1yUDFVTktVcUV2?=
 =?utf-8?B?TzhTMStnZlV0UElNYTRIUEhwVFlMcGpLVmpldE95UzAzczE3Z2ZSUjdBbUQx?=
 =?utf-8?B?SHlGekdVWHhLRGt6NlAzcFJKdSs1R2RKeHNjWlByYklnU0tsRWFXQjhiTmdN?=
 =?utf-8?B?WnpWSlN2c2Z0RmpyVVpidzVuUGlxOEJXdnBCK2JYb2M2VnZmcVgwVlhQUWpu?=
 =?utf-8?B?d0Q5c0t3Wm1FQ3FMM0JjMjRobDYxSXpYN3lNaTA1cG1ha1FrQ1gydkdKRS9O?=
 =?utf-8?B?SmxLYjR4TFZkdk5hd21zdnFROWhaZzd4SUpySlY4dTdWVytSbnp3enlSUlZT?=
 =?utf-8?B?TGtLSU5KSlY5RDVGWnZUT25BWlRtaXQ4RzJPMVhnRDJLbkVEY1IrN3ozSEpT?=
 =?utf-8?B?VERPWDNKOVJDWDhVaGx0a2ZBcW5PVmZ1VHVEYnVQSllwSkJnU05iWUJQcGQx?=
 =?utf-8?B?UEQ0d3RzUDk2bnMySmZWeWNsRjByV1Vzb2FkTllaUUtkRzVINDI2L3E3Q3kx?=
 =?utf-8?B?a2RMUXdHZ2lpNU5KTFFSdWJWem9CYTJaMm40QWhWQ0RJeGJUdmx6Tk1pa0pQ?=
 =?utf-8?B?d2J6TmZpSVdweG5NSkZkc1gzZTJQZTlTK1VacXZwbEk0YVpOajFSK2dvK1lJ?=
 =?utf-8?B?ejBMankxTTdkSlc5L0xJZ2JlVmtvY2lzNTBJWVNkZU9yRGxKYW9GSTg5ZTFY?=
 =?utf-8?B?b2tKVEhMU2RuWnBPWlpEVmJ2S2ZyRUVGQWhjM1hUTTVKNDl6UEk4U050WC9E?=
 =?utf-8?B?UlZLNnhQbE5xb01OMlNhNjlta3pjVUpaYWpEWHZBaXVmdndIdkw5RnFtMUcr?=
 =?utf-8?B?M0dSOTQwWHJZTUhKUG9ENWhvamI1eTZvTTBodytvYkpYUU9DbUhZR3lkT2k4?=
 =?utf-8?B?NHNQOWJ5YWx0bE9yV1J5bytjUitHOUxHRHNkL1VGNi8xU3JCUmFVZGtwT0VM?=
 =?utf-8?B?bk9qZWovRU9xWGttQzdxS3JpUTI5TjEvZFBvT29PeUF2ZEdMUWhVNzFxczFP?=
 =?utf-8?B?d2o1Y3ZkLythM1diVUQxVGdiUG4rZXZBL0xjQlVRaHBHbEIrMER2alQyZDc3?=
 =?utf-8?B?SGt4Y2lHczI0NWVDNUZ3bW90MVVDemtIMFl3VUdIeVc4ckpvTVdJMGV1OHJs?=
 =?utf-8?B?dFI4Ui9HRDdWYUJVRm9uLzhCRjkybHJqa0V2ektPTGtmU2dTdEtyUmx5akg5?=
 =?utf-8?B?eGFOZk53QWlQTE9pSWF1Z1NhTGZIYVljWHRMeG4vRm1LelBLcnhQak91aEt1?=
 =?utf-8?B?cC9lWThHY3J4bERvODZyOUswTkRRVFRlYkkwUU11MFdzeHNocW9WbHhmVHZR?=
 =?utf-8?Q?dXC//kkAcrA=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YTF1eFVHUndyNU0xeU9VWG9IRW5UMVZocHRKUERybUxSdmFiRDBlei9INTd6?=
 =?utf-8?B?SzJRY3poUDNRWGRMMkM2UjJlRERIY0NqdkxuOWZka2laVFhQTlpRUWFaSDl4?=
 =?utf-8?B?RXJHL285UWxXeUorWnZ0N3F0RFB5TS9GZ2RXQUtmRnBiMjNGSVF6R3BZZUdn?=
 =?utf-8?B?eEF6MGVTV1NkMUN6amg1bHpSMmRuTUVycEU1b3F0WkxTWUtCVFhaWUdHTmxZ?=
 =?utf-8?B?TWd3MmJsVkZQWVlpZHNYK21Sb0UwMWZNMERpd1J6QzFpamY1MnBVK1ZtS1VW?=
 =?utf-8?B?T2o1RkxRMmdaSEI1dHJEaDVUR2FhSm5icnJYSVdZbXdLUU9ETWl1Q1BUSUZo?=
 =?utf-8?B?ZnRtQUkycVRzZG84cHd3TDNZdVZBb3VlangzZTdsNTF5YmtxSlVoU09Pc0pG?=
 =?utf-8?B?WUNJNXJFT1FUQ055ZUJ4aVlML2cvWDRESmRrbTYwSEFTdEZPWEUyamFBY0tW?=
 =?utf-8?B?QWZEZGx6NWVJV2Z6aGdiU1VNMEh6dnRTVWRKUHhSREJIRmczbWwrQlNqR2hK?=
 =?utf-8?B?Rm0xN0hFUlVkMTNDeFdwSmdpWmFWSk1pb205K29ZZWppc1RFNzhqUU9TZTM3?=
 =?utf-8?B?NGpWQlBMajlwUnd3RjhzR2JqbTFBbW4wNXdVOGJjcFJHTTVqeWwxaFlJSEYw?=
 =?utf-8?B?NFRKUVZILy9qQ0ozTTVMQ3BnOFFFbzNuUFUxWjc4MlAzTmY0SDhZZXRibUlT?=
 =?utf-8?B?L01tQWZ5U3ZkUjBNbWxEcDRDa1psQUZqMlVUVHkvRCtFR2xRZng5UDNTbWNU?=
 =?utf-8?B?WnFxRFRmWlE1bjB6aVpKaTRVb0RlOHVQSnJGeDJvZjVCQTVtOG9jOUtSNTNE?=
 =?utf-8?B?cExEQ1JZdTdCYnBDcUQ5UkVZd2FlaHB1UVNWOHJkT1lNVWlNS2pCUzhYUC8z?=
 =?utf-8?B?a3V2YUZiQ0xXNVpVNjMrdnY2TmU5a1hhV1RoVC9HOW1wTktyL0U0QVpKL2dB?=
 =?utf-8?B?TG9jYVlZRFhwREZQK1ppTG1kTlRYMGp5aDV1aW53NHQ1SE5ZdlUyQnNZU0Jh?=
 =?utf-8?B?VTJ3TUpCTTRHaDhCbzJwdXdxcEc2VWhVeWdjOGxoYWVvTUZiQm9EUGFpQm03?=
 =?utf-8?B?a0FnaHM4ZjB6VGlyN3RtQ1gvTnhDL0tZWDg2OXQyR3JOT2wzeXJpb3QrZjd4?=
 =?utf-8?B?N09pQlJRRmdzV1IwRytlS1Q5MTNvRjE2eHliMm5KcHBoc050SlEvQTdIM3RN?=
 =?utf-8?B?V3FrVjdDM3A3eVNEWEtmWEF4bHNKTmVrREtNVWRaYmVUaWpWSkZxSVppOXhh?=
 =?utf-8?B?RjVWbVJvWU91bk01dEVsSTRPdTBoU1RZcTRMd3BDRDNoZm8rUFFGWXYzWDhR?=
 =?utf-8?B?ZWpkaXJzZHVKVGFFMUxoSDIwNk91dzRjTkNXaHg0NXZpM21UNVM4Ukp6ejNL?=
 =?utf-8?B?TlJxbjdnTVlIcmEydVB5SnlqcS9BeHp2Qmw4VmZzVVpqck9iQkF4dyticVEw?=
 =?utf-8?B?ak9ONWkyeUFKVEl5eitLWnU2cC9WSmJkVlZVS2dTN1MrUTFjd2xhakRrYUV0?=
 =?utf-8?B?ZTlteTFHZktmWFh6ZWJoL0U0OExvclB0cjhZaE9ERE4zTXB3WWNzRnR4ZGND?=
 =?utf-8?B?bHFRcG4xQnpzcmp4OTNPV0xRTFVZMUtCVDd6SmJTY3ZGM2tOVzF0WitrRUtm?=
 =?utf-8?B?aEhWUDVUSjR6eDVtUVM4MU14NWwvczNRRnVDbm5LRitlbmdDM201cWc1dGlu?=
 =?utf-8?B?OGhKTjNHNVVMTldpdDhvcFlXWFRiZG1ITEVOMWoxMnpyNCtkVzBtOENQeDFV?=
 =?utf-8?B?ZkxZYUhDZnJlNEJIMU9xOVFJOGU2TEZlbUM0M00zb0o1WEwzalRQVzIvSWxu?=
 =?utf-8?B?K2Nnck44bmd2L0hZb2t3TUNrMWQ4Vi8wRDN6WlFxTExJcUFPS00zaDZ4RWtE?=
 =?utf-8?B?QTBXTi84dEQ3VHBybHk1TGpTaFV6cURETzNBTEp4UWdPY01tUzJlaGJGaG11?=
 =?utf-8?B?azcwY1NXMFp2L1grdTRRQUcxNzNSaUlXQW1WbUp1L0N6YVJOcUM5ODBIbDdN?=
 =?utf-8?B?Sm5xYUwyNG5OanlFYWlXeFJoZ25JdThYaU80RHBnYXNtc0lYdnlWT3dTSlhl?=
 =?utf-8?B?ell5cDMzS2JzdkFaaTYxS3AzRE5mS01ncm40Ky8wV2J4S0NlU050WS8xUHFq?=
 =?utf-8?Q?y8TT7p8+sYQxFgqUZwdtYynB4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	694cXMxazv1P/ZeRj/tv9QICiIpwwCPPgcUD9z1r9wd1r/QbaVoiRp43pmD45iq+U1zTAlkQhkE54jZD7EnMGyCg/sfSV1oFNKyvUrGR186wuMf1uSB+lRBr0kqcPrP2Bx3h5+dmCjonK6DHZfVLR/4+qbn3lYcByc388knenZMK/D8wA2MDLzdh4/ZllNClfPCoSmhRgBz7RwrEYrWUoKyaLM9XslKQsG17XUMwASsriSqNF3rKXaCkK3fNdrLrOsNpuDegP4xmj2tjdVGFxzJDcw+MxAW5BiHgJj5X6DagwefcpAVxWkW4X+WN+1u28FjCkQT7v+F8hgB+bWFXAcYms4JPpZ04A2jIZTA5MV4D72gpxDxd+kvSucAYFmjVr89RZX+0kip5nfhp+WGBes9MBwNhpnCLM/myiZhowu9VJ4Xlh0tQdYOdN289NUpp7xmQCQdLFHD2oGVYcYtuc03YeMoDWZEDGNBbmvbmqgxtO1i0lEVkHtJz2GYwNSAbVdgQellc7Vt5e6WNjqj2IuuetHl7nyfmQFgNZ+PkFBzaAsGOBzhaOjJdecmSOSpVb/C30Rmzdxzs5h/HY76cisylOnNSaBodLZ78U8I/upI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0db81bb-0204-427e-306d-08ddb4b12de0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 12:58:43.1628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2hEeWxqy+qyhLe7gT5hBhAplkdulstYAOupULXi7BCBifsrYHaSU7msFgNKt6lLbpPx30FED6RP9hpIXHq51Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506260109
X-Proofpoint-GUID: T1DZ3NI6PCdwzeNjFim8vFIlN3Dn7VeW
X-Proofpoint-ORIG-GUID: T1DZ3NI6PCdwzeNjFim8vFIlN3Dn7VeW
X-Authority-Analysis: v=2.4 cv=cpebk04i c=1 sm=1 tr=0 ts=685d440a b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=VByVxmysoRhPh_IJtNgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDEwOSBTYWx0ZWRfX0zewbbJtrhzJ t5Lbdj5pjSUZAKPvmzgOrgzEWpG2SxadvrwttF/SJN6PKwVKnKzH8aVbFqDCxIubIaiApwybhhK +FbyCTeGNTqpjd5YqHLLFAJ3nO8I2dAXzm+h868fQff/uA9ZxpLdaQVmr3V5GFriVKX33hVwEfN
 CipIxaJ5isNI0I9zbR8cD44AuT5w0iGFgqeWF/SpTOC84m2VVbcrsExvLv4qMxnWu2KLectKcAX /anAS72okDvs3AxSv4qrnHGUwnT7EPwC2IWdXUVgoo14CL41llxdWO9IBhrySxPQdqnnpKsiwH2 VKl9cPjjTpdbOKw4Tr9kMmhfqCplAlx0wP0HFIToWq+/ntixt5jRox14r6LEAcDfwXZOQb4M8g+
 Pfp6O81tggNXvFaU20/3v3W+qbEBcnDitWr/qeQPR7AQCW/E/gS4elvVO9wx4bOyJ5Zuxk83

On 6/24/25 5:09 PM, Jakub Kicinski wrote:
> We're trying to add a strict regexp for the name format in the spec.
> Underscores will not be allowed, dashes should be used instead.
> This makes no difference to C (codegen, if used, replaces special
> chars in names) but it gives more uniform naming in Python.
> 
> Fixes: 13727f85b49b ("NFSD: introduce netlink stubs")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: chuck.lever@oracle.com
> CC: jlayton@kernel.org
> CC: lorenzo@kernel.org
> ---
>  Documentation/netlink/specs/nfsd.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
> index c87658114852..8d1a3c01708f 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -27,7 +27,7 @@ doc: NFSD configuration over generic netlink.
>          name: proc
>          type: u32
>        -
> -        name: service_time
> +        name: service-time
>          type: s64
>        -
>          name: pad
> @@ -139,7 +139,7 @@ doc: NFSD configuration over generic netlink.
>              - prog
>              - version
>              - proc
> -            - service_time
> +            - service-time
>              - saddr4
>              - daddr4
>              - saddr6

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

