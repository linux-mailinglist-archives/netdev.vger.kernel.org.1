Return-Path: <netdev+bounces-175677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 330CAA6714C
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B458C19A2D3E
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED72207E00;
	Tue, 18 Mar 2025 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Wh1QyxjG"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53E7207A1F;
	Tue, 18 Mar 2025 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293779; cv=none; b=ivXp2clh5s7u6aGONJA6/UrBG+w5gpT7bd6h7hGkpqu7wjBPao/F9f6lFzSgNwh7jD2A2ip9m8a5PP4u/KlqmMnvhMi2e342yqR/jgSO2zNC3aPmHSBE3fX20FgjVYKUYUoXHPnb1i/kw58Dy4gb4YfkbziDvBnCS++VjnMKv8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293779; c=relaxed/simple;
	bh=o85dNYKxjhVyQic2tzOaS2dDGnYUZB+vuSQDNjhlJc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btDwF9V8KVlOJ1ql2TXPSjvvtPV4Q2DsGbnpaM2gkN/4J7oW1xwN1ns7730aSMeCzO3ewA8aiQszoXxomOjdckNUi9ae50snInnwf67N7WkvRcjLC8uiH04glcgyVj1d1Gm1LvheM3AIUgZ0yc9TTeN1zfg5a9Ff4myTg8vQarY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Wh1QyxjG; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1742293715;
	bh=o85dNYKxjhVyQic2tzOaS2dDGnYUZB+vuSQDNjhlJc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Wh1QyxjGQDU5ZRwNDDEM+G8Cs7ZDtoD4ZGwpHHWyP+VFDMVB4GXeEVYswNdJvYISC
	 9MTVElaqUaGDlJbpOiMDxOQSxjB9NwAktjRo83AE+zPa3rBFM9HTU2vmVoehAyxdqW
	 FhzZs9uOIJ2lJVw9JiIZdSoPi5LuUxG1zLgl7TFc=
X-QQ-mid: bizesmtpip4t1742293676tc8iuox
X-QQ-Originating-IP: aObwQ7kshVJ3gRnrbd8euD+E7nA+/AAMUnXKji9wq9o=
Received: from [IPV6:240e:668:120a::212:156] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Mar 2025 18:27:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16948721884944530558
Message-ID: <540019E19B3FCA3D+99198df4-b799-4639-9a62-993abfc6cd69@uniontech.com>
Date: Tue, 18 Mar 2025 18:27:54 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] mlxsw: spectrum_acl_bloom_filter: Workaround for
 some LLVM versions
To: Ido Schimmel <idosch@nvidia.com>
Cc: petrm@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, czj2441@163.com,
 zhanjun@uniontech.com, niecheng1@uniontech.com, guanwentao@uniontech.com
References: <CBD5806B120ADEEE+20250318054803.462085-1-wangyuli@uniontech.com>
 <Z9k4XQUDEKPHHI5k@shredder>
