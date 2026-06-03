Return-Path: <netdev+bounces-294699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 28zeHi38H2pttgAAu9opvQ
	(envelope-from <netdev+bounces-294699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 12:04:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A00FD63664F
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 12:04:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=Z8XaZxjk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294699-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294699-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E48CC3013ED8
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 10:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024D03F6C24;
	Wed,  3 Jun 2026 10:03:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D1344A71D;
	Wed,  3 Jun 2026 10:03:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481025; cv=none; b=QXAjB8g14b+PjExu0zl/Eb1iQ2MUaBhOxYCY0igtqQJlWV6LiOtjVIfLuTZD6jEnfYiK/jM55viY7r/ru6SvPaR6Ty1DyMv9ik52lgUWbhJvOBXMdKI0vexcTe02sH8SOwvZoY1Q2UzayK7/Tq4LvgHtMAAHbGFgN03POWtbQDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481025; c=relaxed/simple;
	bh=pEaXSOHQ9QvT9NqytlODNnvrYZrZb7ohW7mnBxtRE/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u7H6NtR10ePTUXHiaHwnqcmG7p0OSA4mIShZZdoetOxVw57Qi94mNYOY3XoPd90Y54Vv7mtDlIuZL3nW7yOqka90FNoTOhK/fZ6UwjlN7O/peL8eaNgjrMTjwJJyUVUuQ62Ptdbc1A1DV8wy/f23SEVA1fcCMLT72UqEV5Hh54A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=Z8XaZxjk; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 653A3DfpC3734791, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780480993;
	bh=pEaXSOHQ9QvT9NqytlODNnvrYZrZb7ohW7mnBxtRE/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Z8XaZxjkDVNQcRci7O0v+cPvqfaApAOVC63PFxOdedMHY6Q8hzOOerit/t4gSgNsO
	 3vg3SbbgJXnRW0pCBwJYCf7B362Td6hwCc8u6vzplH52gn1mKhPOSBZHEudJnxyaeI
	 Uz7clLa345bAWKLkyA/fQStc4hwALtijq7EruUuy5OZx0K5YkJgrO3+8rsL0VtrWH0
	 fD/ciP8BVu9iaFs5YrNCI5ejkmE79GHMrph7jLzveFOKF0rU5AcGHL7xhndEbyAscO
	 uulFimxkeR2DiXgQri/frp1KtVcBHDU0DdWshB01Qvh3Btx5hMruoCd/o6w0/P78J2
	 2XNMmKG6CKOcQ==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 653A3DfpC3734791
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Jun 2026 18:03:13 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Jun 2026 18:03:13 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Wed,
 3 Jun 2026 18:03:13 +0800
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
Thread-Index: AQHc8yZ/Mp8SA5nBjkWeW0kSVYYOAbYr622AgACJVcD//4tpAIAAiC6A//+HfoCAAIdu8A==
Date: Wed, 3 Jun 2026 10:03:13 +0000
Message-ID: <c088522c19624f11beb179a71a11d9c1@realsil.com.cn>
References: <20260603065916.334-1-javen_xu@realsil.com.cn>
 <20260603065916.334-2-javen_xu@realsil.com.cn>
 <7496c873-fee7-4584-ad70-4315d7b94f8f@bootlin.com>
 <f614a60942e34bf39b1d49fb273221ab@realsil.com.cn>
 <0bc2ae0e-316c-447e-9098-f18f4b491328@bootlin.com>
 <7c35fa5bb5f24afdb42e2d45a4e559c3@realsil.com.cn>
 <bac05b34-9c16-4c18-9e6e-a8ccee86f0d3@bootlin.com>
In-Reply-To: <bac05b34-9c16-4c18-9e6e-a8ccee86f0d3@bootlin.com>
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
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294699-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realsil.com.cn:mid,realsil.com.cn:dkim,realsil.com.cn:from_mime,realsil.com.cn:email,bootlin.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A00FD63664F

PkhpLA0KPg0KPk9uIDYvMy8yNiAxMToxMywgSmF2ZW4gd3JvdGU6DQo+Pj4gSGksDQo+Pj4NCj4+
PiBPbiA2LzMvMjYgMTA6MDAsIEphdmVuIHdyb3RlOg0KPj4+Pj4gT24gNi8zLzI2IDA4OjU5LCBq
YXZlbiB3cm90ZToNCj4+Pj4+PiBGcm9tOiBKYXZlbiBYdSA8amF2ZW5feHVAcmVhbHNpbC5jb20u
Y24+DQo+Pj4+Pj4NCj4+Pj4+PiBBZGQgc3VwcG9ydCBmb3IgcnRsODExNmFmIGR1bW15IHBoeSBk
cml2ZXIsIG1hdGNoIHBoeSBpZCBhbmQgcmVhZA0KPj4+Pj4+IGxpbmsgc3BlZWQgZnJvbSBNSUlf
Qk1DUi4NCj4+Pj4+Pg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEphdmVuIFh1IDxqYXZlbl94dUBy
ZWFsc2lsLmNvbS5jbj4NCj4+Pj4+DQo+Pj4+PiBDYW4geW91IGVsYWJvcmF0ZSBtb3JlIG9uIHdo
eSB0aGlzIGlzIG5lZWRlZCA/DQo+Pj4+Pg0KPj4+Pj4gVGhlIGNvdmVyIHNheXMgOg0KPj4+Pj4g
Ig0KPj4+Pj4gSW4gdGhpcyBtb2RlLCB0aGUgZHJpdmVyDQo+Pj4+PiBuZWVkcyBhIGR1bW15IFBI
WSBJRCBzbyB0aGF0IHBoeWxpYiBjYW4gYXR0YWNoIHRvIGEgZHVtbXkgUmVhbHRlaw0KPj4+Pj4g
UEhZIGRyaXZlciwgd2hpbGUgc2VsZWN0ZWQgc3RhbmRhcmQgUEhZIHJlZ2lzdGVycyBhcmUgaGFu
ZGxlZA0KPj4+Pj4gdGhyb3VnaCB0aGUgU2VyRGVzIHJlZ2lzdGVyLg0KPj4+Pj4gIg0KPj4+Pj4N
Cj4+Pj4+IFdoeSBjYW4ndCB5b3UgdXNlIHRoZSBTZXJEZXMgcmVnaXN0ZXJzIGZvciB5b3VyIFBI
WSBkcml2ZXIgPyBUaGUNCj4+Pj4+IHBocmFzZSBhYm92ZSBzdWdnZXN0cyB0aGF0IHRoZSAiU2Vy
RGVzIHJlZ2lzdGVycyIgaGF2ZSB0aGUgdHlwaWNhbA0KPj4+Pj4gQzIyLzQ1IGxheW91dC4gVGhl
cmUgYXJlIFBIWXMgYW5kIFBDU3Mgb3V0IHRoZXJlIHRoYXQgYXJlbid0DQo+Pj4+PiBhY2Nlc3Nl
ZCB0aHJvdWdoIHJlZ3VsYXIgTURJTyB3aXRoIHJlZ21hcCBiZWluZyB1c2VkIHRvIHRyYW5zbGF0
ZQ0KPj4+Pj4gdGhlIG1kaW8gYWNjZXNzZXMgZG9uZSBieSBwaHlsaWIgaW50byB0aGUgYWN0dWFs
IHJlZ2lzdGVyIGFjY2VzcyBtZXRob2QNCj51c2VkLg0KPj4+Pj4NCj4+Pj4+IE1heGltZQ0KPj4+
Pj4NCj4+Pj4NCj4+Pj4gVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCj4+Pj4gTWF5YmUgSSBzaG91
bGRuJ3QgY2FsbCBpdCBhICJkdW1teSIgUEhZLiBJdCBpcyBhY3R1YWxseSBhIHJlYWwsDQo+Pj4+
IGRlZGljYXRlZCBQSFkNCj4+PiBkcml2ZXIgZm9yIHRoZSBSVEw4MTE2YWYgb3BlcmF0aW5nIGlu
IEZpYmVyL1NlckRlcyBtb2RlLiBUaGUgcmVhc29uDQo+Pj4gd2UgY2Fubm90IHVzZSB0aGUgc3Rh
bmRhcmQgZ2VuZXJpYyBQSFkgZHJpdmVyIGlzIHRoYXQgaGFyZHdhcmUgZG9lcw0KPj4+IG5vdCBj
b3JyZWN0bHkgcG9wdWxhdGUgdGhlIHN0YW5kYXJkIEdpZ2FiaXQgU3RhdHVzIFJlZ2lzdGVyDQo+
Pj4gKE1JSV9TVEFUMTAwMCwgUmVnIDB4MGEpLg0KPj4+PiBIZXJlIGlzIGEgc25pcHBldCBvZiBv
dXIgTURJTyByZWFkIHRyYWNlIGR1cmluZyBsaW5rIHVwOg0KPj4+PiByODE2OSAwMDAwOjg1OjAw
LjE6IE1ESU8gcmVhZDogdHAtPm9jcF9iYXNlPTB4YTQwMCwgcmVnPTB4MGEsDQo+Pj4+IHZhbHVl
PTB4MDAwMA0KPj4+PiByODE2OSAwMDAwOjg1OjAwLjE6IE1ESU8gcmVhZDogdHAtPm9jcF9iYXNl
PTB4YTQwMCwgcmVnPTB4MDUsDQo+Pj4+IHZhbHVlPTB4NDFhMCBSZWcgMHgwYSByZXR1cm5zIDB4
MDAwMCwgdGhlIHBoeWxpYiBnZW5lcmljIHN0YXR1cw0KPj4+PiBwYXJzZXIgZmFpbHMNCj4+PiB0
byByZXNvbHZlIHRoZSAxMDAwTWJwcyBsaW5rLCBjYXVzaW5nIHRoZSBkcml2ZXIgdG8gaW5jb3Jy
ZWN0bHkgZmFsbA0KPj4+IGJhY2sgdG8gYSBmb3JjZWQgMTBNYnBzLCBldmVuIHRob3VnaCB0aGUg
cGh5c2ljYWwgbGluayBpcyBhY3R1YWxseSBVUCBhdA0KPjEwMDBNYnBzLg0KPj4+IFRoZXJlZm9y
ZSwgd2UgbmVlZCB0byByZWdpc3RlciBhIGN1c3RvbSBQSFkgZHJpdmVyIHRvIHByb3ZpZGUgYQ0K
Pj4+IHNwZWNpZmljIC5yZWFkX3N0YXR1cyBjYWxsYmFjayB0aGF0IHBhcnNlcyBNSUlfQk1DUiBp
bnN0ZWFkIG9mDQo+Pj4gcmVseWluZyBvbiBNSUlfU1RBVDEwMDAuDQo+Pj4NCj4+PiBUaGlzIGJl
aGF2aW91ciBvZiBub3QgZ2V0dGluZyBwcm9wZXIgaW5mb3JtYXRpb24gdGhyb3VnaCB0aGUgc3Rh
bmRhcmQNCj4+PiByZWdpc3RlciBoYXBwZW5zIG9uIG11bHRpcGxlIGRpZmZlcmVudCBQSFlzLCBz
byBoYXZpbmcgYSBkZWRpY2F0ZWQNCj4+PiBkcml2ZXIgaXMgdGhlIHdheSB0byBnbyBpbmRlZWQu
DQo+Pj4NCj4+PiBXaGF0IGRvZXMgdGhpcyBQSFkgZG8gZXhhY3RseSwgZG9lcyBpdCBjb25uZWN0
IHRvIGFuIFNGUCBjYWdlIGFzIHRoZQ0KPj4+IG5hbWUgc2VlbXMgdG8gaW1wbHkgPyBJZiBzbywg
d2hhdCBraW5kIG9mIG1vZGUgY2FuIGl0IHN1cHBvcnQgPw0KPj4+IDEwMDBCYXNlWC8xMDBCYXNl
WCwgbWF5YmUgU0dNSUkgYXMgd2VsbCA/DQo+Pj4NCj4+PiBXaGF0IEkgZG9uJ3QgcXVpdGUgdW5k
ZXJzdGFuZCB0aGVuIGlzIHdoeSB5b3UgaGF2ZSB0aGUgbmVlZCB0byByZXR1cm4NCj4+PiBhIGN1
c3RvbSBQSFkgSUQgdGhhdCBtYXRjaGVzIHRoYXQgImR1bW15IiBkcml2ZXIsIGluIHRoZSBuZXh0
IHBhdGNoLg0KPj4+DQo+Pj4gSWYgdGhpcyBpcyBhIHJlZ3VsYXIgUEhZIHdpdGggQzIyIHJlZ2lz
dGVycywgd2hhdCdzIHRoZSBvcmlnaW5hbA0KPj4+IGNvbnRlbnQgb2YNCj4+PiBQSFlTSUQxLzIg
PyBNDQo+Pj4NCj4+PiBDYW4geW91IGV4cGxhaW4gd2hhdCB0aGUgaGFyZHdhcmUgbG9va3MgbGlr
ZSBleGFjdGx5ID8gV2hhdCBhcmUgdGhlDQo+Pj4gZGlmZmVyZW50IGNvbXBvbmVudHMgaW52b2x2
ZWQsIGV0YyA/DQo+Pj4NCj4+PiBNYXhpbWUNCj4+DQo+PiBJdCBzdXBwb3J0cyAxMDAwQmFzZVgg
bW9kZS4NCj4NCj5PaywgYnV0IHRoZSBkcml2ZXIgZm9yIHRoZSAiZHVtbXkiIHBoeSBzZWVtcyB0
byBiZSBhYmxlIHRvIHJlcG9ydCBTUEVFRF8xMDAsDQo+d2hpY2ggeW91IGNhbid0IGFjaGlldmUg
d2l0aCAxMDAwQmFzZVguIEVpdGhlciB0aGlzIGlzIGEgc3RyYXkgY2hlY2sgaW4gdGhlIFBIWQ0K
PmRyaXZlciwgb3IgdGhlcmUncyBtb3JlIHRvIGl0IHRoYW4gMTAwMEJhc2VYIDopDQo+DQo+QWxz
bywgaWYgdGhpcyBpcyAxMDAwQmFzZVggbWF5YmUgeW91IG5lZWQgdG8gdXNlIHRoZSBDMzcgaGVs
cGVycyB0byByZWFkIHRoZQ0KPmxpbmsgc3RhdHVzIDoNCj4NCj5odHRwczovL2VsaXhpci5ib290
bGluLmNvbS9saW51eC92Ny4xLQ0KPnJjNS9zb3VyY2UvZHJpdmVycy9uZXQvcGh5L3BoeV9kZXZp
Y2UuYyNMMjYwNw0KPg0KPj4gVGhlIGRhdGFwYXRoIGluIEZpYmVyIG1vZGUgaXMgc3RyaWN0bHkg
YW5kIHNpbXBseTogTUFDIC0+IFBDUyAtPiBTZXJEZXMuDQo+TUFDIGFjY2Vzc2VzIHRoZSBQQ1Mg
cmVnaXN0ZXJzIHZpYSBNQUMgT0NQIGNoYW5uZWwuIEFsdGhvdWdoIGl0IGlzIGFjY2Vzc2VkDQo+
dmlhIE1BQyBPQ1AsIHRoZSByZWdpc3RlciBkZWZpbml0aW9ucyBhdCB0aG9zZSBhZGRyZXNzZXMg
YXJlIGV4YWN0bHkgdGhlIHNhbWUNCj5hcyB0aGUgSUVFRSA4MDIuMyBDbGF1c2UgMjIgUEhZIHN0
YW5kYXJkIHJlZ2lzdGVycy4NCj4+IFJlYWRpbmcgUmVnIDB4MDIgYW5kIDB4MDMgdmlhIHRoaXMg
TUFDIE9DUCBpbnRlcmZhY2Ugc2ltcGx5IHJldHVybnMNCj4weDAwMDAwMDAwLg0KPj4gWyAxNjcx
LjI5OTgzN10gcjgxNjkgMDAwMDo4NTowMC4xOiA4MTE2YWYgcmVhZDogcmVnPTB4MDIsIHZhbHVl
PTB4MDAwMA0KPj4gWyAxNjcxLjI5OTkwNl0gcjgxNjkgMDAwMDo4NTowMC4xOiA4MTE2YWYgcmVh
ZDogcmVnPTB4MDMsIHZhbHVlPTB4MDAwMA0KPj4gU28gd2UgbmVlZCBhIGR1bW15IHBoeSBpZCB0
byBhdHRhY2ggcGh5IGRyaXZlci4NCj4NCj5TbyB0aGlzIFBIWSBhY3R1YWxseSBkb2Vzbid0IGV4
aXN0ID8gd2hhdCB5b3UgaGF2ZSBpcyBhIFBDUyB0aGF0IHlvdSBhY2Nlc3Mgb3Zlcg0KPk1ESU8s
IHJpZ2h0ID8NCj4NCj5JdCBzZWVtcyBpdCBhbGwgYm9pbHMgZG93biB0byBob3cgdGhlIHJlYWx0
ZWsgTUFDIGRyaXZlciBkZWFscyB3aXRoIFBIWXMgYW5kDQo+UENTcyBhbmQgU0ZQLCB0aGF0IGlz
IHdpdGhvdXQgdXNpbmcgcGh5bGluayBvciB0aGUgU0ZQIGluZnJhc3RydWN0dXJlIGF0IGFsbCA6
KA0KPg0KPkNhbiB5b3UgY2hlY2sgZm9yIHRoZSBDMzcgdGhpbmcgYW5kIHRoZSBTUEVFRF8xMDAg
cmVwb3J0aW5nID8NCj4NCj5NYXhpbWUNCj4NCllvdSBhcmUgZXhhY3RseSByaWdodC4gVGhlIFBI
WSBkb2Vzbid0IGFjdHVhbGx5IGV4aXN0OyB3aGF0IHdlIGhhdmUgaXMgYW4gaW50ZXJuYWwgUENT
LiAgSSB3aWxsIHRyeSB1c2luZyB0aGUgQzM3IGhlbHBlcnMgKGdlbnBoeV9jMzdfcmVhZF9zdGF0
dXMoKSkgdG8gcmVhZCB0aGUgbGluayBzdGF0dXMgYW5kIHRlc3QgaG93IGl0IGJlaGF2ZXMgd2l0
aCBvdXIgaGFyZHdhcmUuIEkgd2lsbCBnZXQgYmFjayB0byB5b3Ugd2l0aCB0aGUgcmVzdWx0cyBz
b29uLiBBbmQgY2hlY2sgU1BFRURfMTAwIHRvby4NCkkgYWN0dWFsbHkgdHJpZWQgdG8gbWlncmF0
ZSBpdCB0byBwaHlsaW5rIGJlZm9yZS4gSG93ZXZlciwgdGhlIGN1cnJlbnQgZHJpdmVyIGNvZGVi
YXNlIGlzIGRlZXBseSBjb3VwbGVkIHdpdGggdHAtPnBoeWRldiBpbiBtYW55IHBsYWNlcy4gRGVj
b3VwbGluZyBpdCBtYXkgaW50cm9kdWNlIGJ1Z3MgZm9yIG51bWVyb3VzIGV4aXN0aW5nIGRldmlj
ZXMuIFRoZXJlZm9yZSwgSSB3YW50IHRvIHRyeSB0byBleHBvc2UgdGhlIGludGVybmFsIFBDUyBh
cyBhIGR1bW15IFBIWSBkZXZpY2UuDQpBbnl3YXksIHRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQoN
CkJScywNCkphdmVuDQoNCg==

