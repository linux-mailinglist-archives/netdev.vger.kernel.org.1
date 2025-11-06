Return-Path: <netdev+bounces-236500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2574C3D452
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 20:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C9B189298E
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 19:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8D8340DA6;
	Thu,  6 Nov 2025 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X4Pe49du";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t+SsKTqK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B004F184;
	Thu,  6 Nov 2025 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762458336; cv=fail; b=HL3F3O5NaSCKdN3t0aL9FW7lNdP6G35Po2uVjbkVrAYzB0xK4Kllho142stRlNLq2ee3BEXOj+sUfy4ZoQ0UWvDNGC1vDdVKsnYOGIOmOx0/UbOxhvERBONTR2ObaH2ldxNMhiIHJYXUHqXI5DySR4Z+h6Ik2WVHEHfRZMmXUgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762458336; c=relaxed/simple;
	bh=VojV19zMvGyzBfSNo2lk0rWZdoiE0NCxoFDhHCOt+D8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cAKX5PqJMKohPmD7q5olBsuQRJoC6XjWvgoLPQRJhjIk5+HygvG2+vezHkasEg+M5pA83sXqlolc1iVOD+JzpihIsZlMYECFeaEhl2eQXCz1RwQwmQIsjxy6FtxUnqAFl3LES6JVRIbq2DuPFlCof1IXdtTBC1FhJN16wFhsu2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X4Pe49du; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t+SsKTqK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6IgXm2001196;
	Thu, 6 Nov 2025 19:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=K/hhOW9BDKWbnA8VyGKFg3+GkhBw5IjUyG0CVnnoc3U=; b=
	X4Pe49duKIGjV5SuKTMEd7TMlnNzNWnjR3wiVHkDqi4K3X7NffOEnwhmetQcsRTp
	edRjjiJ6olDnJ1w12410YMCzNQDyR7Rarm1tAuFAa4pFKPfmXRDjUv0pEKkEO7JO
	SME8pQuSFwi3VKF8YUIMDQz2JIgEppFFqQTKVEtNalk9nlbNnVhn5ijtBsaG4VL6
	alw7gmhVJuSiWq1joQImrJhy8QXr6AP0Uzgmy4426RJzcK20L0GNi6VLW0ExAMUF
	vPJDktuLkQdD2/pzNNwY3Kf3ovoBFgSoeQkXtU+UA/9Qgf+arjM6mWtad+Gn0Ne2
	HIOcrQfC12oC5BNOjLHZXA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8yhj8d69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 19:44:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6HuCJL039452;
	Thu, 6 Nov 2025 19:44:47 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ncknp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 19:44:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoUFUFJ4xPuNtxBCO9jQCB5mlJzXlrbCv1sUC6eN3n59c2ZdijYjAqft4UhRfVjsLW9ut4+GWRF39+PhuwOHB94rKH9isxrXxm/4itGANeqk3QlIlK/Qvae4F/UOfbXe/usHaSjiIWPKshNoSXzILu6OS9Dz7+2kV9grCtpEK2tglyEclqt9IutVu0wG+WAFMkMxHNFqT073WhPkvYpxW2hPuaCj/EX9lrZK8sPUgMLrCG5g6HExB75QkZw8w2pt+uVH3COuUDdb3h11mIyDk1U2PAODJwBCP1OqUwFAh0/2lYAxEmYS26atPvuD/dfCWylN2W5pZLnjGMGDT7JGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/hhOW9BDKWbnA8VyGKFg3+GkhBw5IjUyG0CVnnoc3U=;
 b=nP6n8L8rQRpzcE2Bt4o/PkoG5o25OmvFJlDbTv2V7zts/4CaR5lBIeAiItWp7MK4H63c7BTt4yHiufBXTC9wTHctrFt4ST15zqzjLP8zWUdPmaMXz78yfgN5TIMgl4wCSKoYW1ZC3NVROrYtlHtEOsaZCc12ShAMNkNKpIP8aLCfr0PoueTMFPqpmkFVIffgp00JApa953b7Tkcn+QNeYIz6WT+IWL2fvoL0GPg9cvctII7Ex79mLvWzwl5PfQ2lOG0elOLxdKivsi1cMriU6QfGuvb//uw4N2HRTLobO2x+82GWqobxDsZflkG2Yjw57cgim4m9c2N07w3v86LYZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/hhOW9BDKWbnA8VyGKFg3+GkhBw5IjUyG0CVnnoc3U=;
 b=t+SsKTqKqgkOX1Pf6jkYc7SfoN8iEFl6EJe5/Hw8AviLYOg/qWuU7XpsqALzNdyu8Vlh7XlBZbbou4oVUZS5epYgM2qJ4x3jeT+SMA704WXMNxL8TxQzh4gomJqE8MXp71IBfMBSGjcyzUDMbfMbUFQkfxNHvx3tuDYEJBZVeWU=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH8PR10MB6526.namprd10.prod.outlook.com (2603:10b6:510:22a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 19:44:43 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9253.017; Thu, 6 Nov 2025
 19:44:43 +0000
Message-ID: <01ac3610-02eb-4a0e-b463-67548d2e02c2@oracle.com>
Date: Fri, 7 Nov 2025 01:14:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH net-next v05 4/5] hinic3: Add mac filter ops
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
 <02644ad18839feb50582ec8cd05830a4882517d4.1762414088.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <02644ad18839feb50582ec8cd05830a4882517d4.1762414088.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0386.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::14) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH8PR10MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 153e800e-2a52-4b78-bc1f-08de1d6ceebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVp2S2llcEloK1p3Tno4YkVRVE1CMmo3YUZCWVI1U1phOFZlNGc1U3Qydnln?=
 =?utf-8?B?SGZ3N1Y5VFpXbmMzUThIN0ZYd1dMVFptS2RYMHk2ZllWeU5aa0VVQ0tHQzcw?=
 =?utf-8?B?S2hybHZKSS9rUHAzMEZMb25IcDVHUDNDYjVEUEVWSmFyNms5UmYxTTAwT0lD?=
 =?utf-8?B?RmFyZlVHelhsQlhqRXVoeFpmLys3V25iR2JpenI2ekF3bFFrdlRMa1RyNnJG?=
 =?utf-8?B?WFdENytTTDdzL3JySGN0VHIxQUFOampmRFlNbFFiYXNEUER5dHBhaGdzTDJT?=
 =?utf-8?B?dTlPWU5WL0xxZDRkT3JSb1hvcjBHVjJzNFpYc0tmVTlyVEJtTXJXTVVETDI0?=
 =?utf-8?B?SEM4VGlxWEdlQnl2ZWNLRTFOUEF4V1BMQUxCS1dCUzBrSlhpQ3BnOCtzd0Rl?=
 =?utf-8?B?Q0RpVytxSHNxOTkxY3lMbHZkcjJQa1gwRlRlcklYQWJKNjUraFlLVWcwSk9l?=
 =?utf-8?B?OUw1VDJOd1lLNGkwMkw5bWZ0bkFWRWxNK0dnZWlmaWlKSmNrNnJPM3g3TU1p?=
 =?utf-8?B?bjNDRWpJTXJwY3Uva3NueE1OblR5aTBSRjMraDNjU0xXM1hrbWZiNWhzc1ZM?=
 =?utf-8?B?QWRuM3cyeTJtUFg4V2dQaU5qbXJnSUhpNkEvZHE0TUVzMVhDNnpwbmRlc3Az?=
 =?utf-8?B?QnBGSFBkcVVocXBOdUJMZXNtMWk0YjJSY1NvZXczOWI3QXdvUzFkRCtPcUJ3?=
 =?utf-8?B?bHJlb0F3c3A1dlE1d2pESzNCQ0Y0a3JtT1loZDZKRE1SRlVxUytiWEN6N0Rl?=
 =?utf-8?B?ZStPZ0tHMFFubDQ2cVlhTXdGSGRkNWh4WFR6SDFuNThCL0hnV1BCQ09CLzZP?=
 =?utf-8?B?QkFleVVDU09ucnQzSllCUUdoM2NVaTgzZTlnMzdaaXdOaDRDOWVsN21DaFJw?=
 =?utf-8?B?R0VJdHJ3VUtEZHJaVnp6OEQyQVBpVE15MyszUHpQVnN2VE1qSjBEU21SdWV4?=
 =?utf-8?B?U3lRMTZjdnB3UTRXaTQ2dkFuVlJZS24zWmFId3FuTFlIaml5aXYrM0lPQTk1?=
 =?utf-8?B?S3QrU2NtU0x5TWxTRkpTQkRkZVZxUWkzNGI5a2dNbmhNWVFOSG1xZ3UyR05F?=
 =?utf-8?B?T3VtU3dnM2V0SCtEMi96SEdMRjlBczNTQXhKSlBmM1pOOUwyUWZFTHZpU1Fw?=
 =?utf-8?B?YkhPK3UxdGw3UFo1ejN1RVpWc1NFOFZLZC9NN3BwUDVYd2FMeEo1ZnFSYXpw?=
 =?utf-8?B?amNwMnZoMTd2cFNQSUg3dCswcXBQcDkra05DOXVzVUhTVDRlMlNzZFgwWWUw?=
 =?utf-8?B?cEVqbWZjMW9UUU8zOXNkSlYyb3ByVkRZUnpNSkNWVmN6NUxtOTJrRE00NFh2?=
 =?utf-8?B?TDh5S3ZDTWlZcXZSSDZlQkErRWt4MmtPUFF2aGhWRTRuQzBtWStUNFNpN3V1?=
 =?utf-8?B?QktnMXgrOE9zUUJyUFZEbTErc0s5OW5rZFkzQjU4TzZHODRJTVRLK1ZhWm5z?=
 =?utf-8?B?Y1BGaVZqQWxoSDczem5vVFdWcitPSVljb1pNMzZRbnY0b1QzeFZNdHFyRHAy?=
 =?utf-8?B?M1QyS0FWZnZ6U3IzNUVVUzd1bHUyb0M4UjB4dlRvYUU5U09mOTFZTDNMWStp?=
 =?utf-8?B?MmtzR3hLSFQyR3M1b0cxbUsySjBzQ1JzaTR2b20vSlY0RFp2VS9qR0hWNnZY?=
 =?utf-8?B?L0E5YUdrNFA1NlBVaktjWi9HUi8wRkhzOXgzZTI5ZFZ5dFZkZW93VjI0bndQ?=
 =?utf-8?B?V3djL1h0amdWMmk3NU41bDR5TldQQnppMmpsYnFzS1czOGVrbmRtN1ZGZ0E3?=
 =?utf-8?B?SjJCUWgwakwrSTdvc3RYSnZpV2gxT0xpUEIrNmRoQ3JiL1UwNm53V01XQVdl?=
 =?utf-8?B?VFFMT0FaY0VMZVZFMjdZMUtvYnlVZHQ1Y2lZRUFhYmdpZEhNejl5bzVGMXBQ?=
 =?utf-8?B?aG5mWDdrUDdqTmo3Qng1b1RIb0VoQ2tqeFp6VWlld05PblA3TE5LM1lRY3lh?=
 =?utf-8?B?cVQ2aGxiRkZjN0pJRGxQdjNTbm1UUCtVVGtDUHprQ1A1ZUhySU5nTElVcW42?=
 =?utf-8?Q?RQBm0561pgpQZuTUpJggHuByaLdJJg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QURrRmdUSFVYVVRZZElvOFJNeTFJVkh2SnNHYU9QQXpUeU9sMm5EWUpMUis2?=
 =?utf-8?B?VUlXUWdGSkVEd1hSTFJEMCtnVkFXQ3lSZlVMRW1OMmMwUzJwUFVPMElqVXds?=
 =?utf-8?B?VEFIRnVQRE9yV0JZS3czUG1TWG5xckJsMFZ3NWhxc2xhUzU2MVExQnNjQmI5?=
 =?utf-8?B?NGkzV3V5UFpTeFFvVmI5b29haUgzc1RJNzZEbEd1cVNwQ0M4bUhiTW5FWnRO?=
 =?utf-8?B?d1h1RWxIRmpJb01YNm94TGd6U2ozYnUzVWlkSVlPaGJucXEzYWZYdnRtRFdy?=
 =?utf-8?B?S3ZoRkdKdjRwRmdjQWI3bStYVVR3YkhPUkM5dFQzZjJnOThXNjVsYXd5Yzkw?=
 =?utf-8?B?OFl0cVVmZEhDQXNyRURQTjdveGtIeW0zVDROUUpxMVdaS3pqUStnNWZIMi9B?=
 =?utf-8?B?a3R5UVc4RHlZSytJNTRwUWw2SnZ3TVFPQjQ1dkh6Nk5oenBrRmMwMTA1d3dz?=
 =?utf-8?B?UUh6dTRRVTVzN1BpRVhGUmxIdXYrTmFBL0J0b2hQMDVSUGFiclRIR2p5elVZ?=
 =?utf-8?B?YnRHNGlQbitSVkxhUWpVYllySTA2TDlFMEhiRVBYTzFVSGFVVDQ1aEprMUhM?=
 =?utf-8?B?WVNZUnh0L2pMZ1htWmdLTWFZdjZEM25lR0FmSS8wa0M0ZDV0cWorZzh6VDJG?=
 =?utf-8?B?eHl1Q3g2TXc4dnFNcDJRVFpTWjJDWVF1R3NHczBpZ0pyTWtvQm1MKzNQdnl1?=
 =?utf-8?B?b01Scm9yNmU1TDlxRklrUk5uNW5pbXZrVXpKTS9Fd3h2SnZlU2hmU0lsT3lX?=
 =?utf-8?B?T3NMVFc0dHJhR1RjOTl0bmhTNG9KQ3hQbzFTU1lXcjR5TzNDYUR1SHNRWG1K?=
 =?utf-8?B?SlRaRzZSdXg1YlJLSElzWGFYUzFMcE80akJKanhGZ1MvRXR1Ynk1Qm9HUDVE?=
 =?utf-8?B?bnlpZlluWkM4WkpScE4zVSs5TnE2Rm04cEN0aUhzSFY0dHRhdlJuMkZPWGd1?=
 =?utf-8?B?Yk5veGF0TFV0MnpJbkxuMGdjbUMyeUVYOHJWeFRjd3ZhNHlqSHk0emVmbzh1?=
 =?utf-8?B?bGZORVp2WU4zZU95aWhaeGhDdUF3NjlnY3FKRW81SUUzd2RNZkR2QkR4VGVE?=
 =?utf-8?B?OElBVlUycDNOaEFQc0t4eG83N0FiYXEyMzlqT3MwbGg4dHNnS3JlQmk4bFdJ?=
 =?utf-8?B?UVU4T2ZmTkR5b2prbnF4bHdnSFY3SGxrVHJqSWEyb2pHbi9LdmxQVFVrQVpK?=
 =?utf-8?B?dlI5NnJndktDVnhCNGEwWWxlSkJkWHdyS1lXSy94Z2N6aDErb1JxajhxQXpp?=
 =?utf-8?B?L3RnWS81bGJZNXhQZWVtUHV3aEljTGJGdHVXaUVvOThDMm9aU0RNRTBaRFJT?=
 =?utf-8?B?emtkQzNlMU43am42RlNGMmdmNkVoN0JYc1NtcjBHZnFJdGNkc2xHaDZHYVF1?=
 =?utf-8?B?bjUrSkNIWFBNV255VEx1cTVEZVlwNkpNQVE5cU5nTDRlQmJTRkJMYjF2cktP?=
 =?utf-8?B?ZG45cnVTWm53ZHpWZzRKeWJYeUNHVFB4VnoydTNxZWtxeDk5VXY4aDlZcGU4?=
 =?utf-8?B?d2ZnL3VZcHpBcDBrdGxRZkc3bHdFTjNiYUhyUFF1N3pCRFhOckJrS3dOT2x6?=
 =?utf-8?B?SWRvb1ZXeHdNajhiR3RiNC8xT0lmRFIwTHpuOGZFcVByTnBub21BdmFsV1RS?=
 =?utf-8?B?UTVsVUFOYytKajNwdzU0Q0pTbzYzMXl2QnpreXhUZzFiOTd3ZWY4YWZTc3NV?=
 =?utf-8?B?RE9FZzV3VW5MTmFmYlNRQXBlTEJaaWZubXI0bVpFOEVsMHJUWGRmTys3SUQ2?=
 =?utf-8?B?c1NGOG10QThrWEhUeVBuSm1EMzhQelorVkNaenZDOExGZkxxbDQ5ZEgyWUxs?=
 =?utf-8?B?V2V0aXlHQnpodmlYazdVQ0xPQm5za3V0K0VMTTBpcGljREhYeUZOd2M5K2Ry?=
 =?utf-8?B?RnN3aTBDczFmQkhIVnQ2Y2pkSnBrb29aenU0TGMwTDJwc1dzTXE0bHcvUEJr?=
 =?utf-8?B?ZGl0WU1adlREc0FtMTdkTENRc2txOUVqMk1nOVdodWlidk1qYnJ1MlBHQUFz?=
 =?utf-8?B?dmx4SG81cTlFVVJadXhPRmpwcFRNWkNFcnhWcmR6eXdDcnFGTWtFbFYzcGV0?=
 =?utf-8?B?TkV2Qkw2S2dMcFF3WHU2OVNOU25wSmlSRzArVEx5OVJZMk9yWnZJdm5WQWN3?=
 =?utf-8?B?emdGUXpwSkhSSjlZU3ZhVi9OcENQYVlrRHhFUHgyMW4yNUpRVVB0MjRLb3ZT?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YXhtYh28LoJ9RWBQ2RjX5hDFnC6QN6SIKVab3Su0GdJAV3cR9teWMTJesYuWc/ugP9zsNaRgcdEtgCWTJTDvixVwEor+vcvvoUs2Sco+KVQ55f8y1H988LSyQerPpW3DK9/PnYtuWPEmT4a3MXj2P0vk5uTwKXPMZrWXW7s+kpA52DpvCk8wtgWETvWH+xAra54YPV50ZhefZ7eFzVPO7sEZaHa41dj9NPJcGMAksHqGOHy3RoderzXzM5NVxMEUVhwHm4oK2ZxxFiJw3oja96IhgyO54i43bENM2/ZIydpErezp58iVvq4gscNMTqf1U9QZvq1CyLVJnXwh4cwegO7MLtz5S9pOU6dMGDVWf6rFRUlbuDx7miGDygfxbeAvEURTQ1WZT4NMWXgeaIlH60+MIRzMfmaB/zlNwB5rLJVb7akaGYiSA/B2igFZbfh0ad9iLT6GyjehdsJ+BvE2t4w0KfUqbaBBh76IxSGGMFCVVjTWTprzY10SQeRTPm+maQLExCbPUrDhOK6wMjl9u4LqMU45Fx1mNlnYAAPPYcTFaWnHcCVkgnvX+4oFZvOeeIA9dxTfjMg/Cr47fl9FGRJX2LkE5fZE+00SWFC61jo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153e800e-2a52-4b78-bc1f-08de1d6ceebe
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 19:44:43.4397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9mQGNzDiiY3EHyiIPOSKgjP9GFu8Do1kP4QWk/XbEHiBd1aBRzZLmCm0xuHr9UT8uQ8haWBxO46lGtaLp9vsOTGotAUPfVHlAhKtHnHQH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6526
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060161
X-Proofpoint-ORIG-GUID: pjjUUC3qgPDnNi8c6M6mvUjAh46iQtx1
X-Proofpoint-GUID: pjjUUC3qgPDnNi8c6M6mvUjAh46iQtx1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzNSBTYWx0ZWRfX5Q7hBtD/xZxz
 gjiWR9uzEKrMVjUSGIBaNA+YDTso2NlbJPn+YDbD4PYzU7EzGfSerk+zO7PU6+TnpmgLyFakDW7
 aFBQdK2+irQFOekMFHFOmZfGeyAG0McKyraHlJwHadCYayfWaEG2zWgDCBqt0fxTl1a9TMcLnrZ
 OSsh6MiSAay2IpxdVyTJKeqTPiHbvAIQO5Rlk3f20MZpj7HK1eaQPqInDv0rjctt2B/V7BAk/Q8
 hM5hITiumxHJ42hJPSGAic9+PKhQcgU9IZJrtbpe37sOAGqHDt+CPjPJ/2cSpFxoAA9Bpns2CYB
 KujYIPKXjvq1bUKEQvTQoqLtFwAeenv/xIQLL5mnXU7rKyErkoFpFVMgagEu5fPBlzJS4glzZIZ
 ROuXWHSTdj/fYJdSjBEjyYifzOFUFw==
