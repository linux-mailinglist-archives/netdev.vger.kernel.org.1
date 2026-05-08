Return-Path: <netdev+bounces-285661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCidI6V6/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:54:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D434F2239
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C6E33029C1C
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3049D371D16;
	Fri,  8 May 2026 05:48:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A8636212F;
	Fri,  8 May 2026 05:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778219305; cv=none; b=P4Vrjqs6WcGrDJmOB22QSrb8p5pqpniOUuf5yksXphqGjFDq6KwOdNXiqJKaHK2/XZmd5O/4MgbJhLLm+jMScn0QGaAZN3akcSsdOcFfOZQzY/8/3nKfHuB6ia0k1AJ4I1TC3RD1IubmuSO1I4cQVFi7CP0GwAzPk9qWrjYiB9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778219305; c=relaxed/simple;
	bh=0W/wBVAObQwwCcBVl6ZH+DTU1kffvaLDQmTAhORcktw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=tNA7BgR+j54reCuL8ymRokrQfbGcRKWO0Zb6dtMkCVzwvqKwrMEUSbg7Z+c7iqWUp1ABTc+E0aOzUol4Us5hoSYddyHWPZIv2vQlw+C7B4mfIX1nsak6+tkiiGgmZHSKppViL4ATrluydt61MFmOa72Ycy9lbcPL7qleF4szbVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Fri, 8 May 2026 13:47:31 +0800 (GMT+08:00)
