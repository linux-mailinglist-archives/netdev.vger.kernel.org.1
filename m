Return-Path: <netdev+bounces-146382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3067A9D3365
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 07:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36891B21B61
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 06:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F94156677;
	Wed, 20 Nov 2024 06:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="gQiK8Sp7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807C827447;
	Wed, 20 Nov 2024 06:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732082652; cv=fail; b=AlCXFRddwIozPJwYBiZJ1zeRdBl3M875+ecA9/4r4Qs3uu8AH1lOGE/pA866g7Dj91rNCln+EP4aelbSt/Icai63RFewlPBkDp8rJUXLPsMAyzV6IVj2burt1dOPjJE5ihUXiyn2sq62T/213EdpPhB3fJ3rP3yrWDSmuyIW8pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732082652; c=relaxed/simple;
	bh=5ayCGR5nvC1dTXPq0H47TzZJXAltlgB3DP+kaAGukvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q6LrLsT4zwvVMuvHXjdOiFWkhXJvXvfSdcbkSLJPx9PJK17qfibuMir4Z3mFSrSHDYs8eRhOB7Ajd3GvJ7Hwpq85wS4Z+Ad5B1gj6Qhb7W0hsDJ+JcEw/+4EumGuw7Md9zYwLMFP0UF6RufpFnobgT+3qebORNQJ7PT+gFe9Zwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=gQiK8Sp7; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJNOs94025508;
	Tue, 19 Nov 2024 22:03:47 -0800
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4313t10uk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 22:03:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5Bm0HwTknKbutaahcSyo7JV8xRZOKzHs7U+CBTC+bqle59JWw/YJCZc/5/XFPN1WcBLDaBb+UJXvHpQ+0ITYfpVXt0E1a09ibTEgnJLkofHNlkiVi3CdBgMUnmA+M+QbNaJxmZ1NkMxKCSPOHKdPqMe9z7ETO9ijuikEKyoKFi1YSqgRS8K0DMvLIsnGYVbTamfVSFFLil/wgQFQcVwg6MEyXVT/OqIuspt0eEbqMfTIHa+6jSnVMU9jqBZplnX5vwONSP1bVkdd5zUeHn36v+JdELqjslXReBHKQjAe7mHJ1uj+MPM7lmeWcCPVVh2PSbCIZtXxGiHQvtIA0F+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ayCGR5nvC1dTXPq0H47TzZJXAltlgB3DP+kaAGukvA=;
 b=stuLKl1fbsb3xOipFs0N6nauX+K0paRwWjfQrcBZLdPzstVeYYOa+ne7GD61xzjhQNAKQ8oaOD9GOW/6I4UN2fxux3YlF1JKjn6wQJuQlpNj5QHd7pShxbaZC/upTTAU5b3PET1fF6APGqDlW6whUCX4NH0X/KFeWpFJQendPaA4oXRc/uKEHLCj6uUQ7rRzTj6/3zQkufPmBhEAV/TPOH+Fj+ZJ/EzSPLo+IlPHmXktL8uLIZRT8Kqhmi/WbD52CI2XkGxkCbh5X9SnVWsIgAczjAFKjfnORkFDyOLjjYgps2CDdxCvxUrwP22I1WSxA3aPKqMlnYzUDsZ2YiEEGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ayCGR5nvC1dTXPq0H47TzZJXAltlgB3DP+kaAGukvA=;
 b=gQiK8Sp7K6gz4aeMM9o2trOzyhPZnOJO800MjtvYBoxVfpnh9aLzp9M3qZy5zQFsk2ok0uIHYmdFpRpaY08zOLdJi7zNJ6CEnvoc87hMD3pVWaPEEHSaqUc9SIGydZrRvkj1ayKvEcb0ssErf9Ks/3VHO3Qwlu2Fw1GX4XUCRKA=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by LV8PR18MB5914.namprd18.prod.outlook.com (2603:10b6:408:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 06:03:44 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%6]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 06:03:44 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Linu Cherian <lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [net-next PATCH v4 0/6] CN20K silicon with mbox support
