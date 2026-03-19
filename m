Return-Path: <netdev+bounces-269390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAmrAOvJu2leoQIAu9opvQ
	(envelope-from <netdev+bounces-269390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:03:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1CF2C9355
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 298D832851CC
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247DD347FF4;
	Thu, 19 Mar 2026 09:56:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599CE341055;
	Thu, 19 Mar 2026 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914184; cv=none; b=KjInnE+mA8Tapm8WzLl8MMvkIf58AMrvmX1q1teO9eZqnOTQNIX0FZrwix/C4c/vHDYvUElwvcRakrcy1cfeVhMqL3Zl8KOkzrwyMfLXtGfuv5PKCwWG1csNZWozzfBxsmllNF8KCIpFE8tmn729njwn+Eo8LdzVF7aihqOICgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914184; c=relaxed/simple;
	bh=2hMouKBOO7iljDh84gym0ir5SjUx+qmM6vACrsQWh1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=iYP1obWfXnuFpXPiIMh4ShA7KutLlxnM4U53M0sIbZl6WXfb5bBbd5D1Fkfc2n2u84txCRoXen1h6BxhmJWPC7gIIkWrc4OjLHDt+BQ5QlW8mzELCKpQjf4ku1rO167X6dZJ/KSnoj7WRtGpu/GWwIkigEIm6wA+nlEoVC6ACDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Thu, 19 Mar 2026 17:55:31 +0800 (GMT+08:00)
Date: Thu, 19 Mar 2026 17:55:31 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: krzk+dt@kernel.org, "Conor Dooley" <conor@kernel.org>
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, wens@kernel.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com
Subject: Re: Re: [PATCH net-next v4 1/3] dt-bindings: ethernet: eswin: add
 clock sampling control
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260313-stiffness-item-c451eaef970d@spud>
References: <20260313075234.1567-1-lizhi2@eswincomputing.com>
 <20260313075351.1584-1-lizhi2@eswincomputing.com>
 <20260313-stiffness-item-c451eaef970d@spud>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4d45d39b.591c.19d05858b58.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TAJkCgDHaXMTyLtpTOUJAA--.3066W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAgELDGm61AkcbQAAs7
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW3Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269390-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	HAS_X_PRIO_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,eswincomputing.com,einfochips.com];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	NEURAL_SPAM(0.00)[0.572];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D1CF2C9355
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgS3J6eXN6dG9mLAoKQ291bGQgeW91IHBsZWFzZSB0YWtlIGEgbG9vayBhdCBDb25vcuKAmXMg
ZmVlZGJhY2sgb24gdGhlIGNvbXBhdGlibGUgbmFtaW5nPwoKQ29ub3IgaGFzIHJldmlld2VkIHRo
ZSBwYXRjaCBhbmQgcHJvdmlkZWQgaGlzIEFja2VkLWJ5LCBidXQgYWxzbyBub3RlZAp0aGF0IHRo
ZXJlIG1pZ2h0IGJlIGNvbmNlcm5zIHJlZ2FyZGluZyB0aGUgY29tcGF0aWJsZSBzdHJpbmcuCgpQ
bGVhc2UgbGV0IG1lIGtub3cgaWYgdGhlIGN1cnJlbnQgbmFtaW5nIGlzIGFjY2VwdGFibGUsIG9y
IGlmIGFueSBjaGFuZ2VzCmFyZSByZXF1aXJlZC4KClRoYW5rcywKWmhpIExpCgoKPiAtLS0tLeWO
n+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiQ29ub3IgRG9vbGV5IiA8Y29ub3JAa2VybmVs
Lm9yZz4KPiDlj5HpgIHml7bpl7Q6MjAyNi0wMy0xNCAwMTozOTo1OCAo5pif5pyf5YWtKQo+IOaU
tuS7tuS6ujogbGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbQo+IOaKhOmAgTogZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmcsIGFuZHJldytuZXRkZXZAbHVubi5jaCwgZGF2ZW1AZGF2ZW1sb2Z0Lm5l
dCwgZWR1bWF6ZXRAZ29vZ2xlLmNvbSwga3ViYUBrZXJuZWwub3JnLCByb2JoQGtlcm5lbC5vcmcs
IGtyemsrZHRAa2VybmVsLm9yZywgY29ub3IrZHRAa2VybmVsLm9yZywgbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZywgcGFiZW5pQHJlZGhhdC5jb20sIG1jb3F1ZWxpbi5zdG0zMkBnbWFpbC5jb20sIGFs
ZXhhbmRyZS50b3JndWVAZm9zcy5zdC5jb20sIHJtaytrZXJuZWxAYXJtbGludXgub3JnLnVrLCB3
ZW5zQGtlcm5lbC5vcmcsIHBqd0BrZXJuZWwub3JnLCBwYWxtZXJAZGFiYmVsdC5jb20sIGFvdUBl
ZWNzLmJlcmtlbGV5LmVkdSwgYWxleEBnaGl0aS5mciwgbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFk
ZWFkLm9yZywgbGludXgtc3RtMzJAc3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbSwgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnLCBuaW5neXVAZXN3aW5jb21wdXRpbmcuY29tLCBsaW5taW5AZXN3aW5jb21wdXRpbmcuY29t
LCBwaW5rZXNoLnZhZ2hlbGFAZWluZm9jaGlwcy5jb20sIHByaXRlc2gucGF0ZWxAZWluZm9jaGlw
cy5jb20sIHdlaXNoYW5nanVhbkBlc3dpbmNvbXB1dGluZy5jb20KPiDkuLvpopg6IFJlOiBbUEFU
Q0ggbmV0LW5leHQgdjQgMS8zXSBkdC1iaW5kaW5nczogZXRoZXJuZXQ6IGVzd2luOiBhZGQgY2xv
Y2sgc2FtcGxpbmcgY29udHJvbAo+IAo+IE9uIEZyaSwgTWFyIDEzLCAyMDI2IGF0IDAzOjUzOjUx
UE0gKzA4MDAsIGxpemhpMkBlc3dpbmNvbXB1dGluZy5jb20gd3JvdGU6Cj4gPiBGcm9tOiBaaGkg
TGkgPGxpemhpMkBlc3dpbmNvbXB1dGluZy5jb20+Cj4gPiAKPiA+IER1ZSB0byBjaGlwIGJhY2tl
bmQgcmVhc29ucywgdGhlcmUgaXMgYWxyZWFkeSBhbiBhcHByb3hpbWF0ZWx5IDQtNSBucwo+ID4g
c2tldyBiZXR3ZWVuIHRoZSBSWCBjbG9jayBhbmQgZGF0YSBvZiB0aGUgZXRoMSBNQUMgY29udHJv
bGxlciBpbnNpZGUKPiA+IHRoZSBzaWxpY29uLgo+ID4gCj4gPiBGb3IgMTAwME0sIHRoZSBSWCBj
bG9jayBtdXN0IGJlIGludmVydGVkIHNpbmNlIGl0IGlzIG5vdCBwb3NzaWJsZSB0bwo+ID4gbWVl
dCB0aGUgUkdNSUkgdGltaW5nIHJlcXVpcmVtZW50cyB1c2luZyBvbmx5IHJ4LWludGVybmFsLWRl
bGF5LXBzIG9uCj4gPiB0aGUgTUFDIHRvZ2V0aGVyIHdpdGggdGhlIHN0YW5kYXJkIDIgbnMgZGVs
YXkgb24gdGhlIFBIWS4gVGhlcmVmb3JlLAo+ID4gZXZlbiBvbiBhIHByb3Blcmx5IGRlc2lnbmVk
IGJvYXJkLCBldGgxIHN0aWxsIHJlcXVpcmVzIFJYIGNsb2NrCj4gPiBpbnZlcnNpb24uCj4gPiAK
PiA+IFRoaXMgYmVoYXZpb3VyIGVmZmVjdGl2ZWx5IGJyZWFrcyB0aGUgUkdNSUkgdGltaW5nIGFz
c3VtcHRpb25zIGF0IHRoZQo+ID4gU29DIGxldmVsLgo+ID4gCj4gPiBGb3IgdGhlIFRYIHBhdGgg
b2YgZXRoMSwgdGhlcmUgaXMgYWxzbyBhIHNrZXcgYmV0d2VlbiB0aGUgVFggY2xvY2sKPiA+IGFu
ZCBkYXRhIG9uIHRoZSBNQUMgY29udHJvbGxlciBpbnNpZGUgdGhlIHNpbGljb24uIFRoaXMgc2tl
dyBoYXBwZW5zCj4gPiB0byBiZSBhcHByb3hpbWF0ZWx5IDIgbnMuIFRoZXJlZm9yZSwgaXQgY2Fu
IGJlIGNvbnNpZGVyZWQgdGhhdCB0aGUKPiA+IDIgbnMgZGVsYXkgb2YgVFggaXMgcHJvdmlkZWQg
YnkgdGhlIE1BQywgc28gdGhlIFRYIGlzIGNvbXBsaWFudCB3aXRoCj4gPiB0aGUgUkdNSUkgc3Rh
bmRhcmQuCj4gPiAKPiA+IEZvciAxMC8xMDAgb3BlcmF0aW9uLCB0aGUgYXBwcm94aW1hdGVseSA0
LTUgbnMgc2tldyBpbiB0aGUgY2hpcCBkb2VzCj4gPiBub3QgYnJlYWsgdGhlIHN0YW5kYXJkLiBU
aGUgUkdNSUkgdGltaW5nIHRhYmxlIChTZWN0aW9uIDMuMykgc3BlY2lmaWVzCj4gPiB0aGF0IGZv
ciAxMC8xMDAgb3BlcmF0aW9uIHRoZSBtYXhpbXVtIHZhbHVlIGlzIHVuc3BlY2lmaWVkOgo+ID4g
aHR0cHM6Ly9jb21tdW5pdHkubnhwLmNvbS9wd214eTg3NjU0L2F0dGFjaG1lbnRzL3B3bXh5ODc2
NTQvaW14LXByb2Nlc3NvcnMvMjA2NTUvMS9SR01JSXYyXzBfZmluYWxfaHAucGRmCj4gPiAKPiA+
IER1ZSB0byB0aGUgZXRoMSBzaWxpY29uIGJlaGF2aW9yIGRlc2NyaWJlZCBhYm92ZSwgYSBuZXcg
Y29tcGF0aWJsZQo+ID4gc3RyaW5nICJlc3dpbixlaWM3NzAwLXFvcy1ldGgtY2xrLWludmVyc2lv
biIgaXMgYWRkZWQgdG8gdGhlIGRldmljZQo+ID4gdHJlZS4gVGhpcyBhbGxvd3MgdGhlIGRyaXZl
ciB0byBoYW5kbGUgdGhlIGRpZmZlcmVuY2VzIGJldHdlZW4gZXRoMQo+ID4gYW5kIGV0aDAgdGhy
b3VnaCBkZWRpY2F0ZWQgbG9naWMuCj4gPiAKPiA+IFRoZSByeC1pbnRlcm5hbC1kZWxheS1wcyBh
bmQgdHgtaW50ZXJuYWwtZGVsYXktcHMgcHJvcGVydGllcyBub3cgdXNlCj4gPiBtaW5pbXVtIGFu
ZCBtYXhpbXVtIGNvbnN0cmFpbnRzIHRvIHJlZmxlY3QgdGhlIGFjdHVhbCBoYXJkd2FyZSBkZWxh
eQo+ID4gcmFuZ2UgKDAtMjU0MCBwcykgYXBwbGllZCBpbiAyMCBwcyBzdGVwcy4gVGhpcyByZWxh
eGVzIHRoZSBiaW5kaW5nCj4gPiB2YWxpZGF0aW9uIGNvbXBhcmVkIHRvIHRoZSBwcmV2aW91cyBl
bnVtLWJhc2VkIGRlZmluaXRpb24gYW5kIGF2b2lkcwo+ID4gcmVncmVzc2lvbnMgZm9yIGV4aXN0
aW5nIERUQnMgd2hpbGUga2VlcGluZyB0aGUgc2FtZSBoYXJkd2FyZSBsaW1pdHMuCj4gPiAKPiA+
IFRyZWF0IHRoZSBSWC9UWCBpbnRlcm5hbCBkZWxheSBwcm9wZXJ0aWVzIGFzIG9wdGlvbmFsLCBi
b2FyZC1zcGVjaWZpYwo+ID4gdHVuaW5nIGtub2JzIGFuZCByZW1vdmUgdGhlbSBmcm9tIHRoZSBl
eGFtcGxlIHRvIGF2b2lkIGVuY291cmFnaW5nCj4gPiB0aGVpciB1c2UuCj4gPiAKPiA+IEluIGFk
ZGl0aW9uLCB0aGUgYmluZGluZyBub3cgaW5jbHVkZXMgYWRkaXRpb25hbCBiYWNrZ3JvdW5kIGlu
Zm9ybWF0aW9uCj4gPiBhYm91dCB0aGUgSFNQIENTUiByZWdpc3RlcnMgYWNjZXNzZWQgYnkgdGhl
IE1BQy4gVGhlIFRYRCBhbmQgUlhEIGRlbGF5Cj4gPiBjb250cm9sIHJlZ2lzdGVycyBhcmUgaW5j
bHVkZWQgc28gdGhlIGRyaXZlciBjYW4gZXhwbGljaXRseSBjbGVhciBhbnkKPiA+IHJlc2lkdWFs
IGNvbmZpZ3VyYXRpb24gbGVmdCBieSB0aGUgYm9vdGxvYWRlci4KPiA+IAo+ID4gQmFja2dyb3Vu
ZCByZWZlcmVuY2UgZm9yIHRoZSBIaWdoLVNwZWVkIFN1YnN5c3RlbSBhbmQgSFNQIENTUiBibG9j
ayBpcwo+ID4gYXZhaWxhYmxlIGluIENoYXB0ZXIgMTAgKCJIaWdoLVNwZWVkIEludGVyZmFjZSIp
IG9mIHRoZSBFSUM3NzAwWCBTb0MKPiA+IFRlY2huaWNhbCBSZWZlcmVuY2UgTWFudWFsLCBQYXJ0
IDQKPiA+IChFSUM3NzAwWF9Tb0NfVGVjaG5pY2FsX1JlZmVyZW5jZV9NYW51YWxfUGFydDQucGRm
KToKPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9lc3dpbmNvbXB1dGluZy9FSUM3NzAwWC1Tb0MtVGVj
aG5pY2FsLVJlZmVyZW5jZS1NYW51YWwvcmVsZWFzZXMKPiA+IAo+ID4gVGhlcmUgYXJlIGN1cnJl
bnRseSBubyBpbi10cmVlIHVzZXJzIG9mIHRoZSBFSUM3NzAwIEV0aGVybmV0IGRyaXZlciwgc28K
PiA+IHRoZXNlIGNoYW5nZXMgYXJlIHNhZmUuCj4gPiAKPiA+IEZpeGVzOiA4ODhiZDBlY2E5M2Mg
KCJkdC1iaW5kaW5nczogZXRoZXJuZXQ6IGVzd2luOiBEb2N1bWVudCBmb3IgRUlDNzcwMCBTb0Mi
KQo+ID4gU2lnbmVkLW9mZi1ieTogWmhpIExpIDxsaXpoaTJAZXN3aW5jb21wdXRpbmcuY29tPgo+
IAo+IEtyenlzenRvZiBtaWdodCBub3QgeWV0IGJlIGhhcHB5IHdpdGggdGhlIGNvbXBhdGlibGUg
bmFtaW5nLCBidXQgZnJvbSBteQo+IHBvdjoKPiBBY2tlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25v
ci5kb29sZXlAbWljcm9jaGlwLmNvbT4K

