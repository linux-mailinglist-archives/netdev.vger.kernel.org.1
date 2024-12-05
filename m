Return-Path: <netdev+bounces-149219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC9E9E4CA1
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 04:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478A3164196
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 03:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA92418C33C;
	Thu,  5 Dec 2024 03:26:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9E4180A80
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 03:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733369181; cv=none; b=WFlIfrYccsOKky8oxGOEU+25TCs59dVF51sCRwxSZSCNB6o5G95AlKCZhpb1BhiGf14TwrvzJSAyPYMVndy7Tqypb+P0pMoDLK3iL4iuYh6vxPVTdnUKxUkJYxw9a83YvM+ev+n9RVd/CsSHH1RBV17no8gqtbVIvkmRARdl0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733369181; c=relaxed/simple;
	bh=LoDnp2H2oYB/dOeJ1OpO4yUA/k0lyCal45/QQU0GnLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=rS6B2VfX0/H7c8kJNsQNkdkfec7sGmqb73JAsCtTFRzcha6AVKYF2jqyWpmN0PwIBICg0AQwYf+d5ppD+3sZGzyRknGMvS1UC50vsOGwTZl5kVcsNpOrGaMiguroRDuc5pGp5XrnWtB78xuw3DoD0mO0izrvdimKAxLlHNtOx4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelsoft.com; spf=pass smtp.mailfrom=kernelsoft.com; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelsoft.com
Received: from tianyu2$kernelsoft.com ( [106.37.191.2] ) by
 ajax-webmail-mail (Coremail) ; Thu, 5 Dec 2024 11:23:27 +0800 (GMT+08:00)
Date: Thu, 5 Dec 2024 11:23:27 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: tianyu2 <tianyu2@kernelsoft.com>
To: "Paolo Abeni" <pabeni@redhat.com>
Cc: eric.dumazet@gmail.com, "Pablo Neira Ayuso" <pablo@netfilter.org>, 
	netdev@vger.kernel.org
Subject: Re: [PATCH] ipv4: remove useless arg
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT5 build
 20230627(00751abc) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <cbd3f835-0d01-46fa-9125-a0fbd5f50919@redhat.com>
References: <20241202033230.870313-1-tianyu2@kernelsoft.com>
 <85376cf2-0c95-4a08-bcbb-33c30c2f2c51@redhat.com>
 <68a6773c.8deb.1938faae78c.Coremail.tianyu2@kernelsoft.com>
 <cbd3f835-0d01-46fa-9125-a0fbd5f50919@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3a24afbf.8f12.19394d80ca6.Coremail.tianyu2@kernelsoft.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQAAfwC3NN+vHFFnP+FYAg--.5803W
X-CM-SenderInfo: xwld05zxs6yvxuqhz2xriwhudrp/1tbiAQAOEmdPN9YCaQADs8
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW3Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

