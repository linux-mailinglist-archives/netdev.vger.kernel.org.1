Return-Path: <netdev+bounces-293945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id F1vjDMgtHmrUhgkAu9opvQ
	(envelope-from <netdev+bounces-293945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 03:11:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3E7626C90
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 03:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 299B4300D87C
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 01:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED107331230;
	Tue,  2 Jun 2026 01:11:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8F22848BA;
	Tue,  2 Jun 2026 01:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780362692; cv=none; b=KD8WLboNS64hCgJDqScHspej/yeAHY7Z47unVRZoxPbee4ElwgRn1aWZFMBGukXMdGZzO3WOVJ8xY1bg/LkFI3fol4p8dyG7BpRKLfOEOznzaUpa11WOwuN+K5IG2NqbYrH9cDvcRgrNSvsk+hrnYuzvzLldl0C0tN9G1TREg/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780362692; c=relaxed/simple;
	bh=DdWVFDKv0uqoGvd9EXIAE+fQ/WKxVpErqNmxBJr6nWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=evYptynIIT+tAcNWf6BkxbgHjU+6Q531xxom6YOc0Qvi2tkK3LxyCK6jcWEzRttitOEg19AfZ7kmOjrwhWjMTuQKw5zlbihEFdKv1Up3IhZGXUDula2xckEpLylHT9AY4CVC0DRTyOYQyHxJLKuIDwSnLE2HHcl9ZwqgYnDFLzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Tue, 2 Jun 2026 09:10:57 +0800 (GMT+08:00)
Date: Tue, 2 Jun 2026 09:10:57 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Rob Herring" <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com, sashiko-bot@kernel.org,
	"Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: Re: [PATCH net v2] dt-bindings: ethernet: eswin: fix hsp-sp-csr
 backward compatibility
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260601213406.GA26933-robh@kernel.org>
References: <20260601032852.961-1-lizhi2@eswincomputing.com>
 <20260601213406.GA26933-robh@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <29be007f.8dd9.19e85e23e48.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TAJkCgDHaXOhLR5qwWggAA--.8788W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAQEGDGodtB8IUAAAsO
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293945-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.002];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8A3E7626C90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiUm9iIEhlcnJpbmciIDxy
b2JoQGtlcm5lbC5vcmc+Cj4gU2VuZCB0aW1lOlR1ZXNkYXksIDAyLzA2LzIwMjYgMDU6MzQ6MDYK
PiBUbzogbGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbQo+IENjOiBhbmRyZXcrbmV0ZGV2QGx1bm4u
Y2gsIGRhdmVtQGRhdmVtbG9mdC5uZXQsIGVkdW1hemV0QGdvb2dsZS5jb20sIGt1YmFAa2VybmVs
Lm9yZywgcGFiZW5pQHJlZGhhdC5jb20sIGtyemsrZHRAa2VybmVsLm9yZywgY29ub3IrZHRAa2Vy
bmVsLm9yZywgbmV0ZGV2QHZnZXIua2VybmVsLm9yZywgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsIG5pbmd5dUBlc3dpbmNvbXB1dGluZy5j
b20sIGxpbm1pbkBlc3dpbmNvbXB1dGluZy5jb20sIHBpbmtlc2gudmFnaGVsYUBlaW5mb2NoaXBz
LmNvbSwgcHJpdGVzaC5wYXRlbEBlaW5mb2NoaXBzLmNvbSwgd2Vpc2hhbmdqdWFuQGVzd2luY29t
cHV0aW5nLmNvbSwgc2FzaGlrby1ib3RAa2VybmVsLm9yZywgIktyenlzenRvZiBLb3psb3dza2ki
IDxrcnp5c3p0b2Yua296bG93c2tpQG9zcy5xdWFsY29tbS5jb20+Cj4gU3ViamVjdDogUmU6IFtQ
QVRDSCBuZXQgdjJdIGR0LWJpbmRpbmdzOiBldGhlcm5ldDogZXN3aW46IGZpeCBoc3Atc3AtY3Ny
IGJhY2t3YXJkIGNvbXBhdGliaWxpdHkKPiAKPiBPbiBNb24sIEp1biAwMSwgMjAyNiBhdCAxMToy
ODo1MkFNICswODAwLCBsaXpoaTJAZXN3aW5jb21wdXRpbmcuY29tIHdyb3RlOgo+ID4gRnJvbTog
WmhpIExpIDxsaXpoaTJAZXN3aW5jb21wdXRpbmcuY29tPgo+ID4gCj4gPiBjMzYwNjljNmY0NmMg
YWRkZWQgdHdvIG9wdGlvbmFsIGNlbGxzIHRvIGVzd2luLGhzcC1zcC1jc3IsIGJ1dAo+ID4gb21p
dHRlZCBtaW5JdGVtczogNC4KPiAKPiBQbGVhc2UgcnVuIGNoZWNrcGF0Y2gucGwgYW5kIGZpeCB0
aGUgaXNzdWUgaXQgcmVwb3J0cyB3aXRoIHRoZSBjb21taXQgCj4gcmVmZXJlbmNlLgo+IAoKVGhh
bmtzIGZvciBwb2ludGluZyB0aGlzIG91dC4KCkknbGwgZml4IGl0IGFuZCBzZW5kIGEgdjMuCgo+
ID4gCj4gPiBBcyBhIHJlc3VsdCwgZHQtc2NoZW1hIGltcGxpY2l0bHkgcmVxdWlyZWQgYWxsIDYg
Y2VsbHMsIHdoaWNoCj4gPiBicm9rZSBiYWNrd2FyZCBjb21wYXRpYmlsaXR5IHdpdGggZXhpc3Rp
bmcgNC1jZWxsIGRldmljZSB0cmVlcy4KPiA+IAo+ID4gQWRkIG1pbkl0ZW1zOiA0IHRvIHByZXNl
cnZlIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkuCj4gPiAKPiA+IEZpeGVzOiBjMzYwNjljNmY0NmMg
KCJkdC1iaW5kaW5nczogZXRoZXJuZXQ6IGVzd2luOiBhZGQgb3B0aW9uYWwgVFhEIGFuZCBSWEQg
ZGVsYXkgcmVnaXN0ZXIgb2Zmc2V0cyIpCj4gPiBSZXBvcnRlZC1ieTogU2FzaGlrbyBBSSA8c2Fz
aGlrby1ib3RAa2VybmVsLm9yZz4KPiA+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzIwMjYwNTE5MDIyMzM0LjM1NzQyQzJCQ0I3QHNtdHAua2VybmVsLm9yZy8KPiA+IFJldmll
d2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQG9zcy5xdWFs
Y29tbS5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGkgTGkgPGxpemhpMkBlc3dpbmNvbXB1dGlu
Zy5jb20+Cj4gPiAtLS0KPiA+IENoYW5nZXMgaW4gdjI6Cj4gPiAgIC0gUmVmZXJlbmNlIGMzNjA2
OWM2ZjQ2YyBleHBsaWNpdGx5IGluc3RlYWQgb2YgInByZXZpb3VzIGNoYW5nZSIuCj4gPiAgIC0g
SW1wcm92ZSBjb21taXQgbWVzc2FnZSBmb3JtYXR0aW5nIGFuZCBsaW5lIHdyYXBwaW5nLgo+ID4g
ICAtIE5vIGZ1bmN0aW9uYWwgY2hhbmdlLgo+ID4gICAtIExpbmsgdG8gdjE6Cj4gPiAgICAgaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI2MDUyNTA1MjQ0MS4xNjM3LTEtbGl6aGkyQGVz
d2luY29tcHV0aW5nLmNvbS8KPiA+IC0tLQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9uZXQvZXN3aW4sZWljNzcwMC1ldGgueWFtbCB8IDMgKystCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9lc3dpbixlaWM3NzAwLWV0
aC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9lc3dpbixlaWM3
NzAwLWV0aC55YW1sCj4gPiBpbmRleCBiNjZhZTYzMDBmYWYuLjY1ODgyZmY3OWQ4ZCAxMDA2NDQK
PiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvZXN3aW4sZWlj
NzcwMC1ldGgueWFtbAo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L25ldC9lc3dpbixlaWM3NzAwLWV0aC55YW1sCj4gPiBAQCAtODQsNyArODQsOCBAQCBwcm9wZXJ0
aWVzOgo+ID4gICAgICAgIFRoaXMgcmVmZXJlbmNlIGlzIHByb3ZpZGVkIGZvciBiYWNrZ3JvdW5k
IGluZm9ybWF0aW9uIG9ubHkuCj4gPiAgICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2Rl
ZmluaXRpb25zL3BoYW5kbGUtYXJyYXkKPiA+ICAgICAgaXRlbXM6Cj4gPiAtICAgICAgLSBpdGVt
czoKPiA+ICsgICAgICAtIG1pbkl0ZW1zOiA0Cj4gPiArICAgICAgICBpdGVtczoKPiA+ICAgICAg
ICAgICAgLSBkZXNjcmlwdGlvbjogUGhhbmRsZSB0byBIU1AoSGlnaC1TcGVlZCBQZXJpcGhlcmFs
KSBkZXZpY2UKPiA+ICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogT2Zmc2V0IG9mIHBoeSBjb250
cm9sIHJlZ2lzdGVyIGZvciBpbnRlcm5hbAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICBv
ciBleHRlcm5hbCBjbG9jayBzZWxlY3Rpb24KPiA+IC0tIAo+ID4gMi4yNS4xCj4gPiAKPiA+IAo=


