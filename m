Return-Path: <netdev+bounces-218358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC34B3C295
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 20:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600825A1454
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 18:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C20335BCC;
	Fri, 29 Aug 2025 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A0m5rkqL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tihQlXcH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839F0343207
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492772; cv=fail; b=mZSvtka2dyjWa3omNkB6JQWiSvxMImquSPgY+IrbMCy9TAEk7vFed+WD9Cnr/UyVWLNGaigcxdCImS0SmSKZVQx7icTp/1mVrPZZgh+w+m9gzLEnas8HlZNKVDW8+ArxzpDr1w6SH1wTkv9aZlIqsB+QdEEIr3uFIaEsvEdScPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492772; c=relaxed/simple;
	bh=D1T7eM8BlIEKCYQ48znnbVII88scGF8dwj2yCUKBolw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kDvNmiQM4hJyw7zdy3jxxb6cgYqV5EptCy2+WqrS7cDjehi8k+Txo26lNdFrZF1buScj7GXzeb7DSw7GZeSIMWMrOqh3Nigywqq83sGgHXF0CLyjIHIUGFr6hrT8+dc5kHahYtICW0rISHnKLgWjiIsCg/OiTvQ7unnuNQow+hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A0m5rkqL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tihQlXcH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TGfk6Y013377;
	Fri, 29 Aug 2025 18:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=evmDwRY7uNX+bHmm6JfY0bTJ/JcTFLFqNKXRJAifZ5M=; b=
	A0m5rkqLSkSj64abnTN91GHkTkj+hTt1uxkKEqsLNCck0lYMjULBvzb6SCanc+oJ
	MWIV6cYtr2GO+qPvz7ac+ulgH8jwUw2i5Bj2Vuq8qQoyJvaPIrQhGVpI2AT2QrW3
	JbvK3Y8B/0TJ/C6DUl7RRakY5Dwxv/oKWyoOpx4yn2YgniwBSDSmtbhCAUKBDc1t
	PtoxJAXpyQzVV2dsBPP/3hcQtwgQYo5vUtcjrGwlK4PV74g3apD7cdntUiTeYBbV
	0184gsm/D8ISuKdnl9FNSRkEqGwQIYm6zHflx5m8okiPXEuZbESSPlcGlYP+N5Ce
	jZsj66qmibiw7iv20ToBOQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4jau296-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 18:39:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57TGw3aJ014695;
	Fri, 29 Aug 2025 18:39:22 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43dfa2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 18:39:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pgpf/4UdURfY85WmnKB8pyzFWM+WEzySlqxjQR97EP+tuJ936z0c9T+NlaZS5NEd0lnFgcsDavs/XptGd6Nmyu50ZrcxydMIPj7wsFrRkL1Z4KHmdCqHL7CzeF8mjXvMK+f6/ZFU9Zs78eZwOVmK3f1ByuK9dVNjkYfRIub8iP4awD6Y86cyagoLRCcZcGT8MBhO3p6BuiaNoDQrb69GdYR8+y1f6kRsd46cc3uTSk6ByHgOc5iXlzVszszItIztoZWRtfBl2Gjkrdqq2b6eyvA0O9GKCOjLmoAZBJMz7FRhrojedMFZ7E4FnkNMledH+AojtLXhimAAblU3XO23Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evmDwRY7uNX+bHmm6JfY0bTJ/JcTFLFqNKXRJAifZ5M=;
 b=VWrEUpJMuMt534zsjlMPKvO04CKdKxoc+kXNvrzkkqUdzXXBNC9Ej5gHnHgAZQ6/ADa9qzhX3uSzzcl1+mdxRc818Q/uCfMflv3YyE5Dabf4yRz5pLIUy+xhnZmjuEx6hRs4bajzu6+U3O+WeSz7MtpdAbBwTgqwcsZvtjPKpwed9u8uUP1F+oBtF9TYFe4pqDn12x5CDr3XbUM6Sy6jj5dDQwVvNqt6NHD082lhVo/RIR4TTUbPbbK4uFbyV/VDC36YckGlF0CNkgt2kMbMZ/hy/mAgagyJaJtfc9UYxEjLYUkCjgltRuMs0l4A7Ywt3xW9dajrjSpUBU7tQimuwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evmDwRY7uNX+bHmm6JfY0bTJ/JcTFLFqNKXRJAifZ5M=;
 b=tihQlXcH2tNIf7Zfm1/j6AhbDdtg3rWWr3R2kYj80Ja4Oavwmv79PE8uLTXdwqtwBWQEcbTtLVq2GyJiNCFC/vedrzR+SlUSve9BAD1weIQHTW6s6k//NOP+dBIA4LIuQcfqInAhn8M5/x7xrxGYteiMYNyFYoFCPV83Rb4HmEM=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by BY5PR10MB4210.namprd10.prod.outlook.com (2603:10b6:a03:201::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Fri, 29 Aug
 2025 18:39:19 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9073.017; Fri, 29 Aug 2025
 18:39:19 +0000
