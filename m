Return-Path: <netdev+bounces-125695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4BC96E443
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3EB1C23792
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 20:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F301A3BB9;
	Thu,  5 Sep 2024 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HcOlBzoM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E/qCiQiG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB5191F6B;
	Thu,  5 Sep 2024 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725568904; cv=fail; b=HE5eRm/y7IaalWDLrCAvEPaHyHPuISobTqP7e4jipq0SbNpj9m7b4TsZDxVLtFourseSA1PpMhj+NFGEMEUgHkH99ht9dJOVKSxqXVhgx7mz7gwONr0SqipJa7bcDjr2QizT+J5Hvnu3d/33XernbWGlWrxZfXXfSivNI3y1D9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725568904; c=relaxed/simple;
	bh=9qN0X+HGnscbPPc9vn2LcJI8ko4T3tA7Kpb3rIP7EYo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ps4MLPg+2INpjfXAx8ElI+8g9vaV6OT+oEn1eo4YXHl/8ZeI5kI8N1wEc2ceXtIl/QWPLjiluN4q+c9Acb4ha1ksWgouEOkWKmulMkROS5inpqgwsECGWXck2SkOJc5PQ0NM9Mh4RUeElfjBofl/SBpEkK5EpZ76nGbIQiZEWCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HcOlBzoM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E/qCiQiG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485KfWBS029815;
	Thu, 5 Sep 2024 20:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:from:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=OTFpO8DZKz3EzKzT0Oxc6CPZtIHouZe87SCZbWN5MzE=; b=
	HcOlBzoMesvaQm50WR+HeyGgRttA0RDmAULLflSKw/xw89zl3hJADs6oRq8fTIgY
	32/h0+93rIVK4EphI08c8gHiFuzP10o22E9xUjydBekwKq1lh6fDxPliuvqWggU6
	xd65j/dZXL1UUi3ZZ73mlkK9sM79vs9eWFRBBsDmkgTy2NFr9fyuOoio84atBhhS
	Nt5kzjoksiwwXs62RSGkZuCnrT+mJIcpqxoEqKli/rqMPUnBpesoM7DYBnK5HdEu
	x1TuANxY6XWoZgTxgR3F3se8YrelWA6kwPBSArReivRhyVTgYXhp8LZDy2HJojZq
	KLDSFhsknInGvnKS/G7qWg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41fhwjg8q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 20:41:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 485KAQ3B018026;
	Thu, 5 Sep 2024 20:41:31 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41fhyg58gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 20:41:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANzwBeS+b1UA4oLgv7W2tCumCzdk+LarGR0i6aJw8DlcPlgI093zTRYetF2KPdXraTj3Pf7dacG+JmXooY05RNA1IuaFNTVGpVBh70JfKy7jzUBRZsBBYvXTLevIe97WGzBW0tHF5Qxg8oUX3RxEKSiSnii4/x9tiG3GGJTYICWtVcqZD6y6YNZASMnOkXABx50VOCjpMIAxrxcReAhAP/kDVSvYi7DmrW+Twrhe8uA3Thal4qmFCiyYUpRVUYjagSKVdnGiCOK4ye0pSLgboXMkHMO0G4qPQ43AqSlGBgwoqQHkETVLMAKB5R1sf1KWk4W7SVn2j3sY6IhPu2XQnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTFpO8DZKz3EzKzT0Oxc6CPZtIHouZe87SCZbWN5MzE=;
 b=rA/Rc1kUml+AtoNzpEzm/GI0tSTyRWNPOmL60VO+cx2ic+A9iG3tLT/kLLCGvOCv2NBKdQ8320/kKofnQnrcL2+XzBTEr3C6D/Vfz/rxyUeu0F/46pLJiykDbgdUid3AslqBuhyoPhOeUcSt8+OS2DIaFepyfxWnbXw78lT9CGc6HKLAVZU7q9UXqAriJQraUNM4AtXyBYOIv8ffeAPwWscfwdJjZMue9fvkF2Zg6PciCd3bu+tkD5nul/6pNVXciajD4FZrQg7mYPOiVcnA7umfsF/+bPoMoVpSWVExynG2TWt0yT+edNanFPMn+Flq3loEEJx+pCbNt0QUfwl6TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTFpO8DZKz3EzKzT0Oxc6CPZtIHouZe87SCZbWN5MzE=;
 b=E/qCiQiGQDC0fLiw6DVgRVTEok0YYUR9sNvGHsyh6sB3xY9q5ntAwJL49n1mfC1MmycdjI5MyhzckDAImNL3ph1uqANAbu+XPAWdUjCftrHb+dJHgKTQ2mc9BMHIIzhp/9sCeiCeYLtHCy4L2QNeY6A4HJcqBLcjXUuzXZZUdOQ=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by DS0PR10MB7127.namprd10.prod.outlook.com (2603:10b6:8:df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Thu, 5 Sep
 2024 20:41:29 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7939.016; Thu, 5 Sep 2024
 20:41:29 +0000
Message-ID: <d7073535-b435-418e-a58f-46728fc79c1e@oracle.com>
Date: Thu, 5 Sep 2024 13:41:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
From: Shoaib Rao <rao.shoaib@oracle.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com,
        syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
References: <13a58eb5-d756-46a3-81f0-aba96184b266@oracle.com>
 <20240905194616.20503-1-kuniyu@amazon.com>
 <e500b808-d0a6-4517-a4ae-c5c31f466115@oracle.com>
 <68873c3c-d1ec-4041-96d8-e6921be13de5@oracle.com>
Content-Language: en-US
In-Reply-To: <68873c3c-d1ec-4041-96d8-e6921be13de5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:a03:333::10) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|DS0PR10MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 8113f75d-033b-49ac-77a6-08dccdeb1e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHBNZExvN3ltV2lMZGhhbVVhZzhuYm5vbjFrMDRhcE90ak5JeGlBOUM3WS9z?=
 =?utf-8?B?VHdsSmYvaGlUNEp6eFFMNzluMlJGMkpQTHg2Y3Y5UXZLZUJGTmVJZ2d4Sk9B?=
 =?utf-8?B?anYwWlFURHJuZ3poY3IrcmE1b3JpT3NiV1NNTXNNK2U3aUN1TzNDSFZJZUJV?=
 =?utf-8?B?aEhtYnVaMWlUcjBVVGd5UGZ4OGNvTjUxMjlWRlY5aTMybUtwdk15cUd4aWRh?=
 =?utf-8?B?MGFFc1g1YjNxWHRtZkgvMlNMMkg2SUthcGpHLzV4MllLMzMxcWxicXNzSEl1?=
 =?utf-8?B?aU5rZG9ROGpseWwwNXBic1dhblFHU1cxM1dqUE1HdFNZTnlzQ2J3S3ZGUWJW?=
 =?utf-8?B?bzBmYjJYZmhSTHN2VG1WYXo4MG1oRHVmNjBaWnVta0xQTENuSHNVNDVSbm50?=
 =?utf-8?B?V2dHSjFBRnpET0QzWitsOTlkSDBxekpxNE9JTnFJYXFQajY5WWdjZVUrYXpU?=
 =?utf-8?B?Q2dVeUpYeUd2THdnQkNlUjRpSWtFL01CQzczd1p0cHR1RzQ4TW4yZVpYQ3pD?=
 =?utf-8?B?V3NLVEp1ZnluQVR1djlrTUZQbWUwTlZ3cExtUUx0RG0yNUpVRHJEcTNvcHJ4?=
 =?utf-8?B?SVN1MGlWOUdta2lmbm5BM2doaEwwclFiRHhpQWs2Ty9xQmNXRWFaRFVhbEtl?=
 =?utf-8?B?UmtWVGRCeTAxSFNkWDFiT1pIdmpBRE1mMHZINC85dTdKTmhwdTJLSmQreEVs?=
 =?utf-8?B?RmxFZm01MGMxY1Jxc3o1K1Fld1EvdnVmbzg4YWlJN2RNSU9yV1lsV01WL0Fi?=
 =?utf-8?B?a2lRY2tlSHhoNnFodGoyaXlMWkhJNmVVcW5yZy9VV0ZaVGhDbFpOODFZaDlF?=
 =?utf-8?B?bUZya0JYQlBRdFVDZnNISTF2RCt6R0JYKzZmS2sxUThxYkIxQzluZWFkUisy?=
 =?utf-8?B?d2ZXbmR5enkwL0g3cTRpT1c4eFpwQXpUdThQZlRicEJteFJQSGh6c2dlYXBU?=
 =?utf-8?B?Y2VtL1FUWkxhdzRKS3FUck52TTZPNk93cVBuRXRCMjhwdERnUFVwcXlwYmVn?=
 =?utf-8?B?RDcwUXNHazhnOHNuL2ZHWUxUTjNTbXhLdlN0RG1PMUJnS0xzZnhOSWpIWUg3?=
 =?utf-8?B?aXFISmpReXk2NW1tUG8ycFJTU0xmdkdUNXJiNXZ3K2hib0dxcXRiMnFaanlp?=
 =?utf-8?B?cTNzQkRQc2RtalJsZGhhZjBwZXMzWE12d0svWkxrbi9mMEcwb0Jkc0NtWXhN?=
 =?utf-8?B?cXRoYk8vTTU2Ui9MUnE3OWVaQ0NIeXg5WkpxNVI4VTEvOGNkNzM1TGlXaVh2?=
 =?utf-8?B?Ti9uNUsrd3VzMDNOc3E3R0hyTmc0RjVENjFTcEZXcy9ad0Q0VXNYMHBKUU4z?=
 =?utf-8?B?ZlRSSmhhMWpBWUNZLzZ6WmdsUTBieTN0Q3h6dHRDQ0k2NS9lSEJ2bUQ1VS80?=
 =?utf-8?B?UVUzd3F2eVR6RE52UnNWdnN0TTEvR2xKZXRzZmJYaGdYdXU0TzRmMndOWkZE?=
 =?utf-8?B?SmpNMlZ0TE5QR1dYdHd0cTV3OUtXTU1vTEUwZHhQRXNwWDRtTFc0eVhxcFY2?=
 =?utf-8?B?RjdSN2MvWHpZemxBS21yakYyc1k2MlFLRHJxbWd5a0tYSHZGZVFUckZZWXhl?=
 =?utf-8?B?Ykx2QU9aTi9pYXlTcUMyWjIyMEM4dkhLRkZZM3FiVU9VM0JwOWhleEJhT1J6?=
 =?utf-8?B?R3hTOUVzQ0xBbFVnRWFNNHNMUkg3aVdGTGlLTjVEbE01Wll4S3VCdEFPeE9C?=
 =?utf-8?B?NWh3bS9UT3lMRU9HdG1vcDh6WkU3UXJiVloweHFDbmR3VGtkcVl0WjRXZEJ2?=
 =?utf-8?B?Si9nYzV6R2JDVSs0aHpsb0RNN3JLaEhib1MxeHNOYjB6TUE2WDhMdmxmbGpR?=
 =?utf-8?Q?zeqFf+LKnNFxGpV8Yns8tu+Yzb+CVL3fOrkKE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1N5b0U5K09JVG9sWUlzR284UG1OT01ScjN2Zi9uMld0Zmh5OUE4QzZiVmRZ?=
 =?utf-8?B?cGJRTkZyVUFZWGxNaGV2bS8zek4zMXQ1blYvTnd0NkZ6U0Q2QVVrZWRrTDB0?=
 =?utf-8?B?MDVnV1RGUkY2bWEwbDAwM21YS1o5QzFiUXRVQTVWWVZYRXV3b0xDdTBMaFYv?=
 =?utf-8?B?WWJCMHltY2FPWDRQSTNsM3FlM2xBYW5TL1UzMXBGVUo5aGlQTUlMc1dpRU1U?=
 =?utf-8?B?MFdHSjhkb3RiNFNMdXVpUGY5SWQ5R1Mwa0dZQjlrOFdTN1hTcE1FRHdXM3Yy?=
 =?utf-8?B?S01IWlRDTmpmWis3dW9iQkJIM2tYbW12T3c4N0FXRUhKS2ZVTTZNckVVWXc2?=
 =?utf-8?B?c0tKWFdML25iZ0xneTJCRDdBNXJLaG5CZEwxaE1Fd1lTMDBZR1hjcGNGQjds?=
 =?utf-8?B?WUwxVUFQcEwyUjVNT0VVOXdrQjE0dVJpZHZWSmZxd0h3LzFReVZva3dTeFZh?=
 =?utf-8?B?Rkp2UUFEMkx3WTBXUHY0V1EwSGVqemJrN3h4MjdEcjI5cjNnVEMyY2lndHps?=
 =?utf-8?B?UTlNallibm1uRGNnQjFBeVBzaG5KREt5cFpuSnBZV3dQOFdZNS8xdXlrdlQ5?=
 =?utf-8?B?TzRvTCtQQTIvNVRzMVJaeklZWTJrTC82U3IrWHRFcGZBbVZVRlBmNm1hV21u?=
 =?utf-8?B?QmRvVnhyeVBjZ2tQamU0cXQwUkdmby9pWTlVL2k0dFg5S2JBZ2dCNDUyQW00?=
 =?utf-8?B?cGxxQkkxUnFCWnFxWC9YVU4yQ3h2b3ZlcXIyMVdmNFMrZzZCUkM1NEx6dUNm?=
 =?utf-8?B?Unl2UVgzaEZ6dnFkWFpNTnl4aHNmTkFoTjB3bzBSY0VuT29tOFhqN3NxVnRK?=
 =?utf-8?B?V0FocVFMSTIxdmtiekpqUGlJbjlQc3JIUzBaOXZqNWNhQVBTUHlWVG9IMEJU?=
 =?utf-8?B?eWV3cEhNRnpUa2pUb2d3SVFmUTFQZWU2bk5DRFN3dHVqdHFIelUyZ3RRTC9l?=
 =?utf-8?B?a0ZRT01UNVlCVUhIQ201cmd6TmZWTlZFVmxZWU5PZDd6WW8xR2lDRFRHVDBM?=
 =?utf-8?B?RWxaZGU3TzVZNERLMVpGekwxQUtoWHljMytZSlQxbmRKNmFzS1ZOZWFScXVD?=
 =?utf-8?B?NTJjTm01MEZnNmtsWnJpTHFyMTAvZ1pzVzVYb3JQaCtqdU9VQ1gwK1lJRHdv?=
 =?utf-8?B?ekJ0L3VKN29kczh2YmplU0ZWRDFpYnlnQnFMN3NqV3M4NkZqSzJSTk5jcFUr?=
 =?utf-8?B?bzJWcXdVa3BLSURva2tuejVYRTFKNVZVL3c1SUhTTnJtSno2U1lQWnlsd1kv?=
 =?utf-8?B?Mkc4YW94MHVQN0xmT01mSDFpd1A4cFVEaFJDMGhxRzJNc0dVdDBiZ3QyWm9I?=
 =?utf-8?B?U2svRGdqY2grR09LVUpneGJjR0g1TVMvaDhmSXJwSmFsR2ExS1VWLzJqS1Z1?=
 =?utf-8?B?RnExWjIyaEpLN2x4T1pJZ09WbGpaWG9aalh0eGNxOGhrOU5OcXFBK043d1BU?=
 =?utf-8?B?eS8wTWVNd25aWUtjak1aVUNySUR4VDNScjdqNUx1ajB5b0F6RFlLYmRDRzFR?=
 =?utf-8?B?YXI4aFMwRGlBZzljVXlRdWVDMFFtWXdhVzMwTGNOZ1BURWFyYy9TZTR2dmhm?=
 =?utf-8?B?OUJIcDE2QjNxbW5nZTZqSnY1dzlnYlkxL3NWNnNScnVkSXBOKzN2cHprckhL?=
 =?utf-8?B?UGVxS3ZjemZQTjgweVRPRFFJaGRJNkg3WWZGcFBnem9GbGRFM0JHK05DMnZS?=
 =?utf-8?B?enBpUlpYc2c0Vm80MkU5QUhQcU84ZGc1b21odTVYTmZ4R2VpSVF2eW9TTy9q?=
 =?utf-8?B?QUFKS1cvUGZIeG5Pc1lvVWhPSldDZE5xbDlUZkQ4dlJNdUxFNU5LL0llU1p4?=
 =?utf-8?B?bjFYM1AxZjBzbkh0ZUh1eDZmbSt1R3VSSHpkN3RINUlNeTNNWFk1c0twbWdl?=
 =?utf-8?B?emRNRFdvVlpIRTl6ME5HR0tXYjNPRWdrSkxpeTlHZ3dLV0NKYy9LbkpNQWtq?=
 =?utf-8?B?ZWYxL1Q2UjZpcm5Bb0kwLzhKNVgxbkhpT053M1BxbEdxVjljVUZtVFB5RnAy?=
 =?utf-8?B?UC9Jd1dNNDRnNzM1Q0ZQbnlmVzNkQUY1UlhvSzJ6bGpvTmFLQUprYytmNzdp?=
 =?utf-8?B?SnJCYWl4UmFSRHMyOXNpMk0rUENEb293QlAybW5qcStBZG1wR2NWeThhOFNo?=
 =?utf-8?B?a09RWG9OWExzaGhvOXkrdTFsZ1kwbUZjekFicWd0UXBHNXJWeU5sTFkzVXJG?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mtLvHaIXCsXUPVu4JxsyoBcvh+Jh/v9DUSJUrP0VS1mGliEqafgn7xC1NMAMIAF0spW5vEGIC0CSmVsbUkYguRwQgwRdqrdAtx9QlaQ/OuuNDuwzPG3BGjiZDRtP+ZPaFN3hazLDeBsTvSMeFMxKSY5JFCEVM4zW+n4rB/kZvi3s6XADWKS/hGDal1oC1raVQmxrAxZmu+7qB9bvwxk7CWMvac8xbZhF/8E04yPxgwXoFNVMYPtDXedC+VPNE3crtpjLFmi04dN3Owone47nQTpy6DZSOOZuBJk1Tbe1WDs7Ibj9QDaLwmRnrIscVR+zgiQjHv7hQJ1J4tJf4C2jRHnxa51C/eaYLzszcnzf1Wn+6CYfhzs/PF2rzRp08xEE/ae41OhHGJCWBUli5FGyxDODAJ2EWeoAjWcn2oJwRvcXPN2WBAUID2+wNXhZUr1EdINTHgRtZT0+ho41iFg4kUcrXU4Lq01u/dXRu5/fNhml5FxsvDU8AApd5HmokPpCVwKidH7wM2u1gOqFy1ikk3ChgoxdAuLBRYQzJvLGGTwXdxdKM0Mu6WFsZsj7PQWuK0uCx4H9EI06l6ed2FKlf5gbHhSi6FZGfd5Vv/VP9tc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8113f75d-033b-49ac-77a6-08dccdeb1e38
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 20:41:28.9444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6COdHVcH9a+dbfdGCy5x6fKLe51LSG0/GuUuZO11x2q+82Y6/cr4wlb0Y+OJBGx2CLZeRrAV9+9U9PAgyKyRUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_15,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=895 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409050153
X-Proofpoint-ORIG-GUID: 1xhJqru3YiOo8BsnUwA9BWrmOBa4Z1fZ
X-Proofpoint-GUID: 1xhJqru3YiOo8BsnUwA9BWrmOBa4Z1fZ


