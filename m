Return-Path: <netdev+bounces-232290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 191A8C03EC4
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 02:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B6DD4E94CD
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 00:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26C02AD25;
	Fri, 24 Oct 2025 00:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1Zmsa0J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8121328DC4;
	Fri, 24 Oct 2025 00:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761264224; cv=none; b=HE03jhL/ZS0BvuBs8h37vpLwEiW4DDd5cRbOZ7Ng46vyfUWQZ2E/q9+mGBrN90lVMAv7P1glAhHRo3XPahJcqj10ttHKFKnFVXaWAfCrjfLdku050CJ5QezCIXb8rJBETXi1874rne5SkxmwVZzuB2cpCf6xoZteR4Jt1q8hOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761264224; c=relaxed/simple;
	bh=82yuS+sWTafw2Py0dWaPeg0/oAhrcVBmZqViILrxQCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mz5PhavMo5RZGVfhFtwkUbMQtCSOohGjy6ddlAF0nIAsuV8n6xMtAZmPhbWoow1Rmtnb8jg5AMHa8KYtZUPftCeZsiYb4MHUMokiZ5/a9LA3dTMlYoYXz2YH8S05lHe9zlqK8/sVcu9JpCKsrBgGN3hG0XYxE13fVYlpLgU5wj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1Zmsa0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613A3C4CEE7;
	Fri, 24 Oct 2025 00:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761264224;
	bh=82yuS+sWTafw2Py0dWaPeg0/oAhrcVBmZqViILrxQCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j1Zmsa0Jy/Sm4bV1ai2EZm4v+Swx+9f4ZwcZ1+bhWCsXg/CjjLqlQVw2tOSUqVYNz
	 aA3aTlJF7crlRXvVJXtwIPhpAk1l4AvA/CuvFObqBc3PC/ZiQdcGM7Qnbmuva/4b2o
	 vdC/yQBxrVgYVtJRwGa4VGiCu+tmLDNYb5P9uqy5HQ4S7fO/7DWwM4uN/gp8KmjYlc
	 181T2B3qrz5uvSvrJhNYk1riAoSaA8aYV7cLAKq+CaJ27zO5693mvutTgObBnNDas/
	 UKAA5AFwC+6Slt6unHxLTjFLt2XWgzIFPpcuEfxpioHySt8OaaZyU+WnOn59XF4BG0
	 TrwMQiOhoauyg==
Date: Thu, 23 Oct 2025 17:03:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Chia-Yu Chang
 <chia-yu.chang@nokia-bell-labs.com>, Chuck Lever <chuck.lever@oracle.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Simon Horman
 <horms@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] ynl: add ignore-index flag for
 indexed-array
Message-ID: <20251023170342.2bb7ce83@kernel.org>
In-Reply-To: <f35cb9c8-7a5d-4fb7-b69b-aa14ab7f1dd5@fiberby.net>
References: <20251022182701.250897-1-ast@fiberby.net>
	<20251022184517.55b95744@kernel.org>
	<f35cb9c8-7a5d-4fb7-b69b-aa14ab7f1dd5@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Oct 2025 18:37:09 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
>  > C code already does this, right? We just collect the attributes
>  > completely ignoring the index. =20
>=20
> In the userspace C code, for sub-type nest the index is preserved
> in struct member idx, and elided for other sub-types.

I see it now, I guess I added it for get but forgot to obey it=20
for put :(

>  > So why do we need to extend the spec. =20
>=20
> For me it's mostly the naming "indexed-array". Earlier it was
> "array-nest", then we renamed it to "indexed-array" because
> it doesn't always contain nests.  I think it's counter-intuitive
> to elide the index by default, for something called "indexed-array".
> The majority of the families using it don't care about the index.
>=20
> What if we called it "ordered-array", and then always counted from 1
> (for families that cares) when packing in user-space code?
>=20
>  > Have you found any case where the index matters and can be
>  > non-contiguous (other than the known TC kerfuffle). =20
>=20
> IFLA_OFFLOAD_XSTATS_HW_S_INFO could be re-defined as a nest,
> IFLA_OFFLOAD_XSTATS_L3_STATS is the only index atm.

Isn't that pretty much always true? If the index is significant
the whole thing could be redefined as a nest, with names provided
in the spec?

> IFLA_INET_CONF / IFLA_INET6_CONF is on input, but those are
> also special by having different types depending on direction.
>=20
> I found a bunch of other ones, using a static index, but they
> can also be defined as a multi-attr wrapped in an additional
> outer nest, like IFLA_VF_VLAN_LIST already is.

Multi-attr with an outer nest should at least solve your wg problem=20
I guess? If all the attrs have type of 0 we can make it a multi-attr.

>  > FWIW another concept is what TypeValue does.
>  > "Inject" the index into the child nest as an extra member.
>  > Most flexible but also prolly a PITA for user space to init those
>  > for requests. =20
>=20
> Same as is done in the userspace C code for indexed-arrays with
> sub-type nest. For most families it doesn't matter if the C code
> inits the index or not.

