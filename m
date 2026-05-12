Return-Path: <netdev+bounces-286956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PzoILHEAmp7wQEAu9opvQ
	(envelope-from <netdev+bounces-286956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:12:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DDE51AC04
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE8D831F3104
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 05:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CF53D47DB;
	Tue, 12 May 2026 05:40:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEDC3D1CD5;
	Tue, 12 May 2026 05:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564411; cv=none; b=S5mDksGQBNgMJCVvVXndIqN4s+qB97hdggvG2z08A1wpZ2hfYwe5UZLq+Szu0WQqx8qZ9akX2rPd69iLVk7U/56YWf826pWuufZzRz5C+TPxa3KgqN+95vPiCLlvtTCPMiEJbpASZ3lXobV759NzCsAVx1bUUWm63pTGKzltO2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564411; c=relaxed/simple;
	bh=VLL9ELTYpl2Z/PtV5ezkA3tdcxmAf+VSreORf7yQztY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=fiO2nN9SpDoduwoAmOXmeJzKxjmaCuDI2FCATLbcuzKZwGPxwJNJu4oXMOUx6e4uVyqjmpB6CDzN/Tv+CFVuQrHfIfyqMinyWZAbcg8IcpBTUoTPEaB5s9T7RyTDaxQSNQzjLUrIxcjn380ON4R9sSp+SmMv8WAjqQlj6d2skgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Tue, 12 May 2026 13:39:12 +0800 (GMT+08:00)
Date: Tue, 12 May 2026 13:39:12 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, devicetree@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com,
	horms@kernel.org
Subject: Re: Re: Re: [PATCH net-next v7 2/4] net: stmmac: eic7700: enable
 clocks before syscon access and correct RX sampling timing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <38d052b7.7a70.19dfb0d782b.Coremail.lizhi2@eswincomputing.com>
References: <20260427072353.1114-1-lizhi2@eswincomputing.com>
 <20260427072508.1151-1-lizhi2@eswincomputing.com>
 <20260428180625.738223cf@kernel.org>
 <2117464.7991.19ddd2125d1.Coremail.lizhi2@eswincomputing.com>
 <20260430163551.7491407a@kernel.org>
 <38d052b7.7a70.19dfb0d782b.Coremail.lizhi2@eswincomputing.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <446f69bd.7fe4.19e1ab248fb.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TAJkCgBnCXMAvQJqub8YAA--.6986W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAgEFDGoCBREW-AAAsc
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Queue-Id: D8DDE51AC04
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286956-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_X_PRIO_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,bootlin.com,eswincomputing.com,einfochips.com];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiDmnY7lv5cgPGxpemhpMkBl
c3dpbmNvbXB1dGluZy5jb20+Cj4gU2VuZCB0aW1lOldlZG5lc2RheSwgMDYvMDUvMjAyNiAxMDox
MDo1Nwo+IFRvOiAiSmFrdWIgS2ljaW5za2kiIDxrdWJhQGtlcm5lbC5vcmc+Cj4gQ2M6IGFuZHJl
dytuZXRkZXZAbHVubi5jaCwgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcsIGRhdmVtQGRhdmVt
bG9mdC5uZXQsIGVkdW1hemV0QGdvb2dsZS5jb20sIHJvYmhAa2VybmVsLm9yZywga3J6aytkdEBr
ZXJuZWwub3JnLCBjb25vcitkdEBrZXJuZWwub3JnLCBuZXRkZXZAdmdlci5rZXJuZWwub3JnLCBw
YWJlbmlAcmVkaGF0LmNvbSwgbWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbSwgYWxleGFuZHJlLnRv
cmd1ZUBmb3NzLnN0LmNvbSwgcm1rK2tlcm5lbEBhcm1saW51eC5vcmcudWssIHBqd0BrZXJuZWwu
b3JnLCBwYWxtZXJAZGFiYmVsdC5jb20sIGFvdUBlZWNzLmJlcmtlbGV5LmVkdSwgYWxleEBnaGl0
aS5mciwgbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZywgbGludXgtc3RtMzJAc3QtbWQt
bWFpbG1hbi5zdG9ybXJlcGx5LmNvbSwgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLCBtYXhpbWUuY2hldmFsbGllckBib290
bGluLmNvbSwgbmluZ3l1QGVzd2luY29tcHV0aW5nLmNvbSwgbGlubWluQGVzd2luY29tcHV0aW5n
LmNvbSwgcGlua2VzaC52YWdoZWxhQGVpbmZvY2hpcHMuY29tLCBwcml0ZXNoLnBhdGVsQGVpbmZv
Y2hpcHMuY29tLCB3ZWlzaGFuZ2p1YW5AZXN3aW5jb21wdXRpbmcuY29tLCBob3Jtc0BrZXJuZWwu
b3JnCj4gU3ViamVjdDogUmU6IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjcgMi80XSBuZXQ6IHN0bW1h
YzogZWljNzcwMDogZW5hYmxlIGNsb2NrcyBiZWZvcmUgc3lzY29uIGFjY2VzcyBhbmQgY29ycmVj
dCBSWCBzYW1wbGluZyB0aW1pbmcKPiAKPiAKPiAKPiAKPiA+IC0tLS0t5Y6f5aeL6YKu5Lu2LS0t
LS0KPiA+IOWPkeS7tuS6ujogIkpha3ViIEtpY2luc2tpIiA8a3ViYUBrZXJuZWwub3JnPgo+ID4g
5Y+R6YCB5pe26Ze0OjIwMjYtMDUtMDEgMDc6MzU6NTEgKOaYn+acn+S6lCkKPiA+IOaUtuS7tuS6
ujog5p2O5b+XIDxsaXpoaTJAZXN3aW5jb21wdXRpbmcuY29tPgo+ID4g5oqE6YCBOiBhbmRyZXcr
bmV0ZGV2QGx1bm4uY2gsIGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnLCBkYXZlbUBkYXZlbWxv
ZnQubmV0LCBlZHVtYXpldEBnb29nbGUuY29tLCByb2JoQGtlcm5lbC5vcmcsIGtyemsrZHRAa2Vy
bmVsLm9yZywgY29ub3IrZHRAa2VybmVsLm9yZywgbmV0ZGV2QHZnZXIua2VybmVsLm9yZywgcGFi
ZW5pQHJlZGhhdC5jb20sIG1jb3F1ZWxpbi5zdG0zMkBnbWFpbC5jb20sIGFsZXhhbmRyZS50b3Jn
dWVAZm9zcy5zdC5jb20sIHJtaytrZXJuZWxAYXJtbGludXgub3JnLnVrLCBwandAa2VybmVsLm9y
ZywgcGFsbWVyQGRhYmJlbHQuY29tLCBhb3VAZWVjcy5iZXJrZWxleS5lZHUsIGFsZXhAZ2hpdGku
ZnIsIGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcsIGxpbnV4LXN0bTMyQHN0LW1kLW1h
aWxtYW4uc3Rvcm1yZXBseS5jb20sIGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywgbWF4aW1lLmNoZXZhbGxpZXJAYm9vdGxp
bi5jb20sIG5pbmd5dUBlc3dpbmNvbXB1dGluZy5jb20sIGxpbm1pbkBlc3dpbmNvbXB1dGluZy5j
b20sIHBpbmtlc2gudmFnaGVsYUBlaW5mb2NoaXBzLmNvbSwgcHJpdGVzaC5wYXRlbEBlaW5mb2No
aXBzLmNvbSwgd2Vpc2hhbmdqdWFuQGVzd2luY29tcHV0aW5nLmNvbSwgaG9ybXNAa2VybmVsLm9y
Zwo+ID4g5Li76aKYOiBSZTogW1BBVENIIG5ldC1uZXh0IHY3IDIvNF0gbmV0OiBzdG1tYWM6IGVp
Yzc3MDA6IGVuYWJsZSBjbG9ja3MgYmVmb3JlIHN5c2NvbiBhY2Nlc3MgYW5kIGNvcnJlY3QgUlgg
c2FtcGxpbmcgdGltaW5nCj4gPiAKPiA+IE9uIFRodSwgMzAgQXByIDIwMjYgMTQ6NDM6NTAgKzA4
MDAgKEdNVCswODowMCkg5p2O5b+XIHdyb3RlOgo+ID4gPiA+IFdoeSBGaXhlcz8gSWYgZXRoMSBu
ZXZlciB3b3JrZWQgdGhpcyBpcyBub3QgYSBmaXggYnV0IG5ldyBmdW5jdGlvbmFsaXR5Cj4gPiA+
ID4gSWYgeW91IHdhbnQgdG8gbWFrZSB0aGlzIGEgZml4IHRvIHByZXZlbnQgaW5jb21wYXRpYmls
aXR5IC0gY3V0IGl0IGRvd24KPiA+ID4gPiBqdXN0IHRvIHRoZSBldGgwIGNoYW5nZXMuCj4gPiA+
ID4gICAKPiA+ID4gVGhhbmsgeW91IGZvciB0aGUgc3VnZ2VzdGlvbi4KPiA+ID4gCj4gPiA+IFlv
dSdyZSByaWdodCB0aGF0IGV0aDEgbmV2ZXIgd29ya2VkIGF0IEdpZ2FiaXQgc3BlZWQsIHNvIHRo
aXMgc2hvdWxkCj4gPiA+IG5vdCBiZSB0cmVhdGVkIGFzIGEgZml4Lgo+ID4gPiAKPiA+ID4gSW4g
djgsIEkgd2lsbCBzcGxpdCB0aGUgY2hhbmdlcyBpbnRvIHR3byBwYXRjaGVzIHdpdGhpbiB0aGUg
c2FtZSBzZXJpZXM6Cj4gPiA+IC0gUGF0Y2ggMSB3aWxsIGNvbnRhaW4gb25seSB0aGUgZml4ZXMg
YWZmZWN0aW5nIHRoZSBleGlzdGluZyBldGgwCj4gPiA+IGZ1bmN0aW9uYWxpdHksIGFuZCB3aWxs
IGtlZXAgdGhlIEZpeGVzIHRhZy4KPiA+ID4gLSBQYXRjaCAyIHdpbGwgYWRkIHRoZSBldGgxIHN1
cHBvcnQgKFJYIGNsb2NrIGludmVyc2lvbiB3b3JrYXJvdW5kKQo+ID4gPiBhcyBuZXcgZnVuY3Rp
b25hbGl0eSwgd2l0aG91dCBhIEZpeGVzIHRhZy4KPiA+ID4gCj4gPiA+IFBsZWFzZSBsZXQgbWUg
a25vdyBpZiB5b3Ugd291bGQgcHJlZmVyIGEgZGlmZmVyZW50IHNwbGl0IG9yIG9yZGVyaW5nLgo+
ID4gCj4gPiBJZiB5b3Ugd2FudCB0byBjb25zaWRlciBzb21lIHBhcnQgb2YgdGhpcyBjb21taXQg
YSBmaXggaXQgaGFzIHRvIGJlCj4gPiBwb3N0ZWQgc2VwYXJhdGVseSB0byB0aGUgbmV0IHRyZWUg
KHJhdGhlciB0aGFuIG5ldC1uZXh0KS4KPiA+IE9uY2UgaXQncyBtZXJnZWQgYW5kIG1ha2VzIGl0
IHdheSBvdmVyIHRvIHRoZSBuZXQtbmV4dCB0cmVlIChlYWNoCj4gPiBUaHVyc2RheSkgeW91IGNh
biBwb3N0IHRoZSBuZXQtbmV4dCBjaG5hZ2VzIGZvciBldGgxCj4gCj4gVGhhbmtzLCB1bmRlcnN0
b29kLgo+IAo+IEkgd2lsbCBzcGxpdCB0aGUgY2hhbmdlcyBhY2NvcmRpbmdseToKPiAtIFNlbmQg
dGhlIGV0aDAgZml4ZXMgYXMgYSBuZXcgdjEgc2VyaWVzIHRhcmdldGluZyBuZXQuCj4gLSBTZW5k
IHRoZSBldGgxIGVuYWJsZW1lbnQgYXMgYSBuZXcgdjEgc2VyaWVzIHRhcmdldGluZyBuZXQtbmV4
dC4KPiAKPiBUaGFua3MgZm9yIHRoZSBndWlkYW5jZS4KCkhpIEpha3ViLAoKSnVzdCB0byBjb25m
aXJtIHRoZSB2ZXJzaW9uaW5nIGZvciB0aGUgZXRoMSBwYXJ0IGFmdGVyIHNwbGl0dGluZyB0aGUK
b3JpZ2luYWwgdjcvdjggc2VyaWVzOgoKRm9yIHRoZSBuZXQgZml4IHBhcnQsIEkgaGF2ZSBhbHJl
YWR5IHBvc3RlZCBpdCBhcyBhIG5ldyB2MSBzZXJpZXMKdGFyZ2V0aW5nIG5ldC4KCkZvciB0aGUg
ZXRoMSBlbmFibGVtZW50IHBhcnQsIG15IGN1cnJlbnQgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGl0
CnNob3VsZCBiZSB0cmVhdGVkIGFzIGEgbmV3IGluZGVwZW5kZW50IHYxIHNlcmllcyBmb3IgbmV0
LW5leHQsCnNpbmNlIHRoZSBzY29wZSBhbmQgdGFyZ2V0IHRyZWUgaGF2ZSBjaGFuZ2VkIGFmdGVy
IHRoZSBzcGxpdC4KCldvdWxkIHlvdSBwcmVmZXIgdGhpcyBldGgxIHNlcmllcyB0byBzdGFydCBh
cyB2MSwgb3Igc2hvdWxkIGl0CmNvbnRpbnVlIGFzIHY4IGZvciBjb250aW51aXR5IHdpdGggdGhl
IG9yaWdpbmFsIHNlcmllcz8KCkkgd2lsbCBmb2xsb3cgeW91ciBwcmVmZXJyZWQgYXBwcm9hY2gg
YmVmb3JlIHBvc3RpbmcgaXQuCgpUaGFua3MsClpoaQo=

