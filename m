Return-Path: <netdev+bounces-180845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB41FA82B26
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7D29A1B49
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F32267F4C;
	Wed,  9 Apr 2025 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=universe-factory.net header.i=@universe-factory.net header.b="Aafp1mcA"
X-Original-To: netdev@vger.kernel.org
Received: from mail.universe-factory.net (osgiliath.universe-factory.net [141.95.161.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC3525DCE2;
	Wed,  9 Apr 2025 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.161.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213450; cv=none; b=r9NrrpUJ20NdK1i7s5aAK4UeoqgpSS4aHjMhz+Ng345u5lDgW2lJdCdt5eiep77hNxLmCHcgDNCBdP4GRLYyul6xiT+ExjDIikaY3xM1GS8pHOKi6Rh/b0xL4570lVDoPfxUiQ+BYGK08wrvxO/mVa0rfL5tF9Wp04keyQVahpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213450; c=relaxed/simple;
	bh=ByunKrilyL48d/c5MjnZJh9souP+RihV9Ah6M47bueA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jr9UutlP/6qmfsIEGvF5S2yGmAyO+rfAvS2+MzQHvm/pZBzcziDU/dv1Js87L9xu0PlBurwfS0wRlH2kJRrPlLOOO0HRwwkm6SzDTF7deC18B+KJvrhwoqQBK4LAz4Uzt3L8vHszCs0pIuCFqRC8P3Kbu6KJIlreGuCMPpHxLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=universe-factory.net; spf=pass smtp.mailfrom=universe-factory.net; dkim=pass (2048-bit key) header.d=universe-factory.net header.i=@universe-factory.net header.b=Aafp1mcA; arc=none smtp.client-ip=141.95.161.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=universe-factory.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=universe-factory.net
Message-ID: <3615fa6f-a837-4b4d-a987-52245710d84e@universe-factory.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=universe-factory.net;
	s=dkim; t=1744213443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ByunKrilyL48d/c5MjnZJh9souP+RihV9Ah6M47bueA=;
	b=Aafp1mcAiZH8DXqq0kdvvMDJv8NFT22AjB8NsPBEnvZADRi2tSeY4Enyq2XH9UJyrQLknZ
	2kf2xqN1Flc9CKMmrI6Yh2sl5aUGLb+uQDHLsBrsBkLflX+6fk1bayRUjV++iEK14OVkVK
	nwrLpa5DFraGh3nafaK/k+3QpQttUQkboHxm0Agt9x+i7WZ7JJ1abptJnIzMk+v5Gh5ydI
	EzdrKKwIElEwsqu5TXbRTsArPxydkKbAMQgZ8wIq/F094d0mBFlgciSg0WBz8KvKEhfhxd
	eRatMIdeFfsQgZqQC3aKxotH8tgUdbK9lRySvz6dT1GcST9KmRhNF2lOwfIhUA==
Authentication-Results: mail.universe-factory.net;
	auth=pass smtp.mailfrom=mschiffer@universe-factory.net
Date: Wed, 9 Apr 2025 17:44:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: batman-adv: constify and move broadcast
 addr definition
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
References: <c5f3e04813ff92aca8dddc7e1966fe45fca63e56.1744127239.git.mschiffer@universe-factory.net>
 <2789676.Lt9SDvczpP@ripper>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Autocrypt: addr=mschiffer@universe-factory.net; keydata=
 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
 cQqe8eRmcdNdqWSiJQ8VLoI=
In-Reply-To: <2789676.Lt9SDvczpP@ripper>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------60iJOc5p1wrpyh3HgNkqvD71"
X-Spamd-Bar: ----

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------60iJOc5p1wrpyh3HgNkqvD71
Content-Type: multipart/mixed; boundary="------------so68tEQeyh9weA1bi63OW1xD";
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
Message-ID: <3615fa6f-a837-4b4d-a987-52245710d84e@universe-factory.net>
Subject: Re: [PATCH net-next] net: batman-adv: constify and move broadcast
 addr definition
References: <c5f3e04813ff92aca8dddc7e1966fe45fca63e56.1744127239.git.mschiffer@universe-factory.net>
 <2789676.Lt9SDvczpP@ripper>
In-Reply-To: <2789676.Lt9SDvczpP@ripper>

--------------so68tEQeyh9weA1bi63OW1xD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDkvMDQvMjAyNSAxMDoxMCwgU3ZlbiBFY2tlbG1hbm4gd3JvdGU6DQo+IE9uIFR1ZXNk
YXksIDggQXByaWwgMjAyNSAxNzo1MzozNiBDRVNUIE1hdHRoaWFzIFNjaGlmZmVyIHdyb3Rl
Og0KPj4gKyAgICAgICBjb25zdCB1OCBicm9hZGNhc3RfYWRkcltdID0gezB4ZmYsIDB4ZmYs
IDB4ZmYsIDB4ZmYsIDB4ZmYsIDB4ZmZ9Ow0KPiANCj4gU2hvdWxkIG1vc3QgbGlrZWx5IGJl
ICJzdGF0aWMgY29uc3QgdTggLi4uIg0KPiANCj4gKGNoZWNrcGF0Y2ggU1RBVElDX0NPTlNU
X0NIQVJfQVJSQVkpDQo+IA0KPiBLaW5kIHJlZ2FyZHMsDQo+IAlTdmVuDQoNClRoYW5rcywg
d2lsbCBzZW5kIGEgdjIuIFRoZSBjaGVja3BhdGNoIGNoZWNrIG9ubHkgbG9va3MgZm9yIHN0
cmluZ3MsIG5vdCANCmFycmF5cyBkZWZpbmVkIHdpdGggeyB9LCBzbyBpdCBkaWRuJ3QgdHJp
Z2dlciBmb3IgbWUuDQoNCkJlc3QsDQpNYXR0aGlhcw0K

--------------so68tEQeyh9weA1bi63OW1xD--

--------------60iJOc5p1wrpyh3HgNkqvD71
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEZmTnvaa2aYgexS51Fu8/ZMsgHZwFAmf2lcIFAwAAAAAACgkQFu8/ZMsgHZxu
fRAA02x0QMxxvLVurZGGbh1sjKGPgMeRcQwSoO6e516iXhjjlhali0f3Z+xVxSpPw9Hjg4OX/vs3
tupMNvLjFTizfw11jyTjQirrID8J813n1yRc+hJEayjEvhbrv5+nUGDUANiasAoASuikE7ah34jY
WIOrt4qD38EHEvbwRVFz0YUZqfGFDrJ/l3t+/wm24VFVFMHXLVLVcn8qJmfoCdAKmKP2Qh1HMqVG
OLNwiwMo5CBUYx0yhN/RzdU5F0660Q+CUT2ws1GN/MejfcqLUvwl4ol3RpM3heewLhPU2ArRJy+2
QBaN+mVZJK4LL3P+wtgeL+0FUxiJelIfDFaLrBg0fcuUnfgenkKPcwaHc4lzBqNPcdJJ20sCP4Go
In0Vz4WpgtV4HIAz4659tqxo3YkDrHSMiyE2p903AoTxTUn8hT+TpK8VacfaOjqcyMUKtkXHwSze
FGS09DJlQMiYCxbIRUzKNM6MkvCbBQaB5CuG+sJX5RDl6rDsZTXMX/PjvmTzKPPvwDMEln9QO+xz
l9bhOGi3FBQ3/OsXOwuCyenPtwRGfh/ZLkAwOIB9LPEmqq0HXO5EgcuuAomHfuiFw1Kd9gov6wcN
L7Phl4l0HrHLKGcIXQtZkfdqnbNJ1MTeVBBjkaiq1UqLQXbEJL6q1nll8QrFNVXcRXkAnw+U7GQa
IV8=
=xF61
-----END PGP SIGNATURE-----

--------------60iJOc5p1wrpyh3HgNkqvD71--

