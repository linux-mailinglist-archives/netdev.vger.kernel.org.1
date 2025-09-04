Return-Path: <netdev+bounces-219953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC86B43DBC
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D790542F4B
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81763054CA;
	Thu,  4 Sep 2025 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bE2mJKYV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VHj+nkNy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E07E2F3C0C
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993942; cv=fail; b=bMN9BkNms+DAbfysOXS47auF/75YZZoJg+/0d0mV62bXO1/XMOR6vxCod5yKl6T2AeYxRw2VLaidA8yVmsxdnvWGgu+ybesv5JN7DZ3BpWKuZqzefXZMd20R76/BFhV6va40N1ZO0PtmA/NGBjJadXrIcvQ7Lup89bREyjsJw6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993942; c=relaxed/simple;
	bh=YePXRwWJnmwJYK3eOq3vXRX3b9I70L4+ukRGEHJFY3s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WkpukI7/mc+l/PU73SJvAkfReBUcGRfswEz3PRWAIJTczeJqeBc4Jm6jgzZFEactyEEqHrpNtppCvPNzaSJckkCgpmRvnkpkQ7wmM61XIDGrQJkLzDAUcIhkmEh5GQyoq6jDmCAiRFWpHT8/czhAuCAGvpzrJZaUN2dT2pfkaY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bE2mJKYV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VHj+nkNy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584Dj2ii015642;
	Thu, 4 Sep 2025 13:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yFvdIEzegXOuW06ACIpwN9uwPP53jiJuW0yBuzP6eKk=; b=
	bE2mJKYVyTx28k29TklxfbalDvWEUalzhEGawUHRC8JmhnuJBCtL/IJQauD8gwe4
	K5lQbA5gMEoP0v9wPY7Zvc8rNJB8Vqr1LKYDbR8BveIIUIJsh8l9rJsvwqK4eaIT
	sQ1o7l4rs42vTmVkdG45XD9J7akCgnlHKfgfp3afZn1FGabbd7Mnq1hmxk4HyTrV
	UCc3kRwke8Xpm575wg0Nni9W9DR/bGYPNn38mK2abAniSxFATZhxwvrcHDcjTGRs
	yc+r2/GCbkUDc8/Ax3+UqEaxtOV1tWjmfKUdE4GryQ1AIY88C74YrJ6NM1dc6Ewc
	Ibe4boB7nGnE3Q3ywxC9Vg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ybx180ak-24
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 13:52:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584Dk0aB040252;
	Thu, 4 Sep 2025 13:46:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrhp38h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 13:46:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prdpTUJBAqt5xJ4p1WQmWwD91wlco/XXadOG4FXnFbez65R4T3K50a4b7TaQ71RfxXnE+mu28WKszL7mCZkfOgdHbZmTGuPSva6Wswp8qzLX9cTZrps//4z71CB75/GAnUDfmuOswiKpMYSXz0ba+piHrUaKnVZyGjhTMGj6pufbkUIEm3Tv01+4BLMAiXaVgO7xXLjWKMUR3CZ/7f8LUv64FbYYdVkDjPKfZzGy4Y0V+3UuSZqbOzZ10ikohqzEsI53yc1mDgELfKIyie5v2Hw+tIH9wlSbCeWrDOuxVkWWs930AtMjNaip+rgoZe5dMyc0eYXCKnt/XvNWncRevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFvdIEzegXOuW06ACIpwN9uwPP53jiJuW0yBuzP6eKk=;
 b=HPs3C37dcJn3vEMvFh3Um8Wci5OP9+tLGUdC4uB8DZSvcRTwOt0jjt01ATR9uXeCq+Xc7wFcSADYQ/if5vHlTAvxRKSJ1RiHqmchK4CuMxquqYUQMFb5XbAssA7xlzqbqiczB9lyUia+B0t91h4NE7ntVmKpTsdmIZ/f3coauxlD4UyVahiwH7UHTmGMyHzGRBqGhF3M4CxMaSCkHiYh101iydb1PR3mWBPeWK4MYpD7Af1rXULzvferXExJvCpXKBF/1Gp0ITNjSpAAHjj6ZhB7vf/X44VrlbkWwyBL1VKDAnqv3UrwFzEKJxJ1RQq6lwqlKwtlhoivXTTVPCU/7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFvdIEzegXOuW06ACIpwN9uwPP53jiJuW0yBuzP6eKk=;
 b=VHj+nkNyS0+vHsfL+LDVWdtZbbFk15kQ0IVIh4Ms6S69bSnN/L8HXcVnk9tO2TFTnqE9dlljdr31xC/lzDpLKy7tVBzS4BRzPhQt7ltiRtBSn7Xds20TCUmtAQzj8rzogRuDbslP3SbL2fyAw1PzlkHJcR+lqpBG+ITC795ia2E=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CO6PR10MB5586.namprd10.prod.outlook.com (2603:10b6:303:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 13:46:05 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 13:46:04 +0000
Message-ID: <e022df33-8759-4fa5-a694-d0d16c51d575@oracle.com>
Date: Thu, 4 Sep 2025 19:15:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH net-next] udp_tunnel: Fix typo using
 netdev_WARN instead of netdev_warn
