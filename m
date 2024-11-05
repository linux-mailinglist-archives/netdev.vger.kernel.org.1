Return-Path: <netdev+bounces-142041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053179BD2E1
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28AD11C223B6
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 16:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7E61DAC96;
	Tue,  5 Nov 2024 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="u2p+EKKq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA99B17C7CE
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730825542; cv=none; b=ZZLXZLVLLSSsOF3znA0vUNFpC/khLugQwJLdJJsqYCvoleTdnrfgTzlFe1WdGFSgq+x+Vvij+V1T/bDiSt+kPu1xBz2ld/WNZsk21bYKlkO+wTJvfC65Rpn9BGNRyr/uscU4/fyjG7ku36MsKAXid34H8ze4rdF4tIYeNETukU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730825542; c=relaxed/simple;
	bh=L11dFyZ0+nUzhwFXLC8bzr3KIUpvRCIvse7h0SferFk=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KXSNpx0K+Z7SyWx2Dac2WHPPE7ArivpqqhPvseVI29xSrnTWZwYxARaVamU6Gw4U7dyggdg52YyP17agrqld7IpHBWnk8e3MIoPJwcH+8rx20vMc+FKzAVqtz9c6kxtheFGr1yFdlKnWS2jveZIenRkafE29Zz/SvWkVuXjfhss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=u2p+EKKq; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730825541; x=1762361541;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=L11dFyZ0+nUzhwFXLC8bzr3KIUpvRCIvse7h0SferFk=;
  b=u2p+EKKqSWIMc3IzHpnD2Skop1QvnsPzegkAGqpOz05n7245UvAMbQbJ
   NPH9TmutVR9LPxCtbnTOVDOH5FXOYxRvBFD3JBlDP7tB8Qqs5Mu1vvhLn
   WyUnNb6gzpiMCQr+46nwP9bJSmZT0H2Wim0jBNDy9GzY06dfSJnaYXgkW
   0=;
X-IronPort-AV: E=Sophos;i="6.11,260,1725321600"; 
   d="scan'208";a="382645216"
Subject: RE: [PATCH v3 net-next 3/3] net: ena: Add PHC documentation
Thread-Topic: [PATCH v3 net-next 3/3] net: ena: Add PHC documentation
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 16:52:15 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:5706]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.24.44:2525] with esmtp (Farcaster)
 id dd4def1a-f106-4a09-84f9-76b55d5e72f4; Tue, 5 Nov 2024 16:52:13 +0000 (UTC)
