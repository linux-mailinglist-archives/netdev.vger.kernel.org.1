Return-Path: <netdev+bounces-261162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE/AKRa8n2ktdgQAu9opvQ
	(envelope-from <netdev+bounces-261162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:20:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9141A0754
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A45A7301B7B7
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D816311C38;
	Thu, 26 Feb 2026 03:20:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CAB285CB4;
	Thu, 26 Feb 2026 03:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076052; cv=none; b=fYH7fupfgyf+lRPuEdQc2fEGmKqK1cjZxnqKbHZMFsM8rTLyWXQnAjoZjV3TVVTyoc+j5O4WV+MPcKLqiyhoG2aXlhrTxTgfHrdb5Y3XWtWBxWoHmTFnX/GkZCrENQzC7T2xydcf5VJLMqGvuzcYGzXKLd/xeujVrme8RjCxb6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076052; c=relaxed/simple;
	bh=N9pzA0KKk9pAydgPApXyHsI9MmCEVWk3nfMnXSs0C2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=bbGl9Nn+ygRFw3/3znaAqjxelVUxlsjunu16YgL5CJjY8zJSYedZdFpsej2CVZ50aDRq2qdR9Vr/szFi3SAc7x/zqxo7fc0HM5yHNEtScjiAv98wP4hpPhl/XHC4iftUEkDri0L7pTNeuBXIFuKxysSqEHE8TwehyP+u3STrQ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Thu, 26 Feb 2026 11:20:02 +0800 (GMT+08:00)
Date: Thu, 26 Feb 2026 11:20:02 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Marcel Ziswiler" <marcel@ziswiler.com>
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com,
	dongxuyang@eswincomputing.com, ganboing@gmail.com,
	pritesh.patel@einfochips.com
Subject: Re: Re: [PATCH v2 0/2] net: stmmac: eic7700: fix EIC7700 eth1 RX
 sampling timing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <5f99968ec561631852bfa72aea95a100dcad5324.camel@ziswiler.com>
References: <20260209094628.886-1-lizhi2@eswincomputing.com>
 <5f99968ec561631852bfa72aea95a100dcad5324.camel@ziswiler.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6137cd6a.4859.19c97f5eb67.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TAJkCgBn_HDiu59pn6YDAA--.351W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAgEKDGmfJIYS1AAAsX
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
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
	TAGGED_FROM(0.00)[bounces-261162-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_X_PRIO_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.598];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,st-md-mailman.stormreply.com,lists.infradead.org,eswincomputing.com,einfochips.com];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F9141A0754
X-Rspamd-Action: no action

