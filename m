Return-Path: <netdev+bounces-290617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAA6IKdzD2r4MQYAu9opvQ
	(envelope-from <netdev+bounces-290617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 23:05:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FA65AC030
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 23:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B010302D31A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 21:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D87344DA8;
	Thu, 21 May 2026 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kNDmPJQM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mf2rnZd7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59B22FC876;
	Thu, 21 May 2026 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779397499; cv=fail; b=aY33GqVjd8+7+eygRJ3bWMSdqbwES7L6TJyyO0isxz5+U/FUXptWRQJ9eID0+pv0p5CmLrha8wKsbR6RGVMFAVXgJLJlfyS1YCfpB6TNZM1haT/sGaSP5ghi9NoB6BW4Hnksc/VpVxrmDn1Vcjbqec2wJ6stPwf6v9APu3UsdyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779397499; c=relaxed/simple;
	bh=XFifKHcCpVfnn502ihWEvQby8MFUapgZbFdVMUxYvDE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nsz1UfUFwqRe99wqd92nNL4uFoNrYLkMZ9jRm2urGwwdvv1EoseNdg+Cl7XEJloGsfYjtIkNplAdGTqiMtBKzT6mklVdtDDXh+qI16qn2aHWOd/hXaHhOxKkdOyKIzpGwxScfQaUiq9vT2uHdbBRg4A+rbF+ujBfKvGgutKDFqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kNDmPJQM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mf2rnZd7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LJfXWA3527403;
	Thu, 21 May 2026 21:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xPl5bUFeL+juUUXzpfP5JP6r73KiCRRK7r60AxBiccM=; b=
	kNDmPJQM/T2TLBfZEgR72O6/4qL1tejcvhaEdyRCqTpJ4QR3EuxX5zK9yOn1+h+h
	u/Cdfe3YdUs9ry7QiPhbUt49LgWnWQRDap6YWbjxWsxrkGJr1jdO5mBSFdSdnh8Z
	lQ+0Da39wvjBjuk8rYwfpy9VzPIuciUGuWgV4VD/xEon3gawsWDV+xRuikMM2/Zr
	IP5AN9wScj3gK77TZyks/N5ivi1WOfEOVKsC8P0AZmd2t/7Bvx7VBW2b9K7SkiU0
	0HCl4cFWdHBcp7TDiOaI1AQ7Ar2akuKqqf5Y6kwDX+zkKt5j0KnWpu/cE4HS0eBu
	MdbvI+fpLuZ8rf9L+a3Pkg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6gxx21gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 21:04:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64LL4k0B024690;
	Thu, 21 May 2026 21:04:48 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1e64p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 21:04:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTqnYx57Xsjd+lLAw7RyCI+3jKETOuQXspVFeLJNVL4xAD9iugJj3Q9RQkua70LwH1lTPyPgLB51q/6UUAwzGGlC+n0Qa9lYbnzUzRadkMGVDQJrDdt3ZWrCwzehhnwbeG8WVCi6+8dpv2L6apw+j17qfH9/CSXRgF5XDqYj1gmDtXSKM0KqVxJFPE519rnSlzBVFZnCmvKml76nkAhDI+rb8293rsjffS/h5t2fx2i5I1X04uvopR9RiBWuxhOzDs7aut3tPR5PtDzHBUulsOqmg3JPTgdmJcDfICxAz1xj0QJJdWctOqQBNblv9oywfEeW4Oj4Qf0kMWqvKIqQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPl5bUFeL+juUUXzpfP5JP6r73KiCRRK7r60AxBiccM=;
 b=gt7Fxe6rjKi6Gap1JjsTqEGVwmjQiO7ZAIHQTCcamryqPWys/zqRQWqpibYxjdTa/eUI0RpwL++pYHqczSWtDaN2egztDpwwlq3DmCG0EvwKKYuKHM5exYmYtbj8t03w1UQh2r62Mo84E/XxGmZi0oN3RKvLZ7O2Tl7jPT6oq8Qe1huPbSpKpwG3cok+g/fdMJu+QIb4gKZOgNIYwLiyUIWxsbIIoicBHRGgc26u/vlR7X+Z43bmMKaP7skiaepJkKiCByw3zqFfYUByF9Vp8XLg9G+LM6PbpkND7RYXIH7o2yVshliGRyMGBcVKIvB5bybFroCCvTc97DPLA7sl3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPl5bUFeL+juUUXzpfP5JP6r73KiCRRK7r60AxBiccM=;
 b=mf2rnZd7SPuEOL232pDzRXtMBqCWKWANFL3VviyKOPaVEMw5U0WHYiRZlJA+xWXy9ol1c4qBhpAzcB2tXi4DZoIytM0/nVMw7l9Y/E0urBAfniUAzdn9nhqrkX22wlX7kDY0XhNlR/6Vajyr/ACk4peF7aA/Bclo2ltjIa5Hdqo=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by MW4PR10MB6369.namprd10.prod.outlook.com (2603:10b6:303:1ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 21:04:26 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 21:04:26 +0000
Message-ID: <0098d80b-3b79-4753-8a7f-195cbeb1759b@oracle.com>
Date: Thu, 21 May 2026 14:04:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tap: free page on error paths in tap_get_user_xdp()
To: Weiming Shi <bestswngs@gmail.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, pabeni@redhat.com,
        kuba@kernel.org, edumazet@google.com, xmei5@asu.edu,
        linux-kernel@vger.kernel.org, Si-Wei Liu <si-wei.liu@oracle.com>,
        mst@redhat.com
References: <20260521163230.1478627-2-bestswngs@gmail.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20260521163230.1478627-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0167.namprd05.prod.outlook.com
 (2603:10b6:a03:339::22) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|MW4PR10MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 1722f88c-28cc-4f66-96bf-08deb77c8a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	319MC+nde7zPycqbQChs73sLbxvmQEUKj9Q7jfhURRJbdgqv+MMg+OyHuNU8p2icOcQIhaVs93IwiZEUFQMllVxrd1LGWP8vKdImgx+3yaY2jSgJ0D/stjI/V/IR4nsZ8/Dl0fbXI9MqBDRkUuOY30xVxRKl1ckqu9jhLlrx95voVm2ROvdE/CVCGhcsaygeGraKmruBttb8t0J3pNQrNrbiDofhk4kE6qD3XgiID/St3LvfHwWv5JxLa4UukZ/UXl+sQjQyhgnhEr0OBg+9ElB8vRzTn7yD04FYnxML6V+de5ojtzoe2+X8h6On44X/mOKXmEBB72zpZkKNX7EQz/4Jqd9pVQKrt66xR2yxdIWpkRruq7x599f7ZCFY0J0Mix+XlRWx8kBEtMWovrWTIXYhpl9ZBVZpoXBLy1+fWbWW1M6eqeknbxdhjqA1dJQNzynSkTfHlx7jEXWsnTWyAHCCUqQ0CDuSzXExVIesunm9H8iGFlpgyMjm3SX+mBotxlN6VuWmWAS16imIsBjAu+lDH4lx3h4nAY7jYBrH0qbQDGERJOTl6Azn7XjZ9gYRxPq5i8jynptcNklEcTnXnSiar8ZRTjaB5LSNsVAdifKNfcxhf1Iy5/ievL0iuIpF1RRF1XtbgkhK3AZnWlevyhx4pc+66lWmx1HNFiW7DCHKYeS40sYU8v67F6lLlKJf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5109.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmhsUG1MR1FPQjBJTGRCTDBjdC9wVnpXRkJqcm9GTllLS1I4b05icmVweGRn?=
 =?utf-8?B?VmI5WS8wMGRSOFZydGRUUmx2cCt2cVhyK2NHZVFDTzFNMmpVeTR2VG5LaHFw?=
 =?utf-8?B?QzduZ1NXbmp4TWNmL3dQVXhTK2Q5NTgvd3FYY3BQbTUrZ3FMY3RBbEJBYWh1?=
 =?utf-8?B?SUhZSk1wdmVOYzJ5d0VWYUo5R2NORlF6N2ZrWkNSY1gxMVN3Qld0dDEyMmkx?=
 =?utf-8?B?NlpuenhxQ1BjQnpxSldUbk9ERTNNSWE0QU9ENi9rdHcxNjFRZXJ6M29yRDZF?=
 =?utf-8?B?aTUxN0dscDI5Rkx1QnRSZ2JBMFFraVpON0NlUkhIaHdKa3l1SWZoVkVyWjRu?=
 =?utf-8?B?MEdicURqb3lZcGlNMzJXdFQ1RWJadkpRditWZXFsNnNwdVUvWmpkSmJhMnJN?=
 =?utf-8?B?NmlTc0lPVGxsTE5hNEZOYmFEUW80MDhkV3VCUjhiZW5xZVpYTU1tVlhRVm9X?=
 =?utf-8?B?Qm42Vzg2UGFJc2NpMURNb1liTUdnTjh4eWlhUjJidlB4T3p1M0JRUHYxczlX?=
 =?utf-8?B?OXlVSUtXb2pWbHVGVEtMZEltLzFSTSszWVZOaXlMa2FrNXdidzduL0tsV0U1?=
 =?utf-8?B?amRWM0ZpcDlFSFJFSzdnRDNHMnBnZHJwU3JiVWF0S0ZLcWRiVHJRdDJMZkFr?=
 =?utf-8?B?RlpTUUpER0o3T2xNRkNwUmU0d2pFdW00YzV5TFBnTmwrNVJ6ZnU3Y1FOM1dW?=
 =?utf-8?B?ZTBlQ1pmYWl3bkJMVnpZaUNlQkJCTW9mZmxPYVhla2dJM0F2SXlkYTN2cm5D?=
 =?utf-8?B?eDRsVk9KdDVjOWFaRlZoNEIrTnB4RnIzT3JQQzJRcEcxNmRyK3hBbnF5SWhB?=
 =?utf-8?B?cUFmSHpGRFpSaFVKRytpNUVNTFErTU9QYVZWcEp2RmpnTE5sUDhGRzhucm9s?=
 =?utf-8?B?dWFzM0hiK3RoLy9PTkQ2dVpYV3R4clhyZXF1S0YwNldXSGUvTDdmL1lEZzlO?=
 =?utf-8?B?QjBhZ1hoZ05JQThmY0lnL2xKLzVvbzdWY3N0TnREeE5RVGcwNjFiZGpnNVds?=
 =?utf-8?B?QjFlRVFoRXltbFFrM1RzSE4zM3U4R2tCSUFYN0VSZHRWaGcvK0RLaEdyalU3?=
 =?utf-8?B?U2U5ZTlaOTBWSUU0VHV3RjcxYTFaODVuU056bzFtQ2dSeDhDNGQwREtUbGRV?=
 =?utf-8?B?QmhjL1ExU0djUWhwS09pZGVNcWVBK3g1b2RkSmxhU3RaRzduelMvRS9MTnk2?=
 =?utf-8?B?ak50VHNGSHpPZXV3OW5Sdnp5OWw2cmZCYmRRRlpoWGc5OXptTXpGTmtacDJD?=
 =?utf-8?B?eXZDbzF0QVlCWjl5WWFuT2ZFaGdSLzhjMWxFNVJzdDRyc2kxUUliNzZGa3VG?=
 =?utf-8?B?Y3pUa0JzYjh6ekFqSUx2ZERqZzJsZmVXdFhMQmhqamJYczUvVUhHYnJ4cC9O?=
 =?utf-8?B?anVUQTV0d1lPSUNadHc1aFdsd0dCcHFiNjBsOCtoL2g1OVZicElMUnJoVDFI?=
 =?utf-8?B?bEExWWZaZ1lvclNhU0dvODZvRlRyN1ExQjZHbFJyQnFpdCs1bHk5aGdaaFc3?=
 =?utf-8?B?ZkMvQm9wSWRDSWVIb3Z3VHpQanZHU1NBd29ZOXpRRkRmWC8ydGN3bXBaQUdL?=
 =?utf-8?B?d1pvazJkNysrWDFJOURkN3lsRXFUSlF1bHhlMXFVVkZ2anh0a2UraWlDS0gr?=
 =?utf-8?B?ZEZJNDhFczRUT1UwbUF5U1krdEhJR0E5V2w0VmhkRzhjcVBMc0U0TlZObyta?=
 =?utf-8?B?YmJReTBxdGpkdDVYanhtQ1pBdXNKRkFsNDBPRVc5Zy94WXFzc0lub0k0VTJJ?=
 =?utf-8?B?bldJTnoyRFV3OTFicEpvU01EUTFjRTgvYVRLMEltTWM1Mk16c1ROTFN2dnh6?=
 =?utf-8?B?ZVBZb01ucFNVcUkxZ1c4eW1vemZ5a2h2b2Zra1JPK0FnU1dqR2U2bmowSXNZ?=
 =?utf-8?B?ckVSNHE1L1NYK0lDcXRSd2VwZGdaSk5IckpOYnBpUGZqQmp6TmFEM1UwYmsy?=
 =?utf-8?B?YnZmMExwV0xHbDEwS2ZKZjZUbXpjWDJGRWJCNmpJNjZ5SkZoN1RmOFhQandy?=
 =?utf-8?B?S3NnUUo2dHV6Y2dsSGQySDhobXZwZDhXSGlIa0hVSWhlTHRFa0oycGE1VElm?=
 =?utf-8?B?QUQxeG5qeTNET3ExZ1FsclA2aGswc0lqK3BQd2dISVowV1RzSHBETW1XYVp6?=
 =?utf-8?B?VjhRNGZHZk9idWJGTTBUZk85Y3lDQVdMZ3p0SzB6VmZndTQ5ZGNYbmF2ZTVa?=
 =?utf-8?B?akNhcGdqaHRIVkp4VUlpR2VvYjA0YURhWjFGOXgxRXdRb0tJLzVKMTZNVTNH?=
 =?utf-8?B?M2taQkxiZGovMkxuNVJBZEdabjhxaVdqQ3hpQ3BqNG1XbWhEbWVkM1VlRW52?=
 =?utf-8?B?V2N1dlNLSFBsNjdjZGVFaHo3cGZaeXE3RjlCSWFFZTVRRm5uc2lSdz09?=
X-Exchange-RoutingPolicyChecked:
	ixsDq0jLZwBxqXTJyoFiVRLNnStk2taCsCfaEEtE7GZSQShn+4onfPbFUxciS80UFsqii0ebH85XVRDOhe+rgG62aVvhy4/Ee2H6EmBdO8cWmB0wXUuQAUb6ngzBvvzSwxUFx/QeEYCpmOFXUJfK6dvH1EWA/OpVFjNibYo3wjaPxZl0GbzQcgQmPhSOg1FSgpTv98lKIxwoMOgkeI/1BYJ2knwe2INhtbcoB+Swlfsekv9RwdJsaImQOTG8I8Ijsci50muTn9ividuO7XW4xUdjhmUbVZraHjaubjbSbwymHXin3PbcOqvhHBu0VqmlvkHqj73GYvA5oAIUH4O9cw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	02yq3Gnoe/N+AebWwp1YqaIsnBpayqH8xKFu0Ra2A9M8ZmnvZUcXh0RXgmd0OTjR4XXb3iuOpSPBdRES4gCsmchkQxk0YsSiwdgMdO9qKomN4uAeyTlKLRdu4Gx2qehpDj1RZgiib++bUe0geAYhlP1x2pAEqc+4A5x28ooEKrzZSXUFZ0jDshRHt7NHbOZVqXWuk/4XU9Xk8aQ21R2JEa8nlmm4FeqTPo/qs4fHT/zM30kZh6lzM4m2MF4OSM2/GGxCdWT+FSyYrH2yccYjUOE9peYSwkId8l6mpeqRxt7Vla9nwsv62i4vG1pNPCAOCqSwPfmgVjhwPO+VgIGpp/+R37lOptFMCtSVXvKEgpWO62CrV4LA/CXkPqGLW/F8WFkZnHpQoFJVnLNs5M0wYCg9LhdH9h1uqOyO0ezZcPFBzhkKCtvEr4dmcfYfHLnvdPzdd5pYTSdFExXbmeo/3Je5Y0ioLiMfp8bMBki+TZN+tm17tb6ZoBzRMdZANGfXnwrG6fSkJAoi8ZJ5gwDZaIi0KotKqURsVpaBCrBeswZ66DIdMxMCT2Db/ZOfzP9JDZCw6jF0WmKUatJRAePiVuXlDVy9+Z2OCGnm7GpkzkY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1722f88c-28cc-4f66-96bf-08deb77c8a66
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 21:04:25.9977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qpNmLauYI2jA3c5tIBg3Ooq2BKuYEoXsOZCcc7A+xagu9TZ0dq+ylzgGMjo0ex0nCaV40JEyIwkFFinX/dcHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605210212
X-Authority-Analysis: v=2.4 cv=UOjt2ify c=1 sm=1 tr=0 ts=6a0f7371 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=rEluC7O5_6X6rRshLnEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 84SRljrxlALrkHAyXB3w7wAtDw4EKgKz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDIxMiBTYWx0ZWRfX6DNSydvx0rYH
 m2fMaMBNSjaUXf8joMiQj7dduqKz4RsIG6ZlsewrrLgiaA61F3uKH2SLLdxYTNvL2RUVdbROtyd
 fDwiccjFtsdr4iamA8Grrt8bq8+/xjnI7iiu/nKexhhGG0fqbVzmGWcG8pHhpaeDZn8aXNpxwrf
 KSZhGXOo1hMa0AiyN3uh+19YIg4mrm/ga0xZjtYn56Tt+iiylKUybXXlyV1nMKWkbk3MzhzHHSq
 oMHBZjxZZN9wEn/atZzKUuhVdAjbDlouelMr50zNRti40Tu4NLQFWWJWwGnOaevxW7C0e8nzWc+
 zhY8CRdSXJqB9qCLX7wYL1SOeoFJFetV5MVumSG5H5CSzAbH9g37ISV1JT5qZBpgWA5JpujEzrM
 ZNwl6bVnXkfOwF2b/e57RsWmiHNEKTRFydhs+lEFWRg+sjiPe9MSA1xPIdHXQ9AuUVfU0CsF1b7
 vIMjX762NvExZc05dBQ==
X-Proofpoint-GUID: 84SRljrxlALrkHAyXB3w7wAtDw4EKgKz
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-290617-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,kernel.org,google.com,asu.edu,vger.kernel.org,oracle.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email,oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim,asu.edu:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongli.zhang@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 13FA65AC030
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026-05-21 9:32 AM, Weiming Shi wrote:
> tap_get_user_xdp() rejects a frame shorter than ETH_HLEN with -EINVAL,
> and returns -ENOMEM when build_skb() fails. Both paths jump to the err
> label without freeing the page that vhost_net_build_xdp() allocated for
> the frame. tap_sendmsg() discards the per-buffer return value and always
> returns 0, so vhost_tx_batch() takes the success path and never frees
> the page; each rejected frame in a batch leaks one page-frag chunk.
> 
> Free the page on both error paths, before the skb is built. This is the
> tap counterpart of the same leak in tun_xdp_one().
> 
> Fixes: 0efac27791ee ("tap: accept an array of XDP buffs through sendmsg()")
> Fixes: ed7f2afdd0e0 ("tap: add missing verification for short frame")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  drivers/net/tap.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index b8240737dc51..2e75846d1072 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -1052,6 +1052,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
>  	int err, depth;
>  
>  	if (unlikely(xdp->data_end - xdp->data < ETH_HLEN)) {
> +		put_page(virt_to_head_page(xdp->data));
>  		err = -EINVAL;
>  		goto err;
>  	}
> @@ -1061,6 +1062,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
>  
>  	skb = build_skb(xdp->data_hard_start, buflen);
>  	if (!skb) {
> +		put_page(virt_to_head_page(xdp->data));
>  		err = -ENOMEM;
>  		goto err;
>  	}

The bug fix looks good to me.

Reviewed-by: Dongli Zhang <dongli.zhang@oracle.com>

+ Michael and Si-Wei for FYI regarding vhost as well.

Thank you very much!

Dongli Zhang

