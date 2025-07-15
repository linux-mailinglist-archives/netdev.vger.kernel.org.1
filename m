Return-Path: <netdev+bounces-207054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA98B05788
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 12:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D6356049B
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 10:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AE62D29BF;
	Tue, 15 Jul 2025 10:10:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F03275842;
	Tue, 15 Jul 2025 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574210; cv=none; b=f5hDlEW+sCi0tH0d/Fbiu+Ddb+nhP5yoFE0PgFHPEA8UjaMLHdK/+g1rJkWdmZvmPFR1Gwpj4qn458J1pJtSSEA9vmUqTgrFv1xd/eXfu6NA+UkPIQNtFDFkkwrHYLlxTMsEch4UGFQ4AXYffGjCA+5jC1DCKZViLfEtZW7q4Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574210; c=relaxed/simple;
	bh=bun7DXgfrzihoQdy+CxHxRyUuSdCirsltCFXqR+nYyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=GyRQXzSOvN5XaISS6Skvn2ZmU0CG86bS3ydsSm495y+BZuXhcM+Y1WoyM6YzF5lZkJGVEmLoKYjTz6yQApstsz5GfbYoc02ZfZh4g1PeM3npqaP7fBesyo9gQXuP5sgHfW68qHEh83uUxMFsuUldPWEEZuV4TlFvPgFEK/h2d5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Tue, 15 Jul 2025 18:09:35 +0800 (GMT+08:00)
Date: Tue, 15 Jul 2025 18:09:35 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
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
Subject: Re: Re: [PATCH v3 2/2] ethernet: eswin: Add eic7700 ethernet driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <1b975a3e-ae1c-4354-90db-1f8d7ff567d3@kernel.org>
References: <20250528041455.878-1-weishangjuan@eswincomputing.com>
 <20250528041634.912-1-weishangjuan@eswincomputing.com>
 <1b975a3e-ae1c-4354-90db-1f8d7ff567d3@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2e8343eb.34d0.1980d8fa817.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TAJkCgA3WxHfKHZon0WwAA--.12412W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAQEEDGh1MO8oigAAso
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

