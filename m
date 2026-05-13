Return-Path: <netdev+bounces-287752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO1AIPgOBWrcRwIAu9opvQ
	(envelope-from <netdev+bounces-287752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:53:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D87C753C25F
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0A8D3016923
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 23:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60263CD8B9;
	Wed, 13 May 2026 23:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="A2t5Qm36"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D873CC327
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778716405; cv=none; b=Ml13rqIcj/SnGVCMz5ARt8MnMh/12lfqslpLl5o4wsEWPn0JtLMliJr119m7AS4/iFRNMrkI+fBuqjDLP6WC25gmrYgaHisM5QvSl5vDJjEFwPWtygKVbmdJtwpouH1XQLNxO+GnKqrVQehEsQzAOsNX91sGHlzZwHusYVY+qOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778716405; c=relaxed/simple;
	bh=fxMxXQIw8ZjQ8EPb898K7EZvtKPcOGrgDojoAMlGPQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=g9jZLo7652pBgImhTPNFBEmB1A4zsqE7au+VOcKqwIhpgAOHBQ8CAzaUKcARLZ+vr+N5ccXHgHgWhwn5ckHTTLvIVeqdl0ap/E41HjNitsmvwqpQezKbCKzsfD2QS1rc9pm4+4/yDddJRm4YZyF+L8KUZBNKu9axFlfr5c1trwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=A2t5Qm36; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778716397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxMxXQIw8ZjQ8EPb898K7EZvtKPcOGrgDojoAMlGPQk=;
	b=A2t5Qm36I4y0GkiJIw4gfKNx+b95EkHBNdLNywUOWCF3EvWXNoi9Uda4DVRQ5pvZ7vCpVh
	bh6zLD055+nkk/Z9FtBGumP16RKksuRSylvcy6X+/RzcEydTeSG+IndW5jKR4MgxlhddUq
	179nk/kYyAMD3oLE4MYzxq1GX6+dbWkdGIHNJ6k89hwjxDmNDBvICn7p9IonplnsTh9xNN
	Q1oOBDnRTJFj4vYDbe5G3yB3aesVvzGZH5yvQOHX0iE/wmKXUenxGFnHy+CdUmX8DPUgfL
	jDbAPLXYXqgPSMyhbELYIiBZEFi92uhZ9o0fbFIAHQaYURyEQt5LRxGU0jWNHg==
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012037.outbound.protection.outlook.com
 [40.93.195.37]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-4-t3hZaYVMNW-RwQyAXEBMrA-1; Wed, 13 May 2026 16:53:15 -0700
X-MC-Unique: t3hZaYVMNW-RwQyAXEBMrA-1
X-Mimecast-MFC-AGG-ID: t3hZaYVMNW-RwQyAXEBMrA_1778716391
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by LV3PR02MB10127.namprd02.prod.outlook.com (2603:10b6:408:1a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 23:53:08 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 23:53:07 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 1/9] dt-bindings: net: add onsemi's S2500
 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next v2 1/9] dt-bindings: net: add onsemi's S2500
 10BASE-T1S MACPHY
Thread-Index: AdzhcEqKHy9WMaaoSHKX00ujMX5pNgACjxcAAFv2XRAAAydUAAAPAmlA
Date: Wed, 13 May 2026 23:53:07 +0000
Message-ID: <CY8PR02MB9249D14ADE162A6854C72B9783062@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB924920C8825C7AE5D22EFA4483382@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20542d76-6f70-4c2d-9fef-0de620a8d6d1@lunn.ch>
 <CY8PR02MB924974BBC348DE4814DA3C7C83062@CY8PR02MB9249.namprd02.prod.outlook.com>
 <3c5aa072-9107-440c-820f-3f63aa3ac3e9@lunn.ch>
