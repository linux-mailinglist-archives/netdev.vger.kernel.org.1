Return-Path: <netdev+bounces-220710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CF1B48498
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 08:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61E517974F
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 06:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D692E2DD4;
	Mon,  8 Sep 2025 06:56:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3002E1746;
	Mon,  8 Sep 2025 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314610; cv=none; b=ld8jJ4dbJvmfMzcZtLqn0Z+fagwBrUC1RKj0mVW/W7DdM+2PiOEZ4NMnj+JaScchw4aJ8e8Vb1YnPfI4DbZ3NnnwdqSaUYrmloklYN7xCKVOyFHKeRBW9r5dvrAXX1ZsSaRZ0L/AAc+iZ+lBLnk25Xp2dk2vr9N7kOqxkwkhoRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314610; c=relaxed/simple;
	bh=IbSA8NDCnusHdgd1dttsll2/WAB1xmi3fNprMtwEA2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=tM8vffpICUZswb+cRxQQFP4BW7Of13ngwZ+KEMnb7mwAuL3UBqu3CaBt6/ghHZVdX1G8uWQE3AB4kYnv2d8bmETG+qZi7pAj2ifM+p9i5uMk9bcwbqLJMOXUXAHTVAaOukxnTt3yhNtTHlfw+yhINBrvrRFyrRIid9qG9PG0lc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Mon, 8 Sep 2025 14:55:55 +0800 (GMT+08:00)
Date: Mon, 8 Sep 2025 14:55:55 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: weishangjuan@eswincomputing.com, devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, yong.liang.choong@linux.intel.com,
	vladimir.oltean@nxp.com, faizal.abdul.rahim@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, inochiama@gmail.com,
	jan.petrous@oss.nxp.com, jszhang@kernel.org, p.zabel@pengutronix.de,
	boon.khai.ng@altera.com, 0x1207@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	emil.renner.berthing@canonical.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v5 2/2] ethernet: eswin: Add eic7700 ethernet driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <aLlpUOr3IJzTuV1g@shell.armlinux.org.uk>
References: <20250904085913.2494-1-weishangjuan@eswincomputing.com>
 <20250904090125.2598-1-weishangjuan@eswincomputing.com>
 <aLlpUOr3IJzTuV1g@shell.armlinux.org.uk>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <a05a5e6.1188.199281c1df8.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TAJkCgA3WxH7fb5oznPLAA--.15808W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAQETDGi9s3cdZgABs0
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

