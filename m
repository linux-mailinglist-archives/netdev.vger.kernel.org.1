Return-Path: <netdev+bounces-264302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E/7M4RjqWmB6gAAu9opvQ
	(envelope-from <netdev+bounces-264302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:05:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E6E210489
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24499304AD30
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 10:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463BE3803FD;
	Thu,  5 Mar 2026 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="gl3gWXKy"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFEE33C192;
	Thu,  5 Mar 2026 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708385; cv=none; b=G7H0bdzT4kZLF3pBAAgDveFR+azNZOob/PNrqejgxnIK1veg+C5RLnIK8s7g8X0MfDnF4LuFsFMGVEpmQLXqSb4g7t7E8htZpebzvDn8Yfx+nrjjepvt0/MC5e459q5ceTYDcL8rpb+aRvLeqyGgCXRMVLzEiGh8BFiaQTM1hNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708385; c=relaxed/simple;
	bh=KiyvVqcdvEtviEaNeNJBpZ0EKAyYXnxdOWkBy8kRoU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DR/eLZCUDsay7kKrMyfVWpOvqo/srHd50Dzcv4AuDhSFfCrndfDEBgNLVT1XqJhBNsPFQnCWdTDGvJa3qtimm28OWw8TuDtfwd4sFHhMqRveJ6Wb27P6+gPPoNzB1v5L0JmkYoWXFh1RYqkboMfzPSuFpbe1w+2NNRQcG/U2Ynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=gl3gWXKy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 625AwrSS31169392, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1772708334;
	bh=KiyvVqcdvEtviEaNeNJBpZ0EKAyYXnxdOWkBy8kRoU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=gl3gWXKy0qGlB+JiDH96neVdAKeHhjdyXooHiXhnR0/KZJFZ0jnu9l6u4HerP8kKu
	 9Au2W/hUdoElclAoZgZF8ofQvLqNQSEf7XLuv2UNka20bKr/M1TDFnp6EwUQO+jTLY
	 UQvXC5t5vVdvTQqTdXZsyfRQLkHua3hQe7MhV5bQOuPSpoit50VQb1Y/9g2qgYLOB6
	 0d0+YcJEcB/DPlT5hGBnMcIH2ireFdGAeFzramM7V31n9yzuli1o/hg329R2hRiovB
	 DIM0VyTJDjqaox9P4qtIAQaqaifrtNVnwYuKyRxC5B5MLEbEIPv1fO54Uj9/ILkLtG
	 JLxuqZjDSSjYQ==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 625AwrSS31169392
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Mar 2026 18:58:54 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 5 Mar 2026 18:58:53 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.1748.039; Thu,
 5 Mar 2026 18:58:53 +0800
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
Subject: RE: [PATCH net-next v1 4/4] r8169: enable system enter c10 with
 RTL8116af
Thread-Topic: [PATCH net-next v1 4/4] r8169: enable system enter c10 with
 RTL8116af
Thread-Index: AQHcqg5agfaJnCS8+0OnqQrVxYsUrbWbQ6kAgALQoYCAAFOVgIABYarQ
Date: Thu, 5 Mar 2026 10:58:52 +0000
Message-ID: <5b10525d9f524452897a32b5c0a93a12@realsil.com.cn>
References: <20260302063215.1790-1-javen_xu@realsil.com.cn>
 <20260302063215.1790-5-javen_xu@realsil.com.cn>
 <9b6aeead-4e60-4df4-8aaf-b07ab2c99d46@gmail.com>
 <f1912e8588604b9b86646a86eac05c6c@realsil.com.cn>
 <33d351be-8a91-4940-950a-7f0866d0cae9@gmail.com>
In-Reply-To: <33d351be-8a91-4940-950a-7f0866d0cae9@gmail.com>
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
X-Rspamd-Queue-Id: 46E6E210489
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264302-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,realsil.com.cn:dkim,realsil.com.cn:email,realsil.com.cn:mid]
X-Rspamd-Action: no action

