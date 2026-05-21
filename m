Return-Path: <netdev+bounces-290601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKqDJvtmD2pKKgYAu9opvQ
	(envelope-from <netdev+bounces-290601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:11:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6CE5ABA9B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA8C83028F13
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5FA3F54C2;
	Thu, 21 May 2026 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ClHCnPVK"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AC43537C8;
	Thu, 21 May 2026 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779394289; cv=none; b=aPgBIsFhg2SSh6btqQDJI9GyEraEwJCXEY0EJKGN55a2BSm8vl4k3T3daD+5w9gSDJ2g64LLZWh6L5wuA6RUOAtnYLh3F2Q9BKwZ1EYnx9tD0wOiuSl/t76fFKcn3jl8YqL9OYcc28RVH2syS8HrdA8uwXbJJEqKMOg7P1L1pSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779394289; c=relaxed/simple;
	bh=dz8u9C0Rl7sb2H+dFbKoo7DJ7m9BxH4dLZBzXqxHVR8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E3GwCch2tEd+m5bM1kk4HRWff81CblcB7YHflVRzX9cSaTsELLZw0dazFM34eBYNhxQzGzEBVj13MA7wiquRVTc0WXgSBb8oC7SbHroQDgppCi+sqpOCm6NUa0d1fXpOceAViI2MiIyny5yl/RPykDaNEwkamojzN5YmCBs3EKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ClHCnPVK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dz8u9C0Rl7sb2H+dFbKoo7DJ7m9BxH4dLZBzXqxHVR8=; b=ClHCnPVKI8uurBWwcDuAH3pO0H
	h+QFT3pkyVoNZAksFpMslEd19azkKukCG4y2qF6A6onaoExHx9fQSFVncH03R+RQxum4mtowqyls/
	bmVOw+9HmD9wS4y/oYJF2B0XIH8m5AtyyO379iUIhLrYkW8ulqUJLIcTGEfon4S9ZdBULd181Wy3p
	MncquWM5YgxwzqSc9VAhmjQCP/yEQ3lghw+EE7Yp3pLlaqpilFXoxUpiWck7aXwjgKasH44rQkRg1
	CccqMyjvJ7ssBIUI3oumHFFNTWTv6bavUzJMzVtpVR3P4ALg92hdhV8TopRo9vzzyF+WnXnn2Lobc
	MyJhg9pg==;
Received: from 54-240-197-239.amazon.com ([54.240.197.239] helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ9jn-00000008yha-22c6;
	Thu, 21 May 2026 20:11:23 +0000
Message-ID: <8b8a748a2ac6e8e3d970f5e74a2774133e7e7d8c.camel@infradead.org>
Subject: Re: [PATCH v3 net-next 1/7] ptp: Add ioctls for PHC timestamps with
 quality attributes
From: David Woodhouse <dwmw2@infradead.org>
To: Arthur Kiyanovski <akiyano@amazon.com>, David Miller
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, David Woodhouse <dwmw@amazon.com>, Yonatan
 Sarna <ysarna@amazon.com>, Zorik Machulsky <zorik@amazon.com>, Alexander
 Matushevsky <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, Matt
 Wilson <msw@amazon.com>,  Anthony Liguori <aliguori@amazon.com>, Nafea
 Bshara <nafea@amazon.com>, Evgeny Schmeilin <evgenys@amazon.com>,  Netanel
 Belgazal <netanel@amazon.com>, Ali Saidi <alisaidi@amazon.com>, Benjamin
 Herrenschmidt <benh@amazon.com>,  Noam Dagan <ndagan@amazon.com>, David
 Arinzon <darinzon@amazon.com>, Evgeny Ostrovsky <evostrov@amazon.com>, Ofir
 Tabachnik <ofirt@amazon.com>, Amit Bernstein <amitbern@amazon.com>,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, 
 vadim.fedorenko@linux.dev
Date: Thu, 21 May 2026 21:11:21 +0100
In-Reply-To: <20260515164033.6403-2-akiyano@amazon.com>
References: <20260515164033.6403-1-akiyano@amazon.com>
	 <20260515164033.6403-2-akiyano@amazon.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-ea3OhdIBMc/RsDRSfw3P"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.66 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-290601-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[32];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,linutronix.de,lunn.ch,linux.alibaba.com,amazon.com,vger.kernel.org,kernel.org,linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EA6CE5ABA9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-ea3OhdIBMc/RsDRSfw3P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gRnJpLCAyMDI2LTA1LTE1IGF0IDE2OjQwICswMDAwLCBBcnRodXIgS2l5YW5vdnNraSB3cm90
ZToKPiAKPiArICogc3RydWN0IHB0cF9jbG9ja19hdHRyaWJ1dGVzIC0gZGVzY3JpYmVzIGFkZGl0
aW9uYWwgZGF0YSBmb3IgYSBQVFAgY2xvY2sKPiArICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGltZXN0YW1wCj4gKyAqCj4gKyAq
IEBlcnJvcl9ib3VuZDrCoMKgIFRoZSBtYXhpbXVtIHBvc3NpYmxlIGVycm9yIChpbiBuYW5vc2Vj
b25kcykgYXNzb2NpYXRlZCB3aXRoCj4gKyAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdGhlIHJlcG9ydGVkIHRpbWVzdGFtcCwgdGhpcyB2YWx1ZSBxdWFudGlmaWVzIHRoZSBpbmFj
Y3VyYWN5Cj4gKyAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb2YgdGhlIGNsb2Nr
IGF0IHRoZSB0aW1lIG9mIHJlYWRpbmcuIEEgdmFsdWUgb2YgVUlOVF9NQVgKPiArICrCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbmRpY2F0ZXMgdGhhdCB0aGUgZXJyb3IgYm91bmQg
aXMgdW5rbm93biBvciB1bmF2YWlsYWJsZS4KPiArICogQHRpbWVzY2FsZTrCoMKgwqDCoCBDbG9j
ayB0aW1lc2NhbGUgZm9yIHRpbWVzdGFtcCBpbnRlcnByZXRhdGlvbgo+ICsgKsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIChlbnVtIHB0cF9jbG9ja190aW1lc2NhbGUpLgo+ICsgKiBA
c3RhdHVzOsKgwqDCoMKgwqDCoMKgIFF1YWxpdGF0aXZlIHN5bmNocm9uaXphdGlvbiBzdGF0dXMg
b2YgdGhlIGNsb2NrCj4gKyAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKGVudW0g
cHRwX2Nsb2NrX3N0YXR1cykuCj4gKyAqIEBjb3VudGVyX2lkOsKgwqDCoCBJZGVudGlmaWVzIHRo
ZSBoYXJkd2FyZSBjb3VudGVyIHVzZWQgdG8gcHJvZHVjZQo+ICsgKsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNvdW50ZXJfdmFsdWUgKGVudW0gcHRwX2NvdW50ZXJfaWQpLgo+ICsg
KsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBUUF9DT1VOVEVSX1VOS05PV04gKDAp
IG1lYW5zIG5vIGNvdW50ZXIgaXMgYXZhaWxhYmxlLgo+ICsgKiBAcnN2OsKgwqDCoMKgwqDCoMKg
wqDCoMKgIFJlc2VydmVkIGZvciBmdXR1cmUgdXNlLCBzaG91bGQgYmUgc2V0IHRvIHplcm8uCj4g
KyAqIEBjb3VudGVyX3ZhbHVlOiBSYXcgaGFyZHdhcmUgY291bnRlciB2YWx1ZSAoZS5nLiBUU0Mg
dGlja3MpIGNhcHR1cmVkIGF0Cj4gKyAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dGhlIHRpbWUgb2YgdGhlIFBIQyB0aW1lc3RhbXAgcmVhZGluZy4gWmVybyB3aXRoCj4gKyAqwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY291bnRlcl9pZCA9PSBQVFBfQ09VTlRFUl9V
TktOT1dOIG1lYW5zIG5vdCBhdmFpbGFibGUuCj4gKyAqLwo+ICtzdHJ1Y3QgcHRwX2Nsb2NrX2F0
dHJpYnV0ZXMgewo+ICsJX191MzIgZXJyb3JfYm91bmQ7Cj4gKwlfX3U4IHRpbWVzY2FsZTsKPiAr
CV9fdTggc3RhdHVzOwo+ICsJX191OCBjb3VudGVyX2lkOwo+ICsJX191OCByc3Y7Cj4gKwlfX3U2
NCBjb3VudGVyX3ZhbHVlOwo+ICt9Owo+ICsKClRob21hcyBwb2ludHMgb3V0IHRoYXQgdGhlIGNv
dW50ZXJfaWQgYW5kIGNvdW50ZXJfdmFsdWUgZG9uJ3QgcmVhbGx5CmJlbG9uZyB0aGVyZSBpbiB0
aGUgY2xvY2sgYXR0cmlidXRlcy4KCkJldHRlciB0byB1c2UgYSBzeXN0ZW1fY291bnRlcnZhbF90
IHdoaWNoIGdvZXMgYWxvbmcgd2l0aCBlYWNoCip0aW1lc3RhbXAqLgoKSW4gZmFjdCwgSSB0aGlu
ayBpdCBuZWVkcyB0byBiZSBpbiB0aGUgc3RydWN0IHB0cF9zeXN0ZW1fdGltZXN0YW1wIGFzCml0
IHN0cmljdGx5IGdvZXMgYWxvbmcgd2l0aCBlYWNoIHRpbWVzdGFtcD8KCkFuZCB0aGUgcHRwX3Jl
YWRfc3lzdGVtX3B7cmUsb3N0fXRzKCkgaGVscGVycyBuZWVkIHRvIHVzZSB0aGUKa3RpbWVfZ2V0
X3NuYXBzaG90X2lkKCkgdGhhdCBUaG9tYXMgcG9zdGVkIGF0IHRoZSBlbmQgb2YKaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsLzg3dHNzMHZkcmouZmZzQHRnbHgvCgpJIHRoaW5rIHdlIG5lZWQg
dG8gbWFrZSBpdCBjbGVhciB0aGF0IHVubGVzcyB0aGUgaGFyZHdhcmUgZGV2aWNlCmFjdHVhbGx5
IGRvZXMgKmhhdmUqIGEgc3luY2hyb25pemVkIGNvdW50ZXIgdmFsdWUgKHRocm91Z2ggUFRNIG9y
IGJ5CmJlaW5nIGEgdmlydCBkZXZpY2UgdGhhdCB3b3JrcyB0aGF0IHdheSksIGl0ICpzaG91bGRu
J3QqIHByb3ZpZGUgYQpjb3VudGVyIHZhbHVlIGF0IGFsbCBpbiB0aGUgZGV2aWNlIHJlYWRpbmcu
Cg==


--=-ea3OhdIBMc/RsDRSfw3P
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUyMTIwMTEy
MVowLwYJKoZIhvcNAQkEMSIEIJEuhWGsvcJJSsW85fBmiR5EblgMeNRi/uVwOGgcSVkMMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAT8H26kFxZJm0
/k0gW4QUEy5ofvSRbMvnAmDDUlkDO2dQX+qaerZAsx3DvKB9fq64eGhuzyzRQI8EHM4x+en/IoKB
HOoeoD6W/krHDW+jhRU1Ih6LEQeefOINTNNHB8fsxpGIjgOlCOjdg+1+ONVuAiXK7L8Yw4Cw7YSP
hJdR0daOpmCHHuUIb7YHDlKLAJ61dCYQfWAJ4l7ntlXu7FYq3QpT42vdaur6ADnpvTBYTjG4f+ll
D5GT8kpOx3h1yLMYdzDMI9L/ByNe72j75qI4ADmWTz3lyPe/ZG6v4HLPLDiI4qeeNEz3yMREUWwM
PX6S+qa7JNLR5yNfUhB6pwCL5TPqXGFpfTuSIQr9m911IeJjyRytb5G71Q9OkRV+c5rN3aQXSPa5
Cr5nxA0g5pULrpBQSGXGq+YPq3kDwJCgZOCGmNe0eh0fzRvnqA/NryrVNcAjRuyi23+R+jLqACNH
RERGM9qUoRecUcKM7wY+CgAUhCSrL0sMpdgkBiDADDp81Xb0Tx4qToWxt7CXkkkNZBBZT48jMZ+m
Zk56kmv5V+b9NcHEaC2qyokCF+4SkTiMrIwVxEtenBSM7HuXDtD/0hq9GBD4S0+V7RgmNgfO7jRG
c4SYZyFpwHHePd0lKe8NtR7/+Nc5tI1X8gR1oHWOAJKQT0tRrkrxaosprCLVyOQAAAAAAAA=


--=-ea3OhdIBMc/RsDRSfw3P--

