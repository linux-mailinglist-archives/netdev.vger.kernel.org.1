Return-Path: <netdev+bounces-236490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42944C3D367
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 20:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83103A3A2B
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 19:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFF62580F9;
	Thu,  6 Nov 2025 19:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AuHy1dbU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C7mYTtZM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8333613A3F7;
	Thu,  6 Nov 2025 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762456554; cv=fail; b=VeOR0qIUNCMMtnWrT1s+wKlMuzPkRCp1VyFNr6i0VDdV9fVK4YuAnzISa33akcAdt/LdMVis3JtOuizoBTm7qnD5DRTOrZgXNMAre7mI3kZvM66DbcRQ47GtdZFmeC7qeaBMfFbq7voFVkl/CvWTtMr1yBasf5bproi4rGDtK9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762456554; c=relaxed/simple;
	bh=OAzSv7zbiweOZJOTW313bSUN6lxhxqHsi+RXRiausC8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ESoJhwIOLZCMbxw3BvCNAR1sqR4eMl1PQAwUbcbrc5ncpPUGlLN7iRWDd42d4sPmWUxkjfpVHDkaT7ado1/sscRjIrwtEyfipR5cqLeHx5zQx0wHsooYTPYiwiXSEofYJA2h+7+18n2uwntViQT5VDbO9VCiZP4+p4hAU0JPjaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AuHy1dbU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C7mYTtZM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6IgbDG009774;
	Thu, 6 Nov 2025 19:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4PCsMxmPgA0yqTPRQyrCv/SQFaWf3zHuerzsFeH3oSU=; b=
	AuHy1dbUFbPJmUBiSNIAliMwkyO1Xa61S2A9AYY4GDumbYsdaCVXtVpRTwH6J5fv
	IECIP3SuRJljSXQo5ARU+vF9YpHr4dFE+WVmT6FZhCThDkjJjApUWndn7glzA/GS
	2sSbjppWnONcWcEgMloBN8/aXA7PwSH4fKU3FRoo2S4Jb01Vr3IXmIH6t58J8E7k
	V7oE7KfSrXY67NlNpfu6isNOW/BjmAYJ+OmqRi9eYg8KIPgm83ELCCiI1/hPd4VC
	7/mPZAeSYvF61/0fYw5S9g5l5SXf4QlL+UsvpZpBNJQhrH53ddeltbff5ZO9ynF+
	DDlVugHv8hyg/HAPlIZjRQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8ykwr9xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 19:15:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6HLCan023035;
	Thu, 6 Nov 2025 19:15:02 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012010.outbound.protection.outlook.com [40.107.200.10])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ngce2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 19:15:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVSsJlaJ1Hi6HWK5QkeYjiH5esQlfiEqttctk6Fi/d1hn/rA3L23ogfbRtaHTGsC/G0pKLNhWtgz50V/w2mWWNSm41j1Cu0bz4WWS6bw5UvyXF3D4Gj1eL6gZefxzgVcfa2syBcDuIsNKcWUedVge15itSvP3HcGjv/zkOWCPLk8eVPaJLeSdI83vAI4ZuesXyfdyk7QQqDtzpgtJZRhalD3QA7dW1osCyiIp7jQ59mfIuMb8sqeIDEc3MBVd3mmyOJnVlsCXe7X+tLL+PxAQ1upSGftCm2IgtH2M/lhXaf6BCOvqNG7aJ5GCvgD2P1pyhd97TOHNH4KJsn6FhgRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PCsMxmPgA0yqTPRQyrCv/SQFaWf3zHuerzsFeH3oSU=;
 b=Xx1qbXoUy3/e479ZRAujpjRSA+ALxCQlGDqRm1C4w74pnLGcXvwBdqR8p5Cr0Hj6WLzK2++nnYSNnKZY1XABCfmgFAqonlNn0QL6rZfN8UTfQw6OiPZtzBhI17IKaZwP3HTu3FoTAbd0m8PKdZ9QYjHC9dZ/C7oegfUAZ1c1MmldCIbOuagTrZBORosgtORjplLc7Os6FhGyijcQeTvdFMCwF51e6FME4N0r3IFgpJdN/0vgDRFwCdUVVW8arc1foL+9+mYhDBSkfuKztVPgww1+okECBhzcwTZkZ4vbTWrcrPv4rwW0bFYiFzmaW17ZVb8bkt9sT/tq4s93jKI0aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PCsMxmPgA0yqTPRQyrCv/SQFaWf3zHuerzsFeH3oSU=;
 b=C7mYTtZMqX+HEt9/BWugCW5srcytVV+bsYL3qmT6q/iUJT5lIcj2HjDRruPOETvY4YS9uXlOaCGNWvw7Tgd3MrlFSxMWiHyNg8VZLlgleHnph145D2pi7cuVTJ7jutNESflPvTkbaiIPsHTV5lFv4RmhNEKSq+tGuOdTf/em/pQ=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH0PR10MB5732.namprd10.prod.outlook.com (2603:10b6:510:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 19:14:58 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9253.017; Thu, 6 Nov 2025
 19:14:57 +0000
Message-ID: <bad21a2d-c26b-4f95-9c75-566d63e415d9@oracle.com>
Date: Fri, 7 Nov 2025 00:44:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH net-next v05 3/5] hinic3: Add NIC
 configuration ops
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Markus.Elfring@web.de,
        pavan.chebbi@broadcom.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
        Shen Chenyang <shenchenyang1@hisilicon.com>,
        Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
        Shi Jing <shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>,
        Meny Yossefi <meny.yossefi@huawei.com>,
        Gur Stavi <gur.stavi@huawei.com>
