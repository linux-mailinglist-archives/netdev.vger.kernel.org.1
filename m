Return-Path: <netdev+bounces-301629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m5SPBYXJO2qNdAgAu9opvQ
	(envelope-from <netdev+bounces-301629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:11:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 904346BE030
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:11:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b="b9/R07QY";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301629-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301629-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73C22302C7B6
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 12:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8579A279917;
	Wed, 24 Jun 2026 12:04:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013022.outbound.protection.outlook.com [52.101.83.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD4A22CBE6
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 12:04:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302673; cv=fail; b=G6oGtes8PU52AW+rubRKb8iwmMLegy7zKcoHr/5ncRvE+Wod1bfVZTD3ebAm4xhpWRwUNAF9X441R5BMEtEyZXvuwXUaCIWpj9AQuqTlk7X7dlLbSYTUuxhAI974Zr8oGnpMEVfyAiSKRb+yWuJbB/VJDEdJnKJpDiE0ik70vxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302673; c=relaxed/simple;
	bh=VbhoZHiu25rl6ETacB+9BUieBiqzqNpyexVLxmLugcc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YbtgwJJvdLjjG5L+MHeW6GSgB0+6tw9YKzFn0+EUZR/94VfU0ku+1mIWUIFoeHfMbghnO8xrPwWwIy6TeVWHBw9z50WCSi6i/52A/gy59l8lC92Qmg39Ko+rWUuHVf/Jg6UYH9yOSfSVhFy2EBSN1lp3mVhDH5upe9SDg4Um4TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=b9/R07QY; arc=fail smtp.client-ip=52.101.83.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsfAo5CKHh2Mz3Rd1QwZkAVVB5znx4Esg13xnxVtb0tJBZ9gf3SvBDGtQQSB5VlcrHMi8/pTYpQH2899FiiH/MwjH186kwvS+d2PSW21+pW8wxKMDuxoUfa3/yHgfVIYUJKererPy6RLZ9PkrG6FYZEeAGwKH0r2d2/rgtVoNP+NbnOTu/MvENZspuS5o4eyanQPHFecOJhoPBqDsHs0g4kkp13acYouIvkIYs962MGgyFR51FrC7eGdyp/O0VK4R/x2ucOe4VL/AEdZR3orQVY8fLVzHJdFQ692NMzfyboq95qFNpzAVfB9g4DYgKSdjnQXp5RuxS9LPUAXwYAUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbhoZHiu25rl6ETacB+9BUieBiqzqNpyexVLxmLugcc=;
 b=joTeR3KCVF1Ao3/KNe5FhB9hS0FWz11PMuPyuUEVcb3KxV/BNW96EfCMOc9jNB9wib40GP57/ehZPOllgMyIee8RB1x6hQYDqx+VphXR1fGBsftheR9Kqz8G4QP8+tHcx9toWgdgmCyS9YC0ZhgARmV5NfIRoKDhc3B6tRLGxwFfW5Z4zQ8bOsQY+BJpmv1pnIEuzhpXTTm2P57B0h0CEI2060iMJsInEx1LbFaVS2pnBCUXGbIg5YJeBmnPJXjSSP4gPcSZ0yQJQ0x+9UpRpB0471bLqvoCCkzRdtFO8HnfF5SqPDGkutaPEC03xIrQTtEMPWIfXQweb5psQy8agQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbhoZHiu25rl6ETacB+9BUieBiqzqNpyexVLxmLugcc=;
 b=b9/R07QYPhOKyl5iAIAXCVZ0pDizG/RzWm/cbCVz2KfKVmWchpVPHGUZIOxV++2UtJiHVtuDl7oQfudkdnb/WhflHeD0yGP+iA6DO9QC9W43b1saNW3MUEX9uc93GxtFSbCCgMepWFziHydX49zPAwGc7ynI/JsJoZPb1gjxwx3SGBpJePXTMCMugvQMQSbiw71YsSvPQ/t13sF1c9bd016FgbtmmbyY8zHx6SNQcHUAKqiTkMlub4aeMk7leSxZMNIPuXC6aPRCupRj4G5JYLZzmbgsT2p95WGMouQYZ3A6naeFIfYx9llVEud5iBFHozWgIOxnJTVEdvVzHoyn5g==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DU4P189MB3469.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:5f1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.13; Wed, 24 Jun 2026 12:04:27 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 12:04:27 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Eric Dumazet <edumazet@google.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
	"syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com"
	<syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: RE: [PATCH v2 net 1/2] tipc: fix UAF in cleanup_bearer() due to
 premature dst_cache_destroy()
Thread-Topic: [PATCH v2 net 1/2] tipc: fix UAF in cleanup_bearer() due to
 premature dst_cache_destroy()
Thread-Index: AQHdAzYSKLx9SbAji0OavEsAqZmJsrZNnDuw
Date: Wed, 24 Jun 2026 12:04:27 +0000
Message-ID:
 <GV1P189MB198820F9C95A5FF9A110EA19C6ED2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260623173030.2925059-1-edumazet@google.com>
 <20260623173030.2925059-2-edumazet@google.com>
In-Reply-To: <20260623173030.2925059-2-edumazet@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DU4P189MB3469:EE_
x-ms-office365-filtering-correlation-id: 35d9c616-7155-4fd3-cdac-08ded1e8bda1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|22082099003|18002099003|11063799006|4143699003|5023799004|56012099006|38070700021;
x-microsoft-antispam-message-info:
 bLmvFDbk6vWp+12VzjZiqVfye2HtTn6VJY8H6pmsib2ECUKGxHPQL50PBbomi1/1+BlZy6mdBGbujpckrmja6lftz6PmQGEy95rDIUiq+KRKYOkWCq9IHLbkO3tCsepnVQ/yj/tZeCeVQuAt6f76vztl/nvgs7t6nAJtO+hKzMBx4HYLhDISTzE5vU4uhNKlGGcgS6AY8ReTUwM72SMma8jNY9r7Wo+elkbrx5HDNXX3uH9FKaT1CJkNsy0rOpIlb7sm0OjnuZEziill0nn0tUPZ02U3De2fwBVSYCW8X7/4wppq5rISn2mVzKNvyazmNhLnZTxSRZeHzo0itQIC11hVR7IWy9KuoHcRwoNE7qIV68a4oqulJvoPJzKxnkJDV9W3UE7z0199lKTe0SRgPtQnJlP/Y6HNmug9LRPQ7LhUgfiMWMuKMvUZzK2HwKo1feAqXhV6pabcQYDtCE54FTmLR92geDeiRmOJ188yJ0zMKtZbx2JY5gPb2/A3XqnuV1axJ6y+Nnh+NGS50+ZymUSHEfejZjpXttG137ieoiXloQg+oeA9Nu9kMWx7cgl5jJnzTjPeESwWrYRCIsD5ypQVEduk4Pzw+eSX1O3M8bkJ8u2rWaSWsIX5g5a9zuCLjLONX13ti2qs9lanh69NDOlVcR6X60J+/6cQ5G/A1Ic=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(5023799004)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UVl6VTdCOHZmMmx0cUZjeHZoUFZ6MmNkL3Q1NDJCNmJJSmNsSFpXSlNvNmJK?=
 =?utf-8?B?d0xxOWpZSE1qMlc1RWlzTE91QzZRRTVxNXZoQUJwaEcrNUs2d0RNV3JqRzFi?=
 =?utf-8?B?K1hKaGU2TlB1MDdyZHlXRlFaMVFnRGNWYk9ySFpmbDJINFNnL2piRTlEbmU2?=
 =?utf-8?B?QSt1U2VpUDNOcUhYdkZnVlZxOHhra1lYUkZ0VmZLMVZKSUdaemRSZXFYdGFQ?=
 =?utf-8?B?UXdIUi90Ky8zdTFZbW9IeFFlRDZPMGNrNU1vUzFMdTZxdTBsUDI4RklmNFhH?=
 =?utf-8?B?bGZpMFJkc2lRbDhLVjhvSXBXUC9FVGxwNXFPeEZTb05lQ1BVM3lVM1lDQTZ5?=
 =?utf-8?B?dE81MkZoUmJSUnZyK0tZbG5MZ0RkbVRhRzhoUVQ3dkxFcjhFQVpxcnZRREFs?=
 =?utf-8?B?czdWYmlmQmxXRVp2cUN2TTRjNFUvTTYzNDJjai8yeWJjcmhlVEkrMER0YktO?=
 =?utf-8?B?Zm95VlNQT3VvN0ZpWloxcUV4aXB5L1FIejZOaGp4eW5Dd3MrOWpJd0MrdEx3?=
 =?utf-8?B?ZzJaR0VWMnNKWlljbUJ4N3RxenY2VEFoKzFRTng2WGU2WkQ5UjVocjJtSjZx?=
 =?utf-8?B?VkxhalUrRmh5eE5rTit0QUw4S1RTRXQxelZXdFdMeDhETkRwakx6MmpGT1lx?=
 =?utf-8?B?M3drd3hVK1UyOE5ETHV1MHNEbUVUdjZYZnlHV0Z6Z3NrdTl5ZE0rM3d5UWtz?=
 =?utf-8?B?dWVnS2F0U2txUk80WkVDZ3dZOGNVOE9oQ2U1NWRxbG5WOTg2WGNFak02VVNk?=
 =?utf-8?B?dzl1S1VneDYrNzJuaW5pSFJ0QW41Q1lMWWRJWjhFa0srTlQ3T0tSREhOZVVm?=
 =?utf-8?B?cXNTYytiVzVZQmVweTg5Q09vTTh5NlloRWY1V1FzZldwOUU4V05BZWdwMHIv?=
 =?utf-8?B?MjYvWUl1WmRTQVUxM2hNMnRNbE81ak9FY0MrQTM0M2RUak9yN1ZPSGJGMUIw?=
 =?utf-8?B?UFJuNDJBcmJreXV2Vm5YZHN3YTFVRmVFZE8yY1Z5cmZJRFQ3MHAveWhIMW01?=
 =?utf-8?B?by9EM3VPcFlvMWtqeEFOT1FrOEFXYXQ2YTZ5RlNwenBjSGplbVRWcTdYd2hY?=
 =?utf-8?B?cXdoa2F3Wmh2LzZzaWJBM0F3N2EyUCtjRWdCeWZvWlZZRlZ0aHVJWkF0OGRS?=
 =?utf-8?B?U0JFdUhGWVhRcnZSbkJZbkNUSWxOSUhZK0N4RFRMZUU4T2VOY0N1bjdIVVNI?=
 =?utf-8?B?eE52UWZ1eFJ5d29DVU14Nk9INXcvYlB0VmJjN1hOU1VybVdTSko1TCtiVW0w?=
 =?utf-8?B?bkkvcnBMZmxBcXYwVzlJaXR5MEpCNnh1R3o2bEhmUnkyNjJXcWRSV0xqRnh0?=
 =?utf-8?B?TFE0RCtrUElqSGRsQXZoa3ZIYTBwWmoycnI3QUxCcFFFWDBUNU5LNGtEdXpQ?=
 =?utf-8?B?Y1dZMHFYb2xHT2FMWlVDVU9zOWpzZkV6a1k2cUtrUnZwVDlLbVZLSVM4a1VC?=
 =?utf-8?B?UHk2ajRJcGl5T1k4VkpZWGYwY0hKQitmRjFyRitkdWdFUVVtbE9tVlp1Q2x2?=
 =?utf-8?B?Yjhxamd1eWZxQ3FzSmR5NmxkcWgzSjJCVE5hVEVEMTd3UE1oWTN2NXJBVWpF?=
 =?utf-8?B?ZXBvMXVHdEg1a3JhTGdIVzY3OUNaZVZuejVNVTZ3WFNXSWhsTkZmb3Viam9U?=
 =?utf-8?B?eDM0aTVRU05OMXE5Q0VLa3Q5MkZud0NYNzNYamZWcWVVQzFPL043Nk11MGps?=
 =?utf-8?B?bmxtS0xoNmNiTHlVOVJyb3lRemJXeUJJM0MySmI3dnMya3NPZXJlQ1pQbGc2?=
 =?utf-8?B?dDQ0alBJdzJGL0xWWDc2OUVIcU15elYzLzN1c2J5UkdORGZmRTJ4MmdlcVdH?=
 =?utf-8?B?eTBJbTlzMGNENXYrRDFvQS8zbVBJODhGTElUZU8rZHBtZzVUd1d1eUhvQ3Fk?=
 =?utf-8?B?dDZTa0RremJlaVF6RWpFSzZIWEhibkZtMklLS2piZ3kwTlF5RDJQTngxSlB0?=
 =?utf-8?B?ZGNFc2lMNDhUUEV1M1J0YzZ3SDg0NU8yOTh5Mm9rRzVsVHRNMXVMR2VaMXZ2?=
 =?utf-8?B?SHQzU2pqc1h5RjExSzZpNWpzN3FjV3lSazZwbVZrWFQ1VTVReG9zdXZmRTdv?=
 =?utf-8?B?TUlNc25ObHJIU1dPUmdaMDlXM3ErbktWbTRMbWJPZDhDUmxjazcwWVd5QnIx?=
 =?utf-8?B?bUdNYldJTjBFbXdoT0JxSGJWRVZUMGRIcnFXQ1RVMnUrVjFyaFhZZnhpS0FX?=
 =?utf-8?B?dXR6VUo4TW5MS0tZTjJRNzFMMzlNNW9vbGZpc01jaTJlK29DVnFuY2FNaXI1?=
 =?utf-8?B?dVNOdFJvRWJZcGRyNWdCWjcvc1FJaEdLNDZBK0F3Y1Y0eXNWWWxZaXJtOHZB?=
 =?utf-8?B?WUpxUndTdFFwOTJnSGIvTnRtYTVMcFpzRUlOR0tUVEcxQ0g5eVEvUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d9c616-7155-4fd3-cdac-08ded1e8bda1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 12:04:27.6736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVTFIpV7vxuLHDlQNKU8d0oFUxR4MyS12zwEX0YWegMh6Fm/EQD+/R19giOUY78Jyf81VYPcYw/tcc0cw1R6/oGizNjOyMRlZpTI0raTWlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P189MB3469
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301629-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[est.tech];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:horms@kernel.org,m:kuniyu@google.com,m:lucien.xin@gmail.com,m:jmaloy@redhat.com,m:tipc-discussion@lists.sourceforge.net,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:lucienxin@gmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,redhat.com,lists.sourceforge.net,vger.kernel.org,syzkaller.appspotmail.com,davemloft.net];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e14bc5d4942756023b77];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,est.tech:dkim,est.tech:from_mime,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 904346BE030