Message-ID: <a4532ca7-fee8-486a-9c5f-6fccb6de7b40@oracle.com>
Date: Sat, 30 Aug 2025 00:09:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/11] virtio_net: Implement layer 2 ethtool flow
 rules
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
        mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com,
        virtualization@lists.linux.dev, pabeni@redhat.com
Cc: parav@nvidia.com, shshitrit@nvidia.com, yohadt@nvidia.com
References: <20250827183852.2471-1-danielj@nvidia.com>
 <20250827183852.2471-7-danielj@nvidia.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250827183852.2471-7-danielj@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::17) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|BY5PR10MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8942bd-27c4-4b70-3cf1-08dde72b5d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3k4ampXcjZJeVpDb0Z4azBobG5KZWRGK0tXQ25rSTNpdW9Nc1gwV0Uwampn?=
 =?utf-8?B?NW5HdzQrekltMDQxRkh3L0NtYXE1Q0p4WTg0YWdMQytHcFllTDl2REVPYlBZ?=
 =?utf-8?B?TW1Qaml2TU1OcWI4THBMM1pkZ2xMNEQzSVBNZUpCK255NzRyTm1YTHVxQzkx?=
 =?utf-8?B?SWNLQS9pdHRTeGZFMXJmMHg1enVMcXo2K2t4WG9IK0c0TUc3QkxnVDdrTHZp?=
 =?utf-8?B?RFNlSXRsN3puMWtZTS8xaUFUSVBaZXJBTXJlYmxLR1FhR2ZQSXFtWTdSVnRv?=
 =?utf-8?B?dVN4M3lMNUZLMmpNS3JDdjROV25DRmtDcHlQUFZianBFSnovdE0yWGl5anBh?=
 =?utf-8?B?Rld4Smw0R2l1S3A4NUhMNVJIZ0MrZ3pVQ05xUndOcXFadnJqd1lyZmEzbnBl?=
 =?utf-8?B?UUtIbXVITGtTYkE1b3BxL1krSEMySXY4L202NWszQUZuNUZvS3JJUW53K1F2?=
 =?utf-8?B?RlFKU09ZbDZUOEVpOXpoMkcvZ1JyQmw5K09FclJCVm1hWEJGSlNBSk5OOTVq?=
 =?utf-8?B?eE0ySzhyTjBtN3YvOFpMSFFFMjdGOGw1dFE0OHZ2ZlFLSERzWFc3NlI2ZlM4?=
 =?utf-8?B?cWk4TTRQOHV4dHE5dzg2cDdFaUhkRTkvVk9tT3JNRnh4NkhWRGdqQTZ4TEIz?=
 =?utf-8?B?WXg4Rll4SFpOQk5vUzJCTWgxWms2QlVvYmtlVEVLRTV6NUpUdXNFVWRYYzQz?=
 =?utf-8?B?MzVrZUViWUp4cjFOdFBMeFNtNWpiWVl4ZHlBQTlDUUh6ZWhScW9acy9NSUwz?=
 =?utf-8?B?YjllRDN5K2FvRDI2QkdFSDlJZWRTS2wySWUreVFLc0lTSU9QUGZZNVV3VW5y?=
 =?utf-8?B?S0wwbGRYdk9CZDVTUCtyeFJDSHc0VGdtb2gvQUxwUTV5eXhBTmluWExSa2xn?=
 =?utf-8?B?dCswU3g1V3lmZUtmdVpqd1JKVEdiN2VGcG5ncmlDdW1tRzFMcHJTQitRKzN2?=
 =?utf-8?B?MWZYczZPWVluWFNodHRIamhkRFpxWWtYUnZDaFdkSXRMN1JDNEZQbTdieXUv?=
 =?utf-8?B?N3J2WGY5Y3dFWUozYkVZNjBjemk3S3ZNNTAxOHN1UnZXbG9SVHNDWms0b0JD?=
 =?utf-8?B?bGd2aTVTVHEwUDlJa0hVVmpaSWxCR0xoMytIOExPdHFKR3NnclpqUFU4Y2Vt?=
 =?utf-8?B?b3RqSWg2RDZudmN6UEFpV2dUU2dKeThidWpROUdkbUJha0RyYlhkSmZnb1Rn?=
 =?utf-8?B?anJZdGJMNTh4R0o3QW5JVnRFQkFzUlNxZEREYXFTOXVYZWlmajUrK3gzMG04?=
 =?utf-8?B?ejdvQlBOMTdFWFM5SitwSEE3WSt4NDBIaVI3TG9oQkc2bStURVpFTHpJQ3o2?=
 =?utf-8?B?Y2s0ZUlOVWIrZjdmUU14bzZrcUlPYjczZ1dNcXduNCtQZ1RDZG1INDNmc3Jo?=
 =?utf-8?B?ZndqUjlxbmNJY3JJNTJDNmhQd1duVTVGTkZFbFZjYlQwTEV6TytyaTB4OTZ0?=
 =?utf-8?B?b0haQ09Bc1hibSt1dWdUSklOUzR6Q0tWdi92TVN2SGl4SlVDWUlOeEJlWWtN?=
 =?utf-8?B?cW9RQktaL1hIWk9RMFF1RWZhNEVPWm8rTFEvNlc5eEh5OVZUUk9pRnc3YXFn?=
 =?utf-8?B?NUZFQkJJUGI4d2Z5eWRLZTRnWmNzclNKL1Q1RVM0RVkxSG1IOVJVU2NHNjMx?=
 =?utf-8?B?WXpnekZlME5yblNTSlVkRlBldHZZSmRjblVMK2o5Z0RxekFmQyt0T1pOYmRD?=
 =?utf-8?B?VXNyNFJOYXB6UEFac3g4SjV2RzFQZkNxZjJTUWFGSEljcVg5OXcyUGtTYWJ2?=
 =?utf-8?B?eW53OFc4amkrM2UrVXNOTktEbFNoMnhMc3IybEYwVU54L3dhaWxVV25RelFa?=
 =?utf-8?B?MHVkSnFnaFI0OWFXUlVYcWdBS2xDcEMrYTVpOENrdjB6b2N1b09kK2w0MWFv?=
 =?utf-8?B?YWZBWHliRDNqcmRzYk56UDJ1SG41bmh0VDJUOVhjaStycHkvc2ZqSHNRN3NI?=
 =?utf-8?Q?seMb2bwH474=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGpXZmZFbHJhbWR3cWRZejI1cTJlS2xrZERXbUpoMldRMi9oRGh6UzVTb2FB?=
 =?utf-8?B?K24xNWtibzJsY0gxc2d3aWJTYVFOdGljQ09pREh0ZUJObzBtSVdBWGVXdG95?=
 =?utf-8?B?VDdPQ3ZJK3pCVngyTFRFNHdHK1RsYklZVFZlRWJ4UUlicExWcXdtRTd6YytY?=
 =?utf-8?B?UlpyYXpKNWhlWmF4WGtWL281aVZJZE1ML1g3NmJQQWRidGRSdlRseFFVYnZ4?=
 =?utf-8?B?RGtCcUorRStrc0FpT29OQ3ROUXRZa2ZEdTFwUnJ0VWNLdTRGTnpNMTNBd0Jw?=
 =?utf-8?B?VlczemxibCtFV0h6SHc1WW56VFNDQmN0cWxNZGxFWVduQ2ZGN05pdmxPbmNL?=
 =?utf-8?B?L1RkSy9OK3dPSnBZZE12L0ZRR294WWdUYTF5QUJoWjB3Y2Q1VzgyN3hsd242?=
 =?utf-8?B?eXB2emdDUGN5MHZZYjZZKysyckJXRXZ5THhWWTFYMVBhTTlsSTVvcHV1SkRm?=
 =?utf-8?B?cnFLRmtsRlZiOXBLS0JBbXFGNVY0alZZbVJWS2RLTXBkRjBqUTVwMTBvVlVz?=
 =?utf-8?B?eDYyM3h1UnJIV0QvejZxQ0k1ektPVTN2enV4aFJ3bFF2cEplSUNUMU8yeHlk?=
 =?utf-8?B?WVM2TnU2U3dweVVmeERSaktJbys0Zk11eFd6b1l2UEhvaDRhdktvaHVXVEFh?=
 =?utf-8?B?eFhEUGFaSTZnVnpFU3Y1Qlh1eXQ0Y1ZvMVJUdE1sWUhTemhJK1FCNGppYWo0?=
 =?utf-8?B?STRwaXRsSysvanQyRzJwcEdKSXRpVnlsQ3NMNksyK0ViZUhIR1IySmJkenhE?=
 =?utf-8?B?QjR3bkxoT1dRMEtReUh5MzFQUkNPbzIxb1pMODhrUXo2SVl0ZWNsUHdDb3pw?=
 =?utf-8?B?WDBDSlkrSytMOXErY3AxMElTZUhkMVFqOGNPWE5LQmozLzNsWkUvd21Dcm1J?=
 =?utf-8?B?aVVGam5pcHMxQnJxYVJ4cVBFZ2trSlZWYXhINk83STA0QjhFNXRONnl0L3lm?=
 =?utf-8?B?YXl1UFNEQUNVc0xTaDltRWZ6dmVDeUlmTFF2Um5LVjE5bnFLOWNGQWZDenVM?=
 =?utf-8?B?T3dZckh4MDNra1VIQmVUUzVTZlc4TXFFaE5aOHNmTHlGckczbTNra01YRlBX?=
 =?utf-8?B?ZnJiVkVwQ1hHV2tFVkVPQW1xcUIrNUVocWNWOXA4TzhKMGs0ODR4WXdGMkJu?=
 =?utf-8?B?Unhmd1BLei81aUo1NEVrUG92MGVKaTFZaytXWmRUeVVSbXgyOWhVazd0eVVn?=
 =?utf-8?B?WnlTOHNHKzlZZEtPcjkzZ1J1RG1kb25saXUvaTFsQ2V5L2p1eXYybEhvYlYr?=
 =?utf-8?B?dDFyRGVTMEZwQ2dQd3Fzcy9yMzdrZEt1Sk15VzZtYzhhNVhCNnBRVlpRTWgx?=
 =?utf-8?B?M3ZMK2RkeXdyS1l0MlNEbEphMDkyTFdjOFd4YThLdlcrQ1pYemxQTnZQSnZm?=
 =?utf-8?B?emJzeENITEJ4Z3ZsOGRvNUh5a3hMMEl3SERiSkZtZjFMNy9WSzBhWGx4ZzEy?=
 =?utf-8?B?QUxZNldsUWJ0UFNhQjUrZ3YyVlRNWEdRU2gwRjFuUTdzbld2U2ZOYWFEQVVy?=
 =?utf-8?B?d2dOcFFLclZkUDZUU25EODhETVQ0RkVPMzdIemFzSXZudmQrdk41alNpVmlp?=
 =?utf-8?B?Y0FkaWNhSm16ZkszYWFCM0w4ZEhwRVhnVVFibmk3QjZEUG9IZ1VrY0RKc3VQ?=
 =?utf-8?B?ZVhwclVQR0hFTGhWa1FiVWdUQ2pxNnFnSTNnaWZ2TzdEcmFlK0NKSUdLWEp1?=
 =?utf-8?B?QkdqUDNFYmRnM1RSNzlIWkg2MzhQK2wwTDBwWlo3d3AzZXJMd1RHeGNQU3lH?=
 =?utf-8?B?ZVc5eUJHdGlJRVAzRVdQWFR5RWJvellXRTE5aC9QN0NKZnJGemQvSmZ0UWo5?=
 =?utf-8?B?bzNLSUQ4OHYzQ0ZtaEZ0RHFvK292WWdYRGg2RmZUVVJSQ3lQblFsOEgwa1Q5?=
 =?utf-8?B?bUcvL2VQa3EzbnVWZElOd1ZxY216OHNNTFZYMzlkRGEvVzVrNjE1SGdiOU9I?=
 =?utf-8?B?NDhrWXVBSVZ1L002dE1MMkFuVngwcWVBN3Z5UFdyZlM5aTBncjdJa1IrN3FZ?=
 =?utf-8?B?bHpaMFFqVmJmTUVtL3JORHJmL1IxaVRzQjZObWdtT00vcDJ2aTFqWXpRZDZx?=
 =?utf-8?B?KzhkbFFHcVhwUG1IaVM4VXBLWXJjcFdiR3BLV2VZSXV2YmZ1b3YyaFFhQm1x?=
 =?utf-8?Q?TS0OaZhkQDxeiURqmuuayQ0+G?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oxyt43tXj+IinDwMMEibgiUAit/DHZupf6MM3mFLSurRRTGv0rXcXUKSDphZAcUn5f4/3AegWB4onRGJBYlSYWce767qtXViE8MROQtncemBbUlHkYJko4fLReGTDDmNkfbVZlcN9uhTCHkVlHl6Q99q6tWjPgHiXXZHs8fQWuNPhDD2RGwNFlYCe32Jnk9f7BuqeZBKLlb3JFqEeEBGvgijYUNjX9yyo0AzlwHr3mnSzS+4QcAWjSDnG0q9d3w8scn3xjpk59XnxtgL0dtSfDwstzvuSZVFhdzgDqPHBFeU2z4F0O6wIb30usao/lJBs/Wyek8yPl9buxDjnl/1DXB8O6ZEV0EU6cqkcvIzAbWfpJfgTPoDRl4vgyh0DndxPK9ee+SFbaDkDxo5YifCq8yfqBoDkYm00W0UwDq1luprC+TYORzj/O+lkaYjlcRqj2l8sG4SwREPxFqqlIuOIs22SrKxTej/QWAODYj4jgn7tD0ok18w8x/AMmcQuoZ6bbkLtWh9gUrHjl+NowmISElVFitjNCSjdd3xKVADbkLNHbuEaQV+AHcNSULelDJvs7FSX7a0PCd4oZJ0MIXcYsbnVudUHB878jso3XPxc4s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8942bd-27c4-4b70-3cf1-08dde72b5d06
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 18:39:19.0690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6NT391RjtbMTM170qGyY60b81W18UJu5lQX4LyJ29Xwlc1fJjXAzC2WZ+Whi6LVa/QtAe4lyIiDNGbCUNvmD6NXQZ0gcXnyPb5+goTEgKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4210
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508290164
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxOCBTYWx0ZWRfX9kDSGA7nu823
 lOln5ncC1gTpTP9wHxCBv1N5xLhSGDYZ91vDctTO5vum3djrgRF5PZqVvKqFAe10Yt1JcZ+i2W0
 djUDf+nFnGGT/MDxpv/RcIn5mWNSTAXAhii5DrVNehkCcvT61yTxxRxx1k73T8wjdOJudVHLH0S
 FKupH0g0kdksxIXMnY1bLPJDw5vmvnt/N4QbWRxmlLXPsCtQQGamOlYSYkyvN/NXGqV2cxtjsBR
 +UEH4PTm5MkTlkYDRtYRyJdA+PYeda0J29IWcNpWEGPZuC4ngzqTT3We65Ug9KxhLhSehmY1d17
 XNCpE8SGdNziHtVEu5VVC14kJWAoOUdQziJo1GlWAVyVz06rqu1pMNMy7AKD/+hydeW39yatHP3
 imjg8lFAsNmEtt3yDzrolepBhRKJaA==
