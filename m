Return-Path: <netdev+bounces-57415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127118130E4
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C8A281221
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA5F5103C;
	Thu, 14 Dec 2023 13:05:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net (zg8tmtu5ljg5lje1ms4xmtka.icoremail.net [159.89.151.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C07C3125;
	Thu, 14 Dec 2023 05:05:51 -0800 (PST)
Received: from alexious$zju.edu.cn ( [124.90.104.65] ) by
 ajax-webmail-mail-app2 (Coremail) ; Thu, 14 Dec 2023 21:05:27 +0800
 (GMT+08:00)
Date: Thu, 14 Dec 2023 21:05:27 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: alexious@zju.edu.cn
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Chris Snook" <chris.snook@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, 
	"Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, 
	"Yuanjun Gong" <ruc_gongyuanjun@163.com>, 
	"Jie Yang" <jie.yang@atheros.com>, 
	"Jeff Garzik" <jgarzik@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] [v2] ethernet: atheros: fix a memleak in
 atl1e_setup_ring_resources
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20231211191447.0408689d@kernel.org>
References: <20231208082316.3384650-1-alexious@zju.edu.cn>
 <20231211191447.0408689d@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <632c5358.35eae.18c686e98f2.Coremail.alexious@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:by_KCgDnDiqY_Xpl526SAA--.29775W
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/1tbiAggGAGV23RYUMAAGs2
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

Cj4gT24gRnJpLCAgOCBEZWMgMjAyMyAxNjoyMzoxNCArMDgwMCBaaGlwZW5nIEx1IHdyb3RlOgo+
ID4gdjI6IFNldHRpbmcgdHhfcmluZy0+dHhfYnVmZmVyIHRvIE5VTEwgYWZ0ZXIgZnJlZS4KPiAK
PiBIYXZpbmcgY2xvc2VyIGxvb2sgYXQgdGhpcyBkcml2ZXIgIC0gaXQgdHJpZXMgdG8gZnJlZSBi
b3RoIG9uIGNsb3NlIGFuZAo+IHJlbW92ZSwgc28gc2VlbXMgbGlrZSB3ZSBkbyBpbmRlZWQgaGF2
ZSB0byBOVUxMLW91dCB0aGUgcG9pbnRlciwgc2lnaC4KPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9hdGhlcm9zL2F0bDFlL2F0bDFlX21haW4uYyBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2F0aGVyb3MvYXRsMWUvYXRsMWVfbWFpbi5jCj4gPiBpbmRleCA1OTM1YmUxOTBi
OWUuLjFiZmZlNzc0MzlhYyAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2F0
aGVyb3MvYXRsMWUvYXRsMWVfbWFpbi5jCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9h
dGhlcm9zL2F0bDFlL2F0bDFlX21haW4uYwo+ID4gQEAgLTg2Niw2ICs4NjYsOCBAQCBzdGF0aWMg
aW50IGF0bDFlX3NldHVwX3JpbmdfcmVzb3VyY2VzKHN0cnVjdCBhdGwxZV9hZGFwdGVyICphZGFw
dGVyKQo+ID4gIAkJbmV0ZGV2X2VycihhZGFwdGVyLT5uZXRkZXYsICJvZmZzZXQoJWQpID4gcmlu
ZyBzaXplKCVkKSAhIVxuIiwKPiA+ICAJCQkgICBvZmZzZXQsIGFkYXB0ZXItPnJpbmdfc2l6ZSk7
Cj4gPiAgCQllcnIgPSAtMTsKPiA+ICsJCWtmcmVlKHR4X3JpbmctPnR4X2J1ZmZlcik7Cj4gPiAr
CQl0eF9yaW5nLT50eF9idWZmZXIgPSBOVUxMOwo+ID4gIAkJZ290byBmYWlsZWQ7Cj4gCj4gUGxl
YXNlIGFkZCBhIG5ldyBqdW1wIHRhcmdldCwgdGhvLCBhbmQgbW92ZSB0aGUgZnJlZWluZyB0aGVy
ZS4KPiBUaGVyZSdzIGEgc21hbGwgY2hhbmNlIHNvbWVvbmUgd2lsbCBhZGQgbW9yZSBjb2RlIHRv
IHRoaXMgZnVuY3Rpb24KPiBhbmQgaXQgd2lsbCBuZWVkIHRvIGNvcHkgLyBwYXN0ZSB0aGlzIHVu
d2luZC4KPiAtLSAKClRoYW5rIHlvdSBmb3IgeW91ciBhZHZpY2UsIEkndmUgc2VuZCBhIHYzIHZl
cnNpb24gb2YgdGhpcyBwYXRjaC4K

