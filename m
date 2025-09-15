Return-Path: <netdev+bounces-222970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAC1B5753C
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 11:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C9A16C064
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 09:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699DF2F3628;
	Mon, 15 Sep 2025 09:50:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961EB1DE4F6;
	Mon, 15 Sep 2025 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757929844; cv=none; b=NPzZSPhm8q8aLDSeshOVCr8pmyXH5ycdIpGPTlotkzlvlzjLCFQ/NWqbuOAwvkB7mFwd8eECFQPAXuoNK702UnxEm28YQCz5fvLxSVCB1zsPL11MfsLaCnJT73MxBuv+YpYiiBrTEcmp52C9NjdDwc3oeDUNywWZasLZOOhJL7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757929844; c=relaxed/simple;
	bh=H43jQh2/OR4og+peubxGV8dFkGR0ES1D/EW+GQmVya0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=AQ+NGv726bZgTuVZ3pF/RvYm3UqGNxxVBvCZ99pM0zns+UKHlRteRTx0LSOSQ8R2do8tGg4bhNVfz1tOkce/WTuVJvc67cf2A5gy6T3/goQxoKkPnxtRKlf7BBenNAqf6mA64pJ0LWCnFLP97qmMdz6KdR88Oa08H1S/7KIexgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from weishangjuan$eswincomputing.com ( [10.12.96.155] ) by
 ajax-webmail-app2 (Coremail) ; Mon, 15 Sep 2025 17:50:01 +0800 (GMT+08:00)
Date: Mon, 15 Sep 2025 17:50:01 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6Z+m5bCa5aif?= <weishangjuan@eswincomputing.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, yong.liang.choong@linux.intel.com,
	vladimir.oltean@nxp.com, rmk+kernel@armlinux.org.uk,
	faizal.abdul.rahim@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, inochiama@gmail.com,
	jan.petrous@oss.nxp.com, jszhang@kernel.org, p.zabel@pengutronix.de,
	boon.khai.ng@altera.com, 0x1207@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	emil.renner.berthing@canonical.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, lizhi2@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v6 1/2] dt-bindings: ethernet: eswin: Document for
 EIC7700 SoC
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <50496bf2-1d10-4d89-addb-f4fe774497d9@kernel.org>
References: <20250912055352.2832-1-weishangjuan@eswincomputing.com>
 <20250912055612.2884-1-weishangjuan@eswincomputing.com>
 <50496bf2-1d10-4d89-addb-f4fe774497d9@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <45afe6bc.1302.1994cc80846.Coremail.weishangjuan@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgA31pRJ4cdoWlTRAA--.24971W
X-CM-SenderInfo: pzhl2xxdqjy31dq6v25zlqu0xpsx3x1qjou0bp/1tbiAQEGEGjG7f
	gnDAACsE
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

