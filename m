Return-Path: <netdev+bounces-36398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A137AF8C0
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 05:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 46B122810B7
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 03:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3088633D6;
	Wed, 27 Sep 2023 03:40:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7395F28F2
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 03:40:45 +0000 (UTC)
X-Greylist: delayed 101 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Sep 2023 20:40:44 PDT
Received: from jari.cn (unknown [218.92.28.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02E0472A5;
	Tue, 26 Sep 2023 20:40:43 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.31] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 11:37:30
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.31]
Date: Wed, 27 Sep 2023 11:37:30 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: chenguohua@jari.cn
To: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netdev: Clean up errors in netdevice.h
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
Message-ID: <2de2b453.859.18ad4b697c8.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQAAfwDXaD56oxNlRNC9AA--.563W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAFEWFEYxtJMwAFs3
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
dGhhdCBvcGVuIGJyYWNlIHsgc2hvdWxkIGJlIG9uIHRoZSBwcmV2aW91cyBsaW5lCkVSUk9SOiBz
cGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJz0nIChjdHg6VnhWKQoKU2lnbmVkLW9mZi1ieTog
R3VvSHVhIENoZW5nIDxjaGVuZ3VvaHVhQGphcmkuY24+Ci0tLQogaW5jbHVkZS9saW51eC9uZXRk
ZXZpY2UuaCB8IDUgKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9uZXRkZXZpY2UuaCBiL2luY2x1
ZGUvbGludXgvbmV0ZGV2aWNlLmgKaW5kZXggN2U1MjBjMTRlYjhjLi41NTEzNzJmNDJiZTYgMTAw
NjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvbmV0ZGV2aWNlLmgKKysrIGIvaW5jbHVkZS9saW51eC9u
ZXRkZXZpY2UuaApAQCAtMjMwNiw3ICsyMzA2LDcgQEAgc3RydWN0IG5ldF9kZXZpY2UgewogCiAJ
c3RydWN0IGxpc3RfaGVhZAlsaW5rX3dhdGNoX2xpc3Q7CiAKLQllbnVtIHsgTkVUUkVHX1VOSU5J
VElBTElaRUQ9MCwKKwllbnVtIHsgTkVUUkVHX1VOSU5JVElBTElaRUQgPSAwLAogCSAgICAgICBO
RVRSRUdfUkVHSVNURVJFRCwJLyogY29tcGxldGVkIHJlZ2lzdGVyX25ldGRldmljZSAqLwogCSAg
ICAgICBORVRSRUdfVU5SRUdJU1RFUklORywJLyogY2FsbGVkIHVucmVnaXN0ZXJfbmV0ZGV2aWNl
ICovCiAJICAgICAgIE5FVFJFR19VTlJFR0lTVEVSRUQsCS8qIGNvbXBsZXRlZCB1bnJlZ2lzdGVy
IHRvZG8gKi8KQEAgLTI1MDEsOCArMjUwMSw3IEBAIHN0cnVjdCBuZXRkZXZfcXVldWUgKm5ldGRl
dl9nZXRfdHhfcXVldWUoY29uc3Qgc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKIH0KIAogc3RhdGlj
IGlubGluZSBzdHJ1Y3QgbmV0ZGV2X3F1ZXVlICpza2JfZ2V0X3R4X3F1ZXVlKGNvbnN0IHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYsCi0JCQkJCQkgICAgY29uc3Qgc3RydWN0IHNrX2J1ZmYgKnNrYikK
LXsKKwkJCQkJCSAgICBjb25zdCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKSB7CiAJcmV0dXJuIG5ldGRl
dl9nZXRfdHhfcXVldWUoZGV2LCBza2JfZ2V0X3F1ZXVlX21hcHBpbmcoc2tiKSk7CiB9CiAKLS0g
CjIuMTcuMQo=

