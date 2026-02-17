Return-Path: <netdev+bounces-259035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDBeBlpylGntDwIAu9opvQ
	(envelope-from <netdev+bounces-259035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:51:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 421F214CC36
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 496563001FAB
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 13:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905A036AB72;
	Tue, 17 Feb 2026 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="lsNUQau7"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022107.outbound.protection.outlook.com [52.101.66.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE29D4C6C;
	Tue, 17 Feb 2026 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336273; cv=fail; b=VeoDRmlUPQK7P/3olG33UcRguJe5YfKqxInCgP6OA85DSOYPCjpphHXz4QvywdcGmh0VJRtaM6/M6pM5fV/P9jL+svhaXxWSWZOSaucCGRpVmQSO8QcRHz4iUk+MpjQPEJGa28pswoQanexeW8kiqk/B8x6MbSXD6upZk1EQahk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336273; c=relaxed/simple;
	bh=EB6TvqFti5584/DM/i/r4Ty8Ok8QPPyxfV7sIgaJXiU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JNuUn/OfRRvsOEdWxBEbdS4Mz+Vazed+GwEpfQV6gZFrgAQyqUEKI48aFh0rnPo/3tK+FiqJPJ5NghynDebnUIXrpf+fdx1e1Fhq/asCKLd7M8wExAujcHd1Xx3/WyGMj+u7QY1Epz7ejRxG8ZkVEe2q68jhseYgqo6cxRw94RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=lsNUQau7; arc=fail smtp.client-ip=52.101.66.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WW2OTK1sR5W2LZN5LDsN51IEWM0HJYR3Cl9M/PcersbCBMuMF7Fz8YmhepKc7XtD9KJ52n7tWwuHuFD2T9NYQdhGa5Disbsat63YK9L9ZGeoIYWcKtTyrzpEtDCXvpTCTU2YS/iqDjFAIT9JsiUvfy0czDhCBx1QxQ48u88wUg6E6TtxHXR7MrIVL2ylZsZVRS2mnk7Iihtulhluc94ezeMuLPkiLwPun6KLCWkRG12OMg3wOR+8HcS40ktSfQ2cW1z6tRPEa+WsYALNsVH88CYg/XvrSBchot1ueVWRFn6CGUnp4ls58Zi7JNG2VrXYh+cONulhqNZl1O7wsjx33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EB6TvqFti5584/DM/i/r4Ty8Ok8QPPyxfV7sIgaJXiU=;
 b=uFrrRLu7ELLAPXNB0WBIM1kZtexDRZ6oDV84PI8X15/9NkS6F1yl8GkdKZSMpHUeFWjOco4/86px/Z7brCFX3CjC6TWVF0HH+kJl5z6LnVI67JVZIj4AQGKXHgBy/VsASX+PMCG3Kc2Y1xSSxgAjQwVMF66ewuAHr5PtXKAvgSJA/vVY24Bd7oRlWyHa7obejDjffwnzT67H284N2VBlgaXLGTxTVbh9doW9YA0sYtIidKvs+kjxDVwqPA7X9OwSHQW8X9wTzS+rP0BZkzXDiM/JRDlVhyR70QsbwJG/DThK8ZuGSrMQH22GMc7s7mgNf5avugTgQ25VIGyok7Kxtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EB6TvqFti5584/DM/i/r4Ty8Ok8QPPyxfV7sIgaJXiU=;
 b=lsNUQau7t5xgJtwZB9u/2C/WzGVrXTYZwlY7xy85jq1s2g34+wcOwX398Fw3R9jM5EJHe9RmQxv3JwU5BPKSJdxjcyw12c8RcG6s/cl/73LRmDlSziu/KB8v26pAR0+GQ0JSX+EIOeqjszyFPUTOS6JvPdjGXm9PElYBtQqa6T3krJiZZXlcQiBzKcu/LQjHyq5IdJzpwfiwV11pU5HtNBzpqLog9sNCAcjYvdGRLaMp94CsqdAuc4AaFonGWGUDDrofFjswfb1ybAUaQjStJlxDG3ftnNdSCVht3d58hUtzTJ26tqVVj0lM2vAKstDg/XP6TCbN0+CpluiuCoYQ1Q==
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:297::14)
 by VI0P195MB2738.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:2c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 13:51:05 +0000
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::efce:766c:909a:9335]) by DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::efce:766c:909a:9335%3]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 13:51:05 +0000
From: Teresa Remmet <t.remmet@phytec.de>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "robh@kernel.org" <robh@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"afd@ti.com" <afd@ti.com>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	Benjamin Hahn <b.hahn@phytec.de>, "kuba@kernel.org" <kuba@kernel.org>, Jan
 Remmet <j.remmet@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "upstream@lists.phytec.de"
	<upstream@lists.phytec.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Yannic
 Moog <y.moog@phytec.de>
