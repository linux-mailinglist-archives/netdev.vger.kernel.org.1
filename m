Return-Path: <netdev+bounces-119959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05070957ABD
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B73B1C23D4D
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDEE101C4;
	Tue, 20 Aug 2024 01:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TPilCCeM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jq4sOAAQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79488DDAD
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 01:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724115999; cv=fail; b=ToHQGaABuC6ns2IQA3eYJOcpKjhzcaYavFt9145LDJRmMLrJBy2d1t/Pwuq3LzLVWblg0QEKoX9ZgQ5mgKPjuOL8f6h68/6vHFPo7DEO/pK63WPrD5KFIb3g+IneIsB4TBNOvDEewzUnpi0j6msVRG4/HMzWaGqu0Nbuelam1xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724115999; c=relaxed/simple;
	bh=oRjlp3Gshybjj6uSVWk9FsrZPeJPgAtI+TF/+MiYId4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jpERG/aE9pyCBF8tSyo8BqUSVNnePz1RMlu87t8tosJF3AwEjGOtKgI539fJHm8ZC8Ppu/VbgV2KHK+bt69MtliQr3O+7pinVOB79oV8fH/l5/WhcQtF6NwuMVanQbvrRLG5ffUj57QWgMmlFUPxZ0t86cO8W4QDcbfH/GG8euU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TPilCCeM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jq4sOAAQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JLLRR8016254;
	Tue, 20 Aug 2024 01:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=IlYzg1++i1wV4WOBQnjvXWiQxI1z/8NFNlTVjqcW4gs=; b=
	TPilCCeMbgB2AJ0iAzujvoVj94xhkavH26P/GuPVygf7bXYiimQYHyYwEARWtWLo
	nuxI1+S7+QaCPgJ3LT//EshnlnAEkNbUVsSlpmVPZe7I+DI0nXGhpbUiwKpuTdRb
	9wJgmiFJUaZ76Nr5AJWjQAgSt/gvhSlIVBISne81rKVRjvNIH/8eP6yFiTcqFCY9
	KyCHB4j1bIpLjZ8K8/VmgalEr6pKZTYUEIzwKPzaIz9aD/haBXcu3UgN9wlYre0L
	Eh+bIAwD8/RTHJZZ3SCkwtTVXcagAtkBoNkj2pE7yO/glEAB/HZDKdK4IjE5iPS8
	ZRqK+rN6f/Wjc1APAbK1tQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6gbw33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 01:06:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47K0xHxQ009661;
	Tue, 20 Aug 2024 01:06:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 414h36g6gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 01:06:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOiSFhTNwK1WCpbQRSSUQtse4mMI9dhi9b6rYEx3KZPVUPzCsGa4K6lWDolVBERps61JzKvC1B5ge3o4b8/xy3uBJ4I57jgfKeLaqRfyB1B3DzOoPGflTPdvrl1RapIcKX2JztoXmMqt3Mc/tK93s1ZQ9ecG1XweyLPqRKcB0YaaSDDJDKvXKtDjqzeDMOkXh0ltj+Nb0Z5UaD728TYnpVFIHNQI0OXuYjXqS0qRyRxSYZ0o6dPHedTwvl3I5bxKb2g7ylNiUYy22rnOIVryrRqUbf0ka6eAG6l00jaMtoXHuylpUbDS3AwebNSQc2Ut5jDnJMdmx6h4fuBVI5BoJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlYzg1++i1wV4WOBQnjvXWiQxI1z/8NFNlTVjqcW4gs=;
 b=TCb4CSgQt6D8Ex/xWxGZyUUWivJ1JeA8wXwUVkvRVolHHC79rm/TL9rOKSDmY8YiZbChcyoAoHmftWI2GbTdm4mZpbzeNkJSm3N7sH3ezywhS/1cw33lc8YYoYQ2iWP/aksDm43Y+faS8CkZTc1rbD8xI6dzKMYG7xk+LowyejgqXzS5q9Qtzn6PofmR/27zEHHhbLK3TbreCM/8gbfjxulE6U0/qNuJcjy0bEbsvIdZZXACTI0gs5/1DC5zbCXyZSWlghsZZYo93TdUJ3ixj3/Mlmk9nwsNZfKFZc8TtUrVcOZcB7rHnyJWQ6fgw+G14I4kPcesE5MpeHw/1S5Aaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlYzg1++i1wV4WOBQnjvXWiQxI1z/8NFNlTVjqcW4gs=;
 b=Jq4sOAAQyH2oL1XXZE2Nndb3KsENFSLblNu3aLfftXuJMVn2t66uBB0bjbdUf+ouC1hI1+0hlNxcJu9u34vkbsehT+7vDDXuq6AG8nOxCFkAsvxNvYBKTtWrgL+ucQscFu/duto6LKMRvToWoGKZnaGenbg8vVari27RtB0yYA0=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH0PR10MB5003.namprd10.prod.outlook.com (2603:10b6:610:ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 01:06:14 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 01:06:12 +0000
Message-ID: <b4b3df48-d0c9-df99-5c47-7b193a5f70fd@oracle.com>
Date: Mon, 19 Aug 2024 18:06:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v5 1/4] virtio_ring: enable premapped mode
 whatever use_dma_api
