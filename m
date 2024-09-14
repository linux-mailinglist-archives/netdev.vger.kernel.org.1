Return-Path: <netdev+bounces-128291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC515978D5C
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 06:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B13CB2327B
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 04:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F73F18E25;
	Sat, 14 Sep 2024 04:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqhxLQPM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0152B17C96;
	Sat, 14 Sep 2024 04:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726288784; cv=none; b=WxJa9HQJzjbDo8DO3QJRCHmgxz+kZIVl7jR0ZpVK/EjFUobLyPcTxDdeefaKo54D9k9U/S86gcnL+aNEtFsN36a2ML2pc/AQfWnfOCzI7ua5t+t2IJz3y0cHqqy1zWcTZSH3tmptn0QUL9D3FqTMy2UlCklvqRpI7dZwzSPbksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726288784; c=relaxed/simple;
	bh=F6akxK2W4SuQNEXOhSjWcn4tVsoCGbPAD8FLnECAZj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3Ql2zw7IHPrhzD6ome3FAEx3jjCIMYGXyDLR4CIk4ylElt4Qf9ANZykriWTM03pziDGuJh301gG24c2ynD/mMldyCFYOlXXRpHqeagEZ5xkB6YH3eJj7mE1Vnrui7G0Vspz46b76Dq1Aow1XcwdlfYBKZVWhNAQz4sfPgmsAW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqhxLQPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E989CC4CEC0;
	Sat, 14 Sep 2024 04:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726288783;
	bh=F6akxK2W4SuQNEXOhSjWcn4tVsoCGbPAD8FLnECAZj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dqhxLQPMlAccmLKEHNYDBuA6B6yi84IbA4CfTFtvtpbr4WI9sIcWY4HZUf2pXTVjL
	 ZkQz57N0o+2fXFNmqOgc5vnUERAIiuWcUeiq89LcxEaXqFIzyyTp8l6xUvJhiVt+IS
	 HEy7x+arlV7BK1pxgxgpWomrSzHvqXeLwiee6/kAaptGU0qJhEiX1QN8FPGXKmFv9F
	 2Vb983Q6vKJf4WcTD+Huq6va8iOvUcqXDBboxxvNWlMUbCSo1dLUr5eEwzX9KeyQ5o
	 WKvMMX6B/wzqx4IcySEAezJFozGqC1s9HX8gbw3XRDAx5wea/nXEJesBc2ZoPA5pST
	 phZdFxQGtLhvg==
Date: Fri, 13 Sep 2024 21:39:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tools: ynl-gen: use big-endian netlink
 attribute types
Message-ID: <20240913213941.5b76c22e@kernel.org>
In-Reply-To: <20240913085555.134788-1-ast@fiberby.net>
References: <20240913085555.134788-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Nice improvement! Since it technically missed net-next closing by a few
hours, let me nit pick a little..

On Fri, 13 Sep 2024 08:55:54 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
> index 717530bc9c52e..e26f2c3c40891 100755
> --- a/tools/net/ynl/ynl-gen-c.py
> +++ b/tools/net/ynl/ynl-gen-c.py
> @@ -48,6 +48,7 @@ class Type(SpecAttr):
>          self.attr =3D attr
>          self.attr_set =3D attr_set
>          self.type =3D attr['type']
> +        self.nla_type =3D self.type

is it worth introducing nla_type as Type attribute just for one user?
inside a netlink code generator meaning of nla_type may not be crystal
clear

>          self.checks =3D attr.get('checks', {})
> =20
>          self.request =3D False
> @@ -157,7 +158,7 @@ class Type(SpecAttr):
>          return '{ .type =3D ' + policy + ', }'
> =20
>      def attr_policy(self, cw):
> -        policy =3D c_upper('nla-' + self.attr['type'])
> +        policy =3D c_upper('nla-' + self.nla_type)

We could just swap the type directly here?
--=20
pw-bot: defer

