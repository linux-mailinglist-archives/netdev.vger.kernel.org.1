Return-Path: <netdev+bounces-167812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738E2A3C6EE
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 19:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC5C189022F
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928DE1F461F;
	Wed, 19 Feb 2025 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="awRCATdu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E281B6CF1;
	Wed, 19 Feb 2025 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988078; cv=fail; b=C6WoK8JI1Af8ZOy2+INiZX1YDqJ0G1clAafJWhQeOdq9z9PO5p38MYKH/e2V+K0hbAImXJSNuNvBUm6xzxvHNiZqOwyOEQxNVTgZTsQvGaTsj/77h3LyrSj5Ze/cFcPZRaAyMTTL+MpOcW++1YnChXLxNBwuKVmDUbKm4kBW1WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988078; c=relaxed/simple;
	bh=ttNkVFk6OcOyonNzg1MmiF9eaImPhUjsVxKz/fnCXj0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LclJEPuYcHVWm1Q+nASK7IO/Lh1pxtNsGKvnp5HC0SGvWydgW3N7BnHQCd3ktZdoqus27lNtjcS4jFwUIg2HfpG8BE/gEEzU0HmFvg1gRA8CRVO6GRVLB/VgClMX1GxGIBEY5TKpOthkVbeH4epkKRBLBrrixmp3W4mQ/3z2Mzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=awRCATdu; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JH0OeR005913;
	Wed, 19 Feb 2025 10:01:03 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44vyyujmya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 10:01:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teEpyUyFYO2ENbaB4f10ochv2JJhD7xhSa4aRkkDv616PS+AQh+PcdI2D0lXEWFHO7yHnVxa44q2cgyZ7MazFLVX/Z7F6OkGtVsAs0AnM666ebeVZ8lHhU2Q5fpDcjJzjkHiq74G0Wumhx5KZotcjes68E7q6Sk0+Be8VFErbxUhvtXesmiDmwVh2e/y62A6eZIl1JIlBxIgAGJbt5MIBdmfnSjeGKdfuYctzxabkuIaBNfYsoRVNoPw56hcm8+8Lwyb1GYgTky6LXiaSkSw/+2MrYkbX0MCLGM0EUN6Yoai7sd6dBn5ACa/Rkb+TkEO7FAFdc9qNMeVcilfJevnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttNkVFk6OcOyonNzg1MmiF9eaImPhUjsVxKz/fnCXj0=;
 b=ehOlowe5MVkMCmMUMn8jtNX4BiFs3ZA7zebdDyKADV/+gNZWlOvPsw51QtTBFZC/+NUket36OMRTKu9wlfYL/RDsaVuqUNluyf6w3ELZm/idk8B9j3dYnAqqqhFpxGwqV23V3+5TEmxvvVLOTaqvGRtFng/BxqyfLFephDLAwAmvUyqSwDhZ+6B3Ep2prRg2NJ4IFxlhL/pRo+5o4FUPIjwGvB/KbwGz3zDTUJyvK9YlmqCQCWSLD291XSsYDPrflkgkxOW0hftrg40ImG7xyn572MthSKQGuenDSHn1FJZX1JKfI7KgGEuhZEQ902F27Eun/vtK1H/FtqCwmSuSrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttNkVFk6OcOyonNzg1MmiF9eaImPhUjsVxKz/fnCXj0=;
 b=awRCATduUl0Ld1AYSh7KkV0kMieEPkL4nEClga4f2KUjBH5eSqLEACeMeXu5LCV5fQG1Bp8N+hnY7U25rfO5z7sAncYH5Cd3JWzvuuLBzfsnNFbvG92dmdkzOH+Z5qsia09MUySUhruMoNEiIg54aD+gCO/gFbfAACcjfn+JFu8=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by BL1PR18MB4133.namprd18.prod.outlook.com (2603:10b6:208:310::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 18:00:59 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%4]) with mapi id 15.20.8445.013; Wed, 19 Feb 2025
 18:00:58 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Arnd Bergmann <arnd@kernel.org>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya
 Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>
