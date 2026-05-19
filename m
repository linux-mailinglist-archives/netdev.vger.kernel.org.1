Return-Path: <netdev+bounces-289266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHIsHM7hC2qzPwUAu9opvQ
	(envelope-from <netdev+bounces-289266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:06:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A045771B8
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EE7C30398AA
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 04:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F42D47FF;
	Tue, 19 May 2026 04:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="VdCskvjt"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB841C5D59;
	Tue, 19 May 2026 04:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779163594; cv=none; b=fR2F2k2neyg/mvwom4iVhBcVy3XBeSnjVKtnkb0Lq9d/2vWJ0PHTQFI5lri1dpMO7JJB91j8G7UP4JBJtSnj960exxUlzsjbsT1ZIth5788RzDqitw+24YyqWF+s6ZsdKq0ntl8ZRbUIbzr7CQWOPAkEw61/FlJFuWY1i5nl9+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779163594; c=relaxed/simple;
	bh=a0FFF8UWIgGnE2Sg2dQt5JXH3hA5G4j19E/rDP378CQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JrrEtVAE8G0qFHON5IiT93Nji4Cl3BIchfrY9g8SV2dA045nRhzOkKrQjpjLwY4pHFHmyQ/xzQZvo/2PvhY+siCouDL8+RkZa+F4J+OfpErENL62xfjEw4zVWPvuUAj9gCPRFgWABOgyaWYDii9kp1xoa2aOd+7VoEThJTHzmq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=VdCskvjt; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1779163584;
	bh=a0FFF8UWIgGnE2Sg2dQt5JXH3hA5G4j19E/rDP378CQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VdCskvjtfkRPR1ypTEVetgKvX6GR5eUrfE+8xMsp6PLB6rZPVjwwSLzxBNXufL6h8
	 7eV4v0Z1LExj+yJxJMTu0QtHnCHwC2Fvu6sixGvy6g5NNh0mB7Fnftk2lid+c40Q4F
	 3b9nECtRpI9SYbYEieLctL6x9qi29Zj1OoROU0ih4UWBIvnve1uAgb0Ze0WT+z+hD+
	 GyaegA4ylBL4W7xGuqtzZxlQWNUBdjkwdvTV+gQ+S/FUA0fGkZTe34ilqCZvcTlSx5
	 zO2G4AezGdf5qyQ47NagRxiGrHcwY0oVyilWGnApK6dP3Irhe1enlH44ZzQEWMFJie
	 OBpSUR/U/SqJw==
Received: from [10.36.158.48] (unknown [50.175.227.221])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DDA83605C8;
	Tue, 19 May 2026 12:06:19 +0800 (AWST)
Message-ID: <bca423e86899791f96c626b10f816ac1bff8059e.camel@codeconstruct.com.au>
Subject: Re: [net-next v42] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@os.amperecomputing.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Matt Johnston <matt@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Huisong Li <lihuisong@huawei.com>
Date: Mon, 18 May 2026 21:06:17 -0700
In-Reply-To: <20260518203900.30720-1-admiyo@os.amperecomputing.com>
References: <20260518203900.30720-1-admiyo@os.amperecomputing.com>
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
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289266-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codeconstruct.com.au:mid,codeconstruct.com.au:dkim]
X-Rspamd-Queue-Id: C0A045771B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgQWRhbSwKCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL3N0WU5G
ckNUIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvc3RZTkZyQ1QKPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NAo+IGluZGV4IDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAu
LjliMDFkMWU5MDlmMjBmZTAzN2VlYTY4NTExNmQzNDRhMjE2NWRiNTIKPiBHSVQgYmluYXJ5IHBh
dGNoCj4gbGl0ZXJhbCA1NjQwNzMKClsxMjU1IGxpbmVzIG9mIGI4NSBkYXRhXQoKSSB0aGluayBz
b21ldGhpbmcgbGVha2VkIGludG8geW91ciBjb21taXQ/Cgo+ICtzdGF0aWMgdm9pZCBtY3RwX3Bj
Y19jbGllbnRfcnhfY2FsbGJhY2soc3RydWN0IG1ib3hfY2xpZW50ICpjbCwgdm9pZCAqbXNzZykK
PiArewo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBhY3BpX3BjY3RfZXh0X3BjY19zaGFyZWRfbWVt
b3J5IHBjY19oZWFkZXI7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IG1jdHBfcGNjX25kZXYgKm1j
dHBfcGNjX25kZXY7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IG1jdHBfcGNjX21haWxib3ggKmlu
Ym94Owo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBtY3RwX3NrYl9jYiAqY2I7Cj4gK8KgwqDCoMKg
wqDCoMKgc3RydWN0IHNrX2J1ZmYgKnNrYjsKPiArwqDCoMKgwqDCoMKgwqB1MzIgaGVhZGVyX2xl
bmd0aDsKPiArwqDCoMKgwqDCoMKgwqBpbnQgc2l6ZTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgbWN0
cF9wY2NfbmRldiA9IGNvbnRhaW5lcl9vZihjbCwgc3RydWN0IG1jdHBfcGNjX25kZXYsIGluYm94
LmNsaWVudCk7Cj4gK8KgwqDCoMKgwqDCoMKgaW5ib3ggPSAmbWN0cF9wY2NfbmRldi0+aW5ib3g7
Cj4gK8KgwqDCoMKgwqDCoMKgbWVtY3B5X2Zyb21pbygmcGNjX2hlYWRlciwgaW5ib3gtPmNoYW4t
PnNobWVtLCBzaXplb2YocGNjX2hlYWRlcikpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqAvLyBUaGUg
bWVzc2FnZSBtdXN0IGF0IGxlYXN0IGhhdmUgdGhlIFBDQyBjb21tYW5kIGluZGljYXRpbmcgaXQg
aXMgYW4gTUNUUAo+ICvCoMKgwqDCoMKgwqDCoC8vIG1lc3NhZ2UgZm9sbG93ZWQgYnkgdGhlIE1D
VFAgaGVhZGVyLCBvciB3ZSBoYXZlIGEgbWFsZm9ybWVkIG1lc3NhZ2UuCj4gK8KgwqDCoMKgwqDC
oMKgLy8gVGhpcyBtYXkgYmUgcnVuIG9uIGJpZyBlbmRpYW4gc3lzdGVtLCBidXQgdGhlIGRhdGEg
aW4gdGhlIGJ1ZmZlciBpcwo+ICvCoMKgwqDCoMKgwqDCoC8vIGV4cGxpY2l0bHkgbGl0dGxlIGVu
ZGlhbi4KPiArwqDCoMKgwqDCoMKgwqBoZWFkZXJfbGVuZ3RoID0gbGUzMl90b19jcHUocGNjX2hl
YWRlci5sZW5ndGgpOwoKSXMgdGhpcyBzdGlsbCBPSyB3aXRoIHBjY19oZWFkZXIubGVuZ3RoIGJl
aW5nIGEgdTMyIChhbmQgbm90IGEgX19sZTMyPykKCj4gK3N0YXRpYyBuZXRkZXZfdHhfdCBtY3Rw
X3BjY190eChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqbmRldikKPiAr
ewo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBhY3BpX3BjY3RfZXh0X3BjY19zaGFyZWRfbWVtb3J5
ICpwY2NfaGVhZGVyOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBtY3RwX3BjY19uZGV2ICptcG5k
ID0gbmV0ZGV2X3ByaXYobmRldik7Cj4gK8KgwqDCoMKgwqDCoMKgaW50IGxlbiA9IHNrYi0+bGVu
Owo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAoc2tiX2Nvd19oZWFkKHNrYiwgc2l6ZW9mKCpwY2Nf
aGVhZGVyKSkpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gZXJyb3I7Cj4g
Kwo+ICvCoMKgwqDCoMKgwqDCoHBjY19oZWFkZXIgPSBza2JfcHVzaChza2IsIHNpemVvZigqcGNj
X2hlYWRlcikpOwo+ICvCoMKgwqDCoMKgwqDCoHBjY19oZWFkZXItPnNpZ25hdHVyZSA9IFBDQ19T
SUdOQVRVUkUgfCBtcG5kLT5vdXRib3guaW5kZXg7Cj4gK8KgwqDCoMKgwqDCoMKgcGNjX2hlYWRl
ci0+ZmxhZ3MgPSBQQ0NfQ01EX0NPTVBMRVRJT05fTk9USUZZOwo+ICvCoMKgwqDCoMKgwqDCoG1l
bWNweSgmcGNjX2hlYWRlci0+Y29tbWFuZCwgTUNUUF9TSUdOQVRVUkUsIE1DVFBfU0lHTkFUVVJF
X0xFTkdUSCk7Cj4gK8KgwqDCoMKgwqDCoMKgcGNjX2hlYWRlci0+bGVuZ3RoID0gbGVuICsgTUNU
UF9TSUdOQVRVUkVfTEVOR1RIOwoKWW91J3JlIGRvaW5nIHRoZSBlbmRpYW4gY29udmVyc2lvbiBv
biByZWFkLCBidXQgbm90IG9uIHdyaXRlLiBXaGF0IHdhcwp0aGUgZGVjaXNpb24gb24gd2hldGhl
ciB5b3UgbmVlZCBpdCBvciBub3Q/Cgo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAoc2tiLT5sZW4g
PiBtcG5kLT5vdXRib3guY2hhbi0+c2htZW1fc2l6ZSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZ290byBlcnJvcjsKPiArCj4gK8KgwqDCoMKgwqDCoMKgaWYgKG1ib3hfc2VuZF9t
ZXNzYWdlKG1wbmQtPm91dGJveC5jaGFuLT5tY2hhbiwgc2tiKSA8IDApIHsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgbmV0aWZfc3RvcF9xdWV1ZShuZGV2KTsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgLyoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICogVGhlcmUgaXMgYSBwb3NzaWJpbGl0eSB0aGF0IHRoZSBtYWlsYm94IHdhcyBjbGVhcmVkIG9u
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGFub3RoZXIgdGhyZWFkIGJldHdl
ZW4gdGhlIGZhaWxlZCBzZW5kIGF0dGVtcHQgYW5kCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAqIHN0b3BwaW5nIHRoZSBxdWV1ZS7CoCBJZiB0aGF0IGlzIHRoZSBjYXNlLCBhbmQg
d2UgZG9uJ3QgcmVzdGFydAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB0aGUg
cXVldWUsIGl0IHdpbGwgcmVtYWluIHBlcm1hbmVudGx5IHN0b3BwZWQuwqAgVG8gdGVzdCwKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogdHJ5IHN1Ym1pdHRpbmcgdGhlIG1lc3Nh
Z2UgYWdhaW4uIElmIHN1Y2Nlc3NmdWwsIHJlc3RhcnQgdGhlCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAqIHF1ZXVlLgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Ki8KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKG1ib3hfc2VuZF9tZXNzYWdl
KG1wbmQtPm91dGJveC5jaGFuLT5tY2hhbiwgc2tiKSA+PSAwKSB7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuZXRpZl93YWtlX3F1ZXVlKG5kZXYpOwoK
VGhlIHJldHJ5IGlzIGEgYml0IG9kZDsgeW91IGNhbiBzaW1wbGlmeSB0aGlzIHJhY2UgaGFuZGxp
bmcgYnkgZG9pbmcgdGhlCnN0b3BfcXVldWUgcGVzc2ltaXN0aWNhbGx5LCBhbmQgdGhlIHJlLXN0
YXJ0aW5nIHRoZSBxdWV1ZSBvbiBzdWNjZXNzOgoKICAgIG5ldGlmX3N0b3BfcXVldWUoKTsKICAg
IGlmIChtYm94X3NlbmRfbWVzc2FnZSguLi4pID49IDApIHsKICAgICAgICBuZXRpZl9zdGFydF9x
dWV1ZSgpOwogICAgfQoKSSBkb24ndCB0aGluayB5b3UgbmVlZCBhIHdha2UgKHZzIHN0YXJ0KSwg
c2luY2UgeW91J3JlIHJ1bm5pbmcgaW4gdGhlCnNhbWUgc29mdGlycSBjb250ZXh0IGFzIHRoZSBz
dG9wLgoKQ2hlZXJzLAoKCkplcmVteQo=


