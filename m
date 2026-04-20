Return-Path: <netdev+bounces-279646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2InkLP2T5WnqlgEAu9opvQ
	(envelope-from <netdev+bounces-279646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:48:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CCA426658
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2A4530071C4
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ED4379EEF;
	Mon, 20 Apr 2026 02:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="AvytTNrE"
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFEA379EC6;
	Mon, 20 Apr 2026 02:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776652928; cv=none; b=IghsvPRt1qZ5VEvz2g/a+kGRUMJ04t2zISGKrMkyykTorjR2G7t0CMXtrC93lYUlShmIn9Ak7+SIJUkxSd629fii8BAipW2LOYBa0rUgKGs3VFClY+kAB1iYcPyUH/ETa8CCudA8Zc+b87vYnpmoRCR1atR55IDWu8Y/kuM/0Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776652928; c=relaxed/simple;
	bh=WrUIQ+PsFt/5i2au3Hp0rJuDUnQZ21VHU9NUkkcdJBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=U1EuHpv+evP3l2OuEuvLaJyPeyW3dild0/+gmTqr9ycFU2ZKerSGvrcfbL1U7CkKyA7ybjnJL9BkhwCF+HsOx54nUErOO+gEaswVjqEhrv1L6a/3exFa6RCxI9UtcMcDCj1tDF/ImIUphy+UashCdGWcs49Yxx+HtTq9eS1H5os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=AvytTNrE reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
	In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID; bh=+cuJHmRM8JGkgrPIkkYY/0ZGmG00GRI2mhrV
	ZJvE51A=; b=AvytTNrEbAvqdic5AbIAFC0kvgyuvKxOwaSByJHsGkhizxGPF/h0
	A0b544H6K0OwkObXMf1TvyHx6rYRiJEhMDxApXTLacchpEzBy66bOwP0Kiu6DR1j
	nZJ7gFGb8f/AI5MBc93MUKQYL7jj6tETlc+VqEwEDBKvZjMEzoEZmEs=
Received: from 25181214217$stu.xidian.edu.cn ( [113.200.174.80] ) by
 ajax-webmail-hzbj-edu-front-4.icoremail.net (Coremail) ; Mon, 20 Apr 2026
 10:41:32 +0800 (GMT+08:00)
Date: Mon, 20 Apr 2026 10:41:32 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?546L5piO54Wc?= <25181214217@stu.xidian.edu.cn>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, tglx@kernel.org,
	mingo@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] net: hamachi: fix divide by zero in
 hamachi_init_one
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250410(2f5ccd7f) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-8dfce572-2f24-404d-b59d-0dd2e304114c-icoremail.cn
In-Reply-To: <e1d937ec-d909-4553-9f1e-c89f9b556d6a@lunn.ch>
References: <20260418121804.149171-1-25181214217@stu.xidian.edu.cn>
 <e1d937ec-d909-4553-9f1e-c89f9b556d6a@lunn.ch>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2543c18f.5194.19da8c3b8d1.Coremail.25181214217@stu.xidian.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:BrQMCkA22rVckuVp9uSoAQ--.19917W
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUHEWniTmNg3
	AAKsB
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWkCw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spamd-Result: default: False [7.44 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[xidian.edu.cn : SPF not aligned (relaxed),quarantine];
	MID_CONTAINS_FROM(1.00)[];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279646-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,body];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_PERMFAIL(0.00)[stu.xidian.edu.cn:s=dkim];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[25181214217@stu.xidian.edu.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[stu.xidian.edu.cn:~];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	NEURAL_SPAM(0.00)[0.963];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xidian.edu.cn:email,lunn.ch:email,stu.xidian.edu.cn:mid]
X-Rspamd-Queue-Id: 08CCA426658
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

