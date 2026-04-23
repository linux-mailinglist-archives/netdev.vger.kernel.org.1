Return-Path: <netdev+bounces-280641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM1GIDTN6WkKkgIAu9opvQ
	(envelope-from <netdev+bounces-280641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:41:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B744E113
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91971302A68D
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB3F2E889C;
	Thu, 23 Apr 2026 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="Av7o4px4"
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAEB2989B0;
	Thu, 23 Apr 2026 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776929843; cv=none; b=u0DDVYn5NQPUybN9Dl1UP20abvunaGZsKNbrrTkjW0EH2BwjVd8yY88bCB157quuJKE7srO2tArk2WecEXklt8dzN3YFlxbCg1B7oXNew/18BI7+W6qSAGILhN+rhF7vbbv6lEkTI1TfhWK+bBjppPZeZV8ruCsuoAJFrQR1+ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776929843; c=relaxed/simple;
	bh=qbXRTD+spRL21cgjgma9x0oRfyFjympLgHoHqpap1jk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=nP0b818ZtT7AXokCvmzk4Zc+hiLU1oLHO24kfHDOSmP4iQA44Rd70kRab+FpxzvVd2HPxmlCVc69AjgN9qT1soZIfPCKboXQ5tkyyCjLdz6rSR6D2E4DCr0saxNVW7mYTMfUthFEYpqVymmd2ZZtFNXmyyEee9RoeHz2WQLlJFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=Av7o4px4 reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
	In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID; bh=vQgYiYTqlgCkoXhxKT0KFWsQ75g5UsoURGZ8
	S3S6t8o=; b=Av7o4px4FUN8QzcAN4vLFmQKvh31EcERq9k7lkzfM/xlSMVSzdcF
	Ke8zdFRFYpnNPtuD+I1pKqb2KDqYDcGc8+lyGwkjw3NKl8p6ECUVkiSPkIMcMmLD
	1INu5H2XLfJQHEev+HcnLXfXwXZlKMvZWsdyBev16GHHR54BspJFSQU=
Received: from 25181214217$stu.xidian.edu.cn ( [113.200.174.80] ) by
 ajax-webmail-hzbj-edu-front-4.icoremail.net (Coremail) ; Thu, 23 Apr 2026
 15:36:49 +0800 (GMT+08:00)
Date: Thu, 23 Apr 2026 15:36:49 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?546L5piO54Wc?= <25181214217@stu.xidian.edu.cn>
To: "Sabrina Dubroca" <sd@queasysnail.net>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] ipv6: udp: fix memory leak in udpv6_sendmsg error
 path
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250410(2f5ccd7f) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-8dfce572-2f24-404d-b59d-0dd2e304114c-icoremail.cn
In-Reply-To: <aei3QDpiToAcYfR1@krikkit>
References: <20260422105802.486216-1-25181214217@stu.xidian.edu.cn>
 <aei3QDpiToAcYfR1@krikkit>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <213735e5.6f4b.19db945239c.Coremail.25181214217@stu.xidian.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:BrQMCkA22rURzOlpCou3AQ--.22166W
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgULEWnnlGSvE
	wAEsb
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
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
	TAGGED_FROM(0.00)[bounces-280641-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,meta];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_PERMFAIL(0.00)[stu.xidian.edu.cn:s=dkim];
	HAS_X_PRIO_THREE(0.00)[3];
	DKIM_TRACE(0.00)[stu.xidian.edu.cn:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[25181214217@stu.xidian.edu.cn,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.996];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xidian.edu.cn:email,stu.xidian.edu.cn:mid]
X-Rspamd-Queue-Id: DE4B744E113
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

