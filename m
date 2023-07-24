Return-Path: <netdev+bounces-20502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 030F475FBE5
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 18:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653E92816E1
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 16:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6E3F4F5;
	Mon, 24 Jul 2023 16:23:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F90F9D8
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 16:23:32 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623BFFF
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1690215780; x=1690820580; i=ps.report@gmx.net;
 bh=WjvR59b9rmoDdcABLWnQyaooMFewsRQs8pLeavrYCNY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=K6BfCgH1spMZpSEwCwYMQvDJAG/5wzw2xztIHOXHLfNCO/e12+A9BFAr3uWjFtoRHScui7w
 UZB3hamsi7XCBF+CpqjGO5NL9taFg6P3LTATVvymBfBMHJLVCfjvCUwY9sIODkS6bIXU64jh6
 OeDh3csYDSedlcL7FCNh/uWtMWAAPh9JlfLLHshRJR7l/xSSUKz1QwaLNlxbg5Dpb/i+6Ue0v
 QhFfvzf3lvQ+hB9EinPxfILVbndmxmrIb1MvQIdLCstOnd8+PDZfgYPWervyQ2UkoQPXMZLsJ
 m7RM9OxLQcwcxQ/CJ2Oot+9A1OW0g0iRu6Z+r5oGzymm5ozWq7ng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([62.216.209.33]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbkv-1qYn9z0k6l-00P9Ef; Mon, 24
 Jul 2023 18:23:00 +0200
From: Peter Seiderer <ps.report@gmx.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <simon.horman@corigine.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Richard Gobert <richardbgobert@gmail.com>,
	Patrick Ohly <patrick.ohly@intel.com>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v2] net: skbuff: remove unused HAVE_HW_TIME_STAMP feature define
Date: Mon, 24 Jul 2023 18:22:55 +0200
Message-ID: <20230724162255.14087-1-ps.report@gmx.net>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:Omfcl7bz8QzN7zDln/EHEj7XJ2cXUQNbBxwYE6PQ56RoZHpkTU/
 376gGfCsL+HlbC9qVaaPrUsbBMZAYAavz68S8I4FOZUCyNhxwdht+I+ieyGJwgLpYPpBENH
 KbIjNP7IiXjJEy8yJiPiU2wzMJvm7yR39XPpK51q7Z5k0Df9jk7W9l2nJZIPGdrj8OiEOwu
 gqKDk+qLjxTZMFDFH2gcg==
UI-OutboundReport: notjunk:1;M01:P0:PhdQyDR/UEM=;ssCJODtcTwCIhBdFIwGPV8v6per
 HN5MnPzsVh/Lz7ygtPpkVWrMZDq6nEI8wFD47NwFzn4R8KlkXpWutL9l4wWmqTLgSQMVMclFl
 SwtEJT+f53W8LlPCV5GLhyQ4P9wNEZ1U+IOrTcQ13g3Kfj3pJ5ZPjwnNeuAG1m0lqTuKQeaXg
 0k1hFmiB79I1ovrHQG0XE5ia2Gc1fyf8vxwP5wkea6kfJhp5t7pOfPUmZLEwAR1Godrc+ANTE
 lMvgLl1KcFoHj6f8EGRe1i/yIzfzbhe4AyDkWjXLa/cRVCGnXobP6rtdw00leHfFmPse2S+gk
 OtcP+mK4eJOJaipbWme33QhR0uetpAxBVBM+NCrSa2eogbAFSlzZGIcGo8foMD3mmfgXMINBl
 T+HJV5L2bSh1/Sr9Lf6cm242W5FjldL97TaOVdhSvNFqzId1xHV8TpoJPqFYDhLbFLpdlIohJ
 NYIS3uJTTPotnVVz1ehXy9W/R/hy6g48e+xu4BhI/Jtkj1rIrN5wkmKOqAj5/815FDBEwESqF
 DwOUth8dTKpNLlCv9PFc0f2yn06QhrXEC6jBZCWHA7NqZCJBSBZo0Zn9Ff6wb87EGi7mml8eN
 rDIkN4Gct4sCPiXk16j3Z3VHPT7gp/VNnuNYsLSVvb9eTyWeZpDj9pesC087wKbvc/DiUim+4
 pyqiTNMvWcIt0pyqD/7upwl3QaBQwgdEqt82oPZPLmmpw/nm+LSJwID+JDiqT4VFwtfWtVAWb
 Cbg/sjH4ZsYoytHCZg3BUPluKncBZYsE5fjXUm0+pWHv7TYeYl1bn2iO/6h9wl2/p8wPuAQqr
 o921770MqDnEYYKXhWOeRt/EG98hulpOrBpZF89jYoYQJX9V1n1MTzSTXQ0lrCBAJYeTP3q3h
 n/aCw2WT0AqBG8aP31oIqUzxSDGNalP/dlC5+lD0O9lO+VIY6iQ+PFgDmj1TKrL11L0d3KMga
 nVoD1g==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