RGVhcsKgS3J6eXN6dG9mIEtvemxvd3NraSwKClRoYW5rIHlvdSBmb3IgeW91ciBwcm9mZXNzaW9u
YWwgYW5kIHZhbHVhYmxlIHN1Z2dlc3Rpb25zLgpPdXIgcXVlc3Rpb24gaXMgZW1iZWRkZWQgYmVs
b3cgeW91ciBjb21tZW50LgoKQmVzdCByZWdhcmRzLAoKCkxpIFpoaQpFc3dpbiBDb21wdXRpbmcK
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAyLzJdIGV0aGVybmV0OiBlc3dpbjogQWRkIGVpYzc3
MDAgZXRoZXJuZXQgZHJpdmVyCj4gRGF0ZTogVGh1LCAzIEp1bCAyMDI1IDExOjUzOjMzICswMjAw
CVt0aHJlYWQgb3ZlcnZpZXddCj4gTWVzc2FnZS1JRDogPGYwOTZhZmExLTI2MGUtNGY4Yy04NTk1
LTNiNDE0MjViMjk2NEBrZXJuZWwub3JnPiAocmF3KQo+IEluLVJlcGx5LVRvOiA8MjAyNTA3MDMw
OTIwMTUuMTIwMC0xLXdlaXNoYW5nanVhbkBlc3dpbmNvbXB1dGluZy5jb20+Cj4gT24gMDMvMDcv
MjAyNSAxMToyMCwgd2Vpc2hhbmdqdWFuQGVzd2luY29tcHV0aW5nLmNvbSB3cm90ZToKPiA+ICsJ
cmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91MzJfaW5kZXgocGRldi0+ZGV2Lm9mX25vZGUsICJlc3dp
bixzeXNjcmdfY3NyIiwgMSwKPiA+ICsJCQkJCSAmaHNwX2FjbGtfY3RybF9vZmZzZXQpOwo+ID4g
KwlpZiAocmV0KQo+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoJnBkZXYtPmRldiwgcmV0LCAi
Y2FuJ3QgZ2V0IGhzcF9hY2xrX2N0cmxfb2Zmc2V0XG4iKTsKPiA+ICsKPiA+ICsJcmVnbWFwX3Jl
YWQoZHdjX3ByaXYtPmNyZ19yZWdtYXAsIGhzcF9hY2xrX2N0cmxfb2Zmc2V0LCAmaHNwX2FjbGtf
Y3RybF9yZWdzZXQpOwo+ID4gKwloc3BfYWNsa19jdHJsX3JlZ3NldCB8PSAoRUlDNzcwMF9IU1Bf
QUNMS19DTEtFTiB8IEVJQzc3MDBfSFNQX0FDTEtfRElWU09SKTsKPiA+ICsJcmVnbWFwX3dyaXRl
KGR3Y19wcml2LT5jcmdfcmVnbWFwLCBoc3BfYWNsa19jdHJsX29mZnNldCwgaHNwX2FjbGtfY3Ry
bF9yZWdzZXQpOwo+ID4gKwo+ID4gPiArCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyX2luZGV4
KHBkZXYtPmRldi5vZl9ub2RlLCAiZXN3aW4sc3lzY3JnX2NzciIsIDIsCj4gPiArCQkJCQkgJmhz
cF9jZmdfY3RybF9vZmZzZXQpOwo+ID4gKwlpZiAocmV0KQo+ID4gKwkJcmV0dXJuIGRldl9lcnJf
cHJvYmUoJnBkZXYtPmRldiwgcmV0LCAiY2FuJ3QgZ2V0IGhzcF9jZmdfY3RybF9vZmZzZXRcbiIp
Owo+ID4gKwo+ID4gKwlyZWdtYXBfd3JpdGUoZHdjX3ByaXYtPmNyZ19yZWdtYXAsIGhzcF9jZmdf
Y3RybF9vZmZzZXQsIEVJQzc3MDBfSFNQX0NGR19DVFJMX1JFR1NFVCk7Cj4gPiArCj4gPiArCWR3
Y19wcml2LT5oc3BfcmVnbWFwID0gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfcGhhbmRsZShwZGV2
LT5kZXYub2Zfbm9kZSwKPiA+ICsJCQkJCQkJICAgICAgICJlc3dpbixoc3Bfc3BfY3NyIik7Cj4g
Cj4gVGhlcmUgaXMgbm8gc3VjaCBwcm9wZXJ0eS4gSSBhbHJlYWR5IHNhaWQgYXQgdjIgeW91IGNh
bm5vdCBoYXZlCj4gdW5kb2N1bWVudGVkIEFCSS4KPiAKClRoZSBwcm9wZXJ0aWVzIGluIHRoZSBZ
QU1MIGZpbGUgdXNlIGRhc2hlcywgd2hpbGUgdGhlIGRyaXZlciB1c2VzIHVuZGVyc2NvcmVzLCBy
ZXN1bHRpbmcgaW4gYW4gaW5jb25zaXN0ZW5jeS4gVGhpcyB3aWxsIGJlIGNvcnJlY3RlZCBpbiB0
aGUgbmV4dCBwYXRjaC4gSXMgdGhpcyBjb3JyZWN0PwoKPiA+ICsJaWYgKElTX0VSUihkd2NfcHJp
di0+aHNwX3JlZ21hcCkpCj4gPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZSgmcGRldi0+ZGV2LCBQ
VFJfRVJSKGR3Y19wcml2LT5oc3BfcmVnbWFwKSwKPiA+ICsJCQkJIkZhaWxlZCB0byBnZXQgaHNw
X3NwX2NzciByZWdtYXBcbiIpOwo+ID4gKwo+ID4gKwlyZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3Uz
Ml9pbmRleChwZGV2LT5kZXYub2Zfbm9kZSwgImVzd2luLGhzcF9zcF9jc3IiLCAyLAo+IAo+IE5B
Swo+IAo+ID4gKwkJCQkJICZldGhfcGh5X2N0cmxfb2Zmc2V0KTsKPiA+ICsJaWYgKHJldCkKPiA+
ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKCZwZGV2LT5kZXYsIHJldCwgImNhbid0IGdldCBldGhf
cGh5X2N0cmxfb2Zmc2V0XG4iKTsKPiA+ICsKPiA+ICsJcmVnbWFwX3JlYWQoZHdjX3ByaXYtPmhz
cF9yZWdtYXAsIGV0aF9waHlfY3RybF9vZmZzZXQsICZldGhfcGh5X2N0cmxfcmVnc2V0KTsKPiA+
ICsJZXRoX3BoeV9jdHJsX3JlZ3NldCB8PSAoRUlDNzcwMF9FVEhfVFhfQ0xLX1NFTCB8IEVJQzc3
MDBfRVRIX1BIWV9JTlRGX1NFTEkpOwo+ID4gKwlyZWdtYXBfd3JpdGUoZHdjX3ByaXYtPmhzcF9y
ZWdtYXAsIGV0aF9waHlfY3RybF9vZmZzZXQsIGV0aF9waHlfY3RybF9yZWdzZXQpOwo+ID4gKwo+
ID4gKwlyZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMl9pbmRleChwZGV2LT5kZXYub2Zfbm9kZSwg
ImVzd2luLGhzcF9zcF9jc3IiLCAzLAo+ID4gKwkJCQkJICZldGhfYXhpX2xwX2N0cmxfb2Zmc2V0
KTsKPiA+ICsJaWYgKHJldCkKPiA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKCZwZGV2LT5kZXYs
IHJldCwgImNhbid0IGdldCBldGhfYXhpX2xwX2N0cmxfb2Zmc2V0XG4iKTsKPiA+ICsKPiA+ICsJ
cmVnbWFwX3dyaXRlKGR3Y19wcml2LT5oc3BfcmVnbWFwLCBldGhfYXhpX2xwX2N0cmxfb2Zmc2V0
LCBFSUM3NzAwX0VUSF9DU1lTUkVRX1ZBTCk7Cj4gPiArCj4gPiArCXBsYXRfZGF0LT5jbGtfdHhf
aSA9IGRldm1fY2xrX2dldF9lbmFibGVkKCZwZGV2LT5kZXYsICJ0eCIpOwo+ID4gKwlpZiAoSVNf
RVJSKHBsYXRfZGF0LT5jbGtfdHhfaSkpCj4gPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZSgmcGRl
di0+ZGV2LCBQVFJfRVJSKHBsYXRfZGF0LT5jbGtfdHhfaSksCj4gPiArCQkJCSJlcnJvciBnZXR0
aW5nIHR4IGNsb2NrXG4iKTsKPiA+ICsKPiA+ICsJcGxhdF9kYXQtPmZpeF9tYWNfc3BlZWQgPSBl
aWM3NzAwX3Fvc19maXhfc3BlZWQ7Cj4gPiArCXBsYXRfZGF0LT5zZXRfY2xrX3R4X3JhdGUgPSBz
dG1tYWNfc2V0X2Nsa190eF9yYXRlOwo+ID4gKwlwbGF0X2RhdC0+YnNwX3ByaXYgPSBkd2NfcHJp
djsKPiA+ICsKPiA+ICsJcmV0ID0gc3RtbWFjX2R2cl9wcm9iZSgmcGRldi0+ZGV2LCBwbGF0X2Rh
dCwgJnN0bW1hY19yZXMpOwo+ID4gKwlpZiAocmV0KQo+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJv
YmUoJnBkZXYtPmRldiwgcmV0LCAiRmFpbGVkIHRvIGRyaXZlciBwcm9iZVxuIik7Cj4gPiArCj4g
PiArCXJldHVybiByZXQ7Cj4gPiArfQo+ID4gKwo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkIGVpYzc3MDBfZHdtYWNfbWF0Y2hbXSA9IHsKPiA+ICsJeyAuY29tcGF0aWJsZSA9
ICJlc3dpbixlaWM3NzAwLXFvcy1ldGgiIH0sCj4gPiArCXsgfQo+ID4gK307Cj4gPiArTU9EVUxF
X0RFVklDRV9UQUJMRShvZiwgZWljNzcwMF9kd21hY19tYXRjaCk7Cj4gPiArCj4gPiArc3RhdGlj
IHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgZWljNzcwMF9kd21hY19kcml2ZXIgPSB7Cj4gKwkucHJv
YmUgID0gZWljNzcwMF9kd21hY19wcm9iZSwKPiArCS5yZW1vdmUgPSBzdG1tYWNfcGx0ZnJfcmVt
b3ZlLAo+ICsJLmRyaXZlciA9IHsKPiArCQkubmFtZSAgICAgICAgICAgPSAiZWljNzcwMC1ldGgt
ZHdtYWMiLAo+ICsJCS5wbSAgICAgICAgICAgICA9ICZzdG1tYWNfcGx0ZnJfcG1fb3BzLAo+ICsJ
CS5vZl9tYXRjaF90YWJsZSA9IGVpYzc3MDBfZHdtYWNfbWF0Y2gsCj4gKwl9LAo+ICt9Owo+ICtt
b2R1bGVfcGxhdGZvcm1fZHJpdmVyKGVpYzc3MDBfZHdtYWNfZHJpdmVyKTsKPiArCj4gK01PRFVM
RV9BVVRIT1IoIkVzd2luIik7Cj4gCj4gRHJvcCwgdGhhdCdzIG5vdCBhIHBlcnNvbi4KPiAKPiAK
PiBCZXN0IHJlZ2FyZHMsCj4gS3J6eXN6dG9mCg==

