Return-Path: <netdev+bounces-19893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9174F75CB23
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 17:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8357E1C21718
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 15:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2F827F3D;
	Fri, 21 Jul 2023 15:13:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2527F12
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 15:13:43 +0000 (UTC)
X-Greylist: delayed 1189 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Jul 2023 08:13:20 PDT
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EEE635AB;
	Fri, 21 Jul 2023 08:13:19 -0700 (PDT)
Received: from linma$zju.edu.cn ( [10.181.227.232] ) by
 ajax-webmail-mail-app4 (Coremail) ; Fri, 21 Jul 2023 22:53:10 +0800
 (GMT+08:00)
X-Originating-IP: [10.181.227.232]
Date: Fri, 21 Jul 2023 22:53:10 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Simon Horman" <simon.horman@corigine.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] xfrm: add NULL check in xfrm_update_ae_params
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <ZLqTe9XroSlOs+39@corigine.com>
References: <20230721014411.2407082-1-linma@zju.edu.cn>
 <ZLqTe9XroSlOs+39@corigine.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4c1a89e2.e2292.18978f0bf57.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgAHTAnWm7pkf+nPCQ--.49268W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwUDEmS54XkBxQAEsS
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUCw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGVsbG8gU2ltb24sCgo+IAo+IG5pdDogaW1wZWxlbWVudGF0aW9uIC0+IGltcGxlbWVudGF0aW9u
Cj4gCj4gLi4uCgpPb29vcHMsIHNvIHNvcnJ5LiA6TwpIYXZlIHNlbnQgdGhlIHNlY29uZCB2ZXJz
aW9uIG9mIHRoaXMgcGF0Y2guIFRoYW5rcyEgSGF2ZSBhIGdyZWF0IHdlZWtlbmQuCgpSZWdhcmRz
Ckxpbg==

