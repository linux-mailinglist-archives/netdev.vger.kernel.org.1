Return-Path: <netdev+bounces-281008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F7mAqKR62lGOgAAu9opvQ
	(envelope-from <netdev+bounces-281008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:52:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C39C46103E
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 896E6301F4B5
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 15:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE093D9DBA;
	Fri, 24 Apr 2026 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="uM69jLxK"
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566BB3BFE52;
	Fri, 24 Apr 2026 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045257; cv=none; b=EgJEuDa8POnBx43k/+yLXQV10MyyM+HFxg0BQYQQTEzVPP3TZq/RQLI94S2S99YZnJ1U5H3yFdSg6Q7fhRwJHYmAl6qvxqpI3nBRHROr8rUM6MyLVPq3KprpNNL/lsvoQw9SYGz8TXMWzvLq1j2vQYgCFvCsVF9FhudI0LKfkrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045257; c=relaxed/simple;
	bh=KuesuZ/9uytPoIdU4uiXOiECwS1v2eT2N1Igt6w/PE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=sEOH+5SJJOh1ieOdmmcaPErfCKJlrn0/Mi39N6IbjFlt5QmV6Az7ZXThS8yrAsJ+n0upU8quuS4/gPQ4vvLHXgFwLnlfFNwNPHT1DsPTbfiFhZ+YG7++m/rrmq5QdmnTSX6ewR4u8Y8Vtd6JHIiqHjaBzobY+mF7D3KWn6HCKT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=uM69jLxK reason="key not found in DNS"; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
	In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID; bh=1tG1s0cy7ku5xrhB1FJz8J99kWLTfwog8GUi
	2B6kpbQ=; b=uM69jLxKvP9xr1EfWMF0fWAQCMSnfC6D5iFJYbUekVtbhLeoDtfQ
	R6Evh96pqqYyBlSMAfALgxZl5t0LV24M0Bl5N/j2D+auXgA42y1wl0tMDA2Qdyh3
	yejKBNlE9IY35ZsBU9IC3dGUW9kmzqtts+DDC1niBmNTRALY+qFFu1E=
Received: from 25181214217$stu.xidian.edu.cn ( [113.200.174.80] ) by
 ajax-webmail-hzbj-edu-front-4.icoremail.net (Coremail) ; Fri, 24 Apr 2026
 23:40:21 +0800 (GMT+08:00)
Date: Fri, 24 Apr 2026 23:40:21 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?546L5piO54Wc?= <25181214217@stu.xidian.edu.cn>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.com"
 <syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"sd@queasysnail.net" <sd@queasysnail.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: Re: Re: Re: [PATCH v2] ipv6: fix memory leak in
 __ip6_make_skb() when queue is empty
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250410(2f5ccd7f) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-8dfce572-2f24-404d-b59d-0dd2e304114c-icoremail.cn
In-Reply-To: <68628d54304821fe8410e756ce3f92c60da10e1d.camel@siemens.com>
References: <20260423082233.514056-1-25181214217@stu.xidian.edu.cn>
 <willemdebruijn.kernel.28284ffff84dc@gmail.com>
 <2ebe2714.7628.19dbd7d2b62.Coremail.25181214217@stu.xidian.edu.cn>
 <5eabb1a1.7642.19dbd869da3.Coremail.25181214217@stu.xidian.edu.cn>
 <68628d54304821fe8410e756ce3f92c60da10e1d.camel@siemens.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <378c89ac.7c26.19dc0263038.Coremail.25181214217@stu.xidian.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:BrQMCkCGLrrmjutpaie+AQ--.44483W
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUNEWnqN9lzE
	QADsU
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Queue-Id: 7C39C46103E
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.44 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	DMARC_POLICY_QUARANTINE(1.50)[xidian.edu.cn : SPF not aligned (relaxed),quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281008-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_PERMFAIL(0.00)[stu.xidian.edu.cn:s=dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	DKIM_TRACE(0.00)[stu.xidian.edu.cn:~];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e5d6936b9f4545fd88ab];
	FROM_NEQ_ENVFROM(0.00)[25181214217@stu.xidian.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,davemloft.net,kernel.org,queasysnail.net,vger.kernel.org,google.com,redhat.com];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.996];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Spam: Yes

SGkgRmxvcmlhbiBhbmQgU2FicmluYSwKCkkgY2hlY2tlZCB0aGUgc3RhYmxlIGJyYW5jaGVzIGZv
ciBhIHBvdGVudGlhbCBiYWNrcG9ydC4gSXQgdHVybnMgb3V0IG5vIGJhY2twb3J0IGlzIG5lZWRl
ZCBiZWNhdXNlIHRoZSBzdGFibGUgdHJlZXMgYXJlIG5vdCBhZmZlY3RlZCBieSB0aGlzIHNwZWNp
ZmljIGxlYWsgcGF0aC4KCkxvb2tpbmcgY2xvc2VseSBhdCBgaXA2X3NldHVwX2NvcmsoKWAgaW4g
dGhlIHN0YWJsZSB0cmVlcywgYGNvcmstPmJhc2UuZHN0ID0gJnJ0LT5kc3Q7YCBpcyBhc3NpZ25l
ZCBhdCB0aGUgdmVyeSBiZWdpbm5pbmcgb2YgdGhlIGZ1bmN0aW9uLiAKCklmIGEgc3Vic2VxdWVu
dCBtZW1vcnkgYWxsb2NhdGlvbiBmYWlscyAoZS5nLiwgYGt6YWxsb2NgIGZhaWxpbmcgZHVlIHRv
IGZhaWxzbGFiKSwgaXQgcmV0dXJucyBgLUVOT0JVRlNgLCBidXQgdGhlIGBkc3RgIHJlZmVyZW5j
ZSBpcyBhbHJlYWR5IGxpbmtlZCB0byB0aGUgY29yay4gV2hlbiBgaXA2X21ha2Vfc2tiKClgIGNh
dGNoZXMgdGhpcyBlcnJvciwgaXQgY2FsbHMgYGlwNl9jb3JrX3JlbGVhc2UoY29yaywgJnY2X2Nv
cmspYCwgd2hpY2ggc3VjY2Vzc2Z1bGx5IGZyZWVzIHRoZSBgZHN0YC4KCkFzIFNhYnJpbmEgY29y
cmVjdGx5IHBvaW50ZWQgb3V0IHJlZ2FyZGluZyBteSB2MSwgYWRkaW5nIGFuIGV4cGxpY2l0IGBk
c3RfcmVsZWFzZSgpYCBoZXJlIHdvdWxkIGFjdHVhbGx5IGNhdXNlIGEgZG91YmxlIGZyZWUuCgpU
aGUgb3JpZ2luYWwgc3l6Ym90IG1lbW9yeSBsZWFrIHJlcG9ydCB1bmRlciBgZmFpbHNsYWJgIHNl
ZW1zIHRvIGJlIGEgZmFsc2UgcG9zaXRpdmUgb3IgcmVsYXRlZCB0byBhIGRpZmZlcmVudCBvYmpl
Y3QgZW50aXJlbHkuIFRoZSBgZHN0X2VudHJ5YCBoYW5kbGluZyBpbiB0aGlzIGVycm9yIHBhdGgg
aXMgYWxyZWFkeSByb2J1c3QuIAoKVGhpcyBpc3N1ZSBjYW4gYmUgY2xvc2VkIHdpdGhvdXQgYW55
IHBhdGNoZXMuIFRoYW5rcyBmb3IgdGhlIGRpc2N1c3Npb24uCgpCZXN0IHJlZ2FyZHMsCk1pbmd5
dSBXYW5nCgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiQmV6ZGVrYSwg
RmxvcmlhbiIgPGZsb3JpYW4uYmV6ZGVrYUBzaWVtZW5zLmNvbT4KPiDlj5HpgIHml7bpl7Q6MjAy
Ni0wNC0yNCAxNDo1NjozNSAo5pif5pyf5LqUKQo+IOaUtuS7tuS6ujogIndpbGxlbWRlYnJ1aWpu
Lmtlcm5lbEBnbWFpbC5jb20iIDx3aWxsZW1kZWJydWlqbi5rZXJuZWxAZ21haWwuY29tPiwgIjI1
MTgxMjE0MjE3QHN0dS54aWRpYW4uZWR1LmNuIiA8MjUxODEyMTQyMTdAc3R1LnhpZGlhbi5lZHUu
Y24+Cj4g5oqE6YCBOiAic3l6Ym90K2U1ZDY5MzZiOWY0NTQ1ZmQ4OGFiQHN5emthbGxlci5hcHBz
cG90bWFpbC5jb20iIDxzeXpib3QrZTVkNjkzNmI5ZjQ1NDVmZDg4YWJAc3l6a2FsbGVyLmFwcHNw
b3RtYWlsLmNvbT4sICJkYXZlbUBkYXZlbWxvZnQubmV0IiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4s
ICJkc2FoZXJuQGtlcm5lbC5vcmciIDxkc2FoZXJuQGtlcm5lbC5vcmc+LCAic2RAcXVlYXN5c25h
aWwubmV0IiA8c2RAcXVlYXN5c25haWwubmV0PiwgImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmciIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPiwgIm5ldGRldkB2Z2VyLmtlcm5lbC5v
cmciIDxuZXRkZXZAdmdlci5rZXJuZWwub3JnPiwgImhvcm1zQGtlcm5lbC5vcmciIDxob3Jtc0Br
ZXJuZWwub3JnPiwgImVkdW1hemV0QGdvb2dsZS5jb20iIDxlZHVtYXpldEBnb29nbGUuY29tPiwg
Imt1YmFAa2VybmVsLm9yZyIgPGt1YmFAa2VybmVsLm9yZz4sICJwYWJlbmlAcmVkaGF0LmNvbSIg
PHBhYmVuaUByZWRoYXQuY29tPgo+IOS4u+mimDogUmU6IFJlOiBSZTogW1BBVENIIHYyXSBpcHY2
OiBmaXggbWVtb3J5IGxlYWsgaW4gX19pcDZfbWFrZV9za2IoKSB3aGVuIHF1ZXVlIGlzIGVtcHR5
Cj4gCj4gT24gRnJpLCAyMDI2LTA0LTI0IGF0IDExOjI2ICswODAwLCDnjovmmI7nhZwgd3JvdGU6
Cj4gPiBIaSBTYWJyaW5hIGFuZCBKYWt1YiwKPiA+IAo+ID4gQmVmb3JlIHNlbmRpbmcgb3V0IHRo
ZSB2MyBwYXRjaCwgSSBzeW5jZWQgbXkgdHJlZSB0byB0aGUgbGF0ZXN0IG1haW5saW5lIGFuZCBj
aGVja2VkIHRoZSBjdXJyZW50IHN0YXRlIG9mIGBpcDZfbWFrZV9za2IoKWAuIAo+ID4gCj4gPiBJ
dCB0dXJucyBvdXQgdGhhdCB0aGUgbWlzc2luZyBgaXA2X2NvcmtfcmVsZWFzZShjb3JrKWAgaW4g
dGhlIGVycm9yIHBhdGggd2FzIGFscmVhZHkgbmF0dXJhbGx5IHJlc29sdmVkIGJ5IEVyaWMgRHVt
YXpldCdzIHJlY2VudCByZWZhY3RvcmluZyBjb21taXQ6Cj4gPiBiNDA5YTdmNzE3NmIgKCJpcHY2
OiBjb2xvY2F0ZSBpbmV0Nl9jb3JrIGluIGluZXRfY29ya19mdWxsIikKPiA+IAo+ID4gV2l0aCBF
cmljJ3MgY2hhbmdlcywgdGhlIGVycm9yIGhhbmRsaW5nIG5vdyBjb3JyZWN0bHkgY2FsbHMgYGlw
Nl9jb3JrX3JlbGVhc2UoY29yaylgIGlmIGBpcDZfc2V0dXBfY29yaygpYCBmYWlscywgbWVhbmlu
ZyB0aGUgbWVtb3J5IGxlYWsgaXMgbm8gbG9uZ2VyIHByZXNlbnQgaW4gdGhlIGxhdGVzdCB0cmVl
Lgo+IAo+IEZpbmUsIHNvIG1haW5saW5lIGlzIGNvcnJlY3Qgbm93LiBXaGF0IGFib3V0IHRoZSBz
dGFibGUgdHJlZXM/IERpZCB5b3UKPiBjaGVjayB0aGVtIGFscmVhZHk/Cj4gCj4gRmxvcmlhbgo+
IAo+ID4gCj4gPiBQbGVhc2UgZGlzcmVnYXJkIG15IHYxIGFuZCB2MiBwYXRjaGVzLiBJIGFtIGFs
c28gdGVsbGluZyBzeXpib3QgdG8gY2xvc2UgdGhpcyByZXBvcnQgYmFzZWQgb24gRXJpYydzIGNv
bW1pdC4KPiA+IAo+ID4gVGhhbmsgeW91IGFsbCBhZ2FpbiBmb3IgeW91ciB0aW1lLCB0aGUgZGVl
cCBjb2RlIHJldmlldywgYW5kIGZvciBndWlkaW5nIG1lIHRvIGZpbmQgdGhlIHRydWUgcm9vdCBj
YXVzZS4gSSBsZWFybmVkIGEgaHVnZSBhbW91bnQgZnJvbSB0aGlzIGRpc2N1c3Npb24hCj4gPiAK
PiA+ICNzeXogZml4OiBpcHY2OiBjb2xvY2F0ZSBpbmV0Nl9jb3JrIGluIGluZXRfY29ya19mdWxs
Cj4gPiAKPiA+IEJlc3QgcmVnYXJkcywKPiA+IE1pbmd5dSBXYW5nCj4gPiAKPiA+IDIwMjYtMDQt
MjQgMTE6MTY6MzAgIueOi+aYjueFnCIgPDI1MTgxMjE0MjE3QHN0dS54aWRpYW4uZWR1LmNuPiDl
hpnpgZPvvJoKPiA+ID4gSGksCj4gPiA+IAo+ID4gPiBUaGFuayB5b3Ugc28gbXVjaCBmb3IgdGhl
IHJldmlldyBhbmQgZm9yIHBvaW50aW5nIG1lIHRvIHRoZSBjb3JyZWN0IEZpeGVzIHRhZyEKPiA+
ID4gCj4gPiA+IFlvdSBoaXQgdGhlIG5haWwgb24gdGhlIGhlYWQgcmVnYXJkaW5nIGBfX2lwNl9h
cHBlbmRfZGF0YSgpYC4gQWZ0ZXIgcmUtZXZhbHVhdGluZyB0aGUgY29kZSBwYXRoIGJhc2VkIG9u
IHlvdXIgcXVlc3Rpb24sIEkgcmVhbGl6ZSBteSBhc3N1bXB0aW9uIGluIHYyIHdhcyBpbmNvcnJl
Y3QuIGBfX2lwNl9hcHBlbmRfZGF0YSgpYCBkb2VzIGluZGVlZCBndWFyYW50ZWUgdGhhdCBhbiBz
a2IgaXMgcXVldWVkIHVwb24gc3VjY2VzcywgbWFraW5nIHRoZSBgc2tiID09IE5VTExgIHBhdGgg
ZGVhZCBjb2RlIGluIHRoaXMgY29udGV4dC4KPiA+ID4gCj4gPiA+IEkgdHJhY2VkIHRoZSBgZmFp
bHNsYWJgIG1lbW9yeSBsZWFrIGJhY2sgdG8gaXRzIHRydWUgb3JpZ2luOiB0aGUgbG9ja2xlc3Mg
ZmFzdCBwYXRoIHdyYXBwZXIgYGlwNl9tYWtlX3NrYigpYC4KPiA+ID4gCj4gPiA+IFNhYnJpbmEg
cHJldmlvdXNseSBub3RlZCB0aGF0IGBpcDZfc2V0dXBfY29yaygpYCBmYWlsdXJlcyBjb3JyZWN0
bHkgcmVsZWFzZSB0aGUgZHN0LiBUaGF0IGlzIGFic29sdXRlbHkgdHJ1ZSBmb3IgdGhlIHNsb3cg
cGF0aCwgd2hlcmUgYHVkcF92Nl9mbHVzaF9wZW5kaW5nX2ZyYW1lcygpYCBldmVudHVhbGx5IGhh
bmRsZXMgdGhlIGNsZWFudXAuIAo+ID4gPiAKPiA+ID4gSG93ZXZlciwgaW4gdGhlIGZhc3QgcGF0
aCwgYGlwNl9tYWtlX3NrYigpYCBjYWxscyBgaXA2X3NldHVwX2NvcmsoKWAuIEluc2lkZSBgaXA2
X3NldHVwX2NvcmsoKWAsIGBjb3JrLT5iYXNlLmRzdGAgaXMgYXNzaWduZWQgZWFybHkuIElmIGEg
c3Vic2VxdWVudCBtZW1vcnkgYWxsb2NhdGlvbiBmYWlscyAoZS5nLiwgYHY2X2NvcmstPm9wdCA9
IGt6YWxsb2MoLi4uKWAgZmFpbGluZyBkdWUgdG8gZmFpbHNsYWIpLCBpdCByZXR1cm5zIGFuIGVy
cm9yLiBgaXA2X21ha2Vfc2tiKClgIHRoZW4gZGlyZWN0bHkgcmV0dXJucyBgRVJSX1BUUihlcnIp
YCBXSVRIT1VUIGNhbGxpbmcgYGlwNl9jb3JrX3JlbGVhc2UoY29yaylgLgo+ID4gPiAKPiA+ID4g
U2luY2UgYHVkcHY2X3NlbmRtc2coKWAgYXNzdW1lcyB0aGUgYGRzdGAgcmVmZXJlbmNlIGlzIHN0
b2xlbiBieSBgaXA2X21ha2Vfc2tiKClgIGFuZCB1bmNvbmRpdGlvbmFsbHkganVtcHMgdG8gYG91
dF9ub19kc3RgLCB0aGUgYGRzdGAgaXMgY29tcGxldGVseSBsZWFrZWQuCj4gPiA+IAo+ID4gPiBU
aGUgZml4IGlzIHNpbXBseSB0byBhZGQgYGlwNl9jb3JrX3JlbGVhc2UoY29yaylgIGluIHRoZSBg
aXA2X3NldHVwX2NvcmsoKWAgZXJyb3IgcGF0aCBpbnNpZGUgYGlwNl9tYWtlX3NrYigpYC4KPiA+
ID4gCj4gPiA+IEkgd2lsbCBzdWJtaXQgYSB2MyBwYXRjaCBzaG9ydGx5IGFkZHJlc3NpbmcgdGhp
cyB0cnVlIHJvb3QgY2F1c2UgYW5kIHVzaW5nIHlvdXIgc3VnZ2VzdGVkIEZpeGVzIHRhZy4gVGhh
bmsgeW91IGFnYWluIGZvciBzdGVlcmluZyBtZSBpbiB0aGUgZXhhY3QgcmlnaHQgZGlyZWN0aW9u
IQo+ID4gPiAKPiA+ID4gQmVzdCByZWdhcmRzLAo+ID4gPiBNaW5neXUgV2FuZwo+ID4gPiAKPiA+
ID4gCj4gPiA+ID4gLS0tLS3ljp/lp4vpgq7ku7YtLS0tLQo+ID4gPiA+IOWPkeS7tuS6ujogIldp
bGxlbSBkZSBCcnVpam4iIDx3aWxsZW1kZWJydWlqbi5rZXJuZWxAZ21haWwuY29tPgo+ID4gPiA+
IOWPkemAgeaXtumXtDoyMDI2LTA0LTIzIDIyOjU5OjQ1ICjmmJ/mnJ/lm5spCj4gPiA+ID4g5pS2
5Lu25Lq6OiAiTWluZ3l1IFdhbmciIDwyNTE4MTIxNDIxN0BzdHUueGlkaWFuLmVkdS5jbj4sIHdp
bGxlbWRlYnJ1aWpuLmtlcm5lbEBnbWFpbC5jb20sIGRhdmVtQGRhdmVtbG9mdC5uZXQsIGRzYWhl
cm5Aa2VybmVsLm9yZywgZWR1bWF6ZXRAZ29vZ2xlLmNvbSwga3ViYUBrZXJuZWwub3JnLCBwYWJl
bmlAcmVkaGF0LmNvbQo+ID4gPiA+IOaKhOmAgTogc2RAcXVlYXN5c25haWwubmV0LCBob3Jtc0Br
ZXJuZWwub3JnLCBuZXRkZXZAdmdlci5rZXJuZWwub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnLCAiTWluZ3l1IFdhbmciIDwyNTE4MTIxNDIxN0BzdHUueGlkaWFuLmVkdS5jbj4sIHN5
emJvdCtlNWQ2OTM2YjlmNDU0NWZkODhhYkBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCj4gPiA+
ID4g5Li76aKYOiBSZTogW1BBVENIIHYyXSBpcHY2OiBmaXggbWVtb3J5IGxlYWsgaW4gX19pcDZf
bWFrZV9za2IoKSB3aGVuIHF1ZXVlIGlzIGVtcHR5Cj4gPiA+ID4gCj4gPiA+ID4gTWluZ3l1IFdh
bmcgd3JvdGU6Cj4gPiA+ID4gPiBEdXJpbmcgZnV6emluZyB3aXRoIGZhaWxzbGFiIGVuYWJsZWQs
IGEgbWVtb3J5IGxlYWsgd2FzIG9ic2VydmVkIGluIHRoZQo+ID4gPiA+ID4gSVB2NiBVRFAgc2Vu
ZCBwYXRoLgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBUaGUgcm9vdCBjYXVzZSByZXNpZGVzIGluIF9f
aXA2X21ha2Vfc2tiKCkuIEluIGV4dHJlbWVseSByYXJlIGNhc2VzCj4gPiA+ID4gPiAoc3VjaCBh
cyBmYXVsdCBpbmplY3Rpb24gb3Igc3BlY2lmaWMgZW1wdHkgcGF5bG9hZCBjb25kaXRpb25zKSwK
PiA+ID4gPiAKPiA+ID4gPiBDYW4geW91IGVsYWJvcmF0ZSBvbiB0aGlzPyBXaGljaCBmYXVsdCBp
bmplY3Rpb24gbGV0cwo+ID4gPiA+IF9faXA2X2FwcGVuZF9kYXRhIHN1Y2NlZWQgd2l0aG91dCB3
cml0aW5nIGRhdGE/Cj4gPiA+ID4gCj4gPiA+ID4gPiBfX2lwNl9hcHBlbmRfZGF0YSgpIG1heSBz
dWNjZWVkIGJ1dCBsZWF2ZSB0aGUgc29ja2V0J3Mgd3JpdGUgcXVldWUKPiA+ID4gPiA+IGVtcHR5
Lgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBXaGVuIF9faXA2X21ha2Vfc2tiKCkgaXMgc3Vic2VxdWVu
dGx5IGNhbGxlZCwgX19za2JfZGVxdWV1ZShxdWV1ZSkKPiA+ID4gPiA+IHJldHVybnMgTlVMTC4g
VGhlIHByZXZpb3VzIGxvZ2ljIGhhbmRsZWQgdGhpcyBieSBleGVjdXRpbmcgYSAnZ290byBvdXQ7
JywKPiA+ID4gPiA+IHdoaWNoIGNvbXBsZXRlbHkgYnlwYXNzZWQgdGhlIGNhbGwgdG8gaXA2X2Nv
cmtfcmVsZWFzZShjb3JrKS4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gU2luY2UgdGhlICdjb3JrJyBz
dHJ1Y3R1cmUgYWN0aXZlbHkgaG9sZHMgYSByZWZlcmVuY2UgdG8gdGhlIHJvdXRpbmcKPiA+ID4g
PiA+IGVudHJ5IChkc3RfZW50cnkpIGFuZCBwb3RlbnRpYWxseSBvdGhlciBhbGxvY2F0ZWQgb3B0
aW9ucywgc2tpcHBpbmcKPiA+ID4gPiA+IHRoZSByZWxlYXNlIGNsZWFubHkgbGVha3MgdGhlc2Ug
cmVzb3VyY2VzLgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBGaXggdGhpcyBieSBpbnRyb2R1Y2luZyBh
biAnb3V0X2NvcmtfcmVsZWFzZScgbGFiZWwgYW5kIGp1bXBpbmcgdG8gaXQKPiA+ID4gPiA+IHdo
ZW4gc2tiIGlzIE5VTEwsIGVuc3VyaW5nIHRoZSBjb3JrIHN0YXRlIGlzIGFsd2F5cyBwcm9wZXJs
eSBjbGVhbmVkIHVwLgo+ID4gPiA+ID4gVGhlIG5vdy11bnVzZWQgJ291dCcgbGFiZWwgaXMgYWxz
byByZW1vdmVkIHRvIHByZXZlbnQgY29tcGlsZXIgd2FybmluZ3MuCj4gPiA+ID4gPiAKPiA+ID4g
PiA+IEZpeGVzOiAxZGExNzdlNGMzZjQgKCJMaW51eC0yLjYuMTItcmMyIikKPiA+ID4gPiAKPiA+
ID4gPiBJIHRoaW5rIHRoaXMgaXMgCj4gPiA+ID4gCj4gPiA+ID4gRml4ZXM6IDY0MjIzOThjMmFi
MCAoImlwdjY6IGludHJvZHVjZSBpcHY2X21ha2Vfc2tiIikKPiA+ID4gPiAKPiA+ID4gPiA+IFJl
cG9ydGVkLWJ5OiBzeXpib3QrZTVkNjkzNmI5ZjQ1NDVmZDg4YWJAc3l6a2FsbGVyLmFwcHNwb3Rt
YWlsLmNvbQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTWluZ3l1IFdhbmcgPDI1MTgxMjE0MjE3
QHN0dS54aWRpYW4uZWR1LmNuPgo=

