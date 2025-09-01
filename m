Return-Path: <netdev+bounces-218698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BFAB3DF5B
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 12:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846E517DBC9
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41298212556;
	Mon,  1 Sep 2025 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CCmYYP+9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="puSYmwDY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1158263F2D
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720839; cv=fail; b=kzl5uuMSTtLqbTQPuc/he19WE2FufvvVbySEeh8IOYJUe8nHJ/rCElTOw4OgnEjEBbwu0wriudJmd9XB3nzOm5nQw0hwbuXk77x9Ec/wxTie62iMcKE0cBsVdFX1CAyKWBPmKQY8GIuqnj5dDrB8DHBiBuGiswDwtHRMrdsL7bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720839; c=relaxed/simple;
	bh=p6oyHUMKFOEFrqG42ElRs7JVeo6hUAD9V6lMEI9WPU8=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=kRb3Dehnh7ZyMrg15oH88WQWRJLU7MTYNcGmucK3BJtPRdiA7uwiA68DJ7awXB9gVJJLy3HdpdfvGMA9IYaMlmmcZOPD+REYsiZZXUMCyRGwE7VnNRZpm+gZ5Tty53HruAdHxETqQID/scQsfywzuG7QTCioAIeblHej0uzyHT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CCmYYP+9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=puSYmwDY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815fwEJ000588;
	Mon, 1 Sep 2025 10:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=V0WwOmI+9yq7rrS9Yg/4awirslHoRl581GnYpzGck4w=; b=
	CCmYYP+9eIbR4LTQTrFx3LmUnmuzR43mXmcZTe5jXkieKftjI+W2443FbCgPPg9J
	Lj7yLVluwvPMJlS5+gjFKBedF10n4M67zSoDnQqnD/qSZjtTH7z5bdowCZvmPtl5
	cQMyx0S1pIcWB4oL2HKJpFHp6yy2htJTgv4HIdAryYVMFHU1xLA72dapque30MkO
	ptgzVZHAboblMlkpGnzwP5GX8Wn/3VLm+5OpddG1P+NiAvzjb7Qy4FxgK9ln77Ee
	VVjTI8Yvrg8rDl2qmGIivUH+3A9JtrbqStF1LmpAl4WWSDjAdgYXW1Ua9l1cojl2
	mYhYjvl2BZigRYx7TiqPiw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmna6k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 10:00:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5819TR9i026867;
	Mon, 1 Sep 2025 10:00:27 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01m7p82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 10:00:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGugrsEJdYnVQL5fC3VuSYvNWO56WoDUG7qqtkDfUbUs96zsh56bxfOJwXdBbi0KTqdeyz1Ok0RTeoyGVG7tnXBwO2QksOpimlkS53afbjv4Ekmd2anzL/G5UAkjT0f7yoRQYZ1309Sc/ixoq5Hs3AbwNLXo4dbu9A6HTeeEy/LgfJIBQ36OZpdxvYR0siKCOj1THBYnJtB8sJ4gX0jGzmMkMEYrAtmSbCI3dSKETJyEMj1/2hSx/eZUvXuY30YnUH6YEI6BvnJ5YNRictZnWNV225k29ycn0zoHtS6tTfXruFZPBM/hVUOAo6yPP8aE7a/sI1K8ijGu3KVzQSZpkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0WwOmI+9yq7rrS9Yg/4awirslHoRl581GnYpzGck4w=;
 b=VoCM0lPCObQ1nMtHd81cdnhhjPfB5jSyB1MtytArcMZTtbung9TAmcpNKm/iRn9ZigYH5/uW5LXBULjPddA3Uof666Cr2deLwUV6ixfbKBQSUVLRENECHx0fEORwAMtWWuDrt+9ouZQ9/epXiK6bjpHjfBPJU67SD3Y6y+vJ7DFq4prfjDHLPp0HweIv7VuhugsBITl53AExn8VLYPQqc61oHscaLGOuvBq9iiZVezjqIbDKSmj7VhZbMb36C/ETY3qDNdUtT0Qja21RuVzLRQVPARPEcgrylDnua+gom0/xmNMsqd0yIxFsMsGSHmYi7RUmG/FHxZuFe1xm7FUv0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0WwOmI+9yq7rrS9Yg/4awirslHoRl581GnYpzGck4w=;
 b=puSYmwDY4DluF7GdioldYSVc1ILWPIRCW+Mq0fDVEihtUDzTeT1FvXfRz7WpnPfCeJg6AfahSivlH271KuSppNAfl+H6Zw+NjH56O6y12m4kE5T59XoWNrQAO1U/IMW4oSxq8mqBnrqFeN+Jz0LuV3hL9eKo/ogFkcSkTL57Ipo=
