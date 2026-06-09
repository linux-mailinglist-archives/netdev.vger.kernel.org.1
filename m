Return-Path: <netdev+bounces-297142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xVJVNz85KGq/AQMAu9opvQ
	(envelope-from <netdev+bounces-297142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:03:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 546BB66219E
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:03:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=a+PCSAeO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297142-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297142-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 243B730829D1
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7333E481AAC;
	Tue,  9 Jun 2026 15:41:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBBA48125B
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:41:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019677; cv=none; b=k+FNYrhf912tS/i6k2uOYmNewfPl+RZ0r9p5FMShd+ttKJUdG1/MBQv1cfaa8Ju+ak4FECY5TGKRpaGFdZkZJ6KZ0K64ymYSdmEmLV21wFkIHXAnbexXnuQKWq2K+kRFDEXHbbFkuKzLK0O75K3Kp2iII9e1jgC/YjGJ0ICAGtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019677; c=relaxed/simple;
	bh=Zmeb0Yc86Eil8wOALtleMwAwi9pY2g5orlI2TlSaSVY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=oxrdkgdiSzxhIQW8On8pAisluZ4xCnA8/o4cj+W2nuuuBRQLlrmuPYV3RX9z9M92Ra1mKcvbKQ/H8dWUiFTlzeSyE0VT3eLevCdlDj05tfMMZ/d75V+UuU5GGmI6tXbhdkXV4SN0jF0hnW7675mRlp8S9Rah/tC6en1Np+Fzfqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=a+PCSAeO; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1781019669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zmeb0Yc86Eil8wOALtleMwAwi9pY2g5orlI2TlSaSVY=;
	b=a+PCSAeO0zhtavn9kspOaZj/JDrBKu+rsoblzZMpitLqkF0/SgtgqydleinY5NzlSDquvh
	3oMPu3/hceEKaa6Tw/yUv/qc/jAbbmI8eIV1/v9TVLV48JnU7Aqr3DgavGmlk6gsMVV9z2
	dfNOBzFnzq37AfV5e8PKSFmzl1yHxE4F/w49F8yiZmJDt4clzjYbDVuJsNP4vz2SKl8gq7
	TJw+WXfLoYGnkF4FvD1R4bb68BCiKX55uNplCxYXbudxbLJGlptS0dkxtu3ORdR/y1ZO+N
	DowzzjmJTDjwJzSJw+A7EffVyOftEi6+6NnWBoD1Cmo+gM2Tf5PO4bstIORjYw==
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-14-BPheUI-7POyTpX0b4bM-4Q-2; Tue,
 09 Jun 2026 08:41:04 -0700
X-MC-Unique: BPheUI-7POyTpX0b4bM-4Q-2
X-Mimecast-MFC-AGG-ID: BPheUI-7POyTpX0b4bM-4Q_1781019659
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CY8PR02MB9452.namprd02.prod.outlook.com (2603:10b6:930:74::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 15:40:57 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 15:40:56 +0000
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
Thread-Index: AQHc8eDLvWzkHnbXI0KmrY/VvMfuDrYrecyAgAALlpCAAm25gIAAkU0wgAAYXICAAAajgIAFcz6AgAAGt5CAAd//gIAAaviw
Date: Tue, 9 Jun 2026 15:40:56 +0000
Message-ID: <CY8PR02MB9249EC4F3896121911D0FF3C831D2@CY8PR02MB9249.namprd02.prod.outlook.com>
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
In-Reply-To: <a02cd86e-a5b8-481c-a07e-7243ee537b24@microchip.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CY8PR02MB9452:EE_
x-ms-office365-filtering-correlation-id: 3e37fb9c-b76e-4cce-9c6a-08dec63d7f8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|6133799003|18002099003|22082099003|11063799006|4143699003|56012099006
x-microsoft-antispam-message-info: gIrIoXIfdN0zX0Fe+BrkTUcSI+J5b4nsT10fVrtG+VoA5h5zN2wiRR7N1WhQuoswDyYPso4lmiUjHXPY+Qm1JX718WHz+9QerK6FidL3qEq2RhmYhPkjWShqwCeLJlez5YAk1u0YEQ6u+DHXNU01hWNaWz0QCWGr4tFBfR1dxgS6gv45c+k/Z68R3c1XtxFIUHJx9Xu5+fy12svciUYrIAjRRI8yqx7e/AS8drIlPmDrJqApIrn0al8Lni3n5YXy7nKcbW0ceujuhqpafXKA3H16BsDuGiM9XRxEW1iQtDN9IrP1fvmipKzTRfMD3yc4ew9NpA1jX2GJ5yFOs4yLBwi1dOGjvW4YbKnnyEtw0w6jSwND7VBZdyU2suPIXYD6c7XxqxrUXK/dW0NI/F6/AodbAic3tawY3Z97rQBZsEaoCE/VVue0IvnExhs6ng9K1DjrEVT3e5zhgXc7ME4xhKP9upSF5cFLtFBwqhxlrx0I1x9J44l+K9/PvvYV/cGz2SFA110NSdNZvJAc2UooF7kX5ek8IPsOPSbf8Y2bcDJhAJP7LSlcr2shq9rHocNjTzO4MRdU894K+NaW49a3AcMvj2BgH8jieGPIhfPbTQRorKie6D+zIZXSygcZ5sxjSuXEPc7tVFMfQC8MLDTg/QOXb7KFLZIbnBuU35tSeFcOb+4ziV/0Rg26c8W0+2Tib36swo5GAraeutd0cpmfFLcfMCFJP2RzZ/2OXI3/kjOaaX8pqn26uotRar87KqeK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmluZE1QeGtYZ1AydUhReUlleDJGN2p1L2RxcFNCdHozWE1BMStNajFLbTVj?=
 =?utf-8?B?S0VTdWdqRHRiVU84aVVQVStKdVBUK0VRemYxVWY3ZUNTRGVOTjdnbVJEYncr?=
 =?utf-8?B?L2MxaEJSeEhIblhjcUNFMWwrVyt4RUo3SmZ1dG9JRTlXTmtYdVFSaFNIVmE5?=
 =?utf-8?B?enpiV2dVU1NTbU1oMWxUeG5nSU1uTy84R0pQQXpxZDBlejZLZGE2VXZFYmRt?=
 =?utf-8?B?aHhBc3ordnlKdzVtdmc1cUdzYWhtR3NCYVNYcEdtVTN2R282dXZlVXFOVXlx?=
 =?utf-8?B?VVg2RGFncnJZZ0VXVlhJRS9PdjlHYjRMblVja0pVcXpBWGVnbHh6ZVJ2aXlF?=
 =?utf-8?B?M0d1ajF1RmZ4UDdFOFZkSTcwSVlXMTIzbGZQSno4SmpFRmtGT3lWUjRtSUUx?=
 =?utf-8?B?QWF6ME5yYXdxN1ZhNHVCaEdBMk1QTkR4QVdyT0lFK1BWaWV2bkk0QXVDaWI0?=
 =?utf-8?B?RU8wUU82NE5xL1VXMWNicUMzTGVtblJRRFNMYjR4ZXZ5dlkyb0I5MHF3M29K?=
 =?utf-8?B?aDJNY1dlQmtpT2dkUE1EMCthT3F5NEFLRlhlTTBzK2tqVzZkaEp4MWFDeWtS?=
 =?utf-8?B?OWYyenVwMEJTL1FJZWwwa013UTJBK282bnpWOFlwUkpldDNQUEp5V1dZR0lq?=
 =?utf-8?B?OG44aUtkbE85dVR6RCtURG9GT2MycURvajdwWFVMLzM3Nnd4Nk5nK3JlbmJU?=
 =?utf-8?B?ak5qWXZ3dTdRSFVWRDVHV2JuVEJoeHpiM3ViL3NIanJYUlU1cVgxR28reWpN?=
 =?utf-8?B?a2xUektlMXE5TW5GVkxmKzl6V1NSUytkQ3d1RkxBR3RGV0JYTGRaVUlHK1o3?=
 =?utf-8?B?bDY0T3gwcHg2NTVPeU9WWlVtT2U3WitQeTBWZ0Q1WmJxcnkzSHA2Z1JULysy?=
 =?utf-8?B?eXcyc05ZaXlXVlVKa3pHM0ZKbVFINVZQSUF2N0U4WktkNlhqTkcxZGJRbnVO?=
 =?utf-8?B?eDQwWFFKa3hMZkRkRTQwL1JPa25ZZkVKNTB5dmJidUxGeHV4YnBhc2V3V3ps?=
 =?utf-8?B?MUtKMk14d05kazViY2c2Vk9ra093Z1JRTTVGSkM2NDdMRHlDVWVFY1pIclZq?=
 =?utf-8?B?UmhEUldsS2xRUzBMaVdFYjFpSmpzcVlmWmhxbXJ5dmpTYzZqREo3eEJ5Z0tS?=
 =?utf-8?B?Nk9mQnc5bjNxWUdERFJqRXI5cnM1UjFxcEdJTnBWSUhtR2NIMTNoVjdqNlJZ?=
 =?utf-8?B?SmRzZldVMjhIdk1yREtIOCtJVDIyQ0srUTJJWU9odVQySUxKdlUzdmdVWUpk?=
 =?utf-8?B?dm96QjNnaEVPVzlnZnR1RllEaU1ySU5vUkExaFBaNXJWVmFsVjZTY2pNL25T?=
 =?utf-8?B?YjBWczg2ZEw1Rk8wbk5hTkdxSlFNT0czSHVQQkZZUGhEOFRlT3ZPNWp5elc4?=
 =?utf-8?B?WC9VYVZYcHhoYnYrUUNydmZBTW5OWHZ5blRlZCs4Qis0bkcwbTQvZmVIMmpi?=
 =?utf-8?B?S0YrTktBeVNtWDZPSWMyR0Y5ay9oZkZMdGFleHFuRWZvY1FqOWF1VkRHeE9w?=
 =?utf-8?B?QkwwMjJBWGJqNUo2YkZ2Q21Kb3NiRDByOVUwUjBXTzFWYklQbTRXY2ROYUhR?=
 =?utf-8?B?KzVZSHJnM3FHRnVLVTZCc2FSeldxeUk5dWtoOWdSdUEycmhXM1pqemkvUGcz?=
 =?utf-8?B?TElYRVMwb0lqLysvOE5ZOHdXMUZraFVPSUxocjQxSS9DUzlMbkNjVGs1dVRF?=
 =?utf-8?B?V3crSWxSYTlwU2ZTUWEyRXhGR2FZYzZuMlpUMmxzNW0rZEZXeEhWM3FYTEZK?=
 =?utf-8?B?MVhTMzE1bXpyckpQZUhSd0crWmltZGVIZm5TVjlFbzU1SVZVaitOQmNWd3FO?=
 =?utf-8?B?MGdZNEVmdG8rM1A4RUNGSlBkenVFSWdLZFdqOC9mMmtnc2NMOGdOKzhtV0Ji?=
 =?utf-8?B?cDlBcDQ2RWxLV1FGenNlK0ZvMjdkMThicXIwdGQrNFZDUThyZkc4bWVrMlN0?=
 =?utf-8?B?bEdGblk2b1NCSm5wdmNNZUgxaWZTZ05mWlNoQWt2Qk9IczVjME93RjFEUzJj?=
 =?utf-8?B?RnI5RlRrY3V0K29mYy8rdjEwd0x1WXYxQ0trU3RSZzBvT3lsUXVzN2hPcCsv?=
 =?utf-8?B?K1dqTE9XSmhIb2J3d0NueXdUSG1BSnNmdDBURXNEYlRwU1lzUFA5TXUyNFlP?=
 =?utf-8?B?dndsU0t6U1hrZkFWaVR3NmVEVUtjTkVWNGxxZ2dhdXRTMC9idlFvR0V6L2dp?=
 =?utf-8?B?a2hRV0pCOEZuMStTRkFEdWpaZEk5T2dvekRhUFlnUGNQcGdKNFJOR1NVY3ZI?=
 =?utf-8?B?dU5QclU3bVlSc3A1bitFeTZkWVY5UFJla0lNZFpTaVAvSXQyVXNkRjcxM0Zp?=
 =?utf-8?B?YXpHRG9iUlRxUU85WFY2VExuUktHREUxRkxVVk9zQU5RZlZ0U01aZz09?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QWX2rcN4P7EeOYyxm+d0jmM5ddhOCqmeK70YtPKj4JKv4fP8jMkiXmP8edJyrmwR+PXdgx4z7smyDdLtW+JYX1C2doiNHt80ZeYimhNPR3IuN1AvCCLzgz6DZ0hQW/4S6Kv1xlHitd2Q5FjRnozO07UI7DDHm1cUwwrG9l+f+ZpZQ4DpdrefIC06qilO7/tdyYg8+6tzZYJ/5cSjB1ziDqlZShoA362Q+j1J/Eh1XjM9CXiT2y7GrVV78+zMaU5odp8HnYUsrnSeNVR0jDAUOoQjjE3uqSASM3+amOMKgIjDb2v/1tIyP4g9R/kOoK+ksescp/nJtv4dHplwPJ4B5A==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e37fb9c-b76e-4cce-9c6a-08dec63d7f8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 15:40:56.8164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UyBOZqF0SiRHP0Cqdc3sqy0ruGC1JQV0IRmVhqKRWkjTQhbge5Dw4A48npi/6sWbm8N/d2GS3RFR7cEaeY5ExsLWxke7w9Zb9S9xIjYr+vE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9452
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1_e-TzVR6-jcdA8KDUB-eT3VqLAENDmptk0LkjDpoIE_1781019659
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297142-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Parthiban.Veerasooran@microchip.com,m:andrew@lunn.ch,m:conor@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,onsemi.com:dkim,onsemi.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 546BB66219E

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCB2MyAyLzJdIGR0LWJpbmRpbmdzOiBuZXQ6IHVwZGF0
ZWQgaW50ZXJydXB0IHR5cGUgdG8gYmUgYWN0aXZlIGxvdywNCj4gbGV2ZWwgdHJpZ2dlcmVkDQo+
IA0KPiBIaSBTZWx2YW1hbmksDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSB1cGRhdGUuIEkgaGF2
ZSBhbHNvIGltcGxlbWVudGVkIHRocmVhZGVkIElSUSBoYW5kbGluZywNCj4gYW5kIGl0IHdvcmtz
IGZpbmUgb24gbXkgc2lkZSBhcyB3ZWxsLiBTaW5jZSB5b3UgYXJlIGFscmVhZHkgcGxhbm5pbmcg
dG8NCj4gcG9zdCBwYXRjaGVzIGZvciB0aGlzIGltcGxlbWVudGF0aW9uIGFuZCBoYXZlIG1lbnRp
b25lZCB0aGF0IHlvdSB3aWxsDQo+IGluY2x1ZGUgdGhlbSBpbiB5b3VyIG5leHQgc3VibWlzc2lv
biwgSSB3aWxsIGhvbGQgb2ZmIG9uIHBvc3RpbmcgbXkNCj4gcGF0Y2ggZm9yIG5vdy4gUGxlYXNl
IGxldCBtZSBrbm93IGlmIHlvdSB3b3VsZCBsaWtlIG1lIHRvIHNoYXJlIGl0IGZyb20NCj4gbXkg
c2lkZS4NCg0KVGhhbmtzIFBhcnRoaWJhbi4NClRob3VnaCBjb2RlIHdhcyByZWFkeSwgSSBnb3Qg
aW50byBvdGhlciB0aGluZ3MgZm9yIHRoZSBwYXN0IHR3byBkYXlzLiBQbGVhc2Ugc2hhcmUgeW91
ciBjaGFuZ2VzLiBJIHdpbGwgY29tcGFyZSB3aXRoIG1pbmUgYmVmb3JlIHN1Ym1pdHRpbmcuIA0K
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IFBhcnRoaWJhbiBWDQo+ID4NCj4gPj4NCj4gPj4gQmVz
dCByZWdhcmRzLA0KPiA+PiBQYXJ0aGliYW4gVg0KPiA+Pj4NCj4gPj4+IEFuZHJldw0KPiA+DQoN
Cg==


