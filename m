Return-Path: <netdev+bounces-297269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OFWAGFZxKGpeEwMAu9opvQ
	(envelope-from <netdev+bounces-297269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:02:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C58664006
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:02:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b="IxQ/nBVA";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297269-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297269-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 741E6300E02E
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 20:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C45835B653;
	Tue,  9 Jun 2026 20:02:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAAF346A14
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 20:02:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781035348; cv=none; b=evgzFzT3chifCATCiab6TsvJgliUQI5X0V2eAwGADmvFXVH8c1FTyL/43LCMXL2lJ+i8CEp/o10sRIQME2TbKBTB7LW9iUCgCPCKWZc55G/nOqC7T2tTjzqJ+H4fcK4Lr70rru05R48V4OoMsZwuu55mqzw6tbAce7/Ifxm6fZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781035348; c=relaxed/simple;
	bh=YEiws//EPZ7F8AMCSdjYviYSQe7Tj7xND1OX/SYdE5M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=iJlJlh/QN9ggV6vvcn/MJoaVR2wVIJdvyh5Itv/JZcWwgSHVxDg1wu06agiO01267pD27R+r0yFhABbInxbezE8btBZAMZcrnIOzVISRneVPp55sCsXnofkhZzikDwAblo6LjsvVIbKUAHxvMbNKdPvRSrrVlHqIBGkQsEvhdIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=IxQ/nBVA; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1781035346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YEiws//EPZ7F8AMCSdjYviYSQe7Tj7xND1OX/SYdE5M=;
	b=IxQ/nBVADOmxaFWFxkc03i2aQN9Yzefkv4DJhISX9Xsn5rsyWq8cLRAWxsP3x9nfPvTNdS
	55e04P/NOoSHT03Q+8UQ05nn6TfcMR+AQz5J+Xm1uzh2Hlwd6ggsHc1C/PDZ/KuzBUnFtN
	DQVaKA23x5YGHiLBvpVb1/YJSvH6NWYyam+ahYKYAIYm4JIiq/O3I/0dX/Kaddf2Ybgf7c
	qn707DWfpBInwv3SuQ8KNEgWXk9zYiKtFXSI70uHYy9/UuNF4meP6C16VwuPeqw8bf902E
	CgWIlOMEw/WKALC6okm6Gkz/8h1LSBqcuJP8OFbwNWzcxUektl835mDXAYybGQ==
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010040.outbound.protection.outlook.com [52.101.46.40])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-42-H_1Q1DRqM8-bqQHwliyE9A-1; Tue,
 09 Jun 2026 13:02:21 -0700