Cgo+IE9uIDEyLzQvMjQgMDQ6MTYsIHRpYW55dTIgd3JvdGU6Cj4gPj4gT24gMTIvMi8yNCAwNDoz
MiwgdGlhbnl1MiB3cm90ZToKPiA+Pj4gVGhlICJzdHJ1Y3Qgc29jayAqc2siIHBhcmFtZXRlciBp
biBpcF9yY3ZfZmluaXNoX2NvcmUgaXMgdW51c2VkLCB3aGljaAo+ID4+PiBsZWFkcyB0aGUgY29t
cGlsZXIgdG8gb3B0aW1pemUgaXQgb3V0LiBBcyBhIHJlc3VsdCwgdGhlCj4gPj4+ICJzdHJ1Y3Qg
c2tfYnVmZiAqc2tiIiBwYXJhbWV0ZXIgaXMgcGFzc2VkIHVzaW5nIHgxLiBBbmQgdGhpcyBtYWtl
IGtwcm9iZQo+ID4+PiBoYXJkIHRvIHVzZS4KPiA+Pj4KPiA+Pj4gU2lnbmVkLW9mZi1ieTogdGlh
bnl1MiA8dGlhbnl1MkBrZXJuZWxzb2Z0LmNvbT4KPiA+Pgo+ID4+IFRoZSBwYXRjaCBjb2RlIGdv
b2QsIGJ1dCB0aGUgYWJvdmUgZG9lcyBub3QgbG9vayBsaWtlIGEgcmVhbCBuYW1lPyE/Cj4gPj4K
PiA+PiBJZiBzbywgcGxlYXNlIHJlLXN1Ym1pdCwgdXNpbmcgeW91ciByZWFsIGZ1bGwgbmFtZSBh
bmQgaW5jbHVkaW5nIHRoZQo+ID4+IHRhcmdldCB0cmVlIChuZXQtbmV4dCBpbiB0aGlzIGNhc2Up
IGluIHRoZSBzdWJqIHByZWZpeC4KPiA+Pgo+ID4+IFNlZToKPiA+PiBodHRwczovL2VsaXhpci5i
b290bGluLmNvbS9saW51eC92Ni4xMi4xL3NvdXJjZS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3Vi
bWl0dGluZy1wYXRjaGVzLnJzdCNMNDQwCj4gPj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20v
bGludXgvdjYuMTIuMS9zb3VyY2UvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL21haW50YWluZXItbmV0
ZGV2LnJzdCNMMTIKPiA+Pgo+ID4+IEBQYWJsbzogYWZ0ZXIgdGhpcyBjaGFuZ2Ugd2lsbCBiZSBt
ZXJnZWQsIEkgKnRoaW5rKiB0aGF0IGEgcG9zc2libGUKPiA+PiBmb2xsb3ctdXAgY291bGQgZHJv
cCB0aGUgJ3NrJyBhcmcgZnJvbSBORl9IT09LX0xJU1QgYW5kIGlwX3Jjdl9maW5pc2goKSB0b28u
Cj4gPj4KPiA+PiBUaGFua3MhCj4gPj4KPiA+PiBQYW9sbwo+ID4gCj4gPiBUaGFuayB5b3UgZm9y
IHRoZSByZW1pbmRlci4gSeKAmWxsIGFkanVzdCB0aGUgcGF0Y2ggZm9ybWF0IGluIHRoZSBuZXh0
IHZlcnNpb24uCj4gPiAKPiA+IElmIGlwX3Jjdl9maW5pc2ggaXMgbW9kaWZpZWQsICBORl9IT09L
L05GX0hPT0tfTElTVCBhbHNvIG5lZWRzIHRvIGJlIGFkanVzdGVkLiBJIG5vdGljZWQgdGhhdCBt
YW55IHBsYWNlcyB1c2UgTkZfSE9PSy4gVGhlc2UgbW9kaWZpY2F0aW9ucyBzaG91bGQgYmUgZmlu
ZSwgcmlnaHQ/Cj4gCj4gT3VjaCwgSSBtaXNzZWQgdGhlIE5GX0hPT0sgaW1wbGljYXRpb24uIFRv
dWNoaW5nIGFsbCBORl9IT09LKCkKPiBjYWxsLXNpdGVzIGxvb2tzIElNSE8gd2F5IHRvIGludmFz
aXZlIHRvIGp1c3RpZnkgdGhpcyBjaGFuZ2UuCj4gCj4gPiBIb3dldmVyLCBJIGZvdW5kIHRoYXQg
dGhlIGlwX3Jjdl9maW5pc2ggZnVuY3Rpb24gZG9lc27igJl0IHNlZW0gdG8gYmUgb3B0aW1pemVk
IGJ5IHRoZSBjb21waWxlci4KPiA+IChBUk02NCkoIGdjYyB2ZXJzaW9uIDguNS4wIDIwMjEwNTE0
IChSZWQgSGF0IDguNS4wLTQpIChHQ0MpICkKPiAKPiBGVFIsIHRoYXQgaXMgcXVpdGUgYW4gb2xk
IG9uZSA6KSBZb3Ugc2hvdWxkIHRyeSB3aXRoIGdjYyAxMy4KCgpJIGFwcGxpZWQgbXkgcGF0Y2gg
dG8gdGhlIHY2LjEzLXJjMSB2ZXJzaW9uLkFuZCBJIGNvbXBpbGVkIGl0IG9uIHg4NiB1c2luZyBH
Q0MgMTMuCkl0IHNlZW1zIHRoYXQgaXBfcmN2X2ZpbmlzaCB3YXMgbm90IG9wdGltaXplZC4KKGdj
YyB2ZXJzaW9uIDEzLjEuMCAoVWJ1bnR1IDEzLjEuMC04dWJ1bnR1MX4yMi4wNCkpCgoKZmZmZmZm
ZmY4MWNjNmU0MCA8aXBfcmN2X2ZpbmlzaD46CmZmZmZmZmZmODFjYzZlNDA6ICAgICAgIGYzIDBm
IDFlIGZhICAgICAgICAgICAgIGVuZGJyNjQKZmZmZmZmZmY4MWNjNmU0NDogICAgICAgNDggODUg
ZDIgICAgICAgICAgICAgICAgdGVzdCAgICVyZHgsJXJkeApmZmZmZmZmZjgxY2M2ZTQ3OiAgICAg
ICA3NCAzYSAgICAgICAgICAgICAgICAgICBqZSAgICAgZmZmZmZmZmY4MWNjNmU4MyA8aXBfcmN2
X2ZpbmlzaCsweDQzPgpmZmZmZmZmZjgxY2M2ZTQ5OiAgICAgICA1MyAgICAgICAgICAgICAgICAg
ICAgICBwdXNoICAgJXJieApmZmZmZmZmZjgxY2M2ZTRhOiAgICAgICA0OCA4OSBkMyAgICAgICAg
ICAgICAgICBtb3YgICAgJXJkeCwlcmJ4CmZmZmZmZmZmODFjYzZlNGQ6ICAgICAgIDQ4IDhiIDUy
IDEwICAgICAgICAgICAgIG1vdiAgICAweDEwKCVyZHgpLCVyZHgKZmZmZmZmZmY4MWNjNmU1MTog
ICAgICAgMzEgYzkgICAgICAgICAgICAgICAgICAgeG9yICAgICVlY3gsJWVjeApmZmZmZmZmZjgx
Y2M2ZTUzOiAgICAgICA0OCA4OSBkZSAgICAgICAgICAgICAgICBtb3YgICAgJXJieCwlcnNpCmZm
ZmZmZmZmODFjYzZlNTY6ICAgICAgIGU4IDA1IGYwIGZmIGZmICAgICAgICAgIGNhbGwgICBmZmZm
ZmZmZjgxY2M1ZTYwIDxpcF9yY3ZfZmluaXNoX2NvcmU+CgoKCj4gCj4gVGhhbmtzLAo+IAo+IFBh
b2xvCg==

