Return-Path: <netdev+bounces-296364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nALkN8ZIJmqBUQIAu9opvQ
	(envelope-from <netdev+bounces-296364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 06:44:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE9B6529FC
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 06:44:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=VdFczHm7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296364-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296364-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A65C5301038F
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 04:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B5A347503;
	Mon,  8 Jun 2026 04:44:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6531F988
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 04:44:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780893891; cv=none; b=cda/fdC/PjpYmc/FNVSdYpPhHEDiBIj9aCaPGU6GJYXayHyrpulxSdm90Q4zBpuVhUsj1C5znodGio4KXh1H64iTGbCzX5eJZzXSDzzMV1HWPFwaQMLJKcR8RyRCQ9we5e3u8N4oYXwgkDFEwF0yys3SBhJnQPp+WbY8aJIgN34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780893891; c=relaxed/simple;
	bh=Ig7v+V5DWtO0EmcifvA2fsLCbdB8R6lC1QBuX6EcoKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=j0+wlLaj3om8aP8iANtY6uNXChbClb0uulgMznvrISY4HRPFua+QpdYFStYDEV0aOsbwUBFxKAruUl2loN4TrmRm+dTopdzY+fPmDBwYo4abVB4v0YW+dUn1AwIqztCCN3GacoDkB1qHvme5VZWp1xOIenppbp90Z4IasG0OuFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=VdFczHm7; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780893889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ig7v+V5DWtO0EmcifvA2fsLCbdB8R6lC1QBuX6EcoKw=;
	b=VdFczHm7VFbl0yt2ZHb3VPOuV+nir5kWuEYLEbLURz0m5Zw/eKF9ps7JS6/qnb4QTURA6c
	7Edw2pcCFe0NlkUdiXDHU120j/QS8J6PHDNdstA+WQokOtTWmt7dZoMaIhDv/Q7tWpcTNT
	eAgX56RyqRsa/HNmG6h1eRKweTVYkDqbXqb4IUWsSAr57/MVegVzxI3PkLRIWHAYweU4d1
	ucqaAc/yn49dw3PkTt+Kx9WlgdpkLdwdf33o1Uof/S+xv0MN+9Jx3pD8FShWB9mtUZSyRi
	PdaYzTCR7BJo34qtnB08blwWtIUXAkM43yg99ykCLNi+6FQZH4W/+6aRr0jQ6A==
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013048.outbound.protection.outlook.com
 [40.93.196.48]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-38-JeMYrSd0PsWajUuNIVtGaA-1; Sun, 07 Jun 2026 21:44:45 -0700
X-MC-Unique: JeMYrSd0PsWajUuNIVtGaA-1
X-Mimecast-MFC-AGG-ID: JeMYrSd0PsWajUuNIVtGaA_1780893881
Received: from DM4PR02MB9263.namprd02.prod.outlook.com (2603:10b6:8:105::12)
 by DSVPR02MB11914.namprd02.prod.outlook.com (2603:10b6:8:420::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 04:44:38 +0000
Received: from DM4PR02MB9263.namprd02.prod.outlook.com
 ([fe80::cce5:83d:e300:d648]) by DM4PR02MB9263.namprd02.prod.outlook.com
 ([fe80::cce5:83d:e300:d648%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 04:44:38 +0000
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
Thread-Index: AQHc8eDLvWzkHnbXI0KmrY/VvMfuDrYrecyAgAALlpCAAm25gIAAkU0wgAAYXICAAAajgIAFcz6AgAAGt5A=
Date: Mon, 8 Jun 2026 04:44:38 +0000
Message-ID: <DM4PR02MB926317F64B5A3827009B66A9831C2@DM4PR02MB9263.namprd02.prod.outlook.com>
References: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
 <20260601-level-trigger-v3-2-da73e7010532@onsemi.com>
 <20260602-rebel-snide-5036c97e410d@spud>
 <CY8PR02MB92493D2E5491AAE5416C05A283122@CY8PR02MB9249.namprd02.prod.outlook.com>
 <a5abb9b8-6ebf-4f95-a684-fc889b98acea@microchip.com>
 <CY8PR02MB9249E607ACBF3A05AB83ABF683102@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260604-swimwear-garnet-3eb092e6fda7@spud>
 <4df9882b-3426-4c36-8048-0c76d0f11c74@lunn.ch>
 <7c68173a-ebff-42cc-8519-95e8365805b5@microchip.com>
In-Reply-To: <7c68173a-ebff-42cc-8519-95e8365805b5@microchip.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR02MB9263:EE_|DSVPR02MB11914:EE_
x-ms-office365-filtering-correlation-id: e37560ea-9672-448b-2734-08dec518a5a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|18002099003|22082099003|6133799003|11063799006|4143699003|56012099006
x-microsoft-antispam-message-info: C5jnzhkjYSMlbny0SJb3S1uLJReQrTdHh6+i7GA452qe7QY7VXstToMiUG07te9ATQSXipVJKbve5ZWXUxxi+5MkoguOzPSp8HqjzeJGOovTAp780P0CpJzi8ijYPZkhCctFNm1IHpoFCUYF4wbhbqCe78XgX0geV8290TWJH2BaQ5O4ZDkEsQ9OLxmtNNQl6m3cICpL2KciBX5EEYtRJDiK0sIhURK8Id1lqiLbRk9dJrJ1LKQE491yrO150kf1F2Ju6a+TBPsnow39EoAlAfkIkGGR7n/xigxmzQtGBlD5Lk2XQdHU4yZ+2vKoQxQRUHqJIV3RutUPdKHTKLxfehtu5GOSdGyaZwbnt0M4ost1QSaRQl7pCaRX1jP3yADSc5xvk8V4oP5N3sVoyPF5ZRV47GHGRjkGkeOyZcCPUSt/U26/GLvbry6xEVCN9HnbOxIFBdoM2JNTVza3+nY5XzP2mVxg4+cJq9Bp+P635d71n4Fv9pOABJzTPi6Qsi1/llQ3aryNbM3kNr2pxir4Sx0eRE+lrSy8xBulqkq9aPMSL2DoormiSJsRmiSBhjWD8JzSeysBvpGJ16DSkyYRyQDYVAcpzFRYI34zc81pcu4bYputrPz+mnCB9tqHhppKN0Yn+f3SP8KDwbYvaBrgc3lFxwUJ9h8xJOVNX6/FRzww7spoSuT1my+g+cpr1wCBZgbW1DrNfZsU/bSOCTqCj418hUIh3sX/q30Ops0f6CNkhyw9EPmVCj82aLIR14Ce
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR02MB9263.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(18002099003)(22082099003)(6133799003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWhWaHJvaUw2dkVOc0tmcTRVUUVPdXl6WmVvRithWElxbldZRmhMY3Fmb3lW?=
 =?utf-8?B?V0tlMnowemZONTJDeHpUQllob0owcURyc3pHTk1vTExrVU1tazBhdnRqRERh?=
 =?utf-8?B?b0VjTlJUc0kyOXB4aytmWi9lK2JqTUJiVG9SV3l0Sk1yUUtrVFNDRGhQUEFV?=
 =?utf-8?B?WXZ5c0EyNXBOb2ZFNXF2OEw1TzJZN3FLeHFHTjlNYVZVY2VUQi9QNDZjNncw?=
 =?utf-8?B?cU83bUErN21PL01rNVNjd0ZvTmxrbldZcE9kQ3JuYS9wRzRqeTVRQlMyeUhF?=
 =?utf-8?B?RVF1VnJHaHVSUDA5SVZTc1FiMUhCdmswQ2VHSEpDVFJFZUtuUmt5RGd0Vk5a?=
 =?utf-8?B?NW5rZ0RtYi9vYjAyekpQRzJWWU1ncFQ3cmxDc1prUmZYTElHaWdydkcrNmdx?=
 =?utf-8?B?TitUNlc2RFlBbTJVbGtFZE5hWWdTKzYvMUtDekhkTG9CN1ErUEdUYm14TjBF?=
 =?utf-8?B?SjlVVUNiWGYyNEFtZ3dvNis3dThPck9uK3RVS1JtTWFPSk1oOVc0TWdIY05F?=
 =?utf-8?B?N21oVDg2elpRVmd0TTk2RGlLdEtOWEYvMkNVd1QxMDQwNzk0S3hJdHBycGNv?=
 =?utf-8?B?YWlDVFRxV1ZjRTcrQ0xGZnRYNUM5RzhJZ3hKSVJuLzlSMjk2UVhyekpsTUtD?=
 =?utf-8?B?UmYxVTZjTUJQdEpTK3Z6aHBUVWxvQTV5c1NuNVMxN0pjK0ZPY0NaNzNOd0Fx?=
 =?utf-8?B?RDUxOUtPMS92M1k5YzZpc2xnZzdGb01vYVFmbmRHYmNGVjNtVVZXd0VORG1B?=
 =?utf-8?B?WDMvZEswSThuQ2toM1RpOVQ3Z1JUTmhIMVZTRnhYdUN6L0xXdGRkL3FMcmxh?=
 =?utf-8?B?VTBUWFl1NG9NTFV1TUxQOS9YcEVBVVRBRzFjNVdhaW5td0VkcHQ0M1RFellT?=
 =?utf-8?B?Nk9MbWhQVmRUSFRVRERDNHVtZkdUcnVwclExNGJsbndaTkxyaUtsanU4L1Rk?=
 =?utf-8?B?KzZaRG1ZRUtZdDlFRzdCSTlITFVZc3p5UHBjOXQzOEMwcktNNHZUNjhGOG5r?=
 =?utf-8?B?WExHM0ZVZEx4UldNSXVOcWc2TjF4dHFWcUZpUzM2Zkd2ZkVqSEVUVmo2cmp3?=
 =?utf-8?B?VXFxRkM5aURsdTIvNWxGOEtsdGZDdDFKTmhQOG96N0NIc2c5clRockJjRjFQ?=
 =?utf-8?B?MXcrTHh6dXBSTVFiZW5LTm9QZUZxclNaQU5EdU0vOGVuWTliZmkrb21VaFFM?=
 =?utf-8?B?TVRNR2k5MllDRkNvMGtZTEwwVisrU2k3STN6NFpUTzNSaHJ1MkJXUFVTb1Jh?=
 =?utf-8?B?RGhvenBSWkxERzNSazk5KzZEL3F2L0VqY0lHc2pCdlcybUVLNmd0NkF3amdF?=
 =?utf-8?B?MnRSdXVlUFVxN29KNWVBeFpYSFlFUTlUUzg5QmRQU3hwV2pDajZUK3FvT2dK?=
 =?utf-8?B?OENhZkRJVllKOHhwWCtLelA5TWtHNEJQcnVZRFA1ZlEvZnZ5cWZQM1QwUHAx?=
 =?utf-8?B?L1hZZEloWW9mUVRKSkIwNkJ4NkYxNjJ1RFc2UTlHRzNwdE51KzBoczBLVEdQ?=
 =?utf-8?B?aUpYOGRycHZPWC84QUl6YnpQaXVmMzVzVVVoZjQ3QUs0T0c2c0N0WS9IY2lm?=
 =?utf-8?B?UzhQTjhucUd4QllYT2dIeWY3bHNFM1ZpdGJsOWlJVDdaWUVDOGg3cmJ6WURp?=
 =?utf-8?B?OGllMkd2VXNNRTVLWW1oM044QStkTWRCWDRsYUxpMHlVNEwxN2xTTlh4OEUr?=
 =?utf-8?B?UlNJOVEzazlyTEFMSzRvR3djSktXMFhKTWNWQzVGQTFBd0dqaCtkZVhtcEJ6?=
 =?utf-8?B?bWk0ZW5PQ2dwMXNpUHg2TG1URm9SNUVubkJma1p2VC9ZZTlSZjd3N1ZvUnh4?=
 =?utf-8?B?TzM4bEhFeERtNkxOdVFQU05XeERDbTh1TFZTOGtITytJNXgxNU8xUmlUaUxH?=
 =?utf-8?B?czNhalRTaHo1VzhkbnIvRnhnZXlNWCs4U1IyRENSamVmUk54clphMkxvMnBQ?=
 =?utf-8?B?YW41NVZsRzlOWDhlbyswVGwrZkpIQlZDL3pPZnRad3BnSE1ialJma2x6Y2xY?=
 =?utf-8?B?cjVZSU5ockZIQy9DUjZmL2hZR1NKcEFlVW9xMkVReXJ5VEpWZlpRc0hPT2RW?=
 =?utf-8?B?dDBrNis2Z090T0d0RjV6L2lHK1NidUpxSUZmRlFHZ295OGlsRzMxZ1htaE5S?=
 =?utf-8?B?NWo5emtKa1M1cWZkRXRkVXYxQi9YRkdjbXdpZ2h3bnVQUzFXQ3RTTXJDeVhS?=
 =?utf-8?B?SVdTQkJSMmIrVkE1R09HeTNVWGtaYTJpMTREU0gxSXdIYm1NSUQ2MG4wbm5j?=
 =?utf-8?B?WHpkeG1UaWpJVUtiVGdHTmVUSkdaOWk5TXUzRHV6Zi8zUUkwbXVoalNOWmwy?=
 =?utf-8?B?UEdKZXd4dEtPYkd2WDZHanhXbThyZzNvUlZFRFhWM3M2anpjY3A1bDBMV0JD?=
 =?utf-8?Q?G0OX88fY3U0gYYlU=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bPIeOA5OV+kP7jMtA0AqAh59XIlh6YRgjYcMPR3uGrXFcMzvvxyRUgPQE/Nui2p2BezVdJqAQ9O1s03ccbUmA3KBAYRVRarohxdXUkLdGkgW8yyB3fa4Et4bjqC5TpOR+NEzozvMB9Y/pjl+9AcThGIPeFmqGuY23gT23kHRDDvexUwDp2q+poiW23+YeESYfZsF2CqG+qvWZrR7+VCvbsgbrtjyLiVrj7SQadVOm6F+0vyT5fpwLN4b10GAsacTPHFGYDPh0W7C81AmffswuOrb2csc5AYRiVUCRvMGx6Nd+O1cdKMiCGoTh3KCwFrtAYrb2rOxl17dSErZNgUXtQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR02MB9263.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37560ea-9672-448b-2734-08dec518a5a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 04:44:38.1733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +yAUZL6JbdcgveIxD3NsW7xfTDcsXqAo5qnQGNMOp53kzhA2hXFgMEyItG2zEJym6tofJNoSAcJ+HgXnq8y9dv04//CVmyhJ4EhW9BZNGnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11914
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lzHDUykqi79VC60mKrNLrs5b1G-rpYovrfhrzrUVFMY_1780893881
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296364-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Parthiban.Veerasooran@microchip.com,m:andrew@lunn.ch,m:conor@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,onsemi.com:from_mime,onsemi.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FE9B6529FC

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCB2MyAyLzJdIGR0LWJpbmRpbmdzOiBuZXQ6IHVwZGF0
ZWQgaW50ZXJydXB0IHR5cGUgdG8gYmUgYWN0aXZlIGxvdywNCj4gbGV2ZWwgdHJpZ2dlcmVkDQo+
IA0KPiANCj4gVGhpcyBNZXNzYWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyDQo+IFRoaXMg
bWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4NCj4gDQo+IE9uIDA0
LzA2LzI2IDEwOjMwIHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4gPg0KPiA+IFRoYXQgaXMgdGhl
IHByb2JsZW0gd2l0aCBlZGdlIGludGVycnVwdHMgd2hlbiBsZXZlbCBzaG91bGQgYmUNCj4gPiB1
c2VkLiBUaGV5IHdvcmsgJTk5Ljkgb2YgdGhlIHRpbWUsIHNvIG1hbnkgZGV2ZWxvcGVycyBkb24n
dCBub3RpY2UNCj4gPiB0aGV5IGhhdmUgaXQgd3JvbmcuIEFuZCB0aGVuIG9uZSBkYXkgaXQgYWxs
IHN0b3BzIGJlY2F1c2UgYW4gaW50ZXJydXB0DQo+ID4gZ290IGxvc3QuDQo+IEkgYWdyZWUgd2l0
aCB0aGlzIHBvaW50LiBCdXQgc2ltcGx5IGNoYW5naW5nIHRoZSBpbnRlcnJ1cHQgdHlwZSBpbiB0
aGUNCj4gZXhpc3RpbmcgbG9naWMgaXMgbm90IHN1ZmZpY2llbnQuIExldmVs4oCRdHJpZ2dlcmVk
IGludGVycnVwdHMgcmVxdWlyZQ0KPiBjYXJlZnVsIGhhbmRsaW5nIGluIHRoZSBkcml2ZXIsIGFu
ZCB3aXRoIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIEkgYW0NCj4gb2JzZXJ2aW5nIGlzc3Vl
cyB1bmRlciBzeXN0ZW0gbG9hZCB3aGVuIHVzaW5nIGxldmVs4oCRdHJpZ2dlcmVkIElSUXMsIGFz
DQo+IGFsc28gZGlzY3Vzc2VkIGluIGFub3RoZXIgdGhyZWFkLg0KDQoNClBhcnRoaWJhbiwNCg0K
SSBhZ3JlZS4gV2hlbiB3ZSBjaGFuZ2UgdG8gbGV2ZWwgdHJpZ2dlcmVkIGludGVycnVwdCwgY3Vy
cmVudCBtZWNoYW5pc20gd29uJ3Qgd29yayBhcw0Kd2UgYXJlIG5vdCBkaXNhYmxpbmcgdGhlIGlu
dGVycnVwdCB3aGVuIHdlIGhhbmRsZSB0aGVtLg0KDQpJIGhhdmUgYSBtb2RpZmljYXRpb24gcmVh
ZHkgdGhhdCB1c2VzIHRocmVhZGVkIElSUSBtZWNoYW5pc20sIHdoaWNoIGRpc2FibGVzIGZ1cnRo
ZXIgaW50ZXJydXB0IHVudGlsIHRoZQ0KdGhyZWFkIHJldHVybnMuKHdpdGggbGV2ZWwgdHJpZ2dl
ciBjaGFuZ2VzIG9mIGNvdXJzZSkuICBNeSBzaW1wbGUgdGVzdHMgKHBpbmcgYW5kIHB0cDRsKSB3
b3JrIGZpbmUgd2l0aCB0aG9zZSANCmNoYW5nZXMgSSBhbSBnb2luZyB0byBydW4gc29tZSBoZWF2
eSB0cmFmZmljIHRlc3RzLiAgSWYgSSBmaW5kIHRoZW0gc3RhYmxlLCBJIHdpbGwgcG9zdCB0aGVt
IGluIG15IG5leHQgdjMgc3VibWlzc2lvbi4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBQYXJ0
aGliYW4gVg0KPiA+DQo+ID4gQW5kcmV3DQoNCg==


