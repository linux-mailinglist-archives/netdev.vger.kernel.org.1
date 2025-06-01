Return-Path: <netdev+bounces-194521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6D1AC9E39
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 11:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC2EB7A86B0
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 09:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EB91A0714;
	Sun,  1 Jun 2025 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=universe-factory.net header.i=@universe-factory.net header.b="XdY5wsPk"
X-Original-To: netdev@vger.kernel.org
Received: from mail.universe-factory.net (osgiliath.universe-factory.net [141.95.161.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443F484D34;
	Sun,  1 Jun 2025 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.161.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748770541; cv=none; b=OJSVPy5+je+MO556hanuhhY045lcZ5NQtwXLjeAnMDmj5uxP+9nl4ZxB1IsyKwHWws+gxww4HPmqvvsPpBASBXAVPWUlGT3KGy6TJbhnXw69rWjLKNy0/HkrKDnYi28QB+CkjHDZu3N4u6ETOTplotLqYEVrg928dDVv2Qj2xPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748770541; c=relaxed/simple;
	bh=uTLC5p9N22Kx9vL8qJSA/195UF4sbsCr0Yl3EzuP/0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+rpgdRycUX9rxmDHQnfHE3cl2XqhzRnLYO+VibQMRopG1RopbeZGcax5wiczs1n3/OoWBmaPMGUsQKAcF6mLWl5hGz2Wqn1JLyBc6txbG9GCwCcGExCYV6k3qwEMU0dNnyvrMHW4qv93/4pd5BrrHy1Hp1UN9SImuYyMssFXOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=universe-factory.net; spf=pass smtp.mailfrom=universe-factory.net; dkim=pass (2048-bit key) header.d=universe-factory.net header.i=@universe-factory.net header.b=XdY5wsPk; arc=none smtp.client-ip=141.95.161.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=universe-factory.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=universe-factory.net
Message-ID: <bb85858d-b123-45ce-8fae-9658e13b822c@universe-factory.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=universe-factory.net;
	s=dkim; t=1748769987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uTLC5p9N22Kx9vL8qJSA/195UF4sbsCr0Yl3EzuP/0U=;
	b=XdY5wsPkHimN+SJ0uGzH//JnYlwIDFcSpPoeD8VA0bGO2k5m0XUWllXlOevDZl5E0OtvyR
	sWrQkII2zSMbP4DhvrRTj7bwf02MCAfDaXBwikD57XgFR9kYpLimxPTgZAMzPG4eSKkQRW
	I2j2gLeNDcyHE6TYiEv/iR1pVqbnk3G9KQXjLb8o3YCcxyCUbOfRTsyfOzVagNLBGRmntl
	QcOI1AWAs5xCvAIbuZ99Jk8lSKC0Nl+BoyoAOZoyFvC0CB3BJ0mXB+QGXEFeEoGxf/MORD
	nlmjfXmVPfgt9YTuEQs+tH+VOzmiRbxCzO1hN/k3dvWQGk2lFxm2mGC1G5cz6w==
Authentication-Results: mail.universe-factory.net;
	auth=pass smtp.mailfrom=mschiffer@universe-factory.net
Date: Sun, 1 Jun 2025 11:26:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH batadv 4/5] batman-adv: remove global hardif list
Content-Language: en-US-large
To: Sven Eckelmann <sven@narfation.org>,
 Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
 <262d5c5a5afe3d478d2e65187c0913a3a8c4781f.1747687504.git.mschiffer@universe-factory.net>
 <4860101.CbtlEUcBR6@sven-desktop>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Autocrypt: addr=mschiffer@universe-factory.net; keydata=
 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
 cQqe8eRmcdNdqWSiJQ8VLoI=
In-Reply-To: <4860101.CbtlEUcBR6@sven-desktop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------M0z18r80a60pH0xVhjEr00Yu"
X-Spamd-Bar: -----

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------M0z18r80a60pH0xVhjEr00Yu
Content-Type: multipart/mixed; boundary="------------3dmVChmUPlBQ0TlI7BQPqP8E";
 protected-headers="v1"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Sven Eckelmann <sven@narfation.org>,
 Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <bb85858d-b123-45ce-8fae-9658e13b822c@universe-factory.net>
Subject: Re: [PATCH batadv 4/5] batman-adv: remove global hardif list
References: <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
 <262d5c5a5afe3d478d2e65187c0913a3a8c4781f.1747687504.git.mschiffer@universe-factory.net>
 <4860101.CbtlEUcBR6@sven-desktop>
In-Reply-To: <4860101.CbtlEUcBR6@sven-desktop>

--------------3dmVChmUPlBQ0TlI7BQPqP8E
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzEvMDUvMjAyNSAxMTo1NiwgU3ZlbiBFY2tlbG1hbm4gd3JvdGU6DQo+IE9uIE1vbmRh
eSwgMTkgTWF5IDIwMjUgMjI6NDY6MzEgQ0VTVCBNYXR0aGlhcyBTY2hpZmZlciB3cm90ZToN
Cj4+ICAgc3RydWN0IGJhdGFkdl9oYXJkX2lmYWNlICoNCj4+IC1iYXRhZHZfaGFyZGlmX2dl
dF9ieV9uZXRkZXYoY29uc3Qgc3RydWN0IG5ldF9kZXZpY2UgKm5ldF9kZXYpDQo+PiArYmF0
YWR2X2hhcmRpZl9nZXRfYnlfbmV0ZGV2KHN0cnVjdCBuZXRfZGV2aWNlICpuZXRfZGV2KQ0K
Pj4gICB7DQo+PiAgICAgICAgICBzdHJ1Y3QgYmF0YWR2X2hhcmRfaWZhY2UgKmhhcmRfaWZh
Y2U7DQo+PiArICAgICAgIHN0cnVjdCBuZXRfZGV2aWNlICptZXNoX2lmYWNlOw0KPj4gICAN
Cj4+IC0gICAgICAgcmN1X3JlYWRfbG9jaygpOw0KPj4gLSAgICAgICBsaXN0X2Zvcl9lYWNo
X2VudHJ5X3JjdShoYXJkX2lmYWNlLCAmYmF0YWR2X2hhcmRpZl9saXN0LCBsaXN0KSB7DQo+
PiAtICAgICAgICAgICAgICAgaWYgKGhhcmRfaWZhY2UtPm5ldF9kZXYgPT0gbmV0X2RldiAm
Jg0KPj4gLSAgICAgICAgICAgICAgICAgICBrcmVmX2dldF91bmxlc3NfemVybygmaGFyZF9p
ZmFjZS0+cmVmY291bnQpKQ0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7
DQo+PiAtICAgICAgIH0NCj4+ICsgICAgICAgbWVzaF9pZmFjZSA9IG5ldGRldl9tYXN0ZXJf
dXBwZXJfZGV2X2dldChuZXRfZGV2KTsNCj4+ICsgICAgICAgaWYgKCFtZXNoX2lmYWNlIHx8
ICFiYXRhZHZfbWVzaGlmX2lzX3ZhbGlkKG1lc2hfaWZhY2UpKQ0KPj4gKyAgICAgICAgICAg
ICAgIHJldHVybiBOVUxMOw0KPj4gICANCj4+IC0gICAgICAgaGFyZF9pZmFjZSA9IE5VTEw7
DQo+PiArICAgICAgIGhhcmRfaWZhY2UgPSBuZXRkZXZfbG93ZXJfZGV2X2dldF9wcml2YXRl
KG1lc2hfaWZhY2UsIG5ldF9kZXYpOw0KPj4gKyAgICAgICBpZiAoIWtyZWZfZ2V0X3VubGVz
c196ZXJvKCZoYXJkX2lmYWNlLT5yZWZjb3VudCkpDQo+PiArICAgICAgICAgICAgICAgcmV0
dXJuIE5VTEw7DQo+PiAgIA0KPj4gLW91dDoNCj4+IC0gICAgICAgcmN1X3JlYWRfdW5sb2Nr
KCk7DQo+PiAgICAgICAgICByZXR1cm4gaGFyZF9pZmFjZTsNCj4+ICAgfQ0KPiANCj4gVGhp
cyBjb2RlIGlzIG5vdyByZWx5aW5nIG9uIHJ0bmxfbG9jaygpIChzZWUgYEFTU0VSVF9SVE5M
YCBpbg0KPiBgbmV0ZGV2X21hc3Rlcl91cHBlcl9kZXZfZ2V0YCBhbmQgbW9zdCBsaWtlbHkg
c29tZSBjb21tZW50cyBzb213aGVyZSBhYm91dCB0aGUNCj4gbGlzdHMgdXNlZCBieSBgbmV0
ZGV2X2xvd2VyX2Rldl9nZXRfcHJpdmF0ZWApLiBCdXQgYGJhdGFkdl90dF9sb2NhbF9hZGRg
IGlzDQo+IHVzaW5nIHRoaXMgZnVuY3Rpb24gd2l0aG91dCBob2xkaW5nIHRoaXMgbG9jayBh
bGwgdGhlIHRpbWUuIEZvciBleGFtcGxlIGR1cmluZw0KPiBwYWNrZXQgcHJvY2Vzc2luZy4N
Cj4gDQo+IFNlZSBmb3IgZXhhbXBsZSBgYmF0YWR2X3R0X2xvY2FsX2FkZGAgY2FsbHMgaW4g
YGJhdGFkdl9pbnRlcmZhY2VfdHhgLiBUaGlzDQo+IHdpbGwgaGFwcGVuIHdoZW4gYHNrYi0+
c2tiX2lpZmAgaXMgbm90IDAgKHNvIGl0IHdhcyBmb3J3YXJkZWQpLg0KPiANCj4gDQo+IFBs
ZWFzZSBkb3VibGUgY2hlY2sgdGhpcyAtIEkgaGF2ZSBub3QgYWN0dWFsbHkgdGVzdGVkIGl0
IGJ1dCBqdXN0IHdlbnQgdGhyb3VnaA0KPiB0aGUgY29kZS4NCj4gDQo+IA0KPiBBbmQgc2F5
aW5nIHRoaXMsIHRoZSBgYmF0YWR2X2hhcmRpZl9nZXRfYnlfbmV0ZGV2YCBjYWxsIHdhcyBh
bHNvIHVzZWQgdG8NCj4gcmV0cmlldmUgYWRkaXRpb25hbCBpbmZvcm1hdGlvbiBhYm91dCBh
bGxsIGtpbmQgb2YgaW50ZXJmYWNlcyAtIGV2ZW4gd2hlbiB0aGV5DQo+IGFyZSBub3QgdXNl
ZCBieSBiYXRtYW4tYWR2IGRpcmVjdGx5LiBGb3IgZXhhbXBsZSBmb3IgZmlndXJpbmcgb3V0
IGlmIGl0IGlzIGENCj4gd2lmaSBpbnRlcmZhY2UoZm9yIHRoZSBUVCB3aWZpIGZsYWcpLiBX
aXRoIHlvdSBjaGFuZ2UgaGVyZSwgeW91IGFyZSBiYXNpY2FsbHkNCj4gYnJlYWtpbmcgdGhp
cyBmdW5jdGlvbmFsaXR5IGJlY2F1c2UgeW91IG5vdyByZXF1aXJlIHRoYXQgdGhlIG5ldGRl
diBpcyBhIGxvd2VyDQo+IGludGVyZmFjZSBvZiBiYXRtYW4tYWR2LiBUaGVyZWZvcmUsIHRo
aW5ncyBsaWtlOg0KPiANCj4gDQo+ICAgICAgICAgICAgICAgICAgICAg4pSM4pSA4pSA4pSA
4pSA4pSA4pSA4pSQDQo+ICAgICAgICAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pS8YnItbGFu4pSc4pSA4pSA4pSA4pSA4pSA4pSA4pSQDQo+ICAgICAgICAg4pSC
ICAgICAgICAgICDilJTilIDilIDilIDilIDilIDilIDilJggICAgICDilIINCj4gICAgICAg
ICDilIIgICAgICAgICAgICAgICAgICAgICAgICAg4pSCDQo+ICAgICAgICAg4pSCICAgICAg
ICAgICAgICAgICAgICAgICAgIOKUgg0KPiAgICAgICDilIzilIDilrzilIDilJAgICAgICAg
ICAgICAgICAgICAgIOKUjOKUgOKUgOKWvOKUgOKUkA0KPiAgICAgICDilIJhcDDilIIgICAg
ICAgICAgICAgICAgICAgIOKUgmJhdDDilIINCj4gICAgICAg4pSU4pSA4pSA4pSA4pSYICAg
ICAgICAgICAgICAgICAgICDilJTilIDilIDilKzilIDilJgNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIOKUgg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAg4pSCDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICDilIzilIDilIDi
lrzilIDilIDilJANCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIOKUgm1lc2gw
4pSCDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICDilJTilIDilIDilIDilIDi
lIDilJgNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCj4gSXMgbm90IGhh
bmRsZWQgYW55bW9yZSBjb3JyZWN0bHkgaW4gVFQgYmVjYXVzZSBhcDAgaXMgbm90IGEgbG93
ZXIgaW50ZXJmYWNlIG9mDQo+IGFueSBiYXRhZHYgbWVzaCBpbnRlcmZhY2UuIEFuZCBhcyBy
ZXN1bHQsIHRoZSBhcC1pc29sYXRpb24gZmVhdHVyZSBvZiBUVA0KPiB3aWxsIGJyZWFrLg0K
PiANCj4gS2luZCByZWdhcmRzLA0KPiAJU3Zlbg0KDQpIbW0sIHRoaXMgaXMgYSB0cmlja3kg
b25lLiBPbmx5IGhhdmluZyB0aGUgaGFyZGlmcyBhcm91bmQgd2hpbGUgdGhleSdyZSANCnVz
ZWQgZm9yIG1lc2hpbmcgbWVhbnMgd2UgbmVlZCBzb21lIG90aGVyIHdheSB0byBkZXRlcm1p
bmUgdGhlIHdpZmkgZmxhZ3MgLSANCmJ1dCBkb2luZyBpdCBvbiBkZW1hbmQgZm9yIGV2ZXJ5
IGJhdGFkdl90dF9sb2NhbF9hZGQoKSBzZWVtcyBsaWtlIGl0IGNvdWxkIA0KYmUgdXNlZCB0
byBmYWNpbGl0YXRlIGEgRG9TIG9uIHRoZSBSVE5MIGJ5IGNhdXNpbmcgbGFyZ2UgbnVtYmVy
cyBvZiBUVCANCmVudHJpZXMgdG8gYmUgYWRkZWQsIGFzIHRoZSBsb2NrIG5lZWRzIHRvIGJl
IGhlbGQgZm9yIHJlc29sdmluZyB0aGUgaWZsaW5rLg0KDQpPbmUgb3B0aW9uIG1pZ2h0IGJl
IHRvIGFkZCBhIGNhY2hlIGZvciB0aGUgd2lmaSBmbGFnIChhbmQgcG9zc2libGUgb3RoZXIg
DQppbmZvcm1hdGlvbiwgSSdsbCBoYXZlIHRvIGNoZWNrIGlmIHRoZXJlIGlzIGFueXRoaW5n
IGVsc2UpLCBidXQgc3RvcmUgaXQgaW4gDQp0aGUgbWVzaCBpbnRlcmZhY2UsIG9ubHkgZm9y
IGludGVyZmFjZXMgdGhhdCBhcmUgYnJpZGdlZCB3aXRoIHRoZSBtZXNoLiANCkNhY2hlIGVu
dHJpZXMgY291bGQgYmUgY3JlYXRlZCBvbiBkZW1hbmQgd2hlbiBhIGxvY2FsIFRUIGVudHJ5
IGlzIGFkZGVkIGZvciANCmFuIHVua25vd24gSUlGOyB3aGVuIHRvIHJlbW92ZSBjYWNoZSBl
bnRyaWVzIGlzIHNvbWV0aGluZyBJJ2xsIGhhdmUgdG8gDQpmaWd1cmUgb3V0Lg0KDQpTaW1w
bGVyIGlkZWFzIGhvdyB0byBzb2x2ZSB0aGlzIGFyZSB3ZWxjb21lIDopDQoNCkJlc3QsDQpN
YXR0aGlhcw0K

--------------3dmVChmUPlBQ0TlI7BQPqP8E--

--------------M0z18r80a60pH0xVhjEr00Yu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEZmTnvaa2aYgexS51Fu8/ZMsgHZwFAmg8HMEFAwAAAAAACgkQFu8/ZMsgHZwt
ZxAAtIG1Tpru/AHHIo+VLwHK+N6TC4JhwdvbBMG9g7M976Fev7xXF2lLLQy8QPkGCD5TP9FKLZUt
/rBy87HRGS7qVCdp30E0Tx6xqbWiOPkJ6yzE3qzhFapwZJnsxGJo7eFA6CYNRTMI9gIp7OODgipV
Bhi6ZQdjFZ2nILqjx2q9KjcZXAPTpyenHRJot7d0QbidNkcr2oHSWowGeGI7IlXHsi2O+jyEM8vR
ml5lbAao1hzm/EhOtrMXeJUzfcMMlzflZn0i8QbryMvRmlhict0LmUcRTWsdZsZGOQGlHzVSIHoh
pgzfN/ieYDfNBfxu7ift0N4DYd60KcTtb4VQk1Yc+iSq7t5+fvZP0QcmTPRlgkQL3tS/YYjp+yjU
nFlRzxpWlFkye7+AL9nx3rDyrUidfq1doM8xs2bYtB6VTj/kCwjF+ViP2GXIIJ1Fd4ASxAeiCR7N
ae1F9aAKYdSJa/aF7XqqN3fSXrxj8rnOPMkkhNWAlohDgDe39Xrusl7H1j6jexk+mKYhUw1bcngY
Vgi7uwZRYrxFasniS+976K49S8d2RZ3Q4/kYz+pOfge7wmgn8VNefP/Kvbi4XhHDgzvmJnzI3ZwE
yrnKktydLrJpqXq5Of4mIH2DG58Z/sRX/4exUSaiSn7r/q5IiSQRdWOXk04DVe+Yl7NI92yMgg9c
IDw=
=ukPK
-----END PGP SIGNATURE-----

--------------M0z18r80a60pH0xVhjEr00Yu--

