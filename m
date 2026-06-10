Return-Path: <netdev+bounces-297724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aRZlGXV/KWrPXwMAu9opvQ
	(envelope-from <netdev+bounces-297724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:15:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6A866A9A7
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:15:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=eUQ5t03Z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297724-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297724-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B353A302B07D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F4D43D4FF;
	Wed, 10 Jun 2026 15:10:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282E143CEFD
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 15:10:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104220; cv=none; b=JdrlJmlHJ2inmK6MS5NsOMngGNI7xog0jZZqw24hLv7IAH4pode/XVuzIz2QKNrLuXKUDSW8TdzCnct2LErnsHiT3z98UXOTZQetpwUGfKPnzuX9VEHxZIGsQ2Fk3xAxSSiXD+FsaiaUfhfIsFR2UbHBbvWvGlEQSk2DLYztoEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104220; c=relaxed/simple;
	bh=CxMqc5Z8dZCP7YbevMXRl4wrFU/nva9jNTpDigvQuKk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=TefBdNgLvd8E8h7G0QTNBN5usBrqX61I+xNVRaPc0P2LD7ehHZaFZ8hcS6DuomqeAC59QyYnA+Y+yoryzXP/h1+dov0L2SBdv+PGDcKioOg3VpKhAYw7hYCgF1GmNffPY+nTCnPjiPaw4AB3xDapvirLAn5N+k/0AGL5OMCQcvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=eUQ5t03Z; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1781104218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxMqc5Z8dZCP7YbevMXRl4wrFU/nva9jNTpDigvQuKk=;
	b=eUQ5t03Z4D2mztOyhS1vA3eEV6ThsNg5SlMlj1qxlKzkkPaAvp5M5wEpY5cimwxU3xSbMw
	Wxrnm+AYxdJsafIFANV86NCgRwpOneDmQDqBqGGwr3gtEsT/3euEjrJQAKiNXbFXA5Z1AM
	8uyTryxqy7KLCgpt84w+qbQxHM77jX0FnlLvZ8WTpz/ckGb4NZXywu4DdUUDj5CtLg+iny
	8WCfxsrIFd3wC5S6PgAPfMo8kTqdRJciPqHXMquw8eltSaqhhYxY3hvH0Xi5TB3PScTRAs
	iZtEJr/eCIBVn2Il7+DNz7egtJ/Tpsy70KEclDhhpZeFAcB9lL6d5ojzOBs39g==
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013056.outbound.protection.outlook.com
 [40.93.196.56]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-10-uO4FCk0fNxa9Xtad_a6i1w-1; Wed, 10 Jun 2026 08:10:08 -0700
X-MC-Unique: uO4FCk0fNxa9Xtad_a6i1w-1
X-Mimecast-MFC-AGG-ID: uO4FCk0fNxa9Xtad_a6i1w_1781104204
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by SN7PR02MB9302.namprd02.prod.outlook.com (2603:10b6:806:34d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 15:09:59 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 15:09:59 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>
Subject: RE: [PATCH net v4 4/4] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Thread-Topic: [PATCH net v4 4/4] dt-bindings: net: updated interrupt type to
 be active low, level triggered
Thread-Index: AQHc+ElHB34YcFpMHEOx+ZpC8f1y4rY3YxQAgACCA/A=
Date: Wed, 10 Jun 2026 15:09:59 +0000
Message-ID: <CY8PR02MB924967C220439DD4D4B0F699831A2@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <20260609-level-trigger-v4-0-6f389abdd192@onsemi.com>
 <20260609-level-trigger-v4-4-6f389abdd192@onsemi.com>
 <20260610-glittering-rose-squirrel-b0ccf6@quoll>
In-Reply-To: <20260610-glittering-rose-squirrel-b0ccf6@quoll>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|SN7PR02MB9302:EE_
x-ms-office365-filtering-correlation-id: 464afc91-0c33-49cf-8fe4-08dec70256e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003|38070700021
x-microsoft-antispam-message-info: cZjqM2UBlZO1Myx/u2/OcIN78N/JeLpTTxQQrPEXTrRB8ffeECWwXu85wO+2LjQxkHI3KgBLe4RrCuvwfeIcDh99SkruNS7zKMX8kcepOfRn0TAHxZ2WbU0SmyXrIYpwCNr5tuxfM5tFNzEzU87FanElTJDUn6/jrSHsd+LTb9F0YHPCo/N0i7iKOZ0/uKC7fhlAzIgri+IOWOElporocPBnDJn+klMLyQIrYWjtSQhbERG1xssh5qvewK4ny/0vMXD3IrEO+G1Oj01lTT+TODbTSwQgoQDb1/rWokm+Xbxor+1rziBraNEx3833PnvCqdfnKscVzRYxQThuYcHDbzTTdmu9YqKd4SbjGAyHeYlegKDnZhr5pi2oVbMUZLyPuKS+t4eB5CLw7J23cRQ0AXLXJVpjSfELpGRmdZlQDlqe0VlvT81VdIrbkRTXjERjwVmbrS5uIGKoJysyoYIYTzyYEOO3yO6kaZeHThHCsdV7iYlxV2jVwtLu7AGVFJV82y2+aVljrnoNi6UcA4twnMakajOi+P35qRCe+0gaTyvdcnwcR+kJuJavarVAoX0tbrsENgLZPhbzI2brqTMem9D98cka5/WZMzB+sqfXm3DtrCCtmX4oVQJm22HGSeV3uq9esf5mvsg2/jRjlUjYWOwKHBSVbVXhCaESaiXe2HSEsrHVHld68ZlsyZfJ3RxMZeufFSWrHeEN39gF0kWCfLW/zZfKjgRpbWbCJ7agsj0sY9QV4RDsn9B+Ktv1wXdN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXcwUHdaeWZ1OEJwWElEU1Rrd2NNZmZEMzFOTjVqb2NkdCtPMno0Mi9mUW1C?=
 =?utf-8?B?UU14YlA4Z2tmRElQdVVqaE9tSzA0Tk4rdG1aTmxvdEF5bm84L1VBN3oxZTNx?=
 =?utf-8?B?a2grVE96TDVPUW9TZDNqeFhZRzZmQkc2bzBBdTNOWUtvbUo3dXpiUXlNc2JR?=
 =?utf-8?B?QzVuenoxaW5jdDF2OVRlNkI5RzU4ZCt1TmhETEgrMW9QZjRaNE9zTnprMXBZ?=
 =?utf-8?B?UDBWT0dTWmxWcGtuRFBGWXJtMHY1V3ZuSzlTcnZFc01SWnhVTHJySjNuQ1BM?=
 =?utf-8?B?ekNXcWs3T21lUXF0WVhUNHNoNm5sTjlzL01BMHR2cUNoVFdUNnl1VWsxcmRn?=
 =?utf-8?B?N2E1eTNWNTU2L0doMkV6Y2M0ZXV0ajg4RlNVOU5MYVA2aG9vRHFNT24yREpp?=
 =?utf-8?B?SVlMQjBqekhvSjhxalZoUXVPSWZTSFp3K1JBSzIyOVJDQ0R4QkZPd29qZldM?=
 =?utf-8?B?dkdJRkdBODBVeGRKRTcrd29Ed1h3Q2hha3JiblJ4NTM3VEo1UWdTTTYyQTY1?=
 =?utf-8?B?TzRITEI1cGFqbDJ0bUNEWmFIUjNYM2wrWmRMOTFpeVQzNG95cjdRV28zbkxp?=
 =?utf-8?B?dFhLYUR4dHpwYjZHd1BxbXd6b3JGQWxXZ081SDVkTExqWXJmeFZ3K1Zkcndi?=
 =?utf-8?B?VGdCUGZ4RWh2NmZKTXBUb3djTVJoZmdSa0JJRWI4UHFpaDBZU0EyK0d3OWZO?=
 =?utf-8?B?OHAzLzh4WDBIZHozVW5zcktjSFBpTUlaYnRnMlJhK3JRcHRtRVZ2MlYyOWJw?=
 =?utf-8?B?dWV4enNHNnFhZlZGZjhHTGhteHZSMWJBRnNOaUFuMGlObW96NnRCaTYzcHdh?=
 =?utf-8?B?VG5IRnhMN0t3OC9tS0tFaS9jSDVUQzBsZzZBVGpDZkROUCtVRFUremFXSXdD?=
 =?utf-8?B?bnBmWEtJY3pFc1A3UjRsb2FrN2VUbEZLNHErRHhtWjhFZjZldi9zZm4rVTdx?=
 =?utf-8?B?cUVRSTNSdUhLd0VxM05ycVd6VGM4R3UzRmxpbm40alhIUzY5QnVPdGd3TDBw?=
 =?utf-8?B?ejFFaFdDdVhHQnhDR0pDcDcrWHdvVHhhMG5YMTFiZ3g4bEN6K2F2dlhjR0tI?=
 =?utf-8?B?S3NoUTNFNFpBN1dkZ3BxOVpQRERJdW84Njd5VWtrNmhHcjZkc1hVWE5ZYVAw?=
 =?utf-8?B?eEZoNzZmUm04a1JSWFN4T0FYNlFaSFRxdENqNjBOQmN5VG1mRmFQdXpTSkM4?=
 =?utf-8?B?NTFFYzZjeENxeFBXckZra3ZhT1RsaVRnNUJCalAzakRjblc0UkZJaXNaUmhU?=
 =?utf-8?B?clpqU3R3TEN2U3RUUVM2a0RkcXRSeGY5TDluQlV3VDNRK1lmQVJNRUlGY1Z1?=
 =?utf-8?B?K2h4WVdpVXYrcGUwYk9PN3JlbzlGdlV0bmdqYzBwd0xQSXRwcUhUTUtqcG9z?=
 =?utf-8?B?cWttOTUyQWNLWmxVVnpOQTMzaUJ6dlcwL1V4d0h1YUdwQ1VSTlIyNWZqazJR?=
 =?utf-8?B?TDhBQmpEeVJPVkNqL1NCb3FSSVdXSmdTZmJSdjRENElHMmRMalhRUStqMTNm?=
 =?utf-8?B?cEh6aDkzZWQ0NFNHWFI0bFBOeE85YjNxZ3pIR0hYUWhxZGtyNzBPTklHVjRy?=
 =?utf-8?B?ZGthK1pwRE1panB2U2Z6MFZuSldESXA5TmpOUFNKWDNwN010TmpPNkpiL3Jx?=
 =?utf-8?B?Q29vQ3h0Mzc0Z3RMUW9ha0plVHlMblRTalE2eEx5V2xyeWQ5ZnVsaHBBeUU2?=
 =?utf-8?B?K0p1aWZIWDQraVVCejVZdVhCNFAvSHBrbnNtR2xSdUt4SzZhRU1COHRQTzVa?=
 =?utf-8?B?OVJzQlVIbFQ3UDBCblRRVXQ4bjlnRTRUNDRkNEhvNE1zL3pWcFNLYkFTTHpJ?=
 =?utf-8?B?eklSVk1RYnoxTmZZa0pjenV5bXh2Y2tRdkQrV3dxNVJ0bUp4M1FrTldtckFD?=
 =?utf-8?B?MGEzaGg1OXBBMVhlS3ZLbXhwT21zTFhjTFl2S3laTEVwSE9NNkU5T2pxcFBV?=
 =?utf-8?B?M2IrMTFocDlySHlUN2ZObGtBdDBoWk9pMFdhWFdLZGhpaDhFb0dCaFplUktY?=
 =?utf-8?B?R0JmZytnN1E0YnBGN2tOTTBEUTJPbHc2T3ROSFhmNncrY2t2cmNhRjd6S0tS?=
 =?utf-8?B?TE5GdU1KbEszY28yazFva3RkNlBscHF0c0xwSWtteVRMRnZJZWk1bXRuSVdI?=
 =?utf-8?B?UDlDTERFWmMzSDhaWVpaSWpjdHk0TlRmeVZKaHFnUUhWV0JGeFp3YkpqQmNm?=
 =?utf-8?B?WEFMVlFTbnFMZWJwNDhqQ1dSeDFNQ3Q5dFgxT2VaSk8wZkp6LytXQTdtZ1VF?=
 =?utf-8?B?MEx2Z0hBVjNib3VLY0lHT2g5aXNDZU1CRUdYSDRPRzRheXBhR2pUaC80TnJu?=
 =?utf-8?B?cWEzZVpGUGlJc1U4eE9DREp2Mk04T2JuNWVNbllBUW1Rbkg4eHJzZW1LQ1ox?=
 =?utf-8?Q?A7HjVo5ZiR5/UUzA=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hDYRWEzzXs5Owf4pc3fcXmFOTZjgpTzxDcyWy29x8ccCgniK5xtkw+ZCWNJGfSkozEWVvnSHGPRjBK/36aHUcJ4aD+j4QhK3nyu3u+21P53YsGbp8rz/ihtzEPAeFYya0UcUizWpc4uGDEflwQIJNuMngh+5KA/TNHpdNvs3rbL1xDnn49CPi/Q852Fl3UKv7aiyhPLiWy0d15wii+F9zDDIRcmECPX8GLB138sfy+z8rkN+6Ot6afhICFRW0qMR+shFdzMFHP0cR7RcEoGsc+IVsUCXoCKRXExpazeo589p1T+rgrk+IwLrnm0l/0pKYOZpRHhT/DHXUAqR92s6fg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464afc91-0c33-49cf-8fe4-08dec70256e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 15:09:59.4695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CphGw7tJJlagszfosBBYXG5I6lfcZWFAXT2GflzXwAiRWk2nWTsO0lCz4A2rQYVWBZAxim3H1mIry/KoxvJZVP3PSmZn2AUcyGJp+xm9qA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR02MB9302
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EEIFcv9Wcg9jaXkZi_jqCtm83siGffDrThQ-La8wgiQ_1781104204
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297724-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:conor.dooley@microchip.com,m:devicetree@vger.kernel.org,m:Pier.Beruto@onsemi.com,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,onsemi.com:dkim,onsemi.com:email,onsemi.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E6A866A9A7

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCB2NCA0LzRdIGR0LWJpbmRpbmdzOiBuZXQ6IHVwZGF0
ZWQgaW50ZXJydXB0IHR5cGUgdG8gYmUgYWN0aXZlIGxvdywNCj4gbGV2ZWwgdHJpZ2dlcmVkDQo+
IA0KPiBPbiBUdWUsIEp1biAwOSwgMjAyNiBhdCAxMjo1MDoyN1BNIC0wNzAwLCBTZWx2YW1hbmkg
UmFqYWdvcGFsIHdyb3RlOg0KPiA+IEFjY29yZGluZyB0byBPUEVOIEFsbGlhbmNlIDEwQkFTRS1U
MXggTUFDUEhZIFNlcmlhbCBJbnRlcmZhY2UgKFRDNikNCj4gPiBzcGVjaWZpY2F0aW9uLCBpbnRl
cnJ1cHQgdHlwZSBpcyBhY3RpdmUgbG93LCBsZXZlbCB0cmlnZ2VyZWQgaW50ZXJydXB0Lg0KPiA+
DQo+ID4gRml4ZXM6IGFjNDliOTUwYmVhOSAoImR0LWJpbmRpbmdzOiBuZXQ6IGFkZCBNaWNyb2No
aXAncyBMQU44NjVYIDEwQkFTRS1UMVMNCj4gTUFDUEhZIikNCj4gDQo+IFRoaXMgdG8gYmUgYSBm
aXgsIHlvdSB3b3VsZCBuZWVkIHRvIGRlc2NyaWJlIHRoZSBpc3N1ZSwgZS5nLiBpbXBhY3QuIEkN
Cj4gYWxyZWFkeSBhc2tlZCBsYXN0IHRpbWUgYW5kIGNvbW1pdCBtc2cgZGlkIG5vdCBpbXByb3Zl
Lg0KDQoNCkhhdmUgYWRkZWQgc29tZSBkZXRhaWxzIGluIHRoZSBzb3VyY2UgY2hhbmdlLiBJIHNo
b3VsZCBoYXZlIGFkZGVkIGhlcmUgdG9vLiBJIHdpbGwgYWRkIGhlcmUgaW4gdGhlIG5leHQgc3Vi
bWlzc2lvbi4gDQoNCg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBTZWx2YW1hbmkgUmFqYWdvcGFs
IDxTZWx2YW1hbmkuUmFqYWdvcGFsQG9uc2VtaS5jb20+DQo+ID4NCj4gDQo+IE1lc3NlZCBwYXRj
aCAtIG1pc3Npbmcgc2VwYXJhdG9yLg0KDQoNCkkgZGlkbid0IGtub3csIHRoZXJlZm9yZSBkaWRu
J3QgcmVhbGl6ZS4gV2lsbCBhZGQgaW4gdGhlIG5leHQgc3VibWlzc2lvbi4NCg0KDQo+IA0KPiA+
IGNoYW5nZXMgaW4gdjQ6DQo+ID4gbm8gY2hhbmdlDQo+ID4gY2hhbmdlcyBpbiB2Mw0KPiA+IGlu
dGVycnVwdHMgZW50cnkgY2hhbmdlZCB0byBsZXZlbCB0cmlnZ2VyZWQgZnJvbSBlZGdlIHRyaWdn
ZXJlZA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K


