Return-Path: <netdev+bounces-187597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D89AA7FA4
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 11:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6D61BA1A2B
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 09:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16001D7E54;
	Sat,  3 May 2025 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="arkvE+4v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LV9s7gEG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC63D42A8F;
	Sat,  3 May 2025 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746264562; cv=fail; b=nVPav90vBiuLTYL1g2qRhZqHbSoITHN4+iptrlSmDqqWmxU4g3dj7LSSB2jf8bomnJ5oQr6iLKNTP9BQEWcBOSrRIp5rKSCvJi9bfe0UnaWN26+yPaeNrb8ye9hmQmn/t0lsstsQF1eySQcDRQlnY+HW6HbX1ip+khvSzLiGywo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746264562; c=relaxed/simple;
	bh=UNoYckbqD1ZK6+TmM/zd3BkMCozEBA2zcDL9/iiGFjc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kaV7JsB6kOJRtg9h//MblwsV5S8JJN2Se04xgFnFYmJjEiixi6R4Z95rhLq8Y5yslj1/FII3nfg5b9nFp8m+nATh+D+jnaRVheWc4YMK7cIncI0pypcDJArF9ryja2pj8AL0xx4UdRt9V5ib/h9bK+WbhSGzm5VN3SqV+bJzd3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=arkvE+4v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LV9s7gEG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54392Qth029848;
	Sat, 3 May 2025 09:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SVHrHPuHV+ds93MwJJkeCUdtd1QKa1tgGwkEv49jhkY=; b=
	arkvE+4vxUsxk64u0TCDX7G37jgN8J7S05eRvELEb3czK51SVTyNEuR7vl99rD4C
	Xpmr6fRY8oePCrUJamVkKmZL+qb54Mnw3gWM3ziFJ75utYJnnT53trzGGaxBEjP/
	+325d8vgikQAV52DIjnZp7VfzvPM6Ayfn3bLJ5exQPbF5VWX3m1IhL3kKEzL9gtI
	HfY6hn49T2N93OuiUjgIv/e84dOWW3CiuZfhTSgFHzyKqenSBpAcLnuvAG1Evv/Y
	vPk2JgeBzjSSIFjDRYksINMjb+vB7SR1qh6Xq89oHI/POjiu/clfGZ/sv+r4LSu8
	ouY4yx1lq7aXrIbz6DhpWA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46dg5g00h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 May 2025 09:26:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 543710av035355;
	Sat, 3 May 2025 09:26:40 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kceb38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 May 2025 09:26:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWz7GoAhkz49pEsQ5qU35zpd71FKeFAZem8DQn0OHBN13IiqwY1OYD17I7ttO8fktevYu4wdUHvTqTOMRzqyf26MgLT6LzyOcaJ4lsX1g63XlcC4kKDvWtUHUGBDzvxT43qiagQ8UJhX6RGfJQMcYGhr8aeFJKl7YcGB8mj8v+RBhnnGj/Sz37KLCZd3cRG3A4mjOv6H8cSzgnINPoxBu7+jggWFwekosgg7A4/MkWmxfobEbmYq1ttvcozeDp5Wljk2KwL7NRr8Dv0ug+E3cKCAOzPong8gzLvwaqd76uSHcgHSGlx6CJkpFmLDXWCQIs+3KmpkfNyxfEN00untBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVHrHPuHV+ds93MwJJkeCUdtd1QKa1tgGwkEv49jhkY=;
 b=F2Ak/fzw7WPfYaswVgwvEt5CYU6WYqqWc3UowuEg4uIlYosIS5IzdC/Xm/adeXyJeyJMUmt7KJ5TN7nrt8gCfJAJWQHsgg86c14FLnsQwDGMjyCHX/uXoeIFoB/Z0SD20mpVIXtuuIC0c5WOGADhxi5CAj0SW85bbhpxGaCeJSuNm6MTtlkSR3Lj/2BB+xNmtnOj5lYw8+lto3M1KRN9BV7ZDj6Y9JyDEFF+WS8w3gMVyNtNTPF0Rxber0L6Vf2UGkherBrwW+fuwmEJZauOZTq0MLwabY8ups4uIhaRhXQewPl+Nl+HBbylKYrvntXNaW1nbom71lpnDWTa0cUcFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVHrHPuHV+ds93MwJJkeCUdtd1QKa1tgGwkEv49jhkY=;
 b=LV9s7gEGlmEXvfBrUxCV5WQYXvC4tTxMJ0IDYZ3JTBrLDNN0FMwdys4w3Sgx3TDFPLhxbZ7XwcC7OX+w6tECRE9eMZOdysv7Krglcdmk0lrhFeRblxFgPTqoqtOfcGpVLn4Vj7cKDUAtuvAkuRpStFH69IgV/APMnAHcCE79nDw=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM4PR10MB6062.namprd10.prod.outlook.com (2603:10b6:8:b7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.25; Sat, 3 May 2025 09:26:37 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Sat, 3 May 2025
 09:26:37 +0000
Message-ID: <90a12a85-cf44-499d-bc1b-9413eea00954@oracle.com>
Date: Sat, 3 May 2025 14:56:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 07/11] net: ti: prueth: Adds support for
 network filters for traffic control supported by PRU-ICSS
