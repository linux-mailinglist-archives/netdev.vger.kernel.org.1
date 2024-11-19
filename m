Return-Path: <netdev+bounces-146142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6AD9D21B1
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7D31F22233
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 08:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFFC1925B3;
	Tue, 19 Nov 2024 08:38:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D08158D96;
	Tue, 19 Nov 2024 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005512; cv=none; b=ulejSL8LBm9cvTprUjZILGnBDCmUzdOqnDOnwx3EtKKmKJz3n0lq+V7Zryl8R5E0sjhbRunU8ZJ5I6nILoFgDZaCKbYBO3SJpbamNtjXTPaabeXtsuOj6DdrB4ePNdHHFL90/jEjh5a/a2KaLGJ9ehpSWoHHRK7NqbRlPwwOHFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005512; c=relaxed/simple;
	bh=8MOZvwOA2k/at8HFZualT9WLA3LcWXeKk9wIaUaDI/E=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oeOxC6usWSjjAtzRSPX7iAgYAvNBpB1Go6ao1WLPgfy+lSdNbe8HqpDXQBHxtapVu2HGZ2w0lpEZNKsL3Wiz9bOkX2S7r99dpAgpkOw8n/BKKR5aL5b8iGoWiByM+j562oba6GYfMIs0LlvdluwrXlnBvFI0RsSLERT0voLFH/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XsyWB1sppz1V4kG;
	Tue, 19 Nov 2024 16:35:50 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D104180105;
	Tue, 19 Nov 2024 16:38:27 +0800 (CST)
Received: from kwepemn500013.china.huawei.com (7.202.194.154) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 16:38:26 +0800
Received: from dggpeml100007.china.huawei.com (7.185.36.28) by
 kwepemn500013.china.huawei.com (7.202.194.154) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Nov 2024 16:38:26 +0800
Received: from dggpeml100007.china.huawei.com ([7.185.36.28]) by
 dggpeml100007.china.huawei.com ([7.185.36.28]) with mapi id 15.01.2507.039;
 Tue, 19 Nov 2024 16:38:26 +0800
From: mengkanglai <mengkanglai2@huawei.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "edumazet@google.com" <edumazet@google.com>, "Fengtao
 (fengtao, Euler)" <fengtao40@huawei.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Yanan
 (Euler)" <yanan@huawei.com>
Subject: =?gb2312?B?UkU6tPC4tDoga2VybmVsIHRjcCBzb2NrZXRzIHN0dWNrIGluIEZJTl9XQUlU?=
 =?gb2312?Q?1_after_call_tcp=5Fclose?=
Thread-Topic: =?gb2312?B?tPC4tDoga2VybmVsIHRjcCBzb2NrZXRzIHN0dWNrIGluIEZJTl9XQUlUMSBh?=
 =?gb2312?Q?fter_call_tcp=5Fclose?=
