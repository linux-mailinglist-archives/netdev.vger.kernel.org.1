Return-Path: <netdev+bounces-302952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h1pFM0lEQ2oXWQoAu9opvQ
	(envelope-from <netdev+bounces-302952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:21:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8656E03C6
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:21:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=LUcJOFvw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302952-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302952-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1723300B1D2
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636633D6498;
	Tue, 30 Jun 2026 04:21:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180073AB289
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:21:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793287; cv=none; b=DuHi2iJEoRWrdg6E1lEScT8CpDr6UijRi2T92lDq17NDFx18QbZB18etl6FTsfFtaklarSC6scM8uf6RdxtophAHODCNkhacXNvVKJP5NLF63UDCDwQvTO1XK7jpVbFuD/4FaRPY5ktWObzGM2nZwmAawqjkPD5iVRzfHdEgx2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793287; c=relaxed/simple;
	bh=6XahfylI694XR2wJn0+IVbqT3QNS0nrzYeCPGiKfrOw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=l1R1X56D4idmupbVIwEvxnm8W/VHOLvU2OKRdQTZQW0cpICpvlXH1VpGhmGJtHLLBCKhLmI07/UP0vU/PbJ4Vtp5Vnfe4pQDJx/oawAz6L3T3YHx7+HKSZMaarOm1sgzNAj2WEZPLkAvelIQKX1M4SSM8+sYX5EoK/2KKsFQKwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=LUcJOFvw; arc=none smtp.client-ip=170.10.151.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1782793285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XahfylI694XR2wJn0+IVbqT3QNS0nrzYeCPGiKfrOw=;
	b=LUcJOFvwqwomCLeOd6Wz3u4u9oVXEVf6pBksAAQZ9tewZuRDpeGriHRZlk4JbU5VMHOWPt
	Cp5W8V6H7qfum7PrAJsBFlnfFC0sHeaL8RIPF73l4hW3i9zGrTbmEcQanztEeVrqAeskm7
	MqLg96Ju5s1jsILoDQ9hsfCjJCkWig8BWOz5Gw6558tGdvN8Mmr8tFkZ/SLP1oZRNNRjAm
	VlxuR2IbGC8JxHFqSR7xcpPR0JioK99jAOyVVNrWyzmzol7k8RkftV8HkUHIR/Pu6lLG6J
	25JtNd/tvYX1IoH08JOAvg/61vZYGqv7iieHeS2uxABOKrcWhRXSUnZP7EnVdA==
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010049.outbound.protection.outlook.com [52.101.85.49]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-25-QxPPL_JhMmmOHoI4mJ93CQ-1; Mon,
 29 Jun 2026 21:21:23 -0700
X-MC-Unique: QxPPL_JhMmmOHoI4mJ93CQ-1
X-Mimecast-MFC-AGG-ID: QxPPL_JhMmmOHoI4mJ93CQ_1782793281
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by LVUPR02MB11516.namprd02.prod.outlook.com (2603:10b6:408:39b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 04:21:19 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0159.012; Tue, 30 Jun 2026
 04:21:19 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Conor.Dooley@microchip.com"
	<Conor.Dooley@microchip.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Piergiorgio Beruto
	<Pier.Beruto@onsemi.com>
Subject: RE: [PATCH net v5 1/4] net: ethernet: oa_tc6: Interrupt is active
 low, level triggered.
Thread-Topic: [PATCH net v5 1/4] net: ethernet: oa_tc6: Interrupt is active
 low, level triggered.
Thread-Index: AQHc+e0nFxx0u09WdkC+bo9XNPrS8rZAt0OAgAMGobCABlg+EIABlccAgAAFtTCAA5jlAIAAJzFwgAAJedCABxDtgIAAD1cA
Date: Tue, 30 Jun 2026 04:21:19 +0000
Message-ID: <CYYPR02MB982853E592F3E25E92BC0AAE83F72@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
 <20260611-level-trigger-v5-1-4533a9e85ce2@onsemi.com>
 <7c89df6b-32ac-46c8-8400-945879037f2e@microchip.com>
 <CYYPR02MB9828CD98EEEB9B218A940E4483E32@CYYPR02MB9828.namprd02.prod.outlook.com>
 <CYYPR02MB9828A1434E6339A6CFCCA74283EF2@CYYPR02MB9828.namprd02.prod.outlook.com>
 <64f4f30e-a987-4289-b36a-1acc977a6764@microchip.com>
 <CYYPR02MB9828E1167750AEA090EC60CD83EE2@CYYPR02MB9828.namprd02.prod.outlook.com>
 <f127837f-e08f-48e0-a3a9-906e1d61d6bb@microchip.com>
 <CYYPR02MB982836BC273D09FD3BDE623583EC2@CYYPR02MB9828.namprd02.prod.outlook.com>
 <CYYPR02MB98285BD6A2639E0B01AE407183EC2@CYYPR02MB9828.namprd02.prod.outlook.com>
 <d15eaa01-3312-420f-a34a-d810710e5b12@microchip.com>
In-Reply-To: <d15eaa01-3312-420f-a34a-d810710e5b12@microchip.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|LVUPR02MB11516:EE_
x-ms-office365-filtering-correlation-id: 64dc597f-652f-471d-8a86-08ded65f08d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|18002099003|38070700021|22082099003|6133799003|11063799006|56012099006|4143699003
x-microsoft-antispam-message-info: a6V2+APF86ZnHuvRaExNd1qNIP+d46zr6oPtnl9ncFiWEDqeYzzQ+R3ZglF/hb1BdAAOd5lu+orL3IQw7n99NE9LXx1oaRLMTe2w7PQDBEPF4YgXKIfIi6Kp4pI78uqMhfyAhg0KOaa0LnIrwLW5YubqtK0nPGkYDb6M1GHG0zwp1C+eAwmDHxdhtgrDENB+QA54J2dIw5PDLu8GEk6H9PAxp5FE6NgEpbjdwLkQYblFED1NHfaWdgxgP9wqcllJyEeDfbv5j2uSaus6n0ShYRWK/uXbK1ni42ggCgN53BspmcTk9Jl5JlyefcwT199/6LidRs5qZ1gL+lV/PJA1k/Xyf8l+otKltKiXknCGeCHS6NQSTmudkwlR4njqsOx63WQtaVWnDV0LK1dx6y4L98owMBhlwVinQTZaj9LMFXBQ89YnVDNIZQ1/k6Drf4Ht5UqVmK44wEfe70/fInVM1ddqEsiLc7vezIlY/w4avLvkh4GuodIX/dBKjpNrhzM5hq4AF88stSL+Mxf8XD54hHHNcXpiKQImM8XwgiDrOWbCLGuQyzGTZWP35+r0du2+DvLPOXtgPi42XhG6zaShQw+vHRCZcIqyLkYomu9xAdZuMGGBUBDTANpVQ+etBne+XVg6ohdwVdvAopK+y0GCk9vz9XUQoEpdHNI/kxNY2tIyZs2++1P6f440I9elcanEhYoezWhquu9KfSJ2CmKBrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(18002099003)(38070700021)(22082099003)(6133799003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1lLZHdwZm5jbU5qQnJjQ2RQZEJ3WkFwU2M5bTNZMmt4bUc0Zk8vWTJOVlow?=
 =?utf-8?B?Rkk5ejJad3hNd0ZuaERyVmNxWnVISE5hV3dIS3p0UXRrSkI2N3FPTk1zRVUx?=
 =?utf-8?B?SlZjclp2QkxFbWp3Wkx1MVJjcTREK1hRSS84czR5Q2M3WkdUdlJ3bmt3aHls?=
 =?utf-8?B?eTdobTJEc1FVRmUvYlJrWFVGRCtnZG1aUU9qRHZYVXVyNnI5YzlVaWtDMDNi?=
 =?utf-8?B?c0EzSmloWnVtNmJnOUhpZ2Rmem00d1JzV3lWdGRmQVVVcGh3WFdXVll5dkxU?=
 =?utf-8?B?K05YZDVqaTgwRGtJeEYyUlZ0VmdqOVlRdy9oeTFNcVFLN0RLZ0UyaXB4djhE?=
 =?utf-8?B?MzQ2VGZYS2o2N2NNaE5STGpLVkhvSUhVc0tkZHkyOFM4TjREbFUwWDRLWlFy?=
 =?utf-8?B?V0s4K0hUOTBFeXBxVVBSaldZQ3QrU3ZqaHFPSDBzVVRkeENRMzUxQytKVmF3?=
 =?utf-8?B?MUpQaVg4aTlwY1UwSUpMdFMzcUQ4b1FNVGJMdnh6Q1NnVHYySmZsa1dTbmdV?=
 =?utf-8?B?Y3BuK09tb3NyT1piZjBrb3lnU1BYL3VBM2xDSkZkK3djUWpmdnM2QWMwbGFQ?=
 =?utf-8?B?UVpSWjlqUW4yUGwyQ0dUMVNySlN4TWRXMGtHa3l4ZzQ2NnRsRlp0T0t5YWxB?=
 =?utf-8?B?NGErTFN1dkc1WmxEQUxBU3RSbk5NbGZSQ1RsZElyNWZLNURicEpJSGlRb2xZ?=
 =?utf-8?B?ZnY5UlU5Z0xXemNHckJRQ0dhcjFURnRFSkl0TDJ6L0NBb2JpNE40U3hBZzNr?=
 =?utf-8?B?eWgyMHJkcGZxcW9FVk9LTktLdTNsRk9GaTFXZXpZQlRFNytGMFRuVWNlZVRJ?=
 =?utf-8?B?eHNxeVNYMUNEOGdoZ3JnakdrenkvVnZjdDQ2UkR5cHo0VVczV0VTQXVSODRC?=
 =?utf-8?B?RCtwR2FJTzFCakZyTEhXdjkyVTdEamwwTmVkOWgrdUNmblFibnQxSlBRR0Zo?=
 =?utf-8?B?emkrQ3cyNEE3QXdMakVzQkxpUWtEK3dSTGQ1ZGZrQlZ5QVNhOFhuS2NhbXJY?=
 =?utf-8?B?eGdJNyt5QTBnR0g2TTV0ZEdOQnR0RURZZmZGN2ZpakJ3eE1zQWtBV1Rhc3dC?=
 =?utf-8?B?dWplV3g5cEZFT2xRQjdhNGQrcFNOZjlJU2svSENyVHNIN1ZUcXlrT0NNb3Bh?=
 =?utf-8?B?SU1KYkhUdjJZYWw0a0FoQlJsYlhBSlNlZmdpVEZvRjhUdlBHL1VJZElJNklI?=
 =?utf-8?B?OWplZGR1SzliWUQ4Y0RGQUdNbzQ3YTJuVjF1b3h2bHFqMGtaY2x3TkFINDNY?=
 =?utf-8?B?YnFiOFl1QnRScjlGbW1POWFrMkhXbHMyK05qRW5FMEYwb3FjUjljZkduNWJU?=
 =?utf-8?B?Y3hKNXRhcTc0WEJmMnVJdy8xakJvYUI0TnJDZ2RyYXZjM0VFdS9rcmllUHdt?=
 =?utf-8?B?UUViQ2xpUXllaVFyYjl1S3hlZ01TcEIrWVd0M2VnN3cxZzU4TGRzeXVJUkhp?=
 =?utf-8?B?Q1RHUkxqbDBnak9oWUE0VnpiZHZUVTk1NVpQMlJlZ3Z3UWRyWVlzeGZQN1Fr?=
 =?utf-8?B?TFd4NHFMWUh2Uks0dkw4SXRlRHVFQlpBWGkxS01XYXcrdWcyMjVZNlEvWkla?=
 =?utf-8?B?YXJuaVVBNm5MSWdIaml6U3NrbjlQRUZJKzMvQktyOEFqUTNkUThXRG9yeU1n?=
 =?utf-8?B?NGlJT2NycFZ3WXpOV1I1S0xxZGl2Z1Q5RE56UUhXS0lGbWE2WE9FcWhNUXVX?=
 =?utf-8?B?TEdCOHNMVFlGRW1mc2FuTnFNMmZyNVhwQUdzT3NkSUtMYmpZQzhSTlF0Tk9X?=
 =?utf-8?B?UTI0eGQ4MS9CN0haMUIzdW9DWXVGZjlNUzBYdnUvME11NHZtYnh4NmNBNDZp?=
 =?utf-8?B?SEx5dDZuc0JpQlIxMmc4S2hJWm5lb2I0YWJiMW1WeTNqd0ZNRENzNE9xUERK?=
 =?utf-8?B?Q3lHTC9DeWJKM1N1aDZmQ25ENktubHhtalNiS09IYjJnL08wTDBVOTZMTE1v?=
 =?utf-8?B?amRKVzlNbWp6WEp5a1JkbVE0MWFQOFpQVmdLSUtVQnVGdWdKUW1sNzY4VWw3?=
 =?utf-8?B?emtLeDA3b013SWhZcnlGY3JQbm5UR2ZvSWh0cHdOTHFEaUZUOFFKY0R5ZFRl?=
 =?utf-8?B?R0VoTDdFQ3RBTUdmREVOeE03QWxXVG4wVUd4S3Q0T2ExQ1NnVDVueVpWUjBK?=
 =?utf-8?B?TDNTRTNnazVDcjFZWXFCeTdKaE9Vd0t4VGFyakJRaXBpdCtTVXJPSldPenJN?=
 =?utf-8?B?NjY1SHhBNUlDN0g0QU0yNmo0dStNR0w5V3RMU2NuT29mMXFocHB1aDZYa3ZD?=
 =?utf-8?B?dzZ5bTJlOUxlZDNBcTg0NUlGOFA0czZ0WHM2ai9GRE1CQzdQZCtQbjNxUzJN?=
 =?utf-8?B?Y2E4RlRyWlBscU1taDl0MXBsc0ZaSUdBMVhuK3NWZkxxUndmY3Y3RUZNeTZN?=
 =?utf-8?Q?FZ1fM1uShsGvJEiA=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kQi0Gva5QQc4D/tB1XFWHN9UqK4lXZ7zmL7oSfi9+ELtxdvZH2pF7Ixky/vwMG3qQ+fqQk8rr/UGcSahhXbCk7E1+6YlAZ0r9avcdR6cfqlf3eoaPJg5dfcX/69qPsEeY48c9HUqwvx/f0KE1NMhtU1muGLfS1Z4rpvVA+Bf+fU3D/9RqbHVTRdcav65YWjrTqXRGuRXbeI/C/G7KTitn/IN2DbEqGkO7Cv0TaymMu/4y9OOf1GU7K8JJytP+ejeyzGzuXd0b/cXeeDD1QA1rJpalFpbsSw5K2jiCxmJDJOpywJpvMBTV5aBfpkyAfe8gcW0vmUqYj+oQVu/71/dQA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dc597f-652f-471d-8a86-08ded65f08d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 04:21:19.1081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dUok0YtYgQsH9JYP5XaXNRhSFc4hbs6GlBFSY9OxQFEqMRhY1A5a4hxiAgE2zEDSE1eN2g0ER4OwkKTFisnZJRrf0FiKVwHsm0bDC9FGS0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR02MB11516
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4BFY7Luucx1_s0Iqosq3Lqmbcshnigc1S8SxShXVqAk_1782793281
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302952-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Parthiban.Veerasooran@microchip.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,onsemi.com:dkim,onsemi.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F8656E03C6

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhcnRoaWJhbi5WZWVyYXNv
b3JhbkBtaWNyb2NoaXAuY29tIDxQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlwLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQgdjUgMS80XSBuZXQ6IGV0aGVybmV0OiBvYV90YzY6
IEludGVycnVwdCBpcyBhY3RpdmUgbG93LCBsZXZlbA0KPiB0cmlnZ2VyZWQuDQo+IA0KPiANCj4g
U29ycnkgZm9yIHRoZSBkZWxheWVkIHJlc3BvbnNlLiBJIHNlZSB5b3UgYWxyZWFkeSBzaGFyZWQg
dGhlIHBhdGNoZXMgZm9yDQo+IHRoZSBmaXhlcy4gVG9kYXkgSSB3aWxsIHRlc3QgdGhlIGJlbG93
IHBhdGNoIHNlcmllcyBhbmQgc2hhcmUgdGhlDQo+IGZlZWRiYWNrIEFTQVAuDQo+IA0KPiANCg0K
UGFydGhpYmFuLg0KTm8gd29ycmllcy4gTGV0IHVzIGhvcGUgdGhpcyBhZGRyZXNzIHRoZSBOVUxM
IHBvaW50ZXIgcmVmZXJlbmNlIChhbmQgdHJhZmZpYyByZWNvdmVycyBncmFjZWZ1bGx5KQ0KDQpT
aW5jZXJlbHkNClNlbHZhDQoNCg==


