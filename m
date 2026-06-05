Return-Path: <netdev+bounces-295579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6cqtM+4uImpTTgEAu9opvQ
	(envelope-from <netdev+bounces-295579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:05:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25376644963
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:05:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295579-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295579-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAFC530C8419
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 02:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51623E1D16;
	Fri,  5 Jun 2026 02:01:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9C23D7E6;
	Fri,  5 Jun 2026 02:00:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780624870; cv=none; b=ROvkfpvIMKU22jTnwFzWgdehmFIwO0gP+Xo+Y+xQ7LD8IbXZ2+1/0YgkSQdfo43EduQ+6c5YM8TtTwwfFwDqtDAfxJepN5Y8Yz9pO/Tg5cSETxhL9SShB2/stE9+a4H7poRPZDNYY8yrq7eZS1lQvtjkhRuWJxiAcaFMirEATRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780624870; c=relaxed/simple;
	bh=J779dFSCQWOm4dQwHstZyjULyKJinK2MiVqgv94EKK8=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=B2Chgpbew8jruSibxHoaFXzG4o5g+i/9PtDPOkpqksjr3XCvdhtPfYNhipEex0ZqXPL6bNdecbN67u+9CI4t7QvBopYhw+t+j3ry8yKJlitjpaEFrgyoTCA6C3gUxEGW3/LoOFZlq+ldjDsBHJ1G/Wl3GSJSLGlIVHbdAFRMFJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.74
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09781785|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0171234-0.00200289-0.980874;FP=12461754946603209801|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DW;RN=17;RT=17;SR=0;TI=W4_0.2.3_212D3FFB_1780624731439_o7001c596;
Received: from WS-web (Illusion.Wang@nebula-matrix.com[W4_0.2.3_212D3FFB_1780624731439_o7001c596] cluster:ay29) at Fri, 05 Jun 2026 10:00:43 +0800
Date: Fri, 05 Jun 2026 10:00:43 +0800
From: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
To: "Paolo Abeni" <pabeni@redhat.com>,
  "Dimon" <dimon.zhao@nebula-matrix.com>,
  "Alvin" <alvin.wang@nebula-matrix.com>,
  "Sam" <sam.chen@nebula-matrix.com>,
  "netdev" <netdev@vger.kernel.org>
Cc: "andrew+netdev" <andrew+netdev@lunn.ch>,
  "corbet" <corbet@lwn.net>,
  "kuba" <kuba@kernel.org>,
  "horms" <horms@kernel.org>,
  "linux-doc" <linux-doc@vger.kernel.org>,
  "vadim.fedorenko" <vadim.fedorenko@linux.dev>,
  "lukas.bulwahn" <lukas.bulwahn@redhat.com>,
  "edumazet" <edumazet@google.com>,
  "enelsonmoore" <enelsonmoore@gmail.com>,
  "skhan" <skhan@linuxfoundation.org>,
  "hkallweit1" <hkallweit1@gmail.com>,
  "open list" <linux-kernel@vger.kernel.org>
Reply-To: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
Message-ID: <1ba81af4-2051-41fc-902d-cb66217c855a.Illusion.Wang@nebula-matrix.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIHYxNyBuZXQtbmV4dCAwNS8xMV0gbmV0L25lYnVsYS1tYXRyaXg6?=
  =?UTF-8?B?IGFkZCBjaGFubmVsIGxheWVy?=
X-Mailer: [Alimail-Mailagent revision 446][W4_0.2.3][null][Chrome]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260601093149.25905-1-illusion.wang@nebula-matrix.com> <20260601093149.25905-6-illusion.wang@nebula-matrix.com>,<c5750d8a-5b37-4269-819b-1c3c04be0ddf@redhat.com>
x-aliyun-mail-creator: W4_0.2.3_null_EuMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjY5NDMuMTQyIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4zLjIwLVJlbGVhc2UuMjYwNTE0MDAyKSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAxMjAwIEFyY2hpdGVjdHVyZS94ODZfNjQgd2ViRHQvUEM=uL
In-Reply-To: <c5750d8a-5b37-4269-819b-1c3c04be0ddf@redhat.com>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[nebula-matrix.com];
	FORGED_SENDER(0.00)[Illusion.Wang@nebula-matrix.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:dimon.zhao@nebula-matrix.com,m:alvin.wang@nebula-matrix.com,m:sam.chen@nebula-matrix.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:kuba@kernel.org,m:horms@kernel.org,m:linux-doc@vger.kernel.org,m:vadim.fedorenko@linux.dev,m:lukas.bulwahn@redhat.com,m:edumazet@google.com,m:enelsonmoore@gmail.com,m:skhan@linuxfoundation.org,m:hkallweit1@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295579-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nebula-matrix.com:mid,nebula-matrix.com:from_mime,nebula-matrix.com:replyto,linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	HAS_REPLYTO(0.00)[Illusion.Wang@nebula-matrix.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Illusion.Wang@nebula-matrix.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,linux.dev,redhat.com,google.com,gmail.com,linuxfoundation.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25376644963

PiBTYXNoaWtvIHJlcG9ydHMgYSBudW1iZXIgb2YgaXNzdWVzIFdSVCB0aGUgYXRvbWljIHN0YXR1
cyB1cGRhdGVzOgo+IAo+IGh0dHBzOi8vbmV0ZGV2LWFpLmJvdHMubGludXguZGV2L3Nhc2hpa28v
Iy9wYXRjaHNldC8yMDI2MDYwMTA5MzE0OS4yNTkwNS0xLWlsbHVzaW9uLndhbmclNDBuZWJ1bGEt
bWF0cml4LmNvbQoKPiBJdCdzIGluZGVlZCBxdWl0ZSBjb21wbGV4IHRvIGdldCB0aGluZ3Mgcmln
aHQgdGhpcyB3YXkuIEknbSB3b25kZXJpbmcgaWYKPiB5b3Ugc2hvdWxkIHVzZSBhIHNwaW5fbG9j
ayBpbnN0ZWFkIHRvIHByb3RlY3QgdGhlIHJlbGV2YW50IHN0YXRlPwoKPiBBbHNvIGEgZmV3IHBy
b2Nlc3MgcmVsYXRlZCBub3RlczoKPiAtIHRvIG1ha2UgZWZmZWN0aXZlIHByb2dyZXNzZXMgeW91
IHNob3VsZCBwcm9hY3RpdmVseSByZXBseSBvbiB0aGUgTUwgV1JUCj4gdGhlIHNhc2hpa28gY29t
bWVudHMgZGlzY3Vzc2lvbiBpZiBhbmQgd2h5IHRoZXkgYXJlIChub3QpIHJlbGV2YW50Lgo+IC0g
aXMgJ2lsbHVzaW9uIHdhbmcnIChhbGwgbG93ZXIgY2FzZSkgeW91ciByZWFsIG5hbWU/IHdlIGNh
bid0IGFjY2VwdAo+IHBzZXVkb25pbXMgYXMgU29CIHRhZy4KClRoYW5rIHlvdSBmb3IgeW91ciBm
ZWVkYmFjay4KWWVzLCBJJ3ZlIHJldmlld2VkIHRoZSBTYXNoaWtvIHJlcG9ydC4gVGhlIGF0b21p
YyBzdGF0dXMgdXBkYXRlIHJhY2UgaXMgcmVhbDoKbmJsX2NoYW5fcmVjdl9hY2tfbXNnIHdyaXRl
cyBzdGF0dXMgYW5kIG5lZWRfd2FrZWQgd2hpbGUgbmJsX2NoYW5fc2VuZF9tc2cKbWF5IHJlYWQv
Y2xlYXIgdGhlbSwgd2l0aCBubyBvcmRlcmluZyBndWFyYW50ZWUgYmV0d2VlbiB0aGUgdHdvIGF0
b21pY3MuClRoZSBzcGlubG9jayBmaXggYWRkcmVzc2VzIGV4YWN0bHkgd2hhdCBTYXNoaWtvIGZs
YWdnZWQuCkknbGwgdXBkYXRlIHRoZSBwYXRjaHNldCBhY2NvcmRpbmdseS4KcHM6ICJpbGx1c2lv
biB3YW5nIiBpcyBpbmRlZWQgbXkgcmVhbCBuYW1lLg==

