Return-Path: <netdev+bounces-239904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BB4C6DD18
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F21334E477
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CBA2F656A;
	Wed, 19 Nov 2025 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I2oDO0Up";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TzA48yzR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6AD2EDD75;
	Wed, 19 Nov 2025 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763545593; cv=fail; b=lHb4ImaI1T1o2P9i8Wgzx/qu1z8M4A6UAXoHSYtAKHrMZPzIIVNqZiHLjszgzqFhnQyvzZ8CBJmMTuT6mybkpccvB73MFOqSj5ErWvWgrd4HFr5toMRDpArtk+FgOs02V7B5tgiOSpgMFOjcXq+F/S1mnQgP62iVLYW1ub+J5NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763545593; c=relaxed/simple;
	bh=S9elYjsHMDtbOm47+/nst9XcOjAnN0fXmcG3kG6nafU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BPFtVT2IeSWv/1VMN5RIYIRBh575IUV9Xp95WALh+Y0t8Vy0p3J6il+Bzzp7KUnPQMOVID/j1BF545cytN6Wb4e3SJs2yerei5wdl+aBSI7EIAT1+uay59s3SaS4s7IhIkm7BF6i7P4CzpJar7mEkYvnJnL3b6rg25upp92h66I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I2oDO0Up; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TzA48yzR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ9fVOk015196;
	Wed, 19 Nov 2025 09:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xQB55e8/P4KLqHYL3VdnVp63mCmuwdWPDiFolU01ooY=; b=
	I2oDO0UpIwS1JTdShYY2XcQodkHGKtNelVQMf6TuBoAebnyTCdBCH62S9W5L6SVF
	76SrQffM9VsBMpmveVnmkd/IzIh3Jx2L/gAa6BSsJmkOe1/A/oE+JFbKP79NklvB
	Gqc+QTDUm1lnWuYb/2EB9XyT1Jvi5XXczrsQ5RKJ6aTMy2BfVY5QLGRibwnyJZx9
	GadGOIw70AJOamFCREpVykScaJzJJ3yFTvAyQFD2gi2/7xI24RYwMFwjrYJpuYem
	82QPm2Hpkp1jwzrD7F+S4TDIRlzwsB+LzXN8PKng8rsXQ7x0FMD13dquNL0PMHFC
	Qyj98mA/EWiI7JJY7r988w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbxm3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 09:46:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ9VRIO039837;
	Wed, 19 Nov 2025 09:46:00 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefymnrw9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 09:46:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PR8ywJxTviFMlfye0edZTimWEJyapaBwBVngwoJsqDZccfg8kQtJBz61jUmDdeIsXF9FuRfci3lAdCQzsWWZKannT5Fk3xnMc7s9Mf2bzvT5ql4nzq6Ie4cRz5pD0bQiNmgMByIzRicLIAKDJuK4Zzc1eMzvEfnvt9tIR4SFbT9yUbkO/zSA4G5K0mfIZwSI1a/DVOiLYHbXU1sRMjYOPp+KeEcDqs8jwtAByLYJIl17QUffF+a2kVHbm/plv3CTdZMymAD/WWPBeB6u7ZH7qRlSZKLIvrSWBVc1YbtttlarUysR2RmDDc79YQwkPb74ivmkVKasNj1k/P17eEEdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQB55e8/P4KLqHYL3VdnVp63mCmuwdWPDiFolU01ooY=;
 b=U+ScWFHIRYF/pVIMpXUQZUXavaY93dX4LJy+B6PvRWoEcaqwS+zPY9IWsHvMp16kukXPUbkwNuHySzTOOpGYKSAePxYfDrdervmBuV5RuGXcjaTEtDTIBwX9mxZfo17qtv2sZ2t3i//YrKdA/ljCQucCRYOQ/ztTcp0VDVmjNly61erc7zE5BRdqa8dtzLCYvAE6ZK5fyNOl354TQKM6Py7kWNMj9xozvvncRnlPlm/QgZDUThUg038UWU+Z9rcVfekJEz9O15+zZEGelIOLd2GoZZA/WpssO6mM/Kr9qV/ojwmvOZqqHtUuS/ndIpXsQJOJXFpAPn0bsrBdh6qZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQB55e8/P4KLqHYL3VdnVp63mCmuwdWPDiFolU01ooY=;
 b=TzA48yzRxCuNt4KFEoxlfwipGiifg9o+wnI3QvuCusoDDk6VRddU419TwVrUyZxGVxQG5E1oQYDU7rxF49OwkQLSdrI+8F+S10rWKGJmSy6u/Ur/WEAtL7RfNlCwHxoUpnAsCegANKa8o9H7XBVbf7rxQ9r1zlS1nIWOsbkqniU=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH5PR10MB997733.namprd10.prod.outlook.com (2603:10b6:510:34c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 09:45:58 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 09:45:57 +0000
Message-ID: <75684350-48e9-4438-ae42-431d7eb2a5f2@oracle.com>
Date: Wed, 19 Nov 2025 15:15:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [v2, net-next 01/12] bng_en: Query PHY and report
 link status
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
        vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
        Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
References: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
 <20251114195312.22863-2-bhargava.marreddy@broadcom.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20251114195312.22863-2-bhargava.marreddy@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0237.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::9) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH5PR10MB997733:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f02641-7f01-4684-f989-08de275070ca
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aDgxVVMwVmVYcytiUU9vZUF0Z245RDkzRndJek53bFRBUktNbDg3aTFkUU9O?=
 =?utf-8?B?T2FjTTVnQnBqekNGL1pDdHBjV29oZnBZTnpJcXM2aFVjNmMydlEyVTJkcHBY?=
 =?utf-8?B?eEg4OWZKNGlvbWpIbTl2RDRsYmZCVUpkaHRwcUVmL0k4ams2cTEvQnRDb2JW?=
 =?utf-8?B?NldUZTdOTFlWN0ZnMnMweEQyMTlTL0s0L1BxV3lMUmIvRkdSTHZyWjgxTXc1?=
 =?utf-8?B?U0hueUNOS09uV2xMbFdWT1E0RG5TRUVNT2ZoU3NpeEFEMUZoNFV0Tysra29a?=
 =?utf-8?B?UEpnMHEzVHR5d1NxODk4U3ZZUk1TRzZnY3RSamRnYm5tNGRCWWZCcE1kaEdI?=
 =?utf-8?B?MXNYLzc3eGpHbklXWm9lZmRTSDJVYVUrcUlGNFdYdnJUOHR4TmlFbzQ3WFND?=
 =?utf-8?B?bUo3UGJqK0NHbWhHNEtqSE8rZG5RRmRQVml0dVJIdWRQdzZwUEU3eGZnUnhW?=
 =?utf-8?B?K3JhLzdGejZ4aVZ3RWR1aFg4SCt2K2phSHNwNUJLUVVJSktncXpVLzZUMlNK?=
 =?utf-8?B?cUovTTZRQi9yT0pHRkw4bEtrRDJJd1lYMnZWbVpCRjBheWtYNXNHOVdCOGNs?=
 =?utf-8?B?aWVZYVFwWWVYQ0JZL1FTUmN4blRSWXR4VEVZMnRxM1ZrUlFZWllLUTZMd1F1?=
 =?utf-8?B?VVpxYTdveFVGaHc3Y1hkdnNKWEdFQ1pZaGswLzlJY3RodExOSmJnYllqUkh0?=
 =?utf-8?B?dkZSOEZ3bkszM2lnYThFZmxOc2Jobjk0NTFqaEcwOUhrYlJ1eHBHKzNxYjla?=
 =?utf-8?B?bkEvUmFVa2lZZkVOY0M3YWw2STlrT3h6N0paYkp5Q2Y3dVJnc2pCdURaQy9Q?=
 =?utf-8?B?M2RjYjNpWTBLM1NEcEEvc25DdVVmUHo3NmlzRkFnSHAzdk8yVnl5UzV1YjE5?=
 =?utf-8?B?blZFaUdjT1U0NFhTOHh3dTBYYmpVY0x3Sno0MThxd2hPa0hKRkdkdGVRWjdn?=
 =?utf-8?B?T1RJalpKejFJQmllOWhIdXVuNCtidVF1aExEWEZXMlo3T3dIWm9yaVJTd2Fq?=
 =?utf-8?B?LzdXRnExbGpVTGRJMEttMDZtMi9jMkNtcG14bU5uMncrWFhEcmlVazZ2OHVi?=
 =?utf-8?B?L1RrQmNXdHNhMlV5LzhmdHEvZTdOQnBmT2tTZjFwREM0Sy9ZL0dzVTFZVmV1?=
 =?utf-8?B?Y2VscGxLZVBTWUo4VEZmcWtKZndndVBnaUhBSmV2My9QQTNnMmJCNVNDTUk3?=
 =?utf-8?B?RGVkSldGT0hHMUJ4d01nNHQrM3ZUYWNlc3ExMW1hWEdudGJ6ZGpHbHduRk12?=
 =?utf-8?B?czU2SWZQU2poNUtrbUZlWmxDRXcxeTdqd0ZLU1pDL05JeHJQRVFhbzFBcHlo?=
 =?utf-8?B?bkVka25Tdk9PMU1YdW44RjdDR2svSFRRUXg3cW1xckMvQTladFNPcUdVRjRB?=
 =?utf-8?B?eWtWeEpJL2tOTlZJSUxFcUtZbnN1STRIU3dWL2dabkF1eWpmSCtMdCtiUC9a?=
 =?utf-8?B?VW5hSk5LZExQNkVPb0tRdnoyTHdQM0lZeURod3E3cW02TzdxTXVYSkUrck5G?=
 =?utf-8?B?a0xvOWNzN2xGMWJVM2lKMllTQzZEY0RMbVM5Ry82UWtYbnQxTHJjbHM0d1FR?=
 =?utf-8?B?T0d6d1JteUVCcHZlY2d3ZmhKL3E2TTVrR0Q1Wk0xQzRLRTF2MTBmckNuYlYy?=
 =?utf-8?B?NzJDTkxkYitwZDVHUXQ5MHBWaWZmMGpFVWVWRlIwUVhnUmppYVlEcnhwRjBE?=
 =?utf-8?B?WER2Z0ZrQkNmNU5OK1BaTUFtd3kwbFl0TXVnOGlvOW95azRsVVFiR2tXdzlw?=
 =?utf-8?B?cTR2ZUU0ZzlmZVhzNDFSSTNnTkIxTW1tOC9kZk1Yd2M4d1pWbnlDWUFFVmxP?=
 =?utf-8?B?Ti9wTkFXcm5KMnRCUHNLMnhsakpWckJLQmJweWVhcllKZ3p2SjN1R3JscWpB?=
 =?utf-8?B?NTJrUVRXSDRJaTJuTkRjM3pTbXNscGUwUjBBZEJWODdWL1NTNFdoa1pqMFhz?=
 =?utf-8?Q?mfpKwJDYZz92YN4vg/abopp9Kr75SGMu?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QUJwSWVZVzYvZWNLS1AzaEVYM3N1bXhveThXb2ZCQlkyT2xKcVBEcUFtSFla?=
 =?utf-8?B?SCtwNFd4dEZWVmJOTmkwUnNXMUUwNmc3LzdxeUFhV2tTV0tHYU9FRWp3YXhY?=
 =?utf-8?B?RkRqZDlmamUwUGtkdE5ad3E4UmtWWDNrV0xxZFE2NTBuQ1kzeWlpOVVsbHMy?=
 =?utf-8?B?YnpDRG44dkdPdGVVRFlOemZ6eFN2aHVDMlZ1RFl6b2U2WDNRbVc5QVVtcWZB?=
 =?utf-8?B?WDMrS1ZvbkNuQUUxeFpEWkdsSSsyeXdNQXJzeGpMUkhrK0xYY1FvU0Nza2o1?=
 =?utf-8?B?d2U2R2lNSnFTcHI0Y2xkU3NxSURQV3JaU2ErN1RMVjhwY3NHK3BWT2M0ZDFn?=
 =?utf-8?B?RjBnVy9wRjJKVXh5MmdHd3FqMk9vbDBMYXowK3E3ay9IQktYYzlrbnR0cUkv?=
 =?utf-8?B?M3pDWjYxUURHbmN0N2RMb0VpQjBVNEE2a2RvQ3hUTVd4QnAwLzVaUDJPeWs4?=
 =?utf-8?B?VWpNMmFwdEQwaTRPZUpCd21BUXloVEJZK3dxNjQ1UTJZZnJaSytUZXBlSlNt?=
 =?utf-8?B?Y29VWEdBTFU4cWVrbHEvWjlRWFdSSURPdUtKQnJwcVBudC9aOUZtcU9PZE1s?=
 =?utf-8?B?c0w1ZmN0Vms3UGk4VURHbll5RW1Pa0QxTDB0WDJPOWxrOEd1K1I1R1d6SXlk?=
 =?utf-8?B?MVZpYmVDaldPMTRndVhvaFhEVzlzZnZaaEhWNTdYMFhrcGFhc2MwUEthaVhB?=
 =?utf-8?B?SkhWWWgrcys0bFRJWkFaOXhHQ1BMTnJadzB4TEdFbGxwM3ZMWG9sU2V4VGZm?=
 =?utf-8?B?VjVMK0k2VHQvSlFWN25RdFNFdEI3WTNzdTU1M3BBR3NzTUVEWHRybjJDcVEy?=
 =?utf-8?B?ZWhaRFAxdXBZamltbHlPWGhULysrMEQ0V3doRk1Wcmc3Ym9CaFg2TWU3Ulo2?=
 =?utf-8?B?a3VMVExpZ1luaUxYZU8rTnhOV3dkNlg2T1haRHY5SlMrQXVNWklEcXFoaFdE?=
 =?utf-8?B?d0xlNmRXMC9nSlZtSFY4ZFA5TTJkbEtRUDArRWtwWGJETmlLeUpEYjM3OC9F?=
 =?utf-8?B?WEJjdmNBT0Z5akpwbFIxSjBwcEgwMjRKZVZyQjlTdVpWVGdGbXlqRHB5aW1M?=
 =?utf-8?B?LzBGNy9IVFl4V2xhazl2MVVTQWFnbEt0SFZldmo5ZzJ1SzNBVUd6ZHd1cDZi?=
 =?utf-8?B?Nk5VamdLWTVzU3NUSDdWcGZNbGZxMDE2LzB3TkRwNllQTTM2Qk4xSml1d254?=
 =?utf-8?B?R3l2bGJrVXBJR0hGUUtKUDNOcmM3cGMrai9MZ1R6VENFdXhzTDlNQkpzL3Vy?=
 =?utf-8?B?UlRUS0xDbkJ6bDVWT3VUS0pmeDFqZ3dlcHRqUFQza3d6Y3VlOVZmNk9WTUZD?=
 =?utf-8?B?S3dubnBUeFFyK28rYkYwWnZ1TTU0T0M3TWowRzhmdHQxM08rYWpPZmc2a2Fa?=
 =?utf-8?B?aG43M1lWZ3BacWVpVmtHb2NHMmZzL2xvRUFKeXQrcXVzeDlnQ0RudkVBUTZJ?=
 =?utf-8?B?MU93VXRKL1FNZHYyN2JRYUo1d2dWTm9xdGdqTHpLV04rNktFRUdWZkI3Rjdv?=
 =?utf-8?B?TWlsZmlYc1dTNWJsK3cvLytvUXVRem11VEFob3NjdVFuN0sxWUZxakFvRHVZ?=
 =?utf-8?B?NDZNTlZFL0hpYldUMk1hQlM3bmhLMkRPaEtTNEhmb1k3TmVtR0VjY29XWHlh?=
 =?utf-8?B?enFtOEpYaExGNytOWDVDKy8vemRnWmtRNlZWRmVJa01pbnBUc24wVU9xbk5W?=
 =?utf-8?B?bm9jVkZ0M2x3cnRoT0dxalM3UC9jc2x0anBMRGJLRjNqb1hmK3dzblJBRWkz?=
 =?utf-8?B?VnRUK1pYdjZwNndLK0ErcEplcTdzQ042eU9GeXBuYVdPdFdvVUsvZG1XR3NU?=
 =?utf-8?B?Y3A2RWhFUEFoZEZKYzBDRVVhWU9ScmRVUVpsZjJFQ0ZsUTB5T0NUZE5wZTQx?=
 =?utf-8?B?NkVWUnNiUEpHeHlNVExQZHA3OGpJbDJRdUdVbm43RUhwaUVqSXMwcWtiRWZX?=
 =?utf-8?B?d1M2YUZCbWNKOGJ3WlVzNFJkQjV5cjNXUEh3TzVqRUxmamw4SWlNWENUVm01?=
 =?utf-8?B?cU5GbUtZM2ZWWDRsNDlQUmYvU0l1QkZZTFRLWjcySmlXeE5EWVZRbXRFRXk0?=
 =?utf-8?B?L0RDRzVvY1psQkVZNU5QYU5VdEttcmppMDdmN0VqUUlvTVlpZC9SVGgzRlUx?=
 =?utf-8?B?bzVKM0RONEdNT1JZdTZ5NDF0WDZGb0NwcWt1SUU5Y2t5dGZBazVrSVJxSGY3?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aCU+iP0b3UIqSD3XkC7xAdX2r9a4+wE1fUVI1COPw4KTB5inUDFSKB+oKO7ZApxIEMiOa/v5U4CZHkBwj9/wdvskvL+r+XpG6cevAQCmum2YdS6A45HY3wQHlqq5WcYFI7xBwbvDqK6aeGh3MQUUAW89BRfaM2axGkL70XcNtNbFERsPhJTCt7VqikH/nTjcHwG802l52BcLoacqPuSMTtzXq4MziZ2lhiylMyrDIhaplhr/+1Gsf89AgBXWHMu2Qfr/BOrLOdvARt+g5c3i5pXU0WkmCDrTilysYfB7zVWgjA9u1LwUQNl9Sca8/916NyAmGcg6HCaNKyDpzKZUhEXOVm4qzrxzCqczqFZDbMAQZ0lvbeek0F+29pt2+GWx7XjnwL09px1S8onGJZKVNAX0DFY2zszo9N71+M7ETumVNkAeKGT79v32AxvxWlKgmD6K/5YQvJu7h4tK35Toa6Ars10TSrthny0YrXrfjxwmALyCUoQWBGPLNNBeoLmfcjl+r7yBm3wlc/3vUivg1uk2w1nBiS04pM+m+g3ojDA+cgz/P40iHKfDch7CQXQg4Z0OeJqoKRK73rz5YZBwO5lQ7v2XXuc7d+NG/6MkInw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f02641-7f01-4684-f989-08de275070ca
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 09:45:57.7612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhCrxSuPZp01coUWQzMW/2/ohzppj8PAIaWIIVVpEbeiYlgenpExhsjQoCGWy4ZlbqIPT0N/Rp9GoWHHGl0B6NQJEudAtSwkrTdTvPRHLBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997733
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190076
X-Proofpoint-GUID: 0BmqFIj7E4br_KdhLZ3CUPuIAVjgJVCt
X-Authority-Analysis: v=2.4 cv=JZyxbEKV c=1 sm=1 tr=0 ts=691d91d9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=fxXqJguxbffst5WLTZgA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: 0BmqFIj7E4br_KdhLZ3CUPuIAVjgJVCt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX4iaQpWizsrBf
 WE+oOScdHVDirsjwYP/KAACdSjTAyTMU9UgGpmgsntYfa4BC0kAybZ94aa8hDai9XfaaeBBfuxh
 T1HKhc4R3iHcWHd7sZwcE89J9g9du+cQqRlyGXOQG3cebbTX2eRVMSFMaBVjlR8Qv2NSVfDdJOT
 JPFHxuqbwjLHulw1dAE7/1ImmHaCXGlzkkuiz7eTEpOagjoMGzP2xUFBlNCkOX6ywU/TFtiHNXZ
 gJhOtq2PbNiygmjpXhE6Yq/n66IRVX5Yzbch1Vge/cp3YUr35hyBQEWnhHpTjzWGzmC9thKM7Ry
 T/fVYj4nzj7mCTPPQooYyN2LL0B+iaK0TpAGdX3ml83hYH5aaT24PleXwEEHXVbdkUIo3fFZCP6
 4DMzAG7j8u2qhkZz8lwNmr5EBeMi1B4Gju4FLqoTEwJbRaLv2bY=


