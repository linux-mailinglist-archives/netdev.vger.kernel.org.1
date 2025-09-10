Return-Path: <netdev+bounces-221598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2A8B5118C
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 10:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3B4189A1F8
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802833101B6;
	Wed, 10 Sep 2025 08:37:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.142.27])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7982C11DB;
	Wed, 10 Sep 2025 08:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.142.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493442; cv=none; b=pUCMyF0G/h7avYwbzvctD0dXI7awHDOkj/eu5zQ4B2BCKaQF3sm1lwXZTdFtCK/PzEquW3WcmlAQ5DqDsgIbz0kOC/HiATGf56hEKCQWZkmZ1Lr08zEqxn0qaZLioLkeP1EsOOs3azwDd4IEUrVdhUW85+ym6Q9xV1flM7g5jIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493442; c=relaxed/simple;
	bh=cRjq8XWD+5JGqB7JhkYl6nl7QM3sj5UrtQ721rRgubY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Si2fOnrcXuEupbqvYpD8MFWi6iWi6uHdXwJJXmiZeZ7OIyWD6iI+bSFvWuCKe+HFfVsC+6YYyUWKmD9t6HqYw+eOddmI/fc5znU6NllPv1JFTZReM/oxGdJQAwHV9xipUMrM6GMx9AV+z5aaPmnydHw1c1W7kUFjxea7cj2CzDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.76.142.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from weishangjuan$eswincomputing.com ( [10.12.96.155] ) by
 ajax-webmail-app2 (Coremail) ; Wed, 10 Sep 2025 16:36:19 +0800 (GMT+08:00)
Date: Wed, 10 Sep 2025 16:36:19 +0800 (GMT+08:00)
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
Subject: Re: Re: [PATCH v5 1/2] dt-bindings: ethernet: eswin: Document for
 EIC7700 SoC
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20250905-hissing-papaya-badger-1b2ddf@kuoka>
References: <20250904085913.2494-1-weishangjuan@eswincomputing.com>
 <20250904090055.2546-1-weishangjuan@eswincomputing.com>
 <20250905-hissing-papaya-badger-1b2ddf@kuoka>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3579e9ca.106c.19932c4c2f0.Coremail.weishangjuan@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAXt5WDOMFo7PzMAA--.25110W
X-CM-SenderInfo: pzhl2xxdqjy31dq6v25zlqu0xpsx3x1qjou0bp/1tbiAQEBEGjAVn
	gdDwAAsF
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

