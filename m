Return-Path: <netdev+bounces-251292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F83D3B83C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B3293004E1B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D762E5B05;
	Mon, 19 Jan 2026 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1eDddWd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96122DA768
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854409; cv=none; b=FvES+W+vNdwOFPQm4i8/9Faq/Gr3F/gFlnI8ODlDM4AuNgWhbYpNxfzcVRl1BBvYRVRn1Z+RPAV0l3AQDML0bLUC1aEJ+oOGOUxvcSlLgLwGoYXSvFq9sXwnR+qiWNe/qmxiitICR7WhNicw4G0KXQRgkouTAXU9rfvTFyiPD0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854409; c=relaxed/simple;
	bh=N/LX3GsJmHUlHzbIr3xIIXbxXhRXrB42a6UDdCEAwt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APjOdJNnYRG9Ou2k3VjYZWDEy2dz8pjvbVD/G54Z+4g5BFVp9gd+qmK031umOiyDVgLJRe32gztKkJdHNrpTV7JVh115IR4t/znaL/q5HQdEs7mS8p66e8fTjQWLbykIGFjLW+Xqk2opaqou3+93SxJ+fCd7gIuzhEiwVlU8bBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1eDddWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FF7C2BC87
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 20:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768854408;
	bh=N/LX3GsJmHUlHzbIr3xIIXbxXhRXrB42a6UDdCEAwt8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X1eDddWdJdlJo9+1szofGfPdYTvFFC8yIy7R6aXDXqvMLGprhj/zH7Vnp7zo2WUH2
	 mnphPPDu8UgB+c0qPzmU8WhJGoXwP8XF4hZuYLFe9sZOZZtCGOpBUB69YaU9hNHMzu
	 VXNZ/UTuiL1W5SzmiazKzzocwLIf+1gf9kcKFvW2hZRX3g7aRVNsGs1WhCKg5qQtky
	 HH5J/wD28Iu4O2FijQCLkxmUSut0qBBBh4CjaCq27CYlpogi89ymHtYDu4Nb+w1PZZ
	 RjPjemXiLnulG9zd/P5FI8YJvJEwz3oislHjZDAUdTGuGfpHx+Q9dojBPnxPnYKwJ5
	 bZGe1YIjMuZLQ==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-790992528f6so40671607b3.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 12:26:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYV8/vr0VxLjUtUZGIv0q4C3S0WlipkxarAD7b/Vd3TB4Os+K3Xxdx2ivso0SjjX0piP1CDzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGQEsUe3C7J0hj88seUSNgUUk2PVNDkCVeIdY4AINIPPmPJ8ah
	DZ9Xlyi6i77AldzHlFCJaobKdkPj1IlX9pEXgCbwzYHkjdpD40r5UB70TcbTaN2Eh3lBk87D93a
	T3Lo1tXr5bgzcUXmom5HElIqBvHJCorY=
X-Received: by 2002:a05:690c:6606:b0:78d:68df:81a7 with SMTP id
 00721157ae682-793c522d712mr100362567b3.10.1768854407788; Mon, 19 Jan 2026
 12:26:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-ks8995-fixups-v2-0-98bd034a0d12@kernel.org>
 <20260119-ks8995-fixups-v2-1-98bd034a0d12@kernel.org> <20260119153850.r7m7qf7wsb6lvwwe@skbuf>
 <20260119083341.148109c2@kernel.org>
In-Reply-To: <20260119083341.148109c2@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 19 Jan 2026 21:26:36 +0100
X-Gmail-Original-Message-ID: <CAD++jLkcB12YT+bLe6G0OvC3zrc=sKJYVAYR-m=6-bv+c_+8Hw@mail.gmail.com>
X-Gm-Features: AZwV_QjzP1oXhXmkPArBfOI3DhvFKwh1cCldRC9yvNnL7-f7pRKs--l1EYkkKS4
Message-ID: <CAD++jLkcB12YT+bLe6G0OvC3zrc=sKJYVAYR-m=6-bv+c_+8Hw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/4] net: dsa: ks8995: Add shutdown callback
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>, 
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 5:33=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> On Mon, 19 Jan 2026 17:38:50 +0200 Vladimir Oltean wrote:
> > On Mon, Jan 19, 2026 at 03:30:05PM +0100, Linus Walleij wrote:
> > > The DSA framework requires that dsa_switch_shutdown() be
> > > called when the driver is shut down.
> > >
> > > Fixes: a7fe8b266f65 ("net: dsa: ks8995: Add basic switch set-up")
> >
> > $ git tag --contains a7fe8b266f65
> > v6.18
> >
> > We are in the RC stage for v6.19, so this is 'net' material, not
> > 'net-next', the patch has already made it into a released kernel.
>
> The AI code review points out that the DSA docs/you suggest mutual
> exclusion with .remove. Do we also want this to be addressed?

That's pretty impressive. I need to learn how to
use this approach for my subsystems.

(Also fixing my patches.)

Yours,
Linus Walleij

