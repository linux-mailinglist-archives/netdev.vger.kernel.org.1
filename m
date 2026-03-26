Return-Path: <netdev+bounces-271815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAZDOoOlxGmZ1wQAu9opvQ
	(envelope-from <netdev+bounces-271815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:18:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5279632EB1F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A1073038AD5
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DE23914E2;
	Thu, 26 Mar 2026 03:15:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBCA1F2380;
	Thu, 26 Mar 2026 03:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774494941; cv=none; b=Z25Milpx0JlOzN8zpxgkv+QjMJF4CBfC04x47byiQh/z5xhPsEUJjOqFXv7Zr4ZP6j/h0xWPEDUfZzawIN4nKoiF6oQQDDfoGapXaxXbRqTKPwqsht1r/A6rEwQtDP/MhfOMOI9uI9/qhnlVK+9i+svD1B+mb176RDOjOxxtMLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774494941; c=relaxed/simple;
	bh=OoD/586wfscgcCERlMV9YK0cmcINDrZLfN+kCmWW3FE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=LL0sR/vkMgafFEAXXWckuNhAew61q95pgEhmGYeJUNFj6ouG9wL03FFNhUCk1Q04QFIOXdnOrSMYmHYOUqVSmpiI7KcD6O4BTi39eNah5SORwyCyGvZtORzl3zv3MXdgFvzw43MG6+7Ow7hdRNhRiAT4gtTi1fHvF3FKqOVo9WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Thu, 26 Mar 2026 11:14:45 +0800 (GMT+08:00)
Date: Thu, 26 Mar 2026 11:14:45 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Simon Horman" <horms@kernel.org>
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: Re: [PATCH net-next v5 3/3] riscv: dts: eswin:
 eic7700-hifive-premier-p550: enable Ethernet controller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260325180330.GL111839@horms.kernel.org>
References: <20260324073017.376-1-lizhi2@eswincomputing.com>
 <20260324073408.439-1-lizhi2@eswincomputing.com>
 <20260325180330.GL111839@horms.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2a12c839.5e64.19d28232537.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TAJkCgDHaXOlpMRpqdYLAA--.3593W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAgERDGnEDooA3QADsp
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
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
	TAGGED_FROM(0.00)[bounces-271815-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_X_PRIO_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,bootlin.com,eswincomputing.com,einfochips.com];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5279632EB1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiU2ltb24gSG9ybWFuIiA8
aG9ybXNAa2VybmVsLm9yZz4KPiDlj5HpgIHml7bpl7Q6MjAyNi0wMy0yNiAwMjowMzozMCAo5pif
5pyf5ZubKQo+IOaUtuS7tuS6ujogbGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbQo+IOaKhOmAgTog
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcsIGFuZHJldytuZXRkZXZAbHVubi5jaCwgZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldCwgZWR1bWF6ZXRAZ29vZ2xlLmNvbSwga3ViYUBrZXJuZWwub3JnLCByb2Jo
QGtlcm5lbC5vcmcsIGtyemsrZHRAa2VybmVsLm9yZywgY29ub3IrZHRAa2VybmVsLm9yZywgbmV0
ZGV2QHZnZXIua2VybmVsLm9yZywgcGFiZW5pQHJlZGhhdC5jb20sIG1jb3F1ZWxpbi5zdG0zMkBn
bWFpbC5jb20sIGFsZXhhbmRyZS50b3JndWVAZm9zcy5zdC5jb20sIHJtaytrZXJuZWxAYXJtbGlu
dXgub3JnLnVrLCBwandAa2VybmVsLm9yZywgcGFsbWVyQGRhYmJlbHQuY29tLCBhb3VAZWVjcy5i
ZXJrZWxleS5lZHUsIGFsZXhAZ2hpdGkuZnIsIGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5v
cmcsIGxpbnV4LXN0bTMyQHN0LW1kLW1haWxtYW4uc3Rvcm1yZXBseS5jb20sIGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywg
bWF4aW1lLmNoZXZhbGxpZXJAYm9vdGxpbi5jb20sIG5pbmd5dUBlc3dpbmNvbXB1dGluZy5jb20s
IGxpbm1pbkBlc3dpbmNvbXB1dGluZy5jb20sIHBpbmtlc2gudmFnaGVsYUBlaW5mb2NoaXBzLmNv
bSwgcHJpdGVzaC5wYXRlbEBlaW5mb2NoaXBzLmNvbSwgd2Vpc2hhbmdqdWFuQGVzd2luY29tcHV0
aW5nLmNvbQo+IOS4u+mimDogUmU6IFtQQVRDSCBuZXQtbmV4dCB2NSAzLzNdIHJpc2N2OiBkdHM6
IGVzd2luOiBlaWM3NzAwLWhpZml2ZS1wcmVtaWVyLXA1NTA6IGVuYWJsZSBFdGhlcm5ldCBjb250
cm9sbGVyCj4gCj4gT24gVHVlLCBNYXIgMjQsIDIwMjYgYXQgMDM6MzQ6MDhQTSArMDgwMCwgbGl6
aGkyQGVzd2luY29tcHV0aW5nLmNvbSB3cm90ZToKPiA+IEZyb206IFpoaSBMaSA8bGl6aGkyQGVz
d2luY29tcHV0aW5nLmNvbT4KPiA+IAo+ID4gRW5hYmxlIHRoZSBvbi1ib2FyZCBHaWdhYml0IEV0
aGVybmV0IGNvbnRyb2xsZXIgb24gdGhlCj4gPiBIaUZpdmUgUHJlbWllciBQNTUwIGRldmVsb3Bt
ZW50IGJvYXJkLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGkgTGkgPGxpemhpMkBlc3dpbmNv
bXB1dGluZy5jb20+Cj4gPiAtLS0KPiA+ICAuLi4vZHRzL2Vzd2luL2VpYzc3MDAtaGlmaXZlLXBy
ZW1pZXItcDU1MC5kdHMgfCA0MiArKysrKysrKysrKysKPiA+ICBhcmNoL3Jpc2N2L2Jvb3QvZHRz
L2Vzd2luL2VpYzc3MDAuZHRzaSAgICAgICAgfCA2NiArKysrKysrKysrKysrKysrKysrCj4gPiAg
MiBmaWxlcyBjaGFuZ2VkLCAxMDggaW5zZXJ0aW9ucygrKQo+IAo+IFVuZm9ydHVuYXRlbHkgdGhp
cyBkb2VzIG5vdCBjb21waWxlOgo+IAo+ICQgQVJDSD1yaXNjdiBtYWtlIGFsbG1vZGNvbmZpZyBk
dGJzCj4gLi4uCj4gICBEVEMgICAgIGFyY2gvcmlzY3YvYm9vdC9kdHMvZXN3aW4vZWljNzcwMC1o
aWZpdmUtcHJlbWllci1wNTUwLmR0Ygo+IGFyY2gvcmlzY3YvYm9vdC9kdHMvZXN3aW4vZWljNzcw
MC5kdHNpOjMwMC4yOC0zMzAuNTogRVJST1IgKHBoYW5kbGVfcmVmZXJlbmNlcyk6IC9zb2MvZXRo
ZXJuZXRANTA0MDAwMDA6IFJlZmVyZW5jZSB0byBub24tZXhpc3RlbnQgbm9kZSBvciBsYWJlbCAi
Y2xrIgo+IC4uLgo+IAo+IC0tIAo+IHB3LWJvdDogY2hhbmdlcy1yZXF1ZXN0ZWQKCkhpIFNpbW9u
LAoKVGhhbmtzIGZvciB5b3VyIHJldmlldy4KCllvdSdyZSByaWdodCwgdGhpcyBidWlsZCBmYWls
dXJlIGlzIGR1ZSB0byBhbiBpbnZhbGlkIGNsb2NrIHJlZmVyZW5jZQooImNsayIpIGluIHRoZSBF
dGhlcm5ldCBub2RlLCB3aGljaCBkb2VzIG5vdCBjb3JyZXNwb25kIHRvIGFuIGV4aXN0aW5nCmNs
b2NrIHByb3ZpZGVyIGxhYmVsIGluIHRoZSBjdXJyZW50IERUUy4KCkZvciBjb250ZXh0LCB0aGlz
IHdhcyBkaXNjdXNzZWQgZHVyaW5nIGFuIGVhcmxpZXIgcmV2aXNpb246Cmh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xrbWwvNWRlYThjZTAuNDQzNS4xOWM0NzEyMzFmNS5Db3JlbWFpbC5saXpoaTJA
ZXN3aW5jb21wdXRpbmcuY29tLwoKVGhlIEVJQzc3MDAgY2xvY2sgY29udHJvbGxlciBzdXBwb3J0
IGhhcyBzaW5jZSBiZWVuIGFwcGxpZWQsIHNvIEkgd2lsbAp1cGRhdGUgdGhlIERUUyB0byByZWZl
cmVuY2UgdGhlIGNvcnJlY3QgY2xvY2sgcHJvdmlkZXIgYW5kIGVuc3VyZSB0aGUKYnVpbGQgcGFz
c2VzIGNsZWFubHkuCgpJIHdpbGwgZml4IHRoaXMgaW4gdGhlIG5leHQgcmV2aXNpb24gKHY2KS4K
ClRoYW5rcywKWmhpIExpCg==

