Return-Path: <netdev+bounces-300957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5OZDEuLAOGpPhgcAu9opvQ
	(envelope-from <netdev+bounces-300957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 06:58:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D059D6ACA35
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 06:58:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=LrVy6cJT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300957-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300957-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4623430058DB
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 04:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A163546F0;
	Mon, 22 Jun 2026 04:58:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C218AE2
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 04:58:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782104286; cv=none; b=tBTsZBfYusQfApJMuVGb1bPIb11SUlx3FhIqcRKDmp/HpymsiuCXqtb1WzbZizWiAjkJoN4/1G/anvHDLqHtfcyHmFXE4qFCNW5eUk49MpiAHKB+txuFV7pUnnuoAC7AaSTHp0RB+3c0lF7MidWe6fpttk6c4VJv35reuHY+0kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782104286; c=relaxed/simple;
	bh=+VOnvNM60M+k2nG0gQTAkLl7v1Z0cr6JLAqlom+/SfQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=vFQtRiL1bfre2ywhg+HGQWnaYYnNm/e8gMkpiF4ZPetsaaNvSMDPVF6awE15cg2n2bHzmZRHE46yUaxSmJVijGkAqEtnS/mjbMCnyLSBv9UyOBxmQNZITBl5qlJIekZGT0wzPo+9mWH1EL9N46hyH6A13YDOCZEiQSKUSNCCqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=LrVy6cJT; arc=none smtp.client-ip=170.10.151.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1782104278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VOnvNM60M+k2nG0gQTAkLl7v1Z0cr6JLAqlom+/SfQ=;
	b=LrVy6cJTRrQ39u5daIcl9iP/pByZsNntGADiKBnZ6aLgxQZM3wHuYUlKlVUfRyJpSdcima
	cSiiYZkMYEeouImP1+RjiTIHTVeAuViwh10hRbhfncgfsqfTnUSrLXsVytPR0hV2kh4X9m
	hYpa9SA0uM+LtwEtyPMe46k0x4UQwmvN9e0g8aekQhY7Mfm/iJDTQg6M1mBSr5sNg8ChLu
	dwJchhCrmMl+tNQ2m2uf5WlmdMe6C068bDBTOu+Ep9SclCIyfupHi3HdFLDX99W7st660U
	PBwy32XEb9awtrlEi6BjwPZJESIekhZls5Pyszxb3d2FDlMWpVRdLBi+IcIkrQ==
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011053.outbound.protection.outlook.com
 [40.93.194.53]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-47-YZEFfmOwOeibgdoPXCgHgw-2; Sun, 21 Jun 2026 21:57:54 -0700
X-MC-Unique: YZEFfmOwOeibgdoPXCgHgw-2
X-Mimecast-MFC-AGG-ID: YZEFfmOwOeibgdoPXCgHgw_1782104273
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by DSVPR02MB11400.namprd02.prod.outlook.com (2603:10b6:8:352::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 04:57:51 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 04:57:51 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>, Parthiban
 Veerasooran <parthiban.veerasooran@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>
Subject: RE: [PATCH 0/2] Fix to possible skb leak due to race condtion in tx
 path
Thread-Topic: [PATCH 0/2] Fix to possible skb leak due to race condtion in tx
 path
Thread-Index: AQHdAf8aPq83HbcV3UqOsNuScoSl5LZKAqYQ
Date: Mon, 22 Jun 2026 04:57:51 +0000
Message-ID: <CYYPR02MB982876915421DB709301F59B83EF2@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260621-fix-race-condition-and-crash-v1-0-91987c2d4e56@onsemi.com>
In-Reply-To: <20260621-fix-race-condition-and-crash-v1-0-91987c2d4e56@onsemi.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|DSVPR02MB11400:EE_
x-ms-office365-filtering-correlation-id: 18c43021-6edb-401e-80df-08ded01ad038
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|38070700021|18002099003|22082099003|6133799003|56012099006|11063799006
x-microsoft-antispam-message-info: PPGBG/TWi4g9TdUOMksWkim1J8ObfIs5Q8A/OtkY0BFwE/prUPW7cDFBxE8/CX7DahIhje4WvqeicWshaiMik6t7SrWK+0U0+0/p7GOO3rtctWmYDCGfSAhq6i54Ye8fvyqu5qek2nkj8/iWHme5gZjLjf7iw1WWNS7ulctn7WucQfh8o0RypWk5M4hmKFK0lv9gBLUmRQgcoevsydANQhiuQes7WXHgs9PhXYIxYykjQcE1WbM5ky2MkZcRZi6Sm4SrsSoDd3PZXICiJiXTyaycVI0GVUmcPvwUrEdNFzmlVQ/AiszUdiEEC/j7XTWUncxDaQxTHQxlQaYSey21Fc1d+lBc4ZCrXdY9NmhUP7zgEkpu47s2pWhtRcwc+L0IfLhUKUKMZkCF6nZl6DACNAZGTvfplyxzLG6JFNVos3aKEKSRXe/Do+d7v3ELNmRETAvGyI9G3xdZQMAIhYf7uJ2Vubsk+bNCFcIE8PBaDs0/wVKoR8dwW9DYHN4XvHlEomNunzp1+scv2UhfyN4xHrcN14gzBzAHCrKBq8BcKHTAQTr0KIuCKWhGrY/n7XRa1j4O7gBQ0QpQUm58pVpCldG+JGSsMDzOUBHiJz+nOlwL+2g0Qw/2PUChP2xrb7qxPa1XHUcW3tEr7NDdXccLyb1ZSFI5DKq6JlfQEyVEWqo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmRZQzFteHUvSmk3TnljdzNBb3pZQlNHemRWYmw0dmYwdVFRVWFKbEYyNDlE?=
 =?utf-8?B?bW5ONDY2bG8vMDh5RGNuNmJrL2syQnNKc2podkJLWUkrY3l5eGJCTFJyRDJv?=
 =?utf-8?B?NDlmY01MQ1gvM3BuMUtpazJUMkl2cXNMcXlRb1R4QkFaNU1vWTQ3S2VLY3c2?=
 =?utf-8?B?ZnlTWlVBVmZEMStzWE9Qeld0Zi9CVFBTSS9QSzVMNTdQdGtHT3BjR0pwM3Bp?=
 =?utf-8?B?dzJOdnN4cU5VTWl6ak9HeHkzRUJmSVdiV3htb1VXcjluczU0MGE0WDVRQ0Zp?=
 =?utf-8?B?RFBvTkJOVElNemNoZnFHVlhicVc1L1lQcTZFeXNIN3RrdmRKa2RUcmdFUDFn?=
 =?utf-8?B?Zm5PMW4xbWJyYTZQaWhWMGpnUmozY2pBeEFkc290ei9CQUV5R0JwdC83TUVO?=
 =?utf-8?B?MG9JcWt0TXRFank4anZNNWo1ZWF4cTRxckFsbld6TFlJdWtiV1JsK05SVjFO?=
 =?utf-8?B?SW54TTd4L09nYXhmNUZ3aUczaGloUndXUDR3ajZhVHVYNHBId0U5ZTV4Yjlr?=
 =?utf-8?B?TWxrcTRyL2xRRTMxaGxubFlpMmR6RFA3enRBMEYwcXVFeUViSlI2R293R2Na?=
 =?utf-8?B?d0tkcFNwOUlLRzMrV2Z4TkRLVWtqa3F1NW1hOFdOdnZHRFVJa2hHdUF6R2RJ?=
 =?utf-8?B?aGVzSnQ4Vnl3T0txdWIvQmhoT3YwS0dwKzhVb2tBWkZ3Vk8vZms0ak9OZ25E?=
 =?utf-8?B?ZmEwNWRoLzZEKzZ6SDFBMHlSMEVRSkV0b0RCWGkrQTdNd1lsVWgzRFhBdmZO?=
 =?utf-8?B?Z1pDUjREM21yNGxSNnNBVm9jY29reU94dHBLcGw0RTJkTkRrMDEyOWgyNmZO?=
 =?utf-8?B?SVFuSEo3emd1cVFnakZVTEhuNzJCVjNRaFpKNCtBZGVLL1FsUUFwamlnWEh0?=
 =?utf-8?B?ZmR1eklabFNNQkMzS0NvWmFpc1AzazlJcmI4bXZDT0VGdTdNSUE1RENZTmdT?=
 =?utf-8?B?RER5VjNtd3kvMGpkOTdIbVVIYkF3QkNlNFVMd0YwUjdiaFFNQ3dGbzk0S0ZS?=
 =?utf-8?B?NzNLOHcyYmZBSk9Td2FmMWJJaU5kNldsWG44VFh6MFYrUFdzU0Y4NjBFOVdN?=
 =?utf-8?B?T3A4L0o0aGRDNlBvRGRoajdqNE9KTXJWQlNhRHpWSU9ScWRRYlNhZjZlU2Vs?=
 =?utf-8?B?a2dCeDlUU1pUQTVEYlZuSDhTNW9wUGsxbEhucDhpWkV1YlhzNzR0VHlMNmJ2?=
 =?utf-8?B?WFl1NlVtTlJ0cGJFUkhSTXptcUdwYTFuZEx0blFGQkRKdEx6Tld3dU1CQjlk?=
 =?utf-8?B?a1Fhd3lEZCswOVhya2hvV0YwWUtMaXl5cUdoeGdEVlRFNkV1RU5XQ0NwVHlk?=
 =?utf-8?B?OGtkWEFrM0JETHFaSG1qYzgzbzB5bEx1YmM5MXR1NElncVduWDF4UEJ0bW1W?=
 =?utf-8?B?MzhVMVhIZEN1MXcxQWU2dkhoK3lwUWZ5TmhsWWpGWnFoQjVMeXBzVmpONFRk?=
 =?utf-8?B?Y3VqcU9uTnFkakR6MkpqVFB2QzZwZ0ZHV3pkMHZEYjBUMlFJeVlhN2M0aUdy?=
 =?utf-8?B?ZitqK25nZ0djY0haaTgvT1NGTzZKNzFPSTlUV3lkVUlnUTJmSEJnaXhlZzZI?=
 =?utf-8?B?YUx0dFZYMmMySEZBYkxvayt2WUtjd2JJd2srVmI0LzBYc3V5VTV2NWw3ejJo?=
 =?utf-8?B?QzlKVithaldvdWpkOXd1V2J5MWFNK21qaTdxeWFZYkdyQkFVbVNndTQwNU5T?=
 =?utf-8?B?M1FlNGpkcldVRW42TVRoU3JQNE5HSTUySDNVQU9zM1RLZzkvWE1iVzdiY3Rx?=
 =?utf-8?B?STZNcWFvNFJtR3J5eXNqVDhTRnl1akU0dkc5dFZoSmdxYmh1T0sxajlyUGU4?=
 =?utf-8?B?N3FEQVJYcEw0dURvaUwxeFpqZ2toYUdMNklPV2JPbCs5KzFVeXVXRWZ5Yk1i?=
 =?utf-8?B?empCd2xKUnFVY0lpUjRaZ1dXY2hiZi9tSFZNNHF5SjJjaFdEQVpQaFp0d2Rl?=
 =?utf-8?B?R0lDOE9RUjFkcXZrdDRZZ0Z2ZitlTjMzeStZcTNDZ1ZDSGRSYzN5VnN5eklW?=
 =?utf-8?B?TnFiTVlIQXY1N0ZPU3BkVXU4QktOQkUvWWxQTlJpNHZmZmRHQzg4K3BmazU2?=
 =?utf-8?B?LzNsZ29ESldOaFhzOXJCVnEzZEhJblFsTk9kMWpRVVgzdDBlcXowQWVKbVAy?=
 =?utf-8?B?V1U4bGJ4NjRub0Y4WlRJZ08wbFlJVWl0NG93d3dTME9XUEkzcjdoQXBUOVN3?=
 =?utf-8?B?Tm1Bck81NVNtak9IeGxrN2UrQ3RzT21jZUUvNS9vWWt6bFh1TEZpK1R0WmZE?=
 =?utf-8?B?TlljNzgwL1pDWGlRTXpXUXMzRE9FVlY1Q2VNeGxNNzFicE96eDZpVVkzc1Ev?=
 =?utf-8?B?UEVGeHJxVktPbXprL3REdDJCcHhpdHV4S1ZCT0RCd0h3RGMvbVAyQT09?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ddTKKMkmsiPTtD4W31FJqQxa0LGYuGg0k5QZbmlrKnRiaWqerTP6MoLdXUgkDpV4jf5SGvrjy48gff+S6Ikcex27Exz6sjA1redKOlXHxfP9L7qApXmuxB9ZX3Qnl9yYM0pj3MPcFTK42meDL+r1qciY69xCqHLt7ZyhMzWssXQMFW4mW74Vt9hc4gtrDEAyJTvevxOv15LylysrY/2QjYBNTdNfQIBRWqfYkKpLQg/zPvZDC2ehe60DwWre+0BAjVlpSFQq+sBLoNK2FcR/dbyaY19ioqCJyiWJfVj9xJQ9I5zbmn3avSy8gOLO/KyMUNVPM6zTlNMFli1zDMFQHQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c43021-6edb-401e-80df-08ded01ad038
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 04:57:51.3998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KXYPE+ytaRjCRLhw5mV7LGPrtVgurVlqfE+21JMo+epCkrWNQzE5Uv7O8YOg35K8Y/mYhU5rndw24YfO9RR3SqqyDXF49ZtrgPyr/QboIok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11400
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Rl3b2vRX2XnPqJvGuzlXDOKU7t2us3XtlSkfAqqLsxk_1782104273
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300957-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:Pier.Beruto@onsemi.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D059D6ACA35

U29ycnkgdGhhdCBJIG1pc3NlZCB0byBtZW50aW9uIHRoZSB0YXJnZXQgdHJlZSAobmV0KS4gV2ls
bCB3YWl0IGZvciBmZXcgZGF5cyBhbnl3YXkgYW5kIHJlLXN1Ym1pdCBpZiBuZWVkZWQuDQoNClNp
bmNlcmVseQ0KU2VsdmENCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBT
ZWx2YW1hbmkgUmFqYWdvcGFsIHZpYSBCNCBSZWxheQ0KPiA8ZGV2bnVsbCtTZWx2YW1hbmkuUmFq
YWdvcGFsLm9uc2VtaS5jb21Aa2VybmVsLm9yZz4NCj4gU2VudDogU3VuZGF5LCBKdW5lIDIxLCAy
MDI2IDk6MjQgUE0NCj4gU3ViamVjdDogW1BBVENIIDAvMl0gRml4IHRvIHBvc3NpYmxlIHNrYiBs
ZWFrIGR1ZSB0byByYWNlIGNvbmR0aW9uIGluIHR4IHBhdGgNCj4gDQo+IA0KPiBUaGlzIE1lc3Nh
Z2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5kZXINCj4gVGhpcyBtZXNzYWdlIGNhbWUgZnJvbSBv
dXRzaWRlIHlvdXIgb3JnYW5pemF0aW9uLg0KPiANCj4gRHVlIHRvIHRoZSBmYWN0IHRoYXQgdHJh
ZmZpYyBpcyBoYW5kbGVkIGluIHRocmVhZGVkIElSUSwNCj4gYW5kIHRoZSBpbnRyb2R1Y3Rpb24g
b2YgZGlzYWJsZV90cmFmZmljIGZsYWcsIGludHJvZHVjZWQNCj4gdGhlIHJhY2UgY29uZGl0aW9u
IHdoZXJlIHNrIGJ1ZmZlciBtYXkgbGVhayBpZiB0cmFzbWl0DQo+IHBhdGggaXMgaW50ZXJydXB0
ZWQgYmV0d2VlbiB0aGUgY29uZGl0aW9uIGNoZWNrIGFuZA0KPiBpbml0aWFsaXppbmcgdGhlIHdh
aXRpbmdfdHhfc2tiIHBvaW50ZXIgZm9yIHRyYW5zbWlzc2lvbi4NCj4gDQo+IFdpdGggdGhpcyBj
aGFuZ2UsIGRpc2FibGVfdHJhZmZpYyBhbmQgd2FpdGluZ190eF9za2INCj4gcG9pbnRlciBhcmUg
cHJvdGVjdGVkIGJ5IHNwaW4gbG9jay91bmxvY2sgcGFpci4NCj4gDQo+IFRoaXMgaXMgaGlnaGxp
Z2h0ZWQgaW4gU2FzaGlrbyByZXZpZXcNCj4gaHR0cHM6Ly9uZXRkZXYtYWkuYm90cy5saW51eC5k
ZXYvc2FzaGlrby8jL3BhdGNoc2V0LzIwMjYwNjExLWxldmVsLXRyaWdnZXItdjUtMC0NCj4gNDUz
M2E5ZTg1Y2UyJTQwb25zZW1pLmNvbQ0KPiA8aHR0cHM6Ly9uZXRkZXYtYWkuYm90cy5saW51eC5k
ZXYvc2FzaGlrby8jL3BhdGNoc2V0LzIwMjYwNjExLWxldmVsLXRyaWdnZXItdjUtMC00NTMzYTll
ODVjZTIlNDBvbnNlbWkuY29tDQo+ID1uZXRkZXYtYWkuYm90cy5saW51eC5kZXY+DQo+IA0KPiBB
bHNvIG9uIGJ1ZmZlciBvdmVycnVuIGNvbmRpdGlvbiwgcHJvYmFibHkgZHVlIHRvIGxvc3Mgb2YN
Cj4gU1BJIGRhdGEgY2h1bmtzLCByZWNlaXZlIHBhdGggZG9lc24ndCBzZWUgdGhlIGV4cGVjdGVk
DQo+IGRhdGEgY2h1bmsgd2l0aCBlbmRfdmFsaWQgYml0IHNldC4gQXMgYSByZXN1bHQsIGRyaXZl
cg0KPiBrZWVwcyBhZGRpbmcgZGF0YSBjaHVua3MgdG8gdGhlIHNrYiBiZWZvcmUgcnVubmluZyBv
dXQNCj4gb2Ygc3BhY2UgYW5kIGtlcm5lbCBwYW5pYyBpcyBzZWVuLg0KPiANCj4gV2l0aCB0aGlz
IGNoYW5nZSwgYmVmb3JlIGFkZGluZyBkYXRhIHRvIHRoZSBza2IsIGlmIHRoZXJlDQo+IGlzIG5v
IHNwYWNlLCBza2IgaXMgZnJlZWQgYW5kIGRyaXZlciBzdGFydHMgbG9va2luZyBmb3INCj4gbmV3
IGZyYW1lIGJ5IGxvb2tpbmcgZm9yIGEgZGF0YSBjaHVuayB3aXRoIHN0YXJ0X3ZhbGlkDQo+IGJp
dCBzZXQuDQo+IA0KPiBbIDcwNS40MDU0OTBdIHNrYnVmZjogc2tiX292ZXJfcGFuaWM6IHRleHQ6
ZmZmZmZmZDJlYjcyYTI2NCBsZW46MTYwMCBwdXQ6NjQNCj4gaGVhZDpmZmZmZmY4MDRlNWNkYzQw
IGRhdGE6ZmZmZmZmODA0ZTVjZGM4MCB0YWlsOjB4NjgwIGVuZDoweDY0MCBkZXY6ZXRoMQ0KPiBb
IDcwNS40MDU1NjldIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiBbIDcw
NS40MDU1NzVdIGtlcm5lbCBCVUcgYXQgbmV0L2NvcmUvc2tidWZmLmM6MjE0IQ0KPiBbIDcwNS40
MDU1ODldIEludGVybmFsIGVycm9yOiBPb3BzIC0gQlVHOiAwMDAwMDAwMGYyMDAwODAwIFsjMV0g
U01QDQo+IA0KPiBbIDY3MDMuNDI3NjkwXSBDYWxsIHRyYWNlOg0KPiBbIDcwNS45MjUxNTddIHNr
Yl9wYW5pYysweDU4LzB4NjggKFApDQo+IFsgNzA1LjkyODcyNl0gc2tiX3B1dCsweDc0LzB4ODAN
Cj4gWyA3MDUuOTMxNzcyXSBvYV90YzZfdXBkYXRlX3J4X3NrYisweDQ0LzB4OTggW29hX3RjNl9t
b2RdDQo+IFsgNzA1LjkzNzA4NF0gb2FfdGM2X21hY3BoeV90aHJlYWRlZF9pcnErMHgzZjQvMHg5
MDAgW29hX3RjNl9tb2RdDQo+IFsgNzA1Ljk0MzA4NF0gaXJxX3RocmVhZF9mbisweDM0LzB4YjgN
Cj4gWyA3MDUuOTQ2NjU0XSBpcnFfdGhyZWFkKzB4MWEwLzB4MzAwDQo+IFsgNzA1Ljk1MDEzNF0g
a3RocmVhZCsweDEzOC8weDE1MA0KPiBbIDcwNS45NTMzNTZdIHJldF9mcm9tX2ZvcmsrMHgxMC8w
eDIwDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZWx2YW1hbmkgUmFqYWdvcGFsIDxTZWx2YW1hbmku
UmFqYWdvcGFsQG9uc2VtaS5jb20+DQo+IC0tLQ0KPiBTZWx2YW1hbmkgUmFqYWdvcGFsICgyKToN
Cj4gUHJvdGVjdCBza2IgcG9pbnRlciB1c2VkIGJ5IHR3byBkaWZmZXJlbnQga2VybmVsIGluc3Rh
bmNlcw0KPiBuZXQ6IGV0aGVybmV0OiBvYV90YzY6IEltcHJvdmVtZW50IGluIGJ1ZmZlciBvdmVy
ZmxvdyBoYW5kbGluZw0KPiANCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvb2FfdGM2LmMgfCA3NSAr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQo+IDEgZmlsZSBjaGFu
Z2VkLCA0OCBpbnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkNCj4gLS0tDQo+IGJhc2UtY29t
bWl0OiBkMDdkODBiNmExMjlhNDQ1MzhjZGExNTQ5YjdhY2Y5NTE1NGZiMTk3DQo+IGNoYW5nZS1p
ZDogMjAyNjA2MjEtZml4LXJhY2UtY29uZGl0aW9uLWFuZC1jcmFzaC05NGQwNTVhNjY1YzQNCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gU2VsdmFtYW5pIFJhamFnb3BhbCA8U2VsdmFtYW5p
LlJhamFnb3BhbEBvbnNlbWkuY29tPg0KPiANCg0K


