Return-Path: <netdev+bounces-225714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35829B9770F
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 22:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734EB17A745
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 20:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3099C257437;
	Tue, 23 Sep 2025 20:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aMDfm5Em";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FiouCM+b"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9890E1A9FA7
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758657698; cv=fail; b=T8NYqYyqjxeRG2mfOYYYCm26/xI42ROPZmoTSEQsnagWo5Jjf3Q4zOKBSGEZWi9jn3QTxyHGPzx1tqxN9H5/cw0JH5JiRgRCXkWg3xVm01yyGW/XozsOkFwLaNzkm3PrOQyfNSOsG5d0JU7vONrqBLN75ewwECqOaETU9Db0GhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758657698; c=relaxed/simple;
	bh=JJeUtfqypPPhk4q2mMWHRJd+D8wbmKoUSZhxdadRbSc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rioatQLhskvI1ruak+dXwp0c1Oy4RRtYc8N5dQfPM5hLZfmcnSovJzIseoya+a8jNjFpVQA+dTZFbaI61rGepsc+IN34VPfvFhbbu8d3b7dLimMuhl1bk+T9gJyiyoLAH9MWqtVvxAjgxgFGxfrCxkEEy59Ix6kr/uVK+wq1fGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aMDfm5Em; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FiouCM+b; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NJuD94030765;
	Tue, 23 Sep 2025 20:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lDJBHiBqxlhrN1D7OGrdC9LydtPNDgkMep9INTUfYvo=; b=
	aMDfm5EmjvmEMB0nHg52dqlF63BZ5ssDfdlFlgfXzdi4YJeN5g+odrB/Tv1NI4Wk
	abS7w6jauAYB/x+tMvXNb8FaKCAmEiV8OCViseYiQXsWg0yw9LupyVLKnVI0Rlxy
	J6i5QI0Ttyqk1/H78UC36cycPM4n9qf59Nt2vaR78ggTNpADrji2hfXz7bCWYubI
	05OkJ7+DU0PXzko0ZBF7zFfck+s1dP1ZCyDfwxrFiksrtoH6nVUtsfCm2jBkOk0o
	81m9gyTbTT1+207+Kd3JNGVQ/fZg6TGw1CpUHtuCjstjW5UwemS88GgFcFCBrefv
	Ac4VwIzlgt9AEzHMS5Q82w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mtt5fv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 20:01:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58NIiPm4034365;
	Tue, 23 Sep 2025 20:01:10 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49a6nk572m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 20:01:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHpVt+6842CFx6ZJjbQ8zkTzFI2HCCxqSo1LzjK+7sZtsuuzq+qHxVmImdzbeN3WkRgnjpTbuvlosVz7i4jamyFHnaIiBka5lyOb6ma/ZsPpYwHglfpSkHvjLgCJfnBrQXB7T8oqIceckfNfao5hlySXKF1reewFpKR2akQIgmZ0JBP9Ci6NkproXUomwuFY6ovelWiFS/DOgiQP5G5LnD6WYOubDTud676kNVYQl5PFfECxjEXSA6MMfLgkM5nQfXjqJZCWQVz3yo1LY5Z9Y3cm/eKhjZ9P3zgFJbxbMwdeUkxNC0xujxUT6v9gXEjFc9twaUpsDCF2ZItR1NEAAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDJBHiBqxlhrN1D7OGrdC9LydtPNDgkMep9INTUfYvo=;
 b=gT2bb49Xk40wMclEbyWGaChBI2d5RFaPYWjO3aCBXlU/pQsb7dVfOIH24IMmV2mzjK/eGljdF5FwVoiFc3duLqde41EXH7ACtzKpGE8qIQmuj2giexdLXufYAO/g+H+utXGGge+6HRwfHtPRRe2z3nVhEubACBdhzt6iCPGrQkxAEQZGpQ/Z15pHwQWAaRoOkvOiO/T9CMXSY/FQHPlJnKGrgVDIdjeIRNrYbmSdaMhplM98vOVN//Xqxk7Ml6ysfvl/kbC8AvIW/qV8Ea3TiDttfq8PDb5LwYurft3TKoqbjzNj0GemvMzqiqDJ/ygtqv7wU6qGzFXrhKrqQLsvwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDJBHiBqxlhrN1D7OGrdC9LydtPNDgkMep9INTUfYvo=;
 b=FiouCM+bF1/hTDZGAcrCcRjr1yOfhAtUVllbfcvdwzPcAnDExGyH4YJ4k9cvYQCFWB71NaTKMpNqlrC6AuQbS7b159nqnSM7sXY/SO/G4ZVAtzmLg98qrMZazxUyXp+qA8Ky30CLkujLMUWyzmBAds7sdV4ETJh8Z3ecTolwZng=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by LV3PR10MB7844.namprd10.prod.outlook.com (2603:10b6:408:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 20:01:06 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 20:01:06 +0000
Message-ID: <2c8d90d0-2926-45ed-a838-d51d270372cd@oracle.com>
Date: Wed, 24 Sep 2025 01:30:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH net-next v2 5/6] bnxt_fwctl: Add bnxt fwctl
 device
