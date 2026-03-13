Return-Path: <netdev+bounces-267311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BV1Niy8s2nEaQAAu9opvQ
	(envelope-from <netdev+bounces-267311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:26:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 459B827EC48
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 891F4302CD1C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 07:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B55331205;
	Fri, 13 Mar 2026 07:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="PqOKygWG"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FAD282F04;
	Fri, 13 Mar 2026 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773386793; cv=none; b=KhUA/6Tie85ogKwA0Wny08MGYnNosIfFOjkDVI/Hiyx9gai4Lv9cUBxWFI6y/bk4eA99lL+F7tsuxKpUGcFDpykF338mZvJKR9Jn+azmdSyerYidxn7otwoP3A93tKxzxBFkbw15Rc7lwXW30t5vrrZnF96UrqhF624jnSGZIfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773386793; c=relaxed/simple;
	bh=u2PzLQD6uUVcqn+hbxPBwJ77ANoLcc8u+xuz+HXf5pc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DGTQkRwKb/eQ5/vo3rXy3Pg5r6YMaCJqRudVSVgJGyL1TFtXZzWNrzQdI5U3Ehuv9Z0XWsnocvzEn+ntUQX9/zBcnbUj+LdoRHELu7Van1Qg1sVR4lL1Yvtu2oLCEpG7EpMmE0+qpbE+JOWCMkgsqyv53hQ1VI9BPvtFnhTSKNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=PqOKygWG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62D7PpdS64191020, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1773386751;
	bh=u2PzLQD6uUVcqn+hbxPBwJ77ANoLcc8u+xuz+HXf5pc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=PqOKygWGUVfC2a1+p3Hv6CcOj6VPo9WfP4cNmmn50Ma7VDWeRXI+VJ/6WVOi2hicJ
	 /mLE685TDc5W4nTyb8bVUyfm2QgBH04eivOB2PQ/1LclpiEZPpubv5hVOqbu6j7yoK
	 RS9cgmrma/xWPXt3Br12EaniHeGbXpGIv/Rf0xR6M6EY281fJ/DkM45o32Qt/te8nQ
	 HPkyCDzHNck1xm+5QRQHLuk5qONyUooNDzVImw/a0kXlMLVkau6vISWWFVpbFm8hi2
	 EjWSDOwZhNQINZmtNgQSBUkfriZn4rEan2gKfXgXctPQXpdvEHnIet/OWI5Wa6U7Ed
	 Y2lGgaI2Cpoxg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62D7PpdS64191020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Mar 2026 15:25:51 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 13 Mar 2026 15:25:50 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Fri,
 13 Mar 2026 15:25:50 +0800
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
Thread-Index: AQHcqg5Z7uVmgFYgw0+wv8VnyYk43LWbR6uAgBDWaXA=
Date: Fri, 13 Mar 2026 07:25:50 +0000
Message-ID: <98d632aecbbb4dd8ad79c24e672765b1@realsil.com.cn>
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
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267311-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 459B827EC48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
IElzIHRoZXJlIGFueSB1c2UgY2FzZSBmb3INCj5zdWNoIGxlZ2FjeSBtb2Rlcz8NCj4NCj4NCj4+
IFNpZ25lZC1vZmYtYnk6IEphdmVuIFh1IDxqYXZlbl94dUByZWFsc2lsLmNvbS5jbj4NCj4+IC0t
LQ0KPj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jIHwgNzENCj4+
ICsrKysrKysrKysrKysrKysrKysrLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDYyIGluc2VydGlv
bnMoKyksIDkgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3Jl
YWx0ZWsvcjgxNjlfbWFpbi5jDQo+PiBpbmRleCBmYjIyNDdhMjBjMzYuLmE1YzBkMzk5NTMyOCAx
MDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5j
DQo+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X21haW4uYw0KPj4g
QEAgLTcyNiw2ICs3MjYsMTIgQEAgZW51bSBydGxfZGFzaF90eXBlIHsNCj4+ICAgICAgIFJUTF9E
QVNIXzI1X0JQLA0KPj4gIH07DQo+Pg0KPj4gK2VudW0gcnRsX3NmcF9tb2RlIHsNCj4+ICsgICAg
IFJUTF9TRlBfTk9ORSwNCj4+ICsgICAgIFJUTF9TRlBfODE2OF9BRiwNCj4+ICsgICAgIFJUTF9T
RlBfODEyN19BVEYsDQo+PiArfTsNCj4+ICsNCj4+ICBzdHJ1Y3QgcnRsODE2OV9wcml2YXRlIHsN
Cj4+ICAgICAgIHZvaWQgX19pb21lbSAqbW1pb19hZGRyOyAgICAgICAgLyogbWVtb3J5IG1hcCBw
aHlzaWNhbCBhZGRyZXNzICovDQo+PiAgICAgICBzdHJ1Y3QgcGNpX2RldiAqcGNpX2RldjsNCj4+
IEBAIC03MzQsNiArNzQwLDcgQEAgc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSB7DQo+PiAgICAgICBz
dHJ1Y3QgbmFwaV9zdHJ1Y3QgbmFwaTsNCj4+ICAgICAgIGVudW0gbWFjX3ZlcnNpb24gbWFjX3Zl
cnNpb247DQo+PiAgICAgICBlbnVtIHJ0bF9kYXNoX3R5cGUgZGFzaF90eXBlOw0KPj4gKyAgICAg
ZW51bSBydGxfc2ZwX21vZGUgc2ZwX21vZGU7DQo+PiAgICAgICB1MzIgY3VyX3J4OyAvKiBJbmRl
eCBpbnRvIHRoZSBSeCBkZXNjcmlwdG9yIGJ1ZmZlciBvZiBuZXh0IFJ4IHBrdC4gKi8NCj4+ICAg
ICAgIHUzMiBjdXJfdHg7IC8qIEluZGV4IGludG8gdGhlIFR4IGRlc2NyaXB0b3IgYnVmZmVyIG9m
IG5leHQgUnggcGt0LiAqLw0KPj4gICAgICAgdTMyIGRpcnR5X3R4Ow0KPj4gQEAgLTc2MCw3ICs3
NjcsNiBAQCBzdHJ1Y3QgcnRsODE2OV9wcml2YXRlIHsNCj4+ICAgICAgIHVuc2lnbmVkIHN1cHBv
cnRzX2dtaWk6MTsNCj4+ICAgICAgIHVuc2lnbmVkIGFzcG1fbWFuYWdlYWJsZToxOw0KPj4gICAg
ICAgdW5zaWduZWQgZGFzaF9lbmFibGVkOjE7DQo+PiAtICAgICBib29sIHNmcF9tb2RlOjE7DQo+
PiAgICAgICBkbWFfYWRkcl90IGNvdW50ZXJzX3BoeXNfYWRkcjsNCj4+ICAgICAgIHN0cnVjdCBy
dGw4MTY5X2NvdW50ZXJzICpjb3VudGVyczsNCj4+ICAgICAgIHN0cnVjdCBydGw4MTY5X3RjX29m
ZnNldHMgdGNfb2Zmc2V0OyBAQCAtMTEyNiw3ICsxMTMyLDcgQEANCj4+IHN0YXRpYyBpbnQgcjgx
NjhfcGh5X29jcF9yZWFkKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRwLCB1MzIgcmVnKQ0KPj4g
ICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+DQo+PiAgICAgICAvKiBSZXR1cm4gZHVtbXkgTUlJ
X1BIWVNJRDIgaW4gU0ZQIG1vZGUgdG8gbWF0Y2ggU0ZQIFBIWSBkcml2ZXIgKi8NCj4+IC0gICAg
IGlmICh0cC0+c2ZwX21vZGUgJiYgcmVnID09IChPQ1BfU1REX1BIWV9CQVNFICsgMiAqIE1JSV9Q
SFlTSUQyKSkNCj4+ICsgICAgIGlmICh0cC0+c2ZwX21vZGUgPT0gUlRMX1NGUF84MTI3X0FURiAm
JiByZWcgPT0NCj4oT0NQX1NURF9QSFlfQkFTRQ0KPj4gKyArIDIgKiBNSUlfUEhZU0lEMikpDQo+
PiAgICAgICAgICAgICAgIHJldHVybiBQSFlfSURfUlRMX0RVTU1ZX1NGUCAmIDB4ZmZmZjsNCj4+
DQo+PiAgICAgICBSVExfVzMyKHRwLCBHUEhZX09DUCwgcmVnIDw8IDE1KTsgQEAgLTEyNzAsNiAr
MTI3NiwzNCBAQCBzdGF0aWMNCj4+IGludCByODE2OGdfbWRpb19yZWFkKHN0cnVjdCBydGw4MTY5
X3ByaXZhdGUgKnRwLCBpbnQgcmVnKQ0KPj4gICAgICAgcmV0dXJuIHI4MTY4X3BoeV9vY3BfcmVh
ZCh0cCwgdHAtPm9jcF9iYXNlICsgcmVnICogMik7ICB9DQo+Pg0KPj4gKy8qIFRoZSBxdWlyayBy
ZWZsZWN0cyBSVEw4MTE2YWYgU2VyRGVzIHN0YXR1cy4gKi8gc3RhdGljIGludA0KPj4gK3I4MTE2
YWZfbWRpb19yZWFkX3F1aXJrKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRwLCBpbnQgcmVnKSB7
DQo+PiArICAgICB1OCBwaHlTdGF0dXMgPSBSVExfUjgodHAsIFBIWXN0YXR1cyk7DQo+PiArDQo+
PiArICAgICBpZiAoIShwaHlTdGF0dXMgJiBMaW5rU3RhdHVzKSkNCj4+ICsgICAgICAgICAgICAg
cmV0dXJuIDA7DQo+PiArDQo+PiArICAgICAvKiBCTVNSICovDQo+PiArICAgICBpZiAodHAtPm9j
cF9iYXNlID09IE9DUF9TVERfUEhZX0JBU0UgJiYgcmVnID09IE1JSV9CTVNSKQ0KPj4gKyAgICAg
ICAgICAgICByZXR1cm4gQk1TUl9BTkVHQ09NUExFVEUgfCBCTVNSX0xTVEFUVVM7DQo+PiArDQo+
PiArICAgICAvKiBQSFlTUiAqLw0KPj4gKyAgICAgaWYgKHRwLT5vY3BfYmFzZSA9PSAweGE0MzAg
JiYgcmVnID09IDB4MTIpIHsNCj4+ICsgICAgICAgICAgICAgaWYgKHBoeVN0YXR1cyAmIF8xMDAw
YnBzRikNCj4+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gMHgwMDI4Ow0KPj4gKyAgICAg
ICAgICAgICBlbHNlIGlmIChwaHlTdGF0dXMgJiBfMTAwYnBzKQ0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiAweDAwMTg7DQo+DQo+VGhpcyBpcyBhIGNvbXBsZXRlIGhhY2suIEFueSBt
ZWFucyB0byBhY2Nlc3MgdGhlIFNlckRlcyBkaXJlY3RseT8NCg0KSGksIEhlaW5lcg0KTm93IHdl
IGZpbmQgYSBpbmRpcmVjdCBhY2Nlc3MgdG8gc2VyZGVzIHJlZy4gVGhlIHNlcmRlcyByZWcgaXMg
ZGVzaWduZWQgYWNjb3JkaW5nIHRvIElFRUUgODAyLjMuDQpCSVQgMiBtZWFucyBMaW5rIFN0YXR1
cyBhbmQgQklUIDUgbWVhbnMgQU5FR0NPTVBMRVRFLiBXZSBjYW4gYWNjZXNzIGl0IHRocm91Z2gg
cmVhZCBtYWMgb2NwDQoweGViMTQsIEkgd29uZGVyIHdoZXRoZXIgdGhpcyBpbmRpcmVjdCBhY2Nl
c3MgY2FuIGJlIGFjY2VwdGVkPw0KDQpUaGFua3MsDQpKYXZlbiBYdQ0KDQo+DQo+PiArICAgICB9
DQo+PiArDQo+PiArICAgICByZXR1cm4gMDsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGludCBy
ODExNmFmX21kaW9fcmVhZChzdHJ1Y3QgcnRsODE2OV9wcml2YXRlICp0cCwgaW50IHJlZykgew0K
Pj4gKyAgICAgcmV0dXJuIHI4MTY4Z19tZGlvX3JlYWQodHAsIHJlZykgfCByODExNmFmX21kaW9f
cmVhZF9xdWlyayh0cCwNCj4+ICtyZWcpOyB9DQo+PiArDQo+PiAgc3RhdGljIHZvaWQgbWFjX21j
dV93cml0ZShzdHJ1Y3QgcnRsODE2OV9wcml2YXRlICp0cCwgaW50IHJlZywgaW50DQo+PiB2YWx1
ZSkgIHsNCj4+ICAgICAgIGlmIChyZWcgPT0gMHgxZikgew0KPj4gQEAgLTEyODAsNiArMTMxNCwx
MyBAQCBzdGF0aWMgdm9pZCBtYWNfbWN1X3dyaXRlKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUNCj4q
dHAsIGludCByZWcsIGludCB2YWx1ZSkNCj4+ICAgICAgIHI4MTY4X21hY19vY3Bfd3JpdGUodHAs
IHRwLT5vY3BfYmFzZSArIHJlZywgdmFsdWUpOyAgfQ0KPj4NCj4+ICtzdGF0aWMgYm9vbCBydGxf
aXNfODExNmFmKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRwKSB7DQo+PiArICAgICByZXR1cm4g
dHAtPm1hY192ZXJzaW9uID09IFJUTF9HSUdBX01BQ19WRVJfNTIgJiYNCj4+ICsgICAgICAgICAg
ICAgKHI4MTY4X21hY19vY3BfcmVhZCh0cCwgMHhkYzAwKSAmIDB4MDA3OCkgPT0gMHgwMDMwICYm
DQo+PiArICAgICAgICAgICAgIChyODE2OF9tYWNfb2NwX3JlYWQodHAsIDB4ZDAwNikgJiAweDAw
ZmYpID09IDB4MDAwMDsgfQ0KPj4gKw0KPj4gIHN0YXRpYyBpbnQgbWFjX21jdV9yZWFkKHN0cnVj
dCBydGw4MTY5X3ByaXZhdGUgKnRwLCBpbnQgcmVnKSAgew0KPj4gICAgICAgcmV0dXJuIHI4MTY4
X21hY19vY3BfcmVhZCh0cCwgdHAtPm9jcF9iYXNlICsgcmVnKTsgQEAgLTEzODYsNw0KPj4gKzE0
MjcsMTAgQEAgc3RhdGljIGludCBydGxfcmVhZHBoeShzdHJ1Y3QgcnRsODE2OV9wcml2YXRlICp0
cCwgaW50IGxvY2F0aW9uKQ0KPj4gICAgICAgY2FzZSBSVExfR0lHQV9NQUNfVkVSXzMxOg0KPj4g
ICAgICAgICAgICAgICByZXR1cm4gcjgxNjhkcF8yX21kaW9fcmVhZCh0cCwgbG9jYXRpb24pOw0K
Pj4gICAgICAgY2FzZSBSVExfR0lHQV9NQUNfVkVSXzQwIC4uLiBSVExfR0lHQV9NQUNfVkVSX0xB
U1Q6DQo+PiAtICAgICAgICAgICAgIHJldHVybiByODE2OGdfbWRpb19yZWFkKHRwLCBsb2NhdGlv
bik7DQo+PiArICAgICAgICAgICAgIGlmICh0cC0+c2ZwX21vZGUgPT0gUlRMX1NGUF84MTY4X0FG
KQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiByODExNmFmX21kaW9fcmVhZCh0cCwg
bG9jYXRpb24pOw0KPj4gKyAgICAgICAgICAgICBlbHNlDQo+PiArICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIHI4MTY4Z19tZGlvX3JlYWQodHAsIGxvY2F0aW9uKTsNCj4+ICAgICAgIGRlZmF1
bHQ6DQo+PiAgICAgICAgICAgICAgIHJldHVybiByODE2OV9tZGlvX3JlYWQodHAsIGxvY2F0aW9u
KTsNCj4+ICAgICAgIH0NCj4+IEBAIC0xNTc1LDYgKzE2MTksMjAgQEAgc3RhdGljIGJvb2wgcnRs
X2Rhc2hfaXNfZW5hYmxlZChzdHJ1Y3QNCj5ydGw4MTY5X3ByaXZhdGUgKnRwKQ0KPj4gICAgICAg
fQ0KPj4gIH0NCj4+DQo+PiArc3RhdGljIGVudW0gcnRsX3NmcF9tb2RlIHJ0bF9nZXRfc2ZwX21v
ZGUoc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHApDQo+PiArew0KPj4gKyAgICAgaWYgKHJ0bF9p
c184MTI1KHRwKSkgew0KPj4gKyAgICAgICAgICAgICB1MTYgZGF0YSA9IHI4MTY4X21hY19vY3Bf
cmVhZCh0cCwgMHhkMDA2KTsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgaWYgKChkYXRhICYgMHhm
ZikgPT0gMHgwNykNCj4+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gUlRMX1NGUF84MTI3
X0FURjsNCj4+ICsgICAgIH0gZWxzZSBpZiAocnRsX2lzXzgxMTZhZih0cCkpIHsNCj4+ICsgICAg
ICAgICAgICAgcmV0dXJuIFJUTF9TRlBfODE2OF9BRjsNCj4+ICsgICAgIH0NCj4+ICsNCj4+ICsg
ICAgIHJldHVybiBSVExfU0ZQX05PTkU7DQo+PiArfQ0KPj4gKw0KPj4gIHN0YXRpYyBlbnVtIHJ0
bF9kYXNoX3R5cGUgcnRsX2dldF9kYXNoX3R5cGUoc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZQ0KPj4g
KnRwKSAgew0KPj4gICAgICAgc3dpdGNoICh0cC0+bWFjX3ZlcnNpb24pIHsNCj4+IEBAIC01Njkz
LDEyICs1NzUxLDcgQEAgc3RhdGljIGludCBydGxfaW5pdF9vbmUoc3RydWN0IHBjaV9kZXYgKnBk
ZXYsIGNvbnN0DQo+c3RydWN0IHBjaV9kZXZpY2VfaWQgKmVudCkNCj4+ICAgICAgIH0NCj4+ICAg
ICAgIHRwLT5hc3BtX21hbmFnZWFibGUgPSAhcmM7DQo+Pg0KPj4gLSAgICAgaWYgKHJ0bF9pc184
MTI1KHRwKSkgew0KPj4gLSAgICAgICAgICAgICB1MTYgZGF0YSA9IHI4MTY4X21hY19vY3BfcmVh
ZCh0cCwgMHhkMDA2KTsNCj4+IC0NCj4+IC0gICAgICAgICAgICAgaWYgKChkYXRhICYgMHhmZikg
PT0gMHgwNykNCj4+IC0gICAgICAgICAgICAgICAgICAgICB0cC0+c2ZwX21vZGUgPSB0cnVlOw0K
Pj4gLSAgICAgfQ0KPj4gKyAgICAgdHAtPnNmcF9tb2RlID0gcnRsX2dldF9zZnBfbW9kZSh0cCk7
DQo+Pg0KPj4gICAgICAgdHAtPmRhc2hfdHlwZSA9IHJ0bF9nZXRfZGFzaF90eXBlKHRwKTsNCj4+
ICAgICAgIHRwLT5kYXNoX2VuYWJsZWQgPSBydGxfZGFzaF9pc19lbmFibGVkKHRwKTsNCg0K