Content-Language: en-US
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        virtualization@lists.linux.dev, Darren Kenny <darren.kenny@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>
References: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
 <20240511031404.30903-2-xuanzhuo@linux.alibaba.com>
 <8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com>
 <1723900832.273505-1-xuanzhuo@linux.alibaba.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1723900832.273505-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:23a::19) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH0PR10MB5003:EE_
X-MS-Office365-Filtering-Correlation-Id: 819a7ba7-43e1-4fe6-fe19-08dcc0b4484c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnBPSHF0ckJGdVFzcC9WMGJka2syREFtaGxKYWwyemE0YU1WeW1NZFNOR0c5?=
 =?utf-8?B?U09kbmJvOFJoaTVNaVlsbXZZMkhlQTlvUEtlZGI4YURKT0tSYzVmV0wxa2dm?=
 =?utf-8?B?MGo0Z21nWFNCbWdsK1AySWU1VGkyeXVJd21EQksrYVlRNkc3ZW4yWVlFWTR3?=
 =?utf-8?B?S3hoUWI2KzdndXBOcnowRU90SUtLaW1FLy9IUGo5TC9PaVE4byt4Q0tEcmo0?=
 =?utf-8?B?ZVR4eHR4WUNRSVpCNGhhNkZwUkYvM0JHNXp5Mk10RU10aGFPM3JkTWFweTBP?=
 =?utf-8?B?TGdWb3doZ2Ntc1c5eG85TFRJSUJ4Z2xQblZxTTYxVXpDZmZudWF0UkJZTEc3?=
 =?utf-8?B?OXBNcXFhV3Z3ajNDUElnMkw3WXdoOS9UKytGVFBhRFJRRU53ckorT1ZvcmRl?=
 =?utf-8?B?Ry96cE5pK2RxN1lSOEVPU1pncGZxTnFrdGRrWGpKdUUveVMzeGlMTVhPdjMz?=
 =?utf-8?B?KzNHN0FySmxEaFFGUHBoMEdmSVVyOHpJRTNMcU41ODdjYXdzZVo5dC8rMy9z?=
 =?utf-8?B?OU5udTVVckVHSVkzMGN4OVVsVzNLaFNTYTFpdEcxOEhwdGYxaTh3YkRIajln?=
 =?utf-8?B?elVTWUg3WWluaXB0aTl5WlZGL1JuTXA1NVh0YWJIWmRNSXR2SU5aR0FpVVpv?=
 =?utf-8?B?czJua2Z2WkxUQVRTOU1vU1pPRjA4NmpTL01CclpCc2h4cmNLYmoreDN3ajdU?=
 =?utf-8?B?VjF4N29TYk90Nm5yeFFaWEMrblNuY2YxdEhaY2lkZS9WMFNHa1BvMDN2QUgv?=
 =?utf-8?B?NnNleVdoeGtuVW5CZkwvaVRKcW56SktBdU5kWkNzYSswVnhUWWtjRThEODN1?=
 =?utf-8?B?TXlQTytGZWRoMUMzR1UwbDl2OEowM2F4L042MkxzWFFFemV4NTdVem9kM0U2?=
 =?utf-8?B?ejFRc3EwNjhWdjdCdXlCVXh6dFBVNHY0NWJsejE5WUNKZFhWcjdXenBJMGV5?=
 =?utf-8?B?dG9wZHJEL1I2T0d2cUZiL0hEWkVCTnJwNm1hR1NxdHRoM05OK2V3UGZUL1Y2?=
 =?utf-8?B?VGowSHNqazB1ekNUUVlkOTU4a2tvRWtFQkpNaVRsbjRXdVo2THVacHdGOVlj?=
 =?utf-8?B?Tm1hcklmdzJyYTV3dUkyZjdFUlhpNTRVY0Y1UGhlUnFvTXVBMWgyTnF2eDFk?=
 =?utf-8?B?RVR0UnNZdFl1NlFELzlJakR6MTU2bVVjeWczTllPOGUvazhRcmsxeStPN2o1?=
 =?utf-8?B?KzRTNzlQOTd0WXk0RHhEMjRTY2lwVS9KN3Q5M0tzQlBwNUhDNGtwY1pQeU5x?=
 =?utf-8?B?cGxRWGFjZzhDN0w0T3Z2Y1d0TlR2SmhwTkJCQXpzc0VQUmY5NXlKRXg3TElv?=
 =?utf-8?B?cnEvbEozVjY1VnpnYS8rVjJqTmhha09ZQzFBR3pGMVlPeklyVHkzMnlDejJv?=
 =?utf-8?B?d3hEUEhOWFFoMjY4Q2gycnQ2bk5RWWRwNGE0aHdzS0lZcldmMm15Ni92WS96?=
 =?utf-8?B?Z1VTUlYwODM1b3Bzb3pkLzEvWDR3NlhuNncyK3puVUYwNG90a21teVhIS3ZJ?=
 =?utf-8?B?NG9mNmZ1MVZDYzRHMXBUT1hPREpOYng1K0QrZ09wOHBvcmRoNCtkcFlrM0lp?=
 =?utf-8?B?cGpvSkZJREJpbGVDemdpME1tbkh0UlRJcHdacVRSOWJvRHdiUUxRZHAxV1My?=
 =?utf-8?B?bTRwQnlxeHAvVFZRM21sNmlJV3M1dzlWR0pKbk9vVXNTMFYvdmF1YWtaalF1?=
 =?utf-8?B?VjlNUHdqL3hDZ2tzRzBCdUt5djNFMm1UeFM5TXV5UFEyOW45OFNNMHozWTBa?=
 =?utf-8?B?bjJkci80SzlmUEkyL1VTWXZ6MTYwN29lZXlYbGx2UWFvNVNyQmkxVUN5RFhw?=
 =?utf-8?B?WkpEY08rVlJCYzJvbndiQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXFnajFxcDVHRmRpVUlQV1ZPMFFDMmpQTkdFeFdPQVo4T3lGckpDQWlFaUMx?=
 =?utf-8?B?NlkyTnNoU3hLZ3VMR1lnS1RYRFo5bldvMjFoL1BGdmZMOXhlRU91bkR5SVZB?=
 =?utf-8?B?bmpWN25LY3ZacHNtUmI1TEcvNGJ0VTRtK0Z3WGhmSXB5TFJNMlVZSmhFWTV4?=
 =?utf-8?B?YWZPMHRlTWZiUEdVeTl2blU2Z3d2eWNsTkYwWW0rcE9nWjA2V3dZdEV4WWww?=
 =?utf-8?B?VFQ0OHZ5TmtVMDhRcVpWc3djS3FhQndZNGRhVEIyVysvVjVJTnNjM1VUQU83?=
 =?utf-8?B?bTZ0TVRQRlZMOEg2QVc3VmppeDJmam1UdDRod3pCRjdrOHdWekJ2WXV0Z3Fi?=
 =?utf-8?B?SkRIaERMeVFWNEhvL2dZSjVhbk1ic0F5VEdWYnNwSTBqcGgwZHoweE9KNHNt?=
 =?utf-8?B?cUpIaGlpVHVwQW1UTnpYeFlweVE4TWR0NjZwaXFmMjFvYmJ0Nmgwc0NMTTlM?=
 =?utf-8?B?eWtBSVdiNTZ4bTUvY1dxdldSWXV2ZXRCMmdUalExUStMU3o0NlNIWDN2UTZJ?=
 =?utf-8?B?OWRnU1VLTkFHK3dTcmFJRkpjbmM2Vll0TWQzRUwzbGZESWh2b3F6cGVrUkZh?=
 =?utf-8?B?NHUyc1RRSmZac3FKcmxxQVJzT1R4bzg4ZFR1bzU3UFZuZDh6YXZpUVdJRnM4?=
 =?utf-8?B?WEZSTWt1YWgzd1JwekRkT0twMHRwazVsTm9OeVlEcnFrd2pMekppUWIrcStq?=
 =?utf-8?B?U25UQUJIRzEybjVZclI2d29ZcGwrTWdyeVBreXA5UkVMcGtDL0NWRXlvd2Vu?=
 =?utf-8?B?NzhFUFBuRUt6WjAvcjJKU0daSytSS2pNUGM0UVBvV2NZRC92RWFsaGl0d3lL?=
 =?utf-8?B?bVlVRmhJcHdSUVR5RjJldm9DSFdoaUtzeWJOT25KbDFUUVllZkFOa1dLNlFK?=
 =?utf-8?B?RmRydm52Q1NXNS9yTDNJWkR3VkxwUndKZ3hCNFBvN0IvSklpeUVvSmYxQi9C?=
 =?utf-8?B?Mnd4QnJieTQwSjFhQ0VTVFZYaWVNT2dNc1VpZ0lFNGM5UmFTcjZoMktkb0pa?=
 =?utf-8?B?ZDUxZUhiQjVqczFqZlhDVjhFMmIrZXZncFNhZjhvZURkRlBzZzNBei9SVmYr?=
 =?utf-8?B?Y1Q1VlVxbTBTczJLOXlwSnhNRlZlYzZyV24xSmpuNml2d1hyZVJXL1BwejRM?=
 =?utf-8?B?eElpdE8vTm94VUdnVjVPcnRJd2drNytFMnVVWkRrSlJuTzBlNUVoNUJQaXpu?=
 =?utf-8?B?TlFQbjZIQk1mT0pkeDU1cVV1U0FhSHNsK2lOdkJVWktOcTVHREJlNlJkM2ZK?=
 =?utf-8?B?dGdXSFFVQlowNlZCUTFMMEtpTFNpbnNHbkhRVDFFdVR6eGRJd01GTU5rSndE?=
 =?utf-8?B?MnNZYzgzN2dtOEJ4N3hRNHNQQkZBbHFPY051RitWNG5hR2N2NG05eWlibzh2?=
 =?utf-8?B?cWZ3VktRVEs5ODUreWlON1Z0Zzd2LzZMV2ZiNW5WdkF3UVBFdGQ0ZzFGTjg0?=
 =?utf-8?B?b29GN3pDWkQ3bXY4empZUDlReTQxRXJIY2ptTVJYOEtLdkhmMW5Vak9FQVJa?=
 =?utf-8?B?OFZGbjRXMC96WmVsV2VRdVgxbXg3RkhmRy9rY0hya2JKQXlYZGphQWtzNWtR?=
 =?utf-8?B?VnhaVlkyR0RpdW8yeE1rN3lkZTlyM3pTdGw1TXIyUDlhZzE2NHNYSktSTStx?=
 =?utf-8?B?VTFNRkxiUHR2N1JseXdMUWQvRjRFM0VIR0R5UjlqbDRwbmFDN0h4a1RFK1Jh?=
 =?utf-8?B?ZjRmSXBUbG5aVkJ6dmFGUVluVm4wTDhsczVORWYwQkdOOGYraWFZajRBMmpW?=
 =?utf-8?B?eXQvVGJHdGFscWRJbVFhRDBtYmNDNTAvc2FUZEc4UWFoSEd1dWhTbEdjRjNO?=
 =?utf-8?B?YUpRVHdGR3dLQ2xwUUVCV2xwVlBjS2hoV2tNZWs0MlU0dFQveGdDbFpad3pD?=
 =?utf-8?B?MHduaTJmdEFPYWdpV0NVZzNiaXRGTmV0K3VzV1Fwa0U5YzNRZ2NCeDd5TVJE?=
 =?utf-8?B?dkh6N1d5bWhkQTZJR01YdDhQdkFyRTkrSGp5TG9aa3ZoYWM5cGtBWmNPVHo4?=
 =?utf-8?B?VmlmR3Q5SkhvZUMxcFNUM29wQnlwQVp4L00wRmJnL1c2OC9PUU9EMjRXSGVn?=
 =?utf-8?B?MzNQY2JXS1RoS1NiWkQzZ1BVcEp2RGZpb1k5TW5KN1ZsTDI0Y3p3dHdqQnpy?=
 =?utf-8?Q?RnBB/980kPlDUKDIZ4e2HlZVV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TntnA9WoWaGqPuNatatOz6W/Kz1sd4j8si/riRIW4gKoOD+kcdZVAIbzY4sCT4bdDSH9FgRI0pkkVEfr47muRAPzw7jl1RgvtKy42eucacGSDAKB9YCPLk67hQnWOAYSeRPHWCunM6CRYwLX2eM4dD3G83OPUvvP3ibNME/hsP+/Z4Yvdllopsrh8MrQYzzq/Ihz1qYagNUf2KaQCYza6HcUGqrEGKilZ1XXfbGTaeZYieIFU7iPyjqLR6xarbHw0+ogUWIT5TykfYU6TtF56F3lq4EsperZGfBrdm6v3vVg1w3hQkiST/UkQ0EDJQs4al+HyHlGUrnKz+xPIvl7JKMwWDf/OS9Q0RlG8B1oqbKNkOZbRamp8Seq2Mszw+s/A5SXkSfqv5GK8K/igJ9DxmwtI8ElS4yoS5bzwHOJWzJsaMHIBAbgWNQN8IH7l+n0eznsYV2XzoSh1EKt176Gpv1MwNIfW3j27ODP3MwThOb9LvzeQXJfoYdP1mGo+VmjKZ15vpLn9ZYG75Du6zRmevgpUnQHUOTfxXHHRaMXe5FtDrLfwq6cjgz82KtPMXBPN3Wg9Kz3/2BUeSmfWohomiFlhLXIADwNw/1K4X48pr8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819a7ba7-43e1-4fe6-fe19-08dcc0b4484c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 01:06:12.0975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYTa4omV7CMta8/dMOBqkiiqQEdHqqV00A4GoYnE92a1UV0NGGXnRb2nfSdA5YLWAWGEIL2lbxIfdstoAQf4AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5003
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408200007
X-Proofpoint-ORIG-GUID: Sb4QYbuxVSdFkipF99tcchB4A4zcbCXY
X-Proofpoint-GUID: Sb4QYbuxVSdFkipF99tcchB4A4zcbCXY