To: Pavan Chebbi <pavan.chebbi@broadcom.com>, jgg@ziepe.ca,
        michael.chan@broadcom.com
Cc: dave.jiang@intel.com, saeedm@nvidia.com, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, corbet@lwn.net, edumazet@google.com,
        gospo@broadcom.com, kuba@kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, selvin.xavier@broadcom.com,
        leon@kernel.org, kalesh-anakkur.purayil@broadcom.com
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
 <20250923095825.901529-6-pavan.chebbi@broadcom.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250923095825.901529-6-pavan.chebbi@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0168.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::11) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|LV3PR10MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba349c9-1242-4961-ae36-08ddfadbee3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXlSNENIa1ZkeEZOb0lWY1hYdU1jVU5iaXMvT1lzc3JpYXVFWmdDRWhIbDVL?=
 =?utf-8?B?RklaWlQzRnRVdUx0VTRic0N1SnBrTDFUdDFEQmduZkxNaDZVK0k0MHkvSEg3?=
 =?utf-8?B?YXdibUpsSFgrRmswbWFhNlE0Qjc3ck1uUkkvMldOVmU3RXZuUld5S3NRdmlt?=
 =?utf-8?B?dXBRbDZ6ejcwOStYelRRTzVWL01uUUUzQ3A1b0VHRUtIOFp0WXVaTDhtbkJy?=
 =?utf-8?B?THo0b1Z6Q09oc1F0ai84TjNFRTdjNzlvTzNMcXpLZEpHaTU2UnduTHNoQW4v?=
 =?utf-8?B?L3NEZitkdk1GRktNdGFBSXdsa0IweGp0RTRFbkREZmEvMHRXUUluSlcrTW9P?=
 =?utf-8?B?TExFaGlETmhJUzNjODhDZ1VodElvT2RNK092VU5QdWFoSVRReU5oUWFKVFRZ?=
 =?utf-8?B?cjE5MTZ5NkVxbVBoM041dnp6U1hTelhEQk9IZGRmcHllMkEwWXM1eGdWdnJ4?=
 =?utf-8?B?Q2lDakxWT3g3U0pmbjRRK0lMOGF3UTIrem9mc3BvSUpVQWJsZUVPZTBwTlls?=
 =?utf-8?B?OFBBZy9IYUY1TWFZMCtXaEVBSGhQWVUwcXVGSUU3ZEwzZ1pCZDI0TndlQXlQ?=
 =?utf-8?B?cDM3S1Z1OW9kak1iWE5qcDJLek5KZ1UrdzhHUVFuK1p2QnFQUUY0MG5RZ2dB?=
 =?utf-8?B?T3FXRjRIZ085Rlo1TVhJSW1lRU9SRnNKR3BaNWduOGZqMkxiYlFtVlVCUXlK?=
 =?utf-8?B?cWxTM203bWFab0I0elZMVW0rUjBaVGt1Vm1GN0IrWm0zTDcwdDFHZTAxbjVK?=
 =?utf-8?B?SzNkSXBncmNaOEZLRHp5ek5GMGNpeEduUUQ1NWppbzNNVnQyZnBZTkpLYU9z?=
 =?utf-8?B?d2NUSVU4Vnc1WUFhajBDMUFlajh0Z3dPZXJxOEpUQmxERGJTTW9ad3pIc3d5?=
 =?utf-8?B?bkdsZTFyYndlSEVCNUh1TVIyWWRhVCs3clBPYlpjMDNIc1FwcUp1OW1Ua2R6?=
 =?utf-8?B?TFkrSERoWlB1QmJKOGhzV01pQ2FPNmthaitLQnE1RDd3V3NjdUVGWnVmSmZR?=
 =?utf-8?B?anpKS0tENjhoN0Nid0xZRmM2WkJzL3cxTnRWbWFjOGZBUytMdUJwcW9WSjRX?=
 =?utf-8?B?YUFwMHFOTGxldEN4SThNYkhXMmdCdkM5NUpDTmk3R3pwMmRxa3pJeEdzUkZ0?=
 =?utf-8?B?LzgwQ1grczlsSzExWC9qYTNrRjhpbDFBVXZpWGl1OElyZ045NUR3dWtIdkNR?=
 =?utf-8?B?NXZJTGlDL2ZnSkk5TXlyc3pKNWpvalJ6akFtY1V5bUFpeEkwL2YvaTY2Zzlp?=
 =?utf-8?B?L2NyMEVyNDRSTHM3dk1NcCtpWjdvU1Q1L1J6SXNQSXBmVlh3aGM0VXdwbjNu?=
 =?utf-8?B?aG96dndxL0wzdjIxd1JFY1creFdEeWRNVUZqU3VubTd6YW92R1V2eXVCTlov?=
 =?utf-8?B?bzdXdEtQenZtbXNacnRBdThoSlFocTZlbEpsTlhBK28vSEtreGs1eWJnaTNW?=
 =?utf-8?B?NUl3NEgvdysxeHlzazdHdHZyL1NQVE5vcENzbmc2QWpuSnpkaVB1MjZKR2FG?=
 =?utf-8?B?U1c0Wk53V1pNbXZkUkNsRU56WXFQWm1mdHp1Z05HSFN1ZnVHbEQybmFWQVNK?=
 =?utf-8?B?bEU5WHJ2WDZPWVpRZ2ZrcCtoUU9BOGN3TVZXMk9yNFk1K293UmNsSkZnQ3dH?=
 =?utf-8?B?dkhKMjdobVQ3TEM5VlllRFFRRExNa20xRktOOXZ3V2tSb2VXMmdjNHlRTmJF?=
 =?utf-8?B?M3loUkU3TDFxN2ZPN2pMd1VaY2libUV6WTBsQllBU3llUHFZV1FhdmlVN05P?=
 =?utf-8?B?SHpodkRZcVQ5V0cvREpreDBVNFhxaFhyZHZRQXZ4aXJtY0dlbC8zbFRNbEEz?=
 =?utf-8?B?SXhXS0pxTHlnWmxEWVVPejdCUWttaXFkUDEwdU9NQzFDTGZDVmFRQldHMXVv?=
 =?utf-8?B?T2RtdU91N05CREJ1NnVmajRrQmg5MGhQSXJyOXEwR3NlODNBNW9MNmpZaUNn?=
 =?utf-8?Q?J/NIRVLi13Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2ZiaG44enBsR2MxQW12Y01GMnFCOEpwdUlVRDFpTTVrb0ZnMWxEL0FicWg0?=
 =?utf-8?B?dmsxRStqYTg1RzFUNHRDSnJ0VjNUUmg4TlA3L3BkUnp4VWo2QVdremRKcDJY?=
 =?utf-8?B?RDJCVlliamxETWVpZGlSaXhNeGtpckNoNFRMaDRMbVVjS2g1U2FEczFXVTFL?=
 =?utf-8?B?MTIzZmJxWTMxUlVhT3Y3V0YxMTJFUzFSZjl5eEh5NEsxNm15UGpBTks2VEln?=
 =?utf-8?B?eUNyalB3NDdCNVQ3SUhoMVA4TVZhd2NqUHorRU82VjFkRE52YWRhd1I3alJ4?=
 =?utf-8?B?K0RKTDlzdmVNNVJjN1B5Vm81Tkp6QW1SZWFnUXZ3N3lpSDhSbWcwT0JkL2RX?=
 =?utf-8?B?RnhBWnZoVmxtcGJ0ZTBMVVhHckRyUVI0WURnL2tnMVNYUHZ6L1p4dENkTFdU?=
 =?utf-8?B?MkJXcERYei83RDdFaHBRVFhHWW05OGRXcmNqVDNyYzJnbHl0eDFpRUE1aitr?=
 =?utf-8?B?TkN2TnBZK2RSTUlxamFpNmVIaGYvRE1vR2pYbGw3cHcxNytOQnkyV21pdUVV?=
 =?utf-8?B?TFlVbVdpWVJLL3NVREcvazdSeUVnUE02QUltOVNFMVJFVS9OdjMwdnhtQjE1?=
 =?utf-8?B?NEt5Tk1VMUxqZWgzNjFtcW9UV3BUM0oyWHZSem9TRHhIQzQ2YzZ5L2l4eTQy?=
 =?utf-8?B?WVVoSjFXMDNRdDdTRVRZWWZsRThwak44L28zOFIvaG41ejFDaFFrcVEvUHZY?=
 =?utf-8?B?Y2hNWjkxcWJjcE9wNDYyWVJFZWNFaEpyY1owazFvaWQyaWt5bGdEQXBWNW4y?=
 =?utf-8?B?d0hiak9CSkVmYjZWd1g4dDlyODRCQ0xvRmNQcXcvUzRiUi9WTk9vL2dHRjdt?=
 =?utf-8?B?NHBOam9FY3RMcCs5L0x4eCtQbmczblpxcGgyUFB2dXJBc0xtUXlPT296MW1L?=
 =?utf-8?B?RzR1VlFZY09wMmxtb1hteldNL2VmTFRPY3hlVlF6S2RFMHk0YkI0L0lrUUVG?=
 =?utf-8?B?MDFIbU5zWndZeE4rZUhKMmg1UDFoR1lGSDRpbUExVkpTUmZSOEFDd243bTJu?=
 =?utf-8?B?a05YWEdZbXdSSTRDTkJKYkFGTnRqWERVVGwwOHNBRmh3azBqN2pkOTZydFNt?=
 =?utf-8?B?U3ZQV2cvcmV3VnJGYWVRQnVlYkxHWERWeXJiVUw5RUx6djU2aWxNNzZrWHNz?=
 =?utf-8?B?RWJWT0tGKzhsRlZIb1dCM0pZR3FoTTdYL1NPS213RktUUldreEZLSFpGaFZz?=
 =?utf-8?B?NUlqZ05Nck9uZHI0czR0TFlMdURudThHa294TDNqRDJSbisrTFFQUVdGdEZv?=
 =?utf-8?B?Wm4zRlNYUEN1SFVtMkozcXRXNS83ZGpEc0VKeE5wK2lQQUEwL0FrSlJOWkN4?=
 =?utf-8?B?TXd1ZjVwRzZDaE80RlBPMFIwbDZMaDdXYkJ4Y0hjSjlXNUF6ZG1yZ1AyUUNk?=
 =?utf-8?B?TkhlNG1aMDhTS0kvbS9nb2xVZ3JqRVlldnIrd3VlYVg2UEZjYitGelgvZzlN?=
 =?utf-8?B?OEFuNngzYjR1czRjL1BsUVJoMXRUSUNhVVhxNkYwY0kyRUZIYzNBemRtd3hE?=
 =?utf-8?B?ZnNLbGJsbFFZckRtdWptaFJxZTNxWURJZVVZVHVWci9ZN2ZGdlVPcUEyTTlF?=
 =?utf-8?B?SlgrK0dlUWk3SlVZbTRxS3Y1b3hhTWdMR0Vyd2FnOHJTZ1FqTzhsS2o0OUpL?=
 =?utf-8?B?OU1sdzF0SFkzdm9VRk92OGkzOFFPSCtTZWl6Qld5T2NBWUw2MWJydGlndHVu?=
 =?utf-8?B?R29wOVJWK3NVTUt6aGN3WEFrVlNCbTMxUzVWVmxndWxJZTJoTk5Lc2QzNDBJ?=
 =?utf-8?B?ZHdyb3ZoV0thL21NRGZ6U2JFcTlEMXU3WTJraTJWNUxXeE1kY1BXL3VjcmRP?=
 =?utf-8?B?YmFndkhVU0NIRXZyRjd5dm5PNURzOU9JZWVVeXNYUC81WWNzNFloTDBHU2JQ?=
 =?utf-8?B?eExMRG1wNFZwMkFEajd3VURHZEdldXJ5cVNSNlI1SzExbTVtb0R2Nm1WUFJt?=
 =?utf-8?B?Vm1wQ0tJTk56ZFMzU1QzVnJ4U1dOeUd2dzJnMEZJTjhmTXFGd2dlek8ycXZI?=
 =?utf-8?B?L1VkWXgwdVN4ci8rVU52bnBSWnRoQ1ZhRUdaYXhYN2cyWHRnTGhDc0t3L3Mw?=
 =?utf-8?B?VjRqQ2VxVjlCSzVVclNmSU9MSzhsVDNiMzVnOFV5V21VMWxYcWJuOHdOcXdt?=
 =?utf-8?B?aFRNdWhZZ3VuY0tIakFuR3FWVmV5TUwxYUE1NWFCdk5CRXY2TlkxMEw3eWlo?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ogCpMoaMXjabMs0ZGOHZ4OnRTA9tq2TXtf/Do+94bK2ejGm8m/T5VM3EX7INUZ/J0XnmMRKzweNALZo3sPl+xCNdmXlsJ3OEM/R0O93sEdhRMqAT6+GV0UlPxTfFRRMAeU9sMqpRQt54R+bQBTaN9hK6ieuMGo4CLe/rtMJYHbw6WzCviuml6UTxlLoMtQXvfLYFzCoHrnmenRM68cSud32bVR63TvuEnJj/+nCcoA5RVj/xGqHD+G+rT31z+OTl2BzKWAWdw45ijxzf1DFE2n4OCw0VAtscjl1wVMkUZHavzWJELTN9aEpdnOdzadbct7ERUD2XUOw43lO9/Nkunq3CEWFV2QtG/S/2izo5N0EtgBJXqxItM4CR1QCvBKfV8MjzIumDcB/ucihAzMK5QUpW+EoC5vjux34+4HSXSxBAz/7qqWBMhpmkjW6tZjDqBaIFQceC1B4WOLAZtFPUPJEWJIHZFJH/vlNO809AGlvMMOPYHpvWl4lNvyiIrocuzpJt28tLn5S7UR75jFAm5eZP/2o9fcylU5c2Ci/8W3X+Y+ipMGuGrXiW3ezHQItxLFhZmCjOLZLpcKaCcSKhdk+etwTM6B1hJTxwZoadZLs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba349c9-1242-4961-ae36-08ddfadbee3a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 20:01:06.0456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iP55j4oxKJmNGJOfu/DybtpyC/vJzt5fp1GrpSv9M1BStuWFoqlC8OuMCRErfe2B0/AjiciSD2EcRwVABf+QP/Pz+0dAEW4UQNUgdJJadNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7844
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509230181
X-Authority-Analysis: v=2.4 cv=fd2ty1QF c=1 sm=1 tr=0 ts=68d2fc88 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=suAwacP_4s2x8PoZzdUA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13616
X-Proofpoint-ORIG-GUID: KjEyXhsIgydCKMMfeeRQgiAVA6mYMASu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNCBTYWx0ZWRfX05H3wXAQKxwa
 reLlJ3qFBmcewX12ugJonFXRT3/ZKhPOXgcGJDipZCuVXVJRcWJKRAGXcmrTavoco5bCEa/YfbL
 BPKZb2rWP4uLYYzSG8k2pdxSfE75LADgqs0UOxDPUqYUb4VCQAdzrHFM0rw4KRxXE7l75vCGUkW
 iqTb1YnJGHOh8QrCWH0yfeGSXKXknexVslx7TgANUPnq9Gi8jg2TSR+tk0WXUfCoY6ivJ6nOoWx
 3ahhvDeXBEPAZLWwmAN6kk6pYIv6D1wwK2tzKGOebALiJu/Zrpn2qUsCIgQPt8LIwZGyS8RULRk
 RrDsxXTSw7LYYX2L0A4GFu26mQGKDX09jOArOsaL4/qdlp7WiUqMefYGyJU5h0OL5jLaTLpknx2
 p9ko3VC9QpyoN+2mKtYJjAy8F+naSQ==
