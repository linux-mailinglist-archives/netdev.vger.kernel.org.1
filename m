Return-Path: <netdev+bounces-248901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11272D10C56
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 07:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C379C3036AF0
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 06:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5FF32252D;
	Mon, 12 Jan 2026 06:56:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE575320CB3;
	Mon, 12 Jan 2026 06:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200987; cv=none; b=hUzm/Zo4+E+Cz6G2LYX3SwEfgMdfudj6Iwfre284P3SAnVRJRHoF4ZA61/cgLQHx32o5IcK14ZyGNnHlL1ARC1Jlr2CzEfIaqp+R1DtfVnF4OCgZrUGrsLqRofKl1Za+kFIbPHjtmbOM2xH86hA+1QTTJqL4BDcRELgUGOBQPww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200987; c=relaxed/simple;
	bh=vUeBuyvG02WL9NUy0Rpmjt3Vi6GIXO5jsLu58g1hMwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=sARFLnv/YStLITzS2B5BCPpCwibde/oGgS8eoB0OmGL8dptu7yr3uX6/s059Gp+5Y4xIQKFfnbIonN/744NiWLxgZMQj/UMDsxWhe2EXd1WwkRUYYfYvE1GT79QG/mJ60eNQSYyVuRcN5EJydaGyBSiYRisK87ukMymiO/fbSw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Mon, 12 Jan 2026 14:55:45 +0800 (GMT+08:00)
Date: Mon, 12 Jan 2026 14:55:45 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: Re: [PATCH v1 2/2] net: stmmac: eic7700: enable clocks before
 syscon access and correct RX sampling timing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <1f553a6e-ca95-45e2-be14-96557a35e618@lunn.ch>
