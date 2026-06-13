Return-Path: <netdev+bounces-298889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gtiEEXXFLGrcWAQAu9opvQ
	(envelope-from <netdev+bounces-298889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 04:50:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9174E67D8F9
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 04:50:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=MTVuOSCb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298889-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298889-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09D03313FC66
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E8533D4F8;
	Sat, 13 Jun 2026 02:50:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18B1217659
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 02:50:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781319026; cv=fail; b=CqAVE2chSlPg4qLkNuUgBKTjbT7yf87Ekt/JugGhf9etWjfb2huHORCxceQcXYNyga0iEBbkarMTrCYOorfqhKJNsfrrjpljOThHHJ+n6DP67lsVTkNNnGSQqTkM8Oz0smdCjmvQEW9fnFXe0uHgshfKMD8FsfBLfqTa/GMJLc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781319026; c=relaxed/simple;
	bh=RawHnQy3pefrOVk8h3cfeiE+LgnJXGnnxiYgxxmCNfo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hR6fn7XHwBx2vGqQroQSmIyH81F+6aPPDjgd+95bR+v0pmtkAoBtkIb1P0mQ7pptKzURyOPHLe5oEiEF0ZVihfRIJo3lskRfxumWVLFDYmFWi8vN5p/wN0dWBpqQ2ZyK74blij4yNApmy4/gQ/98wTe7ZA3g/7v3ob/z19UfkqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=MTVuOSCb; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etbr3TN5cmX6byXx0EuXseOG8w1OJ5mJgiX6Vz80EOV+P5t5bMvONfmyk1FHiX6ffIr+rdnvz4+5tNL53gvQHPFs1Mx7jdNipBmMsINsmEMU9hehjc44ZpW7Src+OdL/1dT0JerQqqkzpDnVe/1ViZBTgVVoRwvEMn5STyGq+8el3vQYrpjugGwITeJWWIesRDXwTvq5Sf8FFzLkmC0xZ3Y/rbs5SEvilOMosgQtHdpDvyRFpFCT47wNe/Y29epO5lOYUegngRRV8l7CcidmYlaOO4GZrPB7QQq2mYt1vnk552zU9FwHcfVaEkKSK66yKasxv/j+RYmAKnQNl3alwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RawHnQy3pefrOVk8h3cfeiE+LgnJXGnnxiYgxxmCNfo=;
 b=TurUh3WxeyrF8/UUuwLSlMiBPrm8J5AOjpMbUoPcX927xKKmDGy+zuepXlSHF2GqEw7lPOLwg1sZTGtdJJZTH7ZJM1XQ+4DCtQMfNcFN8Id1ApufgwQ51wpN+BK6WAAr7sjrShQOWvewdm2j/mYyyo4BLoKdR0Ir+7coIuRZpCp8cIIvt3EZqcruYq8sc5KYoHlV9S6MnNxh427rCkRnjvnG+15BVSXUjVTROiYidfsS24GXC76C9XGTJ71nWUQt2k1Cmn5Kn4jKyX8WtP1c0V+s4qkJ8rwIrf72or5sBObL2++KGQq8ES5nbMKM54TQpbovTzAKc9DkOFrze4WLxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RawHnQy3pefrOVk8h3cfeiE+LgnJXGnnxiYgxxmCNfo=;
 b=MTVuOSCbpTymnKWaYqqVnzzOVUzAB9AlCUsfmQQ0ZTw4WToXNOMfIh6+6QkWiVTW0FJmzm07Rw7NeUWKfw9+ZPOJD+oEsfyLC3flbp4aCWMqFknM+XB8VLp62iPhkIeMvk3RVK0BoZIlu47qwSW5Hufw9AmjJ5d7zA9GU4k3768o42aRDWRqLkajbJJxCSeLrg3+ulBq/nTl4AeIuGWhXCqKSZMraiX8YxzGJRLxUKrQlTvLn9tbt6YUK/EkCHGqEDTEO6Uf6/Y9s/bYuMWZRLU6PWxJ7q32H4Bc+seFdicDDA9v2nPMzkP4ceS3W6v8tUSP5/WIfeqlV8Dky5Olww==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AM8P189MB1314.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:249::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.15; Sat, 13 Jun 2026 02:50:20 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0113.014; Sat, 13 Jun 2026
 02:50:20 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Eric Dumazet <edumazet@google.com>
CC: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
	"syzbot+64ec81389cbad56a8c35@syzkaller.appspotmail.com"
	<syzbot+64ec81389cbad56a8c35@syzkaller.appspotmail.com>, Jon Maloy
	<jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH net] tipc: fix UAF in tipc_l2_send_msg()
