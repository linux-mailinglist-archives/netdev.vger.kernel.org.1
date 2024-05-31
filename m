Return-Path: <netdev+bounces-99672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CCB8D5CA5
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 10:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B7B1C2229A
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B6574053;
	Fri, 31 May 2024 08:24:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CC276413;
	Fri, 31 May 2024 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143857; cv=fail; b=MwZD2nTFclDHaqlwTPQaNmZhF8Xp3/561euwCZz9uhFw75o4iSL5oZ9VzhU0soLUIuqBFSf5g2XAQdxSoKUP6XGBI4VBB0J3553iNMIXnUkJCjR5AVJyu1NGYsW2/6Ks32kjVlKA6HlUeukWMnCdhIPHMDBp35pgDIMIMR6e/sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143857; c=relaxed/simple;
	bh=g5dgjxXHOGPIZaXpIVTi9GLCtHaghX1x6RHhvNI+WF0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gctEtjlzEpj1FCuWst1Y5E5s27sFwQIktM3usDnFX9q3VfRUM+lf6/hMxo0eOJTKRquSgOOnGfCFZcqxTjY7PiUhmngf/YoIBoLq/zOpp1+pcaCGoL/NGf5sXdU6WCLYM8q2UnRzpQvjD7DoKb3kh2db7pxcTTcU0ReaRI8GRW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V4jvPK031819;
	Fri, 31 May 2024 08:23:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yf5w9879m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 08:23:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOGcDzDSStG0IU5iWqDQ83ttRvt4UHaSZ5gSVJ4Wm8zavh9NAJ8o+YgTMlFo+1gY2jrJE0QF6Bk1fL6FepykE8+Mcnn+dWFs7EdNiDXHF8IVMrn5Fv/gmUAyYUJVBNdlN78Pcg8T6DlIHc+WVaJ2ILQHRIZR38NYLVH3i0Rtf2fWXjj05B/S/bO8qHy/fUjyTfWg8CbR7MmKJYS73OQDzYQ05Td6+JtC6rEdlMa5LnmzVK7voTM3PkKu7/QyFSVIcW1GG/h2M6HVDHaRYLSKmveVgrK4+jThxhlQG2r7ZeNr9IwhannnEzBfnf+iIc2dmUpW6NIyO8HGwNtsyv24nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5dgjxXHOGPIZaXpIVTi9GLCtHaghX1x6RHhvNI+WF0=;
 b=RB7BmqaroeiLM6gTzihGbaLjpTD2JEgMD6+70VyMmbTDfhLWCDXkVGlhsosIkzSXHFwSYXtjLUM2gln126oREsSZiu69BVLVcafbSSBzo9W5k2QkcRR3O4iKHNLLlkMUASfBX6g47qfU5zU/Ip80AoKZJ9pSWQwCmqy3+wTxE/tZ50YPeVVkA9vBax+zZCu37xrihotu97HRrK35gFqLSvvR3H6mBPQtULFilNFyliq3hceWKbPqjyPxAruGh4d9KxP1M1cxOVo2dGTZ0unve6s0XwYePNBxdbR7OW2uOZIcob/Fi4PcbpYZjjEH/utfp+4d36WkFWJ60DCvrFCPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH8PR11MB6880.namprd11.prod.outlook.com (2603:10b6:510:228::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 31 May
 2024 08:23:28 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 08:23:27 +0000
Message-ID: <f01f3be2-5185-49e0-91ab-cf3ffabdf9d0@windriver.com>
Date: Fri, 31 May 2024 16:23:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net v2 PATCH] net: stmmac: Update CBS parameters when speed
 changes after linking up
To: Vladimir Oltean <olteanv@gmail.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20240530061453.561708-1-xiaolei.wang@windriver.com>
 <f8b0843f-7900-4ad0-9e70-c16175e893d9@lunn.ch>
 <20240530132822.xv23at32wj73hzfj@skbuf>
 <ZliBzo7eETml/+bl@shell.armlinux.org.uk>
 <20240530135335.yanffjb3ketmoo7u@skbuf>
 <ZliJ2O+bj18jQ0B8@shell.armlinux.org.uk>
 <20240530143522.32c5lhkg42yiggob@skbuf>
