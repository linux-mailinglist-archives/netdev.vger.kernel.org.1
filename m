Return-Path: <netdev+bounces-211140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68862B16E00
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 10:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAC8F7AE313
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 08:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFA528FFD2;
	Thu, 31 Jul 2025 08:57:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1956C21FF4C;
	Thu, 31 Jul 2025 08:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952264; cv=none; b=uqkspKUHlEdx9Ynxkp2j25cmOJkrK6uLrHVbS7KcUWEmbVGjP3XhvrKnE1jYHHD0mb9C65+lQDlrStSdPhYoMinlyVsmYxpOVWUt7C8mSxhRhNGhVtj6jfNaEGpyvK9U3Wzg/TWDl+cXOAnZbZfpanXwi1d6x83GKjcVhHIimCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952264; c=relaxed/simple;
	bh=k2Nx/LegFy/E1eU89PbApIE6ldIbJeB0zgfUhW6ateM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=TSIecRaGGjIiUku4qnBocNXTR3uzNV3yoMclLZ216hI+gmfJzbxW7XcO5sMa/QWhLg6mEZRz9qGB+4SVu/gHAGnmVP7cRE2ije0+2PdArNK9PEchPrBEspr7bPzdTEBb+h2cEUHbIE1VsMfd/wLCPGxEU2Qnm3fGJA93Ir0dYQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Thu, 31 Jul 2025 16:56:57 +0800 (GMT+08:00)
Date: Thu, 31 Jul 2025 16:56:57 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: weishangjuan@eswincomputing.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	yong.liang.choong@linux.intel.com, vladimir.oltean@nxp.com,
	jszhang@kernel.org, jan.petrous@oss.nxp.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, inochiama@gmail.com,
	boon.khai.ng@altera.com, dfustini@tenstorrent.com, 0x1207@gmail.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: Re: Re: Re: Re: [PATCH v3 2/2] ethernet: eswin: Add eic7700
 ethernet driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <28a48738-af05-41a4-be4c-5ca9ec2071d3@lunn.ch>
References: <20250703091808.1092-1-weishangjuan@eswincomputing.com>
 <20250703092015.1200-1-weishangjuan@eswincomputing.com>
 <c212c50e-52ae-4330-8e67-792e83ab29e4@lunn.ch>
 <7ccc507d.34b1.1980d6a26c0.Coremail.lizhi2@eswincomputing.com>
 <e734f2fd-b96f-4981-9f00-a94f3fd03213@lunn.ch>
 <6c5f12cd.37b0.1982ada38e5.Coremail.lizhi2@eswincomputing.com>
 <6b3c8130-77f0-4266-b1ed-2de80e0113b0@lunn.ch>
 <006c01dbfafb$3a99e0e0$afcda2a0$@eswincomputing.com>
 <28a48738-af05-41a4-be4c-5ca9ec2071d3@lunn.ch>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2b4deeba.3f61.1985fb2e8d4.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TAJkCgA3WxHaL4toD0e5AA--.13444W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAgEADGiKSUwhLgABsm
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

