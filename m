Return-Path: <netdev+bounces-45713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 468D37DF246
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 13:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F801C20E68
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 12:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF42F18638;
	Thu,  2 Nov 2023 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59A818E01
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 12:24:34 +0000 (UTC)
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Nov 2023 05:24:31 PDT
Received: from baidu.com (mx21.baidu.com [220.181.3.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D45D189
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 05:24:31 -0700 (PDT)
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH 1/2][net-next] skbuff: move
 netlink_large_alloc_large_skb() to skbuff.c
Thread-Topic: [PATCH 1/2][net-next] skbuff: move
 netlink_large_alloc_large_skb() to skbuff.c
Thread-Index: AQHaDXv+Yii923TczkyZ24SK2r7UN7Bm7qQg
Date: Thu, 2 Nov 2023 12:09:21 +0000
Message-ID: <d8fe126e98d1494baddc715c39deef3d@baidu.com>
References: <20231102062836.19074-1-lirongqing@baidu.com>
 <50622ac2-0939-af35-5d62-c56249e7bd26@huawei.com>
In-Reply-To: <50622ac2-0939-af35-5d62-c56249e7bd26@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.22.206.15]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.36
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 15:10:21:SYSTEM

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWXVuc2hlbmcgTGluIDxs
aW55dW5zaGVuZ0BodWF3ZWkuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMiwgMjAy
MyA3OjAyIFBNDQo+IFRvOiBMaSxSb25ncWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+OyBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXVtuZXQtbmV4dF0g
c2tidWZmOiBtb3ZlIG5ldGxpbmtfbGFyZ2VfYWxsb2NfbGFyZ2Vfc2tiKCkNCj4gdG8gc2tidWZm
LmMNCj4gDQo+IE9uIDIwMjMvMTEvMiAxNDoyOCwgTGkgUm9uZ1Fpbmcgd3JvdGU6DQo+ID4gbW92
ZSBuZXRsaW5rX2FsbG9jX2xhcmdlX3NrYiBhbmQgbmV0bGlua19za2JfZGVzdHJ1Y3RvciB0byBz
a2J1ZmYuYw0KPiA+IGFuZCByZW5hbWUgdGhlbSBtb3JlIGdlbmVyaWMsIHNvIHRoZXkgY2FuIGJl
IHVzZWQgZWxzZXdoZXJlIGxhcmdlDQo+ID4gbm9uLWNvbnRpZ3VvdXMgcGh5c2ljYWwgbWVtb3J5
IGlzIG5lZWRlZA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGkgUm9uZ1FpbmcgPGxpcm9uZ3Fp
bmdAYmFpZHUuY29tPg0KPiA+IC0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L3NrYnVmZi5oICAgfCAg
MyArKysNCj4gPiAgbmV0L2NvcmUvc2tidWZmLmMgICAgICAgIHwgNDANCj4gKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBuZXQvbmV0bGluay9hZl9uZXRsaW5r
LmMgfCA0MQ0KPiA+ICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ID4gIDMgZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKSwgMzkgZGVsZXRpb25zKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9za2J1ZmYuaCBiL2luY2x1ZGUvbGlu
dXgvc2tidWZmLmggaW5kZXgNCj4gPiA0MTc0YzRiLi43NzRhNDAxIDEwMDY0NA0KPiA+IC0tLSBh
L2luY2x1ZGUvbGludXgvc2tidWZmLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3NrYnVmZi5o
DQo+ID4gQEAgLTUwNjMsNSArNTA2Myw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBza2JfbWFya19m
b3JfcmVjeWNsZShzdHJ1Y3QNCj4gPiBza19idWZmICpza2IpICBzc2l6ZV90IHNrYl9zcGxpY2Vf
ZnJvbV9pdGVyKHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBpb3ZfaXRlcg0KPiAqaXRlciwN
Cj4gPiAgCQkJICAgICBzc2l6ZV90IG1heHNpemUsIGdmcF90IGdmcCk7DQo+ID4NCj4gPiArDQo+
ID4gK3ZvaWQgbGFyZ2Vfc2tiX2Rlc3RydWN0b3Ioc3RydWN0IHNrX2J1ZmYgKnNrYik7IHN0cnVj
dCBza19idWZmDQo+ID4gKyphbGxvY19sYXJnZV9za2IodW5zaWduZWQgaW50IHNpemUsIGludCBi
cm9hZGNhc3QpOw0KPiA+ICAjZW5kaWYJLyogX19LRVJORUxfXyAqLw0KPiA+ICAjZW5kaWYJLyog
X0xJTlVYX1NLQlVGRl9IICovDQo+ID4gZGlmZiAtLWdpdCBhL25ldC9jb3JlL3NrYnVmZi5jIGIv
bmV0L2NvcmUvc2tidWZmLmMgaW5kZXgNCj4gPiA0NTcwNzA1Li4yMGZmY2Q1IDEwMDY0NA0KPiA+
IC0tLSBhL25ldC9jb3JlL3NrYnVmZi5jDQo+ID4gKysrIGIvbmV0L2NvcmUvc2tidWZmLmMNCj4g
PiBAQCAtNjkxNywzICs2OTE3LDQzIEBAIHNzaXplX3Qgc2tiX3NwbGljZV9mcm9tX2l0ZXIoc3Ry
dWN0IHNrX2J1ZmYgKnNrYiwNCj4gc3RydWN0IGlvdl9pdGVyICppdGVyLA0KPiA+ICAJcmV0dXJu
IHNwbGljZWQgPzogcmV0Ow0KPiA+ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0woc2tiX3NwbGljZV9m
cm9tX2l0ZXIpOw0KPiA+ICsNCj4gPiArdm9pZCBsYXJnZV9za2JfZGVzdHJ1Y3RvcihzdHJ1Y3Qg
c2tfYnVmZiAqc2tiKSB7DQo+ID4gKwlpZiAoaXNfdm1hbGxvY19hZGRyKHNrYi0+aGVhZCkpIHsN
Cj4gPiArCQlpZiAoIXNrYi0+Y2xvbmVkIHx8DQo+ID4gKwkJICAgICFhdG9taWNfZGVjX3JldHVy
bigmKHNrYl9zaGluZm8oc2tiKS0+ZGF0YXJlZikpKQ0KPiA+ICsJCQl2ZnJlZShza2ItPmhlYWQp
Ow0KPiA+ICsNCj4gPiArCQlza2ItPmhlYWQgPSBOVUxMOw0KPiANCj4gVGhlcmUgc2VlbXMgdG8g
YmUgYW4gYXNzdW1wdGlvbiB0aGF0IHNrYiByZXR1cm5lZCBmcm9tDQo+IG5ldGxpbmtfYWxsb2Nf
bGFyZ2Vfc2tiKCkgaXMgbm90IGV4cGVjdGluZyB0aGUgZnJhZyBwYWdlIGZvciBzaGluZm8tPmZy
YWdzKiwgYXMgdGhlDQo+IGFib3ZlIE5VTEwgc2V0dGluZyB3aWxsIGJ5cGFzcyBtb3N0IG9mIHRo
ZSBoYW5kbGluZyBpbiBza2JfcmVsZWFzZV9kYXRhKCksdGhlbg0KPiBob3cgY2FuIHdlIGVuc3Vy
ZSB0aGF0IHRoZSB1c2VyIGlzIG5vdCBicmVha2luZyB0aGUgYXNzdW1wdGlvbiBpZiB3ZSBtYWtl
IGl0DQo+IG1vcmUgZ2VuZXJpYz8NCj4gDQoNCkhvdyBhYm91dCB0byBhZGQgV0FSTl9PTihza2Jf
c2hpbmZvKHNrYiktPiBucl9mcmFncykgdG8gZmluZCB0aGlzIGNvbmRpdGlvbg0KDQoNCi1MaSBS
b25nUWluZw0KPiANCg0K