> @@ -9,8 +9,10 @@
>   
>   #include <linux/etherdevice.h>
>   #include <linux/bnxt/hsi.h>
> +#include <linux/ethtool.h>
>   #include "bnge_rmem.h"
>   #include "bnge_resc.h"
> +#include "bnge_link.h"
>   
>   #define DRV_VER_MAJ	1
>   #define DRV_VER_MIN	15
> @@ -141,6 +143,17 @@ struct bnge_dev {
>   	struct bnge_ctx_mem_info	*ctx;
>   
>   	u64			flags;
> +#define BNGE_PF(bd)		(1)
> +#define BNGE_VF(bd)		(0)
> +#define BNGE_NPAR(bd)		(0)
> +#define BNGE_MH(bd)		(0)
> +#define BNGE_SINGLE_PF(bd)	(BNGE_PF(bd) && !BNGE_NPAR(bd) && !BNGE_MH(bn))

bn is wrong.

> +#define BNGE_SH_PORT_CFG_OK(bd)			\
> +	(BNGE_PF(bd) && ((bd)->phy_flags & BNGE_PHY_FL_SHARED_PORT_CFG))
> +#define BNGE_PHY_CFG_ABLE(bd)			\
> +	((BNGE_SINGLE_PF(bd) ||			\
> +	  BNGE_SH_PORT_CFG_OK(bd)) &&		\
> +	 (bd)->link_info.phy_state == BNGE_PHY_STATE_ENABLED)
>   
>   	struct bnge_hw_resc	hw_resc;
>   
> @@ -197,6 +210,22 @@ struct bnge_dev {
>   
>   	struct bnge_irq		*irq_tbl;
>   	u16			irqs_acquired;
> +
> +	/* To protect link related settings during link changes and
> +	 * ethtool settings changes.
> +	 */
> +	struct mutex		link_lock;
> +	struct bnge_link_info	link_info;
> +
> +	/* copied from flags and flags2 in hwrm_port_phy_qcaps_output */
> +	u32			phy_flags;
> +#define BNGE_PHY_FL_SHARED_PORT_CFG	\
> +	PORT_PHY_QCAPS_RESP_FLAGS_SHARED_PHY_CFG_SUPPORTED
> +#define BNGE_PHY_FL_NO_FCS		PORT_PHY_QCAPS_RESP_FLAGS_NO_FCS
> +#define BNGE_PHY_FL_SPEEDS2		\
> +	(PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED << 8)
> +
> +	u32                     msg_enable;
>   };
>   
>   static inline bool bnge_is_roce_en(struct bnge_dev *bd)
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> index 198f49b40db..b0e941ad18b 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> @@ -14,6 +14,7 @@
>   #include "bnge_hwrm_lib.h"
>   #include "bnge_rmem.h"
>   #include "bnge_resc.h"
> +#include "bnge_link.h"
>   
>   int bnge_hwrm_ver_get(struct bnge_dev *bd)
>   {
> @@ -981,6 +982,192 @@ void bnge_hwrm_vnic_ctx_free_one(struct bnge_dev *bd,
>   	vnic->fw_rss_cos_lb_ctx[ctx_idx] = INVALID_HW_RING_ID;
>   }
>   
> +int bnge_hwrm_phy_qcaps(struct bnge_dev *bd)
> +{
> +	struct bnge_link_info *link_info = &bd->link_info;
> +	struct hwrm_port_phy_qcaps_output *resp;
> +	struct hwrm_port_phy_qcaps_input *req;
> +	int rc = 0;
> +
> +	rc = bnge_hwrm_req_init(bd, req, HWRM_PORT_PHY_QCAPS);
> +	if (rc)
> +		return rc;
> +
> +	resp = bnge_hwrm_req_hold(bd, req);
> +	rc = bnge_hwrm_req_send(bd, req);
> +	if (rc)
> +		goto hwrm_phy_qcaps_exit;
> +
> +	bd->phy_flags = resp->flags | (le16_to_cpu(resp->flags2) << 8);
> +
> +	if (bnge_phy_qcaps_no_speed(resp)) {
> +		link_info->phy_state = BNGE_PHY_STATE_DISABLED;
> +		netdev_warn(bd->netdev, "Ethernet link disabled\n");
> +	} else if (link_info->phy_state == BNGE_PHY_STATE_DISABLED) {
> +		link_info->phy_state = BNGE_PHY_STATE_ENABLED;
> +		netdev_info(bd->netdev, "Ethernet link enabled\n");
> +		/* Phy re-enabled, reprobe the speeds */
> +		link_info->support_auto_speeds = 0;
> +		link_info->support_pam4_auto_speeds = 0;
> +		link_info->support_auto_speeds2 = 0;
> +	}
> +	if (resp->supported_speeds_auto_mode)
> +		link_info->support_auto_speeds =
> +			le16_to_cpu(resp->supported_speeds_auto_mode);
> +	if (resp->supported_pam4_speeds_auto_mode)
> +		link_info->support_pam4_auto_speeds =
> +			le16_to_cpu(resp->supported_pam4_speeds_auto_mode);
> +	if (resp->supported_speeds2_auto_mode)
> +		link_info->support_auto_speeds2 =
> +			le16_to_cpu(resp->supported_speeds2_auto_mode);
> +
> +	bd->port_count = resp->port_cnt;
> +
> +hwrm_phy_qcaps_exit:
> +	bnge_hwrm_req_drop(bd, req);
> +	return rc;
> +}
> +
> +int bnge_hwrm_set_link_setting(struct bnge_net *bn, bool set_pause)
> +{
> +	struct hwrm_port_phy_cfg_input *req;
> +	struct bnge_dev *bd = bn->bd;
> +	int rc;
> +
> +	rc = bnge_hwrm_req_init(bd, req, HWRM_PORT_PHY_CFG);
> +	if (rc)
> +		return rc;
> +
> +	if (set_pause)
> +		bnge_hwrm_set_pause_common(bn, req);
> +
> +	bnge_hwrm_set_link_common(bn, req);
> +
> +	return bnge_hwrm_req_send(bd, req);
> +}
> +
[snip]
> 
> +
> +int bnge_update_phy_setting(struct bnge_net *bn)
> +{
> +	struct bnge_ethtool_link_info *elink_info;
> +	struct bnge_link_info *link_info;
> +	struct bnge_dev *bd = bn->bd;
> +	bool update_pause = false;
> +	bool update_link = false;
> +	int rc;
> +
> +	link_info = &bd->link_info;
> +	elink_info = &bn->eth_link_info;
> +	rc = bnge_update_link(bn, true);
> +	if (rc) {
> +		netdev_err(bd->netdev, "failed to update link (rc: %d)\n",
> +			   rc);
> +		return rc;
> +	}
> +	if (!BNGE_SINGLE_PF(bd))
> +		return 0;
> +
> +	if ((elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL) &&
> +	    (link_info->auto_pause_setting & BNGE_LINK_PAUSE_BOTH) !=
> +	    elink_info->req_flow_ctrl)
> +		update_pause = true;
> +	if (!(elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL) &&
> +	    link_info->force_pause_setting != elink_info->req_flow_ctrl)
> +		update_pause = true;
> +	if (!(elink_info->autoneg & BNGE_AUTONEG_SPEED)) {
> +		if (BNGE_AUTO_MODE(link_info->auto_mode))
> +			update_link = true;
> +		if (bnge_force_speed_updated(bn))
> +			update_link = true;
> +		if (elink_info->req_duplex != link_info->duplex_setting)
> +			update_link = true;
> +	} else {
> +		if (link_info->auto_mode == BNGE_LINK_AUTO_NONE)
> +			update_link = true;
> +		if (bnge_auto_speed_updated(bn))
> +			update_link = true;
> +	}
> +
> +	/* The last close may have shutdown the link, so need to call
> +	 * PHY_CFG to bring it back up.
> +	 */
> +	if (!BNGE_LINK_IS_UP(bd))
> +		update_link = true;
> +
> +	if (update_link)
> +		rc = bnge_hwrm_set_link_setting(bn, update_pause);
> +	else if (update_pause)
> +		rc = bnge_hwrm_set_pause(bn);

new line help here

if
update_link == false
update_pause == false

it will return rc = 0 assign by bnge_update_link() correct?

> +	if (rc) {
> +		netdev_err(bd->netdev,
> +			   "failed to update phy setting (rc: %d)\n", rc);
> +		return rc;
> +	}
> +
> +	return rc;
> +}
> +
> +void bnge_get_port_module_status(struct bnge_net *bn)
> +{
> +	struct bnge_dev *bd = bn->bd;
> +	struct bnge_link_info *link_info = &bd->link_info;
> +	struct hwrm_port_phy_qcfg_output *resp = &link_info->phy_qcfg_resp;
> +	u8 module_status;
> +
> +	if (bnge_update_link(bn, true))
> +		return;
> +
> +	module_status = link_info->module_status;
> +	switch (module_status) {
> +	case PORT_PHY_QCFG_RESP_MODULE_STATUS_DISABLETX:
> +	case PORT_PHY_QCFG_RESP_MODULE_STATUS_PWRDOWN:
> +	case PORT_PHY_QCFG_RESP_MODULE_STATUS_WARNINGMSG:
> +		netdev_warn(bd->netdev,
> +			    "Unqualified SFP+ module detected on port %d\n",
> +			    bd->pf.port_id);
> +		netdev_warn(bd->netdev, "Module part number %s\n",
> +			    resp->phy_vendor_partnumber);
> +		if (module_status == PORT_PHY_QCFG_RESP_MODULE_STATUS_DISABLETX)
> +			netdev_warn(bd->netdev, "TX is disabled\n");
> +		if (module_status == PORT_PHY_QCFG_RESP_MODULE_STATUS_PWRDOWN)
> +			netdev_warn(bd->netdev, "SFP+ module is shutdown\n");
> +	}
> +}
> +
> +static bool bnge_support_dropped(u16 advertising, u16 supported)
> +{
> +	u16 diff = advertising ^ supported;
> +
> +	return ((supported | diff) != supported);
> +}
> +
> +bool bnge_support_speed_dropped(struct bnge_net *bn)
> +{
> +	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
> +	struct bnge_dev *bd = bn->bd;
> +	struct bnge_link_info *link_info = &bd->link_info;
> +
> +	/* Check if any advertised speeds are no longer supported. The caller
> +	 * holds the link_lock mutex, so we can modify link_info settings.
> +	 */
> +	if (bd->phy_flags & BNGE_PHY_FL_SPEEDS2) {
> +		if (bnge_support_dropped(elink_info->advertising,
> +					 link_info->support_auto_speeds2)) {
> +			elink_info->advertising =
> +				link_info->support_auto_speeds2;
> +			return true;
> +		}
> +		return false;
> +	}
> +	if (bnge_support_dropped(elink_info->advertising,
> +				 link_info->support_auto_speeds)) {
> +		elink_info->advertising = link_info->support_auto_speeds;
> +		return true;
> +	}
> +	if (bnge_support_dropped(elink_info->advertising_pam4,
> +				 link_info->support_pam4_auto_speeds)) {
> +		elink_info->advertising_pam4 =
> +			link_info->support_pam4_auto_speeds;
> +		return true;
> +	}
> +	return false;
> +}
> +
> +static char *bnge_report_fec(struct bnge_link_info *link_info)
> +{
> +	u8 active_fec = link_info->active_fec_sig_mode &
> +			PORT_PHY_QCFG_RESP_ACTIVE_FEC_MASK;
> +
> +	switch (active_fec) {
> +	default:
> +	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_NONE_ACTIVE:
> +		return "None";
> +	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_CLAUSE74_ACTIVE:
> +		return "Clause 74 BaseR";
> +	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_CLAUSE91_ACTIVE:
> +		return "Clause 91 RS(528,514)";
> +	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS544_1XN_ACTIVE:
> +		return "Clause 91 RS544_1XN";
> +	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS544_IEEE_ACTIVE:
> +		return "Clause 91 RS(544,514)";
> +	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS272_1XN_ACTIVE:
> +		return "Clause 91 RS272_1XN";
> +	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS272_IEEE_ACTIVE:
> +		return "Clause 91 RS(272,257)";
> +	}
> +}
> +
> +void bnge_report_link(struct bnge_dev *bd)
> +{
> +	if (BNGE_LINK_IS_UP(bd)) {
> +		const char *signal = "";
> +		const char *flow_ctrl;
> +		const char *duplex;
> +		u32 speed;
> +		u16 fec;
> +
> +		netif_carrier_on(bd->netdev);
> +		speed = bnge_fw_to_ethtool_speed(bd->link_info.link_speed);
> +		if (speed == SPEED_UNKNOWN) {
> +			netdev_info(bd->netdev,
> +				    "NIC Link is Up, speed unknown\n");
> +			return;
> +		}
> +		if (bd->link_info.duplex == BNGE_LINK_DUPLEX_FULL)
> +			duplex = "full";
> +		else
> +			duplex = "half";
> +		if (bd->link_info.pause == BNGE_LINK_PAUSE_BOTH)
> +			flow_ctrl = "ON - receive & transmit";
> +		else if (bd->link_info.pause == BNGE_LINK_PAUSE_TX)
> +			flow_ctrl = "ON - transmit";
> +		else if (bd->link_info.pause == BNGE_LINK_PAUSE_RX)
> +			flow_ctrl = "ON - receive";
> +		else
> +			flow_ctrl = "none";
> +		if (bd->link_info.phy_qcfg_resp.option_flags &
> +		    PORT_PHY_QCFG_RESP_OPTION_FLAGS_SIGNAL_MODE_KNOWN) {
> +			u8 sig_mode = bd->link_info.active_fec_sig_mode &
> +				      PORT_PHY_QCFG_RESP_SIGNAL_MODE_MASK;
> +			switch (sig_mode) {
> +			case PORT_PHY_QCFG_RESP_SIGNAL_MODE_NRZ:
> +				signal = "(NRZ) ";
> +				break;
> +			case PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4:
> +				signal = "(PAM4 56Gbps) ";
> +				break;
> +			case PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4_112:
> +				signal = "(PAM4 112Gbps) ";
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +		netdev_info(bd->netdev, "NIC Link is Up, %u Mbps %s%s duplex, Flow control: %s\n",
> +			    speed, signal, duplex, flow_ctrl);
> +		fec = bd->link_info.fec_cfg;
> +		if (!(fec & PORT_PHY_QCFG_RESP_FEC_CFG_FEC_NONE_SUPPORTED))
> +			netdev_info(bd->netdev, "FEC autoneg %s encoding: %s\n",
> +				    (fec & BNGE_FEC_AUTONEG) ? "on" : "off",
> +				    bnge_report_fec(&bd->link_info));
> +	} else {
> +		netif_carrier_off(bd->netdev);
> +		netdev_err(bd->netdev, "NIC Link is Down\n");
> +	}
> +}
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.h b/drivers/net/ethernet/broadcom/bnge/bnge_link.h
> new file mode 100644
> index 00000000000..65da27c510b
> --- /dev/null
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.h
> @@ -0,0 +1,185 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2025 Broadcom */
> +
> +#ifndef _BNGE_LINK_H_
> +#define _BNGE_LINK_H_
> +
> +#define BNGE_PHY_AUTO_SPEEDS2_MASK	\
> +	PORT_PHY_CFG_REQ_ENABLES_AUTO_LINK_SPEEDS2_MASK
> +#define BNGE_PHY_AUTO_SPEED_MASK	\
> +	PORT_PHY_CFG_REQ_ENABLES_AUTO_LINK_SPEED_MASK
> +#define BNGE_PHY_AUTO_PAM4_SPEED_MASK	\
> +	PORT_PHY_CFG_REQ_ENABLES_AUTO_PAM4_LINK_SPEED_MASK
> +#define BNGE_PHY_FLAGS_RESTART_AUTO	\
> +	PORT_PHY_CFG_REQ_FLAGS_RESTART_AUTONEG
> +#define BNGE_PHY_FLAGS_ENA_FORCE_SPEEDS2	\
> +	PORT_PHY_CFG_REQ_ENABLES_FORCE_LINK_SPEEDS2
> +#define BNGE_PHY_FLAGS_ENA_FORCE_PM4_SPEED	\

typo should be PAM4 ?

> +	PORT_PHY_CFG_REQ_ENABLES_FORCE_PAM4_LINK_SPEED
> +
> +struct bnge_link_info {
> +	u8			phy_type;
> +	u8			media_type;
> +	u8			transceiver;
> +	u8			phy_addr;
> +	u8			phy_link_status;
> +#define BNGE_LINK_LINK		PORT_PHY_QCFG_RESP_LINK_LINK
> +	u8			phy_state;
> +#define BNGE_PHY_STATE_ENABLED		0
> +#define BNGE_PHY_STATE_DISABLED		1
> +
> +	u8			link_state;
> +#define BNGE_LINK_STATE_UNKNOWN	0
> +#define BNGE_LINK_STATE_DOWN	1
> +#define BNGE_LINK_STATE_UP	2
> +#define BNGE_LINK_IS_UP(bd)		\
> +	((bd)->link_info.link_state == BNGE_LINK_STATE_UP)
> +	u8			active_lanes;


Thanks,
Alok

