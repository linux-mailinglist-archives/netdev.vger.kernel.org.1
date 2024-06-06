Return-Path: <netdev+bounces-101196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EFC8FDB87
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C098B1C2310E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 00:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3300479F6;
	Thu,  6 Jun 2024 00:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="jvfku0O1";
	dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b="NkuuOP7N"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00183b01.pphosted.com (mx0a-00183b01.pphosted.com [67.231.149.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295EB4A2D;
	Thu,  6 Jun 2024 00:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717634152; cv=fail; b=Itz81uQxeLniPFx6h8/qtlEXQ0UHAUjwtJ62Pmqa8i+KfHn9EdVsw2MCjQNEaUp755RufaB838rTz6w14qzS+x60+W/cqxavhwqY26rKIsjaR/D2V9jtk8c8oMSzp1BT4/05/Vh1n45SY2GyR66l75fFMsXFl9Q54Lzf/ltx/og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717634152; c=relaxed/simple;
	bh=q2CkXwa4I9wPUDBAt/Od1ukmH/rWF5KJ6gPWVoQ0F9M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ob2DSKTADvlpdDWKD0EbrQOSTDO/ZP1D4Dhw1n303GwVfrs/s/CdrPGYuiDCyzEH4UBpxLER7qNwFCSUNG1D3w7JHSMPeHw/qMaQTKr/Zh4HKGNj1XVCeAe4l97LN0j53NIi5d3bcj02IG2m8utBJlzW3h8mF0XK5wdtW2M4hFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=jvfku0O1; dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b=NkuuOP7N; arc=fail smtp.client-ip=67.231.149.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
	by mx0a-00183b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455DPnVA008188;
	Wed, 5 Jun 2024 18:35:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pphosted-onsemi; bh=bFnPA2Dq3VTdbN/ZMoC1/xX3OOSwRQbJV/OUIhIouyg=; b=
	jvfku0O1z58jFAkneBFqMIqVohbsspa22bwCxG6Qz7NnmBw0Aaq9t684xxpgK1jo
	crPb9bsEYFE9UFG2psibFkEgALJcl0DOCjWCpl/I48FcZYuZzIhelIS2pMiiqt1R
	AHU1/vAc6zx48LBeOp9ADwe+LPT3EeLxv/vE/dJmG5iE1FO56dC4o9Gd1nu2a2Lq
	dpNoc/3R1twfRt0PEGzyA7LC2R0cvhrxFV5/rGsiFLBoARddORYxbqg+EL5yAY5X
	tiTHU+OG62OW1DMexxGoTSclHn8P+FxFrblYdVur422DbCneTsDHCwE9glXsqJbb
	9jY4HI3P5SW8/nJVh+iyIg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-00183b01.pphosted.com (PPS) with ESMTPS id 3yjrvx15nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 18:35:09 -0600 (MDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+vK0X43LWuQYNnO/VsWsitkBLUbdzMUnio9d87HjxHg0lLC27BUs1dCWv7xxUVPxrtbkgQ/qMsKdQGxrBvDXU2ERYLeFaJ/nbbqhtz7/E0qfsDGLF2pAQ980A01Tw8HV1sZyn5rpwHc6KaUs5fz4vL4P4e7CCtepKp0UmmJSZoDAknULSDZTdkQZtDMGkx9XfFofnTxD81a3cjx54Mh+XXRYaZgExumy4xXylJnlCYrh7JJkYlnW/h1zVBS5KBxLXf0ihZksACOYinOLi8xn7SiAPPsKMtea5zXNYvbrxN5sJLYMAICGHqaqeX2tJ28Z+3+NTrdj3qdJal8+Mfqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFnPA2Dq3VTdbN/ZMoC1/xX3OOSwRQbJV/OUIhIouyg=;
 b=Ze2xCwmZIlIk+OjpKUXyUkPHl6UYlOZu9/OOiPnuQt9By7D4Sd9n6gI8JAMmCkftBpnaN/SSSnPNbJVx0nuTFSweS9lVPcQlmrP37k78oJHovn/fyoliEXXUt0+xdFEGaUlhGz87aGfyEvjTpmwtSBJLhAGJ5VogTHqfkHUJvajk0cgWQT4cQonoaiJ+FjsTxhoGq+oRBt9MLlvZclJ6F8uANFaOzl5kkGVKSdN4kEBSk8u0UUyMTICjPVvYOIxj/DT8sswOA2v3FzdB2LgNvf6+YTjEe/38f3xSEXApD23X0B3IGaAXRZBrFtU8RUTYzj5HJxbfV9RakMiAaurBmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onsemi.com; dmarc=pass action=none header.from=onsemi.com;
 dkim=pass header.d=onsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onsemi.onmicrosoft.com; s=selector2-onsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFnPA2Dq3VTdbN/ZMoC1/xX3OOSwRQbJV/OUIhIouyg=;
 b=NkuuOP7NOHy0B1UODV+VU6WHR8BwNIFaE+5rPL9WfPMMLbwOO47fLOb/Pf9LGCmW/S5mN1UpZyvUe6lvmB9/DHH/QBK1uUSVEjSXGTQbN5SUvE9VBAPWMMww3Ra/cIgEW1ypdoVZGfTMrs4lSoFQu+HA6ujXA9r7kCr27KdDEm4=
Received: from BYAPR02MB5958.namprd02.prod.outlook.com (2603:10b6:a03:125::18)
 by DM6PR02MB6509.namprd02.prod.outlook.com (2603:10b6:5:1b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 00:35:04 +0000
Received: from BYAPR02MB5958.namprd02.prod.outlook.com
 ([fe80::9050:b9f2:336c:edaa]) by BYAPR02MB5958.namprd02.prod.outlook.com
 ([fe80::9050:b9f2:336c:edaa%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 00:35:04 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>,
        Piergiorgio Beruto
	<Pier.Beruto@onsemi.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "saeedm@nvidia.com"
	<saeedm@nvidia.com>,
        "anthony.l.nguyen@intel.com"
	<anthony.l.nguyen@intel.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "Horatiu.Vultur@microchip.com"
	<Horatiu.Vultur@microchip.com>,
        "ruanjinjie@huawei.com"
	<ruanjinjie@huawei.com>,
        "Steen.Hegelund@microchip.com"
	<Steen.Hegelund@microchip.com>,
        "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>,
        "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>,
        "Thorsten.Kummermehr@microchip.com"
	<Thorsten.Kummermehr@microchip.com>,
        "Nicolas.Ferre@microchip.com"
	<Nicolas.Ferre@microchip.com>,
        "benjamin.bigler@bernformulastudent.ch"
	<benjamin.bigler@bernformulastudent.ch>,
        Viliam Vozar
	<Viliam.Vozar@onsemi.com>,
        Arndt Schuebel <Arndt.Schuebel@onsemi.com>
Subject: RE: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Topic: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Index: 
 AQHakZAzTzY8uLDqjU+aLRkJ24TPX7F0voeAgAA2YYCAGHiwAIAAQuMAgAFPWgCAAH78AIAA9q2AgBaZtCCAAA/6AIAABQ4AgAACngCACKHOAIABvDqAgAAGhgCAACuYgIAEK/gAgAQWz/CAACdPAIAABqdg
Date: Thu, 6 Jun 2024 00:35:04 +0000
Message-ID: 
 <BYAPR02MB5958DE3C4FE820216153894B83FA2@BYAPR02MB5958.namprd02.prod.outlook.com>
References: 
 <BYAPR02MB5958A4D667D13071E023B18F83F52@BYAPR02MB5958.namprd02.prod.outlook.com>
 <6e4c8336-2783-45dd-b907-6b31cf0dae6c@lunn.ch>
 <BY5PR02MB6786619C0A0FCB2BEDC2F90D9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>
 <0581b64a-dd7a-43d7-83f7-657ae93cefe5@lunn.ch>
 <BY5PR02MB6786FC4808B2947CA03977429DF32@BY5PR02MB6786.namprd02.prod.outlook.com>
 <39a62649-813a-426c-a2a6-4991e66de36e@microchip.com>
 <585d7709-bcee-4a0e-9879-612bf798ed45@lunn.ch>
 <BY5PR02MB6786649AEE8D66E4472BB9679DFC2@BY5PR02MB6786.namprd02.prod.outlook.com>
 <cbe5043b-5bb5-4b9f-ac09-5c767ceced36@microchip.com>
 <BYAPR02MB5958BD922DAE2D31F18241B283F92@BYAPR02MB5958.namprd02.prod.outlook.com>
 <732ce616-9ddc-4564-ab1f-ac7bbc591292@lunn.ch>
In-Reply-To: <732ce616-9ddc-4564-ab1f-ac7bbc591292@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5958:EE_|DM6PR02MB6509:EE_
x-ms-office365-filtering-correlation-id: 58362e16-cf35-4840-16e3-08dc85c0823c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?9lUgO4tYk1waYoPr5PKaMwIDCp8GQ9kfJ7OxOdt9SdRMg6ZPr9zVP6N+4BPH?=
 =?us-ascii?Q?iMaR3LberUb39ws5iSFQSsY223XGyUESSqxmuf5dnELqYlsvV+YKdUNb19Hs?=
 =?us-ascii?Q?w1n5VFbtNDtYVSWOdBogQMw4GSMWk5bAY9lkNtjMWrgLZ+RD0vwbQ5GGiaeF?=
 =?us-ascii?Q?1WH8psGtl1vyDZc/T41xl6vjwvYgDvGzOWZ4Fziue8vtL9cUkA0izLBGL+yG?=
 =?us-ascii?Q?hOoOuunIt+bddtfk3FGW2Wp7fugyJkE22VNZ53pkyxbVT6P1Yr3XymDjgNT5?=
 =?us-ascii?Q?pN3vqNP7zAz82r6D38k7YPFkgGN0uLeiDxZn9Y3kcFxjKzOHw/ngSjcdbra7?=
 =?us-ascii?Q?QNpCeohAAPyoV7sfC3X6ymOQ33cEAqTlXK4cvdJA7oRONPHn10b0s+A8J6c4?=
 =?us-ascii?Q?sAR4wMfcO7O9JlUuvAinlAbTQG3BF9Xf28P0Xi9KQY6i1+viFROEx/ZDZYM9?=
 =?us-ascii?Q?rY022V/ye8cko598rOmuyYjMNkWj/9YoyE1lqEcuEHwIrLiqiMuwlW1gVXkB?=
 =?us-ascii?Q?VlS9ALnY5xfFIx7Wdtqfx23uJWTEsWxFetx5Zb6UcZE1OJf8CFnQnGleS9Pn?=
 =?us-ascii?Q?n6Jo9eSD702dSjHNyPTjAqU4oZ2gytuaSCyqgbku1DCsADgTt2NcHKxgy82O?=
 =?us-ascii?Q?02cF4QvuLs194tk1NhR+HFW/YGwZcv9pWA6njYWsmGc2ih3xjq5SV0IfVrh0?=
 =?us-ascii?Q?3YJyLthva9h44JFHb0gzGI0S9LvKoGkR2UgJ/jdXv7zHPeOg5HWLgH40Bu+B?=
 =?us-ascii?Q?GC1en9E3XeLesDbULnYzlaaGRDbwSkE7OfzIGhqnb9BZcT70UxaaS4pNwKPA?=
 =?us-ascii?Q?UXyNxNO4Gv5i4WAUSBYb3CTT6PUSp5PXMAZVATZBq9gu3iGw4haeLnuF/FuH?=
 =?us-ascii?Q?sOWriQ4os3UHOxvRlSKfNkhpreSJGpQZcmTOZtRPgHiAqwc+blv3vJ7cfsTK?=
 =?us-ascii?Q?sxpDNEYl1BK5ZbCQbjl+5whA0Mm9EQQOM6ru8ChRNI3Ole7K7VAZ65S71KM6?=
 =?us-ascii?Q?XlinWj6UBNFVmZiYYTSqV2dZkjENAEtvYIgKes7qeGL1t37Op5VFUXEHIRoZ?=
 =?us-ascii?Q?99GWB7SJea/SIGOAyyt/JXAjnoHFFO+5i5iivgpbrwpv5we/nif1iU2FB9qa?=
 =?us-ascii?Q?IjgQJkEzGf4Ol0tDKo0mpNblqkMxkJGMLooDxv/h6JpkYYkaWweWbMBzCh0V?=
 =?us-ascii?Q?cLlJ3RronmKneww4pan1eS5ONFFlwaFD8GR/kiPUcxW31CT1ESls04EHS9zg?=
 =?us-ascii?Q?i5N0Sngg2ScyRtHMIuEOFsr1SYPrmsDtNXp5DG052RfFBF6Bwenz1cx0xFH1?=
 =?us-ascii?Q?xQsdVM0OIaMteamd3+BO7lDQVYXis5O/9AqusaDZwCpbmLXLcE+Eg2UR+riq?=
 =?us-ascii?Q?trDdJMY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5958.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?RY27jYjWN0xkJK3RTEibdR1NvYQAnO2rNvUZWBWdGrohjweDdGIiPxB3hf9V?=
 =?us-ascii?Q?uhHzeEa4NOAw+947EA4h9esA0R1KVnBS/fPyAt6TS9vWf8cfWb5K4zqOci7u?=
 =?us-ascii?Q?5rKiOKiMBLvNCNAGtFoYYTHIC4qQYFwBmw3mZcLSQGp8FOjNQLctnslkQ3Uo?=
 =?us-ascii?Q?BjLbTwT0bypIlqRrAR7HeKHvKdjd81sN1sSHTkVgW5MK4IjxnQyMh9C6S/MQ?=
 =?us-ascii?Q?guQdn9EXB32EiwC0rs5A96DHeikQIxbb6hHKOl5NuF5qCwaB+iqef7h6+++E?=
 =?us-ascii?Q?r5XvUQl46eSkqjEdrdV1wquWCOKML4iYC2ydgKjJuh+2J4aSwtuvkTNj9yGc?=
 =?us-ascii?Q?0KeWspVno/VXBIRVkz2fytXqj8g+OoXKLAvoR5C23NccNsbvlLZsCftrXGxk?=
 =?us-ascii?Q?nB9m1Vc10fcLzYiNzn7v7ZbN175+QvfF7Y9YFGFzvW9tUssULKD2SoTD1Vwt?=
 =?us-ascii?Q?IIVZQSll6ergBRq88cwGtFRZS0ayCUHtI9z9oHgKl/AptmGrld3wN9kjZNWL?=
 =?us-ascii?Q?fBYFF8dD5clDHTCrvw5hiXaM0MFCc27zqPDUh09r4hzb/3Vx8Dy8zs5wn1dl?=
 =?us-ascii?Q?y6x9n+sc/T4LoccafGeuhbATqaonL3XHrJb8KYL+fcHVKoB649dY0gN956Pl?=
 =?us-ascii?Q?jWzGDdExctBRP1YtAuNgW+Ujr6KFNi7ZZhfnOyDpGvbBA46HKxh4+HufgMFQ?=
 =?us-ascii?Q?rS2UjmKUfhgE9oiRJtBBR9zL5q4HuUw1oadkpAKe9OQ/THygCmSOUn+DGl1N?=
 =?us-ascii?Q?HOdB/Wgq6zxWYQ3hLJq9o7O1p7jjyFKRxCLY6HdwolmRQ0jyKf/c9cZMCI/4?=
 =?us-ascii?Q?IY2Myz1953P7gKuwZoCAbRTxitmyLeW0L+zfOXjK7799qcUKqmxIoX/dCgub?=
 =?us-ascii?Q?fUORlnFvvhUoMDFINeFd4XB8DYuA6arVtGCZCexIdjnCaJrE2rDZvY6LDvpz?=
 =?us-ascii?Q?Zt0Y94C0tleC6e+OEVI0MPkJzFUoQS9z8I96Tv7wLtvfsAYQcoKVhc99Vkao?=
 =?us-ascii?Q?vSArgndoSFOrePbslpUyzrRR4NzIVgLXPlOGVmuntJQTGRaM/b03qMXuR3t2?=
 =?us-ascii?Q?BYcTt07A8aCzHi0XIEi5LVt9Yy7JT1NniGuhBQD+MeX5ohTapRhrhLGWAeYO?=
 =?us-ascii?Q?SD6lHRKbTD/iqsxupwNUvpL8cZSDdFOQeqAzPBp8U/dVHNh6TX/mqSoCXuMp?=
 =?us-ascii?Q?DAXGwTD6hm+xOqXlO44xQudDjNU9dceLTy8V+wDtgJPSH5AkgySSGbx0I3qn?=
 =?us-ascii?Q?+AJ6hB0BDfqsm5KZF/pc+6r0WzrXNy230fE6JQBXlmZQ5exnhej0VUHPOZEn?=
 =?us-ascii?Q?2+p/75EEqxDXZTsGf9zc63lJJAdMzyB/K4ir2hEAMIW6ELt4TxSu+BcOSjk6?=
 =?us-ascii?Q?BKbZEJ2mlFcvg77AMhf98sd8zAIvZbyzVp3RfqZl5agWIpqFJmP9yYJkAMPW?=
 =?us-ascii?Q?l2sP0lnnZOnWw48roAMhfwXTkozIcZlokldUxOOeCmR0xqJYMfjIk8gzyHq+?=
 =?us-ascii?Q?JD4ggLhnoyXcHk+YgzIkwtwSI2RcVgztFScXKPUEa1qzCLViSHZKhiQhxdfF?=
 =?us-ascii?Q?JH3+gM595VhfqXgZMgb6aGN0Q8XeXaPPhrZNczNsW35II9tGTuhlIcJPS+16?=
 =?us-ascii?Q?Eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5958.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58362e16-cf35-4840-16e3-08dc85c0823c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 00:35:04.4582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dl176zKCuMg5Lft4VNI6PHNZdpwgeQ1XqmV3p6fa9pANZB6wyqnBS4nf0KHUC4fW4HGL2KWVZ2wbileMx1jzu4JmBr5I4ySrc+ugdY8dHHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6509
X-Proofpoint-ORIG-GUID: yTdlAifkjXKK4DCsru5vS9_bpAO2i6Iw
X-Proofpoint-GUID: yTdlAifkjXKK4DCsru5vS9_bpAO2i6Iw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_08,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406060002



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, June 5, 2024 4:43 PM
> To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> Cc: Parthiban.Veerasooran@microchip.com; Piergiorgio Beruto
> <Pier.Beruto@onsemi.com>; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> horms@kernel.org; saeedm@nvidia.com; anthony.l.nguyen@intel.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; corbet@lwn.net;
> linux-doc@vger.kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> devicetree@vger.kernel.org; Horatiu.Vultur@microchip.com;
> ruanjinjie@huawei.com; Steen.Hegelund@microchip.com;
> vladimir.oltean@nxp.com; UNGLinuxDriver@microchip.com;
> Thorsten.Kummermehr@microchip.com;
> Nicolas.Ferre@microchip.com;
> benjamin.bigler@bernformulastudent.ch; Viliam Vozar
> <Viliam.Vozar@onsemi.com>; Arndt Schuebel
> <Arndt.Schuebel@onsemi.com>
> Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN Alliance
> 10BASE-T1x MACPHY Serial Interface
>=20
> [External Email]: This email arrived from an external source - Please
> exercise caution when opening any attachments or clicking on links.
>=20
>=20
> On Wed, Jun 05, 2024 at 09:40:12PM +0000, Selvamani Rajagopal
> wrote:
> > Parthiban/Andrew,
> >
> > Couple of requests / suggestions after completing the integration of
> our drivers to the current framework.
>=20
> Please configure your email client to wrap lines at about 78
> characters.
>=20

I believe my client is configured to wrap at 70th characters.=20
Not sure why it is not doing it.

>=20
> >
> > 1) Can we move memory map selector definitions
> (OA_TC6_PHY_C45_PCS_MMS2 and other 4 definitions) to the header
> file
> >      include/linux/oa_tc6.h?
> >      Also, if possible, could we add the MMS0, MMS1?. Our driver is
> using them. Of course, we could add it when we submit our driver.
>=20
> Interesting. So you have vendor registers outside of MMS 10-15?

This is not about vendor registers. The current oa_tc6 defines=20
MMS selector values for 2, 3, 4, 5, 6. I am asking, if 0, 1 can be added,=20
which are meant for "Standard Control and Status" and MAC respectively,=20
according to MMS assignment table 6 on OA standard.

>=20
> Or do you need to access standard registers? I would prefer to see
> your use cases before deciding this. If you want to access standard
> registers, you are probably doing stuff other vendors also want to do,
> so we should add a helper in the framework.
>=20
> 2) If it not too late to ask, Is it possible to move interrupt
> > handler to vendor's code?
>=20
> I would say no, not at the moment.
>=20
> What we can do in the future is allow a driver to register a function
> to handle the vendor interrupts, leaving the framework to handle the
> standard interrupts, and chain into the specific driver vendor
> interrupt handler when a vendor interrupt it indicated.
>=20
> > This way, it will provide vendors' code an ability to deal with some
> > of the interrupts. For example, our code deals with PHYINT bit.
>=20
> Please explain what you are doing here? What are you doing which the
> framework does not cover.

One example I can think of is, to handle PHYINT status bit
that may be set in STATUS0 register. Another example could be,
to give a vendor flexibility to not to use interrupt mode.=20
FYI: Our driver uses interrupts. So, this is not the main reason.

>=20
> 	Andrew

