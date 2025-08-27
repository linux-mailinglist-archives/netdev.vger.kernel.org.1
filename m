Return-Path: <netdev+bounces-217397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D685FB38891
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 19:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD9A77B681A
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFAB2D7DE5;
	Wed, 27 Aug 2025 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C+QlWc9R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UGubSOU2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461782D7384;
	Wed, 27 Aug 2025 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315627; cv=fail; b=I19AamSxtPYt+XwadRLkEcBvlhFKZB18nc1DO+pbftCOeHeR+szGKnSE8SFCDVb2krPqgRD+LU5E3nEiprUIBI2H4oPzqM1Br72TC3jGq9vR7n8BklcjvOAqrjMbpaU7wJzLRTQbWmo9Ltd0aoujSK6AOSTU1C48HLkZGUZphPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315627; c=relaxed/simple;
	bh=lkRHzqxgFtqJ8fcRHnDgQqtE8CGazCrPhteXtiFMovs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rqGWWFwUO9vaxuANQ1TcKWL+AODpO8g6SeDqNCCVMRlns8pZEGJisVKOKokHYIFd1dY3/NtfjterhVvSP5jUGsTlMWLt2rEz5LI8p/zYkXP+ko/V90BUWsgdWvzMYUs5V6Nivnl+Wt/lAovxwcPHcnN//m+JMvLB4Xdo6iWBnlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C+QlWc9R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UGubSOU2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RH8vMb001210;
	Wed, 27 Aug 2025 17:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zSATvfUiNoldGMcT+QYiQA6/yQWdcOdFBGOcLRLz0ZQ=; b=
	C+QlWc9RM4gcyEARkUn4J35LjxFX53BG1uveIMG6lYA82uwJ85/I+6rsrgC0EmuK
	UWa0T+1UZTJc1R909mljW2+8V1sKUxhXppmVaFgWO5KM8vv0txd6v6/zGN1aEpTQ
	U4Mytl8/Phtn7ElffQe5h8vd4LRrmTeregQN9ZqknuLcTM3aicjSUoPS0cgXLwWK
	g752GQvuvyfbyci086uQ1VBq0bf7x3r9KuKMFvo9QIPZ81kklPaQGPZ8fKRulXIm
	u+suJEo0HiizfO+vqD8Mnyb9KMZn3Y6o/h4bD/rt0eau8/0StsEgs2Y68AxafFy2
	+NMv0NZcNyZqyGFenCZRRg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e27198-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 17:26:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RGCi9k014754;
	Wed, 27 Aug 2025 17:26:54 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43aweux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 17:26:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qd3qdYi9SFE5Bsk/03hgVTpyGD03InBjAa3N2WfR/DGk3pwjmCAFp8ELKndiDyDQchjqsTm+oHbwBNFzJt/11LhOlGlpynoiCmq9o3vS1J5KHq7rb58QE8lvjh2pqThK28gFup+Yq403j2a2TDWCcGPHZdVc6ieESc6Xb+TVTsl6PEAjmY2sP6mnlnR1CB2Ot6Fqyg2vjwoqOF32uSVUSHbgbQQdL8uZjgIFTgCJSqKUmynhmQk/qaaGgrb6zMVXBRbbir4PcAe7jwvDtUPQ8jYCbdbZsBwy3uoOCE5ldctXKtTasdpg7k0cNdKtMqjYOCFTrPJdzrHy0YQeK6lhtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSATvfUiNoldGMcT+QYiQA6/yQWdcOdFBGOcLRLz0ZQ=;
 b=MvpAjdRCKGz1WwBiMxdjLJNbrje9JbQajIbXJZfqX2XpXRcV0uUUIQyD6FoQ6UFGc9u7L738D3dYDovAtE2M2dJG6YF51s/03Qh55Ul69X50iGtZvTm637I/1Nk1Zf3bB5l9vAkDIEWN0L5gJ0YAKlC4dd2EvfeboVF3PRTirH0zYUJ4k80QPdqzRdJ9MoHx2xm1OSQV8TlJzpk7iriXwLAYVcAJ6Dwo4dWjyuaUFAdiOiqYDdvV91U/B7yAMMwTCrB5qQUpvrJGAB8OVcMVKqjnZ22stxgJSCRghA70lqrcyYQNeSD1B2RJgC99gLQjnrCcl+mGmIZv50DRDrOi2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSATvfUiNoldGMcT+QYiQA6/yQWdcOdFBGOcLRLz0ZQ=;
 b=UGubSOU2oeVIE30oQ04Ki1CBRx5YIlpSUSq2cyLCzjvnJ6Mb3WJtlcMfsxSL/VpzxgYymjE4z5+17CIQNjp29UKsR78SXPitIthnr1edqXLzSDRZfZ3ouOcikKPLCrFdqLryhnZrKS/ILogi1KZIosOKRGnaxG6jpukLoTxUSzg=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS0PR10MB7456.namprd10.prod.outlook.com (2603:10b6:8:160::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 17:26:52 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9052.017; Wed, 27 Aug 2025
 17:26:52 +0000
Message-ID: <77484dd2-47c8-4539-b4bb-1713e2bc1330@oracle.com>
Date: Wed, 27 Aug 2025 22:56:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 22/22] sfc: support pio mapping based on cxl
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
        netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-23-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250624141355.269056-23-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0117.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::11) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS0PR10MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 2934c96d-39db-4cae-daa6-08dde58ee91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mno5Z1k3aTcvRVlVS0Z1NVNCOGFhMFhmZzBsQ1NxVkFHN3lLUjVwQzEwc3Nr?=
 =?utf-8?B?ZnVTQzVQa1hhQm41blVCeDdRWTFZV1BCQ0lBVWx1cUY4YURNWE03cGlCazRW?=
 =?utf-8?B?VXQxTGpNcUQrdnhkVEpHU0pFZExzRHBwZEFkZ1lYQmoxVkk5UkZ2RHY3Ukpp?=
 =?utf-8?B?RVVvamlSeEdJeEMrdk5vUGZQV0xlRzBiakhQdTRyUGF6cVIrZkRoTFlDM3g1?=
 =?utf-8?B?VU1ON3FtaDFFR3ROSkVUSUhQdzhoL3M0RW9QOXpEN2t0dmYzTDJsKzJSY0FU?=
 =?utf-8?B?ZU11c3h1R3RKYjErOXdTVTR4OGU4SVFoYmtCdlYzYzExRlFVck5XalE4MVha?=
 =?utf-8?B?RTlDQzladGNxKytNWW9FOGRUekdTaWhrdGpIVStLUHZZVmNlV2pOaFJLeFhw?=
 =?utf-8?B?bUF0b2plVmpOWUgrUm1aLzhtUUFVWFlXYlo3MWVjYnVKQTFkYU5PZlUzT3V3?=
 =?utf-8?B?d0NsUVJHUTZlbHFXVUlRTXpPSjJGVWEyNFdpMHBDbmowa2tSZlJ6WWJSMzZV?=
 =?utf-8?B?M0NROXVOd2d1Y2Yva0h4ajBqbjlVa2EwOTM3a2NtWTFSUVlyQk1FM0lUbURy?=
 =?utf-8?B?SXBsMWxaT1VtK1VmTGhuc1Fja08xeDltaG9FR3JJTkd4WDdOcDFvOFQ1YXFY?=
 =?utf-8?B?K0J4NUZJdm1XdUU2UCtMem5ubmRtL1AybEhHSU1sZnlOMW16Vkgwb2h4N3Rj?=
 =?utf-8?B?SVdPb0JYNXpvOU5ESTBrZU55NHlFVUNRNkFIalp5UTdjTS9KNWx3a0V4VTF2?=
 =?utf-8?B?ZFJSUWhVVm41OXAyTnBOMGl2NEI1MW5qbU0wMHpZbDNYTThkcUY1b0pzNHV1?=
 =?utf-8?B?TUZKcHhna1U2cDUvUVFycjhramZYcFYzQkN5MUM5Si8vOHBKUGh0NDduY0JE?=
 =?utf-8?B?K1RDREFWWjBoZ1E4NURqVnpMT3pBSFZyYmgrbWw1dWdGYUo1NE51UGh2a2hm?=
 =?utf-8?B?SkFFOU8rVTdmL3c4TUQ2WTJoT1JLb3ZSVmpnSlc5ellwUmoyS01NM0l5eFJr?=
 =?utf-8?B?QmtXTGV3dDFvQm92KytwMDAzakxyeExPaytFZXduZ2FGTnAwc05YNVpJOXRM?=
 =?utf-8?B?YmR2c3h6aUdtOUIzUGZJZkRlUGU4U1NVbXAxM3c1ekwvMzlQSkZhWXRVbnVK?=
 =?utf-8?B?ajhNT29LOWw0UExnYUtNMHNsNzRpTUZNRU9CakZ5N3lsS1dFYmFINWJwNFc4?=
 =?utf-8?B?cmxNeGV4SmVNWDBza00zdDY5WUVlT0c4M1B3TFBWSDRSand4SVV4WXNJYWha?=
 =?utf-8?B?ZzljaExOSEY0bzJ0d3VtaGVVZE5SZ3d5YzdQVFhrQ2VIOXNmWGtBYlJXOUhS?=
 =?utf-8?B?cU95bW14YTg4TDA3NndEK2NINk1LZFREakVJNkpCUzF1Y3R5dVJtMVRsZ1or?=
 =?utf-8?B?ZktXYjJ2TUEvSVZqb3J1TmpuME9mMnpnNUVYSTJOWDRsNHVrNkJhQmFmS0lk?=
 =?utf-8?B?VFNramVDdWxwNGVCeFUzZkdUemkxb2gweTJDK01oVkplODFHcGE5RXR5MStN?=
 =?utf-8?B?TjlTRmhVREI0cjU0OGpCOXZJLzlLWWxtNkIrQUNjYmJ6NzBDSSt0TEtaSFFO?=
 =?utf-8?B?bkVGMVlpZy9lczgyeHdPWjFhdDNVTjU2d0pXcEUvVDJuYlZwV0ZlZFVmNmdF?=
 =?utf-8?B?WXVhY000Zjk3NTFLdzJTdVBTWU5ra2ZCVmxEL0xYNzFEdjJjcEFseERmK0pj?=
 =?utf-8?B?b2Zmd3FQcjhtYW16L2p3d0ZaK1lTM2Exekw3ZzBJanlaVTlsVEdBZ21IUmZ0?=
 =?utf-8?B?d1dGbTZseHM4dGZaMEJZU0kwanhmYXVxT2dIQUtMd1M2aHFUeWZId1JWUnV1?=
 =?utf-8?B?R0cyRlJnZUlWbDVWSjdXbW5KWldwblMvVEw0KzZiR1F1Si9RbTZwVlRZQzZF?=
 =?utf-8?B?ZHFIeGpyOHd5WHA1UWdpalFDSFNTNFR1dnZrQXBoMjAvalg3K0JGak1oSzd2?=
 =?utf-8?B?MGhYcVZ4TFltMGt1alBNVXFSRzZFaXNSV1d1VkZQMi9tZjlzRFdTb2lEQVZD?=
 =?utf-8?B?OEFrSGlWTFh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T01lWS8rNER0RGhRTUVrT0JEdnRidFlqczZGdCt4VUFPMzk5QjdRZzJISk8y?=
 =?utf-8?B?VE15YU56WVRvc2hvVzNMaWZMOUp0L1pLVWxOM25JekYyZzBUUThMR1BERmxp?=
 =?utf-8?B?aU5KMGVRbzZQZ1BTbEMxMHdnUW9IMjM3NDdBbDhVeHl6UW9LM0FEK3liaWxl?=
 =?utf-8?B?RTBoRjQwMWpwc1d1TU9zcGIza0gySmRLS29KQmppckxTblQrR2NsWnZ4K0t5?=
 =?utf-8?B?cTNKQW83ejBaNU1tbVVtRGtvVVVjbklMODg0RzFad1AyMlBlUnNoMnk2UnJp?=
 =?utf-8?B?Vm93aDhBS282V29PM2xheWxtTUMvcWd6QmRoOU1TTE5NUDdZbFNIbXA3SzUz?=
 =?utf-8?B?aHFjNXQvWFpHSVFuRVk2QmVQYUFlbnphY25jYnk3R3EwdWZFREgvZldFWlAx?=
 =?utf-8?B?bDlic3JGM1JrTTNtbitZcVhLb3lHbjFRNUw0SU1zZ2MrMUk2WUxoVmh6Z2hs?=
 =?utf-8?B?RDZHRjUzOGNMdHQ0WGVXeDNjTy9zOUZWb2J1MEpqam4yZGowdXJFMGJmMEFl?=
 =?utf-8?B?NW5TeitMeVI5UWhLMm5PazlMa0NDWm00NnJYMG9zbTUyN2tpSzJocjc3UWZl?=
 =?utf-8?B?R0kyNExwd0IxZWFleEVNQVdOblF3QUlmSE10VDVkSTRQbGtoYjhzK3A4MFF1?=
 =?utf-8?B?ZUl4U2dIR2c3VDVzakR6N3l3ajJBOFY4MXRWQlBJVGNQSHV4RTdJUjlhSmsr?=
 =?utf-8?B?RHFWSU5QVmdHSGpUaXczWmEwLzZ1bTJud1ZjdUVYSmo2Y2NKMFRjSEZnZzli?=
 =?utf-8?B?bGhvV0REc0hNQkpGeFhUTTRFcjZPTWlkRlZCZFNoMTVzbG52Z1dJNG9LYUM4?=
 =?utf-8?B?dDJ5RitwcUhJVS91bnRqMFlYUUt2d3lPYXZXTWhmYzMvcnE4TGlCaWdDbHpU?=
 =?utf-8?B?WlA1UmtuRkRya0FIelhHVlYxc1lzZmZnWjN0TGZYTW1BeVlpbTRsLy9TU1Q4?=
 =?utf-8?B?TlBIWWlBaUtVTEo0cE5FeVY4K3piTU1NSEI4RUpUbDB5WURKUDJGMW04Y3NQ?=
 =?utf-8?B?cjM1clBCc2ZKdEg0TlZhaTdsOTJpQnpEeTVZSUpWZXpvdlQ4Yk02WllBeE5N?=
 =?utf-8?B?aTQ0MEVabHU1MWNPMnA3NzArYXBvYlRCaVo3bEl0VE9pRjFSSjg2amtERGdC?=
 =?utf-8?B?REJlbWhJd2ZRejR1RU5hNXdtQ0xtZWlMcklUd1VNa0JiU2ZvYlA2RkZEc2tp?=
 =?utf-8?B?QjVoWnBBdTlySTdMKzJuemFJRVc4Tjk1SC9RbnRkUms2aGFuaCtFRzZJREhv?=
 =?utf-8?B?bFZUakl6ekNMTGs5eC9SZjVTdU43cXRIdjF3aTJKZjVTZzFHUDJwVE1FTzFG?=
 =?utf-8?B?TDNhSFl6WVlVbEl1SmZkQW94VzNCa2ZqNEkyTFlRSVNydFN6VE1VekM3cksr?=
 =?utf-8?B?M0JlOFRHUXp5ZFhHckFVU1BlNHlkanBydTltOXhvRmNHM0JRbFpuWjJZNjZR?=
 =?utf-8?B?R3dOSEFzSHRsd3FPQU1JWEthZXovK1lVVEpyVnRXWEpMU3l6b1E0Q21xdGtO?=
 =?utf-8?B?SmJha3pYUDRKV0dMWGt5WHVXMWlYOWRkanBFaFV2aWZPVEtEZUhyYmI2L1ll?=
 =?utf-8?B?Z3k5QkhObWV6NE5ZNFFrcXMzQjk0bDZVU0EzTlhnSTJ2SzlaUVlvVGdnOU8r?=
 =?utf-8?B?dTVaZDRpWHd3OU54MHh5Z2hVakJRYm5wY0FUNlZDTDdTYmxISG5OcEdoRDJD?=
 =?utf-8?B?dld5S3A1NS9JQ3V0Y2s1Y3RlMS9iMEtVVjFlbVc2WmRZOThwdmZ1QmpjdU5I?=
 =?utf-8?B?dmcwb214NHdjYVc4cVBFZ2ZKQlMzNFFXSnU5ZlQyOElidTJqRG5xUlNab3po?=
 =?utf-8?B?bXNKNUFLZUNQc1EwdkRqdVROYkR1OVFrVXJqRXRJR3ZVVk5XcDJpZ1M1R1Z4?=
 =?utf-8?B?Zk1wYkVNc2hkU0JJQklsYVRQak5weFlna2RadkdmeGlPNjkwU2pORFByTkl2?=
 =?utf-8?B?TUlkUGsvd2VJa1dHbUZYNWNFY2F1T3M3YjBIMDRDMWQ3cEEwYm9GaC93Mzgy?=
 =?utf-8?B?WEVIOFBFeGh3ei85bTYwY2plOVhDZVN0WDBPUW5XWjlmVWtDTHlXRlFmTDRl?=
 =?utf-8?B?aXpNQzgyUzBHRHVWNVN5aDZrMFRhUm1md3JpcmorOVRxTEVvZXdvMTd0U3FV?=
 =?utf-8?Q?1toDqIfdGXwdHLIcKJzVW0sON?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nzEEC0h6L5vBL8qyJpqp5dgLuGnTHQ9FqEtsDmwuTPUpmzseTFC+4CqSdG1W+hQI0/Zr1h3TPtvl4lTpnt24VJEy3Xbh3yk3vaVZvWqDvPuZfjMHUC3gepYMtKyoShQZKMpLtaktq2Alh9z+DqIesbvGEPvL3ceu6KqHu3ZW3clXNvwQKbCTP+7pD2gN7upteOULc2MIUvSBUQbeSR0214Rz8rIXrGuDzQk1RIS/fKflP+OU0i1sNG/vOhVK2CcQT8bpSQGxaq4r6zytiAFJQ/oaY+HH5616qBv05a6GrqkFgbTgzD0vqkqu4PIQbl4T2Wz+Izkd38xXUnaswNkFGlo44/WHenLtxggNGsg+6JuuFbLqb+NDOicUlsvgNKFXIxy4tbQiDTUEYemsyuOT7g1ZoxaRyFou6uNNsIcZqBG8xGclR7pgZ/l/VGx0VVQpdSRDwCrjjRcnIPBLsqOOSMFEiIJNY3D3VOyYslqWLoagimnp0DX2NpR3IKXn6qp4VPytYCYYBHyf7FykHnMLsl9dEg9u1QqSttIWImDpX9o+ilv1oSxz8G5h2PbjQ8hPS0IUUEhRKpRymMFOkdqLkERSl34yFC3yQSMFP3jyW98=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2934c96d-39db-4cae-daa6-08dde58ee91a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 17:26:51.9740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIL18DK0CtRRcCiNFLUkJffDkapjW5mHdKLQNazJNdFkkc8PmE7S56t+VMg30s/VhUHuKeWoSTOA0XXmBMolfImH/63evj0VctmqnAFpVYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7456
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=971
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508270149
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfX4fptmVZg/BUw
 lwcmPgMuo6W2QmnbFLZXIjRUFGgiQiSq4mX5KsaQ6PFkEzELJqjOBaVowugJwu0/DkYo9/Vgfcc
 hxn4yvDVQB6IE8zWDh6ccQuvfsUt/cjh0CLj/Jb6uXHtIzb3nd/nDa1wuSJw2kGqNZhP7Y1YeQE
 x2z+nvFERA1U0qOyU5TJoN2w7F304HslxrVJ6WWuE1RNvmbOi4c8wdvlSoyVg1T1qTu4NtM893h
 F6hCGjbqUC+w6nZqn6j+FuSBqU11PevIW72eyVc4WD900GlFUq7JR7YNcBsKcMSjIKLXsFDuLxD
 G0oxOUdMqJEcrUJCbKqXfLztpTyLqRNH1Cr7TFcmEt3lGuYyWoe5Boaz6DoT+ga6/0B/O7mhElm
 RJTfBve/9xA1vUppaD9ZkOB/X60lVA==
X-Proofpoint-ORIG-GUID: Bk3UzO8cfCGEqNTJAiQsMJJhJ0kqTWe_
X-Proofpoint-GUID: Bk3UzO8cfCGEqNTJAiQsMJJhJ0kqTWe_
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68af3fdf b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=zd2uoN0lAAAA:8 a=AKhRQe34H0uklM-726AA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13602



On 6/24/2025 7:43 PM, alejandro.lucero-palau@amd.com wrote:
> +	rc = cxl_get_region_range(cxl->efx_region, &range);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL getting regions params failed");
> +		goto err_region_params;
> +	}
> +
> +	cxl->ctpio_cxl = ioremap(range.start, range.end - range.start + 1);
> +	if (!cxl->ctpio_cxl) {
> +		pci_err(pci_dev, "CXL ioremap region (%pra) pfailed", &range);

pfailed -> failed

> +		rc = -ENOMEM;
> +		goto err_region_params;
> +	}
> +

Thanks,
Alok

