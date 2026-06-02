Return-Path: <netdev+bounces-293978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOaBDTdFHmomiQkAu9opvQ
	(envelope-from <netdev+bounces-293978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:51:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4F1627693
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BB70301368C
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189B22DEA89;
	Tue,  2 Jun 2026 02:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="guQUczOy"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6339531ED8B
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780368356; cv=none; b=HwAGUgmzixoUzfKidf7R+KMTONpBOkrfBRoJF6flDXXgRYd4ZjEKqg01Z6I/EhEvENcjYQXepFZXe2ZRiGa6fdLWP3GRyB1jOTQriGzTv4RCw7rWEbrhQkqLlrvWLhfS2d4EbrM83Vwy8qrkXu/ZObxLnaqMD451ostvqu5/ugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780368356; c=relaxed/simple;
	bh=igQN0sBf06tV2DO+6GGgERNB1TupoRy4xA9e2Mc1HiU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=nBC77GmuR7q6MrOzrFfxf4NEobdMYeC1XULoIKF0CnigluJtBO9e7Ka0FoJcXxvARVvTZcnKnznNuRI9k8Q5WQ4zUS24F7sez+lc1hP7QFYLpO7dx6Vg5hAXGAcxbk39wzcXlSLo+M81jYzwz5S8Yaxou7lg9511MsgbTTp0Dbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=guQUczOy; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780368354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=igQN0sBf06tV2DO+6GGgERNB1TupoRy4xA9e2Mc1HiU=;
	b=guQUczOyvCQd5Fgdlt2HaVPg+2u2Gjfmey5sSFfkKGPbHHl/NqzWC7BAZHQZyG+o5NL4rw
	6vB36N5xNG44royxE9X3uLif2dZMFib8caXChZTd2RTkQSptQ/W2rZUTJMGU4bsvPYz5ls
	68P6hRrXLLTjCvtGiEIGa+eQI27W1IbhZ8Y3hDHI3jbcWfaUbbP/kzp8vzAriJoYyoBRKd
	nyCcllfUg73L6gQFWD8xr9zknHp315tuG+nLTJ7MDX0tK47qvEI4Om/pCgvPRBWvkYX6u0
	fXvn875MoYX7fbm2ImDXbc5Y3FH54YL7sgNVuRLpgISFX19ZlU8Ro2ofOjcVIQ==
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-41-t5PF5IwxPsqnUKV-0w6AIg-1; Mon,
 01 Jun 2026 19:45:51 -0700
X-MC-Unique: t5PF5IwxPsqnUKV-0w6AIg-1
X-Mimecast-MFC-AGG-ID: t5PF5IwxPsqnUKV-0w6AIg_1780368349
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by SJ0PR02MB8783.namprd02.prod.outlook.com (2603:10b6:a03:3e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 02:45:46 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 02:45:39 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "parthiban.veerasooran@microchip.com"
	<parthiban.veerasooran@microchip.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v2 2/2] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Thread-Topic: [PATCH net v2 2/2] dt-bindings: net: updated interrupt type to
 be active low, level triggered
Thread-Index: Adzvphv6ynOJ7tFNRMGEE6zUoRwGYAAea6+AAIZzBNA=
Date: Tue, 2 Jun 2026 02:45:39 +0000
Message-ID: <CY8PR02MB9249A4BE4B6473A7A194379B83122@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB92497E67D5AB4C72E7A4C12683162@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260530-brainy-azure-swallow-9c8e1f@quoll>
In-Reply-To: <20260530-brainy-azure-swallow-9c8e1f@quoll>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|SJ0PR02MB8783:EE_
x-ms-office365-filtering-correlation-id: 31e091da-9606-45e2-c5b6-08dec0510832
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700021|22082099003|18002099003|6133799003|56012099006|11063799006|4143699003
x-microsoft-antispam-message-info: +/I3pC3nk45CpUo0mCrROtgQCsKcmbMsUZ+BgB2LoYDk6qFUAecRSoJY3bC01XPXQhtNYvdE8JYBncipS5aqGG1oYjP1XSM7NQRrUWIULZ7lJ4ZzJKntDjVlHn9kKMqEFoiCGQzGWcyO/EBWpuEx4UbVcW7k++kVfYj1Aq+15Cdw4oLIj2eDLum/rVIuaEIil0UsR5jQ+xmFFHoYlY8G22fiyqF9MldUlxXoKlTVKD1dINdTZ8ifZaxsEuah8/w6s9hQVi2kond5i7TVm0InQSgslm32iZPIt+8yyhJoUCUe5oKH55sJFexwk9VXLGu8KfsL8dJ1ltGT3h+mGIRsFoY5Rr2E9BBj8mgVWh/jPX+km0sBk9EptPrXfcftbwQ5rmlUj4phvSN1x1grnoYQeNJr92desEtVyjmgbdBXCixcvi5M2g8j8OTRBFkBQ9mWSAaOkE29/cLufwc3c5PTTBHgFLiEOQzKtuAxzfIWtHP0bSZ/My/k6Unx+k/X60hQnznnLAWhXmgKiL+F5Nef3ROte+vyVr9TB5FTIX2YtUjkrLnc45V9nJiL0lyJjjmVQsUYvSCvhoRdahYJ4C7o+TQlG/GjGJqEjUpdicV36R+wWMTXUJjHDTftUr9Xl/8tqY7w0KDNb1OD0Fu7QqrZ0wbNyuV0fsq+vj4bSP+VLUUx64GFXIClc5f61IxRzq5oOj3aEHNv6CCzoTFE5Ga5YZ8rlGBV/zGywduznxku/nuQuihBCdv5Rpp5KsWKMQ4q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dW1TWThLUEZlRDYxWm5TVTRsUW1SMml2MGRYbUNTV1d4MVlUL2lib3dPMTBk?=
 =?utf-8?B?aloweFM4anR6KzRVbFkwMlc5Qnh6M2NCTjZJSmZqR2RMdStpK1hycHVFZ2NY?=
 =?utf-8?B?V2NoanA2SFRUZjdhZ3FCdEhwOTNjcWtzbzkvOGxSSFBWc1FuTFU0V1VGQUJy?=
 =?utf-8?B?UG4yK2Fqc2ljWmhpeDVyYU1TQkxzYytJa1lUQmxmMEZ4ZVZnS09oTW1yTTBj?=
 =?utf-8?B?UnJjM0FRWTFvbkg5a3FGcmtyNVB2a2U0cVJpaC9vMFJmM09wemlwWVpoeHlP?=
 =?utf-8?B?K0VrdUFtN3BmRFh3dDV2MVhWcjhyRGxOQjlrbGozNTE1UFFuSWZoaWxCOEVO?=
 =?utf-8?B?c2RoU3Y5aFl0UWk1dklCL0tpZmFjSVM2Yy80VlNFb2l6eWFsVmdCUzlRaFNW?=
 =?utf-8?B?d2NZRlV5elNoaGczUDEvbS9nYVd5ODdjN2FubE14YnN1WFM0WjJsUjBvS3VJ?=
 =?utf-8?B?SllnZmlVSTVPbERyZVNpUUVZTUpXZFY4Z3lYZzYxbWtLTk9uQ200aENYSE51?=
 =?utf-8?B?eUwzeEwzY1VvWUk5L005aXZ3UWNndjNWZ1RXTDZyZ09KOW9xOHF2S29MMlZq?=
 =?utf-8?B?MDdFWEpjOXdSMkF1YVBDMmlBSG8zcFF6SE9nQUdEWkNiUGZNRjBLM1dLTkVn?=
 =?utf-8?B?RS9jQVFGNGRuT3pRdzBqK0tsajJRWUxydkRYR1p2S0k3K1p6cUoyWlhZS3JK?=
 =?utf-8?B?czFSVkU5Wk5CdmwzcEdQVmdmOXdkTUNGMS80ZitFMThVWnNKa3NGd0JSa25E?=
 =?utf-8?B?aEJyTjJ3ZGV3RVBnK3ZpTExMU0ZTSG92azA3TXhOVVU2YzFrV2hUYURIVjVr?=
 =?utf-8?B?bmM3Q2NNRGRINTJzU0wzdEtlTGlSekhueG1LSVFhblRZUW9JZDUrcyt2aFly?=
 =?utf-8?B?QmlMVkt0M0RkUWUyRFdmYnprRGRnM2pHN2JTeHU3cktGb1lhZ0xSd1gwZ0hH?=
 =?utf-8?B?blArM0JBSFBnMUdmTVhYL3prRlJyREJwTTF6K2dMa0dkVWNmWmJiOUtWMXBo?=
 =?utf-8?B?RkcvckpFdFRCZWNBNzdWclh2MzZybXpkdStyK2JiRzlFMEozeGpMR2I2VWRu?=
 =?utf-8?B?MW43SFV5aTZEWmI1QVNoQnVXQVJTRUZJRjdGRnVybXR3WExRWHNkcURmM09S?=
 =?utf-8?B?OU12QmpmM1JvMVIra1JZU0hUTkszY01NMWxEOTNoYXBTRDhMdkY1NGdGUm9j?=
 =?utf-8?B?WmlYQWVQdHlKNG5IMk5uUUQraDRXR1Brdm1MYlhBSy9aWkh0OXBXcGsySWF2?=
 =?utf-8?B?bnl2ZXlQc3VXNkhEMk5DZmJPSU1aTW9GdG9XU1pxc0c3K3plTnNPZUQ0cnZr?=
 =?utf-8?B?S1Uzd3A1WjlFSkRpZkRDaVdweU9PMEV3a3QzK0tNeHQ3bzhXNWVqcURHUVlk?=
 =?utf-8?B?SHd4Mm1ScEExeE5rbGlZTFBBMDVVS1pWWVcrb1hUajgxbFdqVzZUVS96SzB1?=
 =?utf-8?B?c3UxNXg2bm5hZk5JZmVBRzNwUk9uYWVwRWxxYjVaT0VjcXlMZmlNV0lDUW9V?=
 =?utf-8?B?c29rKzZHVnN1Y1FhaVlWcWR3cEhGZC9lY2lSeG1tNyt4TWVXN2REcFUrNW15?=
 =?utf-8?B?MnM5K2NIMXVOOTN6M21vVzkyRXdzamViYUhMQ1V2c2EyaG5FRUFhOW8xbkhP?=
 =?utf-8?B?dmxub091aXY0UkpBVGJ3ZXhERmVJRUkrcFRtcVczZ2JzTXpKVnJLUVF1Wmc4?=
 =?utf-8?B?NVczWWxBY1RBbWxxelhTTDBIeGZpdThGVitKdlFGSkI1US9GRzlXQ0FPUDZT?=
 =?utf-8?B?L1E1eUJyNDlSaXFsSERGWWVaVHFtU0xtWjBZM0NlV1A5d2g2aG9iWjBvczdS?=
 =?utf-8?B?S3MvNklJL0d6Yzh1UWwyeHRLVkFyVUttSDNwMU1DdzArbFNESGFHa1N6aEdn?=
 =?utf-8?B?UzdKM3VLSUNKQXZ3QUhhTWRGTjE2R3JTZ0J3TFBVUnpKR0tMQ2ZLQWFHa013?=
 =?utf-8?B?bzRYNC9TVjNTSG9lRHFMaHBkcGpJTndOYWR1bWx0ZndOWnh6VVJSSlYwcDRM?=
 =?utf-8?B?Qm1PWUJDQkFkeXV2K1BwUHdHOHd1ZnRsNWJDczdLaXJYUUhUWmxhTnlPdTJB?=
 =?utf-8?B?d0hFbGlqQUVUQWtLODZ1S0tuWUo1V0FSUzUwQjlia2RkUGxpcmlFdVduakZs?=
 =?utf-8?B?SEFmUmszMmdvWEpBUmxXK1l4bnNyYzZPVEQrV3hHeEdyNmR0VEpKMEt2OGRl?=
 =?utf-8?B?YVIrVnROUTFjZjFCVHptdlo5djBrcDZPVmhyb0xVYVczRENTV0ZlSXRUYnl6?=
 =?utf-8?B?OEsxS1FZMTZvdnNCTXU3dGFPRncxQVRTT0U4UGdydGo0RkJDd2RZUmU0RHhr?=
 =?utf-8?B?Q0Rsak85Y0xrcEtUcUJTLy9TRE5lNCtENFZxck00SEJUUUp4dUJTWVRya2xk?=
 =?utf-8?Q?mcDfOUxCzSkG1zQc=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MGYY8O0eboSNC9EP58MeIOiWk79zzbCngDx7l9uWqNP50gzHft7io2B3/ACISxie+TRdzxmp+d8KKTlN7bmS/erYo8OwquLQhPKNhIBvuwGlK5iO8RDwM1RPpITeYKp2dAJLn/+CPuxnzkmaJkrsIbu4XA3ah5VKXf/R0Ko5xSotY4GDFAbWZi6tSCQxauG0dgq9RCrtWOauGaAyMjxLi52gb/lbCOBFuC5TU7ABzCfRvmF283OOu7SFcH5zoTkg6PBOl8NtTYalR7z6gvLo+dBk6x0PiaDx2zBVs3+yt4VzGFwCOeAZUy1jqb6r9El4Rt59Kssto7jHI4aPXfVTUw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e091da-9606-45e2-c5b6-08dec0510832
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 02:45:39.5460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ze7a+jf+gSVQGYMMDncy0p9lYOHDrGFbzupGfyIn0Ud5nTcdo4I7jPHz2vhdfUo9FqSIoE3YSXI6P7c1sl6xwnAmFfV+wUzMC1MYlVdk4Yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8783
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oOHHZn50frXGXkF5CzoZf1dif4Y1sFRtqZ0ozUNsNu4_1780368349
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293978-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.986];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,onsemi.com:email,onsemi.com:dkim,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 9F4F1627693
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBPbiBGcmksIE1heSAyOSwgMjAyNiBhdCAwODowNDo1NVBNICswMDAwLCBTZWx2YW1hbmkgUmFq
YWdvcGFsIHdyb3RlOg0KPiA+IEFjY29yZGluZyB0byBPUEVOIEFsbGlhbmNlIDEwQkFTRS1UMXgg
TUFDUEhZIFNlcmlhbCBJbnRlcmZhY2UgKFRDNikNCj4gPiBzcGVjaWZpY2F0aW9uLCBpbnRlcnJ1
cHQgdHlwZSBpcyBhY3RpdmUgbG93LCBsZXZlbCB0cmlnZ2VyZWQgaW50ZXJydXB0Lg0KPiA+DQo+
ID4gRml4ZXM6IGFjNDliOTUwYmVhOSAoImR0LWJpbmRpbmdzOiBuZXQ6IGFkZCBNaWNyb2NoaXAn
cyBMQU44NjVYIDEwQkFTRS1UMVMNCj4gTUFDUEhZIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBTZWx2
YW1hbmkgUmFqYWdvcGFsIDxTZWx2YW1hbmkuUmFqYWdvcGFsQG9uc2VtaS5jb20+DQo+ID4gLS0t
DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9taWNyb2NoaXAsbGFu
ODY1MC55YW1sIHwgMiArLQ0KPiA+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gSSBkb3dubG9hZGVkIGVudGlyZSB0aHJlYWQgYW5kIHNlZSBubyBw
YXRjaCAjMSwgbm8gY292ZXIgbGV0dGVyLCBubw0KPiBjaGFuZ2Vsb2cgaGVyZS4gV2hlcmUgaXMg
dGhlIHJlc3Q/DQoNCg0KU29ycnkgYWJvdXQgdGhhdC4gSSBzZW50IHdpdGggdGhlIHJlZ3VsYXIg
ZW1haWwgYXMgSSBkb24ndCBoYXZlIGFjY2VzcyB0byBTTVRQIHNlcnZlci4NCg0KVGhpcyB0aW1l
IEkgdXNlZCBiNC4gSSBiZWxpZXZlIHYzIGhhcyBldmVyeXRoaW5nIHRoYXQgaXMgZXhwZWN0ZWQv
bmVlZGVkLg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L25ldGRldmJwZi9j
b3Zlci8yMDI2MDYwMS1sZXZlbC10cmlnZ2VyLXYzLTAtZGE3M2U3MDEwNTMyQG9uc2VtaS5jb20v
DQoNCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K