X-Authority-Analysis: v=2.4 cv=Lr+fC3dc c=1 sm=1 tr=0 ts=690cfab0 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7uoXELoAAAA:8 a=i0EeH86SAAAA:8 a=mXwQa6XB-DnZL7NOKPsA:9 a=QEXdDO2ut3YA:10
 a=07tN73Fy-TQQJT60VmHH:22 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22



On 11/6/2025 4:45 PM, Fan Gong wrote:
> Add ops to support unicast and multicast to filter mac address and
> forward packages.

packages ->

> 
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---
>   drivers/net/ethernet/huawei/hinic3/Makefile   |   1 +
>   .../ethernet/huawei/hinic3/hinic3_filter.c    | 418 ++++++++++++++++++
>   .../net/ethernet/huawei/hinic3/hinic3_main.c  |   6 +
>   .../huawei/hinic3/hinic3_mgmt_interface.h     |  17 +
>   .../huawei/hinic3/hinic3_netdev_ops.c         |  15 +
>   .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  24 +
>   .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |   1 +
>   .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  33 ++
>   8 files changed, 515 insertions(+)
> +
> +void hinic3_clean_mac_list_filter(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_mac_filter *ftmp;
> +	struct hinic3_mac_filter *f;
> +
> +	list_for_each_entry_safe(f, ftmp, &nic_dev->uc_filter_list, list) {
> +		if (f->state == HINIC3_MAC_HW_SYNCED)
> +			hinic3_uc_unsync(netdev, f->addr);
> +		list_del(&f->list);
> +		kfree(f);
> +	}
> +
> +	list_for_each_entry_safe(f, ftmp, &nic_dev->mc_filter_list, list) {

hinic3_uc_unsync() for both UC and MC lists.

> +		if (f->state == HINIC3_MAC_HW_SYNCED)
> +			hinic3_uc_unsync(netdev, f->addr);
> +		list_del(&f->list);
> +		kfree(f);
> +	}
> +}
> +
> +static struct hinic3_mac_filter *
> +hinic3_find_mac(const struct list_head *filter_list, u8 *addr)
> +{
> +	struct hinic3_mac_filter *f;
> +
> +	list_for_each_entry(f, filter_list, list) {
> +		if (ether_addr_equal(addr, f->addr))
> +			return f;
> +	}
> +	return NULL;
> +}
> +
> +static int hinic3_mac_filter_sync(struct net_device *netdev,
> +				  struct list_head *mac_filter_list, bool uc)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct list_head tmp_del_list, tmp_add_list;
> +	int err = 0, add_list_len = 0, add_count;
> +	struct hinic3_mac_filter *fclone;
> +	struct hinic3_mac_filter *ftmp;
> +	struct hinic3_mac_filter *f;
> +
> +	INIT_LIST_HEAD(&tmp_del_list);
> +	INIT_LIST_HEAD(&tmp_add_list);
> +
> +	list_for_each_entry_safe(f, ftmp, mac_filter_list, list) {
> +		if (f->state != HINIC3_MAC_WAIT_HW_UNSYNC)
> +			continue;
> +
> +		f->state = HINIC3_MAC_HW_UNSYNCED;
> +		list_move_tail(&f->list, &tmp_del_list);
> +	}
> +
> +	list_for_each_entry_safe(f, ftmp, mac_filter_list, list) {
> +		if (f->state != HINIC3_MAC_WAIT_HW_SYNC)
> +			continue;
> +
> +		fclone = hinic3_mac_filter_entry_clone(f);
> +		if (!fclone) {
> +			hinic3_undo_del_filter_entries(mac_filter_list,
> +						       &tmp_del_list);
> +			hinic3_undo_add_filter_entries(mac_filter_list,
> +						       &tmp_add_list);
> +
> +			netdev_err(netdev,
> +				   "Failed to clone mac_filter_entry\n");
> +			err = -ENOMEM;
> +			goto cleanup_tmp_filter_list;
> +		}
> +
> +		f->state = HINIC3_MAC_HW_SYNCING;
> +		list_add_tail(&fclone->list, &tmp_add_list);
> +		add_list_len++;
> +	}
> +
> +	add_count = hinic3_mac_filter_sync_hw(netdev, &tmp_del_list,
> +					      &tmp_add_list);