X-Proofpoint-GUID: KjEyXhsIgydCKMMfeeRQgiAVA6mYMASu



On 9/23/2025 3:28 PM, Pavan Chebbi wrote:
> +static int bnxt_fw_setup_input_dma(struct bnxtctl_dev *bnxt_dev,
> +				   struct device *dev,
> +				   int num_dma,
> +				   struct fwctl_dma_info_bnxt *msg,
> +				   struct bnxt_fw_msg *fw_msg)
> +{
> +	u8 i, num_allocated = 0;
> +	void *dma_ptr;
> +	int rc = 0;
> +
> +	for (i = 0; i < num_dma; i++) {

The driver caps num_dma at 10 and rejects values greater than that.
It would be clearer and more consistent to use u8 num_dma here instead 
of int.

> +		if (msg->len == 0 || msg->len > MAX_DMA_MEM_SIZE) {
> +			rc = -EINVAL;
> +			goto err;
> +		}
> +		bnxt_dev->dma_virt_addr[i] = dma_alloc_coherent(dev->parent,
> +								msg->len,
> +								&bnxt_dev->dma_addr[i],
> +								GFP_KERNEL);
> +		if (!bnxt_dev->dma_virt_addr[i]) {
> +			rc = -ENOMEM;
> +			goto err;
> +		}
> +		num

Thanks,
Alok

