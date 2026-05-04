Return-Path: <netdev+bounces-284025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBTwJgf0+Gk73gIAu9opvQ
	(envelope-from <netdev+bounces-284025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:31:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EA14C3431
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9074306DEE8
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 19:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C54B3E4C8F;
	Mon,  4 May 2026 19:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="OaVlO9C8"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A964E3EF0BD
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777922523; cv=none; b=OlowIdeZ3t0LeWPFt3HqhwFI50ZPjAe4vML8Fo34NHh6ekMi3PaP8bun7Dr9lmyOj3nTGCidX5qxoSRMrq9AHtXbqmtzvLwa6y7qPJS7DkCxGXIfg866o9VWMNE1Mhq7chOQ09qQ2auGBiP0ibiMrfjPSUvKwaQK4PKlKgfXGXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777922523; c=relaxed/simple;
	bh=0bdmbpCP63HVFni9PAxa2cMUd3n6p0hn+OaLbdEb6h0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=fuRgF0R9fpU4b0nMA967a/0QpbcjtwZSbcbv/bQ1namdkSzfSL66S0dBDHWRtvRhT/FHSlt++6XBF2adoxhrDXNrb2dWpCTn/g+Si+53u69BJ0iQlQcse8r3gWujyMWe+nzS/3b0VrM2Y47TZrMVxh1JgStkra8d7x+p7Xa6XZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=OaVlO9C8; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1777922521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0bdmbpCP63HVFni9PAxa2cMUd3n6p0hn+OaLbdEb6h0=;
	b=OaVlO9C8oftjtj101CABCbw3/49jYMk/J9wqNBgNewPDd2Kje+SpOGLp6mV8Cb5CkyFJGq
	E6YAJNjv9upGBdDLfkM4CIZwZxLaMF3d59CI36iEWszeFbf4WjnEpWUWwCzDbb9YMMzw4V
	pOFWFwZx/N94RaPl+G/Q+ayVwhS2AfIlPtcQz8sNWYiooNBPNo+SgmcB6rFi6xn+PyIuSM
	HG3L1ENiaa+OIQZGQvjyIBpzz1yQ/dj5w9hZfkN1uBzdw15ZbrnAxgR9Zsj8tJgKka2XVk
	zZTGypeXnUMxbFPG2WlVTv0WmJAHTxMtMJTHiVLgvTOE5vaB+v5I8wQ3rlh+Sg==
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013052.outbound.protection.outlook.com
 [40.93.196.52]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-74-p_-gkFbZOG-LSrLoIIuKdw-2; Mon, 04 May 2026 12:21:58 -0700
X-MC-Unique: p_-gkFbZOG-LSrLoIIuKdw-2
X-Mimecast-MFC-AGG-ID: p_-gkFbZOG-LSrLoIIuKdw_1777922517
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by SA1PR02MB11291.namprd02.prod.outlook.com (2603:10b6:806:49e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 19:21:55 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 19:21:55 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 4/5] onsemi: ncn260xx: Add driver support for
 NCN26010 and TS2500 MAC-PHY
Thread-Topic: [PATCH net-next 4/5] onsemi: ncn260xx: Add driver support for
 NCN26010 and TS2500 MAC-PHY
Thread-Index: AdzZld+FrVHyslWiQ5KiIZOby61/UQAElaYAAJPFZ9AAAMRGAAAAD6yQAAAk+3A=
Date: Mon, 4 May 2026 19:21:55 +0000
Message-ID: <CY8PR02MB9249ABC8B96EFD3F1B4DF55383312@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB92494A5A16B7AF4EA3A69F2483322@CY8PR02MB9249.namprd02.prod.outlook.com>
 <12245592-fb85-46d9-9f26-5ed37efacbfc@lunn.ch>
 <CY8PR02MB92499BF412C31A04BADE609183312@CY8PR02MB9249.namprd02.prod.outlook.com>
 <5f07822d-6ea9-4beb-a222-58a94e4801d6@lunn.ch>
 <CY8PR02MB9249082A82E8E2C503D6773683312@CY8PR02MB9249.namprd02.prod.outlook.com>
In-Reply-To: <CY8PR02MB9249082A82E8E2C503D6773683312@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|SA1PR02MB11291:EE_
x-ms-office365-filtering-correlation-id: cb25c245-f162-4c44-bc3f-08deaa12675b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|38070700021
x-microsoft-antispam-message-info: mla5rHK4YFM9/7mPLdR9zdmphxjNrJ9Ee6FlRPTb2InDocZJ3c7/gg2PjXOS0v+L21Z6fCL/M0BkZFTKrrRic5pizNhgIYxnFkP7yrHZAVNYYcV17kP02kOBtJExJ5uw0gvvON+5fQIi8Ern5sDWDaero2L/UkLQqSCu5/W4iJnBb7LAiry4xIXIQGz/Mdoe/WN8CHDmqw6shAThbZ3tjbZJB7VwahxpcXvTh7wAcDqBxZXnHkR6rT37ZK+WRzaAE5h/YA8H4TETkstamV51ecFOsyNDO+xL5FgHdVaz3JwMZ0JbO0Y6EFSZEIhhsyAUcKv3KY+zTz724jNn89CBRcRwhz13Hot34HswyOuCrRMyzo662mn/Av+u+9yezih1soj6AiSZfeDW1z47o1taz4HIOEx7AXR0iX6dXIVyGic9mJnG/TkvvEKzUf19HMzxCmO724ApHiwNgSkc4IazzW9FGsEetNlJyXGuG4w2ImrHBmTmmoD5zLetRsbpN/9HdZkfHgJi8sowpH1EvYyi3bXehXOP7CmlFYhlhXSjGnMDYsPPaIjLpR70oC3DPEtTGId9ARtlEP3nZ3uwCUf4B39FEgOtXDhT257QX8OkCqYSX38WsWfDsf/xVhVqpkPjuWZkUphUSwzumKc1LghJbr2ZhRQnPNkbgoQlCDc8ti8B4HH8vqsqiScyW9RdrIgam8BNegvI91T5M4NIfRrj96FOTwu31CfllGfjcBvoIBOGPjTFobVn58i4EzD+oYDS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2FZQkdURVJqMC90dURVdUFWT0xlUEM3YVNNdmtIUDFIY2NGMU12eURJWEsv?=
 =?utf-8?B?V1E1akRSY014Y3ZwVHhjSjdLSkErMWdOck9wVm94R1FORVUxRzJYWk9oMkp6?=
 =?utf-8?B?RU9IRkhTYmp3Wk5QVjlRejhHdXBGN2JvRStHbWVvZEhSNHRBalR5cnhtS1R2?=
 =?utf-8?B?MmJDcm9US2FlcUxpQ0dLMFI4Y2N6aTd1b0NuSlp0WWIzNkJtYlFSZ3g4Wlhj?=
 =?utf-8?B?QW9uT3RYRVhvVlZSRzh2dDRzemh4d1BsUm9rcmMreFRtTUlWSlM3NHVKR2Vv?=
 =?utf-8?B?dTNTM1hWV1JuaFYwcE5RRjU2SjZBaUZjSU1kQ2QrWnVGYm9IQWJQVTA4ZExo?=
 =?utf-8?B?bEdWL3ZKdGVHQmtuRGZlYmdDZVF1S3REMTRNZmlaV0kzMkZjbTJseTdGejRh?=
 =?utf-8?B?UzhrM2htTnpvdVJxM0Mya2xYNzJDSWRkaFpEZm5HWXdCTXlnMm5pQWhMWGUr?=
 =?utf-8?B?dUhRM2JIckdlNHAvekFCeFFWZWtsdWYzZ0hJb1laYW15YkhMY1gxTUxxT3hY?=
 =?utf-8?B?RHpZZFUzR1c3cnp0QnlXMyswVnM3Q3JLVnhRcllWS0JWMVhTcXRCSGxnNnEy?=
 =?utf-8?B?NzA5Tlg4OEhWV29jVXZnRXM1cE14NlFHQkZuQWU3em5BaVNER28xQmFJTGs0?=
 =?utf-8?B?YTlpSXFKZFZHVEFuNnp4UjVPTUcraGJwTGFPbGdiRFgrd3dhUDRTM2xPMVFE?=
 =?utf-8?B?QjJzdTg1MXBDenBGWEpVaTF2bGREMGVEMnVYK3lrcjB3QmlXaEhzVnA4QUdG?=
 =?utf-8?B?ZzgwMU9PZ2tUTDBEZmJxN1hyM0Z3c2xIaHhYb2lXQUw4VXd0Qi8ySUJFWlBW?=
 =?utf-8?B?L3EvYmpMdDB5d1cvNENlN21kbkNSTUF0SjR5cEpwRlRwNFRjMEg3WnB4V3pm?=
 =?utf-8?B?bktwdWYxZjBiT29YQVhCVHVxU01tK2tieFRxTUF6SXBISmlldytjWitSQndk?=
 =?utf-8?B?NCtBUzdRMTFsL0pPMUc3cTBmSUJ2VHNYMWswNXNPZUMreCtUazRVSEltTEk3?=
 =?utf-8?B?Vk5SUlF0TkFIMjc3TUhPWENLMVNhOWFzRnpDYitHNXhJcmQ1bGRscHpxelFo?=
 =?utf-8?B?ckxMaVJqQXZDbmthOXMwemtrYW4xY2sxbGNtYWZ1Q0lPRzduald6ais2YVZV?=
 =?utf-8?B?VHJmNU42K1pEZ0pMaWI4ZTFtVFUzdzJyNkJpZ1M3UVpSY29HaC9vUENMcEJt?=
 =?utf-8?B?RWRENlcrTXluZERObFdzVEtiNS8wVlFOZlFTN096SEdkUXVDY3dsQkJkMnhH?=
 =?utf-8?B?VnVQZXZSWHljZVJSNlNMTW9xbmQxa1NsQkpiOHBSaTQ3T1VDRklZdDJINXVp?=
 =?utf-8?B?ZTYzdnJ0U2lRZTZHNi9kb0xaOHd6bUFqYnBUdVI1Rm9VcnUwM1FzZWdEb09U?=
 =?utf-8?B?UlpjdlNUMHZmZ1Z3QThDVHEzd2FSdEF2WXoyVEFCYVRpZHNWT0ZvdXk1UXQ1?=
 =?utf-8?B?MDk4eGJBN0xVNkxQdTVRa0QzWTlweDl2VWVJa25hN3djWDJqQno4NzIrOEEv?=
 =?utf-8?B?OFN0M1BnUnJ6MEZZeHVoV2xDbkYxa3NIcmRDVFl5Sy9BWTRmZUh1WUw5clBz?=
 =?utf-8?B?WmNqa0VNdFdBZGZsK0J2MWZPditGaVloVnlUendMRmtJMk0wdzJ4UHRGVFhO?=
 =?utf-8?B?M0hRd0J6MnVWNHJKaHRXZW1KcEc4VFVScExMd25oWWw4dHJGZXdjeHo0SVZS?=
 =?utf-8?B?SS9vZTVrU05XOG0rdktpQTBYbWZqWU5ubWd6d0c0RWtObDlVckloelhJMUY0?=
 =?utf-8?B?QnpXQWljekRqVS8vZ09MbXFsZ0FROHZheTRreVRjODlGdkY1dmJCcUs1T3Nj?=
 =?utf-8?B?TjUxVVRHRlJISlE4aVhZblRvQVBlVlpWMjU1WFdCQ002VU9lVDk2MTZVZTRW?=
 =?utf-8?B?WnJJR0YxbFBlN0UyLzFMc2FSR2ViZmlDZ1cvWDE3eUdwM3ZNdTBxQW1iSmJ6?=
 =?utf-8?B?WWpyMUlBWSs2ajBUQ3UwczY2MzR3UVlOQklzTXdjS3UxSmtRc29NZWNLWXFi?=
 =?utf-8?B?WHQvNFVvcTNxajRiMzZTVzRTWGFEQi93azhWdzFQUTlpdnMyOE5BajVtaVl0?=
 =?utf-8?B?Z1JiWmVRanVrTEpWZnBkUGYyTk5wYStEUFZlWktCT3lTQVRQd1A3RjdqWkMz?=
 =?utf-8?B?ODVPelRqNGxJWW9kcTdUdDYwaCtoeFlKV1N1Tkljc2VEV1hyaUdad1F0SStJ?=
 =?utf-8?B?YmFjaFA3QkoyZnlZTEJqaEF4S1BXR3JSdlIrSjZaZ3UyUkZUN0FaNGpacWt3?=
 =?utf-8?B?S3I0M2tDZVQwL3pLU3p2ZFRPc0lQRG9BS1g4OVNPcGZWMGl2elFVRVZuN21V?=
 =?utf-8?B?b0xnUGlUNzVVTUV1MDdxazZhY3BraTBHU2hQQmlMcUhmQ3UvamxBc045bWpB?=
 =?utf-8?Q?UDm598TVPNzjD9do=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EvR1Y1d1Y7SzLot4HI2Hgi1U4IJ+zU37nvsaK916JFw4JpzWOPB2+NHqAFFkTdSzhQVMTEXQy4vAjJyD4Q87egYXtPNHdmBVo5qBYYIYhgpY33+AyXjsE2iO+MIXN0VEtM2wAbQSCOpjbYUBe1UZBvINJy3LMI/YL6V1KErZeEsNdKf7ZcDcGMGNHyzW2IIEbu4deWhKeL4ACbuHfCR0B7v9VywiAb80wXifW4rYnv7Yrin5wCoGtmaBTS6kIlDdP2qF5Pu179jZanEh2CFpvNe5JKWChchQF2U2Ecy9QFEgCFm2OckimH0rAbHiy8NxMvebzr23O66fXf2N3J9yng==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb25c245-f162-4c44-bc3f-08deaa12675b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 19:21:55.3322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06GWheFZXcihd+naJBvwhQEIea+c/GIpPnNcLk/ZH14NKAJecFqOuubi78AvwpBNHL6fJJs2SvDPmVoK2lg1PZDg7SvsGeBUQ5UFuHGgXD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB11291
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: awVlssNsZ_wslWNebKq2zDim4pGuru_v6JFj1-h7YUg_1777922517
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: 44EA14C3431
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284025-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[onsemi.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,CY8PR02MB9249.namprd02.prod.outlook.com:mid,lunn.ch:email,onsemi.com:dkim,onsemi.com:email,davemloft.net:email]

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2VsdmFtYW5pIFJhamFn
b3BhbA0KPiBTZW50OiBNb25kYXksIE1heSA0LCAyMDI2IDEyOjE4IFBNDQo+IFRvOiAnQW5kcmV3
IEx1bm4nIDxhbmRyZXdAbHVubi5jaD4NCj4gQ2M6IFBpZXJnaW9yZ2lvIEJlcnV0byA8UGllci5C
ZXJ1dG9Ab25zZW1pLmNvbT47IGFuZHJldytuZXRkZXZAbHVubi5jaDsNCj4gZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVk
aGF0LmNvbTsNCj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIIG5ldC1uZXh0IDQvNV0gb25zZW1pOiBuY24y
NjB4eDogQWRkIGRyaXZlciBzdXBwb3J0IGZvciBOQ04yNjAxMA0KPiBhbmQgVFMyNTAwIE1BQy1Q
SFkNCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206
IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4NCj4gPiBTZW50OiBNb25kYXksIE1heSA0LCAy
MDI2IDEyOjE1IFBNDQo+ID4gVG86IFNlbHZhbWFuaSBSYWphZ29wYWwgPFNlbHZhbWFuaS5SYWph
Z29wYWxAb25zZW1pLmNvbT4NCj4gPiBDYzogUGllcmdpb3JnaW8gQmVydXRvIDxQaWVyLkJlcnV0
b0BvbnNlbWkuY29tPjsgYW5kcmV3K25ldGRldkBsdW5uLmNoOw0KPiA+IGRhdmVtQGRhdmVtbG9m
dC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJl
ZGhhdC5jb207DQo+ID4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgNC81XSBvbnNlbWk6
IG5jbjI2MHh4OiBBZGQgZHJpdmVyIHN1cHBvcnQgZm9yIE5DTjI2MDEwDQo+ID4gYW5kIFRTMjUw
MCBNQUMtUEhZDQo+ID4NCj4gPg0KPiA+IFRoaXMgTWVzc2FnZSBJcyBGcm9tIGFuIEV4dGVybmFs
IFNlbmRlcg0KPiA+IFRoaXMgbWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXph
dGlvbi4NCj4gPg0KPiA+ID4gPiBTbyB5b3Ugc2VlbSB0byBiZSBjb21wbGlhbnQgd2l0aCB0aGUg
c3RhbmRhcmQuIEkndmUgbm90IHNlZW4gYW55dGhpbmcNCj4gPiA+ID4gdXNlIE1ESU9fTU1EX1BP
V0VSX1VOSVQgc28gbm90IGhhdmluZyB0aGF0IHNob3VsZCBub3QgYmUgYW4NCj4gPiA+ID4gaXNz
dWUuIE1ESU9fTU1EX0FOIGlzIHVzZWQgYnkgYSBudW1iZXIgb2YgUEhZcywgYnV0IGkgYXNzdW1l
IHlvdXJzDQo+ID4gPiA+IGRvZXMgbm90Lg0KPiA+ID4gPg0KPiA+ID4gPiA4MDIuMyBDNDUgc2F5
cyB0aGF0IGlmIGEgcmVnaXN0ZXIgZG9lcyBub3QgZXhpc3QsIGl0IHNob3VsZCByZWFkDQo+ID4g
PiA+IDAuIFdoYXQgd291bGQgaGFwcGVuIGlmIGEgcmVhZCB3YXMgbWFkZSB0bw0KPiA+ID4gPiBP
QV9UQzZfUEhZX0M0NV9BVVRPX05FR19NTVM1LCByYXRoZXIgdGhhbiByZXR1cm5pbmcgRU9QTk9U
U1VQUD8NCj4gPiA+ID4NCj4gPiA+ID4gVGFibGUgNiBzYXlzIG5vdGhpbmcgYWJvdXQgTU1EIDMw
LCB3aGljaCB5b3UgbWFwIHRvIDEyLiAxMC0xNSBhcmUNCj4gPiA+ID4gZGVmaW5lZCBhcyB2ZW5k
b3Igc3BlY2lmaWMsIHNvIHRoYXQgaXMgTy5LLg0KPiA+ID4gPg0KPiA+ID4gPiBCdXQgY2FuIHdl
IHNpbXBseSB0aGlzLiBBZGQgc29tZXRoaW5nIGxpa2UNCj4gPiA+ID4NCj4gPiA+ID4gdm9pZCBv
YV90YzZfc2V0X3ZlbmQxX21tcyhzdHJ1Y3Qgb2FfdGM2ICp0YzYsIGludCBtbXMpDQo+ID4gPiA+
IHsNCj4gPiA+ID4gdGM2LT52ZW5kMV9tbXMgPSBtbXM7DQo+ID4gPiA+IH0NCj4gPiA+ID4NCj4g
PiA+ID4gYW5kIG1ha2Ugb2FfdGM2X2dldF9waHlfYzQ1X21tcygpIGxvb2sgYXQgaXRzIHZhbHVl
Pw0KPiA+ID4NCj4gPiA+IFN1cmUuIEkgY2FuIGRvIHRoYXQuDQo+ID4gPg0KPiA+ID4gU2luY2Ug
d2UgZG9uJ3Qgc3VwcG9ydCBQQ1MsIGFuZCBQT1dFUl9VTklULCBtYXkgSSBzdWdnZXN0IGFsdGVy
bmF0aXZlIHNvbHV0aW9uPw0KPiA+DQo+ID4gSSB3b3VsZCBwcmVmZXIgdG8gcmVseSBvbiA4MDIu
MyBkZWZpbmVkIEM0NSBiZWhhdmlvdXIuIEEgcmVhZCB0byBhDQo+ID4gcmVnaXN0ZXIgd2hpY2gg
ZG9lcyBub3QgZXhpc3RzIGdpdmVzIDAuIFRoYXQgaXMgd2hhdCBQSFlzIGFuZCBwaHlsaWINCj4g
PiBleHBlY3QuDQo+ID4NCj4gPiBZb3UgZmFpbGVkIHRvIGFuc3dlciBteSBxdWVzdGlvbiBhYm91
dCB0aGlzLiBXaGF0IGhhcHBlbnMgd2l0aCB5b3VyDQo+ID4gZGV2aWNlIGlmIHlvdSBhY2Nlc3Mg
QzQ1IHJlZ2lzdGVycyB3aGljaCBkb24ndCBleGlzdD8NCj4gDQo+IFNvcnJ5LiBXYWl0aW5nIGZv
ciBhbiBhbnN3ZXIgZnJvbSBoYXJkd2FyZSBkZXNpZ25lci4NCg0KDQpJdCBpcyBjb25maXJtZWQg
dGhhdCB3ZSB3aWxsIHJldHVybiAwIGlmIHVuc3VwcG9ydGVkIHJlZ2lzdGVycyBhcmUgcmVhZC4N
Cg0KPiANCj4gPg0KPiA+ID4gVGhpcyBnaXZlcyBmbGV4aWJpbGl0eSB0byB2ZW5kb3JzIGFzIG1v
c3RseSBsaWtlbHksIGFsbCB0aGUgdmVuZG9ycw0KPiA+ID4gbWF5IG5vdCBzaGFyZSB0aGUgc2Ft
ZSBzZXQgb2YgTURJT19NTURfWFhYIHN1cHBvcnQuDQo+ID4NCj4gPiBXZWxsLCBhbGwgdmVuZG9y
cyBzaG91bGQgc3VwcG9ydCB3aGF0IGlzIGRlZmluZWQgaW4gdGhlIHN0YW5kYXJkLiBJdA0KPiA+
IGlzIG9ubHkgTURJT19NTURfVkVORDEgd2hpY2ggaXMgbGVmdCB1bmRlZmluZWQsIGFuZCBkaWZm
ZXJlbnQgdmVuZG9ycw0KPiA+IGNvdWxkIHB1dCB0aGF0IGF0IGRpZmZlcmVudCBNTVMgaW4gdGhl
IDEwLTE1IHJhbmdlLCBidXQgaSB0aGluayB0aGUNCj4gPiByZXN0IGlzIHdlbGwgZGVmaW5lZC4N
Cj4gPg0KPiA+IEFuZHJldw0KDQo=


