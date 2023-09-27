Return-Path: <netdev+bounces-36424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A527AFB01
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 08:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 054DCB20901
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 06:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FF11C289;
	Wed, 27 Sep 2023 06:25:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75C113FF1
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 06:25:22 +0000 (UTC)
Received: from jari.cn (unknown [218.92.28.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C0509C;
	Tue, 26 Sep 2023 23:25:20 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 14:24:03
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date: Wed, 27 Sep 2023 14:24:03 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: chenguohua@jari.cn
To: 3chas3@gmail.com
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] atm: Clean up errors in atm_tcp.h
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
Message-ID: <32b04d0b.86a.18ad54f1174.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQAAfwBn+D2DyhNlPee9AA--.626W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8ANAAAsc
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_PBL,RDNS_NONE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
c3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCgpTaWduZWQtb2ZmLWJ5OiBH
dW9IdWEgQ2hlbmcgPGNoZW5ndW9odWFAamFyaS5jbj4KLS0tCiBpbmNsdWRlL2xpbnV4L2F0bV90
Y3AuaCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYXRtX3RjcC5oIGIvaW5jbHVkZS9saW51eC9h
dG1fdGNwLmgKaW5kZXggMjU1ODQzOWQ4NDliLi4yNjM1OTY1ZTg5ODIgMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvbGludXgvYXRtX3RjcC5oCisrKyBiL2luY2x1ZGUvbGludXgvYXRtX3RjcC5oCkBAIC0x
Myw3ICsxMyw3IEBAIHN0cnVjdCBhdG1fdmNjOwogc3RydWN0IG1vZHVsZTsKIAogc3RydWN0IGF0
bV90Y3Bfb3BzIHsKLQlpbnQgKCphdHRhY2gpKHN0cnVjdCBhdG1fdmNjICp2Y2MsaW50IGl0Zik7
CisJaW50ICgqYXR0YWNoKShzdHJ1Y3QgYXRtX3ZjYyAqdmNjLCBpbnQgaXRmKTsKIAlpbnQgKCpj
cmVhdGVfcGVyc2lzdGVudCkoaW50IGl0Zik7CiAJaW50ICgqcmVtb3ZlX3BlcnNpc3RlbnQpKGlu
dCBpdGYpOwogCXN0cnVjdCBtb2R1bGUgKm93bmVyOwotLSAKMi4xNy4xCg==

