Return-Path: <netdev+bounces-125412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8705696D07D
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0779B23FB3
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 07:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598A8193069;
	Thu,  5 Sep 2024 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GpZKVBac";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pvUWgeJ6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884FE192B94;
	Thu,  5 Sep 2024 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521754; cv=fail; b=a3AR2S4lfKH14Ys29hy0b0YlwbjaLOFp2Ja9eWPX5I79Kf3Sv/8zKQd7kv1xOTwsftPNRF3j/pW+n9Aoa3DEjNHyiHVB8g6mIxMVU2Pu2841UUsLEWoEOVuP3a69p+GAn9YmfnAUVS1+b4cMxvX59ZtFsO5+vt8mZ0TsWBf7jqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521754; c=relaxed/simple;
	bh=9xg1WFLZu61QL0eX8ubV5zJr7GcQe/KyAtHToQfgSOU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FXH74rl6J1cx/yqDlB7e+c2Ki/dotrtTha1fguOC6KAz989O7TYsUbDNbdm366VUR8iIg8ERxrkXq929e0QBtNWvv5nmNG1lO+Kvb6zQH2U+eu8ubI8OKa0fjR1twQjUyo0s6xGr/CNWsWATljnTYvh71RRGyrwiFuOTjcduC1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GpZKVBac; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pvUWgeJ6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4853tvX3021283;
	Thu, 5 Sep 2024 07:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:from:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=ELWL8YGMjK7256VGCyXK+B9DLQtrzhAjEqTpyp82mAM=; b=
	GpZKVBac32uEnMJXM2hyWiDWcdnq+/LbjUIebZ+RydQx2/IHunp0LkB+ssyFRX/1
	nLhnqTya3BbLmvb1NxyWXKBKZ2WUkMjbBERiWkjp1zZS0E4giNKvSiglcIIV5Wi6
	yPOpJCseebm574sUkApY9acjagp4owyrx/OiOU/j391y9z6WfHeEOT1C8/ajruRC
	pjjhsfmiT4k0fTEvxkAlK0PbxRdfdBdHbphMf3GlNIWMfxIcbE/CGa1mJ7NDcLza
	qHntvZvK0RCVNQbFeBB/FlgqdNpMG1QIExknQVHvcl03GrIgLTxQUYlfap2GeED6
	/aQUtHGK5w1gH5+HuPn/nA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dwndn5bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 07:35:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48573BKb001869;
	Thu, 5 Sep 2024 07:35:40 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmhdu07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 07:35:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spwHl6jdQQiCdjYPJbr5yx9q+yO8GTYxKmEVLfJPtLSGes4HXKKRXnqL2oZhoJN4JWCXH4IQlJY4k5sHEVeVx2RhTR60rFOQpiHwLR2qWOhKX/2G9B4erU13mtdzxn5TmOkeGeZA/t82aXO/1SPu0mb8P4EbnJ2DYVDBbInynLW3PgncHQCHyPE/5eXMRWElk/2aXUEJYj0Wm5tpEHrWtAla/a1Gqc/KfnxsHuS4iByfaKs6ax8a+0qmwg54EZR/AMrrdeShVHkGKFN3mAFVjXQrUmSfxuFqqBvx3WeRKANihubIjSwPlmb0RAjmJ7B26aqCWqZjn2jZyNGCdiXDhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELWL8YGMjK7256VGCyXK+B9DLQtrzhAjEqTpyp82mAM=;
 b=gtxJiFApEoyArkDrtvr+mH2tiJK/PLBbyB8FEhO7i3W9PJcsWYrEuXYwphnJPOgmLsEnSI6qpoPjtuDJrT2z7fobtJMq5YcQw1CnK4xK2OghNVng8dobd7+a1Cmr6waqiKoILCCQ6napSqxvGGOTRQnTPcU5G1u593RAWnwBkg9OGFCQ/ZVy1/XAOP4R+7QRi9oLhBSvGwbDn+KtiUMGDbc21xmKmVwxfTSK4S51g+OTLgsZJ8qGih6QencheW4KD+1ns+kVgP+iXImCCB2yfKc8zFc6gdiRGUGrkclkTB8HsIQLlOwWkLya2+ir5P6mytc7lmADryxB1CPrrSyKSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELWL8YGMjK7256VGCyXK+B9DLQtrzhAjEqTpyp82mAM=;
 b=pvUWgeJ62Q1d1NHt0dKz6dowEHljj5VVCS3Ncq4BILytxVEFBKcPsAyMnE52/SAZD89tQy2E6GUtF44cfNET7ygjbEd0pJtUAn2buIyBvKACHjo0bmDrdDYzr7j8PLzDpMvHEXMoh8fLVLdfEKNxgshBAOh6r0iPtkGHFJBwLw0=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by PH7PR10MB6250.namprd10.prod.outlook.com (2603:10b6:510:212::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Thu, 5 Sep
 2024 07:35:37 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7939.016; Thu, 5 Sep 2024
 07:35:37 +0000
Message-ID: <13a58eb5-d756-46a3-81f0-aba96184b266@oracle.com>
Date: Thu, 5 Sep 2024 00:35:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
From: Shoaib Rao <rao.shoaib@oracle.com>
To: Eric Dumazet <edumazet@google.com>,
        syzbot <syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
References: <00000000000083b05a06214c9ddc@google.com>
 <CANn89iKt9Z7rOecB_6SgcqHOMOqhAen6_+eE0=Sc9873rrqXzg@mail.gmail.com>
 <f6443f4c-c3ab-478e-ba1d-aedecdcb353f@oracle.com>
Content-Language: en-US
In-Reply-To: <f6443f4c-c3ab-478e-ba1d-aedecdcb353f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0174.namprd05.prod.outlook.com
 (2603:10b6:a03:339::29) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|PH7PR10MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 6408bd1d-b821-417d-9f73-08dccd7d55c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkk0bko3RnRGZ2dLek94aWQvSjYrZHQzNzdHdGNMMHNhS3Ara0t5Q3VnYmlZ?=
 =?utf-8?B?VXk0N3B4bmQya200T3Z4dVI2QUxYMnplMGwrVnNqY2VnbkZpeFozVVhHUzhP?=
 =?utf-8?B?WWxDZ1Q4NG9VZ0FwTWs2bXBvNndqcHdTeGJsbytZNmRUdzBxSzdFelE2TEtH?=
 =?utf-8?B?NXk4SWdzeGtpQ2lzMnAyUVdXaENwb2tIQUVtNlJIT01YQ1N2ck1ZTmxoMmI1?=
 =?utf-8?B?SXlmNTlpeFRodFRsN0hmcXlsK05uVFJBNDVNMWVrREM2Si9rT01Bd001UXAy?=
 =?utf-8?B?Z3JLNnVLR2NZYks4M2QwWWNQNWJERGI4NEF6ZXJGbWVRSVJSY3dYeXBMVUpa?=
 =?utf-8?B?UC9QZGJQSFpLa3N1U2dnMEpCdGorMzdQSHdpYTNocnFHeTUvS2ovSy8zcFNQ?=
 =?utf-8?B?YXdtTnlWQ0dBaXFQTjFXN3p3eWg0ZURHSElzYnNqYVYyZmJsMHUyTTRPQ3cz?=
 =?utf-8?B?S3RQMnZnZ3F4eDY2SytvR3o2ZVJkcmVqdjVna3hFZ3l6bkJHSDhKT0k5QnZs?=
 =?utf-8?B?YjYvMnF4U3NXUGVZZ0N5MGUvMlZJZWxiK3RKQ0FKejl4ZnpxREdvRlVmMWJn?=
 =?utf-8?B?UFJSSlBaV1gySFI4SDA3TlFValJmU3cycU5TYUdmQzRnYkJxQURjakxad0l4?=
 =?utf-8?B?WWU0OHlxczFBT21nbUEvcm00YUUrR3JBUUdwVElqMnZNdUFtL3hlcmZXSGRs?=
 =?utf-8?B?NnpnYnZVKzFObS9JUzA2NnNpc0F2aEo5SndMOFlKVG5ST0NSM2p3NHpMbXlE?=
 =?utf-8?B?eW1ZODVBYnkwZXYvcXgyazF6RElmQ3hRZXRxQWIrYmpEVSt0aVNMOWdtZUll?=
 =?utf-8?B?RjF2NGRER3JQcFlYL3NzT2tiWXgyUFRFQnBwSTNpUllvRWhTT0FsdmJGRmgr?=
 =?utf-8?B?SklmamdXRzRuRkorY1Zhcy9LV3h4WjRrZy9WR2owRTF3ajJnRVBsOVJKRitG?=
 =?utf-8?B?RjFLVEx6cUNLcVJSN2JLYVhXMGJFOTQ5VkFiQkxHZ1dWckNwQ0JBbklpd2w1?=
 =?utf-8?B?ZFJPY2lnOUVSdVRrL3huSnRWR3lBSjRReGJKcGtwd2YzcndabFZPN0N3ZENT?=
 =?utf-8?B?NEUxMllLazFEOUNkcCtWVXdFNW1Nc1daV1hvRVFsTTNCdlFHTktrZWNJY2M5?=
 =?utf-8?B?WTR6SytJUFZSYjF4bzdKUk5mOFlqREN6SXFyWkJiS2dUcHp4TmdZTXZDajk5?=
 =?utf-8?B?cGoralV3amRQbWRSejY1WWRFTVZjYkNlSVBISGdsdG9WWHlGZ1RGVExsekJi?=
 =?utf-8?B?MHlVTk1CWGNDTlFVb2tnU1NRS1MyUEZ4amhRY3JRc0YrN01jN01nb3hzN2ZI?=
 =?utf-8?B?TTVDZ0x6amhRd3BQQmo4T1RFaVVwcUVYUGtuSkVUU09TTmp3a3podmxBRXZE?=
 =?utf-8?B?Nk5ValhSYVRJN2R4ZzRad09OOWdZRCt6YzlQZkpIOGp3NUkrbXFMc0RUdHlV?=
 =?utf-8?B?eTJOQUV4eklBOWJjYmlDbU5tbDBRZGZtOHRQd25aS3cxL2k2eVB3T3Q5Q1RM?=
 =?utf-8?B?cmlyM3IwZUszWmNXYi9JeHZOZnlBcm9RY2trV1RBZkx6SjRlRjBxTFRNYXB0?=
 =?utf-8?B?QmtrbEN4Nk9OSXhUeURSMVF1OTRlV1kreUd1WGFVRkliNkJrbkFBN1Q2U0pu?=
 =?utf-8?B?cDZLaHZKWTFjUjlLdnpaWm9mMDk1UEFhSzJRMm0ybVVWejZaY3NhWHFZdVBl?=
 =?utf-8?B?M1M0eUVhcy92UkNFMDY2OEU0ZVdiMUZhK1lKN0tkQUpQZUlEZHNvTUdoZ3Bo?=
 =?utf-8?Q?DLgFV9urWjoP8SpcY0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1gyZlR3UUcxMWNmMFdPc0JaR0RvbGJHSEJNa2xSZzNrNTVEYTF5WUFhNExa?=
 =?utf-8?B?bThtQnA0eWZvQUVQcE1QbjIzaFBjQlB4QkZzc2xmVG14NWIzaDhnWkJReml6?=
 =?utf-8?B?Q2xQK2Mvd09mTG5pQ3Q4cGsrYzdmN3o0cXNNUVdYcFlOdDhsTHhCUW1NMEUr?=
 =?utf-8?B?NzdpOTIxSXFuRng0UDFPQjNuZmpxckF2Sk12bTk2Mjd2RHRmYnh6RVY0ZElO?=
 =?utf-8?B?ekdhTmFIQU1mcGx5QU41elRma2ZlR09DZjU2Zk53WEUzbGg2RkFFYVJpbWJ4?=
 =?utf-8?B?TlQxTEJzYVFpOUpBbzlBaXc3U0YwVEdEUlhtNGRXdHJwcWhjY3NUSFpMNlpW?=
 =?utf-8?B?TnZYaHAvTHMvakpoRHI5dmZZYkZma2JqYWVVSVVZZXc3dzloV3BqMm92djJX?=
 =?utf-8?B?alRVR2Jaa0VZK3JFb2lEZ1Jlclh2WEY4Ky9XYzF3TUs2L2ZjVnJBU3hYZGNF?=
 =?utf-8?B?VDNGWWxZR0E1MDlsSFBoWGJjSE9aUmVXMzFpSTFaMzdKeE13Z2hQc2ZuZ3do?=
 =?utf-8?B?OE9xM0dVVkhDR1QxNHF5U3JUSStIRlBPenZqOXkvNnViemJ3enZxTzlOUUtO?=
 =?utf-8?B?aE44WXVrMDIya2xRQUVwbndENjQxN29BbGgwN24xY0FRUE5MdmlIRzZqaXJ5?=
 =?utf-8?B?UFloWEhOci9TKzU0MmRDVVF4L1FsYlZabjJBTXJZTnluY1lPcmM0UmtRRGU4?=
 =?utf-8?B?RGo4dlR6NHFyZTYzUHpZbGdBMm1vMlJHSDE5V1JUSXVKUGQ4Q0RROVRGeVdw?=
 =?utf-8?B?VXNWSE1odXJ6TmNmUTkydmQ3RzB4NTBOOUVNUit5L3FwVzIrL2NVdFVYRGlP?=
 =?utf-8?B?WGRBYWJyaEJERVRRRGVjVksrTkxaRHdvZk0wUjFhalREU2xuR2dSa2x2cjI1?=
 =?utf-8?B?YS9qbHQ0Q29BS2oxakFmcHZ6aTRkWU1SRXZ1Rm50RDFFTDBxck40WTlNenZs?=
 =?utf-8?B?dTFIcnNxdkRkSW51TUY1SXVFcldkeFlHZCsxOUJRZmhIQzRRVTZZMGhiUVcw?=
 =?utf-8?B?YWFmTDJvTG9zZmdQMk9GSjhBL2E5M3NXYkdmaFBVcXFicVZSbE1mQnpJTnh3?=
 =?utf-8?B?WkxLUGhSRTk4RkJkZDRKT0diVGVkREZTdDdSdTlSL1Z2VERETDh0MFBlZnRU?=
 =?utf-8?B?dVdXR1EwVkJSOGorekNCNHAyNGo4bXRhUWY2bVA0UnBYUDE5Y0pzSHlIeUJD?=
 =?utf-8?B?Y0tqbDh3Q21lNVBYc0FiSWh3UWZEMUJhT0o3SitGTUF0enhDWWlmTCtsOTQ0?=
 =?utf-8?B?cURmeDhlUVZnVURRL3ExU3J4a20vN1ZPWjRKUk90ZlFIQVpuYnJYUld0UTd4?=
 =?utf-8?B?RERPa3p2dDdza2FzSUxkUUlsYTlJVW1ldTROc245b1lTZXpPd3JlOVhiSEN0?=
 =?utf-8?B?a0ZBSnRZNWpzS3orc3FGZWhoVEVvZlRYUGwwUmxQY0tORGxaNXAzTUhmbTFx?=
 =?utf-8?B?MUVrc3pVNFpGZ3YrZXlteFJDODJaN0hzb0RXNHdFc3JpV0EramtmVE9UK3dN?=
 =?utf-8?B?WkpuN0tlWVdRUFliK0l1UFRzTGhxOHp6VzJiUGE4RUJqQm9NczdZV1FyNU4y?=
 =?utf-8?B?bmd5SytNZENlTm9nTzNvMFgyRHBaU2JJejZiRzE5R0ZGdDMrdDI5c3J0N1VD?=
 =?utf-8?B?NWR1RnhqV0FTWHk2K2htbTJwVis2T1NuNGw5RDIvVVVJb1F1TlZ4VDZkWmpG?=
 =?utf-8?B?TER5ZkJjQU83TGZ1L3RNTVdUODhuWEF3WWpJRVVyZHlYZVBOZWd2OUVSK0hL?=
 =?utf-8?B?cFYxeFVHRCtQSFQvUkdBcWR6bVl4YWVoZXdkOENkdU56VkZnVklIYloxNTdK?=
 =?utf-8?B?aFJiTGdJWjlZZHczZXVSNkFHV1puTGgwRnlPWG85RUp5dG95cUNSOVV2MnZv?=
 =?utf-8?B?bFNUUjFNZ0VVU2x3ZmsyaFpsS3oreCtLVTNFZG5NV0o1SlplS3lwVU5jSktK?=
 =?utf-8?B?b0dZNDUxLytVSmhIaFZSNEtTSWNwaW5NckpZMll5QTJ6ejZMaVRxVERnbG01?=
 =?utf-8?B?UmRocDdHdUxZbnk0ODNoNi9mcEJFREZyaXY2bVBkQm1STWN6dyt5OUFENVlo?=
 =?utf-8?B?N3YyNlJiV2VtRVZROU5VaDljQmdaYjFKVkhjOFErVFMxaHhLbmZYSlREVFNI?=
 =?utf-8?B?eGcveXF6ZU9uL1pweTNDL2dBWHZsWTNrOHVETTdweHVEa29TdDA0UWxyd1M0?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gP0KHwKIrKJJlr//MnoJg++SZbk9EJEXuKqTi40dt2QbIqh8dMLZYOr+c49gfDBhWfXjqExN+2q/7+PUX6zv8poikDHNOiUdVXJNpnczn8Edk2FjkKQXraeanRQD+aroASBxZbqSt1Ae5lMOB3RQ+U0tjrQsbMipAWFVVkQePwDx1vgVgwExEj2+Vj2/dZ3ASZtx8ek2bOgmrjXlKrOUDuQw6/bx96xyhpHFBXitxeGQgDVwtpDqFjzfbLE0Gu9yiDdo52hXZKFo5SpsKXXolypfqLd4yhdv2j8dmotrmWaG+/avok9I651co50rOwrl/LgUNncdZW6jVNbvxt+IHhyw43xXFSYCInQFUFfhH7cHKp5jxWtoIXzfZcXWqiBEvK+0GJNXY8NyyUE16q1NM4NaXfvu1J1h1d3iVCkQmP2gz+L0pMxNLMUHeNXrELITBlxUBJfU7D1URUkynrskUkoR1PiqzpFKinNbkrA2l5Gd9YQOgp/pWu6Bnz2n+uP9W9bslbvTsr5EdIkrOSv3xqb1/ttOpgcVrN3E5NIfDRc/V+ufQ0GN8N55vIs3w/5TbF8YZWkAYLv4hvyKs2lG9pu4yv88qLUxiyg3bvkdRjA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6408bd1d-b821-417d-9f73-08dccd7d55c6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 07:35:37.5441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEHNpopDxD66ckDzZKr/g8pv+upMN8vSf9B0Q8oLv33gE5gQ3CKDdWY3+XhyAXx8ssHmdnHJXw9+bWUfOxcYig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409050054
X-Proofpoint-GUID: Msha3tUJpRkhZEPblK40ljcc-mWUIxx6
X-Proofpoint-ORIG-GUID: Msha3tUJpRkhZEPblK40ljcc-mWUIxx6


On 9/4/2024 10:32 AM, Shoaib Rao wrote:
>
> On 9/4/2024 8:32 AM, Eric Dumazet wrote:
>> On Wed, Sep 4, 2024 at 5:13 PM syzbot
>> <syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com> wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    fbdaffe41adc Merge branch 'am-qt2025-phy-rust'
>>> git tree:       net-next
>>> console+strace: 
>>> https://urldefense.com/v3/__https://syzkaller.appspot.com/x/log.txt?x=13d7c44d980000__;!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmCinyPp6_w$
>>> kernel config: 
>>> https://urldefense.com/v3/__https://syzkaller.appspot.com/x/.config?x=996585887acdadb3__;!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmChXq35SIA$
>>> dashboard link: 
>>> https://urldefense.com/v3/__https://syzkaller.appspot.com/bug?extid=8811381d455e3e9ec788__;!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmCgeHsuB4Q$
>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils 
>>> for Debian) 2.40
>>> syz repro: 
>>> https://urldefense.com/v3/__https://syzkaller.appspot.com/x/repro.syz?x=14b395db980000__;!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmChfSXV14A$
>>> C reproducer: 
>>> https://urldefense.com/v3/__https://syzkaller.appspot.com/x/repro.c?x=16d3fc53980000__;!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmChGWZhDug$
>>>
>>> Downloadable assets:
>>> disk image: 
>>> https://urldefense.com/v3/__https://storage.googleapis.com/syzbot-assets/feaa1b13b490/disk-fbdaffe4.raw.xz__;!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmChjbj6XGw$
>>> vmlinux: 
>>> https://urldefense.com/v3/__https://storage.googleapis.com/syzbot-assets/8e5dccd0377a/vmlinux-fbdaffe4.xz__;!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmChlarTUfA$
>>> kernel image: 
>>> https://urldefense.com/v3/__https://storage.googleapis.com/syzbot-assets/75151f74f4c9/bzImage-fbdaffe4.xz__;!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmCgl9hRVww$
>>>
>>> Bisection is inconclusive: the first bad commit could be any of:
>>>
>>> 06ab21c3cb6e dt-bindings: net: mediatek,net: add top-level constraints
>>> 70d16e13368c dt-bindings: net: renesas,etheravb: add top-level 
>>> constraints
>>>
>>> bisection log: 
>>> https://urldefense.com/v3/__https://syzkaller.appspot.com/x/bisect.txt?x=11d42e63980000__;!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmCjDvB9Flg$
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the 
>>> commit:
>>> Reported-by: syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com
>>>
>>> ==================================================================
>>> BUG: KASAN: slab-use-after-free in unix_stream_read_actor+0xa6/0xb0 
>>> net/unix/af_unix.c:2959
>>> Read of size 4 at addr ffff8880326abcc4 by task syz-executor178/5235
>>>
>>> CPU: 0 UID: 0 PID: 5235 Comm: syz-executor178 Not tainted 
>>> 6.11.0-rc5-syzkaller-00742-gfbdaffe41adc #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, 
>>> BIOS Google 08/06/2024
>>> Call Trace:
>>>   <TASK>
>>>   __dump_stack lib/dump_stack.c:93 [inline]
>>>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
>>>   print_address_description mm/kasan/report.c:377 [inline]
>>>   print_report+0x169/0x550 mm/kasan/report.c:488
>>>   kasan_report+0x143/0x180 mm/kasan/report.c:601
>>>   unix_stream_read_actor+0xa6/0xb0 net/unix/af_unix.c:2959
>>>   unix_stream_recv_urg+0x1df/0x320 net/unix/af_unix.c:2640
>>>   unix_stream_read_generic+0x2456/0x2520 net/unix/af_unix.c:2778
>>>   unix_stream_recvmsg+0x22b/0x2c0 net/unix/af_unix.c:2996
>>>   sock_recvmsg_nosec net/socket.c:1046 [inline]
>>>   sock_recvmsg+0x22f/0x280 net/socket.c:1068
>>>   ____sys_recvmsg+0x1db/0x470 net/socket.c:2816
>>>   ___sys_recvmsg net/socket.c:2858 [inline]
>>>   __sys_recvmsg+0x2f0/0x3e0 net/socket.c:2888
>>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>> RIP: 0033:0x7f5360d6b4e9
>>> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 
>>> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 
>>> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>>> RSP: 002b:00007fff29b3a458 EFLAGS: 00000246 ORIG_RAX: 000000000000002f
>>> RAX: ffffffffffffffda RBX: 00007fff29b3a638 RCX: 00007f5360d6b4e9
>>> RDX: 0000000000002001 RSI: 0000000020000640 RDI: 0000000000000003
>>> RBP: 00007f5360dde610 R08: 0000000000000000 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
>>> R13: 00007fff29b3a628 R14: 0000000000000001 R15: 0000000000000001
>>>   </TASK>
>>>
>>> Allocated by task 5235:
>>>   kasan_save_stack mm/kasan/common.c:47 [inline]
>>>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>>>   unpoison_slab_object mm/kasan/common.c:312 [inline]
>>>   __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
>>>   kasan_slab_alloc include/linux/kasan.h:201 [inline]
>>>   slab_post_alloc_hook mm/slub.c:3988 [inline]
>>>   slab_alloc_node mm/slub.c:4037 [inline]
>>>   kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4080
>>>   __alloc_skb+0x1c3/0x440 net/core/skbuff.c:667
>>>   alloc_skb include/linux/skbuff.h:1320 [inline]
>>>   alloc_skb_with_frags+0xc3/0x770 net/core/skbuff.c:6528
>>>   sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2815
>>>   sock_alloc_send_skb include/net/sock.h:1778 [inline]
>>>   queue_oob+0x108/0x680 net/unix/af_unix.c:2198
>>>   unix_stream_sendmsg+0xd24/0xf80 net/unix/af_unix.c:2351
>>>   sock_sendmsg_nosec net/socket.c:730 [inline]
>>>   __sock_sendmsg+0x221/0x270 net/socket.c:745
>>>   ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
>>>   ___sys_sendmsg net/socket.c:2651 [inline]
>>>   __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
>>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>
>>> Freed by task 5235:
>>>   kasan_save_stack mm/kasan/common.c:47 [inline]
>>>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>>>   kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>>>   poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
>>>   __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>>>   kasan_slab_free include/linux/kasan.h:184 [inline]
>>>   slab_free_hook mm/slub.c:2252 [inline]
>>>   slab_free mm/slub.c:4473 [inline]
>>>   kmem_cache_free+0x145/0x350 mm/slub.c:4548
>>>   unix_stream_read_generic+0x1ef6/0x2520 net/unix/af_unix.c:2917
>>>   unix_stream_recvmsg+0x22b/0x2c0 net/unix/af_unix.c:2996
>>>   sock_recvmsg_nosec net/socket.c:1046 [inline]
>>>   sock_recvmsg+0x22f/0x280 net/socket.c:1068
>>>   __sys_recvfrom+0x256/0x3e0 net/socket.c:2255
>>>   __do_sys_recvfrom net/socket.c:2273 [inline]
>>>   __se_sys_recvfrom net/socket.c:2269 [inline]
>>>   __x64_sys_recvfrom+0xde/0x100 net/socket.c:2269
>>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>
>>> The buggy address belongs to the object at ffff8880326abc80
>>>   which belongs to the cache skbuff_head_cache of size 240
>>> The buggy address is located 68 bytes inside of
>>>   freed 240-byte region [ffff8880326abc80, ffff8880326abd70)
>>>
>>> The buggy address belongs to the physical page:
>>> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 
>>> pfn:0x326ab
>>> ksm flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
>>> page_type: 0xfdffffff(slab)
>>> raw: 00fff00000000000 ffff88801eaee780 ffffea0000b7dc80 
>>> dead000000000003
>>> raw: 0000000000000000 00000000800c000c 00000001fdffffff 
>>> 0000000000000000
>>> page dumped because: kasan: bad access detected
>>> page_owner tracks the page as allocated
>>> page last allocated via order 0, migratetype Unmovable, gfp_mask 
>>> 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 4686, 
>>> tgid 4686 (udevadm), ts 32357469485, free_ts 28829011109
>>>   set_page_owner include/linux/page_owner.h:32 [inline]
>>>   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
>>>   prep_new_page mm/page_alloc.c:1501 [inline]
>>>   get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3439
>>>   __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4695
>>>   __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
>>>   alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
>>>   alloc_slab_page+0x5f/0x120 mm/slub.c:2321
>>>   allocate_slab+0x5a/0x2f0 mm/slub.c:2484
>>>   new_slab mm/slub.c:2537 [inline]
>>>   ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
>>>   __slab_alloc+0x58/0xa0 mm/slub.c:3813
>>>   __slab_alloc_node mm/slub.c:3866 [inline]
>>>   slab_alloc_node mm/slub.c:4025 [inline]
>>>   kmem_cache_alloc_node_noprof+0x1fe/0x320 mm/slub.c:4080
>>>   __alloc_skb+0x1c3/0x440 net/core/skbuff.c:667
>>>   alloc_skb include/linux/skbuff.h:1320 [inline]
>>>   alloc_uevent_skb+0x74/0x230 lib/kobject_uevent.c:289
>>>   uevent_net_broadcast_untagged lib/kobject_uevent.c:326 [inline]
>>>   kobject_uevent_net_broadcast+0x2fd/0x580 lib/kobject_uevent.c:410
>>>   kobject_uevent_env+0x57d/0x8e0 lib/kobject_uevent.c:608
>>>   kobject_synth_uevent+0x4ef/0xae0 lib/kobject_uevent.c:207
>>>   uevent_store+0x4b/0x70 drivers/base/bus.c:633
>>>   kernfs_fop_write_iter+0x3a1/0x500 fs/kernfs/file.c:334
>>>   new_sync_write fs/read_write.c:497 [inline]
>>>   vfs_write+0xa72/0xc90 fs/read_write.c:590
>>> page last free pid 1 tgid 1 stack trace:
>>>   reset_page_owner include/linux/page_owner.h:25 [inline]
>>>   free_pages_prepare mm/page_alloc.c:1094 [inline]
>>>   free_unref_page+0xd22/0xea0 mm/page_alloc.c:2612
>>>   kasan_depopulate_vmalloc_pte+0x74/0x90 mm/kasan/shadow.c:408
>>>   apply_to_pte_range mm/memory.c:2797 [inline]
>>>   apply_to_pmd_range mm/memory.c:2841 [inline]
>>>   apply_to_pud_range mm/memory.c:2877 [inline]
>>>   apply_to_p4d_range mm/memory.c:2913 [inline]
>>>   __apply_to_page_range+0x8a8/0xe50 mm/memory.c:2947
>>>   kasan_release_vmalloc+0x9a/0xb0 mm/kasan/shadow.c:525
>>>   purge_vmap_node+0x3e3/0x770 mm/vmalloc.c:2208
>>>   __purge_vmap_area_lazy+0x708/0xae0 mm/vmalloc.c:2290
>>>   _vm_unmap_aliases+0x79d/0x840 mm/vmalloc.c:2885
>>>   change_page_attr_set_clr+0x2fe/0xdb0 
>>> arch/x86/mm/pat/set_memory.c:1881
>>>   change_page_attr_set arch/x86/mm/pat/set_memory.c:1922 [inline]
>>>   set_memory_nx+0xf2/0x130 arch/x86/mm/pat/set_memory.c:2110
>>>   free_init_pages arch/x86/mm/init.c:924 [inline]
>>>   free_kernel_image_pages arch/x86/mm/init.c:943 [inline]
>>>   free_initmem+0x79/0x110 arch/x86/mm/init.c:970
>>>   kernel_init+0x31/0x2b0 init/main.c:1476
>>>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>>>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>>>
>>> Memory state around the buggy address:
>>>   ffff8880326abb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>>   ffff8880326abc00: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
>>>> ffff8880326abc80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>>                                             ^
>>>   ffff8880326abd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
>>>   ffff8880326abd80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>>> ==================================================================
>>>
>>>
>>> ---
>>> This report is generated by a bot. It may contain errors.
>>> See 
>>> https://urldefense.com/v3/__https://goo.gl/tpsmEJ__;!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmCj0yiM5oA$ 
>>> for more information about syzbot.
>>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>>
>>> syzbot will keep track of this issue. See:
>>> https://urldefense.com/v3/__https://goo.gl/tpsmEJ*status__;Iw!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmCglGrElYg$ 
>>> for how to communicate with syzbot.
>>> For information about bisection process see: 
>>> https://urldefense.com/v3/__https://goo.gl/tpsmEJ*bisection__;Iw!!ACWV5N9M2RV99hQ!O_wYwGadsms5089A9E28Dxx6WaVGOgSJ31BkCSFGtWTEPW52si4mQ-gN_xDf6oRUivpWe5nrmChS6eLfFw$
>>>
>>> If the report is already addressed, let syzbot know by replying with:
>>> #syz fix: exact-commit-title
>>>
>>> If you want syzbot to run the reproducer, reply with:
>>> #syz test: git://repo/address.git branch-or-commit-hash
>>> If you attach or paste a git patch, syzbot will apply it before 
>>> testing.
>>>
>>> If you want to overwrite report's subsystems, reply with:
>>> #syz set subsystems: new-subsystem
>>> (See the list of subsystem names on the web dashboard)
>>>
>>> If the report is a duplicate of another one, reply with:
>>> #syz dup: exact-subject-of-another-report
>>>
>>> If you want to undo deduplication, reply with:
>>> #syz undup
>>
>> Another af_unix OOB issue.
>>
>> Rao can you take a look ?
>>
>> Thanks.
>
> Sure I will take a look.
>
> Shoaib
>
Hi All,

