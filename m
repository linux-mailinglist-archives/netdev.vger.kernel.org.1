Return-Path: <netdev+bounces-303269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dKNCE2/cQ2oBkgoAu9opvQ
	(envelope-from <netdev+bounces-303269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:10:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B29E06E5C4A
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:10:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=MLsjK2ss;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303269-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303269-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E1D7300613C
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE2632AACB;
	Tue, 30 Jun 2026 15:09:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45646315D53
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:09:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832156; cv=none; b=qJDUE8TVgJBaaiGdZ7Yrh+UUHpxco/Mu0u8dPIRlG3O/0AAMfhRZpx22pDG0nR8YC38reNWKP4qpQLJzbiberRJr/fmyt0QdV2PCGkPPlu2xrLmkBJxMLT/gUQUS62/nH4qNLgoQ+u/80hMnLKYLJyaAQMSGwKGO+AXTFTejGP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832156; c=relaxed/simple;
	bh=kWtta70ofGmRF7G9mTChUSqWizOzUgEcvRtLJpcT94g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=LN21taQ7eC+AvD3EJdJ3Ev2uhg56VJ8TOpVBjePT5m2G4L448dPdDX/RppqpFrfS7tJFu8KCKIWhgQrZSX/CBqnymCPxqdcHo2WBJQqDc1wd9auXh2d7B2M/eg0Ki1MOe6VKvbl2u35H/cGARU3rny5JmVU+HLYjsVa8wwi+c8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=MLsjK2ss; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1782832154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWtta70ofGmRF7G9mTChUSqWizOzUgEcvRtLJpcT94g=;
	b=MLsjK2ssh4PoQSsyS9IHRGJiXVjyHryWVTasdfZAiFqYmGQK3oFGQw7f3ntyqAEaZ4DOb5
	PAy/7+FDyjhdZY8AzISg2PZ7j3OqyplNLNRxvuzl/JLDq5xtCElbNU15O9Z635VoDMS+xo
	rst92cDpFXf2DClSOn088Y1dfToDrAFJmO9KlhamBxOsGUGcYYjksG3k8pfWvb9YsDPNBT
	xDfGDaj2ZuDo3yq+8q9oOzYXwbq+Kg9dC66TY0G7a7dDTwoWKlt2N0nYyPr7w6A7kzzvIo
	s9k4Knk0gYS0NdpBhDyX0gvIE+SlkTptrIMTizGEagbNdtLeNTjHJGUeuWT6rw==
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012048.outbound.protection.outlook.com
 [40.93.195.48]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-12-oNkKPeHkOIm0d6kay7AZGQ-1; Tue, 30 Jun 2026 08:09:08 -0700
X-MC-Unique: oNkKPeHkOIm0d6kay7AZGQ-1
X-Mimecast-MFC-AGG-ID: oNkKPeHkOIm0d6kay7AZGQ_1782832143
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by LVUPR02MB11515.namprd02.prod.outlook.com (2603:10b6:408:39b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 15:09:01 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0159.012; Tue, 30 Jun 2026
 15:09:00 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Richard Cochran
	<richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Jerry Ray <jerry.ray@microchip.com>
Subject: RE: [PATCH net-next v6 14/15] dt-bindings: net: add onsemi's S2500
Thread-Topic: [PATCH net-next v6 14/15] dt-bindings: net: add onsemi's S2500
Thread-Index: AQHdCFnVC49Mza+OoEG88Iq8ZbN8+7ZXMRvA
Date: Tue, 30 Jun 2026 15:09:00 +0000
Message-ID: <CYYPR02MB98280A43E1F2D36CA55CD2A583F72@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260629-s2500-mac-phy-support-v6-0-18ce79500371@onsemi.com>
 <20260629-s2500-mac-phy-support-v6-14-18ce79500371@onsemi.com>
 <20260630-beryl-mongrel-of-exercise-abf63a@quoll>
In-Reply-To: <20260630-beryl-mongrel-of-exercise-abf63a@quoll>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|LVUPR02MB11515:EE_
x-ms-office365-filtering-correlation-id: 3ce3d931-ae9b-4992-c7a1-08ded6b98429
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|22082099003|18002099003|4143699003|38070700021|11063799006|56012099006
x-microsoft-antispam-message-info: 3sMm+pj4SK39FlZhX4ZJdB9+TUK9pIzO9QOLW9vdAsthU1wmxTzzQeIp/wE/AbdxGNERncwS5mwOa6Vjp4jhdiGdzicne8tYYBmVYzkiIBjuZtYPqCDOPW+nicj1UiKTciQgdyOoMqUR5dlnHNcLViHnw6gEampHbcnPHehumKdyCySDfxi4KDuHwlxk6/1AliwQuHBIl4oLr9PMxXDUCs+TaVNmMpM4m+VcOWu7dYZA0k1MiWFPP1GchM0KvrQyvqU+Nfs2/jHcy3J0ixxmd3+MTgJ1JXYytKF5hGCcQOuJxdbQjnmc5HAU6J5Q+SX2phajoulAiGCq8glKn180LVKR94X787Hu4X9/bdbDXRxY3Ghp4vYVgW8KCaXXzPJceZhl3+j9YUZ1mowczyhC0oaZ2Cv9r84/pMjbIIhEblmDmKlx8c1FwxCgzaP3TiVUsHT2Ic+tsxG73mJJJ/N5JL8x/pdo5daWseE5MCWlMl9ISeaDRFCLTnstIoP1AxdeFauQXigGWQbS84p0UkmMyKSTuWemWlS2V6HUgzYsJQjQwtnOwWLJ/LzQlvOhB8fjcLw3+TqNtJjbVk/2POAtYesLod1kXOHs/41Bc8yUCHCTUciqNykEjvHGUTV3ISXdv2FkYnj86oBsDxNErOlmG+kTHCqyCo8QXEc94tTUl8LVVzTP/JwVhJVRULIRqFX45OkP2sfTiHcqC7pObi3Dwhh9DyGxYdSqMP+skY2bCXM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(4143699003)(38070700021)(11063799006)(56012099006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE85bWN6QUlqa085eDVEQjk1aHlaK0FWQnhvN3h5WVY0ZCtEV0s0cFk4Vkhy?=
 =?utf-8?B?cE5FWTlmM2VKTlVkTE5DWTZLMjlTUHJLYUttUnlETEpKelpoaGhQTlNVL1Ns?=
 =?utf-8?B?K0x1c1hwclg3dHl4OXAxRU5jUkpLVHNOVHRzcytueHk2Yms4VzNRMHFETVVn?=
 =?utf-8?B?OUlvM05zN3l1aDRod09ZZjJXSWlKQWtIZEw2Z3VmYUNEQXh5QmZiRFk4S1pX?=
 =?utf-8?B?aFM5c0hIc3pxSVhhUkgxbEQxbVhZN0QrcjAveGJLeG9QQVJBeGxnVWFVUksx?=
 =?utf-8?B?TU5FNzZ1eFMxUmlCUlRpMTVPSWFWZG95a1FUT1Uwb2Y5Z2k2cGV3ZU1sNktV?=
 =?utf-8?B?ZHhJeFlJbFpZVklHMzFYOHVnRW1OcGpEdVVSV1ZzclNPNzd5SmRISHhERFlx?=
 =?utf-8?B?THhXdVdkWDBzRVVVR1BOWE5FM1AvVGhyWFlia2dMcjV1WE9URm9NaWRmcitD?=
 =?utf-8?B?RC9VZjkwY2FWMi9YVGcvYlVzclFTRElHK3ZXNVZBMGFmUDJsZnM2a0VIYTNB?=
 =?utf-8?B?WUp2STJWbE9jdUlMeSt1cG5mRE5SQnBuRmJuVllMUm92Sk50cFFPcEkwUm0w?=
 =?utf-8?B?YVdUbEFKdXVZUGVoUkxoNE9KVXJtdlpkRk5GMlB1THlGTTROaGFYQ1p4SGln?=
 =?utf-8?B?ak1iU0RoYUpER0RlUXh6bUFFeGFTYXY2MkZTVmVSalYrUXMzNks0WXJ4amlq?=
 =?utf-8?B?ekQxOXBWMHZxSTZaYjVMaGphbHVYalJRcXd0WnFCMEltQU9ReUVrTGUwS0ky?=
 =?utf-8?B?M1loU3N1U1ZGZmhUL3plVHF5eXI3anh3WURQZTNvUHVCSHVxUW8xMW9pcGFG?=
 =?utf-8?B?c0dUNDlzdURHOFFQZmZoSXpQK2d3LzB6RVNBZm5OVW0wVytLNWZiYThWWFkz?=
 =?utf-8?B?REFRWWM0WkZEOUtMOEFvaFp6NzN3a0R6RXdPZFNJeStkeHNneEVxdkp6OEF6?=
 =?utf-8?B?Lzl2d1hxckFONmJrdi8yQWNvNmNJS3FQZVUxMkdHbXRmK0Rub0xNV1N0Vzgv?=
 =?utf-8?B?aFlvU3p1VUFZclQ3N0tleFFIK0RNa0dJTEU4V2t6ek5tRDFCVk1aYmVDWlB0?=
 =?utf-8?B?VWpVWk9TQkVwMzdQUG1tUXVFeGtPY2E3NjdpdzF6eUd3V0ZuWXRPdE04V3JV?=
 =?utf-8?B?dFQzY280OFZjelMxTWZtSVhvN1ZZMDE1VStQS01QNFBJNVpaaFR3NUc0cDdR?=
 =?utf-8?B?aG4rNjk1T1ZQV29BVEJ5dzRqTWtRdUZUcnNxQWwxY2FZQ0Vwa3pBYjh1dHo5?=
 =?utf-8?B?eTZMR2Q0MU1GSUF3Z3FKMlp2RldDKzZmWit3b0R6d0NGWFozZG5PQnFZQmtN?=
 =?utf-8?B?YUU3ODVqSTh1Q3B4WFUrbUpuekN4RHFBMEJleHVhdUNhVkpYY1BKUzF5Q0xQ?=
 =?utf-8?B?WDBET0RqRVZoeW5PcTlxcVc1T1dVb2x5aXhldUVYcGZEYmN6NTBWTWtINllC?=
 =?utf-8?B?ZTY3bFdnYW1Qd3BHSVZmZVNTSjE4Z3g5aDIxTm5LNmZyUndjWmpNc0cxMWR6?=
 =?utf-8?B?NktHRis0ZG5mbTdNQkZkZmVRODB6NFNrOXdSeHNLQlhicjZvNzI3S202TjVY?=
 =?utf-8?B?QU1mZVRKQzUybjM3WkJkMmU1SVI0VVUrQkh2MDVqR3EwdVVWVjNocHdEM3VO?=
 =?utf-8?B?ZW9EbDVSQTQybTBUZG1CSm9uTlZweEprZENQcW1Da0hGMGxZbXBid0F6dExJ?=
 =?utf-8?B?dE1ZMWU1OERVVWFKVU9BbVZNeld0R0dPYTdYdlpmS241VFhnS2FSbU43aS9Q?=
 =?utf-8?B?eVhwdktvbUdTWG9MMUYrUElMay84TzNIMlFSVjN5bFZ0NjZ3OVEzN21PUXhy?=
 =?utf-8?B?R1pmRnF5WEhlMkxLdWttdW5NREpSZjc0N0RnVmNKSlY5NHZLZTdxS3hSd0lm?=
 =?utf-8?B?dW5Ld2ovREsvOUpuL0VzdFQxTmpLQnFFbVVnc3QyQVo1czd0UklQQkNxUUtI?=
 =?utf-8?B?aDR5aDJnbnZ2TlZUTm9VWXNZeVRuSTdnMW8xczJNZm50b2c0cXh0b3IzVXM0?=
 =?utf-8?B?QkNPbDFCMUNwVDNBVW1va3pJeG1ycjBJeXV5eWp1R0xqNHJQV25qOXRCRWlD?=
 =?utf-8?B?bFlqNG13Y2NQRFVyUmlYZFZFdlJLakhGS3JoM3ZheDlCS0FWNnZmMlpQWHFC?=
 =?utf-8?B?NDFaNHhVQUYrUTNKOU5LaEdVZGw5RnlsQzdRL3NNT2Jtc2VjOFd3VUU1NEx5?=
 =?utf-8?B?YW9mcG1FaGhQc25haVRFeHhSaS8yV3Z0QlZ5TFk5dm9OYkZGamljM1l6RnVP?=
 =?utf-8?B?RXM3U2NWOEw5Tjd6MmNFOXA4ODRsQXdrYzRLSUNWWEpScjlEY01BTW9XeXRt?=
 =?utf-8?B?QjlYK1dTZGxMNXk2OVZKT0FRU0c2T2FMNVlaNytoUzFjTmsxenpmT3Uycm9X?=
 =?utf-8?Q?GYxZtzMub8sK4drk=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: I1xACmTUANKf0G7ACZrQLSDTHxDlgp4pRPpp7fmptqmp8l8dyWD9AGfqEAA5nEjGjSNvdu2GcXOdf7K2P3gccpEeqoNN9kIEA2Pj/0Li9EIDznXGblDTki4ELPhSmr+wgno7MH+dHSZmrSMkKa+Xw5vmK44lbDm/eKKaFPpMpO/kpVR0bD259fByAT3W1UsNZ1+5S1irIAOZFjiBWIyvASX9bIzpcjzNOOh5ctjl7VuJSwxM+uIaXY0OCaQ24qxSmDza69D3R/4O0ER7wqY7HmVKejQq+3/q5OAMKf0ffSDhbfIgodp186z5DUeXVFuAnZYF2OGMipDEIplDquUwYw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce3d931-ae9b-4992-c7a1-08ded6b98429
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 15:09:00.7505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R91K6lrK1yNgod1ePDiy54tQT4bgRJfJnPeNjo0m9lCZXVwhKpSWGCvgrcuWUfiMhmy2RCrvwTO30aRv+f9KZW+EcdDaOkAFdB4aYK2kUCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR02MB11515
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8yQdOiIPdQ46svMypX5Q9HwSLHet-k34EHckSLVzktQ_1782832143
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303269-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:andrew@lunn.ch,m:Pier.Beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B29E06E5C4A

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjYgMTQv
MTVdIGR0LWJpbmRpbmdzOiBuZXQ6IGFkZCBvbnNlbWkncyBTMjUwMA0KPiANCj4gTm8gaW1wcm92
ZW1lbnRzLg0KPiANCj4gU28gbm90IG9ubHkgeW91IGlnbm9yZWQgcmV2aWV3IGNvbW1lbnQgYnV0
IHlvdSBhbHNvIGlnbm9yZWQgYWN0dWFsDQo+IHJldmlldyB0YWcuDQo+IA0KPiBEb24ndCB3b3Jy
eSwgd2UgY2FuIGlnbm9yZSB5b3VyIHBhdGNoZXMgYXMgd2VsbC4NCg0KRmFpciBjb21tZW50LiBT
b3JyeSBhYm91dCB0aGF0LiBJIGxvb2tlZCB0aHJvdWdoIG15IGVtYWlscy4gQm90aCB3ZXJlIG1p
c3NlZC4gV2lsbCB0YWtlIGNhcmUgb2YgaXQuDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6
eXN6dG9mDQoNCg==


