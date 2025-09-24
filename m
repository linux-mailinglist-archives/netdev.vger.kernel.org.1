Return-Path: <netdev+bounces-226125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7374B9CABD
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A429B3A5FA7
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 23:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E136283FE9;
	Wed, 24 Sep 2025 23:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cA0e6Eoa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BA763CB
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757243; cv=none; b=l6MMrvhkQpdaD+R1SRPtSfpdPaPf4uxhixk+SAp/ID+pKWZgPuVhtwdjxK15sLtg//2NhixV/KkitY6Thn/lSRCdcbxKP5tmnCrw0GBke+PU61staM79+rvHQH3tT7fXEkhqoOLrCxCIu5++8ixmR2WHQgh+4c8PruAvsE38YHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757243; c=relaxed/simple;
	bh=MZiAY1G9URGZ+FV5XwIuXmUKR+Uwo4DY8qBrtVJMlDw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yp1s4Cth7zM+0X9R9ygOxtfJA2s4kF+FW4eozar+3eo5K2zX+/4rDVt6hU0Pgn2cPOatXojszSM15aO07OENySSydui/9NDkAXUT++Nzxq+JKksiEOiiHMlC7R1Gpo+fH0O9pxIgvWHFhouzGZCMN5jRonKI1uSMc1arKCtvcQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cA0e6Eoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8F2C4CEE7;
	Wed, 24 Sep 2025 23:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758757242;
	bh=MZiAY1G9URGZ+FV5XwIuXmUKR+Uwo4DY8qBrtVJMlDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cA0e6EoaSaTjYAgDWp3yQwcyFL3Qq7lYpQqPBbJj2vTqPVm3gOeLEANtZTig8jzo+
	 tjDIhgA4oTpcjdzVQX5vE5saev45x8/MrkHuSOx9iK+wua9rZu7sZN6ycMmz6BCOvy
	 iWEF58BxFfgPOWHHy3cXmNg/9+is9GqdxoLssL8q8jYdc/YEUWaZQOOOFXrOZLHxnB
	 3e+Wy6Oczrl0TsxsEspa3hec47d7mNlhCm+9WS1yvhxAT7y8uX+gNK9jjUHFIj83N5
	 KiuBf/2Ab23NPNif1TpaoJQImknb5OYyMpjF5h3hhGdOkAS2zbVDanUfnQSU/kLfNQ
	 rYgv1qeevbMHQ==
Date: Wed, 24 Sep 2025 16:40:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?SsOhbiBWw6FjbGF2?= <jvaclav@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net/hsr: add protocol version to fill_info
 output
Message-ID: <20250924164041.3f938cab@kernel.org>
In-Reply-To: <CAEQfnk3Ft4ke3UXS60WMYH8M6WsLgH=D=7zXmkcr3tx0cdiR_g@mail.gmail.com>
References: <20250922093743.1347351-3-jvaclav@redhat.com>
	<20250923170604.6c629d90@kernel.org>
	<CAEQfnk3Ft4ke3UXS60WMYH8M6WsLgH=D=7zXmkcr3tx0cdiR_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Sep 2025 13:21:32 +0200 J=C3=A1n V=C3=A1clav wrote:
> On Wed, Sep 24, 2025 at 2:06=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Mon, 22 Sep 2025 11:37:45 +0200 Jan Vaclav wrote: =20
> > >       if (hsr->prot_version =3D=3D PRP_V1)
> > >               proto =3D HSR_PROTOCOL_PRP;
> > > +     if (nla_put_u8(skb, IFLA_HSR_VERSION, hsr->prot_version))
> > > +             goto nla_put_failure; =20
> >
> > Looks like configuration path does not allow setting version if proto
> > is PRP. Should we add an else before the if? since previous if is
> > checking for PRP already
> > =20
>=20
> The way HSR configuration is currently handled seems very confusing to
> me, because it allows setting the protocol version, but for PRP_V1
> only as a byproduct of setting the protocol to PRP. If you configure
> an interface with (proto =3D PRP, version =3D PRP_V1), it will fail, which
> seems wrong to me, considering this is the end result of configuring
> only with proto =3D PRP anyways.

I'm not very familiar with HSR or PRP. But The PRP_V1 which has value
of 3 looks like a kernel-internal hack. Or does the protocol actually
specify value 3 to mean PRP?

I don't think there's anything particularly wrong with the code.
The version is for HSR because PRP only has one version, there's no
ambiguity.

But again, I'm just glancing at the code I could be wrong..

