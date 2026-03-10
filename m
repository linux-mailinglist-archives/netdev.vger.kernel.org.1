Return-Path: <netdev+bounces-265899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIs1AE3Fr2nWcAIAu9opvQ
	(envelope-from <netdev+bounces-265899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:16:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB4F246317
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 141193024933
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 07:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3183BFE2B;
	Tue, 10 Mar 2026 07:16:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1390F175A80;
	Tue, 10 Mar 2026 07:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773126986; cv=none; b=OzPDpu53WraUlw860anBQb3AaLiQ0y4KIlUDW5xjyytzhwxjVDX/4OB65T4zDJaUtnuenA11/xq6ACBuvum//hopgbznJ9+VkM2nVwz1cSlFWp2uMqGh/Zjo+p5My4Rh2VrAGC1etaVaW6Uev9oZfJcuNc9jx+AVeCtRN7ol+cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773126986; c=relaxed/simple;
	bh=adVdp0CWnInaiA8SkZvdYfPWJFxylLonnt+wV3B403o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=N+qFUIQH7S7ybVFyac7BAxuq7Q55+WWN1XBn1u1bDWg2KMbwK07sdd42QaA/fSV4RiSFTKX+TpNC4rxFp+Gxcmqo7dwulsA1sgTMyW6xKCWPuHS546xCGDOZGO0+evQbmXcJ8LCtsrkkQ/SwiASVzbaV5DoylltqHIM0dosZ5LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Tue, 10 Mar 2026 15:15:40 +0800 (GMT+08:00)
Date: Tue, 10 Mar 2026 15:15:40 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Yao Zi" <me@ziyao.cc>
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	wens@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com
Subject: Re: Re: [PATCH net-next v3 3/3] riscv: dts: eswin:
 eic7700-hifive-premier-p550: enable Ethernet controller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <aaa4xodVNaY0gmBA@pie>
References: <20260303061525.846-1-lizhi2@eswincomputing.com>
 <20260303061732.918-1-lizhi2@eswincomputing.com> <aaa4xodVNaY0gmBA@pie>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <408e45b4.51a4.19cd699f60e.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TAJkCgDHaXMcxa9pRCIHAA--.2221W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAQECDGmu9hMT1QABsr
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Queue-Id: 9FB4F246317
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265899-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_X_PRIO_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.960];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,eswincomputing.com,einfochips.com];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiWWFvIFppIiA8bWVAeml5
YW8uY2M+Cj4g5Y+R6YCB5pe26Ze0OjIwMjYtMDMtMDMgMTg6MzI6MzggKOaYn+acn+S6jCkKPiDm
lLbku7bkuro6IGxpemhpMkBlc3dpbmNvbXB1dGluZy5jb20sIGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnLCBhbmRyZXcrbmV0ZGV2QGx1bm4uY2gsIGRhdmVtQGRhdmVtbG9mdC5uZXQsIGVkdW1h
emV0QGdvb2dsZS5jb20sIGt1YmFAa2VybmVsLm9yZywgcm9iaEBrZXJuZWwub3JnLCBrcnprK2R0
QGtlcm5lbC5vcmcsIGNvbm9yK2R0QGtlcm5lbC5vcmcsIG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcs
IHBhYmVuaUByZWRoYXQuY29tLCBtY29xdWVsaW4uc3RtMzJAZ21haWwuY29tLCBhbGV4YW5kcmUu
dG9yZ3VlQGZvc3Muc3QuY29tLCBybWsra2VybmVsQGFybWxpbnV4Lm9yZy51aywgd2Vuc0BrZXJu
ZWwub3JnLCBwandAa2VybmVsLm9yZywgcGFsbWVyQGRhYmJlbHQuY29tLCBhb3VAZWVjcy5iZXJr
ZWxleS5lZHUsIGFsZXhAZ2hpdGkuZnIsIGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcs
IGxpbnV4LXN0bTMyQHN0LW1kLW1haWxtYW4uc3Rvcm1yZXBseS5jb20sIGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+IOaK
hOmAgTogbmluZ3l1QGVzd2luY29tcHV0aW5nLmNvbSwgbGlubWluQGVzd2luY29tcHV0aW5nLmNv
bSwgcGlua2VzaC52YWdoZWxhQGVpbmZvY2hpcHMuY29tLCBwcml0ZXNoLnBhdGVsQGVpbmZvY2hp
cHMuY29tLCB3ZWlzaGFuZ2p1YW5AZXN3aW5jb21wdXRpbmcuY29tCj4g5Li76aKYOiBSZTogW1BB
VENIIG5ldC1uZXh0IHYzIDMvM10gcmlzY3Y6IGR0czogZXN3aW46IGVpYzc3MDAtaGlmaXZlLXBy
ZW1pZXItcDU1MDogZW5hYmxlIEV0aGVybmV0IGNvbnRyb2xsZXIKPiAKPiBPbiBUdWUsIE1hciAw
MywgMjAyNiBhdCAwMjoxNzozMlBNICswODAwLCBsaXpoaTJAZXN3aW5jb21wdXRpbmcuY29tIHdy
b3RlOgo+ID4gRnJvbTogWmhpIExpIDxsaXpoaTJAZXN3aW5jb21wdXRpbmcuY29tPgo+ID4gCj4g
PiBFbmFibGUgdGhlIG9uLWJvYXJkIEdpZ2FiaXQgRXRoZXJuZXQgY29udHJvbGxlciBvbiB0aGUK
PiA+IEhpRml2ZSBQcmVtaWVyIFA1NTAgZGV2ZWxvcG1lbnQgYm9hcmQuCj4gPiAKPiA+IFNpZ25l
ZC1vZmYtYnk6IFpoaSBMaSA8bGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbT4KPiA+IC0tLQo+ID4g
IC4uLi9kdHMvZXN3aW4vZWljNzcwMC1oaWZpdmUtcHJlbWllci1wNTUwLmR0cyB8IDUwICsrKysr
KysrKysrKysrKysrCj4gPiAgYXJjaC9yaXNjdi9ib290L2R0cy9lc3dpbi9laWM3NzAwLmR0c2kg
ICAgICAgIHwgNTQgKysrKysrKysrKysrKysrKysrKwo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTA0
IGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMv
ZXN3aW4vZWljNzcwMC1oaWZpdmUtcHJlbWllci1wNTUwLmR0cyBiL2FyY2gvcmlzY3YvYm9vdC9k
dHMvZXN3aW4vZWljNzcwMC1oaWZpdmUtcHJlbWllci1wNTUwLmR0cwo+ID4gaW5kZXggMTMxZWQx
ZmM2YjJlLi5kNTU4ZjBmZGZiMzggMTAwNjQ0Cj4gPiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3QvZHRz
L2Vzd2luL2VpYzc3MDAtaGlmaXZlLXByZW1pZXItcDU1MC5kdHMKPiA+ICsrKyBiL2FyY2gvcmlz
Y3YvYm9vdC9kdHMvZXN3aW4vZWljNzcwMC1oaWZpdmUtcHJlbWllci1wNTUwLmR0cwo+IAo+IC4u
Lgo+IAo+ID4gQEAgLTIwLDYgKzIyLDU0IEBAIGNob3NlbiB7Cj4gPiAgCX07Cj4gPiAgfTsKPiA+
ICAKPiA+ICsmZ21hYzAgewo+ID4gKwlwaHktaGFuZGxlID0gPCZnbWFjMF9waHkwPjsKPiA+ICsJ
cGh5LW1vZGUgPSAicmdtaWktaWQiOwo+ID4gKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOwo+
ID4gKwlwaW5jdHJsLTAgPSA8JmdwaW8xMDZfcGlucz47Cj4gPiArCXJ4LWludGVybmFsLWRlbGF5
LXBzID0gPDIwPjsKPiA+ICsJdHgtaW50ZXJuYWwtZGVsYXktcHMgPSA8MTAwPjsKPiA+ICsJc3Rh
dHVzID0gIm9rYXkiOwo+ID4gKwo+ID4gKwltZGlvIHsKPiA+ICsJCWNvbXBhdGlibGUgPSAic25w
cyxkd21hYy1tZGlvIjsKPiAKPiBTaW5jZSBpdCdzIGltcGxlbWVudGVkIGluIHRoZSBEV01BQyBJ
UCwgSSB0aGluayB0aGUgbWRpbyBidXMgaXMKPiBTb0Mtc3BlY2lmaWMgYW5kIHNob3VsZCBiZSBw
dXQgaW50byB0aGUgU29DIGRldmljZXRyZWUgaW5zdGVhZC4KPiAKCkhpIFlhbyBaaSwKClRoYW5r
cyBmb3IgdGhlIHJldmlldy4KCllvdSdyZSByaWdodCB0aGF0IHRoZSBNRElPIGJ1cyBpcyBpbXBs
ZW1lbnRlZCBhcyBwYXJ0IG9mIHRoZSBEV01BQyBJUCBhbmQKaXMgdGhlcmVmb3JlIFNvQy1zcGVj
aWZpYy4gSXQgbWFrZXMgbW9yZSBzZW5zZSB0byBkZXNjcmliZSB0aGUgTURJTwpjb250cm9sbGVy
IGluIHRoZSBTb0MgZHRzaS4KCkknbGwgbW92ZSB0aGUgTURJTyBub2RlIHRvIGVpYzc3MDAuZHRz
aSBhbmQga2VlcCBvbmx5IHRoZSBQSFkgbm9kZSBpbiB0aGUKYm9hcmQgZHRzIGluIHRoZSBuZXh0
IHJldmlzaW9uLgoKVGhhbmtzLApaaGkgTGkK