Thread-Index: Ads6WLnMxTxT5H3UTJOsoe68wa8MAw==
Date: Tue, 19 Nov 2024 08:38:26 +0000
Message-ID: <d46151818b694dc79b488061817d3d73@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBLdW5peXVraSBJd2FzaGltYSA8a3VuaXl1
QGFtYXpvbi5jb20+IA0KPiC3osvNyrG85DogMjAyNMTqMTHUwjE0yNUgMjo1Ng0KPiDK1bz+yMs6
IG1lbmdrYW5nbGFpIDxtZW5na2FuZ2xhaTJAaHVhd2VpLmNvbT4NCj4gs63LzTogZGF2ZW1AZGF2
ZW1sb2Z0Lm5ldDsgZHNhaGVybkBrZXJuZWwub3JnOyBlZHVtYXpldEBnb29nbGUuY29tOyBGZW5n
dGFvIChmZW5ndGFvLCBFdWxlcikgPGZlbmd0YW80MEBodWF3ZWkuY29tPjsga3ViYUBrZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3Jn
OyBwYWJlbmlAcmVkaGF0LmNvbTsgWWFuYW4gKEV1bGVyKSA8eWFuYW5AaHVhd2VpLmNvbT47IGt1
bml5dUBhbWF6b24uY29tDQo+INb3zOI6IFJlOiBrZXJuZWwgdGNwIHNvY2tldHMgc3R1Y2sgaW4g
RklOX1dBSVQxIGFmdGVyIGNhbGwgdGNwX2Nsb3NlDQo+IA0KPiBGcm9tOiBtZW5na2FuZ2xhaSA8
bWVuZ2thbmdsYWkyQGh1YXdlaS5jb20+DQo+IERhdGU6IFdlZCwgMTMgTm92IDIwMjQgMTI6NDA6
MzQgKzAwMDANCj4gPiBIZWxsbywgRXJpYzoNCj4gPiBDb21taXQgMTUxYzljNzI0ZDA1ICh0Y3A6
IHByb3Blcmx5IHRlcm1pbmF0ZSB0aW1lcnMgZm9yIGtlcm5lbCANCj4gPiBzb2NrZXRzKSBpbnRy
b2R1Y2UgaW5ldF9jc2tfY2xlYXJfeG1pdF90aW1lcnNfc3luYyBpbiB0Y3BfY2xvc2UuDQo+ID4g
Rm9yIGtlcm5lbCBzb2NrZXRzIGl0IGRvZXMgbm90IGhvbGQgc2stPnNrX25ldF9yZWZjbnQsIGlm
IHRoaXMgaXMgDQo+ID4ga2VybmVsIHRjcCBzb2NrZXQgaXQgd2lsbCBjYWxsIHRjcF9zZW5kX2Zp
biBpbiBfX3RjcF9jbG9zZSB0byBzZW5kIEZJTiANCj4gPiBwYWNrZXQgdG8gcmVtb3RlcyBzZXJ2
ZXIsDQo+IA0KPiBKdXN0IGN1cmlvdXMgd2hpY2ggc3Vic3lzdGVtIHRoZSBrZXJuZWwgc29ja2V0
IGlzIGNyZWF0ZWQgYnkuDQo+IA0KPiBSZWNlbnRseSwgQ0lGUyBhbmQgc3VucnBjIGFyZSAoYmVp
bmcpIGNvbnZlcnRlZCB0byBob2xkIG5ldCByZWZjbnQuDQo+IA0KPiBDSUZTOiBodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQv
Y29tbWl0Lz9pZD1lZjcxMzRjN2ZjNDhlMTQ0MWIzOThlNTVhODYyMjMyODY4YTZmMGE3DQo+IHN1
bnJwYzogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjQxMTEyMTM1NDM0LjgwMzg5
MC0xLWxpdWppYW41NkBodWF3ZWkuY29tLw0KPiANCj4gSSByZW1lbWJlciBSRFMncyBsaXN0ZW5l
ciBkb2VzIG5vdCBob2xkIHJlZmNudCBidXQgb3RoZXIgY2xpZW50IHNvY2tldHMgKFNNQywgUkRT
LCBNUFRDUCwgQ0lGUywgc3VucnBjKSBkby4NCj4gDQo+IEkgdGhpbmsgYWxsIFRDUCBrZXJuZWwg
c29ja2V0cyBzaG91bGQgaG9sZCBuZXRucyByZWZjbnQgZXhjZXB0IGZvciBvbmUgY3JlYXRlZCBh
dCBwZXJuZXRfb3BlcmF0aW9ucy5pbml0KCkgaG9vayBsaWtlIFJEUy4NCj4gDQo+ID4gaWYgdGhp
cyBmaW4gcGFja2V0IGxvc3QgZHVlIHRvIG5ldHdvcmsgZmF1bHRzLCB0Y3Agc2hvdWxkIHJldHJh
bnNtaXQgDQo+ID4gdGhpcyBmaW4gcGFja2V0LCBidXQgdGNwX3RpbWVyIHN0b3BwZWQgYnkgaW5l
dF9jc2tfY2xlYXJfeG1pdF90aW1lcnNfc3luYy4NCj4gPiB0Y3Agc29ja2V0cyBzdGF0ZSB3aWxs
IHN0dWNrIGluIEZJTl9XQUlUMSBhbmQgbmV2ZXIgZ28gYXdheS4gSSB0aGluayANCj4gPiBpdCdz
IG5vdCByaWdodC4NCg0KDQpJIGZvdW5kIHRoaXMgcHJvYmxlbSB3aGVuIHRlc3RpbmcgbmZzLiBz
dW5ycGM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDI0MTExMjEzNTQzNC44MDM4
OTAtMS1saXVqaWFuNTZAaHVhd2VpLmNvbS8gd2lsbCBzb2x2ZSB0aGlzIHByb2JsZW0uIA0KSSBh
Z3JlZSB3aXRoIHRoYXQgYWxsIFRDUCBrZXJuZWwgc29ja2V0cyBzaG91bGQgaG9sZCBuZXRucyBy
ZWZjbnQuDQpIb3dldmVyLCBmb3Iga2VybmVsIHRjcCBzb2NrZXRzIGNyZWF0ZWQgYnkgb3RoZXIg
a2VybmVsIG1vZHVsZXMgdGhyb3VnaCBzb2NrX2NyZWF0ZV9rZXJuIG9yIHNrX2FsbG9jKGtlcm49
MCksIGl0IG1lYW5zIHRoYXQgdGhleSBtdXN0IG5vdyBob2xkIHNrX25ldF9yZWZjbmYsIG90aGVy
d2lzZSBmaW4gd2lsbCBvbmx5IGJlIHNlbnQgb25jZSBhbmQgd2lsbCBub3QgYmUgcmV0cmFuc21p
dHRlZCB3aGVuIHRoZSBzb2NrZXQgaXMgcmVsZWFzZWQuQnV0IG90aGVyIHVzZSB0Y3AgbW9kdWxl
cyBtYXkgbm90IGJlIGF3YXJlIG9mIGhvbGQgc2tfbmV0X3JlZmNudC4gc2hvdWxkIHdlIGFkZCBh
IGNoZWNrIGluIHRjcF9jbG9zZaO/DQoNCi0tLQ0KZGlmZiAtLWdpdCBhL25ldC9pcHY0L3RjcC5j
IGIvbmV0L2lwdjQvdGNwLmMNCmluZGV4IGZiOTIwMzY5Yy4uNmI5MjAyNmE0IDEwMDY0NA0KLS0t
IGEvbmV0L2lwdjQvdGNwLmMNCisrKyBiL25ldC9pcHY0L3RjcC5jDQpAQCAtMjgwNCw3ICsyODA0
LDcgQEAgdm9pZCB0Y3BfY2xvc2Uoc3RydWN0IHNvY2sgKnNrLCBsb25nIHRpbWVvdXQpDQogICAg
ICAgIGxvY2tfc29jayhzayk7DQogICAgICAgIF9fdGNwX2Nsb3NlKHNrLCB0aW1lb3V0KTsNCiAg
ICAgICAgcmVsZWFzZV9zb2NrKHNrKTsNCi0gICAgICAgaWYgKCFzay0+c2tfbmV0X3JlZmNudCkN
CisgICAgICAgaWYgKHNrLT5uZXQgIT0gJmluaXRfbmV0ICYmICFzay0+c2tfbmV0X3JlZmNudCkN
CiAgICAgICAgICAgICAgICBpbmV0X2Nza19jbGVhcl94bWl0X3RpbWVyc19zeW5jKHNrKTsNCiAg
ICAgICAgc29ja19wdXQoc2spOw0KIH0NCg==