Thread-Topic: [PATCH net] tipc: fix UAF in tipc_l2_send_msg()
Thread-Index: AQHc+nPDQx+MvdTJDEy+XThdr3soDrY7x9RQ
Date: Sat, 13 Jun 2026 02:50:20 +0000
Message-ID:
 <GV1P189MB1988A0E785BF302589C9AE42C6192@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260612135949.4010482-1-edumazet@google.com>
In-Reply-To: <20260612135949.4010482-1-edumazet@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AM8P189MB1314:EE_
x-ms-office365-filtering-correlation-id: 903c6d63-fd5c-45fc-ca88-08dec8f6825a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|38070700021|18002099003|22082099003|11063799006|5023799004|56012099006;
x-microsoft-antispam-message-info:
 MHAxV8UGmZS2KtkqqkJvaHNtTdjq8I0U5YzPMw/zfFm0Tw23p13FAjd8tCnbQzw077oxn3OLNCiYsdAjeBNZ0KQvRcnhtdGde7wWUQdS4Kr5+bZhTk+KWqTX79ycebDyT4OSrKqw6W/QTcvlZMqw9PbAFKVYBWb60FEmlksUwIQLmvJHqtt/s+dwRb/hz+omORqg1AEAGD9LFOGwXaOAE0f97tHxYRES+FclBSD4w4ckcl/i7a2+o1j5ZgIRyNx2KuuhCRt4dieiqTROSd+Vq9NiIuUeI5I07yWRw1r5Rq3NcapYCDgSuBeJEo2JF35wcqLBTkWFRdLDnYK1vipgZESXBM+DhfMXYTrCjLuhWtUYCMmo0esjvAfUgCswtOU1lOzNJyov5JhBZTN+rhvxKqkxzmoeY4UmyCWZL7d4HAe3Hq3WTwreFZZ5TohlW1Q5IYUpGjIXe98ZVsN1gpl4I1HUvhAigFDk9TYPkz8ghUAjSvbhaK62hbN+LRzpeVC3TxDjjZGpS36y8hmgHjeKSulKBQRrNFVtSCI0hffkeIcTZbFsLUJKKRKzrmauVREelLbUg/cEVuyJNlQ1B4um/gIxV0xDD/g/b8+shzlvYK7Kq9VPv97rJ6hM8ZR8hi/uaC463Ii5CVuglLISZrp+DnAnrWqPzqIl1qJ9sbmF0eL5jNteazhOcfGAvr4gwXrz5UCc/ba8dYLc7Hjh13BvDIJsLNCDmNIhojLSXscFJV7camQipAnu3V2xm5PRcwqM
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SS9CVXMrZ1Jyc0QvZmFkMnZDdGoyNGhPYlI2SG9LSk9VRjE1eit6Y0MrcDZh?=
 =?utf-8?B?Z0ExMmZJNFB3a0ZEZDZNbm5UaGdQU1RIbDBkcFUvU0FhTDIzUjB2UVE0UFcy?=
 =?utf-8?B?aEMxVVFiTWcrRktxbGZERmlZeEVqdXFqaHFQUXdnaEg2eG5oMXBxaGlWUjlh?=
 =?utf-8?B?TUZIVlAzOUsxcTBrQlppa0pDQ01ITVMxbGhGZjBYMDEzbWlwTXRsWTNmeDZv?=
 =?utf-8?B?RXFUT3BCUG55ZlBsb3NDbXZTWTJIK0R3cWEwWm5OUjJuRTVoTjdSSWRnTFFT?=
 =?utf-8?B?OXBSYUNGQWcrZU0xQ2I0ZUcwY1k3NE1ZTzEzbGtHb1dwOHBoa2h3cEtOekRY?=
 =?utf-8?B?bFB0Y0VSWTJNUUkyZDlEdWxnK0tHUVkzcEtWdTlvaVorWGh4Z0xORktza0p1?=
 =?utf-8?B?SHZ4UGlhTG03YWl0eXZ3dnAzSU03R1ZxV1M2STU3K1Nhd2VZOGEvcW5oUWpa?=
 =?utf-8?B?QTRadjl6VmxOS09sMGZIT0RyZkJ0N3VGSGtWdGU2SjRaYjZpRzI1OWowVlJV?=
 =?utf-8?B?elRseHNvekk4aWRjSUdGbTF5dCszTXoveGJ5UHArV0prRGlFK3NSWHMzUlA2?=
 =?utf-8?B?QVdMKzM0NkpsNHpvMnA2Qm9MZ1RxdmtYVkFpMHhuTVR3cDZ4c3oxemNuUm56?=
 =?utf-8?B?aHpFdWNhTndJTlFEcU9rdnQrQjl6alpTYjYxY012Q2ZMRUFkT1BJalEvdVB6?=
 =?utf-8?B?MnArS1VCc0JRclZvbFVtbUFtWms0RzR0emgyT0s2WnR4YzFJWkdIc0QyWUFE?=
 =?utf-8?B?S3NqQVYyMGtmNlN4TEh6SjQ1WnFjMm1xcXpPVE1KanZvRHhoZ2dGaTBmNGxN?=
 =?utf-8?B?dDA1R2pSOVJtYWdQZTRFMldwcXozMkhXS2NTam10Ym9UU1RSU1Z6TTVUU0kx?=
 =?utf-8?B?YUVLVTJKaG5Kdjd5NDBsbktxK2xiZlRvRGdJZTVNLzh0dDVTUE8wYWZYam9v?=
 =?utf-8?B?UEEzb0hnK25CbUlQNEZ1MXE3YnRtTzdlbnIyQWtlK1BSNFRzalJieGVXL0JQ?=
 =?utf-8?B?UzlobStPL2JEemxTcEEvcVZJMFF1dFdTYjYxN1lwMUFVMFk1RTh3cU1SeCtr?=
 =?utf-8?B?dThxOE52YmZZSi85SW04NDZCVm1idGVhMDNnOHM4ZmN0N3VTNTZuazBxTlRj?=
 =?utf-8?B?dk85MUxNUHQ0dWMzNjl3MVlKVGYramc5SXJWUFJMY29UN0E0dnBwd3MvNitp?=
 =?utf-8?B?eGVlVkYrZHNUMzdCbzh6M1BFN0RROFEvckNkSk9KUzdxaEszS3BzaENaUjhH?=
 =?utf-8?B?SnZFdXJRWG82SE14UzhMTk1xY3JEVEY0dDRwNnc1UjlLQ0ZudlhTTHVOWlBS?=
 =?utf-8?B?NWZ4bUVjRlpEbjY0SmVRMWtNSU02YlZ6ZXpxcVRtd2lzR2RPbmpmMUFXQkRY?=
 =?utf-8?B?endOL0FHVGlaRk10ODBwWCtJTE5jQXpXT212Z3labFBaS0NHS3JaTlFSS0lr?=
 =?utf-8?B?Vm8yeDBMcTdUa1dUU1RHaHM0ZXpsUXRtV2dRTzhXVGVCSlR0ejZ4VFdPY1dh?=
 =?utf-8?B?cDVQQ2JZUlNSamxQRlBta1lNN1drNllPem9rcytBdmxmVHRRekNjdU9rQ2ZY?=
 =?utf-8?B?d3RBYjRvUnRmSFVsdkMrZ2hxUnY0UlNwSmZDRzdNa3VtdmlyNjAveU15TzBm?=
 =?utf-8?B?QmR0c3pYQlROVm9IenNSM2RpOElxcVVNcmRnaHJiY3hBMmFzS1lNQ0l0SmZx?=
 =?utf-8?B?eDNRM1RCa0RlMVlGZHFhVE9YakhmRGc4aitRYk9HUFNDZi9IZi9Db0ZUMUhZ?=
 =?utf-8?B?UitnRElYYXovd0lHNTFQa1EvVUdGMVQxbGp5K0FsaHB3ZmtDeU83ZlowRE93?=
 =?utf-8?B?c05lNzJOVzV0R2k4RDlCWEg3RzJqKzk1OVk4V3poMFdQTnp2RlcxOVkreFY5?=
 =?utf-8?B?eVpmeWNINWovSnkwZTVwUnBFd1h1YlZiK2MzMGZVZ3RKOGNHTGJrMkpmYllZ?=
 =?utf-8?B?ZXc3TlJGZWJiekF5bTQrMUVmZVhQK3Nxb0pCZXdrOHdrVnpoTFFFaERwQ0V0?=
 =?utf-8?B?V1VBWTdPODdDZTFBRzgvbjN0eGtXTGNLdlRoS3UvbXNGMmw3UlZKZXE2RVY1?=
 =?utf-8?B?Sm1pR3k0TSs4aFAxUDVWOTRZdUk4UkttaXVaNkpnNnNacHRFL2xNRDBicU9m?=
 =?utf-8?B?ZGprMzNlaXZNbWl3c1ZEV0hRRFp0NUdDTEZZaFJBVE4xcm5Zc01LZFdxUlNR?=
 =?utf-8?B?RzlUdmJ1R3R0amlEYUpoRVBnazZBSkcvVm4yTis0YlpsMGtkQm1oV3lhQ3Zq?=
 =?utf-8?B?RzI4UGU3ams0Slgyd1FKTTk2TnlEUHJkOVJ0NWhPOUxHblVHNkdtb3YwYklX?=
 =?utf-8?B?UkU1TG55MlBmU0FKUFR0NUU4bWxncUhJK1VsTXZsWWd5U0xjOHpVZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 903c6d63-fd5c-45fc-ca88-08dec8f6825a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2026 02:50:20.7315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6WdaCuBwPd+sapanRb+AAPXafX3+yi0yv5YsKUyUAaXdjYlSqv9us2bq3EAKI4yuxxlwA8pBB9Fy1m08UUl0rKoQxlYVU5Fi1iMlTKxWbR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P189MB1314
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298889-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+64ec81389cbad56a8c35@syzkaller.appspotmail.com,m:jmaloy@redhat.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[est.tech];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,redhat.com,davemloft.net];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev,64ec81389cbad56a8c35];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,est.tech:dkim,est.tech:from_mime,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9174E67D8F9

