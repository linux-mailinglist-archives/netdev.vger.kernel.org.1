Return-Path: <netdev+bounces-137904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF7D9AB105
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1A51F242A9
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 14:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF481A0B0C;
	Tue, 22 Oct 2024 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XuFOwYaF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B45119DF66
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607958; cv=none; b=Vcm9w9z5bmRAkyBqvYu2t226uirX4jyVfff9XbL6Lu23e5bhloAEvXcFM4UOVk8x6b3s5lTDrpn76B+U/F+OZAbe0rI4Zaewa7/8lgXFfizIppGOXLbNFxsh52OldoSpX5ko3knlyh+UBIO7h84gyk0TMcl17EG+CDwJPx2BTZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607958; c=relaxed/simple;
	bh=WnzSU2OtzmtdRGHf36Rspsk8545Y20fvQKFYS0uYVY0=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZExTDMxcUZ0YD08X8GjlWEjw/Aoh1tdjtQaXCH4cgN+gt7vwIe04YAC7CGOADeZKuMFX9Xt7FrMYGzd0XNiZGTbHqg6fr/N+L3jdlYVnpBNBvbc7Oj49XQ8hokHAmY0MPgWInAH+fhuUP2hUHu5bmPqbRBN6QlB6+RkE9YjnPis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XuFOwYaF; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729607957; x=1761143957;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=WnzSU2OtzmtdRGHf36Rspsk8545Y20fvQKFYS0uYVY0=;
  b=XuFOwYaFf/xAfb9LyUxHXCsR3wJuHq+2oeETMATY2mIOwlerochbedm5
   RBQkDe6rk5nQTE2HNRjtZUIGhzxjQgmop0aJhyZRSNjvofZijhKFYrCQw
   zRsPzQ9EWawvmlZvQh3BW4cI21LK9UJ0ozcah1653EnY8h+OWMVKAZpHj
   o=;
X-IronPort-AV: E=Sophos;i="6.11,223,1725321600"; 
   d="scan'208";a="140614062"
Subject: RE: [PATCH v1 net-next 3/3] net: ena: Add PHC documentation
Thread-Topic: [PATCH v1 net-next 3/3] net: ena: Add PHC documentation
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 14:39:15 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:53663]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.10.171:2525] with esmtp (Farcaster)
 id bd5a6ba9-a5a8-4fe4-9588-a64676bd565a; Tue, 22 Oct 2024 14:39:14 +0000 (UTC)
X-Farcaster-Flow-ID: bd5a6ba9-a5a8-4fe4-9588-a64676bd565a
Received: from EX19D022EUA004.ant.amazon.com (10.252.50.82) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 22 Oct 2024 14:39:14 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D022EUA004.ant.amazon.com (10.252.50.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 22 Oct 2024 14:39:14 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.035; Tue, 22 Oct 2024 14:39:14 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: David Woodhouse <dwmw2@infradead.org>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>
Thread-Index: AQHbI3j6/gWuVA+BA0SdZ8txTotu87KRZG8AgAFs5bCAAAQUAIAAAkZg
Date: Tue, 22 Oct 2024 14:39:13 +0000
Message-ID: <448a2aca058d4aeabb39a01e1b56d51e@amazon.com>
References: <20241021052011.591-1-darinzon@amazon.com>
	 <20241021052011.591-4-darinzon@amazon.com>
	 <5f469c57a34c0a2a76b6f8c4517a0e4b7c038e8b.camel@infradead.org>
	 <07a168fb44ac4c3a897678ac86893429@amazon.com>
 <cf2e768830c0950e2de375ed057c5b8eb104b62d.camel@infradead.org>
In-Reply-To: <cf2e768830c0950e2de375ed057c5b8eb104b62d.camel@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiA+ID4gPiArwqAgdGVzdHB0cCAtZCAvZGV2L3B0cCQoZXRodG9vbCAtVCA8aW50ZXJmYWNlPiB8
IGF3ayAnL1BUUA0KPiA+ID4gPiBIYXJkd2FyZQ0KPiA+ID4gQ2xvY2s6LyB7cHJpbnQgJE5GfScp
IC1rIDENCj4gPiA+ID4gKw0KPiA+ID4NCj4gPiA+IERvZXMgdWRldiBjcmVhdGUgYSBzdGFibGUg
c3ltbGluayBmb3IgdGhpcywgbGlrZSBpdCBkb2VzIGZvciBlLmcuDQo+ID4gPiAvZGV2L3B0cF9r
dm0gPw0KPiA+ID4NCj4gPg0KPiA+IFllcywgeW91IGNhbiBhZGQgYSBzcGVjaWZpYyBydWxlIGZv
ciB0aGUgZW5hIHB0cCBkZXZpY2UNCj4gPg0KPiA+IFNVQlNZU1RFTT09InB0cCIsIEFUVFJ7Y2xv
Y2tfbmFtZX09PSJlbmEtcHRwLSoiLCBTWU1MSU5LICs9ICJlbmEtDQo+IHB0cCINCj4gDQo+IEkg
ZG9uJ3Qgc2VlIGl0IGhlcmUgeWV0IHRob3VnaDoNCj4gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9z
eXN0ZW1kL3N5c3RlbWQvYmxvYi9tYWluL3J1bGVzLmQvNTAtdWRldi0NCj4gZGVmYXVsdC5ydWxl
cy5pbiNMMzMNCg0KV2Ugd2lsbCBhZGQgYSBwdWxsIHJlcXVlc3QgdG8gc3lzdGVtZCB3aGljaCBh
ZGRzIHRoZSBhYm92ZSBzdWdnZXN0ZWQgcnVsZS4NCg==

