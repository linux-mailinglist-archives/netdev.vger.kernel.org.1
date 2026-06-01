Return-Path: <netdev+bounces-293490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMTnLuHdHGpKTgkAu9opvQ
	(envelope-from <netdev+bounces-293490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 03:18:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B439618984
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 03:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E7D3301368D
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 01:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BFF175A88;
	Mon,  1 Jun 2026 01:18:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D238846F;
	Mon,  1 Jun 2026 01:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780276702; cv=none; b=hPgIRpnHheB7fT3nekZtylZDlDWofiMjeh0po3WIyK5CaYwMkY31hO1XfcT5+NIBUYtDhEfck0tO5D79vMDa8hBlHDiBlHJtyGGRvuZKiAS22KiychGEtldFov7mW9xjVg751acv3eEWf5nkTeAsU4/a0dwd+ZSdb90N9O5aJiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780276702; c=relaxed/simple;
	bh=rQvagyY4Ca+v/dxQorgD/epfZs221Q8Oj9GImAEUUac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=gL3sD0t3nEZhWx0pyrld1z4oEv1qfV22nbsNOrr0PvWDgmo/FdljjPYm4enPeMK2koB9J3KaUWALnny8dK+A50Uq8sOeMHlyM4yaW6tNRjlvyXwAQeALslPco4g48yNqXU3IVdE4nvsrTAbO2XzY3CMEjGM26z2EBjDhrv7Uv4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Mon, 1 Jun 2026 09:17:40 +0800 (GMT+08:00)
Date: Mon, 1 Jun 2026 09:17:40 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com, sashiko-bot@kernel.org
Subject: Re: Re: [PATCH net v1] dt-bindings: ethernet: eswin: fix hsp-sp-csr
 backward compatibility
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260530-hysterical-oyster-of-skill-0c93cb@quoll>
References: <20260525052441.1637-1-lizhi2@eswincomputing.com>
 <20260530-hysterical-oyster-of-skill-0c93cb@quoll>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <15b536d2.8d0c.19e80c20ad8.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TAJkCgBn_HC13RxqZLMfAA--.8194W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAQEEDGocYp8AQQADsB
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[eswincomputing.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293490-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_SPAM(0.00)[0.297];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0B439618984
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiS3J6eXN6dG9mIEtvemxv
d3NraSIgPGtyemtAa2VybmVsLm9yZz4KPiBTZW5kIHRpbWU6U2F0dXJkYXksIDMwLzA1LzIwMjYg
MTk6MTg6NTQKPiBUbzogbGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbQo+IENjOiBhbmRyZXcrbmV0
ZGV2QGx1bm4uY2gsIGRhdmVtQGRhdmVtbG9mdC5uZXQsIGVkdW1hemV0QGdvb2dsZS5jb20sIGt1
YmFAa2VybmVsLm9yZywgcGFiZW5pQHJlZGhhdC5jb20sIHJvYmhAa2VybmVsLm9yZywga3J6aytk
dEBrZXJuZWwub3JnLCBjb25vcitkdEBrZXJuZWwub3JnLCBuZXRkZXZAdmdlci5rZXJuZWwub3Jn
LCBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZywgbmluZ3l1QGVzd2luY29tcHV0aW5nLmNvbSwgbGlubWluQGVzd2luY29tcHV0aW5nLmNvbSwg
cGlua2VzaC52YWdoZWxhQGVpbmZvY2hpcHMuY29tLCBwcml0ZXNoLnBhdGVsQGVpbmZvY2hpcHMu
Y29tLCB3ZWlzaGFuZ2p1YW5AZXN3aW5jb21wdXRpbmcuY29tLCBzYXNoaWtvLWJvdEBrZXJuZWwu
b3JnCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQgdjFdIGR0LWJpbmRpbmdzOiBldGhlcm5ldDog
ZXN3aW46IGZpeCBoc3Atc3AtY3NyIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkKPiAKPiBPbiBNb24s
IE1heSAyNSwgMjAyNiBhdCAwMToyNDo0MVBNICswODAwLCBsaXpoaTJAZXN3aW5jb21wdXRpbmcu
Y29tIHdyb3RlOgo+ID4gRnJvbTogWmhpIExpIDxsaXpoaTJAZXN3aW5jb21wdXRpbmcuY29tPgo+
ID4gCj4gPiBUaGUgcHJldmlvdXMgY2hhbmdlIGFkZGVkIHR3byBvcHRpb25hbCBjZWxscyB0bwo+
IAo+IFdoYXQgaXMgcHJldmlvdXMgaW4gdGhpcyBjb250ZXh0PyBUaGVyZSBpcyBubyBwcmV2aW91
cyBjb21taXQgaGVyZS4KPiAKCkdvb2QgcG9pbnQuIEknbGwgcmV3b3JkIHRoaXMgaW4gdjIgdG8g
ZXhwbGljaXRseSByZWZlcmVuY2UgdGhlIGNvbW1pdApiZWluZyBmaXhlZC4KCj4gPiBlc3dpbixo
c3Atc3AtY3NyLCBidXQgb21pdHRlZCBtaW5JdGVtczogNC4KPiA+IAo+ID4gQXMgYSByZXN1bHQs
IGR0LXNjaGVtYSBpbXBsaWNpdGx5IHJlcXVpcmVkIGFsbCA2IGNlbGxzLAo+ID4gYnJlYWtpbmcg
YmFja3dhcmQgY29tcGF0aWJpbGl0eSB3aXRoIGV4aXN0aW5nIDQtY2VsbAo+ID4gZGV2aWNlIHRy
ZWVzLgo+IAo+IFBsZWFzZSB3cmFwIGNvbW1pdCBtZXNzYWdlIGFjY29yZGluZyB0byBMaW51eCBj
b2Rpbmcgc3R5bGUgLyBzdWJtaXNzaW9uCj4gcHJvY2VzcyAobmVpdGhlciB0b28gZWFybHkgbm9y
IG92ZXIgdGhlIGxpbWl0KToKPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni40
LXJjMS9zb3VyY2UvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3Qj
TDU5Nwo+IAoKVGhhbmtzLCBJJ2xsIGZpeCB0aGUgbGluZSB3cmFwcGluZyBpbiB2MiBhcyB3ZWxs
LgoKPiA+IAo+ID4gQWRkIG1pbkl0ZW1zOiA0IHRvIHByZXNlcnZlIGJhY2t3YXJkIGNvbXBhdGli
aWxpdHkuCj4gPiAKPiA+IEZpeGVzOiBjMzYwNjljNmY0NmMgKCJkdC1iaW5kaW5nczogZXRoZXJu
ZXQ6IGVzd2luOiBhZGQgb3B0aW9uYWwgVFhEIGFuZCBSWEQgZGVsYXkgcmVnaXN0ZXIgb2Zmc2V0
cyIpCj4gPiBSZXBvcnRlZC1ieTogU2FzaGlrbyBBSSA8c2FzaGlrby1ib3RAa2VybmVsLm9yZz4K
PiA+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNTE5MDIyMzM0LjM1
NzQyQzJCQ0I3QHNtdHAua2VybmVsLm9yZy8KPiA+IFNpZ25lZC1vZmYtYnk6IFpoaSBMaSA8bGl6
aGkyQGVzd2luY29tcHV0aW5nLmNvbT4KPiA+IC0tLQo+IAo+IAo+IFdpdGggZml4ZWQgY29tbWl0
IG1zZzoKPiAKPiBSZXZpZXdlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtv
emxvd3NraUBvc3MucXVhbGNvbW0uY29tPgo+IAoKVGhhbmtzLCBJJ2xsIGNhcnJ5IHlvdXIgUmV2
aWV3ZWQtYnkgdGFnIGluIHYyLgo=