Subject: Re: [PATCH 1/2] dt-bindings: dp83867: add binding for
 ti,output-impedance property
Thread-Topic: [PATCH 1/2] dt-bindings: dp83867: add binding for
 ti,output-impedance property
Thread-Index: AQHcmpxhWRkMKA1T7UebNhPB945cELV9dLMAgAAUFACACWrqAA==
Date: Tue, 17 Feb 2026 13:51:05 +0000
Message-ID: <f9b4672deea9b555c8103a88a3e08cf0cb921a46.camel@phytec.de>
References:
 <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-0-8deccd658d16@phytec.de>
	 <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-1-8deccd658d16@phytec.de>
	 <20260210144849.GB2675838-robh@kernel.org>
	 <cfe612e3aa7455d61825d94de627caa384628854.camel@phytec.de>
	 <0c021636-5a69-48df-8c13-a320e8f4278f@lunn.ch>
In-Reply-To: <0c021636-5a69-48df-8c13-a320e8f4278f@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB1228:EE_|VI0P195MB2738:EE_
x-ms-office365-filtering-correlation-id: 1436e157-ee49-47bb-4207-08de6e2b986e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NDhnMUNCc2RFMkdwNXl0WUlLajUvUUFuL25mb3prVkpDT1VUOS9RendnUFdE?=
 =?utf-8?B?WWJOU0Y3ZlhHcEcrUzRUcFhBZVJObTBIQ0tQci96U1NQUkdsVEhRVVB2OEJR?=
 =?utf-8?B?anFSWHJQei8vVTRlbUh1SlBjczJNMnYxaitHa25FbmFXanowcHNvRGJYV0ox?=
 =?utf-8?B?VmZFUkpkdTBKUDlFUi9jSk9YekxuT2VKQVVzVTVxSkdUMHhKMmxzRGVDQnZT?=
 =?utf-8?B?d1doQkhXQTRkZ3JDWkZkRDFIbU9uazBmdm96clo5YmFORjZPc1FOczZ0ek55?=
 =?utf-8?B?WEJwejhUa0xLRGpBNFVWTG8wOTNVdzZlaURTOW9IV2lqNStyVGtnNnA0Qmc5?=
 =?utf-8?B?RVhvelhBeUN0MmxkUm5OT0JoZWxtN0VicXVROEVnZzBHNzNLQ21KU1VkUHhR?=
 =?utf-8?B?Tm8xNk1SK0dxZkJ0T3A1Vk9qakRKZEdOblhEcEZXRmYxUFpTZ2pTWTYreWwv?=
 =?utf-8?B?UTNrMnVmRFIzTkszMHdxTTB5UFQzbE5ScUdKNkJkdk11UHB0Lzd6cWJMTjlp?=
 =?utf-8?B?NzB6Vzk4SDF1b3NKSjVINmhpNi9QTlNLcUU4N2R5OWNsVG83S2YvaC9VZ1Uv?=
 =?utf-8?B?dkxOSE10V3ZvdlU1bW5rdnY1MmRMU2FESGZwNGJYSHQ4TU1BcEhXd2ZqME9V?=
 =?utf-8?B?UFV4YVRncCtBVjhNbVNhbUFJUmw0WUVwVmo2K0VsaUMyajMwQklUcDlCZlFF?=
 =?utf-8?B?V0p2b1l3S2g3b3VRbVN2ak1vc2VvNStjTUxsS2pDVStJd2ZLK2JTNGlicDM0?=
 =?utf-8?B?dkxMQ1Fscnh3MEZwZXdzdVkxUDJGM0RRems0TDZ6TFd5enZPUlVvUzV3b0tX?=
 =?utf-8?B?TWZWNWwxSzV4cVEydk1sQUJsV3BzandXeDJsTHE2K1lYZFpIa1FuempqZUNV?=
 =?utf-8?B?eFljNk1QRGJTM2RRL0VyZzFSTUVFNStCVnUrc0lOcEp3UVNkQUpaVitkbnd3?=
 =?utf-8?B?VklIRjhTalhPdzNrbGlJNVBBMk0zVkdKQ3BxdVlnNDFBdzVIa2lMVkY5dTR0?=
 =?utf-8?B?U2FxbndCaE1tSTVlZmpqK3RkQlNBUllJUitVekR4dFBFb1BHU0lPK21Eb3Fi?=
 =?utf-8?B?by8xSi85NVVaOHRJVWpueU42MEhSR0pzcmZFbFBLaHFkekptVGlWdXErTlgw?=
 =?utf-8?B?RGFuQ0xQVkRxMDhqZTh6YUM4enIrZER0QzVFazJia3crVHlyQzVXQUs3eGVW?=
 =?utf-8?B?dEhGRFRST2Vibks2UnFLeWVQK3FFck43SUk3ZTRTQkw5dnIwVExlSjdGbE12?=
 =?utf-8?B?TVB4bk5KLzBUbDN0dFFjbVo3K1hybHRZUVVEZmJiZW5NWUl2Q3N3SVpIWUJ0?=
 =?utf-8?B?amxFT3NlbWZHTkpJTE1rYUt1Y2VvUlZYbnpSc1dsUERKdFdHS2NFbmVHbmJq?=
 =?utf-8?B?Q1JMaGViRjNRbTNPS2VQR3VDaFMwVXZFc2g2VmVHbmtzTTFSemVlb1UyK05I?=
 =?utf-8?B?akx6S1R5MS9nUmVBTHBtZ3ZSaUJLbk9UYVJ3Y3NEUUcrbW9WQmF1Q0w1Zkhi?=
 =?utf-8?B?aExMVlRxMXZLUjV3NThiZE5LcXRzM0xLcEtEV1FwUnJaeGN1bmNvS0ltRGQ0?=
 =?utf-8?B?S2FmSHFtMnV4ZHVtTDZ0cE5GdTEyUllIY0IrY3BjcWtqajZmQmV2QnJkSi9x?=
 =?utf-8?B?M0F6d0ExSjd0SVNvUnh6dGdRbVZvWjZ2ZHV4VEFkY3NKZ21OQXZ3d1p6ME0y?=
 =?utf-8?B?UFNNc2lkMWZvc3ozbW1oZi9Fam43cWJ2VmNHMHVzdE1UMmV4WVNaY3pNRjAz?=
 =?utf-8?B?eWxtcnJwOEpjcDV4YXB4alNTaVBzTFJnME1vNWVJM1AyZ2Jwc2RBNWhVSWJE?=
 =?utf-8?B?dGZoV2FrVStjWnJZY3NjaHlEMjJjVTg5NWY2TFBTQWJZVWs1c3ZsSzF3d3NR?=
 =?utf-8?B?V2RxUVB2WHFaQmM1ZDE3UjJPTitXUGFRelVzb0hBYTB4QXZkSEpWOFdOVEl2?=
 =?utf-8?B?QW5lY3hKREdzZm90NFVDUEtpVnlYc1lFU0RoejQwd0pScUJPMUgwZjFIZis5?=
 =?utf-8?B?SmJjbjExeGZpOU5zUVB1cG1ydys1WGlFZGxVME5tc2diYjkzT1BlRytGaUlN?=
 =?utf-8?B?MXdMMWdnODRhY0xZTU8rZi9GbXF6QW9lVDgycUJ5QVlHVlcvTkF0UXVmaEFu?=
 =?utf-8?B?U1pzKzM5bm1ocXR3UXBQWkl1WU4zUnhxZmtyNjVNZHRUWlFGM3k5bDJmZ2ds?=
 =?utf-8?Q?OsoXdaEwQ2obTo7BeuCkj1GVBQvfTKwP+u3uHRaGU43T?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P195MB1228.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3BnQlJERVd2cEFIdkFFVnpGMUFtREZvZUQzRjdpdTBVYkN4cVVnWGNJekYw?=
 =?utf-8?B?bkZ6eVhlcG1qK0JWUHhucVdDWmxrNzFMUjRyMlJVbFJVUnVLSW9Ldy8yYzIr?=
 =?utf-8?B?VmRYRXROVVFDUXZEZlVqY0pHQXcxMk5sZDMyRXM4bXNwbHd2R09hd0lZSTFQ?=
 =?utf-8?B?dVNQcHg0bEliMG1jbDBFeXRoTjgzR2ZKcGR3WFVCaU40RElRK1pPN0RaakxH?=
 =?utf-8?B?dnNpTkc4anZDNlVKbEp0UktiTzVlTHJzY3YvdDdtbUJHR0U0d0IvdmtGT0FB?=
 =?utf-8?B?VEtzWEtvUlJWRktheGk2OGd2bXg1R1hvaGtYMzk5OVkwOVp2TkthbVFkL1Ey?=
 =?utf-8?B?NEo3OWw4ekxMQWtJdi83Wi9nMS9EWktqakdxUkhPT0Y1dEVBN0doQVZ5WHQw?=
 =?utf-8?B?b1F3ZmhoRDZVU0V2Sk9vUHpxQit0dlJCMnVadUhhQndOTVJRS0NCdTNWdGV5?=
 =?utf-8?B?dWI5bm1kanFmUWNOc3lHMTNpUzZyL0hnc0hwdG5PbmVxWkNueWhmTStGQ1h0?=
 =?utf-8?B?d1dpWTcwUVRkTXNpRTREeDRyZGNYcFlEejZSRTBUVU5IWWtWSk5GcFE3QVRX?=
 =?utf-8?B?UW1xYVNzdEM1QjZoRzdEUDd5Ty9ZVUlJZ3Vzd1poRlExbnMyZ1hrTTkyWGhB?=
 =?utf-8?B?TmpEbzlnQkVKQzdxamlWODZqZTNxUEJ2ejJnRHlHNEt2NTFKa2lueWFnM3NH?=
 =?utf-8?B?VkNBclhqR3h6bnNzNVdmN0I0bnVjZFE3d0t6RWNGYVBjOHhkV2lBdHNqNTQ2?=
 =?utf-8?B?T3pWU1BKaFVYampZZ0xNMVhIS1dOZ3Z4TStUeklsNjkya01QUHNldmF2N3Ni?=
 =?utf-8?B?cUhac1oyK1d5NDdIVXlRMkkvYUxNWEI2OHNaWjVRUGYyTklsWWR3ejFTU2k5?=
 =?utf-8?B?TDVtNkRBQ1d0SXZwRnBDc2g3VXE5Zmxkd3NzRGtVZWZveXN5bUd3WW9kMmFR?=
 =?utf-8?B?N0JPQ0xIOUZZMHhIVE9GcVZoVnNwQ1RPMmZNWlllaitsQ2hFQlRLbmJjVWh1?=
 =?utf-8?B?dUQ2dHlRYTQ5VGR1dWV6VzhHeU41amNCejZaNU9INXBhVjhvUEhyWitDMVJj?=
 =?utf-8?B?T1V0TjU0WHIxQ2hCYWR0YkpPbm8xKzE1anUrWVl3bWVSYzJnOWo1VENkZ1ky?=
 =?utf-8?B?djNWUW42UlYxdjRIWlZsdGVxZEpHSE4wQzNPZUNaODJ1R1MrQjRVR2M4Z1Nx?=
 =?utf-8?B?VUVxVmlrOGlCMHpmZWRvTkJuZittSEx3SENwenYyaGdub1U0WHNCYUxyYVJJ?=
 =?utf-8?B?Z3UwSTZUb0xWRG45WE4rSzZIWFZFQmVQem5MWE5QR1gxeXU4amNLN2plWjVz?=
 =?utf-8?B?N0I0a0VkK1ppc2kxcUI3NnVYM2hvVHVvMkh1U3lXTC9OUzQ1Q0huS2pOVmdv?=
 =?utf-8?B?VytjeHJrd3hROElPcnM4d3FWbXdyUDhrQ3E1WW81K0UxUUxwdGFZa1BFQjhk?=
 =?utf-8?B?dDVsL1VqRE9FZVFHbmxOTHMvc0xpeENaM25EVWc0K2s3eXlqelhnK0hnUzRZ?=
 =?utf-8?B?K1JUWENTTTdjWjBBY0poVDJUbXVTMXNhTkpjUHJiRyt4dVh2Nk1iWkVGNDV5?=
 =?utf-8?B?OVFiMFNZa0t6NUVObnBlOVEzcmJrajNxUkd0VjZobW1MZThqY1hUZm1WdzFv?=
 =?utf-8?B?NG5OSnFKL3J0UlRua3Jma2E2cmlleXNCNEFuUmVtQTE2NEptMlE3UVdyRVFJ?=
 =?utf-8?B?ZzRsdk1yWUNWZXFac0NtYXBmWVhib0c1STFVMlVBSGZyYkVZNXZmVE15VndV?=
 =?utf-8?B?ZlZvbnZTNVNwZ1kweU1GaytLT09Tend0RG5VTHdvZldVa0FMdE8xTllFNitR?=
 =?utf-8?B?c1p6QmNJSzh5VXJ5UWhnalIwOTk5WnZjZFAveUdTeHNod0ExaGZ1cVJGaEox?=
 =?utf-8?B?TWJjUEw5MlBqb2liajY4ZkFzdjhIbUxQNE05VC9HbFVIaWJTM2czdW82SW5j?=
 =?utf-8?B?MmRmR0J2TTBjUGhYczFCYUwrd08yT1ppdjRIaW9PWHhWMFQzNGxORmVyVWJp?=
 =?utf-8?B?ZFhIcnF0VHdRRk5VOGR1d09uQlo5ZU5reWw2S3VFT3RFc2ZkYkNySjQyVEpS?=
 =?utf-8?B?UjF4dVg0bmQrMXkwRFRTQWN3K3hITjlNR24zWkg0akZQTWVicnNrZ3JRelRt?=
 =?utf-8?B?OTllYk52VDJlK2VtKzlGcTdveWxPZFBKd2VsaXY3c3pUaUxLKzFRSUEzMVd5?=
 =?utf-8?B?V1UrWjFuVTd1QWlLUEE0TkovK1JhbEpleE5YdVBlbEJDRDkrdlhDS1JpTm1k?=
 =?utf-8?B?YTJBeVhpdWpMZm5xSXZVUkJtbXBqeE90RnNqcjVicitZcDVvbWNrQUxJbWVR?=
 =?utf-8?B?WlQwNG1OOWl4YzF5WHl2OG5tOVN0ZTAzZzIxQ21NRndyQ1Y3Z2JlUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F101A33EABFA484E96125358440267B5@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1436e157-ee49-47bb-4207-08de6e2b986e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 13:51:05.3011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4LZPEmNidEIv2UBNkf+jY/eoKCfnHveJhorQIPODLO9JdlTQvZKSgQIcmESotXuLg6wnSpvRir1Etk4BOwGrKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB2738
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[phytec.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[phytec.de:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259035-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,ti.com,google.com,redhat.com,armlinux.org.uk,vger.kernel.org,gmail.com,phytec.de,lists.phytec.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[t.remmet@phytec.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[phytec.de:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,phytec.de:mid,phytec.de:dkim,phytec.de:email]
X-Rspamd-Queue-Id: 421F214CC36
X-Rspamd-Action: no action

SGVsbG8gQW5kcmV3LA0KDQpBbSBNaXR0d29jaCwgZGVtIDExLjAyLjIwMjYgdW0gMTU6MDIgKzAx
MDAgc2NocmllYiBBbmRyZXcgTHVubjoNCj4gT24gV2VkLCBGZWIgMTEsIDIwMjYgYXQgMTI6NTA6
MTNQTSArMDAwMCwgVGVyZXNhIFJlbW1ldCB3cm90ZToNCj4gPiBIZWxsbyBSb2IsDQo+ID4gDQo+
ID4gQW0gRGllbnN0YWcsIGRlbSAxMC4wMi4yMDI2IHVtIDA4OjQ4IC0wNjAwIHNjaHJpZWIgUm9i
IEhlcnJpbmc6DQo+ID4gPiBPbiBUaHUsIEphbiAyOSwgMjAyNiBhdCAwMzoxMzozM1BNICswMTAw
LCBUZXJlc2EgUmVtbWV0IHdyb3RlOg0KPiA+ID4gPiBBZGQgYW4gb3B0aW9uYWwgZGV2aWNlIHRy
ZWUgcHJvcGVydHksICJ0aSxvdXRwdXQtaW1wZWRhbmNlIiwNCj4gPiA+ID4gd2hpY2gNCj4gPiA+
ID4gc3BlY2lmaWVzIHRoZSBvdXRwdXQgaW1wZWRhbmNlIHVzaW5nIGEgcmF3IHJlZ2lzdGVyIGZp
ZWxkIHZhbHVlDQo+ID4gPiA+IGZyb20NCj4gPiA+ID4gMHgwIHRvIDB4MWYuDQo+ID4gPiA+IA0K
PiA+ID4gPiAweDAgY29ycmVzcG9uZHMgdG8gdGhlIGhpZ2hlc3QgaW1wZWRhbmNlIChhcHByb3hp
bWF0ZWx5IDcwDQo+ID4gPiA+IG9obXMpLA0KPiA+ID4gPiB3aGlsZSAweDFmIHJlcHJlc2VudHMg
dGhlIGxvd2VzdCAoYXBwcm94aW1hdGVseSAzNSBvaG1zKS4NCj4gPiA+ID4gDQo+ID4gPiA+IFRo
aXMgcHJvcGVydHkgYWxsb3dzIHRoZSBpbXBlZGFuY2UgdG8gYmUgY29uZmlndXJlZCB0aHJvdWdo
IHRoZQ0KPiA+ID4gPiBkZXZpY2UtdHJlZSB0byBhbnkgcmVxdWlyZWQgdmFsdWUgcmF0aGVyIHRo
YW4gYmVpbmcgbGltaXRlZCB0bw0KPiA+ID4gPiBmaXhlZA0KPiA+ID4gPiBtaW5pbXVtIG9yIG1h
eGltdW0gc2V0dGluZ3MuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUZXJlc2Eg
UmVtbWV0IDx0LnJlbW1ldEBwaHl0ZWMuZGU+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvdGksZHA4Mzg2Ny55YW1sIHwgMTkNCj4g
PiA+ID4gKysrKysrKysrKysrKystLS0tLQ0KPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNCBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdp
dA0KPiA+ID4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvdGksZHA4
Mzg2Ny55YW1sDQo+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25l
dC90aSxkcDgzODY3LnlhbWwNCj4gPiA+ID4gaW5kZXggNGJjMWY5OGZkOWZlLi5hOGQ4YmZiNjhi
ZWUgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9uZXQvdGksZHA4Mzg2Ny55YW1sDQo+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9uZXQvdGksZHA4Mzg2Ny55YW1sDQo+ID4gPiA+IEBAIC01MiwxMSArNTIs
MjAgQEAgcHJvcGVydGllczoNCj4gPiA+ID4gwqDCoMKgwqAgZGVzY3JpcHRpb246IHwNCj4gPiA+
ID4gwqDCoMKgwqDCoMKgIE1BQyBJbnRlcmZhY2UgSW1wZWRhbmNlIGNvbnRyb2wgdG8gc2V0IHRo
ZSBwcm9ncmFtbWFibGUNCj4gPiA+ID4gb3V0cHV0IGltcGVkYW5jZQ0KPiA+ID4gPiDCoMKgwqDC
oMKgwqAgdG8gYSBtYXhpbXVtIHZhbHVlICg3MCBvaG1zKS4NCj4gPiA+ID4gLcKgwqDCoMKgwqAg
Tm90ZTogU3BlY2lmeWluZyBhbiBpb19pbXBlZGFuY2VfY3RybCBudm1lbSBjZWxsIG9yIG9uZQ0K
PiA+ID4gPiBvZg0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgIHRpLG1pbi1v
dXRwdXQtaW1wZWRhbmNlLCB0aSxtYXgtb3V0cHV0LWltcGVkYW5jZQ0KPiA+ID4gPiBwcm9wZXJ0
aWVzDQo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoCBhcmUgbXV0dWFsbHkgZXhjbHVzaXZlLiBJZiBt
b3JlIHRoYW4gb25lIGlzIHByZXNlbnQsDQo+ID4gPiA+IGFuDQo+ID4gPiA+IG52bWVtDQo+ID4g
PiA+IC3CoMKgwqDCoMKgwqDCoCBjZWxsIHRha2VzIHByZWNlZGVuY2Ugb3ZlciB0aSxtYXgtb3V0
cHV0LWltcGVkYW5jZSwNCj4gPiA+ID4gd2hpY2gNCj4gPiA+ID4gaW4NCj4gPiA+ID4gLcKgwqDC
oMKgwqDCoMKgIHR1cm4gdGFrZXMgcHJlY2VkZW5jZSBvdmVyIHRpLG1pbi1vdXRwdXQtaW1wZWRh
bmNlLg0KPiA+ID4gPiArwqDCoMKgwqDCoCBOb3RlOiBTcGVjaWZ5aW5nIGFuIGlvX2ltcGVkYW5j
ZV9jdHJsIG52bWVtIGNlbGwsDQo+ID4gPiA+IHRpLG91dHB1dC0NCj4gPiA+ID4gaW1wZWRhbmNl
DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCBvciBvbmUgb2YgdGhlIGJvb2xlYW4gdGksbWluLW91
dHB1dC1pbXBlZGFuY2UgYW5kDQo+ID4gPiA+IHRpLG1heC0NCj4gPiA+ID4gb3V0cHV0LWltcGVk
YW5jZQ0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgcHJvcGVydGllcyBpcyBtdXR1YWxseSBleGNs
dXNpdmUuDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCBJZiBtb3JlIHRoYW4gb25lIGlzIHByZXNl
bnQgdGhlIHByaW9yaXR5IG9yZGVyIGlzDQo+ID4gPiA+IG52bWVtDQo+ID4gPiA+IGNlbGwsDQo+
ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCB0aSxvdXRwdXQtaW1wZWRhbmNlLCB0aSxtYXgtb3V0cHV0
LWltcGVkYW5jZSBhbmQgbGFzdA0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgdGksbWluLW91dHB1
dC1pbXBlZGFuY2UuDQo+ID4gPiA+ICsNCj4gPiA+ID4gK8KgIHRpLG91dHB1dC1pbXBlZGFuY2U6
DQo+ID4gPiA+ICvCoMKgwqAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMv
dWludDMyDQo+ID4gPiA+ICvCoMKgwqAgZGVzY3JpcHRpb246DQo+ID4gPiA+ICvCoMKgwqDCoMKg
IE1BQyBJbnRlcmZhY2UgSW1wZWRhbmNlIGNvbnRyb2wgdG8gc2V0IHRoZSByYXcgcmVnaXN0ZXIN
Cj4gPiA+ID4gdmFsdWUgZnJvbSAweDANCj4gPiA+ID4gK8KgwqDCoMKgwqAgKGFwcHJveC4gNzAg
b2htcykgdG8gMHgxZiAoYXBwcm94LiAzNSBvaG1zKS4NCj4gPiA+ID4gK8KgwqDCoCBtaW5pbXVt
OiAwDQo+ID4gPiA+ICvCoMKgwqAgbWF4aW11bTogMzENCj4gPiA+IA0KPiA+ID4gSG93IGRvZXMg
dGhpcyBjb21wYXJlIHRvICdtYWMtdGVybWluYXRpb24tb2htcyc/IFNlZW1zIGxpa2UgdGhpcw0K
PiA+ID4gc2hvdWxkIA0KPiA+ID4gYmUgYSBjb21tb24gcHJvcGVydHkgd2hldGhlciBpdCdzIHRo
ZSBzYW1lIG9yIGZvciBhIGRpZmZlcmVudA0KPiA+ID4gbG9jYXRpb24uDQo+ID4gDQo+ID4gdGhl
IGRpZmZlcmVuY2UgaXMgdGhhdCB0aGUgdGVybWluYXRpb24gaXMgbm90IHBhc3NlZCBpbiBvaG1z
IGJ1dCBhDQo+ID4gcmF3DQo+ID4gcmVnaXN0ZXIgdmFsdWUgdGhhdCBjYW4gbm90IGRpcmVjdGx5
IGJlIG1hdGNoZWQgdG8gYSByZXNpc3RhbmNlDQo+ID4gdmFsdWUuDQo+ID4gDQo+ID4gVGhlIGRh
dGFzaGVldCBzYXlzIGhlcmUgIk91dHB1dCBpbXBlZGFuY2UgYXBwcm94aW1hdGUgcmFuZ2UgZnJv
bQ0KPiA+IDM1LQ0KPiA+IDcwb2htcyBpbiAzMiBzdGVwcy4NCj4gPiBMb3dlc3QgYmVpbmcgMTEx
MTEgYW5kIGhpZ2hlc3QgYmVpbmcgMDAwMDAuIFJhbmdlIGFuZCBTdGVwIHNpemUNCj4gPiB3aWxs
IHZhcnkgd2l0aCBwcm9jZXNzLiINCj4gPiANCj4gPiBTbyB1c2luZyAnbWFjLXRlcm1pbmF0aW9u
LW9obXMnIHNlZW1lZCBub3QgdGhlIHJpZ2h0IGZpdCBoZXJlIGFzDQo+ID4gdGhlDQo+ID4gZG9j
dW1lbnRhdGlvbiB0YWxrcyBhYm91dCBzZWxlY3RpbmcgYSByZXNpc3RhbmNlIHZhbHVlIHdoaWNo
IGlzIG5vdA0KPiA+IHBvc3NpYmxlIGluIHRoaXMgY2FzZS4NCj4gDQo+IFlvdSBuZWVkIGEgcmVh
bGx5IGdvb2QgYXJndW1lbnQgdG8gdXNlIHJhdyByZWdpc3RlciB2YWx1ZXMgaW4gRFQuDQo+IA0K
PiBHaXZlbiByZWFsIGxpZmUgdXNlIGNhc2UsIGhvdyBpbXBvcnRhbnQgaXMgdGhlICJhcHByb3hp
bWF0ZSI/IERvIHlvdQ0KPiBuZWVkIHRvIHR1bmUgdGhlIHZhbHVlIGZvciBldmVyeSBzaW5nbGUg
ZGV2aWNlPyBPciBpcyBvbmUgdmFsdWUNCj4gbGlrZWx5DQo+IHRvIHdvcmsgZm9yIGFsbCBpbnN0
YW5jZXMgb2YgYSBib2FyZD8NCg0KVGhlcmUgaXMgYWxyZWFkeSBhbiBudm1lbSBiaW5kaW5nIHdo
aWNoIG1ha2VzIGl0IHBvc3NpYmxlIHRvIHR1bmUgdGhlDQpyYXcgdmFsdWUgcGVyIGRldmljZSwg
c28gSSB3b3VsZCBzYXkgaXMgY2xlYXJseSB1c2VmdWwgaW4gc29tZSBzZXR1cHMuDQpJbiBvdXIg
Y2FzZSBJIGRpc2N1c3NlZCB0aGlzIHdpdGggb3VyIEhXIGVuZ2luZWVyLiBPbiB0aGUgY3VycmVu
dCBib2FyZA0KZGVzaWduIGEgc2luZ2xlIHZhbHVlIGlzIGV4cGVjdGVkIHRvIGdpdmUgc3VmZmlj
aWVudGx5IGdvb2Qgc2lnbmFsDQppbnRlZ3JpdHkgZm9yIGFsbCBpbnN0YW5jZXMgb2YgdGhhdCBi
b2FyZC7CoA0KDQpXZSB1c2UgdGhpcyBQSFkgYWxzbyBpbiBvdGhlciBkZXNpZ25zIHdoZXJlIHNl
bGVjdGluZyBlaXRoZXIgdGhlDQptaW5pbXVtIG9yIG1heGltdW0gb3V0cHV0IGltcGVkYW5jZSB2
YWx1ZSBoYXMgYmVlbiBnb29kIGVub3VnaCBhbmQgd2UNCmNvdWxkIHJlbHkgb24gdGhlIGV4aXN0
aW5nIG1pbi9tYXggYmluZGluZ3MuIFRoZSBkaWZmZXJlbmNlIG5vdyBpcyB0aGF0DQpmb3IgdGhp
cyBuZXcgZGVzaWduIHdlIG5lZWQgYSB2YWx1ZSBpbiBiZXR3ZWVuIHRob3NlIGV4dHJlbWVzLCBz
byB3ZQ0KY2FuIG5vIGxvbmdlciB1c2UganVzdCB0aGUgbWluL21heCB2YWx1ZXMuDQo+IA0KPiBT
byBsb25nIGFzIHlvdSBzdGF0ZSB0aGUgdmFsdWVzIGFyZSBhcHByb3hpbWF0ZSwgaSBkb24ndCBz
ZWUgd2h5IHlvdQ0KPiBjYW5ub3QgdXNlIG9obXMsIHdpdGggYSByYW5nZSBvZiAzNCAtIDcwLCBh
bmQgbGV0IHRoZSBkcml2ZXIgY29udmVydA0KPiB0byByZWdpc3RlciB2YWx1ZS4NCg0KQWNjb3Jk
aW5nIHRvIHRoZSBkYXRhIHNoZWV0LCB0aGUgZGVmYXVsdCBpbXBlZGFuY2UgY29udHJvbCByZWdp
c3RlciBpcw0KdHJpbW1lZCB0byA1MCBvaG1zIGR1cmluZyBwcm9kdWN0aW9uLCB3aGljaCBtZWFu
cyBkaWZmZXJlbnQgZGV2aWNlcw0KcG93ZXIgdXAgd2l0aCBkaWZmZXJlbnQgcmVzZXQgdmFsdWVz
LiBJIGNoZWNrZWQgdGhlIGltcGVkYW5jZSByZXNldA0KdmFsdWVzIG9uIGFyb3VuZCAyMCBQSFlz
IGFuZCBvYnNlcnZlZCB0aGF0IHRoZSBkZWZhdWx0IHJhdyByZWdpc3Rlcg0KdmFsdWVzIHJhbmdl
ZCBmcm9tIDB4YyB0byAweDEwLiANCkEgVEkgZm9ydW0gcG9zdCBtZW50aW9ucyBhIHRvbGVyYW5j
ZSBvZiBhcm91bmQgKy8tOCUgWzFdLsKgDQpHaXZlbiB0aGlzIHNwcmVhZCwgbWFwcGluZyAzMSBy
ZWdpc3RlciBzdGVwcyBkaXJlY3RseSB0byAzNS03MCBvaG1zDQp3b3VsZCBpbXBseSBhIGxldmVs
IG9mIGFjY3VyYWN5IHRoYXQgaXMgbm90IGFjdHVhbGx5IHByZXNlbnQuDQoNCkEgdmVyeSBzaW1p
bGFyIGNvbmNlcm5zIGFuZCBhcmd1bWVudHMgY2FtZSB1cCBkdXJpbmcgdGhlIGluaXRpYWwNCmRp
c2N1c3Npb24gb2YgdGhlIG91dHB1dCBpbXBlZGFuY2UgYmluZGluZ3MgWzJdLiBUaGUgc29sdXRp
b24gd2FzIHRvDQpjcmVhdGUganVzdCB0aGUgbWluL21heCBzZXR0aW5ncy4NCg0KVGVyZXNhDQoN
ClsxXWh0dHBzOi8vZTJlLnRpLmNvbS9zdXBwb3J0L2ludGVyZmFjZS1ncm91cC9pbnRlcmZhY2Uv
Zi9pbnRlcmZhY2UtZm9ydW0vNzIzNTEyL2RwODM4Njdlcmd6LXItZXZtLWRwODM4NjctdG9sZXJh
bmNlLWRyaWZ0LW9mLW91dHB1dC1pbXBlZGFuY2UtY29udHJvbC1iaXQtNC0wLW9mLWlvX211eF9j
ZmctMHgwMTcwDQoNCg0KWzJdDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvOTU5YmFjMzkt
Y2NkNi04MzM4LWE5ZjQtN2Y1NmY2M2IwNDc4QHRpLmNvbS8NCg0KPiDCoMKgIEFuZHJldw0KDQot
LSANClBIWVRFQyBNZXNzdGVjaG5payBHbWJIIHwgQmFyY2Vsb25hLUFsbGVlIDEgfCA1NTEyOSBN
YWlueiwgR2VybWFueQ0KDQpHZXNjaMOkZnRzZsO8aHJlcjogRGlwbC4tSW5nLiBNaWNoYWVsIE1p
dGV6a2ksIERpcGwuLUluZy4gQm9kbyBIdWJlciwNCkRpcGwuLUluZy4gKEZIKSBNYXJrdXMgTGlj
a2VzIHwgSGFuZGVsc3JlZ2lzdGVyIE1haW56IEhSQiA0NjU2IHwNCkZpbmFuemFtdCBNYWlueiB8
IFN0Lk5yLiAyNi82NjUvMDA2MDgsIERFIDE0OTA1OTg1NQ0K