X-Farcaster-Flow-ID: dd4def1a-f106-4a09-84f9-76b55d5e72f4
Received: from EX19D010EUA004.ant.amazon.com (10.252.50.94) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 16:52:12 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D010EUA004.ant.amazon.com (10.252.50.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 16:52:12 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.035; Tue, 5 Nov 2024 16:52:12 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Gal Pressman <gal@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
CC: David Miller <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "Woodhouse,
 David" <dwmw@amazon.co.uk>, "Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>, "Bshara, Saeed"
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
	<ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>, "Agroskin,
 Shay" <shayagr@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir"
	<ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>, "Rahul
 Rameshbabu" <rrameshbabu@nvidia.com>
Thread-Index: AQHbLeQGl7kxu2fA00SYfY6yxcXfg7Kn9ekAgABNu5CAAJyxAIAACMZw
Date: Tue, 5 Nov 2024 16:52:11 +0000
Message-ID: <4ba02d13a8c14045b0df7deaee188f82@amazon.com>
References: <20241103113140.275-1-darinzon@amazon.com>
 <20241103113140.275-4-darinzon@amazon.com>
 <20241104181722.4ee86665@kernel.org>
 <4ce957d04f6048f9bf607826e9e0be5b@amazon.com>
 <91932534-7309-4650-b4c8-1bfe61579b50@nvidia.com>
In-Reply-To: <91932534-7309-4650-b4c8-1bfe61579b50@nvidia.com>
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

PiA+Pj4gKz09PT09PT09PT09PT09PT09DQo+ID4+ID09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+Pj4gKyoqcGhjX2NudCoqICAgICAgICAg
TnVtYmVyIG9mIHN1Y2Nlc3NmdWwgcmV0cmlldmVkIHRpbWVzdGFtcHMgKGJlbG93DQo+ID4+IGV4
cGlyZSB0aW1lb3V0KS4NCj4gPj4+ICsqKnBoY19leHAqKiAgICAgICAgIE51bWJlciBvZiBleHBp
cmVkIHJldHJpZXZlZCB0aW1lc3RhbXBzIChhYm92ZQ0KPiA+PiBleHBpcmUgdGltZW91dCkuDQo+
ID4+PiArKipwaGNfc2twKiogICAgICAgICBOdW1iZXIgb2Ygc2tpcHBlZCBnZXQgdGltZSBhdHRl
bXB0cyAoZHVyaW5nIGJsb2NrDQo+ID4+IHBlcmlvZCkuDQo+ID4+PiArKipwaGNfZXJyKiogICAg
ICAgICBOdW1iZXIgb2YgZmFpbGVkIGdldCB0aW1lIGF0dGVtcHRzIChlbnRlcmluZyBpbnRvDQo+
IGJsb2NrDQo+ID4+IHN0YXRlKS4NCj4gPj4+ICs9PT09PT09PT09PT09PT09PQ0KPiA+PiA9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPj4N
Cj4gPj4gSSBzZWVtIHRvIHJlY2FsbCB3ZSBoYWQgYW4gdW5wbGVhc2FudCBjb252ZXJzYXRpb24g
YWJvdXQgdXNpbmcNCj4gPj4gc3RhbmRhcmQgc3RhdHMgcmVjZW50bHkuIFBsZWFzZSB0ZWxsIG1l
IHdoZXJlIHlvdSBsb29rZWQgdG8gY2hlY2sgaWYNCj4gPj4gTGludXggaGFzIHN0YW5kYXJkIHN0
YXRzIGZvciBwYWNrZXQgdGltZXN0YW1waW5nLiBXZSBuZWVkIHRvIGFkZCB0aGUNCj4gcmlnaHQg
aW5mbyB0aGVyZS4NCj4gPj4gLS0NCj4gPj4gcHctYm90OiBjcg0KPiA+DQo+ID4gSGkgSmFrdWIs
DQo+ID4NCj4gPiBKdXN0IHdhbnRlZCB0byBjbGFyaWZ5IHRoYXQgdGhpcyBmZWF0dXJlIGFuZCB0
aGUgYXNzb2NpYXRlZA0KPiA+IGRvY3VtZW50YXRpb24gYXJlIHNwZWNpZmljYWxseSBpbnRlbmRl
ZCBmb3IgcmVhZGluZyBhIEhXIHRpbWVzdGFtcCwgbm90DQo+IGZvciBUWC9SWCBwYWNrZXQgdGlt
ZXN0YW1waW5nLg0KPiA+IFdlIHJldmlld2VkIHNpbWlsYXIgZHJpdmVycyB0aGF0IHN1cHBvcnQg
SFcgdGltZXN0YW1waW5nIHZpYQ0KPiA+IGBnZXR0aW1lNjRgIGFuZCBgZ2V0dGltZXg2NGAgQVBJ
cywgYW5kIHdlIGNvdWxkbid0IGlkZW50aWZ5IGFueSB0aGF0DQo+IGNhcHR1cmUgb3IgcmVwb3J0
IHN0YXRpc3RpY3MgcmVsYXRlZCB0byByZWFkaW5nIGEgSFcgdGltZXN0YW1wLg0KPiA+IExldCB1
cyBrbm93IGlmIGZ1cnRoZXIgZGV0YWlscyB3b3VsZCBiZSBoZWxwZnVsLg0KPiANCj4gRGF2aWQs
IGRpZCB5b3UgY29uc2lkZXIgUmFodWwncyByZWNlbnQgdGltZXN0YW1waW5nIHN0YXRzIEFQST8N
Cj4gMGU5YzEyNzcyOWJlICgiZXRodG9vbDogYWRkIGludGVyZmFjZSB0byByZWFkIFR4IGhhcmR3
YXJlIHRpbWVzdGFtcGluZw0KPiBzdGF0aXN0aWNzIikNCg0KSGkgR2FsLA0KDQpXZSd2ZSBsb29r
ZWQgaW50byB0aGUgYGdldF90c19zdGF0c2AgZXRodG9vbCBob29rLCBhbmQgaXQgcmVmZXJzIHRv
IFRYIEhXIHBhY2tldCB0aW1lc3RhbXBpbmcNCmFuZCBub3QgSFcgdGltZXN0YW1wIHdoaWNoIGlz
IHJldHJpZXZlZCB0aHJvdWdoIGBnZXR0aW1lNjRgIGFuZCBgZ2V0dGltZXg2NGAuDQo=