RGVhciBLcnp5c3p0b2YgS296bG93c2tpLAoKSSBob3BlIHRoaXMgZW1haWwgZmluZHMgeW91IHdl
bGwuIEZpcnN0LCBwbGVhc2UgYWxsb3cgbWUgdG8gYXBvbG9naXplIGZvciBhbnkgaW5jb252ZW5p
ZW5jZQpjYXVzZWQgYnkgdGhlIHByZXZpb3VzIHZlcnNpb24gb2YgdGhlIHlhbWwgZGVzY3JpcHRp
b24uIFdlIGhhdmUgbm93IHJldmlzZWQgdGhlIGRlc2NyaXB0aW9uCmNvbnRlbnQgYWNjb3JkaW5n
bHkgYXMgZm9sbG93OgoKZGVzY3JpcHRpb246CsKgIFBsYXRmb3JtIGdsdWUgbGF5ZXIgaW1wbGVt
ZW50YXRpb24gZm9yIFNUTU1BQyBFdGhlcm5ldCBkcml2ZXIuCgpJbiBhZGRpdGlvbiwgdGhlIGxp
bmsgdG8gdjUgcGF0Y2hlcyBpcyBhcyBmb2xsb3dz77yaCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC8yMDI1MDkwNDA5MDA1NS4yNTQ2LTEtd2Vpc2hhbmdqdWFuQGVzd2luY29tcHV0aW5nLmNv
bS8KCkkgaGF2ZSBhIHF1ZXN0aW9uIHRvIHNlZWsgeW91ciBhZHZpY2UuCkFmdGVyIHNlbmRpbmcg
dGhlIHY1IHBhdGNoZXMsIHdlIHJlY2VpdmVkIHlvdXIgZmVlZGJhY2suIE9yaWdpbmFsbHksIHdo
ZW4gcHJlcGFyaW5nIHRoZSB2NiBwYXRjaGVzLAp3ZSBpbnRlbmRlZCB0byBpbmNsdWRlIHRoZSAi
UmV2aWV3ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kga3J6eXN6dG9mLmtvemxvd3NraUBsaW5h
cm8ub3JnIiB0YWcuCkhvd2V2ZXIsIGdpdmVuIHRoYXQgd2UgaGF2ZSByZXZpc2VkwqB0aGUgeWFt
bCBkZXNjcmlwdGlvbiwgSSBhbSB1bmNlcnRhaW4gd2hldGhlciB0aGlzIHRhZyBzaG91bGQKc3Rp
bGwgYmUgaW5jbHVkZWQgaW4gdGhlIHY2IHBhdGNoZXMuIFBlcnNvbmFsbHksIEkgYmVsaWV2ZSBp
dCB3b3VsZCBiZSBhcHByb3ByaWF0ZSB0byByZXRhaW4gdGhlCiJSZXZpZXdlZC1ieSIgdGFnLiBD
b3VsZCB5b3UgcGxlYXNlIGNvbmZpcm0gaWYgdGhpcyBpcyBjb3JyZWN0PwpUaGFuayB5b3UgZm9y
IHlvdXIgdGltZSBhbmQgZ3VpZGFuY2UuIEkgbG9vayBmb3J3YXJkIHRvIHlvdXIgcmVzcG9uc2Uu
CkJlc3QgcmVnYXJkcywKU2hhbmdqdWFuIFdlaQoKCj4gLS0tLS3ljp/lp4vpgq7ku7YtLS0tLQo+
IOWPkeS7tuS6ujogIktyenlzenRvZiBLb3psb3dza2kiIDxrcnprQGtlcm5lbC5vcmc+Cj4g5Y+R
6YCB5pe26Ze0OjIwMjUtMDktMDUgMTU6NTM6MzAgKOaYn+acn+S6lCkKPiDmlLbku7bkuro6IHdl
aXNoYW5nanVhbkBlc3dpbmNvbXB1dGluZy5jb20KPiDmioTpgIE6IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnLCBhbmRyZXcrbmV0ZGV2QGx1bm4uY2gsIGRhdmVtQGRhdmVtbG9mdC5uZXQsIGVk
dW1hemV0QGdvb2dsZS5jb20sIGt1YmFAa2VybmVsLm9yZywgcGFiZW5pQHJlZGhhdC5jb20sIHJv
YmhAa2VybmVsLm9yZywga3J6aytkdEBrZXJuZWwub3JnLCBjb25vcitkdEBrZXJuZWwub3JnLCBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcsIG1jb3F1ZWxpbi5zdG0zMkBnbWFp
bC5jb20sIGFsZXhhbmRyZS50b3JndWVAZm9zcy5zdC5jb20sIHlvbmcubGlhbmcuY2hvb25nQGxp
bnV4LmludGVsLmNvbSwgdmxhZGltaXIub2x0ZWFuQG54cC5jb20sIHJtaytrZXJuZWxAYXJtbGlu
dXgub3JnLnVrLCBmYWl6YWwuYWJkdWwucmFoaW1AbGludXguaW50ZWwuY29tLCBwcmFiaGFrYXIu
bWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20sIGlub2NoaWFtYUBnbWFpbC5jb20sIGphbi5w
ZXRyb3VzQG9zcy5ueHAuY29tLCBqc3poYW5nQGtlcm5lbC5vcmcsIHAuemFiZWxAcGVuZ3V0cm9u
aXguZGUsIGJvb24ua2hhaS5uZ0BhbHRlcmEuY29tLCAweDEyMDdAZ21haWwuY29tLCBuZXRkZXZA
dmdlci5rZXJuZWwub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLCBsaW51eC1zdG0z
MkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29tLCBlbWlsLnJlbm5lci5iZXJ0aGluZ0BjYW5v
bmljYWwuY29tLCBuaW5neXVAZXN3aW5jb21wdXRpbmcuY29tLCBsaW5taW5AZXN3aW5jb21wdXRp
bmcuY29tLCBsaXpoaTJAZXN3aW5jb21wdXRpbmcuY29tLCBwaW5rZXNoLnZhZ2hlbGFAZWluZm9j
aGlwcy5jb20KPiDkuLvpopg6IFJlOiBbUEFUQ0ggdjUgMS8yXSBkdC1iaW5kaW5nczogZXRoZXJu
ZXQ6IGVzd2luOiBEb2N1bWVudCBmb3IgRUlDNzcwMCBTb0MKPiAKPiBPbiBUaHUsIFNlcCAwNCwg
MjAyNSBhdCAwNTowMDo1NVBNICswODAwLCB3ZWlzaGFuZ2p1YW5AZXN3aW5jb21wdXRpbmcuY29t
IHdyb3RlOgo+ID4gRnJvbTogU2hhbmdqdWFuIFdlaSA8d2Vpc2hhbmdqdWFuQGVzd2luY29tcHV0
aW5nLmNvbT4KPiA+IAo+ID4gQWRkIEVTV0lOIEVJQzc3MDAgRXRoZXJuZXQgY29udHJvbGxlciwg
c3VwcG9ydGluZyBjbG9jawo+ID4gY29uZmlndXJhdGlvbiwgZGVsYXkgYWRqdXN0bWVudCBhbmQg
c3BlZWQgYWRhcHRpdmUgZnVuY3Rpb25zLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGkgTGkg
PGxpemhpMkBlc3dpbmNvbXB1dGluZy5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFuZ2p1YW4g
V2VpIDx3ZWlzaGFuZ2p1YW5AZXN3aW5jb21wdXRpbmcuY29tPgo+IAo+IFJldmlld2VkLWJ5OiBL
cnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+Cj4gCj4g
QmVzdCByZWdhcmRzLAo+IEtyenlzenRvZgo=

