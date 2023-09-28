Return-Path: <netdev+bounces-36658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4768C7B111D
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 05:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id D0B36B20982
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 03:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2145237;
	Thu, 28 Sep 2023 03:16:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63CE5235
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 03:16:05 +0000 (UTC)
Received: from jari.cn (unknown [218.92.28.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8EF394;
	Wed, 27 Sep 2023 20:16:03 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 28 Sep 2023 11:14:40
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date: Thu, 28 Sep 2023 11:14:40 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "KaiLong Wang" <wangkailong@jari.cn>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: snmp: Clean up errors in snmp.h
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
Message-ID: <55bdec01.8ad.18ad9c80cca.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQAAfwC3VUCg7xRlEIG+AA--.629W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAIB2UT+K8AFwAHs-
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
c3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCkVSUk9SOiBzcGFjZXMgcmVx
dWlyZWQgYXJvdW5kIHRoYXQgJz09JyAoY3R4OlZ4VikKClNpZ25lZC1vZmYtYnk6IEthaUxvbmcg
V2FuZyA8d2FuZ2thaWxvbmdAamFyaS5jbj4KLS0tCiBpbmNsdWRlL25ldC9zbm1wLmggfCA0ICsr
LS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9uZXQvc25tcC5oIGIvaW5jbHVkZS9uZXQvc25tcC5oCmluZGV4IDQ2
OGE2NzgzNmUyZi4uOTJlOTJiZWJkZTJjIDEwMDY0NAotLS0gYS9pbmNsdWRlL25ldC9zbm1wLmgK
KysrIGIvaW5jbHVkZS9uZXQvc25tcC5oCkBAIC0zMSw3ICszMSw3IEBAIHN0cnVjdCBzbm1wX21p
YiB7CiAJaW50IGVudHJ5OwogfTsKIAotI2RlZmluZSBTTk1QX01JQl9JVEVNKF9uYW1lLF9lbnRy
eSkJewlcCisjZGVmaW5lIFNOTVBfTUlCX0lURU0oX25hbWUsIF9lbnRyeSkJewlcCiAJLm5hbWUg
PSBfbmFtZSwJCQkJXAogCS5lbnRyeSA9IF9lbnRyeSwJCQlcCiB9CkBAIC0xNTUsNyArMTU1LDcg
QEAgc3RydWN0IGxpbnV4X3Rsc19taWIgewogCX0gd2hpbGUgKDApCiAKIAotI2lmIEJJVFNfUEVS
X0xPTkc9PTMyCisjaWYgQklUU19QRVJfTE9ORyA9PSAzMgogCiAjZGVmaW5lIF9fU05NUF9BRERf
U1RBVFM2NChtaWIsIGZpZWxkLCBhZGRlbmQpIAkJCQlcCiAJZG8gewkJCQkJCQkJXAotLSAKMi4x
Ny4xCg==