Pk9uIDA0LjAzLjIwMjYgMTA6NDMsIOiuuOS/iuS8nyB3cm90ZToNCj4+PiBPbiAwMi4wMy4yMDI2
IDA3OjMyLCBqYXZlbiB3cm90ZToNCj4+Pj4gRnJvbTogSmF2ZW4gWHUgPGphdmVuX3h1QHJlYWxz
aWwuY29tLmNuPg0KPj4+Pg0KPj4+PiBSVEw4MTE2YWYgaXMgYSBtdWx0aSBmdW5jdGlvbiBjaGlw
LiBGdW5jdGlvbiAxIGlzIGxvYWQgd2l0aCByODE2OQ0KPj4+PiBkcml2ZXIuIEZ1bmN0aW9uIDAg
aXMgYm1jIHZpcnVhbCBkcml2ZXIgd2hpY2ggaXMgdXNlZCBmb3IgcG93ZXINCj4+Pj4gbWFuYWdl
bWVudC4gVGhpcyBwYXRjaCBzZXQgRnVuY3Rpb24gMiB0byA3IGludG8gZDMgc3RhdGUgd2hlbiBj
b25maWcNCj4+Pj4gaHdfY29uZmlnLiBUaGlzIGhlbHBzIHRoZSB3aG9sZSBzeXN0ZW0gZW50ZXIg
YzEwLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBKYXZlbiBYdSA8amF2ZW5feHVAcmVhbHNp
bC5jb20uY24+DQo+Pj4+IC0tLQ0KPj4+PiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9y
ODE2OV9tYWluLmMgfCA5NQ0KPj4+PiArKysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiAgMSBm
aWxlIGNoYW5nZWQsIDk1IGluc2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+Pj4+IGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMNCj4+Pj4gaW5kZXggNzg3ODU5YjBhYjY4
Li5kOGZmYzc2MTg2YjIgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3Jl
YWx0ZWsvcjgxNjlfbWFpbi5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0
ZWsvcjgxNjlfbWFpbi5jDQo+Pj4+IEBAIC0xMTIxLDYgKzExMjEsMTAwIEBAIERFQ0xBUkVfUlRM
X0NPTkQocnRsX29jcF9ncGh5X2NvbmQpDQo+Pj4+ICAgICAgIHJldHVybiBSVExfUjMyKHRwLCBH
UEhZX09DUCkgJiBPQ1BBUl9GTEFHOyAgfQ0KPj4+Pg0KPj4+PiArc3RhdGljIHUzMiBydGxfb3Ro
ZXJfY3NpX3JlYWQoc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHAsIHU4DQo+Pj4+ICttdWx0aV9m
dW5fc2VsX2JpdCwgaW50IGFkZHIpIHsNCj4+Pj4gKyAgICAgUlRMX1czMih0cCwgQ1NJQVIsIChh
ZGRyICYgQ1NJQVJfQUREUl9NQVNLKSB8DQo+Pj4+ICttdWx0aV9mdW5fc2VsX2JpdA0KPj4+IDw8
IDE2IHwNCj4+Pj4gKyAgICAgICAgICAgICBDU0lBUl9CWVRFX0VOQUJMRSk7DQo+Pj4+ICsNCj4+
Pj4gKyAgICAgcmV0dXJuIHJ0bF9sb29wX3dhaXRfaGlnaCh0cCwgJnJ0bF9jc2lhcl9jb25kLCAx
MCwgMTAwKSA/DQo+Pj4+ICsgICAgICAgICAgICAgUlRMX1IzMih0cCwgQ1NJRFIpIDogfjA7IH0N
Cj4+Pj4gKw0KPj4+PiArc3RhdGljIHZvaWQgcnRsX290aGVyX2NzaV93cml0ZShzdHJ1Y3QgcnRs
ODE2OV9wcml2YXRlICp0cCwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTgg
bXVsdGlfZnVuX3NlbF9iaXQsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlu
dCBhZGRyLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgdmFsdWUpIHsN
Cj4+Pj4gKyAgICAgUlRMX1czMih0cCwgQ1NJRFIsIHZhbHVlKTsNCj4+Pj4gKyAgICAgUlRMX1cz
Mih0cCwgQ1NJQVIsIENTSUFSX1dSSVRFX0NNRCB8IChhZGRyICYNCj5DU0lBUl9BRERSX01BU0sp
DQo+Pj4gfA0KPj4+PiArICAgICAgICAgICAgIENTSUFSX0JZVEVfRU5BQkxFIHwgbXVsdGlfZnVu
X3NlbF9iaXQgPDwgMTYpOw0KPj4+PiArDQo+Pj4+ICsgICAgIHJ0bF9sb29wX3dhaXRfbG93KHRw
LCAmcnRsX2NzaWFyX2NvbmQsIDEwLCAxMDApOyB9DQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyB2b2lk
IHJ0bDgxNjhfY2xlYXJfYW5kX3NldF9vdGhlcl9mdW5fcGNpX2JpdChzdHJ1Y3QNCj4+Pj4gK3J0
bDgxNjlfcHJpdmF0ZQ0KPj4+ICp0cCwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1OCBtdWx0aV9mdW5fc2VsX2JpdCwNCj4+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgYWRkciwNCj4+
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1MzIg
Y2xlYXJtYXNrLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHUzMiBzZXRtYXNrKSB7DQo+Pj4+ICsgICAgIHUzMiB2YWw7DQo+Pj4+ICsNCj4+
Pj4gKyAgICAgdmFsID0gcnRsX290aGVyX2NzaV9yZWFkKHRwLCBtdWx0aV9mdW5fc2VsX2JpdCwg
YWRkcik7DQo+Pj4+ICsgICAgIHZhbCAmPSB+Y2xlYXJtYXNrOw0KPj4+PiArICAgICB2YWwgfD0g
c2V0bWFzazsNCj4+Pj4gKyAgICAgcnRsX290aGVyX2NzaV93cml0ZSh0cCwgbXVsdGlfZnVuX3Nl
bF9iaXQsIGFkZHIsIHZhbCk7IH0NCj4+Pj4gKw0KPj4+PiArc3RhdGljIHZvaWQgcnRsODE2OF9v
dGhlcl9mdW5fZGV2X3BjaV9zZXR0aW5nKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRwLA0KPj4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHUzMiBhZGRyLA0K
Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHUzMiBjbGVh
cm1hc2ssDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dTMyIHNldG1hc2ssDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdTggbXVsdGlfZnVuX3NlbF9iaXQpIHsNCj4+Pj4gKyAgICAgdTMyIHZhbDsNCj4+Pj4g
KyAgICAgdTggaTsNCj4+Pj4gKyAgICAgdTggRnVuQml0Ow0KPj4+PiArICAgICAvKiAwOiBCTUMs
IDE6IE5JQywgMjogVENSLCAzOiBWR0EvUENJRV9UT19VU0IsIDQ6IEVIQ0ksIDU6DQo+Pj4+ICtX
SUZJLCA2OiBXSUZJLA0KPj4+IDc6IEtDUyAqLw0KPj4+PiArICAgICBmb3IgKGkgPSAwOyBpIDwg
ODsgaSsrKSB7DQo+Pj4+ICsgICAgICAgICAgICAgRnVuQml0ID0gKDEgPDwgaSk7DQo+Pj4+ICsg
ICAgICAgICAgICAgaWYgKEZ1bkJpdCAmIG11bHRpX2Z1bl9zZWxfYml0KSB7DQo+Pj4+ICsgICAg
ICAgICAgICAgICAgICAgICB1OCBzZXRfb3RoZXJfZnVuID0gdHJ1ZTsNCj4+Pj4gKw0KPj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgaWYgKGkgPT0gMCkgew0KPj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzZXRfb3RoZXJfZnVuID0gdHJ1ZTsNCj4+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgIH0gZWxzZSBpZiAoaSA9PSA1IHx8IGkgPT0gNikgew0KPj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpZiAodHAtPmRhc2hfZW5hYmxlZCkgew0KPj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZhbCA9IHJ0bF9lcmlfcmVhZCh0cCwgMHgxODQp
Ow0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh2YWwgJiBC
SVQoMjYpKQ0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc2V0X290aGVyX2Z1biA9IGZhbHNlOw0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGVsc2UNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHNldF9vdGhlcl9mdW4gPSB0cnVlOw0KPj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB9DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugew0KPj4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2YWwgPSBydGxfb3RoZXJfY3NpX3JlYWQo
dHAsIGksIDB4MDApOw0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAodmFs
ID09IDB4ZmZmZmZmZmYpDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc2V0X290aGVyX2Z1biA9IHRydWU7DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGVsc2UNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZXRf
b3RoZXJfZnVuID0gZmFsc2U7DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICB9DQo+Pj4+ICsg
ICAgICAgICAgICAgICAgICAgICBpZiAoc2V0X290aGVyX2Z1bikNCj4+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcnRsODE2OF9jbGVhcl9hbmRfc2V0X290aGVyX2Z1bl9wY2lfYml0
KHRwLCBpLCBhZGRyLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2xlYXJtYXNrLCBzZXRtYXNrKTsNCj4+
Pj4gKyAgICAgICAgICAgICB9DQo+Pj4+ICsgICAgIH0NCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiAr
c3RhdGljIHZvaWQgcnRsODE2OF9zZXRfZGFzaF9vdGhlcl9mdW5fZGV2X3N0YXRlX2NoYW5nZShz
dHJ1Y3QNCj4+PiBydGw4MTY5X3ByaXZhdGUgKnRwLA0KPj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1OCBkZXZfc3RhdGUsDQo+Pj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHU4DQo+
Pj4+ICttdWx0aV9mdW5fc2VsX2JpdCkgew0KPj4+PiArICAgICB1MzIgY2xlYXJtYXNrOw0KPj4+
PiArICAgICB1MzIgc2V0bWFzazsNCj4+Pj4gKw0KPj4+PiArICAgICBpZiAoZGV2X3N0YXRlID09
IDApIHsNCj4+Pj4gKyAgICAgICAgICAgICBjbGVhcm1hc2sgPSAoQklUKDApIHwgQklUKDEpKTsN
Cj4+Pj4gKyAgICAgICAgICAgICBzZXRtYXNrID0gMDsNCj4+Pj4gKyAgICAgICAgICAgICBydGw4
MTY4X290aGVyX2Z1bl9kZXZfcGNpX3NldHRpbmcodHAsIDB4NDQsIGNsZWFybWFzaywNCj4+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2V0bWFzaywg
bXVsdGlfZnVuX3NlbF9iaXQpOw0KPj4+PiArICAgICB9IGVsc2Ugew0KPj4+PiArICAgICAgICAg
ICAgIGNsZWFybWFzayA9IDA7DQo+Pj4+ICsgICAgICAgICAgICAgc2V0bWFzayA9IChCSVQoMCkg
fCBCSVQoMSkpOw0KPj4+PiArICAgICAgICAgICAgIHJ0bDgxNjhfb3RoZXJfZnVuX2Rldl9wY2lf
c2V0dGluZyh0cCwgMHg0NCwgY2xlYXJtYXNrLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzZXRtYXNrLCBtdWx0aV9mdW5fc2VsX2JpdCk7DQo+
Pj4+ICsgICAgIH0NCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiAgc3RhdGljIHZvaWQgcjgxNjhfcGh5
X29jcF93cml0ZShzdHJ1Y3QgcnRsODE2OV9wcml2YXRlICp0cCwgdTMyDQo+Pj4+IHJlZywNCj4+
Pj4gdTMyIGRhdGEpICB7DQo+Pj4+ICAgICAgIGlmIChydGxfb2NwX3JlZ19mYWlsdXJlKHJlZykp
DQo+Pj4+IEBAIC0zNzg1LDYgKzM4NzksNyBAQCBzdGF0aWMgdm9pZCBydGxfaHdfc3RhcnRfODEx
NyhzdHJ1Y3QNCj4+PiBydGw4MTY5X3ByaXZhdGUgKnRwKQ0KPj4+PiAgICAgICByODE2OF9tYWNf
b2NwX3dyaXRlKHRwLCAweGMwOTQsIDB4MDAwMCk7DQo+Pj4+ICAgICAgIHI4MTY4X21hY19vY3Bf
d3JpdGUodHAsIDB4YzA5ZSwgMHgwMDAwKTsNCj4+Pj4NCj4+Pj4gKyAgICAgcnRsODE2OF9zZXRf
ZGFzaF9vdGhlcl9mdW5fZGV2X3N0YXRlX2NoYW5nZSh0cCwgMywgMHhmYyk7DQo+Pj4+ICAgICAg
IC8qIGZpcm13YXJlIGlzIGZvciBNQUMgb25seSAqLw0KPj4+PiAgICAgICByODE2OV9hcHBseV9m
aXJtd2FyZSh0cCk7DQo+Pj4+ICB9DQo+Pj4NCj4+PiBUaGlzIGlzIHRoZSB0eXBlIG9mIGNvZGUg
dGhhdCB3b3VsZCBtYWtlIHI4MTY5IGJlY29tZSBhbg0KPj4+IHVubWFpbnRhaW5hYmxlIG1lc3Mg
bGlrZSB0aGUgdmVuZG9yIGRyaXZlcnMuIFdoeSBub3QgdXNlIHN0YW5kYXJkDQo+Pj4gbWVhbnMg
bGlrZQ0KPj4+IHBjaV9idXNfcmVhZF9jb25maWdfd29yZCgpIGV0IGFsPw0KPj4NCj4+IFRoYW5r
cyBmb3IgdGhlIHN1Z2dlc3Rpb24uDQo+PiBJIGZpcnN0IHRyaWVkIHRvIHVzZSBsc3BjaSwgYnV0
IEkgY2FuJ3QgZmluZCBmdW5jdGlvbiAyLTcgaW4gcGNpDQo+PiBzeXN0ZW0uIFRoZW4gSSB0cmll
ZCB0byB1c2UgcGNpX2J1c19yZWFkX2NvbmZpZ193b3JkKCkgdG8gYWNjZXNzIEZ1bmN0aW9uDQo+
Mi03IGFuZCBnZXQgcmVzdWx0IGFzIGJlbG93Lg0KPj4NCj4+IFsyMTI1NC45ODQ5ODNdIFJUTDgx
NjhfREVCVUc6IFNsb3QgMCwgRnVuY3Rpb24gMiwgUmVhZCBWZW5kb3IgSUQ6DQo+PiAweGZmZmZm
ZmZmDQo+Pg0KPj4gVGhpcyBjb25maXJtcyB0aGF0IHRoZXNlIGZ1bmNpdG9ucyBhcmUgcGh5c2lj
YWxseSBoaWRkZW4gZnJvbSB0aGUgUENJDQo+PiBidXMuIFRoZXkgZG8gbm90IHJlc3BvbmQgdG8g
c3RhbmRhcmQgUENJIGNvbmZpZ3VyYXRpb24gY3ljbGVzLCB0aGlzDQo+PiBtYXliZSB0aGUgcmVh
c29uIHdoeSBzdGFuZGFyZCBQQ0kgQVBJcyBjYW5ub3QgYmUgdXNlZCBoZXJlLg0KPj4gVGhlc2Ug
ZnVuY3Rpb25zIGFyZSBpbXBvcnRhbnQgZm9yIHBvd2VyIHN0YXRlIGlzc3VlLiBXaGVuIHN5c3Rl
bQ0KPj4gc3VzcGVuZHMsIGxpbnV4IFBDSSBjb3JlIGF1dG9tYXRpY2FsbHkgaGFuZGxlcyB0aGUg
cG93ZXIgdHJhbnNpdGlvbg0KPj4gZm9yIHRoZSB2aXNpYmxlIGZ1bmN0aW9ucy4gQnV0IHNpbmNl
IGZ1bmN0aW9uIDItNyBpcyBpbnZpc2libGUsIHRoZQ0KPj4ga2VybmVsIGNhbm5vdCBtYW5hZ2Ug
aXQuIEFzIGEgcmVzdWx0LCB3ZSBoYXZlIG5vIGNob2ljZSBidXQgdG8gdXNlIHRoZQ0KPnZlbmRv
ci1zcGVjaWZpYyBpbmRpcmVjdCBhY2Nlc3MgbWVjaGFuaXNtKHZpYSBDU0lBUiByZWdpc3Rlciku
DQo+Pg0KPkkgdW5kZXJzdGFuZCB5b3VyIHBhaW4gYWRkaW5nIG1haW5saW5lIHN1cHBvcnQgZm9y
IGJyb2tlbiBodyBkZXNpZ25zLiBJDQo+Y29uc2lkZXIgdGhlIGNoaXAgZGVzaWduIGZ1bmRhbWVu
dGFsbHkgYnJva2VuIGFzIFBDSSBmdW5jdGlvbnMgMi03IGFyZSBoaWRkZW4NCj5hbmQgdGhlIGV0
aGVybmV0IGRyaXZlciBpcyBleHBlY3RlZCB0byBzZXQgcG93ZXIgbWFuYWdlbWVudCBzdGF0ZXMg
Zm9yIGUuZy4NCj50aGUgRUhDSSBhbmQgV2lGaSBmdW5jdGlvbnMuDQo+QXMgc3RhdGVkIGluIGFu
b3RoZXIgY29tbWVudCwgdGhlIGJlc3Qgb3B0aW9uIHNlZW1zIHRvIG1lIHRvIGFkZCBzdXBwb3J0
DQo+Zm9yIHRoaXMgY2hpcCBkb3duc3RyZWFtIG9ubHkuDQoNClRoYW5rcyBmb3IgeW91ciBzdWdn
ZXN0aW9uLCBJIHdpbGwgdGFrZSBpdCBpbnRvIGNvbnNpZGVyYXRpb24uDQoNClRoYW5rcywNCkph
dmVuIFh1DQoNCg==

