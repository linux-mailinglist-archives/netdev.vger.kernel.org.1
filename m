Return-Path: <netdev+bounces-286776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGcGBlUeAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:22:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D985144C5
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C7D2300FB1C
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA23C47B413;
	Mon, 11 May 2026 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="LXkKaYYw"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AD136215D
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523557; cv=none; b=e5lAvGGWohZZac+e2W6fSYEHvbFK7qQi+/THNrWn04c1TDiVExNwq8eYq8x19CWk282/x3eWtLRg7i9J2nMMxgDa3xI+gLwj57z6dlmu/sMjYB9FQtznRHg/y//nvbsonwp1mmG5YZa40YS2KIdnLO/TgjSSEPNF9lElJKgrajs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523557; c=relaxed/simple;
	bh=J+lXauZAVLBMIryu1QdUJ2uZpXmcPJLFtBZEhz2VZIU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vnpa0E6no4oOKzPcomTXoqN7qjf8UhKtWheygUkPOe2D478Iefk2zuBhFFPvnlI7zmOyh2seiiUE3OiwLJubOlt5gBoS/BZ0DaFmylroRCkjFMnwUojXt1UdgV9n9OTUi9UJw7kicfBSSZJRSVD44SvjixDaQe+iA/8PiQnGFrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=LXkKaYYw; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778523549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J+lXauZAVLBMIryu1QdUJ2uZpXmcPJLFtBZEhz2VZIU=;
	b=LXkKaYYwO7piIdAjkNJ2ExVfS+t1fkaH6D/ko6sGGwJAm7nTx0e3FEqqfhSM8arzmCHm7W
	aTmNtdnqcdLNL1wn1uQC9+3QNRapZPiTh7EvHVvEJZ7TDBvoo9z7WhmmSY5/u0huYADHyn
	3nM8zoikV7vh0/5kzc8kkgx6n4IBA/yb3ncAIY5RCcq8VTKFKfrr74gm5P8tI8VgPyakJ4
	irRZvxom/dybUuFdSTMwEBwzz4e19gabCpZKecPonqva/ob6j6gAGqbwMqPCMTBe2wn1sF
	QTRcnwi5yaFS4rSMmi8fj6Czu3MeGjNn+GLDIVrmUoJxP/NgCk6LlDg/SVovqg==
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-8-478VvzzaNpuX1LTTGzZdRQ-1; Mon,
 11 May 2026 11:19:04 -0700
X-MC-Unique: 478VvzzaNpuX1LTTGzZdRQ-1
X-Mimecast-MFC-AGG-ID: 478VvzzaNpuX1LTTGzZdRQ_1778523541
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CO6PR02MB8786.namprd02.prod.outlook.com (2603:10b6:303:141::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 18:18:56 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 18:18:55 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 1/9] dt-bindings: net: add onsemi's S2500
 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next v2 1/9] dt-bindings: net: add onsemi's S2500
 10BASE-T1S MACPHY
