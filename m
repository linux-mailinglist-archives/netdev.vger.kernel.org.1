Return-Path: <netdev+bounces-295302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z+PkLvCdIWotKAEAu9opvQ
	(envelope-from <netdev+bounces-295302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:46:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B78D56418DC
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:46:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=jP7v96Q7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295302-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295302-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E85630BB24B
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 15:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F00330646;
	Thu,  4 Jun 2026 15:22:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC97830AD0B
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 15:22:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586523; cv=none; b=L6XRoQOJRTJLmo8KdyZ5bHuY2XV0q1xTO/vKSiGLtoBWdR2vg2NMxvMlEagRCNKb83UT+6kjQIYlnG+ZVLWoGlSbMXv0ZTu0qx32gjww8oi6WBh6eiHGWYr22xpTQzHGTfedjZsg75nlDV1KWOiBwGZYgtEhdJ6oNZaZLEFVhsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586523; c=relaxed/simple;
	bh=KcthLx6++yL4uXemk1N3qj99iA9kzIt/QcGDckz7V3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=oNat6w9dRsjAfNHiQZ9jD/Wyb1r2LY2cAeHYPn2+XfzybW9yFsc7t8vPtUUXdlW/YYSq3/sRCINqha2V4xmwIHPg0i00aYLVRpAlYTLSP2sawd9JxWuAm2hUFEvW56rnzrmlnwldu72L38smwO4Rqx+dNmWBVBXnkjUZu5+LAww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=jP7v96Q7; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780586521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KcthLx6++yL4uXemk1N3qj99iA9kzIt/QcGDckz7V3M=;
	b=jP7v96Q7q6UyIKmuOciYBhjg8P6TUdhVleKAgPM/vRc781iTML4tM+NsrjDP/bwURYuAZE
	J33g3/lbKVyPycE+VLq1GHW3/S/Y1HLGySpWT8jF+UiZJjs6xlKiGQQ2Ffuh27gat0HAYz
	xuE2jKS2HSsgVx1UpfXvdNJhSfMdpwFs+bxrFZD7XrvhSLsrV+Iiak2o3DHGp5w/zxMA2c
	yCT/fo2VhjruBPM7IJOZXiqgEP3KTtVSjvnTvN899PLkQDDEBrcITpwXokm/h9jaQ/ctDn
	+hXgM8jYZ59bdmzETw5THlcpuAItufUXNOjUiJBLpDuqV9XA/L7a/I3+GeUy+A==
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-72-sdP4K0x0Oyqz4SvULhW3Xw-1; Thu,
 04 Jun 2026 08:21:55 -0700
X-MC-Unique: sdP4K0x0Oyqz4SvULhW3Xw-1
X-Mimecast-MFC-AGG-ID: sdP4K0x0Oyqz4SvULhW3Xw_1780586510
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by SAWPR02MB11996.namprd02.prod.outlook.com (2603:10b6:806:55b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 15:21:47 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 15:21:47 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>, "conor@kernel.org" <conor@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Conor.Dooley@microchip.com" <Conor.Dooley@microchip.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Thread-Topic: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to
 be active low, level triggered
Thread-Index: AQHc8eDLvWzkHnbXI0KmrY/VvMfuDrYrecyAgAALlpCAAm25gIAAkU0w
Date: Thu, 4 Jun 2026 15:21:47 +0000
Message-ID: <CY8PR02MB9249E607ACBF3A05AB83ABF683102@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
 <20260601-level-trigger-v3-2-da73e7010532@onsemi.com>
 <20260602-rebel-snide-5036c97e410d@spud>
 <CY8PR02MB92493D2E5491AAE5416C05A283122@CY8PR02MB9249.namprd02.prod.outlook.com>
 <a5abb9b8-6ebf-4f95-a684-fc889b98acea@microchip.com>
In-Reply-To: <a5abb9b8-6ebf-4f95-a684-fc889b98acea@microchip.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|SAWPR02MB11996:EE_
x-ms-office365-filtering-correlation-id: 642f23d7-e137-40ef-feee-08dec24cfe46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|6133799003|22082099003|38070700021|4143699003|56012099006|5023799004|11063799006
x-microsoft-antispam-message-info: A+eKcY+A2eR435ci3D1FPE9WuPnKR++P1eKkLs7SK5S1KpDIU+n+oV1YuwIlQRxDnzrfYzSp/JpFurEx416kJCbkddu+nNlBhCrystBGL/JUZ12Eq1GZxUQnqmEGRId89sgeAHJJ0SFqDAZ4iNB3xm9SyeTZxl+EUKELZz5ynb4G5mhr1m6RXMXCpGzdAplNzvgMho34cpggJ0N4ZMplwssSAiCuVDLXcrMz/0hHEiBFP4M5E+lHuoiPa5P8kIwZQNN3+W0T5tp7P9khu1ny3Nfpi1sUAs3O0J4GLO2IbFAkbiLpqgUqCU8uJhB6Cbi4XNj7RGMDbF4AS/fD3rq9zPpIyiVbeRkbjY7t+pMDwITsaY34zxZqZcYK2udvBMT+se4xm98IV4yY+mfJASc523mWAeHUKnlxKu+ev6oYKdfeKaVbi+J8oGniThg8/kf0qvItdykeOuTqv764UdWrzE2Kygqta8Pikl5aPYDMIK+/FRUsPg1KPwTPNHX+I/RuYvqdx0doV3p5JeLHPqcbNcEnmZWWKawlFLMIDXFIBN1+NhDU9PL/V1t1yzhtjUxewlSFYj2mSlHyXzj/Y8XJsL9WpabrN6oy+ryxB5yncQP1pGeAaVuvQeGtjbD3Ltl7YmBf/8Sz//FBdhA5G73WMln2Ktf6mtb3gLzkBeBRaSG2GAI/EolA1WZbTLcf8YE66izsd4E1nfPy3Xr9Z/6UCINX5x5BPv4jenuFPvvi1TnO/OZBrlg6b7E1GTSksBuV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(6133799003)(22082099003)(38070700021)(4143699003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cC9YVUp3bHJJN1NDalJxa2E3RDRDVUx3ODM0cmMyRms2WWpISHo4WTRWdUtO?=
 =?utf-8?B?aWhPRXEzMGJzSFQ5VzlDSllFc0ZGcjREd3hqa2MwcXFiN2tUMWtkR2FCRXJl?=
 =?utf-8?B?UUtYMTFIRjgxZXpYSlViSlNWZm8ySHIwa0JIL0psTkZ0RmRYYUlwQm4rcVFh?=
 =?utf-8?B?UHh4eEVwenQycnhzRzNvQnBnTTlNM2lVVi9HcVNOcURWRER5QlR2SFAzSCtI?=
 =?utf-8?B?aUx0UUZUN0lMak5Zdlp0QTNRTXRFNi9nRGdxdUpmdm12ek1qZWdNZkowcmZV?=
 =?utf-8?B?dGNrVGk1cWVwUmVEMk9iWXRTUnNuMitOMVF0UFZ4K3V6YTR2Q3ZUMUJ5Q210?=
 =?utf-8?B?cWc0L0pjYzlOUFBGbWl5ZDlGSnd2TDBDRTFwRnpJTWdwN3dCL0J2cVdlRnVC?=
 =?utf-8?B?MkhsWGFDY3EyK0d5UnYwV3dpSjdNY1lCMkJucTk2NDJzRjdDaEw1cFc2WTUv?=
 =?utf-8?B?WXpJTXpEVUVwZlBOTmhsYzB0N3JHSzdoSjduc1lSU0kyUG50K1lFZmE0SmF3?=
 =?utf-8?B?R2NlanhlTTVHWXEyUmFCWWtvc3paMW1qRzhLTTRTRU1FaVlXSUxEdmFwdW9S?=
 =?utf-8?B?NWpuQlIxR1U5QVcvUnlhMVFGekpFYyt2b3JUOFhHTXN3cXpUUzBpVC9kYmh3?=
 =?utf-8?B?bzlxOVJkZXlaT21RUlp2blpheEl3cytqdGRSVWhqc1NXWll3ZEs4dHFRU1ZK?=
 =?utf-8?B?MDJYdW9qcWFGQlhWdFNyb1ZFL1E5N3l0N1Z4ZzE3b0JlemcwcERrSmhsaDJT?=
 =?utf-8?B?L2x3S2hPMkF6RTBxckM3THIzN2xnei9ibldlQWVuOUV1SDdxc3hiQXYzaUIx?=
 =?utf-8?B?SzkyQ1J3QkpqYzdNYXVCQ2x0WEs1enFDZE1NNjBOWWJjdHlxTjRScVFqcVBO?=
 =?utf-8?B?OW4zSklCRlVMS05wTXFkNXZjUFVLNkJwRnh6RUhrZVpwcW5ZYzZrWnBoOVhu?=
 =?utf-8?B?d0xHbHp2ak5rR2pSelZheFF2Ylljck9hMTJwV1p2VEgvcFVKWGd1c01RN2l4?=
 =?utf-8?B?WmkxQzJScFdRTUlwMklyR0pYeXFkTld6eG5FMGt4RUV2Z3BmMWlrbmtNRjV5?=
 =?utf-8?B?TGdZdTJNUjM0OW00TVNLVDhoRU10bnQ0Y2poeTRrSHdGbkZKSjR2SUROQjNO?=
 =?utf-8?B?elNsUlVDcllzOTNDbS92V2w2TDNWdm5YeHdaMGp6R0VDQUNZZm1SWUhwNDE5?=
 =?utf-8?B?NGZ3OFp6bDVBZWNrQUI1MjM3eUdvMWcrRXNSRXVCd2xrOGRWemg3YWc1R1Q1?=
 =?utf-8?B?Z3Bqa085NDJsNCs2VGFoc3JMYUF1WFYvSXF0cDR3bmpXNU9kbkQ3WVMzVTVy?=
 =?utf-8?B?dU9TcFNLZUdERExxMUJPVmtEL0ZRU1A3ditLakQxWDhiMUkzNlJVUVNRVXkx?=
 =?utf-8?B?NGZSOEczNzVZdG1qbGhlZVd5bURRMHo1L3k4TWY5d2FlNEo3VnFNbncvK0N6?=
 =?utf-8?B?VGtZOVE1TnM4RXVPUEdaQ0NxM1d3R2hUQytsdko3cFRDRjVwU0JHYXZqSG9W?=
 =?utf-8?B?d1ZWVUdwV3dPeVB2S2xjWEcrdG5BdU5sbWtmaVJqck1nTnFObi9XTUI0QVlU?=
 =?utf-8?B?YisxYTNGSjc2T2d5VXFyNHpXdmJ1ZUV3aUpOOUNIYml6YktFaFJuREpUYzB5?=
 =?utf-8?B?bkpVcmZDRHFxaEdwdVRkVTN3QVlRbnBNUUY3dDRHWm5hcnZLckk2TnJ3YzJ5?=
 =?utf-8?B?eFR4Z1lMdTEySVFMb3U5Sm9jaTVaekk1bWlHMDZERGxqSkZORUhJTjhpb3Yz?=
 =?utf-8?B?VzNkVlpLNHBxUHRmUlEvZXpDSzd1dFVCcHVNdGdoTU14eG55a0duTG1RQ0VX?=
 =?utf-8?B?YS85c01sLzhpSVNuQXE4Vy80Vk9aS2xlR05Ea2ZRZlhlWUFYTjhJdnFsTlBH?=
 =?utf-8?B?UzlFelRyRUhTTDVob2k3dVFyc1RESUVaRmswdFVLZjVtNzhldjhRVzJVK1JW?=
 =?utf-8?B?a0pyOWZUVFVmVkRxVndzY28yQ0ZTTWpvN1p2UWhacXA1RHc5eHlVNUpSWTVM?=
 =?utf-8?B?Wk8rMGdtVTVqUUErSHlxWVJnSXFmMWhmcFJxQlFNUVBEaFJNWmhzeDg4UHFn?=
 =?utf-8?B?K3dvZ2M4MWg4b3ZCbkhqYWlnQ2l6YkN1U1JiRDQyVWVHODluSDZoTmNiMWNW?=
 =?utf-8?B?dml0R29HV1VEb2cvdS8xa1EydEFTVTJEckFnTFpjYjRNU2ZZRWU3T05NaFlF?=
 =?utf-8?B?c0xFTHVIOEJEWXhLQmFoWTBDYWhsUXExOEZxOTd2SVlQMWFaZGNCYUdZR2pR?=
 =?utf-8?B?aUhOZXB2N1BXSy9yZzVCMEZTamVlU1Ziby84S0RUNzFGdTNhamVXRkpCN0Rm?=
 =?utf-8?B?THh6RlpKYm94THMySVgyUWZ2S0ppZXkxQW80UnJDZmkvM3VZTHQ3TGxhdTYy?=
 =?utf-8?Q?xCwPqsZMI/D8lz6A=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fMJewksZ5s72RA0DEDROUAJII4akR0J5Ny+OB01vTa0BQT9P985uremIaSQ3eNLUcZRJMCaOCaona8UwSDqGEFeAhu3HL91PG5zn8OgHqywO3XTRjJ6wbtmH1gO4iCbX0L1Mv8Shk9xuLNIcOvsfwX6FYgO6Ab9+kF1Cmqb6VCO+kJ3FwRb+sW71nUgXZ5DHfjezrgGBxSLd5a4KXPj3Km/Iv51nekR3jRayDecWMQwG04xTcNYOiQtuJnxou7TRUZL7Wvr2hF92P3b2xWBf7M16VexqPPm3/awjXlo00C+Is3NnHM9NLOQ8MuLHZ6VncqvPyibZfar2arhfI1LVnA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642f23d7-e137-40ef-feee-08dec24cfe46
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 15:21:47.1599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I7F52jBYUbU09zEyXLe/SfTrSGKiDl+ZXxDsVJVOEedp19D60yKNibMwinyIMTFYijJucdFeq3FJ6g6A7A1JL2T6bPq0HF6yFR/xlIIOjf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR02MB11996
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ftgh4RmCb6tGK4K6eODGOYFDOAxhunciRo_SwgdO5UA_1780586510
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.56 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295302-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Parthiban.Veerasooran@microchip.com,m:conor@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,onsemi.com:from_mime,onsemi.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B78D56418DC

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCB2MyAyLzJdIGR0LWJpbmRpbmdzOiBuZXQ6IHVwZGF0
ZWQgaW50ZXJydXB0IHR5cGUgdG8gYmUgYWN0aXZlIGxvdywNCj4gbGV2ZWwgdHJpZ2dlcmVkDQo+
IA0KPiBIaSBDb25vciAmIFNlbHZhbWFuaSwNCj4gDQpbLl0NCj4gT25lIHBvc3NpYmxlIGFsdGVy
bmF0aXZlIGNvdWxkIGJlIHRvIHVzZSBhIHRocmVhZGVkIElSUSBoYW5kbGVyIHdpdGgNCj4gSVJR
Rl9PTkVTSE9ULCB3aGVyZSB0aGUgSVJRIGxpbmUgaXMgZGlzYWJsZWQgdW50aWwgdGhlIGhhbmRs
ZXINCj4gY29tcGxldGVzLCBhbmQgc2xlZXBpbmcgaXMgYWxsb3dlZC4gSW4gdGhhdCBjYXNlLCB3
ZSBjb3VsZCBwZXJmb3JtIHRoZQ0KPiBTUEkgdHJhbnNmZXIgaW4gdGhlIHRocmVhZGVkIGhhbmRs
ZXIgdG8gc2VuZCB0aGUgZGF0YSBoZWFkZXIgYW5kDQo+IGRlYXNzZXJ0IHRoZSBpbnRlcnJ1cHQs
IHdoaWxlIGRlZmVycmluZyB0aGUgcmVtYWluaW5nIHdvcmsgdG8gYSBzZXBhcmF0ZQ0KPiBrdGhy
ZWFkICh0aGUgY3VycmVudCBTUEkgdGhyZWFkKS4gSG93ZXZlciwgSSBoYXZlIG5vdCB5ZXQgdHJp
ZWQgdGhpcw0KPiBpbXBsZW1lbnRhdGlvbiwgc28gSSBjYW5ub3QgY29tbWVudCBvbiBpdHMgYmVo
YXZpb3Igb3IgZWZmZWN0aXZlbmVzcw0KPiB3aXRob3V0IGltcGxlbWVudGluZyBhbmQgdGVzdGlu
ZyBpdC4NCg0KSSBjYW4gdGVzdCB0aGlzIGluIG15IHNldHVwLg0KDQo+IA0KPiBJIG1heSBiZSBt
aXNzaW5nIHNvbWV0aGluZyBoZXJlIGFuZCBhbSB0cnlpbmcgdG8gY2xhcmlmeSBteQ0KPiB1bmRl
cnN0YW5kaW5nLiBJIGFtIGFsc28gY3VyaW91cyB3aHkgdGhpcyBpc3N1ZSByZXByb2R1Y2VzIG9u
IG91ciBzeXN0ZW0NCj4gYnV0IGRvZXMgbm90IGFwcGVhciBpbiBTZWx2YW1hbmnigJlzIHNldHVw
IHdpdGggYW4gYWN0aXZl4oCRbG93IGxldmVsDQo+IGludGVycnVwdCBjb25maWd1cmF0aW9uLiBJ
ZiBwb3NzaWJsZSwgY291bGQgeW91IHNoYXJlIGRldGFpbHMgb2YgeW91cg0KPiBzZXR1cCBhbmQg
aG93IHRoZSB0ZXN0aW5nIGlzIGJlaW5nIHBlcmZvcm1lZD8NCg0KTXkgc2V0dXAgaXMgc2ltaWxh
ciB0byB5b3Vycy4gV2UgaGF2ZSBSYXNwYmVycnkgUGkgYm9hcmRzIChQLTQgJiBQaS01KSBjb25u
ZWN0ZWQNCnRvIG91ciBNQUMtUEhZIGV2YWx1YXRpb24gYm9hcmQuIEFzIHlvdSBjb3VsZCBzZWUg
aW4gbXkgcGF0Y2ggc3VibWlzc2lvbnMsIA0KdGhlcmUgYXJlIG5vIGNoYW5nZXMgdG8gb2FfdGM2
LmMgaW4gdGhlIHdheSBpbnRlcnJ1cHRzIGFyZSBoYW5kbGVkLg0KDQo+IA0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IFBhcnRoaWJhbiBWDQo+ID4NCj4gPj4NCj4gPj4gQ2hlZXJzLA0KPiA+PiBDb25vci4N
Cj4gPj4NCj4gPj4+DQoNCg==