X-MC-Unique: H_1Q1DRqM8-bqQHwliyE9A-1
X-Mimecast-MFC-AGG-ID: H_1Q1DRqM8-bqQHwliyE9A_1781035334
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CH3PR02MB9479.namprd02.prod.outlook.com (2603:10b6:610:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 20:02:08 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 20:02:07 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"conor@kernel.org" <conor@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Conor.Dooley@microchip.com"
	<Conor.Dooley@microchip.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Thread-Topic: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to
 be active low, level triggered
Thread-Index: AQHc8eDLvWzkHnbXI0KmrY/VvMfuDrYrecyAgAALlpCAAm25gIAAkU0wgAAYXICAAAajgIAFcz6AgAAGt5CAAd//gIAAaviwgABI9uA=
Date: Tue, 9 Jun 2026 20:02:07 +0000
Message-ID: <CY8PR02MB9249B913E28E285EB46EC59C831D2@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
 <20260601-level-trigger-v3-2-da73e7010532@onsemi.com>
 <20260602-rebel-snide-5036c97e410d@spud>
 <CY8PR02MB92493D2E5491AAE5416C05A283122@CY8PR02MB9249.namprd02.prod.outlook.com>
 <a5abb9b8-6ebf-4f95-a684-fc889b98acea@microchip.com>
 <CY8PR02MB9249E607ACBF3A05AB83ABF683102@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260604-swimwear-garnet-3eb092e6fda7@spud>
 <4df9882b-3426-4c36-8048-0c76d0f11c74@lunn.ch>
 <7c68173a-ebff-42cc-8519-95e8365805b5@microchip.com>
 <DM4PR02MB926317F64B5A3827009B66A9831C2@DM4PR02MB9263.namprd02.prod.outlook.com>
 <a02cd86e-a5b8-481c-a07e-7243ee537b24@microchip.com>
 <CY8PR02MB9249EC4F3896121911D0FF3C831D2@CY8PR02MB9249.namprd02.prod.outlook.com>
In-Reply-To: <CY8PR02MB9249EC4F3896121911D0FF3C831D2@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CH3PR02MB9479:EE_
x-ms-office365-filtering-correlation-id: 55bda3f2-7652-4b6e-fcf9-08dec661fc37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|56012099006|5023799004|11063799006|4143699003|6133799003|18002099003|22082099003
x-microsoft-antispam-message-info: wIiXhhJ2hbXuHdvC8r0IUoRobDMa++Wx6cbj9vjVX/XxoIYqgHyIs9ITVeoggggf13e7jOFRJ1m1f7cWiecOTz91SdgPOakTS29jNiXo6RWs0E254tIe4is4AUl4RwGsSwsbwR+ze6WN+Zr6v87KgmtLewB4/eq7hDRpPoCuGcJz5+FqWpjfgu4poq+cAW62by17bSmPhXv8qV2LDDPVOVd6PLopzcLVTqx7GksB47MT2Zpe5XIUQI5Ipe14HARLwjybCW1MnMZ2dwyJI54cFxYpc2lUBCl6W5J9z87qOTektNtVHuh2X+GOePjW2lS5jWOpFP4rz6+GdDLG4RgjlHwWi4LP8j3H7L7y8EnzVzH7aRRihv4g5iDWRXXVgHcqc6w7CoXI12TMGvDi0kykyooCnttXXa5BaVljrJt6axBVhZvWYBkASgzxCUQOClUJnvne/kcvw/2wU1oRZYh9U0O9Z+YA5LpfkAHX8JhvhBSs8Y++exZRsx7Graze2FXDQg4jFG0jKK5nzHyXF6+S8jHZdRa56I6JnoEaXD40GPoEkmqsByv8K0Gz8EF0Zn8MA0nx3gRV+AQGbsrReFO2dyyz3PtFwBuBysd3KavrldjALQfiVgs47SilL0SYCWZZ1TR/JDJzSC9oDkCd8S78+mjsVhP/PWZVoFZHDLHo0pGo/UrcaU31z9aWDts0yGmvW7sEQCnOAd/FaLvqrrbMj3VjA030aGFEh8RKGF9CahunrQP0D8zmeSNj4eO1QdAF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(56012099006)(5023799004)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEppRU1EMk4vR3l3a010eGphZmRuU0JzT1JsK1NXOFhJYzBPN3Jkb0tsT0Z5?=
 =?utf-8?B?VW01RGs1WWtKTHB5Mk9pTHdWbzJFN21ORGUzVm1WUzkwYStnQWpMMTdWQkJ3?=
 =?utf-8?B?YlJPMDNvNkVkZ1o3SERIK3lTQ2hLVVUyQW85ajhNZjFpYzFNMHRlMnZVNWRU?=
 =?utf-8?B?cVdpNmlLZGNHZDV0VEc2bDQybE9qSjNjUHg3QWZSU0VZQlRIaUpaTE41U3Ba?=
 =?utf-8?B?a1IyODdDNU5LbHg2b3NQaU5KTGtmSmZLUGY4VFRDdkdIWVdNR3AxNHpPOVBE?=
 =?utf-8?B?TXh3bzlMWkc1VTllcEpPQUVpKzFyQTNiRnptS3IxRjQ5SHQ0WEpBQlZkVDlX?=
 =?utf-8?B?NEs5b1A5OUI5b3pVZ0RVV2lhQmphNWhsa1VHUHk0MldwUXE3RU16M1R3a0xY?=
 =?utf-8?B?OHdFcUNGVHBiaDZMalZDYjRnSVdzOXpUS1k5VTJpUDBFVlJzak9ncGFGa2FE?=
 =?utf-8?B?elJmYjMwR0dBOVMwdFlDNm5FbVA1VkFKUFU3Vmg0dFpsUWdlaHBuZUpJNVZm?=
 =?utf-8?B?amdpS3Uxc3VUT1pFblE3anZmd3BrUXhEc0luMkV4aURsNEliV0QyWElGSW9J?=
 =?utf-8?B?dzF3dUlSZXgrUXg3NHdYMEk2OTVXdVRWUktoZGt4VU1lU1JPM2RpVmp1YVV1?=
 =?utf-8?B?bFFJZDlNZEsrZHhoc2ZtcEZCOVkzemkvL0QzMll0bHI3WllneFQrV1F1Vkk2?=
 =?utf-8?B?Q2ZQdEFxUFhoaExiZCtMN2EzaGgrV3doTE5KZFIzQ093WUFKTFlKZnE3aUJZ?=
 =?utf-8?B?cFljSE81VHNTS0xpdFI2ZW1LL0xqQUxBWkFWd2d3SmI0bzNCMjBlNXVTUytp?=
 =?utf-8?B?WDlzdG1Nc3VLYXpkalBBeVZHQUNsN1NxNnp2a0t1eFYrTGNkNVNscm1DOS9n?=
 =?utf-8?B?dWRCZWpHRytVRGhBRkJLbS9tNGFPTVVYMk9TbFNDZ3ZvQ3ROaXE4OFdUWFli?=
 =?utf-8?B?cjFMNzZ3MytDT2VHRk9QckxxazRQekhKQUxoRCsySkdNbjd1b2Fqd3JsdnE0?=
 =?utf-8?B?K1BwdVF1QVdpaXZMbkRhckRyalN3bkFEbk5EbXQrRi81TjBWd0RSOFo3WXlC?=
 =?utf-8?B?b3FrelJUSTdGdkR2UU5DRDFubDAwbms4VFljZGFLamVLU1BuRVBaQm12UzFn?=
 =?utf-8?B?TitDb0FmNkZ1TTM4ampUbXYxNTg5Sk9jNG9QME1TMFlQNnZ2dmk4bVl1clNz?=
 =?utf-8?B?ZEM3b2RHenM3eDB1K0YxZTRtQUl2Kzc3QXZrTzAvV0t2Y3R4RmlzNFRLVUd0?=
 =?utf-8?B?Y0Z0OUowa0xabWNHNDVMYU1oaHNWTjVKcmhTL0tIM0tJbjEzVnVmOUhQNFk5?=
 =?utf-8?B?MVFUQmxnb2dBYjNXbnBuUjB4dVhVcnpsWkpiamlNNWNQUVRMcjB3bzhETVAx?=
 =?utf-8?B?clBtQUFYcEoyZ2puZ0p1ZTdGdzViTGlGZmFyd2VpUWFJYUdtVERheWhoMWtt?=
 =?utf-8?B?dXVNdzh3bXRBckdKN29aZ21mMTJONFRuS3Q5TU5VQitxbnFHY1lKeU5mQkJm?=
 =?utf-8?B?WmgyMnZmbFdCNEkzZ1RIWDNLVk54ME9iQWZMWk1vVUlHTVk3YWZYSkhBSnlQ?=
 =?utf-8?B?cVNmZytDZTdQZlZXTklUdVd2ZVJKTGpBcm0zNnNyRDVreXJrV3czbDFoY2I1?=
 =?utf-8?B?Q2FLNG9ySFBOaDBSRnBCR3NacHRLMkxkTndyVnpLOGxrbHFMWWhCbnQ3N3Uw?=
 =?utf-8?B?UXBiMThCOTJaQnk2eEl3anFHb0dTNHpuaXF0UkVOQWcwOTBUVXNBdGJiU2VL?=
 =?utf-8?B?WHVtS1ZTQlZkbmUwQlVYbGthUnQ5U1lndnpXWkhnZWxsVjU5dXNyRVBMY0xj?=
 =?utf-8?B?MHR2NFhxS0NrRW9wZ1IrOXNZZ2twRjFlZVo5dVlYb3Mwc3pzZWdNbHNKSEZK?=
 =?utf-8?B?UzNEZGZMVTZnVDNjTzBTQ0lLeGxWZmxtN1NrOXhIcDZVaDVyRTlUVlNyMXp1?=
 =?utf-8?B?cWJUT3Z1d28wMERBc0RFN0pqNVVhUUI3ZkVYanBhLzZnNDdvTFNIYkVwUEpU?=
 =?utf-8?B?cmpzSUlML0Z5TjhwTzEzS3pWdDNkckJMQThhaHVOT2NVRU02TVp5RFhFaUxO?=
 =?utf-8?B?S09VRElWc29MMTVDQklLbXNxUHUrcHIxekV5WUppeFN5RHM0VmREb3hpbjBD?=
 =?utf-8?B?MU4yWWVvckVHS0hibU5jd1U3UUZRa0RPcUZ6WGtMTm5mSmdFaE04UUVoYjNn?=
 =?utf-8?B?bklBeDVSbW91OSszRldSL0lYeVJGZHNKNHpDWVU4a3UxTlNJR3lla2NqUyty?=
 =?utf-8?B?SmVIQ0M5YWpCdTdWbmVmVlB5cFdLRCt1c1hpLzNLMHRvKzdjcHRMY1VRV1ZL?=
 =?utf-8?B?ZHZHczlCVjVuV1FHZE1paE1TYUtoeDVZRHpPTEtIVUtYRHlBMndrQT09?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: D6SENN4KubCCCOsDeOWS3bG1R8nd84fpTlZsnean0M+gpcQg3s98vjzYuH/WfGy7bGuQtTGOO303B2+wBq3dzSp7O93vRR0/bG/luGqDC6hkTYkCxXInLPmfSeN6WJgEe7kmEyLi7/+XnnrJSr2gsQPqBWlnpT7Nao/gF8Pyed3EPZwnHfUmut+CyvMB5PMT6o1y8snrHh+YfY0O/LXGbOOEr+yrOaPzD0IBgaoVtfCxhRRYgRNF3OjPbolaMPLxEKsM+55Il3ITwCE4g7h4Hq/CjlEjtRqFXcT58QK9zYorsbJuNlqsaGbvzdepPJtflhmbBAPnmXSC3o9dXCU5hA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bda3f2-7652-4b6e-fcf9-08dec661fc37
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 20:02:07.8690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FYbak3owSfJmCTHFor42ykaO6yRPsgnFgn/+z5lMy036XQAKFGqpPonqds8qI6NgvYz5QZcQ30s+P3qxTVdpZ7mV057ifVBbpp+X3JE9H60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9479
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uuoX-RZ_Zz1CrGnnt3YJzD-WuDt3H0WqR3qBzOFI47A_1781035334
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297269-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Parthiban.Veerasooran@microchip.com,m:andrew@lunn.ch,m:conor@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:dkim,onsemi.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04C58664006

PiBTdWJqZWN0OiBSRTogW1BBVENIIG5ldCB2MyAyLzJdIGR0LWJpbmRpbmdzOiBuZXQ6IHVwZGF0
ZWQgaW50ZXJydXB0IHR5cGUgdG8gYmUgYWN0aXZlIGxvdywNCj4gbGV2ZWwgdHJpZ2dlcmVkDQo+
IA0KPiANCj4gVGhhbmtzIFBhcnRoaWJhbi4NCj4gVGhvdWdoIGNvZGUgd2FzIHJlYWR5LCBJIGdv
dCBpbnRvIG90aGVyIHRoaW5ncyBmb3IgdGhlIHBhc3QgdHdvIGRheXMuIFBsZWFzZSBzaGFyZSB5
b3VyDQo+IGNoYW5nZXMuIEkgd2lsbCBjb21wYXJlIHdpdGggbWluZSBiZWZvcmUgc3VibWl0dGlu
Zy4NCg0KDQpQYXJ0aGliYW4sDQoNCkp1c3Qgc3VibWl0dGVkIHRoZSBwYXRjaGVzLiBXaGVuIHlv
dSBoYXZlIHRpbWUsIHBsZWFzZSByZXZpZXcgYW5kIHRlc3QuDQpBcyB5b3UgY291bGQgc2VlLCBv
bmUgY2hhbmdlIGxlZCB0byBtb3JlIGludmVzdGlnYXRpb24uIEkgc2F3IGEgdHJhZmZpYyBzdGFs
bA0Kd2hlbiBJIG92ZXJzdWJzY3JpYmVkIHRoZSB0cmFmZmljLiBUaGF0IGludmVzdGlnYXRpb24g
bGVkIHRvIGV4dHJhIHBhdGNoZXMuDQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9uZXRkZXZicGYvbGlzdC8/c2VyaWVzPTExMDg4MDQNCg0KDQo+IA0KPiA+DQo+ID4gQmVz
dCByZWdhcmRzLA0KPiA+IFBhcnRoaWJhbiBWDQo+ID4gPg0KDQo=