RGVhciBSdXNzZWxsIEtpbmcsClRoYW5rIHlvdSBmb3IgeW91ciB2YWx1YWJsZSBhbmQgcHJvZmVz
c2lvbmFsIHN1Z2dlc3Rpb25zLgoKWW91J3JlIHJpZ2h0IOKAlCB0eF9kZWxheV9wcywgcnhfZGVs
YXlfcHMgYW5kIGhzcF9yZWdtYXAgYXJlCm9ubHkgdXNlZCBpbiBwcm9iZSwgc28gd2XigJlsbCBz
d2l0Y2ggdGhlbSB0byBsb2NhbCB2YXJpYWJsZXMuCldl4oCZbGwgYWxzbyBpbmxpbmUgdGhlIGRl
bGF5IGhhbmRsaW5nIGludG8gcHJvYmUgYXMgc3VnZ2VzdGVkLgpUaGlzIHdpbGwgYmUgdXBkYXRl
ZCBpbiB0aGUgbmV4dCB2ZXJzaW9uLgoKQmVzdCByZWdhcmRzLAoKTGkgWmhpCkVzd2luIENvbXB1
dGluZwo+IC0tLS0t5Y6f5aeL6YKu5Lu2LS0tLS0KPiDlj5Hku7bkuro6ICJSdXNzZWxsIEtpbmcg
KE9yYWNsZSkiIDxsaW51eEBhcm1saW51eC5vcmcudWs+Cj4g5Y+R6YCB5pe26Ze0OjIwMjUtMDkt
MDQgMTg6MjY6MjQgKOaYn+acn+WbmykKPiDmlLbku7bkuro6IHdlaXNoYW5nanVhbkBlc3dpbmNv
bXB1dGluZy5jb20KPiDmioTpgIE6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnLCBhbmRyZXcr
bmV0ZGV2QGx1bm4uY2gsIGRhdmVtQGRhdmVtbG9mdC5uZXQsIGVkdW1hemV0QGdvb2dsZS5jb20s
IGt1YmFAa2VybmVsLm9yZywgcGFiZW5pQHJlZGhhdC5jb20sIHJvYmhAa2VybmVsLm9yZywga3J6
aytkdEBrZXJuZWwub3JnLCBjb25vcitkdEBrZXJuZWwub3JnLCBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcsIG1jb3F1ZWxpbi5zdG0zMkBnbWFpbC5jb20sIGFsZXhhbmRyZS50
b3JndWVAZm9zcy5zdC5jb20sIHlvbmcubGlhbmcuY2hvb25nQGxpbnV4LmludGVsLmNvbSwgdmxh
ZGltaXIub2x0ZWFuQG54cC5jb20sIGZhaXphbC5hYmR1bC5yYWhpbUBsaW51eC5pbnRlbC5jb20s
IHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbSwgaW5vY2hpYW1hQGdtYWls
LmNvbSwgamFuLnBldHJvdXNAb3NzLm54cC5jb20sIGpzemhhbmdAa2VybmVsLm9yZywgcC56YWJl
bEBwZW5ndXRyb25peC5kZSwgYm9vbi5raGFpLm5nQGFsdGVyYS5jb20sIDB4MTIwN0BnbWFpbC5j
b20sIG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcs
IGxpbnV4LXN0bTMyQHN0LW1kLW1haWxtYW4uc3Rvcm1yZXBseS5jb20sIGVtaWwucmVubmVyLmJl
cnRoaW5nQGNhbm9uaWNhbC5jb20sIG5pbmd5dUBlc3dpbmNvbXB1dGluZy5jb20sIGxpbm1pbkBl
c3dpbmNvbXB1dGluZy5jb20sIGxpemhpMkBlc3dpbmNvbXB1dGluZy5jb20sIHBpbmtlc2gudmFn
aGVsYUBlaW5mb2NoaXBzLmNvbQo+IOS4u+mimDogUmU6IFtQQVRDSCB2NSAyLzJdIGV0aGVybmV0
OiBlc3dpbjogQWRkIGVpYzc3MDAgZXRoZXJuZXQgZHJpdmVyCj4gCj4gT24gVGh1LCBTZXAgMDQs
IDIwMjUgYXQgMDU6MDE6MjVQTSArMDgwMCwgd2Vpc2hhbmdqdWFuQGVzd2luY29tcHV0aW5nLmNv
bSB3cm90ZToKPiA+ICtzdHJ1Y3QgZWljNzcwMF9xb3NfcHJpdiB7Cj4gPiArCXN0cnVjdCBwbGF0
X3N0bW1hY2VuZXRfZGF0YSAqcGxhdF9kYXQ7Cj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldjsKPiA+
ICsJc3RydWN0IHJlZ21hcCAqaHNwX3JlZ21hcDsKPiA+ICsJdTMyIHR4X2RlbGF5X3BzOwo+ID4g
Kwl1MzIgcnhfZGVsYXlfcHM7Cj4gPiArfTsKPiA+ICsKPiA+ICsvKioKPiA+ICsgKiBlaWM3NzAw
X2FwcGx5X2RlbGF5IC0gQXBwbHkgVFggb3IgUlggZGVsYXkgdG8gYSByZWdpc3RlciB2YWx1ZS4K
PiA+ICsgKiBAZGVsYXlfcHM6IERlbGF5IGluIHBpY29zZWNvbmRzLCBjb252ZXJ0ZWQgdG8gMC4x
bnMgdW5pdHMuCj4gPiArICogQHJlZzogICAgICBQb2ludGVyIHRvIHJlZ2lzdGVyIHZhbHVlIHRv
IHVwZGF0ZSBpbi1wbGFjZS4KPiA+ICsgKiBAaXNfcng6ICAgIFRydWUgZm9yIFJYIGRlbGF5IChi
aXRzIDMwOjI0KSwgZmFsc2UgZm9yIFRYIGRlbGF5IChiaXRzIDE0OjgpLgo+ID4gKyAqCj4gPiAr
ICogQ29udmVydHMgZGVsYXkgZnJvbSBwcyB0byAwLjFucyB1bml0cywgY2FwcGVkIGJ5IEVJQzc3
MDBfTUFYX0RFTEFZX1VOSVQuCj4gPiArICogVXBkYXRlcyBvbmx5IHRoZSBSWCBvciBUWCBkZWxh
eSBmaWVsZCAodXNpbmcgRklFTERfUFJFUCksIGxlYXZpbmcgYWxsCj4gPiArICogb3RoZXIgYml0
cyBpbiAqQHJlZyB1bmNoYW5nZWQuCj4gPiArICovCj4gPiArc3RhdGljIHZvaWQgZWljNzcwMF9h
cHBseV9kZWxheSh1MzIgZGVsYXlfcHMsIHUzMiAqcmVnLCBib29sIGlzX3J4KQo+ID4gK3sKPiA+
ICsJdTMyIHZhbCA9IG1pbihkZWxheV9wcyAvIDEwMCwgRUlDNzcwMF9NQVhfREVMQVlfVU5JVCk7
Cj4gPiArCj4gPiArCWlmIChpc19yeCkgewo+ID4gKwkJKnJlZyAmPSB+RUlDNzcwMF9FVEhfUlhf
QURKX0RFTEFZOwo+ID4gKwkJKnJlZyB8PSBGSUVMRF9QUkVQKEVJQzc3MDBfRVRIX1JYX0FESl9E
RUxBWSwgdmFsKTsKPiA+ICsJfSBlbHNlIHsKPiA+ICsJCSpyZWcgJj0gfkVJQzc3MDBfRVRIX1RY
X0FESl9ERUxBWTsKPiA+ICsJCSpyZWcgfD0gRklFTERfUFJFUChFSUM3NzAwX0VUSF9UWF9BREpf
REVMQVksIHZhbCk7Cj4gPiArCX0KPiA+ICt9Cj4gCj4gLi4uCj4gCj4gPiArCS8qIFJlYWQgcngt
aW50ZXJuYWwtZGVsYXktcHMgYW5kIHVwZGF0ZSByeF9jbGsgZGVsYXkgKi8KPiA+ICsJaWYgKCFv
Zl9wcm9wZXJ0eV9yZWFkX3UzMihwZGV2LT5kZXYub2Zfbm9kZSwKPiA+ICsJCQkJICAicngtaW50
ZXJuYWwtZGVsYXktcHMiLAo+ID4gKwkJCQkgICZkd2NfcHJpdi0+cnhfZGVsYXlfcHMpKSB7Cj4g
PiArCQllaWM3NzAwX2FwcGx5X2RlbGF5KGR3Y19wcml2LT5yeF9kZWxheV9wcywKPiA+ICsJCQkJ
ICAgICZldGhfZGx5X3BhcmFtLCB0cnVlKTsKPiAKPiBJJ3ZlIGJlZW4gdHJ5aW5nIHRvIGZpZ3Vy
ZSBvdXQgdGhlIHJlYXNvbmluZyBiZWhpbmQgdGhlIGZvbGxvd2luZzoKPiAKPiAxLiB0aGUgcHJl
c2VuY2Ugb2YgZHdjX3ByaXYtPnJ4X2RlbGF5X3BzIGFuZCBkd2NfcHJpdi0+dHhfZGVsYXlfcHMK
PiAgICByYXRoZXIgdGhhbiBqdXN0IHVzaW5nIGEgbG9jYWwgdmFyaWFibGUgKCJkZWxheSIgPykK
PiAyLiB0aGUgcHJlc2VuY2Ugb2YgZWljNzcwMF9hcHBseV9kZWxheSgpIHdoZW4gd2UgaGF2ZSB0
byBkbyBzb21ldGhpbmcKPiAgICBkaWZmZXJlbnQgdG8gZ2V0IHRoZSBkZWxheSB2YWx1ZSBhbnl3
YXkKPiAKPiBJdCBzZWVtcyB0byBtZSB0aGF0IHRoaXMgc2hvdWxkIGVpdGhlciBiZToKPiAKPiBz
dGF0aWMgdm9pZCBlaWM3NzAwX3BhcnNlX2RlbGF5KHUzMiAqcmVnLCBzdHJ1Y3QgZGV2aWNlICpk
ZXYsCj4gCQkJCWNvbnN0IGNoYXIgKm5hbWUsIGJvb2wgaXNfcngpCj4gewo+IAl1MzIgZGVsYXk7
Cj4gCj4gCWlmIChvZl9wcm9wZXJ0eV9yZWFkX3UzMihkZXYtPm9mX25vZGUsIG5hbWUsICZkZWxh
eSkpIHsKPiAJCWRldl93YXJuKGRldiwgImNhbid0IGdldCAlc1xuIiwgbmFtZSk7Cj4gCQlyZXR1
cm4KPiAJfQo+IAo+IAlpZiAoaXNfcngpIHsKPiAJCSpyZWcgJj0gfkVJQzc3MDBfRVRIX1JYX0FE
Sl9ERUxBWTsKPiAJCSpyZWcgfD0gRklFTERfUFJFUChFSUM3NzAwX0VUSF9SWF9BREpfREVMQVks
IGRlbGF5KTsKPiAJfSBlbHNlIHsKPiAJCSpyZWcgJj0gfkVJQzc3MDBfRVRIX1RYX0FESl9ERUxB
WTsKPiAJCSpyZWcgfD0gRklFTERfUFJFUChFSUM3NzAwX0VUSF9UWF9BREpfREVMQVksIGRlbGF5
KTsKPiAJfQo+IH0KPiAKPiBvciBqdXN0IG5vdCBib3RoZXIgd2l0aCB0aGUgZnVuY3Rpb24gYXQg
YWxsIGFuZCBqdXN0IHdyaXRlIGl0IG91dAo+IGZ1bGx5IGluIHRoZSBwcm9iZSBmdW5jdGlvbi4K
PiAKPiBUaGFua3MuCj4gCj4gLS0gCj4gUk1LJ3MgUGF0Y2ggc3lzdGVtOiBodHRwczovL3d3dy5h
cm1saW51eC5vcmcudWsvZGV2ZWxvcGVyL3BhdGNoZXMvCj4gRlRUUCBpcyBoZXJlISA4ME1icHMg
ZG93biAxME1icHMgdXAuIERlY2VudCBjb25uZWN0aXZpdHkgYXQgbGFzdCEK