To: Parvathi Pudi <parvathi@couthit.com>, danishanwar@ti.com,
        rogerq@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
        ssantosh@kernel.org, tony@atomide.com, richardcochran@gmail.com,
        glaroque@baylibre.com, schnelle@linux.ibm.com, m-karicheri2@ti.com,
        s.hauer@pengutronix.de, rdunlap@infradead.org, diogo.ivo@siemens.com,
        basharath@couthit.com, horms@kernel.org, jacob.e.keller@intel.com,
        m-malladi@ti.com, javier.carrasco.cruz@gmail.com, afd@ti.com,
        s-anna@ti.com
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pratheesh@ti.com, prajith@ti.com, vigneshr@ti.com, praneeth@ti.com,
        srk@ti.com, rogerq@ti.com, krishna@couthit.com, pmohan@couthit.com,
        mohan@couthit.com
References: <20250423060707.145166-1-parvathi@couthit.com>
 <20250423072356.146726-8-parvathi@couthit.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250423072356.146726-8-parvathi@couthit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM4PR10MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 0038d11a-c08d-4f8e-3a16-08dd8a249a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnhZK0xham9VNGVYdXNaa09kMkR6aVNDcmNqK2M3WWp3alZabmo0ZWV1ajhl?=
 =?utf-8?B?OXhYaUZ5UnpZWmZCQXVsaDdwWEJjY0dEMFEvNHJhWWdkdHkzYkl6bHdtNFAr?=
 =?utf-8?B?M0gvYjY4bUtJamt1STQwbDFaMEdPbGViR0N4R2QrVnhUMFJMV0JPNVEwbjZn?=
 =?utf-8?B?ZXNuSDhoTldWTnN2YW8ybGRRZDNQR0VWK0tPWkQ0dlpCV3RVVHB3V01HNExH?=
 =?utf-8?B?Y29DYTQ0SlV0RGtITllzc0hLQmxzQXhER2JaYm9Lc09tRkZ4MU5BUHdJQWth?=
 =?utf-8?B?ZzJBTjRrRk5mMEJiT3lCL3FycGFicitUd0VIRUhrSzR4cWJQK0xLQ1g2YTVV?=
 =?utf-8?B?Vm1DV3ZjYXBGT3l4aVVseUJPdEFNOHphdjBxT3FTUzhxRWlDNGprVjVKZHpC?=
 =?utf-8?B?WFlUUVB5cmM2N0VhMW92YzlESTg2aGRDQXBsdUpYUFdkZUZ0QS9wQlJQb2o5?=
 =?utf-8?B?S2plb21xN0J6REYxWEtPWFhVbHM2blNOOWd3VmVZZXlrSjlaNXIrdWhIbHUw?=
 =?utf-8?B?cEJOa0RwdUcxV1BqK1FIRlI2clJvcXdXYkRzMFBXSk1HZmVJYVZLd0loWXpK?=
 =?utf-8?B?U1RVUXl5S1ZyZTQ1VGJiMWxqdzdFTHl4VnM2MFo2QmNRTWxEVk9ZZDJ0aTgw?=
 =?utf-8?B?U2xHa21admNaSHZkTkpHWVFGN0VuUzUyNU5RUC90QVVqZmYvQUdlN2V3SE12?=
 =?utf-8?B?aCtRdTh1WE80WHdaR0lxSEJOYllaQ09vcEw3VTlOQTh6THNJdXRnRTErQjFW?=
 =?utf-8?B?a1IrQnVUMVI4bFpySEJ4eGhPNDhQUGVvaUhRWFgrSnVHeEV3VnFKaG5EbGsw?=
 =?utf-8?B?YUlUMWMzT0xsbFY1L09uOEVxeVNtMW5FbWxQV3NGQ3dVK1Q2ZXRjZVd2QUZt?=
 =?utf-8?B?eDEyUER0a0ptNzlXdlJVWDlpUHNpTFNZNUpOazB2c25CaEY2UmtEUnRlM2VZ?=
 =?utf-8?B?K0ZnSmNtMkJYenQ2UEd5U2hIeXBhdDZyck5BQ293T3VBN2RkYmdkeTdFcGtS?=
 =?utf-8?B?TnZZVFhyTEZWVVp4SVVieVJaWEoxaVBkamRVZkdOWDQwbEpFVUxDc2hFUnVH?=
 =?utf-8?B?bEg1YVZnV1lTQlNyZ2RLWmM5Q1h1d1I5YWcxdlVuOVZ1TmtCMCs2QUhLakU3?=
 =?utf-8?B?RUxVM2YyTkVUaDU2Zy95ZGF6V2kycnl2KzJTOVVtcHJuUUpVNnlWcm9pc3ZR?=
 =?utf-8?B?WU1YYmQ0RkZMZ3p0NW5nNzNlcjVPcVcyVE5TTWlybHliYjRpWHJXU29lZi90?=
 =?utf-8?B?SHRJV0ZsRVFuajJWSytBL0p5M0h6WXE5YkljNXU5OStBOWltR2srSVVHWlVY?=
 =?utf-8?B?SEQ3MGpTTTMrd1dJYk9ETXNTL0xyVHhTL0tka3FONnlBbG05dWJyZDd0Slhp?=
 =?utf-8?B?RXhIUlNLMEwxZ0ZXdFdabXl1T3Y1RE9tWmExOXd5MTFSdEk5K0Y3RzY0ZUFj?=
 =?utf-8?B?S1liTEF0YXRydDRZTUY2LytxV2ZtclFsczBNSXdNUEQ0MGd4VGRMWDVkcHFP?=
 =?utf-8?B?WHF1MGFPeEQ5cEpiMUFqYjF1UDNmVytRaVRtdzhnTk1tUlNoeWNhR0NnSDRh?=
 =?utf-8?B?VWFsaHFBQjV4SjhlM1Y2WkFPSmZkUk1KRkhnVlJLU0xkQXNCOHlNUXBqekNI?=
 =?utf-8?B?UGJLYktZNzhDQ0E2VUNZbjhNbTdrY2toRXhWaUg3alBEdU9nL0RnRVNNOGZ2?=
 =?utf-8?B?NWJoWWtzMVY4OXpBcXNRTlY0WFhCQlRGSUZ6NEJhaEJCVW9HYlVrN0dyYVFS?=
 =?utf-8?B?ZnI2STRKMGNSdloydWF6SHQ4cFZWNnFZREhYL3A4aEhib0R1Y3p0TUxYbm52?=
 =?utf-8?B?N1ZmaUtMNXRVQ3hhV3VkZ3lXbk9QWmFuOUYxcFNDZzJWVjgxQ3NVSGFaQjhB?=
 =?utf-8?B?UDNpWE9POHh2eDg5K01KcVRYNWxMMkgzL3Mza0Zhbm9WdWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3JTL0w4RDZPaDBGNHhrNDNVeHJ6VUJZZUZiMGJrV2lpZ2cwcFZsRkpYcnZN?=
 =?utf-8?B?RWVmZVpDYkVpaVBqejZkWWR0ZzVCQi9mck1nY3oyZUpHWFliVVV6WXl1MUhn?=
 =?utf-8?B?aUgvM3VZUEJIeHV1WmNnMGt2VXYrd3V4anl4QlpqWXF6V0ZWSXJPWGcvSXVt?=
 =?utf-8?B?eDNxOFBnekNDVTY0aUxYU3drc2NLVUpFOHdkQzBwZFRIbUNrcXVPT0x3QnpU?=
 =?utf-8?B?Z1hjTlE4bXhjWlp5Z1VMdU1FeWs3eVB4Z0xOTGJKZ0craVI2YWFBWmVuR3Zm?=
 =?utf-8?B?cmN0Y0I1VXVVVm1sTkdaZEIxWHg0YnQ3REVVL0RObU03OHRlMTlITWhrNExu?=
 =?utf-8?B?TmpTdGtXSzI1a0F5MWV4V3hUMVBqM3hnN2g4R0NCSVdTUE1WOWFvcHZkN1BY?=
 =?utf-8?B?cm1DbnZmOThQaXA4YmE5MlM5aWFrZVF4bHNNWnBVaFZTMUZZTmVaU1pVcXNG?=
 =?utf-8?B?aWlaZERaS1Jpa1MwWnlwMHNKWnFDamJGUzdwSXlSWlozaUo3U3FmcTgwb2k4?=
 =?utf-8?B?NEtOWFI2WE9IVzJ6MVF1K3V1eDNWT29LVlZXSlowdk5VSnFYbkZwaTVGNksw?=
 =?utf-8?B?STB0R042UElrUThYT2NMeW1BbGlpbzhTeHJ0Q2pEL010TFFHaDhDVGZwUDBh?=
 =?utf-8?B?RDhEcEc5SldEM2U1MzhLcGc5YUM1OTlzZDFIbEpMZFpmOHpmbnc3VDNiWE5L?=
 =?utf-8?B?WFFwc0NpZTVQeUI4Y3YyaWdOQmxPU3UzZHRNMS93TkRITWE3SmJrVTlMSGIw?=
 =?utf-8?B?NXZ6RjFjRDZHcnE2dUk3dUYwcjFtczZvNHhwR3BoYVczOHYwOGRYQ2xhWGI5?=
 =?utf-8?B?RjV3T0tKb0JGTHh4Sy9Xb0gwMnBEYmdUdWZ3eUVqY3pUVURvOVYySE1XM1l4?=
 =?utf-8?B?eGdPZ1ptNFc0bldyaTZDOXo1N0NXNGtoMXpSaWtLRFkvbXJneFBkZDdjeG03?=
 =?utf-8?B?cE90WEwzQjRtb0FxbG5udXlLa3hqNkNWcTMyUVE2ZnBHTnYvdmxHakNwN0tv?=
 =?utf-8?B?eGsySFlDYzhHRWxQSEhEWXZQUzlha0dEOElCbGtiTHEyNWhVN1QyR2lrR1Ix?=
 =?utf-8?B?cjhieWwwV1hLLzFVYkc1MWdkNVpYS1JqbGdzWnZTb2I5RlE0ZFltc0EyZkJC?=
 =?utf-8?B?WVh1T0ZNU0huZHA3eE45WGFwL0J4aDBrQTNERXFqWUY0bWRFV2cvOFdsYmlU?=
 =?utf-8?B?R01peHFhZzRoSWJyTGF5bEh4TUhnU1BRQnpMMFVxV0paQkpMRHRBWHVjR000?=
 =?utf-8?B?V280MVNzR25xYmFaeVZwTDBkbFJYY0dLUTg5V1J3YUluYko4dCtWcElmNGJP?=
 =?utf-8?B?ME14MHFGcVZ4bk4yV1hsZnVoMjJmUHZaeFdvdDF0YVdCQUhEaFJ5MEdtbm04?=
 =?utf-8?B?eVJtSm1TRGx3ZlVOL2dvbUJTNVdkbG9OaTMxK0xianFXbXlvRkZKNHIvNXdP?=
 =?utf-8?B?anpzeXExbUdmM3k1aElNZlArZG9JNzVoZ1Z1K0tzUm51TWFlUEZLMHRETVA2?=
 =?utf-8?B?RXBxRkRQZ200Q1RVVjB3MUZJY1VkR21udUhkQXBXR1FycTJjdDZXVkQybHZI?=
 =?utf-8?B?UndNY1hXNm04akJPQVBFblY4VWM3KzdYblpIWFZsU1VMSnNURjFLK1BGdkJt?=
 =?utf-8?B?ZkhGbDJTdWxLL2pmOHo4cWJqeUpRTUlzcTVhMXpRa0hjblBjd0ZEdUFveWE3?=
 =?utf-8?B?ak1iSDJlRWZBUG05SVFIU2NrVXJkT2NRUEJiNkR5MVlRWi9BbkNNYVI1dHZm?=
 =?utf-8?B?TGtVYi9FeFhEOElDcUFHazNHYlZ1aDRTQTdXeVFJRzVwZ2dTZWYrdURMTzNH?=
 =?utf-8?B?bmRHSFlDQ2pQU1lYblp6Z2k1UkZlOVE5dzhrbkRFcnpMSzZHT3A0UVU0STdP?=
 =?utf-8?B?bmVpSDhZSWozMHRYc0xNWlBldTFiaVhNM3dYeGNvSTBQbWR6Y2h2UWpiRXdD?=
 =?utf-8?B?MU1RcEZDUHB1R3hhSm1jZTNnSmJQcnFCSE00QUlqbFRYYXVOYnpTN1NXVTg3?=
 =?utf-8?B?NTJ3WDgxMjY1UHArdHlCaHFvcHhQUWxvUzY2UG1oWEdoZEROVTNESWhkSzQ2?=
 =?utf-8?B?Zmw0Zi9uVVhHSlZPV21iRSswSHduakFyT0RIcGJOanl1a29aSFpYcUxWeGdO?=
 =?utf-8?B?VlFETlFDM1pha2Z5bmlQUnRXNEZGb2VHeS9jamMrK2d6aGY3bm1GREN3UG5y?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3saluEVZszVQx61C3CxI12oxub5uXTMhbP+2xYgAIMWvNz4Zrv0mkHqMlE+S+6GeApATSOvkQAFKaZQFF6y14czrSY5C1RaMsL9fJ8iQS8CAuAG87E/WygJAiEABeCRZwTEkmZT7QTIvhuzexxPwilY90RkMkuvuHqHJ2snRi2eqx5xs2hEUv8eUl28/yQZLiduc4mKoPYa4/kyZ/jbsmVyteUN5luEc0N9NRGavEI9sAT6AnIDc7n5wVRQLu+Hu6KN9UJVPA9+9NhcWe1a/+CLjmyO9P2pErGkqWoETAzS++zDuH3NCzThsxMv6cVXK6k+qCKB/dQ1oCWbJdtO8AvAECczypuOAiSr190gkFTo9ztiBZO+wsod3kYsV9cAB/nP2fjO5QYrIKghgfZMOOS6uTJDfN4xRvrgoJ4Q/A+Q2ZFlzJgUgm0AM8/1uvkOuzmVh4hBaqX7WHKGOvR+srBVS7YOpkGRgpnFZcAx+enjYMzvuoww4pNckKT5sGPgaKcGmEConF7VupcxhIQXsclSZBIQNmvp9RiOwh3Vbt3wKQPjzyJUvZxZBT8y8OybKGty/mOcqhN8awUItxOwLMjbA3PXyFp98ytkjo/lxykU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0038d11a-c08d-4f8e-3a16-08dd8a249a61
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2025 09:26:37.1860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9s2yZfMz0rNK+i9Q0xcnoocgS95oc+rMrb00Ps+yzw9Tjx1187oHvoftVFq8QuE3aRLBy+vKiu9TgvB2ipClcXyrMDIm/BP1T4PpDXHl19E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6062
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-03_04,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505030082
X-Authority-Analysis: v=2.4 cv=GLEIEvNK c=1 sm=1 tr=0 ts=6815e152 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=MC2SG-5JKGE4uHR-:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=sozttTNsAAAA:8 a=phHMdyB2EjiPLhRZp2EA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13130
X-Proofpoint-GUID: wC5xz4WSU55mqhtY91V-cfogIynNHAXd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAzMDA4MyBTYWx0ZWRfX1a4DPy8m5HM4 RgsJIXS5ngfrA+Xpa8SiChOJG+hnxffKGVm66JsQv7DPhn725Rqa1HwD/D3NxeHE06UGKbL0YMf cstKEakmSY3wyvKbgnOt9Eeq9zYWR5AWHgxYWQjnGSmJFkpHFA2EdOY9CLWoMZKrHiVF+QwY6tu
 LAL5BS757F7fi16n74SmDDhlhPRmYzpL5Hq/iwKY8owSIiny3GV5Gr4leyIXkxcTYFrLG27r4Kw clX7dajrwCPD37Ddrr3jOMZD+st1npPZBiwy6j1UMKSc6//b/H9xDUMsWXtnkr8OmmUjN8/THNN /p21BhrF3TMwZnrCABn5Cll9s9fzkPMMyrBF6jERPVDRZTJ+KtktSVY1KzQddj5Xhw3G+fyMkpO
 eC5KW0GmlD3PJqw5rJIo0B5uMToUps07IobqkTlGcj9kPwoeL1RPp9QBGMcQsP5nTLt8koUv
