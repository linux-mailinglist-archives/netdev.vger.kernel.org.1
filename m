Return-Path: <netdev+bounces-104464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3464790C9E8
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706D928884E
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12D715821A;
	Tue, 18 Jun 2024 11:02:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E47D1581EF;
	Tue, 18 Jun 2024 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708541; cv=none; b=G0431QOU1+nAib8yO+ZeBEwPA91tAEydbeUwNUOis0HsmuQjMxO+DppJAO/lRHLqe7qYUq+Chb3yjzDTolo+nQB0LJCTFID50buwbC3nY252L8sHB14PzRRwLDKKYQSsYx4wvUn9qXF14Bwcz6EIyOkpFO4fn3oNzJAs0gQSqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708541; c=relaxed/simple;
	bh=JmMqCzUFzGdntw8cFxUiHsUFzFPMlt7PsprJzWJyifA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bihPj+V+zLiX+vHh0+sLPa2PaDweqI7aBmNOQBJprwWjsHTw7iDoD2dxbnJwB1oqt49cee3Bhh2dxJLQl/kajTbwxgEG+pSCoTUT4LobV7UJO+H3IydYufP5t41Df/fM3wpSTq8V1/8xTOpA2jPiT7aSujLqYfk81us5iwME8hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45IB1VAS0398675, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45IB1VAS0398675
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 19:01:31 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 19:01:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 18 Jun 2024 19:01:30 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 18 Jun 2024 19:01:30 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Markus Elfring <Markus.Elfring@web.de>, Simon Horman <horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Lunn
	<andrew@lunn.ch>, Hariprasad Kelam <hkelam@marvell.com>,
        Jiri Pirko
	<jiri@resnulli.us>, Larry Chiu <larry.chiu@realtek.com>,
        Ping-Ke Shih
	<pkshih@realtek.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: RE: [v20 02/13] rtase: Implement the .ndo_open function
Thread-Topic: [v20 02/13] rtase: Implement the .ndo_open function
Thread-Index: AQHawJ5eL1A+vv787Ey/gTxPzZ037bHL8dBA///X7QCAABcWAIABe3RQ
Date: Tue, 18 Jun 2024 11:01:30 +0000
Message-ID: <d8ca31ba65364e60af91bca644a96db5@realtek.com>
References: <20240607084321.7254-3-justinlai0215@realtek.com>
 <1d01ece4-bf4e-4266-942c-289c032bf44d@web.de>
 <ef7c83dea1d849ad94acef81819f9430@realtek.com>
 <6b284a02-15e2-4eba-9d5f-870a8baa08e8@web.de>
 <0c57021d0bfc444ebe640aa4c5845496@realtek.com>
 <20240617185956.GY8447@kernel.org>
 <202406181007.45IA7eWxA3305754@rtits1.realtek.com.tw>
In-Reply-To: <202406181007.45IA7eWxA3305754@rtits1.realtek.com.tw>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiANCj4gPiBJIHdvdWxkIGFsc28gc3VnZ2VzdCByZWFkaW5nIE1hcmt1cydzIGFkdmljZSB3aXRo
IGR1ZSBjYXJlLCBhcyBpdCBpcw0KPiA+IG5vdCBhbHdheXMgYWxpZ25lZCB3aXRoIGJlc3QgcHJh
Y3RpY2UgZm9yIE5ldHdvcmtpbmcgY29kZS4NCj4gDQo+IEkgZGFyZSB0byBwcm9wb3NlIGZ1cnRo
ZXIgY29sbGF0ZXJhbCBldm9sdXRpb24gYWNjb3JkaW5nIHRvIGF2YWlsYWJsZQ0KPiBwcm9ncmFt
bWluZyBpbnRlcmZhY2VzLg0KPiANCj4gUmVnYXJkcywNCj4gTWFya3VzDQoNClRoYW5rIHlvdSBm
b3IgeW91ciBzdWdnZXN0aW9uLCBidXQgc2luY2Ugd2Ugc3RpbGwgbmVlZCB0byBzdXJ2ZXkgdGhl
IG5ldw0KbWV0aG9kLCB3ZSB3YW50IHRvIHVzZSB0aGUgZ290byBtZXRob2QgZm9yIHRoaXMgY3Vy
cmVudCB2ZXJzaW9uIG9mIHRoZQ0KcGF0Y2ggYW5kIG1ha2UgbW9kaWZpY2F0aW9ucyBiYXNlZCBv
biBTaW1vbidzIHN1Z2dlc3Rpb25zLg0K

