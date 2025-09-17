Return-Path: <netdev+bounces-224179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FC7B81BC9
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 22:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A87587291
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 20:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE7D2AD3E;
	Wed, 17 Sep 2025 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nqiv2zP4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b2y6GRL4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE914690;
	Wed, 17 Sep 2025 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140323; cv=fail; b=q5TkiNCGECDniA/7MEVlcTcFfUGIBY1TwDYPpK1JjjCW8bbWu+PKhGn7vZCNhfPF9hrY760ps4LW5hz6tSe3zzB280GeD6iyBlhbjOGtjKKklwC2J76W3ifmZjJRY3HhkwSXxqlLmKb0OyUF6WV7hYWbnJYU9bC7QLUCyHRvrP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140323; c=relaxed/simple;
	bh=kwd/n4C9h8BjXJZARXeDcAwrw5yjNaeniv2uhwa86bs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jga/OSdegPxldZBcD+3yipv29rCLgOW2/yuGPHpd+VA+J4LoTgti/jroOWhl1e774nEjMmgUb2oxq/rai3mS/TWdKlnkak14goxReqjmUmnXHsJTIcsScCVQrk+WcBbpB5AQSFWQ7yN48KEo9bP1Jb2HhLbeOw620QnV2O39680=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Nqiv2zP4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b2y6GRL4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIV6J014271;
	Wed, 17 Sep 2025 20:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Zjf/D6fF6H2J8ZrvPE3XT9U9VectP0FzKRnvPE34D90=; b=
	Nqiv2zP4kSLnh7ijtYT2/8YmLazD43LNkIFvnA1zxoWaDLsx7hG0u4MNG8Gq6txg
	tVqRzECAPHSs959xwVOEMhKUOuxepKjmxalXrloQktuU61CKadJvdwn3tk4pd24J
	TDYgg7UWrNS1BiuKGpXYJa+Mo3ZgUd5VPNHc6WLMEY7hMECH2uft0rZij15pohyb
	0kL8rWG4b/A72t4lkMn27ZJUpHw82LCSpQa4iokRazgchzkufp4kU8tCAgXd6RHD
	FcbzguLeLiF11XmIqnqGzMGNtPn9LfEmt4avZoJibzq0uLvUV4aDb+UpGyHO0bfp
	r37nibDULFe0kdR4KGKcbQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0ka69u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 20:18:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HJNAvh001468;
	Wed, 17 Sep 2025 20:18:26 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2efuyv-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 20:18:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uopdLoj9jnxTiTqs2P9CsuEeMANApT3nd40LDkzB6WqSI8bq/jryEKa6i+9rSL5GkYCkKpDmkLBxuUs/xJwQAB0r5PAFx18pYpoHvwCO1PLPzLJzsamFCzYaTLTpWFOQGIF8IQ5ye3X1lmmWHQevtsra4VZdAxvt/UQfFujhHug7Maz3K14B0wBTfiHeYLSUQPc6BHvEB3zhF6D2IyOdrFx6eZmJI0Y+msPfahv/r58kBT/N4lgHxc0VIxrZUujUlUA/tPUd7YusiTPaIgImK0HGmTtadhN5tR2xMJ7JKPkwTaNabSAVkac/UH70/m+pXhjonGFQUJH9HfwF/7uYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zjf/D6fF6H2J8ZrvPE3XT9U9VectP0FzKRnvPE34D90=;
 b=JET5Pg0rYIqCPL6zYdBKHIuh2V3Qw6Uu/J66dDzrkekins31gqv+GDYS921zXiUrG5b239X1WxBdTKRayLnDqeUvLgoiX/lK9CQY8ExYsxoEG13qcstSC5rM5FtZy3mS74vGwNKucGCR9K4iDZm4FDnEjG3lVt5tyqHKR9ZHjlH6EVIYONijByw8oV8hOmBSOZkS27m+3rDVOhSLiku4O/Rc+Xn9gjwpTcMuu/benNhKM2CN+CQih3UXFEn+0f/HXC7TPCDrVwVEsI8g/ndRxMC4GznVUhr2MYQjGGoPP3r863DQoqMX1GfP+FrkYjV9JPdiGTaE4T/O5CTiWwEu0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zjf/D6fF6H2J8ZrvPE3XT9U9VectP0FzKRnvPE34D90=;
 b=b2y6GRL4JW9N7NFAvE2iGrHZNaoeAmzIsBqsALro6RrjgZbnbp/kEOS6rfkHH7+Y17E3yIsk2ny+qCSGaVTLvT0Fp1UfSULbTDU1RcsmfeQGzI33ONTalU6WjHDUMXt9Go6OhZU9LwxNHoq7zHOgVH800jpB0CpAMtKR+9pPIzM=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SA6PR10MB8158.namprd10.prod.outlook.com (2603:10b6:806:442::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 20:14:17 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 20:14:16 +0000
Message-ID: <2d51927d-98b6-4bc6-92ca-0dcfef0e31f1@oracle.com>
Date: Thu, 18 Sep 2025 01:44:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [v7, net-next 08/10] bng_en: Register rings with the
 firmware
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
        vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
        Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
 <20250911193505.24068-9-bhargava.marreddy@broadcom.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250911193505.24068-9-bhargava.marreddy@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0014.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::27) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SA6PR10MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c1f018-3690-448b-405f-08ddf626c721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHJBZEdjZGJJMkc0MVYxNThVQkVwd1FRZ0RzWXlEdm43cjVsaVplZmMxR2FP?=
 =?utf-8?B?YkdHWUp6MmhuNjNUSmJMQ1lyWUhXbG9Ybzg0Y1Nqam9EOU85cmUvUytOdjhS?=
 =?utf-8?B?dzdkOE95QStuMUZXaXVCSjN5eFR3OUpEY05yaDRTbTBKMGhYbnltb3JXdElD?=
 =?utf-8?B?YSt6OVNXNjFXQ0RqUmZvT3JMYUNpTHZOalh5d3BxbW5EVFpXb2VzOWYyQTVP?=
 =?utf-8?B?a3JuNHdFN3RMUCtXMHE0OVcxV1FuOVh6ZFNVZXN0ME9nc1dWMjliRWFtbE55?=
 =?utf-8?B?QXdtVXRJYk9uZDhWSTlxN0k0T2tiWnJmdklFNDhMeUxqVkMxN2creSt1MXp6?=
 =?utf-8?B?aEVITnVLd3BFVWZyYXY2MDR0Sm5mNmJiYnR6cTNkd29QWGpZdnFxcnpycHBS?=
 =?utf-8?B?WE1qWHJ4RGduQjFMQ1BzZHZkUmdRSWliUk9icjhwVlFGMWN6YzN4UzUzZnFs?=
 =?utf-8?B?elVJaEJodGM0Z1g2dHFtd2l0UEdYRk9xL2p1RStrZ0crSTduejJjVGlUK1NW?=
 =?utf-8?B?RTNGWWE0bGdvUFprNFVIcjAyNmIyVzFNUUhUaTFHQ2ZkMjk3cWUvV1pOWlND?=
 =?utf-8?B?YTRiOUlEVEF6enVHS1NGNEpydndUTm9aaU1uWXpWQUxDWnVMdlNWOTQvMVpl?=
 =?utf-8?B?RjNkNFkvSU1RNXFWUllQM1lNNUI5WlVBSHVyMHJtWTdBZEZ0b0paYzF2Sm5Z?=
 =?utf-8?B?dmxWNFcxNWFZQUZoelZoOFY3bDBVTXFMazlLM2Zsd3ZJTUFiSk8zby9ZK1Rw?=
 =?utf-8?B?cXhnM2lCNlFBblgvU01qZFRnS1dXeXIzRllJeDhaYVFoRjJCQU9lRy9jWjdr?=
 =?utf-8?B?aFQ5T0hGdlpIVFNIVVY1dk9GT1BxNzlxSXpVVEVGRVpwMEUzZmZkaG9nSmZs?=
 =?utf-8?B?MG9Rck9FeVhmNkdQZkpVYTl0bDdINDBVRDA3clhNK0FKV2tZaFVkVWlET08w?=
 =?utf-8?B?RkhWWnA2d0ZMci9iVU5XdFkxbHg2N3FsWUQxMTQ4Z0JMMmd1NVVQYWxPR2xu?=
 =?utf-8?B?OEdZOGd0ZEwwKzBvTGd6YVRINGdhOENUNkVMSlVHdUJjRitRNGxwK3RMYjhh?=
 =?utf-8?B?eHNYKzViYzV4alpuOHZYNzlWY2djaVNsbytUUWZVK0Z6TTlCclhrby8vdGxo?=
 =?utf-8?B?UE9XRFBITjlsMEppaUpzWmZkUHpXUmlxdXY0M2VkNUJsZUxpQXhzZTA2aklN?=
 =?utf-8?B?amNYUjlkd3ZEcmVrRHNqME5QeWllOHUxeTRrWU9JOTFodkNkZFlnL3c2cW54?=
 =?utf-8?B?T1NkNS9VNzJ2VWloOWpBaXRTdHRnTGJYKzJtakRXSm15QUQxSXM2cXB2UU55?=
 =?utf-8?B?c2xWamwxaTVGei9ZbWtkQ01TMjJBeHlieE9OOE1HQnJCUGRmQitFTjZEVnQv?=
 =?utf-8?B?QmZJR3FyMXB2WFdwMW1JNitqbUQ3cHJYKzdiakFOdlRMbXN5QXB2WGNQcXlx?=
 =?utf-8?B?V2VWNWx0eTJRU0lxdGRVc0VKMDRVMGpQYVVoR2wvQTgrcmZmVXhVeXp5bjVa?=
 =?utf-8?B?Q0pLYTRvSVpoWng3bXNXbDE4dG9ML1FhejZQQjBvQWE5R0h3MjBBVjJXZHlS?=
 =?utf-8?B?TVBEbmx4Z0hwUThZQWJ6aU90aEN6amEvTGlsaG9xN0haY0xXKzdmOHBQbk41?=
 =?utf-8?B?S1RibkIyenpIV0I3b1NSdjJhbzZ4Z2VSaFhQR1g3QzkxRWp2bEhudVczTVVx?=
 =?utf-8?B?RnZWVHNCT2lyTmZDOCtKMkJsSm01ZlpINUl4a1Z6RXc3eEVsZTZYODkvME1k?=
 =?utf-8?B?TnlzQnkvdi9HUmdPUVUxeFZ1MjlRMXpHbW5NNjFkQTBMVDZQZ0p3Ri90VEFB?=
 =?utf-8?B?RDh2QnBnQnRGcjBrZlBCQVZyZDd1bmZBK1krR3BET3JveWlXcVNkMnB2SkRv?=
 =?utf-8?B?Y0dFZDF0cFBSQy84cXJaMENpUHcwWGZad2lqQTIrZnhweHdFWTJmTFIxM2xD?=
 =?utf-8?Q?/t4sLZYplo4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWtId2dseG5sN2dqNGFjMStjVkVCWkhUNFl2TGFwY1pwd0w4VUZ0SjZxZUpP?=
 =?utf-8?B?K00vNVFmWGhhRVRmRGhYeWR5bytoQndibU01RHRiZ3huQVdwbG1xZ2pVeDl0?=
 =?utf-8?B?eEc1c2FReDVBWE12Qjd2S3cxYVkrRC9JUVZIM0xOMDY3K2FldSsyeDlQZ0wy?=
 =?utf-8?B?NGpmdmdPUXd5Q3pXMXNvUWdUTHlrRUozUEM2QW1LMU8xblZzS2NabGVyNFFv?=
 =?utf-8?B?aVFFcmhmcEovbnNEVk53ZE9OaWJGYmppSVl3dXQ4Nlgvd1hqL1dJdXdQZGo5?=
 =?utf-8?B?dnlOOWhGOTNUMlJRNUJlcDZCWDJMaldxdExCZ0dlUUtRbjFqMXgzY21BMWRB?=
 =?utf-8?B?Q2l1cVNKM2VSU1NDS01tUFpBUWtOenY1bENmRTdZVExJblI1QzlSTTZpdm9X?=
 =?utf-8?B?YVA1dDkxampoNXZScVJ5bHNFclVydUxTMExjZDAxc0ljNXBMNEZCaWE5WWZR?=
 =?utf-8?B?bE9ibEVGWXYwdjVuaEViZUJKR0p6VGRaR2ZjclFCYjBnUzh6cEx6bjFEeitM?=
 =?utf-8?B?TThrRFdTWmMzTTNRUXdzT0htam1oSVh1dHkzU3NsUEVTKzNUeEVkVWlWWG4z?=
 =?utf-8?B?dG9TNDZsTkxzdklRb1IvTVUyd3hpcUhvd0E5MUI3SEo2aDJzdFVRb01pWEhY?=
 =?utf-8?B?SXJjY3RmeGIzaEhCZW5MQlNQVm1DRGdQbDNPTDBNaG5NN3VVakNhTzhRVHhW?=
 =?utf-8?B?VVN5R093M2FvM3JVODVVMXBYMGRGcDBTcHNMUGgwc0VqQldtT1FuSE90TkN0?=
 =?utf-8?B?dDVtRzAwMXlicjViSFY5RlN6d0d2RlAzYmJhdUY1L1FhRGJQS2QyNTlWSjVy?=
 =?utf-8?B?WTUxVTlOdXlZQU1wY01CMVlIYjcrN1V5cHdNZlpaMVlabmdWd1RMT2dFK1or?=
 =?utf-8?B?OU5MZ1BUQ3N3TFZDVzNxVnBPSkd6TmFGSUI2T21FRDZCVThKdHduUDlTQXRW?=
 =?utf-8?B?SmRhOWZLK2plb0ZncDY5R0Y0MDZ2aGlnNWF6cHlWVnE0aGVKMlRXeU1pKzZx?=
 =?utf-8?B?My82ZlZ4bk93eGpGRms4QkVhT0I3OWVTNElGZ2gxMUQ0c0lheTc2eURPWjVX?=
 =?utf-8?B?dGNMa1A1aXIzbWpRVG9QMk03R2huN3d3cjZkTVBHdkV1OFJKRTJXRzNReHlj?=
 =?utf-8?B?c0VFMEZvWHd3cjNVV2tKSWwvbmRDS0NnVjlYNEJXUlJrYllFVjNESmY2VFVs?=
 =?utf-8?B?blNXTnhaamdRYU92MlRUS3IxY1U4bytQMnN5aDUwTWhQL1gzbU12WlMwZHpD?=
 =?utf-8?B?ZTI3aXlhWGxmbG5STmpJYXoyZVNCc2MwS0VQYkxRTkVQUk8rTkxJdVR4VWpL?=
 =?utf-8?B?Qm8yNndTZlhkc3pqd2lSa2tUYXVOVVpjVStCaDZLWEJIRXl5cVhGOE1aUEQy?=
 =?utf-8?B?L2NNTkRzSjkxVStIT3dOS3VFUjlSM1JaYmRuS2J2bGJqeVFka2R5ZE5tTm1G?=
 =?utf-8?B?Sk94VFp2UkpxWlJzdW1sRkxFdkY1L2NmbUdUMkt4VXlPSU9rK0pKYmtFcmQ1?=
 =?utf-8?B?Q1Z5cXRJdVE1ZytWcDdwVFBhdG9ZemFWVGxwODI5aXlOMi9UVmZPVGt0QzRm?=
 =?utf-8?B?K21KQmFLMUdRL1pqdDlXTmVrclBMSFNQSEhaSExaRGtjdHVrbnFKZ3JpVU1u?=
 =?utf-8?B?WDYwb1VibU50RnV3bTRCK1ZPNW5TMlJjQnVXVnlDMGlkRXA2Zi9LS3hUVWxS?=
 =?utf-8?B?ZCtpMVJ3VGpJcWcya3VkQ2R5M1BWQnpCcXJaV0pHd1NxOHFjL1RaenBTU29W?=
 =?utf-8?B?bnJUTnV6OE03YmVDelFnVkpzaWlaSUQrMTVZYUF2SGs4dk50eDBNWmwrRjJC?=
 =?utf-8?B?amV0SzJNRGMxOUJQYS9WZXdpZ2lZalUvY3JhOFY5elN0VFJTN0szS3B6SS9M?=
 =?utf-8?B?QlBDdnFjaGN2ZmZYSmx3V1VHQ2J0U3R5dHVqZkRoVytMekFZRWtidmZDd1hC?=
 =?utf-8?B?V1FJa1UzV2NYekZLMEYvVjE1elA4NXhYWlBXUVVMVFY2N0ZROXdLbnZtVkFi?=
 =?utf-8?B?ZzY0UnlTNUphT0JWTE1GanNLMG54WHF3U0YwUHNjeEtQeU5sRGhwait6ZU1P?=
 =?utf-8?B?eDliTEZGQ2cwazFRMWxhamNiQURqaHlxbklUSTVFYlYzWmFOWUNGUUdaVHlB?=
 =?utf-8?B?TVZ2TDBmRXBoYXRVNXNhUEhub3JNNFl2UTErbEFQQWtqeGlVUDIycVQvWks0?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MwBXndqbLJZbtg9NqhORxCWAxOmnZZu6aYAFCXHB1WVMiWm+h+uJs73sFmW7ssp8d6nwK5YYTlwVc+lGIx4K6U8tdZEJJPYK5EM7EfXaqZUlrE8dUqE5qyyiAa5+MRkwIm7s7jIjExMx1TWRGJAiAwfE+zGNEvfWo5SdnY6hkSlkxIBvA1xMyqdV4foHQKiGT8+LiB+Y5ZKdg/XqUShpDDtNXM11omilvR5Bp+19+dzNiS6Eba0AFsEYRgm3V2NPy/+Mzl+meJvsSK/98qJn6D5USo9+OlpPgDd4M4zYspcuokERrIycGZAimM6+s+66Z6afkvKtXeN1tFs5PV8vKxIwUPhL2c7uDssMI2GA77qJn29X+I5a1I9Jf6ZZfVj5aC22LWLM/MPLXXfYjjB6YbLrgl6n2hht3oIhsMZdTn1aZ821vmZqs3Dz6sVXl7WZ0Ymfsx0Y08wK2kocF0izHMacGvTrYIzvT/51E+YmZdSN0/+KXArlm69M8CCRyfG3MO1oZbw8Nhflcy1CoPxbdCL2CIAi9x/uxZis9AjKVz8pAWlAAn9jph/xqvvuzHNM9d3Kpl9tVilwViEakt+U1UzACoVjbg1umk/k9ew4W2M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c1f018-3690-448b-405f-08ddf626c721
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 20:14:16.8434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydMHMaBh3VjCeQnmCIBUodTlktbkysY4LGf6wtgevVDzDFdKFGorMatgwyZgUk6dhe8rz51DUX+TcgDE+vqZ5gkq2tHISQlYVWn2mqAz2Eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509170198
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cb1793 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=L4yLzXqvQPGEcLfg6CwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KxKbwiuI0E-29Iv6qliPnrg6bYLbC568
X-Proofpoint-ORIG-GUID: KxKbwiuI0E-29Iv6qliPnrg6bYLbC568
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfX5TXIfkkycBIm
 xC1vzILmWOZtZQqqzX+bbHtA2z27J+WtrWs3GrSGC6POiohBMC0pTWQmsSyftaVi0Fr2ZYJ3fTc
 KzcRewUmZGInMhozwnLfwtcG9i36bjOggbrd2Ty8tW65JXu8jGbbwcexsc90WEuZSMSCY8fbngv
 QhUdHGldb6BzeTno/9ZXexvc3a9Aw21W6N1XUJZ7Fdcx7Hj3Xm/4pu8mQcBeZskRyLZZ/Q8VJE4
 iTWlwHNL+y5RDTSp+yyxZdMoEgLbcLPBWtKqp4q/iyAshdeYlg8OPH9IPmt8KE0336jJhToISO5
 wmNqurAr6Hy5eHQH7/PiqQyl/Ro/PVMvFGX12VJVUJXORVd7HitASKyWpFFmpqO8vy2jAosW8Ue
 UiI2+YZX