In-Reply-To: <3c5aa072-9107-440c-820f-3f63aa3ac3e9@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|LV3PR02MB10127:EE_
x-ms-office365-filtering-correlation-id: 303db9e0-04d4-4850-c1b2-08deb14ac84d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|4143699003|22082099003|18002099003|56012099003|11063799003|3023799003
x-microsoft-antispam-message-info: ysUX5IwqtXWtvzqLfA1QDoQMHKzhW8BCh8RFZ0qB4mPOCHn43JKvV21PTjdmDPZP6FPy2aL38kF2zuNp+H+xhOcniWcXZVLc45QcWDkqv7tGg5fO3pLoexlqRVGlBkwN6v9hKolKn1Ajvw7h1SIL19LOWL5gsDmOw8GZbmuVXyThina4eQxX/+2fk/TQzTEV3HAlvlqpwkxEKU6LvydfLq+5H4ONsqwvP3/x/wpb6xMkUdODbgzPiQymIh1Nl7pLnfhwgk12rwh0wqc/aNEt889VsT2S8qTDiWtMgc7+e4ZX1a84Z034mC3+pZz29+6CdBX/Kgb27B1Zg1asf7DRn30SgMAnHwsr13FLig9fVU5I2nosV76yynxf2ixlfTtxsKnmdSrD5Q4OMdkKQAfQDz2xFo/dXlGOI/WWNEa0bGmur3oe98m3oDuX7ryR5kzI9yxRj/DNasW0oTdwRsBR97uEucinKbIdM9WhlA5YAhr64C3PD33ORPOwdaEBMLZMsAF81kDyg9PhOLRrqWRi2iNk+HQPlN5climonLwERhIQiCPtgl0MR4zqYKu5pB49f1AxYmI1q2KwQzAHv+Ysdo9h/1yXPUdwzTTLfYE003/1DcnXX2RcDG894tBv52eETmZBzukqGzCX/baQScGG/FWog+hgaataHsK6jzJtlHqU1tpsQ8byZoelbiv2WJ7BOWQIS2NkDfh06+mo633EqPP8ZaPYw61fDkpGIDxgsXtNhw1v+HvrSmD5NSDw3+9A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(4143699003)(22082099003)(18002099003)(56012099003)(11063799003)(3023799003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXl6Mnd6K0tLQitDOWtTd3NzeVoremxXQTg0elU0RVFUaVhmbFVTQjZod2Rq?=
 =?utf-8?B?UjA0dkU4dFpFRWloMGRwb25WTVpRVCtsc05lU0lMekRMQTJScVgydXdNOXRa?=
 =?utf-8?B?ZUVMbS9pZXpxTWNMcGd0NWNTbG11QjE5RTN1Z3k0cGxVRnR5MlBLdTBOWldI?=
 =?utf-8?B?OVFiZzBkRVppWFFNb21EMjdsNDBYTTVJTUlGQTh0TmkvL2tWY2RQZzJPa0Fj?=
 =?utf-8?B?bFZQUHFZaFNITE5CRWsxcXJiU2d1YnplQklMWjRvNUNKNStJSDBBYWUrdkRi?=
 =?utf-8?B?YU9WY3pKa09vMVVDa05JODZ2VU4xRHJUVUtQK2NFWS9saVZtbmRBMGU5OTlk?=
 =?utf-8?B?Sm1qSmRMRUtUaEw3M1kzUGYzd1FidmQ4YnR2L0dqVGtBSEc5OExPZVNTTDdz?=
 =?utf-8?B?ZUNoSXhBUHlsYUxRU1Vnd0xFSDJocEE0OVpTOWpjSnVSUHcvWmVyMWgyMWVz?=
 =?utf-8?B?NnhVVlVvbG9zcDR4MXQ4OHM0dEZ2MThCdGhOaVZUZWpvYXZITk1xSEhkY0VF?=
 =?utf-8?B?U21VVkk1NkRJVTZMNDlkVGk1RUZ5ZW4wYVkxcVcyQUFUYWQvbkxLZFJNQmVl?=
 =?utf-8?B?dnlXVGhpTmQzTjgwMHF1VXUvRDMvaE5VSTF5YnQwUTg1ZG93WFVoMGYwNlFR?=
 =?utf-8?B?LzZQbDZlSG45UDF4MjZHcHovOHFDanBwQmRGZTYvQWJQTDRvcThsVVZlL0Vy?=
 =?utf-8?B?N1Y0YWVkZUw1OW1EdGc1cnkzVXZWbER3bmNyekVVY2c3Ry9seDFGQ1hmeS95?=
 =?utf-8?B?cGp2anEzS1FSODBLNGtrZ1lXRFNuVFEzbUl0ZFRSKzBOTTZqZDBvU25SZGMr?=
 =?utf-8?B?dHJRSUZQOEtjNEV3S0NJcnlsNHZxYlYyaDRNRCtTYVlJQURYZVBRbWUwWkJY?=
 =?utf-8?B?SkZOa0VVQ005VUZnQTFFU055aTdwWWczTTZEQ2tJRzRxVTFPVlV6bmtvQVQw?=
 =?utf-8?B?dkcvZitPWnFIdlBCQ0JRMzh6clBiQ2liQm11T2hyNEh6cFhXa1BnejU5Y09G?=
 =?utf-8?B?NlE1c21kWUNRNHduMnhveHViRmFpWFpEN2VqN3dZRWhRUEJ4L2pkemJDb0VD?=
 =?utf-8?B?L0pybEpxQUhabS9ONWhhUUxFdlNmd0JwbGJLY2dUdlVhOWVJa290N1NSN1ZR?=
 =?utf-8?B?cEpkbXFCU0ErVHN2bU9tZFplNkd6TUtoZjFxM1k5elV5eU9RODZtT3YzZWd1?=
 =?utf-8?B?ZHVIQUQzQlhFUHcyWE9EQUMvcVRHLy9kaGE2ODRXZmNuSXJLYUhmYk15QldR?=
 =?utf-8?B?aUpXY053cU9wckFJajJvUC9kMTdUQm9tci9rM3kraUZ4MGJVb1RkOHpwamMr?=
 =?utf-8?B?d2dTNWdvQWRBVUVKS1RCVkNCdmZWWDR4b2c4dk11Q2JWY3B0b2ZYYmdydnov?=
 =?utf-8?B?V1Y4TkIxdU1sSHp2eDQyQlJZeW8yVzdibWtuazZRRnN0cmRvMnZFS2crcnk3?=
 =?utf-8?B?Z1c3emljZFVldXROeE1zemthbll1YWVQeDFHTmd0ZWRZcFlzc0hYNG0xMCt2?=
 =?utf-8?B?K0tzTkM5bGZzNDBpcFpQcGtGcHhxbURxV0NCbmlvc21DNlVrVmdnYUpoSisz?=
 =?utf-8?B?Rlpka2FFbTdTaW85aGhUYWswOElTRUNlc0ZERitmNHUyd0swNDhUZHBHOHBG?=
 =?utf-8?B?VGlndDZKZFNpWEVxdmdvL2JEYjFPMWNjZkdUTkxpUUtaWXc0dk5JTnorSlVr?=
 =?utf-8?B?S0JmaEF5UnRtSE1tclJXRWlUaVpRSWc1N3BRdmM5eGVoZy8yaVpFVk1sdEhV?=
 =?utf-8?B?VjY1MmU4OTVQNVN5SThhbVV4VFFxZE5hT2N6V1FwVFpUdVlVbFFlTzZhZm4r?=
 =?utf-8?B?M3lJUitzSUlVa0oxRlY4UjBhclgxS3hoN256NnVXUklIMW9HeEtabUlZTWVy?=
 =?utf-8?B?U0s1Q2JRYTM2R1VUQ2kvbkRwMkVVaE94REwvUlY2QW1YZU84Nk50YWZaRVZh?=
 =?utf-8?B?UnJwQWZDTjBXMFRlcGNoZkpGN1A0U3g4MzFReGZDQzFTc3JsaDV6M0NnQ2RK?=
 =?utf-8?B?TjRFL0haWXpDNlB4VnU4ckkwcGlwWDFva3FNTzZ6VHlWeVF4aEJZeFVQUVNH?=
 =?utf-8?B?UmtKVmp3YzlDcFZteUY1THBjdi9hVENGMHNXS0NmdjF4Q2d4YldTaE1Jc3lQ?=
 =?utf-8?B?UjFJMVJSSjVab0RkcnlBMUdoOGdOTGp3UFJVRlVXUm44Wi9rZ0pKOGtoekRw?=
 =?utf-8?B?a3hVYlFOZUZYZlkzWTRiMFUrWk9wYzZ1ZnFTQ3hFbzB3ajZjeGkwNVJSTUVj?=
 =?utf-8?B?cGk5YUNRRGZ5NmZTU21YZmNMWHNrSzZCdTJNdTI3SnZNYzJXZTVwTzYvWHJV?=
 =?utf-8?B?U2Zxb0pQMndqNThvRG5kV282Z050RUlpeENzMWJ4alhhWjFrdGhySVV3b29R?=
 =?utf-8?Q?3p0ggWFWU4xO3tp8=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kcwk2Kgdprv+SM343B8CTmPorLRjZSML1CRlmmTknJEvVwCSCtcxXFwADpSun7/Q/eYMV60VTkvfL/Dn7iPcJ5k/kAxwBWlt4+RDdwYCua2ckCq7LSEqILd+1wLgeYlNwd7fXdvd8PuqTYIreZpf7XGdDqRO8eeErYp1SaREvKsh9deiDVbMP+XsuzxiWm5JvGzBl5rxXhJVwHbHgC1lamud1oo8jhWAxNvJnJfgdYuxPdXepKo8vR1McvCqvmEG0SKJUAfmPy8jF1t4J25FPko7LsJqm+fEmisAx2llcyhf3aJkqVr047S74XphuelMrPV2CyC6YeeAj7Yw73heqg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303db9e0-04d4-4850-c1b2-08deb14ac84d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 23:53:07.9057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lf88bT5Wif/4nrU7z0XbjcNGiXN6Srq+W9qVLTMi2Tsi23/j9S5PFVV3Uu3sOA1LDZqiygBN4W4kLFUXzJdeLmHSo4EpziRA787l4Fofhi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10127
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QtAYry2ZBb4IVdTzS26CV38iK-YlObBDzPGUxQhyQEk_1778716391
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: D87C753C25F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287752-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.963];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

