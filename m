Return-Path: <netdev+bounces-294691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p7GvDWTyH2pBtAAAu9opvQ
	(envelope-from <netdev+bounces-294691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 11:22:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A92F76361D6
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 11:22:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=DEffNBzq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294691-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294691-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D4EC315FC4A
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 09:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED4C37BE7E;
	Wed,  3 Jun 2026 09:13:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0CD37B012;
	Wed,  3 Jun 2026 09:13:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478026; cv=none; b=cu6fFqJO4FqMXvU81LCyQ0qOXP+NcG5urDo/ydG5qMw5yrqsTqu1oG/3Bwb1pp4L8WVmBc0IJ5Q7O5mcyWFAHeiZdeJP1ybnuTXRaocwd5EPzY6d66jasM92vJUZipaGKeUaMvYGc7NkRu7VzP/Ke1m/3aj/EMxgA7mhLtQuBSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478026; c=relaxed/simple;
	bh=FZjOqMxNgSXYU7esm/O9XWUsP3DSF/UOljhY02gPSkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z8Dsn2J7Fz+xIKYNyfe8/a7ZWpWQWVeZTYkWqfXpUoOem0gmBAtAdo6fYHDUGEkxsj+gg8nbdJ2wBZ07Li3Mc/2AVXsInx4QNfQUvd9y+hKP6Lf1spwlEHAaXrPJGP67T/cCQK+1EPhusUk2jMDAdRyjDCX4PDRsdvggt3X9lEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=DEffNBzq; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6539DDwO43715451, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780477994;
	bh=FZjOqMxNgSXYU7esm/O9XWUsP3DSF/UOljhY02gPSkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=DEffNBzqV7rRasy27ecbGDpHpv70RgHkKqvgps5las7yIwA0swVtxhqAYgLYW/fhC
	 nx9gLfzu6j0xXHFN8aXMeF6qmGPyPogq5ZhUUpD2abGo/tuOYXUq0Fnw8yZIOPBNfJ
	 +KSsyi8qb8rEm6EFbPQHC7JzJTGSFWLe0f1SJq7JK8aC8XANhFHsb1kVPaSEAbxfpT
	 g2eS0I+po/QxwkamSfmp59/kHDuMeiA6u+tyhIea7I4X+vRiTpj5O2580UcfVle0Vp
	 ft9q61BTyh1qk/amOh17Y84v7HaWZ1METJMgU91PuKH9PMca1mRx3qTCTHROkoo1A9
	 x2tdn+AIjk+Og==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6539DDwO43715451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Jun 2026 17:13:14 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Jun 2026 17:13:13 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Wed,
 3 Jun 2026 17:13:13 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v1 1/5] net: phy: realtek: add support for dummy
 phy
Thread-Topic: [PATCH net-next v1 1/5] net: phy: realtek: add support for dummy
 phy
Thread-Index: AQHc8yZ/Mp8SA5nBjkWeW0kSVYYOAbYr622AgACJVcD//4tpAIAAiC6A
Date: Wed, 3 Jun 2026 09:13:13 +0000
Message-ID: <7c35fa5bb5f24afdb42e2d45a4e559c3@realsil.com.cn>
References: <20260603065916.334-1-javen_xu@realsil.com.cn>
 <20260603065916.334-2-javen_xu@realsil.com.cn>
 <7496c873-fee7-4584-ad70-4315d7b94f8f@bootlin.com>
 <f614a60942e34bf39b1d49fb273221ab@realsil.com.cn>
 <0bc2ae0e-316c-447e-9098-f18f4b491328@bootlin.com>
In-Reply-To: <0bc2ae0e-316c-447e-9098-f18f4b491328@bootlin.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294691-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:mid,realsil.com.cn:dkim,realsil.com.cn:from_mime,realsil.com.cn:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A92F76361D6

