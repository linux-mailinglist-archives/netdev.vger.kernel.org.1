Return-Path: <netdev+bounces-225480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FE5B940F9
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 05:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01F7F4E29D1
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 03:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BA4236437;
	Tue, 23 Sep 2025 03:07:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.205.26])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E957E2264BD;
	Tue, 23 Sep 2025 03:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.205.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758596832; cv=none; b=B6QdRwEHCP3U0qllNb0a78G5N8NtEb04cDDn/IXHz37ejZAvlF8Cy10y94RCyLJo/aD8po29Wva3y+RxSUwjpFiww+9fspXtPNKXGEEYLvCceecW6capdi9du7k77rXjFaIEABNDwhF3WqA6ldrp9kjwELLVjWMFlqfvlC7Dcrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758596832; c=relaxed/simple;
	bh=dKjJjUJFFbk7Ak+Tf4z4jgGW1f5LOmkcdWZKxun+c30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=MPlZID1Tq355PQ2KfJ5EadjMQJIlbQRLalNSvOzkA40KQxeDVzANSVL54d+VsfhATEU0FAE614LqaB298K6tTEqx+69NW7evNIGYkXIuNjLEqlLjWK9EHlJGuEmN8H7jT3ka3Q703Ns3mJw/+hfxwwYFKxFi59DtFdo5G+URkSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.229.205.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from weishangjuan$eswincomputing.com ( [10.12.96.155] ) by
 ajax-webmail-app2 (Coremail) ; Tue, 23 Sep 2025 11:06:08 +0800 (GMT+08:00)
Date: Tue, 23 Sep 2025 11:06:08 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6Z+m5bCa5aif?= <weishangjuan@eswincomputing.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, vladimir.oltean@nxp.com,
	yong.liang.choong@linux.intel.com, anthony.l.nguyen@intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, jan.petrous@oss.nxp.com,
	jszhang@kernel.org, inochiama@gmail.com, 0x1207@gmail.com,
	boon.khai.ng@altera.com, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, lizhi2@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v7 2/2] ethernet: eswin: Add eic7700 ethernet driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <aMw-dgNiXgPeqeSz@shell.armlinux.org.uk>
References: <20250918085612.3176-1-weishangjuan@eswincomputing.com>
 <20250918090026.3280-1-weishangjuan@eswincomputing.com>
 <aMw-dgNiXgPeqeSz@shell.armlinux.org.uk>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <30080c70.16e1.199748921d3.Coremail.weishangjuan@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgDHZpWgDtJoo9vXAA--.25976W
