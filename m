Return-Path: <netdev+bounces-296625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xx1RKOPiJmqpmQIAu9opvQ
	(envelope-from <netdev+bounces-296625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:42:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B846583C9
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:42:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=aD7MQXZ2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296625-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296625-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 115393051599
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 15:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248E4423152;
	Mon,  8 Jun 2026 15:04:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC25C3DCD86
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:04:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931075; cv=none; b=JuSq+2gJwZdPpVZNBUaYWh+y5lQa3OskIT3j+MB6gbswZMoNPTcSqb8GCZR4fMj8LZmlXGYo3/90xZRWf0hvQjrhovTT2ybzT/PwgqIxfn9DZXzZY6t82U/E/ZhJiAehPfgIXwRNmaTkTZk8exn+dJVFuoFneca9NIxOc1AlbAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931075; c=relaxed/simple;
	bh=AMp19Y3f3mgCseJLZe5AGO/icYDr4A3NJA39rKfnj54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=oRvw7Jl9Ymu/VSItqtS36WAyvMn+oYv4O++rmtNEmWTsXEXShLRa+Ql+zRi7XkzDU/FDK4lwWy/Qqq0cCw1ZXKRNkdbVhaTUlMKdHsOd79htNVSuSAHO9YSj+59DFMbr4c3inZJ+9y1BqHMbmVrezub6RqE0Bmexen/sW5eHLLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=aD7MQXZ2; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780931073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMp19Y3f3mgCseJLZe5AGO/icYDr4A3NJA39rKfnj54=;
	b=aD7MQXZ2Rs5zZ+wGH88DviJ9DwTg96/dlXhs3AoplBu/By5LceQMZnhpgElvhx99LU07AT
	UtOS69PH2T8NtCTnWgOgrgHDSEIY9Ye9p2sD/cStZGUdKJ3X22VT6MS/ymcWwOHoHjppXL
	iWZn6+DCOyXLeEIsECCJEi5rQqe9ueUg123Jjq3OTkZx/KiRAapOZSmKIoBYA/gx8BEA5a
	ISrvmM2LEv2BTeExA/Qwf7hKok62/UsqC8pV2dpB6j0TO/zEV5mOq2Rza/FnLyTu7yqBu3
	EVm7fIWZsDnVHlXYQBqeTQv6GKkU1nSsELkdo8nDWUeh/j2VBq4DzqJxDPcxeA==
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012056.outbound.protection.outlook.com
 [40.107.200.56]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-54-bxBH4JDtOxqh3JIfQ0Fm8g-1; Mon, 08 Jun 2026 08:04:28 -0700
X-MC-Unique: bxBH4JDtOxqh3JIfQ0Fm8g-1
X-Mimecast-MFC-AGG-ID: bxBH4JDtOxqh3JIfQ0Fm8g_1780931062
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CH3PR02MB10112.namprd02.prod.outlook.com (2603:10b6:610:197::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 15:04:19 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 15:04:19 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>, "conor@kernel.org" <conor@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
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
Thread-Index: AQHc8eDLvWzkHnbXI0KmrY/VvMfuDrYrecyAgAALlpCAAm25gIAAkU0wgAAYXICAAAajgIAFcz6AgAAGt5CAACvrAIAAgT8g
Date: Mon, 8 Jun 2026 15:04:19 +0000
Message-ID: <CY8PR02MB9249CBAC46F7F56A5075254E831C2@CY8PR02MB9249.namprd02.prod.outlook.com>
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
 <103296ba-9577-4851-ad43-dcd261130afd@lunn.ch>
In-Reply-To: <103296ba-9577-4851-ad43-dcd261130afd@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CH3PR02MB10112:EE_
x-ms-office365-filtering-correlation-id: dc5d7d61-9291-4c8d-aac4-08dec56f373e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|6133799003|38070700021|11063799006|4143699003|56012099006
x-microsoft-antispam-message-info: x9vDLgSpVTZa7Hc8La+2MBBEtOy5CQhz5Ritg7JHW54xPj8senZ3cIDrApxjmyXxdazd8xKjwhdG/NwkLs57yy4qtlfpIkPeQO0m9zEpEcbL6U0ggQXGgxVZqlqDuVmJ8Uu1cwGzb805lylkKbmE4aEVS0paS67E2SMEoCQA9BMGzHnld/+6cRziY4fqT5hEZTC3uf/wgi5HOkDmldRcZkbblKBVdGzyVuyWnu3jqKps5FIfLR1QQWdFa6+F5QK/fvAJPSOBwancYGU2i0b6y8rt6a6hKedtghlOCdLBm95UMFhkcIdLn/IvsVodhogAMF8DSZNOXAC9tY50gbWtersbpy6lxoCpGKl52WqCx2KwLax33Ab0cJPNIqEUcop72HfZsmHo6n31XBxSqIHShFlb4/4KBg9xqAYuTHPT/Ah+OZ494uF4tQ76vt51Ch7yW9mUv03rl6Kw57B9TeCamx1klu76E9IjWR5vaFTvp1urXIgCFrdzza+c5+AJqvWJs6xppdKVSTU7dCmzkpaOSlG3HRtZz0rgdSA7gsERUhtbTanx5sM/8fLOiIopvb4F39fK5+mCx+HJWB2SKi6zve6bwmOPIoF20ncnWcRltdGeELzIXZ82nvbZibGeafFUuLwxgU8NfB4+i0A7GyPHv82hREpAA5TNQykin9dG+2LXX9BEPKivtCYAAx2hNpapDR5QBm1WBK6bATEZLvTVkf7Rg3Y27EtBKKebCGmdOZU9wdAdlyA4AU961Zc3NASB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(6133799003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzJoaGVKbSt1WlloU3FPbzZoTktKMi9jNDFUWFlCR3lRWUkxdHBhaXZzTUpp?=
 =?utf-8?B?a1FjaVFmQ0tMNCszTFNucTFrY2hML2M3bXg1M0tYKzMvekd5T2JXVTRmTnJX?=
 =?utf-8?B?V1k5bDRZY0ozenVGcGFtL3JBVEROdkZFbE5MM09WczVuT1B1RUxydDBGS1ZN?=
 =?utf-8?B?MmF1RkZFZnhRUXNPSFI4MCtIWm1zcDNqcW1NRjFCcjJzcXBSbFhjc0F2Nzl1?=
 =?utf-8?B?d0VTOWNXOUpBMHVrSFhqU282dmhlNThMc2VwaFB2dHJVYkpPSXJiUE9Tb1dr?=
 =?utf-8?B?TWEyM3V5RERpdGtkRk9EOU8xV3Bhc1lOZTBSRmdqM0htK0ZrbmVlV1RLRW1D?=
 =?utf-8?B?RzAzU29qb01FSkJQMWVqVHpoaWJWNE5FeXJDNkVMcGZYcGFDRE5JdEJub2gv?=
 =?utf-8?B?emtuUm9JS0RCaUFraFRmYlRMSVR6djYyZitzQTllaHFDSkRzaXRvNnBrRUpr?=
 =?utf-8?B?elBrNzhQbXF4M01pc2lTdWZiYjV6eUVTZmE1ZkUwd0tWVDQ2Wjg2R3d6NjBZ?=
 =?utf-8?B?QjJYVXROMWdoV3dKOUtlUSt5ay9GeVMzeU94ZEYxUUZLalF6SHV4aDBVb0cr?=
 =?utf-8?B?MDQxamR5K0l3TUxuNko4N09BR0FlbUZ1blFPWHhEdE5jeHJJZGdEZkQyd0F1?=
 =?utf-8?B?cm84bmRvWXJBcVliUFc3OTNrZ0VEcUhkT1BwdSt6dGJLRUhsMUNsNFFCald5?=
 =?utf-8?B?a0FKTTJHVXRlbjNsSlllTVNMZmRDcStaK0hjNkh3Mk5aVHNtY1lKWXZ5V2l5?=
 =?utf-8?B?eUlTZVJaSnlxRFJkdHlPcG82Z2hONk9zcDVrczB2M2dvcVZwNURON2t3YWtv?=
 =?utf-8?B?ZDYraWlZT3MvMkhGUkljLzVxalY0aDg0cjRRYXdGV0hySUVZbDVhNzBFZWZa?=
 =?utf-8?B?SytFWGJxOHBxZDNBOTMyWUhEVDlBVURUNWJOVVVDU0Z3NGhzZEZtcy9EeUp4?=
 =?utf-8?B?Nllkak0xcitLRnlXOW9rOXliTy9PVkxVTVFkQk00UzJLZ2RiQ05WVXAzSDZY?=
 =?utf-8?B?eXNuQUUyT3F1VmdnclRLSkVTYzZJSFhMeEZ6b2lQNjRMUUZuY1pmNlN6UGUx?=
 =?utf-8?B?Y3NhY0lYYlFOWEh1QzY2TWJYYXFkZGlITDBrVGhsdFIzb0FTeXQ0TDRVUFRN?=
 =?utf-8?B?WkZvek4yNm9HekNtR1JYc3JNM0NONERyOFYzdTVrNDlBOG9yK1d6di8rZGhS?=
 =?utf-8?B?enRBSlZ3QjNJWHJZUEV4THRFN2Rvc3BSbkpIYTVJdlBQWmcwQ2xleE55azl5?=
 =?utf-8?B?bzFhQmdXQW5ac29pdXF0SFRaWTdZRklqRGsxZXFVU0F3RnVBVGNTQlVvVmI1?=
 =?utf-8?B?cmFSUkZtUGVRaFVvU1NzR2VneTE0YjFTQmJkZERpbkMrQVY3enRvaFpYYU40?=
 =?utf-8?B?MHZZZ2RxUExDMTBrcWk1SUhyc05SVW1FOE9QSDQ1ZkhzR2hMc3owTDF2Q1k2?=
 =?utf-8?B?bThnOFNuc01KaGRFVTlrODlKVk84ditCVkRuUVFCRkRqcVNMa2VWb3BHZlk4?=
 =?utf-8?B?VFg2bGFSVGdMWEVsWkpQS0Z6UkhPL3ZvRXpReW9USVZSQVR5QVBvWnZCbGpj?=
 =?utf-8?B?dE94TldTaWplbmhJWnh2d1h0NS9jMGJIaVo5MHFzejZyUENxczNNdjFleXRn?=
 =?utf-8?B?NzV4bmp1bU5JLzBZWWFsc255UldXdGhubVZIa290VXZlNGNKM0dzTEUwN0c3?=
 =?utf-8?B?OWQ1TE8zdm5ydU5tNUhUS25PWGdRYWlTYVFJSlphaDFHRkVwbFlmQXp2ZEpw?=
 =?utf-8?B?TFF6WjFBQjBqVzR3R2tTMXAxUXZtSlNwazJWTTJJWWsxSzlrWkl4VS9ZYUxR?=
 =?utf-8?B?ckVKUmpzSDN0ZjhDUGxZUXFhYmRJbmkzdWdEWXdleG44cUpuWVBIZ0hVei9Q?=
 =?utf-8?B?a3RGb3NLMnJUNEpQUVhVOExRcVV2RFlkRmVVTUQ3V1JUclBIeG1YTU5QVm1K?=
 =?utf-8?B?TWVCWnhDQ3VGeDRWWnVxMkR4VU15WHIxYkM0Rk1zcmM2SFQyTXFja3dDZmtj?=
 =?utf-8?B?NXBoaCtvSWJ3WThTUjc5MGN3NG5uaHErMUx2ZE5MR1hJaFV4YmhsY1dOS1B4?=
 =?utf-8?B?TDNBWC9BYnV5ZmVGMVNXZkRCV2Q5eUMzTWl1VERCYTR2VFNMaUR5MjlzU2Ey?=
 =?utf-8?B?bmZCYUs3S29IeWkyYloxYW9TNUNHNVNTeTZJLzJXSGxlRTZIN3pncTZWNWxF?=
 =?utf-8?B?cHhUTC9EQzV5TCtmc2ZmQ3R3blM3c2JSTDFvZkR2OUNYN3lyMkhqQ2dsSnE0?=
 =?utf-8?B?SGFnNk5lR09IY3Baa2JrNGZteldtb0dWd3hhc1lteFJkNjVpY0FMQzhJdTcr?=
 =?utf-8?B?R3drL2FFRzZlVGRzaVR2SFVqS0lHZDdjYWc1Yi9Yam1pSlh6aWVnQUx0V0dZ?=
 =?utf-8?Q?ANgDyuD3F88l0ON4=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Edy+XVJpoUim4ENAUFAE4Es+PSb6+rbv6xfe9QxZA/s8MQmDQ95YDUfxFSmHWgJa3hRxrSiHYKuaocsRNmkI7Wt9eZIzBCIxz3nEQh0RVyFXGYWS14mUNPlxvs/NPuk3BG7weGWmMEJfkZKn5ltqFj6yiUN6mm8z8pd80gggNhoPZ64La03w80/ZbQgO+Y2kA+tZjC/xXqocS7M4YTSbdEH8qfkR+1hMjZJVdkCEzJXPPzdmcZzMxQMI7lDtngICbcrX7hLZyOtEP/j08qb3/+fb0FhI1yANI9CJYADSfOx0iDhp50uaL1uNNvlEEfXr0P3kfYXZvAKcCROSuj253Q==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5d7d61-9291-4c8d-aac4-08dec56f373e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 15:04:19.1462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DTMM18p83ilmg+bgFqWmaWWeH1Xx1Lzupf/M5QYhZ5A9HwQ0KlMbOHr7TX8OcxI8n0Ys3JcfgMDfJBAdaAWYi3znHN4+pXZjkGwgLoz68Vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10112
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Du9pOQaOcKbqxeJB-yg9wgO-kb0rBjXlh9Xy5JZAiyk_1780931062
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296625-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:Parthiban.Veerasooran@microchip.com,m:conor@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,onsemi.com:dkim,onsemi.com:from_mime,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15B846583C9

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCB2MyAyLzJdIGR0LWJpbmRpbmdzOiBuZXQ6IHVwZGF0
ZWQgaW50ZXJydXB0IHR5cGUgdG8gYmUgYWN0aXZlIGxvdywNCj4gbGV2ZWwgdHJpZ2dlcmVkDQo+
IA0KPiANCj4gPiBJIGFncmVlLiBXaGVuIHdlIGNoYW5nZSB0byBsZXZlbCB0cmlnZ2VyZWQgaW50
ZXJydXB0LCBjdXJyZW50IG1lY2hhbmlzbSB3b24ndCB3b3JrIGFzDQo+ID4gd2UgYXJlIG5vdCBk
aXNhYmxpbmcgdGhlIGludGVycnVwdCB3aGVuIHdlIGhhbmRsZSB0aGVtLg0KPiANCj4gSSdtIGtp
bmQgb2Ygc3VycHJpc2VkIGFib3V0IHRoYXQuIElmIHlvdSBvbmx5IHByb3ZpZGUgYSB0aHJlYWQg
Y29udGV4dA0KPiBoYW5kbGVyLCBidXQgbm90IGEgaW50ZXJydXB0IGNvbnRleHQgaGFuZGxlciwg
aSB3b3VsZCBvZiBleHBlY3RlZCB0aGUNCj4gSVJRIGNvcmUgdG8gbGVhdmUgdGhlIGludGVycnVw
dCBkaXNhYmxlZCB1bnRpbCB0aGUgdGhyZWFkZWQgaGFuZGxlcg0KPiBleGl0ZWQuIEJ1dCBtYXli
ZSBpdCBpcyBoaXN0b3JpYyBiZWhhdmlvdXIuDQoNCg0KWW91IGFyZSByaWdodC4gSSB3YXMganVz
dCBoaWdobGlnaHRpbmcgdGhlIG5lZWQgZm9yIG1vdmluZyB0byANCnRocmVhZGVkIElSUSB3aGVu
IHdlIG1vdmUgdG8gbGV2ZWwgdHJpZ2dlcmVkIGludGVycnVwdC4NCg0KQXMgeW91IGtub3csIHRo
ZSBjdXJyZW50IGNvZGUgZG9lc24ndCBoYXZlIHRocmVhZGVkIElSUS4NCkl0IGhhcyBJU1Igd2Fr
aW5nIHVwIGEgdGhyZWFkIHRoYXQgaGFuZGxlcyB0aGUgaW50ZXJydXB0DQogDQo+IEFuZHJldw0K
DQo=


