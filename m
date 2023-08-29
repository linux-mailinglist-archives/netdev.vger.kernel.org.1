Return-Path: <netdev+bounces-31152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3954A78BEDA
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 08:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590D91C209B2
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 06:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53A210E4;
	Tue, 29 Aug 2023 06:55:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA498EDA
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 06:55:24 +0000 (UTC)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEDDC0;
	Mon, 28 Aug 2023 23:55:22 -0700 (PDT)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id D9EB61046D9E;
	Tue, 29 Aug 2023 09:55:20 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru D9EB61046D9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1693292121; bh=TxxxUsUyt8BnEAKOymmzZVUoiWJkUCxBRXo4PSXMW54=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=hbvWGlafR6SJW6K1U+QGw/kxXF0e3Br9J8NDjFjT7JX/IzWo2ryfyx1v0cpXrsuGN
	 JHcWuN1sCIi4Bw4G9UD4hJ3hVPlyAhluBGvSt4w6XZLDtmRiD7YXH/zhdXm4LYnCNb
	 biF9crGqEMRtKXqv95kFGFfCzErPRcSSza9t+T38=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id D788A3156D42;
	Tue, 29 Aug 2023 09:55:20 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: Re: [PATCH net] ipv4: igmp: Remove redundant comparison in
 igmp_mcf_get_next()
Thread-Topic: [PATCH net] ipv4: igmp: Remove redundant comparison in
 igmp_mcf_get_next()
Thread-Index: AQHZ2kXG9mn6S9YqqECy9pm1MtVZqw==
Date: Tue, 29 Aug 2023 06:55:20 +0000
Message-ID: <1849f80f-c717-557e-056a-795dae7e0c32@infotecs.ru>
References: <20230828085926.424703-1-Ilia.Gavrilov@infotecs.ru>
 <fea6db56-3a01-b7c8-b800-a6c885e99feb@kernel.org>
In-Reply-To: <fea6db56-3a01-b7c8-b800-a6c885e99feb@kernel.org>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.17.0.10]
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-ID: <991B8407AEEF014494350B9614C1CF1F@infotecs.ru>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2023/08/29 05:18:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/08/29 04:09:00 #21767055
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gOC8yOS8yMyAwNTo0NSwgRGF2aWQgQWhlcm4gd3JvdGU6DQo+IE9uIDgvMjgvMjMgMzowMSBB
TSwgR2F2cmlsb3YgSWxpYSB3cm90ZToNCj4+IFRoZSAnc3RhdGUtPmltJyB2YWx1ZSB3aWxsIGFs
d2F5cyBiZSBub24temVybyBhZnRlcg0KPj4gdGhlICd3aGlsZScgc3RhdGVtZW50LCBzbyB0aGUg
Y2hlY2sgY2FuIGJlIHJlbW92ZWQuDQo+Pg0KPj4gRm91bmQgYnkgSW5mb1RlQ1Mgb24gYmVoYWxm
IG9mIExpbnV4IFZlcmlmaWNhdGlvbiBDZW50ZXINCj4+IChsaW51eHRlc3Rpbmcub3JnKSB3aXRo
IFNWQUNFLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEdhdnJpbG92IElsaWEgPElsaWEuR2F2cmls
b3ZAaW5mb3RlY3MucnU+DQo+PiAtLS0NCj4+ICAgbmV0L2lwdjQvaWdtcC5jIHwgMiAtLQ0KPj4g
ICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvbmV0
L2lwdjQvaWdtcC5jIGIvbmV0L2lwdjQvaWdtcC5jDQo+PiBpbmRleCA0OGZmNWYxM2U3OTcuLjZl
YmYwNjg4NjUyNyAxMDA2NDQNCj4+IC0tLSBhL25ldC9pcHY0L2lnbXAuYw0KPj4gKysrIGIvbmV0
L2lwdjQvaWdtcC5jDQo+PiBAQCAtMjk0Myw4ICsyOTQzLDYgQEAgc3RhdGljIHN0cnVjdCBpcF9z
Zl9saXN0ICppZ21wX21jZl9nZXRfbmV4dChzdHJ1Y3Qgc2VxX2ZpbGUgKnNlcSwgc3RydWN0IGlw
X3NmX2wNCj4+ICAgCQkJCWNvbnRpbnVlOw0KPj4gICAJCQlzdGF0ZS0+aW0gPSByY3VfZGVyZWZl
cmVuY2Uoc3RhdGUtPmlkZXYtPm1jX2xpc3QpOw0KPj4gICAJCX0NCj4+IC0JCWlmICghc3RhdGUt
PmltKQ0KPj4gLQkJCWJyZWFrOw0KPj4gICAJCXNwaW5fbG9ja19iaCgmc3RhdGUtPmltLT5sb2Nr
KTsNCj4+ICAgCQlwc2YgPSBzdGF0ZS0+aW0tPnNvdXJjZXM7DQo+PiAgIAl9DQo+IA0KPiBTYW1l
IHdpdGggdGhpcyBvbmU6IGFncmVlIHRoZSBjaGVjayBpcyBub3QgbmVlZGVkLCBidXQgSSBhbHNv
IGJlbGlldmUgaXQNCj4gZG9lcyBub3QgbmVlZCB0byBiZSBiYWNrcG9ydGVkLiBTaW5jZSBuZXQt
bmV4dCBpcyBjbG9zZWQsIHJlc3VibWl0IGFmdGVyDQo+IDkvMTEuDQo+IA0KPiAtLQ0KPiBwdy1i
b3Q6IGRlZmVyDQoNCkknbGwgcmVzZW5kIGl0IGFmdGVyIDkvMTEuDQpUaGFuayB5b3UgZm9yIHRo
ZSByZXZpZXchDQo=

