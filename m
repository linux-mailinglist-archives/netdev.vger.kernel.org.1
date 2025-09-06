Return-Path: <netdev+bounces-220514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04166B46775
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 02:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87551890D1B
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 00:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80FA22F01;
	Sat,  6 Sep 2025 00:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcwxCXYo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE2B5661;
	Sat,  6 Sep 2025 00:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757117891; cv=none; b=Q+iG5lpXrcNNrKiQTEm0JoDglLHdzJOTEnDRHiUy5wq/A2CQAeYyti3+ci4bC1kzUOR8V7KC6nGPS2Vk645yZOgY6atgyLuySC2pA+9gRJ2sKxcEssRQrAd8kbsl5LenZGvpNH6oQFxiR0c0GguU0gxuhrs3XHdH1wXbv1ospgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757117891; c=relaxed/simple;
	bh=lu+qRIbrRnZYTba50Wh+xDGx19vsLgoXzjNCDvoDXhI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdG4WrgF5kYrDYJ/reWK7Lp75Bf2n+P+y45BmqrLOfo+80NxIVbpVKH5djH9iYVfxKdv2itteAEiAEOsiHA+IYDp844jvt+gjPDkt4mnmE1kVEQB9YgMUeD3p+fJMeemk/KXM3lKW0yYba3g1EsH4DAzkoHI7+lQz7+ExweCt8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcwxCXYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C51CC4CEF5;
	Sat,  6 Sep 2025 00:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757117891;
	bh=lu+qRIbrRnZYTba50Wh+xDGx19vsLgoXzjNCDvoDXhI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LcwxCXYowbvRJToUbp7RT0rVnNzFcbUTfuqhhb5hY6ijwHm1YMB13p/TllOhBoVaU
	 Oow7s8yoeerWWd51e59nqinESsmyUpz3dRv2ZFHUrrweM+oOUzjigcxWFf11w6ccYe
	 XJzWTeD9m5B/P8FnSPDpwJEgQOiEjE1Gv2kjs5JXJQ29jSMscxVp446ii2QhxO/XLn
	 pZ8ctoSxv0oCO7cQhAT0Qmds1SWFxVT6MIsKVJSl9WUXUBrd+dVW6MZZBjyYambqy1
	 lXQNmbzNyLr6s/h2XExLN7A9ZcCtrHJYfUqM12FyaVZZg3Dn2fDkbQ/6ze1ORjfaOq
	 eNzW36EQiTWsg==
Date: Fri, 5 Sep 2025 17:18:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 05/11] tools: ynl-gen: define nlattr *array in
 a block scope
Message-ID: <20250905171809.694562c6@kernel.org>
In-Reply-To: <20250904220156.1006541-5-ast@fiberby.net>
References: <20250904-wg-ynl-prep@fiberby.net>
	<20250904220156.1006541-5-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  4 Sep 2025 22:01:28 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Instead of trying to define "struct nlattr *array;" in the all
> the right places, then simply define it in a block scope,
> as it's only used here.
>=20
> Before this patch it was generated for attribute set _put()
> functions, like wireguard_wgpeer_put(), but missing and caused a
> compile error for the command function wireguard_set_device().
>=20
> $ make -C tools/net/ynl/generated wireguard-user.o
> -e      CC wireguard-user.o
> wireguard-user.c: In function =E2=80=98wireguard_set_device=E2=80=99:
> wireguard-user.c:548:9: error: =E2=80=98array=E2=80=99 undeclared (first =
use in ..)
>   548 |         array =3D ynl_attr_nest_start(nlh, WGDEVICE_A_PEERS);
>       |         ^~~~~

Dunno about this one. In patch 4 you basically add another instance of
the "let's declare local vars at function level" approach. And here
you're going the other way. This patch will certainly work, but I felt
like I wouldn't have written it this way if I was typing in the parsers
by hand.