X-Proofpoint-ORIG-GUID: wC5xz4WSU55mqhtY91V-cfogIynNHAXd


> +	/* for LRE, it is a shared table. So lock the access */
> +	spin_lock_irqsave(&emac->addr_lock, flags);
> +
> +	/* VLAN filter table is 512 bytes (4096 bit) bitmap.
> +	 * Each bit controls enabling or disabling corresponding
> +	 * VID. Therefore byte index that controls a given VID is
> +	 * can calculated as vid / 8 and the bit within that byte
> +	 * that controls VID is given by vid % 8. Allow untagged
> +	 * frames to host by default.
> +	 */
> +	byte_index = vid / BITS_PER_BYTE;
> +	bit_index = vid % BITS_PER_BYTE;
> +	val = readb(ram + vlan_filter_tbl + byte_index);
> +	if (add)
> +		val |= BIT(bit_index);
> +	else
> +		val &= ~BIT(bit_index);
> +	writeb(val, ram + vlan_filter_tbl + byte_index);
> +
> +	spin_unlock_irqrestore(&emac->addr_lock, flags);
> +
> +	netdev_dbg(emac->ndev, "%s VID bit at index %d and bit %d\n",
> +		   add ? "Setting" : "Clearing", byte_index, bit_index);

VID bit at byte index