CC: Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        Sai Krishna Gajula <saikrishnag@marvell.com>,
        Nithin
 Kumar Dabilpuram <ndabilpuram@marvell.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] [net-next v2] octeontx2: hide unused label
Thread-Topic: [EXTERNAL] [PATCH] [net-next v2] octeontx2: hide unused label
Thread-Index: AQHbguqNmgE39JiK00SCXHPwrUbXVLNO6kLQ
Date: Wed, 19 Feb 2025 18:00:58 +0000
Message-ID:
 <SJ0PR18MB5216A3F2CB8D6EF286A7ED9DDBC52@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20250219162239.1376865-1-arnd@kernel.org>
In-Reply-To: <20250219162239.1376865-1-arnd@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|BL1PR18MB4133:EE_
x-ms-office365-filtering-correlation-id: a3245399-2f1d-4e5e-2e3f-08dd510f5d54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eU9ramtma2dWQU1vZzZGUG1OY0ltUHBRYjBIcndGQXVmc1NSbVdKbWFZSnBE?=
 =?utf-8?B?U2xvamFRT2JIYjllQmMyNDNXd0wvKzU2WEVTa3QwUTF5L2hka3V6QnJ0eVpJ?=
 =?utf-8?B?SkNuamI3MFVsOUdzQ2IyTnBkZSs0RlowS1RieXZaL3ZtTmZyN3FlY2w2c1lx?=
 =?utf-8?B?aDQraEg3dC9YazZZTDJPR2Rpc0FIYlhIMkNzWmVWTzVwRkxNczdEZytJTmVV?=
 =?utf-8?B?aFYzZHZvQ3dyWHFEUGZpSitSSnhRTStPZjQvNlRYZG5mZnd2LzBKekZZS1Zu?=
 =?utf-8?B?bHdEaTdIZGprRFJrSGRwdjBRbDJwN1lpU2paeXUvbzJuVmR6bXk5YnNFUTg1?=
 =?utf-8?B?bzczQTJPSVB6UktyMWs2Y3dLNW94SDdtZnJRYmR3RzlvY3RZSVdjNk1qYWRY?=
 =?utf-8?B?c2Z4aTdUV1c2alJ1cVRxdjlCRGVUcGVzditHbGIrSFhYcFE5dmJtTzQ3NlN6?=
 =?utf-8?B?c0pOUE1YS3h1TWVnQ3JzT1N3QVF6UEU1SndSYlJtQjI4R25ONSsyREgvS2Rw?=
 =?utf-8?B?Q0VodnJvK3dta3lNNENyWmdKdEljYmFVZE1lZUVielM2SmYzbVNheWdSbTdh?=
 =?utf-8?B?M1h0TUNncXRpZ0NEeUxxdGYybm9BMWhNWWJPU2Y3VmlYYmdMWnZMZmVyZ1A1?=
 =?utf-8?B?d1hER3BxMGVLLytJZXl3RjFRZ3ZhUkxKaWRvbFNWVWlDZW1sTXpDVVhGNUlz?=
 =?utf-8?B?Y0E4RS85cXhYRDUvbzB6ZVNEYzlEOUhYcHE3ZytIV21TWkMwYkY4SS8yRUhO?=
 =?utf-8?B?akU1LzdlRGdOcnRRTGRxSS9NaUNBTzVpU3EybXNqTmpaOHM1NjY4K2JCak8r?=
 =?utf-8?B?OGxESllLS1d2K3hlYTFpdU1Yc0s0dGRyK09MSGkxM080QUY1Um1wUU5UbXNY?=
 =?utf-8?B?eEIvc2x2dnBvUUVsUUNNdGtEMW55eHNqQ2phUVJkVjRrUUtQMjBHaGhyRlZU?=
 =?utf-8?B?NVFoZXZmc0gxajNQbERtdDd5TUlZV2JGUklQSTlaOVM5VGQ3MUhmdFdtSTV3?=
 =?utf-8?B?amVCdTd1emFWdmUwSUVoSFhpd3l4N25aSWtnS1I2WFNZdFdJV3VFaUdQOEdq?=
 =?utf-8?B?ZHl3ZDlDaGszUDA1TTdwZUhOejEzcDJETXZFTGRNL1g0YTR0OXdhS3V1b3d3?=
 =?utf-8?B?SDFiUGRHTExBQkJnZStLYjZLMVQ5M0hnU3pTckpqWjFLSko4L24rdWlmRVVT?=
 =?utf-8?B?UnBTWTNrc3d5dzF3WEZyWTFOcWl5Syt3UW9FMGJOOVRyM2F6ckJqRE9xa2ZM?=
 =?utf-8?B?YzZwdHlWYmxQMGtIakppRkR5YkRnNThsWFhjcVJqRVc4S1hGSWx3cjBvZE9N?=
 =?utf-8?B?cDVDcHo2NnE5ZThzaVkxQ2I1aUdaUDdpaXNqVkhCL01rNDBOMGlWUitZeGJn?=
 =?utf-8?B?VVRsSUlLVWc1YldiN29oenUxc2Y5QzU5bEEzbktzOTY1NmhBRGxJVFJiY09t?=
 =?utf-8?B?M3BTdXhNeGkrcUpiTFM1VitGU2Q2Sy91czlpZ1lZNkNxY0dQWUpyYVZtR1Ft?=
 =?utf-8?B?RGVSUTNnM1R4cEo0SUswK0J4Vnl1bnhQSkhWQzdrMDNwZ2tsYWtBUjh2Mm4v?=
 =?utf-8?B?YXA2UUltVGJIS1B6SDhtOUN4UG5QOUkveFlsaGRIQ1RmT25HTTd0TlJKdkZh?=
 =?utf-8?B?TEp1b2QrcHZjVEpiODliMjBpTzlPQUl1ZE4rMDBCSWthMjE0OWlMSGRRL25L?=
 =?utf-8?B?b1d4QWE2WDlSMWthQTFjYXd1OEpCUVFtZGZ0eTdGTGJBRUsxSTFKdFpEVWs4?=
 =?utf-8?B?OXg0RlhiSGV5NmEyMVhIM3JlSDJFVERJSWM1UVRxL0trdXR5WHJxVDJlZG9S?=
 =?utf-8?B?cVBBM2hnMU1RemdPNmQzWlkwVGZLVk0xV0sxQTNGUmNYS003K3hCMXBWOHRX?=
 =?utf-8?B?WVE3Q2tKZGFndlNhTTloZFI0cFI1VlJrMHJRY1BodUVuWWw4R2ZFTGxNNkla?=
 =?utf-8?Q?VXviMhE4+oDvyZbMgfgJz5i8YvRiytlN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXlJdWIzZFdKeCtXMkpKa0d0OXJaQ0I2RysvZytDdk1jWGNXalhYa3ZYVStK?=
 =?utf-8?B?TW1aOTBKQTNlN1UyN3JNTmJmZXhMWFh2RHczWHBFbWpWeUR6RHhnTWNLYlpz?=
 =?utf-8?B?L0xMTDlTVWlwWGRVR2ZMY0pmMXRtQ08yNE9hUFNJNmNLaXQwbEFNa291blJz?=
 =?utf-8?B?NjlmVTdpUC9rcUp6ZUhySll2aUxwT0FkSjF1UENvSTNCN2RpY1p2eGdDaTFI?=
 =?utf-8?B?K0txdFBrRFRuenNoQXE3eVdFZmN1Z3JWR1BhckZTVzNVT0tEdUVFRk42dW9p?=
 =?utf-8?B?K2ZXRzZiOFVZMkZCWkt6eTN5VkpEOXZNZzBVeFhSZFVjaWl4cnhJZm1nUURr?=
 =?utf-8?B?ekhxd1pVU3FDR2FsUmJmVmNCVE1nK0t0UWJYWU1QRUJ3MjZ3TkVWQUJkMlpv?=
 =?utf-8?B?VklzQnB3bWt4YSt1SlB0UVhyV3ZCbEFuQzZRZjdqNHFGWEE4ZitPRUYvQ3NN?=
 =?utf-8?B?R2cvNnBGNWFLbDhWdEY0OTFLT2hyamIzWmJWVmJMQi9MalBtWWJNb1QwTllT?=
 =?utf-8?B?SUtjeEp2Y1AzVmhPSnVrU09PSUJqS1F3bkxidldKKzRLc01oZ3J5b3Q1YmtR?=
 =?utf-8?B?MERnWmdncmdmcFIySmZ3eGFad1k1L2VUcURINklFc2lKVE83cWFYRU0wMnAr?=
 =?utf-8?B?NkJWWE1hM055S0ZIVE5JS25vWE9YNEJWdUovbmdVWEpBQWR2U2xZV2hJNWV0?=
 =?utf-8?B?L0dOUU9wWG5aUG5kV0M0SXhvRDVET2dwWFZZNUxHOVFkYUp4blJtZWpLY3BR?=
 =?utf-8?B?eXFVd2tJM2NoUk9wRUJrelFTVnI0WDFadXIzbjVwanA0ZmM1VWVQNnFyKzVK?=
 =?utf-8?B?bnBkOTFDT1h3RGVrcWhFOWpVQ0wxNVZ6LzJOaTVQRmpIMlBBbGNRRWh0QlpN?=
 =?utf-8?B?b0k4bWRRcitoRFd4SkxURWxPVi9HUHFWRk53OWg4cXZpZTdQWThvUnoyQnph?=
 =?utf-8?B?eWNiOXA4REl1YndycGpaZ3VpSzdkRG1ZSHcycERXd0cvell6aFoyVnBldmpK?=
 =?utf-8?B?dTJZbk9aSlBzdHR4Mzl5c0NjSDFyTU8xTFVwVko1VnNGSVNxK0dEVlRYOWtR?=
 =?utf-8?B?ZjZxdWszSGVwYnk2TzNyRkFCZC9UREp1OUw0aXJNNzUyanlabTNtbWJacUV0?=
 =?utf-8?B?N1VkT1NTc29BUi92S2RjMFJtcEdnbjJOSHhyWEFEQXJZLytLVC9LU3V6VW0y?=
 =?utf-8?B?NE5PREkvZVZBaFhQOGVWdlMzZ0RGSXpDaTladjR6OXVzOVpZTTFUS29TTXJi?=
 =?utf-8?B?QXpCakU2UWlHSDY4U3d1N3VZMXgvK3Z5NWtRRlcyMGZydDVYUjk5a1VxZ0sw?=
 =?utf-8?B?WWxPUDZaRmxOeFVwZDhhMW5jc3BkSUFFa0dCTGxtRXNWVnBlUnlWeXNkM1FV?=
 =?utf-8?B?OXN6dHQ3WkR1UDRsUXBEU0F3d0s0M0wzVzc5VzRTWGlRSHlKeUFRSTN4Tlc0?=
 =?utf-8?B?eFdhd0dzaG9XVHVHT2ZFVjJJM2ZldU96NU0yOERXa2ZqSVM1T1FhdldMc0tK?=
 =?utf-8?B?eHo0alFKMlJFdlRNdlFCQXhRRll6ZHZ5MzBuUlVlNTBMeGd4NHpsMzJ1Y3E5?=
 =?utf-8?B?WHhyb1orVkc4WURBVS95T1ZLajhETEJwc2dYMkprQnhDeXlmbGN1VVpiWFlV?=
 =?utf-8?B?Mko5WmpienR6NFNocmV4ZTRpTHBheXhicGtlTk9ZMlRqSTZiUU5CS2kvb1Ni?=
 =?utf-8?B?cnpCS0pDL0Z0Uk5kTWZncjk2ZXZ2by9GNHNISGxaKzJVakhmczFPdkp5Z3FX?=
 =?utf-8?B?S0V3dHFoczR5WTRhUWZ3SEhPYXlJa1Z3K245S3plUmtWUEVsNHRzUG5hWGEz?=
 =?utf-8?B?N0tUM1hwSFF2N0lKZXI0dERCai9uVElndVF3cklDY3BUOWw4bFpMaFhWNVdU?=
 =?utf-8?B?bzNSVDJ1QVp4VXhVZGpPMVJjb0VXZ3NFSXdJRXgwajIvSWJtQ3pTWTIrL2wx?=
 =?utf-8?B?STJ4SHR4WXpEWGd4NkZ4MlZuSWVmb3RFei8wQmpua0NPd3o1b3MxRUZTNXpY?=
 =?utf-8?B?U3d3NEdsaXBoU3F6TUVSNHB5b1FWeFV3eW1CZkNTSXFQOGlES0xROWhmWXhw?=
 =?utf-8?B?cFJwQm9rRXB2MVBwWHNqTVpKV050M0svL2pRdEVkTGJjZnBPT002UlpTTWU2?=
 =?utf-8?Q?rrZ1UafwoTe6Ix15oZlWFmVIG?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3245399-2f1d-4e5e-2e3f-08dd510f5d54
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 18:00:58.8417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fyj16O+3YYxMG3pYPbr2SKnspCbSrlyMwpbv3LXaGEYNCrJ7yomO+tgj7+KlqNnaAD1AZ8+t/JS/TFoV0M91lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4133
X-Proofpoint-GUID: ywFwzrTcHbzwlPrYaeQoIk6eyAcvmA49
X-Proofpoint-ORIG-GUID: ywFwzrTcHbzwlPrYaeQoIk6eyAcvmA49
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_07,2025-02-19_01,2024-11-22_01

PiBkcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9wZi5jIHwg
MiArKw0KPmRyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3Zm
LmMgfCAyICsrDQo+IDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+DQo+ZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3Bm
LmMNCj5iL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3Bm
LmMNCj5pbmRleCBjN2M1NjJmMGY1ZTUuLmNmZWQ5ZWM1YjE1NyAxMDA2NDQNCj4tLS0gYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9wZi5jDQo+KysrIGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfcGYuYw0KPkBA
IC0zMjE0LDggKzMyMTQsMTAgQEAgc3RhdGljIGludCBvdHgyX3Byb2JlKHN0cnVjdCBwY2lfZGV2
ICpwZGV2LCBjb25zdA0KPnN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkNCj4NCj4gCXJldHVybiAw
Ow0KPg0KPisjaWZkZWYgQ09ORklHX0RDQg0KPiBlcnJfZnJlZV96Y19ibWFwOg0KPiAJYml0bWFw
X2ZyZWUocGYtPmFmX3hkcF96Y19xaWR4KTsNCj4rI2VuZGlmDQo+IGVycl9zcmlvdl9jbGVhbm51
cDoNCj4gCW90eDJfc3Jpb3ZfdmZjZmdfY2xlYW51cChwZik7DQo+IGVycl9wZl9zcmlvdl9pbml0
Og0KPmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9u
aWMvb3R4Ml92Zi5jDQo+Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9u
aWMvb3R4Ml92Zi5jDQo+aW5kZXggNjNkZGQyNjJkMTIyLi43ZWYzYmE0NzdkNDkgMTAwNjQ0DQo+
LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdmYu
Yw0KPisrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgy
X3ZmLmMNCj5AQCAtNzM3LDggKzczNywxMCBAQCBzdGF0aWMgaW50IG90eDJ2Zl9wcm9iZShzdHJ1
Y3QgcGNpX2RldiAqcGRldiwgY29uc3QNCj5zdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpDQo+DQo+
IAlyZXR1cm4gMDsNCj4NCj4rI2lmZGVmIENPTkZJR19EQ0INCj4gZXJyX2ZyZWVfemNfYm1hcDoN
Cj4gCWJpdG1hcF9mcmVlKHZmLT5hZl94ZHBfemNfcWlkeCk7DQo+KyNlbmRpZg0KPiBlcnJfdW5y
ZWdfZGV2bGluazoNCj4gCW90eDJfdW5yZWdpc3Rlcl9kbCh2Zik7DQo+IGVycl9zaHV0ZG93bl90
YzoNCj4tLQ0KPjIuMzkuNQ0KW1N1bWFuXSBUaGFua3MgZm9yIHRoZSBwYXRjaCwgbG9va3MgZ29v
ZCB0byBtZS4NClJldmlld2VkLWJ5OiBTdW1hbiBHaG9zaCA8c3VtYW5nQG1hcnZlbGwuY29tPg0K
DQo=

