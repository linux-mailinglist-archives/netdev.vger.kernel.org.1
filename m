Return-Path: <netdev+bounces-291236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Dq1EtLfE2qzGwcAu9opvQ
	(envelope-from <netdev+bounces-291236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 07:36:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9635C5F2E
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 07:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA245300AED3
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 05:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4AC342524;
	Mon, 25 May 2026 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="evyB4TEc"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8CB4317D
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 05:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779687375; cv=none; b=puFXgRHSXOUGBGKijpjF/cJhLAr9ZooTM54HhUcy93QSuRJMnvummc+Aryhb7vKUv8xZDUfTxxJaoRPq/DqGZkbp6wEyj7W0oDKlEquaVdMqO1F7taDyZSf5ynImeaq5s4bxRDEKDPQpVLPg1r8/T7cpePTn02JGIK0YPv6oOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779687375; c=relaxed/simple;
	bh=4eF36SBL45L6BepRrRVC+dyMU3TI4dXo4kKV/udTuBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=YAiKPorjeFekS1iVo6Nti+mRXUxd5zvY9F0Xvi6qnUeZkPSL5ZCgcgXEO5o6N+WZ82ut71C5VjOnzrh9RbDY/AJeLjJcFjkofKWvR/c4fp83AvJhUfFX9FetTE+OJeYHvr8ifRu28XMYnFcWV3ppsm4KqMMx55vBG2+Ip54sAT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=evyB4TEc; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1779687367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4eF36SBL45L6BepRrRVC+dyMU3TI4dXo4kKV/udTuBw=;
	b=evyB4TEcGnzdGKwzQUGSr3kFrX4D/qnRyaAaqQkDCw2wL9e1w7uv9h3H8lPrEWZdo/7oKj
	D8jnlKMLIR1xgF4xPfHIAwwxU4EJrRz94fFgJD2rplLZ8bTMDSK4k/iHH8WHp6CJCuNSP+
	qr34UrlVMEol99eGS4ErRHKNfirriVMdrYWfT6uOprIFHZG9UDTGUYy7Me/WrtMhUhsrzY
	1/mEy4JmpKXgjcO4/1ucY3seGGGxW+km5Wm+l0ZJLZHqmUery05CoRCUceQKy6KuhBEjPu
	uw+SsetmchrvpFNxnPKKr2QRrskHmPVQwUndFgM8OTZv/r5I7wrKhk83LS4zGA==
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013007.outbound.protection.outlook.com
 [40.93.201.7]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-12-g-hCA1pbPXiCOJ3h2sJWfA-1; Sun, 24 May 2026 22:36:03 -0700
X-MC-Unique: g-hCA1pbPXiCOJ3h2sJWfA-1
X-Mimecast-MFC-AGG-ID: g-hCA1pbPXiCOJ3h2sJWfA_1779687360
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CH3PR02MB10246.namprd02.prod.outlook.com (2603:10b6:610:1c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 05:35:56 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 05:35:56 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 3/9] net: phy: ncn26000: Added PHY loopback
 and read/write MMD callbacks
Thread-Topic: [PATCH net-next v2 3/9] net: phy: ncn26000: Added PHY loopback
 and read/write MMD callbacks
Thread-Index: AdzhcLiQPfhdO8TWRI6R6+3XYqpw1wACu2kAAp6DiXA=
Date: Mon, 25 May 2026 05:35:55 +0000
Message-ID: <CY8PR02MB92494894582414C9D8FA1A2E830A2@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB9249CDA8F2C560FDD0F662D883382@CY8PR02MB9249.namprd02.prod.outlook.com>
 <774d54e2-235c-4685-a582-f9714132923a@lunn.ch>
In-Reply-To: <774d54e2-235c-4685-a582-f9714132923a@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CH3PR02MB10246:EE_
x-ms-office365-filtering-correlation-id: 07dcb6f5-5597-4991-ab6a-08deba1f7e5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|11063799006|6133799003|4143699003|38070700021
x-microsoft-antispam-message-info: neXNaoTX62M1Qx6l2Qu/vTb2TSMwz7BnMXMwF9AHsfdnANnTYnlITRsjGW64dINIUdPI8FAXJ54nrgVAydi+88gTvb6H3hqGj/awj/KcxkKZAC4Dtv+QzhQPt33LEDIR4faImy/uZWq6KBWPhuQ3jU/WeX2rhwsKTyLmBpj6ytMVn8TrXfB5k5od7rf3BJj7uZOGmcFCh0qi7ctVdLsCHsi2DVKSUXaUwdOsSkqUJj2Zv5ktixmRRG+NMZA1dSqZi6Wkvi4hc5zr9udUkaccFYG/rvs8HeljHS8PNy5HAYGro5oKB28KgcnogPD/qH9ddjQzWGqXX5BuUSkWKks9fczD5BEWYfRetfoL8TnpZhVC6mNVne+Jh1c+vlimP/skNhXtU6TGSm/rJ9Siks2NCey+I3U/ZiB9AosN+QieNCIsElRoYq5fmWgcq4aXABwXuCwpoVfhrJEmFm/wb6kN0dhqj8C5lSp2cbUOKvRY2tXgcg1oxr1jS+T2oYlNIGlbR8/K3nuc3hy13dAgtfOwsjSrCR2h0kXNv/XXWbiOv8OXAI1d6REePmpSv2sYH3UUCNKmY2LRBn6o1ouTWmIIT/tUOerAxMWTeDSqHsTHo4um9VPaTdznVg6ZDq1UzuTsvkpYvAGSKXcQPhhQOppIXvN61OSkbNt9pYfGREcO80B9SwNynWKBByqFN8+RVb3OZfYuYg2CwYEMZu3J138vDmhqAbzW2i9NboGeG+8yK93Ujw8Rah2aLi/MX97hu8co
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799006)(6133799003)(4143699003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3NQWkJqVWIxK2xzVnVjY0k2VlB3SjdQZDFWaXNvNG5Gd1RtODB6TnlGQWNy?=
 =?utf-8?B?cmp6N254ajk0aFRqcmxNWjg5ZWZCWTcwRjZISmo3Y2Y2NFREK3hNa1RsV1pR?=
 =?utf-8?B?bDNYSTVZVnB3WkFtRjhGVzlhV2xmZ3h1Tkl0UnJXRTcyNXB1Z3h3eTNtWngx?=
 =?utf-8?B?TEFFT2dpbmd0cnc2T0Z6M1cvNDg2VzFNQlhIS2Z0ckcwdlJaT21qM1N2dkFU?=
 =?utf-8?B?SG12SllxZytlRWppRjVDKzU3amZsKzlvbG0rK3dYeC9EcHI3UitlY0NlV3Bm?=
 =?utf-8?B?RWpFbXZRcUhSbnEyMEs2RnF2cGE4ck1rcVVpSmowTXptcFZTeVFyNGxJTE1v?=
 =?utf-8?B?WFdHWTJBaElIbUNkWFp4bDdVN2RldUR6N09UQTRPT1BIY24xSjNlY0FqdkNh?=
 =?utf-8?B?cmxoRFNKVE80U1N5dmlkbmc0NU91MnpUcTV3M0UzWDhVdVBmQnIyQ1pPWjdz?=
 =?utf-8?B?aEJNNG1Rdkd1Mzc3RldmcUdEZTBrSVdtQ2RVTUI5dnZ4aDY5QnUzMkloWDlN?=
 =?utf-8?B?RTlQRDNpSTFMcXBpNEE1aGJ2MXUxM0Fpc1N0MStKc3kvcmF0enR3anlzWFRI?=
 =?utf-8?B?bEtBSFNSYXczSzFuY2xwNDR0ZTdSU0lJbmVmNlpKOUpyTGpFQWE2WmxCSlcr?=
 =?utf-8?B?MGxQMEtzaDVyVGxpUWtNQXNDc1g3V1RzQVpBeVZzQ1dETGNSZHhZTGRNaThm?=
 =?utf-8?B?dnlSaDZiZTRaTksrUkY0QVZMM1Jpc3Y3MDF2a0N2ai8wZzljRTJ6ZTFOeTlw?=
 =?utf-8?B?WWdBSGpCTW80cFVBeWc3UmoyazJHWFJWQy9SaVZUNUxUTWNGWkRkc0pxWjdj?=
 =?utf-8?B?Z091aVpUMXQrWGlqL3BpR1ZUUUM2bkJXNmVBTVNjbzJYWkxMTHhHMTQxZm0w?=
 =?utf-8?B?T0ZSRU9qV2pjbzRYb0UzbG9ycmZmQkU4WjN1WTFRcTc0Ykt2cjgwcExaenBY?=
 =?utf-8?B?MjNIUlZnUWxpZE9uN1UzbkVZWDJRcUVraTNnUmVKNitGbklydFJESEZDL0tE?=
 =?utf-8?B?anBZMEFiSEtBeER1cEtQdlFMSGkzWXVCRlJLdUZ3ZXhNcCswQWJPZ01sZm9L?=
 =?utf-8?B?TlMzRzlhdXNRdFlQSjJJZm5tTWpZVWtuekRDTHZWNXBDUWtZUk1RcTc4ZzhH?=
 =?utf-8?B?MHpPUTIxTGRacFBRYVJtVHBxYklJS2RwblhucE5MVnRLTUpNTFlnSjV3ZWFo?=
 =?utf-8?B?ektNcWFhcnpQSVNDbjZFek5ScGVzYWJTWWhtVHcvb0UwcnRlSjQvdER6Sm1O?=
 =?utf-8?B?d2tuNDZyUU5jeGUvdnlCSTE0RlhnYkhPbTc1amhDK2tPMlhwbUJDMDdjMDM2?=
 =?utf-8?B?bXc3TU54WVplOEorWCtqZngzM0JqNlhxc1BlMnFoRG9Vc29YbVNGWUZwY2R5?=
 =?utf-8?B?TDJ6clQ5SEoyd0V3VzR2a2l1UkR5SFQ1Y214cWczOGpJWTc2OGhrcGJoSlRv?=
 =?utf-8?B?TjlSRis4eHgzUUxrclhpaWxWaGlnV09hRTF4MWVERlR1c1pMa3ZkWDNmRGRG?=
 =?utf-8?B?UWVtU0xiVHRzTllDdUZBVGk2NlRYelVDTHNrYlI3WjFOS3NEbGlRR0w0WjVW?=
 =?utf-8?B?QzV1Nm8xc0JYYzYva1BzWlZnMUtFRXNpTmdQVXRjZUVvaUdHWHBwb0NvRzZL?=
 =?utf-8?B?Rkl1emN1S3VLVW10OVV4ODlsd1hCVVVIRG5pandGOGc5eXlETVRpV0JrUml4?=
 =?utf-8?B?K0tsSUR0LzBTN3psSTJPeURQUU5rL3JNaVlWSlU5blQ2YWtVVE1YZ1FuQmk5?=
 =?utf-8?B?d3RVTGFZV2ZsZ0FuY0dDOXdGenBEZjFReVprc2o3L01XaU4vTStlekFsb3Fv?=
 =?utf-8?B?aEh1Vys0RFhSdWRIMi9RcndTZkpjNTZEUTUzSVdyT2wwNnk2aUtTRENKY2g4?=
 =?utf-8?B?aWkyVHBSQk9HWlpJdEw4UW4zblVCR01PR0RiVk4ra0pselQ5bE9aME5BbFA4?=
 =?utf-8?B?TDFVYmxtTHdjYS9lNTR6QXd6L0szdlJTRmhySExMdXFlVElseURkaFQyV2x4?=
 =?utf-8?B?ZzF2czk2YzRCRTMzdWhLN0tkdVlOK3ZYbVI0SHlQZkNkMUQ3SUp1ZEhDcE1R?=
 =?utf-8?B?N1htTnNIV2ZVdnhnZ1p6RG9mckpscnBBYVA5bnRJSTgvRDlZM0tySlRJUmVn?=
 =?utf-8?B?ak5zVmVBTTdIM3N5UGU5YTgrS0x3TW1NeXZYSlVpRHl3Q1F0dlhQOTBrd3pS?=
 =?utf-8?B?UjkzK1Q3NDdNZS9VdnNRam9KeUM1RHMydks4d01BQUJjME1yL3BneE94SEQ1?=
 =?utf-8?B?TE9DRG53S1JOY1RyLzMwQ2liM1N3S2ZTdHQwZXZDREN3NXM5RDR2UlZLZzlB?=
 =?utf-8?B?MGd2RGFFK0xhb1Q2NzVMbXM5RTNiNW0wenZ5RDJQNEtjR0E1UU8raW0zK2ZI?=
 =?utf-8?Q?Yr/l0aHIKEFOpCKo=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: alF22Ex3n0v66deKyE1sxvp9Sae+6D/xP7/N2kd39RcPkbOnAGcOQo8AJAovm+uJpOfXMIzPCDXOErtj0vttCGDMB8ppoVIo+3rpEPYzkklpGxDzuT1WU+wJIHN6PSIgIla9xInRxTZsfVsqJYsLpL2Nccjf5zupgIgKTtI3BHxtLexH4DFJIA2/+NVrmMb0HklQ83BeWI2wH4fcG/BwAllwquDnp7dyvqRGUOPd8LVSl2eiPlV/Bz+oUnbxHOMWs4aW1/bd4+qjjBfAovNBpB6SVvaZ1ouddWgSO8nvpqP1L8FRT7lvspLb35NVDt9JmzJDYTI3MBI5eaJZqkbyeg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07dcb6f5-5597-4991-ab6a-08deba1f7e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 05:35:55.9538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgGPDzpHrC0CIQP/YduQIBACK8lYWX207urxu0meONcuZmm3Wg0dMw9+jAB5UQVNRIJV3FVHNa8GNV10UNg5gn4KG7Xctot9gn/mrwCdr6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10246
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5FhJG15hRosjw2PKQblBy53-NJCfMUvFM2evmDXp9A0_1779687360
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291236-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[onsemi.com:+];
	NEURAL_HAM(-0.00)[-0.960];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: BE9635C5F2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9waHkvbmNuMjYwMDAuYyBiL2RyaXZlcnMvbmV0
L3BoeS9uY24yNjAwMC5jDQo+ID4gaW5kZXggNjhiMGU0NjQ3Li5kMzAyZTA0YzggMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9uZXQvcGh5L25jbjI2MDAwLmMNCj4gPiArKysgYi9kcml2ZXJzL25l
dC9waHkvbmNuMjYwMDAuYw0KPiA+IEBAIC0xNjIsNiArMTYyLDM5IEBAIHN0YXRpYyBpbnQgbmNu
MjYwMDBfY29uZmlnX2ludHIoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikNCj4gPiByZXR1cm4g
MDsNCj4gPiB9DQo+ID4NCj4gPiArLyogRGlyZWN0bHkgYWNjZXNzaW5nIHZpYSBDbGF1c2UgNDUg
cmVhZCBhdm9pZHMgdGhlIGV4dHJhDQo+ID4gKyAqIFNQSSBhY2Nlc3NlcyByZXF1aXJlZCBieSBp
bmRpcmVjdCBhY2Nlc3MuDQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMgaW50IG5jbjI2MDAwX3JlYWRf
bW1kKHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYsIGludCBkZXYsIHUxNiByZWcpDQo+ID4gK3sN
Cj4gPiArIHN0cnVjdCBtaWlfYnVzICpidXMgPSBwaHlkZXYtPm1kaW8uYnVzOw0KPiA+ICsgaW50
IGFkZHIgPSBwaHlkZXYtPm1kaW8uYWRkcjsNCj4gPiArDQo+ID4gKyByZXR1cm4gX19tZGlvYnVz
X2M0NV9yZWFkKGJ1cywgYWRkciwgZGV2LCByZWcpOw0KPiA+ICt9DQo+IA0KPiBUaGlzIG5lZWRz
IG1vcmUgZXhwbGFuYXRpb24uIE1heWJlIHlvdSBuZWVkIHRvIGxvb2sgaW50bw0KPiBwaHlkZXYt
PmlzX2M0NS4NCg0KQW5kZXcsDQoNCkkgc3BlbnQgc29tZSB0aW1lIHRvIHVuZGVyc3RhbmQgdGhl
IGlzX2M0NSBmbGFnLiBBcyBmYXIgYXMgSSBjYW4gc2VlLCB0aGlzIGlzIHRoZSBvbmx5IHdheS4g
U2VlIG15IHJlYXNvbnMgYmVsb3csIHRvIHNlZSBpZiBpdCBtYWtlcyBzZW5zZS4NCg0KMSkgQ3Vy
cmVudCBpbXBsZW1lbnRhdGlvbiBvZiBvYV90YzYuYyBkb2Vzbid0IGdpdmUgRFQgbm9kZSB0byBw
aHlkZXYuIFRvIGJlIHByZWNpc2UsIGRldl9vZl9ub2RlKHBoeWRldi0+bWRpby5kZXYpIHJldHVy
bnMgTlVMTC4NCiAgICBXaGF0IHRoaXMgbWVhbnMgaXMsIGV2ZW4gaWYgd2Ugc2V0IGNvbXBhdGli
bGUgc3RyaW5nIGV0aGVybmV0LXBoeS1pZWVlODAyLjMtYzQ1LCBwaHlsaWIgd29uJ3Qgc2V0IHBo
eWRldi0+aXNfYzQ1IGZsYWcuDQogICBUbyByZXNvbHZlIHRoaXMgaXNzdWUsIHdlIGhhdmUgdG8g
cmVwbGFjZSBtZGlvYnVzX3JlZ2lzdGVyIHdpdGggb2ZfbWRpb2J1c19yZWdpc3RlciBpbiBvYV90
YzYuYw0KDQoyKSBDZWNsYXJpbmcgdGhlIFBIWSBldGhlcm5ldC1waHktaWVlZTgwMi4zLWM0NSBj
b21wYXRpYmxlIGFuZCBzZXR0aW5nIHRoZSBwaHlkcnYtPmlzX2M0NSBmbGFnIGJyaW5ncyBhIG5l
dyBpc3N1ZS4gQWxsIHRoZSBjYWxscyANCiAgICAgYXJlIHJvdXRlZCB0byBjNDUgQVBJcy4gQXMg
YSByZXN1bHQsIEdlbmVyaWMgTURJTyByZWdpc3RlcnMgKGxpa2UgTURJT19ERVZJRDEgLyBNRElP
X0RFVklEMSkgd29uJ3Qgd29yayBhbmQgUEhZIHdvbid0IGJlIA0KICAgICBkZXRlY3RlZC4NCg0K
MykgU2luY2UgdHJ5aW5nIHdpdGggcGh5ZHJ2LT5pc19jNDUgc2V0LCBpcyBvdXQgb2YgcXVlc3Rp
b24sIHBoeV9yZWFkX21tZCBpcyB0aGUgb25seSB3YXkgdG8gcm91dGUgYzQ1IEFQSXMuIFRoaXMg
cmVxdWlyZXMgDQogICAgcmVhZF9tbWQgYW5kIHdyaXRlX21tZCBjYWxsYmFja3MgdG8gYmUgaW1w
bGVtZW50ZWQsIElmIG5vdCwgdGhpcyB0YWtlcyB0aGUgcGF0aCBvZiBjYWxsaW5nIG1tZF9waHlf
cmVhZCB3aGljaCBhZ2FpbiByZXF1aXJlcw0KICAgIGlzX2M0NSBmbGFnIHRvIGJlIHNldC4gT3Ro
ZXJ3aXNlLCBpdCBnb2VzIHRvIGMyMiBBUElzLCB3aGljaCByZXF1aXJlcyBpbmRpcmVjdCBhY2Nl
c3MgdGhhdCBNQUMtUEhZIGRldmljZSBkb2Vzbid0IHN1cHBvcnQuDQoNCiAgIEkgdHJpZWQgY2Fs
bGluZyBtZGlvYnVzX2M0NV9yZWFkIGluc2lkZSBwaHlkZXYtPnJlYWRfbW1kIGNhbGxiYWNrLiBJ
dCBsb2NrcyB0aGUgc3lzdGVtLiBJIGRpZG4ndCBpbnZlc3RpZ2F0ZSB0aGlzIGZ1cnRoZXIuIEFz
IGEgcmVzdWx0LA0KICAgX19tZGlvYnVzX2M0NV9yZWFkIChhbmQgX19tZGlvYnVzX2M0NV93cml0
ZSBmb3Igd3JpdGVfbW1kKSBpcyB0aGUgb25seSBjb3Vyc2Ugb2YgYWN0aW9uLCBhcyBmYXIgYXMg
SSBjYW4gdW5kZXJzdGFuZC4NCg0KDQo+IA0KPiBBbmRyZXcNCg0K