RGVhciBLcnp5c3p0b2YgS296bG93c2tpLAoKSSBhbSB3cml0aW5nIHRvIHNpbmNlcmVseSBhcG9s
b2dpemUgZm9yIG9taXR0aW5nIHlvdXIgIlJldmlld2VkLWJ5IiB0YWcKaW4gdGhlIHY2IHBhdGNo
IHNlcmllcyB3aXRob3V0IHByb3ZpZGluZyBhbiBleHBsYW5hdGlvbi4gVGhpcyB3YXMgYW4gb3Zl
cnNpZ2h0Cm9uIG15IHBhcnQsIGFuZCBJIHRydWx5IHJlZ3JldCBhbnkgaW5jb252ZW5pZW5jZSBv
ciBmcnVzdHJhdGlvbiBpdCBoYXMgY2F1c2VkLgoKVGhlIHJlYXNvbiB3aHkgSSBkaWRuJ3QgYWRk
IHRhZ3MgaXMgdGhhdCBJIG1hZGUgbW9kaWZpY2F0aW9ucyB0byB0aGUgZGVzY3JpcHRpb24KaW4g
dGhlIFlBTUwgZmlsZS4gRHVlIHRvIHRoZXNlIGNoYW5nZXMgdGhhdCBhbHRlciB0aGUgY29udGVu
dCB5b3UgaGF2ZSBwcmV2aW91c2x5CnZpZXdlZCwgSSBiZWxpZXZlIHRoZXNlIG1vZGlmaWNhdGlv
bnMgbWF5IHJlcXVpcmUgYSByZSBleGFtaW5hdGlvbiBhbmQgdGhlcmVmb3JlCnNob3VsZCBub3Qg
YmUgcmV0YWluZWQgd2l0aG91dCB5b3VyIGNvbmZpcm1hdGlvbi4KCkkgdW5kZXJzdGFuZCB0aGF0
IHdoZW4gc3VibWl0dGluZyB0aGUgcGF0Y2gsIEkgc2hvdWxkIGNsZWFybHkgc3RhdGUgdGhlIHJl
YXNvbi4KSSBoYXZlIGNhcmVmdWxseSByZWFkIHRoZSBzdWJtaXNzaW9uIGd1aWRlbGluZXMgYW5k
IHdpbGwgZW5zdXJlIGZ1bGwgY29tcGxpYW5jZQp3aXRoIHRoZSBwcm9jZXNzIGluIGFsbCBmdXR1
cmUgY29udHJpYnV0aW9ucywgaW5jbHVkaW5nIHByb3BlciB1c2Ugb2YgYjQgYW5kIGNsZWFyCmNv
bW11bmljYXRpb24gb2YgY2hhbmdlcy4KClRoYW5rIHlvdSBmb3IgeW91ciBwYXRpZW5jZSBhbmQg
Z3VpZGFuY2UuCgpCZXN0IHJlZ2FyZHMsClNoYW5nanVhbiBXZWkKCgo+IC0tLS0t5Y6f5aeL6YKu
5Lu2LS0tLS0KPiDlj5Hku7bkuro6ICJLcnp5c3p0b2YgS296bG93c2tpIiA8a3J6a0BrZXJuZWwu
b3JnPgo+IOWPkemAgeaXtumXtDoyMDI1LTA5LTEyIDIxOjE0OjI0ICjmmJ/mnJ/kupQpCj4g5pS2
5Lu25Lq6OiB3ZWlzaGFuZ2p1YW5AZXN3aW5jb21wdXRpbmcuY29tLCBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZywgYW5kcmV3K25ldGRldkBsdW5uLmNoLCBkYXZlbUBkYXZlbWxvZnQubmV0LCBl
ZHVtYXpldEBnb29nbGUuY29tLCBrdWJhQGtlcm5lbC5vcmcsIHBhYmVuaUByZWRoYXQuY29tLCBy
b2JoQGtlcm5lbC5vcmcsIGtyemsrZHRAa2VybmVsLm9yZywgY29ub3IrZHRAa2VybmVsLm9yZywg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnLCBtY29xdWVsaW4uc3RtMzJAZ21h
aWwuY29tLCBhbGV4YW5kcmUudG9yZ3VlQGZvc3Muc3QuY29tLCB5b25nLmxpYW5nLmNob29uZ0Bs
aW51eC5pbnRlbC5jb20sIHZsYWRpbWlyLm9sdGVhbkBueHAuY29tLCBybWsra2VybmVsQGFybWxp
bnV4Lm9yZy51aywgZmFpemFsLmFiZHVsLnJhaGltQGxpbnV4LmludGVsLmNvbSwgcHJhYmhha2Fy
Lm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tLCBpbm9jaGlhbWFAZ21haWwuY29tLCBqYW4u
cGV0cm91c0Bvc3MubnhwLmNvbSwganN6aGFuZ0BrZXJuZWwub3JnLCBwLnphYmVsQHBlbmd1dHJv
bml4LmRlLCBib29uLmtoYWkubmdAYWx0ZXJhLmNvbSwgMHgxMjA3QGdtYWlsLmNvbSwgbmV0ZGV2
QHZnZXIua2VybmVsLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywgbGludXgtc3Rt
MzJAc3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbSwgZW1pbC5yZW5uZXIuYmVydGhpbmdAY2Fu
b25pY2FsLmNvbQo+IOaKhOmAgTogbmluZ3l1QGVzd2luY29tcHV0aW5nLmNvbSwgbGlubWluQGVz
d2luY29tcHV0aW5nLmNvbSwgbGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbSwgcGlua2VzaC52YWdo
ZWxhQGVpbmZvY2hpcHMuY29tCj4g5Li76aKYOiBSZTogW1BBVENIIHY2IDEvMl0gZHQtYmluZGlu
Z3M6IGV0aGVybmV0OiBlc3dpbjogRG9jdW1lbnQgZm9yIEVJQzc3MDAgU29DCj4gCj4gT24gMTIv
MDkvMjAyNSAwNzo1Niwgd2Vpc2hhbmdqdWFuQGVzd2luY29tcHV0aW5nLmNvbSB3cm90ZToKPiA+
IEZyb206IFNoYW5nanVhbiBXZWkgPHdlaXNoYW5nanVhbkBlc3dpbmNvbXB1dGluZy5jb20+Cj4g
PiAKPiA+IEFkZCBFU1dJTiBFSUM3NzAwIEV0aGVybmV0IGNvbnRyb2xsZXIsIHN1cHBvcnRpbmcg
Y2xvY2sKPiA+IGNvbmZpZ3VyYXRpb24sIGRlbGF5IGFkanVzdG1lbnQgYW5kIHNwZWVkIGFkYXB0
aXZlIGZ1bmN0aW9ucy4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogWmhpIExpIDxsaXpoaTJAZXN3
aW5jb21wdXRpbmcuY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogU2hhbmdqdWFuIFdlaSA8d2Vpc2hh
bmdqdWFuQGVzd2luY29tcHV0aW5nLmNvbT4KPiAKPiBUaGVyZSBpcyBubyBleHBsYW5hdGlvbiBv
ZiBkcm9wcGluZyB0aGUgdGFnLiBQbGVhc2UgcmVhZCBDQVJFRlVMTFkKPiBzdWJtaXR0aW5nIHBh
dGNoZXMuCj4gCj4gQ29tcGFyaW5nIGFsc28gZmFpbHM6Cj4gCj4gYjQgZGlmZiAnPDIwMjUwOTEy
MDU1MzUyLjI4MzItMS13ZWlzaGFuZ2p1YW5AZXN3aW5jb21wdXRpbmcuY29tPicKPiBVc2luZyBj
YWNoZWQgY29weSBvZiB0aGUgbG9va3VwCj4gLS0tCj4gQW5hbHl6aW5nIDU1IG1lc3NhZ2VzIGlu
IHRoZSB0aHJlYWQKPiBQcmVwYXJpbmcgZmFrZS1hbSBmb3IgdjY6IGR0LWJpbmRpbmdzOiBldGhl
cm5ldDogZXN3aW46IERvY3VtZW50IGZvcgo+IEVJQzc3MDAgU29DCj4gRVJST1I6IENvdWxkIG5v
dCBmYWtlLWFtIHZlcnNpb24gdjYKPiAtLS0KPiBDb3VsZCBub3QgY3JlYXRlIGZha2UtYW0gcmFu
Z2UgZm9yIHVwcGVyIHNlcmllcyB2Ngo+IAo+IEkgYW0gbm90IGdvaW5nIHRvIHJldmlldyB0d2lj
ZSwgc28geW91IGNhbiBkcm9wIG15IHRhZyBhZ2FpbiB3aXRob3V0Cj4gZXhwbGFuYXRpb24uCj4g
Cj4gQmVzdCByZWdhcmRzLAo+IEtyenlzenRvZgo=