I am not able to reproduce the issue. I have run the C program at least 
100 times in a loop. In the I do get an EFAULT, not sure if that is 
intentional or not but no panic. Should I be doing something 
differently? The kernel version I am using is 
v6.11-rc6-70-gc763c4339688. Later I can try with the exact version.

[rshoaib@turbo-2 debug_pnic]$ gcc cause_panic.c -o panic_sys
[rshoaib@turbo-2 debug_pnic]$ strace -f ./panic_sys
execve("./panic_sys", ["./panic_sys"], 0x7ffe7d271d38 /* 63 vars */) = 0
brk(NULL)                               = 0x18104000
arch_prctl(0x3001 /* ARCH_??? */, 0x7ffe134f7880) = -1 EINVAL (Invalid 
argument)
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or 
directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=94859, ...}) = 0
mmap(NULL, 94859, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7feb7dd0f000
close(3)                                = 0
openat(AT_FDCWD, "/lib64/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, 
"\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\200\251\3\0\0\0\0\0"..., 
832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=2164792, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7feb7dd0d000
lseek(3, 808, SEEK_SET)                 = 808
read(3, 
"\4\0\0\0\20\0\0\0\5\0\0\0GNU\0\2\0\0\300\4\0\0\0\3\0\0\0\0\0\0\0", 32) = 32
mmap(NULL, 4020448, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x7feb7d728000
mprotect(0x7feb7d8f5000, 2093056, PROT_NONE) = 0
mmap(0x7feb7daf4000, 24576, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1cc000) = 0x7feb7daf4000
mmap(0x7feb7dafa000, 14560, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7feb7dafa000
close(3)                                = 0
arch_prctl(ARCH_SET_FS, 0x7feb7dd0e500) = 0
mprotect(0x7feb7daf4000, 16384, PROT_READ) = 0
mprotect(0x600000, 4096, PROT_READ)     = 0
mprotect(0x7feb7dd2d000, 4096, PROT_READ) = 0
munmap(0x7feb7dd0f000, 94859)           = 0
mmap(0x1ffff000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, 
-1, 0) = 0x1ffff000
mmap(0x20000000, 16777216, PROT_READ|PROT_WRITE|PROT_EXEC, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x20000000
mmap(0x21000000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, 
-1, 0) = 0x21000000
write(1, "executing program\n", 18executing program
)     = 18
socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) = 0
sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\333", 
iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 
MSG_OOB|MSG_DONTWAIT) = 1
recvmsg(3, {msg_name=NULL, msg_namelen=0, msg_iov=NULL, msg_iovlen=0, 
msg_controllen=0, msg_flags=MSG_OOB}, MSG_OOB|MSG_WAITFORONE) = 1
sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\21", 
iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 
MSG_OOB|MSG_NOSIGNAL|MSG_MORE) = 1
recvfrom(3, "\21", 125, MSG_DONTROUTE|MSG_TRUNC, NULL, NULL) = 1
recvmsg(3, {msg_namelen=0}, MSG_OOB|MSG_ERRQUEUE) = -1 EFAULT (Bad 
address)     <======
exit_group(0)                           = ?
+++ exited with 0 +++

Regards,

Shoaib