SGkgU2FicmluYSBhbmQgSmFrdWIsCgpUaGFuayB5b3UgZm9yIHRoZSBkZXRhaWxlZCByZXZpZXcg
YW5kIHBvaW50aW5nIG91dCB0aGUgY3Jhc2ggcmlzayBpbiB2MS4gCgpZb3UgYXJlIGFic29sdXRl
bHkgY29ycmVjdC4gTXkgcHJldmlvdXMgcGF0Y2ggd291bGQgbGVhZCB0byBhIERvdWJsZSBGcmVl
L1VBRiBiZWNhdXNlIGZ1bmN0aW9ucyBsaWtlIGlwNl9zZXR1cF9jb3JrKCkgYW5kIF9faXA2X2Zs
dXNoX3BlbmRpbmdfZnJhbWVzKCkgYWxyZWFkeSBoYW5kbGUgdGhlIGRzdCByZWxlYXNlIGluIHRo
ZWlyIGVycm9yIHBhdGhzLgoKQWZ0ZXIgYSBkZWVwZXIgaW52ZXN0aWdhdGlvbiwgSSBmb3VuZCB0
aGUgYWN0dWFsIHNvdXJjZSBvZiB0aGUgbWVtb3J5IGxlYWsgcmVwb3J0ZWQgYnkgdGhlIGZ1enpl
ci4gSXQgb2NjdXJzIGluc2lkZSBgX19pcDZfbWFrZV9za2IoKWAgaW4gYG5ldC9pcHY2L2lwNl9v
dXRwdXQuY2AuCgpJbiBzcGVjaWZpYyBjYXNlcyAoc3VjaCBhcyBmYXVsdCBpbmplY3Rpb24gZHVy
aW5nIHBhY2tldCBjb25zdHJ1Y3Rpb24pLCBgX19pcDZfYXBwZW5kX2RhdGEoKWAgY2FuIHN1Y2Nl
ZWQgd2hpbGUgbGVhdmluZyB0aGUgcXVldWUgZW1wdHkuIFdoZW4gYF9faXA2X21ha2Vfc2tiKClg
IGlzIHRoZW4gY2FsbGVkLCBgX19za2JfZGVxdWV1ZShxdWV1ZSlgIHJldHVybnMgTlVMTC4gCgpD
dXJyZW50bHksIHRoZSBjb2RlIGhhbmRsZXMgYSBOVUxMIHNrYiB3aXRoIGEgYGdvdG8gb3V0O2As
IHdoaWNoIGNvbXBsZXRlbHkgYnlwYXNzZXMgdGhlIGNhbGwgdG8gYGlwNl9jb3JrX3JlbGVhc2Uo
Y29yayk7YC4gU2luY2UgdGhlIGBjb3JrYCBzdHJ1Y3R1cmUgc3RpbGwgaG9sZHMgdGhlIGBkc3Rf
ZW50cnlgIHJlZmVyZW5jZSBhdCB0aGlzIHBvaW50LCBza2lwcGluZyB0aGUgcmVsZWFzZSBjYXVz
ZXMgdGhlIG1lbW9yeSBsZWFrLgoKSSBhbSBhYmFuZG9uaW5nIHRoZSB2MSBhcHByb2FjaCBhbmQg
d2lsbCBzdWJtaXQgYSB2MiBwYXRjaCB0aGF0IGZpeGVzIHRoZSBsb2dpYyBpbiBgX19pcDZfbWFr
ZV9za2IoKWAgdG8gZW5zdXJlIGBpcDZfY29ya19yZWxlYXNlKClgIGlzIGFsd2F5cyBjYWxsZWQu
CgpCZXN0IHJlZ2FyZHMsCk1pbmd5dSBXYW5nCgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g
5Y+R5Lu25Lq6OiAiU2FicmluYSBEdWJyb2NhIiA8c2RAcXVlYXN5c25haWwubmV0Pgo+IOWPkemA
geaXtumXtDoyMDI2LTA0LTIyIDE5OjU1OjQ0ICjmmJ/mnJ/kuIkpCj4g5pS25Lu25Lq6OiAiTWlu
Z3l1IFdhbmciIDwyNTE4MTIxNDIxN0BzdHUueGlkaWFuLmVkdS5jbj4KPiDmioTpgIE6IHdpbGxl
bWRlYnJ1aWpuLmtlcm5lbEBnbWFpbC5jb20sIGRhdmVtQGRhdmVtbG9mdC5uZXQsIGRzYWhlcm5A
a2VybmVsLm9yZywgZWR1bWF6ZXRAZ29vZ2xlLmNvbSwga3ViYUBrZXJuZWwub3JnLCBwYWJlbmlA
cmVkaGF0LmNvbSwgaG9ybXNAa2VybmVsLm9yZywgbmV0ZGV2QHZnZXIua2VybmVsLm9yZywgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+IOS4u+mimDogUmU6IFtQQVRDSF0gaXB2NjogdWRw
OiBmaXggbWVtb3J5IGxlYWsgaW4gdWRwdjZfc2VuZG1zZyBlcnJvciBwYXRoCj4gCj4gMjAyNi0w
NC0yMiwgMTg6NTg6MDIgKzA4MDAsIE1pbmd5dSBXYW5nIHdyb3RlOgo+ID4gRHVyaW5nIGZ1enpp
bmcgd2l0aCBmYWlsc2xhYiBlbmFibGVkLCBhIG1lbW9yeSBsZWFrIHdhcyBvYnNlcnZlZCBpbiB0
aGUKPiA+IElQdjYgVURQIHNlbmQgcGF0aC4KPiA+IAo+ID4gV2hlbiBzZW5kaW5nIHZpYSB0aGUg
bG9ja2xlc3MgZmFzdCBwYXRoICghY29ya3JlcSksIHVkcHY2X3NlbmRtc2coKQo+ID4gY2FsbHMg
aXA2X21ha2Vfc2tiKCkgYW5kIGFzc3VtZXMgdGhhdCB0aGUgcm91dGluZyBlbnRyeSAoZHN0X2Vu
dHJ5KQo+ID4gcmVmZXJlbmNlIGhhcyBiZWVuIHN0b2xlbiBieSB0aGUgY2FsbGVlLiBIb3dldmVy
LCBpZiBpcDZfbWFrZV9za2IoKQo+ID4gZmFpbHMgZWFybHkgKGUuZy4sIGR1ZSB0byBhbiBFTk9N
RU0gZnJvbSBtZW1vcnkgYWxsb2NhdGlvbiBmYWlsdXJlKSwKPiA+IGl0IHJldHVybnMgYW4gZXJy
b3IgcG9pbnRlciB3aXRob3V0IGNvbnN1bWluZyB0aGUgZHN0IHJlZmVyZW5jZS4KPiAKPiBOb3Qg
aW4gYWxsIGNhc2VzPyBJZiBpcDZfc2V0dXBfY29yaygpIGZhaWxzLCB3ZSBjYWxsCj4gaXA2X2Nv
cmtfcmVsZWFzZSgpIHdoaWNoIHdpbGwgcmVsZWFzZSB0aGUgZHN0LiBUaGUgTVNHX1BST0JFIHBh
dGggYWxzbwo+IHJlbGVhc2VzIHRoZSBkc3QuIF9faXA2X2ZsdXNoX3BlbmRpbmdfZnJhbWVzKCkg
YWxzbyBsb29rcyBsaWtlIGl0IGRvZXMKPiB0aGF0Lgo+IAo+ID4gU2luY2UgdWRwdjZfc2VuZG1z
ZygpIHVuY29uZGl0aW9uYWxseSBqdW1wcyB0byB0aGUgJ291dF9ub19kc3QnIGxhYmVsLAo+ID4g
dGhlIHVuY29uc3VtZWQgZHN0X2VudHJ5IGlzIG5ldmVyIHJlbGVhc2VkLCByZXN1bHRpbmcgaW4g
YSBtZW1vcnkgbGVhay4KPiA+IAo+ID4gRml4IHRoaXMgYnkgZXhwbGljaXRseSBjYWxsaW5nIGRz
dF9yZWxlYXNlKGRzdCkgd2hlbiBpcDZfbWFrZV9za2IoKQo+ID4gcmV0dXJucyBhbiBlcnJvci4K
PiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogTWluZ3l1IFdhbmcgPDI1MTgxMjE0MjE3QHN0dS54aWRp
YW4uZWR1LmNuPgo+IAo+IEFuZCB0aGlzIGlzIG1pc3NpbmcgYSBGaXhlcyB0YWcuCj4gCj4gPiAg
bmV0L2lwdjYvdWRwLmMgfCA1ICsrKystCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L2lwdjYvdWRwLmMg
Yi9uZXQvaXB2Ni91ZHAuYwo+ID4gaW5kZXggMTVlMDMyMTk0ZWNjLi5iODNlY2ZkNzI5YWYgMTAw
NjQ0Cj4gPiAtLS0gYS9uZXQvaXB2Ni91ZHAuYwo+ID4gKysrIGIvbmV0L2lwdjYvdWRwLmMKPiA+
IEBAIC0xNzA2LDggKzE3MDYsMTEgQEAgaW50IHVkcHY2X3NlbmRtc2coc3RydWN0IHNvY2sgKnNr
LCBzdHJ1Y3QgbXNnaGRyICptc2csIHNpemVfdCBsZW4pCj4gPiAgCQkJCSAgIGRzdF9ydDZfaW5m
byhkc3QpLAo+ID4gIAkJCQkgICBtc2ctPm1zZ19mbGFncywgJmNvcmspOwo+ID4gIAkJZXJyID0g
UFRSX0VSUihza2IpOwo+ID4gLQkJaWYgKCFJU19FUlJfT1JfTlVMTChza2IpKQo+ID4gKwkJaWYg
KCFJU19FUlJfT1JfTlVMTChza2IpKSB7Cj4gPiAgCQkJZXJyID0gdWRwX3Y2X3NlbmRfc2tiKHNr
YiwgZmw2LCAmY29yay5iYXNlKTsKPiA+ICsJCX0gZWxzZSB7Cj4gPiArCQkJZHN0X3JlbGVhc2Uo
ZHN0KTsKPiA+ICsJCX0KPiA+ICAJCS8qIGlwNl9tYWtlX3NrYiBzdGVhbHMgZHN0IHJlZmVyZW5j
ZSAqLwo+IAo+IFRoaXMgY29tbWVudCBiZWNvbWVzIHJlYWxseSBjb25mdXNpbmcgYWZ0ZXIgeW91
ciBwYXRjaC4KPiAKPiA+ICAJCWdvdG8gb3V0X25vX2RzdDsKPiA+ICAJfQo+ID4gLS0gCj4gPiAy
LjM0LjEKPiA+IAo+ID4gCj4gCj4gLS0gCj4gU2FicmluYQo=

