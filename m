Return-Path: <netdev+bounces-303526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aJFNKY3JRGrR0woAu9opvQ
	(envelope-from <netdev+bounces-303526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:02:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EDB6EAEC9
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:02:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b="X 18J4d3";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303526-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303526-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D99C3004042
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 08:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA643CAE80;
	Wed,  1 Jul 2026 08:02:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0A33C73C9
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 08:02:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892934; cv=none; b=mGKaK+oVctbGsfgA+wClAuSfsTJ8ZaHzWy6ncPy5lztuWnD+4iX1ouYG8L51Hm7Tu3oQ4XdmOi1z8EdB0cLdyFMsFDCDBqLKwBgt3zZaQ9dy+mEE6bNL4o1hf5UnzTd3zodaTvreMP9iUotfJailme1fFgSvXROVn+RP+bsGS7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892934; c=relaxed/simple;
	bh=UM86fGEBO0wzeoxCvanAgTThVnL/Sm8WVXLM7yMpNnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=BjrJf7sUIrSzRrtu7PuNSnK7aGuTmONzWz3C6Gpf08olXj8fykmkcbEg0PhkJY7s+5Nh4oNgWFUdhx1DB0MC022BcfKhpX4zKWeX30cNL6rQZxMBC1kk6BivYc1m2AUitzr1M+G5EMhqfJo/ta+JZz3DbKUNnSIQs+I+UWz1z4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X18J4d3X; arc=none smtp.client-ip=220.197.31.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=UM86fGEBO0wzeoxCvanAgTThVnL/Sm8WVXLM7yMpNnk=; b=X
	18J4d3XEOfL0cyOsWk+qaV3Mjz8oTt9MuvYAsBdM4/U80ZJHOTtfpPRWletyswHB
	IYoauB+ZkL4RA2c3k2hXH1TZOofQyADXKwvMBF3Ih1yS8sGtuYMmVaaVrJKtrNCt
	4S0wCX4Y6deahji0qKfYlxGOAT8t+WQJe09qLXnYxA=
Received: from zhulei_szu$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-133 (Coremail) ; Wed, 1 Jul 2026 16:01:16 +0800 (CST)
Date: Wed, 1 Jul 2026 16:01:16 +0800 (CST)
From: zhulei  <zhulei_szu@163.com>
To: "Lorenzo Bianconi" <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re:Re: [PATCH RESEND net-next] net: airoha: Make use of the helper
 function dev_err_probe()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <akOcrmDpfzNUTR2n@lore-desk>
References: <20260630015247.43322-1-zhulei_szu@163.com>
 <akOcrmDpfzNUTR2n@lore-desk>
X-NTES-SC: AL_Qu2TAPSSvUAs4CafZekcnE8QguY7UMq0sv4k3YBUc8AFqCDv5Dojck1EP37m8eGDFDGvgDO4Qj5g9t5aX7BIcVSj5/WjKiWDqWSnsDvmtw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <23f58025.6d6d.19f1cb25385.Coremail.zhulei_szu@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hSgvCgD3HwVNyURqu8kUAA--.1180W
X-CM-SenderInfo: x2kxzvxlbv63i6rwjhhfrp/xtbC7w0xfmpEyU3LWgAA3W
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhulei_szu@163.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303526-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhulei_szu@163.com,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47EDB6EAEC9

QXQgMjAyNi0wNi0zMCAxODozODozOCwgIkxvcmVuem8gQmlhbmNvbmkiIDxsb3JlbnpvQGtlcm5l
bC5vcmc+IHdyb3RlOgo+PiBGcm9tOiBMZWkgWmh1IDx6aHVsZWlAa3lsaW5vcy5jbj4KPj4gCj4+
IFVzZSBkZXZfZXJyX3Byb2JlKCkgdG8gcmVkdWNlIGNvZGUgc2l6ZSBhbmQgc2ltcGxpZnkgdGhl
IGNvZGUuCj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBMZWkgWmh1IDx6aHVsZWlAa3lsaW5vcy5jbj4K
Pj4gLS0tCj4+IFRoZSBsYXN0IHN1Ym1pc3Npb24gd2FzIHdoZW4gbmV0LW5leHQgaXMgY2xvc2Vk
LlJlc2VuZGluZyBpdC4KPj4gCj4+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9haXJvaGEvYWlyb2hh
X2V0aC5jIHwgMjEgKysrKysrKysrLS0tLS0tLS0tLS0tCj4+ICAxIGZpbGUgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKPj4gCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9haXJvaGEvYWlyb2hhX2V0aC5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
YWlyb2hhL2Fpcm9oYV9ldGguYwo+PiBpbmRleCAzMWNkYjExY2Q3OGQuLjE4OWY2NGU4M2E0NiAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvYWlyb2hhL2Fpcm9oYV9ldGguYwo+
PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9haXJvaGEvYWlyb2hhX2V0aC5jCj4+IEBAIC0z
MDcxLDEwICszMDcxLDkgQEAgc3RhdGljIGludCBhaXJvaGFfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikKPj4gIAlldGgtPmRldiA9ICZwZGV2LT5kZXY7Cj4+ICAKPj4gIAllcnIg
PSBkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KGV0aC0+ZGV2LCBETUFfQklUX01BU0soMzIpKTsK
Pgo+SSBkbyBub3QgdGhpbmsgZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudCgpIGNhbiByZXR1cm4g
LUVQUk9CRV9ERUZFUiwgc28gdGhlcmUKPmlzIG5vIHBvaW50IGFkZGluZyBkZXZfZXJyX3Byb2Jl
KCkgaGVyZS4KPgo+UmVnYXJkcywKPkxvcmVuem8KPgpIaSBMb3JlbnpvLAoKVGhhbmtzIGZvciB5
b3VyIHJldmlldy4KCkJlZm9yZSBtYWtpbmcgdGhpcyBwYXRjaCwgSSByZWZlcnJlZCB0byB0aGUg
Y29tbWVudHMgb2YgZGV2X2Vycl9wcm9iZToKImV2ZW4gaWYgQGVyciBpcyBrbm93biB0byBuZXZl
ciBiZSAtRVBST0JFX0RFRkVSLCB0aGUgYmVuZWZpdCBjb21wYXJlZAp0byBhIG5vcm1hbCBkZXZf
ZXJyKCkgaXMgdGhlIHN0YW5kYXJkaXplZCBmb3JtYXQgb2YgdGhlIGVycm9yIGNvZGUuIgoKSW4g
dGhlIHByb2JlIGZ1bmN0aW9uLCBJIG5vdGljZWQgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291
cmNlX2J5bmFtZQphbHJlYWR5IHVzZXMgZGV2X2Vycl9wcm9iZSwgd2hpbGUgb3RoZXIgZnVuY3Rp
b25zIHN0aWxsIHVzZSBkZXZfZXJyLgpSZXBsYWNlIHRoZW0gd2l0aCBkZXZfZXJyX3Byb2JlIGZv
ciBjb25zaXN0ZW5jeSwgbW9yZSBjb21wYWN0IGVycm9yIHBhdGhzLAphbmQgYmV0dGVyIHJlYWRh
YmlsaXR5IG9mIGVycm9yIGNvZGVzLgoKQmVzdCByZWdhcmRzCkxlaQoK

