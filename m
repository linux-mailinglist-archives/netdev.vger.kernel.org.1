Return-Path: <netdev+bounces-306294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u5qxLQW8T2runQIAu9opvQ
	(envelope-from <netdev+bounces-306294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:19:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0233A732C0B
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:19:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b="id6qN/ys";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306294-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306294-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20B413129C33
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 15:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368FB357A3E;
	Thu,  9 Jul 2026 15:03:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899AE23D7FB
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 15:03:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609386; cv=none; b=O8KsiYp7Dm4ExXeCvpeYkfkXbKmLCMyFdWWk7dWaeSQiTd721GVLMzuX8rGLve0vHAxLaMnLOYjwEDxu0fI+Ltu+RlEwlyaChKPYWMAsnNO7EIXUjCDcT50o6tTumUmcP1/lBEqtwQLZKMhHH35tXZjcXu/0OQYgVMpBiP5kvsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609386; c=relaxed/simple;
	bh=b+7gt16ss+1aXCdimO3zYtlkRqfM3eem9aodXMTqg5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=YSr0c13SquHtyvZzE+108dhthIZsrB8wwq29QzeLz+QIXjKn3gbzdOQVATllJTcVzO7ZhEDOouhVycg5Iq5b/99uyIF0uJyl6jPU0bhOJQV93pP2ATHnMLQGDSuCHeWZqgWRO1i23N3jDL1quIo+3Yx3Vg4A83nVKGeGme4zzAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=id6qN/ys; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1783609384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+7gt16ss+1aXCdimO3zYtlkRqfM3eem9aodXMTqg5A=;
	b=id6qN/ysBShcPAW9AOY+f3SjIk1WtOK05kADTNDfvOZDl0hMFhaiKvamuJC1XyBHhggUpA
	7hd9it9xeqyOj8Kcfdfji3ODf9pUA/x6keNS/0symrXfpAxsTLPZudyus1M6oQL83Vcsf9
	/0BHp0MGE4LOy7t/J9M9usETr7knDX8gTtKIn6TRdO0HD90EXPeKg9Sf+lh2ecVMIF3COD
	5bRo+hvEUoQOtQbEBfAKyhsQOQpCnWtkLuXAlxOCKi3D5ywK4Jbb5TDbZcpiuPhD9e/krj
	6YlsQxk9NavnrxkuepoVmwvS1hf5cE0QKRgnIDpRyJExhQAYwrQffl+euDnUQA==
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010050.outbound.protection.outlook.com
 [40.93.198.50]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-32-Wm7kqzisP0WutrOUEJrjjg-1; Thu, 09 Jul 2026 08:02:56 -0700
X-MC-Unique: Wm7kqzisP0WutrOUEJrjjg-1
X-Mimecast-MFC-AGG-ID: Wm7kqzisP0WutrOUEJrjjg_1783609368
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by PH0PR02MB7176.namprd02.prod.outlook.com (2603:10b6:510:1d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Thu, 9 Jul
 2026 15:02:45 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 15:02:44 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Richard Cochran
	<richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jerry Ray
	<jerry.ray@microchip.com>
Subject: RE: [PATCH net-next v7 08/15] net: ethernet: oa_tc6: Support for
 hardware timestamp
Thread-Topic: [PATCH net-next v7 08/15] net: ethernet: oa_tc6: Support for
 hardware timestamp
Thread-Index: AQHdD5DdBz2+4L1RLE6n9UH5TdAjtLZlSDqw
Date: Thu, 9 Jul 2026 15:02:44 +0000
Message-ID: <CYYPR02MB982841173093F85A04D3DF4B83FE2@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260708-s2500-mac-phy-support-v7-0-478c877aa1a9@onsemi.com>
 <20260708-s2500-mac-phy-support-v7-8-478c877aa1a9@onsemi.com>
 <4a847a6b-7837-4044-8a87-0ddac47725f8@linux.dev>
In-Reply-To: <4a847a6b-7837-4044-8a87-0ddac47725f8@linux.dev>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|PH0PR02MB7176:EE_
x-ms-office365-filtering-correlation-id: effb33f1-8911-4fdb-5969-08deddcb21ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|56012099006|3023799007|11063799006|4143699003|22082099003|18002099003|6133799003|38070700021|921020
x-microsoft-antispam-message-info: 2FYgo1LzSRfjkkI9fySRtfD8barDQZjqpQJmcRyL3REhrzWvRBmcm++cf6hmdaKgMhExtIEHe5TrQgVvSpMrHMHEPgnmkyZs5kRWajMA7dqDClfyS5bloTSJSeIkwkYk48UbanB5vicL60pUrgFWcNC4ElF2+6k45OAEG3ry5PYpXLKI6JaxEMC6ZESwAeqn9+93INBkaBsMSVtk5/825A//Olp9fHWXNhA2Y3ZQwG5wJ/vzDnoVWsJS2jvFyqw2sh6RlLAwzRkyPBiQe3om4LJdvY/wA+S4HCMqyuthRRWp+O/SCpl7qyC0tlGMJj4n9SaLvS0GCR+nUIZup8Do6InIqsMN985lpBS2Byp2QcEa2MOMXw3KDyjJitOG0SGaPgdLRQlqswbZd0MWdvm6z0qQ+VKuuIgJ1mM7/mLb1v9GhVCegFuRCHTUGpaaCQPjeYnpPnJixTTvftvCBp2nkWCHq8sACkEN5oA0Y2kIbH9lFM62x3S2+uG+pZEeFAmb23p0z1yxCaeTxfwF/TwgAgO/LoDm5ip6DcUbOrQVd49tr0yvDM+shB9Pz5mmEfnz9XRAOPV2K/8gujxMDCKMli2TBp+9Q4Ht45KM4U6CF9XinPJHGAN7X98XkXr8KIWNr67EXideuNyLSOYzExoxYDrjoZZaumdF54Nq7z8u+2K801KRXKzhFzhsoK4DLvLNqD8VxP6JunHlX2sX9QEv2QO9guNMshnqI/qAjhzFez49yDjN2zYIgKCagY/dDUQb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(56012099006)(3023799007)(11063799006)(4143699003)(22082099003)(18002099003)(6133799003)(38070700021)(921020);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0JkaFZKM2pmMHMyM0ZiM2NoT2E5dmdqWHZmeUhrRXFFWVJhVGhNdWZpamcz?=
 =?utf-8?B?Y3A2enFmaE5HNnJiUkJSOGlEa2dabDRkWnRRL3NNQ3BLZ2hvWU1zU2FjL3Js?=
 =?utf-8?B?djV5ZWxHM0xwRjA4Wmc1T1kyQ2hNaUlQQWlEV0R1NDd5clc4QmFlR1hNWGJG?=
 =?utf-8?B?bnBxVWZsd2pnWHNHY0FJRHBRN3V4YlZDcVQ3VDZuVW9wQ2EvbUs0T0tVYmZ4?=
 =?utf-8?B?bHZLSVJSeTByMUliZGtpejFEOC83VmhIQjNRN2t5QllvWjhpdEUrUmRtcmJp?=
 =?utf-8?B?VHNkVGhUL1hYUWpJQTVzS0luaE9CRXFkME5LMUU0d2d1RHpOV3BLTWxXM3lH?=
 =?utf-8?B?MFRqSEJqbTJaTFFpQnZhOElLMlNJWE95aDV5VUtWejFTa1BtMDJUUXVxWDZS?=
 =?utf-8?B?d0hhOTdmdThVYmxxVTE1eVlxUlRCMDVQT0Q2OEI4TGIza04vZFJNVWU1QnJB?=
 =?utf-8?B?SlhOeDhCc000VkFWdllWL3ZLMGliMloyVE5sTWdrcmlqL0VCWTFxRzBoN2V6?=
 =?utf-8?B?ejl0c1UxV2VqWFd6dzNBNFBjbVhwclZRRWxVUDV2OUcwQ2RRUnVWZnFqczhF?=
 =?utf-8?B?eFFFb2VmU2syOGZLZUFELzRrM0N1NzdyY2FiWHAycXNPMWRvMlN1REUvRzZF?=
 =?utf-8?B?UiszbjgzT0pxaDBQaEd6MGRYRVB5c1BmOE1sdmxHOGdRd0swbVJRNm1Ld3hI?=
 =?utf-8?B?YWl6SVgrZytrZ1RXeHB5U2NMbjlaZ2pmY2trdXRUTGdPeWZ2YWdFdk90bU9X?=
 =?utf-8?B?YmxLTEtEVHdIRXRGbCtaRjkydXNoK3FxRDI5ODFrQU82czY4R3hzZVhUTldE?=
 =?utf-8?B?bEc3RXQ2Ukc0NERJdDhtTGhyMi9EWFp5VWlSNyt6YUU0N2xnV0I4a1M1TmxG?=
 =?utf-8?B?K2Y4SmluR2ZndEhMTiswTWR1YzlibURYYm00ZWJxVkFhbDA0NTNxMStlYjhI?=
 =?utf-8?B?N1VXTVFvcnhxa1BoR2g1NEkrQkZML3lhc1BNNFJsZGFML01UamlBbnJmMlAx?=
 =?utf-8?B?eE5oS2tZUWxQMXdQK29VWG9MdVVndVJxNUVSTTJPZ1dOWC9OVXdGSjVYalQw?=
 =?utf-8?B?N2k1WFNYSzZwS3IxSWR4Qm9sa2lLeFRFYU8wc3RCZmR1QzlldElQMzRBK3NL?=
 =?utf-8?B?Tm4wR1VXeTUydEl5TFBLb01uMlYzQjhtZFFWa3Uxc01vRlk3Y2tBcGs0RzJ4?=
 =?utf-8?B?dnRRQ2ZGNUJjTXNHYWVTaHFyMnIrV3A5VnhrenpsWC9mMlFUZTZOQW83S09j?=
 =?utf-8?B?blhlSEYxd0xYdS8rc2FOMGZsT0FLSzVCb21jZlJOS2FyR05PamhzeHVReDA5?=
 =?utf-8?B?RFBUUzMwQjZ4VmhISWtUVVM1UzY4RzNjRUxMblBKZ2Z2cHUrd2hYVDExemZ0?=
 =?utf-8?B?Y0tRMXNHK21CUERSbkpzMHBwZGdnbmtkWGxjVloyRjhvQXErdzJSa2JQcHFB?=
 =?utf-8?B?dGszLzRYWEQwU2QvTTRZbS9rYmlGZmhZMGJJTVNaTlBFeGdSSnFCWlQ3OEFK?=
 =?utf-8?B?WXhBUFVGaWM0a25XQ1pKR0lKQktPb2gvbUhaV1NLcHA5SGVvL1N2clBPQ0pO?=
 =?utf-8?B?KzJLYXFvczRFVUREL2xrMTNKRGhobGVDOTVva25VMXFoMjFydFlwL3Q2S2FL?=
 =?utf-8?B?dytFVHozRUc3RncwVVkyZ1BvRjV0OHBPV2dsT1ZseG1STnJ0a1I3QjdEWm5D?=
 =?utf-8?B?b0c5MmlwUW5KKzZ4cVBZYm5qMW9pNkRLZTZXak1QMGt4Q1A1NmxQYnpzTG1U?=
 =?utf-8?B?bGJqeU1JcEpGTktCT0gramp4U3FSeXUxRVhOV3NlRHJXL2VnZjh1VmJ5RDdG?=
 =?utf-8?B?cXZxbkZGSmx5Q3BHZWtUaEhuRnhJYk04NDg2VklJdUZObGNZSytGNjc1eS9w?=
 =?utf-8?B?am1ROGZIWVBxT1lQMGh6Q2tkMDZVeTdUNXovR3FHUzVWRGV1T0RVRHE4S1ZU?=
 =?utf-8?B?QjBraFNGaEtEeUZsNXRUc1B0cnhVQk9BcnBPU0VldHhVei85R1c3SnZoRFRV?=
 =?utf-8?B?Smx6eFJiQzJLZlUxN0dDNVBYS21Yai90R29QQ0lDN2hGcTlvUWcrWEM4MXU2?=
 =?utf-8?B?Mk1pd21CUERxb3VVbURza04zUGt6algrYXZ0VVFRQ1IrY3dlOXo3dmU5U0JE?=
 =?utf-8?B?VEJRT2lPdWd0VkE4aDBOZDJvZldiSGFoMEFPQVpoRGJLSlFkZDQ0MWU4V25o?=
 =?utf-8?B?ZUU5YUNxNmVxekxoM1ZxcFNUN0h6QzYydzFGZjlia05zc1pCRm1lVFlicHlo?=
 =?utf-8?B?ZkZEWTlHYjVReHNuanRndFdLWW1DTVlQUjFzdWdzZW0waGM3WlpsSERLZTg2?=
 =?utf-8?B?UU1kOHJYQ3F3RTlZZ3hwbWszcHVRK3djS1M3OC9DdU5rWlZPQWladz09?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TGD1p0HMxRuilVzhnP9nHonfkafy76n/9fhnwwo7lmu2gNwHfFM17UivhgUfNMeRB7R4yDcCtOqZ7940DZgJeFzROR0mjRu6TbmOEg+uTsEsBlbQZ140ScePd09q5/vLOS5Rk8rP+uVQeUj6F0OaJe5gbUgaLS+DjZ/yNwXwbAMB7DZSlwDh7oWx7tyRsDAHbn4fPM93eL+7IddMrHS9W6annesVWY9R1lVpVhkzUic5DfYUxAL9pIZqQDDZLeUzQabu9zWdxUhn/dVLPQvQwX86AxBP3Xspoby55+iNVKDYE2N5kC91u+AVtU3VtuaJg1ZyUZiNF/D2uvqvpY55Jw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: effb33f1-8911-4fdb-5969-08deddcb21ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 15:02:44.7884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GznbPpSVo5W+2TN5wP1SpAKNuXhMOAXwNL2zAJAJ3+zTmHDRketZAoZ6wrumtbY0KH/4LwqNurBwMy519KKEstOgyvJIzLVelE6/cfTiYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7176
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GYSI5Tcw1_4-i6voP9GE9gVsfZmwzYzX2ZlcQc5NuMI_1783609368
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306294-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vadim.fedorenko@linux.dev,m:andrew@lunn.ch,m:Pier.Beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:from_mime,onsemi.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,CYYPR02MB9828.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0233A732C0B

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWYWRpbSBGZWRvcmVua28gPHZh
ZGltLmZlZG9yZW5rb0BsaW51eC5kZXY+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDksIDIwMjYg
Mzo0NSBBTQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IHY3IDA4LzE1XSBuZXQ6IGV0
aGVybmV0OiBvYV90YzY6IFN1cHBvcnQgZm9yIGhhcmR3YXJlDQo+IHRpbWVzdGFtcA0KPiANCj4g
DQo+ID4gKw0KPiA+ICsgaWYgKGNtZCA9PSBTSU9DU0hXVFNUQU1QIHx8IGNtZCA9PSBTSU9DR0hX
VFNUQU1QKQ0KPiA+ICsgcmV0dXJuIG9hX3RjNl90c3RhbXBfaW9jdGwodGM2LCBycSwgY21kKTsN
Cj4gDQo+IGlvY3RsIGludGVyZmFjZSBmb3IgSFcgdGltZXN0YW1wIGNvbmZpZ3VyYXRpb24gaXMg
ZGVwcmVjYXRlZCwga2VybmVsDQo+IGNvZGUgd2FzIHJlY2VudGx5IGNsZWFuZWQgdXAgdG8gYXZp
b2QgdGhlc2UgaW9jdGwgY29tbWFuZHMgaW4gZmF2b3Igb2YNCj4gbmRvX2h3dHN0YW1wX2dldC9u
ZG9faHd0c3RhbXBfc2V0IGNhbGxiYWNrcy4gTmV3IGRyaXZlcnMgbXVzdCBub3QgdXNlDQo+IGRl
cHJlY2F0ZWQgaW9jdGwgY29tbWFuZHMuDQo+IA0KDQpJIHNlZS4gU3VyZS4gV2lsbCByZW1vdmUg
aXQuIA0K