DQo+ID4gSSBiZWxpZXZlIHRoaXMgd2lsbCBhZmZlY3QgdGhlIHBhcmFtZXRlcnMgcGFzc2VkIHRv
IHJlcXVlc3RfaXJxIGluIG9hX3RjNi5jLiBBdCBwcmVzZW50LA0KPiBJUlFGX1RSSUdHRVJfRkFM
TElORyBpcyB1c2VkLiBJdCBoYXMgdG8gYmUgY2hhbmdlZCB0byBJUlFGX1RSSUdHRVJfTE9XLg0K
PiA+IEJUVywgSSBkaWQgdGVzdCB3aXRoIHRoaXMgY29uZmlndXJhdGlvbi4gQm90aCBlZGdlIHRy
aWdnZXJlZCBhbmQgYWN0aXZlIGxvdywgbGV2ZWwNCj4gdHJpZ2dlcmVkIHNlZW0gdG8gd29yaywg
dGhvdWdoIHRlY2huaWNhbGx5IGl0IGlzIHN1cHBvc2VkIHRvIGJlIGxldmVsIHRyaWdnZXJlZC4N
Cj4gPg0KPiA+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBJIHNob3VsZCBzdWJtaXQgdGhpcyBw
YXJ0aWN1bGFyIGNoYW5nZSB0byBvYV90YzYsIHRvIG5ldCwgbm90DQo+IG5ldC1uZXh0IGFzIGl0
IGZhbGxzIHVuZGVyIGJ1ZyBmaXguIENhbiB5b3UgY29uZmlybT8NCj4gDQo+IFllcywgdGhpcyBp
cyBhIGJ1Zy4gUGxlYXNlIHN1Ym1pdCBpdCB0byBuZXQsIGFuZCBpbmNsdWRlIGEgRml4ZXM6IHRh
Zy4NCg0KQW5kcmV3LA0KDQpJIGFtIHByZXBhcmluZyB0aGUgcGF0Y2ggZm9yIHRoaXMgaXNzdWUu
DQoNCldvbmRlcmluZyB3aG8gd291bGQgZml4IHRoaXMgaW4gdGhlIFlBTUwgZmlsZT8gVGhlIG1h
aW50YWluZXJzIGZyb20gdGhlIHJlc3BlY3RpdmUgdmVuZG9ycyA/IFRoZSBzcGVjaWZpYyBmaWxl
IGluIHF1ZXN0aW9uIGlzLCBtaWNyb2NoaXAsbGFuODY1MC55YW1sLg0KDQo+IA0KPiBBbmRyZXcN
Cg0K


