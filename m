Return-Path: <netdev+bounces-119203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A97F954B31
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 15:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED0C1C2245E
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 13:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312DF1BBBF0;
	Fri, 16 Aug 2024 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="FNKguG6N"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D58138F91;
	Fri, 16 Aug 2024 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815415; cv=fail; b=i6wNMVq7Z3eJjijg4oktSbh7ebCA9wB0bAbGspAq7yy99E8K1nkWdH+LgcC7Av64C1+DlM14fiJgNNjgPGopgktDs4aX9rHJ3n5ZqlaZkahGYZ9jF5ecTLtjiT31WaF6v8wPgLI3i2ZNVJOBh1K+l8IQuBEq3Cc/GVydSLCfmmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815415; c=relaxed/simple;
	bh=ZX6HLlsOE1o4dvgxOG/5oljcydr5ZnhMY8Ef9W9OXMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fi1bCY2QDaEsjT4LBQ0OimsHkNgBAdtxE2s/OBXVNAYaowtuUM4Jx37PJCuD22EgQX+4ne+J2ErBsq7MjE4Q7bvMdwnv6FvZXQFbgo9XBdQ6y1ypiiU7kePLaLA+qeDs3sTank0Mwi3Ilph5xyXm5pWnHLxXRfsGnaI+TxpyPDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=FNKguG6N; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GDMx8E011502;
	Fri, 16 Aug 2024 06:36:47 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4127khg2aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 06:36:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bn8usqsEWlO9HHPZwszCB5Tgwkxu/wIqOgWZJi1WkAkl7E1YMj6FkNBIMLyYsNUYfcMA1qX0KQCHHttamKy/DdAvz3owIg36KUAps7DsdZ9qHbCuvHyGB75gGMSr/AqesnSTg5z2YtZjXY8varWes35zpqv1/ALnwjBTqoJtpGpIas2dpEq9SqJzLQX/5+kU2stFtNWnz/kLBZH8VqeyjBjjkBhHmsQ9OQiXZ3b6VuvBGtYmXEqGu17rrZ0pVkhmtH+ilNsuzFdDzM+UanNZGZE8dtMXLrz7L4lLTypBunRMVJioZJxEqh5X8t9XRyPPMMki1qo7NtQ+RP70vfeaGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZX6HLlsOE1o4dvgxOG/5oljcydr5ZnhMY8Ef9W9OXMw=;
 b=MCi6l+dkzVIQsC75hmh8fhoD5xUp4YpSJwNtDrHxG30ot83HhvbogDGEFez2CaJg7aanW/uM/uY5mCGUI3SFHFSMxCoS0prs0L25Vn2yZqetkmIX71gJY0mvOiFlC7wENE/X9M2Q/26UNw1sLpR23Dy5+RZHLo33e4zz4afs0zW8QxHI2p53FknNm9MvdUdcftEeijn4Fgpnrf0PhfTnqjQoTABwKEDt9OigevO/BWwMkQnU4TMe8bSjjcNdeIANHuOhgst4+4ghEitb8+T1Jorj1iiDxELgLeXYHMac5INlUPMldohdoyRyi93VkY4hRKcEa5ICZI6yZ/7cz5E8OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX6HLlsOE1o4dvgxOG/5oljcydr5ZnhMY8Ef9W9OXMw=;
 b=FNKguG6NcF02xB9tIhhCBdofwRTjhthNe6Mg3XZfwGeCzKLgko8KeSexSPCNNV3IH+PT8Xx4x655YwEgRLMxCOuQGqn8nO/mUOIkEZsOdqo1uL68KnzW+yE0M1903RouINK484AYD6PROzQh6xtS1xHzoSMQF6lV/lH31wGwH6Y=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by PH7PR18MB5667.namprd18.prod.outlook.com (2603:10b6:510:2e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 13:36:41 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 13:36:41 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v10 01/11] octeontx2-pf:
 Refactoring RVU driver
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v10 01/11] octeontx2-pf:
 Refactoring RVU driver
