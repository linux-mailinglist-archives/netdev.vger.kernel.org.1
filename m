Return-Path: <netdev+bounces-146218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F269D24E1
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 12:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99967B25073
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A7C1C9EB0;
	Tue, 19 Nov 2024 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Aox4JN6B"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3AC1C8306;
	Tue, 19 Nov 2024 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015871; cv=none; b=bBFfDcNvjYPr7VSK70zHBKXbQdJAapF7VlaInvnd1KLyzeZyeggsYfqpjg19yQ5f1Qmp4gNJ3Ipd1lAynVFoCbBegXJ0Q2KXAlsmUYllwvTd9eRBbKuqMm/RXNZ18p4eaksFlOpgrJpfPyjGo5s2K686pxFHKCYdxCw+DqONMwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015871; c=relaxed/simple;
	bh=VGsQijzefvyWwOUR5TJb0AkEtxZrPlruPUyzcP5EKhQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tttJfIX3MNEKudwTMVNCJMKuIntUY3cEBPIuyno9K9BLgkDg+oPCs7gtS55bVmET8j9Q4cqv+zyDOYbYlcTEW0uSxd9mmvOx4lefx2xyvLxx3qHOSU5keIwRXDl9MZxNwa0YW/avwinNQ6/m5oogKKQTp02x4tn6oCmZOidYOVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Aox4JN6B; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AJBUZl942355100, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732015835; bh=VGsQijzefvyWwOUR5TJb0AkEtxZrPlruPUyzcP5EKhQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Aox4JN6BqkTdDcBGwqCV+EWasIDt1+TWkk4YaRbzbCfQdfBplKpZFg4bkPqizlmNt
	 udsOgKXfDoNLrQi7b+luuGdvvRYuELt2bscqDSdezP58u6xy29Fq4IdIIhEIAq2+vj
	 zeCn3Gx2O6GqyYIru7hpaEwTaBk46gMhyxYemmMZ5a4fiji6DDEu816OJ5fEKXT1Qr
	 Zv0aa1L1fke++W39J1KsGiAeKaqbQWnJBK7xSgx5QYREjxvmwW5YnsqgDi79diz/pX
	 iNYmGFrohOFmreOtWmZefpVxpQaYVoV1mYNCBk37F8HIkSbhnt0SELlsclqa+f1oC0
	 Gd+Agn3hNgpSg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AJBUZl942355100
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 19:30:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 19:30:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Nov 2024 19:30:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Tue, 19 Nov 2024 19:30:34 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "horms@kernel.org"
	<horms@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu
	<larry.chiu@realtek.com>
Subject: RE: [PATCH net v2 3/5] rtase: Add support for RTL907XD-VA PCIe port
Thread-Topic: [PATCH net v2 3/5] rtase: Add support for RTL907XD-VA PCIe port
Thread-Index: AQHbN0SFfyRIafwEokSyyOXB545urLK5wOOAgAKTAUCAAZNpgIAAlryQ
Date: Tue, 19 Nov 2024 11:30:34 +0000
Message-ID: <e65e0b67ad4b40be9191271fb183a23f@realtek.com>
References: <20241115095429.399029-1-justinlai0215@realtek.com>
 <20241115095429.399029-4-justinlai0215@realtek.com>
 <939ab163-a537-417f-9edc-0823644a2a1d@lunn.ch>
 <a0280d8e17ce4286b8070028e069d7e9@realtek.com>
 <bf7a70f2-ab0e-467d-a451-a57062982f18@redhat.com>
In-Reply-To: <bf7a70f2-ab0e-467d-a451-a57062982f18@redhat.com>
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

PiBPbiAxMS8xOC8yNCAwMzozMCwgSnVzdGluIExhaSB3cm90ZToNCj4gPj4NCj4gPj4gT24gRnJp
LCBOb3YgMTUsIDIwMjQgYXQgMDU6NTQ6MjdQTSArMDgwMCwgSnVzdGluIExhaSB3cm90ZToNCj4g
Pj4+IDEuIEFkZCBSVEw5MDdYRC1WQSBoYXJkd2FyZSB2ZXJzaW9uIGlkLg0KPiA+Pj4gMi4gQWRk
IHRoZSByZXBvcnRlZCBzcGVlZCBmb3IgUlRMOTA3WEQtVkEuDQo+ID4+DQo+ID4+IFRoaXMgaXMg
bm90IGEgZml4LCBpdCBuZXZlciB3b3JrZWQgb24gdGhpcyBkZXZpY2UgYXMgZmFyIGFzIGkgc2Vl
LiBTbw0KPiA+PiB0aGlzIHNob3VsZCBiZSBmb3IgbmV0LW5leHQuDQo+ID4+DQo+ID4+IFBsZWFz
ZSBzZXBhcmF0ZSB0aGVzZSBwYXRjaGVzIG91dCBpbnRvIHJlYWwgZml4ZXMsIGFuZCBuZXcgZmVh
dHVyZXMuDQo+ID4+DQo+ID4+ICAgICAgICAgQW5kcmV3DQo+ID4NCj4gPiBUaGFuayB5b3UgZm9y
IHlvdXIgcmVzcG9uc2UuIEkgd2lsbCBmb2xsb3cgdGhlc2UgZ3VpZGVsaW5lcyBmb3IgdGhlDQo+
ID4gY2F0ZWdvcml6YXRpb24gYW5kIHVwbG9hZCB0aGUgcGF0Y2ggdG8gbmV0LW5leHQgYWNjb3Jk
aW5nbHkuIEkNCj4gPiBhcHByZWNpYXRlIHlvdXIgYXNzaXN0YW5jZS4NCj4gDQo+IFBsZWFzZSBy
ZS1wb3N0IHRoZSBzZXJpZXMgaW5jbHVkaW5nIG5ldCBwYXRjaGVzIG9ubHkgYW5kIHdhaXQgZm9y
IHRoZSBtZXJnZQ0KPiB3aW5kb3cgY29tcGxldGlvbiAofjJ3IGZyb20gbm93KSBiZWZvcmUgcG9z
dGluZyB0aGUgbmV0LW5leHQgcGF0Y2guDQo+IA0KPiBUaGFua3MhDQo+IA0KPiBQYW9sbw0KDQpI
aSBQYW9sbw0KDQpUaGFuayB5b3UgZm9yIHRoZSBub3RpZmljYXRpb24uIEkgaGF2ZSByZW1vdmVk
IHRoaXMgcGF0Y2ggZnJvbSB0aGUgbGF0ZXN0DQpwYXRjaCBzZXQuDQoNCkp1c3Rpbg0K

