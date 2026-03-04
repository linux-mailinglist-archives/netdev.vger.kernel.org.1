Return-Path: <netdev+bounces-263546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMWDIkeTp2meiQAAu9opvQ
	(envelope-from <netdev+bounces-263546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:04:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3522E1F9C49
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 916893055419
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 02:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA7C2405E7;
	Wed,  4 Mar 2026 02:04:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5BB1F0995;
	Wed,  4 Mar 2026 02:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772589874; cv=none; b=Z8dFoglEvfdcq+T9zLJCl0VAvLwq0k4G3Ibq2DMCH1haYl0KWnTaXtBwSMfj6hc4q2IOIgtP4P3NSxi8NW4sFyQq0d/DwJnW3nFkGLxGs8Ao4IKfXiEdzRYRPCXb1/54mQRjZ8V0beQrVxvaSBRJFgn40mfuGjDQKxLjhyT5Rgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772589874; c=relaxed/simple;
	bh=ybml9HInb4+o4VrF6ndpG1Umf4zPo60hG3kil2zXiiY=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=iOkmSz/SB27VZ9/+mgo9dmRr7Amfp8nufdsoetaMzKd3tVa4l7CXG8l4GXnasm3npCfxSKsGwjCRPnZC5KQZBBJ3dhOAPLOAiZ37dfCpdMyIn3qQRbDa9la58g7twX7ZuA7CLSVeslySMNIYhIqFcPcyESjjNWMaQxZeJntx5ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07844513|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0096324-0.000205348-0.990162;FP=13633870077576090782|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033065182171;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DW;RN=16;RT=16;SR=0;TI=W4_0.2.3_21202854_1772589537699_o7001c48e;
Received: from WS-web (Illusion.Wang@nebula-matrix.com[W4_0.2.3_21202854_1772589537699_o7001c48e] cluster:ay29) at Wed, 04 Mar 2026 10:04:18 +0800
Date: Wed, 04 Mar 2026 10:04:18 +0800
From: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: "Dimon" <dimon.zhao@nebula-matrix.com>,
  "Alvin" <alvin.wang@nebula-matrix.com>,
  "Sam" <sam.chen@nebula-matrix.com>,
  "netdev" <netdev@vger.kernel.org>,
  "andrew+netdev" <andrew+netdev@lunn.ch>,
  "corbet" <corbet@lwn.net>,
  "kuba" <kuba@kernel.org>,
  "linux-doc" <linux-doc@vger.kernel.org>,
  "lorenzo" <lorenzo@kernel.org>,
  "pabeni" <pabeni@redhat.com>,
  "horms" <horms@kernel.org>,
  "vadim.fedorenko" <vadim.fedorenko@linux.dev>,
  "lukas.bulwahn" <lukas.bulwahn@redhat.com>,
  "edumazet" <edumazet@google.com>,
  "open list" <linux-kernel@vger.kernel.org>
Reply-To: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
Message-ID: <a6a6a721-46f5-4639-a78e-9911eda1e3ba.Illusion.Wang@nebula-matrix.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIHY1IG5ldC1uZXh0IDA1LzExXSBuZXQvbmVidWxhLW1hdHJpeDog?=
  =?UTF-8?B?YWRkIGNoYW5uZWwgbGF5ZXI=?=
X-Mailer: [Alimail-Mailagent revision 1106][W4_0.2.3][null][Chrome]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260226073840.3222-1-illusion.wang@nebula-matrix.com> <20260226073840.3222-6-illusion.wang@nebula-matrix.com>,<a3cd8ff5-7545-44a8-96ac-cf7f773df66e@lunn.ch>
x-aliyun-mail-creator: W4_0.2.3_null_EuMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjY5NDMuMTQyIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4yLjE1LVJlbGVhc2UuMjYwMjI1MDAxKSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAxMjAwIEFyY2hpdGVjdHVyZS94ODZfNjQgd2ViRHQvUEM=uL
In-Reply-To: <a3cd8ff5-7545-44a8-96ac-cf7f773df66e@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: 3522E1F9C49
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nebula-matrix.com:replyto,nebula-matrix.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	DMARC_NA(0.00)[nebula-matrix.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[Illusion.Wang@nebula-matrix.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Illusion.Wang@nebula-matrix.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263546-lists,netdev=lfdr.de];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

PiA+ICsjZGVmaW5lIE5CTF9DSEFOX1RYX1JJTkdfVE9fREVTQyh0eF9yaW5nLCBpKSBcCj4gPiAr
ICgmKCgoc3RydWN0IG5ibF9jaGFuX3R4X2Rlc2MgKikoKHR4X3JpbmcpLT4gPmRlc2MpKVtpXSkp
Cj4gPiArI2RlZmluZSBOQkxfQ0hBTl9SWF9SSU5HX1RPX0RFU0MocnhfcmluZywgaSkgXAo+ID4g
KyAoJigoKHN0cnVjdCBuYmxfY2hhbl9yeF9kZXNjICopKChyeF9yaW5nKS0+ID5kZXNjKSlbaV0p
KQoKPkFyZSB0aGUgY2FzdHMgbmVlZGVkIGhlcmU/Cgo+ID4gK3N0cnVjdCBuYmxfY2hhbl90eF9k
ZXNjIHsKPiA+ICsgdTE2IGZsYWdzOwo+ID4gKyB1MTYgc3JjaWQ7Cj4gPiArIHUxNiBkc3RpZDsK
PiA+ICsgdTE2IGRhdGFfbGVuOwoKPiA+ICsgdTE2IGJ1Zl9sZW47Cgo+ID4gKyB1NjQgYnVmX2Fk
ZHI7Cj4gPiArIHUxNiBtc2dfdHlwZTsKPiA+ICsgdTggZGF0YVsxNl07Cj4gPiArIHUxNiBtc2dp
ZDsKPiA+ICsgdTggcnN2WzI2XTsKPiA+ICt9IF9fcGFja2VkOwoKPlRoaXMgaXMgYSBoYXJkd2Fy
ZSBkZXNjcmlwdG9yPyBJdCBpcyBhY3R1YWxseSBpbiBtZW1vcnkgbGlrZSB0aGlzLAo+d2l0aCB0
aGUgdTY0IGJ1Zl9hZGRyIGJhZGx5IGFsaWduZWQ/IFdoYXQgd2FzIHRoZSBoYXJkd2FyZSBlbmdp
bmVlcgo+dGhpbmtpbmc/IEp1c3Qgc3dhcHBpbmcgYnVmX2FkZHIgYW5kIGJ1Zl9sZW4gd291bGQg
b2YgbWFkZSBpdCBhIGxvdAo+YmV0dGVyLgoKPiA+ICtzdHJ1Y3QgbmJsX2NoYW5fcnhfZGVzYyB7
Cj4gPiArIHUxNiBmbGFnczsKPiA+ICsgdTMyIGJ1Zl9sZW47Cj4gPiArIHUxNiBidWZfaWQ7Cj4g
PiArIHU2NCBidWZfYWRkcjsKPiA+ICt9IF9fcGFja2VkOwoKPlNpbWlsYXJseSBiYWRseSBkZXNp
Z25lZC4KClRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjay4KU2luY2UgbmJsX2NoYW5fcmluZy0+
ZGVzYyBpcyBhIHZvaWQgKiwgY2FzdGluZyBpcyByZXF1aXJlZCBmb3IgZGlmZmVyZW50IHNjZW5h
cmlvcy4KVGhlIGRlc2lnbiBvZiBuYmxfY2hhbl90eF9kZXNjL25ibF9jaGFuX3J4X2Rlc2MgaXMg
aW5kZWVkIHBvb3IsIGJ1dCB0aGUgY2hpcCBoYXMKYWxyZWFkeSBiZWVuIHRhcGVkIG91dCAoaS5l
LiwgbWFudWZhY3R1cmVkKS4gV2UgaGF2ZSByZWNvZ25pemVkIHRoaXMgaXNzdWUgYW5kCmhhdmUg
Y29ycmVjdGVkIGl0IGluIHRoZSBuZXh0LWdlbmVyYXRpb24gY2hpcC4KCi0taWxsdXNpb24ud2Fu
Zw==

