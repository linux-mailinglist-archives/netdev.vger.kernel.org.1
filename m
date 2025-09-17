Return-Path: <netdev+bounces-224141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED78B8129B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 19:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB89A6251E2
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5BD2FC03B;
	Wed, 17 Sep 2025 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Zxmdz0Sw"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C511EBFE0;
	Wed, 17 Sep 2025 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130008; cv=none; b=pH6tjwh3KGZkBPbEMRk2Bc4bwE7xM0aSDxbp/3cQqi5k+E1ERRrxKjorybWtTIi4VZqvIyvnT47TwYJrGETI8GL+e+kuJf/AYtLUPMF8mT26mtjXluTVO9YBLVkhWCeyBmzcDdaE8OL3Hz3pNJtOJ/RXf29qbcfPvIH/Uvm2skE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130008; c=relaxed/simple;
	bh=cg2Q0FlEjLdV7xx3QS3qDQh0+DMnBCJ9c9DsM3OkmHc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ogDws/JMxM8yRERuXzgEuLDd8OPIuXjsfEUY3UGXang7+gBC/Nzf8EBmHtFPn0T7Jpyb1jDiWpPJ/1j1w0YdCIc+tsjwtfaSY3RaJbvJ2kG6VE/H5Oa+DkTYMJUacnrPdUrXaMMW5r5SoECnVh6wDl5Sh1o8O1qxBTXB784uJEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Zxmdz0Sw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58HHQEZ00567363, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758129975; bh=cg2Q0FlEjLdV7xx3QS3qDQh0+DMnBCJ9c9DsM3OkmHc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Zxmdz0SwwYLKrxtaVsjhGW5yQzRxPIuRFpzqhf64k1w6xtLyfYY/i5ZHoheSNlPV+
	 Wte/lmSNxYvdNANiOc3bn0x0bxrJp0hoVezwtCahZjrZD1QxGT4IBYq5EyWABJ2m5R
	 pOrInlRiAUQ3K7T6pGZYde2KBJ2B5JPr+JSuH5e/OYBfuWl3UzKTSm+pdj3pnZ4HyJ
	 GoUeFcKTcGNa21wwsKc5Yv/rx7TzGjgqyofFZMx7dYjEbivSndO0Vg9FKSsujM+LM0
	 wn31jziTEL86Lp+Ce2ZS3Ne2m54+hTvlHG4ltbF9g4EPu0SpzyGN5UICMZRix06mJC
	 DUUgGiLFduOFw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58HHQEZ00567363
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 01:26:15 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 18 Sep 2025 01:26:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Thu, 18 Sep 2025 01:26:14 +0800
From: Hau <hau@realtek.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd <nic_swsd@realtek.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] r8169: set EEE speed down ratio to 1
Thread-Topic: [PATCH net-next] r8169: set EEE speed down ratio to 1
Thread-Index: AQHcHUE6wESi95i7Y0uNfg+X46GTibSEfc2AgBMKn0D//6TSgIAAiFIw
Date: Wed, 17 Sep 2025 17:26:13 +0000
Message-ID: <f5494952210a4f12a20f691a4ef03201@realtek.com>
References: <20250904021123.5734-1-hau@realtek.com>
 <292e1b4d-b00d-4bb5-b55e-5684666c0229@gmail.com>
 <a710550463da4b4281f9db1a8d0b29e1@realtek.com>
 <0c5f8ebd-5ac0-4ac5-ae66-24a5acea371c@gmail.com>
In-Reply-To: <0c5f8ebd-5ac0-4ac5-ae66-24a5acea371c@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiA+Pg0KPiA+PiBFeHRlcm5hbCBtYWlsIDogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0
c2lkZSB0aGUgb3JnYW5pemF0aW9uLg0KPiA+PiBEbyBub3QgcmVwbHksIGNsaWNrIGxpbmtzLCBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplDQo+ID4+IHRoZSBzZW5kZXIg
YW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gPj4NCj4gPj4NCj4gPj4NCj4gPj4gT24g
OS80LzIwMjUgNDoxMSBBTSwgQ2h1bkhhbyBMaW4gd3JvdGU6DQo+ID4+PiBFRUUgc3BlZWQgZG93
biByYXRpbyAobWFjIG9jcCAweGUwNTZbNzo0XSkgaXMgdXNlZCB0byBjb250cm9sIEVFRQ0KPiA+
Pj4gc3BlZWQgZG93biByYXRlLiBUaGUgbGFyZ2VyIHRoaXMgdmFsdWUgaXMsIHRoZSBtb3JlIHBv
d2VyIGNhbiBzYXZlLg0KPiA+Pj4gQnV0IGl0IGFjdHVhbGx5IHNhdmUgbGVzcyBwb3dlciB0aGVu
IGV4cGVjdGVkLCBidXQgd2lsbCBpbXBhY3QNCj4gPj4+IGNvbXBhdGliaWxpdHkuIFNvIHNldCBp
dCB0byAxIChtYWMgb2NwIDB4ZTA1Nls3OjRdID0gMCkgdG8gaW1wcm92ZQ0KPiA+PiBjb21wYXRp
YmlsaXR5Lg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IENodW5IYW8gTGluIDxoYXVAcmVh
bHRlay5jb20+DQo+ID4+PiAtLS0NCj4gPj4NCj4gPj4gUmV2aWV3ZWQtYnk6IEhlaW5lciBLYWxs
d2VpdCA8aGthbGx3ZWl0MUBnbWFpbC5jb20+DQo+ID4NCj4gPiBUaGlzIHBhdGNoIHNlZW1zIGhh
cyBiZWVuIHJldmlld2VkLiBCdXQgSSBkaWQgbm90IHNlZSBpdCBiZWVuIGFjY2VwdGVkLg0KPiBT
aG91bGQgSSByZXN1Ym1pdCB0aGUgcGF0Y2g/DQo+IA0KPiBJdHMgc3RhdHVzIGluIHBhdGNod29y
ayBpcyAiY2hhbmdlcyByZXF1ZXN0ZWQiLCBsaWtlbHkgZHVlIHRvIHRoZSBmYWN0IHRoYXQgd2UN
Cj4gaGFkIGEgY29udmVyc2F0aW9uIGFib3V0IHRoZSBwYXRjaC4gU28geWVzLCBwbGVhc2UgcmVz
dWJtaXQsIHdpdGggbXkgUmIsDQo+IGFuZCBiZXN0IGFsc28gYWRkIHRoZSBmb2xsb3dpbmcsIHRo
YXQgeW91IHdyb3RlLCB0byB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+IA0KSSB3aWxsIHJlc3VibWl0
IHRoZSBwYXRjaC4gVGhhbmtzLg0KDQo+IEl0IG1lYW5zIGNsb2NrIChNQUMgTUNVKSBzcGVlZCBk
b3duLiBJdCBpcyBub3QgZnJvbSBzcGVjLCBzbyBpdCBpcyBraW5kIG9mDQo+IFJlYWx0ZWsgc3Bl
Y2lmaWMgZmVhdHVyZS4NCj4gSXQgbWF5IGNhdXNlIHBhY2tldCBkcm9wIG9yIGludGVycnVwdCBs
b3NzIChkaWZmZXJlbnQgaGFyZHdhcmUgbWF5IGhhdmUNCj4gZGlmZmVyZW50IGlzc3VlKS4NCg0K