this could return a -error; if hinic3_set_mac fail

> +	if (add_count < add_list_len) {
> +		/* there were errors, delete all mac in hw */
> +		hinic3_undo_add_filter_entries(mac_filter_list, &tmp_add_list);
> +		/* VF does not support promiscuous mode,
> +		 * don't delete any other uc mac.
> +		 */
> +		if (!HINIC3_IS_VF(nic_dev->hwdev) || !uc) {
> +			list_for_each_entry_safe(f, ftmp, mac_filter_list,
> +						 list) {
> +				if (f->state != HINIC3_MAC_HW_SYNCED)
> +					continue;
> +
> +				fclone = hinic3_mac_filter_entry_clone(f);
> +				if (!fclone)
> +					break;
> +
> +				f->state = HINIC3_MAC_HW_SYNCING;
> +				list_add_tail(&fclone->list, &tmp_del_list);
> +			}
> +		}
> +
> +		hinic3_mac_filter_sync_hw(netdev, &tmp_del_list, &tmp_add_list);
> +
> +		/* need to enter promiscuous/allmulti mode */
> +		err = -ENOMEM;
> +	}
> +
> +cleanup_tmp_filter_list:
> +	hinic3_cleanup_filter_list(&tmp_del_list);
> +	hinic3_cleanup_filter_list(&tmp_add_list);
> +
> +	return err ? err : add_count;
> +}
> +
> +static void hinic3_mac_filter_sync_all(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	int add_count;
> +
> +	if (test_bit(HINIC3_MAC_FILTER_CHANGED, &nic_dev->flags)) {
> +		clear_bit(HINIC3_MAC_FILTER_CHANGED, &nic_dev->flags);
> +		add_count = hinic3_mac_filter_sync(netdev,
> +						   &nic_dev->uc_filter_list,
> +						   true);
> +		if (add_count < 0 &&
> +		    hinic3_test_support(nic_dev, HINIC3_NIC_F_PROMISC))
> +			set_bit(HINIC3_PROMISC_FORCE_ON,
> +				&nic_dev->rx_mod_state);
> +		else if (add_count)
> +			clear_bit(HINIC3_PROMISC_FORCE_ON,
> +				  &nic_dev->rx_mod_state);
> +
> +		add_count = hinic3_mac_filter_sync(netdev,
> +						   &nic_dev->mc_filter_list,
> +						   false);
> +		if (add_count < 0 &&
> +		    hinic3_test_support(nic_dev, HINIC3_NIC_F_ALLMULTI))
> +			set_bit(HINIC3_ALLMULTI_FORCE_ON,
> +				&nic_dev->rx_mod_state);
> +		else if (add_count)
> +			clear_bit(HINIC3_ALLMULTI_FORCE_ON,
> +				  &nic_dev->rx_mod_state);
> +	}
> +}
> +
> +#define HINIC3_DEFAULT_RX_MODE \
> +	(L2NIC_RX_MODE_UC | L2NIC_RX_MODE_MC | L2NIC_RX_MODE_BC)
> +
> +static void hinic3_update_mac_filter(struct net_device *netdev,
> +				     const struct netdev_hw_addr_list *src_list,
> +				     struct list_head *filter_list)
> +{
> +	struct hinic3_mac_filter *filter;
> +	struct hinic3_mac_filter *ftmp;
> +	struct hinic3_mac_filter *f;
> +	struct netdev_hw_addr *ha;
> +
> +	/* add addr if not already in the filter list */
> +	netif_addr_lock_bh(netdev);
> +	netdev_hw_addr_list_for_each(ha, src_list) {
> +		filter = hinic3_find_mac(filter_list, ha->addr);
> +		if (!filter)
> +			hinic3_add_filter(netdev, filter_list, ha->addr);
> +		else if (filter->state == HINIC3_MAC_WAIT_HW_UNSYNC)
> +			filter->state = HINIC3_MAC_HW_SYNCED;
> +	}
> +	netif_addr_unlock_bh(netdev);
> +
> +	/* delete addr if not in netdev list */
> +	list_for_each_entry_safe(f, ftmp, filter_list, list) {
> +		bool found = false;
> +
> +		netif_addr_lock_bh(netdev);
> +		netdev_hw_addr_list_for_each(ha, src_list)
> +			if (ether_addr_equal(ha->addr, f->addr)) {
> +				found = true;
> +				break;
> +			}
> +		netif_addr_unlock_bh(netdev);
> +
> +		if (found)
> +			continue;
> +
> +		hinic3_del_filter(netdev, f);
> +	}
> +}
> +
> +static void hinic3_sync_rx_mode_to_hw(struct net_device *netdev, int promisc_en,
> +				      int allmulti_en)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	u32 rx_mod = HINIC3_DEFAULT_RX_MODE;
> +	int err;
> +
> +	rx_mod |= (promisc_en ? L2NIC_RX_MODE_PROMISC : 0);
> +	rx_mod |= (allmulti_en ? L2NIC_RX_MODE_MC_ALL : 0);
> +
> +	if (promisc_en != test_bit(HINIC3_HW_PROMISC_ON,
> +				   &nic_dev->rx_mod_state))
> +		netdev_dbg(netdev, "%s promisc mode\n",
> +			   promisc_en ? "Enter" : "Left");
> +	if (allmulti_en !=
> +	    test_bit(HINIC3_HW_ALLMULTI_ON, &nic_dev->rx_mod_state))
> +		netdev_dbg(netdev, "%s all_multi mode\n",
> +			   allmulti_en ? "Enter" : "Left");
> +
> +	err = hinic3_set_rx_mode(nic_dev->hwdev, rx_mod);
> +	if (err) {
> +		netdev_err(netdev, "Failed to set rx_mode\n");
> +		return;
> +	}
> +
> +	promisc_en ? set_bit(HINIC3_HW_PROMISC_ON, &nic_dev->rx_mod_state) :
> +		clear_bit(HINIC3_HW_PROMISC_ON, &nic_dev->rx_mod_state);
> +
> +	allmulti_en ? set_bit(HINIC3_HW_ALLMULTI_ON, &nic_dev->rx_mod_state) :
> +		clear_bit(HINIC3_HW_ALLMULTI_ON, &nic_dev->rx_mod_state);
> +}
> +
> +void hinic3_set_rx_mode_work(struct work_struct *work)
> +{
> +	int promisc_en = 0, allmulti_en = 0;
> +	struct hinic3_nic_dev *nic_dev;
> +	struct net_device *netdev;
> +
> +	nic_dev = container_of(work, struct hinic3_nic_dev, rx_mode_work);
> +	netdev = nic_dev->netdev;
> +
> +	if (test_and_clear_bit(HINIC3_UPDATE_MAC_FILTER, &nic_dev->flags)) {
> +		hinic3_update_mac_filter(netdev, &netdev->uc,
> +					 &nic_dev->uc_filter_list);
> +		hinic3_update_mac_filter(netdev, &netdev->mc,
> +					 &nic_dev->mc_filter_list);
> +	}
> +
> +	hinic3_mac_filter_sync_all(netdev);
> +
> +	if (hinic3_test_support(nic_dev, HINIC3_NIC_F_PROMISC))
> +		promisc_en = !!(netdev->flags & IFF_PROMISC) ||
> +			test_bit(HINIC3_PROMISC_FORCE_ON,
> +				 &nic_dev->rx_mod_state);
> +
> +	if (hinic3_test_support(nic_dev, HINIC3_NIC_F_ALLMULTI))
> +		allmulti_en = !!(netdev->flags & IFF_ALLMULTI) ||
> +			test_bit(HINIC3_ALLMULTI_FORCE_ON,
> +				 &nic_dev->rx_mod_state);
> +
> +	if (promisc_en != test_bit(HINIC3_HW_PROMISC_ON,
> +				   &nic_dev->rx_mod_state) ||
> +	    allmulti_en != test_bit(HINIC3_HW_ALLMULTI_ON,
> +				    &nic_dev->rx_mod_state))
> +		hinic3_sync_rx_mode_to_hw(netdev, promisc_en, allmulti_en);
> +}
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> index 4a47dac1c4b4..e43597937da5 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> @@ -154,6 +154,10 @@ static int hinic3_init_nic_dev(struct net_device *netdev,
>   	INIT_DELAYED_WORK(&nic_dev->periodic_work,
>   			  hinic3_periodic_work_handler);
>   
> +	INIT_LIST_HEAD(&nic_dev->uc_filter_list);
> +	INIT_LIST_HEAD(&nic_dev->mc_filter_list);
> +	INIT_WORK(&nic_dev->rx_mode_work, hinic3_set_rx_mode_work);
> +
>   	return 0;
>   }
>   
> @@ -220,6 +224,7 @@ static void hinic3_sw_uninit(struct net_device *netdev)
>   	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
>   
>   	hinic3_free_txrxqs(netdev);
> +	hinic3_clean_mac_list_filter(netdev);
>   	hinic3_del_mac(nic_dev->hwdev, netdev->dev_addr, 0,
>   		       hinic3_global_func_id(nic_dev->hwdev));
>   	hinic3_clear_rss_config(netdev);
> @@ -408,6 +413,7 @@ static void hinic3_nic_remove(struct auxiliary_device *adev)
>   	unregister_netdev(netdev);
>   
>   	disable_delayed_work_sync(&nic_dev->periodic_work);
> +	cancel_work_sync(&nic_dev->rx_mode_work);
>   	destroy_workqueue(nic_dev->workq);
>   
>   	hinic3_update_nic_feature(nic_dev, 0);
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
> index 68dfdfa1b1ba..a69778b09c83 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
> @@ -115,6 +115,22 @@ struct l2nic_cmd_set_vport_state {
>   	u8                   rsvd2[3];
>   };
>   
> +/* *
> + * Definition of the NIC receiving mode
> + */
> +#define L2NIC_RX_MODE_UC       0x01
> +#define L2NIC_RX_MODE_MC       0x02
> +#define L2NIC_RX_MODE_BC       0x04
> +#define L2NIC_RX_MODE_MC_ALL   0x08
> +#define L2NIC_RX_MODE_PROMISC  0x10
> +
> +struct l2nic_rx_mode_config {
> +	struct mgmt_msg_head msg_head;
> +	u16                  func_id;
> +	u16                  rsvd1;
> +	u32                  rx_mode;
> +};
> +
>   struct l2nic_cmd_set_dcb_state {
>   	struct mgmt_msg_head head;
>   	u16                  func_id;
> @@ -205,6 +221,7 @@ enum l2nic_cmd {
>   	/* FUNC CFG */
>   	L2NIC_CMD_SET_FUNC_TBL        = 5,
>   	L2NIC_CMD_SET_VPORT_ENABLE    = 6,
> +	L2NIC_CMD_SET_RX_MODE         = 7,
>   	L2NIC_CMD_SET_SQ_CI_ATTR      = 8,
>   	L2NIC_CMD_CLEAR_QP_RESOURCE   = 11,
>   	L2NIC_CMD_CFG_RX_LRO          = 13,
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> index ad50128f3d76..335de3093382 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> @@ -828,6 +828,20 @@ static void hinic3_get_stats64(struct net_device *netdev,
>   	stats->rx_dropped = dropped;
>   }
>   
> +static void hinic3_nic_set_rx_mode(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +
> +	if (netdev_uc_count(netdev) != nic_dev->netdev_uc_cnt ||
> +	    netdev_mc_count(netdev) != nic_dev->netdev_mc_cnt) {
> +		set_bit(HINIC3_UPDATE_MAC_FILTER, &nic_dev->flags);
> +		nic_dev->netdev_uc_cnt = netdev_uc_count(netdev);
> +		nic_dev->netdev_mc_cnt = netdev_mc_count(netdev);
> +	}
> +
> +	queue_work(nic_dev->workq, &nic_dev->rx_mode_work);
> +}
> +
>   static const struct net_device_ops hinic3_netdev_ops = {
>   	.ndo_open             = hinic3_open,
>   	.ndo_stop             = hinic3_close,
> @@ -840,6 +854,7 @@ static const struct net_device_ops hinic3_netdev_ops = {
>   	.ndo_vlan_rx_kill_vid = hinic3_vlan_rx_kill_vid,
>   	.ndo_tx_timeout       = hinic3_tx_timeout,
>   	.ndo_get_stats64      = hinic3_get_stats64,
> +	.ndo_set_rx_mode      = hinic3_nic_set_rx_mode,
>   	.ndo_start_xmit       = hinic3_xmit_frame,
>   };
>   
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
> index 72e09402841a..92afab46309c 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
> @@ -499,6 +499,30 @@ int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev)
>   	return pkt_drop.msg_head.status;
>   }
>   
> +int hinic3_set_rx_mode(struct hinic3_hwdev *hwdev, u32 enable)

u32 enable -> u32 rx_mode

> +{
> +	struct l2nic_rx_mode_config rx_mode_cfg = {};
> +	struct mgmt_msg_params msg_params = {};
> +	int err;
> +
> +	rx_mode_cfg.func_id = hinic3_global_func_id(hwdev);
> +	rx_mode_cfg.rx_mode = enable;
> +
> +	mgmt_msg_params_init_default(&msg_params, &rx_mode_cfg,
> +				     sizeof(rx_mode_cfg));
> +
> +	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
> +				       L2NIC_CMD_SET_RX_MODE, &msg_params);
> +
> +	if (err || rx_mode_cfg.msg_head.status) {
> +		dev_err(hwdev->dev, "Failed to set rx mode, err: %d, status: 0x%x\n",
> +			err, rx_mode_cfg.msg_head.status);
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
>   static int hinic3_config_vlan(struct hinic3_hwdev *hwdev,


Thanks,
Alok