PlN1YmplY3Q6IFtQQVRDSCBuZXRdIHRpcGM6IGZpeCBVQUYgaW4gdGlwY19sMl9zZW5kX21zZygp
DQo+DQo+U3l6Ym90IHJlcG9ydGVkIGEgc2xhYi11c2UtYWZ0ZXItZnJlZSBpbiBpcHZsYW5faGFy
ZF9oZWFkZXIoKSB3aGVuIGNhbGxlZA0KPmZyb20gdGlwY19sMl9zZW5kX21zZygpLg0KPg0KPlRo
ZSByb290IGNhdXNlIGlzIHRoYXQgdGlwY19kaXNhYmxlX2wyX21lZGlhKCkgY2FsbHMgc3luY2hy
b25pemVfbmV0KCkgd2hpbGUgYi0NCj4+bWVkaWFfcHRyIGlzIHN0aWxsIHZhbGlkLiBUaGlzIGFs
bG93cyBjb25jdXJyZW50IFJDVSByZWFkZXJzIHRvIG9idGFpbiB0aGUNCj5kZXZpY2UgcG9pbnRl
ciBhZnRlciBzeW5jaHJvbml6ZV9uZXQoKSBoYXMgZmluaXNoZWQuDQo+VGhlIHBvaW50ZXIgaXMg
Y2xlYXJlZCBsYXRlciBpbiBiZWFyZXJfZGlzYWJsZSgpLCBidXQgd2l0aG91dCBhbnkgc3Vic2Vx
dWVudA0KPnN5bmNocm9uaXphdGlvbiwgYWxsb3dpbmcgdGhlIGRldmljZSB0byBiZSBmcmVlZCB3
aGlsZSBzdGlsbCBpbiB1c2UgYnkgcmVhZGVycy4NCj4NCj5GaXggdGhpcyBieSBjbGVhcmluZyBi
LT5tZWRpYV9wdHIgaW4gdGlwY19kaXNhYmxlX2wyX21lZGlhKCkgYmVmb3JlIGNhbGxpbmcNCj5z
eW5jaHJvbml6ZV9uZXQoKS4NCj4NCj5UaGlzIGlzIHNhZmUgdG8gZG8gbm93IGJlY2F1c2UgdGhl
IGNhbGwgb3JkZXIgaW4gYmVhcmVyX2Rpc2FibGUoKSB3YXMgcmV2ZXJzZWQNCj5pbiAwZDA1MWJm
OTNjMDYgKCJ0aXBjOiBtYWtlIGJlYXJlciBwYWNrZXQgZmlsdGVyaW5nIGdlbmVyaWMiKSB0byBj
YWxsDQo+dGlwY19ub2RlX2RlbGV0ZV9saW5rcygpICh3aGljaCBuZWVkcyB0aGUgcG9pbnRlcikg
YmVmb3JlIGRpc2FibGVfbWVkaWEoKS4NCj4NCj5GaXhlczogMjgyYjNhMDU2MjI1ICgidGlwYzog
c2VuZCBvdXQgUkVTRVQgaW1tZWRpYXRlbHkgd2hlbiBsaW5rIGdvZXMNCj5kb3duIikNCj5odHRw
czovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvNmEyYzEwMDcuNDI4ZmZlMjYuMjU4YjI3LjAxNWQu
R0FFQGdvb2dsZS5jDQo+b20vVC8jdQ0KPlJlcG9ydGVkLWJ5OiBzeXpib3QrNjRlYzgxMzg5Y2Jh
ZDU2YThjMzVAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KPlNpZ25lZC1vZmYtYnk6IEVyaWMg
RHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4NCj5DYzogSm9uIE1hbG95IDxqbWFsb3lAcmVk
aGF0LmNvbT4NCj4tLS0NCj4gbmV0L3RpcGMvYmVhcmVyLmMgfCAxICsNCj4gMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspDQo+DQo+ZGlmZiAtLWdpdCBhL25ldC90aXBjL2JlYXJlci5jIGIv
bmV0L3RpcGMvYmVhcmVyLmMgaW5kZXgNCj5hM2JkMWVmMTc1NThhMzc3ODdiYjkyZjJjMzgwNWMw
ZmRhODc0ZDhhLi4wNWRjZDJmOWU4ODdhNmU1Y2E2NjY1YWI0DQo+MWU0ZDViNTEwN2YxNThjIDEw
MDY0NA0KPi0tLSBhL25ldC90aXBjL2JlYXJlci5jDQo+KysrIGIvbmV0L3RpcGMvYmVhcmVyLmMN
Cj5AQCAtNDgyLDYgKzQ4Miw3IEBAIHZvaWQgdGlwY19kaXNhYmxlX2wyX21lZGlhKHN0cnVjdCB0
aXBjX2JlYXJlciAqYikNCj4gCWRldiA9IChzdHJ1Y3QgbmV0X2RldmljZSAqKXJ0bmxfZGVyZWZl
cmVuY2UoYi0+bWVkaWFfcHRyKTsNCj4gCWRldl9yZW1vdmVfcGFjaygmYi0+cHQpOw0KPiAJUkNV
X0lOSVRfUE9JTlRFUihkZXYtPnRpcGNfcHRyLCBOVUxMKTsNCj4rCVJDVV9JTklUX1BPSU5URVIo
Yi0+bWVkaWFfcHRyLCBOVUxMKTsNCg0KU2luY2UgJ2ItPm1lZGlhX3B0cicgaXMgcmVzZXQgaGVy
ZSwgU2hvdWxkIHRoZSBzYW1lIHJlc2V0IGJlIHJlbW92ZWQgaW4gYmVhcmVyX2Rpc2FibGUoKSA/
DQpiZWFyZXJfZGlzYWJsZSgpDQp7DQouLi4NClJDVV9JTklUX1BPSU5URVIoYi0+bWVkaWFfcHRy
LCBOVUxMKTsNCi4uLg0KfQ0KDQo+IAlzeW5jaHJvbml6ZV9uZXQoKTsNCj4gCWRldl9wdXQoZGV2
KTsNCj4gfQ0KPi0tDQo+Mi41NC4wLjExMzYuZ2RiMmNhMTY0YzQtZ29vZw0KPg0KDQo=