SGkgTWFyY2VsLAoKVGhhbmtzIGZvciBzaGFyaW5nIHRoZSBkZXRhaWxzLgoKMS4gSSBjaGVja2Vk
IHlvdXIgbG9nIGFuZCBub3RpY2VkIHRoYXQgdGhlIGtlcm5lbCBjbWRsaW5lIGFscmVhZHkgaW5j
bHVkZXMKICAgImNsa19pZ25vcmVfdW51c2VkIi4gVGhlcmVmb3JlLCB5b3VyIGlzc3VlIGRvZXMg
bm90IGFwcGVhciB0byBiZSB0aGUKICAgc2FtZSBhcyB0aGUgb25lIHByZXZpb3VzbHkgcmVwb3J0
ZWQgYnkgQm8gR2FuLgoKMi4gSSBhbHNvIHZlcmlmaWVkIHRoYXQgdjYuMTkuMiBhbHJlYWR5IGNv
bnRhaW5zIHRoZSB0d28gZU1NQyBmaXggcGF0Y2hlczoKICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYWxsL0NBUER5S0ZxY015TS09eCsyRldOTGhIWT1ndTVBcEhOUFFocDB4QktESkdyN0JoRXg0
UUBtYWlsLmdtYWlsLmNvbS8KICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBUER5S0Zy
a0VaRHVNYkdwZnhpc21jeD12SmtTU0tfWGJ0Qjc2MitzVUZvY3VwVDYzd0BtYWlsLmdtYWlsLmNv
bS8KCiAgIEEgbGlrZWx5IGNhdXNlIGlzIHRoYXQgdGhlIGVNTUMgRFRTIG5vZGUgaXMgbWlzc2lu
ZyB0aGUgQVhJIGNsb2NrIGRlZmluaXRpb24uCiAgIFBsZWFzZSByZWZlciB0byB0aGUgRFRTIHVw
ZGF0ZXMgaW4gdGhlIGZvbGxvd2luZyBwdWxsIHJlcXVlc3QgZm9yIHJlZmVyZW5jZToKICAgaHR0
cHM6Ly9naXRodWIuY29tL2Vzd2luY29tcHV0aW5nL2xpbnV4LW5leHQvcHVsbC8yMAoKMy4gSW4g
YWRkaXRpb24sIHBsZWFzZSBjaGVjayB3aGV0aGVyIENPTkZJR19HUElPX0RXQVBCPXkgaXMgZW5h
YmxlZCBpbiB5b3VyCiAgIGtlcm5lbCBjb25maWd1cmF0aW9uLiBTaW5jZSBHTUFDIGlzIGJ1aWx0
LWluIGJ5IGRlZmF1bHQsIGl0IGRlcGVuZHMgb24KICAgR1BJTyBiZWluZyBhdmFpbGFibGUgZHVy
aW5nIGVhcmx5IGluaXRpYWxpemF0aW9uLgoKSG9wZSB0aGlzIGhlbHBzIG5hcnJvdyB0aGluZ3Mg
ZG93bi4gUGxlYXNlIGxldCBtZSBrbm93IHdoYXQgeW91IGZpbmQuCgpCZXN0IHJlZ2FyZHMsClpo
aSBMaQoKCj4gLS0tLS3ljp/lp4vpgq7ku7YtLS0tLQo+IOWPkeS7tuS6ujogIk1hcmNlbCBaaXN3
aWxlciIgPG1hcmNlbEB6aXN3aWxlci5jb20+Cj4g5Y+R6YCB5pe26Ze0OjIwMjYtMDItMjEgMDI6
Mzc6NTcgKOaYn+acn+WFrSkKPiDmlLbku7bkuro6IGxpemhpMkBlc3dpbmNvbXB1dGluZy5jb20s
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnLCBhbmRyZXcrbmV0ZGV2QGx1bm4uY2gsIGRhdmVt
QGRhdmVtbG9mdC5uZXQsIGVkdW1hemV0QGdvb2dsZS5jb20sIGt1YmFAa2VybmVsLm9yZywgcm9i
aEBrZXJuZWwub3JnLCBrcnprK2R0QGtlcm5lbC5vcmcsIGNvbm9yK2R0QGtlcm5lbC5vcmcsIG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmcsIHBhYmVuaUByZWRoYXQuY29tLCBtY29xdWVsaW4uc3RtMzJA
Z21haWwuY29tLCBhbGV4YW5kcmUudG9yZ3VlQGZvc3Muc3QuY29tLCBybWsra2VybmVsQGFybWxp
bnV4Lm9yZy51aywgbGludXgtc3RtMzJAc3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbSwgbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnCj4g5oqE6YCBOiBuaW5neXVAZXN3aW5jb21wdXRpbmcuY29tLCBsaW5taW5AZXN3aW5j
b21wdXRpbmcuY29tLCBwaW5rZXNoLnZhZ2hlbGFAZWluZm9jaGlwcy5jb20sIHdlaXNoYW5nanVh
bkBlc3dpbmNvbXB1dGluZy5jb20sIGRvbmd4dXlhbmdAZXN3aW5jb21wdXRpbmcuY29tCj4g5Li7
6aKYOiBSZTogW1BBVENIIHYyIDAvMl0gbmV0OiBzdG1tYWM6IGVpYzc3MDA6IGZpeCBFSUM3NzAw
IGV0aDEgUlggc2FtcGxpbmcgdGltaW5nCj4gCj4gSGkgWmhpIExpCj4gCj4gU29ycnksIHRvIHN0
ZWFsIHRoaXMgdGhyZWFkLCBidXQgSSBkbyBoYXZlIGEgcXVpY2sgcXVlc3Rpb24gY29uY2Vybmlu
ZyBFdGhlcm5ldCBvbiB0aGUgRUlDNzcwMC4gRXZlcnkgdGltZSBJCj4gZW5hYmxlIGdtYWMwIGlu
IHRoZSBkZXZpY2UgdHJlZSBteSBFQkM3NzAwIHN0b3BzIGJvb3RpbmcgKGUuZy4gU0QgY2FyZCBp
cyBubyBsb25nZXIgZGV0ZWN0ZWQpIHdoaWxlIEV0aGVybmV0Cj4gZG9lcyBzZWVtIHRvIGF0IGxl
YXN0IGdldCBkZXRlY3RlZC4gVGhpcyBoYXMgYmVlbiBzZWVuIHVzaW5nIG5leHQtMjAyNjAyMTks
IHN0YWJsZSB2Ni4xOS4yIFsxXSBhcyB3ZWxsIGFzCj4gNi4xOC4wLXJjNiBbMl0uIEFueSBpZGVh
IHdoYXQgY291bGQgYmUgZ29pbmcgd3Jvbmc/Cj4gCj4gSSBhZG1pdCBzbyBmYXIgSSBvbmx5IGRv
IGhhdmUgb25lIHNpbmdsZSBFQkM3NzAwIGF0IGhhbmQgd2hpbGUgd2FpdGluZyBmb3IgZnVydGhl
ciBoYXJkd2FyZSB0byBhcnJpdmUuCj4gCj4gVGhhbmtzIQo+IAo+IFsxXSBodHRwczovL2dpdGh1
Yi5jb20vcmlzY3YvbWV0YS1yaXNjdi9wdWxsLzYwMQo+IFsyXSBodHRwczovL2dpdGh1Yi5jb20v
ZXN3aW5jb21wdXRpbmcvbGludXgtbmV4dC90cmVlL2Rldi90ZXN0LXVwc3RyZWFtLXY2LjE4LXJj
Ngo+IAo+IENoZWVycwo+IAo+IE1hcmNlbAo+IAo+IFtzbmlwXQo=

