Return-Path: <netdev+bounces-17151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD94A75098D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C806F1C20DE9
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757F02AB3C;
	Wed, 12 Jul 2023 13:26:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DC8100AE
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:26:37 +0000 (UTC)
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71118C0;
	Wed, 12 Jul 2023 06:26:34 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.54] ) by
 ajax-webmail-mail-app4 (Coremail) ; Wed, 12 Jul 2023 21:26:09 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.54]
Date: Wed, 12 Jul 2023 21:26:09 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Simon Horman" <simon.horman@corigine.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1] netfilter: conntrack: validate cta_ip via parsing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <ZK6nwn99T8NAP6pC@corigine.com>
References: <20230711032257.3561166-1-linma@zju.edu.cn>
 <ZK6nwn99T8NAP6pC@corigine.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <65fa5eb3.cd95a.1894a47d75b.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgB3fxfyqa5kQMgeCQ--.40523W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwIEEmSg1PcD-QAusg
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUCw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGVsbG8gU2ltb24sCgo+IAo+IEkgZG9uJ3QgdGhpbmsgdGhpcyB3YXJyYW50cyBhIGZpeGVzIHRh
ZywgYXMgaXQncyBub3QgZml4aW5nIGFueQo+IHVzZXItdmlzaWJsZSBiZWhhdmlvdXIuIFJhdGhl
ciwgaXQgaXMgYSBjbGVhbi11cC4KPiAKCk15IGJhZCwgSSB3aWxsIHJlc2VuZCBvbmUgd2l0aCBh
ZGp1c3RlZCBtZXNzYWdlLgoKUmVnYXJkcwpMaW4=

