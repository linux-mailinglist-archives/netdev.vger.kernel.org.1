Return-Path: <netdev+bounces-253722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KC16HPdjeGnTpgEAu9opvQ
	(envelope-from <netdev+bounces-253722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:06:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D5790968
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 797A03006018
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EFE316182;
	Tue, 27 Jan 2026 07:06:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6327925CC6C;
	Tue, 27 Jan 2026 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769497587; cv=none; b=XrNsjaApde4ED6VMLxS6DeX4odk9ys2mWJpGg5zt+dDQqeiGkR9XxFaRAXOKBzyokM3q9aVfespmRwREMPqfqNy8EwdRhFk4KOc9LPP4SiPoHz5PRFHhE6Gc5Sn5I862MptmorNhhb3cJEh3R79F+0vg0Ml/bUF8fRLe4WOtL3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769497587; c=relaxed/simple;
	bh=8FuA/oa5qikBVbmktFQblCerGh/L3C1BRLg+j+XNqYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=C5GJuOXVwpNyREgi8VydlCvgGkgEP01uc4bxSE2Awjr4/uZEzhfoK6jEfsqP/BQ65dBJ57joVfaDiw3yZURjMu1JXdSMJxZg8AL9nYTIdy4L2yPw7gASfUlGMY96GsnQ6u6X5OKdtTmxIdenfDjIwMTXfyDQ0j5YtEXeJvV9YLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from linmin$eswincomputing.com ( [10.10.96.205] ) by
 ajax-webmail-app2 (Coremail) ; Tue, 27 Jan 2026 15:05:48 +0800 (GMT+08:00)
Date: Tue, 27 Jan 2026 15:05:48 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Min Lin" <linmin@eswincomputing.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>,
	"Bo Gan" <ganboing@gmail.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	weishangjuan@eswincomputing.com
Subject: Re: Re: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock
 sampling control
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <d010a6b8-5bf0-40ff-8e76-18362a238d50@lunn.ch>
References: <20260109080601.1262-1-lizhi2@eswincomputing.com>
 <20260109080859.1285-1-lizhi2@eswincomputing.com>
 <00b7b42f-2f9d-402a-82f0-21641ea894a1@lunn.ch>
 <aWKZvEW7rKFFwZLG@shell.armlinux.org.uk>
 <0d54ddca-9270-40a5-aa82-d8a7b65027ff@gmail.com>
 <1a622916.2d28.19bb105feab.Coremail.lizhi2@eswincomputing.com>
 <d010a6b8-5bf0-40ff-8e76-18362a238d50@lunn.ch>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <203bb660.2c91.19bfe45d677.Coremail.linmin@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TQJkCgAXiy3MY3hpcrAGAA--.1516W
X-CM-SenderInfo: 5olqzx3q6h245lqf0zpsxwx03jof0z/1tbiAgEACWl3l4EXtwABsj
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253722-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_X_PRIO_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linmin@eswincomputing.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[eswincomputing.com,gmail.com,armlinux.org.uk,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,einfochips.com];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,davemloft.net:email,st.com:email,einfochips.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: D7D5790968
X-Rspamd-Action: no action

SGkgQW5kcmV3LAoKVGhhbmsgeW91IGZvciB0YWtpbmcgdGhlIHRpbWUgdG8gcmV2aWV3IHRoZSBw
YXRjaC4KCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlcy0tLS0tCj4gRnJvbTogIkFuZHJldyBMdW5u
IiA8YW5kcmV3QGx1bm4uY2g+Cj4gU2VuZCB0aW1lOlRodXJzZGF5LCAyMi8wMS8yMDI2IDIxOjI3
OjM0Cj4gVG86IOadjuW/lyA8bGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbT4KPiBDYzogIkJvIEdh
biIgPGdhbmJvaW5nQGdtYWlsLmNvbT4sICJSdXNzZWxsIEtpbmcgKE9yYWNsZSkiIDxsaW51eEBh
cm1saW51eC5vcmcudWs+LCBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZywgYW5kcmV3K25ldGRl
dkBsdW5uLmNoLCBkYXZlbUBkYXZlbWxvZnQubmV0LCBlZHVtYXpldEBnb29nbGUuY29tLCBrdWJh
QGtlcm5lbC5vcmcsIHJvYmhAa2VybmVsLm9yZywga3J6aytkdEBrZXJuZWwub3JnLCBjb25vcitk
dEBrZXJuZWwub3JnLCBuZXRkZXZAdmdlci5rZXJuZWwub3JnLCBwYWJlbmlAcmVkaGF0LmNvbSwg
bWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbSwgYWxleGFuZHJlLnRvcmd1ZUBmb3NzLnN0LmNvbSwg
bGludXgtc3RtMzJAc3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbSwgbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLCBuaW5n
eXVAZXN3aW5jb21wdXRpbmcuY29tLCBsaW5taW5AZXN3aW5jb21wdXRpbmcuY29tLCBwaW5rZXNo
LnZhZ2hlbGFAZWluZm9jaGlwcy5jb20sIHdlaXNoYW5nanVhbkBlc3dpbmNvbXB1dGluZy5jb20K
PiBTdWJqZWN0OiBSZTogUmU6IFtQQVRDSCB2MSAxLzJdIGR0LWJpbmRpbmdzOiBldGhlcm5ldDog
ZXN3aW46IGFkZCBjbG9jayBzYW1wbGluZyBjb250cm9sCj4gCj4gPiBXZSBhbHNvIGludGVuZAo+
ID4gdG8gdXBzdHJlYW0gY29tcGxldGUgRFRTIGZpbGVzIGZvciBFSUM3NzAwIHNvIHRoZSBiaW5k
aW5ncyBjYW4gYmUgdmFsaWRhdGVkCj4gPiBhZ2FpbnN0IHJlYWwgaGFyZHdhcmUuCj4gCj4gSSBz
dWdnZXN0IHlvdSBwcmlvcml0aXNlIHRoaXMuIEFSTS1TT0MgaXMgcHJldHR5IGZsZXhpYmxlIGZv
cgo+IGFjY2VwdGluZyB3b3JrIGluIHByb2dyZXNzIHN1cHBvcnQgZm9yIG5ldyBTb0NzLiBBbGwg
eW91IHJlYWxseSBuZWVkCj4gaXMgZm9yIHRoZSBib2FyZCB0byBib290IHRvIGEgbG9naW4gcHJv
bXB0IG9uIGEgc2VyaWFsIHBvcnQgdXNpbmcgYW4KPiBpbml0cmFtc2ZzLiBTbyB0aGUgLmR0c2kg
YW5kIC5kdHMgZmlsZSBjYW4gYmUgdmVyeSBzbGltLCBDUFVzLCBtZW1vcnkKPiBhbmQgVUFSVHMu
Cj4gCj4gT25jZSB5b3UgaGF2ZSB0aGF0IG1lcmdlZCB5b3UgY2FuIHdvcmsgb24gdGhlIG90aGVy
IGRyaXZlcnMsIHRoZWlyCj4gYmluZGluZ3MsIGV0Yy4KPiAKVGhlIGVpYzc3MDAuZHRzaSBhbmQg
ZWljNzcwMC1oaWZpdmUtcHJlbWllci1wNTUwLmR0cyBhcmUgYWxyZWFkeSBpbgp2Ni4xOS1yYzYu
IEFzIHlvdSBzYWlkLCBpdCBvbmx5IGluY2x1ZGVzIENQVXMsIG1lbW9yeSBhbmQgVUFSVHMgcmln
aHQKbm93LiBJdCBoYXMgYmVlbiB2ZXJpZmllZCB0byBiZSBhYmxlIHRvIGxvZ2luIHByb21wdCBv
biBhIHNlcmlhbCBwb3J0CnVzaW5nIGFuIGluaXRyYW1mcy4KQmVzaWRlcywgdGhlIHJlc2V0IGRy
aXZlciBmb3IgZWljNzcwMCBoYXMgYWxyZWFkeSBiZWVuIG1lcmdlZCBpbiB2Ni4xOS1yYzYuCgpC
ZWNhdXNlIHRoZSBkZXZpY2UgZHJpdmVycyBzdWNoIGFzIEV0aGVybmV0IHJlbHkgb24gdGhlIGNs
b2NrIGRyaXZlciwKb3VyIHBsYW4gaXMgdGhhdCBvbmNlIHRoZSBjbG9jayBkcml2ZXIgaXMgYXBw
bGllZCwgd2Ugd2lsbCBhZGQgb3RoZXIKZGV2aWNlIG5vZGVzIHN1Y2ggYXMgRXRoZXJuZXQgYW5k
IGVNTUMgaW4gdGhlIG5leHQgdXBzdHJlYW0gcGF0Y2gKb2YgdGhlIERUUy4gSXMgdGhpcyByZWFz
b25hYmxlPwoKUmVnYXJkcywKTGluIE1pbgo=

