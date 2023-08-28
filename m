Return-Path: <netdev+bounces-30969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EC278A481
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 04:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13BB280DC8
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 02:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11237643;
	Mon, 28 Aug 2023 02:13:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059B27E4
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 02:13:14 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25756132;
	Sun, 27 Aug 2023 19:12:46 -0700 (PDT)
Received: from kwepemm000004.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RYvCw4N0xzrSMt;
	Mon, 28 Aug 2023 10:10:36 +0800 (CST)
Received: from dggpeml500007.china.huawei.com (7.185.36.75) by
 kwepemm000004.china.huawei.com (7.193.23.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 28 Aug 2023 10:12:12 +0800
Received: from dggpeml500007.china.huawei.com ([7.185.36.75]) by
 dggpeml500007.china.huawei.com ([7.185.36.75]) with mapi id 15.01.2507.031;
 Mon, 28 Aug 2023 10:12:12 +0800
From: mengkanglai <mengkanglai2@huawei.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Fengtao (fengtao, Euler)" <fengtao40@huawei.com>, "Yanan (Euler)"
	<yanan@huawei.com>
Subject: ltp testcases failed due to commit cf3128a7aca
Thread-Topic: ltp testcases failed due to commit cf3128a7aca
Thread-Index: AdnZVQldr3VMVyCYRUKKPDyUsJEoDA==
Date: Mon, 28 Aug 2023 02:12:12 +0000
Message-ID: <dd2a5ae913a84a36bded3dfeb4dbe466@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.136.115.4]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

V2hlbiBJIHJ1biBsYXRlc3QgbHRwIHRlc3RjYXNlIHRlc3RjYXNlcy9uZXR3b3JrL3N0cmVzcy91
ZHAvdW5pLWJhc2ljL3VkcDYtdW5pLWJhc2ljMDcgd2l0aCBsYXRlc3Qga2VybmVsIDYuNSwgaXQg
ZmFpbGVkIGluIKGwbHRwYXBpY21kLmM6MTg4OiBGYWlsZWQgdG8gY29uZmlndXJlIFNBRC9TUEQg
b24gdGhlIGxvY2FsIGhvc3ShsS4NCkkgZm91bmQgdGhhdCB0aGUgcmVhc29uIGZvciBmYWlsdXJl
IHdhcyB0aGlzIGNvbW1hbmQ6DQpvdXRwdXRfaXBzZWNfY29uZiBzcmMgXA0KICAgICAgICAkSVBT
RUNfUFJPVE8gJElQU0VDX01PREUgJFNQSSAkbGhvc3RfYWRkciAkcmhvc3RfYWRkciBcDQogICAg
ICAgICAgICB8ICBzZXRrZXkgLWMgMj4mMSB8IHRlZSAkaXBzZWNfbG9nDQoNClRoaXMgY29tbWFu
ZCBldmVudHVhbGx5IHVzZSBzZXRrZXkgLWMgdG8gYWRkIHNwZGFkZCBlbnRyeSBmYWlsZWQ6DQpz
cGRhZGQgJHNyY19pcGFkZHIgJGRzdF9pcGFkZHIgYW55DQqhoaGhLVAgb3V0IGlwc2VjICRwcm90
b2NvbC90dW5uZWwvJHtzcmNfaXBhZGRyfS0ke2RzdF9pcGFkZHJ9L3VzZSA7IA0KDQpJdCByZXR1
cm5zIEludmFsaWQgYXJndW1lbnQuDQoNCkkgZm91bmQgdGhpcyBmYWlsZWQgZHVlIHRvIGNvbW1p
dCBjZjMxMjhhN2FjYShhZl9rZXk6IFJlamVjdCBvcHRpb25hbCB0dW5uZWwvQkVFVCBtb2RlIHRl
bXBsYXRlcyBpbiBvdXRib3VuZCBwb2xpY2llcyksIGlzIGxhdGVzdCBsdHAgdGVzdGNhc2VzIGFy
ZSBub3QgYWRhcHRlZD8gDQo=

