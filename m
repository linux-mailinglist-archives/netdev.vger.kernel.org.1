Return-Path: <netdev+bounces-287788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIHWDyQzBWonTQIAu9opvQ
	(envelope-from <netdev+bounces-287788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 04:27:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CE553D066
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 04:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AA843046E8F
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 02:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7170B2E7BB6;
	Thu, 14 May 2026 02:26:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A1F329C60;
	Thu, 14 May 2026 02:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778725606; cv=none; b=rBgm6PBWE7JTMoZlrAF7K06SKJjAb7y0hJK5VPvBPQa6cJdaP7gb2sR4g7+6H3F/PSMW0eMiPfjPosm+wcNXueBnEK6YNes51FHk/0UGS8AeWiJgP/+zYIMQZS1i6riZoFv8tzNMadDdspk1e7gPElQ6L7+pnOW2zJznQc8zA54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778725606; c=relaxed/simple;
	bh=u8MoHDV87EkButoVtnwYzpxxD5cG3nCo6IslC3GitKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=GuJZr002ZhrzEUa0DZ2a2uSv1ToJEi+qa4b6/l73Bteq4bFq8Ehp5hgV0XO1x7AVgeGQ8FLX13NmfTq0yo3ph2aNuxoEFB1rWYBzTmMH8OnjJImDgEm/tZRh+ZTerfYgiT0hyyKDWTz84KZCOGdiYG+gNeckNR1bvK4HYKmszyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Thu, 14 May 2026 10:25:55 +0800 (GMT+08:00)
Date: Thu, 14 May 2026 10:25:55 +0800 (GMT+08:00)
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
Subject: Re: Re: [PATCH net-next v7 2/4] net: stmmac: eic7700: enable clocks
 before syscon access and correct RX sampling timing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260512161315.141aba88@kernel.org>
References: <20260427072353.1114-1-lizhi2@eswincomputing.com>
 <20260427072508.1151-1-lizhi2@eswincomputing.com>
 <20260428180625.738223cf@kernel.org>
 <2117464.7991.19ddd2125d1.Coremail.lizhi2@eswincomputing.com>
 <20260430163551.7491407a@kernel.org>
 <38d052b7.7a70.19dfb0d782b.Coremail.lizhi2@eswincomputing.com>
 <446f69bd.7fe4.19e1ab248fb.Coremail.lizhi2@eswincomputing.com>
 <20260512161315.141aba88@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7171f9b3.81b6.19e244e0e9f.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TAJkCgDHaXO1MgVqOkkZAA--.7373W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAQEGDGoDVh1cGAAEso
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Queue-Id: D1CE553D066
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
	TAGGED_FROM(0.00)[bounces-287788-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_X_PRIO_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.907];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,bootlin.com,eswincomputing.com,einfochips.com];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiSmFrdWIgS2ljaW5za2ki
IDxrdWJhQGtlcm5lbC5vcmc+Cj4gU2VuZCB0aW1lOldlZG5lc2RheSwgMTMvMDUvMjAyNiAwNzox
MzoxNQo+IFRvOiDmnY7lv5cgPGxpemhpMkBlc3dpbmNvbXB1dGluZy5jb20+Cj4gQ2M6IGFuZHJl
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
b3JnCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCB2NyAyLzRdIG5ldDogc3RtbWFjOiBl
aWM3NzAwOiBlbmFibGUgY2xvY2tzIGJlZm9yZSBzeXNjb24gYWNjZXNzIGFuZCBjb3JyZWN0IFJY
IHNhbXBsaW5nIHRpbWluZwo+IAo+IE9uIFR1ZSwgMTIgTWF5IDIwMjYgMTM6Mzk6MTIgKzA4MDAg
KEdNVCswODowMCkg5p2O5b+XIHdyb3RlOgo+ID4gRm9yIHRoZSBldGgxIGVuYWJsZW1lbnQgcGFy
dCwgbXkgY3VycmVudCB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgaXQKPiA+IHNob3VsZCBiZSB0cmVh
dGVkIGFzIGEgbmV3IGluZGVwZW5kZW50IHYxIHNlcmllcyBmb3IgbmV0LW5leHQsCj4gPiBzaW5j
ZSB0aGUgc2NvcGUgYW5kIHRhcmdldCB0cmVlIGhhdmUgY2hhbmdlZCBhZnRlciB0aGUgc3BsaXQu
Cj4gPiAKPiA+IFdvdWxkIHlvdSBwcmVmZXIgdGhpcyBldGgxIHNlcmllcyB0byBzdGFydCBhcyB2
MSwgb3Igc2hvdWxkIGl0Cj4gPiBjb250aW51ZSBhcyB2OCBmb3IgY29udGludWl0eSB3aXRoIHRo
ZSBvcmlnaW5hbCBzZXJpZXM/Cj4gCj4gdjggaXMgYmV0dGVyLCBidXQgaXMgdGhlIGZpeCBpbiBu
ZXQtbmV4dCBhbHJlYWR5Pwo+IAo+IElmIHRoaXMgaXMgdGhlIHBvc3RpbmcgeW91J3JlIHJlZmVy
cmluZyB0bzoKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA1MDcwODMyMTQuMTky
LTEtbGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbS8KPiBpdCBoYXMgYmVlbiBkcm9wcGVkIGJhc2Vk
IG9uIGZlZWRiYWNrIGZyb20gTWF4aW1lIGFuZCBJIGRvbid0IHNlZSBhIHYyLgoKWWVzLCB0aGUg
ZXRoMCBmaXhlcyBoYXZlIG5vdyBiZWVuIHJlcG9zdGVkIGFzIGEgZGVkaWNhdGVkIHNlcmllcyB0
YXJnZXRpbmcgbmV0OgpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjYwNTA3MDgzMDM3
LjE1Mi0xLWxpemhpMkBlc3dpbmNvbXB1dGluZy5jb20vCgpUaGUgcHJldmlvdXMgbmV0LW5leHQg
ZXRoMS1yZWxhdGVkIHBvc3Rpbmcgd2FzIGRyb3BwZWQgZm9sbG93aW5nIHlvdXIgZ3VpZGFuY2UK
dG8gZmlyc3QgY29tcGxldGUgdGhlIGV0aDAgZml4ZXMgaW4gbmV0IGJlZm9yZSBjb250aW51aW5n
IHdpdGggZXRoMS4gSSB3aWxsCmtlZXAgZXRoMSBhcyB2OCBhcyBwcmV2aW91c2x5IHN1Z2dlc3Rl
ZC4KCkZvciB0aGUgZXRoMCBuZXQgc2VyaWVzLCBJIHdpbGwgc3BsaXQgdGhlIHJlbWFpbmluZyBj
aGFuZ2VzIGluIHYyIGFzIHN1Z2dlc3RlZApieSBNYXhpbWUgdG8gaW1wcm92ZSByZXZpZXdhYmls
aXR5IGFuZCBiaXNlY3RhYmlsaXR5LCBhbmQgcmVzZW5kIHNob3J0bHkuCgpPbmNlIHRoYXQgaXMg
Y29tcGxldGVkLCBJIHdpbGwgcHJvY2VlZCB3aXRoIHRoZSBldGgxIGVuYWJsZW1lbnQgc2VyaWVz
ICh2OCkKYmFzZWQgb24gdGhlIHVwZGF0ZWQgY29udGV4dC4KClRoYW5rcywKWmhpCg==

