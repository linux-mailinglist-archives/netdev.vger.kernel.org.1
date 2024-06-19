Return-Path: <netdev+bounces-104843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AFF90EA6F
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8248C2817D6
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB0213E3EB;
	Wed, 19 Jun 2024 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="vuUIa2v9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F1184D2A;
	Wed, 19 Jun 2024 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798963; cv=fail; b=XfsUOT9sr4rqjIGw+iEL0Y5xM2EWa2iU8Q/RQlS9i4KnIuNEwgOTgr1P9IGpUSxpV4/6dHFGBdcf2ZVcwurLG7esJegTul+OUKStn5FwEkdJ4+gHjxIN3iCbGRt9IM/QtXzYm4NjT/b/tWllHpzRackdKVGSTUxfyStS+QgsArc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798963; c=relaxed/simple;
	bh=6e/7JsgPkfj3ZN0boEuJYJf8nKvg5n4Cy1mndicgIOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j1ONXsfu5843+nAVyji9YRvKDk4Uw3fpl85JxuGol2PkqpncGNKOaE4mR6Z1g90HnmyTwIk7gpEqNT4JgURcv9MEJwrjBfF42TtjJv9z93KNQysmJBjuc3E9i7g8Bmjbu8IFWE3gxQteTXdIhaxVnsPqC+KJ+AIeSwIT0426njg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=vuUIa2v9; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J9l8DO011751;
	Wed, 19 Jun 2024 05:09:05 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yuw0jreeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 05:09:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhhOQ1QE1Y9IHSsCIVF+EykvRnKfvG8Gm3b+wWIPEFK887O+2HtPN2/UZVT9YqbCdcCJVrRqrvA0JEKFBpXcNwmvrLplaelHXpnLPAlN+Jkh63EPkJfZNdLp19C2BtTQUs/Tq0GRSUZE9hNAD9dcnAHqNRFGcB80UKP4DM7fiUMlOPy+eVe04xISheKE4RhZ6+dAGU5yAhHTxAMmurBa9187uFuQj4RbEOhshEZdOu4cZsskEnSjVZqwi79JGBxLYt44NAALgI0vUew0Y0/bitTObEXr+YJIkltr2AUVUAik3cGV1HipLwHhUme4U04ted2tjTvqYBgxclqAqAhekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6e/7JsgPkfj3ZN0boEuJYJf8nKvg5n4Cy1mndicgIOA=;
 b=VPDk2mMS5bTrpyJ3Ekfi8KI8y+CIPNnsM5d0vf1+gULjR1C/gY7rf4lzdt2X9CjstkWtaEpXIrAUVxW6/AgKWoU1pcqFhVKQtwyN+l5dPoPnDRqOTp0wM0qTUvty8f7VhAPWgKLDZLDpmB13+FOEAc9hw5PJUy52vsrDre0GKGts/clXfPOkGYk60F+zeXFqoXH8wvtn9VEF6rSBpNB4o25wQUHhaXOU0FLvhFCs24pTT3bRCRJlIVyS+EsUHjxifq93KWOMoiqrB1mt60kTCwF4KwRg3VypSNRnazZV/+T7wuF8JdjmCW+YhgGVwN+0w54Q+Bin+LJlbkGV6calkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6e/7JsgPkfj3ZN0boEuJYJf8nKvg5n4Cy1mndicgIOA=;
 b=vuUIa2v9vMQW8jhO+7nl4Aea3ZVlND21C873RRnO7D5ZjeNoZuz6VC9pxpqJoGKd9MONinntWjsdl8FsekX9jN1KNIBki+Waus0ccsRxhjVgtf0h9aCqtYqWPAN3ZEJ9fihRg2eybsVVKyl0oU7uOQ4AzwKW2snuru8c2JFqc9o=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by SJ0PR18MB5185.namprd18.prod.outlook.com (2603:10b6:a03:438::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 12:09:01 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 12:08:59 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Simon Horman <horms@kernel.org>
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
Subject: RE: [EXTERNAL] Re: [net PATCH] octeontx2-pf: Fix linking objects into
 multiple modules
Thread-Topic: [EXTERNAL] Re: [net PATCH] octeontx2-pf: Fix linking objects
 into multiple modules
Thread-Index: AQHawUZdGhHuAZXCHESSZO5jnw5zFLHO7pWAgAAQVzA=
Date: Wed, 19 Jun 2024 12:08:59 +0000
Message-ID: 
 <CH0PR18MB43390E4FDE8AD2163256A85ECDCF2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240618061122.6628-1-gakula@marvell.com>
 <20240619110517.GC690967@kernel.org>
In-Reply-To: <20240619110517.GC690967@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|SJ0PR18MB5185:EE_
x-ms-office365-filtering-correlation-id: 7d306f10-9d26-44d1-9743-08dc90589a3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?R1hvWkZKNDhpY1JWekN0cUdzdDE2amRjKzRoK01vTldScDNSZUlSOXhKbFVN?=
 =?utf-8?B?MmRKTjM5c3NKQUNGaC9Gck1LeWN1Zm1vSW5hdmdxRUlyckFXZ3JoajRVellS?=
 =?utf-8?B?MmprM2J1Y25raDBhWjEvT2RydVVqSDNXSkYrZUNWL0dUbVFxQjVLQk5lV3h5?=
 =?utf-8?B?SlZna0tYZU1OMUdCQU5yT1dVSnplcjByeDRMcklqdjVnU1lLVDY5S2lTdzg5?=
 =?utf-8?B?NHNjSGNOVmViN3FZU3dzdktSc3hvQnN0eVQ2cGg3bXNXeitQMStwZVVhMXNl?=
 =?utf-8?B?ZHZOYlJRUmZ3VVgrYUNTM2VXRzF0OHloR09FZlNNQmZCMEtGNzJBK0xndE44?=
 =?utf-8?B?bFErc1NYV2c5TUtCUUxXS0xvUmRQeDljQ25LVEtVRWROYVZnK1dmRCtFK2Q2?=
 =?utf-8?B?TXNUWi9rc0plOEorcmdKQjdVNDhLenI4RHU1YWVkeXNSdHV1UUZPNGtpMUZk?=
 =?utf-8?B?QVlRSFJWckIzekVWdmVVcHArUk15U2dSSm4yR0dnbHJ0UGJwQU1UeE1HRFFl?=
 =?utf-8?B?OUcxcnNoL09CQVljVXZKY3FHU0pnclRQeDJSQ05xcnlyWEhlOWkyNEk1R1Vi?=
 =?utf-8?B?b3lEVHVjWTlYNURjamxEUzBya21oQW40T3pYblhaY2ZpL1l3Rk5Dd0xJMXBI?=
 =?utf-8?B?Mm5oKzR5UU5Eb1NKNUhPSHpuYnVsbStmQ2p5SExUT3dVY0dnSHY0ZzB1ZEor?=
 =?utf-8?B?OWg5OS94dkxUOENsdU9RTnB2TFFLUzhrejNabDB1S3BNSW1QS1RpbDNQTzdY?=
 =?utf-8?B?d1dic3R1b1lwK2grNmNodGVKb2NRd3BZb2dvZVBkOGxHTmVwY0R2eDZYcmhm?=
 =?utf-8?B?L3V1SVkvbUljVGpQNitpb2N1ZnFSaXVIdkY4VmplOFd2N0xNbHlIVzJRNHky?=
 =?utf-8?B?TmpuUlBDdThhb0o5cFAzL2hlM25yWGJTZm1vL2VJakFyQ0FmZ0xBWjFDMHRR?=
 =?utf-8?B?UHVXaWxEWm1KN2h0UVlZaTVLTVl0Sm1WM3RIVFp5NEdzRngxYlhWVEdiMVV4?=
 =?utf-8?B?RVIxVHpONkdkYXp2Zy9KTlBvSGxENWh3TFhrNUpPUWVzRGpMZFhsWWNHYVht?=
 =?utf-8?B?eWxRU1cwNTdGV3BkNFd0MkJiL2hoWFF3Rm1QYzJGTFpTbHRLU3BMUXhkZlVi?=
 =?utf-8?B?dWhEcERtRnc0Q2UxSUVEQWpBY3AzZnE1RU14TkoxRGx0ZnA2anB0M0ZFWWV6?=
 =?utf-8?B?RzlNdDFJVVpLOHduOW5vWDVmL1RyWVpZVDl4b0VZYWRWcmpoR2dSMXg5TjBU?=
 =?utf-8?B?dUxBR0FjYnA1M2ViOG8walFxTGR5WEVocTI1QnVIRFd4akZMa1g1ZFJaYXhm?=
 =?utf-8?B?QUI5SmRuZE1XZ2I3LzdDemNVQmsybGIvemNVaFd3dTk0bW1jVVVGRjdNV0NY?=
 =?utf-8?B?YTVPUk1TbSt6WlhVOWVJZ0lGUkZ3Yjdub3hpai9rSlA4NlZyWkdFcjU2cTRk?=
 =?utf-8?B?a1lkOUs5YlVlS2xKRDc4SDI3ZzRtSHlCVVdrZjRZeEhoZ3NhaldMYUpUZXM1?=
 =?utf-8?B?WDcwTFlEd3Z4TlBGVHRqbTkyM3B3aXpYVHlScnd3K1pVY3V2Z1VHdEg0eENo?=
 =?utf-8?B?aTNNSVZodFgxUEdWdGFXWW9tZ0cxczVYLzhRSnlvL1g2YXh1WEF2U2VDSXRR?=
 =?utf-8?B?T0duOTJtTUtFbWlWS3pHaVlnVC9mc2ZHQUxXcDkxNEk4RUFIT3lISCszWFpS?=
 =?utf-8?B?SDJQMjJqQ1IvOXQ0QzZCenNENmhCM0JJSlArWkZRQVdGanlBZ3JuTGg5d0F0?=
 =?utf-8?B?amwyMVpzT29sTlZNTU11czlaU3prbFRpQVRncUVJeENoQUpPb2hxWC9TSVdx?=
 =?utf-8?Q?g7cGrguC+RbVCdQd/uQO8ttb8w528nCR8lOCI=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bjUxK3VQblNIZzhZYkxhZCtncHFCZEhyNy9KSlBZUUZEN1Y1ODZWbnFRNlU3?=
 =?utf-8?B?VTVqM3ExcmYyejhMOFNsZkFscllJRzZvbFB1UlpRTUt0VTNUeEFIMEVqTjZw?=
 =?utf-8?B?OWpMMFppY2ZTSVFZUDVlVzlhcGR0NGw0UlZFT285bzNyS044Y0JPTzRNajBP?=
 =?utf-8?B?bW5FY2xlaWlQTU1GN3NDMkhvb3dBVXRuWEkyTXlWSEgvdURsaVFSZ1ZNNE50?=
 =?utf-8?B?Y3k1U2Zub2FoY3I0SU1XUjBpaGVmTU13TEtjNGV2QkJ4QWhwR0d1cWRaUzFL?=
 =?utf-8?B?N1IrMFFicnM0cU80WUpGcXRiWnlpVWw3OUU5M0YwRnhTRzBVbXhCYkt6SVVR?=
 =?utf-8?B?TzRnb0NuMzhNY3IvTURpSnhJbkhIZTExR2NTMUE0R0JlMERZRWxEN2V6Z0JH?=
 =?utf-8?B?OFgzVko4WWVZSjlJbFIwYjZtZEQzTForekcvcnYxS2QxS0I3RHJ1Y0tONnIx?=
 =?utf-8?B?WUNLcWxXMFV3YksycDRxSU45bXFmR2RvSmliTmt5QUNVaFlwd1NlQ2R0T0t5?=
 =?utf-8?B?ZjVvNTRTZ2VYR0Vjc3oyQWhabUVtamx2YTNXNXJBNWVoUVl4blNidjdSdmpy?=
 =?utf-8?B?eEFpNko2dzRpS1ZtUTNXZThBVHlYdXFwNTVYOXVwSGpmZFdjczdTamk2R3l0?=
 =?utf-8?B?ZEtOUjRxcDN1ZVFUczd4R0NvVXBFSWFTazdEOUdLMDlGeHdEeDFvVVlZVGdx?=
 =?utf-8?B?QjBPZHYyVFN4L0prMEYra2lOZElFZnV3cndBZFNRc0o2dXpWTVliLzVvZ054?=
 =?utf-8?B?R0UwV0w2cldQVlU3eEZwek12UFBKbUZ5OS96OStOZmUyaktwWmxRL1YyQzY2?=
 =?utf-8?B?bmZ3cytQUzFJaVZPc0QydzBnUGh5NUJCajhqaGZKZTVzRk1YaUxyaVUxUWh2?=
 =?utf-8?B?ZXN5ckZOV0l2Z1l6UVlleXZyUGswTFIyY1JVSUhWTlIwTFNQS1dKN0JxK1hE?=
 =?utf-8?B?SjJDRlVVZW5XYnZwTHFnV3NMK2lDY3JMNW92WTNEbXpLQm44ZUV5L2pmdXRO?=
 =?utf-8?B?bEJndWxHMzJ5VXkrZFc1NlZpYmtWOHMwK3JjY05QclIrRnpXMmtHOFlWOVBH?=
 =?utf-8?B?aGozRTJVT3I3MUpNcDR0MUszZDI1MWd6cElLdFFEOVhSekY4ckVxSjFTNGZs?=
 =?utf-8?B?VHJEc3pTRzZsU2wwdUFKUjNPT1g5UktyVDNSbWVxTDFCaU5yalhYdk1iNlBP?=
 =?utf-8?B?MTFrdm8wTFV5UE5Sc1Y5a1poWDZTVDJlUjFsYVV5TXI2dFdsUGxsSDhQTHZJ?=
 =?utf-8?B?c1RxUDAvajNhS096d3dRdlErd0tmWkJlT3pOU3Zjdk43eCtjdDdpRDYzY2l6?=
 =?utf-8?B?b3pEY1BKWHZmUk5pS1pCcUMxRFFEZzY5d1FrUEVLSm44ZEFxTzhncjVXLzNK?=
 =?utf-8?B?cDhsL2NIUUJrMjJ3V2pKOVBUWDJsVjdXUEdWYktPMnUwdWxUeGF3dGF0VDRI?=
 =?utf-8?B?MU1Tc2U5UFloTUM0QjhLMFo5RDNwTUZoeDRDY1Y2dzZwZDZaNFU2RzJFdnEw?=
 =?utf-8?B?VHlEbDNnczA5U3lXWlFsbzRrWXQ1dmtMMFVnWkRocy9uZ0lPT1VKS0tmR0Er?=
 =?utf-8?B?ck85NkJwaDhoYjV3R3hOSi9ZQjhHUThtR0wreXB0K1B3SE00ZmxQNyt5Yjcr?=
 =?utf-8?B?YmtIU3pKOHJsK3Rwdkp2Mnd1SDFuWHFiRkduazlKMlNPMEVXdU1GV2hNSzB5?=
 =?utf-8?B?MVlKMlU5NVJkUGdzOW45NndMc1BWa0lQdFdLYUJFMkoxZC9jU3NiNHV3alVH?=
 =?utf-8?B?YXIwdG8xRnRWK1g0ZHEvS2IxbE9KZ1J1azI1WGRiNmttUUo1d3Ezd0V0Yi9Z?=
 =?utf-8?B?aERTaXhEWkYvNlpUcnBjeTlKR3RYQkN4ME1iNUxSSWZXNVZ3NEJaeEJuZFFl?=
 =?utf-8?B?bjVlb2hCSGJBWjZLU2NxdHBTN0kreGZseTB3UkEwd3RvZWJXeFRMK0RWcU1n?=
 =?utf-8?B?UTlrNWw2TktCQUt5aEJCbXVvek5IbTViaHpRMU1CMzh2SHI4ZHp1bVdheUdB?=
 =?utf-8?B?aDkrc1hxTWVvOXA5ZHJ2VzIyaFhKZk1ZcTBGZGJFb1lCN1FHQVljMlBUcUM1?=
 =?utf-8?B?Y3lxS0VLNm5lMjVOYjlDZENoN2p0VU9kRVhSRGxOL2Q0UGUxMzFIbGhDSGpB?=
 =?utf-8?Q?kaK4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d306f10-9d26-44d1-9743-08dc90589a3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 12:08:59.8571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6o/XmNYJrGGP+oRjj94UdUYOldQcw3GmUBOj+l7t20jwljyxknxDiKzyj8DpUXZtG/3hpZhi2Ob8N/vSLpifA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5185
X-Proofpoint-GUID: jCZ1KcbY7PyM__hFJ6YyzJSJsNAfsOjh
X-Proofpoint-ORIG-GUID: jCZ1KcbY7PyM__hFJ6YyzJSJsNAfsOjh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01

DQoNCkZyb206IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4gDQpTZW50OiBXZWRuZXNk
YXksIEp1bmUgMTksIDIwMjQgNDozNSBQTQ0KVG86IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1
bGFAbWFydmVsbC5jb20+DQpDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsga3ViYUBrZXJuZWwub3JnOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBw
YWJlbmlAcmVkaGF0LmNvbTsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgU3VuaWwgS292dnVyaSBHb3V0
aGFtIDxzZ291dGhhbUBtYXJ2ZWxsLmNvbT47IFN1YmJhcmF5YSBTdW5kZWVwIEJoYXR0YSA8c2Jo
YXR0YUBtYXJ2ZWxsLmNvbT47IEhhcmlwcmFzYWQgS2VsYW0gPGhrZWxhbUBtYXJ2ZWxsLmNvbT4N
ClN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtuZXQgUEFUQ0hdIG9jdGVvbnR4Mi1wZjogRml4IGxp
bmtpbmcgb2JqZWN0cyBpbnRvIG11bHRpcGxlIG1vZHVsZXMNCg0KPj4gVGhpcyBwYXRjaCBmaXhl
cyB0aGUgYmVsb3cgYnVpbGQgd2FybmluZyBtZXNzYWdlcyB0aGF0IGFyZQ0KPj4gY2F1c2VkIGR1
ZSB0byBsaW5raW5nIHNhbWUgZmlsZXMgdG8gbXVsdGlwbGUgbW9kdWxlcyBieQ0KPj4gZXhwb3J0
aW5nIHRoZSByZXF1aXJlZCBzeW1ib2xzLg0KPj4gDQo+PiAic2NyaXB0cy9NYWtlZmlsZS5idWls
ZDoyNDQ6IGRyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9NYWtlZmls
ZToNCj4+IG90eDJfZGV2bGluay5vIGlzIGFkZGVkIHRvIG11bHRpcGxlIG1vZHVsZXM6IHJ2dV9u
aWNwZiBydnVfbmljdmYNCj4+IA0KPj4gc2NyaXB0cy9NYWtlZmlsZS5idWlsZDoyNDQ6IGRyaXZl
cnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9NYWtlZmlsZToNCj4+IG90eDJf
ZGNibmwubyBpcyBhZGRlZCB0byBtdWx0aXBsZSBtb2R1bGVzOiBydnVfbmljcGYgcnZ1X25pY3Zm
Ig0KPj4gDQo+PiBGaXhlczogOGU2NzU1ODE3N2Y4ICgib2N0ZW9udHgyLXBmOiBQRkMgY29uZmln
IHN1cHBvcnQgd2l0aCBEQ0J4IikuDQo+PiBTaWduZWQtb2ZmLWJ5OiBHZWV0aGEgc293amFueWEg
PG1haWx0bzpnYWt1bGFAbWFydmVsbC5jb20+DQoNCj5UaGFua3MgR2VldGhhLA0KDQo+SSBjaGVj
a2VkIGFuZCBpdCBkb2VzIG5vdCBzZWVtIHRvIGJlIHBvc3NpYmxlIHRvIGNvbXBpbGUNCj5ydnVf
bmljdmYgYXMgYSBidWlsdC1pbiBhbmQgcnZ1X25pY3BmIGFzIGEgbW9kdWxlLA0KPndoaWNoIHdh
cyBteSBvbmx5IGNvbmNlcm4gYWJvdXQgdGhpcy4NClllcywgaXQgY2FuIGJlIGlnbm9yZWQgYXMg
VkYgY2FuIG5vdCBiZSBlbmFibGVkIHdpdGhvdXQgUEYgZHJpdmVyIGxvYWRlZC4NCg0KPlJldmll
d2VkLWJ5OiBTaW1vbiBIb3JtYW4gPG1haWx0bzpob3Jtc0BrZXJuZWwub3JnPg0K

