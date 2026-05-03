Return-Path: <netdev+bounces-283653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG+MIgSZ92n0jQIAu9opvQ
	(envelope-from <netdev+bounces-283653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 20:50:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E67D64B709D
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 20:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29F27300D150
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E8339EF2B;
	Sun,  3 May 2026 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="KDj46tnV"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002D4399350
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777834237; cv=none; b=TxzKh3KI697JyciCqgdVNUCXqsAhvlSyVYgNDAYNtJc7VM5GfgzrztoIhNb/RoQjL0/H/db4RtpgOvK7L7VZYYm/5JeVpf0QaeogNR2UX3PHXlfA+8hRZnU0V0HQ16SqeHEcpDmLa+HF9yHGiUFHpG0ZT3flXa4ZpSZN8ew7L9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777834237; c=relaxed/simple;
	bh=07GsRD5OLlu7kbTtCFRnMXsaNCQpxJP71IZxnDj5p70=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=P7qz1Ztu9LlBRCJvA27ishQT1ee6Gq3WoNK2vX920DNfoCdN1LwlFrkA2tucEgxZOU9jOxxannsY+4wvdjd7AVv8wMq0HUyLCPI5CYth3NmDRisnHh/Qz7L6tuevCq/haSbrK7IyrOx5smYaYfsog0Hiufa3NLCbqcCHJBiee0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=KDj46tnV; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1777834235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07GsRD5OLlu7kbTtCFRnMXsaNCQpxJP71IZxnDj5p70=;
	b=KDj46tnVq+krXwBWmvMY3SgE1Dhj7KKbiAJgzoNm0xhJ91RXH6Vho8wdoW2P19exvooqrw
	jJd1eKpK/HS57vjFJo60Uf3MKMlxVeKiPVmUlggwjqhvrvrnYsIcZHBLc+CveOWNJNsqsL
	HL9UZGk3DsLhLU3tW3mJ38u2COKy4wUQwx7Ai5nb70Bqr8xK1duJFraU8qzV/WYgfILCvg
	8tDtcOjxhVv8roB9PDzmKrllTmIarY+hPQg1a3FrwtCm/qogeao7OCw+OP3JKDs2JrhD4c
	SAM8czcKEM7dLBF3SboQZRCYL+iP2BeWZivoLKFp07hxWrQlndU+Li1xZ2hWMg==
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013022.outbound.protection.outlook.com
 [40.107.201.22]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-45-toNPXxKbP7-X1SL95q8znA-1; Sun, 03 May 2026 11:50:30 -0700
X-MC-Unique: toNPXxKbP7-X1SL95q8znA-1
X-Mimecast-MFC-AGG-ID: toNPXxKbP7-X1SL95q8znA_1777834224
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by BY5PR02MB7073.namprd02.prod.outlook.com (2603:10b6:a03:237::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 3 May
 2026 18:50:20 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9870.023; Sun, 3 May 2026
 18:50:20 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "ciprian.regus@analog.com" <ciprian.regus@analog.com>, Parthiban
 Veerasooran <parthiban.veerasooran@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH net-next 2/5] net: ethernet: oa_tc6: Allow custom mii_bus
Thread-Topic: [PATCH net-next 2/5] net: ethernet: oa_tc6: Allow custom mii_bus
Thread-Index: AQHc2rEgF3hIAB6D/Eq3y9ss2XCLE7X8jmMAgAALcACAAAuZ4A==
Date: Sun, 3 May 2026 18:50:20 +0000
Message-ID: <CY8PR02MB92493088AC2D6C2768A359F883302@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
 <20260503-adin1140-driver-v1-2-dd043cdd88f0@analog.com>
 <aad9cb98-8f1f-409f-8d58-0318e125210c@lunn.ch>
 <CY8PR02MB92498A398D3F05B94EEB7ED383302@CY8PR02MB9249.namprd02.prod.outlook.com>
 <77df32ed-3e22-4e9b-941b-3046de25b88f@lunn.ch>
In-Reply-To: <77df32ed-3e22-4e9b-941b-3046de25b88f@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|BY5PR02MB7073:EE_
x-ms-office365-filtering-correlation-id: e76cd13f-86c2-49a4-c71f-08dea944d374
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003|38070700021
x-microsoft-antispam-message-info: qQHJvxN4kxdx5Aer8nDVzv/rmbADoULiCnqSaNNdbDXghgHJU2sz+eSeXo9G+WddsMzqOq3ogp8GbwUVz2WDHXBgRFAguPGJNOukBlq+RkcQgWm1AEFld1LSDAn6m7EkS1Fek58oGDYYOLgjmaL7d+9j5U5nq8qngQervY6IXVqIYIHk8qt6AhBkmv3qk7NILgSUl/wpbJJHDhPwkksEL25/kj5PoxdL/57j6XHxH8KicGOSbGifRECESwLCYxKDvMremonyZHplVnT2DaP94Z+OpnDgQjZmVI5UOjFPH2gHn1vihzE5HrujedAmUmdlS5CUVjnI6rUfRjEUsPqdQBZwmxikQAnQsrnUAbAM4YmnuSsE50oj3GS6NWU2Gm43Ki7aLeczYvDk5qaXr6htUvTrR2pZppxmKl/NHRWffA1B0KlLcVNqfsTwGwNKu/jisaSeW2MQ0nhdcjopNxIgtIHbI0ygvGFj00D5Am7Rxh+jewdOyDgSEQC6iVD0AtwZAXjJDz/ie6zZHHYup9WrAOty4SfoSi2yXVKhjTv1jclWYAqfgMH68kZLphyrQrfFfkGPo49PPTG9qlUxb++CVcp8RPHmfEpnJe9XI6LyzGIZq5NEo8DlsJWoqA/pHrmnKQg9GKft4zW3PclEf8iFHJ14D3aerPcav5jSktQNr0h9+3j/549gf6so6usXMp7f201qhd4Q1XArO7jgZsIXDpdjUhVBcwgfF5//QZ9m4ic7H6LTI3GJ+yruK2w45NX2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjdZbEs1bFMzcGwzbEVzdGhQTjlscHRiWEF3NmdjaDkwekdIOThmYndkS3cr?=
 =?utf-8?B?WDF0Tmx4WEVQeFNZRFlyZWFoQlg3YmhaaW9MVkZLOUJtd1V0VmppdG1Udkh4?=
 =?utf-8?B?bEZFa0cxZmVNK1Z3ck0xSG9Gd2hRZzNRaG5TS1JCZGc1WThxWW8vTDJETTZu?=
 =?utf-8?B?bnd0emx5UGFBbzNOUUFCd1MvVFlDcWozd3hXdlVBMVlCTGw2RG81a0k5bEYw?=
 =?utf-8?B?dkFiVHc1V3ZJQ3V6M1NLODg5OStWaVJzMkJLNExZR01UMGRPalpNT3RJUnc2?=
 =?utf-8?B?SXBNRlFiQkhSdzBYWUtYMHBvTGxUWkR4R2hSYTVJSGdQVC9McEtrTWg2UG1R?=
 =?utf-8?B?KzlzZGdjOFNVK3RwYTZ4Z21uVDRqNW9XdWN3MlZWTlJEakRqT2dWd1V5SVZj?=
 =?utf-8?B?aGVvMVRjUE9jNnBQRmhxdlcxS2N0eXgxMVpiWDk1dEdBZU5jM0JZQm5weXJv?=
 =?utf-8?B?cTdwS2kzWEpRSjlKQndXbzNTdDZpbk9ZZU9RdmtFekJxTGlnOHVnRDMzRDJ5?=
 =?utf-8?B?ZzlSaHRsc0lGVW90ZXQ4bGUyUkx0N1JhbDMyMksyZ1FSaXFyMUROWFpwc3U3?=
 =?utf-8?B?VlN2cXRtZzZGRldnRmxVWnJBeE9XSWN0U0FxajZJcGtzUGFiNkxBVFRYelE3?=
 =?utf-8?B?RVNTSzJlZ3MyYW8rYjJHZWZYS2JrSS9IWHN1STlIbzcvTGVqTkEwaUhaVDl1?=
 =?utf-8?B?TnBYSndaQ3k0eGxGeXMrOXl3RG90Nis2aDA5Q3JHN0NsY2JHVGhLQ3QrYWtI?=
 =?utf-8?B?c2psbUoxVjRvbEw2WXAvWHpuUnNxYllkRU10VVB1ZnZaVHB0bm01Z2dQdFJk?=
 =?utf-8?B?MFBoN3VsWnRpT1FPZXhoV3I2RXNLWHlUS01nWHgvSmJhSkZ3WDc4SDFBc05i?=
 =?utf-8?B?U0ttVzdkNjdjaVNOVk1ha3g1d1BxLzY2N2xDWnMrRzQrL0k2V3lpRFBVRTZo?=
 =?utf-8?B?bHJlSnAvUDUxM2NMUnZEdWFXWXUydmtRZVh2a2FodGptZERMbnRxbXhpNDRR?=
 =?utf-8?B?RGthY2FmNWVDWXZscnphSUdqbmZReVJoSnMzUm9icm1SZlArRmZXbWVOSjh4?=
 =?utf-8?B?UDJ3RHZoaTVXNzZ6bnRhdE5sMytUTTRVT1FMdUVacDFvVzh2dXJKeU1XMnZv?=
 =?utf-8?B?NCt6QUI2T1lQak90N21oQk5OR3B2akdUaXZHY0JzVllVcWhFSDBIcm0yWlo2?=
 =?utf-8?B?OGpvZFFDakxjSWNwSDkySVAyakZYaEk0L2xEVGJXTG5YdUU0MHJkT3ZvQ2dq?=
 =?utf-8?B?NzFZd0tJQTFtVmx5SHFETkZrVi9DSzVlaVUzNW81RjEzKy9WSlRMTkZVMXEy?=
 =?utf-8?B?TGlqZHc3V3JDM1JTSk1LS3FBNFJtQ1BQMjJuM085UmEzWkhqcTBzaUpyVzU5?=
 =?utf-8?B?VlhDV09IazBwamJlYkFnYUVnc3NvbFJBZmdycVJ6NzltNUZLR2MzVWdkYkkz?=
 =?utf-8?B?aUdiMW0vcU01dzBUK1ZPUmt2dE1lQmx4Q3lpdzhrdDQ3WllZUzZHd25DWHdw?=
 =?utf-8?B?NnBRWkhNZTMrcWxicE1kbHZnYmJnOURkM0hsR3BSZVVHSFpyWE93V1hqTDhW?=
 =?utf-8?B?M3RSUFpDVWo5S2c4bGVtaVBQNERPcFBFcjYzZTQrU3JtSXkwck1vZ3J1bzJL?=
 =?utf-8?B?UmU5Rm5vQVlNRm5jSlZPTEFuUWxQMTB5UkhPYkFBZHJMYzM3Zzd6K0h6VWFZ?=
 =?utf-8?B?TC9IbzJiRndHNlBBSnd6RjV0aWZLdmxZci9URjk1YXJrYTJPZ2NMb0psV3Q0?=
 =?utf-8?B?TXArTkRBS2tXYjVmSGUxRmlGeEJJQVBMRHdXeFZEZ3hXcG0vT1NoU2UvYWFN?=
 =?utf-8?B?ZUZVbU54bXE0Um1EeS96dXZyYlAvcmE3TkxGQ09BOGI2UHA2M1dXL2ZxSlRp?=
 =?utf-8?B?NHdIaEcvUG94Q1RVNHErYzNWM0s5bXpZemlNOFR2V0tEb3dsTnlaVGpRRS9k?=
 =?utf-8?B?L3JMajdlYXdPVWtiekFnNm9QYjlNem5FRVBqRTBnS2IxcTdmVnc0dld1dGVF?=
 =?utf-8?B?cVQ4NFVqaDVSWTQxOE11c0loN1hXSVVmRFFKbHYvUmhiV29ZR3VudEVnMHFE?=
 =?utf-8?B?bWlzZytwRCtWZEVJYWRmNnlGMU9vbWE1SExOdCsvZmhFSThaVkNsTmZvUERv?=
 =?utf-8?B?WFA4K2tLaUIrRnVvMGJFSGZtaW12QmdndEhLbytIL28zczVFSDZyMmFUWmlO?=
 =?utf-8?B?MDhHUlYxUkRlNmF4ZFJta2NXM0h6Y2hydUQwMjExd09EcU1MV0IwUkhXK3Nu?=
 =?utf-8?B?Rlk4STBHdjFyZ0F5ZVYzTnBUQk1NM0NsSlVteHpGVVpJNzg4cm5GY25ic0tM?=
 =?utf-8?B?UVVreWRJWHRBV25yT2J3U1RsVmsyMnZmRHNEUHdCcFJwSFRXOUVTZz09?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Lysj1qvzUE7PMh6n/7uFWH7828o/0Q/UxcnzgZkmdRsruubs2782+rAgQjYzXb6eMNclpwpeLPdYcuKUx+7rWvsksDMV+9UsKJfY1x97k1gwNjc+35PiLVrvYZkb8JDD9xobadzZFfGsS1PFAsjRzEEsjCiqGbHI3fo1MMyRW4ZnuHfoNg/mMi/DnPCUlhEwmU8UffkmXrmiB5juKmlK0gKZxmBFloSjeVzd/nNJ1mnEnh6XYnnupaWipgpAWiH56c0JgDpKCQsgaoHbjzqV/z3hzjm1eiT3otcTVVYKKDHbN6z2fI2jHZ6hNXcD7FkP0fosqbsghIQmuxSutzRHlw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76cd13f-86c2-49a4-c71f-08dea944d374
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2026 18:50:20.3497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b97JYJBRcjLLn+J5UFVVm5V75O4qYNkmzkfyOtC1hr41fq9aglm7qBo8GwDj5tBvDexXD/pV0hukfff3zCZzaoELIJjKr637ILWOsbRogTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7073
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -J4QfxbNdR1_HXv21_whCdI33D_xirvr1m0I5apu-Xw_1777834224
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: E67D64B709D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283653-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[analog.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHJldyBMdW5uIDxhbmRy
ZXdAbHVubi5jaD4NCj4gU2VudDogU3VuZGF5LCBNYXkgMywgMjAyNiAxMTowNyBBTQ0KPiBUbzog
U2VsdmFtYW5pIFJhamFnb3BhbCA8U2VsdmFtYW5pLlJhamFnb3BhbEBvbnNlbWkuY29tPg0KPiBD
YzogY2lwcmlhbi5yZWd1c0BhbmFsb2cuY29tOyBQYXJ0aGliYW4gVmVlcmFzb29yYW4NCj4gPHBh
cnRoaWJhbi52ZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tPjsgQW5kcmV3IEx1bm4gPGFuZHJldytu
ZXRkZXZAbHVubi5jaD47DQo+IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47
IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47DQo+IEpha3ViIEtpY2luc2tpIDxr
dWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBTaW1vbiBI
b3JtYW4NCj4gPGhvcm1zQGtlcm5lbC5vcmc+OyBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24u
bmV0PjsgU2h1YWggS2hhbg0KPiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz47IEhlaW5lciBL
YWxsd2VpdCA8aGthbGx3ZWl0MUBnbWFpbC5jb20+OyBSdXNzZWxsIEtpbmcNCj4gPGxpbnV4QGFy
bWxpbnV4Lm9yZy51az47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2Yg
S296bG93c2tpDQo+IDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0
QGtlcm5lbC5vcmc+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IDIvNV0gbmV0OiBldGhl
cm5ldDogb2FfdGM2OiBBbGxvdyBjdXN0b20gbWlpX2J1cw0KPiANCj4gDQo+IFRoaXMgTWVzc2Fn
ZSBJcyBGcm9tIGFuIEV4dGVybmFsIFNlbmRlcg0KPiBUaGlzIG1lc3NhZ2UgY2FtZSBmcm9tIG91
dHNpZGUgeW91ciBvcmdhbml6YXRpb24uDQo+IA0KPiA+ID4gVGhpcyBhbGwgc2VlbXMgcHJldHR5
IGludmFzaXZlIGFuZCB1Z2x5LiBQbGVhc2UgY291bGQgeW91IHRoaW5rIHdoYXQNCj4gPiA+IGhh
cHBlbnMgaWYgaW5zdGVhZCBvZiBwYXNzaW5nIGluIGFuIG1kaW9idXMsIHlvdSBwYXNzIGEgcGh5
ZGV2LiBJcyB0aGUNCj4gPiA+IGNoYW5nZSB0byB0aGUgY29yZSBzaW1wbGVyIGFuZCBjbGVhbmVy
Pw0KPiA+ID4NCj4gPiA+IEFuZHJldw0KPiA+DQo+IA0KPiA+IEtpbmQgb2YgYWdyZWUuIEluaXRp
YWxseSB3ZSB3ZXJlIHRoaW5raW5nIGFib3V0IGNoYW5naW5nIHRoZQ0KPiA+IGV4aXN0aW5nIGNv
ZGUgKE1pY3JvY2hpcCdzIHZlbmRvciBjb2RlKSB0byBhbGxvYyBtaWlfYnVzIHNvIHRoYXQNCj4g
PiBjb2RlIHdvdWxkIGJlIHNhbWUgYWNyb3NzIG11bHRpcGxlIHZlbmRvcnMuIEVpdGhlciB3YXks
IGl0IHdvdWxkIGJlDQo+ID4gaW52YXNpdmUgY2hhbmdlcy4gU28sIHdlIGRlY2lkZSB0byBnbyB3
aXRoIG1pbmltYWwgY2hhbmdlIHRvIG90aGVyDQo+ID4gdmVuZG9yJ3MgY29kZS4NCj4gDQo+IFRo
YXQgd291bGQgYmUgd3JvbmcuIFRoZSBzdGFuZGFyZCBkZWZpbmVzIHRoaXMsIHNvIGl0IHNob3Vs
ZCBiZSBpbiB0aGUNCj4gY29yZS4gQW55dGhpbmcgd2hpY2ggdGhlIHN0YW5kYXJkIGRlZmluZXMg
c2hvdWxkIGJlIGluIHRoZSBjb3JlLCBzbw0KPiB0aGF0IGRyaXZlcnMgZm9yIGhhcmR3YXJlIHdo
aWNoIGFjdHVhbGx5IGZvbGxvdyB0aGUgc3RhbmRhcmQgYXJlDQo+IG1pbmltYWwuIEFsc28sIHdl
IHRyeSB0byBrZWVwIHdvcmthcm91bmRzIGZvciBicm9rZW4gaGFyZHdhcmUgb3V0IG9mDQo+IHRo
ZSBjb3JlLCBoaWRlIGl0IGluIHRoZSBkcml2ZXIuIFRoYXQgaXMgbm90IGFsd2F5cyBwb3NzaWJs
ZSwgYnV0IHRoZQ0KPiBhaW0gc2hvdWxkIGJlIHRvIG1ha2UgdGhlIGNvcmUgY2xlYW4uIFdlIGRv
bid0IHdhbnQgdG8gcGVuYWxpc2UNCj4gdmVuZG9ycyB3aGljaCBnb3QgdGhlIGltcGxlbWVudGF0
aW9uIGNvcnJlY3QgYmVjYXVzZSBvZiB2ZW5kb3JzIHdobw0KPiBnb3QgaXMgd3JvbmcuDQo+IA0K
PiA+IFRyeWluZyB0byB1bmRlcnN0YW5kIHlvdXIgc3VnZ2VzdGlvbi4gQXJlIHlvdSBzdWdnZXN0
aW5nIHRvIG1vdmUNCj4gPiBlbnRpcmUgbWlpX2J1cyBhbGxvY2F0aW9uL0FQSXMgaW1wbGVtZW50
YXRpb24gdG8gdmVuZG9yIHNpZGUgYW5kDQo+ID4ga2VlcCBvbmx5IHBoeSBkZXYgdXNhZ2UgaW4g
b2FfdGM2LmM/DQo+IA0KPiBOby4gSSdtIHRoaW5raW5nIG1heWJlIGV4dGVuZCBvYV90YzZfaW5p
dCwgc2ltaWxhciB0byB3aGF0IHlvdQ0KPiBkaWQuIEFkZCBhIHF1aXJrcyBmbGFnLCBhbmQgZGVm
aW5lIFRDNl9RVUlSS19CUk9LRU5fUEhZLiBBbmQgYWxsb3cgYQ0KPiBwaHlkZXYgdG8gYmUgcGFz
c2VkIGFzIHdlbGwuDQo+IA0KPiBJZiB0aGUgcXVpcmsgaXMgc2V0LCBkb24ndCBjYWxsIG9hX3Rj
Nl9tZGlvYnVzX3JlZ2lzdGVyKCkgb3INCj4gcGh5X2ZpbmRfZmlyc3QoKSwgbm9yIG9hX3RjNl9t
ZGlvYnVzX3VucmVnaXN0ZXIoKS4NCj4gDQo+IFlvdSBwcm9iYWJseSB3YW50IHRvIHN0YXJ0IHdp
dGggYSBwYXRjaCB3aGljaCBicmVha3Mgb2FfdGM2X3BoeV9pbml0KCkNCj4gaW50byB0d28sIHNp
bmNlIHlvdSBzdGlsbCBuZWVkIHRoZSBwaHlfY29ubmVjdF9kaXJlY3QoKSBhbmQNCj4gcGh5X2F0
dGFjaGVkX2luZm8oKS4gVGhlbiBhZGQgdGhlIHF1aXJrLCBhbmQgbGFzdGx5IHlvdXIgZHJpdmVy
IG1ha2luZw0KPiB1c2Ugb2YgdGhlIHF1aXJrLg0KPiANCj4gVGhlIHF1aXJrcyBmbGFnIGNvdWxk
IGFsc28gYmUgdXNlZCBmb3IgZGV2aWNlcyB3aGljaCBoYXZlIE1NRCAzMA0KPiBtYXBwZWQgaW50
byBhIHZlbmRvciByZXNlcnZlZCBNTVMuDQo+IA0KPiBBbmRyZXcNCg0KQW5kcmV3LA0KSSByZWFs
aXplZCB0aGF0IEkgd3JvbmdseSBwaWNrZWQgdGhpcyB0aHJlYWQgdG8gYXNrIG15IHF1ZXN0aW9u
LiBUaGlzIGVtYWlsIHRocmVhZCB3YXNuJ3Qgb3Vycy4gQnV0IEkgZ290IHlvdXIgc3VnZ2VzdGlv
bi4gV2lsbCB0cnkvdGVzdC4gV2lsbCBkaXNjdXNzIHRoaXMgaW4gb3VyIHRocmVhZC4NCg0KU2lu
Y2VyZWx5DQpTZWx2YQ0KDQo=


