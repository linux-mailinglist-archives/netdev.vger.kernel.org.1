Return-Path: <netdev+bounces-229434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5949BDC1CA
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 04:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB5B19A2999
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 02:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA263090EC;
	Wed, 15 Oct 2025 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="belzWaZG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Efe1E0Xx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D143081D1
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 02:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760494161; cv=fail; b=qVP52vsbPyO0fmkfx4hxlOR0gtWwI5jNaL0iWcc40X16ZP8xNLGNN2+0EZDupa/9080XDiU1BrwSzjkHCdBINuh+cAcMtIzBgM1fM9TY+j1ebcQyAv0nSM/DrxLGznzbeJrugSzUpwSq8lljK3nZqpQpSnnOmGcSKcHsYg5NOOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760494161; c=relaxed/simple;
	bh=2cooZGV9zPL7Bjafg+l19/gvStzE8CErvS4wdTPer/M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZCjrVkhMqHq5FZjpkkVlB0JlqZ5IvZ8KthuLOkCfzOXFTf9ow0DVbMvskspLBsLDg4zmOSmS1eyDpNISXbbAGkXhwq0MnqRtqsxJBAbzIBvyAFN33d0N53TD187JbJL9czsDApdWare3hBQyAR7eLNgEuGP56xN/QXBSaQoQaxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=belzWaZG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Efe1E0Xx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F1uWg4011536;
	Wed, 15 Oct 2025 02:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3noGHW63Z3ItHrdBFks3XtxziwL1Lg3W22uB9JqDe7g=; b=
	belzWaZGXpG84+/9lPD6xhIKqWxATd9E4xtjHlc6qWQKLcmLtARAk4sguEp0oR46
	BlM9GnOZTSBG991aQL1D+xJvPp9ZJn/pjAvZ8qB9HGULbqXD8fAlyYvQIbX3MvTo
	SqWPSkUtkx8vmVnquu4vnD8pPzCaak2ExehCnMj/dwXlojkCImbYTSKlMqQL19zc
	o77pizQEpJgY7eBvprgL2hYIHSlH1TecSTocZkL0NlD2FWUum1r0AU/ccnXMvvHd
	ryK591DM0BEUtGTZ/lw3AfP8YySOG56R5KB7dnEQu4yEi/94jRGT8mru9rfQRCNJ
	RV/c+hXDuYa0umT7oKwaGQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qeuswjjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 02:08:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59F10Xb8037860;
	Wed, 15 Oct 2025 02:08:58 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpfr3u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 02:08:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6AzVVfKJzdOdVYWvoAHZnQPD58PeJ2sv1sXPpXllxQ3ulylfhC5HatABypVcxU8GJI11URWDcCEyXHbL7TCgxxzPDcaC1sm40AMa5KLrIBCGfOKFC2T6NaATFWJ9N4TsGZXKIJ4o/jaGJnKVZYnNi2ur5TxfrMChfFWD5TD6VzSY6r/Opd09aaMFWWQCwoEq40gXaSe7iT81wJd3cOfO4QpbYDPAqkbbMs9UXDu5AZoj2i/7zzUbdTuw02ZoieM4lGLzpIu3J6EAuAtDLeTsHz7ou6QkUgWxJEZz01qA7CCSpnHy6bbfmWGpdOI+MEyKO+9UbDx4vGr8LLe1oTmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3noGHW63Z3ItHrdBFks3XtxziwL1Lg3W22uB9JqDe7g=;
 b=j1VwvWRPldDrV8IsEa5cVbnHXuKR/Ik9r9Qj9IHrxzBD8RuOUAq67FuUbZAOjeJtr4PfywUy1Aky0T8+KMtA/c6nfhRRvhnJinkpgP/3Mc7ldDWeE4bg35ozQ0e/Uajya1KFpMgfxxVDGJHfr6e5Mvw70wBb8tfHmgymAO/Yd9ExUgS7tuYR1q0975tDH5F1vm57tNUBwyyxPVlUho3j9ycas/BWMR0FMCXBxC0VWRq8+tSWbwbpQEGGbPFXs0LsV8BFlTm5/6NBMPsSkpbSiVpNTjAslD6WEIc3llrCYGo8QZ18nBgG3JTvMoJE7dcujZjWuAikTxFy+Rd3XMu6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3noGHW63Z3ItHrdBFks3XtxziwL1Lg3W22uB9JqDe7g=;
 b=Efe1E0XxxK3IPO5SJkoeB8KBYgYHzJvasm4yddkdUscaAcIVN2m35YYhcWJb3mGdOSNwo5WPdXpoCibWYa1/TNZoH9z/Dn+fw8z1TToUSM7It7JmKLshocElmqkVZHuDfa3MHFNq1DKfrH2jtk8cPeeA5NWID6wbcvrlz8VpFMo=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CH2PR10MB4344.namprd10.prod.outlook.com (2603:10b6:610:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 02:08:55 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 02:08:55 +0000
Message-ID: <a9d7e2d5-7389-44af-b139-8f630a9bc226@oracle.com>
Date: Wed, 15 Oct 2025 07:38:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH net] net: amd-xgbe: use EOPNOTSUPP
 instead of ENOTSUPP in xgbe_phy_mii_read_c45
