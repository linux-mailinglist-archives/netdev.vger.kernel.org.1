Return-Path: <netdev+bounces-137894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D6D9AB0A3
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0651F24062
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 14:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40A5199EA2;
	Tue, 22 Oct 2024 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="b4XxTD53"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9A219D88F
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606654; cv=none; b=VS6tcSCcL/t33wm/xkUEVquH2nWRkrLMuSdwQv+aM+M6qJsKCRbJ7rtt5ZYd3f/ndh0vTvo6wcDJTnLDbINW+U029EhWF/9+NgRAPkntqDlA0IsoxuN/0MnX8+RRVzOBzFnryR0BWLc/t+7Fo5hyJ8nJKGIUfLiK1iRelxOCHa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606654; c=relaxed/simple;
	bh=C2xFePEtwfUlIpNAcsA+dMrSjTesOW7WcmWL/PUmvew=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JPeRzKRISbD0nuGtQCRx0Ta11XkrsNg3nNTQViuFZhhaE4jli5+rpS5ikZ9WIIVX6eZCe/Bnw19nBxB+GVdSm0LBe3MDKjukC4TQC7s5+1VXvzhcbD5h468H2B/C9FbBgXRS0lqJO0QrvxAn4zRdfdhysrB1/moEOUvx3ieP7Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=b4XxTD53; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729606653; x=1761142653;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=C2xFePEtwfUlIpNAcsA+dMrSjTesOW7WcmWL/PUmvew=;
  b=b4XxTD53yzOpQzW7+1ZTdwFNQTJEXwhP/dgDsxDBcorpzuqUUjmn9deY
   Fy2i639ypndLDi2PMz9v5UWg6JReMG6js6JljcJDEkE22+AGuATvS/0cs
   7JIyyFimG+scdMBGJWmg8Bnl1WJdG4a22D4MvfSCisNrJpMLh0rQGEVgy
   A=;
X-IronPort-AV: E=Sophos;i="6.11,223,1725321600"; 
   d="scan'208";a="140606111"
Subject: RE: [PATCH v1 net-next 3/3] net: ena: Add PHC documentation
Thread-Topic: [PATCH v1 net-next 3/3] net: ena: Add PHC documentation
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 14:17:31 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:4209]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.20.75:2525] with esmtp (Farcaster)
 id dbe9bd66-3dd0-482c-bac6-4c07cbcb53b5; Tue, 22 Oct 2024 14:17:30 +0000 (UTC)
X-Farcaster-Flow-ID: dbe9bd66-3dd0-482c-bac6-4c07cbcb53b5
Received: from EX19D011EUA004.ant.amazon.com (10.252.50.46) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 22 Oct 2024 14:17:30 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D011EUA004.ant.amazon.com (10.252.50.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 22 Oct 2024 14:17:29 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.035; Tue, 22 Oct 2024 14:17:29 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: David Woodhouse <dwmw2@infradead.org>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>, "Machulsky, Zorik"
	<zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, "Bshara,
 Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori,
 Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel"
	<netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt,
 Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir"
	<ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>
Thread-Index: AQHbI3j6/gWuVA+BA0SdZ8txTotu87KRZG8AgAFs5bA=
Date: Tue, 22 Oct 2024 14:17:29 +0000
Message-ID: <07a168fb44ac4c3a897678ac86893429@amazon.com>
References: <20241021052011.591-1-darinzon@amazon.com>
	 <20241021052011.591-4-darinzon@amazon.com>
 <5f469c57a34c0a2a76b6f8c4517a0e4b7c038e8b.camel@infradead.org>
In-Reply-To: <5f469c57a34c0a2a76b6f8c4517a0e4b7c038e8b.camel@infradead.org>
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

PiA+ICvCoCB0ZXN0cHRwIC1kIC9kZXYvcHRwJChldGh0b29sIC1UIDxpbnRlcmZhY2U+IHwgYXdr
ICcvUFRQIEhhcmR3YXJlDQo+IENsb2NrOi8ge3ByaW50ICRORn0nKSAtayAxDQo+ID4gKw0KPiAN
Cj4gRG9lcyB1ZGV2IGNyZWF0ZSBhIHN0YWJsZSBzeW1saW5rIGZvciB0aGlzLCBsaWtlIGl0IGRv
ZXMgZm9yIGUuZy4NCj4gL2Rldi9wdHBfa3ZtID8NCj4gDQoNClllcywgeW91IGNhbiBhZGQgYSBz
cGVjaWZpYyBydWxlIGZvciB0aGUgZW5hIHB0cCBkZXZpY2UNCg0KU1VCU1lTVEVNPT0icHRwIiwg
QVRUUntjbG9ja19uYW1lfT09ImVuYS1wdHAtKiIsIFNZTUxJTksgKz0gImVuYS1wdHAiDQoNCj4g
SSBub3RlIHRoZSBFQzIgZG9jdW1lbnRhdGlvbiAqc3RpbGwqIHRlbGxzIHVzZXJzIHRvIHVzZSAv
ZGV2L3B0cDANCj4gd2l0aG91dCBldmVuIGNoZWNraW5nIHdoaWNoIGRldmljZSB0aGF0IGlzLCBz
byB0aGV5IGNvdWxkIGdldCBzb21ldGhpbmcNCj4gKnZlcnkqIGRpZmZlcmVudCB0byB3aGF0IHRo
ZXkgZXhwZWN0LCBpZiB0aGV5IGFjY2lkZW50YWxseSBzdGFydCB1c2luZw0KPiB0aGUgS1ZNIFBU
UCBjbG9jayBpbnN0ZWFkIQ0K

