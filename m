Return-Path: <netdev+bounces-298158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a6aUMNbEKmo5wgMAu9opvQ
	(envelope-from <netdev+bounces-298158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:23:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 339C2672ABE
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:23:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=V4ar4KAg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298158-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298158-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33834308F820
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F061410D38;
	Thu, 11 Jun 2026 14:23:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D227406811
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 14:23:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781187784; cv=none; b=seeJ5J+HD/o6Yg2z3Hu4CISgBPqjIDyRGRpZ/YXflgSQ/tQmScOpD3q4XEiYAsIqgOKJe9TuSf/ptFnjZ8/azkYUDfwnQqwzW7+XKxTusdkzuGep/7o426CeLRW5CEz48AShyo+iYwBWpyxLcTNtN9mHqPeMQTzbfe9X3VE5As8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781187784; c=relaxed/simple;
	bh=GavPWrlAwC69kahRs6+2JXNVG6cSJB3RkGnFR0ikOPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Rx1586q5NRRhB8zipieg1qogZnyrCNvVxPFco2M11cq5aroewm/DxxAgX8QA1AriIlL1GY6b471YALZGYt8v1J4QRcQMeMeaDDzGGXz3JeoAPArNVVJkjxXb/53yAUZ+VyRZWiguxE1c8xYjzHH8m1bDZfoA8ZzRG7NB+8m/VUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=V4ar4KAg; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1781187776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GavPWrlAwC69kahRs6+2JXNVG6cSJB3RkGnFR0ikOPA=;
	b=V4ar4KAgDYoGtIZZbZwvS6ruE45P1GT0BKNYslG2yhIHzk3cf9ru5TWpt93FmbFoiYbHZn
	SA9K19BIaxN2bRPCsm1uHvDbfRaCV4qrgtmuqZeQ5yming6ZSxWzjbuinb5fXSNvCiSMwv
	QVrOfSG/+r5tk8cyrsk0htSwnprrBOO0R9FEFge4F7nbk+F2ThR0bGP0xHE8kxk3O1aJAr
	9K2o3SEH6X/WLrLPaGPzZYqttF1OA8mX/eCheD4qj7QacXrRkADYN7QJCWJ4KUo+tUeenk
	NqFQhZXf3Izd46MR0Yq47mjRkJ7A7+tTzLrYdPqRqLZVxFb082E6B1Yjpa9wPA==
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-46-eZLU9Vi_MVC5cwkPd244ew-2; Thu,
 11 Jun 2026 07:22:51 -0700
X-MC-Unique: eZLU9Vi_MVC5cwkPd244ew-2
X-Mimecast-MFC-AGG-ID: eZLU9Vi_MVC5cwkPd244ew_1781187767
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by DS0PR02MB9353.namprd02.prod.outlook.com (2603:10b6:8:153::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 14:22:41 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 14:22:40 +0000
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
Thread-Index: AQHc8eDLvWzkHnbXI0KmrY/VvMfuDrYrecyAgAALlpCAAm25gIAAkU0wgAAYXICAAAajgIAFcz6AgAAGt5CAAd//gIAAaviwgABI9uCAAq+yAIAAFbtQ
Date: Thu, 11 Jun 2026 14:22:40 +0000
Message-ID: <CY8PR02MB92498B8CC2E0A3B50908C510831B2@CY8PR02MB9249.namprd02.prod.outlook.com>
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
 <CY8PR02MB9249B913E28E285EB46EC59C831D2@CY8PR02MB9249.namprd02.prod.outlook.com>
 <56e6c9ea-2e2a-406d-b7d0-ec484e3170e6@microchip.com>
In-Reply-To: <56e6c9ea-2e2a-406d-b7d0-ec484e3170e6@microchip.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|DS0PR02MB9353:EE_
x-ms-office365-filtering-correlation-id: 7a892003-fef7-4dc6-36b9-08dec7c4e516
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|4143699003|11063799006|56012099006|22082099003|18002099003|38070700021
x-microsoft-antispam-message-info: hNElvY5jar+qs74RRsAkMyEcI5DA+iklq1+xsjHRe1ANt5Y/XoiQSdgoN7l52ehndcQcy0/bH6Zi2QWykqG5Ez9kjV5OJu0u8EtIDDFMMruA16zcve+Z4qUSOFY6qtFg9luccqIyM/1kYFu60ZNMSzfONZJPfF4W9uDUT/oV8M2+WOEonutu8v927SGcSQ1fnb/NXWIvjbVNtzMNHz2PSy9dZlcsFcwaAURHzDrRUGJkzwQqxHP2ORK2iQnYxpQ8XTwv92wlVp61Y6j8opgFfZxDEiu7Jm7kJTYwnf88twKM2rUSHOqLf2Ykhyn54Q6D7oXTF6/lIRTKOdyQ9JDEGH7jt955AnuLYhKE6AaJkMPWWWC7LQDTA8q3CRvIG4lCRqk4ors30OpbWDEpj/e/yF5GR8p04eyg3fJgfHHCme/utr06jLcd1VTeFg/Fax+MiVftWUEMAFZskO4Jvr6cfrGtAQr4Y+3WnpoGVaAUlGuYIqusVQ83aK1WBgR98fAWDNVfqorS9sQ8WNiMmAomDwvGCjPTtAeV5JO5kRwE8TRe1YYS0mMZm52Pv2aInyv1Vz7eKxG4uP/hsyc2cHg5RJ1HVtuCnK/yijv18dl+4lCc/muEKjLDVPO03YuyFQvvGbPp/v13H2Za8zC6vKzbh4uXJ7dG6onx950+1xGoF+ViicwAiSFwyuDz6jTaQoSXW9b5UlUeGQZMOFqkhCyYjTotpzgKGnFfX0vUapFsCmaN9Arfyu5ma83mCsy5RdFW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1EyUUhpT1JGRE9Zb2hpRGZqZ2dKV3hQa3lzdGxMUmc3UWNmalFrb0oxeUlO?=
 =?utf-8?B?YUEzRVdTVlEzc25DM1kwN2YwT05Ib1R3cXVyVjZvUGVTVHJRdEQybytrZUpv?=
 =?utf-8?B?SW1YTVZNZ2lkQ2xhZW5aRnZUU3Y3Sk84RnZYMGVvbmgrZWh4dlFGdVBoTmtm?=
 =?utf-8?B?V0VpQUlhamlSMmZ0N2tUOXVxZXpaN1VkVjN0Q0lqWDczNm5VRkhtMmZRNkVt?=
 =?utf-8?B?TlQvejEyb2FNbHhwaTZnK20wV3duNHh4bjV0QVZzbHVsaVF4WWVZRmJmU1FP?=
 =?utf-8?B?TlhCWUNSc1h5ek9OL2MvOHg5Y0c2aWpYR2gwTHZkSy83STJYUTZNUFgyUXFO?=
 =?utf-8?B?YTJrdXFnazFQT1ZrNENobWxyaGRUSkVteXlNZ013WDNySjV0S0c3T2VsclI2?=
 =?utf-8?B?S1NpajlyM2Z3cEZaY1I3K0xvTEdvdVdZS1hpR0llbng2QVZkZjZ4OHliSEhu?=
 =?utf-8?B?dHBwMURDNDBJZ0tIWUV6Wi9jS3ZZZVNRb05CMVFaZDRvU1BXNThrVEpmV2xZ?=
 =?utf-8?B?VHpNbmtEQ3lIdHVOSklIMGk4VlFmN3l0MmFlTitUMUdISUNSMDVXMUUxN3BF?=
 =?utf-8?B?cFg2N01DeFhvVW9EMU5rOEp1SFh0K1J4anhXd21TMlBqTGFCWUcvdGNkTTBy?=
 =?utf-8?B?bUt4MDJZY1RxUXo5bmFWNDRlQWdEOUtTbnFDcWxEOHdJR3VHVjBMRDh6dVd0?=
 =?utf-8?B?QWQ2UDFpMFhjRGU5UVRBSHZoMGxNZTAvTkx0Ym9aYmFoZExQeGtmK3ZKdUZK?=
 =?utf-8?B?UTRBZmFvaWEzYzF6MmI4bjFGYzVFUGg3Z2sxRkQ5RWhrbkJyaVp5WmJod09N?=
 =?utf-8?B?T1k3clkrNU1TclhhN2VLU2kzVE54bk5sQk9YOWpJelRhOUNOMVlmZ2xPRmdi?=
 =?utf-8?B?ZzdPdjFKbUR3ZFRJT0xyWDgrRUlqVlEzQTl0MllNWGU1T1k5YVB1NEdxYUpn?=
 =?utf-8?B?bFlFZm9SdWV2SWtTa3pIYlNuR2xBUjB4cDNLUEZDWU1BZUhueDBaeVpwdU1r?=
 =?utf-8?B?cDE2S1ZrUGNMcWFKcXhkWW9DZGdBSWtGTHZ6amJRdnoyNUZpV0VXanhZNytU?=
 =?utf-8?B?b0NHVFJkQ2FVcDdpa1FtcEZPWXNTWWo1b1Nub0VOeW54TEF6UmV0Z1lNYjVw?=
 =?utf-8?B?d3VsTVlEa3g4dmVmNEhCWUFsZXVvRDVSTXpuc1ZiQ2NvMHFwRE15L2hISUNr?=
 =?utf-8?B?TmR6ZktsWC85QjFabGpwSHRuNFljcDFoRXZzd285V1NjZWZaTHR2OEJCRHJY?=
 =?utf-8?B?OVFsY21HaVcwZnlUZnBMRFNobkp2dTVIQjA5VHVIREEwSHNVU0I2MmttZ0JH?=
 =?utf-8?B?c1BhWnR5bGRlaS9haHNTWDBQOUxmRTE0N01zZU1XcDZoSndPbTBnUzh2ekNr?=
 =?utf-8?B?ciszcUpvQTNjOVMwVnlXUG5CNXl2Q3FyV3NaOWJZTEg0OVZEWnhlMjdoeFZH?=
 =?utf-8?B?YTNET3pHU0VZbUlPUXRLSmZxWTBRRXFlUmVQR3VqZUFBZGdWdmc0c2tRQWJ3?=
 =?utf-8?B?MEdiMm5ZTHV0UFBNMXNycXF2RlJFWlNSSGVQSWsvSWNxSnV2T1o3eFpuYXpC?=
 =?utf-8?B?TVAxc1RsdGpnM2k2SGVuTmtrOXVpRFBwUUdYaW5vMENSTU9FWVptUmdIenRv?=
 =?utf-8?B?eWhGUWMvY3pldTZ4QWVnMVdpUUIyYUQ2WmUzczlRQm1DZnFFcGNGK1E4bG95?=
 =?utf-8?B?eU1mZU56K29BZHBXckZRSTg4czMwelk1d2MzWjVUOUZJVnRKT3paeEJpOXZC?=
 =?utf-8?B?NjRSM1Q5OXpNakg4SkxTc2dXMlhhL3FRVXZKRnpyNVhremZGSmpTeGJVYUJL?=
 =?utf-8?B?V2NOWGJ0OGhzRzNNamZDeGdGZk5yZVBmNWYwUlNySHpnN3YvcUlGbTNNeVdx?=
 =?utf-8?B?enpFQlFTdlJFMFE1ZkIxa0dVTGhUalJ4K2hheVJrQU5JUDl2TDU1MFBTcENR?=
 =?utf-8?B?aWhhNHlhVW9GZ25Rb2plaERYQWFoaWVCL1UzWGJGY012cVM5a2VZc0RWRVZB?=
 =?utf-8?B?K21DWjl1ZXd4WnFmK0Ztc0lMclVWc3graWZEa2ZRVllRRkJWTFNXSWdxRWpR?=
 =?utf-8?B?WCszRk5QdUdRNlkyOUxMTEtNeEJwMEZWQVJRKzRlV1BhZnFGUnNoQVR4dHBr?=
 =?utf-8?B?QnVYcTNRd0xySm9acStidW5DYm5HN3dQMTM4UWFubnNhZnJHc3Vqd1d2ZEVi?=
 =?utf-8?B?cHVOZ2lDM3lNa3M5MCtDQXZpTFR1dG4vVXZpdnQ0a2tLTnVJMXNLaXlFMzZW?=
 =?utf-8?B?Y0h4WlVIOU05bUlJK1owRFF4QTE4Qk5pTDFHWFRwYnNZdmFqTnJIR25HZFhu?=
 =?utf-8?B?K0crK0hUekpEQ0I3ZjExTmY4MmVHWDZJZ3F1UGU2dWxMc3FPUWFFdz09?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: A4r/JTKYNAhcUnMty+gGq3WjHx6myM3r7Yzx0p1vZ1dnuQjOua5g0zNCQAG5rNM54aNrYwYRn6JifGzQPF40m8uy8rD0Z/j0GFtg12CYU869dbiSr7XHzU5RsxqIdrgJZAdABYwR5eUvAH4e/oV2CD1hLsAOt51ISyajFJean4QQsjqw6uHB7inSFkChluZPkRs+dn88PZHEluI9q9hI2xZ/fD7cWEBkvt2fbKQh0N7EgSsQcADtnhY919jYu3HqsbUwQSrnnLtxJWlD864o2vPbI6Pmj9GHpSfQp0LfW8FmfQSyK2Fv5blhhnk9hWPE6eEr++eEbuvV1ERopsEsIg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a892003-fef7-4dc6-36b9-08dec7c4e516
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 14:22:40.3997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3JA2jdGOd9mKOmJcVqhRqptlMVleyVDMcZgkmqPs4vyi7jipprMg4I+TGZwjz2Q32uCvk71zJKOTUV9Tz8y5upA6DCilEqGDgdW9sYivYZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9353
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2OcsMvhUy93a0TXm04sFa8Jx8ZyRKYhHKnSgqhtPSQs_1781187767
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298158-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Parthiban.Veerasooran@microchip.com,m:andrew@lunn.ch,m:conor@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,onsemi.com:dkim,onsemi.com:from_mime,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 339C2672ABE

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCB2MyAyLzJdIGR0LWJpbmRpbmdzOiBuZXQ6IHVwZGF0
ZWQgaW50ZXJydXB0IHR5cGUgdG8gYmUgYWN0aXZlIGxvdywNCj4gbGV2ZWwgdHJpZ2dlcmVkDQo+
IA0KPiANCj4gSGkgU2VsdmFtYW5pLA0KPiANCj4gT24gMTAvMDYvMjYgMTozMiBhbSwgU2VsdmFt
YW5pIFJhamFnb3BhbCB3cm90ZToNCj4NCj4gVGhhbmsgeW91IGZvciB0aGUgdXBkYXRlLiBJIHdp
bGwgdGVzdCB5b3VyIHY0IHN1Ym1pc3Npb24gYW5kIHNoYXJlIHRoZQ0KPiBmZWVkYmFjayBhcyBz
b29uIGFzIHBvc3NpYmxlLg0KDQpQYXJ0aGliYW4sDQoNCkkgdGhpbmsgaXQgaXMgYmV0dGVyIHRv
IHdhaXQgZm9yIHY1IHRvIHRlc3QuIHY0IGZhaWxlZCBpbiBBSSBjb2RlIHJldmlldy4gSXQgcmFp
c2VkIHNvbWUgaW1wb3J0YW50IHJhY2UgY29uZGl0aW9ucyByZWxhdGVkIA0KcXVlc3Rpb25zLiBJ
IGhhdmUgc29tZSBtb3JlIGNoYW5nZXMgdG8gYWRkcmVzcyB0aG9zZS4gV2lsbCBzdWJtaXQgdjUg
c29vbi4gWW91IHdpbGwgaGF2ZSBpdCBieSBNb25kYXksIGlmIG5vdCB0b2RheS4NCg0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBQYXJ0aGliYW4gVg0KPiA+DQoNCg==


