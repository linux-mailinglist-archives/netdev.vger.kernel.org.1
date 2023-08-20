Return-Path: <netdev+bounces-29190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60178781FAC
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 22:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8CA1C20899
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 20:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA226FC5;
	Sun, 20 Aug 2023 20:12:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCE27E6
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 20:12:48 +0000 (UTC)
Received: from authsmtp.register.it (authsmtp24.register.it [81.88.48.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE73D10EB
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 13:07:46 -0700 (PDT)
Received: from [192.168.1.243] ([213.230.62.249])
	by cmsmtp with ESMTPSA
	id Xoi5q5eKUODRcXoi5qZaNg; Sun, 20 Aug 2023 22:07:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schroetersa.ch;
	s=key_mmumrc8kf9; t=1692562062;
	bh=JPS9pi3pKZ4eP300PosgCdMwv63ZQ5aOWWW7Obq4CJQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TxgYbh3e/RcDYl5Yuq1iw8sbS7k6ne5AbRYeeMKi4w7D72yepWu8vVlCET5YoIATh
	 0cURcV4SDJm4PWthA+qZCuvvy/xeqYhesL1ASrYRor5rYKRFIoAKovUzReDycf02O4
	 wSc5vTkqBmMXHAKP2o5VFOw4qyMVlgWZrHEwn8oWuQ3aqMUOTs8JTqCKjIlfsBFM2m
	 sngiNa1q0+KEXRNqxdLDHHTwb4iFzuSVhroVlUJ+v7tTJSNmx2Fa9jNeW42FDZE+Nn
	 h7SM+aZzuHM/9GQDe9orb54yLkO/GU/dgY0FvTC2+mZy4BcOlTGVI3eQNCFDkma3xk
	 fI1AllyMWGQqA==
X-Rid: mathieu@schroetersa.ch@213.230.62.249
Message-ID: <ca7f140f-1717-456f-0385-c3d2ff71f95c@schroetersa.ch>
Date: Sun, 20 Aug 2023 22:07:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH iproute2-next] utils: fix get_integer() logic
To: Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, dsahern@gmail.com
References: <20230819205448.428253-1-pctammela@mojatatu.com>
Content-Language: en-US
From: Mathieu Schroeter <mathieu@schroetersa.ch>
In-Reply-To: <20230819205448.428253-1-pctammela@mojatatu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------X0hev60z16KuIg1KAlmsUti9"
X-CMAE-Envelope: MS4xfPcXJkffhBL5kzXL+MevBalGsO/wzloE6dSxL04Y4uM7WSdzkdgzc4D4OP4O3h75fjYkLos1QQmT4CI+B5gcU6JxFZ7XaD2LNc8FQ8F7xrn0Z0M2I0I6
 57E6K9MHznWaDpkCGZC4rpaBDiggkwSzi6fDVHLj2nHWX+Oh0FQoL+an7Mo3THP5v2Ck//1/eZ5QnnHuyd0dLp8a06vpw39lN28tLMJX9BGwt/Pk4I4TqQlw
 hLvaeDg2qxn9BP6M3tXBNcNHj30pC7RUTeY7q4x1WdYTdM9zQyxy62T4qkz5oI+naFI7+w58VUHj2+yfCrdYXw==
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------X0hev60z16KuIg1KAlmsUti9
Content-Type: multipart/mixed; boundary="------------e0hLC8iKNnEjBnKpDKqsozxN";
 protected-headers="v1"
From: Mathieu Schroeter <mathieu@schroetersa.ch>
To: Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, dsahern@gmail.com
Message-ID: <ca7f140f-1717-456f-0385-c3d2ff71f95c@schroetersa.ch>
Subject: Re: [PATCH iproute2-next] utils: fix get_integer() logic
References: <20230819205448.428253-1-pctammela@mojatatu.com>
In-Reply-To: <20230819205448.428253-1-pctammela@mojatatu.com>

--------------e0hLC8iKNnEjBnKpDKqsozxN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

TGUgMTkuMDguMjMgw6AgMjI6NTQsIFBlZHJvIFRhbW1lbGEgYSDDqWNyaXTCoDoNCj4gQWZ0
ZXIgM2E0NjNjMTUsIGdldF9pbnRlZ2VyKCkgZG9lc24ndCByZXR1cm4gdGhlIGNvbnZlcnRl
ZCB2YWx1ZSBhbmQNCj4gYWx3YXlzIHdyaXRlcyAwIGluICd2YWwnIGluIGNhc2Ugb2Ygc3Vj
Y2Vzcy4NCj4gRml4IHRoZSBsb2dpYyBzbyBpdCB3cml0ZXMgdGhlIGNvbnZlcnRlZCB2YWx1
ZSBpbiAndmFsJy4NCj4NCj4gRml4ZXM6IDNhNDYzYzE1ICgiQWRkIGdldF9sb25nIHV0aWxp
dHkgYW5kIGFkYXB0IGdldF9pbnRlZ2VyIGFjY29yZGluZ2x5Ig0KPiBTaWduZWQtb2ZmLWJ5
OiBQZWRybyBUYW1tZWxhIDxwY3RhbW1lbGFAbW9qYXRhdHUuY29tPg0KPiAtLS0NCj4gICBs
aWIvdXRpbHMuYyB8IDMgKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvbGliL3V0aWxzLmMgYi9saWIv
dXRpbHMuYw0KPiBpbmRleCBlZmEwMTY2OC4uOTliYTdhMjMgMTAwNjQ0DQo+IC0tLSBhL2xp
Yi91dGlscy5jDQo+ICsrKyBiL2xpYi91dGlscy5jDQo+IEBAIC0xNDIsNyArMTQyLDggQEAg
aW50IGdldF9pbnRlZ2VyKGludCAqdmFsLCBjb25zdCBjaGFyICphcmcsIGludCBiYXNlKQ0K
PiAgIHsNCj4gICAJbG9uZyByZXM7DQo+ICAgDQo+IC0JcmVzID0gZ2V0X2xvbmcoTlVMTCwg
YXJnLCBiYXNlKTsNCj4gKwlpZiAoZ2V0X2xvbmcoJnJlcywgYXJnLCBiYXNlKSA8IDApDQo+
ICsJCXJldHVybiAtMTsNCj4gICANCj4gICAJLyogT3V0c2lkZSByYW5nZSBvZiBpbnQgKi8N
Cj4gICAJaWYgKHJlcyA8IElOVF9NSU4gfHwgcmVzID4gSU5UX01BWCkNCg0KbXkgYmFkDQoN
ClRoYW5rIHlvdSAhDQoNCg==

--------------e0hLC8iKNnEjBnKpDKqsozxN--

--------------X0hev60z16KuIg1KAlmsUti9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEPxpdP3aajPAoLxrbi5FFpfqdqKgFAmTicowFAwAAAAAACgkQi5FFpfqdqKh9
Rwf+NfJNg7GpPcz6mfeaF7D25E/bwXuuD8v598B+mhuDm1eYtmIuhwP2X7lqBDJOda1/SyA+91ik
gAoP50JX2KmvGVUNk1RGukAP/9NP3E34f/moAAvyy2VdSmln6pz88giAU8bSHu41ye/NzzlfFn0j
W8pnlG2vL/jhjDijN1tna36v2aqL6fSAc8b06Y9OxNuZu8bt9Un0VnGl6IQSdiDGDUKewZ1laK0s
odSH+o7sNMBFe2i8969Uw9OezJ0Bfg5sgrDXKDxvM1GqywQIwDRqYAg2/OrSdrIrweqRgFZUURZh
RuDKVSkn1UzPWYykb/Hki7uxqlHP93Cgj4+sST8Fbg==
=P/sO
-----END PGP SIGNATURE-----

--------------X0hev60z16KuIg1KAlmsUti9--