To: Simon Horman <horms@kernel.org>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
References: <20250903195717.2614214-1-alok.a.tiwari@oracle.com>
 <20250904091832.GC372207@horms.kernel.org>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250904091832.GC372207@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0298.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::15) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CO6PR10MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: d53bf274-e79d-4b13-be37-08ddebb964a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bElDUmNkbVEyK3R4TnVoUHM1aFMxbkZIVEF6K1VsZGlQbnJld1ovZFhjME1G?=
 =?utf-8?B?b1JkbXBmeDRoM0svNVcyeGtSWmoxMXRlZEhoeHJOT3o5QlcrbHN5NUNza093?=
 =?utf-8?B?QjRERU1lQkJ1QUl4NVJkUDJ0clFzdjdmWXJZU3ZyZDlUZU5ITk1nMk5ndWZS?=
 =?utf-8?B?RE8vaHkweVovcHV5OTRtemNJRURzMWU2eEhZVmJaNU9MUzBScTR5QlIrL2I4?=
 =?utf-8?B?LzNPOWhYY2VMNHFvc1pqN1lJMThSSGsyQ2wxRERwZnNEaWZFVlozb0gwTk5E?=
 =?utf-8?B?WEM5QS9nMUdHdStHWWRJbjRDVkwwVkV6b0pNNnlGL2Iybnp3RVR4UFByUDND?=
 =?utf-8?B?dFc3VXdrTnN3ZkErem8wd2YrRlFETlA0WTB3R0RETVd5b0I3UGdtejE2cElC?=
 =?utf-8?B?TWhIdmp4cEVienFISWdjYkdUcW95M0xkTTVlSXUzS2o2UFNWbzVLQnBWTU45?=
 =?utf-8?B?b1RmTHFDaUZuMW1sbkhKYy93WEdOV2I0ek96RnlxWVJjSGlRalFJeDkzOGo2?=
 =?utf-8?B?RzVyREVBN2pFd2NCNFRpNnR4WWVhVjN2SGdSWkViR05lNnQ4NzVYTWJIYTNG?=
 =?utf-8?B?V29MNkxZWEFLUzJGUUkzMmlBWmMzU0NlYms5WnZXaWJYdXd1RWlvVHg3VDhC?=
 =?utf-8?B?dldobkpSMVZ0R09DVDllVm9GNFJsL2p1bmRHNkpzNVR6V085N1RTQXhteWg5?=
 =?utf-8?B?ZmJHOSt6VWdVZllpcTA4ekNxc0hxZy9NdUNod3FyOWhxNk52eEIxS0RLMGVE?=
 =?utf-8?B?VC8xcTlJUzVjSU1SRzJyUmx4ZGdZZTU5NWpVNHJNRVlJMzdjMFQ4V1ZBeEVE?=
 =?utf-8?B?ZUludHVhcWtEbmptalJhWHkrS01nTUk5R2xIVXlQRnprclY4V1dUMGVlNlk3?=
 =?utf-8?B?cENGZEFFcW9Pbld0eDlEUU5Oak5Sb0R5TjdNOHB3RjUzOGZCbzhBeW9nQXpN?=
 =?utf-8?B?L3lTWnpKZWxzMjlPaDBZVDRRYVdLTDhqcDE3NTFTYllvMnN0ck1wdllmeHAv?=
 =?utf-8?B?ZzFrSmNXL0ZDZXdncllRR2dNcDZTMlZ1eitwK2V3OGZmdVVZL0xyT3lSbUcx?=
 =?utf-8?B?Ulc4eXVjSk1Vd0JEVmkyOXVOS1RDNExYU2xzejFkTkd6WG5jUitzcTdrWlhK?=
 =?utf-8?B?OStjSzQxZHE4eFRmbGQrTE54NHBiWGVORTBiUjJCeDdHbFhncnFsK0hnRVBv?=
 =?utf-8?B?dWllZ1htZ3p5ak5JaDI1Z2haeGcrU29KRzBleEcxUEhEUWpuSjBnazNMaHow?=
 =?utf-8?B?bU9RRDN6WUkzM1pEMFFCUDR1cmFuYkNXTUJWbHFUOEYwSTZrR2thVWdOOU8y?=
 =?utf-8?B?eEQ4U1YxamFXekk3aW9jTFN0b0hNNFFwOW1KcEkzL3lQVW4yOXk5NU9uUlR3?=
 =?utf-8?B?T3BHMUEwUUxtcGpwenVvZzBFVFdhMXlpdE40MFB1SkVRbTlNN0RvS25pUElF?=
 =?utf-8?B?QmZyaDBSZGl2WUtCL3I2YkFTQjcrakh2WDlIZ3h4NHBFZ3pKcmxobG8ySnpW?=
 =?utf-8?B?OVRvdCtGUDduWEZWMEJVNXZBN2VyN3BFMTA0VFVBbk45RlM1VXh2Tll3b1pN?=
 =?utf-8?B?ZUpCZEdNK25mV2E3QUMzaUNXNWNOUUI0OWp0OFFBbGdnWnJoaGhYM0VlMytK?=
 =?utf-8?B?b012WFB4d0xubnc5L1dpWXJZYTBNMmQwc0R0S2ZyTVY2L1p6cjRiWlFlMi9w?=
 =?utf-8?B?anhmdFdUS2JhbEpCM2RSUStXc09jOHNIOThHWVdzUUYwQlRYZjNKNEdiWlFt?=
 =?utf-8?B?SlYrOStIMDFqWXlJdWpuTit4OFlpWlpSRnllb01QeVBZMGZDSHZtZFN2QXkz?=
 =?utf-8?B?dkxJakozYU1NTmVnTGg2RnBsR2VpaUhlU2dQeXVVMTNqZHpiVGt3MlIvYy9T?=
 =?utf-8?B?N3B0T1NrMVJGTXgxckU2MVU4OS9wQVpmMlBjSFlDT1JwUUc2TVhTanNmVGRo?=
 =?utf-8?Q?lTALAclMIlw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUJxQi9EY0RJdjFEdm9SMmNtbVYyTXcyeXJwTUdDcXU4WlBoT2xST2J0K01O?=
 =?utf-8?B?T3ZhbU1pUlpkWUhEamRmWkZ3cVJaS1F2L3dMWmsydU9vaU4yOTZQV1Y3eDVL?=
 =?utf-8?B?U3k4amdVQjVUVTNEY0lRcGhPeXJFVzJHWnN0alJmVFN1bW1mb1lyWk44R1VS?=
 =?utf-8?B?aDFCd013dzlrYVAzUTR4NzQwb09aNWc2cytrMCsvTTVudXhUNVd3a01OZWxq?=
 =?utf-8?B?OGRuSHVFblc0Q1FXS3hocHMrdFcwMDB5T2RTU1BtbDlNUVUyUWs1SWN3aER5?=
 =?utf-8?B?QURreVh2dU4wVDBiTkFQcnJIY2lWemFXZ0U1VnIveXpPdVVVTWNYbWtzTE1F?=
 =?utf-8?B?Q2pxa1ZjV1ZRSTQ0Ukw0SkpKTDBUbnZvMjZUYkpvN1JvUnppMi9DaW9UeDh2?=
 =?utf-8?B?SlVNZnhZTHBIY0lQbm5Sc3FnMzRIQmoxNmJtODB1b3h4cHFyOGg2Z1FCYTVw?=
 =?utf-8?B?RlUvS2xPVi9oWngrRm5SYkNGdUppQ3lRZWl3OXFRczdDbk0vTzV2dWtaNzAr?=
 =?utf-8?B?RHFTUDVSVUhjZnhveG9UNnV0MGxGTCsrQUpvSWJnZkhXQlF1bUhlZlY0OEFU?=
 =?utf-8?B?NEgyZ1VaU055ZnJydDE4Mjg2Y1htRDF5YXhDTjBCcVNhZ2tZK3MvUDJMR3Ev?=
 =?utf-8?B?Z1A0SFFpMlVSajFJeEhwcUhETjJSRkFuMWM2S3JSU2ViOVFGQm1HdmZncEQ5?=
 =?utf-8?B?UkJSUU00cmRRallHVTc2MStLb0tMWDh2TmVVMUMzRjhNcWJObVBNVjFiSmt0?=
 =?utf-8?B?WCtJUnN5Zm5hZmJOcHRWcStFK1BLSFYwRE5aWWM3bnkwUTIyTkR6em44ZW9t?=
 =?utf-8?B?R3lOa2VWaEtROVlvL01McTE4dXYvRkFkVmJuaUtTY0ZwQjM0YXBNRXVwNXAv?=
 =?utf-8?B?RjJmcmZqY1h3TjRtbWJtSjJFTmwvRE0rK29WbnBsSGlPcE5IZldSdFRZbkhG?=
 =?utf-8?B?dDFvQ0ZOWWZKSmk3WWxmVERaNnN0UVlWOGxHTnZ2N1cvQzVuckV2WUh2VVIx?=
 =?utf-8?B?SXpRMlA1OGVqSjVBUDhaMlEwMitKQkxRTmVuZ3d0WnRxa2xndllqWFFnYzlG?=
 =?utf-8?B?K3lKQjJVN3NHbGc2QUlwV1BnV1pTMTd2NXc3L2Z3SWE3RW5ud3JkcmRYbmMy?=
 =?utf-8?B?UUN4ai9ITURWRDA2WDBRWW9vSXpGMzVuOE5ZR08rbTZTUjBTWXhMcnMvSnRG?=
 =?utf-8?B?SzRYWVFIcDNEeVExS2JXQVFSeTdjZ1RMRE54TkxEVThSOFlsWkhSenN6eWdL?=
 =?utf-8?B?YlExNTZMR0MralBsZ1ROdXJYZ2pZREJZU3M2R1JubTBLQ1FFblRRQVRDenV2?=
 =?utf-8?B?YVA1KzlCelVFUG9WZ1JNYTNsVFJRcjdBRXVxMFlZYTNnbklBT2JDeDRMd1Rs?=
 =?utf-8?B?MUU4bDRaOGVJL2pZeUZySzZCY1pZYVlyODluMW1kS1VXckpzYVJoN1AzcE52?=
 =?utf-8?B?U2Iyc1FZdFNlUWhKRWN4ankwSzR3cXllQUUxanJlUHZMczBXWnNnbExEV1pj?=
 =?utf-8?B?a3F4ZE5LMnZLVnREU0RiRVc4UWc5K2hOcjVzamt3ZUxneDE2MlMyaE1aNXhI?=
 =?utf-8?B?MU1paVRaVDR4MlhyaTZPYWxEZ2tvTitldEpFUVZYTTU1UXJYQkFxR1JUc29i?=
 =?utf-8?B?cVV1ZHg4YmhzQnRPZDFmL1NxSFM3NmdSNlpSZExicER4NVpRN2VQNDh3ZUZY?=
 =?utf-8?B?WHQvcmk2c2FFbWhjNElhcUFUNzg0Yjk0aGFTL3JDRUVWQ0NIbmlVa3cwUGhD?=
 =?utf-8?B?ZDBWb3pzZ1BxZldlSm9MNTFFQTNCOW12QUhDU2lkSTYxanBDWDlxbzhrSitn?=
 =?utf-8?B?a05ZZHcyWE1ZQWJtV09Ud3I0U1RnRXdWdDlpM2dUdEVSOSszNjhFWkJLRzh3?=
 =?utf-8?B?Wko3WDgyMkEreWNJZ1pCa0krbHlyWStSTGRwNXpGVWE1VjJIZ2xrTWRFNW9s?=
 =?utf-8?B?L2NzN0t1WnBNbzUrek12blF6MENzTFdCeDBicm1UWG0relV3ZWtJNHVVN2FR?=
 =?utf-8?B?L01tN1JBSG9jNjdUN2ZqOGxKdXArT3I0RUdQTGxQQTU4Tyt0L3Z0M1BYOHln?=
 =?utf-8?B?SVJBTG1Jd3lOdlNacHVqUUs0VzJmbjJTTUpPMXpZZkhJczh5MlYxb3cyV3ZB?=
 =?utf-8?B?aGpJRTAwcVFkMEhvMGg2OEJvSkFLUnoxUzdKUm5ESUV3MjVtb044OHVTZ296?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ILFDU02A6LiYYLxT+5oEVkdLZnV2uwg2rVCyd8Vknd3ZXGUnmRXfFiS8pvDqnV6UhaK0+e7ItaO9/wpr5+emL/QU8VRKGMSDZbF0tTwyOEEZ5RVdYgeybHWTxTHJ9yyvNUuS7xs4nu8GVRVTstAZB7t7+F7JPO+tp6PSct2znqlmYRC+7iJ7qtnyvJAdjORQDo9pB7I+ADURuCrvzCszFeKp14OHZYE0TKBO6/g3VDCLKlNj2qEkc8/TPe5KXpVX2O0yafY342ZQLbT6aZrxJz3sXXRdKY0RXghcGdZTI7+MwZzaJTsI/+ig/f3Y0DVjOEhCcZVEM/x/rEKEsty90BZce1RORswU+luqNFyYHx1AFs0aV0GPQgc/Qi2eIxzp0gSrYc4SLnhjYv/4j+eDJEeaRYEo6jAdREY1fDGmjZYxek8MkBAal055A+hLomCRnwUENIpQWY+eQAHGinMHfQqU6s8SL6EeHIPs4AmUf5lJciiKSKRYfESWUspMEJZpd3h+gXIeznLiIjBC4NytHkXO8d1PFJkIxwQdcGPf2zWv3WcgKSR+vdsY0EYH2wxP2dIf652uRvUwZ4qSu6C8y6SAsHDixQWvwcufHOesOrw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53bf274-e79d-4b13-be37-08ddebb964a3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 13:46:04.8749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llGBdfO9km9uGt5POVqvZ/P0u0PtRYol81dcwK8hTzayFdeCAqSA1OIYQj77iCOzFexm8r1ybslrxLrAMcuAAy26wnFalsIkn0U/vdWwQOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509040136
