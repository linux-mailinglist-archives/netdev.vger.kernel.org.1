Return-Path: <netdev+bounces-282633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMt2IKTL8mmWuQEAu9opvQ
	(envelope-from <netdev+bounces-282633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 05:25:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF2749CC8D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 05:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7564E3008986
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5728E30100E;
	Thu, 30 Apr 2026 03:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="ZCdgAjad"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6974A24DCF9;
	Thu, 30 Apr 2026 03:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519519; cv=none; b=rXS8c+wbShGjquwT540GyNLGswjtRZLTYqczZWcI7/ePOqZbkTilojarQyN9f021JkaHpVmq0IoExGAr5P4dbfWEyPaMx8lpdsCwgKSe3uPe3vSfDHyTElbTW7gdHec424EW7ZesfWb46CMaoT1csvRTfUnswHvjt/7mO2m4jOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519519; c=relaxed/simple;
	bh=PJZr7C5C4OXpj5cCSZue1OW4x8LRZPplAwpMsPljLmw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NEcui7rEgCL4r41nQUg4maiD1ysVaa6Htc9fpO5AhPK6ms13zfuNe/07TKmU0onsbNQNItV1MVXRRt6QlkM+TFl+oKJj3bndI/LIEjtHfZs3BHJwzQdHBWYhU8sqeisQcLxgo3Kn9WmRHsWgQ2KneFccl5eI0CkBq03TwZcKqeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=ZCdgAjad; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63U3O91501669170, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1777519450;
	bh=PJZr7C5C4OXpj5cCSZue1OW4x8LRZPplAwpMsPljLmw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ZCdgAjad2ewd9CJcBrz3Axpw4sNeyqPZO1fBhpBqaAeeJ2VZ8ZSsyvGfhfLFH9Qcl
	 9krmVi2+Rw1P2rayVUWMRk7dVk24B4VHYJByP4PLqRXR+7utUbTsmP9TKdOqWIvdJ0
	 mVSFgWqDWJIWI/VZlFH68i9zlSKYL2c/BTrmm/U4BIjiQm2lBa378MmPBwPlaNpZmd
	 8lEQFalj6sAycs4J6KZM8FjjIqUYgxLV2O/7y/BMbqMtxVMqeiyKjTD6r3/i04Ll7H
	 awRbK6ODwAva4a6SAsb6OKJX1huPpvIjdMyaw72l+kEczxSbvHNd7AbXQe+R3ARh+O
	 kR98acH8U2k/w==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63U3O91501669170
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 Apr 2026 11:24:10 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 30 Apr 2026 11:24:09 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Thu,
 30 Apr 2026 11:24:09 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>,
        "nic_swsd@realtek.com" <nic_swsd@realtek.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC Patch net-next v2 4/8] r8169: add support for new interrupt
 mapping
Thread-Topic: [RFC Patch net-next v2 4/8] r8169: add support for new interrupt
 mapping
Thread-Index: AQHc16bmFP6XEBdh3kmvpYj0dwFzt7X1lKWAgAFcbbA=
Date: Thu, 30 Apr 2026 03:24:09 +0000
Message-ID: <a7da7f0169704c5d8cf2284b3b187791@realsil.com.cn>
References: <20260429070750.1477-1-javen_xu@realsil.com.cn>
 <20260429070750.1477-5-javen_xu@realsil.com.cn>
 <40fadbd2-e138-4000-85b2-dd4188d43e19@linux.dev>
In-Reply-To: <40fadbd2-e138-4000-85b2-dd4188d43e19@linux.dev>
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
X-Rspamd-Queue-Id: 8AF2749CC8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-282633-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realsil.com.cn:email,realsil.com.cn:dkim,realsil.com.cn:mid]