Date: Fri, 8 May 2026 13:47:31 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: Re: [PATCH net v1 1/2] dt-bindings: ethernet: eswin: refine
 delay model and HSP register description
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <2436c6e9-4aad-4ffd-9fef-0cbbe38dc66d@lunn.ch>
References: <20260507083037.152-1-lizhi2@eswincomputing.com>
 <20260507083136.175-1-lizhi2@eswincomputing.com>
 <2436c6e9-4aad-4ffd-9fef-0cbbe38dc66d@lunn.ch>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1b38bce2.7d07.19e06207806.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TAJkCgBn_HDzeP1p2NgXAA--.6342W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAgEBDGn8vxER1gACsw
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Queue-Id: E8D434F2239
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285661-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_X_PRIO_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.882];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,st-md-mailman.stormreply.com,lists.infradead.org,eswincomputing.com,einfochips.com];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiQW5kcmV3IEx1bm4iIDxh
bmRyZXdAbHVubi5jaD4KPiDlj5HpgIHml7bpl7Q6MjAyNi0wNS0wNyAyMDoyOToxMCAo5pif5pyf
5ZubKQo+IOaUtuS7tuS6ujogbGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbQo+IOaKhOmAgTogYW5k
cmV3K25ldGRldkBsdW5uLmNoLCBkYXZlbUBkYXZlbWxvZnQubmV0LCBlZHVtYXpldEBnb29nbGUu
Y29tLCBrdWJhQGtlcm5lbC5vcmcsIHBhYmVuaUByZWRoYXQuY29tLCByb2JoQGtlcm5lbC5vcmcs
IGtyemsrZHRAa2VybmVsLm9yZywgY29ub3IrZHRAa2VybmVsLm9yZywgbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZywgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcsIG1jb3F1ZWxpbi5zdG0zMkBnbWFpbC5jb20sIGFsZXhhbmRyZS50b3JndWVAZm9z
cy5zdC5jb20sIHJtaytrZXJuZWxAYXJtbGludXgub3JnLnVrLCBtYXhpbWUuY2hldmFsbGllckBi
b290bGluLmNvbSwgbGludXgtc3RtMzJAc3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbSwgbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnLCBuaW5neXVAZXN3aW5jb21wdXRpbmcu
Y29tLCBsaW5taW5AZXN3aW5jb21wdXRpbmcuY29tLCBwaW5rZXNoLnZhZ2hlbGFAZWluZm9jaGlw
cy5jb20sIHByaXRlc2gucGF0ZWxAZWluZm9jaGlwcy5jb20sIHdlaXNoYW5nanVhbkBlc3dpbmNv
bXB1dGluZy5jb20KPiDkuLvpopg6IFJlOiBbUEFUQ0ggbmV0IHYxIDEvMl0gZHQtYmluZGluZ3M6
IGV0aGVybmV0OiBlc3dpbjogcmVmaW5lIGRlbGF5IG1vZGVsIGFuZCBIU1AgcmVnaXN0ZXIgZGVz
Y3JpcHRpb24KPiAKPiA+ICAgICAgZXRoZXJuZXRANTA0MDAwMDAgewo+ID4gICAgICAgICAgY29t
cGF0aWJsZSA9ICJlc3dpbixlaWM3NzAwLXFvcy1ldGgiLCAic25wcyxkd21hYy01LjIwIjsKPiA+
ICAgICAgICAgIHJlZyA9IDwweDUwNDAwMDAwIDB4MTAwMDA+Owo+ID4gLSAgICAgICAgY2xvY2tz
ID0gPCZkMF9jbG9jayAxODY+LCA8JmQwX2Nsb2NrIDE3MT4sIDwmZDBfY2xvY2sgNDA+LAo+ID4g
LSAgICAgICAgICAgICAgICA8JmQwX2Nsb2NrIDE5Mz47Cj4gPiAtICAgICAgICBjbG9jay1uYW1l
cyA9ICJheGkiLCAiY2ZnIiwgInN0bW1hY2V0aCIsICJ0eCI7Cj4gPiAgICAgICAgICBpbnRlcnJ1
cHQtcGFyZW50ID0gPCZwbGljPjsKPiA+ICAgICAgICAgIGludGVycnVwdHMgPSA8NjE+Owo+ID4g
ICAgICAgICAgaW50ZXJydXB0LW5hbWVzID0gIm1hY2lycSI7Cj4gPiAtICAgICAgICBwaHktbW9k
ZSA9ICJyZ21paS1pZCI7Cj4gPiAtICAgICAgICBwaHktaGFuZGxlID0gPCZwaHkwPjsKPiA+ICsg
ICAgICAgIGNsb2NrcyA9IDwmZDBfY2xvY2sgMTg2PiwgPCZkMF9jbG9jayAxNzE+LCA8JmQwX2Ns
b2NrIDQwPiwKPiA+ICsgICAgICAgICAgICAgICAgPCZkMF9jbG9jayAxOTM+Owo+ID4gKyAgICAg
ICAgY2xvY2stbmFtZXMgPSAiYXhpIiwgImNmZyIsICJzdG1tYWNldGgiLCAidHgiOwo+IAo+IFBs
ZWFzZSBkb24ndCBtb3ZlIHRoZSBjbG9ja3MgYXJvdW5kLCBzaW5jZSB0aGV5IGhhdmUgbm90aGlu
ZyB0byBkbwo+IHdpdGggUkdNSUkgZGVsYXlzLgo+IAo+IAo+ID4gICAgICAgICAgcmVzZXRzID0g
PCZyZXNldCA5NT47Cj4gPiAgICAgICAgICByZXNldC1uYW1lcyA9ICJzdG1tYWNldGgiOwo+ID4g
LSAgICAgICAgcngtaW50ZXJuYWwtZGVsYXktcHMgPSA8MjAwPjsKPiA+IC0gICAgICAgIHR4LWlu
dGVybmFsLWRlbGF5LXBzID0gPDIwMD47Cj4gPiAtICAgICAgICBlc3dpbixoc3Atc3AtY3NyID0g
PCZoc3Bfc3BfY3NyIDB4MTAwIDB4MTA4IDB4MTE4PjsKPiA+IC0gICAgICAgIHNucHMsYXhpLWNv
bmZpZyA9IDwmc3RtbWFjX2F4aV9zZXR1cD47Cj4gPiArICAgICAgICBlc3dpbixoc3Atc3AtY3Ny
ID0gPCZoc3Bfc3BfY3NyIDB4MTAwIDB4MTA4IDB4MTE4IDB4MTE0IDB4MTFjPjsKPiA+ICsgICAg
ICAgIHBoeS1oYW5kbGUgPSA8JnBoeTA+Owo+ID4gKyAgICAgICAgcGh5LW1vZGUgPSAicmdtaWkt
aWQiOwo+ID4gICAgICAgICAgc25wcyxhYWw7Cj4gPiAgICAgICAgICBzbnBzLGZpeGVkLWJ1cnN0
Owo+ID4gICAgICAgICAgc25wcyx0c287Cj4gPiAtICAgICAgICBzdG1tYWNfYXhpX3NldHVwOiBz
dG1tYWMtYXhpLWNvbmZpZyB7Cj4gPiArICAgICAgICBzbnBzLGF4aS1jb25maWcgPSA8JnN0bW1h
Y19heGlfc2V0dXBfZ21hYzA+Owo+ID4gKwo+ID4gKyAgICAgICAgc3RtbWFjX2F4aV9zZXR1cF9n
bWFjMDogc3RtbWFjLWF4aS1jb25maWcgewo+IAo+IEFuZCB3aGF0IGRvIHRoZXNlIGNoYW5nZXMg
aGF2ZSB0byBkbyB3aXRoIFJHTUlJIGRlbGF5cz8KPiAKCllvdSdyZSByaWdodCwgdGhvc2UgdW5y
ZWxhdGVkIGV4YW1wbGUgY2hhbmdlcyBzaG91bGQgbm90IGJlIG1peGVkIGludG8gdGhlCmZpeC1y
ZWxhdGVkIGJpbmRpbmcgdXBkYXRlLgoKSSB3aWxsIGxpbWl0IHRoZSBiaW5kaW5nIGNoYW5nZXMg
dG8gb25seSB3aGF0IGlzIHJlcXVpcmVkIGZvciB0aGUgZml4ZXMsCnN1Y2ggYXMgdGhlIGFkZGl0
aW9uYWwgSFNQIENTUiBvZmZzZXRzIG5lZWRlZCBmb3IgZXhwbGljaXQgVFhEL1JYRCBkZWxheQpy
ZWdpc3RlciBpbml0aWFsaXphdGlvbiwgYW5kIGRyb3AgdGhlIHVucmVsYXRlZCBEVFMgZXhhbXBs
ZSByZW9yZGVyaW5nIG9yCmNsZWFudXAgY2hhbmdlcyBmcm9tIHRoaXMgc2VyaWVzLgo=

