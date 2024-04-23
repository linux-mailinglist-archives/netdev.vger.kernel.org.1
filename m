Return-Path: <netdev+bounces-90610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB898AF30E
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 17:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B221F24A24
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD24136652;
	Tue, 23 Apr 2024 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="GAgvujrZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9656C13C9B9
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713887793; cv=fail; b=dnBQAnP8wk7gYoRa+vcKAlfzpA839q4gS6TLNQ3f+vbcf/8xYIlb/vQUzuK+ogWMABuMWecxboGxCu+7/6Z/+0XCnEsjJ9jBrCGOLfL8klVTcZaLW9jqKJAH7hnu6hw/TrQFY+hEEBaoJZiSURd03aY89ZsZENHG6LXNEMN4yw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713887793; c=relaxed/simple;
	bh=cvxFbo+aMwAXOB9TV+nt+FeKDDDNZLN5fg7OH/HaGHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rrbayQvCTPyTFwfglLrT3qwooGsAkEQ1u5p3jhfPGTAFRDsVbwCzeWJfZeozgxyVMc3dTnOX3emnn+HzuzBDUM5PuoLi55HJu0CGomEIeUchsSGMBxSIaLrvcnXNQinT0OLn+VP7Yans8jongDeRRzLX75onLkpM+zilwnsMUWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=GAgvujrZ; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N5bmgk016941;
	Tue, 23 Apr 2024 08:56:25 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xmd7ghqru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 08:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYgfbKIU2dt16QTXSAU1CDdBu+b8RSja7w3FAbt995yA4yr1L7YHYWnxqr10M4X5YjC7YK9jEnhSaaWcB93kv7OWO7PmSQzN+IlJ6wd6LYP/u0GZchH+Yeq2oHtC9iJqAjBmEehJDiLpCNrV4Zx9mXdqJz+zqUP97B62EtKYW1fhW6OESU8L54HuDX8+QThm9fNf+fmjm5QGVcVEA68NsnW49+M2EoV9y7rEUupgOjtE9vfoHm3j+XF6mgGokpbi2YCPsZL/bV0dOC11F4UecZ4Ik3Q9znnK/xrbhyBDrjv0Dj9V4saj5HTFdZEIr/jCADoQa8PfH8vHvl6UN9uDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvxFbo+aMwAXOB9TV+nt+FeKDDDNZLN5fg7OH/HaGHY=;
 b=LSaJFwU3TmaGbsRH1MUVZnskb+YkD/jQnGliICsWOpjKOcg/IGV1XGq2FGjAyKbnjZrW+o21ZaC6qoaQwwYDgrbpwEhvTProGl6pc8+76yBUvdPXtNVNuxiZsEbEKQ3bLD4JK/q/IKbmOcUsY/Xl/r5egyz6OVkFfyGdkomtQnYVMLdCoxo8A9Q+JXSFjfRkN8+vqwtOdlvolwOR66OzhDTYNhNzKUGOiZRYubGAJ3zpU94BGmV8x1P71EUb6H4luzcA6CakB6T+a7Wojm7QH0FojUh0c4NPk2g0B3300LwtgemV0kynDCHA49G/b5LMrGGU1DjTMxxP8GLToMCMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvxFbo+aMwAXOB9TV+nt+FeKDDDNZLN5fg7OH/HaGHY=;
 b=GAgvujrZj8K4/9JywFJb2E+e/bhBMVHPSN0Vo/yWNPZvtAqOxN/h+qloWfmMIawU72EaC9G/bxVndH6KM/hJfwp1TQ1UUkqKJXmPtDuFtZr1ryYHbSfB+eTorF7AxBzgtNU4U0Mnbs51fwRtqtfun+PuTNSC7DMNA4GFHl0FJpk=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by CO1PR18MB4795.namprd18.prod.outlook.com (2603:10b6:303:ee::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 15:56:22 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::4c91:458c:d14d:2fa6]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::4c91:458c:d14d:2fa6%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 15:56:22 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
        Madhu
 Chittim <madhu.chittim@intel.com>,
        Sridhar Samudrala
	<sridhar.samudrala@intel.com>