Thread-Topic: [net-next PATCH v4 0/6] CN20K silicon with mbox support
Thread-Index: AQHbOxH0IlDC5YGJRUmXUJOW7MirRQ==
Date: Wed, 20 Nov 2024 06:03:44 +0000
Message-ID:
 <BY3PR18MB4707EE231F8A9C37E4B7915AA0212@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20241118150124.984323-1-saikrishnag@marvell.com>
 <20241118173848.41a8060b@kernel.org>
In-Reply-To: <20241118173848.41a8060b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|LV8PR18MB5914:EE_
x-ms-office365-filtering-correlation-id: 430eec94-fabc-421e-e02f-08dd0929171f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmR0bkpqejB1cjF0Snd5eVhzTnhFWkFqcHhvd2M4RVR0QmlodFpsdXVkc1Zx?=
 =?utf-8?B?MlZ5cVQ3OTNSRHVrYTNFMS9xbncvYUVqcFE3UlNCV2hEVnFpSUJCbTVNeUZv?=
 =?utf-8?B?OElPd3BoRGlBNkxLYVFpU0c2RUZXNjgzWEx2b3RnQ1BaazBlQnJYaURlUExG?=
 =?utf-8?B?TEs3b29YVEozSUdqcnlleE1UdjBXRVd2ZVlOYVM2ZzlxcVFUUSt0OTh2M253?=
 =?utf-8?B?djQzMG9JWG0vbjJkNHUyTWJsWTNuYmo3aFlUc24wZnBHTEp6Nk5ESVErdDk1?=
 =?utf-8?B?N1Iwb3VkM3FGMTd5a2xFcVdadHVrUTNIWW96dmZIM0dEeHdPNytvMHVhZEs3?=
 =?utf-8?B?UXFYa1JTOXdNbkpKbkhYZUxLS3RTNjRYZkV3VVUvaG1oWUl4UEdCTWc0TWxK?=
 =?utf-8?B?eUtvVkxzSEJFaFNmSzBoNTgzcGNXb0hOQmthU1JaWVVud2wwSXZRSW5ycDJB?=
 =?utf-8?B?T3I3a3BoblFnN3V0NU9mZHRLQWNkdFFRdGp2azJJRVo0ZFlmSm9uZGJ6Z2lT?=
 =?utf-8?B?OFJxREFSSEhFcTRxYmNacmdMQjB2K1pvYU8rZytGOHBIaCsvSkdkK0F1SnFT?=
 =?utf-8?B?WFEwdmVreDRoK0tIVnV1RGUyalZWWndZa0hzd2xXTDFyVFZCL1QvdHpMV0VY?=
 =?utf-8?B?Ylk5ZzNpL0E0SlVIRUZML2tRbEovQ3luNjdCbWpac0wvalpmK1daTGQ5bUxu?=
 =?utf-8?B?VVNHVXdpaVIwcDJmdDQxWTlQQWlEdjlpbGJaM295OW1OZ0NzakR2U1JwalIv?=
 =?utf-8?B?OGFJTjI1SlF1ejV3TkpIUFdQWkh2OXdPTERjcUFraHFjUktKY3N0WXNDQW5q?=
 =?utf-8?B?SDBHNlljbkZvMVgyeUk1MndVT1dCbHFiVm4rSzhPVEZHTkJMMWV3YWdvYkwz?=
 =?utf-8?B?M21pTS9BWnFhK0FpRUpmOWNEakI5OWxybWVlVC9pL3BKMnVTdTQ4NUVYSjZ4?=
 =?utf-8?B?MjUyb0s1cHFUN05QZzFtSWM5SHdmUEo1SW1tek5YZ1ZiU0I0aUR6TmhNWU1z?=
 =?utf-8?B?SzYxdU5wbGNWcThWL25kVHBCSXFLTHFIUzJYNWdrL04xTkQ0QjB3b1Y0MU1o?=
 =?utf-8?B?WVhBalM4RkFHdWprWkNyb2RsdlZxaGhqYllwMi9ZdlZEYUUrUGY0TCtPKzNF?=
 =?utf-8?B?ZDRDY0MrZUhPNmpvVVJGdWNmQ1dQWWdpeFdwZVZObVhqMk56R3dSSEFEaE5Y?=
 =?utf-8?B?ZUVFVXJkbUl2RHAwTERRWTNDbzlLeEpMVUJKQWhGc1FsMWo2eUtpeng5K2I4?=
 =?utf-8?B?ODdScnM3Z2pEYmVIV0J2Y21tYWEvNFBYbE5UMkQxcm4zM1FGNWN4TXM4UUY4?=
 =?utf-8?B?dy9DZi9ZQit4VVRmSG5qMi9kMXNCM1hrRkpMZ2ZHVjR1SzcwVlcvM0syQ3R6?=
 =?utf-8?B?SGVEZlZqMCtMQk5pR1JxVkY4ZXRrTDIvdnlNS0NmM1d2cmlEaVlaQWZuREtM?=
 =?utf-8?B?aWtmQVB3STFSZzlJZm5CK2g4NlFRMUt1Sy9YMElNMWE4UGRlbk5QRFRnWUQ3?=
 =?utf-8?B?NHk4NXJaZ3JJZDJmalRaQysxMGxneERMVlBTL2ZtcGFUWEZ2Z3dUVVZUR1lR?=
 =?utf-8?B?emlaUDVVRjdtbEx6OWJiTjJhNzhmOHdSSElpWGdCRWxlNS9jN01sNThHdStE?=
 =?utf-8?B?Si92eU83SXBmcUJOeFpNdE5LOWVEOXhRanJaK2U0Qk85OUlNcGVWVGttSTJV?=
 =?utf-8?B?MGpEWXNDbkJrZkJEMitXL0l0OGtWQlRGbHkyREZHNVhBMEtRQVorbGxXWHVH?=
 =?utf-8?B?QWpqV0hKNVZjSk1id256YVQ0TWpsS1FPU0JneU9GVmFKZjhPZkYrbXp2TDEy?=
 =?utf-8?Q?qnvye+SgOCc+dk+MM64Dtq1DcDbioyjYZJmdY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGt1bkhVRnVoQ3g3VkUwS1ViUWlHTlZwdGlBLzhLcEhvWmRManA0Rk1Ua1hh?=
 =?utf-8?B?SUx6TWtCZjhGaEptTTdyWE10eE5qb2kwUjBBSlJRcnJZcjMzOEdiNlc5Sjhn?=
 =?utf-8?B?QVE0OFpsSG9JYmUxeDFZNjJIUWxBci9GdTZVczhUWmJVUW9ZQ2IrS0piUEhE?=
 =?utf-8?B?cUo3bVlXejdaWkdDa2NObVVSVHluQS9BNkNsUEdQcnM3cEpNR1BNRHpVTUFH?=
 =?utf-8?B?UHdwUEh5c21SbjdCUTROdG9nNnNVa2NHa0lxdkF4UlNzL05JN3A5WmdpNERK?=
 =?utf-8?B?cUtUWU5IeU95QzFvb2pMbFJzODFzWkh6ekRTcWM0K0dEOHBxN2dhVHJHWEJO?=
 =?utf-8?B?UVRyb1FMeWtpdHlEZENmSjJPMW1xVnJIMEhWeXgzenRVYkpMdDQrY1VDeVpW?=
 =?utf-8?B?b1E2djgyRXJwZk4rS0V5ZE1kODVKc3oxd2l2bWdyd2dZU1N6b2dGMjZTQkVY?=
 =?utf-8?B?K1VJNnBhUUpQRjVBK1BDMThUU24wR3o1NXZxbVltOWxHQllheTFJaE83cDIz?=
 =?utf-8?B?QXFsd1BiTkRTajl0VFBKR2lsL1pTQVZlNmhyMnNUVUZzWlVvVC9PcGI2NEFn?=
 =?utf-8?B?M3p3MWVOV1BjdGdaREIzeGNxL1kySmNHbk9HUWMvWTRCeEUzRmNmdGFXaTdV?=
 =?utf-8?B?d1puVFlzTGNSSEUwdFJwWnNmd1JnNmRUemhYSWd5d3UrRHRGU0M4OCt5K1hZ?=
 =?utf-8?B?SUdYcHAwaXJNQVBoMk1TM1RSTFJKMzdwdk9pcWpiUWZUa2lKL1dNb1hya2Fx?=
 =?utf-8?B?TFBZVnl2eGthdG1RdGhuQ0NidkRZTVp5WjBmUDR2eEg5YitlRmNrTGJtTGdS?=
 =?utf-8?B?V2UrTmhFQ3Bod0xOcEZYMUNydUFMNVdMTDhxTTRZQUR4eTBKWTZTYzBNMmVh?=
 =?utf-8?B?aUl1YWpSSHB2bTVCUWdVcUxRVm16a2FpbXdKS091M3p4YkFCUWhPVDJVZmgr?=
 =?utf-8?B?NmY0VDEzeUpsc0R5dDlNenBNaG5CRUVPTCtjNG9xby9TdmJGdmlTMFpBaW9t?=
 =?utf-8?B?Q09lcXpLWU5zV2VLaC9MakJEdFVSYk1KTzh2Z01mbkNScUkyNlhGbFlOWGFX?=
 =?utf-8?B?TlpOOUZjSmZJZ2syK2p3Sjk2bHByQXdpYlhMSFkwSDArVzZrVlZ2QWtheHhQ?=
 =?utf-8?B?Wk93Qzg4ZzB0dWQyS1ltQjFpTDRqY3UvaEcxWUZaMFBRc0xLOUZJSjVUVWtR?=
 =?utf-8?B?T0NTWWlwUWtrcDFPVENya1BLS3hXZSs0TGFIckVxWTNhSzZGa1hDbVljbGRR?=
 =?utf-8?B?MVhZeVBqNU5Kd2poYWZ3c3prNDRVS1didDlTU3NpRkd2WDZTeFNtRmFZVldl?=
 =?utf-8?B?cnlFS1c4VkF4M1dCUXZDYW8rdUwrQTNUQy83czU1eU1kR2pxT2xsV0VjSVlI?=
 =?utf-8?B?SHFhc0twN1dxMDN0WEtvanloZzhWYkpkL0xrM3h3OS9Ddm9hbkZLaEtDaE5L?=
 =?utf-8?B?T3F4UndoeU9kTEptWnQvc2lla09GaGJyUHBpN25UaEJYdWsza1BNdkQ3V1Jw?=
 =?utf-8?B?WTRnMFI4bmhEQ01kKzM5TlJISDdnKzNMRmVXcmlnbEVkMWg0S0hOdTRKS2Y0?=
 =?utf-8?B?ZTdmUGJlazRRRFU5THcxa1BKUTl2TFBXa2J6Z0lDTmlQc3Bva1l2Z090aDBx?=
 =?utf-8?B?dy9SRHEwNVdRQ3lsNEdJL2p1Qkd6eUZvM25xUXFvUHJ6QjJxOUMzVGhLSm41?=
 =?utf-8?B?aG9EalB2anRpUGhUejVVNmpvV1luWDV1b1pGRktMd0R2NzVvU3VoWWdVc2hB?=
 =?utf-8?B?bFc5VUdxZW95bjN2SWRPem5vOGdadFdQRXZYSURGTWZHdXc5amdpc0hhRzBP?=
 =?utf-8?B?ci9ZeUk3QzgvQll1WTBma2wwR1gvTTMraXh5SEpDS1E1WmtEd0Y4YzFod2ti?=
 =?utf-8?B?YU8zRXFxV1NudU9kQm9RQXpJaEZaL09qYzBLN2FuODZGaUV3UXVKZFpTcStp?=
 =?utf-8?B?YjZEcVA5Qkl6ZUgxY0RFM1Vpb0RQVGJJNTVsNUV4YUpRRGRsN3gyOHAzRUQx?=
 =?utf-8?B?UC9OLy9IdVB0Wmp1bExTWlhmMzNQOXFJK2RucjNVQ3VvR2RiSUVSUkxKazdj?=
 =?utf-8?B?Ty9PN3VuU3U0OFdsR2I1a0xpWW4xQ2MvbzlvYnNhYWFxeWVTVlhQblR6N0JR?=
 =?utf-8?Q?lNlBImRmexSx+O2yHygCy2xAo?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430eec94-fabc-421e-e02f-08dd0929171f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 06:03:44.2214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1K3JuPcWOdIPB6DTvWcy6BuHUU0BlQ1VGRcexHcs/qXa9tr2rfTbXuE57Tb5bIRee9Q9sSD0GZ0XxQ0+ii8M6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5914
