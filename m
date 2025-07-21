Return-Path: <netdev+bounces-208480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E298B0BADA
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 04:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D481643E9
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 02:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E2013D246;
	Mon, 21 Jul 2025 02:40:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmty1ljiyny4xntuumtyw.icoremail.net (zg8tmty1ljiyny4xntuumtyw.icoremail.net [165.227.155.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4D628E17;
	Mon, 21 Jul 2025 02:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.227.155.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753065656; cv=none; b=PjwQ4815vO1GnE8FLPdxsT0Q2YQYiFe/xeUZb7A9VibZt6ZjP74EZlSENExKK3knFOyB/aYpPxGgMGciih790CVD+D5GoX2HNYWuM/aG+MmjkcscHSxDeqIsOlIQab4ldMSdcb4xOKyrLNQFGfjeq/Ko1ksu3M/BlHNl79rbyZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753065656; c=relaxed/simple;
	bh=QCn2fymLq9Cp97mTe0VFqyCwSznom7KPVY7EfdsdBII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=WFCnj6tq0GjW72lTA9h79asFFluxAWELUNe5TdMPqSLtS2KA7DRhQDuf+j/H7px5cC/7dK0WmsLO2YbH82Pr6//PwDCbgUuW73jqyzSo6UTyc5UDsdzKEI9bfj5AY22eiJAcCyFqSTbw3T8d+XOeoRz88qg0ZmyhYSEs0exyKPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=165.227.155.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Mon, 21 Jul 2025 10:40:01 +0800 (GMT+08:00)
Date: Mon, 21 Jul 2025 10:40:01 +0800 (GMT+08:00)
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
Subject: Re: Re: Re: [PATCH v3 2/2] ethernet: eswin: Add eic7700 ethernet
 driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <e734f2fd-b96f-4981-9f00-a94f3fd03213@lunn.ch>
References: <20250703091808.1092-1-weishangjuan@eswincomputing.com>
 <20250703092015.1200-1-weishangjuan@eswincomputing.com>
 <c212c50e-52ae-4330-8e67-792e83ab29e4@lunn.ch>
 <7ccc507d.34b1.1980d6a26c0.Coremail.lizhi2@eswincomputing.com>
 <e734f2fd-b96f-4981-9f00-a94f3fd03213@lunn.ch>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6c5f12cd.37b0.1982ada38e5.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TAJkCgB3jg+BqH1oA9a0AA--.9408W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAQEKDGh9GfATSQABsh
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

RGVhciBBbmRyZXcgTHVubiwKVGhhbmsgeW91IGZvciB5b3VyIHByb2Zlc3Npb25hbCBhbmQgdmFs
dWFibGUgc3VnZ2VzdGlvbnMuCk91ciBxdWVzdGlvbnMgYXJlIGVtYmVkZGVkIGJlbG93IHlvdXIg
Y29tbWVudHMgaW4gdGhlIG9yaWdpbmFsIGVtYWlsIGJlbG93LgoKCkJlc3QgcmVnYXJkcywKCkxp
IFpoaQpFc3dpbiBDb21wdXRpbmcKCgo+IC0tLS0t5Y6f5aeL6YKu5Lu2LS0tLS0KPiDlj5Hku7bk
uro6ICJBbmRyZXcgTHVubiIgPGFuZHJld0BsdW5uLmNoPgo+IOWPkemAgeaXtumXtDoyMDI1LTA3
LTE1IDIxOjA5OjE3ICjmmJ/mnJ/kuowpCj4g5pS25Lu25Lq6OiDmnY7lv5cgPGxpemhpMkBlc3dp
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
c2gudmFnaGVsYUBlaW5mb2NoaXBzLmNvbQo+IOS4u+mimDogUmU6IFJlOiBbUEFUQ0ggdjMgMi8y
XSBldGhlcm5ldDogZXN3aW46IEFkZCBlaWM3NzAwIGV0aGVybmV0IGRyaXZlcgo+IAo+ID4gPiA+
ICsJZHdjX3ByaXYtPmRseV9wYXJhbV8xMDAwbVswXSA9IEVJQzc3MDBfREVMQVlfVkFMVUUwOwo+
ID4gPiA+ICsJZHdjX3ByaXYtPmRseV9wYXJhbV8xMDAwbVsxXSA9IEVJQzc3MDBfREVMQVlfVkFM
VUUxOwo+ID4gPiA+ICsJZHdjX3ByaXYtPmRseV9wYXJhbV8xMDAwbVsyXSA9IEVJQzc3MDBfREVM
QVlfVkFMVUUwOwo+ID4gPiA+ICsJZHdjX3ByaXYtPmRseV9wYXJhbV8xMDBtWzBdID0gRUlDNzcw
MF9ERUxBWV9WQUxVRTA7Cj4gPiA+ID4gKwlkd2NfcHJpdi0+ZGx5X3BhcmFtXzEwMG1bMV0gPSBF
SUM3NzAwX0RFTEFZX1ZBTFVFMTsKPiA+ID4gPiArCWR3Y19wcml2LT5kbHlfcGFyYW1fMTAwbVsy
XSA9IEVJQzc3MDBfREVMQVlfVkFMVUUwOwo+ID4gPiA+ICsJZHdjX3ByaXYtPmRseV9wYXJhbV8x
MG1bMF0gPSAweDA7Cj4gPiA+ID4gKwlkd2NfcHJpdi0+ZGx5X3BhcmFtXzEwbVsxXSA9IDB4MDsK
PiA+ID4gPiArCWR3Y19wcml2LT5kbHlfcGFyYW1fMTBtWzJdID0gMHgwOwo+ID4gPiAKPiA+ID4g
V2hhdCBhcmUgdGhlIHRocmVlIGRpZmZlcmVudCB2YWx1ZXMgZm9yPwo+ID4gPiAKPiA+IAo+ID4g
TGV0IG1lIGNsYXJpZnkgdGhlIHB1cnBvc2Ugb2YgdGhlIHRocmVlIGVsZW1lbnRzIGluIGVhY2gg
ZGx5X3BhcmFtXyogYXJyYXk6Cj4gPiAgIGRseV9wYXJhbV9beF1bMF06IERlbGF5IGNvbmZpZ3Vy
YXRpb24gZm9yIFRYRCBzaWduYWxzCj4gPiAgIGRseV9wYXJhbV9beF1bMV06IERlbGF5IGNvbmZp
Z3VyYXRpb24gZm9yIGNvbnRyb2wgc2lnbmFscyAoZS5nLiwgVFhfRU4sIFJYX0RWLCBSWF9DTEsp
Cj4gPiAgIGRseV9wYXJhbV9beF1bMl06IERlbGF5IGNvbmZpZ3VyYXRpb24gZm9yIFJYRCBzaWdu
YWxzCj4gCj4gTWF5YmUgYWRkIGEgI2RlZmluZSBvciBhbiBlbnVtIGZvciB0aGUgaW5kZXguCj4g
Cj4gRG8gdGhlc2UgZGVsYXlzIHJlcHJlc2VudCB0aGUgUkdNSUkgMm5zIGRlbGF5Pwo+IAoKWWVz
LCB0aGVzZSBkZWxheXMgcmVmZXIgdG8gdGhlIFJHTUlJIGRlbGF5LCBidXQgdGhleSBhcmUgbm90
IHN0cmljdGx5IDJucy4gVGhlcmUgYXJlIGEgZmV3IHBvaW50cyB0aGF0IHJlcXVpcmUgZnVydGhl
ciBjbGFyaWZpY2F0aW9uOgoxLiBSZWdhcmRpbmcgZGVsYXkgY29uZmlndXJhdGlvbiBsb2dpYzoK
ICAgQXMgeW91IG1lbnRpb25lZCBpbiB2ZXJzaW9uIFYyLCByeC1pbnRlcm5hbC1kZWxheS1wcyBh
bmQgdHgtaW50ZXJuYWwtZGVsYXktcHMgd2lsbCBiZSBtYXBwZWQgdG8gYW5kIG92ZXJ3cml0ZSB0
aGUgY29ycmVzcG9uZGluZyBiaXRzIGluIHRoZSBFSUM3NzAwX0RFTEFZX1ZBTFVFMSByZWdpc3Rl
ciwgd2hpY2ggY29udHJvbHMgdGhlIHJ4X2NsayBhbmQgdHhfY2xrIGRlbGF5cy4gSXMgdGhpcyB1
bmRlcnN0YW5kaW5nIGFuZCBhcHByb2FjaCBjb3JyZWN0IGFuZCBmZWFzaWJsZT8KMi4gQWJvdXQg
dGhlIHBoeS1tb2RlIHNldHRpbmc6CiAgIEluIG91ciBwbGF0Zm9ybSwgdGhlIGludGVybmFsIGRl
bGF5cyBhcmUgcHJvdmlkZWQgYnkgdGhlIE1BQy4gV2hlbiBjb25maWd1cmluZyByeC1pbnRlcm5h
bC1kZWxheS1wcyBhbmQgdHgtaW50ZXJuYWwtZGVsYXktcHMgaW4gdGhlIGRldmljZSB0cmVlLCBp
cyBpdCBhcHByb3ByaWF0ZSB0byBzZXQgcGh5LW1vZGUgPSAicmdtaWktaWQiIGluIHRoaXMgY2Fz
ZT8KMy4gRGVsYXkgdmFsdWVzIGJlaW5nIGdyZWF0ZXIgdGhhbiAybnM6CiAgIEluIG91ciBwbGF0
Zm9ybSwgdGhlIG9wdGltYWwgZGVsYXkgdmFsdWVzIGZvciByeF9jbGsgYW5kIHR4X2NsayBhcmUg
ZGV0ZXJtaW5lZCBiYXNlZCBvbiB0aGUgYm9hcmQtbGV2ZWwgdGltaW5nIGFkanVzdG1lbnQsIGFu
ZCBib3RoIGFyZSBncmVhdGVyIHRoYW4gMm5zLiBHaXZlbiB0aGlzLCBpcyBpdCByZWFzb25hYmxl
IGFuZCBjb21wbGlhbnQgd2l0aCB0aGUgUkdNSUkgc3BlY2lmaWNhdGlvbiB0byBzZXQgYm90aCBy
eC1pbnRlcm5hbC1kZWxheS1wcyBhbmQgdHgtaW50ZXJuYWwtZGVsYXktcHMgdG8gdmFsdWVzIGdy
ZWF0ZXIgdGhhbiAybnMgaW4gdGhlIERldmljZSBUcmVlPwoKPiA+ID4gewo+ID4gPiA+ICsJCWVp
Yzc3MDBfc2V0X2RlbGF5KGR3Y19wcml2LT5yeF9kZWxheV9wcywgZHdjX3ByaXYtPnR4X2RlbGF5
X3BzLAo+ID4gPiA+ICsJCQkJICAmZHdjX3ByaXYtPmRseV9wYXJhbV8xMDAwbVsxXSk7Cj4gPiA+
ID4gKwkJZWljNzcwMF9zZXRfZGVsYXkoZHdjX3ByaXYtPnJ4X2RlbGF5X3BzLCBkd2NfcHJpdi0+
dHhfZGVsYXlfcHMsCj4gPiA+ID4gKwkJCQkgICZkd2NfcHJpdi0+ZGx5X3BhcmFtXzEwMG1bMV0p
Owo+ID4gPiA+ICsJCWVpYzc3MDBfc2V0X2RlbGF5KGR3Y19wcml2LT5yeF9kZWxheV9wcywgZHdj
X3ByaXYtPnR4X2RlbGF5X3BzLAo+ID4gPiA+ICsJCQkJICAmZHdjX3ByaXYtPmRseV9wYXJhbV8x
MG1bMV0pOwo+ID4gPiA+ICsJfSBlbHNlIHsKPiA+ID4gPiArCQlkZXZfZGJnKCZwZGV2LT5kZXYs
ICIgdXNlIGRlZmF1bHQgZGx5XG4iKTsKPiA+ID4gCj4gPiA+IFdoYXQgaXMgdGhlIGRlZmF1bHQ/
IEl0IHNob3VsZCBiZSAwcHMuIFNvIHRoZXJlIGlzIG5vIHBvaW50IHByaW50aW5nCj4gPiA+IHRo
aXMgbWVzc2FnZS4KPiA+ID4gCj4gPiAKPiA+IFRoZSBkZWZhdWx0IHZhbHVlIGlzIEVJQzc3MDBf
REVMQVlfVkFMVUUxCj4gCj4gQnV0IHdoYXQgZG9lcyBFSUM3NzAwX0RFTEFZX1ZBTFVFMSBtZWFu
PyBJdCBzaG91bGQgbWVhbiAwcHM/IEJ1dCBpJ20KPiBub3Qgc3VyZSBpdCBkb2VzLgo+IAoKVGhl
cmUgaXMgYSBxdWVzdGlvbiB0aGF0IG5lZWRzIGNsYXJpZmljYXRpb246ClRoZSBFSUM3NzAwX0RF
TEFZX1ZBTFVFMCBhbmQgRUlDNzcwMF9ERUxBWV9WQUxVRTEgcmVnaXN0ZXJzIGNvbnRhaW4gdGhl
IG9wdGltYWwgZGVsYXkgY29uZmlndXJhdGlvbnMgZGV0ZXJtaW5lZCB0aHJvdWdoIGJvYXJkLWxl
dmVsIHBoYXNlIGFkanVzdG1lbnQuIFRoZXJlZm9yZSwgdGhleSBhcmUgYWxzbyB1c2VkIGFzIHRo
ZSBkZWZhdWx0IHZhbHVlcyBpbiBvdXIgcGxhdGZvcm0uIElmIHRoZSBkZWZhdWx0IGRlbGF5IGlz
IHNldCB0byAwcHMsIHRoZSBFdGhlcm5ldCBpbnRlcmZhY2UgbWF5IGZhaWwgdG8gZnVuY3Rpb24g
Y29ycmVjdGx5IGluIG91ciBwbGF0Zm9ybS4KCj4gCUFuZHJldwo=

