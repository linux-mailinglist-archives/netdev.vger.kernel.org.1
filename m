Return-Path: <netdev+bounces-295900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RR7cHKf+Imr4gAEAu9opvQ
	(envelope-from <netdev+bounces-295900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 18:51:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF23649F22
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 18:51:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=dGxH2QuZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295900-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295900-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 546E3300D14C
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AEF36DA0C;
	Fri,  5 Jun 2026 16:36:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011027.outbound.protection.outlook.com [40.107.130.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21DA340403;
	Fri,  5 Jun 2026 16:35:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677373; cv=fail; b=VH06ZakXt2GU3vZdPGEZ71jAJU4MwaMYzwSXi/mqLw7nStp/mNoqh4ZlB0VunWVVx1kAMMh/sE72jUvGxg9t3K5itopvLAMVuJfF9O0uy6Vuznln4628JU4wO7oBOlNtWXNDSd4MTg5/MkOiJO+X6cGU35LVvmweQJxkDDQtPog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677373; c=relaxed/simple;
	bh=mk9u18catW3M0auIPk+uQOhwpw1/LuLa6WV4x0m8wQ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GI/YUaKzCYpnbnAPUaTeh7yFl/giAiqbQQkkjnkx6xKUyd2WB9CrOgaF3rnR+nO79mW5bqocj2c4eB+YVxhXuLr6kV5fyl7f+zAnzgnZaRnXot4/UKOuZaLvX750KFdh4JsngpYs4oIBejlWbKKFrm3yOmOHFdFcpVH1Bh6FF1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=dGxH2QuZ; arc=fail smtp.client-ip=40.107.130.27
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRSx0em8u6WHTohDayWoOVxPs+TXEOjItYHAqsXijDUhyfF+edRFAdoOPAiLUgcbRYbzmAVOhPDILFPL9Wqr2QFKPKN/kpDlo/YDhS8zhGZ3wECJEQgmdsTnosxWR+VxjMj/XRc3VZoCczzlXZTEOzly+LTFTu1KqxBmQWtj04o4ofxRJIVaYZKKwtmiyXDH+SwBbZ5oi353XyQk/JEFrihxqn5a6TiU3duIfzB4yTj7C0ZVYylk7prc12WIX/cDPQusy0Gh0zrWobEp6E5nSWKPwVNTdLsD6eo7Uz9IsQFsp4zPjziqRPx019IDWo4YhS28zq9VwpdU9fZCm4tXYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDy1GfuQXeilFdu031t9v0Mf7WwxMM8KFb41wDraYG0=;
 b=i6sjauU5DUmSSBunMgFarb+hux2AnYGlFt9zh4oJDI/sjDj5XF0XAFLb+NC/m2/rHxK1kJgSguoOGKn1A5jv++3jMHcTI04ylBGa1uUF7v4tkqh/o9kjFkwznMk7snIfzd3Bw5E8iTbzknvFCkeSSLi0z0it1twViFyou3O1NSsu420RjBz6zUAjWiWL3DUYeo4TvzzUlPLrM3G881QDlTO6MBBEIH8REzYzBHGBY34+GFX433egBycNuAlwoBmLbI7D9yl+04pKMo0HX1XniVinVSkB6DUp7irKJ+9pX7w++renlNSqt58/txPl0G/rkDVF+sYKLJlU3bf+zDH+hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDy1GfuQXeilFdu031t9v0Mf7WwxMM8KFb41wDraYG0=;
 b=dGxH2QuZjTgip2fbAAQcDjH78o0vS+wgE9GRaw1Tcddn1CP4ELESgJaRRgjHJPncVyiabZbubRhUfI0NFBz/hzBYLaQCaHCZAXxlYTjA/hmcxzLCYxNpYREc9nrkHXwcGGNA0MTJRJRtjSDCkH067Rs5f2UJI+fdQrKMs1RaTJQ6JLcVZFGYp8mXfBtp9NXAZqVQ62AZlaMqXSvBvKSNF/US4wgfpcYAEO0am66Kf96Y5AUWVcdpJqbFzQkPeZ8wS0JtOKK3H16zmHu4BoMY+zYGDDT0TfmvBM/tuRoV6wozbTQuic1+jDQ7W5Orak1d/Q8GAINIx2NttxKDiqTDeQ==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PA2P189MB2636.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:40e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Fri, 5 Jun 2026 16:35:53 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:35:53 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: "Bird, Tim" <Tim.Bird@sony.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-spdx@vger.kernel.org"
	<linux-spdx@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jmaloy@redhat.com" <jmaloy@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>
Subject: Re: [PATCH] tipc: Add SPDX id lines to source files
Thread-Topic: [PATCH] tipc: Add SPDX id lines to source files
Thread-Index: AQHc9FGJbV5WutgYYkuYt2Ohyz8RjbYvLawAgAD2YgCAAAJOpg==
Date: Fri, 5 Jun 2026 16:35:53 +0000
Message-ID:
 <GV1P189MB1988CF69395CB583074480F8C6112@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260604183805.747630-1-tim.bird@sony.com>
 <GV1P189MB1988FB0E53EA8D3FCC2533BDC6112@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <MW5PR13MB56323F0BA8638F14186DB228FD112@MW5PR13MB5632.namprd13.prod.outlook.com>
In-Reply-To:
 <MW5PR13MB56323F0BA8638F14186DB228FD112@MW5PR13MB5632.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PA2P189MB2636:EE_
x-ms-office365-filtering-correlation-id: 39be809c-a801-487e-04a7-08dec32082cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|7416014|1800799024|18002099003|6133799003|22082099003|38070700021|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info:
 zO/hF57FXii7ZIO8oy2jw9ZXn57W4SylK+BhWqMZmivhPV8jJwddGpz4VOiLXFBtlKUDnxIjEJ3OmI80F0jGZ6x0OI5qHFHSrlHXhOrhUf36S937aj028PmzjrWK/bnulOYYfVZLJHKJFBwF02v3RpbLUDcJzuIwVfmjJJtmiLxmAQmPjam/XWRMOso1AZ511wZJ/PSr3RkgNRYx90TtnvopwRjPvLNJ1R0t+AnIGbi0eneuLRjpuZ3p/9t63eHWOE2R3n+fRTs0w+A+k7qySE+ivIRrU8+PeIizUzYDXn/AHz5I5YHad9xoqM68SX6RUK/QUuErTRJdTDTTw1WJMgoDCJTpT1mJ7e8FZze+63oZXtW48/mdmmGJgy8TQTqLVqu9TFIyEaBpXRo6qKzXuGQO4Zwz3UmyZVoSnC7HbYsNPPYhI5Ps+V1/PdaGgZ2Ou903pWI0EZfMpwSHC0TB7LNGHZ7gNQXHQdl7JASdQHCPJVPm3km9kgu0IAGIP0K6cn1bIolG07MYp6uuVfrrc++zG7RfmKQs37+nL42qdjGGrwfnDxltJRRtA3m5XVlGDzhW7WIHMGqAjCxuCxRPcFzkGSIIgILJqHKD6GrkCSr3allEw3B6QFb8EfRi3EKSzEUA8AS0OpXpDdwOnMZYdhTrvZPzk2UaSURPUBTH3lKwFfTJb5tc+MsHqyMa8Q8uELBRgdeNNd6HgMyUaVVfKeZk/NSDzdOtT8dZzdBwhzAFN9gBb8YglYPkBjVIQj2H
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(18002099003)(6133799003)(22082099003)(38070700021)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?SfLnAxc+whB4H7xi/gr7STIhFl8diRg39HpLXSD044MgI9VflfqUg+S0sq?=
 =?iso-8859-1?Q?zkWbYXmmh/tvBLU+J9U7Mn6sq/XW3f2sQloLJr2kVKhiJ8U+rDU7oi/sFi?=
 =?iso-8859-1?Q?ZXYKRtPgqlVC3dB3fkBV0L9UO1Q+NZLXYCG3B/7DxosaJxZ6NI+0GgjkCg?=
 =?iso-8859-1?Q?PV9kdjO9niHRzQAj00H95IzGVVJRbpuRNcJJi3Z26c8GyUxx0x8zCH4p4i?=
 =?iso-8859-1?Q?o33jMBTHd2wozZExanRxXgZb80lJPX2rSE51zVBuo55Obj9FLJNIV1DfHM?=
 =?iso-8859-1?Q?u471XsL+8RCwOiwYbTknBALnPxXKiIw0kqgiMcYgYx4bDkvCrH8fR6MZB4?=
 =?iso-8859-1?Q?7Lvbb+rAnL/vYXiMcpuGei+f1K2GlAtN3Q5n8n8Ykw5EKkJlaZx+T1LuH9?=
 =?iso-8859-1?Q?lkNE4mRaX6DOXl7TYGBkOyEmu36LuINVrEXAplDDAk3DzNxoB5gnkn5TgZ?=
 =?iso-8859-1?Q?EAzsBL8nns6OCasolhZGt2prcXG88f7Lcg23AEu0g8v2TZsBMq+5c5SDJ6?=
 =?iso-8859-1?Q?gBMM/HpoBZUcHiOlqzqb97EUGwJqR0iTvyt4njY8iMJcYSmEvErcnLCEzO?=
 =?iso-8859-1?Q?YIckjy3HFYRNy1xJJOaXLi5WWd4F8FnZ+vzHwmAINEEaoKsUUqtc0pzUo/?=
 =?iso-8859-1?Q?XVECj8WRhLNEVdcqm03ygpyJ6HESMMkSvPQku0SCXDLN518qqVJGCX7qqQ?=
 =?iso-8859-1?Q?QGcSUMxXHZO0AFmqQ+LZmCvzCYNe4M0rTE6BhWoqmlLp/gkebuByIBw6Tn?=
 =?iso-8859-1?Q?LKZFGjVxEadOYXp0DfgPA86C/7SC0yI8uFpn4iqrpahyoM2YoPRiDOaTn9?=
 =?iso-8859-1?Q?aOSdodNMAVJ0Sfqqtfgy5GMRF/4RvwqS0plX6uxypXRNsjIrrFYyZlXsxz?=
 =?iso-8859-1?Q?iKzbLxtuFQNC01Bye4/SrhErXIkgWjTxznQB6LuAJhu3kqxC43o2U9jkxG?=
 =?iso-8859-1?Q?2z4Ln0DxfbMc+tvoWOFQPwB7uBKrOIlv+1JBcaefLRVCkazaVU6PNU6hNo?=
 =?iso-8859-1?Q?597dvsaPCbzUTLmjQTD6x3H+6wyZS9o8XznF9QEshpU4KJcUQoh4POaokp?=
 =?iso-8859-1?Q?TUkKCZrcbKj0NMPbWGt0vCF4SEf5yEHWM7w7Rmp3HsjZfLMQUEc7I77UQX?=
 =?iso-8859-1?Q?2YY4epHuMUGIEfQgL+CCDHLH0M4jdubNp8F3xwRDDBUDo0KqDzPmz2HWkx?=
 =?iso-8859-1?Q?3IW1Bttb/rZo5WSxUauxUHLk8m8VkVqI/aRnsvC2tQmmpsSOYl5e8x2XeV?=
 =?iso-8859-1?Q?iMomngeYRS6SXaJyms4+wlKeZZ5PKYT2wPUUrmOKKyLXzP/X6lE+KCq/j8?=
 =?iso-8859-1?Q?nCveOSSJV4mC1JuhrU8SCdN4feuFw11w8Zl+AniXi6fnlvrCL0jghUyYcU?=
 =?iso-8859-1?Q?xneJpPCGU/nZUfqZywCj72sMLw88Iinkmn5iJEYZYFisG2CnysfBGZCPbB?=
 =?iso-8859-1?Q?3rp/I+QWpdyESImMU0XntyhigpW7rH7LmOrZQDSE8SuFX4IzWH3Gg6mqCX?=
 =?iso-8859-1?Q?HRV+vCai7mPTsvUB4WzcPLWLfHMi2axydfN8BC3eZv/dmJnuzpx1d60FYn?=
 =?iso-8859-1?Q?YTiTBWqh5O4gzt6RzYgaFiUI0m2RD2GeD4Vp0M/O61KE8EAw03QipJsH8O?=
 =?iso-8859-1?Q?Jw+MxSQI6KiVg/3Q79CszYlg5AD/B8/56K4NxEQjMbedWzCiZOSV/Rskhr?=
 =?iso-8859-1?Q?kW0jeS/02cfUwT86HC8R0erZcrpeGzRLoKMGo+CVL6UDFc+Z9zlsgEWQGG?=
 =?iso-8859-1?Q?MKdhdN1ze+gX5+jdFkaJjQUOB55ey+p6qW2QfETlQNZEMF2e8HCnydNK0o?=
 =?iso-8859-1?Q?tAuASQwB1s75zrDuOIA6bulFTv/ZvwT5udog8ZVhg7skVcleiM+cn1p8IM?=
 =?iso-8859-1?Q?qe?=
x-ms-exchange-antispam-messagedata-1: v+CzQs6ES0tteQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 39be809c-a801-487e-04a7-08dec32082cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 16:35:53.3469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUjhafqJEFxQaNoMA/+I8dq46sm61z1ASCMLJ4KMP3cOSYPgr+TekjjjtS32+q1MaCOE5B9a1uuAnBWRuo9CqrEsMbl/JkZpfQTmz27uj5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P189MB2636
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[est.tech];
	TAGGED_FROM(0.00)[bounces-295900-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Tim.Bird@sony.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-spdx@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[est.tech:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sony.com:email,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,opensource.org:url,vger.kernel.org:from_smtp,est.tech:from_mime,est.tech:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DF23649F22

> Can you please explain why you believe the original license of TIPC is GP=
L-2.0 and not dual-licensed?=0A=
> Do you have evidence outside of the kernel repository and commit history =
that you are referring to?=0A=
=0A=
I referred to https://opensource.org/license/bsd-3-clause:=0A=
The first line "Copyright <YEAR> <COPYRIGHT HOLDER>" does not seem look lik=
e what describe in current files:=0A=
"* Copyright (c) 2004-2005, 2010-2011, Wind River Systems=0A=
  * Copyright (c) 2020-2021, Red Hat Inc=0A=
 * All rights reserved.=0A=
"=0A=
Further more, GPL is mentioned in the paragraph makes me think that it is f=
or GPL-2.0 license only.=0A=
I might be wrong or miss some history of current headers.=0A=
=0A=
> The current text in the headers of all these files contains the full, exa=
ct text of the BSD-3-Clause=0A=
> license, along with a statement that "Alternatively, this software may be=
 distributed under the terms of the=0A=
> GNU General Public License ("GPL") version 2 as published by the Free Sof=
tware Foundation."  This has=0A=
> been the case since 2006, when this code was introduced into the kernel s=
ource tree*.=0A=
=0A=
> This is the one of the most unambiguous cases of dual licensing I have en=
countered while working on=0A=
> these SPDX ID Lines.=0A=
 > -- Tim=0A=
=0A=
> * Details:=0A=
> Per Lindon, working for Ericsson, introduced most of these files on Jan 2=
, 2006, with a BSD-3-Clause=0A=
> license.  Most of the files were introduced with commit b97bf3fd8f6a=0A=
> On Jan 11, 2006, a little over a week later, Per clarified that the licen=
se was intended to be dual licensed,=0A=
> and added the "Alternatively..." clause.  This was in commit 9ea1fd3c1a15=
.=0A=
=0A=
> >=0A=
> >Signed-off-by: Tim Bird <tim.bird@sony.com>=0A=
> >---=0A=
> > net/tipc/addr.c           | 29 +----------------------------=0A=
> > net/tipc/addr.h           | 29 +----------------------------=0A=
> > net/tipc/bcast.c          | 29 +----------------------------=0A=
> > net/tipc/bcast.h          | 29 +----------------------------=0A=
> > net/tipc/bearer.c         | 29 +----------------------------=0A=
> > net/tipc/bearer.h         | 29 +----------------------------=0A=
> > net/tipc/core.c           | 29 +----------------------------=0A=
> > net/tipc/core.h           | 29 +----------------------------=0A=
> > net/tipc/diag.c           | 29 +----------------------------=0A=
> > net/tipc/discover.c       | 29 +----------------------------=0A=
> > net/tipc/discover.h       | 29 +----------------------------=0A=
> > net/tipc/eth_media.c      | 29 +----------------------------=0A=
> > net/tipc/group.c          | 29 +----------------------------=0A=
> > net/tipc/group.h          | 29 +----------------------------=0A=
> > net/tipc/ib_media.c       | 29 +----------------------------=0A=
> > net/tipc/link.c           | 29 +----------------------------=0A=
> > net/tipc/link.h           | 29 +----------------------------=0A=
> > net/tipc/monitor.c        | 29 +----------------------------=0A=
> > net/tipc/monitor.h        | 29 +----------------------------=0A=
> > net/tipc/msg.c            | 29 +----------------------------=0A=
> > net/tipc/msg.h            | 29 +----------------------------=0A=
> > net/tipc/name_distr.c     | 29 +----------------------------=0A=
> > net/tipc/name_distr.h     | 29 +----------------------------=0A=
> > net/tipc/name_table.c     | 29 +----------------------------=0A=
> > net/tipc/name_table.h     | 29 +----------------------------=0A=
> > net/tipc/net.c            | 29 +----------------------------=0A=
> > net/tipc/net.h            | 29 +----------------------------=0A=
> > net/tipc/netlink.c        | 29 +----------------------------=0A=
> > net/tipc/netlink.h        | 29 +----------------------------=0A=
> > net/tipc/netlink_compat.c | 29 +----------------------------=0A=
> > net/tipc/node.c           | 29 +----------------------------=0A=
> > net/tipc/node.h           | 29 +----------------------------=0A=
> > net/tipc/socket.c         | 29 +----------------------------=0A=
> > net/tipc/socket.h         | 29 +----------------------------=0A=
> > net/tipc/subscr.c         | 29 +----------------------------=0A=
> > net/tipc/subscr.h         | 29 +----------------------------=0A=
> > net/tipc/sysctl.c         | 29 +----------------------------=0A=
> > net/tipc/topsrv.c         | 29 +----------------------------=0A=
> > net/tipc/topsrv.h         | 29 +----------------------------=0A=
> > net/tipc/trace.c          | 29 +----------------------------=0A=
> > net/tipc/trace.h          | 29 +----------------------------=0A=
> > net/tipc/udp_media.c      | 29 +----------------------------=0A=
> > net/tipc/udp_media.h      | 29 +----------------------------=0A=
> > 43 files changed, 43 insertions(+), 1204 deletions(-)=0A=
> >=0A=
> >diff --git a/net/tipc/addr.c b/net/tipc/addr.c=0A=
> >index 6f5c54cbf8d9..ee73b58bcc69 100644=0A=
> >--- a/net/tipc/addr.c=0A=
> >+++ b/net/tipc/addr.c=0A=
> >@@ -1,3 +1,4 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/addr.c: TIPC address utility routines=0A=
> >  *=0A=
> >@@ -5,34 +6,6 @@=0A=
> >  * Copyright (c) 2004-2005, 2010-2011, Wind River Systems=0A=
> >  * Copyright (c) 2020-2021, Red Hat Inc=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include "addr.h"=0A=
> >diff --git a/net/tipc/addr.h b/net/tipc/addr.h=0A=
> >index a113cf7e1f89..0eccd4719092 100644=0A=
> >--- a/net/tipc/addr.h=0A=
> >+++ b/net/tipc/addr.h=0A=
> >@@ -1,3 +1,4 @@=0A=
> >+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */=0A=
> > /*=0A=
> >  * net/tipc/addr.h: Include file for TIPC address utility routines=0A=
> >  *=0A=
> >@@ -5,34 +6,6 @@=0A=
> >  * Copyright (c) 2004-2005, Wind River Systems=0A=
> >  * Copyright (c) 2020-2021, Red Hat Inc=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #ifndef _TIPC_ADDR_H=0A=
> >diff --git a/net/tipc/bcast.c b/net/tipc/bcast.c=0A=
> >index 76a1585d3f6b..27dbb5fcdb3a 100644=0A=
> >--- a/net/tipc/bcast.c=0A=
> >+++ b/net/tipc/bcast.c=0A=
> >@@ -1,3 +1,4 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/bcast.c: TIPC broadcast code=0A=
> >  *=0A=
> >@@ -5,34 +6,6 @@=0A=
> >  * Copyright (c) 2004, Intel Corporation.=0A=
> >  * Copyright (c) 2005, 2010-2011, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include <linux/tipc_config.h>=0A=
> >diff --git a/net/tipc/bcast.h b/net/tipc/bcast.h=0A=
> >index 2d9352dc7b0e..8a453b3796af 100644=0A=
> >--- a/net/tipc/bcast.h=0A=
> >+++ b/net/tipc/bcast.h=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */=0A=
> > /*=0A=
> >  * net/tipc/bcast.h: Include file for TIPC broadcast code=0A=
> >  *=0A=
> >  * Copyright (c) 2003-2006, 2014-2015, Ericsson AB=0A=
> >  * Copyright (c) 2005, 2010-2011, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #ifndef _TIPC_BCAST_H=0A=
> >diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c=0A=
> >index a3bd1ef17558..ba362ea61ccf 100644=0A=
> >--- a/net/tipc/bearer.c=0A=
> >+++ b/net/tipc/bearer.c=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/bearer.c: TIPC bearer code=0A=
> >  *=0A=
> >  * Copyright (c) 1996-2006, 2013-2016, Ericsson AB=0A=
> >  * Copyright (c) 2004-2006, 2010-2013, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include <net/sock.h>=0A=
> >diff --git a/net/tipc/bearer.h b/net/tipc/bearer.h=0A=
> >index 41eac1ee0c09..ce913ac16924 100644=0A=
> >--- a/net/tipc/bearer.h=0A=
> >+++ b/net/tipc/bearer.h=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */=0A=
> > /*=0A=
> >  * net/tipc/bearer.h: Include file for TIPC bearer code=0A=
> >  *=0A=
> >  * Copyright (c) 1996-2006, 2013-2016, Ericsson AB=0A=
> >  * Copyright (c) 2005, 2010-2011, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #ifndef _TIPC_BEARER_H=0A=
> >diff --git a/net/tipc/core.c b/net/tipc/core.c=0A=
> >index 434e70eabe08..0fa53f05fd10 100644=0A=
> >--- a/net/tipc/core.c=0A=
> >+++ b/net/tipc/core.c=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/core.c: TIPC module code=0A=
> >  *=0A=
> >  * Copyright (c) 2003-2006, 2013, Ericsson AB=0A=
> >  * Copyright (c) 2005-2006, 2010-2013, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include "core.h"=0A=
> >diff --git a/net/tipc/core.h b/net/tipc/core.h=0A=
> >index 9ce5f9ff6cc0..ff96b66c8bb7 100644=0A=
> >--- a/net/tipc/core.h=0A=
> >+++ b/net/tipc/core.h=0A=
> >@@ -1,3 +1,4 @@=0A=
> >+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */=0A=
> > /*=0A=
> >  * net/tipc/core.h: Include file for TIPC global declarations=0A=
> >  *=0A=
> >@@ -5,34 +6,6 @@=0A=
> >  * Copyright (c) 2005-2007, 2010-2013, Wind River Systems=0A=
> >  * Copyright (c) 2020, Red Hat Inc=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #ifndef _TIPC_CORE_H=0A=
> >diff --git a/net/tipc/diag.c b/net/tipc/diag.c=0A=
> >index 54dde8c4e4d4..e6a1cb0a52da 100644=0A=
> >--- a/net/tipc/diag.c=0A=
> >+++ b/net/tipc/diag.c=0A=
> >@@ -1,36 +1,9 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/diag.c: TIPC socket diag=0A=
> >  *=0A=
> >  * Copyright (c) 2018, Ericsson AB=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "ASIS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO,THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include "core.h"=0A=
> >diff --git a/net/tipc/discover.c b/net/tipc/discover.c=0A=
> >index 3e54d2df5683..bb4d7c066521 100644=0A=
> >--- a/net/tipc/discover.c=0A=
> >+++ b/net/tipc/discover.c=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/discover.c=0A=
> >  *=0A=
> >  * Copyright (c) 2003-2006, 2014-2018, Ericsson AB=0A=
> >  * Copyright (c) 2005-2006, 2010-2011, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include "core.h"=0A=
> >diff --git a/net/tipc/discover.h b/net/tipc/discover.h=0A=
> >index 521d96c41dfd..87945cd1ed62 100644=0A=
> >--- a/net/tipc/discover.h=0A=
> >+++ b/net/tipc/discover.h=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */=0A=
> > /*=0A=
> >  * net/tipc/discover.h=0A=
> >  *=0A=
> >  * Copyright (c) 2003-2006, Ericsson AB=0A=
> >  * Copyright (c) 2005, 2010-2011, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #ifndef _TIPC_DISCOVER_H=0A=
> >diff --git a/net/tipc/eth_media.c b/net/tipc/eth_media.c=0A=
> >index cb0d185e06af..3eb8c5218f73 100644=0A=
> >--- a/net/tipc/eth_media.c=0A=
> >+++ b/net/tipc/eth_media.c=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/eth_media.c: Ethernet bearer support for TIPC=0A=
> >  *=0A=
> >  * Copyright (c) 2001-2007, 2013-2014, Ericsson AB=0A=
> >  * Copyright (c) 2005-2008, 2011-2013, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include "core.h"=0A=
> >diff --git a/net/tipc/group.c b/net/tipc/group.c=0A=
> >index 14e6732624e2..5b2990b1533e 100644=0A=
> >--- a/net/tipc/group.c=0A=
> >+++ b/net/tipc/group.c=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/group.c: TIPC group messaging code=0A=
> >  *=0A=
> >  * Copyright (c) 2017, Ericsson AB=0A=
> >  * Copyright (c) 2020, Red Hat Inc=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include "core.h"=0A=
> >diff --git a/net/tipc/group.h b/net/tipc/group.h=0A=
> >index ea4c3be64c78..2eefe626d550 100644=0A=
> >--- a/net/tipc/group.h=0A=
> >+++ b/net/tipc/group.h=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */=0A=
> > /*=0A=
> >  * net/tipc/group.h: Include file for TIPC group unicast/multicast func=
tions=0A=
> >  *=0A=
> >  * Copyright (c) 2017, Ericsson AB=0A=
> >  * Copyright (c) 2020, Red Hat Inc=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #ifndef _TIPC_GROUP_H=0A=
> >diff --git a/net/tipc/ib_media.c b/net/tipc/ib_media.c=0A=
> >index b9ad0434c3cd..504d36777a23 100644=0A=
> >--- a/net/tipc/ib_media.c=0A=
> >+++ b/net/tipc/ib_media.c=0A=
> >@@ -1,3 +1,4 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/ib_media.c: Infiniband bearer support for TIPC=0A=
> >  *=0A=
> >@@ -8,34 +9,6 @@=0A=
> >  * Copyright (c) 2001-2007, Ericsson AB=0A=
> >  * Copyright (c) 2005-2008, 2011, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include <linux/if_infiniband.h>=0A=
> >diff --git a/net/tipc/link.c b/net/tipc/link.c=0A=
> >index 49dfc098d89b..ff966b9892ee 100644=0A=
> >--- a/net/tipc/link.c=0A=
> >+++ b/net/tipc/link.c=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/link.c: TIPC link code=0A=
> >  *=0A=
> >  * Copyright (c) 1996-2007, 2012-2016, Ericsson AB=0A=
> >  * Copyright (c) 2004-2007, 2010-2013, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include "core.h"=0A=
> >diff --git a/net/tipc/link.h b/net/tipc/link.h=0A=
> >index d80f5649b395..102ff0184fa8 100644=0A=
> >--- a/net/tipc/link.h=0A=
> >+++ b/net/tipc/link.h=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */=0A=
> > /*=0A=
> >  * net/tipc/link.h: Include file for TIPC link code=0A=
> >  *=0A=
> >  * Copyright (c) 1995-2006, 2013-2014, Ericsson AB=0A=
> >  * Copyright (c) 2004-2005, 2010-2011, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #ifndef _TIPC_LINK_H=0A=
> >diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c=0A=
> >index a94b9b36a700..fe1906e103d3 100644=0A=
> >--- a/net/tipc/monitor.c=0A=
> >+++ b/net/tipc/monitor.c=0A=
> >@@ -1,36 +1,9 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/monitor.c=0A=
> >  *=0A=
> >  * Copyright (c) 2016, Ericsson AB=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include <net/genetlink.h>=0A=
> >diff --git a/net/tipc/monitor.h b/net/tipc/monitor.h=0A=
> >index ed63d2e650b0..3b849c683371 100644=0A=
> >--- a/net/tipc/monitor.h=0A=
> >+++ b/net/tipc/monitor.h=0A=
> >@@ -1,36 +1,9 @@=0A=
> >+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */=0A=
> > /*=0A=
> >  * net/tipc/monitor.h=0A=
> >  *=0A=
> >  * Copyright (c) 2015, Ericsson AB=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #ifndef _TIPC_MONITOR_H=0A=
> >diff --git a/net/tipc/msg.c b/net/tipc/msg.c=0A=
> >index b0bba0feef56..22f0274c4505 100644=0A=
> >--- a/net/tipc/msg.c=0A=
> >+++ b/net/tipc/msg.c=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/msg.c: TIPC message header routines=0A=
> >  *=0A=
> >  * Copyright (c) 2000-2006, 2014-2015, Ericsson AB=0A=
> >  * Copyright (c) 2005, 2010-2011, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include <net/sock.h>=0A=
> >diff --git a/net/tipc/msg.h b/net/tipc/msg.h=0A=
> >index c5eec16213d7..3416bf07869e 100644=0A=
> >--- a/net/tipc/msg.h=0A=
> >+++ b/net/tipc/msg.h=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */=0A=
> > /*=0A=
> >  * net/tipc/msg.h: Include file for TIPC message header routines=0A=
> >  *=0A=
> >  * Copyright (c) 2000-2007, 2014-2017 Ericsson AB=0A=
> >  * Copyright (c) 2005-2008, 2010-2011, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #ifndef _TIPC_MSG_H=0A=
> >diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c=0A=
> >index 190b49c5cbc3..e9af08463caf 100644=0A=
> >--- a/net/tipc/name_distr.c=0A=
> >+++ b/net/tipc/name_distr.c=0A=
> >@@ -1,3 +1,4 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/name_distr.c: TIPC name distribution code=0A=
> >  *=0A=
> >@@ -5,34 +6,6 @@=0A=
> >  * Copyright (c) 2005, 2010-2011, Wind River Systems=0A=
> >  * Copyright (c) 2020-2021, Red Hat Inc=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include "core.h"=0A=
> >diff --git a/net/tipc/name_distr.h b/net/tipc/name_distr.h=0A=
> >index c677f6f082df..cd08ec9943f9 100644=0A=
> >--- a/net/tipc/name_distr.h=0A=
> >+++ b/net/tipc/name_distr.h=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */=0A=
> > /*=0A=
> >  * net/tipc/name_distr.h: Include file for TIPC name distribution code=
=0A=
> >  *=0A=
> >  * Copyright (c) 2000-2006, Ericsson AB=0A=
> >  * Copyright (c) 2005, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #ifndef _TIPC_NAME_DISTR_H=0A=
> >diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c=0A=
> >index 253c72d1366e..b0f95a13a812 100644=0A=
> >--- a/net/tipc/name_table.c=0A=
> >+++ b/net/tipc/name_table.c=0A=
> >@@ -1,3 +1,4 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/name_table.c: TIPC name table code=0A=
> >  *=0A=
> >@@ -5,34 +6,6 @@=0A=
> >  * Copyright (c) 2004-2008, 2010-2014, Wind River Systems=0A=
> >  * Copyright (c) 2020-2021, Red Hat Inc=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include <net/sock.h>=0A=
> >diff --git a/net/tipc/name_table.h b/net/tipc/name_table.h=0A=
> >index 7ff6eeebaae6..fff7e79dd936 100644=0A=
> >--- a/net/tipc/name_table.h=0A=
> >+++ b/net/tipc/name_table.h=0A=
> >@@ -1,3 +1,4 @@=0A=
> >+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */=0A=
> > /*=0A=
> >  * net/tipc/name_table.h: Include file for TIPC name table code=0A=
> >  *=0A=
> >@@ -5,34 +6,6 @@=0A=
> >  * Copyright (c) 2004-2005, 2010-2011, Wind River Systems=0A=
> >  * Copyright (c) 2020-2021, Red Hat Inc=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #ifndef _TIPC_NAME_TABLE_H=0A=
> >diff --git a/net/tipc/net.c b/net/tipc/net.c=0A=
> >index 7e65d0b0c4a8..1883f1a76d6b 100644=0A=
> >--- a/net/tipc/net.c=0A=
> >+++ b/net/tipc/net.c=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/net.c: TIPC network routing code=0A=
> >  *=0A=
> >  * Copyright (c) 1995-2006, 2014, Ericsson AB=0A=
> >  * Copyright (c) 2005, 2010-2011, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include "core.h"=0A=
> >diff --git a/net/tipc/net.h b/net/tipc/net.h=0A=
> >index 1cb1e43cf34a..1c56ae964c46 100644=0A=
> >--- a/net/tipc/net.h=0A=
> >+++ b/net/tipc/net.h=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */=0A=
> > /*=0A=
> >  * net/tipc/net.h: Include file for TIPC network routing code=0A=
> >  *=0A=
> >  * Copyright (c) 1995-2006, 2014, Ericsson AB=0A=
> >  * Copyright (c) 2005, 2010-2011, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #ifndef _TIPC_NET_H=0A=
> >diff --git a/net/tipc/netlink.c b/net/tipc/netlink.c=0A=
> >index 1a9a5bdaccf4..8dc5b1daee5b 100644=0A=
> >--- a/net/tipc/netlink.c=0A=
> >+++ b/net/tipc/netlink.c=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/netlink.c: TIPC configuration handling=0A=
> >  *=0A=
> >  * Copyright (c) 2005-2006, 2014, Ericsson AB=0A=
> >  * Copyright (c) 2005-2007, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include "core.h"=0A=
> >diff --git a/net/tipc/netlink.h b/net/tipc/netlink.h=0A=
> >index 7cf777723e3e..56b395b216a6 100644=0A=
> >--- a/net/tipc/netlink.h=0A=
> >+++ b/net/tipc/netlink.h=0A=
> >@@ -1,36 +1,9 @@=0A=
> >+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */=0A=
> > /*=0A=
> >  * net/tipc/netlink.h: Include file for TIPC netlink code=0A=
> >  *=0A=
> >  * Copyright (c) 2014, Ericsson AB=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #ifndef _TIPC_NETLINK_H=0A=
> >diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c=0A=
> >index 2a786c56c8c5..c110b9844a91 100644=0A=
> >--- a/net/tipc/netlink_compat.c=0A=
> >+++ b/net/tipc/netlink_compat.c=0A=
> >@@ -1,34 +1,7 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * Copyright (c) 2014, Ericsson AB=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include "core.h"=0A=
> >diff --git a/net/tipc/node.c b/net/tipc/node.c=0A=
> >index 97aa970a0d83..724fec939a85 100644=0A=
> >--- a/net/tipc/node.c=0A=
> >+++ b/net/tipc/node.c=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/node.c: TIPC node management routines=0A=
> >  *=0A=
> >  * Copyright (c) 2000-2006, 2012-2016, Ericsson AB=0A=
> >  * Copyright (c) 2005-2006, 2010-2014, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include "core.h"=0A=
> >diff --git a/net/tipc/node.h b/net/tipc/node.h=0A=
> >index 154a5bbb0d29..28da1d7025e5 100644=0A=
> >--- a/net/tipc/node.h=0A=
> >+++ b/net/tipc/node.h=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */=0A=
> > /*=0A=
> >  * net/tipc/node.h: Include file for TIPC node management routines=0A=
> >  *=0A=
> >  * Copyright (c) 2000-2006, 2014-2016, Ericsson AB=0A=
> >  * Copyright (c) 2005, 2010-2014, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #ifndef _TIPC_NODE_H=0A=
> >diff --git a/net/tipc/socket.c b/net/tipc/socket.c=0A=
> >index 9329919fb07f..ec79eb6e35b3 100644=0A=
> >--- a/net/tipc/socket.c=0A=
> >+++ b/net/tipc/socket.c=0A=
> >@@ -1,3 +1,4 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/socket.c: TIPC socket API=0A=
> >  *=0A=
> >@@ -5,34 +6,6 @@=0A=
> >  * Copyright (c) 2004-2008, 2010-2013, Wind River Systems=0A=
> >  * Copyright (c) 2020-2021, Red Hat Inc=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include <linux/rhashtable.h>=0A=
> >diff --git a/net/tipc/socket.h b/net/tipc/socket.h=0A=
> >index 02cdf166807d..4d3a31590395 100644=0A=
> >--- a/net/tipc/socket.h=0A=
> >+++ b/net/tipc/socket.h=0A=
> >@@ -1,35 +1,8 @@=0A=
> >+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */=0A=
> > /* net/tipc/socket.h: Include file for TIPC socket code=0A=
> >  *=0A=
> >  * Copyright (c) 2014-2016, Ericsson AB=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #ifndef _TIPC_SOCK_H=0A=
> >diff --git a/net/tipc/subscr.c b/net/tipc/subscr.c=0A=
> >index 352d304c3acd..6d6c34871485 100644=0A=
> >--- a/net/tipc/subscr.c=0A=
> >+++ b/net/tipc/subscr.c=0A=
> >@@ -1,3 +1,4 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/subscr.c: TIPC network topology service=0A=
> >  *=0A=
> >@@ -5,34 +6,6 @@=0A=
> >  * Copyright (c) 2005-2007, 2010-2013, Wind River Systems=0A=
> >  * Copyright (c) 2020-2021, Red Hat Inc=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include "core.h"=0A=
> >diff --git a/net/tipc/subscr.h b/net/tipc/subscr.h=0A=
> >index 60b877531b66..0262e6589b69 100644=0A=
> >--- a/net/tipc/subscr.h=0A=
> >+++ b/net/tipc/subscr.h=0A=
> >@@ -1,3 +1,4 @@=0A=
> >+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */=0A=
> > /*=0A=
> >  * net/tipc/subscr.h: Include file for TIPC network topology service=0A=
> >  *=0A=
> >@@ -5,34 +6,6 @@=0A=
> >  * Copyright (c) 2005-2007, 2012-2013, Wind River Systems=0A=
> >  * Copyright (c) 2020-2021, Red Hat Inc=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #ifndef _TIPC_SUBSCR_H=0A=
> >diff --git a/net/tipc/sysctl.c b/net/tipc/sysctl.c=0A=
> >index 30d2e06e3d8c..1ce7c6dea30b 100644=0A=
> >--- a/net/tipc/sysctl.c=0A=
> >+++ b/net/tipc/sysctl.c=0A=
> >@@ -1,36 +1,9 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/sysctl.c: sysctl interface to TIPC subsystem=0A=
> >  *=0A=
> >  * Copyright (c) 2013, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include "core.h"=0A=
> >diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c=0A=
> >index af530c9ed840..9346578327d2 100644=0A=
> >--- a/net/tipc/topsrv.c=0A=
> >+++ b/net/tipc/topsrv.c=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/server.c: TIPC server infrastructure=0A=
> >  *=0A=
> >  * Copyright (c) 2012-2013, Wind River Systems=0A=
> >  * Copyright (c) 2017-2018, Ericsson AB=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include "subscr.h"=0A=
> >diff --git a/net/tipc/topsrv.h b/net/tipc/topsrv.h=0A=
> >index c7ea71293748..b98c37c98738 100644=0A=
> >--- a/net/tipc/topsrv.h=0A=
> >+++ b/net/tipc/topsrv.h=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */=0A=
> > /*=0A=
> >  * net/tipc/server.h: Include file for TIPC server code=0A=
> >  *=0A=
> >  * Copyright (c) 2012-2013, Wind River Systems=0A=
> >  * Copyright (c) 2017, Ericsson AB=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #ifndef _TIPC_SERVER_H=0A=
> >diff --git a/net/tipc/trace.c b/net/tipc/trace.c=0A=
> >index 7d2931521e0e..e052e59dfb44 100644=0A=
> >--- a/net/tipc/trace.c=0A=
> >+++ b/net/tipc/trace.c=0A=
> >@@ -1,36 +1,9 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /*=0A=
> >  * net/tipc/trace.c: TIPC tracepoints code=0A=
> >  *=0A=
> >  * Copyright (c) 2018, Ericsson AB=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "ASIS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO,THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #define CREATE_TRACE_POINTS=0A=
> >diff --git a/net/tipc/trace.h b/net/tipc/trace.h=0A=
> >index 865142ed0ab4..47656cb64c67 100644=0A=
> >--- a/net/tipc/trace.h=0A=
> >+++ b/net/tipc/trace.h=0A=
> >@@ -1,36 +1,9 @@=0A=
> >+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */=0A=
> > /*=0A=
> >  * net/tipc/trace.h: TIPC tracepoints=0A=
> >  *=0A=
> >  * Copyright (c) 2018, Ericsson AB=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "ASIS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO,THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #undef TRACE_SYSTEM=0A=
> >diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c=0A=
> >index 2c66b356025a..b2aeb63ad48f 100644=0A=
> >--- a/net/tipc/udp_media.c=0A=
> >+++ b/net/tipc/udp_media.c=0A=
> >@@ -1,35 +1,8 @@=0A=
> >+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause=0A=
> > /* net/tipc/udp_media.c: IP bearer support for TIPC=0A=
> >  *=0A=
> >  * Copyright (c) 2015, Ericsson AB=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #include <linux/socket.h>=0A=
> >diff --git a/net/tipc/udp_media.h b/net/tipc/udp_media.h=0A=
> >index e7455cc73e16..8b92aef7246a 100644=0A=
> >--- a/net/tipc/udp_media.h=0A=
> >+++ b/net/tipc/udp_media.h=0A=
> >@@ -1,37 +1,10 @@=0A=
> >+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */=0A=
> > /*=0A=
> >  * net/tipc/udp_media.h: Include file for UDP bearer media=0A=
> >  *=0A=
> >  * Copyright (c) 1996-2006, 2013-2016, Ericsson AB=0A=
> >  * Copyright (c) 2005, 2010-2011, Wind River Systems=0A=
> >  * All rights reserved.=0A=
> >- *=0A=
> >- * Redistribution and use in source and binary forms, with or without=
=0A=
> >- * modification, are permitted provided that the following conditions a=
re met:=0A=
> >- *=0A=
> >- * 1. Redistributions of source code must retain the above copyright=0A=
> >- *    notice, this list of conditions and the following disclaimer.=0A=
> >- * 2. Redistributions in binary form must reproduce the above copyright=
=0A=
> >- *    notice, this list of conditions and the following disclaimer in t=
he=0A=
> >- *    documentation and/or other materials provided with the distributi=
on.=0A=
> >- * 3. Neither the names of the copyright holders nor the names of its=
=0A=
> >- *    contributors may be used to endorse or promote products derived f=
rom=0A=
> >- *    this software without specific prior written permission.=0A=
> >- *=0A=
> >- * Alternatively, this software may be distributed under the terms of t=
he=0A=
> >- * GNU General Public License ("GPL") version 2 as published by the Fre=
e=0A=
> >- * Software Foundation.=0A=
> >- *=0A=
> >- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND=0A=
> >CONTRIBUTORS "AS IS"=0A=
> >- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A=
> >LIMITED TO, THE=0A=
> >- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A=0A=
> >PARTICULAR PURPOSE=0A=
> >- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR=0A=
> >CONTRIBUTORS BE=0A=
> >- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=
=0A=
> >- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
> >PROCUREMENT OF=0A=
> >- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
> >BUSINESS=0A=
> >- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=0A=
> >WHETHER IN=0A=
> >- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=0A=
> >OTHERWISE)=0A=
> >- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=0A=
> >ADVISED OF THE=0A=
> >- * POSSIBILITY OF SUCH DAMAGE.=0A=
> >  */=0A=
> >=0A=
> > #ifdef CONFIG_TIPC_MEDIA_UDP=0A=
> >--=0A=
> >2.43.0=0A=
> >=0A=
=0A=