On 9/12/2025 1:05 AM, Bhargava Marreddy wrote:
> +int hwrm_ring_free_send_msg(struct bnge_net *bn,
> +			    struct bnge_ring_struct *ring,
> +			    u32 ring_type, int cmpl_ring_id)
> +{
> +	struct hwrm_ring_free_input *req;
> +	struct bnge_dev *bd = bn->bd;
> +	int rc;
> +
> +	rc = bnge_hwrm_req_init(bd, req, HWRM_RING_FREE);
> +	if (rc)
> +		goto exit;
> +
> +	req->cmpl_ring = cpu_to_le16(cmpl_ring_id);
> +	req->ring_type = ring_type;

req->ring_type is a u8, but u32 ring_type uses here
since the enums (0x0, ->0x5) fit in 8 bits
That is not a mismatch but it is misleading.
it can use u8 ?

> +	req->ring_id = cpu_to_le16(ring->fw_ring_id);
> +
> +	bnge_hwrm_req_hold(bd, req);
> +	rc = bnge_hwrm_req_send(bd, req);
> +	bnge_hwrm_req_drop(bd, req);
> +exit:
> +	if (rc) {
> +		netdev_err(bd->netdev, "hwrm_ring_free type %d failed. rc:%d\n", ring_type, rc);
> +		return -EIO;
> +	}
> +	return 0;
> +}


Thanks,
Alok