UmVtb3ZlIHVudXNlZCBIQVZFX0hXX1RJTUVfU1RBTVAgZmVhdHVyZSBkZWZpbmUgKGludHJvZHVj
ZWQgYnkKY29tbWl0IGFjNDVmNjAyZWUzZCAoIm5ldDogaW5mcmFzdHJ1Y3R1cmUgZm9yIGhhcmR3
YXJlIHRpbWUgc3RhbXBpbmciKS4KClNpZ25lZC1vZmYtYnk6IFBldGVyIFNlaWRlcmVyIDxwcy5y
ZXBvcnRAZ214Lm5ldD4KLS0tCkNoYW5nZXMgdjEgLT4gdjI6CiAgLSBzcGVjaWZ5IHRhcmdldCB0
cmVlIG5ldC1uZXh0CiAgLSBzdWJqZWN0IGNoYW5nZSBmcm9tICdza2J1ZmY6IC4uLicgdG8gJ25l
dDogc2tidWZmOiAuLi4nCiAgLSBhZGQgQ0MgbmV0ZGV2QHZnZXIua2VybmVsLm9yZyAoaW5zdGVh
ZCBvZiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnKQogIC0gYWRkIENDIFBhdHJpY2sgT2hs
eSA8cGF0cmljay5vaGx5QGludGVsLmNvbT4KLS0tCiBpbmNsdWRlL2xpbnV4L3NrYnVmZi5oIHwg
MiAtLQogMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9za2J1ZmYuaCBiL2luY2x1ZGUvbGludXgvc2tidWZmLmgKaW5kZXggZmFhYmEwNTBm
ODQzLi4xNmE0OWJhNTM0ZTQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvc2tidWZmLmgKKysr
IGIvaW5jbHVkZS9saW51eC9za2J1ZmYuaApAQCAtNDQxLDggKzQ0MSw2IEBAIHN0YXRpYyBpbmxp
bmUgYm9vbCBza2JfZnJhZ19tdXN0X2xvb3Aoc3RydWN0IHBhZ2UgKnApCiAJICAgICBjb3BpZWQg
Kz0gcF9sZW4sIHArKywgcF9vZmYgPSAwLAkJCQlcCiAJICAgICBwX2xlbiA9IG1pbl90KHUzMiwg
Zl9sZW4gLSBjb3BpZWQsIFBBR0VfU0laRSkpCQlcCiAKLSNkZWZpbmUgSEFWRV9IV19USU1FX1NU
QU1QCi0KIC8qKgogICogc3RydWN0IHNrYl9zaGFyZWRfaHd0c3RhbXBzIC0gaGFyZHdhcmUgdGlt
ZSBzdGFtcHMKICAqIEBod3RzdGFtcDoJCWhhcmR3YXJlIHRpbWUgc3RhbXAgdHJhbnNmb3JtZWQg
aW50byBkdXJhdGlvbgotLSAKMi40MS4wCgo=

