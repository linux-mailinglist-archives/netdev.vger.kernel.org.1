Return-Path: <netdev+bounces-14731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6162B7436D1
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 10:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84DB280FE6
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 08:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C246A92A;
	Fri, 30 Jun 2023 08:16:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5DDAD21
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 08:16:25 +0000 (UTC)
X-Greylist: delayed 24938 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Jun 2023 01:16:22 PDT
Received: from zg8tmty3ljk5ljewns4xndka.icoremail.net (zg8tmty3ljk5ljewns4xndka.icoremail.net [167.99.105.149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C19791FCC
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 01:16:22 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.63] ) by
 ajax-webmail-mail-app4 (Coremail) ; Fri, 30 Jun 2023 16:16:02 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.63]
Date: Fri, 30 Jun 2023 16:16:02 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Steffen Klassert" <steffen.klassert@secunet.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	tgraf@suug.ch, simon.horman@corigine.com
Subject: Re: [PATCH v3] net: xfrm: Amend XFRMA_SEC_CTX nla_policy structure
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <ZJ6L+chlwapjZO+A@gauss3.secunet.de>
References: <20230630012241.2822225-1-linma@zju.edu.cn>
 <ZJ6L+chlwapjZO+A@gauss3.secunet.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4c72597b.afcdf.1890b5f9c05.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgB3ybFDj55kSloECA--.30724W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwIBEmSc4HcRfAAIsY
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGVsbG8gU3RlZmZlbiwKCj4gPiArCVtYRlJNQV9NVElNRVJfVEhSRVNIXQk9IHsgLnR5cGUgPSBO
TEFfVTMyIH0sCj4gCj4gVGhlIGFib3ZlIGxpbmUgaXMgYXBwYXJlbnRseSBtaXNzaW5nLCBidXQg
ZG9lcyBpdCByZWFsbHkgYmVsb25nIHRvIHRoaXMKPiBwYXRjaD8gQXQgbGVhc3QgaXQgaXMgbm90
IG1lbnRpb25lZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuCgpOb3BlLCBteSBiYWQsIGl0IGlzIGFi
b3V0IGFub3RoZXIgb25nb2luZyBwYXRjaC4gVC5UCgpTb3JyeSBmb3IgdGhlIGNvbmZ1c2luZyBw
YXRjaCwgd2lsbCByZXNlbmQgaXQuCgpSZWdhcmRzCkxpbg==