Subject: RE: Re: [RFC] HW TX Rate Limiting Driver API
Thread-Topic: Re: [RFC] HW TX Rate Limiting Driver API
Thread-Index: AQHalZbJkYp5DKtT4EmHAd7oN3kRhw==
Date: Tue, 23 Apr 2024 15:56:22 +0000
Message-ID: 
 <BY3PR18MB4737760F45BAFC010FAE3680C6112@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240405102313.GA310894@kernel.org>
	 <BY3PR18MB47379D035EB5DD965D6D187FC6122@BY3PR18MB4737.namprd18.prod.outlook.com>
 <64ebeda4a6f7b95adcce533d4ce9a657535ba0c4.camel@redhat.com>
In-Reply-To: <64ebeda4a6f7b95adcce533d4ce9a657535ba0c4.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|CO1PR18MB4795:EE_
x-ms-office365-filtering-correlation-id: 698a6ade-0703-4deb-f7e6-08dc63adec5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VEJVODBmUUFDNUhTMXpLL2grTlJTV2hCM01RMkdtK050QlNPdXZqQ3MzbGp3?=
 =?utf-8?B?UC9hWWx4OGFWSFlVNE03eHIxbk9RSjhNaXIrSFFXb0FTRHRNTnIrWWt2Q3Uz?=
 =?utf-8?B?SEFSSWZEdmxNamJEeUpWb1lDZ3J1bmpxV2o1UFdhRXJQN1c1cEkvTVllNVJj?=
 =?utf-8?B?QTB1Vjc3VVNRTWFpLzkzN29sVkE4ckg4NmpKT2JTN2FDcS9FeWpIYXNIa1Js?=
 =?utf-8?B?ay9ZSVNHWEdzWUlxdmlsYVBHclBMU2sxc1JPcm8wUitBTVNqQnFLS0ExSU1E?=
 =?utf-8?B?blpvZFl1NytIa3laTmF1eVZqVmVTaDZJUW16OEtSa1dlOG96MW5qa3lFVUxB?=
 =?utf-8?B?ZTJJUGlicUhLK1B6bVVKWVd4dlZXZ2JiMEFnZGJkVlhtQkhBYzA0SFZhalhI?=
 =?utf-8?B?a05WUTVPYWZXWUZVWkg1NTFkMFJsOWFnN1ZOb1R1NzZTenRpQVdIUm1ET1Jz?=
 =?utf-8?B?UEk5c0NzRlRzb2hOeVAxa3UyekZQQlhnNW5OOGJZaTNweUh2WkxONWhUZGpV?=
 =?utf-8?B?SVQvcVgwc3RpQ1VDRU52NlM3L244T2NoKy8wZk1zdUpFcDdJamFNV0RMd3Ey?=
 =?utf-8?B?bjFGbGdueDIrQWQrZFBWQ2dSVGtMU3pBVDgrMjY3THpDM2xmWms1cnI5bDdV?=
 =?utf-8?B?Tk5lRmZlYlZsQXBlVVRzeGp5NkN1c3REUmpjMDJkUnhDMjJhbWFBb0JCbUcw?=
 =?utf-8?B?OWxSSm10YlFJczFnUng1V0JuTklWcnZKRFlva21pWTFPRXJMTDV5ck9nSEZa?=
 =?utf-8?B?ZnBqR3krTjZhSzlhbGlHVkdWWGxFT3dHdm9NSkIyb3dEQkxyZG1PYUZ0R0M5?=
 =?utf-8?B?WFdDUXd4ZndNZGs4alZTcjgvaVc0b3NaV25PRmgyZUh1VnU4ekFsRzFjbkVC?=
 =?utf-8?B?VlJLN3VXNzhjUnlDWE5WNFphOEkrM2pCejZ6ZStPbVZrQWVZNVc3UUZ4d1U4?=
 =?utf-8?B?bGg0REtaYmd5TGYzTkllRFoyQUtkcWFJYUV3Zm5OeFNPb01KaFdSV0p0V3Y2?=
 =?utf-8?B?MlhPL1VRS241dkRGWE10VGNjekx5eXBtNG1na21iNGc4ajQxR0NOaCs1RElm?=
 =?utf-8?B?elR5dS9pdHBEMjJZTlpuV2U0UEdnbVRHV2M3RjEyWGN1cFZyK0lXWG1aanpL?=
 =?utf-8?B?YWZkcFJKL2RmOEd5d1ZqU3gzaVNhTko0QTA5R1NXbXJtZlBBVkc4T2RiSDZ5?=
 =?utf-8?B?NjVrV3RROGFkb1JiaDBJdDdZZ3VISWUvcGZtTHlrSXVTNUVNV1llTmhXU3FH?=
 =?utf-8?B?dGUyVHZjNjFsV1J0M0NYZkplZXRuV09adkNZc0s2a0tPQ2dLcXM1RjcwQ3F4?=
 =?utf-8?B?bExCRER0RWNPM3VKWXhtVEFxOEFxaU5SQm8zbld5T2p2bER6VzhJYmc4THll?=
 =?utf-8?B?cEl1c3lzTFVsQkZSUHUrR0ZOMVo1N3dQWHNkMGE3RXkyaisrT2dKQ3pGN2VP?=
 =?utf-8?B?bUE3QWpvMjVTSHRqNE5ReGoyb1MyTnlPUnRGeEdDSExtYnExNGg2N25OMysz?=
 =?utf-8?B?WGhxQ2tZVjUyTkJ0Q0F2aHh0aG5uT2dEajRObWtJNk1JQjVpV0RDcXBFck0z?=
 =?utf-8?B?alR4OXNrRVdBQUMxUW1yU3ZXdjhCV2pLVFNWNkp3bTFVQmFsUU82aVgvMURl?=
 =?utf-8?B?R245QmlxUmd5WlRWeUxxQmZkcjJ5VU11SkpRa044dGlwSHVkS1lqbUxtZ09F?=
 =?utf-8?B?RjVMUjNJajFYbHB5VExkbjNFTklYTDUxaVJrVjk5ZG9XcVg4Zmlsa2ZrMEdF?=
 =?utf-8?B?cVkwdzFYMjZYdUV5Y1ZIZGJrSXBJT28rUWp0clhRWkpxTlVRS1JGVSs0cTlP?=
 =?utf-8?B?dk5IbFZVYmNjb2w4ZFArUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Smw1cGNrRk13TEVjZTZFOWdhZVk0Sm9iT2ZySGhqa25lNUUyMTg5UVc5TGJ4?=
 =?utf-8?B?YWlKbkRTUEpxQ0x3bmloRU1LRDV5SkV1alJZc0VpR3QvY0FPdytSbldib0FP?=
 =?utf-8?B?MzdMT1AyOWIvb204TndPQWt0ZkZEa1pjckRXQ0VkWHFqZXhGejVSbGdYbXVx?=
 =?utf-8?B?bHh3Qi81UG5Uc3dua3BScENaNnlZL0VKUVVxVmU4ZGpHRVBTbmFMdVZRY3FQ?=
 =?utf-8?B?aDJFcHNvUjNpS3pFanVEeFRZWnE4S2E1ZmhPQzhwcm0zczJUZ0dQK0k1Szlt?=
 =?utf-8?B?WWFCOTYvRHdiSlFQSUwrWUpIalVlYnBmWkk4Y2M0S2EzaEVnV0xoODdGSnFw?=
 =?utf-8?B?MGdQd1JEK2VFMnJhZ28zdkd2a2V6QnVjZ1VQZHhIZE9mSlVXWFJkZ1R4NE41?=
 =?utf-8?B?OHFwTHVGSmt1VHY4N253TUwzd3lLOHRJaGR6N1p3YXFsRGdWcTdZNVhPUEFB?=
 =?utf-8?B?bGViV2JHN0krODZtbGdNV2hkaG1tWU5NTDNQZ3dydk5tQlpnTVMrYXZSS2U3?=
 =?utf-8?B?NlR2RmRYSVdObFpEVU1lRE5UNnhPQ0h6YllubCtJR1dBa3IrdmxXaGhxQWRr?=
 =?utf-8?B?ZUt5ZnQ4Mk5GVWl4TGE3a0c0QVc5dzFQVlRyVC9aSGhXclJSd0wxVHgvalM2?=
 =?utf-8?B?a1g5VWpoQWdsWDFmekc4YjU4S3JzQ21aUjZ3Znd1TEFEOGlDR3hqbEZZNUlK?=
 =?utf-8?B?TDBETS8vT091ckd5a1pONE9JSC8wbWRoekcvcG9lcmc1cWplb01tNHp5c1Rm?=
 =?utf-8?B?WG9mRjY4OUpYVmhPeGhXN3ozVXprNCsxdU9saTFjb21nR09VdENxSEgxT2lz?=
 =?utf-8?B?ZnhpOVgwYTNxSHpMYTFQOWFoWDBoMm5RVzF6VVJrZURHUGx4c1kzbG9lTTVK?=
 =?utf-8?B?dGJRUm4zTEM2dE1wMkpyeDd4U0g5SlEwSzFWWWV1T0VpY3lkY2VCTk83OVZh?=
 =?utf-8?B?RFJXQXBISStZZm5qZEpnMGNyWUxZTStQVWNYMHVjN0VnMndhVTgzQ3JnSmNn?=
 =?utf-8?B?STV4Z1RPdkpmOCtTQ2wvVWhteXNQaXRvSU5ta0VQOFM4MFJFQ0FHaGZZU1lm?=
 =?utf-8?B?ZThjRnFHTW56NVpDUHlPTFQ3TDN6T1EyeThwZ2pDb3g1b2dHK3dTRTBqZE5p?=
 =?utf-8?B?ZjNWYWdOTC9wWTNQMjJNK2J6YUtnelpmeTNuL044SStRUmZKb2FJZlVWaXVs?=
 =?utf-8?B?cytHVmJGVVkrWkJjYzkyRVZIVXJnd21YTzgzTWlreHVrUTFSQzBRQTVZL2tK?=
 =?utf-8?B?T015WHhmNS90dXRtVTB2eHlYWWx3MjM5NjlKb2R5MDZTTTI5Z2tEcGVPQmFG?=
 =?utf-8?B?ODRaOTdYeThRRE1UTTlqc1Q2UkMrYm15MDRmV1VTT1p6UHhQVVdvVmxBeitp?=
 =?utf-8?B?d0hGSXZEQnJ2RFY0MEh6TkNBWXhRb3ZJSzVMREI1SHJFNHZIOFA0dGRnL3Jy?=
 =?utf-8?B?KzJsbDMrR0IyZ2hiUXN4elBHbFlWdEhCMVVvY3BvRyt5QWdrSWdrNWIzOUtI?=
 =?utf-8?B?V2tZaUtkY0ZRSXB3dDFMNzh4VVJXd1lJdDdEVEpRcTZKWjkvWHhqOGt2ZEVi?=
 =?utf-8?B?dkhraW9pVXlaTU8ycW1GaWQzbW1oSU9CMWRZL3BLNHhaTTNzMEFLMEZSdlRT?=
 =?utf-8?B?MjBIVVRYcHBWL3JlTTY4aVBNemJpVFQ4eVJ0UDR0T1J5OVFhbG9nSHo2KzJs?=
 =?utf-8?B?SWU3S0Iwaitlbk9KMVB3TEZmODN0Y05COUtkMThOWlRnTnlrbWVNTTdxSkwr?=
 =?utf-8?B?ZW5KUWVMV1ZZazI2R0JzL3g1SnFFMC9lQzVpQkVxYUx5TTFzTU9NbzBRODUv?=
 =?utf-8?B?WUg4U2UxRGFjRkU2K0xwZ3d2T2FQNU5IZUY1OUdlOXR0ZktxRHo3U2xaSStE?=
 =?utf-8?B?NkloY3Y3VVU2TlFlU05CbU92bEdTeUJXSUlJbXk0R25XUDJRNzlZbkNLQzFk?=
 =?utf-8?B?Y3B3R29YZkYwcGxBY3M1R05JcEs1UlN5QzhVVkRxSU5wYU9WeWtDLzVIRlM5?=
 =?utf-8?B?T3dnTCtYZWlFWEk5MEpZZmVrWVlpQTFzeEt1MnhaTHE4WWZuQ3MwNUtlRzdq?=
 =?utf-8?B?M0UwSkJMR25pZDFlVFBvUHA1MFJJWGRCT0doQWVxTkhXK0h5RXhuenEwc1k1?=
 =?utf-8?Q?LTaeHaDwXnty9sygj4ABR1LSy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698a6ade-0703-4deb-f7e6-08dc63adec5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 15:56:22.5758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SGgZJ8Cm/hIAozrHgS40BuaxjK1F4bm2UwYsxZA/q801HNB0L86iV/SIVhqAw8a2eA9wKI1t3WOY8gvkB3VDmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4795