X-Proofpoint-GUID: lk8qoZ-GF0bqHCcNWJyFStGY11ysa-9O
X-Authority-Analysis: v=2.4 cv=IZWHWXqa c=1 sm=1 tr=0 ts=68b1f3db b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=2RwW1wVEyL7uUiuVjH4A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13602
X-Proofpoint-ORIG-GUID: lk8qoZ-GF0bqHCcNWJyFStGY11ysa-9O



> +static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
> +				 size_t *key_size, size_t *classifier_size,
> +				 int *num_hdrs)
> +{
> +	*num_hdrs = 1;
> +	*key_size = sizeof(struct ethhdr);
> +	/*
> +	 * The classifier size is the size of the classifier header, a selector
> +	 * header for each type of header in the match critea, and each header

typo critea -> criteria

> +	 * providing the mask for matching against.
> +	 */
> +	*classifier_size = *key_size +
> +			   sizeof(struct virtio_net_resource_obj_ff_classifier) +
> +			   sizeof(struct virtio_net_ff_selector) * (*num_hdrs);
> +}
> +
> +static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
> +				   u8 *key,
> +				   const struct ethtool_rx_flow_spec *fs)
> +{
> +	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
> +	struct ethhdr *eth_k = (struct ethhdr *)key;
> +
> +	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
> +	selector->length = sizeof(struct ethhdr);
> +
> +	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
> +	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
> +}
> +
> +static int
> +validate_classifier_selectors(struct virtnet_ff *ff,
> +			      struct virtio_net_resource_obj_ff_classifier *classifier,
> +			      int num_hdrs)
> +{
> +	struct virtio_net_ff_selector *selector = classifier->selectors;
> +
> +	for (int i = 0; i < num_hdrs; i++) {
> +		if (!validate_mask(ff, selector))
> +			return -EINVAL;
> +
> +		selector = (struct virtio_net_ff_selector *)(((u8 *)selector) +
> +			    sizeof(*selector) + selector->length);
> +	}
> +
> +	return 0;
> +}
> +
> +static int build_and_insert(struct virtnet_ff *ff,
> +			    struct virtnet_ethtool_rule *eth_rule)
> +{
> +	struct virtio_net_resource_obj_ff_classifier *classifier;
> +	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
> +	struct virtio_net_ff_selector *selector;
> +	struct virtnet_classifier *c;
> +	size_t classifier_size;
> +	size_t key_size;
> +	int num_hdrs;
> +	u8 *key;
> +	int err;
> +
> +	calculate_flow_sizes(fs, &key_size, &classifier_size, &num_hdrs);
> +
> +	key = kzalloc(key_size, GFP_KERNEL);
> +	if (!key)
> +		return -ENOMEM;
> +
> +	/*
> +	 * virio_net_ff_obj_ff_classifier is already included in the

virio_net_ff_obj_ff_classifier -> virtio_net_ff_obj_ff_classifier

> +	 * classifier_size.
> +	 */
> +	c = kzalloc(classifier_size +
> +		    sizeof(struct virtnet_classifier) -
> +		    sizeof(struct virtio_net_resource_obj_ff_classifier),
> +		    GFP_KERNEL);
> +	if (!c)
> +		return -ENOMEM;

kfree(key) before returning -ENOMEM

> +
> +	c->size = classifier_size;
> +	classifier = &c->classifier;
> +	classifier->count = num_hdrs;
> +	selector = &classifier->selectors[0];
> +
> +	setup_eth_hdr_key_mask(selector, key, fs);
> +
> +	err = validate_classifier_selectors(ff, classifier, num_hdrs);
> +	if (err)
> +		goto err_key;
> +
> +	err = setup_classifier(ff, c);
> +	if (err)
> +		goto err_classifier;
> +
> +	err = insert_rule(ff, eth_rule, c->id, key, key_size);
> +	if (err) {
> +		destroy_classifier(ff, c->id);
> +		goto err_key;
> +	}
> +
> +	return 0;
> +
> +err_classifier:
> +	kfree(c);
> +err_key:
> +	kfree(key);
> +
> +	return err;
> +}
> +

Thanks,
Alok