References: <20260109080601.1262-1-lizhi2@eswincomputing.com>
 <20260109080929.1308-1-lizhi2@eswincomputing.com>
 <1f553a6e-ca95-45e2-be14-96557a35e618@lunn.ch>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3c434477.2d22.19bb0fd3f21.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TAJkCgAXH2zymmRp3RGUAA--.9130W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAQEFDGlj0ItHlAABsK
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiQW5kcmV3IEx1bm4iIDxh
bmRyZXdAbHVubi5jaD4KPiDlj5HpgIHml7bpl7Q6MjAyNi0wMS0xMCAwMjozMTowOSAo5pif5pyf
5YWtKQo+IOaUtuS7tuS6ujogbGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbQo+IOaKhOmAgTogZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcsIGFuZHJldytuZXRkZXZAbHVubi5jaCwgZGF2ZW1AZGF2
ZW1sb2Z0Lm5ldCwgZWR1bWF6ZXRAZ29vZ2xlLmNvbSwga3ViYUBrZXJuZWwub3JnLCByb2JoQGtl
cm5lbC5vcmcsIGtyemsrZHRAa2VybmVsLm9yZywgY29ub3IrZHRAa2VybmVsLm9yZywgbmV0ZGV2
QHZnZXIua2VybmVsLm9yZywgcGFiZW5pQHJlZGhhdC5jb20sIG1jb3F1ZWxpbi5zdG0zMkBnbWFp
bC5jb20sIGFsZXhhbmRyZS50b3JndWVAZm9zcy5zdC5jb20sIHJtaytrZXJuZWxAYXJtbGludXgu
b3JnLnVrLCBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29tLCBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcsIG5pbmd5dUBlc3dpbmNvbXB1dGluZy5jb20sIGxpbm1pbkBlc3dpbmNvbXB1dGluZy5jb20s
IHBpbmtlc2gudmFnaGVsYUBlaW5mb2NoaXBzLmNvbSwgd2Vpc2hhbmdqdWFuQGVzd2luY29tcHV0
aW5nLmNvbQo+IOS4u+mimDogUmU6IFtQQVRDSCB2MSAyLzJdIG5ldDogc3RtbWFjOiBlaWM3NzAw
OiBlbmFibGUgY2xvY2tzIGJlZm9yZSBzeXNjb24gYWNjZXNzIGFuZCBjb3JyZWN0IFJYIHNhbXBs
aW5nIHRpbWluZwo+IAo+ID4gKwlkd2NfcHJpdi0+ZWljNzcwMF9oc3BfcmVnbWFwID0KPiA+ICsJ
CQlzeXNjb25fcmVnbWFwX2xvb2t1cF9ieV9waGFuZGxlKHBkZXYtPmRldi5vZl9ub2RlLAo+ID4g
KwkJCQkJCQkiZXN3aW4saHNwLXNwLWNzciIpOwo+ID4gKwlpZiAoSVNfRVJSKGR3Y19wcml2LT5l
aWM3NzAwX2hzcF9yZWdtYXApKQo+ID4gIAkJcmV0dXJuIGRldl9lcnJfcHJvYmUoJnBkZXYtPmRl
diwKPiA+IC0JCQkJUFRSX0VSUihlaWM3NzAwX2hzcF9yZWdtYXApLAo+ID4gKwkJCQlQVFJfRVJS
KGR3Y19wcml2LT5laWM3NzAwX2hzcF9yZWdtYXApLAo+ID4gIAkJCQkiRmFpbGVkIHRvIGdldCBo
c3Atc3AtY3NyIHJlZ21hcFxuIik7Cj4gCj4gSW4gb3JkZXIgdG8gYmUgYmFja3dhcmRzIGNvbXBh
dGlibGUsIHlvdSBjYW5ub3QgZXJyb3Igb3V0IGhlcmUsCj4gYmVjYXVzZSBvbGQgRFQgYmxvYnMg
d29uJ3QgaGF2ZSB0aGlzIHByb3BlcnR5Lgo+IAoKVGhhbmtzIGZvciB0aGUgcmV2aWV3LgoKV2Ug
d291bGQgbGlrZSB0byBjbGFyaWZ5IG91ciB1bmRlcnN0YW5kaW5nIGJlZm9yZSBjaGFuZ2luZyB0
aGUgYmVoYXZpb3IuCgonZXN3aW4saHNwLXNwLWNzcicgaGFzIGJlZW4gZG9jdW1lbnRlZCBhcyBh
IHJlcXVpcmVkIHByb3BlcnR5IHNpbmNlIHRoZQppbml0aWFsIEVJQzc3MDAgRFdNQUMgYmluZGlu
ZywgYW5kIHRoZSBleGlzdGluZyBkcml2ZXIgYWxyZWFkeSByZWxpZXMgb24KaXQgZm9yIFJYL1RY
IGNsb2NrIGRlbGF5IHByb2dyYW1taW5nLiBGcm9tIG91ciB1bmRlcnN0YW5kaW5nLCB0aGlzCnBy
b3BlcnR5IGlzIGZ1bmRhbWVudGFsIHRvIGNvcnJlY3QgTUFDIGNsb2NrIGNvbmZpZ3VyYXRpb24g
b24gRUlDNzcwMCwKcmF0aGVyIHRoYW4gYW4gb3B0aW9uYWwgZW5oYW5jZW1lbnQuCgpHaXZlbiB0
aGlzLCBjb3VsZCB5b3UgcGxlYXNlIGNsYXJpZnkgd2hldGhlciB3ZSBzaG91bGQgc3RpbGwgdHJl
YXQKZXN3aW4saHNwLXNwLWNzciBhcyBvcHRpb25hbCBhdCBydW50aW1lIHB1cmVseSBmb3IgRFQg
QUJJIHJvYnVzdG5lc3MsCmV2ZW4gdGhvdWdoIGl0IGlzIHJlcXVpcmVkIGJ5IHRoZSBiaW5kaW5n
IGFuZCBoYXJkd2FyZSBkZXNpZ24/CgpPbmNlIGNvbmZpcm1lZCwgd2Ugd2lsbCB1cGRhdGUgdGhl
IGRyaXZlciBhbmQgYmluZGluZyBhY2NvcmRpbmdseS4KClRoYW5rcywKTGkgWmhpCg==

