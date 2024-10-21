Return-Path: <netdev+bounces-137528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00129A6C78
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78021C21347
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519AE1F6698;
	Mon, 21 Oct 2024 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="b399xvkX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CC933F7
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521962; cv=none; b=R+ChkrAWq3cquQ3su/FfAADWf4IpaYdnNAouJIrsUS7U8WOoufpx2yj3jfgiXq90FuuwVobPxeErf6YKtXCH3hIxk35z86KbP3Snbb1PwpnmQnvKZpaTyZj8fc+b/1LrASpV4Tv4nwEBujKnwvunhLTGBmgxyKlvcHYLqReos4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521962; c=relaxed/simple;
	bh=HZZkRLn/ilazjD3pJkprIrKx+O4fiyPeTcxVv7p/8wY=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dWINEvHSBHd/Y8pev3YB4CDb3GOGWUI6YltDh+lTlPp/TXjzPCvcBznLwwAReiDf5oSq1wuzsvSCD3aGeu1SCYizKD6wQ1DS4pe1Dn4HLheI3Ns4+mfdlPcM9rbMn5eqIzPv+JAe7of8OXbs+1e7rqyo6bSuqQGYekzuQ0S9Y1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=b399xvkX; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729521961; x=1761057961;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=HZZkRLn/ilazjD3pJkprIrKx+O4fiyPeTcxVv7p/8wY=;
  b=b399xvkXDdhrGFYXJHGe1subnXjN0w3RDwpbRx8jH5JTsxG+5d4U/I1y
   chFEK0thYryN+MlFAvvpJChCZ3YfE+Xyy23M8VmYI4CGnaqm4HxE5pD3v
   v7Vn/mGN5iIu9sirvnNKdpcu++uFFVkKCQ/dhOFErFXFMq88hTWXtsH59
   A=;
X-IronPort-AV: E=Sophos;i="6.11,221,1725321600"; 
   d="scan'208";a="463169653"
Subject: RE: [PATCH v1 net-next 3/3] net: ena: Add PHC documentation
Thread-Topic: [PATCH v1 net-next 3/3] net: ena: Add PHC documentation
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 14:45:42 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:24233]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.6.84:2525] with esmtp (Farcaster)
 id a4c50b5d-6e62-4868-a2ec-04f368a7cbac; Mon, 21 Oct 2024 14:45:39 +0000 (UTC)
