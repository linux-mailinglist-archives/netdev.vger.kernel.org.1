Return-Path: <netdev+bounces-302977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DMnzG/NaQ2qyXAoAu9opvQ
	(envelope-from <netdev+bounces-302977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:58:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8816E08D2
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:58:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=PGYfSICX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302977-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302977-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40D7D300B9EC
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AA43DFC62;
	Tue, 30 Jun 2026 05:58:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB31DDC2B
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 05:58:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799087; cv=none; b=EhqpH1lyJHhKXaMBxQz3ZoMn06wYLCkQagPaQdhEIBs00fF4IKSGg7IDfAMHcfHAemtHuwPrG2pcMMvOWkGoYPs62uRkEUSh8A8eqwOum4sTyf5O5SJ6Y2r7mZcDf7UH03ESKBQwN7DbPHswmu3jtOE4f05AAwc1DIsNjK8w1l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799087; c=relaxed/simple;
	bh=U+LQiCIKgIIT8rsKexgB9f8o7RERxNl+APXSHVZf9Wg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=E6ZTXBdmgrMneXrt8Ypks+QK9Et1RsYZ1SkkWi9r+C3IMWIHIU/l6Ukh2q0Xt5hpgZhb9YLsgstQUXrxn8yWbtdZL5hql8zIZVa4uL6YF0v65UatV/pFNER6Gl2rbA7J6aD3selV+FpoFTNTBYrSW+QzMOgEDjHqUBye+WfDfmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=PGYfSICX; arc=none smtp.client-ip=170.10.151.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1782799086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+LQiCIKgIIT8rsKexgB9f8o7RERxNl+APXSHVZf9Wg=;
	b=PGYfSICXkEKt8ZBPETVT9bIE5JKT1QtV9KctuNkRdK3CXCLj+05e3YpXMiHIMDOZ4byU4d
	AGmYCT2W99WV61nCufs6u2+21ncsLmX7vWP6wgX3sL84lRUAOAmLSOxHNyFhjdCuA+8Ggk
	UnH+wsl4gbTJiQaIm2KJ2JsUVRWX6/HlMCIgrKzAA0xcsG/asB1cA0szpWGNqGH+Hxei2F
	VozK2BlCu/87kMpQ323ZMT74RCu5j5nKa9Ijwv2YMEV+TBNIruNZmkZJLUAGYbToNldjB7
	Bhgb/luHP5tymjg0t/ybTCqYTSVsD3EJ/GPU0VvK3wVcjce0fESZax1TcRcQBQ==
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-69--L6ceBvbNv6h-gpInuIrVA-1; Mon,
 29 Jun 2026 22:58:03 -0700
X-MC-Unique: -L6ceBvbNv6h-gpInuIrVA-1
X-Mimecast-MFC-AGG-ID: -L6ceBvbNv6h-gpInuIrVA_1782799082
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by SA0PR02MB7257.namprd02.prod.outlook.com (2603:10b6:806:db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 05:58:00 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0159.012; Tue, 30 Jun 2026
 05:57:59 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net v2 0/2] Fix to possible skb leak due to race condtion
 in tx path
Thread-Topic: [PATCH net v2 0/2] Fix to possible skb leak due to race condtion
 in tx path
Thread-Index: AQHdBYF1dp5jUpnr70OodkVPlIeiZ7ZWmkQAgAAFWEA=
Date: Tue, 30 Jun 2026 05:57:59 +0000
Message-ID: <CYYPR02MB98286358AFA882AFDA4F2A4683F72@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260626-fix-race-condition-and-crash-v2-0-b6c5c10e604f@onsemi.com>
 <d3d382c6-5ae4-486f-89a4-885584d863c4@microchip.com>
In-Reply-To: <d3d382c6-5ae4-486f-89a4-885584d863c4@microchip.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|SA0PR02MB7257:EE_
x-ms-office365-filtering-correlation-id: c007628c-9782-40a0-19ca-08ded66c8a49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|4143699003|11063799006|5023799004|18002099003|56012099006|38070700021
x-microsoft-antispam-message-info: YesPRDmrr0cJGft3GmfTdXzRsGZWgcGNoh1PTQu7sR7GrnP/QC+5w1pHT5AwjzVjZFw0QMRwhREvlisWsJcMFfHsnclIwhAqXPyeG9WLg/yxH38ztty9LnhtWl5fSu5CnqL/xfvUclZ54vOUzeopG2ZboNgUHU+1s69t1AscOzfox3CBunMexZ535jvWX9o0Pk64lIEi7032HiwYrfInvFGxUDZSt7y94wd5QrnNCoLMNysQoNv3jWx4qo/JzV/DasLBWBUNLsE35Sc8rAGXhRSyqbARntQg/rKHC13Dd1dfgORVQFW9hN5wVBAVuuXrU08cdKClHg0uGLnF6fGbTWdrT3cq4LwIVekb4Z5mVYxtFf0eDXlpnIv+WM7cvMb5taXkruxtPtLKfaSnVvY1UDva83ziMbmYPKHTN0qkfO0Abb+4NU7k3rxZ9yM4mgJpYRFktrZ9F5LvFlJ0+usa+z24RFGG3W5KaUYn81xLbYFy61tWPM1YCIt8NxkjY2dDDXwRjWEP47SCUUfJN0RAdGiBgZt7I9yDkW0VkEmYoQZ1lBrsBDlagtFneTmo5zalPpfKSagaRjhqDFOQwyKoZQDk673gMj3bypIQ4HqbIQ5VWSANpzeyA2nth5qXF0O/jByaUO2ugN+ScnrD3G8S0mYixj6GOVZKROzNLOt3VaJ3yBdAp/vpsWFJ2i9RdhRWeeHmFLap7fRsgk7JNTFgshDUtq4kMKdzVJ9rjsVLARk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(4143699003)(11063799006)(5023799004)(18002099003)(56012099006)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEh1aXNyTFY2OU9IUzcyR1ZEZWp2NUhIbk9CQ0lWY3RudEJpOEZwK1owbjNN?=
 =?utf-8?B?ZDRZSjgwSUVCd1NDWmFBTUVxbjh0UExvWVV4M3NWL1BNZVZidjF2QUprbDZy?=
 =?utf-8?B?amVrUkYyekQ0dDJra21CQXBEV2NzbjhZSmJQZGpjN0hreWNWVHQ1YWdEbG9C?=
 =?utf-8?B?a1NWUnBjZVd3NmpWZGVMS0g0aTIyNjZKaldBWi9NUGNONXJ2TlJDQWpYRWJ5?=
 =?utf-8?B?VzFud3ZyLzZBc1RDZHlDQU8vT0U3OHdmVXl0YzhpYTRtVFZwNGs1aEd6TjUy?=
 =?utf-8?B?VTREbXEvZGZNcXRJeVVxMmRSUTQwcVNZZ2JmblRIN3o1OURJekYvOGExUjlC?=
 =?utf-8?B?bjd2UWN6STFKK1dDeDQ5dzIwMmlOai9JZlJtd0JwanBlQlJuYjVvNkNzRTJz?=
 =?utf-8?B?dFByMVpDYXlocUZqRkdEQkNyNEdnbFNZc3h0YytLU2JHMUpjV0gwQk5MMUZV?=
 =?utf-8?B?NkgrSitRVjBzUC9OVkVXR3d2M0xTYUtwOVZWWmgrMzlUSGZtZ2JUWUkvUkxh?=
 =?utf-8?B?aXpXK3FkbTU2aUlNMmVDYjF4MGUyVFpBZjlMYXBDaFFWQTFsRGZKMVRqbnpt?=
 =?utf-8?B?ayszcFVNY1JCRFNlSUlUdFhWUGhud1B0L2pRK21LMGRWei8yTHJucVgvTWxP?=
 =?utf-8?B?OWJIWkwyOHRBNGxCbHgrSUcvRW91TlU4amVlZWU4Wmc2aGpORHY0SzB1STVZ?=
 =?utf-8?B?aDRUR3c4Qkc5TDYrSDBxR1hwNHhiWTNWNEFZVStUSnRwdXJweTJSRWx5Q3ds?=
 =?utf-8?B?cVRQem5OT3RSUjdGYmNHN3J4TUFENmZ1KzhJQXo0TUoyUUxZeVBoT3dZMHQx?=
 =?utf-8?B?TTFUTU9WakdTUEJpRUZEZXpvNS9xcnpEczJKQVBnUFF2MjQxNWdJV0dXaTdq?=
 =?utf-8?B?SGNlUXU3elpBSDVQTVU4bHM0Yjc2Z3hRNm9kdC92cWxjMHpYWGh3ZElOMU96?=
 =?utf-8?B?Q1d0RU5jSU1uQnhsSUY3Q051dEFkeEoraXRUSmh3Yk5iQ0QwNmlnNitLWG5K?=
 =?utf-8?B?VDh3RC9jNnlBcEdtUkdlbFBuY0dUYXRhMWFYT21Hbkl6VmIzc3VHWW1EaTlj?=
 =?utf-8?B?RktBSy82TUJJWEFYZVZOVHhOajg5OUpsc1IwdDVSVDg3SEJQaWFoQ1lYMEU0?=
 =?utf-8?B?dmU0QWhXc2VmWU94YUNiamVMVDFhc2Y4bCtxdTVNMlJSSVdyTFVmS3FFeEpE?=
 =?utf-8?B?ZThNQTNCV1VtZ2ltdGkrUUVuU2hrTUhMZlBPN0I0bm8yUndSRFVKa2UvRzQv?=
 =?utf-8?B?VXdzV2xkL1R3a3VJV2VDN014MjRBMWlYUER4RHNlcUdpbVUyZDJRakRGeUda?=
 =?utf-8?B?L0tPTzZFRFZtbkI2c2w4d3JJekZlREk0SjBKQlpYN05mTWZLL3dzaW8rYklJ?=
 =?utf-8?B?Z3BGeTAxZ2MvODIxVm1NUHFMU2VHaFQrQlA1ejZXY1NaWmNOZFdRdFJWV05K?=
 =?utf-8?B?a3Fodnh3T2xtMkhPM1hOamlkQ0ZrS3ZVRWZtQldDNXFBRURGckFCRzFOYVZF?=
 =?utf-8?B?VEpWTnJtYXVJS3hDVER6SlBHOWgzYmRlSWRtOFlOelJpaEI5SWNFQzN4RHJh?=
 =?utf-8?B?Y0c4dUE1dEEwb2ovNlJyT25NajhreWZnejZ4bkNwL3g1T0t0UHNVd09oRGd5?=
 =?utf-8?B?ZnRjSTR5SUVVQXNUK1pQZW5IMG84SkhFZXR5RmxiL2hXMVA1alEzWlRKWVd5?=
 =?utf-8?B?REZLQmNDL3ppZ2NISzhzOG9lWnlyWjROMU5zRkhWMThxVVhCbVZEOEh4WnZZ?=
 =?utf-8?B?Y1hNSVArRjcybFFza3M1WDZuNDFWY2tPa050bjllZlQ2Y3BQUTcyck5KRXJ5?=
 =?utf-8?B?ayt3Z0NINE1MdkVsdzk4Sm1XRG02bi9xNFZ4SkpudVhaelEwbm1kL3p1Ym5w?=
 =?utf-8?B?YVFzWkFqcnc1aDlXTlBjaDFnejlEaEhZbG1veWhJTG5QcUQ0eTB1TEVCNzRO?=
 =?utf-8?B?ZUhKcUI1KzV5ZXY0RWhqcVliR1Q3YTlsZ3d1RmMxUWI0RnVxamw5VFZJZzl6?=
 =?utf-8?B?WkFEczF4dlhEbm5wOGg1d3NPblhBQjNPd1RsUzZOQlFDc1QvMVpreEFPRnlK?=
 =?utf-8?B?VzhnSEtMKzRjV1Z4ajlpVXpQV1k5RGNnemRHMHhJMGJKUUE0YmpWeHYrYWdZ?=
 =?utf-8?B?WlJVVXhwY05zdEdYcHp2K2tPK2d0eFI0WWJsdG55V0ZjTHd3YjJWTVE3ckZD?=
 =?utf-8?B?NWpReWFZRFhHc3ZsWGZrRjhqMXBSVy85bW5CNFBlSjZKY0tGWlJHVVJQcFFX?=
 =?utf-8?B?MjZ3NnNhNjB6dlgxWFN6SGZxbWlDYzhVL2RTMkFMbmMwRERsMktJNU10ZFdr?=
 =?utf-8?B?NHBJbSs5V0hlSERtQkJGcG4xdjh6ekZONUNPT1pLSEZwMzFyZ24vVGhHT202?=
 =?utf-8?Q?etmaZi9R7QEzjzsk=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PtSKXtH2aITReHMcqY8MPUbrS6HDjMgfhYjmlpiDAvgL0M3W9lUuotdoJoMWAZ0AtRo7xmwdHJ5AapXegiHTXkJSvmreHuU9NScNf3jJu7V8uaFWzUjBIaAuJ6dTGCfEz2jEqj6x8faXqhlwZAzCRqP43mT3gNaADF0GBg1suIUPFD62mdUV8sqS4itgRPjhOuUAB4tn8h9fJzUB87XF8x48G+pvcFfvJT1yPnByWDslxSflhBwitL5y2CY00QmiKGc3xWLzfzaE4itUA7Nmu0p2FFfJaoN6f0FWFgfbwshCaWIw8jJ8cB3sGT0h0a8dFknTelHeudYtvgEzZcGiiw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c007628c-9782-40a0-19ca-08ded66c8a49
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 05:57:59.7518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qcZi71Vuj5Xhduc3MHOhCJCdK/EUKMJjxTNgqBwZBmjNuehXfIVwds5lgILdQMiMLSf0O+OlkKAnIgvwpiRGcwtiq9JZGXFfxXLTI466So8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7257
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RMc36gVhpU5jg2bQt4GPWUFComAPFx08nf8d_XxB-0U_1782799082
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302977-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Parthiban.Veerasooran@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:Pier.Beruto@onsemi.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,microchip.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB8816E08D2

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYXJ0aGliYW4uVmVlcmFzb29y
YW5AbWljcm9jaGlwLmNvbSA8UGFydGhpYmFuLlZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0IHYyIDAvMl0gRml4IHRvIHBvc3NpYmxlIHNrYiBsZWFr
IGR1ZSB0byByYWNlIGNvbmR0aW9uIGluIHR4IHBhdGgNCj4gDQo+IA0KPg0KPiBJIHBlcmZvcm1l
ZCBhIG9uZS1ob3VyIHF1aWNrIHRlc3QgdXNpbmcgdHdvIGluc3RhbmNlcyBvZiB0aGUgTEFOODY1
MQ0KPiBNQUMtUEhZIENsaWNrIChUZXN0IENhc2UgMiksIGFuZCBpdCByYW4gd2l0aG91dCBhbnkg
Y3Jhc2hlcy4gVGhhbmsgeW91DQo+IGZvciB0aGUgZml4ZXMuDQoNCg0KR3JlYXQuIEFwcHJlY2lh
dGUgeW91ciBoZWxwLiBUaGFua3MNCg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IFBhcnRoaWJh
biBWDQo+ID4NCj4gPiAtLS0NCg0K


