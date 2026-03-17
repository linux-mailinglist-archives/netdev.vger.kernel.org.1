Return-Path: <netdev+bounces-268409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCQRHnXHuGnTjAEAu9opvQ
	(envelope-from <netdev+bounces-268409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:16:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DC22A3153
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6F5C3003D17
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E6A19E819;
	Tue, 17 Mar 2026 03:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="YnYxXTKs"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DEC19539F;
	Tue, 17 Mar 2026 03:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773717337; cv=none; b=PnGMN00lURj5j/yotBeyLmpUv//YV/mBrYxJYwwx4ru2De3Xjk5QHoWfW1mEjdIEuR9oac3sVBe7yAhSNi3t2PSQkafNFkXOQ1649bk9rU32XY0B5TMdgWt4kJUIjqM6ArJCKwLLJ+L3YzVifGW6NJeJIPynyYye5NSCNwCVSBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773717337; c=relaxed/simple;
	bh=jtAthRKadlzFZTp/s4GweKkPrERUzfK2tpkuqLclxuc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=akCW9FQwNnFCPl4hR+A+bk7lloTpAifL6ueg00EWS/97F1/9W3Q206e0C/4aWFcxrsuxGxd6M+HjkUIkTb/aH78kaG/Iu6GI9TV2iHbyZ2xb90qSsjnQmKN2LBFy5zXRcvDQWUXrAWjeM37J5/VnkA1QIuM+6hsN0XEmpUGR4A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=YnYxXTKs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62H3EtxhE3131655, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1773717297;
	bh=jtAthRKadlzFZTp/s4GweKkPrERUzfK2tpkuqLclxuc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=YnYxXTKsFGjKTUBw9z7tBbKX2XYY5I5wHCAv/tmy+thcX+Y8Q6wH/WaOEKy4nuAj0
	 V0wr1Agrjr7oP1ZRHdlTbPG2gQhoa9KqOqL3UPH5G4EQ9uOdm6u9TOlWmvyjKUTG14
	 3+Sy/MFM6uLXOWkwQY+Z2RHjLE+7xj2IugB3pJJVQcEsyj4RDRUfaU0MVxXmh36Q9E
	 O5c7a3P7yB2EnKiV9llDqp7fqnVcOh6MyTUfalhh4y4wGJQTxfRQQPTOjN9m1vJZC0
	 ypNQYGisTq0j19oYAAXPQ2MXodDSuIp1L0Z9kq0AmB3y2TPIprW8zDXtzIaExTa4EG
	 kSO9wqnCPIeKw==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62H3EtxhE3131655
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 17 Mar 2026 11:14:56 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 17 Mar 2026 11:14:55 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Tue,
 17 Mar 2026 11:14:55 +0800
From: Javen <javen_xu@realsil.com.cn>
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
Thread-Index: AQHcqg5Z7uVmgFYgw0+wv8VnyYk43LWbR6uAgBDWaXCAAGZPgIAFmeqw
Date: Tue, 17 Mar 2026 03:14:54 +0000
Message-ID: <761cc11222bc4f4cb206629a76292c97@realsil.com.cn>
References: <20260302063215.1790-1-javen_xu@realsil.com.cn>
 <20260302063215.1790-3-javen_xu@realsil.com.cn>
 <d2b97f5b-6032-49fd-b80a-6fb47f3fad4c@gmail.com>
 <98d632aecbbb4dd8ad79c24e672765b1@realsil.com.cn>
 <fcb72518-24f7-4e16-8208-fb38441408d2@gmail.com>
In-Reply-To: <fcb72518-24f7-4e16-8208-fb38441408d2@gmail.com>
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
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268409-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8DC22A3153
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pk9uIDEzLjAzLjIwMjYgMDg6MjUsIEphdmVuIHdyb3RlOg0KPj4+IE9uIDAyLjAzLjIwMjYgMDc6
MzIsIGphdmVuIHdyb3RlOg0KPj4+PiBGcm9tOiBKYXZlbiBYdSA8amF2ZW5feHVAcmVhbHNpbC5j
b20uY24+DQo+Pj4+DQo+Pj4+IFJUTDgxMTZhZiBpcyBhIHZhcmlhdGlvbiBvZiBSVEw4MTY4ZnAu
IEl0IHVzZXMgU2VyRGVzIGluc3RlYWQgb2YgUEhZLg0KPj4+PiBCdXQgU2VyRGVzIHN0YXR1cyB3
aWxsIG5vdCByZWxlY3QgdG8gUEhZLiBTbyBpdCBuZWVkcyB0byBhZGQgc2ZwDQo+Pj4+IG1vZGUg
Zm9yIHF1aXJrIHRvIGhlbHAgcmVmbGVjdCBTZXJEZXMgc3RhdHVzIGR1cmluZyBQSFkgcmVhZC4N
Cj4+Pj4NCj4+Pg0KPj4+IElzIHRoZXJlIGFueSBtYXNzIG1hcmtldCBkZXZpY2UgdXNpbmcgdGhp
cyBjaGlwIHZlcnNpb24/IEFzIGZhciBhcw0KPj4+IHBvc3NpYmxlIEknZCBsaWtlIHRvIGF2b2lk
IGFkZGluZyBzdXBwb3J0IGZvciBjaGlwIHZlcnNpb25zIHRoYXQNCj4+PiBuZXZlciBtYWtlIGl0
IHRvIHRoZSBtYXNzIG1hcmtldC4gVGhpcyBqdXN0IG1ha2VzIGRyaXZlciBtYWludGVuYW5jZQ0K
PmhhcmRlci4NCj4+Pg0KPj4+IFRoZSBwYXRjaCBpbmNsdWRlcyBzdXBwb3J0IGZvciAxMDBNYnBz
IGZpYmVyIG1vZGUuIElzIHRoZXJlIGFueSB1c2UNCj4+PiBjYXNlIGZvciBzdWNoIGxlZ2FjeSBt
b2Rlcz8NCj4+Pg0KPj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEphdmVuIFh1IDxqYXZlbl94dUBy
ZWFsc2lsLmNvbS5jbj4NCj4+Pj4gLS0tDQo+Pj4+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFs
dGVrL3I4MTY5X21haW4uYyB8IDcxDQo+Pj4+ICsrKysrKysrKysrKysrKysrKysrLS0tDQo+Pj4+
ICAxIGZpbGUgY2hhbmdlZCwgNjIgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4+Pj4N
Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFp
bi5jDQo+Pj4+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMNCj4+
Pj4gaW5kZXggZmIyMjQ3YTIwYzM2Li5hNWMwZDM5OTUzMjggMTAwNjQ0DQo+Pj4+IC0tLSBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+Pj4+ICsrKyBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+Pj4+IEBAIC03MjYsNiArNzI2
LDEyIEBAIGVudW0gcnRsX2Rhc2hfdHlwZSB7DQo+Pj4+ICAgICAgIFJUTF9EQVNIXzI1X0JQLA0K
Pj4+PiAgfTsNCj4+Pj4NCj4+Pj4gK2VudW0gcnRsX3NmcF9tb2RlIHsNCj4+Pj4gKyAgICAgUlRM
X1NGUF9OT05FLA0KPj4+PiArICAgICBSVExfU0ZQXzgxNjhfQUYsDQo+Pj4+ICsgICAgIFJUTF9T
RlBfODEyN19BVEYsDQo+Pj4+ICt9Ow0KPj4+PiArDQo+Pj4+ICBzdHJ1Y3QgcnRsODE2OV9wcml2
YXRlIHsNCj4+Pj4gICAgICAgdm9pZCBfX2lvbWVtICptbWlvX2FkZHI7ICAgICAgICAvKiBtZW1v
cnkgbWFwIHBoeXNpY2FsIGFkZHJlc3MgKi8NCj4+Pj4gICAgICAgc3RydWN0IHBjaV9kZXYgKnBj
aV9kZXY7DQo+Pj4+IEBAIC03MzQsNiArNzQwLDcgQEAgc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSB7
DQo+Pj4+ICAgICAgIHN0cnVjdCBuYXBpX3N0cnVjdCBuYXBpOw0KPj4+PiAgICAgICBlbnVtIG1h
Y192ZXJzaW9uIG1hY192ZXJzaW9uOw0KPj4+PiAgICAgICBlbnVtIHJ0bF9kYXNoX3R5cGUgZGFz
aF90eXBlOw0KPj4+PiArICAgICBlbnVtIHJ0bF9zZnBfbW9kZSBzZnBfbW9kZTsNCj4+Pj4gICAg
ICAgdTMyIGN1cl9yeDsgLyogSW5kZXggaW50byB0aGUgUnggZGVzY3JpcHRvciBidWZmZXIgb2Yg
bmV4dCBSeCBwa3QuICovDQo+Pj4+ICAgICAgIHUzMiBjdXJfdHg7IC8qIEluZGV4IGludG8gdGhl
IFR4IGRlc2NyaXB0b3IgYnVmZmVyIG9mIG5leHQgUnggcGt0LiAqLw0KPj4+PiAgICAgICB1MzIg
ZGlydHlfdHg7DQo+Pj4+IEBAIC03NjAsNyArNzY3LDYgQEAgc3RydWN0IHJ0bDgxNjlfcHJpdmF0
ZSB7DQo+Pj4+ICAgICAgIHVuc2lnbmVkIHN1cHBvcnRzX2dtaWk6MTsNCj4+Pj4gICAgICAgdW5z
aWduZWQgYXNwbV9tYW5hZ2VhYmxlOjE7DQo+Pj4+ICAgICAgIHVuc2lnbmVkIGRhc2hfZW5hYmxl
ZDoxOw0KPj4+PiAtICAgICBib29sIHNmcF9tb2RlOjE7DQo+Pj4+ICAgICAgIGRtYV9hZGRyX3Qg
Y291bnRlcnNfcGh5c19hZGRyOw0KPj4+PiAgICAgICBzdHJ1Y3QgcnRsODE2OV9jb3VudGVycyAq
Y291bnRlcnM7DQo+Pj4+ICAgICAgIHN0cnVjdCBydGw4MTY5X3RjX29mZnNldHMgdGNfb2Zmc2V0
OyBAQCAtMTEyNiw3ICsxMTMyLDcgQEANCj4+Pj4gc3RhdGljIGludCByODE2OF9waHlfb2NwX3Jl
YWQoc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHAsIHUzMiByZWcpDQo+Pj4+ICAgICAgICAgICAg
ICAgcmV0dXJuIDA7DQo+Pj4+DQo+Pj4+ICAgICAgIC8qIFJldHVybiBkdW1teSBNSUlfUEhZU0lE
MiBpbiBTRlAgbW9kZSB0byBtYXRjaCBTRlAgUEhZIGRyaXZlcg0KPiovDQo+Pj4+IC0gICAgIGlm
ICh0cC0+c2ZwX21vZGUgJiYgcmVnID09IChPQ1BfU1REX1BIWV9CQVNFICsgMiAqIE1JSV9QSFlT
SUQyKSkNCj4+Pj4gKyAgICAgaWYgKHRwLT5zZnBfbW9kZSA9PSBSVExfU0ZQXzgxMjdfQVRGICYm
IHJlZyA9PQ0KPj4+IChPQ1BfU1REX1BIWV9CQVNFDQo+Pj4+ICsgKyAyICogTUlJX1BIWVNJRDIp
KQ0KPj4+PiAgICAgICAgICAgICAgIHJldHVybiBQSFlfSURfUlRMX0RVTU1ZX1NGUCAmIDB4ZmZm
ZjsNCj4+Pj4NCj4+Pj4gICAgICAgUlRMX1czMih0cCwgR1BIWV9PQ1AsIHJlZyA8PCAxNSk7IEBA
IC0xMjcwLDYgKzEyNzYsMzQgQEANCj4+Pj4gc3RhdGljIGludCByODE2OGdfbWRpb19yZWFkKHN0
cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRwLCBpbnQgcmVnKQ0KPj4+PiAgICAgICByZXR1cm4gcjgx
NjhfcGh5X29jcF9yZWFkKHRwLCB0cC0+b2NwX2Jhc2UgKyByZWcgKiAyKTsgIH0NCj4+Pj4NCj4+
Pj4gKy8qIFRoZSBxdWlyayByZWZsZWN0cyBSVEw4MTE2YWYgU2VyRGVzIHN0YXR1cy4gKi8gc3Rh
dGljIGludA0KPj4+PiArcjgxMTZhZl9tZGlvX3JlYWRfcXVpcmsoc3RydWN0IHJ0bDgxNjlfcHJp
dmF0ZSAqdHAsIGludCByZWcpIHsNCj4+Pj4gKyAgICAgdTggcGh5U3RhdHVzID0gUlRMX1I4KHRw
LCBQSFlzdGF0dXMpOw0KPj4+PiArDQo+Pj4+ICsgICAgIGlmICghKHBoeVN0YXR1cyAmIExpbmtT
dGF0dXMpKQ0KPj4+PiArICAgICAgICAgICAgIHJldHVybiAwOw0KPj4+PiArDQo+Pj4+ICsgICAg
IC8qIEJNU1IgKi8NCj4+Pj4gKyAgICAgaWYgKHRwLT5vY3BfYmFzZSA9PSBPQ1BfU1REX1BIWV9C
QVNFICYmIHJlZyA9PSBNSUlfQk1TUikNCj4+Pj4gKyAgICAgICAgICAgICByZXR1cm4gQk1TUl9B
TkVHQ09NUExFVEUgfCBCTVNSX0xTVEFUVVM7DQo+Pj4+ICsNCj4+Pj4gKyAgICAgLyogUEhZU1Ig
Ki8NCj4+Pj4gKyAgICAgaWYgKHRwLT5vY3BfYmFzZSA9PSAweGE0MzAgJiYgcmVnID09IDB4MTIp
IHsNCj4+Pj4gKyAgICAgICAgICAgICBpZiAocGh5U3RhdHVzICYgXzEwMDBicHNGKQ0KPj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDB4MDAyODsNCj4+Pj4gKyAgICAgICAgICAgICBl
bHNlIGlmIChwaHlTdGF0dXMgJiBfMTAwYnBzKQ0KPj4+PiArICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIDB4MDAxODsNCj4+Pg0KPj4+IFRoaXMgaXMgYSBjb21wbGV0ZSBoYWNrLiBBbnkgbWVh
bnMgdG8gYWNjZXNzIHRoZSBTZXJEZXMgZGlyZWN0bHk/DQo+Pg0KPj4gSGksIEhlaW5lcg0KPj4g
Tm93IHdlIGZpbmQgYSBpbmRpcmVjdCBhY2Nlc3MgdG8gc2VyZGVzIHJlZy4gVGhlIHNlcmRlcyBy
ZWcgaXMgZGVzaWduZWQNCj5hY2NvcmRpbmcgdG8gSUVFRSA4MDIuMy4NCj4+IEJJVCAyIG1lYW5z
IExpbmsgU3RhdHVzIGFuZCBCSVQgNSBtZWFucyBBTkVHQ09NUExFVEUuIFdlIGNhbiBhY2Nlc3Mg
aXQNCj4+IHRocm91Z2ggcmVhZCBtYWMgb2NwIDB4ZWIxNCwgSSB3b25kZXIgd2hldGhlciB0aGlz
IGluZGlyZWN0IGFjY2VzcyBjYW4gYmUNCj5hY2NlcHRlZD8NCj4+DQo+QmFzZWQgb24gdGhlIGJp
dCBudW1iZXJzIHRoaXMgc2VlbXMgdG8gYmUgdGhlIEJNU1IgcmVnaXN0ZXIuIENhbiBhbGwgY2xh
dXNlDQo+MjIgcmVnaXN0ZXJzIGJlIGFjY2Vzc2VkIGluIGEgc2ltaWxhciB3YXkgc28gdGhhdCBh
IE1JSSBidXMgY2FuIGJlIGltcGxlbWVudGVkDQo+Zm9yIGFjY2Vzc2luZyB0aGUgU2VyRGVzPw0K
DQpXZSBjaGVja2VkIG91ciBjaGlwIGRvY3VtZW50YXRpb24gYW5kIGNvbmZpcm1lZCB0aGF0IHRo
ZSBTZXJEZXMgcmVnaXN0ZXIgZmlsZSBtYXBzDQphbGwgY2xhdXNlIDIyIHJlZ2lzdGVycyhlLmcu
IFdSIDB4ZWIxMDxyZWdfYWRkcj4sIFJEIDB4ZWIxNC4gcmVnX2FkZHIgMHg0MCBpcyBmb3IgQk1D
UiwNCjB4NDEgZm9yIEJNU1IsIDB4NDIgZm9yIFBIWVNJRDEsIDB4NDMgZm9yIFBIWVNJRDIsIGV0
Yy4pDQpBcyB5b3Ugc3VnZ2VzdGVkLCBJIHdvbmRlciB3aGV0aGVyIHRoZSBwcm9wZXIgYXBwcm9h
Y2ggaXMgdG8gaW1wbGVtZW50IGEgdmlydHVhbCBtaWlfYnVzDQphbmQgbWFwIHRoZSBzdGFuZGFy
ZCBzZXJkZXMgcmVnIGluIHRoZSBuZXcgbWFwLg0KDQpUaGFua3MsDQpKYXZlbiBYdQ0KDQo+SW4g
Z2VuZXJhbCBpdCdzIGhhcmQgdG8gcHJvdmlkZSBhIHN0YXRlbWVudCB3L28ga25vd2luZyB0aGUg
aW50ZXJuYWwgbGF5b3V0IG9mDQo+dGhlIElQIGJsb2Nrcy4NCj5DYW4geW91IHByb3ZpZGUgYW55
IGNoaXAgZG9jdW1lbnRhdGlvbiAvIGRhdGFzaGVldD8NCj5Gb3IgcHJvcGVyIHN1cHBvcnQgb2Yg
c3VjaCBhIGNvbXBvbmVudCBjaGFpbiBiZXR3ZWVuIE1BQyBhbmQgU0ZQIHBvcnQNCj50aGUgZHJp
dmVyIHdvdWxkIGhhdmUgdG8gYmUgY29udmVydGVkIHRvIHVzZSBwaHlsaW5rLCB3aGF0IHJlcXVp
cmVzIGFjY2VzcyB0bw0KPnRoZSBpbnZvbHZlZCBjb21wb25lbnRzLCBpbmNsLiB0aGUgU0ZQIEky
QyBidXMuDQo+DQo+DQo+PiBUaGFua3MsDQo+PiBKYXZlbiBYdQ0KPj4NCj4+Pg0KPj4+PiArICAg
ICB9DQo+Pj4+ICsNCj4+Pj4gKyAgICAgcmV0dXJuIDA7DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4g
K3N0YXRpYyBpbnQgcjgxMTZhZl9tZGlvX3JlYWQoc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHAs
IGludCByZWcpIHsNCj4+Pj4gKyAgICAgcmV0dXJuIHI4MTY4Z19tZGlvX3JlYWQodHAsIHJlZykg
fCByODExNmFmX21kaW9fcmVhZF9xdWlyayh0cCwNCj4+Pj4gK3JlZyk7IH0NCj4+Pj4gKw0KPj4+
PiAgc3RhdGljIHZvaWQgbWFjX21jdV93cml0ZShzdHJ1Y3QgcnRsODE2OV9wcml2YXRlICp0cCwg
aW50IHJlZywgaW50DQo+Pj4+IHZhbHVlKSAgew0KPj4+PiAgICAgICBpZiAocmVnID09IDB4MWYp
IHsNCj4+Pj4gQEAgLTEyODAsNiArMTMxNCwxMyBAQCBzdGF0aWMgdm9pZCBtYWNfbWN1X3dyaXRl
KHN0cnVjdA0KPj4+PiBydGw4MTY5X3ByaXZhdGUNCj4+PiAqdHAsIGludCByZWcsIGludCB2YWx1
ZSkNCj4+Pj4gICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgdHAtPm9jcF9iYXNlICsgcmVn
LCB2YWx1ZSk7ICB9DQo+Pj4+DQo+Pj4+ICtzdGF0aWMgYm9vbCBydGxfaXNfODExNmFmKHN0cnVj
dCBydGw4MTY5X3ByaXZhdGUgKnRwKSB7DQo+Pj4+ICsgICAgIHJldHVybiB0cC0+bWFjX3ZlcnNp
b24gPT0gUlRMX0dJR0FfTUFDX1ZFUl81MiAmJg0KPj4+PiArICAgICAgICAgICAgIChyODE2OF9t
YWNfb2NwX3JlYWQodHAsIDB4ZGMwMCkgJiAweDAwNzgpID09IDB4MDAzMCAmJg0KPj4+PiArICAg
ICAgICAgICAgIChyODE2OF9tYWNfb2NwX3JlYWQodHAsIDB4ZDAwNikgJiAweDAwZmYpID09IDB4
MDAwMDsgfQ0KPj4+PiArDQo+Pj4+ICBzdGF0aWMgaW50IG1hY19tY3VfcmVhZChzdHJ1Y3QgcnRs
ODE2OV9wcml2YXRlICp0cCwgaW50IHJlZykgIHsNCj4+Pj4gICAgICAgcmV0dXJuIHI4MTY4X21h
Y19vY3BfcmVhZCh0cCwgdHAtPm9jcF9iYXNlICsgcmVnKTsgQEAgLTEzODYsNw0KPj4+PiArMTQy
NywxMCBAQCBzdGF0aWMgaW50IHJ0bF9yZWFkcGh5KHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRw
LCBpbnQNCj4+Pj4gK2xvY2F0aW9uKQ0KPj4+PiAgICAgICBjYXNlIFJUTF9HSUdBX01BQ19WRVJf
MzE6DQo+Pj4+ICAgICAgICAgICAgICAgcmV0dXJuIHI4MTY4ZHBfMl9tZGlvX3JlYWQodHAsIGxv
Y2F0aW9uKTsNCj4+Pj4gICAgICAgY2FzZSBSVExfR0lHQV9NQUNfVkVSXzQwIC4uLiBSVExfR0lH
QV9NQUNfVkVSX0xBU1Q6DQo+Pj4+IC0gICAgICAgICAgICAgcmV0dXJuIHI4MTY4Z19tZGlvX3Jl
YWQodHAsIGxvY2F0aW9uKTsNCj4+Pj4gKyAgICAgICAgICAgICBpZiAodHAtPnNmcF9tb2RlID09
IFJUTF9TRlBfODE2OF9BRikNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiByODEx
NmFmX21kaW9fcmVhZCh0cCwgbG9jYXRpb24pOw0KPj4+PiArICAgICAgICAgICAgIGVsc2UNCj4+
Pj4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiByODE2OGdfbWRpb19yZWFkKHRwLCBsb2Nh
dGlvbik7DQo+Pj4+ICAgICAgIGRlZmF1bHQ6DQo+Pj4+ICAgICAgICAgICAgICAgcmV0dXJuIHI4
MTY5X21kaW9fcmVhZCh0cCwgbG9jYXRpb24pOw0KPj4+PiAgICAgICB9DQo+Pj4+IEBAIC0xNTc1
LDYgKzE2MTksMjAgQEAgc3RhdGljIGJvb2wgcnRsX2Rhc2hfaXNfZW5hYmxlZChzdHJ1Y3QNCj4+
PiBydGw4MTY5X3ByaXZhdGUgKnRwKQ0KPj4+PiAgICAgICB9DQo+Pj4+ICB9DQo+Pj4+DQo+Pj4+
ICtzdGF0aWMgZW51bSBydGxfc2ZwX21vZGUgcnRsX2dldF9zZnBfbW9kZShzdHJ1Y3QgcnRsODE2
OV9wcml2YXRlDQo+Pj4+ICsqdHApIHsNCj4+Pj4gKyAgICAgaWYgKHJ0bF9pc184MTI1KHRwKSkg
ew0KPj4+PiArICAgICAgICAgICAgIHUxNiBkYXRhID0gcjgxNjhfbWFjX29jcF9yZWFkKHRwLCAw
eGQwMDYpOw0KPj4+PiArDQo+Pj4+ICsgICAgICAgICAgICAgaWYgKChkYXRhICYgMHhmZikgPT0g
MHgwNykNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiBSVExfU0ZQXzgxMjdfQVRG
Ow0KPj4+PiArICAgICB9IGVsc2UgaWYgKHJ0bF9pc184MTE2YWYodHApKSB7DQo+Pj4+ICsgICAg
ICAgICAgICAgcmV0dXJuIFJUTF9TRlBfODE2OF9BRjsNCj4+Pj4gKyAgICAgfQ0KPj4+PiArDQo+
Pj4+ICsgICAgIHJldHVybiBSVExfU0ZQX05PTkU7DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gIHN0
YXRpYyBlbnVtIHJ0bF9kYXNoX3R5cGUgcnRsX2dldF9kYXNoX3R5cGUoc3RydWN0IHJ0bDgxNjlf
cHJpdmF0ZQ0KPj4+PiAqdHApICB7DQo+Pj4+ICAgICAgIHN3aXRjaCAodHAtPm1hY192ZXJzaW9u
KSB7DQo+Pj4+IEBAIC01NjkzLDEyICs1NzUxLDcgQEAgc3RhdGljIGludCBydGxfaW5pdF9vbmUo
c3RydWN0IHBjaV9kZXYgKnBkZXYsDQo+Pj4+IGNvbnN0DQo+Pj4gc3RydWN0IHBjaV9kZXZpY2Vf
aWQgKmVudCkNCj4+Pj4gICAgICAgfQ0KPj4+PiAgICAgICB0cC0+YXNwbV9tYW5hZ2VhYmxlID0g
IXJjOw0KPj4+Pg0KPj4+PiAtICAgICBpZiAocnRsX2lzXzgxMjUodHApKSB7DQo+Pj4+IC0gICAg
ICAgICAgICAgdTE2IGRhdGEgPSByODE2OF9tYWNfb2NwX3JlYWQodHAsIDB4ZDAwNik7DQo+Pj4+
IC0NCj4+Pj4gLSAgICAgICAgICAgICBpZiAoKGRhdGEgJiAweGZmKSA9PSAweDA3KQ0KPj4+PiAt
ICAgICAgICAgICAgICAgICAgICAgdHAtPnNmcF9tb2RlID0gdHJ1ZTsNCj4+Pj4gLSAgICAgfQ0K
Pj4+PiArICAgICB0cC0+c2ZwX21vZGUgPSBydGxfZ2V0X3NmcF9tb2RlKHRwKTsNCj4+Pj4NCj4+
Pj4gICAgICAgdHAtPmRhc2hfdHlwZSA9IHJ0bF9nZXRfZGFzaF90eXBlKHRwKTsNCj4+Pj4gICAg
ICAgdHAtPmRhc2hfZW5hYmxlZCA9IHJ0bF9kYXNoX2lzX2VuYWJsZWQodHApOw0KPj4NCg0K