X-Farcaster-Flow-ID: a4c50b5d-6e62-4868-a2ec-04f368a7cbac
Received: from EX19D017EUA001.ant.amazon.com (10.252.50.71) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 14:45:39 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D017EUA001.ant.amazon.com (10.252.50.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 14:45:38 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.035; Mon, 21 Oct 2024 14:45:38 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Woodhouse, David"
	<dwmw@amazon.co.uk>, "Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky,
 Alexander" <matua@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, "Wilson,
 Matt" <msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara,
 Nafea" <nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>
Thread-Index: AQHbI3j6/gWuVA+BA0SdZ8txTotu87KRRU0AgAAC/mA=
Date: Mon, 21 Oct 2024 14:45:38 +0000
Message-ID: <34df060882164fb5899da6117e93b782@amazon.com>
References: <20241021052011.591-1-darinzon@amazon.com>
 <20241021052011.591-4-darinzon@amazon.com> <ZxZmGmNWjViZEEbX@mini-arch>
In-Reply-To: <ZxZmGmNWjViZEEbX@mini-arch>
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

PiA+IFByb3ZpZGUgdGhlIHJlbGV2YW50IGluZm9ybWF0aW9uIGFuZCBndWlkZWxpbmVzIGFib3V0
IHRoZSBmZWF0dXJlDQo+ID4gc3VwcG9ydCBpbiB0aGUgRU5BIGRyaXZlci4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEFtaXQgQmVybnN0ZWluIDxhbWl0YmVybkBhbWF6b24uY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IERhdmlkIEFyaW56b24gPGRhcmluem9uQGFtYXpvbi5jb20+DQo+ID4gLS0t
DQo+ID4gIC4uLi9kZXZpY2VfZHJpdmVycy9ldGhlcm5ldC9hbWF6b24vZW5hLnJzdCAgICB8IDc4
DQo+ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDc4IGluc2VydGlv
bnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vbmV0d29ya2lu
Zy9kZXZpY2VfZHJpdmVycy9ldGhlcm5ldC9hbWF6b24vZW5hLnJzdA0KPiA+IGIvRG9jdW1lbnRh
dGlvbi9uZXR3b3JraW5nL2RldmljZV9kcml2ZXJzL2V0aGVybmV0L2FtYXpvbi9lbmEucnN0DQo+
ID4gaW5kZXggNDU2MWU4YWIuLjlmNDkwYmI4IDEwMDY0NA0KPiA+IC0tLQ0KPiBhL0RvY3VtZW50
YXRpb24vbmV0d29ya2luZy9kZXZpY2VfZHJpdmVycy9ldGhlcm5ldC9hbWF6b24vZW5hLnJzdA0K
PiA+ICsrKw0KPiBiL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9kZXZpY2VfZHJpdmVycy9ldGhl
cm5ldC9hbWF6b24vZW5hLnJzdA0KPiA+IEBAIC01Niw2ICs1Niw3IEBAIGVuYV9uZXRkZXYuW2No
XSAgICAgTWFpbiBMaW51eCBrZXJuZWwgZHJpdmVyLg0KPiA+ICBlbmFfZXRodG9vbC5jICAgICAg
IGV0aHRvb2wgY2FsbGJhY2tzLg0KPiA+ICBlbmFfeGRwLltjaF0gICAgICAgIFhEUCBmaWxlcw0K
PiA+ICBlbmFfcGNpX2lkX3RibC5oICAgIFN1cHBvcnRlZCBkZXZpY2UgSURzLg0KPiA+ICtlbmFf
cGhjLltjaF0gICAgICAgIFBUUCBoYXJkd2FyZSBjbG9jayBpbmZyYXN0cnVjdHVyZSAoc2VlIGBQ
SENgXyBmb3IgbW9yZQ0KPiBpbmZvKQ0KPiA+ICA9PT09PT09PT09PT09PT09PQ0KPiA9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPg0KPiA+
ICBNYW5hZ2VtZW50IEludGVyZmFjZToNCj4gPiBAQCAtMjIxLDYgKzIyMiw4MyBAQCBkZXNjcmlw
dG9yIGl0IHdhcyByZWNlaXZlZCBvbiB3b3VsZCBiZSByZWN5Y2xlZC4NCj4gPiBXaGVuIGEgcGFj
a2V0IHNtYWxsZXIgIHRoYW4gUlggY29weWJyZWFrIGJ5dGVzIGlzIHJlY2VpdmVkLCBpdCBpcw0K
PiA+IGNvcGllZCBpbnRvIGEgbmV3IG1lbW9yeSAgYnVmZmVyIGFuZCB0aGUgUlggZGVzY3JpcHRv
ciBpcyByZXR1cm5lZCB0byBIVy4NCj4gPg0KPiA+ICsuLiBfYFBIQ2A6DQo+ID4gKw0KPiA+ICtQ
VFAgSGFyZHdhcmUgQ2xvY2sgKFBIQykNCj4gPiArPT09PT09PT09PT09PT09PT09PT09PQ0KPiA+
ICsuLiBfYHB0cC11c2Vyc3BhY2UtYXBpYDoNCj4gPiAraHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcv
ZHJpdmVyLWFwaS9wdHAuaHRtbCNwdHAtaGFyZHdhcmUtY2xvY2stdXNlci1zDQo+ID4gK3BhY2Ut
YXBpIC4uIF9gdGVzdHB0cGA6DQo+ID4gK2h0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4
L2xhdGVzdC9zb3VyY2UvdG9vbHMvdGVzdGluZy9zZWxmdGVzdA0KPiA+ICtzL3B0cC90ZXN0cHRw
LmMNCj4gDQo+IG5pdDoNCj4gRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2RldmljZV9kcml2ZXJz
L2V0aGVybmV0L2FtYXpvbi9lbmEucnN0OjIyODoNCj4gV0FSTklORzogVGl0bGUgdW5kZXJsaW5l
IHRvbyBzaG9ydC4NCj4gDQo+IC0tLQ0KPiBwdy1ib3Q6IGNyDQoNClRoYW5rcyBmb3IgcmFpc2lu
ZyB0aGlzLCB3aWxsIGZpeCBpbiB0aGUgbmV4dCByZXZpc2lvbg0K

