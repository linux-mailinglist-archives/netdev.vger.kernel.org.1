Return-Path: <netdev+bounces-239757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18564C6C2DB
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 01:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 1CF3C2C62B
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 00:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9590A221FCA;
	Wed, 19 Nov 2025 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1I0qSAl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C47F214812;
	Wed, 19 Nov 2025 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763513599; cv=none; b=GP8sB1FLs7Bd+hNTvdpy/d9Evzolo0sgQy668AI3Ryum0b+3y2IyKmB3ginCPhNJOnTOa14WmTBlcIuiE5y58zCtTcKxXlB6dmYkChD7496bXNfGLa5zVchOiqpJm3KQjzTRxgTrdZNUP06juj5fES0UJtw+B5/fJlZCeHAfsJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763513599; c=relaxed/simple;
	bh=kdl2WMZWDlCFrdcyuc2+LdLt928k5GOWuRvxrCpd7Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkFdVgpU52VRFtfImuC8qCqVH3CaIBue+xN8fnMWsOnuCdDgnCs0z8FoZKmLKfca1b2YlUiSN+DSCx4/myfit2XV5C1ju4GCrCBK3DUPfbDvqq1InRquj9ZwYrvXUDKIWvo/0BZ96thgyIbcaRc+DGMyXf0xFphRmc9FETh5tOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1I0qSAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63956C4AF12;
	Wed, 19 Nov 2025 00:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763513598;
	bh=kdl2WMZWDlCFrdcyuc2+LdLt928k5GOWuRvxrCpd7Qs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h1I0qSAlaTPipkby0PxQ0loeTlahBMxd7/rnsKdgRuk+VHiS7HXvaEHVhyHVca+6Q
	 gK5ocBk5/HjBSAgycwE4HoCUGQPe1YMU/43LPrHdUXMiNwPwq9hNf0pqtm39yLF995
	 yVEzh/l86WZSDGC3gBQw35bu6inN4T+tdlqQze6fWKPybXDtZm6rxaULRDoGBvBEid
	 mCw5b+tNJXGe9809w+o1jSCjEmuouudo0woEH0t+d370DTjKikeu9g/ESD0WT6VLm1
	 //RSrJ2fcJXROmBje6cuMVZQ85/y+uAjr9RyFO6foluu8DJ2OnWhA3/suepo7yDaoy
	 wQIsKgSmTVMzQ==
Date: Tue, 18 Nov 2025 16:53:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jordan Rife <jordan@jrife.io>
Subject: Re: [PATCH net-next v3 07/11] uapi: wireguard: generate header with
 ynl-gen
Message-ID: <20251118165315.281a21ca@kernel.org>
In-Reply-To: <aRyOAYuWZE440WQ4@zx2c4.com>
References: <20251105183223.89913-1-ast@fiberby.net>
	<20251105183223.89913-8-ast@fiberby.net>
	<aRyOAYuWZE440WQ4@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Nov 2025 16:17:21 +0100 Jason A. Donenfeld wrote:
> On Wed, Nov 05, 2025 at 06:32:16PM +0000, Asbj=C3=B8rn Sloth T=C3=B8nnese=
n wrote:
> > Use ynl-gen to generate the UAPI header for wireguard.
> > diff --git a/include/uapi/linux/wireguard.h b/include/uapi/linux/wiregu=
ard.h
> > index a2815f4f2910..dc3924d0c552 100644
> > --- a/include/uapi/linux/wireguard.h
> > +++ b/include/uapi/linux/wireguard.h
> > @@ -1,32 +1,28 @@
> > -/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT */
> > -/*
> > - * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All R=
ights Reserved.
> > - */
> > +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-=
3-Clause) */
> > +/* Do not edit directly, auto-generated from: */
> > +/*	Documentation/netlink/specs/wireguard.yaml */
> > +/* YNL-GEN uapi header */ =20
>=20
> Same desire here -- can this get auto generated at compile time (or in
> headers_install time).

IMHO generating uAPI on the fly has more downsides than benefits.
For one thing people grepping the code and looking and lxr will
never find the definition. All the user space code in tools/ is
generated at build time, but the amount of kernel code we generate
is not significant at this stage. Not significant enough to complicate
everyone's life..