Pk9uIDI5LzA0LzIwMjYgMDg6MDcsIGphdmVuIHdyb3RlOg0KPj4gRnJvbTogSmF2ZW4gWHUgPGph
dmVuX3h1QHJlYWxzaWwuY29tLmNuPg0KPj4NCj4+IFRvIHN1cHBvcnQgUlNTLCB0aGUgbnVtYmVy
IG9mIGhhcmR3YXJlIGludGVycnVwdCBiaXRzIHNob3VsZCBtYXRjaCB0aGUNCj4+IGludGVycnVw
dCBvZiBzb2Z0d2FyZS4gU28gd2UgYWRkIHN1cHBvcnQgZm9yIG5ldyBpbnRlcnJ1cHQgbWFwcGlu
ZyBoZXJlLg0KPj4gSVNSX1ZFUl9NQVBfUkVHIGlzIHRoZSBoYXJkd2FyZSByZWdpc3RlciB0byBp
bmRpY2F0ZSBpbnRlcnJ1cHQgc3RhdHVzLg0KPj4gSU1SX1NFVF9WRUNfTUFQX1JFRyBpcyBpbnRl
cnJ1cHQgbWFzayB3aGljaCBpcyBzZXQgdG8gZW5hYmxlIGlycS4NCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBKYXZlbiBYdSA8amF2ZW5feHVAcmVhbHNpbC5jb20uY24+DQo+DQo+Wy4uLl0NCj4NCj4+
DQo+PiAgICAgICAgICAgICAgIG5hcGkgPSAmdHAtPnI4MTY5bmFwaVtpXTsNCj4+ICAgICAgICAg
ICAgICAgc25wcmludGYoaXJxLT5uYW1lLCBsZW4sICIlcy0lZCIsIGRldi0+bmFtZSwgaSk7IEBA
DQo+PiAtNTY2NCwxMCArNTcxNywxNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG5ldF9kZXZpY2Vf
b3BzIHJ0bF9uZXRkZXZfb3BzDQo+PiA9IHsNCj4+DQo+PiAgIHN0YXRpYyB2b2lkIHJ0bF9zZXRf
aXJxX21hc2soc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHApDQo+PiAgIHsNCj4+IC0gICAgIHRw
LT5pcnFfbWFzayA9IFJ4T0sgfCBSeEVyciB8IFR4T0sgfCBUeEVyciB8IExpbmtDaGc7DQo+PiAr
ICAgICBpZiAodHAtPmZlYXR1cmVzICYgUlRMX1ZFQ19NQVBfRU5BQkxFKSB7DQo+PiArICAgICAg
ICAgICAgIHRwLT5pcnFfbWFzayA9IElTUklNUl9MSU5LQ0hHOw0KPj4gKyAgICAgICAgICAgICB0
cC0+aXJxX21hc2sgfD0gSVNSSU1SX1RPS19RMDsNCj4NCj4gICAgICAgbml0OiB5b3UgY2FuIHNl
dCBpdCBpbiBvbmUgbGluZQ0KPg0KPj4gKyAgICAgICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8
IHRwLT5udW1fcnhfcmluZ3M7IGkrKykNCj4+ICsgICAgICAgICAgICAgICAgICAgICB0cC0+aXJx
X21hc2sgfD0gSVNSSU1SX1JPS19RMCA8PCBpOw0KPj4gKyAgICAgfSBlbHNlIHsNCj4+ICsgICAg
ICAgICAgICAgdHAtPmlycV9tYXNrID0gUnhPSyB8IFJ4RXJyIHwgVHhPSyB8IFR4RXJyIHwgTGlu
a0NoZzsNCj4+DQo+PiAtICAgICBpZiAodHAtPm1hY192ZXJzaW9uIDw9IFJUTF9HSUdBX01BQ19W
RVJfMDYpDQo+PiAtICAgICAgICAgICAgIHRwLT5pcnFfbWFzayB8PSBTWVNFcnIgfCBSeEZJRk9P
dmVyOw0KPj4gKyAgICAgICAgICAgICBpZiAodHAtPm1hY192ZXJzaW9uIDw9IFJUTF9HSUdBX01B
Q19WRVJfMDYpDQo+PiArICAgICAgICAgICAgICAgICAgICAgdHAtPmlycV9tYXNrIHw9IFNZU0Vy
ciB8IFJ4RklGT092ZXI7DQo+PiArICAgICB9DQo+PiAgIH0NCj4+DQo+PiAgIHN0YXRpYyBpbnQg
cnRsX2FsbG9jX2lycShzdHJ1Y3QgcnRsODE2OV9wcml2YXRlICp0cCkgQEAgLTU2OTUsNg0KPj4g
KzU3NTUsMTYgQEAgc3RhdGljIGludCBydGxfYWxsb2NfaXJxKHN0cnVjdCBydGw4MTY5X3ByaXZh
dGUgKnRwKQ0KPj4gICAgICAgaWYgKG52ZWNzIDwgMCkNCj4+ICAgICAgICAgICAgICAgbnZlY3Mg
PSBwY2lfYWxsb2NfaXJxX3ZlY3RvcnMocGRldiwgMSwgMSwNCj4+IFBDSV9JUlFfQUxMX1RZUEVT
KTsNCj4+DQo+PiArICAgICB0cC0+ZmVhdHVyZXMgJj0gflJUTF9WRUNfTUFQX0VOQUJMRTsNCj4+
ICsNCj4+ICsgICAgIGlmIChudmVjcyA+IDApIHsNCj4+ICsgICAgICAgICAgICAgdHAtPmlycV9u
dmVjcyA9IG52ZWNzOw0KPj4gKyAgICAgICAgICAgICB0cC0+aXJxID0gcGNpX2lycV92ZWN0b3Io
cGRldiwgMCk7DQo+PiArICAgICAgICAgICAgIGlmIChudmVjcyA+IDEpDQo+PiArICAgICAgICAg
ICAgICAgICAgICAgdHAtPmZlYXR1cmVzIHw9IFJUTF9WRUNfTUFQX0VOQUJMRTsNCj4+ICsgICAg
ICAgICAgICAgcmV0dXJuIDA7DQo+PiArICAgICB9DQo+PiArDQo+PiAgICAgICB0cC0+aXJxID0g
cGRldi0+aXJxOw0KPj4gICAgICAgdHAtPmlycV9udmVjcyA9IDE7DQo+DQo+bm93IHRoZXNlIDIg
bGluZXMgYXJlIG5vdCBuZWVkZWQsIGJlY2F1c2UgaW4gc3VjY2VzcyB0aGV5IGFyZSBuZXZlciBl
eGVjdXRlZCwNCj5idXQgaW4gZXJyb3IgcGF0aCB0aGV5IHByb3ZpZGUgd3JvbmcgaW5mb3JtYXRp
b24uDQo+DQo+dGhlIHdob2xlIGNhbiBiZSByZXdyaXR0ZW4gd2l0aCBlcnJvciBwYXRoIGluIGNh
c2UgYm90aCB0cmllcyBvZg0KPnBjaV9hbGxvY19pcnFfdmVjdG9ycyBmYWlsZWQgYW5kIHRoZSBj
b21tb24gY29kZSBmb3Igc3VjY2VzcyBwYXRoOg0KPg0KPiAgICAgICAgaWYgKG52ZWNzIDwgMCkN
Cj4gICAgICAgICAgICAgICAgbnZlY3MgPSBwY2lfYWxsb2NfaXJxX3ZlY3RvcnMocGRldiwgMSwg
MSwgUENJX0lSUV9BTExfVFlQRVMpOw0KPg0KPiAgICAgICAgaWYgKG52ZWNzIDwgMCkNCj4gICAg
ICAgICAgICAgICAgcmV0dXJuIG52ZWNzOw0KPg0KPiAgICAgICAgdHAtPmlycV9udmVjcyA9IG52
ZWNzOw0KPiAgICAgICAgdHAtPmlycSA9IHBjaV9pcnFfdmVjdG9yKHBkZXYsIDApOw0KPg0KPiAg
ICAgICAgaWYgKG52ZWNzID4gMSkNCj4gICAgICAgICAgICAgICAgdHAtPmZlYXR1cmVzIHw9IFJU
TF9WRUNfTUFQX0VOQUJMRTsNCj4NCj4gICAgICAgIHJldHVybiAwOw0KPg0KPj4NCj4+IEBAIC01
OTY1LDYgKzYwMzUsNTMgQEAgc3RhdGljIGJvb2wgcnRsX2FzcG1faXNfc2FmZShzdHJ1Y3QNCj5y
dGw4MTY5X3ByaXZhdGUgKnRwKQ0KPj4gICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gICB9DQo+Pg0K
Pj4gK3N0YXRpYyBpbnQgcnRsODE2OV9wb2xsX21zaXhfcngoc3RydWN0IG5hcGlfc3RydWN0ICpu
YXBpLCBpbnQgYnVkZ2V0KQ0KPj4gK3sNCj4+ICsgICAgIHN0cnVjdCBydGw4MTY5X25hcGkgKnI4
MTY5X25hcGkgPSBjb250YWluZXJfb2YobmFwaSwgc3RydWN0IHJ0bDgxNjlfbmFwaSwNCj5uYXBp
KTsNCj4+ICsgICAgIHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRwID0gcjgxNjlfbmFwaS0+cHJp
djsNCj4+ICsgICAgIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYgPSB0cC0+ZGV2Ow0KPj4gKyAgICAg
Y29uc3QgaW50IG1lc3NhZ2VfaWQgPSByODE2OV9uYXBpLT5pbmRleDsNCj4NCj5yZXZlcnNlIHht
YXNzIHRyZWUsIHBsZWFzZQ0KPg0KPj4gKyAgICAgaW50IHdvcmtfZG9uZSA9IDA7DQo+PiArDQo+
PiArICAgICBpZiAobWVzc2FnZV9pZCA8IHRwLT5udW1fcnhfcmluZ3MpDQo+PiArICAgICAgICAg
ICAgIHdvcmtfZG9uZSArPSBydGxfcngoZGV2LCB0cCwgJnRwLT5yeF9yaW5nW21lc3NhZ2VfaWRd
LA0KPj4gKyBidWRnZXQpOw0KPj4gKw0KPj4gKyAgICAgaWYgKHdvcmtfZG9uZSA8IGJ1ZGdldCAm
JiBuYXBpX2NvbXBsZXRlX2RvbmUobmFwaSwgd29ya19kb25lKSkNCj4+ICsgICAgICAgICAgICAg
cnRsODE2OV9lbmFibGVfaHdfaW50ZXJydXB0X21zaXgodHAsIG1lc3NhZ2VfaWQpOw0KPj4gKw0K
Pj4gKyAgICAgcmV0dXJuIHdvcmtfZG9uZTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGludCBy
dGw4MTY5X3BvbGxfbXNpeF90eChzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksIGludCBidWRnZXQp
DQo+PiArew0KPj4gKyAgICAgc3RydWN0IHJ0bDgxNjlfbmFwaSAqcjgxNjlfbmFwaSA9IGNvbnRh
aW5lcl9vZihuYXBpLCBzdHJ1Y3QgcnRsODE2OV9uYXBpLA0KPm5hcGkpOw0KPj4gKyAgICAgc3Ry
dWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHAgPSByODE2OV9uYXBpLT5wcml2Ow0KPj4gKyAgICAgc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldiA9IHRwLT5kZXY7DQo+PiArICAgICB1bnNpZ25lZCBpbnQgd29y
a19kb25lID0gMDsNCj4+ICsgICAgIGNvbnN0IGludCBtZXNzYWdlX2lkID0gcjgxNjlfbmFwaS0+
aW5kZXg7DQo+PiArICAgICBpbnQgdHhfcmluZ19pZHggPSBtZXNzYWdlX2lkIC0gODsNCj4NCj5k
aXR0bw0KPg0KPj4gKw0KPj4gKyAgICAgaWYgKHR4X3JpbmdfaWR4ID49IDApDQo+PiArICAgICAg
ICAgICAgIHJ0bF90eChkZXYsIHRwLCBidWRnZXQpOw0KPj4gKw0KPj4gKyAgICAgaWYgKHdvcmtf
ZG9uZSA8IGJ1ZGdldCAmJiBuYXBpX2NvbXBsZXRlX2RvbmUobmFwaSwgd29ya19kb25lKSkNCj4+
ICsgICAgICAgICAgICAgcnRsODE2OV9lbmFibGVfaHdfaW50ZXJydXB0X21zaXgodHAsIG1lc3Nh
Z2VfaWQpOw0KPj4gKw0KPj4gKyAgICAgcmV0dXJuIHdvcmtfZG9uZTsNCj4+ICt9DQo+PiArDQo+
PiArc3RhdGljIGludCBydGw4MTY5X3BvbGxfbXNpeF9vdGhlcihzdHJ1Y3QgbmFwaV9zdHJ1Y3Qg
Km5hcGksIGludA0KPj4gK2J1ZGdldCkgew0KPj4gKyAgICAgc3RydWN0IHJ0bDgxNjlfbmFwaSAq
cjgxNjlfbmFwaSA9IGNvbnRhaW5lcl9vZihuYXBpLCBzdHJ1Y3QgcnRsODE2OV9uYXBpLA0KPm5h
cGkpOw0KPj4gKyAgICAgc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHAgPSByODE2OV9uYXBpLT5w
cml2Ow0KPj4gKyAgICAgY29uc3QgaW50IG1lc3NhZ2VfaWQgPSByODE2OV9uYXBpLT5pbmRleDsN
Cj4+ICsNCj4+ICsgICAgIG5hcGlfY29tcGxldGVfZG9uZShuYXBpLCBidWRnZXQpOw0KPj4gKyAg
ICAgcnRsODE2OV9lbmFibGVfaHdfaW50ZXJydXB0X21zaXgodHAsIG1lc3NhZ2VfaWQpOw0KPj4g
Kw0KPj4gKyAgICAgcmV0dXJuIDE7DQo+PiArfQ0KPj4gKw0KPj4gICBzdGF0aWMgdm9pZCByODE2
OV9pbml0X25hcGkoc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHApDQo+PiAgIHsNCj4+ICAgICAg
IGZvciAoaW50IGkgPSAwOyBpIDwgdHAtPmlycV9udmVjczsgaSsrKSB7IEBAIC01OTcyLDYgKzYw
ODksMjAgQEANCj4+IHN0YXRpYyB2b2lkIHI4MTY5X2luaXRfbmFwaShzdHJ1Y3QgcnRsODE2OV9w
cml2YXRlICp0cCkNCj4+ICAgICAgICAgICAgICAgaW50ICgqcG9sbCkoc3RydWN0IG5hcGlfc3Ry
dWN0ICpuYXBpLCBpbnQgYnVkZ2V0KTsNCj4+DQo+PiAgICAgICAgICAgICAgIHBvbGwgPSBydGw4
MTY5X3BvbGw7DQo+PiArICAgICAgICAgICAgIGlmICh0cC0+ZmVhdHVyZXMgJiBSVExfVkVDX01B
UF9FTkFCTEUpIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBzd2l0Y2ggKHRwLT5od19jdXJy
X2lzcl92ZXIpIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBjYXNlIDY6DQo+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpZiAoaSA8IFI4MTI3X01BWF9SWF9RVUVVRVMpDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBvbGwgPSBydGw4MTY5X3BvbGxf
bXNpeF9yeDsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVsc2UgaWYgKGkgPiA3
ICYmIGkgPCAxNikNCj4NCj4gICAgICAgIG1hZ2ljIGNvbnN0YW50cz8NCj4NCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcG9sbCA9IHJ0bDgxNjlfcG9sbF9tc2l4X3R4
Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZWxzZQ0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBwb2xsID0gcnRsODE2OV9wb2xsX21zaXhfb3RoZXI7
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICBkZWZhdWx0Og0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJl
YWs7DQo+PiArICAgICAgICAgICAgICAgICAgICAgfQ0KPj4gKyAgICAgICAgICAgICB9DQo+PiAg
ICAgICAgICAgICAgIG5ldGlmX25hcGlfYWRkKHRwLT5kZXYsICZyODE2OW5hcGktPm5hcGksIHBv
bGwpOw0KPj4gICAgICAgICAgICAgICByODE2OW5hcGktPnByaXYgPSB0cDsNCj4+ICAgICAgICAg
ICAgICAgcjgxNjluYXBpLT5pbmRleCA9IGk7DQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuIEkg
aGF2ZSBhcHBsaWVkIGFsbCB0aGUgY29tbWVudHMgbG9jYWxseS4gT25jZSB0aGUgb25nb2luZyBk
aXNjdXNzaW9uIGNvbmNsdWRlcywgSSB3aWxsIHNlbmQgdGhlIG5leHQgdmVyc2lvbi4NCg0KQlJz
LA0KSmF2ZW4NCg0K

