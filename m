Return-Path: <netdev+bounces-288213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIlTImTMBmrynwIAu9opvQ
	(envelope-from <netdev+bounces-288213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:33:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B51C54AA19
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60A5A302925A
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 07:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE37E3EDE45;
	Fri, 15 May 2026 07:32:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13613DEAC5;
	Fri, 15 May 2026 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830322; cv=none; b=UUaAecBXKzYMjYIPLfVkARpuFlxKWMYU6NwjCiKGjZOqaV2E81jrtFvOxYVEc5kKUTb2ET/D9ddUMbeiF3cnUIwncRtUmxN8X8jL8jruCCJs6XG5vhBGPqoHiMHIvudZgPAQaBrgF+kiHpY2Y/4dVTSduTHMd7cwLs+fZDU1dt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830322; c=relaxed/simple;
	bh=X3AkEkRJJo0jVO99ov3hOjezsomQAOLSpaf7FKnhiJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=lxLEFxOjzUDPstVUUYF02/5DBs8aWDakS443X1X+zxOAM1POhy1A4nNb5Tj1/ZGvI9/ez9tOc0ZheX0sDf/+lAj1AKmQBkfnFtnhke6SbCnxYPhOBLY+z/YhAW8RqOF09GcLVMd75PAaP8LmUQyXdB+bLI0pE8QHXFX/0f1Fy9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Fri, 15 May 2026 15:31:16 +0800 (GMT+08:00)
Date: Fri, 15 May 2026 15:31:16 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: Re: [PATCH net v1 1/2] dt-bindings: ethernet: eswin: refine
 delay model and HSP register description
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <2436c6e9-4aad-4ffd-9fef-0cbbe38dc66d@lunn.ch>
References: <20260507083037.152-1-lizhi2@eswincomputing.com>
 <20260507083136.175-1-lizhi2@eswincomputing.com>
 <2436c6e9-4aad-4ffd-9fef-0cbbe38dc66d@lunn.ch>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <29bee81.8323.19e2a8bf746.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TAJkCgBn_HDFywZq+qYZAA--.7037W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAgEIDGoF+ZIKMwACs4
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Queue-Id: 2B51C54AA19
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288213-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,st-md-mailman.stormreply.com,lists.infradead.org,eswincomputing.com,einfochips.com];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	NEURAL_SPAM(0.00)[0.360];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Cgo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZXMtLS0tLQo+IEZyb206ICJBbmRyZXcgTHVubiIgPGFu
ZHJld0BsdW5uLmNoPgo+IFNlbmQgdGltZTpUaHVyc2RheSwgMDcvMDUvMjAyNiAyMDoyOToxMAo+
IFRvOiBsaXpoaTJAZXN3aW5jb21wdXRpbmcuY29tCj4gQ2M6IGFuZHJldytuZXRkZXZAbHVubi5j
aCwgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldCwgZWR1bWF6ZXRAZ29vZ2xlLmNvbSwga3ViYUBrZXJuZWwu
b3JnLCBwYWJlbmlAcmVkaGF0LmNvbSwgcm9iaEBrZXJuZWwub3JnLCBrcnprK2R0QGtlcm5lbC5v
cmcsIGNvbm9yK2R0QGtlcm5lbC5vcmcsIG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcsIGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLCBtY29xdWVs
aW4uc3RtMzJAZ21haWwuY29tLCBhbGV4YW5kcmUudG9yZ3VlQGZvc3Muc3QuY29tLCBybWsra2Vy
bmVsQGFybWxpbnV4Lm9yZy51aywgbWF4aW1lLmNoZXZhbGxpZXJAYm9vdGxpbi5jb20sIGxpbnV4
LXN0bTMyQHN0LW1kLW1haWxtYW4uc3Rvcm1yZXBseS5jb20sIGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZywgbmluZ3l1QGVzd2luY29tcHV0aW5nLmNvbSwgbGlubWluQGVzd2lu
Y29tcHV0aW5nLmNvbSwgcGlua2VzaC52YWdoZWxhQGVpbmZvY2hpcHMuY29tLCBwcml0ZXNoLnBh
dGVsQGVpbmZvY2hpcHMuY29tLCB3ZWlzaGFuZ2p1YW5AZXN3aW5jb21wdXRpbmcuY29tCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCBuZXQgdjEgMS8yXSBkdC1iaW5kaW5nczogZXRoZXJuZXQ6IGVzd2lu
OiByZWZpbmUgZGVsYXkgbW9kZWwgYW5kIEhTUCByZWdpc3RlciBkZXNjcmlwdGlvbgo+IAo+ID4g
ICAgICBldGhlcm5ldEA1MDQwMDAwMCB7Cj4gPiAgICAgICAgICBjb21wYXRpYmxlID0gImVzd2lu
LGVpYzc3MDAtcW9zLWV0aCIsICJzbnBzLGR3bWFjLTUuMjAiOwo+ID4gICAgICAgICAgcmVnID0g
PDB4NTA0MDAwMDAgMHgxMDAwMD47Cj4gPiAtICAgICAgICBjbG9ja3MgPSA8JmQwX2Nsb2NrIDE4
Nj4sIDwmZDBfY2xvY2sgMTcxPiwgPCZkMF9jbG9jayA0MD4sCj4gPiAtICAgICAgICAgICAgICAg
IDwmZDBfY2xvY2sgMTkzPjsKPiA+IC0gICAgICAgIGNsb2NrLW5hbWVzID0gImF4aSIsICJjZmci
LCAic3RtbWFjZXRoIiwgInR4IjsKPiA+ICAgICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8JnBs
aWM+Owo+ID4gICAgICAgICAgaW50ZXJydXB0cyA9IDw2MT47Cj4gPiAgICAgICAgICBpbnRlcnJ1
cHQtbmFtZXMgPSAibWFjaXJxIjsKPiA+IC0gICAgICAgIHBoeS1tb2RlID0gInJnbWlpLWlkIjsK
PiA+IC0gICAgICAgIHBoeS1oYW5kbGUgPSA8JnBoeTA+Owo+ID4gKyAgICAgICAgY2xvY2tzID0g
PCZkMF9jbG9jayAxODY+LCA8JmQwX2Nsb2NrIDE3MT4sIDwmZDBfY2xvY2sgNDA+LAo+ID4gKyAg
ICAgICAgICAgICAgICA8JmQwX2Nsb2NrIDE5Mz47Cj4gPiArICAgICAgICBjbG9jay1uYW1lcyA9
ICJheGkiLCAiY2ZnIiwgInN0bW1hY2V0aCIsICJ0eCI7Cj4gCj4gUGxlYXNlIGRvbid0IG1vdmUg
dGhlIGNsb2NrcyBhcm91bmQsIHNpbmNlIHRoZXkgaGF2ZSBub3RoaW5nIHRvIGRvCj4gd2l0aCBS
R01JSSBkZWxheXMuCj4gCj4gCj4gPiAgICAgICAgICByZXNldHMgPSA8JnJlc2V0IDk1PjsKPiA+
ICAgICAgICAgIHJlc2V0LW5hbWVzID0gInN0bW1hY2V0aCI7Cj4gPiAtICAgICAgICByeC1pbnRl
cm5hbC1kZWxheS1wcyA9IDwyMDA+Owo+ID4gLSAgICAgICAgdHgtaW50ZXJuYWwtZGVsYXktcHMg
PSA8MjAwPjsKPiA+IC0gICAgICAgIGVzd2luLGhzcC1zcC1jc3IgPSA8JmhzcF9zcF9jc3IgMHgx
MDAgMHgxMDggMHgxMTg+Owo+ID4gLSAgICAgICAgc25wcyxheGktY29uZmlnID0gPCZzdG1tYWNf
YXhpX3NldHVwPjsKPiA+ICsgICAgICAgIGVzd2luLGhzcC1zcC1jc3IgPSA8JmhzcF9zcF9jc3Ig
MHgxMDAgMHgxMDggMHgxMTggMHgxMTQgMHgxMWM+Owo+ID4gKyAgICAgICAgcGh5LWhhbmRsZSA9
IDwmcGh5MD47Cj4gPiArICAgICAgICBwaHktbW9kZSA9ICJyZ21paS1pZCI7Cj4gPiAgICAgICAg
ICBzbnBzLGFhbDsKPiA+ICAgICAgICAgIHNucHMsZml4ZWQtYnVyc3Q7Cj4gPiAgICAgICAgICBz
bnBzLHRzbzsKPiA+IC0gICAgICAgIHN0bW1hY19heGlfc2V0dXA6IHN0bW1hYy1heGktY29uZmln
IHsKPiA+ICsgICAgICAgIHNucHMsYXhpLWNvbmZpZyA9IDwmc3RtbWFjX2F4aV9zZXR1cF9nbWFj
MD47Cj4gPiArCj4gPiArICAgICAgICBzdG1tYWNfYXhpX3NldHVwX2dtYWMwOiBzdG1tYWMtYXhp
LWNvbmZpZyB7Cj4gCj4gQW5kIHdoYXQgZG8gdGhlc2UgY2hhbmdlcyBoYXZlIHRvIGRvIHdpdGgg
UkdNSUkgZGVsYXlzPwo+IAoKSGkgQW5kcmV3LAoKQmVmb3JlIHNlbmRpbmcgdGhlIG5leHQgcmV2
aXNpb24sIEkgd291bGQgbGlrZSB0byBjb25maXJtIG9uZSBwb2ludCBhYm91dAp0aGUgYmluZGlu
ZyB1cGRhdGUuCgpJbiB5b3VyIHByZXZpb3VzIHJldmlldyBjb21tZW50OgpodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sLzdlNTkzZWRlLTU5ZWItNDMxNi1hYjcyLTk0OWE1MWMwMDhjNkBsdW5u
LmNoLwoKeW91IG1lbnRpb25lZCB0aGF0ICJhIHdlbGwgZGVzaWduZWQgYm9hcmQgc2hvdWxkIG5v
dCBuZWVkIGRlbGF5cyIuCgpCYXNlZCBvbiB0aGF0LCBJIGFtIHBsYW5uaW5nIHRvIHJlbW92ZSBy
eC1pbnRlcm5hbC1kZWxheS1wcyBhbmQKdHgtaW50ZXJuYWwtZGVsYXktcHMgZnJvbSB0aGUgcmVx
dWlyZWQgbGlzdC4KClRoZSBpbnRlbnRpb24gaXMgdGhhdCB0aGVzZSBwcm9wZXJ0aWVzIHJlbWFp
biBhdmFpbGFibGUgZm9yIE1BQy1zaWRlCmZpbmUgdHVuaW5nIHdoZW4gbmVlZGVkLCBidXQgYXJl
IG9wdGlvbmFsIHNpbmNlIHRoZSByZXF1aXJlZCBSR01JSSBkZWxheQptYXkgaW5zdGVhZCBiZSBw
cm92aWRlZCBieSB0aGUgUEhZIChmb3IgZXhhbXBsZSB3aXRoIHJnbWlpLWlkKSBvciBieSB0aGUK
Ym9hcmQgZGVzaWduLgoKV291bGQgeW91IGNvbnNpZGVyIHRoaXMgdG8gYmUgYSBmaXggdG8gYW4g
b3Zlcmx5IHJlc3RyaWN0aXZlIHNjaGVtYQpyZXF1aXJlbWVudCwgb3IgbW9yZSBvZiBhIHNjaGVt
YSByZWxheGF0aW9uIC8gaW1wcm92ZW1lbnQ/CgpUaGlzIHdpbGwgaGVscCBkZXRlcm1pbmUgd2hl
dGhlciB0aGlzIGNoYW5nZSBzaG91bGQgcmVtYWluIGluIHRoZSBuZXQKc2VyaWVzIG9yIGJlIG1v
dmVkIHRvIGEgZm9sbG93LXVwIG5ldC1uZXh0IHNlcmllcy4KClRoYW5rcywKWmhpIExpCg==

