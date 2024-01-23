Return-Path: <netdev+bounces-65051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C91838F70
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 14:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5FC1C2174A
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 13:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670605EE93;
	Tue, 23 Jan 2024 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="jsAboB28";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="OKl2HyUz"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956525EE74;
	Tue, 23 Jan 2024 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015400; cv=fail; b=vGMbiCGLHzmAVEOW3k9mAixkleB1s4LvJYgLCo4NYSONfRlQklY37WahlFkK0sckcihacKah9yMJ4yIeyQ2oF2wewcDz4x7L+8C9CRkE29aBUpVsR6sdB26C6vUKCAWNAcDgwrjk0MmLZ5GsydVDM7I4l8RUbGVsKOJlbzg1VDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015400; c=relaxed/simple;
	bh=xxmwri9bhnGxDBVjcYNjWru9MwbSMMBF930Yxjz4OkY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TCG2KMz0KBnMZyuNAB2QDmUTCm3sGA6Kt8lKyWSNBxjVZoqW2J7uN7cgDlJzWFmNFTFQM98Jnd4OkPFJ30+YQsghcBz8YaR4665D4WuamcmbwyPG+DT+E3QCS4KfNTIu1B+sxno1GXgCHPMcs70aCkVpadM+OVxN4W16dZPKe/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=jsAboB28; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=OKl2HyUz; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N6Wojk009198;
	Tue, 23 Jan 2024 13:42:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	12052020; bh=Py6IYSZk4Fe40Q5KRcLKAEnM1H5nJybsdPKSOvexQqE=; b=jsA
	boB28+D+xb9G2ndZ4o58MFGBxFQurpCr6tQ9In8kSwRmii6CQDmWhvrzfMg2tYss
	5pnN8X3cDmAaHboEVqMWyuUU0MBUpWwXiLHZipnCdQvgMwZfI444XTlEoGQ1QEtr
	BNxyChTVYH/pacM2507+ZjRhZrJ2QIgKRi/B4VAbQ+WVxpUrPKh6d+yXErIRiWyF
	vwcSEHuc0jZ5Rnke4qYoWXSSCoeVjP+Oo41+DEP3Cn80JoYuEc39pzGpY5eJ7jDj
	fqNVgYwX2MvA5ydtDDqz7lsMwz14hihPQoa4MOCB0AeJmeG1E0YzBAo3GTfvsnYa
	rhXSZ86pMnDp0Hs/5GA==
Received: from mail.beijerelectronics.com ([195.67.87.131])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 3vr325ke5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 13:42:43 +0100 (CET)
Received: from EX01GLOBAL.beijerelectronics.com (10.101.10.25) by
 EX01GLOBAL.beijerelectronics.com (10.101.10.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2375.17; Tue, 23 Jan 2024 13:42:42 +0100
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.105)
 by EX01GLOBAL.beijerelectronics.com (10.101.10.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2375.17 via Frontend Transport; Tue, 23 Jan 2024 13:42:42 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3ohWEHSY9ON7LsnlbtwaZ90UmYY92sUwHdHdOi7phzPq/UdRrVQFqO0DuFNkal2Ffwo5//IADp78FhIgjGd5wZBF4157wtgAfv2BMqs5ebwJBQmv4kLRM13CSpiz71IF/f5eQnTB+eUe235MaqGOFYYLJzGHXuvN6s06bSmPAzQIC8bD4rJnPLQGrX8FikziY71m0kvyMPgiErVq1NNZ3Fkfj8OMj+8oVmiJOtuq5mticve2pDNbxPiAXFFFO/XKkvC6aPS9jNJhmGtTlLrlixoe0HRjODU3rlCKoYfbjm8UVghObeKsEc0rRY5HqvA8ePSf+9UiOTDJcuRhEeXlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Py6IYSZk4Fe40Q5KRcLKAEnM1H5nJybsdPKSOvexQqE=;
 b=Jz20BtI9NNJPHxjgGgVFsw1mgOePj7kU5Rn86xhT7peTv/M4jaDtWx3pFkj7SPNucs3YY+AAPMYQcRN35hCgpk+EPOrqbiS6kEVxMmpOD4RWQbY0HsWodQFFolBabW9xNO3zXxartoI3ACytRlRwUv9CD4Cp4lbQOGCqna5a7J+3tTIqP/lOsO5Z2zazWc9t/Z72bxVPV8UEeZW7/Aw58/DA/gjBDQEO03Xg9p5JGXpo9CV2ZIkIEX3Pqwbg7krE191NhzPpZqBaHMvZmV/J1IILpldZf6WelLbT5gwuLaJS/t3E4jjLudVWnaUUQxS2RQsVIr/x3sKY5hdkhfyWNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Py6IYSZk4Fe40Q5KRcLKAEnM1H5nJybsdPKSOvexQqE=;
 b=OKl2HyUzndHO4gznkFMUVMBRIjQOviIeBXUDJt/pUq4KzVf+p32JWAcEvgGO17FOzrWpLsvGn+NDjYqLg1gpOKAGEM+XTnwrdyG79/k22LvAm+VjPmSsbnQjqXDhiZWxIb+rb92ZfAKDjVrSuuKl/a3g6XUkgK96inq8okFrQSQ=
Received: from DB9P192MB1388.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:296::18)
 by AS4P192MB1623.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:4b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 12:42:41 +0000