SGkgQW5kcmV3LAoKUmVnYXJkaW5nIHRoZSAiaGFsdCIgYW5kIGV4cGxvaXRhYmlsaXR5OgpXaGls
ZSBhIGNsZWFuIHBhbmljIG9uIGJhZCBoYXJkd2FyZSBpcyBhIHNhZmUgZGVmZW5zZSwgdGhpcyBp
cyBhbiB1bmhhbmRsZWQgZXhjZXB0aW9uIHRoYXQgYnJlYWtzIHRoZSBtb2R1bGUgZXJyb3ItaGFu
ZGxpbmcgcGF0aC4gSXQgY2F1c2VzIG1lbW9yeSBjb3JydXB0aW9uIHJhdGhlciB0aGFuIGEgc2Fm
ZSBoYWx0LCB3aGljaCBpcyBkYW5nZXJvdXMgZm9yIGhvdC1wbHVnZ2FibGUgVk1zLiBUaGUgdHJh
Y2Ugc2hvd3MgYSBLQVNBTiBvdXQtb2YtYm91bmRzIHJlYWQgYW5kIGEgc3Vic2VxdWVudCBzb2Z0
IGxvY2t1cDoKCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQpCVUc6IEtBU0FOOiBzbGFiLW91dC1vZi1ib3VuZHMgaW4gaWRl
bXBvdGVudF9pbml0X21vZHVsZSsweDU0YS8weDYyMApSZWFkIG9mIHNpemUgOCBhdCBhZGRyIGZm
ZmY4ODgxMTkxZTdlMDggYnkgdGFzayBzeXN0ZW1kLXVkZXZkLzE2OQouLi4Kd2F0Y2hkb2c6IEJV
Rzogc29mdCBsb2NrdXAgLSBDUFUjMiBzdHVjayBmb3IgMjQ1cyEgW3N5c3RlbWQtdWRldmQ6MTc0
XQpSSVA6IDAwMTA6cXVldWVkX3NwaW5fbG9ja19zbG93cGF0aCsweDI0My8weGI5MAo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KClJlZ2FyZGluZyByZXBvcnRpbmcgdGhlIGF0dGFjazoKWW91IGFyZSBlbnRpcmVseSBjb3Jy
ZWN0IHRoYXQgdGhlIHYxIHBhdGNoIHBhc3NpdmVseSBtYXNrZWQgdGhlIG1hdGggZXJyb3IuIFRo
aXMgdjIgcGF0Y2ggYWN0aXZlbHkgZGV0ZWN0cyB0aGUgdW50cnVzdGVkIGhhcmR3YXJlIHN0YXRl
ICgoaSAmIDB4ODApICYmICEoaSAmIDB4N2YpKSwgbG91ZGx5IHJlcG9ydHMgaXQgdmlhIGRldl9l
cnIoKSwgYW5kIHNhZmVseSBhYm9ydHMgdGhlIHByb2JlIHdpdGggLUVJTy4KClNpZ25lZC1vZmYt
Ynk6IE1pbmd5dSBXYW5nIDwyNTE4MTIxNDIxN0BzdHUueGlkaWFuLmVkdS5jbj4KLS0tCkNoYW5n
ZXMgaW4gdjI6Ci0gQWRkcmVzc2VkIGZlZWRiYWNrIGZyb20gQW5kcmV3IEx1bm4gcmVnYXJkaW5n
IHRydXN0aW5nIGJhZCBoYXJkd2FyZS4KLSBBZGRlZCBleHBsaWNpdCBkZXRlY3Rpb24gZm9yIHRo
ZSB1bnRydXN0ZWQgaGFyZHdhcmUgc3RhdGUuCi0gQWRkZWQgZGV2X2VycigpIHRvIHJlcG9ydCB0
aGUgYXR0YWNrIGFuZCBhYm9ydGVkIHRoZSBwcm9iZSB3aXRoIC1FSU8gdG8gcHJldmVudCBlcnJv
ci1wYXRoIG1lbW9yeSBjb3JydXB0aW9uLiAKCiBkcml2ZXJzL25ldC9ldGhlcm5ldC9wYWNrZXRl
bmdpbmVzL2hhbWFjaGkuYyB8IDggKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9wYWNrZXRlbmdpbmVzL2hh
bWFjaGkuYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3BhY2tldGVuZ2luZXMvaGFtYWNoaS5jCmlu
ZGV4IGIwZGU3ZTlmMTJhNS4uMmY0ODdkYjJmYjMzIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9wYWNrZXRlbmdpbmVzL2hhbWFjaGkuYworKysgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9wYWNrZXRlbmdpbmVzL2hhbWFjaGkuYwpAQCAtNzQ1LDYgKzc0NSwxNCBAQCBzdGF0aWMgaW50
IGhhbWFjaGlfaW5pdF9vbmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsCiAJCSAgIGRldi0+bmFtZSwg
Y2hpcF90YmxbY2hpcF9pZF0ubmFtZSwgcmVhZGwoaW9hZGRyICsgQ2hpcFJldiksCiAJCSAgIGlv
YWRkciwgZGV2LT5kZXZfYWRkciwgaXJxKTsKIAlpID0gcmVhZGIoaW9hZGRyICsgUENJQ2xrTWVh
cyk7CisKKwlpZiAoKGkgJiAweDgwKSAmJiAhKGkgJiAweDdmKSkgeworCQlkZXZfZXJyKCZwZGV2
LT5kZXYsICJJbnZhbGlkIFBDSUNsa01lYXMgdmFsdWUgKDB4JTAyeCksIGhhcmR3YXJlIHVudHJ1
c3RlZC5cbiIsIGkpOworCQl1bnJlZ2lzdGVyX25ldGRldihkZXYpOworCQlyZXQgPSAtRUlPOwor
CQlnb3RvIGVycl9vdXRfdW5tYXBfcng7CisJfQorCiAJcHJpbnRrKEtFUk5fSU5GTyAiJXM6ICAl
ZC1iaXQgJWQgTWh6IFBDSSBidXMgKCVkKSwgVmlydHVhbCBKdW1wZXJzICIKIAkJICAgIiUyLjJ4
LCBMUEEgJTQuNHguXG4iLAogCQkgICBkZXYtPm5hbWUsIHJlYWR3KGlvYWRkciArIE1pc2NTdGF0
dXMpICYgMSA/IDY0IDogMzIsCi0tIAoyLjM0LjEKCjIwMjYtMDQtMTggMjM6MzQ6MjYgIkFuZHJl
dyBMdW5uIiA8YW5kcmV3QGx1bm4uY2g+IOWGmemBk++8mgo+IE9uIFNhdCwgQXByIDE4LCAyMDI2
IGF0IDA4OjE4OjA0UE0gKzA4MDAsIE1pbmd5dSBXYW5nIHdyb3RlOgo+ID4gRHVyaW5nIHRoZSBo
YXJkd2FyZSBpbml0aWFsaXphdGlvbiBwaGFzZSBpbiBoYW1hY2hpX2luaXRfb25lKCksIHRoZSBk
cml2ZXIKPiA+IHJlYWRzIHRoZSBQQ0lDbGtNZWFzIHJlZ2lzdGVyIHRvIGNhbGN1bGF0ZSB0aGUg
UENJIGJ1cyBmcmVxdWVuY3kuCj4gPiAKPiA+IFRoZSBjdXJyZW50IGNvZGUgYXR0ZW1wdHMgdG8g
cHJldmVudCBhIGRpdmlkZS1ieS16ZXJvIGVycm9yIHVzaW5nIGEgdGVybmFyeQo+ID4gb3BlcmF0
b3I6IGBpID8gMjAwMC8oaSYweDdmKSA6IDBgLiBIb3dldmVyLCB0aGlzIGNoZWNrIGlzIGZsYXdl
ZC4gVGhlIGhpZ2hlc3QKPiA+IGJpdCBvZiBgaWAgKDB4ODApIGFjdHMgYXMgYSByZWFkeSBmbGFn
LiBJZiB1bnJlbGlhYmxlIGhhcmR3YXJlIG9yIGEgbWFsaWNpb3VzCj4gPiB2aXJ0dWFsIGRldmlj
ZSByZXR1cm5zIGEgdmFsdWUgd2hlcmUgdGhlIHJlYWR5IGJpdCBpcyBzZXQgYnV0IHRoZSBsb3dl
ciA3IGJpdHMKPiA+IGFyZSB6ZXJvIChlLmcuLCAweDgwKSwgdGhlIGNvbmRpdGlvbiBgaWAgZXZh
bHVhdGVzIHRvIHRydWUsIGJ1dCBgKGkgJiAweDdmKWAKPiA+IGV2YWx1YXRlcyB0byAwLiBUaGlz
IHJlc3VsdHMgaW4gYSBmYXRhbCBkaXZpZGUtYnktemVybyBleGNlcHRpb24uCj4gPiAKPiA+IFRo
aXMgYnVnIHdhcyBkaXNjb3ZlcmVkIGR1cmluZyBhbiBhdXRvbWF0ZWQgdmlydHVhbCBkZXZpY2Ug
ZnV6emluZyBjYW1wYWlnbgo+ID4gdGVzdGluZyB0aGUgaGFyZHdhcmUtc29mdHdhcmUgdHJ1c3Qg
Ym91bmRhcnkuIFdoZW4gdGhlIGhhcmR3YXJlIHJldHVybnMgMHg4MCwKPiA+IGl0IGJ5cGFzc2Vk
IHRoZSByZWFkaW5lc3Mgd2hpbGUtbG9vcCBidXQgdHJpZ2dlcmVkIHRoZSBkaXZpZGUgZXJyb3Iu
IEluIG91cgo+ID4gdGVzdHMsIHRoaXMgcGFuaWMgaW50ZXJydXB0ZWQgdGhlIG1vZHVsZSBsb2Fk
aW5nIHByb2Nlc3MsIGZ1cnRoZXIgdHJpZ2dlcmluZwo+ID4gYSBLQVNBTiBzbGFiLW91dC1vZi1i
b3VuZHMgaW4gdGhlIG1vZHVsZSBlcnJvciBwYXRoLCBhbmQgdWx0aW1hdGVseSBsZWFkaW5nCj4g
PiB0byBhIG11bHRpLWNvcmUgc29mdCBsb2NrdXAgYW5kIFJDVSBzdGFsbC4KPiAKPiBJc24ndCB0
aGF0IGEgZ29vZCByZXN1bHQgb2Ygc29tZWJvZHkgdHJ5aW5nIHRvIHVzZSBlbXVsYXRlZCBoYXJk
d2FyZQo+IHdpdGggYmFkIGJlaGF2aW91cj8gVGhlIG1hY2hpbmUgZ3JpbmRzIHRvIGEgaGFsdD8g
U28gaXQgaXMgbm90Cj4gZXhwbG9pdGFibGUuCj4gCj4gV2hhdCBoYXBwZW5zIHdpdGggeW91ciBw
YXRjaCBpbiBwbGFjZT8gSG93IGFyZSB5b3UgcmVwb3J0aW5nIHRoZQo+IGhhcmR3YXJlIGlzIGF0
dGFja2luZyB0aGUgbWFjaGluZSwgYW5kIHRoZSBoYXJkd2FyZSBzaG91bGQgbm90IGJlCj4gdHJ1
c3RlZD8KPiAKPiAJQW5kcmV3Cg==

