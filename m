Return-Path: <netdev+bounces-203672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7404AF6BE7
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD28D17CC00
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 07:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3F6292B42;
	Thu,  3 Jul 2025 07:47:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BED1FFC46;
	Thu,  3 Jul 2025 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751528826; cv=none; b=A/89MbywwjVNrA2wKtBleqzTSAxamWINvK4uVdlyMIPptFSdwDc7xa879N4wYdLMTnelpAODaL7pjQCZ5SvLiB33awl8E2RnliHp2forAC3V7SM4szwq7eBe3RRtlTwObZv5QIajk5dlOUR1myisokaGT+5mSr/YIo2IMRY4jZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751528826; c=relaxed/simple;
	bh=+ZJxOQrATq7hnw8q/mIwpB3YoUGdyaPdgNxmrN0zKA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngn1O+amgAdl/SIFyr+fj3cw6C8u4xcIm1zXRv9H95t3hqgi+7zdtfAnIV9T+YzMrXhisVTsqm43rAyoZB+PmqHRuR5koFrU8yzEFM7A/FNM5dAi7BCoRVSSe6aC12g/iZ8XK0DLUtG4ZdLm2OczhJGNuUboRQ5nbK+QSREqcl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.33.13] (unknown [210.73.43.2])
	by APP-01 (Coremail) with SMTP id qwCowABXg6ddNWZodWypAA--.34433S2;
	Thu, 03 Jul 2025 15:46:38 +0800 (CST)
Message-ID: <ce2881b9-38ed-42b6-824d-72948389e8fa@iscas.ac.cn>
Date: Thu, 3 Jul 2025 15:46:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/5] riscv: dts: spacemit: Add Ethernet
 support for Jupiter
To: Junhui Liu <junhui.liu@pigmoral.tech>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Vivian Wang <uwu@dram.page>, Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250702-net-k1-emac-v3-0-882dc55404f3@iscas.ac.cn>
 <20250702-net-k1-emac-v3-5-882dc55404f3@iscas.ac.cn>
 <a2284afb-ee61-457e-aaa8-49a9ce3838f9@pigmoral.tech>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <a2284afb-ee61-457e-aaa8-49a9ce3838f9@pigmoral.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-CM-TRANSID:qwCowABXg6ddNWZodWypAA--.34433S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy8Ar4fAFWkXFy8uF1fXrb_yoW5Cr4rpF
	Z5JFZ3ArW7Grn3Jr13JryDuF98Cr18J3WkWrn7XF1UJF42vryYgr1jqr1qgr1UJr48Xr15
	Zr1jvrs7urnrtrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmmb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4xvF2IEb7IF0Fy264kE64k0F24l
	FcxC0VAYjxAxZF0Ex2IqxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZV
	WrXwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJwCE64xvF2IEb7IF0Fy7
	YxBIdaVFxhVjvjDU0xZFpf9x07jHLvNUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