References: <cover.1762414088.git.zhuyikai1@h-partners.com>
 <79e88cbc9aa0676d8f23fd2806eadd99350dd539.1762414088.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <79e88cbc9aa0676d8f23fd2806eadd99350dd539.1762414088.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::18) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH0PR10MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: b755123b-d924-4844-900c-08de1d68c664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlVQZWtoTEdPeCtubDNydkpEQ1NOOXZHa3o0aDNKRzFpNjlVWmJHbW8wQm1s?=
 =?utf-8?B?M0RsYlYvU3BFZldhZXVBQXhWcUR3UE8yWldtZ1lEcE9vdTAwYkk3QkduOXlp?=
 =?utf-8?B?Q3c2MHB2YWhPNmo0QVJDdlJhWVZvRUp5VFJpekZVbXEwMlZJb2o1VUZNVHZa?=
 =?utf-8?B?aFpMd0RTZlJSMGFLd0N1Sy9CUWRFOFcwcHJreTFITmlxQkNleEt3Tm95dThV?=
 =?utf-8?B?K3FlRXFrdFdiTlpFMWYweGUyb2wrVXUzNkNFa0tWVFA4MzRLVUxVbXViV3Rm?=
 =?utf-8?B?VnlNMEV0a2RvOWVuQWUyYytGL1ZXbm0rbjQzUjhUZXozY2VYL0tBQnE1RDk1?=
 =?utf-8?B?U1VwcmZoYm5VSE5iODdMaXJkc05wVHYzUEk5SGZCYnNkMXNRd0JLM0IzRUpr?=
 =?utf-8?B?RmQvZGtDamswWFp1NlBhNEJBdFIrS3puWGkyUVJNOXpydHRUOE9zOWE4VkV5?=
 =?utf-8?B?VDB6SVBYZjdLVER5aGwwY1JsSExzb3pKREtQRTdlTFZUcGhJcUVVSlFsemE4?=
 =?utf-8?B?c2J6TjA2dVJMZCt0NkNqSzhBdmgyWWU0dnJiZnRlRkxuaC9na3cwSTNGZmxV?=
 =?utf-8?B?UG0rd3pKbWpMOTNadVVJTWxiOGdibjZmK2FTdnhjUEx4a2lmQmFpS2NCdldq?=
 =?utf-8?B?MHU0NmtUb0R1MDZIc05LeFcyamNZU3NBZ2ZnNDVPRDVqWTI2a1JvbE8zVGxk?=
 =?utf-8?B?K0xJUnlRaHNLV2FyYVhpbVJsc2ZaQ0JaZnVRaE45WWM3Q05tMHBBanlMTmds?=
 =?utf-8?B?Rnh1emEzTGpKNWV5eCsyL0FNNVNEcjUrSjZMN0ZqbFdKcTgrZTNNc0JxNW5M?=
 =?utf-8?B?WG1XQUt4YkVWdERFSDNQemxmS0xCRENiZFExUjBxQ3Q2N1NrbUF6QUtaRklB?=
 =?utf-8?B?OVVpcnJBcUF2WkdBSHowQm5FRklkNGRmZENsekdFeHh4Sm9lRktRWGdHL001?=
 =?utf-8?B?anpWM0I2UThyOERIQmpBVGp3a3QyWGhmcXlleGUwOGVWdWVwME9UbGM4eTMr?=
 =?utf-8?B?bFl0dlFwbENsbEhqMVFsUmlwclBObkV0Tjk0K0c2V3RSbHMwWU5NTWR4QSsy?=
 =?utf-8?B?VDB3aHpiVFBqVnFncDVYS25ON2E0QVN3RWVWVDJFdkVLRGIvN1FIV1VFcWxT?=
 =?utf-8?B?aXF2ZGlCZ0p6L1RvUlAzWFRHcDZiQlpKT2dHVDBxQUhleGR5NitheXhRZHAr?=
 =?utf-8?B?bDFJK3FxTkpIWlR5S3Zhc1VLTUl4emFHRXBFY0tjUHhOY3BMQU1VQ2c4L2cz?=
 =?utf-8?B?WFlJWVNsdS9NVXNONXlMVVJ0Z3paVERCRWdMZHRKcHllMnhzT2RZYUxEUGpF?=
 =?utf-8?B?cmY2WmFpUWFYVFRGNFBBU240K0NCRUtYNkFCd2E1NGQ3RHBpVWFPRTVaM3Ar?=
 =?utf-8?B?aFZMQWFwSWRRYlJWdlVFakRQV3psMGdCNGROaHRrSHFsYXV3YnBmL2FjbzNn?=
 =?utf-8?B?M2lVL2NRQm1WNCs0TzVJWHFrTkpvdW5ick94bU05Y3VoWWFCZVExM29tYUdP?=
 =?utf-8?B?bENkWm5aT0VTaURjVlFWRVhGQktLYVc1ajh5djIrMjAwNk5Sa0NYOEY3MUhQ?=
 =?utf-8?B?YW14dm8wTjEyRzRYTFYyb1BGVmIwNkRRNkpYc0lMczRJcWdoY09zaTJsSll6?=
 =?utf-8?B?NmhkUkRNeWhKUUt5ejM4b1FycXFXZHlCL2NKWDFGSm1MSnh3OEdFY1FLV2ww?=
 =?utf-8?B?amtHNit0a240RGJHekhMWFcyLy8zRWpjakFCbkRBL3FvMHJUVzVXUTUxZXRZ?=
 =?utf-8?B?QVkrUm00d1V1M0wySkZBTnpXTHlVd1BVbFhJNnM0d21XNUtPdFhoZlZDMFNa?=
 =?utf-8?B?a0hFS1E0VXB2R21vek9nclhraElVcllLMGROVUkzQnhuUTkyMUtpODF2dmRF?=
 =?utf-8?B?Q0FBN21pcUVhUG1iYldhSWRJMXBaS1FNNlVmbDFObkJkZGhsakI4dEl3WERF?=
 =?utf-8?B?QmlhbFdCVFVEMFd2QklWZW1nbm56a0FBT2FMTzdOM0F3elJ4QzVKalNheGFE?=
 =?utf-8?Q?mSo35OuQxDEsVt1CI/sga9caxzemv8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2RBZ3VuVGRab1l5SlU2NXhXK1ZCRTkrWXJwYlVBcEZSUnZ2VVV4dzdSbU52?=
 =?utf-8?B?WFowbFlORUVCaVBHYjVqNGpzb2lYeEk2ZllzSXc0U0xCdFJKblg0V2x6a0ZJ?=
 =?utf-8?B?ZUtCbURsSXg5eUFmVlNnSXkrRjlIMjU2aFBTblFTT2xFNjFjMGdGMzFnVW9r?=
 =?utf-8?B?eGRQM1pQdnd4d3pEZ3U3Rk0yanZPNUFhTDlLdkVVZEJtemNURUlSVVdoVnkz?=
 =?utf-8?B?bi9tbDdSTnRoK3ZqdmdRSjFrNmdMdUN4MUtBUS9QTWVScFhUaGVuR1VPaEEr?=
 =?utf-8?B?SVhHcFJmalBZYlh6NXc4QkpFa0FaZms2ZWh2VC9WQXZMeFZQbkRLNU1WMWpx?=
 =?utf-8?B?WTFoc1pIZzRoTHJSajBUemlXTU9CVGJCaGZCdjRUOWk4WTJLVUJNL0lpcWEw?=
 =?utf-8?B?c3Z1TVFEU0NPV0M3b0dvTjNhYWZqNGFKR3Z1RFRxL2ppV2VXbklmNjkvbFcy?=
 =?utf-8?B?Vis4ZkswcVBJck1pejlpdEQzMnF2Q293WEV2TS9sWlVJZXd3NS9NVStkMm1R?=
 =?utf-8?B?NkRCbHVZUGpvT1VqQWZTd2xwMXQxSG02QTRtT2xTY1VWMU8xeWw3dFhBcmVD?=
 =?utf-8?B?SXdlNU93cTBzcmVrOHBNMlVBblBSZzNSVjFSL1hBVGJPMDBVMFFEK2txZita?=
 =?utf-8?B?M2xIdm04SGdUbzVYeXVEajdDemxDNDhObzFTT3hCVmZ6VEZLOEFyWWRIeG5x?=
 =?utf-8?B?OEI4MmZlR3Ntek12WlluY3IzTHBjRmJlbHpSRVp4RVZNbS9HMWxUVERvQTV6?=
 =?utf-8?B?Vnp1S2lwNHM4Qk1GZTd0cnhDZ3hjbVgxTURhSks3RjJ1K1hRMHUzb0cxQWt6?=
 =?utf-8?B?UzBZVkNkVkpmejJqbnU2WE5WNE93ZmZjN0t0cVlxeWhRT2ZXNXVyOEVrTTd3?=
 =?utf-8?B?UG5kbit5YjhVMUlEcDZncVRTcC9Vd2IwcGY0MWNuUDVPNVJmblhmbGdzY1Np?=
 =?utf-8?B?bDZrR0tpQmVoeFNvWEFRcGFYZHJicFJ6bkZvWTB5L3JRbWhFSEJyQWpyQTZX?=
 =?utf-8?B?WjVRZWpNTS8xb3JPZSt0RlkyQzgzRmhWZjRwYnhWYWwxelJRcUtoL3Foakty?=
 =?utf-8?B?SkIwTWd5M0pCclRLSTV4RTRVM0FpTDF6clNzQ3daU0p6ZlJTaEkwSm9KOXp2?=
 =?utf-8?B?VCsxMnloOW1WNU53a3NhOGM1NkE3OEMvMlhZcGlrNlRFaGwzbUswd1BRS01q?=
 =?utf-8?B?RENnaTVad3pwK1RMUjZYSUlkaW8ycjJ2akZDczZKakJaeEJHeTNNT25TQzBN?=
 =?utf-8?B?VERpVTdINmk3OUhQQ0s1ak5DUEFNVUNNUFdRaSsvaFVHdzAyMkVsZ28rdWN0?=
 =?utf-8?B?OFhiS3hZdkkrbFcwSFdiRTJGY0JvelVXbTc4RmVJSWFjcEl2SkhOcmprZHkw?=
 =?utf-8?B?VG8zT0ZDVTZMUUZjQUhUKzJHRUZOMmp1azhkNzhKc2wrdG9TSkhoaDVvSmJI?=
 =?utf-8?B?a0ZUOUZUd3l2VVdDT3VDUFZlMGVpaWtlaXZ1NytsREdsT1hWaDd2ZlBGWS91?=
 =?utf-8?B?MEd0ZTNjbUdOZXcxVnBWZFkvVCtVWG1GQjJJQ1JSaEdMK1JHbEZ5N2VUR2RT?=
 =?utf-8?B?L1hKbzhnU3hrcWZEYTFwNFJ3cE9IREQ4QXpBZHVGUlFGR3AyeEhldFF0NXRq?=
 =?utf-8?B?UVhVRmJ3SDhZdXI2L0FLeUZ0OE1HTnViTk5icWl0bU0zTmdCQ2NhWkNTMnZk?=
 =?utf-8?B?d1FvWThWUEIxNnJnL05wTkw3YVdBbitiQlM2WEdRcU0zSVpLbTBNODFSSlFF?=
 =?utf-8?B?QUIzZ0lTRVJxY3JJRlcvM05GMjRTYVM5b2dVZHV2c2RSOFBUSUZEUEFoVDZX?=
 =?utf-8?B?QWxhaXo2Tnd1VzFGeEcyWkFZamZpZmFkTmRBMWZaakZIRVVQMFkwL2NidFJ2?=
 =?utf-8?B?aklZTlhscVVlYThmeldlUENwekVSS3gwS3g2V2g0MUtsa3ZFL3p0TnVqOXo0?=
 =?utf-8?B?MjB2a3JxWDMvWVg4NXo3cU1wMDJQa1o0VVhYQU1SbTJPQjhBczYxcmJJU0FO?=
 =?utf-8?B?bTN4cmJOU20zb0JpdVhPS05VK2RGMHhmR0l2b2JiaG5uVlpiYVI2Q084TU5X?=
 =?utf-8?B?ZU1OczhuNVFMWHRnQzZvOG1ZandsTEZyclc3MEthT1pncTBCV04rWTBSQ3hp?=
 =?utf-8?B?RGxhaWN2UFdWR1lQRVA0MnZxeFpmRXlnOEVyY1dnOU1YSnBKWjVjOHFKV1JO?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rovENecJD/PB6+0TXnQI/GtpDVQuXRLSNs/9uDijMl/FA1u3JNDRXhrUFQkpf/7GVAG1tXXy/6lewAKd1guid6rAxIVOAfkcN8wexZTjdZnjVL3pb1O/uDbIGVtNErQPj1cngz5fXY7pvrId6L0+oFrVxQmElxryiBFVgp44b8EBhKLSmjwx3EpFPZ8lMM6sUkfx19o/iugZ5GMXHii7QePt5cVeu+9xNca65mVyn8kSwXUVZOjEs51xME1WQ0eCPh+cQaSzFSVsePvLns1ktNEYV+304cojjaeJTsIU2Mx29EAwwTm7TtvbyVeQjKhbV62JCway6/gfEvNCro28BHFrMOPpnudqD3jHjMMlFsUYrR5DWgpMvR+bUOMDDre5bEW2Yzx+4XrE41UyVjH8QZvJVv4EQNnKmh1UzpzsJsMbNN7YGRefkNpGL3d27UYJYdjTTpkE5M9sX1C34OfI+J1ug89KdbRwsDBCBTRgadVtN7DEUboiQ/8HZt7ESvwU2sO7Lug4n7d1FxbsT9SJK7TfUiLWzZanvomuYaoPiXBdddCWRkmiy4KuKyAXZ2r4m38bJB3qZkk3iEshz2qERq1bu2Z74Cudu8ChBdWjexU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b755123b-d924-4844-900c-08de1d68c664
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 19:14:57.8586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2IM8aC7CmBKjfZGbQJRlM7LXlwzaA+M14Cddt4wIL/WVekKyQ5ctKavYefcDpexj7Rw4Rvihig11stkXT4ZCjCx9F+NGWWqkSTXSeJ4Uzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511060156
X-Proofpoint-ORIG-GUID: FVHZ5INpnSAaoTCvL6KPAGqnk5AqKQKm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzNSBTYWx0ZWRfX2D/7Wyec98+b
 6xg5yBS0QqEdCB749Qpd0NJHW4AERcSS3GsGnDK8d4Cc8h5nlg9EdCyzFEV5IIIelSAn3VFaK4a
 sr/OHWRnXnNMvP5YFelfqVFV4Q3pxrGPssKc4xMBvNgqa2SPXzdWV3fV7cF2XUD9K8GLFMCzzwt
 Gs6znvxKgYWHl/92OAY3LJey5WSCLSF0qLNXCsCE09S+VvmYY7JBdpIxLv4pX8ub92x/2cH0QPa
 vy2TAsrR1zDsYsbXoK2mrDAfbXgCkHcivxSMBVxUGgRKwiSadFF4W8rhKZ5EP3MrzjcL15u7GgF
 g08J9Hc53h+XMO3xRbc4I4H2VWv2Ht+KO6lgmn4SyxpoUuxy4oWOWSpfAIOHGDJ3Bsn47SagbSs
 z5ER1wwZYRpmYaW+VFZMxj6/HGM7b7C0lDHcAFQq7Re54ygPCUI=
