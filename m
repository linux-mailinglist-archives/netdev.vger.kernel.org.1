Return-Path: <netdev+bounces-129170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0D597E126
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 13:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252451F21339
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 11:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C74317C211;
	Sun, 22 Sep 2024 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Vaq+JFki"
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2724CE13;
	Sun, 22 Sep 2024 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727004672; cv=none; b=SSbdvRhR643QRKTnAv+NBnJh3gGqGwQ7miVr+0ygebcwnRQWL2Hm26ddexIX2FxqQKY2DMgeJsZSfDeldoSfoSfTxuyNQMR28Pqnsvz0iJrenj4FZ4hSmDuZgv0C1ui7OeM4tiPU3Bqbu5Znvip5VC9mMYnXXjtKEPz047z/0DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727004672; c=relaxed/simple;
	bh=JxrBdpcosTtdMdJJGo64a8Vefx/lTcU1V7IWvfD31KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=ZaJQo4dicXwQAnBJ+iKx7/PPTGLnW8BbmSxeN9tXpDBQjE2vt9Wmu9cO2KMkUHdeaLa4uj2TKXhfl1FKSn+akQrhahRBYa7l796nstQr01EzQSPYa+J8M+eBqtK2VBgDjtPyqYDfeIWqZLVUim6ccSfkqQweupGUufgifdrvk9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Vaq+JFki; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1727004544;
	bh=JxrBdpcosTtdMdJJGo64a8Vefx/lTcU1V7IWvfD31KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Vaq+JFkiID8jIlttrYlp+cZ9vIzOI7HThRvnDuy3h9khboG1OpRpsyQhBYfvkSf98
	 YYILxLPSjZDqMk1hKkaz7gOgR3Sv9wjacJJjCS0qaj1ZEm/DYzO97b2kkDUAf3TZ0g
	 K2piktZ2oLLetMqUYRm7vq0Z+1z0X/rSSRmxIoYE=