X-Proofpoint-ORIG-GUID: U8heuAVx-VRqw8bkz4q4NweyCLL1nTWL
X-Proofpoint-GUID: U8heuAVx-VRqw8bkz4q4NweyCLL1nTWL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_13,2024-04-23_02,2023-05-22_02

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQWJlbmkgPHBh
YmVuaUByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAyMywgMjAyNCA3OjM4IFBN
DQo+IFRvOiBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgU2lt
b24gSG9ybWFuDQo+IDxob3Jtc0BrZXJuZWwub3JnPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0K
PiBDYzogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IEppcmkgUGlya28gPGppcmlA
cmVzbnVsbGkudXM+OyBNYWRodQ0KPiBDaGl0dGltIDxtYWRodS5jaGl0dGltQGludGVsLmNvbT47
IFNyaWRoYXIgU2FtdWRyYWxhDQo+IDxzcmlkaGFyLnNhbXVkcmFsYUBpbnRlbC5jb20+DQo+IFN1
YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtSRkNdIEhXIFRYIFJhdGUgTGltaXRpbmcgRHJpdmVyIEFQ
SQ0KPiANCj4gT24gTW9uLCAyMDI0LTA0LTIyIGF0IDExOjMwICswMDAwLCBTdW5pbCBLb3Z2dXJp
IEdvdXRoYW0gd3JvdGU6DQo+ID4NCj4gPiBPbiBGcmlkYXksIEFwcmlsIDUsIDIwMjQgMzo1MyBQ
TSBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+DQo+IHdyb3RlOg0KPiBbLi4uXQ0KPiA+
ID4gLyoqDQo+ID4gPiAgKiBzdHJ1Y3Qgc2hhcGVyX2luZm8gLSByZXByZXNlbnQgYSBub2RlIG9m
IHRoZSBzaGFwZXIgaGllcmFyY2h5DQo+ID4gPiAgKiBAaWQ6IFVuaXF1ZSBpZGVudGlmaWVyIGlu
c2lkZSB0aGUgc2hhcGVyIHRyZWUuDQo+ID4gPiAgKiBAcGFyZW50X2lkOiBJRCBvZiBwYXJlbnQg
c2hhcGVyLCBvciBTSEFQRVJfTk9ORV9JRCBpZiB0aGUgc2hhcGVyIGhhcw0KPiA+ID4gICogICAg
ICAgICAgICAgbm8gcGFyZW50LiBPbmx5IHRoZSByb290IHNoYXBlciBoYXMgbm8gcGFyZW50Lg0K
PiA+ID4gICogQG1ldHJpYzogU3BlY2lmeSBpZiB0aGUgYncgbGltaXRzIHJlZmVycyB0byBQUFMg
b3IgQlBTDQo+ID4gPiAgKiBAYndfbWluOiBNaW5pbXVtIGd1YXJhbnRlZWQgcmF0ZSBmb3IgdGhp
cyBzaGFwZXINCj4gPiA+ICAqIEBid19tYXg6IE1heGltdW0gcGVhayBidyBhbGxvd2VkIGZvciB0
aGlzIHNoYXBlcg0KPiA+ID4gICogQGJ1cnN0OiBNYXhpbXVtIGJ1cnN0IGZvciB0aGUgcGVlayBy
YXRlIG9mIHRoaXMgc2hhcGVyDQo+ID4gPiAgKiBAcHJpb3JpdHk6IFNjaGVkdWxpbmcgcHJpb3Jp
dHkgZm9yIHRoaXMgc2hhcGVyDQo+ID4gPiAgKiBAd2VpZ2h0OiBTY2hlZHVsaW5nIHdlaWdodCBm
b3IgdGhpcyBzaGFwZXINCj4gPiA+ICAqDQo+ID4gPiAgKiBUaGUgZnVsbCBzaGFwZXIgaGllcmFy
Y2h5IGlzIG1haW50YWluZWQgb25seSBieSB0aGUNCj4gPiA+ICAqIE5JQyBkcml2ZXIgKG9yIGZp
cm13YXJlKSwgcG9zc2libHkgaW4gYSBOSUMtc3BlY2lmaWMgZm9ybWF0DQo+ID4gPiAgKiBhbmQv
b3IgaW4gSC9XIHRhYmxlcy4NCj4gPiA+ICAqIFRoZSBrZXJuZWwgdXNlcyB0aGlzIHJlcHJlc2Vu
dGF0aW9uIGFuZCB0aGUgc2hhcGVyX29wcyB0bw0KPiA+ID4gICogYWNjZXNzLCB0cmF2ZXJzZSwg
YW5kIHVwZGF0ZSBpdC4NCj4gPiA+ICAqLw0KPiA+ID4gc3RydWN0IHNoYXBlcl9pbmZvIHsNCj4g
PiA+IAkvKiBUaGUgZm9sbG93aW5nIGZpZWxkcyBhbGxvdyB0aGUgZnVsbCB0cmF2ZXJzYWwgb2Yg
dGhlIHdob2xlDQo+ID4gPiAJICogaGllcmFyY2h5Lg0KPiA+ID4gCSAqLw0KPiA+ID4gCXUzMiBp
ZDsNCj4gPiA+IAl1MzIgcGFyZW50X2lkOw0KPiA+ID4NCj4gPiA+IAkvKiBUaGUgZm9sbG93aW5n
IGZpZWxkcyBkZWZpbmUgdGhlIGJlaGF2aW9yIG9mIHRoZSBzaGFwZXIuICovDQo+ID4gPiAJZW51
bSBzaGFwZXJfbWV0cmljIG1ldHJpYzsNCj4gPiA+IAl1NjQgYndfbWluOw0KPiA+ID4gCXU2NCBi
d19tYXg7DQo+ID4gPiAJdTMyIGJ1cnN0Ow0KPiA+ID4gCXUzMiBwcmlvcml0eTsNCj4gPiA+IAl1
MzIgd2VpZ2h0Ow0KPiA+ID4gfTsNCj4gPiA+DQo+ID4NCj4gPiAnYndfbWluL21heCcgaXMgdTY0
IGFuZCAnYnVyc3QnIC8gJ3dlaWdodCcgYXJlIHUzMiwgYW55IHNwZWNpZmljIHJlYXNvbiA/DQo+
IA0KPiBBIE5JQyBjYW4gZXhjZWVkIFVJTlQzMl9NQVggYnBzLCB3aGlsZSBVSU5UMzJfTUFYIGRp
ZmZlcmVudCB2YWx1ZXMgbG9vaw0KPiBtb3JlIHRoZW4gZW5vdWdoIHRvIGNvcGUgZm9yIGRpZmZl
cmVudCB3ZWlnaHRzLg0KPiANCj4gTm8gc3Ryb25nIG9waW5pb25zLCB3ZSBjYW4gaW5jcmVhc2Ug
dGhlIHdlaWdodCByYW5nZSwgYnV0IGl0IGxvb2tzIGEgYml0IG92ZXJraWxsDQo+IHRvIG1lLg0K
PiANCj4gWy4uLl0NCj4gPiBDYW4geW91IHBsZWFzZSBjb25maXJtIGJlbG93DQo+ID4gMS4gRG9l
cyBwcml2aWxlZ2VkIFZGIG1lYW4gdHJ1c3RlZCBWRiA/DQo+IA0KPiBZZXMuIEJ1dCBrZWVwIGlu
IG1pbmQgdGhhdCBnaXZlbiB0aGUgY3VycmVudCBzdGF0dXMgb2YgZGlzY3Vzc2lvbiB3ZSBhcmUg
Z29pbmcNCj4gdG8gZHJvcCBwcml2aWxlZ2VkL3RydXN0ZWQgVkYgcmVmZXJlbmNlLg0KPiANCj4g
PiAyLiBXaXRoIHRoaXMgd2UgY2FuIHNldHVwIGJlbG93IGFzIHdlbGwsIGZyb20gUEYgPw0KPiA+
ICAgICAgLS0gUGVyLVZGIFF1YW50dW0NCj4gPiAgICAgIC0tIFBlci1WRiBTdHJpY3QgcHJpb3Jp
dHkNCj4gPiAgICAgIC0tIFBlci1WRiByYXRlbGltaXQNCj4gDQo+IEFzc3VtaW5nIHRoZSBOSUMg
SC9XIHN1cHBvcnQgaXQsIHllczogdGhlIGhvc3Qgd2lsbCBoYXZlIGZ1bGwgY29udHJvbCBvdmVy
IGFsbA0KPiB0aGUgYXZhaWxhYmxlIHNoYXBlci4NCg0KVGhhbmtzIGZvciB0aGUgY2xhcmlmaWNh
dGlvbi4NCg0KPiANCj4gPiAzLiBXb25kZXJpbmcgaWYgaXQgd291bGQgYmUgYmVuZWZpY2lhbCB0
byBhcHBseSB0aGlzIHRvIGluZ3Jlc3MgdHJhZmZpYyBhcyB3ZWxsLA0KPiBhbGwgbW9kZXMgbWF5
IG9yIG1heSBub3QgYXBwbHksDQo+ID4gICAgICBidXQgYXQgdGhlIGxlYXN0IGl0IGNvdWxkIGJl
IHBvc3NpYmxlIHRvIGFwcGx5IFBQUy9CUFMgcmF0ZWxpbWl0LiBTbyB0aGF0IHRoZQ0KPiBjb25m
aWd1cmF0aW9uIG1ldGhvZG9sb2d5DQo+ID4gICAgICByZW1haW5zIHNhbWUgYWNyb3NzIGVncmVz
cyBhbmQgaW5ncmVzcy4NCj4gDQo+IEkgdGhpbmsgdGhlIEFQSSBjb3VsZCBiZSBleHRlbmRlZCB0
byB0aGUgUlggc2lkZSwgdG9vLCBhcyBhIGZvbGxvdy0gdXAvbmV4dA0KPiBzdGVwLiBUaGlzIHJl
bGF0aXZlbHkgc2ltcGxlIGZlYXR1cmUgaXMgaW4gcHJvZ3Jlc3Mgc2luY2UgYSBzaWduaWZpY2Fu
dCB0aW1lLCBJIHRoaW5rDQo+IGl0IHdvdWxkIGJlIG5pY2UgdHJ5IHRvIGhhdmUgaXQgaW4gcGxh
Y2UgZmlyc3QuDQo+IA0KPiBXZSB3aWxsIHRyeSB0byBlbnN1cmUgdGhlcmUgd2lsbCBiZSBubyBu
YW1pbmcgY2xhc2ggZm9yIHN1Y2ggZXh0ZW5zaW9uLg0KPiANCg0KDQpNYWtlcyBzZW5zZSBhbmQg
YWdyZWUuDQoNClRoYW5rcywNClN1bmlsLg0KDQo=

