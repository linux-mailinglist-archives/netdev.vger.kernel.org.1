Return-Path: <netdev+bounces-20612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B547603B3
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 02:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC092815E8
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57020161;
	Tue, 25 Jul 2023 00:15:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF3810EE
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:15:54 +0000 (UTC)
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net (zg8tmtu5ljg5lje1ms4xmtka.icoremail.net [159.89.151.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94FAD10C9;
	Mon, 24 Jul 2023 17:15:51 -0700 (PDT)
Received: from linma$zju.edu.cn ( [10.162.208.50] ) by
 ajax-webmail-mail-app2 (Coremail) ; Tue, 25 Jul 2023 08:15:39 +0800
 (GMT+08:00)
X-Originating-IP: [10.162.208.50]
Date: Tue, 25 Jul 2023 08:15:39 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/sched: mqprio: Add length check for
 TCA_MQPRIO_{MAX/MIN}_RATE64
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230724160214.424573ac@kernel.org>
References: <20230724014625.4087030-1-linma@zju.edu.cn>
 <20230724160214.424573ac@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <63d69a72.e2656.1898a66ca22.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:by_KCgDXV3wrFL9kw2GACg--.42590W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwMHEmS91fkWAgABs1
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGVsbG8gSmFrdWIsCgo+ID4gVGhlIG5sYV9mb3JfZWFjaF9uZXN0ZWQgcGFyc2luZyBpbiBmdW5j
dGlvbiBtcXByaW9fcGFyc2VfbmxhdHRyKCkgZG9lcwo+ID4gbm90IGNoZWNrIHRoZSBsZW5ndGgg
b2YgdGhlIG5lc3RlZCBhdHRyaWJ1dGUuIFRoaXMgY2FuIGxlYWQgdG8gYW4KPiA+IG91dC1vZi1h
dHRyaWJ1dGUgcmVhZCBhbmQgYWxsb3cgYSBtYWxmb3JtZWQgbmxhdHRyIChlLmcuLCBsZW5ndGgg
MCkgdG8KPiA+IGJlIHZpZXdlZCBhcyA4IGJ5dGUgaW50ZWdlciBhbmQgcGFzc2VkIHRvIHByaXYt
Pm1heF9yYXRlL21pbl9yYXRlLgo+ID4gCj4gPiBUaGlzIHBhdGNoIGFkZHMgdGhlIGNoZWNrIGJh
c2VkIG9uIG5sYV9sZW4oKSB3aGVuIGNoZWNrIHRoZSBubGFfdHlwZSgpLAo+ID4gd2hpY2ggZW5z
dXJlcyB0aGF0IHRoZSBsZW5ndGggb2YgdGhlc2UgdHdvIGF0dHJpYnV0ZSBtdXN0IGVxdWFscwo+
ID4gc2l6ZW9mKHU2NCkuCj4gCj4gSG93IGRvIHlvdSBydW4gZ2V0X21haW50YWluZXI/IFlvdSBk
aWRuJ3QgQ0MgdGhlIGF1dGhvciBvZiB0aGUgY29kZS4KClRoYXQncyB3ZWlyZCwgSSBqdXN0IHJh
biBjb2RlIGJlbG93IGFuZCBzZW5kIHRoaXMgcGF0Y2ggdG8gYWxsIDkgZW1haWxzIHBvcGVkIG91
dC4KCiMgLi9zY3JpcHRzL2dldF9tYWludGFpbmVyLnBsIG5ldC9zY2hlZC9zY2hfbXFwcmlvLmMK
SmFtYWwgSGFkaSBTYWxpbSA8amhzQG1vamF0YXR1LmNvbT4gKG1haW50YWluZXI6VEMgc3Vic3lz
dGVtKQpDb25nIFdhbmcgPHhpeW91Lndhbmdjb25nQGdtYWlsLmNvbT4gKG1haW50YWluZXI6VEMg
c3Vic3lzdGVtKQpKaXJpIFBpcmtvIDxqaXJpQHJlc251bGxpLnVzPiAobWFpbnRhaW5lcjpUQyBz
dWJzeXN0ZW0pCiJEYXZpZCBTLiBNaWxsZXIiIDxkYXZlbUBkYXZlbWxvZnQubmV0PiAobWFpbnRh
aW5lcjpORVRXT1JLSU5HIFtHRU5FUkFMXSkKRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUu
Y29tPiAobWFpbnRhaW5lcjpORVRXT1JLSU5HIFtHRU5FUkFMXSkKSmFrdWIgS2ljaW5za2kgPGt1
YmFAa2VybmVsLm9yZz4gKG1haW50YWluZXI6TkVUV09SS0lORyBbR0VORVJBTF0pClBhb2xvIEFi
ZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4gKG1haW50YWluZXI6TkVUV09SS0lORyBbR0VORVJBTF0p
Cm5ldGRldkB2Z2VyLmtlcm5lbC5vcmcgKG9wZW4gbGlzdDpUQyBzdWJzeXN0ZW0pCmxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcgKG9wZW4gbGlzdCkKCkNhbiB5b3UgdGVsbCBtZSB3aGljaCBv
bmUgaXMgbWlzc2luZyBhbmQgSSB3aWxsIHJlc2VuZCB0aGUgcGF0Y2ggdG8gaGltLgoKVGhhbmtz
Ckxpbg==