X-Proofpoint-GUID: FVHZ5INpnSAaoTCvL6KPAGqnk5AqKQKm
X-Authority-Analysis: v=2.4 cv=T6KBjvKQ c=1 sm=1 tr=0 ts=690cf3b7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7uoXELoAAAA:8 a=i0EeH86SAAAA:8 a=iHsgi__5cebxS3jvbBsA:9 a=QEXdDO2ut3YA:10
 a=07tN73Fy-TQQJT60VmHH:22 cc=ntf awl=host:12100



On 11/6/2025 4:45 PM, Fan Gong wrote:
> Add ops to configure NIC feature(lro, vlan, csum...).
> Add queue work to collect NIC data.
> 
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---
>   .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  54 +++
>   .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |   2 +
>   .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |   2 +-
>   .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |   9 +
>   .../net/ethernet/huawei/hinic3/hinic3_irq.c   | 136 +++++++-
>   .../net/ethernet/huawei/hinic3/hinic3_main.c  |  43 +++
>   .../huawei/hinic3/hinic3_mgmt_interface.h     |  50 +++
>   .../huawei/hinic3/hinic3_netdev_ops.c         | 318 ++++++++++++++++++
>   .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 171 ++++++++++
>   .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |   7 +
>   .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  45 +++
>   .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  20 ++
>   .../net/ethernet/huawei/hinic3/hinic3_tx.h    |  18 +
>   13 files changed, 873 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
> index 09dae2ef610c..554b3134b5a7 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
> @@ -9,6 +9,36 @@
>   #include "hinic3_hwif.h"
>   #include "hinic3_mbox.h"
>   
> +static int hinic3_get_interrupt_cfg(struct hinic3_hwdev *hwdev,
> +				    struct hinic3_interrupt_info *info)
> +{
> +	struct comm_cmd_cfg_msix_ctrl_reg msix_cfg = {};
> +	struct mgmt_msg_params msg_params = {};
> +	int err;
> +
> +	msix_cfg.func_id = hinic3_global_func_id(hwdev);
> +	msix_cfg.msix_index = info->msix_index;
> +	msix_cfg.opcode = MGMT_MSG_CMD_OP_GET;
> +
> +	mgmt_msg_params_init_default(&msg_params, &msix_cfg, sizeof(msix_cfg));
> +
> +	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
> +				       COMM_CMD_CFG_MSIX_CTRL_REG, &msg_params);
> +	if (err || msix_cfg.head.status) {
> +		dev_err(hwdev->dev, "Failed to get interrupt config, err: %d, status: 0x%x\n",
> +			err, msix_cfg.head.status);
> +		return -EFAULT;
> +	}
> +
> +	info->lli_credit_limit = msix_cfg.lli_credit_cnt;
> +	info->lli_timer_cfg = msix_cfg.lli_timer_cnt;
> +	info->pending_limit = msix_cfg.pending_cnt;
> +	info->coalesc_timer_cfg = msix_cfg.coalesce_timer_cnt;
> +	info->resend_timer_cfg = msix_cfg.resend_timer_cnt;
> +
> +	return 0;
> +}
> +
>   int hinic3_set_interrupt_cfg_direct(struct hinic3_hwdev *hwdev,
>   				    const struct hinic3_interrupt_info *info)
>   {
> @@ -40,6 +70,30 @@ int hinic3_set_interrupt_cfg_direct(struct hinic3_hwdev *hwdev,
>   	return 0;
>   }
>   
> +int hinic3_set_interrupt_cfg(struct hinic3_hwdev *hwdev,
> +			     struct hinic3_interrupt_info info)
> +{
> +	struct hinic3_interrupt_info temp_info;
> +	int err;
> +
> +	temp_info.msix_index = info.msix_index;
> +
> +	err = hinic3_get_interrupt_cfg(hwdev, &temp_info);
> +	if (err)
> +		return err;
> +
> +	info.lli_credit_limit = temp_info.lli_credit_limit;
> +	info.lli_timer_cfg = temp_info.lli_timer_cfg;
> +
> +	if (!info.interrupt_coalesc_set) {
> +		info.pending_limit = temp_info.pending_limit;
> +		info.coalesc_timer_cfg = temp_info.coalesc_timer_cfg;
> +		info.resend_timer_cfg = temp_info.resend_timer_cfg;
> +	}
> +
> +	return hinic3_set_interrupt_cfg_direct(hwdev, &info);
> +}
> +
>   int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag)
>   {
>   	struct comm_cmd_func_reset func_reset = {};
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
> index c9c6b4fbcb12..8e4737c486b7 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
> @@ -23,6 +23,8 @@ struct hinic3_interrupt_info {
>   
>   int hinic3_set_interrupt_cfg_direct(struct hinic3_hwdev *hwdev,
>   				    const struct hinic3_interrupt_info *info);
> +int hinic3_set_interrupt_cfg(struct hinic3_hwdev *hwdev,
> +			     struct hinic3_interrupt_info info);
>   int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag);
>   
>   int hinic3_get_comm_features(struct hinic3_hwdev *hwdev, u64 *s_feature,
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
> index 25e375b20174..4048b3302db7 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
> @@ -200,7 +200,7 @@ static int init_ceqs_msix_attr(struct hinic3_hwdev *hwdev)
>   	for (q_id = 0; q_id < ceqs->num_ceqs; q_id++) {
>   		eq = &ceqs->ceq[q_id];
>   		info.msix_index = eq->msix_entry_idx;
> -		err = hinic3_set_interrupt_cfg_direct(hwdev, &info);
> +		err = hinic3_set_interrupt_cfg(hwdev, info);
>   		if (err) {
>   			dev_err(hwdev->dev, "Set msix attr for ceq %u failed\n",
>   				q_id);
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
> index 3c15f22973fe..58bc561f95b3 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
> @@ -17,6 +17,15 @@ enum hinic3_event_service_type {
>   	HINIC3_EVENT_SRV_NIC  = 1
>   };
>   
> +enum hinic3_fault_err_level {
> +	HINIC3_FAULT_LEVEL_SERIOUS_FLR = 3,
> +};
> +
> +enum hinic3_fault_source_type {
> +	HINIC3_FAULT_SRC_HW_PHY_FAULT = 9,
> +	HINIC3_FAULT_SRC_TX_TIMEOUT   = 22,
> +};
> +
>   #define HINIC3_SRV_EVENT_TYPE(svc, type)    (((svc) << 16) | (type))
>   
>   /* driver-specific data of pci_dev */
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> index a69b361225e9..cb9412986c26 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> @@ -10,6 +10,9 @@
>   #include "hinic3_rx.h"
>   #include "hinic3_tx.h"
>   
> +#define HINIC3_RX_RATE_THRESH  50000
> +#define HINIC3_AVG_PKT_SMALL   256U
> +
>   static int hinic3_poll(struct napi_struct *napi, int budget)
>   {
>   	struct hinic3_irq_cfg *irq_cfg =
> @@ -92,7 +95,7 @@ static int hinic3_request_irq(struct hinic3_irq_cfg *irq_cfg, u16 q_id)
>   	info.coalesc_timer_cfg =
>   		nic_dev->intr_coalesce[q_id].coalesce_timer_cfg;
>   	info.resend_timer_cfg = nic_dev->intr_coalesce[q_id].resend_timer_cfg;
> -	err = hinic3_set_interrupt_cfg_direct(nic_dev->hwdev, &info);
> +	err = hinic3_set_interrupt_cfg(nic_dev->hwdev, info);
>   	if (err) {
>   		netdev_err(netdev, "Failed to set RX interrupt coalescing attribute.\n");
>   		qp_del_napi(irq_cfg);
> @@ -117,6 +120,134 @@ static void hinic3_release_irq(struct hinic3_irq_cfg *irq_cfg)
>   	free_irq(irq_cfg->irq_id, irq_cfg);
>   }
>   
> +static int hinic3_set_interrupt_moder(struct net_device *netdev, u16 q_id,
> +				      u8 coalesc_timer_cfg, u8 pending_limit)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_interrupt_info info = {};
> +	int err;
> +
> +	if (coalesc_timer_cfg == nic_dev->rxqs[q_id].last_coalesc_timer_cfg &&
> +	    pending_limit == nic_dev->rxqs[q_id].last_pending_limit)
> +		return 0;
> +
> +	if (q_id >= nic_dev->q_params.num_qps)
> +		return 0;
> +
> +	info.interrupt_coalesc_set = 1;
> +	info.coalesc_timer_cfg = coalesc_timer_cfg;
> +	info.pending_limit = pending_limit;
> +	info.msix_index = nic_dev->q_params.irq_cfg[q_id].msix_entry_idx;
> +	info.resend_timer_cfg =
> +		nic_dev->intr_coalesce[q_id].resend_timer_cfg;
> +
> +	err = hinic3_set_interrupt_cfg(nic_dev->hwdev, info);
> +	if (err) {
> +		netdev_err(netdev,
> +			   "Failed to modify moderation for Queue: %u\n", q_id);
> +	} else {
> +		nic_dev->rxqs[q_id].last_coalesc_timer_cfg = coalesc_timer_cfg;
> +		nic_dev->rxqs[q_id].last_pending_limit = pending_limit;
> +	}
> +
> +	return err;
> +}
> +
> +static void hinic3_calc_coal_para(struct hinic3_intr_coal_info *q_coal,
> +				  u64 rx_rate, u8 *coalesc_timer_cfg,
> +				  u8 *pending_limit)
> +{
> +	if (rx_rate < q_coal->pkt_rate_low) {
> +		*coalesc_timer_cfg = q_coal->rx_usecs_low;
> +		*pending_limit = q_coal->rx_pending_limit_low;
> +	} else if (rx_rate > q_coal->pkt_rate_high) {
> +		*coalesc_timer_cfg = q_coal->rx_usecs_high;
> +		*pending_limit = q_coal->rx_pending_limit_high;
> +	} else {
> +		*coalesc_timer_cfg =
> +			(u8)((rx_rate - q_coal->pkt_rate_low) *
> +			     (q_coal->rx_usecs_high - q_coal->rx_usecs_low) /
> +			     (q_coal->pkt_rate_high - q_coal->pkt_rate_low) +
> +			     q_coal->rx_usecs_low);
> +
> +		*pending_limit =
> +			(u8)((rx_rate - q_coal->pkt_rate_low) *
> +			     (q_coal->rx_pending_limit_high -
> +			      q_coal->rx_pending_limit_low) /
> +			     (q_coal->pkt_rate_high - q_coal->pkt_rate_low) +
> +			     q_coal->rx_pending_limit_low);
> +	}
> +}
> +
> +static void hinic3_update_queue_coal(struct net_device *netdev, u16 qid,
> +				     u64 rx_rate, u64 avg_pkt_size, u64 tx_rate)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_intr_coal_info *q_coal;
> +	u8 coalesc_timer_cfg, pending_limit;
> +
> +	q_coal = &nic_dev->intr_coalesce[qid];
> +
> +	if (rx_rate > HINIC3_RX_RATE_THRESH &&
> +	    avg_pkt_size > HINIC3_AVG_PKT_SMALL) {
> +		hinic3_calc_coal_para(q_coal, rx_rate, &coalesc_timer_cfg,
> +				      &pending_limit);
> +	} else {
> +		coalesc_timer_cfg = 3;
> +		pending_limit = q_coal->rx_pending_limit_low;
> +	}
> +
> +	hinic3_set_interrupt_moder(netdev, qid,
> +				   coalesc_timer_cfg, pending_limit);
> +}
> +
> +static void hinic3_auto_moderation_work(struct work_struct *work)
> +{
> +	u64 rx_packets, rx_bytes, rx_pkt_diff, rx_rate, avg_pkt_size;
> +	u64 tx_packets, tx_bytes, tx_pkt_diff, tx_rate;
> +	struct hinic3_nic_dev *nic_dev;
> +	struct delayed_work *delay;
> +	struct net_device *netdev;
> +	unsigned long period;
> +	u16 qid;
> +
> +	delay = to_delayed_work(work);
> +	nic_dev = container_of(delay, struct hinic3_nic_dev, moderation_task);
> +	period = (unsigned long)(jiffies - nic_dev->last_moder_jiffies);
> +	netdev = nic_dev->netdev;
> +
> +	queue_delayed_work(nic_dev->workq, &nic_dev->moderation_task,
> +			   HINIC3_MODERATONE_DELAY);
> +
> +	for (qid = 0; qid < nic_dev->q_params.num_qps; qid++) {
> +		rx_packets = nic_dev->rxqs[qid].rxq_stats.packets;
> +		rx_bytes = nic_dev->rxqs[qid].rxq_stats.bytes;
> +		tx_packets = nic_dev->txqs[qid].txq_stats.packets;
> +		tx_bytes = nic_dev->txqs[qid].txq_stats.bytes;
> +
> +		rx_pkt_diff =
> +			rx_packets - nic_dev->rxqs[qid].last_moder_packets;
> +		avg_pkt_size = rx_pkt_diff ?
> +			((unsigned long)(rx_bytes -
> +			 nic_dev->rxqs[qid].last_moder_bytes)) /
> +			 rx_pkt_diff : 0;
> +
> +		rx_rate = rx_pkt_diff * HZ / period;
> +		tx_pkt_diff =
> +			tx_packets - nic_dev->txqs[qid].last_moder_packets;
> +		tx_rate = tx_pkt_diff * HZ / period;
> +
> +		hinic3_update_queue_coal(netdev, qid, rx_rate, avg_pkt_size,
> +					 tx_rate);
> +		nic_dev->rxqs[qid].last_moder_packets = rx_packets;
> +		nic_dev->rxqs[qid].last_moder_bytes = rx_bytes;
> +		nic_dev->txqs[qid].last_moder_packets = tx_packets;
> +		nic_dev->txqs[qid].last_moder_bytes = tx_bytes;
> +	}
> +
> +	nic_dev->last_moder_jiffies = jiffies;
> +}
> +
>   int hinic3_qps_irq_init(struct net_device *netdev)
>   {
>   	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> @@ -157,6 +288,9 @@ int hinic3_qps_irq_init(struct net_device *netdev)
>   				      HINIC3_MSIX_ENABLE);
>   	}
>   
> +	INIT_DELAYED_WORK(&nic_dev->moderation_task,
> +			  hinic3_auto_moderation_work);
> +
>   	return 0;
>   
>   err_release_irqs:
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> index e12102806791..4a47dac1c4b4 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> @@ -108,6 +108,22 @@ static void hinic3_free_txrxqs(struct net_device *netdev)
>   	hinic3_free_txqs(netdev);
>   }
>   
> +static void hinic3_periodic_work_handler(struct work_struct *work)
> +{
> +	struct delayed_work *delay = to_delayed_work(work);
> +	struct hinic3_nic_dev *nic_dev;
> +
> +	nic_dev = container_of(delay, struct hinic3_nic_dev, periodic_work);
> +	if (test_and_clear_bit(HINIC3_EVENT_WORK_TX_TIMEOUT,
> +			       &nic_dev->event_flag))
> +		dev_info(nic_dev->hwdev->dev,
> +			 "Fault event report, src: %u, level: %u\n",
> +			 HINIC3_FAULT_SRC_TX_TIMEOUT,
> +			 HINIC3_FAULT_LEVEL_SERIOUS_FLR);
> +
> +	queue_delayed_work(nic_dev->workq, &nic_dev->periodic_work, HZ);
> +}
> +
>   static int hinic3_init_nic_dev(struct net_device *netdev,
>   			       struct hinic3_hwdev *hwdev)
>   {
> @@ -121,8 +137,23 @@ static int hinic3_init_nic_dev(struct net_device *netdev,
>   
>   	nic_dev->rx_buf_len = HINIC3_RX_BUF_LEN;
>   	nic_dev->lro_replenish_thld = HINIC3_LRO_REPLENISH_THLD;
> +	nic_dev->vlan_bitmap = kzalloc(HINIC3_VLAN_BITMAP_SIZE(nic_dev),
> +				       GFP_KERNEL);
> +	if (!nic_dev->vlan_bitmap)
> +		return -ENOMEM;
> +
>   	nic_dev->nic_svc_cap = hwdev->cfg_mgmt->cap.nic_svc_cap;
>   
> +	nic_dev->workq = create_singlethread_workqueue(HINIC3_NIC_DEV_WQ_NAME);
> +	if (!nic_dev->workq) {
> +		dev_err(hwdev->dev, "Failed to initialize nic workqueue\n");
> +		kfree(nic_dev->vlan_bitmap);
> +		return -ENOMEM;
> +	}
> +
> +	INIT_DELAYED_WORK(&nic_dev->periodic_work,
> +			  hinic3_periodic_work_handler);
> +
>   	return 0;
>   }
>   
> @@ -229,6 +260,13 @@ static int hinic3_set_default_hw_feature(struct net_device *netdev)
>   		return err;
>   	}
>   
> +	err = hinic3_set_hw_features(netdev);
> +	if (err) {
> +		hinic3_update_nic_feature(nic_dev, 0);
> +		hinic3_set_nic_feature_to_hw(nic_dev);
> +		return err;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -329,6 +367,7 @@ static int hinic3_nic_probe(struct auxiliary_device *adev,
>   	if (err)
>   		goto err_uninit_sw;
>   
> +	queue_delayed_work(nic_dev->workq, &nic_dev->periodic_work, HZ);
>   	netif_carrier_off(netdev);
>   
>   	err = register_netdev(netdev);
> @@ -368,12 +407,16 @@ static void hinic3_nic_remove(struct auxiliary_device *adev)
>   	netdev = nic_dev->netdev;
>   	unregister_netdev(netdev);
>   
> +	disable_delayed_work_sync(&nic_dev->periodic_work);
> +	destroy_workqueue(nic_dev->workq);
> +
>   	hinic3_update_nic_feature(nic_dev, 0);
>   	hinic3_set_nic_feature_to_hw(nic_dev);
>   	hinic3_sw_uninit(netdev);
>   
>   	hinic3_free_nic_io(nic_dev);
>   
> +	kfree(nic_dev->vlan_bitmap);
>   	free_netdev(netdev);
>   }
>   
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
> index 3a6d3ee534d0..68dfdfa1b1ba 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
> @@ -56,6 +56,31 @@ struct l2nic_cmd_update_mac {
>   	u8                   new_mac[ETH_ALEN];
>   };
>   
> +struct l2nic_cmd_vlan_config {
> +	struct mgmt_msg_head msg_head;
> +	u16                  func_id;
> +	u8                   opcode;
> +	u8                   rsvd1;
> +	u16                  vlan_id;
> +	u16                  rsvd2;
> +};
> +
> +struct l2nic_cmd_vlan_offload {
> +	struct mgmt_msg_head msg_head;
> +	u16                  func_id;
> +	u8                   vlan_offload;
> +	u8                   vd1[5];

Probably rsvd1[5];

> +};
> +
> +/* set vlan filter */
> +struct l2nic_cmd_set_vlan_filter {
> +	struct mgmt_msg_head msg_head;
> +	u16                  func_id;
> +	u8                   resvd[2];

what about rsvd[2]; ?

> +	/* bit0:vlan filter en; bit1:broadcast_filter_en */
> +	u32                  vlan_filter_ctrl;
> +};
> +
>   struct l2nic_cmd_set_ci_attr {
>   	struct mgmt_msg_head msg_head;
>   	u16                  func_idx;
> @@ -102,6 +127,26 @@ struct l2nic_cmd_set_dcb_state {
>   	u8                   rsvd[7];
>   };
>   
> +struct l2nic_cmd_lro_config {
> +	struct mgmt_msg_head msg_head;
> +	u16                  func_id;
> +	u8                   opcode;
> +	u8                   rsvd1;
> +	u8                   lro_ipv4_en;
> +	u8                   lro_ipv6_en;
> +	/* unit is 1K */
> +	u8                   lro_max_pkt_len;
> +	u8                   resv2[13];
> +};
> +
> +struct l2nic_cmd_lro_timer {
> +	struct mgmt_msg_head msg_head;
> +	/* 1: set timer value, 0: get timer value */
> +	u8                   opcode;
> +	u8                   rsvd[3];
> +	u32                  timer;
> +};
> +
>   #define L2NIC_RSS_TYPE_VALID_MASK         BIT(23)
>   #define L2NIC_RSS_TYPE_TCP_IPV6_EXT_MASK  BIT(24)
>   #define L2NIC_RSS_TYPE_IPV6_EXT_MASK      BIT(25)
> @@ -162,11 +207,16 @@ enum l2nic_cmd {
>   	L2NIC_CMD_SET_VPORT_ENABLE    = 6,
>   	L2NIC_CMD_SET_SQ_CI_ATTR      = 8,
>   	L2NIC_CMD_CLEAR_QP_RESOURCE   = 11,
> +	L2NIC_CMD_CFG_RX_LRO          = 13,
> +	L2NIC_CMD_CFG_LRO_TIMER       = 14,
>   	L2NIC_CMD_FEATURE_NEGO        = 15,
>   	L2NIC_CMD_GET_MAC             = 20,
>   	L2NIC_CMD_SET_MAC             = 21,
>   	L2NIC_CMD_DEL_MAC             = 22,
>   	L2NIC_CMD_UPDATE_MAC          = 23,
> +	L2NIC_CMD_CFG_FUNC_VLAN       = 25,
> +	L2NIC_CMD_SET_VLAN_FILTER_EN  = 26,
> +	L2NIC_CMD_SET_RX_VLAN_OFFLOAD = 27,
>   	L2NIC_CMD_CFG_RSS             = 60,
>   	L2NIC_CMD_CFG_RSS_HASH_KEY    = 63,
>   	L2NIC_CMD_CFG_RSS_HASH_ENGINE = 64,
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> index bf199f4ce847..ad50128f3d76 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> @@ -12,6 +12,15 @@
>   #include "hinic3_rx.h"
>   #include "hinic3_tx.h"
>   
> +#define HINIC3_LRO_DEFAULT_COAL_PKT_SIZE  32
> +#define HINIC3_LRO_DEFAULT_TIME_LIMIT     16
> +
> +#define VLAN_BITMAP_BITS_SIZE(nic_dev)    (sizeof(*(nic_dev)->vlan_bitmap) * 8)
> +#define VID_LINE(nic_dev, vid)  \
> +	((vid) / VLAN_BITMAP_BITS_SIZE(nic_dev))
> +#define VID_COL(nic_dev, vid)  \
> +	((vid) & (VLAN_BITMAP_BITS_SIZE(nic_dev) - 1))
> +
>   /* try to modify the number of irq to the target number,
>    * and return the actual number of irq.
>    */
> @@ -384,6 +393,9 @@ static int hinic3_vport_up(struct net_device *netdev)
>   	if (!err && link_status_up)
>   		netif_carrier_on(netdev);
>   
> +	queue_delayed_work(nic_dev->workq, &nic_dev->moderation_task,
> +			   HINIC3_MODERATONE_DELAY);
> +
>   	hinic3_print_link_message(netdev, link_status_up);
>   
>   	return 0;
> @@ -406,6 +418,8 @@ static void hinic3_vport_down(struct net_device *netdev)
>   	netif_carrier_off(netdev);
>   	netif_tx_disable(netdev);
>   
> +	disable_delayed_work_sync(&nic_dev->moderation_task);
> +
>   	glb_func_id = hinic3_global_func_id(nic_dev->hwdev);
>   	hinic3_set_vport_enable(nic_dev->hwdev, glb_func_id, false);
>   
> @@ -476,6 +490,162 @@ static int hinic3_close(struct net_device *netdev)
>   	return 0;
>   }
>   
> +#define SET_FEATURES_OP_STR(op)  ((op) ? "Enable" : "Disable")
> +
> +static int hinic3_set_feature_rx_csum(struct net_device *netdev,
> +				      netdev_features_t wanted_features,
> +				      netdev_features_t features,
> +				      netdev_features_t *failed_features)
> +{
> +	netdev_features_t changed = wanted_features ^ features;
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> +
> +	if (changed & NETIF_F_RXCSUM)
> +		dev_dbg(hwdev->dev, "%s rx csum success\n",
> +			SET_FEATURES_OP_STR(wanted_features & NETIF_F_RXCSUM));
> +
> +	return 0;
> +}
> +
> +static int hinic3_set_feature_tso(struct net_device *netdev,
> +				  netdev_features_t wanted_features,
> +				  netdev_features_t features,
> +				  netdev_features_t *failed_features)
> +{
> +	netdev_features_t changed = wanted_features ^ features;
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> +
> +	if (changed & NETIF_F_TSO)
> +		dev_dbg(hwdev->dev, "%s tso success\n",
> +			SET_FEATURES_OP_STR(wanted_features & NETIF_F_TSO));
> +
> +	return 0;
> +}
> +
> +static int hinic3_set_feature_lro(struct net_device *netdev,
> +				  netdev_features_t wanted_features,
> +				  netdev_features_t features,
> +				  netdev_features_t *failed_features)
> +{
> +	netdev_features_t changed = wanted_features ^ features;
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> +	bool en = !!(wanted_features & NETIF_F_LRO);
> +	int err;
> +
> +	if (!(changed & NETIF_F_LRO))
> +		return 0;
> +
> +	err = hinic3_set_rx_lro_state(hwdev, en,
> +				      HINIC3_LRO_DEFAULT_TIME_LIMIT,
> +				      HINIC3_LRO_DEFAULT_COAL_PKT_SIZE);
> +	if (err) {
> +		dev_err(hwdev->dev, "%s lro failed\n", SET_FEATURES_OP_STR(en));
> +		*failed_features |= NETIF_F_LRO;
> +	}
> +
> +	return err;
> +}
> +
> +static int hinic3_set_feature_rx_cvlan(struct net_device *netdev,
> +				       netdev_features_t wanted_features,
> +				       netdev_features_t features,
> +				       netdev_features_t *failed_features)
> +{
> +	bool en = !!(wanted_features & NETIF_F_HW_VLAN_CTAG_RX);
> +	netdev_features_t changed = wanted_features ^ features;
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> +	int err;
> +
> +	if (!(changed & NETIF_F_HW_VLAN_CTAG_RX))
> +		return 0;
> +
> +	err = hinic3_set_rx_vlan_offload(hwdev, en);
> +	if (err) {
> +		dev_err(hwdev->dev, "%s rxvlan failed\n",

"%s rx vlan offload failed\n" similar to below one

> +			SET_FEATURES_OP_STR(en));
> +		*failed_features |= NETIF_F_HW_VLAN_CTAG_RX;
> +	}
> +
> +	return err;
> +}
> +
> +static int hinic3_set_feature_vlan_filter(struct net_device *netdev,
> +					  netdev_features_t wanted_features,
> +					  netdev_features_t features,
> +					  netdev_features_t *failed_features)
> +{
> +	bool en = !!(wanted_features & NETIF_F_HW_VLAN_CTAG_FILTER);
> +	netdev_features_t changed = wanted_features ^ features;
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> +	int err;
> +
> +	if (!(changed & NETIF_F_HW_VLAN_CTAG_FILTER))
> +		return 0;
> +
> +	err = hinic3_set_vlan_fliter(hwdev, en);
> +	if (err) {
> +		dev_err(hwdev->dev, "%s rx vlan filter failed\n",
> +			SET_FEATURES_OP_STR(en));
> +		*failed_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
> +	}
> +
> +	return err;
> +}
> +
> +static int hinic3_set_features(struct net_device *netdev,
> +			       netdev_features_t curr,
> +			       netdev_features_t wanted)
> +{
> +	netdev_features_t failed = 0;
> +	int err;
> +
> +	err = hinic3_set_feature_rx_csum(netdev, wanted, curr, &failed) |
> +	      hinic3_set_feature_tso(netdev, wanted, curr, &failed) |
> +	      hinic3_set_feature_lro(netdev, wanted, curr, &failed) |
> +	      hinic3_set_feature_rx_cvlan(netdev, wanted, curr, &failed) |
> +	      hinic3_set_feature_vlan_filter(netdev, wanted, curr, &failed);
> +	if (err) {
> +		netdev->features = wanted ^ failed;
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hinic3_ndo_set_features(struct net_device *netdev,
> +				   netdev_features_t features)
> +{
> +	return hinic3_set_features(netdev, netdev->features, features);
> +}
> +
> +static netdev_features_t hinic3_fix_features(struct net_device *netdev,
> +					     netdev_features_t features)
> +{
> +	netdev_features_t features_tmp = features;
> +
> +	/* If Rx checksum is disabled, then LRO should also be disabled */
> +	if (!(features_tmp & NETIF_F_RXCSUM))
> +		features_tmp &= ~NETIF_F_LRO;
> +
> +	return features_tmp;
> +}
> +
> +int hinic3_set_hw_features(struct net_device *netdev)
> +{
> +	netdev_features_t wanted, curr;
> +
> +	wanted = netdev->features;
> +	/* fake current features so all wanted are enabled */
> +	curr = ~wanted;
> +
> +	return hinic3_set_features(netdev, curr, wanted);
> +}
> +
>   static int hinic3_change_mtu(struct net_device *netdev, int new_mtu)
>   {
>   	int err;
> @@ -517,11 +687,159 @@ static int hinic3_set_mac_addr(struct net_device *netdev, void *addr)
>   	return 0;
>   }
>   
> +static int hinic3_vlan_rx_add_vid(struct net_device *netdev,
> +				  __be16 proto, u16 vid)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	unsigned long *vlan_bitmap = nic_dev->vlan_bitmap;
> +	u32 column, row;
> +	u16 func_id;
> +	int err;
> +
> +	column = VID_COL(nic_dev, vid);
> +	row = VID_LINE(nic_dev, vid);
> +
> +	func_id = hinic3_global_func_id(nic_dev->hwdev);
> +
> +	err = hinic3_add_vlan(nic_dev->hwdev, vid, func_id);
> +	if (err) {
> +		netdev_err(netdev, "Failed to add vlan %u\n", vid);
> +		goto out;
> +	}
> +
> +	set_bit(column, &vlan_bitmap[row]);
> +	netdev_dbg(netdev, "Add vlan %u\n", vid);
> +
> +out:
> +	return err;
> +}
> +
> +static int hinic3_vlan_rx_kill_vid(struct net_device *netdev,
> +				   __be16 proto, u16 vid)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	unsigned long *vlan_bitmap = nic_dev->vlan_bitmap;
> +	u32 column, row;
> +	u16 func_id;
> +	int err;
> +
> +	column  = VID_COL(nic_dev, vid);
> +	row = VID_LINE(nic_dev, vid);
> +
> +	func_id = hinic3_global_func_id(nic_dev->hwdev);
> +	err = hinic3_del_vlan(nic_dev->hwdev, vid, func_id);
> +	if (err) {
> +		netdev_err(netdev, "Failed to delete vlan\n");

missing %u\n", vid) similar to add vlan

> +		goto out;
> +	}
> +
> +	clear_bit(column, &vlan_bitmap[row]);
> +	netdev_dbg(netdev, "Remove vlan %u\n", vid);
> +
> +out:
> +	return err;
> +}
> +
> +static void hinic3_tx_timeout(struct net_device *netdev, unsigned int txqueue)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_io_queue *sq;
> +	bool hw_err = false;
> +	u16 sw_pi, hw_ci;
> +	u8 q_id;
> +
> +	HINIC3_NIC_STATS_INC(nic_dev, netdev_tx_timeout);
> +	netdev_err(netdev, "Tx timeout\n");
> +
> +	for (q_id = 0; q_id < nic_dev->q_params.num_qps; q_id++) {
> +		if (!netif_xmit_stopped(netdev_get_tx_queue(netdev, q_id)))
> +			continue;
> +
> +		sq = nic_dev->txqs[q_id].sq;
> +		sw_pi = hinic3_get_sq_local_pi(sq);
> +		hw_ci = hinic3_get_sq_hw_ci(sq);
> +		netdev_dbg(netdev,
> +			   "txq%u: sw_pi: %u, hw_ci: %u, sw_ci: %u, napi->state: 0x%lx.\n",
> +			   q_id, sw_pi, hw_ci, hinic3_get_sq_local_ci(sq),
> +			   nic_dev->q_params.irq_cfg[q_id].napi.state);
> +
> +		if (sw_pi != hw_ci)
> +			hw_err = true;
> +	}
> +
> +	if (hw_err)
> +		set_bit(HINIC3_EVENT_WORK_TX_TIMEOUT, &nic_dev->event_flag);
> +}
> +
> +static void hinic3_get_stats64(struct net_device *netdev,
> +			       struct rtnl_link_stats64 *stats)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	u64 bytes, packets, dropped, errors;
> +	struct hinic3_txq_stats *txq_stats;
> +	struct hinic3_rxq_stats *rxq_stats;
> +	struct hinic3_txq *txq;
> +	struct hinic3_rxq *rxq;
> +	unsigned int start;
> +	int i;
> +
> +	bytes = 0;
> +	packets = 0;
> +	dropped = 0;
> +	for (i = 0; i < nic_dev->max_qps; i++) {
> +		if (!nic_dev->txqs)
> +			break;
> +
> +		txq = &nic_dev->txqs[i];
> +		txq_stats = &txq->txq_stats;
> +		do {
> +			start = u64_stats_fetch_begin(&txq_stats->syncp);
> +			bytes += txq_stats->bytes;
> +			packets += txq_stats->packets;
> +			dropped += txq_stats->dropped;
> +		} while (u64_stats_fetch_retry(&txq_stats->syncp, start));
> +	}
> +	stats->tx_packets = packets;
> +	stats->tx_bytes   = bytes;
> +	stats->tx_dropped = dropped;
> +
> +	bytes = 0;
> +	packets = 0;
> +	errors = 0;
> +	dropped = 0;
> +	for (i = 0; i < nic_dev->max_qps; i++) {
> +		if (!nic_dev->rxqs)
> +			break;
> +
> +		rxq = &nic_dev->rxqs[i];
> +		rxq_stats = &rxq->rxq_stats;
> +		do {
> +			start = u64_stats_fetch_begin(&rxq_stats->syncp);
> +			bytes += rxq_stats->bytes;
> +			packets += rxq_stats->packets;
> +			errors += rxq_stats->csum_errors +
> +				rxq_stats->other_errors;
> +			dropped += rxq_stats->dropped;
> +		} while (u64_stats_fetch_retry(&rxq_stats->syncp, start));
> +	}
> +	stats->rx_packets = packets;
> +	stats->rx_bytes   = bytes;
> +	stats->rx_errors  = errors;
> +	stats->rx_dropped = dropped;
> +}
> +
>   static const struct net_device_ops hinic3_netdev_ops = {
>   	.ndo_open             = hinic3_open,
>   	.ndo_stop             = hinic3_close,
> +	.ndo_set_features     = hinic3_ndo_set_features,
> +	.ndo_fix_features     = hinic3_fix_features,
>   	.ndo_change_mtu       = hinic3_change_mtu,
>   	.ndo_set_mac_address  = hinic3_set_mac_addr,
> +	.ndo_validate_addr    = eth_validate_addr,
> +	.ndo_vlan_rx_add_vid  = hinic3_vlan_rx_add_vid,
> +	.ndo_vlan_rx_kill_vid = hinic3_vlan_rx_kill_vid,
> +	.ndo_tx_timeout       = hinic3_tx_timeout,
> +	.ndo_get_stats64      = hinic3_get_stats64,
>   	.ndo_start_xmit       = hinic3_xmit_frame,
>   };
>   
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
> index 7fec13bbe60e..72e09402841a 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
> @@ -10,6 +10,9 @@
>   #include "hinic3_nic_dev.h"
>   #include "hinic3_nic_io.h"
>   
> +#define MGMT_MSG_CMD_OP_ADD  1
> +#define MGMT_MSG_CMD_OP_DEL  0
> +
>   static int hinic3_feature_nego(struct hinic3_hwdev *hwdev, u8 opcode,
>   			       u64 *s_feature, u16 size)
>   {
> @@ -57,6 +60,136 @@ bool hinic3_test_support(struct hinic3_nic_dev *nic_dev,
>   	return (nic_dev->nic_io->feature_cap & feature_bits) == feature_bits;
>   }
>   
> +static int hinic3_set_rx_lro(struct hinic3_hwdev *hwdev, u8 ipv4_en, u8 ipv6_en,
> +			     u8 lro_max_pkt_len)
> +{
> +	struct l2nic_cmd_lro_config lro_cfg = {};
> +	struct mgmt_msg_params msg_params = {};
> +	int err;
> +
> +	lro_cfg.func_id = hinic3_global_func_id(hwdev);
> +	lro_cfg.opcode = MGMT_MSG_CMD_OP_SET;
> +	lro_cfg.lro_ipv4_en = ipv4_en;
> +	lro_cfg.lro_ipv6_en = ipv6_en;
> +	lro_cfg.lro_max_pkt_len = lro_max_pkt_len;
> +
> +	mgmt_msg_params_init_default(&msg_params, &lro_cfg,
> +				     sizeof(lro_cfg));
> +
> +	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
> +				       L2NIC_CMD_CFG_RX_LRO,
> +				       &msg_params);
> +
> +	if (err || lro_cfg.msg_head.status) {
> +		dev_err(hwdev->dev, "Failed to set lro offload, err: %d, status: 0x%x\n",
> +			err, lro_cfg.msg_head.status);
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hinic3_set_rx_lro_timer(struct hinic3_hwdev *hwdev, u32 timer_value)
> +{
> +	struct l2nic_cmd_lro_timer lro_timer = {};
> +	struct mgmt_msg_params msg_params = {};
> +	int err;
> +
> +	lro_timer.opcode = MGMT_MSG_CMD_OP_SET;
> +	lro_timer.timer = timer_value;
> +
> +	mgmt_msg_params_init_default(&msg_params, &lro_timer,
> +				     sizeof(lro_timer));
> +
> +	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
> +				       L2NIC_CMD_CFG_LRO_TIMER,
> +				       &msg_params);
> +
> +	if (err || lro_timer.msg_head.status) {
> +		dev_err(hwdev->dev, "Failed to set lro timer, err: %d, status: 0x%x\n",
> +			err, lro_timer.msg_head.status);
> +
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +int hinic3_set_rx_lro_state(struct hinic3_hwdev *hwdev, u8 lro_en,
> +			    u32 lro_timer, u8 lro_max_pkt_len)
> +{
> +	u8 ipv4_en, ipv6_en;
> +	int err;
> +
> +	ipv4_en = lro_en ? 1 : 0;
> +	ipv6_en = lro_en ? 1 : 0;
> +
> +	dev_dbg(hwdev->dev, "Set LRO max coalesce packet size to %uK\n",
> +		lro_max_pkt_len);
> +
> +	err = hinic3_set_rx_lro(hwdev, ipv4_en, ipv6_en, lro_max_pkt_len);
> +	if (err)
> +		return err;
> +
> +	/* we don't set LRO timer for VF */
> +	if (HINIC3_IS_VF(hwdev))
> +		return 0;
> +
> +	dev_dbg(hwdev->dev, "Set LRO timer to %u\n", lro_timer);
> +
> +	return hinic3_set_rx_lro_timer(hwdev, lro_timer);
> +}
> +
> +int hinic3_set_rx_vlan_offload(struct hinic3_hwdev *hwdev, u8 en)
> +{
> +	struct l2nic_cmd_vlan_offload vlan_cfg = {};
> +	struct mgmt_msg_params msg_params = {};
> +	int err;
> +
> +	vlan_cfg.func_id = hinic3_global_func_id(hwdev);
> +	vlan_cfg.vlan_offload = en;
> +
> +	mgmt_msg_params_init_default(&msg_params, &vlan_cfg,
> +				     sizeof(vlan_cfg));
> +
> +	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
> +				       L2NIC_CMD_SET_RX_VLAN_OFFLOAD,
> +				       &msg_params);
> +
> +	if (err || vlan_cfg.msg_head.status) {
> +		dev_err(hwdev->dev, "Failed to set rx vlan offload, err: %d, status: 0x%x\n",
> +			err, vlan_cfg.msg_head.status);
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +int hinic3_set_vlan_fliter(struct hinic3_hwdev *hwdev, u32 vlan_filter_ctrl)

typo fliter -> filter

> +{
> +	struct l2nic_cmd_set_vlan_filter vlan_filter;
> +	struct mgmt_msg_params msg_params = {};
> +	int err;
> +
> +	vlan_filter.func_id = hinic3_global_func_id(hwdev);
> +	vlan_filter.vlan_filter_ctrl = vlan_filter_ctrl;
> +
> +	mgmt_msg_params_init_default(&msg_params, &vlan_filter,
> +				     sizeof(vlan_filter));
> +
> +	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
> +				       L2NIC_CMD_SET_VLAN_FILTER_EN,
> +				       &msg_params);
> +
> +	if (err || vlan_filter.msg_head.status) {
> +		dev_err(hwdev->dev, "Failed to set vlan filter, err: %d, status: 0x%x\n",
> +			err, vlan_filter.msg_head.status);
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
>   void hinic3_update_nic_feature(struct hinic3_nic_dev *nic_dev, u64 feature_cap)
>   {
>   	nic_dev->nic_io->feature_cap = feature_cap;
> @@ -366,6 +499,44 @@ int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev)
>   	return pkt_drop.msg_head.status;
>   }
>   
> +static int hinic3_config_vlan(struct hinic3_hwdev *hwdev,
> +			      u8 opcode, u16 vlan_id, u16 func_id)
> +{
> +	struct l2nic_cmd_vlan_config vlan_info = {};
> +	struct mgmt_msg_params msg_params = {};
> +	int err;
> +
> +	vlan_info.opcode = opcode;
> +	vlan_info.func_id = func_id;
> +	vlan_info.vlan_id = vlan_id;
> +
> +	mgmt_msg_params_init_default(&msg_params, &vlan_info,
> +				     sizeof(vlan_info));
> +
> +	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
> +				       L2NIC_CMD_CFG_FUNC_VLAN, &msg_params);
> +
> +	if (err || vlan_info.msg_head.status) {
> +		dev_err(hwdev->dev,
> +			"Failed to %s vlan, err: %d, status: 0x%x\n",
> +			opcode == MGMT_MSG_CMD_OP_ADD ? "add" : "delete",
> +			err, vlan_info.msg_head.status);
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +int hinic3_add_vlan(struct hinic3_hwdev *hwdev, u16 vlan_id, u16 func_id)
> +{
> +	return hinic3_config_vlan(hwdev, MGMT_MSG_CMD_OP_ADD, vlan_id, func_id);
> +}
> +
> +int hinic3_del_vlan(struct hinic3_hwdev *hwdev, u16 vlan_id, u16 func_id)
> +{
> +	return hinic3_config_vlan(hwdev, MGMT_MSG_CMD_OP_DEL, vlan_id, func_id);
> +}
> +
>   int hinic3_set_port_enable(struct hinic3_hwdev *hwdev, bool enable)
>   {
>   	struct mag_cmd_set_port_enable en_state = {};
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
> index d4326937db48..bb7c2a67dd4b 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
> @@ -57,6 +57,11 @@ bool hinic3_test_support(struct hinic3_nic_dev *nic_dev,
>   			 enum hinic3_nic_feature_cap feature_bits);
>   void hinic3_update_nic_feature(struct hinic3_nic_dev *nic_dev, u64 feature_cap);
>   
> +int hinic3_set_rx_lro_state(struct hinic3_hwdev *hwdev, u8 lro_en,
> +			    u32 lro_timer, u8 lro_max_pkt_len);
> +int hinic3_set_rx_vlan_offload(struct hinic3_hwdev *hwdev, u8 en);
> +int hinic3_set_vlan_fliter(struct hinic3_hwdev *hwdev, u32 vlan_filter_ctrl);
> +
>   int hinic3_init_function_table(struct hinic3_nic_dev *nic_dev);
>   int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu);
>   
> @@ -78,5 +83,7 @@ int hinic3_set_port_enable(struct hinic3_hwdev *hwdev, bool enable);
>   int hinic3_get_link_status(struct hinic3_hwdev *hwdev, bool *link_status_up);
>   int hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, u16 func_id,
>   			    bool enable);
> +int hinic3_add_vlan(struct hinic3_hwdev *hwdev, u16 vlan_id, u16 func_id);
> +int hinic3_del_vlan(struct hinic3_hwdev *hwdev, u16 vlan_id, u16 func_id);
>   
>   #endif
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> index 3a9f3ccdb684..b628294b375c 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> @@ -4,15 +4,42 @@
>   #ifndef _HINIC3_NIC_DEV_H_
>   #define _HINIC3_NIC_DEV_H_
>   
> +#include <linux/if_vlan.h>
>   #include <linux/netdevice.h>
>   
>   #include "hinic3_hw_cfg.h"
> +#include "hinic3_hwdev.h"
>   #include "hinic3_mgmt_interface.h"
>   
> +#define HINIC3_VLAN_BITMAP_BYTE_SIZE(nic_dev)  (sizeof(*(nic_dev)->vlan_bitmap))
> +#define HINIC3_VLAN_BITMAP_SIZE(nic_dev)  \
> +	(VLAN_N_VID / HINIC3_VLAN_BITMAP_BYTE_SIZE(nic_dev))
> +#define HINIC3_MODERATONE_DELAY  HZ

HINIC3_MODERATONE_DELAY -> HINIC3_MODERATION_DELAY

> +
>   enum hinic3_flags {
>   	HINIC3_RSS_ENABLE,
>   };
>   
> +enum hinic3_event_work_flags {
> +	HINIC3_EVENT_WORK_TX_TIMEOUT,
> +};
> +
> +#define HINIC3_NIC_STATS_INC(nic_dev, field) \
> +do { \
> +	u64_stats_update_begin(&(nic_dev)->stats.syncp); \
> +	(nic_dev)->stats.field++; \
> +	u64_stats_update_end(&(nic_dev)->stats.syncp); \
> +} while (0)
> +
> +struct hinic3_nic_stats {
> +	u64                   netdev_tx_timeout;
> +
> +	/* Subdivision statistics show in private tool */
> +	u64                   tx_carrier_off_drop;
> +	u64                   tx_invalid_qid;
> +	struct u64_stats_sync syncp;
> +};
> +
>   enum hinic3_rss_hash_type {
>   	HINIC3_RSS_HASH_ENGINE_TYPE_XOR  = 0,
>   	HINIC3_RSS_HASH_ENGINE_TYPE_TOEP = 1,
> @@ -55,6 +82,15 @@ struct hinic3_intr_coal_info {
>   	u8 pending_limit;
>   	u8 coalesce_timer_cfg;
>   	u8 resend_timer_cfg;
> +
> +	u64 pkt_rate_low;
> +	u8  rx_usecs_low;
> +	u8  rx_pending_limit_low;
> +	u64 pkt_rate_high;
> +	u8  rx_usecs_high;
> +	u8  rx_pending_limit_high;
> +
> +	u8  user_set_intr_coal_flag;
>   };
>   
>   struct hinic3_nic_dev {
> @@ -66,12 +102,14 @@ struct hinic3_nic_dev {
>   	u16                             max_qps;
>   	u16                             rx_buf_len;
>   	u32                             lro_replenish_thld;
> +	unsigned long                   *vlan_bitmap;
>   	unsigned long                   flags;
>   	struct hinic3_nic_service_cap   nic_svc_cap;
>   
>   	struct hinic3_dyna_txrxq_params q_params;
>   	struct hinic3_txq               *txqs;
>   	struct hinic3_rxq               *rxqs;
> +	struct hinic3_nic_stats         stats;
>   
>   	enum hinic3_rss_hash_type       rss_hash_type;
>   	struct hinic3_rss_type          rss_type;
> @@ -82,13 +120,20 @@ struct hinic3_nic_dev {
>   	struct msix_entry               *qps_msix_entries;
>   
>   	struct hinic3_intr_coal_info    *intr_coalesce;
> +	unsigned long                   last_moder_jiffies;
>   
> +	struct workqueue_struct         *workq;
> +	struct delayed_work             periodic_work;
> +	struct delayed_work             moderation_task;
>   	struct semaphore                port_state_sem;
>   
> +	/* flag bits defined by hinic3_event_work_flags */
> +	unsigned long                   event_flag;
>   	bool                            link_status_up;
>   };
>   
>   void hinic3_set_netdev_ops(struct net_device *netdev);
> +int hinic3_set_hw_features(struct net_device *netdev);
>   int hinic3_qps_irq_init(struct net_device *netdev);
>   void hinic3_qps_irq_uninit(struct net_device *netdev);
>   
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
> index 44ae841a3648..9ab9fa03d80b 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
> @@ -25,6 +25,20 @@
>   #define RQ_CQE_STATUS_GET(val, member) \
>   	FIELD_GET(RQ_CQE_STATUS_##member##_MASK, val)
>   
> +struct hinic3_rxq_stats {
> +	u64                   packets;
> +	u64                   bytes;
> +	u64                   errors;
> +	u64                   csum_errors;
> +	u64                   other_errors;
> +	u64                   dropped;
> +	u64                   rx_buf_empty;
> +	u64                   alloc_skb_err;
> +	u64                   alloc_rx_buf_err;
> +	u64                   restore_drop_sge;
> +	struct u64_stats_sync syncp;
> +};
> +
>   /* RX Completion information that is provided by HW for a specific RX WQE */
>   struct hinic3_rq_cqe {
>   	__le32 status;
> @@ -59,6 +73,7 @@ struct hinic3_rxq {
>   	u16                     buf_len;
>   	u32                     buf_len_shift;
>   
> +	struct hinic3_rxq_stats rxq_stats;
>   	u32                     cons_idx;
>   	u32                     delta;
>   
> @@ -80,6 +95,11 @@ struct hinic3_rxq {
>   	struct device          *dev; /* device for DMA mapping */
>   
>   	dma_addr_t             cqe_start_paddr;
> +
> +	u64                    last_moder_packets;
> +	u64                    last_moder_bytes;
> +	u8                     last_coalesc_timer_cfg;
> +	u8                     last_pending_limit;
>   } ____cacheline_aligned;
>   
>   struct hinic3_dyna_rxq_res {
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
> index 7e1b872ba752..7df7f3fe8061 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
> @@ -100,6 +100,20 @@ struct hinic3_sq_wqe_combo {
>   	u32                       task_type;
>   };
>   
> +struct hinic3_txq_stats {
> +	u64                   packets;
> +	u64                   bytes;
> +	u64                   busy;
> +	u64                   dropped;
> +	u64                   skb_pad_err;
> +	u64                   frag_len_overflow;
> +	u64                   offload_cow_skb_err;
> +	u64                   map_frag_err;
> +	u64                   unknown_tunnel_pkt;
> +	u64                   frag_size_err;
> +	struct u64_stats_sync syncp;
> +};
> +
>   struct hinic3_dma_info {
>   	dma_addr_t dma;
>   	u32        len;
> @@ -123,6 +137,10 @@ struct hinic3_txq {
>   
>   	struct hinic3_tx_info   *tx_info;
>   	struct hinic3_io_queue  *sq;
> +
> +	struct hinic3_txq_stats txq_stats;
> +	u64                     last_moder_packets;
> +	u64                     last_moder_bytes;
>   } ____cacheline_aligned;
>   
>   struct hinic3_dyna_txq_res {

Thanks,
Alok