Hi,

May I know if this is really an intended fix to post officially, or just 
a workaround/probe to make the offset in page_frag happy when 
net_high_order_alloc_disable is true? In case it's the former, even 
though this could fix the issue, I would assume clamping to a smaller 
page_frag than a regular page size for every buffer may have certain 
performance regression for the merge-able buffer case? Can you justify 
the performance impact with some benchmark runs with larger MTU and 
merge-able rx buffers to prove the regression is negligible? You would 
need to compare against where you don't have the inadvertent 
virtnet_rq_dma cost on any page i.e. getting all 4 patches of this 
series reverted. Both tests with net_high_order_alloc_disable set to on 
and off are needed.

Thanks,
-Siwei

On 8/17/2024 6:20 AM, Xuan Zhuo wrote:
> Hi, guys, I have a fix patch for this.
> Could anybody test it?
>
> Thanks.
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index af474cc191d0..426d68c2d01d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2492,13 +2492,15 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
>   {
>          struct virtnet_info *vi = rq->vq->vdev->priv;
>          const size_t hdr_len = vi->hdr_len;
> -       unsigned int len;
> +       unsigned int len, max_len;
> +
> +       max_len = PAGE_SIZE - ALIGN(sizeof(struct virtnet_rq_dma), L1_CACHE_BYTES);
>
>          if (room)
> -               return PAGE_SIZE - room;
> +               return max_len - room;
>
>          len = hdr_len + clamp_t(unsigned int, ewma_pkt_len_read(avg_pkt_len),
> -                               rq->min_buf_len, PAGE_SIZE - hdr_len);
> +                               rq->min_buf_len, max_len - hdr_len);
>
>          return ALIGN(len, L1_CACHE_BYTES);
>   }


