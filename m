Return-Path: <netdev+bounces-228183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D04BC3EFC
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 10:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8D93ADE5C
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 08:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9666E2F361E;
	Wed,  8 Oct 2025 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3oyHJ7+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714EE2E22B4
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913511; cv=none; b=j2pGGiD2tHP6zbKVFtVO8cqoFg7bETnR2+TzutvbrDTTMV9DFYthDPDKJXn+LpkwVrB4tTgLjobQ/DFrlAwxtbiSw/4V+OLhtVvzZ9bYwGzAHC5J0JzV2nVvwz2vLAp8Cu+TWAmlTj3n9imLRKSLeq4qhtjaXlsreFxKB5wHmBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913511; c=relaxed/simple;
	bh=61um9Z5Z7w5C/Y58XBFy7nF1UiQ4Fnu9RxUx6QSY6KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT/LG/uJVb6isFmawywUuc5SJynKnw5voN4LfLD3wiVTTFvAGu8hjoPHhLDryTEW6TQfh0wE0zK2jizCNHpQBJelCwpkf3TGiVzJXHhQ80a7DXSzXbcKGrHyPctfYm5PQFm89yF628pg1Ct8zIgLoYITcWzttIVMi72ED+nL+vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3oyHJ7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF27C4CEF4;
	Wed,  8 Oct 2025 08:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759913511;
	bh=61um9Z5Z7w5C/Y58XBFy7nF1UiQ4Fnu9RxUx6QSY6KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b3oyHJ7+KXvjNYGV5Fw5uVcZFR4+Dfis8w+SPAoiZeuT8CCSZL72C2ZNT3XnM4X8l
	 bMhevnQ5KyKzsRfHNt71zpptisC15rsjIIVAi44gIS8E+I0zCDW0F5QQp7+YRDPe7P
	 3p/GVPIThd97flfhMDWetR/RZPXHyyH8WnYDZLNSTrr1t3q30iQ7Uc9C+OJ3Ht4ceR
	 oUnpFEg+pPQukM9ywLeLLtY8oFRmhyYSCRrSpBgapEjIH4KoxfdmTGYRM+aW5WIlvP
	 mtT6GEgD+CPMnSYQcM8WC2uX3nk8dTLheOOCm76VDI0mG2CzeRolDurjExgVeIc+SW
	 S6LVF3V3wA1jg==
Date: Wed, 8 Oct 2025 10:51:48 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Fix loopback mode configuration for
 GDM2 port
Message-ID: <aOYmJC1-mn22ehRG@lore-desk>
References: <20251005-airoha-loopback-mode-fix-v1-1-d017f78acf76@kernel.org>
 <7b460ea8-c340-4ab8-96d9-43568227ee07@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F73I8gfksC2p3ILC"
Content-Disposition: inline
In-Reply-To: <7b460ea8-c340-4ab8-96d9-43568227ee07@redhat.com>


--F73I8gfksC2p3ILC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 07, Paolo Abeni wrote:
> On 10/5/25 4:52 PM, Lorenzo Bianconi wrote:
> > Add missing configuration for loopback mode in airhoha_set_gdm2_loopback
> > routine.
> >=20
> > Fixes: 9cd451d414f6e ("net: airoha: Add loopback support for GDM2")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/ethernet/airoha/airoha_eth.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 81ea01a652b9c545c348ad6390af8be873a4997f..abe7a23e3ab7a189a3a2800=
7004572719307de90 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -1710,7 +1710,9 @@ static void airhoha_set_gdm2_loopback(struct airo=
ha_gdm_port *port)
> >  	airoha_fe_wr(eth, REG_GDM_RXCHN_EN(2), 0xffff);
> >  	airoha_fe_rmw(eth, REG_GDM_LPBK_CFG(2),
> >  		      LPBK_CHAN_MASK | LPBK_MODE_MASK | LPBK_EN_MASK,
> > -		      FIELD_PREP(LPBK_CHAN_MASK, chan) | LPBK_EN_MASK);
> > +		      FIELD_PREP(LPBK_CHAN_MASK, chan) |
> > +		      FIELD_PREP(LPBK_MODE_MASK, 7) |
>=20
> I suggest introducing some human readable macro to replace the above
> magic number.

ack, I will do in v2.

Regards,
Lorenzo

>=20
> Thanks,
>=20
> Paolo
>=20

--F73I8gfksC2p3ILC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaOYmJAAKCRA6cBh0uS2t
rLIaAP9ZpLaeZx/xuXWhNczt2hljchjtx1rGalRK9vfN4hRXaAEAwAG7dafqK7nA
xqMvinYWqO1bJ84j20g9/PDkDWmpGg8=
=3Lie
-----END PGP SIGNATURE-----

--F73I8gfksC2p3ILC--