PkhpLA0KPg0KPk9uIDYvMy8yNiAxMDowMCwgSmF2ZW4gd3JvdGU6DQo+Pj4gT24gNi8zLzI2IDA4
OjU5LCBqYXZlbiB3cm90ZToNCj4+Pj4gRnJvbTogSmF2ZW4gWHUgPGphdmVuX3h1QHJlYWxzaWwu
Y29tLmNuPg0KPj4+Pg0KPj4+PiBBZGQgc3VwcG9ydCBmb3IgcnRsODExNmFmIGR1bW15IHBoeSBk
cml2ZXIsIG1hdGNoIHBoeSBpZCBhbmQgcmVhZA0KPj4+PiBsaW5rIHNwZWVkIGZyb20gTUlJX0JN
Q1IuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEphdmVuIFh1IDxqYXZlbl94dUByZWFsc2ls
LmNvbS5jbj4NCj4+Pg0KPj4+IENhbiB5b3UgZWxhYm9yYXRlIG1vcmUgb24gd2h5IHRoaXMgaXMg
bmVlZGVkID8NCj4+Pg0KPj4+IFRoZSBjb3ZlciBzYXlzIDoNCj4+PiAiDQo+Pj4gSW4gdGhpcyBt
b2RlLCB0aGUgZHJpdmVyDQo+Pj4gbmVlZHMgYSBkdW1teSBQSFkgSUQgc28gdGhhdCBwaHlsaWIg
Y2FuIGF0dGFjaCB0byBhIGR1bW15IFJlYWx0ZWsgUEhZDQo+Pj4gZHJpdmVyLCB3aGlsZSBzZWxl
Y3RlZCBzdGFuZGFyZCBQSFkgcmVnaXN0ZXJzIGFyZSBoYW5kbGVkIHRocm91Z2ggdGhlDQo+Pj4g
U2VyRGVzIHJlZ2lzdGVyLg0KPj4+ICINCj4+Pg0KPj4+IFdoeSBjYW4ndCB5b3UgdXNlIHRoZSBT
ZXJEZXMgcmVnaXN0ZXJzIGZvciB5b3VyIFBIWSBkcml2ZXIgPyBUaGUNCj4+PiBwaHJhc2UgYWJv
dmUgc3VnZ2VzdHMgdGhhdCB0aGUgIlNlckRlcyByZWdpc3RlcnMiIGhhdmUgdGhlIHR5cGljYWwN
Cj4+PiBDMjIvNDUgbGF5b3V0LiBUaGVyZSBhcmUgUEhZcyBhbmQgUENTcyBvdXQgdGhlcmUgdGhh
dCBhcmVuJ3QgYWNjZXNzZWQNCj4+PiB0aHJvdWdoIHJlZ3VsYXIgTURJTyB3aXRoIHJlZ21hcCBi
ZWluZyB1c2VkIHRvIHRyYW5zbGF0ZSB0aGUgbWRpbw0KPj4+IGFjY2Vzc2VzIGRvbmUgYnkgcGh5
bGliIGludG8gdGhlIGFjdHVhbCByZWdpc3RlciBhY2Nlc3MgbWV0aG9kIHVzZWQuDQo+Pj4NCj4+
PiBNYXhpbWUNCj4+Pg0KPj4NCj4+IFRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQo+PiBNYXliZSBJ
IHNob3VsZG4ndCBjYWxsIGl0IGEgImR1bW15IiBQSFkuIEl0IGlzIGFjdHVhbGx5IGEgcmVhbCwg
ZGVkaWNhdGVkIFBIWQ0KPmRyaXZlciBmb3IgdGhlIFJUTDgxMTZhZiBvcGVyYXRpbmcgaW4gRmli
ZXIvU2VyRGVzIG1vZGUuIFRoZSByZWFzb24gd2UNCj5jYW5ub3QgdXNlIHRoZSBzdGFuZGFyZCBn
ZW5lcmljIFBIWSBkcml2ZXIgaXMgdGhhdCBoYXJkd2FyZSBkb2VzIG5vdA0KPmNvcnJlY3RseSBw
b3B1bGF0ZSB0aGUgc3RhbmRhcmQgR2lnYWJpdCBTdGF0dXMgUmVnaXN0ZXIgKE1JSV9TVEFUMTAw
MCwgUmVnDQo+MHgwYSkuDQo+PiBIZXJlIGlzIGEgc25pcHBldCBvZiBvdXIgTURJTyByZWFkIHRy
YWNlIGR1cmluZyBsaW5rIHVwOg0KPj4gcjgxNjkgMDAwMDo4NTowMC4xOiBNRElPIHJlYWQ6IHRw
LT5vY3BfYmFzZT0weGE0MDAsIHJlZz0weDBhLA0KPj4gdmFsdWU9MHgwMDAwDQo+PiByODE2OSAw
MDAwOjg1OjAwLjE6IE1ESU8gcmVhZDogdHAtPm9jcF9iYXNlPTB4YTQwMCwgcmVnPTB4MDUsDQo+
PiB2YWx1ZT0weDQxYTAgUmVnIDB4MGEgcmV0dXJucyAweDAwMDAsIHRoZSBwaHlsaWIgZ2VuZXJp
YyBzdGF0dXMgcGFyc2VyIGZhaWxzDQo+dG8gcmVzb2x2ZSB0aGUgMTAwME1icHMgbGluaywgY2F1
c2luZyB0aGUgZHJpdmVyIHRvIGluY29ycmVjdGx5IGZhbGwgYmFjayB0byBhDQo+Zm9yY2VkIDEw
TWJwcywgZXZlbiB0aG91Z2ggdGhlIHBoeXNpY2FsIGxpbmsgaXMgYWN0dWFsbHkgVVAgYXQgMTAw
ME1icHMuDQo+VGhlcmVmb3JlLCB3ZSBuZWVkIHRvIHJlZ2lzdGVyIGEgY3VzdG9tIFBIWSBkcml2
ZXIgdG8gcHJvdmlkZSBhDQo+c3BlY2lmaWMgLnJlYWRfc3RhdHVzIGNhbGxiYWNrIHRoYXQgcGFy
c2VzIE1JSV9CTUNSIGluc3RlYWQgb2YgcmVseWluZyBvbg0KPk1JSV9TVEFUMTAwMC4NCj4NCj5U
aGlzIGJlaGF2aW91ciBvZiBub3QgZ2V0dGluZyBwcm9wZXIgaW5mb3JtYXRpb24gdGhyb3VnaCB0
aGUgc3RhbmRhcmQNCj5yZWdpc3RlciBoYXBwZW5zIG9uIG11bHRpcGxlIGRpZmZlcmVudCBQSFlz
LCBzbyBoYXZpbmcgYSBkZWRpY2F0ZWQgZHJpdmVyIGlzDQo+dGhlIHdheSB0byBnbyBpbmRlZWQu
DQo+DQo+V2hhdCBkb2VzIHRoaXMgUEhZIGRvIGV4YWN0bHksIGRvZXMgaXQgY29ubmVjdCB0byBh
biBTRlAgY2FnZSBhcyB0aGUgbmFtZQ0KPnNlZW1zIHRvIGltcGx5ID8gSWYgc28sIHdoYXQga2lu
ZCBvZiBtb2RlIGNhbiBpdCBzdXBwb3J0ID8NCj4xMDAwQmFzZVgvMTAwQmFzZVgsIG1heWJlIFNH
TUlJIGFzIHdlbGwgPw0KPg0KPldoYXQgSSBkb24ndCBxdWl0ZSB1bmRlcnN0YW5kIHRoZW4gaXMg
d2h5IHlvdSBoYXZlIHRoZSBuZWVkIHRvIHJldHVybiBhDQo+Y3VzdG9tIFBIWSBJRCB0aGF0IG1h
dGNoZXMgdGhhdCAiZHVtbXkiIGRyaXZlciwgaW4gdGhlIG5leHQgcGF0Y2guDQo+DQo+SWYgdGhp
cyBpcyBhIHJlZ3VsYXIgUEhZIHdpdGggQzIyIHJlZ2lzdGVycywgd2hhdCdzIHRoZSBvcmlnaW5h
bCBjb250ZW50IG9mDQo+UEhZU0lEMS8yID8gTQ0KPg0KPkNhbiB5b3UgZXhwbGFpbiB3aGF0IHRo
ZSBoYXJkd2FyZSBsb29rcyBsaWtlIGV4YWN0bHkgPyBXaGF0IGFyZSB0aGUgZGlmZmVyZW50DQo+
Y29tcG9uZW50cyBpbnZvbHZlZCwgZXRjID8NCj4NCj5NYXhpbWUNCg0KSXQgc3VwcG9ydHMgMTAw
MEJhc2VYIG1vZGUuDQpUaGUgZGF0YXBhdGggaW4gRmliZXIgbW9kZSBpcyBzdHJpY3RseSBhbmQg
c2ltcGx5OiBNQUMgLT4gUENTIC0+IFNlckRlcy4gTUFDIGFjY2Vzc2VzIHRoZSBQQ1MgcmVnaXN0
ZXJzIHZpYSBNQUMgT0NQIGNoYW5uZWwuIEFsdGhvdWdoIGl0IGlzIGFjY2Vzc2VkIHZpYSBNQUMg
T0NQLCB0aGUgcmVnaXN0ZXIgZGVmaW5pdGlvbnMgYXQgdGhvc2UgYWRkcmVzc2VzIGFyZSBleGFj
dGx5IHRoZSBzYW1lIGFzIHRoZSBJRUVFIDgwMi4zIENsYXVzZSAyMiBQSFkgc3RhbmRhcmQgcmVn
aXN0ZXJzLg0KUmVhZGluZyBSZWcgMHgwMiBhbmQgMHgwMyB2aWEgdGhpcyBNQUMgT0NQIGludGVy
ZmFjZSBzaW1wbHkgcmV0dXJucyAweDAwMDAwMDAwLg0KWyAxNjcxLjI5OTgzN10gcjgxNjkgMDAw
MDo4NTowMC4xOiA4MTE2YWYgcmVhZDogcmVnPTB4MDIsIHZhbHVlPTB4MDAwMA0KWyAxNjcxLjI5
OTkwNl0gcjgxNjkgMDAwMDo4NTowMC4xOiA4MTE2YWYgcmVhZDogcmVnPTB4MDMsIHZhbHVlPTB4
MDAwMA0KU28gd2UgbmVlZCBhIGR1bW15IHBoeSBpZCB0byBhdHRhY2ggcGh5IGRyaXZlci4NCg0K
QlJzLA0KSmF2ZW4NCg0K