Thread-Index: AdzhcEqKHy9WMaaoSHKX00ujMX5pNg==
Date: Mon, 11 May 2026 18:18:55 +0000
Message-ID: <CY8PR02MB924920C8825C7AE5D22EFA4483382@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CO6PR02MB8786:EE_
x-ms-office365-filtering-correlation-id: 2f46b44e-8a6b-4a4e-8fe4-08deaf89c37c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|921020|38070700021|3023799003|11063799003
x-microsoft-antispam-message-info: jLAGzh9FNL+JBe630L/lkc54zlw6+16ewQUDTidlXhN9JAlAIoYcXnW6wldeozaGfW+92ht5SXQuTu6NblkMPfV4zedtukPAUkElWKVUf4FIlTX76vovHYGYHYB2sM78D70u3JPm4cQp2MZ5/JhA96mVH40zP/R2xdds3yBjzoTEZYczpATVuNoDWWUFmVrASgzlo/kGmU+XFa+bvJyAjcVUZ7wSfTB5clV9rSVwr1EQGJj4sSImFq7WHqrdCmMg1QztZnwAkIhZ1wyJzyHQVk0v6jq8B+mcepizHbiT40+R+zDznYPW8aTPCY/XoM9d9zPgrZo0nc2yF9gtLK8WsaB62waSQrn3VkxXDY9pIM9uZAZozWgLRQ63S9EW8aStAhH1m/SVh0JOsGQd7e/xjnAc78iv22GDKf4njD6urunRlyiTZoS+x1Oxl2T6P0Ew1WjsVN2mj/FSxR/fInfmfV6YMtZt2d0tBBFVYee2TrRmnjV2NWdQChLd6FkFCHit4atQa7ABfRIq5JJX+xbvptu1RECbqMmPqKUjbsq13GeSsB3TOwUXXj7MA4rsVMq5lSsmUuDVPt7tpNBaSDAYCVtbcwRUl+KHWlZ0TEzILyr496TX0N/pHBoTh0IA+wHKk33DdJkIylMKnMVsuBedZq8bS5sFnhFo4q5BUlid4+zSTe1IGIZyMPAagQgBd7ZDdBNNyfK+7YmtVHxuFgqqiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(921020)(38070700021)(3023799003)(11063799003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDFHcDZuNnBmbWI4cldON2xmMWxyZ1FRL0UwVEdBbXA2NjR1VmV5OGxkdHFF?=
 =?utf-8?B?WGh4bzc4VGR0R1RRaEVCN0xUcjNFQng2TURib2VMenNhWGxKQndRS0xBanVS?=
 =?utf-8?B?TVhwWTltMkJGT3JtKzNMaEU3bGw4WVdvMnZUZjVROGVBNFhPcHRKQTN0cnRR?=
 =?utf-8?B?cUoxWUFreGJ6VVl6amgxWFdTa0NLOTI2bk0vQitxM202QTQ4cVplWFBEUFBO?=
 =?utf-8?B?LzNNOExaNUFMK243Q2psQXhrbE91U2dHY2NzTm4rNHRjbmpSTlY0Zmthc0dI?=
 =?utf-8?B?dU1FMi9aVVU5Q3UvN3dpUUtqL2p5NEg4cTZsMk55b3dFNGNhc2RKMHJwR0hZ?=
 =?utf-8?B?a09tWWg4QkVHemtDcjVkV0FWaDR2T0pNTG1OaEZTdHJNU1AzZWJYZ01palZr?=
 =?utf-8?B?Mm9mZWhrUHpaUk5WZVcySjJWaVAvOVd2dXFlZHdwTG8zVTgvTWs4OWZ3LzJx?=
 =?utf-8?B?UHBWSzZNUHUvQkRLS1VzcW1pQTZBUlRhbDFZa2hHenBlYWE2Sis5ZU9SR1cx?=
 =?utf-8?B?K3VoR0xybTU1cFlzUnVabklwb0hzQ3dlaFRSaWNCblEyN3E4d0FGYzcwcm5Z?=
 =?utf-8?B?OTgwRm1mZGZBbEhHMGJ1a2laYkszNXlzQThlNStrbHZWY3VGc0lFcWZXY0ZK?=
 =?utf-8?B?YVhaaE9aM3Jkc3c5ZFpHRHZEdS9SZXFwYnBBMU14MUdPL2RpWWlTUGluQUk3?=
 =?utf-8?B?SXV3bkdJNGJJaDJJUEYrMWVxK3dyQVN3aEQ3VFNMMlRHcy9xMTVrYUxwcEs1?=
 =?utf-8?B?aTl4b3F5MUxxNDZobmliSmhVMDdzMHgwVTREemtJS1Q4TkIvUXJyZlVvNm0y?=
 =?utf-8?B?aXVpb1B0ZlNyYXhkVGhDZnVyYmxBN21mTlpacGpUc0xLclBjQUVHblZlODJI?=
 =?utf-8?B?MUlUOTdsNVE5T1I3ZmtNcVFOdi9pRlhuc3R5azNoLytDYWxHVVVFK3hVcC85?=
 =?utf-8?B?UWtFWWNaY3A2WktOZ1lnLzQrUU9YSzU5cmxIMlRlQytHSU52MUxuVkZxekNS?=
 =?utf-8?B?c2I4cFhZdnpuU1k4S0haMm0rZzFnQUdkdU1XcHA1RXZFRzZmNkpsSGZFY0Rt?=
 =?utf-8?B?UGxYQTFQSjVkeU12ckhlV1hwNjZ5b2RLTHV5TEFhTnBUVFVBNGJocDlGbFpq?=
 =?utf-8?B?WDRXckwwaGRSQ3dBQ0FzQXJZMk44U2Zmb1cwT3RyRE9hRW5sWWRDUDJnaFN5?=
 =?utf-8?B?NDRjclJ0T2ZxTTBxNVlycFJISFI4UlorYkdnNnU4SnlQS1A3UUk0MlR5V3Rk?=
 =?utf-8?B?L2ZUS0IrOGRLT1AzUzFlUFNxazQwZ0hLY3d0ZC9ldDgwNkFlRTdsb2FBdlhJ?=
 =?utf-8?B?aktEcnJsSHFUcDhxZGcrdWF6YVEwQ1ZDd0xEWndTdXk0T0ZhTGxSYnEvUUtm?=
 =?utf-8?B?ZkYweGtBSHZ4TkFHL3MvdE0vMnFlbW9IcWRlKytmZG5mZHljOW5HZlJPbzIr?=
 =?utf-8?B?dmE2eDRNa2RZOE13T20wTlY5Z3VxYUdCZWpILzNKaFJsUGZqVEJodUFXRFd2?=
 =?utf-8?B?OUtPTm9MY0dzZWJhVVVVZVhlVW5wRWxlbGxUMVRKQ0owUGtPK1hCMGtjZ1dY?=
 =?utf-8?B?RUNYa0VaR21SSDUzSktKSEFieXpQUFdIdjVDK0d1dWRySnc3R3c2amk3Z3Ri?=
 =?utf-8?B?Tkh0UW8wb2RpUUtMMDF1Ni9oZ0xkQy9xZ21FSzhQejFqbHlzS1VkV01YL0w5?=
 =?utf-8?B?UUJtcDVYd2VBTmdSNHpvZHRWT0Zwd2JUL3JwU2tNbk5aNFZ4RTI2aEswWVdX?=
 =?utf-8?B?TElaU2s2Y05FMWZQOVFoYTF2Rk14ZWFYOFIwT2hKSFZSY09ZQTlrOEsrRlZr?=
 =?utf-8?B?dXpFMDRodm1Zai9Rb3NmbTBwMXNZd0JuWkZHT1dyNG5KMzk5OGZqOUFRL0U1?=
 =?utf-8?B?aVQveTF5Z2R1Z2tnbCtvNmh2MTBmMUhiOGM3SS9OUjVYVkpuNlNKUDFRb1RL?=
 =?utf-8?B?MDVnOUVsVE00TFZYQ3Q2N00rcGRxVWIxSkxzNWpJemMzMUI5WjcrNzNEQ28z?=
 =?utf-8?B?ei85aHJlSXBMZ3lJUjBINm9QdVduSE5Fc05mQ0R4R3BueElkS2svTU9zeDc5?=
 =?utf-8?B?bmsvMk94V3RnMWxFeU45WE9kd3NTMmJ6aWFBVXpmUnVpVGJGQ09HRnFSbkkw?=
 =?utf-8?B?bDVzZnpZSVR1bm83MjFWWkFzWHp0K1FpTkE3T1ZLT3YzSTc4WkdkOWdOd1JW?=
 =?utf-8?B?YkdXa0tZb1R6ZDFBZzFrR0JRWkpWWGZGT2lsa3ZIQmFIdzAvdmVBVms0dzFL?=
 =?utf-8?B?MXdzK3VyU3V0SEptY2RQekNKNVJoaGlJUTJTVzFzQWdaR0ZOY3I3T1NZRW1n?=
 =?utf-8?B?dmNYcDlobkdPQThBV3FRVkw2dHNlU0F2MTIrUXBXMTBYRkxZS3NqcUUxUTVm?=
 =?utf-8?Q?j105Z5CfEAvD6Bpw=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZMLE7X1/mNrcOy9uTVRg7/lg39bG6ZWT61A37aFa3d4HG5toxYvl9m5ryGVCrGH/D1LC3N9HyCoBhthLdFOjA8iSGrqjaabuWjdw96Sz3XyWW2p6gu23Zf83CBtfbKjR8zwYLlzuDG3WXwcTiC8jkbZaO35sMeShNn+V/PJV4QBndLiGrRFacC6nb3ImAhCq0TM8gLJwmpZGhHQx8eV53jt19ggbwsXZAIr13DobGyA7tu66jDY2DPXocqKvr1zVLwDF7CYVwuA8T/35Yn9JNeJYytPTRtVCBthFTl0Cl0etC6zMJobK4B8r8pwsNeaIOqGDAG7GE1Wz8RKJFmOBPA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f46b44e-8a6b-4a4e-8fe4-08deaf89c37c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 18:18:55.7858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/mzGzWgfB3zLRuLjuvwhTNfznrKkPnXg6xU0JS46YvAFiQSlNPG0KoB24DIXgjS7wHzUPuc9IOqlcn9wLw5Owz46n0k0kub3XyBb0k/LLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8786
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1ZZ1rD2KCHh9B8faSkMBpw72bfzqQEtiB-aQWjLBx2g_1778523541
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: 01D985144C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286776-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:email,onsemi.com:url,onsemi.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,CY8PR02MB9249.namprd02.prod.outlook.com:mid,0.0.0.0:email,devicetree.org:url]
X-Rspamd-Action: no action

