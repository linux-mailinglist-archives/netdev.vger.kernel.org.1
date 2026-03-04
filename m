Return-Path: <netdev+bounces-263644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MtnMbfrp2lDlwAAu9opvQ
	(envelope-from <netdev+bounces-263644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:22:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 269F21FC7A1
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0C9D308A14C
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 08:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3132C36EAAB;
	Wed,  4 Mar 2026 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="h7/vvATO"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34803264E5;
	Wed,  4 Mar 2026 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772612256; cv=none; b=d1m93LXFm6o9qGPajzggzIMaKU17BNJ4bK7crK8SYPsMCEd2Hr7aA87efw4JJ5AB4F15NUSowkyQINntIyQQZAkyQ6Dm+iOOxuf8uj0ukFi4wuFH2ajgiSnGR3MvhVcFWVruKaL5S4bX+3/1JR7kzbSOmqUQ0jTpRbhaj0GqTqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772612256; c=relaxed/simple;
	bh=qG1hjhHVos0TxzU+bIrZC4rFHXjeZsmYS+c3PCR6Z9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lgz4gA9r/9UgRdW+YOJD0pNCAhQ9L/Y/o77Dqj3hDdJgI8rxNWShfwMH62rL2vQMlH8Jdrg96s/i4uxHbHNzwP0QIONBUf2QgoN8K06EymG7zgGa2nj0oA9t5GEgVDlUav9PXp31pq60ys/WA7lzXyaGVlrDKZLyaBGlkoIa6ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=h7/vvATO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6248GuZU22928764, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1772612217;
	bh=qG1hjhHVos0TxzU+bIrZC4rFHXjeZsmYS+c3PCR6Z9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=h7/vvATO0h5XxHBcTP5NlNuMdDg9DlkWzpAP9yU9m3JjyvtC2xGlRNdRPJOYGd3WM
	 6cOj+mt1PfUhaBhuRb0jpSYePtPflmG3yM09nq2b1MYPpKCmz6VE9NV3f2OY9n0nRb
	 goi96V+DPvdIN/GVzAnUhmMDvPorVmY7LWBhoeANWTzXzpvIX4D/+tb9N1QivzJszF
	 RrYWuaCwJMz4rlztGinHvZ8zsSyiIotfkrZrXN6GKpR7S9HgzvWQMMbiSi3SFcHRG1
	 +keWs/cbWZlksLNkqTysp6ugFeyzL4oQ+g3oIJCh3SaIcf9J2SgIm+3PV4QiCJawtp
	 cNDTE1FSyh5rQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6248GuZU22928764
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Mar 2026 16:16:57 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Wed, 4 Mar 2026 16:16:56 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.1748.039; Wed,
 4 Mar 2026 16:16:56 +0800
From: =?utf-8?B?6K645L+K5Lyf?= <javen_xu@realsil.com.cn>
To: Heiner Kallweit <hkallweit1@gmail.com>,
        "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v1 2/4] r8169: add sfp mode for RTL8116af
Thread-Topic: [PATCH net-next v1 2/4] r8169: add sfp mode for RTL8116af
Thread-Index: AQHcqg5Z7uVmgFYgw0+wv8VnyYk43LWbR6uAgAK8v1A=
Date: Wed, 4 Mar 2026 08:16:56 +0000
Message-ID: <d00155fb7b2549eaafbeeeffe2b2d56d@realsil.com.cn>
References: <20260302063215.1790-1-javen_xu@realsil.com.cn>
 <20260302063215.1790-3-javen_xu@realsil.com.cn>
 <d2b97f5b-6032-49fd-b80a-6fb47f3fad4c@gmail.com>
In-Reply-To: <d2b97f5b-6032-49fd-b80a-6fb47f3fad4c@gmail.com>
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
X-Rspamd-Queue-Id: 269F21FC7A1
X-Rspamd-Server: lfdr
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263644-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realsil.com.cn:dkim,realsil.com.cn:email,realsil.com.cn:mid]
X-Rspamd-Action: no action

