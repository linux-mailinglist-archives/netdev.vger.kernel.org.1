Return-Path: <netdev+bounces-258054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL6ZK+IGi2kdPQAAu9opvQ
	(envelope-from <netdev+bounces-258054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 11:22:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D75119947
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 11:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9223E302E92A
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 10:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C1F355028;
	Tue, 10 Feb 2026 10:22:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38576352F8B;
	Tue, 10 Feb 2026 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770718943; cv=none; b=ttV3M4B3L8Hy+Icm2edgaS0HtOky5Vh35pz/vv6ytdx2r7fSr14/TmjTRZG8oyteL7EZfiKEiV/JLcFUqf2L1rZbyenNHvMx7WuNd3Jmpblpjq6p/mxxjo7Bl5WJWrl59bfIpimstW3Mf4Vfn23G2njMoTK3+jroOYBt0RSU8gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770718943; c=relaxed/simple;
	bh=xH0/xyuV2m4IGJF4YQH/yddhchsc4qxVZOZhbxGO42E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=tthMurP6NGA5u0SuI0vP0YXdlzYip8derWB4/PUkHA+KZMShRmesnNZAvLKCOdC23zDwvfbHpgFeSa8qXBM+BGaTJNETzEHNAfxW6Bmn9gN8R+mQl+1w9TQjDCzF8HyTFgEwmVFstktgG/DDakhwrFDBTo6Ec+Xa20wncSZ7DFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Tue, 10 Feb 2026 18:21:40 +0800 (GMT+08:00)
Date: Tue, 10 Feb 2026 18:21:40 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	"Andrew Lunn" <andrew@lunn.ch>
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: Re: [PATCH v2 0/2] net: stmmac: eic7700: fix EIC7700 eth1 RX
 sampling timing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <aYnvwAK3gpxBs-EF@shell.armlinux.org.uk>
References: <20260209094628.886-1-lizhi2@eswincomputing.com>
 <64bf6b40-b947-4ffa-8d48-4d6341931327@lunn.ch>
 <aYnvwAK3gpxBs-EF@shell.armlinux.org.uk>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5dea8ce0.4435.19c471231f5.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TAJkCgDXMzm0BotpuZEEAA--.2117W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAgEODGmKDIMekQAAsi
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
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
	DMARC_NA(0.00)[eswincomputing.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-258054-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,eswincomputing.com,einfochips.com];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13D75119947
X-Rspamd-Action: no action

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiUnVzc2VsbCBLaW5nIChP
cmFjbGUpIiA8bGludXhAYXJtbGludXgub3JnLnVrPgo+IOWPkemAgeaXtumXtDoyMDI2LTAyLTA5
IDIyOjMxOjI4ICjmmJ/mnJ/kuIApCj4g5pS25Lu25Lq6OiBsaXpoaTJAZXN3aW5jb21wdXRpbmcu
Y29tLCAiQW5kcmV3IEx1bm4iIDxhbmRyZXdAbHVubi5jaD4KPiDmioTpgIE6IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnLCBhbmRyZXcrbmV0ZGV2QGx1bm4uY2gsIGRhdmVtQGRhdmVtbG9mdC5u
ZXQsIGVkdW1hemV0QGdvb2dsZS5jb20sIGt1YmFAa2VybmVsLm9yZywgcm9iaEBrZXJuZWwub3Jn
LCBrcnprK2R0QGtlcm5lbC5vcmcsIGNvbm9yK2R0QGtlcm5lbC5vcmcsIG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmcsIHBhYmVuaUByZWRoYXQuY29tLCBtY29xdWVsaW4uc3RtMzJAZ21haWwuY29tLCBh
bGV4YW5kcmUudG9yZ3VlQGZvc3Muc3QuY29tLCBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0
b3JtcmVwbHkuY29tLCBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcsIGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsIG5pbmd5dUBlc3dpbmNvbXB1dGluZy5jb20sIGxpbm1p
bkBlc3dpbmNvbXB1dGluZy5jb20sIHBpbmtlc2gudmFnaGVsYUBlaW5mb2NoaXBzLmNvbSwgd2Vp
c2hhbmdqdWFuQGVzd2luY29tcHV0aW5nLmNvbQo+IOS4u+mimDogUmU6IFtQQVRDSCB2MiAwLzJd
IG5ldDogc3RtbWFjOiBlaWM3NzAwOiBmaXggRUlDNzcwMCBldGgxIFJYIHNhbXBsaW5nIHRpbWlu
Zwo+IAo+IE9uIE1vbiwgRmViIDA5LCAyMDI2IGF0IDAyOjM2OjExUE0gKzAxMDAsIEFuZHJldyBM
dW5uIHdyb3RlOgo+ID4gT24gTW9uLCBGZWIgMDksIDIwMjYgYXQgMDU6NDY6MjhQTSArMDgwMCwg
bGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbSB3cm90ZToKPiA+ID4gRnJvbTogWmhpIExpIDxsaXpo
aTJAZXN3aW5jb21wdXRpbmcuY29tPgo+ID4gPiAKPiA+ID4gdjEgLT4gdjI6Cj4gPiAKPiA+IEZv
ciB2ZXJzaW9uIDMsIHBsZWFzZSBpbmNsdWRlIGEgcGF0Y2ggdG8gdGhlIFNvQyAuZHRzaSBmaWxl
IGFkZGluZyB0aGUKPiA+IEV0aGVybmV0IG5vZGVzLiBXZSBsaWtlIHRvIHNlZSB1c2VycyBvZiBj
b2RlIGJlaW5nIGFkZGVkLgo+IAo+IEluIGFkZGl0aW9uIHRvIEFuZHJldydzIGNvbW1lbnRzLCBi
ZWZvcmUgcG9zdGluZyBhbm90aGVyIHNlcmllcywgcGxlYXNlCj4gcmV2aWV3IGh0dHBzOi8vZG9j
cy5rZXJuZWwub3JnL3Byb2Nlc3MvbWFpbnRhaW5lci1uZXRkZXYuaHRtbCwKPiBwYXJ0aWN1bGFy
bHkgc2VjdGlvbnMgMS40IGFuZCAxLjYuMS4KPiAKVGhhbmtzIGZvciB0aGUgY29tbWVudHMuCgpU
aGUgdjMgcGF0Y2ggd2lsbCB0YXJnZXQgdGhlIG5ldCBnaXQgdHJlZS4KCldlIHdpbGwgYWRkIHRo
ZSBldGhlcm5ldCBub2RlcyBhbmQgdGhlIGNvcnJlc3BvbmRpbmcgY2xvY2sgbm9kZSB0bwplaWM3
NzAwLmR0c2kgYW5kIGVpYzc3MDAtaGlmaXZlLXByZW1pZXItcDU1MC5kdHMgaW4gdjMgcGF0Y2gu
IAoKUGxlYXNlIG5vdGUgdGhhdCB0aGUgRUlDNzcwMCBjbG9jayBjb250cm9sbGVyIGJpbmRpbmcg
YW5kIGRyaXZlciBhcmUgbm90CnlldCBtZXJnZWQgdXBzdHJlYW0sIHNvIHRoZSBjbG9jayBub2Rl
cyB3aWxsIG5vdCBiZSBmdW5jdGlvbmFsIHVudGlsIHRoZQpjbG9jayBkcml2ZXIgaXMgYXZhaWxh
YmxlLiBBcyBhIHJlc3VsdCwgZHRic19jaGVjayB3aWxsIGN1cnJlbnRseSByZXBvcnQKc2NoZW1h
IHdhcm5pbmdzL2Vycm9ycyByZWxhdGVkIHRvIHRoZSBjbG9jayBub2Rlcy4gVGhpcyBpcyBhIGtu
b3duIGFuZAp0ZW1wb3JhcnkgbGltaXRhdGlvbiB1bnRpbCB0aGUgY2xvY2sgYmluZGluZyBhbmQg
ZHJpdmVyIGFyZSBhdmFpbGFibGUKdXBzdHJlYW0uCgpQbGVhc2UgbGV0IHVzIGtub3cgaWYgdGhp
cyBhcHByb2FjaCBpcyBhY2NlcHRhYmxlLgoKQmVzdCByZWdhcmRzLApaaGkgTGkK

