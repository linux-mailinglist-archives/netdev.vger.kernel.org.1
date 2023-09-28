Return-Path: <netdev+bounces-36655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9361E7B1116
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 05:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2085A28186E
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 03:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A695232;
	Thu, 28 Sep 2023 03:10:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2891872
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 03:10:05 +0000 (UTC)
Received: from jari.cn (unknown [218.92.28.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECD5B94;
	Wed, 27 Sep 2023 20:10:03 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 28 Sep 2023 11:08:16
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date: Thu, 28 Sep 2023 11:08:16 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "KaiLong Wang" <wangkailong@jari.cn>
To: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wext.h: Clean up errors in wext.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7c5744ca.8aa.18ad9c22e75.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQAAfwBn+D0g7hRlZYC+AA--.636W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAIB2UT+K8AFQAHs9
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_PBL,RDNS_NONE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
ImZvbyAqIGJhciIgc2hvdWxkIGJlICJmb28gKmJhciIKClNpZ25lZC1vZmYtYnk6IEthaUxvbmcg
V2FuZyA8d2FuZ2thaWxvbmdAamFyaS5jbj4KLS0tCiBpbmNsdWRlL25ldC93ZXh0LmggfCA4ICsr
KystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L3dleHQuaCBiL2luY2x1ZGUvbmV0L3dleHQuaAppbmRl
eCBhYTE5MmE2NzAzMDQuLmEzYWFjNjQ4NzY1ZSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9uZXQvd2V4
dC5oCisrKyBiL2luY2x1ZGUvbmV0L3dleHQuaApAQCAtNDgsMTAgKzQ4LDEwIEBAIGludCBpb2N0
bF9wcml2YXRlX2NhbGwoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgc3RydWN0IGl3cmVxICppd3Is
CiBpbnQgY29tcGF0X3ByaXZhdGVfY2FsbChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCBzdHJ1Y3Qg
aXdyZXEgKml3ciwKIAkJCXVuc2lnbmVkIGludCBjbWQsIHN0cnVjdCBpd19yZXF1ZXN0X2luZm8g
KmluZm8sCiAJCQlpd19oYW5kbGVyIGhhbmRsZXIpOwotaW50IGl3X2hhbmRsZXJfZ2V0X3ByaXZh
dGUoc3RydWN0IG5ldF9kZXZpY2UgKgkJZGV2LAotCQkJICAgc3RydWN0IGl3X3JlcXVlc3RfaW5m
byAqCWluZm8sCi0JCQkgICB1bmlvbiBpd3JlcV9kYXRhICoJCXdycXUsCi0JCQkgICBjaGFyICoJ
CQlleHRyYSk7CitpbnQgaXdfaGFuZGxlcl9nZXRfcHJpdmF0ZShzdHJ1Y3QgbmV0X2RldmljZSAq
ZGV2LAorCQkJICAgc3RydWN0IGl3X3JlcXVlc3RfaW5mbyAqaW5mbywKKwkJCSAgIHVuaW9uIGl3
cmVxX2RhdGEgKndycXUsCisJCQkgICBjaGFyICpleHRyYSk7CiAjZWxzZQogI2RlZmluZSBpb2N0
bF9wcml2YXRlX2NhbGwgTlVMTAogI2RlZmluZSBjb21wYXRfcHJpdmF0ZV9jYWxsIE5VTEwKLS0g
CjIuMTcuMQo=