> +
> +	return 0;
> +}
> +
> +static int icssm_emac_ndo_vlan_rx_add_vid(struct net_device *dev,
> +					  __be16 proto, u16 vid)
> +{
> +	struct prueth_emac *emac = netdev_priv(dev);
> +
> +	return icssm_emac_add_del_vid(emac, true, proto, vid);
> +}
> +
> +static int icssm_emac_ndo_vlan_rx_kill_vid(struct net_device *dev,
> +					   __be16 proto, u16 vid)
> +{
> +	struct prueth_emac *emac = netdev_priv(dev);
> +
> +	return icssm_emac_add_del_vid(emac, false, proto, vid);
> +}
> +
> +static int icssm_emac_get_port_parent_id(struct net_device *dev,
> +					 struct netdev_phys_item_id *ppid)
> +{
> +	struct prueth_emac *emac = netdev_priv(dev);
> +	struct prueth *prueth = emac->prueth;
> +
> +	ppid->id_len = sizeof(prueth->base_mac);
> +	memcpy(&ppid->id, &prueth->base_mac, ppid->id_len);
> +
> +	return 0;
> +}
> +
> +static int icssm_emac_ndo_get_phys_port_name(struct net_device *ndev,
> +					     char *name, size_t len)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	int err;
> +
> +	err = snprintf(name, len, "p%d", emac->port_id);
> +
> +	if (err >= len)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>   static const struct net_device_ops emac_netdev_ops = {
>   	.ndo_open = icssm_emac_ndo_open,
>   	.ndo_stop = icssm_emac_ndo_stop,
>   	.ndo_start_xmit = icssm_emac_ndo_start_xmit,
> +	.ndo_set_mac_address = eth_mac_addr,
> +	.ndo_validate_addr = eth_validate_addr,
>   	.ndo_tx_timeout = icssm_emac_ndo_tx_timeout,
>   	.ndo_get_stats64 = icssm_emac_ndo_get_stats64,
> +	.ndo_set_rx_mode = icssm_emac_ndo_set_rx_mode,
>   	.ndo_eth_ioctl = icssm_emac_ndo_ioctl,
> +	.ndo_vlan_rx_add_vid = icssm_emac_ndo_vlan_rx_add_vid,
> +	.ndo_vlan_rx_kill_vid = icssm_emac_ndo_vlan_rx_kill_vid,
> +	.ndo_setup_tc = icssm_emac_ndo_setup_tc,
> +	.ndo_get_port_parent_id = icssm_emac_get_port_parent_id,
> +	.ndo_get_phys_port_name = icssm_emac_ndo_get_phys_port_name,
>   };
>   
>   /* get emac_port corresponding to eth_node name */
> @@ -1567,6 +1865,7 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
>   	emac->prueth = prueth;
>   	emac->ndev = ndev;
>   	emac->port_id = port;
> +	memset(&emac->mc_filter_mask[0], 0xff, ETH_ALEN); /* default mask */
>   
>   	/* by default eth_type is EMAC */
>   	switch (port) {
> @@ -1608,7 +1907,9 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
>   		dev_err(prueth->dev, "could not get ptp tx irq. Skipping PTP support\n");
>   	}
>   
> +	spin_lock_init(&emac->lock);
>   	spin_lock_init(&emac->ptp_skb_lock);
> +	spin_lock_init(&emac->addr_lock);
>   
>   	/* get mac address from DT and set private and netdev addr */
>   	ret = of_get_ethdev_address(eth_node, ndev);
> @@ -1637,6 +1938,10 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
>   	phy_remove_link_mode(emac->phydev, ETHTOOL_LINK_MODE_Pause_BIT);
>   	phy_remove_link_mode(emac->phydev, ETHTOOL_LINK_MODE_Asym_Pause_BIT);
>   
> +	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_TC;
> +
> +	ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
> +
>   	ndev->netdev_ops = &emac_netdev_ops;
>   	ndev->ethtool_ops = &emac_ethtool_ops;
>   
> @@ -1689,6 +1994,7 @@ static int icssm_prueth_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, prueth);
>   	prueth->dev = dev;
>   	prueth->fw_data = device_get_match_data(dev);
> +	prueth->fw_offsets = &fw_offsets_v2_1;
>   
>   	eth_ports_node = of_get_child_by_name(np, "ethernet-ports");
>   	if (!eth_ports_node)
> @@ -1875,6 +2181,8 @@ static int icssm_prueth_probe(struct platform_device *pdev)
>   			prueth->emac[PRUETH_MAC1]->ndev;
>   	}
>   
> +	eth_random_addr(prueth->base_mac);
> +
>   	dev_info(dev, "TI PRU ethernet driver initialized: %s EMAC mode\n",
>   		 (!eth0_node || !eth1_node) ? "single" : "dual");
>   
> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.h b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
> index 1709b3b6c2be..8a5f1647466a 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.h
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
> @@ -28,6 +28,9 @@
>   #define EMAC_MAX_FRM_SUPPORT (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN + \
>   			      ICSSM_LRE_TAG_SIZE)
>   
> +/* default timer for NSP and HSR/PRP */
> +#define PRUETH_NSP_TIMER_MS	(100) /* Refresh NSP counters every 100ms */
> +
>   #define PRUETH_REG_DUMP_VER		1
>   
>   /* Encoding: 32-16: Reserved, 16-8: Reg dump version, 8-0: Ethertype  */