Thread-Index: AQHa5z16bLt3siVov02ZB0iTBLEH/bIdhGaAgAxb6aA=
Date: Fri, 16 Aug 2024 13:36:41 +0000
Message-ID:
 <CH0PR18MB4339720BC03E2E4E6FAC0251CD812@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240805131815.7588-1-gakula@marvell.com>
 <20240805131815.7588-2-gakula@marvell.com>
 <ZrTnK78ITIGU-7qj@nanopsycho.orion>
In-Reply-To: <ZrTnK78ITIGU-7qj@nanopsycho.orion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|PH7PR18MB5667:EE_
x-ms-office365-filtering-correlation-id: 1b10cfe0-880e-4100-960d-08dcbdf87641
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NGhuVm9seXFoSlpUY2dTWVYybmtNbEpqdERsdVJtMjBIZHlBU3gxaUkxdkUx?=
 =?utf-8?B?VmZib3grNHVEVmVOaCtKbFF5UmF1ZE5wWHlBVXowd3hzVnRVTWRaSE9tYUFi?=
 =?utf-8?B?UlVwRTViblpOZ0ltaXEvTlBRWjlzY1VHNG4yelRnRzRBbWxoRUYzcGNBR1Js?=
 =?utf-8?B?MG5EMnBCUkppQ2xzSEQzVU1rR08wa3lKbS9PNkNXOG9IVEFzZUVwV1hsWHd6?=
 =?utf-8?B?czNGNC9rNy8rb3M3dmkvQTdsVDdHTkF5VlBkNmZvanA1aUM4U09LSWt1UitU?=
 =?utf-8?B?OU9KWmZBeUZRYmR0QjZmNFpKRjN0empMZHJndXlmZlJyTWxJQ2J0dUNvNzN0?=
 =?utf-8?B?R3JiNFNOMmxGL1RDSUpGVFpDSzVOMlNhV1hhSjZFc2FWb2dERkZ5SWhXcnNS?=
 =?utf-8?B?a091MnZHejRISkdLbVRiUGhUR2VLdXdFSTUwNlUwcmtwUnFEQ1U4VFc0bits?=
 =?utf-8?B?REdkQ0ZGbDVIYmJveXhrSU9hS0VBTnlYZnhJUFZ5aVROSWd1RmJVYkJmbGhD?=
 =?utf-8?B?V01NTVhiY3NNKzMrSnYyTmV2S1lqdmRPSWYzS1VoWUpvbThMQzNQZG5kRUdR?=
 =?utf-8?B?WU9KUGJZVFhWb1ZCTjIvVUJKSlliNVRqVE54Y1lJUFZFVWNnQ2lxRkhVYzhk?=
 =?utf-8?B?VzYxUVErbFo1RGhuNHM2cm1EVHcxdkdseVpRaFB0TGFDUlFSdElWZXhlM3Ny?=
 =?utf-8?B?cTV3RG5oREJEOEhDQVlBUExtV3ZVYVBpbGZpSnBuOUtuRE1uRS9PUVRjWkR3?=
 =?utf-8?B?WGxvbWdoUHBpbURwQStpMnBtdFc1WTFIdThzaHUwUGgxK29lZis0OHZnbURX?=
 =?utf-8?B?NW9OMGxPMVgwYXI0cHlldHJHMjRJNzZGWk1XM1h4SVRJa2h0RHRGK3FCRWw4?=
 =?utf-8?B?eUhoV3d4eE53YnFNU0VJeERTWXBkUm5PQkFLZmJVVFQwQmh2YUtTaTlwS0ls?=
 =?utf-8?B?SGtGMUcyREhEZ0dHQ2ZYNVk4ZUNGZXhReTF0Y3Y4RCtRaDJMVEt4RElKdlh0?=
 =?utf-8?B?RjV5c3pIdmJ3WlhTaXNpZ3I0cXRTME0zWmNhZ3l2bHFHSXZuMURJK2t3YWFm?=
 =?utf-8?B?RzNCSk1jQ0hxdmZ3djZ6Sm9PVVhlWGwrdWF2NHVSRmtPUXJtSUlQYlRIdUVk?=
 =?utf-8?B?MXJkRi9KYzdSZFJxRkY5S25PdURlU3lDdERGMVpjdjE2eW1IUEdtY3NjM2pX?=
 =?utf-8?B?TTM5bzZZNHljTGZoYjQ4VjhBY1AyeUh6VEk4MHl4cVdFOC9BckdPS1hXeWZW?=
 =?utf-8?B?VVF2bjhmSmNoTlN3UU9Ecy9oTi8xcDRvNUdsczZkMDh0cUJEVjBHQXpJWlFN?=
 =?utf-8?B?bVh4Ky9XRlk1YThlR2Y5eTJ2TmtEZ2l4VWh3YkZWZEpJWDM2M254dnFUVW1K?=
 =?utf-8?B?dEN5bElqdm00SWpSRDJmbzBqbUYzWmdHNTgyN2JId1hmZnFSbHVtVVcxUlpt?=
 =?utf-8?B?eEF5K2JYYUxBZkhGbUZVQ1JwUjdTdFlUeU5Mc2VVd2IwZ1JGK2Y4OEs2aVd0?=
 =?utf-8?B?UGxQMkZhcUFnanczTVUzdEcycHdGb3Rkenc4SUVlelh3Qk1qRTBzc0I5ckli?=
 =?utf-8?B?WUpIcnR2d3lZVmZ1eGxuRlliNExJaXpJUkFLQzdRc1ZqVlZGa3VOdUZzSDRs?=
 =?utf-8?B?MU9sdkltUU4rZGFxaitxcmplZW1pZ3FUR05zNGM3Y0EwUjdoY0Nqdys1YTBV?=
 =?utf-8?B?MHczRU5tLzBhRlhUMzBkQTNMTFRYREpJRS9zMHg2MUhFbEtzL3lJZmlGUmpI?=
 =?utf-8?B?V3R4cVFxUzUyMURhZXBKUHBJN0tvdm13aGt4b3FPQU1SbEFnQkNkMnNNQzE5?=
 =?utf-8?B?ajFlRkFrM0t3NXQwZENzYmY3am91Qml3QzJ0ZHk1U1lZZXpocUpJYUpqMTVV?=
 =?utf-8?B?VDg2U09jRmRkOU5WdklQdGkxaWdyUzViQWJGa2Jod1RNS0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VW03eUdjbDdmZTZMclRXSkpvWlBGUUhFYWY3dmdDVVRNc1BsYmFiUkkvVm9U?=
 =?utf-8?B?NGlZZnJvT3M4aitHSzU4UlczSFpvdDFDeFhQRVpSZURuZVAxVSs1ODlVSnM1?=
 =?utf-8?B?NTdrL2pxb2JjRlJ6cnh3NHVBbkFTRUt5NlJOQURIR0ZhMlUya1ZLZTdJSHl1?=
 =?utf-8?B?ZlZWZk9sNXgzSlY3WVVSUXVpK3MyaWZCMHdrVnhrM3NPZE9NUXZOK25YeCto?=
 =?utf-8?B?TGpCM2hMU2x6cjYrOHllQ0ErRm1ZcU1CUVlOR3psM2ZQVC9Wd1EwNjFZaWlY?=
 =?utf-8?B?cS9YYnUzMFg5VjkwclNpUENqV2ppM2FMQVgxdEUyazg0OTUyR29EM0dwQzJU?=
 =?utf-8?B?ZGZEVUU3OXFLT0hiSHFtUGlmV3ZTQUdmSzJ0QXVMbHh3UFRUOWt0ZGRWYm83?=
 =?utf-8?B?aHRWU3VrUmV3T1VqWTBzaXFzQ2lqSDk5a0k5Z1g0YjB2UWdXN1NHRHA2Q001?=
 =?utf-8?B?a1pnQ1NjRSt2cHppWGVtMlU1VjdIcGtUMjlkV2ZGSFZwWUIxcGdEaUgrZURJ?=
 =?utf-8?B?V1o5Q2ROYzQydEVXK2o1LzJndUlqcU9rTnFXdWFvaCt4cnZpMGg0bWViMjRV?=
 =?utf-8?B?bSt5b1lTaVFXOURvdkt4VkRwNEdjVW5GY0M4dDRhQTZ6SlhlRnJLd0poSE45?=
 =?utf-8?B?dmVoRjZ1TDlLWWErQmtpSTZSOE1YUENWNFJwVFA1UU9zQk5GdFNFMDNKbGQ4?=
 =?utf-8?B?SFhPN3JqNnNhaHpwQi8yY0R0dTJxMksvLy9ibXFkbUlCRVNRaThEeDd2VG5X?=
 =?utf-8?B?cXNGTXZTeEtJb0MvdUVKYStMOStnUTZvYzI0TCtvRTNmdHJaOFV1RGVXdFhk?=
 =?utf-8?B?cXdTblFXTEVRcUEyRlJNRWl6blUzLzhRVkRFRmhGelhaZzF0V2p0NEwvWWt3?=
 =?utf-8?B?cFd1bmxib01kWmdZbkhuUmhUZlNUNmprTFlFZUVkblFrTzkvOGJ3a1crY3J1?=
 =?utf-8?B?NTBlWWxzNHNaeWE0eHhxM0d2eTBtNVMrc3ZEMW9lTlVDMDZVNExvYlZxejlN?=
 =?utf-8?B?eEhmOFU5WjViNUlwaHA3LzByZXFXaUlhVCtFM0t1QlRleW1PRDFJeVdyVHFy?=
 =?utf-8?B?U2w4cFIvQUtXTm1FRDBad09MdWtYd0g1eGRJYXNTMkdSZUp3NEsvMnJhV2M1?=
 =?utf-8?B?QVZIbUFIdWM2TnRDZ3YxVTlpY3RhaEpNdHdveVR1bmxnQklibFBGZlNEYXVo?=
 =?utf-8?B?NGwvRi9MOENGaktBTERlU29keU51N21pSzhZRlV5UC9wVE5mYlB0TTA5Z2dy?=
 =?utf-8?B?elVXRlNyNml6Yk1OZGYxSFJVM1MycXdaNVdZekZVWHZnd1pWOHFYd0FqQldp?=
 =?utf-8?B?TFNSZDBBU2FZRFlrSCtRc3UvdVVEc0YxeElvUlI0YTFPZ0VkcEhHRnpTZmdn?=
 =?utf-8?B?S2NUc29oZi9zOVhVVEhIRzlrWEl6TVJDNEdYbzJIV0g0MWpPc0J2SFcwRGV3?=
 =?utf-8?B?MlFsMVZaM0RIbjZNU0g3MGdjKytEQnJ5d0NjOFo4bzlnL3ROdkQzZm8vMFp2?=
 =?utf-8?B?b2tvZVAxU0d6QTBvUWlRRUlCampEeUM4REVXTzFsaEtRbnlyRVlIc1FWQ3Ns?=
 =?utf-8?B?NDhYbUZncGZydmV2QzBwNnplTXoxcVNkVG00THJPVmlNZVRJVEhVRjhlcEhF?=
 =?utf-8?B?ZG5ycmV2MXNxVzBDNzBpem9RRkMzai84NzQwbE9NV1JkejhDRjVrdXFSRkg4?=
 =?utf-8?B?TzVVZ1crbFhRRFdYRUE3MVp3d1hGS1hMV2hNekp2Q29JR2pMTDJFWWVMblV2?=
 =?utf-8?B?TzFFV1VjSjBiM3JtdW9FaXpQbXpOWVRVTG8zWFo1OC9UV2NEa2llWEE5c0hT?=
 =?utf-8?B?UGh5Vml2RXV1WVBmL0VBSVVKUTVHbXlTbEU0djl5VFB1ZjNMMTRPTDBnbjVw?=
 =?utf-8?B?OTNrZ3VKRmZTT0k2dFEzSFV0TTVFaXFFQkVrT0xVTVlYVCtRQmxRNEZMZnV5?=
 =?utf-8?B?K1c2TlpQL2ZEOHoxNGkvT3hWdlp5Q3NkUzRJQWxPaXk2alc1VGVMUnoxYzFK?=
 =?utf-8?B?M3Z1QzVlR2w4eCtjN3kwbll0bXdSOWZ5WU1kenFIcHBjbE5NbVBzbk52a3hM?=
 =?utf-8?B?Y1NrSEJjcWlPUUhtZ3FIS3RlUjNsbTNPSUxldVdUbFJjWVp0amcybHZRY3Nh?=
 =?utf-8?Q?iOpk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b10cfe0-880e-4100-960d-08dcbdf87641
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 13:36:41.2812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQ5RvOkGHHS20ipmmUui/Mlgtn2kCfAADP6JPYlTIHgySJMaANLkIIdQj6mf++Xv028WU0xIzacHvpRS2qBuhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5667
X-Proofpoint-ORIG-GUID: NLw6rKbOd9Q9ORsZk1PsF_xqtj40WdJ4
X-Proofpoint-GUID: NLw6rKbOd9Q9ORsZk1PsF_xqtj40WdJ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_05,2024-08-16_01,2024-05-17_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEppcmkgUGlya28gPGppcmlA
cmVzbnVsbGkudXM+DQo+U2VudDogVGh1cnNkYXksIEF1Z3VzdCA4LCAyMDI0IDk6MTIgUE0NCj5U
bzogR2VldGhhc293amFueWEgQWt1bGEgPGdha3VsYUBtYXJ2ZWxsLmNvbT4NCj5DYzogbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga3ViYUBrZXJu
ZWwub3JnOw0KPmRhdmVtQGRhdmVtbG9mdC5uZXQ7IHBhYmVuaUByZWRoYXQuY29tOyBlZHVtYXpl
dEBnb29nbGUuY29tOyBTdW5pbA0KPktvdnZ1cmkgR291dGhhbSA8c2dvdXRoYW1AbWFydmVsbC5j
b20+OyBTdWJiYXJheWEgU3VuZGVlcCBCaGF0dGENCj48c2JoYXR0YUBtYXJ2ZWxsLmNvbT47IEhh
cmlwcmFzYWQgS2VsYW0gPGhrZWxhbUBtYXJ2ZWxsLmNvbT4NCj5TdWJqZWN0OiBbRVhURVJOQUxd
IFJlOiBbbmV0LW5leHQgUEFUQ0ggdjEwIDAxLzExXSBvY3Rlb250eDItcGY6IFJlZmFjdG9yaW5n
DQo+UlZVIGRyaXZlcg0KPg0KPk1vbiwgQXVnIDA1LCAyMDI0IGF0IDAzOjE4OjA1UE0gQ0VTVCwg
Z2FrdWxhQG1hcnZlbGwuY29tIHdyb3RlOg0KPj5SZWZhY3RvcmluZyBhbmQgZXhwb3J0IGxpc3Qg
b2Ygc2hhcmVkIGZ1bmN0aW9ucyBzdWNoIHRoYXQgdGhleSBjYW4gYmUNCj4+dXNlZCBieSBib3Ro
IFJWVSBOSUMgYW5kIHJlcHJlc2VudG9yIGRyaXZlci4NCj4+DQo+PlNpZ25lZC1vZmYtYnk6IEdl
ZXRoYSBzb3dqYW55YSA8Z2FrdWxhQG1hcnZlbGwuY29tPg0KPj5SZXZpZXdlZC1ieTogU2ltb24g
SG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPg0KPj4tLS0NCj4+IC4uLi9ldGhlcm5ldC9tYXJ2ZWxs
L29jdGVvbnR4Mi9hZi9jb21tb24uaCAgICB8ICAgMiArDQo+PiAuLi4vbmV0L2V0aGVybmV0L21h
cnZlbGwvb2N0ZW9udHgyL2FmL21ib3guaCAgfCAgIDIgKw0KPj4gLi4uL25ldC9ldGhlcm5ldC9t
YXJ2ZWxsL29jdGVvbnR4Mi9hZi9ucGMuaCAgIHwgICAxICsNCj4+IC4uLi9uZXQvZXRoZXJuZXQv
bWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1LmMgICB8ICAxMSArDQo+PiAuLi4vbmV0L2V0aGVybmV0
L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dS5oICAgfCAgIDEgKw0KPj4gLi4uL21hcnZlbGwvb2N0
ZW9udHgyL2FmL3J2dV9kZWJ1Z2ZzLmMgICAgICAgIHwgIDI3IC0tDQo+PiAuLi4vZXRoZXJuZXQv
bWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1X25peC5jICAgfCAgNDcgKystLQ0KPj4gLi4uL21hcnZl
bGwvb2N0ZW9udHgyL2FmL3J2dV9ucGNfZnMuYyAgICAgICAgIHwgICA1ICsNCj4+IC4uLi9ldGhl
cm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfcmVnLmggICB8ICAgNCArDQo+PiAuLi4vbWFy
dmVsbC9vY3Rlb250eDIvYWYvcnZ1X3N0cnVjdC5oICAgICAgICAgfCAgMjYgKysNCj4+IC4uLi9t
YXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfc3dpdGNoLmMgICAgICAgICB8ICAgMiArLQ0KPj4gLi4u
L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX2NvbW1vbi5jICAgICAgIHwgICA2ICstDQo+PiAu
Li4vbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfY29tbW9uLmggICAgICAgfCAgNDMgKystLQ0K
Pj4gLi4uL2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3BmLmMgIHwgMjQwICsr
KysrKysrKysrLS0tLS0tLQ0KPj4gLi4uL21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3R4cngu
YyAgICAgICAgIHwgIDE3ICstDQo+PiAuLi4vbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdHhy
eC5oICAgICAgICAgfCAgIDMgKy0NCj4+IC4uLi9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9u
aWMvb3R4Ml92Zi5jICB8ICAgNyArLQ0KPj4gMTcgZmlsZXMgY2hhbmdlZCwgMjY2IGluc2VydGlv
bnMoKyksIDE3OCBkZWxldGlvbnMoLSkNCj4NCj5Ib3cgY2FuIGFueW9uZSByZXZpZXcgdGhpcz8N
Cj4NCj5JZiB5b3UgbmVlZCB0byByZWZhY3RvciB0aGUgY29kZSBpbiBwcmVwYXJhdGlvbiBmb3Ig
YSBmZWF0dXJlLCB5b3UgY2FuIGRvIGluIGluIGENCj5zZXBhcmF0ZSBwYXRjaHNldCBzZW50IGJl
Zm9yZSB0aGUgZmVhdHVyZSBhcHBlYXJzLiBUaGlzIHBhdGNoIHNob3VsZCBiZSBzcGxpdA0KPmlu
dG8gWCBwYXRjaGVzLiBPbmUgbG9naWNhbCBjaGFuZ2UgcGVyIHBhdGNoLg0KSWYgdGhlc2UgY2hh
bmdlcyBhcmUgbW92ZWQgaW50byBhIHNlcGFyYXRlIHBhdGNoc2V0LiAgSG93IGNhbiBzb21lb25l
IHVuZGVyc3RhbmQgYW5kIHJldmlldyANCnRoZW0gd2l0aG91dCBrbm93aW5nIHdoZXJlIHRoZXkg
Z2V0IHJldXNlZC4NCg==

