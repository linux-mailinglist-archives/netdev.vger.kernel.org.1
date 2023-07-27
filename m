Return-Path: <netdev+bounces-21671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9467642D1
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 02:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11DC1C21495
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 00:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E06EC3;
	Thu, 27 Jul 2023 00:03:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958CCEBE
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 00:03:47 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A3069C;
	Wed, 26 Jul 2023 17:03:43 -0700 (PDT)
Received: from linma$zju.edu.cn ( [10.181.249.112] ) by
 ajax-webmail-mail-app2 (Coremail) ; Thu, 27 Jul 2023 08:03:17 +0800
 (GMT+08:00)
X-Originating-IP: [10.181.249.112]
Date: Thu, 27 Jul 2023 08:03:17 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Nikolay Aleksandrov" <razor@blackwall.org>, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, idosch@nvidia.com, 
	lucien.xin@gmail.com, liuhangbin@gmail.com, edwin.peer@broadcom.com, 
	jiri@resnulli.us, md.fahad.iqbal.polash@intel.com, 
	anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, 
	neerav.parikh@intel.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtnetlink: let rtnl_bridge_setlink checks
 IFLA_BRIDGE_MODE length
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230726084420.1bf95ef9@kernel.org>
References: <20230725055706.498774-1-linma@zju.edu.cn>
 <6a177bb3-0ee4-f453-695b-d9bdd441aa2c@blackwall.org>
 <7670876b.ea0b8.189912c3a92.Coremail.linma@zju.edu.cn>
 <20230726084420.1bf95ef9@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2b14aaf4.e65a0.18994a82f19.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:by_KCgBnEZxFtMFk6q+iCg--.43986W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwIIEmTAePoLZAAdsP
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGkgSmFrdWIsCgo+IAo+IFlvdSdsbCBuZWVkIHRvIHdhaXQgZm9yIHRoZSBwYXRjaCB0byBwcm9w
YWdhdGUgYmVmb3JlIHBvc3RpbmcuCj4gT3VyIHRyZWVzIG1lcmdlIGVhY2ggVGh1cnNkYXksIHNv
IGlmIHlvdSBwb3N0IG9uIEZyaWRheSB0aGUgZml4Cj4gc2hvdWxkIGJlIGluIG5ldC1uZXh0LgoK
Q29vbCwgSSB1bmRlcnN0YW5kIG5vdy4gVGhhbmtzIQoKUmVnYXJkcwpMaW4=

