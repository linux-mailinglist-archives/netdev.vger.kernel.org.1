Return-Path: <netdev+bounces-101628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC428FFAF9
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 06:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC2C1F2653D
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 04:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22AB4D11B;
	Fri,  7 Jun 2024 04:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="t06MvRPa";
	dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b="w9Cp8j/G"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00183b01.pphosted.com (mx0b-00183b01.pphosted.com [67.231.157.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1618E28;
	Fri,  7 Jun 2024 04:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717735289; cv=fail; b=Xy7HYkkRCYVvpmcksBRdjJ1BJZyWpAxwSezkoyGJjGkNzogL76o4f8qcx2Lye/Uc9Qi0dHc8+nILKdoY2zryIWon5mXhb4NzxcwWKX19ws3tz+OMSedyU8NeXzJY7L8LARW8kCBpjPu1Fb3kPy/gXBn43k5co7OHyIvLPMqr0rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717735289; c=relaxed/simple;
	bh=gUkeS1w01OxWAv6txt66hfXjy3UFxy2OJFFc9EVrI5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X/pJo6EEf6w6JJ3FD0DwxQSjzsnZdxSMEYEARtX2PrgKcdpYPsFschAmWFfS7eQnRDPqx4bSIhxr/JoBFqK4K+rHKvZMhTyt3d/nXzTp3haqMZCLgLHlzi2h1vRGWcVoRFO9v+Gk9HaLwh1zWaD85/FUOgnWScNxnJQgwsAQEKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=t06MvRPa; dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b=w9Cp8j/G; arc=fail smtp.client-ip=67.231.157.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
	by mx0b-00183b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456HMNrh010707;
	Thu, 6 Jun 2024 22:40:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pphosted-onsemi; bh=6tmu7m5XP85gJTD+USd8xENxix08xDjzRP6dbvVqfAY=; b=
	t06MvRPap1iAfcK9srlbFsGs2g+/nJZ9bH6SphZVTw67BFW7TMDb1ZpucEFKpAT9
	zoQaiSf6uYDEVVVEh9RZgrZ2oeTqWKbeqmrCGxyXWCXpiXSeFVd5TEsNINwZ51th
	Su43Rw475UdV+LElumWaU+TqHJfYam0n5/dTw9XxUbzzpN7Opb9zjtXFrx0EvK69
	if2aYzaLYjJOfh0lhwKI37phiAzjTKK40CmJ86km9EXPjRqEMX3vgmD9QaB8ITbG
	Pbhkk9jl8WgWI7NBa3/Iyc6jdvtzvjWYIGdJl1Yzk//wStNaID+PXUpDM3lBZDPR
	gNS15P0fWHPbzKur58cXgw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by mx0b-00183b01.pphosted.com (PPS) with ESMTPS id 3yjrvwv74w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 22:40:35 -0600 (MDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpOM2FUfjHQ99H28vfBjK/9KuZXyYlyzHj1iv5DUwMfpwbDJ3gbCWsqwXumZP8H/lxf+38pkdYAHHBoLHDYXngulyw9yRv/4ZO40iG/WJxjWDpZ+bHnjgXXyunpGvG+MFgxinT5fw6oRs3D3K1fylyeTn4Krq0y/uCY5cmZhs+BsawrK/7GFvKN5Cus+aMcNJwThMEoTerQC52k8Jo2Ht8eXPNMCPkMBc6cbIxLbD43RvYQiDEEt8byheOGr98u6ZVNL6Bw8guzg3ETjtR0lgAfs+GZqaF7Ectj08ZMEGEnetoLPPHrdxPCB4hKzm6hYMeIC/NP7Ud5+t7hKDylbOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tmu7m5XP85gJTD+USd8xENxix08xDjzRP6dbvVqfAY=;
 b=aPGbNGdwGX+75iL1n++8za3yZNwmJNcovMmAx4v/n+5EvMpPJSlgNohFtNYvuaYhko8XD8YCuxpcUI4WdeizXfTWHhXrA8JluclAlf0YNumOmVC4f6fqDFwrW4oWVK46NlOY3WsuPQoZgj2nQicumshC1B+UdmoEFQny7c9Y1XTMaqeb1IAh42q1B7O9DxoQbCdTG7UyXjrfi4VQH/rV79EN+SIkcPdpRr2rGrjH5lrRGxfj7hdAX1MfsQ4yL1lVnhYdnmM54mBBT+Lyzeu7pNf9RV/vFAXkx7cUy4uxNZTDy9D6381OW+gj/LDeTigyOW+bRxoQQMd0pOCRbSGH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onsemi.com; dmarc=pass action=none header.from=onsemi.com;
 dkim=pass header.d=onsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onsemi.onmicrosoft.com; s=selector2-onsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tmu7m5XP85gJTD+USd8xENxix08xDjzRP6dbvVqfAY=;
 b=w9Cp8j/Gtu9TNiTZzawftdYIJBH0+qERlsKpJHKN8r0ggUcCjf7qg8ATzqNLL7CVPgybTkTITEC4N/gwq+fkmMY2IMM5Mp2p9rMwnumPd04WylJdif2MXANP+LLrmwLBZOiL6jmM5TRy2zr2VEUMKpiU4fUumduzM5m/iQevq0c=
Received: from BYAPR02MB5958.namprd02.prod.outlook.com (2603:10b6:a03:125::18)
 by PH0PR02MB8860.namprd02.prod.outlook.com (2603:10b6:510:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 04:40:33 +0000
Received: from BYAPR02MB5958.namprd02.prod.outlook.com
 ([fe80::9050:b9f2:336c:edaa]) by BYAPR02MB5958.namprd02.prod.outlook.com
 ([fe80::9050:b9f2:336c:edaa%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 04:40:33 +0000
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
 AQHakZAzTzY8uLDqjU+aLRkJ24TPX7F0voeAgAA2YYCAGHiwAIAAQuMAgAFPWgCAAH78AIAA9q2AgBaZtCCAAA/6AIAABQ4AgAACngCACKHOAIABvDqAgAAGhgCAACuYgIAEK/gAgAQWz/CAACdPAIAABqdggADbbICAAQMcwA==
Date: Fri, 7 Jun 2024 04:40:33 +0000
Message-ID: 
 <BYAPR02MB5958E09553F82C486DE8BDA483FB2@BYAPR02MB5958.namprd02.prod.outlook.com>
References: 
 <BY5PR02MB6786619C0A0FCB2BEDC2F90D9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>
 <0581b64a-dd7a-43d7-83f7-657ae93cefe5@lunn.ch>
 <BY5PR02MB6786FC4808B2947CA03977429DF32@BY5PR02MB6786.namprd02.prod.outlook.com>
 <39a62649-813a-426c-a2a6-4991e66de36e@microchip.com>
 <585d7709-bcee-4a0e-9879-612bf798ed45@lunn.ch>
 <BY5PR02MB6786649AEE8D66E4472BB9679DFC2@BY5PR02MB6786.namprd02.prod.outlook.com>
 <cbe5043b-5bb5-4b9f-ac09-5c767ceced36@microchip.com>
 <BYAPR02MB5958BD922DAE2D31F18241B283F92@BYAPR02MB5958.namprd02.prod.outlook.com>
 <732ce616-9ddc-4564-ab1f-ac7bbc591292@lunn.ch>
 <BYAPR02MB5958DE3C4FE820216153894B83FA2@BYAPR02MB5958.namprd02.prod.outlook.com>
 <79f61e42-c32f-4314-8b77-99880c2d7eeb@lunn.ch>
In-Reply-To: <79f61e42-c32f-4314-8b77-99880c2d7eeb@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5958:EE_|PH0PR02MB8860:EE_
x-ms-office365-filtering-correlation-id: a51add4b-59d6-4178-84a6-08dc86abf791
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?ejqeoa5AJ6z9EcFgDOaKxyUbi2wwH3teCfEZd8d6Nud43uEsLlh56DRsqbvy?=
 =?us-ascii?Q?2150rIi+WC1/gGEU+vqlW+aORcktBTcBKzfe6SpuDNL+xUxDHiyp6AxkqSFH?=
 =?us-ascii?Q?lU/n3lBF0ZdIfe4x8sZXvVIauK+8X6R6vVPq17m7Set13ymdUYrIQ1xdD5zZ?=
 =?us-ascii?Q?vgYycSvKj3AivfjFZo+pooF3/IMGTfk8xgnQacN1ICCxj2z9fDkb+OEWxh9p?=
 =?us-ascii?Q?fULp5THk9uMskim3kdPoCQmKTMeYEwCBZo36h7r08Cmq9YmFxSAMKRlAXfjn?=
 =?us-ascii?Q?DbxZCjmefNpa/zySBiEDr38X9HIC0DFc7SqmbeDujGKrR/hkzvM/JhKtWMR1?=
 =?us-ascii?Q?5BMrooduosscgUuaSd7qw8+xitrcx89C1FuyfJQIlud32AzPnX+gmC8QbzQW?=
 =?us-ascii?Q?TX61kITfXZ1wtEGQ/MlvW2CwVokvu/s75CKdM57krnZvPc+GOf46SuBgk7j0?=
 =?us-ascii?Q?iUJ0km3UZoOJGWhw+SF0fJzaohVNBMYef8rt++ywvY6DPurtaD4amZB1OiBh?=
 =?us-ascii?Q?o4yn9Qp5AtjrBmCVmXytMsLA2X1WZGx/0wfTXmJ5UxLkjs7Xc7lFvxEtpJ6Z?=
 =?us-ascii?Q?3BTbzuamTQGrR0gyKQK2lp54nQoOl5gStpmsnUohzw1tbbRtN/hRq2f/3vXO?=
 =?us-ascii?Q?j9P9kNGH4lLHqp6UG9zodKnAUfKpzWXMZDCS/jAQY0OoXH4/oGN0Y2/1cy6P?=
 =?us-ascii?Q?47qxnnqmvvCurKPNF9CQCqaG0ASFkVqXiZzBhzueqb7ECOJqhMR349MfkWsR?=
 =?us-ascii?Q?t5hd59ZZoClIUTTbS6CERg7ZQc9V7UgL9bv3SluDvZL8ZfqhNjCrinJzY6sb?=
 =?us-ascii?Q?iJft8qdqdKSa6YaDkvdke0tlF3bNAsM6CyUMpfXPs+QokT0arySnMVlTeS6H?=
 =?us-ascii?Q?7FU7cZqZKlcxSxu8fz1Ros2IRBHz5+2Xp8EzSXe/fPpesq6wy4KEYNyazBCK?=
 =?us-ascii?Q?FV2noiOIcMHgJtHqKLiivJu5UQMI9UZtKeCQ6maE66bWzT1A+fTkUEB4XXt2?=
 =?us-ascii?Q?jY3CF8UajWPhwrbYtPinJ1m4WhcVpcdsoS7+tcUWi1aYQb2K8r5Zy3/6wvY2?=
 =?us-ascii?Q?No/Ea7NU2HMRHHNJLliaaSHxz5PyiLCWbHM9+ZW3AwHUXtUOI3y1KeIY0Y3g?=
 =?us-ascii?Q?E+7CkyxPHBKiR5j07QIITY0HLc5fJnUmMhQTlUcmzHWfNJJrxNh4w8kb8pv2?=
 =?us-ascii?Q?bGwGQC6ReN4o3vq6QPpL7OpjWFL2Yk+WEps7W0KaN8lczcJTxMe6ay36sldj?=
 =?us-ascii?Q?dlcrSO4b1+e+9Mrn78XcrX25o/h00hSjSasAwTKUQncYMUmwUwpwvNXPs19t?=
 =?us-ascii?Q?Vr80frmp8WlEPHQxUuX76z1wM1sfDIbTw2YUjh5xZRd96OS1b17++0jgGw04?=
 =?us-ascii?Q?kL+MJ1U=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5958.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?lh6x+UgYvxzUrsrmDup8b1WOR6THg6HAQODOgpVJvtaQYwHQS7ot4Y5IzvSh?=
 =?us-ascii?Q?4fv9bh5rT2EohfE1tAfisd9hqXFaVj7Aj0JzxTBprspC0S4nftevjxHNAaNf?=
 =?us-ascii?Q?bF+yw6TXyJs1jLoZpBYCNogrgnYDVTnsc1B63K7SAVR6FzeEcbllXWPf6PKP?=
 =?us-ascii?Q?QrcfAclvLrOnQEGF4kZ6ikkgRo/u+bf9PCiQ2l0rzDursWM/z6/EwNZW206F?=
 =?us-ascii?Q?uHj4UaWuvkUy/H+bIC50WK3DbDzaI2jJtyPIHEqxGwZMN0F3FXvyRiXiv02J?=
 =?us-ascii?Q?J1OnajjSjo0vhq8dPOl9N+yQDSYEMCelUzmBr80Rm+Tzvu/HpD8bOLIuUlWZ?=
 =?us-ascii?Q?kyuDTiiLu8KCdupji/PGOLQEjRBSTYN7E+ncoyZQDWFrFLqiu1FpvKV/EFKp?=
 =?us-ascii?Q?uOOHnaseb+cTJ13D9Vjvi59Lllti/WPofxcSokufUZq5YP/JDCBGKI92Z9Hb?=
 =?us-ascii?Q?bekgl32CtBqZ7CHoQwGQVcyuU6HaxzYvmmWdrfWaC2JG6vALDlxv9ZRUDCLD?=
 =?us-ascii?Q?Zk19zQol5aIQqFZurhv9AK1ub1PaCIaA2wSekJ3BFZtUMWfVqPorKZ/curCO?=
 =?us-ascii?Q?wni9CKAZH5CehPFRB1usjO4pYlyJfxxVkOj5maLul8CP+5q8SG5UQ+IPYDGM?=
 =?us-ascii?Q?X6NpgPPh3aT3GigIR57XDYuS99Why1ZSo0ouZ34emOjll0wTpF3PiLxH6tu4?=
 =?us-ascii?Q?AlVkqW+JzFvcmn2qLhxJ9TeCWUysXsHV0amjmQuV2XWvzYTI2mkglESCjaB1?=
 =?us-ascii?Q?WywRRaRhunzmW1zqyxnNpr0HFGL8MdHA6B1m0kAbucVKnegoeMDoSnz72NSX?=
 =?us-ascii?Q?ZjERo8sD6sHGgscrclsfJwyB3+bC1Upm7ht0U8oXyhHJjvjb9bStsUno81IP?=
 =?us-ascii?Q?ZPm4DNxONr64Fi4ytgspxW1GAJnC63ia0A1J6R5nll5csoBjVn1240Ihjo2C?=
 =?us-ascii?Q?MY5l5tLUL1YUUKT/fdkWRyPaEI6bZsPcic8conuW9bxOVM+amDpAG38adNUR?=
 =?us-ascii?Q?YvJJY5mMpwTEi4xJZV8tOeJx5gDCCrGqBFm1K245U2nwbrA6sGr71wrGwlBg?=
 =?us-ascii?Q?IhV80ey28t/hh4qUaGClQQR4U8KAMWENpXXQGtTdGe/pPuBVHmNCY36JPYgw?=
 =?us-ascii?Q?ZZGcUnRIkP+WP7NseuLo8PzWnnnBnsio23cftyRLdVWWL8ITbfiVI9kh0sad?=
 =?us-ascii?Q?zKmSiIP92dT6+xr0ulXcNJlPVvZ6m/duAHq72kXfVfNbE7AmZeZayttV7n/8?=
 =?us-ascii?Q?AwNMwqucwO5CkRvL8w5U4YSohMmqko2YkfUv76HGMEH0fmCKLONGIxXsjWGG?=
 =?us-ascii?Q?B+GLZoatm3CcqRbKpuUjALTJXbjWtElMp4AEBxlep9XZYAdx/PO2iYTvOQRv?=
 =?us-ascii?Q?F74lrUAi54PXFWsAzz/MDHZ5SQULYMDbMMYpgtUcVBzN/aSFpXyYvHxEDiwm?=
 =?us-ascii?Q?SJMIL1Dp2uYEn/9T0qrFGFGT1IHOJZs3UNyyjuJeUMwdXtYphGk2wzrX/hPW?=
 =?us-ascii?Q?XXM609jIwligzC9OBMVUnhJTcR1RxT3N8M12I6jQm3Xv/34x9Isg0+xuGbj9?=
 =?us-ascii?Q?RCtsUh0VySUNGwVBXiJ2SgiJdraLfDWTSvWAeCFe6AKqs9QtGzRLbxEkbW5a?=
 =?us-ascii?Q?DA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a51add4b-59d6-4178-84a6-08dc86abf791
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 04:40:33.0401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0yBgYKzcJzdDnakXGpgWVdx8ayn2Ghb1OBqEOD8LakkKHtP/aUpfcHsvCL4AAUUbs8E2m/JkYug9jF/0bF1/OeOmSUCtKwAZGwLVw4eGXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8860
X-Proofpoint-ORIG-GUID: 4Nhxi6JQtE2G00GG7rRnUEzXeFwFE_sI
X-Proofpoint-GUID: 4Nhxi6JQtE2G00GG7rRnUEzXeFwFE_sI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070031



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, June 6, 2024 6:12 AM
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
> Thorsten.Kummermehr@microchip.com; Nicolas.Ferre@microchip.com;
> benjamin.bigler@bernformulastudent.ch; Viliam Vozar
> <Viliam.Vozar@onsemi.com>; Arndt Schuebel
> <Arndt.Schuebel@onsemi.com>
> Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN Alliance
> 10BASE-T1x MACPHY Serial Interface
>=20
> [External Email]: This email arrived from an external source - Please
> exercise caution when opening any attachments or clicking on links.
>=20
> > I believe my client is configured to wrap at 70th characters.
> > Not sure why it is not doing it.
>=20
>=20
> It could be you also send a MIME obfuscated copy which is not wrapped
> correctly?
>=20
> > > > 1) Can we move memory map selector definitions
> > > (OA_TC6_PHY_C45_PCS_MMS2 and other 4 definitions) to the header
> > > file
> > > >      include/linux/oa_tc6.h?
> > > >      Also, if possible, could we add the MMS0, MMS1?. Our driver is
> > > using them. Of course, we could add it when we submit our driver.
> > >
> > > Interesting. So you have vendor registers outside of MMS 10-15?
> >
> > This is not about vendor registers. The current oa_tc6 defines
> > MMS selector values for 2, 3, 4, 5, 6. I am asking, if 0, 1 can be adde=
d,
> > which are meant for "Standard Control and Status" and MAC
> respectively,
> > according to MMS assignment table 6 on OA standard.
>=20
> But why would a MAC driver need access to those? Everything using
> those registers should be defined in the standard. So the framework
> should handle them.
>=20
> > One example I can think of is, to handle PHYINT status bit
> > that may be set in STATUS0 register. Another example could be,
> > to give a vendor flexibility to not to use interrupt mode.
>=20
> But that is part of the standard. Why would a driver need to do
> anything, the framework should handle PHYINT, calling
> phy_mac_interrupt(phydev).
>=20
> I really think you need to post patches. We can then discuss each use
> case, and i can give you concrete feedback.


True.  That would be better. Will work on the patches so that it is clear.


>=20
> But in general, if it is part of the standard it should be in the
> framework. Support for features which are not part of the standard,
> and workarounds for where a device violates the standard, should be in
> the MAC driver, or the PHY driver.
>=20
> 	Andrew

