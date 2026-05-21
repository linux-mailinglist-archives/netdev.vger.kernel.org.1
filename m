Return-Path: <netdev+bounces-290576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMgtHktGD2ptIgYAu9opvQ
	(envelope-from <netdev+bounces-290576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:52:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 302485AA9BF
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06B17300337F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2193EFD0C;
	Thu, 21 May 2026 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="Kf0427bG"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CE539BFF4
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385925; cv=none; b=pddtqFhn2+T9ZACnyWX9vH/aFTFeDvrkOHvig9wpk3FnAMykf7g6Ni57LjA88dsxMEoEtYqucjmWAdwRq4YZGmjcKHYdg3ABNasErFO+IBfBHZLSxjUvBJvTAuDJTLFndZkjQ91UZ3f9rfIsyrnRi5DFEdWEabqNKaxshqLI9Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385925; c=relaxed/simple;
	bh=HSJJlkFN7vHB0dKwOSqXz4Ha38WrsfhL24Q7zAQ/sBE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=mrJQa3f5hcWrjym70VZq8xBWsgqDvimFFEZwujotIy3oh4oZQRr5RRXR77V4AdFuqMBkdraLFK/U+hkSqNXrwyb6xKMGlNGjSAjZzW6ks/U5uOMQzhcQibckdl1y/4Q1/6a8HG4dtcgtOPq98jrEpkR232AVoybMzPyr2KyFA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=Kf0427bG; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1779385918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSJJlkFN7vHB0dKwOSqXz4Ha38WrsfhL24Q7zAQ/sBE=;
	b=Kf0427bGVqBKHHno4N4oSaCNO7zJIRbjP1fl25gK8CLUqCWTsz19CGTCs8WFyNjbrQwrgD
	IBLgSCOpktVXgYeUeS8fixSeEwKYvWbsCn5nOcncpkBpaXhAOw1m/CWMc3WkOkzTp42WEc
	0vTnSP5KybkJLTG6VOLXs1rM9QJlB+TcB5eKha2snb8KQFlFGZ76juJdHY6YHauYNnLSad
	Gt9TvT+xmp1MGD8rDviu7aiRYyLGZSHLsUBTyqncsxLaIQbuj3Y3b+sEiB/89XmPO6WkCv
	QUoql/rUKeRwLCR5N7NvLUDPxKPOLv3abMCZJTl9IVOkslGpW/5ywacH0uRDbQ==
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-21-9QLdkpy6MAOxvgTazft4PQ-1; Thu,
 21 May 2026 10:51:55 -0700
X-MC-Unique: 9QLdkpy6MAOxvgTazft4PQ-1
X-Mimecast-MFC-AGG-ID: 9QLdkpy6MAOxvgTazft4PQ_1779385914
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by PH0PR02MB7576.namprd02.prod.outlook.com (2603:10b6:510:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 17:51:52 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 17:51:52 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 8/9] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Topic: [PATCH net-next v2 8/9] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Index: AdzhcbEAp6Owv179R1mImunkqBeYBAAELzkAAT2eW1AAEUQMgACinjEw
Date: Thu, 21 May 2026 17:51:52 +0000
Message-ID: <CY8PR02MB9249AE486B23AD6637517436830E2@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB924948C0BB8611D5A2618D3283382@CY8PR02MB9249.namprd02.prod.outlook.com>
 <c9b1b559-f72e-46e0-8d71-57ea26f70bb0@lunn.ch>
 <CY8PR02MB9249BE304350D2FA7C196A6C83032@CY8PR02MB9249.namprd02.prod.outlook.com>
 <660d68f2-2e4a-4dad-a33b-9cbd1847c04e@lunn.ch>
In-Reply-To: <660d68f2-2e4a-4dad-a33b-9cbd1847c04e@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|PH0PR02MB7576:EE_
x-ms-office365-filtering-correlation-id: c84582f6-c7dc-4549-c36e-08deb761a3cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|56012099003|22082099003|11063799006|4143699003|5023799004
x-microsoft-antispam-message-info: ghzIAaEbnXo+Ew1jEuEYreP8DRQbgeauU5grBQaViwwz1x8pr2eQ3pTtepewGo2l/TjKSB7vrGSZuQ8QG1bWoYBzbsR1UexcIyWxgE2CWYG/+I3yg9w2dL5/sMdCBM1MfKCfgvVJ3bVSbubhvZt3HlB4ugzU2ji8E/3K4LdRgl7766py0WilNuMGc4Vd1eoM5cvqthu0rWIbiOk/x/IL8pzRvr3VBaAMoCW3NCUovDsQJH301WdT0jgn5S7ral92vu5WC4mqjSLx2qhzPf1STLBoWEsH3o1v7DN/2PuMMA8OeBwCeSfpFi8i2GZYmgKVfXo8SjqwgyFmjSb1qPyOUdQwUlhysTfda3/jecdFOMNxnDdoca4g5jZaHKK54T7KkbHZ4KjSy9ZNTWWQSACnT5IGz7PRU3CkWraenhYJmDLTsVb4eY063bYxCO0Z87v1ZalvO32nqu/ry7WmWurIZpj3LWaKE+gUz8FJjIIIn7nIfd+eEKXdxA9ac5MqwxsAU5p5IQDCZVEI9pH2mj2pV8s+ZOlyCfsNo2dFnocMLejt2bQ+8DvtO+SiE4exeovL/srzHnFjToO3xULI55JqkSdf1PP4uHA8+2peCXBbhhsjlghYLBJdWnVFFQlHVEl/KyL6N0DaaVbv/fC6hI2oSS3EJsIWvGIcLWHkU4TX4mVgK7AH1NwXYAvfvC54BGonqNoBjgcKj/vDSMgO7DXSNpFithfQQ+HvJyYZcxDGAG4L5EkQlbCBGLIQoj/psoih
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003)(11063799006)(4143699003)(5023799004);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blNqK2swWjRDRnY2ekU1eU9yanc2ejlDSUZxWGFWOXZ1K1pXb2ZTbm81dWhN?=
 =?utf-8?B?aU4xZnRHRUNuTWh0Q0lveWJwYmRYUWdPeXc1elBMSHBzRDBIUlM5dDRwaGlz?=
 =?utf-8?B?QXdrMmhKZzFvYk9CeDNKSmJrOU94cG1jb0FSVEU4amJ5N3dzVjJzRFFQcDl2?=
 =?utf-8?B?SVRET0hwOGY4WGYyZXV6U3lKTkNnVU1iNUdlUlNPTGZMeWZLZnlmcm5xSWV4?=
 =?utf-8?B?SmQ4emRPTmU1eTlWV29zTzJPZnhKaDE2ZUJHV1lvNzdGcjBsWVdZVkdGbmRx?=
 =?utf-8?B?aSt5OFFpMXd6NnBVVTczZkh5R3hXZzYxa1h5QVR3RU9EVXhscUNxTlFLTFFC?=
 =?utf-8?B?WUlPd2M2YVVEMWhZcTJVTFpqR0RlK25zNXlxL3QrQ1ppTUkzWnNxVk1KeXMx?=
 =?utf-8?B?dzc1NWMycldUcENPTXBldVlTUXh1NU9Qb0ZpeTBwbGN3V0c5aFVubnJkV0hZ?=
 =?utf-8?B?ekRDQTg1dUpyOTlrV2laUmdHZ1pWZ3MyWnVvaUNsb3hya1hOSER3VUZKZTBW?=
 =?utf-8?B?TkYvUVV2SWQ1Skxoc1NKRnlRZjljU2F0MWw0TXdxbTQralZQaStHb1JUeE92?=
 =?utf-8?B?ZHhBNjJrVXdzS0FsTGhuWU95Qjc1TDNPbTRzcHRZTVMydUIydFhreVBMWis0?=
 =?utf-8?B?bEZ6N2tUWng4VzhJZjFJNlI0Ly8xRUdEVFIycU1PUkNGYTNuMmUzdXdiWXBB?=
 =?utf-8?B?a041akM3WTAxeGtLem80THRwOXN5S0hlUmthL0I4Vmg5MU9VdXNNTUl2SGNq?=
 =?utf-8?B?WG5oVm1HRUlDK25SMXh1ci9haFljL1FJb1lLenhDSXduRi9LRHdoSms4a0RZ?=
 =?utf-8?B?N1pjeUkrdzRQN3JWKzVERUg4VkFaL0NaOWlDdVAzaGpXRWtOdFNwVVIwejFm?=
 =?utf-8?B?SXFCaEZMRnBIdEErTHNBNUVsZjhzcmhvMFZPRzZhSG5uREo1QmJOcjJIbCt2?=
 =?utf-8?B?YnZyV3BRRUxTQzk1UzFoTGlZLzVFWUFhNDFBY3Zhb1VjNkowTUZ4N0p3OExl?=
 =?utf-8?B?VDd0c1poU1JXdDFXTTlvS0xmZTBxYjFpRzBOc2tzREwwOTh4eWc5NzJnVldM?=
 =?utf-8?B?bzRJZUNFeWRGdkM2NUR3TG9RMHA3L1BIRU9vOTMzb1ZXNU4zalQxTFNYMlFP?=
 =?utf-8?B?UFRteU9VRDgwNkNieXltQVJBbHBOUktrUnNoRTAxMStmcllqMEw4ck5CUlZw?=
 =?utf-8?B?RFFXSzNic3Bodm9YT2ZQbGptR2JQQWtsWW4rcjE0MGd1anYyVGNmK0ZPV0J6?=
 =?utf-8?B?TlFtMTRUM3lQemlsTmtUWlhJc2w0bmpKenVGdVNUWWxmMEptVnhTVktxSVlO?=
 =?utf-8?B?S2JRL1dlSEJuVVM3SFJOZ3ROTGkvb1pRUXZlL0FxS0hJK0E5N2Z0V2llcFIx?=
 =?utf-8?B?NjN5cElpMzVLOG9zaURqL2FKS1BEbCtwN2psTzR4VG5HZ2NlclIrcWRVNWQx?=
 =?utf-8?B?Qm5uY0VFZHJwRTkzNUNyMkxrYlBESGhkNURpQ0pMc0lvVENXVlIxdHZua1FV?=
 =?utf-8?B?cmM1MnMzaVcrTk9IdDd1RWlSVlcweks2QURrZ0ZoZitTa3N5bFpHcjYyQ2xz?=
 =?utf-8?B?K2p4ZjFPTWJ3N1F1aUFCN1VvVm9NYmV4elR4eWFlNWhZV3d3a0VIZk8rTE9n?=
 =?utf-8?B?QkllUXdLNlptZFFCeFpXRzJveEllUVhQd0NEZ3R3MG5BZUlQRVU4R0Ryc0xl?=
 =?utf-8?B?YVJQRTZmRlNiRjluTXBFcHc4WlRHeGhVVS9TWEVHcWlBak5iYnBOd0Qzemxl?=
 =?utf-8?B?VzV0NWZuMmtHTnpDLzJ3aE1keUJHMWN1Qk0yWEw2WmVLYm9QU0l1L1dMbDhO?=
 =?utf-8?B?OE5RTUVDekFDOVBxMGRKdUpSa2t1VndUS2FCTnJlMzgxOWZqU05MWWFySzlr?=
 =?utf-8?B?V0M2SUJsTExBR0x6L1hxUkxaaXpTekoyUXVNc1FjamdITGdMSFhHaGExNnpP?=
 =?utf-8?B?NGxGVVpNYStMbmZOb0d3SEUyTVc2MmNhaWR2RHdBT3RKa1grME04TFYwdWZI?=
 =?utf-8?B?WUdGUjY5VTI5amVZVjZKQkZLRk9zSjlFdm5mbHMzN2l5ZGRNdjgrdkZzeXBp?=
 =?utf-8?B?eS96UFJFWEJ4NnluNzJnM1BhNVlmekR6QUlLamhqVzBmdWd5N1VKeEYrNlZu?=
 =?utf-8?B?TWUvay9nMG1RdjNsUkp1OTNyRW1pU1FBVUNOeTZOcXg1a1pUZmJ4UXZPTVFC?=
 =?utf-8?B?R3ZvVEIyVE91NEI2VTl3UUtkWjFCYllPMzdwbERzZ0wvVlcvVXA2NTlFWlVr?=
 =?utf-8?B?QXVDbkxuZUJKRHFkVENpZy84ZkxYOVJCYWVrdnNzMVBlZnZXSXNBRHQ1SDZM?=
 =?utf-8?B?QnRLby9TUnpSck0rM0lJallqUlZGUml0empRTndiVkRhaGZlNzhERGV5YjZy?=
 =?utf-8?Q?1c8Xn6IJTtcl8Mkc=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ABldY7UatN8bhRXYf+5IAuddkNRYIlUeEheAz7ic0lh2gRFQ1uGmN9ZhnPemwKuJhp/G/d/q6DWdLByybNmHY/zsfLSbY1ipi5g+eFa0G+TTuR30ddEwRzWrJWV/0QmzH+gc/24CGruVCRAechTL8bxGWfBke6hEa9jcTQYfoyB+0u5XvVEjUQcnyjqhXNjVfUr1k0+26LB218Rr3dT9zbRNC43HwC9Gh+SqocDi60jtTtVC8DJiEzflUEmUVdRRfM5wsOwPUmvgjEC6r80kMzjV6ERWyZbV3/0i+amMd1lZBvnZyrhk8msFzX6BpBXFUUhyKJq5T4FgBACY7mZKBQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84582f6-c7dc-4549-c36e-08deb761a3cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 17:51:52.0878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvxR8ZZuikeOHByH25dnNHYIoWnuXit66nPc2g0yuWfnUDNmQFiqk7ejFga0pfVKHBHYQMM2JvGbOlVIa1bfvDGWdlo5wEt4Jxe/9pZ0GtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7576
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9OCxxGPuP34TmeepKOkX7sE60fvylP_tc66EjMqHIqk_1779385914
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290576-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[onsemi.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,onsemi.com:dkim]
X-Rspamd-Queue-Id: 302485AA9BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gPiA+DQo+ID4gPiBXaGF0IGlzIGFjdHVhbGx5IHNwZWNpZmljIHRvIHRoZSBzMjUwMCBo
ZXJlPyBZb3VyIGFpbSBzaG91bGQgYmUgdG8gcHV0DQo+ID4gPiBldmVyeXRoaW5nIHlvdSBjYW4g
aW50byB0aGUgY29yZS4NCj4gPg0KPiA+IEkgYWdyZWUgb24gdGhpcyBhbmQgdGhlIG5leHQgY29t
bWVudCBhcyB3ZWxsLiBOb3RoaW5nIHJlYWxseSB2ZW5kb3Igc3BlY2lmaWMuDQo+ID4NCj4gPiBR
dWVzdGlvbiBpcywNCj4gPiAxKSBTaG91bGQgd2UgYWRkIHRoZSBQVFAgY29kZSBpbiBvYV90YzYu
Yz8gVGhpcyBQVFAgY29kZSBhZGQgMjAwKyBsaW5lcy4gTXkNCj4gcHJlZmVyZW5jZSBpcyB0byBh
ZGQgYSBuZXcgZmlsZSBvYV90YzZfcHRwLmMgdW5kZXIgdGhlIGRpcmVjdG9yeSB3aGVyZSBvYV90
YzYuYyByZXNpZGVzLg0KPiANCj4gb2FfdGM2X3B0cC5jIGlzIGdvb2QuIE1heWJlIGNyZWF0ZSBh
IGRpcmVjdG9yeSBvYV90YzYgYW5kIG1vdmUgdGhlDQo+IGNvZGUgaW50byB0aGVyZS4gRXNwZWNp
YWxseSBpZiB5b3UgbmVlZCB0byBhZGQgYSBsb2NhbCBoZWFkZXIgd2hpY2ggaXMNCj4gc2hhcmVk
IGJ5IG9hX3RjNi5jIGFuZCBvYV90YzZfcHRwLmMsIGJ1dCBpcyBub3QgbmVlZGVkIGJ5IHRoZSBk
cml2ZXJzLg0KDQoNCkFuZHJldywNCkxpdHRsZSBjb3JyZWN0aW9uIHRvIHdoYXQgSSBzYWlkLiBB
cyB0aW1lc3RhbXAgcmVnaXN0ZXJzIGFyZSBpbiB2ZW5kb3Igc3BlY2lmaWMgTU1TLCByZWFkL3dy
aXRlL2FkanVzdCB0aW1lIGNhbGxiYWNrcyBoYXZlIHRvIGJlIGluIHZlbmRvcidzIGNvZGUuIEkg
YW0gcHV0dGluZyByZWdpc3Rlci91bnJlZ2lzdGVyIG9mIHB0cCBjbG9jayB0byAgb2FfdGM2X3B0
cC5jLiBJIHdpbGwgYWxzbyBtb3ZlIGFsbCB0aW1lc3RhbXAgcmVsYXRlZCBhZGRpdGlvbnMgZnJv
bSBvYV90YzYuYyB0byBvYV90YzZfcHRwLmMuIFRoaXMgd2lsbCByZWR1Y2UgdGhlIGNoYW5nZXMg
dG8gb2FfdGM2LmMgc2lnbmlmaWNhbnRseS4gDQoNClRoaXMgaXMgYmVzaWRlcyBtb3Zpbmcgb2Ff
dGM2LmMgdG8gaXRzIG93biBkaXJlY3RvcnkgKGRyaXZlcnMvbmV0L2V0aGVybmV0L29hX3RjNikg
YXMgeW91IHN1Z2dlc3RlZC4gV2Ugd2lsbCBoYXZlIGEgbmV3ZXIsIGxvY2FsIGhlYWRlciBmaWxl
IHRvIGFjY29tbW9kYXRlIHNoYXJlZCBkZWZpbml0aW9ucyB3aXRoaW4gT0EgVEM2IGZyYW1ld29y
ayBjb2RlLg0KDQo+IA0KPiA+IDIpIElmIHdlIGFyZSBhZGRpbmcgYSBuZXcgZmlsZSwgc2hvdWxk
IGl0IGJlIHVuZGVyIHNhbWUgQ09ORklHX09BX1RDNiBvciBhZGQgYSBuZXcNCj4gQ09ORklHX09B
X1RDNl9IV19USU1FU1RBTVAgb3Igc29tZXRoaW5nIHNpbWlsYXI/DQo+IA0KPiBJIHdvdWxkIG5v
dCBib3RoZXIgd2l0aCBhIG5ldyBzeW1ib2wuIEl0IGFkZHMgYnVpbGQgdGVzdGluZyBjb21wbGV4
aXR5DQo+IGhhdmluZyB0byBidWlsZCB3aXRoIGFuZCB3aXRob3V0IGl0LCB0byB0ZXN0IHRoZSBz
dHVicyBhcmUgY29ycmVjdA0KPiBldGMuDQo+IA0KPiBBbmRyZXcNCg0K