Received: from DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
 ([fe80::f1b7:52d5:fa2e:39e1]) by DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
 ([fe80::f1b7:52d5:fa2e:39e1%4]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 12:42:41 +0000
Message-ID: <83ff5327-c76a-4b78-ad4b-d34dae477d61@westermo.com>
Date: Tue, 23 Jan 2024 13:42:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] net-next is OPEN
To: Petr Machata <petrm@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "netdev-driver-reviewers@vger.kernel.org"
	<netdev-driver-reviewers@vger.kernel.org>
References: <20240122091612.3f1a3e3d@kernel.org> <87fryonx35.fsf@nvidia.com>
Content-Language: en-US
From: Matthias May <matthias.may@westermo.com>
In-Reply-To: <87fryonx35.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0145.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::15) To DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:296::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB1388:EE_|AS4P192MB1623:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a041b94-b75b-44e6-fe62-08dc1c10c9c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q3z+VNosoCKOp/EKN1p5KDdoesBIIooIuXLv85njJ/plIN26bgHaLWGCTk8rgAduYHU0No27kD7BCaph2H8M5LIpJoKOOCgjTy5s+ohqCwUtKCOMtUFLwpVZizukPDldsrwkA5+7+UegrDF6Ui17koYflr3l0OVbw2NYiYXP8mjVaVpzU14hofZ8iZcFVAu026pg65+HafloknfYpY1MkCp+/8jC6T8BA6rl46kQzK7ippOKCe91BGHH6QwKNZOPLm8NNYIJIPfKD7HwXfp+2QZt1SbzmqnexEVsA9O75yLJhkzspTOBrMmt7NGGWcWRukf3xSIqav7pjWBFkzeF0JOebBiHtT7yPCsSErdEQfEMf7p7zy44sumjhD/2RWeHZAZhhO75hl94FLBTn6AOTCKNKFYhgCWkhZ45vocvHt3BjUKUEoi3ASDt/SYEHO0hLzRr4rTGT356tV5BlRgp+0Ui75bUxfNX7bcXd3vXOSXPoTmKXQcAvawCCaKEwt16LbuHduoObztIDxQO0Ui1ycQ4EGeQMt6UO4BufuxTDxef/JfmhDHeP+i4Je79tT5/UPdXKsKCo/37M78D2Qh2XMASyIo4D/xN5bWyuIkRjpx4DQ2EOP1vXZ/gOZ9Z7Ful
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB1388.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(396003)(346002)(366004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6512007)(966005)(6506007)(478600001)(66556008)(53546011)(66946007)(66476007)(6486002)(110136005)(54906003)(8676002)(8936002)(316002)(26005)(2616005)(83380400001)(2906002)(44832011)(4326008)(5660300002)(41300700001)(36756003)(38100700002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djVIbExrcDY3a1dkMnNTOVN4eWN2UUxWa3BpUTZjWHhSay9DSzNYV3RkRk1s?=
 =?utf-8?B?SnRmcU5wS2VaM2g0MHpwdWxMcDN2ZVdlcnpoVWUxc3lMS2h4R21mblFyalla?=
 =?utf-8?B?NzJDcytZUDhMRzRnVUU3empJWjdiWnh2Tnp1R1dHVXdWNmhzc205K00zOTZa?=
 =?utf-8?B?alJEZCs3bVdTd09SMUVPWHFFeS8xNGphMXFFdmZ0dkNwdEZDNVlxTnVPazIy?=
 =?utf-8?B?TFVoanBJTEo1ZFQwL001RzlUSjJEcWlUTlcxanBNZG9ldUFNYklVWndnSXhN?=
 =?utf-8?B?YzhmcGRYaEcrd1IrYmM1MmhCVGpqeXIzNjRDU21JbkRvU3kzR2dpNHdwcWlZ?=
 =?utf-8?B?dEdBOFpnZXdsbXZOYmV3UWJUaWc5WEVsbjhsTFBPa2I0bEhVYWswZ0dHSXhT?=
 =?utf-8?B?RmZpbE9rb2xnT29kWFZoK2RGT09oL084VHlKRzJKeldhZmJXOFBBTnR2cUpF?=
 =?utf-8?B?TEt5YnFKTW5URE5PUGVrcXExMys2M2I5Y0ltMm1KUHp3WlhTckRDWkJkYmxm?=
 =?utf-8?B?b1JrQWZEQmw3aWlHN2djYmhxZTB5L21OaEZsc1Bnb3pJS1JTa3N0QXpQYUpC?=
 =?utf-8?B?UDVLRG5MQk43OHBPYWdGOXYxU0dXZWV0RHozNmZVRUdJS1BjbHl5NVZ3ODVW?=
 =?utf-8?B?eHdsVURDdS84WlMwZ05CcXBCM2ZhS045QmpaTStSZnQvRTAxUElCd2Q1TzZa?=
 =?utf-8?B?bXArYjR0L0FJOGNlSE1xU3h6TmVEN3lxNkh6SjJSRG43S0pTMjBkcTBhRjBT?=
 =?utf-8?B?MTRVVnJlMEM2RENqVEM2K3dOVUlkVUpWN3R2K1ZydC9xSVBLSUc3QU5lN0Zo?=
 =?utf-8?B?Q25SbUMyby9iN3ZRMDFMUGp1WDhwQ05YYUpYVC80dWtzM3M1YWx1dFBMcmRi?=
 =?utf-8?B?dDkwRjFqVUVxclVzMks1bFdteEtRbTRKS3FBRklyMGtyQ0FVQWhoZjU4ZE1k?=
 =?utf-8?B?b29TZ2I3NVE1SkcvbHp5STlJbzVITWp3S2JhblNEcjlITG40YVhRMjU5UHNN?=
 =?utf-8?B?aU1iZFgvN2dvWHpiemZGZGFRZ1ZtS1Vvc3k5aG9lTmFlamNJUWNUQnFMRmEr?=
 =?utf-8?B?UE1UNnl0WllPVUJ1QjdpcGczT2VqZ3R4NzJkMWJKM2dkV3N5S1JGanFjcE9V?=
 =?utf-8?B?d0NmWWx4VytvR0ppRkIzVXhTN0lsMXYxT2ExdUFsbE1rNGF1dmMxeU54ZTQz?=
 =?utf-8?B?N3lXZ293RzBkQ011L3JXNERkdi9IYVErcEJ0TEdYMStaSUxiOVNOdWV4NkZG?=
 =?utf-8?B?d3V2VFpxdjlZL082djN5aFIwNnZUNWhRemxrYVBzN1FtbmdTZW9DdGJJbTBn?=
 =?utf-8?B?N081VTYxRmJhTHlMc2R6YUxaZkFrOGJBRlBSNWpoZ3hBVDNrVGUveGFJNEtR?=
 =?utf-8?B?WFpobHJabjMxWTBmVFNmQUNJNCtxR2EyYWwyT1RXcFdtZG5QZlJHaUFQK2lX?=
 =?utf-8?B?ZGxlUk9qZWFnTUJrM25RWkZKWmF6WDdEUkNqaHNpYVZ5cjVtTXNuNGM0alcx?=
 =?utf-8?B?MkNUdE1hQzhNaHh6YUM2NGxnYWthR0ozVHNmQU42ODVTMWRUbWoxdGpudjlC?=
 =?utf-8?B?MTViRkdLY24xTk05Yzc5RFJaS3NmdVU5VUQ4eCtTMmVBTTJIeERSaWlTWERj?=
 =?utf-8?B?ekdCSWx4NWoyckdYSUx6SDM5THdoRE0vRGV4R1dFMStPN0hVR3cra3lGMGh6?=
 =?utf-8?B?a0Fub0lnUTgxL1RUOXBpbUg3U0JMdmErSlVmcmxLd2FIaTRpTjJFVlBibDVE?=
 =?utf-8?B?NitkclpwYk4rQ25XY204L1FHSHNIdUlqOTZDejJnaDF3THErRjV6L1FTZFN0?=
 =?utf-8?B?Mzh3eUdPcXBoZGZKVHhiNlhjblJTUU1PczdtSVJndFdpS2NoTWRqT0ZaZEJC?=
 =?utf-8?B?bzd1VzN2MzF5UGROaVM3YjU0d3hyVVR6V2RDOXJ4dnNZcERPajRkUUxhUmk2?=
 =?utf-8?B?aFVYZDZHQ1ZKYUZVZ05iUEZVMEE4OVh4SlpVbmF1cytkc05HTDhsaFNPRTk2?=
 =?utf-8?B?QzhJenhyRFp6L3JMcGd6eHpTSnloYWxDWWpIVjZCRjYvaDIyMHlvdlJKQXV2?=
 =?utf-8?B?aytwZW5rT1VkOE1iUEJuczZ5WXYySUxNVWIyZ05va3FSYkxIUjczTm9wWkph?=
 =?utf-8?Q?xINxEGQ3QhDEuvraTLYznNZng?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a041b94-b75b-44e6-fe62-08dc1c10c9c1
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 12:42:41.1151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amFpSzx07SvLaJXQx4FvvW0iy6yFYL+92kMx8TX6DPeWw189fV9t5Q7Dh+k0voqN3BcreVMv8OwrGYlUzfOOuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P192MB1623
X-OrganizationHeadersPreserved: AS4P192MB1623.EURP192.PROD.OUTLOOK.COM
X-CrossPremisesHeadersPromoted: EX01GLOBAL.beijerelectronics.com
X-CrossPremisesHeadersFiltered: EX01GLOBAL.beijerelectronics.com
X-OriginatorOrg: westermo.com
X-Proofpoint-ORIG-GUID: QLhxHFVKc1dFucPSDOfY6PuMdykSsT11
X-Proofpoint-GUID: QLhxHFVKc1dFucPSDOfY6PuMdykSsT11

On 23/01/2024 10:55, Petr Machata wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
>
>> If you authored any net or drivers/net selftests, please look around
>> and see if they are passing. If not - send patches or LMK what I need
>> to do to make them pass on the runner.. Make sure to scroll down to
>> the "Not reporting to patchwork" section.
> A whole bunch of them fail because of no IPv6 support in the runner
> kernel. E.g. this from bridge-mdb.sh[0]:
>
>      # Error: Rule family not supported.
>      # Error: Rule family not supported.
>      # sysctl: cannot stat /proc/sys/net/ipv6/conf/all/forwarding: No such file or directory
>      # sysctl: cannot stat /proc/sys/net/ipv6/conf/all/forwarding: No such file or directory
>      # RTNETLINK answers: Operation not supported
>
> I'm surprised any passed at all, it's super common for tests to validate
> their topology by pinging through, but I guess it's often just IPv4. I
> think the fix is just this?
>
>      $ scripts/config -k -m CONFIG_IPV6
>
> There are also a bunch of missing qdiscs, e.g. in [1], [2]. To fix:
>
>      $ scripts/config -k -m CONFIG_NET_SCH_TBF
>      $ scripts/config -k -m CONFIG_NET_SCH_PRIO
>      $ scripts/config -k -m CONFIG_NET_SCH_ETS
>
> Regarding sch_red.sh[3], I worry the test will be noisy, and suspect it
> does not make sense to run it in automated fashion. But if you think
> it's worth a try:
>
>      $ scripts/config -k -m CONFIG_NET_SCH_RED
>
> Then there are a bunch of missing netdevices. VXLAN[4]:
>
>      $ scripts/config -k -m CONFIG_VXLAN
>
> and GRE [5], which I think needs all of these:
>
>      $ scripts/config -k -m CONFIG_NET_IPIP
>      $ scripts/config -k -m CONFIG_IPV6_GRE
>      $ scripts/config -k -m CONFIG_NET_IPGRE_DEMUX
>      $ scripts/config -k -m CONFIG_NET_IPGRE
>
> And TC actions [6]. I think the following will be necessary for some of
> the tests (we enable BPF as well internally).
>
>      $ scripts/config -k -m CONFIG_NET_ACT_GACT
>      $ scripts/config -k -m CONFIG_NET_ACT_MIRRED
>      $ scripts/config -k -m CONFIG_NET_ACT_SAMPLE
>      $ scripts/config -k -m CONFIG_NET_ACT_VLAN
>      $ scripts/config -k -m CONFIG_NET_ACT_SKBEDIT
>      $ scripts/config -k -m CONFIG_NET_ACT_PEDIT
>      $ scripts/config -k -m CONFIG_NET_ACT_POLICE
>
> Hopefully the above should clean up the results a bit, I can take
> another sweep afterwards.
>
> [0] https://urldefense.com/v3/__https://netdev-2.bots.linux.dev/vmksft-forwarding/results/433341/14-bridge-mdb-sh/stdout__;!!I9LPvj3b!Eb-NZpjOY2wkTb2sApNj0Hx-II6xvFO688SZN7feUAjC_6RFAz3dmeR3LzssrLqm_Kr7rJEalB7DvzQR$
> [1] https://urldefense.com/v3/__https://netdev-2.bots.linux.dev/vmksft-forwarding/results/433341/17-sch-ets-sh/stdout__;!!I9LPvj3b!Eb-NZpjOY2wkTb2sApNj0Hx-II6xvFO688SZN7feUAjC_6RFAz3dmeR3LzssrLqm_Kr7rJEalDWGO6rP$
> [2] https://urldefense.com/v3/__https://netdev-2.bots.linux.dev/vmksft-forwarding/results/433341/33-sch-tbf-prio-sh/stdout__;!!I9LPvj3b!Eb-NZpjOY2wkTb2sApNj0Hx-II6xvFO688SZN7feUAjC_6RFAz3dmeR3LzssrLqm_Kr7rJEalMVxxlTD$
> [3] https://urldefense.com/v3/__https://netdev-2.bots.linux.dev/vmksft-forwarding/results/433341/21-sch-red-sh/stdout__;!!I9LPvj3b!Eb-NZpjOY2wkTb2sApNj0Hx-II6xvFO688SZN7feUAjC_6RFAz3dmeR3LzssrLqm_Kr7rJEalMfr0cOk$
> [4] https://urldefense.com/v3/__https://netdev-2.bots.linux.dev/vmksft-forwarding/results/433341/27-mirror-gre-changes-sh/stdout__;!!I9LPvj3b!Eb-NZpjOY2wkTb2sApNj0Hx-II6xvFO688SZN7feUAjC_6RFAz3dmeR3LzssrLqm_Kr7rJEalP3lTojb$
> [5] https://urldefense.com/v3/__https://netdev-2.bots.linux.dev/vmksft-forwarding/results/433341/18-vxlan-bridge-1d-sh/stdout__;!!I9LPvj3b!Eb-NZpjOY2wkTb2sApNj0Hx-II6xvFO688SZN7feUAjC_6RFAz3dmeR3LzssrLqm_Kr7rJEalBLEoTPs$
> [6] https://urldefense.com/v3/__https://netdev-2.bots.linux.dev/vmksft-forwarding/results/433341/42-pedit-l4port-sh/stdout__;!!I9LPvj3b!Eb-NZpjOY2wkTb2sApNj0Hx-II6xvFO688SZN7feUAjC_6RFAz3dmeR3LzssrLqm_Kr7rJEalOO5rTam$
>
Hi

Probably also missing is CONFIG_GENEVE
81-l2-tos-ttl-inherit-sh check operation with gre, vxlan and geneve, but 
modprobes first if the module is actually available. If it isn't, it 
just continues and doesn't fail.

Also there seems to be something wrong with ending, see 
https://netdev-2.bots.linux.dev/vmksft-net/results/433200/81-l2-tos-ttl-inherit-sh
The test outputs the results in a table with box drawing characters 
(┌─┬┐├─┼┤└─┴┘)

BR
Matthias


