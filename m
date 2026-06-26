Return-Path: <netdev+bounces-302134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nk64Kh9MPmqNCwkAu9opvQ
	(envelope-from <netdev+bounces-302134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 11:53:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD40F6CBD9C
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 11:53:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=XeQrqlNd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302134-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302134-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A519B30036D7
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 09:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A283E44F6;
	Fri, 26 Jun 2026 09:53:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8263EB0ED
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 09:53:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782467595; cv=none; b=TOCApek9KBmOqtn3tqa8+oRbYTOIcz+sdY6mjhJQfCE1WLwVErcqkcdA8laYI3ree41zW9Ms8+TcdONZ2Njx6yMmo3gJuKVic/S54larq8hvS7XSpLn6+OJWEUfzw5gYIT3+lKMsl4iThX+fp0Xni8Rflyims9ipg3szQPQ4oQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782467595; c=relaxed/simple;
	bh=Yi/qUZt9qg0ByP4Mcln3ZqWM0Uqkr5E9KpTPDXr8Gqk=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=Q2E4Qp5nBaFij0bu6SfHKl7Z2ysE4Dp0nh8znzzn0vZ3o7SAkWKMmp4C2yZqhBFMI/ReEZyMvQeM6RkLETUcZeNvvhyBD5+BJDkLjoKfFMSGaTNQK/BL6Ox9RrUqncyms95buq5DXNKkpjjsxPp88cNCdksksb1yG5mkls/U0gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XeQrqlNd; arc=none smtp.client-ip=54.92.39.34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782467587;
	bh=Yi/qUZt9qg0ByP4Mcln3ZqWM0Uqkr5E9KpTPDXr8Gqk=;
	h=Date:From:To:Subject:Mime-Version:Message-ID;
	b=XeQrqlNdDsk/le/gyojpwXRIViWZlOvZ9L3FrFAExA5LsC0/oXOqo4dgv7ZLKS5zp
	 04Htgrm7vAFsMfBberLkPxmxlL8wR/f9MZ1nfP1trqaa4vaLy+rJbVcZz2/sw1XlNW
	 z1PqbzI76D038LifrsVtiBxJjueRHa6GeFXZqOC4=
X-QQ-mid: esmtpsz19t1782467584t5a7fa496
X-QQ-Originating-IP: U+eTu1JUOTbwCH3OSXH9MotKvQopZeeKuAkQZkjc1Rk=
Received: from PEN002676 ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jun 2026 17:53:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18176677891781331183
Date: Fri, 26 Jun 2026 17:53:02 +0800
From: =?GB2312?B?1dS98MP3?= <zhaojinming@uniontech.com>
To: horms <horms@kernel.org>
Cc: horms <horms@kernel.org>, 
	"Andrew Lunn" <andrew@lunn.ch>, 
	andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, 
	edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	madalin.bucur <madalin.bucur@nxp.com>, 
	netdev <netdev@vger.kernel.org>, 
	pabeni <pabeni@redhat.com>, 
	sean.anderson <sean.anderson@linux.dev>
Subject: Re: [PATCH v3] net: fman: fix use-after-free on IRQF_SHARED handler after probe failure
References: <20260624094922.2971930-2-zhaojinming@uniontech.com>, 
	<20260625164237.1222477-1-horms@kernel.org>
X-Priority: 3
X-GUID: E840455C-9460-4682-B1B5-5A72F72EF2E7
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.375[cn]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <A2160E1BFD1B78E6+202606261753007787241@uniontech.com>
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: base64
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NhdiEwnVOUqE09iVaV7teDv2sXjmIYoPQ0TQ8EbC5TRTVaNjsuzzQfEk
	EBNZ/HLXNZ9myAwq5M5cVyx5epi+WmA7GLj7YsTBg5nRdDK4czVz7hLQqlrjjnnrPZjBZFx
	AbFbwssxYtElN7KaJOSR8w8VZSJEi5BKBMk0EAXdAiqwOlsb/6xG7QUASMbPylSQgb8JmVq
	26GH9zPHTGqOuBbzVIe9CtZAd1R+4pNnm+LXsxITlAbGyvPDdTeEc4cbU65m+ggDQPAZZVB
	G4cB48b6hDyxGP35d8HhNRLrooIbyXcttnLyrQ7Higoi56ZhVDTEe2hIMZV2+GfiGR/31r4
	IFBgaGPECEfteUluc8du2jjFZCjrHyxWzJaDPqVmw1YIgkYf6uJ3K0sIJyi9BZQSswSxQls
	YD3mVKKKbp6opPR+A+Hq+bhV9ZXT24KnOtPFbIIY9jSVKXBCJ5FAmY9KAT40L49FdAfBXKc
	FlGse6OHfe4yu0a1zKovMB4z3fgm20yq66QPlXIo0yG7bwl0l0nMWeKCmb2qSypz1qrdXbS
	n57yZLBi1K2TWD4YEVcQunZFSeDHx1Mc10mEQHKKpfQjnd9KvZxYD9L3n0n92kyvpvv0pTf
	zZyDkME8SzMXXJ7tCOkUTD0Nw7ND7PXiCmf9FM6oFG/bbblU+oCfEU7Zr0zUgBinDJM3KFl
	t5xRjRb/I39n1voYdSYkGBjOF63AcyXGeCnP4QZ/X7AyrG1H2gaO9BY8TyoHEnFuW9GYoM5
	hg8KfK/qjWvHRMfGdOge9pXEWmFmhYLOLl5yefbluKyEgMXwV+pzdYQeYlRbZIBv2fkT61m
	in/zpva+s5lHMAKP9WnGRALnCrQ8GrcfBf5SaETHrJAUsju6hWZeyk6yEiGTx3LtzAqB2Od
	DWlZSCNJS2rPb79lxUxhzKgyp4QzW21nIQbWzBJCQ3rKHf4HGXjxvBkerc9d5GmKEmnP9Bz
	Uo5XOCv0ZhpeUUHpJu0hMLOdXVtw995rC7M2oSnX9X7yp+5G9JK+3k5D1NUq7d/5e4y0Kse
	53AXsfiQ==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:madalin.bucur@nxp.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:sean.anderson@linux.dev,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302134-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD40F6CBD9C

SGksCgpUaGUgYW5hbHlzaXMgaXMgbG9naWNhbGx5IGNvcnJlY3QuIFNpbmNlIGZtYW4gaXMgemVy
by1pbml0aWFsaXplZCBieQpremFsbG9jX29iaigpLCBib3RoIGZtYW4tPmNmZyBhbmQgZm1hbi0+
ZnBtX3JlZ3MgYXJlIE5VTEwgd2hlbgpkZXZtX3JlcXVlc3RfaXJxKCkgcmVnaXN0ZXJzIHRoZSBz
aGFyZWQgSVJRIGhhbmRsZXIuIFRoZSBndWFyZCBpbgpmbWFuX2lycSgpOgoKICAgIGlmICghaXNf
aW5pdF9kb25lKGZtYW4tPmNmZykpCiAgICAgICAgcmV0dXJuIElSUV9OT05FOwoKZG9lcyBub3Qg
cHJvdGVjdCBhZ2FpbnN0IHRoaXMgY2FzZSBiZWNhdXNlIGlzX2luaXRfZG9uZShOVUxMKSByZXR1
cm5zCnRydWUsIHNvIHRoZSBoYW5kbGVyIHdvdWxkIHByb2NlZWQgdG8gZGVyZWZlcmVuY2UgdGhl
IE5VTEwKZnBtX3JlZ3MgcG9pbnRlciB2aWEgaW9yZWFkMzJiZSgpLgoKSG93ZXZlciwgdGhpcyBp
cyBhIHByZS1leGlzdGluZyBpc3N1ZSB1bnJlbGF0ZWQgdG8gdGhlIFVBRiBmaXggaW4gdGhpcwpw
YXRjaC4gVGhlIHdpbmRvdyBpcyB2ZXJ5IHNob3J0IC0tIGJldHdlZW4gZGV2bV9yZXF1ZXN0X2ly
cSgpIGFuZCB0aGUKY29tcGxldGlvbiBvZiBmbWFuX2luaXQoKSAtLSBhbmQgd291bGQgcmVxdWly
ZSBhbm90aGVyIGRldmljZSBvbiB0aGUKc2FtZSBzaGFyZWQgSVJRIGxpbmUgdG8gZmlyZSBhbiBp
bnRlcnJ1cHQgZHVyaW5nIHRoYXQgaW50ZXJ2YWwuCgpJZiB0aGlzIHNob3VsZCBiZSBhZGRyZXNz
ZWQsIEkgd2lsbCBzZW5kIGEgc2VwYXJhdGUgcGF0Y2ggZm9yIGl0LgpUaGUgY3VycmVudCBwYXRj
aCBpcyBmb2N1c2VkIHNvbGVseSBvbiB0aGUgcG9zdC1JUlEtcmVnaXN0cmF0aW9uIFVBRgpvbiBl
cnJvciBwYXRocy4KClBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3Ugd291bGQgbGlrZSBtZSB0byBo
YW5kbGUgdGhpcyBzZXBhcmF0ZWx5LgoKQmVzdCByZWdhcmRzLApaaGFvSmlubWluZwoKCgo+VGhp
cyBpcyBhbiBBSS1nZW5lcmF0ZWQgcmV2aWV3IG9mIHlvdXIgcGF0Y2guIFRoZSBodW1hbiBzZW5k
aW5nIHRoaXMKCgoKPmVtYWlsIGhhcyBjb25zaWRlcmVkIHRoZSBBSSByZXZpZXcgdmFsaWQsIG9y
IGF0IGxlYXN0IHBsYXVzaWJsZS4KCgoKPkZ1bGwgcmV2aWV3IGF0OiBodHRwczovL3Nhc2hpa28u
ZGV2CgoKCj4tLS0KCgoKPm5ldDogZm1hbjogZml4IHVzZS1hZnRlci1mcmVlIG9uIElSUUZfU0hB
UkVEIGhhbmRsZXIgYWZ0ZXIgcHJvYmUgZmFpbHVyZQoKCgo+CgoKCj5UaGlzIHBhdGNoIGZpeGVz
IGEgdXNlLWFmdGVyLWZyZWUgaW4gdGhlIGVycm9yIHBhdGggb2YgcmVhZF9kdHNfbm9kZSgpLiBJ
dAoKCgo+bWFudWFsbHkgcmVsZWFzZXMgdGhlIHJlZ2lzdGVyZWQgSVJRIGhhbmRsZXJzIGJlZm9y
ZSBmcmVlaW5nIHRoZSBmbWFuCgoKCj5zdHJ1Y3R1cmUsIHByZXZlbnRpbmcgdGhlIGRldnJlcyBj
bGVhbnVwIGZyb20gbGVhdmluZyBhIHJlZ2lzdGVyZWQgSVJRCgoKCj5wb2ludGluZyB0byBmcmVl
ZCBtZW1vcnkuCgoKCj4KCgoKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Zy
ZWVzY2FsZS9mbWFuL2ZtYW4uYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mbWFu
L2ZtYW4uYwoKCgo+PiBpbmRleCAwMTMyNzNhMmRlMzJmLi5iYTIzMzhkYTBjZWExIDEwMDY0NAoK
Cgo+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZm1hbi9mbWFuLmMKCgoK
Pj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZtYW4vZm1hbi5jCgoKCj5b
IC4uLiBdCgoKCj4+IEBAIC0yNzg2LDcgKzI3OTAsNyBAQCBzdGF0aWMgc3RydWN0IGZtYW4gKnJl
YWRfZHRzX25vZGUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqb2ZfZGV2KQoKCgo+Pj8gCQlpZiAo
ZXJyIDwgMCkgewoKCgo+Pj8gCQkJZGV2X2Vycigmb2ZfZGV2LT5kZXYsICIlczogaXJxICVkIGFs
bG9jYXRpb24gZmFpbGVkIChlcnJvciA9ICVkKVxuIiwKCgoKPj4/IAkJCQlfX2Z1bmNfXywgZm1h
bi0+ZHRzX3BhcmFtcy5lcnJfaXJxLCBlcnIpOwoKCgo+PiAtCQkJZ290byBmbWFuX2ZyZWU7CgoK
Cj4+ICsJCQlnb3RvIGZyZWVfbWFpbl9pcnE7CgoKCj4KCgoKPltTZXZlcml0eTogSGlnaF0KCgoK
PlRoaXMgaXMgYSBwcmUtZXhpc3RpbmcgaXNzdWUsIGJ1dCBzaW5jZSB3ZSBhcmUgbW9kaWZ5aW5n
IHRoZSBJUlEgZXJyb3IKCgoKPmhhbmRsaW5nIGhlcmUsIGNvdWxkIHRoZSBzaGFyZWQgaW50ZXJy
dXB0IGhhbmRsZXIgY3Jhc2ggaWYgaXQgZmlyZXMgZHVyaW5nCgoKCj50aGlzIHNldHVwIHBoYXNl
PwoKCgo+CgoKCj5KdXN0IGJlZm9yZSB0aGlzIHNuaXBwZXQgaW4gcmVhZF9kdHNfbm9kZSgpLCBk
ZXZtX3JlcXVlc3RfaXJxKCkgaXMgY2FsbGVkCgoKCj53aXRoIElSUUZfU0hBUkVEIHdoaWxlIGZt
YW4gaXMgc3RpbGwgcGFydGlhbGx5IGluaXRpYWxpemVkLiBTaW5jZSBmbWFuIHdhcwoKCgo+YWxs
b2NhdGVkIHdpdGgga3phbGxvY19vYmooKSwgZm1hbi0+Y2ZnIGFuZCBmbWFuLT5mcG1fcmVncyBh
cmUgTlVMTC4KCgoKPgoKCgo+SWYgYSBzaGFyZWQgaW50ZXJydXB0IGZpcmVzIGltbWVkaWF0ZWx5
LCBmbWFuX2lycSgpIGlzIGNhbGxlZDoKCgoKPgoKCgo+ZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJl
ZXNjYWxlL2ZtYW4vZm1hbi5jOmZtYW5faXJxKCkgewoKCgo+Pz8/Pz8/PyAuLi4KCgoKPj8/Pz8/
Pz8gaWYgKCFpc19pbml0X2RvbmUoZm1hbi0+Y2ZnKSkKCgoKPj8/Pz8/Pz8/Pz8/Pz8/PyByZXR1
cm4gSVJRX05PTkU7CgoKCj4KCgoKPj8/Pz8/Pz8gZnBtX3JnID0gZm1hbi0+ZnBtX3JlZ3M7CgoK
Cj4/Pz8/Pz8/IHBlbmRpbmcgPSBpb3JlYWQzMmJlKCZmcG1fcmctPmZtX25waSk7CgoKCj4/Pz8/
Pz8/IC4uLgoKCgo+fQoKCgo+CgoKCj5TaW5jZSBmbWFuLT5jZmcgaXMgTlVMTCwgaXNfaW5pdF9k
b25lKCkgYmVoYXZlcyBsaWtlIHRoaXM6CgoKCj4KCgoKPmRyaXZlcnMvbmV0L2V0aGVybmV0L2Zy
ZWVzY2FsZS9mbWFuL2ZtYW4uYzppc19pbml0X2RvbmUoKSB7CgoKCj4/Pz8/Pz8/IGlmICghY2Zn
KQoKCgo+Pz8/Pz8/Pz8/Pz8/Pz8/IHJldHVybiB0cnVlOwoKCgo+Pz8/Pz8/PyAuLi4KCgoKPn0K
CgoKPgoKCgo+V291bGQgdGhpcyBjYXVzZSBmbWFuX2lycSgpIHRvIGJ5cGFzcyB0aGUgZWFybHkg
cmV0dXJuLCBwcm9jZWVkIHdpdGggYSBOVUxMCgoKCj5mcG1fcmcgcG9pbnRlciwgYW5kIGRlcmVm
ZXJlbmNlIGl0IGR1cmluZyB0aGUgaW9yZWFkMzJiZSgpIGNhbGw/CgoKCj4KCgoKPj4/IAkJfQoK
Cgo+Pj8gCX0KCgoKPgoKCg==