remove extra ' ' after Ethertype

> @@ -293,6 +296,29 @@ enum prueth_mem {
>   	PRUETH_MEM_MAX,
>   };
>   
> +/* Firmware offsets/size information */
> +struct prueth_fw_offsets {
> +	u32 index_array_offset;
> +	u32 bin_array_offset;
> +	u32 nt_array_offset;
> +	u32 index_array_loc;
> +	u32 bin_array_loc;
> +	u32 nt_array_loc;
> +	u32 index_array_max_entries;
> +	u32 bin_array_max_entries;
> +	u32 nt_array_max_entries;
> +	u32 vlan_ctrl_byte;
> +	u32 vlan_filter_tbl;
> +	u32 mc_ctrl_byte;
> +	u32 mc_filter_mask;
> +	u32 mc_filter_tbl;
> +	/* IEP wrap is used in the rx packet ordering logic and
> +	 * is different for ICSSM v1.0 vs 2.1
> +	 */
> +	u32 iep_wrap;
> +	u16 hash_mask;
> +};
> +
[clip]
> @@ -0,0 +1,120 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/* Copyright (C) 2015-2021 Texas Instruments Incorporated - https://urldefense.com/v3/__https://www.ti.com__;!!ACWV5N9M2RV99hQ!Pnt8LQPwsRI73TtUPzBpwVw_Cn90DbuNXinXJ5m2isPHfFxjNTp4JBlr6UedPapFerELKSzV4SFNoiUfE1xa8g$
> + *
> + * This file contains VLAN/Multicast filtering feature memory map
> + *
> + */
> +
> +#ifndef ICSS_VLAN_MULTICAST_FILTER_MM_H
> +#define ICSS_VLAN_MULTICAST_FILTER_MM_H
> +
> +/*  VLAN/Multicast filter defines & offsets,
> + *  present on both PRU0 and PRU1 DRAM

remove extra ' '

> + */
> +
> +/* Feature enable/disable values for multicast filtering */
> +#define ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_DISABLED		0x00
> +#define ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_ENABLED		0x01
> +
> +/* Feature enable/disable values  for VLAN filtering */

