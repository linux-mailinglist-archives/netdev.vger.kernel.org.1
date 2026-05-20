Return-Path: <netdev+bounces-289813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDoJD5+CDWrUyQUAu9opvQ
	(envelope-from <netdev+bounces-289813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:45:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8318A58B02E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51BAF3058749
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 07:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2AE3806D5;
	Wed, 20 May 2026 07:51:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2094.outbound.protection.partner.outlook.cn [139.219.146.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADC53438B1;
	Wed, 20 May 2026 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263477; cv=fail; b=AtnMD1FDOabF7c6uct1WoRx2qcrfOaujWoX08Uxg8jxQziOXFVTlYYTJX/FyClRYyv5TNG+3bcEWEeMgMg13Sb8d/kizGbsT0OF0D2DDznhjgcy56rWqpRUOZwUOdXI9cLG7HLD2HrNmW3bz7S64ZitDrAjGOi2yyL5Go7BVsZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263477; c=relaxed/simple;
	bh=tBYwTIkg7Rl5r0EYU1wwfTNBwZ8E/1c9Rrr0lpOOcJw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ohNfyROGt2ZzpL2G7ilpft9RPikEwNKQ40bWnFUL2HXPkbG5kZP5FfC79BDJLTzarevdsCbPd9ixYcxhujJkYWba7y2b0Nxg0vQqH967HuEjWOh5OMoCWSSieVN4Fv2ZAokn0jeH72TSgFhI4hHfHR0Io73+jjj4zxCB0eZTqv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adfXoRakl4+ua9TEhRAnGBlbCxa8llx9ycRxyfIqTqFHIV7xMCJewPFqYKjgS07NLdA0GWjwRpM3rsQ/qVz1XkZCDU+NS6gLk2vgkewcgM8UmedNVrp9OXXM3xoScMfwcLNw8AtR65rVpR28xRK0Ao69OC9568AvY98uiiBHMkLS0ajk1ZLDpxHQSdF2H6alpsX0sfSXVG2og0zfTKwi13218u2wZzuBY23VfQ417ewoxp/XIXf9oAE0PyBEmk4OVr6QUS/Kb3oNlM9fbVc/1nDwEshzHjMvo6+0wugmEJW+tHye9BBFhcNoQzdTxOBB1OuW+6W0tdTDE5bu1Uk99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBYwTIkg7Rl5r0EYU1wwfTNBwZ8E/1c9Rrr0lpOOcJw=;
 b=m+6G54rpofBJUPSs/EBQBR7sc/eGtvT28yjcrNMCp86CiydgCKkyB8s7Zr97/NiZJI5QucsQvEJnI5b2wiChRUG/LQSBoRg8pUTfFb9EOhRKoCOXWrHDkgnfWZ+R7opcFgR3f9jiLv1YysDSOvgg9YHnCGGNP47jjtDiXa/mVAVFrXBZwVjz/7UOKd0sTedspou9ZIUO/qtoc3eORKodOiiArTsuZcUbFKyyvba52hAWxJplcqZ/DptiRmCDAReq5hDCUKsfL9+/Dl0cRAcpC19HkhYZK3YZrJcyasEQlH5DDUPDCwj4DZhGlQGDw/nDrkVrwHU/ZvRUzNaRFWQ+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0893.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.15; Wed, 20 May
 2026 07:18:22 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Wed, 20 May 2026 07:18:22 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [net-next v4 3/5] dt-bindings: net: starfive,jh7110-dwmac: Add
 jhb100 sgmii rx clk
Thread-Topic: [net-next v4 3/5] dt-bindings: net: starfive,jh7110-dwmac: Add
 jhb100 sgmii rx clk
Thread-Index: AQHc53hT59M+uKUzr0qKiLTpANMLHLYWff6AgAAEvlA=
Date: Wed, 20 May 2026 07:18:22 +0000
Message-ID:
 <SHXPR01MB086346EAB66ACAFAE228E290E6012@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20260519101436.111476-1-minda.chen@starfivetech.com>
 <20260519101436.111476-4-minda.chen@starfivetech.com>
 <20260520-acrid-kickass-kittiwake-6d4247@quoll>
In-Reply-To: <20260520-acrid-kickass-kittiwake-6d4247@quoll>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0893:EE_
x-ms-office365-filtering-correlation-id: 77a6f82c-33af-4eb8-cdcb-08deb63ff9dc
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|22082099003|56012099003|18002099003|3023799007|4143699003;
x-microsoft-antispam-message-info:
 hoGusLfIeh7bK3rl/T6DqKOQcNuAGIPHOUaIPZ0yK8ywTnaxG/xONYJwXP94Md78KDUadKZ8uc36LZiDlB33esvsgB0x3HNtmyox7bEUKa7fH7ep3UfoQYyph2a/JPyAnS5xr1ghJnEuhShTGUnmcjuvJ1yaA7McehTQqPkH0XEVxm/uboYh+R+KNq7wgLcYJmRZsPhRMrdrhcl0n0Er06OJTCUwYPz5Rq1R6EmLeg39KN+VToLhrQ1YErqiTzhz332iJ7r4miS3j5TBHvwH7Gi/ypo8Ek59UhrinrcXOmIW7UBz5UTak428jXchc3UT/DFy51Io3IVbbSZi1sTbWdudeYL26GomiRkYYL+8sWGRebTIWdjiwhsnZw8xw5/Oi5l00t+Ehx+tfqJojlNqd8nfMvUt4GsP5ObIolkq0L2ZGV6jX/TffDujfavJj6/ooab12tVnBD78/7HxnNS/kRQ2ZTQOxPr5o+l6q5IBHkSVD6vtnKau/0/EJz+G9ZcSGFiaVQzc06KRySZl+ZkwFSEwVKe/B/ifUiI9XjMxegsIGikoDNRfJ2SZp85o0ToG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003)(3023799007)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHh3ZkpxamlKL3I1eDZtWkZ3S05hNWQxNkE1RFE4WjdqRWtrb1hVeDlBUjM4?=
 =?utf-8?B?ai9SNG1JWklnbnVhNGtIY1NVdVNnaTRPZHZjRzB6VEUza1Z2dExFZkk1d0FC?=
 =?utf-8?B?aEZUSFhtRkd3dzlKUWNTemlXMXozRGlZQktlTDJ2SHlqbWZzT1M4azNhSXNQ?=
 =?utf-8?B?N0ZXZVdUMlBQamNXYXNiUXVBRDc0K3dxaVl1c21GYkxGdDR3cGV2bFpPY25x?=
 =?utf-8?B?bDJ3TmFnUm4zc29JWk1wbXg0YjgzU0FBWmMzMzJ3RjhsTm5MNndIdllRUFJZ?=
 =?utf-8?B?cFZpQ3Y1bnh5L1VZN2U1WVR3cVhDb2VmK1NiSG1jOGc4MWZpUWltQzNkbUxH?=
 =?utf-8?B?VUlqbjZtRTROdmNSZkxmbEVFT050cDdWTkt4a3lreEpFejNVb0o4UTdiZHRY?=
 =?utf-8?B?RGZ3RG1FL3ZRbGREREdEd1k4a2RWbHpnaVR1eFBHcWxuVnNmd0JhZS9GSUpF?=
 =?utf-8?B?RGk0M2Y5ZzQxUjNNR25qT2lNa0dEODdIUmZmNUVRU1FDOEFoOHdtZWRrMWpj?=
 =?utf-8?B?eEpIUUdQZ25WWldKeVdrRno5aWwvRlFOdExybExxeW82UVJaNm1nblJ2M1lp?=
 =?utf-8?B?ZXY4RVAzcGxKN3JuNlZMK2xSRUwweXJBYXdPRHRRclVDdnVKR3hpNzcyWk5O?=
 =?utf-8?B?MWNvVjBqWEpCZDFFN0tLOEZZcnIrZUFocCtnYzJjL2ROKzRTZGhPeDlTSEJU?=
 =?utf-8?B?NjFWVHlSaFRWVGRsVnpZeVhVNzN0RndmWDg1TjJiNEFqTytpWWVYSjJyTVdM?=
 =?utf-8?B?Q1BxT25lek9senZzSDlBcjVqN2Q1NzBBQnVHMlI5RVpNZTI4aUNpc3VsQzZC?=
 =?utf-8?B?QUJTTkZQMnZLbVpsVEJhVWp1VjRBc3BFdzlXcEZyK1F3UyszM3RFUS9VZ0Nz?=
 =?utf-8?B?RDlBZ3lzcVZzWFN3RWxNUmFUQTVpV09ZOWEyWlhhMXNWOUJrNmVtREJKNlVT?=
 =?utf-8?B?QUluWnNQZWdnc01yMklYa0NPZFVPNTNMYm9OazhCTS9yTENaVW9VdlAvelht?=
 =?utf-8?B?YW56MHhjbXJrQW43Z2lsV3ArRTJ3L2Q0WWwxL3cvay9EdElsV2QrOHJWOGo4?=
 =?utf-8?B?NW9iZFBmenVrc2tySWM3NERGWmZoN3VxbGU5eWpHNHhLSDgwQkNqc0k4S3Bt?=
 =?utf-8?B?VGZBT1lScDN1cEovYXNXQUtTQmlXODBvajY3VEJKNTRZeEJtMkFidTlYV3A1?=
 =?utf-8?B?OWk5NXlpMjhSa0tFcHJOOVVSV0x6YW1CaWVnOUVibng0NFpOOUFiZThTVUFQ?=
 =?utf-8?B?SGNyWU0zM09rekpocjhaNkZzc3ZMbVZENDRlWWthcERjN2UyMFhlUDErQ2wx?=
 =?utf-8?B?MFE1M3phRHNzZEl2VzlNeUtZVVRISkNxWDk1YjhtMTdqc2wvYmEyVGpDVGZ3?=
 =?utf-8?B?R1NDWGc5ZlJ5TytIMVFJWTdKaThOcHJ1OVUvRGwxa3plTUNwTmZLVFMxemE2?=
 =?utf-8?B?M080RklZNDF4UFpCSW1jYjJmWm5lRkhSb0NpL3Y5cGhpbndhb2lUc01VR3Fx?=
 =?utf-8?B?S1kyRXRCYlErMzZaanA2ZCtXbS9VZno2NENVY0JaRGszTEQrUTMwYnErTjdm?=
 =?utf-8?B?anAxUlBiaHFVYld4MWl5ZmVqdERBOXg5ZG1aYnlxMFl3S1NxTHBHSjR0bUVF?=
 =?utf-8?B?TE9KNEx0bjArNHRaZU9CbEhmVUNURGxSb3ZTWFo3V0NwUmR0RHlZZ1dMNGV4?=
 =?utf-8?B?OGRiSnpFMHlleGVsMFVvQ1h6QnFmKzhlZGNEbWJVWUxJNmc0cnZBZ29jcXNw?=
 =?utf-8?B?Q0YxUGRCbmJiYmNRanQwUG02U3hmUURIQkwzdFZtbEd3d0pUdWpvdDRWZGlM?=
 =?utf-8?B?bHkyaVBsTkdYbCsrSkg4SElDVVJjQ3hiWG5tQ3M0SmtGckpXK0tPUEtQaGZ5?=
 =?utf-8?B?ZGJ5NDhYRHEzVWFJWDVuZjJUdDFjRWErV3hDVFNYWVIwVWJCb3RmUzNpK3Bx?=
 =?utf-8?B?MUtvOS94TDdqdlF2WFF6cmg4aVE1cFFUUTJhRWRBQ0puK1diWkg3ZUI1UE1p?=
 =?utf-8?B?ajlzcDJGanlNdGd0VVh0RUpvdE4rN1pJTGcwZ0NnbHZuM1lzNTNOZ3dZWEs3?=
 =?utf-8?B?NVVVVFN2SDRxQ0w3UGFLT0ZxUUJzaFE5bDZlQlFoUmRNNDNiQXR5djIxdGEz?=
 =?utf-8?B?UU04cGdCVTBoUWV1RS9Qa3Z6YTE1RldReWRUN3FnLzd2QlAwNHNjOXowZkRY?=
 =?utf-8?B?TGhLVm9PL0dmdkJKbE5qWVM0WDdGQzFVQVJ5NXRUQkpGSmVzeW9kclg4MTVj?=
 =?utf-8?B?RDBRM1JpQ0tPUndZNjFmcTRYNUszWUo3U3ArUlVCdmJqWEhwaU5WVG9MUXQx?=
 =?utf-8?B?YTFvcU9YbUJ5a1pvYis0UGNMclhlRnVPM1hEZjJaNnJ6L1p1cyt2UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a6f82c-33af-4eb8-cdcb-08deb63ff9dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 07:18:22.3909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jFbaBn3+/kBRV+RTYgiwzxnmJV+2Sl+4jPHK/EgxYE2r+BEb8716LW3BEvqvUAh10/jtZSyfQI5AGnLsNp2C69zf5MltnEkp0w4eC9G9Skg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0893
X-Spamd-Result: default: False [4.64 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-289813-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org,st-md-mailman.stormreply.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn:mid]
X-Rspamd-Queue-Id: 8318A58B02E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gDQo+IE9uIFR1ZSwgTWF5IDE5LCAyMDI2IGF0IDA2OjE0OjM0UE0gKzA4MDAsIE1pbmRh
IENoZW4gd3JvdGU6DQo+ID4gamhiMTAwIFNHTUlJIGludGVyZmFjZSB0eC9yeCBtYWMgY2xvY2sg
aXMgc3BsaXQgYW5kIHJlcXVpcmUgdG8gc2V0DQo+ID4gY2xvY2sgcmF0ZSBpbiAxME0vMTAwTS8x
MDAwTSBzcGVlZC4gU28gZHRzIG5lZWQgdG8gYWRkIGEgbmV3IHJ4IGNsb2NrDQo+ID4gaW4gY29k
ZSwgZHRzIGFuZCBkdCBiaW5kaW5nIGRvYy4NCj4gPiBTbyBpbiBqaGIxMDAgU0dNSUkgaW50ZXJm
YWNlIGNvbnRhaW4gNiBjbG9ja3MsIFJNSUkvUkdNSUkgaW50ZXJmYWNlDQo+ID4gc3RpbGwgY29u
dGFpbCA1IGNsb2Nrcy4NCj4gDQo+IElmIHRoaXMgaXMgZm9yIGpoYjEwMCwgd2h5IGlzbid0IHRo
aXMgcGFydCBvZiBwcmV2aW91cyBwYXRjaD8NCj4gDQo+IERvZXMgdGhpcyBuZWVkIGNvbnN0cmFp
bnRzIHBlciB2YXJpYW50IG9mIHRoZSBkZXZpY2U/DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEty
enlzenRvZg0KDQpPa2F5LiBJIHdpbGwgbWVyZ2UgdGhpcyB0byBwYXRjaDIuIA0KDQo=

