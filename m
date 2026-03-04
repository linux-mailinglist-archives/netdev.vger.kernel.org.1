Return-Path: <netdev+bounces-263650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNJpJFjtp2mWlwAAu9opvQ
	(envelope-from <netdev+bounces-263650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:29:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 183511FC9D8
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0DE530045B0
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 08:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774AB38E13F;
	Wed,  4 Mar 2026 08:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFXE641t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54415384224
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 08:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772612948; cv=none; b=kkUIz2CHaicNvftw/Qavfn/mwUMkhGylMdoRqJfM+t6g6w8GmCNyIG6h4H9KDSxPiCJFzenPZ67NrZzShvy2EykJMXM8ghfgmV/boXiMAD568tiOKwmcAMYZqfTWis+DNNH7immnU+PzlL+ioYBq4Q9oZgCcPtSNS3GkzzfGrKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772612948; c=relaxed/simple;
	bh=4Ac7+YMVNcgLTiWD3JC9geCCgf05rClB8IFh32bwZDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbHWXzxbAYCeaL5YrrxSQgJ2bsdHQeYxP7UrtnO1vghEwWW9cPFDmY3pL8zC54KkrOUn+ckqP4bM7UJBdMqljZc39WiMP+LutEXOSIHLOFGQr3w9zfiawtHbubMNkIDCAHEJvTPAghPSz5L1nkrPT54g71XS+Iggrs8zXkelFoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFXE641t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758C3C19423;
	Wed,  4 Mar 2026 08:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772612947;
	bh=4Ac7+YMVNcgLTiWD3JC9geCCgf05rClB8IFh32bwZDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kFXE641tTVclA+hL8OI6wWJfFCJHGWpuCPSFOTQ4OU5zgwI9haWAhiXzFbtrDXbmv
	 iq8gDAtsjZRVJ+aLRPRrG/16cW1eZQrsktx/tyCfWce/C2Ac5Jm2Y65fXpxQIZyK9W
	 T4f8JBOskKaPW3FXefOzjJ8JcCKvXWnUvpTEUjj1Oir16ucy/wiwK6Iex7XT4QKbd5
	 mpDwFkbednxLhp/y1mJWOMoVYUorMDbZOO9O4we4n6svR53+1P8yomzJsG/gS1ztLF
	 BNVuO3k3NgAx6E1G7SdZxH8lC8DO8DHckr5u3SC+IyZuPZnycmn7kzRz2ljeEg+NYO
	 Z7Yu9WLXuTv4w==
Date: Wed, 4 Mar 2026 09:29:05 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Fix GDM2 loopback configuration
 for USB serdes
Message-ID: <aaftUXaSD0u5ZhO7@lore-desk>
References: <20260228-airoha-fix-loopback-for-usb-serdes-v1-1-a94be0f897da@kernel.org>
 <20260303141624.GD71509@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F9TiRjTzjJbtqhOj"
Content-Disposition: inline
In-Reply-To: <20260303141624.GD71509@kernel.org>
X-Rspamd-Queue-Id: 183511FC9D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263650-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


--F9TiRjTzjJbtqhOj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, Feb 28, 2026 at 01:20:33PM +0100, Lorenzo Bianconi wrote:
> > Flow Control source port mapping for USB serdes needs to be configured
> > according to the GDM port nbd parameter. This is a preliminary patch
> > since nbd parameter is specific for the given port serdes and needs to
> > be read from the DTS (in the current codebase is assigned statically).
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Hi Lorenzo,
>=20
> Is this a fix? If so, should it have a fixes tag? And be targeted at net?
> Otherwise, perhaps drop the "Fix" from the subject.

Hi Simon,

This is a preliminary patch in order to completely fix the loopback
configuration for USB serdes but the point is we are not supporting
USB serdes upstream yet (there is only OpenWrt support available at
the moment). Do you think we should target net-next or net in this
case?

>=20
> Also, I think it would be worth explaining the situation
> before and after this patch.
>=20
> > ---
> >  drivers/net/ethernet/airoha/airoha_eth.c  | 10 ++++++----
> >  drivers/net/ethernet/airoha/airoha_regs.h |  5 +----
> >  2 files changed, 7 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 3779f93b47bc13ae21d4ae088dece4712dc214e5..37fc2b33d3af8a190a74efc=
69ed54f163afa6412 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -1729,10 +1729,12 @@ static int airhoha_set_gdm2_loopback(struct air=
oha_gdm_port *port)
> >  		      SP_CPORT_MASK(val),
> >  		      FE_PSE_PORT_CDM2 << __ffs(SP_CPORT_MASK(val)));
> > =20
> > -	if (port->id !=3D AIROHA_GDM3_IDX && airoha_is_7581(eth))
> > -		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6,
> > -			      FC_ID_OF_SRC_PORT24_MASK,
> > -			      FIELD_PREP(FC_ID_OF_SRC_PORT24_MASK, 2));
> > +	if (port->id =3D=3D AIROHA_GDM4_IDX && airoha_is_7581(eth)) {
> > +		u32 mask =3D FC_ID_OF_SRC_PORT_MASK(nbq);
>=20
> AI generated code review flags that the commit message talks about nbd.
> But here we have nbq.

yes, my mistake. It is supposed to be nbq and not nbd.

>=20
> > +
> > +		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6, mask,
> > +			      AIROHA_GDM2_IDX << __ffs(mask));
>=20
> Perhaps na=EFvely I would have used FIELD_PREP here.
> Maybe that leads to an incorrect result. But if not,
> is a shift used here for consistency with the code at
> the beginning of this hunk?

ack, I think we can FIELD_PREP() now. In the past we can't use FIELD_PREP()
with non-compile constant mask, but now it is doable.

Regards,
Lorenzo

>=20
> > +	}
> > =20
> >  	return 0;
> >  }
>=20
> ...

--F9TiRjTzjJbtqhOj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaaftUQAKCRA6cBh0uS2t
rK2AAP41fbpezZsic6pgjkdkADETszHQezTZrkrIfzqb/JPZoQEAsrucGpLcN550
Cmok4JfK/ZxGWXhXITNH04hYiVkgNg0=
=HuOh
-----END PGP SIGNATURE-----

--F9TiRjTzjJbtqhOj--