Received: from BLAPR10MB5315.namprd10.prod.outlook.com (2603:10b6:208:324::8)
 by DS4PPF3E4368C94.namprd10.prod.outlook.com (2603:10b6:f:fc00::d18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Mon, 1 Sep
 2025 10:00:24 +0000
Received: from BLAPR10MB5315.namprd10.prod.outlook.com
 ([fe80::7056:2e10:874:f3aa]) by BLAPR10MB5315.namprd10.prod.outlook.com
 ([fe80::7056:2e10:874:f3aa%3]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 10:00:24 +0000
Message-ID: <f5978c86-5271-4699-bb7d-92e3f2e2b9be@oracle.com>
Date: Mon, 1 Sep 2025 15:29:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [QUERY] mctp: getsockopt unknown option return code -EINVAL
To: Jeremy Kerr <jk@codeconstruct.com.au>, matt@codeconstruct.com.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
References: <20250901071156.1169519-1-alok.a.tiwari@oracle.com>
 <048e6efc6e61901d0df3defaf6cc64c2afa5f937.camel@codeconstruct.com.au>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: alok.a.tiwari@oracle.com
In-Reply-To: <048e6efc6e61901d0df3defaf6cc64c2afa5f937.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0117.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::33) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5315:EE_|DS4PPF3E4368C94:EE_
X-MS-Office365-Filtering-Correlation-Id: c885ff4a-1274-4efd-9fe5-08dde93e52fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzRrcDR1S2djZk9MSW1qcktxN2ppalY4RFdNb0tGYVhlek10S0dOL012bm53?=
 =?utf-8?B?TkZSUVlGekIyVGZublpQWDhTUE15Ym16ME42aEtPSTRBZkcvNElPdGZSZ1RN?=
 =?utf-8?B?L25kcnlpbkdHUG5CUHA3RUVrdDcxM0VQZGF6cGZkVGEySGZxcmZPMm1CRktD?=
 =?utf-8?B?czVRajlFZGpqOEZtaVZqQnV3cURLRHRjdHdlSnRBcnBIS0poOVhkRkdkK1FK?=
 =?utf-8?B?N3I3cTBXVm5vbWN6ZjlSUjRZSnRFazBYYW5pNjY5bzYzYzVpZUgwODdKcndB?=
 =?utf-8?B?amhEY0JGZFFUdlpyWlcrdk5rcDk5YTZxRkVpVGpZLzRlbit2MnlFbGwxYnRF?=
 =?utf-8?B?M2xvS1d6MlpjdUpSRWxqRzA2VGNsTzFqVHJrcmN2eXdjcjZRSWlJbTFrSVk4?=
 =?utf-8?B?VVlpVDcvdmx4SjVNSi9jL0JQYlRucVlkNkhHeXpJSHhnYUFKbUJRODM2RWti?=
 =?utf-8?B?VGZVRWtVRmNrQlVoRUczcDk4V05RNDR2eXB3Y0tFSlZ5SDhvbnFPTGVXRVFV?=
 =?utf-8?B?em5RWGZxRkVTQ3k3WlBQbHBDVnBKTE1hZkN0VXVlYUxNL2V6b0FCQ1BSOElG?=
 =?utf-8?B?ek5TNzBMQnI2MlpOQUNzamEreUZub3hmVU1hUjdINmwrT0o1SzJMd2o3SzdI?=
 =?utf-8?B?bWxWQnczejFaSm5zOUpnSW5HRk5NRlkwalRlOGdYaU5GcEtreEdDNk1CZ25U?=
 =?utf-8?B?aXNwenVQNi9MRmZHWE5yQ0NOZzM3UjI3WDFKZWQ2NFpLZTZoZnlxREJTT2Vy?=
 =?utf-8?B?SkJob1d6RXJFWDdzQVVHaTY5dXFFSEdRKzQ4enVDandCVnYwSlVIVjBFWHJN?=
 =?utf-8?B?NjcyVGVMc20xRVJSaWxoZ2FvcWdGUDRSd2FMVERKVmNuVkhHZUpKWHgyT0V1?=
 =?utf-8?B?eVZEYXZ0WjNob0toMDFRT0psbWY2SFZRMTI4MnJpTVdyWmN3K2V6aVU5S1Zv?=
 =?utf-8?B?Znl4ZkRiWmtDNzZzTTVIRmN3TTlSdDV3ZVdNVktaTUdWOTZOS1gxZlVNUDlT?=
 =?utf-8?B?SlNFSzZkQ2Y3ek1lTjZhMUs1dEkzUlRQUHJheUdGWnNHd09DNGpyVHg4a00v?=
 =?utf-8?B?dVFMSGhNZFRYR0d6UDFDWVIvdjNzcjY4VFVPcmpEVW9tcE82czlQalBIVnBV?=
 =?utf-8?B?elh1cGRIWnQxT0IwaWMyd05wTTZaV3pGaTFyamJXdFBMRjluOGxPVlhwdk5V?=
 =?utf-8?B?bkZXOW96UjM4T0llQVlvc3lyTFg1QmNUUFNOOHR1UUpBTThBaTVzYUZtY05U?=
 =?utf-8?B?U3hwRUdVMkhFNmcvRW12WStHam1Ub0tRK2dXQU9OOU9sZ1ZQTWIzd3dGZmoy?=
 =?utf-8?B?YXV2dHovSHlucVpSdVdmM1JuWUQ5UjEwZEtldjErSEM5WjMzQTNWdGxOeEtj?=
 =?utf-8?B?NUo4WWNNZ0V6Z3hncXVENkxHQmtpZEk0ZFhEdCtudUJxYTltWVlUcmhMRk5a?=
 =?utf-8?B?eTVFVEpDcHo1TGd4cFdLazZBcXVSTWd5a1h4Rksxck5SaGdyTWx6SlRpaWNO?=
 =?utf-8?B?TndFSFpncG9DdWgrRnVFVWRuQzlmSHRNN1dCMGJUZnJHNXhyb0tIOTdBV0cy?=
 =?utf-8?B?dHFIMTVsVjFWeU01MC9KS1BhQXh2V1ZQSGJrRlpsZTQ1YXlnNzlkaXdJVHZO?=
 =?utf-8?B?aE8zcW9ORVQrOXdLTFZINW5zUDNNLy9HL3ZEQm1HRDFIUXhPTDJJUVREeVpI?=
 =?utf-8?B?d2dFcXNkVEtlWURWREY2NzYzc3l1dnJLSVM3SXFNbjBCa0IyUDk0alJYUCtv?=
 =?utf-8?B?Tng2SFhJVjFzZ21qU2VJN3ZIWnR5WmY0QjlsenV3bk80aE9YdUx5bE5yMkh6?=
 =?utf-8?B?RFE0RUo2MmZBWktkWEpZSVBQT29Dc0UrK2cxcmc0TXpiUHZ3VmVSWERhMGFX?=
 =?utf-8?B?clJqaVVRcENibnZrQjVxWmZ4QVJ2VzMrUHJPQnRQUHlNaFN2WGlTZGhxQ3Vv?=
 =?utf-8?Q?e64T8fwoWBQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5315.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk9aY1h3ZGxMTFdpNVY3a0Z6R0VvNnMrRTRJTUhzZysyWis4ODFtcEFOZkZS?=
 =?utf-8?B?NkprZW9zbEY5V3ZjbmRNeVZTT1lLTXBPNjQzTm5lWXRDeDNPZ3kza2dxVyti?=
 =?utf-8?B?SlA4V3Jmd3hjT1V6aVI3cFZ5aG15QnpBV29PWTBkTERwVFJkOUVSbCt1VUhQ?=
 =?utf-8?B?TmJKb1VweEJqeGs5cDdCVkZnN2pqdU95Z0dvcFk4Szd0TUNJSWZwRzlERGxO?=
 =?utf-8?B?dkNIZ2NJNDJ5WVhVT1JWeEpxdnVKUm9NY1lEbVBzbkxmRGlOZVIyOG1IbENh?=
 =?utf-8?B?eTRka3VFbzUvRTZTUXV3VDNEU2Qxd1poKzVsc0drOHJLM1l4eU0vTVlUVGZU?=
 =?utf-8?B?elF2T3Q0ekIwYkZyYy9HajVNbytBbnFia1BBSjl2M1RmZmFjTTdsQ085QTJ5?=
 =?utf-8?B?UGt6RDk5ZXhJcHFRSTFsUjA3OGZQczBoblJRY2tNZWRSWGZ5dzJiQXVucGpm?=
 =?utf-8?B?bHVjME9aOVJSYklmbjB4N3lNYWxjMkllV3FxYTVNeFkwMWNSRmpwU2VidGV3?=
 =?utf-8?B?dTlRU2ZKU2FxM25hQTdKRWEyQXFyKzE3aEoyaDd1Z3d6VGduRzduQ0RHZ1JG?=
 =?utf-8?B?K3IwRk41TkJ2czlCWmFCUVFuRTdNeUpFWFNVeERHZ0FwamxUMS9zaWNMcnpu?=
 =?utf-8?B?Q25rYWJ1aXMwL0NLMkpQaW04dmZWaStkVkpaYm1QMnA4Y3F0YnpQNzRiazQ3?=
 =?utf-8?B?ZkgxV00wbmpFMVJ5RWdxeGJ0aHZydzViWWx1QnFRdUJYVXdyNjFVbzlEOHJr?=
 =?utf-8?B?a291dHJ0L3VmbmdHTitmbmJnWGU1T0hZYTc4L2xIcUJwSDBlR2dHV2lBMGZK?=
 =?utf-8?B?S2FMT3M0OFhtZnhPbEJvaGhhRlJ1d2xCT1RHby83cm93MnBTQjRoN0pNdjdz?=
 =?utf-8?B?TTJzbDRRcXV6VitJQWl6WFlrTjg4WDhKV3UyWGNWMm54YUVkSEgzMENQRGI1?=
 =?utf-8?B?aEFaYWwxRmpaeEF6OUlNUGFYcXNXV1JJNGxOalcwVzJGcjdlbnlKQW5iS2xs?=
 =?utf-8?B?MmNxMGRSV0JFVkxDWUdwRS8wSlMrRXRUUkN3bXhqcHlYVlNuNXRGUjBDM2lQ?=
 =?utf-8?B?bnJIcHcwbkRBN0FtRWNSZllXenZDaTk4SFlRd0xheTVZNEkzRCtaS2xKOERm?=
 =?utf-8?B?T25IaTZiaEZVQ2RNYWwzcVBtbUVZYVptYlg4cGJrWjl5dGIwWkNtdTFvYzZU?=
 =?utf-8?B?RVlVSWE0a1MrZzBTSjdzRkpFZTdHTU5OeGZ1ODFhMWcvamovU2w1YVhTQ0h5?=
 =?utf-8?B?K2JLajBVZWFCaVJqR0V6WTFuRzN4b243QXpZcUhIczdKeVVDZmt5enhRU3B4?=
 =?utf-8?B?UHRFOGVIeWVPRFlWb2ppNitNQzBjUGx4V1kyVHNYVkpwR3lrOVVBYUdWSllP?=
 =?utf-8?B?Tk5hRVRtZlRIb2FEQTA0dVZ2TnRIM1ZPNUV6Y25FOXZrdStjM3Q5WnF5Qkcy?=
 =?utf-8?B?ZC9LVyt4Y1RHNzhPQStZRGJhRlN6N2FrMXdOdno5VnQ3OGtoSDN0RW45Vm9E?=
 =?utf-8?B?M1NFeHhlVFNxQmhweTR5aDI4MzhGeElWaUZrZVY0clJqczZ5S3YwZEo5ZkQr?=
 =?utf-8?B?aHRUdy9XK3M0enpoa0gzQUtBUGJxd3U0eE51YzZNYWowSVo4TjdmSXp3ekRO?=
 =?utf-8?B?RUFvWVUxcUNlT290NEZhNGl2MlRTWHVrN3ZSOVFTUURTQTZETHpVZXBXOW5a?=
 =?utf-8?B?SEFXTDlWeDdwRENsMFVhTi8wb29tMVZzdWtjSms4akZKTktkYk50SXBmQ2cw?=
 =?utf-8?B?VDQrVjVNUHdlU00vY0lyU01BbWRxOU9ZZ2NLL0wraXJWV09XSlFMcEp4NnN1?=
 =?utf-8?B?UzZOenpJWWRxYTB4UGlNNTFINWV2a1F6T0hManp5Q3dIcGE0TmtyVXFYNjcz?=
 =?utf-8?B?OXkwdkZvRVZua3FVWFZNQXNBdVRZUEJsTzArU1JvWThvV3dIQUZ0WmxlR1I4?=
 =?utf-8?B?bWtSanB6TzBHMVVTY1lpRUhpc2YvaEJLMERoS1ZZS0dVZjRxRUoxLzZVQi9q?=
 =?utf-8?B?TGM1VFJGSXFPcGNhYnNyemZHNG5adyt5bW5OWDh5NFIrYWVLdVk0alJTaFZU?=
 =?utf-8?B?Z1ExQjY2QnlFZEFFS2FtcDRFZ3JFQUtmQ0dVd2NKelM1K3hrRk4rU1dRdmxx?=
 =?utf-8?B?VXBHQzlRc3VhdjM4cTBqTlNCOGp0eTd0NTVRdVFLQjd6czBpSzdBelhnMVV0?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K5l2QAGd9r0L4S7EQk9ZJfWhcgOPe0Z/Q2Xn37j4GwOJIllyQism6trw9s2DmEutDByO029p8GKK/hi0A5DC6rgMb5krrNyN/1E5vNCcAKQGELdsgfg1vs0WAj2ZISAM0dkX0zxhDsyvKVUTe2DOZMlAhKupMZEICusQojDQDC00SrqOQ142HpZlBJkTlSqizYzRAojAY06tEhpfJDBXFGXWqYJtnCDZx/BNZSF2yqn/fGcbt9hzaKmEc8Ss74qaevvla1/0fEkdp3ttmILHbWXyDEZVxtbWtIwS8/fk05vULObVJQvZE28QoKuFKWST8YCoW/NO01dFkti4h+yI7RND9WHPUwBEp6L3DZE+O0hPpwjXpJewRjvHDh5tj+WcCCQ8w0EVsipibJbNFNICdLG8NKjlQVN4apNV336XoCGEMf/nGJlhWtKN6yK2ahyIUhN6dgSy4jdZjh2TiPXdm7h6SWmLk6/S7loRg4pI5FCKh/nzz2qmSs9fu0NYwBHvIhfTktFTEbdAdRbfBEWTU9qp57zTUEr5x3pExckqLUD3kWhageFDKIp2+grh5UWkikhyiH4uCHM7v1EmQ64ahKvkdQqqqwOY1jefDt6nnoQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c885ff4a-1274-4efd-9fe5-08dde93e52fc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 10:00:24.4324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99cA9G34GrhVLv/werbQSnxgJuXNhkRSRaoRXyZD26dkXL3aYdqSpZfSwOeG/N9ItJ1IsvIZUqS3z3VDDsRwSfa+O3roqaP4pFmFUQFZQZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF3E4368C94
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509010106
X-Proofpoint-GUID: KhZ2ygzPsIjhUSfQlVBf9bvOBc8dI8c1
X-Proofpoint-ORIG-GUID: KhZ2ygzPsIjhUSfQlVBf9bvOBc8dI8c1
X-Authority-Analysis: v=2.4 cv=Of2YDgTY c=1 sm=1 tr=0 ts=68b56ebb cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=GCff_eYz5RV4QiM1BFwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXws4cSNi5q0PH
 ZYpFomHHMMaYe4mbzTePj4n8CWd4wHNO7q3RO1M84oy2hsdpXJB8OzQcZO6ZaoFSS5IHaO1OgLN
 0aUPwcp6nr6oxvgAL4H8oeePfq9oPgw1i1KlkMz89V3TihG6TSK1Dz1DdcS7lBt0Y5mIWGd76uT
 vxKp0KSMVTEjwEGU2rGXHlqTOU8qPDuHrplVVPF963CkVrfEwp9NgoY/RxdKDOycrOVJvPYU41d
 MO3E00dY1co34IocZ0g2dNTnAS2VzEcogh8OH5koVuWr+xuY0hOqiYOEEQKRx4zOvUEogzIOT/W
 7l8W21i88LybZHpZ5E/fDdJ4kOoT19uuA0tIfYZl4HLf6CB0oReimZy2aioC5YvzlDSHFVHEjge
 xHRvWHNt



On 9/1/2025 12:54 PM, Jeremy Kerr wrote:
> Hi Alok,
> 
>> Would it be ideal to return -ENOPROTOOPT instead of -EINVAL in
>> mctp_getsockopt() when an option is unrecognized?
>> This would match the behavior of mctp_setsockopt() and follow the
>> standard kernel socket API convention for unknown options.
> 
> Yes, I think this makes sense, and probably extended to the level !=
> SOL_MCTP checks too.
> 
> Is there a particular path you're looking at here?
> 
> Cheers,
> 
> 
> Jeremy


Thanks Jeremy.

I was not looking at a specific path, I just noticed the inconsistency 
in the return codes between getsockopt and setsockopt.

Extending this to the level != SOL_MCTP case would also require changes 
in the mctp_setsockopt() API.
Would it be better to handle that in a separate patch? For now,
I can limit this change to mctp_getsockopt() as "returning -ENOPROTOOPT 
instead of -EINVAL".

Also, would it be fine if I send this patch to [net-next] without a 
Fixes tag?

Thanks,
Alok