X-Authority-Analysis: v=2.4 cv=eJ8TjGp1 c=1 sm=1 tr=0 ts=68b9998a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QrCLNJhHXfeXM9h_FfIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12068
X-Proofpoint-ORIG-GUID: Vj8EAAJBtlrNDztm3sLoN1bbzmk5hVqb
X-Proofpoint-GUID: Vj8EAAJBtlrNDztm3sLoN1bbzmk5hVqb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDEzNiBTYWx0ZWRfX84ZOGuji0yle
 2i6Ev0adJ85XbAzEZYHHlABRFLa+/1SpNDmeXIKHLx77QHgV+biTrWvo4i5hRniNyDsD+w0BIi7
 PtELF1tbY3Urkd98OMGL12MYHzK5rDa71iuqopki5E55TH1ufF4o4249QtiiQ4G2Rjlmez0q4r+
 Tzxu8kX9ehhY3lsWjnBcDvBJfWiG4IF7YiC7av0zIijv5BB+nVInc9azj9sm4BfYc6cvtgunzyK
 DVRx4rgSN4usUh5WO9vyj79S2OzJ4HruuWRkaBUp/Ls5pqRTo7dMs1KwakdW1UtiDRy48gEUX+B
 PPha9X1ekTr/Rbejwhtq9TURYT49mlzVkoavQT7JfsIgMXGTA51hCvGdrxnhwmNsrJljZ95ztz/
 KWYe+2IZROVuAHwxpLjEDnPOhyWe4g==



On 9/4/2025 2:48 PM, Simon Horman wrote:
> On Wed, Sep 03, 2025 at 12:57:12PM -0700, Alok Tiwari wrote:
>> There is no condition being tested, so it should be netdev_warn,
>> not netdev_WARN. Using netdev_WARN here is a typo or misuse.
> 
> Hi Alok,
> 
> I agree that using netdev_warn() seems more appropriate.
> 
> But doesn't the difference between netdev_warn() and netdev_WARN()
> lie in the output they produce rather than testing of a condition
> (or not)?
> 
>>
>> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> 
> ...

Thanks Simon, agreed, I understand your point.

since WARN() triggers backtrace and dumps the file name
it is not require here. The failure in udp_tunnel_nic_register()
should just be treated as an expected operation failure, not as a kernel bug

Should I send a v2 with an updated commit message
(remove "condition being tested"), or drop these changes?”


Thanks for your review.

Thanks,
Alok