To: Simon Horman <horms@kernel.org>
Cc: Shyam-sundar.S-k@amd.com, kuba@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux@armlinux.org.uk, netdev@vger.kernel.org
References: <20251013171933.777061-1-alok.a.tiwari@oracle.com>
 <aO4x_fD_g3nMjYnZ@horms.kernel.org>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <aO4x_fD_g3nMjYnZ@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0070.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::9) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CH2PR10MB4344:EE_
X-MS-Office365-Filtering-Correlation-Id: 132a7453-5437-4a4d-c053-08de0b8fcb5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjBySm9rSlo5eVB4UzI0ckRCMjA1TEZHbWl2MnlhSmdnSURjUGdXWWJUR1pZ?=
 =?utf-8?B?YjhLVVFGVm0yZWZNQzNOK0prOTl6QmRuMzRGcHNSajJNNEVzY2oxazVTYTJU?=
 =?utf-8?B?ZXB3a1ZmeERrbERQV0ZWNGp0K1U4Rkd1T3dQRDRrTi9LUkZRT0VQNDJONDhk?=
 =?utf-8?B?ZG5SenpLL1hvSFZvYVFlVWtyYzBNaUdSY3U3VXV0dGZLdEhBQ2FXaUZJQURN?=
 =?utf-8?B?eVBUbS9FZFg0M003M3BaSTBLWDZJRFZOV1hFS0FWVkttRzNWa2tDc2o0QVJj?=
 =?utf-8?B?UzZ5dFlwV3FHaEdBSUU3UmhydVRyVGwzamlBdkI4dWQ2dGNLcFN4VEpuM1ZI?=
 =?utf-8?B?ME1Dam12ODU0dUc5ZGtscC8rdjlSUjBmTmVxTFB3aUR0S2s5WUtBOWR6TlBF?=
 =?utf-8?B?T0ZKeTgzdXRCdnJhUG9IVXlydk5oa0liNmRyODlmUWl1RGZ3U3l5dS96NXZu?=
 =?utf-8?B?eFlZUFNwY0ZwYUlrcmVNNTFvY3hCSWlzNkVtUXlnd1BNQjhMMnhQZmw5eGZY?=
 =?utf-8?B?TE5QcXJYM3NKRHZ0QUViK0hwdjRkYlVjeHd0b2cxYmhUM29kYmNFbnRISEFM?=
 =?utf-8?B?YnJsVk5CNXdkdDBNSVpRTFdtd1M1akpLTWErRnY3T0VwUFIxVWZFSGlCeEd0?=
 =?utf-8?B?YkxBUlQ5dUtrTkZsZm9IMWowWFlHazZFODlCZmk1ejhicWVFT1dwMEpyVE9n?=
 =?utf-8?B?aXJNQWRsTkcyZExRTFpUYlArQ3FUSGZUSGU4NldVS281SVNGZ2E4SlRFUWZu?=
 =?utf-8?B?UXZDVTNDRUdCRUtqYkZBTXJ3Sy8xaEpvSVhjclIzbktGWnRlQ1dCV3Z2QWYr?=
 =?utf-8?B?b2U3RG9aRjN1ZkRjMDJrdDZwaFNrRUY2VTdSbDJIZWhxQnZHMDdUVytvOUg3?=
 =?utf-8?B?RDVqRDY5UWtoMEUvUU83RVpONzRSZ01LRHFhMFBNdjl2Z0tmTHBNdVY1Wmd0?=
 =?utf-8?B?ZkNHSG8zYUkyWno3U1VJZ3JsZjRuUGFtTHA4R2FSZnlKQVZYVnRJOGsvNFZR?=
 =?utf-8?B?bTk1WFl6RURRUGxma1pXdDlYZTFHY3ZyVmhBUUxMSWhYWXAxcXExRmJjSVlE?=
 =?utf-8?B?a1lDL050YXQ0MWJvVkV6TGxhSjNLMmhWUGxmWTBubkF2YkZ2NWpkZS9wV2lW?=
 =?utf-8?B?bzFra3gzK0hkVlhmVUZYUk9McnJWOWJUMHV3QkVMZnpmVmRQNDc1MFNGazdE?=
 =?utf-8?B?c3ZMY3hYdzJQMTBrKzBOck8zbWZPbmJRTUcrcFYvMUl4MEJOOW44b2tkQXI3?=
 =?utf-8?B?YkZ1SHRXK2JpQkU0YWhRems1Y1VaM0dySldJRVJ2M2VteTYyc25SaW5MRG1u?=
 =?utf-8?B?bXZscGkyeUJCMTVCR1JUWHZCNDkyeExRbmRVZ0owbXFWd0dyMVF5YWlZR0Nh?=
 =?utf-8?B?ZlN2ZXlEUkhsY2h1YURjcHJtcHpRcG84T1EycUFsdlFJYXd1dUtYSjlOdkEy?=
 =?utf-8?B?ZEo5VHRncTh4cTB0cUMrUE11T0lDQmUwNFB2THRnaDRQTVVHWnRvUjdtNGp1?=
 =?utf-8?B?UFBMRnN0VlVVZTR1QTg3UjVqVXR6K0pBdHpQekRiaXcvSWU4OGJ3QzNHVTBm?=
 =?utf-8?B?dGlDd0JtRThsOU9EK0xhN24vV0VPUXFFbWZwOU9LMStEa1pvUmNjWHlDNW5w?=
 =?utf-8?B?dVVCSUIwL3Zvakl2NzlNTTB5Y2lyM2dCUTJNQU5GVVVnbTZjYzZvZnFKYStu?=
 =?utf-8?B?c01KNlJLTDA3SUFFRUZRUmJaT0xEV3RDbnVkcWoyVHdpVkhKL3ZxazFSczMy?=
 =?utf-8?B?L2t5QXRsS2lwbGlSQlR4TkdHeGROWHhaOTM1K3RTRlBDV1Znd1RYOWJicnVk?=
 =?utf-8?B?dW1qei9jaWlpRUhKcTFMcDVyZGNyNnZtZzVwNDl3OTRCMjFsd09zV1A2WUR0?=
 =?utf-8?B?akUwblVlVElYUUZHVjNIQUUwTWxML0FtRGZTQTVJcXBLdkRBMjIvTStaQksr?=
 =?utf-8?Q?GJioRH/2gkpw11W2DObQwpb0oSBJrEHw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nmx4K3hIdWs1YmpZK2Q0MTJGSHk0Y1h4czVGdDd1SDA5OEQ4ZkxIaFBTV2xO?=
 =?utf-8?B?Y2dKcnB5UDk2b0dHbnYxazczTkJWMHlsd0pvNExodkdiSFhvVm9XSzlDeGFN?=
 =?utf-8?B?ODl0MEpmZk1OdGxjQ01PQnlvdm5LY2xoSVBSWG4vejlVbGxUVXB6QktUeVZo?=
 =?utf-8?B?SjdtWXVoSm12alFPYkREVlI2dUc3c3JiSG9XTkVmMDdRZXdGdFc0NEpyVXRh?=
 =?utf-8?B?czhNdXNJTmRJNnNWQkprUmlRVXh6SmN5dEMvZWF3SGJlZmNnRnFuRHJOMHdJ?=
 =?utf-8?B?QzFFVFg5dUNqYWdtcU9BRmFBZWJycHJHdndFYTRXSm5aY0hOZUdweSttV0pK?=
 =?utf-8?B?Sm15ZkduK0V5Vks4YkN2WjNVWllpOXZrZzYra1hkWjVYbFhHRDh4QmFNeWxY?=
 =?utf-8?B?U2FJVjl3N21WeHdEM1M4Y2U5dG1GOThhNFJkU2pIVUJBNmpYOVdNc1p4SGlR?=
 =?utf-8?B?dnlPRlI4enNSNUVyWnNuRHdCdXljeUFOcnBVT3B1YlRFcGlqT1FZcDFCNzd1?=
 =?utf-8?B?YXNMOHNXc0czZ0gzd0hPOENiUmcwS3Z0dVNqZjlhQ2d3VWdvdFNiTkJ1a3RU?=
 =?utf-8?B?UXZuQnFOVVNuT0FGK3Z0akRjQU5vZ3g4WnhuNEtqMUFFU0JtNUNKZXBXYmph?=
 =?utf-8?B?OEdhR2hUbU40SVVET3cxY0tRS21INmRCZUx2ZG9haE1tSUlSa21kcEl1MDJO?=
 =?utf-8?B?NU1WMDB2eTZpbjE0UGI0d3JhK1c3L3hLN09KVDI5Qy93UDRRWEdZZXhJQnAv?=
 =?utf-8?B?L3E0WjFkbFRuQXlHbXRuVHV6d2xXbDhNdnpTNFVCZFpGM3owa2x1Tk5nYjY5?=
 =?utf-8?B?VURkZkg0UFdLYW56WW5LTDNwSXE1emZNZ2FSZXhpa1UvMHpFMTU2YnBsalht?=
 =?utf-8?B?emloREtkL29abDQyUVFyZ1ZyamRpM2JFMEVuejdGZVFpU0wxWTBRTnJIZWdO?=
 =?utf-8?B?aHB1NHhMRDlZbEFhUlNaYnNZTkJNWkQyM1VMNTQzZkVFSEVoSE9VYW9yN2Ry?=
 =?utf-8?B?cEthRURxT1l2L0ZjbFIrYU51S2d1YkZKek5NR3JIQnFkTGRFdzlKMGV2enJh?=
 =?utf-8?B?WFdzQ0hkdGtpK0tIV2FYSnIyL3RVd1JCYTR2WUQrWGphZ3RUOVBJWkhjRUFk?=
 =?utf-8?B?STdtWFRxNnowNXZkYm1FOFM2VmhrMUF5VFo4aEpTckNodU5ZM0R3d3k0aHEy?=
 =?utf-8?B?UGJUYWZyMkU1YWVpTjN1eWFKZm9LeHozTnQzdS9NT29HSTZGVmpWZk1yN1FT?=
 =?utf-8?B?c0xoZEFVaVB3YjZQT090dTRDSjhvdDBuSDV2QWJNUkUrL1NIU1Z4ZFd4dGYx?=
 =?utf-8?B?cml4WnlPN3g3M2JZcXNPVGNkdHlBeUdGSENCYnlKRi9URGJZNjVTQys5d0I0?=
 =?utf-8?B?OFh5cURmejkwSER3Y2FrUTNsaDRuOThEMjlxTzk5UkhzQ0hHZkJRUkZCV0dx?=
 =?utf-8?B?Ykhuc3kzU0o2TGNuWC84RHpnOWFMMjBiemJEa2pMdDcvZlV6bS9GTU10c0NN?=
 =?utf-8?B?MUVyY0w1QTBoZURtQTY1ZXBnNTZ6VVh0T29UZ2dYSHZocjFqd3Z6UGdCbExh?=
 =?utf-8?B?elVyQ1RvaEZhQzZzclFlcVQ3OElWRVQwOHJYY0lBekZTSHh4N0gyRFpFZXM1?=
 =?utf-8?B?L1F6bjcxWE9tQjZjN3lZVXJscWFoNk5waTVSSlhYVHpYcmpNNDUrelh3TDIy?=
 =?utf-8?B?M0tYMk1WTUc4MnZZeG14V2h5ZFJOYkErWWRPa1BkNjlqTGlYNHBqeXkzMVc4?=
 =?utf-8?B?WjJGU2RzeXNSYStTN0o3cE5GR2NMOUcwVWJER2RKa2tSMFdaWldqWVFPejhv?=
 =?utf-8?B?Zi9YbnJQTlJaNmN5TW5ETGMwczN0alpveTRvcTNuQW9xMXUxZ3poRWRLcHRO?=
 =?utf-8?B?Y2tVWEFic1p2UWNDN1lDOTN4YzNUa3poZU05L0JYc1pCd3FiSTEyTVJJVHpV?=
 =?utf-8?B?cHJ6SXRZL2FIWXE3eTFkODlWQkNURGZsS1FDczZNbGFLNCtQN21qdlFsVC9V?=
 =?utf-8?B?dTZNcERpZEVtNGZ4ZitnTHRIS2EyblpqYXNYd0NqVWhmUnBocG9DMnpGVWNt?=
 =?utf-8?B?eGY3VDBWRGlEVjRVZ0V3Q3NIRTdIb3hWTnlYZFVVVmk4NFgySHR3TzhTKzZL?=
 =?utf-8?B?cEdWTGxBbGpvVHphanRSWlhXWUU1MmRMbjFxSzhlR0F4bHkrdmpIUi9yYThB?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hNTvN2ZbeX6tV6BAxOqN+qWYdBfwBOCkdIo/KFJlsH0husHMBzNC//mMzqqONNYYxJO3dzfAq/kAvdO9iYpDUZPM1ATuULr874T92vfLkgffT5OueHJBb+bE+kdYftxsMLOOJ9HkkqrA+SR4kOjLZEArnMMuLbAFxkuIqH1V65RHf0fq8uARTfevst33qBk7YCCqaUlsVDyx9zKEVq2vPi0zdrdD5XzPNAREggI+BNMyT6yrvjxDfXCT3Ipyo8QpPOAtApIewACnPUSZsmaqq2/NSvJajL7z4C4vG+df62HAjF3Vc2AevKi0iQI1i5FOIU7VFPcY4XkGObAkcnSL6ghTn6qAyLBEwejD+8UmNy81/KbAdExEoXv22l8qocZWgejk+FE4DDBheE25HuZPHTR8z7UXzvlxpGo7UWYsV81Gxd6CIrQ3/vzaApNyDNTmSsFWs4Av6dk/MMM8xeXkpuObIKZY7pJCTefyYgNJSecofP5IUPbnjJC2DFSI6eThtvu5wgzDv6szSvkjLZ4ToVi9TDnonrGb7mwKY4UYzgagI6IBwx3JhAG/hZnTPo2YMp9v93eNvDzGkZxXlZSWkE4xrFC/vDPLUzRyOIBYviw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132a7453-5437-4a4d-c053-08de0b8fcb5a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 02:08:55.4891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jb4AboO9CZ6o4P40RyBy+9diG8+EvBgisBuN6uKlWFAYs16V8+ADkIhgACi0OLH41NXnfryjGzCGKRr3p49kkFdzNl3drx2guEOIi0P9j8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4344
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510150013
X-Proofpoint-ORIG-GUID: TiV-cDdM4VefrM_4CArTKERwXn0mvQw0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX0l4VKoD2V1hh
 v1c3NCIJDNb6W0xfhZax4R+zsl5BGieCznG/k//eCyVLYaXMh1o7Xe7cCuIjgCdLa3yr4rgQ2wj
 oyr0GmijsudeXEXFuUGNtyOOoddaVdxEncthiFEDYQTfLKYGBDQMu2Indfeq1tvSx8wXxS3Ze/v
 jI1Xp44s0vTXb8yto4PMOYAnYHEBmPRUlp9oLr4j45AXzcrQuwhetUNLrdwso6IRPXycNiMuli9
 ZB8J7EqRVyr9D+EaGRm/2z0pSFzqu+OxCP56a8ufNIYScspSlckDzx5JA74s13REEu7vNJdSfep
 4kqlXpNxkRwqR3M+lC0cHdz0CENVzzjouQEiTXR/G2hKgERnUzAhqODi82K64Okgv0E9KImwRA3
 puOGJ+wM7PfaizVH7H1WW4zO8AOTu8uReNbuNv/gTg4f2E/+3qs=
X-Authority-Analysis: v=2.4 cv=E7TAZKdl c=1 sm=1 tr=0 ts=68ef023b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=mITI9VeZjGSOdAK9:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=mKg2oqnnszWA29WCgwcA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12091
X-Proofpoint-GUID: TiV-cDdM4VefrM_4CArTKERwXn0mvQw0



On 10/14/2025 4:50 PM, Simon Horman wrote:
> Hi Alok,
> 
> I lean somewhat towards this being an enhancement rather than a fix.
> But if we want to go down the fixes road, then I think the problem
> was introduced in the implementation of xgbe_phy_mii_read() in
> commit abf0a1c2b26a ("amd-xgbe: Add support for SFP+ modules").
> Although I do see how you could argue for the commit you have cited.
> 
> The above aside, this patch looks good to me.
> 
> Reviewed-by: Simon Horman<horms@kernel.org>

Thanks Simon. let me send it to net-next.I will remove fixes tag.

Thanks,
Alok