QWRkIFlBTUwgZGV2aWNlIHRyZWUgYmluZGluZyBmb3IgdGhlIG9uc2VtaSBTMjUwMA0KSUVFRSA4
MDIuM2NnIGNvbXBsaWFudCBFdGhlcm5ldCB0cmFuc2NlaXZlciBkZXZpY2VzLg0KDQpTaWduZWQt
b2ZmLWJ5OiBTZWx2YW1hbmkgUmFqYWdvcGFsIDxTZWx2YW1hbmkuUmFqYWdvcGFsQG9uc2VtaS5j
b20+DQotLS0NCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvb25ubixzMjUwMC55YW1sICAg
fCA2NCArKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDY0IGluc2VydGlvbnMo
KykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L25ldC9vbm5uLHMyNTAwLnlhbWwNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9uZXQvb25ubixzMjUwMC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL25ldC9vbm5uLHMyNTAwLnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQpp
bmRleCAwMDAwMDAwMDAuLjk0YTczYjVmMw0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9vbm5uLHMyNTAwLnlhbWwNCkBAIC0wLDAgKzEs
NjQgQEANCisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0y
LUNsYXVzZSkNCislWUFNTCAxLjINCistLS0NCiskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9z
Y2hlbWFzL25ldC9vbm5uLHMyNTAwLnlhbWwjDQorJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUu
b3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQordGl0bGU6IG9uc2VtaSBTMjUwMCAxMEJB
U0UtVDFTIE1BQ1BIWSBFdGhlcm5ldCBDb250cm9sbGVycw0KKw0KK21haW50YWluZXJzOg0KKyAg
LSBQaWVyZ2lvcmdpbyBCZXJ1dG8gPFBpZXIuQmVydXRvQG9uc2VtaS5jb20+DQorICAtIFNlbHZh
IFJhamFnb3BhbCA8U2VsdmFtYW5pLlJhamFnb3BhbEBvbnNlbWkuY29tPg0KKw0KK2Rlc2NyaXB0
aW9uOg0KKyAgVGhlIFMyNTAwIGNvbWJpbmVzIGEgTWVkaWEgQWNjZXNzIENvbnRyb2xsZXIgKE1B
QykgYW5kIGFuDQorICBFdGhlcm5ldCBQSFkgdG8gZW5hYmxlIDEwQkFTReKAkVQxUyBuZXR3b3Jr
cy4gVGhlIEV0aGVybmV0IE1lZGlhIEFjY2Vzcw0KKyAgQ29udHJvbGxlciAoTUFDKSBtb2R1bGUg
aW1wbGVtZW50cyBhIDEwIE1icHMgaGFsZiBkdXBsZXggRXRoZXJuZXQgTUFDLA0KKyAgY29tcGF0
aWJsZSB3aXRoIHRoZSBJRUVFIDgwMi4zIHN0YW5kYXJkIGFuZCBhIDEwQkFTRS1UMVMgcGh5c2lj
YWwgbGF5ZXINCisgIHRyYW5zY2VpdmVyIGludGVncmF0ZWQgaW50byB0aGUgUzI1MDAuIFRoZSBj
b21tdW5pY2F0aW9uIGJldHdlZW4NCisgIHRoZSBob3N0IGFuZCB0aGUgTUFDLVBIWSBpcyBzcGVj
aWZpZWQgaW4gdGhlIE9QRU4gQWxsaWFuY2UgMTBCQVNFLVQxeA0KKyAgTUFDUEhZIFNlcmlhbCBJ
bnRlcmZhY2UgKFRDNikuDQorDQorICBTcGVjaWZpY2F0aW9ucyBhYm91dCB0aGUgUzI1MDAgY2Fu
IGJlIGZvdW5kIGF0Og0KKyAgICBodHRwczovL3d3dy5vbnNlbWkuY29tL2Rvd25sb2FkL2RhdGEt
c2hlZXQvcGRmL3QzMGhtMXRzMjUwMC1kLnBkZg0KKw0KK2FsbE9mOg0KKyAgLSAkcmVmOiAvc2No
ZW1hcy9uZXQvZXRoZXJuZXQtY29udHJvbGxlci55YW1sIw0KKyAgLSAkcmVmOiAvc2NoZW1hcy9z
cGkvc3BpLXBlcmlwaGVyYWwtcHJvcHMueWFtbCMNCisNCitwcm9wZXJ0aWVzOg0KKyAgY29tcGF0
aWJsZToNCisgICAgY29uc3Q6IG9ubm4sczI1MDANCisNCisgIHJlZzoNCisgICAgbWF4SXRlbXM6
IDENCisNCisgIGludGVycnVwdHM6DQorICAgIGRlc2NyaXB0aW9uOg0KKyAgICAgIEludGVycnVw
dCBmcm9tIE1BQy1QSFkgYXNzZXJ0ZWQgaW4gdGhlIGV2ZW50IG9mIFJlY2VpdmUgQ2h1bmtzDQor
ICAgICAgQXZhaWxhYmxlLCBUcmFuc21pdCBDaHVuayBDcmVkaXRzIEF2YWlsYWJsZSBhbmQgRXh0
ZW5kZWQgU3RhdHVzDQorICAgICAgRXZlbnQuDQorICAgIG1heEl0ZW1zOiAxDQorDQorcmVxdWly
ZWQ6DQorICAtIGNvbXBhdGlibGUNCisgIC0gcmVnDQorICAtIGludGVycnVwdHMNCisNCithZGRp
dGlvbmFsUHJvcGVydGllczogZmFsc2UNCisNCitleGFtcGxlczoNCisgIC0gfA0KKyAgICBzcGkg
ew0KKyAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KKyAgICAgICNzaXplLWNlbGxzID0gPDA+
Ow0KKw0KKyAgICAgIGV0aGVybmV0QDAgew0KKyAgICAgICAgY29tcGF0aWJsZSA9ICJvbm5uLHMy
NTAwIjsNCisgICAgICAgIHJlZyA9IDwwPjsNCisgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVm
YXVsdCI7DQorICAgICAgICBwaW5jdHJsLTAgPSA8JmV0aDBfcGlucz47DQorICAgICAgICBpbnRl
cnJ1cHQtcGFyZW50ID0gPCZncGlvPjsNCisgICAgICAgIGludGVycnVwdHMgPSA8MjUgMj47DQor
ICAgICAgfTsNCisgICAgfTsNCi0tIA0KMi40My4wDQoNCg==