Content-Language: en-US
From: xiaolei wang <xiaolei.wang@windriver.com>
In-Reply-To: <20240530143522.32c5lhkg42yiggob@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0228.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::7) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH8PR11MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: d55afb14-b076-42d2-499e-08dc814af271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZE9YRkF4TGtCcnJPM2FoRDErRS9RSFZ6Q3BmYWNHelA5ZmUwdVVjVXFiOTJn?=
 =?utf-8?B?ZDJqL2RxY2NMNEFramR3dVJuVFNiVUo1ZDQzWTk1WndiSlRRVWd3Z0xSenBL?=
 =?utf-8?B?K25pNzk4RUVNVnVTeFY2RTdDMEtMaWQ1N042OGQ0NWNuMFZBd2x3R0NSRmh5?=
 =?utf-8?B?aXZMTGdIOGZBVVB5TXk4UzlrMVpCQjJUbnJWME1kV21hWlY1Z3NERG5ZQ3JF?=
 =?utf-8?B?bW1IVlZTa01TaWlISDRRN1laTWZ4VVA4VFRCYTBUWkk3ekRRdzVvN2tYVEQ5?=
 =?utf-8?B?QTNSVzlGV1Eyek1xaGdXdWJNSUZEL3JtRFJ0a2ZWRVh5SUpuQmFyclRvUnNr?=
 =?utf-8?B?ZFFFUjRNaHNONXoraHczSktIQzNYOEN4SFJnbUw1bWlBRXFNSXp6bTJJMGs3?=
 =?utf-8?B?K2wrN0xVYndub3VBMTFOdmNkRldFM1E4bTQyaFpSNUdNQlVTeTlDUzJoc21w?=
 =?utf-8?B?NWlSM2NOQkRrOVI1Tm9rR0MwVEdEMW9jM080ckFsSytVYkk3TzhacUR4UUtN?=
 =?utf-8?B?K2x3VVhTSy82MGVDZkxvSGpxSHdUVlpFUWR2WHpOc1JiYVNma09TTnNJcjcw?=
 =?utf-8?B?RlZKSTMzMDBWTnJseklscVhVVm84cDVWWjM3V0VicnhPOXpxUGJFajR0NHZt?=
 =?utf-8?B?MkhyZlhXaERWcG0vRzAvVk9md1g2QmtmVldRbFJhZDVHUU1xR0JMaGhQc1FK?=
 =?utf-8?B?TVN5dXQwVTdmQXc3OENQUEhGaUhtbXcvbU4yZC9vQTVCNDJzVGxmWm9mUWE4?=
 =?utf-8?B?azBOOHNwYU5iUlR4VVpIYTJ6Mi93aUQzcTByRWNUcE5Jckp5L3Jlamw0UzFr?=
 =?utf-8?B?RzJSTmpjZlY2K0xxYngxU0ZMT2RBVS82WEZiWkZEMlZiT3F2a0RNWW5tKyt3?=
 =?utf-8?B?eDhpUy9tTnRCVTZtazcxSlhyeWhEaDg2YXV4RGY3dk1YSmswTndFdjRtdUNS?=
 =?utf-8?B?QkwrYi9QcGRGd2V4L3lGeVQ2SWlVeGlRbmpHT01QS0piMnBwVUpMQXdneUR2?=
 =?utf-8?B?c0l2NjVPVk1JRGdKN3BJcW5vSFlLNEIxVmFiWVNTZGprYnFRWmcyVFZRZ3hX?=
 =?utf-8?B?VTZPV2ZDU0ZJUXJTRGsxMTMrSkZleS9pWFJsbmFkaGJMdEJrcy9PNUZpV2tT?=
 =?utf-8?B?WDBvUnFXY1NtakJtSmlOQkN3ZDZPMldqRFlRc3pCYmRuMldPTklmdUVhckZh?=
 =?utf-8?B?ZFB3SVBVVTlTK1EvZXI3N3d0dWpGQ0FIUWFiVFM2T1pZcTVCYWdMTW5wdUdM?=
 =?utf-8?B?aTRNNzlKcnRqM0cyYUYwODNuYnhRUkEyMmp0c0REc0FpWGZnSENocWZRY1k3?=
 =?utf-8?B?a0luU2NOWXFHZ2ZvS2RqcXFJbzFyd0JwTFAvVC94S3RCdFVTbDIxUTlsdjF1?=
 =?utf-8?B?Y0h6K29adHRjTCtjWDhqN2NYUHNhWWhIakNMOFdpWEs1OEsvM1gyQlAzWUY0?=
 =?utf-8?B?SVhDMFZEaHJlbHdBSWNYSmJld0JVNlZMNjZaQStnSVZoTW45N3doRmxvQjFt?=
 =?utf-8?B?dE5wOUg3WGVDS0l5eXRrUWREcFQ0eXV2RmVKdzNFTDIwUkZpVGNWa0NEanA3?=
 =?utf-8?B?Y2tMckxMU2tvVHNxRElteW5pU1NGU3REQ3pSUnlOWVlYa2VIQWNOZlRlSUx2?=
 =?utf-8?B?eDljeTYwQVZ6N2xVWkppelR6RG93SFNpcCtHYzJ6VXBFQWhzc09zZVV1ZDds?=
 =?utf-8?B?R0lick4zOGEwUjl1SjlzN3JqV1N6SmdLQmdLcVpUU043Q0lCZ3p3Z09BPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MnhTcVgwSnM0VTRwcGVRUWswN1g4UVM0RHkydm5EN1o0WXQ1MmVVcmQ2Rjlj?=
 =?utf-8?B?WWZUY0NHTXlrQ2hlRFppajlsSzM4VWhJZnEyTXFhRTZDWGx2cXI0b0tMTkJu?=
 =?utf-8?B?SEdzZ05uSWxENDB0Tm9BMWVFZE44RzJQSnhnVXV1T3pqUlNnN0k5b1JRaDhy?=
 =?utf-8?B?Z1psR2JSSUpjWXRmWXltU1lCODlGMFBzMU1lS0ZmMU1xQjI1SjUxd1hzdTFa?=
 =?utf-8?B?U1V3ZExCS291K3BseG9lVnpNNjRobkRSMGVubTlsWVUyZ01HOE5oSlJhckV5?=
 =?utf-8?B?STdob1plMEhIY2hzbm8rMVpkNTBmZlVhZWJ2Y1c4UmIwMm52M2NwNFIwUGl1?=
 =?utf-8?B?OUtIWDVPNUlqUVV2Q0FEVjFldUZObnM4U3JBR2dMblpER1FKaVVSY2t0WDI2?=
 =?utf-8?B?d2VLOURwZ1hIaDNmWFBTcG8wTTRSeXErbU1HQlovQVIwei95SDcwWnNWYmVs?=
 =?utf-8?B?OE5XUjgySmlJUFl4ais3L0pHRTRnWkF2cHRiYW44RUlSUnFoNTc1bm9pbjd0?=
 =?utf-8?B?ZU9NLzdpZWZoWVYvL2NhNWFKR256QVptMkVlZlk4cmRxYUJQaDBRYi9rVmU2?=
 =?utf-8?B?OXMyMmVEN0pEVTJrMTJjZ3NjWWJMempPNEdQUnA4YjBSM1hkb1R5RS9vTll6?=
 =?utf-8?B?RmxxYXRVRzRGZURNY3ZIaGl1ZGFLdW5nY0h6dW9xQ0FJTU5uVENTNHAvWUlT?=
 =?utf-8?B?WStoczFmTEhKSE1GWXVzaTIwVVUwS3haOVRUTzhORmwrQis4aEc1WDk4T2E4?=
 =?utf-8?B?RUVad3hvY1RJT0p4dy8xdUpPd1BVcHgvKy9tQmRpOVRrR283M0hEb3NrSjMv?=
 =?utf-8?B?SjJ0OUljUk10V0J3ZmE0NDhCWW5YYzVQa3MzSnlxenRaTnFmR3Jia29IUmxp?=
 =?utf-8?B?ZVlxSjZFN3lkOFB3dklMRHFnOXljUXVTOEdDcmFncjNlajZpM0oxL1FVa1RM?=
 =?utf-8?B?RmhncW9OZXhSSTBERmRWUlVQSHg1dkZ0L3gxeXJQVWJTS21CWjFwUU9iTkQ0?=
 =?utf-8?B?VWdqelNFb0lZSld4dVNWWFoxSFhGNzlqK1lXWEk1SVlMRmc0RXRCMjNHVWZK?=
 =?utf-8?B?ZmZaQWwzempKV09ISXhtM3JMUlRuK0J3eURTQm1LVk5rT0pnam1HTTR1K1Ev?=
 =?utf-8?B?T0owRTRtaUZDRmd4MzQxY2kwanRhQ05KQWJaclR0RUNYcmM2U2g5OWVONCtZ?=
 =?utf-8?B?OFFSK0R1bE5PV1QyaklRNUxXbGxiNHhkRWQ2MTR0NVArTmxoL09XK2VEd0xi?=
 =?utf-8?B?TFhFSUZPTmZQaXVzVkxUelM1amk3bVVHNTZjenNZVHIwRVRGZ1FBMHZLTnV2?=
 =?utf-8?B?S1Nsa2kyUVZBalZ0VGcvUTJSaHc3UDNNS2RybWtva3RNRjFjYzB6SDVDWHlm?=
 =?utf-8?B?TlpiQ1Z0Y1lZNi9jdUo2cHVkcEwzVVdvcEJzK1h0R2UvN0g0OXFGcm9YOHIr?=
 =?utf-8?B?QjV3cXZXNi81RFV0U2NmbHdsU2ZLbTdyWDdiVFlTYTljTTZNcndpZjdkeVR6?=
 =?utf-8?B?dUtFZVJCbGlEVldrNVB3VHpoT0RMbHRacnlMMCt0K3JBK1QwUjZRdHhiRCtG?=
 =?utf-8?B?L1hwbVo2NFRxRVQ1RUNtZE9BSnpYdEpIdnVrZ2dXbERkdVNUTEJPODcvSEN4?=
 =?utf-8?B?RnN0NGRaWlVTdWpXRXJ5bm12bGprZ28vNklaUWV1UXFEUDBtSFc5a3VhUXly?=
 =?utf-8?B?UkkwYnczYmtHWi9NVjd3QVBrd2pXNWtlWUxrYitWU0FabDh3R09nUEsrL0Jy?=
 =?utf-8?B?TGdTS2pBQ2lsS3krNlRocExXQjlXVUo3RWJVMzdwd2hseG1mQTVNOHJoTzFT?=
 =?utf-8?B?U21aVDRPR2hBTUJmN256VWRkRW4zeG8zRjh4c2NEbG1mRXNDa2EyeFNaQVZC?=
 =?utf-8?B?NW1XU2d5R01IbjZmclhqRHdHbjRKNkswSUhGZ0pmYU5TSzEzSlluRVlSemxp?=
 =?utf-8?B?WWxFRzI1THJOTStsVnJBUUpwQnVPYTBQS0dPak9YSE9MWXNybkZJamV3RnYy?=
 =?utf-8?B?Qm9uWFBTQzdkR2J2T1JaV3JaVTFlQTFBeVRpNm92T2VGTGJTdUxYWXVTVk9P?=
 =?utf-8?B?aWtLaHlWQS8zbXJramJqWk9xbnI5UlpJbzUxeXgzSmRYYnV0aUdpdEtxMHdw?=
 =?utf-8?B?em1GZzZDb3M3TzIzUTQrL0FyZjVOM2lUVlZ3UjRKakJqMDZYNEhEclc4VEtK?=
 =?utf-8?B?STNQV1VTNUh4NGVwUFFjWk1lQUVPQVE1TzJFS2VSSmkralRZTXNmSk1RdEdt?=
 =?utf-8?B?NlJkNlpKRUJnTXVkL3QvdHdGUHNBPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d55afb14-b076-42d2-499e-08dc814af271
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 08:23:27.6114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEu0+d9lDK5B6Y07WDt6xkvqWVcTbibNvblmg8A7FqIXgvjVlCdXEvs7ZhielwZN354241AxRkBDr5X1yBM3/LwvP2sF+N3svewQC0aVFec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6880
X-Proofpoint-ORIG-GUID: LWcBSC5xEEBvbNHEiSMI2tBWXUzwavDE
X-Proofpoint-GUID: LWcBSC5xEEBvbNHEiSMI2tBWXUzwavDE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_04,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 clxscore=1011 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2405170001 definitions=main-2405310062


