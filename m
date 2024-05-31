Return-Path: <netdev+bounces-99772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3078D6572
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 17:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057C728CDAE
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865F476020;
	Fri, 31 May 2024 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="nMVOdp7I";
	dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b="6qEiFc4d"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00183b01.pphosted.com (mx0b-00183b01.pphosted.com [67.231.157.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EF97442E;
	Fri, 31 May 2024 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168456; cv=fail; b=XvYPhkngV5Hny1SPYX6VHTvnUh3M4/FZvOh3IP2SIKAQVFEMrPU+oTEtaF0p3ZscjDElJZLIIRh0NpiAA02UpZtnQRptEROTPR5x5329kxs9JDIXoq74hC480HM5T189IL7JHD2uKfntsVdhVg7e6CZrKoT26Ao9OHb/m4PQloE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168456; c=relaxed/simple;
	bh=Aw5t6EowC9fFGMmf2DlfHMJe5/aa7W8ochlh5Rs/+/A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gLeYcrTxZG/MKxl0e8FloVGbOe07FQ+ZME1zWxxCfYUPhHdjcxivC9XtYTMxk3UHp39qhvFr7LxBvSGyxPMyi2dB3uE1DuC94/m3F6wVOq0CrPyJhzXHfb0+k3qzvZnUPlJe9AUiXeZgUF4vwBzjJ87xoDwAd1JHkEYVZHRcC48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=nMVOdp7I; dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b=6qEiFc4d; arc=fail smtp.client-ip=67.231.157.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Received: from pps.filterd (m0048103.ppops.net [127.0.0.1])
	by mx0b-00183b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V7cqa5003593;
	Fri, 31 May 2024 09:13:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pphosted-onsemi; bh=4MCHxlPW0tvPrzMvOXUliXuyrUP6g/xGPOK83AZ1bDc=; b=
	nMVOdp7IvgYDFtmdYlGplW3GLP2NhZ4cTf3mjd3RUTyn763CtxJXBzQq3OBgRgY5
	vgTu90bUSWPZfQZka75OUVFKbx6Q60AXdgEWucrepmvbY2AUVgVNt5Nlw1G0jefh
	qYLBbVAHrI2uKK+mFAFWsU5qgE/E6UgjUQhcNeecl1iYLyYvZIS8PbKWGI9iVmQX
	2184PsGCdtybHAbbyuH5QOnhDpaXBccyjHRUnWRE+TN+tLmk6eJE6KD8AtPbTgPV
	xkptQzk7qCyBshYggJqT+ujxVsgMFOG/4sMKoZNq4Bo3NFX3B/RHIzM8hsI4RtOC
	h87C1nvOCSNy20yatq6LLw==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by mx0b-00183b01.pphosted.com (PPS) with ESMTPS id 3ybcw66db2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 09:13:18 -0600 (MDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+80tdxhvrUV9psUXJukxoM2SYwRkesbMCt9zEwI79XAHM0IVfFW+wvbSImzp5ejvawStoLv4Rp8gW1giKOp15O1D8bLQfjxRChNzH0FQ5Y82eAH1CSigxzO/qrY3ys8uuSFTTBiPZXWFsisNRarRULsusRktuqSwauKEgd1jHG9gRjtdEgO7D78Ec+eB0w5n+UOXFqFBHC/bLU1/OpLtVpD/wx55Dbuub/1RuwP27+fVra9xAvckjXz3JYt9f5LGk+0JuZOi5YZz5UMbgB1hgH7tnv04mG4FEwfdp91fZwtAehwvxl5QxKxVG2OO3cF1nfmDhHxqyt4WqiMJWRHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MCHxlPW0tvPrzMvOXUliXuyrUP6g/xGPOK83AZ1bDc=;
 b=k/ejTAfN9TYwPuMcSbMWVXLYFhhpT8oKNh+KFzk4GrB7S4tuoHoa2SC0scOhlPGoJB6ij3Tq+DHRLSc3kMOiwKprLC5kRLjfUnWOuszvcg4bPbe2Uq1aVxjIGK4RllC45hTBAFHMHpcADDUHUFruOjX4sD8fhpDmhbZk2A2YMYXit/7mbLrEqiXoKslLrkxh81Sc43/higfn0txhJQXIV8qccXcf5n4Si3UX+JzuiFT5musX7unfopLqhW5I49fv6pWzwW7742RD7vgXJ8n1tF37tFmICx4wpnan0W34IGPiUOaALlcBRxgCB4uvbq/NXrqAgIg8qWk/23Z3NPaV9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onsemi.com; dmarc=pass action=none header.from=onsemi.com;
 dkim=pass header.d=onsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onsemi.onmicrosoft.com; s=selector2-onsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MCHxlPW0tvPrzMvOXUliXuyrUP6g/xGPOK83AZ1bDc=;
 b=6qEiFc4dgGSAYVKbbyyvqMqNUHhndqHS9wSAsaaQNXrMCg4lFqfKRs3Ug83yWzx2HVx+6Gl5H7PNzPVp5XOK+qCCn8E/8kvRqNmJNU9vRF0Z1L7ipW8pVRPNLMP/bbFN2aIUJMvSCSxrSjtd22AT+ZLA0Lxd6iLgQuQxj3VmZvw=
Received: from BY5PR02MB6786.namprd02.prod.outlook.com (2603:10b6:a03:210::11)
 by CH3PR02MB10217.namprd02.prod.outlook.com (2603:10b6:610:1be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 15:13:15 +0000
Received: from BY5PR02MB6786.namprd02.prod.outlook.com
 ([fe80::5308:8de6:b03e:3a47]) by BY5PR02MB6786.namprd02.prod.outlook.com
 ([fe80::5308:8de6:b03e:3a47%3]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 15:13:15 +0000
From: Piergiorgio Beruto <Pier.Beruto@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>,
        "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>
CC: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
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
 AQHakZAxosrycArunkaHEujJo3A4abF0voeAgAA2YYCAGHiwAIAAQuMAgAFPWgCAAH78AIAA9q2AgBaf7QCAAAnBAIAAAr5ggAAE7gCACKAxgIABvdeAgAAGhgCAACs4gA==
Date: Fri, 31 May 2024 15:13:15 +0000
Message-ID: 
 <BY5PR02MB6786649AEE8D66E4472BB9679DFC2@BY5PR02MB6786.namprd02.prod.outlook.com>
References: <6ba7e1c8-5f89-4a0e-931f-3c117ccc7558@lunn.ch>
 <8b9f8c10-e6bf-47df-ad83-eaf2590d8625@microchip.com>
 <44cd0dc2-4b37-4e2f-be47-85f4c0e9f69c@lunn.ch>
 <b941aefd-dbc5-48ea-b9f4-30611354384d@microchip.com>
 <BYAPR02MB5958A4D667D13071E023B18F83F52@BYAPR02MB5958.namprd02.prod.outlook.com>
 <6e4c8336-2783-45dd-b907-6b31cf0dae6c@lunn.ch>
 <BY5PR02MB6786619C0A0FCB2BEDC2F90D9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>
 <0581b64a-dd7a-43d7-83f7-657ae93cefe5@lunn.ch>
 <BY5PR02MB6786FC4808B2947CA03977429DF32@BY5PR02MB6786.namprd02.prod.outlook.com>
 <39a62649-813a-426c-a2a6-4991e66de36e@microchip.com>
 <585d7709-bcee-4a0e-9879-612bf798ed45@lunn.ch>
In-Reply-To: <585d7709-bcee-4a0e-9879-612bf798ed45@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR02MB6786:EE_|CH3PR02MB10217:EE_
x-ms-office365-filtering-correlation-id: bec7774d-b570-464b-577f-08dc81843235
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?ZONTsivknfWcFMJJryE2rE4nt2NgPDQ3x7G/w/vsZLRo1GwENdH5cSCnX1G/?=
 =?us-ascii?Q?IWgz7LEQNwwq3bC+TfkAJJY+Zro0JhxkGhl0fDfrTnRkChQKdoeZy0sQnNMa?=
 =?us-ascii?Q?EwLnuNldzwijhzZhMvcPr/ZDI4faW1k2rNP3lJjm8RvkWO6WlI4OkmJT97uF?=
 =?us-ascii?Q?YOLIga7zF8WJsgvrFIe/uP5oMZru5i1CLq0ppcVsIpcHyHcnKh9BPuh0S1JJ?=
 =?us-ascii?Q?ZrVNwg3y0GaVVgxuSusBevZkN/elMFZXSmUZtrtgS7CIkeRKHcM/qlpCUZJe?=
 =?us-ascii?Q?iu20ZkaP2tqbPtQqi/sVJk2YoQ8sTNDcZWYqgHiYdaT3GuTG8+/AwmaMqz2F?=
 =?us-ascii?Q?HAjFruGAI9zQmsXARW1HeZrgggPQce9TSzmDupEbey1r81MO7GzwD22bJzgJ?=
 =?us-ascii?Q?7S2hBH85/ZXkxFNFy/G7+7UvR/24MaH4884uvoqe92S2NVQdGCUb5GkIfOZz?=
 =?us-ascii?Q?FMDGKrsiXxpdbD0/WL3SCf83zelcnmpcwt8Dhax7ZlpzkLKNMQoAJBxLLAEg?=
 =?us-ascii?Q?f6ebJuDqF5N7FpErfJ1Qqgqu2mCbyQnq9I1l0edurZbEg1aP8UOY2YnlcRP0?=
 =?us-ascii?Q?XGZy8sGB2JHTKACRkb32j5KJAngzVHpp+mJZ2wLrk1E1Un4plr6lW5rBntT8?=
 =?us-ascii?Q?+ow5ay2I2xNUGHwXucPcRhoAQ5K1EFrDA04CfbLnzPsXf6PlVyzGId0YMGji?=
 =?us-ascii?Q?ehx1VC/7wg6NyJWdkLktY//WYiu/IHVCwzgSq5KoYAsJRq18E6HGWgCYeC7j?=
 =?us-ascii?Q?pZMm6H6Rj3g336Eh/BgOo6XtohnZi3YmOL67ShLMP0zsR9LeVm1EGCKFcOhf?=
 =?us-ascii?Q?IPXxHnKYV7JLVnWTkCB3dIfl1axzL198n4o8GnqBfFsOCEafcgMk392WEuTh?=
 =?us-ascii?Q?CKPk01GvXGizvKXnsBR8uSouvkovb71vu0+AdhgfScPpPpgVaW4Z9e9FlNBG?=
 =?us-ascii?Q?EIypo3HiInBN3lD3MbrgX25bgijSOlV3+hjGt7PVjGJdKjRrJRuWS5elNa75?=
 =?us-ascii?Q?Ww3uGeEcDsKciEDMUCvHwwcUud5AycMhIWPdmvpbsDUcKInTPTqFCogH0KIf?=
 =?us-ascii?Q?/vABYVYOfO7/q9LyTx4UWgETU0ohF99lV6TNZMmzvAtkopnVCDUv50KOJlIN?=
 =?us-ascii?Q?K12XdwKA0XZKl6fpRDokdsbuzjqUTySC/9LaKxLVU2ztEBKEmZg4q7vnOBfb?=
 =?us-ascii?Q?QAjL+tyChXYy+QJoBXwsL0RY3V85kzSI9oGwEZsvy7nNxwOTXIAdAidvR5zP?=
 =?us-ascii?Q?P0/5OMVQpdVDWpW7zC4FeiPRbS4cMzTKypGF3c23VA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6786.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?/NzU5ajPv7Gbt2nQ6WyhRDmCyOHTCg5li/sasxEfG4DE+ZNIpOxHbd7faD0b?=
 =?us-ascii?Q?2gqe7KvSfB2u4fp338Vb2Fsnvi480dowkc1um+r+2OO0NZjchLRohaXOdZpN?=
 =?us-ascii?Q?xzYt/T2ss+2xDLchhqZWYD0Z0MsZSiWNaQ2bnKmT0Yk5oxVAB5A9eX9DroC3?=
 =?us-ascii?Q?vd0OPqxzvpRZJ7tvnzc6LkkslmGXF3MAoI3pOkRGgN7AJaWHzNMU4JlfOQg4?=
 =?us-ascii?Q?Nb0Zpym5tROp1rUiCOgHSR3yk76ly6ubsCFpyFyzi1GVD1AVcAGH6s1Q30X9?=
 =?us-ascii?Q?cXbmTJ/UkRyMdYQdZQIoovd7dvCHl3xTPf98eTZSZtTd4NBQIEfuOcezh/0e?=
 =?us-ascii?Q?YHl4w8+/oRW7o4Rbzd4R/xOGrzP+eOH22h1pjzXqOn8csymtTxfy8PgknY3G?=
 =?us-ascii?Q?bUJ7842wQmsgHujLwUrTvyNvCNa1BsETDjZ6+FqG1cdf3F2UZHoULV+dnv4o?=
 =?us-ascii?Q?+7XBgoTuzrlAOdGVAQTiAvD0TRT7V31Pm/iq/Fg5mJNZ+6fyswauIyMMUw0M?=
 =?us-ascii?Q?q6OR3OIOq4IxCOipB09xiquAda1aVvZd3X5V+8UK4BoWJE2r2PSL/s/EMYge?=
 =?us-ascii?Q?tkQ7dKlCici1SGCZnKSiRal5IeqCLUb1m/mp2o77dbuyeVYTkqS+ojH/0U2w?=
 =?us-ascii?Q?/N3wCCC0Rh+h7JIg1LeOb3Pm8MlhhxB9z6zywsr3K9QKTMmf53tzTPv9XSqb?=
 =?us-ascii?Q?UoJ7Hisgn3we2is6kilDBu06gZINwoeVRzDSKjgAkVkO8JTkrhVxYcSpLeVi?=
 =?us-ascii?Q?jnfOP0+i625F3i5fu2PPtizg68dyORx32mqirOYX1PHL4jlJofqtKgnBeITu?=
 =?us-ascii?Q?Io6lH0mVx/8Zm52araGacTn8Ff6OgfBbBdntoW3A4Mrb2y1PB0sPngUD0ut7?=
 =?us-ascii?Q?5CPsB2z6vbgaWAALMv8IWo1nMtRsmD702whHZ4P6DKrKqgVac47etpShhUcO?=
 =?us-ascii?Q?WrOP5/QtkMcggo2cewgzkJFvYaPDVMZuv7H1RSxIC1kJzBLpHnWmixVs2/ic?=
 =?us-ascii?Q?au8RepqbbTtPTyGyYM98lA5hwRN5+obuMJ3Jko7imeWD3EjcYm6pHjnO6gR8?=
 =?us-ascii?Q?cagXMXJH4IU0swJTwXLOgGoq9pRb+Mh93EPqkrpG6YM4VX6gorpjpGYZyPtj?=
 =?us-ascii?Q?YD4q2DskIytZTmgI7H8EUiiThmB/0bBj8ipzaUFyyqbjWTUvD2yb3G8R77vz?=
 =?us-ascii?Q?CMjXKJTpt7uOsxgqq0B6o/PkOkgmslTWUvwXgnQtHNbrovQyQ7IYK9AFIhhl?=
 =?us-ascii?Q?i/inGA6s+2qAx21KiNfWEdxRy08nTirrmS86vtSJ25REJYqZjYai+So7OwZB?=
 =?us-ascii?Q?dbeRZ2gNDV7+Iq/M42sfX/UsTeRnYZF7QmFvlqJUekLc0c2JBXIiU1qt+y6i?=
 =?us-ascii?Q?oL9Gipb1AYAbROIgH7OgXiK5NECNeHe43W+y5mMzbQl6UNoKmoadEn3LVYKh?=
 =?us-ascii?Q?BWhnP+ktWfcCSnjlXg8uA1++1RF2PD16gW/5ALxKVTRpmyqQkyQCa8VKPJ+7?=
 =?us-ascii?Q?sfqqfCbwGzyfl9+g1k6lyTK3eKiGDw9jk5dCdhF9Qk++hWxKREHDKiokTJvH?=
 =?us-ascii?Q?oPxNv8en5Zag65+3F2RbM8iC++fkBhnx8nq3X+rL?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6786.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec7774d-b570-464b-577f-08dc81843235
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 15:13:15.7519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TZjmorrIgnExOJaiMHZuFlsK6G4dtH58fUQKss9ZiLKvQ7CC2fOGUyks0GVK6TfZ0YkIOZdZEVfqTDaPOzfakQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10217
X-Proofpoint-ORIG-GUID: Gc3KMUy8PgzJfzHF_QGZTcS_WwWucuyG
X-Proofpoint-GUID: Gc3KMUy8PgzJfzHF_QGZTcS_WwWucuyG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_11,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310114

Hi Andrew,
We're currently working on re-factoring our driver onto the framework.
I will make sure we can give you a feedback ASAP.

We're also trying to asses the performance difference between what we have =
now and what we can achieve after re-factorng.

Thanks,
Piergiorgio

-----Original Message-----
From: Andrew Lunn <andrew@lunn.ch>
Sent: 31 May, 2024 14:37
To: Parthiban.Veerasooran@microchip.com
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>; Selvamani Rajagopal <Selva=
mani.Rajagopal@onsemi.com>; davem@davemloft.net; edumazet@google.com; kuba@=
kernel.org; pabeni@redhat.com; horms@kernel.org; saeedm@nvidia.com; anthony=
.l.nguyen@intel.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; =
corbet@lwn.net; linux-doc@vger.kernel.org; robh+dt@kernel.org; krzysztof.ko=
zlowski+dt@linaro.org; conor+dt@kernel.org; devicetree@vger.kernel.org; Hor=
atiu.Vultur@microchip.com; ruanjinjie@huawei.com; Steen.Hegelund@microchip.=
com; vladimir.oltean@nxp.com; UNGLinuxDriver@microchip.com; Thorsten.Kummer=
mehr@microchip.com; Nicolas.Ferre@microchip.com; benjamin.bigler@bernformul=
astudent.ch; Viliam Vozar <Viliam.Vozar@onsemi.com>; Arndt Schuebel <Arndt.=
Schuebel@onsemi.com>
Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN Alliance 10BASE=
-T1x MACPHY Serial Interface

[External Email]: This email arrived from an external source - Please exerc=
ise caution when opening any attachments or clicking on links.

> So I would request all of you to give your comments on the existing
> implementation in the patch series to improve better. Once this
> version is mainlined we will discuss further to implement further
> features supported. I feel the current discussion doesn't have any
> impact on the existing implementation which supports basic 10Base-T1S
> Ethernet communication.

Agreed. Lets focus on what we have now.

https://urldefense.com/v3/__https://patchwork.kernel.org/project/netdevbpf/=
patch/20240418125648.372526-2-Parthiban.Veerasooran@microchip.com/__;!!KkVu=
bWw!n9QOIA72sKA9z72UFogHeBRnA8Hse9gmIqzNv27f7Tc-4dYH1KA__DfMSmln-uBotO-bnw3=
PC2qXbfRn$

Version 4 failed to apply. So we are missing all the CI tests. We need a v5=
 which cleanly applies to net-next in order for those tests to run.

I think we should disable vendor interrupts by default, since we currently =
have no way to handle them.

I had a quick look at the comments on the patches. I don't think we have an=
y other big issues not agreed on. So please post a v5 with them all address=
ed and we will see what the CI says.

Piergiorgio, if you have any real problems getting basic support for your d=
evice working with this framework, now would be a good time to raise the pr=
oblems.

        Andrew

