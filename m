Return-Path: <netdev+bounces-268437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBIEKtzduGlSkgEAu9opvQ
	(envelope-from <netdev+bounces-268437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 05:51:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F24A2A3D4A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 05:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C2EE300C0CD
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7770936C5BD;
	Tue, 17 Mar 2026 04:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="BGxjIVx0"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4E134F279;
	Tue, 17 Mar 2026 04:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773723098; cv=none; b=c7Ml+2ZhafhUt9eKSH2dGLUmuziQap2INskJVbYAQobhgD+iHqNO6PGCgtMM6otpO9OJhflKX4y0EqSh0keDIwGYV9Otst3g7wIo+sBXncJfl5NaGoGsFMgL6NNTDhkldoMMvzPpW4obDVdogmO/ZkuuCZrz0X7OTWClNgRci94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773723098; c=relaxed/simple;
	bh=bjBO2MewXCjuUYMwIotAwScnESYXa90VTTbegDBcfBQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EsAu4H3bEn9jb7Tqce3f9Odjev6WCjCb1bKoYJGyzbUQSnx25lJVRUdCZ/Dui7Buq169wUkr0IVVEch/bIC2rnC8fUO3BsHMN5fj2Y1IAoSdlrijANlyYmQbfXyenha9i/ZKaH2ao6rBjJ3XBPln0ehOZ0zmzA4zEXe0NcS9Di0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=BGxjIVx0; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1773723089;
	bh=bjBO2MewXCjuUYMwIotAwScnESYXa90VTTbegDBcfBQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BGxjIVx066cdPHZ2q/jYHqKcouTqa6oqGYBwYThbGx9h2RcbKic4txS1lGXQQglgX
	 Yd4IIDQyHhb8AU9w0O+wdL/k9mxqLRn0gADW3bFZ6oBJvoXuCs+qXatTb4SeDZl7YW
	 rw3aPhhwZtaYJhIjrwP0BHWoQk5YJzVEtzkpMFYNsME6+WHwQGUyIUwk3si8oiAv0X
	 tqBCQKX1cLZMFNqCHAYwISQzpGFuEsK+SEIehbVyIXZK+8Rqh540sGn0QV5Ol1xPY1
	 2ahEDRCnpWM+/CsqNEmMFlHYwgwAMNnITjQ9LSiou4JGL5t9uRs18YfgDjwpMya+OR
	 Ce0DbMeDzi7DA==
Received: from [192.168.72.167] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1105960BA5;
	Tue, 17 Mar 2026 12:51:27 +0800 (AWST)
Message-ID: <73277cce3afbc784f3aeed69da3c39a0659d562f.camel@codeconstruct.com.au>
Subject: Re: [net-next v33 1/1] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@os.amperecomputing.com>, Matt Johnston
 <matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Huisong Li <lihuisong@huawei.com>
Date: Tue, 17 Mar 2026 12:51:27 +0800
In-Reply-To: <20260316035626.363698-2-admiyo@os.amperecomputing.com>
References: <20260316035626.363698-1-admiyo@os.amperecomputing.com>
	 <20260316035626.363698-2-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.56 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268437-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F24A2A3D4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgQWRhbSwKClNvbWUgY29tbWVudHMgaW5saW5lLgoKPiArc3RhdGljIHZvaWQgbWN0cF9wY2Nf
Y2xpZW50X3J4X2NhbGxiYWNrKHN0cnVjdCBtYm94X2NsaWVudCAqY2wsIHZvaWQgKm1zc2cpCj4g
K3sKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYWNwaV9wY2N0X2V4dF9wY2Nfc2hhcmVkX21lbW9y
eSBwY2NfaGVhZGVyOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBtY3RwX3BjY19uZGV2ICptY3Rw
X3BjY19uZGV2Owo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBtY3RwX3BjY19tYWlsYm94ICppbmJv
eDsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbWN0cF9za2JfY2IgKmNiOwo+ICvCoMKgwqDCoMKg
wqDCoHN0cnVjdCBza19idWZmICpza2I7Cj4gK8KgwqDCoMKgwqDCoMKgaW50IHNpemU7Cj4gKwo+
ICvCoMKgwqDCoMKgwqDCoG1jdHBfcGNjX25kZXYgPSBjb250YWluZXJfb2YoY2wsIHN0cnVjdCBt
Y3RwX3BjY19uZGV2LCBpbmJveC5jbGllbnQpOwo+ICvCoMKgwqDCoMKgwqDCoGluYm94ID0gJm1j
dHBfcGNjX25kZXYtPmluYm94Owo+ICvCoMKgwqDCoMKgwqDCoG1lbWNweV9mcm9taW8oJnBjY19o
ZWFkZXIsIGluYm94LT5jaGFuLT5zaG1lbSwgc2l6ZW9mKHBjY19oZWFkZXIpKTsKPiArwqDCoMKg
wqDCoMKgwqBzaXplID0gcGNjX2hlYWRlci5sZW5ndGggLSBzaXplb2YodTMyKTsKClNpbmNlIHNp
emUgaXMgc2lnbmVkLCB0aGlzIG1heSBiZSBuZWdhdGl2ZS4uLgoKKGFsc28sIHdoeSBzaXplb2Yo
dTMyKSBoZXJlPyBmcm9tIHRoZSBzcGVjLCBpdCBzZWVtcyBsaWtlIHlvdSdyZQp0cmltbWluZyB0
aGUgc2lnbmF0dXJlIGhlcmUsIHNvIE1DVFBfU0lHTkFUVVJFX0xFTkdUSCB3b3VsZCBiZSBtb3Jl
CmFwcHJvcHJpYXRlPyBvciBzaXplb2YocGNjX2hlYWRlci5jb21tYW5kKT8pCgo+ICsKPiArwqDC
oMKgwqDCoMKgwqBpZiAoc2l6ZSA9PSAwKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm47CgouLi4gd2hpY2ggd29uJ3QgZ2V0IHBpY2tlZCB1cCBoZXJlCgo+ICsKPiArwqDC
oMKgwqDCoMKgwqBpZiAoc3RybmNtcCgodW5zaWduZWQgY2hhciAqKSZwY2NfaGVhZGVyLmNvbW1h
bmQsIE1DVFBfU0lHTkFUVVJFLCA0KSAhPSAwKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGRldl9kc3RhdHNfcnhfZHJvcHBlZChtY3RwX3BjY19uZGV2LT5uZGV2KTsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuOwo+ICvCoMKgwqDCoMKgwqDCoH0KCldl
IHNob3VsZG4ndCByZWFsbHkgYmUgdHJlYXRpbmcgdGhlIHNpZ25hdHVyZSBhcyBhIHN0cmluZywg
anVzdCBtZW1jbXAoKQppbnN0ZWFkIG9mIHN0cm5jbXAoKS4gWW91IGNvdWxkIGFsc28gY29uc2lk
ZXIgdXNpbmcgYSB1MzIgKGFwcHJvcHJpYXRlbHkKY29tbWVudGVkKSBpbnN0ZWFkIG9mIHRoZSBz
dHJpbmcgZm9yIE1DVFBfU0lHTkFUVVJFLCBhbmQgZG9pbmcgYSBkaXJlY3QKY29tcGFyaXNvbiB3
aXRoIHBjY19oZWFkZXIuY29tbWFuZC4KCjQgLT4gTUNUUF9TSUdOQVRVUkVfTEVOR1RILCBvciB3
aGF0ZXZlciB5b3UgY2hvc2UgZm9yIHRoZSBhYm92ZS4KCj4gKwo+ICvCoMKgwqDCoMKgwqDCoGlm
IChzaXplID4gbWN0cF9wY2NfbmRldi0+bmRldi0+bXR1KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBkZXZfZGJnKGNsLT5kZXYsICJNQ1RQX1BDQyBieXRlcyBhdmFpbGFibGUgZXhj
ZWVkcyBNVFUiKTsKCihJIGFzc3VtZSB3ZSdyZSBmaW5lIHRvIHJlY2VpdmUgbGFyZ2VyLXRoYW4t
TVRVIHBhY2tldHMsIGluIHdoaWNoCmNhc2UgcHJvYmFibHkgZG9uJ3QgbmVlZCB0aGUgZGV2X2Ri
Zz8pCgo+ICsKPiArwqDCoMKgwqDCoMKgwqBza2IgPSBuZXRkZXZfYWxsb2Nfc2tiKG1jdHBfcGNj
X25kZXYtPm5kZXYsIHNpemUpOwoKLi4uIHdpdGggdGhlIG5lZ2F0aXZlIHNpemUsIHRoaXMgd2ls
bCBlbmQgdXAgYXMgYSBodWdlIGF0dGVtcHRlZAphbGxvY2F0aW9uIGhlcmUuCgpNYXliZSBjaGFu
Z2UgdGhlIGFib3ZlIGNoZWNrIGZvciBwY2NfaGVhZGVyLmxlbmd0aCA+IHNpemVvZih3aGF0ZXZl
ciksCmluc3RlYWQgb2Ygc3VidHJhY3RpbmcgdGhlIHNpemVvZigpIGZpcnN0LCBzbyB5b3UgY2Fu
bm90IHVuZGVyZmxvdy4KVGhlbiwgdXNlIGFuIHVuc2lnbmVkIHR5cGUgZm9yIHNpemUuCgo+ICvC
oMKgwqDCoMKgwqDCoGlmICghc2tiKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGRldl9kc3RhdHNfcnhfZHJvcHBlZChtY3RwX3BjY19uZGV2LT5uZGV2KTsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiArwqDCoMKg
wqDCoMKgwqBza2JfcHV0KHNrYiwgc2l6ZSk7Cj4gK8KgwqDCoMKgwqDCoMKgc2tiLT5wcm90b2Nv
bCA9IGh0b25zKEVUSF9QX01DVFApOwo+ICvCoMKgwqDCoMKgwqDCoG1lbWNweV9mcm9taW8oc2ti
LT5kYXRhLCBpbmJveC0+Y2hhbi0+c2htZW0gKyBzaXplb2YocGNjX2hlYWRlciksCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZSk7CgpNaW5vcjogVGhpcyBz
ZWVtcyBvZGRseS13cmFwcGVkLCBhcyB5b3UgaGF2ZSBsb25nZXIgbGluZXMgYWJvdmUuCgo+ICvC
oMKgwqDCoMKgwqDCoGRldl9kc3RhdHNfcnhfYWRkKG1jdHBfcGNjX25kZXYtPm5kZXYsIHNrYi0+
bGVuKTsKCllvdXIgUlggc3RhdHMgZG8gbm90IGluY2x1ZGUgdGhlIFBDQyBoZWFkZXIsIGJ1dCB5
b3VyIFRYIHN0YXRzIGRvLgoKSSB3b3VsZCBzdWdnZXN0IG1ha2luZyB0aGUgU0tCIGxheW91dCBj
b25zaXN0ZW50IChpZS4sIHByZXNlbmNlIG9mIHRoZQp0cmFuc3BvcnQgaGVhZGVyKSBhY3Jvc3Mg
VFggYW5kIFJYLiBJbmNsdWRlIHRoZSBwY2MgaGVhZGVyIGluCnRoZSBSWCBza2IgZGF0YSAod2hp
Y2ggeW91IGRvIGluIHRoZSBUWCBwYXRoKSwgYW5kIHVzZSBza2ItPmxlbiBmb3IgYm90aApUWCBh
bmQgUlggYWNjb3VudGluZy4KCkNoZWVycywKCgpKZXJlbXkK