Pk9uIDAyLjAzLjIwMjYgMDc6MzIsIGphdmVuIHdyb3RlOg0KPj4gRnJvbTogSmF2ZW4gWHUgPGph
dmVuX3h1QHJlYWxzaWwuY29tLmNuPg0KPj4NCj4+IFJUTDgxMTZhZiBpcyBhIHZhcmlhdGlvbiBv
ZiBSVEw4MTY4ZnAuIEl0IHVzZXMgU2VyRGVzIGluc3RlYWQgb2YgUEhZLg0KPj4gQnV0IFNlckRl
cyBzdGF0dXMgd2lsbCBub3QgcmVsZWN0IHRvIFBIWS4gU28gaXQgbmVlZHMgdG8gYWRkIHNmcCBt
b2RlDQo+PiBmb3IgcXVpcmsgdG8gaGVscCByZWZsZWN0IFNlckRlcyBzdGF0dXMgZHVyaW5nIFBI
WSByZWFkLg0KPj4NCj4NCj5JcyB0aGVyZSBhbnkgbWFzcyBtYXJrZXQgZGV2aWNlIHVzaW5nIHRo
aXMgY2hpcCB2ZXJzaW9uPyBBcyBmYXIgYXMgcG9zc2libGUgSSdkDQo+bGlrZSB0byBhdm9pZCBh
ZGRpbmcgc3VwcG9ydCBmb3IgY2hpcCB2ZXJzaW9ucyB0aGF0IG5ldmVyIG1ha2UgaXQgdG8gdGhl
IG1hc3MNCj5tYXJrZXQuIFRoaXMganVzdCBtYWtlcyBkcml2ZXIgbWFpbnRlbmFuY2UgaGFyZGVy
Lg0KPg0KPlRoZSBwYXRjaCBpbmNsdWRlcyBzdXBwb3J0IGZvciAxMDBNYnBzIGZpYmVyIG1vZGUu
IElzIHRoZXJlIGFueSB1c2UgY2FzZSBmb3INCj5zdWNoIGxlZ2FjeSBtb2Rlcz8NCj4NCg0KT3Vy
IGN1c3RvbWVyIHBsYXRmb3JtICh1c2luZyBSVEw4MTE2YWYpIHJlcXVpcmVzIHN1cHBvcnQgZm9y
IGVudGVyaW5nIGMxMA0KcG93ZXItc2F2aW5nIHN0YXRlLCBzbyB3ZSBuZWVkIHRvIGFkZCBzdXBw
b3J0IGZvciB0aGlzIGNoaXAuDQoNCj4NCj4+IFNpZ25lZC1vZmYtYnk6IEphdmVuIFh1IDxqYXZl
bl94dUByZWFsc2lsLmNvbS5jbj4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3Jl
YWx0ZWsvcjgxNjlfbWFpbi5jIHwgNzENCj4+ICsrKysrKysrKysrKysrKysrKysrLS0tDQo+PiAg
MSBmaWxlIGNoYW5nZWQsIDYyIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+
PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+PiBpbmRleCBm
YjIyNDdhMjBjMzYuLmE1YzBkMzk5NTMyOCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9yZWFsdGVrL3I4MTY5X21haW4uYw0KPj4gQEAgLTcyNiw2ICs3MjYsMTIgQEAgZW51bSBydGxf
ZGFzaF90eXBlIHsNCj4+ICAgICAgIFJUTF9EQVNIXzI1X0JQLA0KPj4gIH07DQo+Pg0KPj4gK2Vu
dW0gcnRsX3NmcF9tb2RlIHsNCj4+ICsgICAgIFJUTF9TRlBfTk9ORSwNCj4+ICsgICAgIFJUTF9T
RlBfODE2OF9BRiwNCj4+ICsgICAgIFJUTF9TRlBfODEyN19BVEYsDQo+PiArfTsNCj4+ICsNCj4+
ICBzdHJ1Y3QgcnRsODE2OV9wcml2YXRlIHsNCj4+ICAgICAgIHZvaWQgX19pb21lbSAqbW1pb19h
ZGRyOyAgICAgICAgLyogbWVtb3J5IG1hcCBwaHlzaWNhbCBhZGRyZXNzICovDQo+PiAgICAgICBz
dHJ1Y3QgcGNpX2RldiAqcGNpX2RldjsNCj4+IEBAIC03MzQsNiArNzQwLDcgQEAgc3RydWN0IHJ0
bDgxNjlfcHJpdmF0ZSB7DQo+PiAgICAgICBzdHJ1Y3QgbmFwaV9zdHJ1Y3QgbmFwaTsNCj4+ICAg
ICAgIGVudW0gbWFjX3ZlcnNpb24gbWFjX3ZlcnNpb247DQo+PiAgICAgICBlbnVtIHJ0bF9kYXNo
X3R5cGUgZGFzaF90eXBlOw0KPj4gKyAgICAgZW51bSBydGxfc2ZwX21vZGUgc2ZwX21vZGU7DQo+
PiAgICAgICB1MzIgY3VyX3J4OyAvKiBJbmRleCBpbnRvIHRoZSBSeCBkZXNjcmlwdG9yIGJ1ZmZl
ciBvZiBuZXh0IFJ4IHBrdC4gKi8NCj4+ICAgICAgIHUzMiBjdXJfdHg7IC8qIEluZGV4IGludG8g
dGhlIFR4IGRlc2NyaXB0b3IgYnVmZmVyIG9mIG5leHQgUnggcGt0LiAqLw0KPj4gICAgICAgdTMy
IGRpcnR5X3R4Ow0KPj4gQEAgLTc2MCw3ICs3NjcsNiBAQCBzdHJ1Y3QgcnRsODE2OV9wcml2YXRl
IHsNCj4+ICAgICAgIHVuc2lnbmVkIHN1cHBvcnRzX2dtaWk6MTsNCj4+ICAgICAgIHVuc2lnbmVk
IGFzcG1fbWFuYWdlYWJsZToxOw0KPj4gICAgICAgdW5zaWduZWQgZGFzaF9lbmFibGVkOjE7DQo+
PiAtICAgICBib29sIHNmcF9tb2RlOjE7DQo+PiAgICAgICBkbWFfYWRkcl90IGNvdW50ZXJzX3Bo
eXNfYWRkcjsNCj4+ICAgICAgIHN0cnVjdCBydGw4MTY5X2NvdW50ZXJzICpjb3VudGVyczsNCj4+
ICAgICAgIHN0cnVjdCBydGw4MTY5X3RjX29mZnNldHMgdGNfb2Zmc2V0OyBAQCAtMTEyNiw3ICsx
MTMyLDcgQEANCj4+IHN0YXRpYyBpbnQgcjgxNjhfcGh5X29jcF9yZWFkKHN0cnVjdCBydGw4MTY5
X3ByaXZhdGUgKnRwLCB1MzIgcmVnKQ0KPj4gICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+DQo+
PiAgICAgICAvKiBSZXR1cm4gZHVtbXkgTUlJX1BIWVNJRDIgaW4gU0ZQIG1vZGUgdG8gbWF0Y2gg
U0ZQIFBIWSBkcml2ZXIgKi8NCj4+IC0gICAgIGlmICh0cC0+c2ZwX21vZGUgJiYgcmVnID09IChP
Q1BfU1REX1BIWV9CQVNFICsgMiAqIE1JSV9QSFlTSUQyKSkNCj4+ICsgICAgIGlmICh0cC0+c2Zw
X21vZGUgPT0gUlRMX1NGUF84MTI3X0FURiAmJiByZWcgPT0NCj4oT0NQX1NURF9QSFlfQkFTRQ0K
Pj4gKyArIDIgKiBNSUlfUEhZU0lEMikpDQo+PiAgICAgICAgICAgICAgIHJldHVybiBQSFlfSURf
UlRMX0RVTU1ZX1NGUCAmIDB4ZmZmZjsNCj4+DQo+PiAgICAgICBSVExfVzMyKHRwLCBHUEhZX09D
UCwgcmVnIDw8IDE1KTsgQEAgLTEyNzAsNiArMTI3NiwzNCBAQCBzdGF0aWMNCj4+IGludCByODE2
OGdfbWRpb19yZWFkKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRwLCBpbnQgcmVnKQ0KPj4gICAg
ICAgcmV0dXJuIHI4MTY4X3BoeV9vY3BfcmVhZCh0cCwgdHAtPm9jcF9iYXNlICsgcmVnICogMik7
ICB9DQo+Pg0KPj4gKy8qIFRoZSBxdWlyayByZWZsZWN0cyBSVEw4MTE2YWYgU2VyRGVzIHN0YXR1
cy4gKi8gc3RhdGljIGludA0KPj4gK3I4MTE2YWZfbWRpb19yZWFkX3F1aXJrKHN0cnVjdCBydGw4
MTY5X3ByaXZhdGUgKnRwLCBpbnQgcmVnKSB7DQo+PiArICAgICB1OCBwaHlTdGF0dXMgPSBSVExf
UjgodHAsIFBIWXN0YXR1cyk7DQo+PiArDQo+PiArICAgICBpZiAoIShwaHlTdGF0dXMgJiBMaW5r
U3RhdHVzKSkNCj4+ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+PiArDQo+PiArICAgICAvKiBC
TVNSICovDQo+PiArICAgICBpZiAodHAtPm9jcF9iYXNlID09IE9DUF9TVERfUEhZX0JBU0UgJiYg
cmVnID09IE1JSV9CTVNSKQ0KPj4gKyAgICAgICAgICAgICByZXR1cm4gQk1TUl9BTkVHQ09NUExF
VEUgfCBCTVNSX0xTVEFUVVM7DQo+PiArDQo+PiArICAgICAvKiBQSFlTUiAqLw0KPj4gKyAgICAg
aWYgKHRwLT5vY3BfYmFzZSA9PSAweGE0MzAgJiYgcmVnID09IDB4MTIpIHsNCj4+ICsgICAgICAg
ICAgICAgaWYgKHBoeVN0YXR1cyAmIF8xMDAwYnBzRikNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gMHgwMDI4Ow0KPj4gKyAgICAgICAgICAgICBlbHNlIGlmIChwaHlTdGF0dXMgJiBf
MTAwYnBzKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiAweDAwMTg7DQo+DQo+VGhp
cyBpcyBhIGNvbXBsZXRlIGhhY2suIEFueSBtZWFucyB0byBhY2Nlc3MgdGhlIFNlckRlcyBkaXJl
Y3RseT8NCg0KVW5saWtlIFJUTDgxMjdhdGYgd2hlcmUgdGhlIFNlckRlcyBzdGF0dXMgaXMgYXV0
b21hdGljYWxseSByZWZsZWN0ZWQgaW4gdGhlDQpTdGFuZGFyZCBQSFkgcmVnaXN0ZXIsIFJUTDgx
MTZhZiBkb2VzIG5vdCBzeW5jIHRoaXMgc3RhdHVzIHRvIHRoZSBQSFkgcmVnaXN0ZXIuDQpNYXli
ZSB0aGlzIGhhcmR3YXJlIGRlc2lnbiBpcyB0byBzYXZlIHBvd2VyLiBTbyB3ZSBoYXZlIG5vIGNo
b2ljZSBidXQgdG8NCnVwc3RyZWFtIHN1Y2ggaGFjayBjb2RlIHRvIGdldCBsaW5rIHN0YXR1cyBh
bmQgc3BlZWQuIA0KR2l2ZW4gdGhpcyBoYXJkd2FyZSBiZWhhdmlvciwgZG8geW91IGhhdmUgYW55
IHN1Z2dlc3Rpb25zIGZvciBhIGNsZWFuZXIgYXBwcm9hY2gsDQpvciB3b3VsZCB0aGlzIHdvcmth
cm91bmQgYmUgYWNjZXB0YWJsZSB3aXRoIHNvbWUgZXhwbGFpbmluZyBjb21tZW50cz8NCg0KVGhh
bmtzLA0KSmF2ZW4gWHUNCg0KPg0KPj4gKyAgICAgfQ0KPj4gKw0KPj4gKyAgICAgcmV0dXJuIDA7
DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgcjgxMTZhZl9tZGlvX3JlYWQoc3RydWN0IHJ0
bDgxNjlfcHJpdmF0ZSAqdHAsIGludCByZWcpIHsNCj4+ICsgICAgIHJldHVybiByODE2OGdfbWRp
b19yZWFkKHRwLCByZWcpIHwgcjgxMTZhZl9tZGlvX3JlYWRfcXVpcmsodHAsDQo+PiArcmVnKTsg
fQ0KPj4gKw0KPj4gIHN0YXRpYyB2b2lkIG1hY19tY3Vfd3JpdGUoc3RydWN0IHJ0bDgxNjlfcHJp
dmF0ZSAqdHAsIGludCByZWcsIGludA0KPj4gdmFsdWUpICB7DQo+PiAgICAgICBpZiAocmVnID09
IDB4MWYpIHsNCj4+IEBAIC0xMjgwLDYgKzEzMTQsMTMgQEAgc3RhdGljIHZvaWQgbWFjX21jdV93
cml0ZShzdHJ1Y3QgcnRsODE2OV9wcml2YXRlDQo+KnRwLCBpbnQgcmVnLCBpbnQgdmFsdWUpDQo+
PiAgICAgICByODE2OF9tYWNfb2NwX3dyaXRlKHRwLCB0cC0+b2NwX2Jhc2UgKyByZWcsIHZhbHVl
KTsgIH0NCj4+DQo+PiArc3RhdGljIGJvb2wgcnRsX2lzXzgxMTZhZihzdHJ1Y3QgcnRsODE2OV9w
cml2YXRlICp0cCkgew0KPj4gKyAgICAgcmV0dXJuIHRwLT5tYWNfdmVyc2lvbiA9PSBSVExfR0lH
QV9NQUNfVkVSXzUyICYmDQo+PiArICAgICAgICAgICAgIChyODE2OF9tYWNfb2NwX3JlYWQodHAs
IDB4ZGMwMCkgJiAweDAwNzgpID09IDB4MDAzMCAmJg0KPj4gKyAgICAgICAgICAgICAocjgxNjhf
bWFjX29jcF9yZWFkKHRwLCAweGQwMDYpICYgMHgwMGZmKSA9PSAweDAwMDA7IH0NCj4+ICsNCj4+
ICBzdGF0aWMgaW50IG1hY19tY3VfcmVhZChzdHJ1Y3QgcnRsODE2OV9wcml2YXRlICp0cCwgaW50
IHJlZykgIHsNCj4+ICAgICAgIHJldHVybiByODE2OF9tYWNfb2NwX3JlYWQodHAsIHRwLT5vY3Bf
YmFzZSArIHJlZyk7IEBAIC0xMzg2LDcNCj4+ICsxNDI3LDEwIEBAIHN0YXRpYyBpbnQgcnRsX3Jl
YWRwaHkoc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHAsIGludCBsb2NhdGlvbikNCj4+ICAgICAg
IGNhc2UgUlRMX0dJR0FfTUFDX1ZFUl8zMToNCj4+ICAgICAgICAgICAgICAgcmV0dXJuIHI4MTY4
ZHBfMl9tZGlvX3JlYWQodHAsIGxvY2F0aW9uKTsNCj4+ICAgICAgIGNhc2UgUlRMX0dJR0FfTUFD
X1ZFUl80MCAuLi4gUlRMX0dJR0FfTUFDX1ZFUl9MQVNUOg0KPj4gLSAgICAgICAgICAgICByZXR1
cm4gcjgxNjhnX21kaW9fcmVhZCh0cCwgbG9jYXRpb24pOw0KPj4gKyAgICAgICAgICAgICBpZiAo
dHAtPnNmcF9tb2RlID09IFJUTF9TRlBfODE2OF9BRikNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gcjgxMTZhZl9tZGlvX3JlYWQodHAsIGxvY2F0aW9uKTsNCj4+ICsgICAgICAgICAg
ICAgZWxzZQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiByODE2OGdfbWRpb19yZWFk
KHRwLCBsb2NhdGlvbik7DQo+PiAgICAgICBkZWZhdWx0Og0KPj4gICAgICAgICAgICAgICByZXR1
cm4gcjgxNjlfbWRpb19yZWFkKHRwLCBsb2NhdGlvbik7DQo+PiAgICAgICB9DQo+PiBAQCAtMTU3
NSw2ICsxNjE5LDIwIEBAIHN0YXRpYyBib29sIHJ0bF9kYXNoX2lzX2VuYWJsZWQoc3RydWN0DQo+
cnRsODE2OV9wcml2YXRlICp0cCkNCj4+ICAgICAgIH0NCj4+ICB9DQo+Pg0KPj4gK3N0YXRpYyBl
bnVtIHJ0bF9zZnBfbW9kZSBydGxfZ2V0X3NmcF9tb2RlKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUg
KnRwKQ0KPj4gK3sNCj4+ICsgICAgIGlmIChydGxfaXNfODEyNSh0cCkpIHsNCj4+ICsgICAgICAg
ICAgICAgdTE2IGRhdGEgPSByODE2OF9tYWNfb2NwX3JlYWQodHAsIDB4ZDAwNik7DQo+PiArDQo+
PiArICAgICAgICAgICAgIGlmICgoZGF0YSAmIDB4ZmYpID09IDB4MDcpDQo+PiArICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIFJUTF9TRlBfODEyN19BVEY7DQo+PiArICAgICB9IGVsc2UgaWYg
KHJ0bF9pc184MTE2YWYodHApKSB7DQo+PiArICAgICAgICAgICAgIHJldHVybiBSVExfU0ZQXzgx
NjhfQUY7DQo+PiArICAgICB9DQo+PiArDQo+PiArICAgICByZXR1cm4gUlRMX1NGUF9OT05FOw0K
Pj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgZW51bSBydGxfZGFzaF90eXBlIHJ0bF9nZXRfZGFzaF90
eXBlKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUNCj4+ICp0cCkgIHsNCj4+ICAgICAgIHN3aXRjaCAo
dHAtPm1hY192ZXJzaW9uKSB7DQo+PiBAQCAtNTY5MywxMiArNTc1MSw3IEBAIHN0YXRpYyBpbnQg
cnRsX2luaXRfb25lKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdA0KPnN0cnVjdCBwY2lfZGV2
aWNlX2lkICplbnQpDQo+PiAgICAgICB9DQo+PiAgICAgICB0cC0+YXNwbV9tYW5hZ2VhYmxlID0g
IXJjOw0KPj4NCj4+IC0gICAgIGlmIChydGxfaXNfODEyNSh0cCkpIHsNCj4+IC0gICAgICAgICAg
ICAgdTE2IGRhdGEgPSByODE2OF9tYWNfb2NwX3JlYWQodHAsIDB4ZDAwNik7DQo+PiAtDQo+PiAt
ICAgICAgICAgICAgIGlmICgoZGF0YSAmIDB4ZmYpID09IDB4MDcpDQo+PiAtICAgICAgICAgICAg
ICAgICAgICAgdHAtPnNmcF9tb2RlID0gdHJ1ZTsNCj4+IC0gICAgIH0NCj4+ICsgICAgIHRwLT5z
ZnBfbW9kZSA9IHJ0bF9nZXRfc2ZwX21vZGUodHApOw0KPj4NCj4+ICAgICAgIHRwLT5kYXNoX3R5
cGUgPSBydGxfZ2V0X2Rhc2hfdHlwZSh0cCk7DQo+PiAgICAgICB0cC0+ZGFzaF9lbmFibGVkID0g
cnRsX2Rhc2hfaXNfZW5hYmxlZCh0cCk7DQoNCg==