X-CM-SenderInfo: pzhl2xxdqjy31dq6v25zlqu0xpsx3x1qjou0bp/1tbiAgEOEGjRel
	QTIgABs6
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkgS2luZywKSSBob3BlIHRoaXMgbWVzc2FnZSBmaW5kcyB5b3Ugd2VsbC4KVGhhbmsgeW91IGZv
ciB5b3VyIHByb2Zlc3Npb25hbCBhbmQgdmFsdWFibGUgc3VnZ2VzdGlvbnMuCk91ciBxdWVzdGlv
bnMgYXJlIGVtYmVkZGVkIGJlbG93IHlvdXIgY29tbWVudHMgaW4gdGhlIG9yaWdpbmFsIGVtYWls
IGJlbG93LgoKQmVzdCByZWdhcmRzLApTaGFuZ2p1YW4gV2VpCgoKPiAtLS0tLeWOn+Wni+mCruS7
ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiUnVzc2VsbCBLaW5nIChPcmFjbGUpIiA8bGludXhAYXJtbGlu
dXgub3JnLnVrPgo+IOWPkemAgeaXtumXtDoyMDI1LTA5LTE5IDAxOjE2OjM4ICjmmJ/mnJ/kupQp
Cj4g5pS25Lu25Lq6OiB3ZWlzaGFuZ2p1YW5AZXN3aW5jb21wdXRpbmcuY29tCj4g5oqE6YCBOiBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZywgYW5kcmV3K25ldGRldkBsdW5uLmNoLCBkYXZlbUBk
YXZlbWxvZnQubmV0LCBlZHVtYXpldEBnb29nbGUuY29tLCBrdWJhQGtlcm5lbC5vcmcsIHJvYmhA
a2VybmVsLm9yZywga3J6aytkdEBrZXJuZWwub3JnLCBjb25vcitkdEBrZXJuZWwub3JnLCBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnLCBwYWJlbmlAcmVkaGF0LmNvbSwgbWNvcXVlbGluLnN0bTMyQGdt
YWlsLmNvbSwgYWxleGFuZHJlLnRvcmd1ZUBmb3NzLnN0LmNvbSwgdmxhZGltaXIub2x0ZWFuQG54
cC5jb20sIHlvbmcubGlhbmcuY2hvb25nQGxpbnV4LmludGVsLmNvbSwgYW50aG9ueS5sLm5ndXll
bkBpbnRlbC5jb20sIHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbSwgamFu
LnBldHJvdXNAb3NzLm54cC5jb20sIGpzemhhbmdAa2VybmVsLm9yZywgaW5vY2hpYW1hQGdtYWls
LmNvbSwgMHgxMjA3QGdtYWlsLmNvbSwgYm9vbi5raGFpLm5nQGFsdGVyYS5jb20sIGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcsIGxpbnV4LXN0bTMyQHN0LW1kLW1haWxtYW4uc3Rvcm1yZXBs
eS5jb20sIGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZywgbmluZ3l1QGVzd2lu
Y29tcHV0aW5nLmNvbSwgbGlubWluQGVzd2luY29tcHV0aW5nLmNvbSwgbGl6aGkyQGVzd2luY29t
cHV0aW5nLmNvbSwgcGlua2VzaC52YWdoZWxhQGVpbmZvY2hpcHMuY29tCj4g5Li76aKYOiBSZTog
W1BBVENIIHY3IDIvMl0gZXRoZXJuZXQ6IGVzd2luOiBBZGQgZWljNzcwMCBldGhlcm5ldCBkcml2
ZXIKPiAKPiBPbiBUaHUsIFNlcCAxOCwgMjAyNSBhdCAwNTowMDoyNlBNICswODAwLCB3ZWlzaGFu
Z2p1YW5AZXN3aW5jb21wdXRpbmcuY29tIHdyb3RlOgo+ID4gKwlwbGF0X2RhdC0+Y2xrX3R4X2kg
PSBzdG1tYWNfcGx0ZnJfZmluZF9jbGsocGxhdF9kYXQsICJ0eCIpOwo+ID4gKwlwbGF0X2RhdC0+
c2V0X2Nsa190eF9yYXRlID0gc3RtbWFjX3NldF9jbGtfdHhfcmF0ZTsKPiA+ICsJcGxhdF9kYXQt
PmJzcF9wcml2ID0gZHdjX3ByaXY7Cj4gPiArCXBsYXRfZGF0LT5jbGtzX2NvbmZpZyA9IGVpYzc3
MDBfY2xrc19jb25maWc7Cj4gPiArCWR3Y19wcml2LT5wbGF0X2RhdCA9IHBsYXRfZGF0Owo+ID4g
Kwo+ID4gKwlyZXQgPSBlaWM3NzAwX2Nsa3NfY29uZmlnKGR3Y19wcml2LCB0cnVlKTsKPiA+ICsJ
aWYgKHJldCkKPiA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKCZwZGV2LT5kZXYsCj4gPiArCQkJ
CXJldCwKPiA+ICsJCQkJImVycm9yIGVuYWJsZSBjbG9ja1xuIik7Cj4gPiArCj4gPiArCXJldCA9
IHN0bW1hY19kdnJfcHJvYmUoJnBkZXYtPmRldiwgcGxhdF9kYXQsICZzdG1tYWNfcmVzKTsKPiA+
ICsJaWYgKHJldCkgewo+ID4gKwkJZWljNzcwMF9jbGtzX2NvbmZpZyhkd2NfcHJpdiwgZmFsc2Up
Owo+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoJnBkZXYtPmRldiwKPiA+ICsJCQkJcmV0LAo+
ID4gKwkJCQkiRmFpbGVkIHRvIGRyaXZlciBwcm9iZVxuIik7Cj4gPiArCX0KPiA+ICsKPiA+ICsJ
cmV0dXJuIHJldDsKPiA+ICt9Cj4gPiArCj4gPiArc3RhdGljIHZvaWQgZWljNzcwMF9kd21hY19y
ZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiA+ICt7Cj4gPiArCXN0cnVjdCBl
aWM3NzAwX3Fvc19wcml2ICpkd2NfcHJpdiA9IGdldF9zdG1tYWNfYnNwX3ByaXYoJnBkZXYtPmRl
dik7Cj4gPiArCj4gPiArCXN0bW1hY19wbHRmcl9yZW1vdmUocGRldik7Cj4gPiArCWVpYzc3MDBf
Y2xrc19jb25maWcoZHdjX3ByaXYsIGZhbHNlKTsKPiAKPiBJdCB3b3VsZCBiZSBuaWNlIHRvIHNl
ZSB0aGUgYWJvdmUgY29kZSBjbGVhbmVkIHVwIGxpa2UgSSBkaWQgZm9yIGFsbAo+IHRoZSBvdGhl
ciBzdG1tYWMgZ2x1ZSBkcml2ZXJzIHJlY2VudGx5Lgo+IAo+IEhvd2V2ZXIsIHRoaXMgaXMgbm90
IHRvIHNheSB0aGlzIHNob3VsZG4ndCBiZSBtZXJnZWQgLSBidXQgcGxlYXNlCj4gY29uc2lkZXIg
dGhpcyBpZiB5b3UgZG8gYW5vdGhlciByZXdvcmsgb2YgdGhlc2UgcGF0Y2hlcywgaWYgbm90IGFz
Cj4gYSBmb2xsb3ctdXAgcGF0Y2guCj4gCj4gRXNzZW50aWFsbHksIHlvdSBjYW4gdXNlIGRldm1f
c3RtbWFjX3BsdGZtX3Byb2JlKCksIHBvcHVsYXRlIHRoZQo+IHBsYXRfZGF0LT5pbml0KCkgYW5k
IHBsYXRfZGF0LT5leGl0KCkgbWV0aG9kcyB0byBjYWxsIHRoZQo+IGNsa3NfY29uZmlnIGZ1bmN0
aW9uLCBidXQgYXMgeW91IGRvbid0IHdhbnQgdGhlc2UgbWV0aG9kcyB0byBiZQo+IGNhbGxlZCBk
dXJpbmcgc3VzcGVuZC9yZXN1bWUgKGJlY2F1c2UgcGxhdF9kYXQtPmNsa3NfY29uZmlnKCkgaXMK
PiBhbHJlYWR5IGNhbGxlZCB0aGVyZSksIHByb3ZpZGUgZW1wdHkgcGxhdF9kYXQtPnN1c3BlbmQo
KSBhbmQKPiBwbGF0X2RhdC0+cmVzdW1lKCkgbWV0aG9kcy4KPiAKPiBCb251cyBwb2ludHMgaWYg
eW91IGluY2x1ZGUgYSBwYXRjaCB3aGljaCBwcm92aWRlcyB0aGlzIGZ1bmN0aW9uYWxpdHkKPiBh
cyBsaWJyYXJ5IGZ1bmN0aW9ucyBpbiBzdG1tYWNfcGxhdGZvcm0uYyB3aGljaCBjYW4gYmUgdXNl
ZCB0bwo+IGluaXRpYWxpc2UgLT5pbml0KCkgYW5kIC0+ZXhpdCgpIGZvciB0aGlzIGJlaGF2aW91
ciwgYW5kIGNoZWNrIG90aGVyCj4gc3RtbWFjIHBsYXRmb3JtIGdsdWUgZHJpdmVycyB0byBzZWUg
aWYgdGhleSB3b3VsZCBiZW5lZml0IGZyb20gdXNpbmcKPiB0aGVzZS4KPiAKCkluIHRoZSBjdXJy
ZW50IGVpYzc3MDBfZHdtYWMgZ2x1ZSBkcml2ZXIsIHRoZSByZWdtYXBfcmVhZCgpL3dyaXRlKCkK
b3BlcmF0aW9ucyhmb3IgcGh5X2N0cmwxLCBheGlfbHBfY3RybDEsIGFuZCB0aGUgUlgvVFggZGVs
YXkgcmVnaXN0ZXJzKSlhcmXCoApwZXJmb3JtZWQgZGlyZWN0bHkgaW4gdGhlIHByb2JlKCkgZnVu
Y3Rpb24uIFdvdWxkIGl0IGJlIGNsZWFuZXIgdG8gbW92ZSB0aGVzZQpyZWdpc3RlciBjb25maWd1
cmF0aW9ucyBpbnRvIHRoZSBpbml0KCkgY2FsbGJhY2sgaW5zdGVhZCwgc28gdGhhdCB0aGV5IGFy
ZQphbHNvIHJlYXBwbGllZCBkdXJpbmcgcmVzdW1lKCk/Cgo+IE9mIGNvdXJzZSwgaXQgd291bGQg
YmUgbmljZSBub3QgdG8gaGF2ZSB0byBnbyB0byB0aGUgZXh0ZW50IG9mCj4gYWRkaW5nIGVtcHR5
IGZ1bmN0aW9ucyBmb3IgLT5zdXNwZW5kKCkgYW5kIC0+cmVzdW1lKCksIGJ1dCBzdG1tYWMgaGFz
Cj4gYSBsb3Qgb2Ygd2VpcmRvIGhpc3RvcnksIGFuZCB0aGVyZSB3YXMgbm8gZWFzeSB3YXkgdG8g
bWFpbnRhaW4KPiBjb21wYXRpYmlsaXR5IHdpdGhvdXQgZG9pbmcgdGhhdCB3aGVuIEkgYWRkZWQg
dGhlc2UgdHdvIG5ldyBtZXRob2RzLgo+IAo+IExhc3RseSwgcGxlYXNlIGNvbnNpZGVyIHVzaW5n
ICJuZXQ6IHN0bW1hYzogPHNob3J0ZW5lZC1nbHVlLW5hbWU+OiBibGFoIgo+IGFzIHRoZSBzdWJq
ZWN0IHNvIHRoZXJlJ3MgYSBjb25zaXN0ZW50IHN0eWxlIGZvciBzdG1tYWMgcGF0Y2hlcy4KPiAK
PiBUaGFua3MuCj4gCj4gLS0gCj4gUk1LJ3MgUGF0Y2ggc3lzdGVtOiBodHRwczovL3d3dy5hcm1s
aW51eC5vcmcudWsvZGV2ZWxvcGVyL3BhdGNoZXMvCj4gRlRUUCBpcyBoZXJlISA4ME1icHMgZG93
biAxME1icHMgdXAuIERlY2VudCBjb25uZWN0aXZpdHkgYXQgbGFzdCEK

