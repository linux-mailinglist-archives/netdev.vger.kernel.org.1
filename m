Return-Path: <netdev+bounces-252142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPgEKw2KcWk1IAAAu9opvQ
	(envelope-from <netdev+bounces-252142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:23:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 564D460D87
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B35E844715A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545A738A708;
	Thu, 22 Jan 2026 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Q+LQcLlt"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C48C2FFFA4;
	Thu, 22 Jan 2026 02:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769048379; cv=none; b=GXOYM82nq+R2ei6LP3OKV91ckt0jF4Ha3SCFqC6+bpgV6pcN6VjEQV2vqwD2Lq2ovx1C2vUQzP98ed62XI55xU7TFb2DY0Ezu3SS7fZ4iyF9VRKbQU148AMj0UFXUtLFHnyMpdAs2IzKQeqIIDuilnTDF2T61tced+Xq6WxptvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769048379; c=relaxed/simple;
	bh=mGUXzYVzMFDbyZMW9Cy617aKBsSZtOJGIgCgcbmj9Ig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=NlFErq+TzWsQFgYJEFPH/mXNIrDk65vmetUnOnLxjTVWLUsMLkqHUb3I8tZt2Rz0mfCwS01O2fRZXm5fZWni3CgLd+J1FLiSd9mPp7KBaolfVsJpAU90/WAQK7A/03dF6F9X5xUM1pUqpr4GysEsADaLocZU7oM6WhRplv1GK4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Q+LQcLlt; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=mGUXzYVzMFDbyZMW9Cy617aKBsSZtOJGIgCgcbmj9Ig=; b=Q
	+LQcLltLQ77M8Ui2bTak8nBp6DMIFzZofaO6CLRxT1KfSKNgVR+eoLsnnNvH2mns
	IRRdgMct40QXyzQ+V54elfN5fOz8O9Fq4APYw1gGdciZ7+NnoIBYgBm0swEZTHRY
	yS+pyDVJuTFMj26f6SI9U9dXEnhM2T0wAQnpgCnxSk=
Received: from slark_xiao$163.com (
 [2409:895b:3874:c9a2:e8a9:6c3d:52dc:d224] ) by ajax-webmail-wmsvr-40-135
 (Coremail) ; Thu, 22 Jan 2026 10:18:24 +0800 (CST)
Date: Thu, 22 Jan 2026 10:18:24 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Loic Poulain" <loic.poulain@linaro.org>
Cc: ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, gustavoars@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re:Re: [net] Revert "net: wwan: mhi_wwan_mbim: Avoid
 -Wflex-array-member-not-at-end warning"
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <09efbade-24ce-4e11-ab4e-782eab4f1a71@embeddedor.com>
References: <20260120072018.29375-1-slark_xiao@163.com>
 <1228d107-4a60-4c33-a763-1a199c0b0961@embeddedor.com>
 <5e012074.84f7.19bdab162e4.Coremail.slark_xiao@163.com>
 <2fc0de60-6450-4ea3-957b-5de465a2313d@embeddedor.com>
 <1eb019f4.1033.19be352bf0c.Coremail.slark_xiao@163.com>
 <09efbade-24ce-4e11-ab4e-782eab4f1a71@embeddedor.com>
X-NTES-SC: AL_Qu2dC/yft0sr4iGdYOkfmk8Sg+84W8K3v/0v1YVQOpF8jB7owS0ObV9oIlruycGEACW+qQmsdD9S5M5TbZBxQYUoC01u9UNUglNFj3u1ZgDt9w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <34e3e90e.1f22.19be37eea29.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hygvCgBHci_wiHFpjk5cAA--.12875W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC6BAVeWlxiPCV9wAA3W
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TAGGED_FROM(0.00)[bounces-252142-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slark_xiao@163.com,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[163.com,none];
	DBL_BLOCKED_OPENRESOLVER(0.00)[embeddedor.com:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 564D460D87
X-Rspamd-Action: no action

CgpBdCAyMDI2LTAxLTIyIDEwOjE0OjQxLCAiR3VzdGF2byBBLiBSLiBTaWx2YSIgPGd1c3Rhdm9A
ZW1iZWRkZWRvci5jb20+IHdyb3RlOgo+Cj4KPk9uIDEvMjIvMjYgMTA6MzAsIFNsYXJrIFhpYW8g
d3JvdGU6Cj4+IAo+PiAKPj4gQXQgMjAyNi0wMS0yMCAxNzoyODo0MiwgIkd1c3Rhdm8gQS4gUi4g
U2lsdmEiIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPiB3cm90ZToKPj4+Cj4+Pgo+Pj4gT24gMS8y
MC8yNiAxODoxNiwgU2xhcmsgWGlhbyB3cm90ZToKPj4+Pgo+Pj4+Cj4+Pj4gQXQgMjAyNi0wMS0y
MCAxNTo1MTo1NywgIkd1c3Rhdm8gQS4gUi4gU2lsdmEiIDxndXN0YXZvQGVtYmVkZGVkb3IuY29t
PiB3cm90ZToKPj4+Pj4gSGkgU2xhcmssCj4+Pj4+Cj4+Pj4+IE9uIDEvMjAvMjYgMTY6MjAsIFNs
YXJrIFhpYW8gd3JvdGU6Cj4+Pj4+PiBUaGlzIHJldmVydHMgY29tbWl0IGVlZWNmNWQzYTNhNDg0
Y2VkZmEzZjJmODdlNmQ1MWE3MzkwZWQ5NjAuCj4+Pj4+Pgo+Pj4+Pj4gVGhpcyBjaGFuZ2UgbGVh
ZCB0byBNSEkgV1dBTiBkZXZpY2UgY2FuJ3QgY29ubmVjdCB0byBpbnRlcm5ldC4KPj4+Pj4+IEkg
Zm91bmQgYSBuZXR3cm9rIGlzc3VlIHdpdGgga2VybmVsIDYuMTktcmM0LCBidXQgbmV0d29yayB3
b3Jrcwo+Pj4+Pj4gd2VsbCB3aXRoIGtlcm5lbCA2LjE4LXJjMS4gQWZ0ZXIgY2hlY2tpbmcsIHRo
aXMgY29tbWl0IGlzIHRoZQo+Pj4+Pj4gcm9vdCBjYXVzZS4KPj4+Pj4KPj4+Pj4gVGhhbmtzIGZv
ciB0aGUgcmVwb3J0Lgo+Pj4+Pgo+Pj4+PiBDb3VsZCB5b3UgcGxlYXNlIGFwcGx5IHRoZSBmb2xs
b3dpbmcgcGF0Y2ggb24gdG9wIG9mIHRoaXMgcmV2ZXJ0LAo+Pj4+PiBhbmQgbGV0IHVzIGtub3cg
aWYgdGhlIHByb2JsZW0gc3RpbGwgbWFuaWZlc3RzPyBUaGFuayB5b3UhCj4+Pj4+Cj4+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93d2FuL21oaV93d2FuX21iaW0uYyBiL2RyaXZlcnMvbmV0
L3d3YW4vbWhpX3d3YW5fbWJpbS5jCj4+Pj4+IGluZGV4IDFkN2UzYWQ5MDBjMS4uYTI3MWE3MmZl
ZDYzIDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL25ldC93d2FuL21oaV93d2FuX21iaW0uYwo+
Pj4+PiArKysgYi9kcml2ZXJzL25ldC93d2FuL21oaV93d2FuX21iaW0uYwo+Pj4+PiBAQCAtNzgs
OSArNzgsMTIgQEAgc3RydWN0IG1oaV9tYmltX2NvbnRleHQgewo+Pj4+Pgo+Pj4+PiAgICBzdHJ1
Y3QgbWJpbV90eF9oZHIgewo+Pj4+PiAgICAgICAgICAgc3RydWN0IHVzYl9jZGNfbmNtX250aDE2
IG50aDE2Owo+Pj4+PiAtICAgICAgIHN0cnVjdCB1c2JfY2RjX25jbV9uZHAxNiBuZHAxNjsKPj4+
Pj4gLSAgICAgICBzdHJ1Y3QgdXNiX2NkY19uY21fZHBlMTYgZHBlMTZbMl07Cj4+Pj4+ICsgICAg
ICAgX19UUkFJTElOR19PVkVSTEFQKHN0cnVjdCB1c2JfY2RjX25jbV9uZHAxNiwgbmRwMTYsIGRw
ZTE2LCBfX3BhY2tlZCwKPj4+Pj4gKyAgICAgICAgICAgICAgIHN0cnVjdCB1c2JfY2RjX25jbV9k
cGUxNiBkcGUxNlsyXTsKPj4+Pj4gKyAgICAgICApOwo+Pj4+PiAgICB9IF9fcGFja2VkOwo+Pj4+
PiArc3RhdGljX2Fzc2VydChvZmZzZXRvZihzdHJ1Y3QgbWJpbV90eF9oZHIsIG5kcDE2LmRwZTE2
KSA9PQo+Pj4+PiArICAgICAgICAgICAgIG9mZnNldG9mKHN0cnVjdCBtYmltX3R4X2hkciwgZHBl
MTYpKTsKPj4+Pj4KPj4+Pj4gICAgc3RhdGljIHN0cnVjdCBtaGlfbWJpbV9saW5rICptaGlfbWJp
bV9nZXRfbGlua19yY3Uoc3RydWN0IG1oaV9tYmltX2NvbnRleHQgKm1iaW0sCj4+Pj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQg
aW50IHNlc3Npb24pCj4+Pj4gVGhpcyBwYXRjaCB3b24ndCBpbnRyb2R1Y2UgcHJldmlvdXMgcHJv
YmxlbS4KPj4+Pgo+Pj4KPj4+IFRoYW5rcyBmb3IgY29uZmlybWluZyB0aGlzLgo+Pj4KPj4+IEkn
bGwgdHVybiBpdCBpbnRvIGEgcHJvcGVyIHBhdGNoLgo+Pj4KPj4+IC1HdXN0YXZvCj4+IEhpLAo+
PiBBcmUgeW91IHBsYW5pbmcgdG8gYWRkIHRoaXMgcmV2ZXJ0IGNvbW1pdCB0byB5b3VyIGNvbWlu
ZyBwYXRjaD8KPgo+Tm8uIEkgdGhpbmsgdGhlIHJldmVydCBzaG91bGQgYmUgYXBwbGllZCBieSB0
aGUgbWFpbnRhaW5lcnMsIGZpcnN0Lgo+Cj5UaGFua3MKPi1HdXN0YXZvCj4KSGkgTG9pYywKQ291
bGQgeW91IGhlbHAgY2hlY2sgdGhpcyBjb21taXQgc3RhdHVzPwoKVGhhbmtzCj4+IEFjdHVhbGx5
IGl0J3MgdXJnZW50IHRvIHJldmVydCB0aGlzIGNoYW5nZSBzaW5jZSB0aGUgcmVsZWFzZSBkZWFk
bGluZSBvZiB2Ni4xOSBpcyBjb21pbmcgc29vbgo+PiBhbmQgYWxsIG15IE1ISSBXV0FOIGRldmlj
ZSBoYXZlIGJlZW4gaW1wYWN0ZWQuCj4+IEkgZG9uJ3Qga25vdyB3aHkgdGhpcyBjb21taXQgaGFz
IGJlZW4gdGFnZ2VkIGFzICJOb3QgQXBwbGljYWJsZSIgYW5kIHdobyBkaWQgdGhpcy4KPj4gCj4+
IEkgaG9wZSB3ZSBjYW4gZml4IGl0IHJlZ3Jlc3Npb24gYmVmb3JlIHRoZSBvZmZpY2lhbCB2Ni4x
OSByZWxlYXNlLgo+PiAKPj4gVGhhbmtzCg==