remove extra ' ' after values

> +#define ICSS_EMAC_FW_VLAN_FILTER_CTRL_DISABLED			0x00
> +#define ICSS_EMAC_FW_VLAN_FILTER_CTRL_ENABLED			0x01
> +
> +/* Add/remove multicast mac id for filtering bin */
> +#define ICSS_EMAC_FW_MULTICAST_FILTER_HOST_RCV_ALLOWED		0x01
> +#define ICSS_EMAC_FW_MULTICAST_FILTER_HOST_RCV_NOT_ALLOWED	0x00
> +
> +/* Default HASH value for the multicast filtering Mask */
> +#define ICSS_EMAC_FW_MULTICAST_FILTER_INIT_VAL			0xFF
> +
> +/* Size requirements for Multicast filtering feature */
> +#define ICSS_EMAC_FW_MULTICAST_TABLE_SIZE_BYTES			       256
> +#define ICSS_EMAC_FW_MULTICAST_FILTER_MASK_SIZE_BYTES			 6
> +#define ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_SIZE_BYTES			 1
> +#define ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OVERRIDE_STATUS_SIZE_BYTES	 1
> +#define ICSS_EMAC_FW_MULTICAST_FILTER_DROP_CNT_SIZE_BYTES		 4
> +
> +/* Size requirements for VLAN filtering feature : 4096 bits = 512 bytes */
> +#define ICSS_EMAC_FW_VLAN_FILTER_TABLE_SIZE_BYTES		       512
> +#define ICSS_EMAC_FW_VLAN_FILTER_CTRL_SIZE_BYTES			 1
> +#define ICSS_EMAC_FW_VLAN_FILTER_DROP_CNT_SIZE_BYTES			 4
> +
> +/* Mask override set status */
> +#define ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OVERRIDE_SET			 1
> +/* Mask override not set status */
> +#define ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OVERRIDE_NOT_SET		 0
> +/* 6 bytes HASH Mask for the MAC */
> +#define ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OFFSET	  0xF4
> +/* 0 -> multicast filtering disabled | 1 -> multicast filtering enabled */
> +#define ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_OFFSET	\
> +	(ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OFFSET +	\
> +	 ICSS_EMAC_FW_MULTICAST_FILTER_MASK_SIZE_BYTES)
> +/* Status indicating if the HASH override is done or not: 0: no, 1: yes */
> +#define ICSS_EMAC_FW_MULTICAST_FILTER_OVERRIDE_STATUS	\
> +	(ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_OFFSET +	\
> +	 ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_SIZE_BYTES)
> +/* Multicast drop statistics */
> +#define ICSS_EMAC_FW_MULTICAST_FILTER_DROP_CNT_OFFSET	\
> +	(ICSS_EMAC_FW_MULTICAST_FILTER_OVERRIDE_STATUS +\
> +	 ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OVERRIDE_STATUS_SIZE_BYTES)
> +/* Multicast table */
> +#define ICSS_EMAC_FW_MULTICAST_FILTER_TABLE		\
> +	(ICSS_EMAC_FW_MULTICAST_FILTER_DROP_CNT_OFFSET +\
> +	 ICSS_EMAC_FW_MULTICAST_FILTER_DROP_CNT_SIZE_BYTES)
> +
> +/* Multicast filter defines & offsets for LRE
> + */
> +#define ICSS_LRE_FW_MULTICAST_TABLE_SEARCH_OP_CONTROL_BIT	0xE0
> +/* one byte field :
> + * 0 -> multicast filtering disabled
> + * 1 -> multicast filtering enabled
> + */
> +#define ICSS_LRE_FW_MULTICAST_FILTER_MASK			 0xE4
> +#define ICSS_LRE_FW_MULTICAST_FILTER_TABLE			 0x100
> +
> +/* VLAN table Offsets */
> +#define ICSS_EMAC_FW_VLAN_FLTR_TBL_BASE_ADDR		 0x200
> +#define ICSS_EMAC_FW_VLAN_FILTER_CTRL_BITMAP_OFFSET	 0xEF
> +#define ICSS_EMAC_FW_VLAN_FILTER_DROP_CNT_OFFSET	\
> +	(ICSS_EMAC_FW_VLAN_FILTER_CTRL_BITMAP_OFFSET +	\
> +	 ICSS_EMAC_FW_VLAN_FILTER_CTRL_SIZE_BYTES)
> +
> +/* VLAN filter Control Bit maps */
> +/* one bit field, bit 0: | 0 : VLAN filter disabled (default),
> + * 1: VLAN filter enabled
> + */
> +#define ICSS_EMAC_FW_VLAN_FILTER_CTRL_ENABLE_BIT		       0
> +/* one bit field, bit 1: | 0 : untagged host rcv allowed (default),
> + * 1: untagged host rcv not allowed
> + */
> +#define ICSS_EMAC_FW_VLAN_FILTER_UNTAG_HOST_RCV_ALLOW_CTRL_BIT	       1
> +/* one bit field, bit 1: | 0 : priotag host rcv allowed (default),
> + * 1: priotag host rcv not allowed
> + */
> +#define ICSS_EMAC_FW_VLAN_FILTER_PRIOTAG_HOST_RCV_ALLOW_CTRL_BIT       2
> +/* one bit field, bit 1: | 0 : skip sv vlan flow
> + * :1 : take sv vlan flow  (not applicable for dual emac )
> + */
> +#define ICSS_EMAC_FW_VLAN_FILTER_SV_VLAN_FLOW_HOST_RCV_ALLOW_CTRL_BIT  3
> +
> +/* VLAN IDs */
> +#define ICSS_EMAC_FW_VLAN_FILTER_PRIOTAG_VID			       0
> +#define ICSS_EMAC_FW_VLAN_FILTER_VID_MIN			       0x0000
> +#define ICSS_EMAC_FW_VLAN_FILTER_VID_MAX			       0x0FFF
> +
> +/* VLAN Filtering Commands */
> +#define ICSS_EMAC_FW_VLAN_FILTER_ADD_VLAN_VID_CMD		       0x00
> +#define ICSS_EMAC_FW_VLAN_FILTER_REMOVE_VLAN_VID_CMD		       0x01
> +
> +/* Switch defines for VLAN/MC filtering */
> +/* SRAM
> + * VLAN filter defines & offsets
> + */
> +#define ICSS_LRE_FW_VLAN_FLTR_CTRL_BYTE				 0x1FE

lowercase hex please, all place.

> +/* one bit field | 0 : VLAN filter disabled
> + *		 | 1 : VLAN filter enabled
> + */
> +#define ICSS_LRE_FW_VLAN_FLTR_TBL_BASE_ADDR			 0x200
> +
> +#endif /* ICSS_MULTICAST_FILTER_MM_H */


Thanks,
Alok