SGkgSnVuaHVpLA0KDQpPbiA3LzMvMjUgMTQ6NDgsIEp1bmh1aSBMaXUgd3JvdGU6DQo+IEhp
IFZpdmlhbiwNCj4gVGhhbmtzIGZvciB5b3Ugd29yayENCj4NCj4gT24gMjAyNS83LzIgMTQ6
MDEsIFZpdmlhbiBXYW5nIHdyb3RlOg0KPj4gTWlsay1WIEp1cGl0ZXIgdXNlcyBhbiBSR01J
SSBQSFkgZm9yIGVhY2ggcG9ydCBhbmQgdXNlcyBHUElPIGZvciBQSFkNCj4+IHJlc2V0Lg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZpdmlhbiBXYW5nIDx3YW5ncnVpa2FuZ0Bpc2Nhcy5h
Yy5jbj4NCj4NCj4gU3VjY2Vzc2Z1bGx5IHRlc3RlZCB3aXRoIGlwZXJmMyBvbiBNaWxrLVYg
SnVwaXRlci4NCj4NCj4gVENQIFJ4OiA5NDEgTWJpdHMvc2VjDQo+IFRDUCBUeDogOTQzIE1i
aXRzL3NlYw0KPiBVRFAgUng6IDk1NiBNYml0cy9zZWMNCj4gVURQIFR4OiA5NTYgTWJpdHMv
c2VjDQo+DQo+IFRlc3RlZC1ieTogSnVuaHVpIExpdSA8anVuaHVpLmxpdUBwaWdtb3JhbC50
ZWNoPsKgDQo+DQpUaGFua3MgZm9yIHRoZSB0ZXN0aW5nISBJIGRvIG5vdCBoYXZlIGEgTWls
ay1WIEp1cGl0ZXIgaGFuZHksIHNvIHRoYXQNCndhcyB2ZXJ5IGhlbHBmdWwuDQoNCkFzIGRp
c2N1c3NlZCBbMV0sIEkgd2lsbCBwb3N0IGEgdjQgc29vbiB3aXRoIG1pbm9yIGZpeGVzIGFu
ZCBhbHNvIHNhbnMNCnRoZSBEVFMgY2hhbmdlcy4gSSB3aWxsIHB1dCB5b3VyIFRlc3RlZC1i
eSBvbiB0aGUgZHJpdmVyIHBhdGNoIGluc3RlYWQNCm9mIHRoaXMgRFRTIHBhdGNoLCBzbyBp
dCB3aWxsIHNob3cgdXAgaW4gdjQuDQoNCkFyZSB5b3Ugb2theSB3aXRoIHRoaXM/IElmIHlv
dSBkb24ndCBsaWtlIGl0IGZlZWwgZnJlZSB0byB0ZWxsIG1lLg0KDQpSZWdhcmRzLA0KVml2
aWFuICJkcmFtZm9yZXZlciIgV2FuZw0KDQpbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3NwYWNlbWl0L2E5Y2FkMDdjLTA5NzMtNDNjMy04OWYzLTk1Yjg1NmI1NzVkZkBpc2Nhcy5h
Yy5jbi8NCg0KPj4gLS0tDQo+PiDCoCBhcmNoL3Jpc2N2L2Jvb3QvZHRzL3NwYWNlbWl0L2sx
LW1pbGt2LWp1cGl0ZXIuZHRzIHwgNDYNCj4+ICsrKysrKysrKysrKysrKysrKysrKysrDQo+
PiDCoCAxIGZpbGUgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3NwYWNlbWl0L2sxLW1pbGt2LWp1cGl0ZXIuZHRz
DQo+PiBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3BhY2VtaXQvazEtbWlsa3YtanVwaXRlci5k
dHMNCj4+IGluZGV4DQo+PiA0NDgzMTkyMTQxMDQ5Y2FhMjAxYzA5M2ZiMjA2YjYxMzRhMDY0
ZjQyLi5jNTkzMzU1NWMwNmI2NmY0MGU2MWZlMmI5YzE1OWJhMDc3MGMyZmExDQo+PiAxMDA2
NDQNCj4+IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3BhY2VtaXQvazEtbWlsa3YtanVw
aXRlci5kdHMNCj4+ICsrKyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3BhY2VtaXQvazEtbWls
a3YtanVwaXRlci5kdHMNCj4+IEBAIC0yMCw2ICsyMCw1MiBAQCBjaG9zZW4gew0KPj4gwqDC
oMKgwqDCoCB9Ow0KPj4gwqAgfTsNCj4+IMKgICsmZXRoMCB7DQo+PiArwqDCoMKgIHBoeS1o
YW5kbGUgPSA8JnJnbWlpMD47DQo+PiArwqDCoMKgIHBoeS1tb2RlID0gInJnbWlpLWlkIjsN
Cj4+ICvCoMKgwqAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4+ICvCoMKgwqAgcGlu
Y3RybC0wID0gPCZnbWFjMF9jZmc+Ow0KPj4gK8KgwqDCoCByeC1pbnRlcm5hbC1kZWxheS1w
cyA9IDwwPjsNCj4+ICvCoMKgwqAgdHgtaW50ZXJuYWwtZGVsYXktcHMgPSA8MD47DQo+PiAr
wqDCoMKgIHN0YXR1cyA9ICJva2F5IjsNCj4+ICsNCj4+ICvCoMKgwqAgbWRpby1idXMgew0K
Pj4gK8KgwqDCoMKgwqDCoMKgICNhZGRyZXNzLWNlbGxzID0gPDB4MT47DQo+PiArwqDCoMKg
wqDCoMKgwqAgI3NpemUtY2VsbHMgPSA8MHgwPjsNCj4+ICsNCj4+ICvCoMKgwqDCoMKgwqDC
oCByZXNldC1ncGlvcyA9IDwmZ3BpbyBLMV9HUElPKDExMCkgR1BJT19BQ1RJVkVfTE9XPjsN
Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXNldC1kZWxheS11cyA9IDwxMDAwMD47DQo+PiArwqDC
oMKgwqDCoMKgwqAgcmVzZXQtcG9zdC1kZWxheS11cyA9IDwxMDAwMDA+Ow0KPj4gKw0KPj4g
K8KgwqDCoMKgwqDCoMKgIHJnbWlpMDogcGh5QDEgew0KPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmVnID0gPDB4MT47DQo+PiArwqDCoMKgwqDCoMKgwqAgfTsNCj4+ICvCoMKgwqAg
fTsNCj4+ICt9Ow0KPj4gKw0KPj4gKyZldGgxIHsNCj4+ICvCoMKgwqAgcGh5LWhhbmRsZSA9
IDwmcmdtaWkxPjsNCj4+ICvCoMKgwqAgcGh5LW1vZGUgPSAicmdtaWktaWQiOw0KPj4gK8Kg
wqDCoCBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPj4gK8KgwqDCoCBwaW5jdHJsLTAg
PSA8JmdtYWMxX2NmZz47DQo+PiArwqDCoMKgIHJ4LWludGVybmFsLWRlbGF5LXBzID0gPDA+
Ow0KPj4gK8KgwqDCoCB0eC1pbnRlcm5hbC1kZWxheS1wcyA9IDwyNTA+Ow0KPj4gK8KgwqDC
oCBzdGF0dXMgPSAib2theSI7DQo+PiArDQo+PiArwqDCoMKgIG1kaW8tYnVzIHsNCj4+ICvC
oMKgwqDCoMKgwqDCoCAjYWRkcmVzcy1jZWxscyA9IDwweDE+Ow0KPj4gK8KgwqDCoMKgwqDC
oMKgICNzaXplLWNlbGxzID0gPDB4MD47DQo+PiArDQo+PiArwqDCoMKgwqDCoMKgwqAgcmVz
ZXQtZ3Bpb3MgPSA8JmdwaW8gSzFfR1BJTygxMTUpIEdQSU9fQUNUSVZFX0xPVz47DQo+PiAr
wqDCoMKgwqDCoMKgwqAgcmVzZXQtZGVsYXktdXMgPSA8MTAwMDA+Ow0KPj4gK8KgwqDCoMKg
wqDCoMKgIHJlc2V0LXBvc3QtZGVsYXktdXMgPSA8MTAwMDAwPjsNCj4+ICsNCj4+ICvCoMKg
wqDCoMKgwqDCoCByZ21paTE6IHBoeUAxIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJlZyA9IDwweDE+Ow0KPj4gK8KgwqDCoMKgwqDCoMKgIH07DQo+PiArwqDCoMKgIH07DQo+
PiArfTsNCj4+ICsNCj4+IMKgICZ1YXJ0MCB7DQo+PiDCoMKgwqDCoMKgIHBpbmN0cmwtbmFt
ZXMgPSAiZGVmYXVsdCI7DQo+PiDCoMKgwqDCoMKgIHBpbmN0cmwtMCA9IDwmdWFydDBfMl9j
Zmc+Ow0KPj4NCg==