RGVhciBBbmRyZXcgTHVubiwKVGhhbmsgeW91IGZvciB5b3VyIHByb2Zlc3Npb25hbCBhbmQgdmFs
dWFibGUgc3VnZ2VzdGlvbnMuCk91ciBxdWVzdGlvbnMgYXJlIGVtYmVkZGVkIGJlbG93IHlvdXIg
Y29tbWVudHMgaW4gdGhlIG9yaWdpbmFsIGVtYWlsIGJlbG93LgoKCkJlc3QgcmVnYXJkcywKCkxp
IFpoaQpFc3dpbiBDb21wdXRpbmcKCgo+IC0tLS0t5Y6f5aeL6YKu5Lu2LS0tLS0KPiDlj5Hku7bk
uro6ICJBbmRyZXcgTHVubiIgPGFuZHJld0BsdW5uLmNoPgo+IOWPkemAgeaXtumXtDoyMDI1LTA3
LTIyIDIyOjA3OjIzICjmmJ/mnJ/kuowpCj4g5pS25Lu25Lq6OiDmnY7lv5cgPGxpemhpMkBlc3dp
bmNvbXB1dGluZy5jb20+Cj4g5oqE6YCBOiB3ZWlzaGFuZ2p1YW5AZXN3aW5jb21wdXRpbmcuY29t
LCBhbmRyZXcrbmV0ZGV2QGx1bm4uY2gsIGRhdmVtQGRhdmVtbG9mdC5uZXQsIGVkdW1hemV0QGdv
b2dsZS5jb20sIGt1YmFAa2VybmVsLm9yZywgcm9iaEBrZXJuZWwub3JnLCBrcnprK2R0QGtlcm5l
bC5vcmcsIGNvbm9yK2R0QGtlcm5lbC5vcmcsIG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcsIGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLCBtY29x
dWVsaW4uc3RtMzJAZ21haWwuY29tLCBhbGV4YW5kcmUudG9yZ3VlQGZvc3Muc3QuY29tLCBybWsr
a2VybmVsQGFybWxpbnV4Lm9yZy51aywgeW9uZy5saWFuZy5jaG9vbmdAbGludXguaW50ZWwuY29t
LCB2bGFkaW1pci5vbHRlYW5AbnhwLmNvbSwganN6aGFuZ0BrZXJuZWwub3JnLCBqYW4ucGV0cm91
c0Bvc3MubnhwLmNvbSwgcHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tLCBp
bm9jaGlhbWFAZ21haWwuY29tLCBib29uLmtoYWkubmdAYWx0ZXJhLmNvbSwgZGZ1c3RpbmlAdGVu
c3RvcnJlbnQuY29tLCAweDEyMDdAZ21haWwuY29tLCBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFu
LnN0b3JtcmVwbHkuY29tLCBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcsIG5p
bmd5dUBlc3dpbmNvbXB1dGluZy5jb20sIGxpbm1pbkBlc3dpbmNvbXB1dGluZy5jb20sIHBpbmtl
c2gudmFnaGVsYUBlaW5mb2NoaXBzLmNvbQo+IOS4u+mimDogUmU6IFJlOiBSZTogUmU6IFtQQVRD
SCB2MyAyLzJdIGV0aGVybmV0OiBlc3dpbjogQWRkIGVpYzc3MDAgZXRoZXJuZXQgZHJpdmVyCj4g
Cj4gPiBJbiB2MiwgYGVzd2luLGRseS1wYXJhbS14eHhgIGlzIHVzZWQgdG8gY29uZmlndXJlIGFs
bCBkZWxheSByZWdpc3RlcnMgdmlhCj4gPiBkZXZpY2UgdHJlZSwgaW5jbHVkaW5nIFJYQ0xLIGFu
ZCBUWENMSy4gQmFzZWQgb24gdGhlIGxhdGVzdCBkaXNjdXNzaW9uLAo+ID4gdGhpcyBhcHByb2Fj
aCBpbiB0aGUgbmV4dCB2ZXJzaW9uOgo+ID4gLSBUaGUgZGVsYXkgY29uZmlndXJhdGlvbiBmb3Ig
UlhDTEsgYW5kIFRYQ0xLIHdpbGwgYmUgaGFuZGxlZCB1c2luZyB0aGUKPiA+ICBzdGFuZGFyZCBE
VCBwcm9wZXJ0aWVzIGByeC1pbnRlcm5hbC1kZWxheS1wc2AgYW5kIGB0eC1pbnRlcm5hbC1kZWxh
eS1wc2AuCj4gPiAtIFRoZSByZW1haW5pbmcgZGVsYXkgY29uZmlndXJhdGlvbiAoZS5nLiwgZm9y
IFJYRDAtNCwgVFhEMC00LCBSWERWKSB3aWxsCj4gPiAgY29udGludWUgdG8gdXNlIHRoZSB2ZW5k
b3Itc3BlY2lmaWMgYGVzd2luLGRseS1wYXJhbS14eHhgIHByb3BlcnRpZXMuCj4gPiAtIElmIHRo
ZSBzdGFuZGFyZCBkZWxheSBwcm9wZXJ0aWVzIGFyZSBub3Qgc3BlY2lmaWVkIGluIERULCBhIGRl
ZmF1bHQgb2YgMAo+ID4gcHMKPiA+ICB3aWxsIGJlIGFzc3VtZWQuCj4gCj4gUGxlYXNlIGtlZXAg
dGhlIFJHTUlJIHN0YW5kYXJkIGluIG1pbmQuIEFsbCBpdCBzYXlzIGlzIHRoYXQgdGhlcmUKPiBz
aG91bGQgYmUgYSAybnMgZGVsYXkgYmV0d2VlbiB0aGUgZGF0YSBhbmQgdGhlIGNsb2NrIHNpZ25h
bC4gSXQgaXMKPiBhbHNvIHF1aXRlIGdlbmVyb3VzIG9uIHRoZSByYW5nZSBvZiBkZWxheXMgd2hp
Y2ggc2hvdWxkIGFjdHVhbGx5Cj4gd29yay4gSXQgc2F5cyBub3RoaW5nIGFib3V0IGJlaW5nIGFi
bGUgdG8gY29uZmlndXJlIHRoYXQgZGVsYXkuIEFuZCBpdAo+IGRlZmluaXRlbHkgc2F5cyBub3Ro
aW5nIGFib3V0IGJlaW5nIGFibGUgdG8gY29uZmlndXJlIGVhY2ggaW5kaXZpZHVhbAo+IHNpbmds
ZS4KPiAKPiBZb3UgaGFyZHdhcmUgaGFzIGEgbG90IG9mIGZsZXhpYmlsaXR5LCBidXQgbm9uZSBv
ZiBpZiBzaG91bGQgYWN0dWFsbHkKPiBiZSBuZWVkZWQsIGlmIHlvdSBmb2xsb3cgdGhlIHN0YW5k
YXJkLgo+IAo+IFNvIHBoeS1tb2RlID0gInJnbWlpLWlkIjsgc2hvdWxkIGJlIGFsbCB5b3UgbmVl
ZCBmb3IgbW9zdCBib2FyZHMuCj4gRXZlcnl0aGluZyBlbHNlIHNob3VsZCBiZSBvcHRpb25hbCwg
d2l0aCBzZW5zaWJsZSBkZWZhdWx0cy4KPiAKCk9uIG91ciBwbGF0Zm9ybSwgdGhlIHZlbmRvci1z
cGVjaWZpYyBhdHRyaWJ1dGVzIGVzd2luLGRseS1wYXJhbS0qIHdlcmUKaW5pdGlhbGx5IGludHJv
ZHVjZWQgdG8gY29tcGVuc2F0ZSBmb3IgYm9hcmQtc3BlY2lmaWMgdmFyaWF0aW9ucyBpbiBSR01J
SQpzaWduYWwgdGltaW5nLCBwcmltYXJpbHkgZHVlIHRvIGRpZmZlcmVuY2VzIGluIFBDQiB0cmFj
ZSBsZW5ndGhzLiBUaGVzZQphdHRyaWJ1dGVzIGFsbG93IGZpbmUtZ3JhaW5lZCwgcGVyLXNpZ25h
bCBkZWxheSBjb250cm9sIGZvciBSWEQsIFRYRCwKVFhFTiwgUlhEViwgUlhDTEssIGFuZCBUWENM
SywgYmFzZWQgb24gZW1waXJpY2FsbHkgZGVyaXZlZCBvcHRpbWFsIHBoYXNlCnNldHRpbmdzLgpJ
biBvdXIgZXhwZXJpZW5jZSwgc2V0dGluZyBwaHktbW9kZSA9ICJyZ21paS1pZCIgYWxvbmUsIGFs
b25nIHdpdGggb25seQp0aGUgc3RhbmRhcmQgcHJvcGVydGllcyByeC1pbnRlcm5hbC1kZWxheS1w
cyBhbmQgdHgtaW50ZXJuYWwtZGVsYXktcHMsCmhhcyBwcm92ZW4gaW5zdWZmaWNpZW50IHRvIG1l
ZXQgb3VyIGhhcmR3YXJlJ3MgdGltaW5nIHJlcXVpcmVtZW50cy4KVGhlcmVmb3JlIHRoZXNlIHN0
YW5kYXJkIHByb3BlcnRpZXMgYXJlIHRyZWF0ZWQgYXMgY29udHJvbGxpbmcgb25seSBSWENMSwph
bmQgVFhDTEssIHdoaWxlIGNvbnRpbnVpbmcgdG8gdXNlIHRoZSBlc3dpbixkbHktcGFyYW0tKiBh
dHRyaWJ1dGVzIGZvcgpvdGhlciBzaWduYWxzLgpBZGRpdGlvbmFsbHksIGlmIHJ4LWludGVybmFs
LWRlbGF5LXBzIGFuZCB0eC1pbnRlcm5hbC1kZWxheS1wcyBhcmUKb21pdHRlZCwgdGhlaXIgdmFs
dWVzIGRlZmF1bHQgdG8gMHBzIGR1ZSB0byB0aGUgdXNlIG9mIGRldm1fa3phbGxvYygpLgpUaGlz
IGJlaGF2aW9yIHJlaW5mb3JjZXMgdGhlIG5lZWQgZm9yIGV4cGxpY2l0IGRlbGF5IHZhbHVlcyBp
biBjZXJ0YWluCmNvbmZpZ3VyYXRpb25zLiBGb3IgcmVmZXJlbmNlLCBUSSBwbGF0Zm9ybXMgdXNl
IGEgZGVkaWNhdGVkIElPREVMQVkKaGFyZHdhcmUgbW9kdWxlIHRvIHByb2dyYW0gcGVyLXNpZ25h
bCBSR01JSSBkZWxheXMgaW4gYSBzaW1pbGFyIGZhc2hpb24uCgpBcyBwZXIgeW91ciBzdWdnZXN0
aW9uLCB3ZSB3aWxsIHNldCBtb2RlPSJyZ21paS1pZCIuCldlIGhhdmUgcXVlc3Rpb25zIG9uIHNl
dHRpbmcgZGVsYXkgcGFyYW1ldGVycyBmcm9tIGR0cyB3ZSBoYXZlIHR3bwphcHByb2NoZXMuIENv
dWxkIHlvdSBwbGVhc2UgbGV0IHVzIGtub3cgd2hpY2ggYXBwcm9hY2ggaXMgYXBwcm9wcmlhdGU/
CgoxLiBTZXR0aW5nIGFsbCBkZWxheSBwYXJhbWV0ZXJzIChSWEQsIFRYRCwgVFhFTiwgUlhEViwg
UlhDTEssIGFuZCBUWENMSykKICAgdXNpbmcgdmVuZG9yLXNwZWNpZmljIGF0dHJpYnV0ZXPCoGVz
d2luLGRseS1wYXJhbS0qLgogICBlLmcuCiAgIGVzd2luLGRseS1wYXJhbS0xMDAwbSA9IDwweDIw
MjAyMDIwIDB4OTYyMDVBMjAgMHgyMDIwMjAyMD47CjIuIFNldHRpbmcgZGVsYXkgcGFyYW1ldGVy
cyAoUlhELCBUWEQsIFRYRU4sIFJYRFYpIHVzaW5nIHZlbmRvci1zcGVjaWZpYwogICBhdHRyaWJ1
dGVzwqBlc3dpbixkbHktcGFyYW0tKsKgLCBSWENMSyB1c2luZyByeC1pbnRlcm5hbC1kZWxheS1w
cyBhbmQKICAgVFhDTEsgdXNpbmcgdHgtaW50ZXJuYWwtZGVsYXktcHMuCiAgIGUuZwogICBlc3dp
bixkbHktcGFyYW0tMTAwMG0gPSA8MHgyMDIwMjAyMCAweDgwMjAwMDIwIDB4MjAyMDIwMjA+Owog
ICByeC1pbnRlcm5hbC1kZWxheS1wcyA9IDw5MDAwPjsKICAgdHgtaW50ZXJuYWwtZGVsYXktcHMg
PSA8MjIwMD47Cgo+IAlBbmRyZXcK