On 9/5/2024 1:37 PM, Shoaib Rao wrote:
>
> On 9/5/2024 1:15 PM, Shoaib Rao wrote:
>>
>> On 9/5/2024 12:46 PM, Kuniyuki Iwashima wrote:
>>> From: Shoaib Rao <rao.shoaib@oracle.com>
>>> Date: Thu, 5 Sep 2024 00:35:35 -0700
>>>> Hi All,
>>>>
>>>> I am not able to reproduce the issue. I have run the C program at 
>>>> least
>>>> 100 times in a loop. In the I do get an EFAULT, not sure if that is
>>>> intentional or not but no panic. Should I be doing something
>>>> differently? The kernel version I am using is
>>>> v6.11-rc6-70-gc763c4339688. Later I can try with the exact version.
>>> The -EFAULT is the bug meaning that we were trying to read an 
>>> consumed skb.
>>>
>>> But the first bug is in recvfrom() that shouldn't be able to read 
>>> OOB skb
>>> without MSG_OOB, which doesn't clear unix_sk(sk)->oob_skb, and later
>>> something bad happens.
>>>
>>>    socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) = 0
>>>    sendmsg(4, {msg_name=NULL, msg_namelen=0, 
>>> msg_iov=[{iov_base="\333", iov_len=1}], msg_iovlen=1, 
>>> msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_DONTWAIT) = 1
>>>    recvmsg(3, {msg_name=NULL, msg_namelen=0, msg_iov=NULL, 
>>> msg_iovlen=0, msg_controllen=0, msg_flags=MSG_OOB}, 
>>> MSG_OOB|MSG_WAITFORONE) = 1
>>>    sendmsg(4, {msg_name=NULL, msg_namelen=0, 
>>> msg_iov=[{iov_base="\21", iov_len=1}], msg_iovlen=1, 
>>> msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_NOSIGNAL|MSG_MORE) = 1
>>>> recvfrom(3, "\21", 125, MSG_DONTROUTE|MSG_TRUNC|MSG_DONTWAIT, NULL, 
>>>> NULL) = 1
>>>    recvmsg(3, {msg_namelen=0}, MSG_OOB|MSG_ERRQUEUE) = -1 EFAULT 
>>> (Bad address)
>>>
>>> I posted a fix officially:
>>> https://urldefense.com/v3/__https://lore.kernel.org/netdev/20240905193240.17565-5-kuniyu@amazon.com/__;!!ACWV5N9M2RV99hQ!IJeFvLdaXIRN2ABsMFVaKOEjI3oZb2kUr6ld6ZRJCPAVum4vuyyYwUP6_5ZH9mGZiJDn6vrbxBAOqYI$ 
>>>
>>
>> Thanks that is great. Isn't EFAULT,  normally indicative of an issue 
>> with the user provided address of the buffer, not the kernel buffer.
>>
>> Shoaib
>>
> Can you provide the full test case that you used to reproduce the issue.
>
> Thanks,
>
> Shoaib
>
>
 From the recvmsg man page


    Return Value

These calls return the number of bytes received, or -1 if an error 
occurred. The return value will be 0 when the peer has performed an 
orderly shutdown.

*EFAULT*

The receive buffer*pointer*(s) point outside the process's address space.

I still do not understand why if I had all the check on and the issue 
occured, why the kernel did not panic. Maybe, running the exact test 
case will help me understand.

Shoaib


