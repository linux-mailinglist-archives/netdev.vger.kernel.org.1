Return-Path: <netdev+bounces-21228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FBC762EAE
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 09:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C714F281B87
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 07:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86809471;
	Wed, 26 Jul 2023 07:49:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE71C9456
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:49:49 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B89A7687;
	Wed, 26 Jul 2023 00:49:35 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.60] ) by
 ajax-webmail-mail-app4 (Coremail) ; Wed, 26 Jul 2023 15:49:02 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.60]
Date: Wed, 26 Jul 2023 15:49:02 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Nikolay Aleksandrov" <razor@blackwall.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, idosch@nvidia.com, lucien.xin@gmail.com, 
	liuhangbin@gmail.com, edwin.peer@broadcom.com, jiri@resnulli.us, 
	md.fahad.iqbal.polash@intel.com, anirudh.venkataramanan@intel.com, 
	jeffrey.t.kirsher@intel.com, neerav.parikh@intel.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtnetlink: let rtnl_bridge_setlink checks
 IFLA_BRIDGE_MODE length
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <6a177bb3-0ee4-f453-695b-d9bdd441aa2c@blackwall.org>
References: <20230725055706.498774-1-linma@zju.edu.cn>
 <6a177bb3-0ee4-f453-695b-d9bdd441aa2c@blackwall.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7670876b.ea0b8.189912c3a92.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgBHjAnvz8BkdjkkCg--.52320W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwIIEmTAePoLZAAAsS
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGkgTmlrb2xheSwKCj4gCj4gUGF0Y2ggbG9va3MgZ29vZCBub3csIHlvdSBzaG91bGQgcHJvYmFi
bHkgcmVtb3ZlIHRoZSBleHRyYSBjaGVja3MgZG9uZQo+IGJ5IGVhY2ggZHJpdmVyIHRoYXQgYXJl
IG5vdyB1bm5lY2Vzc2FyeSAobmV0LW5leHQgbWF0ZXJpYWwpLiBBcyBIYW5nYmluCj4gY29tbWVu
dGVkIHlvdSBzaG91bGQgdGFyZ2V0IHRoaXMgZml4IGF0IC1uZXQsIHdpdGggdGhhdDoKPiAKPiBB
Y2tlZC1ieTogTmlrb2xheSBBbGVrc2FuZHJvdiA8cmF6b3JAYmxhY2t3YWxsLm9yZz4KCkNvb2ws
IEkgYWdyZWUgd2l0aCBIYW5nYmluIHRoYXQgYW5vdGhlciBwYXRjaCB3aGljaCByZW1vdmVzIHRo
ZSByZWR1bmRhbnQKY2hlY2tzIGluIGRyaXZlciBpcyBuZWVkZWQuCgpCdXQgSSBoYXZlIGEgc2lt
cGxlIHF1ZXN0aW9uLiBJIHdpbGwgc2VuZCB0aGlzIHBhdGNoIHRvIG5ldCBvbmUgYW5kIGFub3Ro
ZXIKdG8gbmV0LW5leHQgb25lLiBIb3cgY2FuIEkgZW5zdXJlIHRoZSBsYXR0ZXIgb25lIGRlcGVu
ZHMgb24gdGhlIGZvcm1lciBvbmU/Ck9yIHNob3VsZCBJIHNlbmQgYSBwYXRjaCBzZXJpZXMgdG8g
bmV0LW5leHQgdGhhdCBjb250YWlucyB0aGUgZm9ybWVyIG9uZSA6KQooSSBjdXJyZW50bHkgY2hv
b3NlIHRoZSBtZXRob2QgMiBhbmQgcGxlYXNlIGxldCBtZSBrbm93IGlmIEkgZG8gdGhpcyB3cm9u
ZykKClJlZ2FyZHMKTGlu