X-QQ-mid: bizesmtpip4t1727004530te9cy2l
X-QQ-Originating-IP: cIIfLSPrlIH+hqKJAtCDGf16FZ6IbOpPWcUIAqsub/o=
Received: from [IPV6:240e:36c:d18:fa00:e9bb:21 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 22 Sep 2024 19:28:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 20816915635614422
Message-ID: <A0A7181245E14BD0+1c43b164-20b1-49ab-81db-40bdc8c91641@uniontech.com>
Date: Sun, 22 Sep 2024 19:28:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: [PATCH 3/3] eth: bnxt: Correct the typo 'accelaration'
To: WangYuli <wangyuli@uniontech.com>, michael.chan@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <7BF34BF48048052E+20240922111832.441807-1-wangyuli@uniontech.com>
 <FAD000B9FEA4D995+64bdb13a-3a7e-4e9f-bc15-199f8bbeae06@uniontech.com>
From: WangYuli <wangyuli@uniontech.com>
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <FAD000B9FEA4D995+64bdb13a-3a7e-4e9f-bc15-199f8bbeae06@uniontech.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------IVlrE0VpUEX0sPtKtdMpirWJ"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------IVlrE0VpUEX0sPtKtdMpirWJ
Content-Type: multipart/mixed; boundary="------------Pp0h1510Iz4qv7uF186k5VrZ";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: WangYuli <wangyuli@uniontech.com>, michael.chan@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com
Message-ID: <1c43b164-20b1-49ab-81db-40bdc8c91641@uniontech.com>
Subject: [PATCH 3/3] eth: bnxt: Correct the typo 'accelaration'
References: <7BF34BF48048052E+20240922111832.441807-1-wangyuli@uniontech.com>
 <FAD000B9FEA4D995+64bdb13a-3a7e-4e9f-bc15-199f8bbeae06@uniontech.com>
In-Reply-To: <FAD000B9FEA4D995+64bdb13a-3a7e-4e9f-bc15-199f8bbeae06@uniontech.com>

--------------Pp0h1510Iz4qv7uF186k5VrZ
Content-Type: multipart/mixed; boundary="------------qcVx9mQBNm0M264v0pb1iIrt"

--------------qcVx9mQBNm0M264v0pb1iIrt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

IEZyb20gZDRlMzIwNDc2ZDI0ZTk0NDExYzIwNTA5N2UzYmQwNDE2NjU5MzAzOCBNb24gU2Vw
IDE3IDAwOjAwOjAwIDIwMDENCkZyb206IFdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2gu
Y29tPg0KRGF0ZTogU3VuLCAyMiBTZXAgMjAyNCAxODo1MDozMCArMDgwMA0KU3ViamVjdDog
W1BBVENIIDMvM10gZXRoOiBibnh0OiBDb3JyZWN0IHRoZSB0eXBvICdhY2NlbGFyYXRpb24n
DQoNClRoZXJlIGlzIGEgc3BlbGxpbmcgbWlzdGFrZSBvZiAnYWNjZWxhcmF0aW9uJyB3aGlj
aCBzaG91bGQgYmUNCidhY2NlbGVyYXRpb24nLg0KDQpTaWduZWQtb2ZmLWJ5OiBXYW5nWXVs
aSA8d2FuZ3l1bGlAdW5pb250ZWNoLmNvbT4NCi0tLQ0KIMKgZHJpdmVycy9uZXQvZXRoZXJu
ZXQvYnJvYWRjb20vYm54dC9ibnh0LmMgfCAyICstDQogwqAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2Jyb2FkY29tL2JueHQvYm54dC5jIA0KYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9icm9hZGNvbS9ibnh0L2JueHQuYw0KaW5kZXggNmU0MjJlMjQ3NTBhLi5jYjAyYjBlNjhm
MTcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9icm9hZGNvbS9ibnh0L2Ju
eHQuYw0KKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvYnJvYWRjb20vYm54dC9ibnh0LmMN
CkBAIC0xMjg4MCw3ICsxMjg4MCw3IEBAIHN0YXRpYyBuZXRkZXZfZmVhdHVyZXNfdCANCmJu
eHRfZml4X2ZlYXR1cmVzKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsDQogwqDCoMKgwqDCoMKg
wqAgaWYgKGZlYXR1cmVzICYgTkVUSUZfRl9HUk9fSFcpDQogwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGZlYXR1cmVzICY9IH5ORVRJRl9GX0xSTzsNCg0KLcKgwqDCoMKgwqDC
oCAvKiBCb3RoIENUQUcgYW5kIFNUQUcgVkxBTiBhY2NlbGFyYXRpb24gb24gdGhlIFJYIHNp
ZGUgaGF2ZSB0byBiZQ0KK8KgwqDCoMKgwqDCoCAvKiBCb3RoIENUQUcgYW5kIFNUQUcgVkxB
TiBhY2NlbGVyYXRpb24gb24gdGhlIFJYIHNpZGUgaGF2ZSB0byBiZQ0KIMKgwqDCoMKgwqDC
oMKgwqAgKiB0dXJuZWQgb24gb3Igb2ZmIHRvZ2V0aGVyLg0KIMKgwqDCoMKgwqDCoMKgwqAg
Ki8NCiDCoMKgwqDCoMKgwqDCoCB2bGFuX2ZlYXR1cmVzID0gZmVhdHVyZXMgJiBCTlhUX0hX
X0ZFQVRVUkVfVkxBTl9BTExfUlg7DQotLSANCjIuNDMuMA0K
--------------qcVx9mQBNm0M264v0pb1iIrt
Content-Type: application/pgp-keys; name="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSK
P+nX39DNIVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAx
FiEEa1GMzYeuKPkgqDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMB
AAAKCRDF2h8wRvQL7g0UAQCH3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfP
bwD/SrncJwwPAL4GiLPEC4XssV6FPUAY0rA68eNNI9cJLArOOARmgSyJEgorBgEE
AZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7VTL0dvPDofBTjFYDAQgHwngE
GBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIbDAAKCRDF2h8wRvQL
7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkUo9ERi7qS
/hbUdUgtitI89efbY0TVetgDsyeQiwU=3D
=3DBlkq
-----END PGP PUBLIC KEY BLOCK-----

--------------qcVx9mQBNm0M264v0pb1iIrt--

--------------Pp0h1510Iz4qv7uF186k5VrZ--

--------------IVlrE0VpUEX0sPtKtdMpirWJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZu//cAUDAAAAAAAKCRDF2h8wRvQL7rzF
AQDXWaPh/PRBFv6AWQYrhphW0J4UDL1rhMxuuYYdab4scwD/RbbvJ95Rh3W3sJLEa0CE+GEHUY7R
5Z99OVjctHzomg8=
=9n/t
-----END PGP SIGNATURE-----

--------------IVlrE0VpUEX0sPtKtdMpirWJ--

