Return-Path: <netdev+bounces-14691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072BA74322E
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 03:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355D01C20B35
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 01:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F9F15A6;
	Fri, 30 Jun 2023 01:20:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E8B17C6
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 01:20:53 +0000 (UTC)
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net (zg8tmtu5ljg5lje1ms4xmtka.icoremail.net [159.89.151.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 953C62703
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 18:20:49 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.63] ) by
 ajax-webmail-mail-app4 (Coremail) ; Fri, 30 Jun 2023 09:20:26 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.63]
Date: Fri, 30 Jun 2023 09:20:26 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Simon Horman" <simon.horman@corigine.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, tgraf@suug.ch
Subject: Re: [PATCH v1] net: xfrm: Amend XFRMA_SEC_CTX nla_policy structure
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <ZJ3jSTQFww87vLYn@corigine.com>
References: <20230627055255.1233458-1-linma@zju.edu.cn>
 <ZJ3jSTQFww87vLYn@corigine.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <51ed0352.ae7ad.18909e31cb4.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgAHTAnaLZ5kJHj6Bw--.28981W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwIBEmSc4HcRfAAEsU
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGkgU2ltb24sCgo+IAo+IEhpIExpbiBNYSwKPiAKPiBhIG1pbm9yIG5pdCB2aWEgY2hlY2twYXRj
aC5wbCAtLWNvZGVzcGVsbDogZXhwdGVjdGVkIC0+IGV4cGVjdGVkCj4gCj4gLi4uCgpDb29sLCBJ
IHdpbGwgcmVtZW1iZXIgdG8gZG8gdGhpcyBzaW5jZSBub3csIHRoYW5rcy4gOikKClJlZ2FyZHMK
TGlu

