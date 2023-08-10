Return-Path: <netdev+bounces-26457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7AF777DFE
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242092821D3
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63AB20F93;
	Thu, 10 Aug 2023 16:21:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D286E1E1D2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 16:21:10 +0000 (UTC)
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D9AAA8;
	Thu, 10 Aug 2023 09:21:08 -0700 (PDT)
Received: from linma$zju.edu.cn ( [10.181.231.207] ) by
 ajax-webmail-mail-app4 (Coremail) ; Fri, 11 Aug 2023 00:02:24 +0800
 (GMT+08:00)
X-Originating-IP: [10.181.231.207]
Date: Fri, 11 Aug 2023 00:02:24 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Simon Horman" <horms@kernel.org>
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, rdunlap@infradead.org, 
	void@manifault.com, jani.nikula@intel.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] docs: staging: add netlink attrs best practices
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <ZNTw+ApPS9U4VhZI@vergenet.net>
References: <20230809032552.765663-1-linma@zju.edu.cn>
 <ZNTw+ApPS9U4VhZI@vergenet.net>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <41722e43.1049b3.189e02f50f6.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgB3fxcRCtVkdX_VCg--.62776W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwIDEmTUP3sScwAAsF
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGVsbG8gU2ltb24sCgo+ID4gUHJvdmlkZSBzb21lIHN1Z2dlc3Rpb25zIHRoYXQgd2hvIGRlYWwg
d2l0aCBOZXRsaW5rIGNvZGUgY291bGQgZm9sbG93Cj4gPiAob2YgY291cnNlIHVzaW5nIHRoZSB3
b3JkICJiZXN0LXByYWN0aWNlcyIgbWF5IHNvdW5kIHNvbWV3aGF0Cj4gPiBleGFnZ2VyYXRlKS4K
PiA+IAo+ID4gQWNjb3JkaW5nIHRvIG15IHJlY2VudCBwcmFjdGljZXMsIHRoZSBwYXJzaW5nIG9m
IHRoZSBOZXRsaW5rIGF0dHJpYnV0ZXMKPiA+IGxhY2tzIGRvY3VtZW50cyBmb3Iga2VybmVsIGRl
dmVsb3BlcnMuIFNpbmNlIHJlY2VudGx5IHRoZSByZWxldmFudCBkb2NzCj4gPiBmb3IgTmV0bGlu
ayB1c2VyIHNwYWNlIGdldCByZXBsZW5pc2hlZCwgSSBndWVzcyBpcyBhIGdvb2QgY2hhbmNlIGZv
cgo+ID4ga2VybmVsIHNwYWNlIHBhcnQgdG8gY2F0Y2ggd2l0aC4KPiA+IAo+ID4gRmlyc3QgdGlt
ZSB0byB3cml0ZSBhIGRvY3VtZW50IGFuZCBhbnkgcmV2aWV3cyBhcmUgYXBwcmVjaWF0ZWQuCj4g
PiAKPiA+IFNpZ25lZC1vZmYtYnk6IExpbiBNYSA8bGlubWFAemp1LmVkdS5jbj4KPiAKPiBUaGFu
a3MgZm9yIHdyaXRpbmcgdGhpcyB1cCwgZnJvbSBteSBwZXJzcGVjdGl2ZSB0aGlzIGlzIHZlcnkg
dXNlZnVsLgo+IAo+IFNvbWUgdHJpdmlhbCBmZWVkYmFjayBmb2xsb3dzLgoKVGhhbmtzIHNvb29v
b29vIG11Y2guIEFuZCBmZWVsIHJlYWxseSBzb3JyeSB0aGF0IHRoZSB2MiBzdGlsbCBoYXMgc28g
bWFueQp0eXBvcywgZ3JhbW1hciBpc3N1ZXMsIGFuZCB3b3JkIG1pc3VzZS4gSSB3aWxsIHByZXBh
cmUgdGhlIHYzIGNhcmVmdWxseQp3aXRoIGFsbCB0aG9zZSBzdWdnZXN0aW9ucy4gUmVhbGx5IGFw
cHJlY2lhdGUgdGhhdC4KCj4gCj4gPiAtLS0KPiA+IHYxIC0+IHYyOiBmaXggc29tZSB0eXBvcyBp
biBGT08gZXhhbXBsZSwKPiA+ICAgICAgICAgICBhZGQgZXh0cmEgc2VjdGlvbiAiQWJvdXQgR2Vu
ZXJhbCBOZXRsaW5rIENhc2UiIHRvIGF2b2lkIGFueQo+ID4gICAgICAgICAgIGNvbmZ1c2lvbiBm
b3IgbmV3IGNvZGUgdXNlcnMuCj4gPiAKPiA+ICBEb2N1bWVudGF0aW9uL3N0YWdpbmcvaW5kZXgu
cnN0ICAgICAgICAgICAgICAgfCAgIDEgKwo+ID4gIC4uLi9zdGFnaW5nL25ldGxpbmstYXR0cnMt
YmVzdC1wcmFjdGljZXMucnN0ICB8IDU0NCArKysrKysrKysrKysrKysrKysKPiA+ICBNQUlOVEFJ
TkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwo+IAo+IFBlcmhh
cHMgdGhpcyB3YXMgZGlzY3Vzc2VkIGVhcmxpZXIuCj4gQnV0IEknbSBjdXJpb3VzIHRvIGtub3cg
aWYgdGhlcmUgaXMgYSBwcmVmZXJlbmNlIGZvciBwdXR0aW5nCj4gdGhpcyBpbnRvIHN0YWdpbmcg
cmF0aGVyIHRoYW4gbmV0d29ya2luZyBvciBlbHNld2hlcmUuCj4gCgpJbiBmYWN0LCBJIGhhdmUg
bm8gaWRlYSBhYm91dCB0aGF0LiBCdXQgc2luY2UgdGhlIGN1cnJlbnQgTmV0bGluawpkb2N1bWVu
dGF0aW9uIGlzIG1haW5seSB1c2VyIHNwYWNlIHJlbGF0ZWQgc28gSSBjYW4gY29udmluY2UgbXlz
ZWxmIG5vdAp0byBwdXQgdGhpcyBkb2N1bWVudCB0aGVyZS4KCkkgZ3Vlc3MgeW91IGFyZSByaWdo
dCwgbWF5YmUgSSBzaG91bGQgcGxhY2UgaXQgYXQgRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nLwpm
b2xkZXIuCgpbc25pcF0KClRoYW5rcyBhZ2FpbgpMaW4K

