Return-Path: <netdev+bounces-180078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42994A7F761
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DA2179C5A
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 08:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91762641F5;
	Tue,  8 Apr 2025 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qzp9zD1f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45DD2641CB
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744099908; cv=none; b=DzBF+87HgZYdlg3t9mGxMaboQAG5YId4Pjr5vhSszykkH3bkXnDtITrjRL46dh35cxinvXCMFC2H3jrxGNlJY/h+Pp4+4O/9Om7W5WnBtnRLPQFaFzLkSEt5NMP5Z+biMs+VFj58FdUxXkIa42uh7H/QmTWdyDU1PocxHZ9I+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744099908; c=relaxed/simple;
	bh=sdci4lJsO/FOikKIVq4yCkhQfnhsn9Us40sQtnVw+Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4SQYaJ+bUPDOybj+ToVkd5bo9vKC5YQLTfrfUWsHiASGZJ/PcKXCF75rFKyY8alSqUlrXHUqXol0BtT6YzY+MtXeMysnftkdxvnU7WlXg4ypZ9Ka8z3IKktbZrLIb8z8yzQ/zLxJSQYGTwJvje7Vds76r9S4a7oO8v9oEeiR1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qzp9zD1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2C7C4CEE9;
	Tue,  8 Apr 2025 08:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744099908;
	bh=sdci4lJsO/FOikKIVq4yCkhQfnhsn9Us40sQtnVw+Xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qzp9zD1fw7vRDLwtT0qI/gIR/GHnf3Qv752bVzjp7b5VGG06sX7xDK5fp961WVTEf
	 WPEAfUv/c2tzI+IBLGZ+y1Rx/KE1w9Q7Yf/tHlA3lLIe5QufpOu0k3puZt4WL4a5Is
	 VrpCeIsEhZrQ4QP1zM3Xn3XrPRmsgXFEfDQE+Qo1PAvmatJiHf3B/XPntRYegpfMYr
	 r8E9sOE+bqEf+25D9ZvKx626KgpcFQnDkzCvTVZVzat7FuIBUxJDU6QKvFIrMuhodP
	 ntQLt9UlAtCulJpHCkWXZy7RvYHOPdM/BZVkbc/fUibXacHQVeleZ7US4z/TeZ7cio
	 XP3uLDDN3mb8g==
Date: Tue, 8 Apr 2025 10:11:45 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Add matchall filter offload support
Message-ID: <Z_TaQbEeTZnKL9ei@lore-desk>
References: <20250407-airoha-hw-rx-ratelimit-v1-1-917d092d56fd@kernel.org>
 <CAKa-r6tNa+Ltxb61g6E3h66pxW0XTDb76T6Wc2XMJCu8xuAvPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cf4oqZqIraZr0Mc3"
Content-Disposition: inline
In-Reply-To: <CAKa-r6tNa+Ltxb61g6E3h66pxW0XTDb76T6Wc2XMJCu8xuAvPg@mail.gmail.com>


--cf4oqZqIraZr0Mc3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> hello Lorenzo, thanks for this patch!

Hi Davide,

thx for the review.

>=20
> On Mon, Apr 7, 2025 at 10:04=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.=
org> wrote:
> >
> > Introduce tc matchall filter offload support in airoha_eth driver.
> > Matchall hw filter is used to implement hw rate policing via tc action
> > police:
> >
> > $tc qdisc add dev eth0 handle ffff: ingress
> > $tc filter add dev eth0 parent ffff: matchall action police \
> >  rate 100mbit burst 1000k drop
> >
> > Curennet implementation supports just drop/accept as exceed/notexceed
> > actions. Moreover, rate and burst are the only supported configuration
> > parameters.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> [...]
>=20
> > +
> > +       if (act->police.peakrate_bytes_ps || act->police.avrate ||
> > +           act->police.overhead) {
> > +               NL_SET_ERR_MSG_MOD(f->common.extack,
> > +                                  "peakrate/avrate/overhead not suppor=
ted");
> > +               return -EOPNOTSUPP;
> > +       }
>=20
> I think the driver should also validate the so-called "mtu policing"
> parameter. E.g, configuring it in the hardware if it has non-zero
> value in act->police, or alternatively reject offloading of police
> rules where act->police.mtu is non-zero (like done in the hunk above).
> WDYT?

ack, right, I missed it. I will add it in v2.

Regards,
Lorenzo

> --=20
> davide
>=20

--cf4oqZqIraZr0Mc3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ/TaQQAKCRA6cBh0uS2t
rO5FAP9IPAyg0FFzsbCQb+ZqLZXr+62jP0nLzaeO/Mklx3HefwEAloAoGjXka5kn
3FvimlCwCpSabbKDUFgb6Nl9SpTVnQk=
=NtS5
-----END PGP SIGNATURE-----

--cf4oqZqIraZr0Mc3--

