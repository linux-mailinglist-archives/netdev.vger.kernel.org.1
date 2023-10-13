Return-Path: <netdev+bounces-40581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9921F7C7B53
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 03:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271891F207C0
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 01:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C15181D;
	Fri, 13 Oct 2023 01:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBF4A29
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 01:49:12 +0000 (UTC)
Received: from jari.cn (unknown [218.92.28.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1953C0;
	Thu, 12 Oct 2023 18:49:10 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 09:47:22
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date: Fri, 13 Oct 2023 09:47:22 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: chenguohua@jari.cn
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] etherdevice: Clean up errors in etherdevice.h
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
Message-ID: <22a751c6.93b.18b26b780d4.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQAAfwDnhD+qoShlS9bBAA--.643W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAAEWUjyrIAGQAQsn
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
	T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
dGhhdCBvcGVuIGJyYWNlIHsgc2hvdWxkIGJlIG9uIHRoZSBwcmV2aW91cyBsaW5lCgpTaWduZWQt
b2ZmLWJ5OiBHdW9IdWEgQ2hlbmcgPGNoZW5ndW9odWFAamFyaS5jbj4KLS0tCiBpbmNsdWRlL2xp
bnV4L2V0aGVyZGV2aWNlLmggfCAzICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZXRoZXJkZXZpY2Uu
aCBiL2luY2x1ZGUvbGludXgvZXRoZXJkZXZpY2UuaAppbmRleCAyMjQ2NDVmMTdjMzMuLjMwZmMz
YmMwZWIwOSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9ldGhlcmRldmljZS5oCisrKyBiL2lu
Y2x1ZGUvbGludXgvZXRoZXJkZXZpY2UuaApAQCAtNjcsOCArNjcsNyBAQCBzdHJ1Y3Qgc2tfYnVm
ZiAqZXRoX2dyb19yZWNlaXZlKHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQsIHN0cnVjdCBza19idWZm
ICpza2IpOwogaW50IGV0aF9ncm9fY29tcGxldGUoc3RydWN0IHNrX2J1ZmYgKnNrYiwgaW50IG5o
b2ZmKTsKIAogLyogUmVzZXJ2ZWQgRXRoZXJuZXQgQWRkcmVzc2VzIHBlciBJRUVFIDgwMi4xUSAq
Lwotc3RhdGljIGNvbnN0IHU4IGV0aF9yZXNlcnZlZF9hZGRyX2Jhc2VbRVRIX0FMRU5dIF9fYWxp
Z25lZCgyKSA9Ci17IDB4MDEsIDB4ODAsIDB4YzIsIDB4MDAsIDB4MDAsIDB4MDAgfTsKK3N0YXRp
YyBjb25zdCB1OCBldGhfcmVzZXJ2ZWRfYWRkcl9iYXNlW0VUSF9BTEVOXSBfX2FsaWduZWQoMikg
PSB7IDB4MDEsIDB4ODAsIDB4YzIsIDB4MDAsIDB4MDAsIDB4MDAgfTsKICNkZWZpbmUgZXRoX3N0
cF9hZGRyIGV0aF9yZXNlcnZlZF9hZGRyX2Jhc2UKIAogLyoqCi0tIAoyLjE3LjEK