On 5/30/24 22:35, Vladimir Oltean wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Thu, May 30, 2024 at 03:14:48PM +0100, Russell King (Oracle) wrote:
>>> I don't see why the CBS parameters would need to be de-programmed from
>>> hardware on a link down event. Is that some stmmac specific thing?
>> If the driver is having to do computation on the parameters based on
>> the link speed, then when the link speed changes, the parameters
>> no longer match what the kernel _thinks_ those parameters were
>> programmed with.
>>
>> What I'm trying to get over to you is that what you propose causes
>> an inconsistency between how the hardware is _programmed_ to behave
>> for CBS and what the kernel reports the CBS settings are if the
>> link speed changes.
>>
>> It's all very well saying that userspace should basically reconstruct
>> the tc settings when the link changes, but not everyone is aware of
>> that. I'm saying it's a problem if one isn't aware of this issue with
>> this hardware, and one looks at tc qdisc show output, and assumes
>> that reflects what is actually being used when it isn't.
>>
>> It's quality of implmentation - as far as I'm concerned, the kernel
>> should *not* mislead the user like this.
> I was saying that the tc-cbs parameters input into the kernel should
> already have the link speed baked into them:
> portTransmitRate = idleSlope - sendSlope. In theory one could feed any
> data into the kernel, but this is based on the IEEE 802.1Q formulas.
>
> I had missed the fact that there is a calculation dependent on
> priv->speed within tc_setup_cbs(), and I'm sorry for that. I thought
> that the values were passed unaltered down to stmmac_config_cbs(). So
> "make no change to the driver" is no longer my recommendation.
>
> In that case, my recommendation is to do as sja1105_setup_tc_cbs() does:
> replace priv->speed with the portTransmitRate recovered from the tc-cbs
> parameters, and fully expect that when the link speed changes, user
> space comes along and changes those parameters.

I will try it

thanks

xiaolei