X-Proofpoint-ORIG-GUID: hdkjWmAF8ndVrsCPGXt2Y2yxm5_1ei-G
X-Proofpoint-GUID: hdkjWmAF8ndVrsCPGXt2Y2yxm5_1ei-G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxOSwgMjAyNCA3OjA5IEFN
DQo+IFRvOiBTYWkgS3Jpc2huYSBHYWp1bGEgPHNhaWtyaXNobmFnQG1hcnZlbGwuY29tPg0KPiBD
YzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgcGFiZW5pQHJlZGhh
dC5jb207DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IFN1bmlsIEtvdnZ1cmkgR291dGhhbQ0KPiA8c2dvdXRoYW1AbWFydmVsbC5jb20+OyBH
ZWV0aGFzb3dqYW55YSBBa3VsYSA8Z2FrdWxhQG1hcnZlbGwuY29tPjsNCj4gTGludSBDaGVyaWFu
IDxsY2hlcmlhbkBtYXJ2ZWxsLmNvbT47IEplcmluIEphY29iIDxqZXJpbmpAbWFydmVsbC5jb20+
Ow0KPiBIYXJpcHJhc2FkIEtlbGFtIDxoa2VsYW1AbWFydmVsbC5jb20+OyBTdWJiYXJheWEgU3Vu
ZGVlcCBCaGF0dGENCj4gPHNiaGF0dGFAbWFydmVsbC5jb20+OyBhbmRyZXcrbmV0ZGV2QGx1bm4u
Y2g7IGthbGVzaC0NCj4gYW5ha2t1ci5wdXJheWlsQGJyb2FkY29tLmNvbQ0KPiBTdWJqZWN0OiBS
ZTogW25ldC1uZXh0IFBBVENIIHY0IDAvNl0gQ04yMEsgc2lsaWNvbiB3aXRoIG1ib3gNCj4gc3Vw
cG9ydA0KPiANCj4gT24gTW9uLCAxOCBOb3YgMjAyNCAyMDrigIozMTrigIoxOCArMDUzMCBTYWkg
S3Jpc2huYSB3cm90ZTogPiBDTjIwSyBpcyB0aGUNCj4gbmV4dCBnZW5lcmF0aW9uIHNpbGljb24g
aW4gdGhlIE9jdGVvbiBzZXJpZXMgd2l0aCB2YXJpb3VzID4gaW1wcm92ZW1lbnRzIGFuZA0KPiBu
ZXcgZmVhdHVyZXMuIFRoZSBtZXJnZSB3aW5kb3cgaGFzIHN0YXJ0ZWQgYW5kIHRoZXJlZm9yZSBu
ZXQtbmV4dCBpcyBjbG9zZWQsDQo+IHBsZWFzZSByZXBvc3QgDQo+IE9uIE1vbiwgMTggTm92IDIw
MjQgMjA6MzE6MTggKzA1MzAgU2FpIEtyaXNobmEgd3JvdGU6DQo+ID4gQ04yMEsgaXMgdGhlIG5l
eHQgZ2VuZXJhdGlvbiBzaWxpY29uIGluIHRoZSBPY3Rlb24gc2VyaWVzIHdpdGggdmFyaW91cw0K
PiA+IGltcHJvdmVtZW50cyBhbmQgbmV3IGZlYXR1cmVzLg0KPiANCj4gVGhlIG1lcmdlIHdpbmRv
dyBoYXMgc3RhcnRlZCBhbmQgdGhlcmVmb3JlIG5ldC1uZXh0IGlzIGNsb3NlZCwgcGxlYXNlIHJl
cG9zdA0KPiBpbiAyIHdlZWtzLg0KQWNrLCB3aWxsIHJlcG9zdCBvbmNlIG5ldC1uZXh0IGlzIGJh
Y2suDQo+IC0tDQo+IHB3LWJvdDogZGVmZXINCg==

