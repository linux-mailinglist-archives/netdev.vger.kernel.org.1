Return-Path: <netdev+bounces-23030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A804976A717
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 04:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD16128180C
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 02:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC53AEA3;
	Tue,  1 Aug 2023 02:40:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C170C7E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 02:40:35 +0000 (UTC)
X-Greylist: delayed 51997 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Jul 2023 19:40:32 PDT
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9301B1BEE;
	Mon, 31 Jul 2023 19:40:32 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.60] ) by
 ajax-webmail-mail-app4 (Coremail) ; Tue, 1 Aug 2023 10:40:10 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.60]
Date: Tue, 1 Aug 2023 10:40:10 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	fw@strlen.de, yang.lee@linux.alibaba.com, jgg@ziepe.ca, 
	markzhang@nvidia.com, phaddad@nvidia.com, yuancan@huawei.com, 
	ohartoov@nvidia.com, chenzhongjin@huawei.com, aharonl@nvidia.com, 
	leon@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v1 1/2] netlink: let len field used to parse
 type-not-care nested attrs
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230731193118.67d79f7b@kernel.org>
References: <20230731121247.3972783-1-linma@zju.edu.cn>
 <20230731120326.6bdd5bf9@kernel.org>
 <38179c76.f308d.189aed2db99.Coremail.linma@zju.edu.cn>
 <20230731193118.67d79f7b@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <438e3303.f31cc.189aef79e80.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgB3fxeLcMhkSC1rCg--.55606W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwUOEmTIYfoAqwACsE
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGVsbG8gSmFrdWIsCgo+IAo+IFlvdXIgaW5pdGlhbCBmaXggd2FzIHBlcmZlY3RseSBmaW5lLgo+
IAo+IFdlIGRvIG5lZWQgYSBzb2x1dGlvbiBmb3IgYSBub3JtYWwgbXVsdGktYXR0ciBwYXJzZSwg
YnV0IHRoYXQncyBub3QgCj4gdGhlIGNhc2UgaGVyZS4KCkNvb2wg8J+YjgoKVGhhbmtzCkxpbg==


