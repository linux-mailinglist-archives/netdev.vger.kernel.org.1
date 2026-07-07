Return-Path: <netdev+bounces-305252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TvI/BvBYTGrujQEAu9opvQ
	(envelope-from <netdev+bounces-305252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 03:40:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1385716A3C
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 03:39:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305252-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305252-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D5F7302678B
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 01:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A742230BB94;
	Tue,  7 Jul 2026 01:39:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471942F8E87;
	Tue,  7 Jul 2026 01:39:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783388396; cv=none; b=lyILxSvYz2wkUO1kdn0h99IJzzy9LNVAxbvtgih0u4Lr9ek7nrUZOdO04ezwkk+RAhbI36+9kFRZsMmH3hNP+9mUp4b0fUxBbixgmaihIgJ+IIDoaJdBgkbx1M0jdz2clMBW9wvCa9uUaRt4cpRpbkYoy2T+gRWqu9mqih87wgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783388396; c=relaxed/simple;
	bh=U8mnG7gmyZdzLW4X8k/b7yhoGAJufakGSaO8vIHHVKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=bkWBxEFvAzWUhQ6OxE3e0RV4PJDTUC492IeU4Caj7QbCcAsv0P1yKaHgJziJ5nQRVl7kckdZxJGY92gcGQgwFkqgE5ohgoTignEYLWVJtpN3YDulEjI3/7WJvTdaI7jt4IeFKe1tx+/eY4FQPlFtbtC0HFD/Ra0/+JTUXFTKWIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Tue, 7 Jul 2026 09:39:41 +0800 (GMT+08:00)
Date: Tue, 7 Jul 2026 09:39:41 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Paolo Abeni" <pabeni@redhat.com>
Cc: "Andrew Lunn" <andrew@lunn.ch>, sashiko-reviews@lists.linux.dev,
	conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
	"Min Lin" <linmin@eswincomputing.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Re: [PATCH net-next v9 6/6] riscv: dts: eswin:
 eic7700-hifive-premier-p550: enable Ethernet controller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <41d0e6d6-f1fc-425e-a122-b0433a925a3d@redhat.com>
References: <20260630063123.1118-1-lizhi2@eswincomputing.com>
 <20260630063445.1226-1-lizhi2@eswincomputing.com>
 <20260701063512.9ED051F000E9@smtp.kernel.org>
 <5de09a24.a11e.19f2207d7d2.Coremail.lizhi2@eswincomputing.com>
 <58532b95-bb74-4d87-acae-e67b41dd7d57@lunn.ch>
 <f21ffca.a15e.19f25abaea6.Coremail.lizhi2@eswincomputing.com>
 <41d0e6d6-f1fc-425e-a122-b0433a925a3d@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5d02cc6b.a380.19f3a3b21b7.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TAJkCgDHW3DeWExqqv0xAA--.9550W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAQEADGpKhyUuEAADsz
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:andrew@lunn.ch,m:sashiko-reviews@lists.linux.dev,m:conor+dt@kernel.org,m:robh@kernel.org,m:devicetree@vger.kernel.org,m:linmin@eswincomputing.com,m:netdev@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-305252-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:email,eswincomputing.com:from_mime,eswincomputing.com:email,eswincomputing.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1385716A3C

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiUGFvbG8gQWJlbmkiIDxw
YWJlbmlAcmVkaGF0LmNvbT4KPiBTZW5kIHRpbWU6TW9uZGF5LCAwNi8wNy8yMDI2IDIxOjM1OjQw
Cj4gVG86IOadjuW/lyA8bGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbT4sICJBbmRyZXcgTHVubiIg
PGFuZHJld0BsdW5uLmNoPgo+IENjOiBzYXNoaWtvLXJldmlld3NAbGlzdHMubGludXguZGV2LCBj
b25vcitkdEBrZXJuZWwub3JnLCByb2JoQGtlcm5lbC5vcmcsIGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnLCAiTWluIExpbiIgPGxpbm1pbkBlc3dpbmNvbXB1dGluZy5jb20+LCAibmV0ZGV2QHZn
ZXIua2VybmVsLm9yZyIgPG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+Cj4gU3ViamVjdDogUmU6IFtQ
QVRDSCBuZXQtbmV4dCB2OSA2LzZdIHJpc2N2OiBkdHM6IGVzd2luOiBlaWM3NzAwLWhpZml2ZS1w
cmVtaWVyLXA1NTA6IGVuYWJsZSBFdGhlcm5ldCBjb250cm9sbGVyCj4gCj4gT24gNy8zLzI2IDM6
NTAgQU0sIOadjuW/lyB3cm90ZToKPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiA+
PiBGcm9tOiAiQW5kcmV3IEx1bm4iIDxhbmRyZXdAbHVubi5jaD4KPiA+PiBTZW5kIHRpbWU6VGh1
cnNkYXksIDAyLzA3LzIwMjYgMjE6MjI6MzQKPiA+PiBUbzog5p2O5b+XIDxsaXpoaTJAZXN3aW5j
b21wdXRpbmcuY29tPgo+ID4+IENjOiBzYXNoaWtvLXJldmlld3NAbGlzdHMubGludXguZGV2LCBj
b25vcitkdEBrZXJuZWwub3JnLCByb2JoQGtlcm5lbC5vcmcsIGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnLCAiTWluIExpbiIgPGxpbm1pbkBlc3dpbmNvbXB1dGluZy5jb20+Cj4gPj4gU3ViamVj
dDogUmU6IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjkgNi82XSByaXNjdjogZHRzOiBlc3dpbjogZWlj
NzcwMC1oaWZpdmUtcHJlbWllci1wNTUwOiBlbmFibGUgRXRoZXJuZXQgY29udHJvbGxlcgo+ID4+
Cj4gPj4+IEhpIEFuZHJldywKPiA+Pj4KPiA+Pj4gT25lIHF1ZXN0aW9uIGJlZm9yZSBJIHByZXBh
cmUgdGhlIG5leHQgcmV2aXNpb24uCj4gPj4+Cj4gPj4+IEFzIGRpc2N1c3NlZCBwcmV2aW91c2x5
LCB0aGUgRFRTIHBhdGNoIHdhcyBpbmNsdWRlZCBvbmx5IHRvIHByb3ZpZGUgdGhlIG92ZXJhbGwK
PiA+Pj4gRXRoZXJuZXQgZGVzaWduIGNvbnRleHQgZHVyaW5nIHRoZSByZXZpZXcgb2YgdGhlIGJp
bmRpbmcgYW5kIGRyaXZlciBwYXRjaGVzOgo+ID4+Pgo+ID4+PiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9sa21sLzY0YmY2YjQwLWI5NDctNGZmYS04ZDQ4LTRkNjM0MTkzMTMyN0BsdW5uLmNoLwo+
ID4+Pgo+ID4+PiBGb3IgdGhlIG5leHQgcmV2aXNpb24sIHdvdWxkIGl0IGJlIGFjY2VwdGFibGUg
dG8gZHJvcCB0aGUgRFRTIHBhdGNoIGZyb20gdGhpcwo+ID4+PiBzZXJpZXMgYW5kIHBvc3Qgb25s
eSB0aGUgYmluZGluZyBhbmQgZHJpdmVyIHBhdGNoZXM/IFRoZSBjb21wbGV0ZSBEVFMKPiA+Pj4g
ZW5hYmxlbWVudCBpcyBwbGFubmVkIHRvIGJlIHN1Ym1pdHRlZCBsYXRlciBhcyBhIHNlcGFyYXRl
IHNlcmllcyBhZnRlciB0aGUKPiA+Pj4gYmluZGluZyBhbmQgZHJpdmVyIGhhdmUgYmVlbiBtZXJn
ZWQuCj4gPj4KPiA+PiBXaGF0IG5vcm1hbGx5IGhhcHBlbnMgaXMgdGhhdCBJIGdpdmUgYW4gQWNr
ZWQtYnk6IG9yIGEgUmV2aWV3ZWQtYnk6Cj4gPj4gZm9yIHRoZSBEVCBwYXRjaCwgYW5kIHlvdSBz
dWJtaXQgaXQgZm9yIG1lcmdpbmcgdmlhIHRoZSBEVCBNYWludGFpbmVyLgo+ID4+IEV2ZXJ5dGhp
bmcgdGhlbiBtZWV0cyB1cCBpbiBsaW51eC1uZXh0Lgo+ID4+Cj4gPj4gV2h5IGRvIHlvdSBuZWVk
IHRvIGRvIHRoaXMgbGF0ZXI/IFdoeSBub3Qgbm93Pwo+ID4+Cj4gPiAKPiA+IFRoZXJlIGlzIGFu
IGFub3RoZXIgc2VwZXJhdGUgRFQgcGF0Y2ggc2VyaWVzCj4gPiBbaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjYwNjE1MTIyMDE2LjExMTAyMDYtMS1waW5rZXNoLnZhZ2hlbGFAZWluZm9j
aGlwcy5jb20vXQo+ID4gd2hpY2ggaXMgdW5kZXIgcmV2aWV3Lgo+ID4gSXQgYWxzbyBpbnRyb2R1
Y2VzIERUIG5vZGVzIGZvciByZXNldCwgY2xvY2ssIHBpbmN0cmwsIEhTUCBwb3dlciBkb21haW4u
Cj4gPiAKPiA+IFRoZXJlZm9yZSwgb3VyIHBsYW5uZWQgc3RlcHMgYXJlIGFzIGZvbGxvd3M6Cj4g
PiAxLiBJbiB0aGUgbmV4dCBuZXQtbmV4dCB2MTDigIsgcGF0Y2ggc2VyaWVzLCBkcm9wIHRoZSBE
VFMgcGF0Y2hlcywgYW5kIHN1Ym1pdCBvbmx5Cj4gPiAgICB0aGUgYmluZGluZ3MgYW5kIGRyaXZl
ci4KPiA+IDIuIFdhaXQgZm9yIFBpbmtlc2jigJlzIERUIHBhdGNoIHNlcmllc+KAiyB0byBiZSBt
ZXJnZWQuCj4gPiAzLiBPbmNlIHRoZSBIU1BDUkcgcGF0Y2ggc2VyaWVz4oCLCj4gPiAgICBbaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNjA1MDYwNzMwLjE2MDUtMS1kb25neHV5YW5n
QGVzd2luY29tcHV0aW5nLmNvbS9dCj4gPiAgICBpcyBtZXJnZWQsIHN1Ym1pdCBhIG5ldyBEVCBw
YXRjaCBzZXJpZXPigIsgdG8gZXh0ZW5kIEVTV0lOIEVJQzc3MDAgU29DIHN1cHBvcnTigIsKPiA+
ICAgIGZvciBhbGwgSFNQIG1vZHVsZXPigJRpbmNsdWRpbmcgVVNCLCBlTU1DLCBTRCwgYW5kIEV0
aGVybmV0LCBzaW5jZSB0aGV5IGFyZSBhbGwKPiA+ICAgIHVuZGVyIHRoZSBIU1AgYnVzIG5vZGUg
ZXZlbnRob3VnaCBldGhlcm5ldCBkb2VzZSBub3QgZGVwZW5kIG9uIEhTUENSRyBwYXRjaC4KPiAK
PiBJbiB2MTAgcGxlYXNlIGluY2x1ZGUgc29tZSBhY3R1YWwgZGVzY3JpcHRpb24gb2YgdGhlIHNl
cmllcywgYmV5b25kIHRoZQo+IGNoYW5nZWxvZy4KPiAKCk9LLCB0aGFua3MuCgpGb3IgdjEwLCB3
ZSdsbCBkcm9wIHRoZSBEVFMgcGF0Y2hlcyAocGF0Y2hlcyA1IGFuZCA2IGluIHY5KSBmcm9tIHRo
aXMKc2VyaWVzIGFuZCB1cGRhdGUgdGhlIGNvdmVyIGxldHRlciB0byBpbmNsdWRlIGEgcHJvcGVy
IGRlc2NyaXB0aW9uIG9mCnRoZSBzZXJpZXMuCg==