Content-Language: en-US
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <Z9k4XQUDEKPHHI5k@shredder>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zRvarJ8jpADb0bkjEy3uRGfr"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NtMl7YUnlkICryeo7xo0hPcSQn1vuxO4YowKP9lNW8qpWl4dd5F0nSHO
	H0j3jvOVs35gzr2zaoQMFhJPQ8RRoTo7dB8CYUrQTtMyzPU0baB4fXZ/fc4FtEaYFtpWyNi
	k5ATHT+U+Ezkb+UJAHTaGxvhedHy1IshdsTQT/T+l/6UUDiwLXnY5ASZTq13GUNVqY+snSe
	NTHNrYtECfd5PU5ceYWhGHnvYjgfZkuw8PfMPXM25zSF5mtiAaAEfwNKGIsu66N3OXO61b3
	lZxCt0VqXQcnsLbTaMODX54uWz95Y/A9gMsUFvpngg505ecghwMEaKLDuhjOxcXB5m+gFQu
	0fp1+jTYMvHTko63axxsAopqOOt12vUYIFzNPqMtq9PSBK4qa8qE5cJ9PDd8+wXP+Na7mjV
	7Vj69OLoHhiSRfkjpFKE6qWsBOlmBwBbJe4vgcaAhpIFD0AL9y+XrscwooKPFulvChKqmtn
	5y52bJFay6W763cwwlbBkIg7//4+mivgpDA6Ydt4RjndEhZ8TDmcBvi7pTvMIyFCZqxITig
	nU6gE4N+4zoeTKjMWZxMQn6Xt9MsqWv87/lGB4cSGDLdwFw/FSkqO1BEVI8P31yqyJmKT/D
	py9I+dRDAZBLp0lKYTo6osJgov8PAXXt9vPKcSTYBDMyuuuctCMYhm9JDxMTu/DdBSOoYUU
	Rx9pKlGjzAkC4t7AoTBReqZtIfK8uvCVbD5dcXMfV4QmVJOrkKBSbh/Dtb73DNYpX0dQ07S
	h1gvwiGgwdDhxKCNgu0GdzPnxNw18mHmGuoRkr0CifbkgGUAqeghwdfIRbrhcg9DFmQ82W/
	iDG+EoO5b3LAdJ1roRRiw5K01LuEymDGH0J4NmKl2ZmB22TeIbpAgGDzPSgzEpzXL25fTXu
	YXq2fVzRht9WAJEC1xX3YJVp5vayedZJfUoxUUTj9/dEYAFKwMrYl9/6J0Kx5MPyk+dJtDg
	XYTyVrKHHjJmhzwtbszwqwM2lgOvXEuH/xQJjsY3fy/tGq9tG+wHO/m+QuB7iNLfBI4XPiR
	8h0tWThXpS7jMBhz94Ltu19qlsnRKMUVWgpU4sxpBhuXOuP3WdERN/lJQGJMVsa9snxWAaF
	Q==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------zRvarJ8jpADb0bkjEy3uRGfr
Content-Type: multipart/mixed; boundary="------------kBUSRutY3n4c4uQF6O2Zf3dh";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: petrm@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, czj2441@163.com,
 zhanjun@uniontech.com, niecheng1@uniontech.com, guanwentao@uniontech.com
Message-ID: <99198df4-b799-4639-9a62-993abfc6cd69@uniontech.com>
Subject: Re: [PATCH net v2] mlxsw: spectrum_acl_bloom_filter: Workaround for
 some LLVM versions
References: <CBD5806B120ADEEE+20250318054803.462085-1-wangyuli@uniontech.com>
 <Z9k4XQUDEKPHHI5k@shredder>
In-Reply-To: <Z9k4XQUDEKPHHI5k@shredder>

--------------kBUSRutY3n4c4uQF6O2Zf3dh
Content-Type: multipart/mixed; boundary="------------IZuLjKHBvEiD5jxy855i5itO"

--------------IZuLjKHBvEiD5jxy855i5itO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

QXBvbG9naWVzLCBhIG1pbm9yIGZvcm1hdHRpbmcgZXJyb3IuDQoNCldpbGwgc2VuZCBhIHBh
dGNoIHYzLg0KDQpUaGFua3MsDQoNCi0tDQoNCldhbmdZdWxpDQoNCg==
--------------IZuLjKHBvEiD5jxy855i5itO
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

--------------IZuLjKHBvEiD5jxy855i5itO--

--------------kBUSRutY3n4c4uQF6O2Zf3dh--

--------------zRvarJ8jpADb0bkjEy3uRGfr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZ9lKqgUDAAAAAAAKCRDF2h8wRvQL7i0l
APoCoN3Vd6b3dWxRYkqED+Jdl/OuR5bU9WK/thyKyiRa6QEA7a+EnaW4KFR4TyWc8e9s7hmxusy/
qbiJNS09+h5/ZAE=
=oRcs
-----END PGP SIGNATURE-----

--------------zRvarJ8jpADb0bkjEy3uRGfr--