PlN1YmplY3Q6IFtQQVRDSCB2MiBuZXQgMS8yXSB0aXBjOiBmaXggVUFGIGluIGNsZWFudXBfYmVh
cmVyKCkgZHVlIHRvIHByZW1hdHVyZQ0KPmRzdF9jYWNoZV9kZXN0cm95KCkNCj4NCj5USVBDIFVE
UCBtZWRpYSBiZWFyZXIgdGVhcmRvd24gY2FsbHMgZHN0X2NhY2hlX2Rlc3Ryb3koKSBvbiBpdHMg
cmVwbGljYXN0DQo+Y2FjaGVzIGJlZm9yZSBjYWxsaW5nIHN5bmNocm9uaXplX25ldCgpIHRvIHdh
aXQgZm9yIGNvbmN1cnJlbnQgUkNVIHJlYWRlcnMNCj4odHJhbnNtaXR0ZXJzKSB0byBmaW5pc2g6
DQo+DQo+c3RhdGljIHZvaWQgY2xlYW51cF9iZWFyZXIoc3RydWN0IHdvcmtfc3RydWN0ICp3b3Jr
KSB7IC4uLg0KPglsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocmNhc3QsIHRtcCwgJnViLT5yY2Fz
dC5saXN0LCBsaXN0KSB7DQo+CQlkc3RfY2FjaGVfZGVzdHJveSgmcmNhc3QtPmRzdF9jYWNoZSk7
DQo+CQlsaXN0X2RlbF9yY3UoJnJjYXN0LT5saXN0KTsNCj4JCWtmcmVlX3JjdShyY2FzdCwgcmN1
KTsNCj4JfQ0KPi4uLg0KPglkc3RfY2FjaGVfZGVzdHJveSgmdWItPnJjYXN0LmRzdF9jYWNoZSk7
DQo+CXVkcF90dW5uZWxfc29ja19yZWxlYXNlKHViLT5zayk7DQo+CXN5bmNocm9uaXplX25ldCgp
Ow0KPi4uLg0KPn0NCj4NCj5UaGlzIGlzIGhpZ2hseSBidWdneSBiZWNhdXNlIGRzdF9jYWNoZV9k
ZXN0cm95KCkgaW1tZWRpYXRlbHkgZnJlZXMgdGhlIHBlci0NCj5DUFUgY2FjaGUgbWVtb3J5IChm
cmVlX3BlcmNwdSgpKSBhbmQgcmVsZWFzZXMgdGhlIGNhY2hlZCBkc3QgZW50cmllcw0KPndpdGhv
dXQgYW55IHN5bmNocm9uaXphdGlvbi4NCj4NCj5JZiBhIGNvbmN1cnJlbnQgdHJhbnNtaXR0ZXIg
KGUuZy4sIHRpcGNfdWRwX3htaXQoKSkgaXMgcnVubmluZyBvbiBhbm90aGVyIENQVQ0KPnVuZGVy
IFJDVSBwcm90ZWN0aW9uLCBpdCBjYW4gY2FsbCBkc3RfY2FjaGVfZ2V0KCkgY29uY3VycmVudGx5
LCBsZWFkaW5nIHRvOg0KPjEuIFVzZS1BZnRlci1GcmVlIG9uIHRoZSBwZXItQ1BVIGNhY2hlIHBv
aW50ZXIgaXRzZWxmIChjcmFzaCkuDQo+Mi4gInJjdXJlZiAtIGltYmFsYW5jZWQgcHV0KCkiIHdh
cm5pbmcgaWYgaXQgYXR0ZW1wdHMgdG8gcmVsZWFzZSBhDQo+ICAgZHN0IHRoYXQgd2FzIGNvbmN1
cnJlbnRseSByZWxlYXNlZCBieSBkc3RfY2FjaGVfZGVzdHJveSgpLg0KPg0KPkZ1cnRoZXJtb3Jl
LCBjYWxsaW5nIGtmcmVlKHViKSBpbW1lZGlhdGVseSBhZnRlciBzeW5jaHJvbml6ZV9uZXQoKSB3
aXRob3V0DQo+Y2xvc2luZyB0aGUgc29ja2V0IGZpcnN0IChvciB3YWl0aW5nIGFmdGVyIGNsb3Np
bmcgaXQpIGxlYXZlcyBhIHdpbmRvdyB3aGVyZSBhDQo+Y29uY3VycmVudCByZWNlaXZlciAodGlw
Y191ZHBfcmVjdigpKSBjb3VsZCBzdGFydCBhZnRlciBzeW5jaHJvbml6ZV9uZXQoKSwNCj5hY2Nl
c3MgdWIsIGFuZCBzdWZmZXIgYSBVQUYgd2hlbiBrZnJlZSh1YikgcnVucy4NCj4NCj5UbyBmaXgg
dGhpcywgd2UgbXVzdCBkZWZlciBkc3RfY2FjaGVfZGVzdHJveSgpIGFuZCBrZnJlZSh1YikgdW50
aWwgYWZ0ZXIgd2UgaGF2ZQ0KPmVuc3VyZWQgdGhhdCBubyBtb3JlIHJlYWRlcnMgY2FuIHNlZSB0
aGUgYmVhcmVyL3NvY2tldCBhbmQgYWxsIGV4aXN0aW5nDQo+cmVhZGVycyBoYXZlIGZpbmlzaGVk
Og0KPg0KPjEuIERlZmVyIHJjYXN0IGVudHJ5IGRlc3RydWN0aW9uIChib3RoIGRzdF9jYWNoZV9k
ZXN0cm95KCkgYW5kIGtmcmVlKCkpDQo+ICAgdG8gYW4gUkNVIGNhbGxiYWNrIHVzaW5nIGNhbGxf
cmN1X2h1cnJ5KCkuDQo+ICAgVXNpbmcgY2FsbF9yY3VfaHVycnkoKSBlbnN1cmVzIHRoZSBkc3Qg
ZW50cmllcyBhcmUgcmVsZWFzZWQgcXVpY2tseS4NCj4NCj4yLiBSZWxlYXNlIHRoZSBiZWFyZXIg
c29ja2V0IHVzaW5nIHVkcF90dW5uZWxfc29ja19yZWxlYXNlKCkgKHN0b3BzDQo+ICAgbmV3IHJl
Y2VpdmUgcmVhZGVycykuDQo+DQo+My4gQ2FsbCBzeW5jaHJvbml6ZV9uZXQoKSB0byB3YWl0IGZv
ciBhbGwgb3V0c3RhbmRpbmcgUkNVIHJlYWRlcnMNCj4gICAoYm90aCB0cmFuc21pdCBhbmQgcmVj
ZWl2ZSkgdG8gZmluaXNoLg0KPg0KPjQuIE5vdyB0aGF0IGl0IGlzIHNhZmUsIGNhbGwgZHN0X2Nh
Y2hlX2Rlc3Ryb3koKSBvbiB0aGUgbWFpbiBiZWFyZXINCj4gICBjYWNoZSwgYW5kIGZyZWUgdWIu
DQo+DQo+Tm90ZTogMykgYW5kIDQpIGNhbiBiZSBjaGFuZ2VkIGxhdGVyIGluIG5ldC1uZXh0IHRv
IGFsc28gdXNlDQo+Y2FsbF9yY3VfaHVycnkoKSBhbmQgZ2V0IHJpZCBvZiB0aGUgc3luY2hyb25p
emVfbmV0KCkgbGF0ZW5jeS4NCj4NCj5GaXhlczogZTljMWE3OTMyMTBmICgidGlwYzogYWRkIGRz
dF9jYWNoZSBzdXBwb3J0IGZvciB1ZHAgbWVkaWEiKQ0KPlJlcG9ydGVkLWJ5OiBzeXpib3QrZTE0
YmM1ZDQ5NDI3NTYwMjNiNzdAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KPkNsb3NlczoNCj5o
dHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvNmEzOTZhNjYuNTJhZTcyYzIuMTM2YWM3LjAw
MDMuR0FFQGdvb2dsZS4NCj5jb20vVC8jdQ0KPlNpZ25lZC1vZmYtYnk6IEVyaWMgRHVtYXpldCA8
ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4NCj5DYzogWGluIExvbmcgPGx1Y2llbi54aW5AZ21haWwuY29t
Pg0KPkNjOiBKb24gTWFsb3kgPGptYWxveUByZWRoYXQuY29tPg0KPkNjOiB0aXBjLWRpc2N1c3Np
b25AbGlzdHMuc291cmNlZm9yZ2UubmV0DQo+LS0tDQo+djI6IGFkZHJlc3NlZCBYaW4gTG9uZyBm
ZWVkYmFjaw0KPnYxOg0KPmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi9DQU5uODlpK2Rr
YnJTQXd2YVdYVzd5V01mY3dVZWJ1VEJMRw0KPjVUN0FHWmFaY3BWWUd5ZlFAbWFpbC5nbWFpbC5j
b20vVC8jbTdiYmVlZGZmZTNiZWRiNjllMzMyMzY0MTBlMzgzDQo+M2M3Y2U4MDk4NTANCj4gbmV0
L3RpcGMvdWRwX21lZGlhLmMgfCAxNSArKysrKysrKysrKy0tLS0NCj4gMSBmaWxlIGNoYW5nZWQs
IDExIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL25ldC90
aXBjL3VkcF9tZWRpYS5jIGIvbmV0L3RpcGMvdWRwX21lZGlhLmMgaW5kZXgNCj45ODhiOGE3Zjk1
M2FkNmRhODYwZTYxOTBmMWYyNDQ2NTBmMTIxZGNlLi42NmYzY2I4N2EwYWFhYWM4ZjQwZThmMjM3
YQ0KPmI5YTQ0ZDUzOWIxY2Q4IDEwMDY0NA0KPi0tLSBhL25ldC90aXBjL3VkcF9tZWRpYS5jDQo+
KysrIGIvbmV0L3RpcGMvdWRwX21lZGlhLmMNCj5AQCAtODAzLDYgKzgwMywxNCBAQCBzdGF0aWMg
aW50IHRpcGNfdWRwX2VuYWJsZShzdHJ1Y3QgbmV0ICpuZXQsIHN0cnVjdA0KPnRpcGNfYmVhcmVy
ICpiLA0KPiAJcmV0dXJuIGVycjsNCj4gfQ0KPg0KPitzdGF0aWMgdm9pZCByY2FzdF9mcmVlX3Jj
dShzdHJ1Y3QgcmN1X2hlYWQgKnJjdSkgew0KPisJc3RydWN0IHVkcF9yZXBsaWNhc3QgKnJjYXN0
ID0gY29udGFpbmVyX29mKHJjdSwgc3RydWN0IHVkcF9yZXBsaWNhc3QsDQo+K3JjdSk7DQoNClRo
aXMgbGluZSBpcyBsb25nIChvdmVyIDgwIGNvbHVtbnMpLiBQbGVhc2UgYnJlYWsgaXQgaW50byAy
IGxpbmVzIChyZWZlciB0byBsaW51eC9Eb2N1bWVudGF0aW9uL3Byb2Nlc3MvY29kaW5nLXN0eWxl
LnJzdCkuDQoNCj4rDQo+Kwlkc3RfY2FjaGVfZGVzdHJveSgmcmNhc3QtPmRzdF9jYWNoZSk7DQo+
KwlrZnJlZShyY2FzdCk7DQo+K30NCj4rDQo+IC8qIGNsZWFudXBfYmVhcmVyIC0gYnJlYWsgdGhl
IHNvY2tldC9iZWFyZXIgYXNzb2NpYXRpb24gKi8gIHN0YXRpYyB2b2lkDQo+Y2xlYW51cF9iZWFy
ZXIoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKSAgeyBAQCAtODExLDE4ICs4MTksMTcgQEAgc3Rh
dGljDQo+dm9pZCBjbGVhbnVwX2JlYXJlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+IAlz
dHJ1Y3QgdGlwY19uZXQgKnRuOw0KPg0KPiAJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHJjYXN0
LCB0bXAsICZ1Yi0+cmNhc3QubGlzdCwgbGlzdCkgew0KPi0JCWRzdF9jYWNoZV9kZXN0cm95KCZy
Y2FzdC0+ZHN0X2NhY2hlKTsNCj4gCQlsaXN0X2RlbF9yY3UoJnJjYXN0LT5saXN0KTsNCj4tCQlr
ZnJlZV9yY3UocmNhc3QsIHJjdSk7DQo+KwkJY2FsbF9yY3VfaHVycnkoJnJjYXN0LT5yY3UsIHJj
YXN0X2ZyZWVfcmN1KTsNCj4gCX0NCj4NCj4gCXRuID0gdGlwY19uZXQoc29ja19uZXQodWItPnNr
KSk7DQo+DQo+LQlkc3RfY2FjaGVfZGVzdHJveSgmdWItPnJjYXN0LmRzdF9jYWNoZSk7DQo+IAl1
ZHBfdHVubmVsX3NvY2tfcmVsZWFzZSh1Yi0+c2spOw0KPg0KPi0JLyogTm90ZTogY291bGQgdXNl
IGEgY2FsbF9yY3UoKSB0byBhdm9pZCBhbm90aGVyIHN5bmNocm9uaXplX25ldCgpICovDQo+IAlz
eW5jaHJvbml6ZV9uZXQoKTsNCj4rDQo+Kwlkc3RfY2FjaGVfZGVzdHJveSgmdWItPnJjYXN0LmRz
dF9jYWNoZSk7DQo+IAlhdG9taWNfZGVjKCZ0bi0+d3FfY291bnQpOw0KPiAJa2ZyZWUodWIpOw0K
PiB9DQo+LS0NCj4yLjU1LjAucmMwLjc5OS5nZDZmOTRlZDU5My1nb29nDQo+DQoNCg==

