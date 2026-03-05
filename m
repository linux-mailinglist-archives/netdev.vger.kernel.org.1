Return-Path: <netdev+bounces-264153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPDqE0HwqGkwzAAAu9opvQ
	(envelope-from <netdev+bounces-264153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:53:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3BC20A597
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8039301E3E2
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 02:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C13A267B07;
	Thu,  5 Mar 2026 02:53:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CBD26A1AF;
	Thu,  5 Mar 2026 02:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772679202; cv=none; b=QfdEiBeAYTtsZibXQ5LIhkrrgri6Oxz99wLN15R/4Bom/pt0T2YizrhjuCO9eVx1HVL5WZvOTOXk/5inMbO+kF5uXpLFzq/kAGLwed36BZUk54JxfJhmOwl0LT2EY6SMI5ShP5HedGV3gzkqrwM+rbvd8lfFWd8SLOiCqHCsnP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772679202; c=relaxed/simple;
	bh=ybndNrLUKU2ohwbDLpcSzdJf2WxNWha0amEA0YitpQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=IXcGc0F/wPkisFexgs2v+KNyB+Ham8rDKFc2U0wWkvqE8UfIPxrrOP/lYEbUjbmN/zK0A5UZavJPtmxUWOSSqqUmBU5qOWw6nCJXlBHoJvPW1FEKj0Z2krPYAqhCpyBvxchP45BmEwvnCW/8+gnrWbP/APKL8a0Dy+dN33KnRiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Thu, 5 Mar 2026 10:52:38 +0800 (GMT+08:00)
Date: Thu, 5 Mar 2026 10:52:38 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Conor Dooley" <conor@kernel.org>, krzk+dt@kernel.org
Cc: "Bo Gan" <ganboing@gmail.com>, "Jakub Kicinski" <kuba@kernel.org>,
	devicetree@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, robh@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, wens@kernel.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com
Subject: Re: Re: [PATCH net-next v3 1/3] dt-bindings: ethernet: eswin: add
 clock sampling control
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260304-capable-setback-908ba5b5c858@spud>
References: <20260303061525.846-1-lizhi2@eswincomputing.com>
 <20260303061637.872-1-lizhi2@eswincomputing.com>
 <20260303163846.156d18f7@kernel.org>
 <20260304-regulate-verdict-c3a361d2dc83@spud>
 <05a15890-392c-41c3-9566-8eb506ddfe5f@gmail.com>
 <20260304-capable-setback-908ba5b5c858@spud>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <9eaad6e.4df8.19cbbe95b3c.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TAJkCgBnCXP276hpA8kFAA--.1626W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAgERDGmoXwcMsQAAs6
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Queue-Id: EF3BC20A597
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264153-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_X_PRIO_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,eswincomputing.com,einfochips.com];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiQ29ub3IgRG9vbGV5IiA8
Y29ub3JAa2VybmVsLm9yZz4KPiDlj5HpgIHml7bpl7Q6MjAyNi0wMy0wNCAxNzozMDo1NyAo5pif
5pyf5LiJKQo+IOaUtuS7tuS6ujogIkJvIEdhbiIgPGdhbmJvaW5nQGdtYWlsLmNvbT4KPiDmioTp
gIE6ICJKYWt1YiBLaWNpbnNraSIgPGt1YmFAa2VybmVsLm9yZz4sIGxpemhpMkBlc3dpbmNvbXB1
dGluZy5jb20sIGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnLCBhbmRyZXcrbmV0ZGV2QGx1bm4u
Y2gsIGRhdmVtQGRhdmVtbG9mdC5uZXQsIGVkdW1hemV0QGdvb2dsZS5jb20sIHJvYmhAa2VybmVs
Lm9yZywga3J6aytkdEBrZXJuZWwub3JnLCBjb25vcitkdEBrZXJuZWwub3JnLCBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnLCBwYWJlbmlAcmVkaGF0LmNvbSwgbWNvcXVlbGluLnN0bTMyQGdtYWlsLmNv
bSwgYWxleGFuZHJlLnRvcmd1ZUBmb3NzLnN0LmNvbSwgcm1rK2tlcm5lbEBhcm1saW51eC5vcmcu
dWssIHdlbnNAa2VybmVsLm9yZywgcGp3QGtlcm5lbC5vcmcsIHBhbG1lckBkYWJiZWx0LmNvbSwg
YW91QGVlY3MuYmVya2VsZXkuZWR1LCBhbGV4QGdoaXRpLmZyLCBsaW51eC1yaXNjdkBsaXN0cy5p
bmZyYWRlYWQub3JnLCBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29tLCBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcsIG5pbmd5dUBlc3dpbmNvbXB1dGluZy5jb20sIGxpbm1pbkBlc3dpbmNvbXB1dGlu
Zy5jb20sIHBpbmtlc2gudmFnaGVsYUBlaW5mb2NoaXBzLmNvbSwgcHJpdGVzaC5wYXRlbEBlaW5m
b2NoaXBzLmNvbSwgd2Vpc2hhbmdqdWFuQGVzd2luY29tcHV0aW5nLmNvbQo+IOS4u+mimDogUmU6
IFtQQVRDSCBuZXQtbmV4dCB2MyAxLzNdIGR0LWJpbmRpbmdzOiBldGhlcm5ldDogZXN3aW46IGFk
ZCBjbG9jayBzYW1wbGluZyBjb250cm9sCj4gCj4gT24gVHVlLCBNYXIgMDMsIDIwMjYgYXQgMDU6
MjM6MThQTSAtMDgwMCwgQm8gR2FuIHdyb3RlOgo+ID4gSGkgQWxsLAo+ID4gCj4gPiBPbiAzLzMv
MjYgMTY6NDcsIENvbm9yIERvb2xleSB3cm90ZToKPiA+ID4gT24gVHVlLCBNYXIgMDMsIDIwMjYg
YXQgMDQ6Mzg6NDZQTSAtMDgwMCwgSmFrdWIgS2ljaW5za2kgd3JvdGU6Cj4gPiA+ID4gT24gVHVl
LCAgMyBNYXIgMjAyNiAxNDoxNjozNyArMDgwMCBsaXpoaTJAZXN3aW5jb21wdXRpbmcuY29tIHdy
b3RlOgo+ID4gPiA+ID4gVGhlcmUgYXJlIGN1cnJlbnRseSBubyBpbi10cmVlIHVzZXJzIG9mIHRo
ZSBFSUM3NzAwIEV0aGVybmV0IGRyaXZlciwgc28KPiA+ID4gPiA+IHRoZXNlIGNoYW5nZXMgYXJl
IHNhZmUuCj4gPiA+ID4gCj4gPiA+ID4gV2hhdCBkbyB5b3UgbWVhbiBieSB0aGlzIHNlbnRlbmNl
PyBUaGUgY29tbWl0IHVuZGVyIEZpeGVzIHdhcyBwYXJ0IG9mCj4gPiA+ID4gTGludXggdjYuMTkg
YWxyZWFkeS4KPiA+ID4gCj4gPiA+IFRoZSAiZnVubnkiIHRoaW5nIGlzIHRoYXQgY2FyaW5nIGFi
b3V0IHVzZXJzIGRvZXNuJ3QgZXZlbiByZWFsbHkgbWF0dGVyCj4gPiA+IG9uIHRoZSBkZXZpY2V0
cmVlIHBhdGNoLCBleGNlcHQgZm9yIHRoaXMgaHVuazoKPiA+ID4gfEBAIC04MSw3ICs5OSw5IEBA
IHByb3BlcnRpZXM6Cj4gPiA+IHwgICAgICAgICAgICAgICAgICAgICAgICAgIG9yIGV4dGVybmFs
IGNsb2NrIHNlbGVjdGlvbgo+ID4gPiB8ICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBPZmZzZXQg
b2YgQVhJIGNsb2NrIGNvbnRyb2xsZXIgTG93LVBvd2VyIHJlcXVlc3QKPiA+ID4gfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmVnaXN0ZXIKPiA+ID4gfCsgICAgICAgICAgLSBkZXNjcmlwdGlv
bjogT2Zmc2V0IG9mIHJlZ2lzdGVyIGNvbnRyb2xsaW5nIFRYRCBkZWxheQo+ID4gPiB8ICAgICAg
ICAgICAtIGRlc2NyaXB0aW9uOiBPZmZzZXQgb2YgcmVnaXN0ZXIgY29udHJvbGxpbmcgVFgvUlgg
Y2xvY2sgZGVsYXkKPiA+ID4gfCsgICAgICAgICAgLSBkZXNjcmlwdGlvbjogT2Zmc2V0IG9mIHJl
Z2lzdGVyIGNvbnRyb2xsaW5nIFJYRCBkZWxheQo+ID4gPiB8Cj4gPiA+IHwgcmVxdWlyZWQ6Cj4g
PiA+IHwgICAtIGNvbXBhdGlibGUKPiA+ID4gQW5kIGl0IG9ubHkgbWF0dGVycyBoZXJlIGJlY2F1
c2UgYW4gaXRlbSBpcyBpbmplY3RlZCBtaWQtbGlzdC4gSWYgdGhpcwo+ID4gPiB3YXMgbW92ZWQg
dG8gdGhlIGVuZCB3aXRoIHRoZSBSWEQgZGVsYXksIHRoZSAqKmR0LWJpbmRpbmcqKiBjaGFuZ2Vz
Cj4gPiA+IGRvbid0IGhhdmUgaXNzdWVzIHdpdGggc2FmZXR5LiBJJ3ZlIG5vdCBsb29rZWQgYXQg
d2hldGhlciB0aGVyZSBhcmUKPiA+ID4ga25vY2stb24gY29uY2VybnMgYWJvdXQgdXNlcnMgaW4g
dGhlIGRyaXZlciBvciB3aGF0ZXZlciB5ZXQsIGJ1dCBmcm9tIGEKPiA+ID4gYmluZGluZyBQT1Yg
b25seSB0aGF0IGh1bmsgY2FuIGJyZWFrIHNvbWV0aGluZyB0aGF0IGN1cnJlbnRseSB3b3Jrcy4K
PiA+IAo+ID4gVGhpcyB3YXMgYWxyZWFkeSBkaXNjdXNzZWQgaGVyZSBpbiB2MToKPiA+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvZTcxODNhZTEtOGI4Yi00ZTc3LTlmNGUtM2JjMWI0YjYz
NTU2QGx1bm4uY2gvCj4gPiAKPiA+IFRoZSBkZXZpY2UtdHJlZSBpcyBub3QgY2hlY2tlZCBpbiB5
ZXQgYnkgRVNXSU4gZm9sa3MsIHNvIHRoZXJlJ3MgY3VycmVudGx5Cj4gPiBubyB1c2VyIG9mIHRo
ZSBkdC1iaW5kaW5nLiBObyBuZWVkIHRvIHdvcnJ5IGFib3V0IGJhY2t3YXJkIGNvbXBhdC4KPiAK
PiBUaGUgYmluZGluZyBhbmQgZHJpdmVyIGV4aXN0LCB0aGVyZSBkb2Vzbid0IG5lZWQgdG8gYmUg
YSBkdHMgaW4gdHJlZSBmb3IKPiB0aGVyZSB0byBiZSBwb3RlbnRpYWwgdXNlcnMuIElmIHRoZSBi
cmVhayB3YXMgaW1wb3J0YW50IEkgbWlnaHQgbm90Cj4gY2FyZSwgYnV0IHRoaXMgc2VlbXMgdG8g
YmUgYSBncmF0dWl0b3VzIGJyZWFrLCBzaW5jZSB0aGUgbmV3IGl0ZW1zIGNvdWxkCj4gYmUgYWRk
ZWQgdG8gdGhlIGVuZCBvZiB0aGUgbGlzdCBhbmQgY29tcGF0aWJpbGl0eSBtYWludGFpbmVkIHdp
dGhvdXQKPiBpbmN1cnJpbmcgYW55IG1vcmUgZGlmZmljdWx0eSBmb3IgeW91LgoKSGkgQ29ub3Ig
YW5kIEtyenlzenRvZiwKClRoYW5rcyBmb3IgdGhlIHJldmlld3MuCgotIFRoZSBuZXh0IHBhdGNo
IHdpbGwgZml4IHRoZSBwcm9wZXJ0eSBvcmRlciB0byBhdm9pZCBhbnkgYnJlYWthZ2UKICB3aXRo
IGV4aXN0aW5nIERUIGJpbmRpbmdzLgoKLSBFdGgxIGRvZXMgaGF2ZSBhIHRpbWluZyBpc3N1ZSBp
biBzaWxpY29uLCBhcyBkaXNjdXNzZWQgaGVyZToKICBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
a21sLzMyYTFmODE0LjJjNzkuMTliZmUxNzMyMjUuQ29yZW1haWwubGlubWluQGVzd2luY29tcHV0
aW5nLmNvbS8KCsKgIEJhc2VkIG9uIHRoaXMsIGFuZCBhY2NvcmRpbmcgdG8gdGhlIGFkdmljZSBm
cm9tIEFuZHJldwogIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvNTljZWM2MTctMDE4OS00
ZGMzLWJjM2YtNjM0NjE1NWE2MmFlQGx1bm4uY2gvCiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC9iZDIwMmNmYS1kNmViLTRkMGUtOTgyZC1iNDk3OTVkZDI1ZjdAbHVubi5jaC8KwqAgYWRk
aW5nIGEgRFQgcHJvcGVydHkgaXMgbm90IGEgcmVhc29uYWJsZSBhcHByb2FjaC4KwqDCoArCoCBJ
biB0aGUgbmV4dCBwYXRjaCwgSSB3aWxsIGltcHJvdmUgdGhlIGRlc2NyaXB0aW9uL3BhcmFncmFw
aCBhbmQgcHJvcGVybHkKICBkb2N1bWVudCB0aGUgdGltaW5nIGlzc3Vlcy4KwqDCoArCoCBEbyB5
b3UgdGhpbmsgdGhpcyBpcyBva2F5PwoKQmVzdCByZWdhcmRzLApaaGkgTGkK

